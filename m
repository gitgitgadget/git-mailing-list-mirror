Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA29FC02
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698973; cv=fail; b=sBywaUxIc1/J904rekZ7JvlzVoadKqZqW1KpY1G1UnWsJcCHK8ns5s8vtbnwQIRgyl3zeZcYTOlwCRm8QIqKfZnaCpGUSaz1Uy6KWhp86lmn5BPZasKObo17i81pesWSrpZ28N9g5f299s/A0T/mHFhQyF8FdYuUjL+3iRp3arM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698973; c=relaxed/simple;
	bh=iaME6gDvPG3iIPweiVJHUg4UyJZ0EiaoBSko+WCHLHg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iEdZ4kcZVRO5hq5g1EvGttq5hl8ByQG80a0vJczE3Q5SExF7h08FfcHZYYjaPjtgi/2Dm8pCVe+lF328Z+FAn6lGZVLhFEhmJaHjLPXF0DALqgcaPKarsjHlS311rBSJ7u62ePAnn0f3QdVsrrSr+ezT+pec0RQyk198d32hRv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T8MYej57; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8MYej57"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmYQz7jMh15NIcU9Ow/8XE6LAMYjMr/Ob72wTAA3N5cymZbXMILMIbTB5ZpsIzLo3eZ1y1HFDNuytDAQ3aL5hjfybNJI83ODvB8EPc10oUu7mXVwhwn7ZG9ZIEZ7Ss0zyETAg+S4DvoXUD0Jjzklb6524FSVVgz0SohFl+xCQpk/t/Mc2rl6wiRz77hjASn7jJj16TPaFkleRCgRPlrzT5IjxwsJzUcNWVGlDqStUN7EkU1ovD0CJYrOmIWyX9kyz2XS27+H0dMWVq+v4zWxMapO1d1XRFBddb68FiZF0vCJhNKGuLoVUy/siIFRRtYdDyfSyBOb6FpwUi+Dyz3sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1PIbF+OvaSvkNlf8+GVtlnLVGyZtR5hIiJtJANCDEs=;
 b=LvCd4XuDLR29n2crfHInkOU+kukMwm7Riv6nEefBFeB8aUnWgA2nBFo8A9BYKMTDVFg7SiwhT6aunCbapu7B0UBaS5SAtAfCMhiD5BrsVLYWbk+zBgaXgGc57rRlWBmn28E4Bhd1u8WYq+1LbMCYGo2Mk+z4pB8hChBN3DDPmbbdbM6RyKYOlK5MoyzXfPZVLV7zzew+q0IUHem+rScQQ+ZhJ1fyN5dMRU0nPuwutkIzutWhDf2OrpDTG1speuhyjdG+mwRyrkjB8maKtYZpXqHxuFXrqusZBkcmCHZkm4lGik9WaAfbafHGtnqlThDE34vArLPlBNYYVq65C8bbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1PIbF+OvaSvkNlf8+GVtlnLVGyZtR5hIiJtJANCDEs=;
 b=T8MYej57cKMLZ8NJVmdFM9ATh6KoH/uiojz1X1cNJ6WMH3Kow9j7wjl2Bmj45N4XAaDES4WO6GDIxICsPPtdeABxLpBv1nijItxuTAfuUVVuAeephFp15NThqTbduNDwuQy4Qeo2KrZB52+eB7aCiQUZAbxjiIgGT4LZnSa9t2TnYs2ZmXNgjPs7FpN+YpkdevqomB35dwI0mFPR/Z1DkRDPNxsqP+3RGzHH/PjPhZ8+xmCTd7E54jGHZ7ASAQmufizrOGIWpNNns7dFGzL/bQwu+aJRwhjuKiq72TcaS4lIep5aE8SbzPhX75e39xkMhSCBvZpnxuRuFCPi1ltGUQ==
Received: from PH0PR07CA0058.namprd07.prod.outlook.com (2603:10b6:510:e::33)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Thu, 6 Jun
 2024 18:36:07 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::b4) by PH0PR07CA0058.outlook.office365.com
 (2603:10b6:510:e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Thu, 6 Jun 2024 18:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 18:36:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 11:35:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 6 Jun 2024 11:35:54 -0700
Received: from treble.com (10.127.8.13) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 6 Jun
 2024 11:35:54 -0700
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Junio C Hamano <gitster@pobox.com>, Jeff King
	<peff@peff.net>
Subject: [PATCH v3] credential: clear expired c->credential, unify secret clearing
Date: Thu, 6 Jun 2024 11:35:16 -0700
Message-ID: <20240606183516.4077896-2-aplattner@nvidia.com>
X-Mailer: git-send-email 2.45.2.409.g7b0defb391
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c80d306-d3a1-4c49-8a4a-08dc8657877e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GYjycNP/mX/YWRVWsUyooBoq7s1N7NPc5KgiChjdVKG+w3CcDSbl1xfstvdW?=
 =?us-ascii?Q?kcoh/XyR7S2EtLmtnLIvtBUrDHqooSbLM6TO9F7/bbiFMSPc0Geg9pxyx85x?=
 =?us-ascii?Q?hhALZZ53HG1fyYfbYZJHtDy3Xmy4yG5BJVfZ7vYvlnQx5efl1RyXfmojpDZH?=
 =?us-ascii?Q?p1QWqTOLi7LIzn+gc4S94RhilrXZZ8FbWUOOZ8V81zuhZFp5zIu7O5ljNJ6Y?=
 =?us-ascii?Q?hBi/L5ExEBpbspXn6fVlSRhAIxtWxsEf2badFTVK5JAGX3BTD9iqM8wHRnWN?=
 =?us-ascii?Q?uHJeJxPKd0n9KC2EmGNSARzTjUf0AwT+g4HQxQYDOI4s2z+SVsf2pmaGOUxt?=
 =?us-ascii?Q?CbEqW606vLP3tx0poSbm93NDLqPV8w0zFGkSRBq+4y6bJyCwZdYSGXFARJNU?=
 =?us-ascii?Q?Hwxq2gjyBVFiGBvpTt0iEyNJUmzOJ7VUlhVJLDWSSlRO6fsEx4PctWDZZCPy?=
 =?us-ascii?Q?ABN8P0f3nqbR30OJijiNQZn+wZp4yIFRyGrL3RjecqQgGx2CFx2CFLhrjSuJ?=
 =?us-ascii?Q?oUuEwRZUoJzGvBoJXw6c1dv8adYJ43LZPAo+LVzvNxYGsQT6qecH9n9dz6H7?=
 =?us-ascii?Q?U4fPnQluG+FQeiU4ySjQiIwt1TSbCwyAnJnYnl4UWK1dXTu+YjwVhd/bQK5o?=
 =?us-ascii?Q?KUtLJf8WGXy4u1w1tJXQTq7bI0EXAs1DkyeishNKLXmulcd37skpcALlfm0S?=
 =?us-ascii?Q?Uss9NIiaQD13k59qKariUGO4HLkgKYpTpMVWSehCqS/2oDT5HOfHBNyoSB1O?=
 =?us-ascii?Q?psTjknPcdh/QO8oDjm+oSX9C4VAiT4QfZEMLQtwfDU+HLPs5nusgeWRHfYDS?=
 =?us-ascii?Q?ny3XDUo9M51fHKUXvU6a42xGFqBtnIkr6o4rt244Ae6WHlUSD+GJdpW3vtut?=
 =?us-ascii?Q?O9qC0axXUcAfefphozolsjt4raO5JwucQMRNBs1mPLAa5N7ZgvPMHotexby/?=
 =?us-ascii?Q?eLAav2BnZm0TGraJshyGdFzjx49Bi1FkL8ZoiwWWTeVynQtdutmYo3cdEX1/?=
 =?us-ascii?Q?pNKEZ0p8ocaCN6/FBaLsXXVlb1UPJsaU2yNwfD9GGtYnxHr9uy9M8CXP7D40?=
 =?us-ascii?Q?sbuMQyXjKFoFhTNiE4VQiSQjJFRP2M0mbG030JuF6OfHUaS+RuF64c1kRUNO?=
 =?us-ascii?Q?v6ncP5SMHap4rYm/+/4ibdne1e5PjAhnnUO+CXWPdZjQw96WPXr7iJDDJSJe?=
 =?us-ascii?Q?ALBoISlw/XhOuZdcKWH6wEZ2YUUk7r3/qrK9LIkpoxkykWxp3cMluxLBAI0P?=
 =?us-ascii?Q?rPpw6ob9KI74bZ9IBgZ5wxtiEqNCRYBgro9J7NjgEPwwceZbWfBjfxl45WiO?=
 =?us-ascii?Q?eQs/54h8agbhxS7OOJfsEyGWt1tzUF7CZKmzzajOULm/FJMAb0alEzSTtwal?=
 =?us-ascii?Q?G2waLXJxzpqQl03+GUCR0u0t+A7knneLwM/yPr8+g+fz7qu/5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:36:07.2167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c80d306-d3a1-4c49-8a4a-08dc8657877e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915

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
wherever both c->password and c->credential are being cleared.

Update comments in credential.h to mention the new struct fields.

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
v3: I reverted the behavior change to credential_reject() and just unified
everything to use credential_clear_secrets() instead. We can rework
credential_reject() in a later change if we decide to. So the only behavior
change now should be the expiration case in credential_fill()

I also updated some of the comments in credential.h to mention the new struct
fields.

Thanks for your patience with this series, everyone!

 credential.c | 16 ++++++++++------
 credential.h | 34 ++++++++++++++++++----------------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/credential.c b/credential.c
index 758528b291..4b1a2b94fe 100644
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
@@ -479,9 +478,15 @@ void credential_fill(struct credential *c, int all_capabilities)
 
 	for (i = 0; i < c->helpers.nr; i++) {
 		credential_do(c, c->helpers.items[i].string, "get");
+
 		if (c->password_expiry_utc < time(NULL)) {
-			/* Discard expired password */
-			FREE_AND_NULL(c->password);
+			/*
+			 * Don't use credential_clear() here: callers such as
+			 * cmd_credential() expect to still be able to call
+			 * credential_write() on a struct credential whose
+			 * secrets have expired.
+			 */
+			credential_clear_secrets(c);
 			/* Reset expiry to maintain consistency */
 			c->password_expiry_utc = TIME_MAX;
 		}
@@ -528,9 +533,8 @@ void credential_reject(struct credential *c)
 	for (i = 0; i < c->helpers.nr; i++)
 		credential_do(c, c->helpers.items[i].string, "erase");
 
+	credential_clear_secrets(c);
 	FREE_AND_NULL(c->username);
-	FREE_AND_NULL(c->password);
-	FREE_AND_NULL(c->credential);
 	FREE_AND_NULL(c->oauth_refresh_token);
 	c->password_expiry_utc = TIME_MAX;
 	c->approved = 0;
diff --git a/credential.h b/credential.h
index af8c287ff2..5f9e6ff2ef 100644
--- a/credential.h
+++ b/credential.h
@@ -5,8 +5,8 @@
 #include "strvec.h"
 
 /**
- * The credentials API provides an abstracted way of gathering username and
- * password credentials from the user.
+ * The credentials API provides an abstracted way of gathering
+ * authentication credentials from the user.
  *
  * Typical setup
  * -------------
@@ -116,11 +116,12 @@ struct credential_capability {
 };
 
 /**
- * This struct represents a single username/password combination
- * along with any associated context. All string fields should be
- * heap-allocated (or NULL if they are not known or not applicable).
- * The meaning of the individual context fields is the same as
- * their counterparts in the helper protocol.
+ * This struct represents a single login credential (typically a
+ * username/password combination) along with any associated
+ * context. All string fields should be heap-allocated (or NULL if
+ * they are not known or not applicable). The meaning of the
+ * individual context fields is the same as their counterparts in
+ * the helper protocol.
  *
  * This struct should always be initialized with `CREDENTIAL_INIT` or
  * `credential_init`.
@@ -207,11 +208,12 @@ void credential_clear(struct credential *);
 
 /**
  * Instruct the credential subsystem to fill the username and
- * password fields of the passed credential struct by first
- * consulting helpers, then asking the user. After this function
- * returns, the username and password fields of the credential are
- * guaranteed to be non-NULL. If an error occurs, the function will
- * die().
+ * password (or authtype and credential) fields of the passed
+ * credential struct by first consulting helpers, then asking the
+ * user. After this function returns, either the username and
+ * password fields or the credential field of the credential are
+ * guaranteed to be non-NULL. If an error occurs, the function
+ * will die().
  *
  * If all_capabilities is set, this is an internal user that is prepared
  * to deal with all known capabilities, and we should advertise that fact.
@@ -232,10 +234,10 @@ void credential_approve(struct credential *);
  * have been rejected. This will cause the credential subsystem to
  * notify any helpers of the rejection (which allows them, for
  * example, to purge the invalid credentials from storage). It
- * will also free() the username and password fields of the
- * credential and set them to NULL (readying the credential for
- * another call to `credential_fill`). Any errors from helpers are
- * ignored.
+ * will also free() the username, password, and credential fields
+ * of the credential and set them to NULL (readying the credential
+ * for another call to `credential_fill`). Any errors from helpers
+ * are ignored.
  */
 void credential_reject(struct credential *);
 
-- 
2.45.2.409.g7b0defb391

