Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228951B81CA
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768274423; cv=fail; b=qquQsJJn90j2Noawgza7NDfeZ+SEVdx1NG7HS9d3kXtOxBiX41AbXduOJpgil7m3XzEbipBbhFahhSD6nvwy5k07SOFkU8P4+dGaIOh3T71FzsJQn679DXOuIdlF5Phv95Rqks4mHAa2IoqE5OGx6fQiDev6+6Cj8SlFFzinzP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768274423; c=relaxed/simple;
	bh=bpQXD0Yfs1/OAQGERQOYjca1lZaEqkoR+Zh4MrLeFEc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T60FKrbHEi0RQXC0xh2rSyx1Fs5pBHYnAY/xL6dF0NW6mRwyuxmf7tm6opV0ZGY+QUU9lXEK8PB5otFhr4f17uYw1fa3H5krMtQcM4hijxJu4OW+JHBoVX38lHrvamjwcDpZ9Flok8CZj2QDkKuVymXijb4duiBzurmdSDrnC34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bk5IcDVv; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bk5IcDVv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yk1iQOG+8dHuaQHGzEyUYFgknxiszY6TkaLOesTn2H8T60Xicsjk45iIE3N6q7Cn83uheZyiLICxUACf/1irNAYcf+6sTetWgZggoMURhBaVbqwsjlGLlBm11d7ylH9YZR97VHPCbyCJUQUilVH9zODLZz/W5zSujypnvOLoL9ZQFkhue025pKLaPWsKrDnh1BrWZBIU1/4Sh+QIe7pAVh5V/HVI3ruijaSYRikyfdlPZ3oW5yrTBeBGB+3CGNMuZkDt1GNWWN3Pwg1eA1qflzJIUFhrUeat3kq83TZSiuEEFV9s7PYiCw7vQx+TiWJBFYJ3usPfxsFaJt80+m4GTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgn0KqRRV8I5evL15SeDsld4oXq6wh6W9F1UK52ENmA=;
 b=ocRwOMIyEdC7pI9PvnKIzTtY6GqrpDmhR14y8NoFaiA3FyZlprnUqRyxwiBFt1ndV9uAuq5AGI+Gdu+/fetHOLSeAMOyR8ks9xExLq6+p0kT/NaXTyHgWsM+/m5/yRpj/RbGtYhripHt3ifWO4xcc2ruceECm7Cz5AmMNAHizTEC8iqyBZecDsei46xTFvWE7SHew4ShDblzNUBELJO8mFb88udvcvnO3qg/JlvaJdHW8co/l5miGKyrcbqv0tVJVgTLIDbnB+pYsY6pDWVNN13zoQ1uqOtXS4y6nba8SGJYQ9lzxtZYzKigU0/aEPGRESbhnXyWki6nDggraqtJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cgn0KqRRV8I5evL15SeDsld4oXq6wh6W9F1UK52ENmA=;
 b=bk5IcDVv9Y9dKYDXNTm+miirFNtG8ShMEk/juUpZC7tMhPHltSxSjjWTtEhjyAQ2fQE/NIWZdzzK2osbIFSi8wEYIUw8ONf0IVkifDGOBkmruNmv2HLrFrszmhyAFFcA527RGMFlKG86abhfbvjoUAfdSQ2kdkrxw8WJoG057XbGrnSNQl6SBOsKA2NWISrFHlv3fS8BjtaStp5/dUErXZPtFEyCkcXOd1UPlkEoqrSuyPdNil2PGNOMQn/SXgmxa9cvknQScyZGwfxlvfvDCknYv7T7Lpg443/c/JhgvDZau/7NltJqrdwWtrlJXm5veMojY1zTMdl0DnNfM8bZ4Q==
Received: from PH8P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::13)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 03:20:15 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::9d) by PH8P221CA0017.outlook.office365.com
 (2603:10b6:510:2d8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 03:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 03:20:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 19:19:41 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 12 Jan 2026 19:19:40 -0800
Received: from treble.com (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 19:19:40 -0800
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>, Patrick Steinhardt <ps@pks.im>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Lucas De Marchi
	<demarchi@kernel.org>
Subject: [PATCH v2] remote-curl: Use auth for probe_rpc() requests too
Date: Mon, 12 Jan 2026 19:19:28 -0800
Message-ID: <20260113031929.3746753-1-aplattner@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 670b1661-6917-4e51-b42b-08de5252ab20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7142099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ebJZQV8W41pgkYVuvSE7eF0lvTqsjoLUMcISwhSHqymrheDuezHq7VpZd9ql?=
 =?us-ascii?Q?5c2SyduUq+1UnkoSRH4+4j7XfJgpHmZivpqhSPVj9iF+b9HfREkZN3tkiDO9?=
 =?us-ascii?Q?W6f1HF9oeFY/YLS/0sSjIHEVzLGyMWnrWXpKxsszwdkEaIMdRbf90nmkRpu4?=
 =?us-ascii?Q?3s2Q0KMpYtWEdZwSXiJNPtuyC1eHhltkui+lAf0CuaDZ5MViJfJkgZbsCKJK?=
 =?us-ascii?Q?vAok+kmaS5xDjxOFMzxUB4R9ElSJ8xPyCULwiHRElOqDwdcTSimSKESlW8yh?=
 =?us-ascii?Q?fXX+teqxP9n1Q0UU7t1v+aAYwTwe8K6Vc5tMuaVA1qxxOoMCnmPEb0XTzm3V?=
 =?us-ascii?Q?40+0mt6s1nWfDOuYWpysuG8wD8VBZPIu9086JL3mwLFRz6YmE5dgDsSpGY0y?=
 =?us-ascii?Q?MtjMGnGE8Y4+W7qBMfyxpTr+Dkwskpvn2EP2cwrqWd12S6KfnTXpMB+TdA6Q?=
 =?us-ascii?Q?AdduyAeGM6Bvq0ovWBB0978YIflX5rqcno4OBEaVxCCug2N5CGIGum7TeN9P?=
 =?us-ascii?Q?jKWltISlEfMyCNi8VSzZOC3ahn5Gl1NmqZH1LxY7eHfMRHcoZD26GUxpwS4r?=
 =?us-ascii?Q?Yi6zEais3268jpBYaFxy1PCsJ9qi1dCCpqVHtdjc7gBmAU63mTiSN7wz3ro1?=
 =?us-ascii?Q?lawG79KKJNA403rXFLck+Vq/z4+qVSPKrNA0lFcyv9/vnnVOcY4HHhbjySZZ?=
 =?us-ascii?Q?sEFNggtYEiAWpzFULTnhZDRKW8ToAzW/US8iA6z0Rwza0jC/eNh7wZHUWPov?=
 =?us-ascii?Q?4iy1K1vca+ykI65jd4CxCeGoy1LCtHjAg0kjybZxPAYWn4i4EZRhsc6mnxLh?=
 =?us-ascii?Q?yEjNk0H/fwvq6IYD2cIM6T0jWta2OneLxexcORlx3qgElLJbj58yRSK36yj4?=
 =?us-ascii?Q?kDwJUVYYnl2UTy+yuK+kPtHucyzP9lYAv0V0hqfEcscgnVwfhgvhrIF9COhP?=
 =?us-ascii?Q?4M9Y5I0aG5foAZ0MX+QKsTdWaPJQqyF0nrp4zjOszD1Iq00ZPnTpXahRLP/w?=
 =?us-ascii?Q?YRQApdPZku0Rtk+6W19CQG0Dqp8DBblo/vi3cjcR/NOgHfXX5KoXNxWFAvF9?=
 =?us-ascii?Q?zQVRQBoBDr1wny5wPYhcLX0NClt7ZJeDvAx+01I83og+ljNQNNji9SQBen7z?=
 =?us-ascii?Q?nlhZAOw822dAz7Qsh70Dvjz6iR4tK/vxMeWeFJYU2LrWZOwh1Xb7F9ycSQMC?=
 =?us-ascii?Q?9kQa5XjcKR1KDVhS7lCeheU7cs8Sc2fal167D0Gp1ulpJj1dHxMhy4JtbF48?=
 =?us-ascii?Q?z67Dv0I6yS3ghvEaoJPJbyfc4pTKPieELbFfvTBeYP/XQirjba2lEFTS3IjR?=
 =?us-ascii?Q?rJ2olcPMJgGTj66dQ9Xx82Q92a2jTtExKk91u6l/H1q2YfVzjswmJ5tnUQqF?=
 =?us-ascii?Q?p9+ZU44kppPmg8nvAzeqCFuh7UgnhOT3od3JZVSTmQlKoMm7qoxOGWkf9pzN?=
 =?us-ascii?Q?EHB4bNzqW7uo/IHKaAB6MFaT6DfUBRJZg2BzTMlXYkciax4Xhs0CGsvEi8Ed?=
 =?us-ascii?Q?ApGH5LPkA+Rk90/8p5xDrxmbrFvEveADddXu4FK4DInzRJbwitFIY9QIoQw5?=
 =?us-ascii?Q?1avLGGXilKrn9pwn5Es=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7142099003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:20:12.5790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 670b1661-6917-4e51-b42b-08de5252ab20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

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
v2: Update commit description to clarify why HTTP_REAUTH doesn't help here, and
add a test to verify the fix.

 remote-curl.c               |  2 ++
 t/t5563-simple-http-auth.sh | 46 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

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
index c1febbae9d..adc210cdd3 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -63,6 +63,26 @@ test_expect_success 'setup repository' '
 	git push --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
 '
 
+test_expect_success 'setup large repository for probe_rpc testing' '
+	rm -rf large.git &&
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
+	rm -rf large.git
+'
+
 test_expect_success 'access using basic auth' '
 	test_when_finished "per_test_cleanup" &&
 
@@ -605,6 +625,32 @@ test_expect_success 'access using bearer auth with invalid credentials' '
 	EOF
 '
 
+test_expect_success 'clone with bearer auth and probe_rpc' '
+	test_when_finished "per_test_cleanup" &&
+
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

