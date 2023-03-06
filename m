Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA31C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 14:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjCFOID (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjCFOHT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 09:07:19 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF112311E
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 06:06:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so5256396wmi.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 06:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678111604;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUZvW498oqoG37gd40FZPqaVzzvaAQQ1q00K/CTZo8I=;
        b=lWjix4YPbJsKll2ai0zEuVqt06OLjFvfZx8PlS6fgZSO6qDD5aYvyfnDcOYj8cP1Yr
         QhnE/V51Exyibgo3FXQHqN0N1CpfmWZkFl96x3sDnQzKg9fkzQUIaJe0cTrZNdLZG7jw
         /SynEAwBpXmInA/dtAl+fyqZEMyvZty4x0kqWyEZ2O2Tx5hXXwN03Fnd31f31uZukR0L
         a4ZdOdkA/UKUXuCqHApwlcDOryaHQQQ706UvMdlS1vloMJEJ6MdHMtXVzS7DZILxJvQV
         pYOq56CN6sRCqo+qxvSH+9JcbZEPskwbCrhRVJOOtFgHilKptlaZp2wFTUFrXMnvb2vy
         5MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111604;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUZvW498oqoG37gd40FZPqaVzzvaAQQ1q00K/CTZo8I=;
        b=qFmO3jLOu+97owl62KsPipDUu3OPPxbpIT3ymd2SVPfS9MR2OiZaX6xHd/aP5uvflo
         asgUQUV2im02OVvBiheupuKvHBtCaVvm0pS9ALf8vTmS8QrVqw/u4UdOXux24CjoqVZT
         Tc9L1CYzl/8NniQ4L1/ThvXVsxPmZSrE7IPodjknb9wRKsyThb71zZkmV2i+2aj3BDcb
         CUQlhkYY60cBJpORo2jXhXi+A1hOQOJJKzjGbckrk8zd/HygCtfbxEqFbVIZ0MQQwrcr
         ypwMDCctn3fEFnwzOpUZt3w8zZ8KNdIaQfRn6phQJMPCPOI8PQM1slew1wsCaM9QKkyc
         taKQ==
X-Gm-Message-State: AO0yUKUTvsVNfZkc8z5fub41NHFfVq8tH32xoczp0b2WYkdSAVOFCXIp
        rqxvDlv9urcqB9dAFuFJqtKD/0qUt9s=
X-Google-Smtp-Source: AK7set9xLjWDXP3QgivLMHvG8M8THGpmdU7U2TP8y1sNJGZ5bRtu+4MrooeBeeEnQD6hcL9d3pqacQ==
X-Received: by 2002:a05:600c:1d2a:b0:3e1:374:8b66 with SMTP id l42-20020a05600c1d2a00b003e103748b66mr9249306wms.40.1678111604369;
        Mon, 06 Mar 2023 06:06:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003e209b45f6bsm15589470wmq.29.2023.03.06.06.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:06:44 -0800 (PST)
Message-Id: <b8c55ecf88d6229f13e05e8369adaf9e70ae1de0.1678111599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 14:06:37 +0000
Subject: [PATCH 7/8] ahead-behind: implement ahead_behind() logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Fully implement the commit-counting logic behind the ahead-behind
builtin as a new ahead_behind() method in commit-reach.h. Add tests
for the functionality in both t4218-ahead-behind.sh and
t6600-test-reach.sh. The tests in t4218 are rather simple, but cover a
simple diamond commit history completely while the tests in t6600 make
use of the more complicated commit history and the test setup to check
three repository states: no commit-graph, a complete commit-graph, and a
half-filled commit-graph. These extra states are particularly helpful to
check due to the implementation of ahead_behind() and how it relies upon
ensure_generations_valid().

The interface for ahead_behind() uses two arrays. The first array of
commits contains the list of all starting points for the walk. This
includes all tip commits _and_ base commits. The second array, using the
new ahead_behind_count struct, indicates which commits from that initial
array form the base/tip pair for the ahead/behind count it will store.

While the ahead-behind builtin currently only supports one base, this
implementation of ahead_behind() allows multiple bases, if desired. Even
with multiple bases, there is only one commit walk used for counting the
ahead/behind values, saving time when the base/tip ranges overlap
significantly.

This interface for ahead_behind() also makes it very easy to call
ensure_generations_valid() on the entire array of bases and tips. This
call is necessary because it is critical that the walk that counts
ahead/behind values never walks a commit more than once. Without
generation numbers on every commit, there is a possibility that a
commit date skew could cause the walk to revisit a commit and then
double-count it. For this reason, it is strongly recommended that 'git
ahead-behind' is only run in a repository with a commit-graph file that
covers most of the reachable commits, storing precomputed generation
numbers. If no commit-graph exists, this walk will be much slower as it
must walk all reachable commits in ensure_generations_valid() before
performing the counting logic.

It is possible to detect if generation numbers are available at run time
and redirect the implementation to another algorithm that does not
require this property. However, that implementation requires a commit
walk per base/tip pair _and_ can be slower due to the commit date
heuristics required. Such an implementation could be considered in the
future if there is a reason to include it, but most Git hosts should
already be generating a commit-graph file as part of repository
maintenance. Most Git clients should also be generating commit-graph
files as part of background maintenance or automatic GCs.

Now, let's discuss the ahead/behind counting algorithm.

Each commit in the input commit list is associated with a bit position
indicating "the ith commit can reach this commit". Each of these commits
is associated with a bitmap with its position flipped on and then
placed in a queue for walking commit history. We walk commits by popping
the commit with maximum generation number out of the queue, guaranteeing
that we will never walk a child of that commit in any future steps.

As we walk, we load the bitmap for the current commit and perform two
main steps. The _second_ step examines each parent of the current commit
and adds the current commit's bitmap bits to each parent's bitmap. (We
create a new bitmap for the parent if this is our first time seeing that
parent.) After adding the bits to the parent's bitmap, the parent is
added to the walk queue. Due to this passing of bits to parents, the
current commit has a guarantee that the ith bit is enabled on its bitmap
if and only if the ith commit can reach the current commit.

The first step of the walk is to examine the bitmask on the current
commit and decide which ranges the commit is in or not. Due to the "bit
pushing" in the second step, we have a guarantee that the ith bit of the
current commit's bitmap is on if and only if the ith starting commit can
reach it. For each ahead_behind_count struct, check the base_index and
tip_index to see if those bits are enabled on the current bitmap. If
exactly one bit is enabled, then increment the corresponding 'ahead' or
'behind' count.  This increment is the reason we _absolutely need_ to
walk commits at most once.

The only subtle thing to do with this walk is to check to see if a
parent has all bits on in its bitmap, in which case it becomes "stale"
and is marked with the STALE bit. This allows queue_has_nonstale() to be
the terminating condition of the walk, which greatly reduces the number
of commits walked if all of the commits are nearby in history. It avoids
walking a large number of common commits when there is a deep history.
We also use the helper method insert_no_dup() to add commits to the
priority queue without adding them multiple times. This uses the PARENT2
flag. Thus, we must clear both the STALE and PARENT2 bits of all
commits, in case ahead_behind() is called multiple times in the same
process.

There is no previous implementation of ahead-behind to compare against.
A previous implementation in another fork of Git used a single process
to essentially do the same walk as 'git rev-list --count <base>..<tip>'
for every base/tip pair given as input. The single-walk implementation
in this change was a significant improvement over that implementation.
Another version from that fork used reachability bitmaps for the
comparison, but that implementation was slower than the current commit
walk implementation in almost all cases.

To best present _some_ amount of evidence for this performance gain,
create a new performance test, p1500-graph-walks.sh. This script could
be used for other walks than just ahead-behind in the future, but let's
limit to ahead-behind now.

To gain some amount of a baseline, create one test that checks 'git
ahead-behind' against up to 50 tips and another that uses 'git rev-list
--count' in a loop. Be sure to write a commit-graph before running the
performance tests.

Using the Git source code as the repository, we see a pronounced
improvement:

Test                                            this tree
---------------------------------------------------------------
1500.2: ahead-behind counts: git ahead-behind   0.08(0.07+0.01)
1500.3: ahead-behind counts: git rev-list       1.11(0.92+0.18)

But the de-facto performance benchmark is the Linux kernel repository,
which presents these values for my copy:

Test                                            this tree
---------------------------------------------------------------
1500.2: ahead-behind counts: git ahead-behind   0.27(0.25+0.02)
1500.3: ahead-behind counts: git rev-list       4.53(3.92+0.60)

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/ahead-behind.c      | 23 +++++++++
 commit-reach.c              | 95 +++++++++++++++++++++++++++++++++++++
 commit-reach.h              | 30 ++++++++++++
 t/perf/p1500-graph-walks.sh | 25 ++++++++++
 t/t4218-ahead-behind.sh     | 67 ++++++++++++++++++++++++++
 t/t6600-test-reach.sh       | 62 ++++++++++++++++++++++++
 6 files changed, 302 insertions(+)
 create mode 100755 t/perf/p1500-graph-walks.sh

diff --git a/builtin/ahead-behind.c b/builtin/ahead-behind.c
index e4f65fc0548..c06b95b5f37 100644
--- a/builtin/ahead-behind.c
+++ b/builtin/ahead-behind.c
@@ -2,6 +2,7 @@
 #include "parse-options.h"
 #include "config.h"
 #include "commit.h"
+#include "commit-reach.h"
 
 static const char * const ahead_behind_usage[] = {
 	N_("git ahead-behind --base=<ref> [ --stdin | <revs> ]"),
@@ -29,8 +30,12 @@ static int handle_arg(struct string_list *tips, const char *arg)
 int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
 {
 	const char *base_ref = NULL;
+	struct commit *base;
 	int from_stdin = 0;
 	struct string_list tips = STRING_LIST_INIT_DUP;
+	struct commit **commits;
+	struct ahead_behind_count *counts;
+	size_t i;
 
 	struct option ahead_behind_opts[] = {
 		OPT_STRING('b', "base", &base_ref, N_("base"), N_("base reference to process")),
@@ -71,5 +76,23 @@ int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
 	if (!tips.nr)
 		return 0;
 
+	ALLOC_ARRAY(commits, tips.nr + 1);
+	ALLOC_ARRAY(counts, tips.nr);
+
+	for (i = 0; i < tips.nr; i++) {
+		commits[i] = tips.items[i].util;
+		counts[i].tip_index = i;
+		counts[i].base_index = tips.nr;
+	}
+	commits[tips.nr] = base;
+
+	ahead_behind(commits, tips.nr + 1, counts, tips.nr);
+
+	for (i = 0; i < tips.nr; i++)
+		printf("%s %d %d\n", tips.items[i].string,
+		       counts[i].ahead, counts[i].behind);
+
+	free(counts);
+	free(commits);
 	return 0;
 }
diff --git a/commit-reach.c b/commit-reach.c
index 2e33c599a82..87ccc2cd4f5 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -8,6 +8,7 @@
 #include "revision.h"
 #include "tag.h"
 #include "commit-reach.h"
+#include "ewah/ewok.h"
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
@@ -941,3 +942,97 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 
 	return found_commits;
 }
+
+define_commit_slab(bit_arrays, struct bitmap *);
+static struct bit_arrays bit_arrays;
+
+static void insert_no_dup(struct prio_queue *queue, struct commit *c)
+{
+	if (c->object.flags & PARENT2)
+		return;
+	prio_queue_put(queue, c);
+	c->object.flags |= PARENT2;
+}
+
+static struct bitmap *init_bit_array(struct commit *c, int width)
+{
+	struct bitmap **bitmap = bit_arrays_at(&bit_arrays, c);
+	if (!*bitmap)
+		*bitmap = bitmap_word_alloc(width);
+	return *bitmap;
+}
+
+static void free_bit_array(struct commit *c)
+{
+	struct bitmap **bitmap = bit_arrays_at(&bit_arrays, c);
+	if (!*bitmap)
+		return;
+	bitmap_free(*bitmap);
+	*bitmap = NULL;
+}
+
+void ahead_behind(struct commit **commits, size_t commits_nr,
+		  struct ahead_behind_count *counts, size_t counts_nr)
+{
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
+	size_t width = (commits_nr + BITS_IN_EWORD - 1) / BITS_IN_EWORD;
+	size_t i;
+
+	if (!commits_nr || !counts_nr)
+		return;
+
+	for (i = 0; i < counts_nr; i++) {
+		counts[i].ahead = 0;
+		counts[i].behind = 0;
+	}
+
+	ensure_generations_valid(commits, commits_nr);
+
+	init_bit_arrays(&bit_arrays);
+
+	for (i = 0; i < commits_nr; i++) {
+		struct commit *c = commits[i];
+		struct bitmap *bitmap = init_bit_array(c, width);
+
+		bitmap_set(bitmap, i);
+		insert_no_dup(&queue, c);
+	}
+
+	while (queue_has_nonstale(&queue)) {
+		struct commit *c = prio_queue_get(&queue);
+		struct commit_list *p;
+		struct bitmap *bitmap_c = init_bit_array(c, width);
+
+		for (i = 0; i < counts_nr; i++) {
+			int reach_from_tip = bitmap_get(bitmap_c, counts[i].tip_index);
+			int reach_from_base = bitmap_get(bitmap_c, counts[i].base_index);
+
+			if (reach_from_tip ^ reach_from_base) {
+				if (reach_from_base)
+					counts[i].behind++;
+				else
+					counts[i].ahead++;
+			}
+		}
+
+		for (p = c->parents; p; p = p->next) {
+			struct bitmap *bitmap_p;
+
+			parse_commit(p->item);
+
+			bitmap_p = init_bit_array(p->item, width);
+			bitmap_or(bitmap_p, bitmap_c);
+
+			if (bitmap_popcount(bitmap_p) == commits_nr)
+				p->item->object.flags |= STALE;
+
+			insert_no_dup(&queue, p->item);
+		}
+
+		free_bit_array(c);
+	}
+
+	repo_clear_commit_marks(the_repository, PARENT2 | STALE);
+	clear_bit_arrays(&bit_arrays);
+	clear_prio_queue(&queue);
+}
diff --git a/commit-reach.h b/commit-reach.h
index 148b56fea50..1780f9317bf 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -104,4 +104,34 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 					 struct commit **to, int nr_to,
 					 unsigned int reachable_flag);
 
+struct ahead_behind_count {
+	/**
+	 * As input, the *_index members indicate which positions in
+	 * the 'tips' array correspond to the tip and base of this
+	 * comparison.
+	 */
+	size_t tip_index;
+	size_t base_index;
+
+	/**
+	 * These values store the computed counts for each side of the
+	 * symmetric difference:
+	 *
+	 * 'ahead' stores the number of commits reachable from the tip
+	 * and not reachable from the base.
+	 *
+	 * 'behind' stores the number of commits reachable from the base
+	 * and not reachable from the tip.
+	 */
+	int ahead;
+	int behind;
+};
+
+/**
+ * Given an array of commits and an array of ahead_behind_count pairs,
+ * compute the ahead/behind counts for each pair.
+ */
+void ahead_behind(struct commit **commits, size_t commits_nr,
+		  struct ahead_behind_count *counts, size_t counts_nr);
+
 #endif
diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
new file mode 100755
index 00000000000..c9ac4b7e6e2
--- /dev/null
+++ b/t/perf/p1500-graph-walks.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description='Commit walk performance tests'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_expect_success 'setup' '
+	git for-each-ref --format="%(refname)" "refs/heads/*" "refs/tags/*" >allrefs &&
+	sort -r allrefs | head -n 50 >refs &&
+	git commit-graph write --reachable
+'
+
+test_perf 'ahead-behind counts: git ahead-behind' '
+	git ahead-behind --base=HEAD --stdin <refs
+'
+
+test_perf 'ahead-behind counts: git rev-list' '
+	for r in $(cat refs)
+	do
+		git rev-list --count "HEAD..$r" || return 1
+	done
+'
+
+test_done
diff --git a/t/t4218-ahead-behind.sh b/t/t4218-ahead-behind.sh
index 56f16515896..6658c919fdf 100755
--- a/t/t4218-ahead-behind.sh
+++ b/t/t4218-ahead-behind.sh
@@ -4,6 +4,16 @@ test_description='git ahead-behind command-line options'
 
 . ./test-lib.sh
 
+test_expect_success 'setup simple history' '
+	test_commit base &&
+	git checkout -b right &&
+	test_commit right &&
+	git checkout -b left base &&
+	test_commit left &&
+	git checkout -b merge &&
+	git merge right -m "merge"
+'
+
 test_expect_success 'git ahead-behind -h' '
 	test_must_fail git ahead-behind -h >out &&
 	grep "usage:" out
@@ -14,6 +24,11 @@ test_expect_success 'git ahead-behind without --base' '
 	grep "usage:" err
 '
 
+test_expect_success 'git ahead-behind with broken --base' '
+	test_must_fail git ahead-behind --base=bogus HEAD 2>err &&
+	grep "could not resolve '\''bogus'\''" err
+'
+
 test_expect_success 'git ahead-behind with broken tip' '
 	test_must_fail git ahead-behind --base=HEAD bogus 2>err &&
 	grep "could not resolve '\''bogus'\''" err
@@ -30,4 +45,56 @@ test_expect_success 'git ahead-behind without tips' '
 	test_must_be_empty err
 '
 
+test_expect_success 'git ahead-behind --base=base' '
+	git ahead-behind --base=base base left right merge >actual &&
+
+	cat >expect <<-EOF &&
+	base 0 0
+	left 1 0
+	right 1 0
+	merge 3 0
+	EOF
+
+	test_cmp expect actual
+'
+
+test_expect_success 'git ahead-behind --base=left' '
+	git ahead-behind --base=left base left right merge >actual &&
+
+	cat >expect <<-EOF &&
+	base 0 1
+	left 0 0
+	right 1 1
+	merge 2 0
+	EOF
+
+	test_cmp expect actual
+'
+
+test_expect_success 'git ahead-behind --base=right' '
+	git ahead-behind --base=right base left right merge >actual &&
+
+	cat >expect <<-EOF &&
+	base 0 1
+	left 1 1
+	right 0 0
+	merge 2 0
+	EOF
+
+	test_cmp expect actual
+'
+
+test_expect_success 'git ahead-behind --base=merge' '
+	git ahead-behind --base=merge base left right merge >actual &&
+
+	cat >expect <<-EOF &&
+	base 0 3
+	left 0 2
+	right 0 2
+	merge 0 0
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 338a9c46a24..951e07100f6 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -443,4 +443,66 @@ test_expect_success 'get_reachable_subset:none' '
 	test_all_modes get_reachable_subset
 '
 
+test_expect_success 'ahead-behind:linear' '
+	cat >input <<-\EOF &&
+	commit-1-1
+	commit-1-3
+	commit-1-5
+	commit-1-8
+	EOF
+	cat >expect <<-\EOF &&
+	commit-1-1 0 8
+	commit-1-3 0 6
+	commit-1-5 0 4
+	commit-1-8 0 1
+	EOF
+	run_all_modes git ahead-behind --base=commit-1-9 --stdin
+'
+
+test_expect_success 'ahead-behind:all' '
+	cat >input <<-\EOF &&
+	commit-1-1
+	commit-2-4
+	commit-4-2
+	commit-4-4
+	EOF
+	cat >expect <<-\EOF &&
+	commit-1-1 0 24
+	commit-2-4 0 17
+	commit-4-2 0 17
+	commit-4-4 0 9
+	EOF
+	run_all_modes git ahead-behind --base=commit-5-5 --stdin
+'
+
+test_expect_success 'ahead-behind:some' '
+	cat >input <<-\EOF &&
+	commit-1-1
+	commit-5-3
+	commit-4-8
+	commit-9-9
+	EOF
+	cat >expect <<-\EOF &&
+	commit-1-1 0 53
+	commit-5-3 0 39
+	commit-4-8 8 30
+	commit-9-9 27 0
+	EOF
+	run_all_modes git ahead-behind --base=commit-9-6 --stdin
+'
+
+test_expect_success 'ahead-behind:none' '
+	cat >input <<-\EOF &&
+	commit-7-5
+	commit-4-8
+	commit-9-9
+	EOF
+	cat >expect <<-\EOF &&
+	commit-7-5 7 4
+	commit-4-8 16 16
+	commit-9-9 49 0
+	EOF
+	run_all_modes git ahead-behind --base=commit-8-4 --stdin
+'
+
 test_done
-- 
gitgitgadget

