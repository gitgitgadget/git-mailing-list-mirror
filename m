Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AB3B6BE5
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684202; cv=none; b=soxZEzv0Y55zZyD3r4CyiBoDPGKKnwgpJOru5H6eKXDBZfvGwydOvD+hy41Fikx2iuNW6xaa4HUs+BuxErbUs8jNDmSnOrLdyH9KO5BxrM22Vqv6ehjtH5gX3AXQXZWbf1UyvZED/Lf0/i4JM0IHSwYVU/PFJ5hSGd26YNdiyFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684202; c=relaxed/simple;
	bh=fSR15FP5JvUAsrbEhmxfcECmpiyEsn/er+VbrWoqX3o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r3YSh403zoqoN3U6Zz8DtvhMJgIi5mMnWsK5aamf67ttMAjC+fk0qgVH7YkgqAaFRuU0j1/c3O1MC6KdyU+GUh2QMI8frK9JExi2dSJDFrsHbvPZPfb+XZ5cUGAlY3fbAh3FHmR6lfp2aW2rnVo6XXdo7goWmvOWmDMdAUPZjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5XtCSqJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5XtCSqJ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-39647184c73so1184567a91.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684194; x=1788288994; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m4q8Jk+70XEBnmkYYhygSBDPrR+AX200Symt1znT0rs=;
        b=g5XtCSqJSjpPObvtmSDXwbO0LzWClft4y/xMyONX0Oct/n90+Bh/MA/MDx1bT+M38D
         3UR4Dk2cZtTaDgJl7D1mlYKbC72NouTI3UxY/Vivat8I7DHaIq+nfMSyAkA2KUq33Imd
         yS8Mj+rovdjWga50zxdcW09usYfYwEOzqq1WWjTIHDF34h0Q4epxjDlXrAl6ySjVoW9T
         /YfPrQxcmbFof+URqA2fMxnSuyLznD0j7QtdmWS8+XW8v7GH/sD9eVFiZZxemoHfv9G+
         lVMaHiJgrMXBfdYRApKioySN2Jyzn6sTLOK5+SIwFbjLrZ40cFUxHWe1eFYP8orjf/cM
         hkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684194; x=1788288994;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m4q8Jk+70XEBnmkYYhygSBDPrR+AX200Symt1znT0rs=;
        b=J16cbvlEU5hhFqXigo1nsmqemXWJ3bcabvJuSk0w2xR2zGS3r+qNXKZeS9pAdf8mV0
         8xFmbCNCLo8YDH5+6UxY2KnJbajPY82ymABbDVpROp84HneF8qLj1eEv0b6YJiuyCoUN
         eaGy3OdH4H/zAex9EznySwUfcJbCNkpxZ+zw+YIK+LnWYwDC5WCsobMmwiwvl/5WB4Ps
         MRPFWmkbUi8icA9CLe24DYM/nu9a3cjmqrNmq/bMypxqpq/KHup7ffzQ7gCj2tSTlapX
         b82bJfvZpQNM+NB37C21pk57+X8+68WMmsNHPNJkcV3oaKSnrv6z/aSiHVbF9ZQkUm04
         g5KQ==
X-Gm-Message-State: AFuF++nKQFirvGsHVLiYCexUKSR5egbfELYHiLzHSE0jK/ciXbkjxH0b
	RjzjvRixZOai06ENhwTziDAcWAUd0rOCDO++W5uYYJCMuTDE5A4ae8TkVGSBWiu3
X-Gm-Gg: AR+sD13e0qeTpP0acJxxyi3kBHFcZBkuaxINirSSag/3kLJ4s3iw0EEeh9ejSG17sMy
	Ei5dzgiYCy2U3CeYGmr++1pNJuJXQc1u3klaLTeIw+yFp+xmGOyaNp+IDFmnzP7wFMu8Xi0nNcY
	9UrAzW0HlMfyVnMmJFbDQjahw15Xhd5T01pU2Z12xEMEWHhy/I2BRCnf1Ji4uZdvCbCL8xOvg8v
	/9R7n2qluJwyibqQUERHecXgYJDBW4a9WumaJbxNyxaYk8jnaGFyaevs2pVkN68YKbSuJsIX71m
	OvW/T8CrapYKd84NaIAbOQK+xWeRyzfPw/g+bE5c6jfu71/iGHZGi8u3MVNTCrGAhWLGrxnoVuY
	TLMpt9oJB2viqqAaNCDv1P8UXFFUpn+1T8bSKt2bxqt5SwxThkrfFFAs9Ob5C+SY/Zy1aIgrclT
	Zz8UAC5Hze5oU95qRJjem5/6MBUu284MPgyzsdmrXp5vYzgXIlQt5ke4bbyr7FwD8=
X-Received: by 2002:a17:90b:1c02:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-39645ace043mr11384660a91.14.1787684194191;
        Tue, 25 Aug 2026 11:56:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283fa89e8fsm428285eec.8.2026.08.25.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:56:33 -0700 (PDT)
Message-Id: <c8fc195a2ace4c2058ffa87e40a5745d349ab2dc.1787684181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 18:56:21 +0000
Subject: [PATCH v2 7/7] trace2: remove use of xcalloc()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    Taylor Blau <ttaylorr@openai.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Remove use of xcalloc() from the trace2 API due to its possible use of
die(), which could lead to recursive die() handlers. This is used in the
trace2 API to track an array of thread contexts when logging multi-
threaded operations.

Instead of killing the process on a failure, we attempt to proceed as
much as possible. We replace the dynamic thread context with a
statically-allocated context that uses the "unknown" thread name to
identify that we are in an error case.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 banned-die.h     |  3 ++
 trace2/tr2_ctr.c | 10 ++++++-
 trace2/tr2_tls.c | 73 ++++++++++++++++++++++++++++++++++++------------
 trace2/tr2_tls.h |  6 ++++
 trace2/tr2_tmr.c | 14 ++++++++--
 5 files changed, 85 insertions(+), 21 deletions(-)

diff --git a/banned-die.h b/banned-die.h
index 423e7b607d..3dc521f6b0 100644
--- a/banned-die.h
+++ b/banned-die.h
@@ -17,6 +17,9 @@
 #undef xstrdup
 #define xstrdup(str) BANNED(xstrdup)
 
+#undef xcalloc
+#define xcalloc(nmemb, size) BANNED(xcalloc)
+
 #undef xstrfmt
 #define xstrfmt(...) BANNED(xstrfmt)
 
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index 3067df4d18..5283946e08 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -54,7 +54,11 @@ static struct tr2_counter_metadata tr2_counter_metadata[TRACE2_NUMBER_OF_COUNTER
 void tr2_counter_increment(enum trace2_counter_id cid, uint64_t value)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	struct tr2_counter *c = &ctx->counter_block.counter[cid];
+	struct tr2_counter *c;
+
+	if (tr2tls_is_fallback(ctx))
+		return;
+	c = &ctx->counter_block.counter[cid];
 
 	c->value += value;
 
@@ -68,6 +72,8 @@ void tr2_update_final_counters(void)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 	enum trace2_counter_id cid;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
 	if (!ctx->used_any_counter)
 		return;
 
@@ -89,6 +95,8 @@ void tr2_emit_per_thread_counters(tr2_tgt_evt_counter_t *fn_apply)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 	enum trace2_counter_id cid;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
 	if (!ctx->used_any_per_thread_counter)
 		return;
 
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 8596292a94..2c6aaed504 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -13,6 +13,9 @@
 #define TR2_REGION_NESTING_INITIAL_SIZE (100)
 
 static struct tr2tls_thread_ctx *tr2tls_thread_main;
+static struct tr2tls_thread_ctx tr2tls_thread_fallback = {
+	.thread_name = "unknown",
+};
 static uint64_t tr2tls_us_start_process;
 
 static pthread_mutex_t tr2tls_mutex;
@@ -37,16 +40,23 @@ void tr2tls_start_process_clock(void)
 struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
 					     uint64_t us_thread_start)
 {
-	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
+	struct tr2tls_thread_ctx *ctx = calloc(1, sizeof(*ctx));
 	struct strbuf buf = STRBUF_INIT;
 
+	if (!ctx)
+		goto fallback;
+
 	/*
 	 * Implicitly "tr2tls_push_self()" to capture the thread's start
 	 * time in array_us_start[0].  For the main thread this gives us the
 	 * application run time.
 	 */
 	ctx->alloc = TR2_REGION_NESTING_INITIAL_SIZE;
-	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
+	ctx->array_us_start = calloc(ctx->alloc, sizeof(uint64_t));
+	if (!ctx->array_us_start) {
+		free(ctx);
+		goto fallback;
+	}
 	ctx->array_us_start[ctx->nr_open_regions++] = us_thread_start;
 
 	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
@@ -62,6 +72,10 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
 	pthread_setspecific(tr2tls_key, ctx);
 
 	return ctx;
+
+fallback:
+	pthread_setspecific(tr2tls_key, &tr2tls_thread_fallback);
+	return &tr2tls_thread_fallback;
 }
 
 struct tr2tls_thread_ctx *tr2tls_get_self(void)
@@ -84,6 +98,11 @@ struct tr2tls_thread_ctx *tr2tls_get_self(void)
 	return ctx;
 }
 
+int tr2tls_is_fallback(const struct tr2tls_thread_ctx *ctx)
+{
+	return ctx == &tr2tls_thread_fallback;
+}
+
 int tr2tls_is_main_thread(void)
 {
 	if (!HAVE_THREADS)
@@ -100,6 +119,9 @@ void tr2tls_unset_self(void)
 
 	pthread_setspecific(tr2tls_key, NULL);
 
+	if (tr2tls_is_fallback(ctx))
+		return;
+
 	free((char *)ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
@@ -111,30 +133,33 @@ void tr2tls_push_self(uint64_t us_now)
 	uint64_t *new_array;
 	size_t new_alloc;
 
-	if (ctx->nr_skipped_regions) {
-		ctx->nr_skipped_regions++;
-		return;
-	}
-
-	if (ctx->nr_open_regions < ctx->alloc)
+	if (tr2tls_is_fallback(ctx))
 		return;
 
-	if (ctx->alloc > SIZE_MAX / (2 * sizeof(*ctx->array_us_start))) {
+	if (ctx->nr_skipped_regions) {
 		ctx->nr_skipped_regions++;
 		return;
 	}
-	new_alloc = ctx->alloc * 2;
 
-	new_array = realloc(ctx->array_us_start,
-			    new_alloc * sizeof(*ctx->array_us_start));
-	if (!new_array) {
-		ctx->nr_skipped_regions++;
-		return;
+	if (ctx->nr_open_regions >= ctx->alloc) {
+		if (ctx->alloc >
+		    SIZE_MAX / (2 * sizeof(*ctx->array_us_start))) {
+			ctx->nr_skipped_regions++;
+			return;
+		}
+		new_alloc = ctx->alloc * 2;
+
+		new_array = realloc(ctx->array_us_start,
+				    new_alloc * sizeof(*ctx->array_us_start));
+		if (!new_array) {
+			ctx->nr_skipped_regions++;
+			return;
+		}
+
+		ctx->array_us_start = new_array;
+		ctx->alloc = new_alloc;
 	}
 
-	ctx->array_us_start = new_array;
-	ctx->alloc = new_alloc;
-
 	ctx->array_us_start[ctx->nr_open_regions++] = us_now;
 }
 
@@ -142,6 +167,9 @@ void tr2tls_pop_self(void)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 
+	if (tr2tls_is_fallback(ctx))
+		return;
+
 	if (ctx->nr_skipped_regions) {
 		ctx->nr_skipped_regions--;
 		return;
@@ -157,6 +185,9 @@ void tr2tls_pop_unwind_self(void)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 
+	if (tr2tls_is_fallback(ctx))
+		return;
+
 	while (ctx->nr_open_regions > 1)
 		tr2tls_pop_self();
 }
@@ -167,6 +198,8 @@ uint64_t tr2tls_region_elasped_self(uint64_t us)
 	uint64_t us_start;
 
 	ctx = tr2tls_get_self();
+	if (tr2tls_is_fallback(ctx))
+		return 0;
 	if (ctx->nr_skipped_regions)
 		return 0;
 	if (!ctx->nr_open_regions)
@@ -188,6 +221,10 @@ uint64_t tr2tls_absolute_elapsed(uint64_t us)
 static void tr2tls_key_destructor(void *payload)
 {
 	struct tr2tls_thread_ctx *ctx = payload;
+
+	if (tr2tls_is_fallback(ctx))
+		return;
+
 	free((char *)ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index c365017923..4a0969c014 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -54,6 +54,12 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
  */
 struct tr2tls_thread_ctx *tr2tls_get_self(void);
 
+/*
+ * Return true if the context is the non-allocating fallback used after an
+ * allocation failure. Callers must not modify a fallback context.
+ */
+int tr2tls_is_fallback(const struct tr2tls_thread_ctx *ctx);
+
 /*
  * return true if the current thread is the main thread.
  */
diff --git a/trace2/tr2_tmr.c b/trace2/tr2_tmr.c
index a329c466b9..b3d26e2b31 100644
--- a/trace2/tr2_tmr.c
+++ b/trace2/tr2_tmr.c
@@ -38,8 +38,11 @@ static struct tr2_timer_metadata tr2_timer_metadata[TRACE2_NUMBER_OF_TIMERS] = {
 void tr2_start_timer(enum trace2_timer_id tid)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	struct tr2_timer *t = &ctx->timer_block.timer[tid];
+	struct tr2_timer *t;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
+	t = &ctx->timer_block.timer[tid];
 	t->recursion_count++;
 	if (t->recursion_count > 1)
 		return; /* ignore recursive starts */
@@ -50,10 +53,13 @@ void tr2_start_timer(enum trace2_timer_id tid)
 void tr2_stop_timer(enum trace2_timer_id tid)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	struct tr2_timer *t = &ctx->timer_block.timer[tid];
+	struct tr2_timer *t;
 	uint64_t ns_now;
 	uint64_t ns_interval;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
+	t = &ctx->timer_block.timer[tid];
 	assert(t->recursion_count > 0);
 
 	t->recursion_count--;
@@ -91,6 +97,8 @@ void tr2_update_final_timers(void)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 	enum trace2_timer_id tid;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
 	if (!ctx->used_any_timer)
 		return;
 
@@ -137,6 +145,8 @@ void tr2_emit_per_thread_timers(tr2_tgt_evt_timer_t *fn_apply)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 	enum trace2_timer_id tid;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
 	if (!ctx->used_any_per_thread_timer)
 		return;
 
-- 
gitgitgadget
