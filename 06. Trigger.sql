CREATE TRIGGER tr_UserGameItems_LevelRestriction ON UserGameItems
INSTEAD OF UPDATE
AS BEGIN
         IF(
             (
               SELECT Level
               FROM UsersGames
               WHERE Id =
                  (
                   SELECT UserGameId
                   FROM inserted
                 )
              ) <
           (
               SELECT MinLevel
               FROM Items
               WHERE Id =
               (
                   SELECT ItemId
                   FROM inserted
               )
           ) )
BEGIN RAISERROR('Your current level is not enough', 16, 1);
END;

INSERT INTO UserGameItems
 VALUES
        (
        (
            SELECT ItemId
            FROM inserted
        ),
        (
            SELECT UserGameId
            FROM inserted
         )
         );
     END;
	 
UPDATE ug
SET ug.Cash+=50000
FROM UsersGames AS ug
JOIN Users AS u ON u.Id = ug.UserId
JOIN Games AS g ON g.Id = ug.GameId
WHERE u.FirstName IN('baleremuda', 'loosenoise', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
AND g.Name = 'Bali';