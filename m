Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41D5C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 18:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJLSwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJLSwi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 14:52:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AB9240A9
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 11:52:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so27542536wrr.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBYrCTm6sONYh2JzDxn3XUEMeP9cTr+K0XsOM99+7bc=;
        b=eqomppaclg8GvRuX5I6qMr9PObfalnG7n/gm3Vg6BLssYLwxicco0+q6JhMxxFngKc
         G0GJXaQESe+XGXHufnS8gpwyO2yD26i9F+JYH6YN0g1h7SaKBwE8VgYgZGf84DuiuvVA
         C+lRpIrg5QcDVNQ4hYW2RcFFbjueWr13dlNKGPVYLZJKqTwZrMnFQu//k69WxlB3n7wx
         7WxHqxZIqoLYI1O07IuUbRKB/WuWSM+SjpiIOeDLRguuHaNjFvs3fCJFJrZJpvoYmMJq
         1xTGATyDZrd5B9G7tTL0a/ID3Bd8037OPdgDACCVVgxCkV7By3Vl6ewcpA5QdrnkxrLa
         RqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBYrCTm6sONYh2JzDxn3XUEMeP9cTr+K0XsOM99+7bc=;
        b=uO0SKKB8V6+Ad4jC5+9CbC8E+odQWWnurXm21XXz3tsOLzHtvyahh/7anujr0dYSka
         ywilt3TRoVtFYYbYdD4hM1JtZVjpjRH6JPBpGoyEIq9XcPoZWAsEdVquCOccgC22IivX
         LILRs/vAYDKLBUxIGfg20crQ291FnSQF005GLq13AQom7TMAcpTjDq39YchCeCHhi5fX
         Ek2gWEKoezrbhpAfRFQwX6vTQ4GLPQzzKZKYRB2bNolgaL3cecK3DPGGDax7SvSpcXPI
         jJ9RCbQCvJJSIN/Js2GjeacRd2z/QLNGbgtsErSZxCUmwdyyMW33b529bfo50FB3TbOs
         ZQLw==
X-Gm-Message-State: ACrzQf3bi6kVaypQBm8yp6idH/wA53f/qOdTt7x/khb5G8kts7UeJyxn
        Qve7jNnUtguVSkQw/7ocPayhEsWp3CY=
X-Google-Smtp-Source: AMsMyM4WNQD1D+daoCmC/u4eXbZ5hoD5uvOnC39gJgAQpymADJEQRVFuYbyqtiNcSC4gZm8VypkAHA==
X-Received: by 2002:adf:f501:0:b0:22c:cbea:240a with SMTP id q1-20020adff501000000b0022ccbea240amr19436213wro.78.1665600756255;
        Wed, 12 Oct 2022 11:52:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az12-20020a05600c600c00b003a62052053csm2929327wmb.18.2022.10.12.11.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:52:35 -0700 (PDT)
Message-Id: <637b422b8606b3b6d954e6a1959aae450507cdfa.1665600750.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
        <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 18:52:27 +0000
Subject: [PATCH v2 4/7] trace2: rename the thread_name argument to
 trace2_thread_start
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Rename the `thread_name` argument in `tr2tls_create_self()` and
`trace2_thread_start()` to be `thread_base_name` to make it clearer
that the passed argument is a component used in the construction of
the actual `struct tr2tls_thread_ctx.thread_name` variable.

The base name will be used along with the thread id to create a
unique thread name.

This commit does not change how the `thread_name` field is
allocated or stored within the `tr2tls_thread_ctx` structure.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2.c         |  6 +++---
 trace2.h         | 11 ++++++-----
 trace2/tr2_tls.c |  4 ++--
 trace2/tr2_tls.h | 17 ++++++++++-------
 4 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/trace2.c b/trace2.c
index c1244e45ace..165264dc79a 100644
--- a/trace2.c
+++ b/trace2.c
@@ -466,7 +466,7 @@ void trace2_exec_result_fl(const char *file, int line, int exec_id, int code)
 				file, line, us_elapsed_absolute, exec_id, code);
 }
 
-void trace2_thread_start_fl(const char *file, int line, const char *thread_name)
+void trace2_thread_start_fl(const char *file, int line, const char *thread_base_name)
 {
 	struct tr2_tgt *tgt_j;
 	int j;
@@ -488,14 +488,14 @@ void trace2_thread_start_fl(const char *file, int line, const char *thread_name)
 		 */
 		trace2_region_enter_printf_fl(file, line, NULL, NULL, NULL,
 					      "thread-proc on main: %s",
-					      thread_name);
+					      thread_base_name);
 		return;
 	}
 
 	us_now = getnanotime() / 1000;
 	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
 
-	tr2tls_create_self(thread_name, us_now);
+	tr2tls_create_self(thread_base_name, us_now);
 
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_thread_start_fl)
diff --git a/trace2.h b/trace2.h
index af3c11694cc..74cdb1354f7 100644
--- a/trace2.h
+++ b/trace2.h
@@ -304,14 +304,15 @@ void trace2_exec_result_fl(const char *file, int line, int exec_id, int code);
  * thread-proc to allow the thread to create its own thread-local
  * storage.
  *
- * Thread names should be descriptive, like "preload_index".
- * Thread names will be decorated with an instance number automatically.
+ * The thread base name should be descriptive, like "preload_index" or
+ * taken from the thread-proc function.  A unique thread name will be
+ * created from the given base name and the thread id automatically.
  */
 void trace2_thread_start_fl(const char *file, int line,
-			    const char *thread_name);
+			    const char *thread_base_name);
 
-#define trace2_thread_start(thread_name) \
-	trace2_thread_start_fl(__FILE__, __LINE__, (thread_name))
+#define trace2_thread_start(thread_base_name) \
+	trace2_thread_start_fl(__FILE__, __LINE__, (thread_base_name))
 
 /*
  * Emit a 'thread_exit' event.  This must be called from inside the
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 8d2182fbdbb..4f7c516ecb6 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -31,7 +31,7 @@ void tr2tls_start_process_clock(void)
 	tr2tls_us_start_process = getnanotime() / 1000;
 }
 
-struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
+struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
 					     uint64_t us_thread_start)
 {
 	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
@@ -50,7 +50,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 	strbuf_init(&ctx->thread_name, 0);
 	if (ctx->thread_id)
 		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
-	strbuf_addstr(&ctx->thread_name, thread_name);
+	strbuf_addstr(&ctx->thread_name, thread_base_name);
 	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
 		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
 
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 1297509fd23..7d1f03a2ea6 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -25,17 +25,20 @@ struct tr2tls_thread_ctx {
 /*
  * Create thread-local storage for the current thread.
  *
- * We assume the first thread is "main".  Other threads are given
- * non-zero thread-ids to help distinguish messages from concurrent
- * threads.
- *
- * Truncate the thread name if necessary to help with column alignment
- * in printf-style messages.
+ * The first thread in the process will have:
+ *     { .thread_id=0, .thread_name="main" }
+ * Subsequent threads are given a non-zero thread_id and a thread_name
+ * constructed from the id and a thread base name (which is usually just
+ * the name of the thread-proc function).  For example:
+ *     { .thread_id=10, .thread_name="th10fsm-listen" }
+ * This helps to identify and distinguish messages from concurrent threads.
+ * The ctx.thread_name field is truncated if necessary to help with column
+ * alignment in printf-style messages.
  *
  * In this and all following functions the term "self" refers to the
  * current thread.
  */
-struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
+struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
 					     uint64_t us_thread_start);
 
 /*
-- 
gitgitgadget

