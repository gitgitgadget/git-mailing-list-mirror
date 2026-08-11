Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037F3FE65F
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440539; cv=none; b=DOCjOwFN0kYughPNo951ODb4pCRi6TlueuhEoYfW2cNEPiTQRKKhSoYdhuEAG0lravY1VhUpnFolLfqYebGZbZvZ4yveNklJI4aAcpbBBHyezKs/bRAYQni6QW+UXgqlRG82Kc/Ge6V9zilgdG+a7TrHeHO6D32EGZOeWmcj1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440539; c=relaxed/simple;
	bh=fnZ+iMJUo/DuRDzLO4ex3L4HscaIBS1fBclatDDmCV8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ruCB0EwpRon7Ws5GPOnvuNd4UQXM+YESmmNh1Oiim6w7KI20x+wM7YqcUM8PrBPER6uW87eGsLlYjDxN8upvla4G1b9jV2AdsnCxtkRvVYTEz60OcR5cFedFe5b9bVVrE7vDt0HxYgcE4K/koPRIMmA7+CdARgPcS8MNTSInTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfhK2bGj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfhK2bGj"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2033932a91.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440536; x=1787045336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wMr+mjkxIYU6LJOs6FwRgx6sGJdqFsv9mQmcRGFxn8U=;
        b=VfhK2bGjp5lOsc2Tm8TmTYPNuYGCyjMOvqg7Myj/8GQz7zXpMFzYKAVV6Z1sECXLNW
         yNkXyLa8rtyo6KFflLDDmjTJLCXIYAdlmH5hnT5SQg1B7KgZ8wJnkQKP4Z0vhztH6qbf
         KTC54+zlhWnPt/QX/xC/VSK3HvpkwKX8cgPFb6/jLTXnUNvF1EacwIK0AqD+0U60oky+
         dLaP+tbFf+MDVXKKpaYoPJlH+2V3bwr8uStqHnq6mnFDdsExqI0s7cE7Kzo1Fao4BiUQ
         z2RmerZuuvXSNJiovmYfRbaFvGtHhYtNNaBcYfC6CTkXktRgrcKB9WQsZ9aiaTRGtW82
         3XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440536; x=1787045336;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMr+mjkxIYU6LJOs6FwRgx6sGJdqFsv9mQmcRGFxn8U=;
        b=Ru3aHcAguUo5g3r2dlWAe+RD3e8WBbTWAEJAobSMkVIkTWhnHYtHlamj7BjDmO7Io6
         ydtPRp+3Lfaxy/v8IBd2PrJ29PWWFtnH6Jk/Fko85hIt3xJzp31iiqFtEHErkt3Srlf+
         PF1ydOJNHkNRBd4DJ/qvkogqitzZ1GOIISsgehcwT0rpC9G/ga1nt2rjehY+r3kq1ZST
         V/KeUkfkCzBataKeTAHGViq58QnOqQ8XhIn/tfZbECOu/RGyY6RNopyNPuI66YZl+1cy
         1UxJsxfOM88ES57npNySu6Rn6gwqNSmMiDC+5NtSXlo6f8j/0iH5JFNvA/0H5Qm8pbI9
         E1oQ==
X-Gm-Message-State: AOJu0YymbLN6DFsI9V9dDJZ232xq9jABfGY879zrSmU26QGanvyEQaDv
	Dln0HKbIPmCbUv0CvEIp0a2lKyS2DdIlLuHOGRmJzShXDDr9hojRQMglT5d45Enh
X-Gm-Gg: AR+sD10kUMqCGaKc3cP9E42YN6chPCb+ZfUJV213fhemMtOsndtkawRPmNrMj/Z7Q6e
	XfoNkzxN/cbevGRZM6in3afCcsWoibbELCqQNgCsyqXrsolzgIkoXq7ni9nLKhKN60zM+uXMVlS
	A97JfKFhzOGeAdv02brfM+kHBFC4MpKiFr1PYw7yPiV5SGZOCJnRmUlKWSEGn5pxMNLtHawPstr
	QqiP7h3BlNRFNeCZxWZ19q3kjqQpWjLTvFgHgB5eZdF5LB2wxtxGok334IAdCYyORm4+BD8Az1p
	oU0sic3m/HaR4spxTdpxdHgnvKwOFFLIxsqMLp00TE25/VwO9uRsWij9QRkp/3OIenhMYXsLQ6L
	tdBwq6IlXoCa06F5fHnk9cvTdP2lQpmbqViwVwpYYqNWRmDJVsU+McbFO6alS2nvqRUZh0gzdDZ
	EZgEI9RAH5AK2lC/R+OPY2ypInf6n8hApc6IgFRWaa1wn/7rv9WhuX9wDRGhEM1xk=
X-Received: by 2002:a17:90b:3809:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-392ec56af8cmr1540543a91.10.1786440534939;
        Tue, 11 Aug 2026 02:28:54 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392ee445c72sm1232742a91.17.2026.08.11.02.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:28:54 -0700 (PDT)
Message-Id: <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 09:28:42 +0000
Subject: [PATCH v8 00/10] commit-reach: terminate merge-base walk when one side is exhausted
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
ordered region, where generation ordering guarantees that paint on visited
commits is final.

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


This series is based on master.

[1]
https://lore.kernel.org/git/CAL71e4Ps-2_0+uuZu43N9pFnXBemoAohPs_eyRJf8taXHJPAXQ@mail.gmail.com/T/#u
[2] https://github.com/gitgitgadget/git/pull/2150

Changes since v7:

 * Moved topo_ceiling from patch 10 into patch 8 where the side-exhaustion
   gate first needs it, so V1_MAX saturation is handled correctly at every
   commit in the series.

 * Renamed "finite/INFINITY region" to "ordered/unordered region" in
   documentation and in general tried to tighten up the documentation around
   this.

 * Added code comment explaining why termination conditions must be checked
   before decrementing counters in paint_queue_get().

 * Minor wording and formatting fixes in commit messages, test comments, and
   the t6099 ASCII graph.

Changes since v6:

 * Now based on master; all prerequisite topics have graduated.

 * Added a topological ceiling concept for v1 commit-graph support. When the
   commit-graph uses v1 topological levels (no GDAT chunk), generation
   numbers saturate at V1_MAX, breaking ordering guarantees in the same way
   as INFINITY. Patch 10 introduces a topo_ceiling (V1_MAX for v1, INFINITY
   for v2) that the side-exhaustion and single-result gates compare against,
   so saturated commits are treated as unordered.

 * Used $LF variable instead of a literal newline in the
   test_trace2_data_singular helper (patch 2), matching the existing pattern
   in test-lib. (Suggested by Rene Scharfe.)

 * Improved the min_generation / generation cutoff documentation to explain
   why callers can safely terminate early, rather than just stating the
   threshold rule.

Changes since v5:

 * Rebased on next, which now contains kk/commit-reach-find-all-fix. The
   gen_ordered guard from that topic is carried through patches 7-9 via
   state.gen_ordered, then removed in patch 10 along with the date-ordering
   fallback.

 * Minor documentation and test comment improvements.

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

cc: Derrick Stolee stolee@gmail.com cc: Elijah Newren newren@gmail.com cc:
Kristofer Karlsson krka@spotify.com cc: René Scharfe l.s.r@web.de cc: SZEDER
Gábor szeder.dev@gmail.com

Elijah Newren (1):
  t6600: add test cases for side-exhaustion edge cases

Kristofer Karlsson (9):
  Documentation/technical: add paint-down-to-common doc
  test-lib-functions: improve diagnostic output for trace2 data
    assertions
  t6099: add side-exhaustion regression test
  commit-reach: add trace2 instrumentation to paint_down_to_common()
  t6600: add clock-skew topologies and step counts for edge cases
  commit-reach: introduce struct paint_state with per-side counters
  commit-reach: terminate merge-base walk when one paint side is
    exhausted
  commit-reach: move min_generation check into paint_queue_get()
  commit-reach: remove commit-date ordering fallback

 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/paint-down-to-common.adoc       | 155 +++++++++++
 commit-reach.c                                | 165 +++++++++---
 t/meson.build                                 |   1 +
 t/t6099-merge-base-side-exhaustion.sh         |  82 ++++++
 t/t6600-test-reach.sh                         | 241 +++++++++++++++++-
 t/test-lib-functions.sh                       |  35 +++
 8 files changed, 627 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/technical/paint-down-to-common.adoc
 create mode 100755 t/t6099-merge-base-side-exhaustion.sh


base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2149%2Fspkrka%2Fside-exhaust-pr-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2149/spkrka/side-exhaust-pr-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/2149

Range-diff vs v7:

  1:  c1f303353c !  1:  d74c9d5781 Documentation/technical: add paint-down-to-common doc
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +
      +The walk uses a priority queue ordered by generation number
      +(highest first), breaking ties by commit date. Each step dequeues
     -+the highest-priority commit (this is when we say a commit is
     -+"visited") and propagates its paint flags to its parents, enqueuing
     -+them if they gained new flags. When a commit receives both PARENT1
     -+and PARENT2, it is a merge-base candidate. A candidate gains the
     -+STALE flag so its ancestors propagate staleness -- any deeper common
     -+ancestor is necessarily redundant.
     ++the highest-priority commit and propagates its paint flags to its
     ++parents, enqueuing any parent that gained new flags. When a
     ++commit receives both PARENT1 and PARENT2, it is a merge-base
     ++candidate. A candidate gains the STALE flag so its ancestors
     ++propagate staleness -- any deeper common ancestor is necessarily
     ++redundant.
      +
      +[[generation-regions]]
     -+INFINITY and finite generation regions
     -+--------------------------------------
     ++Topologically ordered and unordered generation regions
     ++------------------------------------------------------
      +
     -+The properties in this section assume generation-number ordering (the
     -+default comparator). They do NOT hold when the date-ordering fallback
     -+is active -- see <<date-ordering-fallback>>.
     -+
     -+The commit-graph stores a generation number for each commit.
     -+Commits not in the commit-graph have generation
     -+`GENERATION_NUMBER_INFINITY`. The graph is closed under
     -+reachability: if a commit is in the graph, all its ancestors are
     -+too. This partitions the commit graph into two regions:
     ++Commits fall into two regions based on whether their generation
     ++numbers provide a topological ordering guarantee:
      +
      +....
     -+    +---------------------------------------+
     -+    |          INFINITY region              |
     -+    |  generation = INFINITY                |
     -+    |  queue order: heuristic (commit date) |
     -+    +---------------------------------------+
     -+                    |
     -+                    v
     -+    +---------------------------------------+
     -+    |          Finite region                |
     -+    |  generation = finite                  |
     -+    |  queue order: topological             |
     -+    +---------------------------------------+
     ++    +------------------------------------------+
     ++    |          Unordered region                |
     ++    |  generation = INFINITY or V1_MAX         |
     ++    |  queue order: heuristic (commit date)    |
     ++    +------------------------------------------+
     ++                      |
     ++                      v
     ++    +------------------------------------------+
     ++    |          Ordered region                  |
     ++    |  generation = finite, unsaturated        |
     ++    |  queue order: topological                |
     ++    +------------------------------------------+
      +....
      +
     -+When the commit-graph is enabled, the INFINITY region is typically
     -+very small -- it only contains commits added since the last
     -+commit-graph refresh.
     -+
     -+With v1 commit-graphs (topological levels, no GDAT chunk),
     -+generation numbers saturate at `GENERATION_NUMBER_V1_MAX`.
     -+Saturated commits share the same generation value despite
     -+different topological depths, which breaks ordering guarantees
     -+in the same way as INFINITY. The early exit gates compare
     -+against `GENERATION_NUMBER_V1_MAX` for v1 graphs and
     -+`GENERATION_NUMBER_INFINITY` for v2 graphs, so that saturated
     -+commits are treated as unordered.
     -+
     -+All reachable INFINITY-generation commits are visited before any
     -+finite-generation commit, because INFINITY is larger than any finite
     -+value. Once the walk crosses into the finite region, it stays there.
     -+
     -+In the finite region, generation ordering guarantees topological
     -+traversal: children are always visited before their parents. This
     -+means that paint on already-visited commits is final -- no future
     -+traversal step can add paint to them.
     -+
     -+In the INFINITY region, commit-date ordering can violate this: a
     -+parent with a later date can be visited before a child with an earlier
     -+date. Paint flags are therefore NOT final at visit time, and a
     -+commit visited with only one side's paint may later gain the other.
     -+
     -+Paint flags are only added, never removed. Since each flag can be set
     -+at most once per commit, the number of times a commit can be
     -+re-enqueued is bounded by the number of flag transitions.
     ++In the ordered region, a child's generation is strictly greater
     ++than its parent's. Same-generation commits are necessarily
     ++independent, so the queue always processes children before
     ++their parents.
     ++
     ++In the unordered region, parent-child pairs can share the same
     ++generation number, so topological order is not guaranteed. The
     ++queue uses commit-date as a heuristic, which typically produces
     ++a reasonable traversal order but may process a parent before
     ++its child.
     ++
     ++Commits not in the commit-graph have generation INFINITY; v1
     ++commit-graphs saturate at V1_MAX. Both place commits in the
     ++unordered region. Any optimization that depends on generation
     ++ordering must account for this saturation boundary.
     ++
     ++With generation ordering, values in the unordered region exceed
     ++those in the ordered region. The walk may therefore transition
     ++from the unordered region into the ordered region, but never in
     ++the reverse direction. Without a commit-graph, every commit has INFINITY
     ++and the walk operates entirely in the unordered region.
     ++
     ++In the ordered region, paint on a dequeued commit is final --
     ++no future step can add flags to it. In the unordered region,
     ++a dequeued commit may later gain additional paint. Paint flags
     ++are only added, never removed, bounding the number of
     ++re-enqueues per commit.
      +
      +Termination
      +-----------
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +  3. Generation cutoff: the dequeued commit's generation is below
      +     a caller-supplied `min_generation` threshold.
      +  4. Single result: the caller only needs one merge base, one has
     -+     been found, and the walk has entered the finite-generation
     -+     region.
     ++     been found, and the walk has entered the ordered region.
      +
      +Stale entry condition
      +~~~~~~~~~~~~~~~~~~~~~
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +
      +Single result
      +~~~~~~~~~~~~~
     -+When only one merge base is needed, the walk is in the
     -+finite-generation region, and the queue uses generation ordering,
     -+the first candidate found is necessarily the highest-generation
     -+common ancestor. No remaining commit in the queue can be a
     -+descendant of this candidate (generation ordering guarantees
     -+children are visited first), so it cannot be redundant and the walk
     -+can stop immediately.
     ++When only one merge base is needed and the walk is in the
     ++ordered region with generation ordering, the first candidate
     ++found is necessarily the highest-generation common ancestor.
     ++No remaining commit in the queue can be a descendant of this
     ++candidate (generation ordering guarantees children are visited
     ++first), so it cannot be redundant and the walk can stop
     ++immediately.
      +
      +This optimization is NOT safe when the date-ordering fallback is
      +active, because commit-date order can visit a deeper ancestor
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +
      +When the commit-graph has generation numbers v1 and no
      +generation floor is specified, topological ordering
     -+(via generation numbers) is disabled.  Topological levels are
     ++(via generation numbers) is disabled. Topological levels are
      +correct but unbalanced -- ordering by such generation numbers
      +can sometimes cause the walk to detour too far before finding
     -+merge bases.  Commit-date ordering typically reaches them in
     ++merge bases. Commit-date ordering typically reaches them in
      +fewer steps -- see this change for more details:
      +
      +   091f4cf3 (commit: don't use generation numbers if not needed,
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +of both worlds and do not need this fallback.
      +
      +For v1, `paint_down_to_common()` falls back to pure commit-date
     -+ordering via `compare_commits_by_commit_date`.  Because commit
     ++ordering via `compare_commits_by_commit_date`. Because commit
      +dates are not monotonic (clock skew, rebases, etc.), the queue
      +may visit commits out of topological order.
      +
  2:  57ecc0b18a =  2:  37ec7e9aa3 test-lib-functions: improve diagnostic output for trace2 data assertions
  3:  f857577e0c !  3:  6208bcf3b3 t6600: add test cases for side-exhaustion edge cases
     @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
      +	#   ps-T1   ps-T2
      +	#
      +	# where ps-T1=merge(ps-Z,ps-B), ps-T2=merge(ps-W,ps-B), so
     -+	# merge-base(ps-T1,ps-T2) = ps-B. During the walk, ps-X transitions
     ++	# merge-base(ps-T1,ps-T2) = ps-B.  During the walk, ps-X transitions
      +	# to (PARENT1|PARENT2) via ps-Z and ps-W before ps-B is dequeued;
      +	# then the STALE-walk from ps-B transitions ps-X to
      +	# (PARENT1|PARENT2|STALE).
     @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
      +
      +	# Build a side topology that lives entirely outside the half
      +	# commit-graph and has non-monotonic commit dates, to exercise the
     -+	# INFINITY-gate in paint_down_to_common. With both tips outside
     ++	# INFINITY-gate in paint_down_to_common.  With both tips outside
      +	# the graph, generation is INFINITY and the queue falls back to
      +	# commit-date order, which here is non-monotonic.
      +	#
     @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many' '
      +
      +test_expect_success 'get_merge_bases_many:pending-stale' '
      +	# Exercises the (PARENT1|PARENT2) -> (...|STALE) transition path in
     -+	# paint_down_to_common(). See the topology comment in the setup test.
     ++	# paint_down_to_common().  See the topology comment in the setup test.
      +	cat >input <<-\EOF &&
      +	A:ps-T1
      +	X:ps-T2
     @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many' '
      +'
      +
      +test_expect_success 'get_merge_bases_many:infinity-both-sides' '
     -+	# Exercises the push-time INFINITY-gate in paint_down_to_common(). See
     ++	# Exercises the push-time INFINITY-gate in paint_down_to_common().  See
      +	# the pi-* topology comment in the setup test.
      +	cat >input <<-\EOF &&
      +	A:pi-X
  4:  e8565ce020 !  4:  f4bb58fd46 t6099, t6600: add side-exhaustion regression tests
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    t6099, t6600: add side-exhaustion regression tests
     +    t6099: add side-exhaustion regression test
      
          Add t6099 to test the case where multiple merge-base candidates exist
          and one is an ancestor of another. This exercises the side-exhaustion
          optimization in paint_down_to_common together with the
          remove_redundant safety net in get_merge_bases_many_0.
      
     -    Add a mixed finite/INFINITY test to t6600 where one tip is outside
     -    the commit-graph (INFINITY generation) and the other is inside.
     -    This exercises the region transition: the walk starts in the
     -    INFINITY region where side-exhaustion is disabled, then crosses
     -    into the finite region where it can fire.
     -
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## t/meson.build ##
     @@ t/t6099-merge-base-side-exhaustion.sh (new)
      +
      +Graph shape (parents are below children):
      +
     -+   A ----------- X
     -+   |\           /|
     -+   | B---------/ |
     -+   | |           |
     -+   e2 \         f2
     -+   |   |         |
     -+   e1 d1        f1
     -+    \  |        /
     -+     \ |       /
     -+      \|      /
     ++   A ----- X
     ++   |\     /|
     ++   | B---/ |
     ++   |  \    |
     ++   e2  \   f2
     ++   |   |   |
     ++   e1  d1  f1
     ++    \  |  /
     ++     \ | /
     ++      \|/
      +       C
      +
      +A and X are the two tips.
  5:  490be76bef !  5:  53cb1a9690 commit-reach: add trace2 instrumentation to paint_down_to_common()
     @@ Commit message
          GIT_TRACE2_EVENT. This provides a way to measure the impact of
          future optimizations without relying on wall-clock benchmarks alone.
      
     +    Some step counts already vary across commit-graph modes (e.g.
     +    in_merge_bases_many:self) because the pre-existing min_generation
     +    optimization short-circuits the walk when generation data is
     +    available.
     +
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## commit-reach.c ##
  6:  75d58639fc !  6:  e40c759756 t6600: add clock-skew topologies and step counts for edge cases
     @@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all commit-walk steps'
       '
       
      +test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
     -+	# Verify correct merge base under clock skew.  se-D (the
     -+	# merge base) has a higher date than its child se-C.
     -+	# Generation ordering ensures se-C is visited before se-D,
     -+	# so P1 paint propagates correctly and se-D is found.
     ++	# Verify that the merge base is computed correctly even
     ++	# when commits have non-monotonic commit dates.
      +	>input &&
      +	git rev-parse se-D >expect &&
      +	run_all_modes git merge-base --all se-A se-B &&
     @@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all commit-walk steps'
      +'
      +
      +test_expect_success 'merge-base --all with clock skew and redundant ancestor (side-exhaustion)' '
     -+	# Verify correct merge base when clock skew could cause a
     -+	# too-deep result.  MB1 is the correct merge base; MB2 is
     -+	# its ancestor.  A reaches MB2 via E (high date) and MB1
     -+	# via C (low date).  Generation ordering ensures C is
     -+	# visited before side-exhaustion fires, so MB1 is found
     -+	# and remove_redundant correctly discards MB2.
     ++	# Verify that the correct merge base is found even when
     ++	# non-monotonic commit dates could cause a redundant
     ++	# ancestor to be visited first.
      +	>input &&
      +	git rev-parse se2-MB1 >expect &&
      +	run_all_modes git merge-base --all se2-A se2-B &&
  7:  a1c8e89ef9 !  7:  bbb83f8eaa commit-reach: introduce struct paint_state with per-side counters
     @@ Commit message
      
          The existing nonstale_queue is left in place for ahead_behind(),
          though nonstale_queue_put_dedup() and nonstale_queue_get_dedup()
     -    became unused and are removed.
     +    become unused and are removed.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## Documentation/technical/paint-down-to-common.adoc ##
     -@@ Documentation/technical/paint-down-to-common.adoc: re-enqueued is bounded by the number of flag transitions.
     +@@ Documentation/technical/paint-down-to-common.adoc: re-enqueues per commit.
       Termination
       -----------
       
     @@ commit-reach.c: static void clear_nonstale_queue(struct nonstale_queue *queue)
       }
       
      -static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
     ++/*
     ++ * Dequeue the next commit for the paint walk, or return NULL when
     ++ * no more merge bases can be discovered.
     ++ */
      +static struct commit *paint_queue_get(struct paint_state *state)
       {
      -	struct commit *commit = nonstale_queue_get(queue);
     @@ commit-reach.c: static void clear_nonstale_queue(struct nonstale_queue *queue)
      +
      +	commit->object.flags &= ~ENQUEUED;
      +
     ++	/*
     ++	 * Check exit condition before decrementing: the counters
     ++	 * still include this commit, so the last non-stale commit
     ++	 * sees a non-zero count and is returned for processing.
     ++	 */
      +	if (!state->parent1_count && !state->parent2_count &&
      +	    !state->mb_candidate_count)
      +		return NULL;
  8:  391fa07783 !  8:  4a6603731c commit-reach: terminate merge-base walk when one paint side is exhausted
     @@ Commit message
      
          Add an early termination check to paint_down_to_common() using the
          per-side counters introduced earlier. Once the walk enters the
     -    finite-generation region, terminate early when one side's exclusive
     -    count drops to zero -- no new merge-base can form without both paint
     +    ordered region, terminate early when one side's exclusive count
     +    drops to zero -- no new merge-base can form without both paint
          sides meeting.
      
          The check also waits for pending_merge_bases to reach zero, ensuring
          all merge-base candidates have been dequeued and recorded before
          exiting.
      
     -    The INFINITY gate ensures correctness: commits without a commit-graph
     -    entry have GENERATION_NUMBER_INFINITY and are ordered by commit date,
     -    which is not topologically reliable. The optimization only fires
     -    once the walk enters the finite-generation region where ordering
     -    guarantees hold.
     +    The optimization is gated by gen_ordered (which excludes v1
     +    commit-graphs that use the date-ordering fallback) and by a
     +    generation check against topo_ceiling. topo_ceiling is
     +    GENERATION_NUMBER_INFINITY for v2 graphs and
     +    GENERATION_NUMBER_V1_MAX for v1 graphs, so that saturated commits
     +    are treated as unordered. Together these ensure the check only
     +    fires in the ordered region where topological ordering holds.
     +
     +    The same topo_ceiling boundary is applied to the existing
     +    single-result early exit so that all generation-dependent gates
     +    express the same saturation-aware boundary consistently.
      
          Step counts measured with trace2 on git.git with commit-graph:
      
     @@ Commit message
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## Documentation/technical/paint-down-to-common.adoc ##
     +@@ Documentation/technical/paint-down-to-common.adoc: its child.
     + Commits not in the commit-graph have generation INFINITY; v1
     + commit-graphs saturate at V1_MAX. Both place commits in the
     + unordered region. Any optimization that depends on generation
     +-ordering must account for this saturation boundary.
     ++ordering must account for this saturation boundary. The early
     ++exit gates compare against a topological ceiling --
     ++`GENERATION_NUMBER_V1_MAX` for v1 graphs and
     ++`GENERATION_NUMBER_INFINITY` for v2 graphs -- so that saturated
     ++commits are treated as unordered.
     + 
     + With generation ordering, values in the unordered region exceed
     + those in the ordered region. The walk may therefore transition
      @@ Documentation/technical/paint-down-to-common.adoc: ends when one of the following conditions holds:
     +      a caller-supplied `min_generation` threshold.
         4. Single result: the caller only needs one merge base, one has
     -      been found, and the walk has entered the finite-generation
     -      region.
     +      been found, and the walk has entered the ordered region.
      +  5. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
      +     remain in the queue, no pending merge-base candidates exist,
     -+     and the walk has entered the finite-generation region.
     ++     and the walk has entered the ordered region.
       
       Stale entry condition
       ~~~~~~~~~~~~~~~~~~~~~
     @@ Documentation/technical/paint-down-to-common.adoc: existing candidates by provin
      +A new merge-base requires commits from both sides to meet. When one
      +side's exclusive counter reaches zero and there are no pending
      +merge-base candidates, no future traversal step can produce a new
     -+candidate.
     -+
     -+This optimization only activates in the finite-generation region
     -+where topological ordering holds. In that region, children are
     -+always visited before parents, so paint flags are final at visit
     -+time and an exhausted side cannot reappear. In the INFINITY region,
     -+commit-date ordering can violate this guarantee, so the check is
     -+skipped.
     ++candidate. This optimization only activates in the ordered region,
     ++where paint flags are final at visit time; in the unordered region,
     ++a side that appears exhausted could reappear through late paint
     ++propagation.
      +
       Generation cutoff
       ~~~~~~~~~~~~~~~~~
       Some callers (notably `remove_redundant()`) supply a `min_generation`
     -@@ Documentation/technical/paint-down-to-common.adoc: ordering via `compare_commits_by_commit_date`.  Because commit
     +@@ Documentation/technical/paint-down-to-common.adoc: ordering via `compare_commits_by_commit_date`. Because commit
       dates are not monotonic (clock skew, rebases, etc.), the queue
       may visit commits out of topological order.
       
     @@ Documentation/technical/paint-down-to-common.adoc: ordering via `compare_commits
       
      
       ## commit-reach.c ##
     -@@ commit-reach.c: static void paint_queue_put(struct paint_state *state,
     - 	}
     - }
     +@@ commit-reach.c: struct paint_state {
     + 	size_t parent2_count;
     + 	size_t mb_candidate_count;
     + 	int gen_ordered;
     ++	timestamp_t topo_ceiling;
     + };
       
     -+/*
     -+ * Dequeue the next commit for the paint walk, or return NULL when
     -+ * no more merge bases can be discovered.
     -+ */
     - static struct commit *paint_queue_get(struct paint_state *state)
     - {
     - 	struct commit *commit = prio_queue_get(&state->queue);
     + static void paint_count_update(struct paint_state *state,
      @@ commit-reach.c: static struct commit *paint_queue_get(struct paint_state *state)
     - 
     - 	commit->object.flags &= ~ENQUEUED;
     - 
     + 	 * still include this commit, so the last non-stale commit
     + 	 * sees a non-zero count and is returned for processing.
     + 	 */
      -	if (!state->parent1_count && !state->parent2_count &&
      -	    !state->mb_candidate_count)
      -		return NULL;
     @@ commit-reach.c: static struct commit *paint_queue_get(struct paint_state *state)
      +		/* one side is exhausted */
      +		if ((!state->parent1_count || !state->parent2_count) &&
      +		    state->gen_ordered &&
     -+		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
     ++		    commit_graph_generation(commit) < state->topo_ceiling)
      +			return NULL;
      +	}
       
       	paint_count_update(state, commit->object.flags, -1);
       	return commit;
     +@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     + 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
     + 	struct commit_list **tail = result;
     + 
     ++	state.topo_ceiling = corrected_commit_dates_enabled(r)
     ++		? GENERATION_NUMBER_INFINITY
     ++		: GENERATION_NUMBER_V1_MAX;
     + 	if (!min_generation && !corrected_commit_dates_enabled(r)) {
     + 		state.queue.compare = compare_commits_by_commit_date;
     + 		state.gen_ordered = 0;
     +@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     + 				 */
     + 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
     + 				    state.gen_ordered &&
     +-				    generation < GENERATION_NUMBER_INFINITY)
     ++				    generation < state.topo_ceiling)
     + 					break;
     + 			}
     + 			/* Mark parents of a found merge stale */
      
       ## t/t6600-test-reach.sh ##
      @@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases_many:self' '
  9:  cd3273eb15 !  9:  9a0f4df49a commit-reach: move min_generation check into paint_queue_get()
     @@ commit-reach.c: struct paint_state {
       	int gen_ordered;
      +	timestamp_t min_generation;
      +	timestamp_t last_gen;
     + 	timestamp_t topo_ceiling;
       };
       
     - static void paint_count_update(struct paint_state *state,
      @@ commit-reach.c: static void paint_queue_put(struct paint_state *state,
       static struct commit *paint_queue_get(struct paint_state *state)
       {
     @@ commit-reach.c: static void paint_queue_put(struct paint_state *state,
      +	if (generation < state->min_generation)
      +		return NULL;
       
     - 	if (!state->mb_candidate_count) {
     - 		/* only stale entries remain */
     + 	/*
     + 	 * Check exit condition before decrementing: the counters
      @@ commit-reach.c: static struct commit *paint_queue_get(struct paint_state *state)
       		/* one side is exhausted */
       		if ((!state->parent1_count || !state->parent2_count) &&
       		    state->gen_ordered &&
     --		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
     -+		    generation < GENERATION_NUMBER_INFINITY)
     +-		    commit_graph_generation(commit) < state->topo_ceiling)
     ++		    generation < state->topo_ceiling)
       			return NULL;
       	}
       
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       
      +	state.min_generation = min_generation;
      +	state.last_gen = GENERATION_NUMBER_INFINITY;
     - 	if (!min_generation && !corrected_commit_dates_enabled(r)) {
     - 		state.queue.compare = compare_commits_by_commit_date;
     - 		state.gen_ordered = 0;
     + 	state.topo_ceiling = corrected_commit_dates_enabled(r)
     + 		? GENERATION_NUMBER_INFINITY
     + 		: GENERATION_NUMBER_V1_MAX;
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       	while ((commit = paint_queue_get(&state))) {
       		struct commit_list *parents;
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       				 */
       				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
       				    state.gen_ordered &&
     --				    generation < GENERATION_NUMBER_INFINITY)
     -+				    state.last_gen < GENERATION_NUMBER_INFINITY)
     +-				    generation < state.topo_ceiling)
     ++				    state.last_gen < state.topo_ceiling)
       					break;
       			}
       			/* Mark parents of a found merge stale */
 10:  b655b24dc0 ! 10:  677e25077c commit-reach: remove commit-date ordering fallback
     @@ Commit message
            v2 graph, this series:  3,887    0.01 s
      
          With generation ordering always active, the existing min_generation
     -    check in paint_queue_get() correctly identifies when the walk has
     -    reached the finite generation region. The date ordering fallback
     -    broke this invariant: a commit could have a finite topo level
     -    while the queue was date-ordered, causing the early exit to fire
     -    before all merge bases were found.
     +    check in paint_queue_get() can safely terminate once the walk
     +    crosses below the caller's generation floor. The date ordering
     +    fallback broke this invariant: a commit could have a finite topo
     +    level while the queue was date-ordered, causing the early exit to
     +    fire before all merge bases were found.
      
     -    For v1 commit-graphs where generation numbers saturate at
     -    GENERATION_NUMBER_V1_MAX, introduce a topological ceiling that
     -    the early exit gates compare against instead of
     -    GENERATION_NUMBER_INFINITY. This ensures saturated commits are
     -    treated as unordered, preventing premature termination when
     -    generation values are unreliable.
     +    With the fallback removed, gen_ordered is always true and can be
     +    dropped. The topo_ceiling field (introduced earlier) already
     +    handles V1_MAX saturation, so the early exit gates need no further
     +    changes.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## Documentation/technical/paint-down-to-common.adoc ##
     -@@ Documentation/technical/paint-down-to-common.adoc: ancestor is necessarily redundant.
     - INFINITY and finite generation regions
     - --------------------------------------
     - 
     --The properties in this section assume generation-number ordering (the
     --default comparator). They do NOT hold when the date-ordering fallback
     --is active -- see <<date-ordering-fallback>>.
     --
     - The commit-graph stores a generation number for each commit.
     - Commits not in the commit-graph have generation
     - `GENERATION_NUMBER_INFINITY`. The graph is closed under
     -@@ Documentation/technical/paint-down-to-common.adoc: traversal: children are always visited before their parents. This
     - means that paint on already-visited commits is final -- no future
     - traversal step can add paint to them.
     - 
     --In the INFINITY region, commit-date ordering can violate this: a
     --parent with a later date can be visited before a child with an earlier
     --date. Paint flags are therefore NOT final at visit time, and a
     --commit visited with only one side's paint may later gain the other.
     -+In the INFINITY region, all commits share the same generation
     -+value, so the queue breaks ties by commit date. This can violate
     -+topological ordering: a parent with a later date can be visited
     -+before a child with an earlier date. Paint flags are therefore
     -+NOT final at visit time, and a commit visited with only one
     -+side's paint may later gain the other.
     - 
     - Paint flags are only added, never removed. Since each flag can be set
     - at most once per commit, the number of times a commit can be
     -@@ Documentation/technical/paint-down-to-common.adoc: descendant of this candidate (generation ordering guarantees
     - children are visited first), so it cannot be redundant and the walk
     - can stop immediately.
     +@@ Documentation/technical/paint-down-to-common.adoc: candidate (generation ordering guarantees children are visited
     + first), so it cannot be redundant and the walk can stop
     + immediately.
       
      -This optimization is NOT safe when the date-ordering fallback is
      -active, because commit-date order can visit a deeper ancestor
     @@ Documentation/technical/paint-down-to-common.adoc: descendant of this candidate
      -
      -When the commit-graph has generation numbers v1 and no
      -generation floor is specified, topological ordering
     --(via generation numbers) is disabled.  Topological levels are
     +-(via generation numbers) is disabled. Topological levels are
      -correct but unbalanced -- ordering by such generation numbers
      -can sometimes cause the walk to detour too far before finding
     --merge bases.  Commit-date ordering typically reaches them in
     +-merge bases. Commit-date ordering typically reaches them in
      -fewer steps -- see this change for more details:
      -
      -   091f4cf3 (commit: don't use generation numbers if not needed,
     @@ Documentation/technical/paint-down-to-common.adoc: descendant of this candidate
      -of both worlds and do not need this fallback.
      -
      -For v1, `paint_down_to_common()` falls back to pure commit-date
     --ordering via `compare_commits_by_commit_date`.  Because commit
     +-ordering via `compare_commits_by_commit_date`. Because commit
      -dates are not monotonic (clock skew, rebases, etc.), the queue
      -may visit commits out of topological order.
      -
     @@ commit-reach.c: struct paint_state {
      -	int gen_ordered;
       	timestamp_t min_generation;
       	timestamp_t last_gen;
     -+	timestamp_t topo_ceiling;
     - };
     - 
     - static void paint_count_update(struct paint_state *state,
     + 	timestamp_t topo_ceiling;
      @@ commit-reach.c: static struct commit *paint_queue_get(struct paint_state *state)
       
       		/* one side is exhausted */
       		if ((!state->parent1_count || !state->parent2_count) &&
      -		    state->gen_ordered &&
     --		    generation < GENERATION_NUMBER_INFINITY)
     -+		    generation < state->topo_ceiling)
     + 		    generation < state->topo_ceiling)
       			return NULL;
       	}
     - 
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       				enum merge_base_flags mb_flags,
       				struct commit_list **result)
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
      +	/*
      +	 * Generation ordering is required for the side-exhaustion and
      +	 * single-result early exits, which rely on topological traversal
     -+	 * order (children visited before parents) in the finite region.
     ++	 * order (children visited before parents) in the ordered region.
      +	 */
       	struct paint_state state = {
      -		.queue = { compare_commits_by_gen_then_commit_date },
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       	struct commit *commit;
       	int i;
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     - 
     - 	state.min_generation = min_generation;
     - 	state.last_gen = GENERATION_NUMBER_INFINITY;
     + 	state.topo_ceiling = corrected_commit_dates_enabled(r)
     + 		? GENERATION_NUMBER_INFINITY
     + 		: GENERATION_NUMBER_V1_MAX;
      -	if (!min_generation && !corrected_commit_dates_enabled(r)) {
      -		state.queue.compare = compare_commits_by_commit_date;
      -		state.gen_ordered = 0;
      -	}
     -+	state.topo_ceiling = corrected_commit_dates_enabled(r)
     -+		? GENERATION_NUMBER_INFINITY
     -+		: GENERATION_NUMBER_V1_MAX;
       
       	one->object.flags |= PARENT1;
       	if (!n) {
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       				 */
       				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
      -				    state.gen_ordered &&
     --				    state.last_gen < GENERATION_NUMBER_INFINITY)
     -+				    state.last_gen < state.topo_ceiling)
     + 				    state.last_gen < state.topo_ceiling)
       					break;
       			}
     - 			/* Mark parents of a found merge stale */
      
       ## t/t6600-test-reach.sh ##
      @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:infinity-both-sides' '
     @@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all commit-walk steps'
       '
       
       test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
     --	# Verify correct merge base under clock skew.  se-D (the
     --	# merge base) has a higher date than its child se-C.
     --	# Generation ordering ensures se-C is visited before se-D,
     --	# so P1 paint propagates correctly and se-D is found.
     -+	# Verify that the merge base is computed correctly even
     -+	# when commits have non-monotonic commit dates.
     +@@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
       	>input &&
       	git rev-parse se-D >expect &&
       	run_all_modes git merge-base --all se-A se-B &&
     @@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all commit-walk steps'
       '
       
       test_expect_success 'merge-base --all with clock skew and redundant ancestor (side-exhaustion)' '
     --	# Verify correct merge base when clock skew could cause a
     --	# too-deep result.  MB1 is the correct merge base; MB2 is
     --	# its ancestor.  A reaches MB2 via E (high date) and MB1
     --	# via C (low date).  Generation ordering ensures C is
     --	# visited before side-exhaustion fires, so MB1 is found
     --	# and remove_redundant correctly discards MB2.
     -+	# Verify that the correct merge base is found even when
     -+	# non-monotonic commit dates could cause a redundant
     -+	# ancestor to be visited first.
     +@@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all with clock skew and redundant ancestor (si
       	>input &&
       	git rev-parse se2-MB1 >expect &&
       	run_all_modes git merge-base --all se2-A se2-B &&

-- 
gitgitgadget
