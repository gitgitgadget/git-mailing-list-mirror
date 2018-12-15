Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C790320A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeLOAKe (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:34 -0500
Received: from mail-oi1-f202.google.com ([209.85.167.202]:50380 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLOAKe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:34 -0500
Received: by mail-oi1-f202.google.com with SMTP id u63so3439245oie.17
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Mb+Sn/8mXWcnIHJo0dFLVb2/R3CSQuy8CSpA1ix1KZQ=;
        b=pFo/tA0JZ74iXQQqBik4D+4OF/jVAZwei7cSrLCCeC31Dh0ut4OPW+FapJq/Mw4y1l
         9mJvNhQ16O7rvnqenaeh7lTPol+N5rzxvNheEQxcO6nSNqPcCC5+pf8vFTCwz85To3xU
         zrktpATjbC0FjxspWl1eVHdaTCi8UXQ+HKJC7emxfkxMNz/WUikxZLEO/yBtK5hE4Yof
         FfIFERe11ezOlGc9VF5gy502KcJPG+zi6qwvySW4eYOjOxnvuVLioQH5zRiogChPRe+K
         kF0gZwb6TSPUaCqAcThj1nyuY4xeuaeZuaQbwF0UEiqL6QLyUVkvPbK3JtGaOMemqtt2
         SjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mb+Sn/8mXWcnIHJo0dFLVb2/R3CSQuy8CSpA1ix1KZQ=;
        b=YvJqiMnmpDVWdZn4dTX1cr15f623RQkMHeyxwIuaGWr+GV8VlaClTNARI5AMXI/P2X
         piGk3BH9sVJPbOsPNbzAnITMvD6PdRDeHA/BcEooC7+QKXBE5pwGa01iPNaW31tdwCKF
         THZA9JWQ9xrp1spVOFIjeMI/3CovfaI9F0xQjEhUTpXzAPJjBiJcuObLvQGES3V4COcy
         LWOb3858tWGtxsADXRJg1EsbLScdbrNS9xs4noOSDCEzbeb2Zg5g+JyMbR2QoPN8yLHW
         jezt6tGyWt0sh5c9A/vynINWNgM4ulAPtbJYWKyy1P0bldR9DcWUEwgrxP/FuaZguFEq
         2s3w==
X-Gm-Message-State: AA+aEWaIwjBs7yhR/8exKB2snG7UHeP9W0Z535j4/RH5lsh93JeWKq+4
        Xvno1WaHhVObaQbjLz71cloUg+rN55JESXLyOyWmxpJHrVbvctYlWWNE3XpYxoudghnynTKtmX8
        D5peX0nmtMb65PosIhyK/KWOWHTE7o/KoDc4BAJtiIzO/ZdKXRFX+Q+XwzEMD
X-Google-Smtp-Source: AFSGD/VEiRPEyxMLFCIdF9UnlR8e8xu0Z7AidExUOI9F2qMfrmvWeTmNu0wmMJTx7Tv38rWL7uQUjmm1qjUJ
X-Received: by 2002:aca:ec82:: with SMTP id k124mr4159137oih.36.1544832633182;
 Fri, 14 Dec 2018 16:10:33 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:39 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-21-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 20/23] commit-graph: convert remaining functions to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert all functions to handle arbitrary repositories in commit-graph.c
that are used by functions taking a repository argument already.

Notable exclusion is write_commit_graph and its local functions as that
only works on the_repository.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-graph.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..f78a8e96b5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -292,7 +292,8 @@ static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t
 			    g->chunk_oid_lookup, g->hash_len, pos);
 }
 
-static struct commit_list **insert_parent_or_die(struct commit_graph *g,
+static struct commit_list **insert_parent_or_die(struct repository *r,
+						 struct commit_graph *g,
 						 uint64_t pos,
 						 struct commit_list **pptr)
 {
@@ -303,7 +304,7 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
 		die("invalid parent position %"PRIu64, pos);
 
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
-	c = lookup_commit(the_repository, &oid);
+	c = lookup_commit(r, &oid);
 	if (!c)
 		die(_("could not find commit %s"), oid_to_hex(&oid));
 	c->graph_pos = pos;
@@ -317,7 +318,9 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
-static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t pos)
+static int fill_commit_in_graph(struct repository *r,
+				struct commit *item,
+				struct commit_graph *g, uint32_t pos)
 {
 	uint32_t edge_value;
 	uint32_t *parent_data_ptr;
@@ -341,13 +344,13 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	edge_value = get_be32(commit_data + g->hash_len);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
-	pptr = insert_parent_or_die(g, edge_value, pptr);
+	pptr = insert_parent_or_die(r, g, edge_value, pptr);
 
 	edge_value = get_be32(commit_data + g->hash_len + 4);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
 	if (!(edge_value & GRAPH_OCTOPUS_EDGES_NEEDED)) {
-		pptr = insert_parent_or_die(g, edge_value, pptr);
+		pptr = insert_parent_or_die(r, g, edge_value, pptr);
 		return 1;
 	}
 
@@ -355,7 +358,7 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 			  4 * (uint64_t)(edge_value & GRAPH_EDGE_LAST_MASK));
 	do {
 		edge_value = get_be32(parent_data_ptr);
-		pptr = insert_parent_or_die(g,
+		pptr = insert_parent_or_die(r, g,
 					    edge_value & GRAPH_EDGE_LAST_MASK,
 					    pptr);
 		parent_data_ptr++;
@@ -374,7 +377,9 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	}
 }
 
-static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
+static int parse_commit_in_graph_one(struct repository *r,
+				     struct commit_graph *g,
+				     struct commit *item)
 {
 	uint32_t pos;
 
@@ -382,7 +387,7 @@ static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item
 		return 1;
 
 	if (find_commit_in_graph(item, g, &pos))
-		return fill_commit_in_graph(item, g, pos);
+		return fill_commit_in_graph(r, item, g, pos);
 
 	return 0;
 }
@@ -391,7 +396,7 @@ int parse_commit_in_graph(struct repository *r, struct commit *item)
 {
 	if (!prepare_commit_graph(r))
 		return 0;
-	return parse_commit_in_graph_one(r->objects->commit_graph, item);
+	return parse_commit_in_graph_one(r, r->objects->commit_graph, item);
 }
 
 void load_commit_graph_info(struct repository *r, struct commit *item)
@@ -403,19 +408,22 @@ void load_commit_graph_info(struct repository *r, struct commit *item)
 		fill_commit_graph_info(item, r->objects->commit_graph, pos);
 }
 
-static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *c)
+static struct tree *load_tree_for_commit(struct repository *r,
+					 struct commit_graph *g,
+					 struct commit *c)
 {
 	struct object_id oid;
 	const unsigned char *commit_data = g->chunk_commit_data +
 					   GRAPH_DATA_WIDTH * (c->graph_pos);
 
 	hashcpy(oid.hash, commit_data);
-	c->maybe_tree = lookup_tree(the_repository, &oid);
+	c->maybe_tree = lookup_tree(r, &oid);
 
 	return c->maybe_tree;
 }
 
-static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
+static struct tree *get_commit_tree_in_graph_one(struct repository *r,
+						 struct commit_graph *g,
 						 const struct commit *c)
 {
 	if (c->maybe_tree)
@@ -423,12 +431,12 @@ static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
 	if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("get_commit_tree_in_graph_one called from non-commit-graph commit");
 
-	return load_tree_for_commit(g, (struct commit *)c);
+	return load_tree_for_commit(r, g, (struct commit *)c);
 }
 
 struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit *c)
 {
-	return get_commit_tree_in_graph_one(r->objects->commit_graph, c);
+	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -1025,7 +1033,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		}
 
 		graph_commit = lookup_commit(r, &cur_oid);
-		if (!parse_commit_in_graph_one(g, graph_commit))
+		if (!parse_commit_in_graph_one(r, g, graph_commit))
 			graph_report("failed to parse %s from commit-graph",
 				     oid_to_hex(&cur_oid));
 	}
@@ -1061,7 +1069,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 			continue;
 		}
 
-		if (!oideq(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
+		if (!oideq(&get_commit_tree_in_graph_one(r, g, graph_commit)->object.oid,
 			   get_commit_tree_oid(odb_commit)))
 			graph_report("root tree OID for commit %s in commit-graph is %s != %s",
 				     oid_to_hex(&cur_oid),
-- 
2.20.0.405.gbc1bbc6f85-goog

