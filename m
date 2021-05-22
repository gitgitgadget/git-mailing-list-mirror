Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C97CC2B9FB
	for <git@archiver.kernel.org>; Sat, 22 May 2021 14:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4296128A
	for <git@archiver.kernel.org>; Sat, 22 May 2021 14:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhEVOXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 10:23:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60949 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhEVOXY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 10:23:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B094B6BC3;
        Sat, 22 May 2021 10:21:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=T
        v7oHxN7CUPQ28PrJMJ9bzyyzqM/iafWqYGgB4o+71g=; b=SgMTp6s+8r6RtrLIF
        mU4f7HLgg3VtCny7C+e4eY37gwWRpgd3vzqH10TdXFBk2nTzHXKvTopm9kvV7gMn
        Or+NtIqFlXPf/ZSoPvb2DvbOYq1xf173I7Uild3oBTJvGb8hOPkj7BzOLNWDLWws
        goqPjymUwVgROBy9gR1jnOfCRg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01EEBB6BC0;
        Sat, 22 May 2021 10:21:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73B3EB6BBF;
        Sat, 22 May 2021 10:21:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2021, #05; Sat, 22)
X-master-at: de88ac70f3a801262eb3aa087e5d9a712be0a54a
X-next-at: 3cb6fa43cd00a825d13bf67004b2df69d9efb73b
Date:   Sat, 22 May 2021 23:21:57 +0900
Message-ID: <xmqqeedyq262.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1156206C-BB09-11EB-8C5D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[sorry for almost-daily updates, but I wanted to make sure that I am
 not missing any fixes for regressions during this cycle]

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The Git 2.32-rc1 has been tagged for testing.  From now on, please
allocate some bandwidth for finding and fixing regressions in what
is already in the release candidates, rather than new stuff.  I may
still pick up new topics that are not yet anywhere in my tree, and
updates to topics that are queued in 'seen', but fixes to what
happened between v2.31.0..master get higher priority than all the
rest.

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

* dl/stash-show-untracked-fixup (2021-05-22) 1 commit
  (merged to 'next' on 2021-05-22 at bbe06ef834)
 + stash show: use stash.showIncludeUntracked even when diff options given

 Another brown paper bag inconsistency fix for a new feature
 introduced during this cycle.


* jh/simple-ipc-sans-pthread (2021-05-21) 1 commit
  (merged to 'next' on 2021-05-22 at 4332dd2012)
 + simple-ipc: correct ifdefs when NO_PTHREADS is defined

 The "simple-ipc" did not compile without pthreads support, but the
 build procedure was not properly account for it.


* wm/rev-parse-path-format-wo-arg (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-20 at 5d3c8ba2bf)
 + rev-parse: fix segfault with missing --path-format argument
 (this branch is used by wm/rev-parse-die-i18n.)

 The "rev-parse" command did not diagnose the lack of argument to
 "--path-format" option, which was introduced in v2.31 era, which
 has been corrected.

--------------------------------------------------
[New Topics]

* dd/honor-users-tar-in-tests (2021-05-22) 1 commit
 - t: use configured TAR instead of tar

 Test portability fix.

--------------------------------------------------
[Stalled]

* ag/merge-strategies-in-c (2021-03-17) 15 commits
 - sequencer: use the "octopus" merge strategy without forking
 - sequencer: use the "resolve" strategy without forking
 - merge: use the "octopus" strategy without forking
 - merge: use the "resolve" strategy without forking
 - merge-octopus: rewrite in C
 - merge-recursive: move better_branch_name() to merge.c
 - merge-resolve: rewrite in C
 - merge-one-file: rewrite in C
 - update-index: move add_cacheinfo() to read-cache.c
 - merge-index: add a new way to invoke `git-merge-one-file'
 - merge-index: drop the index
 - merge-index: libify merge_one_path() and merge_all()
 - t6060: add tests for removed files
 - t6060: modify multiple files to expose a possible issue with merge-index
 - t6407: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.

 Expecting a (hopefully final) reroll.
 cf. <nycvar.QRO.7.76.6.2103241142220.50@tvgsbejvaqbjf.bet>


* tv/p4-fallback-encoding (2021-04-30) 1 commit
 - git-p4: git-p4.fallbackEncoding to specify non UTF-8 charset

 "git p4" learns the fallbackEncoding configuration variable to
 safely accept changeset descriptions that aren't written in UTF-8.


* ds/status-with-sparse-index (2021-05-22) 14 commits
 - fsmonitor: integrate with sparse index
 - wt-status: expand added sparse directory entries
 - status: use sparse-index throughout
 - status: skip sparse-checkout percentage with sparse-index
 - dir.c: accept a directory as part of cone-mode patterns
 - unpack-trees: be careful around sparse directory entries
 - unpack-trees: compare sparse directories correctly
 - unpack-trees: preserve cache_bottom
 - t1092: add tests for status/add and sparse files
 - t1092: expand repository data shape
 - sparse-index: include EXTENDED flag when expanding
 - sparse-index: skip indexes with unmerged entries
 - Merge branch 'mt/add-rm-in-sparse-checkout' into ds/status-with-sparse-index
 - Merge branch 'ds/sparse-index-protections' into ds/status-with-sparse-index

 "git status" codepath learned to work with sparsely populated index
 without hydrating it fully.


* jh/rfc-builtin-fsmonitor (2021-05-04) 24 commits
 - fsmonitor: only enable it in non-bare repositories
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - p7519: add fsmonitor--daemon
 - t7527: create test for fsmonitor--daemon
 - fsmonitor: force update index when fsmonitor token advances
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon:: introduce client delay for testing
 - fsmonitor--daemon: periodically truncate list of modified files
 - fsmonitor--daemon: implement handle_client callback
 - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
 - fsmonitor-fs-listen-macos: add macos header files for FSEvent
 - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
 - fsmonitor--daemon: create token-based changed path cache
 - fsmonitor--daemon: define token-ids
 - fsmonitor--daemon: add pathname classification
 - fsmonitor--daemon: implement daemon command options
 - fsmonitor-fs-listen-macos: stub in backend for MacOS
 - fsmonitor-fs-listen-win32: stub in backend for Windows
 - fsmonitor--daemon: implement client command options
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
 - config: FSMonitor is repository-specific
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor

 An attempt to write and ship with a watchman equivalent tailored
 for our use.


* ab/describe-tests-fix (2021-05-11) 5 commits
 - describe tests: support -C in "check_describe"
 - describe tests: fix nested "test_expect_success" call
 - describe tests: don't rely on err.actual from "check_describe"
 - describe tests: refactor away from glob matching
 - describe tests: improve test for --work-tree & --dirty
 (this branch uses ab/test-lib-updates.)

 Various updates to tests around "git describe"

 Waiting for the base topic to solidify.


* ab/pickaxe-pcre2 (2021-05-11) 22 commits
 - xdiff-interface: replace discard_hunk_line() with a flag
 - xdiff users: use designated initializers for out_line
 - pickaxe -G: don't special-case create/delete
 - pickaxe -G: terminate early on matching lines
 - xdiff-interface: allow early return from xdiff_emit_line_fn
 - xdiff-interface: prepare for allowing early return
 - pickaxe -S: slightly optimize contains()
 - pickaxe: rename variables in has_changes() for brevity
 - pickaxe -S: support content with NULs under --pickaxe-regex
 - pickaxe: assert that we must have a needle under -G or -S
 - pickaxe: refactor function selection in diffcore-pickaxe()
 - perf: add performance test for pickaxe
 - pickaxe/style: consolidate declarations and assignments
 - diff.h: move pickaxe fields together again
 - pickaxe: die when --find-object and --pickaxe-all are combined
 - pickaxe: die when -G and --pickaxe-regex are combined
 - pickaxe tests: add missing test for --no-pickaxe-regex being an error
 - pickaxe tests: test for -G, -S and --find-object incompatibility
 - pickaxe tests: add test for "log -S" not being a regex
 - pickaxe tests: add test for diffgrep_consume() internals
 - pickaxe tests: refactor to use test_commit --append --printf
 - grep/pcre2 tests: reword comments referring to kwset
 (this branch uses ab/test-lib-updates.)

 Rewrite the backend for "diff -G/-S" to use pcre2 engine when
 available.

 Waiting for the base topic to solidify.


* es/config-hooks (2021-03-10) 36 commits
 . run-command: stop thinking about hooks
 . git-send-email: use 'git hook run' for 'sendemail-validate'
 . bugreport: use hook_exists instead of find_hook
 . receive-pack: convert receive hooks to hook.h
 . post-update: use hook.h library
 . proc-receive: acquire hook list from hook.h
 . receive-pack: convert 'update' hook to hook.h
 . reference-transaction: look for hooks in config
 . transport: convert pre-push hook to use config
 . hook: convert 'post-rewrite' hook to config
 . hooks: convert 'post-checkout' hook to hook library
 . git-p4: use 'git hook' to run hooks
 . receive-pack: convert push-to-checkout hook to hook.h
 . read-cache: convert post-index-change hook to use config
 . rebase: teach pre-rebase to use hook.h
 . gc: use hook library for pre-auto-gc hook
 . merge: use config-based hooks for post-merge hook
 . am: convert applypatch hooks to use config
 . commit: use config-based hooks
 . hooks: allow callers to capture output
 . run-command: allow capturing of collated output
 . hook: provide stdin by string_list or callback
 . run-command: add stdin callback for parallelization
 . hook: allow specifying working directory for hooks
 . hook: allow parallel hook execution
 . run-command: allow stdin for run_processes_parallel
 . hook: support passing stdin to hooks
 . hook: introduce hook_exists()
 . hook: add 'run' subcommand
 . parse-options: parse into strvec
 . hook: implement hookcmd.<name>.skip
 . hook: teach hook.runHookDir
 . hook: include hookdir hook in list
 . hook: add list command
 . hook: scaffolding for git-hook subcommand
 . doc: propose hooks managed by the config

 The "hooks defined in config" topic.

--------------------------------------------------
[Cooking]

* ah/fetch-reject-warning-grammofix (2021-05-20) 1 commit
 - fetch: improve grammar of "shallow roots" message

 Message update.


* ah/setup-extensions-message-i18n-fix (2021-05-20) 1 commit
 - setup: split "extensions found" messages into singular and plural

 Message update.


* jk/clone-clean-upon-transport-error (2021-05-19) 1 commit
  (merged to 'next' on 2021-05-22 at 464b1f187c)
 + clone: clean up directory after transport_fetch_refs() failure

 Recent "git clone" left a temporary directory behind when the
 transport layer returned an failure.

 Will cook in 'next'.


* jk/doc-color-pager (2021-05-20) 1 commit
 - doc: explain the use of color.pager

 The documentation for "color.pager" configuration variable has been
 updated.

 Will merge to 'next'.


* jk/fetch-pack-v2-half-close-early (2021-05-20) 1 commit
 - fetch-pack: signal v2 server that we are done making requests

 "git fetch" over protocol v2 left its side of the socket open after
 it finished speaking, which unnecessarily wasted the resource on
 the other side.

 Will merge to 'next'.


* ry/clarify-fast-forward-in-glossary (2021-05-19) 1 commit
  (merged to 'next' on 2021-05-22 at 97a851d59f)
 + docs: improve fast-forward in glossary content

 The description of "fast-forward" in the glossary has been updated.

 Will cook in 'next'.


* wm/rev-parse-die-i18n (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-22 at 65c256d92b)
 + rev-parse: mark die() messages for translation

 Quite a many die() messages in rev-parse haven't been marked for
 translation.

 Will cook in 'next'.


* es/trace2-log-parent-process-name (2021-05-21) 1 commit
 - tr2: log parent process name


* ps/rev-list-object-type-filter (2021-05-21) 1 commit
 - help: fix small typo in error message


* ab/send-email-optim (2021-05-21) 10 commits
 - perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
 - send-email: move trivial config handling to Perl
 - perl: lazily load some common Git.pm setup code
 - send-email: lazily load modules for a big speedup
 - send-email: get rid of indirect object syntax
 - send-email: use function syntax instead of barewords
 - send-email: lazily shell out to "git var"
 - send-email: lazily load config for a big speedup
 - send-email: refactor sendemail.smtpencryption config parsing
 - send-email: remove non-working support for "sendemail.smtpssl"

 "git send-email" optimization.


* ab/update-submitting-patches (2021-05-13) 3 commits
 - SubmittingPatches: remove pine-specific hints from MUA hints
 - SubmittingPatches: replace discussion of Travis with GitHub Actions
 - SubmittingPatches: move discussion of Signed-off-by above "send"

 Reorganize and update the SubmitingPatches document.

 Expecting a reroll.
 cf. <xmqq4kf7fueq.fsf@gitster.g>, <20210512235136.GB10785@localhost>


* zh/ref-filter-atom-type (2021-05-14) 2 commits
  (merged to 'next' on 2021-05-16 at 48fd717185)
 + ref-filter: introduce enum atom_type
 + ref-filter: add objectsize to used_atom

 The code to handle the "--format" option in "for-each-ref" and
 friends made too many string comparisons on %(atom)s used in the
 format string, which has been corrected by converting them into
 enum when the format string is parsed.

 Will cook in 'next'.


* tl/fix-packfile-uri-doc (2021-05-14) 1 commit
 - packfile-uri.txt: fix blobPackfileUri description

 Doc fix.

 Will merge to 'next'?
 cf. <xmqq8s4c6fbg.fsf@gitster.g>


* ga/send-email-sendmail-cmd (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-22 at 755df67f0e)
 + git-send-email: add option to specify sendmail command

 "git send-email" learned the "--sendmail-cmd" command line option
 and the "sendemail.sendmailCmd" configuration variable, which is a
 more sensible approach than the current way of repurposing the
 "smtp-server" that is meant to name the server to instead name the
 command to talk to the server.

 Will cook in 'next'.


* ah/doc-describe (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-22 at 8f3925fd41)
 + describe-doc: clarify default length of abbreviation

 Doc update.

 Will cook in 'next'.


* ah/merge-usage-i18n-fix (2021-05-16) 1 commit
  (merged to 'next' on 2021-05-20 at e26a60d624)
 + merge: don't translate literal commands

 i18n update.

 Will cook in 'next'.


* ah/stash-usage-i18n-fix (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-20 at 68e6a46117)
 + stash: don't translate literal commands

 i18n update.

 Will cook in 'next'.


* ah/submodule-helper-module-summary-parseopt (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-20 at 928e72b83f)
 + submodule: use the imperative mood to describe the --files option

 Message update.

 Will cook in 'next'.


* ef/mailinfo-short-name (2021-05-17) 1 commit
  (merged to 'next' on 2021-05-20 at 5ee67911ea)
 + mailinfo: don't discard names under 3 characters

 We historically rejected a very short string as an author name
 while accepting a patch e-mail, which has been loosened.

 Will cook in 'next'.


* ds/write-index-with-hashfile-api (2021-05-19) 4 commits
 - read-cache: delete unused hashing methods
 - read-cache: use hashfile instead of git_hash_ctx
 - csum-file.h: increase hashfile buffer size
 - hashfile: use write_in_full()

 Use the hashfile API in the codepath that writes the index file to
 reduce code duplication.

 Will merge to 'next'.


* jc/clarify-revision-range (2021-05-18) 1 commit
  (merged to 'next' on 2021-05-22 at 83a689d8ad)
 + revisions(7): clarify that most commands take a single revision range

 Doc update.

 Will cook in 'next'.


* jn/size-t-casted-to-off-t-fix (2021-05-19) 1 commit
  (merged to 'next' on 2021-05-20 at bbde7e6616)
 + xsize_t: avoid implementation defined behavior when len < 0

 Rewrite code that triggers undefined behaiour warning.

 Will cook in 'next'.


* mt/parallel-checkout-with-padded-oidcpy (2021-05-18) 1 commit
  (merged to 'next' on 2021-05-20 at 016cab0381)
 + parallel-checkout: send the new object_id algo field to the workers

 The parallel checkout codepath did not initialize object ID field
 used to talk to the worker processes in a futureproof way.

 Will cook in 'next'.


* so/log-m-implies-p (2021-05-21) 10 commits
 - diff-merges: let "-m" imply "-p"
 - diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
 - stash list: stop passing "-m" to "git log"
 - git-svn: stop passing "-m" to "git rev-list"
 - diff-merges: move specific diff-index "-m" handling to diff-index
 - t4013: test "git diff-index -m"
 - t4013: test "git diff-tree -m"
 - t4013: test "git log -m --stat"
 - t4013: test "git log -m --raw"
 - t4013: test that "-m" alone has no effect in "git log"

 The "-m" option in "git log -m" that does not specify which format,
 if any, of diff is desired did not have any visible effect; it now
 implies some form of diff (by default "--patch") is produced.

 Will merge to 'next'.


* bc/doc-asciidoctor-to-man-wo-xmlto (2021-05-14) 2 commits
 - doc: remove GNU_ROFF option
 - doc: add an option to have Asciidoctor build man pages directly

 An option to render the manual pages via AsciiDoctor bypassing
 xmlto has been introduced.


* ab/trace2-squelch-gcc-warning (2021-05-21) 1 commit
 - trace2: refactor to avoid gcc warning under -O3

 Workaround compiler warnings.

 Will merge to 'next'.


* hn/refs-errno-cleanup (2021-04-30) 8 commits
 - refs: explicitly propagate errno from refs_read_raw_ref
 - refs: stop setting EINVAL and ELOOP in symref resolution
 - refs: clear errno return in refs_resolve_ref_unsafe()
 - refs: add failure_errno to refs_read_raw_ref() signature
 - refs: make errno output explicit for refs_resolve_ref_unsafe
 - refs: make errno output explicit for read_raw_ref_fn
 - refs/files-backend: stop setting errno from lock_ref_oid_basic
 - refs: remove EINVAL specification from the errno sideband in read_raw_ref_fn

 Futz with the way 'errno' is relied on in the refs API to carry the
 failure modes up the callchain.

 Waiting for reviews.


* en/ort-perf-batch-11 (2021-05-20) 13 commits
 - merge-ort, diffcore-rename: employ cached renames when possible
 - merge-ort: handle interactions of caching and rename/rename(1to1) cases
 - merge-ort: add helper functions for using cached renames
 - merge-ort: preserve cached renames for the appropriate side
 - merge-ort: avoid accidental API mis-use
 - merge-ort: add code to check for whether cached renames can be reused
 - merge-ort: populate caches of rename detection results
 - merge-ort: add data structures for in-memory caching of rename detection
 - t6429: testcases for remembering renames
 - fast-rebase: write conflict state to working tree, index, and HEAD
 - fast-rebase: change assert() to BUG()
 - Documentation/technical: describe remembering renames optimization
 - t6423: rename file within directory that other side renamed

 Optimize out repeated rename detection in a sequence of mergy
 operations.

 Will merge to 'next'.


* ls/fast-export-signed (2021-05-03) 5 commits
 - fast-export, fast-import: add support for signed-commits
 - fast-export: do not modify memory from get_commit_buffer
 - git-fast-export.txt: clarify why 'verbatim' may not be a good idea
 - fast-export: rename --signed-tags='warn' to 'warn-verbatim'
 - git-fast-import.txt: add missing LF in the BNF

 "git fast-export" offers a way to control how signed tags are
 handled; the mechanism has been extended to allow specifying how
 signed commits are handled as well.

 Expecting a reroll.
 cf. <xmqqa6pca0pv.fsf@gitster.g>, <xmqq1rao9zev.fsf@gitster.g>


* hn/prep-tests-for-reftable (2021-04-28) 21 commits
 - t1415: set REFFILES for test specific to storage format
 - t4202: mark bogus head hash test with REFFILES
 - t7003: check reflog existence only for REFFILES
 - t7900: mark pack-refs tests as REFFILES
 - t1404: mark tests that muck with .git directly as REFFILES.
 - t2017: mark --orphan/logAllRefUpdates=false test as REFFILES
 - t1414: mark corruption test with REFFILES
 - t1407: require REFFILES for for_each_reflog test
 - test-lib: provide test prereq REFFILES
 - t5304: use "reflog expire --all" to clear the reflog
 - t5304: restyle: trim empty lines, drop ':' before >
 - t7003: use rev-parse rather than FS inspection
 - t5000: inspect HEAD using git-rev-parse
 - t5000: reformat indentation to the latest fashion
 - t1301: fix typo in error message
 - t1413: use tar to save and restore entire .git directory
 - t1401-symbolic-ref: avoid direct filesystem access
 - t5601: read HEAD using rev-parse
 - t9300: check ref existence using test-helper rather than a file system check
 - t/helper/ref-store: initialize oid in resolve-ref
 - t4202: split testcase for invalid HEAD symref and HEAD hash

 Preliminary clean-up of tests before the main reftable changes
 hits the codebase.

 Waiting for reviews.


* tb/multi-pack-bitmaps (2021-04-10) 23 commits
 - p5326: perf tests for MIDX bitmaps
 - p5310: extract full and partial bitmap tests
 - midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 - t7700: update to work with MIDX bitmap test knob
 - t5319: don't write MIDX bitmaps in t5319
 - t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 - t5326: test multi-pack bitmap behavior
 - t/helper/test-read-midx.c: add --checksum mode
 - t5310: move some tests to lib-bitmap.sh
 - pack-bitmap: write multi-pack bitmaps
 - pack-bitmap: read multi-pack bitmaps
 - pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
 - pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
 - pack-bitmap.c: introduce 'bitmap_num_objects()'
 - midx: respect 'core.multiPackIndex' when writing
 - midx: clear auxiliary .rev after replacing the MIDX
 - midx: make a number of functions non-static
 - Documentation: describe MIDX-based bitmaps
 - Documentation: build 'technical/bitmap-format' by default
 - pack-bitmap-write.c: free existing bitmaps
 - pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
 - pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
 - Merge branch 'tb/pack-preferred-tips-to-give-bitmap' into tb/multi-pack-bitmaps

 The reachability bitmap file used to be generated only for a single
 pack, but now we've learned to generate bitmaps for history that
 span across multiple packfiles.

 Waiting for reviews.
 cf. <cover.1617991824.git.me@ttaylorr.com>


* ab/test-lib-updates (2021-05-11) 11 commits
 - test-lib: split up and deprecate test_create_repo()
 - test-lib: do not show advice about init.defaultBranch under --verbose
 - test-lib: reformat argument list in test_create_repo()
 - submodule tests: use symbolic-ref --short to discover branch name
 - test-lib functions: add --printf option to test_commit
 - describe tests: convert setup to use test_commit
 - test-lib functions: add an --annotated option to "test_commit"
 - test-lib-functions: document test_commit --no-tag
 - test-lib-functions: reword "test_commit --append" docs
 - test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
 - test-lib: bring $remove_trash out of retirement
 (this branch is used by ab/describe-tests-fix and ab/pickaxe-pcre2.)

 Test clean-up.


* ao/p4-avoid-decoding (2021-04-12) 2 commits
 - git-p4: do not decode data from perforce by default
 - git-p4: avoid decoding more data from perforce

 "git p4" in Python-2 days used to accept a lot more kinds of data
 from Perforce server as uninterrupted byte sequence, but after
 switching to Python-3, too many things are expected to be in UTF-8,
 which broke traditional use cases.

 Waiting for reviews.


* ma/t0091-bugreport-fix (2021-04-12) 1 commit
 - t0091-bugreport.sh: actually verify some content of report

 Test fix.

 Expecting a reroll.
 cf. <YHYZTLl90rkWWVOr@google.com>, <87a6q22dei.fsf@evledraar.gmail.com>


* mr/bisect-in-c-4 (2021-04-11) 4 commits
 - bisect--helper: retire `--bisect-next-check` subcommand
 - bisect--helper: reimplement `bisect_run` shell function in C
 - bisect--helper: reimplement `bisect_visualize()`shell function in C
 - run-command: make `exists_in_PATH()` non-static

 The codepaths involved in running "git bisect visualize" and "git
 bisect run" has been rewritten in C.

 Expecting a reroll.
 cf. <xmqq35vwh8qk.fsf@gitster.g>, <xmqqy2doftrj.fsf@gitster.g>,
 <CAP8UFD3X24F3qgefHpi00PM-KUk+vcqxwy2Dbngbyj7ciavCVQ@mail.gmail.com>
 May want to boost the test coverage.


* hn/reftable (2021-05-20) 28 commits
 - t1404: annotate test cases with REFFILES
 - t1401,t2011: parameterize HEAD.lock for REFTABLE
 - t1301: document what needs to be done for REFTABLE
 - Add "test-tool dump-reftable" command.
 - git-prompt: prepare for reftable refs backend
 - Reftable support for git-core
 - reftable: add dump utility
 - reftable: implement stack, a mutable database of reftable files.
 - reftable: implement refname validation
 - reftable: add merged table view
 - reftable: add a heap-based priority queue for reftable records
 - reftable: reftable file level tests
 - reftable: read reftable files
 - reftable: generic interface to tables
 - reftable: write reftable files
 - reftable: a generic binary tree implementation
 - reftable: reading/writing blocks
 - Provide zlib's uncompress2 from compat/zlib-compat.c
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: add blocksource, an abstraction for random access reads
 - reftable: utility functions
 - reftable: add error related functionality
 - reftable: add LICENSE
 - init-db: set the_repository->hash_algo early on
 - hash.h: provide constants for the hash IDs
 - refs/debug: trace into reflog expiry too
 - refs: document reflog_expire_fn's flag argument
 - refs: make explicit that ref_iterator_peel returns boolean

 The "reftable" backend for the refs API.

 Waiting for reviews.


* ab/fsck-unexpected-type (2021-05-21) 17 commits
 - fsck: report invalid object type-path combinations
 - fsck: report invalid types recorded in objects
 - object-store.h: move read_loose_object() below 'struct object_info'
 - fsck: don't hard die on invalid object types
 - object-file.c: return -1, not "status" from unpack_loose_header()
 - object-file.c: return -2 on "header too long" in unpack_loose_header()
 - object-file.c: stop dying in parse_loose_header()
 - object-file.c: add missing braces to loose_object_info()
 - object-file.c: make parse_loose_header_extended() public
 - cache.h: move object functions to object-store.h
 - cat-file tests: test for current --allow-unknown-type behavior
 - cat-file tests: add corrupt loose object test
 - rev-list tests: test for behavior with invalid object types
 - cat-file tests: test that --allow-unknown-type isn't on by default
 - cat-file tests: test for missing object with -t and -s
 - fsck tests: add test for fsck-ing an unknown type
 - fsck tests: refactor one test to use a sub-repo

 "git fsck" has been taught to report mismatch between expected and
 actual types of an object better.
