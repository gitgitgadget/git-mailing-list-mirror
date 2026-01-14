Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D953A1E63
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408712; cv=fail; b=G5Bf/4RyJjLspfv9a91KQ2nBdw05Huay/Jy0FSR1770NGL8hTxy3nBXqYKHCHNKypdHOT/14W93Sw781zfivfB+J53SqrKhLNjtbs9GUP4x0nZlIwJAkshKlrHkPuD+YbQbahQnMiS774Vr1SJmWDkYSX8YxQPz0NOsZFGJHAS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408712; c=relaxed/simple;
	bh=tr0infDp/pmhGS0Qoe1DoVDRk/j0Glopwjx6YbHFWl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MTd/3mmaD2MpioTQ18db0ddTi+7yL2/46PrFSOAVu31SCYEVpOuW1QT3VPjfI5kATwgdnCdITIdi1YKmGc49uTByvrixE3xi79s/lP2Qjff7/R0BGmW9dLoWFuMdI/43bvTYa0hUayrt1b0ctNJpDLL0yUBS4wCVDEq0u8DEYOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V6QtGO10; arc=fail smtp.client-ip=52.101.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V6QtGO10"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZJI65h9NcPObbjOx7coNl5iV7H8I6y2L43n1IKpMJXrNtMRzxHT0Abig050NKvPAd+aJPoNAA2HbddCj6euKdLrTdBHkNf0ngAPU8byPPsj1k+rEnPWPMhdQ/VbTx3CQloVgLrMcQI5Q0Qv0cJikahYe9B7uiX4eFOv+3eiR9S35M6Z8s+x51u2AWMd1GzxOUq1+ldAQN8jjN5g8skXcXiv0kZWdpIDOCB7a8EDq7hPCvqr97XWjgDduOI6756ddHk4zwm8nSQ5kpOtiNfV3X8pZMjsBV9hnGicIDmq5fWADc8QQAQphzYFmOGJwpsQ8q14eauNf/dHod1irq2u0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giDLj7HdT3MdZaMCv+1mye9i9DN1cyDjdZJCJe1uBec=;
 b=pyhSuCmKvb0YuAlpl+a+p4N4z2M3DwI0lprL4BNR4zjkUX2dpCFSA9MAvwnJB7+S1II1kfVEyIeKCRUsqaitAiGg4LvZiz4dSXyaf6fiyyjd/PeR7pnXaAJIJubH/yoVOWT0y6YJxg/G7z1Q+UYHllJKYtWdneAYfV63pktLMikqVmhyZzYvVCZuf3O93amiJI2bytiBzEkauyj6C/8SMF7MUB6pmjPAkyA+TiT8eG4yD0ZdDJVA9NCuvw8K6m3+tX9QiMt/hznQ5pzPptA4w54ytxtRzk/wr6iY8dhuP4umPMMFVen4r3xVs+A7RVNTEkI1ys2bJK7gByeKXOzA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giDLj7HdT3MdZaMCv+1mye9i9DN1cyDjdZJCJe1uBec=;
 b=V6QtGO10XTcFVZqtfI3Eth33UyeKwjalHTdULZ8fQE9fA5DG+R+Bwc3cMygtsrUCjZ0RjkVdumnIOYof09neqwEfFIgHpdPiUpSoty1oJnGvThJIM4KA8JmJDVl3mzvlctarTutjgsxnEOUdm9uRTgVWNd2gzzyeyxx8hTnU/GtTqcQAqbYvqvaApjsh8Oxu9PbEVL4zWEtLElC0u0ML7nZQA2uG7CR2jhc8/4E4AKyta8D6DlPnSJey59tZrdE6CRunUDwOIgUHJ+zOreJUcMvswWkS5lXI9eJJkj6zpPtDOY34s1DeXmQd43KdW4Vg0GVfQyvKx22JPF73vsjadw==
Received: from MN2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:208:234::14)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:38:21 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::e3) by MN2PR16CA0045.outlook.office365.com
 (2603:10b6:208:234::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:38:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 08:37:45 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 14 Jan 2026 08:37:44 -0800
Received: from treble.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 14
 Jan 2026 08:37:43 -0800
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Jeff King
	<peff@peff.net>
CC: Aaron Plattner <aplattner@nvidia.com>, Patrick Steinhardt <ps@pks.im>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Lucas De Marchi <demarchi@kernel.org>
Subject: [PATCH v5] remote-curl: use auth for probe_rpc() requests too
Date: Wed, 14 Jan 2026 08:36:19 -0800
Message-ID: <20260114163619.614297-2-aplattner@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8627f3-b398-419d-9cf0-08de538b5426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f6cq6YeqaoTu7Kzvr04s+ulp/d7V8ms+5kfBDc3FYfPtn7VYDo14sTVYNrQE?=
 =?us-ascii?Q?n3ECwEWY9Eh+mOVn7FRQF0Xzn9bEWpzRFAfzTnBaK3M1/7Dx6L8xI7uvArtv?=
 =?us-ascii?Q?J9c5zNo7X9b64DpdSjI6HLW1ueb5ttxKHmCNoUR28SgkYSB+C7AIZrZqb6dn?=
 =?us-ascii?Q?2ueb99Nvm4u2X9LihS7Abx0F+tZVpJq452gjXfqH081xXbcStq6HMoSSH27e?=
 =?us-ascii?Q?fHxBUueaVFIFb2ynjymegWPKe6VJq+FSRFYVMHn2gLoLTfJe8J9Yl8Jr/DZz?=
 =?us-ascii?Q?7JEKEthuNY5cJ5KBRSFDRPaCZuZkqMNyKUa1PaBtCHDefduhMCXvapBWTC1G?=
 =?us-ascii?Q?5WnOJeRpmmlOk1s+JGWyuucnKP5A6ji9tRWMModdyFolhuDLyWMEDf5t+wkU?=
 =?us-ascii?Q?RoSHfq0UhPjtBZ7amDA1pQwy1HnVe8xOwLAoiBx2sIcPDQznrM/4Bnc3xcjT?=
 =?us-ascii?Q?lQ8MCnZHjto5yeA7NLElxgnpFPKEFqVSnFDwIO+617VJWP7UUpKSVpN0qmbh?=
 =?us-ascii?Q?xbfUvrIes+1duQfiobjgYBeG3ob1gnhF8ZHEBEooOCxNhrop559AW4yGmMlb?=
 =?us-ascii?Q?cfhVPmXFXUlZ73dO0D9zlDY/4AzueNV88h+HKpFC7uh1OKwWVpWLTcdpOVf1?=
 =?us-ascii?Q?5jqSoA9QShFAibjxeC+BTMPtD9jBfPBdKDsqIOZkX3fiSMLpEKr2k27AKY9X?=
 =?us-ascii?Q?RilndMWZAxSCKJZAq8Vq/ZWqoxdHnungWSogp0PIpkQoTlIqajKqyaGlwrUq?=
 =?us-ascii?Q?ufP0iiqyc3ZtnujtvcKjlJ2o0U5KaX78N8j2BcyjSyAC417tw4OaOf706BCe?=
 =?us-ascii?Q?+V56OAzXFnV2Zlvd530xs7jiUKG8USXJPRc3ZwAkUq6uRZMUrUltciRAgr0P?=
 =?us-ascii?Q?KsVG6PMADaN2Qf3u32LxOYPleLGjEdJaDeCyw4H5GXCeeAD2/Ykp4bldrley?=
 =?us-ascii?Q?Lfta/uoO7g4RR7hyCOq7VbU6h6cUJb13ltY18iODl1xZ2S/vSSgeXtjxu0jI?=
 =?us-ascii?Q?mHT5XpJpw3WQZd51RGwULK/11JDlz9EKRNhEMaPHWAuXk/cZi6EBHMwG1iOt?=
 =?us-ascii?Q?b3gsfBqeqK1LUJZ293jASi1qYgKgGWfUSC/nuIhksi45IsW8cWgQPqEH/pFA?=
 =?us-ascii?Q?smDK2153I2LfuRLOphAt0LMg4tqfZLdXk3WB9ZIS7gaFUFeO80SR9znFlmFq?=
 =?us-ascii?Q?4Z9rADaXo5Cxccoc/K8SUJpDYF9BoAR68fCnjECrWspDOmv/PKsH3rOrMEzd?=
 =?us-ascii?Q?5U/ZAAUAaGt4Mu0Xuco+VHOSrmNQ7PSPwH1671sqRPLfc3vS5Jp+H8xQNd4N?=
 =?us-ascii?Q?DfjOSnoDMlT8L/jNFZ//Fl5njUEZnhgf2kW1u3d+LGhlCXzDmSKni8oxF+S9?=
 =?us-ascii?Q?UNuB3OLbpUmuiXM1ex3oSMFrDqxr7bTdP4YzT0qKu/tqNB+yfM4c1s1K4kPR?=
 =?us-ascii?Q?NK3/mQOYrll8esVjlS0YwrtmhbBXZft7Wl6AUwc3F44sjT46ii0W5PBogTWA?=
 =?us-ascii?Q?2KBeCNjMumooXljtf91yx3jqt0r5g/H/NWVPfv6qfSd+sGXgp5xMRApluCEL?=
 =?us-ascii?Q?rz8xGmjT+rRFqEqaia1GgQEFwOTjS3VIOKGiDnmKqqZyn/a4TAFTWFUPZhNb?=
 =?us-ascii?Q?f9Gt/aRrJfw+YZGGuuZK2M2BN+Gb3FW/guFFo9uLpj3HaJDhwHnh8ftxZWp9?=
 =?us-ascii?Q?eW3qwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007)(7142099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:38:20.8715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8627f3-b398-419d-9cf0-08de538b5426
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459

If a large request requires post_rpc() to call probe_rpc(), the latter
does not use the authorization credentials used for other requests. If
this fails with an HTTP 401 error and http_auth.multistage isn't set,
then the whole request just fails.

For example, using git-credential-msal [1], the following attempt to clone a
large repository fails partway through because the initial request to download
the commit history and promisor packs succeeds, but the
subsequent request to download the blobs needed to construct the working
tree fails with a 401 error and the checkout fails.

(lines removed for brevity)

  git clone --filter=blob:none https://secure-server.example/repo
  11:03:26.855369 git.c:502               trace: built-in: git clone --filter=blob:none https://secure-server.example/repo
  Cloning into 'sw'...
  warning: templates not found in /home/aaron/share/git-core/templates
  11:03:26.857169 run-command.c:673       trace: run_command: git remote-https origin https://secure-server.example/repo
  11:03:27.012104 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
  11:03:27.049243 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
  11:03:27.049270 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
  11:03:27.053786 run-command.c:673       trace: run_command: 'git credential-msal get'
  11:03:27.952830 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
  11:03:27.952849 http.c:849              => Send header: Authorization: Bearer <redacted>
  11:03:27.995419 http.c:849              <= Recv header: HTTP/1.1 200 OK
  11:03:28.230039 http.c:890              == Info: Reusing existing https: connection with host secure-server.example
  11:03:28.230208 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
  11:03:28.230216 http.c:849              => Send header: Content-Type: application/x-git-upload-pack-request
  11:03:28.230221 http.c:849              => Send header: Authorization: Bearer <redacted>
  11:03:28.269085 http.c:849              <= Recv header: HTTP/1.1 200 OK
  11:03:28.684163 http.c:890              == Info: Reusing existing https: connection with host secure-server.example
  11:03:28.684379 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
  11:03:28.684391 http.c:849              => Send header: Accept: application/x-git-upload-pack-result
  11:03:28.684393 http.c:849              => Send header: Authorization: Bearer <redacted>
  11:03:28.869546 run-command.c:673       trace: run_command: git index-pack --stdin --fix-thin '--keep=fetch-pack 43856 on dgx-spark' --promisor
  11:06:39.861237 run-command.c:673       trace: run_command: git -c fetch.negotiationAlgorithm=noop fetch origin --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin
  11:06:39.865981 run-command.c:673       trace: run_command: git remote-https origin https://secure-server.example/repo
  11:06:39.868039 run-command.c:673       trace: run_command: git-remote-https origin https://secure-server.example/repo
  11:07:30.412575 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
  11:07:30.456285 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
  11:07:30.456318 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
  11:07:30.456439 run-command.c:673       trace: run_command: 'git credential-cache get'
  11:07:30.461266 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
  11:07:30.461282 http.c:849              => Send header: Authorization: Bearer <redacted>
  11:07:30.501628 http.c:849              <= Recv header: HTTP/1.1 200 OK
  11:07:34.725262 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
  11:07:34.725279 http.c:849              => Send header: Content-Type: application/x-git-upload-pack-request
  11:07:34.761407 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
  11:07:34.761443 http.c:890              == Info: Bearer authentication problem, ignoring.
  11:07:34.761453 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
  11:07:34.761509 http.c:890              == Info: The requested URL returned error: 401
  11:07:34.761530 http.c:890              == Info: closing connection #0
  11:07:34.761913 run-command.c:673       trace: run_command: 'git credential-cache erase'
  11:07:34.761927 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-cache erase' 'git credential-cache erase'
  11:07:34.768069 git.c:502               trace: built-in: git credential-cache erase
  11:07:34.768690 run-command.c:673       trace: run_command: 'git credential-msal erase'
  11:07:34.768713 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-msal erase' 'git credential-msal erase'
  11:07:34.772742 git.c:808               trace: exec: git-credential-msal erase
  11:07:34.772783 run-command.c:673       trace: run_command: git-credential-msal erase
  11:07:34.772819 run-command.c:765       trace: start_command: /usr/bin/git-credential-msal erase
  error: RPC failed; HTTP 401 curl 22 The requested URL returned error: 401
  fatal: unable to write request to remote: Broken pipe
  fatal: could not fetch c4fff0229c9be06ecf576356a4d39a8a755b8d81 from promisor remote
  warning: Clone succeeded, but checkout failed.
  You can inspect what was checked out with 'git status'
  and retry with 'git restore --source=HEAD :/'

In this case, the HTTP_REAUTH retry logic is not used because the
credential helper didn't set the 'continue' flag, so
http_auth.multistage is false and handle_curl_result() fails with
HTTP_NOAUTH instead.

Fix the immediate problem by including the authorization headers in the
probe_rpc() request as well.

Add a test for this scenario:

 1. Create a repository with two thousand refs.
 2. Clone that into the web root used by t5563-simple-http-auth.sh.
 3. Configure http.postBuffer to be very small in order to trigger the
    probe_rpc() path that fails.
 4. Clone using a valid Bearer token.

[1] https://github.com/Binary-Eater/git-credential-msal

Tested-by: Lucas De Marchi <demarchi@kernel.org>
Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
v5: use test_seq -f, reorder Tested-by vs Signed-off-by lines

 remote-curl.c               |  1 +
 t/t5563-simple-http-auth.sh | 45 +++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/remote-curl.c b/remote-curl.c
index 69f919454a..92e40bb682 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -876,6 +876,7 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
+	headers = http_append_auth_header(&http_auth, headers);
 
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index c1febbae9d..0063581615 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -605,6 +605,51 @@ test_expect_success 'access using bearer auth with invalid credentials' '
 	EOF
 '
 
+test_expect_success 'clone with bearer auth and probe_rpc' '
+	test_when_finished "per_test_cleanup" &&
+	test_when_finished "rm -rf large.git" &&
+
+	# Set up a repository large enough to trigger probe_rpc
+	git init large.git &&
+	(
+		cd large.git &&
+		git config set maintenance.auto false &&
+		git commit --allow-empty --message "initial" &&
+		# Create many refs to trigger probe_rpc, which is called when
+		# the request body is larger than http.postBuffer.
+		#
+		# In the test later, http.postBuffer is set to 70000. Each
+		# "want" line is ~45 bytes, so we need at least 70000/45 = ~1600
+		# refs
+		test_seq -f "create refs/heads/branch-%d @" 2000 |
+		git update-ref --stdin
+	) &&
+	git clone --bare large.git "$HTTPD_DOCUMENT_ROOT_PATH/large.git" &&
+
+	# Clone it through HTTP with a Bearer token
+	set_credential_reply get <<-EOF &&
+	capability[]=authtype
+	authtype=Bearer
+	credential=YS1naXQtdG9rZW4=
+	EOF
+
+	# Bearer token
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	id=1 creds=Bearer YS1naXQtdG9rZW4=
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	id=1 status=200
+	id=default response=WWW-Authenticate: Bearer authorize_uri="id.example.com"
+	EOF
+
+	# Set a small buffer to force probe_rpc to be called
+	# Must be > LARGE_PACKET_MAX (65520)
+	test_config_global http.postBuffer 70000 &&
+	test_config_global credential.helper test-helper &&
+	git clone "$HTTPD_URL/custom_auth/large.git" partial-auth-clone 2>clone-error
+'
+
 test_expect_success 'access using three-legged auth' '
 	test_when_finished "per_test_cleanup" &&
 
-- 
2.52.0

