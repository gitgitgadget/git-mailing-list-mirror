Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C859B69
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437927; cv=none; b=ZXRi+Uy+oVO0yMrbG3Ke0+SBdlcd79UEq/dvUI101Z5kHSm1CkCokj8s/R4tk6NoAN44Hw1RrWsR/shhYPS265XtIWB5UfIjtIs0WZ+jzw99aXcGZuAlHAgNLB/v9EDN9dFs2rMHTwZIzhk/TbqDnN2VnUgTgbsMaDrdC3c8eC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437927; c=relaxed/simple;
	bh=MLQDa0lW5HzvCHUY6MAclvRg2JC4RaQUI73A75pzuLc=;
	h=Received:DKIM-Signature:Received:Received:From:To:Subject:
	 X-master-at:X-next-at:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=PqHzLsbLD2stf3hkmUA9y1o4+/hVNydd5VT8Kyo7SN0gdK6110WtMM+dLLslFZbyqBQ04WVd3ax0ZMFqyxCcIj0ZMzWNhAbIkl0AVEuOsE4n9T0VwT5DYwNR9qML6ZfiHvkHO+8QxLC/ffIB86wRs2P6DXka/+5IZhPz37zMdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ykwxnKUS; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ykwxnKUS"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 39FBF26F74;
	Tue, 16 Jan 2024 15:45:18 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=M
	LQDa0lW5HzvCHUY6MAclvRg2JC4RaQUI73A75pzuLc=; b=ykwxnKUSIlj0wf0AZ
	GfX2qWajQLuLq6/cgREF6BGbh3LIBVmLkT/nN1IBkSjtqrcZq9+p/AUPEiVaaxs6
	+zeQ+2ebialgKHhaTmhxbjNGffZ/WvI9iyvam0PlJz7TSzRmp0fbM/Yw68RrNosI
	nQbWtz6vuNDJYxCLKn8AvNNgm8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1619226F73;
	Tue, 16 Jan 2024 15:45:18 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9579426F70;
	Tue, 16 Jan 2024 15:45:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2024, #05; Tue, 16)
X-master-at: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
X-next-at: 8c6e9c07ef0bd922be435c0763b0b1b5bc508796
Date: Tue, 16 Jan 2024 12:45:13 -0800
Message-ID: <xmqqmst5yply.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 26625A36-B4B0-11EE-BE13-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

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

* cp/git-flush-is-an-env-bool (2024-01-04) 1 commit
  (merged to 'next' on 2024-01-04 at b435a96ce8)
 + write-or-die: make GIT_FLUSH a Boolean environment variable

 Unlike other environment variables that took the usual
 true/false/yes/no as well as 0/1, GIT_FLUSH only understood 0/1,
 which has been corrected.
 source: <pull.1628.v3.git.1704363617842.gitgitgadget@gmail.com>


* cp/sideband-array-index-comment-fix (2023-12-28) 1 commit
  (merged to 'next' on 2024-01-08 at f906bc86f1)
 + sideband.c: remove redundant 'NEEDSWORK' tag

 In-code comment fix.
 source: <pull.1625.v4.git.1703750460527.gitgitgadget@gmail.com>


* ib/rebase-reschedule-doc (2024-01-05) 1 commit
  (merged to 'next' on 2024-01-08 at d451d1f760)
 + rebase: clarify --reschedule-failed-exec default

 Doc update.
 source: <20240105011424.1443732-2-illia.bobyr@gmail.com>


* jk/commit-graph-slab-clear-fix (2024-01-05) 1 commit
  (merged to 'next' on 2024-01-08 at f78c4fc296)
 + commit-graph: retain commit slab when closing NULL commit_graph

 Clearing in-core repository (happens during e.g., "git fetch
 --recurse-submodules" with commit graph enabled) made in-core
 commit object in an inconsistent state by discarding the necessary
 data from commit-graph too early, which has been corrected.
 source: <20240105054142.GA2035092@coredump.intra.peff.net>


* jk/index-pack-lsan-false-positive-fix (2024-01-05) 1 commit
  (merged to 'next' on 2024-01-08 at 589ed65251)
 + index-pack: spawn threads atomically

 Fix false positive reported by leak sanitizer.
 source: <20240105085034.GA3078476@coredump.intra.peff.net>


* jk/t1006-cat-file-objectsize-disk (2024-01-03) 2 commits
  (merged to 'next' on 2024-01-03 at a492c6355c)
 + t1006: prefer shell loop to awk for packed object sizes
  (merged to 'next' on 2023-12-28 at d82812e636)
 + t1006: add tests for %(objectsize:disk)

 Test update.
 source: <20231221094722.GA570888@coredump.intra.peff.net>
 source: <20240103090152.GB1866508@coredump.intra.peff.net>


* js/contributor-docs-updates (2023-12-27) 9 commits
  (merged to 'next' on 2024-01-02 at 0e072117cd)
 + SubmittingPatches: hyphenate non-ASCII
 + SubmittingPatches: clarify GitHub artifact format
 + SubmittingPatches: clarify GitHub visual
 + SubmittingPatches: provide tag naming advice
 + SubmittingPatches: update extra tags list
 + SubmittingPatches: discourage new trailers
 + SubmittingPatches: drop ref to "What's in git.git"
 + CodingGuidelines: write punctuation marks
 + CodingGuidelines: move period inside parentheses

 Doc update.
 source: <pull.1623.v3.git.1703739324.gitgitgadget@gmail.com>


* jw/builtin-objectmode-attr (2023-12-28) 1 commit
  (merged to 'next' on 2024-01-02 at 4c3784b3a1)
 + attr: add builtin objectmode values support

 The builtin_objectmode attribute is populated for each path
 without adding anything in .gitattributes files, which would be
 useful in magic pathspec, e.g., ":(attr:builtin_objectmode=100755)"
 to limit to executables.
 cf. <xmqq5y0ssknj.fsf@gitster.g>
 source: <20231116054437.2343549-1-jojwang@google.com>


* jx/sideband-chomp-newline-fix (2023-12-18) 3 commits
  (merged to 'next' on 2024-01-04 at 1237898a22)
 + pkt-line: do not chomp newlines for sideband messages
 + pkt-line: memorize sideband fragment in reader
 + test-pkt-line: add option parser for unpack-sideband

 Sideband demultiplexer fixes.
 source: <cover.1702823801.git.zhiyou.jx@alibaba-inc.com>


* ms/rebase-insnformat-doc-fix (2024-01-03) 1 commit
  (merged to 'next' on 2024-01-04 at d68f2be39b)
 + Documentation: fix statement about rebase.instructionFormat

 Docfix.
 source: <pull.1629.git.git.1704305663254.gitgitgadget@gmail.com>


* ps/refstorage-extension (2024-01-02) 13 commits
  (merged to 'next' on 2024-01-08 at f9a034803b)
 + t9500: write "extensions.refstorage" into config
 + builtin/clone: introduce `--ref-format=` value flag
 + builtin/init: introduce `--ref-format=` value flag
 + builtin/rev-parse: introduce `--show-ref-format` flag
 + t: introduce GIT_TEST_DEFAULT_REF_FORMAT envvar
 + setup: introduce GIT_DEFAULT_REF_FORMAT envvar
 + setup: introduce "extensions.refStorage" extension
 + setup: set repository's formats on init
 + setup: start tracking ref storage format
 + refs: refactor logic to look up storage backends
 + worktree: skip reading HEAD when repairing worktrees
 + t: introduce DEFAULT_REPO_FORMAT prereq
 + Merge branch 'ps/clone-into-reftable-repository' into ps/refstorage-extension
 (this branch is used by ps/prompt-parse-HEAD-futureproof and ps/worktree-refdb-initialization.)

 Introduce a new extension "refstorage" so that we can mark a
 repository that uses a non-default ref backend, like reftable.
 source: <cover.1703833818.git.ps@pks.im>


* ps/reftable-fixes-and-optims (2024-01-03) 9 commits
  (merged to 'next' on 2024-01-08 at 167d7685f8)
 + reftable/merged: transfer ownership of records when iterating
 + reftable/merged: really reuse buffers to compute record keys
 + reftable/record: store "val2" hashes as static arrays
 + reftable/record: store "val1" hashes as static arrays
 + reftable/record: constify some parts of the interface
 + reftable/writer: fix index corruption when writing multiple indices
 + reftable/stack: do not auto-compact twice in `reftable_stack_add()`
 + reftable/stack: do not overwrite errors when compacting
 + Merge branch 'ps/reftable-fixes' into ps/reftable-fixes-and-optims

 More fixes and optimizations to the reftable backend.
 source: <cover.1704262787.git.ps@pks.im>


* tb/multi-pack-verbatim-reuse (2023-12-14) 26 commits
  (merged to 'next' on 2024-01-04 at 891ac0fa2c)
 + t/perf: add performance tests for multi-pack reuse
 + pack-bitmap: enable reuse from all bitmapped packs
 + pack-objects: allow setting `pack.allowPackReuse` to "single"
 + t/test-lib-functions.sh: implement `test_trace2_data` helper
 + pack-objects: add tracing for various packfile metrics
 + pack-bitmap: prepare to mark objects from multiple packs for reuse
 + pack-revindex: implement `midx_pair_to_pack_pos()`
 + pack-revindex: factor out `midx_key_to_pack_pos()` helper
 + midx: implement `midx_preferred_pack()`
 + git-compat-util.h: implement checked size_t to uint32_t conversion
 + pack-objects: include number of packs reused in output
 + pack-objects: prepare `write_reused_pack_verbatim()` for multi-pack reuse
 + pack-objects: prepare `write_reused_pack()` for multi-pack reuse
 + pack-objects: pass `bitmapped_pack`'s to pack-reuse functions
 + pack-objects: keep track of `pack_start` for each reuse pack
 + pack-objects: parameterize pack-reuse routines over a single pack
 + pack-bitmap: return multiple packs via `reuse_partial_packfile_from_bitmap()`
 + pack-bitmap: simplify `reuse_partial_packfile_from_bitmap()` signature
 + ewah: implement `bitmap_is_empty()`
 + pack-bitmap: pass `bitmapped_pack` struct to pack-reuse functions
 + midx: implement `midx_locate_pack()`
 + midx: implement `BTMP` chunk
 + midx: factor out `fill_pack_info()`
 + pack-bitmap: plug leak in find_objects()
 + pack-bitmap-write: deep-clear the `bb_commit` slab
 + pack-objects: free packing_data in more places

 Streaming spans of packfile data used to be done only from a
 single, primary, pack in a repository with multiple packfiles.  It
 has been extended to allow reuse from other packfiles, too.
 cf. <ZXurD1NTZ4TAs7WZ@nand.local>
 source: <cover.1702592603.git.me@ttaylorr.com>

--------------------------------------------------
[New Topics]

* es/some-up-to-date-messages-must-stay (2024-01-12) 1 commit
  (merged to 'next' on 2024-01-16 at 2b598f7de2)
 + messages: mark some strings with "up-to-date" not to touch

 Comment updates to help developers not to attempt to modify
 messages from plumbing commands that must stay constant.

 It might make sense to reassess the plumbing needs every few years,
 but that should be done as a separate effort.

 Will merge to 'master'.
 source: <20240112171910.11131-1-ericsunshine@charter.net>


* bk/complete-bisect (2024-01-12) 5 commits
 - completion: custom git-bisect terms
 - completion: custom git-bisect terms
 - completion: move to maintain define-before-use
 - completion: git-log opts to bisect visualize
 - completion: complete new old actions, start opts

 Command line completion support (in contrib/) has been
 updated for "git bisect".

 Needs review.
 source: <20240110020347.673155-1-britton.kerin@gmail.com>


* bk/complete-dirname-for-am-and-format-patch (2024-01-12) 1 commit
 - completion: dir-type optargs for am, format-patch

 Command line completion support (in contrib/) has been
 updated for a few commands to complete directory names where a
 directory name is expected.

 Needs review.
 source: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>


* bk/complete-send-email (2024-01-12) 1 commit
 - completion: don't complete revs when --no-format-patch

 Command line completion support (in contrib/) has been taught to
 avoid offering revision names as candidates to "git send-email" when
 the command is used to send pre-generated files.

 Needs review.
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


* gt/test-commit-o-i-options (2024-01-16) 2 commits
 - t7501: add tests for --amend --signoff
 - t7501: add tests for --include and --only

 A few tests to "git commit -o <pathspec>" and "git commit -i
 <pathspec>" has been added.

 Expecting a reroll.
 cf. <xmqq1qah46i0.fsf@gitster.g>
 source: <20240113042254.38602-1-shyamthakkar001@gmail.com>


* jt/tests-with-reftable (2024-01-12) 2 commits
 - t5541: remove lockfile creation
 - t1401: remove lockfile creation

 Tweak a few tests not to manually modify the reference database
 (hence easier to work with other backends like reftable).

 Will merge to 'next'.
 source: <pull.1634.v2.git.1705004670.gitgitgadget@gmail.com>


* la/strvec-comment-fix (2024-01-12) 1 commit
 - strvec: use correct member name in comments

 Comment fix.

 Will merge to 'next'.
 source: <pull.1640.git.1705043195997.gitgitgadget@gmail.com>


* la/trailer-api (2024-01-12) 10 commits
 - trailer: delete obsolete argument handling code from API
 - trailer: move arg handling to interpret-trailers.c
 - trailer: prepare to move parse_trailers_from_command_line_args() to builtin
 - trailer: spread usage of "trailer_block" language
 - trailer: make trailer_info struct private
 - sequencer: use the trailer iterator
 - trailer: delete obsolete formatting functions
 - trailer: unify trailer formatting machinery
 - trailer: include "trailer" term in API functions
 - trailer: move process_trailers() to interpret-trailers.c

 Code clean-up.

 Needs review.
 source: <pull.1632.git.1704869487.gitgitgadget@gmail.com>


* ps/tests-with-ref-files-backend (2024-01-12) 6 commits
 - t: mark tests regarding git-pack-refs(1) to be backend specific
 - t5526: break test submodule differently
 - t1419: mark test suite as files-backend specific
 - t1302: make tests more robust with new extensions
 - t1301: mark test for `core.sharedRepository` as reffiles specific
 - t1300: make tests more robust with non-default ref backends

 Prepare existing tests on refs to work better with non-default
 backends.

 Needs review.
 source: <cover.1704877233.git.ps@pks.im>


* ne/doc-filter-blob-limit-fix (2024-01-16) 1 commit
 - rev-list-options: fix off-by-one in '--filter=blob:limit=<n>' explainer

 Docfix.

 Will merge to 'next'.
 source: <pull.1645.git.git.1705261850650.gitgitgadget@gmail.com>


* ps/commit-graph-write-leakfix (2024-01-15) 1 commit
 - commit-graph: fix memory leak when not writing graph

 Leakfix.

 Will merge to 'next'.
 source: <0feab5e7d5bc6275e2c7671cd8f6786ea86fd610.1702891190.git.ps@pks.im>

--------------------------------------------------
[Cooking]

* cp/t4129-pipefix (2024-01-10) 1 commit
  (merged to 'next' on 2024-01-12 at fd9b72b71a)
 + t4129: prevent loss of exit code due to the use of pipes

 Test update.

 Will merge to 'master'.
 source: <pull.1636.git.1704891257544.gitgitgadget@gmail.com>


* rj/advice-delete-branch-not-fully-merged (2024-01-11) 3 commits
 - branch: make the advice to force-deleting a conditional one
 - advice: fix an unexpected leading space
 - advice: sort the advice related lists
 (this branch is used by rj/advice-disable-how-to-disable.)

 The error message given when "git branch -d branch" fails due to
 commits unique to the branch has been split into an error and a new
 conditional advice message.

 Will merge to 'next'.
 source: <4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>


* en/diffcore-delta-final-line-fix (2024-01-11) 1 commit
 - diffcore-delta: avoid ignoring final 'line' of file

 Rename detection logic ignored the final line of a file if it is an
 incomplete line.

 Expecting a reroll.
 cf. <xmqqedenearc.fsf@gitster.g>
 source: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>


* mj/gitweb-unreadable-config-error (2024-01-10) 1 commit
 - gitweb: die when a configuration file cannot be read

 When given an existing but unreadable file as a configuration file,
 gitweb behaved as if the file did not exist at all, but now it
 errors out.  This is a change that may break backward compatibility.

 Will merge to 'next'.
 source: <20240110225709.30168-1-marcelo.jimenez@gmail.com>


* ps/completion-with-reftable-fix (2024-01-16) 5 commits
 - completion: treat dangling symrefs as existing pseudorefs
 - completion: silence pseudoref existence check
 - completion: improve existence check for pseudo-refs
 - t9902: verify that completion does not print anything
 - completion: discover repo path in `__git_pseudoref_exists ()`

 Completion update to prepare for reftable

 Will merge to 'next'?
 source: <cover.1705314554.git.ps@pks.im>


* ps/p4-use-ref-api (2024-01-11) 1 commit
  (merged to 'next' on 2024-01-12 at 3f89cf25f6)
 + git-p4: stop reaching into the refdb

 "git p4" update to prepare for reftable

 Will merge to 'master'.
 source: <33d6a062ec56be33ed50a42a420be0b023f6f4cf.1704980814.git.ps@pks.im>


* ps/gitlab-ci-static-analysis (2024-01-08) 1 commit
  (merged to 'next' on 2024-01-10 at 71af34de07)
 + ci: add job performing static analysis on GitLab CI

 GitLab CI update.

 Will merge to 'master'.
 source: <1536a5ef07ad24dafb5d685b40099882f89e6cc5.1703761005.git.ps@pks.im>


* ps/prompt-parse-HEAD-futureproof (2024-01-08) 2 commits
  (merged to 'next' on 2024-01-10 at f9515b9d89)
 + git-prompt: stop manually parsing HEAD with unknown ref formats
 + Merge branch 'ps/refstorage-extension' into ps/prompt-parse-HEAD-futureproof

 Futureproof command line prompt support (in contrib/).

 Will merge to 'master'.
 source: <ef4e36a5a40c369da138242a8fdc9e12a846613b.1704356313.git.ps@pks.im>


* ps/reftable-optimize-io (2024-01-11) 5 commits
  (merged to 'next' on 2024-01-12 at 4096e880e0)
 + reftable/blocksource: use mmap to read tables
 + reftable/blocksource: refactor code to match our coding style
 + reftable/stack: use stat info to avoid re-reading stack list
 + reftable/stack: refactor reloading to use file descriptor
 + reftable/stack: refactor stack reloading to have common exit path

 Low-level I/O optimization for reftable.

 Will merge to 'master'.
 source: <cover.1704966670.git.ps@pks.im>


* rj/clarify-branch-doc-m (2024-01-08) 1 commit
  (merged to 'next' on 2024-01-10 at 432eaa2c6b)
 + branch: clarify <oldbranch> term

 Doc update.

 Will merge to 'master'.
 source: <d38e5a18-4d85-48f3-bc8b-8ca02ea683a4@gmail.com>


* tb/fetch-all-configuration (2024-01-08) 1 commit
  (merged to 'next' on 2024-01-12 at 6a05050382)
 + fetch: add new config option fetch.all

 "git fetch" learned to pay attention to "fetch.all" configuration
 variable, which pretends as if "--all" was passed from the command
 line when no remote parameter was given.

 Will merge to 'master'.
 source: <20240108211832.47362-1-dev@tb6.eu>


* rj/advice-disable-how-to-disable (2024-01-15) 1 commit
 - advice: allow disabling the automatic hint in advise_if_enabled()
 (this branch uses rj/advice-delete-branch-not-fully-merged.)

 All conditional "advice" messages show how to turn them off, which
 becomes repetitive.  Add a configuration variable to omit the
 instruction.

 Will requeue with better dependencies before merging to 'next'.
 source: <c870a0b6-9fa8-4d00-a5a6-661ca175805f@gmail.com>


* vd/fsck-submodule-url-test (2024-01-09) 3 commits
 - submodule-config.c: strengthen URL fsck check
 - t7450: test submodule urls
 - submodule-config.h: move check_submodule_url

 Tighten URL checks fsck makes in a URL recorded for submodules.

 Expecting a reroll (and review response).
 cf. <20240110103812.GB16674@coredump.intra.peff.net>
 cf. <ZZ46MrjSocJl-kpU@tanuki>
 source: <pull.1635.git.1704822817.gitgitgadget@gmail.com>


* sd/negotiate-trace-fix (2024-01-03) 1 commit
 - push: region_leave trace for negotiate_using_fetch

 Tracing fix.

 Waiting for a review response.
 cf. <xmqqbka27zu9.fsf@gitster.g>
 source: <20240103224054.1940209-1-delmerico@google.com>


* sk/mingw-owner-check-error-message-improvement (2024-01-10) 1 commit
  (merged to 'next' on 2024-01-12 at 05c56e151b)
 + mingw: give more details about unsafe directory's ownership

 In addition to (rather cryptic) Security Identifiers, show username
 and domain in the error message when we barf on mismatch between
 the Git directory and the current user.

 Will merge to 'master'.
 source: <20240108173837.20480-2-soekkle@freenet.de>


* ps/worktree-refdb-initialization (2024-01-08) 7 commits
 - builtin/worktree: create refdb via ref backend
 - worktree: expose interface to look up worktree by name
 - builtin/worktree: move setup of commondir file earlier
 - refs/files: skip creation of "refs/{heads,tags}" for worktrees
 - setup: move creation of "refs/" into the files backend
 - refs: prepare `refs_init_db()` for initializing worktree refs
 - Merge branch 'ps/refstorage-extension' into ps/worktree-refdb-initialization

 Instead of manually creating refs/ hierarchy on disk upon a
 creation of a secondary worktree, which is only usable via the
 files backend, use the refs API to populate it.

 Will merge to 'next'.
 source: <cover.1704705733.git.ps@pks.im>


* cp/apply-core-filemode (2023-12-26) 3 commits
 - apply: code simplification
 - apply: correctly reverse patch's pre- and post-image mode bits
 - apply: ignore working tree filemode when !core.filemode

 "git apply" on a filesystem without filemode support have learned
 to take a hint from what is in the index for the path, even when
 not working with the "--index" or "--cached" option, when checking
 the executable bit match what is required by the preimage in the
 patch.

 Needs review.
 source: <20231226233218.472054-1-gitster@pobox.com>


* al/unit-test-ctype (2024-01-16) 1 commit
 - unit-tests: rewrite t/helper/test-ctype.c as a unit test

 Move test-ctype helper to the unit-test framework.

 Will merge to 'next'.
 source: <20240112102743.1440-1-ach.lumap@gmail.com>


* bk/bisect-doc-fix (2024-01-10) 2 commits
  (merged to 'next' on 2024-01-12 at bdb3609554)
 + doc: refer to pathspec instead of path
 + doc: use singular form of repeatable path arg

 Synopsis fix.

 Will merge to 'master'.
 source: <20240103040207.661413-1-britton.kerin@gmail.com>


* ja/doc-placeholders-fix (2023-12-26) 2 commits
 - doc: enforce placeholders in documentation
 - doc: enforce dashes in placeholders

 Docfix.

 Needs review.
 source: <pull.1626.git.1703539287.gitgitgadget@gmail.com>


* jc/bisect-doc (2023-12-09) 1 commit
 - bisect: document "terms" subcommand more fully

 Doc update.

 Needs review.
 source: <xmqqzfyjmk02.fsf@gitster.g>


* tb/pair-chunk-expect (2023-11-10) 8 commits
 - midx: read `OOFF` chunk with `pair_chunk_expect()`
 - midx: read `OIDL` chunk with `pair_chunk_expect()`
 - commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
 - commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
 - commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
 - commit-graph: read `OIDL` chunk with `pair_chunk_expect()`
 - chunk-format: introduce `pair_chunk_expect()` helper
 - Merge branch 'jk/chunk-bounds-more' into HEAD

 Further code clean-up.

 Needs review.
 source: <cover.1699569246.git.me@ttaylorr.com>


* tb/path-filter-fix (2023-10-18) 17 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: drop unnecessary `graph_read_bloom_data_context`
 - commit-graph.c: unconditionally load Bloom filters
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
 - commit-graph: new filter ver. that fixes murmur3
 - repo-settings: introduce commitgraph.changedPathsVersion
 - t4216: test changed path filters with high bit paths
 - t/helper/test-read-graph: implement `bloom-filters` mode
 - bloom.h: make `load_bloom_filter_from_graph()` public
 - t/helper/test-read-graph.c: extract `dump_graph_info()`
 - gitformat-commit-graph: describe version 2 of BDAT
 - commit-graph: ensure Bloom filters are read with consistent settings
 - revision.c: consult Bloom filters for root commits
 - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Expecting a reroll?
 cf. <20231023202212.GA5470@szeder.dev>
 source: <cover.1697653929.git.me@ttaylorr.com>


* ak/color-decorate-symbols (2023-10-23) 7 commits
 - log: add color.decorate.pseudoref config variable
 - refs: exempt pseudorefs from pattern prefixing
 - refs: add pseudorefs array and iteration functions
 - log: add color.decorate.ref config variable
 - log: add color.decorate.symbol config variable
 - log: use designated inits for decoration_colors
 - config: restructure color.decorate documentation

 A new config for coloring.

 Needs review.
 source: <20231023221143.72489-1-andy.koppe@gmail.com>


* eb/hash-transition (2023-10-02) 30 commits
 - t1016-compatObjectFormat: add tests to verify the conversion between objects
 - t1006: test oid compatibility with cat-file
 - t1006: rename sha1 to oid
 - test-lib: compute the compatibility hash so tests may use it
 - builtin/ls-tree: let the oid determine the output algorithm
 - object-file: handle compat objects in check_object_signature
 - tree-walk: init_tree_desc take an oid to get the hash algorithm
 - builtin/cat-file: let the oid determine the output algorithm
 - rev-parse: add an --output-object-format parameter
 - repository: implement extensions.compatObjectFormat
 - object-file: update object_info_extended to reencode objects
 - object-file-convert: convert commits that embed signed tags
 - object-file-convert: convert commit objects when writing
 - object-file-convert: don't leak when converting tag objects
 - object-file-convert: convert tag objects when writing
 - object-file-convert: add a function to convert trees between algorithms
 - object: factor out parse_mode out of fast-import and tree-walk into in object.h
 - cache: add a function to read an OID of a specific algorithm
 - tag: sign both hashes
 - commit: export add_header_signature to support handling signatures on tags
 - commit: convert mergetag before computing the signature of a commit
 - commit: write commits for both hashes
 - object-file: add a compat_oid_in parameter to write_object_file_flags
 - object-file: update the loose object map when writing loose objects
 - loose: compatibilty short name support
 - loose: add a mapping between SHA-1 and SHA-256 for loose objects
 - repository: add a compatibility hash algorithm
 - object-names: support input of oids in any supported hash
 - oid-array: teach oid-array to handle multiple kinds of oids
 - object-file-convert: stubs for converting from one object format to another

 Teach a repository to work with both SHA-1 and SHA-256 hash algorithms.

 Needs review.
 source: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>


* jx/remote-archive-over-smart-http (2024-01-16) 6 commits
 - transport-helper: call do_take_over() in process_connect
 - transport-helper: call do_take_over() in connect_helper
 - http-backend: new rpc-service for git-upload-archive
 - transport-helper: protocol-v2 supports upload-archive
 - remote-curl: supports git-upload-archive service
 - transport-helper: no connection restriction in connect_helper

 "git archive --remote=<remote>" learned to talk over the smart
 http (aka stateless) transport.

 Will merge to 'next'?
 source: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>
