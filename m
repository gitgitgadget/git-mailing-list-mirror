Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77A1220966
	for <e@80x24.org>; Sun,  2 Apr 2017 20:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbdDBUFc (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 16:05:32 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35034 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdDBUFb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 16:05:31 -0400
Received: by mail-qk0-f196.google.com with SMTP id k139so5468471qke.2
        for <git@vger.kernel.org>; Sun, 02 Apr 2017 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hjc3s3MRlBN6r/F8mwYpVVHD2QcZKf8MuhcOpW7hH8A=;
        b=NdhjzO6EXsrkRX1QMA/I75e37D4ZYKmsURppGiYADVC8euEQurLJ9CKNC3mNqbTgWz
         B9bZ9CLgsvwEJJLe7MQuS/08j/rTSIHRXxi0qyZGi46AcWxyJkCqwom2YvKfU4W6jqoc
         G/xBK0ArI1Ug4/YN7Uhn3NnSmWcTmy+i+T1HpMAiiqvdtwtO2XR+c2lmg64Kb9Y/HTxP
         S8T7WmNdoOFAd+qM9ZGceoVMo2GuJMTJqB04LYqsZE+uRoJFRCTFwBjblm1DzhYtBPa8
         5ocg3xpYnU1gfZGFVSaD3Nag5AyL9ScN9+GxT4SiQm2T0qP0dFArJhRCaVRlEM/BHLLL
         5qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hjc3s3MRlBN6r/F8mwYpVVHD2QcZKf8MuhcOpW7hH8A=;
        b=oMDZOyievxQv/6gBLj54n5M5N2wDpwTU7/UJSzvz9wD1yUJrfInUYrrRcvi7y6oHtU
         i44HsC7zzSjF3yQ7Z7jqVXRUXtd/hQPSiFBLbQea5jO5BNR67BnZljgEalMwmD7gNt3i
         URRUkgVgldXHKtkdSTXRe4mun5VtQxPjvhKG6FRFbU/O86bR+f7Ylqfb0KL3pFVzPR7z
         Ff9Ni0DEWWE0SmStMmkC3SvhjhI1CKUWydhwiYTRKCDVKEPfro9SzU1OCEni4D6zIYwv
         7zwwAUaO977hNvft26uQAyo+e3gztrngphTcclx6bA6jSCrLqhsb/TpYxnLTwFEJ8LKE
         YUUQ==
X-Gm-Message-State: AFeK/H2QEhzYrS6i+tT7x3e5n54bQAZMDAQUaAUBujvCUctYZaZDdmjWwfx6tBZQhh9VVg==
X-Received: by 10.55.93.131 with SMTP id r125mr13412199qkb.282.1491163530371;
        Sun, 02 Apr 2017 13:05:30 -0700 (PDT)
Received: from localhost.localdomain (186-245-85-163.user3g.veloxzone.com.br. [186.245.85.163])
        by smtp.gmail.com with ESMTPSA id 137sm8162258qkd.19.2017.04.02.13.05.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 02 Apr 2017 13:05:29 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v7 3/5] dir_iterator: add helpers to dir_iterator_advance
Date:   Sun,  2 Apr 2017 17:03:06 -0300
Message-Id: <1491163388-41255-4-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491163388-41255-1-git-send-email-bnmvco@gmail.com>
References: <1491163388-41255-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create inline helpers to dir_iterator_advance(). Make
dir_iterator_advance()'s code more legible and allow some behavior to
be reusable.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 dir-iterator.c | 65 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 34182a9..ce8bf81 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -50,6 +50,43 @@ struct dir_iterator_int {
 	struct dir_iterator_level *levels;
 };
 
+static inline void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
+{
+	level->dir_state = DIR_STATE_RECURSE;
+	ALLOC_GROW(iter->levels, iter->levels_nr + 1,
+		   iter->levels_alloc);
+	level = &iter->levels[iter->levels_nr++];
+	level->initialized = 0;
+}
+
+static inline int pop_dir_level(struct dir_iterator_int *iter)
+{
+	return --iter->levels_nr;
+}
+
+static inline int set_iterator_data(struct dir_iterator_int *iter, struct dir_iterator_level *level)
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

