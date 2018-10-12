Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F9C1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 20:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJMDgS (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 23:36:18 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:53254 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJMDgS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 23:36:18 -0400
Received: by mail-yw1-f73.google.com with SMTP id h38-v6so7915062ywk.20
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G1pwJfiQyk3zVq68ce3vXrOTMhIYi8oDEU6aDb7pqW4=;
        b=O0d3zwwuRyAjYHO6Stcv8Yk10lonOjbnu3lOKqvJaJXZnXqwUqUGLBbIBLCkwNZDzU
         SAidr/S+lLw68JT/0A3r4j12e2zxAoLkHq33WKDFDyKXdnjGVCsn9ZmFjdoR4B2/8e3S
         D8er/eSeIPnJWPDp/pjF6C1MNQHUCdmpoG3B0zBQxU/P8Z5jg+fb1My/0fhqTZL8/Ujv
         9xetbqiPyIcWeCI8sfZXho0ZenbNoOzO6LcsuXowJuMYQW5j9N1g3vy3vQatTVGX1+9E
         fPdJi6iU9MPSp5ImjvNwkmTngGtfEvQwFK8YaoFm0dsDI0Y0F8EAoZ6HLj06qPE8O/zH
         9HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G1pwJfiQyk3zVq68ce3vXrOTMhIYi8oDEU6aDb7pqW4=;
        b=KNIzgG96Hhe9q5r1/YB3e75J6YfhLqmF/ZrjmDl6JdM9tkrhOBP+85x4Z9Gf7sE5M3
         XAXgZB32NgkVWUPKBv1z4yz5kXnanU0RmCtis30Rt/sG82ToDLWyGDinmCod4s5ClJfr
         aYoaM4k8QrIq+5Oz6H6Sn8KN4seNp4SmV9iD7AHS9cexAgKSgeZDyt47r8bnT8XwUEHB
         UlwP7P+KBAzEG/eoL7ExVxnwwfic+36s/kZh5YPdNI89AwcUJbkxBqn+GND07Jfa1nQM
         9nU6WKBYXERoOO1TOFHhZIAtd8maW73xUmt7dfayxapwOvX6GZukjW6k+M/xWonFvtvF
         FkyA==
X-Gm-Message-State: ABuFfojoRz3WST3W1DWCy4S05KsVIYG0OYAh+3iHzg5ArYfY+vI4XeIU
        EDO9nkvjhgE+Qjj0vTbQ2QkZ8wc8hcF9LntDbQYxIRhYikIQ+Y1/yRrxAMUMkKHOOPulUfVgRxr
        t/UUeRGGs6lIOp/710zuSqqoJk0oB+x14bhzjBGUIwEvO0z2yaCcrIGu5KmY=
X-Google-Smtp-Source: ACcGV60scOwuMLypCNBbU5lNBOtamsDtEf4LtVst5teY3AmBdcQeH+3IrbiE3K09+ppmhw+5pOyW6IsXBERE
X-Received: by 2002:a25:be85:: with SMTP id i5-v6mr4404579ybk.19.1539374530585;
 Fri, 12 Oct 2018 13:02:10 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:01:42 -0700
In-Reply-To: <cover.1539373969.git.matvore@google.com>
Message-Id: <3bff094363c7887bfe6547e520cbe83097cf6f73.1539373969.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1539373969.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH v12 1/8] list-objects: store common func args in struct
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will make utility functions easier to create, as done by the next
patch.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects.c | 158 +++++++++++++++++++++++--------------------------
 1 file changed, 74 insertions(+), 84 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index c99c47ac1..584518a3f 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -12,20 +12,25 @@
 #include "packfile.h"
 #include "object-store.h"
 
-static void process_blob(struct rev_info *revs,
+struct traversal_context {
+	struct rev_info *revs;
+	show_object_fn show_object;
+	show_commit_fn show_commit;
+	void *show_data;
+	filter_object_fn filter_fn;
+	void *filter_data;
+};
+
+static void process_blob(struct traversal_context *ctx,
 			 struct blob *blob,
-			 show_object_fn show,
 			 struct strbuf *path,
-			 const char *name,
-			 void *cb_data,
-			 filter_object_fn filter_fn,
-			 void *filter_data)
+			 const char *name)
 {
 	struct object *obj = &blob->object;
 	size_t pathlen;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
 
-	if (!revs->blob_objects)
+	if (!ctx->revs->blob_objects)
 		return;
 	if (!obj)
 		die("bad blob object");
@@ -41,21 +46,21 @@ static void process_blob(struct rev_info *revs,
 	 * may cause the actual filter to report an incomplete list
 	 * of missing objects.
 	 */
-	if (revs->exclude_promisor_objects &&
+	if (ctx->revs->exclude_promisor_objects &&
 	    !has_object_file(&obj->oid) &&
 	    is_promisor_object(&obj->oid))
 		return;
 
 	pathlen = path->len;
 	strbuf_addstr(path, name);
-	if (!(obj->flags & USER_GIVEN) && filter_fn)
-		r = filter_fn(LOFS_BLOB, obj,
-			      path->buf, &path->buf[pathlen],
-			      filter_data);
+	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn)
+		r = ctx->filter_fn(LOFS_BLOB, obj,
+				   path->buf, &path->buf[pathlen],
+				   ctx->filter_data);
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		show(obj, path->buf, cb_data);
+		ctx->show_object(obj, path->buf, ctx->show_data);
 	strbuf_setlen(path, pathlen);
 }
 
@@ -81,26 +86,21 @@ static void process_blob(struct rev_info *revs,
  * the link, and how to do it. Whether it necessarily makes
  * any sense what-so-ever to ever do that is another issue.
  */
-static void process_gitlink(struct rev_info *revs,
+static void process_gitlink(struct traversal_context *ctx,
 			    const unsigned char *sha1,
-			    show_object_fn show,
 			    struct strbuf *path,
-			    const char *name,
-			    void *cb_data)
+			    const char *name)
 {
 	/* Nothing to do */
 }
 
-static void process_tree(struct rev_info *revs,
+static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
-			 show_object_fn show,
 			 struct strbuf *base,
-			 const char *name,
-			 void *cb_data,
-			 filter_object_fn filter_fn,
-			 void *filter_data)
+			 const char *name)
 {
 	struct object *obj = &tree->object;
+	struct rev_info *revs = ctx->revs;
 	struct tree_desc desc;
 	struct name_entry entry;
 	enum interesting match = revs->diffopt.pathspec.nr == 0 ?
@@ -133,14 +133,14 @@ static void process_tree(struct rev_info *revs,
 	}
 
 	strbuf_addstr(base, name);
-	if (!(obj->flags & USER_GIVEN) && filter_fn)
-		r = filter_fn(LOFS_BEGIN_TREE, obj,
-			      base->buf, &base->buf[baselen],
-			      filter_data);
+	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn)
+		r = ctx->filter_fn(LOFS_BEGIN_TREE, obj,
+				   base->buf, &base->buf[baselen],
+				   ctx->filter_data);
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		show(obj, base->buf, cb_data);
+		ctx->show_object(obj, base->buf, ctx->show_data);
 	if (base->len)
 		strbuf_addch(base, '/');
 
@@ -157,29 +157,25 @@ static void process_tree(struct rev_info *revs,
 		}
 
 		if (S_ISDIR(entry.mode))
-			process_tree(revs,
+			process_tree(ctx,
 				     lookup_tree(the_repository, entry.oid),
-				     show, base, entry.path,
-				     cb_data, filter_fn, filter_data);
+				     base, entry.path);
 		else if (S_ISGITLINK(entry.mode))
-			process_gitlink(revs, entry.oid->hash,
-					show, base, entry.path,
-					cb_data);
+			process_gitlink(ctx, entry.oid->hash, base, entry.path);
 		else
-			process_blob(revs,
+			process_blob(ctx,
 				     lookup_blob(the_repository, entry.oid),
-				     show, base, entry.path,
-				     cb_data, filter_fn, filter_data);
+				     base, entry.path);
 	}
 
-	if (!(obj->flags & USER_GIVEN) && filter_fn) {
-		r = filter_fn(LOFS_END_TREE, obj,
-			      base->buf, &base->buf[baselen],
-			      filter_data);
+	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn) {
+		r = ctx->filter_fn(LOFS_END_TREE, obj,
+				   base->buf, &base->buf[baselen],
+				   ctx->filter_data);
 		if (r & LOFR_MARK_SEEN)
 			obj->flags |= SEEN;
 		if (r & LOFR_DO_SHOW)
-			show(obj, base->buf, cb_data);
+			ctx->show_object(obj, base->buf, ctx->show_data);
 	}
 
 	strbuf_setlen(base, baselen);
@@ -242,19 +238,15 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 	add_pending_object(revs, &tree->object, "");
 }
 
-static void traverse_trees_and_blobs(struct rev_info *revs,
-				     struct strbuf *base,
-				     show_object_fn show_object,
-				     void *show_data,
-				     filter_object_fn filter_fn,
-				     void *filter_data)
+static void traverse_trees_and_blobs(struct traversal_context *ctx,
+				     struct strbuf *base)
 {
 	int i;
 
 	assert(base->len == 0);
 
-	for (i = 0; i < revs->pending.nr; i++) {
-		struct object_array_entry *pending = revs->pending.objects + i;
+	for (i = 0; i < ctx->revs->pending.nr; i++) {
+		struct object_array_entry *pending = ctx->revs->pending.objects + i;
 		struct object *obj = pending->item;
 		const char *name = pending->name;
 		const char *path = pending->path;
@@ -262,62 +254,49 @@ static void traverse_trees_and_blobs(struct rev_info *revs,
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			show_object(obj, name, show_data);
+			ctx->show_object(obj, name, ctx->show_data);
 			continue;
 		}
 		if (!path)
 			path = "";
 		if (obj->type == OBJ_TREE) {
-			process_tree(revs, (struct tree *)obj, show_object,
-				     base, path, show_data,
-				     filter_fn, filter_data);
+			process_tree(ctx, (struct tree *)obj, base, path);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
-			process_blob(revs, (struct blob *)obj, show_object,
-				     base, path, show_data,
-				     filter_fn, filter_data);
+			process_blob(ctx, (struct blob *)obj, base, path);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
 		    oid_to_hex(&obj->oid), name);
 	}
-	object_array_clear(&revs->pending);
+	object_array_clear(&ctx->revs->pending);
 }
 
-static void do_traverse(struct rev_info *revs,
-			show_commit_fn show_commit,
-			show_object_fn show_object,
-			void *show_data,
-			filter_object_fn filter_fn,
-			void *filter_data)
+static void do_traverse(struct traversal_context *ctx)
 {
 	struct commit *commit;
 	struct strbuf csp; /* callee's scratch pad */
 	strbuf_init(&csp, PATH_MAX);
 
-	while ((commit = get_revision(revs)) != NULL) {
+	while ((commit = get_revision(ctx->revs)) != NULL) {
 		/*
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
 		 */
 		if (get_commit_tree(commit))
-			add_pending_tree(revs, get_commit_tree(commit));
-		show_commit(commit, show_data);
+			add_pending_tree(ctx->revs, get_commit_tree(commit));
+		ctx->show_commit(commit, ctx->show_data);
 
-		if (revs->tree_blobs_in_commit_order)
+		if (ctx->revs->tree_blobs_in_commit_order)
 			/*
 			 * NEEDSWORK: Adding the tree and then flushing it here
 			 * needs a reallocation for each commit. Can we pass the
 			 * tree directory without allocation churn?
 			 */
-			traverse_trees_and_blobs(revs, &csp,
-						 show_object, show_data,
-						 filter_fn, filter_data);
+			traverse_trees_and_blobs(ctx, &csp);
 	}
-	traverse_trees_and_blobs(revs, &csp,
-				 show_object, show_data,
-				 filter_fn, filter_data);
+	traverse_trees_and_blobs(ctx, &csp);
 	strbuf_release(&csp);
 }
 
@@ -326,7 +305,14 @@ void traverse_commit_list(struct rev_info *revs,
 			  show_object_fn show_object,
 			  void *show_data)
 {
-	do_traverse(revs, show_commit, show_object, show_data, NULL, NULL);
+	struct traversal_context ctx;
+	ctx.revs = revs;
+	ctx.show_commit = show_commit;
+	ctx.show_object = show_object;
+	ctx.show_data = show_data;
+	ctx.filter_fn = NULL;
+	ctx.filter_data = NULL;
+	do_traverse(&ctx);
 }
 
 void traverse_commit_list_filtered(
@@ -337,14 +323,18 @@ void traverse_commit_list_filtered(
 	void *show_data,
 	struct oidset *omitted)
 {
-	filter_object_fn filter_fn = NULL;
+	struct traversal_context ctx;
 	filter_free_fn filter_free_fn = NULL;
-	void *filter_data = NULL;
-
-	filter_data = list_objects_filter__init(omitted, filter_options,
-						&filter_fn, &filter_free_fn);
-	do_traverse(revs, show_commit, show_object, show_data,
-		    filter_fn, filter_data);
-	if (filter_data && filter_free_fn)
-		filter_free_fn(filter_data);
+
+	ctx.revs = revs;
+	ctx.show_object = show_object;
+	ctx.show_commit = show_commit;
+	ctx.show_data = show_data;
+	ctx.filter_fn = NULL;
+
+	ctx.filter_data = list_objects_filter__init(omitted, filter_options,
+						    &ctx.filter_fn, &filter_free_fn);
+	do_traverse(&ctx);
+	if (ctx.filter_data && filter_free_fn)
+		filter_free_fn(ctx.filter_data);
 }
-- 
2.19.1.331.ge82ca0e54c-goog

