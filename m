Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194661F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933190AbeGIUpA (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:45:00 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:47284 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeGIUo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:44:58 -0400
Received: by mail-io0-f201.google.com with SMTP id p17-v6so17532116iob.14
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ofk+xD5sf4v2hhJR4dJCJdcKR5hmYoRPEA/HzqRUK00=;
        b=JMpN+VSaZc9kSmUimSRMfhE/R7YphdjXsOf6OAtJ6bmsEOQy3AM36gViePsvmgigsq
         /bDP44FyEUC39BPdyXbPpdoMMR0XqY4L8iKYeLqNLH3jmyfCDldWHbeFTFhmPBUz+7Lv
         NLiQNCRAx7Gi4DI0mtqrW+EAWsbsrS2TBfeodk/zt+k6I0EUVtYfsJczNW70Iaqcvn8H
         bkYxYkIItzLE28/ar9TZ0ioqAcCizzyhuFgJwVccJOqQV26PN3vKJGd8edvL5/2gZhmH
         uIoPAdRd1N+xZB/MM3zsBhjk7jk42Qy2E3N0OYb5a8IwYkeqUhs8oE+4/qYJl1X11e/I
         w84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ofk+xD5sf4v2hhJR4dJCJdcKR5hmYoRPEA/HzqRUK00=;
        b=Lny2dcT/q10dG8Ux9skC8OqC4HBOduhKlraQDUo3KNdyqKdreoCMB3RjHbsqXr4U0D
         x+0T9k2Vo3CGYlyJiJLwo+Df2dZ65PpTA2Svrn058oW7R4Eaax175KuGDkT4Qc25+7vq
         Uh8cVgMpKyChNvRgjSLepILDwAjCSeF4BiDg/HI8algUOgJ7bFxMY7YfGddgz0F0E1Eo
         /mjYJE3ITUqc/mz0bNbmKM5iYTJuT3gv/KIYMQWcXaRg8B4aWxI//CtCUgczWu0c+jV6
         ML+68dulrvW/vAZCqM4YXfxxjq/cl6MrI25grcrHbD/fj3FWKVCs4KCCV13NzgBV/Fp+
         3QYQ==
X-Gm-Message-State: APt69E1lPa324p2ACZG+dWqGm9TCNyKYOXy33jKadi786B0Ww1I5c7mW
        J7zD7Lu8Wc+4P9aEvDc2hVka+adTWPVKS9M+lYEJzIVbVJw/V9NlmiV3JL44i6wqSTfLYkpvubN
        a3593qn5T0GRosqqp6MUNHdxUtp5I56IdMATmdHdoIHfY5x1z90GMqoCpBI3+r4ik0enTMTy5PT
        4g
X-Google-Smtp-Source: AAOMgpeRPqJe6Qy8IP+kSNeRIpVSHQl7BjNVjdLkLvJ+MCsDbcOm4d4oAKBdOpLkLWPwL7jM2bPdT8OBR7HofvAgpsVA
MIME-Version: 1.0
X-Received: by 2002:a24:ad4f:: with SMTP id a15-v6mr8853982itj.42.1531169097667;
 Mon, 09 Jul 2018 13:44:57 -0700 (PDT)
Date:   Mon,  9 Jul 2018 13:44:39 -0700
In-Reply-To: <cover.1531168854.git.jonathantanmy@google.com>
Message-Id: <19ccb4643a68df95051cf4513038471aa1bdd900.1531168854.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531168854.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 5/6] commit-graph: store graph in struct object_store
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of storing commit graphs in static variables, store them in
struct object_store. There are no changes to the signatures of existing
functions - they all still only support the_repository, and support for
other instances of struct repository will be added in a subsequent
commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 commit-graph.c | 40 +++++++++++++++++++---------------------
 object-store.h |  3 +++
 object.c       |  5 +++++
 3 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6d1bc4ff7c..af97a10603 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -183,24 +183,20 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	exit(1);
 }
 
-/* global storage */
-static struct commit_graph *commit_graph = NULL;
-
 static void prepare_commit_graph_one(const char *obj_dir)
 {
 	char *graph_name;
 
-	if (commit_graph)
+	if (the_repository->objects->commit_graph)
 		return;
 
 	graph_name = get_commit_graph_filename(obj_dir);
-	commit_graph = load_commit_graph_one(graph_name);
+	the_repository->objects->commit_graph =
+		load_commit_graph_one(graph_name);
 
 	FREE_AND_NULL(graph_name);
 }
 
-static int prepare_commit_graph_run_once = 0;
-
 /*
  * Return 1 if commit_graph is non-NULL, and 0 otherwise.
  *
@@ -212,9 +208,9 @@ static int prepare_commit_graph(void)
 	struct alternate_object_database *alt;
 	char *obj_dir;
 
-	if (prepare_commit_graph_run_once)
-		return !!commit_graph;
-	prepare_commit_graph_run_once = 1;
+	if (the_repository->objects->commit_graph_attempted)
+		return !!the_repository->objects->commit_graph;
+	the_repository->objects->commit_graph_attempted = 1;
 
 	if (!core_commit_graph)
 		return 0;
@@ -223,16 +219,16 @@ static int prepare_commit_graph(void)
 	prepare_commit_graph_one(obj_dir);
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects->alt_odb_list;
-	     !commit_graph && alt;
+	     !the_repository->objects->commit_graph && alt;
 	     alt = alt->next)
 		prepare_commit_graph_one(alt->path);
-	return !!commit_graph;
+	return !!the_repository->objects->commit_graph;
 }
 
 static void close_commit_graph(void)
 {
-	free_commit_graph(commit_graph);
-	commit_graph = NULL;
+	free_commit_graph(the_repository->objects->commit_graph);
+	the_repository->objects->commit_graph = NULL;
 }
 
 static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t *pos)
@@ -342,7 +338,7 @@ int parse_commit_in_graph(struct commit *item)
 {
 	if (!prepare_commit_graph())
 		return 0;
-	return parse_commit_in_graph_one(commit_graph, item);
+	return parse_commit_in_graph_one(the_repository->objects->commit_graph, item);
 }
 
 void load_commit_graph_info(struct commit *item)
@@ -350,8 +346,8 @@ void load_commit_graph_info(struct commit *item)
 	uint32_t pos;
 	if (!prepare_commit_graph())
 		return;
-	if (find_commit_in_graph(item, commit_graph, &pos))
-		fill_commit_graph_info(item, commit_graph, pos);
+	if (find_commit_in_graph(item, the_repository->objects->commit_graph, &pos))
+		fill_commit_graph_info(item, the_repository->objects->commit_graph, pos);
 }
 
 static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *c)
@@ -379,7 +375,7 @@ static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
 
 struct tree *get_commit_tree_in_graph(const struct commit *c)
 {
-	return get_commit_tree_in_graph_one(commit_graph, c);
+	return get_commit_tree_in_graph_one(the_repository->objects->commit_graph, c);
 }
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -696,15 +692,17 @@ void write_commit_graph(const char *obj_dir,
 
 	if (append) {
 		prepare_commit_graph_one(obj_dir);
-		if (commit_graph)
-			oids.alloc += commit_graph->num_commits;
+		if (the_repository->objects->commit_graph)
+			oids.alloc += the_repository->objects->commit_graph->num_commits;
 	}
 
 	if (oids.alloc < 1024)
 		oids.alloc = 1024;
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
-	if (append && commit_graph) {
+	if (append && the_repository->objects->commit_graph) {
+		struct commit_graph *commit_graph =
+			the_repository->objects->commit_graph;
 		for (i = 0; i < commit_graph->num_commits; i++) {
 			const unsigned char *hash = commit_graph->chunk_oid_lookup +
 				commit_graph->hash_len * i;
diff --git a/object-store.h b/object-store.h
index f0b77146e4..39f4a3d5b9 100644
--- a/object-store.h
+++ b/object-store.h
@@ -106,6 +106,9 @@ struct raw_object_store {
 	 */
 	struct oidmap *replace_map;
 
+	struct commit_graph *commit_graph;
+	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
+
 	/*
 	 * private data
 	 *
diff --git a/object.c b/object.c
index 10d167825e..6672820b9e 100644
--- a/object.c
+++ b/object.c
@@ -8,6 +8,7 @@
 #include "alloc.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "commit-graph.h"
 
 unsigned int get_max_object_index(void)
 {
@@ -501,6 +502,10 @@ void raw_object_store_clear(struct raw_object_store *o)
 	oidmap_free(o->replace_map, 1);
 	FREE_AND_NULL(o->replace_map);
 
+	free_commit_graph(o->commit_graph);
+	o->commit_graph = NULL;
+	o->commit_graph_attempted = 0;
+
 	free_alt_odbs(o);
 	o->alt_odb_tail = NULL;
 
-- 
2.18.0.203.gfac676dfb9-goog

