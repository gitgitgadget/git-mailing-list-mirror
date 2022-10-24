Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61BEFA373F
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 16:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiJXQKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 12:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiJXQJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 12:09:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9622E9F5
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 07:59:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so10191115wms.0
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t70zD9u4QyJOFLJtAsQtNnnx/aU1oF7oKkTWzJZ/sKw=;
        b=nCoe0cKjncFUMcEu8yOLvYN/Vce63i/dIvNNFeCznj8BqYJ54QGzOrWNXXB+jTMd7T
         RqEvvTrNQTmM8SdIQHn9mZoVcb4I77xTYF7MGRDRn4Op93xxAaw6CYgo9fK3HV1T8frs
         3h7ML/sUAWiEzPTvPeDbDCE2gcpKEHphYPbf94ycPeYBFcBWbOzh/ZjfOetS6NAGthzV
         tojDJV9NP4pP8vZ9lXj/8awAsjmfdY8UYp0hZnwek/IEVtxqbnIfKkhdji66ff/xyX/t
         4Xvv24oJvVUnYb1TtZrt17MzSUqtLJog/RTU3SGzPSTL2E5AIiIZLqhHOVcPtzBZbenY
         D+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t70zD9u4QyJOFLJtAsQtNnnx/aU1oF7oKkTWzJZ/sKw=;
        b=OD4THFFFhZfB1xk94mIiPQ53luysWOUTD8I4JKbXPmrljqe+SXTte8evItOEoN+tit
         hVRbNMwI6AC4cqgAt+07+ol50m/Gz1gkq14++FGwg3geapVCC2yQekWvgPn/mCmm9ExV
         H4WznJlYEjAQ8PaGSMTOWoVbM09Oxw6d57M4xBC7KtCKijyeYQJl69lJWgP8HNmXJT99
         lamYy7oJdn54XMoQRan81nSFVCdWHZUHVL244JgsKFpYVbok+UpCGt6v0dC22maPzBxP
         HdFqIZncYWoABUp0SpZRW3ssoCooqUryckiMRDhMEYnvc0NXKElQbzDN/8g0vjhjvgMe
         4fQQ==
X-Gm-Message-State: ACrzQf2+FqsZtYAzg0J2eUrqwYJONebkVb1Ml3Y9FuCic/KOuWTnRJbJ
        SeDJvtNTPMo5v47YEZBiEeGShoiETDU=
X-Google-Smtp-Source: AMsMyM4FvHk3T/Y8FQNcOkOMS9Dkw2fLxboQaKwc4ekQ2TUdLVwkDlKCHzPMQnkDvy3tzMqwTpyktA==
X-Received: by 2002:a05:600c:35cf:b0:3c6:e957:b403 with SMTP id r15-20020a05600c35cf00b003c6e957b403mr36494890wmq.162.1666618875814;
        Mon, 24 Oct 2022 06:41:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10-20020adffa0a000000b002305cfb9f3dsm25829703wrr.89.2022.10.24.06.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:41:15 -0700 (PDT)
Message-Id: <79c6406d492ab629d5d042edaf1507888d5378c0.1666618868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
References: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
        <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 13:41:05 +0000
Subject: [PATCH v4 6/8] trace2: convert ctx.thread_name from strbuf to pointer
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

Convert the `tr2tls_thread_ctx.thread_name` field from a `strbuf`
to a "const char*" pointer.

The `thread_name` field is a constant string that is constructed when
the context is created.  Using a (non-const) `strbuf` structure for it
caused some confusion in the past because it implied that someone
could rename a thread after it was created.  That usage was not
intended.  Change it to a const pointer to make the intent more clear.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_event.c |  2 +-
 trace2/tr2_tgt_perf.c  |  2 +-
 trace2/tr2_tls.c       | 16 +++++++++-------
 trace2/tr2_tls.h       |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 37a3163be12..52f9356c695 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -90,7 +90,7 @@ static void event_fmt_prepare(const char *event_name, const char *file,
 
 	jw_object_string(jw, "event", event_name);
 	jw_object_string(jw, "sid", tr2_sid_get());
-	jw_object_string(jw, "thread", ctx->thread_name.buf);
+	jw_object_string(jw, "thread", ctx->thread_name);
 
 	/*
 	 * In brief mode, only emit <time> on these 2 event types.
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 8cb792488c8..59ca58f862d 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -108,7 +108,7 @@ static void perf_fmt_prepare(const char *event_name,
 
 	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
 	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
-		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
+		    ctx->thread_name, TR2FMT_PERF_MAX_EVENT_NAME,
 		    event_name);
 
 	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 4f7c516ecb6..3a67532aae4 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -35,6 +35,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
 					     uint64_t us_thread_start)
 {
 	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
+	struct strbuf buf = STRBUF_INIT;
 
 	/*
 	 * Implicitly "tr2tls_push_self()" to capture the thread's start
@@ -47,12 +48,13 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
 
 	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
 
-	strbuf_init(&ctx->thread_name, 0);
+	strbuf_init(&buf, 0);
 	if (ctx->thread_id)
-		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
-	strbuf_addstr(&ctx->thread_name, thread_base_name);
-	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
-		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
+		strbuf_addf(&buf, "th%02d:", ctx->thread_id);
+	strbuf_addstr(&buf, thread_base_name);
+	if (buf.len > TR2_MAX_THREAD_NAME)
+		strbuf_setlen(&buf, TR2_MAX_THREAD_NAME);
+	ctx->thread_name = strbuf_detach(&buf, NULL);
 
 	pthread_setspecific(tr2tls_key, ctx);
 
@@ -95,7 +97,7 @@ void tr2tls_unset_self(void)
 
 	pthread_setspecific(tr2tls_key, NULL);
 
-	strbuf_release(&ctx->thread_name);
+	free((char *)ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
 }
@@ -113,7 +115,7 @@ void tr2tls_pop_self(void)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 
 	if (!ctx->nr_open_regions)
-		BUG("no open regions in thread '%s'", ctx->thread_name.buf);
+		BUG("no open regions in thread '%s'", ctx->thread_name);
 
 	ctx->nr_open_regions--;
 }
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 3ac4380d829..65836b1399c 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -15,7 +15,7 @@
 #define TR2_MAX_THREAD_NAME (24)
 
 struct tr2tls_thread_ctx {
-	struct strbuf thread_name;
+	const char *thread_name;
 	uint64_t *array_us_start;
 	size_t alloc;
 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
-- 
gitgitgadget

