Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08764C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F8422280
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="FXDV0cNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgKCOYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:24:13 -0500
Received: from mail-eopbgr60105.outbound.protection.outlook.com ([40.107.6.105]:29101
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729539AbgKCOXo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 09:23:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds8SW/fxEjjA8WI1sOczax9oGv9pyWEhH+zwoHyehXyLQNq/J3melCRhgHj5ZRiDVV9eDl8p6g6ahVEfhT8zBOTG97HZkfYk2H90EAh3kfelJZTz8Sl2eM802LiN4hO9zqMYAlPe2g926EMBO7IttT4EVtsevHdjg8f7YsSxd9ICe/oRTYyUYV17/CjR3HtShN5YrpNQMnC+9Dn8awE1fvk03HS8kpKCsT9OUdkS8/CIT0SC6VwoEvSlbzIRNkHj0RxN6jLNMsPD8JcdPkHFmgXshbE5jqftQjy271w9xpEPnRgF8meLcyq8gzMdTDTsprPh5tRQyKdcI+/JOQYNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2PNQMWoGDCdC8a4IVFsznFXLFlFHgGAN3t8JLnPn4A=;
 b=InMcw8mmnSsrA0DRD3vS8wmVzMTSKaUvINN1E9A5eqCPxrAXxCuBH6pAUV4vNTC5swGRTC1F/SR2xG4UTHBd6MvvcIt9ySFtnCIyL3WrTOupmlXfuKzaajZ2wRnrfa77RaHy3V0AoZm5d8qH8SeIFDJe1Dq2vuNEzqjrJO2u+lx95gZtOtcZNpUezaGzMUxpnFPKVeObUfZlAkVLzWBpWdQaZTNK+FFYp/FmlddBF8zyREw4RGDmXDo5ZVtmiT9dafIcyOugD3RpBxaJOSqwMLWwY+jAGrMcOKp7hHdbjHS6mInl3u3x1f+0eJYrIgQo4gUcZUc2WuJOCj9fO1I3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 131.228.6.101) smtp.rcpttodomain=google.com smtp.mailfrom=nokia.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2PNQMWoGDCdC8a4IVFsznFXLFlFHgGAN3t8JLnPn4A=;
 b=FXDV0cNJSk6HnJzMs1UlU9Jj32Pnmx9T6+xMx23KxTKD9KR/IBC9yl/a9fgreocJtpIxuRIyrXp3RDQN81EUTX94WttY4PMNBMy41cMf2MAM97HfRrwLk+mm0KR57nQQfMD9k55JfL4i5gAMZfLcoD/7ZEEZROD+v4caq6EFy4o=
Received: from MR2P264CA0039.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::27) by
 AM8PR07MB7634.eurprd07.prod.outlook.com (2603:10a6:20b:24d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.10; Tue, 3 Nov 2020 14:23:42 +0000
Received: from VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:0:cafe::ae) by MR2P264CA0039.outlook.office365.com
 (2603:10a6:500::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 3 Nov 2020 14:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 131.228.6.101) smtp.mailfrom=nokia.com; google.com; dkim=none (message not
 signed) header.d=none;google.com; dmarc=fail action=none
 header.from=nokia.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 nokia.com discourages use of 131.228.6.101 as permitted sender)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 VE1EUR03FT011.mail.protection.outlook.com (10.152.18.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.15 via Frontend Transport; Tue, 3 Nov 2020 14:23:41 +0000
Received: from ulegcpbofur.emea.nsn-net.net (ulegcpbofur.emea.nsn-net.net [10.151.74.147])
        by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 0A3ENbo8005363;
        Tue, 3 Nov 2020 14:23:38 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Cc:     peter.kaestle@nokia.com
Subject: [REGRESSION FIX 2/2] Revert "submodule.c: fetch in submodules git directory instead of in worktree"
Date:   Tue,  3 Nov 2020 15:23:19 +0100
Message-Id: <1604413399-63090-3-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
References: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 382141dc-428c-4ce5-47e7-08d880041098
X-MS-TrafficTypeDiagnostic: AM8PR07MB7634:
X-Microsoft-Antispam-PRVS: <AM8PR07MB76342EB50F6B1A3011B2FE65EE110@AM8PR07MB7634.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcZOktR1esJTMHzPk76iolwWfoNR0mkheNz1SKUnNNIxcYRMyEyl+AAXwyBTtBGTgE87mnNCfNp7XGff6HovYgut85zZMkpY6ywggk80N01LXHO8BcwZ6LknMHHWtPyeXIVdav0t76tLMCLPwtj4qRa1v6OZOmg1h5ZjH7Ab34uNtPySxjfw6d/OgJBSmnuEmEBE0JWr7G3BvxJZZVuZvZToQcq2Wbxs1lno0jK86w4sl7rk/CSbiTRilp3v/bLYVogI5q6vSk4ZWzSigZJww21F95TPeidx+ehuzveapjn5IgTdZ3n8VCLmlNWcS5Q6zlhX5wLXZIdtSPmF52XNXV64BwTnpBx2+pXTJkgQRRoiSxwagVgZylIv/Ed/cALXy5+1sF6ULUg6tjAghx1nqg==
X-Forefront-Antispam-Report: CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966005)(478600001)(44832011)(110136005)(82310400003)(2906002)(36906005)(83380400001)(316002)(2616005)(6666004)(336012)(82740400003)(81166007)(26005)(4326008)(107886003)(47076004)(36756003)(70206006)(186003)(356005)(8936002)(8676002)(86362001)(70586007)(5660300002);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 14:23:41.8635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 382141dc-428c-4ce5-47e7-08d880041098
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7634
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

