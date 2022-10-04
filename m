Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E270BC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJDQUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJDQUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:20:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2193AB1B
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:20:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i83-20020a1c3b56000000b003bd44dc526fso1112227wma.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=hxtLIS/x5S5M+vKHrv/OI64Re4gc9i3o/wSBOO+OBuM=;
        b=EaZLuDGZR6VgYoB442BmRdmzdNucG+0akCxMRTZd477eVvExLKypeQ1tWgL5PDpC3c
         ujXrhhDJC/zjegHDAAW6fHAVnDDnoX6bxASJfxoKHigtfpfYGm5tkifqNgKuo34e62o4
         tJmD8W8foE1CEUKw6V42OdJVxZoXQh+vLlDrv0BZB08/nSNafdxApudx1yBNhGlvV51s
         YKbUsiXLNokuqV658iHO1mSjmv2eQTyrL771uYemARWQ4gi7sj0+hXfPWmpWKRmtQMTd
         bTx65JCKf/zMCG+3RkbW5WYfLKo8VrQBklWFoJ7n6Zvzv5AFFToRBhYM0qpkg2+jLhaq
         q3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hxtLIS/x5S5M+vKHrv/OI64Re4gc9i3o/wSBOO+OBuM=;
        b=jawXEfmdTcvIGtyd67CKkm2tA444Q/nTVo+bNZlW/RD/JEP8gD6UuDJvH+neOnPZFO
         EQovINqQKnZcLuIaDvzPBwBCfzX7JsfawqnViSFkxkdycZlDxAk0Hlrzpyjgu0qX0okI
         uQILKMNPdTtBw15tiQjsqUa8u1i/ByP94GCrIE4MfcKWUAmgDDyL0/oNrMP4dYskD7p3
         hiTZpZvxvPoZhDVPPzXFdAaQqH4xcV3495pVr3N15Gldsyv17VzQ066ly8PEsm3Z2XCm
         TB5J83rCTXCXRAR4x7i8SCfhcXTT1YKgSvpOmkCJz4k8v/uN9f6uqx2NMxZ0fJqDxYGQ
         e9hg==
X-Gm-Message-State: ACrzQf2lGe0iTUYsAEC/oLqv2niJYyMOf62r0a4pAP930mUTROlgh0Bv
        NsmzUfZ2AhH4HJuOP9xecyAW4VCmD64=
X-Google-Smtp-Source: AMsMyM4zM2OB5r2Wf0M2GLXGny0w7dThC8MKP6v+Bvkox2SGSrx8p9uS0iulaqMiC9v2P2G7dHiXiA==
X-Received: by 2002:a05:600c:4186:b0:3b4:a660:1d29 with SMTP id p6-20020a05600c418600b003b4a6601d29mr405996wmh.120.1664900412828;
        Tue, 04 Oct 2022 09:20:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14-20020adfed0e000000b002258235bda3sm12694559wro.61.2022.10.04.09.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:20:12 -0700 (PDT)
Message-Id: <82f1672e180afcd876505a4354bd9952f70db49e.1664900407.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 16:20:03 +0000
Subject: [PATCH 5/9] trace2: rename trace2 thread_name argument as name_hint
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

Rename the `thread_name` argument in `tr2tls_create_self()`
and `trace2_thread_start()` to be `name_hint` to make it clear
that the passed argument is a hint that will be used to create
the actual `struct tr2tls_thread_ctx.thread_name` variable.

This should make it clearer in the API that the trace2 layer
does not borrow the caller's string pointer/buffer, but rather
that it will use that hint in formatting the actual thread's
name.  Previous discussion on the mailing list indicated that
there was confusion about this point.

This commit does not change how the `thread_name` field is
allocated or stored within the `tr2tls_thread_ctx` structure.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt |  2 +-
 trace2.c                               |  6 +++---
 trace2.h                               | 11 ++++++-----
 trace2/tr2_tls.c                       |  4 ++--
 trace2/tr2_tls.h                       | 17 ++++++++++-------
 5 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 431d424f9d5..4fe2d6992ab 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -209,7 +209,7 @@ e.g: `void trace2_child_start(struct child_process *cmd)`.
 
 These messages are concerned with Git thread usage.
 
-e.g: `void trace2_thread_start(const char *thread_name)`.
+e.g: `void trace2_thread_start(const char *name_hint)`.
 
 === Region and Data Messages
 
diff --git a/trace2.c b/trace2.c
index c1244e45ace..c8e5acced2a 100644
--- a/trace2.c
+++ b/trace2.c
@@ -466,7 +466,7 @@ void trace2_exec_result_fl(const char *file, int line, int exec_id, int code)
 				file, line, us_elapsed_absolute, exec_id, code);
 }
 
-void trace2_thread_start_fl(const char *file, int line, const char *thread_name)
+void trace2_thread_start_fl(const char *file, int line, const char *name_hint)
 {
 	struct tr2_tgt *tgt_j;
 	int j;
@@ -488,14 +488,14 @@ void trace2_thread_start_fl(const char *file, int line, const char *thread_name)
 		 */
 		trace2_region_enter_printf_fl(file, line, NULL, NULL, NULL,
 					      "thread-proc on main: %s",
-					      thread_name);
+					      name_hint);
 		return;
 	}
 
 	us_now = getnanotime() / 1000;
 	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
 
-	tr2tls_create_self(thread_name, us_now);
+	tr2tls_create_self(name_hint, us_now);
 
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_thread_start_fl)
diff --git a/trace2.h b/trace2.h
index af3c11694cc..fe39dcb5849 100644
--- a/trace2.h
+++ b/trace2.h
@@ -304,14 +304,15 @@ void trace2_exec_result_fl(const char *file, int line, int exec_id, int code);
  * thread-proc to allow the thread to create its own thread-local
  * storage.
  *
- * Thread names should be descriptive, like "preload_index".
- * Thread names will be decorated with an instance number automatically.
+ * The thread name hint should be descriptive, like "preload_index" or
+ * taken from the thread-proc function.  A unique thread name will be
+ * created from the hint and the thread id automatically.
  */
 void trace2_thread_start_fl(const char *file, int line,
-			    const char *thread_name);
+			    const char *name_hint);
 
-#define trace2_thread_start(thread_name) \
-	trace2_thread_start_fl(__FILE__, __LINE__, (thread_name))
+#define trace2_thread_start(name_hint) \
+	trace2_thread_start_fl(__FILE__, __LINE__, (name_hint))
 
 /*
  * Emit a 'thread_exit' event.  This must be called from inside the
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 8d2182fbdbb..39b41fd2487 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -31,7 +31,7 @@ void tr2tls_start_process_clock(void)
 	tr2tls_us_start_process = getnanotime() / 1000;
 }
 
-struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
+struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
 					     uint64_t us_thread_start)
 {
 	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
@@ -50,7 +50,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 	strbuf_init(&ctx->thread_name, 0);
 	if (ctx->thread_id)
 		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
-	strbuf_addstr(&ctx->thread_name, thread_name);
+	strbuf_addstr(&ctx->thread_name, name_hint);
 	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
 		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
 
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 1297509fd23..f1ee58305d6 100644
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
+ * constructed from the id and a "name hint" (which is usually based
+ * upon the name of the thread-proc function).  For example:
+ *     { .thread_id=10, .thread_name="th10fsm-listen" }
+ * This helps to identify and distinguish messages from concurrent threads.
+ * The ctx.thread_name field is truncated if necessary to help with column
+ * alignment in printf-style messages.
  *
  * In this and all following functions the term "self" refers to the
  * current thread.
  */
-struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
+struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
 					     uint64_t us_thread_start);
 
 /*
-- 
gitgitgadget

