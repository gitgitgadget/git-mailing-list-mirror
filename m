Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA14C636CB
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65AB613DA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhGOX3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhGOX3T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 19:29:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5177BC061767
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j186-20020a25d2c30000b029055ed6ffbea6so9873718ybg.14
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wS6wYXsXJOg3Yo6b2J3wujqVfHfRd2gSIngVFmoCgmU=;
        b=jBDIsN5/2CYTgWpcNtxAKBk/JxA7u32E6dk2Q4tO9I2KdZmfCEmhiR/fDbXhKiOZ7K
         dH1nOBMUrVvzP/b/2WJmOumAAH1ru8Ov9wa0YlnaIE3Oec+a5IuZmVbl3IvrOHEakAAW
         fYTe/1EOThivxXUHMkrin3eRxaGe0+uswzNSSwKSR4YHA1zi+bYC6Ntw0Zix+xsPsy3n
         qpS/opTpRpB2Y+K+EM7f7BO2S0+Pw9QYBp57duKFj+VT3r67doj6nIPAE/y/ylDqhepL
         IB6RVn8FtVAkJZBuep0xZOKPDUrT5KCgVEr/+LEOaypHBBIWGSuOOGLiHbpoXFV5LQe0
         PbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wS6wYXsXJOg3Yo6b2J3wujqVfHfRd2gSIngVFmoCgmU=;
        b=G1MOZohgAPCwuOFdR9QJPqzHjpDUE6Fgwp5pfGfHUrQKsVP+j0PLWNf8qGLWsLpLLN
         Pkrr2Qfmx2ajcuv6ionXsXoU7EjjezeSrMFAoD4Lr0pNPGRlV3z30V3KO1vjNIQOA/rF
         nf3Jt32u/g3bVRoEi03JnseD/jHb/Bk1tMoAcI2Itxp4V4yiwH3rH2Frexy0GOIiYtpU
         4LLCwLOlgZTwPaxqkgsVTm1R9/vn9IA414Hvw5pKmDItk83g1b3lRhrKcJQ3lAbPzDNs
         NQfj5UqWLVAN5O6W93VcJlXdBQ2I5OV9bjwgfKJwtH1G4l56dibBTTz1ttS0ZMzh7Dfs
         45qg==
X-Gm-Message-State: AOAM5304Ip/bo8RI3CSJgPBGB7A5+q+I5VxL9sFrd4j1IiZLOdKF32NB
        +m4eDbVgVb1PZPmmxetlWByaKobgpBDVvZqT+bL6oW+CxXF+QH0fgHwPHwCcSdUnsHbXNTdtqSm
        +wZk4qCOgtgRWcEY5ceGGXrWe0R4psB5Kt5mINpzqbP9ieJSdY9s2SUzdg9cUm2VZtXPMXWlh2Q
        ==
X-Google-Smtp-Source: ABdhPJzTOQS1J2QXnB3qlZqDFikELTJ/RSD+oYPYsXJZxfyT82O88LOXbLWCscohxpxEClgDSbCB2zAY2jBXSR+EYLI=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:c795:6596:6e89:ce2])
 (user=emilyshaffer job=sendgmr) by 2002:a25:bd4f:: with SMTP id
 p15mr8879313ybm.338.1626391583498; Thu, 15 Jul 2021 16:26:23 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:26:01 -0700
In-Reply-To: <20210715232603.3415111-1-emilyshaffer@google.com>
Message-Id: <20210715232603.3415111-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210715232603.3415111-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 7/9] hook: allow out-of-repo 'git hook' invocations
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since hooks can now be supplied via the config, and a config can be
present without a gitdir via the global and system configs, we can start
to allow 'git hook run' to occur without a gitdir. This enables us to do
things like run sendemail-validate hooks when running 'git send-email'
from a nongit directory.

It still doesn't make sense to look for hooks in the hookdir in nongit
repos, though, as there is no hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    For hookdir hooks, do we want to run them in nongit dir when core.hooksPath
    is set? For example, if someone set core.hooksPath in their global config and
    then ran 'git hook run sendemail-validate' in a nongit dir?

 git.c                         |  2 +-
 hook.c                        | 18 ++++++++++--------
 t/t1360-config-based-hooks.sh | 13 +++++++++++++
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/git.c b/git.c
index 540909c391..39988ee3b0 100644
--- a/git.c
+++ b/git.c
@@ -538,7 +538,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
-	{ "hook", cmd_hook, RUN_SETUP },
+	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/hook.c b/hook.c
index ed90edcad7..b08b876d5d 100644
--- a/hook.c
+++ b/hook.c
@@ -202,7 +202,6 @@ static int hook_config_lookup(const char *key, const char *value, void *cb_data)
 struct list_head* hook_list(const char* hookname, int allow_unknown)
 {
 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
-	const char *hook_path;
 	struct strbuf hook_key = STRBUF_INIT;
 	struct hook_config_cb cb_data = { &hook_key, hook_head };
 
@@ -216,14 +215,17 @@ struct list_head* hook_list(const char* hookname, int allow_unknown)
 	git_config(hook_config_lookup, &cb_data);
 
 
-	if (allow_unknown)
-		hook_path = find_hook_gently(hookname);
-	else
-		hook_path = find_hook(hookname);
+	if (have_git_dir()) {
+		const char *hook_path;
+		if (allow_unknown)
+			hook_path = find_hook_gently(hookname);
+		else
+			hook_path = find_hook(hookname);
 
-	/* Add the hook from the hookdir */
-	if (hook_path)
-		append_or_move_hook(hook_head, hook_path)->from_hookdir = 1;
+		/* Add the hook from the hookdir */
+		if (hook_path)
+			append_or_move_hook(hook_head, hook_path)->from_hookdir = 1;
+	}
 
 	return hook_head;
 }
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 12fca516ec..e4a7b06ad1 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -34,6 +34,19 @@ test_expect_success 'git hook rejects commands without a hookname' '
 	test_must_fail git hook list
 '
 
+test_expect_success 'git hook runs outside of a repo' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	$ROOT/path/def
+	EOF
+
+	nongit git config --list --global &&
+
+	nongit git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'git hook list orders by config order' '
 	setup_hooks &&
 
-- 
2.32.0.402.g57bb445576-goog

