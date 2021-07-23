Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE3CC4320A
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFEC60F21
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhGWSL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 14:11:57 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E440C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:52:30 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id f62-20020a17090a28c4b02901733dbfa29cso7292077pjd.0
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pwTqZiBDjXRUztc4/N+QlR6QxaMAryQU3t0uztYEjY8=;
        b=Xp1QlhEz25FovkhLwkzw803bPghHLQAfTUNXOXhut4DccYVw+XrSQMYCDiwGPOqGA9
         qzqF+dvk2gwoHnbdZ0pcyuy507UjRCsNoLIBUujYCAo/dFS7gBqOfRtkKKo8BrpSAJVV
         X3WlxcLUTqr8NKA/QSOhj9ux/afLFZOyeTT1e36nD/5Kt/UQhGVgbSstai8rWuC2dnb3
         8bnbgXvSw7B5/idxpHqZmV2+uxnpJTFbk0waw+rNDA1FMv7KDEcZSSur0VbLUJy8zsNr
         zvxQN8OoNAwEMF9W80FdpRHlf+cd/GJE2YAjcy5a2337oUilM1gXT3YJadtBf78wENRo
         RnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pwTqZiBDjXRUztc4/N+QlR6QxaMAryQU3t0uztYEjY8=;
        b=t2LQmwKGRVzQ8QEyl4A4Zh4joJH0kZ3ukGJ2oztdZKa45cH/vKW/Ly3HTBG4b1iz0Z
         tFIeNrqwoJFMvk0eaRGLM+mvrO6cg6OHn2qSXhWh6wT4zv+8A3zAPnF2aNhCTNd7aVzc
         xPfkqSQQ2bSgK9uRevA/3dQPIbQQtTq7MPrNcTDKMP2mS34F/QSSnoRoXhcyuIP3v5Da
         CmR6ZTMgoUR3gYD/hI8UAyck5OdpIPyFcYYhRiPCyyLRp6reNuDX80VWFZT1jEsIX3B9
         3zhhLvR2NYXWAJPMpAMuyAmhanfqUMZ08fcZNDxkzKU3qKk3tNtgM3NJn1DQiyT1Al/q
         5x1A==
X-Gm-Message-State: AOAM5327jjzGRV2Ulp0jcRsfDD3IitmnHp6cVsBMsoN9M+W6iU8vh2a7
        shXXmUo9dL50pJwJQ5/DpAezAJnutcxyJxeqhKLH/ZBdMU7khVULDXKjDG56RmHGSXy4I51qLCQ
        1XfNAjlcRdxEk6RoBiL8ZlUOBUZsssgUhaBMLqVY11NPXFkbWxmvCNcKPvJztx873kjjlTgeG8j
        Zl
X-Google-Smtp-Source: ABdhPJwJXHqDk1JQoL+mDk392OrRH6oXEqfQ9SoYnK0rM8ztdaGNjIyh8afcN0g8WwCvWNQZdrUhk6H9/VoG9iPLSyoZ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:8b56:0:b029:2b9:77be:d305 with
 SMTP id i22-20020aa78b560000b02902b977bed305mr5949216pfd.61.1627066349805;
 Fri, 23 Jul 2021 11:52:29 -0700 (PDT)
Date:   Fri, 23 Jul 2021 11:52:22 -0700
In-Reply-To: <cover.1627066238.git.jonathantanmy@google.com>
Message-Id: <f502997d159c7a30862fab3c3b443291539b6f29.1627066238.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1627066238.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 1/2] unpack-trees: refactor prefetching code
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the prefetching code in unpack-trees.c into its own function,
because it will be used elsewhere in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h        |  9 +++++++++
 read-cache.c   | 23 +++++++++++++++++++++++
 unpack-trees.c | 27 ++++++++-------------------
 3 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/cache.h b/cache.h
index ba04ff8bd3..6f952e22c6 100644
--- a/cache.h
+++ b/cache.h
@@ -410,6 +410,15 @@ struct cache_entry *dup_cache_entry(const struct cache_entry *ce, struct index_s
  */
 void validate_cache_entries(const struct index_state *istate);
 
+/*
+ * Bulk prefetch all missing cache entries that are not GITLINKs and that match
+ * the given predicate. This function should only be called if
+ * has_promisor_remote() returns true.
+ */
+typedef int (*must_prefetch_predicate)(const struct cache_entry *);
+void prefetch_cache_entries(const struct index_state *istate,
+			    must_prefetch_predicate must_prefetch);
+
 #ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
 extern struct index_state the_index;
 
diff --git a/read-cache.c b/read-cache.c
index ba2b012a6c..4e396bf17f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -27,6 +27,7 @@
 #include "progress.h"
 #include "sparse-index.h"
 #include "csum-file.h"
+#include "promisor-remote.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -3657,3 +3658,25 @@ static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_ta
 		strbuf_add(sb, &buffer, sizeof(uint32_t));
 	}
 }
+
+void prefetch_cache_entries(const struct index_state *istate,
+			    must_prefetch_predicate must_prefetch)
+{
+	int i;
+	struct oid_array to_fetch = OID_ARRAY_INIT;
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+
+		if (S_ISGITLINK(ce->ce_mode) || !must_prefetch(ce))
+			continue;
+		if (!oid_object_info_extended(the_repository, &ce->oid,
+					      NULL,
+					      OBJECT_INFO_FOR_PREFETCH))
+			continue;
+		oid_array_append(&to_fetch, &ce->oid);
+	}
+	promisor_remote_get_direct(the_repository,
+				   to_fetch.oid, to_fetch.nr);
+	oid_array_clear(&to_fetch);
+}
diff --git a/unpack-trees.c b/unpack-trees.c
index f88a69f8e7..ed92794032 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -392,6 +392,11 @@ static void report_collided_checkout(struct index_state *index)
 	string_list_clear(&list, 0);
 }
 
+static int must_checkout(const struct cache_entry *ce)
+{
+	return ce->ce_flags & CE_UPDATE;
+}
+
 static int check_updates(struct unpack_trees_options *o,
 			 struct index_state *index)
 {
@@ -442,28 +447,12 @@ static int check_updates(struct unpack_trees_options *o,
 	if (should_update_submodules())
 		load_gitmodules_file(index, &state);
 
-	if (has_promisor_remote()) {
+	if (has_promisor_remote())
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
 		 */
-		struct oid_array to_fetch = OID_ARRAY_INIT;
-		for (i = 0; i < index->cache_nr; i++) {
-			struct cache_entry *ce = index->cache[i];
-
-			if (!(ce->ce_flags & CE_UPDATE) ||
-			    S_ISGITLINK(ce->ce_mode))
-				continue;
-			if (!oid_object_info_extended(the_repository, &ce->oid,
-						      NULL,
-						      OBJECT_INFO_FOR_PREFETCH))
-				continue;
-			oid_array_append(&to_fetch, &ce->oid);
-		}
-		promisor_remote_get_direct(the_repository,
-					   to_fetch.oid, to_fetch.nr);
-		oid_array_clear(&to_fetch);
-	}
+		prefetch_cache_entries(index, must_checkout);
 
 	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
 
@@ -473,7 +462,7 @@ static int check_updates(struct unpack_trees_options *o,
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
-		if (ce->ce_flags & CE_UPDATE) {
+		if (must_checkout(ce)) {
 			size_t last_pc_queue_size = pc_queue_size();
 
 			if (ce->ce_flags & CE_WT_REMOVE)
-- 
2.32.0.432.gabb21c7263-goog

