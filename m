Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D082C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0737361003
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFWRvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhFWRvH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B39C061283
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so4530138wms.1
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6mMRSvHlr+FNcoHa/pROk6r5cDU+xPXnnl81yBh6Oo=;
        b=iuSw5kqxeIpAPXcwQSx+4XlJNTNjwfE12t5wnUqwBy5cGgc1Llh8W06uDWg1VEl3np
         reuIac4GltWC8hI385Mw+rntki59b2YvAsmk/fmo0PZH83A3K1f0CaglM1PEO8qT/els
         TlDi94vfpfRWqOgI7c8+O6FxVsZdQHdLCuN+nZ/Dv+C3JylTQsaNnq4kre7A+gNtMEyH
         ewCM2UV4TXeEmpYqa9xBOmL+UQIcShH9EYODX1TFrSVrV0UF3V1a7YrQ0igMuxBNlCrU
         Pf8vmCZQ85fLGc2Gf2+8p3/fHY3WKgluMrla1XVcaasEnH0YyPt+zpKEPC2zqFFQjO9v
         4wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6mMRSvHlr+FNcoHa/pROk6r5cDU+xPXnnl81yBh6Oo=;
        b=al3Rza6mB3F3JqUOWER+ycq27MIeWnUzshjRXExSbOOLPivlT7EawwrfP9txuC54pA
         EIIkr/7lG+iSEIV5pp4L7f1NBR15bGzUJ/yeZzE7GXBo68bw6ieeGSghXAp/DsPSoZJ/
         cFRrNWqByJQOCwQXdsfYXhAP/RmM6u9B7/3dyrDTvmneUeMbncjqi/uSMz5K2qUn4aCi
         Xp63JAivERPeLRJRCgNH4odF9AwJbCZR1FMtOhP2xnk1vCXkqYeDZeOe2vxjun+kz6Sx
         CXvCQj/q3lZjEq5+okdh8nRAQohNm01jsyZBuxRjpLb8VMr71XgDvw83HpCs3Qe+ENS9
         +cuQ==
X-Gm-Message-State: AOAM531XZkWTWWAzSL0WM+H4IJkXuyvMWEcQ5+ifPp0fY+tjDCxq7Vyq
        /mZgaVlHVHPYLwzGViVvHFVhEXJPCjTy/A==
X-Google-Smtp-Source: ABdhPJxDKl+adNvTE/G/yH46cp9FaMB6KGT8YkcR/KHFBIq11y5+omSc53z6cROBummcIPo6t29eRw==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr12507079wmq.14.1624470520686;
        Wed, 23 Jun 2021 10:48:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/25] progress.[ch]: convert "title" to "struct strbuf"
Date:   Wed, 23 Jun 2021 19:48:16 +0200
Message-Id: <patch-16.25-2161d9cbef3-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Covert the "title" for the progress bar to a "struct strbuf", as with
the existing "counters_sb". Let's also rename the "counters_sb" to
merely "status", as we'll soon start using it not just to count, but
for any other arbitrary messaging after our fixed "title".

This makes the emitting the output more consistent, and allows us to
have both a UTF-8 progress bar, and a "status" portion. We won't be
making use of the latter just let, but let's not close the door to it
by relying on a strbuf with a len for one, and a char * for the other.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 63 ++++++++++++++++++++++++++++++++----------------------
 progress.h |  9 +++++---
 2 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/progress.c b/progress.c
index 44479f65921..e17490964c4 100644
--- a/progress.c
+++ b/progress.c
@@ -29,9 +29,8 @@ static void display(struct progress *progress, uint64_t n,
 		    const char *update_msg, int last_update)
 {
 	const char *tp;
-	struct strbuf *counters_sb = &progress->counters_sb;
 	int show_update = 0;
-	int last_count_len = counters_sb->len;
+	size_t last_count_len = progress->status_len_utf8;
 
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
@@ -43,47 +42,57 @@ static void display(struct progress *progress, uint64_t n,
 		if (percent != progress->last_percent || progress_update) {
 			progress->last_percent = percent;
 
-			strbuf_reset(counters_sb);
-			strbuf_addf(counters_sb,
+			strbuf_reset(&progress->status);
+			strbuf_addf(&progress->status,
 				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
 				    (uintmax_t)n, (uintmax_t)progress->total,
 				    tp);
 			show_update = 1;
 		}
 	} else if (progress_update) {
-		strbuf_reset(counters_sb);
-		strbuf_addf(counters_sb, "%"PRIuMAX"%s", (uintmax_t)n, tp);
+		strbuf_reset(&progress->status);
+		strbuf_addf(&progress->status, "%"PRIuMAX"%s", (uintmax_t)n, tp);
 		show_update = 1;
 	}
 
 	if (show_update && update_msg)
-		strbuf_addf(counters_sb, ", %s.", update_msg);
+		strbuf_addf(&progress->status, ", %s.", update_msg);
 
 	if (show_update) {
 		int stderr_is_foreground_fd = is_foreground_fd(fileno(stderr));
 		if (stderr_is_foreground_fd || update_msg) {
 			const char *eol = last_update ? "\n" : "\r";
-			size_t clear_len = counters_sb->len < last_count_len ?
-					last_count_len - counters_sb->len + 1 :
+			size_t clear_len = progress->status.len < last_count_len ?
+					last_count_len - progress->status.len + 1 :
 					0;
 			/* The "+ 2" accounts for the ": ". */
-			size_t progress_line_len = progress->title_len +
-						counters_sb->len + 2;
+			size_t progress_line_len = progress->title_len_utf8 +
+						progress->status.len + 2;
 			int cols = term_columns();
+			progress->status_len_utf8 = utf8_strwidth(progress->status.buf);
 
 			if (progress->split) {
-				fprintf(stderr, "  %s%*s", counters_sb->buf,
-					(int) clear_len, eol);
+				fprintf(stderr, "  %*s%*s",
+					(int)progress->status_len_utf8,
+					progress->status.buf,
+					(int)clear_len, eol);
 			} else if (!update_msg && cols < progress_line_len) {
-				clear_len = progress->title_len + 1 < cols ?
-					    cols - progress->title_len - 1 : 0;
-				fprintf(stderr, "%s:%*s\n  %s%s",
-					progress->title, (int) clear_len, "",
-					counters_sb->buf, eol);
+				clear_len = progress->title_len_utf8 + 1 < cols ?
+					    cols - progress->title_len_utf8 - 1 : 0;
+				fprintf(stderr, "%*s:%*s\n  %*s%s",
+					(int)progress->title_len_utf8,
+					progress->title.buf,
+					(int)clear_len, "",
+					(int)progress->status_len_utf8,
+					progress->status.buf, eol);
 				progress->split = 1;
 			} else {
-				fprintf(stderr, "%s: %s%*s", progress->title,
-					counters_sb->buf, (int) clear_len, eol);
+				fprintf(stderr, "%*s: %*s%*s",
+					(int)progress->title_len_utf8,
+					progress->title.buf,
+					(int)progress->status_len_utf8,
+					progress->status.buf,
+					(int)clear_len, eol);
 			}
 			if (stderr_is_foreground_fd)
 				fflush(stderr);
@@ -232,15 +241,18 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 					     unsigned delay, int testing)
 {
 	struct progress *progress = xmalloc(sizeof(*progress));
-	progress->title = title;
+	strbuf_init(&progress->title, 0);
+	strbuf_addstr(&progress->title, title);
+	progress->title_len_utf8 = utf8_strwidth(title);
+	strbuf_init(&progress->status, 0);
+	progress->status_len_utf8 = 0;
+
 	progress->total = total;
 	progress->last_value = -1;
 	progress->last_percent = -1;
 	progress->delay = delay;
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
-	strbuf_init(&progress->counters_sb, 0);
-	progress->title_len = utf8_strwidth(title);
 	progress->split = 0;
 	progress->test_mode = testing;
 	set_progress_signal(progress);
@@ -288,7 +300,7 @@ void stop_progress(struct progress **p_progress)
 					   "total_bytes",
 					   progress->throughput->curr_total);
 
-		trace2_region_leave("progress", progress->title, the_repository);
+		trace2_region_leave("progress", progress->title.buf, the_repository);
 	}
 
 	stop_progress_msg(p_progress, _("done"));
@@ -320,7 +332,8 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		display(progress, progress->last_value, msg, 1);
 	}
 	clear_progress_signal(progress);
-	strbuf_release(&progress->counters_sb);
+	strbuf_release(&progress->title);
+	strbuf_release(&progress->status);
 	if (progress->throughput)
 		strbuf_release(&progress->throughput->display);
 	free(progress->throughput);
diff --git a/progress.h b/progress.h
index 4693dddb6c5..ba38447d104 100644
--- a/progress.h
+++ b/progress.h
@@ -17,15 +17,18 @@ struct throughput {
 };
 
 struct progress {
-	const char *title;
+	struct strbuf title;
+	size_t title_len_utf8;
+
+	struct strbuf status;
+	size_t status_len_utf8;
+
 	uint64_t last_value;
 	uint64_t total;
 	unsigned last_percent;
 	unsigned delay;
 	struct throughput *throughput;
 	uint64_t start_ns;
-	struct strbuf counters_sb;
-	int title_len;
 	int split;
 
 	/*
-- 
2.32.0.599.g3967b4fa4ac

