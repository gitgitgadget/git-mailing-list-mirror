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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D21C4360C
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F155864FDF
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCKCLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhCKCLS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:18 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710AEC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:18 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id t19so14435529qta.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zmKnU5JQTIiX1yJYC8uTcq37/BNrhHT+TN8H00corv0=;
        b=T7asWaS/90Ji+ZWJ+e3ygMS4V9FhlrxdvEkT/p/IzlBKe7YxAfLbasnYB/YAuZsgLV
         qDPzCvqqPuYOBIMlGhlEywlqH+YssZkO3HRLOlYBVY4/s04ubBg+r7c8PGvf+Sx2cMG4
         dmwz4JCii7cXb3qbPP9LoJTBih+514mR0gUUfwWx6IeHj8V+/Qq/CNuw4CzoTy3CX9nr
         W9RqDDNAt8HNo3X0Au7yy2PXVg0fT0lhMNX1QpfCK//7QbAIws2rxuw/mwtp0osW1rs/
         3eq9IA+T/dRP0DOtDtg7jSxO9+pXOzNaAKJ5ccpcUMojY6jyW5IVu3XxRQGoeUzedVrb
         p5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zmKnU5JQTIiX1yJYC8uTcq37/BNrhHT+TN8H00corv0=;
        b=I6EUlNyNrBB5qPjZ3wfc20NJ4wBvVgs36oKfYwT5dn+O06x5+B/B31HDUjaNBXrYCz
         OlH0uUrJl2n/tRrHMBJCFDoyoad/smjZxe5WZPG9zHU2fh5Oey3avxcpfX7565sbwPA/
         GFQvkVF5hIXcRScbVeI3+1e70eoDeaMRIT3l7dPVIRSxAxZODsv/toTQRoiK6noaNIfr
         njoVFT303neuvzXOywBevdXsTKndURrxLqo7wxLIBggISy1//vzHCkZ3B9NuuYaKZyRx
         4vhPPSm+APG/35wepT9LePkUM0JG4cBICoYjPm5l9GGYCN57SU+C3QrZoA4tTvhPbjzr
         DRwA==
X-Gm-Message-State: AOAM532599YIwnqGkuNcVeVeLmiQNnJJ8W7gG0hMpt7XRQCulyNATFTl
        Qq4VjEF6d03Ad/LPANQ2ueJs0NgVe5HfTB8TbaI3d+ds5V5xOSCuY1F7hm+kpfytwllVtMQO5ZC
        qTM+3g9LCYPR2nFy2Ywsu/uBUdv4eKZk4LWqwhHLkPQNiPIESBuuJoSSIOoa0xEoUp5WlaSuWkg
        ==
X-Google-Smtp-Source: ABdhPJxKcfIz75YKHhJT4x/2QQfnabA9x7xSkt1V6bzyH7bypwIeiT4G4EiVtyKm3hM08qwVL0pgYzx+vi6CtaRpp0I=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:c60b:: with SMTP id
 v11mr5799743qvi.44.1615428677602; Wed, 10 Mar 2021 18:11:17 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:15 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-16-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 15/37] hook: provide stdin by string_list or callback
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
 hook.c | 35 ++++++++++++++++++++++++++++++++++-
 hook.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 9088b520f3..a509d2d80e 100644
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
@@ -39,6 +40,7 @@ static void append_or_move_hook(struct list_head *head, const char *command)
 		strbuf_init(&to_add->command, 0);
 		strbuf_addstr(&to_add->command, command);
 		to_add->from_hookdir = 0;
+		to_add->feed_pipe_cb_data = NULL;
 	}
 
 	/* re-set the scope so we show where an override was specified */
@@ -252,6 +254,8 @@ void run_hooks_opt_init_sync(struct run_hooks_opt *o)
 	o->run_hookdir = configured_hookdir_opt();
 	o->jobs = 1;
 	o->dir = NULL;
+	o->feed_pipe = NULL;
+	o->feed_pipe_ctx = NULL;
 }
 
 void run_hooks_opt_init_async(struct run_hooks_opt *o)
@@ -285,6 +289,28 @@ void run_hooks_opt_clear(struct run_hooks_opt *o)
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
@@ -300,6 +326,10 @@ static int pick_next_hook(struct child_process *cp,
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
@@ -379,6 +409,9 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if (options->path_to_stdin && options->feed_pipe)
+		BUG("choose only one method to populate stdin");
+
 	strbuf_addstr(&hookname_str, hookname);
 
 	to_run = hook_list(&hookname_str);
@@ -400,7 +433,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
 				   notify_start_failure,
-				   NULL,
+				   options->feed_pipe,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/hook.h b/hook.h
index fcd8e99e39..ecf0228a46 100644
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
2.31.0.rc2.261.g7f71774620-goog

