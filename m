Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1D3C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE11601FD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhE1MOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbhE1MNg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E07C06138D
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so2275020wmf.1
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gu2/EP8+WZtdqS+LfCUB7epHyQjdD+jLlCHAe/9Yvvs=;
        b=N6va65qAeuikLyMxWL+aIC1BXKEOTq3aRHYRLzmDdtDARhi1+OrhxhwpHPZ499YlE4
         y/CAlRkH72ENBIP+3Tc7lGCbtlp/N/bKK1rZEbHfdVd7j/Xd7jjsJLbognyWNw+JT2tT
         iYa4raUvpJgOPezg7tTKdmKsXEK/LNEIwx67t0MIPjBE9kcQ1NF9Vqnss5pOIfAeipJN
         I7e9EhXVE7JNk4TfbTNoqCRpisXh7TES5z2yRoAcox3QGCpurYscLRIg9tABmtpn09oe
         5QlR/rOd3EoWngdNB4zra5aP97myEo1aW+nsrcZzLGgx+3ilPgX3WYG73AWuP+HbFpQY
         Uiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gu2/EP8+WZtdqS+LfCUB7epHyQjdD+jLlCHAe/9Yvvs=;
        b=P5AzEyIKxauXuLO5j9aVTyHqVbYZ6WXywwKeRbQ6uKshduEinvja2gYEpGwQmDyIi3
         9tiOfSw2CdJTMA8gei7Uku9rgBcHFKBre5KzwUsnunT15/AsuiS4KzQTtLFd8hz10mIu
         Mu/80qeh9CWJFcB5DguqyQ1/mkxzOzcv/JfTleNsTPR5iTvzapTLQNvpOnTqyXlykcA5
         HyqOiaUgVJMxp0twnl+YUBrC714O17zSGg7zZGDk11IwMCncq7/xBZW7svfY/Qdv84Wi
         5gcP5t8WAOBOKmOY0bj7urFOuLPnJjTz3fhWIsQiFORf4o6LUb2FM7DN651vEsHJYcQ6
         314w==
X-Gm-Message-State: AOAM533muXdoiB8jRvUzvMzvNeG5S69Rwq5avEcNLWPtLWPzUR1W681m
        m0oKoCu5d60gybUIJ3EnjRgGucA/TojRIw==
X-Google-Smtp-Source: ABdhPJzirDWKQ4fVGyB6ous0qsrcwwZ2fDPiYeqfm1YtOXFVHkuTEQC1IzaHaVD0ZCTLFzmQE2Bb2Q==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr13488872wmg.146.1622203913316;
        Fri, 28 May 2021 05:11:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/31] commit: use hook.h to execute hooks
Date:   Fri, 28 May 2021 14:11:16 +0200
Message-Id: <patch-14.31-3f3610f5ed3-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach run_commit_hook() to call hook.h instead of run-command.h. This
covers 'pre-commit', 'commit-msg', and
'prepare-commit-msg'.

Additionally, ask the hook library - not run-command - whether any
hooks will be run, as it's possible hooks may exist in the config but
not the hookdir.

Because all but 'post-commit' hooks are expected to make some state
change, force all but 'post-commit' hook to run in series. 'post-commit'
"is meant primarily for notification, and cannot affect the outcome of
`git commit`," so it is fine to run in parallel.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c |  2 +-
 commit.c         | 16 ++++++++++------
 sequencer.c      |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index f1aafd67d46..dad4e565443 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1045,7 +1045,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
+	if (!no_verify && hook_exists("pre-commit")) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
diff --git a/commit.c b/commit.c
index 8ea55a447fa..e8147a88fc6 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1698,22 +1699,25 @@ size_t ignore_non_trailer(const char *buf, size_t len)
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    const char *name, ...)
 {
-	struct strvec hook_env = STRVEC_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	va_list args;
+	const char *arg;
 	int ret;
-
-	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
+	strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
 	 * Let the hook know that no editor will be launched.
 	 */
 	if (!editor_is_used)
-		strvec_push(&hook_env, "GIT_EDITOR=:");
+		strvec_push(&opt.env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.v, name, args);
+	while ((arg = va_arg(args, const char *)))
+		strvec_push(&opt.args, arg);
 	va_end(args);
-	strvec_clear(&hook_env);
+
+	ret = run_hooks(name, &opt);
+	run_hooks_opt_clear(&opt);
 
 	return ret;
 }
diff --git a/sequencer.c b/sequencer.c
index 3de479f90e1..8f46984ffb7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1446,7 +1446,7 @@ static int try_to_commit(struct repository *r,
 		}
 	}
 
-	if (find_hook("prepare-commit-msg")) {
+	if (hook_exists("prepare-commit-msg")) {
 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
-- 
2.32.0.rc1.458.gd885d4f985c

