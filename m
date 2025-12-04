Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531529BD94
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868939; cv=fail; b=aT2DuOqWPwhn7KNY1yYerowUFJVkogJveWTOi2wasLt5GS428gkN3wtaPp0QcKKGKWraYOW8sYrm+uTFx9pR9b+/V/qNikr+Nb6+ZMq8fWtEAn6v4vKFgfJ7jhti1KsB9rKkNGzZMyWCG2xgu3CcxyWF00ZbeORbkgduV39/ksY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868939; c=relaxed/simple;
	bh=UeXLZZ5cawqxXflG5lcOAWW3lyJ0cy4UNBPqt6+q9lM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AtPA0S6yMchRGkD0GMeVdF6FaZ6h8Xgl1nH8MLP6ROscjvajkOx9OhiOI5uzD1eHZK/h10Dd1pPYSE0TCmF1GMCwQnjQsmggLuSrfiC+FTcXgq2iIwNV9/kiPnt2SFnlEvNbrf4FKF39KsRve21zqn8CnH+d2KWbJyZExG/doRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=syt0uYaW; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="syt0uYaW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DP3d/hHoCntWimIYKZXTGACGzUClYmw1Jof2cwQo/vAmYt4oa4tewOkEMNQie5g3zUMZJVuxYNResfs1BGANb6CCcJze3z9LyUf+Hjk0s2cvZ+pglgEvCG7S5FdcSl9a1visUZdU4dQ4UMOpSnAEGU5LQPU+n8m8OrwcOutkN8B3USK/omGgKg7rAY2liLTG+O80tXVp20JV1ttQO7hjWgFiIhWzq2Mr0E/VEFlu593g0f9zQhMV/Hutkp2PtDZlY6l36zo5uiHFYd1CN6R92zwMHOXWTZDchzds/3/1MhscWVyblwIAGdjKHej5wbsK6N9xadcVAlQQyrNNuruB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZjyvfNqcALZ6eoc1gH/hbTYE4gluTIAM3JB0anl8WU=;
 b=CsVNP1LpBlQIHGy1jRiQRFr1yVrXWObWQQ7mI/U1QQlv/EKFz5GA+qGpDdHsADMYoiNCs1exxK7d10agrtFLtKTdXg2MIGDj4DkknmShM56fCmRw4vp3fepZ+PG0MBgSJAa+apO/O55HZohDDLN6Skv6Kl4LqSspjZv4dm2SLH7MhinL85SPBh/QQkNPI3JkhMs3m7UtASXheSV/AxOyW/jFUfz8Sy+Aw+n7uRvhXwFZLc6d4kVNT6JLKWjJpsFrDamuY8hGmIjyZ49TJxU+XvB9M1VQTTho5xVL2TYICGWarfi44umwO8jAuVE6oRYdK62PakhhyBBEO9raY4CSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZjyvfNqcALZ6eoc1gH/hbTYE4gluTIAM3JB0anl8WU=;
 b=syt0uYaWLrhTtQhZcV155rt3xjg3m/D6rnj/dBoUligagvld1nLNPerMZfCLIqoO7BeuntybeSAiFYB0yfaI9XqJE9rzioE39rZ4l6k9UbFVObk5N2r8szO/iNuSKK4VMIoxv91JgJdDPV7qCcPKlqZh4OS2nm+IUhY9TP+92PWzHihYe9B3LOKnyWTNqG98mK2d0ddklV2Gni/c025/A+cRqWcSsiVENaZj4EEs4/bfuZOTsFlgvbsQlMsgVprAy9bOh8q/qDvnCymEevr/2htt7HKgHb0v0Ee3R19s5/eREIV6IBv2vuCss1LHmSf3Mn8mYPPofk9JUmgKOi/fnQ==
Received: from CYZPR20CA0018.namprd20.prod.outlook.com (2603:10b6:930:a2::6)
 by CY3PR12MB9678.namprd12.prod.outlook.com (2603:10b6:930:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 17:22:10 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:a2:cafe::70) by CYZPR20CA0018.outlook.office365.com
 (2603:10b6:930:a2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Thu,
 4 Dec 2025 17:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 17:22:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 09:21:42 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 09:21:41 -0800
Received: from treble.plattner.fun (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 09:21:41 -0800
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>
Subject: [PATCH] packfile: skip decompressing and hashing blobs in add_promisor_object()
Date: Thu, 4 Dec 2025 09:21:29 -0800
Message-ID: <20251204172132.319360-1-aplattner@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 191d287f-3b54-4642-99cf-08de3359a867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8bKpvN0Ri0Bc4wzIXhxC346pUeHmp+GjYON5ZnH8GJl0NQi/k5DhWlSqPikf?=
 =?us-ascii?Q?LWWtmyW321A8U3n1KwQy+bDXQWz0IMW0b1aaiKKbsH5mwT9RS5E+bbOaxeAk?=
 =?us-ascii?Q?gUx25Qrweai0T9UgJc+6PbrbzRbXqV4b1aZ7kLahm74qJdwzVXbv8PJymgrf?=
 =?us-ascii?Q?7JR0QNW4gsdXhk1W08wM0kUJZiLE88A01YUxMFE+kZ2fPbzlTZaRPMLCoYGI?=
 =?us-ascii?Q?pwclPn3u4JM+fLF6DEYE2vtWMAp7oUnxbg1mM4rM9bmjmN3kCaN3CfI6xDMy?=
 =?us-ascii?Q?VwblRThnn9e/hrJt4FEOYtSCzOxyzI0N12tAyOS1nWNCFEIP3KZ+/D4RXUSb?=
 =?us-ascii?Q?zBYxVdK4eSg0BKqbcI72Ue8ddsCg8eBKHc/J16ZFy7lrbxli1i10FEHPNjcm?=
 =?us-ascii?Q?suc98UdO8r8Q9PI8gFuAWtSHqlqcv937OBbe8VCWzkZmT0dm+nklTqwQyKhh?=
 =?us-ascii?Q?vAsUIxXUYmLvRGhQUgonNCYPGaqouDC60ZIcfnb7D+IMCReLGQxwGmA49mfD?=
 =?us-ascii?Q?yvIgvvUmhUvWEQwNxD3litpkBogW23QphjIgW1L+V+cjpQiekAjerSAj4Cul?=
 =?us-ascii?Q?JV6q1SMqoTiJw1fG/IMpSc0GMCofMX32osOwB5RNCdqBcSfcE2qGuG+wj6FA?=
 =?us-ascii?Q?RQvxEYHBy5YuNJXygH0mf9UGJfo/AxS0/VAoOTGmq1GYDkF5wb81IKy3Y1c/?=
 =?us-ascii?Q?LDZ5XTK2+JD22Q76LmEPNswzLREl5C0H0Q+kcjmQfW7Cl1y/einXX6y9yR+I?=
 =?us-ascii?Q?sZcBW7njSCqPSPcC48EjppaU6pcPrI+gy9ANnXXTkhva24NN5boPWe6WGAsm?=
 =?us-ascii?Q?9+YLafBQKrEv5iadnTzd1VB+X8oz7mf8Zm8EWCOyPZoFT/7Xd7JO+wb+UiPG?=
 =?us-ascii?Q?ta4yE0Ue96T8vHSnRV8XteHLbwhnH4HroSBhxiX/RM/w+890cYyNg8Ngj0yu?=
 =?us-ascii?Q?ENAU0pNqWgaC9p4Fd/d1xPKRQokYGl+l96b1cs310l2JmYAN9bRTV60u2Sm1?=
 =?us-ascii?Q?o6Ud8nk0H8J56PusIU16mKVScPYP9QpPpg7lYxFA8KQ6ZmAFj1kBpn4Dfweb?=
 =?us-ascii?Q?rHSgvseZf9utaoHhAZU2sat/6fKQ9xBy0mJ4efYyaQbe5DCFZUWLwS5Xlx1V?=
 =?us-ascii?Q?NRtCYXJlNw3CTCLDvO/fsJ52+NRoMV4eNunVrziHnH97bzjmDpnWuxsl+hS5?=
 =?us-ascii?Q?EytNxVlRAzgxluliSjLhhfLvNRMLUOjCLAC7ySPoGbgW9EJk87X56o4MkqLP?=
 =?us-ascii?Q?AAgBiSamAfyxNctlBzhV3XGuRHmpf58KVkb/iCrNp92dtC8q09uWa/K1GDk5?=
 =?us-ascii?Q?ntgOFgjTSKvWNAJ9pbjl+edxO86yy77WRc3twuTYmeNzy2gmPwcXt3cHHH1C?=
 =?us-ascii?Q?UPqjSO87zfO1JhflgF9qY7YT3TXB2t55I19Qhg/dEdDEM86OsMxqxDIvLaep?=
 =?us-ascii?Q?mjSFx1ewKGE1BWSDeOvsZG+AcjuEbzrjZ4r9zzgyZSwXoHBFJADEFq1GtioV?=
 =?us-ascii?Q?L9xQ98gSO7/roe5jv8lVWgP+1+hUJXufYrr4BvkuZPuSsVx4TC4kfgilb6ib?=
 =?us-ascii?Q?yhQthBf+gMy/rvTHGbY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:22:10.2294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 191d287f-3b54-4642-99cf-08de3359a867
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678

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

For objects that weren't already parsed, use odb_read_object_info() to
query the object type. If it's a blob, just insert it into the oidset
without parsing it. This improves performance for very large pack files
significantly:

 $ time ~/git/git/git-rev-list --objects --all --exclude-promisor-objects --quiet
 ________________________________________________________
 Executed in  118.76 secs    fish           external
    usr time   50.88 secs   11.02 millis   50.87 secs
    sys time   36.31 secs    0.08 millis   36.31 secs

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
 packfile.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/packfile.c b/packfile.c
index 9cc11b6dc5..563fd14f0e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2309,6 +2309,17 @@ static int add_promisor_object(const struct object_id *oid,
 	if (obj && obj->parsed) {
 		we_parsed_object = 0;
 	} else {
+		/*
+		 * Blobs don't reference other objects, so skip parsing them
+		 * to save time.
+		 */
+		enum object_type type;
+		type = odb_read_object_info(pack->repo->objects, oid, NULL);
+		if (type == OBJ_BLOB) {
+			oidset_insert(set, oid);
+			return 0;
+		}
+
 		we_parsed_object = 1;
 		obj = parse_object(pack->repo, oid);
 	}
-- 
2.52.0

