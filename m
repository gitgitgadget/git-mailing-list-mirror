Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09F21F462
	for <e@80x24.org>; Mon, 17 Jun 2019 18:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfFQSHL (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 14:07:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35603 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfFQSHL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 14:07:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so11887364qto.2
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 11:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7yuEzi75kfPRt+apPwS0eTRWAMKnpOjqolIaSk5QuM=;
        b=aXnrqUwg3PslCp7tlI2+8UlEIawaZhplksBw3RRIJKMDv+/GgHTlmzdoEwyMPqbLcl
         hlru8bmHmD6PKu3xMzQVOCVGEFOK5CZyN9AMqpZ76vdQ2Ahu7Bd09ck3GNsOTRZlzwXv
         1aBzCnSf7I1yGelMGVu+8NRHw/aYv34TAJWg+SfYudlNoRf96n1F0WxCAZeKmNnULqBn
         x2xADVE+OZIjlm6WuIWDl9YN801gS3c07rro/6GgybSYsa3Bkgep5VZftowgJNEU1AFT
         Z+tkzNP7mvy9d+PLrwEyEQegHqwuGbrFptu9cQzrklD4xjBO58vbBmoYehJBsUlGcKjQ
         Ps4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7yuEzi75kfPRt+apPwS0eTRWAMKnpOjqolIaSk5QuM=;
        b=TQyjmeILWMLRzv/pEazzpFaQVvb8rEgdtCJsBs7rTO2/UOi8k7qqWgbsPqiYBKSjwl
         a5O3/Nk8DeorG/oPYo71/LAhLgcy4fanPGB2cBFqL0P/AhX8v6PlwXX0U/D3wWEm33zS
         dicDjC9pDUPpxI5SJfQ8RBO/HG1lnzQIyb1fB7OMdtkxsjHQtKLTAS8uG+qFZ9s8UvRI
         tgQhE4L0wtFj9nK+GXA+voLbCuayOr2HT+vDqALvna5PLmRXidUjXNuH4+N9SJnM1giA
         JStURVoBfGn/dqBmbYq+RD2kAlYHFgPk9hboRwt9cjzUvKSD+ZM3wLIzu0vedTssRE69
         y0rQ==
X-Gm-Message-State: APjAAAUgblnmf+bENO8kF04ASIhDiLKqkGlfpE4kflaaKiAymLDH5hbp
        95tARSmXO0Y6brx8aZ+Q38PuZJrU
X-Google-Smtp-Source: APXvYqw/hZqnRUn6qSnDjfHFb4jlZArBGWFBKiy7kn4yNj6/8bydGZxGVGpSfIx5o+UsmA6qW7XOKg==
X-Received: by 2002:ac8:2c33:: with SMTP id d48mr97661337qta.40.1560794829755;
        Mon, 17 Jun 2019 11:07:09 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:a800:1012:6e6a:2b95:41d:be6b])
        by smtp.gmail.com with ESMTPSA id 41sm9001600qtp.32.2019.06.17.11.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:07:09 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2] commit-graph: normalize commit-graph filenames
Date:   Mon, 17 Jun 2019 14:07:07 -0400
Message-Id: <20190617180707.11685-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.430.g4f3aec613b
In-Reply-To: <20190617150207.16849-1-dstolee@microsoft.com>
References: <20190617150207.16849-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing commit-graph files, we append path data to an
object directory, which may be specified by the user via the
'--object-dir' option. If the user supplies a trailing slash,
or some other alternative path format, the resulting path may
be usable for writing to the correct location. However, when
expiring graph files from the <obj-dir>/info/commit-graphs
directory during a write, we need to compare paths with exact
string matches.

Normalize the commit-graph filenames to avoid ambiguity. This
creates extra allocations, but this is a constant multiple of
the number of commit-graph files, which should be a number in
the single digits.

Further normalize the object directory in the context. Due to
a comparison between g->obj_dir and ctx->obj_dir in
split_graph_merge_strategy(), a trailing slash would prevent
any merging of layers within the same object directory. The
check is there to ensure we do not merge across alternates.
Update the tests to include a case with this trailing slash
problem.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

Sorry for the previously-bad patch. This one I believe to
be a full correction, and also includes a test to ensure
we do not make this mistake again.

Thanks,
-Stolee

 commit-graph.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8842f93910..2836a6fc3d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -43,15 +43,23 @@
 
 char *get_commit_graph_filename(const char *obj_dir)
 {
-	return xstrfmt("%s/info/commit-graph", obj_dir);
+	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
+	char *normalized = xmalloc(strlen(filename) + 1);
+	normalize_path_copy(normalized, filename);
+	free(filename);
+	return normalized;
 }
 
 static char *get_split_graph_filename(const char *obj_dir,
 				      const char *oid_hex)
 {
-	return xstrfmt("%s/info/commit-graphs/graph-%s.graph",
-		       obj_dir,
-		       oid_hex);
+	char *filename = xstrfmt("%s/info/commit-graphs/graph-%s.graph",
+				 obj_dir,
+				 oid_hex);
+	char *normalized = xmalloc(strlen(filename) + 1);
+	normalize_path_copy(normalized, filename);
+	free(filename);
+	return normalized;
 }
 
 static char *get_chain_filename(const char *obj_dir)
@@ -744,7 +752,7 @@ struct packed_oid_list {
 
 struct write_commit_graph_context {
 	struct repository *r;
-	const char *obj_dir;
+	char *obj_dir;
 	char *graph_name;
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -1693,7 +1701,11 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	}
 
 	strbuf_addstr(&path, ctx->obj_dir);
-	strbuf_addstr(&path, "/info/commit-graphs");
+
+	if (path.buf[path.len - 1] != '/')
+		strbuf_addch(&path, '/');
+
+	strbuf_addstr(&path, "info/commit-graphs");
 	dir = opendir(path.buf);
 
 	if (!dir) {
@@ -1727,7 +1739,6 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 
 		if (!found)
 			unlink(path.buf);
-
 	}
 }
 
@@ -1739,6 +1750,7 @@ int write_commit_graph(const char *obj_dir,
 {
 	struct write_commit_graph_context *ctx;
 	uint32_t i, count_distinct = 0;
+	size_t len;
 	int res = 0;
 
 	if (!commit_graph_compatible(the_repository))
@@ -1746,7 +1758,14 @@ int write_commit_graph(const char *obj_dir,
 
 	ctx = xcalloc(1, sizeof(struct write_commit_graph_context));
 	ctx->r = the_repository;
-	ctx->obj_dir = obj_dir;
+
+	/* normalize object dir with no trailing slash */
+	ctx->obj_dir = xmallocz(strlen(obj_dir) + 1);
+	normalize_path_copy(ctx->obj_dir, obj_dir);
+	len = strlen(ctx->obj_dir);
+	if (len && ctx->obj_dir[len - 1] == '/')
+		ctx->obj_dir[len - 1] = 0;
+
 	ctx->append = flags & COMMIT_GRAPH_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_PROGRESS ? 1 : 0;
 	ctx->split = flags & COMMIT_GRAPH_SPLIT ? 1 : 0;
@@ -1854,6 +1873,7 @@ int write_commit_graph(const char *obj_dir,
 	free(ctx->graph_name);
 	free(ctx->commits.list);
 	free(ctx->oids.list);
+	free(ctx->obj_dir);
 
 	if (ctx->commit_graph_filenames_after) {
 		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
-- 
2.22.0.430.g4f3aec613b

