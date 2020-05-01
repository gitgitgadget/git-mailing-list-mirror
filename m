Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E8CC47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425E920857
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K+DEtpBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgEAWJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 18:09:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57553 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgEAWJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 18:09:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 324825B25A;
        Fri,  1 May 2020 18:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=M
        2TfLLm6pptlnyEcExRflMhlFQ8=; b=K+DEtpBRIDdccL77OoAJZSTScWxpFfOZX
        N+Dzbw3VBlKd5FSDUe+9pLHx4V485Q2J3w+4CosWgai9qYcmse1sXjPAdziybKwv
        opV842K/SLPUNCAXdRAeQbgQWON1dVGOrVFBZK7rtk8IeM55558zN/AZCEaZYMw5
        38tRTxMFgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=taI
        CtGq/Dv/samSAkwFn9BR/H79IiWvlCFUMwgUX4VbVLn/ufrqOduNv9hGZeteDwwp
        cYwGj13kcDsdeu+/y/SDB5AmhXJRA0zxDTB9D8m6gMl88dYzMdIYifoOpO8x0wnu
        kQuTr3h6+urRn3fBBd3TX/YqS9h9UjZVNfRAOujI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AA325B259;
        Fri,  1 May 2020 18:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C1405B252;
        Fri,  1 May 2020 18:09:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2020, #01; Fri, 1)
X-master-at: b34789c0b0d3b137f0bb516b417bd8d75e0cb306
X-next-at: 232c24e857ed6ddde51b0435add1905f58948aec
Date:   Fri, 01 May 2020 15:08:59 -0700
Message-ID: <xmqq8sibl344.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C5228FE-8BF8-11EA-AE7A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The sixth batch merged quite a few topics to 'master'; they haven't
spent the usual "at least a week" in the 'next' branch, but all of
them looked quite safe and benign.  Knock wood.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* dd/mailinfo-with-nul (2020-04-22) 3 commits
  (merged to 'next' on 2020-04-28 at b1d3e40d49)
 + mailinfo: disallow NUL character in mail's header
 + mailinfo.c: avoid strlen on strings that can contains NUL
 + t4254: merge 2 steps of a single test

 Tighten "git mailinfo" to notice and error out when decoded result
 contains NUL in it.


* dd/sparse-fixes (2020-04-27) 4 commits
  (merged to 'next' on 2020-04-28 at d809f916ee)
 + progress.c: silence cgcc suggestion about internal linkage
 + graph.c: limit linkage of internal variable
 + compat/regex: move stdlib.h up in inclusion chain
 + test-parse-pathspec-file.c: s/0/NULL/ for pointer type

 Compilation fix.


* dl/test-must-fail-fixes-4 (2020-04-20) 7 commits
  (merged to 'next' on 2020-04-28 at 6f4804aa09)
 + t9819: don't use test_must_fail with p4
 + t9164: use test_must_fail only on git commands
 + t9160: use test_path_is_missing()
 + t9141: use test_path_is_missing()
 + t7508: don't use `test_must_fail test_cmp`
 + t7408: replace incorrect uses of test_must_fail
 + t6030: use test_path_is_missing()

 Test clean-up.


* ds/blame-on-bloom (2020-04-23) 6 commits
  (merged to 'next' on 2020-04-28 at 6152eb2eb3)
 + test-bloom: check that we have expected arguments
 + test-bloom: fix some whitespace issues
 + blame: drop unused parameter from maybe_changed_path
  (merged to 'next' on 2020-04-22 at dc4f24e54b)
 + blame: use changed-path Bloom filters
 + tests: write commit-graph with Bloom filters
 + revision: complicated pathspecs disable filters
 (this branch is used by ds/line-log-on-bloom; uses gs/commit-graph-path-filter.)

 "git blame" learns to take advantage of the "changed-paths" Bloom
 filter stored in the commit-graph file.


* ds/build-homebrew-gettext-fix (2020-04-27) 1 commit
  (merged to 'next' on 2020-04-28 at 70c6eca470)
 + macOS/brew: let the build find gettext headers/libraries/msgfmt

 Recent update to Homebrew used by macOS folks breaks build by
 moving gettext library and necessary headers.


* ds/multi-pack-index (2020-04-24) 1 commit
  (merged to 'next' on 2020-04-28 at b8f9691cbc)
 + multi-pack-index: close file descriptor after mmap

 The multi-pack-index left mmapped file descriptors open when it
 does not have to.


* eb/gitweb-more-trailers (2020-04-24) 1 commit
  (merged to 'next' on 2020-04-28 at 7b16ac0810)
 + gitweb: Recognize *-to and Closes/Fixes trailers

 Gitweb updates.


* en/rebase-root-and-fork-point-are-incompatible (2020-04-27) 1 commit
  (merged to 'next' on 2020-04-28 at 8ea4882905)
 + rebase: display an error if --root and --fork-point are both provided

 Incompatible options "--root" and "--fork-point" of "git rebase"
 have been marked and documented as being incompatible.


* es/bugreport (2020-04-27) 6 commits
  (merged to 'next' on 2020-04-28 at fdfd36a5d7)
 + bugreport: drop extraneous includes
  (merged to 'next' on 2020-04-22 at f5a2ab988e)
 + bugreport: add compiler info
 + bugreport: add uname info
 + bugreport: gather git version and build info
 + bugreport: add tool to generate debugging info
 + help: move list_config_help to builtin/help
 (this branch is used by es/bugreport-with-hooks.)

 The "bugreport" tool.


* gs/commit-graph-path-filter (2020-04-09) 16 commits
  (merged to 'next' on 2020-04-22 at 34b35f43bd)
 + bloom: ignore renames when computing changed paths
 + commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
 + t4216: add end to end tests for git log with Bloom filters
 + revision.c: add trace2 stats around Bloom filter usage
 + revision.c: use Bloom filters to speed up path based revision walks
 + commit-graph: add --changed-paths option to write subcommand
 + commit-graph: reuse existing Bloom filters during write
 + commit-graph: write Bloom filters to commit graph file
 + commit-graph: examine commits by generation number
 + commit-graph: examine changed-path objects in pack order
 + commit-graph: compute Bloom filters for changed paths
 + diff: halt tree-diff early after max_changes
 + bloom.c: core Bloom filter implementation for changed paths.
 + bloom.c: introduce core Bloom filter constructs
 + bloom.c: add the murmur3 hash implementation
 + commit-graph: define and use MAX_NUM_CHUNKS
 (this branch is used by ds/blame-on-bloom and ds/line-log-on-bloom.)

 Introduce an extension to the commit-graph to make it efficient to
 check for the paths that were modified at each commit using Bloom
 filters.


* jk/build-with-right-curl (2020-04-05) 3 commits
  (merged to 'next' on 2020-04-28 at 1718c25b44)
 + Makefile: avoid running curl-config unnecessarily
 + Makefile: use curl-config --cflags
 + Makefile: avoid running curl-config multiple times

 The build procedure did not use the libcurl library and its include
 files correctly for a custom-built installation.
 cf. <20200428033611.GB2369457@coredump.intra.peff.net>


* js/anonymise-push-url-in-errors (2020-04-28) 1 commit
  (merged to 'next' on 2020-04-28 at 49539cf116)
 + push: anonymize URLs in error messages and warnings

 Error and verbose trace messages from "git push" did not redact
 credential material embedded in URLs.


* jt/v2-fetch-nego-fix (2020-04-28) 3 commits
  (merged to 'next' on 2020-04-28 at c6f9ebf2f7)
 + fetch-pack: in protocol v2, reset in_vain upon ACK
 + fetch-pack: in protocol v2, in_vain only after ACK
 + fetch-pack: return enum from process_acks()

 The upload-pack protocol v2 gave up too early before finding a
 common ancestor, resulting in a wasteful fetch from a fork of a
 project.  This has been corrected to match the behaviour of v0
 protocol.


* mt/doc-worktree-ref (2020-04-24) 1 commit
  (merged to 'next' on 2020-04-28 at d96c05cb0a)
 + config doc: fix reference to config.worktree info

 Docfix.


* tb/commit-graph-fd-exhaustion-fix (2020-04-24) 4 commits
  (merged to 'next' on 2020-04-28 at 6d5fd6bc49)
 + commit-graph: close descriptors after mmap
 + commit-graph.c: gracefully handle file descriptor exhaustion
 + t/test-lib.sh: make ULIMIT_FILE_DESCRIPTORS available to tests
 + commit-graph.c: don't use discarded graph_name in error
 (this branch is tangled with tb/commit-graph-split-strategy.)

 The commit-graph code exhausted file descriptors easily when it
 does not have to.


* tb/commit-graph-split-strategy (2020-04-29) 8 commits
  (merged to 'next' on 2020-04-29 at 99fa922569)
 + Revert "commit-graph.c: introduce '--[no-]check-oids'"
 + commit-graph.c: introduce '--[no-]check-oids'
 + commit-graph.h: replace 'commit_hex' with 'commits'
 + oidset: introduce 'oidset_size'
 + builtin/commit-graph.c: introduce split strategy 'replace'
 + builtin/commit-graph.c: introduce split strategy 'no-merge'
 + builtin/commit-graph.c: support for '--split[=<strategy>]'
 + t/helper/test-read-graph.c: support commit-graph chains
 (this branch is tangled with tb/commit-graph-fd-exhaustion-fix.)

 "git commit-graph write" learned different ways to write out split
 files.


* tb/reset-shallow (2020-04-24) 2 commits
  (merged to 'next' on 2020-04-28 at 9510639ae8)
 + shallow.c: use '{commit,rollback}_shallow_file'
 + t5537: use test_write_lines and indented heredocs for readability
 (this branch is used by tb/shallow-cleanup.)

 Fix in-core inconsistency after fetching into a shallow repository
 that broke the code to write out commit-graph.

--------------------------------------------------
[New Topics]

* ds/line-log-on-bloom (2020-05-01) 12 commits
 - line-log: integrate with changed-path Bloom filters
 - line-log: try to use generation number-based topo-ordering
 - line-log: more responsive, incremental 'git log -L'
 - t4211-line-log: add tests for parent oids
 - line-log: remove unused fields from 'struct line_log_data'
 - completion: offer '--(no-)patch' among 'git log' options
 - bloom: use num_changes not nr for limit detection
 - bloom: parse commit before computing filters
 - bloom: de-duplicate directory entries
 - Documentation: changed-path Bloom filters use byte words
 - test-bloom: fix usage typo
 - bloom: fix whitespace around tab length

 "git log -L..." now takes advantage of the "which paths are touched
 by this commit?" info stored in the commit-graph system.


* es/restore-staged-from-head-by-default (2020-05-01) 3 commits
 - restore: default to HEAD when combining --worktree and --staged
 - fixup! restore: require --source when combining --worktree and --staged
 - restore: require --source when combining --worktree and --staged

 "git restore --staged --worktree" now defaults to take the contents
 out of "HEAD", instead of erroring out.


* jk/credential-sample-update (2020-05-01) 2 commits
 - gitcredentials(7): make shell-snippet example more realistic
 - gitcredentials(7): clarify quoting of helper examples

 The samples in the credential documentation has been updated to
 make it clear that we depict what would appear in the .git/config
 file, by adding appropriate quotes as needed..

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* cb/credential-store-warn-bogus-lines (2020-04-30) 2 commits
 - credential-store: warn instead of fatal for bogus lines from store
 - credential-store: document the file format a bit more

 With the recent tightening of the code that is used to parse
 various parts of a URL for use in the credential subsystem, a
 hand-edited credential-store file causes the credential helper to
 die, which is a bit too harsh to the users.  Demote the error
 behaviour to only warn and keep using well-formed lines instead.

 Expecting a final reroll.
 It seems that we decided to do absolute minimum to avoid doing any
 unnecessary harm.  Ignore malformed lines but without warning.
 cf. <20200501135757.GF33264@Carlos-MBP>


* dl/switch-c-option-in-error-message (2020-04-30) 1 commit
 - switch: fix errors and comments related to -c and -C

 In error messages that "git switch" mentions its option to create a
 new branch, "-b/-B" options were shown, where "-c/-C" options
 should be, which has been corrected.

 Will merge to 'next'.


* es/bugreport-with-hooks (2020-04-30) 2 commits
 - SQUASH???
 - bugreport: collect list of populated hooks

 "git bugreport" learned to report enabled hooks in the repository.

 Needs polishing the tests.


* tb/shallow-cleanup (2020-04-30) 4 commits
 - shallow: use struct 'shallow_lock' for additional safety
 - shallow.h: document '{commit,rollback}_shallow_file'
 - shallow: extract a header file for shallow-related functions
 - commit: make 'commit_graft_pos' non-static

 Code cleanup.

 Will merge to 'next'.


* bc/wildcard-credential (2020-04-27) 1 commit
  (merged to 'next' on 2020-04-28 at 1a0d6b91dc)
 + credential: fix matching URLs with multiple levels in path

 Update the parser used for credential.<URL>.<variable>
 configuration, to handle <URL>s with '/' in them correctly.

 Will merge to 'master'.


* ah/userdiff-markdown (2020-04-30) 1 commit
 - userdiff: support Markdown

 The userdiff patterns for Markdown documents have been added.

 Will merge to 'next'.


* mr/bisect-in-c-2 (2020-04-23) 12 commits
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: finish porting `bisect_start()` to C
 - bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
 - bisect--helper: reimplement `bisect_autostart` shell function in C
 - bisect--helper: introduce new `write_in_file()` function
 - bisect--helper: use '-res' in 'cmd_bisect__helper' return
 - bisect--helper: fix `cmd_*()` function switch default return

 Rewrite of the remainder of "git bisect" script in C continues.

 Any volunteer to review this?


* js/partial-urlmatch-2.17 (2020-04-29) 3 commits
  (merged to 'next' on 2020-05-01 at 7c69571f89)
 + credential: handle `credential.<partial-URL>.<key>` again
 + credential: optionally allow partial URLs in credential_from_url_gently()
 + credential: fix grammar
 (this branch is used by js/partial-urlmatch.)

 Recent updates broke parsing of "credential.<url>.<key>" where
 <url> is not a full URL (e.g. [credential "https://"] helper = ...)
 stopped working, which has been corrected.

 Will merge to 'master'.


* js/partial-urlmatch (2020-04-29) 3 commits
  (merged to 'next' on 2020-05-01 at e7017fcfd1)
 + Sync with js/partial-urlmatch-2.17
 + credential: handle `credential.<partial-URL>.<key>` again
 + credential: optionally allow partial URLs in credential_from_url_gently()
 (this branch uses js/partial-urlmatch-2.17.)

 The same as js/partial-urlmatch-2.17, built on more recent codebase
 to avoid unnecessary merge conflicts.

 Will merge to 'master'.


* jk/complete-git-switch (2020-04-28) 11 commits
 - completion: complete remote branches for git switch --track
 - completion: recognize -c/-C when completing for git switch
 - completion: fix completion for git switch with no options
 - completion: perform DWIM logic directly in __git_complete_refs
 - completion: extract function __git_dwim_remote_heads
 - completion: rename --track option of __git_complete_refs
 - completion: stop completing refs for git switch --orphan
 - completion: add tests showing lack of support for git switch -c/-C
 - completion: add test highlighting subpar git switch --track completion
 - completion: add test showing subpar git switch completion
 - completion: add some simple test cases for git switch completion

 The command line completion (in contrib/) learned to complete
 options that the "git switch" command takes.


* tb/commit-graph-perm-bits (2020-04-29) 5 commits
  (merged to 'next' on 2020-04-29 at 66a87c1fbc)
 + commit-graph.c: make 'commit-graph-chain's read-only
 + commit-graph.c: ensure graph layers respect core.sharedRepository
 + commit-graph.c: write non-split graphs as read-only
 + lockfile.c: introduce 'hold_lock_file_for_update_mode'
 + tempfile.c: introduce 'create_tempfile_mode'

 Some of the files commit-graph subsystem keeps on disk did not
 correctly honor the core.sharedRepository settings and some were
 left read-write.

 Will merge to 'master'.


* dl/opt-callback-cleanup (2020-04-28) 1 commit
  (merged to 'next' on 2020-04-28 at aa773e183a)
 + Use OPT_CALLBACK and OPT_CALLBACK_F

 Code cleanup.

 Will merge to 'master'.


* dl/push-recurse-submodules-fix (2020-04-28) 1 commit
  (merged to 'next' on 2020-04-28 at c2cd20ef9e)
 + push: unset PARSE_OPT_OPTARG for --recurse-submodules

 Code cleanup.

 Will merge to 'master'.


* jk/test-fail-prereqs-fix (2020-04-28) 1 commit
  (merged to 'next' on 2020-04-28 at 75787711c0)
 + t0000: disable GIT_TEST_FAIL_PREREQS in sub-tests

 Test update.

 Will merge to 'master'.


* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Expecting a reroll.
 cf. <20200416152145.wp2zeibxmuyas6y6@feanor>


* pw/rebase-i-more-options (2020-04-29) 5 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_free
 - rebase -i: support --committer-date-is-author-date
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.


* dd/iso-8601-updates (2020-04-24) 4 commits
  (merged to 'next' on 2020-04-28 at 18fba39171)
 + date.c: allow compact version of ISO-8601 datetime
 + date.c: skip fractional second part of ISO-8601
 + date.c: validate and set time in a helper function
 + date.c: s/is_date/set_date/

 The approxidate parser learns to parse seconds with fraction.

 Will merge to 'master'.


* jx/proc-receive-hook (2020-04-15) 8 commits
 - SQUASH???
 - doc: add documentation for the proc-receive hook
 - receive-pack: new config receive.procReceiveRefs
 - refs.c: refactor to reuse ref_is_hidden()
 - send-pack: extension for client-side status report
 - receive-pack: add new proc-receive hook
 - connect: export parse_feature_value()
 - transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.


* hn/reftable (2020-04-27) 12 commits
 - t: use update-ref and show-ref to reading/writing refs
 - Add some reftable testing infrastructure
 - Reftable support for git-core
 - Add reftable library
 - reftable: clarify how empty tables should be written
 - reftable: define version 2 of the spec to accomodate SHA256
 - reftable: file format documentation
 - Add .gitattributes for the reftable/ directory
 - refs: document how ref_iterator_advance_fn should handle symrefs
 - create .git/refs in files-backend.c
 - Iterate over the "refs/" namespace in for_each_[raw]ref
 - refs.h: clarify reflog iteration order

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

 At v10.  VCbuild may have to be updated to deal with the new lib.
 cf. https://github.com/git/git/runs/624424705?check_suite_focus=true
 cf. <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>

--------------------------------------------------
[Discarded]

* jc/credential-store-file-format-doc (2020-04-27) 1 commit
 . credential-store: document the file format a bit more

 Now has become a part of Carlo's credential-store fix patches.
