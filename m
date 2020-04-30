Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB57C4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 23:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1869520873
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 23:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nl4NwBhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgD3XEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 19:04:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52823 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgD3XEh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 19:04:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80449BBD69;
        Thu, 30 Apr 2020 19:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=O
        1lI3DYvTtjj+aglwJ8AMNHa9l0=; b=nl4NwBhuBsohLMCwgLOqM67CskGFDBJGD
        N9l/cJxGZo/xcaHT0xZNJ7MjtIiaq5FX9f1j1Fl8ZYNH+5qccRFCpPre+zR1tiN6
        Wx7x536+M15auBR1GZNf/9HJjSHnFqxlVjGTZNYknzmgLJoVn1ixUeiLpN1JEKaL
        TjBJhJM8fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=KMV
        grDNaAQuZb31b9vQLQIBeYwcdFiAMT8+RQrZmbQyE8JUEr7sLpE3IKbvaVhokltb
        fNSXQQZilbpHmjKEjgoxzFPJVlLw/pciAvQJc7h6OxD0bXBftnTZgrKE3NiSt57S
        fCBWYy/ayEi/o6vLnoKltOymnJT2qNlrN9A88RG0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78488BBD68;
        Thu, 30 Apr 2020 19:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A59EDBBD67;
        Thu, 30 Apr 2020 19:04:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2020, #04; Thu, 30)
X-master-at: d61d20c9b413225793f8a0b491bbbec61c184e26
X-next-at: e9eca65c58678cd6523f72e8b97b77f978a3477e
Date:   Thu, 30 Apr 2020 16:04:25 -0700
Message-ID: <xmqqmu6spocm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F075436C-8B36-11EA-9810-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Quite a few topics have been merged to 'next' and also to 'master'.
There are a few more important topics that need to be merged down to
'master' before we're comfortable cutting the next maintenance
update but hopefully we'd get there during this week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* dd/ci-musl-libc (2020-04-06) 6 commits
 + travis: build and test on Linux with musl libc and busybox
 + ci/linux32: libify install-dependencies step
 + ci: refactor docker runner script
 + ci/linux32: parameterise command to switch arch
 + ci/lib-docker: preserve required environment variables
 + ci: make MAKEFLAGS available inside the Docker container in the Linux32 job
 (this branch is used by dd/ci-swap-azure-pipelines-with-github-actions.)

 A new CI job to build and run test suite on linux with musl libc
 has been added.


* dd/ci-swap-azure-pipelines-with-github-actions (2020-04-10) 14 commits
  (merged to 'next' on 2020-04-20 at 40d0486c23)
 + ci: let GitHub Actions upload failed tests' directories
 + ci: add a problem matcher for GitHub Actions
 + tests: when run in Bash, annotate test failures with file name/line number
 + ci: retire the Azure Pipelines definition
 + README: add a build badge for the GitHub Actions runs
 + ci: configure GitHub Actions for CI/PR
 + ci: run gem with sudo to install asciidoctor
 + ci: explicit install all required packages
 + ci: fix the `jobname` of the `GETTEXT_POISON` job
 + ci/lib: set TERM environment variable if not exist
 + ci/lib: allow running in GitHub Actions
 + ci/lib: if CI type is unknown, show the environment variables
 + Merge branch 'dd/ci-musl-libc' into HEAD
 + Merge branch 'dd/test-with-busybox' into HEAD
 (this branch uses dd/ci-musl-libc.)

 Update the CI configuration to use GitHub Actions, retiring the one
 based on Azure Pipelines.

 Will merge to 'master', together with dd/ci-musl-libc.


* dl/merge-autostash (2020-04-10) 22 commits
  (merged to 'next' on 2020-04-22 at 98b991e8f5)
 + pull: pass --autostash to merge
 + t5520: make test_pull_autostash() accept expect_parent_num
 + merge: teach --autostash option
 + sequencer: implement apply_autostash_oid()
 + sequencer: implement save_autostash()
 + sequencer: unlink autostash in apply_autostash()
 + sequencer: extract perform_autostash() from rebase
 + rebase: generify create_autostash()
 + rebase: extract create_autostash()
 + reset: extract reset_head() from rebase
 + rebase: generify reset_head()
 + rebase: use apply_autostash() from sequencer.c
 + sequencer: rename stash_sha1 to stash_oid
 + sequencer: make apply_autostash() accept a path
 + rebase: use read_oneliner()
 + sequencer: make read_oneliner() extern
 + sequencer: configurably warn on non-existent files
 + sequencer: make read_oneliner() accept flags
 + sequencer: make file exists check more efficient
 + sequencer: stop leaking buf
 + t7600: use test_write_lines()
 + Makefile: ASCII-sort += lists
 (this branch is used by dl/merge-autostash-rebase-quit-fix.)

 "git merge" learns the "--autostash" option.

 Will merge to 'master' together with the "rebase --quit" fix.


* dl/merge-autostash-rebase-quit-fix (2020-04-28) 1 commit
  (merged to 'next' on 2020-04-28 at 24dcf3edc1)
 + rebase: save autostash entry into stash reflog on --quit
 (this branch uses dl/merge-autostash.)

 The stash entry created by "git rebase --autosquash" to keep the
 initial dirty state were discarded by mistake upon "git rebase
 --quit", which has been corrected.


* en/fill-directory-exponential (2020-04-01) 12 commits
  (merged to 'next' on 2020-04-22 at e2577e3dc9)
 + completion: fix 'git add' on paths under an untracked directory
 + Fix error-prone fill_directory() API; make it only return matches
 + dir: replace double pathspec matching with single in treat_directory()
 + dir: include DIR_KEEP_UNTRACKED_CONTENTS handling in treat_directory()
 + dir: replace exponential algorithm with a linear one
 + dir: refactor treat_directory to clarify control flow
 + dir: fix confusion based on variable tense
 + dir: fix broken comment
 + dir: consolidate treat_path() and treat_one_path()
 + dir: fix simple typo in comment
 + t3000: add more testcases testing a variety of ls-files issues
 + t7063: more thorough status checking

 The directory traversal code had redundant recursive calls which
 made its performance characteristics exponential with respect to
 the depth of the tree, which was corrected.


* en/sparse-checkout (2020-03-27) 18 commits
  (merged to 'next' on 2020-04-15 at 3e295e445d)
 + sparse-checkout: provide a new reapply subcommand
 + unpack-trees: failure to set SKIP_WORKTREE bits always just a warning
 + unpack-trees: provide warnings on sparse updates for unmerged paths too
 + unpack-trees: make sparse path messages sound like warnings
 + unpack-trees: split display_error_msgs() into two
 + unpack-trees: rename ERROR_* fields meant for warnings to WARNING_*
 + unpack-trees: move ERROR_WOULD_LOSE_SUBMODULE earlier
 + sparse-checkout: use improved unpack_trees porcelain messages
 + sparse-checkout: use new update_sparsity() function
 + unpack-trees: add a new update_sparsity() function
 + unpack-trees: pull sparse-checkout pattern reading into a new function
 + unpack-trees: do not mark a dirty path with SKIP_WORKTREE
 + unpack-trees: allow check_updates() to work on a different index
 + t1091: make some tests a little more defensive against failures
 + unpack-trees: simplify pattern_list freeing
 + unpack-trees: simplify verify_absent_sparse()
 + unpack-trees: remove unused error type
 + unpack-trees: fix minor typo in comment

 "sparse-checkout" UI improvements.


* ps/transactional-update-ref-stdin (2020-04-02) 9 commits
  (merged to 'next' on 2020-04-22 at 5c92add109)
 + update-ref: implement interactive transaction handling
 + update-ref: read commands in a line-wise fashion
 + update-ref: move transaction handling into `update_refs_stdin()`
 + update-ref: pass end pointer instead of strbuf
 + update-ref: drop unused argument for `parse_refname`
 + update-ref: organize commands in an array
 + strbuf: provide function to append whole lines
 + git-update-ref.txt: add missing word
 + refs: fix segfault when aborting empty transaction

 "git update-ref --stdin" learned a handful of new verbs to let the
 user control ref update transactions more explicitly, which helps
 as an ingredient to implement two-phase commit-style atomic
 ref-updates across multiple repositories.

--------------------------------------------------
[New Topics]

* cb/credential-store-warn-bogus-lines (2020-04-28) 2 commits
 - credential-store: warn instead of fatal for bogus lines from store
 - credential-store: document the file format a bit more

 With the recent tightening of the code that is used to parse
 various parts of a URL for use in the credential subsystem, a
 hand-edited credential-store file causes the credential helper to
 die, which is a bit too harsh to the users.  Demote the error
 behaviour to only warn and keep using well-formed lines instead.


* dl/switch-c-option-in-error-message (2020-04-30) 1 commit
 - switch: fix errors and comments related to -c and -C

 In error messages that "git switch" mentions its option to create a
 new branch, "-b/-B" options were shown, where "-c/-C" options
 should be, which has been corrected.

 Will merge to 'next'.


* es/bugreport-with-hooks (2020-04-30) 2 commits
 - SQUASH???
 - bugreport: collect list of populated hooks
 (this branch uses es/bugreport.)

 "git bugreport" learned to report enabled hooks in the repository.

 Needs polishing the tests.


* tb/shallow-cleanup (2020-04-30) 4 commits
 - shallow: use struct 'shallow_lock' for additional safety
 - shallow.h: document '{commit,rollback}_shallow_file'
 - shallow: extract a header file for shallow-related functions
 - commit: make 'commit_graft_pos' non-static
 (this branch uses tb/reset-shallow.)

 Code cleanup.

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

* bc/wildcard-credential (2020-04-27) 1 commit
  (merged to 'next' on 2020-04-28 at 1a0d6b91dc)
 + credential: fix matching URLs with multiple levels in path

 Update the parser used for credential.<URL>.<variable>
 configuration, to handle <URL>s with '/' in them correctly.

 Will merge to 'master'.


* dd/mailinfo-with-nul (2020-04-22) 3 commits
  (merged to 'next' on 2020-04-28 at b1d3e40d49)
 + mailinfo: disallow NUL character in mail's header
 + mailinfo.c: avoid strlen on strings that can contains NUL
 + t4254: merge 2 steps of a single test

 Tighten "git mailinfo" to notice and error out when decoded result
 contains NUL in it.

 Will merge to 'master'.


* ah/userdiff-markdown (2020-04-30) 1 commit
 - userdiff: support Markdown

 The userdiff patterns for Markdown documents have been added.

 Will merge to 'next'.


* dd/sparse-fixes (2020-04-27) 4 commits
  (merged to 'next' on 2020-04-28 at d809f916ee)
 + progress.c: silence cgcc suggestion about internal linkage
 + graph.c: limit linkage of internal variable
 + compat/regex: move stdlib.h up in inclusion chain
 + test-parse-pathspec-file.c: s/0/NULL/ for pointer type

 Compilation fix.

 Will merge to 'master'.


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


* tb/reset-shallow (2020-04-24) 2 commits
  (merged to 'next' on 2020-04-28 at 9510639ae8)
 + shallow.c: use '{commit,rollback}_shallow_file'
 + t5537: use test_write_lines and indented heredocs for readability
 (this branch is used by tb/shallow-cleanup.)

 Fix in-core inconsistency after fetching into a shallow repository
 that broke the code to write out commit-graph.

 Will merge to 'master'.


* ds/build-homebrew-gettext-fix (2020-04-27) 1 commit
  (merged to 'next' on 2020-04-28 at 70c6eca470)
 + macOS/brew: let the build find gettext headers/libraries/msgfmt

 Recent update to Homebrew used by macOS folks breaks build by
 moving gettext library and necessary headers.

 Will merge to 'master'.


* tb/commit-graph-fd-exhaustion-fix (2020-04-24) 4 commits
  (merged to 'next' on 2020-04-28 at 6d5fd6bc49)
 + commit-graph: close descriptors after mmap
 + commit-graph.c: gracefully handle file descriptor exhaustion
 + t/test-lib.sh: make ULIMIT_FILE_DESCRIPTORS available to tests
 + commit-graph.c: don't use discarded graph_name in error
 (this branch is tangled with tb/commit-graph-split-strategy.)

 The commit-graph code exhausted file descriptors easily when it
 does not have to.

 Will merge to 'master'.


* ds/multi-pack-index (2020-04-24) 1 commit
  (merged to 'next' on 2020-04-28 at b8f9691cbc)
 + multi-pack-index: close file descriptor after mmap

 The multi-pack-index left mmapped file descriptors open when it
 does not have to.

 Will merge to 'master'.


* js/anonymise-push-url-in-errors (2020-04-28) 1 commit
  (merged to 'next' on 2020-04-28 at 49539cf116)
 + push: anonymize URLs in error messages and warnings

 Error and verbose trace messages from "git push" did not redact
 credential material embedded in URLs.

 Will merge to 'master'.


* js/partial-urlmatch-2.17 (2020-04-29) 3 commits
 - credential: handle `credential.<partial-URL>.<key>` again
 - credential: optionally allow partial URLs in credential_from_url_gently()
 - credential: fix grammar
 (this branch is used by js/partial-urlmatch.)

 Recent updates broke parsing of "credential.<url>.<key>" where
 <url> is not a full URL (e.g. [credential "https://"] helper = ...)
 stopped working, which has been corrected.

 Will merge to 'next'.


* js/partial-urlmatch (2020-04-29) 3 commits
 - Sync with js/partial-urlmatch-2.17
 - credential: handle `credential.<partial-URL>.<key>` again
 - credential: optionally allow partial URLs in credential_from_url_gently()
 (this branch uses js/partial-urlmatch-2.17.)

 The same as js/partial-urlmatch-2.17, built on more recent codebase
 to avoid unnecessary merge conflicts.

 Will merge to 'next'.


* eb/gitweb-more-trailers (2020-04-24) 1 commit
  (merged to 'next' on 2020-04-28 at 7b16ac0810)
 + gitweb: Recognize *-to and Closes/Fixes trailers

 Gitweb updates.

 Will merge to 'master'.


* en/rebase-root-and-fork-point-are-incompatible (2020-04-27) 1 commit
  (merged to 'next' on 2020-04-28 at 8ea4882905)
 + rebase: display an error if --root and --fork-point are both provided

 Incompatible options "--root" and "--fork-point" of "git rebase"
 have been marked and documented as being incompatible.

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


* jt/v2-fetch-nego-fix (2020-04-28) 3 commits
  (merged to 'next' on 2020-04-28 at c6f9ebf2f7)
 + fetch-pack: in protocol v2, reset in_vain upon ACK
 + fetch-pack: in protocol v2, in_vain only after ACK
 + fetch-pack: return enum from process_acks()

 The upload-pack protocol v2 gave up too early before finding a
 common ancestor, resulting in a wasteful fetch from a fork of a
 project.  This has been corrected to match the behaviour of v0
 protocol.

 Will merge to 'master'.


* mt/doc-worktree-ref (2020-04-24) 1 commit
  (merged to 'next' on 2020-04-28 at d96c05cb0a)
 + config doc: fix reference to config.worktree info

 Docfix.

 Will merge to 'master'.


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

 Will merge to 'master'.


* pw/rebase-i-more-options (2020-04-29) 5 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_free
 - rebase -i: support --committer-date-is-author-date
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.


* ds/blame-on-bloom (2020-04-23) 6 commits
  (merged to 'next' on 2020-04-28 at 6152eb2eb3)
 + test-bloom: check that we have expected arguments
 + test-bloom: fix some whitespace issues
 + blame: drop unused parameter from maybe_changed_path
  (merged to 'next' on 2020-04-22 at dc4f24e54b)
 + blame: use changed-path Bloom filters
 + tests: write commit-graph with Bloom filters
 + revision: complicated pathspecs disable filters
 (this branch uses gs/commit-graph-path-filter.)

 "git blame" learns to take advantage of the "changed-paths" Bloom
 filter stored in the commit-graph file.

 Will merge to 'master', together with gs/commit-graph-path-filter.


* dd/iso-8601-updates (2020-04-24) 4 commits
  (merged to 'next' on 2020-04-28 at 18fba39171)
 + date.c: allow compact version of ISO-8601 datetime
 + date.c: skip fractional second part of ISO-8601
 + date.c: validate and set time in a helper function
 + date.c: s/is_date/set_date/

 The approxidate parser learns to parse seconds with fraction.

 Will merge to 'master'.


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

 Will merge to 'master' together with tb/commit-graph-fd-exhaustion-fix


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
 (this branch is used by ds/blame-on-bloom.)

 Introduce an extension to the commit-graph to make it efficient to
 check for the paths that were modified at each commit using Bloom
 filters.

 Will merge to 'master' together with ds/blame-on-bloom.


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


* jk/build-with-right-curl (2020-04-05) 3 commits
  (merged to 'next' on 2020-04-28 at 1718c25b44)
 + Makefile: avoid running curl-config unnecessarily
 + Makefile: use curl-config --cflags
 + Makefile: avoid running curl-config multiple times

 The build procedure did not use the libcurl library and its include
 files correctly for a custom-built installation.

 Will merge to 'master'.
 cf. <20200428033611.GB2369457@coredump.intra.peff.net>


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

 Will merge to 'master'.

--------------------------------------------------
[Discarded]

* jc/credential-store-file-format-doc (2020-04-27) 1 commit
 . credential-store: document the file format a bit more

 Now has become a part of Carlo's credential-store fix patches.
