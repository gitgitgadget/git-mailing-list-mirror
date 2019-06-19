Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3C0E1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 09:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbfFSJ7j (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 05:59:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40843 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731385AbfFSJ7i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 05:59:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so4722719pgj.7
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mOwsuLV5YQw/z24XqQpVieu79p1qEgu/udmI1Zu1dec=;
        b=oKVjw+/92ZkrHMW4MBEPDqWza26CCizNuGylGechtV9M4KrGjlJxHu+axvQiWlXXw0
         fHb0/ceOL/9sFtbhj16NzYzWnHj0FMkdMEcRcZUMQJ/63Qe/5Rxui0qoG8f4WbMXjFk+
         +SNL+UfTL8ZGhWCa8th5e1BvIgMauXddX1N7ZWu+YuUjnyXirB8TNXqOpdBNYnYpZlsN
         y7indrRLy30wOTragGJwBV8JcA1XUgPlyWMfMIVxoQJBzV+kNGPmq0tlawauiOqbHMqD
         rA3NgSOCuXGN4AiuTYrme37ppr29vjJZxi+zPp6PmX6INpxm++Z4NMOqzDXjF1Hgx2Mo
         Q2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mOwsuLV5YQw/z24XqQpVieu79p1qEgu/udmI1Zu1dec=;
        b=YrA9th7zs2Q2t21Vjp0JYspWDdals79QKn+K+S/hpbh0Ja6+1uCa7Ln+o7M94LCIku
         bSfgDVEDkU+4Cjp9WfL+C5pOz9pDuAGaYuMepiL4s5OlucXFPPaGjotM6fVYqWeXvp2B
         euBJaRA2YawxRaThbU61h3iMysQUPal0139nyGg4W/DoF46z6x6/m8XorRKHQVtuj9sy
         ZGuPaFceOqFLeVlKV0VEYtBZUkeH01VhuRAdDQCEWo/80HJm3VyZLrLY8Z4Tge2Va0x4
         8aWoZ6IoM1TEkLX5SB1tDHT9/DKV+x0jlE3ALXCSj4fS1LJjBnAMBWdXKphs2xN7jiEe
         YCmw==
X-Gm-Message-State: APjAAAVUsQrVzNEP3qOhNct0scg8rtqkerDk7j9zY8YCsj30Va3XM2By
        7FbRWU6dffmO+KjlA5K5qyMfxW0t
X-Google-Smtp-Source: APXvYqyeCaoNPDON528FAYN1L003HJCOt1asf4BB1n8QIZ2FEY81zFhf6xwJZhrfT7fow89GdCoZXg==
X-Received: by 2002:a63:1d10:: with SMTP id d16mr6897666pgd.446.1560938377512;
        Wed, 19 Jun 2019 02:59:37 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id u20sm15836079pgm.56.2019.06.19.02.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 02:59:36 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Jun 2019 16:59:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 7/8] cache-tree.c: dump "TREE" extension as json
Date:   Wed, 19 Jun 2019 16:58:57 +0700
Message-Id: <20190619095858.30124-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com>
References: <20190619095858.30124-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache-tree.c | 41 ++++++++++++++++++++++++++++++++++++-----
 cache-tree.h |  5 ++++-
 read-cache.c |  2 +-
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index b13bfaf71e..fc44016fe8 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -3,6 +3,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
+#include "json-writer.h"
 #include "object-store.h"
 #include "replace-object.h"
 
@@ -492,7 +493,8 @@ void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
 	write_one(sb, root, "", 0);
 }
 
-static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
+static struct cache_tree *read_one(const char **buffer, unsigned long *size_p,
+				   struct json_writer *jw)
 {
 	const char *buf = *buffer;
 	unsigned long size = *size_p;
@@ -546,6 +548,15 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 			*buffer, subtree_nr);
 #endif
 
+	if (jw) {
+		if (it->entry_count >= 0) {
+			jw_object_string(jw, "oid", oid_to_hex(&it->oid));
+			jw_object_intmax(jw, "entry_count", it->entry_count);
+		} else {
+			jw_object_null(jw, "oid");
+		}
+		jw_object_inline_begin_array(jw, "subdirs");
+	}
 	/*
 	 * Just a heuristic -- we do not add directories that often but
 	 * we do not want to have to extend it immediately when we do,
@@ -559,12 +570,18 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 		struct cache_tree_sub *subtree;
 		const char *name = buf;
 
-		sub = read_one(&buf, &size);
+		if (jw) {
+			jw_array_inline_begin_object(jw);
+			jw_object_string(jw, "name", name);
+		}
+		sub = read_one(&buf, &size, jw);
+		jw_end_gently(jw);
 		if (!sub)
 			goto free_return;
 		subtree = cache_tree_sub(it, name);
 		subtree->cache_tree = sub;
 	}
+	jw_end_gently(jw);
 	if (subtree_nr != it->subtree_nr)
 		die("cache-tree: internal error");
 	*buffer = buf;
@@ -576,11 +593,25 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	return NULL;
 }
 
-struct cache_tree *cache_tree_read(const char *buffer, unsigned long size)
+struct cache_tree *cache_tree_read(const char *buffer, unsigned long size,
+				   struct json_writer *jw)
 {
+	struct cache_tree *ret;
+
+	if (jw) {
+		jw_object_inline_begin_object(jw, "cache-tree");
+		jw_object_intmax(jw, "ext-size", size);
+		jw_object_inline_begin_object(jw, "root");
+	}
 	if (buffer[0])
-		return NULL; /* not the whole tree */
-	return read_one(&buffer, &size);
+		ret = NULL; /* not the whole tree */
+	else
+		ret = read_one(&buffer, &size, jw);
+	if (jw) {
+		jw_end(jw);	/* root */
+		jw_end(jw);	/* cache-tree */
+	}
+	return ret;
 }
 
 static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *path)
diff --git a/cache-tree.h b/cache-tree.h
index 757bbc48bc..fc3c73284b 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -6,6 +6,8 @@
 #include "tree-walk.h"
 
 struct cache_tree;
+struct json_writer;
+
 struct cache_tree_sub {
 	struct cache_tree *cache_tree;
 	int count;		/* internally used by update_one() */
@@ -28,7 +30,8 @@ void cache_tree_invalidate_path(struct index_state *, const char *);
 struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
-struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
+struct cache_tree *cache_tree_read(const char *buffer, unsigned long size,
+				   struct json_writer *jw);
 
 int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct index_state *, int);
diff --git a/read-cache.c b/read-cache.c
index 200834e77e..289705b816 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1698,7 +1698,7 @@ static int read_index_extension(struct index_state *istate,
 {
 	switch (CACHE_EXT(ext)) {
 	case CACHE_EXT_TREE:
-		istate->cache_tree = cache_tree_read(data, sz);
+		istate->cache_tree = cache_tree_read(data, sz, istate->jw);
 		break;
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo = resolve_undo_read(data, sz, istate->jw);
-- 
2.22.0.rc0.322.g2b0371e29a

