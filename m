Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ACFD202BB
	for <e@80x24.org>; Mon, 25 Mar 2019 10:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbfCYKjA (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 06:39:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37347 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfCYKjA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 06:39:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so9492780wrm.4
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aaky29/FccbXURdWIlAx4/1oV9df5zw19GK3KRzD4Xk=;
        b=Z2kopLPSeFuRnlgEhNtSvjNqR+Grhs0ZZQKFYUerfpJhD6qHjfrX+79Hd+RZ0Tfu+0
         07Gf4oLuDoXSMv9eDSbRyzL3jMKE+YfSdDZOxEF7qQraVw1SLKj2mbfjC32Nx8xA/RI1
         /rUQJJPRi3ISpb/MKCsu4b9VP6q+fqwHOqJWTmVQDA+6E0oBHXJyIV38J7ARXe7iFG1/
         xe8x/SGr1G+esMQzTdWAitCx7WArYtqQujw8UdxvdLlxTC3tMMDrSM9GvA+EKfAZ6n9E
         ieamfe3ewb46uVyX41frbFegSIPTinxvWNcd53USoBNFPl1NnJWUbn573kXueZ3bc8iT
         XtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaky29/FccbXURdWIlAx4/1oV9df5zw19GK3KRzD4Xk=;
        b=GK6l12cfrxOLYzes5caWbX+R7r4158jPdfOGwjQOVC7mW7vIp17kGSOYxUWuM+8b2U
         htptTLlw3ILfL8z0/n5Vd3Bef2ipPYUkdpUB+oDMXwbKFIigVFdXIS5YyeARFKseedVb
         XIrYLf7CxZAV+LkjXVsDbmx6j2V9c3TgdQnRhvfo5UiTX4Wy/o8NEXnRMruyE7KZHqIw
         qGCyTjpaPV8DLM526HNDQA9l2y6q1+PWLJIwAmrMVVZuPo/2DSN7C1GAKzKRREplQ26u
         ywIvn6dcXWI6fVP4aaprTrG1kN26fK43klyNz/qI9bzhB3bKy27GGAqKvFOigXp98Cbf
         R2+g==
X-Gm-Message-State: APjAAAXVbDANNA4Yqogb0HElg1gia8LH5GzxYX13boOMYZnpMgV/BNcR
        fj2YM4UIFw45OKxi7Ta8eAU/2IEVk+4=
X-Google-Smtp-Source: APXvYqyNBPKg8iLVS/Ov6m2lrmXoZVZDxPq3BwkE2LdGFyBrRv1XJU5Qtx3RpjbT/wrDk3Il2b0A8g==
X-Received: by 2002:adf:afd0:: with SMTP id y16mr14587715wrd.328.1553510338130;
        Mon, 25 Mar 2019 03:38:58 -0700 (PDT)
Received: from localhost.localdomain (x4d0c296b.dyn.telefonica.de. [77.12.41.107])
        by smtp.gmail.com with ESMTPSA id q2sm23247292wrd.46.2019.03.25.03.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:38:57 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/5] progress: make display_progress() return void
Date:   Mon, 25 Mar 2019 11:38:40 +0100
Message-Id: <20190325103844.26749-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190325103844.26749-1-szeder.dev@gmail.com>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since the progress infrastructure was introduced in 96a02f8f6d
(common progress display support, 2007-04-18), display_progress() has
returned an int, telling callers whether it updated the progress bar
or not.  However, this is:

  - useless, because over the last dozen years there has never been a
    single caller that cared about that return value.

  - not quite true, because it doesn't print a progress bar when
    running in the background, yet it returns 1; see 85cb8906f0
    (progress: no progress in background, 2015-04-13).

The related display_throughput() function returned void already upon
its introduction in cf84d51c43 (add throughput to progress display,
2007-10-30).

Let's make display_progress() return void, too.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c | 15 ++++++++-------
 progress.h |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/progress.c b/progress.c
index 5a99c9fbf0..02a20e7d58 100644
--- a/progress.c
+++ b/progress.c
@@ -78,12 +78,12 @@ static int is_foreground_fd(int fd)
 	return tpgrp < 0 || tpgrp == getpgid(0);
 }
 
-static int display(struct progress *progress, uint64_t n, const char *done)
+static void display(struct progress *progress, uint64_t n, const char *done)
 {
 	const char *eol, *tp;
 
 	if (progress->delay && (!progress_update || --progress->delay))
-		return 0;
+		return;
 
 	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
@@ -100,7 +100,7 @@ static int display(struct progress *progress, uint64_t n, const char *done)
 				fflush(stderr);
 			}
 			progress_update = 0;
-			return 1;
+			return;
 		}
 	} else if (progress_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
@@ -109,10 +109,10 @@ static int display(struct progress *progress, uint64_t n, const char *done)
 			fflush(stderr);
 		}
 		progress_update = 0;
-		return 1;
+		return;
 	}
 
-	return 0;
+	return;
 }
 
 static void throughput_string(struct strbuf *buf, uint64_t total,
@@ -188,9 +188,10 @@ void display_throughput(struct progress *progress, uint64_t total)
 		display(progress, progress->last_value, NULL);
 }
 
-int display_progress(struct progress *progress, uint64_t n)
+void display_progress(struct progress *progress, uint64_t n)
 {
-	return progress ? display(progress, n, NULL) : 0;
+	if (progress)
+		display(progress, n, NULL);
 }
 
 static struct progress *start_progress_delay(const char *title, uint64_t total,
diff --git a/progress.h b/progress.h
index 70a4d4a0d6..59e40cc4fd 100644
--- a/progress.h
+++ b/progress.h
@@ -4,7 +4,7 @@
 struct progress;
 
 void display_throughput(struct progress *progress, uint64_t total);
-int display_progress(struct progress *progress, uint64_t n);
+void display_progress(struct progress *progress, uint64_t n);
 struct progress *start_progress(const char *title, uint64_t total);
 struct progress *start_delayed_progress(const char *title, uint64_t total);
 void stop_progress(struct progress **progress);
-- 
2.21.0.539.g07239c3a71.dirty

