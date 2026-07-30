Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4660343D515
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419922; cv=none; b=fCbHgEA2euxk5K4NIANqhLN4KdOarO0amBe8Edo9tjxsfGZbsZ5jEMoMpnkfkfYjanvZd4uahmdUl9lzDcWxP97nGfn0UZu2jqQpdwrdx2psPqk2oL18Sqf/pl8NvJWT5W4W6jM+5so+B3R7jxIevgR+iPg8qnScb90ZG6ijoy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419922; c=relaxed/simple;
	bh=2+n1AuA6Qa4SMT0wGjk8zgnowf4pgt+nOyEyCFJ+okc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UdhhEW368UrSpCe081ftRlMdL5nYeZ5/Vy0kJEnk+8xRWQ8yezmR3E+o4Yx4GJhF6Ni+kjcDiEiY3v1qUJ1uU0SPctS7j56EizS88eqej1SYX7dFJ9ZciazNcT9Xz52J1T4mv/wTDLyW72nnq+fZsnXWKeTsuIB+Z31AmFMK9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5ygPtKZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5ygPtKZ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so1701470a12.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 06:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419918; x=1786024718; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SWLW5Tk9n/srNCGT4erJ1d5R4LC12emwt6d0WVDvYEo=;
        b=r5ygPtKZzJ8BBqc0qVNnuumWtY1Jwoz/ELzCEA1DkCMZnzOXzuWUYLS+oDV1FwHBUX
         sK5wRMwU7scv+k3pDbXlXhcvpt8uH91HFv4zpSserasmLEXwEiRT8WnOh2pqN+zfaxIX
         6VNNKLXn+lXiDJA9SOUIw4jM1otAfMBUSNAakAnoTIv7HKs+s9FGgQTajF+GrMEt3k9O
         NjX4RjvzUEw9PEbKucVUcFzMDE7mrZr2cYL472qEkwlfApsNZrRFhF0xVK8nTQI7xhXL
         xpVRpBgrVg2hGbzU4HzavezFkCyKEu4X4w+CfPkKWYHWyVUVGILYy2ZOkCfugMJ8bwyS
         +2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419918; x=1786024718;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SWLW5Tk9n/srNCGT4erJ1d5R4LC12emwt6d0WVDvYEo=;
        b=EYfOvOlfyIuxp+fnPwtinkbasO6/OMnhv1Lj4VLMhPEqa52qsVkPsbkNy3HSxtZNoZ
         u7QUBb/7B2qPw8Nv8mGtZrGkeyk3Ff3e92khVwy5Mu6awptohwwTvtF7DNI/4rGjGdfs
         R+8cHZR1HNHgblav482eppohLg+iliK4ogPKnEgSG+hKJ1exq/zYNdzCzD735C7tdoLh
         BWC5askBy3UIs9EEn/IZeMOt4BaXm+yhMYXvBiZsasfgXEKlMyD0ysaB0VlQj8nV31DH
         8ix0VSMr+VEVmS/WNPETr1iftHQaBjiTGr0mhYzjvINb7SAMeAJV19tolBSompl/m7VU
         1uGw==
X-Gm-Message-State: AOJu0Yywf6hxms3mS9z6FMonfPeb4I0oFHZBMaj75hCTR8b/XS6TSlT6
	QJe88196znNdcqUyeVtWnV9eM8QgbuJJBvbvM2qnZyWsYo24nMwKKITxiiBNUA==
X-Gm-Gg: AR+sD10o/WTk9mgAWfFY0fVQGkfJfVgLtgYg5UnbywhHeGKlX+iOM0SO7ZTQ1kHsmlE
	o1mbZvS9t7aYoHlg61LemEjTHXemuNMwENr0MLadOLc0h9qGT9oDgA4ZKN/sT24BzqKFedxzSXp
	+sJ7tPTH4HxP3DF9MW1d5GGk9b3sBgRO9hRN7SHL5lxMjtyTQR6gSj6mRQ8UPwypNvmzBT1lfhe
	FY4nkwFG5nFg4qRc2ek+LtLmmpVYLHZ6pa81wjH0RtwQMe9NWw7+BwoMbAU3eZDTx+a41wn2N80
	8DWudY/ymkSI4ubGEEKje7cfN1kSbINCPHoDH9h44xSrd3V7ArmBOkxJOd058WkQVoPMDg0qUm2
	/MxiwvN/CwxEl251soDmOBougQ9815/yKXYj12Gr5qcmAnF37Tni976iQXY6i+JWhxqds4NgN0L
	PQb7hBnTnphX3fzpuK4PlT6S0Te582lYlLn3kdJKLwgsdpXYOk68L1W0cfWWJUAOy6
X-Received: by 2002:a05:6a21:7118:b0:3bc:5284:5445 with SMTP id adf61e73a8af0-3c90075906fmr2886405637.21.1785419917775;
        Thu, 30 Jul 2026 06:58:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.230.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb7a999ddsm2220826a12.4.2026.07.30.06.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:58:37 -0700 (PDT)
Message-Id: <pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
References: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 13:58:29 +0000
Subject: [PATCH v24 0/7] branch: delete-merged
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
 builtin/branch.c                 | 312 +++++++++++++++++++++---
 ref-filter.c                     |  70 ++++++
 ref-filter.h                     |  10 +
 t/t3200-branch.sh                | 401 +++++++++++++++++++++++++++++++
 6 files changed, 821 insertions(+), 31 deletions(-)


base-commit: 13c7afec212fc97ce257d15601659314c6673d6c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v24
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v24
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v23:

 1:  0c4fe549cb ! 1:  59157142b3 branch: add --forked filter for --list mode
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +'
      +
      +test_expect_success '--forked composes with --no-merged' '
     -+	git -C forked branch --forked "origin/*" --no-merged origin/one \
     -+		--format="%(refname:short)" >actual &&
     ++	git -C forked branch --forked "origin/*" --no-merged origin/one --format="%(refname:short)" >actual &&
      +	echo local-one >expect &&
      +	test_cmp expect actual
      +'
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +'
      +
      +test_expect_success '--forked narrows a <pattern> argument' '
     -+	git -C forked branch --forked "origin/*" "local-*" \
     -+		--format="%(refname:short)" >actual &&
     ++	git -C forked branch --forked "origin/*" "local-*" --format="%(refname:short)" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-one
      +	local-two
 2:  2d20015ba9 ! 2:  5d310da9aa branch: convert delete_branches() to a flags argument
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
      -		int flags = 0;
      +		int ref_flags = 0;
       
     - 		copy_branchname(&bname, argv[i], allowed_interpret);
     - 		free(name);
     + 		copy_branchname(the_repository, &bname,
     + 				argv[i], allowed_interpret);
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
       					     RESOLVE_REF_READING
       					     | RESOLVE_REF_NO_RECURSE
 3:  34b37aeb43 = 3:  263e90f6ed branch: let delete_branches skip unmerged branches on bulk refusal
 4:  606ce4082c = 4:  22e31fd35c branch: prepare delete_branches for a bulk caller
 5:  5fd74f0050 ! 5:  d9f93e66c9 branch: add --delete-merged <branch>
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: add --delete-merged <branch>
     +    branch: add --delete-merged <pattern>
      
     -        git branch (--delete-merged <branch>)... [<pattern>...]
     +        git branch (--delete-merged <pattern>)... [<branch-pattern>...]
      
     -    deletes local branches matching the optional patterns when their
     +    deletes local branches matching the optional branch patterns when their
          configured upstream matches one of the --delete-merged arguments and
          their tip is reachable from that upstream. The work has already landed
          on the upstream they track, so the local copy is no longer needed.
      
     -    The option can be repeated to widen the upstream match. Keeping the
     -    candidate patterns as positional arguments lets users bound the set of
     -    local branches that may be deleted independently of the upstream
     -    selection.
     +    Each <pattern> may name a ref, a remote, or a shell glob. The option can
     +    be repeated to widen the upstream match. Keeping the candidate patterns
     +    as positional arguments lets users bound the set of local branches that
     +    may be deleted independently of the upstream selection.
      
          A branch is not deleted when:
      
            * it is checked out in any worktree
            * its configured upstream ref no longer exists, since a missing
              upstream is not by itself a sign of integration
     -      * pushing it by name to the remote configured by
     -        branch.<name>.remote would update its upstream, as determined by
     -        mapping the branch ref through that remote's fetch refspec. For
     -        example, a local "main" that tracks "origin/main" is kept even when
     -        remote.pushDefault names a fork. Right after a pull it merely looks
     -        fully merged.
     +      * pushing it to the remote configured by branch.<name>.remote would
     +        update its upstream, as determined by that remote's configured push
     +        and fetch refspecs. For example, a local "main" that tracks
     +        "origin/main" is kept even when remote.pushDefault names a fork.
     +        Right after a pull it merely looks fully merged.
     +      * it is the local upstream of a branch that is not being deleted, so
     +        no branch is deleted out from under stacked work.
      
          A branch whose work is not yet merged into its upstream is silently
          skipped, so one unmerged topic does not abort the whole sweep.
      
     -    A branch that a surviving branch depends on through a chain of local
     -    upstreams is also kept, so no branch is deleted out from under stacked
     -    work. Collect this transitive set without changing the candidate set
     -    during ref iteration: walk upstream chains from surviving branches,
     -    visit each branch at most once, and remove the collected bases only
     -    after the iteration completes. This makes the result independent of
     -    ref iteration order without repeated full scans.
     +    Collect protected local upstreams without changing the candidate set
     +    during ref iteration, then remove them after iteration. This makes the
     +    result independent of ref iteration order. If a protected branch's own
     +    upstream is deleted by the same sweep, clear its upstream configuration.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     -+git branch (--delete-merged <branch>)... [<pattern>...]
     ++git branch (--delete-merged <pattern>)... [<branch-pattern>...]
       
       DESCRIPTION
       -----------
     @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mod
       	Print the name of the current branch. In detached `HEAD` state,
       	nothing is printed.
       
     -+`--delete-merged <branch>`::
     ++`--delete-merged <pattern>`::
      +	Delete local branches whose configured upstream matches
     -+	_<branch>_, but only when their tip is reachable from that
     ++	_<pattern>_, but only when their tip is reachable from that
      +	upstream. In other words, the work on the branch has already
      +	landed on the upstream it tracks, so the local copy is no longer
     -+	needed. The option can be repeated to widen the upstream match.
     -+	Optional _<pattern>_ arguments limit which local branches are
     -+	considered, e.g. `git branch --delete-merged 'origin/*'
     ++	needed. _<pattern>_ may name a ref, a remote (using the branch its
     ++	`HEAD` points at), or a shell-style glob. The option can be
     ++	repeated to widen the upstream match.
     ++	Optional _<branch-pattern>_ arguments limit which local branches
     ++	are considered, e.g. `git branch --delete-merged 'origin/*'
      +	'topic-*'`.
      ++
      +A branch is not deleted when:
      ++
      +--
      +* its configured upstream ref no longer exists,
     -+* it is checked out in any worktree, or
     -+* pushing it by name to the remote configured by
     ++* it is checked out in any worktree,
     ++* pushing it to the remote configured by
      +  `branch.<name>.remote` would update its upstream, so it cannot be
     -+  distinguished from a branch that just looks "fully merged" right
     -+  after a pull.
     ++  distinguished from a branch that just looks fully merged right
     ++  after a pull; this is determined by the remote's configured push and
     ++  fetch refspecs,
     ++* it is the local upstream of a branch that is not being deleted.
      +--
      ++
     ++When such a local upstream branch has its own upstream deleted by the
     ++same operation, its upstream configuration is cleared.
     +++
      +A branch whose work has not yet been merged into its upstream is
      +silently skipped. Delete it with `git branch -D` if you want to
      +remove it anyway.
     -++
     -+A branch that a surviving branch depends on through a chain of local
     -+upstreams is kept, so a branch is never deleted out from under stacked
     -+work.
      +
       `-v`::
       `-vv`::
     @@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
       	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
       	N_("git branch [<options>] [-r | -a] [--points-at]"),
       	N_("git branch [<options>] [-r | -a] [--format]"),
     -+	N_("git branch [<options>] (--delete-merged <branch>)... [<pattern>...]"),
     ++	N_("git branch [<options>] (--delete-merged <pattern>)... "
     ++	   "[<branch-pattern>...]"),
       	NULL
       };
       
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +struct stacked_branch_data {
      +	struct strset *deletable_branch_names;
      +	struct strset *protected_branch_names;
     -+	struct strset *visited_branch_names;
      +};
      +
     -+static int collect_stacked_branch_bases(const struct reference *ref,
     -+					void *cb_data)
     ++static int collect_stacked_branch_base(const struct reference *ref,
     ++				       void *cb_data)
      +{
      +	struct stacked_branch_data *data = cb_data;
      +	const char *branch_name;
     ++	struct branch *branch;
     ++	const char *upstream_refname;
     ++	const char *upstream_branch_name;
      +
      +	if (!skip_prefix(ref->name, "refs/heads/", &branch_name))
      +		BUG("expected local branch ref, got '%s'", ref->name);
      +	if (strset_contains(data->deletable_branch_names, branch_name))
      +		return 0;
      +
     -+	while (strset_add(data->visited_branch_names, branch_name)) {
     -+		struct branch *branch = branch_get(branch_name);
     -+		const char *upstream_refname = branch_get_upstream(branch, NULL);
     -+		const char *upstream_branch_name;
     -+
     -+		if (!upstream_refname ||
     -+		    !skip_prefix(upstream_refname, "refs/heads/",
     -+				 &upstream_branch_name) ||
     -+		    !strset_contains(data->deletable_branch_names,
     -+				    upstream_branch_name))
     -+			break;
     -+
     -+		strset_add(data->protected_branch_names, upstream_branch_name);
     -+		branch_name = upstream_branch_name;
     -+	}
     ++	branch = branch_get(branch_name);
     ++	upstream_refname = branch_get_upstream(branch, NULL);
     ++	if (!upstream_refname ||
     ++	    !skip_prefix(upstream_refname, "refs/heads/",
     ++			 &upstream_branch_name) ||
     ++	    !strset_contains(data->deletable_branch_names,
     ++			    upstream_branch_name))
     ++		return 0;
      +
     ++	strset_add(data->protected_branch_names, upstream_branch_name);
      +	return 0;
      +}
      +
      +static void protect_stacked_branch_bases(struct ref_store *refs,
     -+					 struct strset *deletable_branch_names)
     ++					 struct strset *deletable_branch_names,
     ++					 struct strset *protected_branch_names)
      +{
     -+	struct strset protected_branch_names = STRSET_INIT;
     -+	struct strset visited_branch_names = STRSET_INIT;
      +	struct stacked_branch_data data = {
      +		.deletable_branch_names = deletable_branch_names,
     -+		.protected_branch_names = &protected_branch_names,
     -+		.visited_branch_names = &visited_branch_names,
     ++		.protected_branch_names = protected_branch_names,
      +	};
      +	struct refs_for_each_ref_options opts = {
      +		.prefix = "refs/heads/",
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +	struct hashmap_iter iter;
      +	struct strmap_entry *entry;
      +
     -+	refs_for_each_ref_ext(refs, collect_stacked_branch_bases, &data, &opts);
     ++	refs_for_each_ref_ext(refs, collect_stacked_branch_base, &data, &opts);
      +
     -+	strset_for_each_entry(&protected_branch_names, &iter, entry)
     ++	strset_for_each_entry(protected_branch_names, &iter, entry)
      +		strset_remove(deletable_branch_names, entry->key);
     ++}
      +
     -+	strset_clear(&visited_branch_names);
     -+	strset_clear(&protected_branch_names);
     ++static void clear_deleted_upstreams(struct strset *protected_branch_names,
     ++				    struct strset *deletable_branch_names)
     ++{
     ++	struct strbuf key = STRBUF_INIT;
     ++	struct hashmap_iter iter;
     ++	struct strmap_entry *entry;
     ++
     ++	strset_for_each_entry(protected_branch_names, &iter, entry) {
     ++		struct branch *branch = branch_get(entry->key);
     ++		const char *upstream_refname = branch_get_upstream(branch, NULL);
     ++		const char *upstream_branch_name;
     ++
     ++		if (!upstream_refname ||
     ++		    !skip_prefix(upstream_refname, "refs/heads/",
     ++				 &upstream_branch_name) ||
     ++		    !strset_contains(deletable_branch_names,
     ++				    upstream_branch_name))
     ++			continue;
     ++
     ++		strbuf_addf(&key, "branch.%s.merge", branch->name);
     ++		repo_config_set_gently(the_repository, key.buf, NULL);
     ++		strbuf_reset(&key);
     ++		strbuf_addf(&key, "branch.%s.remote", branch->name);
     ++		repo_config_set_gently(the_repository, key.buf, NULL);
     ++		strbuf_reset(&key);
     ++	}
     ++
     ++	strbuf_release(&key);
      +}
      +
      +static int branch_pushes_to_upstream(struct branch *branch,
      +				     const char *upstream)
      +{
      +	struct remote *remote = remote_get(remote_for_branch(branch, NULL));
     ++	char *push_refname = NULL;
      +	char *tracking = NULL;
      +	int ret = 0;
      +
     -+	if (remote)
     -+		tracking = apply_refspecs(&remote->fetch, branch->refname);
     ++	if (!remote)
     ++		return 0;
     ++	if (remote->push.nr)
     ++		push_refname = apply_refspecs(&remote->push, branch->refname);
     ++	else
     ++		push_refname = xstrdup(branch->refname);
     ++	if (push_refname)
     ++		tracking = apply_refspecs(&remote->fetch, push_refname);
      +	if (tracking && !strcmp(tracking, upstream))
      +		ret = 1;
      +
     ++	free(push_refname);
      +	free(tracking);
      +	return ret;
      +}
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +	struct ref_filter filter = REF_FILTER_INIT;
      +	struct ref_array candidates = { 0 };
      +	struct strset deletable_branch_names = STRSET_INIT;
     ++	struct strset protected_branch_names = STRSET_INIT;
      +	struct strvec branches_to_delete = STRVEC_INIT;
      +	struct hashmap_iter iter;
      +	struct strmap_entry *entry;
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +		strset_add(&deletable_branch_names, branch_name);
      +	}
      +
     -+	protect_stacked_branch_bases(refs, &deletable_branch_names);
     ++	protect_stacked_branch_bases(refs, &deletable_branch_names,
     ++				     &protected_branch_names);
      +
      +	strset_for_each_entry(&deletable_branch_names, &iter, entry)
      +		strvec_push(&branches_to_delete, entry->key);
     @@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const ch
      +				      DELETE_BRANCH_NO_HEAD_FALLBACK |
      +				      flags);
      +
     ++	if (!ret)
     ++		clear_deleted_upstreams(&protected_branch_names,
     ++					&deletable_branch_names);
     ++
      +	strvec_clear(&branches_to_delete);
     ++	strset_clear(&protected_branch_names);
      +	strset_clear(&deletable_branch_names);
      +	ref_array_clear(&candidates);
      +	ref_filter_clear(&filter);
     @@ builtin/branch.c: int cmd_branch(int argc,
       		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
       		OPT_BOOL(0, "edit-description", &edit_description,
       			 N_("edit the description for the branch")),
     -+		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("branch"),
     -+			N_("delete merged branches whose upstream matches <branch> (repeatable)"),
     ++		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("pattern"),
     ++			N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
      +			PARSE_OPT_NONEG, parse_opt_strvec),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
       		OPT_MERGED(&filter, N_("print only branches that are merged")),
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +create_merged_branch () {
      +	(
      +		cd repo &&
     -+		git checkout -b "$1" origin/next --track &&
     ++		git checkout -b "$1" --track origin/next &&
      +		git commit --allow-empty -m "$1 work" &&
      +		git push origin "$1:next"
      +	)
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	test_cmp expect actual
      +}
      +
     -+test_expect_success '--delete-merged keeps cloned main without a default push remote' '
     ++test_expect_success '--delete-merged keeps cloned main without explicit push configuration' '
      +	setup_repo_for_delete_merged &&
      +	(
      +		cd repo &&
     ++		test_cmp_config origin branch.main.remote &&
     ++		test_cmp_config refs/heads/main branch.main.merge &&
      +		git checkout --detach &&
      +
      +		git branch --delete-merged */* &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	create_merged_branch merged &&
      +	(
      +		cd repo &&
     -+		git checkout -b unmerged origin/next --track &&
     ++		git checkout -b unmerged --track origin/next &&
      +		git commit --allow-empty -m "unmerged work" &&
     -+		git checkout -b tracks-other other/main --track &&
     ++		git checkout -b tracks-other --track other/main &&
      +		sha=$(git rev-parse --short merged) &&
      +
      +		git branch --delete-merged origin/next merged >actual 2>&1 &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	(
      +		cd repo &&
      +		git config remote.pushDefault fork &&
     -+		git checkout -b local-to-delete main --track &&
     -+		git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
     -+		git branch --set-upstream-to=origin/topic upstream-gone &&
     -+		git update-ref -d refs/remotes/origin/topic &&
     -+		git checkout -b tracks-other other/main --track &&
     ++		git checkout -b local-to-delete --track main &&
     ++		git config branch.upstream-gone.merge refs/heads/topic &&
     ++		git checkout -b tracks-other --track other/main &&
      +		git checkout checked-out &&
      +
     -+		git branch --delete-merged origin/* \
     -+			--delete-merged main &&
     ++		git branch --delete-merged origin/* --delete-merged main &&
      +
      +		check_branches <<-\EOF
      +		checked-out
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	)
      +'
      +
     ++test_expect_success '--delete-merged maps push refspecs to upstreams' '
     ++	setup_repo_for_delete_merged &&
     ++	(
     ++		cd repo &&
     ++		git checkout -b topic &&
     ++		git config remote.origin.push "refs/heads/topic:refs/heads/published" &&
     ++		git push origin &&
     ++		git branch --set-upstream-to=origin/published topic &&
     ++		git checkout -b other-topic --track origin/published &&
     ++		git checkout --detach &&
     ++
     ++		git branch --delete-merged origin/published &&
     ++
     ++		check_branches <<-\EOF
     ++		main
     ++		topic
     ++		EOF
     ++	)
     ++'
     ++
      +test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
      +	setup_repo_for_delete_merged &&
      +	create_merged_branch feature &&
      +	(
      +		cd repo &&
     -+		git checkout -b topic feature --track &&
     ++		git checkout -b topic --track feature &&
      +		git commit --allow-empty -m "topic work" &&
      +
      +		git branch --delete-merged origin/next 2>err &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	)
      +'
      +
     -+test_expect_success '--delete-merged keeps the upstream chain of a surviving branch' '
     ++test_expect_success '--delete-merged clears the deleted upstream of a protected branch' '
      +	setup_repo_for_delete_merged &&
      +	(
      +		cd repo &&
     -+		git config remote.pushDefault fork &&
     -+		git branch lower origin/next --track &&
     -+		git branch mid lower --track &&
     -+		git checkout -b tip mid --track &&
     ++		git branch --track lower origin/next &&
     ++		git branch --track mid lower &&
     ++		git checkout -b tip --track mid &&
      +		git commit --allow-empty -m "tip work" &&
     ++		sha=$(git rev-parse --short lower) &&
      +
     -+		git branch --delete-merged origin/next \
     -+			--delete-merged lower >actual 2>&1 &&
     -+		test_must_be_empty actual &&
     ++		git branch --delete-merged origin/next --delete-merged lower >actual 2>&1 &&
     ++		echo "Deleted branch lower (was $sha)." >expect &&
     ++		test_cmp expect actual &&
      +
      +		check_branches <<-\EOF &&
     -+		lower
      +		main
      +		mid
      +		tip
      +		EOF
      +
     -+		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
     ++		git config --local --get-regexp "branch\\.(mid|tip)\\.(merge|remote)" >actual &&
      +		cat >expect <<-\EOF &&
     -+		branch.lower.remote origin
     -+		branch.lower.merge refs/heads/next
     -+		branch.mid.remote .
     -+		branch.mid.merge refs/heads/lower
      +		branch.tip.remote .
      +		branch.tip.merge refs/heads/mid
      +		EOF
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	setup_repo_for_delete_merged &&
      +	(
      +		cd repo &&
     -+		git branch c-lower origin/next --track &&
     -+		git branch b-mid c-lower --track &&
     -+		git checkout -b a-tip b-mid --track &&
     ++		git branch --track c-lower origin/next &&
     ++		git branch --track b-mid c-lower &&
     ++		git checkout -b a-tip --track b-mid &&
      +		git commit --allow-empty -m "tip work" &&
      +
     -+		git branch --delete-merged origin/next \
     -+			--delete-merged "c-*" &&
     ++		git branch --delete-merged origin/next --delete-merged "c-*" &&
      +
      +		check_branches <<-\EOF &&
      +		a-tip
      +		b-mid
     -+		c-lower
      +		main
      +		EOF
      +
     -+		git branch --delete-merged origin/next \
     -+			--delete-merged "c-*" >actual 2>&1 &&
     ++		git branch --delete-merged origin/next --delete-merged "c-*" >actual 2>&1 &&
      +		test_must_be_empty actual &&
      +
      +		check_branches <<-\EOF
      +		a-tip
      +		b-mid
     -+		c-lower
      +		main
      +		EOF
      +	)
 6:  6494be7c75 ! 6:  aa845096d8 branch: add branch.<name>.deleteMerged opt-out
     @@ Documentation/config/branch.adoc: for details).
      
       ## Documentation/git-branch.adoc ##
      @@ Documentation/git-branch.adoc: A branch is not deleted when:
     - +
     - --
     - * its configured upstream ref no longer exists,
     --* it is checked out in any worktree, or
     -+* it is checked out in any worktree,
     - * pushing it by name to the remote configured by
     -   `branch.<name>.remote` would update its upstream, so it cannot be
     -   distinguished from a branch that just looks "fully merged" right
     --  after a pull.
     -+  after a pull, or
     +   distinguished from a branch that just looks fully merged right
     +   after a pull; this is determined by the remote's configured push and
     +   fetch refspecs,
     +-* it is the local upstream of a branch that is not being deleted.
     ++* it is the local upstream of a branch that is not being deleted, or
      +* `branch.<name>.deleteMerged` is set to `false`.
       --
       +
     - A branch whose work has not yet been merged into its upstream is
     + When such a local upstream branch has its own upstream deleted by the
      
       ## builtin/branch.c ##
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
     - 	struct ref_array candidates = { 0 };
       	struct strset deletable_branch_names = STRSET_INIT;
     + 	struct strset protected_branch_names = STRSET_INIT;
       	struct strvec branches_to_delete = STRVEC_INIT;
      +	struct strbuf key = STRBUF_INIT;
       	struct hashmap_iter iter;
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
       	}
       
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
     - 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
     - 				      flags);
     + 		clear_deleted_upstreams(&protected_branch_names,
     + 					&deletable_branch_names);
       
      +	strbuf_release(&key);
       	strvec_clear(&branches_to_delete);
     + 	strset_clear(&protected_branch_names);
       	strset_clear(&deletable_branch_names);
     - 	ref_array_clear(&candidates);
      
       ## t/t3200-branch.sh ##
      @@ t/t3200-branch.sh: test_expect_success '--delete-merged requires a value' '
 7:  7102c931e2 ! 7:  96ebfd6ec6 branch: add --dry-run for --delete-merged
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     --git branch (--delete-merged <branch>)... [<pattern>...]
     -+git branch [--dry-run] (--delete-merged <branch>)... [<pattern>...]
     +-git branch (--delete-merged <pattern>)... [<branch-pattern>...]
     ++git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-branch.adoc: A branch that a surviving branch depends on through a chain of local
     - upstreams is kept, so a branch is never deleted out from under stacked
     - work.
     +@@ Documentation/git-branch.adoc: A branch whose work has not yet been merged into its upstream is
     + silently skipped. Delete it with `git branch -D` if you want to
     + remove it anyway.
       
      +`--dry-run`::
      +	With `--delete-merged`, print which branches would be
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int ki
       			char *refname = name + branch_name_pos;
       			if (!(flags & DELETE_BRANCH_QUIET))
       				printf(remote_branch
     +@@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
     + 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
     + 				      flags);
     + 
     +-	if (!ret)
     ++	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
     + 		clear_deleted_upstreams(&protected_branch_names,
     + 					&deletable_branch_names);
     + 
      @@ builtin/branch.c: int cmd_branch(int argc,
       	int delete = 0, rename = 0, copy = 0, list = 0,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
     @@ builtin/branch.c: int cmd_branch(int argc,
       	int noncreate_actions = 0;
       	/* possible options */
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("branch"),
     - 			N_("delete merged branches whose upstream matches <branch> (repeatable)"),
     + 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("pattern"),
     + 			N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
       			PARSE_OPT_NONEG, parse_opt_strvec),
      +		OPT_BOOL(0, "dry-run", &dry_run,
      +			N_("with --delete-merged, only print which branches would be deleted")),
     @@ builtin/branch.c: int cmd_branch(int argc,
      
       ## t/t3200-branch.sh ##
      @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected merged branches' '
     - 		git checkout -b tracks-other other/main --track &&
     + 		git checkout -b tracks-other --track other/main &&
       		sha=$(git rev-parse --short merged) &&
       
      +		git branch --dry-run --delete-merged origin/next merged >actual 2>&1 &&
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
       		echo "Deleted branch merged (was $sha)." >expect &&
       		test_cmp expect actual &&
      @@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
     - 		git checkout -b topic feature --track &&
     + 		git checkout -b topic --track feature &&
       		git commit --allow-empty -m "topic work" &&
       
      -		git branch --delete-merged origin/next 2>err &&
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream of a
       		check_branches <<-\EOF &&
       		feature
       		main
     -@@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream chain of a surviving bra
     - 		git checkout -b tip mid --track &&
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged clears the deleted upstream of a protected
       		git commit --allow-empty -m "tip work" &&
     + 		sha=$(git rev-parse --short lower) &&
       
     -+		git branch --dry-run --delete-merged origin/next \
     -+			--delete-merged lower >actual 2>&1 &&
     -+		test_must_be_empty actual &&
     ++		git branch --dry-run --delete-merged origin/next --delete-merged lower >actual 2>&1 &&
     ++		echo "Would delete branch lower (was $sha)." >expect &&
     ++		test_cmp expect actual &&
      +
      +		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
      +		cat >expect <<-\EOF &&
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged keeps the upstream chain
      +		EOF
      +		test_cmp expect actual &&
      +
     - 		git branch --delete-merged origin/next \
     - 			--delete-merged lower >actual 2>&1 &&
     - 		test_must_be_empty actual &&
     + 		git branch --delete-merged origin/next --delete-merged lower >actual 2>&1 &&
     + 		echo "Deleted branch lower (was $sha)." >expect &&
     + 		test_cmp expect actual &&
      @@ t/t3200-branch.sh: test_expect_success "branch -d still deletes a deleteMerged=false branch" '
       	)
       '

-- 
gitgitgadget
