Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF8FC77B7A
	for <git@archiver.kernel.org>; Fri, 26 May 2023 01:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbjEZBdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 21:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbjEZBdH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 21:33:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AB31A4
        for <git@vger.kernel.org>; Thu, 25 May 2023 18:33:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so1378635e9.1
        for <git@vger.kernel.org>; Thu, 25 May 2023 18:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685064783; x=1687656783;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEp+Uenlw4iytpVydSAJBRsczeOTUc9BqMl21H9GHto=;
        b=MIMQ83GD2H8soo20cU97rvxGoEJ3DgnDciG7lc3RXbyDFyKr+Y1ibcjMWBDQ47axHk
         0krTJR4qWTrFJuJhxYC/uR7+pjaoaBM44VvptFVPpKTzhB6xfTFH7jMovWiBwybRYwhr
         B09539v/D1Vjl/9IfYlRL8fHMpp4aAYcDv1O2eP9lJvVWm5wUzVFgE6COKAbv9J7k42K
         KTkq1c7QsTxRKo1qebMpWYP0nEfJ2uFmbVQz5CuqJbAAHvXtx35Zy36G2d8uRREEACG3
         2b9GNFdD6QbGiXJ88SQ0HMs2ZIcfsWwenMdnzr7CZSET98nzVX2ytvx5cKlyAGUY9b47
         j2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685064783; x=1687656783;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEp+Uenlw4iytpVydSAJBRsczeOTUc9BqMl21H9GHto=;
        b=CosDR3+QJ7Qv2E8VArWoTLqudlbMLxbTZVlCMsCUxiRKasXkPjbT8evsc3rNX4FOs6
         spT3L35YLCa3kqVmldFor4Mkd3OthK8wLQz2upa8ahX2HJq3Z0HyxmYaF4Ok1qNT93x0
         tKUUmXSdhptL/J/Q+l/jmjwi7fGW42zv2x2RJr9Ibd+Zp7SbWhjIZZ1eqFHfAPxzLLbJ
         e1PP/OjnyMqZfng3Pi3f/RYERY5xE/jnMb8GP94ceKdpHOrq4NDNYmyZj1EXYkgGrxMg
         5cEkalTBgwRFTuXjieCoNnlNreXBEmvwTAKkUCjD3BseTRNiWzKcXZh6cPcW1ahPTY/H
         cZrw==
X-Gm-Message-State: AC+VfDwTYt9H/b6y73Z2MyKiqLQZfcvxJC+YL6itDUjeFicxlQLcVXwB
        mNvyJzgOR/sNE8DwHRCPIUKu5CqabWY=
X-Google-Smtp-Source: ACHHUZ77/+Vo8//Q+Nqe2Tqj7yb4/b+6xwHfgCXCxjo0GzlZ2i382fsIrAssGR5qVCUse3eeAu1hkQ==
X-Received: by 2002:a5d:6809:0:b0:2d8:47c7:7b52 with SMTP id w9-20020a5d6809000000b002d847c77b52mr108355wru.9.1685064782680;
        Thu, 25 May 2023 18:33:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b003eddc6aa5fasm7151775wmd.39.2023.05.25.18.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:33:02 -0700 (PDT)
Message-Id: <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
In-Reply-To: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 May 2023 01:32:57 +0000
Subject: [PATCH v2 0/3] Fix behavior of worktree config in submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, chooglen@google.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About a year ago, discussion on the sparse index integration of 'git grep'
surfaced larger incompatibilities between sparse-checkout and submodules
[1]. This series fixes one of the underlying issues to that incompatibility,
which is that the worktree config of the submodule (where
'core.sparseCheckout', 'core.sparseCheckoutCone', and 'index.sparse' are
set) is not used when operating on the submodule from its super project
(e.g., in a command with '--recurse-submodules').

The outcome of this series is that 'extensions.worktreeConfig' and the
contents of the repository's worktree config are read and applied to (and
only to) the relevant repo when working in a super project/submodule setup.
This alone doesn't fix sparse-checkout/submodule interoperability; the
additional changes needed for that will be submitted in a later series. I'm
also hoping this will help (or at least not hurt) the work to avoid use of
global state in config parsing [2].


Changes since V1
================

 * In 't3007', replaced manual 'git config'/'test_when_finished "git config
   --unset"' pairs with 'test_config' helper. Updated 'test_config' to
   handle the '--worktree' option.
 * Updated commit messages & test comments to better explain the purpose and
   more subtle functionality details to the new tests
 * Added a commit to move 'struct repository' out of 'git_config_source',
   rather than creating a dummy 'config_source' just to hold a repository
   instance.
 * Changed the config setting in the new tests from 'feature.experimental'
   to 'index.sparse' to tie these changes to their intended use case.
 * "super project" -> "superproject"

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/093827ae-41ef-5f7c-7829-647536ce1305@github.com/
[2]
https://lore.kernel.org/git/pull.1497.git.git.1682104398.gitgitgadget@gmail.com/

Victoria Dye (3):
  config: use gitdir to get worktree config
  config: pass 'repo' directly to 'config_with_options()'
  repository: move 'repository_format_worktree_config' to repo scope

 builtin/config.c                       | 17 +++++----
 builtin/worktree.c                     |  2 +-
 config.c                               | 49 ++++++++++++++++----------
 config.h                               |  4 +--
 environment.c                          |  1 -
 environment.h                          |  1 -
 repository.c                           |  1 +
 repository.h                           |  1 +
 setup.c                                | 10 ++++--
 submodule-config.c                     |  3 +-
 t/t3007-ls-files-recurse-submodules.sh | 33 +++++++++++++++++
 t/test-lib-functions.sh                | 13 +++++--
 worktree.c                             |  4 +--
 13 files changed, 102 insertions(+), 37 deletions(-)


base-commit: 4a714b37029a4b63dbd22f7d7ed81f7a0d693680
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1536%2Fvdye%2Fvdye%2Fsubmodule-worktree-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1536/vdye/vdye/submodule-worktree-config-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1536

Range-diff vs v1:

 1:  aead2fe1ce1 ! 1:  fb597cdfeb0 config: use gitdir to get worktree config
     @@ Commit message
          The worktree config is loaded from the path returned by
          'git_pathdup("config.worktree")', the 'config.worktree' relative to the
          gitdir of 'the_repository'. If loading the config for a submodule, this path
     -    is incorrect, since 'the_repository' is the super project. Conversely,
     -    'opts->git_dir' is the gitdir of the submodule being configured, so the
     -    config file in that location should be read instead.
     +    is incorrect, since 'the_repository' is the superproject. 'opts->git_dir' is
     +    the gitdir of the submodule being configured, so the config file in that
     +    location should be read instead.
      
          To ensure the use of 'opts->git_dir' is safe, require that 'opts->git_dir'
          is set if-and-only-if 'opts->commondir' is set (rather than "only-if" as it
          is now). In all current usage of 'config_options', these values are set
          together, so the stricter check does not change any behavior.
      
     -    Finally, add tests to 't3007-ls-files-recurse-submodules.sh' to demonstrate
     -    the corrected config loading behavior. Note that behavior still isn't ideal
     -    because 'extensions.worktreeConfig' in the super project controls whether or
     -    not the worktree config is used in the submodule. This will be fixed in a
     -    later patch.
     +    Finally, add tests to 't3007-ls-files-recurse-submodules.sh' to verify the
     +    corrected config is loaded. Use 'ls-files' to test this because, unlike some
     +    other '--recurse-submodules' commands, 'ls-files' parses the config of the
     +    submodule in the same process as the superproject (via 'show_submodule()' ->
     +    'repo_read_index()' -> 'prepare_repo_settings()'). As a result,
     +    'the_repository' points to the config of the superproject but the
     +    commondir/gitdir in the config sequence will be that of the submodule,
     +    providing the exact scenario needed to verify this patch.
     +
     +    The first test ('--recurse-submodules parses submodule repo config') checks
     +    that the submodule's *repo* config is read when running 'ls-files' on the
     +    superproject; this confirms already-working behavior, serving as a reference
     +    for how worktree config parsing should behave. The second test
     +    ('--recurse-submodules parses submodule worktree config') tests the same
     +    scenario as the previous but instead using the *worktree* config,
     +    demonstrating the corrected behavior. The 'test_config' helper is extended
     +    for this case so that it properly applies the '--worktree' option to the
     +    configure/unconfigure operations it performs.
     +
     +    Note that, although the submodule worktree config is now parsed instead of
     +    the superproject's, 'extensions.worktreeConfig' in the superproject still
     +    controls whether or not the worktree config is enabled at all in the
     +    submodule. This will be fixed in a later patch.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     @@ t/t3007-ls-files-recurse-submodules.sh: test_expect_success '--recurse-submodule
       '
       
      +test_expect_success '--recurse-submodules parses submodule repo config' '
     -+	test_when_finished "git -C submodule config --unset feature.experimental" &&
     -+	git -C submodule config feature.experimental "invalid non-boolean value" &&
     ++	test_config -C submodule index.sparse "invalid non-boolean value" &&
      +	test_must_fail git ls-files --recurse-submodules 2>err &&
      +	grep "bad boolean config value" err
      +'
      +
      +test_expect_success '--recurse-submodules parses submodule worktree config' '
     -+	test_when_finished "git -C submodule config --unset extensions.worktreeConfig" &&
     -+	test_when_finished "git -C submodule config --worktree --unset feature.experimental" &&
     -+	test_when_finished "git config --unset extensions.worktreeConfig" &&
     ++	test_config -C submodule extensions.worktreeConfig true &&
     ++	test_config -C submodule --worktree index.sparse "invalid non-boolean value" &&
      +
     -+	git -C submodule config extensions.worktreeConfig true &&
     -+	git -C submodule config --worktree feature.experimental "invalid non-boolean value" &&
     -+
     -+	# NEEDSWORK: the extensions.worktreeConfig is set globally based on super
     -+	# project, so we need to enable it in the super project.
     -+	git config extensions.worktreeConfig true &&
     ++	# NEEDSWORK: the extensions.worktreeConfig is set globally based on
     ++	# superproject, so we need to enable it in the superproject.
     ++	test_config extensions.worktreeConfig true &&
      +
      +	test_must_fail git ls-files --recurse-submodules 2>err &&
      +	grep "bad boolean config value" err
     @@ t/t3007-ls-files-recurse-submodules.sh: test_expect_success '--recurse-submodule
       test_incompatible_with_recurse_submodules () {
       	test_expect_success "--recurse-submodules and $1 are incompatible" "
       		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
     +
     + ## t/test-lib-functions.sh ##
     +@@ t/test-lib-functions.sh: test_config () {
     + 		config_dir=$1
     + 		shift
     + 	fi
     +-	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} '$1'" &&
     +-	git ${config_dir:+-C "$config_dir"} config "$@"
     ++
     ++	# If --worktree is provided, use it to configure/unconfigure
     ++	is_worktree=
     ++	if test "$1" = --worktree
     ++	then
     ++		is_worktree=1
     ++		shift
     ++	fi
     ++
     ++	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} ${is_worktree:+--worktree} '$1'" &&
     ++	git ${config_dir:+-C "$config_dir"} config ${is_worktree:+--worktree} "$@"
     + }
     + 
     + test_config_global () {
 -:  ----------- > 2:  26a36423a8a config: pass 'repo' directly to 'config_with_options()'
 2:  5ed9100a770 ! 3:  506a2cf8c73 repository: move 'repository_format_worktree_config' to repo scope
     @@ Commit message
          Move 'repository_format_worktree_config' out of the global scope and into
          the 'repository' struct. This change is similar to how
          'repository_format_partial_clone' was moved in ebaf3bcf1ae (repository: move
     -    global r_f_p_c to repo struct, 2021-06-17), adding to the 'repository'
     +    global r_f_p_c to repo struct, 2021-06-17), adding it to the 'repository'
          struct and updating 'setup.c' & 'repository.c' functions to assign the value
     -    appropriately. In addition, update usage of the setting to reference the
     -    relevant context's repo or, as a fallback, 'the_repository'.
     +    appropriately.
      
     -    The primary goal of this change is to be able to load worktree config for a
     -    submodule depending on whether that submodule - not the super project - has
     +    The primary goal of this change is to be able to load the worktree config of
     +    a submodule depending on whether that submodule - not its superproject - has
          'extensions.worktreeConfig' enabled. To ensure 'do_git_config_sequence()'
     -    has access to the newly repo-scoped configuration:
     -
     -    - update 'repo_read_config()' to create a 'config_source' to hold the
     -      repo instance
     -    - add a 'repo' argument to 'do_git_config_sequence()'
     -    - update 'config_with_options' to call 'do_git_config_sequence()' with
     -      'config_source.repo', or 'the_repository' as a fallback
     +    has access to the newly repo-scoped configuration, add a 'struct repository'
     +    argument to 'do_git_config_sequence()' and pass it the 'repo' value from
     +    'config_with_options()'.
      
          Finally, add/update tests in 't3007-ls-files-recurse-submodules.sh' to
     -    verify 'extensions.worktreeConfig' is read an used independently by super
     -    projects and submodules.
     +    verify 'extensions.worktreeConfig' is read an used independently by
     +    superprojects and submodules.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     @@ config.c: static int do_git_config_sequence(struct config_reader *reader,
       	    !access_or_die(worktree_config, R_OK, 0)) {
       		ret += git_config_from_file(fn, worktree_config, data);
       	}
     -@@ config.c: int config_with_options(config_fn_t fn, void *data,
     - 		data = &inc;
     - 	}
     - 
     --	if (config_source)
     -+	if (config_source && config_source->scope != CONFIG_SCOPE_UNKNOWN)
     - 		config_reader_set_scope(&the_reader, config_source->scope);
     - 
     - 	/*
      @@ config.c: int config_with_options(config_fn_t fn, void *data,
       		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
       						data);
       	} else {
      -		ret = do_git_config_sequence(&the_reader, opts, fn, data);
     -+		struct repository *repo = config_source && config_source->repo ?
     -+			config_source->repo : the_repository;
      +		ret = do_git_config_sequence(&the_reader, opts, repo, fn, data);
       	}
       
       	if (inc.remote_urls) {
     -@@ config.c: static void repo_read_config(struct repository *repo)
     - {
     - 	struct config_options opts = { 0 };
     - 	struct configset_add_data data = CONFIGSET_ADD_INIT;
     -+	struct git_config_source config_source = { 0 };
     - 
     - 	opts.respect_includes = 1;
     - 	opts.commondir = repo->commondir;
     - 	opts.git_dir = repo->gitdir;
     - 
     -+	config_source.repo = repo;
     -+
     - 	if (!repo->config)
     - 		CALLOC_ARRAY(repo->config, 1);
     - 	else
     -@@ config.c: static void repo_read_config(struct repository *repo)
     - 	data.config_set = repo->config;
     - 	data.config_reader = &the_reader;
     - 
     --	if (config_with_options(config_set_callback, &data, NULL, &opts) < 0)
     -+	if (config_with_options(config_set_callback, &data, &config_source, &opts) < 0)
     - 		/*
     - 		 * config_with_options() normally returns only
     - 		 * zero, as most errors are fatal, and
      @@ config.c: int repo_config_set_worktree_gently(struct repository *r,
       				    const char *key, const char *value)
       {
     @@ setup.c: void check_repository_format(struct repository_format *fmt)
       	clear_repository_format(&repo_fmt);
      
       ## t/t3007-ls-files-recurse-submodules.sh ##
     -@@ t/t3007-ls-files-recurse-submodules.sh: test_expect_success '--recurse-submodules parses submodule repo config' '
     - test_expect_success '--recurse-submodules parses submodule worktree config' '
     - 	test_when_finished "git -C submodule config --unset extensions.worktreeConfig" &&
     - 	test_when_finished "git -C submodule config --worktree --unset feature.experimental" &&
     --	test_when_finished "git config --unset extensions.worktreeConfig" &&
     +@@ t/t3007-ls-files-recurse-submodules.sh: test_expect_success '--recurse-submodules parses submodule worktree config' '
     + 	test_config -C submodule extensions.worktreeConfig true &&
     + 	test_config -C submodule --worktree index.sparse "invalid non-boolean value" &&
       
     - 	git -C submodule config extensions.worktreeConfig true &&
     - 	git -C submodule config --worktree feature.experimental "invalid non-boolean value" &&
     - 
     --	# NEEDSWORK: the extensions.worktreeConfig is set globally based on super
     --	# project, so we need to enable it in the super project.
     --	git config extensions.worktreeConfig true &&
     +-	# NEEDSWORK: the extensions.worktreeConfig is set globally based on
     +-	# superproject, so we need to enable it in the superproject.
     +-	test_config extensions.worktreeConfig true &&
      -
       	test_must_fail git ls-files --recurse-submodules 2>err &&
       	grep "bad boolean config value" err
       '
       
      +test_expect_success '--recurse-submodules submodules ignore super project worktreeConfig extension' '
     -+	test_when_finished "git config --unset extensions.worktreeConfig" &&
     -+
      +	# Enable worktree config in both super project & submodule, set an
     -+	# invalid config in the submodule worktree config, then disable worktree
     -+	# config in the submodule. The invalid worktree config should not be
     -+	# picked up.
     -+	git config extensions.worktreeConfig true &&
     -+	git -C submodule config extensions.worktreeConfig true &&
     -+	git -C submodule config --worktree feature.experimental "invalid non-boolean value" &&
     -+	git -C submodule config --unset extensions.worktreeConfig &&
     ++	# invalid config in the submodule worktree config
     ++	test_config extensions.worktreeConfig true &&
     ++	test_config -C submodule extensions.worktreeConfig true &&
     ++	test_config -C submodule --worktree index.sparse "invalid non-boolean value" &&
     ++
     ++	# Now, disable the worktree config in the submodule. Note that we need
     ++	# to manually re-enable extensions.worktreeConfig when the test is
     ++	# finished, otherwise the test_unconfig of index.sparse will not work.
     ++	test_unconfig -C submodule extensions.worktreeConfig &&
     ++	test_when_finished "git -C submodule config extensions.worktreeConfig true" &&
      +
     ++	# With extensions.worktreeConfig disabled in the submodule, the invalid
     ++	# worktree config is not picked up.
      +	git ls-files --recurse-submodules 2>err &&
      +	! grep "bad boolean config value" err
      +'

-- 
gitgitgadget
