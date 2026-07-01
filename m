Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DCD18FC97
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923837; cv=none; b=EH0Wg/3nefPwq4T/+wqF1Y6Hlct4VtwDepF8dqi1HUxgTKIOtDewYhAd8e5XeYLfWHGUHeOtrayUgUKgylvgKuYQJhW1ipELzb3O21B+7fj0n1RI6yYuKDv6kLzt4l3pYOd9/2pdgp9XgSSHZucgcveEjM4esRebzWReQvRIZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923837; c=relaxed/simple;
	bh=cgnVyHTFVAnG9P2t7PYWAxbmTRr7bUBpqevBd52mQq8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XUgfMdnPOqto6CagNUibRp0DJ2XcHryTenkKKHhdfgTxlpYGp7sxrRHy6vE9H7krxQR7kMNkDXVmUr5iSVKXOn2Cq3Lfsn4JW9yajLTvuvxN6IxfQ2xD+sKXJX0utC3OG13GuFfzXiUpMlzmbjmBp3K7hvcL5uZ3We2sfQptVaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5sQzpPP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5sQzpPP"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-847917c3678so803695b3a.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923834; x=1783528634; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e66hJEI4DjSNFJfx6XUKDh2+w0p3RW6hJJb5vk75qlc=;
        b=R5sQzpPPrRbAhe96t5zRTYCEpgI26iRR+R7jJHWzyvo8Cfx7u8MPhF8cSx8tiPfstJ
         POSLMzXOjv1mJaT45ap4pSjc+bzka5jtiTQoMqeB9WB85AeF9ckGdNs4K9YvAo+Qh42j
         1PPdHMXDy35wNhL7AeybvWgAgOuSipSDEC+Q2FOO/N6j+//gsolfKVRosY134r9ZNEnF
         Ce8xNmQxhBqYFgEW1pENuth6Wy9cidXnRK8yVUOgslWyuPzAJ5nITxgMuHjT4RnfDB0g
         0+BgdYh1C4LHtpdygcCu9MZOZPaLT4ErTz7I3nnkpWS4amAnhwXrBsbS4jdUnFTECFQS
         jPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923834; x=1783528634;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e66hJEI4DjSNFJfx6XUKDh2+w0p3RW6hJJb5vk75qlc=;
        b=r9cO3IHAl78yt5DQS6j6K/zV3O+YMFR08suLBj2GorN2aV7Z4y3EEO4Gk9inmr8+tU
         dbqvGsRJVIP+cvDqCUUKjD+2BvXscwg9oEnTSGDMCiTkcUGPlGxpiGj606j7Us9ePCjd
         MJxes2JNno19Gk5JArwGD5TNZBaUbQJLfapVonn5OwXWmFmgpZJ0Y58VWLMw0qFx59HZ
         eJ73ZK46MLijnyhRzKJXDMT54ENWR9m+ph77sy/pamxj5HEDpthSuj9wjlUHSNaArqR8
         tYJe3g5Ds70oA3iqA7Wf9AQHs8SysxugfzhkyXibVpL1yd4AkPuDAKj8T9KoX1o2cEwq
         +UaA==
X-Gm-Message-State: AOJu0YyASf9mqXHSYWJ+32tAPg6R9UsE/0wHo59dKhcQXbiutaad8KS+
	k9D1taJE6Ih+y9j2NltwMlQDNBSYq2Y6+SwXEPWrFG4nGYuRFKV/tHhj3L/VGg==
X-Gm-Gg: AfdE7clsATZhGDonrxd2hTr9OoNRKGgAPysTe8+b6GeGkpkptFjwoyYFHEqqELdtT8U
	JuJcq5l0qcPmMIEaTcs0moQH/CT1AM2/UkLpUh6aPutvJ64KWXK4LqNv5Y/BeUrYqosxXDR9HkE
	ctx06VLRg337+4WWfzlks9BNh3xhEtfcDIbHHnO0ykPLzrOgcTz9YsKTOsP8IjisWFoZd1dDqUx
	mO0nIFj3U9Hur0MSQcve4hphTwVCaB8V/jDLWlXg/BiWiJL/yUNSwhJE50LZgUF4v/pn4ABwk59
	IVkMpL8kBbnuYVt77j1rkz2N6xYDFMNFqZ18X+2f76zir/ODFqQ85kkysI2g8rlpP/eQ/KV60tt
	Pt4ruD4BYV3pI/8IKpCNhHA1l72wsD4dS9GsSbu3ETRfwJRW+ibCqhVo9GPIJMLflOOBW6zpxFb
	OcIoV+0CEux3+9R7k=
X-Received: by 2002:aa7:9315:0:b0:847:888f:9b0f with SMTP id d2e1a72fcca58-847bf944a63mr1913313b3a.15.1782923833993;
        Wed, 01 Jul 2026 09:37:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.198.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb949a40sm63497b3a.37.2026.07.01.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:37:13 -0700 (PDT)
Message-Id: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 16:37:01 +0000
Subject: [PATCH v5 00/10] commit-reach: terminate merge-base walk when one side is exhausted
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
Cc: Kristofer Karlsson <krka@spotify.com>

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
[2]. Patch 3 incorporates test cases from Elijah's branch.

This series implements the optimization only after the walk enters the
finite-generation region, where generation ordering guarantees that paint on
visited commits is final.

Patch 2 adds a test_trace2_data_singular helper to test-lib-functions.sh
that reports expected/actual values on assertion failure instead of a silent
grep exit. This was invaluable during development for iterating on step
counts across the series, and should be valuable for repairing tests after
future algorithmic changes. Happy to drop it if it is considered unnecessary
infrastructure.

The final patch removes the commit-date ordering fallback introduced by
091f4cf3 (commit: don't use generation numbers if not needed, 2018-08-30).
With side-exhaustion in place, the fallback is no longer needed for
performance, and removing it ensures the queue is always generation-ordered
regardless of graph version, so every termination condition can rely on a
single ordering invariant. This patch can be dropped if the scope is too
broad for this series.

NOTE: If the final patch is kept, the separate "commit-reach: fix !FIND_ALL
early exit with v1 commit graph" topic becomes unnecessary. Either way, the
two topics conflict trivially and I am happy to reroll whichever lands
second.

Benchmarks

Trace2 step counts are deterministic (measured via trace2_data_intmax added
in patch 5). Wall-clock times are best-of-11 runs.

2.6M-commit monorepo with commit-graph:

                                      steps              wall-clock
merge-base --all  (across import)  2143438 ->      3     3.67s ->    5ms
merge-base --all  (1000 apart)     2692915 ->   1035     4.41s ->    7ms
merge-base --all  (5000 apart)     2692915 ->   6401     4.45s ->   13ms
merge-base --all  (HEAD vs import) 2698872 ->  45960     4.50s ->   79ms
merge-tree        (across import)  2143438 ->      3     4.42s ->   11ms


git.git (88k commits, commit-graph):

                                      steps              wall-clock
merge-base --all v2.0.0 v2.55.0-rc1 72264 ->  44589      110ms ->   68ms
merge-base --all HEAD HEAD~1000      9891 ->   3828       18ms ->   10ms
merge-base --all HEAD HEAD~10000    72303 ->  41487      101ms ->   50ms


CC: Derrick Stolee stolee@gmail.com CC: Elijah Newren newren@gmail.com

[1]
https://lore.kernel.org/git/CAL71e4Ps-2_0+uuZu43N9pFnXBemoAohPs_eyRJf8taXHJPAXQ@mail.gmail.com/T/#u
[2] https://github.com/gitgitgadget/git/pull/2150

Changes since v4:

 * New patch 2/10: added test_trace2_data_singular helper to
   test-lib-functions.sh. Shows expected/actual values on assertion failure
   instead of a silent grep failure. Makes iterating on step counts much
   easier.

 * New patch 6/10: added clock-skew topologies (se-, se2-) that expose
   side-exhaustion bugs when the commit-date ordering fallback fires with a
   v1 commit graph. All topologies use a shared skew_commit helper. Includes
   step count assertions for edge-case tests from patch 3.

 * Folded the nonstale_queue dedup wrapper removal (previously separate
   patch 6/8) into the paint_state introduction in patch 7/10.

 * New patch 10/10: remove the commit-date ordering fallback in
   paint_down_to_common(). The fallback (091cf18e) was a performance
   optimization for v1 commit graphs, but it breaks the generation ordering
   invariant that both the side-exhaustion and single-result optimizations
   depend on. With side-exhaustion in place, the fallback is no longer
   needed. If kept, this supersedes the separate "commit-reach: fix
   !FIND_ALL early exit with v1 commit graph" topic.

Changes since v3:

 * Fixed BUG assertion that was accidentally made unconditional in v3:
   restored the min_generation guard so it only fires when generation-based
   ordering is active.

 * Moved generation cutoff and single-result termination conditions into the
   documentation in patch 1, since they describe existing behavior.

 * Renamed paint_state counter fields for clarity: p1_count ->
   parent1_count, p2_count -> parent2_count, pending_merge_bases ->
   mb_candidate_count. Changed counter types from int to size_t. (Suggested
   by Rene Scharfe.)

Changes since v2:

 * New patch 9/10 (was 8/8): moved the min_generation termination check and
   the last_gen monotonicity assertion into paint_queue_get(), consolidating
   halt conditions. commit_graph_generation() is now called once per
   dequeued commit and shared across all checks.

 * Moved all halt conditions inside paint_queue_get() with the "pop first"
   form: pop, check, then decrement counters. This keeps the optimization
   commit's diff minimal (just inserting the new checks between pop and
   decrement).

 * Shortened the doc comment on paint_queue_get() to describe what it does
   rather than how. Inline comments on each return NULL explain the specific
   halt condition.

 * Replaced the manual commit-graph setup in the step-count test with
   run_all_modes, which now sets GIT_TRACE2_EVENT per mode and produces
   trace-mode-{none,full,half,no-gdat}.txt files.

 * Added a test_paint_down_steps helper for concise 4-mode step assertions
   with diagnostic output on mismatch (prints "expected X, got Y" instead of
   a silent grep failure).

 * Added step-count assertions to the single-walk edge-case tests:
   in_merge_bases_many:self, pending-stale, infinity-both-sides,
   mixed-finite-infinity.

 * Included step counts alongside wall-clock times in the benchmark tables.

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

 * Added trace2_data_intmax() instrumentation to report the number of
   commits visited per paint walk (separate commit), with step-count
   assertions in tests for deterministic regression detection.

Elijah Newren (1):
  t6600: add test cases for side-exhaustion edge cases

Kristofer Karlsson (9):
  Documentation/technical: add paint-down-to-common doc
  test-lib-functions: improve diagnostic output for trace2 data
    assertions
  t6099, t6600: add side-exhaustion regression tests
  commit-reach: add trace2 instrumentation to paint_down_to_common()
  t6600: add clock-skew topologies and step counts for edge cases
  commit-reach: introduce struct paint_state with per-side counters
  commit-reach: terminate merge-base walk when one paint side is
    exhausted
  commit-reach: move min_generation check into paint_queue_get()
  commit-reach: remove commit-date ordering fallback

 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/paint-down-to-common.adoc       | 151 +++++++++
 commit-graph.c                                |  11 -
 commit-graph.h                                |   6 -
 commit-reach.c                                | 152 ++++++---
 t/meson.build                                 |   1 +
 t/t6099-merge-base-side-exhaustion.sh         |  82 +++++
 t/t6600-test-reach.sh                         | 289 +++++++++++++++++-
 t/test-lib-functions.sh                       |  36 +++
 10 files changed, 663 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/technical/paint-down-to-common.adoc
 create mode 100755 t/t6099-merge-base-side-exhaustion.sh


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2149%2Fspkrka%2Fside-exhaust-pr-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2149/spkrka/side-exhaust-pr-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2149

Range-diff vs v4:

  1:  3efb095b03 !  1:  be00f5aaa1 Documentation/technical: add paint-down-to-common doc
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +  - PARENT1: reachable from `one`
      +  - PARENT2: reachable from any commit in `twos[]`
      +
     -+The walk uses a priority queue ordered by generation number (falling
     -+back to commit date when generation numbers are unavailable). Each
     -+step dequeues the highest-priority commit (this is when we say a
     -+commit is "visited") and propagates its paint flags to its parents,
     -+enqueuing them if they gained new flags. When a commit receives
     -+both PARENT1 and PARENT2, it is a merge-base candidate. A candidate
     -+gains the STALE flag so its ancestors propagate staleness -- any
     -+deeper common ancestor is necessarily redundant.
     -+
     ++The walk uses a priority queue ordered by generation number
     ++(highest first), breaking ties by commit date. Each step dequeues
     ++the highest-priority commit (this is when we say a commit is
     ++"visited") and propagates its paint flags to its parents, enqueuing
     ++them if they gained new flags. When a commit receives both PARENT1
     ++and PARENT2, it is a merge-base candidate. A candidate gains the
     ++STALE flag so its ancestors propagate staleness -- any deeper common
     ++ancestor is necessarily redundant.
     ++
     ++NOTE: When the commit-graph uses only topological levels (generation
     ++number v1) and the caller passes `min_generation = 0`, a legacy
     ++fallback replaces the generation-ordered comparator with a pure
     ++commit-date comparator. This breaks the ordering invariants
     ++described below -- see <<date-ordering-fallback>>.
     ++
     ++[[generation-regions]]
      +INFINITY and finite generation regions
      +--------------------------------------
      +
     ++The properties in this section assume generation-number ordering (the
     ++default comparator). They do NOT hold when the date-ordering fallback
     ++is active -- see <<date-ordering-fallback>>.
     ++
      +The commit-graph stores a generation number for each commit. Commits
      +not in the commit-graph have generation `GENERATION_NUMBER_INFINITY`. The
      +graph is closed under reachability: if a commit is in the graph, all
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +
      +Single result
      +~~~~~~~~~~~~~
     -+When only one merge base is needed and the walk is in the
     -+finite-generation region, the first candidate found is necessarily
     -+the highest-generation common ancestor. No remaining commit in the
     -+queue can be a descendant of this candidate (generation ordering
     -+guarantees children are visited first), so it cannot be redundant
     -+and the walk can stop immediately.
     ++When only one merge base is needed, the walk is in the
     ++finite-generation region, and the queue uses generation ordering,
     ++the first candidate found is necessarily the highest-generation
     ++common ancestor. No remaining commit in the queue can be a
     ++descendant of this candidate (generation ordering guarantees
     ++children are visited first), so it cannot be redundant and the walk
     ++can stop immediately.
     ++
     ++This optimization is NOT safe when the date-ordering fallback is
     ++active, because commit-date order can visit a deeper ancestor
     ++before a shallower one -- see <<date-ordering-fallback>>.
     ++
     ++[[date-ordering-fallback]]
     ++Date-ordering fallback
     ++----------------------
     ++
     ++When `min_generation` is zero and the commit-graph does not contain
     ++corrected commit dates (generation number v1, which stores only
     ++topological levels), `paint_down_to_common()` replaces the default
     ++generation-ordered comparator with `compare_commits_by_commit_date`.
     ++
     ++This was introduced as a performance heuristic: topological levels
     ++are coarser than commit dates, so date ordering can reach merge
     ++bases in fewer steps when timestamps are well-behaved. However,
     ++commit dates are not required to be monotonic -- a parent can have
     ++a later date than its child (clock skew, rebases, etc.) -- so the
     ++queue may visit commits out of topological order.
     ++
     ++This disables optimizations that depend on generation ordering:
     ++
     ++  1. *Single result*: the first merge-base candidate found may not
     ++     be the shallowest, because a deeper ancestor with a higher
     ++     commit date can be dequeued first.
     ++
     ++  2. *Side-exhaustion* (see subsequent commits): one paint side can
     ++     appear to drain from the queue while commits from that side are
     ++     still waiting with lower dates, causing premature termination.
      +
      +Related documentation
      +---------------------
  -:  ---------- >  2:  143f5e0cc1 test-lib-functions: improve diagnostic output for trace2 data assertions
  2:  1a0154b406 !  3:  eec4a9d926 t6600: add test cases for side-exhaustion edge cases
     @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
      +	pi_x="$(cat pi-X-oid)" &&
      +	git branch -f pi-X-br "$pi_x" &&
      +	git tag pi-X "$pi_x" &&
     -+
       	git commit-graph write --reachable &&
       	mv .git/objects/info/commit-graph commit-graph-full &&
       	chmod u+w commit-graph-full &&
  3:  017bf156c5 !  4:  7f0efe6c73 t6099, t6600: add side-exhaustion regression tests
     @@ t/t6099-merge-base-side-exhaustion.sh (new)
      +'
      +
      +test_done
     -
     - ## t/t6600-test-reach.sh ##
     -@@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:infinity-both-sides' '
     - 	test_all_modes get_merge_bases_many
     - '
     - 
     -+test_expect_success 'setup mixed finite/INFINITY topology' '
     -+	# Create a commit outside all saved commit-graph files so it always
     -+	# has INFINITY generation, while its parent (ps-X) is in the graph
     -+	# with a finite generation. Use the ps-* orphan topology so we do
     -+	# not pollute the grid-based rev-list tests.
     -+	git checkout ps-X &&
     -+	test_env GIT_TEST_COMMIT_GRAPH= test_commit pm-INF
     -+'
     -+
     -+test_expect_success 'get_merge_bases_many:mixed-finite-infinity' '
     -+	# One tip (pm-INF) is outside the commit-graph with INFINITY
     -+	# generation; the other (ps-B) is in the graph with finite
     -+	# generation. The walk starts in the INFINITY region and crosses
     -+	# into the finite region where side-exhaustion can fire.
     -+	cat >input <<-\EOF &&
     -+	A:pm-INF
     -+	X:ps-B
     -+	EOF
     -+	{
     -+		echo "get_merge_bases_many(A,X):" &&
     -+		git rev-parse ps-X
     -+	} >expect &&
     -+	test_all_modes get_merge_bases_many
     -+'
     -+
     - test_expect_success 'reduce_heads' '
     - 	cat >input <<-\EOF &&
     - 	X:commit-1-10
  4:  df3b090a2b !  5:  b9fb8bfe26 commit-reach: add trace2 instrumentation to paint_down_to_common()
     @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
      +test_paint_down_steps () {
      +	for mode in none full half no-gdat
      +	do
     -+		test_trace2_data paint_down_to_common steps "$1" \
     -+			<"trace-mode-${mode}.txt" || return 1
     ++		test_trace2_data_singular paint_down_to_common steps "$1" \
     ++			"mode=$mode" <"trace-mode-${mode}.txt" || return 1
      +		shift
      +	done
      +}
     @@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases_many:self' '
       '
       
       test_expect_success 'is_descendant_of:hit' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:pending-stale' '
     - 		echo "get_merge_bases_many(A,X):" &&
     - 		git rev-parse ps-B
     - 	} >expect &&
     --	test_all_modes get_merge_bases_many
     -+	test_all_modes get_merge_bases_many &&
     -+	test_paint_down_steps 6 6 6 6
     - '
     - 
     - test_expect_success 'get_merge_bases_many:infinity-both-sides' '
      @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:infinity-both-sides' '
     - 		echo "get_merge_bases_many(A,X):" &&
     - 		git rev-parse pi-B
     - 	} >expect &&
     --	test_all_modes get_merge_bases_many
     -+	test_all_modes get_merge_bases_many &&
     -+	test_paint_down_steps 5 5 5 5
     + 	test_all_modes get_merge_bases_many
       '
       
     - test_expect_success 'setup mixed finite/INFINITY topology' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:mixed-finite-infinity' '
     - 		echo "get_merge_bases_many(A,X):" &&
     - 		git rev-parse ps-X
     - 	} >expect &&
     --	test_all_modes get_merge_bases_many
     -+	test_all_modes get_merge_bases_many &&
     -+	test_paint_down_steps 3 3 3 3
     -+'
     -+
      +test_expect_success 'merge-base --all commit-walk steps' '
      +	>input &&
      +	git rev-parse commit-9-1 >expect &&
      +	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
      +	test_paint_down_steps 81 80 81 81
     - '
     - 
     ++'
     ++
       test_expect_success 'reduce_heads' '
     + 	cat >input <<-\EOF &&
     + 	X:commit-1-10
  -:  ---------- >  6:  c6e3cc13f7 t6600: add clock-skew topologies and step counts for edge cases
  5:  fed9f2c368 !  7:  42a75899f2 commit-reach: introduce struct paint_state with per-side counters
     @@ Commit message
          earlier than the old code in some topologies (the popped stale
          commit is never processed), so a few step counts drop by one.
      
     -    The existing nonstale_queue is left in place for ahead_behind().
     +    The existing nonstale_queue is left in place for ahead_behind(),
     +    though nonstale_queue_put_dedup() and nonstale_queue_get_dedup()
     +    became unused and are removed.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     @@ Documentation/technical/paint-down-to-common.adoc: re-enqueued is bounded by the
         4. Single result: the caller only needs one merge base, one has
      
       ## commit-reach.c ##
     -@@ commit-reach.c: static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
     - 	return commit;
     +@@ commit-reach.c: static void clear_nonstale_queue(struct nonstale_queue *queue)
     + 	queue->max_nonstale = NULL;
       }
       
     +-static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
     +-				     struct commit *c)
      +/*
      + * Priority queue with per-side commit counters for paint_down_to_common().
      + * Each non-stale queued commit occupies exactly one bucket: PARENT1-only,
     @@ commit-reach.c: static struct commit *nonstale_queue_get_dedup(struct nonstale_q
      +	size_t parent1_count;
      +	size_t parent2_count;
      +	size_t mb_candidate_count;
     ++	int gen_ordered;
      +};
      +
      +static void paint_count_update(struct paint_state *state,
      +			       unsigned flags, int delta)
     -+{
     + {
     +-	if (c->object.flags & ENQUEUED)
     +-		return;
     +-	c->object.flags |= ENQUEUED;
     +-	nonstale_queue_put(queue, c);
      +	switch (flags & (PARENT1 | PARENT2 | STALE)) {
      +	case PARENT1:
      +		state->parent1_count += delta;
     @@ commit-reach.c: static struct commit *nonstale_queue_get_dedup(struct nonstale_q
      +	default:
      +		BUG("unexpected paint state");
      +	}
     -+}
     -+
     + }
     + 
     +-static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
      +static void paint_queue_put(struct paint_state *state,
      +			    struct commit *c, unsigned add_flags)
     -+{
     + {
     +-	struct commit *commit = nonstale_queue_get(queue);
      +	unsigned old_flags = c->object.flags;
      +	c->object.flags |= add_flags;
      +
     @@ commit-reach.c: static struct commit *nonstale_queue_get_dedup(struct nonstale_q
      +		paint_count_update(state, c->object.flags, 1);
      +	}
      +}
     -+
     + 
     +-	if (commit)
     +-		commit->object.flags &= ~ENQUEUED;
      +static struct commit *paint_queue_get(struct paint_state *state)
      +{
      +	struct commit *commit = prio_queue_get(&state->queue);
     @@ commit-reach.c: static struct commit *nonstale_queue_get_dedup(struct nonstale_q
      +		return NULL;
      +
      +	paint_count_update(state, commit->object.flags, -1);
     -+	return commit;
     -+}
     -+
     - /*
     -  * See Documentation/technical/paint-down-to-common.adoc
     -  *
     + 	return commit;
     + }
     + 
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       				enum merge_base_flags mb_flags,
       				struct commit_list **result)
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
      -	struct nonstale_queue queue = {
      -		{ compare_commits_by_gen_then_commit_date }
      +	struct paint_state state = {
     -+		.queue = { compare_commits_by_gen_then_commit_date }
     ++		.queue = { compare_commits_by_gen_then_commit_date },
     ++		.gen_ordered = 1,
       	};
      +	struct commit *commit;
       	int i;
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
       	struct commit_list **tail = result;
       
     - 	if (!min_generation && !corrected_commit_dates_enabled(r))
     +-	if (!min_generation && !corrected_commit_dates_enabled(r))
      -		queue.pq.compare = compare_commits_by_commit_date;
     ++	if (!min_generation && !corrected_commit_dates_enabled(r)) {
      +		state.queue.compare = compare_commits_by_commit_date;
     ++		state.gen_ordered = 0;
     ++	}
       
       	one->object.flags |= PARENT1;
       	if (!n) {
     @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:infinity-both-s
       '
       
       test_expect_success 'setup mixed finite/INFINITY topology' '
     +@@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all with clock skew returns wrong merge base (
     + 	>input &&
     + 	git rev-parse se2-MB1 >expect &&
     + 	run_all_modes git merge-base --all se2-A se2-B &&
     +-	test_paint_down_steps 8 7 8 8
     ++	test_paint_down_steps 8 6 8 8
     + '
     + 
     + test_expect_success 'reduce_heads' '
  6:  4db485b48a <  -:  ---------- commit-reach: remove unused nonstale_queue dedup wrappers
  7:  4506780649 !  8:  f8f00b7bcc commit-reach: terminate merge-base walk when one paint side is exhausted
     @@ commit-reach.c: static struct commit *paint_queue_get(struct paint_state *state)
      +
      +		/* one side is exhausted */
      +		if ((!state->parent1_count || !state->parent2_count) &&
     ++		    state->gen_ordered &&
      +		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
      +			return NULL;
      +	}
     @@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all commit-walk steps'
       	git rev-parse commit-9-1 >expect &&
       	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
      -	test_paint_down_steps 81 80 81 81
     -+	test_paint_down_steps 81 9 57 10
     ++	test_paint_down_steps 81 9 57 81
       '
       
     - test_expect_success 'reduce_heads' '
     + test_expect_success 'merge-base --all with clock skew and v1 commit-graph (side-exhaustion)' '
  8:  8dd15d44e6 !  9:  b45c302caa commit-reach: move min_generation check into paint_queue_get()
     @@ Commit message
      
       ## commit-reach.c ##
      @@ commit-reach.c: struct paint_state {
     - 	size_t parent1_count;
       	size_t parent2_count;
       	size_t mb_candidate_count;
     + 	int gen_ordered;
      +	timestamp_t min_generation;
      +	timestamp_t last_gen;
       };
     @@ commit-reach.c: static void paint_queue_put(struct paint_state *state,
       	if (!state->mb_candidate_count) {
       		/* only stale entries remain */
      @@ commit-reach.c: static struct commit *paint_queue_get(struct paint_state *state)
     - 
       		/* one side is exhausted */
       		if ((!state->parent1_count || !state->parent2_count) &&
     + 		    state->gen_ordered &&
      -		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
      +		    generation < GENERATION_NUMBER_INFINITY)
       			return NULL;
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       
      +	state.min_generation = min_generation;
      +	state.last_gen = GENERATION_NUMBER_INFINITY;
     - 	if (!min_generation && !corrected_commit_dates_enabled(r))
     + 	if (!min_generation && !corrected_commit_dates_enabled(r)) {
       		state.queue.compare = compare_commits_by_commit_date;
     - 
     + 		state.gen_ordered = 0;
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       	while ((commit = paint_queue_get(&state))) {
       		struct commit_list *parents;
  -:  ---------- > 10:  d68972b1d7 commit-reach: remove commit-date ordering fallback

-- 
gitgitgadget
