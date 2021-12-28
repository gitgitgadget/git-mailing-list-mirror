Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A7FC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 19:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhL1Tgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 14:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbhL1Tgs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 14:36:48 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6B3C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r17so40172527wrc.3
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QPndysMS5d9HtSVD2Y4SedG3uUuo8ie3ZHyRfzHOZ4w=;
        b=YLB1u/C64wM6mAEKKrVcHLoov2pruFKwbzDN5rkxkvxIFpKAfg02fi+nGwTeKZnhub
         Zqs2FO9qRoWLIdKui73b4fvrkYzkd6J8kUVI+DRxPO9z5EXewtOyNWwfzsJlWV/RzEOl
         rytwlV3O00G3EJmC118mx/IZRfnTeei9YOEVXmD23LhPaJiNrRqrxwaIE9U3A2bsyERp
         QSt0GYWcj2+37tZZReSU3BhdTtQnFp5N6L0ukRKiNoJdRZ9mNoqmP1ROB2s7MkeMf3p8
         L8L/nYun2lJA4VC7ix0Y6PplhhwCTgHoQHBHzSKz3aPsk7Iq5atDc9usHkzRlQS785+V
         nB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QPndysMS5d9HtSVD2Y4SedG3uUuo8ie3ZHyRfzHOZ4w=;
        b=5t18jpl9bEwGEFxp4ifJl+OhKV2j+Qj6BnAaQoi2jk+764RZrp8VQGcB7A6mTUVX9q
         Uh2+mPaAP0g7NZHV0OLqU5KcTYkFGiI4YqM/GCuCaJhPU6mknqt7Obvj93B2tcd/Z8TP
         i3mUqWZxYwQ+dQO+JMucyxVy4UlBmZVslBZ5nXtzpseohVH40wPziY/eIr6wiyU7t/GN
         2BEignDGWp2p8UZuKbfU40IPueWfBIKh2XAF9maLJO9Mzky3k7hWritSjqgDZrF8EyZ0
         Wacri8bkedNQDUPoucqVez1k+gkyCUvDDyhgJVBBPsaAxjb+VXihTMSUbtjH2uL73TF3
         qx9g==
X-Gm-Message-State: AOAM531Hv70sOCEzNHBNzvG7idWWIveZhH2RMtB0b0rphDgFaOKcqjEZ
        SZ7iExvl5HYBbzecRzCuPokoiJ5/kCU=
X-Google-Smtp-Source: ABdhPJyKwryZi8Ckc5QirvABuA3kOs8spBvO5BcYzmaLveFp54nsrEPWjyVvL1+aMIRGWISA2el36w==
X-Received: by 2002:a5d:66d2:: with SMTP id k18mr17882988wrw.430.1640720206152;
        Tue, 28 Dec 2021 11:36:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a198sm19074377wmd.42.2021.12.28.11.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 11:36:45 -0800 (PST)
Message-Id: <531a1ee45c2ff6dfd61f83ccbafc31465f0d9e80.1640720202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 19:36:37 +0000
Subject: [PATCH v2 4/9] trace2: add thread-name override to event target
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach the message formatter in the Trace2 event target to take an
optional thread-name argument.  This overrides the thread name
inherited from the thread local storage data.

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

