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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0B6C43331
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5D264FCD
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCKCMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCKCLj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:39 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2951C061763
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:39 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id u17so14192666qvq.23
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lZ0f+BLxhi0jv9UwqIrAJNMyPRXCDqr/2LXvPk8gE10=;
        b=C9/OZlKRuzkolXZfe3MGALv1BTonByQTiYNlizmzzAk4zQEnAnWJ6CrzX1I6jkyPmr
         7HhU9Gda4SRupyrpXiDMejhymlSkt9xIdNcXgZMJWyx6qr7e8rdF53TVunpHkthvyBGa
         W0xreBD7NGdncI8+034AX/6BWwxDthMD7dv+O5l+bBNqBdcRdI44Omp2O96j44jmQZDV
         M7YUgfHacz9BQQFwfLGaJzyhExxbz5gS75ZsIyjZTgmsTl78PUKk6MZVDo7rUOLwGrHV
         per4Jfv3ZsqEvw6KUzqa1n4kU7MV204i66RDfOWcMB/cIiyvLZ59JvCo6abobVJAadl3
         2q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lZ0f+BLxhi0jv9UwqIrAJNMyPRXCDqr/2LXvPk8gE10=;
        b=YRbAJU50Id+ap5kujFVrZoxgiOjP+dNUQiWVeVUxUbQl/jqiTD2ojIP6qUPpxUbo9J
         6J2HiNC+y3wiL3BkJBrNq8pbRgbl528Qy3jCINGFnrKYlXvwICkazN0RWABGprOMuzNo
         M2J7P1Y3gWuztXKNcjJSy+FI3bNIY5KGt1AOCbeZDIHo6hSjowPTjtniNOGUr6mh5BBM
         KpocoGCGlmb6NHzYree03ATGhcrfIkbqNUpGJEJ/fa27o4tfSrq/izSwkW+kHLvycIqw
         3OvQPJcKzZcfHjFpanPT8WkQadohcc2VXMZ45pPAhgDmH+Wbr9nX1bduT4UkI2J+22U/
         yg5w==
X-Gm-Message-State: AOAM533BSK6bMuVFJNn3pCuqplNusBsPtaCYCXEBvEHvGZ93sRq6PPrx
        fZEay4HMZGN4HNDrOxMNWIrUcfTL+Gzl8viBcr7mxElzfGlpwPOiX6lCc/upiEgKWEJFxqTXEf6
        6LSW6HcN2afUJsxty6KeiiB16xm87IaP3NkAk/JV/EjF2qz7zFfucGqucIZ9q/agUVnIt2duFQg
        ==
X-Google-Smtp-Source: ABdhPJwNyS+OfF9esIAclEqMCA2Ggwsma5sb+lzeAFAgqDhxhnmB0FL4mid+uty0jW4Yra4tn6Pyd/eRqevJO8Ad0b8=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:cb0c:: with SMTP id
 o12mr5674526qvk.54.1615428698884; Wed, 10 Mar 2021 18:11:38 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:27 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-28-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 27/37] hook: convert 'post-rewrite' hook to config
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

The signal handling that's being removed by this commit now takes place
in run-command.h:run_processes_parallel(), so it is OK to remove them
here.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  3 ++
 builtin/am.c               | 19 +++------
 sequencer.c                | 83 +++++++++++++++++---------------------
 3 files changed, 45 insertions(+), 60 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 362224a03b..544238b381 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -594,6 +594,9 @@ The hook always runs after the automatic note copying (see
 "notes.rewrite.<command>" in linkgit:git-config[1]) has happened, and
 thus has access to these notes.
 
+Hooks run during 'post-rewrite' will be run in parallel, unless hook.jobs is
+configured to 1.
+
 The following command-specific comments apply:
 
 rebase::
diff --git a/builtin/am.c b/builtin/am.c
index 4467fd9e63..45425105e8 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -450,23 +450,16 @@ static int run_applypatch_msg_hook(struct am_state *state)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *hook = find_hook("post-rewrite");
+	struct run_hooks_opt opt;
 	int ret;
+	run_hooks_opt_init_async(&opt);
 
-	if (!hook)
-		return 0;
-
-	strvec_push(&cp.args, hook);
-	strvec_push(&cp.args, "rebase");
-
-	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
-	cp.stdout_to_stderr = 1;
-	cp.trace2_hook_name = "post-rewrite";
+	strvec_push(&opt.args, "rebase");
+	opt.path_to_stdin = am_path(state, "rewritten");
 
-	ret = run_command(&cp);
+	ret = run_hooks("post-rewrite", &opt);
 
-	close(cp.in);
+	run_hooks_opt_clear(&opt);
 	return ret;
 }
 
diff --git a/sequencer.c b/sequencer.c
index e3a951fbeb..8280ba828b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -35,6 +35,7 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "hook.h"
+#include "string-list.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -1146,33 +1147,29 @@ int update_head_with_reflog(const struct commit *old_head,
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *argv[3];
+	struct run_hooks_opt opt;
+	struct strbuf tmp = STRBUF_INIT;
+	struct string_list to_stdin = STRING_LIST_INIT_DUP;
 	int code;
-	struct strbuf sb = STRBUF_INIT;
+	run_hooks_opt_init_async(&opt);
 
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
+	string_list_append(&to_stdin, tmp.buf);
+
+	opt.feed_pipe = pipe_from_string_list;
+	opt.feed_pipe_ctx = &to_stdin;
+
+	code = run_hooks("post-rewrite", &opt);
+
+	run_hooks_opt_clear(&opt);
+	strbuf_release(&tmp);
+	string_list_clear(&to_stdin, 0);
+	return code;
 }
 
 void commit_post_rewrite(struct repository *r,
@@ -4325,30 +4322,22 @@ static int pick_commits(struct repository *r,
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
+			struct run_hooks_opt hook_opt;
+			run_hooks_opt_init_async(&hook_opt);
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
2.31.0.rc2.261.g7f71774620-goog

