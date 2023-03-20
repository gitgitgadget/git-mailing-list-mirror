Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB26C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 11:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCTL1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 07:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjCTL11 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 07:27:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E66A4C
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso1382684wmo.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679311622;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voQ7YeXH9eF4Imoj+AIJFG6p42Mxn016kSvitTBIW3s=;
        b=A8TADtL0eQVPVy9zTv87Yr0jNAJUYs4Hf21fpIvvPJbJMAiJlz39WfdSfBbyFxn2nI
         704OAF5G3liq9qFtVbmjsJ3fi2RPS2Rb5Dla3jJgSa+3mc/m9YUhSlbgiKUXzZMhpf8P
         UTf1Bm15VGz6zPQ/H2Oolr9nQAf+q15A5XZgU/GYGCmR1yghfr38UyDQjcE4QLXplpDO
         r3r3c0WbYg1ADMLrAymopNICOSqf27l+f5xUtQbcbPLCKpjzvQCtTEEC05wHBE1Id4mV
         WN8bpTNTsSn2ZO5bxq0aqv0af33MUQ6JY5DJaDMImJVaFgpr2IqIUs3SoLWQF1ZzopmI
         aoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311622;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voQ7YeXH9eF4Imoj+AIJFG6p42Mxn016kSvitTBIW3s=;
        b=spRLoeYpIWx3ldLj8KRTrXYpzrJxz0t0UL3rxAR0MRMHHi8hE+qDYf2ssAahbeqxC2
         9mUyCFhymCuXpb3Yfg4qseGkDNOcDHdQRrcQAI4EhM4Lfi/jt1sEqUM24SxU4wdfJPo7
         2FUXB5sjB2AHddxY0w6pKsayVc3kioWHi4ez4DCiNtW0kcWAV9F/aGsOLMR4UGeXaKO/
         4NKBSFk+r2VGKxnSN3Wvo0YWEUWBJVPpEjFzCUbW+G+IdFWOqwdxaK4iZZo/GK6tbUSA
         78UthQBjqpc7Zu3kEfz9DioNL4AM5JQvpZuREWfDfD2ae0Q68+hpGtB2kXYjaVZU13FQ
         n/Ew==
X-Gm-Message-State: AO0yUKWNBm2BV2W9IeT8XbJ1srUjhHD3i2HyTh7HOwlpD5B7MSyiGnBf
        ZJYvPNYx7PRHo4eR+iahrK0xN8BjCW0=
X-Google-Smtp-Source: AK7set9yVm+AzJ4qa6rNAQf9Iw+Y03DZE57QN3twq8lwWKEs8TN//PgFE1KJFPRo/h4nQF0b/VIERA==
X-Received: by 2002:a05:600c:19c9:b0:3ed:31fa:f563 with SMTP id u9-20020a05600c19c900b003ed31faf563mr16141712wmq.20.1679311622474;
        Mon, 20 Mar 2023 04:27:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c468900b003ed5909aab2sm12917774wmo.25.2023.03.20.04.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:27:02 -0700 (PDT)
Message-Id: <5d937184a0eba9176d97423fb450850fc482e4de.1679311616.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
References: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
        <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Mar 2023 11:26:53 +0000
Subject: [PATCH v4 7/9] commit-reach: implement ahead_behind() logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Fully implement the commit-counting logic required to determine
ahead/behind counts for a batch of commit pairs. This is a new library
method within commit-reach.h. This method will be linked to the
for-each-ref builtin in the next change.

The interface for ahead_behind() uses two arrays. The first array of
commits contains the list of all starting points for the walk. This
includes all tip commits _and_ base commits. The second array specifies
base/tip pairs by pointing to commits within the first array, by index.
The second array also stores the resulting ahead/behind counts for each
of these pairs.

This implementation of ahead_behind() allows multiple bases, if desired.
Even with multiple bases, there is only one commit walk used for
counting the ahead/behind values, saving time when the base/tip ranges
overlap significantly.

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

The first array of commits are considered the starting commits. The
index within that array will play a critical role.

We create a new commit slab that maps commits to a bitmap. For a given
commit (anywhere in the history), its bitmap stores information relative
to which of the input commits can reach that commit. The ith bit will be
on if the ith commit from the starting list can reach that commit. It is
important to notice that these bitmaps are not the typical "reachability
bitmaps" that are stored in .bitmap files. Instead of signalling which
objects are reachable from the current commit, they instead signal
"which starting commits can reach me?" It is also important to know that
the bitmap is not necessarily "complete" until we walk that commit. We
will perform a commit walk by generation number in such a way that we
can guarantee the bitmap is correct when we visit that commit.

At the beginning of the ahead_behind() method, we initialize the bitmaps
for each of the starting commits. By enabling the ith bit for the ith
starting commit, we signal "the ith commit can reach itself."

We walk commits by popping the commit with maximum generation number out
of the queue, guaranteeing that we will never walk a child of that
commit in any future steps.

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

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-reach.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h |  31 +++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index 2e33c599a82..cd990dce16a 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -8,6 +8,7 @@
 #include "revision.h"
 #include "tag.h"
 #include "commit-reach.h"
+#include "ewah/ewok.h"
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
@@ -941,3 +942,105 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 
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
+static struct bitmap *get_bit_array(struct commit *c, int width)
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
+void ahead_behind(struct repository *r,
+		  struct commit **commits, size_t commits_nr,
+		  struct ahead_behind_count *counts, size_t counts_nr)
+{
+	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
+	size_t width = DIV_ROUND_UP(commits_nr, BITS_IN_EWORD);
+
+	if (!commits_nr || !counts_nr)
+		return;
+
+	for (size_t i = 0; i < counts_nr; i++) {
+		counts[i].ahead = 0;
+		counts[i].behind = 0;
+	}
+
+	ensure_generations_valid(r, commits, commits_nr);
+
+	init_bit_arrays(&bit_arrays);
+
+	for (size_t i = 0; i < commits_nr; i++) {
+		struct commit *c = commits[i];
+		struct bitmap *bitmap = get_bit_array(c, width);
+
+		bitmap_set(bitmap, i);
+		insert_no_dup(&queue, c);
+	}
+
+	while (queue_has_nonstale(&queue)) {
+		struct commit *c = prio_queue_get(&queue);
+		struct commit_list *p;
+		struct bitmap *bitmap_c = get_bit_array(c, width);
+
+		for (size_t i = 0; i < counts_nr; i++) {
+			int reach_from_tip = !!bitmap_get(bitmap_c, counts[i].tip_index);
+			int reach_from_base = !!bitmap_get(bitmap_c, counts[i].base_index);
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
+			repo_parse_commit(r, p->item);
+
+			bitmap_p = get_bit_array(p->item, width);
+			bitmap_or(bitmap_p, bitmap_c);
+
+			/*
+			 * If this parent is reachable from every starting
+			 * commit, then none of its ancestors can contribute
+			 * to the ahead/behind count. Mark it as STALE, so
+			 * we can stop the walk when every commit in the
+			 * queue is STALE.
+			 */
+			if (bitmap_popcount(bitmap_p) == commits_nr)
+				p->item->object.flags |= STALE;
+
+			insert_no_dup(&queue, p->item);
+		}
+
+		free_bit_array(c);
+	}
+
+	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
+	repo_clear_commit_marks(r, PARENT2 | STALE);
+	clear_bit_arrays(&bit_arrays);
+	clear_prio_queue(&queue);
+}
diff --git a/commit-reach.h b/commit-reach.h
index 148b56fea50..f708c46e523 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -104,4 +104,35 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
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
+	unsigned int ahead;
+	unsigned int behind;
+};
+
+/*
+ * Given an array of commits and an array of ahead_behind_count pairs,
+ * compute the ahead/behind counts for each pair.
+ */
+void ahead_behind(struct repository *r,
+		  struct commit **commits, size_t commits_nr,
+		  struct ahead_behind_count *counts, size_t counts_nr);
+
 #endif
-- 
gitgitgadget

