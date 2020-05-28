Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E55C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 01:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E99520DD4
	for <git@archiver.kernel.org>; Thu, 28 May 2020 01:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="zq58bW0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgE1BNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 21:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE1BNp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 21:13:45 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C9CC05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 18:13:43 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id f89so12200835qva.3
        for <git@vger.kernel.org>; Wed, 27 May 2020 18:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQjfJvvjEKsVDAcS/kg+gMyIxUqf45ENaQFisrsBNrs=;
        b=zq58bW0WdZyi+XuxS+zb3bYjcTEmemLtyN8uujxD6D1C2woD+dhIWMTPk/N5IfOvkH
         /zv3oFZFsisIYFbP51ocNc9UaVwj///TuUJ4BhRBu1WCm9dSA0mZ3oSgCMZWG7cpecbK
         rcTAkR2jr/htyVcbegpcXX2pcdF/BMJ+8pDlh7R24+QI486v3z4x30CFWy1eTHAq6S4W
         NVJK0eGm/9jkYKYkTv879Jkpj14IN9wN7Wa3MYwNtebk0/kQEj+uc67MQP2AD2vLAw97
         wFM/H3TboitiKkdFxUxhifNU1ilMXE3xwkf6sMVpALtIZ3FuZB9rWqMhLPX2h2+TsPNn
         T8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQjfJvvjEKsVDAcS/kg+gMyIxUqf45ENaQFisrsBNrs=;
        b=nCx/nyb9+/gci1pQX3T/8hZp3/wcmACWatWRubDC03Zh9l2svYISpkieEz9wQLYciT
         tVZ7qZyUSYs+9PAvkQQvsGtV69UnWrzvIxFKNR+t1CLdoj79SJhZQ/aW+k7RhT16Bp4V
         V4sC6m88E62zaAx1bOkXECUYOep17kCn/ob/cUWJqv/Z0VGgT5TkbdxgjN0Dxf19Ey50
         1neIOURu0f/NdhbxveH1bxzSoTPyWZ8GpKwbhW8es4DBs9CtCCjTtJoXEQnvPrQ3/+0s
         bVpAke1BL7OXhyC6iKwzrrXS8YlBqt4rFMcXRqkWGNf+7JWQcLMdTZxmhSWVHUB0dSFU
         DSoQ==
X-Gm-Message-State: AOAM533qS2nzSXIrqfLj8LkL8ClkdilEugGbdi+RQoS2ZFeC0oCHK6Re
        NQ8/Dz8Fb20gTHFIF2cWwsPIM5nGtB8GjA==
X-Google-Smtp-Source: ABdhPJwZERr5CQZ5auK+MloO4+/lC/+109f4qN8Pfg8YTM51n6tmmUp6xrxaegTWUkFnWIFPdZI3Zg==
X-Received: by 2002:a0c:b21b:: with SMTP id x27mr783118qvd.177.1590628421072;
        Wed, 27 May 2020 18:13:41 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id a188sm3547872qkg.11.2020.05.27.18.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:13:40 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [PATCH v3 0/5] grep: honor sparse checkout and add option to ignore it
Date:   Wed, 27 May 2020 22:12:58 -0300
Message-Id: <cover.1590627264.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589058209.git.matheus.bernardino@usp.br>
References: <cover.1589058209.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on the discussions in [1]. The idea is to make
git-grep (and other commands, in the future) be able to restrict their
output to the sparsity patterns, when requested by the user.

[1]: https://lore.kernel.org/git/CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com/t/#u


Note on tests:

In the previous iteration, the setup test in t7817 (patch 4), used the
following command to set sparse-checkout up:

    git sparse-checkout set "/*" "!b" "!/*/" "/sub"

In this iteration, though, I had to change "/sub" to "sub" (which is not
the same, but should produce the same results in t1787). Using the
previous format, the test failed on Windows because git grep
--recurse-submodules did not recurse into "/sub" (a submodule). I used
[2] to investigate and noticed that sub indeed had the SKIP_WORKTREE bit
set on the repo created by the test on Windows. And the sparse-checkout
file contained the following:

/*
!b
!/*/
C:/Users/<path_to_the_Git_for_Windows_SDK_installation>/sub

I wasn't expecting the conversion from "/sub" to the path above. But I'm
not very familiar with the Git for Windows SDK, so is this conversion
expected? 

Furthermore, `pwd` would output:

    /usr/src/git/t/trash directory.t7817-grep-sparse-checkout

So I think that would explain why the converted path for the "/sub" rule
didn't match sub. Could this be a bug in `git sparse-checkout set`? Or
am I missing something?

[2]: https://github.com/sbp/gin


Main changes since v2:

Added patch 2.

Patch 3:
- Fix reading of extensions.worktreeConfig value in do_git_config_sequence(), to
  get the one from the given git_dir, not the_repository.
- Add --submodule option to test-config helper and regression test for the fixes
  in do_git_config_sequence().

Patch 4:
- Reword commit message to remove snippet about --untracked and --no-index
  respecting the sparsity patterns.
- Don't grep submodules that are excluded by the sparsity patterns.
- Add tests to ensure that submodules (and other paths) that are excluded by the
  sparsity patterns, but present in the working tree, are not grepped.
- Some minor variable renames in tests, for better readability.

Patch 5:
- Mention in sparse config docs that --[no-]restrict-to-sparse-paths won't
  affect writting commands.
- die() in grep when --[no-]restrict-to-sparse-paths is used with --no-index
  or --untracked, and add test for this behavior.
- Use test_when_finished and test_config, when possible, to avoid breaking next
  test cases on a test error.
- Adjust the behavior of --[no-]restrict-to-sparse-paths to follow the ideas
  proposed by Elijah in [3] and [4]. Also add more tests for the different
  cases where this option is relevant and improve docs at
  Documentation/config/sparse.txt.

[3]: https://lore.kernel.org/git/CABPp-BE6M9ATDYuQh8f_r3S00dM2Cv9vM3T5j5W_odbVzhC-5A@mail.gmail.com/
[4]: https://lore.kernel.org/git/CABPp-BGEPU49yRN2FRtwhYn6Uh+scGKEFYP4G2GH6=uBTN1SCw@mail.gmail.com/

CI: https://github.com/matheustavares/git/actions/runs/117388742

Matheus Tavares (5):
  doc: grep: unify info on configuration variables
  t/helper/test-config: return exit codes consistently
  config: correctly read worktree configs in submodules
  grep: honor sparse checkout patterns
  config: add setting to ignore sparsity patterns in some cmds

 Documentation/config.txt               |   2 +
 Documentation/config/grep.txt          |  10 +-
 Documentation/config/sparse.txt        |  24 ++
 Documentation/git-grep.txt             |  37 +--
 Documentation/git.txt                  |   4 +
 Makefile                               |   1 +
 builtin/grep.c                         | 134 ++++++++++-
 config.c                               |  21 +-
 contrib/completion/git-completion.bash |   2 +
 git.c                                  |   6 +
 sparse-checkout.c                      |  16 ++
 sparse-checkout.h                      |  11 +
 t/helper/test-config.c                 | 183 +++++++++------
 t/t2404-worktree-config.sh             |  16 ++
 t/t7011-skip-worktree-reading.sh       |   9 -
 t/t7817-grep-sparse-checkout.sh        | 300 +++++++++++++++++++++++++
 t/t9902-completion.sh                  |   4 +-
 17 files changed, 663 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/config/sparse.txt
 create mode 100644 sparse-checkout.c
 create mode 100644 sparse-checkout.h
 create mode 100755 t/t7817-grep-sparse-checkout.sh

Range-diff against v2:
1:  c344d22313 = 1:  63c195d737 doc: grep: unify info on configuration variables
2:  882310b69f < -:  ---------- config: load the correct config.worktree file
-:  ---------- > 2:  43402007ad t/helper/test-config: return exit codes consistently
-:  ---------- > 3:  448e0efffd config: correctly read worktree configs in submodules
3:  e00674c727 ! 4:  5ddac81818 grep: honor sparse checkout patterns
    @@ Commit message
         git-grep currently ignores the sparsity patterns and report all matches
         found outside this subset, which kind of goes in the opposite direction.
         Let's fix that, making it honor the sparsity boundaries for every
    -    grepping case:
    +    grepping case where this is relevant:
     
         - git grep in worktree
         - git grep --cached
         - git grep $REVISION
    -    - git grep --untracked and git grep --no-index (which already respect
    -      sparse checkout boundaries)
     
    -    This is also what some users reported[1] they would want as the default
    -    behavior.
    +    For the worktree case, we will not grep paths that have the
    +    SKIP_WORKTREE bit set, even if they are present for some reason (e.g.
    +    manually created after `git sparse-checkout init`). But the next patch
    +    will add an option to do so. (See 'Note' below.)
     
    -    Note: for `git grep $REVISION`, we will choose to honor the sparsity
    -    patterns only when $REVISION is a commit-ish object. The reason is that,
    -    for a tree, we don't know whether it represents the root of a
    -    repository or a subtree. So we wouldn't be able to correctly match it
    -    against the sparsity patterns. E.g. suppose we have a repository with
    -    these two sparsity rules: "/*" and "!/a"; and the following structure:
    +    For `git grep $REVISION`, we will choose to honor the sparsity patterns
    +    only when $REVISION is a commit-ish object. The reason is that, for a
    +    tree, we don't know whether it represents the root of a repository or a
    +    subtree. So we wouldn't be able to correctly match it against the
    +    sparsity patterns. E.g. suppose we have a repository with these two
    +    sparsity rules: "/*" and "!/a"; and the following structure:
     
         /
         | - a (file)
    @@ Commit message
         therefore it would wrongly match the pattern "!/a". Furthermore, for a
         search in a blob object, we wouldn't even have a path to check the
         patterns against. So, let's ignore the sparsity patterns when grepping
    -    non-commit-ish objects (tags to commits should be fine).
    +    non-commit-ish objects.
     
    -    Finally, the old behavior may still be desirable for some use cases. So
    -    the next patch will add an option to allow restoring it when needed.
    +    Note: The behavior introduced in this patch is what some users have
    +    reported[1] that they would like by default. But the old behavior is
    +    still desirable for some use cases. Therefore, the next patch will add
    +    an option to allow restoring it when needed.
     
         [1]: https://lore.kernel.org/git/CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com/
     
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
      	for (nr = 0; nr < repo->index->cache_nr; nr++) {
      		const struct cache_entry *ce = repo->index->cache[nr];
     +
    -+		if (ce_skip_worktree(ce) && !S_ISGITLINK(ce->ce_mode))
    ++		if (ce_skip_worktree(ce))
     +			continue;
     +
      		strbuf_setlen(&name, name_base_len);
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
     +			      enum pattern_match_result *match)
     +{
     +	int dtype = DT_UNKNOWN;
    -+
    -+	if (S_ISGITLINK(entry_mode))
    -+		return 1;
    ++	int is_dir = S_ISDIR(entry_mode);
     +
     +	if (parent_match == MATCHED_RECURSIVE) {
     +		*match = parent_match;
     +		return 1;
     +	}
     +
    -+	if (S_ISDIR(entry_mode) && !is_dir_sep(path->buf[path->len - 1]))
    ++	if (is_dir && !is_dir_sep(path->buf[path->len - 1]))
     +		strbuf_addch(path, '/');
     +
     +	*match = path_matches_pattern_list(path->buf, path->len,
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
     +	if (*match == UNDECIDED)
     +		*match = parent_match;
     +
    -+	if (S_ISDIR(entry_mode))
    ++	if (is_dir)
     +		strbuf_trim_trailing_dir_sep(path);
     +
    -+	if (*match == NOT_MATCHED && (S_ISREG(entry_mode) ||
    -+	    (S_ISDIR(entry_mode) && sparsity->use_cone_patterns)))
    -+		return 0;
    ++	if (*match == NOT_MATCHED &&
    ++		(!is_dir || (is_dir && sparsity->use_cone_patterns)))
    ++	     return 0;
     +
     +	return 1;
     +}
    @@ t/t7817-grep-sparse-checkout.sh (new)
     +|-- b
     +|-- dir
     +|   `-- c
    -+`-- sub
    -+    |-- A
    -+    |   `-- a
    -+    `-- B
    -+	`-- b
    -+
    -+Where . has non-cone mode sparsity patterns and sub is a submodule with cone
    -+mode sparsity patterns. The resulting sparse-checkout should leave the following
    -+structure:
    ++|-- sub
    ++|   |-- A
    ++|   |   `-- a
    ++|   `-- B
    ++|       `-- b
    ++`-- sub2
    ++    `-- a
    ++
    ++Where . has non-cone mode sparsity patterns, sub is a submodule with cone mode
    ++sparsity patterns and sub2 is a submodule that is excluded by the superproject
    ++sparsity patterns. The resulting sparse checkout should leave the following
    ++structure on the working tree:
     +
     +.
     +|-- a
    -+`-- sub
    -+    `-- B
    -+	`-- b
    ++|-- sub
    ++|   `-- B
    ++|       `-- b
    ++`-- sub2
    ++    `-- a
    ++
    ++But note that sub2 should have the SKIP_WORKTREE bit set.
     +'
     +
     +. ./test-lib.sh
    @@ t/t7817-grep-sparse-checkout.sh (new)
     +		git sparse-checkout set B
     +	) &&
     +
    ++	git init sub2 &&
    ++	(
    ++		cd sub2 &&
    ++		echo "text" >a &&
    ++		git add a &&
    ++		git commit -m sub2
    ++	) &&
    ++
     +	git submodule add ./sub &&
    ++	git submodule add ./sub2 &&
     +	git add a b dir &&
     +	git commit -m super &&
     +	git sparse-checkout init --no-cone &&
    -+	git sparse-checkout set "/*" "!b" "!/*/" &&
    ++	git sparse-checkout set "/*" "!b" "!/*/" "sub" &&
     +
    -+	git tag -am t-commit t-commit HEAD &&
    ++	git tag -am tag-to-commit tag-to-commit HEAD &&
     +	tree=$(git rev-parse HEAD^{tree}) &&
    -+	git tag -am t-tree t-tree $tree &&
    ++	git tag -am tag-to-tree tag-to-tree $tree &&
     +
     +	test_path_is_missing b &&
     +	test_path_is_missing dir &&
     +	test_path_is_missing sub/A &&
     +	test_path_is_file a &&
    -+	test_path_is_file sub/B/b
    ++	test_path_is_file sub/B/b &&
    ++	test_path_is_file sub2/a
     +'
     +
    ++# The test bellow checks a special case: the sparsity patterns exclude '/b'
    ++# and sparse checkout is enable, but the path exists on the working tree (e.g.
    ++# manually created after `git sparse-checkout init`). In this case, grep should
    ++# skip it.
     +test_expect_success 'grep in working tree should honor sparse checkout' '
     +	cat >expect <<-EOF &&
     +	a:text
     +	EOF
    ++	echo "new-text" >b &&
    ++	test_when_finished "rm b" &&
     +	git grep "text" >actual &&
     +	test_cmp expect actual
     +'
    @@ t/t7817-grep-sparse-checkout.sh (new)
     +	cat >expect_commit <<-EOF &&
     +	$commit:a:text
     +	EOF
    -+	cat >expect_t-commit <<-EOF &&
    -+	t-commit:a:text
    ++	cat >expect_tag-to-commit <<-EOF &&
    ++	tag-to-commit:a:text
     +	EOF
     +	git grep "text" $commit >actual_commit &&
     +	test_cmp expect_commit actual_commit &&
    -+	git grep "text" t-commit >actual_t-commit &&
    -+	test_cmp expect_t-commit actual_t-commit
    ++	git grep "text" tag-to-commit >actual_tag-to-commit &&
    ++	test_cmp expect_tag-to-commit actual_tag-to-commit
     +'
     +
     +test_expect_success 'grep <tree-ish> should ignore sparsity patterns' '
    @@ t/t7817-grep-sparse-checkout.sh (new)
     +	$tree:b:text
     +	$tree:dir/c:text
     +	EOF
    -+	cat >expect_t-tree <<-EOF &&
    -+	t-tree:a:text
    -+	t-tree:b:text
    -+	t-tree:dir/c:text
    ++	cat >expect_tag-to-tree <<-EOF &&
    ++	tag-to-tree:a:text
    ++	tag-to-tree:b:text
    ++	tag-to-tree:dir/c:text
     +	EOF
     +	git grep "text" $tree >actual_tree &&
     +	test_cmp expect_tree actual_tree &&
    -+	git grep "text" t-tree >actual_t-tree &&
    -+	test_cmp expect_t-tree actual_t-tree
    ++	git grep "text" tag-to-tree >actual_tag-to-tree &&
    ++	test_cmp expect_tag-to-tree actual_tag-to-tree
    ++'
    ++
    ++# Note that sub2/ is present in the worktree but it is excluded by the sparsity
    ++# patterns, so grep should not recurse into it.
    ++test_expect_success 'grep --recurse-submodules should honor sparse checkout in submodule' '
    ++	cat >expect <<-EOF &&
    ++	a:text
    ++	sub/B/b:text
    ++	EOF
    ++	git grep --recurse-submodules "text" >actual &&
    ++	test_cmp expect actual
     +'
     +
     +test_expect_success 'grep --recurse-submodules --cached should honor sparse checkout in submodule' '
    @@ t/t7817-grep-sparse-checkout.sh (new)
     +	$commit:a:text
     +	$commit:sub/B/b:text
     +	EOF
    -+	cat >expect_t-commit <<-EOF &&
    -+	t-commit:a:text
    -+	t-commit:sub/B/b:text
    ++	cat >expect_tag-to-commit <<-EOF &&
    ++	tag-to-commit:a:text
    ++	tag-to-commit:sub/B/b:text
     +	EOF
     +	git grep --recurse-submodules "text" $commit >actual_commit &&
     +	test_cmp expect_commit actual_commit &&
    -+	git grep --recurse-submodules "text" t-commit >actual_t-commit &&
    -+	test_cmp expect_t-commit actual_t-commit
    ++	git grep --recurse-submodules "text" tag-to-commit >actual_tag-to-commit &&
    ++	test_cmp expect_tag-to-commit actual_tag-to-commit
     +'
     +
     +test_done
4:  3e9e906249 ! 5:  748b1e955c config: add setting to ignore sparsity patterns in some cmds
    @@ Commit message
         subset of files in which they are interested; and allow some commands to
         possibly perform better, by not considering uninteresting paths. For
         this reason, we taught grep to honor the sparsity patterns, in the
    -    previous commit. But, on the other hand, allowing grep and the other
    +    previous patch. But, on the other hand, allowing grep and the other
         commands mentioned to optionally ignore the patterns also make for some
         interesting use cases. E.g. using grep to search for a function
    -    definition that resides outside the sparse checkout.
    +    documentation that resides outside the sparse checkout.
     
         In any case, there is no current way for users to configure the behavior
         they want for these commands. Aiming to provide this flexibility, let's
    @@ Documentation/config/sparse.txt (new)
     ++
     +When this option is true (default), some git commands may limit their behavior
     +to the paths specified by the sparsity patterns, or to the intersection of
    -+those paths and any (like `*.c) that the user might also specify on the command
    -+line. When false, the affected commands will work on full trees, ignoring the
    -+sparsity patterns. For now, only git-grep honors this setting. In this command,
    -+the restriction becomes relevant in one of these three cases: with --cached;
    -+when a commit-ish is given; when searching a working tree that contains paths
    -+previously excluded by the sparsity patterns.
    ++those paths and any (like `*.c`) that the user might also specify on the
    ++command line. When false, the affected commands will work on full trees,
    ++ignoring the sparsity patterns. For now, only git-grep honors this setting. In
    ++this command, the restriction takes effect in three cases: with --cached; when
    ++a commit-ish is given; when searching a working tree where some paths excluded
    ++by the sparsity patterns are present (e.g. manually created paths or not
    ++removed submodules).
     ++
     +Note: commands which export, integrity check, or create history will always
     +operate on full trees (e.g. fast-export, format-patch, fsck, commit, etc.),
    -+unaffected by any sparsity patterns.
    ++unaffected by any sparsity patterns. Also, writting commands such as
    ++sparse-checkout and read-tree will not be affected by this configuration.
     
      ## Documentation/git-grep.txt ##
     @@ Documentation/git-grep.txt: characters.  An empty string as search expression matches all lines.
    @@ builtin/grep.c: static int grep_cache(struct grep_opt *opt,
      	for (nr = 0; nr < repo->index->cache_nr; nr++) {
      		const struct cache_entry *ce = repo->index->cache[nr];
      
    --		if (ce_skip_worktree(ce) && !S_ISGITLINK(ce->ce_mode))
    -+		if (sparse_paths_only && ce_skip_worktree(ce) &&
    -+		    !S_ISGITLINK(ce->ce_mode))
    +-		if (ce_skip_worktree(ce))
    ++		if (sparse_paths_only && ce_skip_worktree(ce))
      			continue;
      
      		strbuf_setlen(&name, name_base_len);
    @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
      		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
     +
     +		if (opt_restrict_to_sparse_paths >= 0) {
    -+			warning(_("--[no-]restrict-to-sparse-paths is ignored"
    -+				  " with --no-index or --untracked"));
    ++			die(_("--[no-]restrict-to-sparse-paths is incompatible"
    ++				  " with --no-index and --untracked"));
     +		}
     +
      		hit = grep_directory(&opt, &pathspec, use_exclude, use_index);
    @@ sparse-checkout.h (new)
     
      ## t/t7817-grep-sparse-checkout.sh ##
     @@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'setup' '
    - 	test_path_is_file sub/B/b
    + 	test_path_is_file sub2/a
      '
      
    +-# The test bellow checks a special case: the sparsity patterns exclude '/b'
     +# The two tests bellow check a special case: the sparsity patterns exclude '/b'
    -+# and sparse checkout is enable, but the path exists on the working tree (e.g.
    -+# manually created after `git sparse-checkout init`). In this case, grep should
    -+# honor --restrict-to-sparse-paths.
    + # and sparse checkout is enable, but the path exists on the working tree (e.g.
    + # manually created after `git sparse-checkout init`). In this case, grep should
    +-# skip it.
    ++# skip the file by default, but not with --no-restrict-to-sparse-paths.
      test_expect_success 'grep in working tree should honor sparse checkout' '
      	cat >expect <<-EOF &&
      	a:text
    - 	EOF
    -+	echo newtext >b &&
    +@@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'grep in working tree should honor sparse checkout' '
      	git grep "text" >actual &&
    --	test_cmp expect actual
    -+	test_cmp expect actual &&
    -+	rm b
    -+'
    + 	test_cmp expect actual
    + '
     +test_expect_success 'grep w/ --no-restrict-to-sparse-paths for sparsely excluded but present paths' '
     +	cat >expect <<-EOF &&
     +	a:text
    -+	b:newtext
    ++	b:new-text
     +	EOF
    -+	echo newtext >b &&
    ++	echo "new-text" >b &&
    ++	test_when_finished "rm b" &&
     +	git --no-restrict-to-sparse-paths grep "text" >actual &&
    -+	test_cmp expect actual &&
    -+	rm b
    - '
    ++	test_cmp expect actual
    ++'
      
      test_expect_success 'grep --cached should honor sparse checkout' '
    + 	cat >expect <<-EOF &&
    +@@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'grep <tree-ish> should ignore sparsity patterns' '
    + '
    + 
    + # Note that sub2/ is present in the worktree but it is excluded by the sparsity
    +-# patterns, so grep should not recurse into it.
    ++# patterns, so grep should only recurse into it with --no-restrict-to-sparse-paths.
    + test_expect_success 'grep --recurse-submodules should honor sparse checkout in submodule' '
    + 	cat >expect <<-EOF &&
    + 	a:text
    +@@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'grep --recurse-submodules should honor sparse checkout in s
    + 	git grep --recurse-submodules "text" >actual &&
    + 	test_cmp expect actual
    + '
    ++test_expect_success 'grep --recurse-submodules should search in excluded submodules w/ --no-restrict-to-sparse-paths' '
    ++	cat >expect <<-EOF &&
    ++	a:text
    ++	sub/B/b:text
    ++	sub2/a:text
    ++	EOF
    ++	git --no-restrict-to-sparse-paths grep --recurse-submodules "text" >actual &&
    ++	test_cmp expect actual
    ++'
    + 
    + test_expect_success 'grep --recurse-submodules --cached should honor sparse checkout in submodule' '
    + 	cat >expect <<-EOF &&
     @@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'grep --recurse-submodules <commit-ish> should honor sparse
    - 	test_cmp expect_t-commit actual_t-commit
    + 	test_cmp expect_tag-to-commit actual_tag-to-commit
      '
      
     +for cmd in 'git --no-restrict-to-sparse-paths grep' \
    @@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'grep --recurse-submodules
     +		$commit:b:text
     +		$commit:dir/c:text
     +		EOF
    -+		cat >expect_t-commit <<-EOF &&
    -+		t-commit:a:text
    -+		t-commit:b:text
    -+		t-commit:dir/c:text
    ++		cat >expect_tag-to-commit <<-EOF &&
    ++		tag-to-commit:a:text
    ++		tag-to-commit:b:text
    ++		tag-to-commit:dir/c:text
     +		EOF
     +		$cmd "text" $commit >actual_commit &&
     +		test_cmp expect_commit actual_commit &&
    -+		$cmd "text" t-commit >actual_t-commit &&
    -+		test_cmp expect_t-commit actual_t-commit
    ++		$cmd "text" tag-to-commit >actual_tag-to-commit &&
    ++		test_cmp expect_tag-to-commit actual_tag-to-commit
     +	'
     +done
     +
    ++test_expect_success 'grep --recurse-submodules --cached \w --no-restrict-to-sparse-paths' '
    ++	cat >expect <<-EOF &&
    ++	a:text
    ++	b:text
    ++	dir/c:text
    ++	sub/A/a:text
    ++	sub/B/b:text
    ++	sub2/a:text
    ++	EOF
    ++	git --no-restrict-to-sparse-paths grep --recurse-submodules --cached \
    ++		"text" >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'grep --recurse-submodules <commit-ish> \w --no-restrict-to-sparse-paths' '
    ++	commit=$(git rev-parse HEAD) &&
    ++	cat >expect_commit <<-EOF &&
    ++	$commit:a:text
    ++	$commit:b:text
    ++	$commit:dir/c:text
    ++	$commit:sub/A/a:text
    ++	$commit:sub/B/b:text
    ++	$commit:sub2/a:text
    ++	EOF
    ++	cat >expect_tag-to-commit <<-EOF &&
    ++	tag-to-commit:a:text
    ++	tag-to-commit:b:text
    ++	tag-to-commit:dir/c:text
    ++	tag-to-commit:sub/A/a:text
    ++	tag-to-commit:sub/B/b:text
    ++	tag-to-commit:sub2/a:text
    ++	EOF
    ++	git --no-restrict-to-sparse-paths grep --recurse-submodules "text" \
    ++		$commit >actual_commit &&
    ++	test_cmp expect_commit actual_commit &&
    ++	git --no-restrict-to-sparse-paths grep --recurse-submodules "text" \
    ++		tag-to-commit >actual_tag-to-commit &&
    ++	test_cmp expect_tag-to-commit actual_tag-to-commit
    ++'
    ++
     +test_expect_success 'should respect the sparse.restrictCmds values from submodules' '
     +	cat >expect <<-EOF &&
     +	a:text
     +	sub/A/a:text
     +	sub/B/b:text
     +	EOF
    -+	git -C sub config sparse.restrictCmds false &&
    ++	test_config -C sub sparse.restrictCmds false &&
     +	git grep --cached --recurse-submodules "text" >actual &&
    -+	test_cmp expect actual &&
    -+	git -C sub config --unset sparse.restrictCmds
    ++	test_cmp expect actual
     +'
     +
     +test_expect_success 'should propagate --[no]-restrict-to-sparse-paths to submodules' '
    @@ t/t7817-grep-sparse-checkout.sh: test_expect_success 'grep --recurse-submodules
     +	dir/c:text
     +	sub/A/a:text
     +	sub/B/b:text
    ++	sub2/a:text
     +	EOF
    -+	git -C sub config sparse.restrictCmds true &&
    ++	test_config -C sub sparse.restrictCmds true &&
     +	git --no-restrict-to-sparse-paths grep --cached --recurse-submodules "text" >actual &&
    -+	test_cmp expect actual &&
    -+	git -C sub config --unset sparse.restrictCmds
    ++	test_cmp expect actual
     +'
    ++
    ++for opt in '--untracked' '--no-index'
    ++do
    ++	test_expect_success "--[no]-restrict-to-sparse-paths and $opt are incompatible" "
    ++		test_must_fail git --restrict-to-sparse-paths grep $opt . 2>actual &&
    ++		test_i18ngrep 'restrict-to-sparse-paths is incompatible with' actual
    ++	"
    ++done
     +
      test_done
     
-- 
2.26.2

