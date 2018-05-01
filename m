Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DADB31FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeEAVea (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46742 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbeEAVe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id p12so9957145pff.13
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4vyEI5v/cJmUW0umpZL6Se4pZos+fT6OQDh7M17cCMM=;
        b=fQjT4XfktbrewQ6xwvsKebdbLLD/WnBm6Rhlc4OZHzz/yPhfQGT4FpgbIMtdxxwRUi
         jwGkBlMKnPr2KdhnHpVQ+l+PWc1DFhhypuanmpWd24nQRFgC58b+983MaTnYRWDCMpd3
         D4RFwJfLFFiVSSurBJ0cRBz9tflT2KsMAOPfE7O6ZP6PbjqcNueOvu+y89ew7//jHL/l
         2jrbOVtgXBerg6YkmLdSk/9nm7UxKl26kuQOCWmU4Ca3ndb2VPubS/tMDF3pDrCi+KlU
         8AGNfchMa5RZOpKT5MtQFXPAs0fYx4Ce6CqUU+CapicCOy2t+0+9HL9hCEdi7HfAlB2l
         mPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4vyEI5v/cJmUW0umpZL6Se4pZos+fT6OQDh7M17cCMM=;
        b=CkUeBxL9xpFuY6Z8tfcPvaXY5bKJdKDNSuDsPFJb2PMyOjjHho95tszef4EmzJAxap
         PDXlBE88Pc54fYQ5duj+fKs3NzeK/55j3dJOoaKxatR4gg9PPJ3fvSd+bXmcZ1QOtR+B
         aHfYPUDfZi7pqZnJqh3gel3XX0JjX8fA3NdOTsjw395rhADCEMhC6Ss5Z9J4XumU+EKj
         u5pZRyhra5pY2q0A7DDdyebdVCEjxjK89MGLWmwyggJdPqJxVmugUfSMiG6iweTNO4YB
         wtsG1wmGPalnc7HM9YM0WW/FVYhBx+KCLDowYfWl9hY5IaF33Fr4rvcUv7i3n3f1DtDW
         ICVQ==
X-Gm-Message-State: ALQs6tA4AXdZ51DoZ/drjzn/8vBe9cH6Xrfkj9fPEPPMtLZzBbzfhtk0
        dyKYcWMmFYl30xxeJaB+uSPTCLN05Xo=
X-Google-Smtp-Source: AB8JxZpLhqM6DWsd56CEpMpFplTKgQgsFJqCMHMPg7NvFpQ/YCIpL5l1pTqA8Pi3gsrXAeXOwWlTdg==
X-Received: by 2002:a17:902:7d09:: with SMTP id z9-v6mr17909318pll.4.1525210466299;
        Tue, 01 May 2018 14:34:26 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k83sm28297904pfg.153.2018.05.01.14.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/13] alloc: allow arbitrary repositories for alloc functions
Date:   Tue,  1 May 2018 14:34:03 -0700
Message-Id: <20180501213403.14643-14-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
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
 alloc.c           | 69 ++++++++++++++++++++++++++++++-----------------
 alloc.h           | 21 +++++++++++++++
 blame.c           |  1 +
 blob.c            |  1 +
 cache.h           | 16 -----------
 commit.c          |  1 +
 merge-recursive.c |  1 +
 object.c          | 24 ++++++++++++++---
 object.h          | 10 ++++++-
 repository.c      |  4 +--
 tag.c             |  1 +
 tree.c            |  1 +
 12 files changed, 104 insertions(+), 46 deletions(-)
 create mode 100644 alloc.h

diff --git a/alloc.c b/alloc.c
index 277dadd221b..66a3d07ba2d 100644
--- a/alloc.c
+++ b/alloc.c
@@ -4,10 +4,11 @@
  * Copyright (C) 2006 Linus Torvalds
  *
  * The standard malloc/free wastes too much space for objects, partly because
- * it maintains all the allocation infrastructure (which isn't needed, since
- * we never free an object descriptor anyway), but even more because it ends
+ * it maintains all the allocation infrastructure, but even more because it ends
  * up with maximal alignment because it doesn't know what the object alignment
  * for the new allocation is.
+ *
+ * TODO: Combine this with mem-pool?
  */
 #include "cache.h"
 #include "object.h"
@@ -30,8 +31,25 @@ struct alloc_state {
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
@@ -45,54 +63,56 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 	ret = s->p;
 	s->p = (char *)s->p + node_size;
 	memset(ret, 0, node_size);
+
+	ALLOC_GROW(s->slabs, s->slab_nr + 1, s->slab_alloc);
+	s->slabs[s->slab_nr++] = ret;
+
 	return ret;
 }
 
-static struct alloc_state blob_state;
-void *alloc_blob_node_the_repository(void)
+struct alloc_state the_repository_blob_state;
+void *alloc_blob_node(struct repository *r)
 {
-	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
+	struct blob *b = alloc_node(r->parsed_objects->blob_state, sizeof(struct blob));
 	b->object.type = OBJ_BLOB;
 	return b;
 }
 
-static struct alloc_state tree_state;
-void *alloc_tree_node_the_repository(void)
+struct alloc_state the_repository_tree_state;
+void *alloc_tree_node(struct repository *r)
 {
-	struct tree *t = alloc_node(&tree_state, sizeof(struct tree));
+	struct tree *t = alloc_node(r->parsed_objects->tree_state, sizeof(struct tree));
 	t->object.type = OBJ_TREE;
 	return t;
 }
 
-static struct alloc_state tag_state;
-void *alloc_tag_node_the_repository(void)
+struct alloc_state the_repository_tag_state;
+void *alloc_tag_node(struct repository *r)
 {
-	struct tag *t = alloc_node(&tag_state, sizeof(struct tag));
+	struct tag *t = alloc_node(r->parsed_objects->tag_state, sizeof(struct tag));
 	t->object.type = OBJ_TAG;
 	return t;
 }
 
-static struct alloc_state object_state;
-void *alloc_object_node_the_repository(void)
+struct alloc_state the_repository_object_state;
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
+struct alloc_state the_repository_commit_state;
+void *alloc_commit_node(struct repository *r)
 {
-	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
+	struct commit *c = alloc_node(r->parsed_objects->commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
-	c->index = alloc_commit_index(the_repository);
+	c->index = alloc_commit_index(r);
 	return c;
 }
 
@@ -103,9 +123,10 @@ static void report(const char *name, unsigned int count, size_t size)
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
index 00000000000..a62d7a06307
--- /dev/null
+++ b/alloc.h
@@ -0,0 +1,21 @@
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
+extern struct alloc_state the_repository_blob_state;
+extern struct alloc_state the_repository_tree_state;
+extern struct alloc_state the_repository_commit_state;
+extern struct alloc_state the_repository_tag_state;
+extern struct alloc_state the_repository_object_state;
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
index fd27cf54faa..003ec55a291 100644
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
@@ -451,10 +452,24 @@ void clear_commit_marks_all(unsigned int flags)
 	}
 }
 
-struct object_parser *object_parser_new(void)
+struct object_parser *object_parser_new(int is_the_repo)
 {
 	struct object_parser *o = xmalloc(sizeof(*o));
 	memset(o, 0, sizeof(*o));
+
+	if (is_the_repo) {
+		o->blob_state = &the_repository_blob_state;
+		o->tree_state = &the_repository_tree_state;
+		o->commit_state = &the_repository_commit_state;
+		o->tag_state = &the_repository_tag_state;
+		o->object_state = &the_repository_object_state;
+	} else {
+		o->blob_state = allocate_alloc_state();
+		o->tree_state = allocate_alloc_state();
+		o->commit_state = allocate_alloc_state();
+		o->tag_state = allocate_alloc_state();
+		o->object_state = allocate_alloc_state();
+	}
 	return o;
 }
 
@@ -501,9 +516,12 @@ void raw_object_store_clear(struct raw_object_store *o)
 void object_parser_clear(struct object_parser *o)
 {
 	/*
-	 * TOOD free objects in o->obj_hash.
-	 *
 	 * As objects are allocated in slabs (see alloc.c), we do
 	 * not need to free each object, but each slab instead.
 	 */
+	clear_alloc_state(o->blob_state);
+	clear_alloc_state(o->tree_state);
+	clear_alloc_state(o->commit_state);
+	clear_alloc_state(o->tag_state);
+	clear_alloc_state(o->object_state);
 }
diff --git a/object.h b/object.h
index 5ef6ce1ea96..cf97dc0d472 100644
--- a/object.h
+++ b/object.h
@@ -4,9 +4,17 @@
 struct object_parser {
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
 
-struct object_parser *object_parser_new(void);
+struct object_parser *object_parser_new(int is_the_repo);
 void object_parser_clear(struct object_parser *o);
 
 struct object_list {
diff --git a/repository.c b/repository.c
index 208ee10071c..51eb876617d 100644
--- a/repository.c
+++ b/repository.c
@@ -15,7 +15,7 @@ void initialize_the_repository(void)
 
 	the_repo.index = &the_index;
 	the_repo.objects = raw_object_store_new();
-	the_repo.parsed_objects = object_parser_new();
+	the_repo.parsed_objects = object_parser_new(1);
 
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
 }
@@ -146,7 +146,7 @@ static int repo_init(struct repository *repo,
 	memset(repo, 0, sizeof(*repo));
 
 	repo->objects = raw_object_store_new();
-	repo->parsed_objects = object_parser_new();
+	repo->parsed_objects = object_parser_new(0);
 
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
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
2.17.0.441.gb46fe60e1d-goog

