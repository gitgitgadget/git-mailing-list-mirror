Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C097171C4
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718164681; cv=none; b=QW2anM9L5/aEeh4RZ9UqeER7w5k8lH5OJWsrcVChuZyQ3vRNqsBfAnyzq3fH2q7oJzDGrGg9eqPc3bo64VbFD0duyd+HKrtFL0mYCdfp2CEwaP38UTCvlAXFsAQYIDtXVufp4ZOsDO7zebocdrFNkv1CPfD/ukbn/9E3A4jZ+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718164681; c=relaxed/simple;
	bh=pIezTOS1dJQXFo6OOQ/Jx2oKqrXr5UnOW/lurDZ8xvs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BWJgo3wEBw5Oki//dXXKKb2tmZtVQPl2SIs4qvlbEGcY+BYlgXc43He6g7J6olldvGPrcM6KwQRrPPyRsO4lbZmwZQVSxOnKj9N8kOEwqr1LdsYSFFctbrBiAiXNckY4lb09c3nr0O2XXBRz7F8vZFgM7ETV3qf4nKQ/RCeuBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VPyminP1; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VPyminP1"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B76001C34E;
	Tue, 11 Jun 2024 23:57:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=p
	IezTOS1dJQXFo6OOQ/Jx2oKqrXr5UnOW/lurDZ8xvs=; b=VPyminP1acwZNji8P
	6WwslwOnp8hplxn4FEZkZzGWLMpUNT8HiDrcpWb6L8wqChpfBqdBMlXlxC3JSIKR
	Hh3nD1cpR4RC/+wnnT3c36Z4O9E+L2D0W8ZuHiXLhC7e1nDMo6OryHTKRpvc6lZd
	mLqdKwM+xcZmsXtxcNu08xz238=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AECFA1C34D;
	Tue, 11 Jun 2024 23:57:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 800BF1C34C;
	Tue, 11 Jun 2024 23:57:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2024, #03; Tue, 11)
X-master-at: 8d94cfb54504f2ec9edc7ca3eb5c29a3dd3675ae
X-next-at: 995854087836ed4a61d3a38cc5e5fc7639b27baa
Date: Tue, 11 Jun 2024 20:57:50 -0700
Message-ID: <xmqqwmmuq0ch.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F13A5258-286F-11EF-A759-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

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

* iw/trace-argv-on-alias (2024-05-31) 3 commits
  (merged to 'next' on 2024-06-03 at 190af38284)
 + run-command: show prepared command
 + Documentation: alias: add notes on shell expansion
 + Documentation: alias: rework notes into points

 The alias-expanded command lines are logged to the trace output.
 source: <20240525234454.1489598-1-iwienand@redhat.com>


* jk/leakfixes (2024-05-30) 6 commits
  (merged to 'next' on 2024-06-03 at 1e8a6276a1)
 + mv: replace src_dir with a strvec
 + mv: factor out empty src_dir removal
 + mv: move src_dir cleanup to end of cmd_mv()
 + t-strvec: mark variable-arg helper with LAST_ARG_MUST_BE_NULL
 + t-strvec: use va_end() to match va_start()
 + Merge branch 'ps/leakfixes' into jk/leakfixes
 (this branch is used by jk/sparse-leakfix.)

 Memory leaks in "git mv" has been plugged.
 source: <20240530063857.GA1942535@coredump.intra.peff.net>


* mt/openindiana-scalar (2024-05-17) 1 commit
  (merged to 'next' on 2024-05-30 at 190d4465cf)
 + scalar: make enlistment delete to work on all POSIX platforms

 Avoid removing the $(cwd) for portability.
 source: <Zkds81OB7C5bTCl_@telcontar>


* ps/leakfixes (2024-05-27) 19 commits
  (merged to 'next' on 2024-05-29 at e75dcb3beb)
 + builtin/mv: fix leaks for submodule gitfile paths
 + builtin/mv: refactor to use `struct strvec`
 + builtin/mv duplicate string list memory
 + builtin/mv: refactor `add_slash()` to always return allocated strings
 + strvec: add functions to replace and remove strings
 + submodule: fix leaking memory for submodule entries
 + commit-reach: fix memory leak in `ahead_behind()`
 + builtin/credential: clear credential before exit
 + config: plug various memory leaks
 + config: clarify memory ownership in `git_config_string()`
 + builtin/log: stop using globals for format config
 + builtin/log: stop using globals for log config
 + convert: refactor code to clarify ownership of check_roundtrip_encoding
 + diff: refactor code to clarify memory ownership of prefixes
 + config: clarify memory ownership in `git_config_pathname()`
 + http: refactor code to clarify memory ownership
 + checkout: clarify memory ownership in `unique_tracking_name()`
 + strbuf: fix leak when `appendwholeline()` fails with EOF
 + transport-helper: fix leaking helper name
 (this branch is used by jk/imap-send-plug-all-msgs-leak, jk/leakfixes, jk/sparse-leakfix, ps/leakfixes-more and ps/no-writable-strings.)

 Leakfixes.
 source: <cover.1716810168.git.ps@pks.im>


* rs/difftool-env-simplify (2024-05-27) 1 commit
  (merged to 'next' on 2024-05-29 at 4d3776a989)
 + difftool: add env vars directly in run_file_diff()

 Code simplification.
 source: <c7c843b9-0ccf-4bcb-a036-d794729a99d6@web.de>


* tb/midx-write-cleanup (2024-05-30) 8 commits
  (merged to 'next' on 2024-05-31 at 03f3d27e4f)
 + pack-bitmap.c: reimplement `midx_bitmap_filename()` with helper
 + midx: replace `get_midx_rev_filename()` with a generic helper
 + midx-write.c: support reading an existing MIDX with `packs_to_include`
 + midx-write.c: extract `fill_packs_from_midx()`
 + midx-write.c: extract `should_include_pack()`
 + midx-write.c: pass `start_pack` to `compute_sorted_entries()`
 + midx-write.c: reduce argument count for `get_sorted_entries()`
 + midx-write.c: tolerate `--preferred-pack` without bitmaps

 Code clean-up around writing the .midx files.
 source: <cover.1717023301.git.me@ttaylorr.com>


* th/quiet-lazy-fetch-from-promisor (2024-05-26) 1 commit
  (merged to 'next' on 2024-05-29 at bb12492199)
 + promisor-remote: add promisor.quiet configuration option

 The promisor.quiet configuration knob can be set to true to make
 lazy fetching from promisor remotes silent.
 source: <20240525100927.2949808-1-tom@compton.nu>

--------------------------------------------------
[New Topics]

* jk/am-retry (2024-06-06) 2 commits
  (merged to 'next' on 2024-06-10 at 4d62361bc7)
 + test-terminal: drop stdin handling
 + am: add explicit "--retry" option

 "git am" has a safety feature to prevent it from starting a new
 session when there already is a session going.  It reliably
 triggers when a mbox is given on the command line, but it has to
 rely on the tty-ness of the standard input.  Add an explicit way to
 opt out of this safety with a command line option.

 Will merge to 'master'.
 source: <20240606081724.GA1166769@coredump.intra.peff.net>


* ps/ci-fix-detection-of-ubuntu-20 (2024-06-06) 1 commit
  (merged to 'next' on 2024-06-10 at 2d6725a946)
 + ci: fix check for Ubuntu 20.04

 Fix for an embarrassing typo that prevented running Python2 tests
 anywhere.

 Will merge to 'master'.
 source: <f91004a4382c95b1b87bf3d1aafc018af2b7b92e.1717662814.git.ps@pks.im>


* tb/pseudo-merge-reachability-bitmap-fixes (2024-06-06) 2 commits
 - pack-bitmap.c: ensure pseudo-merge offset reads are bounded
 - Documentation/technical/bitmap-format.txt: add missing position table
 (this branch uses tb/pseudo-merge-reachability-bitmap.)

 Two rather straight-forward fixes to the base topic that is cooking
 in 'next'.  Once people find it satisfactory, I plan to merge them
 into the base topic.

 Comments?
 source: <cover.1716499565.git.me@ttaylorr.com>


* db/date-underflow-fix (2024-06-08) 2 commits
 - SQUASH???
 - date: detect underflow/overflow when parsing dates with timezone offset

 date parser updates to be more careful about underflowing epoch
 based timestamp.

 Expecting a reroll.
 cf. <xmqq1q58ejnw.fsf@gitster.g>
 cf. <xmqqtthzrraw.fsf@gitster.g>
 source: <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>


* tb/commit-graph-use-tempfile (2024-06-07) 2 commits
 - server-info.c: remove temporary info files on exit
 - commit-graph.c: remove temporary graph layers on exit

 "git update-server-info" and "git commit-graph --write" have been
 updated to use the tempfile API to avoid leaving cruft after
 failing.

 Comments?
 cf. <xmqqfrtog2rd.fsf@gitster.g>
 source: <cover.1717712358.git.me@ttaylorr.com>


* tb/incremental-midx-part-1 (2024-06-07) 19 commits
 - midx: implement support for writing incremental MIDX chains
 - t/t5313-pack-bounds-checks.sh: prepare for sub-directories
 - t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 - midx: implement verification support for incremental MIDXs
 - midx: support reading incremental MIDX chains
 - midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
 - midx: teach `midx_preferred_pack()` about incremental MIDXs
 - midx: teach `midx_contains_pack()` about incremental MIDXs
 - midx: remove unused `midx_locate_pack()`
 - midx: teach `fill_midx_entry()` about incremental MIDXs
 - midx: teach `nth_midxed_offset()` about incremental MIDXs
 - midx: teach `bsearch_midx()` about incremental MIDXs
 - midx: introduce `bsearch_one_midx()`
 - midx: teach `nth_bitmapped_pack()` about incremental MIDXs
 - midx: teach `nth_midxed_object_oid()` about incremental MIDXs
 - midx: teach `prepare_midx_pack()` about incremental MIDXs
 - midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
 - midx: add new fields for incremental MIDX chains
 - Documentation: describe incremental MIDX format

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1717715060.git.me@ttaylorr.com>


* ds/doc-add-interactive-singlekey (2024-06-07) 1 commit
 - doc: interactive.singleKey is disabled by default

 Doc update.

 Will merge to 'next'.
 source: <xmqq4ja4e6d6.fsf@gitster.g>


* gt/unit-test-oidtree (2024-06-10) 1 commit
 - t/: migrate helper/test-oidtree.c to unit-tests/t-oidtree.c

 "oidtree" tests were rewritten to use the unit test framework.

 Expecting a reroll.
 cf. <7o6fuymnfn6b6buyw3yyctjd4dlwlrazspv3xgxvys6djjivxh@qbhyurorgbtt>
 source: <20240608165731.29467-1-shyamthakkar001@gmail.com>


* jc/varargs-attributes (2024-06-10) 4 commits
  (merged to 'next' on 2024-06-10 at a9c55c0f89)
 + __attribute__: add a few missing format attributes
 + __attribute__: mark some functions with LAST_ARG_MUST_BE_NULL
 + __attribute__: remove redundant attribute declaration for git_die_config()
 + __attribute__: trace2_region_enter_printf() is like "printf"

 Varargs functions that are unannotated as printf-like or execl-like
 have been annotated as such.

 Will merge to 'master'.
 source: <20240608183747.2084294-1-gitster@pobox.com>


* jc/worktree-git-path (2024-06-08) 1 commit
 - worktree_git_path(): move the declaration to path.h

 Code cleanup.

 Comments?
 source: <20240608183901.2084546-1-gitster@pobox.com>


* ds/ahead-behind-fix (2024-06-11) 1 commit
 - commit-graph: increment progress indicator

 Fix for a progress bar.

 Will merge to 'next'.
 source: <pull.1743.git.1718118555197.gitgitgadget@gmail.com>


* ps/abbrev-length-before-setup-fix (2024-06-11) 2 commits
 - object-name: don't try to abbreviate to lengths greater than hexsz
 - config: fix segfault when parsing "core.abbrev" without repo

 Setting core.abbrev too early before the repository set-up
 (typically in "git clone") caused segfault, which as been
 corrected.

 source: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>


* ps/make-append-to-cflags (2024-06-11) 1 commit
 - Makefile: add ability to append to CFLAGS and LDFLAGS

 To help developers, the build procedure now allows builders to use
 CFLAGS_APPEND to specify additional CFLAGS.

 Will merge to 'next'.
 source: <8120ddaf0bdfd50e0fc4cf9a04f833102630b639.1718001244.git.ps@pks.im>


* tb/multi-pack-reuse-fix (2024-06-11) 3 commits
 - pack-revindex.c: guard against out-of-bounds pack lookups
 - pack-bitmap.c: avoid uninitialized `pack_int_id` during reuse
 - midx-write.c: do not read existing MIDX with `packs_to_include`

 Assorted fixes to multi-pack-index code paths.

 Will merge to 'next'.
 source: <cover.1718126886.git.me@ttaylorr.com>


* vd/mktree (2024-06-11) 16 commits
 - mktree: remove entries when mode is 0
 - mktree: allow deeper paths in input
 - mktree: optionally add to an existing tree
 - mktree: add directory-file conflict hashmap
 - mktree: use iterator struct to add tree entries to index
 - mktree: create tree using an in-core index
 - mktree: overwrite duplicate entries
 - mktree: validate paths more carefully
 - mktree: add a --literally option
 - mktree: use read_index_info to read stdin lines
 - index-info.c: parse object type in provided in read_index_info
 - index-info.c: identify empty input lines in read_index_info
 - update-index: generalize 'read_index_info'
 - mktree: use non-static tree_entry array
 - mktree: rename treeent to tree_entry
 - mktree: use OPT_BOOL

 "git mktree" has been rewritten, taking advantage of the cache-tree
 API.

 source: <pull.1746.git.1718130288.gitgitgadget@gmail.com>


* xx/bundie-uri-fixes (2024-06-11) 3 commits
 - unbundle: support object verification for fetches
 - fetch-pack: expose fsckObjects configuration logic
 - bundle-uri: verify oid before writing refs

 When bundleURI interface fetches multiple bundles, Git failed to
 take full advantage of all bundles and ended up slurping duplicated
 objects.

 Will merge to 'next'?
 cf. <xmqqa5jruwkr.fsf@gitster.g>
 cf. <xmqqsexjtfcg.fsf@gitster.g>
 source: <pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* rj/add-p-pager (2024-06-04) 6 commits
 . add-patch: introduce the command '|'
 . test-terminal: introduce --no-stdin-pty
 . pager: introduce setup_custom_pager
 . pager: introduce wait_for_pager
 . pager: do not close fd 2 unnecessarily
 . add-patch: test for 'p' command

 "git add -i" and friends learned a new '|' command that sends the
 current hunk to the pager, instead of dumping it to the terminal.

 Expecting a reroll to work well with jk/am-retry
 source: <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>


* ap/credential-clear-fix (2024-06-06) 1 commit
  (merged to 'next' on 2024-06-07 at 933f06b899)
 + credential: clear expired c->credential, unify secret clearing

 Upon expiration event, we forgot to clear in-core authentication
 material other than password (whose support was added recently),
 which has been corrected.

 Will merge to 'master'.
 source: <20240606183516.4077896-2-aplattner@nvidia.com>


* jc/heads-are-branches (2024-06-04) 3 commits
 - show-ref: introduce --branches and deprecate --heads
 - ls-remote: introduce --branches and deprecate --heads
 - refs: call branches branches

 The "--heads" option of "ls-remote" and "show-ref" has been been
 deprecated; "--branches" replaces "--heads".

 Comments?
 source: <20240604220145.3260714-1-gitster@pobox.com>


* jk/imap-send-plug-all-msgs-leak (2024-06-07) 3 commits
  (merged to 'next' on 2024-06-10 at 9b8ec7b97d)
 + imap-send: free all_msgs strbuf in "out" label
 + Merge branch 'jc/t1517-more' into jk/imap-send-plug-all-msgs-leak
 + Merge branch 'ps/no-writable-strings' into jk/imap-send-plug-all-msgs-leak
 (this branch uses jc/t1517-more and ps/no-writable-strings.)

 A leak in "git imap-send" that somehow escapes LSan has been
 plugged.

 Will merge to 'master'.
 source: <20240605083526.GB2345232@coredump.intra.peff.net>


* ps/check-docs-fix (2024-06-06) 4 commits
  (merged to 'next' on 2024-06-10 at 12570afc8e)
 + ci/test-documentation: work around SyntaxWarning in Python 3.12
 + gitlab-ci: add job to run `make check-docs`
 + Documentation/lint-manpages: bubble up errors
 + Makefile: extract script to lint missing/extraneous manpages

 "make check-docs" noticed problems and reported to its output but
 failed to signal its findings with its exit status, which has been
 corrected.

 Will merge to 'master'.
 source: <cover.1717660597.git.ps@pks.im>


* rj/format-patch-auto-cover-with-interdiff (2024-06-07) 2 commits
 - format-patch: assume --cover-letter for diff in multi-patch series
 - t4014: cleanups in a few tests

 "git format-patch --interdiff" for multi-patch series learned to
 turn on cover letters automatically (unless told never to enable
 cover letter with "--no-cover-letter" and such).

 Will merge to 'next'?
 source: <9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>


* rs/diff-exit-code-with-external-diff (2024-06-10) 3 commits
 - diff: let external diffs report that changes are uninteresting
 - userdiff: add and use struct external_diff
 - t4020: test exit code with external diffs

 "git diff --exit-code --ext-diff" learned to take the exit status
 of the external diff driver into account when deciding the exit
 status of the overall "git diff" invocation when configured to do
 so.

 Will merge to 'next'.
 source: <168fecaa-2ebd-4897-b0ba-3bd2a37c01e7@web.de>


* jc/add-i-retire-usebuiltin-config (2024-06-05) 1 commit
 - add-i: finally retire add.interactive.useBuiltin

 For over a year, setting add.interactive.useBuiltin configuration
 variable did nothing but giving a "this does not do anything"
 warning.  Finally remove it.

 Comments?
 source: <xmqqikynqdvq.fsf@gitster.g>


* jc/no-default-attr-tree-in-bare (2024-06-05) 1 commit
 - attr.tree: HEAD:.gitattributes is no longer the default in a bare repo

 Earlier we stopped using the tree of HEAD as the default source of
 attributes in a bare repository, but failed to document it.  This
 has been corrected.

 Comments?
 source: <xmqqa5jzqd5k.fsf_-_@gitster.g>


* jk/sparse-leakfix (2024-06-05) 14 commits
  (merged to 'next' on 2024-06-06 at c92e02c528)
 + sparse-checkout: free duplicate hashmap entries
 + sparse-checkout: free string list after displaying
 + sparse-checkout: free pattern list in sparse_checkout_list()
 + sparse-checkout: free sparse_filename after use
 + sparse-checkout: refactor temporary sparse_checkout_patterns
 + sparse-checkout: always free "line" strbuf after reading input
 + sparse-checkout: reuse --stdin buffer when reading patterns
 + dir.c: always copy input to add_pattern()
 + dir.c: free removed sparse-pattern hashmap entries
 + sparse-checkout: clear patterns when init() sees existing sparse file
 + dir.c: free strings in sparse cone pattern hashmaps
 + sparse-checkout: pass string literals directly to add_pattern()
 + sparse-checkout: free string list in write_cone_to_file()
 + Merge branch 'jk/leakfixes' into jk/sparse-leakfix

 Many memory leaks in the sparse-checkout code paths have been
 plugged.

 Will merge to 'master'.
 source: <20240604100814.GA1304520@coredump.intra.peff.net>


* jk/cap-exclude-file-size (2024-06-05) 2 commits
  (merged to 'next' on 2024-06-05 at 2467011532)
 + dir.c: reduce max pattern file size to 100MB
  (merged to 'next' on 2024-06-04 at 51c0d632d3)
 + dir.c: skip .gitignore, etc larger than INT_MAX

 An overly large ".gitignore" files are now rejected silently.

 Will merge to 'master'.
 source: <xmqqikyowqjj.fsf@gitster.g>


* ps/leakfixes-more (2024-06-11) 30 commits
 - builtin/blame: fix leaking ignore revs files
 - builtin/blame: fix leaking prefixed paths
 - blame: fix leaking data for blame scoreboards
 - line-range: plug leaking find functions
 - merge: fix leaking merge bases
 - builtin/merge: fix leaking `struct cmdnames` in `get_strategy()`
 - sequencer: fix memory leaks in `make_script_with_merges()`
 - builtin/clone: plug leaking HEAD ref in `wanted_peer_refs()`
 - apply: fix leaking string in `match_fragment()`
 - sequencer: fix leaking string buffer in `commit_staged_changes()`
 - commit: fix leaking parents when calling `commit_tree_extended()`
 - config: fix leaking "core.notesref" variable
 - rerere: fix various trivial leaks
 - builtin/stash: fix leak in `show_stash()`
 - revision: free diff options
 - builtin/log: fix leaking commit list in git-cherry(1)
 - merge-recursive: fix memory leak when finalizing merge
 - builtin/merge-recursive: fix leaking object ID bases
 - builtin/difftool: plug memory leaks in `run_dir_diff()`
 - object-name: free leaking object contexts
 - builtin/rev-list: fix leaking bitmap index when calculating disk usage
 - notes: fix memory leak when pruning notes
 - revision: fix leaking display notes
 - merge-recursive: fix leaking rename conflict info
 - biultin/rev-parse: fix memory leaks in `--parseopt` mode
 - bundle: plug leaks in `create_bundle()`
 - notes-utils: free note trees when releasing copied notes
 - parse-options: fix leaks for users of OPT_FILENAME
 - revision: fix memory leak when reversing revisions
 - Merge branch 'ps/leakfixes' into ps/leakfixes-more

 More memory leaks have been plugged.

 Needs review.
 source: <cover.1718095906.git.ps@pks.im>


* gt/decorate-unit-test (2024-05-28) 1 commit
  (merged to 'next' on 2024-06-06 at dd2eb8cad4)
 + t/: migrate helper/test-example-decorate to the unit testing framework

 A test helper that essentially is unit tests on the "decorate"
 logic has been rewritten using the unit-tests framework.

 Will merge to 'master'.
 source: <20240528125837.31090-1-shyamthakkar001@gmail.com>


* jc/safe-directory-leading-path (2024-05-29) 1 commit
  (merged to 'next' on 2024-06-04 at 3d8cb9239c)
 + safe.directory: allow "lead/ing/path/*" match

 The safe.directory configuration knob has been updated to
 optionally allow leading path matches.

 Will merge to 'master'.
 source: <xmqqplt4zjw7.fsf@gitster.g>


* ps/no-writable-strings (2024-06-07) 28 commits
  (merged to 'next' on 2024-06-10 at 9678851a9f)
 + config.mak.dev: enable `-Wwrite-strings` warning
 + builtin/merge: always store allocated strings in `pull_twohead`
 + builtin/rebase: always store allocated string in `options.strategy`
 + builtin/rebase: do not assign default backend to non-constant field
 + imap-send: fix leaking memory in `imap_server_conf`
 + imap-send: drop global `imap_server_conf` variable
 + mailmap: always store allocated strings in mailmap blob
 + revision: always store allocated strings in output encoding
 + remote-curl: avoid assigning string constant to non-const variable
 + send-pack: always allocate receive status
 + parse-options: cast long name for OPTION_ALIAS
 + http: do not assign string constant to non-const field
 + compat/win32: fix const-correctness with string constants
 + pretty: add casts for decoration option pointers
 + object-file: make `buf` parameter of `index_mem()` a constant
 + object-file: mark cached object buffers as const
 + ident: add casts for fallback name and GECOS
 + entry: refactor how we remove items for delayed checkouts
 + line-log: always allocate the output prefix
 + line-log: stop assigning string constant to file parent buffer
 + diff: cast string constant in `fill_textconv()`
 + builtin/remote: cast away constness in `get_head_names()`
 + refspec: remove global tag refspec structure
 + reftable: cast away constness when assigning constants to records
 + refs/reftable: stop micro-optimizing refname allocations on copy
 + global: convert intentionally-leaking config strings to consts
 + global: improve const correctness when assigning string constants
 + Merge branch 'ps/leakfixes' into ps/no-writable-strings
 (this branch is used by jk/imap-send-plug-all-msgs-leak.)

 Building with "-Werror -Wwrite-strings" is now supported.

 Will merge to 'master'.
 source: <cover.1717740365.git.ps@pks.im>


* cp/reftable-unit-test (2024-05-30) 5 commits
  (merged to 'next' on 2024-06-04 at baff123933)
 + t: improve the test-case for parse_names()
 + t: add test for put_be16()
 + t: move tests from reftable/record_test.c to the new unit test
 + t: move tests from reftable/stack_test.c to the new unit test
 + t: move reftable/basics_test.c to the unit testing framework

 Reimplement basic unit tests for reftable under the unit test
 framework.

 Will merge to 'master'.
 source: <20240529171439.18271-1-chandrapratap3519@gmail.com>


* jc/t1517-more (2024-06-04) 2 commits
  (merged to 'next' on 2024-06-04 at f5a118872d)
 + imap-send: minimum leakfix
  (merged to 'next' on 2024-06-03 at 10b71e2a60)
 + t1517: more coverage for commands that work without repository
 (this branch is used by jk/imap-send-plug-all-msgs-leak.)

 "smoke tests" to ensure git commands that are designed to run
 outside repositories do work.

 Will merge to 'master'.
 source: <xmqqwmnajrrk.fsf@gitster.g>


* gt/t-hash-unit-test (2024-05-29) 2 commits
  (merged to 'next' on 2024-06-04 at 86328a5c8c)
 + t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash
 + strbuf: introduce strbuf_addstrings() to repeatedly add a string

 A pair of test helpers that essentially are unit tests on hash
 algorithms have been rewritten using the unit-tests framework.

 Will merge to 'master'.
 source: <20240529080030.64410-1-shyamthakkar001@gmail.com>


* pp/add-parse-range-unit-test (2024-05-27) 1 commit
 - apply: add unit tests for parse_range

 A unit test for code that parses the hunk offset and length from a
 patch fragment header as been added.

 Expecting a reroll.
 cf. <b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com>
 source: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>


* jc/format-patch-with-range-diff (2024-05-24) 2 commits
  (merged to 'next' on 2024-06-07 at 394989ee78)
 + format-patch: move range/inter diff at the end of a single patch output
 + show_log: factor out interdiff/range-diff generation

 Move inter/range-diff output to the end of the patch when
 format-patch adds it to a single patch, instead of writing it
 before the patch text, to be consistent with what is done for a
 cover letter for a multi-patch series.

 Will merge to 'master'.
 source: <20240523225007.2871766-1-gitster@pobox.com>


* cc/upload-pack-missing-action (2024-05-24) 3 commits
 - upload-pack: allow configuring a missing-action
 - pack-objects: use the missing action API
 - rev-list: refactor --missing=<missing-action>

 Allow a server S that is a lazy clone of another repository X to
 respond to a request by C that is a lazy clone of S in a way that
 it omits objects it itself does not have (and has to be lazily
 fetched from X).

 I would say this is a terribly irresponsive design, especially
 there is no negociation for S to learn if the objects it is going
 to omit is obtainable by C from elsewhere.

 Will discard.
 source: <20240524163926.2019648-1-christian.couder@gmail.com>


* ps/document-breaking-changes (2024-06-04) 4 commits
 - BreakingChanges: document that we do not plan to deprecate git-checkout
 - BreakingChanges: document removal of grafting
 - BreakingChanges: document upcoming change from "sha1" to "sha256"
 - docs: introduce document to announce breaking changes

 The structure of the document that records longer-term project
 decisions to deprecate/remove/update various behaviour has been
 outlined.

 Getting there.
 source: <cover.1717504292.git.ps@pks.im>


* ps/ref-storage-migration (2024-06-06) 14 commits
  (merged to 'next' on 2024-06-10 at 81b46b6916)
 + builtin/refs: new command to migrate ref storage formats
 + refs: implement logic to migrate between ref storage formats
 + refs: implement removal of ref storages
 + worktree: don't store main worktree twice
 + reftable: inline `merged_table_release()`
 + refs/files: fix NULL pointer deref when releasing ref store
 + refs/files: extract function to iterate through root refs
 + refs/files: refactor `add_pseudoref_and_head_entries()`
 + refs: allow to skip creation of reflog entries
 + refs: pass storage format to `ref_store_init()` explicitly
 + refs: convert ref storage format to an enum
 + setup: unset ref storage when reinitializing repository version
 + Merge branch 'ps/pseudo-ref-terminology' into ps/ref-storage-migration
 + Merge branch 'ps/refs-without-the-repository-updates' into ps/ref-storage-migration
 (this branch is used by ps/use-the-repository.)

 Allow migrating a repository that uses the files backend for its
 ref storage to use the reftable backend, with limitations.

 Will merge to 'master'.
 source: <cover.1717649802.git.ps@pks.im>


* tb/pseudo-merge-reachability-bitmap (2024-05-24) 25 commits
  (merged to 'next' on 2024-06-03 at fcaa39de12)
 + t/perf: implement performance tests for pseudo-merge bitmaps
 + pseudo-merge: implement support for finding existing merges
 + ewah: `bitmap_equals_ewah()`
 + pack-bitmap: extra trace2 information
 + pack-bitmap.c: use pseudo-merges during traversal
 + t/test-lib-functions.sh: support `--notick` in `test_commit_bulk()`
 + pack-bitmap: implement test helpers for pseudo-merge
 + ewah: implement `ewah_bitmap_popcount()`
 + pseudo-merge: implement support for reading pseudo-merge commits
 + pack-bitmap.c: read pseudo-merge extension
 + pseudo-merge: scaffolding for reads
 + pack-bitmap: extract `read_bitmap()` function
 + pack-bitmap-write.c: write pseudo-merge table
 + pseudo-merge: implement support for selecting pseudo-merge commits
 + config: introduce `git_config_double()`
 + pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
 + pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
 + pack-bitmap-write: support storing pseudo-merge commits
 + pseudo-merge.ch: initial commit
 + pack-bitmap: move some initialization to `bitmap_writer_init()`
 + ewah: implement `ewah_bitmap_is_subset()`
 + Documentation/technical: describe pseudo-merge bitmaps format
 + Documentation/gitpacking.txt: describe pseudo-merge bitmaps
 + Documentation/gitpacking.txt: initial commit
 + Merge branch 'tb/pack-bitmap-write-cleanups' into tb/pseudo-merge-reachability-bitmap
 (this branch is used by tb/pseudo-merge-reachability-bitmap-fixes.)

 The pseudo-merge reachability bitmap to help more efficient storage
 of the reachability bitmap in a repository with too many refs has
 been added.

 On hold until we get comments on the follow-up topic.
 source: <cover.1716499565.git.me@ttaylorr.com>


* kn/update-ref-symref (2024-06-07) 8 commits
 - update-ref: add support for 'symref-update' command
 - reftable: pick either 'oid' or 'target' for new updates
 - update-ref: add support for 'symref-create' command
 - update-ref: add support for 'symref-delete' command
 - update-ref: add support for 'symref-verify' command
 - refs: specify error for regular refs with `old_target`
 - refs: create and use `ref_update_expects_existing_old_ref()`
 - Merge branch 'kn/ref-transaction-symref' into kn/update-ref-symref

 "git update-ref --stdin" learned to handle transactional updates of
 symbolic-refs.

 Will merge to 'next'?
 source: <20240607133304.2333280-1-knayak@gitlab.com>


* ts/archive-prefix-with-add-virtual-file (2024-05-17) 1 commit
 - archive: make --add-virtual-file honor --prefix

 The "--add-virtual-file" option of "git archive", added primarily
 to help "git diagnose", has always ignored the "--prefix", but
 been documented to honor it.

 Iffy if updating the implementation is the best approach.
 cf. <bc3711a7-37d5-46bc-979e-83bd0b2cf900@web.de>
 source: <pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>


* tb/precompose-getcwd (2024-05-31) 1 commit
 - macOS: ls-files path fails if path of workdir is NFD

 We forgot to normalize the result of getcwd() to NFC on macOS where
 all other paths are normalized, which has been corrected.
 source: <20240531193156.28046-1-tboegi@web.de>


* pw/rebase-i-error-message (2024-05-30) 2 commits
 - rebase -i: improve error message when picking merge
 - rebase -i: pass struct replay_opts to parse_insn_line()

 When the user adds to "git rebase -i" instruction to "pick" a merge
 commit, the error experience is not pleasant.  Such an error is now
 caught earlier in the process that parses the todo list.

 Expecting a reroll.
 cf. <88bc0787-e7ae-49e5-99e8-97f6c55ea8c6@gmail.com>
 source: <pull.1672.v3.git.1717076630.gitgitgadget@gmail.com>


* ew/khash-to-khashl (2024-03-28) 3 commits
 - khashl: fix ensemble lookups on empty table
 - treewide: switch to khashl for memory savings
 - list-objects-filter: use kh_size API

 The hashtable library "khash.h" has been replaced with "khashl.h"
 that has better memory usage characteristics.

 Will discard.
 cf. <xmqqy1a4ao3t.fsf@gitster.g>
 source: <20240328101356.300374-1-e@80x24.org>


* ds/doc-config-reflow (2024-03-14) 1 commit
 - config.txt: perform some minor reformatting

 Reflow a paragraph in the documentation source without any effect
 to the formatted text.

 Will discard.
 source: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>


* ie/config-includeif-hostname (2024-03-19) 2 commits
 - config: learn the "hostname:" includeIf condition
 - t: add a test helper for getting hostname

 The conditional inclusion mechanism for configuration files learned
 to switch on the hostname.

 Expecting a reroll.
 cf. <20240319210428.GC1159535@coredump.intra.peff.net>
 cf. <20240320001934.GA903718@coredump.intra.peff.net>
 source: <20240319183722.211300-1-ignacio@iencinas.com>


* cw/git-std-lib (2024-02-28) 4 commits
 . SQUASH??? get rid of apparent debugging crufts
 . test-stdlib: show that git-std-lib is independent
 . git-std-lib: introduce Git Standard Library
 . pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>


* bk/complete-dirname-for-am-and-format-patch (2024-01-12) 1 commit
 - completion: dir-type optargs for am, format-patch

 Command line completion support (in contrib/) has been
 updated for a few commands to complete directory names where a
 directory name is expected.

 Expecting a reroll.
 cf. <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
 cf. <6683f24e-7e56-489d-be2d-8afe1fc38d2b@gmail.com>
 source: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>


* bk/complete-send-email (2024-01-12) 1 commit
 - completion: don't complete revs when --no-format-patch

 Command line completion support (in contrib/) has been taught to
 avoid offering revision names as candidates to "git send-email" when
 the command is used to send pre-generated files.

 Expecting a reroll.
 cf. <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


* tb/path-filter-fix (2024-01-31) 16 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: new Bloom filter version that fixes murmur3
 - commit-graph: unconditionally load Bloom filters
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
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

 Waiting for a final ack?
 cf. <ZcFjkfbsBfk7JQIH@nand.local>
 source: <cover.1706741516.git.me@ttaylorr.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>


--------------------------------------------------
[Discarded]

* ps/ci-use-Og-in-some-jobs (2024-06-10) 2 commits
 . ci: compile "linux-gcc-default" job with -Og
 . Makefile: add ability to append to CFLAGS and LDFLAGS

 Compile with -Og, which is different from the usual -O2, in one CI
 job, to see if we can get more warning coverage.

 Discarded.
 False positives in "-Og -Wall -Werror" are too annoying.
 source: <cover.1718001244.git.ps@pks.im>
