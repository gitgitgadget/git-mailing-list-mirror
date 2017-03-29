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
	by dcvr.yhbt.net (Postfix) with ESMTP id C38C11FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 00:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932748AbdC2Acr (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 20:32:47 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33848 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932608AbdC2Acb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 20:32:31 -0400
Received: by mail-qt0-f195.google.com with SMTP id x35so127448qtc.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 17:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B3dPNK96MF4HdoMLKdWNgIu5Zu7qODk5kK7GuZXg4Rs=;
        b=O+UuDf6AVRPVDIBrzJX34cUvvgTJFisud4ofla9gXUPzdYitl79KhV7vDqxrS5WBSw
         QWfA4yflYikJA+p4NTnupw69B+cKhsqco1+B/g2InS9o1sVQjyv//5wz+guxd215g/ya
         DPtZvldh1p5crTTueUfGsKaRS+/OQkUkL7XtSMCXhNVI62fLOxpjp82i0ZGC9XKPObLN
         zbzudtpPbszNbM+OfRV6V+B+eEeu72yIX5QMGTUdmE6j3UbD4awUums1Hocirn3pMhlz
         56p554R2Ii+qOe1rXuPMLBjMqqU79knrzlZGGsSs9RpqPYGsa70R8RDYolrGUB4yPOdc
         +w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B3dPNK96MF4HdoMLKdWNgIu5Zu7qODk5kK7GuZXg4Rs=;
        b=HIpu57UBEi1oUmtzFhBb7a9kX/70Tj9fJm1EBWtUpsK0RzojZu9CKwAB/v2qgVOd3L
         AHlwXBcdiK9OqKXIN6uNTaOgmsXYPbImP91Cwa6YW+1JykVM6AKH+ox4REfGi653qn5k
         lEagVcbR/lz0h22i93ZICMR4VfV+noPsgmdiSR1kN6QmaYymyPbwsHYLEzbhSpT+kEHe
         Z45GFIKu6SteSY8ZHO9SUxpFtAV9tbSUdBXKVKh8Vt0x60bxxDCYqi1kQVH6K64AysS6
         YXp59U5DhtoyW7d7LXydSC0DXo+0vys+VEf+nsdR6xP1ekRGkK9dyW4pGjAVfIXAZHdO
         QJzA==
X-Gm-Message-State: AFeK/H0QZnniFPnhCaw0prTt1aNQeNp6oONW+RdVbXw93zOyc6YGrRHNvWJNDm3toCLu+Q==
X-Received: by 10.200.47.225 with SMTP id m30mr28775858qta.175.1490747549765;
        Tue, 28 Mar 2017 17:32:29 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net ([187.11.121.49])
        by smtp.gmail.com with ESMTPSA id x26sm3819420qtx.47.2017.03.28.17.32.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 17:32:28 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v4 1/5] dir_iterator: add helpers to dir_iterator_advance
Date:   Tue, 28 Mar 2017 21:32:09 -0300
Message-Id: <1490747533-89143-2-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
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
index 34182a9..853c040 100644
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
+static inline int pop_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
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
+			if (pop_dir_level(iter, level) == 0)
 				return dir_iterator_abort(dir_iterator);

 			continue;
@@ -129,7 +162,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 						iter->base.path.buf, strerror(errno));

 				level->dir = NULL;
-				if (--iter->levels_nr == 0)
+				if (pop_dir_level(iter, level) == 0)
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

