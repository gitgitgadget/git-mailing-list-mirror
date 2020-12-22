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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B4CC433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AA2229C6
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgLVAEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVAEA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:04:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A77BC0611E4
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c9so15654112ybs.8
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2ZAE60cky6qzXQ9u1UPgPFumiFq3z7RBjfFezd3lxus=;
        b=R+Kih8mFcTJmT53WfDbXG3jDF8I1Wa052z2d0Mpki0CVgtWrqpeNk1utgEUSKj+5qs
         eBXeiD7bzPNcIAcXc2hzxUxJLefixBFwX7G9Dp7a1otQXe0PD1xDi2eSIk/mN6XKjDVo
         m+yBJzlDbHLxs9yx/9NnU2LYpU012tHEAjYzA8md/bJcnCFo/Jrg1jcFGI6htgFoAye+
         kjrJO+GBaf2nB2ITGO1hrbHosFItgUGcvVg3ftXybW44y4wx9YCnId0zpCDmGRTUTNn/
         J/agsMfcT5iyoJ5OK2drEQURAo2DmW6ouY3eJBXPtEYcT0pH2gAS/R7Zz6BHbN6Kbguu
         dMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2ZAE60cky6qzXQ9u1UPgPFumiFq3z7RBjfFezd3lxus=;
        b=qysPTojliyXr7zoe0TvJDPIsRFHhSOn26TZFlc+4EttlCZhW94b7OQiTPfqN3WIMUh
         Y5dxSeb4LBgd0JIl0D8Ca10cn9Gkw/W4MrAKd01ISJ7cdIc26uM85Xjl4V1DVnotxY2h
         3Rk1hiRuyzXJyIunboMXj3jPf2JHf9FADqptILW7JnOV8ZLGKUwxjpGZvnjZB6JYWQpn
         JSq/2aIwCFmJMvtKMKmnsa9XjD54iewLtc1yjIrSo0JPPksONFpmPLwjlLdEjLk7PbI3
         JFL+XjHlYJ9nUxCu3kcR56OBtGiRnzkgtCnl+4BcAIa59T3tvsYnzR0JlYNIaM5Lk2pL
         Ivug==
X-Gm-Message-State: AOAM531IaKOmgm7ZsiiV6PanZNgFLBHPhOAdbLGbO+hZLM9d64pgxjCE
        H/FDYtnBa128ZokwmKY6kGzVKaLGAztia55q2Y3bt1/gHDRLV/YFrlHvnMgUV1fKYzb+iRXGe1H
        98mb2+HbU1LJZsU19NENbegBa5RJwZL0ltNUN8lSwOUQJUpfjySb66zjDpDCGMxddNaZaAukbaA
        ==
X-Google-Smtp-Source: ABdhPJwGOEyUIsq1MbYoCCFixToP3NwTjsEHASVhrc6ceG5/tI0xHO0AzyeSedadKkAs7y6YagaZxBhFPpm20mJh0bs=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:9b45:: with SMTP id
 u5mr13924866ybo.331.1608595373352; Mon, 21 Dec 2020 16:02:53 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:18 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-16-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 15/17] hook: provide stdin by string_list or callback
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cases where a hook requires only a small amount of information via
stdin, it should be simple for users to provide a string_list alone. But
in more complicated cases where the stdin is too large to hold in
memory, let's provide a callback the users can populate line after line
with instead.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 hook.c | 39 ++++++++++++++++++++++++++++++++++++++-
 hook.h | 25 +++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 312ede1251..b63a34d0a6 100644
--- a/hook.c
+++ b/hook.c
@@ -9,6 +9,7 @@ void free_hook(struct hook *ptr)
 {
 	if (ptr) {
 		strbuf_release(&ptr->command);
+		free(ptr->feed_pipe_cb_data);
 		free(ptr);
 	}
 }
@@ -38,6 +39,7 @@ static void append_or_move_hook(struct list_head *head, const char *command)
 		strbuf_init(&to_add->command, 0);
 		strbuf_addstr(&to_add->command, command);
 		to_add->from_hookdir = 0;
+		to_add->feed_pipe_cb_data = NULL;
 	}
 
 	/* re-set the scope so we show where an override was specified */
@@ -253,9 +255,32 @@ void run_hooks_opt_clear(struct run_hooks_opt *o)
 {
 	strvec_clear(&o->env);
 	strvec_clear(&o->args);
+	string_list_clear(&o->str_stdin, 0);
 }
 
 
+static int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb)
+{
+	int *item_idx;
+	struct hook *ctx = pp_task_cb;
+	struct string_list *to_pipe = &((struct hook_cb_data*)pp_cb)->options->str_stdin;
+
+	/* Bootstrap the state manager if necessary. */
+	if (!ctx->feed_pipe_cb_data) {
+		ctx->feed_pipe_cb_data = xmalloc(sizeof(unsigned int));
+		*(int*)ctx->feed_pipe_cb_data = 0;
+	}
+
+	item_idx = ctx->feed_pipe_cb_data;
+
+	if (*item_idx < to_pipe->nr) {
+		strbuf_addf(pipe, "%s\n", to_pipe->items[*item_idx].string);
+		(*item_idx)++;
+		return 0;
+	}
+	return 1;
+}
+
 static int pick_next_hook(struct child_process *cp,
 			  struct strbuf *out,
 			  void *pp_cb,
@@ -277,6 +302,10 @@ static int pick_next_hook(struct child_process *cp,
 	if (hook_cb->options->path_to_stdin) {
 		cp->no_stdin = 0;
 		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
+	} else if (hook_cb->options->feed_pipe) {
+		/* ask for start_command() to make a pipe for us */
+		cp->in = -1;
+		cp->no_stdin = 0;
 	} else {
 		cp->no_stdin = 1;
 	}
@@ -350,6 +379,14 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if ((options->path_to_stdin && options->str_stdin.nr) ||
+	    (options->path_to_stdin && options->feed_pipe) ||
+	    (options->str_stdin.nr && options->feed_pipe))
+		BUG("choose only one method to populate stdin");
+
+	if (options->str_stdin.nr)
+		options->feed_pipe = &pipe_from_string_list;
+
 	strbuf_addstr(&hookname_str, hookname);
 
 	to_run = hook_list(&hookname_str);
@@ -368,7 +405,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
 				   notify_start_failure,
-				   NULL,
+				   options->feed_pipe,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/hook.h b/hook.h
index 8a7542610c..0ac83fa7ca 100644
--- a/hook.h
+++ b/hook.h
@@ -2,6 +2,7 @@
 #include "list.h"
 #include "strbuf.h"
 #include "strvec.h"
+#include "run-command.h"
 
 struct hook
 {
@@ -14,6 +15,12 @@ struct hook
 	/* The literal command to run. */
 	struct strbuf command;
 	int from_hookdir;
+
+	/*
+	 * Use this to keep state for your feed_pipe_fn if you are using
+	 * run_hooks_opt.feed_pipe. Otherwise, do not touch it.
+	 */
+	void *feed_pipe_cb_data;
 };
 
 /*
@@ -57,12 +64,24 @@ struct run_hooks_opt
 
 	/* Path to file which should be piped to stdin for each hook */
 	const char *path_to_stdin;
+	/* Pipe each string to stdin, separated by newlines */
+	struct string_list str_stdin;
+	/*
+	 * Callback and state pointer to ask for more content to pipe to stdin.
+	 * Will be called repeatedly, for each hook. See
+	 * hook.c:pipe_from_stdin() for an example. Keep per-hook state in
+	 * hook.feed_pipe_cb_data (per process). Keep initialization context in
+	 * feed_pipe_ctx (shared by all processes).
+	 */
+	feed_pipe_fn feed_pipe;
+	void *feed_pipe_ctx;
 
 	/* Number of threads to parallelize across */
 	int jobs;
 
 	/* Path to initial working directory for subprocess */
 	const char *dir;
+
 };
 
 /*
@@ -81,6 +100,9 @@ struct hook_cb_data {
 	.path_to_stdin = NULL,			\
 	.jobs = 1,				\
 	.dir = NULL,				\
+	.str_stdin = STRING_LIST_INIT_DUP,	\
+	.feed_pipe = NULL,			\
+	.feed_pipe_ctx = NULL,			\
 	.run_hookdir = configured_hookdir_opt()	\
 }
 
@@ -90,6 +112,9 @@ struct hook_cb_data {
 	.path_to_stdin = NULL,			\
 	.jobs = configured_hook_jobs(),		\
 	.dir = NULL,				\
+	.str_stdin = STRING_LIST_INIT_DUP,	\
+	.feed_pipe = NULL,			\
+	.feed_pipe_ctx = NULL,			\
 	.run_hookdir = configured_hookdir_opt()	\
 }
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

