Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6B35CB8D
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768288839; cv=fail; b=gbnGpXJdsuHwczS7E1B1HsDaiU4m4sK7Fuz8925Pkku+SjAAyiHrj+isMT3saNJZ6AmPfm29aVqD1dxKaQqA+7FlBKbOkTMtb8uGAIBSrYos+7zYSajAzWkQxHjWV0FdpiGYlPJRLK6W0rQG9Eu+5P537Wvz9n/5LRI+nyCQh1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768288839; c=relaxed/simple;
	bh=eyxhQXAwFDsca1PP/wlQEMhDMLbBzL8LeldIHUW3HUY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gATAPntm4skoh66RGI+s6KHPHUwNU6qwNr6a6CHNuEevsEIF+gH4y3qwkJx0BrtoE+YtMwAdjolB91As7rJNk7tDr/qw/jTh1h4MXScG78j5Oxr77X8YrIDqZ4XRV3wlFYY1pmWRR/0dCK8/MHr6ldT3pbhWjNFkeJgj0m9CHuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b3i10icP; arc=fail smtp.client-ip=52.101.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b3i10icP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kN2t/pHD+xsuphjw6EDKt/Ml3WbQ2fORnq0QxIr0TZFoA2NRojskAvpjAglWrpiTUi7AJ+EGi+c/Vl/O3ONgb1wvr/0BO/AFsftfoVH+BFBDb0BzEuHY5YSEzAD7oHKShVn+Xc5NxK8Lz0g7/Pt710u+xAu/rXf8vNOwuqrbfTgJ75smMS0DrHulH5PQCV2DYBHixZRmoSXQ4VcPnUYkSwf+J0hOSlBKOwHOfiytCcye9vJnujD7OgXj+35EeDYdnwdbwuevmN3Lp285DW/dhNfVlSm1ro8EIfafhjvk9vJXKIUrsmBNrEJC2fITxnSKcGXguj/+bEPNDnPr/1Wumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHG+BfRhYIXE8A4ht9p/NtRYfQRFsUgihjEOzveXgc8=;
 b=bmS/qTr8rsUOv1S/aol6IxW17QgUZuJtWnBxMa2HbImJQj8hxu9ICOHlxfZBR8Ls2++G+bkl++wXnV266imjOKJ11e4yOt+l5T+367PyYI4VumY7WlB5Vawt0o8SvhGjrG9UP3m5wsIZZVqIkADefnGi/X2FbMiFMIQUNYGms+5rry0W2R9fP/aHaT26aXzN5VPRk8m/D0NlnLpc6ju9JDOl7vUkHKPsy9+vNKhsdRRfrw0IE0tHN2a2laSSm7qA7bPHCggbUE2oQr7e5RcBWhM3eYkTOKZzY9qM2fnfEtIe8MCu7dy5C1FjPjk6KHX7CwU90SZHeRS6B0ImAPJU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHG+BfRhYIXE8A4ht9p/NtRYfQRFsUgihjEOzveXgc8=;
 b=b3i10icP6LWL/6g36yVE72fjXUFOb3jM7VGmTkemn5P6j+oDLOdMb8ievprqw/ALPOdr6pJeXi+Enr3B3S+BqrUFrC5Q5LPGu8DvjhuyZErI7D7NkuR54wMXvs4vLSzrgAH8PSLEaS3QoMAOkRoYRcfMBTsKSYEt24K5JehSQ0X3gtju1BSzOZ54eKM5fc9ZjI5qNnzjTRtgHFyE9bNzzxpRQ7aG4HvPfkGXH8KEuDnfdtopsXA9R83QNuq2FhWpieiZfGOelOx+aeC13qysfyUpFt5ls0ycSosXJzdPM5keJ3AQ1kqMGCA13Tw0t8i1R5q6HhjYmqPfYevs8Eloww==
Received: from BL1PR13CA0261.namprd13.prod.outlook.com (2603:10b6:208:2ba::26)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 07:20:33 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::3) by BL1PR13CA0261.outlook.office365.com
 (2603:10b6:208:2ba::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 07:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 07:20:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 23:20:16 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 23:20:16 -0800
Received: from treble.plattner.fun (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 23:20:15 -0800
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>, Patrick Steinhardt <ps@pks.im>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Lucas De Marchi
	<demarchi@kernel.org>
Subject: [PATCH v3] remote-curl: Use auth for probe_rpc() requests too
Date: Mon, 12 Jan 2026 23:20:12 -0800
Message-ID: <20260113072013.3775439-1-aplattner@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 207c3866-d9dc-4064-9f88-08de52743d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7142099003|18082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EOQ7BgCtINJiIji4soD7QToo2MbbUPrh6aYp40gFIbJrOysnwXl0UYGM0FQh?=
 =?us-ascii?Q?ItbeWo/yTt1lLlsz+TH93aP3kEPRflBFblXGeNizGX6TaAaxbVkuOnVdlk5R?=
 =?us-ascii?Q?GOfDN43i5FhKfI2oaoMYFLVrXPkUxU3FGURd+M2ZzmcWI1gwIPgCQs7n0bpN?=
 =?us-ascii?Q?+0QvypUFVAJp2dxcbwHOARyRhOx0RQpV6UXUIgBdyaVFQLPP6KQD2BhaHR2s?=
 =?us-ascii?Q?FPXmthOLELVxtbPJi/ifIHT8c0cDCv1RgBGe/5iKpd0OmAi7//NpEicegifT?=
 =?us-ascii?Q?QVPow9+KsbRBYASwnZovb4qViaEqAzka4jWA2UvdIMOXlB9wVhKkz2g+JVMh?=
 =?us-ascii?Q?pMQJuTVO6c33TI6KpCL1TGlxn2F4n+qhfJax5DF7nMv5yiRWttxZmp1OQaEp?=
 =?us-ascii?Q?LlcDe7qeEtAVQlMaCk1Qhh+4jBLemFEm4d787kmsgHYNot737Vy2h8Cgy1sf?=
 =?us-ascii?Q?Y759CSbgYBkCU1KRyqWxmO724hVc1oD5Ohpkr66ye56VauYVahxHLFcKhLdU?=
 =?us-ascii?Q?JcuC7EL+z5KgWGnoSq2BhJvKyPQ8EX6I9NInc9f1Tf0LgBqTZagxEgR57gJG?=
 =?us-ascii?Q?O42xc/3ZkeHenwQDf+2fNKrA93oEC5HvqmYmf7jEQkOrpxxUpyGqPcewwBgx?=
 =?us-ascii?Q?a28qM/ShDH2Na/gYvDlAmin+iB4KflovEEii+xSMnhsB1DTe7mrzFWjBlIYO?=
 =?us-ascii?Q?/DcZpKyynqjkSJNvGE0HiHM878fwuRC4iEykWq/KGeh0wYE+efH3jeS4Zph/?=
 =?us-ascii?Q?WHH9zqgXRjPNS/Wt2a3tRvH6kOW/YMK1jIq74hEnKhIHi63N1iDGc+ZuRdUV?=
 =?us-ascii?Q?MLE3PWcjiiCbTabz0tP9GtgZP8rAOo5nI+Y6EbGbsnU7b5V4l8hcWm1MgsAa?=
 =?us-ascii?Q?90Wlvr8tydvuIYU+12mxW57ACwHDbQttYjyYHa+qjEQP4NRB212WkYKG7o8Z?=
 =?us-ascii?Q?dVdJDr8/T9lN2gXn8omg3VFIPv7xCLOpSiXmLrcvawBuHiTOstxf2cJhN+YO?=
 =?us-ascii?Q?6ET2JpRd5B9TWCy9uPgUb8SSP8wusD6o/GeZIVz4t2loyKL2znVdWmp5B/un?=
 =?us-ascii?Q?dglVOU9ByP8QOhfyd1ZeyEHQq91RX5te5ueycSdexRMKXlFoBTmphFe6hJw1?=
 =?us-ascii?Q?N9zWPMbfBg/NtWy3EvDMDLpJIMCZz4sJwxxKM3V0ag/vjtJJ7jlGFPkKgG6g?=
 =?us-ascii?Q?9tDEDgki72vIUhD74OVFMdtSJgtdUWyAswcXpg4PGene1Hr1LJ/pwQ148NoM?=
 =?us-ascii?Q?BCiD1/S/2ekXmRnT2Z/e/c4VS6Lb9k5tOXKL/Ra9IhHNy6L3LAx/VPCLJkfj?=
 =?us-ascii?Q?nnccYcoGBXHhqGLWYDCV2CrTxVkriabrSh2UZ0cnvaVyXrHOzYTDd9z+ydTA?=
 =?us-ascii?Q?vEm5S5XlADt9WzV2o8i5dTbcl6NasTSvIa8pC/49w9f0tr4XpFEImvJeHmhE?=
 =?us-ascii?Q?wMdv2tyYcBrMtmZafiCYcXYPRpL6+y/9s0MOroa2+9TRMvxHN+ppfYsQXLNy?=
 =?us-ascii?Q?4wpBPAScD1hLGnyy7GorgH6tvhEuZLL2yEWev+BThQzQih3ZFS9Lt4CbtJnH?=
 =?us-ascii?Q?fKa6n1H3Dl8EalnwpMo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7142099003)(18082099003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:20:32.9115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 207c3866-d9dc-4064-9f88-08de52743d45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

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

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
Tested-by: Lucas De Marchi <demarchi@kernel.org>
---
v3: Combine the setup and test into a single subtest, use test_when_finished to
remove large.git.

Those are both good suggestions, thanks Patrick.

I contemplated leaving large.git around since normally it gets cleaned up when
the "trash directory.t5563-simple-http-auth" directory is removed, but it's 16
MB so it's a bit big to leave around even in debug mode.

 remote-curl.c               |  2 ++
 t/t5563-simple-http-auth.sh | 45 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/remote-curl.c b/remote-curl.c
index 69f919454a..1d0ae72521 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -877,6 +877,8 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
 
+	headers = http_append_auth_header(&http_auth, headers);
+
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index c1febbae9d..eb41295f25 100755
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
+		printf "create refs/heads/branch-%d @\n" $(test_seq 2000) |
+		    git update-ref --stdin
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

