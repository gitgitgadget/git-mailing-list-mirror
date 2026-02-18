Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442730C36D
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438257; cv=fail; b=qhNMP2rn7Tkz1sa/jI5v9ctYc6WOfiHsiEKQzNK5aM530REISKmb6QLBXiZAVqs08Ot8ZxTOT/pQ8X20/jTQPjwiiODuirdQ6/YEnTvY3tLiKqXO/76ScEPFVtgtxVWisOz77GbBT/KguHJh6PENbDXU9CTre68uL6+25DET8eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438257; c=relaxed/simple;
	bh=mOGZyttjbbAsyomb+MtgWKuvko/aMc8Rs0UVjIJIuJc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdBGIXX3a7t2ypSpSMlG9NT2hfxa7vZOdKzc9yYr4TTdqinccpCW/SjGEcKGuUWG8rAM9v2H50os3JJczdJspOri4DlloD8cQnyFCaPLXB4RHmVjBG+CebnDYNgG5zZfd/l6k30ezjFYy2wH2ROSNfgw38xyTKfdsOW+WQm9oKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OD9zk0AL; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OD9zk0AL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7sVdy05XlfWmrCByBmlwWze+L9BXQHaucg7yiy0N6R3+jWmUbmZ+tlHNmWSlnjRzA72givshw02Q8JV0zRUSG93CVAh+sCHgkspIkzZpb1omoraFCSFTARR8GOOIje23kCl9fKwHFVBJm04zZx/P20L3yeq7zthidtvG9h5QOQg2SoiZUuiv2uhkiSb8yTsouLjHTdA8ly0gJmgb4eUn0Jnftnd5BcQY+YUYvb8Thpj+PhEhXvYEHX943P1oCr7Bnl0qgIwegNTUiNT6SgnYxECqmOaMFaOg+tZ6r0H76TVG5TnBveoSdQr6RJlvxJELYYCX4gcA/tgJ5aS6rpx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LvGM6Gz+q90DXknMVzAWIIJLY3A4/wE+L+iNoN68rk=;
 b=rSi5lbdewBOgDNe/eMvD2pkBuSCAlN9we4SHfwjR4m2670MG5ILkNWkVXv8iz6O7H7JjdtO9jshBVZUrk7PpqXxaaLddYY2h3qCmplwhXfvlK5xVdEsBecuErGNvGE9x806RXTvtqlQ8aujXtpwMDEyKq7tcCXKC8AEfjz2ydbU8VNFgp4TUQTTV+m1QkZfVLekJ7iDLFq5rw6NFaRcgeQrkgqojgUzt+KnxXxf+Rk/wb2cn9A69cVQTLcJ4iN/va45K1OIy5VMqCBE3U2VP1cqK5KXEatJiJPtgbjD8nNaI29Dkl3gZvXL7O/1ALLrG6VYkjUDEyQ5OvdC3+voC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LvGM6Gz+q90DXknMVzAWIIJLY3A4/wE+L+iNoN68rk=;
 b=OD9zk0ALy6SYFhEtK0i0vuAoqAiCy3jCU2MAA3IZCNLGB2VxO1GNkMMNUicMKAlKJUny45iHke7toNVOygj8j+KjS3GUgTNu4WdzOECzv8zFWVuFngMrNT2VkxolqPUsuzFSCQ5g0dRB5Mt0wk8JNVifpDoJ8LB/FVKP66Cblq0Rzzr2nd+8th2p1Saxwj721b2YdtigICwQQbmc3zinFPOLPFaQTgZCGBSli3T6n6A0R8+4t3EVPCe8FY+1zMBU28llH6F9iaT3OVL6uVsWVI++Mcv5FKeVnIU583URrKcPviTMhuCMBSu5YDOhzfFcf1PwO1zHMiHQxQqbumeQkw==
Received: from BL1PR13CA0343.namprd13.prod.outlook.com (2603:10b6:208:2c6::18)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 18:10:49 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::7f) by BL1PR13CA0343.outlook.office365.com
 (2603:10b6:208:2c6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Wed,
 18 Feb 2026 18:10:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 18:10:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 10:10:22 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 10:10:21 -0800
Received: from ace.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 18
 Feb 2026 10:10:21 -0800
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>
Subject: [PATCH] t: use test_seq -f and pipes in a few more places
Date: Wed, 18 Feb 2026 10:10:19 -0800
Message-ID: <20260218181019.1705160-1-aplattner@nvidia.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb36c3c-95b1-4271-32d2-08de6f190bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LSZkrOnvvi3WhoLxXCn08sdPM3d5cR2vtq6BFm+OJT8hDGxZR5msLbOk42tz?=
 =?us-ascii?Q?cw81YbYOIbiCeJVdtiSQpUyMJo8C9SkGgwQ3fOwuAU0yK7R3dn3TQQPYry9s?=
 =?us-ascii?Q?0d39q0wjpxf0R5364h7yrJJUESskEEXFlsnwXoN3nV0IHsz+wesLVLQL2wQU?=
 =?us-ascii?Q?tScMbYvZewm2EfjwmthahGftQKIcv01k8zrRAMf+HbCGnbNOGNDtC8dMJjEX?=
 =?us-ascii?Q?uvTRb6ZwbkctNDaV76YBIT7XlcnoYOnMl5oPUdQRK7wbFLZO2P6N+6A4lmHc?=
 =?us-ascii?Q?NSR/X0YOWzW4xIi+Ip+H3kdNmqT8hbfVkFZp3Vje+3kKgfQVmREInwZBROkK?=
 =?us-ascii?Q?iw6FngXYz6toYXfjnPeAiC5vvhFiMHmGjNTV8BpjcOIC0uQ2WO0fwS+tKOdV?=
 =?us-ascii?Q?p9h32HQYFE+Le0AEEDQThIGge7QgVNpzcCM+N5OOMgcfMPtTzByZ8udbAElC?=
 =?us-ascii?Q?aiw6tk64n400C9t7O4oii5tNqOek043azIQa6o+qOY/0fmYOCJV2wW2H8sOi?=
 =?us-ascii?Q?Lu42PggiTSMu3P+rkknBDgnrORWzRw6kOBNYBkTeQd4OIZSLYXh0d622bb+d?=
 =?us-ascii?Q?VOvkC1Flh/V1NhzkM+utrNTekbyeyNVwL4MEOtquoEc+L8ccyELvTmlV0XXV?=
 =?us-ascii?Q?7hQuXbz3I4si3bStr74/VtlltpJCjMqz/+WR3zb8cyR/hYOkNKaMknuecnvj?=
 =?us-ascii?Q?apD9RMjZrZYJh7PuHD7QQGb/5TC8Hlwhe0VX9P9MROeInKcR3N30oiv9ORlG?=
 =?us-ascii?Q?5mgPjest1dG0/J2z1vOpqdf8tOv9593NE87r0HyiRAEVz1kwERZwkvUlcss/?=
 =?us-ascii?Q?nx97brSFkLVJn5wdrkQXvPRl2U4G0K3yLrEmyLlcpaPXn9vK7KVkc5dJlMVC?=
 =?us-ascii?Q?fPdKT18cvqqCklVV3xbP94TycGxugg5B11civP/eo2dV85hD1o2tbEyDgbj6?=
 =?us-ascii?Q?fnTNlI1KI50nuoikDTyQMVdvGhVUzSQUR1N5ixzcGdkk9/XiK6gb69TIIvXY?=
 =?us-ascii?Q?B3D5Ybrk3/a6aaTv6JRWxYOs3eJbAPhUbCvhmfvmmmzU1OnD+3dLpSamxK4B?=
 =?us-ascii?Q?Ga4dE8lg2TWq1yHIXLyd1rqQvkgdOKPP9ucqXT+yTMgC703AoNuI0t9bhulI?=
 =?us-ascii?Q?M6WdHQyqxv49t/uOwOF9+wr28iG4W4oKm/r2K9L5OhR0IKnmj6ieYiNltzQV?=
 =?us-ascii?Q?VrgYIFZGTQ8w4KJ/7QyRZtqJyHEALFajXQlJM8nJX0nHTyI/gGkrLVZK6mwX?=
 =?us-ascii?Q?bZm9YKTU0SGRHhkkZ/PxmtRyQn+kxOYL1CjKwkKjgzbvF46PpeoloittEP0H?=
 =?us-ascii?Q?RCq22e3U4jSobFn0cylYRgx8yUWvBJzZwYptQHpvm2EuED+iebF+FHfBLStI?=
 =?us-ascii?Q?Pzy/z534TW6DLfFZV3EpG1EfKEqH5VarQCXm34sT0zzulX5h5pcLIZ9xI8Tx?=
 =?us-ascii?Q?P6xxojvMFc9EEL0zo4mJ9ryvfCGa+Wza83ds5Fv1Ki6sHBrkez2JttKntnCa?=
 =?us-ascii?Q?LO23Mt2p0HgyGvvj++7zd0J2TbV0HBoup4MyksA2zZXnEGoHakKl/+QzP5Ci?=
 =?us-ascii?Q?42cLL6ERI760DPJBRT5q4+MqEcpH99DBCMlgfigenKPxwlIpzTmlVqB7cC0O?=
 =?us-ascii?Q?su36/TTS/3/TdqkVYFQ/dgEq5ldaE/cbM3TgR47Q9nvfkeVfh1s1d4RDOfAb?=
 =?us-ascii?Q?GAIeHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dXRJ2PQmtVMvK5SwK5eISs6RQeAEIQyotu7iagwsjgYRrSMV9vwgW/TvEKmk6ynFc/lvrZNGPl4WUIhjJt6Y2GZc3S7IKv27bdK+Hva2HdK4cE9VTk//PnNHcPc7V0k3lQmV+i8cRsrt002byx6PaKdJ7XWmqh9WwSuEERIgktvCXe+a0ur0GlFK59nEZuKoLNPgxqWZjhGegwnekiwhIhpGFHqxHUjZOz8BlYI+DgJ2Lv6Er6k6DEHepCMV0oaLi2nQaNa39UcGqmnAW7LrIBOGjpzNBOK+MXMaJ2AegGesf6wVkI8TtjWkpL7iC9PRD6n57GhzahIvcHkmHG4E/e7E+OEtuaFjQ6VXJRTiUSpT9H0bAccgKAe/HA6HX5TRgSaf8M1U/4T3SupwjUlUgciVUwwohk5QUm/mtKdnKQhNHTOgfiJx94DgiQREuNt7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 18:10:49.1914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb36c3c-95b1-4271-32d2-08de6f190bab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042

Several tests use a pattern that writes to a temporary file like this:

  printf "do something with %d\n" $(test_seq <count>) >tmpfile &&
  git do-something --stdin <tmpfile

Other tests use test_seq's -f parameter, but still write to a temporary file:

  test_seq -f "do something with %d" <count> >input &&
  git do-something --stdin <input

Simplify both of these patterns to

  test_seq -f "do something with %d" <count> |
  git do-something --stdin

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
Suggested by Peff and Junio in <20260114173055.GD885771@coredump.intra.peff.net>
and <xmqqcy3cf5xa.fsf@gitster.g> respectively.

 t/pack-refs-tests.sh              | 24 ++++++++++--------------
 t/t0613-reftable-write-options.sh | 16 ++++++++--------
 t/t1400-update-ref.sh             |  8 ++++----
 t/t1460-refs-migrate.sh           |  8 ++++----
 t/t5004-archive-corner-cases.sh   |  3 +--
 t/t5401-update-hooks.sh           |  4 ++--
 6 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 81086c3690..2fdaccb6c7 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -354,8 +354,8 @@ do
 
 			# Create 14 additional references, which brings us to
 			# 15 together with the default branch.
-			printf "create refs/heads/loose-%d HEAD\n" $(test_seq 14) >stdin &&
-			git update-ref --stdin <stdin &&
+			test_seq -f "create refs/heads/loose-%d HEAD" 14 |
+			git update-ref --stdin &&
 			test_path_is_missing .git/packed-refs &&
 			git ${pack_refs} --auto --all &&
 			test_path_is_missing .git/packed-refs &&
@@ -379,8 +379,8 @@ do
 			test_line_count = 2 .git/packed-refs &&
 
 			# Create 15 loose references.
-			printf "create refs/heads/loose-%d HEAD\n" $(test_seq 15) >stdin &&
-			git update-ref --stdin <stdin &&
+			test_seq -f "create refs/heads/loose-%d HEAD" 15 |
+			git update-ref --stdin &&
 			git ${pack_refs} --auto --all &&
 			test_line_count = 2 .git/packed-refs &&
 
@@ -401,18 +401,14 @@ do
 
 			# Create 99 packed refs. This should cause the heuristic
 			# to require more than the minimum amount of loose refs.
-			test_seq 99 |
-			while read i
-			do
-				printf "create refs/heads/packed-%d HEAD\n" $i || return 1
-			done >stdin &&
-			git update-ref --stdin <stdin &&
+			test_seq -f "create refs/heads/packed-%d HEAD" 99 |
+			git update-ref --stdin &&
 			git ${pack_refs} --all &&
 			test_line_count = 101 .git/packed-refs &&
 
 			# Create 24 loose refs, which should not yet cause us to repack.
-			printf "create refs/heads/loose-%d HEAD\n" $(test_seq 24) >stdin &&
-			git update-ref --stdin <stdin &&
+			test_seq -f "create refs/heads/loose-%d HEAD" 24 |
+			git update-ref --stdin &&
 			git ${pack_refs} --auto --all &&
 			test_line_count = 101 .git/packed-refs &&
 
@@ -420,8 +416,8 @@ do
 			# Note that we explicitly do not check for strict
 			# boundaries here, as this also depends on the size of
 			# the object hash.
-			printf "create refs/heads/addn-%d HEAD\n" $(test_seq 10) >stdin &&
-			git update-ref --stdin <stdin &&
+			test_seq -f "create refs/heads/addn-%d HEAD" 10 |
+			git update-ref --stdin &&
 			git ${pack_refs} --auto --all &&
 			test_line_count = 135 .git/packed-refs
 		)
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index e334751759..26b716c75f 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -68,8 +68,8 @@ test_expect_success 'many refs results in multiple blocks' '
 	(
 		cd repo &&
 		test_commit initial &&
-		test_seq -f "update refs/heads/branch-%d HEAD" 200 >input &&
-		git update-ref --stdin <input &&
+		test_seq -f "update refs/heads/branch-%d HEAD" 200 |
+		git update-ref --stdin &&
 		git pack-refs &&
 
 		cat >expect <<-EOF &&
@@ -178,8 +178,8 @@ test_expect_success 'restart interval at every single record' '
 	(
 		cd repo &&
 		test_commit initial &&
-		test_seq -f "update refs/heads/branch-%d HEAD" 10 >input &&
-		git update-ref --stdin <input &&
+		test_seq -f "update refs/heads/branch-%d HEAD" 10 |
+		git update-ref --stdin &&
 		git -c reftable.restartInterval=1 pack-refs &&
 
 		cat >expect <<-EOF &&
@@ -218,8 +218,8 @@ test_expect_success 'object index gets written by default with ref index' '
 	(
 		cd repo &&
 		test_commit initial &&
-		test_seq -f "update refs/heads/branch-%d HEAD" 5 >input &&
-		git update-ref --stdin <input &&
+		test_seq -f "update refs/heads/branch-%d HEAD" 5 |
+		git update-ref --stdin &&
 		git -c reftable.blockSize=100 pack-refs &&
 
 		cat >expect <<-EOF &&
@@ -253,8 +253,8 @@ test_expect_success 'object index can be disabled' '
 	(
 		cd repo &&
 		test_commit initial &&
-		test_seq -f "update refs/heads/branch-%d HEAD" 5 >input &&
-		git update-ref --stdin <input &&
+		test_seq -f "update refs/heads/branch-%d HEAD" 5 |
+		git update-ref --stdin &&
 		git -c reftable.blockSize=100 -c reftable.indexObjects=false pack-refs &&
 
 		cat >expect <<-EOF &&
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index db6585b8d8..b2858a9061 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1380,16 +1380,16 @@ test_expect_success 'fails with duplicate ref update via symref' '
 
 test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
 (
-	test_seq -f "create refs/heads/%d HEAD" 33 >large_input &&
-	run_with_limited_open_files git update-ref --stdin <large_input &&
+	test_seq -f "create refs/heads/%d HEAD" 33 |
+	run_with_limited_open_files git update-ref --stdin &&
 	git rev-parse --verify -q refs/heads/33
 )
 '
 
 test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
 (
-	test_seq -f "delete refs/heads/%d HEAD" 33 >large_input &&
-	run_with_limited_open_files git update-ref --stdin <large_input &&
+	test_seq -f "delete refs/heads/%d HEAD" 33 |
+	run_with_limited_open_files git update-ref --stdin &&
 	test_must_fail git rev-parse --verify -q refs/heads/33
 )
 '
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 0e1116a319..5246468024 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -276,11 +276,11 @@ test_expect_success 'multiple reftable blocks with multiple entries' '
 	test_when_finished "rm -rf repo" &&
 	git init --ref-format=files repo &&
 	test_commit -C repo first &&
-	printf "create refs/heads/ref-%d HEAD\n" $(test_seq 5000) >stdin &&
-	git -C repo update-ref --stdin <stdin &&
+	test_seq -f "create refs/heads/ref-%d HEAD" 5000 |
+	git -C repo update-ref --stdin &&
 	test_commit -C repo second &&
-	printf "update refs/heads/ref-%d HEAD\n" $(test_seq 3000) >stdin &&
-	git -C repo update-ref --stdin <stdin &&
+	test_seq -f "update refs/heads/ref-%d HEAD" 3000 |
+	git -C repo update-ref --stdin &&
 	test_migration repo reftable true
 '
 
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 027dedd976..df513a4269 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -176,8 +176,7 @@ test_expect_success EXPENSIVE,UNZIP,UNZIP_ZIP64_SUPPORT \
 	blob=$(echo $s | git hash-object -w --stdin) &&
 
 	# create tree containing 65500 entries of that blob
-	test_seq -f "100644 blob $blob\t%d" 1 65500 >tree &&
-	tree=$(git mktree <tree) &&
+	tree=$(test_seq -f "100644 blob $blob\t%d" 1 65500 | git mktree) &&
 
 	# zip it, creating an archive a bit bigger than 4GB
 	git archive -0 -o many-big.zip $tree &&
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 17a46fd3ba..44ec875aef 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -134,8 +134,8 @@ test_expect_success 'pre-receive hook that forgets to read its input' '
 	EOF
 	rm -f victim.git/hooks/update victim.git/hooks/post-update &&
 
-	printf "create refs/heads/branch_%d main\n" $(test_seq 100 999) >input &&
-	git update-ref --stdin <input &&
+	test_seq -f "create refs/heads/branch_%d main" 100 999 |
+	git update-ref --stdin &&
 	git push ./victim.git "+refs/heads/*:refs/heads/*"
 '
 
-- 
2.53.0

