Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CFCE20984
	for <e@80x24.org>; Sun, 11 Sep 2016 05:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755496AbcIKFmp (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 01:42:45 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36700 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbcIKFmi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 01:42:38 -0400
Received: by mail-pa0-f65.google.com with SMTP id ez1so6009089pab.3
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 22:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q70cFPBDjZtMzEHR5kspiGFdVuEJMY06/afU24mRFpk=;
        b=xeyDcbrgaU3SwJTUEgDp6wu0F1bhCXTkjpwavo2JR4t67MD6/gWy9yo1qlWO2yrKAE
         p2EFSxasSNG3E22PHlUkJP//Sx1p+3v7NYktAVJ1j/kTGLtYx8u/jQGOB8RJAJed8ZK6
         uzswNjckYuUxju8Uc61/0Yh93E35zcCFCzWti0asFIlcN2RdMGN5+r9Jzjh+J0ZgfhhT
         CK+KZ/uok1CxXbsrVUqZNWWucpxO5tWXAG6XrC7xWjv57xUWOlKxDxQhKvbkGeE8TEfH
         xzzS9Cqe5Mg77QpWL6CWxXZhh+r1JD+vE2JRe4IuVUeerj4nySCcweBkHlFtg/zYZakv
         6JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q70cFPBDjZtMzEHR5kspiGFdVuEJMY06/afU24mRFpk=;
        b=FaVXmfOqXr+Kz0IdKYNO6I/rfQoajlUvSzO1/FNWZJU/Ucvw/R/fU4Eni+HKGriJnf
         mnwXFB1K1kfllMgeL07TqNV0Jz9mvwrKzhWKOCg8EmdF0cY4cVUoE0idVOdaXksGh5P0
         wvD+c3c/DMEjXEM6AY2cTY/ovkibVONzK9JOl5K6E0DZqZcUjL0NTSLdr99hEwbANStR
         kYYU9Qyhp+kQ9w3Zy3Edep99BSZmU2inNnjW2aMm1BwtJy++qz28mt6dPFIoaMgKl1jk
         A2jGwT+rB0ZkaR5g855vtlXvxcOw0kRW71vBXcuDcVOBJ+put6fRSY/Po9Z+SJv9l2bu
         TZ5A==
X-Gm-Message-State: AE9vXwPPwFaYKXYljIf9D+NvH3UvuXSpA//k26iCbHkhQcpzhmjlQOJPau+8hVedOHsLBw==
X-Received: by 10.66.170.135 with SMTP id am7mr21204795pac.6.1473572556458;
        Sat, 10 Sep 2016 22:42:36 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id n18sm15466033pfa.48.2016.09.10.22.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 22:42:35 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/10] diff.c: rename diff_flush_patch to diff_flush_patch_filepair
Date:   Sat, 10 Sep 2016 22:42:04 -0700
Message-Id: <1473572530-25764-5-git-send-email-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 9d2e704..85fb887 100644
--- a/diff.c
+++ b/diff.c
@@ -4176,7 +4176,7 @@ int diff_unmodified_pair(struct diff_filepair *p)
 	return 0;
 }
 
-static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
+static void diff_flush_patch_filepair(struct diff_filepair *p, struct diff_options *o)
 {
 	if (diff_unmodified_pair(p))
 		return;
@@ -4672,7 +4672,7 @@ void diff_flush(struct diff_options *options)
 	    DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
 	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
 		/*
-		 * run diff_flush_patch for the exit status. setting
+		 * run diff_flush_patch_filepair for the exit status. setting
 		 * options->file to /dev/null should be safe, because we
 		 * aren't supposed to produce any output anyway.
 		 */
@@ -4685,7 +4685,7 @@ void diff_flush(struct diff_options *options)
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
-				diff_flush_patch(p, options);
+				diff_flush_patch_filepair(p, options);
 			if (options->found_changes)
 				break;
 		}
@@ -4705,7 +4705,7 @@ void diff_flush(struct diff_options *options)
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
-				diff_flush_patch(p, options);
+				diff_flush_patch_filepair(p, options);
 		}
 	}
 
-- 
2.7.4

