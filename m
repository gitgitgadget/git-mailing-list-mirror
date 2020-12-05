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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA2C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5217122DBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgLEBr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbgLEBr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:47:59 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F986C08E864
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s30so2553917ybe.15
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/k10iA52eh9k+kpE7X1UGt/QRk/HBhUx/d0hlLJ8Hxo=;
        b=LtMbcRgw32l6I7qtiHbEfj+smfODYLb/iqf5wd98yRlNyQ+ISqP1Z4AIPZNgkgOdn2
         9SIb+mxSGWgnMQ98AAEUZ6t9VzE12RPzzvDesOB2Kiho/Vwo6biXkXzdV/oqS9Y7c+yj
         bT5iPRg3lxCCbC95G1+XSliohTrZ0c8qadGG4J91RuSJO+LkJtfozjeuyMyVXoOlSxlj
         4N5MVuTCisb+OZNZQ8xP+HH7GlXQJBwIjxXgdA/x6DOhfpL98pMlh93rINr8s2FQ+2sp
         fiQXAqDQTIhGtGYKPyyZgW3KF/BO804dZSbWIHrTxAPfcALHX/4GpqTXNxTOfaAFc30r
         AJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/k10iA52eh9k+kpE7X1UGt/QRk/HBhUx/d0hlLJ8Hxo=;
        b=QcQyDScky3xWATwP9y/ndTjRSU1e/VicEFqFKMnuf+3GRi8HIz9P/YbzO17dUBTjFy
         D3GI7Gml6711lKYa+tmz1OFf72kV7ZALWKMGP1mjREUeZYx+2+teK7InmUeBSDEBGnSY
         j8wbUe+SK7pbTTHoip+SWgiKV/NomjvY+lxE4sIlRv5T2TMI0db3I0VfJwm7EKiwIgvJ
         bs9Gw5oglnIvkfd7LCiRoq8iyvPSbWrbqDFeIuZfspTnMoYyigQRV7X1mZF+lZpom7EC
         QJPrsznoHpApArpFPHTPk+xs5J26li1f4ng6Fh6LSN/QRsv1b1vtxFIEyHerJnD5iJR7
         SsGQ==
X-Gm-Message-State: AOAM532KF9rPCX8xf/LbY/s2coPYLdlf0ZLH0LF97/TZWTwC9y93Dukg
        vp9j2lGvEln33a3bG9jZKhhyC1yEczp5pzQYrq3wuTP/hayGx9LktNyTb3/50EpP3fMeTYRKShw
        D+aGMUWNuOBfdfXVz2ihleaMeReHQhUPrK37NcGMCxA2H4MAsffrlzafEQjpr26jVR5URZrUkQQ
        ==
X-Google-Smtp-Source: ABdhPJwkDSJrqXXI5RSAT/Y5Rd8ozrR9en1qktz98lh2ffrqt6Rb3ZDvOZkDXEAMaJDJjJZCZBXcf2FqszPwEknNy6c=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:5b89:: with SMTP id
 p131mr9381798ybb.310.1607132802491; Fri, 04 Dec 2020 17:46:42 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:46:05 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-16-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 15/17] hook: provide stdin by string_list or callback
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
 hook.c | 39 +++++++++++++++++++++++++++++++++++++++
 hook.h | 25 +++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/hook.c b/hook.c
index f0c052d847..fbb49f241d 100644
--- a/hook.c
+++ b/hook.c
@@ -9,6 +9,8 @@ void free_hook(struct hook *ptr)
 {
 	if (ptr) {
 		strbuf_release(&ptr->command);
+		if (ptr->feed_pipe_cb_data)
+			free(ptr->feed_pipe_cb_data);
 		free(ptr);
 	}
 }
@@ -38,6 +40,7 @@ static void append_or_move_hook(struct list_head *head, const char *command)
 		strbuf_init(&to_add->command, 0);
 		strbuf_addstr(&to_add->command, command);
 		to_add->from_hookdir = 0;
+		to_add->feed_pipe_cb_data = NULL;
 	}
 
 	/* re-set the scope so we show where an override was specified */
@@ -253,9 +256,32 @@ void run_hooks_opt_clear(struct run_hooks_opt *o)
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
@@ -277,6 +303,10 @@ static int pick_next_hook(struct child_process *cp,
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
@@ -350,6 +380,14 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
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
@@ -368,6 +406,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
 				   notify_start_failure,
+				   options->feed_pipe,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/hook.h b/hook.h
index 4aae8e2dbb..ace26c637e 100644
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

