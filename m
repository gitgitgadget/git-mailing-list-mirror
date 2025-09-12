Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7952EA729
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673018; cv=none; b=P3nVvIarlL+5yIUUkCCf0pQ49PqYAsSiw/z23MgI3rbY9PXxVIEt+lXneFrwQ0r/gLGTkX3niqjbEkUuRbBk86fL7Bow928Iyac6JNzGfSA/4NyO0RzM1KJ68GyFueilsy4dfGSFcGj/xD14hEFPwKro7vT13EDT6gLDPTW4eMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673018; c=relaxed/simple;
	bh=B3d7hRlICgK2NQFGgyi2rkIYhMgmYmilUGcFmmLSWPg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nZjsxFxWzmkt2iK0D2RpS3rBB++PAXg/r6T8gpGjt9vMS1Zd7vyufzr4jq7OpiSPxEBgTa96S5CLULKS+ObotS7LiUI6m3+C0iFrFX4HB7bXn1+kWT+ifG2XFpEY9mVBWeZ1Hy00EF3jcEOXiZMm56//OexW+IBjJ2R8tMg8WL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwcTVO4V; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwcTVO4V"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244580523a0so17512885ad.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757673014; x=1758277814; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/UYDGJCVMXaCNNZbN4LZaMENlPNlYqt630DeM7Vjdk=;
        b=fwcTVO4VyF6xyFK+Q1KngugcdX6cJwLPTvS9fO1ia5D5ltYuV7HC2mQgswhyr6zOiZ
         yZphX5L0uibBKQ+PokYh+bYj9mcBfUHMAQBk7/ffXKJZK531Il+7Y+D0yNC2a2qx5Ow/
         5EX08g6Hsg1KYGuf+rlplUbi9HHepEv+SHdTLhjZK6Bjz08n69DsiPHlRsD05a/odkqx
         MgClUTSSvSALVWZ4VuTRJjY8jCOD36/yHyqjycqGtYIrMBNjxRFpW7BuyVjFa4t3ZlYN
         1l33flGxibbdjXIpliNRpB13jQaQbMS/B4rMjePqqs9ExYZ9XoLm5vmE1s9WoUY50VAw
         JD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673014; x=1758277814;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/UYDGJCVMXaCNNZbN4LZaMENlPNlYqt630DeM7Vjdk=;
        b=YBG5wQ14wwCntZIdcPDmYYJzvi0S499pCuPejshXubfIC8WgSiRquPwBtZFA7ZoE8z
         7DuACXBtpDeKaTyB0Z7DaPCqr9mE0BKjGpoJfzX79q36AWfBp95Gl/qpgEnfzeQdwkz4
         YsNBeSepuhzpUZr77s8HIYC3Y0G/dBU7O7JV1eGpIrgKD72cMV1f7688RC9/m+16qCRr
         J63YgPFufqOj+XoSW5cxPK9wa4fF+kJ6QqDK1yuDF9voyfcrEsJWM9KDPkSUknkR4015
         T145IL+ukgqZ4FTgEDwh1+xxEyZwEt1csUG/gxgmnYgl/6KNPqnr9Zk6icUIOWKdOWMD
         G46A==
X-Gm-Message-State: AOJu0Yww+Un8kXQn1lhgGeEZahy8q2f6b84Nsa5s/ns4zHNoVhMFgwd3
	ETOELpY7zTRvLnANZRE91XnXRwaT0rbs8i/INd9TRhWbdigD2C9AZqEhdCLiBA==
X-Gm-Gg: ASbGncue7DufGfNTa6iW+8Mwet9n8TJLpY8G9EtC9CLnPGOpg/IboJzdW5uaHff8AV7
	s/R5lDQH5leVW6ND8NHGAWxPVSDv2mMhs3q4qI9nB6xIGyOEoyefOAxvcjCfOCFP0tayGSkkY+U
	apwEk/GXMIcU3PGkkecOe0+kRRTCg1yGgcYSZcresmBoGMxFE4DlhVvJRlbwF0urJRVoNekE2rl
	r43bo8NNlRDt4o0f4S4AYQ5ZiIDwWPuR02r+2XDMERzVd6z46XS2BI4VfzHYm0P0LTAkooCmnW7
	b9o+BxJpTrohMmOPDwabpKM7aK9WAra2LjgbZYBXIfa5pJDYdlrfLaj2dmG1Y3EuyjUtzQeIUnl
	8roOMUR6dTM/2Uk40IV+GCbfVSJLK46rjVfd76w==
X-Google-Smtp-Source: AGHT+IHtF/LBkf4oeg8CsP9CLsjBSEzug5B5cKW1PUrKKHZBPtFtRgGfexpvCcgNFHBX1rkLPQj/SQ==
X-Received: by 2002:a17:902:e94f:b0:252:1d6e:df79 with SMTP id d9443c01a7336-25d27c1b6efmr30758585ad.54.1757673013570;
        Fri, 12 Sep 2025 03:30:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.175.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37294d83sm45443055ad.35.2025.09.12.03.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:30:11 -0700 (PDT)
Message-Id: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 10:30:04 +0000
Subject: [PATCH v3 0/7] sparse-checkout: add 'clean' command
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>

NEW: This series is rebased on a recent master to remove dependence on the
updates to the global variables used by the sparse-checkout system.

When using cone-mode sparse-checkout, users specify which tracked
directories they want (recursively) and any directory not part of the parent
paths for those directories are considered "out of scope". When changing
sparse-checkouts, there are a variety of reasons why these "out of scope"
directories could remain, including:

 * The user has .gitignore or .git/info/exclude files that tell Git to not
   remove files of a certain type.
 * Some filesystem blocker prevented the removal of a tracked file. This is
   usually more of an issue on Windows where a read handle will block file
   deletion.

Typically, this would not mean too much for the user experience. A few extra
filesystem checks might be required to satisfy git status commands, but the
scope of the performance hit is relative to how many cruft files are left
over in this situation.

However, when using the sparse index, these tracked sparse directories cause
significant performance issues. When noticing that the index contains a
sparse directory but that directory exists on disk, Git needs to expand that
sparse directory to determine which files are tracked or untracked. The
current mechanism expands the entire index to a full one, an expensive
operation that scales with the total number of paths at HEAD and not just
the number of cruft files left over.

Advice was added in 9479a31d603 (advice: warn when sparse index expands,
2024-07-08) to help users determine that they were in this state. However,
the advice doesn't actually recommend helpful ways to get out of this state.
Recommending "git clean" on its own is incomplete, as typically users
actually need 'git clean -dfx' to clear out the ignored or excluded files.
Even then, they may need 'git sparse-checkout reapply' afterwards to clear
the sparse directories.

The advice was successful in helping to alert users to the problem, which is
how I got wind of many of these cases for how users get into this state.
It's now time to give them a tool that helps them out of this state.

This series adds a new 'git sparse-checkout clean' command that currently
only works for cone-mode sparse-checkouts. The only thing it does is
collapse the index to a sparse index (as much as possible) and make sure
that any sparse directories are removed. These directories are listed to
stdout.

This command uses the same '--force' and '--dry-run' options as 'git clean',
with integrations with the 'clean.requireForce' config option. There are
some concerns that this isn't an obvious way to work with the 'git clean'
command, but I thought we should be consistent here. I did change the error
message to point users to the necessary options.

This option would be preferred to something like 'git clean -dfx' since it
does not clear the excluded files that are still within the sparse-checkout.
Instead, it performs the exact filesystem operations required to refresh the
sparse index performance back to what is expected.


Updates in V3
=============

Huge thanks to Elijah for such a detailed review. Apologies for the delay in
responding.

 * Removed dependency on stalled series around updating the sparse-checkout
   globals.
 * Commit message and documentation is updated to better describe the
   conditions that qualify a file or directory for removal.
 * Tests are expanded significantly to include special cases and
   aftereffects.
 * A note is added around possible future expansion of the --verbose option
   to include more detailed status information on the files that would be
   deleted.
 * Due to a situation where a file appears as "modified and deleted" after
   the more aggressive updating of the tree, the previous patch 8 is removed
   (for now). I may reconsider and send a version in the future that avoids
   this issue. Tests from the earlier patches are more expanded in such a
   way that the aggressive implementation requires test changes that reveal
   this problem. See [1] for a copy of this change and how it impacts the
   latest tests.

[1]
https://github.com/derrickstolee/git/commit/f9eb8e03361d61023fec33386fc9898f60b65a31


Updates in V2
=============

 * This series is based on 2c5b5565981 (environment: remove the global
   variable 'sparse_expect_files_outside_of_patterns', 2025-07-01) to build
   upon those cleanups in builtin/sparse-checkout.c.
 * The --force and --dry-run options match 'git clean'.
 * A --verbose option is added. It does not link to the index for
   tracked/untracked/ignored/excluded or clean/modified/staged/conflicted
   status, but instead gives the full list for information.
 * To support the --verbose option, a new for_each_file_in_dir() method is
   added to dir.h.
 * Tests are added to demonstrate the behavior when a sparse directory has a
   merge conflict (fails with an explanation). When adding the test based on
   the previous version's functionality, I realized that the behavior is
   sometimes less effective than git sparse-checkout reapply even after a
   sparse file is committed. To demonstrate this change, the full test is
   created on its own and then a code change is added with the impact on the
   test.

Thanks, -Stolee

Derrick Stolee (7):
  sparse-checkout: remove use of the_repository
  sparse-checkout: add basics of 'clean' command
  sparse-checkout: match some 'clean' behavior
  dir: add generic "walk all files" helper
  sparse-checkout: add --verbose option to 'clean'
  sparse-index: point users to new 'clean' action
  t: expand tests around sparse merges and clean

 Documentation/git-sparse-checkout.adoc |  33 +++-
 builtin/sparse-checkout.c              | 218 ++++++++++++++++++-------
 dir.c                                  |  28 ++++
 dir.h                                  |  14 ++
 sparse-index.c                         |   3 +-
 t/t1091-sparse-checkout-builtin.sh     | 175 ++++++++++++++++++++
 6 files changed, 413 insertions(+), 58 deletions(-)


base-commit: ab427cd991100e94792fce124b0934135abdea4b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1941%2Fderrickstolee%2Fgit-sparse-checkout-clean-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1941/derrickstolee/git-sparse-checkout-clean-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1941

Range-diff vs v2:

 1:  92d0cd41a4 ! 1:  437a57b665 sparse-checkout: remove use of the_repository
     @@ builtin/sparse-checkout.c: static enum sparse_checkout_mode update_cone_mode(int
       	int mode, record_mode;
       
      @@ builtin/sparse-checkout.c: static int update_modes(int *cone_mode, int *sparse_index)
     - 	record_mode = (*cone_mode != -1) || !the_repository->settings.sparse_checkout;
     + 	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
       
       	mode = update_cone_mode(cone_mode);
      -	if (record_mode && set_config(mode))
     @@ builtin/sparse-checkout.c: static void add_patterns_literal(int argc, const char
       {
       	int result;
      @@ builtin/sparse-checkout.c: static int modify_pattern_list(struct strvec *args, int use_stdin,
     - 		break;
       	}
       
     --	if (!the_repository->settings.sparse_checkout) {
     + 	if (!core_apply_sparse_checkout) {
      -		set_config(MODE_ALL_PATTERNS);
     --		the_repository->settings.sparse_checkout = 1;
     -+	if (!repo->settings.sparse_checkout) {
      +		set_config(repo, MODE_ALL_PATTERNS);
     -+		repo->settings.sparse_checkout = 1;
     + 		core_apply_sparse_checkout = 1;
       		changed_config = 1;
       	}
       
     @@ builtin/sparse-checkout.c: static struct sparse_checkout_add_opts {
       	static struct option builtin_sparse_checkout_add_options[] = {
       		OPT_BOOL_F(0, "skip-checks", &add_opts.skip_checks,
      @@ builtin/sparse-checkout.c: static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
     - 	if (!the_repository->settings.sparse_checkout)
     + 	if (!core_apply_sparse_checkout)
       		die(_("no sparse-checkout to add to"));
       
      -	repo_read_index(the_repository);
     @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const ch
       	memset(&pl, 0, sizeof(pl));
       	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
      @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const char **argv,
     - 
       	add_pattern("/*", empty_base, 0, &pl, 0);
       
     + 	prepare_repo_settings(the_repository);
      -	the_repository->settings.sparse_index = 0;
      +	repo->settings.sparse_index = 0;
       
     @@ builtin/sparse-checkout.c: static int sparse_checkout_check_rules(int argc, cons
       	return ret;
      @@ builtin/sparse-checkout.c: int cmd_sparse_checkout(int argc,
       
     - 	git_config(git_default_config, NULL);
     + 	repo_config(the_repository, git_default_config, NULL);
       
      -	prepare_repo_settings(the_repository);
      -	the_repository->settings.command_requires_full_index = 0;
 2:  7e8f7c2d6c ! 2:  a1564f74cf sparse-checkout: add basics of 'clean' command
     @@ Commit message
          not be sufficient.
      
          Add a new subcommand to 'git sparse-checkout' that removes these
     -    tracked-but-sparse directories. This necessarily removes all files
     -    contained within, including tracked and untracked files. Of particular
     -    importance are ignored and excluded files which would normally be
     -    ignored even by 'git clean -f' unless the '-x' or '-X' option is
     -    provided. This is the most extreme method for doing this, but it works
     -    when the sparse-checkout is in cone mode and is expected to rescope
     -    based on directories, not files.
     +    tracked-but-sparse directories.
     +
     +    The implementation details provide a clear definition of what is happening,
     +    but it is difficult to describe this without including the internal
     +    implementation details. The core operation converts the index to a sparse
     +    index (in memory if not already on disk) and then deletes any directories in
     +    the worktree that correspond with a sparse directory entry in that sparse
     +    index.
     +
     +    In the most common case, this means that a file will be removed if it is
     +    contained within a directory that is both tracked and outside of the
     +    sparse-checkout definition. However, there can be exceptions depending on
     +    the current state of the index:
     +
     +     * If the worktree has a modification to a tracked, sparse file, then that
     +       file's parent directories will be expanded instead of represented as
     +       sparse directories. Siblings of those parent directories may be
     +       considered sparse.
     +
     +     * If the user staged a sparse file with "git add --sparse", then that file
     +       loses the SKIP_WORKTREE bit until the sparse-checkout is reapplied. Until
     +       then, that file's parent directories are not represented as sparse
     +       directory entries and thus will not be removed. Siblings of those parent
     +       directories may be considered sparse. (There may be other reasons why
     +       the SKIP_WORKTREE bit was removed for a file and this impact on the
     +       sparse directories will apply to those as well.)
     +
     +     * If the user has a merge conflict outside of the sparse-checkout
     +       definition, then those conflict entries prevent the parent directories
     +       from being represented as sparse directory entries and thus are not
     +       removed.
     +
     +     * The cases above present reasons why certain _file conditions_ will impact
     +       which _directories_ are considered sparse. The list of tracked
     +       directories that are outside of the sparse-checkout definition but not
     +       represented as a sparse directory further reduces the list of files that
     +       will be removed.
     +
     +    For these complicated reasons, the documentation details a potential list of
     +    files that will be "considered for removal" instead of defining the list
     +    concretely. The special cases can be handled by resolving conflicts,
     +    committing staged changes, and running 'git sparse-checkout reapply' to
     +    update the SKIP_WORKTREE bits as expected by the sparse-checkout definition.
     +
     +    It is important to make clear that this operation will remove ignored and
     +    excluded files which would normally be ignored even by 'git clean -f' unless
     +    the '-x' or '-X' option is provided. This is the most extreme method for
     +    doing this, but it works when the sparse-checkout is in cone mode and is
     +    expected to rescope based on directories, not files.
      
          The current implementation always deletes these sparse directories
          without warning. This is unacceptable for a released version, but those
          features will be added in changes coming immediately after this one.
      
     -    Note that untracked directories within the sparse-checkout remain.
     -    Further, directories that contain staged changes or files in merge
     -    conflict states are not deleted. This is a detail that is partly hidden
     -    by the implementation which relies on collapsing the index to a sparse
     -    index in-memory and only deleting directories that are listed as sparse
     -    in the index.
     +    Note that this will not remove an untracked directory (or any of its
     +    contents) if its parent is a tracked directory within the sparse-checkout
     +    definition. This is required to prevent removing data created by tools that
     +    perform caching operations for editors or build tools.
     +
     +    Thus, 'git sparse-checkout clean' is both more aggressive and more careful
     +    than 'git clean -fx':
      
     -    If a staged change exists, then that entry is not stored as a sparse
     -    tree entry and thus remains on-disk until committed or reset.
     +     * It is more aggressive because it will remove _tracked_ files within the
     +       sparse directories.
      
     -    There are some interesting cases around merge conflict resolution, but
     -    that will be carefully analyzed in the future.
     +     * It is less aggressive because it will leave _untracked_ files that are
     +       not contained in sparse directories.
     +
     +    These special cases will be handled more explicitly in a future change that
     +    expands tests for the 'git sparse-checkout clean' command. We handle some of
     +    the modified, staged, and committed states including some impact on 'git
     +    status' after cleaning.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ Documentation/git-sparse-checkout.adoc: flags, with the same meaning as the flag
       all sparsity paths.
       
      +'clean'::
     -+	Remove all files in tracked directories that are outside of the
     -+	sparse-checkout definition. This subcommand requires cone-mode
     -+	sparse-checkout to be sure that we know which directories are
     -+	both tracked and all contained paths are not in the sparse-checkout.
     -+	This command can be used to be sure the sparse index works
     -+	efficiently, though it does not require enabling the sparse index
     -+  feature via the `index.sparse=true` configuration.
     ++	Opportunistically remove files outside of the sparse-checkout
     ++	definition. This command requires cone mode to use recursive
     ++	directory matches to determine which files should be removed. A
     ++	file is considered for removal if it is contained within a tracked
     ++	directory that is outside of the sparse-checkout definition.
     +++
     ++Some special cases, such as merge conflicts or modified files outside of
     ++the sparse-checkout definition could lead to keeping files that would
     ++otherwise be removed. Resolve conflicts, stage modifications, and use
     ++`git sparse-checkout reapply` in conjunction with `git sparse-checkout
     ++clean` to resolve these cases.
     +++
     ++This command can be used to be sure the sparse index works efficiently,
     ++though it does not require enabling the sparse index feature via the
     ++`index.sparse=true` configuration.
      +
       'disable'::
       	Disable the `core.sparseCheckout` config setting, and restore the
     @@ builtin/sparse-checkout.c: static int sparse_checkout_reapply(int argc, const ch
      +	};
      +
      +	setup_work_tree();
     -+	if (!repo->settings.sparse_checkout)
     ++	if (!core_apply_sparse_checkout)
      +		die(_("must be in a sparse-checkout to clean directories"));
     -+	if (!repo->settings.sparse_checkout_cone)
     ++	if (!core_sparse_checkout_cone)
      +		die(_("must be in a cone-mode sparse-checkout to clean directories"));
      +
      +	argc = parse_options(argc, argv, prefix,
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'check-rules null termin
       
      +test_expect_success 'clean' '
      +	git -C repo sparse-checkout set --cone deep/deeper1 &&
     ++	git -C repo sparse-checkout reapply &&
      +	mkdir repo/deep/deeper2 repo/folder1 &&
     ++
     ++	# Add untracked files
      +	touch repo/deep/deeper2/file &&
      +	touch repo/folder1/file &&
      +
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'check-rules null termin
      +	test_path_is_missing repo/folder1
      +'
      +
     -+test_expect_success 'clean with staged sparse change' '
     ++test_expect_success 'clean with sparse file states' '
     ++	test_when_finished git reset --hard &&
      +	git -C repo sparse-checkout set --cone deep/deeper1 &&
     -+	mkdir repo/deep/deeper2 repo/folder1 repo/folder2 &&
     -+	touch repo/deep/deeper2/file &&
     -+	touch repo/folder1/file &&
     ++	mkdir repo/folder2 &&
     ++
     ++	# create an untracked file and a modified file
     ++	touch repo/folder2/file &&
      +	echo dirty >repo/folder2/a &&
      +
     -+	git -C repo add --sparse folder1/file &&
     ++	# First clean/reapply pass will do nothing.
     ++	git -C repo sparse-checkout clean >out &&
     ++	test_must_be_empty out &&
     ++	test_path_exists repo/folder2/a &&
     ++	test_path_exists repo/folder2/file &&
     ++
     ++	git -C repo sparse-checkout reapply 2>err &&
     ++	test_grep folder2 err &&
     ++	test_path_exists repo/folder2/a &&
     ++	test_path_exists repo/folder2/file &&
     ++
     ++	# Now, stage the change to the tracked file.
     ++	git -C repo add --sparse folder2/a &&
     ++
     ++	# Clean will continue not doing anything.
     ++	git -C repo sparse-checkout clean >out &&
     ++	test_line_count = 0 out &&
     ++	test_path_exists repo/folder2/a &&
     ++	test_path_exists repo/folder2/file &&
     ++
     ++	# But we can reapply to remove the staged change.
     ++	git -C repo sparse-checkout reapply 2>err &&
     ++	test_grep folder2 err &&
     ++	test_path_is_missing repo/folder2/a &&
     ++	test_path_exists repo/folder2/file &&
      +
     -+	# deletes deep/deeper2/ but leaves folder1/ and folder2/
     ++	# We can clean now.
      +	cat >expect <<-\EOF &&
     -+	Removing deep/deeper2/
     ++	Removing folder2/
      +	EOF
     -+
      +	git -C repo sparse-checkout clean >out &&
      +	test_cmp expect out &&
     ++	test_path_is_missing repo/folder2 &&
      +
     -+	test_path_is_missing repo/deep/deeper2 &&
     -+	test_path_exists repo/folder1
     ++	# At the moment, the file is staged.
     ++	cat >expect <<-\EOF &&
     ++	M  folder2/a
     ++	EOF
     ++
     ++	git -C repo status -s >out &&
     ++	test_cmp expect out &&
     ++
     ++	# Reapply persists the modified state.
     ++	git -C repo sparse-checkout reapply &&
     ++	cat >expect <<-\EOF &&
     ++	M  folder2/a
     ++	EOF
     ++	git -C repo status -s >out &&
     ++	test_cmp expect out &&
     ++
     ++	# Committing the change leads to resolved status.
     ++	git -C repo commit -m "modified" &&
     ++	git -C repo status -s >out &&
     ++	test_must_be_empty out &&
     ++
     ++	# Repeat, but this time commit before reapplying.
     ++	mkdir repo/folder2/ &&
     ++	echo dirtier >repo/folder2/a &&
     ++	git -C repo add --sparse folder2/a &&
     ++	git -C repo sparse-checkout clean >out &&
     ++	test_must_be_empty out &&
     ++	test_path_exists repo/folder2/a &&
     ++
     ++	# Committing without reapplying makes it look like a deletion
     ++	# due to no skip-worktree bit.
     ++	git -C repo commit -m "dirtier" &&
     ++	git -C repo status -s >out &&
     ++	test_must_be_empty out &&
     ++
     ++	git -C repo sparse-checkout reapply &&
     ++	git -C repo status -s >out &&
     ++	test_must_be_empty out
      +'
       
       test_done
 3:  221f3e5fb0 ! 3:  71a498db65 sparse-checkout: match some 'clean' behavior
     @@ Commit message
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/git-sparse-checkout.adoc ##
     -@@ Documentation/git-sparse-checkout.adoc: all sparsity paths.
     - 	This command can be used to be sure the sparse index works
     - 	efficiently, though it does not require enabling the sparse index
     -   feature via the `index.sparse=true` configuration.
     +@@ Documentation/git-sparse-checkout.adoc: clean` to resolve these cases.
     + This command can be used to be sure the sparse index works efficiently,
     + though it does not require enabling the sparse index feature via the
     + `index.sparse=true` configuration.
      ++
      +To prevent accidental deletion of worktree files, the `clean` subcommand
      +will not delete any files without the `-f` or `--force` option, unless
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'clean' '
       	test_cmp expect out &&
       
       	test_path_is_missing repo/deep/deeper2 &&
     -@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'clean with staged sparse change' '
     - 
     - 	git -C repo add --sparse folder1/file &&
     - 
     -+	cat >expect <<-\EOF &&
     -+	Would remove deep/deeper2/
     -+	EOF
     -+
     -+	git -C repo sparse-checkout clean --dry-run >out &&
     -+	test_cmp expect out &&
     -+	test_path_exists repo/deep/deeper2 &&
     -+	test_path_exists repo/folder1 &&
     -+	test_path_exists repo/folder2 &&
     -+
     - 	# deletes deep/deeper2/ but leaves folder1/ and folder2/
     - 	cat >expect <<-\EOF &&
     - 	Removing deep/deeper2/
     - 	EOF
     +@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'clean with sparse file states' '
     + 	git -C repo sparse-checkout set --cone deep/deeper1 &&
     + 	mkdir repo/folder2 &&
       
      +	# The previous test case checked the -f option, so
      +	# test the config option in this one.
      +	git -C repo config clean.requireForce false &&
     - 	git -C repo sparse-checkout clean >out &&
     - 	test_cmp expect out &&
     - 
     - 	test_path_is_missing repo/deep/deeper2 &&
     --	test_path_exists repo/folder1
     -+	test_path_exists repo/folder1 &&
     -+	test_path_exists repo/folder2
     -+'
      +
     + 	# create an untracked file and a modified file
     + 	touch repo/folder2/file &&
     + 	echo dirty >repo/folder2/a &&
     +@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'clean with sparse file states' '
     + 	test_must_be_empty out
     + '
     + 
      +test_expect_success 'clean with merge conflict status' '
      +	git clone repo clean-merge &&
      +
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'clean with staged spars
      +
      +	git -C clean-merge sparse-checkout clean -f >out &&
      +	test_cmp expect out
     - '
     - 
     ++'
     ++
       test_done
 4:  fd9a20a392 = 4:  6b29dda4b8 dir: add generic "walk all files" helper
 5:  f464bb5ed6 ! 5:  2cde464fd4 sparse-checkout: add --verbose option to 'clean'
     @@ Commit message
          Add a new '--verbose' option for users to see all the files that are
          being deleted (with '--force') or would be deleted (with '--dry-run').
      
     +    Based on usage, users may request further context on this list of files for
     +    states such as tracked/untracked, unstaged/staged/conflicted, etc.
     +
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/git-sparse-checkout.adoc ##
     @@ builtin/sparse-checkout.c: static int sparse_checkout_clean(int argc, const char
      
       ## t/t1091-sparse-checkout-builtin.sh ##
      @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'check-rules null termination' '
     - 
       test_expect_success 'clean' '
       	git -C repo sparse-checkout set --cone deep/deeper1 &&
     + 	git -C repo sparse-checkout reapply &&
      -	mkdir repo/deep/deeper2 repo/folder1 &&
      +	mkdir -p repo/deep/deeper2 repo/folder1/extra/inside &&
     + 
     + 	# Add untracked files
       	touch repo/deep/deeper2/file &&
      -	touch repo/folder1/file &&
      +	touch repo/folder1/extra/inside/file &&
 6:  d6dbc0b5ca = 6:  460e5e8157 sparse-index: point users to new 'clean' action
 7:  0b1a2895b9 ! 7:  7f6f62bce6 t: expand tests around sparse merges and clean
     @@ Commit message
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## t/t1091-sparse-checkout-builtin.sh ##
     -@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'clean with staged sparse change' '
     - 	test_path_exists repo/folder2
     +@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'clean with sparse file states' '
     + 	test_must_be_empty out
       '
       
      -test_expect_success 'clean with merge conflict status' '
 8:  82c24ce519 < -:  ---------- sparse-checkout: make 'clean' clear more files

-- 
gitgitgadget
