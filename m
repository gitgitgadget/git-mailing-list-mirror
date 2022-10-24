Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C757ECAAA1
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 18:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiJXSxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiJXSwh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 14:52:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5FC20C9BE
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 10:34:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y10so7030186wma.0
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAlOJTg6iT9VRZtrwsV4BCzjxR+22dkEdOuKsnNwhMw=;
        b=EB4XNIYz4vqYdXDDGalCAQGA2yGeOKCtOjmcShBgxLzj1RQn6iSaRQUI5ahw1KPiYx
         Lnol9UzLubsDX2+0I35h8r0nG4pHHsEEE0asMoQBOwxtfeVVl6bHBC1/X2yb+dYlaucf
         FlangIHTEwUbTRanfCL02HbMcZO5wpAKffBx+EnDv9jSTwquPK4hlp36ew/HagHnLRQn
         a/XgeGty8W6GOTlIRVSAkj56ohCmx+CZk19Oi9utMQi8bPib3iEBi+3yQ+xr8pYBlMYS
         Vb9fj7rJ6jr8yll/ZWsgk4y7qb0F884fq6Xppl5SUn0Y0nG1bYRIkf1MsbCdvxFPsCAq
         dWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAlOJTg6iT9VRZtrwsV4BCzjxR+22dkEdOuKsnNwhMw=;
        b=5sG2Xjj0nL0C7ymGnRlHQMxxnKKvvdK3bgIUa4Ysn0FDBxBsyCtvZOWABkz28/2qkY
         XUb4fax/qrtxZmVdNoYK/u0+ZWbLDvx5Yep9IH1xL33l2vjGVBiGOYakuGwZAKQk75Lq
         JBZJKEG2bh5pIzU1lYiHAGj7xRKlPEuVfC49TVogl4nhguX/hjXly6/2m8kWuOkiQdn0
         tDK7+RJkjZ5UhR6UXJauCHkKhpKPmXa1wpmbPyIj4tWKt5Ru8uRrs3fQKA9LMTfTkcwj
         /nAO05Jtbl72YbTgVuGCZbuRXkjwE9Ozi2t+3pJ3rBwhx733C9kEWMaGDunefQjMJBO3
         Y9ZA==
X-Gm-Message-State: ACrzQf2iPxO7FBspwvIOTnSH/HBrvqQc8wFYfKFehQPq85IKrAIhwpTs
        ko4eaoaufANe7BaX2go+iybFCa3LBu8=
X-Google-Smtp-Source: AMsMyM5lYyFck0Z/ilIJ7GQj2G4xewn4ReTfWoEpEewidlJHbWdHWrHhFjgiwX9an5mO98DuyBpyog==
X-Received: by 2002:a1c:35c9:0:b0:3c3:d9a:385f with SMTP id c192-20020a1c35c9000000b003c30d9a385fmr22089495wma.139.1666618873947;
        Mon, 24 Oct 2022 06:41:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600011c400b002365cd93d05sm7122157wrx.102.2022.10.24.06.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:41:13 -0700 (PDT)
Message-Id: <9adf9cee1a96211cc4c2a305997079c7d6492aea.1666618868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
References: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
        <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 13:41:03 +0000
Subject: [PATCH v4 4/8] trace2: rename the thread_name argument to
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
 trace2/tr2_tls.h |  2 +-
 4 files changed, 12 insertions(+), 11 deletions(-)

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
index 1297509fd23..d4e725f430b 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -35,7 +35,7 @@ struct tr2tls_thread_ctx {
  * In this and all following functions the term "self" refers to the
  * current thread.
  */
-struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
+struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
 					     uint64_t us_thread_start);
 
 /*
-- 
gitgitgadget

