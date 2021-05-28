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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C02C4708D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7A5613E6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhE1MOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbhE1MNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F91AC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so6684540wmc.0
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQQjhSTHoH4IiTKM5fGNPEQJLpMyCBbHyQthfVCwWaA=;
        b=RoII6yVx4gSV/dsVuSszgQErZ73j/H2jw5VUnn7p0hZ73YjP2pcN6kKlL2o8cdD7yA
         +dvj/gbXN5vlZe0pUU1WR/urfhu8M5nOkNAfXjPnb8S/kGcVTHpK1h9o8tICf37+QT8/
         35oItRCPAQ/Z+4rPqk9o4BfwJNznLaZfBXGe8lr7VuwdC+/TuadOqmhm4LdJ8wrz+4Gq
         gmlUrRwr0g0Y8BWy8UqVC/nL947PGO8MtPR6+S+xRVUj1W/3Nxbuyo2jxJYvPqUFPSwC
         bFulzinqU1TnQvTyBrTlbcilM95GfTGh2dYvmtPWm1M7Xv6eE3HoZlkoH3i3gPRovSlW
         6iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQQjhSTHoH4IiTKM5fGNPEQJLpMyCBbHyQthfVCwWaA=;
        b=CB92SO+1iaNri3QYxTf7T7haTkN0BpgG5D0W9Sea6wdvM/SH5YtIYRL/CySHJgToU8
         2fGcw94UlxLcXbU+S5z7IXmSm57GvoIgtCadrIRJ8zo/odAp4JKl618OLo6QG6wdMifF
         31AtZxHCRiFB3C4BG30xa6INOJADMLg6sJwMzZt0TFa0Y1/1QszXrmFHq6neAh0o3OUp
         IXq1Rb2WNDXnbb7dcWxPpxhBC5Mp1KYEv5GjWrn1zjucffb/7VfbGwf3m/ub/6iX6Kqz
         xL+6OYXKJnNN2o0K6tWd7WC6AT+hxDFTaknHLlNNc3JBsF00pBty2wUY9s55lGZZ9Lo9
         Zkdg==
X-Gm-Message-State: AOAM533b4rZYH56QdOi5bw+mhla28jBMeGLZ9zxlOZUJjTJqoJmrKs6t
        7sJw293vpXOS+IuMDtnCBJreIAv32Gik3Q==
X-Google-Smtp-Source: ABdhPJxGZxbcGZXRKZw8vaADo4EDFPs/7mtGLF1VyeoL0UrrnZX7Hdphvv/Bdie+m9HgrhdXa00YCA==
X-Received: by 2002:a7b:c0cf:: with SMTP id s15mr13518986wmh.134.1622203919583;
        Fri, 28 May 2021 05:11:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:59 -0700 (PDT)
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
Subject: [PATCH 21/31] hook: provide stdin by string_list or callback
Date:   Fri, 28 May 2021 14:11:23 +0200
Message-Id: <patch-21.31-3748f128763-20210528T110515Z-avarab@gmail.com>
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

In cases where a hook requires only a small amount of information via
stdin, it should be simple for users to provide a string_list alone. But
in more complicated cases where the stdin is too large to hold in
memory, let's provide a callback the users can populate line after line
with instead.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 33 +++++++++++++++++++++++++++++++--
 hook.h | 27 +++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/hook.c b/hook.c
index 5f6335bac3f..ac5e3988fec 100644
--- a/hook.c
+++ b/hook.c
@@ -47,6 +47,29 @@ void run_hooks_opt_clear(struct run_hooks_opt *o)
 	strvec_clear(&o->args);
 }
 
+int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb)
+{
+	int *item_idx;
+	struct hook *ctx = pp_task_cb;
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct string_list *to_pipe = hook_cb->options->feed_pipe_ctx;
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
@@ -62,6 +85,10 @@ static int pick_next_hook(struct child_process *cp,
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
@@ -114,7 +141,6 @@ static int notify_hook_finished(int result,
 	return 1;
 }
 
-
 int run_found_hooks(const char *hook_name, const char *hook_path,
 		    struct run_hooks_opt *options)
 {
@@ -139,7 +165,7 @@ int run_found_hooks(const char *hook_name, const char *hook_path,
 	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
 				   notify_start_failure,
-				   NULL,
+				   options->feed_pipe,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
@@ -157,6 +183,9 @@ int run_hooks(const char *hook_name, struct run_hooks_opt *options)
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if (options->path_to_stdin && options->feed_pipe)
+		BUG("choose only one method to populate stdin");
+
 	hook_path = find_hook(hook_name);
 
 	/* Care about nonexistence? Use run_found_hooks() */
diff --git a/hook.h b/hook.h
index 74a8c76a94c..ff1697d1087 100644
--- a/hook.h
+++ b/hook.h
@@ -7,6 +7,12 @@
 struct hook {
 	/* The path to the hook */
 	const char *hook_path;
+
+	/*
+	 * Use this to keep state for your feed_pipe_fn if you are using
+	 * run_hooks_opt.feed_pipe. Otherwise, do not touch it.
+	 */
+	void *feed_pipe_cb_data;
 };
 
 struct run_hooks_opt
@@ -30,6 +36,19 @@ struct run_hooks_opt
 
 	/* Path to file which should be piped to stdin for each hook */
 	const char *path_to_stdin;
+
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
 };
 
 #define RUN_HOOKS_OPT_INIT { \
@@ -38,6 +57,14 @@ struct run_hooks_opt
 	.args = STRVEC_INIT, \
 }
 
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
2.32.0.rc1.458.gd885d4f985c

