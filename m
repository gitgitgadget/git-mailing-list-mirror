Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F11B18CC0B
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693827; cv=none; b=SJvg5951XT4j0WAi42156aCh+EFRJ8k4Yle4kodHEdrCmPVbzjKIHkKInN6cw6PjX3UHMIiACOl7/htX4S+IIMZJ15fpmcBvJfAGqUfcq3feSON0oQl0LSP7HpMRX63j4HzjrIRzj30NStTsoHR0EfWt7bvjl09UqyBTnX75+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693827; c=relaxed/simple;
	bh=Nw80fIeLBt7InotAnD295u43Mv52zxTDK8ZopV390KI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gMJvU3/PKfY5tMLEsGR/dY9Ltpry1khZFffyzJ5WVVnO4EfQOG5X10W1l80iO0fvfkGkUL8O8eZOWBVwaF4G6o2ruETRqetxEBpNvNeMNlB44Y0kEPl2IxhJnd6T6Gwxop0fpztoogkqWGYXm6sXdnGtm4ebe1zzXD75ZKnjAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=duZBWp3m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=McHBWyuF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="duZBWp3m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="McHBWyuF"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3837E11401FB;
	Mon, 30 Sep 2024 06:57:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 30 Sep 2024 06:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1727693823; x=1727780223; bh=DsGajNbYWlJgrGcOmnHddK+ngCfTDLC9
	XTmt/Q+yXtQ=; b=duZBWp3mcbLIzRK4ID62tmDRoT4LURQq9mcP6tN6Fjq/Ncl1
	gi0Qmn0cWEOkdn7UilNJE8iigteCPchPV150wiEQ41uE0bhg35ed3QWUD0xHtdJh
	k0xxOKYlz2mCZ0qWw2k/4EnVYNnC4Vt8/fYSIn0YDoDgSUtEBqWJX+ZZLhL6VYQw
	l/yA9miJlcLbaE+EFoSR7oeOP9ZHnVBpbawWRt69Lz/SSN33LQIgGvUnSZqZTs69
	wTZv8VLKYOxR73eREIsSA0fjApOEcb+a7TOs9Tb/ItvjmLHDQi6x33MNO3Ta4WjP
	yydU/cLNJENkKTyC46gI3FcutG40LQ2Shk49CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1727693823; x=1727780223; bh=DsGajNbYWlJgrGcOmnHddK+ngCfTDLC9XTm
	t/Q+yXtQ=; b=McHBWyuFs7k2/XDISp4qtjNs8zLiK3OzKAn9dKK6S7N6pohhZlh
	w1eT8uwwdKzV2TQ8oxPq9IfN40Sm3imll82PX6KW8gnfw1aUSdKAstzVVDQRZxC7
	d0y04u5zPC0sgA2W1A1jX9eNDMEhAiQBuaQAbaqsac0o31CEUKJS8CkEUVLXYWnY
	wprltd2syVWkHdf0NpZ55nowvN3Y0fRyjoIC0i6BQawiRr5VbQZR74NSSNmajf0N
	LCOplD2UTBdjAPGXvH/JGMQy8xa9kaiyDlZL4Q2WhT7loJ18DjSqNXAYk+fCzxEm
	yG8j0mt3buPAauuuqtEGOmLm8epiAmcrVOA==
X-ME-Sender: <xms:_oP6ZqUl5ucD2JuCf1kJDp_m5Tt0i5YT_AQAWXR8a_xyZ4OvOXt-Uw>
    <xme:_oP6Zmlh4pSAdMlK5i9GxUsJ1I-XoZJ0DWzy3N3JymmPB1BqFyWWxmPm17Kt5YGBT
    1mkg7ceq2PW1bqD-w>
X-ME-Received: <xmr:_oP6ZuYnFJqjBh3VNltyKDnJioYtaDzD3SckdPfLuj2M4leJ172Hie-nS-v78b1cIlV-p1aRw-F66XHzzB5VLjeJTAHQ0Ri6KlQRtDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgfeegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:_4P6ZhUNWTfnrtKRnFE35YN7XnXqvSK2BC1z-is6EimHGGuJH6XQGQ>
    <xmx:_4P6Zkk0SxTdugYrkwQgyZ69Qz5SRsOHSf7oSF6FQXQ1phBCNKvS7w>
    <xmx:_4P6Zmd1MTfwtVV220Z7WatS06uN19QTJTMSI3S1HIkcNCMjfVaftA>
    <xmx:_4P6ZmEYG-9PV_-qx10ofHL2KuotFl3evp4i_fY6mRxZAJOI4XpcDg>
    <xmx:_4P6ZuiA1qtXhkgty4Rud1l9Q5sW1Ew17yHV3uqQso7lcjfCtf_xINp0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 06:57:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2024, #12; Sun, 29)
X-master-at: 3857aae53f3633b7de63ad640737c657387ae0c6
X-next-at: c52b418c92d127f8efa6c22f3765e715a23f2229
Date: Mon, 30 Sep 2024 03:57:01 -0700
Message-ID: <xmqqwmit9zpe.fsf@gitster.g>
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

A handful of topics in 'next' will be flushed to 'master' and then
we will tag -rc1 in the middle of this week.

Unfortunately our CI jobs seem to be failing due to
https://lore.kernel.org/git/xmqqmsk37926.fsf@gitster.g/ The
regression in libCurl 8.10.0 has been identified and corrected in
the upstream, but apparently it takes time for the fix to percolate
down.

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
[New Topics]

* ej/cat-file-remote-object-info (2024-09-27) 6 commits
 - cat-file: add remote-object-info to batch-command
 - cat-file: add declaration of variable i inside its for loop
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing

 source: <20240926013856.35527-1-eric.peijian@gmail.com>


* jc/doc-discarding-stalled-topics (2024-09-26) 1 commit
 - howto-maintain-git: discarding inactive topics

 source: <xmqqikuii60q.fsf@gitster.g>

--------------------------------------------------
[Cooking]

* ds/sparse-checkout-expansion-advice (2024-09-23) 1 commit
  (merged to 'next' on 2024-09-27 at e670bccf7e)
 + sparse-checkout: disable advice in 'disable'

 When "git sparse-checkout disable" turns a sparse checkout into a
 regular checkout, the index is fully expanded.  This totally
 expected behaviour however had an "oops, we are expanding the
 index" advice message, which has been corrected.

 Will merge to 'master'.
 source: <pull.1800.git.1727119882901.gitgitgadget@gmail.com>


* ps/includeif-onbranch-cornercase-fix (2024-09-24) 2 commits
  (merged to 'next' on 2024-09-24 at 229c0bf0e5)
 + config: fix evaluating "onbranch" with nonexistent git dir
 + t1305: exercise edge cases of "onbranch" includes

 "git --git-dir=nowhere cmd" failed to properly notice that it
 wasn't in any repository while processing includeIf.onbranch
 configuration and instead crashed.

 Will merge to 'master'.
 source: <cover.1727171197.git.ps@pks.im>


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

 Leakfixes.

 Will merge to 'master'.
 source: <20240924214930.GA1143523@coredump.intra.peff.net>


* jk/test-lsan-improvements (2024-09-25) 3 commits
 - test-lib: check for leak logs after every test
 - test-lib: show leak-sanitizer logs on --immediate failure
 - test-lib: stop showing old leak logs

 Usability improvements for running tests in leak-checking mode.

 Needs review.
 source: <20240924213404.GA1142219@coredump.intra.peff.net>


* es/worktree-repair-copied (2024-09-23) 1 commit
 - worktree: repair copied repository and linked worktrees

 The heuristics in "git worktree repair" can be confused when a
 worktree and its repository are copied and break correctly
 configured worktree and repository that point at each other, which
 has been corrected.

 Needs review.
 source: <20240923075416.54289-1-ericsunshine@charter.net>


* rs/archive-with-attr-pathspec-fix (2024-09-23) 1 commit
  (merged to 'next' on 2024-09-24 at a81fb17e49)
 + archive: load index before pathspec checks

 "git archive" with pathspec magic that uses the attribute
 information did not work well, which has been corrected.

 Will merge to 'master'.
 source: <66c3e9fa-ecfe-4af2-a970-c1afdbc2b7f2@web.de>


* rs/commit-graph-ununleak (2024-09-23) 1 commit
  (merged to 'next' on 2024-09-24 at 5845eca9ce)
 + commit-graph: remove unnecessary UNLEAK

 Code clean-up.

 Will merge to 'master'.
 source: <c3a712d5-8e50-453d-be90-f5bf34de744c@web.de>


* cw/fix-reachable-in-repo-with-promisor (2024-09-19) 2 commits
 - fetch-pack.c: do not declare local commits as "have" in partial repos
 - packfile: split promisor objects oidset into two

 "git gc" in a partial clone (i.e. lacking objects that can be
 lazily fetched from promisor remotes) collected more than objects
 that promisor-remote can give.

 Needs review.
 source: <20240802073143.56731-1-hanyang.tony@bytedance.com>


* ds/background-maintenance-with-credential (2024-09-20) 3 commits
  (merged to 'next' on 2024-09-24 at 379a7a1003)
 + scalar: configure maintenance during 'reconfigure'
 + maintenance: add custom config to background jobs
 + credential: add new interactive config option

 Background tasks "git maintenance" runs may need to use credential
 information when going over the network, but a credential helper
 may work only in an interactive environment, and end up blocking a
 scheduled task waiting for UI.  Credential helpers can now behave
 differently when they are not running interactively.

 Will merge to 'master'.
 source: <pull.1798.git.1726790423.gitgitgadget@gmail.com>


* jc/breaking-changes-early-adopter-option (2024-09-19) 1 commit
 - BreakingChanges: early adopter option

 Describe the policy to introduce breaking changes.

 Comments?
 source: <xmqq7cb77810.fsf@gitster.g>


* ps/reftable-concurrent-writes (2024-09-24) 3 commits
  (merged to 'next' on 2024-09-24 at 04df72ad69)
 + refs/reftable: reload locked stack when preparing transaction
 + reftable/stack: allow locking of outdated stacks
 + refs/reftable: introduce "reftable.lockTimeout"

 Give timeout to the locking code to write to reftable.

 Will merge to 'master'.
 source: <cover.1727155858.git.ps@pks.im>


* pw/submodule-process-sigpipe (2024-09-20) 1 commit
  (merged to 'next' on 2024-09-24 at 9e1ce951c6)
 + submodule status: propagate SIGPIPE

 When a subprocess to work in a submodule spawned by "git submodule"
 fails with SIGPIPE, the parent Git process caught the death of it,
 but gave a generic "failed to work in that submodule", which was
 misleading.  We now behave as if the parent got SIGPIPE and die.

 Will merge to 'master'.
 source: <pull.1799.git.1726837642511.gitgitgadget@gmail.com>


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

 More leak-fixes.

 Will merge to 'master'.
 cf. <ZulXjXSozNrXgMUM@pks.im>
 source: <cover.1727351062.git.ps@pks.im>


* ps/reftable-alloc-failures (2024-09-24) 24 commits
 - reftable: handle trivial allocation failures
 - reftable/tree: handle allocation failures
 - reftable/pq: handle allocation failures when adding entries
 - reftable/block: handle allocation failures
 - reftable/blocksource: handle allocation failures
 - reftable/iter: handle allocation failures when creating indexed table iter
 - reftable/stack: handle allocation failures in auto compaction
 - reftable/stack: handle allocation failures in `stack_compact_range()`
 - reftable/stack: handle allocation failures in `reftable_new_stack()`
 - reftable/stack: handle allocation failures on reload
 - reftable/reader: handle allocation failures in `reader_init_iter()`
 - reftable/reader: handle allocation failures for unindexed reader
 - reftable/merged: handle allocation failures in `merged_table_init_iter()`
 - reftable/writer: handle allocation failures in `reftable_new_writer()`
 - reftable/writer: handle allocation failures in `writer_index_hash()`
 - reftable/record: handle allocation failures when decoding records
 - reftable/record: handle allocation failures on copy
 - reftable/basics: handle allocation failures in `parse_names()`
 - reftable/basics: handle allocation failures in `reftable_calloc()`
 - reftable: introduce `reftable_strdup()`
 - reftable/basics: merge "publicbasics" into "basics"
 - reftable/error: introduce out-of-memory error code
 - Merge branch 'ps/reftable-exclude' into ps/reftable-alloc-failures
 - Merge branch 'cp/unit-test-reftable-stack' into ps/reftable-alloc-failures

 The reftable library is now prepared to expect that the memory
 allocation function given to it may fail to allocate and to deal
 with such an error.

 Expecting a reroll (v3).
 cf. <ZvVO73dp4dbtxKi8@pks.im>
 source: <cover.1727158127.git.ps@pks.im>


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


* tb/weak-sha1-for-tail-sum (2024-09-27) 8 commits
 - csum-file.c: use unsafe SHA-1 implementation when available
 - Makefile: allow specifying a SHA-1 for non-cryptographic uses
 - hash.h: scaffolding for _unsafe hashing variants
 - sha1: do not redefine `platform_SHA_CTX` and friends
 - pack-objects: use finalize_object_file() to rename pack/idx/etc
 - finalize_object_file(): implement collision check
 - finalize_object_file(): refactor unlink_or_warn() placement
 - finalize_object_file(): check for name collision before renaming

 The checksum at the tail of files are now computed without
 collision detection protection.

 Will merge to 'next'.
 cf. <20240927035712.GH567395@coredump.intra.peff.net>
 cf. <CABPp-BH3y96DjapzLPJ+vCoChQiD_wR9uLc3QPsXqzSUr4AFvQ@mail.gmail.com>
 source: <cover.1727364141.git.me@ttaylorr.com>


* sj/ref-contents-check (2024-09-18) 5 commits
 - ref: add symlink ref content check for files backend
 - ref: add symref content check for files backend
 - ref: add more strict checks for regular refs
 - ref: port git-fsck(1) regular refs check for files backend
 - ref: initialize "fsck_ref_report" with zero

 "git fsck" learned to issue warnings on "curiously formatted" ref
 contents that have always been taken valid but something Git
 wouldn't have written itself (e.g., missing terminating end-of-line
 after the full object name).

 Needs review.
 source: <ZuRzCyjQFilGhj8j@ArchLinux>


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
 - doc: apply synopsis simplification on git-clone and git-init
 - doc: update the guidelines to reflect the current formatting rules
 - doc: introduce a synopsis typesetting

 The way AsciiDoc is used for SYNOPSIS part of the manual pages has
 been revamped.  The sources, at least for the simple cases, got
 vastly pleasant to work with.

 Reverted out of 'next', and then replaced.
 Will merge to 'next'.
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
