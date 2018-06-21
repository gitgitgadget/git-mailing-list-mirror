Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E8F1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933813AbeFUV3p (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:29:45 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:55908 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbeFUV3k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:40 -0400
Received: by mail-qk0-f201.google.com with SMTP id f207-v6so3652750qke.22
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=waAZt76HerClF5hPN+mjkxyxHhc0k2lrC0yzC4CqaW4=;
        b=mso8XMc0PRTWzDKk/A8eCXPpPa0PSgHgBLSBEKooHjgw/zPqu44ZptkjP/BxJYxVK3
         SxUODmxPoVgt4jbl4IOs60JNRRTTt/XTgfALzDw6W1rV6WQ6+3eg7gSzc8rM9cCWMukb
         L87uRHqhxgm3149bkoVlf6e4Vwt/5/YqIS3QbJ2YoMG3enjshPsWgEavCAuOksKSmD32
         F6NnvLZVGMGTqxUgA5/wV9VXkKkYcn/RBsrtIe/JRWIuWyKWyfnsZZCSgDfM7l154h+N
         Aj9fAysSIUq18RMwa8cRSbC3D4kPdLJoqN9G+n7eBbuxOGbT8XD8U5Lxaag7HwJFGDl7
         TSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=waAZt76HerClF5hPN+mjkxyxHhc0k2lrC0yzC4CqaW4=;
        b=GGSLs4taEHNzSKGkNh8/RCi0L6SYt1AMDeaxDZa3KnykSymWK0n66zke9N2Ig+260+
         kKzj7BzXkE6pWyWkxMH9B5keTfwYqSvNbovouqG3/lXqIu+c+S4kThpmAMn2t3TlyIwF
         4xZ1QriXVKPdJ8d+dpe85lJKIxtzUeVVuWRZ10vfG1R3haUf+sDYiTLH8f8MOc4dR2Lh
         Yjt5ajcij93uMaW+AhDGbQlPWmfzyQpvOpAwWJbkR6QJcz0uWMPTUbyRcKnFYOFdZE5P
         KMlGhl7NepekkmEsJFUBFEyQsvgv4vH/jfLe9H5cpWSLgwwGqpcAnsKo7MvMfQT6suBR
         /jTg==
X-Gm-Message-State: APt69E2v0YCMcFkUKTv2ZzYw5A9HQ9bQEhHpIgSpJ7Pnn4P5Uq9KnEv2
        S+ZnhB4870KMsoxZqt6FrYh4hFtIRkOuV9D4Dx/PElECmYB0+5xVKWEP2HnOCe/qad/EojErAT2
        +de0rIZ21H1INxWnMCC+mDLiORv/Oln8peKxxnlpalrDImStxa/x/FF1kNspxd52co0wVoYMbk0
        JX
X-Google-Smtp-Source: ADUXVKLl86npTQso79ZWvP1/f10Bqa3z4PnHni1Vd88Adp/aXUsty5Tg6T7ht2mOCQ1B+MbaRQrCiClEdMxZN1ni9z5D
MIME-Version: 1.0
X-Received: by 2002:a37:4a8b:: with SMTP id x133-v6mr14658735qka.39.1529616579170;
 Thu, 21 Jun 2018 14:29:39 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:29:24 -0700
In-Reply-To: <cover.1529616356.git.jonathantanmy@google.com>
Message-Id: <3410494e3505a7b1b895869c3702dbba0f0cf5a6.1529616356.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: [PATCH 4/5] commit-graph: store graph in struct object_store
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
 commit-graph.c | 34 ++++++++++++++++++----------------
 object-store.h |  3 +++
 object.c       |  5 +++++
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9f4e761229..61b4fbb925 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -179,45 +179,42 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
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
 static void prepare_commit_graph(void)
 {
 	struct alternate_object_database *alt;
 	char *obj_dir;
 
-	if (prepare_commit_graph_run_once)
+	if (the_repository->objects->commit_graph_attempted)
 		return;
-	prepare_commit_graph_run_once = 1;
+	the_repository->objects->commit_graph_attempted = 1;
 
 	obj_dir = get_object_directory();
 	prepare_commit_graph_one(obj_dir);
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects->alt_odb_list;
-	     !commit_graph && alt;
+	     !the_repository->objects->commit_graph && alt;
 	     alt = alt->next)
 		prepare_commit_graph_one(alt->path);
 }
 
 static void close_commit_graph(void)
 {
-	free_commit_graph(commit_graph);
-	commit_graph = NULL;
+	free_commit_graph(the_repository->objects->commit_graph);
+	the_repository->objects->commit_graph = NULL;
 }
 
 static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t *pos)
@@ -293,7 +290,9 @@ int parse_commit_in_graph(struct commit *item)
 		return 1;
 
 	prepare_commit_graph();
-	if (commit_graph) {
+	if (the_repository->objects->commit_graph) {
+		struct commit_graph *commit_graph =
+			the_repository->objects->commit_graph;
 		uint32_t pos;
 		int found;
 		if (item->graph_pos != COMMIT_NOT_FROM_GRAPH) {
@@ -329,7 +328,8 @@ struct tree *get_commit_tree_in_graph(const struct commit *c)
 	if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("get_commit_tree_in_graph called from non-commit-graph commit");
 
-	return load_tree_for_commit(commit_graph, (struct commit *)c);
+	return load_tree_for_commit(the_repository->objects->commit_graph,
+				    (struct commit *)c);
 }
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -589,15 +589,17 @@ void write_commit_graph(const char *obj_dir,
 
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
index f7f4de3aaf..04954f4f3e 100644
--- a/object.c
+++ b/object.c
@@ -7,6 +7,7 @@
 #include "tag.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "commit-graph.h"
 
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
@@ -484,6 +485,10 @@ void raw_object_store_clear(struct raw_object_store *o)
 	oidmap_free(o->replace_map, 1);
 	FREE_AND_NULL(o->replace_map);
 
+	free_commit_graph(o->commit_graph);
+	o->commit_graph = NULL;
+	o->commit_graph_attempted = 0;
+
 	free_alt_odbs(o);
 	o->alt_odb_tail = NULL;
 
-- 
2.18.0.rc2.347.g0da03f3a46.dirty

