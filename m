Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568751ABEA6
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731052998; cv=none; b=Fxe/4PWH9YQAr/yZNZVwEibQ1NB9C4t1QolYbvFX++wOlLSXBz5AX0fQa+KJpYXfZyaf7tsO4rb+nxhm6w+gIO1nkl9kc8tL/Jdic5HB+mWQmBdFyJXTOzaBavzvd+BQ/zFa2pyemmpRhGnFi83KzboUjgmSHuc1CpMF438EJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731052998; c=relaxed/simple;
	bh=EpqsMctIoPhgazzIESrOnyz7m20reQa4IcRWBhe4YKk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t0KAT26tHtd4nHXcY/Rm4dfITk59ehn0aoT3LtXdAxaAax9o7NZ4YWH855OZyIv6vTY4F/Dq2aHg3LPBRLPPSEUPI2F9iZfBq8y4UkOurxWSILTV65+sVfnG1g1C9s0dAIPRmTFgRl0YXq+6SnWphH63c9XB3AZox0otgVz/Ixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WqN4IUyD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XyR4qfmz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WqN4IUyD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XyR4qfmz"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6020411400DA;
	Fri,  8 Nov 2024 03:03:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 08 Nov 2024 03:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1731052994; x=1731139394; bh=vsEnkr/Py1
	gRQxVothuMSRoSV2KMVUj87UHUZI1o8Cw=; b=WqN4IUyDGOQUq9VHZcr+bbBpXQ
	vC4NcKJi6/K7r5DHFmcWVPBEiC6h9SwMT3s5aEYS6azBk0LefJi8Z//Utd5r4tiq
	7e6T8iEd3nYBKRpRPTXkWUu3V9hyHYWXnse6CHM2eF53tetlsdXRjWkpMxHt7iXY
	hBk9B0d94WXw29fkko/sqF35w7MGctOk6v5vMUz3aJXNP3x4qybY3xcY5qWAdX/M
	mDFFHSQJhIDp4RoIfUo6+Ocdw+lBEPSNk9kQXO7FGf5/SSB+sa6qhDhTc14vpcri
	j7nSFdYLtA9RMe+DhMR4eUvMM8APh+JAtlaUWJoB1nT9KFfK8SjI0wJ0+iPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731052994; x=1731139394; bh=vsEnkr/Py1gRQxVothuMSRoSV2KMVUj87UH
	UZI1o8Cw=; b=XyR4qfmzKTUmG6paUUn96OsTAUBV0y4ogRatZy/CptUHdYp3ZYq
	StVX68EFfNnGLEgqLW8IOct/DenlyuxZVX2QXZbv4IYnVeaohp9/3YofayYVRRmM
	tKknLXOP2zA+MP0vMnmptshj1QMj+2uZ5HVY335kdVdtFvKndWSqQiSbMx5H3H63
	M3Q2galmglbrsnT+/JaNPNSZwYQ17LedAyRFcJNEy7c6zgstf1+b80Tz0B7FgyYE
	fO5+KUn1zf+3PpfUfco+DDGtyQ8D4GPmP1yl9zVG2X94xrJ0A1FlucNRS80HEZ4N
	0SsUO9jH4bKUTQuFQ2PzrBljQqjlByB7Ufw==
X-ME-Sender: <xms:wcUtZ8IIruSdWeIzLXkI8I7i2_NU_HYLxMfntHuJMw5_es7fbxMyvg>
    <xme:wcUtZ8IixlCTFmevKw334NyBbqaAWAos0PKGZsOh4CpjHJZlu6Xzt71qnunCGHPVD
    aS_fhZ1o6LxQ_KsOQ>
X-ME-Received: <xmr:wcUtZ8twz6V2CiyCxDEYCVU12q494pV42HJ06EbJyWuCjdWVv3RufZeoPip60nr64pR87wuDBe2G4ynmn2idhq1BUDepo_9X9rD2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcu
    oehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffffve
    eigeefhfffkedtkeelheelgfeiieehleetveefuefgvddtkeetvefgueenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhorhdrtgiipdhgohhoghhlvghsohhurhgtvgdrtghomh
    dpghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhdptghlrghrqdguvggtlhhsrdhh
    thdpphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlfihnsehlfihnrdhnvghtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wsUtZ5bUsEK-Dj_Vd33ncFyvU3he2ydeHQWVIpwzixturwkpFljUgQ>
    <xmx:wsUtZzYM1Y7ApHHZhXJIX2Yqycn-nxovQptAAtY9hmHIEgAa8Gamlw>
    <xmx:wsUtZ1BTXdDt501bDFnNfONzJTAtjtTKi2Kz-of8tYZynxE_EcDaRA>
    <xmx:wsUtZ5bq8zDv7a25qfUNbhRL83pi1rE1Hzsxbz4NF_b-SumviBjGOQ>
    <xmx:wsUtZ_HS_nKM_CYftOSA4qCvAcmLPuweIO5Vx2ucQ-aewOaGxS5CPRtY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 03:03:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2024, #04; Fri, 8)
X-master-at: facbe4f633e4ad31e641f64617bc88074c659959
X-next-at: 60cca158198dd42396c273ab7a273339f8157e86
Date: Fri, 08 Nov 2024 17:03:12 +0900
Message-ID: <xmqqbjyqnoe7.fsf@gitster.g>
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
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

It has been a bit longer than usual since the last issue of the
"What's cooking report".  We still have way too many topics that are
not sufficiently reviewed.  Help is greatly appreciated.

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

* cw/config-extensions (2024-10-22) 1 commit
  (merged to 'next' on 2024-10-30 at 875fa0b619)
 + doc: consolidate extensions in git-config documentation
 (this branch is used by cw/worktree-extension.)

 Centralize documentation for repository extensions into a single place.
 source: <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me>


* jk/left-right-bitmap (2024-11-01) 1 commit
  (merged to 'next' on 2024-11-01 at f1d0c395f5)
 + rev-list: skip bitmap traversal for --left-right

 When called with '--left-right' and '--use-bitmap-index', 'rev-list'
 will produce output without any left/right markers, which has been
 corrected.
 source: <20241101121606.GA2327410@coredump.intra.peff.net>


* kn/arbitrary-suffixes (2024-10-24) 1 commit
  (merged to 'next' on 2024-10-30 at 3eedf30c6c)
 + CodingGuidelines: discourage arbitrary suffixes in function names

 Update the project's CodingGuidelines to discourage naming functions
 with a "_1()" suffix.
 source: <20241024105357.2605168-1-karthik.188@gmail.com>


* kn/ci-clang-format-tidy (2024-10-18) 2 commits
  (merged to 'next' on 2024-10-30 at d063e828d5)
 + clang-format: align consecutive macro definitions
 + clang-format: re-adjust line break penalties

 Updates the '.clang-format' to match project conventions.
 source: <cover.1729241030.git.karthik.188@gmail.com>


* ps/upgrade-clar (2024-10-21) 5 commits
  (merged to 'next' on 2024-10-30 at b8b092bb78)
 + cmake: set up proper dependencies for generated clar headers
 + cmake: fix compilation of clar-based unit tests
 + Makefile: extract script to generate clar declarations
 + Makefile: adjust sed command for generating "clar-decls.h"
 + t/unit-tests: update clar to 206accb
 (this branch is used by ps/build.)

 Buildfix and upgrade of Clar to a newer version.
 source: <cover.1729506329.git.ps@pks.im>

--------------------------------------------------
[New Topics]

* ps/reftable-iterator-reuse (2024-11-05) 9 commits
 - refs/reftable: reuse iterators when reading refs
 - reftable/merged: drain priority queue on reseek
 - reftable/stack: add mechanism to notify callers on reload
 - refs/reftable: refactor reflog expiry to use reftable backend
 - refs/reftable: refactor reading symbolic refs to use reftable backend
 - refs/reftable: read references via `struct reftable_backend`
 - refs/reftable: handle reloading stacks in the reftable backend
 - refs/reftable: encapsulate reftable stack
 - Merge branch 'ps/reftable-detach' into HEAD
 (this branch uses ps/reftable-detach.)

 Optimize reading random references out of the reftable backend by
 allowing reuse of iterator objects.

 Needs review.
 source: <cover.1730792627.git.ps@pks.im>


* jc/move-is-bare-repository-cfg-variable-to-repo (2024-11-07) 3 commits
 - repository: BUG when is_bare_cfg is not initialized
 - setup: initialize is_bare_cfg
 - git: remove is_bare_repository_cfg global variable

 Code rewrite to turn the is_bare_repository_cfg global variable
 into a member in the the_repo singleton repository object.

 Waiting for response to reviews.
 source: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>


* jk/describe-perf (2024-11-07) 4 commits
 - describe: stop traversing when we run out of names
 - describe: stop digging for max_candidates+1
 - t/perf: add tests for git-describe
 - t6120: demonstrate weakness in disjoint-root handling

 "git describe" optimization.

 Expecting a reroll.
 cf <20241106192650.GA912471@coredump.intra.peff.net>
 source: <20241106192236.GC880133@coredump.intra.peff.net>


* js/range-diff-diff-merges (2024-11-08) 1 commit
 - range-diff: optionally include merge commits' diffs in the analysis

 "git range-diff" learned to optionally show and compare merge
 commits in the ranges being compared, with the --diff-merges
 option.

 Waiting for response to reviews.
 source: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>


* ps/leakfixes-part-10 (2024-11-07) 27 commits
 - t: remove TEST_PASSES_SANITIZE_LEAK annotations
 - test-lib: unconditionally enable leak checking
 - t: remove unneeded !SANITIZE_LEAK prerequisites
 - t: mark some tests as leak free
 - t5601: work around leak sanitizer issue
 - git-compat-util: drop `UNLEAK()` annotation
 - t/helper: fix leaking commit graph in "read-graph" subcommand
 - builtin/branch: fix leaking sorting options
 - builtin/init-db: fix leaking directory paths
 - builtin/help: fix leaks in `check_git_cmd()`
 - help: fix leaking return value from `help_unknown_cmd()`
 - help: fix leaking `struct cmdnames`
 - help: refactor to not use globals for reading config
 - builtin/sparse-checkout: fix leaking sanitized patterns
 - split-index: fix memory leak in `move_cache_to_base_index()`
 - git: refactor builtin handling to use a `struct strvec`
 - git: refactor alias handling to use a `struct strvec`
 - strvec: introduce new `strvec_splice()` function
 - line-log: fix leak when rewriting commit parents
 - bisect: fix various cases where we leak commit list items
 - bisect: fix leaking commit list items in `check_merge_base()`
 - bisect: fix multiple leaks in `bisect_next_all()`
 - bisect: fix leaking `current_bad_oid`
 - bisect: fix leaking string in `handle_bad_merge_base()`
 - bisect: fix leaking good/bad terms when reading multipe times
 - builtin/blame: fix leaking blame entries with `--incremental`
 - Merge branch 'ps/leakfixes-part-9' into ps/leakfixes-part-10
 (this branch uses ps/leakfixes-part-9.)

 Leakfixes.

 Needs review.
 source: <cover.1730901926.git.ps@pks.im>

--------------------------------------------------
[Cooking]

* ak/t1016-style (2024-11-03) 1 commit
  (merged to 'next' on 2024-11-05 at ee100e90d3)
 + t1016: clean up style

 Test modernization.

 Will merge to 'master'.
 source: <20241103135111.13508-1-algonell@gmail.com>


* en/shallow-exclude-takes-a-ref-fix (2024-11-04) 2 commits
  (merged to 'next' on 2024-11-05 at 8c5d52930b)
 + doc: correct misleading descriptions for --shallow-exclude
 + upload-pack: fix ambiguous error message

 The "--shallow-exclude=<ref>" option to various history transfer
 commands takes a ref, not an arbitrary revision.

 Will merge to 'master'.
 source: <pull.1822.git.1730746964.gitgitgadget@gmail.com>


* kh/sequencer-comment-char (2024-10-23) 1 commit
 - sequencer: comment checked-out branch properly

 The sequencer failed to honor core.commentString in some places.

 Expecting a reroll.
 cf. <c05e603f-1fd4-4ad2-ba03-21269f464ed2@gmail.com>
 source: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>


* ds/full-name-hash (2024-11-04) 7 commits
 - test-tool: add helper for name-hash values
 - pack-objects: disable --full-name-hash when shallow
 - p5313: add size comparison test
 - git-repack: update usage to match docs
 - pack-objects: add GIT_TEST_FULL_NAME_HASH
 - repack: add --full-name-hash option
 - pack-objects: add --full-name-hash option

 "git pack-objects" and its wrapper "git repack" learned an option
 to use an alternative path-hash function to improve delta-base
 selection to produce a packfile with deeper history than window
 size.

 Needs review.
 source: <pull.1823.git.1730775907.gitgitgadget@gmail.com>


* jt/repack-local-promisor (2024-11-03) 5 commits
 - fixup! index-pack: repack local links into promisor packs
 - index-pack: repack local links into promisor packs
 - t5300: move --window clamp test next to unclamped
 - t0410: use from-scratch server
 - t0410: make test description clearer

 "git gc" discards any objects that are outside promisor packs that
 are referred to by an object in a promisor pack, and we do not
 refetch them from the promisor at runtime, resulting an unusable
 repository.  Work it around by including these objects in the
 referring promisor pack at the receiving end of the fetch.

 Will merge to 'next' when the CI breakage fixup is addressed.
 Breaks CI (with a known fix).
 source: <cover.1730491845.git.jonathantanmy@google.com>


* ds/path-walk-1 (2024-10-31) 6 commits
 - path-walk: mark trees and blobs as UNINTERESTING
 - path-walk: visit tags and cached objects
 - path-walk: allow consumer to specify object types
 - t6601: add helper for testing path-walk API
 - test-lib-functions: add test_cmp_sorted
 - path-walk: introduce an object walk by path

 Introduce a new API to visit objects in batches based on a common
 path, or by type.

 Under discussion.
 cf. <ZyUqr/wb5K4Og9j9@nand.local>
 source: <pull.1818.git.1730356023.gitgitgadget@gmail.com>


* bc/ancient-ci (2024-11-01) 3 commits
 - Add additional CI jobs to avoid accidental breakage
 - ci: remove clause for Ubuntu 16.04
 - gitlab-ci: switch from Ubuntu 16.04 to 20.04

 Drop support for ancient environments in various CI jobs.

 Needs review.
 source: <20241031234934.3451390-1-sandals@crustytoothpaste.net>


* cw/worktree-extension (2024-11-01) 9 commits
 - worktree: refactor `repair_worktree_after_gitdir_move()`
 - worktree: add relative cli/config options to `repair` command
 - worktree: add relative cli/config options to `move` command
 - worktree: add relative cli/config options to `add` command
 - worktree: add `write_worktree_linking_files()` function
 - worktree: refactor infer_backlink return
 - worktree: add `relativeWorktrees` extension
 - setup: correctly reinitialize repository version
 - Merge branch 'cw/config-extensions' into cw/worktree

 Introduce a new repository extension to prevent older Git versions
 from mis-interpreting worktrees created with relative paths.

 Needs review.
 source: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>


* kh/bundle-docs (2024-11-08) 4 commits
 - Documentation/git-bundle.txt: discuss naïve backups
 - Documentation/git-bundle.txt: mention --all in spec. refs
 - Documentation/git-bundle.txt: remove old `--all` example
 - Documentation/git-bundle.txt: mention full backup example

 Documentation improvements to more prominently call out the use of
 '--all' when creating bundles.

 Will merge to 'next'?
 source: <cover.1730979849.git.code@khaugsbakk.name>


* as/show-index-uninitialized-hash (2024-11-04) 2 commits
 - t5300: add test for 'show-index --object-format'
 - show-index: fix uninitialized hash function

 Regression fix for 'show-index' when run outside of a repository.

 Expecting a reroll.
 cf. <xmqq4j4mv5o6.fsf@gitster.g>
 source: <20241104192958.64310-1-abhijeet.nkt@gmail.com>


* ps/mingw-rename (2024-11-06) 3 commits
  (merged to 'next' on 2024-11-06 at 6dd2fffec7)
 + compat/mingw: support POSIX semantics for atomic renames
 + compat/mingw: allow deletion of most opened files
 + compat/mingw: share file handles created via `CreateFileW()`

 Teaches the MinGW compatibility layer to support POSIX semantics for
 atomic renames when other process(es) have a file opened at the
 destination path.

 Will merge to 'master'.
 cf. <1483501d-d798-46d6-93f5-f5edaf915e99@kdbg.org>
 source: <cover.1730042775.git.ps@pks.im>


* ps/reftable-detach (2024-10-23) 8 commits
 - reftable/system: provide thin wrapper for lockfile subsystem
 - reftable/stack: drop only use of `get_locked_file_path()`
 - reftable/system: provide thin wrapper for tempfile subsystem
 - reftable/stack: stop using `fsync_component()` directly
 - reftable/system: stop depending on "hash.h"
 - reftable: explicitly handle hash format IDs
 - reftable/system: move "dir.h" to its only user
 - Merge branch 'ps/reftable-strbuf' into ps/reftable-detach
 (this branch is used by ps/reftable-iterator-reuse.)

 Isolates the reftable subsystem from the rest of Git's codebase by
 using fewer pieces of Git's infrastructure.

 Needs review.
 source: <cover.1729677003.git.ps@pks.im>


* km/config-remote-by-name (2024-10-21) 1 commit
 - config: support remote name in includeIf.hasconfig condition

 Support conditionally including configuration by remote name, instead
 of just URL.

 Needs review.
 source: <20241020173216.40852-2-ken@kmatsui.me>


* ps/leakfixes-part-9 (2024-11-04) 22 commits
  (merged to 'next' on 2024-11-05 at 0260dbd8bd)
 + list-objects-filter-options: work around reported leak on error
 + builtin/merge: release output buffer after performing merge
 + dir: fix leak when parsing "status.showUntrackedFiles"
 + t/helper: fix leaking buffer in "dump-untracked-cache"
 + t/helper: stop re-initialization of `the_repository`
 + sparse-index: correctly free EWAH contents
 + dir: release untracked cache data
 + combine-diff: fix leaking lost lines
 + builtin/tag: fix leaking key ID on failure to sign
 + transport-helper: fix leaking import/export marks
 + builtin/commit: fix leaking cleanup config
 + trailer: fix leaking strbufs when formatting trailers
 + trailer: fix leaking trailer values
 + builtin/commit: fix leaking change data contents
 + upload-pack: fix leaking URI protocols
 + pretty: clear signature check
 + diff-lib: fix leaking diffopts in `do_diff_cache()`
 + revision: fix leaking bloom filters
 + builtin/grep: fix leak with `--max-count=0`
 + grep: fix leak in `grep_splice_or()`
 + t/helper: fix leaks in "reach" test tool
 + builtin/ls-remote: plug leaking server options
 (this branch is used by ps/leakfixes-part-10.)

 More leakfixes.

 Will merge to 'master'.
 source: <cover.1730786195.git.ps@pks.im>


* y5/diff-pager (2024-10-21) 1 commit
 - diff: setup pager only before diff contents truly ready

 Delay setting up the pager in 'git diff' until after the diff contents
 itself is fully prepared.

 Needs review.
 source: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>


* la/trailer-info (2024-10-14) 1 commit
 - trailer: spread usage of "trailer_block" language

 Refactoring.

 Needs review.
 source: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com>


* bc/drop-ancient-libcurl-and-perl (2024-10-23) 12 commits
 - gitweb: make use of s///r
 - Require Perl 5.26.0
 - INSTALL: document requirement for libcurl 7.61.0
 - git-curl-compat: remove check for curl 7.56.0
 - git-curl-compat: remove check for curl 7.53.0
 - git-curl-compat: remove check for curl 7.52.0
 - git-curl-compat: remove check for curl 7.44.0
 - git-curl-compat: remove check for curl 7.43.0
 - git-curl-compat: remove check for curl 7.39.0
 - git-curl-compat: remove check for curl 7.34.0
 - git-curl-compat: remove check for curl 7.25.0
 - git-curl-compat: remove check for curl 7.21.5

 Drop support for older libcURL and Perl.

 Under discussion.
 source: <20241023004600.1645313-1-sandals@crustytoothpaste.net>


* es/oss-fuzz (2024-10-16) 3 commits
 - fuzz: port fuzz-url-decode-mem from OSS-Fuzz
 - fuzz: port fuzz-parse-attr-line from OSS-Fuzz
 - fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz

 Backport oss-fuzz tests for us to our codebase.

 Needs review.
 source: <cover.1728939687.git.steadmon@google.com>


* bf/set-head-symref (2024-10-23) 8 commits
 - fetch set_head: handle mirrored bare repositories
 - fetch: set remote/HEAD if it does not exist
 - refs: add create_only option to refs_update_symref_extended
 - refs: add TRANSACTION_CREATE_EXISTS error
 - remote set-head: better output for --auto
 - remote set-head: refactor for readability
 - refs: atomically record overwritten ref in update_symref
 - t/t5505-remote: set default branch to main

 When "git fetch $remote" notices that refs/remotes/$remote/HEAD is
 missing and discovers what branch the other side points with its
 HEAD, refs/remotes/$remote/HEAD is updated to point to it.

 Needs review.
 source: <20241023153736.257733-1-bence@ferdinandy.com>


* ps/build (2024-10-24) 21 commits
 - meson: fix conflicts with in-flight topics
 - Introduce support for the Meson build system
 - Documentation: add comparison of build systems
 - t: allow overriding build dir
 - t: better support for out-of-tree builds
 - Documentation: extract script to generate a list of mergetools
 - Documentation: teach "cmd-list.perl" about out-of-tree builds
 - Documentation: allow sourcing generated includes from separate dir
 - Makefile: simplify building of templates
 - Makefile: allow "bin-wrappers/" directory to exist
 - Makefile: refactor generators to be PWD-independent
 - Makefile: refactor GIT-VERSION-GEN to be reusable
 - Makefile: extract script to generate gitweb.cgi
 - Makefile: extract script to massage Shell scripts
 - Makefile: use "generate-perl.sh" to massage Perl library
 - Makefile: extract script to massage Perl scripts
 - Makefile: consistently use PERL_PATH
 - Makefile: consistently use @PLACEHOLDER@ to substitute
 - Makefile: use common template for GIT-BUILD-OPTIONS
 - Merge branch 'ps/platform-compat-fixes' into ps/build
 - Merge branch 'ps/upgrade-clar' into ps/build

 Build procedure update plus introduction of Mason based builds

 Under discussion.
 source: <cover.1729771605.git.ps@pks.im>


* ej/cat-file-remote-object-info (2024-10-31) 6 commits
 - cat-file: add remote-object-info to batch-command
 - cat-file: add declaration of variable i inside its for loop
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing

 "git cat-file --batch" and friends can optionally ask a remote
 server about objects it does not have.

 Needs review.
 source: <20241028203457.19715-1-eric.peijian@gmail.com>


* cc/promisor-remote-capability (2024-09-10) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Comments?  I got an impression that this is premature without
 finishing the discussion on a larger picture.
 cf. <ZvpZv_fed_su4w2-@pks.im>
 source: <20240910163000.1985723-1-christian.couder@gmail.com>


* sj/ref-contents-check (2024-10-21) 9 commits
 - ref: add symlink ref content check for files backend
 - ref: check whether the target of the symref is a ref
 - ref: add basic symref content check for files backend
 - ref: add more strict checks for regular refs
 - ref: port git-fsck(1) regular refs check for files backend
 - ref: support multiple worktrees check for refs
 - ref: initialize target name outside of check functions
 - ref: check the full refname instead of basename
 - ref: initialize "fsck_ref_report" with zero

 "git fsck" learned to issue warnings on "curiously formatted" ref
 contents that have always been taken valid but something Git
 wouldn't have written itself (e.g., missing terminating end-of-line
 after the full object name).

 Needs review.
 cf. <ZxZ+xteOnm0im5vC@nand.local>
 source: <ZxZX5HDdq_R0C77b@ArchLinux>


* js/libgit-rust (2024-10-16) 5 commits
 - Makefile: add option to build and test libgit-rs and libgit-rs-sys
 - libgit: add higher-level libgit crate
 - libgit-sys: also export some config_set functions
 - libgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Needs review.
 source: <cover.1729032373.git.steadmon@google.com>


* jt/commit-graph-missing (2024-11-05) 2 commits
  (merged to 'next' on 2024-11-06 at b4dd083c2a)
 + fetch-pack: die if in commit graph but not obj db
 + Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"

 A regression where commit objects missing from a commit-graph can
 cause an infinite loop when doing a fetch in a partial clone has
 been fixed.

 Will merge to 'master'.
 source: <cover.1730833754.git.jonathantanmy@google.com>


* kn/the-repository (2024-11-08) 9 commits
 - midx: add repository to `multi_pack_index` struct
 - config: make `packed_git_(limit|window_size)` non-global variables
 - config: make `delta_base_cache_limit` a non-global variable
 - packfile: pass down repository to `for_each_packed_object`
 - packfile: pass down repository to `has_object[_kept]_pack`
 - packfile: pass down repository to `odb_pack_name`
 - packfile: pass `repository` to static function in the file
 - packfile: use `repository` from `packed_git` directly
 - packfile: add repository to struct `packed_git`

 Various implicit uses of 'the_repoository' in the packfile code
 have been eliminated.

 Needs review.
 source: <cover.1730976185.git.karthik.188@gmail.com>
