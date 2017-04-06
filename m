Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C7620966
	for <e@80x24.org>; Thu,  6 Apr 2017 01:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756623AbdDFBjz (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 21:39:55 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35317 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756592AbdDFBju (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 21:39:50 -0400
Received: by mail-qk0-f194.google.com with SMTP id k139so4063442qke.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 18:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=in2F8IDQb0KYMCT5M2KscmgamyWWB3M5JiiF7CDxVMg=;
        b=sYtJO79VgcRDbh8wfv55btjRnyZ36h5LQEOIiv5V5XnLb8Nz2Q6+fHbcJbAXtUZjpL
         57Rml+ivlm7tIMQS862V1PRXX+f+WJ52HdFfbfMPXXyd4+yHBBSm5DZ0ZlMbUkiUv/6o
         dMgORvFJdTyXXGeAAs3kCeIGclgbvHXyEb+mqtri0SmFAF+MBjxaQTmtxKcbt6Ho0d1C
         yRUMBWcf6jGarpdoHltbHNCePw9A9SpeL9yyOI/KA70Xz82J1c5CEA8BvA6qda7qYYYj
         xFzSs6t+nF/hfJMymDwqk7A/XgGzVhtIxBB04puWM/Sima/87rDMg9etL1zwKUHg7xD0
         UDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=in2F8IDQb0KYMCT5M2KscmgamyWWB3M5JiiF7CDxVMg=;
        b=cPN5vnc1Ml+sAyAA0wzOw43JaeqvGpNLK63b8XNU6n+UqsfNDu0FYbV6Lizly6Zcs5
         XEkJ9UjxnqRmjR3pT3GAhALfluMYyXBN2xsue/yF4CF5nLlyvspCc8spCtB0cLkM89kb
         /GncWd3qscRfK8L7lcNeaF2M8M5j7klgcIYTSY07BK1psZCMfvjWvO3AKw+mQ9my+PYU
         xf6mj5+zYd/DV3d2B8oBrue3ovUEU4/IA3ZUOTD7H9fFEf0Qn7Syj5+PkaYLFo7GcR/M
         r4ZSwM4KHtuDhFExosEbtsHAT10n4Vc4c3GEcAD+1MKi82otvehDPko9+hSjR8ot/mit
         jCAQ==
X-Gm-Message-State: AFeK/H1lv3Fd2N9Zl2MMXiPcNXucYSvnouemGzJSDIR9FzIga1Yl0SysksQNCcZyt8l1bw==
X-Received: by 10.55.15.162 with SMTP id 34mr29136219qkp.114.1491442784680;
        Wed, 05 Apr 2017 18:39:44 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net ([187.11.121.49])
        by smtp.gmail.com with ESMTPSA id b78sm58718qkc.50.2017.04.05.18.39.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 18:39:43 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v8 3/5] dir_iterator: add helpers to dir_iterator_advance
Date:   Wed,  5 Apr 2017 22:39:25 -0300
Message-Id: <1491442767-54068-4-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
References: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create helpers to dir_iterator_advance(). Make dir_iterator_advance()'s
code more legible and allow some behavior to be reusable.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 dir-iterator.c | 65 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 34182a9..9e073a0 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -50,6 +50,43 @@ struct dir_iterator_int {
 	struct dir_iterator_level *levels;
 };
 
+static void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
+{
+	level->dir_state = DIR_STATE_RECURSE;
+	ALLOC_GROW(iter->levels, iter->levels_nr + 1,
+		   iter->levels_alloc);
+	level = &iter->levels[iter->levels_nr++];
+	level->initialized = 0;
+}
+
+static int pop_dir_level(struct dir_iterator_int *iter)
+{
+	return --iter->levels_nr;
+}
+
+static int set_iterator_data(struct dir_iterator_int *iter, struct dir_iterator_level *level)
+{
+	if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
+		if (errno != ENOENT)
+			warning("error reading path '%s': %s",
+				iter->base.path.buf,
+				strerror(errno));
+		return -1;
+	}
+
+	/*
+	 * We have to set these each time because
+	 * the path strbuf might have been realloc()ed.
+	 */
+	iter->base.relative_path =
+		iter->base.path.buf + iter->levels[0].prefix_len;
+	iter->base.basename =
+		iter->base.path.buf + level->prefix_len;
+	level->dir_state = DIR_STATE_ITER;
+
+	return 0;
+}
+
 int dir_iterator_advance(struct dir_iterator *dir_iterator)
 {
 	struct dir_iterator_int *iter =
@@ -84,11 +121,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 				 * over; now prepare to iterate into
 				 * it.
 				 */
-				level->dir_state = DIR_STATE_RECURSE;
-				ALLOC_GROW(iter->levels, iter->levels_nr + 1,
-					   iter->levels_alloc);
-				level = &iter->levels[iter->levels_nr++];
-				level->initialized = 0;
+				push_dir_level(iter, level);
 				continue;
 			} else {
 				/*
@@ -104,7 +137,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			 * This level is exhausted (or wasn't opened
 			 * successfully); pop up a level.
 			 */
-			if (--iter->levels_nr == 0)
+			if (pop_dir_level(iter) == 0)
 				return dir_iterator_abort(dir_iterator);
 
 			continue;
@@ -129,7 +162,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 						iter->base.path.buf, strerror(errno));
 
 				level->dir = NULL;
-				if (--iter->levels_nr == 0)
+				if (pop_dir_level(iter) == 0)
 					return dir_iterator_abort(dir_iterator);
 				break;
 			}
@@ -138,23 +171,9 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 				continue;
 
 			strbuf_addstr(&iter->base.path, de->d_name);
-			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
-				if (errno != ENOENT)
-					warning("error reading path '%s': %s",
-						iter->base.path.buf,
-						strerror(errno));
-				continue;
-			}
 
-			/*
-			 * We have to set these each time because
-			 * the path strbuf might have been realloc()ed.
-			 */
-			iter->base.relative_path =
-				iter->base.path.buf + iter->levels[0].prefix_len;
-			iter->base.basename =
-				iter->base.path.buf + level->prefix_len;
-			level->dir_state = DIR_STATE_ITER;
+			if (set_iterator_data(iter, level))
+				continue;
 
 			return ITER_OK;
 		}
-- 
2.7.4 (Apple Git-66)

