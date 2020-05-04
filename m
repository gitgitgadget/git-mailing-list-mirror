Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA5C47247
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0385206C0
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BiskWIyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgEDTNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDTNa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:13:30 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F118EC061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:13:28 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w12so423062qto.19
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KTqSHUf1rowD2u8QuiU3a1NzLqJX65Nahsn1oIbfwus=;
        b=BiskWIyYdenG2+rW4o/wPV6OZ2A8Gsb4E1zh4WHpLQCeygcfQoVcT6LUFyQ69Uwi1F
         q7tm7gXXepK3AIhcisQ2b9LlUu7sak95fzKZaoeQW9jd7t3Rww2fmMEwk8n3itpt9IAq
         sJZ4QVTKR6uqAG3YQEIWvwh0QP7j6IOOb5Jxb5iAjoiLMTvfSJJbQw4MUetAVoquT/Sn
         6kBzf9Z5O/41xadHpkYEibSC8yy/6puyFv9ZzKbbK/StYtGEozS1+2uQqT73kmvb/JQ2
         w15gQ7DI0aiTcKQzwwane/5GOxtGtHOVf9muCvPsgvJtc3h4ICo2zv0M1hLnbKXjnIJ3
         ZRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KTqSHUf1rowD2u8QuiU3a1NzLqJX65Nahsn1oIbfwus=;
        b=ovFbTURodVM03Has48PV/IQSVGmi9qmTDq5/M5Y7MiJfxBAv0Zsm3lLayc2rDMuBlN
         b1SQdSxQKWhOX8cKDRBRsbmsZ+hf3VBbiUNE4goIGH7OhHGLTXxGmGy0gnbQLvSGfkzt
         aFgbTvbeu1oTsiyOO48ePutc26lT5wiuSzbNmovAaLqa3sHW75pYQ+jMGkFZRB+lvpIt
         isuphyIby81ayVW4DyhxxDyep90ozO+XP5zPONPHdqN4ChySYLZBm3jxodBUibAtuWNs
         M4n0FlNaZTPwdXE5aVKnGCB+OEzPXFj+3qv+BKmIRnJJtln4L/RuoCtYJlriqgQzKyid
         Y+Ww==
X-Gm-Message-State: AGi0PubkFPcfTnBts4hLXivKoXgMXioKyLwiAmRaMaEfPMdEmHJBxl54
        v3kfHRGjRBcSnkkBhn7oVkfXdeICefikxFXfif79NVK/cnrd08NS2sY2Z+EBkObgf3DLHSs+leC
        4Bu+tTq8wVS0sBH/MUT/pIympKnttgSZX/l4ID5onQ9BgdTaz74iJjk+HMZADXsaFftmE0wBqG6
        J2
X-Google-Smtp-Source: APiQypI0GNQz2tkB5whtjh3RcO+b3NrW+Y6wr7DH+gbs/10kFIpVVjqFueGvXbsQSsFu6eiwar//u1goBnxTj19sa7Ku
X-Received: by 2002:a05:6214:1386:: with SMTP id g6mr613607qvz.105.1588619607983;
 Mon, 04 May 2020 12:13:27 -0700 (PDT)
Date:   Mon,  4 May 2020 12:13:24 -0700
Message-Id: <20200504191324.201663-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH] commit-graph: avoid memory leaks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A fuzzer running on the entry point provided by fuzz-commit-graph.c
revealed a memory leak when parse_commit_graph() creates a struct
bloom_filter_settings and then returns early due to error. Fix that
error by always freeing that struct first (if it exists) before
returning early due to error.

While making that change, I also noticed another possible memory leak -
when the BLOOMDATA chunk is provided but not BLOOMINDEXES. Also fix that
error.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Here's a memory leak fix revealed by a fuzzer running at $DAYJOB, and
another one that I noticed while making that fix.
---
 commit-graph.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6dc777e2f3..1694f0a691 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -281,8 +281,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
 		if (data + graph_size - chunk_lookup <
 		    GRAPH_CHUNKLOOKUP_WIDTH) {
 			error(_("commit-graph chunk lookup table entry missing; file may be incomplete"));
-			free(graph);
-			return NULL;
+			goto free_and_return;
 		}
 
 		chunk_id = get_be32(chunk_lookup + 0);
@@ -293,8 +292,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
 		if (chunk_offset > graph_size - the_hash_algo->rawsz) {
 			error(_("commit-graph improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
 			      (uint32_t)chunk_offset);
-			free(graph);
-			return NULL;
+			goto free_and_return;
 		}
 
 		switch (chunk_id) {
@@ -361,8 +359,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
 
 		if (chunk_repeated) {
 			error(_("commit-graph chunk id %08x appears multiple times"), chunk_id);
-			free(graph);
-			return NULL;
+			goto free_and_return;
 		}
 
 		if (last_chunk_id == GRAPH_CHUNKID_OIDLOOKUP)
@@ -381,17 +378,20 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
 		/* We need both the bloom chunks to exist together. Else ignore the data */
 		graph->chunk_bloom_indexes = NULL;
 		graph->chunk_bloom_data = NULL;
-		graph->bloom_filter_settings = NULL;
+		FREE_AND_NULL(graph->bloom_filter_settings);
 	}
 
 	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
 
-	if (verify_commit_graph_lite(graph)) {
-		free(graph);
-		return NULL;
-	}
+	if (verify_commit_graph_lite(graph))
+		goto free_and_return;
 
 	return graph;
+
+free_and_return:
+	free(graph->bloom_filter_settings);
+	free(graph);
+	return NULL;
 }
 
 static struct commit_graph *load_commit_graph_one(const char *graph_file,
-- 
2.26.2.526.g744177e7f7-goog

