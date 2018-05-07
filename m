Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2A93200B9
	for <e@80x24.org>; Mon,  7 May 2018 22:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeEGW7v (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:51 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41202 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbeEGW7q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:46 -0400
Received: by mail-pl0-f67.google.com with SMTP id az12-v6so1008098plb.8
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UYgX+K2QoyhpR6gRwbWbaPEhriFcZ8dLlNd75FRGnMo=;
        b=FSbRpSfva0bsJdfNLV/7D4MY3cF4aCQ05nm7K/D2VcqrRHvnUMHr7VgctbaVtdbzWJ
         geLUnpIaLbr4GNaUTa1krsLoBmhBwOuFX+tjNEBKA+fQRX3PkhnvnebGqyc8BQr4MTIo
         qASdXnW8s8aZc5n+GhmJQrajhdvPmGDer/K74tX6IalP91fxwQSKJhOOKJV37LzkWv44
         H/SVjdEeeoKeRUdlDe0dabrSHAc8oSTiJH49ZzB8wgnPF1DE8swiFAkgDBBZlvDhLz+U
         sO8Q9KxDF6jHRYZRG79w563P6jra657ElSfNKzZopVtq/pNo5Rtyd4jWw4hLJNrsDS52
         8xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UYgX+K2QoyhpR6gRwbWbaPEhriFcZ8dLlNd75FRGnMo=;
        b=ESrPFCguwpUekdBRk71b4Kx1IeoAlA9NiTQW29MlES0KM2PfJmc1smrYIYZ3Ny6CvU
         rD4qG7qhnRbYG0HBoPl+1YGZkI44Hcpg+5pZtafaoOCMkcHwleO0zINu41jiV8g+kE9b
         kdPB1HiTuFuMfTAX+jalnP7y095nY7priOFvWH2JAG1Gn5ViWapm7bUqYx2oAGe0rffC
         SXMkGLxEB5fT0wVxDqau1UYVFxOMF7gTrlBgTSvF62AZ03zHRbMfin1yHzooZ8f/cLmr
         GpO3/t5e1f+WYZN/wYwtknW5MA283Qpfuzf2+6VTF8QioHh+WtS21o/E+33iw/cDQvzh
         Dx4w==
X-Gm-Message-State: ALQs6tCaiIlcSdqmoEIi9qL7NyaOa0S0KNJHwfSfB6P0mM1SPMUkuGhF
        41xu6fy8OFSp8AHLgGFqz1icyYC5frc=
X-Google-Smtp-Source: AB8JxZo+BYdbeHHATtbPF7VMm79vusC9MZ2Hb59pr47pf3rnuFzcR2eg6ocO6Fo4s97CB2EYW6kv6w==
X-Received: by 2002:a17:902:4483:: with SMTP id l3-v6mr39331482pld.282.1525733984942;
        Mon, 07 May 2018 15:59:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id o5-v6sm16503993pgv.47.2018.05.07.15.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 13/13] alloc: allow arbitrary repositories for alloc functions
Date:   Mon,  7 May 2018 15:59:16 -0700
Message-Id: <20180507225916.155236-14-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180507225916.155236-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
 <20180507225916.155236-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have to convert all of the alloc functions at once, because alloc_report
uses a funky macro for reporting. It is better for the sake of mechanical
conversion to convert multiple functions at once rather than changing the
structure of the reporting function.

We record all memory allocation in alloc.c, and free them in
clear_alloc_state, which is called for all repositories except
the_repository.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c           | 63 +++++++++++++++++++++++++++++------------------
 alloc.h           | 15 +++++++++++
 blame.c           |  1 +
 blob.c            |  1 +
 cache.h           | 16 ------------
 commit.c          |  1 +
 merge-recursive.c |  1 +
 object.c          | 34 +++++++++++++++++++++++--
 object.h          |  8 ++++++
 tag.c             |  1 +
 tree.c            |  1 +
 11 files changed, 100 insertions(+), 42 deletions(-)
 create mode 100644 alloc.h

diff --git a/alloc.c b/alloc.c
index 277dadd221b..cbdbbc1dd2d 100644
--- a/alloc.c
+++ b/alloc.c
@@ -4,8 +4,7 @@
  * Copyright (C) 2006 Linus Torvalds
  *
  * The standard malloc/free wastes too much space for objects, partly because
- * it maintains all the allocation infrastructure (which isn't needed, since
- * we never free an object descriptor anyway), but even more because it ends
+ * it maintains all the allocation infrastructure, but even more because it ends
  * up with maximal alignment because it doesn't know what the object alignment
  * for the new allocation is.
  */
@@ -15,6 +14,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "alloc.h"
 
 #define BLOCKING 1024
 
@@ -30,8 +30,25 @@ struct alloc_state {
 	int count; /* total number of nodes allocated */
 	int nr;    /* number of nodes left in current allocation */
 	void *p;   /* first free node in current allocation */
+
+	/* bookkeeping of allocations */
+	void **slabs;
+	int slab_nr, slab_alloc;
 };
 
+void *allocate_alloc_state(void)
+{
+	return xcalloc(1, sizeof(struct alloc_state));
+}
+
+void clear_alloc_state(struct alloc_state *s)
+{
+	while (s->slab_nr > 0) {
+		s->slab_nr--;
+		free(s->slabs[s->slab_nr]);
+	}
+}
+
 static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 {
 	void *ret;
@@ -39,60 +56,57 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 	if (!s->nr) {
 		s->nr = BLOCKING;
 		s->p = xmalloc(BLOCKING * node_size);
+
+		ALLOC_GROW(s->slabs, s->slab_nr + 1, s->slab_alloc);
+		s->slabs[s->slab_nr++] = s->p;
 	}
 	s->nr--;
 	s->count++;
 	ret = s->p;
 	s->p = (char *)s->p + node_size;
 	memset(ret, 0, node_size);
+
 	return ret;
 }
 
-static struct alloc_state blob_state;
-void *alloc_blob_node_the_repository(void)
+void *alloc_blob_node(struct repository *r)
 {
-	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
+	struct blob *b = alloc_node(r->parsed_objects->blob_state, sizeof(struct blob));
 	b->object.type = OBJ_BLOB;
 	return b;
 }
 
-static struct alloc_state tree_state;
-void *alloc_tree_node_the_repository(void)
+void *alloc_tree_node(struct repository *r)
 {
-	struct tree *t = alloc_node(&tree_state, sizeof(struct tree));
+	struct tree *t = alloc_node(r->parsed_objects->tree_state, sizeof(struct tree));
 	t->object.type = OBJ_TREE;
 	return t;
 }
 
-static struct alloc_state tag_state;
-void *alloc_tag_node_the_repository(void)
+void *alloc_tag_node(struct repository *r)
 {
-	struct tag *t = alloc_node(&tag_state, sizeof(struct tag));
+	struct tag *t = alloc_node(r->parsed_objects->tag_state, sizeof(struct tag));
 	t->object.type = OBJ_TAG;
 	return t;
 }
 
-static struct alloc_state object_state;
-void *alloc_object_node_the_repository(void)
+void *alloc_object_node(struct repository *r)
 {
-	struct object *obj = alloc_node(&object_state, sizeof(union any_object));
+	struct object *obj = alloc_node(r->parsed_objects->object_state, sizeof(union any_object));
 	obj->type = OBJ_NONE;
 	return obj;
 }
 
-static struct alloc_state commit_state;
-
-unsigned int alloc_commit_index_the_repository(void)
+unsigned int alloc_commit_index(struct repository *r)
 {
-	static unsigned int count;
-	return count++;
+	return r->parsed_objects->commit_count++;
 }
 
-void *alloc_commit_node_the_repository(void)
+void *alloc_commit_node(struct repository *r)
 {
-	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
+	struct commit *c = alloc_node(r->parsed_objects->commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
-	c->index = alloc_commit_index(the_repository);
+	c->index = alloc_commit_index(r);
 	return c;
 }
 
@@ -103,9 +117,10 @@ static void report(const char *name, unsigned int count, size_t size)
 }
 
 #define REPORT(name, type)	\
-    report(#name, name##_state.count, name##_state.count * sizeof(type) >> 10)
+    report(#name, r->parsed_objects->name##_state->count, \
+		  r->parsed_objects->name##_state->count * sizeof(type) >> 10)
 
-void alloc_report_the_repository(void)
+void alloc_report(struct repository *r)
 {
 	REPORT(blob, struct blob);
 	REPORT(tree, struct tree);
diff --git a/alloc.h b/alloc.h
new file mode 100644
index 00000000000..26dcf96020e
--- /dev/null
+++ b/alloc.h
@@ -0,0 +1,15 @@
+#ifndef ALLOC_H
+#define ALLOC_H
+
+void *alloc_blob_node(struct repository *r);
+void *alloc_tree_node(struct repository *r);
+void *alloc_commit_node(struct repository *r);
+void *alloc_tag_node(struct repository *r);
+void *alloc_object_node(struct repository *r);
+void alloc_report(struct repository *r);
+unsigned int alloc_commit_index(struct repository *r);
+
+void *allocate_alloc_state(void);
+void clear_alloc_state(struct alloc_state *s);
+
+#endif
diff --git a/blame.c b/blame.c
index ba9b18e7542..3a11f1ce52b 100644
--- a/blame.c
+++ b/blame.c
@@ -6,6 +6,7 @@
 #include "diffcore.h"
 #include "tag.h"
 #include "blame.h"
+#include "alloc.h"
 
 void blame_origin_decref(struct blame_origin *o)
 {
diff --git a/blob.c b/blob.c
index 9e64f301895..458dafa811e 100644
--- a/blob.c
+++ b/blob.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "repository.h"
+#include "alloc.h"
 
 const char *blob_type = "blob";
 
diff --git a/cache.h b/cache.h
index 0e6c5dd5639..c75559b7d38 100644
--- a/cache.h
+++ b/cache.h
@@ -1763,22 +1763,6 @@ extern const char *excludes_file;
 int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
 
-/* alloc.c */
-#define alloc_blob_node(r) alloc_blob_node_##r()
-extern void *alloc_blob_node_the_repository(void);
-#define alloc_tree_node(r) alloc_tree_node_##r()
-extern void *alloc_tree_node_the_repository(void);
-#define alloc_commit_node(r) alloc_commit_node_##r()
-extern void *alloc_commit_node_the_repository(void);
-#define alloc_tag_node(r) alloc_tag_node_##r()
-extern void *alloc_tag_node_the_repository(void);
-#define alloc_object_node(r) alloc_object_node_##r()
-extern void *alloc_object_node_the_repository(void);
-#define alloc_report(r) alloc_report_##r()
-extern void alloc_report_the_repository(void);
-#define alloc_commit_index(r) alloc_commit_index_##r()
-extern unsigned int alloc_commit_index_the_repository(void);
-
 /* pkt-line.c */
 void packet_trace_identity(const char *prog);
 
diff --git a/commit.c b/commit.c
index a9a43e79bae..c3b400d5930 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "alloc.h"
 #include "gpg-interface.h"
 #include "mergesort.h"
 #include "commit-slab.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index 6dac8908648..aa086a85089 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -14,6 +14,7 @@
 #include "tree-walk.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "alloc.h"
 #include "tag.h"
 #include "unpack-trees.h"
 #include "string-list.h"
diff --git a/object.c b/object.c
index 49b952e9299..2ea2dc7a1cd 100644
--- a/object.c
+++ b/object.c
@@ -4,6 +4,7 @@
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
+#include "alloc.h"
 #include "tag.h"
 #include "object-store.h"
 #include "packfile.h"
@@ -455,6 +456,13 @@ struct parsed_object_pool *parsed_object_pool_new(void)
 {
 	struct parsed_object_pool *o = xmalloc(sizeof(*o));
 	memset(o, 0, sizeof(*o));
+
+	o->blob_state = allocate_alloc_state();
+	o->tree_state = allocate_alloc_state();
+	o->commit_state = allocate_alloc_state();
+	o->tag_state = allocate_alloc_state();
+	o->object_state = allocate_alloc_state();
+
 	return o;
 }
 
@@ -501,9 +509,31 @@ void raw_object_store_clear(struct raw_object_store *o)
 void parsed_object_pool_clear(struct parsed_object_pool *o)
 {
 	/*
-	 * TOOD free objects in o->obj_hash.
-	 *
 	 * As objects are allocated in slabs (see alloc.c), we do
 	 * not need to free each object, but each slab instead.
+	 *
+	 * Before doing so, we need to free any additional memory
+	 * the objects may hold.
 	 */
+	unsigned i;
+
+	for (i = 0; i < o->obj_hash_size; i++) {
+		struct object *obj = o->obj_hash[i];
+
+		if (!obj)
+			continue;
+
+		if (obj->type == OBJ_TREE) {
+			free(((struct tree*)obj)->buffer);
+		} else if (obj->type == OBJ_COMMIT) {
+			free_commit_list(((struct commit*)obj)->parents);
+			free(&((struct commit*)obj)->util);
+		}
+	}
+
+	clear_alloc_state(o->blob_state);
+	clear_alloc_state(o->tree_state);
+	clear_alloc_state(o->commit_state);
+	clear_alloc_state(o->tag_state);
+	clear_alloc_state(o->object_state);
 }
diff --git a/object.h b/object.h
index b41d7a3accb..7916edb4edf 100644
--- a/object.h
+++ b/object.h
@@ -4,6 +4,14 @@
 struct parsed_object_pool {
 	struct object **obj_hash;
 	int nr_objs, obj_hash_size;
+
+	/* TODO: migrate alloc_states to mem-pool? */
+	struct alloc_state *blob_state;
+	struct alloc_state *tree_state;
+	struct alloc_state *commit_state;
+	struct alloc_state *tag_state;
+	struct alloc_state *object_state;
+	unsigned commit_count;
 };
 
 struct parsed_object_pool *parsed_object_pool_new(void);
diff --git a/tag.c b/tag.c
index 02ef4eaafc0..af6a0725b6a 100644
--- a/tag.c
+++ b/tag.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
+#include "alloc.h"
 #include "gpg-interface.h"
 
 const char *tag_type = "tag";
diff --git a/tree.c b/tree.c
index 58cf19b4fa8..8f8ef3189af 100644
--- a/tree.c
+++ b/tree.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 #include "commit.h"
 #include "tag.h"
+#include "alloc.h"
 #include "tree-walk.h"
 
 const char *tree_type = "tree";
-- 
2.17.0.255.g8bfb7c0704

