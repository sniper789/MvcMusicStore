-- AspNetUsers
CREATE TABLE [dbo].[ApplicationUsers] (
    [Id]                   INT            IDENTITY (1, 1) NOT NULL,
    [Email]                NVARCHAR (256) NULL,
    [EmailConfirmed]       BIT            NOT NULL,
    [PasswordHash]         NVARCHAR (MAX) NULL,
    [SecurityStamp]        NVARCHAR (MAX) NULL,
    [PhoneNumber]          NVARCHAR (MAX) NULL,
    [PhoneNumberConfirmed] BIT            NOT NULL,
    [TwoFactorEnabled]     BIT            NOT NULL,
    [LockoutEndDateUtc]    DATETIME       NULL,
    [LockoutEnabled]       BIT            NOT NULL,
    [AccessFailedCount]    INT            NOT NULL,
    [UserName]             NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_dbo.ApplicationUsers] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [UQ_ApplicationUsers_Email] UNIQUE NONCLUSTERED ([Email] ASC),
    CONSTRAINT [UQ_ApplicationUsers_UserName] UNIQUE NONCLUSTERED ([UserName] ASC)
);

-- AspNetRoles
CREATE TABLE [dbo].[ApplicationRoles] (
    [Id]   INT            IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_dbo.ApplicationRoles] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex]
    ON [dbo].[ApplicationUsers]([UserName] ASC);

GO
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex]
    ON [dbo].[ApplicationRoles]([Name] ASC);

--	AspNetUserRoles
CREATE TABLE [dbo].[ApplicationUserRoles] (
    [UserId] INT NOT NULL,
    [RoleId] INT NOT NULL,
    CONSTRAINT [PK_dbo.ApplicationUserRoles] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC),
    CONSTRAINT [FK_dbo.ApplicationUserRoles_dbo.ApplicationRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[ApplicationRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_dbo.ApplicationUserRoles_dbo.ApplicationUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[ApplicationUsers] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[ApplicationUserRoles]([UserId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RoleId]
    ON [dbo].[ApplicationUserRoles]([RoleId] ASC);

-- AspNetUserLogins
CREATE TABLE [dbo].[ApplicationUserLogins] (
    [LoginProvider] NVARCHAR (128) NOT NULL,
    [ProviderKey]   NVARCHAR (128) NOT NULL,
    [UserId]        INT NOT NULL,
    CONSTRAINT [PK_dbo.ApplicationUserLogins] PRIMARY KEY CLUSTERED ([LoginProvider] ASC, [ProviderKey] ASC, [UserId] ASC),
    CONSTRAINT [FK_dbo.ApplicationUserLogins_dbo.ApplicationUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[ApplicationUsers] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[ApplicationUserLogins]([UserId] ASC);

-- AspNetUserClaims
CREATE TABLE [dbo].[ApplicationUserClaims] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [UserId]     INT NOT NULL,
    [ClaimType]  NVARCHAR (MAX) NULL,
    [ClaimValue] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.ApplicationUserClaims] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.ApplicationUserClaims_dbo.ApplicationUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[ApplicationUsers] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[ApplicationUserClaims]([UserId] ASC);

