Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23515E5DC
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768352855; cv=fail; b=cVmmmgY0tf+gnAE/EoOCYOFKTD7yHD2YnQcoQ9Ebu8amL+nmOtal28pWxEf1OvQ821AFyz77atDlb6arSl0vQ8JBidCEOVGk/m8Ao3k4oLTeNGPkjGV1TtRc9S34+TAOy8kgfK5aRZJgg/ZuRlOnUN2eVShp+9SoK3Zv8L+73uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768352855; c=relaxed/simple;
	bh=ji47zf4QqYcYYNtYXOoqp5vyLp5k0KWQ2vzsRShbPQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Agx1HBWm1Wjg0cg+1/4mQ5eeiwzKX/DKVZwnBcDWhz9TtD2+s3YtAe3ipkEp935DCN+NukNsHvFVBr51tHmBQj/ObVzp9xlt6FT2e5TTbo373g+LHa5961DAKDgICgNbOStr+FWzkTXvzm81YPP1Y/O7SKP7egms2KEC2t8996M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cExWgI8F; arc=fail smtp.client-ip=52.101.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cExWgI8F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqkLSQNsSOzOS+CadtwTfDYA+NkGbDJHzCry1lK+UHYPFWgC40FS2y5QxIC6+Sys2iUSeQs7m9SHfMOFDSYhr7I01uZt7olL9GnF+mpaP7Ia4pXWQ7qrX7+2e/P/bOZqQr0xVs5IC7pyG3eJ7TOSG7dYN4bYJ9V2j9vzrvxs+kvJGbwQDvSAVKQSIsFlgV7iH34q8wSNmQI1wxqhoL6yxhM0pC4edp5S7ctjVdeXvSMzEbTJXdc+7GHJcjTwqJJDq5bxHLThlXGnZvUa2lSJ0peE+RNRG2U3z8R+DjIdgR4Oil1dj9jI/RQdKzRoVbBCzYobEWwcnjfl02Ntnk1jqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP3AptLllbzSv86/6InmYmNmpM3hGjaJwB+CnsMVdoQ=;
 b=QbmUPltkrCBqbPXK+XAOng5ZOqs84Ot5g665mSMOHGkawexEFuuudkAVTX1xsmBiqS9xfT+sLxD9KCtKQbCg1VQ1CqdBXRE6H6j0KpDkE0PEjYyouwECf75hJ73tciEUVdurQdaCt3upiRstiOJzW1FyMDcqQzquvypGODTKGbqJ8CiNey9mQJR5bRyHVTtGYhyuUWph9llHpIN5va0F2v1TLg288cgfW3311Vz2sQqF1DsE7ueHPwwKSEajEK3NhGJaNZzRuvdkC+PBVhYcZVsYZmguFWfuW8RmSFHlaGLQWubnDzffymfq5dwqM9J8iniHp8Ir9mnq03iPQVwZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OP3AptLllbzSv86/6InmYmNmpM3hGjaJwB+CnsMVdoQ=;
 b=cExWgI8FB5cksidZ93OjD3fLYDKqNQu6ncwdEM5KhbB+DT05R2l56YPfrSL5wkIEiDEs5LWzK4pAN52SXDHzj+ORjZhaCLaRqxYaZHNVbn+97wr6hURQJgItn/SGMmoGjQYAONW0J1jrlmBpbYChB3hxzeVXLIBcnzhkBMU9gHEQbDmhVYoiHD+EuD5eUB963tcEDX5+6xtCpMkX0IlT4k1mQfwLohSXcjQLz2iT0aUVcS4zJdL3GLpPGQo33ZLu4l10WslqEgC2NQd/tlFhpRHKZkGARuxcODXQZiCfkxLkeHf+mU/uD9hDCL3NRD2vxVnb1OUlYe4iMD0FhMjzzg==
Received: from SN1PR12CA0101.namprd12.prod.outlook.com (2603:10b6:802:21::36)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 01:07:28 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::2d) by SN1PR12CA0101.outlook.office365.com
 (2603:10b6:802:21::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.8 via Frontend Transport; Wed,
 14 Jan 2026 01:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 01:07:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 17:07:14 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 17:07:14 -0800
Received: from treble.com (10.127.8.12) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 13 Jan
 2026 17:07:13 -0800
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
CC: Aaron Plattner <aplattner@nvidia.com>, Patrick Steinhardt <ps@pks.im>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Lucas De Marchi
	<demarchi@kernel.org>
Subject: [PATCH v4] remote-curl: use auth for probe_rpc() requests too
Date: Tue, 13 Jan 2026 17:06:42 -0800
Message-ID: <20260114010642.594566-2-aplattner@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fa38d4-dcc8-4dcd-4487-08de53094965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FFj+90Nj3tgLw51a3GZrjwngNxeanDp3mu+IEBg0GeY7KTU5hu7P4BvQ60/U?=
 =?us-ascii?Q?4vOMs+wfmDRfwF1jndxDKO6E9ZPJDpsxNsD0Akhg3LT++GFQyh0WlnqHfAcm?=
 =?us-ascii?Q?4cww+YUXeXSGfV4ttfNrdEqNIXicC///bD5sku9dYw60i1AudSH+dK6XVKGc?=
 =?us-ascii?Q?yj+Zm516Hsi9bmGMpRCuKzoZGrr9jz0OvlGihAE5oS+RerZBoF2t86yZ+fuF?=
 =?us-ascii?Q?NSt7z3j4turTJyqNObuO3wkGdEZz6JrFeWV5gNdmlW7zNrZVQWDLjN1HFp7H?=
 =?us-ascii?Q?tbnl9VhPGw0fgGrxx1XdP3gv/AEJTMQaHAlx+BGD89HPfNYTDlkrdWIu4Ghr?=
 =?us-ascii?Q?uYIacKw3icm7zxX/xVlH/ZjADxdlgL0MvBPDVqN5WKiQH+o4W1cqi6KOP1mE?=
 =?us-ascii?Q?7XPBft88gpDA5dJApSkuPfiZNGj3njH+XH9Wr0gdkw+DCC9F3wWsJO4wfoDr?=
 =?us-ascii?Q?zPOvH5tk5ZnLQ4ouZAtYvHh7whwkg1HbtjlY4w9MtmHeMmRwqbI0S4cptR09?=
 =?us-ascii?Q?hnfborBzqQiWZDvBegNfFC0iQfi9Zgjyn1RKTiNFUtdcmaARLqNzDg+Ffxnx?=
 =?us-ascii?Q?s2QOuxHCLMH9bA1CKpKSNoUvdt+JEDAJx30IMOxTsZrmwlMTdbb+2CmL81GM?=
 =?us-ascii?Q?iTAzif2coOdW74s//34WLfC1g7O3icmyGSjkMXGjQXBU8oRRUeNMHNGPaa54?=
 =?us-ascii?Q?W8rclru1Woan4SZkhkxT4kgg6qdYyu7upJYkqVHDjR/qBzmg6DeysdkEx7Hc?=
 =?us-ascii?Q?miqMTHjWuydVb89J3ahBllNDZXLIlJ+6D0F5WU7ghiA6QCDU2aKM8hkZAuap?=
 =?us-ascii?Q?BHXP2iR+foLzmEycpjTgXjCY5KsizM5cuYZu06dln771ozRhypw7Mnvfa0ob?=
 =?us-ascii?Q?8DqPFjXrRozav6xhILVuDe0tY2mezuUhC7ke7JqImtLHyopENgjDGIFppLuN?=
 =?us-ascii?Q?o4R0eHzcRVQqaalpLS9vHdie3XilVmKL8ErN3UNPVc0Qf99r9lQfWXPJG6GE?=
 =?us-ascii?Q?Ct5t789QhKcsrPJAklJL2sA59lmmSZSM2JiJcVFKb9QNWDufDPjAJ9h4oMBQ?=
 =?us-ascii?Q?mCBqTB/T9fxuDLj1Y3g3/uMYMdNO3jlsZEl0mc/CDxWp6y2lQArP9kj1uFqx?=
 =?us-ascii?Q?p2jlZoV0pHzJuiDxI953ysCCXFWZLD+Izt/Kh+Urof2Jt/PWNEviTy5suq9D?=
 =?us-ascii?Q?nWPgJ1AOXbbnhoheZNEwWQtu3hTeC1Ul2ciHcQ7QgJHlkzYKw3kQN0u90XLz?=
 =?us-ascii?Q?cn4UnfqMK24W68A577+5MmF8E8/OE6uV4Idw2jYq/eaypjTVwCrayyIf+hXV?=
 =?us-ascii?Q?pMCgXPuUc8CjAl6DalrmLiFn5LmTSeuqjN2vNR2kUCjmWH156P+sIKRZ7AKX?=
 =?us-ascii?Q?7O88ZlngG7VMdj6X24gTNcOFbvP3dfEP+7dvm6zH6Sl+EIEhBKMhELW1EfC0?=
 =?us-ascii?Q?eJuQMa39ZaRUlEExmOrANgyIuOWeA8rpWQHzLR+UiQcsjyJI7Fx9i+Fh4Scl?=
 =?us-ascii?Q?koe/b5svCenvjIFV1n6Pq/ymOAHy1WrZDeicav33fVvJ1C+vA7Vcr8xWAHVQ?=
 =?us-ascii?Q?YOd9yP97dtzfo70NZig=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007)(7142099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 01:07:28.3012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fa38d4-dcc8-4dcd-4487-08de53094965
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220

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
v4: Style nitpicks, use xargs in case 2000 branches is too many for the command
line.

 remote-curl.c               |  1 +
 t/t5563-simple-http-auth.sh | 46 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

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
index c1febbae9d..551a1e22ab 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -605,6 +605,52 @@ test_expect_success 'access using bearer auth with invalid credentials' '
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
+		test_seq 2000 |
+		xargs printf "create refs/heads/branch-%d @\n" |
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

