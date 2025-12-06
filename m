Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA703161A2
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980442; cv=fail; b=LsCnSAZs86irgaWjaarsa21L1ikak464aEYGGbeFio/I4N/e/CtcuGFEXJEu2yxBNJSOKfLdg0vhRC4MYNwXxuuc3S9IC6AUOtYYpMxVgvmoHsMaGWu1vWd4NNSaTeT1nHij5KeP8NzY5Fn0TP2Zu+q4iz7xcFhHIK0LxJKdKNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980442; c=relaxed/simple;
	bh=VEwGxyvzqfukSAbCB147CfqkRcrQwWhWkbl6eypzHb4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LOqYdVI0YENlbRaUDV82U4OWS88vcaOymVu6uwNXnlprjSQ5mEUAc2lA16nV+SGnTp9bE9ouwgHkqbbc4R/V7DJ/LkpKE4cKjtT3+uymiT21OySvplT38P/GqJZ9Z+KtOIY3ekxXu7OY5qviQvfyKJExinELW71fdrQZnIfQZx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QZC8D5uV; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QZC8D5uV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgY2SKOYipcKU9i/y4uzeCubXdCCRcUXUK5txrSBXoqRNGUiBrIz/xC9g6bYnfVzkJ2UCHB5eZ4aP277vAEXKqexHzc8MmVvJ+aAbFDIjVI5tOAQE03esCvT2p9OMVaQzeDZRZ/c8Ty6BRiK4CE5IgtxgTpvFhP3MopwrVcjE5wAsFGw4W7hlyMWy89sWxYa27sui8kWeyiInq6ERAXPvqzlv0KE9AN89Dj1z7pzQo6tw1nQF1PN+B8VifssjdWoXMWoUEJEyaeyxRF2DBHvZxuruLeJa+xOuV8vLyCXS6r4UPg2Nq1yuWZxUzMzoUiNAyWkOlztEsqL4y0Ihjnn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAdpJP1uRqlsk3QA46P0VMBmfzS5xpeqJVw19Jicyxo=;
 b=h4t7xNlcegRs5E2530H7mXxNmPBLfiyPYhQTZhH6tVcekrZl5NTT4bd1XSyDXSO2mnA+e+c3prN2LijYRmAosrcGyFBc2MdxPQ8kBE6IH8482nmNU/SAPMXvc6zO5y2ZMR8F7K8LGC4ao63gXu/ZU9LVFj+tFjvSSCLzqEBreYVfrwHc40HaYgMc2FvpZiim86lz6/cZ6GahAhf+HnYKxW3DlBPeu6mlnH8nwPk+Qy+GbvovT5m3lJwNIUC+b1WGFr/kv3K2mYAWyoV68fUJPSZIrbnyxOOqz8qq6IEGtK6uwC0mTesSg6ZWh1mf0CYTkeCEY1IxTon/qE09TywyMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAdpJP1uRqlsk3QA46P0VMBmfzS5xpeqJVw19Jicyxo=;
 b=QZC8D5uVY9NLsb7KiaNFMspPt2mKTqcGzCPWNav+TsDnC5VuXiqMvBvSgUSZX3MVCtcRdPbLj2IYGwGjGx31You56qW2FPpZqw+qJsK0JNRwegelUlVDxIMnAJMhaSkQnB8FGULbi0zdFNo+rcTLibzeEjvuu/BWPrMI4fv4n1lkCQ2w64OzfFZ00pz/+YzhJy2FkTSZCVVAndO6kNqN1xkhZ7TufQdG5w8usL8FnCX/CFIl+8QTj6bUadzlwHbzpmuYhY8UyNa4EB8gPniuanvF3zoAeOUNvxr/llEnOsfsLkMAcy3ihBVNoJKb3LQMAU2RUC6qfzEjaOzqoVhWnw==
Received: from CH2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:610:20::21)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sat, 6 Dec
 2025 00:20:35 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::9d) by CH2PR07CA0008.outlook.office365.com
 (2603:10b6:610:20::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Sat,
 6 Dec 2025 00:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 00:20:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 16:20:22 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Dec 2025 16:20:21 -0800
Received: from treble.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 5 Dec
 2025 16:20:21 -0800
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] packfile: skip decompressing and hashing blobs in add_promisor_object()
Date: Fri, 5 Dec 2025 16:20:12 -0800
Message-ID: <20251206002014.2066644-1-aplattner@nvidia.com>
X-Mailer: git-send-email 2.52.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 9152fad4-3e51-4008-beb5-08de345d4678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?znuSHgcgk57CVAzDTEFIA9ls35o7jtohhXODNbB6xZdU9oNS0DFbQlq0hsCm?=
 =?us-ascii?Q?04peBPQRvsG0Z4n/IKdyCeJlEcsfW3/rMPme3CRkXba/8s+JeuDCp0sEH785?=
 =?us-ascii?Q?JsAAQhUkF3iHeN5KyiA8JqMxa5UnDXiw24Mbt6YCz5tGV9S4ddD+gL+D8f+7?=
 =?us-ascii?Q?iYPDzzAgDybI8uI00IszxQl4d/7zooC4gl7RRU4jBli85984lZsp2O81EVIx?=
 =?us-ascii?Q?CfItb0+M1LIAPxbJureN+4aAlYv0VVBfnmaGSeYCYz8U2caA0l1Nl1iW+PP7?=
 =?us-ascii?Q?w/HnQhTEAx2yw6i7U/oqVdihz2hqXQ5DJ5cbacNNHG2vtreLxbnv3w8e+S5B?=
 =?us-ascii?Q?w53OaMmk1ep4e2Pmcl2GMaAHdxmHwzJr1Vgwo3FN6KQ+GwCphkm7mwrhv32l?=
 =?us-ascii?Q?UByiHyuKgg4JyP+o0xJjD/264xc6axgqPAHM52WPTiDbdnh6qlLhD4/C2KSg?=
 =?us-ascii?Q?mDrIxV6pdRLSQzeZlz+vch7b74T+evMB5ItcSme1qzwxCA8bq6eKcHPmkc5i?=
 =?us-ascii?Q?qfyiCLcI6zPw+zdt8yk8bhTRRXL1Rs95vDtG9TMy5GggM4/wXnuKiqYx72EV?=
 =?us-ascii?Q?d/aBhqlFudUgH0GUJ22NxliJngnv5kNaz+KnsoGtGeXzyk0CjM1VdYbdM/Vz?=
 =?us-ascii?Q?7JDIJIbkiJNr94Sul/qz1abJSgf8p5H74HbD18T1T6CjI3gt5k9ANEgz/x/A?=
 =?us-ascii?Q?TrayrbjDCSqWJz0VdSuHAIBLHYitIvYDl2FCABcraWxDYetaEKiUwCNrltKo?=
 =?us-ascii?Q?uNWJs6jP/8IkXCIfZsBqcgsP0kV5cPJB+eq3WSJ2fV9byiKmJUQYTF0lfSRs?=
 =?us-ascii?Q?w5yjHtZm6mSCTWsGZL3C+IpDV4wdIZ9eWjYxKnwYVOZ8OlyxUodY0DmSHjUK?=
 =?us-ascii?Q?5KAx9S9oFtZsobsB3FcQfIw6wb9hJpmvwLohK2CPc8RhX/Fdwl5NbrFjo9fl?=
 =?us-ascii?Q?GS+oeTf1K8qOEKkSU2yOSvQdG3myKuqSW4ClBsxqmtzQFayIG6TWkEp04wYc?=
 =?us-ascii?Q?qzLXlLBDryvPxvhpKf0zf9lQ7UQby09/c3/AT5Aryp/E38SEFV36O1U8p9cX?=
 =?us-ascii?Q?uhj2hfSW7oJeXjThYoaQeWBjjdkUbejNqd5yimmbtZ9BF3c/Z/eF2UvpuD7O?=
 =?us-ascii?Q?GQiXvAApTwZlhPvuPnUn6Po2+YUCaJ/guyYmYZE77LXgTy+wxScwAVJRHcMn?=
 =?us-ascii?Q?SXM0r4bEkdC+Hgfa+Ez4TlZ0naGPw39z7aOj2+2BD1titfNjiTrEy+xZMuCf?=
 =?us-ascii?Q?AYtb/dxPqIG2oXpnX+cuoBYpv2XVOM72KSc9JRTDTdyXB/1+ABnIr8m+mLku?=
 =?us-ascii?Q?DkyD88+Qy6yhObLRw6mNI0J+/Ah4E9Tnqw5MjBr7HQJT6kAUrk73llRqiUXP?=
 =?us-ascii?Q?JJVf8T1TMymfpjgaOLvG3SMVlkrfXL6+0x26wqASAiyHpNi3IfnC7yqtD9JM?=
 =?us-ascii?Q?NFG/i/tbgIQsCX7X9lubTlFKLcal/mywpKmtXAdWjDtxhuxRwz5e1MowuDRV?=
 =?us-ascii?Q?dXHXf30+JYRfgbvQE3RTEde8StZ/UXsuPxw9B5xcd8l0FK66lcMeUoVKzCSp?=
 =?us-ascii?Q?AA0b2aQRuuzSahmWaFM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 00:20:35.1157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9152fad4-3e51-4008-beb5-08de345d4678
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657

When is_promisor_object() is called for the first time, it lazily
initializes a set of all promisor objects by iterating through all
objects in promisor packs. For each object, add_promisor_object() calls
parse_object(), which decompresses and hashes the entire object.

For repositories with large pack files, this can take an extremely long
time. For example, on a production repository with a 176 GB promisor
pack:

 $ time ~/git/git/git-rev-list --objects --all --exclude-promisor-objects --quiet
 ________________________________________________________
 Executed in   76.10 mins    fish           external
    usr time   72.10 mins    1.83 millis   72.10 mins
    sys time    3.56 mins    0.17 millis    3.56 mins

add_promisor_object() needs the full object for trees, commits, and
tags. But blobs contain no references to other objects, so the function
can just insert their oids into the set and move on.

parse_object_with_flags() has code to skip decompressing blobs, but it
unfortunately doesn't work with the objects created by
mark_uninteresting() because they have obj->type == OBJ_NONE. Update
parse_object_with_flags() to handle blobs and trees that are in this
state, and then update add_promisor_object() to use
PARSE_OBJECT_SKIP_HASH_CHECK.

This improves performance for very large pack files significantly:

 $ time ~/git/git/git-rev-list --objects --all --exclude-promisor-objects --quiet
 ________________________________________________________
 Executed in  117.63 secs    fish           external
    usr time   45.56 secs    1.09 millis   45.56 secs
    sys time   37.91 secs    1.05 millis   37.91 secs

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
v2: Fix PARSE_OBJECT_SKIP_HASH_CHECK with UNINTERESTING objects, use it
in parse_object_with_flags.

 object.c   | 4 ++--
 packfile.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

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
diff --git a/packfile.c b/packfile.c
index 9cc11b6dc5..01b992a4e1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2310,7 +2310,8 @@ static int add_promisor_object(const struct object_id *oid,
 		we_parsed_object = 0;
 	} else {
 		we_parsed_object = 1;
-		obj = parse_object(pack->repo, oid);
+		obj = parse_object_with_flags(pack->repo, oid,
+					      PARSE_OBJECT_SKIP_HASH_CHECK);
 	}
 
 	if (!obj)
-- 
2.52.0

