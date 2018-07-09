Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23BE61F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754569AbeGIUou (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:44:50 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:45642 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754520AbeGIUos (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:44:48 -0400
Received: by mail-qt0-f201.google.com with SMTP id d14-v6so2228142qtn.12
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=pILGroyNlfB+Q9qcj1tVjTDA80VLvKgg7cQ4oBhfi+Y=;
        b=WX6MEWWeuaIp2FKOTkrkjRCQthH3JUnpD+xHuCm1Bm0bE6C99MOu7CD2ssTp0pCZeb
         vZr2NRh9O6t86oNzmuSb5SnOWzaV7evcmzH8TCz2KZBdbpUDXnGKjTCWk++nGWNliquT
         diRmik9W0qVkh3DSe8a9DL/kDZOuRDZx+PUr2TfWVq3ITGYSFUgJZPrw1UcyY+mIxEcf
         B3cgzxydZ2rrePzEyMgFdFCRf8B6uMOOA2s/2eagM+t8vyDYZEKB2gOs3a3l3pYUMdYw
         vzb26MIX/7BOf2Zk37op7whcUsBiHsrGC52Zof0TMfeWulb4ppb0H34qPZlHS3afk1C2
         i/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=pILGroyNlfB+Q9qcj1tVjTDA80VLvKgg7cQ4oBhfi+Y=;
        b=hVHXKSf0kmahxWc9IY80AdAdL30vYWLdzsKHxB5OpefBFwIksmnp061LIYxS5dIIzd
         D6ZgNDOIYzS/T48T+1ZoAlIiUsKgcLBwtHO/9dImcTHimkuVkH1ffT/DXD1Of6awyVxA
         VMgnQ7UetO/JaqUpR6xUUriLFTbDWfzlfE80nEIPtMnhA1kq4Yx+FPRRki8fQv1Z9WnG
         s0ns6Yi+FCcr7xD+xDm4P7aIB32BY8sh4U0qCa7NuJRp1WVH9zDf0IHvVjCEgpfQg2OP
         a0JhHjok/Ok8uYCNze3oK24D5CJjUBEYuYtuGcwTKdQrR7HK8zX6ezcSnRGRn++Pi4kB
         pCLw==
X-Gm-Message-State: APt69E0snkPGtssw2bTMS3abLfXVwtUJtGVF+mUizn1HXpEqvIsQRHo3
        fLAnJxuGu6xZ2WTDbwTSlq3XpWjGRprlNPTKIV/hobA7Haj1Q4wI6xvPRne98kOI5gSj3kpWBd6
        pSAR4N1B1JoVgkwapQbQ+2bnHVD4HElMkgUJnB5c+5kLiSqxdDnuL6SyVXPc0LEJB8tJZ6TqG9S
        eT
X-Google-Smtp-Source: AAOMgpdcz9phea7FV1FjdKLPHw9pTl1sEaq4KVsGLzg8QtAkael3ZbSRBhPkPKGLDFfPqQWHYlzFlCbjzL+3r9rVddMa
MIME-Version: 1.0
X-Received: by 2002:a0c:c48b:: with SMTP id u11-v6mr12473840qvi.21.1531169087815;
 Mon, 09 Jul 2018 13:44:47 -0700 (PDT)
Date:   Mon,  9 Jul 2018 13:44:35 -0700
In-Reply-To: <cover.1531168854.git.jonathantanmy@google.com>
Message-Id: <9769e2a7471c2b32185896e833cc74824ac5437e.1531168854.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531168854.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 1/6] commit-graph: refactor preparing commit graph
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two functions in the code (1) check if the repository is configured for
commit graphs, (2) call prepare_commit_graph(), and (3) check if the
graph exists. Move (1) and (3) into prepare_commit_graph(), reducing
duplication of code.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 commit-graph.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 212232e752..5ba60f63f9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -200,15 +200,25 @@ static void prepare_commit_graph_one(const char *obj_dir)
 }
 
 static int prepare_commit_graph_run_once = 0;
-static void prepare_commit_graph(void)
+
+/*
+ * Return 1 if commit_graph is non-NULL, and 0 otherwise.
+ *
+ * On the first invocation, this function attemps to load the commit
+ * graph if the_repository is configured to have one.
+ */
+static int prepare_commit_graph(void)
 {
 	struct alternate_object_database *alt;
 	char *obj_dir;
 
 	if (prepare_commit_graph_run_once)
-		return;
+		return !!commit_graph;
 	prepare_commit_graph_run_once = 1;
 
+	if (!core_commit_graph)
+		return 0;
+
 	obj_dir = get_object_directory();
 	prepare_commit_graph_one(obj_dir);
 	prepare_alt_odb(the_repository);
@@ -216,6 +226,7 @@ static void prepare_commit_graph(void)
 	     !commit_graph && alt;
 	     alt = alt->next)
 		prepare_commit_graph_one(alt->path);
+	return !!commit_graph;
 }
 
 static void close_commit_graph(void)
@@ -337,22 +348,17 @@ static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item
 
 int parse_commit_in_graph(struct commit *item)
 {
-	if (!core_commit_graph)
+	if (!prepare_commit_graph())
 		return 0;
-
-	prepare_commit_graph();
-	if (commit_graph)
-		return parse_commit_in_graph_one(commit_graph, item);
-	return 0;
+	return parse_commit_in_graph_one(commit_graph, item);
 }
 
 void load_commit_graph_info(struct commit *item)
 {
 	uint32_t pos;
-	if (!core_commit_graph)
+	if (!prepare_commit_graph())
 		return;
-	prepare_commit_graph();
-	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
+	if (find_commit_in_graph(item, commit_graph, &pos))
 		fill_commit_graph_info(item, commit_graph, pos);
 }
 
-- 
2.18.0.203.gfac676dfb9-goog

