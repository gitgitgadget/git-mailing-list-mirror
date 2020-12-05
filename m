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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB6FC1B0E3
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C6D229C4
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbgLEBv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLEBv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:51:28 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD1DC08E860
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:09 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id l11so4933323pfc.16
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=isU6Nqto7xVPug27tZI9gPvrR9M1DsWKGAAsSUX9RKA=;
        b=D19CsepcJIYRmdaz8oiCUXj+f/SlzJZRqbNat8KYxVs/bymlNvlU09n48sukA5W0uV
         QNELMQoms9zvx7IHPGJaunZg/+lf6dmhIV1B0ZmZ/h89WaewMSbhk9KKwz6bsQRys38+
         JBxL0V+aUgFpZTe0Jo/RhP4tReG6SzC9cVOhPi6BRSvGI+O8r2+/wnzxIg1ZtIH0NmT5
         2RG4O5X8a0JSitF9VUKJI133nlqbQSTln6WYQ7LhDtZy87I2XJP1IGDpBAx8mAxpzGf5
         Q+l1FsUJnJEMhbfTiMouxiDcEIcDK0uXCkf8t2p+8kqUd3Ga6hUMK8eT1I/XGT5FcXxM
         NUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=isU6Nqto7xVPug27tZI9gPvrR9M1DsWKGAAsSUX9RKA=;
        b=EoRfVnevvJtXpOFAhNLEizcEE7rclokZPbi4tjo1utqt/43RnGQetV7hPkPkTs8wFr
         3pdYmREyfPehfdZb5UqfL+LfZnkDyn1GkFBKZaHjC8xiz3qpl6iA9x5JNf6E0B6XbRMT
         f5goGo/GxA8F+Qf25XxO6FV6Sym+x1rNqCrZ6v5q73LhkdQLUivElIxMXwXdQeXcgN/Z
         KcT4fXzzu/XXNY/UDW7FmTJFy7M+0Y2e8xNW/bguGZQ9uw7BaK93mjRtFbTSm38vBGFD
         oGNPyRgmyLTrx2T224RMDXpy2gwbHTIwIvIFJWLUujZZW4YHRhkUBHGHarWZ2j/y0iAq
         E52A==
X-Gm-Message-State: AOAM531u+82z4W1AyW/ctDtViUj/Q10/LIbpvNUR+ZsJ1ttGTZfb1C4i
        PmVVAX9EFVROE/dTwumyzJXiJhxWLyytIaYQL7a102csbKw0RAEVmtCq3mhiEozKPUz03Cgko51
        WZbZB0zlG3SOY7KAXLs7LF/7k0u9IpQvVEefaRlRWSwI+zvQTjfqOib6I7hKJKweXKbUw2ulQag
        ==
X-Google-Smtp-Source: ABdhPJyW/eETJyctMjE2Q2AnBBLSbQzfueS3kBUqWJ5Kb4TEXRlLqpra7NQMRD7OSw3n8GQC7w84+f+2zRqFbgG8ikQ=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6a00:848:b029:197:e659:e236 with
 SMTP id q8-20020a056a000848b0290197e659e236mr6402483pfk.74.1607133009190;
 Fri, 04 Dec 2020 17:50:09 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:38 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 10/17] hook: convert 'post-rewrite' hook to config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using 'hook.h' for 'post-rewrite', we simplify hook invocations by
not needing to put together our own 'struct child_process' and we also
learn to run hooks specified in the config as well as the hook dir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  2 +
 builtin/am.c               | 18 +++------
 sequencer.c                | 76 +++++++++++++++-----------------------
 3 files changed, 36 insertions(+), 60 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 14035ef725..db290984f6 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -585,6 +585,8 @@ The hook always runs after the automatic note copying (see
 "notes.rewrite.<command>" in linkgit:git-config[1]) has happened, and
 thus has access to these notes.
 
+Hooks run during 'post-rewrite' will be run in parallel by default.
+
 The following command-specific comments apply:
 
 rebase::
diff --git a/builtin/am.c b/builtin/am.c
index 22d147bc19..c7cad2cb32 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -449,23 +449,15 @@ static int run_applypatch_msg_hook(struct am_state *state)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *hook = find_hook("post-rewrite");
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
 	int ret;
 
-	if (!hook)
-		return 0;
-
-	strvec_push(&cp.args, hook);
-	strvec_push(&cp.args, "rebase");
+	strvec_push(&opt.args, "rebase");
+	opt.path_to_stdin = am_path(state, "rewritten");
 
-	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
-	cp.stdout_to_stderr = 1;
-	cp.trace2_hook_name = "post-rewrite";
+	ret = run_hooks("post-rewrite", &opt);
 
-	ret = run_command(&cp);
-
-	close(cp.in);
+	run_hooks_opt_clear(&opt);
 	return ret;
 }
 
diff --git a/sequencer.c b/sequencer.c
index 5a98fd2fbc..4befd862ff 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -35,6 +35,7 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "hook.h"
+#include "string-list.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -1143,33 +1144,23 @@ int update_head_with_reflog(const struct commit *old_head,
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *argv[3];
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
+	struct strbuf tmp = STRBUF_INIT;
 	int code;
-	struct strbuf sb = STRBUF_INIT;
 
-	argv[0] = find_hook("post-rewrite");
-	if (!argv[0])
-		return 0;
+	strvec_push(&opt.args, "amend");
 
-	argv[1] = "amend";
-	argv[2] = NULL;
-
-	proc.argv = argv;
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "post-rewrite";
-
-	code = start_command(&proc);
-	if (code)
-		return code;
-	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
-	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(proc.in, sb.buf, sb.len);
-	close(proc.in);
-	strbuf_release(&sb);
-	sigchain_pop(SIGPIPE);
-	return finish_command(&proc);
+	strbuf_addf(&tmp,
+		    "%s %s",
+		    oid_to_hex(oldoid),
+		    oid_to_hex(newoid));
+	string_list_append(&opt.str_stdin, tmp.buf);
+
+	code = run_hooks("post-rewrite", &opt);
+
+	run_hooks_opt_clear(&opt);
+	strbuf_release(&tmp);
+	return code;
 }
 
 void commit_post_rewrite(struct repository *r,
@@ -4317,30 +4308,21 @@ static int pick_commits(struct repository *r,
 		flush_rewritten_pending();
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
-			struct child_process child = CHILD_PROCESS_INIT;
-			const char *post_rewrite_hook =
-				find_hook("post-rewrite");
-
-			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
-			child.git_cmd = 1;
-			strvec_push(&child.args, "notes");
-			strvec_push(&child.args, "copy");
-			strvec_push(&child.args, "--for-rewrite=rebase");
+			struct child_process notes_cp = CHILD_PROCESS_INIT;
+			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_ASYNC;
+
+			notes_cp.in = open(rebase_path_rewritten_list(), O_RDONLY);
+			notes_cp.git_cmd = 1;
+			strvec_push(&notes_cp.args, "notes");
+			strvec_push(&notes_cp.args, "copy");
+			strvec_push(&notes_cp.args, "--for-rewrite=rebase");
 			/* we don't care if this copying failed */
-			run_command(&child);
-
-			if (post_rewrite_hook) {
-				struct child_process hook = CHILD_PROCESS_INIT;
-
-				hook.in = open(rebase_path_rewritten_list(),
-					O_RDONLY);
-				hook.stdout_to_stderr = 1;
-				hook.trace2_hook_name = "post-rewrite";
-				strvec_push(&hook.args, post_rewrite_hook);
-				strvec_push(&hook.args, "rebase");
-				/* we don't care if this hook failed */
-				run_command(&hook);
-			}
+			run_command(&notes_cp);
+
+			hook_opt.path_to_stdin = rebase_path_rewritten_list();
+			strvec_push(&hook_opt.args, "rebase");
+			run_hooks("post-rewrite", &hook_opt);
+			run_hooks_opt_clear(&hook_opt);
 		}
 		apply_autostash(rebase_path_autostash());
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

