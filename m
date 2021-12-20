Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB9AC433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbhLTPVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240223AbhLTPTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:19:48 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7F4C0698DB
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:14 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s1so15285088wra.6
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0BdkwbvT8/fGDnjb4KnHA2Vi+oykkkyrvK4HCWgqGN4=;
        b=N0HZbE+LIOZEG5Qtg24ypRnXzArif6iA2bspqj9HJrwVQ+oHZmQ/hq2kaXFQnzm9kw
         d8workgBCz977sJSjfVhu7fdMFHmql3KBEjgVXVLPptIA0XddW1fdEGOQeQ9EQwxRNoi
         r41yHelhpzFWQm/PTNZqCGRTew+js/3VjRG5MHohaU/ENfv8UFTKvFmxAFGMtbDlkTXw
         IrwH6WF8trs2cqoe9rR8P+lo6VcVJJitGzJWPo2hq16Oc8VQlAK2D6pOcYZcR0PZEcyK
         OfQx7HxQBzId5NKvlcTIgqgnydABp/+O3rrDxkmYyWoXNKoos5et2Edo5GFMZozUzHH4
         U7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0BdkwbvT8/fGDnjb4KnHA2Vi+oykkkyrvK4HCWgqGN4=;
        b=SbYFJX3e4zOHMJ6xrtI7vdnpMSfHcmaGmUDFy4a9p5WrA1v1T2E63Wwj15Nxk9n39K
         UCDUW8wr0WgSR6GeG9w0xVLKl4Py8Bhi70+lNywzsQ4HBcRMcDUJeKKRaT6a+x68TnKk
         qBxCUs9RMISrVLWV0VqACwPQmfwbiILwtmCEHVEE+Pvkxdg08ql95xEYVVd5sZBIQzAY
         aG/+95mWCSJFYqjxjFZPkOF/+LFedIEAfI3swmGK+SBAvz4Uebm3la2r+cCILA1s7pgQ
         A57frwyfb9mjVbwdyVPc9e0ddBvVa7bjwt1cmnVZu6foBB1sSkHTdVy6KuRa9L4kaEJ+
         aplQ==
X-Gm-Message-State: AOAM5310Nru07xKdozpUA/0V9+Tat5KBVdmHnykalan/LKJZcc3U18p4
        gPv0FhcKxKE1Dwu1/47DBCfyQXhHyeQ=
X-Google-Smtp-Source: ABdhPJxXDyUbXefQybvwq3ZrpeKXTd4asF6XiZgBNjE01Q08FOdllorZH3YCTykYdE2FRZSb0TkV9g==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr12926186wrs.494.1640012472892;
        Mon, 20 Dec 2021 07:01:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c187sm16734909wme.33.2021.12.20.07.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:01:12 -0800 (PST)
Message-Id: <e5021ab7f58e002410d2efe658064b3d8f3ec8ac.1640012469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:01:04 +0000
Subject: [PATCH 4/9] trace2: add thread-name override to event target
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach the Trace2 event target to allow the thread-name field to
be specified rather than always inherited from the TLS CTX.

This will be used in a future commit for global events that should
not be tied to a particular thread, such as a global stopwatch timer
that aggregates data from all threads.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_event.c | 59 ++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index ca48d00aebc..4ce50944298 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -81,14 +81,17 @@ static void fn_term(void)
  */
 static void event_fmt_prepare(const char *event_name, const char *file,
 			      int line, const struct repository *repo,
-			      struct json_writer *jw)
+			      struct json_writer *jw,
+			      const char *thread_name_override)
 {
-	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 	struct tr2_tbuf tb_now;
 
 	jw_object_string(jw, "event", event_name);
 	jw_object_string(jw, "sid", tr2_sid_get());
-	jw_object_string(jw, "thread", ctx->thread_name);
+	jw_object_string(jw, "thread",
+			 ((thread_name_override && *thread_name_override)
+			  ? thread_name_override
+			  : tr2tls_get_self()->thread_name));
 
 	/*
 	 * In brief mode, only emit <time> on these 2 event types.
@@ -114,7 +117,7 @@ static void fn_too_many_files_fl(const char *file, int line)
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_end(&jw);
 
 	tr2_dst_write_line(&tr2dst_event, &jw.json);
@@ -127,7 +130,7 @@ static void fn_version_fl(const char *file, int line)
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_string(&jw, "evt", TR2_EVENT_VERSION);
 	jw_object_string(&jw, "exe", git_version_string);
 	jw_end(&jw);
@@ -147,7 +150,7 @@ static void fn_start_fl(const char *file, int line,
 	double t_abs = (double)us_elapsed_absolute / 1000000.0;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_double(&jw, "t_abs", 6, t_abs);
 	jw_object_inline_begin_array(&jw, "argv");
 	jw_array_argv(&jw, argv);
@@ -166,7 +169,7 @@ static void fn_exit_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	double t_abs = (double)us_elapsed_absolute / 1000000.0;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_double(&jw, "t_abs", 6, t_abs);
 	jw_object_intmax(&jw, "code", code);
 	jw_end(&jw);
@@ -182,7 +185,7 @@ static void fn_signal(uint64_t us_elapsed_absolute, int signo)
 	double t_abs = (double)us_elapsed_absolute / 1000000.0;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
+	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw, NULL);
 	jw_object_double(&jw, "t_abs", 6, t_abs);
 	jw_object_intmax(&jw, "signo", signo);
 	jw_end(&jw);
@@ -198,7 +201,7 @@ static void fn_atexit(uint64_t us_elapsed_absolute, int code)
 	double t_abs = (double)us_elapsed_absolute / 1000000.0;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
+	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw, NULL);
 	jw_object_double(&jw, "t_abs", 6, t_abs);
 	jw_object_intmax(&jw, "code", code);
 	jw_end(&jw);
@@ -231,7 +234,7 @@ static void fn_error_va_fl(const char *file, int line, const char *fmt,
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	maybe_add_string_va(&jw, "msg", fmt, ap);
 	/*
 	 * Also emit the format string as a field in case
@@ -253,7 +256,7 @@ static void fn_command_path_fl(const char *file, int line, const char *pathname)
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_string(&jw, "path", pathname);
 	jw_end(&jw);
 
@@ -268,7 +271,7 @@ static void fn_command_ancestry_fl(const char *file, int line, const char **pare
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_inline_begin_array(&jw, "ancestry");
 
 	while ((parent_name = *parent_names++))
@@ -288,7 +291,7 @@ static void fn_command_name_fl(const char *file, int line, const char *name,
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_string(&jw, "name", name);
 	if (hierarchy && *hierarchy)
 		jw_object_string(&jw, "hierarchy", hierarchy);
@@ -304,7 +307,7 @@ static void fn_command_mode_fl(const char *file, int line, const char *mode)
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_string(&jw, "name", mode);
 	jw_end(&jw);
 
@@ -319,7 +322,7 @@ static void fn_alias_fl(const char *file, int line, const char *alias,
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_string(&jw, "alias", alias);
 	jw_object_inline_begin_array(&jw, "argv");
 	jw_array_argv(&jw, argv);
@@ -338,7 +341,7 @@ static void fn_child_start_fl(const char *file, int line,
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_intmax(&jw, "child_id", cmd->trace2_child_id);
 	if (cmd->trace2_hook_name) {
 		jw_object_string(&jw, "child_class", "hook");
@@ -371,7 +374,7 @@ static void fn_child_exit_fl(const char *file, int line,
 	double t_rel = (double)us_elapsed_child / 1000000.0;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_intmax(&jw, "child_id", cid);
 	jw_object_intmax(&jw, "pid", pid);
 	jw_object_intmax(&jw, "code", code);
@@ -392,7 +395,7 @@ static void fn_child_ready_fl(const char *file, int line,
 	double t_rel = (double)us_elapsed_child / 1000000.0;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_intmax(&jw, "child_id", cid);
 	jw_object_intmax(&jw, "pid", pid);
 	jw_object_string(&jw, "ready", ready);
@@ -411,7 +414,7 @@ static void fn_thread_start_fl(const char *file, int line,
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_end(&jw);
 
 	tr2_dst_write_line(&tr2dst_event, &jw.json);
@@ -427,7 +430,7 @@ static void fn_thread_exit_fl(const char *file, int line,
 	double t_rel = (double)us_elapsed_thread / 1000000.0;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_double(&jw, "t_rel", 6, t_rel);
 	jw_end(&jw);
 
@@ -442,7 +445,7 @@ static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_intmax(&jw, "exec_id", exec_id);
 	if (exe)
 		jw_object_string(&jw, "exe", exe);
@@ -463,7 +466,7 @@ static void fn_exec_result_fl(const char *file, int line,
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_intmax(&jw, "exec_id", exec_id);
 	jw_object_intmax(&jw, "code", code);
 	jw_end(&jw);
@@ -479,7 +482,7 @@ static void fn_param_fl(const char *file, int line, const char *param,
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	event_fmt_prepare(event_name, file, line, NULL, &jw, NULL);
 	jw_object_string(&jw, "param", param);
 	jw_object_string(&jw, "value", value);
 	jw_end(&jw);
@@ -495,7 +498,7 @@ static void fn_repo_fl(const char *file, int line,
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, file, line, repo, &jw);
+	event_fmt_prepare(event_name, file, line, repo, &jw, NULL);
 	jw_object_string(&jw, "worktree", repo->worktree);
 	jw_end(&jw);
 
@@ -516,7 +519,7 @@ static void fn_region_enter_printf_va_fl(const char *file, int line,
 		struct json_writer jw = JSON_WRITER_INIT;
 
 		jw_object_begin(&jw, 0);
-		event_fmt_prepare(event_name, file, line, repo, &jw);
+		event_fmt_prepare(event_name, file, line, repo, &jw, NULL);
 		jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
 		if (category)
 			jw_object_string(&jw, "category", category);
@@ -542,7 +545,7 @@ static void fn_region_leave_printf_va_fl(
 		double t_rel = (double)us_elapsed_region / 1000000.0;
 
 		jw_object_begin(&jw, 0);
-		event_fmt_prepare(event_name, file, line, repo, &jw);
+		event_fmt_prepare(event_name, file, line, repo, &jw, NULL);
 		jw_object_double(&jw, "t_rel", 6, t_rel);
 		jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
 		if (category)
@@ -570,7 +573,7 @@ static void fn_data_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 		double t_rel = (double)us_elapsed_region / 1000000.0;
 
 		jw_object_begin(&jw, 0);
-		event_fmt_prepare(event_name, file, line, repo, &jw);
+		event_fmt_prepare(event_name, file, line, repo, &jw, NULL);
 		jw_object_double(&jw, "t_abs", 6, t_abs);
 		jw_object_double(&jw, "t_rel", 6, t_rel);
 		jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
@@ -598,7 +601,7 @@ static void fn_data_json_fl(const char *file, int line,
 		double t_rel = (double)us_elapsed_region / 1000000.0;
 
 		jw_object_begin(&jw, 0);
-		event_fmt_prepare(event_name, file, line, repo, &jw);
+		event_fmt_prepare(event_name, file, line, repo, &jw, NULL);
 		jw_object_double(&jw, "t_abs", 6, t_abs);
 		jw_object_double(&jw, "t_rel", 6, t_rel);
 		jw_object_intmax(&jw, "nesting", ctx->nr_open_regions);
-- 
gitgitgadget

