Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588B20B35
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442952; cv=none; b=XPJQwEcsr+KAWGJzOKH2TjNEYvQDcDwRB1Chp18XR8cye8VGSgQFn6Mj32d09XUGbg3M6Q3JYCuMLX/40zhXGmvjkbVGzOV6VgbcQ5ZLum5UJhrThj3hm964vL6AtSbvqqAqgJIW859e/v2bDEV2xJpjaB83BweumnbnE+RTtTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442952; c=relaxed/simple;
	bh=W3g1coO4XrHXlj+TtIyfLqDZyhQ1zbjoKSqww7KFqMU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=A4One6LF5uXxYqqXmXvN8d6K4xoyiyGFLjsVIMlq+e/e6hOGQpyfbeK5EbhijA7qn8NR/f8dqoirmI8OZR9WaZuzElYmBLtYG5FDnWwqZuSP5VSYvKDXmD6qfIzhAvlw5Yy1TBXw3zw/Ch7bIM9BcrTWySJlSEVIhmCWI/GVryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ViOnmTxx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ViOnmTxx"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5f0c0ca5ef1so101846637b3.2
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442950; x=1706047750; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HmBKDFIyiLwCv3D+Rmc4vI3oa2PvVVFnnjge3s7QzNI=;
        b=ViOnmTxx7uoYp5fJ18rsDsIFC27I12mDcMilhb2zYM3ZJbmmvLGz0LeozkgSzvaUtS
         m4tBcWzHzPePJtv6kVguEPeDN4m5LPv9T8dSZ9HM+QMcyDGB5Bwfy3cS5IrF3dIh/DRQ
         IE2KxcH7K2gPPyF4JJyy4S3qZreDRVFQiG/SpB7jHEy75BXBHfy9ncmcciKWEe7k8KO5
         vKG2NDY5rDv8Zo6xFg6TIOHPbDS/RnDR6vCY6ECsVKZf4rYdzLD5g5gAFP4ZBDtBynOh
         djl+QbKT3NUBpKmkjYAZDOKU2cIOW05ZId6yLCl9iDdq9SSq74SnfKuwEja/nb2l7wgN
         qgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442950; x=1706047750;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmBKDFIyiLwCv3D+Rmc4vI3oa2PvVVFnnjge3s7QzNI=;
        b=mGdDA7tWBp4h7GebryXiHzC72KZGLfyPZA6TCm9BxjqKFRqaEdXKYzyWuE2qw6nVAQ
         JS6q5rjqD/aVu61vO9MgY/yEAIuwMb47BV6o7ISt0RsDTHYOmLsN0UA32xJfCdoyNwaI
         KrMkwB67TOTXjI6WvDGeoyNRBJTO7mHD1kAvkyfRDfmiaDN1WsbwYdaAMlUECvkBo/Ea
         i9C1OALkSrIDs1kzy0pn/9iiwLsieksrOMaOC06fLxCqGEH06GhrmZAmsVd3M2V6AAej
         imDeZY1GoHcQ0Mh30L3vwwLf876A59su/o7B3fKw4uVG6fvO4OuBIpzq5Ft1OvwkM+qN
         JxXg==
X-Gm-Message-State: AOJu0Yw06QYZvADlrb8IGga0y7d7SGIXpi5LVXh5wKl31wTMNDzyfuoZ
	vMCci/D0rRagq5MjwRm3g27bfkt06U7byUM1uDimTIH15HzWLw==
X-Google-Smtp-Source: AGHT+IFcQXwg7QbSi5+qNAuv59OYH+yG3HO1t5zPPIP+kdEbST043u+HHXUnDf9WgcbLm+Wkptu0nA==
X-Received: by 2002:a81:d101:0:b0:5f2:852b:3d08 with SMTP id w1-20020a81d101000000b005f2852b3d08mr5816293ywi.33.1705442950012;
        Tue, 16 Jan 2024 14:09:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p15-20020a0cf68f000000b006817850b81esm346249qvn.136.2024.01.16.14.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:09 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:08 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 02/17] revision.c: consult Bloom filters for root commits
Message-ID: <8f32fd5f460accd07f0d8c0a63f1a4580817a341.1705442923.git.me@ttaylorr.com>
References: <cover.1697653929.git.me@ttaylorr.com>
 <cover.1705442923.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1705442923.git.me@ttaylorr.com>

The commit-graph stores changed-path Bloom filters which represent the
set of paths included in a tree-level diff between a commit's root tree
and that of its parent.

When a commit has no parents, the tree-diff is computed against that
commit's root tree and the empty tree. In other words, every path in
that commit's tree is stored in the Bloom filter (since they all appear
in the diff).

Consult these filters during pathspec-limited traversals in the function
`rev_same_tree_as_empty()`. Doing so yields a performance improvement
where we can avoid enumerating the full set of paths in a parentless
commit's root tree when we know that the path(s) of interest were not
listed in that commit's changed-path Bloom filter.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Original-patch-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 revision.c           | 26 ++++++++++++++++++++++----
 t/t4216-log-bloom.sh |  8 ++++++--
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 2424c9bd67..0e6f7d02b6 100644
--- a/revision.c
+++ b/revision.c
@@ -833,17 +833,28 @@ static int rev_compare_tree(struct rev_info *revs,
 	return tree_difference;
 }
 
-static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
+static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit,
+				  int nth_parent)
 {
 	struct tree *t1 = repo_get_commit_tree(the_repository, commit);
+	int bloom_ret = -1;
 
 	if (!t1)
 		return 0;
 
+	if (!nth_parent && revs->bloom_keys_nr) {
+		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
+		if (!bloom_ret)
+			return 1;
+	}
+
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
 	diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
 
+	if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
+		count_bloom_filter_false_positive++;
+
 	return tree_difference == REV_TREE_SAME;
 }
 
@@ -881,7 +892,7 @@ static int compact_treesame(struct rev_info *revs, struct commit *commit, unsign
 		if (nth_parent != 0)
 			die("compact_treesame %u", nth_parent);
 		old_same = !!(commit->object.flags & TREESAME);
-		if (rev_same_tree_as_empty(revs, commit))
+		if (rev_same_tree_as_empty(revs, commit, nth_parent))
 			commit->object.flags |= TREESAME;
 		else
 			commit->object.flags &= ~TREESAME;
@@ -977,7 +988,14 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		return;
 
 	if (!commit->parents) {
-		if (rev_same_tree_as_empty(revs, commit))
+		/*
+		 * Pretend as if we are comparing ourselves to the
+		 * (non-existent) first parent of this commit object. Even
+		 * though no such parent exists, its changed-path Bloom filter
+		 * (if one exists) is relative to the empty tree, using Bloom
+		 * filters is allowed here.
+		 */
+		if (rev_same_tree_as_empty(revs, commit, 0))
 			commit->object.flags |= TREESAME;
 		return;
 	}
@@ -1058,7 +1076,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 
 		case REV_TREE_NEW:
 			if (revs->remove_empty_trees &&
-			    rev_same_tree_as_empty(revs, p)) {
+			    rev_same_tree_as_empty(revs, p, nth_parent)) {
 				/* We are adding all the specified
 				 * paths from this parent, so the
 				 * history beyond this parent is not
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index b7baf49d62..cc6ebc8140 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -88,7 +88,11 @@ test_bloom_filters_not_used () {
 		# if the Bloom filter system is initialized, ensure that no
 		# filters were used
 		data="statistics:{"
-		data="$data\"filter_not_present\":0,"
+		# unusable filters (e.g., those computed with a
+		# different value of commitGraph.changedPathsVersion)
+		# are counted in the filter_not_present bucket, so any
+		# value is OK there.
+		data="$data\"filter_not_present\":[0-9][0-9]*,"
 		data="$data\"maybe\":0,"
 		data="$data\"definitely_not\":0,"
 		data="$data\"false_positive\":0}"
@@ -175,7 +179,7 @@ test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
 
 test_bloom_filters_used_when_some_filters_are_missing () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":9"
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":10"
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom
-- 
2.43.0.334.gd4dbce1db5.dirty

