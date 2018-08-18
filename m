Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4576C1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 14:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeHRRto (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 13:49:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39124 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeHRRto (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 13:49:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id a134-v6so7870058lfe.6
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bwMKmUx+YzVbN9edh92XNNICmE/DgrpRA0A7yH6igFY=;
        b=dW3d/FdAiCiJwsb3PPbQ8HZEn9S2vDpWy4TIMb57dGxTu5DUyu6Yj9PGqkPiL5JpMz
         srJozxKxr7Uu8V3IaATfKwcBsToAkNlMPMUwBwPjSr8p1A6tQfIXgrkopyPqfeqdzRPB
         pqceGTT00I9xMrKiNIkcQnBEktR05J1zW+MqJlqsSAb+zleef+k9gVz22md30tUEijIZ
         eSIvuhnNe0bm7cfEqhWLqCbKnvb0UGkqru4BUmohscN+1NSHXJZ2AKaB1LICwHncMvoL
         vZOkvOcj0kpAOobTZHGfdBagPE3E96FYQmZIznqVb6joTMmcYUBZGjrj+U05RT4TS3s4
         gdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwMKmUx+YzVbN9edh92XNNICmE/DgrpRA0A7yH6igFY=;
        b=crOYCrazEZBR3Mnq/Ww3tAM5o4d0mvNQCkAPv6egfqpQv5JL0Girf85AhyBs46FDJn
         ougdfxtqejg9Zj/gMlXj0l1SneIH+XG8z3uptglUm82c+t2zdsVwiE/KAKAFLXOlM0HS
         fuGdDjW9QjH/TMHx80CTWHjBEdyS1U2PzrIL7a5C0EDmNVDfYhrXXR7SXFNUnyt+NSF7
         Pl4Hrr2IfaK34dU/64Q9mwHUN9RPQd8HzIeazkqx/FEQMkj/T0zFaQO9tQKICnEbSs+d
         cxG+RdBokKGw69tcnawiornKkO2JKnuyIipwUU1IVrnknV/4kPEz/bj/lqZUAGOAuW+a
         z0dQ==
X-Gm-Message-State: AOUpUlHmA3/9LEl7ef/Oe5h8faveVcEdo5Ha2B7KsjJrSHpliCH1jRJI
        z8Pru+7/60JEDrgvQV9KyvI=
X-Google-Smtp-Source: AA+uWPz9eYkrVgxzFjz5UDs9XxlYNI7YyHpWvNQOSF2ZR6arFGaI++1DC/NqqITq+86M+Au2Y/vhGA==
X-Received: by 2002:a19:ef13:: with SMTP id n19-v6mr9919440lfh.48.1534603306112;
        Sat, 18 Aug 2018 07:41:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b76-v6sm884451lff.53.2018.08.18.07.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 07:41:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, peartben@gmail.com, peff@peff.net
Subject: [PATCH v5 7/7] cache-tree: verify valid cache-tree in the test suite
Date:   Sat, 18 Aug 2018 16:41:28 +0200
Message-Id: <20180818144128.19361-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180818144128.19361-1-pclouds@gmail.com>
References: <20180812081551.27927-1-pclouds@gmail.com>
 <20180818144128.19361-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes sure that cache-tree is consistent with the index. The main
purpose is to catch potential problems by saving the index in
unpack_trees() but the line in write_index() would also help spot
missing invalidation in other code.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache-tree.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 cache-tree.h   |  1 +
 read-cache.c   |  3 ++
 t/test-lib.sh  |  6 ++++
 unpack-trees.c |  2 ++
 5 files changed, 90 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index caafbff2ff..c3c206427c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -4,6 +4,7 @@
 #include "tree-walk.h"
 #include "cache-tree.h"
 #include "object-store.h"
+#include "replace-object.h"
 
 #ifndef DEBUG
 #define DEBUG 0
@@ -732,3 +733,80 @@ int update_main_cache_tree(int flags)
 		the_index.cache_tree = cache_tree();
 	return cache_tree_update(&the_index, flags);
 }
+
+static void verify_one(struct index_state *istate,
+		       struct cache_tree *it,
+		       struct strbuf *path)
+{
+	int i, pos, len = path->len;
+	struct strbuf tree_buf = STRBUF_INIT;
+	struct object_id new_oid;
+
+	for (i = 0; i < it->subtree_nr; i++) {
+		strbuf_addf(path, "%s/", it->down[i]->name);
+		verify_one(istate, it->down[i]->cache_tree, path);
+		strbuf_setlen(path, len);
+	}
+
+	if (it->entry_count < 0 ||
+	    /* no verification on tests (t7003) that replace trees */
+	    lookup_replace_object(the_repository, &it->oid) != &it->oid)
+		return;
+
+	if (path->len) {
+		pos = index_name_pos(istate, path->buf, path->len);
+		pos = -pos - 1;
+	} else {
+		pos = 0;
+	}
+
+	i = 0;
+	while (i < it->entry_count) {
+		struct cache_entry *ce = istate->cache[pos + i];
+		const char *slash;
+		struct cache_tree_sub *sub = NULL;
+		const struct object_id *oid;
+		const char *name;
+		unsigned mode;
+		int entlen;
+
+		if (ce->ce_flags & (CE_STAGEMASK | CE_INTENT_TO_ADD | CE_REMOVE))
+			BUG("%s with flags 0x%x should not be in cache-tree",
+			    ce->name, ce->ce_flags);
+		name = ce->name + path->len;
+		slash = strchr(name, '/');
+		if (slash) {
+			entlen = slash - name;
+			sub = find_subtree(it, ce->name + path->len, entlen, 0);
+			if (!sub || sub->cache_tree->entry_count < 0)
+				BUG("bad subtree '%.*s'", entlen, name);
+			oid = &sub->cache_tree->oid;
+			mode = S_IFDIR;
+			i += sub->cache_tree->entry_count;
+		} else {
+			oid = &ce->oid;
+			mode = ce->ce_mode;
+			entlen = ce_namelen(ce) - path->len;
+			i++;
+		}
+		strbuf_addf(&tree_buf, "%o %.*s%c", mode, entlen, name, '\0');
+		strbuf_add(&tree_buf, oid->hash, the_hash_algo->rawsz);
+	}
+	hash_object_file(tree_buf.buf, tree_buf.len, tree_type, &new_oid);
+	if (oidcmp(&new_oid, &it->oid))
+		BUG("cache-tree for path %.*s does not match. "
+		    "Expected %s got %s", len, path->buf,
+		    oid_to_hex(&new_oid), oid_to_hex(&it->oid));
+	strbuf_setlen(path, len);
+	strbuf_release(&tree_buf);
+}
+
+void cache_tree_verify(struct index_state *istate)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	if (!istate->cache_tree)
+		return;
+	verify_one(istate, istate->cache_tree, &path);
+	strbuf_release(&path);
+}
diff --git a/cache-tree.h b/cache-tree.h
index 9799e894f7..c1fde531f9 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -32,6 +32,7 @@ struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
 int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct index_state *, int);
+void cache_tree_verify(struct index_state *);
 
 int update_main_cache_tree(int);
 
diff --git a/read-cache.c b/read-cache.c
index 5ce40f39b3..41f313bc9e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2744,6 +2744,9 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	int new_shared_index, ret;
 	struct split_index *si = istate->split_index;
 
+	if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
+		cache_tree_verify(istate);
+
 	if ((flags & SKIP_IF_UNCHANGED) && !istate->cache_changed) {
 		if (flags & COMMIT_LOCK)
 			rollback_lock_file(lock);
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 78f7097746..5b50f6e2e6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1083,6 +1083,12 @@ else
 	test_set_prereq C_LOCALE_OUTPUT
 fi
 
+if test -z "$GIT_TEST_CHECK_CACHE_TREE"
+then
+	GIT_TEST_CHECK_CACHE_TREE=true
+	export GIT_TEST_CHECK_CACHE_TREE
+fi
+
 test_lazy_prereq PIPE '
 	# test whether the filesystem supports FIFOs
 	test_have_prereq !MINGW,!CYGWIN &&
diff --git a/unpack-trees.c b/unpack-trees.c
index bc43922922..3394540842 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1578,6 +1578,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->dst_index) {
 		move_index_extensions(&o->result, o->src_index);
 		if (!ret) {
+			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
+				cache_tree_verify(&o->result);
 			if (!o->result.cache_tree)
 				o->result.cache_tree = cache_tree();
 			if (!cache_tree_fully_valid(o->result.cache_tree))
-- 
2.18.0.1004.g6639190530

