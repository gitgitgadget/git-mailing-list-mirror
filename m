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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C70AC43619
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399B964FD7
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhCKCLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCKCLb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:31 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB5DC061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:25 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id a137so10638042qkb.20
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fmVTGH68x2FsqSYInLCVoqvIV47aIbA8dfsXVYpnEoY=;
        b=fW8GqkiFqsC56IeEH4vYRqZ+dY6IH8ECLmLAW5awsKVny02MYM14I4wBrqqQItL5yx
         S7EmWC97tVtznvm/tkD41c/AiUGqGL8JDpj8fW4vaZFemqCdrgifKOmI93gUnHswQ+Ta
         IK4oIkmQ6dNXljiuT4ApUH5oEuSqNBYoFYUNwnRaSq9R4NMPXRFQKyfUU1/rm+lN18bm
         KZdlHY90P7P+QPjPIXROOoOYSFtOXfu0dm/haAUidCvPmaWCFUFL6GjD7srEDS26QEh7
         cIhYwOfYccoeG0Hy07hJ2u3jyex/jFvduWuBSqJpijgBQ/sZF1si0sNj5x2hNAJokdA6
         yuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fmVTGH68x2FsqSYInLCVoqvIV47aIbA8dfsXVYpnEoY=;
        b=N5h28E7V0FGcJm6ryA3hkfqLYy5ek/nsxX0tafR+ThOGt91Eyna3uvgzcnplEoU7M5
         ojDc3NAR88I6nCMhkMCt9NYguh9VRbPYRfDRoBjEaW/4xW7C92Gm46PLMbSh0s6AWcia
         jTdVn2Jmu+4DPXX208Zto0+PiLjhJQbPC29QR86mpdSFX+i82o/Lne9IxyeTk58bjf/Q
         NJ2aVRLcPPKAOzrMAW11qPupEer2213QtrNuuha32YScCiXM+oVu0wdRJf1GL22XB7vz
         1n0Xx8VJianpzTMAM3hcot5GTNs6yXhUPoJ7x/Gj5+1Xyna1vYBgE5SrHr7amdLBZ10M
         UISg==
X-Gm-Message-State: AOAM5305P2Lg1lprBTJG85bJGK1mVsVXEKl0o6lGHObXk9e2aDiYcasP
        BuXzfStFEedHfRNUPRaIc/hLagxdi22flEwlMKDN8m2Y5YV4mO/LoFHYPZOea/bxK+ly3euiL7h
        /B73IXU2INWpHBnnZAPz+wtP+VemZqAlV2SDKDwzl7KM8px0nAL6+jRCDucAcHB4BxbCi7ubujQ
        ==
X-Google-Smtp-Source: ABdhPJyhMWsH6GuMilZ0oUAnJJ/75A8mvn1AGlQER6v5lWNT/oOK1QJNxXLBxOfS3HCINvqtEVaQbZw+w8PYWT1SFaU=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:bf12:: with SMTP id
 m18mr5761444qvi.40.1615428685000; Wed, 10 Mar 2021 18:11:25 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:19 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-20-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 19/37] am: convert applypatch hooks to use config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach pre-applypatch, post-applypatch, and applypatch-msg to use the
hook.h library instead of the run-command.h library. This enables use of
hooks specified in the config, in addition to those in the hookdir.
These three hooks are called only by builtin/am.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  9 +++++++++
 builtin/am.c               | 14 +++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 984fb998b2..0e7eb972ab 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -58,6 +58,9 @@ the message file.
 The default 'applypatch-msg' hook, when enabled, runs the
 'commit-msg' hook, if the latter is enabled.
 
+Hooks run during 'applypatch-msg' will not be parallelized, because hooks are
+expected to edit the file holding the commit log message.
+
 pre-applypatch
 ~~~~~~~~~~~~~~
 
@@ -73,6 +76,9 @@ make a commit if it does not pass certain test.
 The default 'pre-applypatch' hook, when enabled, runs the
 'pre-commit' hook, if the latter is enabled.
 
+Hooks run during 'pre-applypatch' will be run in parallel, unless hook.jobs is
+configured to 1.
+
 post-applypatch
 ~~~~~~~~~~~~~~~
 
@@ -82,6 +88,9 @@ and is invoked after the patch is applied and a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git am`.
 
+Hooks run during 'post-applypatch' will be run in parallel, unless hook.jobs is
+configured to 1.
+
 pre-commit
 ~~~~~~~~~~
 
diff --git a/builtin/am.c b/builtin/am.c
index 8355e3566f..4467fd9e63 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -33,6 +33,7 @@
 #include "string-list.h"
 #include "packfile.h"
 #include "repository.h"
+#include "hook.h"
 
 /**
  * Returns the length of the first line of msg.
@@ -426,9 +427,13 @@ static void am_destroy(const struct am_state *state)
 static int run_applypatch_msg_hook(struct am_state *state)
 {
 	int ret;
+	struct run_hooks_opt opt;
+	run_hooks_opt_init_sync(&opt);
 
 	assert(state->msg);
-	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
+	strvec_push(&opt.args, am_path(state, "final-commit"));
+	ret = run_hooks("applypatch-msg", &opt);
+	run_hooks_opt_clear(&opt);
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
@@ -1558,8 +1563,10 @@ static void do_commit(const struct am_state *state)
 	struct commit_list *parents = NULL;
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
+	struct run_hooks_opt hook_opt;
+	run_hooks_opt_init_async(&hook_opt);
 
-	if (run_hook_le(NULL, "pre-applypatch", NULL))
+	if (run_hooks("pre-applypatch", &hook_opt))
 		exit(1);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
@@ -1611,8 +1618,9 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
-	run_hook_le(NULL, "post-applypatch", NULL);
+	run_hooks("post-applypatch", &hook_opt);
 
+	run_hooks_opt_clear(&hook_opt);
 	strbuf_release(&sb);
 }
 
-- 
2.31.0.rc2.261.g7f71774620-goog

