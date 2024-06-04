Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A7A149006
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524232; cv=fail; b=cSZmP3HU6/rqb9RpRqWQ48bfMsKBWl8s4adghIL+HS4aYI4fXXSCUjOGIkHY9uUxCEWweHIbaL4lQfRH21/zw1YbRlKUTdd2z+O82D5jCSSZPqO3I6fRKFjMUJB3WjH2+aO6xDMpRReFq7b1xJ2TXMybnIXm/fwuIf2s3Id8Hfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524232; c=relaxed/simple;
	bh=Alc477ZAy05ClGS9f18jbXop+CuexVtJudvgKR1f4EI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ko3y84zGV7MmVw3TLJlDoQ3XrDR0Q+j0uH2YKnsGY8SS4AIszsFOdpezQZ4g7Vxtm0Pcm4n9y26tnLXrc6AKCS/u+VodY8KaoUmVKWIOlx5VGIYMtyZC9BHms7XIhz9aMLOyRElyIWFBeUeDFuZ5l7rncCOZCXIGxiY5lJ4vFMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RoDCAT3i; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RoDCAT3i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFsb1zbKJQDkvTFZbE/36DdynYuTPFdxxVg4tt9oiXAoqYD7rO8n15lTnJr3N28Zbd2aptB43PkKKvmjlWsFC3eDZJb89+QiBuHzvXgA17+RcMRVBt87ohOpLfyoF+9Jv/7jG7/Nwzl6tDAzvdzBXw6hQnf0R+Nfu+K2Nrpywrs46GvrPqpmlk5LaGRC5Jg2MofTqhCUtP+IU7Poi8rOlvphEU55gDJUDG7hYYUOVUH6YiqKi4cF4liBuhQBJbM0Pj9E0TZSkRmbXeJmWi/cFX/FcK2oKvAiMzvjIMsG43Ywu+KpGfhEUWsUA2Kgp46/xSAf+G9eKXIeaurD8oMApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cDXe4snVvcx4qM8iXH4QLIzbb613XdHkm0Ru9tW74c=;
 b=T1Fy859iOnUkyiTQUTieqtIYFa1b0I7G5FjX4b5i6lO+0kQ3Wq22E8lrdm81p8yqhRaAb2NXQb/FjQxQB6c1yfbs+64Mz0OrUV0jSndksiySa/Uhy2EJPAqoV+9NSWS5YlLfKmzmO3Axr77vzPH6PLFr/YIWOyuIHRRDShoZRblUQZ5ZZoecfdm9tmFdf6LK/Brl+BoRH5wsL21mmPMAO1T/UUTtPCiZXxDo9jGA50zgLFrQ8MjZfFQRkdqDgF/moq7xEQ0vczLGI+3bR9mdBl2pGxwxx++2fOMBakLCxsBHoVRTm3YkCQmMI61il4+ZjgepWJDzq5QkhWCUqzK8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cDXe4snVvcx4qM8iXH4QLIzbb613XdHkm0Ru9tW74c=;
 b=RoDCAT3iNsNhsBwx5Qx/U71VCeJu5KGGygqVIdsa0mbVUcT61ltheFRalNJXiqjjh7tDLilo/SqVZWTz+XE51wIpihEAa4OtVQoG9fB3EX9BKSoBqLptnMQjFfCUTifZACdDvMXd/HKZxBlqIHMujjnmRSHNS4+G3boGV9fBZMet5J7mAwGH7w26mqM4wpDJogbJyK5I5WlaSz2590LGjM6yxWhwthcmqLyQ/RWcuHw45Nm3oO/35IitZ7iKFVrjA8c3pr/1+YvH8smPkXfCvCyygQEjkcFIhnHaAtK7H+/mKKYgKKkfXVgdtj5AmJkdyNjs93oMyrF14d4Ri6sOog==
Received: from BL0PR02CA0024.namprd02.prod.outlook.com (2603:10b6:207:3c::37)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 18:03:47 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::25) by BL0PR02CA0024.outlook.office365.com
 (2603:10b6:207:3c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Tue, 4 Jun 2024 18:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.0 via Frontend Transport; Tue, 4 Jun 2024 18:03:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Jun 2024
 11:03:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 4 Jun 2024 11:03:25 -0700
Received: from treble.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 4 Jun
 2024 11:03:25 -0700
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
Subject: [PATCH] credential: clear expired c->credential in addition to c->password
Date: Tue, 4 Jun 2024 11:02:20 -0700
Message-ID: <20240604180224.1484537-1-aplattner@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 69996523-f909-4cb5-9b26-08dc84c0ae30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lbxAemr0knY1hBCK+t5vtDcGfCLM6gXeYGEqEENt1CG6REB8TIYzOJA6SBZV?=
 =?us-ascii?Q?4gkx3q6KywGRdedQY2aNxM/OKU3nwrHN3PtFxGOYwiZsDOT0M2jMr4Vuay9F?=
 =?us-ascii?Q?j7BMsX1tRW0q368pvMzCs77z+Covyt82zX8pFhBrEMyOXUwg5Hn3Jfvsne8E?=
 =?us-ascii?Q?i2YrZNnz+s1/YgSrurhrSv2UjGym4i09d+q2dIZ74Zohv+PVZk/3MEyMsOVa?=
 =?us-ascii?Q?QR8JPF2KaeYvFu6VnjPip73lStFcsq5E4Ro1yZNSQz7myGwtl49yeQt+3Z4Y?=
 =?us-ascii?Q?vFySUmRhfc38AKtMZYL8c2NjqGp707EziUyDzWuxW/BnR+aWNJ2tAr73pFSU?=
 =?us-ascii?Q?NK48AaUrYqILV8a+VzvSYBHeQ18RdeM2OAEjmkShdVr3t6wQt1V/DNKrGf8K?=
 =?us-ascii?Q?TqoH5jK26iX8GNn9F29AhQ8Q+qwKI/iz0jx6euovz9bpkfBHoYmYqhQP4leD?=
 =?us-ascii?Q?XalqW9D8m0NAEyz8TDo22BRiheLgxTav+OEg8ugbmbXlzurziqe6yFsZnRnt?=
 =?us-ascii?Q?53lOmvsd8i+Uz+Z6Ti1oRPswQ/Z7OMtbzPE2PdXWKjqRFiF8J6g8x7N7Cx2+?=
 =?us-ascii?Q?LAC/yHLeElMCbyePrfBS8+wYco/9I5BCbNjGIprpeLhciktIk4Ws8OC++vWl?=
 =?us-ascii?Q?IXV/y0WuS4nkouM3liHpo4SkPrhoYWsAGy3u7X2xgFNwEnCRF3YUJgluGamG?=
 =?us-ascii?Q?onJ90O6g9pUa3FobNGissxuYNrTMlekBGgdStMgAkDzv4NJW61OP2HqyvqXG?=
 =?us-ascii?Q?LeMrxFyxPnjmEczx1suslu719qqrZIpT2kd0pFKYeTRFYsaxskL8hIidMZvU?=
 =?us-ascii?Q?+hi5g12mGeRmuotkLM/rKPo7eO0Ktxw450JhraSyUOxJv1QmeknA1GrpkSq9?=
 =?us-ascii?Q?Ktn7fbigndRrhnhum0s8jzgzGnt1f/5Qd0Hvksea9uWkBYptCFpriPbsape2?=
 =?us-ascii?Q?yTvColvZvkvXHv7IiDemajzA6A8m9PSDaJRVh3Xm3Dq0AQIBrUrREjJBGb3U?=
 =?us-ascii?Q?vb3EVlt0anVFrXAXKzKhADQ3zz/VnaF2btUTrxg0n5oCBH6v47HpJM/mdT5+?=
 =?us-ascii?Q?TZBQHR098B7bWo4w3e7eOWnF5BGKLaIyCqpS6JXjTTmYmw6qnY20GZmL/zAC?=
 =?us-ascii?Q?cBtLPb24MWtk/xnZvCQ4zxVb4NN0Tg2GdJOC+hD7YQhRufGlQQ6Y19HEcN64?=
 =?us-ascii?Q?jkFqqQomDE/dhPR78O2orxJCe3X931ClYXMFV81syx/Jp69DRFBI3DlVY/TL?=
 =?us-ascii?Q?CDaZt6k8fjJ24EVYSfPjYyMNA9QTLoPzP0FbwBZK5VmqYkK8XValyC+UasQX?=
 =?us-ascii?Q?mT3M4liS9ji6KfqckQL9OW9ZWNlsjOwLhER2O7+YvNdD7p/817jZoNGFiSOM?=
 =?us-ascii?Q?FaNaayN1pqBUuDXB+eqPa8JRK2A3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:03:46.8744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69996523-f909-4cb5-9b26-08dc84c0ae30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071

When a struct credential expires, credential_fill() clears c->password
so that clients don't try to use it later. However, a struct cred that
uses an alternate authtype won't have a password, but might have a
credential stored in c->credential. Clear that too.

This is a problem, for example, when an OAuth2 bearer token is used. In
the system I'm using, the OAuth2 configuration generates and caches a
bearer token that is valid for an hour. After the token expires, git
needs to call back into the credential helper to use a stored refresh
token to get a new bearer token. But if c->credential is still non-NULL,
git will instead try to use the expired token and fail with an error:

 fatal: Authentication failed for 'https://<oauth2-enabled-server>/repository'

And on the server:

 [auth_openidc:error] [client <ip>:34012] oidc_proto_validate_exp: "exp" validation failure (1717522989): JWT expired 224 seconds ago

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
 credential.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/credential.c b/credential.c
index 758528b291..38b51e11cb 100644
--- a/credential.c
+++ b/credential.c
@@ -480,8 +480,9 @@ void credential_fill(struct credential *c, int all_capabilities)
 	for (i = 0; i < c->helpers.nr; i++) {
 		credential_do(c, c->helpers.items[i].string, "get");
 		if (c->password_expiry_utc < time(NULL)) {
-			/* Discard expired password */
+			/* Discard expired credentials */
 			FREE_AND_NULL(c->password);
+			FREE_AND_NULL(c->credential);
 			/* Reset expiry to maintain consistency */
 			c->password_expiry_utc = TIME_MAX;
 		}
-- 
2.45.2.409.g7b0defb391

