Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A5A20A04
	for <e@80x24.org>; Mon, 17 Apr 2017 20:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932229AbdDQUwF (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 16:52:05 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35145 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbdDQUwB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 16:52:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id o36so20300596qtb.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 13:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=in2F8IDQb0KYMCT5M2KscmgamyWWB3M5JiiF7CDxVMg=;
        b=Rocs1LknJQfR5tr8FCf3PiXJO2dB2GOrljlqx3nfeF3lomCKHUfbLpkVu8bZjU6Gvb
         3L4B3tx/c9lK8QkHyXGny0IHRsRQNJDgZl4n1UDbmSDNoQSqXgdWl4QGRLUokLp1qxcN
         hnQ5FvDn8X3akWreJdp+Qkuj4gnjQf9hPxpf7qSq9+FlWpZ6qoXgCNK0gx68Re7ytToI
         hj7r8YONrdICxZbxbUZRTfcPttScxTwKhLWdlBr/EIjktQBnA+BvTstMAIuR/CSYGXgH
         z4LWl1vEo+DNh0jT8lGW3Dte/Iuu9Gh6Esv6LBl461YG/wHMSy70856xm9X+KurZWpwN
         /7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=in2F8IDQb0KYMCT5M2KscmgamyWWB3M5JiiF7CDxVMg=;
        b=Gd8JShplSFqHmBeeQUzFVJst2uSfOwCthwrCxBBtXk9n9Ek28uJdJQMQ8h4P+/eWOc
         XxPyJ9yNvRPgIMplwbhVo71wLKHBcqhqDWDYGf9Ib2aQfGzw3ePmQxYdbQjmDXglwWe+
         YHy2QMBca9TrSp9oFcNtiEnjlGA9yMS70EMF5dFa//20TS7AbwMoeGH/CxGU65Xlj7uz
         gL1fEmB4jDVdyRRXGYgHxJDVq8umVfdZi8cWgzJt2+/Viak6O+6a8HyBruY1D4jIIHlm
         SVZaK1hIksMNovON2lJdXygJ9Z3TEF09KOoFyDa7xnu8LuuompdBvrPDZRzUymVfzDkl
         l1/A==
X-Gm-Message-State: AN3rC/7hLr5EzKKyOwnUuOBW9237uznKC+EE9smRsEOkAaD3h5yL4UUf
        uTk6tybgTj+7qA==
X-Received: by 10.237.62.243 with SMTP id o48mr10343454qtf.89.1492462315374;
        Mon, 17 Apr 2017 13:51:55 -0700 (PDT)
Received: from localhost.localdomain ([179.222.191.2])
        by smtp.gmail.com with ESMTPSA id f203sm8093848qka.11.2017.04.17.13.51.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 13:51:54 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v9 3/5] dir_iterator: add helpers to dir_iterator_advance
Date:   Mon, 17 Apr 2017 17:51:34 -0300
Message-Id: <1492462296-4990-4-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
References: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
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

