Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD33009F4
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 01:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244975; cv=fail; b=UWKlb2kXSAnQCKvnKXMUMD5Z1rtEYmNEAFMrWUNXxqSG+/tlC7cOaoucAbTmB+UHmaBgcViEZ1Kqvt9TyZ1WgG4uuFFPNqaSmeYBjlb9nSqDdATEGpzvt9zOPzgvLaEN2UbgA0+vpiQg0RN9I4K/d+L7dugUNcGe2q3lSHFQBJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244975; c=relaxed/simple;
	bh=LojatzUOqA3e1UbCxAKM+wDABsHYYF532o7KpsfoHlQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DT30u/zZajCHtOkCvCEagnB3DidFC8m6QE4Hy1VWDwsPYHK/qjBNai1Q7C6XHG49bPyAD+1hncJGeZaAsgtAX5XLYqsCFyifCc9PwcIW+ZmfhehFUI5OGgg8xX2f94P6JWiwmsE/s8V4GpFNUcEL++e0g6v0oFHOSREpqmgLMiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BA+40UW5; arc=fail smtp.client-ip=52.101.62.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BA+40UW5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xe4aPw+wa8pFFWTO9M2qK8km/u1FMmIOl/BPtrOfkqApy4yFyjDarLjhnRNZgku5RW001ip8R3J95sSiNMnZOu1DF+s2mub+Pi0wD6C5fx3vA67rGsHqeQHgIVb1hTQmU/gaIqvvEdXbnYURRAziWXKOnf5o7jUqR3Q74x2THOuAwAJandjx4i2blEmAi1eOr/nNH2zbWfyKipWmYG+QsLTeLcDwPGpUnQT79mthuD3KFU70A9SHDrH1gOFk/pJe7x1ZiCmsP2fes750TqBYqjCC9nZzqHyXCYpYfNYCQN25fWDfV1aMMmQUkr6uT+HJWREUE3W2UTlhMCa6j1qipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMZlh0sTxvdWzUU0PzehSOUPo7ZCFhtSHZPdgISvh1U=;
 b=aBVkvubsup7qtojj5olJmbpZFdHv84sCJ8ZL+9ZzxRgycJpSkEa/rt02bNlUmf1Z8tWwU1gmspTZLc8nth/4AO27yGYCQg670iP+Jw+roXHD+FOMCBein6ezevtNLLg9ndbmnv4dG8636jJt1tIqVX2M+PBc1E2oQx+U0geR8lX03fz2QKlrwDY1NycNV+XlUk4zfCukFgomJq1D+8eIl+oFVQABMNucOJUOGchvLhukVSRlK+EJ2bHCA4O32zqZuc1Mgz76itzj/QxZxrxuxmxHVCBf8zQXX3sW5npWMjdwQw1CZqTCEDYdfEWGzLSih+rIdR9v8FK0tEiS9h9sZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMZlh0sTxvdWzUU0PzehSOUPo7ZCFhtSHZPdgISvh1U=;
 b=BA+40UW5wIY4lJwshdlOFgtz0bYWXPuSnRd3ogBC9t/IOcv1i9Rd38ZHviTNN51cjazb7x4qiOWxLZQxtUO4mU1JRUh7gECEnUnIOxG0GE4ckWMd1cZ1ufRI5DpIsgKaRZccIQQXPoBiiJCErfumuBUHNnviNHgteThnH7GGfiJAHMDrGUYvGPFHBuxgzy2yU1z2vfnuFfjra5dAb2hDQW7XUQ72hkulLyRItvtqv22rp/8f0XRKLHJWCzG9ARNNhZv6To8nme1emr17I93yAuLjPIFAKriL5V4/EiTfV0KdEZwk/X9UKIbfeCt5dHLNq8SKNftHdiRyKRBI6EXYCw==
Received: from SJ0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:a03:331::6)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 01:49:27 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::cc) by SJ0PR03CA0061.outlook.office365.com
 (2603:10b6:a03:331::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 01:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 01:49:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 17:49:16 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Dec 2025 17:49:15 -0800
Received: from treble.plattner.fun (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 17:49:15 -0800
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 2/2] packfile: skip hash checks in add_promisor_object()
Date: Mon, 8 Dec 2025 17:48:57 -0800
Message-ID: <20251209014900.402637-3-aplattner@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f387a5d-f7e3-43ee-03c2-08de36c52fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CGW5+HJeDo4kbdmCs1rryLQ5YnrIPWtqALJ9dtDziGrtU/xTdSNJ6ZsKZteb?=
 =?us-ascii?Q?Yl18qqEZhysPzJdN5W25/0vl7uf4n1FO8zE0cvQTz3i67uLkCeLLQcXXDJx6?=
 =?us-ascii?Q?xoCYB5SaFje3SNrANCGbcPhCH2A1UqVlTmLk9U+8uz+RRchFLUSXgOxRZGWA?=
 =?us-ascii?Q?rNqrVDXDfmx8CSAou371fSYDeet/1jK1hvuGAZvAt9lD49d36hk8gvSqFqwM?=
 =?us-ascii?Q?W9XjsSTRegDJXNy2IeeIp30/iHho4fE2Q38Ndw/vJ+VkeF2kd7z3dOyf1jr+?=
 =?us-ascii?Q?vkxyQxEPHY2s1qXN4ulpbIeGRAstWEekeRsk12UBBeXLkw6X/uYAbdys3wxZ?=
 =?us-ascii?Q?2X9SxUsStyUnBUKXTqxrkhl2/LgyITZLkB+PH4DojPbJiOaMyxOuWqd/tNs6?=
 =?us-ascii?Q?NByKMc3cljN2eeoRcn1kvTNRritYmfYCyCtcIynqZiT3beToCake/myEPE5R?=
 =?us-ascii?Q?9qKIzHi/IPaz4G9PxIJqo0q8ZdK8YLichvtYC0lcQYApy0BToURJx1nQmm9j?=
 =?us-ascii?Q?3N98AHfEtvGfBW6d8Fj3hkGVAZ3SEyKw5X/4br3G9QYU82LLwiC7hb2sqZ56?=
 =?us-ascii?Q?fgdjVhawPwZHSfFq2bSZWc8mCs3EysOtuwnqLz1Y1Q0ZJxjHyFWJuPzp1loH?=
 =?us-ascii?Q?Cp53cyPdR+5Vtyh/Js6xRK5T6MtDFzcnpBB3AdNC1+VXgVBphl0ybsG5qqTa?=
 =?us-ascii?Q?4TFAdgwv6JBgN9TMEpCx9m9TFY7jOakhGV3bxNL7VaRWdNENFMQRDuzcu6eY?=
 =?us-ascii?Q?J0lY23zyKIY7F1OebOe6Ywa/uI6ce7O+2qHaqMrrUbj+vrRKj0r6RA4P/Gh/?=
 =?us-ascii?Q?AmufXnZKDkIOHeh/1dLTQJZ66aEBkPFnl6TnHtomfVKWZVcFKTTurwvF6Y6X?=
 =?us-ascii?Q?Yun+SUzG5qedZ5fgo8D5/Ge3fws0+EfWJH5GGdmZDcHXgmJ69EKzWH6fv17F?=
 =?us-ascii?Q?vtmeU6nYKyvgEKkhaR28lt7XrsnrKzHSrLy+K/96efL7iGtTV0LmLw5jmQ7h?=
 =?us-ascii?Q?xuV49jFEA+LW/PCMCjLI9RxanfMRsXmJHG8L5p6krH4ZejkFnvNWs6ZybPyR?=
 =?us-ascii?Q?aIhOEJqS8QktLU7cfGe3my+KUEni+oI5RWImP1e0X1kOpPrKvwlH0Ag/zyNp?=
 =?us-ascii?Q?ogyA1kit28QKzS/Ycmurr/dwhIZ6KyyW+QC23j9pB2qTDQtY7J044mPyhD1O?=
 =?us-ascii?Q?RKHqUYLcpSD/YEv8rmmWcYrcILhLV5+kezUkS/cD1xTmqk4G6y066/6kuFcz?=
 =?us-ascii?Q?ZUi9/K5TL2ytcFs4y5N7DEh20XgPQ+rbf+AytQcXhRJaJ4KDEeu37+k+m2DL?=
 =?us-ascii?Q?lpNTKcfLbxWUYPs+5w6GbV3+vzTEEr3afQ5z7btvFxHcr5vyFyJbnbabJhiO?=
 =?us-ascii?Q?RyV1PAE+3dU7nzot/88IONRYHnUIf6xpd1ECv7TjsbHuJPHsNqr73tyf6DTE?=
 =?us-ascii?Q?mPsIJN5X3HWDQSJ6fulsaYjaHWQRcW4xcQBuvquy35dDQmJ+KeIrvM6ZjwUK?=
 =?us-ascii?Q?16+Iz6xHqAGTo0NHlI6+s998JqwGR5ib5KeK6egI+X4rmZ/3VhSraMzZaUWh?=
 =?us-ascii?Q?vl0IA8zta3m7HvzfWFI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 01:49:27.2053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f387a5d-f7e3-43ee-03c2-08de36c52fd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698

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

add_promisor_object() just wants to construct the set of all promisor
objects, so it doesn't really need to verify the hash of every object.
Set PARSE_OBJECT_SKIP_HASH_CHECK to skip the hash check. This has the
side effect of skipping decompression of blob objects completely, saving
a significant amount of time:

 $ time ~/git/git/git-rev-list --objects --all --exclude-promisor-objects --quiet
 ________________________________________________________
 Executed in  124.70 secs    fish           external
    usr time   46.94 secs    0.00 millis   46.94 secs
    sys time   43.11 secs    1.03 millis   43.11 secs

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
 packfile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 3d8b994a61..d3014b6746 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2295,7 +2295,8 @@ static int add_promisor_object(const struct object_id *oid,
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

