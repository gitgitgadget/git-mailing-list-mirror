Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915E6C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 11:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCTL1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 07:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCTL1H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 07:27:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE49C114
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so7267559wmq.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679311618;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QbaC+hfNO0izLZhSH54CJdKE10avD8NlUBtkK8Xap4=;
        b=WSoUTw2nvB95FHPXZMrAhvDAfr8JY3xS/qwjr2qQS8e8vKGKE11mqW4UsNccUq6Brf
         FxicFADc5hdAAZ+fnrmJXNxQxr5+goaK8xYeGT1VvrH8/h+Bk2yfHeSfuHk0vhEoVQ/G
         43gh6VzwVJCUIGJZ/yk8dzd7EKW9N95ouEiY42Ct07DUzIsE/HT97BibjKsj2O7osWU/
         AR2PdNRIdRHW4eiRsiTzfyzlXicTCthiuOlPXvC43qTvlogPIFPU/vDawhMCM8sdeKUi
         BXrShe+I/IDUXwc5b5GHhE2988LmMvReT+XDO+XuiTvUzpUK3hUWKg86w1URbuorZMfq
         kJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311618;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QbaC+hfNO0izLZhSH54CJdKE10avD8NlUBtkK8Xap4=;
        b=xPl4RDjzrWXnjOuM1sA8lVoKUCICyemGKu5GecvQEDPynXAMU7P3MwgLiekBH0rNVf
         YA392l8Moz9lH1LoSpSAAOnMS07zhQdmA0WDr+kSmcgShLMd+oc95a+r7PX6ULZxzAof
         ziQZn1seOu974EI0B7s1O1IpE5+US+Rf3znc7XRkrF3ASZX4thWs+kDEJ0dzHCdTUe8P
         DUvDudOy+/Qf2Q9VbtOPr2RxYyfx6iT7MskY2fZBOF859m0tf9Yvy7JDEAj7zUv57pY0
         LMvRfHTa6WFICMLkEmsTBXV7XIJktVGqqeAHYKKCrdt5Xsooh6qRtY0PD8A3na4a42m8
         yZvw==
X-Gm-Message-State: AO0yUKWoyN2wD4qaiag5Wxvq7LmqywKFn8yUHTatOYJGO31Q1dlNVasO
        76Oo/K7asIl4avy3BIqLDR+P2apQcP4=
X-Google-Smtp-Source: AK7set8b7qwikpqhx6nkJdRzB1wksk45al1oRWwwaFadZeQvTfHORd9CQfZOIAKEeOtBpSNHY/l8IQ==
X-Received: by 2002:a05:600c:d0:b0:3ee:392:39f2 with SMTP id u16-20020a05600c00d000b003ee039239f2mr1660195wmm.32.1679311617894;
        Mon, 20 Mar 2023 04:26:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3-20020adffb83000000b002c561805a4csm8644285wrr.45.2023.03.20.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:26:57 -0700 (PDT)
Message-Id: <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
References: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Mar 2023 11:26:46 +0000
Subject: [PATCH v4 0/9] ref-filter: ahead/behind counting, faster --merged option
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
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At $DAYJOB, we have used a custom 'ahead-behind' builtin in our fork of Git
for lots of reasons. The main goal of the builtin is to compare multiple
references against a common base reference. The comparison is number of
commits that are in each side of the symmtric difference of their reachable
sets. A commit C is "ahead" of a commit B by the number of commits in B..C
(reachable from C but not reachable from B). Similarly, the commit C is
"behind" the commit B by the number of commits in C..B (reachable from B but
not reachable from C).

These numbers can be computed by 'git rev-list --count B..C' and 'git
rev-list --count C..B', but there are common needs that benefit from having
the checks being done in the same process:

 1. Our "branches" page lists ahead/behind counts for each listed branch as
    compared to the repo's default branch. This can be done with a single
    'git ahead-behind' process.
 2. When a branch is updated, a background job checks if any pull requests
    that target that branch should be closed because their branches were
    merged implicitly by that update. These queries can be batched into 'git
    ahead-behind' calls.

In that second example, we don't need the full ahead/behind counts (although
it is sufficient to look for branches that are "zero commits ahead", meaning
they are reachable from the base), and instead reachability is the critical
piece.

This series contributes the custom algorithms we used for our 'git
ahead-behind' builtin, but as extensions to 'git for-each-ref':

 * Add a new "%(ahead-behind:<base>)" format token to for-each-ref which
   allows outputting the ahead/behind values in the format string for a
   matching ref.
 * Add a new algorithm that speeds up the 'git for-each-ref --merged='
   option. This also applies to the 'git branch --merged=' option.

The idea to use 'git for-each-ref' instead of creating a new builtin is from
Junio, and simplifies this series significantly compared to v1. I was
initially concerned about the overhead of 'git for-each-ref' and its
generality and sorting, but I was not able to measure any important
difference between this implementation and our internal 'git ahead-behind'
implementation. In particular, when a pattern is given to 'git for-each-ref'
that looks like an exact ref, it navigates directly to the ref instead of
scanning all references for matches.

However, for our specific uses, we like to batch a list of exact references
that could be very long. We introduce a new --stdin option here.

To keep things close to the v1 outline, I replaced the existing patches with
closely-related ones, when possible.

Patch 1 adds the --stdin option to 'git for-each-ref'. (This is similar to
the boilerplate patch from v1.)

Patch 2 adds a test to explicitly check that 'git for-each-ref' will still
succeed when all input refs are missing. (This is similar to the
--ignore-missing patch from v1.)

Patches 3-6 introduce a new method: ensure_generations_valid(). Patch 3
refactors the existing compute_topological_levels() to make it more generic
while Patch 4 ports compute_generation_numbers() onto that generic base.
Patch 5 updates the definition of commit_graph_generation() slightly, making
way for patch 6 to implement the in-memory computation of generation
numbers. With an existing commit-graph file, the commits that are not
present in the file are considered as having generation number "infinity".
This is useful for most of our reachability queries to this point, since
those commits are "above" the ones tracked by the commit-graph. When these
commits are low in number, then there is very little performance cost and
zero correctness cost. (These patches match v1 exactly.)

However, we will see that the ahead/behind computation requires accurate
generation numbers to avoid overcounting. Thus, ensure_generations_valid()
isa way to specify a list of commits that need generation numbers computed
before continuing. It's a no-op if all of those commits are in the
commit-graph file. It's expensive if the commit-graph doesn't exist.
However, '%(ahead-behind:)' computations are likely to be slow no matter
what without a commit-graph, so assuming an existing commit-graph file is
reasonable. If we find sufficient desire to have an implementation that does
not have this requirement, we could create a second implementation and
toggle to it when generation_numbers_enabled() returns false.

Patch 7 implements the ahead-behind algorithm, but it is not connected to a
builtin. It's a long commit message, so hopefully it explains the algorithm
sufficiently. (The difference from v1 is that it no longer integrates with a
builtin and there are no new tests. It also uses 'unsigned int' and is
correctly co-authored by Taylor.)

Patch 8 integrates the ahead-behind algorithm with the ref-filter code,
including parsing the "ahead-behind" token. This finally adds tests that
check both ahead_behind() and ensure_generations_valid() via
t6600-test-reach.sh. (This patch is essentially completely new in v2.)

Patch 9 implements the tips_reachable_from_base() method, and uses it within
the ref-filter code to speed up 'git for-each-ref --merged' and 'git branch
--merged'. (The interface is slightly different than v1, due to the needs of
the new caller.)


Updates in v4
=============

 * A string leak in Patch 1 is remedied.
 * v3's patch 3 is split into v4's patches 3 and 4. Patch 3 now only
   refactors compute_topological_levels(), leaving Patch 4 to only port
   compute_generation_numbers() to the new
   compute_reachable_generation_numbers().
 * Other edits in Patch 3:
   * compute_reachable_generation_numbers() drops the "_1" in its name.
   * Redundant progress counters are removed.
   * The progress struct is passed down into 'struct
     compute_generation_info' and not just the 'struct
     write_commit_graph_context'
 * Patch 6 adds context around why we care about in-memory generation
   number.
 * Patch 7 has several changes:
   * Includes extra context around the input data to ahead_behind() as well
     as some rewrite of the algorithm description.
   * uses DIV_ROUND_UP() to initialize the bitmap width.
   * renames init_bit_array() to get_bit_array() to make it clear that it
     will not regenerate the bitmap if it already exists.
   * adds a new comment before assigning the STALE bit
 * Patch 8 changes the expected format to output <committish> and checks the
   given base during the token parsing instead of delaying.


Updates in v3
=============

 * The APIs are modified to take a 'struct repository *' and use them
   appropriately.
 * The --stdin option in 'git for-each-ref' now uses strvec instead of an
   ad-hoc array.

Thanks, -Stolee

Derrick Stolee (8):
  for-each-ref: add --stdin option
  for-each-ref: explicitly test no matches
  commit-graph: refactor compute_topological_levels()
  commit-graph: simplify compute_generation_numbers()
  commit-graph: return generation from memory
  commit-reach: implement ahead_behind() logic
  for-each-ref: add ahead-behind format atom
  commit-reach: add tips_reachable_from_bases()

Taylor Blau (1):
  commit-graph: introduce `ensure_generations_valid()`

 Documentation/git-for-each-ref.txt |  12 +-
 builtin/branch.c                   |   1 +
 builtin/for-each-ref.c             |  26 +++-
 builtin/tag.c                      |   1 +
 commit-graph.c                     | 207 +++++++++++++++++----------
 commit-graph.h                     |   8 ++
 commit-reach.c                     | 216 +++++++++++++++++++++++++++++
 commit-reach.h                     |  40 ++++++
 ref-filter.c                       |  93 ++++++++++---
 ref-filter.h                       |  26 +++-
 t/perf/p1500-graph-walks.sh        |  50 +++++++
 t/t3203-branch-output.sh           |  14 ++
 t/t5318-commit-graph.sh            |   2 +-
 t/t6300-for-each-ref.sh            |  50 +++++++
 t/t6301-for-each-ref-errors.sh     |  14 ++
 t/t6600-test-reach.sh              | 169 ++++++++++++++++++++++
 t/t7004-tag.sh                     |  28 ++++
 17 files changed, 866 insertions(+), 91 deletions(-)
 create mode 100755 t/perf/p1500-graph-walks.sh


base-commit: 725f57037d81e24eacfda6e59a19c60c0b4c8062
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1489%2Fderrickstolee%2Fstolee%2Fupstream-ahead-behind-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1489/derrickstolee/stolee/upstream-ahead-behind-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1489

Range-diff vs v3:

  1:  f9e80e233f1 !  1:  27d94077aa9 for-each-ref: add --stdin option
     @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const
      +		while (strbuf_getline(&line, stdin) != EOF)
      +			strvec_push(&vec, line.buf);
      +
     ++		strbuf_release(&line);
     ++
      +		/* vec.v is NULL-terminated, just like 'argv'. */
      +		filter.name_patterns = vec.v;
      +	} else {
  2:  f56d6a64d24 =  2:  1e3d499431a for-each-ref: explicitly test no matches
  3:  3b15e9df770 !  3:  79a57f30a85 commit-graph: combine generation computations
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    commit-graph: combine generation computations
     +    commit-graph: refactor compute_topological_levels()
      
          This patch extracts the common code used to compute topological levels
          and corrected committer dates into a common routine,
     -    compute_reachable_generation_numbers_1().
     +    compute_reachable_generation_numbers(). For ease of reading, it only
     +    modifies compute_topological_levels() to use this new routine, leaving
     +    compute_generation_numbers() to be modified in the next change.
      
          This new routine dispatches to call the necessary functions to get and
          set the generation number for a given commit through a vtable (the
     @@ Commit message
          Computing the generation number itself is done in
          compute_generation_from_max(), which dispatches its implementation based
          on the generation version requested, or issuing a BUG() for unrecognized
     -    generation versions.
     +    generation versions. This does not use a vtable because the logic
     +    depends only on the generation number version, not where the data is
     +    being loaded from or being stored to. This is a subtle point that will
     +    make more sense in a future change that modifies the in-memory
     +    generation values instead of just preparing values for writing to a
     +    commit-graph file.
      
     -    This patch cleans up the two places that currently compute topological
     -    levels and corrected commit dates by reducing the amount of duplicated
     -    code. It also makes it possible to introduce a function which
     -    dynamically computes those values for commits that aren't stored in a
     -    commit-graph, which will be required for the forthcoming ahead-behind
     -    rewrite.
     +    This change looks like it adds a lot of new code. However, two upcoming
     +    changes will be quite small due to the work being done in this change.
      
     +    Co-authored-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ commit-graph.c: static void close_reachable(struct write_commit_graph_context *c
      +	}
      +}
      +
     -+static void compute_reachable_generation_numbers_1(
     ++static void compute_reachable_generation_numbers(
      +			struct compute_generation_info *info,
      +			int generation_version)
       {
     @@ commit-graph.c: static void close_reachable(struct write_commit_graph_context *c
      -	for (i = 0; i < ctx->commits.nr; i++) {
      -		struct commit *c = ctx->commits.list[i];
      -		uint32_t level;
     +-
     +-		repo_parse_commit(ctx->r, c);
     +-		level = *topo_level_slab_at(ctx->topo_levels, c);
      +	for (i = 0; i < info->commits->nr; i++) {
      +		struct commit *c = info->commits->list[i];
      +		timestamp_t gen;
      +		repo_parse_commit(info->r, c);
      +		gen = info->get_generation(c, info->data);
     - 
     --		repo_parse_commit(ctx->r, c);
     --		level = *topo_level_slab_at(ctx->topo_levels, c);
      +		display_progress(info->progress, info->progress_cnt + 1);
       
      -		display_progress(ctx->progress, i + 1);
     @@ commit-graph.c: static void compute_topological_levels(struct write_commit_graph
      +{
      +	struct write_commit_graph_context *ctx = data;
      +	*topo_level_slab_at(ctx->topo_levels, c) = (uint32_t)t;
     -+	display_progress(ctx->progress, ctx->progress_cnt + 1);
      +}
      +
      +static void compute_topological_levels(struct write_commit_graph_context *ctx)
      +{
      +	struct compute_generation_info info = {
      +		.r = ctx->r,
     -+		.progress = ctx->progress,
      +		.commits = &ctx->commits,
      +		.get_generation = get_topo_level,
      +		.set_generation = set_topo_level,
     @@ commit-graph.c: static void compute_topological_levels(struct write_commit_graph
      +	};
      +
      +	if (ctx->report_progress)
     -+		ctx->progress = start_delayed_progress(
     ++		info.progress = ctx->progress
     ++			      = start_delayed_progress(
      +					_("Computing commit graph topological levels"),
      +					ctx->commits.nr);
      +
     -+	compute_reachable_generation_numbers_1(&info, 1);
     -+
     - 	stop_progress(&ctx->progress);
     - }
     - 
     -+static timestamp_t get_generation_from_graph_data(struct commit *c, void *data)
     -+{
     -+	return commit_graph_data_at(c)->generation;
     -+}
     -+
     -+static void set_generation_v2(struct commit *c, timestamp_t t, void *data)
     -+{
     -+	struct write_commit_graph_context *ctx = data;
     -+	struct commit_graph_data *g = commit_graph_data_at(c);
     -+	g->generation = (uint32_t)t;
     -+	display_progress(ctx->progress, ctx->progress_cnt + 1);
     -+}
     -+
     - static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - {
     - 	int i;
     --	struct commit_list *list = NULL;
     -+	struct compute_generation_info info = {
     -+		.r = ctx->r,
     -+		.progress = ctx->progress,
     -+		.commits = &ctx->commits,
     -+		.get_generation = get_generation_from_graph_data,
     -+		.set_generation = set_generation_v2,
     -+		.data = ctx,
     -+	};
     - 
     - 	if (ctx->report_progress)
     - 		ctx->progress = start_delayed_progress(
     -@@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - 		}
     - 	}
     - 
     --	for (i = 0; i < ctx->commits.nr; i++) {
     --		struct commit *c = ctx->commits.list[i];
     --		timestamp_t corrected_commit_date;
     --
     --		repo_parse_commit(ctx->r, c);
     --		corrected_commit_date = commit_graph_data_at(c)->generation;
     --
     --		display_progress(ctx->progress, i + 1);
     --		if (corrected_commit_date != GENERATION_NUMBER_ZERO)
     --			continue;
     --
     --		commit_list_insert(c, &list);
     --		while (list) {
     --			struct commit *current = list->item;
     --			struct commit_list *parent;
     --			int all_parents_computed = 1;
     --			timestamp_t max_corrected_commit_date = 0;
     --
     --			for (parent = current->parents; parent; parent = parent->next) {
     --				repo_parse_commit(ctx->r, parent->item);
     --				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
     --
     --				if (corrected_commit_date == GENERATION_NUMBER_ZERO) {
     --					all_parents_computed = 0;
     --					commit_list_insert(parent->item, &list);
     --					break;
     --				}
     --
     --				if (corrected_commit_date > max_corrected_commit_date)
     --					max_corrected_commit_date = corrected_commit_date;
     --			}
     --
     --			if (all_parents_computed) {
     --				pop_commit(&list);
     --
     --				if (current->date && current->date > max_corrected_commit_date)
     --					max_corrected_commit_date = current->date - 1;
     --				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
     --			}
     --		}
     --	}
     -+	compute_reachable_generation_numbers_1(&info, 2);
     - 
     - 	for (i = 0; i < ctx->commits.nr; i++) {
     - 		struct commit *c = ctx->commits.list[i];
     -@@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - 		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
     - 			ctx->num_generation_data_overflows++;
     - 	}
     ++	compute_reachable_generation_numbers(&info, 1);
      +
       	stop_progress(&ctx->progress);
       }
  -:  ----------- >  4:  3fd6c758129 commit-graph: simplify compute_generation_numbers()
  4:  abd3e7a67be !  5:  fed76f0f08e commit-graph: return generation from memory
     @@ Commit message
          for the given commit but the graph_pos indicated the commit was not in
          the commit-graph file.
      
     +    However, an upcoming change will introduce the ability to set generation
     +    values in-memory without writing the commit-graph file. Thus, we can no
     +    longer trust 'graph_pos' to indicate whether or not the generation
     +    member can be trusted.
     +
          Instead, trust the 'generation' member if the commit has a value in the
          slab _and_ the 'generation' member is non-zero. Otherwise, treat it as
          GENERATION_NUMBER_INFINITY.
  5:  e197bddcace !  6:  17a1fc9b15e commit-graph: introduce `ensure_generations_valid()`
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
      +		.set_generation = set_generation_in_graph_data,
      +	};
      +
     -+	compute_reachable_generation_numbers_1(&info, generation_version);
     ++	compute_reachable_generation_numbers(&info, generation_version);
      +}
      +
       static void trace2_bloom_filter_write_statistics(struct write_commit_graph_context *ctx)
  6:  0fb3913810b !  7:  5d937184a0e commit-reach: implement ahead_behind() logic
     @@ Commit message
      
          The interface for ahead_behind() uses two arrays. The first array of
          commits contains the list of all starting points for the walk. This
     -    includes all tip commits _and_ base commits. The second array, using the
     -    new ahead_behind_count struct, indicates which commits from that initial
     -    array form the base/tip pair for the ahead/behind count it will store.
     +    includes all tip commits _and_ base commits. The second array specifies
     +    base/tip pairs by pointing to commits within the first array, by index.
     +    The second array also stores the resulting ahead/behind counts for each
     +    of these pairs.
      
          This implementation of ahead_behind() allows multiple bases, if desired.
          Even with multiple bases, there is only one commit walk used for
     @@ Commit message
      
          Now, let's discuss the ahead/behind counting algorithm.
      
     -    Each commit in the input commit list is associated with a bit position
     -    indicating "the ith commit can reach this commit". Each of these commits
     -    is associated with a bitmap with its position flipped on and then
     -    placed in a queue for walking commit history. We walk commits by popping
     -    the commit with maximum generation number out of the queue, guaranteeing
     -    that we will never walk a child of that commit in any future steps.
     +    The first array of commits are considered the starting commits. The
     +    index within that array will play a critical role.
     +
     +    We create a new commit slab that maps commits to a bitmap. For a given
     +    commit (anywhere in the history), its bitmap stores information relative
     +    to which of the input commits can reach that commit. The ith bit will be
     +    on if the ith commit from the starting list can reach that commit. It is
     +    important to notice that these bitmaps are not the typical "reachability
     +    bitmaps" that are stored in .bitmap files. Instead of signalling which
     +    objects are reachable from the current commit, they instead signal
     +    "which starting commits can reach me?" It is also important to know that
     +    the bitmap is not necessarily "complete" until we walk that commit. We
     +    will perform a commit walk by generation number in such a way that we
     +    can guarantee the bitmap is correct when we visit that commit.
     +
     +    At the beginning of the ahead_behind() method, we initialize the bitmaps
     +    for each of the starting commits. By enabling the ith bit for the ith
     +    starting commit, we signal "the ith commit can reach itself."
     +
     +    We walk commits by popping the commit with maximum generation number out
     +    of the queue, guaranteeing that we will never walk a child of that
     +    commit in any future steps.
      
          As we walk, we load the bitmap for the current commit and perform two
          main steps. The _second_ step examines each parent of the current commit
     @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, i
      +	c->object.flags |= PARENT2;
      +}
      +
     -+static struct bitmap *init_bit_array(struct commit *c, int width)
     ++static struct bitmap *get_bit_array(struct commit *c, int width)
      +{
      +	struct bitmap **bitmap = bit_arrays_at(&bit_arrays, c);
      +	if (!*bitmap)
     @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, i
      +		  struct ahead_behind_count *counts, size_t counts_nr)
      +{
      +	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
     -+	size_t width = (commits_nr + BITS_IN_EWORD - 1) / BITS_IN_EWORD;
     ++	size_t width = DIV_ROUND_UP(commits_nr, BITS_IN_EWORD);
      +
      +	if (!commits_nr || !counts_nr)
      +		return;
     @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, i
      +
      +	for (size_t i = 0; i < commits_nr; i++) {
      +		struct commit *c = commits[i];
     -+		struct bitmap *bitmap = init_bit_array(c, width);
     ++		struct bitmap *bitmap = get_bit_array(c, width);
      +
      +		bitmap_set(bitmap, i);
      +		insert_no_dup(&queue, c);
     @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, i
      +	while (queue_has_nonstale(&queue)) {
      +		struct commit *c = prio_queue_get(&queue);
      +		struct commit_list *p;
     -+		struct bitmap *bitmap_c = init_bit_array(c, width);
     ++		struct bitmap *bitmap_c = get_bit_array(c, width);
      +
      +		for (size_t i = 0; i < counts_nr; i++) {
      +			int reach_from_tip = !!bitmap_get(bitmap_c, counts[i].tip_index);
     @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, i
      +
      +			repo_parse_commit(r, p->item);
      +
     -+			bitmap_p = init_bit_array(p->item, width);
     ++			bitmap_p = get_bit_array(p->item, width);
      +			bitmap_or(bitmap_p, bitmap_c);
      +
     ++			/*
     ++			 * If this parent is reachable from every starting
     ++			 * commit, then none of its ancestors can contribute
     ++			 * to the ahead/behind count. Mark it as STALE, so
     ++			 * we can stop the walk when every commit in the
     ++			 * queue is STALE.
     ++			 */
      +			if (bitmap_popcount(bitmap_p) == commits_nr)
      +				p->item->object.flags |= STALE;
      +
  7:  59cf6759e60 !  8:  b8523e2be0b for-each-ref: add ahead-behind format atom
     @@ ref-filter.c: static int rest_atom_parser(struct ref_format *format, struct used
      +static int ahead_behind_atom_parser(struct ref_format *format, struct used_atom *atom,
      +				    const char *arg, struct strbuf *err)
      +{
     ++	struct string_list_item *item;
     ++
      +	if (!arg)
     -+		return strbuf_addf_ret(err, -1, _("expected format: %%(ahead-behind:<ref>)"));
     ++		return strbuf_addf_ret(err, -1, _("expected format: %%(ahead-behind:<committish>)"));
     ++
     ++	item = string_list_append(&format->bases, arg);
     ++	item->util = lookup_commit_reference_by_name(arg);
     ++	if (!item->util)
     ++		die("failed to find '%s'", arg);
      +
     -+	string_list_append(&format->bases, arg);
      +	return 0;
      +}
      +
     @@ ref-filter.c: static void reach_filter(struct ref_array *array,
      +		return;
      +
      +	ALLOC_ARRAY(commits, commits_nr);
     -+	for (size_t i = 0; i < format->bases.nr; i++) {
     -+		const char *name = format->bases.items[i].string;
     -+		commits[i] = lookup_commit_reference_by_name(name);
     -+		if (!commits[i])
     -+			die("failed to find '%s'", name);
     -+	}
     ++	for (size_t i = 0; i < format->bases.nr; i++)
     ++		commits[i] = format->bases.items[i].util;
      +
      +	ALLOC_ARRAY(array->counts, st_mult(format->bases.nr, array->nr));
      +
     @@ t/t6301-for-each-ref-errors.sh: test_expect_success 'Missing objects are reporte
      +test_expect_success 'ahead-behind requires an argument' '
      +	test_must_fail git for-each-ref \
      +		--format="%(ahead-behind)" 2>err &&
     -+	echo "fatal: expected format: %(ahead-behind:<ref>)" >expect &&
     ++	echo "fatal: expected format: %(ahead-behind:<committish>)" >expect &&
      +	test_cmp expect err
      +'
      +
  8:  7476a39331e =  9:  87fe9676aec commit-reach: add tips_reachable_from_bases()

-- 
gitgitgadget
