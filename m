Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0022907
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733286810; cv=none; b=UG7Xzv/if2bcrsC85o7gWqBBMTu0l2N4C0egKa+st+jGxYzN1tRs06u4+rr1tUc8x4fb63WWSv5ZU8qkrc1W+h1emvajA55rUBM792/eH+2aGSlFcFhLr0Z3I8ZW/RlKwnCzRcSPN46FjPvQN77vMKSRC3kIYsM1AwH+Hj42RlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733286810; c=relaxed/simple;
	bh=Ut3Tl99jPpABaCfYlgpe4Vo0xrFLP9m+PjKWGzTT7/s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lI8YfMhCkpu7e50H5Wy0+06GSiDTR3wYaHHmyCuR2mF12H8OsxaE5FxWLOf+vpYyRZ/jt6KnrUxw1QFbWvjAsnj9Jv6Yy4azbTmiukEdj8QHviuRf0v7cizDAe0PKDY7NbMJDebk/5A5qaAVOiQu9ffsyKWTwFx1JK5vr9RCM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0wbJwyQ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0wbJwyQ"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-841a9366b08so206515339f.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 20:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733286807; x=1733891607; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y9H1zWBHcmQVXbYcDLt3Ou8H4yyWFtwIvfykwv+WABY=;
        b=g0wbJwyQcZPLN3X6g36SukmXVL09hJiC6x0Zs8bZk2v1frcMloo//aZ0QJd8XqiFL6
         M2yjvQDmMjiWfDfHG2Pfuc7fALrswVK2/JBQMC1+DhH/sbCEk8dYsCDFJsRKrh+bqQKt
         7Te9bLIxpsg2/eqFv48l0S2hpiVvZZywRzmEsYVVmgoHE86xvRi2+sayWkxLIvU1ZZa2
         C8ay+2nQJdT/DQyFqhiu1nrHHluuj+uFDN81KzzQbsls5/UXr1MzhR7QavyBstmDiQLo
         4lzfncESIrmyxEZQSZprJBqUlzXH8u250pcZKgB9gg79E8glroEvBjrbwGGr1EJuYCIE
         siuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733286807; x=1733891607;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9H1zWBHcmQVXbYcDLt3Ou8H4yyWFtwIvfykwv+WABY=;
        b=MuyBQbYskbVJbuoEDyBN/knvd+j/ew6hg1yFqqAjnSWcvaDx676TYNSY7EaH1ejg5j
         E+yaqHrf4k7pFgAUl/1LyR6bdtYcHe1xpMojQkS8rgzQngayRwpUyJPLMVbtBKmpI+5M
         xBQQAl8GWowdnqXSWLqW/z/QPRn0g94ADtCQQxoq6aQdaZYOu+E0fE1DS5ZuM+XSg0Z6
         k7AruvodQuJy5eUs/6KYMOT4GwnoeXujCBvJOUc45j5j+nEviyzAKU/GReGv6SQTyF0U
         WiXp+u/y/75T84Z0W7b+q1HE59tf1FHE+kjmuVGKaE61afchiuS2dU37Bdw+6MO3XTmC
         LiEw==
X-Gm-Message-State: AOJu0Yw2LXw9a2coDqsWFghWTT8qAGBqVknQtIAy7w5EKmFJdz9VZUOM
	FfaaYSOXbvNOwfYBGMhzFLWUqb0WQxOdYFyRIvIQaQVRsUp6UFU9QhUNwHw+ZkY4yTSfcHgRiWp
	AiwMoNjRlZNCB4ScZYV3ppA9PP73T0Ayx
X-Gm-Gg: ASbGncuwhpMAETAe/A8F+wrnvBbMpsYTiD1yS86oKGGD1p/JjsT2luUSaoPtw1el76l
	lAlCyzgE/OAvxoyv3XUIZ4SaUizbdPcKkZERoD6dqpu7EwQ==
X-Google-Smtp-Source: AGHT+IGGsVLpUysPudpVCXxk2nnyLQCsiBgFxdxQfGqE3ziyeF2VPiy+rAHsytbTw2uHUERPG65uq3TonkDtbBXdVgo=
X-Received: by 2002:a05:6602:1694:b0:83a:aa8e:5f72 with SMTP id
 ca18e2360f4ac-8445b55af77mr726285539f.4.1733286806725; Tue, 03 Dec 2024
 20:33:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Elijah Newren <newren@gmail.com>
Date: Tue, 3 Dec 2024 20:33:15 -0800
Message-ID: <CABPp-BEEZdcdmtVFXSNnJ1NF+idyY_Npqxg+9Zv2ns+YDYuO_w@mail.gmail.com>
Subject: [ANNOUNCE] git-filter-repo 2.47.0
To: Git Mailing List <git@vger.kernel.org>, git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

I am pleased to announce the release of git-filter-repo v2.47.0.

git filter-repo is a versatile tool for rewriting git repository
history.  The public repo of filter-repo is at

    https://github.com/newren/git-filter-repo

The tarballs can be found at:

    https://github.com/newren/git-filter-repo/releases

git-filter-repo can also be installed via a variety of package managers
across Windows, Mac OS, or Linux (and maybe others)[1].

[1] https://github.com/newren/git-filter-repo/blob/master/INSTALL.md

This is the biggest release of git-filter-repo (and by a significant
margin), excluding its first release.  It is comprised of 81 non-merge
commits since v2.45.0, including six commits from five new
contributors:

  * Aaron Cooper
  * David Linke
  * Lars Schneider
  * Sebastian Andrzej Siewior
  * Vladislav Javadov

----------------------------------------------------------------------

git-filter-repo 2.47 Release Notes
==================================

Given that this is such a big release, I thought I'd provide a highlight
of the highlights:

  * Multiple bug fixes, including a few longstanding issues
  * Several usability improvements to reduce confusion in special cases
  * New --file-info-callback for operating on combination of filename &
    file contents & file mode
  * New --sensitive-data-removal flag, to assist users trying to remove
    sensitive data from a repository and all its clones
  * Rewriting stashes with the rest of the repository history
  * New collection of example filterings based on user-filed issues

Full list of user-visible changes:

(Note: numeric references refer to GitHub issue IDs at
https://github.com/newren/git-filter-repo/issues/)

* Backward compatibility
  * Bump python requirement to 3.6
  * By default, do not create new replace references *and* consume the ones
    that exist.  Use the --replace-refs option to change this, if wanted.
    (#235)

* Fixes:
  * We have always bypassed fresh-clone safety checks if the user runs
    git-filter-repo again.  However, if the
    $GIT_DIR/filter-repo/already_ran file is really old, that may
    suggest they have forgotten their previous rewrite.  If the file is
    older than a day, prompt users for whether to consider this rewrite
    a continuation of their previous one.
  * Fix gnarly but rare corner case bug in tracking the combination of
    pruned and inserted commits that could mess up rewrites, which could
    e.g. cause a crash by making a commit think its ancestor was a
    commit that does not exist)
  * Skip over unexpected git-catfile output in --analyze mode for weird
    (and possibly corrupted?) largo monorepos, so that --analyze can
    complete (#602)
  * Handle origin refs without an origin remote, for git-svn users (#171)
  * Fix rare but problematic pruning of degenerate "evil" merges that
    should not be pruned, and which caused some files to not be deleted
    or not be introduced as expected (#261, #174, #313)
  * Don't die if a repo uses refnames that look like git-describe output
    and those refnames are pruned as part of the rewrite (#261)
  * [insert-beginning contrib script] Add some sanity checks on the
    passed filename (#260)
  * Allow --path-rename arguments before --path arguments; don't require
    them to always come after (#142, #182, #504)

* Features
  * add --no-gc option (#531)
  * Rewrite the stash too, for all those users who insist on not making
    a fresh clone (#115)
  * add a --file-info-callback, allowing users to operate on the combination
    of filename and file contents and file mode (addresses usecases such as
    #74, #345, #464, #468, #509, #549, #597, and others; also kind of
    obsoletes the lint-history contrib script)
  * add tracking of First Changed Commit(s), meaning commits that were
    rewritten whose parents were not rewritten, and write to
    $GIT_DIR/filter-repo/first-changed-commits
  * add recording of changed references, written to
    $GIT_DIR/filter-repo/changed-refs
  * add a --sensitive-data-removal flag/mode, to assist users trying to
    expunge sensitive data from their repository.  This includes:
      * automatically fetching refs other than branches and tags in case
        those also reference the sensitive data (clone by default only fetches
branches and tags)
      * not removing the origin remote, since users need to force push
        back to it
      * track and report on first changed commit(s), so that it can be
        provided to others who need to expunge it from their clones or their
git server
      * track whether and which LFS objects were orphaned by the rewrite, so
        that LFS objects with sensitive data can also be deleted/purged from
the LFS server
      * assistance in terms of next steps needed to ensure the sensitive data
        is removed from other copies, including the force push command that
should be run

* Usability -- improved notifications
  * Provide warnings about filterability on subpar filesystems, e.g. when
    refs differ in case only and doing filtering on a case-insensitive
    filesystem (#48, #156, #325, #512, #566, #572)
  * Notify users when we remove the origin remote
  * Notice and signal if cleanup commands fail (#121)

* Usability:
  * Avoid the need to specify --force with git-replace, so we can more
    universally recommend against the use of --force (#165)
  * Prevent __pycache__ entry made by running git-filter-repo from triggering
    the not-a-frash-clone-check (#522)
  * Update commit-map and ref-map files (under $GIT_DIR/filter-repo) instead of
    overwriting.  (See also under "Fixes" above about an "already_ran" file
    that is older than a day.)
    * Also, output commit-map and ref-map files in predictable orders

* Documentation:
  * Add a new and very detailed "Sensitive Data Removal" subsection in
    the manual to cover the many special considerations facing folks who
    need to try to remove sensitive data from a git repository and its
    clones.
  * Add a new large collection of example filterings based on user-filed
    issues
  * Add a new Frequently Answered Questions document
  * fix some misleading statements
  * clarify the purpose of the --tag-callback (#591)
  * clarify docs for to-subdirectory-filter (#605)
  * note additional default capabilities
  * mention pipx as an alternative in installation instructions (#487)

* Miscellaneous:
  * Make testsuite work when running a version of git built against zlib-ng
  * Make ref deletion output easier to scan through with --debug



Full list of changes since v2.45.0 are as follows:

Aaron Cooper (1):
      Reword to-subdirectory-filter help

David Linke (2):
      INSTALL.md: Mention pypi / pipx as install option
      INSTALL.md: fix typo

Lars Schneider (1):
      filter-repo: skip over unexpected git-catfile output

Sebastian Andrzej Siewior (1):
      t9394: Mask compressed size for comparison.

Vladislav Javadov (1):
      filter-repo: add --no-gc option

Elijah Newren (75):
      Makefile: pypi overhauled their authentication stuff; update note
      t9390: in sanity check tests, put temporaries outside test repo
      filter-repo: fix misleading help message for --replace-message
      filter-repo: add --proceed option to bypass no-args-specified check
      filter-repo: Do not require --force when using git-replace
      filter-repo: change the --replace-refs default to 'delete-no-add'
      Bump python requirement to 3.6
      filter-repo: notify users when we remove the origin remote
      filter-repo: rewrite the stash too
      filter-repo: avoid calling `git config` multiple times
      filter-repo: provide warnings about filterability on subpar filesystems
      filter-repo: notice and signal when cleanup commands fail
      filter-repo: handle origin refs without origin remote
      t9390: skip the version test if we are in some kind of installation
      filter-repo: ignore __pycache__ untracked files for fresh clone check
      filter-repo: clarify the purpose of the --tag-callback
      pyproject.toml: mark filter-repo stable
      git-filter-repo.txt: note additional default capabilities
      git-filter-repo.txt: remove case specific explanation of commit-map file
      git-filter-repo.txt: correct location of metadata files
      filter-repo: make debug ref deletion output easier to scan through
      filter-repo: add some clarifying comments about the purpose of
the _IDs class
      filter-repo: explain data structures in AncestryGraph
      filter-repo: fix gnarly bug in _IDs.record_rename
      filter-repo: allow tracking commit hashes in AncestryGraph
      filter-repo: fix bug in _IDs.__str__()
      filter-repo: remove/rename ID_TO_HASH and HASH_TO_ID
      filter-repo: fix some unfortunate local variable names
      filter-repo: extract part of _record_metadata into a new function
      t9390: add disgusting hack to --analyze test so it works with zlib-ng
      filter-repo: only conditionally heed the already_ran file
      filter-repo: output commit-map and ref-map in predictable orders
      t9390: add a new test demonstrating problems with pruning of merges
      filter-repo: update commit-map metadata file instead of overwriting
      filter-repo: make purpose of trim_extra_parents clearer
      filter-repo: start tracking new_id -> new_hash mapping as well
      filter-repo: rename old_1st_parent -> prev_1st_parent
      filter-repo: add a new _remap_to() convenience function
      filter-repo: add explanatory note for complicated condition
      filter-repo: add a new get_parent_hashes() convenience function
      filter-repo: update ref-map metadata file instead of overwriting
      filter-repo: fix corner case involving bad pruning of evil
degenerate merge
      filter-repo: add tracking and recording of first changed commit(s)
      filter-repo: limit searches for ref values to actual refs
      filter-repo: avoid shadowing built-in names
      filter-repo: determine files modified by callbacks *after* callbacks
      t: restructure tests a bit
      t9394: prefer 'python3' to 'python'
      filter-repo: avoid parsing already_ran file multiple times
      docs: correct a couple items in explanation of ref-map file
      filter-repo: more thorough stash rewriting
      filter-repo: add a --file-info-callback
      git-filter-repo.txt: tweak the quoting
      filter-repo: add --sensitive-data-removal flag
      filter-repo: add special handling of origin for sensitive data removal
      git-filter-repo.txt: add Sensitive Data Removal subsection
      filter-repo: allow users to override automatic fetch forcing in --sdr
      filter-repo: handle locally modified refs vs. automatic fetch of --sdr
      t9393: add testcases for tracking orphaning of lfs objects
      filter-repo: send blobs through RepoFilter._insert_into_stream()
      filter-repo: add LFSObjectTracker class
      filter-repo: set up data structures to track LFS objects
      filter-repo: add necessary blob and commit investigation of LFS objects
      filter-repo: report on and record LFS objects we find
      filter-repo: for multi-run invocations, update LFS tracking information
      filter-repo: handle LFS orphan tracking with partial history rewrites
      git-filter-repo.txt: add details about orphaning of LFS objects
      filter-repo: help users complete sensitive data removal; show next steps
      filter-repo: provide a changed-refs metadata file as well
      insert-beginning: add some sanity checking on the passed filename
      examples-from-user-filed-issues.md: new collection of example filterings
      filter-repo: also allow --path-rename arguments before --path arguments
      FAQ.md: new file with frequently answered questions
      INSTALL.md, README.md: make installation instructions less "sassy"
      README.md: record latest git commits in support of git-filter-repo
