Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3E44248B7
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889382; cv=none; b=H5bjv0h/6N0pHh0PiD1uhMLb9zmGbUUQDe3H7oeQbjje74KU+WUArB1IZGUj8xLZYTzmuQDn7upa+38rN//ialYjZTnAttoRMXgyr9pBw6U6SGOapfp+452hxvxW8unfa/b1JPSvAnBnBilhp+QA7IQ2U5m8QNTPrM9fUHIXnLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889382; c=relaxed/simple;
	bh=01rfNUVgqcCQQDA8H3CtswwnDfNaKh1jxCAApHjhZr8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Pbtm0+hNRc/INfjXbR66aPHOtjXBbYn1760OC2X3l/gEd2hoUx2w5HGKbXaWJdXFwNG7cgrRAQRAHsMzmqEKkdoEIRAlm7tA4jlt3BjbluIeeVYFMIQZWjD/CLHuOzkj5p+HhOkiMMjP/TqiLKl8kj+nSkXyJ3B89M5SMr/ni4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CliyRLaJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CliyRLaJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cae1a3a744so2034195ad.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889380; x=1785494180; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KdYuNETfXUzpH4YRvHk8tlOuXQjoQ+BkdqLwUk44Za0=;
        b=CliyRLaJfPhq1I7pMcRPPvgnpfum5SjXB2MBTCKpRYV6CpMLXNLEUjwEzy6XAo8U12
         LIUgmx3u3nN0idyXkrnG8NoD4CrpEwyM21Je9B22+AIlchIlg31kb7lo2jkW3piRVtJc
         q+MiqXTJq2MZEhseun0/R8HhX6gCYQXdtDf9AXMzR9ADQ6rJhYOrpxOpJ05tmvZbozWI
         qMgjvkmJAkZsMsCYzltcrUNb6/kpRKfW3ltY19QAc/7juqG0zvFkOGs1VeK/IaPXFfBo
         IE79+I8A0QW+6G8vksi/En2BG8h6EZ3fbDBDbCAv72/mx5Lv/e59qkVq/s5qGHJQXnnI
         xVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889380; x=1785494180;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KdYuNETfXUzpH4YRvHk8tlOuXQjoQ+BkdqLwUk44Za0=;
        b=NvJBk7xyD3ZCwC1BrJRzdEEmF0yU6kz3acZlFSZWPz8QdmLfihNuDoM5rBHkpQQZdv
         iJv/CsMqk2hB8zBD0OEFuork5Aqv4ANwUsNViqWO4p9e7lf6MOfCPD/NBcZqoKXUYuu5
         pvPscoe6f4peSFHS5z7z8yg3Iho0c9WogLO8c10IXLmkaKDp8wDMRRs0zNnJevxrwa/b
         E1yTGAN6bJKeno/s4TAJ0wm+UWGXzT834/r+6wskIoYHyXZr9rfvaqqy3zK/OaemN59x
         g5vjghHjg2qJDlG3zG4JS4jMx25Of5aGUK2thEnrosgi271bfDwKFEDSWaB1GD8TNuVx
         3+YQ==
X-Gm-Message-State: AOJu0YyBEZNh5gEUSHwopB2pWZL7F8U0IAzSqBRENzbMxQcTariEOdGB
	3f99A64r5JQz4EvHOuz/+U6t/KoRfdjIjlBEuZ3XtBbeUMcOzgBBmxSsGI4/pg==
X-Gm-Gg: AR+sD10916GG/7iXhJ5gsGQdy+XMkJu8orhGDlUvxThsUjM+qjmR3rXSisyVXTb5jQR
	urg1k4p15/gYus3dEQ6ZNTkxvjB/DZQkWc/JvTpF4Iham+qnnJ7sMb+cUyljHFeWIbe6TEwcvgM
	4VRangDcQpf2pMVa6kk2U1iHvKmhKMHm//S1gY5xAjnWY9+w4do9fMQpqLDICTlw6zxQtEG0lLu
	bbfYyt3/9JJ/DWuR/PZSvgeMmVbKukUIFX7j8J0/HgpX6ESe0Nyiuthyejx3vgwuQaotQbGEDQA
	DqmqLIKU7N72a3M8bddOAMOFolpGTXsSPl+CG5O+M/XVUtBLzwkUQHkrnHsIAS8XrRMUHYb/xB3
	f0LRCvl7uUlTpM6OUhyUt/5DC9z8VvnVSU/aO3jeTrQnJiAdvxs+Fji4FSJ5Hwv3ULPstyu1A0v
	JgNpkqcBX36fF2DUtx
X-Received: by 2002:a17:903:1a6f:b0:2cc:9a86:9c42 with SMTP id d9443c01a7336-2cfa753472fmr75111965ad.45.1784889379484;
        Fri, 24 Jul 2026 03:36:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.128.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f38757esm48755775ad.75.2026.07.24.03.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:36:18 -0700 (PDT)
Message-Id: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
References: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 10:36:10 +0000
Subject: [PATCH v21 0/7] branch: delete-merged
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
  branch: add --delete-merged <branch>
  branch: add branch.<name>.deleteMerged opt-out
  branch: add --dry-run for --delete-merged

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  49 +++-
 builtin/branch.c                 | 275 ++++++++++++++++++---
 ref-filter.c                     |  70 ++++++
 ref-filter.h                     |  10 +
 t/t3200-branch.sh                | 393 +++++++++++++++++++++++++++++++
 6 files changed, 773 insertions(+), 31 deletions(-)


base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v21
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v21
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v20:

 1:  51c1c9d075 = 1:  90aa528bef branch: add --forked filter for --list mode
 2:  711574b2e5 = 2:  048c002cb4 branch: convert delete_branches() to a flags argument
 3:  47c5975dc7 = 3:  bb93303df3 branch: let delete_branches skip unmerged branches on bulk refusal
 4:  46268acec5 = 4:  e70e64c866 branch: prepare delete_branches for a bulk caller
 5:  ef9f57e735 ! 5:  598e68751e branch: add --delete-merged <branch>
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +	struct strvec branches_to_delete = STRVEC_INIT;
      +	struct hashmap_iter iter;
      +	struct strmap_entry *entry;
     -+	size_t i;
      +	int ret = 0;
      +
     -+	for (i = 0; i < upstreams->nr; i++)
     ++	for (size_t i = 0; i < upstreams->nr; i++)
      +		if (ref_filter_forked_add(&filter, upstreams->v[i]) < 0)
      +			die(_("'%s' is not a valid branch or pattern"),
      +			    upstreams->v[i]);
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +	filter.name_patterns = argv;
      +	filter_refs(&candidates, &filter, filter.kind);
      +
     -+	for (i = 0; i < (size_t)candidates.nr; i++) {
     ++	for (size_t i = 0; i < (size_t)candidates.nr; i++) {
      +		const char *branch_refname = candidates.items[i]->refname;
      +		const char *branch_name;
      +		struct branch *branch;
 6:  fa70108611 ! 6:  ac63689d8a branch: add branch.<name>.deleteMerged opt-out
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
      +	struct strbuf key = STRBUF_INIT;
       	struct hashmap_iter iter;
       	struct strmap_entry *entry;
     - 	size_t i;
     + 	int ret = 0;
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       		const char *branch_name;
       		struct branch *branch;
 7:  13bac431a3 = 7:  73c3281b6f branch: add --dry-run for --delete-merged

-- 
gitgitgadget
