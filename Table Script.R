# Libraries 
library(readxl)
library(reactablefmtr)
library(reactable)
library(scales)
library(tidyverse)

# Data
senator_data <- read_excel("Senator NRA.xlsx")
names(senator_data) <- c("Senator", "State", "Funding", "Gun_Deaths", "NRA_Rating", "Comments")

# Creating the Table
table <- senator_data %>%
  reactable(
    defaultColDef = colDef(
      align = "center",
    ),
    columns = list(
      Funding = colDef(
        name = "Funding from the NRA",
        cell = color_tiles(., 
                           number_fmt = scales::dollar,
                           colors = c("#ffffff", "#ff99af" ,"#ff3360", "#cc002d", "#660016"),
                           box_shadow = TRUE,
                           bias = 3)
        ),
      Gun_Deaths = colDef(
        name = "Gun Deaths in Home State",
        cell = color_tiles(.,
                           colors = c("#ff99af" ,"#ff3360", "#cc002d", "#660016"), # No 0 value, so no need for the white color
                           box_shadow = TRUE)
        ),
      NRA_Rating = colDef(
        name = "NRA Rating",
        minWidth = 50
        ),
      State = colDef(
        name = "State",
        minWidth = 50
        ),
      Comments = colDef(
        name = "Comments on Policies After Uvalde Shooting",
        minWidth = 200
        )),
    searchable = TRUE,
    defaultPageSize = 50, striped = TRUE, highlight = TRUE) %>%
  add_title("Career NRA Donations to Senators") %>%
  add_subtitle("Data from the New York Times and the Gun Violence Archive", font_size = 16)

# Saving It
save_reactable_test(table, "senator_nra.html")
