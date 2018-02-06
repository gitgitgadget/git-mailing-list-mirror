Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3EF1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeBFAZt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:25:49 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40334 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbeBFAZo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:25:44 -0500
Received: by mail-pl0-f66.google.com with SMTP id g18so131527plo.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bqQ9OIC3sH50ZdfKleU67UvY24k7yQruAvFybVwuD9I=;
        b=FGBbG1HS6q0e+cwPnHU9CPM2Rg3DhNFUoVQS4W8robDre973dWiCFtlsGCxJHrTzWu
         90MPGb3N7/QC5rPefpzn6WS0JvO1hNx7ZdSng7Y8wRACgDgCMikayWQsZ39hv68RmSl1
         Rhc0kRkbz8IVQixQE7aUD7pqgww+MkXnOTLVgGNMFy5jwHtsXVwkqvyhVYboUhCudJWE
         KR0SbXUDoNWPnyTZfywrPG5bXlJH6bLy6nJ87S1lS2t6vmPqZpKsCL/yp2h3sksmzF1Z
         qBW84O2AOCVhwEC1NB0zm/oNPTgWJuj8ik9RfSjcZNGXCXBABxwrFTNFInf9Py2JgH4m
         //ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bqQ9OIC3sH50ZdfKleU67UvY24k7yQruAvFybVwuD9I=;
        b=Sijz78jN1rqGUXKq2D6Fv9WOv4MZlsRdQvCgnzlZVnarPu+vYpl7E2ToGy1XIHb1wg
         SjjZz3HRdg97y3y/vhOWiKEMoUCEOmtfWPWxHE+sHLvTvKz9i4bamBRp1UvAVaQEwM+p
         yjn2IzqKsmszDbWp693DKgiCUFLYkDAOxbj2ktAP4hyhba5cdKLIaccVn84OZudaYevM
         0wkitL6LVjQNx3woMY5MqcQpNSL4BVYMbnNYRYe/7G4pbXEIgwN8usfue5XgV8MkpYJC
         VC878bsm5/xjZGndVr/4NiUlZz2fXSYH5CBlAtvgu6FjUhIEPUoX5I/FA1wzEAzw+1XT
         pTiQ==
X-Gm-Message-State: APf1xPDugqFjLINj6sUJtgfwfACp8P9Z+FjP0XvK6easKvpTeMl9FHYK
        lB75yKOkOlJr6j2w/lWZdtWz/lYRJXA=
X-Google-Smtp-Source: AH8x22735aIR0eDZ8K1tfxw+XcdBsZZ+hu6fwoc5q141SnS4uwPxjWdnW6C9PfF/zPo6pCcB7oCbcA==
X-Received: by 2002:a17:902:8d81:: with SMTP id v1-v6mr558898plo.430.1517876743224;
        Mon, 05 Feb 2018 16:25:43 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r24sm18781757pfg.51.2018.02.05.16.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:25:42 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 149/194] commit: allow commit buffer functions to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:04 -0800
Message-Id: <20180206001749.218943-51-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/index-pack.c |  2 +-
 commit.c             | 33 ++++++++++++++++++++++-----------
 commit.h             | 17 ++++++++---------
 object.h             |  6 +++++-
 repository.c         |  6 ++++++
 5 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f78e9d2e65..b2b6021ad3 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -870,7 +870,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			}
 			if (obj->type == OBJ_COMMIT) {
 				struct commit *commit = (struct commit *) obj;
-				if (detach_commit_buffer(commit, NULL) != data)
+				if (detach_commit_buffer(the_repository, commit, NULL) != data)
 					die("BUG: parse_object_buffer transmogrified our buffer");
 			}
 			obj->flags |= FLAG_CHECKED;
diff --git a/commit.c b/commit.c
index 8ef8619dec..a5e570f057 100644
--- a/commit.c
+++ b/commit.c
@@ -248,18 +248,29 @@ struct commit_buffer {
 	unsigned long size;
 };
 define_commit_slab(buffer_slab, struct commit_buffer);
-static struct buffer_slab buffer_slab = COMMIT_SLAB_INIT(1, buffer_slab);
+struct buffer_slab the_repository_buffer_slab = COMMIT_SLAB_INIT(1, the_repository_buffer_slab);
 
-void set_commit_buffer_the_repository(struct commit *commit, void *buffer, unsigned long size)
+void alloc_buffer_slab(struct repository *r)
 {
-	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
+	r->parsed_objects.buffer_slab = xcalloc(1, sizeof(struct buffer_slab));
+	init_buffer_slab(r->parsed_objects.buffer_slab);
+}
+
+void free_commit_slab(struct repository *r)
+{
+	free(r->parsed_objects.buffer_slab);
+}
+
+void set_commit_buffer(struct repository *r, struct commit *commit, void *buffer, unsigned long size)
+{
+	struct commit_buffer *v = buffer_slab_at(r->parsed_objects.buffer_slab, commit);
 	v->buffer = buffer;
 	v->size = size;
 }
 
-const void *get_cached_commit_buffer_the_repository(const struct commit *commit, unsigned long *sizep)
+const void *get_cached_commit_buffer(struct repository *r, const struct commit *commit, unsigned long *sizep)
 {
-	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_peek(r->parsed_objects.buffer_slab, commit);
 	if (!v) {
 		if (sizep)
 			*sizep = 0;
@@ -290,25 +301,25 @@ const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-void unuse_commit_buffer_the_repository(const struct commit *commit, const void *buffer)
+void unuse_commit_buffer(struct repository *r, const struct commit *commit, const void *buffer)
 {
-	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_peek(r->parsed_objects.buffer_slab, commit);
 	if (!(v && v->buffer == buffer))
 		free((void *)buffer);
 }
 
-void free_commit_buffer_the_repository(struct commit *commit)
+void free_commit_buffer(struct repository *r, struct commit *commit)
 {
-	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_peek(r->parsed_objects.buffer_slab, commit);
 	if (v) {
 		FREE_AND_NULL(v->buffer);
 		v->size = 0;
 	}
 }
 
-const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
+const void *detach_commit_buffer(struct repository *r, struct commit *commit, unsigned long *sizep)
 {
-	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_peek(r->parsed_objects.buffer_slab, commit);
 	void *ret;
 
 	if (!v) {
diff --git a/commit.h b/commit.h
index 8892989b1d..0d3ccd7279 100644
--- a/commit.h
+++ b/commit.h
@@ -75,19 +75,20 @@ static inline int parse_commit_the_repository(struct commit *item)
 }
 void parse_commit_or_die(struct commit *item);
 
+extern void alloc_buffer_slab(struct repository *r);
+extern void free_commit_slab(struct repository *r);
+
 /*
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
  */
-#define set_commit_buffer(r, c, b, s) set_commit_buffer_##r(c, b, s)
-void set_commit_buffer_the_repository(struct commit *, void *buffer, unsigned long size);
+void set_commit_buffer(struct repository *r, struct commit *, void *buffer, unsigned long size);
 
 /*
  * Get any cached object buffer associated with the commit. Returns NULL
  * if none. The resulting memory should not be freed.
  */
-#define get_cached_commit_buffer(r, c, s) get_cached_commit_buffer_##r(c, s)
-const void *get_cached_commit_buffer_the_repository(const struct commit *, unsigned long *size);
+const void *get_cached_commit_buffer(struct repository *r, const struct commit *, unsigned long *size);
 
 /*
  * Get the commit's object contents, either from cache or by reading the object
@@ -102,20 +103,18 @@ const void *get_commit_buffer(const struct commit *, unsigned long *size);
  * from an earlier call to get_commit_buffer.  The buffer may or may not be
  * freed by this call; callers should not access the memory afterwards.
  */
-#define unuse_commit_buffer(r, c, b) unuse_commit_buffer_##r(c, b)
-void unuse_commit_buffer_the_repository(const struct commit *, const void *buffer);
+void unuse_commit_buffer(struct repository *r, const struct commit *, const void *buffer);
 
 /*
  * Free any cached object buffer associated with the commit.
  */
-#define free_commit_buffer(r, c) free_commit_buffer_##r(c)
-void free_commit_buffer_the_repository(struct commit *);
+void free_commit_buffer(struct repository *r, struct commit *);
 
 /*
  * Disassociate any cached object buffer from the commit, but do not free it.
  * The buffer (or NULL, if none) is returned.
  */
-const void *detach_commit_buffer(struct commit *, unsigned long *sizep);
+const void *detach_commit_buffer(struct repository *r, struct commit *, unsigned long *sizep);
 
 /* Find beginning and length of commit subject. */
 int find_commit_subject(const char *commit_buffer, const char **subject);
diff --git a/object.h b/object.h
index 513f5eaef4..65b5326e0f 100644
--- a/object.h
+++ b/object.h
@@ -5,6 +5,8 @@ struct object_parser {
 	struct object **obj_hash;
 	int nr_objs, obj_hash_size;
 
+	struct buffer_slab *buffer_slab;
+
 	/* parent substitutions from .git/info/grafts and .git/shallow */
 	struct commit_graft **grafts;
 	int grafts_alloc, grafts_nr;
@@ -17,12 +19,14 @@ struct object_parser {
 	unsigned commit_count;
 };
 
+extern struct buffer_slab the_repository_buffer_slab;
 extern struct alloc_state the_repository_blob_state;
 extern struct alloc_state the_repository_tree_state;
 extern struct alloc_state the_repository_commit_state;
 extern struct alloc_state the_repository_tag_state;
 extern struct alloc_state the_repository_object_state;
-#define OBJECT_PARSER_INIT { NULL, 0, 0, NULL, 0, 0, \
+#define OBJECT_PARSER_INIT { NULL, 0, 0, &the_repository_buffer_slab, \
+	NULL, 0, 0, \
 	&the_repository_blob_state, \
 	&the_repository_tree_state, \
 	&the_repository_commit_state, \
diff --git a/repository.c b/repository.c
index f76f0ddd37..0cf019bb9b 100644
--- a/repository.c
+++ b/repository.c
@@ -2,6 +2,7 @@
 #include "repository.h"
 #include "object-store.h"
 #include "config.h"
+#include "commit.h"
 #include "submodule-config.h"
 
 /* The main repository */
@@ -187,6 +188,8 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 	ALLOC_GROW(open_repos, open_repos_nr + 1, open_repos_alloc);
 	open_repos[open_repos_nr++] = repo;
 
+	alloc_buffer_slab(repo);
+
 	return 0;
 
 error:
@@ -249,6 +252,9 @@ int repo_submodule_init(struct repository *submodule,
 void repo_free(struct repository *repo)
 {
 	int i;
+
+	free_commit_slab(repo);
+
 	for (i = 0; i < open_repos_nr; i++) {
 		if (open_repos[i] != repo)
 			continue;
-- 
2.15.1.433.g936d1b9894.dirty

