Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F30C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 23:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F1461250
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 23:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243151AbhIWXXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 19:23:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56621 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbhIWXXg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 19:23:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 910D514C2FA;
        Thu, 23 Sep 2021 19:22:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=i
        l2wrk54SQntZL7vkroWw4z/5ohy0uf4PnbUvq66L98=; b=UA1NflmRociGEjU9Z
        biwYth7IvZOTfxwbEEMoP+pAf3W60x4qtXXXORWK1Z8Rs8ejH7U9Eqwqe39uqJq5
        QQe+7BgylYk7ad4K5bZnBhY9BOLC01IzJhK5DUTQ1EgVPdyrCs8rVAYuT5vaQ3AI
        1MKecoP3WXP3cNB1lDe36H50po=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 885C014C2F9;
        Thu, 23 Sep 2021 19:22:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CDC8214C2F7;
        Thu, 23 Sep 2021 19:22:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2021, #07; Thu, 23)
X-master-at: ddb1055343948e0d0bc81f8d20245f1ada6430a0
X-next-at: 4c38ced6901a8523cea197b31b2616240ec9fb6e
Date:   Thu, 23 Sep 2021 16:22:00 -0700
Message-ID: <xmqqa6k2yj1j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E7893B6-1CC5-11EC-8405-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen',
which means nothing more than that I have found them of interest for
some reason (like "it may have hard-to-resolve conflicts with
another topic already in flight" or "this may turn out to be
useful").  Do not read too much into a topic being in (or not in)
'seen'.  The ones marked with '.' do not appear in any of the
integration branches, but I am still holding onto them.

The eighth batch is out.

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

* ab/gc-remove-unused-call (2021-09-12) 1 commit
  (merged to 'next' on 2021-09-13 at 14f69ed198)
 + gc: remove unused launchctl_get_uid() call

 Code clean-up.


* ab/http-drop-old-curl-plus (2021-09-13) 9 commits
  (merged to 'next' on 2021-09-15 at 16aaab36f1)
 + http: don't hardcode the value of CURL_SOCKOPT_OK
 + http: centralize the accounting of libcurl dependencies
 + http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
 + http: correct version check for CURL_HTTP_VERSION_2
 + http: drop support for curl < 7.18.0 (again)
 + Makefile: drop support for curl < 7.9.8 (again)
 + INSTALL: mention that we need libcurl 7.19.4 or newer to build
 + INSTALL: reword and copy-edit the "libcurl" section
 + INSTALL: don't mention the "curl" executable at all

 Conditional compilation around versions of libcURL has been
 straightened out.


* ab/retire-option-argument (2021-09-12) 4 commits
  (merged to 'next' on 2021-09-15 at 0bd7ce1161)
 + parse-options API: remove OPTION_ARGUMENT feature
 + difftool: use run_command() API in run_file_diff()
 + difftool: prepare "diff" cmdline in cmd_difftool()
 + difftool: prepare "struct child_process" in cmd_difftool()
 (this branch is used by da/difftool.)

 An oddball OPTION_ARGUMENT feature has been removed from the
 parse-options API.


* ab/test-tool-run-command-cleanup (2021-09-12) 1 commit
  (merged to 'next' on 2021-09-13 at 086310d0f4)
 + test-tool run-command: fix flip-flop init pattern

 Code clean-up.


* ab/unused-script-helpers (2021-09-12) 4 commits
  (merged to 'next' on 2021-09-15 at 14e6b0f26e)
 + test-lib: remove unused $_x40 and $_z40 variables
 + git-bisect: remove unused SHA-1 $x40 shell variable
 + git-sh-setup: remove unused "pull with rebase" message
 + git-submodule: remove unused is_zero_oid() function

 Code clean-up.


* cb/plug-leaks-in-alloca-emu-users (2021-09-16) 2 commits
  (merged to 'next' on 2021-09-16 at 2eecae2de3)
 + t0000: avoid masking git exit value through pipes
 + tree-diff: fix leak when not HAVE_ALLOCA_H

 Leakfix.


* cb/unix-sockets-with-windows (2021-09-14) 3 commits
  (merged to 'next' on 2021-09-16 at e2921332ef)
 + git-compat-util: include declaration for unix sockets in windows
 + credential-cache: check for windows specific errors
 + t0301: fixes for windows compatibility

 Adjust credential-cache helper to Windows.


* en/am-abort-fix (2021-09-10) 3 commits
  (merged to 'next' on 2021-09-13 at 11f3d2dc90)
 + am: fix incorrect exit status on am fail to abort
 + t4151: add a few am --abort tests
 + git-am.txt: clarify --abort behavior
 (this branch is used by en/removing-untracked-fixes.)

 When "git am --abort" fails to abort correctly, it still exited
 with exit status of 0, which has been corrected.


* en/tests-cleanup-leftover-untracked (2021-09-12) 1 commit
  (merged to 'next' on 2021-09-13 at cf38118205)
 + tests: remove leftover untracked files

 Test clean-up.


* jk/http-server-protocol-versions (2021-09-10) 5 commits
  (merged to 'next' on 2021-09-13 at 9174cd6d37)
 + docs/protocol-v2: point readers transport config discussion
 + docs/git: discuss server-side config for GIT_PROTOCOL
 + docs/http-backend: mention v2 protocol
 + http-backend: handle HTTP_GIT_PROTOCOL CGI variable
 + t5551: test v2-to-v0 http protocol fallback

 Taking advantage of the CGI interface, http-backend has been
 updated to enable protocol v2 automatically when the other side
 asks for it.


* jk/strvec-typefix (2021-09-12) 1 commit
  (merged to 'next' on 2021-09-13 at e07858581d)
 + strvec: use size_t to store nr and alloc

 Correct nr and alloc members of strvec struct to be of type size_t.


* jt/submodule-name-to-gitdir (2021-09-15) 1 commit
  (merged to 'next' on 2021-09-16 at c658fbfdb8)
 + submodule: extract path to submodule gitdir func

 Code refactoring.


* kz/revindex-comment-fix (2021-09-15) 1 commit
  (merged to 'next' on 2021-09-16 at b4797add3a)
 + pack-revindex.h: correct the time complexity descriptions

 Header comment fix.


* ma/doc-git-version (2021-09-14) 1 commit
  (merged to 'next' on 2021-09-16 at 54a6a3f8b5)
 + documentation: add documentation for 'git version'

 Doc update.


* ma/help-w-check-for-requested-page (2021-09-14) 1 commit
  (merged to 'next' on 2021-09-16 at 292dd7174d)
 + help: make sure local html page exists before calling external processes

 The error in "git help no-such-git-command" is handled better.


* mr/bisect-in-c-4 (2021-09-13) 6 commits
  (merged to 'next' on 2021-09-15 at 2af7f048d4)
 + bisect--helper: retire `--bisect-next-check` subcommand
 + bisect--helper: reimplement `bisect_run` shell function in C
 + bisect--helper: reimplement `bisect_visualize()` shell function in C
 + run-command: make `exists_in_PATH()` non-static
 + t6030-bisect-porcelain: add test for bisect visualize
 + t6030-bisect-porcelain: add tests to control bisect run exit cases

 Rewrite of "git bisect" in C continues.


* po/git-config-doc-mentions-help-c (2021-09-13) 1 commit
  (merged to 'next' on 2021-09-13 at bddbd5c25d)
 + doc: config, tell readers of `git help --config`

 Doc update.


* ps/update-ref-batch-flush (2021-09-15) 2 commits
  (merged to 'next' on 2021-09-15 at 39a69141e3)
 + t1400: avoid SIGPIPE race condition on fifo
  (merged to 'next' on 2021-09-10 at 4ae19a5f34)
 + update-ref: fix streaming of status updates

 "git update-ref --stdin" failed to flush its output as needed,
 which potentially led the conversation to a deadlock.


* rs/drop-core-compression-vars (2021-09-12) 1 commit
  (merged to 'next' on 2021-09-13 at 3bd06626c3)
 + compression: drop write-only core_compression_* variables

 Code clean-up.


* rs/packfile-bad-object-list-in-oidset (2021-09-12) 5 commits
  (merged to 'next' on 2021-09-13 at 80e72f5f97)
 + packfile: use oidset for bad objects
 + packfile: convert has_packed_and_bad() to object_id
 + packfile: convert mark_bad_packed_object() to object_id
 + midx: inline nth_midxed_pack_entry()
 + oidset: make oidset_size() an inline function

 Replace a handcrafted data structure used to keep track of bad
 objects in the packfile API by an oidset.


* rs/use-xopen-in-index-pack (2021-09-10) 1 commit
  (merged to 'next' on 2021-09-16 at 186eaaae56)
 + index-pack: use xopen in init_thread

 Code clean-up.

--------------------------------------------------
[New Topics]

* ab/make-clean-depend-dirs (2021-09-22) 1 commit
 - Makefile: clean .depend dirs under COMPUTE_HEADER_DEPENDENCIES != yes

 "make clean" has been updated to remove leftover .depend/
 directories, even when it is not told to use them to compute header
 dependencies.

 Will merge to 'next'.


* bs/ls-files-opt-help-text-update (2021-09-22) 1 commit
 - ls-files: use imperative mood for -X and -z option description

 Help test for "ls-files" options have been updated.

 Will merge to 'next'.


* cb/make-compdb-fix (2021-09-22) 1 commit
 - Makefile: avoid breaking compilation database generation with DEVELOPER

 Adjust to recent change to use -pedantic for developer builds.

 Will merge to 'next'.


* ds/perf-test-built-path-fix (2021-09-22) 1 commit
 - t/perf/run: fix bin-wrappers computation

 Perf test fix.

 Will merge to 'next'.


* gc/doc-first-contribution-reroll (2021-09-22) 1 commit
 - MyFirstContribution: Document --range-diff option when writing v2

 Doc update.

 Will merge to 'next'.


* jk/grep-haystack-is-read-only (2021-09-22) 5 commits
 - grep: store grep_source buffer as const
 - grep: mark "haystack" buffers as const
 - grep: stop modifying buffer in grep_source_1()
 - grep: stop modifying buffer in show_line()
 - grep: stop modifying buffer in strip_timestamp
 (this branch is used by hm/paint-hits-in-log-grep.)

 Code clean-up in the "grep" machinery.

 Will merge to 'next'.


* jk/http-redact-fix (2021-09-22) 1 commit
 - http: match headers case-insensitively when redacting

 Sensitive data in the HTTP trace were supposed to be redacted, but
 we failed to do so in HTTP/2 requests.

 Will merge to 'next'.


* js/win-lazyload-buildfix (2021-09-23) 2 commits
 - lazyload.h: use an even more generic function pointer than FARPROC
 - lazyload.h: fix warnings about mismatching function pointer types

 Compilation fix.

 Will merge to 'next'.


* ab/auto-depend-with-pedantic (2021-09-22) 1 commit
 - Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work with DEVOPTS=pedantic

 Improve build procedure for developers.

 Will merge to 'next'.


* ab/make-sparse-for-real (2021-09-22) 1 commit
 - Makefile: make the "sparse" target non-.PHONY

 Prevent "make sparse" from running for the source files that
 haven't been modified.


* bs/difftool-msg-tweak (2021-09-22) 1 commit
 - difftool: fix word spacing in the usage strings

 Message tweak.

 Will merge to 'next'.


* ew/midx-doc-update (2021-09-23) 1 commit
 - doc/technical: update note about core.multiPackIndex

 Doc tweak.

 Will merge to 'next'.


* jt/no-abuse-alternate-odb-for-submodules (2021-09-22) 10 commits
 - submodule: trace adding submodule ODB as alternate
 - refs: change refs_for_each_ref_in() to take repo
 - submodule: pass repo to check_has_commit()
 - object-file: only register submodule ODB if needed
 - merge-{ort,recursive}: remove add_submodule_odb()
 - refs: teach refs_for_each_ref() arbitrary repos
 - refs iterator: support non-the_repository advance
 - refs: add repo paramater to _iterator_peel()
 - refs: make _advance() check struct repo, not flag
 - Merge branch 'jt/add-submodule-odb-clean-up' into jt/no-abuse-alternate-odb-for-submodules
 (this branch uses jt/add-submodule-odb-clean-up.)

 Follow through the work to use the repo interface to access
 submodule objects in-process, instead of abusing the alternate
 object database interface.


* tp/send-email-completion (2021-09-22) 3 commits
 - send-email docs: add format-patch options
 - send-email: move bash completions to core script
 - send-email: terminate --git-completion-helper with LF

 The command line complation for "git send-email" options have been
 tweaked to make it easier to keep it in sync with the command itself.


* hm/paint-hits-in-log-grep (2021-09-23) 3 commits
 - pretty: colorize pattern matches in commit messages
 - grep: refactor next_match() and match_one_pattern() for external use
 - Merge branch 'jk/grep-haystack-is-read-only' into hm/paint-hits-in-log-grep
 (this branch uses jk/grep-haystack-is-read-only.)

 "git log --grep=string --author=name" learns to highlight hits just
 like "git grep string" does.

--------------------------------------------------
[Stalled]

* ab/pack-objects-stdin (2021-07-09) 5 commits
 - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
 - pack-objects.c: do stdin parsing via revision.c's API
 - revision.[ch]: add a "handle_stdin_line" API
 - revision.h: refactor "disable_stdin" and "read_from_stdin"
 - upload-pack: run is_repository_shallow() before setup_revisions()

 Introduce handle_stdin_line callback to revision API and uses it.

 Expecting a reroll.


* es/superproject-aware-submodules (2021-08-19) 5 commits
 . fixup! introduce submodule.superprojectGitDir record
 . submodule: record superproject gitdir during 'update'
 . submodule: record superproject gitdir during absorbgitdirs
 . introduce submodule.superprojectGitDir record
 . t7400-submodule-basic: modernize inspect() helper

 A configuration variable in a submodule points at the location of
 the superproject it is bound to (RFC).

 Kicked out of 'seen' tentatively to see how well a conflicting
 ar/submodule-update topic fares.


* ab/fsck-unexpected-type (2021-09-22) 17 commits
 - fsck: report invalid object type-path combinations
 - fsck: don't hard die on invalid object types
 - object-file.c: stop dying in parse_loose_header()
 - object-file.c: return ULHR_TOO_LONG on "header too long"
 - object-file.c: use "enum" return type for unpack_loose_header()
 - object-file.c: simplify unpack_loose_short_header()
 - object-file.c: make parse_loose_header_extended() public
 - object-file.c: return -1, not "status" from unpack_loose_header()
 - object-file.c: don't set "typep" when returning non-zero
 - cat-file tests: test for current --allow-unknown-type behavior
 - cat-file tests: add corrupt loose object test
 - cat-file tests: test for missing/bogus object with -t, -s and -p
 - cat-file tests: move bogus_* variable declarations earlier
 - fsck tests: test for garbage appended to a loose object
 - fsck tests: test current hash/type mismatch behavior
 - fsck tests: refactor one test to use a sub-repo
 - fsck tests: add test for fsck-ing an unknown type

 "git fsck" has been taught to report mismatch between expected and
 actual types of an object better.

 Needs review.

--------------------------------------------------
[Cooking]

* ab/repo-settings-cleanup (2021-09-22) 5 commits
 - repository.h: don't use a mix of int and bitfields
 - repo-settings.c: simplify the setup
 - read-cache & fetch-negotiator: check "enum" values in switch()
 - environment.c: remove test-specific "ignore_untracked..." variable
 - wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c

 Code cleanup.

 Will merge to 'next'.


* ah/connect-parse-feature-v0-fix (2021-09-23) 1 commit
 - connect: also update offset for features without values

 Protocol v0 clients can get stuck parsing a malformed feature line.

 Will merge to 'next'.


* ah/unreak-revisions (2021-09-20) 2 commits
 - log: UNLEAK original pending objects
 - log: UNLEAK rev to silence a large number of leaks

 Mark a few structures with UNLEAK() to help leak detection CI jobs.

 Will merge to 'next'.


* ar/submodule-update (2021-09-20) 8 commits
 - submodule--helper: rename helper functions
 - submodule--helper: remove unused helpers
 - submodule--helper: remove update-clone subcommand
 - submodule: move core cmd_update() logic to C
 - submodule--helper: refactor get_submodule_displaypath()
 - submodule--helper: rename helpers for update-clone
 - submodule--helper: get remote names from any repository
 - submodule--helper: split up ensure_core_worktree()

 Rewrite of "git submodule update" in C.

 Expecting a reroll.
 Stomps on a handful of other topics and comes with an overly large step.


* da/difftool (2021-09-23) 4 commits
 - difftool: add a missing space to the run_dir_diff() comments
 - difftool: create a tmpdir path without repeated slashes
 - Merge branch 'da/difftool-dir-diff-symlink-fix' into da/difftool
 - Merge branch 'ab/retire-option-argument' into da/difftool
 (this branch uses da/difftool-dir-diff-symlink-fix.)

 Code clean-up in "git difftool".

 Will merge to 'next'?


* da/difftool-dir-diff-symlink-fix (2021-09-23) 1 commit
 - difftool: fix symlink-file writing in dir-diff mode
 (this branch is used by da/difftool.)

 "git difftool --dir-diff" mishandled symbolic links.

 Will merge to 'next'.


* en/removing-untracked-fixes (2021-09-20) 7 commits
 - Documentation: call out commands that nuke untracked files/directories
 - Comment important codepaths regarding nuking untracked files/dirs
 - unpack-trees: avoid nuking untracked dir in way of locally deleted file
 - unpack-trees: avoid nuking untracked dir in way of unmerged file
 - Split unpack_trees 'reset' flag into two for untracked handling
 - t2500: add various tests for nuking untracked files
 - Merge branch 'en/am-abort-fix' into en/removing-untracked-fixes

 Various fixes in code paths that move untracked files away to make room.


* en/typofixes (2021-09-20) 2 commits
  (merged to 'next' on 2021-09-20 at 48648dafa3)
 + merge-ort: fix completely wrong comment
 + trace2.h: fix trivial comment typo

 Typofixes.

 Will merge to 'master'.


* ks/submodule-add-message-fix (2021-09-20) 1 commit
 - submodule--helper: fix incorrect newlines in an error message

 Message regression fix.

 Will merge to 'next'.


* tb/commit-graph-usage-fix (2021-09-22) 2 commits
 - builtin/multi-pack-index.c: disable top-level --[no-]progress
 - builtin/commit-graph.c: don't accept common --[no-]progress

 Regression fix for "git commit-graph" command line parsing.

 Will merge to 'next'.


* ws/refer-to-forkpoint-config-in-rebase-doc (2021-09-20) 1 commit
 - Document `rebase.forkpoint` in rebase man page

 Doc update.

 Will merge to 'next'?


* jk/clone-unborn-head-in-bare (2021-09-20) 1 commit
  (merged to 'next' on 2021-09-20 at 93c93b8d51)
 + clone: handle unborn branch in bare repos

 "git clone" from a repository whose HEAD is unborn into a bare
 repository didn't follow the branch name the other side used, which
 is corrected.

 Will merge to 'master'.


* jk/reduce-malloc-in-v2-servers (2021-09-15) 12 commits
  (merged to 'next' on 2021-09-16 at 40cfe41efc)
 + ls-refs: reject unknown arguments
 + serve: reject commands used as capabilities
 + serve: reject bogus v2 "command=ls-refs=foo"
 + docs/protocol-v2: clarify some ls-refs ref-prefix details
 + ls-refs: ignore very long ref-prefix counts
 + serve: drop "keys" strvec
 + serve: provide "receive" function for session-id capability
 + serve: provide "receive" function for object-format capability
 + serve: add "receive" method for v2 capabilities table
 + serve: return capability "value" from get_capability()
 + serve: rename is_command() to parse_command()
 + Merge branch 'ab/serve-cleanup' into jk/reduce-malloc-in-v2-servers

 Code cleanup to limit memory consumption and tighten protocol
 message parsing.

 Will merge to 'master'.


* ns/batched-fsync (2021-09-22) 6 commits
 - core.fsyncobjectfiles: performance tests for add and stash
 - core.fsyncobjectfiles: tests for batch mode
 - update-index: use the bulk-checkin infrastructure
 - core.fsyncobjectfiles: add windows support for batch mode
 - core.fsyncobjectfiles: batched disk flushes
 - bulk-checkin: rename 'state' variable and separate 'plugged' boolean

 The "core.fsyncobjectfiles" configuration variable can now be set
 to "batch" for improved performance.


* jh/builtin-fsmonitor-part1 (2021-09-20) 7 commits
 - t/helper/simple-ipc: convert test-simple-ipc to use start_bg_command
 - run-command: create start_bg_command
 - simple-ipc/ipc-win32: add Windows ACL to named pipe
 - simple-ipc/ipc-win32: add trace2 debugging
 - simple-ipc: move definition of ipc_active_state outside of ifdef
 - simple-ipc: preparations for supporting binary messages.
 - trace2: add trace2_child_ready() to report on background children

 Built-in fsmonitor (part 1).


* cb/cvsserver (2021-09-16) 3 commits
  (merged to 'next' on 2021-09-23 at 98f5f3f9cf)
 + Documentation: cleanup git-cvsserver
 + git-cvsserver: protect against NULL in crypt(3)
 + git-cvsserver: use crypt correctly to compare password hashes

 "git cvsserver" had a long-standing bug in its authentication code,
 which has finally been corrected (it is unclear and is a separate
 question if anybody is seriously using it, though).

 Will merge to 'master'.


* cb/unicode-14 (2021-09-17) 1 commit
  (merged to 'next' on 2021-09-20 at 7873b310ad)
 + unicode: update the width tables to Unicode 14

 The unicode character width table (used for output alignment) has
 been updated.

 Will merge to 'master'.


* ab/align-parse-options-help (2021-09-22) 4 commits
 - parse-options: properly align continued usage output
 - git rev-parse --parseopt tests: add more usagestr tests
 - send-pack: properly use parse_options() API for usage string
 - parse-options API users: align usage output in C-strings

 When "git cmd -h" shows more than one line of usage text (e.g.
 the cmd subcommand may take sub-sub-command), parse-options API
 learned to align these lines, even across i18n/l10n.

 Will merge to 'next'?


* ab/help-config-vars (2021-09-23) 9 commits
 - help: move column config discovery to help.c library
 - help / completion: make "git help" do the hard work
 - help tests: test --config-for-completion option & output
 - help: simplify by moving to OPT_CMDMODE()
 - help: correct logic error in combining --all and --guides
 - help: correct logic error in combining --all and --config
 - help tests: add test for --config output
 - help: correct usage & behavior of "git help --guides"
 - help: correct the usage string in -h and documentation

 Teach "git help -c" into helping the command line completion of
 configuration variables.

 Will merge to 'next'?


* tb/repack-write-midx (2021-09-16) 8 commits
 - builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
 - builtin/repack.c: make largest pack preferred
 - builtin/repack.c: support writing a MIDX while repacking
 - builtin/repack.c: extract showing progress to a variable
 - builtin/repack.c: keep track of existing packs unconditionally
 - midx: preliminary support for `--refs-snapshot`
 - builtin/multi-pack-index.c: support `--stdin-packs` mode
 - midx: expose `write_midx_file_only()` publicly

 "git repack" has been taught to generate multi-pack reachability
 bitmaps.

 Will merge to 'next'?


* ds/add-rm-with-sparse-index (2021-09-22) 14 commits
 - advice: update message to suggest '--sparse'
 - mv: refuse to move sparse paths
 - rm: skip sparse paths with missing SKIP_WORKTREE
 - rm: add --sparse option
 - add: update --renormalize to skip sparse paths
 - add: update --chmod to skip sparse paths
 - add: implement the --sparse option
 - add: skip tracked paths outside sparse-checkout cone
 - add: fail when adding an untracked sparse file
 - dir: fix pattern matching on dirs
 - dir: select directories correctly
 - dir: extract directory-matching logic
 - t1092: behavior for adding sparse files
 - t3705: test that 'sparse_entry' is unstaged

 "git add", "git mv", and "git rm" have been adjusted to avoid
 updating paths outside of the sparse-checkout definition unless
 the user specifies a "--sparse" option.


* tb/midx-write-propagate-namehash (2021-09-17) 7 commits
 - t5326: test propagating hashcache values
 - p5326: generate pack bitmaps before writing the MIDX bitmap
 - p5326: don't set core.multiPackIndex unnecessarily
 - p5326: create missing 'perf-tag' tag
 - midx.c: respect 'pack.writeBitmapHashcache' when writing bitmaps
 - pack-bitmap.c: propagate namehash values from existing bitmaps
 - t/helper/test-bitmap.c: add 'dump-hashes' mode

 "git multi-pack-index write --bitmap" learns to propagate the
 hashcache from original bitmap to resulting bitmap.

 Will merge to 'next'?


* pw/rebase-of-a-tag-fix (2021-09-22) 10 commits
 - rebase: dereference tags
 - rebase: use lookup_commit_reference_by_name()
 - rebase: use our standard error return value
 - t3407: rework rebase --quit tests
 - t3407: strengthen rebase --abort tests
 - t3407: use test_path_is_missing
 - t3407: rename a variable
 - t3407: use test_cmp_rev
 - t3407: use test_commit
 - t3407: run tests in $TEST_DIRECTORY

 "git rebase <upstream> <tag>" failed when aborted in the middle, as
 it mistakenly tried to write the tag object instead of peeling it
 to HEAD.

 Will merge to 'next'?


* en/zdiff3 (2021-09-20) 2 commits
 - update documentation for new zdiff3 conflictStyle
 - xdiff: implement a zealous diff3, or "zdiff3"

 "Zealous diff3" style of merge conflict presentation has been added.


* en/stash-df-fix (2021-09-10) 3 commits
  (merged to 'next' on 2021-09-20 at 513c11fb11)
 + stash: restore untracked files AFTER restoring tracked files
 + stash: avoid feeding directories to update-index
 + t3903: document a pair of directory/file bugs

 Fix "git stash" corner case where the tentative change involves
 changing a directory to a file (or vice versa).

 Will merge to 'master'.


* jt/add-submodule-odb-clean-up (2021-09-09) 3 commits
 - revision: remove "submodule" from opt struct
 - repository: support unabsorbed in repo_submodule_init
 - submodule: remove unnecessary unabsorbed fallback
 (this branch is used by jt/no-abuse-alternate-odb-for-submodules.)

 More code paths that uses the hack to add submodule's object
 database to the set of alternate object store have been cleaned up.

 Will merge to 'next'.


* jx/ci-l10n (2021-09-09) 1 commit
  (merged to 'next' on 2021-09-23 at b2d7f5eecb)
 + ci: new github-action for git-l10n code review

 CI help for l10n.

 Will merge to 'master'.


* js/scalar (2021-09-14) 15 commits
 - scalar: accept -C and -c options before the subcommand
 - scalar: implement the `version` command
 - scalar: implement the `delete` command
 - scalar: teach 'reconfigure' to optionally handle all registered enlistments
 - scalar: allow reconfiguring an existing enlistment
 - scalar: implement the `run` command
 - scalar: teach 'clone' to support the --single-branch option
 - scalar: implement the `clone` subcommand
 - scalar: implement 'scalar list'
 - scalar: let 'unregister' handle a deleted enlistment directory gracefully
 - scalar: 'unregister' stops background maintenance
 - scalar: 'register' sets recommended config and starts maintenance
 - scalar: create test infrastructure
 - scalar: start documenting the command
 - scalar: create a rudimentary executable

 Add pieces from "scalar" to contrib/.


* ab/sanitize-leak-ci (2021-09-23) 2 commits
 - tests: add a test mode for SANITIZE=leak, run it in CI
 - Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS

 CI learns to run the leak sanitizer builds.

 Will merge to 'next'?


* ms/customizable-ident-expansion (2021-09-01) 1 commit
 - keyword expansion: make "$Id$" string configurable

 Instead of "$Id$", user-specified string (like $FreeBSD$) can be
 used as an in-blob placeholder for keyword expansion.


* js/retire-preserve-merges (2021-09-07) 11 commits
  (merged to 'next' on 2021-09-10 at f645ffd7a3)
 + sequencer: restrict scope of a formerly public function
 + rebase: remove a no-longer-used function
 + rebase: stop mentioning the -p option in comments
 + rebase: remove obsolete code comment
 + rebase: drop the internal `rebase--interactive` command
 + git-svn: drop support for `--preserve-merges`
 + rebase: drop support for `--preserve-merges`
 + pull: remove support for `--rebase=preserve`
 + tests: stop testing `git rebase --preserve-merges`
 + remote: warn about unhandled branch.<name>.rebase values
 + t5520: do not use `pull.rebase=preserve`

 The "--preserve-merges" option of "git rebase" has been removed.

 Will cook in 'next'.


* en/remerge-diff (2021-08-31) 7 commits
 - doc/diff-options: explain the new --remerge-diff option
 - show, log: provide a --remerge-diff capability
 - tmp-objdir: new API for creating and removing primary object dirs
 - merge-ort: capture and print ll-merge warnings in our preferred fashion
 - ll-merge: add API for capturing warnings in a strbuf instead of stderr
 - merge-ort: add ability to record conflict messages in a file
 - merge-ort: mark a few more conflict messages as omittable

 A new presentation for two-parent merge "--remerge-diff" can be
 used to show the difference between mechanical (and possibly
 conflicted) merge results and the recorded resolution.


* sg/test-split-index-fix (2021-09-07) 7 commits
 - read-cache: fix GIT_TEST_SPLIT_INDEX
 - tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
 - read-cache: look for shared index files next to the index, too
 - t1600-index: disable GIT_TEST_SPLIT_INDEX
 - t1600-index: don't run git commands upstream of a pipe
 - t1600-index: remove unnecessary redirection
 - Merge branch 'ds/sparse-index-ignored-files' into sg/test-split-index-fix

 Test updates.

 Will merge to 'next'?


* ab/refs-errno-cleanup (2021-08-25) 4 commits
 - refs: make errno output explicit for refs_resolve_ref_unsafe
 - refs: explicitly return failure_errno from parse_loose_ref_contents
 - branch tests: test for errno propagating on failing read
 - refs: add failure_errno to refs_read_raw_ref() signature
 (this branch uses ab/refs-files-cleanup and hn/refs-errno-cleanup.)

 The "remainder" of hn/refs-errno-cleanup topic.


* ab/lib-subtest (2021-09-22) 9 commits
 - test-lib tests: get rid of copy/pasted mock test code
 - test-lib tests: assert 1 exit code, not non-zero
 - test-lib tests: refactor common part of check_sub_test_lib_test*()
 - test-lib tests: avoid subshell for "test_cmp" for readability
 - test-lib tests: don't provide a description for the sub-tests
 - test-lib tests: split up "write and run" into two functions
 - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
 - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
 - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest

 Updates to the tests in t0000 to test the test framework.


* ab/only-single-progress-at-once (2021-09-22) 8 commits
 - progress.c: add & assert a "global_progress" variable
 - pack-bitmap-write.c: add a missing stop_progress()
 - progress.c: add temporary variable from progress struct
 - progress.c: stop eagerly fflush(stderr) when not a terminal
 - progress.c: call progress_interval() from progress_test_force_update()
 - progress.c: move signal handler functions lower
 - progress.c tests: test some invalid usage
 - progress.c tests: make start/stop verbs on stdin

 Further tweaks on progress API.


* fs/ssh-signing (2021-09-10) 9 commits
 - ssh signing: test that gpg fails for unknown keys
 - ssh signing: tests for logs, tags & push certs
 - ssh signing: duplicate t7510 tests for commits
 - ssh signing: verify signatures using ssh-keygen
 - ssh signing: provide a textual signing_key_id
 - ssh signing: retrieve a default key from ssh-agent
 - ssh signing: add ssh key format and signing code
 - ssh signing: add test prereqs
 - ssh signing: preliminary refactoring and clean-up

 Use ssh public crypto for object and push-cert signing.

 On hold.
 cf. <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
 cf. <532d97e7-8c91-df6a-6d90-70668256f513@gigacodes.de>


* cf/fetch-set-upstream-while-detached (2021-07-06) 1 commit
 - fetch: fix segfault on --set-upstream while on a detached HEAD

 "git fetch --set-upstream" while on detached HEAD segfaulted
 instead of noticing that such an operation did not make sense.

 Expecting a reroll.
 cf. <xmqqsg0ri5mq.fsf@gitster.g>


* pw/diff-color-moved-fix (2021-08-05) 13 commits
 - diff: drop unused options parameter from cmp_in_block_with_wsd()
 - diff --color-moved: intern strings
 - diff: use designated initializers for emitted_diff_symbol
 - diff --color-moved-ws=allow-indentation-change: improve hash lookups
 - diff --color-moved: stop clearing potential moved blocks
 - diff --color-moved: shrink potential moved blocks as we go
 - diff --color-moved: unify moved block growth functions
 - diff --color-moved: call comparison function directly
 - diff --color-moved-ws=allow-indentation-change: simplify and optimize
 - diff: simplify allow-indentation-change delta calculation
 - diff --color-moved: avoid false short line matches and bad zerba coloring
 - diff --color-moved=zebra: fix alternate coloring
 - diff --color-moved: add perf tests

 Originally merged to 'next' on 2021-08-05

 Long-overdue correctness and performance update to "diff
 --color-moved" feature.

 Expecting a reroll.
 cf. <8bec1a6d-5052-50c3-4100-e6348289d581@gmail.com>


* hn/reftable (2021-09-10) 20 commits
 - fixup! reftable: implement stack, a mutable database of reftable files.
 - Add "test-tool dump-reftable" command.
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
 - reftable: RFC: add LICENSE
 - hash.h: provide constants for the hash IDs

 The "reftable" backend for the refs API, without integrating into
 the refs subsystem.

 Will merge to 'next'?


* ab/refs-files-cleanup (2021-08-25) 13 commits
  (merged to 'next' on 2021-09-23 at eb5668523f)
 + refs/files: remove unused "errno != ENOTDIR" condition
 + refs/files: remove unused "errno == EISDIR" code
 + refs/files: remove unused "oid" in lock_ref_oid_basic()
 + refs API: remove OID argument to reflog_expire()
 + reflog expire: don't lock reflogs using previously seen OID
 + refs/files: add a comment about refs_reflog_exists() call
 + refs: make repo_dwim_log() accept a NULL oid
 + refs/debug: re-indent argument list for "prepare"
 + refs/files: remove unused "skip" in lock_raw_ref() too
 + refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
 + refs: drop unused "flags" parameter to lock_ref_oid_basic()
 + refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
 + refs/packet: add missing BUG() invocations to reflog callbacks
 (this branch is used by ab/refs-errno-cleanup and hn/refs-errno-cleanup.)

 Continued work on top of the hn/refs-errno-cleanup topic.

 Will merge to 'master'.


* hn/refs-errno-cleanup (2021-08-25) 4 commits
  (merged to 'next' on 2021-09-23 at 502e6b6b08)
 + refs: make errno output explicit for read_raw_ref_fn
 + refs/files-backend: stop setting errno from lock_ref_oid_basic
 + refs: remove EINVAL errno output from specification of read_raw_ref_fn
 + refs file backend: move raceproof_create_file() here
 (this branch is used by ab/refs-errno-cleanup; uses ab/refs-files-cleanup.)

 Futz with the way 'errno' is relied on in the refs API to carry the
 failure modes up the call chain.

 Will merge to 'master'.

--------------------------------------------------
[Discarded]

* ao/p4-avoid-decoding (2021-04-12) 2 commits
 . git-p4: do not decode data from perforce by default
 . git-p4: avoid decoding more data from perforce

 "git p4" in Python-2 days used to accept a lot more kinds of data
 from Perforce server as uninterrupted byte sequence, but after
 switching to Python-3, too many things are expected to be in UTF-8,
 which broke traditional use cases.

 Have been stalled for too long.
 cf. <20210504220153.1d9f0cb2@ado-tr>


* tv/p4-fallback-encoding (2021-04-30) 1 commit
 . git-p4: git-p4.fallbackEncoding to specify non UTF-8 charset

 "git p4" learns the fallbackEncoding configuration variable to
 safely accept changeset descriptions that aren't written in UTF-8.

 Have been stalled for too long.
 cf. <CAKu1iLUaLuAZWqjNK4tfhhR=YaSt4MdQ+90ZY-JcEh_SeHyYCw@mail.gmail.com>


* jh/builtin-fsmonitor (2021-09-03) 37 commits
 . fixup! fsmonitor--daemon: implement handle_client callback
 . SQUASH??? https://github.com/git/git/runs/3438543601?check_suite_focus=true#step:5:136
 . BANDAID: sparse fixes
 . t7527: test FS event reporing on MacOS WRT case and Unicode
 . fsmonitor: handle shortname for .git
 . t7527: test status with untracked-cache and fsmonitor--daemon
 . fsmonitor: force update index after large responses
 . fsmonitor: enhance existing comments
 . fsmonitor--daemon: use a cookie file to sync with file system
 . fsmonitor--daemon: periodically truncate list of modified files
 . t7527: create test for fsmonitor--daemon
 . t/perf/p7519: add fsmonitor--daemon test cases
 . t/perf: avoid copying builtin fsmonitor files into test repo
 . t/perf/p7519: speed up test using "test-tool touch"
 . t/helper/test-touch: add helper to touch a series of files
 . fsmonitor--daemon: implement handle_client callback
 . fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
 . fsmonitor-fs-listen-macos: add macos header files for FSEvent
 . fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
 . fsmonitor--daemon: create token-based changed path cache
 . fsmonitor--daemon: define token-ids
 . fsmonitor--daemon: add pathname classification
 . fsmonitor: do not try to operate on bare repos
 . fsmonitor--daemon: implement 'start' command
 . fsmonitor--daemon: implement 'run' command
 . fsmonitor-fs-listen-macos: stub in backend for MacOS
 . fsmonitor-fs-listen-win32: stub in backend for Windows
 . t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
 . fsmonitor--daemon: implement 'stop' and 'status' commands
 . fsmonitor--daemon: add a built-in fsmonitor daemon
 . fsmonitor: use IPC to query the builtin FSMonitor daemon
 . fsmonitor: config settings are repository-specific
 . help: include fsmonitor--daemon feature flag in version info
 . fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 . fsmonitor--daemon: update fsmonitor documentation
 . fsmonitor--daemon: man page
 . simple-ipc: preparations for supporting binary messages.

 An attempt to write and ship with a watchman equivalent tailored
 for our use.

 Will be rerolled in pieces.


* ab/config-based-hooks-base (2021-09-09) 36 commits
 . hooks: fix a TOCTOU in "did we run a hook?" heuristic
 . receive-pack: convert receive hooks to hook.h
 . post-update: use hook.h library
 . receive-pack: convert 'update' hook to hook.h
 . hooks: allow callers to capture output
 . run-command: allow capturing of collated output
 . reference-transaction: use hook.h to run hooks
 . hook tests: use a modern style for "pre-push" tests
 . hook tests: test for exact "pre-push" hook input
 . transport: convert pre-push hook to hook.h
 . hook: convert 'post-rewrite' hook in sequencer.c to hook.h
 . hook: provide stdin by string_list or callback
 . run-command: add stdin callback for parallelization
 . am: convert 'post-rewrite' hook to hook.h
 . hook: support passing stdin to hooks
 . run-command: allow stdin for run_processes_parallel
 . run-command: remove old run_hook_{le,ve}() hook API
 . receive-pack: convert push-to-checkout hook to hook.h
 . read-cache: convert post-index-change to use hook.h
 . commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
 . git-p4: use 'git hook' to run hooks
 . send-email: use 'git hook run' for 'sendemail-validate'
 . git hook run: add an --ignore-missing flag
 . merge: convert post-merge to use hook.h
 . hooks: convert 'post-checkout' hook to hook library
 . am: convert applypatch to use hook.h
 . rebase: convert pre-rebase to use hook.h
 . gc: use hook library for pre-auto-gc hook
 . hook: add 'run' subcommand
 . hook-list.h: add a generated list of hooks, like config-list.h
 . hook.c users: use "hook_exists()" instead of "find_hook()"
 . hook.c: add a hook_exists() wrapper and use it in bugreport.c
 . hook.[ch]: move find_hook() from run-command.c to hook.c
 . Makefile: remove an out-of-date comment
 . Makefile: stop hardcoding {command,config}-list.h
 . Makefile: mark "check" target as .PHONY
 (this branch is used by es/config-based-hooks.)

 Restructuring of (a subset of) Emily's config-based-hooks series,
 to demonstrate that a series can be presented as a more logical and
 focused progression.

 Will be rerolled in pieces.


* es/config-based-hooks (2021-09-09) 6 commits
 . hook: allow out-of-repo 'git hook' invocations
 . hook: include hooks from the config
 . hook: introduce "git hook list"
 . hook: allow parallel hook execution
 . fixup! hook: run a list of hooks instead
 . hook: run a list of hooks instead
 (this branch uses ab/config-based-hooks-base.)

 Revamp the hooks subsystem to allow multiple of them to trigger
 upon the same event and control via the configuration variables.
