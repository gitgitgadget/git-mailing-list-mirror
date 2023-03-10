Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB299C6FD1F
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 17:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjCJRVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 12:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjCJRVP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 12:21:15 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE69210D321
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:21:07 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso3955504wmo.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678468866;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTtcKAsmw7kl0SU28cuAjLnwuAKgfDutTbFc4Wqg8EA=;
        b=YCybQjHB2CfYVFOW0sx1xZXZ8b3htmL6w4IUUGknBD22VidoNSu2fAmgQ8/nMQ6ANz
         Qury1YnVyZHIfy10WlAdWDNEWlfArrK93Dc4pjZOY91T/CU7KP83xG7GvnYffVcNX9XR
         VU9+sPR8b05qlxCyQoJprXoAjIGPCdTQA96TQwxQgvazFdKX+fTdfoax8OsyS87oo9yJ
         JZattm13/OSn8oNWetcFIFF3PI8b5bcV1Z5anTKj0v/ArHUTXS5Z5OhxkpcwZLcJdfBJ
         pRvfppewl8wabMBNsgZGWJ7gKQzlXXxJ1qWg+l59H3UsJfQnp97/Z7bkIvRs9cHl7N9C
         DNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678468866;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTtcKAsmw7kl0SU28cuAjLnwuAKgfDutTbFc4Wqg8EA=;
        b=8JlsRZUmKxJXeP6sMzawsVfEp8HKDVKQRGQ6uooR3VzuPlq7HNZdvXTILhuouKQ84X
         cjT4aGTsOchvJUD40rOnlFpWYAjfvAqHtaK9VH4MZtG7ibKpxcGwIQav7p2iHYO5r4Lq
         /lACQHQGXYt3lC38f0/lCvAMqR+/eCIATtTLfdlgrmX7oRictgNtgVf5LxgX6Iynda0C
         nQuFJ2KyJnhVFkewmcZsCoC9xzhSwHsCtIE9MlfK58RnBOkYiHhpBc0tEO2NfgRnUBkj
         UbisQRu39EB9/RV5odCKB3jhXrPMjPw8eFFzPII4oA9i0LGUIeOeAipZ56fMEtiIiYD9
         fysA==
X-Gm-Message-State: AO0yUKVRLtaoWs+DJQGZfZzjfnKSq93Fw+rIwjF7hoOoX/9bkJqZuxov
        HokfTLb9zGlo2snLGIv6fwdqGFOyiAg=
X-Google-Smtp-Source: AK7set/TTDXAxCUi+94F1batr9QRyJqDTMcURTYBirH+CDAI8G47yEaM7ya8asCOkmGwi27M9oWLtg==
X-Received: by 2002:a1c:f213:0:b0:3ea:d611:f8 with SMTP id s19-20020a1cf213000000b003ead61100f8mr3787022wmc.38.1678468865891;
        Fri, 10 Mar 2023 09:21:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w19-20020a05600c475300b003eb2e33f327sm770354wmo.2.2023.03.10.09.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:21:05 -0800 (PST)
Message-Id: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Mar 2023 17:20:55 +0000
Subject: [PATCH v2 0/8] ref-filter: ahead/behind counting, faster --merged option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
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
    merged implicitly by that update. These queries can e batched into 'git
    ahead-behind' calls.

In that second example, we don't need the full ahead/behind counts (although
it is sufficient to look for branches that are "zero commits ahead", meaning
they are reachable from the base), and instead reachability is the critical
piece.

This series contributes the custom algorithms we used for our 'git
ahead-behind' builtin, but as extensions to 'git for-each-ref':

 * Add a new "%(ahead-behind:)" format token to for-each-ref which allows
   outputting the ahead/behind values in the format string for a matching
   ref.
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

Patches 3-5 introduce a new method: ensure_generations_valid(). Patch 3 does
some refactoring of the existing generation number computations to make it
more generic, and patch 4 updates the definition of
commit_graph_generation() slightly, making way for patch 5 to implement the
method. With an existing commit-graph file, the commits that are not present
in the file are considered as having generation number "infinity". This is
useful for most of our reachability queries to this point, since those
commits are "above" the ones tracked by the commit-graph. When these commits
are low in number, then there is very little performance cost and zero
correctness cost. (These patches match v1 exactly.)

However, we will see that the ahead/behind computation requires accurate
generation numbers to avoid overcounting. Thus, ensure_generations_valid()
is a way to specify a list of commits that need generation numbers computed
before continuing. It's a no-op if all of those commits are in the
commit-graph file. It's expensive if the commit-graph doesn't exist.
However, '%(ahead-behind:)' computations are likely to be slow no matter
what without a commit-graph, so assuming an existing commit-graph file is
reasonable. If we find sufficient desire to have an implementation that does
not have this requirement, we could create a second implementation and
toggle to it when generation_numbers_enabled() returns false.

Patch 6 implements the ahead-behind algorithm, but it is not connected to a
builtin. It's a long commit message, so hopefully it explains the algorithm
sufficiently. (The difference from v1 is that it no longer integrates with a
builtin and there are no new tests. It also uses 'unsigned int' and is
correctly co-authored by Taylor.)

Patch 7 integrates the ahead-behind algorithm with the ref-filter code,
including parsing the "ahead-behind" token. This finally adds tests that
check both ahead_behind() and ensure_generations_valid() via
t6600-test-reach.sh. (This patch is essentially completely new in v2.)

Patch 8 implements the tips_reachable_from_base() method, and uses it within
the ref-filter code to speed up 'git for-each-ref --merged' and 'git branch
--merged'. (The interface is slightly different than v1, due to the needs of
the new caller.)

Thanks, -Stolee

Derrick Stolee (7):
  for-each-ref: add --stdin option
  for-each-ref: explicitly test no matches
  commit-graph: combine generation computations
  commit-graph: return generation from memory
  commit-reach: implement ahead_behind() logic
  for-each-ref: add ahead-behind format atom
  commit-reach: add tips_reachable_from_bases()

Taylor Blau (1):
  commit-graph: introduce `ensure_generations_valid()`

 Documentation/git-for-each-ref.txt |  12 +-
 builtin/branch.c                   |   1 +
 builtin/for-each-ref.c             |  32 ++++-
 builtin/tag.c                      |   1 +
 commit-graph.c                     | 208 ++++++++++++++++++----------
 commit-graph.h                     |   7 +
 commit-reach.c                     | 210 +++++++++++++++++++++++++++++
 commit-reach.h                     |  38 ++++++
 ref-filter.c                       |  89 +++++++++---
 ref-filter.h                       |  25 +++-
 t/perf/p1500-graph-walks.sh        |  50 +++++++
 t/t3203-branch-output.sh           |  14 ++
 t/t5318-commit-graph.sh            |   2 +-
 t/t6300-for-each-ref.sh            |  50 +++++++
 t/t6301-for-each-ref-errors.sh     |  12 ++
 t/t6600-test-reach.sh              | 169 +++++++++++++++++++++++
 t/t7004-tag.sh                     |  28 ++++
 17 files changed, 859 insertions(+), 89 deletions(-)
 create mode 100755 t/perf/p1500-graph-walks.sh


base-commit: 725f57037d81e24eacfda6e59a19c60c0b4c8062
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1489%2Fderrickstolee%2Fstolee%2Fupstream-ahead-behind-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1489/derrickstolee/stolee/upstream-ahead-behind-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1489

Range-diff vs v1:

 1:  0fd18b6d740 < -:  ----------- ahead-behind: create empty builtin
 2:  08fc0710017 ! 1:  a1d9e0f6ff6 ahead-behind: parse tip references
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    ahead-behind: parse tip references
     +    for-each-ref: add --stdin option
      
     -    Before implementing the logic to compute the ahead/behind counts, parse
     -    the unknown options as commits and place them in a string_list.
     +    When a user wishes to input a large list of patterns to 'git
     +    for-each-ref' (likely a long list of exact refs) there are frequently
     +    system limits on the number of command-line arguments.
      
     -    Be sure to error out when the reference is not found.
     +    Add a new --stdin option to instead read the patterns from standard
     +    input. Add tests that check that any unrecognized arguments are
     +    considered an error when --stdin is provided. Also, an empty pattern
     +    list is interpreted as the complete ref set.
     +
     +    When reading from stdin, we populate the filter.name_patterns array
     +    dynamically as opposed to pointing to the 'argv' array directly. This
     +    requires a careful cast while freeing the individual strings,
     +    conditioned on the --stdin option.
      
     -    Co-authored-by: Taylor Blau <me@ttaylorr.com>
     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     - ## builtin/ahead-behind.c ##
     -@@
     - #include "builtin.h"
     - #include "parse-options.h"
     - #include "config.h"
     -+#include "commit.h"
     - 
     - static const char * const ahead_behind_usage[] = {
     - 	N_("git ahead-behind --base=<ref> [ --stdin | <revs> ]"),
     - 	NULL
     - };
     + ## Documentation/git-for-each-ref.txt ##
     +@@ Documentation/git-for-each-ref.txt: SYNOPSIS
     + --------
     + [verse]
     + 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
     +-		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
     ++		   [(--sort=<key>)...] [--format=<format>]
     ++		   [ --stdin | <pattern>... ]
     + 		   [--points-at=<object>]
     + 		   [--merged[=<object>]] [--no-merged[=<object>]]
     + 		   [--contains[=<object>]] [--no-contains[=<object>]]
     +@@ Documentation/git-for-each-ref.txt: OPTIONS
     + 	literally, in the latter case matching completely or from the
     + 	beginning up to a slash.
       
     -+static int handle_arg(struct string_list *tips, const char *arg)
     -+{
     -+	struct string_list_item *item;
     -+	struct commit *c = lookup_commit_reference_by_name(arg);
     -+
     -+	if (!c)
     -+		return error(_("could not resolve '%s'"), arg);
     -+
     -+	item = string_list_append(tips, arg);
     -+	item->util = c;
     -+	return 0;
     -+}
     ++--stdin::
     ++	If `--stdin` is supplied, then the list of patterns is read from
     ++	standard input instead of from the argument list.
      +
     - int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
     - {
     - 	const char *base_ref = NULL;
     - 	int from_stdin = 0;
     -+	struct string_list tips = STRING_LIST_INIT_DUP;
     + --count=<count>::
     + 	By default the command shows all refs that match
     + 	`<pattern>`.  This option makes it stop after showing
     +
     + ## builtin/for-each-ref.c ##
     +@@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
     + 	struct ref_format format = REF_FORMAT_INIT;
     + 	struct strbuf output = STRBUF_INIT;
     + 	struct strbuf err = STRBUF_INIT;
     ++	int from_stdin = 0;
       
     - 	struct option ahead_behind_opts[] = {
     - 		OPT_STRING('b', "base", &base_ref, N_("base"), N_("base reference to process")),
     -@@ builtin/ahead-behind.c: int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
     + 	struct option opts[] = {
     + 		OPT_BIT('s', "shell", &format.quote_style,
     +@@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
     + 		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
     + 		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
     + 		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
     ++		OPT_BOOL(0, "stdin", &from_stdin, N_("read reference patterns from stdin")),
     + 		OPT_END(),
     + 	};
       
     - 	git_config(git_default_config, NULL);
     +@@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
     + 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
     + 	filter.ignore_case = icase;
       
     +-	filter.name_patterns = argv;
      +	if (from_stdin) {
      +		struct strbuf line = STRBUF_INIT;
     ++		size_t nr = 0, alloc = 16;
      +
     -+		while (strbuf_getline(&line, stdin) != EOF) {
     -+			if (!line.len)
     -+				break;
     ++		if (argv[0])
     ++			die(_("unknown arguments supplied with --stdin"));
      +
     -+			if (handle_arg(&tips, line.buf))
     -+				return 1;
     ++		CALLOC_ARRAY(filter.name_patterns, alloc);
     ++
     ++		while (strbuf_getline(&line, stdin) != EOF) {
     ++			ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
     ++			filter.name_patterns[nr++] = strbuf_detach(&line, NULL);
      +		}
      +
     -+		strbuf_release(&line);
     ++		/* Add a terminating NULL string. */
     ++		ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
     ++		filter.name_patterns[nr + 1] = NULL;
      +	} else {
     -+		int i;
     -+		for (i = 0; i < argc; ++i) {
     -+			if (handle_arg(&tips, argv[i]))
     -+				return 1;
     -+		}
     ++		filter.name_patterns = argv;
      +	}
      +
     -+	/* Early return for no tips. */
     -+	if (!tips.nr)
     -+		return 0;
     -+
     + 	filter.match_as_path = 1;
     + 	filter_refs(&array, &filter, FILTER_REFS_ALL);
     + 	ref_array_sort(sorting, &array);
     +@@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
     + 	free_commit_list(filter.with_commit);
     + 	free_commit_list(filter.no_commit);
     + 	ref_sorting_release(sorting);
     ++	if (from_stdin) {
     ++		for (size_t i = 0; filter.name_patterns[i]; i++)
     ++			free((char *)filter.name_patterns[i]);
     ++		free(filter.name_patterns);
     ++	}
       	return 0;
       }
      
     - ## t/t4218-ahead-behind.sh ##
     -@@ t/t4218-ahead-behind.sh: test_expect_success 'git ahead-behind without --base' '
     - 	grep "usage:" err
     - '
     + ## t/t6300-for-each-ref.sh ##
     +@@ t/t6300-for-each-ref.sh: sig_crlf="$(printf "%s" "$sig" | append_cr; echo dummy)"
     + sig_crlf=${sig_crlf%dummy}
     + test_atom refs/tags/fake-sig-crlf contents:signature "$sig_crlf"
       
     -+test_expect_success 'git ahead-behind with broken tip' '
     -+	test_must_fail git ahead-behind --base=HEAD bogus 2>err &&
     -+	grep "could not resolve '\''bogus'\''" err
     ++test_expect_success 'git for-each-ref --stdin: empty' '
     ++	>in &&
     ++	git for-each-ref --format="%(refname)" --stdin <in >actual &&
     ++	git for-each-ref --format="%(refname)" >expect &&
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git ahead-behind without tips' '
     -+	git ahead-behind --base=HEAD 2>err &&
     -+	test_must_be_empty err
     ++test_expect_success 'git for-each-ref --stdin: fails if extra args' '
     ++	>in &&
     ++	test_must_fail git for-each-ref --format="%(refname)" \
     ++		--stdin refs/heads/extra <in 2>err &&
     ++	grep "unknown arguments supplied with --stdin" err
     ++'
     ++
     ++test_expect_success 'git for-each-ref --stdin: matches' '
     ++	cat >in <<-EOF &&
     ++	refs/tags/multi*
     ++	refs/heads/amb*
     ++	EOF
     ++
     ++	cat >expect <<-EOF &&
     ++	refs/heads/ambiguous
     ++	refs/tags/multi-ref1-100000-user1
     ++	refs/tags/multi-ref1-100000-user2
     ++	refs/tags/multi-ref1-200000-user1
     ++	refs/tags/multi-ref1-200000-user2
     ++	refs/tags/multi-ref2-100000-user1
     ++	refs/tags/multi-ref2-100000-user2
     ++	refs/tags/multi-ref2-200000-user1
     ++	refs/tags/multi-ref2-200000-user2
     ++	refs/tags/multiline
     ++	EOF
     ++
     ++	git for-each-ref --format="%(refname)" --stdin <in >actual &&
     ++	test_cmp expect actual
      +'
      +
       test_done
 3:  b1d022c7cac < -:  ----------- ahead-behind: implement --ignore-missing option
 -:  ----------- > 2:  2f162a2f39f for-each-ref: explicitly test no matches
 4:  853891c0b14 = 3:  db28e82d2a6 commit-graph: combine generation computations
 5:  c6e6581e0ea ! 4:  3cf33801443 commit-graph: return generation from memory
     @@ Commit message
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## commit-graph.c ##
     -@@ commit-graph.c: uint32_t commit_graph_position(const struct commit *c)
     - 	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
     - }
     - 
     -+
     - timestamp_t commit_graph_generation(const struct commit *c)
     - {
     +@@ commit-graph.c: timestamp_t commit_graph_generation(const struct commit *c)
       	struct commit_graph_data *data =
       		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
       
 6:  f31994ac78a = 5:  34dffd836b1 commit-graph: introduce `ensure_generations_valid()`
 7:  b8c55ecf88d ! 6:  9831c23eadb ahead-behind: implement ahead_behind() logic
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    ahead-behind: implement ahead_behind() logic
     +    commit-reach: implement ahead_behind() logic
      
     -    Fully implement the commit-counting logic behind the ahead-behind
     -    builtin as a new ahead_behind() method in commit-reach.h. Add tests
     -    for the functionality in both t4218-ahead-behind.sh and
     -    t6600-test-reach.sh. The tests in t4218 are rather simple, but cover a
     -    simple diamond commit history completely while the tests in t6600 make
     -    use of the more complicated commit history and the test setup to check
     -    three repository states: no commit-graph, a complete commit-graph, and a
     -    half-filled commit-graph. These extra states are particularly helpful to
     -    check due to the implementation of ahead_behind() and how it relies upon
     -    ensure_generations_valid().
     +    Fully implement the commit-counting logic required to determine
     +    ahead/behind counts for a batch of commit pairs. This is a new library
     +    method within commit-reach.h. This method will be linked to the
     +    for-each-ref builtin in the next change.
      
          The interface for ahead_behind() uses two arrays. The first array of
          commits contains the list of all starting points for the walk. This
     @@ Commit message
          new ahead_behind_count struct, indicates which commits from that initial
          array form the base/tip pair for the ahead/behind count it will store.
      
     -    While the ahead-behind builtin currently only supports one base, this
     -    implementation of ahead_behind() allows multiple bases, if desired. Even
     -    with multiple bases, there is only one commit walk used for counting the
     -    ahead/behind values, saving time when the base/tip ranges overlap
     -    significantly.
     +    This implementation of ahead_behind() allows multiple bases, if desired.
     +    Even with multiple bases, there is only one commit walk used for
     +    counting the ahead/behind values, saving time when the base/tip ranges
     +    overlap significantly.
      
          This interface for ahead_behind() also makes it very easy to call
          ensure_generations_valid() on the entire array of bases and tips. This
     @@ Commit message
          commits, in case ahead_behind() is called multiple times in the same
          process.
      
     -    There is no previous implementation of ahead-behind to compare against.
     -    A previous implementation in another fork of Git used a single process
     -    to essentially do the same walk as 'git rev-list --count <base>..<tip>'
     -    for every base/tip pair given as input. The single-walk implementation
     -    in this change was a significant improvement over that implementation.
     -    Another version from that fork used reachability bitmaps for the
     -    comparison, but that implementation was slower than the current commit
     -    walk implementation in almost all cases.
     -
     -    To best present _some_ amount of evidence for this performance gain,
     -    create a new performance test, p1500-graph-walks.sh. This script could
     -    be used for other walks than just ahead-behind in the future, but let's
     -    limit to ahead-behind now.
     -
     -    To gain some amount of a baseline, create one test that checks 'git
     -    ahead-behind' against up to 50 tips and another that uses 'git rev-list
     -    --count' in a loop. Be sure to write a commit-graph before running the
     -    performance tests.
     -
     -    Using the Git source code as the repository, we see a pronounced
     -    improvement:
     -
     -    Test                                            this tree
     -    ---------------------------------------------------------------
     -    1500.2: ahead-behind counts: git ahead-behind   0.08(0.07+0.01)
     -    1500.3: ahead-behind counts: git rev-list       1.11(0.92+0.18)
     -
     -    But the de-facto performance benchmark is the Linux kernel repository,
     -    which presents these values for my copy:
     -
     -    Test                                            this tree
     -    ---------------------------------------------------------------
     -    1500.2: ahead-behind counts: git ahead-behind   0.27(0.25+0.02)
     -    1500.3: ahead-behind counts: git rev-list       4.53(3.92+0.60)
     -
     +    Co-authored-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     - ## builtin/ahead-behind.c ##
     -@@
     - #include "parse-options.h"
     - #include "config.h"
     - #include "commit.h"
     -+#include "commit-reach.h"
     - 
     - static const char * const ahead_behind_usage[] = {
     - 	N_("git ahead-behind --base=<ref> [ --stdin | <revs> ]"),
     -@@ builtin/ahead-behind.c: static int handle_arg(struct string_list *tips, const char *arg)
     - int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
     - {
     - 	const char *base_ref = NULL;
     -+	struct commit *base;
     - 	int from_stdin = 0;
     - 	struct string_list tips = STRING_LIST_INIT_DUP;
     -+	struct commit **commits;
     -+	struct ahead_behind_count *counts;
     -+	size_t i;
     - 
     - 	struct option ahead_behind_opts[] = {
     - 		OPT_STRING('b', "base", &base_ref, N_("base"), N_("base reference to process")),
     -@@ builtin/ahead-behind.c: int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
     - 	if (!tips.nr)
     - 		return 0;
     - 
     -+	ALLOC_ARRAY(commits, tips.nr + 1);
     -+	ALLOC_ARRAY(counts, tips.nr);
     -+
     -+	for (i = 0; i < tips.nr; i++) {
     -+		commits[i] = tips.items[i].util;
     -+		counts[i].tip_index = i;
     -+		counts[i].base_index = tips.nr;
     -+	}
     -+	commits[tips.nr] = base;
     -+
     -+	ahead_behind(commits, tips.nr + 1, counts, tips.nr);
     -+
     -+	for (i = 0; i < tips.nr; i++)
     -+		printf("%s %d %d\n", tips.items[i].string,
     -+		       counts[i].ahead, counts[i].behind);
     -+
     -+	free(counts);
     -+	free(commits);
     - 	return 0;
     - }
     -
       ## commit-reach.c ##
      @@
       #include "revision.h"
     @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, i
      +		struct bitmap *bitmap_c = init_bit_array(c, width);
      +
      +		for (i = 0; i < counts_nr; i++) {
     -+			int reach_from_tip = bitmap_get(bitmap_c, counts[i].tip_index);
     -+			int reach_from_base = bitmap_get(bitmap_c, counts[i].base_index);
     ++			int reach_from_tip = !!bitmap_get(bitmap_c, counts[i].tip_index);
     ++			int reach_from_base = !!bitmap_get(bitmap_c, counts[i].base_index);
      +
      +			if (reach_from_tip ^ reach_from_base) {
      +				if (reach_from_base)
     @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, i
      +		free_bit_array(c);
      +	}
      +
     ++	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
      +	repo_clear_commit_marks(the_repository, PARENT2 | STALE);
      +	clear_bit_arrays(&bit_arrays);
      +	clear_prio_queue(&queue);
     @@ commit-reach.h: struct commit_list *get_reachable_subset(struct commit **from, i
      +	 * 'behind' stores the number of commits reachable from the base
      +	 * and not reachable from the tip.
      +	 */
     -+	int ahead;
     -+	int behind;
     ++	unsigned int ahead;
     ++	unsigned int behind;
      +};
      +
     -+/**
     ++/*
      + * Given an array of commits and an array of ahead_behind_count pairs,
      + * compute the ahead/behind counts for each pair.
      + */
     @@ commit-reach.h: struct commit_list *get_reachable_subset(struct commit **from, i
      +		  struct ahead_behind_count *counts, size_t counts_nr);
      +
       #endif
     -
     - ## t/perf/p1500-graph-walks.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='Commit walk performance tests'
     -+. ./perf-lib.sh
     -+
     -+test_perf_large_repo
     -+
     -+test_expect_success 'setup' '
     -+	git for-each-ref --format="%(refname)" "refs/heads/*" "refs/tags/*" >allrefs &&
     -+	sort -r allrefs | head -n 50 >refs &&
     -+	git commit-graph write --reachable
     -+'
     -+
     -+test_perf 'ahead-behind counts: git ahead-behind' '
     -+	git ahead-behind --base=HEAD --stdin <refs
     -+'
     -+
     -+test_perf 'ahead-behind counts: git rev-list' '
     -+	for r in $(cat refs)
     -+	do
     -+		git rev-list --count "HEAD..$r" || return 1
     -+	done
     -+'
     -+
     -+test_done
     -
     - ## t/t4218-ahead-behind.sh ##
     -@@ t/t4218-ahead-behind.sh: test_description='git ahead-behind command-line options'
     - 
     - . ./test-lib.sh
     - 
     -+test_expect_success 'setup simple history' '
     -+	test_commit base &&
     -+	git checkout -b right &&
     -+	test_commit right &&
     -+	git checkout -b left base &&
     -+	test_commit left &&
     -+	git checkout -b merge &&
     -+	git merge right -m "merge"
     -+'
     -+
     - test_expect_success 'git ahead-behind -h' '
     - 	test_must_fail git ahead-behind -h >out &&
     - 	grep "usage:" out
     -@@ t/t4218-ahead-behind.sh: test_expect_success 'git ahead-behind without --base' '
     - 	grep "usage:" err
     - '
     - 
     -+test_expect_success 'git ahead-behind with broken --base' '
     -+	test_must_fail git ahead-behind --base=bogus HEAD 2>err &&
     -+	grep "could not resolve '\''bogus'\''" err
     -+'
     -+
     - test_expect_success 'git ahead-behind with broken tip' '
     - 	test_must_fail git ahead-behind --base=HEAD bogus 2>err &&
     - 	grep "could not resolve '\''bogus'\''" err
     -@@ t/t4218-ahead-behind.sh: test_expect_success 'git ahead-behind without tips' '
     - 	test_must_be_empty err
     - '
     - 
     -+test_expect_success 'git ahead-behind --base=base' '
     -+	git ahead-behind --base=base base left right merge >actual &&
     -+
     -+	cat >expect <<-EOF &&
     -+	base 0 0
     -+	left 1 0
     -+	right 1 0
     -+	merge 3 0
     -+	EOF
     -+
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'git ahead-behind --base=left' '
     -+	git ahead-behind --base=left base left right merge >actual &&
     -+
     -+	cat >expect <<-EOF &&
     -+	base 0 1
     -+	left 0 0
     -+	right 1 1
     -+	merge 2 0
     -+	EOF
     -+
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'git ahead-behind --base=right' '
     -+	git ahead-behind --base=right base left right merge >actual &&
     -+
     -+	cat >expect <<-EOF &&
     -+	base 0 1
     -+	left 1 1
     -+	right 0 0
     -+	merge 2 0
     -+	EOF
     -+
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'git ahead-behind --base=merge' '
     -+	git ahead-behind --base=merge base left right merge >actual &&
     -+
     -+	cat >expect <<-EOF &&
     -+	base 0 3
     -+	left 0 2
     -+	right 0 2
     -+	merge 0 0
     -+	EOF
     -+
     -+	test_cmp expect actual
     -+'
     -+
     - test_done
     -
     - ## t/t6600-test-reach.sh ##
     -@@ t/t6600-test-reach.sh: test_expect_success 'get_reachable_subset:none' '
     - 	test_all_modes get_reachable_subset
     - '
     - 
     -+test_expect_success 'ahead-behind:linear' '
     -+	cat >input <<-\EOF &&
     -+	commit-1-1
     -+	commit-1-3
     -+	commit-1-5
     -+	commit-1-8
     -+	EOF
     -+	cat >expect <<-\EOF &&
     -+	commit-1-1 0 8
     -+	commit-1-3 0 6
     -+	commit-1-5 0 4
     -+	commit-1-8 0 1
     -+	EOF
     -+	run_all_modes git ahead-behind --base=commit-1-9 --stdin
     -+'
     -+
     -+test_expect_success 'ahead-behind:all' '
     -+	cat >input <<-\EOF &&
     -+	commit-1-1
     -+	commit-2-4
     -+	commit-4-2
     -+	commit-4-4
     -+	EOF
     -+	cat >expect <<-\EOF &&
     -+	commit-1-1 0 24
     -+	commit-2-4 0 17
     -+	commit-4-2 0 17
     -+	commit-4-4 0 9
     -+	EOF
     -+	run_all_modes git ahead-behind --base=commit-5-5 --stdin
     -+'
     -+
     -+test_expect_success 'ahead-behind:some' '
     -+	cat >input <<-\EOF &&
     -+	commit-1-1
     -+	commit-5-3
     -+	commit-4-8
     -+	commit-9-9
     -+	EOF
     -+	cat >expect <<-\EOF &&
     -+	commit-1-1 0 53
     -+	commit-5-3 0 39
     -+	commit-4-8 8 30
     -+	commit-9-9 27 0
     -+	EOF
     -+	run_all_modes git ahead-behind --base=commit-9-6 --stdin
     -+'
     -+
     -+test_expect_success 'ahead-behind:none' '
     -+	cat >input <<-\EOF &&
     -+	commit-7-5
     -+	commit-4-8
     -+	commit-9-9
     -+	EOF
     -+	cat >expect <<-\EOF &&
     -+	commit-7-5 7 4
     -+	commit-4-8 16 16
     -+	commit-9-9 49 0
     -+	EOF
     -+	run_all_modes git ahead-behind --base=commit-8-4 --stdin
     -+'
     -+
     - test_done
 -:  ----------- > 7:  82dd6f44a33 for-each-ref: add ahead-behind format atom
 8:  07eb2cbb699 ! 8:  f3fb6833bd7 ahead-behind: add --contains mode
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    ahead-behind: add --contains mode
     +    commit-reach: add tips_reachable_from_bases()
      
     -    The 'git ahead-behind' builtin can answer a list of questions that do
     -    not require the full ahead/behind counts. For example, instead of using
     -    'git branch --contains=<ref>' to get the full list of branches that
     -    contain the commit at <ref>, a list of tips could be passed to 'git
     -    ahead-behind --base=<ref>' and the rows that report a "behind" value of
     -    zero show which tips can reach <ref>.
     +    Both 'git for-each-ref --merged=<X>' and 'git branch --merged=<X>' use
     +    the ref-filter machinery to select references or branches (respectively)
     +    that are reachable from a set of commits presented by one or more
     +    --merged arguments. This happens within reach_filter(), which uses the
     +    revision-walk machinery to walk history in a standard way.
      
     -    By contract, the rows that report an "ahead" value of zero show which
     -    tips are reachable from the given base. This type of query does not have
     -    an existing equivalent for batching this request. While extracting the
     -    information from 'git ahead-behind' is not terribly difficult, it does
     -    more work than required to answer this query: it _counts_.
     +    However, the commit-reach.c file is full of custom searches that are
     +    more efficient, especially for reachability queries that can terminate
     +    early when reachability is discovered. Add a new
     +    tips_reachable_from_bases() method to commit-reach.c and call it from
     +    within reach_filter() in ref-filter.c. This affects both 'git branch'
     +    and 'git for-each-ref' as tested in p1500-graph-walks.sh.
      
     -    Add a new '--contains' mode to 'git ahead-behind' that removes the
     -    counting behavior and focuses instead on the reachability concern. The
     -    output of the builtin changes in this mode: instead of reporting "<tip>
     -    <ahead> <behind>" for every input tip, it will instead report "<tip>"
     -    for the input tips that are reachable from the specified base.
     +    For the Linux kernel repository, we take an already-fast algorithm and
     +    make it even faster:
     +
     +    Test                                            HEAD~1  HEAD
     +    -------------------------------------------------------------------
     +    1500.5: contains: git for-each-ref --merged     0.13    0.02 -84.6%
     +    1500.6: contains: git branch --merged           0.14    0.02 -85.7%
     +    1500.7: contains: git tag --merged              0.15    0.03 -80.0%
     +
     +    (Note that we remove the iterative 'git rev-list' test from p1500
     +    because it no longer makes sense as a comparison to 'git for-each-ref'
     +    and would just waste time running it for these comparisons.)
      
          The algorithm is implemented in commit-reach.c in the method
          tips_reachable_from_base(). This method takes a string_list of tips and
     @@ Commit message
          from the start, but we will walk only the necessary portion of the
          depth-first search for the reachable commits of lower generation.
      
     -    We can test this completely in the simple repo example in t4218 and more
     -    substantially in the larger repository example in t6600. We can also add
     -    a performance test to demonstrate the speedup relative to the 'git
     -    ahead-behind' builtin without the '--contains' option.
     -
     -    For the Git source code repository, I was able to measure a speedup,
     -    even though both are quite fast.
     -
     -    Test                                                       this tree
     -    --------------------------------------------------------------------------
     -    1500.2: ahead-behind counts: git ahead-behind              0.06(0.06+0.00)
     -    1500.3: ahead-behind counts: git rev-list                  1.08(0.90+0.18)
     -    1500.4: ahead-behind counts: git ahead-behind --contains   0.02(0.02+0.00)
     -
     -    In the Linux kernel repository, the impact is more pronounced:
     -
     -    Test                                                       this tree
     -    --------------------------------------------------------------------------
     -    1500.2: ahead-behind counts: git ahead-behind              0.26(0.25+0.01)
     -    1500.3: ahead-behind counts: git rev-list                  4.58(3.92+0.66)
     -    1500.4: ahead-behind counts: git ahead-behind --contains   0.02(0.00+0.02)
     +    Add extra tests for this behavior in t6600-test-reach.sh as the
     +    interesting data shape of that repository can sometimes demonstrate
     +    corner case bugs.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     - ## Documentation/git-ahead-behind.txt ##
     -@@ Documentation/git-ahead-behind.txt: git-ahead-behind - Count the commits on each side of a revision range
     - SYNOPSIS
     - --------
     - [verse]
     --'git ahead-behind' --base=<ref> [ --stdin | <revs> ]
     -+'git ahead-behind' --base=<ref> [ --contains ] [ --stdin | <revs> ]
     - 
     - DESCRIPTION
     - -----------
     -@@ Documentation/git-ahead-behind.txt: reported to stdout one line at a time as follows:
     - There will be exactly one line per input revision, but the lines may be
     - in an arbitrary order.
     - 
     -+If the `--contains` option is provided, then the output will list the
     -+`<tip>` refs are reachable from the provided `<base>`, one per line.
     -+
     - 
     - OPTIONS
     - -------
     -@@ Documentation/git-ahead-behind.txt: OPTIONS
     - 	Read revision tips and ranges from stdin instead of from the
     - 	command-line.
     - 
     -+--contains::
     -+	Specify that instead of counting the ahead/behind values, only
     -+	indicate whether each tip reference is reachable from the base. In
     -+	this mode, the output format changes to include only the name of
     -+	each tip by name, one per line, and only the tips reachable from
     -+	the base are included in the output.
     -+
     - --ignore-missing::
     - 	When parsing tip references, ignore any references that are not
     - 	found. This is useful when operating in an environment where a
     -
     - ## builtin/ahead-behind.c ##
     -@@
     - #include "commit-reach.h"
     - 
     - static const char * const ahead_behind_usage[] = {
     --	N_("git ahead-behind --base=<ref> [ --stdin | <revs> ]"),
     -+	N_("git ahead-behind --base=<ref> [ --contains ] [ --stdin | <revs> ]"),
     - 	NULL
     - };
     - 
     -@@ builtin/ahead-behind.c: int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
     - {
     - 	const char *base_ref = NULL;
     - 	struct commit *base;
     --	int from_stdin = 0;
     -+	int from_stdin = 0, contains = 0;
     - 	struct string_list tips = STRING_LIST_INIT_DUP;
     - 	struct commit **commits;
     - 	struct ahead_behind_count *counts;
     -@@ builtin/ahead-behind.c: int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
     - 		OPT_STRING('b', "base", &base_ref, N_("base"), N_("base reference to process")),
     - 		OPT_BOOL(0 , "stdin", &from_stdin, N_("read rev names from stdin")),
     - 		OPT_BOOL(0 , "ignore-missing", &ignore_missing, N_("ignore missing tip references")),
     -+		OPT_BOOL(0 , "contains", &contains, N_("only check that tips are reachable from the base")),
     - 		OPT_END()
     - 	};
     - 
     -@@ builtin/ahead-behind.c: int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
     - 
     - 	git_config(git_default_config, NULL);
     - 
     -+	base = lookup_commit_reference_by_name(base_ref);
     -+	if (!base)
     -+		die(_("could not resolve '%s'"), base_ref);
     -+
     - 	if (from_stdin) {
     - 		struct strbuf line = STRBUF_INIT;
     - 
     -@@ builtin/ahead-behind.c: int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
     - 	if (!tips.nr)
     - 		return 0;
     - 
     -+	if (contains) {
     -+		struct string_list_item *item;
     -+
     -+		/* clear out */
     -+		for_each_string_list_item(item, &tips)
     -+			item->util = NULL;
     -+
     -+		tips_reachable_from_base(base, &tips);
     -+
     -+		for_each_string_list_item(item, &tips) {
     -+			if (item->util)
     -+				printf("%s\n", item->string);
     -+		}
     -+
     -+		return 0;
     -+	}
     -+	/* else: not --contains, but normal ahead-behind counting. */
     -+
     - 	ALLOC_ARRAY(commits, tips.nr + 1);
     - 	ALLOC_ARRAY(counts, tips.nr);
     - 
     -
       ## commit-reach.c ##
      @@ commit-reach.c: void ahead_behind(struct commit **commits, size_t commits_nr,
       	clear_bit_arrays(&bit_arrays);
     @@ commit-reach.c: void ahead_behind(struct commit **commits, size_t commits_nr,
      +	return 0;
      +}
      +
     -+void tips_reachable_from_base(struct commit *base,
     -+			      struct string_list *tips)
     ++void tips_reachable_from_bases(struct commit_list *bases,
     ++			       struct commit **tips, size_t tips_nr,
     ++			       int mark)
      +{
     -+	unsigned int i;
     ++	size_t i;
      +	struct commit_and_index *commits;
      +	unsigned int min_generation_index = 0;
      +	timestamp_t min_generation;
      +	struct commit_list *stack = NULL;
      +
     -+	if (!base || !tips || !tips->nr)
     ++	if (!bases || !tips || !tips_nr)
      +		return;
      +
      +	/*
     -+	 * Do a depth-first search starting at 'base' to search for the
     ++	 * Do a depth-first search starting at 'bases' to search for the
      +	 * tips. Stop at the lowest (un-found) generation number. When
      +	 * finding the lowest commit, increase the minimum generation
      +	 * number to the next lowest (un-found) generation number.
      +	 */
      +
     -+	CALLOC_ARRAY(commits, tips->nr);
     ++	CALLOC_ARRAY(commits, tips_nr);
      +
     -+	for (i = 0; i < tips->nr; i++) {
     -+		commits[i].commit = lookup_commit_reference_by_name(tips->items[i].string);
     ++	for (i = 0; i < tips_nr; i++) {
     ++		commits[i].commit = tips[i];
      +		commits[i].index = i;
     -+		commits[i].generation = commit_graph_generation(commits[i].commit);
     ++		commits[i].generation = commit_graph_generation(tips[i]);
      +	}
      +
      +	/* Sort with generation number ascending. */
     -+	QSORT(commits, tips->nr, compare_commit_and_index_by_generation);
     ++	QSORT(commits, tips_nr, compare_commit_and_index_by_generation);
      +	min_generation = commits[0].generation;
      +
     -+	parse_commit(base);
     -+	commit_list_insert(base, &stack);
     ++	while (bases) {
     ++		parse_commit(bases->item);
     ++		commit_list_insert(bases->item, &stack);
     ++		bases = bases->next;
     ++	}
      +
      +	while (stack) {
      +		unsigned int j;
     @@ commit-reach.c: void ahead_behind(struct commit **commits, size_t commits_nr,
      +		struct commit *c = stack->item;
      +		timestamp_t c_gen = commit_graph_generation(c);
      +
     -+		/* Does it match any of our bases? */
     -+		for (j = min_generation_index; j < tips->nr; j++) {
     ++		/* Does it match any of our tips? */
     ++		for (j = min_generation_index; j < tips_nr; j++) {
      +			if (c_gen < commits[j].generation)
      +				break;
      +
      +			if (commits[j].commit == c) {
     -+				tips->items[commits[j].index].util = (void *)(uintptr_t)1;
     ++				tips[commits[j].index]->object.flags |= mark;
      +
      +				if (j == min_generation_index) {
      +					unsigned int k = j + 1;
     -+					while (k < tips->nr &&
     -+					       tips->items[commits[k].index].util)
     ++					while (k < tips_nr &&
     ++					       (tips[commits[k].index]->object.flags & mark))
      +						k++;
      +
      +					/* Terminate early if all found. */
     -+					if (k >= tips->nr)
     ++					if (k >= tips_nr)
      +						goto done;
      +
      +					min_generation_index = k;
     @@ commit-reach.h: struct ahead_behind_count {
       		  struct ahead_behind_count *counts, size_t counts_nr);
       
      +/*
     -+ * Populate the "util" of each string_list item with the boolean value
     -+ * corresponding to "can 'base' reach this tip?"
     ++ * For all tip commits, add 'mark' to their flags if and only if they
     ++ * are reachable from one of the commits in 'bases'.
      + */
     -+void tips_reachable_from_base(struct commit *base,
     -+			      struct string_list *tips);
     ++void tips_reachable_from_bases(struct commit_list *bases,
     ++			       struct commit **tips, size_t tips_nr,
     ++			       int mark);
      +
       #endif
      
     - ## t/perf/p1500-graph-walks.sh ##
     -@@ t/perf/p1500-graph-walks.sh: test_perf 'ahead-behind counts: git rev-list' '
     - 	done
     - '
     + ## ref-filter.c ##
     +@@ ref-filter.c: static void reach_filter(struct ref_array *array,
     + 			 struct commit_list *check_reachable,
     + 			 int include_reached)
     + {
     +-	struct rev_info revs;
     + 	int i, old_nr;
     + 	struct commit **to_clear;
     +-	struct commit_list *cr;
     + 
     + 	if (!check_reachable)
     + 		return;
     + 
     + 	CALLOC_ARRAY(to_clear, array->nr);
     +-
     +-	repo_init_revisions(the_repository, &revs, NULL);
     +-
     + 	for (i = 0; i < array->nr; i++) {
     + 		struct ref_array_item *item = array->items[i];
     +-		add_pending_object(&revs, &item->commit->object, item->refname);
     + 		to_clear[i] = item->commit;
     + 	}
     + 
     +-	for (cr = check_reachable; cr; cr = cr->next) {
     +-		struct commit *merge_commit = cr->item;
     +-		merge_commit->object.flags |= UNINTERESTING;
     +-		add_pending_object(&revs, &merge_commit->object, "");
     +-	}
     +-
     +-	revs.limited = 1;
     +-	if (prepare_revision_walk(&revs))
     +-		die(_("revision walk setup failed"));
     ++	tips_reachable_from_bases(check_reachable,
     ++				  to_clear, array->nr,
     ++				  UNINTERESTING);
     + 
     + 	old_nr = array->nr;
     + 	array->nr = 0;
     +@@ ref-filter.c: static void reach_filter(struct ref_array *array,
     + 		clear_commit_marks(merge_commit, ALL_REV_FLAGS);
     + 	}
     + 
     +-	release_revisions(&revs);
     + 	free(to_clear);
     + }
       
     -+test_perf 'ahead-behind counts: git ahead-behind --contains' '
     -+	git ahead-behind --contains --base=HEAD --stdin <refs
     -+'
     -+
     - test_done
      
     - ## t/t4218-ahead-behind.sh ##
     -@@ t/t4218-ahead-behind.sh: test_expect_success 'git ahead-behind with broken tip and --ignore-missing' '
     - 	test_must_be_empty out
     + ## t/perf/p1500-graph-walks.sh ##
     +@@ t/perf/p1500-graph-walks.sh: test_perf 'ahead-behind counts: git tag' '
     + 	xargs git tag -l --format="%(ahead-behind:HEAD)" <tags
       '
       
     -+test_expect_success 'git ahead-behind --contains with broken tip' '
     -+	test_must_fail git ahead-behind --contains \
     -+		--base=HEAD bogus 2>err &&
     -+	grep "could not resolve '\''bogus'\''" err
     +-test_perf 'ahead-behind counts: git rev-list' '
     +-	for r in $(cat refs)
     +-	do
     +-		git rev-list --count "HEAD..$r" || return 1
     +-	done
     ++test_perf 'contains: git for-each-ref --merged' '
     ++	git for-each-ref --merged=HEAD --stdin <refs
      +'
      +
     -+test_expect_success 'git ahead-behind --contains with broken tip and --ignore-missing' '
     -+	git ahead-behind --base=HEAD --contains \
     -+		--ignore-missing bogus 2>err >out &&
     -+	test_must_be_empty err &&
     -+	test_must_be_empty out
     ++test_perf 'contains: git branch --merged' '
     ++	xargs git branch --merged=HEAD <branches
      +'
      +
     - test_expect_success 'git ahead-behind without tips' '
     - 	git ahead-behind --base=HEAD 2>err &&
     - 	test_must_be_empty err
     -@@ t/t4218-ahead-behind.sh: test_expect_success 'git ahead-behind --base=merge' '
     - 	test_cmp expect actual
     ++test_perf 'contains: git tag --merged' '
     ++	xargs git tag --merged=HEAD <tags
       '
       
     -+test_expect_success 'git ahead-behind --contains --base=base' '
     -+	git ahead-behind --contains --base=base \
     -+		base left right merge >actual &&
     -+
     -+	cat >expect <<-EOF &&
     -+	base
     -+	EOF
     -+
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'git ahead-behind --contains --base=left' '
     -+	git ahead-behind --contains --base=left \
     -+		base left right merge >actual &&
     -+
     -+	cat >expect <<-EOF &&
     -+	base
     -+	left
     -+	EOF
     -+
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'git ahead-behind --contains --base=right' '
     -+	git ahead-behind --contains --base=right \
     -+		base left right merge >actual &&
     -+
     -+	cat >expect <<-EOF &&
     -+	base
     -+	right
     -+	EOF
     -+
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'git ahead-behind --contains --base=merge' '
     -+	git ahead-behind --contains --base=merge \
     -+		base left right merge >actual &&
     -+
     -+	cat >expect <<-EOF &&
     -+	base
     -+	left
     -+	right
     -+	merge
     -+	EOF
     -+
     -+	test_cmp expect actual
     -+'
     -+
       test_done
      
       ## t/t6600-test-reach.sh ##
     -@@ t/t6600-test-reach.sh: test_expect_success 'ahead-behind:none' '
     - 	run_all_modes git ahead-behind --base=commit-8-4 --stdin
     +@@ t/t6600-test-reach.sh: test_expect_success 'for-each-ref ahead-behind:none' '
     + 		--format="%(refname) %(ahead-behind:commit-8-4)" --stdin
       '
       
     -+test_expect_success 'ahead-behind--contains:all' '
     ++test_expect_success 'for-each-ref merged:linear' '
     ++	cat >input <<-\EOF &&
     ++	refs/heads/commit-1-1
     ++	refs/heads/commit-1-3
     ++	refs/heads/commit-1-5
     ++	refs/heads/commit-1-8
     ++	refs/heads/commit-2-1
     ++	refs/heads/commit-5-1
     ++	refs/heads/commit-9-1
     ++	EOF
     ++	cat >expect <<-\EOF &&
     ++	refs/heads/commit-1-1
     ++	refs/heads/commit-1-3
     ++	refs/heads/commit-1-5
     ++	refs/heads/commit-1-8
     ++	EOF
     ++	run_all_modes git for-each-ref --merged=commit-1-9 \
     ++		--format="%(refname)" --stdin
     ++'
     ++
     ++test_expect_success 'for-each-ref merged:all' '
      +	cat >input <<-\EOF &&
     -+	commit-1-1
     -+	commit-2-4
     -+	commit-4-2
     -+	commit-4-4
     ++	refs/heads/commit-1-1
     ++	refs/heads/commit-2-4
     ++	refs/heads/commit-4-2
     ++	refs/heads/commit-4-4
      +	EOF
      +	cat >expect <<-\EOF &&
     -+	commit-1-1
     -+	commit-2-4
     -+	commit-4-2
     -+	commit-4-4
     ++	refs/heads/commit-1-1
     ++	refs/heads/commit-2-4
     ++	refs/heads/commit-4-2
     ++	refs/heads/commit-4-4
      +	EOF
     -+	run_all_modes git ahead-behind --contains --base=commit-5-5 \
     -+		--stdin --use-bitmap-index
     ++	run_all_modes git for-each-ref --merged=commit-5-5 \
     ++		--format="%(refname)" --stdin
      +'
      +
     -+test_expect_success 'ahead-behind--contains:some' '
     ++test_expect_success 'for-each-ref ahead-behind:some' '
      +	cat >input <<-\EOF &&
     -+	commit-1-1
     -+	commit-5-3
     -+	commit-4-8
     -+	commit-9-9
     ++	refs/heads/commit-1-1
     ++	refs/heads/commit-5-3
     ++	refs/heads/commit-4-8
     ++	refs/heads/commit-9-9
      +	EOF
      +	cat >expect <<-\EOF &&
     -+	commit-1-1
     -+	commit-5-3
     ++	refs/heads/commit-1-1
     ++	refs/heads/commit-5-3
      +	EOF
     -+	run_all_modes git ahead-behind --contains --base=commit-9-6 \
     -+		--stdin --use-bitmap-index
     ++	run_all_modes git for-each-ref --merged=commit-9-6 \
     ++		--format="%(refname)" --stdin
      +'
      +
     -+test_expect_success 'ahead-behind--contains:some, reordered' '
     ++test_expect_success 'for-each-ref merged:some, multibase' '
      +	cat >input <<-\EOF &&
     -+	commit-4-8
     -+	commit-5-3
     -+	commit-9-9
     -+	commit-1-1
     ++	refs/heads/commit-1-1
     ++	refs/heads/commit-5-3
     ++	refs/heads/commit-7-8
     ++	refs/heads/commit-4-8
     ++	refs/heads/commit-9-9
      +	EOF
      +	cat >expect <<-\EOF &&
     -+	commit-5-3
     -+	commit-1-1
     ++	refs/heads/commit-1-1
     ++	refs/heads/commit-4-8
     ++	refs/heads/commit-5-3
      +	EOF
     -+	run_all_modes git ahead-behind --contains --base=commit-9-6 \
     -+		--stdin --use-bitmap-index
     ++	run_all_modes git for-each-ref \
     ++		--merged=commit-5-8 \
     ++		--merged=commit-8-5 \
     ++		--format="%(refname)" \
     ++		--stdin
      +'
      +
     -+test_expect_success 'ahead-behind--contains:none' '
     ++test_expect_success 'for-each-ref merged:none' '
      +	cat >input <<-\EOF &&
     -+	commit-7-5
     -+	commit-4-8
     -+	commit-9-9
     ++	refs/heads/commit-7-5
     ++	refs/heads/commit-4-8
     ++	refs/heads/commit-9-9
      +	EOF
      +	>expect &&
     -+	run_all_modes git ahead-behind --contains --base=commit-8-4 \
     -+		--stdin --use-bitmap-index
     ++	run_all_modes git for-each-ref --merged=commit-8-4 \
     ++		--format="%(refname)" --stdin
      +'
      +
       test_done

-- 
gitgitgadget
