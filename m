Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DDDC2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776FC23DC1
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxHYhA4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgDFRAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:13 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:34299 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgDFRAL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:11 -0400
Received: by mail-ed1-f44.google.com with SMTP id o1so413182edv.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=UMGJmkbsrjpxKULyJuJ+crf4sLy929KNZgSw5qQfemc=;
        b=NxHYhA4ZmXhXKA9pgExOz6B/CPXjwStfS+A5t8BHas87rcbLLOPpBO1l6rW1DiVB0n
         tbmZzKgBhl4JsBL5lemNqM5gzVHIPAJgZtSXoDSqX8PU3NpIjSzxTnwGN7T/ICPP+a30
         FKw5JpLiGwXeF3C5Fou+nFxnBSm3ZdAH2gACISbANGG2e5zhPgyqDAP/UCj2Ez0Z4UKm
         Z8S8trKgDR3ElxeexeX2cjfy+Xlj0D62R124YwcDRjjyjxEgt9HyFufsYH6yf3FtPNPG
         wM469wAHUav9npzbQN/uBROpVYDDbvWZwke+UH3UOKPcIXdWp6mEl9nUAzfbTLBH2OeE
         CFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=UMGJmkbsrjpxKULyJuJ+crf4sLy929KNZgSw5qQfemc=;
        b=EzayQer6Ppp/BVf9vrUGU/ZQTqCezHKedqQ+GQWwHr64wqUEKkFMS15Vr0jmKGyiT5
         I2qjLmbmsj/na5A/7G1/bLxJPD+HekEnPwzEcTZAiNICwcoWYvfNgOLE/Chvejw8CLN8
         POMosAtxsFmyA2VBo9kqM4JJVrWy203GA2ap+HLxI//eJ3vESiU59SvU/qmqwZdg68IM
         WVO7wzp0DTWP/0cxonsnHQ4FSnO3cLDYqjQyRFVdWTniOyp1TZpOt+eRuqk3i5S7pSIn
         SB4yFnSmSdczjWJgkQSuVMCwIpgYClB1FlkkS7zKadvrZ1Ddbnb2L4JRaDOHfon+2fzJ
         MsZw==
X-Gm-Message-State: AGi0PuYPXNMcglxoU9y5EexB+GFDZHytxvN6bb1n6G0WsxgwRvX0TRne
        eFBxzyon/y/JFIScZHCbbg6C7f81
X-Google-Smtp-Source: APiQypK+v9JajQnqiZSIx/e7Pskk4ckqDbjHvtSWywsei/lMJB42HN0VMwaGPQMt9oGlfjNjquZpOA==
X-Received: by 2002:a17:906:8689:: with SMTP id g9mr398413ejx.345.1586192406038;
        Mon, 06 Apr 2020 10:00:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p25sm3053001ejw.49.2020.04.06.10.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:00:05 -0700 (PDT)
Message-Id: <617f549ef259424658a84dd67a98685328f6b850.1586192395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:52 +0000
Subject: [PATCH v4 12/15] revision.c: use Bloom filters to speed up path based
 revision walks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Revision walk will now use Bloom filters for commits to speed up
revision walks for a particular path (for computing history for
that path), if they are present in the commit-graph file.

We load the Bloom filters during the prepare_revision_walk step,
currently only when dealing with a single pathspec. Extending
it to work with multiple pathspecs can be explored and built on
top of this series in the future.

While comparing trees in rev_compare_trees(), if the Bloom filter
says that the file is not different between the two trees, we don't
need to compute the expensive diff. This is where we get our
performance gains. The other response of the Bloom filter is '`:maybe',
in which case we fall back to the full diff calculation to determine
if the path was changed in the commit.

We do not try to use Bloom filters when the '--walk-reflogs' option
is specified. The '--walk-reflogs' option does not walk the commit
ancestry chain like the rest of the options. Incorporating the
performance gains when walking reflog entries would add more
complexity, and can be explored in a later series.

Performance Gains:
We tested the performance of `git log -- <path>` on the git repo, the linux
and some internal large repos, with a variety of paths of varying depths.

On the git and linux repos:
- we observed a 2x to 5x speed up.

On a large internal repo with files seated 6-10 levels deep in the tree:
- we observed 10x to 20x speed ups, with some paths going up to 28 times
  faster.

Helped-by: Derrick Stolee <dstolee@microsoft.com
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 bloom.c    | 20 +++++++++++++
 bloom.h    |  4 +++
 revision.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 revision.h | 11 +++++++
 4 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/bloom.c b/bloom.c
index 0f714dd76ae..c5b461d1cfe 100644
--- a/bloom.c
+++ b/bloom.c
@@ -253,3 +253,23 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	return filter;
 }
+
+int bloom_filter_contains(const struct bloom_filter *filter,
+			  const struct bloom_key *key,
+			  const struct bloom_filter_settings *settings)
+{
+	int i;
+	uint64_t mod = filter->len * BITS_PER_WORD;
+
+	if (!mod)
+		return -1;
+
+	for (i = 0; i < settings->num_hashes; i++) {
+		uint64_t hash_mod = key->hashes[i] % mod;
+		uint64_t block_pos = hash_mod / BITS_PER_WORD;
+		if (!(filter->data[block_pos] & get_bitmask(hash_mod)))
+			return 0;
+	}
+
+	return 1;
+}
\ No newline at end of file
diff --git a/bloom.h b/bloom.h
index 760d7122374..b935186425d 100644
--- a/bloom.h
+++ b/bloom.h
@@ -83,4 +83,8 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 				      struct commit *c,
 				      int compute_if_not_present);
 
+int bloom_filter_contains(const struct bloom_filter *filter,
+			  const struct bloom_key *key,
+			  const struct bloom_filter_settings *settings);
+
 #endif
\ No newline at end of file
diff --git a/revision.c b/revision.c
index 8136929e236..d3fcb7c6ff6 100644
--- a/revision.c
+++ b/revision.c
@@ -29,6 +29,7 @@
 #include "prio-queue.h"
 #include "hashmap.h"
 #include "utf8.h"
+#include "bloom.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -624,11 +625,80 @@ static void file_change(struct diff_options *options,
 	options->flags.has_changes = 1;
 }
 
+static void prepare_to_use_bloom_filter(struct rev_info *revs)
+{
+	struct pathspec_item *pi;
+	char *path_alloc = NULL;
+	const char *path;
+	int last_index;
+	int len;
+
+	if (!revs->commits)
+	    return;
+
+	repo_parse_commit(revs->repo, revs->commits->item);
+
+	if (!revs->repo->objects->commit_graph)
+		return;
+
+	revs->bloom_filter_settings = revs->repo->objects->commit_graph->bloom_filter_settings;
+	if (!revs->bloom_filter_settings)
+		return;
+
+	pi = &revs->pruning.pathspec.items[0];
+	last_index = pi->len - 1;
+
+	/* remove single trailing slash from path, if needed */
+	if (pi->match[last_index] == '/') {
+	    path_alloc = xstrdup(pi->match);
+	    path_alloc[last_index] = '\0';
+	    path = path_alloc;
+	} else
+	    path = pi->match;
+
+	len = strlen(path);
+
+	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
+	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
+
+	free(path_alloc);
+}
+
+static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
+						 struct commit *commit)
+{
+	struct bloom_filter *filter;
+	int result;
+
+	if (!revs->repo->objects->commit_graph)
+		return -1;
+
+	if (commit->generation == GENERATION_NUMBER_INFINITY)
+		return -1;
+
+	filter = get_bloom_filter(revs->repo, commit, 0);
+
+	if (!filter) {
+		return -1;
+	}
+
+	if (!filter->len) {
+		return -1;
+	}
+
+	result = bloom_filter_contains(filter,
+				       revs->bloom_key,
+				       revs->bloom_filter_settings);
+
+	return result;
+}
+
 static int rev_compare_tree(struct rev_info *revs,
-			    struct commit *parent, struct commit *commit)
+			    struct commit *parent, struct commit *commit, int nth_parent)
 {
 	struct tree *t1 = get_commit_tree(parent);
 	struct tree *t2 = get_commit_tree(commit);
+	int bloom_ret = 1;
 
 	if (!t1)
 		return REV_TREE_NEW;
@@ -653,11 +723,19 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
+	if (revs->bloom_key && !nth_parent) {
+		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
+
+		if (bloom_ret == 0)
+			return REV_TREE_SAME;
+	}
+
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
 	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
+
 	return tree_difference;
 }
 
@@ -855,7 +933,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			die("cannot simplify commit %s (because of %s)",
 			    oid_to_hex(&commit->object.oid),
 			    oid_to_hex(&p->object.oid));
-		switch (rev_compare_tree(revs, p, commit)) {
+		switch (rev_compare_tree(revs, p, commit, nth_parent)) {
 		case REV_TREE_SAME:
 			if (!revs->simplify_history || !relevant_commit(p)) {
 				/* Even if a merge with an uninteresting
@@ -3362,6 +3440,8 @@ int prepare_revision_walk(struct rev_info *revs)
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
+	if (revs->pruning.pathspec.nr == 1 && !revs->reflog_info)
+		prepare_to_use_bloom_filter(revs);
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
@@ -3379,6 +3459,7 @@ int prepare_revision_walk(struct rev_info *revs)
 		simplify_merges(revs);
 	if (revs->children.name)
 		set_children(revs);
+
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index 475f048fb61..7c026fe41fc 100644
--- a/revision.h
+++ b/revision.h
@@ -56,6 +56,8 @@ struct repository;
 struct rev_info;
 struct string_list;
 struct saved_parents;
+struct bloom_key;
+struct bloom_filter_settings;
 define_shared_commit_slab(revision_sources, char *);
 
 struct rev_cmdline_info {
@@ -291,6 +293,15 @@ struct rev_info {
 	struct revision_sources *sources;
 
 	struct topo_walk_info *topo_walk_info;
+
+	/* Commit graph bloom filter fields */
+	/* The bloom filter key for the pathspec */
+	struct bloom_key *bloom_key;
+	/*
+	 * The bloom filter settings used to generate the key.
+	 * This is loaded from the commit-graph being used.
+	 */
+	struct bloom_filter_settings *bloom_filter_settings;
 };
 
 int ref_excluded(struct string_list *, const char *path);
-- 
gitgitgadget

