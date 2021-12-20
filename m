Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AE5C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 17:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbhLTRN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 12:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbhLTRNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 12:13:25 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4A2C061746
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:13:24 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y22so41229038edq.2
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lRc0iJzVVG44/3Sp5T8Ga5PUVpCk0nXeCDyRT/wUQJM=;
        b=d1J4hBJWSw/xBHqjtYx8Sgrz3Y6rPxFoV2ZsTV3DhZdxurj1UzkH24RRQ/AZ7S8t9T
         P+X2mi+ayNjztnaKgP43EQ2/vtD5kyqVGvPOHce18PvGdkeWl5psfb1m2dWjosjv+3tp
         3bnDOht8h879+SOa9/7ai29hKNzJZCUyG7LCy6lbU0gt7BdyxjozRaNPDz3YpPUiunxg
         oauUlXuW/EAED1OxKiLJ9DJQlcoL04/WWOJN6vFLqfb7sPFYVOBltnfOvqHfGW2M4pec
         VJZwrIeVbz3UHGMs4a5txvHq7HcSVhqbOnn0oA5xQft0ex7ULYqACsQmu0xsxnKAAXv+
         FoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lRc0iJzVVG44/3Sp5T8Ga5PUVpCk0nXeCDyRT/wUQJM=;
        b=yeW4OtWcoRIdLs3CZY355roaxKmYq0jyLSyZVbB9UXC8bX9Fw2W5aJrtpApjIp/M7M
         nZH957pyLQujIvTDFG7jpZ/Tqwo1kq8eeTO/6VvxbVknlOnikARhd7W1hdiHrFcsiCCY
         jXXkUTRLbhLZxtr8/ZuE//p1Mq8KzhQQJM51/nh98LABs6uacCmKDAwePxIJRZ1ga6p3
         6ymE21Wv8oY5bqqNipqnXipZMf0JUdnRbOuvQT0aOnQAsWbReFLt+Pgf9TrdNlrioSP2
         3RZlqmgNpK+rXXQNV7QtM5jAWOOYlI+TAZK/ZagN8XP6zkkLjniV7V+cixzqJeM8NHll
         tQgg==
X-Gm-Message-State: AOAM531RFZuX3nx+EJ58iPDEEdwnqeUgC19kdA/VXc7mSiTWRQhcOMLG
        AjNVeKOPPZhxDeqMHMBxb9afNs9CTOUayg==
X-Google-Smtp-Source: ABdhPJx82MhlwDdZKAhciqevxN3dsAWAeTpCCT3ztrAP8FdzmU4/Lf6j5sgK48zRgDc1QPeQybz3lg==
X-Received: by 2002:a17:907:a04b:: with SMTP id gz11mr13845271ejc.68.1640020403096;
        Mon, 20 Dec 2021 09:13:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gt7sm4277934ejc.180.2021.12.20.09.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 09:13:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzMDx-000UBv-Us;
        Mon, 20 Dec 2021 18:13:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 8/9] trace2: add counter events to perf and event target
 formats
Date:   Mon, 20 Dec 2021 17:51:30 +0100
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <3e39c8172f5de572c7b67f381d51631623a41762.1640012469.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <3e39c8172f5de572c7b67f381d51631623a41762.1640012469.git.gitgitgadget@gmail.com>
Message-ID: <211220.86czlrurm6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> [...]
> diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
> index 9b3905b920c..ca36d44dfd7 100644
> --- a/trace2/tr2_tgt_event.c
> +++ b/trace2/tr2_tgt_event.c
> @@ -23,7 +23,7 @@ static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0, 0 };
>   * Verison 1: original version
>   * Version 2: added "too_many_files" event
>   * Version 3: added "child_ready" event
> - * Version 4: added "timer" event
> + * Version 4: added "timer" and "counter" events
>   */
>  #define TR2_EVENT_VERSION "4"
>  

Nit on series structure: Earlier we bumped the version to 4, but here
we're changing existing version 4 behavior. Would be better IMO just
bump it at the end (if at all needed, per:
https://lore.kernel.org/git/211201.86zgpk9u3t.gmgdl@evledraar.gmail.com/)

> +static void fn_counter(uint64_t us_elapsed_absolute,
> +		       const char *thread_name,
> +		       const char *category,
> +		       const char *counter_name,
> +		       uint64_t value)
> +{
> +	const char *event_name = "counter";
> +	struct strbuf buf_payload = STRBUF_INIT;
> +
> +	strbuf_addf(&buf_payload, "name:%s", counter_name);
> +	strbuf_addf(&buf_payload, " value:%"PRIu64, value);

Odd to have these be two seperate strbuf_addf()...
> +
> +	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
> +			 &us_elapsed_absolute, NULL,
> +			 category, &buf_payload, thread_name);
> +	strbuf_release(&buf_payload);

...but more generally, and I see from e.g. the existing fn_version_fl
that you're just using existing patterns, but it seems odd not to have a
trivial varargs fmt helper for perf_io_write_fl that would avoid the
whole strbuf/addf/release dance.

I did a quick experiment to do that, patch on "master" below. A lot of
the boilerplate could be simplified by factoring out the
sq_quote_buf_pretty() case, and even this approach (re)allocs in a way
that looks avoidable in many cases if perf_fmt_prepare() were improved
(but it looks like it nedes its if/while loops in some cases still):

diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 2ff9cf70835..bcbb0d8a250 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -153,16 +153,33 @@ static void perf_io_write_fl(const char *file, int line, const char *event_name,
 	strbuf_release(&buf_line);
 }
 
+__attribute__((format (printf, 8, 9)))
+static void perf_io_write_fl_fmt(const char *file, int line, const char *event_name,
+				 const struct repository *repo,
+				 uint64_t *p_us_elapsed_absolute,
+				 uint64_t *p_us_elapsed_relative,
+				 const char *category,
+				 const char *fmt, ...)
+{
+	va_list ap;
+	struct strbuf sb = STRBUF_INIT;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	va_end(ap);
+
+	perf_io_write_fl(file, line, event_name, repo, p_us_elapsed_absolute,
+			 p_us_elapsed_relative, category, &sb);
+
+	strbuf_release(&sb);
+}
+
 static void fn_version_fl(const char *file, int line)
 {
 	const char *event_name = "version";
-	struct strbuf buf_payload = STRBUF_INIT;
-
-	strbuf_addstr(&buf_payload, git_version_string);
 
-	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
-	strbuf_release(&buf_payload);
+	perf_io_write_fl_fmt(file, line, event_name, NULL, NULL, NULL, NULL,
+			     "%s", git_version_string);
 }
 
 static void fn_start_fl(const char *file, int line,
@@ -182,37 +199,25 @@ static void fn_exit_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 		       int code)
 {
 	const char *event_name = "exit";
-	struct strbuf buf_payload = STRBUF_INIT;
 
-	strbuf_addf(&buf_payload, "code:%d", code);
-
-	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
-	strbuf_release(&buf_payload);
+	perf_io_write_fl_fmt(file, line, event_name, NULL, &us_elapsed_absolute,
+			     NULL, NULL, "code:%d", code);
 }
 
 static void fn_signal(uint64_t us_elapsed_absolute, int signo)
 {
 	const char *event_name = "signal";
-	struct strbuf buf_payload = STRBUF_INIT;
 
-	strbuf_addf(&buf_payload, "signo:%d", signo);
-
-	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
-			 &us_elapsed_absolute, NULL, NULL, &buf_payload);
-	strbuf_release(&buf_payload);
+	perf_io_write_fl_fmt(__FILE__, __LINE__, event_name, NULL,
+			 &us_elapsed_absolute, NULL, NULL, "signo:%d", signo);
 }
 
 static void fn_atexit(uint64_t us_elapsed_absolute, int code)
 {
 	const char *event_name = "atexit";
-	struct strbuf buf_payload = STRBUF_INIT;
-
-	strbuf_addf(&buf_payload, "code:%d", code);
 
-	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
-			 &us_elapsed_absolute, NULL, NULL, &buf_payload);
-	strbuf_release(&buf_payload);
+	perf_io_write_fl_fmt(__FILE__, __LINE__, event_name, NULL,
+			 &us_elapsed_absolute, NULL, NULL, "code:%d", code);
 }
 
 static void maybe_append_string_va(struct strbuf *buf, const char *fmt,
@@ -244,13 +249,9 @@ static void fn_error_va_fl(const char *file, int line, const char *fmt,
 static void fn_command_path_fl(const char *file, int line, const char *pathname)
 {
 	const char *event_name = "cmd_path";
-	struct strbuf buf_payload = STRBUF_INIT;
-
-	strbuf_addstr(&buf_payload, pathname);
 
-	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
-	strbuf_release(&buf_payload);
+	perf_io_write_fl_fmt(file, line, event_name, NULL, NULL, NULL, NULL,
+			     "%s", pathname);
 }
 
 static void fn_command_ancestry_fl(const char *file, int line, const char **parent_names)
@@ -286,13 +287,9 @@ static void fn_command_name_fl(const char *file, int line, const char *name,
 static void fn_command_mode_fl(const char *file, int line, const char *mode)
 {
 	const char *event_name = "cmd_mode";
-	struct strbuf buf_payload = STRBUF_INIT;
-
-	strbuf_addstr(&buf_payload, mode);
 
-	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
-	strbuf_release(&buf_payload);
+	perf_io_write_fl_fmt(file, line, event_name, NULL, NULL, NULL, NULL,
+			     "%s", mode);
 }
 
 static void fn_alias_fl(const char *file, int line, const char *alias,
@@ -351,13 +348,10 @@ static void fn_child_exit_fl(const char *file, int line,
 			     int code, uint64_t us_elapsed_child)
 {
 	const char *event_name = "child_exit";
-	struct strbuf buf_payload = STRBUF_INIT;
 
-	strbuf_addf(&buf_payload, "[ch%d] pid:%d code:%d", cid, pid, code);
-
-	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 &us_elapsed_child, NULL, &buf_payload);
-	strbuf_release(&buf_payload);
+	perf_io_write_fl_fmt(file, line, event_name, NULL, &us_elapsed_absolute,
+			     &us_elapsed_child, NULL, "[ch%d] pid:%d code:%d",
+			     cid, pid, code);
 }
 
 static void fn_child_ready_fl(const char *file, int line,
@@ -365,24 +359,19 @@ static void fn_child_ready_fl(const char *file, int line,
 			      const char *ready, uint64_t us_elapsed_child)
 {
 	const char *event_name = "child_ready";
-	struct strbuf buf_payload = STRBUF_INIT;
-
-	strbuf_addf(&buf_payload, "[ch%d] pid:%d ready:%s", cid, pid, ready);
 
-	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 &us_elapsed_child, NULL, &buf_payload);
-	strbuf_release(&buf_payload);
+	perf_io_write_fl_fmt(file, line, event_name, NULL, &us_elapsed_absolute,
+			     &us_elapsed_child, NULL,
+			     "[ch%d] pid:%d ready:%s", cid, pid, ready);
 }
 
 static void fn_thread_start_fl(const char *file, int line,
 			       uint64_t us_elapsed_absolute)
 {
 	const char *event_name = "thread_start";
-	struct strbuf buf_payload = STRBUF_INIT;
 
-	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
-	strbuf_release(&buf_payload);
+	perf_io_write_fl_fmt(file, line, event_name, NULL, &us_elapsed_absolute,
+			     NULL, NULL, "%s", ""); /* TODO: No payload, support NULL? */
 }
 
 static void fn_thread_exit_fl(const char *file, int line,
@@ -390,11 +379,9 @@ static void fn_thread_exit_fl(const char *file, int line,
 			      uint64_t us_elapsed_thread)
 {
 	const char *event_name = "thread_exit";
-	struct strbuf buf_payload = STRBUF_INIT;
 
-	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 &us_elapsed_thread, NULL, &buf_payload);
-	strbuf_release(&buf_payload);
+	perf_io_write_fl_fmt(file, line, event_name, NULL, &us_elapsed_absolute,
+			     &us_elapsed_thread, NULL, "%s", ""); /* TODO: No payload, support NULL ? */
 }
 
 static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
@@ -438,13 +425,9 @@ static void fn_param_fl(const char *file, int line, const char *param,
 			const char *value)
 {
 	const char *event_name = "def_param";
-	struct strbuf buf_payload = STRBUF_INIT;
-
-	strbuf_addf(&buf_payload, "%s:%s", param, value);
 
-	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
-	strbuf_release(&buf_payload);
+	perf_io_write_fl_fmt(file, line, event_name, NULL, NULL, NULL, NULL,
+			     "%s:%s", param, value);
 }
 
 static void fn_repo_fl(const char *file, int line,
@@ -525,13 +508,10 @@ static void fn_data_json_fl(const char *file, int line,
 			    const struct json_writer *value)
 {
 	const char *event_name = "data_json";
-	struct strbuf buf_payload = STRBUF_INIT;
-
-	strbuf_addf(&buf_payload, "%s:%s", key, value->json.buf);
 
-	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
-			 &us_elapsed_region, category, &buf_payload);
-	strbuf_release(&buf_payload);
+	perf_io_write_fl_fmt(file, line, event_name, repo, &us_elapsed_absolute,
+			     &us_elapsed_region, category,
+			     "%s:%s", key, value->json.buf);
 }
 
 static void fn_printf_va_fl(const char *file, int line,
