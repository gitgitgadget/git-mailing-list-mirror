Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB9262FDD
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987081; cv=fail; b=Mqar9yztu6IgfiJsRAYHBL8os+eu30BIQykscr/q8rie8XFZCMcafJfB6+lReLFfCPj6oFMfJu28+SodNAebJ8LeTeooP0lkVxlK4R+MP/rl8XPUHJaYfz/Xo1VJd740HrdqPqw7SDf0hFWJHkO3vVmjK3IWVUc/86sJ1HMaxX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987081; c=relaxed/simple;
	bh=tAnSLljOFzywbaWK12lE71UePdzuW27q+0rrtvNIYnU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ebPiePBDNITwROgIVRoaxD0JMBrzBT8UqIejoQaZHOTNa2BHoKegIvEFHnr3+0Ars8equwKjueRzND7d/BLOl0Ol2Tz3eOb8AMFl4z85cuDgY9MnmyXXZHWpHUMb6RZSYWSbUFNCFF2sOcH+dZ8hYxxied4sUNAONDuZiVqHIjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L/9eI6kP; arc=fail smtp.client-ip=52.101.48.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L/9eI6kP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSmFgCt5X6LfbvVfKkKZjR1EhPU74Y5p0Z/2wbOkxO9xPWMkaUDracMKaYbbN6+4SzLzJkv+nqT6XV9FQopK5pccDg9hpUzwfdqE3Iszx7/3IK9RfaAxYqLclH6zv3o4yFNGp1onxCHNGcGEpv3sHkejNHyEb01GJiHIZuyDUv7y0P3ZBxqdZ+Ifp2GONI66HH/c0AQ8gLECm/+LM6ch7XIb/T7KDuYkjSvRNKZVzkLpWOH/30WJ8DLBaSw4zyur4qbJxj65fI7rrQEWg22c+2jRDi5y3yuMNFszVoSoJeUZAMH0s/+XmR4VU6jTVenzCrrhBFfe6jHbIjqLtHTfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jD0n3xTP6/fswNKtt4Th/LAMbW8eiVejtNTcIU12HKY=;
 b=b+9d+hGJfwMD8gAaRPcK2ZQzRGapP5oDY8JRuIhZmpssQZt2xnfUoSioJWW0NJqi07oMhe34Q4Ofup4WokbSOm1tBMwKw+gIU+xBa52NkILbwQR95tBjHzTvcoT5BD5t5ab1SyPSj+FljrWIu8RLvWk9jKk1VlxZ1PWXTOk+S+hohh+hV8MsSQYzV7HtmPBC/NOi0loqbV8daA8Qp1FJVzOmZMEJ/B3LVYqtfiirCPN5cWDLEyRA+iOnzwpNosJK2tZkSRw//uYCHuDKJIEsojvYorqE0u2up0I3BVT1MFubrfLeigQM/vYwDkspv5pycnFWesFCPUFx3TM2uhOcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jD0n3xTP6/fswNKtt4Th/LAMbW8eiVejtNTcIU12HKY=;
 b=L/9eI6kPE1gvFLu9AlzmPBEPs4cnUprfKgUT8PpUceIpbtnl/Sao5/c7SMwPFGlWCGSgD3zxiQpRxZBwweReWjF27vprFTk0PhPNnIKTIBHvDD1gWEJqmo0goxdu6VjenZ/8lyG9P5ouj5yHBgfUsROfXJ/WiBhzKsMwwquvNcWenZnaaz9r2ZGQRX8mi5DkmmA+p0b7qpwJ8IOwdVe7+uxLpKV1oR7lOGfzEGUVJJwJ2Xcwp5si3PmNh5jPYqRIc8Yf77xp4qwZtHSsiGWPYEHw/dwjr+n8+qHKh4MrinrtCDFvIk2UyMFhJm5RkF0fysZ6JxcG/2j4KVkD457Z4Q==
Received: from PH7PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:33d::27)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 22:37:54 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::f2) by PH7PR02CA0008.outlook.office365.com
 (2603:10b6:510:33d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 22:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 22:37:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 14:37:42 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 14:37:41 -0800
Received: from treble.plattner.fun (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 14:37:41 -0800
From: Aaron Plattner <aplattner@nvidia.com>
To: <git@vger.kernel.org>
CC: Aaron Plattner <aplattner@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
Subject: [PATCH] remote-curl: Use auth for probe_rpc() requests too
Date: Wed, 12 Nov 2025 14:37:18 -0800
Message-ID: <20251112223722.376330-1-aplattner@nvidia.com>
X-Mailer: git-send-email 2.51.2
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: ad60bca7-05c2-4888-4668-08de223c1ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GXdLDVi0qQhnG2cNBQsPs/HjaVj/zBOELmC8VhUR1VDzWIOu/t9n3/foMufu?=
 =?us-ascii?Q?2zqVtkY5P7StBzWLBSFzMH9WiRJvXYHPgcZL6CNfGOgjPR8YZEyQV9ZEvdLY?=
 =?us-ascii?Q?gKPQ5zgRafahqBmrDo3hu+C793QY+rOcDWjvWDWbRkC6r3IAxChof5eF5wQr?=
 =?us-ascii?Q?EMEiSvRRpD5GKBE4aAwzaLLAE9vpzdel6EkaVgJn495OcEEUKwSDsX1w7Amb?=
 =?us-ascii?Q?rBm0r/YenL+4QE9KxGrAWMQ8ebxx6nIJYbXy3OBq3TdcNURvG5P21nG+KcQY?=
 =?us-ascii?Q?ZYAspiM2Bpig2YBhkjind4p9nbskC0y3HdpJWT9T0gQd7Whv2gdtSx/RywzW?=
 =?us-ascii?Q?dCLbhc61Dh1fLJdiYzsnBnx4KcMa5ryfR8K2TrdhcWwMSich+2kN6upzrhZx?=
 =?us-ascii?Q?7U9RICfd32o7DIjgyEjCKdVyh/jlIkyeGpabBKfV0XZjs3ECROdNl4D40NsR?=
 =?us-ascii?Q?5L3EK+Veo/aCEY+/7gxKSxF0+pD2SFpSbIiaMgAk2Zb+AwmVEXC+ZtBT/7ir?=
 =?us-ascii?Q?Tx6MOxlvwyOM/gbBG09vTFvv/Q7bxc0vvi1P5hkFI0KRc3hUy9AzaDzOmja2?=
 =?us-ascii?Q?HgE0o0CUsZsoOX9vPkO5uA9B9rFkhgeG9lx97TxMDRIaPFyxoNm02O8r9Iiz?=
 =?us-ascii?Q?rIaQ8hPF1FCfL37rm21gP5EQErCU8zzlL/NU5nZVAa28KiYINM7ppSBtyT0L?=
 =?us-ascii?Q?LvPxL7pz33Qt/Jlzk4PurOXaZmgn4yn+uJ2/2aR1r3e/UqwfSrAP9/D6gHBJ?=
 =?us-ascii?Q?dFbI9ZB+kli1jH5sBOSfCYxwzZE/8vkz//xg6S2MWTYBZbtQwIbn7CV7DLP3?=
 =?us-ascii?Q?t2Ly3/Ksu4uMutZReVDZvC23iia/qzq0qLZrUXgx2NaK4OTG9EKY+L5x6WtD?=
 =?us-ascii?Q?pd+zNYyxzdBwoLrXXVrfFEnJW3vgc4QDd0f3frn/SonvUnAmfdtpAt7NuQxj?=
 =?us-ascii?Q?snSGNJoPtqtBsjQQ+V1sMFVa/ETuva5jqIZ4LL3YRZ5IRvS7SJ26UiORmiNg?=
 =?us-ascii?Q?I5JL5+wqypTIN1qlfc2kUhVmos+uPFVIa0815i8gohJ+zgULKUl4mlWw28Iz?=
 =?us-ascii?Q?5z4ZMx9oM49JWHqv0qHsyOQUVQo5vzCnnZbwJrWGDqN9CT89dCgDlbuuA/Oe?=
 =?us-ascii?Q?eC13+WTaKHS4FoubfI1RGHISt89WwgXVCwGX5uaUW+cZMU7F8ghQKwUqVlLk?=
 =?us-ascii?Q?QFD3aBTAKySyRbBVWCrHjDvyuu03MaVd/cHYk3KyoOOTs88QBc6v3Eza/TML?=
 =?us-ascii?Q?kX4+XnQhmoNjaRXGuc0yBghFRyqUEnauv5XshwF8V00eteDGqkKLK8ElzDSG?=
 =?us-ascii?Q?YAOAg1Bv0K7Pwv/pLY/ZunWU77aB4iYDuWjiUpsEuYyWpe3W6Xx6x8QmJw3l?=
 =?us-ascii?Q?fPY1beoozEN6hxzEnzvm6OJN0gYGaEe4ssv4QpW2R72ddNS4nHD3bpekXXnH?=
 =?us-ascii?Q?B3gGpXw3oPRsYosjA5kVUGae3+kahdOjkLc2+fGA1RsTPQhGoJEGrEWcyuzD?=
 =?us-ascii?Q?qi5SMRaoIfJMvW37O6AbzOei3M+2ZL0F1YuiKxsTBWt4ak9zsJ/jQSWJnZfm?=
 =?us-ascii?Q?H5afYYsBc4WdqRCeUn8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 22:37:54.4737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad60bca7-05c2-4888-4668-08de223c1ef2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398

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

Fix the immediate problem by including the authorization headers in the
probe_rpc() request as well.

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
Link: [1] https://github.com/Binary-Eater/git-credential-msal
---
If http_auth.multistage were set in this scenario, then probe_rpc() would have
returned HTTP_REAUTH and this would have probably worked by generating a new
Bearer token. And we might need to use HTTP_REAUTH to handle the case where the
token expires between the initial request and this one, but I don't think
tackling that in this patch makes sense since the original Bearer token was
still valid and git just didn't try using it. And setting multistage (the
'continue' parameter in git-credential(1)) doesn't make sense for Bearer tokens
since the token comes from an external agent.

 remote-curl.c | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.51.2

