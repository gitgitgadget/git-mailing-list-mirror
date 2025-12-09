Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292923009E4
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244973; cv=fail; b=PksW2L3RywYRJMB8mqexGQX6X7R1lrEUywdCcYyaphMJ+BOwmSKGwEoVXBE+x9vFLGGlWVN5EkMejSym3y3urK9q7q3a//C2YCfgu1Yduy1RXQPJj2fXCPaspi/fDfvDisQTO6wmWSshIbO+xCWHTY7bF3x9GyU+s/Yir32+MCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244973; c=relaxed/simple;
	bh=CMHwNb8hSRmAkK03n2ZGw9vZ66IB/wBHSZLxJC1+tNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsVtcpY9HSdmBXZc26US9Yx60HlzXRsFm/5cVnpr7D+LzU9iEj4kvE8uGEATK0PzV3L5lHUwk71g6mX7PjsShonetheMocULxzOWs7Dg2x77AR0gQWfZnr29PKqj4W/mgX2ZQH4KqmYitD3XJDYdNubeIhmaUzEwH5ZbBa6g6rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mGrdijOq; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mGrdijOq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkIfMWk++zWBLBkFEPDrfoeB1UlJ4jKOQjxLEMJrlKYBTJ/SBmMPsMMIxYo9KWWLlT+hL0vXGbtNcF70rztlbRFbcw30hNP0GO5Ski/99HcLaHNeJ5FEqvdBrad6yQYXlXtzCsebbRb6QZrzhRy9s2CwAAYDqaioaXp79nzsPJJ9Y83C3RAx4XOJRtB/J+lh2ADn54fiLqyuF72pUqs31olyfr9BmEs6Wcsl5S47h1v9Dve4XcVUWAlBb+7PG66qSLVJPn/MZu12s1/XccFxEoYYLGvhzJFg4pKIpHhrSGdR96VS7qGd0sgAqLlX09D6weMqdB8JgVmI+h3O1S0m+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nir8TQKIggBo6bHB0YGt3XnG0t1QrgiEp6OsL1dsf0Q=;
 b=QV5jHv8gDpySDc5msmQiPwWN24/70DUFUT/pbYCrzt9n8Qn9hU+p37nVEt6tp8OYY2eIaB1kF/AmslZ2vcntTCuURcKJxnyJNsPtV46UyoHb5InR61FOJGuF0aRJ51a5Snm9eeCxd3sR1eBsQJ+VKXPtarxGy0/lYVP8yHXLICZ8vYgIujUjok4pZjVRsExgF/Tqp/fWpTavqaC7oDCWXXuELRbNBnHWskzGLznR0xe9hGHjUGNAPywRZovpQPkRcqoL3CeRzaG9viMYhPQeR2q3+uB+2PmEHFFa74qCEx9YZXFQCtE7BMXeQ88+64N1WtGYFH3LHEnATz2eTuhnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nir8TQKIggBo6bHB0YGt3XnG0t1QrgiEp6OsL1dsf0Q=;
 b=mGrdijOq+LKaliBZWjeN9k8XqX/L910XOpXMenurGd5RS6IgPjv9mSpZEXNDraRoClHaAdnyxxJ+sC+Esl2GjHa6R0xMIaoAfO6d0DH7ZT31kneVbF5sqRik6zFn9Q7z7ZKHwndl/hfoajJds/UyQqGVZ44hsKne0AQjVmJ40UHfZ6WbaZm867b7Hf5Up8Q3eOceqpRo5xr6T/CBZeo0a2SVznEhkzG4zJv7FBqFm02tY/LHH9bV3Yv3a+9DZTPTgTTMWXnOW5NLEfOnWmWY82VaEgHi2tiULXsQ2f5lkxJvuQCMH0feC5Ib41/CDLAIbip5bPwdzIpade1pjSfh/w==
Received: from DS7PR05CA0018.namprd05.prod.outlook.com (2603:10b6:5:3b9::23)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 01:49:25 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::7a) by DS7PR05CA0018.outlook.office365.com
 (2603:10b6:5:3b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.5 via Frontend Transport; Tue, 9
 Dec 2025 01:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 01:49:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 17:49:15 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Dec 2025 17:49:14 -0800
Received: from treble.plattner.fun (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 17:49:14 -0800
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 1/2] object: apply skip_hash and discard_tree optimizations to unknown blobs too
Date: Mon, 8 Dec 2025 17:48:56 -0800
Message-ID: <20251209014900.402637-2-aplattner@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209014900.402637-1-aplattner@nvidia.com>
References: <20251209014900.402637-1-aplattner@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e8ec28-bfab-4358-2a00-08de36c52ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ukXV/GrNzKnCkCCx4ifOUZC33gCXc4kk/FCf/w4Nvrn9Fi0B3ubPq6/citm5?=
 =?us-ascii?Q?Ih66V13nTP8Au5+M5lIXjvnoRXnj9e8XOFNJwGhevYoqnsE/YzmBvvfhL86i?=
 =?us-ascii?Q?1Tesnqjt2ewZKg64s3dNbY/XA5m5wehvUA/GA2YD0+F0jAIXohNrhFI590Jl?=
 =?us-ascii?Q?JiyN6cI7pUp4tfh+pWNaVrMqeIpsBGpr8CSrgQjaTFCRE6O/Trg9j3GQkndR?=
 =?us-ascii?Q?Hx5c1zoXvDi8FWl4p2K8ZqTMRoZeGcWOvTzyPt4r0Kk04mJL60B1GcfDzDSd?=
 =?us-ascii?Q?KnBRXM0nIE8sReZoJyhTJFvb1lFWoQI+yHVORwlWtIJqqVpeC6aFj23szY8C?=
 =?us-ascii?Q?RzrotnwWLiCquIJHt893ZbwTEaMh45CQcp7sDZFMKCc8zJ2/KRf/bw3K8O6P?=
 =?us-ascii?Q?Y0w+t2cfCbrzogS9zvzFjiFE80cAMgOlm/QGmj51/rfOgQUCMrE0FNuGRGgk?=
 =?us-ascii?Q?pADXcy6HTPyWHS8K2FISrW+jtYL1bPAJeSHGuLA0SXxpg6jInrOUTcUflm1H?=
 =?us-ascii?Q?H3elPuk65lADFZe+IL47e88TO3EDZYdUlioGCEjOoBsXMUK6Zq+Uwa63PXSc?=
 =?us-ascii?Q?LQc+0m9jGeOqSAerjpJeHF4DTmyZDNMEg7lUzNp653xbedVYx4ZK5tIO4gOI?=
 =?us-ascii?Q?DrikTyo0XfzeoNbmtc+hp+njA27hHpKw90ZRr1Q3Uc9zrGnOhm4F546HIHLR?=
 =?us-ascii?Q?FbIkawiodN4PNQzWirWQxCH9OZM8ld5Uh/uEkuTkvYqdSXFH4T1jG3v49q68?=
 =?us-ascii?Q?hLT0wHATPC56FarDDFeQCvsPRHxfbIn1HSFGUfIShvf2Tg6qM2ZqFcSFJYtw?=
 =?us-ascii?Q?oSXYP2i7uddycGgFqpOs6toWTqrfskhJ2Xo8ZZ+7jmp/3TLCm3y3cu0iCCeH?=
 =?us-ascii?Q?EXcBEiDf5xIO6cqnwPix5x7G4OjwbJc51pRakd/UMbAFlRyAoYWGqsN0KxuZ?=
 =?us-ascii?Q?CeQgh3h2KWW2Ei9bf2WDA+4Fqa/A4MSl2023Mqviv9gHMiSHzEBJGR3SSFT3?=
 =?us-ascii?Q?g+LqmkAE+DORwQiIZts1Hy/IXRBOSVHUPAMd8EHaSyiVYsrTpq12Dg2Lhxv1?=
 =?us-ascii?Q?ckrD8N0GDyHqabfLHqiJBsP6VBeD417ehwf3UhGt3Ir3Bl4eiRt1bFCjYF37?=
 =?us-ascii?Q?nqAK2SaxhKEiSc4D4k0/85OpTsZRgfz58FvTR6bhoiN/1EQ2lOLYBxtvb4dr?=
 =?us-ascii?Q?Xs6cuuzm+4AK0ejlMO7aISEXdXf8+fW725l+WzF0mrusBf/03drfye4aTgRL?=
 =?us-ascii?Q?3V/bXsvtr7AyLMQV8EpYYbHcQn0A+tjTmhnx5uHniIkbeH91QSEsts6IQm/+?=
 =?us-ascii?Q?0FBFMY5lmPz83bEBXM1SelU2S84bvYofInQHklNk8USPW+Es+B/VsccV8vcK?=
 =?us-ascii?Q?RvcZ1/pZGRaLFT8ViIyNGAkkrkfpUxGVLbTjH1iFNI0giYh8AO3Vb4OxRuip?=
 =?us-ascii?Q?d5sJ319agZtMzqv6PdRJBJQtnItyapCDokPDUQOlVgMo0Qqt8BXR/l7ARF3t?=
 =?us-ascii?Q?+Hh0cxDC/Qdgbz5N5GpJh9kdirLZeKWy8ShZly4fBpFWH7T4MKPqiccc2slN?=
 =?us-ascii?Q?bFyMamFJ4Lh6UwG5h+A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 01:49:25.5128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e8ec28-bfab-4358-2a00-08de36c52ee5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182

parse_object_with_flags() has an optimization to skip parsing blobs if
PARSE_OBJECT_SKIP_HASH_CHECK is set and the object hasn't been seen
before or might be a blob but hasn't been parsed yet. The latter can
happen, for example, if add_tree_entries() walks a path that references
a blob object that hasn't been seen before: lookup_blob() marks the
referenced oid as being a blob, but does not provide any additional
information about it until it is parsed.

It's possible for an object to be created without even a type, such as
when prepare_revision_walk() uses mark_uninteresting() to mark all
promisor objects as uninteresting. These objects have obj->parsed ==
false and obj->type == OBJ_NONE.

The skip_hash optimization does not consider this kind of object, so
parse_object_with_flags() proceeds to fully parse the object to
determine its type.

Improve the optimization by applying it to OBJ_NONE objects as well as
OBJ_BLOB ones. Apply a similar fix for trees.

Fixes: 8db2dad7a045 ("parse_object(): check on-disk type of suspected blob")
Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
 object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index b08fc7a163..4669b8d65e 100644
--- a/object.c
+++ b/object.c
@@ -328,7 +328,7 @@ struct object *parse_object_with_flags(struct repository *r,
 			return &commit->object;
 	}
 
-	if ((!obj || obj->type == OBJ_BLOB) &&
+	if ((!obj || obj->type == OBJ_NONE || obj->type == OBJ_BLOB) &&
 	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
 		if (!skip_hash && stream_object_signature(r, repl) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
@@ -344,7 +344,7 @@ struct object *parse_object_with_flags(struct repository *r,
 	 * have the on-disk object with the correct type.
 	 */
 	if (skip_hash && discard_tree &&
-	    (!obj || obj->type == OBJ_TREE) &&
+	    (!obj || obj->type == OBJ_NONE || obj->type == OBJ_TREE) &&
 	    odb_read_object_info(r->objects, oid, NULL) == OBJ_TREE) {
 		return &lookup_tree(r, oid)->object;
 	}
-- 
2.52.0

