Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A63C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJTS2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJTS2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:28:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8921F525C
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v1so387830wrt.11
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAlOJTg6iT9VRZtrwsV4BCzjxR+22dkEdOuKsnNwhMw=;
        b=pRwmkPqo9ULtGpbEeAegCys3OOmCjaDZJyADH2KQUSWWmyQ8G3ft6G0vFuyNHhJyhm
         PGlAtFlefWu838cA8RR2tmbq/tERHFRmpgxGbfIvr47DzMaEzJ6vnbNoiN7jdXEgnx2C
         FBXBUyWmDzvzUF2UFsa78wtqC+V/CJXbb7lKQmKUKzXj/j4XMzY7YlH5OiGrKoIuJKIm
         x+cKuE9HmEQlRmEnJrk1OMpYQsq7IDqnk9NaC1cA4Bl82WFHRv4sd931rgN79ERtzbZZ
         mK77IPYLtBKuBk20fwRogrYSGyj41A2k65rnItTBY8tCsoMVk3W0by2ac6/a3cmC82vR
         IybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAlOJTg6iT9VRZtrwsV4BCzjxR+22dkEdOuKsnNwhMw=;
        b=d2p7aGe0rXIP0vByzrc2sJnIy8yVUW6F1nNbXulpZtBKbnMhGaSlFRoQHwA2HeS7bc
         uJ5+vyEcVPg1cAeSIKvwfQttRzz8FogXnpD/qGmjKhvloR4IH3kAVFbt6VO7tEj+rVRN
         uAQjyXjvZUPVWKr5Pk1eohKG5BMN+ZoBVYYj98L2VTJi4TzueJhDAAc2wK36XRU89R47
         vtWaMZoQK+g12yXPrh0kjjJPilX28my9yl2u4CbkyE5GvXtIVmeRo2QzHBFaVFsfzY+1
         I1iqHXJqVU8JR6FoAZctOmJnmppHdiONmQkXTFptE9UM7XxS9Y25Ued3v3xLo5QuHWRi
         RRvw==
X-Gm-Message-State: ACrzQf1kdXH+B3H1mPDHoBXWNwOJPaTYkNbL5gEz/2T335PXGyBTCrL4
        EDfnX2zPjO8Ny75a6SLzR9Rl3AgykZ0=
X-Google-Smtp-Source: AMsMyM49Hgh/hJfU55pi/LgbLJNBymd4cxdOOpuSjh9DCj+SQ/hjzBf7iDIe927OjO3BhdxB4bjOdg==
X-Received: by 2002:a05:6000:1565:b0:22f:1407:9bfd with SMTP id 5-20020a056000156500b0022f14079bfdmr9517859wrz.620.1666290494879;
        Thu, 20 Oct 2022 11:28:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9-20020adfdb09000000b0022cc6b8df5esm3484466wri.7.2022.10.20.11.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:28:14 -0700 (PDT)
Message-Id: <9adf9cee1a96211cc4c2a305997079c7d6492aea.1666290489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
References: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
        <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 18:28:05 +0000
Subject: [PATCH v3 4/8] trace2: rename the thread_name argument to
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

