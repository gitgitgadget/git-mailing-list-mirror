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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F34C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA83264FAF
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCKCMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhCKCLj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:39 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFD6C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:32 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id h10so14179331qvf.19
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Vc1COTTg+DDFEw5oTnNcR8CtFJOx1prRdNsgtg7H4uw=;
        b=U/tJR29LTkfEoBro11Bz6Nql8e8i6KBEH8CMNxAUQaqHq5v0FtVT5RthbAzhVcJmxS
         2x1PZCVhmCSw7Mgm4gsWfGqLwFowQgOOi032lfrNdDmxZyLhah7QWXXT4FruARA7DHVB
         H0J5OrvCNR6ocTdMNc5wFKbwUAhYh12ZAUhUp0zpRxu1Z2Mh8E9U/rFKsyknacXgbRKO
         LvNL7fDxy0za54ml5XeuPgxRIx0J4SOzufU+fkOkMrCEJPlozou65+/UHPl8E6kVKrJr
         VTjH4Mn/jgQdFdrP2NGqJ6k/tMNo+/ovrMjenWFdEOTprNO5xtueMJ650K0rNmrUAELI
         V/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Vc1COTTg+DDFEw5oTnNcR8CtFJOx1prRdNsgtg7H4uw=;
        b=W67XGkwUNMZb0jC7AYs7X8w95WA6SnD1I8N+tv94PKPow7NG6PqdM7Ef3aMely/rh0
         PH2PdlW2PKXadSWval/UstrSewcxwL0BXtCLtNqK5izDbXhfZz712QpzeZ9dU0BxaIEW
         bDjlXno8YZKObR4ujGe/fcEQbdKfMVW/wKZGb4ZXNWv4gbFq1nv/paX8ByOm9tptXbHY
         5SRloEyUFbG6Tjfq7mSh7TUxCGuJUV51KV0crjENu6MP8XqxAgBCEfLELTCssFTnC/BH
         NU1HhInOCkUrZEc9K+eHOh56mxZFapm0X7irijZbqtsoIvWWYe6DczMFY/7GZoaHD8iC
         Istw==
X-Gm-Message-State: AOAM532viIORJmbPhSv7mvfSyfWHhaBfmrPLPA4GGHxmaCw+HMNO8FgB
        //8jxXi6qWi/NIGzpVBPtvyAJYO1Kd81dAjD7/goHuexQKzTb7EQ0rwLOBa7hM4y/2LxDpaSenV
        B2wrWSqtOmbZtRwXLodZlqwzIGS2eTC++sttSgijDIyn6A823mUsudfUyFLXTjTfGoDNp/1K/aA
        ==
X-Google-Smtp-Source: ABdhPJzeR1lxYgyyRP4HgaDX/y9ZNurPMyil+7BSvaSuTB6Fan8PBCYoOMJilL22mmeYvjVK4Mp7+bIme4eMLgvd9uw=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:a0c6:: with SMTP id
 c64mr5883320qva.57.1615428691916; Wed, 10 Mar 2021 18:11:31 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:23 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-24-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 23/37] read-cache: convert post-index-change hook to use config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using hook.h instead of run-command.h to run, post-index-change hooks
can now be specified in the config in addition to the hookdir.
post-index-change is not run anywhere besides in read-cache.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  3 +++
 read-cache.c               | 13 ++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index e3a0375827..e5c2cef271 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -720,6 +720,9 @@ and "0" meaning they were not.
 Only one parameter should be set to "1" when the hook runs.  The hook
 running passing "1", "1" should not be possible.
 
+Hooks run during 'post-index-change' will be run in parallel, unless hook.jobs
+is configured to 1.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/read-cache.c b/read-cache.c
index 1e9a50c6c7..fd6c111372 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,6 +25,7 @@
 #include "fsmonitor.h"
 #include "thread-utils.h"
 #include "progress.h"
+#include "hook.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -3070,6 +3071,8 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 				 unsigned flags)
 {
 	int ret;
+	struct run_hooks_opt hook_opt;
+	run_hooks_opt_init_async(&hook_opt);
 
 	/*
 	 * TODO trace2: replace "the_repository" with the actual repo instance
@@ -3088,9 +3091,13 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hook_le(NULL, "post-index-change",
-			istate->updated_workdir ? "1" : "0",
-			istate->updated_skipworktree ? "1" : "0", NULL);
+	strvec_pushl(&hook_opt.args,
+		     istate->updated_workdir ? "1" : "0",
+		     istate->updated_skipworktree ? "1" : "0",
+		     NULL);
+	run_hooks("post-index-change", &hook_opt);
+	run_hooks_opt_clear(&hook_opt);
+
 	istate->updated_workdir = 0;
 	istate->updated_skipworktree = 0;
 
-- 
2.31.0.rc2.261.g7f71774620-goog

