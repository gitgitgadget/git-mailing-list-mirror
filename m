Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B44C64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 17:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCJRVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 12:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjCJRVV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 12:21:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6191135DF
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:21:12 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l25so5739541wrb.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678468871;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la3U/fwHpOlIwZmwJOB9ELAPfrLEieX0SmKqKcs4bmQ=;
        b=knfLgBP0bDhGwwaJePl+zwBUNXoc4nZUI+PORYraMkK1bHM+lgELLzAo0yy2F7ioaW
         wA5MoIF4bro0HgVF9yFZMyx8QRr4yET3xEnxAQqVf8yT7DWeEyyzzi6L4tUah0Uy8s02
         P8SsGR1k0mdr2l3lNcWZtHwlUcUSEvZgUpRg5d7cbpegR303jVrbl2dZR+xorEh7Eh91
         gkbOUfffY76gJi3J/JvbCAuZQvH/IQXASCfab1ZE4h2U5+ePXbLJv9MmvmbzSOhJwwq4
         KMvN+opU+gDriEXcWw3jbxDoYVuM+x2iMmTlKPzh/JJeUpxC+XrlcPU6gD//++FmLdzL
         OUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678468871;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la3U/fwHpOlIwZmwJOB9ELAPfrLEieX0SmKqKcs4bmQ=;
        b=SLyF4NYYwbpNoUqKXHu9Txqd/L4kzJ2rao4q1FAxA3Nh/Mzy0g/thLmYeRdoyzKiQs
         SkjmQSgy4mLrqJSAyC5GgcPxyVuHHZwLeyY6o2jhvoLGTqucmUeI8+SFAKDOIngBoeFN
         aS2JsJr35RVezqLA/syttcPz5Z1oWnwb09LIB79MGMshFcnKm3OaWGL9/vg1YnfMNhl2
         9Rlz1aDdopTmI92FWsaqArFEcIZxFqQ0s+M+AB9qsiiJF82k9Qw+fbjqYpOK1drQpFu/
         XgTavF0mDMBQ+Sks0OL2ewOCep5Y82S0RhHgLK95IhYjGdO42B5pT+W8qsgIRp9Eivbw
         lXAA==
X-Gm-Message-State: AO0yUKWSHXXjCUb/XqeaNAVOZBpbSta4HjHWbmSrFRNp2182FvYg1LZf
        OgmL2WvCJqX5u65Ko7pz5QLl7hWkkT0=
X-Google-Smtp-Source: AK7set8eg/UIQ9PDxETDOILllvycQbZDwADHB7uchyf/HcbHioNh0hCT7PckwvBF+M4h4jrvxWKoRQ==
X-Received: by 2002:adf:dd8b:0:b0:2c7:62c1:f09c with SMTP id x11-20020adfdd8b000000b002c762c1f09cmr15669464wrl.50.1678468871040;
        Fri, 10 Mar 2023 09:21:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15-20020a5d488f000000b002c559843748sm331434wrq.10.2023.03.10.09.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:21:10 -0800 (PST)
Message-Id: <f3fb6833bd71d559a3076d9617a235614ad9a5f8.1678468864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Mar 2023 17:21:03 +0000
Subject: [PATCH v2 8/8] commit-reach: add tips_reachable_from_bases()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Both 'git for-each-ref --merged=<X>' and 'git branch --merged=<X>' use
the ref-filter machinery to select references or branches (respectively)
that are reachable from a set of commits presented by one or more
--merged arguments. This happens within reach_filter(), which uses the
revision-walk machinery to walk history in a standard way.

However, the commit-reach.c file is full of custom searches that are
more efficient, especially for reachability queries that can terminate
early when reachability is discovered. Add a new
tips_reachable_from_bases() method to commit-reach.c and call it from
within reach_filter() in ref-filter.c. This affects both 'git branch'
and 'git for-each-ref' as tested in p1500-graph-walks.sh.

For the Linux kernel repository, we take an already-fast algorithm and
make it even faster:

Test                                            HEAD~1  HEAD
-------------------------------------------------------------------
1500.5: contains: git for-each-ref --merged     0.13    0.02 -84.6%
1500.6: contains: git branch --merged           0.14    0.02 -85.7%
1500.7: contains: git tag --merged              0.15    0.03 -80.0%

(Note that we remove the iterative 'git rev-list' test from p1500
because it no longer makes sense as a comparison to 'git for-each-ref'
and would just waste time running it for these comparisons.)

The algorithm is implemented in commit-reach.c in the method
tips_reachable_from_base(). This method takes a string_list of tips and
assigns the 'util' for each item with the value 1 if the base commit can
reach those tips.

Like other reachability queries in commit-reach.c, the fastest way to
search for "can A reach B?" is to do a depth-first search up to the
generation number of B, preferring to explore first parents before later
parents. While we must walk all reachable commits up to that generation
number when the answer is "no", the depth-first search can answer "yes"
much faster than other approaches in most cases.

This search becomes trickier when there are multiple targets for the
depth-first search. The commits with lower generation number are more
likely to be within the history of the start commit, but we don't want
to waste time searching commits of low generation number if the commit
target with lowest generation number has already been found.

The trick here is to take the input commits and sort them by generation
number in ascending order. Track the index within this order as
min_generation_index. When we find a commit, if its index in the list is
equal to min_generation_index, then we can increase the generation
number boundary of our search to the next-lowest value in the list.

With this mechanism, the number of commits to search is minimized with
respect to the depth-first search heuristic. We will walk all commits up
to the minimum generation number of a commit that is _not_ reachable
from the start, but we will walk only the necessary portion of the
depth-first search for the reachable commits of lower generation.

Add extra tests for this behavior in t6600-test-reach.sh as the
interesting data shape of that repository can sometimes demonstrate
corner case bugs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-reach.c              | 114 ++++++++++++++++++++++++++++++++++++
 commit-reach.h              |   8 +++
 ref-filter.c                |  19 +-----
 t/perf/p1500-graph-walks.sh |  15 +++--
 t/t6600-test-reach.sh       |  83 ++++++++++++++++++++++++++
 5 files changed, 218 insertions(+), 21 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 338ca8084b2..f6c4a3c93c7 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1037,3 +1037,117 @@ void ahead_behind(struct commit **commits, size_t commits_nr,
 	clear_bit_arrays(&bit_arrays);
 	clear_prio_queue(&queue);
 }
+
+struct commit_and_index {
+	struct commit *commit;
+	unsigned int index;
+	timestamp_t generation;
+};
+
+static int compare_commit_and_index_by_generation(const void *va, const void *vb)
+{
+	const struct commit_and_index *a = (const struct commit_and_index *)va;
+	const struct commit_and_index *b = (const struct commit_and_index *)vb;
+
+	if (a->generation > b->generation)
+		return 1;
+	if (a->generation < b->generation)
+		return -1;
+	return 0;
+}
+
+void tips_reachable_from_bases(struct commit_list *bases,
+			       struct commit **tips, size_t tips_nr,
+			       int mark)
+{
+	size_t i;
+	struct commit_and_index *commits;
+	unsigned int min_generation_index = 0;
+	timestamp_t min_generation;
+	struct commit_list *stack = NULL;
+
+	if (!bases || !tips || !tips_nr)
+		return;
+
+	/*
+	 * Do a depth-first search starting at 'bases' to search for the
+	 * tips. Stop at the lowest (un-found) generation number. When
+	 * finding the lowest commit, increase the minimum generation
+	 * number to the next lowest (un-found) generation number.
+	 */
+
+	CALLOC_ARRAY(commits, tips_nr);
+
+	for (i = 0; i < tips_nr; i++) {
+		commits[i].commit = tips[i];
+		commits[i].index = i;
+		commits[i].generation = commit_graph_generation(tips[i]);
+	}
+
+	/* Sort with generation number ascending. */
+	QSORT(commits, tips_nr, compare_commit_and_index_by_generation);
+	min_generation = commits[0].generation;
+
+	while (bases) {
+		parse_commit(bases->item);
+		commit_list_insert(bases->item, &stack);
+		bases = bases->next;
+	}
+
+	while (stack) {
+		unsigned int j;
+		int explored_all_parents = 1;
+		struct commit_list *p;
+		struct commit *c = stack->item;
+		timestamp_t c_gen = commit_graph_generation(c);
+
+		/* Does it match any of our tips? */
+		for (j = min_generation_index; j < tips_nr; j++) {
+			if (c_gen < commits[j].generation)
+				break;
+
+			if (commits[j].commit == c) {
+				tips[commits[j].index]->object.flags |= mark;
+
+				if (j == min_generation_index) {
+					unsigned int k = j + 1;
+					while (k < tips_nr &&
+					       (tips[commits[k].index]->object.flags & mark))
+						k++;
+
+					/* Terminate early if all found. */
+					if (k >= tips_nr)
+						goto done;
+
+					min_generation_index = k;
+					min_generation = commits[k].generation;
+				}
+			}
+		}
+
+		for (p = c->parents; p; p = p->next) {
+			parse_commit(p->item);
+
+			/* Have we already explored this parent? */
+			if (p->item->object.flags & SEEN)
+				continue;
+
+			/* Is it below the current minimum generation? */
+			if (commit_graph_generation(p->item) < min_generation)
+				continue;
+
+			/* Ok, we will explore from here on. */
+			p->item->object.flags |= SEEN;
+			explored_all_parents = 0;
+			commit_list_insert(p->item, &stack);
+			break;
+		}
+
+		if (explored_all_parents)
+			pop_commit(&stack);
+	}
+
+done:
+	free(commits);
+	repo_clear_commit_marks(the_repository, SEEN);
+}
diff --git a/commit-reach.h b/commit-reach.h
index f871b5dcce9..14043ed8562 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -134,4 +134,12 @@ struct ahead_behind_count {
 void ahead_behind(struct commit **commits, size_t commits_nr,
 		  struct ahead_behind_count *counts, size_t counts_nr);
 
+/*
+ * For all tip commits, add 'mark' to their flags if and only if they
+ * are reachable from one of the commits in 'bases'.
+ */
+void tips_reachable_from_bases(struct commit_list *bases,
+			       struct commit **tips, size_t tips_nr,
+			       int mark);
+
 #endif
diff --git a/ref-filter.c b/ref-filter.c
index 896bf703f59..ece77d7e8ba 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2390,33 +2390,21 @@ static void reach_filter(struct ref_array *array,
 			 struct commit_list *check_reachable,
 			 int include_reached)
 {
-	struct rev_info revs;
 	int i, old_nr;
 	struct commit **to_clear;
-	struct commit_list *cr;
 
 	if (!check_reachable)
 		return;
 
 	CALLOC_ARRAY(to_clear, array->nr);
-
-	repo_init_revisions(the_repository, &revs, NULL);
-
 	for (i = 0; i < array->nr; i++) {
 		struct ref_array_item *item = array->items[i];
-		add_pending_object(&revs, &item->commit->object, item->refname);
 		to_clear[i] = item->commit;
 	}
 
-	for (cr = check_reachable; cr; cr = cr->next) {
-		struct commit *merge_commit = cr->item;
-		merge_commit->object.flags |= UNINTERESTING;
-		add_pending_object(&revs, &merge_commit->object, "");
-	}
-
-	revs.limited = 1;
-	if (prepare_revision_walk(&revs))
-		die(_("revision walk setup failed"));
+	tips_reachable_from_bases(check_reachable,
+				  to_clear, array->nr,
+				  UNINTERESTING);
 
 	old_nr = array->nr;
 	array->nr = 0;
@@ -2440,7 +2428,6 @@ static void reach_filter(struct ref_array *array,
 		clear_commit_marks(merge_commit, ALL_REV_FLAGS);
 	}
 
-	release_revisions(&revs);
 	free(to_clear);
 }
 
diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
index 439a448c2e6..e14e7620cce 100755
--- a/t/perf/p1500-graph-walks.sh
+++ b/t/perf/p1500-graph-walks.sh
@@ -35,11 +35,16 @@ test_perf 'ahead-behind counts: git tag' '
 	xargs git tag -l --format="%(ahead-behind:HEAD)" <tags
 '
 
-test_perf 'ahead-behind counts: git rev-list' '
-	for r in $(cat refs)
-	do
-		git rev-list --count "HEAD..$r" || return 1
-	done
+test_perf 'contains: git for-each-ref --merged' '
+	git for-each-ref --merged=HEAD --stdin <refs
+'
+
+test_perf 'contains: git branch --merged' '
+	xargs git branch --merged=HEAD <branches
+'
+
+test_perf 'contains: git tag --merged' '
+	xargs git tag --merged=HEAD <tags
 '
 
 test_done
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 0cb50797ef7..b330945f497 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -529,4 +529,87 @@ test_expect_success 'for-each-ref ahead-behind:none' '
 		--format="%(refname) %(ahead-behind:commit-8-4)" --stdin
 '
 
+test_expect_success 'for-each-ref merged:linear' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-1-3
+	refs/heads/commit-1-5
+	refs/heads/commit-1-8
+	refs/heads/commit-2-1
+	refs/heads/commit-5-1
+	refs/heads/commit-9-1
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-1-3
+	refs/heads/commit-1-5
+	refs/heads/commit-1-8
+	EOF
+	run_all_modes git for-each-ref --merged=commit-1-9 \
+		--format="%(refname)" --stdin
+'
+
+test_expect_success 'for-each-ref merged:all' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-2-4
+	refs/heads/commit-4-2
+	refs/heads/commit-4-4
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-2-4
+	refs/heads/commit-4-2
+	refs/heads/commit-4-4
+	EOF
+	run_all_modes git for-each-ref --merged=commit-5-5 \
+		--format="%(refname)" --stdin
+'
+
+test_expect_success 'for-each-ref ahead-behind:some' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-5-3
+	refs/heads/commit-4-8
+	refs/heads/commit-9-9
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-5-3
+	EOF
+	run_all_modes git for-each-ref --merged=commit-9-6 \
+		--format="%(refname)" --stdin
+'
+
+test_expect_success 'for-each-ref merged:some, multibase' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-5-3
+	refs/heads/commit-7-8
+	refs/heads/commit-4-8
+	refs/heads/commit-9-9
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-4-8
+	refs/heads/commit-5-3
+	EOF
+	run_all_modes git for-each-ref \
+		--merged=commit-5-8 \
+		--merged=commit-8-5 \
+		--format="%(refname)" \
+		--stdin
+'
+
+test_expect_success 'for-each-ref merged:none' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-7-5
+	refs/heads/commit-4-8
+	refs/heads/commit-9-9
+	EOF
+	>expect &&
+	run_all_modes git for-each-ref --merged=commit-8-4 \
+		--format="%(refname)" --stdin
+'
+
 test_done
-- 
gitgitgadget
