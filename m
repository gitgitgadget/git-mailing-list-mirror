Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56521BC4E
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728095026; cv=none; b=iDH3uOqgxzyWNkPQPpPt0RqVaNTFxlpOF5435Mz5Tl59sUyRThIojok0n0i8opCfidU39ttYnK1fnL3zqoAOcPdTeHjeDROnf6G5zMgRq4/oVM+NzoQLbWPmiQRtSbXEL6viHMRYK3/v1ey3HUdBSNaS+aVlz1o+lclvgNJKgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728095026; c=relaxed/simple;
	bh=DlBhHKMblMRSMIt+MLnd4I1as0Cu9R+U/nm8jhhfA6M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iBjw6cdZFn4HFQr2hIpRL/b66yVDpM9BWbivLcvRpoLylX6Rgqzylbxyqs7pBwCjRgA75wiA+w02mUWZRaQznAulfYIVXq2Q01TlKwhRQOPZ3qkzJMpTPq0CL+156dElN7/qXZMh6SJImJTW4gZxx51c9ks2srR/7Twy4FDHSPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iYBTxJNd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bR8A1Q6b; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iYBTxJNd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bR8A1Q6b"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEC4B1140259;
	Fri,  4 Oct 2024 22:23:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 04 Oct 2024 22:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1728095021; x=1728181421; bh=g5gNy+biEjgIeTFsVtrCbJhosrsFe5UR
	96wXD1o2rOo=; b=iYBTxJNdM3cGrLh9FdBMgqGcdaaw9WODD44zaY8MZ2eT4dgo
	4Vgtlc+bTTlOgmbzqP0AKttGzCfWaFOi4HMptb9e9JVIFWIGMnPmWrHW7gjMCaEg
	3hpuA2r7F0ot3bFY71zjsIkJUhsQQ1sYdlFbtTM3l/pLR4Dug2NgfUEiMz3Tof9A
	1ywnK74n7prFFgwW6412mWABl8ndlVBvbydw2/Fd4BH/VAUhxdY9o8ZpW0pgVr5G
	GwDp57eYiE9hl7H1dL9M8v0UpFanL2dRYAEdRy6LjT+9UMK6lfhH+AThijlXynh3
	2x64xAvziA9jSNb1Lpe6hgqkeSDd9J+7ZGU1sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1728095021; x=1728181421; bh=g5gNy+biEjgIeTFsVtrCbJhosrsFe5UR96w
	XD1o2rOo=; b=bR8A1Q6bytlRgsAnopCqtGT0TxKZdrjgBdvLHTPiWEGw30aC40h
	Umgz8TGOtnc9KUBdfR+fa1h49aiNqVoSisKMgR8DEwree0JMbq2zm7xfenvQtSyt
	MMao/sDHKk62Z2MDIE+a69NzquQRYqF1mfsjVdGqfYyW8j6hqXMMxj1RjDD6CzJj
	sqhS1uy6TmBzv2UOIXqaeSAgZXyggQWnTzU12dRpkrJ8a7Z3reYtzeQquy6IM/4L
	tOMmF8wBD4c1xDcgk+bKoOoUr7AwZFKFmEu+Jr2j27SCDk15SmXEbLfA1SSR9ni5
	jMaDiCAo+cemeJOhS+QcqZS9ZNlFgMhMHhg==
X-ME-Sender: <xms:LaMAZ_5XsMMOdrD61ydn3eRknG9xn0HeNErCtPU_NjRYO3tGax8cKA>
    <xme:LaMAZ07HQWuPn0QYVknLmPzg8ZqxHNRNITaw70WUOyjO_FH4QvuIp2c0GKk3d6Mlb
    x8t_zSj91pF0gSnAw>
X-ME-Received: <xmr:LaMAZ2dIWht1_Oe-4qUqt347OJWzB31--kgq-Cf-DbxqwQCcw05L57e0iCNcWq1MW3TZiEo9oo-mVtubKvlJV6V77vtc-lrMwuqy1rY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvgedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceo
    ghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhephfduuedtve
    dvvefgheekleduteettdfhhfdtvdehiedvtdeghfdtffefgeeiffehnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpohhrrdgtiidpghhoohhglhgvshhouhhrtggvrdgtohhmpd
    hgihhthhhusgdrtghomhdpghhithhlrggsrdgtohhmpdhpkhhsrdhimhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhifnh
    eslhifnhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LaMAZwLKVBgksJOlYcYgXhu-FJyhByk27LWxzdptXU2gyunb4jowrA>
    <xmx:LaMAZzKTs7sjLis8ZYFlK9_PROf_XvzuhIcNho3XRJa9tN4j16wNJA>
    <xmx:LaMAZ5w0s9CFtqjAhy7V7dYBFL1dh2CEtNWSa0aVRYVnZXtjoHrtAg>
    <xmx:LaMAZ_If_xdbDZfikSSf4r1YXmAx5AOFu6qbmaeryl-XJ1oIYCSAVw>
    <xmx:LaMAZ70R-5hvtiCkgImkzxBsz1k1FKsu3FyIHyKhhvSz15GMyoJwcqgf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 22:23:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2024, #03; Fri, 4)
X-master-at: 90fe3800b92a49173530828c0a17951abd30f0e1
X-next-at: ecfaa0ad0fec27eefd921f5ae74cad15ff483641
Date: Fri, 04 Oct 2024 19:23:40 -0700
Message-ID: <xmqq7cancmoj.fsf@gitster.g>
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

* ak/doc-typofix (2024-09-23) 2 commits
  (merged to 'next' on 2024-10-04 at f667f89519)
 + Documentation: fix typos
 + Documentation/config: fix typos

 Typofixes.
 source: <20240923110343.12388-2-algonell@gmail.com>


* ak/typofix-2.46-maint (2024-10-03) 4 commits
  (merged to 'next' on 2024-10-04 at dd35f48cf2)
 + perl: fix a typo
 + mergetool: fix a typo
 + reftable: fix a typo
 + trace2: fix typos

 Typofixes.
 source: <20241002223816.14858-1-algonell@gmail.com>


* ds/read-cache-mempool-leakfix (2024-10-01) 1 commit
  (merged to 'next' on 2024-10-02 at c0eac890ac)
 + read-cache: free threaded memory pool

 Leakfix.
 source: <pull.1801.v2.git.1727804265033.gitgitgadget@gmail.com>


* jc/doc-discarding-stalled-topics (2024-09-26) 1 commit
  (merged to 'next' on 2024-10-02 at adb0d84fd4)
 + howto-maintain-git: discarding inactive topics

 Document that inactive topics are subject to be discarded.
 source: <xmqqikuii60q.fsf@gitster.g>


* jk/test-lsan-improvements (2024-09-25) 3 commits
  (merged to 'next' on 2024-10-02 at 3d8303fcfe)
 + test-lib: check for leak logs after every test
 + test-lib: show leak-sanitizer logs on --immediate failure
 + test-lib: stop showing old leak logs

 Usability improvements for running tests in leak-checking mode.
 source: <20240924213404.GA1142219@coredump.intra.peff.net>


* kn/osx-fsmonitor-with-submodules-fix (2024-10-04) 1 commit
  (merged to 'next' on 2024-10-04 at 5a9a8775f8)
 + fsmonitor OSX: fix hangs for submodules

 macOS with fsmonitor daemon can hang forever when a submodule is
 involved, which has been corrected.
 source: <pull.1802.v4.git.1728000433326.gitgitgadget@gmail.com>


* mh/w-unused-fix (2024-10-02) 1 commit
  (merged to 'next' on 2024-10-04 at 9a52af034e)
 + utf8.h: squelch unused-parameter warnings with NO_ICONV

 Buildfix.
 source: <20241002200140.2123584-1-mh@glandium.org>


* ps/reftable-concurrent-writes (2024-10-04) 1 commit
  (merged to 'next' on 2024-10-04 at f705b3334a)
 + t0610: work around flaky test with concurrent writers

 Test fix.
 source: <f3874c7e923846e453499e89f00dd4f8862e4c40.1728055880.git.ps@pks.im>


* rs/archive-with-attr-pathspec-fix (2024-10-03) 1 commit
  (merged to 'next' on 2024-10-04 at cc1087dcc0)
 + archive: fix misleading error message

 Message update.
 source: <faed1d0e-86a8-4dcd-a27f-19dcd9f89f37@web.de>


* tb/weak-sha1-for-tail-sum (2024-10-03) 1 commit
  (merged to 'next' on 2024-10-04 at c970b9a3e9)
 + hash.h: set NEEDS_CLONE_HELPER_UNSAFE in fallback mode

 Build fix.
 source: <20241002232618.GA3442753@coredump.intra.peff.net>

--------------------------------------------------
[New Topics]

* ds/line-log-asan-fix (2024-10-03) 1 commit
  (merged to 'next' on 2024-10-04 at ee702f6c95)
 + line-log: protect inner strbuf from free
 (this branch is used by jk/output-prefix-cleanup.)

 Use after free and double freeing at the end in "git log -L... -p"
 had been identified and fixed.

 Will cook in 'next'.
 source: <05c21616c350b5141c17fde1aa5d3aea881c6031.1727956724.git.gitgitgadget@gmail.com>


* sk/doc-maintenance-schedule (2024-10-03) 1 commit
  (merged to 'next' on 2024-10-04 at 2d3722c29d)
 + doc: add a note about staggering of maintenance

 Doc update to clarify how periodical maintenance are scheduled,
 spread across time to avoid thundering hurds.

 Will cook in 'next'.
 source: <pull.1794.git.git.1727945877922.gitgitgadget@gmail.com>


* jk/output-prefix-cleanup (2024-10-03) 5 commits
  (merged to 'next' on 2024-10-04 at 06298d1525)
 + diff: store graph prefix buf in git_graph struct
 + diff: return line_prefix directly when possible
 + diff: return const char from output_prefix callback
 + diff: drop line_prefix_length field
 + line-log: use diff_line_prefix() instead of custom helper
 (this branch uses ds/line-log-asan-fix.)

 Code clean-up.

 Will cook in 'next'.
 source: <pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* kn/fsmonitor-event-listener-fix (2024-10-02) 1 commit
 - fsmonitor: fix hangs by delayed fs event listening

 Under high load, fsmonitor process can hang at start-up, which has
 been corrected.

 Comments?
 source: <pull.1804.git.1727862424713.gitgitgadget@gmail.com>


* jc/a-commands-without-the-repo (2024-10-04) 5 commits
 . SQUASH??? uninitialized variable use fix
 . archive: remove the_repository global variable
 . apply: remove the_repository global variable
 . annotate: remove usage of the_repository global
 . git: pass in repo for RUN_SETUP_GENTLY

 Commands that can also work outside Git have learned to take the
 repository instance "repo" when we know we are in a repository, and
 NULL when we are not, in a parameter.  The uses of the_repository
 variable in a few of them have been removed using the new calling
 convention.

 Comments?
 source: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>


* ps/leakfixes-part-8 (2024-09-30) 25 commits
  (merged to 'next' on 2024-10-04 at 3cfb5747d2)
 + builtin/send-pack: fix leaking list of push options
 + remote: fix leaking push reports
 + t/helper: fix leaks in proc-receive helper
 + pack-write: fix return parameter of `write_rev_file_order()`
 + revision: fix leaking saved parents
 + revision: fix memory leaks when rewriting parents
 + midx-write: fix leaking buffer
 + pack-bitmap-write: fix leaking OID array
 + pseudo-merge: fix leaking strmap keys
 + pseudo-merge: fix various memory leaks
 + line-log: fix several memory leaks
 + diff: improve lifecycle management of diff queues
 + builtin/revert: fix leaking `gpg_sign` and `strategy` config
 + t/helper: fix leaking repository in partial-clone helper
 + builtin/clone: fix leaking repo state when cloning with bundle URIs
 + builtin/pack-redundant: fix various memory leaks
 + builtin/stash: fix leaking `pathspec_from_file`
 + submodule: fix leaking submodule entry list
 + wt-status: fix leaking buffer with sparse directories
 + shell: fix leaking strings
 + scalar: fix leaking repositories
 + read-cache: fix leaking hash context in `do_write_index()`
 + builtin/annotate: fix leaking args vector
 + Merge branch 'jk/http-leakfixes' into ps/leakfixes-part-8
 + Merge branch 'ps/leakfixes-part-7' into ps/leakfixes-part-8

 More leakfixes.

 Will cook in 'next'.
 source: <cover.1727687410.git.ps@pks.im>


* tb/notes-amlog-doc (2024-10-03) 1 commit
  (merged to 'next' on 2024-10-04 at e73c8753e8)
 + Documentation: mention the amlog in howto/maintain-git.txt

 Document "amlog" notes.

 Will cook in 'next'.
 source: <88a13b9f2b6e7fbed517a7e268e4e371d84a9a10.1727917792.git.me@ttaylorr.com>


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


* ps/reftable-alloc-failures (2024-10-04) 28 commits
  (merged to 'next' on 2024-10-04 at 5649ef3dd7)
 + reftable/basics: fix segfault when growing `names` array fails
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
 source: <CAPig+cT7nni11bGmNyYCQZ0P0QZ_HG-izPtsymq==sUOkOn-Lw@mail.gmail.com>
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


* ds/pack-name-hash-tweak (2024-10-04) 6 commits
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


* tb/incremental-midx-part-2 (2024-10-04) 17 commits
 - fixup! pack-bitmap.c: open and store incremental bitmap layers
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
 source: <ZwBsbW5jsFw0mxKk@nand.local>


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
