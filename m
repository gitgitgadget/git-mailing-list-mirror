Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DBF51F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeHMS6Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40662 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMS6P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id y200-v6so11652226lfd.7
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tTrlFtRJwzlF9BscRUltAGzWcm45K6ur2vI3LJZSPBI=;
        b=XNMhEGWuGLH1l0AG3pfB2KWe5G3vsz+YXTh53vFjCF2fZbyDodyUJnYcpRAK7XZdgH
         aSrXaSfJHlDZngVgoK+8XGodiL/TNDSqenjahbouVvN4CEFTVjYrxL6VSJWZCoYU9MhB
         39Nm0rs+6f3SW0V3dbQKlPcO7kW5X7NSCa9b48biFflypNpFT9F0E44CyqAYGqWL+ijx
         2Ic6KGnqXovQKxQNfBnwtp0gO/C+NAhSitobR22vW7BbXfLCiWVbYKhEGuf8izDt/yC2
         q5XEkFrq4GV13gbvv3AGCo+u4a/A0nx0xH9NuAMxm5ArMuWAGXzxxPFffyjQw5MHbeLd
         deCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTrlFtRJwzlF9BscRUltAGzWcm45K6ur2vI3LJZSPBI=;
        b=K1t9nR6bO3kI/VInOdk2NJJZ/fjJZhtsjbweefaKY6Zb1c7oTL19Ae1/LoI1S6fLf/
         EhtIppgZPPiauCXdcIUbOheB1r/PI2mcjXEZEEeVLIjeBQQOVfb9+VIxv7l+Mp0fCQbQ
         9+24C3J9OQJzUoF4W5zwiqvhfoirX9gCpKbJ6JIPy7L6RgaPhvqMVjBCFXcsPRftL91p
         LRjCDUb7fY8vFQl2DoELHLd8ys9uuI6o+iSFPFmhxIPap97Nu6z4kf4ZkaS6nHNuCCZC
         O53OouyZtqOmoK/pLk4iUorUBMipYiawy7K/A4bjoMzhJuAraEe9KcxBWCnvPL4myldU
         MHKw==
X-Gm-Message-State: AOUpUlFxvxJAoSfPJwu9LX/hqK/nJsjL7OwAvDKIYnKgJFXeLJaY9S88
        Wxz4sauFihFJ0uMI0jHLMenm098Q
X-Google-Smtp-Source: AA+uWPx33bSOwJzYuYVAn/cF0JCJpilQhO7YXfwZp2DZSBf853F9rGWs9x14QOEQarkkhOTEA2+OQg==
X-Received: by 2002:a19:aac8:: with SMTP id t191-v6mr11981381lfe.68.1534176920750;
        Mon, 13 Aug 2018 09:15:20 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:20 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/24] cache-tree: wrap the_index based wrappers with #ifdef
Date:   Mon, 13 Aug 2018 18:14:19 +0200
Message-Id: <20180813161441.16824-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This puts update_main_cache_tree() and write_cache_as_tree() in the
same group of "index compat" functions that assume the_index
implicitly, which should only be used within builtin/ or t/helper.

sequencer.c is also updated to not use these functions. As of now, no
files outside builtin/ use these functions anymore.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache-tree.c | 12 ------------
 cache-tree.h | 17 ++++++++++++++---
 sequencer.c  |  4 ++--
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 181d5919f0..16ea022c46 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -652,11 +652,6 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 	return ret;
 }
 
-int write_cache_as_tree(struct object_id *oid, int flags, const char *prefix)
-{
-	return write_index_as_tree(oid, &the_index, get_index_file(), flags, prefix);
-}
-
 static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 {
 	struct tree_desc desc;
@@ -723,10 +718,3 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 		return it->entry_count;
 	return 0;
 }
-
-int update_main_cache_tree(int flags)
-{
-	if (!the_index.cache_tree)
-		the_index.cache_tree = cache_tree();
-	return cache_tree_update(&the_index, flags);
-}
diff --git a/cache-tree.h b/cache-tree.h
index 9799e894f7..fc0c842e77 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -33,8 +33,6 @@ struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct index_state *, int);
 
-int update_main_cache_tree(int);
-
 /* bitmasks to write_cache_as_tree flags */
 #define WRITE_TREE_MISSING_OK 1
 #define WRITE_TREE_IGNORE_CACHE_TREE 2
@@ -48,9 +46,22 @@ int update_main_cache_tree(int);
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix);
-int write_cache_as_tree(struct object_id *oid, int flags, const char *prefix);
 void prime_cache_tree(struct index_state *, struct tree *);
 
 int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, struct traverse_info *info);
 
+#ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
+static inline int write_cache_as_tree(struct object_id *oid, int flags, const char *prefix)
+{
+	return write_index_as_tree(oid, &the_index, get_index_file(), flags, prefix);
+}
+
+static inline int update_main_cache_tree(int flags)
+{
+	if (!the_index.cache_tree)
+		the_index.cache_tree = cache_tree();
+	return cache_tree_update(&the_index, flags);
+}
+#endif
+
 #endif
diff --git a/sequencer.c b/sequencer.c
index 31038472fd..4d40f50c1c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1244,7 +1244,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 		commit_list_insert(current_head, &parents);
 	}
 
-	if (write_cache_as_tree(&tree, 0, NULL)) {
+	if (write_index_as_tree(&tree, &the_index, get_index_file(), 0, NULL)) {
 		res = error(_("git write-tree failed to write a tree"));
 		goto out;
 	}
@@ -1630,7 +1630,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		 * that represents the "current" state for merge-recursive
 		 * to work on.
 		 */
-		if (write_cache_as_tree(&head, 0, NULL))
+		if (write_index_as_tree(&head, &the_index, get_index_file(), 0, NULL))
 			return error(_("your index file is unmerged."));
 	} else {
 		unborn = get_oid("HEAD", &head);
-- 
2.18.0.1004.g6639190530

