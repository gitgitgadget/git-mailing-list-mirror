Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233051D1311
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890497; cv=none; b=Xv1aBEZfMa/ihcf8o0zZWVOF+HwuZsqCYlN9AxkxlJ2vPD0bmUY6fnwKAtw580h5yZUCxD5A8X3nfK1WEViOdMj9kcTrHRRGMTq1iXqfKkKZwSOV55lHoF52XgAmNkYIxpDnC+vMKM8CWsP/mFr4ePN22/efkvWM+MC9p37MCYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890497; c=relaxed/simple;
	bh=+oIV01fRUlb/dUUPMhRbQgrPaCrqtNwz3zBo9nsAnoM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=itvevMPd1XMd1M/DoGTvBDzCkKnrHXXJRhr0O9Dq/y5UU4BxeeczENe3sofeqH1nSr/+d+4gYRIfhJKZjue1iNjBt9ohmIvl7Ln8l9GM9y20k8GHOVnVjTbqT7BYgirGOoU+bKjWErNR/zsCh3my+KKDfXdM+f46Jjf9tz91K7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bm7BOIBj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e91QL1ZL; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bm7BOIBj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e91QL1ZL"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 28E441380227;
	Wed,  2 Oct 2024 13:34:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 02 Oct 2024 13:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1727890492; x=1727976892; bh=QzjBwWv7B1UXlrTFihDjkOCDMKUgZSU1
	omSDtewUYeE=; b=Bm7BOIBj3JoJ4vPzXKHMLVJVCUsZM+YoORlRD8jVaIeOqWmY
	dW0iuWUIvtfpiI1S74mQ561Yu0phVX5B9Go7tObNXkURmY1+zxCh+KN6KHFAMFvc
	8izBPhYDKkmsyyfDwxC7sNZyXAp0eEAAo1EWmKLnEfxxyFGORz8Za++wmksdtU4d
	GjIXFLXerIKf7CSBIROa5Prjdm0s2U6pu9IDj0QXX9vWFpZhivyJsnqdTISOUWTB
	CxFWJ1pfM0m2VIwFsAbDHlwhBa7e0NVyO20IVx4fnEm5tpVJVTRB+gnw049IHJBB
	fNAw0z/1gMXSsQOFPWzjbq8DoAwuVfDzMplpdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1727890492; x=1727976892; bh=QzjBwWv7B1UXlrTFihDjkOCDMKUgZSU1omS
	DtewUYeE=; b=e91QL1ZLFpyzvSp7D2ffNbJVMDJM1tE4kAMGRVZZnrT/yOLeCh7
	jnAfdsJYPbRQEMvZntbHWtCCzEjqjxOXqgntCxVv/Jb7OvN8gA8zmw7vi6BIGLSU
	i2SeicCZxa7Bhvi40FomyNvjFNM1cjSJCWMrzC15VtzLZ6y0CjQBDbN12MwXUcOW
	cUjI75TChowJhYCCNZSDcvl6JEFvMc9Sv1r1dHPRYfBr/VixwMqEugFpObkPtavn
	0s834/uXXGOISPBwf1dLkpbMb0e+r3ZwyNx93GiYHB9jnOaxia1W9+RO1x9YcURV
	zEypRhE3zlBrUCqNz5QD8zvHyRVDkTgxxfg==
X-ME-Sender: <xms:O4T9ZoF28lcfzNie40Jq5PSu2GO2NnQ_ohF8uTGXCoyoWnP0fDWEag>
    <xme:O4T9ZhV3lq1lSS1TKqxunAGnK1gReO0c5JpvgyoWxaVB_ETr2_HVoLg84hd16etho
    A1ylogQ8ioXOB4bfQ>
X-ME-Received: <xmr:O4T9ZiLqyQw3PEEGces0sj7WQFo_vsVb_Jjqy5GOC0Aozq5t4KKKa4BqVZBiILfxDinCprnkL5fYbyKxDABiPT1VGuAOCYvmZfuTxQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcu
    oehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefhudeutd
    evvdevgfehkeeludettedthffhtddvheeivddtgefhtdfffeegieffheenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhorhdrtgiipdhgohhoghhlvghsohhurhgtvgdrtghomh
    dpghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhdpphhkshdrihhmnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlfi
    hnsehlfihnrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:O4T9ZqGojnKp2HKjeh8AgdQRtCuMxLbyHwuuMNIHmSS0f906WT1YMw>
    <xmx:O4T9ZuU27kDHmKjWqU2yAoLQ6Yr7FOMvW2JzBoMnIUgfUk15BAxTyA>
    <xmx:O4T9ZtO5wVyWlM-EBfxVsUIq_SccE_HBnhlTavXadJsCWgEXN1uDPw>
    <xmx:O4T9Zl1CkUbk-DffYU0lFdHPvUnzMf8V3K-nJ9_HAz3V8oqtSRyg6w>
    <xmx:PIT9ZtRmihXjOgdAuPAAuWO1PsTJL4SpJvSECKo1qZFPz2Smu2U2tHId>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 13:34:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2024, #02; Wed, 2)
X-master-at: 111e864d69c84284441b083966c2065c2e9a4e78
X-next-at: 43b9d002c88c60350760fe38edf0e36e2e3da4bb
Date: Wed, 02 Oct 2024 10:34:50 -0700
Message-ID: <xmqqfrpeo1c5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Git 2.47-rc1 has been tagged.  From here on, we expect the flow of
new topics to slow down and contributors are encouraged to focus
more on finding and fixing possible regressions relative to Git
2.46, the last feature release.

Unfortunately our CI jobs seem to be failing due to
https://lore.kernel.org/git/xmqqmsk37926.fsf@gitster.g/

The regression in libCurl 8.10.0 has been identified and corrected
in the upstream, but apparently it takes time for the fix to
percolate down.

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

* ds/sparse-checkout-expansion-advice (2024-09-23) 1 commit
  (merged to 'next' on 2024-09-27 at e670bccf7e)
 + sparse-checkout: disable advice in 'disable'

 When "git sparse-checkout disable" turns a sparse checkout into a
 regular checkout, the index is fully expanded.  This totally
 expected behaviour however had an "oops, we are expanding the
 index" advice message, which has been corrected.
 source: <pull.1800.git.1727119882901.gitgitgadget@gmail.com>


* jk/http-leakfixes (2024-09-25) 28 commits
  (merged to 'next' on 2024-09-27 at c52b418c92)
 + http-push: clean up local_refs at exit
 + http-push: clean up loose request when falling back to packed
 + http-push: clean up objects list
 + http-push: free xml_ctx.cdata after use
 + http-push: free remote_ls_ctx.dentry_name
 + http-push: free transfer_request strbuf
 + http-push: free transfer_request dest field
 + http-push: free curl header lists
 + http-push: free repo->url string
 + http-push: clear refspecs before exiting
 + http-walker: free fake packed_git list
 + remote-curl: free HEAD ref with free_one_ref()
 + http: stop leaking buffer in http_get_info_packs()
 + http: call git_inflate_end() when releasing http_object_request
 + http: fix leak of http_object_request struct
 + http: fix leak when redacting cookies from curl trace
 + transport-helper: fix leak of dummy refs_list
 + fetch-pack: clear pack lockfiles list
 + fetch: free "raw" string when shrinking refspec
 + transport-helper: fix strbuf leak in push_refs_with_push()
 + send-pack: free cas options before exit
 + commit: avoid leaking already-saved buffer
 + fetch-pack, send-pack: clean up shallow oid array
 + fetch-pack: free object filter before exiting
 + connect: clear child process before freeing in diagnostic mode
 + fetch-pack: fix leaking sought refs
 + shallow: fix leak when unregistering last shallow root
 + http-fetch: clear leaking git-index-pack(1) arguments
 (this branch is used by ps/leakfixes-part-8.)

 Leakfixes.
 source: <20240924214930.GA1143523@coredump.intra.peff.net>


* ps/leakfixes-part-7 (2024-09-27) 24 commits
  (merged to 'next' on 2024-09-27 at 8c1aa7e558)
 + diffcore-break: fix leaking filespecs when merging broken pairs
 + revision: fix leaking parents when simplifying commits
 + builtin/maintenance: fix leak in `get_schedule_cmd()`
 + builtin/maintenance: fix leaking config string
 + promisor-remote: fix leaking partial clone filter
 + grep: fix leaking grep pattern
 + submodule: fix leaking submodule ODB paths
 + trace2: destroy context stored in thread-local storage
 + builtin/difftool: plug several trivial memory leaks
 + builtin/repack: fix leaking configuration
 + diffcore-order: fix leaking buffer when parsing orderfiles
 + parse-options: free previous value of `OPTION_FILENAME`
 + diff: fix leaking orderfile option
 + builtin/pull: fix leaking "ff" option
 + dir: fix off by one errors for ignored and untracked entries
 + builtin/submodule--helper: fix leaking remote ref on errors
 + t/helper: fix leaking subrepo in nested submodule config helper
 + builtin/submodule--helper: fix leaking error buffer
 + builtin/submodule--helper: clear child process when not running it
 + submodule: fix leaking update strategy
 + git: fix leaking argv when handling builtins
 + builtin/help: fix leaking `html_path` when reading config multiple times
 + builtin/help: fix dangling reference to `html_path`
 + Merge branch 'ps/leakfixes-part-6' into ps/leakfixes-part-7
 (this branch is used by ps/leakfixes-part-8.)

 More leak-fixes.
 cf. <ZulXjXSozNrXgMUM@pks.im>
 source: <cover.1727351062.git.ps@pks.im>


* tb/weak-sha1-for-tail-sum (2024-09-27) 8 commits
  (merged to 'next' on 2024-09-30 at 1b4caadd94)
 + csum-file.c: use unsafe SHA-1 implementation when available
 + Makefile: allow specifying a SHA-1 for non-cryptographic uses
 + hash.h: scaffolding for _unsafe hashing variants
 + sha1: do not redefine `platform_SHA_CTX` and friends
 + pack-objects: use finalize_object_file() to rename pack/idx/etc
 + finalize_object_file(): implement collision check
 + finalize_object_file(): refactor unlink_or_warn() placement
 + finalize_object_file(): check for name collision before renaming

 The checksum at the tail of files are now computed without
 collision detection protection.  This is safe as the consumer of
 the information to protect itself from replay attacks checks for
 hash collisions independently.
 cf. <20240927035712.GH567395@coredump.intra.peff.net>
 cf. <CABPp-BH3y96DjapzLPJ+vCoChQiD_wR9uLc3QPsXqzSUr4AFvQ@mail.gmail.com>
 source: <cover.1727364141.git.me@ttaylorr.com>

--------------------------------------------------
[New Topics]

* ds/read-cache-mempool-leakfix (2024-10-01) 1 commit
  (merged to 'next' on 2024-10-02 at c0eac890ac)
 + read-cache: free threaded memory pool

 Leakfix.

 Will merge to 'master'.
 source: <pull.1801.v2.git.1727804265033.gitgitgadget@gmail.com>


* kn/fsmonitor-event-listener-fix (2024-10-02) 1 commit
 - fsmonitor: fix hangs by delayed fs event listening

 Under high load, fsmonitor process can hang at start-up, which has
 been corrected.

 Comments?
 source: <pull.1804.git.1727862424713.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* jc/a-commands-without-the-repo (2024-09-30) 4 commits
 - archive: remove the_repository global variable
 - apply: remove the_repository global variable
 - annotate: remove usage of the_repository global
 - git: pass in repo for RUN_SETUP_GENTLY

 Commands that can also work outside Git have learned to take the
 repository instance "repo" when we know we are in a repository, and
 NULL when we are not, in a parameter.  The uses of the_repository
 variable in a few of them have been removed using the new calling
 convention.

 Comments?
 source: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>


* kn/osx-fsmonitor-with-submodules-fix (2024-10-01) 1 commit
 - fsmonitor OSX: fix hangs for submodules

 macOS with fsmonitor daemon can hang forever when a submodule is
 involved, which has been corrected.

 Expecting a reroll.
 cf. <CAOTNsDygwBkNdFX4K_ixL5kP-AvDxWWVXkvfkmV4Kh04ozdYkA@mail.gmail.com>
 source: <pull.1802.v3.git.1727810964571.gitgitgadget@gmail.com>


* ps/leakfixes-part-8 (2024-09-30) 25 commits
 - builtin/send-pack: fix leaking list of push options
 - remote: fix leaking push reports
 - t/helper: fix leaks in proc-receive helper
 - pack-write: fix return parameter of `write_rev_file_order()`
 - revision: fix leaking saved parents
 - revision: fix memory leaks when rewriting parents
 - midx-write: fix leaking buffer
 - pack-bitmap-write: fix leaking OID array
 - pseudo-merge: fix leaking strmap keys
 - pseudo-merge: fix various memory leaks
 - line-log: fix several memory leaks
 - diff: improve lifecycle management of diff queues
 - builtin/revert: fix leaking `gpg_sign` and `strategy` config
 - t/helper: fix leaking repository in partial-clone helper
 - builtin/clone: fix leaking repo state when cloning with bundle URIs
 - builtin/pack-redundant: fix various memory leaks
 - builtin/stash: fix leaking `pathspec_from_file`
 - submodule: fix leaking submodule entry list
 - wt-status: fix leaking buffer with sparse directories
 - shell: fix leaking strings
 - scalar: fix leaking repositories
 - read-cache: fix leaking hash context in `do_write_index()`
 - builtin/annotate: fix leaking args vector
 - Merge branch 'jk/http-leakfixes' into ps/leakfixes-part-8
 - Merge branch 'ps/leakfixes-part-7' into ps/leakfixes-part-8

 More leakfixes.

 Will merge to 'next'.
 source: <cover.1727687410.git.ps@pks.im>


* tb/notes-amlog-doc (2024-09-30) 2 commits
 - Documentation: mention the amlog in howto/maintain-git.txt
 - howto-maintain: mention notes/amlog policy

 Document "amlog" notes.

 Comments?
 source: <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>


* ej/cat-file-remote-object-info (2024-09-27) 6 commits
 - cat-file: add remote-object-info to batch-command
 - cat-file: add declaration of variable i inside its for loop
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing

 "git cat-file --batch" and friends can optionally ask a remote
 server about objects it does not have.

 Comments?
 source: <20240926013856.35527-1-eric.peijian@gmail.com>


* jc/doc-discarding-stalled-topics (2024-09-26) 1 commit
  (merged to 'next' on 2024-10-02 at adb0d84fd4)
 + howto-maintain-git: discarding inactive topics

 Document that inactive topics are subject to be discarded.

 Will merge to 'master'.
 source: <xmqqikuii60q.fsf@gitster.g>


* jk/test-lsan-improvements (2024-09-25) 3 commits
  (merged to 'next' on 2024-10-02 at 3d8303fcfe)
 + test-lib: check for leak logs after every test
 + test-lib: show leak-sanitizer logs on --immediate failure
 + test-lib: stop showing old leak logs

 Usability improvements for running tests in leak-checking mode.

 Will merge to 'master'.
 source: <20240924213404.GA1142219@coredump.intra.peff.net>


* es/worktree-repair-copied (2024-09-23) 1 commit
 - worktree: repair copied repository and linked worktrees

 The heuristics in "git worktree repair" can be confused when a
 worktree and its repository are copied and break correctly
 configured worktree and repository that point at each other, which
 has been corrected.

 Needs review.
 source: <20240923075416.54289-1-ericsunshine@charter.net>


* cw/fix-reachable-in-repo-with-promisor (2024-09-19) 2 commits
 - fetch-pack.c: do not declare local commits as "have" in partial repos
 - packfile: split promisor objects oidset into two

 "git gc" in a partial clone (i.e. lacking objects that can be
 lazily fetched from promisor remotes) collected more than objects
 that promisor-remote can give.

 Needs review.
 source: <20240802073143.56731-1-hanyang.tony@bytedance.com>


* jc/breaking-changes-early-adopter-option (2024-09-19) 1 commit
 - BreakingChanges: early adopter option

 Describe the policy to introduce breaking changes.

 Comments?
 source: <xmqq7cb77810.fsf@gitster.g>


* ps/reftable-alloc-failures (2024-10-02) 27 commits
  (merged to 'next' on 2024-10-02 at a6d42d51d4)
 + reftable/basics: ban standard allocator functions
 + reftable: introduce `REFTABLE_FREE_AND_NULL()`
 + reftable: fix calls to free(3P)
 + reftable: handle trivial allocation failures
 + reftable/tree: handle allocation failures
 + reftable/pq: handle allocation failures when adding entries
 + reftable/block: handle allocation failures
 + reftable/blocksource: handle allocation failures
 + reftable/iter: handle allocation failures when creating indexed table iter
 + reftable/stack: handle allocation failures in auto compaction
 + reftable/stack: handle allocation failures in `stack_compact_range()`
 + reftable/stack: handle allocation failures in `reftable_new_stack()`
 + reftable/stack: handle allocation failures on reload
 + reftable/reader: handle allocation failures in `reader_init_iter()`
 + reftable/reader: handle allocation failures for unindexed reader
 + reftable/merged: handle allocation failures in `merged_table_init_iter()`
 + reftable/writer: handle allocation failures in `reftable_new_writer()`
 + reftable/writer: handle allocation failures in `writer_index_hash()`
 + reftable/record: handle allocation failures when decoding records
 + reftable/record: handle allocation failures on copy
 + reftable/basics: handle allocation failures in `parse_names()`
 + reftable/basics: handle allocation failures in `reftable_calloc()`
 + reftable: introduce `reftable_strdup()`
 + reftable/basics: merge "publicbasics" into "basics"
 + reftable/error: introduce out-of-memory error code
 + Merge branch 'ps/reftable-exclude' into ps/reftable-alloc-failures
 + Merge branch 'cp/unit-test-reftable-stack' into ps/reftable-alloc-failures

 The reftable library is now prepared to expect that the memory
 allocation function given to it may fail to allocate and to deal
 with such an error.

 Will cook in 'next'.
 source: <cover.1727866394.git.ps@pks.im>


* jc/strbuf-commented-something (2024-09-12) 2 commits
 - strbuf: retire strbuf_commented_lines()
 - strbuf: retire strbuf_commented_addf()

 Update two functions whose callers always pass the same global
 variable to omit the redundant parameter and use the global in the
 callee themselves.

 On hold.
 source: <20240912205301.1809355-1-gitster@pobox.com>


* cc/promisor-remote-capability (2024-09-10) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Comments?
 source: <20240910163000.1985723-1-christian.couder@gmail.com>


* ds/pack-name-hash-tweak (2024-09-19) 6 commits
 - test-tool: add helper for name-hash values
 - p5313: add size comparison test
 - git-repack: update usage to match docs
 - pack-objects: add GIT_TEST_FULL_NAME_HASH
 - repack: test --full-name-hash option
 - pack-objects: add --full-name-hash option

 In a repository with too many (more than --window size) similarly
 named files, "git repack" would not find good delta-base candidate
 and worse, it may not use a blob from exactly the same path as a
 good delta-base candidate.  Optionally replace the name hash so
 that only blobs at the same path and nothing else are used as
 delta-base candidate.

 On hold.
 cf. <34346998-deac-4e1f-9d5f-218f664e9e08@gmail.com>
 source: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>


* sj/ref-contents-check (2024-09-30) 9 commits
 - ref: add symlink ref content check for files backend
 - t0602: add ref content checks for worktrees
 - ref: enhance escape situation for worktrees
 - ref: add escape check for the referent of symref
 - ref: add basic symref content check for files backend
 - ref: add more strict checks for regular refs
 - ref: port git-fsck(1) regular refs check for files backend
 - builtin/refs: support multiple worktrees check for refs.
 - ref: initialize "fsck_ref_report" with zero

 "git fsck" learned to issue warnings on "curiously formatted" ref
 contents that have always been taken valid but something Git
 wouldn't have written itself (e.g., missing terminating end-of-line
 after the full object name).

 Needs review.
 cf. <xmqqikud6kc0.fsf@gitster.g>
 source: <Zvj-DgHqtC30KjJe@ArchLinux>


* tb/incremental-midx-part-2 (2024-08-28) 16 commits
 - fixup! midx: implement writing incremental MIDX bitmaps
 - midx: implement writing incremental MIDX bitmaps
 - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
 - pack-bitmap.c: keep track of each layer's type bitmaps
 - ewah: implement `struct ewah_or_iterator`
 - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
 - pack-bitmap.c: compute disk-usage with incremental MIDXs
 - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
 - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
 - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
 - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
 - pack-bitmap.c: open and store incremental bitmap layers
 - pack-revindex: prepare for incremental MIDX bitmaps
 - Documentation: describe incremental MIDX bitmaps
 - Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
 - Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1723760847.git.me@ttaylorr.com>


* js/libgit-rust (2024-09-09) 7 commits
 . SQUASH???
 . Makefile: add option to build and test libgit-rs and libgit-rs-sys
 . libgit: add higher-level libgit crate
 . config: add git_configset_alloc() and git_configset_clear_and_free()
 . libgit-sys: add repo initialization and config access
 . libgit-sys: introduce Rust wrapper for libgit.a
 . common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Expecting a reroll.
 cf. <xmqqv7z8tjd7.fsf@gitster.g>
 source: <20240906221853.257984-1-calvinwan@google.com>


* jc/too-many-arguments (2024-08-06) 4 commits
 - miscellaneous: avoid "too many arguments"
 - notes: avoid "too many arguments"
 - cat-file: avoid "too many arguments"
 - refs: avoid "too many arguments"

 Error message clarification.

 On hold.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* ja/doc-synopsis-markup (2024-09-24) 3 commits
  (merged to 'next' on 2024-09-30 at 15ec13edec)
 + doc: apply synopsis simplification on git-clone and git-init
 + doc: update the guidelines to reflect the current formatting rules
 + doc: introduce a synopsis typesetting

 The way AsciiDoc is used for SYNOPSIS part of the manual pages has
 been revamped.  The sources, at least for the simple cases, got
 vastly pleasant to work with.

 Will cook in 'next'.
 source: <pull.1766.v5.git.1727161730.gitgitgadget@gmail.com>


* ew/cat-file-optim (2024-08-25) 10 commits
 - cat-file: use writev(2) if available
 - cat-file: batch_write: use size_t for length
 - cat-file: batch-command uses content_limit
 - object_info: content_limit only applies to blobs
 - packfile: packed_object_info avoids packed_to_object_type
 - cat-file: use delta_base_cache entries directly
 - packfile: inline cache_or_unpack_entry
 - packfile: fix off-by-one in content_limit comparison
 - packfile: allow content-limit for cat-file
 - packfile: move sizep computation

 "git cat-file --batch" has been optimized.

 Waiting for review responses.
 source: <20240823224630.1180772-1-e@80x24.org>

--------------------------------------------------
[Discarded]

* gt/unit-test-oidset (2024-08-25) 1 commit
 . unit-tests: add tests for oidset.h

 Another unit-test.

 Has been expecting a reroll for too long.
 source: <20240824172028.39419-1-shyamthakkar001@gmail.com>
