Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710001C7B73
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797912; cv=none; b=kgLtIz0NRKpCcCkklGiNE+I/TZESun9Y8Gd+4UwMC6VGjGbF46z+5ZZLVZ/cs0VFOSHOovEp5AfzvGW2DVemtZr3QbouuadQmDWlZtCW+SRHHrd91wcSiZ5viaiFDGHiOp06Yqcl++7//JPgjVTjOFwxIUFrmEeBn4kXlK7PqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797912; c=relaxed/simple;
	bh=2LR1Jy8THZBQN4YcIF7X33xHaJ2cexOcBK1TsDMdDXc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QQYibS9Y+Um1yi7KolASWSH9gk9a/CkLETmD1tPjK3dmaYaTZU1dJuung6cwfOxVl1/jHJMs1rh4qLARBEZ3iiPwcz9AAd/AFeywicjK7FZjzl//QahaQGf4S544weqcj94kulk6okJCUCw5bN38L65ljI7d48dCHls59tUF3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jHHDbsxd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dsDaZCmQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jHHDbsxd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dsDaZCmQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9862E1140544;
	Tue,  1 Oct 2024 11:51:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 01 Oct 2024 11:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1727797908; x=1727884308; bh=Hnttt0Yz4tuf2UuJrYGEV9UXqcmzSypU
	YlOIHydiXTw=; b=jHHDbsxdaMX3oJUnnIO/+t+k+x+Z2/L4RkFXfBypyG2Vj7Am
	cwb/I0esF8XRQNWDDL+uaNSOxiADLBIbH/Beb81NUm539HtoCgPs9SpG6ZzexAPr
	x4jIkhxrs9DjSmxhE0F2Uz7bMwK4BTLEwN/7WxsBJQkDsgD0DJ6KWLcVhRZvtxao
	zk+9XLYRd6vOy6TUsBe/oP8w9mbP3npClTfz/oHtVyIBex377CQscHgi2bvbuOK0
	J3UE5b6hrYvVh65CgJlMVmTmCPpxFX5D8lnjNH8IH/8/fG2opeGnDdclPdOU7IT2
	UaTPstRZhKNQLDkAKqpF8MCFU3aFcducxDfu/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1727797908; x=1727884308; bh=Hnttt0Yz4tuf2UuJrYGEV9UXqcmzSypUYlO
	IHydiXTw=; b=dsDaZCmQe4kErkIYMJ0LuDPZMMrmNIHRZt9CXv7AxWukWQXRcMn
	rhcQBL90TdUKyq8uxBdiR0v2WKWS/hBTfl+65vfENcaRbqUU2zk6PjvZx1oQcfS7
	LWEXeAiq0yQZPNU+rv/MChF24E2+UcC4fyN7aprONIvwSWKtse0lg4h35VYcgw6o
	BxxaAyZfCo7/PCXYXlA+eBz27lrURbqjhNo+oCcnHDBoUSDgtG/4EfA0l+W/6vNL
	//bmv5F6i6a9rxckRK+souBUnkFVc1qAp7Vc4XpPZmCbCc9rKpr8kbC8J+3Ai9U9
	1IlH/vNo1mhfe3myH2SPOIhJNRCZjxDiZkQ==
X-ME-Sender: <xms:lBr8ZheBEzItMIfSe4kEjNiMO1f1JOcfllDw5n7dl2zYVgWeQFlcMQ>
    <xme:lBr8ZvO8chPv83qVZ78z2YOzHW3UOQTCFEhuL57qwUzMI-GRdfpnO_DlNLCqRMj48
    kn3izH7X4Aczy5p7Q>
X-ME-Received: <xmr:lBr8ZqgdAT_HQhD_hMRqkfJpEsPP7O1t2Hbr88SVY_wPTNr8Ex1nL6pyTK1DS8WUS87fyJ717cVu3CZVENB1QEo37jLR_ucVlzenoF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgledvucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:lBr8Zq_84R_PJrZevcaBq8sw-NhQnzYZc7WhCFEPbwpFFwOVEBKCtg>
    <xmx:lBr8ZtuU1Yshk-C984bVez3cjGY2jfo9Kgcewb4JJ9UNdwig_Kv3Pw>
    <xmx:lBr8ZpG_dxJWBuvRb4pCcJELrzmGw9mT2G6c2qmBbeuKzUUh1k22xg>
    <xmx:lBr8ZkNoYj2urqJLqa8xnA-lZjX2CIlKSmCN-HCrDCC3H0TUer22Dg>
    <xmx:lBr8ZlImCGYDX_DRmH5MpS55OHSDHG3hY91h3AYYUZHRpkUCFbF1Lpco>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 11:51:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2024, #01; Tue, 1)
X-master-at: e9356ba3ea2a6754281ff7697b3e5a1697b21e24
X-next-at: 3d1fbeb9078808ccf955c44b37814338e1b24555
Date: Tue, 01 Oct 2024 08:51:46 -0700
Message-ID: <xmqqr08z254d.fsf@gitster.g>
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
we will tag -rc1 soonish.

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
[Graduated to 'master']

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
 source: <pull.1798.git.1726790423.gitgitgadget@gmail.com>


* ps/includeif-onbranch-cornercase-fix (2024-09-24) 2 commits
  (merged to 'next' on 2024-09-24 at 229c0bf0e5)
 + config: fix evaluating "onbranch" with nonexistent git dir
 + t1305: exercise edge cases of "onbranch" includes

 "git --git-dir=nowhere cmd" failed to properly notice that it
 wasn't in any repository while processing includeIf.onbranch
 configuration and instead crashed.
 source: <cover.1727171197.git.ps@pks.im>


* ps/reftable-concurrent-writes (2024-09-24) 3 commits
  (merged to 'next' on 2024-09-24 at 04df72ad69)
 + refs/reftable: reload locked stack when preparing transaction
 + reftable/stack: allow locking of outdated stacks
 + refs/reftable: introduce "reftable.lockTimeout"

 Give timeout to the locking code to write to reftable.
 source: <cover.1727155858.git.ps@pks.im>


* pw/submodule-process-sigpipe (2024-09-20) 1 commit
  (merged to 'next' on 2024-09-24 at 9e1ce951c6)
 + submodule status: propagate SIGPIPE

 When a subprocess to work in a submodule spawned by "git submodule"
 fails with SIGPIPE, the parent Git process caught the death of it,
 but gave a generic "failed to work in that submodule", which was
 misleading.  We now behave as if the parent got SIGPIPE and die.
 source: <pull.1799.git.1726837642511.gitgitgadget@gmail.com>


* rs/archive-with-attr-pathspec-fix (2024-09-23) 1 commit
  (merged to 'next' on 2024-09-24 at a81fb17e49)
 + archive: load index before pathspec checks

 "git archive" with pathspec magic that uses the attribute
 information did not work well, which has been corrected.
 source: <66c3e9fa-ecfe-4af2-a970-c1afdbc2b7f2@web.de>


* rs/commit-graph-ununleak (2024-09-23) 1 commit
  (merged to 'next' on 2024-09-24 at 5845eca9ce)
 + commit-graph: remove unnecessary UNLEAK

 Code clean-up.
 source: <c3a712d5-8e50-453d-be90-f5bf34de744c@web.de>

--------------------------------------------------
[New Topics]

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


* kn/osx-fsmonitor-with-submodules-fix (2024-09-30) 1 commit
 - fsmonitor OSX: fix hangs for submodules

 macOS with fsmonitor daemon can hang forever when a submodule is
 involved, which has been corrected.

 Will merge to 'next'?
 source: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>


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
 (this branch uses jk/http-leakfixes and ps/leakfixes-part-7.)

 More leakfixes.

 Comments?
 source: <cover.1727687410.git.ps@pks.im>


* tb/notes-amlog-doc (2024-09-30) 2 commits
 - Documentation: mention the amlog in howto/maintain-git.txt
 - howto-maintain: mention notes/amlog policy

 Document "amlog" notes.

 Comments?
 source: <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>

--------------------------------------------------
[Cooking]

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
 - howto-maintain-git: discarding inactive topics

 Document that inactive topics are subject to be discarded.

 Will merge to 'next'.
 source: <xmqqikuii60q.fsf@gitster.g>


* ds/sparse-checkout-expansion-advice (2024-09-23) 1 commit
  (merged to 'next' on 2024-09-27 at e670bccf7e)
 + sparse-checkout: disable advice in 'disable'

 When "git sparse-checkout disable" turns a sparse checkout into a
 regular checkout, the index is fully expanded.  This totally
 expected behaviour however had an "oops, we are expanding the
 index" advice message, which has been corrected.

 Will merge to 'master'.
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

 Will merge to 'master'.
 cf. <ZulXjXSozNrXgMUM@pks.im>
 source: <cover.1727351062.git.ps@pks.im>


* ps/reftable-alloc-failures (2024-09-30) 24 commits
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

 Expecting a reroll.
 cf. <Zvrsd5JQr8RAhSaN@pks.im>
 source: <cover.1727680272.git.ps@pks.im>


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
 collision detection protection.

 Will merge to 'master'.
 cf. <20240927035712.GH567395@coredump.intra.peff.net>
 cf. <CABPp-BH3y96DjapzLPJ+vCoChQiD_wR9uLc3QPsXqzSUr4AFvQ@mail.gmail.com>
 source: <cover.1727364141.git.me@ttaylorr.com>


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

 Will merge to 'master'.
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
