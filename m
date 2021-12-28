Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB9AC43219
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 19:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbhL1Tgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 14:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbhL1Tgs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 14:36:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784D8C06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:48 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i22so40104134wrb.13
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LZo6Ali+pIOKbprOs1+/5JSDHn5wDx3xLyDit3UzAJ0=;
        b=k4HDnXLjmV+skYG9F/ui6i4tal0sZFXoFlKL8ligjLJ92uVuctJYBQhMw9HpeuqcAp
         uXXv/sGeF5PPBIhjpFFATkGxSfMBb8PJhFgmZZHQXy8zV8nhTBxKYNwkieTL3Wfi2F1J
         O1GJNvtzzYUW02BwLOa80QNenHH0EUiKX7tXAq5/+FzQ16tGvLeyBaNc+etuwykXQgIm
         ij7h+6gpSDXJFva5B25XQzeIB+kBasr5abnPgc7x9Y7PyTPdvXlWHavuV5HSls0JQoWn
         aUKKhLgO0It+WTVNhC6bTCPzt8x81x0qG/bEdt4PJuUeZnCmvYTIahnZeHzkgseVv7R8
         DZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LZo6Ali+pIOKbprOs1+/5JSDHn5wDx3xLyDit3UzAJ0=;
        b=jbP6h5aj2EuiBs/JvegJf3ZKut98IbBJWADS8IrlARAEvn8WlUyir6Rk/F2G+pF8Qc
         0Vc5ekuHe9NXWgWjOqj3OWxiqyenbj0frw7sjeHnGz6tkC3HN+dQGQ17eJXi3ENJDq+y
         sUAMSkbOKtHAQyFSZHtSVKGN8RuDmpQKxGRfSoJJT2PkRmkdt6ywoRik3U7mei9Y56m8
         cUEabF5miFJCeM/7MukbLUCLtrky3coSdgyrxnHLgprw12l11lxb35O9D5vBpx6iny9z
         EQC7Zyy7WsJFkoL0tSpeBdN0Vn19LbOhjX7/ISj2/cFw2lpvrA3TGwfmz1Kqa1CfNNqd
         GCpA==
X-Gm-Message-State: AOAM531GcUu2Y0iflZ8v0udYkgyOF8iZceogqqFXM/q6U6k73nunkHmF
        YinaMNrE5cc9bFmJ77WLK01xo9d/1NM=
X-Google-Smtp-Source: ABdhPJykhEXl4gh8EGEduejNvUC+2zvODaRwJq1vU3h96BqkZJfXmUUFElg1sGaYN4zM7bThOhT6bQ==
X-Received: by 2002:adf:f001:: with SMTP id j1mr17143443wro.431.1640720206810;
        Tue, 28 Dec 2021 11:36:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a22sm19388627wme.19.2021.12.28.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 11:36:46 -0800 (PST)
Message-Id: <82c445b75f1002bcfa0a770bd47038a747d98970.1640720202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 19:36:38 +0000
Subject: [PATCH v2 5/9] trace2: add thread-name override to perf target
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

Teach the message formatter in the Trace2 perf target to accept an
optional thread name argument.  This will override the thread name
inherited from the thread local storage data block.

This will be used in a future commit for global events that should
not be tied to a particular thread, such as a global stopwatch timer.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_perf.c | 64 +++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index fd6cce3efe5..c008fd08ae8 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -65,9 +65,14 @@ static void perf_fmt_prepare(const char *event_name,
 			     int line, const struct repository *repo,
 			     uint64_t *p_us_elapsed_absolute,
 			     uint64_t *p_us_elapsed_relative,
-			     const char *category, struct strbuf *buf)
+			     const char *category, struct strbuf *buf,
+			     const char *thread_name_override)
 {
 	int len;
+	const char *thread_name =
+		((thread_name_override && *thread_name_override)
+		 ? thread_name_override
+		 : ctx->thread_name);
 
 	strbuf_setlen(buf, 0);
 
@@ -107,7 +112,7 @@ static void perf_fmt_prepare(const char *event_name,
 
 	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
 	strbuf_addf(buf, "%-*.*s | %-*s | ", TR2FMT_PERF_MAX_THREAD_NAME,
-		    TR2FMT_PERF_MAX_THREAD_NAME, ctx->thread_name,
+		    TR2FMT_PERF_MAX_THREAD_NAME, thread_name,
 		    TR2FMT_PERF_MAX_EVENT_NAME, event_name);
 
 	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
@@ -141,14 +146,15 @@ static void perf_io_write_fl(const char *file, int line, const char *event_name,
 			     uint64_t *p_us_elapsed_absolute,
 			     uint64_t *p_us_elapsed_relative,
 			     const char *category,
-			     const struct strbuf *buf_payload)
+			     const struct strbuf *buf_payload,
+			     const char *thread_name_override)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 	struct strbuf buf_line = STRBUF_INIT;
 
 	perf_fmt_prepare(event_name, ctx, file, line, repo,
 			 p_us_elapsed_absolute, p_us_elapsed_relative, category,
-			 &buf_line);
+			 &buf_line, thread_name_override);
 	strbuf_addbuf(&buf_line, buf_payload);
 	tr2_dst_write_line(&tr2dst_perf, &buf_line);
 	strbuf_release(&buf_line);
@@ -162,7 +168,7 @@ static void fn_version_fl(const char *file, int line)
 	strbuf_addstr(&buf_payload, git_version_string);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -175,7 +181,7 @@ static void fn_start_fl(const char *file, int line,
 	sq_append_quote_argv_pretty(&buf_payload, argv);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -188,7 +194,7 @@ static void fn_exit_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	strbuf_addf(&buf_payload, "code:%d", code);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -200,7 +206,7 @@ static void fn_signal(uint64_t us_elapsed_absolute, int signo)
 	strbuf_addf(&buf_payload, "signo:%d", signo);
 
 	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
-			 &us_elapsed_absolute, NULL, NULL, &buf_payload);
+			 &us_elapsed_absolute, NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -212,7 +218,7 @@ static void fn_atexit(uint64_t us_elapsed_absolute, int code)
 	strbuf_addf(&buf_payload, "code:%d", code);
 
 	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
-			 &us_elapsed_absolute, NULL, NULL, &buf_payload);
+			 &us_elapsed_absolute, NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -238,7 +244,7 @@ static void fn_error_va_fl(const char *file, int line, const char *fmt,
 	maybe_append_string_va(&buf_payload, fmt, ap);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -250,7 +256,7 @@ static void fn_command_path_fl(const char *file, int line, const char *pathname)
 	strbuf_addstr(&buf_payload, pathname);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -265,7 +271,7 @@ static void fn_command_ancestry_fl(const char *file, int line, const char **pare
 	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -280,7 +286,7 @@ static void fn_command_name_fl(const char *file, int line, const char *name,
 		strbuf_addf(&buf_payload, " (%s)", hierarchy);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -292,7 +298,7 @@ static void fn_command_mode_fl(const char *file, int line, const char *mode)
 	strbuf_addstr(&buf_payload, mode);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -307,7 +313,7 @@ static void fn_alias_fl(const char *file, int line, const char *alias,
 	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -343,7 +349,7 @@ static void fn_child_start_fl(const char *file, int line,
 	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -357,7 +363,7 @@ static void fn_child_exit_fl(const char *file, int line,
 	strbuf_addf(&buf_payload, "[ch%d] pid:%d code:%d", cid, pid, code);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 &us_elapsed_child, NULL, &buf_payload);
+			 &us_elapsed_child, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -371,7 +377,7 @@ static void fn_child_ready_fl(const char *file, int line,
 	strbuf_addf(&buf_payload, "[ch%d] pid:%d ready:%s", cid, pid, ready);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 &us_elapsed_child, NULL, &buf_payload);
+			 &us_elapsed_child, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -382,7 +388,7 @@ static void fn_thread_start_fl(const char *file, int line,
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -394,7 +400,7 @@ static void fn_thread_exit_fl(const char *file, int line,
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 &us_elapsed_thread, NULL, &buf_payload);
+			 &us_elapsed_thread, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -415,7 +421,7 @@ static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -431,7 +437,7 @@ static void fn_exec_result_fl(const char *file, int line,
 		strbuf_addf(&buf_payload, " err:%s", strerror(code));
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -444,7 +450,7 @@ static void fn_param_fl(const char *file, int line, const char *param,
 	strbuf_addf(&buf_payload, "%s:%s", param, value);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -458,7 +464,7 @@ static void fn_repo_fl(const char *file, int line,
 	sq_quote_buf_pretty(&buf_payload, repo->worktree);
 
 	perf_io_write_fl(file, line, event_name, repo, NULL, NULL, NULL,
-			 &buf_payload);
+			 &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -480,7 +486,7 @@ static void fn_region_enter_printf_va_fl(const char *file, int line,
 	}
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
-			 NULL, category, &buf_payload);
+			 NULL, category, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -500,7 +506,7 @@ static void fn_region_leave_printf_va_fl(
 	}
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
-			 &us_elapsed_region, category, &buf_payload);
+			 &us_elapsed_region, category, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -515,7 +521,7 @@ static void fn_data_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 	strbuf_addf(&buf_payload, "%s:%s", key, value);
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
-			 &us_elapsed_region, category, &buf_payload);
+			 &us_elapsed_region, category, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -531,7 +537,7 @@ static void fn_data_json_fl(const char *file, int line,
 	strbuf_addf(&buf_payload, "%s:%s", key, value->json.buf);
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
-			 &us_elapsed_region, category, &buf_payload);
+			 &us_elapsed_region, category, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
@@ -545,7 +551,7 @@ static void fn_printf_va_fl(const char *file, int line,
 	maybe_append_string_va(&buf_payload, fmt, ap);
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-			 NULL, NULL, &buf_payload);
+			 NULL, NULL, &buf_payload, NULL);
 	strbuf_release(&buf_payload);
 }
 
-- 
gitgitgadget

