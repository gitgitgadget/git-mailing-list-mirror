Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A79DC47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B84D6128D
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhE0AL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbhE0ALX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:23 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90203C06134F
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:42 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id j19-20020ac85f930000b029021f033edf60so1663559qta.10
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g8vUeaNpFTZY8ypWo63L8C3N26h6uVvcs49EsDCGhCs=;
        b=MDwhTybXgB0qCAAllpB6UrQrwfytS6YOK/AXVV2jUqjd7Ruq5qdhW+FBfPit2nchFp
         m/ZBeuTmH1hwahT9cOFHUrZSaoD8vjv1O0zPIaks/TXQ8D+LhtjP1lsXA858kpIKEUxl
         Og5F2VNXoyU61zAr2llCTP1uFA4anH/Xf4qPS0G16iP5ymhYoveaZpOeL59udVHscu+S
         5FOS98FjoapL97ExjFl0E1TRyPyzqDiuX0c3qCYSvavebzE2UnJSovbULmOv4xk0Uswb
         T+4XkrOeE4I9EypOLItgiPg2sVAVOMzwbzgxX8CJM1LO0GU3SHZ4hURCMmD77mIPZWq+
         o3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g8vUeaNpFTZY8ypWo63L8C3N26h6uVvcs49EsDCGhCs=;
        b=Y5yVtB1aHDlWjyyrnm0UMa2U8x+rZ+Z6TL2KrQ9Wwf9VEjASJPBUUfOZVPLAbhs0Nk
         v6oTYzy49XjOyBlYZaBuFqzSp6I2Qi9JlsJ8GTvyOUik24r1RRCBetadNG2Goh/QZDuN
         TnxwSyy4Ni7CmvMcwPQsup2AMiOKlMJ29gPYneJprgpRXgsRlscBo9rssGYlMzTfK0Zx
         6pQEIXD3/cRvhfy6Vusts4/cSOg28XXpIiwlaOY9+GObXMqFpYRbohh3wiIfhqXxOBiF
         vvLb1xTzG6kVVNkemxc/4K9j4sdMuSut6EdFeD7+/TDeJ506q+cBSTOo9x9n+gnNDhzt
         VpFg==
X-Gm-Message-State: AOAM531JJWiWqcMmdkuQ7lEbHXvbK+x1Jh22bqevrUq7y0kM7R89ugaE
        pgn42qbLknOhjjpwGCilyxQxqSztIKESwzGlRFAx4Jb+9msAna4nUPnzuiq4QHp/YWkiggz/IGR
        c9c/s5GOFht7WHLY7MqnrgpvruCKgAVjP9tk61c9F5OOyfC5h9r6x97IFLKeWQvXWmcNINJjQvw
        ==
X-Google-Smtp-Source: ABdhPJw9n9uRH8P9PsSyuRAiIO/0KoBO7j82pNZmlXd3pXMLm40Mbj30oFTV0+ePJsiDlNzlECSrXWy1WBvgiNA8heA=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:eb4d:: with SMTP id
 c13mr835540qvq.48.1622074181620; Wed, 26 May 2021 17:09:41 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:40 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-22-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 21/37] rebase: teach pre-rebase to use hook.h
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
 Documentation/githooks.txt |  3 +++
 builtin/rebase.c           | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d77170dafb..7ae24d65ec 100644
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
index 12f093121d..fe9f144cad 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -28,6 +28,7 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 
 #define DEFAULT_REFLOG_ACTION "rebase"
 
@@ -1313,6 +1314,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
+	struct run_hooks_opt hook_opt;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -2022,10 +2024,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* If a hook exists, give it a chance to interrupt*/
+	run_hooks_opt_init_async(&hook_opt);
+	strvec_pushl(&hook_opt.args, options.upstream_arg, argc ? argv[0] : NULL, NULL);
 	if (!ok_to_skip_pre_rebase &&
-	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
-			argc ? argv[0] : NULL, NULL))
+	    run_hooks("pre-rebase", &hook_opt)) {
+		run_hooks_opt_clear(&hook_opt);
 		die(_("The pre-rebase hook refused to rebase."));
+	}
+	run_hooks_opt_clear(&hook_opt);
 
 	if (options.flags & REBASE_DIFFSTAT) {
 		struct diff_options opts;
-- 
2.31.1.818.g46aad6cb9e-goog

