Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1941A288
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 01:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716062; cv=none; b=raI19k86oYSYmRHVYMLl9OAFbXGDu0fr9ywFdOD2aCkzvduCb3HDrB33wjpszYMTXcJG1/S14q8nHPJYxs651pUGtR8Z07D9XaDaCbwtviFgCiDmrZvPKI0obEpD9VwQi5yRhGQ8k8qJV8WqOClexp/w743j/MUgEaXFb4r+0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716062; c=relaxed/simple;
	bh=tQzZT666hzuMlH/9P44lDKKYCiB3L8kGXa9IDqNQzTc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uIQZNyfRKZQ3MpLDcY3684V5qFT4rF7MAvlEna3t0OCrRm0efw82mHPq9XwAfQfhFhNK/4gJLuVDFDUDS+FcJe9Pd5LTvx1vLg3bnseycCxbu6evm5sLVlV7CPRLptTE8aIFZ3QNS97hre2iJ3fPx9T/ACPHu8s2jFDxwPuH0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWxPHZbe; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWxPHZbe"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so3965805e9.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 18:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752716056; x=1753320856; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k94AtGYOCeMCLW1d6kkWnXaBaR2aPSReFcMk3Yvlapw=;
        b=YWxPHZbeJOICxPSv32v1BDpFbTER3w3xrIrCHx/JekO68oPv1XOaw7wnFsu0QuS4FH
         8IpTjiNHEiszdjMNJBSs7rNo0UZ84CF8cYgR3Yp1S9EzRVwZgGK77SV98ncBxREDY9Yc
         D6xHGOhTV/VLC7sx9WHcbT5UXU44JqsHmXeLH6nT1kCk8srdCXHgP6nz51AxT/IU4inW
         47qvWPSVV2CNAlb2/822dSIML1ZPlhCSuUtRYTbw0MxTLTHPKFewIze+AxO7wMrzOQ22
         YJ7h6psnwknWhxgyfieltjOSuLIxBj/6DnGMmQRAM2XCal7yVkNkHlT8FGsFq3eS62Q0
         d92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716056; x=1753320856;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k94AtGYOCeMCLW1d6kkWnXaBaR2aPSReFcMk3Yvlapw=;
        b=b8Eljf3IRqpwhIDZNXpRhv1D2yGAhrFMyJXX7DyVdZq3wqftyvQZ0BbOzXjwW2Fzc2
         DnzCjLjK6xpMUv/8CtIYxzvg5vklgq/oeS+xWiIX596GISryV9+V/+Ct73ejLO7zlZiN
         /dgA1cR6RZ0CxS4WuupcvLpi994GeHue1GBp/AH5y5Zcd2cAJrV2fRJLBPxPAWZRM4me
         5fZBywlgcEFXMcGy1v6z5rU/mGet1CQvzO8xZH7skiKRxIjKEAqWZUfAHN3MjJ4jQqs8
         LG7IzZ7gVX334CB5B7ZQi0HBvcmNoBFnKGlmCJh41wc3yOIaLJnrHz2jRJSk+V6Xwiiu
         VHBw==
X-Gm-Message-State: AOJu0Yx2XV3BSAGMZbn+gTzZeS3pgziZTN6jHapU0uTC7SltO5UGT+5i
	atwvJlFgIlZzVnZlSdSY5zU6nCRNrtfmMkZxNevAbQ+NcEGMnGS5sRC44TN3jg==
X-Gm-Gg: ASbGncsZMTV6lEXz1o3aW2mV/OuZmrSzXEDwHbHu1nJ3Sf2jp51S7Ir99EGwtUU5VZU
	jpX7ZZ3cuQMtABEQ2wjT4cJoC3t0B02j61IKPYstScqF18LOqK7T25+IsDZmlDEMz/P23ueI/GQ
	N/QDH5+z11E0gkJpV58HG4LHVXx3MICho5onTna1Re2UuEf27XBTYvjBNBvG2ZzGiPHjU15njJY
	4Iy80b2NeGyxRzYHzMXiaqBFEKG25GJFan8CIVIyhq6o9b4bfKPNPO0p1fR46M8oiovrHC8uYGJ
	+N/hSFxgFNkVF2flbgavr4r0kTL7/B7svrtNWhrcgjFMViMRvKUzR5OtSZ4GnDkG4ddcS1Ir88p
	GJqq2wgEsk7bMr178bqT6pVI=
X-Google-Smtp-Source: AGHT+IEFXMfceFpNM+azx2apKL2NVdQR90d7EBCnYO25chS8Sr2yKZhZMALw1lI1h14MgBF7s+BKNw==
X-Received: by 2002:a05:6000:4284:b0:3b4:9721:2b1c with SMTP id ffacd0b85a97d-3b60e4c9134mr3007383f8f.6.1752716056214;
        Wed, 16 Jul 2025 18:34:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14ce6sm19523870f8f.68.2025.07.16.18.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:34:15 -0700 (PDT)
Message-Id: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 01:34:06 +0000
Subject: [PATCH v2 0/8] sparse-checkout: add 'clean' command
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

NEW: This series is based on 2c5b5565981 (environment: remove the global
variable 'sparse_expect_files_outside_of_patterns', 2025-07-01) to build
upon those cleanups in builtin/sparse-checkout.c.

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

I spent a few weeks debating with myself about whether or not this was the
right interface, so please suggest alternatives if you have better ideas.
Among my rejected ideas include:

 * 'git sparse-checkout reapply -f -x' or similar augmentations of
   'reapply'.
 * 'git clean --sparse' to focus the clean operation on things outside of
   the sparse-checkout.


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

Derrick Stolee (8):
  sparse-checkout: remove use of the_repository
  sparse-checkout: add basics of 'clean' command
  sparse-checkout: match some 'clean' behavior
  dir: add generic "walk all files" helper
  sparse-checkout: add --verbose option to 'clean'
  sparse-index: point users to new 'clean' action
  t: expand tests around sparse merges and clean
  sparse-checkout: make 'clean' clear more files

 Documentation/git-sparse-checkout.adoc |  25 ++-
 builtin/sparse-checkout.c              | 230 ++++++++++++++++++-------
 dir.c                                  |  28 +++
 dir.h                                  |  14 ++
 sparse-index.c                         |   3 +-
 t/t1091-sparse-checkout-builtin.sh     | 130 ++++++++++++++
 unpack-trees.c                         |   2 +-
 7 files changed, 371 insertions(+), 61 deletions(-)


base-commit: 2c5b556598191ae64159dc998dc8f0917d412808
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1941%2Fderrickstolee%2Fgit-sparse-checkout-clean-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1941/derrickstolee/git-sparse-checkout-clean-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1941

Range-diff vs v1:

 1:  3cdc44a9e8c ! 1:  92d0cd41a41 sparse-checkout: remove use of the_repository
     @@ builtin/sparse-checkout.c: static enum sparse_checkout_mode update_cone_mode(int
       	int mode, record_mode;
       
      @@ builtin/sparse-checkout.c: static int update_modes(int *cone_mode, int *sparse_index)
     - 	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
     + 	record_mode = (*cone_mode != -1) || !the_repository->settings.sparse_checkout;
       
       	mode = update_cone_mode(cone_mode);
      -	if (record_mode && set_config(mode))
     @@ builtin/sparse-checkout.c: static void add_patterns_literal(int argc, const char
       {
       	int result;
      @@ builtin/sparse-checkout.c: static int modify_pattern_list(struct strvec *args, int use_stdin,
     + 		break;
       	}
       
     - 	if (!core_apply_sparse_checkout) {
     +-	if (!the_repository->settings.sparse_checkout) {
      -		set_config(MODE_ALL_PATTERNS);
     +-		the_repository->settings.sparse_checkout = 1;
     ++	if (!repo->settings.sparse_checkout) {
      +		set_config(repo, MODE_ALL_PATTERNS);
     - 		core_apply_sparse_checkout = 1;
     ++		repo->settings.sparse_checkout = 1;
       		changed_config = 1;
       	}
       
     @@ builtin/sparse-checkout.c: static struct sparse_checkout_add_opts {
       	static struct option builtin_sparse_checkout_add_options[] = {
       		OPT_BOOL_F(0, "skip-checks", &add_opts.skip_checks,
      @@ builtin/sparse-checkout.c: static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
     - 	if (!core_apply_sparse_checkout)
     + 	if (!the_repository->settings.sparse_checkout)
       		die(_("no sparse-checkout to add to"));
       
      -	repo_read_index(the_repository);
     @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const ch
       
       	add_pattern("/*", empty_base, 0, &pl, 0);
       
     --	prepare_repo_settings(the_repository);
      -	the_repository->settings.sparse_index = 0;
     -+	prepare_repo_settings(repo);
      +	repo->settings.sparse_index = 0;
       
      -	if (update_working_directory(&pl))
 2:  49418e8ec8a ! 2:  7e8f7c2d6c8 sparse-checkout: add 'clean' command
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    sparse-checkout: add 'clean' command
     +    sparse-checkout: add basics of 'clean' command
      
          When users change their sparse-checkout definitions to add new
          directories and remove old ones, there may be a few reasons why
     @@ Commit message
          not be sufficient.
      
          Add a new subcommand to 'git sparse-checkout' that removes these
     -    tracked-but-sparse directories, including any excluded or ignored files
     -    underneath. This is the most extreme method for doing this, but it works
     +    tracked-but-sparse directories. This necessarily removes all files
     +    contained within, including tracked and untracked files. Of particular
     +    importance are ignored and excluded files which would normally be
     +    ignored even by 'git clean -f' unless the '-x' or '-X' option is
     +    provided. This is the most extreme method for doing this, but it works
          when the sparse-checkout is in cone mode and is expected to rescope
          based on directories, not files.
      
     -    Be sure to add a --dry-run option so users can predict what will be
     -    deleted. In general, output the directories that are being removed so
     -    users can know what was removed.
     +    The current implementation always deletes these sparse directories
     +    without warning. This is unacceptable for a released version, but those
     +    features will be added in changes coming immediately after this one.
      
     -    Note that untracked directories remain. Further, directories that
     -    contain staged changes are not deleted. This is a detail that is partly
     -    hidden by the implementation which relies on collapsing the index to a
     -    sparse index in-memory and only deleting directories that are listed as
     -    sparse in the index. If a staged change exists, then that entry is not
     -    stored as a sparse tree entry and thus remains on-disk until committed
     -    or reset.
     +    Note that untracked directories within the sparse-checkout remain.
     +    Further, directories that contain staged changes or files in merge
     +    conflict states are not deleted. This is a detail that is partly hidden
     +    by the implementation which relies on collapsing the index to a sparse
     +    index in-memory and only deleting directories that are listed as sparse
     +    in the index.
     +
     +    If a staged change exists, then that entry is not stored as a sparse
     +    tree entry and thus remains on-disk until committed or reset.
     +
     +    There are some interesting cases around merge conflict resolution, but
     +    that will be carefully analyzed in the future.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ Documentation/git-sparse-checkout.adoc: flags, with the same meaning as the flag
      +	sparse-checkout to be sure that we know which directories are
      +	both tracked and all contained paths are not in the sparse-checkout.
      +	This command can be used to be sure the sparse index works
     -+	efficiently.
     -++
     -+The `clean` command can also take the `--dry-run` (`-n`) option to list
     -+the directories it would remove without performing any filesystem changes.
     ++	efficiently, though it does not require enabling the sparse index
     ++  feature via the `index.sparse=true` configuration.
      +
       'disable'::
       	Disable the `core.sparseCheckout` config setting, and restore the
       	working directory to include all files.
      
       ## builtin/sparse-checkout.c ##
     +@@
     + #define DISABLE_SIGN_COMPARE_WARNINGS
     + 
     + #include "builtin.h"
     ++#include "abspath.h"
     + #include "config.h"
     + #include "dir.h"
     + #include "environment.h"
      @@
       static const char *empty_base = "";
       
     @@ builtin/sparse-checkout.c: static int sparse_checkout_reapply(int argc, const ch
      +	NULL
      +};
      +
     -+static struct sparse_checkout_clean_opts {
     -+	int dry_run;
     -+} clean_opts;
     ++static const char *msg_remove = N_("Removing %s\n");
      +
      +static int sparse_checkout_clean(int argc, const char **argv,
      +				   const char *prefix,
      +				   struct repository *repo)
      +{
      +	struct strbuf full_path = STRBUF_INIT;
     ++	const char *msg = msg_remove;
      +	size_t worktree_len;
     -+	static struct option builtin_sparse_checkout_clean_options[] = {
     -+		OPT_BOOL('n', "dry-run", &clean_opts.dry_run,
     -+			 N_("list the directories that would be removed without making filesystem changes")),
     ++
     ++	struct option builtin_sparse_checkout_clean_options[] = {
      +		OPT_END(),
      +	};
      +
      +	setup_work_tree();
     -+	if (!core_apply_sparse_checkout)
     ++	if (!repo->settings.sparse_checkout)
      +		die(_("must be in a sparse-checkout to clean directories"));
     -+	if (!core_sparse_checkout_cone)
     ++	if (!repo->settings.sparse_checkout_cone)
      +		die(_("must be in a cone-mode sparse-checkout to clean directories"));
      +
      +	argc = parse_options(argc, argv, prefix,
     @@ builtin/sparse-checkout.c: static int sparse_checkout_reapply(int argc, const ch
      +	if (repo_read_index(repo) < 0)
      +		die(_("failed to read index"));
      +
     -+	if (convert_to_sparse(repo->index, SPARSE_INDEX_MEMORY_ONLY))
     -+		die(_("failed to convert index to a sparse index"));
     ++	if (convert_to_sparse(repo->index, SPARSE_INDEX_MEMORY_ONLY) ||
     ++	    repo->index->sparse_index == INDEX_EXPANDED)
     ++		die(_("failed to convert index to a sparse index; resolve merge conflicts and try again"));
      +
      +	strbuf_addstr(&full_path, repo->worktree);
      +	strbuf_addch(&full_path, '/');
      +	worktree_len = full_path.len;
      +
      +	for (size_t i = 0; i < repo->index->cache_nr; i++) {
     -+		DIR* dir;
      +		struct cache_entry *ce = repo->index->cache[i];
      +		if (!S_ISSPARSEDIR(ce->ce_mode))
      +			continue;
      +		strbuf_setlen(&full_path, worktree_len);
      +		strbuf_add(&full_path, ce->name, ce->ce_namelen);
      +
     -+		dir = opendir(full_path.buf);
     -+		if (!dir)
     -+			continue;
     -+		else if (ENOENT != errno) {
     -+			warning_errno(_("failed to check for existence of '%s'"), ce->name);
     ++		if (!is_directory(full_path.buf))
      +			continue;
     -+		}
      +
     -+		closedir(dir);
     ++		printf(msg, ce->name);
      +
     -+		printf("%s\n", ce->name);
     -+		if (!clean_opts.dry_run) {
     -+			if (remove_dir_recursively(&full_path, 0))
     -+				warning_errno(_("failed to remove '%s'"), ce->name);
     -+		}
     ++		if (remove_dir_recursively(&full_path, 0))
     ++			warning_errno(_("failed to remove '%s'"), ce->name);
      +	}
      +
      +	strbuf_release(&full_path);
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'check-rules null termin
      +	touch repo/folder1/file &&
      +
      +	cat >expect <<-\EOF &&
     -+	deep/deeper2/
     -+	folder1/
     ++	Removing deep/deeper2/
     ++	Removing folder1/
      +	EOF
      +
     -+	git -C repo sparse-checkout clean --dry-run >out &&
     -+	test_cmp expect out &&
     -+
     -+	test_path_exists repo/deep/deeper2 &&
     -+	test_path_exists repo/folder1 &&
     -+
      +	git -C repo sparse-checkout clean >out &&
      +	test_cmp expect out &&
      +
     -+	! test_path_exists repo/deep/deeper2 &&
     -+	! test_path_exists repo/folder1
     ++	test_path_is_missing repo/deep/deeper2 &&
     ++	test_path_is_missing repo/folder1
      +'
      +
      +test_expect_success 'clean with staged sparse change' '
      +	git -C repo sparse-checkout set --cone deep/deeper1 &&
     -+	mkdir repo/deep/deeper2 repo/folder1 &&
     ++	mkdir repo/deep/deeper2 repo/folder1 repo/folder2 &&
      +	touch repo/deep/deeper2/file &&
      +	touch repo/folder1/file &&
     ++	echo dirty >repo/folder2/a &&
      +
      +	git -C repo add --sparse folder1/file &&
      +
     ++	# deletes deep/deeper2/ but leaves folder1/ and folder2/
      +	cat >expect <<-\EOF &&
     -+	deep/deeper2/
     ++	Removing deep/deeper2/
      +	EOF
      +
     -+	git -C repo sparse-checkout clean --dry-run >out &&
     -+	test_cmp expect out &&
     -+
     -+	test_path_exists repo/deep/deeper2 &&
     -+	test_path_exists repo/folder1 &&
     -+
      +	git -C repo sparse-checkout clean >out &&
      +	test_cmp expect out &&
      +
     -+	! test_path_exists repo/deep/deeper2 &&
     ++	test_path_is_missing repo/deep/deeper2 &&
      +	test_path_exists repo/folder1
      +'
       
 -:  ----------- > 3:  221f3e5fb0c sparse-checkout: match some 'clean' behavior
 -:  ----------- > 4:  fd9a20a3922 dir: add generic "walk all files" helper
 -:  ----------- > 5:  f464bb5ed6b sparse-checkout: add --verbose option to 'clean'
 3:  80d7a7641da = 6:  d6dbc0b5ca9 sparse-index: point users to new 'clean' action
 -:  ----------- > 7:  0b1a2895b90 t: expand tests around sparse merges and clean
 -:  ----------- > 8:  82c24ce5198 sparse-checkout: make 'clean' clear more files

-- 
gitgitgadget
