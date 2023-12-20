Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697284AF87
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tUU+63BI"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB9C41BEDF9;
	Wed, 20 Dec 2023 17:07:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=J
	9TrOlohDBk4sFDu21/xE5H4RD7yo/9agUvy/gQqFXo=; b=tUU+63BI39N6vJFRx
	4pKhOeoRtfV5ybnxsWn8MQ9ykTdc2fBKbkUoXpZU4AmGL5nXr7VzgOSOXIqyEpew
	jj2TJyThjzYLtsMtYQXVpuDhNzZa+axx5Dy2ZEgd9mM2KvuIUyi2Jf7H54P3yUOV
	e0iWg+Q79KPm66yBLnA92xtjmg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D31EA1BEDF8;
	Wed, 20 Dec 2023 17:07:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D36CD1BEDF4;
	Wed, 20 Dec 2023 17:07:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2023, #04; Wed, 20)
X-master-at: 055bb6e9969085777b7fab83e3fee0017654f134
X-next-at: def8568c9112108ee4bb819984aa902a04b042ad
Date: Wed, 20 Dec 2023 14:07:18 -0800
Message-ID: <xmqqh6kcr0ix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 24E91654-9F84-11EE-B9D0-25B3960A682E-77302942!pb-smtp2.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

The 'maint' branch now points at the maintenance track of Git 2.43,
which was released earlier in the month, and the tip of 'next' has
been rewound and rebuilt on top of Git 2.43.  I am planning to start
ejecting topics that have been in the "stalled" state for too long.

The RelNotes symbolic link says we are now working towards Git 2.44.
It may not be a bad idea to reflect on what technical debt and UI
warts we have accumulated so far to see if we have enough of them to
start planning for a breaking Git 3.0 release (or, of course, keep
incrementally improve the system, which is much more preferrable---
continuity and stability is good).

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

* en/complete-sparse-checkout (2023-12-03) 4 commits
  (merged to 'next' on 2023-12-12 at 3de75bd6af)
 + completion: avoid user confusion in non-cone mode
 + completion: avoid misleading completions in cone mode
 + completion: fix logic for determining whether cone mode is active
 + completion: squelch stray errors in sparse-checkout completion

 Command line completion (in contrib/) learned to complete path
 arguments to the "add/set" subcommands of "git sparse-checkout"
 better.
 source: <pull.1349.v3.git.1701583024.gitgitgadget@gmail.com>


* jc/revision-parse-int (2023-12-09) 1 commit
  (merged to 'next' on 2023-12-12 at 6209b4c97c)
 + revision: parse integer arguments to --max-count, --skip, etc., more carefully

 The command line parser for the "log" family of commands was too
 loose when parsing certain numbers, e.g., silently ignoring the
 extra 'q' in "git log -n 1q" without complaining, which has been
 tightened up.
 source: <xmqq5y181fx0.fsf_-_@gitster.g>


* jk/bisect-reset-fix (2023-12-09) 1 commit
  (merged to 'next' on 2023-12-12 at 8f946eafb6)
 + bisect: always clean on reset

 "git bisect reset" has been taught to clean up state files and refs
 even when BISECT_START file is gone.
 source: <20231207065341.GA778781@coredump.intra.peff.net>


* jk/config-cleanup (2023-12-09) 9 commits
  (merged to 'next' on 2023-12-12 at 44ee006c25)
 + sequencer: simplify away extra git_config_string() call
 + gpg-interface: drop pointless config_error_nonbool() checks
 + push: drop confusing configset/callback redundancy
 + config: use git_config_string() for core.checkRoundTripEncoding
 + diff: give more detailed messages for bogus diff.* config
 + config: use config_error_nonbool() instead of custom messages
 + imap-send: don't use git_die_config() inside callback
 + git_xmerge_config(): prefer error() to die()
 + config: reject bogus values for core.checkstat
 (this branch uses jk/implicit-true.)

 Code clean-up around use of configuration variables.
 source: <20231207071030.GA1275835@coredump.intra.peff.net>
 source: <20231207072338.GA1277727@coredump.intra.peff.net>


* jk/end-of-options (2023-12-09) 1 commit
  (merged to 'next' on 2023-12-12 at 4ae454b26d)
 + parse-options: decouple "--end-of-options" and "--"

 "git $cmd --end-of-options --rev -- --path" for some $cmd failed
 to interpret "--rev" as a rev, and "--path" as a path.  This was
 fixed for many programs like "reset" and "checkout".
 source: <20231206222145.GA136253@coredump.intra.peff.net>


* jk/implicit-true (2023-12-09) 7 commits
  (merged to 'next' on 2023-12-12 at 2a42fdc998)
 + fsck: handle NULL value when parsing message config
 + trailer: handle NULL value when parsing trailer-specific config
 + submodule: handle NULL value when parsing submodule.*.branch
 + help: handle NULL value for alias.* config
 + trace2: handle NULL values in tr2_sysenv config callback
 + setup: handle NULL value when parsing extensions
 + config: handle NULL value when parsing non-bools
 (this branch is used by jk/config-cleanup.)

 Some codepaths did not correctly parse configuration variables
 specified with valueless "true", which has been corrected.
 source: <20231207071030.GA1275835@coredump.intra.peff.net>


* jp/use-diff-index-in-pre-commit-sample (2023-12-03) 1 commit
  (merged to 'next' on 2023-12-12 at 4771ea61b9)
 + hooks--pre-commit: detect non-ASCII when renaming

 The sample pre-commit hook that tries to catch introduction of new
 paths that use potentially non-portable characters did not notice
 an existing path getting renamed to such a problematic path, when
 rename detection was enabled.
 source: <pull.1291.v2.git.git.1701360836307.gitgitgadget@gmail.com>


* mk/doc-gitfile-more (2023-12-03) 1 commit
  (merged to 'next' on 2023-12-12 at 7990e4a163)
 + doc: make the gitfile syntax easier to discover

 Doc update.
 source: <20231128065558.1061206-1-mk+copyleft@pimpmybyte.de>


* ps/ref-tests-update-more (2023-12-03) 10 commits
  (merged to 'next' on 2023-12-12 at 3d4004fe3b)
 + t6301: write invalid object ID via `test-tool ref-store`
 + t5551: stop writing packed-refs directly
 + t5401: speed up creation of many branches
 + t4013: simplify magic parsing and drop "failure"
 + t3310: stop checking for reference existence via `test -f`
 + t1417: make `reflog --updateref` tests backend agnostic
 + t1410: use test-tool to create empty reflog
 + t1401: stop treating FETCH_HEAD as real reference
 + t1400: split up generic reflog tests from the reffile-specific ones
 + t0410: mark tests to require the reffiles backend

 Tests update.
 source: <cover.1701242407.git.ps@pks.im>


* rs/incompatible-options-messages (2023-12-09) 7 commits
  (merged to 'next' on 2023-12-12 at a13847a7f6)
 + worktree: simplify incompatibility message for --orphan and commit-ish
 + worktree: standardize incompatibility messages
 + clean: factorize incompatibility message
 + revision, rev-parse: factorize incompatibility messages about - -exclude-hidden
 + revision: use die_for_incompatible_opt3() for - -graph/--reverse/--walk-reflogs
 + repack: use die_for_incompatible_opt3() for -A/-k/--cruft
 + push: use die_for_incompatible_opt4() for - -delete/--tags/--all/--mirror

 Clean-up code that handles combinations of incompatible options.
 source: <20231206115215.94467-1-l.s.r@web.de>

--------------------------------------------------
[New Topics]

* jc/retire-cas-opt-name-constant (2023-12-19) 1 commit
 - remote.h: retire CAS_OPT_NAME

 Code clean-up.

 Will merge to 'next'.
 source: <xmqq5y0uc7tq.fsf@gitster.g>


* rs/rebase-use-strvec-pushf (2023-12-20) 1 commit
  (merged to 'next' on 2023-12-20 at ecb190973c)
 + rebase: use strvec_pushf() for format-patch revisions

 Code clean-up.

 Will merge to 'master'.
 source: <4ab7431c-6c1b-448c-b4d2-e8b9be0e4eef@web.de>


* ps/refstorage-extension (2023-12-20) 13 commits
 - t9500: write "extensions.refstorage" into config
 - builtin/clone: introduce `--ref-format=` value flag
 - builtin/init: introduce `--ref-format=` value flag
 - builtin/rev-parse: introduce `--show-ref-format` flag
 - t: introduce GIT_TEST_DEFAULT_REF_FORMAT envvar
 - setup: introduce GIT_DEFAULT_REF_FORMAT envvar
 - setup: introduce "extensions.refStorage" extension
 - setup: set repository's formats on init
 - setup: start tracking ref storage format when
 - refs: refactor logic to look up storage backends
 - worktree: skip reading HEAD when repairing worktrees
 - t: introduce DEFAULT_REPO_FORMAT prereq
 - Merge branch 'ps/clone-into-reftable-repository' into ps/refstorage-extension
 (this branch uses ps/clone-into-reftable-repository.)

 Introduce a new extension "refstorage" so that we can mark a
 repository that uses a non-default ref backend, like reftable.

 Needs review.
 source: <cover.1703067989.git.ps@pks.im>


* ps/reftable-fixes-and-optims (2023-12-20) 9 commits
 - SQUASH??? make "make hdr-check" pass
 - reftable/merged: transfer ownership of records when iterating
 - reftable/merged: really reuse buffers to compute record keys
 - reftable/record: store "val2" hashes as static arrays
 - reftable/record: store "val1" hashes as static arrays
 - reftable/record: constify some parts of the interface
 - reftable/writer: fix index corruption when writing multiple indices
 - reftable/stack: do not overwrite errors when compacting
 - Merge branch 'ps/reftable-fixes' into ps/reftable-fixes-and-optims
 (this branch uses ps/reftable-fixes.)

 More fixes and optimizations to the reftable backend.

 Needs review.
 source: <cover.1703063544.git.ps@pks.im>

--------------------------------------------------
[Cooking]

* jk/mailinfo-oob-read-fix (2023-12-12) 1 commit
  (merged to 'next' on 2023-12-14 at 0dcfcb0d02)
 + mailinfo: fix out-of-bounds memory reads in unquote_quoted_pair()
 (this branch is used by jk/mailinfo-iterative-unquote-comment.)

 OOB read fix.

 Will merge to 'master'.
 source: <20231212221243.GA1656116@coredump.intra.peff.net>


* ps/pseudo-refs (2023-12-14) 4 commits
 - bisect: consistently write BISECT_EXPECTED_REV via the refdb
 - refs: complete list of special refs
 - refs: propagate errno when reading special refs fails
 - wt-status: read HEAD and ORIG_HEAD via the refdb

 Assorted changes around pseudoref handling.

 Will merge to 'next'.
 source: <cover.1702560829.git.ps@pks.im>


* rs/t6300-compressed-size-fix (2023-12-12) 1 commit
  (merged to 'next' on 2023-12-19 at 37ed09549c)
 + t6300: avoid hard-coding object sizes

 Test fix.

 Will merge to 'master'.
 source: <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>


* es/add-doc-list-short-form-of-all-in-synopsis (2023-12-15) 1 commit
  (merged to 'next' on 2023-12-18 at a4f20da2bf)
 + git-add.txt: add missing short option -A to synopsis

 Doc update.

 Will merge to 'master'.
 source: <20231215204333.1253-1-ericsunshine@charter.net>


* jc/doc-misspelt-refs-fix (2023-12-18) 1 commit
  (merged to 'next' on 2023-12-18 at e7799fd5c9)
 + doc: format.notes specify a ref under refs/notes/ hierarchy

 Doc update.

 Will merge to 'master'.
 source: <xmqqjzpfje33.fsf_-_@gitster.g>


* jc/doc-most-refs-are-not-that-special (2023-12-15) 5 commits
  (merged to 'next' on 2023-12-18 at aead30fcc8)
 + docs: MERGE_AUTOSTASH is not that special
 + docs: AUTO_MERGE is not that special
 + refs.h: HEAD is not that special
 + git-bisect.txt: BISECT_HEAD is not that special
 + git.txt: HEAD is not that special

 Doc updates.

 Will merge to 'master'.
 source: <20231215203245.3622299-1-gitster@pobox.com>


* jk/mailinfo-iterative-unquote-comment (2023-12-14) 2 commits
  (merged to 'next' on 2023-12-18 at 92363605fd)
 + mailinfo: avoid recursion when unquoting From headers
 + t5100: make rfc822 comment test more careful
 (this branch uses jk/mailinfo-oob-read-fix.)

 The code to parse the From e-mail header has been updated to avoid
 recursion.

 Will merge to 'master'.
 source: <20231214214444.GB2297853@coredump.intra.peff.net>


* ps/chainlint-self-check-update (2023-12-15) 1 commit
  (merged to 'next' on 2023-12-18 at 0de2e1807f)
 + tests: adjust whitespace in chainlint expectations

 Test framework update.

 Will merge to 'master'.
 source: <fb312f559de7b99244e4c86a995250599cd9be06.1702622508.git.ps@pks.im>


* tb/multi-pack-verbatim-reuse (2023-12-14) 26 commits
 - t/perf: add performance tests for multi-pack reuse
 - pack-bitmap: enable reuse from all bitmapped packs
 - pack-objects: allow setting `pack.allowPackReuse` to "single"
 - t/test-lib-functions.sh: implement `test_trace2_data` helper
 - pack-objects: add tracing for various packfile metrics
 - pack-bitmap: prepare to mark objects from multiple packs for reuse
 - pack-revindex: implement `midx_pair_to_pack_pos()`
 - pack-revindex: factor out `midx_key_to_pack_pos()` helper
 - midx: implement `midx_preferred_pack()`
 - git-compat-util.h: implement checked size_t to uint32_t conversion
 - pack-objects: include number of packs reused in output
 - pack-objects: prepare `write_reused_pack_verbatim()` for multi-pack reuse
 - pack-objects: prepare `write_reused_pack()` for multi-pack reuse
 - pack-objects: pass `bitmapped_pack`'s to pack-reuse functions
 - pack-objects: keep track of `pack_start` for each reuse pack
 - pack-objects: parameterize pack-reuse routines over a single pack
 - pack-bitmap: return multiple packs via `reuse_partial_packfile_from_bitmap()`
 - pack-bitmap: simplify `reuse_partial_packfile_from_bitmap()` signature
 - ewah: implement `bitmap_is_empty()`
 - pack-bitmap: pass `bitmapped_pack` struct to pack-reuse functions
 - midx: implement `midx_locate_pack()`
 - midx: implement `BTMP` chunk
 - midx: factor out `fill_pack_info()`
 - pack-bitmap: plug leak in find_objects()
 - pack-bitmap-write: deep-clear the `bb_commit` slab
 - pack-objects: free packing_data in more places

 Streaming spans of packfile data used to be done only from a
 single, primary, pack in a repository with multiple packfiles.  It
 has been extended to allow reuse from other packfiles, too.

 Will merge to 'next'?
 cf. <ZXurD1NTZ4TAs7WZ@nand.local>
 source: <cover.1702592603.git.me@ttaylorr.com>


* rs/c99-stdbool-test-balloon (2023-12-18) 1 commit
  (merged to 'next' on 2023-12-18 at 5a62aaa127)
 + git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool

 Test balloon to use C99 "bool" type from <stdbool.h>.

 Will merge to 'master'.
 source: <2d30dc36-6091-4b47-846f-92d3f4a8b135@web.de>


* sp/test-i18ngrep (2023-12-18) 1 commit
  (merged to 'next' on 2023-12-18 at d54442693a)
 + test-lib-functions.sh: fix test_grep fail message wording

 Error message fix in the test framework.

 Will merge to 'master'.
 source: <20231203171956.771-1-shreyanshpaliwalcmsmn@gmail.com>


* jx/fetch-atomic-error-message-fix (2023-12-18) 2 commits
  (merged to 'next' on 2023-12-18 at a1988b00e5)
 + fetch: no redundant error message for atomic fetch
 + t5574: test porcelain output of atomic fetch

 "git fetch --atomic" issued an unnecessary empty error message,
 which has been corrected.

 Will merge to 'master'.
 cf. <ZX__e7VjyLXIl-uV@tanuki>
 source: <cover.1702821462.git.zhiyou.jx@alibaba-inc.com>


* jc/bisect-doc (2023-12-09) 1 commit
 - bisect: document "terms" subcommand more fully

 Doc update.

 Needs review.
 source: <xmqqzfyjmk02.fsf@gitster.g>


* rs/show-ref-incompatible-options (2023-12-11) 1 commit
  (merged to 'next' on 2023-12-18 at 5a092285f7)
 + show-ref: use die_for_incompatible_opt3()

 Code clean-up for sanity checking of command line options for "git
 show-ref".

 Will merge to 'master'.
 source: <e5304253-3347-4900-bbf2-d3c6ee3fb976@web.de>


* sh/completion-with-reftable (2023-12-19) 2 commits
  (merged to 'next' on 2023-12-20 at 7957d4aa5b)
 + completion: support pseudoref existence checks for reftables
 + completion: refactor existence checks for pseudorefs

 Command line completion script (in contrib/) learned to work better
 with the reftable backend.

 Will merge to 'master'.
 source: <cover.1703022850.git.stanhu@gmail.com>


* en/header-cleanup (2023-12-03) 12 commits
 - treewide: remove unnecessary includes in source files
 - treewide: add direct includes currently only pulled in transitively
 - trace2/tr2_tls.h: remove unnecessary include
 - submodule-config.h: remove unnecessary include
 - pkt-line.h: remove unnecessary include
 - line-log.h: remove unnecessary include
 - http.h: remove unnecessary include
 - fsmonitor--daemon.h: remove unnecessary includes
 - blame.h: remove unnecessary includes
 - archive.h: remove unnecessary include
 - treewide: remove unnecessary includes in source files
 - treewide: remove unnecessary includes from header files

 Remove unused header "#include".

 Has a few interactions with topics in flight.
 source: <pull.1617.git.1701585682.gitgitgadget@gmail.com>


* ps/clone-into-reftable-repository (2023-12-12) 7 commits
  (merged to 'next' on 2023-12-19 at adf7eb1f84)
 + builtin/clone: create the refdb with the correct object format
 + builtin/clone: skip reading HEAD when retrieving remote
 + builtin/clone: set up sparse checkout later
 + builtin/clone: fix bundle URIs with mismatching object formats
 + remote-curl: rediscover repository when fetching refs
 + setup: allow skipping creation of the refdb
 + setup: extract function to create the refdb
 (this branch is used by ps/refstorage-extension.)

 "git clone" has been prepared to allow cloning a repository with
 non-default hash function into a repository that uses the reftable
 backend.

 Will merge to 'master'.
 source: <cover.1702361370.git.ps@pks.im>


* jc/checkout-B-branch-in-use (2023-12-13) 2 commits
  (merged to 'next' on 2023-12-14 at 0a3998619e)
 + checkout: forbid "-B <branch>" from touching a branch used elsewhere
 + checkout: refactor die_if_checked_out() caller

 "git checkout -B <branch> [<start-point>]" allowed a branch that is
 in use in another worktree to be updated and checked out, which
 might be a bit unexpected.  The rule has been tightened, which is a
 breaking change.  "--ignore-other-worktrees" option is required to
 unbreak you, if you are used to the current behaviour that "-B"
 overrides the safety.

 Will merge to 'master'.
 source: <xmqqjzq9cl70.fsf@gitster.g>


* ps/reftable-fixes (2023-12-11) 11 commits
  (merged to 'next' on 2023-12-15 at ebba966016)
 + reftable/block: reuse buffer to compute record keys
 + reftable/block: introduce macro to initialize `struct block_iter`
 + reftable/merged: reuse buffer to compute record keys
 + reftable/stack: fix use of unseeded randomness
 + reftable/stack: fix stale lock when dying
 + reftable/stack: reuse buffers when reloading stack
 + reftable/stack: perform auto-compaction with transactional interface
 + reftable/stack: verify that `reftable_stack_add()` uses auto-compaction
 + reftable: handle interrupted writes
 + reftable: handle interrupted reads
 + reftable: wrap EXPECT macros in do/while
 (this branch is used by ps/reftable-fixes-and-optims.)

 Bunch of small fix-ups to the reftable code.

 Will merge to 'master'.
 source: <cover.1702285387.git.ps@pks.im>


* jc/orphan-unborn (2023-11-24) 2 commits
 - orphan/unborn: fix use of 'orphan' in end-user facing messages
 - orphan/unborn: add to the glossary and use them consistently

 Doc updates to clarify what an "unborn branch" means.

 Will merge to 'next'.
 source: <xmqq4jhb977x.fsf@gitster.g>


* jw/builtin-objectmode-attr (2023-12-12) 2 commits
 - SQUASH??? - leakfix
 - attr: add builtin objectmode values support

 The builtin_objectmode attribute is populated for each path
 without adding anything in .gitattributes files, which would be
 useful in magic pathspec, e.g., ":(attr:builtin_objectmode=100755)"
 to limit to executables.

 Needs to get leakfix reviewed.
 source: <20231116054437.2343549-1-jojwang@google.com>


* tb/merge-tree-write-pack (2023-10-23) 5 commits
 - builtin/merge-tree.c: implement support for `--write-pack`
 - bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
 - bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
 - bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
 - bulk-checkin: extract abstract `bulk_checkin_source`

 "git merge-tree" learned "--write-pack" to record its result
 without creating loose objects.

 Broken when an object created during a merge is needed to continue merge
 cf. <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
 source: <cover.1698101088.git.me@ttaylorr.com>


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

 Expecting a reroll.
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


* la/trailer-cleanups (2023-12-20) 3 commits
 - trailer: use offsets for trailer_start/trailer_end
 - trailer: find the end of the log message
 - commit: ignore_non_trailer computes number of bytes to ignore

 Code clean-up.

 Will merge to 'next'.
 source: <pull.1563.v5.git.1697828495.gitgitgadget@gmail.com>


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


* jx/remote-archive-over-smart-http (2023-12-14) 4 commits
 - archive: support remote archive from stateless transport
 - transport-helper: call do_take_over() in connect_helper
 - transport-helper: call do_take_over() in process_connect
 - transport-helper: no connection restriction in connect_helper

 "git archive --remote=<remote>" learned to talk over the smart
 http (aka stateless) transport.

 Needs review.
 source: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>


* jx/sideband-chomp-newline-fix (2023-12-18) 3 commits
 - pkt-line: do not chomp newlines for sideband messages
 - pkt-line: memorize sideband fragment in reader
 - test-pkt-line: add option parser for unpack-sideband

 Sideband demultiplexer fixes.

 Will merge to 'next'?
 source: <cover.1702823801.git.zhiyou.jx@alibaba-inc.com>


* jc/fake-lstat (2023-09-15) 1 commit
  (merged to 'next' on 2023-12-15 at 48e34cc0b4)
 + cache: add fake_lstat()
 (this branch is used by jc/diff-cached-fsmonitor-fix.)

 A new helper to let us pretend that we called lstat() when we know
 our cache_entry is up-to-date via fsmonitor.

 Will merge to 'master'.
 cf. <e5295dbe-94d2-3186-5663-2466eba4bdde@jeffhostetler.com>
 source: <xmqqcyykig1l.fsf@gitster.g>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>


* rj/status-bisect-while-rebase (2023-10-16) 1 commit
 - status: fix branch shown when not only bisecting

 "git status" is taught to show both the branch being bisected and
 being rebased when both are in effect at the same time.

 Will merge to 'next'.
 cf. <xmqqil76kyov.fsf@gitster.g>
 source: <2e24ca9b-9c5f-f4df-b9f8-6574a714dfb2@gmail.com>


* jc/diff-cached-fsmonitor-fix (2023-09-15) 3 commits
  (merged to 'next' on 2023-12-15 at 4aa7596593)
 + diff-lib: fix check_removed() when fsmonitor is active
 + Merge branch 'jc/fake-lstat' into jc/diff-cached-fsmonitor-fix
 + Merge branch 'js/diff-cached-fsmonitor-fix' into jc/diff-cached-fsmonitor-fix
 (this branch uses jc/fake-lstat.)

 The optimization based on fsmonitor in the "diff --cached"
 codepath is resurrected with the "fake-lstat" introduced earlier.

 Will merge to 'master'.
 cf. <e5295dbe-94d2-3186-5663-2466eba4bdde@jeffhostetler.com>
 source: <xmqqr0n0h0tw.fsf@gitster.g>
