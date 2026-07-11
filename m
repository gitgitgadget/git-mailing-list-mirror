Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247FE3921DB
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776472; cv=none; b=jBxavAQjbVYp6qYWQBGYWs2Mlb4aMpxd11D/r3FNYWeItWi7VvxSXOafxjyVkp2qdYsDF5XQtxFTwHf3PW+UvZmJcmrh0YpJdRtKM1EpdwJ9St/Ro3ZiHrL7d0YnxEM+YBpNrXh6/onvWnnzuG7SVSGI/VLQ9DF4q+xUMgJJ/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776472; c=relaxed/simple;
	bh=UbG0WVUDDvorMluthlJfMXcf7rSfDQSH3nnFfDZLCpg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A4g1KQgR3aPZLrr8Q9xpSaOTdWM6HH3u4HJE9ckxwfXmo1OR6yyKdfg8o9smPeggnmvQRvtkUagxtQdMcvzRWnIi7iWSkdwKPwsqycnFfO+i4Cp73YTu5iu6B+xTowa78/Jcku/0Z6mrHBfSny8dVmLNTNhjgvZrUz3DgnYd+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eE5XtOeL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eE5XtOeL"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37df72c9984so3103850a91.3
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783776469; x=1784381269; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3EMLXGQq5W4ZTgTsk3FtHTfzm6Ai1mPOjYrfBA7JGO4=;
        b=eE5XtOeLKrRQ7WcHq4nA7k4YdpEoF3nFBlFCOGNKpZ0gpgkgs7peBJrjv18cDuDFrG
         icKCju6ud7cat18+er5dnbl2Um5i6psxnxxCVos9QNUYRBmO5rHDxP8cb4kMcTbh7rAZ
         ouIV/jU9qBo84/4wqzZvjem37ZHyw3EM6rJUFWBQPyj3a3gceFIhwlDjzg0HEvFi2eXc
         apiYXVsbAYgX+CT9q0EdWZQgaZ+jR7lUkHSDNlOQhxGcZ9E5/+OBOTmXf1M5m+Ly494t
         T5GyEZfKaLdUD6FVrMvTavXGFeFt4e1n8csA9H3+Tjf+j2InTe9oEj5ZwMLBkKzi5o/a
         oyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776469; x=1784381269;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3EMLXGQq5W4ZTgTsk3FtHTfzm6Ai1mPOjYrfBA7JGO4=;
        b=W8hpJ/H/6Dd0OD2YkEFcl/1pRi2es7eyZGFv+bpGVnN/yUGX0KPGZezHveQQcRWqyC
         chX3jcTDBNdDC61+6/jQngnbcsecWLe9Nz7bsHtSSK5Z4Kn9RiqsdRY8x2IfU8VF/lsv
         H2MxlrFbcJTX9/bQ26V/WpcakLoBDZRQi3a09PJjmqbDEA4xCJ7zul+PDQYYpisVPrGr
         7V0uZLM7fnxgzDP1IakltdEzFDFN7njQdb9or7E6C9uqJZZTYuq2q+Ww/GDKNAMt1T86
         0I9AWwb25PKeAztOme3dRSWJX5Kg/4YOVh+YnvzMnxtrd9fB49g6hIkr8V+UQREnE6UT
         Xe5A==
X-Gm-Message-State: AOJu0YyMiXHT3s1kCe6DIOm8LdabM87lxP71tK5Gu4ixGklmlUcDpJzt
	6E+oP4oIbrgOhBr2t4QN4u/I7hiyGePmfDJqnUdZYmPgGrCkeA98MYAzzgVvuQ==
X-Gm-Gg: AfdE7cltSM+p2VFYItXeDxdxnkBT8efwEkoWIb6vYjUCjupDtUqi9fEMr0fm3YVb3sB
	W3PCj7Zf+x/2PCQbGU4yHf2uLQB1+Ro9o6wu6JlhUG+eXPnfK5GYkOTnrT+PbMkMTtp/JH50MJI
	HOUd1iTXw1LT3yPNIboW0z8INadGRaNopG9qevBag5gKVpmmwsPTgNjIIvZaiUTl+cmnybjMKVN
	k1deOkqsv4Q82ixjBh8bAlRVjlfqklrab4+5bgggMxOncJ2YDurrpYVrk6T5hyGi4YHKE45IllR
	BR5eKSgwuHxlfghgkQX7VkTmJ3fBZuT3ZQYlwVO7wLQ2SAX9QXvJg7Mhm1xkq7D63N3n9oJgLGd
	Z7Y2SNfmHCxjrDjvreOasR59WUkwo8Zf5gvFpa9a70ErY14+GRWD0Uc7tggsz11FiHTg0la9FT+
	760MzBN6eBnyezrvYizKcqpx5chg==
X-Received: by 2002:a17:90b:5243:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-38dc7747c1amr3061880a91.15.1783776468873;
        Sat, 11 Jul 2026 06:27:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.76.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm59211659eec.1.2026.07.11.06.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:27:47 -0700 (PDT)
Message-Id: <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Jul 2026 13:27:35 +0000
Subject: [PATCH v6 00/10] commit-reach: terminate merge-base walk when one side is exhausted
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
    Kristofer Karlsson <krka@spotify.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>

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


This series is based on next (depends on kk/commit-reach-find-all-fix and
kk/commit-reach-optim) but is expected to merge cleanly once
kk/commit-reach-find-all-fix graduates to master.

[1]
https://lore.kernel.org/git/CAL71e4Ps-2_0+uuZu43N9pFnXBemoAohPs_eyRJf8taXHJPAXQ@mail.gmail.com/T/#u
[2] https://github.com/gitgitgadget/git/pull/2150

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
 .../technical/paint-down-to-common.adoc       | 154 +++++++++++
 commit-graph.c                                |  11 -
 commit-graph.h                                |   6 -
 commit-reach.c                                | 156 +++++++++---
 t/meson.build                                 |   1 +
 t/t6099-merge-base-side-exhaustion.sh         |  82 ++++++
 t/t6600-test-reach.sh                         | 241 +++++++++++++++++-
 t/test-lib-functions.sh                       |  36 +++
 10 files changed, 618 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/technical/paint-down-to-common.adoc
 create mode 100755 t/t6099-merge-base-side-exhaustion.sh


base-commit: d0cf55ea5485acc255740c5208673122e812dfa4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2149%2Fspkrka%2Fside-exhaust-pr-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2149/spkrka/side-exhaust-pr-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/2149

Range-diff vs v5:

  1:  be00f5aaa1 !  1:  5ef4f08105 Documentation/technical: add paint-down-to-common doc
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +STALE flag so its ancestors propagate staleness -- any deeper common
      +ancestor is necessarily redundant.
      +
     -+NOTE: When the commit-graph uses only topological levels (generation
     -+number v1) and the caller passes `min_generation = 0`, a legacy
     -+fallback replaces the generation-ordered comparator with a pure
     -+commit-date comparator. This breaks the ordering invariants
     -+described below -- see <<date-ordering-fallback>>.
     -+
      +[[generation-regions]]
      +INFINITY and finite generation regions
      +--------------------------------------
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +default comparator). They do NOT hold when the date-ordering fallback
      +is active -- see <<date-ordering-fallback>>.
      +
     -+The commit-graph stores a generation number for each commit. Commits
     -+not in the commit-graph have generation `GENERATION_NUMBER_INFINITY`. The
     -+graph is closed under reachability: if a commit is in the graph, all
     -+its ancestors are too. This partitions the commit graph into two regions:
     ++The commit-graph stores a generation number for each commit.
     ++Commits not in the commit-graph have generation
     ++`GENERATION_NUMBER_INFINITY`. The graph is closed under
     ++reachability: if a commit is in the graph, all its ancestors are
     ++too. This partitions the commit graph into two regions:
      +
      +....
      +    +---------------------------------------+
     @@ Documentation/technical/paint-down-to-common.adoc (new)
      +Date-ordering fallback
      +----------------------
      +
     -+When `min_generation` is zero and the commit-graph does not contain
     -+corrected commit dates (generation number v1, which stores only
     -+topological levels), `paint_down_to_common()` replaces the default
     -+generation-ordered comparator with `compare_commits_by_commit_date`.
     ++When the commit-graph has generation numbers v1 and no
     ++generation floor is specified, topological ordering
     ++(via generation numbers) is disabled.  Topological levels are
     ++correct but unbalanced -- ordering by such generation numbers
     ++can sometimes cause the walk to detour too far before finding
     ++merge bases.  Commit-date ordering typically reaches them in
     ++fewer steps -- see this change for more details:
     ++
     ++   091f4cf3 (commit: don't use generation numbers if not needed,
     ++   2018-08-30)
      +
     -+This was introduced as a performance heuristic: topological levels
     -+are coarser than commit dates, so date ordering can reach merge
     -+bases in fewer steps when timestamps are well-behaved. However,
     -+commit dates are not required to be monotonic -- a parent can have
     -+a later date than its child (clock skew, rebases, etc.) -- so the
     -+queue may visit commits out of topological order.
     ++With generation number v2 (corrected commit dates) we have the best
     ++of both worlds and do not need this fallback.
      +
     -+This disables optimizations that depend on generation ordering:
     ++For v1, `paint_down_to_common()` falls back to pure commit-date
     ++ordering via `compare_commits_by_commit_date`.  Because commit
     ++dates are not monotonic (clock skew, rebases, etc.), the queue
     ++may visit commits out of topological order.
      +
     -+  1. *Single result*: the first merge-base candidate found may not
     -+     be the shallowest, because a deeper ancestor with a higher
     -+     commit date can be dequeued first.
     ++This disables the optimization that depends on generation ordering:
      +
     -+  2. *Side-exhaustion* (see subsequent commits): one paint side can
     -+     appear to drain from the queue while commits from that side are
     -+     still waiting with lower dates, causing premature termination.
     ++  - *Single result*: the first merge-base candidate found may not
     ++    be the shallowest, because a deeper ancestor with a higher
     ++    commit date can be dequeued first.
      +
      +Related documentation
      +---------------------
  2:  143f5e0cc1 !  2:  d0ee6d062e test-lib-functions: improve diagnostic output for trace2 data assertions
     @@ Commit message
          test_trace2_data is a bare grep that silently exits on failure.
          Add a more informative variant that verifies the event appears
          exactly once and reports what went wrong: key not found, multiple
     -    entries, or value mismatch.  Diagnostics go to FD 4 like test_grep.
     +    entries, or value mismatch. Diagnostics go to FD 4 like test_grep.
      
          Before (value mismatch):
      
  3:  eec4a9d926 !  3:  21ecf6dc34 t6600: add test cases for side-exhaustion edge cases
     @@ Commit message
      
       ## t/t6600-test-reach.sh ##
      @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
     - 			git tag -a -m "$x-$i" tag-$x-$i commit-$x-$i || return 1
     - 		done
     - 	done &&
     -+
     + 	git branch -f skew-P2 "$skew_P2" &&
     + 	git tag skew-M2 "$skew_M2" &&
     + 
      +	# Build a small side topology to exercise the (PARENT1|PARENT2) ->
      +	# (PARENT1|PARENT2|STALE) transition in paint_down_to_common(); the
      +	# 10x10 grid above does not exercise it because no merge-base candidate
     @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
      +	pi_x="$(cat pi-X-oid)" &&
      +	git branch -f pi-X-br "$pi_x" &&
      +	git tag pi-X "$pi_x" &&
     ++
       	git commit-graph write --reachable &&
       	mv .git/objects/info/commit-graph commit-graph-full &&
       	chmod u+w commit-graph-full &&
  4:  7f0efe6c73 =  4:  d4ecf4b698 t6099, t6600: add side-exhaustion regression tests
  5:  b9fb8bfe26 !  5:  9e76f5fb62 commit-reach: add trace2 instrumentation to paint_down_to_common()
     @@ commit-reach.c
       /* Remember to update object flag allocation in object.h */
       #define PARENT1		(1u<<16)
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     - 		{ compare_commits_by_gen_then_commit_date }
       	};
       	int i;
     + 	int gen_ordered = 1;
      +	int steps = 0;
       	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
       	struct commit_list **tail = result;
  6:  c6e3cc13f7 !  6:  171b3cd3ae t6600: add clock-skew topologies and step counts for edge cases
     @@ Commit message
      
       ## t/t6600-test-reach.sh ##
      @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
     - 	pi_x="$(cat pi-X-oid)" &&
       	git branch -f pi-X-br "$pi_x" &&
       	git tag pi-X "$pi_x" &&
     -+
     -+	# Build a topology with clock skew to test the !FIND_ALL early
     -+	# exit in paint_down_to_common().  M2 is the correct merge base
     -+	# of P1 and P2, but its ancestor M1 has a higher committer date
     -+	# due to clock skew.  With date-only ordering (v1 commit graph
     -+	# without corrected commit dates), M1 pops from the queue first,
     -+	# gets both paint sides, and the early exit fires before M2 is
     -+	# ever visited.
     -+	#
     -+	#        P1     P2          @7000
     -+	#        |     /  \
     -+	#        A    B    D        @6000
     -+	#       / \   |    |
     -+	#      |  M2--+    |        @2000 (correct merge base)
     -+	#       \ |        |
     -+	#        M1--------+        @5000 (clock skew: date > M2)
     -+	#        |
     -+	#       root                @1000
     -+	#
     -+	git checkout --orphan skew-orphan &&
     -+	skew_tree=$(git mktree </dev/null) &&
     -+	skew_commit () {
     -+		GIT_COMMITTER_DATE="@$1 +0000" GIT_AUTHOR_DATE="@$1 +0000" \
     -+			git commit-tree -m "$2" "$skew_tree" $3 $4 $5 $6
     -+	} &&
     -+	skew_root=$(skew_commit 1000 root) &&
     -+	skew_M1=$(skew_commit 5000 M1 -p "$skew_root") &&
     -+	skew_M2=$(skew_commit 2000 M2 -p "$skew_M1") &&
     -+	skew_A=$(skew_commit 6000 A -p "$skew_M1" -p "$skew_M2") &&
     -+	skew_B=$(skew_commit 6000 B -p "$skew_M2") &&
     -+	skew_D=$(skew_commit 6000 D -p "$skew_M1") &&
     -+	skew_P1=$(skew_commit 7000 P1 -p "$skew_A") &&
     -+	skew_P2=$(skew_commit 7000 P2 -p "$skew_B" -p "$skew_D") &&
     -+	git branch -f skew-P1 "$skew_P1" &&
     -+	git branch -f skew-P2 "$skew_P2" &&
     -+	git tag skew-M2 "$skew_M2" &&
     -+
     -+	# Build a topology where clock skew causes the side-exhaustion
     -+	# optimization to fire too early with date ordering (v1 graph).
     + 
     ++	# Clock-skew topology for side-exhaustion testing.
      +	# D is the correct merge base but has a higher committer date
     -+	# than C (its child), so D is dequeued before C.  The P2 side
     -+	# (B -> D -> root) fully drains while C (P1-only) is still
     -+	# queued.  Side-exhaustion fires, missing D as a merge base.
     ++	# than C (its child).  With date ordering, D would be dequeued
     ++	# before C, causing side-exhaustion to fire too early.
     ++	# Generation ordering prevents this by visiting children
     ++	# before parents regardless of dates.
      +	#
      +	#   se-A (date 7000) --> se-C (date 3000) --> se-D (date 5000) --> se-root (date 4000)
      +	#   se-B (date 6000) --> se-D
     @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
      +	git branch -f se-B "$se_B" &&
      +	git tag se-D "$se_D" &&
      +
     -+	# Build a topology where side-exhaustion with date ordering
     -+	# returns a wrong (too-deep) merge base.  MB1 is the correct
     -+	# merge base; MB2 is its parent and should be filtered as
     -+	# redundant.  A reaches MB2 via E (high date) and MB1 via C
     -+	# (low date).  B reaches MB1 via D.  With date ordering, the
     -+	# P2 side drains after MB2 is found but before C is dequeued,
     -+	# so MB1 never receives P1 paint.  Result: MB2 (wrong).
     ++	# Clock-skew topology with redundant ancestor for
     ++	# side-exhaustion testing.  MB1 is the correct merge base;
     ++	# MB2 is its parent.  A reaches MB2 via E (high date) and
     ++	# MB1 via C (low date).  B reaches MB1 via D.  With date
     ++	# ordering, side-exhaustion would fire before C is dequeued,
     ++	# missing MB1.  Generation ordering ensures both are found.
      +	#
      +	#   se2-A (date 8000) --> se2-C (date 2000) --> se2-MB1 (date 5000) --> se2-MB2 (date 4000) --> se2-root (date 1000)
      +	#   se2-A              --> se2-E (date 6500) --> se2-MB2
     @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
      +	git branch -f se2-A "$se2_A" &&
      +	git branch -f se2-B "$se2_B" &&
      +	git tag se2-MB1 "$se2_MB1" &&
     ++
       	git commit-graph write --reachable &&
       	mv .git/objects/info/commit-graph commit-graph-full &&
       	chmod u+w commit-graph-full &&
     @@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all commit-walk steps'
       	test_paint_down_steps 81 80 81 81
       '
       
     -+test_expect_success 'merge-base --all with clock skew and v1 commit-graph (side-exhaustion)' '
     -+	# With date ordering (v1 graph), the side-exhaustion
     -+	# optimization can fire too early.  In this topology, the P2
     -+	# side (se-B -> se-D -> se-root) fully drains from the queue
     -+	# while se-C (P1-only, low date) is still queued.  With
     -+	# generation ordering, se-C would be dequeued before se-D
     -+	# (child before parent), propagating P1 to se-D and
     -+	# discovering the merge base.  Date ordering violates this.
     ++test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
     ++	# Verify correct merge base under clock skew.  se-D (the
     ++	# merge base) has a higher date than its child se-C.
     ++	# Generation ordering ensures se-C is visited before se-D,
     ++	# so P1 paint propagates correctly and se-D is found.
      +	>input &&
      +	git rev-parse se-D >expect &&
      +	run_all_modes git merge-base --all se-A se-B &&
      +	test_paint_down_steps 6 4 6 6
      +'
      +
     -+test_expect_success 'merge-base --all with clock skew returns wrong merge base (side-exhaustion)' '
     -+	# With date ordering (v1 graph), side-exhaustion causes
     -+	# merge-base --all to return MB2 (too deep) instead of MB1
     -+	# (the correct closest merge base).  P1 paint reaches MB2
     -+	# via E (high date) before it reaches MB1 via C (low date).
     -+	# After MB2 is found as P1|P2, the P2 side drains and
     -+	# side-exhaustion fires while C is still in the queue.
     -+	# MB1 never receives P1 paint, so it is never identified
     -+	# as a merge base.  remove_redundant cannot discard MB2
     -+	# because MB1 was never found.
     ++test_expect_success 'merge-base --all with clock skew and redundant ancestor (side-exhaustion)' '
     ++	# Verify correct merge base when clock skew could cause a
     ++	# too-deep result.  MB1 is the correct merge base; MB2 is
     ++	# its ancestor.  A reaches MB2 via E (high date) and MB1
     ++	# via C (low date).  Generation ordering ensures C is
     ++	# visited before side-exhaustion fires, so MB1 is found
     ++	# and remove_redundant correctly discards MB2.
      +	>input &&
      +	git rev-parse se2-MB1 >expect &&
      +	run_all_modes git merge-base --all se2-A se2-B &&
  7:  42a75899f2 !  7:  92a327a94c commit-reach: introduce struct paint_state with per-side counters
     @@ commit-reach.c: static void clear_nonstale_queue(struct nonstale_queue *queue)
      +	default:
      +		BUG("unexpected paint state");
      +	}
     - }
     - 
     --static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
     ++}
     ++
      +static void paint_queue_put(struct paint_state *state,
      +			    struct commit *c, unsigned add_flags)
     - {
     --	struct commit *commit = nonstale_queue_get(queue);
     ++{
      +	unsigned old_flags = c->object.flags;
      +	c->object.flags |= add_flags;
      +
     @@ commit-reach.c: static void clear_nonstale_queue(struct nonstale_queue *queue)
      +		prio_queue_put(&state->queue, c);
      +		paint_count_update(state, c->object.flags, 1);
      +	}
     -+}
     + }
       
     --	if (commit)
     --		commit->object.flags &= ~ENQUEUED;
     +-static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
      +static struct commit *paint_queue_get(struct paint_state *state)
     -+{
     + {
     +-	struct commit *commit = nonstale_queue_get(queue);
      +	struct commit *commit = prio_queue_get(&state->queue);
      +
      +	if (!commit)
     @@ commit-reach.c: static void clear_nonstale_queue(struct nonstale_queue *queue)
      +	if (!state->parent1_count && !state->parent2_count &&
      +	    !state->mb_candidate_count)
      +		return NULL;
     -+
     + 
     +-	if (commit)
     +-		commit->object.flags &= ~ENQUEUED;
      +	paint_count_update(state, commit->object.flags, -1);
       	return commit;
       }
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       	};
      +	struct commit *commit;
       	int i;
     +-	int gen_ordered = 1;
       	int steps = 0;
       	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
       	struct commit_list **tail = result;
       
     --	if (!min_generation && !corrected_commit_dates_enabled(r))
     + 	if (!min_generation && !corrected_commit_dates_enabled(r)) {
      -		queue.pq.compare = compare_commits_by_commit_date;
     -+	if (!min_generation && !corrected_commit_dates_enabled(r)) {
     +-		gen_ordered = 0;
      +		state.queue.compare = compare_commits_by_commit_date;
      +		state.gen_ordered = 0;
     -+	}
     + 	}
       
       	one->object.flags |= PARENT1;
     - 	if (!n) {
     +@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       		commit_list_append(one, result);
       		return 0;
       	}
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       		struct commit_list *parents;
       		int flags;
       		timestamp_t generation = commit_graph_generation(commit);
     +@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     + 				 * descendant of this one.
     + 				 */
     + 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
     +-				    gen_ordered &&
     ++				    state.gen_ordered &&
     + 				    generation < GENERATION_NUMBER_INFINITY)
     + 					break;
     + 			}
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       			if ((p->object.flags & flags) == flags)
       				continue;
     @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:infinity-both-s
       '
       
       test_expect_success 'setup mixed finite/INFINITY topology' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all with clock skew returns wrong merge base (
     +@@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all with clock skew and redundant ancestor (si
       	>input &&
       	git rev-parse se2-MB1 >expect &&
       	run_all_modes git merge-base --all se2-A se2-B &&
  8:  f8f00b7bcc !  8:  0d552869be commit-reach: terminate merge-base walk when one paint side is exhausted
     @@ Commit message
          commit-reach: terminate merge-base walk when one paint side is exhausted
      
          Add an early termination check to paint_down_to_common() using the
     -    per-side counters introduced earlier.  Once the walk enters the
     +    per-side counters introduced earlier. Once the walk enters the
          finite-generation region, terminate early when one side's exclusive
          count drops to zero -- no new merge-base can form without both paint
          sides meeting.
     @@ Commit message
      
          The INFINITY gate ensures correctness: commits without a commit-graph
          entry have GENERATION_NUMBER_INFINITY and are ordered by commit date,
     -    which is not topologically reliable.  The optimization only fires
     +    which is not topologically reliable. The optimization only fires
          once the walk enters the finite-generation region where ordering
          guarantees hold.
      
     @@ Documentation/technical/paint-down-to-common.adoc: existing candidates by provin
       Generation cutoff
       ~~~~~~~~~~~~~~~~~
       Some callers (notably `remove_redundant()`) supply a `min_generation`
     +@@ Documentation/technical/paint-down-to-common.adoc: ordering via `compare_commits_by_commit_date`.  Because commit
     + dates are not monotonic (clock skew, rebases, etc.), the queue
     + may visit commits out of topological order.
     + 
     +-This disables the optimization that depends on generation ordering:
     ++This disables the optimizations that depend on generation ordering:
     + 
     +   - *Single result*: the first merge-base candidate found may not
     +     be the shallowest, because a deeper ancestor with a higher
     +     commit date can be dequeued first.
     + 
     ++  - *Side exhaustion*: one paint side can appear to drain from the
     ++    queue while commits from that side are still waiting with lower
     ++    dates, causing premature termination.
     ++
     + Related documentation
     + ---------------------
     + 
      
       ## commit-reach.c ##
      @@ commit-reach.c: static void paint_queue_put(struct paint_state *state,
     @@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all commit-walk steps'
      +	test_paint_down_steps 81 9 57 81
       '
       
     - test_expect_success 'merge-base --all with clock skew and v1 commit-graph (side-exhaustion)' '
     + test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
  9:  b45c302caa !  9:  598a963375 commit-reach: move min_generation check into paint_queue_get()
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       		if (flags == (PARENT1 | PARENT2)) {
       			if (!(commit->object.flags & RESULT)) {
      @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     - 				 * descendant of this one.
       				 */
       				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
     + 				    state.gen_ordered &&
      -				    generation < GENERATION_NUMBER_INFINITY)
      +				    state.last_gen < GENERATION_NUMBER_INFINITY)
       					break;
 10:  d68972b1d7 ! 10:  6d617da1f7 commit-reach: remove commit-date ordering fallback
     @@ Commit message
          Side-exhaustion (added in the previous commits) solves this
          differently by terminating the walk as soon as one paint side
          empties from the queue, preventing the deep walk regardless of
     -    queue ordering.  Benchmarks of "git merge-base --all v4.8 v4.9"
     +    queue ordering. Benchmarks of "git merge-base --all v4.8 v4.9"
          on the Linux kernel repo show that side-exhaustion reduces the
          step count far below what the date-ordering fallback achieved:
      
     @@ Commit message
      
          With generation ordering always active, the existing min_generation
          check in paint_queue_get() correctly identifies when the walk has
     -    reached the finite generation region.  The date ordering fallback
     +    reached the finite generation region. The date ordering fallback
          broke this invariant: a commit could have a finite topo level
          while the queue was date-ordered, causing the early exit to fire
          before all merge bases were found.
     @@ Commit message
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## Documentation/technical/paint-down-to-common.adoc ##
     -@@ Documentation/technical/paint-down-to-common.adoc: and PARENT2, it is a merge-base candidate. A candidate gains the
     - STALE flag so its ancestors propagate staleness -- any deeper common
     - ancestor is necessarily redundant.
     - 
     --NOTE: When the commit-graph uses only topological levels (generation
     --number v1) and the caller passes `min_generation = 0`, a legacy
     --fallback replaces the generation-ordered comparator with a pure
     --commit-date comparator. This breaks the ordering invariants
     --described below -- see <<date-ordering-fallback>>.
     --
     - [[generation-regions]]
     +@@ Documentation/technical/paint-down-to-common.adoc: ancestor is necessarily redundant.
       INFINITY and finite generation regions
       --------------------------------------
       
     @@ Documentation/technical/paint-down-to-common.adoc: and PARENT2, it is a merge-ba
      -default comparator). They do NOT hold when the date-ordering fallback
      -is active -- see <<date-ordering-fallback>>.
      -
     - The commit-graph stores a generation number for each commit. Commits
     - not in the commit-graph have generation `GENERATION_NUMBER_INFINITY`. The
     - graph is closed under reachability: if a commit is in the graph, all
     + The commit-graph stores a generation number for each commit.
     + Commits not in the commit-graph have generation
     + `GENERATION_NUMBER_INFINITY`. The graph is closed under
     +@@ Documentation/technical/paint-down-to-common.adoc: traversal: children are always visited before their parents. This
     + means that paint on already-visited commits is final -- no future
     + traversal step can add paint to them.
     + 
     +-In the INFINITY region, commit-date ordering can violate this: a
     +-parent with a later date can be visited before a child with an earlier
     +-date. Paint flags are therefore NOT final at visit time, and a
     +-commit visited with only one side's paint may later gain the other.
     ++In the INFINITY region, all commits share the same generation
     ++value, so the queue breaks ties by commit date. This can violate
     ++topological ordering: a parent with a later date can be visited
     ++before a child with an earlier date. Paint flags are therefore
     ++NOT final at visit time, and a commit visited with only one
     ++side's paint may later gain the other.
     + 
     + Paint flags are only added, never removed. Since each flag can be set
     + at most once per commit, the number of times a commit can be
      @@ Documentation/technical/paint-down-to-common.adoc: descendant of this candidate (generation ordering guarantees
       children are visited first), so it cannot be redundant and the walk
       can stop immediately.
     @@ Documentation/technical/paint-down-to-common.adoc: descendant of this candidate
      -Date-ordering fallback
      -----------------------
      -
     --When `min_generation` is zero and the commit-graph does not contain
     --corrected commit dates (generation number v1, which stores only
     --topological levels), `paint_down_to_common()` replaces the default
     --generation-ordered comparator with `compare_commits_by_commit_date`.
     +-When the commit-graph has generation numbers v1 and no
     +-generation floor is specified, topological ordering
     +-(via generation numbers) is disabled.  Topological levels are
     +-correct but unbalanced -- ordering by such generation numbers
     +-can sometimes cause the walk to detour too far before finding
     +-merge bases.  Commit-date ordering typically reaches them in
     +-fewer steps -- see this change for more details:
      -
     --This was introduced as a performance heuristic: topological levels
     --are coarser than commit dates, so date ordering can reach merge
     --bases in fewer steps when timestamps are well-behaved. However,
     --commit dates are not required to be monotonic -- a parent can have
     --a later date than its child (clock skew, rebases, etc.) -- so the
     --queue may visit commits out of topological order.
     +-   091f4cf3 (commit: don't use generation numbers if not needed,
     +-   2018-08-30)
      -
     --This disables optimizations that depend on generation ordering:
     +-With generation number v2 (corrected commit dates) we have the best
     +-of both worlds and do not need this fallback.
      -
     --  1. *Single result*: the first merge-base candidate found may not
     --     be the shallowest, because a deeper ancestor with a higher
     --     commit date can be dequeued first.
     +-For v1, `paint_down_to_common()` falls back to pure commit-date
     +-ordering via `compare_commits_by_commit_date`.  Because commit
     +-dates are not monotonic (clock skew, rebases, etc.), the queue
     +-may visit commits out of topological order.
      -
     --  2. *Side-exhaustion* (see subsequent commits): one paint side can
     --     appear to drain from the queue while commits from that side are
     --     still waiting with lower dates, causing premature termination.
     +-This disables the optimizations that depend on generation ordering:
     +-
     +-  - *Single result*: the first merge-base candidate found may not
     +-    be the shallowest, because a deeper ancestor with a higher
     +-    commit date can be dequeued first.
     +-
     +-  - *Side exhaustion*: one paint side can appear to drain from the
     +-    queue while commits from that side are still waiting with lower
     +-    dates, causing premature termination.
      -
       Related documentation
       ---------------------
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
       
       	one->object.flags |= PARENT1;
       	if (!n) {
     +@@ commit-reach.c: static int paint_down_to_common(struct repository *r,
     + 				 * descendant of this one.
     + 				 */
     + 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
     +-				    state.gen_ordered &&
     + 				    state.last_gen < GENERATION_NUMBER_INFINITY)
     + 					break;
     + 			}
      
       ## t/t6600-test-reach.sh ##
      @@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many:infinity-both-sides' '
     @@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all commit-walk steps'
      +	test_paint_down_steps 81 9 57 37
       '
       
     - test_expect_success 'merge-base --all with clock skew and v1 commit-graph (side-exhaustion)' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all with clock skew and v1 commit-graph (side-
     + test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
     +-	# Verify correct merge base under clock skew.  se-D (the
     +-	# merge base) has a higher date than its child se-C.
     +-	# Generation ordering ensures se-C is visited before se-D,
     +-	# so P1 paint propagates correctly and se-D is found.
     ++	# Verify that the merge base is computed correctly even
     ++	# when commits have non-monotonic commit dates.
       	>input &&
       	git rev-parse se-D >expect &&
       	run_all_modes git merge-base --all se-A se-B &&
     @@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all with clock skew and
      +	test_paint_down_steps 6 4 6 4
       '
       
     - test_expect_success 'merge-base --all with clock skew returns wrong merge base (side-exhaustion)' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'merge-base --all with clock skew returns wrong merge base (
     + test_expect_success 'merge-base --all with clock skew and redundant ancestor (side-exhaustion)' '
     +-	# Verify correct merge base when clock skew could cause a
     +-	# too-deep result.  MB1 is the correct merge base; MB2 is
     +-	# its ancestor.  A reaches MB2 via E (high date) and MB1
     +-	# via C (low date).  Generation ordering ensures C is
     +-	# visited before side-exhaustion fires, so MB1 is found
     +-	# and remove_redundant correctly discards MB2.
     ++	# Verify that the correct merge base is found even when
     ++	# non-monotonic commit dates could cause a redundant
     ++	# ancestor to be visited first.
       	>input &&
       	git rev-parse se2-MB1 >expect &&
       	run_all_modes git merge-base --all se2-A se2-B &&

-- 
gitgitgadget
