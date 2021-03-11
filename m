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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87772C4361A
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5429064FDC
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCKCLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhCKCLb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2498C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q77so23900371ybq.0
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LK9AvPeCqTvaxfb5WC9sejNPiAu/1Rrn4PDquj7Aux4=;
        b=DLSXagUHTTMmeFys3lJn3Y+B5s0XlY3nJF8CSMo8b5R7Wk3zZH6PwLhzpaBVzJTaDz
         hFomlGjfZ2YNH39mVEisDDkloN0IIL34DZoh8iIxMIRbeXe+VHYBWQ3Q+3HjR3Qd6Csj
         /xlgTlRUvCGJbE2pp3vSj2JWItcMw6DRWdxWgSJAJgLoZ3IkhtWceX37JmIkxv9bEENo
         n05oIyUk/TXybAFvJKPm2LoHXJAOt7N5W/cwp495EB4AjZQUrHTdLGQjs0pNVcm7IwO+
         i4VU8ySCCbxJsgDR7A8Gw250BDaqs/Zp5oCttsk7b4jNeqwnuuB2lBeKl+8aWtHAUDEI
         3boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LK9AvPeCqTvaxfb5WC9sejNPiAu/1Rrn4PDquj7Aux4=;
        b=bgcNECVQlOCJOnWPrMHleRrw8sDWeo61Y8PT2DaD5zoT6QRHe1L7U6YPfwLcDjhrul
         1GLOUVMNeqzev5onFR4PLJj3dBt28zq9igZpq93y3jcYZWe5TnadBbpvm+qPXXbXyspv
         OPfSjqNlinmjwBbny728kpJZX0btNeWsul0Cy1nTT/fnZKoj+zCCskSu30DCS6pbSZZo
         b/G3O6kD5XPVSdtkBtzQ8k/PLRnMtNOEiTLEaREZtPRk+y5IWUGwyNKl5H9sdjAj+rTk
         Yae6yqPSz3njzDe/lqXmsCEFwwj6xOagvG3xjm79zhGB4yahisel8btPj0kzEdf/WNiZ
         S5Cw==
X-Gm-Message-State: AOAM533p/8aqLfps9Ii1FJzbTXzTKCgO8O+CXKoThGuO7WRZzBbd4jIr
        YHzkeWlHA0ZHke78vjiZYxAUUKB4aKB/uyJecwFOaL1sdsDfhlV5zry5kjx+nvsqnSAH1zYNovu
        grma73hmskFpEl9PO4hTU9dQyQYz2IDgBeP8VOWAwT9p+HTQ+jHgGUaMs9vBY4C8e0wPQX1k7hQ
        ==
X-Google-Smtp-Source: ABdhPJyKqclLp6AbQL7FIfKvU13w3s1a3en+HbOej/qhdySbAjJ2/xiXGkRFLLthh79+t8ZcDArYuPZBEz0Kg6/390g=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a25:6c46:: with SMTP id
 h67mr8529551ybc.224.1615428690141; Wed, 10 Mar 2021 18:11:30 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:22 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-23-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 22/37] rebase: teach pre-rebase to use hook.h
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using hook.h instead of run-command.h to run hooks, pre-rebase hooks
can now be specified in the config as well as in the hookdir. pre-rebase
is not called anywhere besides builtin/rebase.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt | 3 +++
 builtin/rebase.c           | 9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 00f88912cd..e3a0375827 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -206,6 +206,9 @@ two parameters.  The first parameter is the upstream from which
 the series was forked.  The second parameter is the branch being
 rebased, and is not set when rebasing the current branch.
 
+Hooks executed during 'pre-rebase' will run in parallel, unless hook.jobs is
+configured to 1.
+
 post-checkout
 ~~~~~~~~~~~~~
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index de400f9a19..c35b5ba452 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -28,6 +28,7 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 
 #define DEFAULT_REFLOG_ACTION "rebase"
 
@@ -1318,6 +1319,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
+	struct run_hooks_opt hook_opt;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -1431,6 +1433,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	};
 	int i;
 
+	run_hooks_opt_init_async(&hook_opt);
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
@@ -2032,9 +2036,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* If a hook exists, give it a chance to interrupt*/
+	strvec_pushl(&hook_opt.args, options.upstream_arg, argc ? argv[0] : NULL, NULL);
 	if (!ok_to_skip_pre_rebase &&
-	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
-			argc ? argv[0] : NULL, NULL))
+	    run_hooks("pre-rebase", &hook_opt))
 		die(_("The pre-rebase hook refused to rebase."));
 
 	if (options.flags & REBASE_DIFFSTAT) {
@@ -2114,6 +2118,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	ret = !!run_specific_rebase(&options, action);
 
 cleanup:
+	run_hooks_opt_clear(&hook_opt);
 	strbuf_release(&buf);
 	strbuf_release(&revisions);
 	free(options.head_name);
-- 
2.31.0.rc2.261.g7f71774620-goog

