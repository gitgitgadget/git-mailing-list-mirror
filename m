Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790AAC61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjCORqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjCORqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:46:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A9F49DE
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id x22so7653269wmj.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678902349;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B2aLMen/68CQm3mC7JjUjW8bb5o+wsXYP2E2aSLyoE=;
        b=CxfydGbRHxtSomoqa45T3nMqMYz1DzTGX5Cf5H0f8FwrZfsCW0V8fUfplnoj+oLPLo
         c6Pm9WoKqd0U4A0z68ifmGax5kCJnaGK8lji0h4vPG3ksEVLmb9VMhnszE2fb+jAHOj5
         RdlL/0ICKlphe9zmG1bd9DUD+lErVjQP/nFbp84jOx9pReYb2eSaEHb5FnHkjvGS8RXB
         Lm2WhozFfh/PUMGfWXGSzVEf3Oa4ZOWmSzb5wUyHJgOEnyGjlhH7H5zzJdoSMVSGaEvS
         1B+dCL+AQ/W07qGID94y3z7e2ywlcbly9QWxtHfO3SJ/6FPTjb44fri9d0OS44eZLK0/
         ubYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902349;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5B2aLMen/68CQm3mC7JjUjW8bb5o+wsXYP2E2aSLyoE=;
        b=NH975o0VIq6fsr1kz9+ODrbBsj37SZcZk8b/BKNQc/1v5yngZm2kJHEeNI3xh/JfWL
         L+OZceUK8qbQN5MPqpFLe4WbrxMRPRqtpkW62AAt1LG7brDi0YqkvCoKIRHA+/jmHRNK
         BZjJyC8oXjV6A3OHbMmG4tU/DQ8tVHkaY3G7SnJmvUxYF7slnZgVSE00DMFnwuYqjTIO
         vgoLaeBgVFQQ3lCnDuaVsoTOI7bZAIS3LXMcx0+y2WPPoAeKv9J6vQA9SYQL8H/K69la
         GWT/95G4KPPJ7CvemFzkqwtjeyJ/h/eyPUKSlP8S4l1Kd0gC/w26hYthBoPrPo08m9Bk
         Nr7g==
X-Gm-Message-State: AO0yUKVohtaABWRhH8JGPiJNukNMBLxieRdG6O1Eujj/yuOXmiOUT2Sz
        usM0df66Uucp6NDKJFzfBGlyLYFXUAs=
X-Google-Smtp-Source: AK7set/AwGnQc/PnLi7JocPi9xJe9zp+bIRh6iZGtwG3E+tw7Q2bodRHki75RCXaE2fa1q3ipmCxnw==
X-Received: by 2002:a05:600c:cc6:b0:3ed:2949:9847 with SMTP id fk6-20020a05600c0cc600b003ed29499847mr8741758wmb.10.1678902348693;
        Wed, 15 Mar 2023 10:45:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c288600b003ed2357f7f1sm2495009wmd.37.2023.03.15.10.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:45:48 -0700 (PDT)
Message-Id: <0fb3913810b7d4731707a0129df7f5d57c8ab39f.1678902343.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
References: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Mar 2023 17:45:41 +0000
Subject: [PATCH v3 6/8] commit-reach: implement ahead_behind() logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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
includes all tip commits _and_ base commits. The second array, using the
new ahead_behind_count struct, indicates which commits from that initial
array form the base/tip pair for the ahead/behind count it will store.

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

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-reach.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h | 31 ++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index 2e33c599a82..1e5a1c37fb7 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -8,6 +8,7 @@
 #include "revision.h"
 #include "tag.h"
 #include "commit-reach.h"
+#include "ewah/ewok.h"
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
@@ -941,3 +942,98 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 
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
+void ahead_behind(struct repository *r,
+		  struct commit **commits, size_t commits_nr,
+		  struct ahead_behind_count *counts, size_t counts_nr)
+{
+	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
+	size_t width = (commits_nr + BITS_IN_EWORD - 1) / BITS_IN_EWORD;
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

