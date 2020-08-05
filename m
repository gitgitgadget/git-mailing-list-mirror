Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3043C433E1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E0D22D2C
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="I7XTi0Hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgHERCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgHERBo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:01:44 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75622C06174A
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:01:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o22so33943522qtt.13
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1BiigwTLfuOeWHvfonIVOOTNqNm25Nmg66yT7L4YJ+U=;
        b=I7XTi0HnnUcsuAaicSZT6dQyoyNj2L3OXn+PjnmIgCAGaAFSvNP6pGK1LpmG1T/ohb
         vfh+mOcyxIH9MwmFRsn8ZDkRuJagYscvc2SB1lcbb8Y400a9FYPb2haRWWNbl8JvO6w8
         J89u0B2ckQ2dqts7iKVVIJDZhoL6Q2U6bDHgIJBT2ZDRJe/+h2QUOnvegcB6omC3j5Gy
         6LuPfRF6atIuxTYmIB0ZzU1Q0DVyki5P8u9thNAB37fYiMfbG4ISvsZ6LyxRbIeIRCnH
         KFUqiCCIcCSyt72FDHrDCooK+dKDYW1iwm4bkcyjyZzdTyB49c+IxOrCaQo9yakppUR0
         JQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1BiigwTLfuOeWHvfonIVOOTNqNm25Nmg66yT7L4YJ+U=;
        b=CpvyMwThdHeJ9NS+iiki3WD3kRHHU7OffvJXCJCMK0JlpceFO+9TbPssK2pg3XuUiI
         ZtAvTLR2tIQoavj3QgF+jXVH8dWcZm/sAcSYbCF5RI2UjBx2xFy9yM/AQubcAenxpnIZ
         99EAe0fBUemf57e5da1XR401c6+5x6B2ekWOvWk6cfw9M7OEODBqZ24VxTijzGatEvvU
         n+Oca1nGBEthy9hfzMH+TUs1PafP5GIIIsyd+hLXQiUJYPzxMV96fWy4nzVRlO2vHkRc
         uewTM+5zf4GTMM8F31KM9X9m82Ho+IISgAGPMWfWEBBiKbqJStZHRBQtDf6kL79eVUjg
         1/vg==
X-Gm-Message-State: AOAM530haYEP2IMmzwf0CzeeOLRRELwM+vPMz/oniIsrEuluP062yfBw
        Fa39l6QmP/ngv2sR4CFTMr92nduDWFF+fg==
X-Google-Smtp-Source: ABdhPJzl0D33467qJQd+N2VlQO3ZfQXPUBkMVhfzgDSBq/+PuiqZsIuLL5ujpg9g+LR2aHlvWNzhjg==
X-Received: by 2002:ac8:35f9:: with SMTP id l54mr4496932qtb.25.1596646899094;
        Wed, 05 Aug 2020 10:01:39 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id t5sm2076562qkh.46.2020.08.05.10.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:01:38 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:01:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH v2 01/14] commit-graph: introduce
 'get_bloom_filter_settings()'
Message-ID: <001f3385ffd96f24a640ff6670166e67784f1f50.1596646576.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1596646576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596646576.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many places in the code often need a pointer to the commit-graph's
'struct bloom_filter_settings', in which case they often take the value
from the top-most commit-graph.

In the non-split case, this works as expected. In the split case,
however, things get a little tricky. Not all layers in a chain of
incremental commit-graphs are required to themselves have Bloom data,
and so whether or not some part of the code uses Bloom filters depends
entirely on whether or not the top-most level of the commit-graph chain
has Bloom filters.

This has been the behavior since Bloom filters were introduced, and has
been codified into the tests since a759bfa9ee (t4216: add end to end
tests for git log with Bloom filters, 2020-04-06). In fact, t4216.130
requires that Bloom filters are not used in exactly the case described
earlier.

There is no reason that this needs to be the case, since it is perfectly
valid for commits in an earlier layer to have Bloom filters when commits
in a newer layer do not.

Since Bloom settings are guaranteed to be the same for any layer in a
chain that has Bloom data, it is sufficient to traverse the
'->base_graph' pointer until either (1) a non-null 'struct
bloom_filter_settings *' is found, or (2) until we are at the root of
the commit-graph chain.

Introduce a 'get_bloom_filter_settings()' function that does just this,
and use it instead of purely dereferencing the top-most graph's
'->bloom_filter_settings' pointer.

While we're at it, add an additional test in t5324 to guard against code
in the commit-graph writing machinery that doesn't correctly handle a
NULL 'struct bloom_filter *'.

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 blame.c                       |  6 ++++--
 bloom.c                       |  6 +++---
 commit-graph.c                | 11 +++++++++++
 commit-graph.h                |  2 ++
 revision.c                    |  5 +----
 t/t4216-log-bloom.sh          |  9 ++++++---
 t/t5324-split-commit-graph.sh | 13 +++++++++++++
 7 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/blame.c b/blame.c
index 82fa16d658..3e5f8787bc 100644
--- a/blame.c
+++ b/blame.c
@@ -2891,16 +2891,18 @@ void setup_blame_bloom_data(struct blame_scoreboard *sb,
 			    const char *path)
 {
 	struct blame_bloom_data *bd;
+	struct bloom_filter_settings *bs;
 
 	if (!sb->repo->objects->commit_graph)
 		return;
 
-	if (!sb->repo->objects->commit_graph->bloom_filter_settings)
+	bs = get_bloom_filter_settings(sb->repo);
+	if (!bs)
 		return;
 
 	bd = xmalloc(sizeof(struct blame_bloom_data));
 
-	bd->settings = sb->repo->objects->commit_graph->bloom_filter_settings;
+	bd->settings = bs;
 
 	bd->alloc = 4;
 	bd->nr = 0;
diff --git a/bloom.c b/bloom.c
index 1a573226e7..cd9380ac62 100644
--- a/bloom.c
+++ b/bloom.c
@@ -38,7 +38,7 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
 	while (graph_pos < g->num_commits_in_base)
 		g = g->base_graph;
 
-	/* The commit graph commit 'c' lives in doesn't carry bloom filters. */
+	/* The commit graph commit 'c' lives in doesn't carry Bloom filters. */
 	if (!g->chunk_bloom_indexes)
 		return 0;
 
@@ -195,8 +195,8 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	if (!filter->data) {
 		load_commit_graph_info(r, c);
 		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH &&
-			r->objects->commit_graph->chunk_bloom_indexes)
-			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
+			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
+				return filter;
 	}
 
 	if (filter->data)
diff --git a/commit-graph.c b/commit-graph.c
index e51c91dd5b..d4b06811be 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -660,6 +660,17 @@ int generation_numbers_enabled(struct repository *r)
 	return !!first_generation;
 }
 
+struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
+{
+	struct commit_graph *g = r->objects->commit_graph;
+	while (g) {
+		if (g->bloom_filter_settings)
+			return g->bloom_filter_settings;
+		g = g->base_graph;
+	}
+	return NULL;
+}
+
 static void close_commit_graph_one(struct commit_graph *g)
 {
 	if (!g)
diff --git a/commit-graph.h b/commit-graph.h
index 09a97030dc..0677dd1031 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -87,6 +87,8 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size);
  */
 int generation_numbers_enabled(struct repository *r);
 
+struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
+
 enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
diff --git a/revision.c b/revision.c
index 6de29cdf7a..c45ed1076e 100644
--- a/revision.c
+++ b/revision.c
@@ -681,10 +681,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 
 	repo_parse_commit(revs->repo, revs->commits->item);
 
-	if (!revs->repo->objects->commit_graph)
-		return;
-
-	revs->bloom_filter_settings = revs->repo->objects->commit_graph->bloom_filter_settings;
+	revs->bloom_filter_settings = get_bloom_filter_settings(revs->repo);
 	if (!revs->bloom_filter_settings)
 		return;
 
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c21cc160f3..c9f9bdf1ba 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -60,7 +60,7 @@ setup () {
 
 test_bloom_filters_used () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":0,\"maybe\""
+	bloom_trace_prefix="statistics:{\"filter_not_present\":${2:-0},\"maybe\""
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom &&
@@ -134,8 +134,11 @@ test_expect_success 'setup - add commit-graph to the chain without Bloom filters
 	test_line_count = 2 .git/objects/info/commit-graphs/commit-graph-chain
 '
 
-test_expect_success 'Do not use Bloom filters if the latest graph does not have Bloom filters.' '
-	test_bloom_filters_not_used "-- A/B"
+test_expect_success 'use Bloom filters even if the latest graph does not have Bloom filters' '
+	# Ensure that the number of empty filters is equal to the number of
+	# filters in the latest graph layer to prove that they are loaded (and
+	# ignored).
+	test_bloom_filters_used "-- A/B" 3
 '
 
 test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 9b850ea907..5bdfd53ef9 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -425,4 +425,17 @@ done <<\EOF
 0600 -r--------
 EOF
 
+test_expect_success '--split=replace with partial Bloom data' '
+	rm -rf $graphdir $infodir/commit-graph &&
+	git reset --hard commits/3 &&
+	git rev-list -1 HEAD~2 >a &&
+	git rev-list -1 HEAD~1 >b &&
+	git commit-graph write --split=no-merge --stdin-commits --changed-paths <a &&
+	git commit-graph write --split=no-merge --stdin-commits <b &&
+	git commit-graph write --split=replace --stdin-commits --changed-paths <c &&
+	ls $graphdir/graph-*.graph >graph-files &&
+	test_line_count = 1 graph-files &&
+	verify_chain_files_exist $graphdir
+'
+
 test_done
-- 
2.28.0.rc1.13.ge78abce653

