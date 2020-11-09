Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD17BC4741F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 08:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B2720702
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 08:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="gMmNkSam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgKIIeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 03:34:08 -0500
Received: from mail-eopbgr00139.outbound.protection.outlook.com ([40.107.0.139]:21712
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726176AbgKIIeH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 03:34:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/5vSmyULsUj1TW/dGcQUO9zs0m6S70SD3MCiUqNF+r5aF8TS5iJsuSiD18RirPWdvgMQNhX/D5+bkR3H7AuLXidW/vRwgDIWlxfVCacorSh/NY2ZSmk43b62RyBcVV80QtxzDptpfbh9w2/q5iJzX+AKxBWiRE6qSzuADX3JB4+xlgt0pgbr1lbgyMwPAL6NdRWMh9pc2i+8kJWes6ogmFZ5H37QOlrVZuzn6dcspKIC2i24yjNzdG9TbNoENlyNyjqAmUnXQCUy/bDhJhABEq5dcQMBid5EJzOWtGSk3Ycn1gjAEAGwqk/QbuAFSzbfrTruSYnpGfhaLgR+LjFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2PNQMWoGDCdC8a4IVFsznFXLFlFHgGAN3t8JLnPn4A=;
 b=YFpX4hQVXUHrErteeqgBz6baCETr2HwbVnE/3fAVf04BrAAE4FKH36nGjhrvXxDW/0O2jKOoQt26/lKg6FCpmD3+uJbo6AXTfyuY3bYl517YHJKlfHTzUItaFWWlJigEFEZ7fYgJk0RfQ+eI11U9/Fv9c37yvHEKoPBACue8r/vBSX3VhYZmMS6okr3WwI+Z1cMAOto/v6AxPZH9OhuLDpTO2urS+MWjjCiCJv266qojct7BVcp6Kcop6cY5vyjjTEigPiaWPttvAmpfEsRXi1MCc76N+6QpMpyKZI7/lxseeWizoI7b2hyStHiwTLhXLuZ26UhrOn+rdb8IT7/54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 131.228.6.101) smtp.rcpttodomain=google.com smtp.mailfrom=nokia.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2PNQMWoGDCdC8a4IVFsznFXLFlFHgGAN3t8JLnPn4A=;
 b=gMmNkSamhQhrKK3RA/9eEyLRdG9tqHKMuPbzHSREMc6MHkgQ6mIUyZFKPJD4xYhJ+lAAQlYNqv0AYChZKEa5DnDkVPF+AZLKtvGg0Z4uJvBXDV5BEn3XczaBGfAai8cbG1xZ/8c7UjrAMBomek2yOwnsnXrk9XA4bNJJ8chgMuY=
Received: from AM6P195CA0005.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::18)
 by AM6PR07MB5623.eurprd07.prod.outlook.com (2603:10a6:20b:81::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Mon, 9 Nov
 2020 08:34:04 +0000
Received: from VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:81:cafe::c1) by AM6P195CA0005.outlook.office365.com
 (2603:10a6:209:81::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Mon, 9 Nov 2020 08:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 131.228.6.101) smtp.mailfrom=nokia.com; google.com; dkim=none (message not
 signed) header.d=none;google.com; dmarc=fail action=none
 header.from=nokia.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 nokia.com discourages use of 131.228.6.101 as permitted sender)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 VE1EUR03FT025.mail.protection.outlook.com (10.152.18.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.17 via Frontend Transport; Mon, 9 Nov 2020 08:34:02 +0000
Received: from ulegcpbofur.emea.nsn-net.net (ulegcpbofur.emea.nsn-net.net [10.151.74.147])
        by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 0A98XxLn030528;
        Mon, 9 Nov 2020 08:34:00 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Cc:     peter.kaestle@nokia.com
Subject: [RFC 2/2] Revert "submodule.c: fetch in submodules git directory instead of in worktree"
Date:   Mon,  9 Nov 2020 09:33:49 +0100
Message-Id: <1604910829-49109-3-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1604910829-49109-1-git-send-email-peter.kaestle@nokia.com>
References: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
 <1604910829-49109-1-git-send-email-peter.kaestle@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c1286101-cd60-4462-4be6-08d8848a365d
X-MS-TrafficTypeDiagnostic: AM6PR07MB5623:
X-Microsoft-Antispam-PRVS: <AM6PR07MB5623CD2D9575E67A2D2BA185EEEA0@AM6PR07MB5623.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJKvyWYok8aZxqg4pUpxQ4p9BkZU8jbM0SrWYKxzpsrO29K/OLo3EvzSAWDO8Adha0O4shJpsJsbgjJlewYg0OCjgqj8FZ4WK6MmMQsAnx/n8aBE24da/H5elsBsValrCdhwa5lAKtlXq7Y7CsKEr4JoDlJcWg/4toyGDntfUydfYRbwRturs4GD5cnaS/7PAGbjlWYaCNNtbGq4pjIwSdo/s8kCtzAY/aXuX9oUrq5JniWHQm6nhUZQhzJEkF5i5z0fh4FjBQQddhDczOjGmow2AlNiambfoNNrExLGic4nCBdN90PJhvrdWtpjQorqupvBBjTEcAaHJ6yEVB/kVTi2LIDdWQ9LwfTNWQGAVMBD0N3gNvIJqdGqz0I+XdoVh65mHmxhlKhi0mta7BEseA==
X-Forefront-Antispam-Report: CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966005)(83380400001)(36756003)(70206006)(26005)(2906002)(36906005)(2616005)(5660300002)(110136005)(82740400003)(316002)(8676002)(336012)(44832011)(86362001)(82310400003)(81166007)(6666004)(186003)(478600001)(70586007)(107886003)(8936002)(4326008)(356005)(47076004);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 08:34:02.4452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1286101-cd60-4462-4be6-08d8848a365d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB5623
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit a62387b3fc9f5aeeb04a2db278121d33a9caafa7 and sets
the "fetching a superproject containing an uninitialized sub/sub
project" testcase to expect success.

Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
---
 submodule.c                 | 14 ++++----------
 t/t5526-fetch-submodules.sh |  2 +-
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/submodule.c b/submodule.c
index b3bb59f..eef5204e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -499,12 +499,6 @@ void prepare_submodule_repo_env(struct strvec *out)
 		     DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
-static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
-{
-	prepare_submodule_repo_env_no_git_dir(out);
-	strvec_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
-}
-
 /*
  * Initialize a repository struct for a submodule based on the provided 'path'.
  *
@@ -1455,8 +1449,8 @@ static int get_next_submodule(struct child_process *cp,
 		if (task->repo) {
 			struct strbuf submodule_prefix = STRBUF_INIT;
 			child_process_init(cp);
-			cp->dir = task->repo->gitdir;
-			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+			cp->dir = task->repo->worktree;
+			prepare_submodule_repo_env(&cp->env_array);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
@@ -1505,9 +1499,9 @@ static int get_next_submodule(struct child_process *cp,
 			    spf->prefix, task->sub->path);
 
 		child_process_init(cp);
-		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+		prepare_submodule_repo_env(&cp->env_array);
 		cp->git_cmd = 1;
-		cp->dir = task->repo->gitdir;
+		cp->dir = task->repo->worktree;
 
 		strvec_init(&cp->args);
 		strvec_pushv(&cp->args, spf->args.v);
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 9fbd481..236e26a 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -729,7 +729,7 @@ add_commit_push()
 	git -C "$dir" push
 }
 
-test_expect_failure 'fetching a superproject containing an uninitialized sub/sub project' '
+test_expect_success 'fetching a superproject containing an uninitialized sub/sub project' '
 	# does not depend on any previous test setups
 
 	for repo in outer middle inner
-- 
2.6.2

