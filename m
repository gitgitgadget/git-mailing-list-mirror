Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23CB38331D
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939898; cv=none; b=OqKcwgJoPkiGUlzk4pG0Zvzz76wjZQJKFDjPOoGOZo1LOMj0y8dJLMh2wqhyzG03/hdGe9cI/4BnnO9OvIMT3qCceMDTlR71K6fFEFugt/U3SZ4oWUE3Oqj2XcRYg1db9d2JANdXFDsBeDYz+XAX7GbjiXBzQc6QhvFzQhVnDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939898; c=relaxed/simple;
	bh=aN64VrR/jCGrV56IwJYtBwxCE+xwKBfAuZfLk53VKYo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fRiZHN59WClTQqbRBBgE0kGdxEUpjUuVXYGK4T9mEOZPt8iaWTnwajZX6hCkKhusjs3Bv0iV8a6iDTeKV1rGwHb6JUdpP5UeEgbA0X8kTVvkQtB7hnyEGlXHriNz67M9QavezHFknUnmtDhok+lzk8s+Hz7XHfZNbHB6tIZ5g3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+im2UFm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+im2UFm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ceaf8a1265so16684955ad.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785939880; x=1786544680; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Izy7stOp6WwWe+Le53cVhQgKVJu3y5pdCvjPGycqHoU=;
        b=j+im2UFmSCXo/RxBjoElPuxZ5Wch57KLbtj/LB6DzORVIkwNq3waD9CuhY5aNDRGHd
         cJzOPCsKqzIQlLA5rZ3mmXr6iN4Yb4DAVrclG4C5RmP5AbBojgjGAOqHyj/TaPyVjTdZ
         cmzWqD2vSAzbMWJeDk93XAqCqt9zUEWFdv6lBvZGVU0zXcpaX8zkiLAMtFyPrkFWrYHE
         vDSeJB3cWs4uuSnkavE5gEAdTQgY2Kfx91J6oW74yi3fBu+moZbn7Ga4VNDOVxFp3NWS
         7/OEX3d6sjXzmxINaqsovKtTdr4mPA4ptQRqz+qUqGyZaAX3JXXLQata1jcYL9e/WGYM
         9Trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939880; x=1786544680;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Izy7stOp6WwWe+Le53cVhQgKVJu3y5pdCvjPGycqHoU=;
        b=WNufWjST0lM21gF5lQDXVbpn4L5BdTqer+PsX2aLN27m3tNQ1TyhKAvNnPkgegzEt7
         X8cfc1Q6Qq85fRFRy4cAVsyQuN68NHjjLQrtAeH046/rjVkhX7PMh1HBJHLZwaXpx1kg
         vcjKmvyWNvEFY8dVyZm3kw2E6jQFfXiOxwmt/4XFWRguTcfMoM8WVJ6yYI8fTcSr3dbS
         MFxBXoUGiOr9O3TI34do4YPxv+gZ8ks2/z3Vxuzk4UmXrT6lgPqp4SWjRMiXJzqJwQRf
         tTxdwEhNt2PIud4kCNpacfqxYvkrvQsPj5S8xtsMOvLVhc6sIcCs/nyDRKt2MSVwwcJc
         nU+w==
X-Gm-Message-State: AOJu0YxuQHRB8xd5AIeeq69GyagZBcVX8v0UXQ69YgjLFyqmANOHFRwj
	qGmYz2VVAO8rbE4s2o6OhLbr5Mb2T+mmLGkD1UVQjvLge0oKjqCczd4ck/aw0A==
X-Gm-Gg: AR+sD13pzONHc6bIMVkxaACbtz9Hln03RI/HOmuYnAviLKLbsjgT+/hnZ2ZtHLzzYNa
	cniAYMyXs6E4iYZQOz5pEnbDTV3v1Ycm1Ed5zyAeNBbZzbmwf/eHCHsJjBQGh4ANvsHgY3Awgoj
	Os+nN3Ty3whdpRi+4tfGqvH+XwZTgmIomMBDLkAuTOScqanerqKDtua7HTT2liRB1C18RhI91NH
	m3qZ82v/aphECvhEhWLjogJYDmKjXAaCZ20ct7Mm6zRW8wlSCB4PMeGc1ljCy43YBn1osROaiwm
	cTvck2xvO8ZamQcwGxdpwL3ew810VDd8tpEG5z9tNTOYasXUx8AAJyMZMUcCRPu9Ly7UVOZ6Uvo
	c2CgFW6q9BPepVzyztkYBUfLnnC6tdoImnQ0angdPXBbXZhzoGc9/hyREQXc7EhI2KNSevn4W+2
	g10fVXeFfEgvLu2JwuygRQP6KFiSE10di0w3tqemdJIDJ3JcVxr2TucMNagkMGaRAWdw==
X-Received: by 2002:a05:6a20:c799:b0:3b4:b276:a789 with SMTP id adf61e73a8af0-3cb86026a16mr9331757637.36.1785939879913;
        Wed, 05 Aug 2026 07:24:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca50ad27sm14637161c88.2.2026.08.05.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:24:38 -0700 (PDT)
Message-Id: <pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:24:30 +0000
Subject: [PATCH v25 0/7] branch: delete-merged
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Delete branches that have already been merged on upstream.

Changes in v25:

 * Wrap long lines in tests.

Changes in v24:

 * Map branches through the configured push and fetch refspecs before
   deciding whether pushing would update their upstream.
 * Protect only the direct upstream of surviving work, delete deeper merged
   bases and clear stale upstream configuration.
 * Clarify that --delete-merged takes upstream patterns in docs.

Changes in v23:

 * Use a loop-local size_t iterator for --forked patterns.
 * Simplify upstream-prefix stripping into an explicit fallback.

Changes in v22:

 * Loop variable int when appropriate to avoid typecast.

Changes in v21:

 * Change loop variables to prevent CI timeout.

Changes in v20:

 * Protect branches transitively required by a surviving local upstream
   stack. Traverse upstream chains once and defer delete-set mutation until
   traversal completes.
 * Make stacked-branch handling independent of ref iteration order and
   update the documentation accordingly.
 * Clarify variable names with regards to branch names (short) to reduce
   confusion.

Changes in v19:

 * Fix bug where dry-run would still remove config, added test coverage.
 * Redesigned --delete-merged as a repeatable upstream selector with
   optional positional patterns limiting deletion scope.
 * Protect same-name upstream branches independently of push-default
   configuration.
 * Simplified flags handling where local caching became complicated when
   mutating values.
 * Clarified assertions in tests.

Changes in v18:

 * Instead of keeping the whole chain of upstream branches, keep only the
   ones an unmerged branch still needs. When a kept (merged) branch in turn
   tracks a branch that is being deleted, clear its now-stale upstream
   config.
 * Rework spare_stacked_bases() to record the kept bases and, in a second
   pass, clear the upstream of any whose own base is going away. Build the
   to-delete list with strset_for_each_entry() instead of re-walking the
   candidate array.

Changes in v17:

 * Keep a merged branch when another surviving branch still tracks it as its
   upstream, so --delete-merged no longer deletes a branch out from under
   one stacked on top of it.
 * Move the --dry-run and branch.<name>.deleteMerged opt-out fully into
   their own commits.

Changes in v16:

 * Convert delete_merged_branches() to take an unsigned int flags argument
   instead of separate quiet/dry_run booleans, matching delete_branches()
 * Reuse the strbuf across the skip-config loop (strbuf_reset per iteration,
   single strbuf_release after) instead of allocating and freeing it each
   time
 * Rewrite the --delete-merged tests as integration tests: branches that
   land commits upstream, with deletion and the checked-out, upstream-gone,
   and push-equals-upstream safety cases exercised together in one run and
   output asserted via test_cmp
 * Collapse the many per-aspect test repos into a single reused repo set up
   by a setup_repo_for_delete_merged helper, and rename helpers off the old
   pm_/prune naming
 * Nest single-repo setup sequences in ( cd ... ) subshells instead of
   prefixing every command with -C

Changes in v15:

 * Renamed --prune-merged to --delete-merged throughout. Not necessarily
   final, but something to advance the discussion.
 * --delete-merged now silently skips not-yet-merged branches instead of
   warning.
 * Initialized the delete_branches() flag locals where declared. Only force
   stays deferred.
 * delete_branches()/check_branch_commit() doc and code cleanups: redundant
   branch NULL checks dropped, ref_array candidates = { 0 }, a BUG() for the
   unreachable non-branch ref, and reworked --delete-merged doc wording.
 * Broadened the --forked tests (local commits for realism, remote add -f,
   --forked coverage), renamed the misleading trunk fixture, and replaced
   the misnamed detached branch with git checkout --detach.

Changes in v14:

 * Fixed a git branch -d -r regression (broke t5404/t5505/t5514): the
   remotes path set a local force but not the DELETE_BRANCH_FORCE bit that
   check_branch_commit() reads, so it wrongly ran the merge check.
 * Made flags the single source of truth in delete_branches() so the bit and
   the derived locals can't disagree.
 * Works locally, but GitHub CI has problems that are there for other
   branches too, hopefully not related
   (https://github.com/git/git/pull/2285).

Changes in v13:

 * Reworked --forked into a real ref-filter applied in apply_ref_filter()
   instead of a post-pass, so non-matching branches are never allocated.
 * Match exact --forked patterns on full refnames (only globs use the
   abbreviated upstream), and dropped the old helper machinery, forward
   declaration, and string_list in favor of a strvec.
 * Replaced the boolean parameters of
   delete_branches()/check_branch_commit() with a single unsigned int flags.
 * --prune-merged now collects candidates via filter_refs() rather than its
   own branch walk.
 * --prune-merged now takes its patterns as positional arguments (e.g. git
   branch --prune-merged origin/main 'feature*') instead of repeating the
   option.

Changes in v12:

 * Reworked --forked from a standalone action into a --list-mode filter.
 * Switched --forked and --prune-merged to repeatable OPT_STRING_LIST
   options.
 * Dropped the bare-remote-name resolution for --forked, the argument is now
   a ref or a glob.

Changes in v11:

 * The flags now take a branch, not a remote. --forked and --prune-merged
   accept a literal upstream short name like origin/main or a wildmatch
   pattern like origin/. The old --all-remotes flag is gone, since origin/
   covers that case.
 * The prune guard now compares @{push} against @{upstream}. A branch is
   spared when these are equal. That is the trunk like case, such as local
   main tracking and pushing to origin/main, where "fully merged to
   upstream" cannot be told apart from "just pulled". Only branches that
   push somewhere other than their upstream, typically fork based topics,
   are candidates. The earlier /HEAD by name guard that the reviewer
   rejected is gone.
 * New --dry-run for --prune-merged.

Changes in v10:

 * --forked / --prune-merged now take a branch glob instead of a remote name
   — origin, origin/*, origin/release-- all work. This replaces the
   remote-only form and subsumes the old --all-remotes flag, which has been
   dropped.
 * New --dry-run for --prune-merged.

Changes in v9:

 * --force no longer has special meaning with --prune-merged; reachability
   is always enforced. Use git branch -D to delete an unmerged branch.
   Matches how git branch's other read/safe actions treat --force.
 * Synopsis drops [-f]; "not fully merged" hint points at git branch -D.
 * Dropped the --prune-merged --force tests.

Changes in v8:

 * Delete only when the branch's work is actually reachable from its
   upstream
 * Skip branches whose upstream is gone (even with --force)
 * Simplified the internal safety flag to live in one place

Changes in v7:

 * --prune-merged now checks if a branch is merged into its own upstream
   first. If the upstream is gone, it checks against the remote's default
   branch instead. If neither exists, the branch is refused (use --force to
   delete anyway).

Changes in v6:

 * --prune-merged now measures merged-ness against the remote's default
   branch instead of the candidate's upstream — so the decision no longer
   depends on which branch happens to be checked out locally.
 * delete_branches() / check_branch_commit() gained a per-candidate override
   that lets a caller substitute a different "what counts as merged"
   reference (or skip the check). branch -d callers pass NULL and keep their
   existing semantics.
 * prune_merged_branches() resolves each candidate's push-remote HEAD and
   threads it through, so --prune-merged --all-remotes measures each
   candidate against its own remote rather than a single global reference.

Changes in v5:

 * Drop commit 'fetch: add --prune-merged'

Changes in v4:

 * Resolve each remote's HEAD and collect the targets into a
   protected_default_refs set in collect_forked_set.
 * In prune_merged_branches, skip a candidate when its upstream is a
   protected default ref and the local branch name matches the default
   branch's leaf name (so a local main tracking origin/main is spared, but a
   renamed trunk tracking origin/main is not).
 * Also skip when the candidate's push ref points at a protected default
   ref, so a topic branch configured to push to origin/main is never pruned.
 * Tests: spare the local default branch; only protect by matching leaf name
   (not by upstream alone); spare a branch whose push ref is the remote
   default.

Changes in v3:

 * s/remote-tracking refs/remote-tracking branches/g

Changes in v2:

 * The whole feature moved out of git fetch and into git branch. git fetch
   --prune-merged now just calls git branch --prune-merged after fetching.
 * The fetch.pruneLocalBranches and remote..pruneLocalBranches config
   options are gone, replaced by per-branch opt-out via branch..pruneMerged.
 * New git branch --forked lists local branches whose upstream lives on the
   given remote (read-only building block).
 * New git branch --prune-merged deletes those branches, but only if their
   tip is reachable from the upstream tracking ref; --force skips that
   safety check.
 * New git branch --all-remotes lets --forked/--prune-merged operate across
   every configured remote at once.
 * The currently checked-out branch in any worktree is always preserved.
 * branch..pruneMerged=false lets you exempt a branch (e.g. a long-running
   topic branch) even with --force; doesn't affect explicit git branch -d.
 * delete_branches() got a warn_only mode so bulk deletion prints a one-line
   warning per skipped branch instead of the noisy four-line hint that git
   branch -d shows.
 * New section in git-branch docs; git-fetch docs trimmed to just mention
   --prune-merged.
 * New tests in t3200-branch.sh for the new branch flags; t5510-fetch.sh
   shrunk since most logic moved.

Harald Nordgren (7):
  branch: add --forked filter for --list mode
  branch: convert delete_branches() to a flags argument
  branch: let delete_branches skip unmerged branches on bulk refusal
  branch: prepare delete_branches for a bulk caller
  branch: add --delete-merged <pattern>
  branch: add branch.<name>.deleteMerged opt-out
  branch: add --dry-run for --delete-merged

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  52 +++-
 builtin/branch.c                 | 312 ++++++++++++++++++++---
 ref-filter.c                     |  70 +++++
 ref-filter.h                     |  10 +
 t/t3200-branch.sh                | 421 +++++++++++++++++++++++++++++++
 6 files changed, 841 insertions(+), 31 deletions(-)


base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v25
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v25
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v24:

 1:  59157142b3 ! 1:  2f8953b339 branch: add --forked filter for --list mode
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +'
      +
      +test_expect_success '--forked <upstream-tracking-branch> filters by upstream' '
     -+	git -C forked branch --forked origin/one --format="%(refname:short)" >actual &&
     ++	git -C forked branch --forked origin/one \
     ++		--format="%(refname:short)" >actual &&
      +	echo local-one >expect &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success '--forked <glob> filters by wildmatch' '
     -+	git -C forked branch --forked "origin/*" --format="%(refname:short)" >actual &&
     ++	git -C forked branch --forked "origin/*" \
     ++		--format="%(refname:short)" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-one
      +	local-two
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +'
      +
      +test_expect_success '--forked <local-branch> matches branches with local upstream' '
     -+	git -C forked branch --forked local-base --format="%(refname:short)" >actual &&
     ++	git -C forked branch --forked local-base \
     ++		--format="%(refname:short)" >actual &&
      +	echo local-onbase >expect &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success '--forked can be repeated to widen the filter' '
     -+	git -C forked branch --forked origin/one --forked other/foreign --format="%(refname:short)" >actual &&
     ++	git -C forked branch --forked origin/one \
     ++		--forked other/foreign \
     ++		--format="%(refname:short)" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-foreign
      +	local-one
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +'
      +
      +test_expect_success '--forked combines literal and glob arguments' '
     -+	git -C forked branch --forked local-base --forked "other/*" --format="%(refname:short)" >actual &&
     ++	git -C forked branch --forked local-base \
     ++		--forked "other/*" \
     ++		--format="%(refname:short)" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-foreign
      +	local-onbase
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +'
      +
      +test_expect_success '--forked "*/*" covers every remote-tracking upstream' '
     -+	git -C forked branch --forked "*/*" --format="%(refname:short)" >actual &&
     ++	git -C forked branch --forked "*/*" \
     ++		--format="%(refname:short)" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-foreign
      +	local-one
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +'
      +
      +test_expect_success '--forked composes with --no-merged' '
     -+	git -C forked branch --forked "origin/*" --no-merged origin/one --format="%(refname:short)" >actual &&
     ++	git -C forked branch --forked "origin/*" \
     ++		--no-merged origin/one \
     ++		--format="%(refname:short)" >actual &&
      +	echo local-one >expect &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success '--forked <remote> uses the branch <remote>/HEAD points at' '
     -+	git -C forked branch --forked origin --format="%(refname:short)" >actual &&
     ++	git -C forked branch --forked origin \
     ++		--format="%(refname:short)" >actual &&
      +	echo main >expect &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success '--forked narrows a <pattern> argument' '
     -+	git -C forked branch --forked "origin/*" "local-*" --format="%(refname:short)" >actual &&
     ++	git -C forked branch --forked "origin/*" "local-*" \
     ++		--format="%(refname:short)" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-one
      +	local-two
 2:  5d310da9aa = 2:  2e80fc3791 branch: convert delete_branches() to a flags argument
 3:  263e90f6ed = 3:  4ab81f0b0a branch: let delete_branches skip unmerged branches on bulk refusal
 4:  22e31fd35c = 4:  83cc3fd6a5 branch: prepare delete_branches for a bulk caller
 5:  d9f93e66c9 ! 5:  a5ef60a394 branch: add --delete-merged <pattern>
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	(
      +		cd repo &&
      +		git checkout -b topic &&
     -+		git config remote.origin.push "refs/heads/topic:refs/heads/published" &&
     ++		git config remote.origin.push \
     ++			"refs/heads/topic:refs/heads/published" &&
      +		git push origin &&
      +		git branch --set-upstream-to=origin/published topic &&
      +		git checkout -b other-topic --track origin/published &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +		topic
      +		EOF
      +
     -+		git config --local --get-regexp "branch\\.(feature|topic)\\.(merge|remote)" >actual &&
     ++		pattern="branch\\.(feature|topic)\\.(merge|remote)" &&
     ++		git config --local --get-regexp "$pattern" >actual &&
      +		cat >expect <<-\EOF &&
      +		branch.feature.remote origin
      +		branch.feature.merge refs/heads/next
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +		git commit --allow-empty -m "tip work" &&
      +		sha=$(git rev-parse --short lower) &&
      +
     -+		git branch --delete-merged origin/next --delete-merged lower >actual 2>&1 &&
     ++		git branch --delete-merged origin/next \
     ++			--delete-merged lower >actual 2>&1 &&
      +		echo "Deleted branch lower (was $sha)." >expect &&
      +		test_cmp expect actual &&
      +
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +		tip
      +		EOF
      +
     -+		git config --local --get-regexp "branch\\.(mid|tip)\\.(merge|remote)" >actual &&
     ++		pattern="branch\\.(mid|tip)\\.(merge|remote)" &&
     ++		git config --local --get-regexp "$pattern" >actual &&
      +		cat >expect <<-\EOF &&
      +		branch.tip.remote .
      +		branch.tip.merge refs/heads/mid
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +		main
      +		EOF
      +
     -+		git branch --delete-merged origin/next --delete-merged "c-*" >actual 2>&1 &&
     ++		git branch --delete-merged origin/next \
     ++			--delete-merged "c-*" >actual 2>&1 &&
      +		test_must_be_empty actual &&
      +
      +		check_branches <<-\EOF
 6:  aa845096d8 = 6:  c2d1fdebe8 branch: add branch.<name>.deleteMerged opt-out
 7:  96ebfd6ec6 ! 7:  5a936bcb93 branch: add --dry-run for --delete-merged
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
       		git checkout -b tracks-other --track other/main &&
       		sha=$(git rev-parse --short merged) &&
       
     -+		git branch --dry-run --delete-merged origin/next merged >actual 2>&1 &&
     ++		git branch --dry-run --delete-merged origin/next merged \
     ++			>actual 2>&1 &&
      +		echo "Would delete branch merged (was $sha)." >expect &&
      +		test_cmp expect actual &&
      +		git rev-parse --verify refs/heads/merged &&
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged clears the deleted upstr
       		git commit --allow-empty -m "tip work" &&
       		sha=$(git rev-parse --short lower) &&
       
     -+		git branch --dry-run --delete-merged origin/next --delete-merged lower >actual 2>&1 &&
     ++		git branch --dry-run --delete-merged origin/next \
     ++			--delete-merged lower >actual 2>&1 &&
      +		echo "Would delete branch lower (was $sha)." >expect &&
      +		test_cmp expect actual &&
      +
     -+		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
     ++		pattern="branch\\.(lower|mid|tip)\\.(merge|remote)" &&
     ++		git config --local --get-regexp "$pattern" >actual &&
      +		cat >expect <<-\EOF &&
      +		branch.lower.remote origin
      +		branch.lower.merge refs/heads/next
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged clears the deleted upstr
      +		EOF
      +		test_cmp expect actual &&
      +
     - 		git branch --delete-merged origin/next --delete-merged lower >actual 2>&1 &&
     + 		git branch --delete-merged origin/next \
     + 			--delete-merged lower >actual 2>&1 &&
       		echo "Deleted branch lower (was $sha)." >expect &&
     - 		test_cmp expect actual &&
      @@ t/t3200-branch.sh: test_expect_success "branch -d still deletes a deleteMerged=false branch" '
       	)
       '

-- 
gitgitgadget
