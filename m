Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ABD1D2B2F
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316425; cv=none; b=jcaSGBgMNIfPPFf4ec+2VMpNCXJ8tBMk9SnDg1v1jwpWoRhcNMRG2mDrY0FKnf0w+5UySluSBKHfy77JS6jJloAJ0NripK/nwtMX3L6WZRrRR/ssJN7YfhfNjDYeJ303fKxweyWrtlvCEnM6ndnA35lyL/YUe8SsBkvqn3eXCJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316425; c=relaxed/simple;
	bh=dZWUjZk3yeYMWwMCO5hmVLrqHE4cz2lJ16EfcPxdnn4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hI8Qnqq7/Ev+rNYcitvlhdJ81gto6sP/Fb6HPETqa7NVjhdpKpWSWO6l87qSyKoZlXw1WSGuKVoiJZUgtcZ1KwrDdA3k0t/krPwTWoRceCEgz53TfRhXbrg8ioyuKWxaj+x8MNhjWnD7Ai2inUzb/6VjgVW61iRcdpYQXhbKurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dmqQCxW7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X/p8uppX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dmqQCxW7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/p8uppX"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D3D7411400C4;
	Mon,  7 Oct 2024 11:53:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 07 Oct 2024 11:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1728316421; x=1728402821; bh=pttKv76LWXeHOIQPESJ8qnXGMX50poYN
	cIWagtGjNNs=; b=dmqQCxW7PcqRFJrplgcMfD81YsofzJmjt5fbfvbmZF7A70h3
	+V6s4nOpeTemo3Hwt8lwxl/qctrm+eMeXsFnVNy0XfWXWBrOdOnPmI8Y2L6H+FV7
	NOF4XM/ja/Q944MnlJfnFJJP2tvsLw3FSP/m7OFhbvKZOpuwKI2jSS14UVOfn+P+
	P6wG3m3jNFyzjzGF1oIaewhCHamiZP5LCeluboBo6zUH+ujzaYqVN5liLCIz+jp0
	x9hZxHo5BgD2x3KTgDH8vAc0ZoZDtOgbNpYASbwWDbhuoO7VFH8dHQ5EVr6TNVHh
	4yhubm001kt9ENdbThE3ghThxXVuktFCQVehzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1728316421; x=1728402821; bh=pttKv76LWXeHOIQPESJ8qnXGMX50poYNcIW
	agtGjNNs=; b=X/p8uppXnSNSpNjx1f5xQbXVl+ZjXIbatcrNJsLDd7iQrOkOHsy
	dDG0KGaVRgvnLZviMOFykDKNgrnLJF9aBbdeepaU/EuHKcY8SJk+E6jrJmTvcutr
	bS/lxhRYYtF2/KvRopE86nocJlfscvIG/EvxNzvY6RgpiLvtI3ThErlg3Z8NcfRy
	dVxFu7o7S1Hnjrrz/hD1uFDiba3N+XrOAM6PLP52LpDVC0azOCAklKr60tUw0w7c
	iqT9DyLeNX25eOyhBFjYS37aCT8MkSPAfpgOU0ioDFQiJ1IcSSFHg8MM+CMtWHgx
	rKQgWJ12Ay/rXQzLfAaHm4AuL+L7eh3zA0A==
X-ME-Sender: <xms:BQQEZ5G_dgHOGQwVCVNVStjmFUvmVXATGbc38rFKwxhlnbGMOjWAoQ>
    <xme:BQQEZ-XyTe81luzhE3LtB03OqUPNCdI2rZMTqNoK0CHW55XHFLLOc8zpD-T8jky2R
    Ix0pCW2UImJ_dYi2g>
X-ME-Received: <xmr:BQQEZ7KB5mQ_ckmUMX-dpant3BHMN2J_odgs9t33gFYzNvCgrkwWFWiBORWL-UwcR59kGS43EMNuQ-6gEw_y9t3vt6iMokP6nEB4cv0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgleeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:BQQEZ_GQpj_-zoBdX9QOpVTVr0yvJn3Ypeb29GvKf36z_f0UbpC9Cg>
    <xmx:BQQEZ_UAlJg7j96Yv3OLATb3e8dgP3fCICD_5EFMoI6FwoWQkr7kCQ>
    <xmx:BQQEZ6Mio8hiHM_fdDoIUf3JAVzMjM2Wu9faY2IgNJDA8qy0JgenKQ>
    <xmx:BQQEZ-3CdbnSHYy12h6MFR72A7hBj9evMKY7r1iHzoM5RNmVviF74w>
    <xmx:BQQEZ6QZwlO1XdGV1EZWGVjyB_QPSCrmCFrHsj4nwVlTgARP0Wsiy9RZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 11:53:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2024, #04; Sun, 6)
X-master-at: 777489f9e09c8d0dd6b12f9d90de6376330577a2
X-next-at: 4ca455297942c5c9616351bc68bad2034c719206
Date: Mon, 07 Oct 2024 08:53:40 -0700
Message-ID: <xmqq4j5naozf.fsf@gitster.g>
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

Git 2.47 (final) has been tagged.

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
[Cooking]

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


* kn/fsmonitor-event-listener-fix (2024-10-02) 1 commit
 - fsmonitor: fix hangs by delayed fs event listening

 Under high load, fsmonitor process can hang at start-up, which has
 been corrected.

 Comments?
 source: <pull.1804.git.1727862424713.gitgitgadget@gmail.com>


* jc/a-commands-without-the-repo (2024-10-06) 3 commits
 - archive: remove the_repository global variable
 - annotate: remove usage of the_repository global
 - git: pass in repo to builtin based on setup_git_directory_gently

 Commands that can also work outside Git have learned to take the
 repository instance "repo" when we know we are in a repository, and
 NULL when we are not, in a parameter.  The uses of the_repository
 variable in a few of them have been removed using the new calling
 convention.

 Comments?
 source: <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>


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
