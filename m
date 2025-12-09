Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D3214A9B
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244969; cv=fail; b=c+hNd4IBrPF6GbGp1GhP8McE0e/CugULXUe+OVhCIwCa92uQneLVc3FkJaRnnXHQZiufzz2VFRRKxuQPG2iAGvMeGHwwTKKwe4LVFiH2Jx1dzAP7QQhAJz1F2sMSTc9z5HInsaGAdDycVwB51UgS25IWNBiLnXBiGDg5sySGwk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244969; c=relaxed/simple;
	bh=6ttzovMtdmSW9TLL5/7NC9rAxaJovRI9mZBN7/4WcxA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XNHI/eWczU0OUMPtKMqldHwMqjvjnMyaXqBH5/CnaDLIoIAxIy65w5Ez+CT6k2l60T4gg9SFRMfI/yE+oAi6DuU+80CwI2Epd7a1f+1xMZN8hM9OrZRvMzdOffnQ6IbRnBq/WTlb3ALPHaml01zvGqL21eZs09WxiLf5aIfBC4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Je6vvaf/; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Je6vvaf/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaGfY9nXIhKSUX3wpAvQfgiZ1buPPuT+eHAUZ/GpgoVymaUM0BSnu8uan7JrJsO+YUca7isld3+6I5Cz93Bfi1RHHBms2npXnxwx5ksbslz2TwA/Bn4S8Qsv1aoE2LJ2Gf6iDd73VAT4CoT+0R+q40lfoEVqadXG8F+ovYjYs0A0wPqsI4AUwYX51C6RXDpbmoiL/ztGYXW33EhhESiFoDXgCSDC2BDTdKpPv0pgzaX3aILQlnYCIticgZmUpw4KaavEofPeRda1ROpf8YjV6iwrTf2AqzeuhpTPU8uMUz8ygavxlmwRoOmyi+qlej7iclDGTceD/e5FFB1GXEWNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+36mfYtH4XxqOtV6KVg+n/oyAZkIOjOb+rts6M5XKg=;
 b=jMZru2J3TjS8IrHaxgmlU+JFfRw0gOxAw1yFHBwImNZgpJW3qTcGkJVOsrsivAeXkK/eNm17Xbc/c2V2deiW3WGlNEbLOgnKCROlRixFytr6FpcPjg1zH7t9ZN0lD79MB3MXtmYLI86SOwNuxHm8Td+m5x8tjX8UQN80u7I5nIKH5uloyY59+16mtOYoPKXrSkLJ02iB+U+Tzerb6BKHmvaYZIPdp4z2vErzzVJaAQWzQGShk8N6EkXIOCJnLPqP2j62mnAdlA1avBp2/9VZxPBf8CnQSRjXHImmoupsLQTLnuATFUI2pbjXP8YQlMtVRHbePp3YN25cobrFehMEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+36mfYtH4XxqOtV6KVg+n/oyAZkIOjOb+rts6M5XKg=;
 b=Je6vvaf/m7GUjje5WaYko59TBC12yolDoTvMv4S995xQ6zJ3TfHQ6UfbUy7tze/pfW9qZnus31CitduhTzrJwZGQ7jUPwYg51CM7dGu2aHFptG+6Pxr0cpQ3M2FT+yVhxcVl0eVSVXc42Co2Xoe3XdO6sg6eGdm71S6IViKF3cd0ybXeu2tk/3qnIj5SYYnWFckG0BhUDHhvCn50/kgWM+V9qm3yWB1hrO6NLc9J6cXW8cjLxDEP8fgW6goJU8zjXYDeEqbcnQT0wkEWOltXK+m5WgqSWjjID9BMw7bUA6rObjJnpflrtc5tpJ5yHvVpt+TEUpCSYTcCnz6Q8Upk3A==
Received: from SJ0PR03CA0076.namprd03.prod.outlook.com (2603:10b6:a03:331::21)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.14; Tue, 9 Dec 2025 01:49:25 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::39) by SJ0PR03CA0076.outlook.office365.com
 (2603:10b6:a03:331::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 01:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 01:49:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 17:49:14 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Dec 2025 17:49:14 -0800
Received: from treble.plattner.fun (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 17:49:14 -0800
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 0/2] improve --exclude-promisor-objects performance
Date: Mon, 8 Dec 2025 17:48:55 -0800
Message-ID: <20251209014900.402637-1-aplattner@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e3e31d-2bc0-45ba-17dd-08de36c52e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fYhci0fs0SPoYFAMwe2QCgn+aLjdU7dXQOOaWHrFxNIzF9veEu16LvJ6+cKn?=
 =?us-ascii?Q?7hBFKC3lUrFeyB5cNSFUZYi63QX62Q99on0nhIsuLuUoAnbFqu3JlTUz+nhn?=
 =?us-ascii?Q?6CXopjrt63qrSNTyOgJbIicgxnpSBQdryKYjHJDP7QWcLsHQ8nURBNymQwZr?=
 =?us-ascii?Q?dZiuFkG3wa+VXH2D0gAYH0v8ODvbUybF1SqhzA6+H1qVycMfXTejq2UnZ56o?=
 =?us-ascii?Q?j7UWtq862RUbsPPSDyrGC0jbKafF1gfvwE7lKT64DA+myxsJCL7IIzoH+VDG?=
 =?us-ascii?Q?hZTip7dc9PW4bfAZ0LVVTRsKzkR7T1tmFP0KL6LWhPkaWHhpYU9DPggsYPtP?=
 =?us-ascii?Q?Y78eg2KXodHjucUDBiD65PcIKdK3ybJ72XkdvdgS42z9V29Y0TBUeeGjJWsG?=
 =?us-ascii?Q?iT06AO5BPnOJBqbG4JlDagusg/eWssDHShkyPpmrb7l3uQqdDykMVYRQzbqy?=
 =?us-ascii?Q?bYv9UzvC4WEEekoRiExAdrNWOoH+d27J2mWbRAOWH1JTMUdUC/Id/NLMZx5J?=
 =?us-ascii?Q?RnRR8priVklNq2Lv8ysTVlq9eHseH3Vo7bVNv+9kMIdi2Fc4iPMLiol33UXO?=
 =?us-ascii?Q?rb4IeFohnU0PT7GYObNEXjGIeaYPyB8pQS4fgpsrZ7vN1T5I9em7H8Qw8FMw?=
 =?us-ascii?Q?jkzVGJTYcsuqlH5P2qnK7CUublchZl8ESZsWzHGwAzScgv8nEkiZZIFatzP1?=
 =?us-ascii?Q?0gfb1bSjhRdu53UV1sJVAMy6ZZeW0GLrVjCMMTn43iLtiULMpj/0Ywdd4xqm?=
 =?us-ascii?Q?wOR2TV2ysKEmMcl5v+tmPvCvBXKGZcxT0wufUohu3LDw3bomT9fTgfAM8Hbs?=
 =?us-ascii?Q?tgfLZyVpwSMCLSeU4T54IO1gQyWMwwBa9BPMIa/FIKmT/OtFnY9IMkoCdZSh?=
 =?us-ascii?Q?cRUACwqUu5KElrj6KXvnMzWUnv/ol1p5K1py6QViI9mG2yi54Tx5EqZZVeYv?=
 =?us-ascii?Q?BCiXCymwIWK6uYFSZO9BpjObfItBX0GPbUkqBAaj8U9z5VJ48hiyhH7F856R?=
 =?us-ascii?Q?/fqdxLiAeESUDQ/BKLqWe8F9kUuwANwECxhrcYEx1hReOj1e5rVJpfhpik0z?=
 =?us-ascii?Q?GvB+DoYQe3krWWUOrr1t5hGdJDvgv/SrAQDs4CYAcPgnrynzrBAXxPVOEeqW?=
 =?us-ascii?Q?6OuVntxXIP3PDwwztVYiQrQZEKVcmWlHklo7shRnWC7HaZo8NVU4ov8lo9gn?=
 =?us-ascii?Q?Vaunss22uiSMXflBoMDZ0J7tAPSxvsdLXpQ2BrQ4nf+Z5w23AKqvEcDMb4A/?=
 =?us-ascii?Q?Vb3dxgQ6PfTFXTDn9UsfJv4FFLCvOUE3mrMsP6+Gs9+nrG48AGShgONYC3Ya?=
 =?us-ascii?Q?GVc2Ckgshefg0Gg640BawVBjj88qKYbYlXLy+RUbvnEhNsnCN1KE06gvRgVI?=
 =?us-ascii?Q?8CIHF2k8A1/M+iw1HQhv1imWrDHHU8U16slGcB5CMst/W/XUXb7OkDCxLEXL?=
 =?us-ascii?Q?xWkrfqa/P9cVfc49CIerlSLjGQ3IYEWzdKxVWwuGNreb5tC53hMGvl7By04x?=
 =?us-ascii?Q?N8mg/PSd2W763vIvPyCl8NKSyUWOCbi59XnADZG1gqfcCuJTxsefzXxzEuUl?=
 =?us-ascii?Q?bwxdEZ4jx67s3jkBjyM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 01:49:25.0266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e3e31d-2bc0-45ba-17dd-08de36c52e8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084

This series fixes the PARSE_OBJECT_SKIP_HASH_CHECK optimization in
parse_object_with_flags() so that it applies to objects with their type set to
OBJ_NONE too, and then uses that behavior significantly improve the performance
of add_promisor_object().

Aaron Plattner (2):
  object: apply skip_hash and discard_tree optimizations to unknown
    blobs too
  packfile: skip hash checks in add_promisor_object()

 object.c   | 4 ++--
 packfile.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.52.0

