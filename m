Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412B01F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 22:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389622AbeGKWtW (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 18:49:22 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:47100 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeGKWtW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 18:49:22 -0400
Received: by mail-vk0-f73.google.com with SMTP id h81-v6so9869694vke.13
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 15:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3iS6GwhjV6D0EUP6ktE6IjcIxiEyA1Mow5z0VK9Tbdg=;
        b=Vxfoca8ciXQXBX039cvXKupwuDBqDJPuWfeuiPwXXfz6zA1mP+6y1Ebisv1wM1hC6G
         AFz4Vv5fL5sIQBALKuy8M+GCAIkUhw6Bfq+TWj4HJGH4R2/n8qvoQu54E9cBeXTJb9n1
         lCtNe08z5YbpCzS9qQQy3mOxMVVPPgmOmBRSwDP1+s1wbNFSoFG4dvhuW6QIGElvCp0n
         5wfyWYrvPllWo8Z1TGzrkWRLVxyMbvlAJcAFPovoUNcG2xLjJpxwwkkPJ26mHjnYGRuL
         uc9xZohfJXZ5m5iwVLIJ3xS+ZPlQTqXB2w/AfafwIVsl9xEHVxeI8Bv5cGxi7go1jvGx
         Jd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3iS6GwhjV6D0EUP6ktE6IjcIxiEyA1Mow5z0VK9Tbdg=;
        b=sL5XvexUYicNcqcCtgBQvuecwOG4hU/uEmOZo+Lg3ca+BdWghG7mpmVZ3pVsjW4dnA
         5VFgNU+dPbEOlSg079+C+38rKFs5A2oOIKnLiW4Wj15w3QTsdbnpcXrSDbfCdZfg218U
         zimVTlckjuOuiolsy9UWzKXj3E31VDsg/FOex02UzYxOshiv4d+ZDMQTdadRCBF73jo4
         M3dUBhy891Avv1IYlgUYEyrs6ku5cM6SZWIDo6uJqYjvQ9VR4iVCXVcAX/NrsygyrS4a
         9Pfkra42xXa7lhBl/RBoxwQZ3jZT3w4sNH/61QDCdO/UwaycVA86IjTbDK/bSmml2Zg3
         2FTw==
X-Gm-Message-State: AOUpUlHNjURmo3NKzOfs5anSLmRUDlAzWSGlzdjAjbp4NUoy9D17vX4u
        ip7oRsavkA/Xl1FRfoi7vee33zg7vb/fPZwbrWVRItqAj4zSdrxPkjt6DrVeJ6qLStbD65fb0O2
        Q2c3Z1h7gfMRSlY7N9DiHHKmws4y40teDNfGkRxh7L+3Guvp66FuQXwi9FdlwU4zD8unWiAH/8u
        YS
X-Google-Smtp-Source: AAOMgpdIFJqD2kaDGO70B5q1npfz/dpOtApfvNOeGxTNBRx07OeKRTp9msTRfQ7miICUatHGkimUK+riInOT0LTONgem
MIME-Version: 1.0
X-Received: by 2002:a9f:3aca:: with SMTP id q10-v6mr272722uag.31.1531348970261;
 Wed, 11 Jul 2018 15:42:50 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:42:37 -0700
In-Reply-To: <cover.1531348540.git.jonathantanmy@google.com>
Message-Id: <2e221f35c9657377f98c53f437bb950e7d4c8a1b.1531348540.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531348540.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v3 1/6] commit-graph: refactor preparing commit graph
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
index 41a0133ff7..1ea701ed69 100644
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

