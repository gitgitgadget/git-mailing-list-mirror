Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512CE54763
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966592; cv=none; b=AB7F0u20eEPC/4ZP2ulh8/Gvk+jZbh/3SFPm/vk6u/TVPT5Og4AJpYuPjDrj/8pj0+fGI/kKiKEN7OvpamXLnz5ZCLXowQqHv+IfYuu80P3lMA02JElkL/jT6fwP4VvBb3EndTtmVg4juqyxmTuHWnvvA74P9do3cDzAifYhyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966592; c=relaxed/simple;
	bh=WsMXtzGTcYJBdS53qXYUNNGu/nLd0PVIVMX3hPRg2EE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kgMHIiYACCOqZus19C9le90KUB9vx2nvujhDsiOsNA+AOBE3BedrZB59NzXFSPgnJ/CBjXw3Fvv83tu/7IwNTTJEuO4qRG1sjN+p9oopNopKhbvrBw/xMsaT2+OWfU3gHs//BRTWZOFedcUTUDzsLG0LxqAkP83tDh9RGcpFt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lXgymhKv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VU0yXIbn; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lXgymhKv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VU0yXIbn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F20E7A0160;
	Mon,  8 Jun 2026 20:56:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 08 Jun 2026 20:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1780966588; x=1781052988; bh=tUvnTTPQ2+
	Z88vdca6Uyo9BsCpoUPQHRdlK+srbcNxc=; b=lXgymhKvKv/Ib4Y+aen3nVuLbj
	9Vg4tLMJaY2TXmJrMsS+4DhcecMHaU7WXoamENjdpZ3DdwXoFl/gb4Kk/vFwMCCI
	n4VkmdYij1ygeDFu+IqJAJzVmy/MczsWQ7daLRfjS9eZFUMgSIy7L2jaqqgNp0Mb
	zWYaan0zEyBToCu/gpVnyrqBMKh9qHfYJ2Uf/3tJdLmKV0dB6alSyZNHE1wb1ahy
	cWV3yFRixRwe/cq6gj75WeIwxgkAVkJuAxqKl9C6/qXPAYn/wOBAeFCYQxKPCBSE
	WAUoVYFlzK+42RWR7QIdWi2Iui6njs6jaNmRtC/AIh4VaOEm0cfwTE/cjqDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780966588; x=1781052988; bh=tUvnTTPQ2+Z88vdca6Uyo9BsCpoUPQHRdlK
	+srbcNxc=; b=VU0yXIbnUngOcv4mKW/QCxbJ1+qiPWabZ0dePTa792tB7EjzHTy
	k3NxO50OrsSnPeCQ8AdgYPKVKwwh140AEMzB3UysZvSCiglA8rK5AcugKwVck+I4
	vJeR9ijhLuv8xv2MxZR54cSEm7Be5g5RRTvukUiBgK/hw1tmdnG79r0yMbrJOALd
	lMBir1EY8VY45O4/UkxWLX9JkK/Zaf4KQ90SN35y/RVgdajE8jQb8JGIiFvWb/Qj
	HG9jLqmuOSKKSd7jLi+yUYFf4D3f1IJTaxh2hipZ9YYq9ByJWYCI2K0GA9oieZqv
	UIvfl+cImJfbyhBKPzWWHqkIFOriR6um3HA==
X-ME-Sender: <xms:u2QnavQcCgRgwPoxvcohr1mHXAxwZztDZvs6QhIiB74w2QPVBSCz8Q>
    <xme:u2QnaoODE8l_ZFJAv4-N4s15VKmVDrAJqHASJaJkYkp3yfGAF8oK9qbgzN7Eng2_m
    r3iAe4Cm9jWMrX5S8guS-WDV5Pkhy845TxHrPEgIC7A3ryAxcWC>
X-ME-Received: <xmr:u2QnaiO5uDB1-NK3wfZn_6I4YzhOy9HtTqe9oR7_txgTr35U75llhoQJ3bYTwxEgfbdb3rqv5_YvBPFiI6cG0u_bkMrd__Dlsje->
X-ME-Proxy-Cause: dmFkZTFq8g2aqDGj40TMxuP/sTHup1swUtquaILg01BhVp/VB3rWB4pt8ZmNO+N/800mzW
    uCsXP9P49o19C6HcqWvzLiRCfYUCFQjLuf4DvvxC/w2QrsMwh2hr+pbNVq9Y5PIag5ljuR
    aBzrsUAS9GnHcCpWQgU3WV0cqBBQZi25p6wxzqjttnDbv+2fKrbpQszduZUbKpiHCKg3l3
    GyHj2cw/lpPyT1E6p5gxtkyMZ7U/RoDZwUbphGHGC54XyNlP1zyfLxQw2eW66odb2DXUP1
    kExqrzgi2KuqBLxYU/bLvPyMN+fcISi+gk25AM2ijumdJXesvvYigE2jaNFQD00eJEwBTx
    dMfPm4kTBcNxdEJBeukknlcxVhLV6LBsEStGbbYholo1XTJMP4zJpNJZ7y1++PN1Bbri6Q
    b01thPqSMaw+wrmdqagBeEP1VC01lVOHGfxwQPU9XhcOgCMGBnDUtOzWAjEyHtXUYWDz45
    NN/V50hie3Iq1hdbbvIexTL1b3dtET79iddnwPBA+nJ9cake4vZXJoh7xNJe9l4+ym9Ngx
    68fhNHvYfTPDjqBT0SivRW468/TfQP1K36suYqX0WatqcO8jXtQ0s24sZnliK/FbQCgKQx
    gQ0rKLsH9/49GSaxxtXMUghKdfmmNwewv9biQHrCxipnU8B+SwmQRYfz0zLg
X-ME-Proxy: <xmx:u2QnaovJCqRt9qALBPB09WeIDLwv-vdMC2ngfzBTKmcHiwNFOqvsmw>
    <xmx:vGQnasUtMEoyH3cbIIEgyHF9KgKWprgv7W4b835PdBY_JeO9B5kA8g>
    <xmx:vGQnagv8z_FOL9_VjDjIZKsIOmy3bLIu4c6DKjQ33r-nm1dSrn_WIg>
    <xmx:vGQnaoU89yO9hmrqE9PLv_t5hGvBOKcz2UJSLjmHotvx2ze5JTTyXA>
    <xmx:vGQnaqbAh8-mWPw8us9rXTdPwM1nuIAJjz8YNFUgXd2bFp77ZmZHVytV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 20:56:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2026, #03)
X-master-at: 600fe743028cbfb640855f659e9851522214bc0b
X-next-at: 3af1d1dc617ff77b2d2d43d1d742f19887db26f5
Date: Mon, 08 Jun 2026 17:56:26 -0700
Message-ID: <xmqqzf14tttx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and is a candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with a URL
to a message that raises issues but they are by no means exhaustive.
A topic without enough support may be discarded after a long period
of no activity (of course they can be resubmitted when new interests
arise).

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-scm/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[Graduated to 'master']

* aj/stash-patch-optimize-temporary-index (2026-05-22) 1 commit
  (merged to 'next' on 2026-05-31 at d1b1dd94f5)
 + stash: reuse cached index entries in --patch temporary index

 "git stash -p" has been optimized by reusing cached index
 entries in its temporary index, avoiding unnecessary lstat()
 calls on unchanged files.
 cf. <xmqqse7m6deh.fsf@gitster.g>
 source: <pull.2306.v2.git.git.1779491545531.gitgitgadget@gmail.com>


* ar/receive-pack-worktree-env (2026-05-25) 1 commit
  (merged to 'next' on 2026-05-27 at 9c246d1969)
 + receive-pack: fix updateInstead with core.worktree

 The GIT_WORK_TREE variable prepared to invoke the push-to-checkout
 hook was leaking into the environment even when there was no hook
 used and broke the default push-to-deploy (i.e., let "git checkout"
 update the working tree only when the working tree is clean).
 source: <20260525162311.66240-2-hi@alyssa.is>


* ds/restore-sparse-index (2026-05-26) 2 commits
  (merged to 'next' on 2026-05-31 at e85a961bc7)
 + restore: avoid sparse index expansion
 + t1092: test 'git restore' with sparse index

 'git restore --staged' has been optimized to avoid unnecessarily expanding
 the sparse index when operating on paths within the sparse checkout
 definition, by handling sparse directory entries at the tree level.
 source: <pull.2121.v2.git.1779827195.gitgitgadget@gmail.com>


* ja/doc-synopsis-style-again (2026-05-25) 6 commits
  (merged to 'next' on 2026-05-31 at cc4fe82d87)
 + doc: convert git-imap-send synopsis and options to new style
 + doc: convert git-apply synopsis and options to new style
 + doc: convert git-am synopsis and options to new style
 + doc: convert git-grep synopsis and options to new style
 + doc: git bisect: clarify the usage of the synopsis vs actual command
 + doc: convert git-bisect to synopsis style

 A batch of documentation pages has been updated to use the modern
 synopsis style.
 cf. <pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
 source: <pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>


* kh/free-commit-list (2026-05-28) 2 commits
  (merged to 'next' on 2026-05-31 at 154f83b192)
 + commit: remove deprecated functions
 + *: replace deprecated free_commit_list

 Code clean-up.
 source: <V2_CV_commit.h_remove_deprecated.732@msgid.xyz>


* kk/commit-reach-optim (2026-05-25) 3 commits
  (merged to 'next' on 2026-05-31 at eeb8d0c207)
 + commit-reach: replace queue_has_nonstale() scan with O(1) tracking
 + commit-reach: deduplicate queue entries in paint_down_to_common
 + object.h: fix stale entries in object flag allocation table

 The check for non-stale commits in the priority queue used by
 `paint_down_to_common` and `ahead_behind` has been optimized by
 replacing an O(N) scan with an O(1) counter, yielding performance
 improvements in repositories with wide histories.
 cf. <xmqqzf1ncded.fsf@gitster.g>
 source: <pull.2124.v2.git.1779719286.gitgitgadget@gmail.com>

--------------------------------------------------
[New Topics]

* ps/odb-source-packed (2026-06-04) 17 commits
 - odb/source-packed: drop pointer to "files" parent source
 - midx: refactor interfaces to work on "packed" source
 - odb/source-packed: stub out remaining functions
 - odb/source-packed: wire up `freshen_object()` callback
 - odb/source-packed: wire up `find_abbrev_len()` callback
 - odb/source-packed: wire up `count_objects()` callback
 - odb/source-packed: wire up `for_each_object()` callback
 - odb/source-packed: wire up `read_object_stream()` callback
 - odb/source-packed: wire up `read_object_info()` callback
 - packfile: use higher-level interface to implement `has_object_pack()`
 - odb/source-packed: wire up `reprepare()` callback
 - odb/source-packed: wire up `close()` callback
 - odb/source-packed: start converting to a proper `struct odb_source`
 - odb/source-packed: store pointer to "files" instead of generic source
 - packfile: move packed source into "odb/" subsystem
 - packfile: rename `struct packfile_store` to `odb_source_packed`
 - Merge branch 'ps/odb-source-loose' into ps/odb-source-packed
 (this branch uses ps/odb-source-loose.)

 The packed object source has been refactored into a proper struct
 odb_source.

 Comments?
 source: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>


* ps/transport-helper-tsan-fix (2026-06-04) 1 commit
 - transport-helper: fix TSAN race in transfer_debug()

 The TSAN race in transfer_debug() within transport-helper.c has been
 resolved by initializing the debug flag early in
 bidirectional_transfer_loop() before spawning worker threads, allowing
 the removal of a TSAN suppression.

 Comments?
 source: <20260604132327.277693-3-pushkarkumarsingh1970@gmail.com>


* ta/typofixes (2026-06-04) 1 commit
 - docs: fix typos

 Typofixes

 Comments?
 source: <20260604131457.19215-1-taahol@utu.fi>


* js/win-kill-child-more-gently (2026-06-04) 2 commits
 - mingw: really handle SIGINT
 - mingw: kill child processes in a gentler way

 Advanced emulation of kill() used on Windows in GfW has been
 upstreamed to improve the symptoms like left-behind .lock files and
 that fails to let the child clean-up itself when it gets killed.

 Comments?
 source: <pull.2130.git.1780590261.gitgitgadget@gmail.com>


* dl/posix-unused-warning-clang (2026-06-08) 2 commits
 - compat/posix.h: simplify GIT_GNUC_PREREQ() comparison
 - compat/posix.h: enable UNUSED warning messages for Clang

 The UNUSED macro in 'compat/posix.h' has been updated to use a
 newly introduced GIT_CLANG_PREREQ macro for compiler version
 checks, and the existing GIT_GNUC_PREREQ macro has been modernized
 to use explicit major/minor comparisons rather than bit-shifting.

 Comments?
 source: <20260608124419.38905-1-dominik.loidolt@univie.ac.at>


* lo/doc-format-patch-subject-prefix (2026-06-04) 1 commit
 - Documentation: remove redundant 'instead' in --subject-prefix

 Wording used in "format-patch --subject-prefix" documentation
 has been improved.

 Will merge to 'next'.
 source: <20260604163510.36687-2-lucasseikioshiro@gmail.com>


* am/doc-tech-hash-typofix (2026-06-05) 1 commit
 - doc: fix typo in GIT_ALTERNATE_OBJECT_DIRECTORIES

 Typofix.

 Will merge to 'next'.
 cf. <aiZo9FqsdKrhz0gA@pks.im>
 source: <20260605172643.8796-1-amonakov@ispras.ru>


* td/ref-filter-restore-prefix-iteration (2026-06-05) 1 commit
 - ref-filter: restore prefix-scoped iteration

 Commands that list branches and tags (like git branch and git tag)
 have been optimized to pass the namespace prefix when initializing
 their ref iterator, avoiding a loose-ref scaling regression in
 repositories with many unrelated loose references.

 Comments?
 source: <20260605-fix-git-branch-regression-v1-1-02f40ad40929@gmail.com>


* ty/move-protect-hfs-ntfs (2026-06-06) 1 commit
 - environment.c: move 'protect_hfs' and 'protect_ntfs' into 'repo_config_values'

 The global configuration variables protect_hfs and protect_ntfs have
 been migrated into struct repo_config_values to tie them to
 per-repository configuration state.

 Comments?
 source: <20260606143412.15443-1-cat@malon.dev>


* ds/config-no-includes (2026-06-08) 3 commits
 - git: add --no-includes top-level option
 - config: add GIT_CONFIG_INCLUDES
 - git-config.adoc: fix paragraph break

 Two new mechanisms, the GIT_CONFIG_INCLUDES environment variable and
 the top-level --no-includes command-line option, have been introduced
 to ignore configuration include directives.

 Comments?
 source: <pull.2139.git.1780927027.gitgitgadget@gmail.com>


* ps/cat-file-remote-object-info (2026-06-08) 12 commits
 - cat-file: make remote-object-info allow-list dynamic
 - cat-file: validate remote atoms with allow_list
 - cat-file: add remote-object-info to batch-command
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - connect: refactor packet writing
 - fetch-pack: move function to connect.c
 - t1006: split test utility functions into new "lib-cat-file.sh"
 - cat-file: add declaration of variable i inside its for loop
 - git-compat-util: add strtoul_ul() with error handling
 - transport-helper: fix memory leak of helper on disconnect

 The `remote-object-info` command has been added to `git cat-file
 --batch-command`, allowing clients to request object metadata
 (currently size) from a remote server via protocol v2 without
 downloading the entire object.

 The client dynamically filters format placeholders based on
 server-advertised capabilities and safely returns empty strings for
 inapplicable or unsupported fields.

 Comments?
 source: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>

--------------------------------------------------
[Stalled]

* jd/unpack-trees-wo-the-repository (2026-03-31) 2 commits
 - unpack-trees: use repository from index instead of global
 - unpack-trees: use repository from index instead of global

 A handful of inappropriate uses of the_repository have been
 rewritten to use the right repository structure instance in the
 unpack-trees.c codepath.

 Waiting for response(s) to review comment(s) for too long, consider discarding.
 cf. <xmqqldf7y95a.fsf@gitster.g>
 source: <pull.2258.v2.git.git.1774971267.gitgitgadget@gmail.com>


* cs/subtree-split-recursion (2026-03-05) 3 commits
 - contrib/subtree: reduce recursion during split
 - contrib/subtree: functionalize split traversal
 - contrib/subtree: reduce function side-effects

 When processing large history graphs on Debian or Ubuntu, "git
 subtree" can die with a "recursion depth reached" error.

 Waiting for response(s) to review comment(s) for too long, consider discarding.
 cf. <xmqqv7c13o5l.fsf@gitster.g>
 source: <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>

--------------------------------------------------
[Cooking]

* ap/http-redirect-wwwauth-fix (2026-06-02) 1 commit
 - http: preserve wwwauth_headers across redirects

 When cURL follows a redirect, the WWW-Authenticate headers from the
 redirect target were lost because credential_from_url() cleared the
 credential state. This has been fixed by preserving the collected
 headers across the redirect update.

 Expecting a reroll.
 cf. <5144a29d-a53f-4446-beff-e1f549345bf9@nvidia.com>
 source: <20260602161150.1527493-1-aplattner@nvidia.com>


* ps/doc-recommend-b4 (2026-06-07) 3 commits
 - b4: introduce configuration for the Git project
 - MyFirstContribution: recommend the use of b4
 - MyFirstContribution: recommend shallow threading of cover letters

 Project-specific configuration for b4 has been introduced, and the
 documentation has been updated to recommend using it as a
 streamlined method for submitting patches.

 Comments?
 source: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>


* kk/streaming-walk-pqueue (2026-05-27) 3 commits
 - revision: use priority queue for non-limited streaming walks
 - revision: introduce rev_walk_mode to clarify get_revision_1()
 - pack-objects: call release_revisions() after cruft traversal

 Streaming revision walks have been optimized by using a priority queue
 for date-sorting commits, speeding up walks repositories with many
 merges.

 Will merge to 'next'?
 source: <pull.2127.git.1779897003.gitgitgadget@gmail.com>


* kk/wildmatch-windows-ls-files-prereq (2026-05-28) 1 commit
  (merged to 'next' on 2026-06-04 at 6dc748aa63)
 + t3070: skip ls-files tests with backslash patterns on Windows

 In t3070-wildmatch, "via ls-files" test variants with patterns
 containing backslash escapes are now skipped on Windows, avoiding 36
 test failures caused by pathspec separator conversion.

 Will merge to 'master'.
 cf. <xmqqecivjn7k.fsf@gitster.g>
 source: <pull.2128.git.1779958849319.gitgitgadget@gmail.com>


* sn/rebase-update-refs-symrefs (2026-06-03) 1 commit
 - rebase: skip branch symref aliases

 "git rebase --update-refs" has been taught to resolve local branch
 symrefs to their referents before queuing updates. This correctly
 skips aliases of the current branch and avoids duplicate updates for
 underlying real branches, fixing failures when branch aliases (like a
 default branch rename) are present.

 Waiting for response(s) to review comment(s).
 cf. <f982c386-e329-4ab0-b695-e540bcb9de3d@gmail.com>
 source: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>


* lp/http-fetch-pack-index-leak-fix (2026-06-01) 2 commits
  (merged to 'next' on 2026-06-04 at f4090b5068)
 + http: fix memory leak in fetch_and_setup_pack_index()
 + http: cleanup function fetch_and_setup_pack_index()

 A memory leak in `fetch_and_setup_pack_index()` when verification of
 the downloaded pack index fails has been plugged. Also an obsolete
 `unlink()` call on parse failure has been cleaned up.

 Will merge to 'master'.
 cf. <20260529053659.GC1099450@coredump.intra.peff.net>
 source: <cover.1780321770.git.lorenzo.pegorari2002@gmail.com>


* jk/describe-contains-all-match-fix (2026-06-01) 1 commit
 - describe: fix --exclude, --match with --contains and --all

 The 'git describe --contains --all' command has been fixed to
 properly honor the '--match' and '--exclude' options by passing
 them down to 'git name-rev' with the appropriate reference
 prefixes.

 Will merge to 'next'?
 source: <20260601233727.43558-1-jacob.e.keller@intel.com>


* wy/docs-typofixes (2026-05-29) 1 commit
 - docs: fix typos and grammar

 Various typos, grammatical errors, and duplicated words in both
 documentation and code comments have been corrected.

 Waiting for response(s) to review comment(s).
 cf. <xmqq8q8x3nox.fsf@gitster.g>
 source: <7b502e20e9495cd4720496bd6738a1fbeb453410.1780041658.git.wy@wyuan.org>


* ab/index-pack-retain-child-bases (2026-06-02) 1 commit
 - index-pack: retain child bases in delta cache

 "git index-pack" has been optimized by retaining child bases in the
 delta cache instead of immediately freeing them, letting the existing
 cache limit policy decide eviction.

 Waiting for response(s) to review comment(s).
 cf. <c4a32a6f-70bf-4ff4-abbf-d6e301246b5b@gmail.com>
 source: <pull.2131.v3.git.1780445118653.gitgitgadget@gmail.com>


* hn/macos-linker-warning (2026-06-02) 1 commit
  (merged to 'next' on 2026-06-04 at db2ca164c4)
 + config.mak.uname: avoid macOS linker warning on Xcode 16.3+

 A linker warning on macOS when building with Xcode 16.3 or newer has
 been avoided by passing -fno-common to the compiler when a
 sufficiently new linker is detected.

 Will merge to 'master'.
 source: <pull.2313.v3.git.git.1780385878555.gitgitgadget@gmail.com>


* mm/diff-process-hunks (2026-05-29) 6 commits
 . blame: consult diff process for no-hunk detection
 . diff: bypass diff process with --no-ext-diff and in format-patch
 . diff: add long-running diff process via diff.<driver>.process
 . sub-process: separate process lifecycle from hashmap management
 . userdiff: add diff.<driver>.process config
 . xdiff: support external hunks via xpparam_t

 A new `diff.<driver>.process` configuration has been introduced to
 allow a long-running external process to act as a hunk provider to
 allows external tools to control which lines Git considers changed
 while leaving all output formatting (word diff, color, blame, etc.) to
 Git's standard pipeline.

 Expecting a reroll.
 cf. <CAC2QwmKNA6wv-jG07fgJj7Xj2J+dzzWEiqV5Q+8HJpjA_GtkFw@mail.gmail.com>
 source: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>


* tb/pack-path-walk-bitmap-delta-islands (2026-06-02) 5 commits
 - pack-objects: support `--delta-islands` with `--path-walk`
 - pack-objects: extract `record_tree_depth()` helper
 - pack-objects: support reachability bitmaps with `--path-walk`
 - t/perf: drop p5311's lookup-table permutation
 - Merge branch 'ds/path-walk-filters' into tb/pack-path-walk-bitmap-delta-islands

 The pack-objects command now supports using reachability bitmaps and
 delta-islands concurrently with the `--path-walk` option, allowing
 faster packaging by falling back to path-walk when bitmaps cannot
 fully satisfy the request.

 Comments?
 source: <cover.1780438896.git.me@ttaylorr.com>


* ty/migrate-trust-executable-bit (2026-05-30) 4 commits
 - read-cache: pass 'istate' to stat/mode helper functions
 - environment: move 'trust_executable_bit' into repo_config_values
 - read-cache: move 'ce_mode_from_stat()' to 'read-cache.c'
 - read-cache: remove redundant extern declarations

 The 'trust_executable_bit' (coming from 'core.filemode'
 configuration) has been migrated into 'repo_config_values' to tie it
 to a specific repository instance.

 Waiting for response(s) to review comment(s).
 cf. <CAP8UFD1GJ=caPh-M97KLCfB1ZKtpomzosYN0uYBOnay+G23GcA@mail.gmail.com>
 cf. <CAP8UFD20yij=1ZEYnR74DoCJ3g=b39yOsUxZecYuuf7nFGaKyA@mail.gmail.com>
 source: <20260530160520.77859-1-cat@malon.dev>


* ak/typofixes (2026-05-31) 1 commit
 - doc: fix typos via codespell

 Typofixes.

 Will merge to 'next'.
 cf. <3398ef40-1547-4324-2cfc-97b9e2b24854@gmx.de>
 cf. <xmqq8q8p1ese.fsf@gitster.g>
 source: <20260531184428.55905-1-algonell@gmail.com>
 source: <20260506101631.18127-1-algonell@gmail.com>
 source: <3398ef40-1547-4324-2cfc-97b9e2b24854@gmx.de>


* kk/prio-queue-cascade-sift (2026-06-01) 1 commit
 - prio-queue: use cascade-down for faster extract-min

 prio_queue_get() has been optimized by using a cascade-down approach
 (promoting the smaller child at each level and sifting up the last
 element from the leaf vacancy), which halves the number of comparisons
 per extract-min operation in the common case.

 Expecting a reroll.
 cf. <CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
 source: <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>


* mm/subprocess-handshake-fix (2026-06-01) 1 commit
 - sub-process: use gentle handshake to avoid die() on startup failure

 The subprocess handshake during startup has been made gentler by using
 packet_read_line_gently() instead of packet_read_line() to prevent the
 parent Git process from dying abruptly when a configured subprocess
 (e.g., a clean/smudge filter) fails to start.

 Will merge to 'next'?
 source: <pull.2133.v2.git.1780348848489.gitgitgadget@gmail.com>


* jk/repo-info-path-keys (2026-06-05) 4 commits
 - repo: add path.commondir with absolute and relative suffix formatting
 - repo: add path.gitdir with absolute and relative suffix formatting
 - rev-parse: use format_path for path formatting
 - path: introduce format_path() for centralized path formatting

 The "git repo info" command has been taught new keys to output both
 absolute and relative paths for "gitdir" and "commondir", supported by
 a new path-formatting helper extracted from "git rev-parse".

 Comments?
 source: <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>


* ps/history-drop (2026-06-08) 9 commits
 - builtin/history: implement "drop" subcommand
 - builtin/history: split handling of ref updates into two phases
 - reset: stop assuming that the caller passes in a clean index
 - reset: allow the caller to specify the current HEAD object
 - reset: introduce ability to skip reference updates
 - reset: introduce dry-run mode
 - reset: modernize flags passed to `reset_head()`
 - reset: drop `USE_THE_REPOSITORY_VARIABLE`
 - read-cache: split out function to drop unmerged entries to stage 0

 The experimental "git history" command has been taught a new "drop"
 subcommand to remove a commit and replay its descendants onto its
 parent.

 Comments?
 source: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>


* ls/doc-raw-timestamp-prefix (2026-06-02) 1 commit
 - doc: document and test `@` prefix for raw timestamps

 Documentation and tests have been added to clarify that Git's internal
 raw timestamp format requires a `@` prefix for values less than
 100,000,000 to prevent ambiguity with other formats like YYYYMMDD.

 Will merge to 'next'.
 cf. xmqqmrxdxq1r.fsf@gitster.g>
 source: <20260602081924.673763-2-dev@luna.gl>


* jk/setup-gitfile-diag-fix (2026-06-01) 1 commit
 - read_gitfile_gently(): return non-repo path on error

 A regression in the error diagnosis code for invalid .git files has
 been fixed, avoiding a potential NULL-pointer crash when reporting
 that a .git file does not point to a valid repository.

 Expecting a reroll?
 cf. <ah6WEtk2pXyViEQA@pks.im>
 source: <20260602061159.GA693928@coredump.intra.peff.net>


* jc/submitting-patches-cover-letter (2026-06-02) 2 commits
 - SubmittingPatches: describe cover letter
 - SubmittingPatches: separate typofixes section

 Guidelines on how to write a cover letter for a multi-patch series
 have been added to SubmittingPatches, which also got a new marker
 to separate the section for typofixes.

 Will merge to 'next'.
 cf. <c54f3571-ff7b-4caa-b75d-a739ed87ec9d@gmail.com>
 cf. <aiEgUdnL8dkszKFn@pks.im>
 source: <20260602144304.3341000-1-gitster@pobox.com>


* ps/t7527-fix-tap-output (2026-06-04) 8 commits
 - t: let prove fail when parsing invalid TAP output
 - t/lib-git-p4: silence output when killing p4d and its watchdog
 - t/test-lib: silence EBUSY errors on Windows during test cleanup
 - t7810: turn MB_REGEX check into a lazy prereq
 - t7527: fix broken TAP output
 - ci: unify Linux images across GitLab and GitHub
 - gitlab-ci: add missing Linux jobs
 - gitlab-ci: rearrange Linux jobs to match GitHub's order

 A recent regression in t7527 that broke TAP output has been fixed,
 some other test noise that also broke TAP output has been silenced,
 and 'prove' is now configured to fail on invalid TAP output to
 prevent future regressions.

 Comments?
 source: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>


* ob/more-repo-config-values (2026-06-02) 8 commits
 - environment: move "warn_on_object_refname_ambiguity" into `struct repo_config_values`
 - environment: move "sparse_expect_files_outside_of_patterns" into `struct repo_config_values`
 - environment: move "core_sparse_checkout_cone" into `struct repo_config_values`
 - environment: move "precomposed_unicode" into `struct repo_config_values`
 - environment: move "pack_compression_level" into `struct repo_config_values`
 - environment: move `zlib_compression_level` into `struct repo_config_values`
 - environment: move "check_stat" into `struct repo_config_values`
 - environment: move "trust_ctime" into `struct repo_config_values`

 Many core configuration variables have been migrated from global
 variables into 'repo_config_values' to tie them to a specific
 repository instance, avoiding cross-repository state leakage.

 Will merge to 'next'.
 source: <20260602170921.35869-1-belkid98@gmail.com>


* kh/doc-trailers (2026-04-13) 9 commits
 - doc: interpret-trailers: document comment line treatment
 - doc: interpret-trailers: commit to “trailer block” term
 - doc: interpret-trailers: add key format example
 - doc: interpret-trailers: explain key format
 - doc: interpret-trailers: explain the format after the intro
 - doc: interpret-trailers: not just for commit messages
 - doc: interpret-trailers: use “metadata” in Name as well
 - doc: interpret-trailers: replace “lines” with “metadata”
 - doc: interpret-trailers: stop fixating on RFC 822

 Documentation updates.

 Expecting a reroll.
 cf. <5508ee49-2f78-4c3a-accf-a2350666bfb8@app.fastmail.com>
 source: <V2_CV_doc_int-tr_key_format.613@msgid.xyz>


* za/completion-hide-dotfiles (2026-05-26) 1 commit
 - completion: hide dotfiles for selected path completion

 The path completion for commands like `git rm` and `git mv`, is being
 updated to hide dotfiles by default, unless the user explicitly starts
 the path with a dot, matching standard shell-completion behavior.

 Comments?
 cf. <xmqqqzmxlep3.fsf@gitster.g>
 source: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>


* ib/doc-push-default-simple (2026-05-25) 1 commit
  (merged to 'next' on 2026-06-02 at 5c1ff2a769)
 + doc: clarify push.default=simple behavior

 The documentation for `push.default = simple` has been clarified to
 better explain its behavior, making it clear that it pushes the
 current branch to a same-named branch on the remote, and detailing
 the upstream requirements for centralized workflows.

 Will merge to 'master'.
 cf. <pull.2115.v2.git.1779767888508.gitgitgadget@gmail.com>
 source: <pull.2115.v2.git.1779767888508.gitgitgadget@gmail.com>


* jc/doc-monitor-ghci (2026-05-24) 1 commit
  (merged to 'next' on 2026-06-02 at 46fb5fe1c2)
 + SubmittingPatches: proactively monitor GHCI pages

 Encourage original authors to monitor the CI status.

 Will merge to 'master'.
 source: <xmqq1pf0gpp3.fsf@gitster.g>


* ec/commit-fixup-options (2026-05-26) 2 commits
 - commit: allow -c/-C for all kinds of --fixup
 - commit: allow -m/-F for all kinds of --fixup

 The -m/-F/-c/-C options to supply commit log message from outside the
 editor are now supported for all "git commit --fixup" variations.

 Comments?
 source: <cover.1779792311.git.erik@cervined.in>


* gh/jump-auto-mode (2026-05-21) 1 commit
  (merged to 'next' on 2026-06-02 at f70dd05c9c)
 + git-jump: pick a mode automatically when invoked without arguments

 The 'git-jump' command (in contrib/) has been taught to automatically
 pick a mode (merge, diff, or ws) when invoked without arguments.

 Will merge to 'master'.
 cf. <20260522052821.GC861761@coredump.intra.peff.net>
 source: <pull.2108.v3.git.1779371110195.gitgitgadget@gmail.com>


* ps/odb-source-loose (2026-06-01) 19 commits
  (merged to 'next' on 2026-06-04 at 660909ad66)
 + odb/source-loose: drop pointer to the "files" source
 + odb/source-loose: stub out remaining callbacks
 + odb/source-loose: wire up `write_object_stream()` callback
 + object-file: refactor writing objects to use loose source
 + odb/source-loose: wire up `write_object()` callback
 + loose: refactor object map to operate on `struct odb_source_loose`
 + odb/source-loose: wire up `freshen_object()` callback
 + odb/source-loose: drop `odb_source_loose_has_object()`
 + odb/source-loose: wire up `count_objects()` callback
 + odb/source-loose: wire up `find_abbrev_len()` callback
 + odb/source-loose: wire up `for_each_object()` callback
 + odb/source-loose: wire up `read_object_stream()` callback
 + odb/source-loose: wire up `read_object_info()` callback
 + odb/source-loose: wire up `close()` callback
 + odb/source-loose: wire up `reprepare()` callback
 + odb/source-loose: start converting to a proper `struct odb_source`
 + odb/source-loose: store pointer to "files" instead of generic source
 + odb/source-loose: move loose source into "odb/" subsystem
 + Merge branch 'ps/odb-in-memory' into ps/odb-source-loose
 (this branch is used by ps/odb-source-packed.)

 The loose object source has been refactored into a proper `struct
 odb_source`.

 Will merge to 'master'.
 source: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>


* ps/setup-centralize-odb-creation (2026-06-04) 9 commits
 - setup: construct object database in `apply_repository_format()`
 - repository: stop reading loose object map twice on repo init
 - setup: stop initializing object database without repository
 - setup: stop creating the object database in `setup_git_env()`
 - repository: stop initializing the object database in `repo_set_gitdir()`
 - setup: deduplicate logic to apply repository format
 - setup: drop `setup_git_env()`
 - t0001: plug test gaps for git-init(1) with GIT_OBJECT_DIRECTORY
 - Merge branch 'ps/setup-wo-the-repository' into ps/setup-centralize-odb-creation

 The setup logic to discover and configure repositories has been
 refactored, and the initialization of the object database has been
 centralized.

 Will merge to 'next'.
 cf. <CAOLa=ZQwVbLsOcajaxQwtkTPm=4St7EiGEEyL6_B0o3Tt1v1pw@mail.gmail.com>
 source: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>


* kh/doc-replay-config (2026-06-05) 4 commits
 - doc: replay: move “default” to the right-hand side
 - doc: replay: use a nested description list
 - doc: replay: improve config description
 - doc: link to config for git-replay(1)

 Doc update for "git replay" to actually refer to its configuration
 variables.

 Comments?
 source: <V3_CV_doc_replay_config.780@msgid.xyz>


* tb/bitmap-build-performance (2026-05-27) 9 commits
  (merged to 'next' on 2026-06-02 at d1a84a996a)
 + pack-bitmap: build pseudo-merge bitmaps after regular bitmaps
 + pack-bitmap: remember pseudo-merge parents
 + pack-bitmap: sort bitmaps before XORing
 + pack-bitmap: cache object positions during fill
 + pack-bitmap: consolidate `find_object_pos()` success path
 + pack-bitmap: reuse stored selected bitmaps
 + pack-bitmap: check subtree bits before recursing
 + pack-bitmap: pass object position to `fill_bitmap_tree()`
 + Merge branch 'tb/pseudo-merge-bugfixes' into tb/bitmap-build-performance

 Reachability bitmap generation has been significantly optimized. By
 reordering tree traversal, caching object positions, and refining how
 pseudo-merge bitmaps are constructed, the performance of "git repack
 --write-midx-bitmaps" is improved, especially for large repositories
 and when using pseudo-merges.

 Will merge to 'master'.
 cf. <20260529083439.GD1106035@coredump.intra.peff.net>
 source: <cover.1779911733.git.me@ttaylorr.com>


* hn/status-pull-advice-qualified (2026-05-21) 1 commit
 - remote: qualify "git pull" advice for non-upstream compareBranches

 Advice shown by "git status" when the local branch is behind or has
 diverged from its push branch has been updated to suggest "git pull
 <remote> <branch>".

 Comments?
 source: <pull.2301.v4.git.git.1779372367317.gitgitgadget@gmail.com>


* rs/strbuf-add-uint (2026-05-12) 4 commits
  (merged to 'next' on 2026-06-02 at f5be02d8ec)
 + ls-tree: use strbuf_add_uint()
 + ls-files: use strbuf_add_uint()
 + cat-file: use strbuf_add_uint()
 + strbuf: add strbuf_add_uint()

 Adding a decimal integer with strbuf_addf("%u") appears commonly;
 they have been optimized by using a custom formatter.

 Will merge to 'master'.
 cf. <20260512184619.GD70851@coredump.intra.peff.net>
 source: <20260512115603.80780-1-l.s.r@web.de>


* mm/doc-word-diff (2026-05-28) 1 commit
  (merged to 'next' on 2026-06-04 at 9fa723ec63)
 + doc: clarify that --word-diff operates on line-level hunks

 The documentation for "--word-diff" has been extended with a bit of
 implementation detail of where these different words come from.

 Will merge to 'master'.
 source: <pull.2113.v2.git.1779996106005.gitgitgadget@gmail.com>


* rs/strbuf-add-oid-hex (2026-05-13) 1 commit
  (merged to 'next' on 2026-06-02 at 4876f95de0)
 + hex: add and use strbuf_add_oid_hex()

 Formatting object name in full hexadecimal form has been optimized
 by using a new strbuf_add_oid_hex() helper function.

 Will merge to 'master'.
 cf. <20260513160155.GA103037@coredump.intra.peff.net>
 source: <183aa0fd-d455-4ec9-9c42-d511fac8b3e4@web.de>


* hn/config-typo-advice (2026-06-02) 2 commits
 - config: improve diagnostic for "set" with missing value
 - config: add git_config_key_is_valid() for quiet validation

 "git config foo.bar=baz" is not likely to be a request to read the
 value of such a variable with '=' in its name; rather it is plausible
 that the user meant "git config set foo.bar baz".  Give advice when
 giving an error message.

 Will merge to 'next'.
 cf. <xmqq1penqfg2.fsf@gitster.g>
 source: <pull.2302.v6.git.git.1780425808.gitgitgadget@gmail.com>


* jt/config-lock-timeout (2026-05-17) 1 commit
 - config: retry acquiring config.lock, configurable via core.configLockTimeout

 Configuration file locking now retries for a short period, avoiding
 failures when multiple processes attempt to update the configuration
 simultaneously.

 Waiting for response(s) to review comment(s).
 cf. <agrIrGwSMFlKTx9x@pks.im>
 source: <20260517132111.1014901-1-joerg@thalheim.io>


* hn/branch-prune-merged (2026-06-05) 6 commits
 . branch: add --dry-run for --prune-merged
 . branch: add branch.<name>.pruneMerged opt-out
 . branch: add --prune-merged <branch>
 . branch: prepare delete_branches for a bulk caller
 . branch: let delete_branches warn instead of error on bulk refusal
 . branch: add --forked filter for --list mode

 "git branch" command learned "--prune-merged" option to remove
 local branches that have already been merged to the remote-tracking
 branches they track.

 Breaks tests.
 source: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>


* st/daemon-sockaddr-fixes (2026-05-27) 3 commits
  (merged to 'next' on 2026-06-04 at 17684e6158)
 + daemon: guard NULL REMOTE_PORT in execute() logging
 + daemon: fix IPv6 address truncation in ip2str()
 + daemon: fix IPv6 address corruption in lookup_hostname()

 Correct use of sockaddr API in "git daemon".

 Will merge to 'master'.
 source: <pull.2300.v3.git.git.1779937016.gitgitgadget@gmail.com>


* cc/promisor-auto-config-url-more (2026-05-27) 8 commits
 - doc: promisor: improve acceptFromServer entry
 - promisor-remote: auto-configure unknown remotes
 - promisor-remote: trust known remotes matching acceptFromServerUrl
 - promisor-remote: introduce promisor.acceptFromServerUrl
 - promisor-remote: add 'local_name' to 'struct promisor_info'
 - urlmatch: add url_normalize_pattern() helper
 - urlmatch: change 'allow_globs' arg to bool
 - t5710: simplify 'mkdir X' followed by 'git -C X init'

 The handling of promisor-remote protocol capability has been
 loosened to allow the other side to add to the list of promisor
 remotes via the promisor.acceptFromServerURL configuration
 variable.

 Comments?
 source: <20260527140820.1438165-1-christian.couder@gmail.com>


* hn/checkout-track-fetch (2026-05-23) 2 commits
 - checkout: extend --track with a "fetch" mode to refresh start-point
 - branch: expose helpers for finding the remote owning a tracking ref

 "git checkout --track=..." learned to optionally fetch the branch
 from the remote the new branch will work with.

 Comments?
 source: <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>


* mf/revision-max-count-oldest (2026-05-18) 1 commit
 - revision.c: implement --max-count-oldest

 "git rev-list" (and "git log" family of commands) learned a new "--max-count-oldest"
 that picks oldest N commits in the range instead of the usual newest.

 Will merge to 'next'.
 source: <8210d60832b9a58aa4d71fc3790e44d8989564ce.1779152064.git.mroik@delayed.space>


* mm/line-log-cleanup (2026-05-28) 3 commits
  (merged to 'next' on 2026-06-04 at 02f8bea278)
 + line-log: allow non-patch diff formats with -L
 + line-log: integrate -L output with the standard log-tree pipeline
 + revision: move -L setup before output_format-to-diff derivation

 The `git log -L` implementation has been refactored to use the
 standard diff output pipeline, enabling pickaxe and diff-filter to
 work as expected. Additionally, metadata-only diff formats like
 --raw and --name-only are now supported with -L.

 Will merge to 'master'.
 cf. <B59BA5B1-184D-48A8-8BAD-11EB6F8EB50C@gmail.com>
 source: <pull.2094.v3.git.1780001267.gitgitgadget@gmail.com>


* en/ort-harden-against-corrupt-trees (2026-04-20) 5 commits
 - cache-tree: fix verify_cache() to catch non-adjacent D/F conflicts
 - merge-ort: abort merge when trees have duplicate entries
 - merge-ort: free diff pairs queue in clear_or_reinit_internal_opts()
 - merge-ort: drop unnecessary show_all_errors from collect_merge_info()
 - merge-ort: propagate callback errors from traverse_trees_wrapper()

 "ort" merge backend handles merging corrupt trees better by
 aborting when it should.

 Waiting for response(s) to review comment(s).
 cf. <xmqqldcy4f07.fsf@gitster.g>
 source: <pull.2096.git.1776731171.gitgitgadget@gmail.com>


* pw/status-rebase-todo (2026-05-01) 2 commits
 - status: improve rebase todo list parsing
 - sequencer: factor out parsing of todo commands

 The display of the rebase todo list in "git status" has been
 improved to correctly abbreviate object IDs for more commands and
 avoid misinterpreting refs as object IDs.

 Waiting for response(s) to review comment(s).
 cf. <xmqqbjdwcsno.fsf@gitster.g>
 source: <cover.1777648598.git.phillip.wood@dunelm.org.uk>


* cl/conditional-config-on-worktree-path (2026-05-24) 2 commits
 - config: add "worktree" and "worktree/i" includeIf conditions
 - config: refactor include_by_gitdir() into include_by_path()

 The [includeIf "condition"] conditional inclusion facility for
 configuration files has learned to use the location of worktree
 in its condition.

 Waiting for response(s) to review comment(s).
 cf. <xmqq8q97et9b.fsf@gitster.g>
 source: <20260525-includeif-worktree-v5-0-1efe525d025a@black-desk.cn>


* ps/shift-root-in-graph (2026-04-27) 1 commit
 - graph: add indentation for commits preceded by a parentless commit

 In a history with more than one root commit, "git log --graph
 --oneline" stuffed an unrelated commit immediately below a root
 commit, which has been corrected by making the spot below a root
 unavailable.

 Expecting a reroll.
 cf. <CAN5EUNQoKRqt3FGLmzRGpPU1nO5jCAogP8Wm9gBZXuPbMNbQAw@mail.gmail.com>
 source: <20260427102838.44867-2-pabloosabaterr@gmail.com>


* th/promisor-quiet-per-repo (2026-04-06) 1 commit
  (merged to 'next' on 2026-06-02 at 02a749d7fe)
 + promisor-remote: fix promisor.quiet to use the correct repository

 The "promisor.quiet" configuration variable was not used from
 relevant submodules when commands like "grep --recurse-submodules"
 triggered a lazy fetch, which has been corrected.

 Will merge to 'master'.
 cf. <c87f1f12-d0cc-4150-8f43-4dc9cc1fe24f@malon.dev>
 source: <20260406183041.783800-1-vikingtc4@gmail.com>


* ua/push-remote-group (2026-05-03) 3 commits
  (merged to 'next' on 2026-06-02 at ba5d6aebaa)
 + push: support pushing to a remote group
 + remote: move remote group resolution to remote.c
 + remote: fix sign-compare warnings in push_cas_option

 "git push" learned to take a "remote group" name to push to, which
 causes pushes to multiple places, just like "git fetch" would do.

 Will merge to 'master'.
 cf. <20260518182721.155070-1-usmanakinyemi202@gmail.com>
 source: <20260503153402.1333220-1-usmanakinyemi202@gmail.com>


* js/parseopt-subcommand-autocorrection (2026-04-27) 11 commits
 - SQUASH???
 - doc: document autocorrect API
 - parseopt: add tests for subcommand autocorrection
 - parseopt: enable subcommand autocorrection for git-remote and git-notes
 - parseopt: autocorrect mistyped subcommands
 - autocorrect: provide config resolution API
 - autocorrect: rename AUTOCORRECT_SHOW to AUTOCORRECT_HINT
 - autocorrect: use mode and delay instead of magic numbers
 - help: move tty check for autocorrection to autocorrect.c
 - help: make autocorrect handling reusable
 - parseopt: extract subcommand handling from parse_options_step()

 The parse-options library learned to auto-correct misspelled
 subcommand names.

 Expecting a reroll.
 cf. <SY0P300MB0801E50FCB7EB2F45CD15208CE042@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 source: <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>


* jc/neuter-sideband-post-3.0 (2026-03-05) 2 commits
 - sideband: delay sanitizing by default to Git v3.0
 - Merge branch 'jc/neuter-sideband-fixup' into jc/neuter-sideband-post-3.0

 The final step, split from earlier attempt by Dscho, to loosen the
 sideband restriction for now and tighten later at Git v3.0 boundary.

 On hold to help the base topic with wider exposure.
 (this branch uses jc/neuter-sideband-fixup.)
 source: <20260305233452.3727126-8-gitster@pobox.com>

--------------------------------------------------
[Discarded]

* kk/fetch-store-ref-optimization (2026-05-24) 1 commit
 - fetch: pass transport to post-fetch connectivity check

 When fetching from a transport that provides a self-contained pack,
 pass the transport pointer to the post-fetch `check_connected()` call
 to optimize connectivity check.

 Retracted.
 cf. <CAL71e4MrVqC1=AR6x0_8S=8kVqPdDkhgCZRb4etFsxTzd6s_8Q@mail.gmail.com>
 source: <pull.2123.git.1779625693328.gitgitgadget@gmail.com>


* lp/repack-propagate-promisor-debugging-info (2026-04-18) 6 commits
 - repack-promisor: add missing headers
 - t7703: test for promisor file content after geometric repack
 - t7700: test for promisor file content after repack
 - repack-promisor: preserve content of promisor files after repack
 - repack-promisor add helper to fill promisor file after repack
 - pack-write: add explanation to promisor file content

 When fetching objects into a lazily cloned repository, .promisor
 files are created with information meant to help debugging.  "git
 repack" has been taught to carry this information forward to
 packfiles that are newly created.

 Retracted.
 cf. <agx_GPfBKpkSc3Gx@lorenzo-VM>
 source: <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>
