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
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E6820964
	for <e@80x24.org>; Sun,  2 Apr 2017 04:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbdDBEgB (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 00:36:01 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33771 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdDBEgA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 00:36:00 -0400
Received: by mail-qt0-f196.google.com with SMTP id r45so15137510qte.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 21:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hjc3s3MRlBN6r/F8mwYpVVHD2QcZKf8MuhcOpW7hH8A=;
        b=RPL5LPlmIyb4g7su3D9kJt6x+mEeBsgmSz2Z8Usgm0qOS6p+Eh/l8WakEvojLPt92v
         ogxt6n6F2kTymjnBzRaTsnANf57zML/Jy/uQk45F+jlgGG2/+UTpJa++InPYyr1SlZdo
         mEjCQrtdYt4YwJLCIMCKgZWO5SWjY08XePMRZlhUoLZ35D9dfxPjSr4oqjr8+6eTmhDx
         QRFj0aGYwrUMr5+NbAV44wT9WpNx8Ua7YiUcqmEHd9jj7EXWsh8GD41bEcfaqyx5AHUg
         TMG5jAjN1tw6mS1g9prtfxJmItu5e8MhHekQqFNZhpOh7OkOkp652O1/2oQsTJR1hnuB
         otaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hjc3s3MRlBN6r/F8mwYpVVHD2QcZKf8MuhcOpW7hH8A=;
        b=LY5kVAwv9i/rtTMQf1M/sz9hqzuScE2DyhlOqgE6EHQsHggBNL7FCiRS85F3GnDoZW
         giy0OTxomhePebSs/jSh/+A3pzCNXdImqpJ82IEoQW6RgTrgbM+r/RRgzP+nEQABGIcz
         FiZkbeA0IUQGXuRR8LRsQBQQ9TPfCcJ14lQq85Hn8IaU0D1B6rUeKdpjM4JkzgrlxZRE
         F5fYnRxrnAWO//H+5bNlIvzo3ImC2ZCk1WEB28Ygkr2gp2uhbLnbs4SiIR960r3ZJ80Y
         D8V8boc6AmP78A5dZ8PIFonPbtsQgIVSBBpTfs5KctolYvvpxcTXLrjfHkWcUavsNzoS
         FSQg==
X-Gm-Message-State: AFeK/H3qL2I38+IlcKRwuBPBqi1dh3q4BA1XfHvO8yAE39e98CnTK/lwmQL4YM8Txhip3A==
X-Received: by 10.237.42.21 with SMTP id c21mr10139135qtd.11.1491107758984;
        Sat, 01 Apr 2017 21:35:58 -0700 (PDT)
Received: from localhost.localdomain ([189.103.231.223])
        by smtp.gmail.com with ESMTPSA id t23sm6907383qka.37.2017.04.01.21.35.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Apr 2017 21:35:58 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, peff@peff.net,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v6 3/5] dir_iterator: add helpers to dir_iterator_advance
Date:   Sun,  2 Apr 2017 01:35:24 -0300
Message-Id: <1491107726-21504-4-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491107726-21504-1-git-send-email-bnmvco@gmail.com>
References: <1491107726-21504-1-git-send-email-bnmvco@gmail.com>
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

