Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4671F462
	for <e@80x24.org>; Tue, 11 Jun 2019 13:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389902AbfFKNDp (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 09:03:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55048 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389958AbfFKNDn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 09:03:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so2870819wme.4
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1VgAFs/fc+Y/9eiRj7tYKketPPl27dz5wMWbvtZ+5Q=;
        b=B5ZRRHFF+FvMgSsWM9bWyitBf7QdsRWDFdIp+GpUfsq1/3YueGqBPlQ0NsQ9FYKdF4
         zyOoT9AUqCnrBEcuZUVz6MXwkotYgd8ewEttTAquFJ9HOiuzZIgVBr7C+6vOZ1umIAFS
         q6o8d8FRkGTuy5bGF4jobje5VoiI1OUo5C0LgUxlDzAMdW50iqhj9ccT6ZRMl5xrSrn4
         64/usX3HmbPrZQlwRxdRsWd/LG+XL2jR2+Zcs6gBrtE2ERtyJ7BAJEVV25txzolVRCM2
         rsrpRab8ux+Wg2/o1rGu20t4Al48UwKRzB1KQUEC7yxpssuA8x85FEGJqthPghfKOu19
         FF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1VgAFs/fc+Y/9eiRj7tYKketPPl27dz5wMWbvtZ+5Q=;
        b=m/8mppR+aH4dVsFPOVOQllcrZ7zv6o41cYVaK1LsFwRzwHDjSl9OyF0Iqc6FuUcQ0d
         97dpB4WzTp8/f1/Zxbe0sSRkQBq3mZH2VVcu6Q+s2lsPvL5Z7NR9U6it+Iy5Iu6bT+Qg
         b9nBg8ZRPPkaDCdcgEQfV2B6uMqbv1QBGgXqPd0tHKvupq7tHOcdb4Km5pEP+h2BADHd
         mHWNrOA5Qg5TznSAUy6WCGm9IvSvK6j/cXneRWBkHNQXDHZ2mxawKu7+ioWVweJqWdae
         qqMvnnnopOOR21KSSd489TFV6uuEqt0L/vRvlo4jjzazmg0NHZtK8qeY2JPFRqCSO11u
         6sXA==
X-Gm-Message-State: APjAAAW3wyeN8+X2X3AsBqdZjUjP0TiX3xVq+j7+pjGCZ6PgcAMXQR+Y
        CKd3O3bVu429lr7a6iECb/k=
X-Google-Smtp-Source: APXvYqwFMqRRWD1EBYuI5hVo9BLNqMLYd5WDuS0iv6fUBsacV7jNy8u27pPeZ/xvOHK4Y5QoX0b5oQ==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr17419821wmh.165.1560258221301;
        Tue, 11 Jun 2019 06:03:41 -0700 (PDT)
Received: from localhost.localdomain (x4d0cbedf.dyn.telefonica.de. [77.12.190.223])
        by smtp.gmail.com with ESMTPSA id l190sm2561524wml.16.2019.06.11.06.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 06:03:40 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 4/4] progress: use term_clear_line()
Date:   Tue, 11 Jun 2019 15:03:20 +0200
Message-Id: <20190611130320.18499-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.566.g58873a45ff
In-Reply-To: <20190611130320.18499-1-szeder.dev@gmail.com>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make sure that the previously displayed progress line is completely
covered up when the new line is shorter, commit 545dc345eb (progress:
break too long progress bar lines, 2019-04-12) added a bunch of
calculations to figure out how many characters it needs to overwrite
with spaces.

Use the just introduced term_clear_line() helper function to, well,
clear the last line, making all these calculations unnecessary, and
thus simplifying the code considerably.

Three tests in 't5541-http-push-smart.sh' 'grep' for specific text
shown in the progress lines at the beginning of the line, but now
those lines begin either with the ANSI escape sequence or with the
terminal width worth of space characters clearing the line.  Relax the
'grep' patterns to match anywhere on the line.  Note that only two of
these three tests fail without relaxing their 'grep' pattern, but the
third looks for the absence of the pattern, so it still succeeds, but
without the adjustment would potentially hide future regressions.

Note also that with this change we no longer need the length of the
previously displayed progress line, so the strbuf added to 'struct
progress' in d53ba841d4 (progress: assemble percentage and counters in
a strbuf before printing, 2019-04-05) is not strictly necessary
anymore.  We still keep it, though, as it avoids allocating and
releasing a strbuf each time the progress is updated.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c                 | 28 +++++++++++-----------------
 t/t5541-http-push-smart.sh |  6 +++---
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/progress.c b/progress.c
index a2e8cf64a8..095dcd0ddf 100644
--- a/progress.c
+++ b/progress.c
@@ -88,7 +88,6 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	const char *tp;
 	struct strbuf *counters_sb = &progress->counters_sb;
 	int show_update = 0;
-	int last_count_len = counters_sb->len;
 
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
@@ -116,26 +115,21 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	if (show_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
 			const char *eol = done ? done : "\r";
-			size_t clear_len = counters_sb->len < last_count_len ?
-					last_count_len - counters_sb->len + 1 :
-					0;
-			size_t progress_line_len = progress->title_len +
-						counters_sb->len + 2;
-			int cols = term_columns();
 
+			term_clear_line();
 			if (progress->split) {
-				fprintf(stderr, "  %s%*s", counters_sb->buf,
-					(int) clear_len, eol);
-			} else if (!done && cols < progress_line_len) {
-				clear_len = progress->title_len + 1 < cols ?
-					    cols - progress->title_len - 1 : 0;
-				fprintf(stderr, "%s:%*s\n  %s%s",
-					progress->title, (int) clear_len, "",
-					counters_sb->buf, eol);
+				fprintf(stderr, "  %s%s", counters_sb->buf,
+					eol);
+			} else if (!done &&
+				   /* The "+ 2" accounts for the ": ". */
+				   term_columns() < progress->title_len +
+						    counters_sb->len + 2) {
+				fprintf(stderr, "%s:\n  %s%s",
+					progress->title, counters_sb->buf, eol);
 				progress->split = 1;
 			} else {
-				fprintf(stderr, "%s: %s%*s", progress->title,
-					counters_sb->buf, (int) clear_len, eol);
+				fprintf(stderr, "%s: %s%s", progress->title,
+					counters_sb->buf, eol);
 			}
 			fflush(stderr);
 		}
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 8ef8763e06..2e4802e206 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -213,7 +213,7 @@ test_expect_success TTY 'push shows progress when stderr is a tty' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit noisy &&
 	test_terminal git push >output 2>&1 &&
-	test_i18ngrep "^Writing objects" output
+	test_i18ngrep "Writing objects" output
 '
 
 test_expect_success TTY 'push --quiet silences status and progress' '
@@ -228,7 +228,7 @@ test_expect_success TTY 'push --no-progress silences progress but not status' '
 	test_commit no-progress &&
 	test_terminal git push --no-progress >output 2>&1 &&
 	test_i18ngrep "^To http" output &&
-	test_i18ngrep ! "^Writing objects" output
+	test_i18ngrep ! "Writing objects" output
 '
 
 test_expect_success 'push --progress shows progress to non-tty' '
@@ -236,7 +236,7 @@ test_expect_success 'push --progress shows progress to non-tty' '
 	test_commit progress &&
 	git push --progress >output 2>&1 &&
 	test_i18ngrep "^To http" output &&
-	test_i18ngrep "^Writing objects" output
+	test_i18ngrep "Writing objects" output
 '
 
 test_expect_success 'http push gives sane defaults to reflog' '
-- 
2.22.0.566.g58873a45ff

