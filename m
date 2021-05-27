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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9B4C47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53659613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbhE0AL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbhE0ALB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:01 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCC8C06138C
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:28 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id u9-20020a05620a4549b02902e956c2a3c8so2066970qkp.20
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=osfYIeU0d2TJ9wVVo18P/YFkWV2BzEx8rkzomjPT40g=;
        b=rM/0XABWDppTCMRkqz65ehllrcaJa4VHxjcOCqpDaP2ixW0TONIoob1BTXs9kBTBA+
         Ssak6DXRN6ePXi/037WBvozlNKhKlKszOv/fhDHsgrfvwoCZI0BPKvol1BMWZJnD8cGr
         NhJ3pkLrR4kFuWkTMy3j1L3HNYCwFpmE5nwmZ4hIbx+4w/RkrVUU7TI77U7w8qV2pFry
         ecqHw9t1nkC/1cbYjSK8TNSwL/VGkK2htGKk+GV0upetQdqc7PcIfENGoT7E0s+iNMxj
         S9H5FzFuZH36z2CZYCsBDt3vPzqJkc0gelvtlci0utisdWRsAWL9a+6ulZIZdMbHi1JL
         Hrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=osfYIeU0d2TJ9wVVo18P/YFkWV2BzEx8rkzomjPT40g=;
        b=bRRnladeMCaw+qHhh2NHLZ5X0eTVbMGSDPLVZKq++1/PU8C1JEgzeoch3NXKn5gMFg
         BNtRUTHI6CPH+Fk1dYgZSom8b275zKMYaMgcgJlKoPl4uM/k5jZoN8QZShm9J7qxrnFf
         /E0x8NXBnppWKEYih59wwVdfXa8xlnjPiH6i8gmd3FD5O4FeOtre8dBw9GxwB4qhtXf3
         7piAvCfahJB025a1qIQ/Wx/0Q/C41X4m9qoA+lRQhAuKhOhrhoVDK0JnBhT/1px8Sw6p
         Zwk6zXmqpCu328otPj2fs29TIXyBrKqXpf3exMVlCSIk+A16WfLJcQIx4l7zU/5JZhsy
         xqnw==
X-Gm-Message-State: AOAM5337ob8KMNXORx27smVlvh/VdLyd/leZjTyky27g+qSjhPZaYFgF
        2r1khUR5X40pswZFqCl68Js0AMAGeGvZYS4BINDM1mipVxn97mv10a3NZmpMYMrVTiYzc1+i7HI
        AMqV8hae872IDMdaQ0Mk/Zdk6nhYVPzTSgpg8/Yzb7DD7GyD8i5ZMs8MGrsBpp0LG9dupqB5d/w
        ==
X-Google-Smtp-Source: ABdhPJx6GosKm5Qyn7oju9FB53x6aZNhVtathjZLzVqENEWAto7wDTHZ4K/IoFl58L1jKmMgeRSq+dB8YuezYTRDREc=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:ee23:: with SMTP id
 l3mr1004986qvs.55.1622074167964; Wed, 26 May 2021 17:09:27 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:33 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-15-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 14/37] hook: provide stdin by string_list or callback
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
 hook.c | 38 ++++++++++++++++++++++++++++++++++++--
 hook.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/hook.c b/hook.c
index 1fa7976583..8aa0d4fdf2 100644
--- a/hook.c
+++ b/hook.c
@@ -7,8 +7,10 @@
 
 void free_hook(struct hook *ptr)
 {
-	if (ptr)
+	if (ptr) {
 		strbuf_release(&ptr->command);
+		free(ptr->feed_pipe_cb_data);
+	}
 	free(ptr);
 }
 
@@ -38,6 +40,7 @@ static void append_or_move_hook(struct list_head *head, const char *command)
 		strbuf_init(&to_add->command, 0);
 		strbuf_addstr(&to_add->command, command);
 		to_add->from_hookdir = 0;
+		to_add->feed_pipe_cb_data = NULL;
 	}
 
 	/* re-set the scope so we show where an override was specified */
@@ -257,6 +260,8 @@ void run_hooks_opt_init_sync(struct run_hooks_opt *o)
 	o->run_hookdir = configured_hookdir_opt();
 	o->jobs = 1;
 	o->dir = NULL;
+	o->feed_pipe = NULL;
+	o->feed_pipe_ctx = NULL;
 }
 
 void run_hooks_opt_init_async(struct run_hooks_opt *o)
@@ -290,6 +295,28 @@ void run_hooks_opt_clear(struct run_hooks_opt *o)
 	strvec_clear(&o->args);
 }
 
+int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb)
+{
+	int *item_idx;
+	struct hook *ctx = pp_task_cb;
+	struct string_list *to_pipe = ((struct hook_cb_data*)pp_cb)->options->feed_pipe_ctx;
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
@@ -305,6 +332,10 @@ static int pick_next_hook(struct child_process *cp,
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
@@ -383,6 +414,9 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if (options->path_to_stdin && options->feed_pipe)
+		BUG("choose only one method to populate stdin");
+
 	to_run = hook_list(hookname);
 
 	list_for_each_safe(pos, tmp, to_run) {
@@ -402,7 +436,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
 				   notify_start_failure,
-				   NULL,
+				   options->feed_pipe,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/hook.h b/hook.h
index 218b9e1721..aba62d4112 100644
--- a/hook.h
+++ b/hook.h
@@ -2,6 +2,7 @@
 #include "list.h"
 #include "strbuf.h"
 #include "strvec.h"
+#include "run-command.h"
 
 struct hook {
 	struct list_head list;
@@ -13,6 +14,12 @@ struct hook {
 	/* The literal command to run. */
 	struct strbuf command;
 	unsigned from_hookdir : 1;
+
+	/*
+	 * Use this to keep state for your feed_pipe_fn if you are using
+	 * run_hooks_opt.feed_pipe. Otherwise, do not touch it.
+	 */
+	void *feed_pipe_cb_data;
 };
 
 /*
@@ -58,14 +65,35 @@ struct run_hooks_opt
 
 	/* Path to file which should be piped to stdin for each hook */
 	const char *path_to_stdin;
+	/*
+	 * Callback and state pointer to ask for more content to pipe to stdin.
+	 * Will be called repeatedly, for each hook. See
+	 * hook.c:pipe_from_stdin() for an example. Keep per-hook state in
+	 * hook.feed_pipe_cb_data (per process). Keep initialization context in
+	 * feed_pipe_ctx (shared by all processes).
+	 *
+	 * See 'pipe_from_string_list()' for info about how to specify a
+	 * string_list as the stdin input instead of writing your own handler.
+	 */
+	feed_pipe_fn feed_pipe;
+	void *feed_pipe_ctx;
 
 	/* Number of threads to parallelize across */
 	int jobs;
 
 	/* Path to initial working directory for subprocess */
 	const char *dir;
+
 };
 
+/*
+ * To specify a 'struct string_list', set 'run_hooks_opt.feed_pipe_ctx' to the
+ * string_list and set 'run_hooks_opt.feed_pipe' to 'pipe_from_string_list()'.
+ * This will pipe each string in the list to stdin, separated by newlines.  (Do
+ * not inject your own newlines.)
+ */
+int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb);
+
 /*
  * Callback provided to feed_pipe_fn and consume_sideband_fn.
  */
-- 
2.31.1.818.g46aad6cb9e-goog

