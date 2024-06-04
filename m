Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3AF135A6F
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529413; cv=fail; b=L6NIQRaXa3Ndb8QDKWG9xppJBN035r8M1igOgG9X6uCHgh/8g2YWBpwUP/W498YYzmvYTWfmDJ1ASqAbM2hlarbrZ80BqaYyh4u2WEccRB4SpV+FeTYTJvNA3Rt8ADlcoONLUnEQtoxDrV+KfZU6ItikbX4Thx59i4EJXwq/mzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529413; c=relaxed/simple;
	bh=+vd84smvmX2YOciNyM7iCgHjJM6T9iibpxmsaKE0TOE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fLiZLfRUujw+lpm1R3rmgJeRVMWjaYrC86ByOIZ45ul3nSUU0Uscaq8LLs+gvZEDIUHETXY1qqoqqf7cbOjsbNyBhbLSrMfpPP7P3qxPwJ6wLcqkJZgfuNW/UQnjqpJD5CfpRkKJss099DwlZZZqMvyElKKlIJLS+s1a3pfQu+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GynA7Vaz; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GynA7Vaz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8p3kNRVo0kYTwvgqLM4fzxkz1+c59IOz/qSJjkCM+I4AUNTSAFCbmqPRoLwzCbqKuZx+V5AZAgGjZcUJkYA19SNOB21lkm9zefzQ+bx5MecsLjH1FhxUS+6+SDd+jIctBM0QIS11XyOepvgvdHJVYAj9xqtdzWb0cWX2RI7Mb3LRErZ9Ws9KI17oaQeyRYcd/ft3LLkq5nq3baUF4ahYu954+h+8RoMoNzuz3+c3f/IfTpT2OrBmnGFeODw1/AkXiAKv7CFGNfeUzyS58MyXyZJmwBhE31KIHut+IGcQk+eNj5/48a0qBkuTFfMFcrgmjEk/W8RbPqBBQtOIDq3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbXXN9KcwSL+meS1G+2sRn/wt+ulmq9Xc6TfUPtUEGk=;
 b=d+D9Pk5D1G943HdG9xURTFWM0+/v2xhIqbfEjwKqclCH+NtZ3ty9sf0p+DKREdr6w4IUbdaaE6qDNSXQJJCNqxylD3Dm1oMjzT5HDMmyETtQPTEiV8nszk3SAaQXJuuTMEV84v4iv0CwVAVTGAQZ2/LQSML3lD4pCZ5JBWNbOt4V2I0/JCGa0bRdl5p0Q7PKdT1g0Zzj54DsyGdP7CUuIt0OhsVF+RwogHmsi5BxWcCUJFb1wEVq3AjQ5qTIqlronw/x6Vi67nvP9IcbMMYWN9yPQtpm17g7fwQtpcjw1MxwaxTub7kqJO2SxPYJZ54OOAVf3XZjaELGIrWhv46HdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbXXN9KcwSL+meS1G+2sRn/wt+ulmq9Xc6TfUPtUEGk=;
 b=GynA7Vaz+hy/E64q419Nb4UjwNmC0lskzkYEq4FlnPqWXpG5brUQNCDzeBTc+l7OfiK4N9Ltszbn2o1AtagpYJsdnNl7IOz3FUH1n5VcL/rpeMrC5Bphvq0lTnEDg6JUThlOwtjoRZFsWh6Sdw5tkexuAfVi5zWkyBuQFdQ35jdMlDTsoYh1ZnG8sDij/z45DxvhTXcBnnxHd+YZK9CievfYZe5R31IRCYCAMy85meIw24ruW7WhtUoPhY+kukhv9yk2Pqs9z5OkGaIF78atcmRAbgOkwSlX25xU6xwB7K6FLDCtXQ+N4yrATRPXS6dBurOvFPe4Qq130/wMhunbrQ==
Received: from BYAPR06CA0047.namprd06.prod.outlook.com (2603:10b6:a03:14b::24)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 19:30:07 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::29) by BYAPR06CA0047.outlook.office365.com
 (2603:10b6:a03:14b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Tue, 4 Jun 2024 19:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 19:30:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Jun 2024
 12:29:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Jun 2024
 12:29:49 -0700
Received: from treble.com (10.127.8.10) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 4 Jun 2024
 12:29:49 -0700
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] credential: clear expired c->credential, unify secret clearing
Date: Tue, 4 Jun 2024 12:29:28 -0700
Message-ID: <20240604192929.3252626-1-aplattner@nvidia.com>
X-Mailer: git-send-email 2.45.2.410.gc00f1d8d6b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 795e639d-9986-4fc8-da2c-08dc84ccbde9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nK9YiDJc8NcWUfR1dqE/tiSHzGIhruC4AfjSzTcp/s3W983dnQ7S+R0L9ywz?=
 =?us-ascii?Q?jHtgrC2BiAufuxUyNqLTrzEvvESc56EfeZ0cMEyxRZyoV97qBU8G8wrnu9On?=
 =?us-ascii?Q?1mnE5ROsv8B3U3Eq/LJl6TUm4NZC4nWqBIK36iHO0b+Bk2/DuB+t9shEj3hU?=
 =?us-ascii?Q?UtwNPe5JMS11/LLte1tc9pj4S0SnexCqagLi0hFoakdH/3hr+8uW4wa3MAAl?=
 =?us-ascii?Q?E2gaPDm0WrNcPlKZA5tliUgxtjlUNgCy8vpmStefWVysFFDLIW7ledAYawwf?=
 =?us-ascii?Q?KCIHI6yv7nh25u214LdaCStbO2m9l1TgTAox/FhrqOcKjEWYL2kF3hTsGbw1?=
 =?us-ascii?Q?SOb3DmQsv4KxgxzEKjjgkefdqD4rtC5G7RRdeNrYIWa9ivbZkZVgE/r6hFFa?=
 =?us-ascii?Q?jpNMBrF/AdWXHP4TmYWi3dwcXdZAOzBPkezQzvej3xI0xAjLBkqgzkXHxu91?=
 =?us-ascii?Q?uiEW+v+y82pwyJEHFaNK+5RZsxq3n7CvJsNqkv5d69D+kfPQzpz6Nl4pZt5y?=
 =?us-ascii?Q?IgmyOa3TpsdJJlAVcvQmCHkx09xooFddtXSYFZv4znnOwoFXRLeTRMVlTRRn?=
 =?us-ascii?Q?IB4Sk1L0Oy1sW6yMJTrdlZyEfJL+ZjuIlzf0wurheLBMgWZ/+F86B7amKcnb?=
 =?us-ascii?Q?EjnpElBr7JdQ7QhLE/I9ygMZP4LiNRR2FKLQiNS2gBXhtjFWbL+qRWg4vFMu?=
 =?us-ascii?Q?SQXipbzc2U6p3epSYoyRFO1fwg1qOUWXfpk9nSX1g5OvCmDruC+QqrhppcId?=
 =?us-ascii?Q?UFtPuk0NYlt1TWrZYelMJyhVAZWFWDj+paPjZUUCqODvyUyLY5FqaLnThDMb?=
 =?us-ascii?Q?fG/i+Ihdmhob4BL3t78Gi+wj32qwk99TpHf2Z0dIn7PcN+zS1TXIypD2Qa7R?=
 =?us-ascii?Q?sJDENTC3YYRm0kIzKdGyO89KieMiZYDTNyT/PIkXT5SKh5J2Jh8zsrSu3f6s?=
 =?us-ascii?Q?lyIqpWfh/Pyz4Q5cVR1jFkpHmIdspgQ9sGKmKDpwirM3UNsUg4bhBFX3mYmT?=
 =?us-ascii?Q?vCNu5LEGxtIEC7Q1qJLSurnxxHyYKFWAwx06Q63eCWbiwzvbHjneyYAxqqiD?=
 =?us-ascii?Q?sRSu3IEr6qjQmAe7zghWcogdnY9dgvoObMcIDl+YxeK0miW5Dd1lmWjdcDjr?=
 =?us-ascii?Q?JutSckJGKAWFVe9i+GFLTpNgERgmdkXj2U8ej11cDcE4Ki6PGu2fXRfx4t1j?=
 =?us-ascii?Q?0LKJwqOv2Gcugq6vrGxh1wJFAWMXhVPD/N6bjPrqxT628/D6HHQu6klHO4RL?=
 =?us-ascii?Q?hriwlxJ2D4TyvVHDEzQztF5P8s3tll8yrAcqXhBzSD3rxKcH7aH5kfN4iuEk?=
 =?us-ascii?Q?fm4EO8CS+GM6g68PDn02LrNa6BppfSRS2EgKlOFzC/iImR4Iyt0Vf6+xuJRF?=
 =?us-ascii?Q?aQZrpaFEl8JbDWDpyyldO/HfNOIo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 19:30:07.3713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 795e639d-9986-4fc8-da2c-08dc84ccbde9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097

When a struct credential expires, credential_fill() clears c->password
so that clients don't try to use it later. However, a struct cred that
uses an alternate authtype won't have a password, but might have a
credential stored in c->credential.

This is a problem, for example, when an OAuth2 bearer token is used. In
the system I'm using, the OAuth2 configuration generates and caches a
bearer token that is valid for an hour. After the token expires, git
needs to call back into the credential helper to use a stored refresh
token to get a new bearer token. But if c->credential is still non-NULL,
git will instead try to use the expired token and fail with an error:

 fatal: Authentication failed for 'https://<oauth2-enabled-server>/repository'

And on the server:

 [auth_openidc:error] [client <ip>:34012] oidc_proto_validate_exp: "exp" validation failure (1717522989): JWT expired 224 seconds ago

Fix this by clearing both c->password and c->credential for an expired
struct credential. While we're at it, use credential_clear_secrets()
wherever both c->password and c->credential are being cleared, and use
the full credential_clear() in credential_reject() after the credential
has been erased from all of the helpers.

v2: Unify secret clearing into credential_clear_secrets(), use
credential_clear() in credential_reject(), add a comment about why we
can't use credential_clear() in credential_fill().

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
 credential.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/credential.c b/credential.c
index 758528b291..72c6f46b02 100644
--- a/credential.c
+++ b/credential.c
@@ -20,12 +20,11 @@ void credential_init(struct credential *c)
 
 void credential_clear(struct credential *c)
 {
+	credential_clear_secrets(c);
 	free(c->protocol);
 	free(c->host);
 	free(c->path);
 	free(c->username);
-	free(c->password);
-	free(c->credential);
 	free(c->oauth_refresh_token);
 	free(c->authtype);
 	string_list_clear(&c->helpers, 0);
@@ -479,9 +478,14 @@ void credential_fill(struct credential *c, int all_capabilities)
 
 	for (i = 0; i < c->helpers.nr; i++) {
 		credential_do(c, c->helpers.items[i].string, "get");
+
 		if (c->password_expiry_utc < time(NULL)) {
-			/* Discard expired password */
-			FREE_AND_NULL(c->password);
+			/*
+			 * Don't use credential_clear() here: callers such as
+			 * cmd_credential() expect to still be able to call
+			 * credential_write() on a struct credential whose secrets have expired.
+			 */
+			credential_clear_secrets(c);
 			/* Reset expiry to maintain consistency */
 			c->password_expiry_utc = TIME_MAX;
 		}
@@ -528,12 +532,7 @@ void credential_reject(struct credential *c)
 	for (i = 0; i < c->helpers.nr; i++)
 		credential_do(c, c->helpers.items[i].string, "erase");
 
-	FREE_AND_NULL(c->username);
-	FREE_AND_NULL(c->password);
-	FREE_AND_NULL(c->credential);
-	FREE_AND_NULL(c->oauth_refresh_token);
-	c->password_expiry_utc = TIME_MAX;
-	c->approved = 0;
+	credential_clear(c);
 }
 
 static int check_url_component(const char *url, int quiet,
-- 
2.45.2.410.gb47f57dd90.dirty

