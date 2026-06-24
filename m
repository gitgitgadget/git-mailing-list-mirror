Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE12D6409
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303259; cv=none; b=G+kdatumxv74oieU+llBIqauzBUXWvyOOqyCkYOPDJn+3ISL7pUK/xKfo1VldpIvBESHFmoluP4/eAotEDcMbMgxibquokdkeo7Uf7RsGP9jpYHutihNyFg8NhKJ/zpsTaxDu+lJdNqrERxGp5HvwTsumrC6b8H/AlKTZ2dYOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303259; c=relaxed/simple;
	bh=1cvL75umiedLVxfM7du20h+nSl8eGOKMuh1ZG2eP5oM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W/mEytyDx8hsY5ynb9KxzY5/Y2SrDhW+7eaOhse1w31SZjzl1KIBzyAVyBcmr5jLhDPJ5SiWT/raooah8IzyvqJ2y2tJc6OAGX633EWf/0UjK2/IjxN2rpgM6Egi9GF+V5/R7zwEXkJMRK8AU+WogsYBXwBODwpPeXYaX7DuxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwD4CtM2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwD4CtM2"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91563abd6a9so40060885a.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303256; x=1782908056; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X11xf3hb+mMKb6EXG4XIiot9QkvVe/SCom97Isvkf8M=;
        b=rwD4CtM2utJoLuOHlX/+ojNIDh4BcU8Dk5McLbXkEatCqq75e03ysckIdgkNi55Gwj
         vADAf4l4Xelpqcp9ND03FJEdAbCPIQWeSj9Va96tMtXg0BUA3GjLfWdKf4ACQoIpenSZ
         +id+K0fHXWsLmgJLwdoq1P7TJI1RQK2X5IJj1qoJfepSGivqD/kEyU2oQCLodTX1JZU0
         EvV4KWH7Cs6jgroZ6tgb51PDyVu5QVFHI5QD8Au4o6Rj08MwSYpoPcOQvj1nnP4LQHuS
         07g1xFY2bqIn+8pqmdtVO7Rep17y4Socx9xrP5DdRH/xAPsHqi+QLM0R/iRLrmLhWlNY
         z57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303256; x=1782908056;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X11xf3hb+mMKb6EXG4XIiot9QkvVe/SCom97Isvkf8M=;
        b=DIDZGOaJK4l0UwaH4JGvr60jBsCC2gCqeH9LEcD/wZYKMuKNY42sPHYnCpEU20nRQ4
         fEWdNTqoOV/VWPbIy+AixwVY35fdZ+jAl/Ys+DNlLn5ng8Iywm0QyZGnlblz62QhZTI4
         n8D9lk2+tTwhjG6Ac3EobYkZwh17gOyQlaY5T+zejrB2Pa+JrFqfOt9HV5u5DWxqjWL+
         et8yVRQpg2HuWkfWsLnwpUS+UP4rYQb3kGnKIFWsbl53P98Bpf2F90UpUmhjJXUOAjUP
         ClDqcBiszffA/5jWCwr6j7ZQEzd4d+MFvfMKsopAMoWrEDr4AZ/+tPoKHTDGR7Q9Nnub
         2cCg==
X-Gm-Message-State: AOJu0YxsMrdEWMNWABIFCwIYKgG/KpwZpiIJpLEWXBzEzG81uDEwPEO5
	3MmBXXL09zfHpESPbfOGVPhVWn0RxtWBys/HipnTavyJbOT042yKBje4/Rf8j2tB
X-Gm-Gg: AfdE7cn9StV1b4i3btQrOQkTS2KVOpKv9wE+HaiDYs45b6DsJZP91roH/Ol++izbLkh
	HRp+95cQ2s8n9kf5UALb5PC55rbe6F8Qu8MRfFT4aHdb86Sh3V61cUCMSO3IFGo5DJlg5faIVz0
	cdpC+mMo/KCVfVtA3Pw9XKxYl1YH04fvN07C0eFlNKBz67FImqagt08bOx83MfkxWk2OFCSbN9E
	ufxXpr2zPSczOdlkF847MBHlYYSGXtTDVMnLyqs20tDzOpbaB+6IS0wg+ErQTFWJaxF309HR15S
	ajtSx5hRrvxBbCdEgCPfSycMQmjcBXQbIrW5OKSjvMrmYWOSQ1O6uQYq0OmxamNoZ1Q+9XNVBeZ
	dVlRF57x6paVGxPekeUVJxGi4NamQVl/fJ8yk/dXFVRyKp3wsbO6gGGo/ghq0ZcMmgfoa9GGMHc
	6IMtACB6XJMUFCVzI=
X-Received: by 2002:a05:620a:2b41:b0:915:b9f6:71a0 with SMTP id af79cd13be357-927847073a0mr454783985a.49.1782303256148;
        Wed, 24 Jun 2026 05:14:16 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.92.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd390bd1sm517948185a.1.2026.06.24.05.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:14:15 -0700 (PDT)
Message-Id: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 12:14:06 +0000
Subject: [PATCH v2 0/7] commit-reach: terminate merge-base walk when one side is exhausted
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>

commit-reach: terminate merge-base walk when one side is exhausted

Optimize paint_down_to_common() for merge-base queries that hit large
one-sided histories.

When the walk from one side reaches a commit with a very low generation
number that the other side never paints, the walk is forced to drain most of
the graph. A common trigger is a repository import that grafts a separate
history with its own root, but any merge that introduces a low-generation
commit never painted by the other side has the same effect.

A new merge-base candidate can only be discovered when exclusive PARENT1 and
PARENT2 paint meet. This series teaches paint_down_to_common() to stop as
soon as one side has no exclusive commits left in the queue; once one side
is exhausted, no further candidates can appear.

  origin/HEAD  o   o  PR HEAD
               |   |
     (import)  o   :
              / \ /
             |   o  merge-base
             |   |
             :   :  (~2.5M commits)
             |   |
  import root   main root


In the RFC thread [1], Derrick Stolee provided a criss-cross counterexample
that sharpened the halt condition, and Elijah Newren independently
discovered the same optimization and shared an implementation in PR #2150
[2]. Patches 2-3 incorporate test cases from Elijah's branch.

This series implements the optimization only after the walk enters the
finite-generation region, where generation ordering guarantees that paint on
visited commits is final.

Patch layout:

1/7 Documentation/technical: add paint-down-to-common doc 2/7 t6600: add
test cases for side-exhaustion edge cases 3/7 t6099, t6600: add
side-exhaustion regression tests 4/7 commit-reach: add trace2
instrumentation to paint_down_to_common() 5/7 commit-reach: introduce struct
paint_state with per-side counters 6/7 commit-reach: remove unused
nonstale_queue dedup wrappers 7/7 commit-reach: terminate merge-base walk
when one paint side is exhausted

Benchmarks

Step counts are deterministic (measured via trace2_data_intmax added in
patch 4). Wall-clock times are medians over 10-20 runs with CPU governor set
to performance.

2.6M-commit monorepo with commit-graph (baseline v2.55.0-rc1):

                                        steps              wall-clock
merge-base --all  (across import)    2682391 ->  53521     7.26s ->   88ms
merge-base --all  (1000 apart)       2659607 ->   1106     6.98s ->    8ms
merge-tree        (across import)          -               8.11s ->  100ms


git.git (88k commits, commit-graph):

                                        steps              wall-clock
merge-base --all v2.0.0 v2.55.0-rc1   72264 ->  44589      82ms ->   49ms
merge-base --all HEAD HEAD~1000         9873 ->   3817      19ms ->    9ms
merge-base --all HEAD HEAD~10000       72285 ->  41523      80ms ->   48ms
merge-base HEAD HEAD~1000                  -                 9ms ->    9ms
merge-base --is-ancestor HEAD~1000 HEAD    -                 6ms ->    6ms


Changes since v1:

 * Reordered patches: documentation first (describing the existing
   algorithm), tests before code changes, so they demonstrate passing with
   old logic first.

 * Dropped the ahead_behind decoupling patch. paint_state is now a NEW
   struct alongside nonstale_queue instead of replacing it. ahead_behind()
   is completely untouched.

 * Removed nonstale_queue_put_dedup() and nonstale_queue_get_dedup() (dead
   code after the conversion) in a separate commit.

 * Renamed: struct paint_queue -> paint_state, field pq -> queue,
   paint_count_add/remove -> paint_count_update (single function with signed
   delta parameter).

 * Split the old paint_count_transition (which handled both old and new
   flags in one call) into separate remove/add calls with a signed delta.
   This eliminates the need for the case 0 handler (which tracked "not in
   the queue") and allows an exhaustive switch on (PARENT1 | PARENT2 |
   STALE) that documents all valid flag combinations, with BUG() in default.

 * Moved all termination conditions into paint_queue_get(). The all-zero
   check and the side-exhaustion check are merged under a shared
   !pending_merge_bases guard. paint_queue_get() derives the generation from
   the dequeued commit itself, so no extra parameter is needed.

 * Added trace2_data_intmax() instrumentation to report the number of
   commits visited per paint walk (separate commit), with deterministic
   step-count assertions in t6600.

 * Expanded switch statements to multi-line format per .clang-format.

 * Used !count style throughout instead of count == 0.

 * Updated technical documentation alongside code changes.

 * Added benchmark data (both git-bench wall-clock and trace2 step counts)
   to commit messages.

[1]
https://lore.kernel.org/git/CAL71e4Ps-2_0+uuZu43N9pFnXBemoAohPs_eyRJf8taXHJPAXQ@mail.gmail.com/T/#u
[2] https://github.com/gitgitgadget/git/pull/2150

Elijah Newren (1):
  t6600: add test cases for side-exhaustion edge cases

Kristofer Karlsson (6):
  Documentation/technical: add paint-down-to-common doc
  t6099, t6600: add side-exhaustion regression tests
  commit-reach: add trace2 instrumentation to paint_down_to_common()
  commit-reach: introduce struct paint_state with per-side counters
  commit-reach: remove unused nonstale_queue dedup wrappers
  commit-reach: terminate merge-base walk when one paint side is
    exhausted

 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/paint-down-to-common.adoc       | 128 ++++++++++++++
 commit-reach.c                                | 119 ++++++++++---
 t/meson.build                                 |   1 +
 t/t6099-merge-base-side-exhaustion.sh         |  82 +++++++++
 t/t6600-test-reach.sh                         | 157 ++++++++++++++++++
 7 files changed, 464 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/technical/paint-down-to-common.adoc
 create mode 100755 t/t6099-merge-base-side-exhaustion.sh


base-commit: ab776a62a78576513ee121424adb19597fbb7613
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2149%2Fspkrka%2Fside-exhaust-pr-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2149/spkrka/side-exhaust-pr-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2149

Range-diff vs v1:

 1:  5492acda0a < -:  ---------- commit-reach: decouple ahead_behind from nonstale_queue
 6:  9cbfc67d72 ! 1:  19ed743bd1 Documentation/technical: add paint-down-to-common doc
     @@ Commit message
          Documentation/technical: add paint-down-to-common doc
      
          Add a technical document describing the paint_down_to_common()
     -    algorithm used for merge-base computation.
     +    algorithm used for merge-base computation, covering the paint
     +    walk, generation number regions, and termination conditions.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +Termination
      +-----------
      +
     -+Termination happens when we can prove that no extra progress is
     -+possible. We are done with the main loop when one of the following
     -+conditions holds:
     ++The walk uses a `nonstale_queue` wrapper around `prio_queue` that
     ++tracks `max_nonstale`: the lowest-priority non-stale commit enqueued
     ++so far. Once that commit is dequeued, every remaining entry is known
     ++to be STALE and the loop terminates. Specifically, the main loop
     ++ends when one of the following conditions holds:
      +
      +  1. The queue is empty.
     -+  2. The queue only contains STALE entries.
     -+  3. Side-exhaustion: the walk has reached the finite region and one
     -+     of the sides is fully exhausted.
     -+
     -+The loop waits for all pending merge-base candidates to be popped
     -+and recorded before any early exit fires, so no separate drain phase
     -+is needed after termination.
     ++  2. `max_nonstale` has been dequeued, meaning the queue only contains
     ++     STALE entries.
      +
      +Stale entry condition
      +~~~~~~~~~~~~~~~~~~~~~
     -+If all entries are stale we cannot find any new merge bases since
     -+that requires at least one enqueued side node meeting the other side.
     -+However, we could still invalidate merge bases (if there are more
     -+than one). This is unnecessary since `remove_redundant()` will clean
     -+that up as a post-process step.
     -+
     -+Side-exhaustion
     -+~~~~~~~~~~~~~~~
     -+A commit is *exclusive* to one side if it carries that side's paint
     -+but not the other (e.g. PARENT1 without PARENT2).
     -+
     -+If we have reached the finite region of the graph, no future
     -+traversal step can add paint to an already-visited commit. Thus if
     -+there are no exclusive PARENT2 commits in the queue, no additional
     -+PARENT2 paint can be introduced into the walk. Even if exclusive
     -+PARENT1 commits remain, no new merge-base candidates can be
     -+discovered. The same holds symmetrically for PARENT1.
     -+
     -+This invariant is only valid in the finite region of the graph.
     ++Once all queued entries are stale, no new merge-base candidates can
     ++be discovered -- that requires at least one non-stale commit from
     ++each side meeting. Continuing the walk could still invalidate
     ++existing candidates by proving one is an ancestor of another, but
     ++`remove_redundant()` handles that as a post-processing step, so it
     ++is safe to exit early.
      +
      +Related documentation
      +---------------------
      +
      +  - `Documentation/technical/commit-graph.adoc` -- generation numbers
      +    and the reachability closure property.
     +
     + ## commit-reach.c ##
     +@@ commit-reach.c: static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
     + 	return commit;
     + }
     + 
     +-/* all input commits in one and twos[] must have been parsed! */
     ++/*
     ++ * See Documentation/technical/paint-down-to-common.adoc
     ++ *
     ++ * All input commits in one and twos[] must have been parsed!
     ++ */
     + static int paint_down_to_common(struct repository *r,
     + 				struct commit *one, int n,
     + 				struct commit **twos,
 4:  91372b975f ! 2:  6151b8e0a3 t6600: add test cases for side-exhaustion edge cases
     @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
      +	#   ps-T1   ps-T2
      +	#
      +	# where ps-T1=merge(ps-Z,ps-B), ps-T2=merge(ps-W,ps-B), so
     -+	# merge-base(ps-T1,ps-T2) = ps-B.  During the walk, ps-X transitions
     ++	# merge-base(ps-T1,ps-T2) = ps-B. During the walk, ps-X transitions
      +	# to (PARENT1|PARENT2) via ps-Z and ps-W before ps-B is dequeued;
      +	# then the STALE-walk from ps-B transitions ps-X to
      +	# (PARENT1|PARENT2|STALE).
     @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
      +
      +	# Build a side topology that lives entirely outside the half
      +	# commit-graph and has non-monotonic commit dates, to exercise the
     -+	# INFINITY-gate in paint_down_to_common.  With both tips outside
     ++	# INFINITY-gate in paint_down_to_common. With both tips outside
      +	# the graph, generation is INFINITY and the queue falls back to
      +	# commit-date order, which here is non-monotonic.
      +	#
     @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many' '
      +
      +test_expect_success 'get_merge_bases_many:pending-stale' '
      +	# Exercises the (PARENT1|PARENT2) -> (...|STALE) transition path in
     -+	# paint_down_to_common().  See the topology comment in the setup test.
     ++	# paint_down_to_common(). See the topology comment in the setup test.
      +	cat >input <<-\EOF &&
      +	A:ps-T1
      +	X:ps-T2
     @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many' '
      +'
      +
      +test_expect_success 'get_merge_bases_many:infinity-both-sides' '
     -+	# Exercises the push-time INFINITY-gate in paint_down_to_common().  See
     ++	# Exercises the push-time INFINITY-gate in paint_down_to_common(). See
      +	# the pi-* topology comment in the setup test.
      +	cat >input <<-\EOF &&
      +	A:pi-X
 5:  faf5bc98ed ! 3:  90f09ecb5c t6099, t6600: add side-exhaustion regression tests
     @@ t/t6099-merge-base-side-exhaustion.sh (new)
      +
      +Test that merge-base --all correctly handles cases where
      +multiple merge-base candidates exist and one is an ancestor
     -+of another.  The side-exhaustion optimization in
     ++of another. The side-exhaustion optimization in
      +paint_down_to_common may exit before STALE propagation
      +removes the ancestor, but remove_redundant catches it.
      +
     @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:infinity-both-s
      +test_expect_success 'setup mixed finite/INFINITY topology' '
      +	# Create a commit outside all saved commit-graph files so it always
      +	# has INFINITY generation, while its parent (ps-X) is in the graph
     -+	# with a finite generation.  Use the ps-* orphan topology so we do
     ++	# with a finite generation. Use the ps-* orphan topology so we do
      +	# not pollute the grid-based rev-list tests.
      +	git checkout ps-X &&
      +	test_env GIT_TEST_COMMIT_GRAPH= test_commit pm-INF
     @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:infinity-both-s
      +test_expect_success 'get_merge_bases_many:mixed-finite-infinity' '
      +	# One tip (pm-INF) is outside the commit-graph with INFINITY
      +	# generation; the other (ps-B) is in the graph with finite
     -+	# generation.  The walk starts in the INFINITY region and crosses
     ++	# generation. The walk starts in the INFINITY region and crosses
      +	# into the finite region where side-exhaustion can fire.
      +	cat >input <<-\EOF &&
      +	A:pm-INF
 -:  ---------- > 4:  6ade4df2ed commit-reach: add trace2 instrumentation to paint_down_to_common()
 2:  316e4dfe26 ! 5:  f24edd45f0 commit-reach: introduce struct paint_queue with per-side counters
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    commit-reach: introduce struct paint_queue with per-side counters
     +    commit-reach: introduce struct paint_state with per-side counters
      
     -    Replace the nonstale_queue abstraction in paint_down_to_common() with
     -    a new paint_queue struct that tracks per-side commit counts. Each
     -    non-stale queued commit occupies exactly one counter bucket based on
     -    its paint flags: PARENT1-only, PARENT2-only, or both sides (a pending
     +    Add a paint_state struct for use by paint_down_to_common() that
     +    wraps a prio_queue with per-side commit counters. Each non-stale
     +    queued commit occupies exactly one counter bucket based on its
     +    paint flags: PARENT1-only, PARENT2-only, or both sides (a pending
          merge-base candidate).
      
     -    The counters are maintained by paint_count_transition() which handles
     -    all flag changes as bucket transfers: remove from the old bucket, add
     -    to the new one. Either step is a no-op when the respective state has
     -    no bucket (stale or zero).
     +    The counters are maintained by paint_count_update() which adjusts
     +    the appropriate bucket by a signed delta. An exhaustive switch on
     +    the paint+stale bits documents all valid flag combinations in one
     +    place.
      
     -    The loop now drains the queue via paint_queue_get() and breaks when
     -    all counters reach zero, replacing the old pointer-based termination
     -    (max_nonstale). This is equivalent behavior.
     +    Convert paint_down_to_common() to use paint_state. The loop now
     +    drains the queue via paint_queue_get() which returns NULL when all
     +    counters reach zero, replacing the old pointer-based termination
     +    (max_nonstale). This is equivalent behavior -- both conditions
     +    detect that no non-stale entries remain.
     +
     +    The existing nonstale_queue is left in place for ahead_behind().
     +
     +    Step counts (via trace2 from the previous commit) are identical
     +    before and after this refactoring, confirming no behavioral change.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     + ## Documentation/technical/paint-down-to-common.adoc ##
     +@@ Documentation/technical/paint-down-to-common.adoc: re-enqueued is bounded by the number of flag transitions.
     + Termination
     + -----------
     + 
     +-The walk uses a `nonstale_queue` wrapper around `prio_queue` that
     +-tracks `max_nonstale`: the lowest-priority non-stale commit enqueued
     +-so far. Once that commit is dequeued, every remaining entry is known
     +-to be STALE and the loop terminates. Specifically, the main loop
     ++The walk tracks the number of commits of each type in the queue
     ++(PARENT1-only, PARENT2-only, pending merge-base). The main loop
     + ends when one of the following conditions holds:
     + 
     +   1. The queue is empty.
     +-  2. `max_nonstale` has been dequeued, meaning the queue only contains
     +-     STALE entries.
     ++  2. The queue contains only stale entries.
     + 
     + Stale entry condition
     + ~~~~~~~~~~~~~~~~~~~~~
     +
       ## commit-reach.c ##
     -@@ commit-reach.c: static int compare_commits_by_gen(const void *_a, const void *_b)
     +@@ commit-reach.c: static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
     + 	return commit;
       }
       
     - /*
     -- * A prio_queue with O(1) termination check.  'max_nonstale' tracks
     -- * the lowest-priority non-stale commit enqueued so far; once it is
     -- * popped, every remaining entry is known to be STALE.
     ++/*
      + * Priority queue with per-side commit counters for paint_down_to_common().
      + * Each non-stale queued commit occupies exactly one bucket: PARENT1-only,
      + * PARENT2-only, or both (a pending merge-base candidate).
     -  */
     --struct nonstale_queue {
     -+struct paint_queue {
     - 	struct prio_queue pq;
     --	struct commit *max_nonstale;
     ++ */
     ++struct paint_state {
     ++	struct prio_queue queue;
      +	int p1_count;
      +	int p2_count;
      +	int pending_merge_bases;
     - };
     - 
     --static void nonstale_queue_put(struct nonstale_queue *queue,
     --			       struct commit *c)
     -+/*
     -+ * Adjust per-side counters for a paint-state transition.  Non-stale
     -+ * commits are counted in one of three counters: PARENT1-only,
     -+ * PARENT2-only, or both.  Zero means "not in the queue" (used on
     -+ * enqueue/dequeue); stale commits are not counted at all.
     -+ */
     -+static void paint_count_transition(struct paint_queue *queue,
     -+				   unsigned old_flags, unsigned new_flags)
     - {
     --	struct commit *old = queue->max_nonstale;
     -+	unsigned old_paint = old_flags & (PARENT1 | PARENT2 | STALE);
     -+	unsigned new_paint = new_flags & (PARENT1 | PARENT2 | STALE);
     - 
     --	prio_queue_put(&queue->pq, c);
     --	if (c->object.flags & STALE)
     -+	if (old_paint == new_paint)
     - 		return;
     --	if (!old || queue->pq.compare(old, c, queue->pq.cb_data) <= 0)
     --		queue->max_nonstale = c;
     --}
     --
     --static struct commit *nonstale_queue_get(struct nonstale_queue *queue)
     --{
     --	struct commit *commit = prio_queue_get(&queue->pq);
     - 
     --	if (commit == queue->max_nonstale)
     --		queue->max_nonstale = NULL;
     --
     --	return commit;
     -+	if (!(old_paint & STALE)) {
     -+		switch (old_paint & (PARENT1 | PARENT2)) {
     -+		case 0:                  break;
     -+		case PARENT1:            queue->p1_count--; break;
     -+		case PARENT2:            queue->p2_count--; break;
     -+		case PARENT1 | PARENT2:  queue->pending_merge_bases--; break;
     -+		default:                 BUG("unexpected paint state");
     -+		}
     -+	}
     -+	if (!(new_paint & STALE)) {
     -+		switch (new_paint & (PARENT1 | PARENT2)) {
     -+		case 0:                  break;
     -+		case PARENT1:            queue->p1_count++; break;
     -+		case PARENT2:            queue->p2_count++; break;
     -+		case PARENT1 | PARENT2:  queue->pending_merge_bases++; break;
     -+		default:                 BUG("unexpected paint state");
     -+		}
     ++};
     ++
     ++static void paint_count_update(struct paint_state *state,
     ++			       unsigned flags, int delta)
     ++{
     ++	switch (flags & (PARENT1 | PARENT2 | STALE)) {
     ++	case PARENT1:
     ++		state->p1_count += delta;
     ++		break;
     ++
     ++	case PARENT2:
     ++		state->p2_count += delta;
     ++		break;
     ++
     ++	case PARENT1 | PARENT2:
     ++		state->pending_merge_bases += delta;
     ++		break;
     ++
     ++	case PARENT1 | PARENT2 | STALE:
     ++		break;
     ++
     ++	default:
     ++		BUG("unexpected paint state");
      +	}
     - }
     - 
     --static void clear_nonstale_queue(struct nonstale_queue *queue)
     -+static void paint_queue_put(struct paint_queue *queue,
     ++}
     ++
     ++static void paint_queue_put(struct paint_state *state,
      +			    struct commit *c, unsigned add_flags)
     - {
     --	clear_prio_queue(&queue->pq);
     --	queue->max_nonstale = NULL;
     --}
     ++{
      +	unsigned old_flags = c->object.flags;
      +	c->object.flags |= add_flags;
     - 
     --static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
     --				     struct commit *c)
     --{
     --	if (c->object.flags & ENQUEUED)
     --		return;
     --	c->object.flags |= ENQUEUED;
     --	nonstale_queue_put(queue, c);
     ++
      +	if (old_flags & ENQUEUED) {
     -+		paint_count_transition(queue, old_flags, c->object.flags);
     ++		paint_count_update(state, old_flags, -1);
     ++		paint_count_update(state, c->object.flags, 1);
      +	} else {
      +		c->object.flags |= ENQUEUED;
     -+		prio_queue_put(&queue->pq, c);
     -+		paint_count_transition(queue, 0, c->object.flags);
     ++		prio_queue_put(&state->queue, c);
     ++		paint_count_update(state, c->object.flags, 1);
      +	}
     - }
     - 
     --static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
     -+static struct commit *paint_queue_get(struct paint_queue *queue)
     - {
     --	struct commit *commit = nonstale_queue_get(queue);
     -+	struct commit *commit = prio_queue_get(&queue->pq);
     - 
     --	if (commit)
     ++}
     ++
     ++static struct commit *paint_queue_get(struct paint_state *state)
     ++{
     ++	struct commit *commit;
     ++
     ++	if (!state->p1_count && !state->p2_count &&
     ++	    !state->pending_merge_bases)
     ++		return NULL;
     ++
     ++	commit = prio_queue_get(&state->queue);
      +	if (commit) {
     - 		commit->object.flags &= ~ENQUEUED;
     -+		paint_count_transition(queue, commit->object.flags, 0);
     ++		commit->object.flags &= ~ENQUEUED;
     ++		paint_count_update(state, commit->object.flags, -1);
      +	}
     - 	return commit;
     - }
     - 
     ++	return commit;
     ++}
     ++
     + /*
     +  * See Documentation/technical/paint-down-to-common.adoc
     +  *
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       				enum merge_base_flags mb_flags,
       				struct commit_list **result)
       {
      -	struct nonstale_queue queue = {
      -		{ compare_commits_by_gen_then_commit_date }
     -+	struct paint_queue queue = {
     -+		.pq = { compare_commits_by_gen_then_commit_date }
     ++	struct paint_state state = {
     ++		.queue = { compare_commits_by_gen_then_commit_date }
       	};
      +	struct commit *commit;
       	int i;
     + 	int steps = 0;
       	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
       	struct commit_list **tail = result;
     -@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     + 
     + 	if (!min_generation && !corrected_commit_dates_enabled(r))
     +-		queue.pq.compare = compare_commits_by_commit_date;
     ++		state.queue.compare = compare_commits_by_commit_date;
     + 
     + 	one->object.flags |= PARENT1;
     + 	if (!n) {
       		commit_list_append(one, result);
       		return 0;
       	}
      -	nonstale_queue_put_dedup(&queue, one);
     -+	paint_queue_put(&queue, one, 0);
     ++	paint_queue_put(&state, one, 0);
       
      -	for (i = 0; i < n; i++) {
      -		twos[i]->object.flags |= PARENT2;
      -		nonstale_queue_put_dedup(&queue, twos[i]);
      -	}
      +	for (i = 0; i < n; i++)
     -+		paint_queue_put(&queue, twos[i], PARENT2);
     ++		paint_queue_put(&state, twos[i], PARENT2);
       
      -	while (queue.max_nonstale) {
      -		struct commit *commit = nonstale_queue_get_dedup(&queue);
     -+	while ((commit = paint_queue_get(&queue))) {
     ++	while ((commit = paint_queue_get(&state))) {
       		struct commit_list *parents;
       		int flags;
       		timestamp_t generation = commit_graph_generation(commit);
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       				continue;
       			if (repo_parse_commit(r, p)) {
      -				clear_nonstale_queue(&queue);
     -+				clear_prio_queue(&queue.pq);
     ++				clear_prio_queue(&state.queue);
       				commit_list_free(*result);
       				*result = NULL;
       				/*
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       			}
      -			p->object.flags |= flags;
      -			nonstale_queue_put_dedup(&queue, p);
     -+			paint_queue_put(&queue, p, flags);
     ++			paint_queue_put(&state, p, flags);
       		}
     -+
     -+		if (queue.p1_count + queue.p2_count +
     -+		    queue.pending_merge_bases == 0)
     -+			break;
       	}
       
      -	clear_nonstale_queue(&queue);
     -+	clear_prio_queue(&queue.pq);
     ++	clear_prio_queue(&state.queue);
     + 	trace2_data_intmax("paint_down_to_common", r,
     + 			   "steps", steps);
       	commit_list_sort_by_date(result);
     - 	return 0;
     - }
 -:  ---------- > 6:  8c72f01083 commit-reach: remove unused nonstale_queue dedup wrappers
 3:  ed12a5cb5b ! 7:  d84b932e5b commit-reach: terminate merge-base walk when one paint side is exhausted
     @@ Commit message
          commit-reach: terminate merge-base walk when one paint side is exhausted
      
          Add an early termination check to paint_down_to_common() using the
     -    per-side counters introduced in the previous commit. Once the walk
     -    enters the finite-generation region, terminate early when one side's
     -    exclusive count drops to zero -- no new merge-base can form without
     -    both paint sides meeting.
     +    per-side counters introduced earlier. Once the walk enters the
     +    finite-generation region, terminate early when one side's exclusive
     +    count drops to zero -- no new merge-base can form without both paint
     +    sides meeting.
      
          The check also waits for pending_merge_bases to reach zero, ensuring
     -    all merge-base candidates have been popped and recorded before
     +    all merge-base candidates have been dequeued and recorded before
          exiting.
      
          The INFINITY gate ensures correctness: commits without a commit-graph
     @@ Commit message
          once the walk enters the finite-generation region where ordering
          guarantees hold.
      
     -    On large repositories with commit-graph, this yields 100-1000x
     -    speedups for merge-base queries where one side (e.g. a PR branch) is
     -    much smaller than the other.
     +    Step counts measured with trace2 on git.git with commit-graph:
     +
     +      merge-base --all v2.0.0 v2.55.0-rc1:
     +        before: 72264 steps    after: 44589 steps
     +
     +      merge-base --all v2.55.0-rc1 v2.55.0-rc1~5:
     +        before:   110 steps    after:     7 steps
      
          Helped-by: Derrick Stolee <stolee@gmail.com>
          Helped-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     + ## Documentation/technical/paint-down-to-common.adoc ##
     +@@ Documentation/technical/paint-down-to-common.adoc: ends when one of the following conditions holds:
     + 
     +   1. The queue is empty.
     +   2. The queue contains only stale entries.
     ++  3. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
     ++     remain in the queue, no pending merge-base candidates exist,
     ++     and the walk has entered the finite-generation region.
     + 
     + Stale entry condition
     + ~~~~~~~~~~~~~~~~~~~~~
     +@@ Documentation/technical/paint-down-to-common.adoc: existing candidates by proving one is an ancestor of another, but
     + `remove_redundant()` handles that as a post-processing step, so it
     + is safe to exit early.
     + 
     ++Side-exhaustion condition
     ++~~~~~~~~~~~~~~~~~~~~~~~~~
     ++A new merge-base requires commits from both sides to meet. When one
     ++side's exclusive counter reaches zero and there are no pending
     ++merge-base candidates, no future traversal step can produce a new
     ++candidate.
     ++
     ++This optimization only activates in the finite-generation region
     ++where topological ordering holds. In that region, children are
     ++always visited before parents, so paint flags are final at visit
     ++time and an exhausted side cannot reappear. In the INFINITY region,
     ++commit-date ordering can violate this guarantee, so the check is
     ++skipped.
     ++
     + Related documentation
     + ---------------------
     + 
     +
       ## commit-reach.c ##
     -@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     - 		if (queue.p1_count + queue.p2_count +
     - 		    queue.pending_merge_bases == 0)
     - 			break;
     +@@ commit-reach.c: static void paint_queue_put(struct paint_state *state,
     + 
     + static struct commit *paint_queue_get(struct paint_state *state)
     + {
     +-	struct commit *commit;
     ++	struct commit *commit = prio_queue_get(&state->queue);
     + 
     +-	if (!state->p1_count && !state->p2_count &&
     +-	    !state->pending_merge_bases)
     ++	if (!commit)
     + 		return NULL;
     + 
     +-	commit = prio_queue_get(&state->queue);
     +-	if (commit) {
     +-		commit->object.flags &= ~ENQUEUED;
     +-		paint_count_update(state, commit->object.flags, -1);
     ++	commit->object.flags &= ~ENQUEUED;
      +
     ++	if (!state->pending_merge_bases) {
     ++		if (!state->p1_count && !state->p2_count)
     ++			return NULL;
      +		/*
      +		 * Side exhaustion: a new merge-base can only form
      +		 * when both PARENT1-only and PARENT2-only commits
     -+		 * remain in the queue.  In the finite-generation
     ++		 * remain in the queue. In the finite-generation
      +		 * region the queue is ordered topologically, so
      +		 * no future step can add paint to visited commits
      +		 * and an exhausted side cannot reappear.
      +		 */
     -+		if (generation < GENERATION_NUMBER_INFINITY &&
     -+		    queue.pending_merge_bases == 0 &&
     -+		    (queue.p1_count == 0 || queue.p2_count == 0))
     -+			break;
     ++		if ((!state->p1_count || !state->p2_count) &&
     ++		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
     ++			return NULL;
       	}
     ++
     ++	paint_count_update(state, commit->object.flags, -1);
     + 	return commit;
     + }
     + 
     +
     + ## t/t6600-test-reach.sh ##
     +@@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all commit-walk steps' '
     + 	cp commit-graph-full .git/objects/info/commit-graph &&
     + 	GIT_TRACE2_EVENT="$(pwd)/trace-full.txt" \
     + 		git merge-base --all commit-9-9 commit-9-1 >actual &&
     +-	test_trace2_data paint_down_to_common steps 80 <trace-full.txt &&
     ++	test_trace2_data paint_down_to_common steps 9 <trace-full.txt &&
     + 
     + 	cp commit-graph-half .git/objects/info/commit-graph &&
     + 	GIT_TRACE2_EVENT="$(pwd)/trace-half.txt" \
     + 		git merge-base --all commit-9-9 commit-9-1 >actual &&
     +-	test_trace2_data paint_down_to_common steps 81 <trace-half.txt
     ++	test_trace2_data paint_down_to_common steps 57 <trace-half.txt
     + '
       
     - 	clear_prio_queue(&queue.pq);
     + test_expect_success 'reduce_heads' '

-- 
gitgitgadget
