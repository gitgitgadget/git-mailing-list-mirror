Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2E3C3C0E
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697233; cv=none; b=Ap9kRtQdE9Y/q5FUKIoUGTOu1pJiLXji4o4or7AkuCznIQH/zFSp1b+QsZOf4JodB5vIGQLQa7fF9Mtwj0d/anR/L5o0ci3N6gxMLMQxnooLs9qXSwidNWwU1WQwsFoERgsiBINrVZ6LOfB6gmgLp/pWqxaGTnzKEo497zb7J4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697233; c=relaxed/simple;
	bh=WHGarTbkyfS+NkvRP/XHFy7R2Q2cWRyN3umtLGiZUGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIcp1XOUYEbQG6JZS6W16P0Pxr6lFwK2nSjNvG2D2lDP6AIkE0cZETny+WhdOaqENsTSd8DHmNuw1V5+HW4cg0/S5MErLU2ffyWb3AXJC2QaNC/KCG0xQ2DxDOoeJVlJtaO7IwNvRbD15igKZu5isxrF55N8qe6Q1CY7iahq67E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRC+B4mt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRC+B4mt"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493f4638f4aso8209735e9.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783697229; x=1784302029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pW+Da8+M3zSSuENsBz0cGhfVRzbY56kDwcSh+hM8Hj8=;
        b=WRC+B4mtytwmXAmF5LLkXisqDgRDtEOrsJlhkhO96TMZchDN4J1eFOFTlUzWGMyyrT
         Y8c9IG8w5pRhOU5Zqc9PrCX0UcYJ6WcPbsSsTRc3nI4m+fzbBDmlmnqXiHJvz8lOMYs8
         Jf2BMoGApr0ijkTxtQd4knqMTWPYw4pdIyL9EucE7OwQ/vXvxQEB+ynMe7qw7X7Ifj9Q
         iBZJBSOn0uMPdBdT0LG6Caoe/WPCbJytiB6FQqX27qbmFT4IWpFEBXc9rlPxRtK0n2mA
         iiAZNi+RpSfjtbXFDDCdK0q5D6yfInrvVXOpTDmnJnMgv1+Kiq9MejkxuBxUgS6COph6
         r13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783697229; x=1784302029;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pW+Da8+M3zSSuENsBz0cGhfVRzbY56kDwcSh+hM8Hj8=;
        b=og/G78w+P667bldTpsf8WhL94W5cuIZ5uLZvDKZQviHie731YHS3mYnT865ZQh6S+E
         w8eYwES2Un5BjlbCEC4HxASzTdBGtOk+rp5R7ybBdW5bwtRzPd+Ji2N9S0JaALl170DA
         Hya1726pw1OCxMJ3sMd5zyGx/3wNOI4cNBUeEf3Lch2ICUxlfQhNCJmP/3I23VhdG9yp
         7hGicv4QPkaukvs/WCOuiRT6m43rMrS87dOhny71xiOw8v3S/kMtQ6cayCWix2TurZh/
         CyQ1YzQvTNYq4KOZwPlAEDHCtudNQZntRacVhIPckzi+MPyoR81tMPCmXZkJcw8AFSVf
         rbeA==
X-Forwarded-Encrypted: i=1; AHgh+RokrQX18r/ioKGnNczlSBjY46qPWvqTWSbF/cyXRk+HolBfliPfc1dFqTjpLF5tp2DAFSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjhkM2+Ze7I2PI/3cw9Q7x3/sv2iaWGIN5gsBKoAZN8lnePMs
	E/C9D+T+DROYTGlsmaUr5rPXx4NZcfA9hLmv9czqSTaAdEbWeUm+r4Si
X-Gm-Gg: AfdE7cm0mMXjk+C0BQtn17KVfi5aZawsSz3Uwa7TJNSUSiPGcOeX1YX5S3eUNrc18if
	PO4NxsGV6eKs0+W/4iqo57ts+kc3RM97unHQsINu6SMM5yra+LRIkNZzVEgHEi9gWFRr8kIELaz
	YgsPWcHlHr6tiZVr5MYBKbT0ZekXbF/Y1rh3lvCe0z5X380iW66Gz/yZm8oZEblh+PBTx+abQVI
	eujtiazuZ/i1S5/OGGVGJ83waQMJ2UWMV0af0xjdtQ/FuMtaf9lsrtg6KOFdsxsqZKDH4hwJ9HK
	vbRaH8Rm7OFWofrK651eRuXmzcGhhQ8mJ1wnHEeYz35swAs9os1eAGoYSGHKRDi0etbDsmbXx3a
	hieK8fL2GOsFmF2o0/MhGHsVx0T23JmQPyx9y3zTBO5kL6vX5Fh2e6YhZcThogjzJ2tBgJ4crcB
	N6+VDPnWW2v32A4gBBPzNy4o0m2KIgYRYG7cG78h5z2dOdsIngj2Df3tldpOcO8U91vSc=
X-Received: by 2002:a05:600c:6297:b0:493:ee2b:c8c7 with SMTP id 5b1f17b1804b1-493ee2bcb92mr76215115e9.4.1783697228965;
        Fri, 10 Jul 2026 08:27:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e77c2esm48215735e9.2.2026.07.10.08.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:27:07 -0700 (PDT)
Message-ID: <c1ff2ca9-5744-490b-8d40-b40fc3100718@gmail.com>
Date: Fri, 10 Jul 2026 16:26:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v18 0/7] branch: delete-merged
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Harald

I've looked through the first five patches and left a few comments and 
queries. I'll look at the last two at the start of next week so don't 
re-roll just yet, but my all means reply to the comments, especially 
where I've asked questions. So far I like what I've seen.

Thanks

Phillip

On 24/06/2026 22:54, Harald Nordgren via GitGitGadget wrote:
> Delete branches that have already been merged on upstream.
> 
> Changes in v18:
> 
>   * Instead of keeping the whole chain of upstream branches, keep only the
>     ones an unmerged branch still needs. When a kept (merged) branch in turn
>     tracks a branch that is being deleted, clear its now-stale upstream
>     config.
>   * Rework spare_stacked_bases() to record the kept bases and, in a second
>     pass, clear the upstream of any whose own base is going away. Build the
>     to-delete list with strset_for_each_entry() instead of re-walking the
>     candidate array.
> 
> Changes in v17:
> 
>   * Keep a merged branch when another surviving branch still tracks it as its
>     upstream, so --delete-merged no longer deletes a branch out from under
>     one stacked on top of it.
>   * Move the --dry-run and branch.<name>.deleteMerged opt-out fully into
>     their own commits.
> 
> Changes in v16:
> 
>   * Convert delete_merged_branches() to take an unsigned int flags argument
>     instead of separate quiet/dry_run booleans, matching delete_branches()
>   * Reuse the strbuf across the skip-config loop (strbuf_reset per iteration,
>     single strbuf_release after) instead of allocating and freeing it each
>     time
>   * Rewrite the --delete-merged tests as integration tests: branches that
>     land commits upstream, with deletion and the checked-out, upstream-gone,
>     and push-equals-upstream safety cases exercised together in one run and
>     output asserted via test_cmp
>   * Collapse the many per-aspect test repos into a single reused repo set up
>     by a setup_repo_for_delete_merged helper, and rename helpers off the old
>     pm_/prune naming
>   * Nest single-repo setup sequences in ( cd ... ) subshells instead of
>     prefixing every command with -C
> 
> Changes in v15:
> 
>   * Renamed --prune-merged to --delete-merged throughout. Not necessarily
>     final, but something to advance the discussion.
>   * --delete-merged now silently skips not-yet-merged branches instead of
>     warning.
>   * Initialized the delete_branches() flag locals where declared. Only force
>     stays deferred.
>   * delete_branches()/check_branch_commit() doc and code cleanups: redundant
>     branch NULL checks dropped, ref_array candidates = { 0 }, a BUG() for the
>     unreachable non-branch ref, and reworked --delete-merged doc wording.
>   * Broadened the --forked tests (local commits for realism, remote add -f,
>     --forked coverage), renamed the misleading trunk fixture, and replaced
>     the misnamed detached branch with git checkout --detach.
> 
> Changes in v14:
> 
>   * Fixed a git branch -d -r regression (broke t5404/t5505/t5514): the
>     remotes path set a local force but not the DELETE_BRANCH_FORCE bit that
>     check_branch_commit() reads, so it wrongly ran the merge check.
>   * Made flags the single source of truth in delete_branches() so the bit and
>     the derived locals can't disagree.
>   * Works locally, but GitHub CI has problems that are there for other
>     branches too, hopefully not related
>     (https://github.com/git/git/pull/2285).
> 
> Changes in v13:
> 
>   * Reworked --forked into a real ref-filter applied in apply_ref_filter()
>     instead of a post-pass, so non-matching branches are never allocated.
>   * Match exact --forked patterns on full refnames (only globs use the
>     abbreviated upstream), and dropped the old helper machinery, forward
>     declaration, and string_list in favor of a strvec.
>   * Replaced the boolean parameters of
>     delete_branches()/check_branch_commit() with a single unsigned int flags.
>   * --prune-merged now collects candidates via filter_refs() rather than its
>     own branch walk.
>   * --prune-merged now takes its patterns as positional arguments (e.g. git
>     branch --prune-merged origin/main 'feature*') instead of repeating the
>     option.
> 
> Changes in v12:
> 
>   * Reworked --forked from a standalone action into a --list-mode filter.
>   * Switched --forked and --prune-merged to repeatable OPT_STRING_LIST
>     options.
>   * Dropped the bare-remote-name resolution for --forked, the argument is now
>     a ref or a glob.
> 
> Changes in v11:
> 
>   * The flags now take a branch, not a remote. --forked and --prune-merged
>     accept a literal upstream short name like origin/main or a wildmatch
>     pattern like origin/. The old --all-remotes flag is gone, since origin/
>     covers that case.
>   * The prune guard now compares @{push} against @{upstream}. A branch is
>     spared when these are equal. That is the trunk like case, such as local
>     main tracking and pushing to origin/main, where "fully merged to
>     upstream" cannot be told apart from "just pulled". Only branches that
>     push somewhere other than their upstream, typically fork based topics,
>     are candidates. The earlier /HEAD by name guard that the reviewer
>     rejected is gone.
>   * New --dry-run for --prune-merged.
> 
> Changes in v10:
> 
>   * --forked / --prune-merged now take a branch glob instead of a remote name
>     — origin, origin/*, origin/release-- all work. This replaces the
>     remote-only form and subsumes the old --all-remotes flag, which has been
>     dropped.
>   * New --dry-run for --prune-merged.
> 
> Changes in v9:
> 
>   * --force no longer has special meaning with --prune-merged; reachability
>     is always enforced. Use git branch -D to delete an unmerged branch.
>     Matches how git branch's other read/safe actions treat --force.
>   * Synopsis drops [-f]; "not fully merged" hint points at git branch -D.
>   * Dropped the --prune-merged --force tests.
> 
> Changes in v8:
> 
>   * Delete only when the branch's work is actually reachable from its
>     upstream
>   * Skip branches whose upstream is gone (even with --force)
>   * Simplified the internal safety flag to live in one place
> 
> Changes in v7:
> 
>   * --prune-merged now checks if a branch is merged into its own upstream
>     first. If the upstream is gone, it checks against the remote's default
>     branch instead. If neither exists, the branch is refused (use --force to
>     delete anyway).
> 
> Changes in v6:
> 
>   * --prune-merged now measures merged-ness against the remote's default
>     branch instead of the candidate's upstream — so the decision no longer
>     depends on which branch happens to be checked out locally.
>   * delete_branches() / check_branch_commit() gained a per-candidate override
>     that lets a caller substitute a different "what counts as merged"
>     reference (or skip the check). branch -d callers pass NULL and keep their
>     existing semantics.
>   * prune_merged_branches() resolves each candidate's push-remote HEAD and
>     threads it through, so --prune-merged --all-remotes measures each
>     candidate against its own remote rather than a single global reference.
> 
> Changes in v5:
> 
>   * Drop commit 'fetch: add --prune-merged'
> 
> Changes in v4:
> 
>   * Resolve each remote's HEAD and collect the targets into a
>     protected_default_refs set in collect_forked_set.
>   * In prune_merged_branches, skip a candidate when its upstream is a
>     protected default ref and the local branch name matches the default
>     branch's leaf name (so a local main tracking origin/main is spared, but a
>     renamed trunk tracking origin/main is not).
>   * Also skip when the candidate's push ref points at a protected default
>     ref, so a topic branch configured to push to origin/main is never pruned.
>   * Tests: spare the local default branch; only protect by matching leaf name
>     (not by upstream alone); spare a branch whose push ref is the remote
>     default.
> 
> Changes in v3:
> 
>   * s/remote-tracking refs/remote-tracking branches/g
> 
> Changes in v2:
> 
>   * The whole feature moved out of git fetch and into git branch. git fetch
>     --prune-merged now just calls git branch --prune-merged after fetching.
>   * The fetch.pruneLocalBranches and remote..pruneLocalBranches config
>     options are gone, replaced by per-branch opt-out via branch..pruneMerged.
>   * New git branch --forked lists local branches whose upstream lives on the
>     given remote (read-only building block).
>   * New git branch --prune-merged deletes those branches, but only if their
>     tip is reachable from the upstream tracking ref; --force skips that
>     safety check.
>   * New git branch --all-remotes lets --forked/--prune-merged operate across
>     every configured remote at once.
>   * The currently checked-out branch in any worktree is always preserved.
>   * branch..pruneMerged=false lets you exempt a branch (e.g. a long-running
>     topic branch) even with --force; doesn't affect explicit git branch -d.
>   * delete_branches() got a warn_only mode so bulk deletion prints a one-line
>     warning per skipped branch instead of the noisy four-line hint that git
>     branch -d shows.
>   * New section in git-branch docs; git-fetch docs trimmed to just mention
>     --prune-merged.
>   * New tests in t3200-branch.sh for the new branch flags; t5510-fetch.sh
>     shrunk since most logic moved.
> 
> Harald Nordgren (7):
>    branch: add --forked filter for --list mode
>    branch: convert delete_branches() to a flags argument
>    branch: let delete_branches skip unmerged branches on bulk refusal
>    branch: prepare delete_branches for a bulk caller
>    branch: add --delete-merged <branch>
>    branch: add branch.<name>.deleteMerged opt-out
>    branch: add --dry-run for --delete-merged
> 
>   Documentation/config/branch.adoc |   7 +
>   Documentation/git-branch.adoc    |  48 ++++-
>   builtin/branch.c                 | 266 +++++++++++++++++++++---
>   ref-filter.c                     |  70 +++++++
>   ref-filter.h                     |  10 +
>   t/t3200-branch.sh                | 342 +++++++++++++++++++++++++++++++
>   6 files changed, 715 insertions(+), 28 deletions(-)
> 
> 
> base-commit: ab776a62a78576513ee121424adb19597fbb7613
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v18
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v18
> Pull-Request: https://github.com/git/git/pull/2285
> 
> Range-diff vs v17:
> 
>   1:  d8cc17bd7f = 1:  3e29ff17bd branch: add --forked filter for --list mode
>   2:  d14b0403f0 = 2:  cdd4fea4a7 branch: convert delete_branches() to a flags argument
>   3:  ef2719dac3 = 3:  a0fd5b4a6c branch: let delete_branches skip unmerged branches on bulk refusal
>   4:  80518f5d11 = 4:  a56d8fe93e branch: prepare delete_branches for a bulk caller
>   5:  46da7c8140 ! 5:  a84c555d99 branch: add --delete-merged <branch>
>       @@ Commit message
>            upstream. The work has already landed on the upstream they track,
>            so the local copy is no longer needed.
>        
>       -    Three kinds of branches are not deleted:
>       +    A branch is not deleted when:
>        
>       -      * any branch checked out in any worktree
>       -      * any branch whose upstream remote-tracking branch no longer
>       -        exists, since a missing upstream is not by itself a sign of
>       -        integration
>       -      * any branch whose push destination equals its upstream
>       -        (<branch>@{push} is the same as <branch>@{upstream}), such as
>       -        a local "main" that tracks and pushes to "origin/main". Right
>       -        after a pull it just looks "fully merged", so it is kept. Only
>       -        branches that push somewhere other than their upstream,
>       -        typically topics in a fork workflow, are candidates.
>       +      * it is checked out in any worktree
>       +      * its upstream remote-tracking branch no longer exists, since a
>       +        missing upstream is not by itself a sign of integration
>       +      * its push destination equals its upstream (<branch>@{push} is
>       +        the same as <branch>@{upstream}), such as a local "main" that
>       +        tracks and pushes to "origin/main". Right after a pull it just
>       +        looks "fully merged", so it is kept. Only branches that push
>       +        somewhere other than their upstream, typically topics in a fork
>       +        workflow, are candidates.
>        
>            A branch whose work is not yet merged into its upstream is silently
>            skipped, so one unmerged topic does not abort the whole sweep.
>        
>            A branch that another, surviving branch tracks as its upstream is
>            also kept, so a branch is never deleted out from under one stacked
>       -    on top of it. Sparing such a base can in turn protect its own
>       -    upstream, so the check repeats until the set stops changing.
>       +    on top of it. Such a kept branch is itself merged, so when its own
>       +    upstream is being deleted, clear its now-stale upstream config.
>        
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>       @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mod
>        +silently skipped. Delete it with `git branch -D` if you want to
>        +remove it anyway.
>        ++
>       -+A branch that another, surviving branch still tracks as its upstream
>       -+is kept, so a branch is never deleted out from under one stacked on
>       -+top of it.
>       ++A branch that another, surviving branch tracks as its upstream is
>       ++kept, so a branch is never deleted out from under one stacked on top
>       ++of it. If that kept branch in turn tracks a branch that is being
>       ++deleted, its now-stale upstream configuration is cleared.
>        +
>         `-v`::
>         `-vv`::
>       @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
>         	return 0;
>         }
>         
>       -+static int collect_upstream(const struct reference *ref, void *cb_data)
>       -+{
>       -+	struct string_list *upstreams = cb_data;
>       -+	struct branch *branch = branch_get(ref->name);
>       -+	const char *upstream = branch_get_upstream(branch, NULL);
>       ++struct spare_data {
>       ++	struct strset *deletable;
>       ++	struct strset *spared;
>       ++};
>        +
>       -+	string_list_append(upstreams, ref->name)->util =
>       -+		xstrdup_or_null(upstream);
>       ++/*
>       ++ * A surviving branch stacked on a deletion candidate would lose its
>       ++ * upstream, so drop that candidate from the delete set and remember it
>       ++ * in "spared" so its own upstream can be tidied up afterwards.
>       ++ */
>       ++static int spare_stacked_base(const struct reference *ref, void *cb_data)
>       ++{
>       ++	struct spare_data *data = cb_data;
>       ++	struct branch *branch;
>       ++	const char *upstream, *up_short;
>       ++
>       ++	if (strset_contains(data->deletable, ref->name))
>       ++		return 0;
>       ++	branch = branch_get(ref->name);
>       ++	upstream = branch_get_upstream(branch, NULL);
>       ++	if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
>       ++	    !strset_contains(data->deletable, up_short))
>       ++		return 0;
>       ++
>       ++	strset_remove(data->deletable, up_short);
>       ++	strset_add(data->spared, up_short);
>        +	return 0;
>        +}
>        +
>        +/*
>       -+ * Keep any branch that another, surviving branch tracks as its
>       -+ * upstream, so we never delete a branch out from under one stacked on
>       -+ * top of it.  Sparing a branch makes it a survivor whose own upstream
>       -+ * then needs the same protection, so repeat until nothing changes.
>       ++ * Keep any branch that a surviving branch tracks as its upstream, so we
>       ++ * never delete a branch out from under one stacked on top of it.  Such a
>       ++ * base is itself merged, so when its own upstream is also going away
>       ++ * (no surviving branch tracks it), clear the base's now-stale upstream.
>        + */
>        +static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
>        +{
>       -+	struct string_list upstreams = STRING_LIST_INIT_DUP;
>       -+	struct string_list_item *item;
>       -+	bool spared;
>       -+
>       -+	refs_for_each_branch_ref(refs, collect_upstream, &upstreams);
>       -+	do {
>       -+		spared = false;
>       -+		for_each_string_list_item(item, &upstreams) {
>       -+			const char *up = item->util, *up_short;
>       -+
>       -+			if (!up || strset_contains(deletable, item->string))
>       -+				continue;
>       -+			if (!skip_prefix(up, "refs/heads/", &up_short) ||
>       -+			    !strset_contains(deletable, up_short))
>       -+				continue;
>       -+
>       -+			strset_remove(deletable, up_short);
>       -+			spared = true;
>       -+		}
>       -+	} while (spared);
>       -+
>       -+	string_list_clear(&upstreams, 1);
>       ++	struct strset spared = STRSET_INIT;
>       ++	struct spare_data data = { .deletable = deletable, .spared = &spared };
>       ++	struct strbuf key = STRBUF_INIT;
>       ++	struct hashmap_iter iter;
>       ++	struct strmap_entry *entry;
>       ++
>       ++	refs_for_each_branch_ref(refs, spare_stacked_base, &data);
>       ++
>       ++	strset_for_each_entry(&spared, &iter, entry) {
>       ++		struct branch *branch = branch_get(entry->key);
>       ++		const char *upstream = branch_get_upstream(branch, NULL);
>       ++		const char *up_short;
>       ++
>       ++		if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
>       ++		    !strset_contains(deletable, up_short))
>       ++			continue;
>       ++
>       ++		strbuf_reset(&key);
>       ++		strbuf_addf(&key, "branch.%s.merge", branch->name);
>       ++		repo_config_set_gently(the_repository, key.buf, NULL);
>       ++		strbuf_reset(&key);
>       ++		strbuf_addf(&key, "branch.%s.remote", branch->name);
>       ++		repo_config_set_gently(the_repository, key.buf, NULL);
>       ++	}
>       ++
>       ++	strbuf_release(&key);
>       ++	strset_clear(&spared);
>        +}
>        +
>        +static int delete_merged_branches(int argc, const char **argv,
>       @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
>        +	struct ref_array candidates = { 0 };
>        +	struct strset deletable = STRSET_INIT;
>        +	struct strvec to_delete = STRVEC_INIT;
>       ++	struct hashmap_iter iter;
>       ++	struct strmap_entry *entry;
>        +	int i, ret = 0;
>        +
>        +	if (!argc)
>       @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
>        +
>        +	spare_stacked_bases(refs, &deletable);
>        +
>       -+	for (i = 0; i < candidates.nr; i++) {
>       -+		const char *short_name;
>       -+
>       -+		if (skip_prefix(candidates.items[i]->refname, "refs/heads/",
>       -+				&short_name) &&
>       -+		    strset_contains(&deletable, short_name))
>       -+			strvec_push(&to_delete, short_name);
>       -+	}
>       ++	strset_for_each_entry(&deletable, &iter, entry)
>       ++		strvec_push(&to_delete, entry->key);
>        +
>        +	if (to_delete.nr)
>        +		ret = delete_branches(to_delete.nr, to_delete.v,
>       @@ t/t3200-branch.sh: test_expect_success '--forked narrows a <pattern> argument' '
>        +		git checkout --detach
>        +	) &&
>        +
>       ++	git -C repo branch --dry-run --delete-merged origin/next >out &&
>       ++	test_grep ! "feature" out &&
>       ++
>        +	git -C repo branch --delete-merged origin/next 2>err &&
>        +
>        +	test_must_be_empty err &&
>        +	git -C repo rev-parse --verify refs/heads/feature &&
>       -+	git -C repo rev-parse --verify refs/heads/topic
>       ++	git -C repo rev-parse --verify refs/heads/topic &&
>       ++	echo origin/next >expect &&
>       ++	git -C repo rev-parse --abbrev-ref feature@{upstream} >actual &&
>       ++	test_cmp expect actual &&
>       ++	echo feature >expect &&
>       ++	git -C repo rev-parse --abbrev-ref topic@{upstream} >actual &&
>       ++	test_cmp expect actual
>        +'
>        +
>        +test_expect_success '--delete-merged keeps a chain of upstreams of a kept branch' '
>       @@ t/t3200-branch.sh: test_expect_success '--forked narrows a <pattern> argument' '
>        +	EOF
>        +	test_cmp expect actual
>        +'
>       ++
>       ++test_expect_success '--delete-merged clears the upstream of a kept base whose own base is deleted' '
>       ++	test_when_finished "rm -rf repo" &&
>       ++	setup_repo_for_delete_merged &&
>       ++	(
>       ++		cd repo &&
>       ++		git branch lower origin/next &&
>       ++		git branch --set-upstream-to=origin/next lower &&
>       ++		git branch mid origin/next &&
>       ++		git branch --set-upstream-to=lower mid &&
>       ++		git checkout -b tip mid &&
>       ++		git commit --allow-empty -m "tip work" &&
>       ++		git branch --set-upstream-to=mid tip &&
>       ++		git checkout --detach
>       ++	) &&
>       ++
>       ++	git -C repo branch --delete-merged origin/next lower &&
>       ++
>       ++	test_must_fail git -C repo rev-parse --verify refs/heads/lower &&
>       ++	git -C repo rev-parse --verify refs/heads/mid &&
>       ++	test_must_fail git -C repo rev-parse mid@{upstream} &&
>       ++	echo mid >expect &&
>       ++	git -C repo rev-parse --abbrev-ref tip@{upstream} >actual &&
>       ++	test_cmp expect actual
>       ++'
>        +
>         test_done
>   6:  27903fbb1d ! 6:  d52d717b70 branch: add branch.<name>.deleteMerged opt-out
>       @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
>         	struct strset deletable = STRSET_INIT;
>         	struct strvec to_delete = STRVEC_INIT;
>        +	struct strbuf key = STRBUF_INIT;
>       + 	struct hashmap_iter iter;
>       + 	struct strmap_entry *entry;
>        +	bool quiet = flags & DELETE_BRANCH_QUIET;
>         	int i, ret = 0;
>         
>       @@ builtin/branch.c: static int delete_merged_branches(int argc, const char **argv,
>         	ref_array_clear(&candidates);
>        
>         ## t/t3200-branch.sh ##
>       -@@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps a chain of upstreams of a kept branch
>       +@@ t/t3200-branch.sh: test_expect_success '--delete-merged clears the upstream of a kept base whose ow
>         	test_cmp expect actual
>         '
>         
>   7:  49c1bcf1fb ! 7:  8d0323f4b3 branch: add --dry-run for --delete-merged
>       @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
>         
>         DESCRIPTION
>         -----------
>       -@@ Documentation/git-branch.adoc: A branch that another, surviving branch still tracks as its upstream
>       - is kept, so a branch is never deleted out from under one stacked on
>       - top of it.
>       +@@ Documentation/git-branch.adoc: kept, so a branch is never deleted out from under one stacked on top
>       + of it. If that kept branch in turn tracks a branch that is being
>       + deleted, its now-stale upstream configuration is cleared.
>         
>        +`--dry-run`::
>        +	With `--delete-merged`, print which branches would be
> 

