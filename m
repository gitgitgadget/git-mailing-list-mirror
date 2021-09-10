Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFF6C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 22:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897456120A
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 22:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhIJWMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 18:12:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60231 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhIJWMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 18:12:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7248014A45B;
        Fri, 10 Sep 2021 18:11:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=a3+YPWmazM5wm29rGlWA1T1Pa
        g20Ba+wKUZczK3cCL4=; b=gYwQXzcKk6kxDX4y39v7s1HNYk5TnjRJGbrFCjfFJ
        ek8V7pkIW8cu0HrK8756jF1MGx4blHFuoTrM7w/JZjAJj/sUJOvPSSnKibUqpGAI
        ssp5v56+v3Q9Fvkvcmpyry+HMSimHgAhnkwdwLAW8djBLcP1fs3BkPhaa8ywaTDN
        MM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AD0814A45A;
        Fri, 10 Sep 2021 18:11:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82BE714A459;
        Fri, 10 Sep 2021 18:11:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2021, #03; Fri, 10)
X-master-at: 8b7c11b8668b4e774f81a9f0b4c30144b818f1d1
X-next-at: 5e29049d33d12c9bf75c9b7214e9d7d19bb2e7fe
Date:   Fri, 10 Sep 2021 15:11:05 -0700
Message-ID: <xmqqsfycqdxi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FF5637DA-1283-11EC-BCC7-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
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

* ab/commit-graph-usage (2021-08-30) 7 commits
  (merged to 'next' on 2021-09-03 at 2254ea1e58)
 + commit-graph: show "unexpected subcommand" error
 + commit-graph: show usage on "commit-graph [write|verify] garbage"
 + commit-graph: early exit to "usage" on !argc
 + multi-pack-index: refactor "goto usage" pattern
 + commit-graph: use parse_options_concat()
 + commit-graph: remove redundant handling of -h
 + commit-graph: define common usage with a macro

 Fixes on usage message from "git commit-graph".


* ab/gc-log-rephrase (2021-09-02) 1 commit
  (merged to 'next' on 2021-09-03 at 24c51e3df1)
 + gc: remove trailing dot from "gc.log" line

 A pathname in an advice message has been made cut-and-paste ready.


* ab/help-autocorrect-prompt (2021-08-14) 1 commit
  (merged to 'next' on 2021-09-08 at e9e130d3e6)
 + help.c: help.autocorrect=3Dprompt waits for user action

 The logic for auto-correction of misspelt subcommands learned to go
 interactive when the help.autocorrect configuration variable is set
 to 'prompt'.


* ab/ls-remote-packet-trace (2021-08-24) 1 commit
  (merged to 'next' on 2021-08-30 at fec2e5a7eb)
 + ls-remote: set packet_trace_identity(<name>)

 Debugging aid fix.


* ab/mailmap-leakfix (2021-08-31) 1 commit
  (merged to 'next' on 2021-09-03 at 348fe07b87)
 + mailmap.c: fix a memory leak in free_mailap_{info,entry}()

 Leakfix.


* ab/rebase-fatal-fatal-fix (2021-08-24) 1 commit
  (merged to 'next' on 2021-08-30 at 256e1cbc9e)
 + rebase: emit one "fatal" in "fatal: fatal: <error>"

 Error message fix.


* ab/retire-advice-config (2021-08-25) 4 commits
  (merged to 'next' on 2021-09-03 at 0045df3dbb)
 + advice: move advice.graftFileDeprecated squashing to commit.[ch]
 + advice: remove use of global advice_add_embedded_repo
 + advice: remove read uses of most global `advice_` variables
 + advice: add enum variants for missing advice variables

 Code clean up to migrate callers from older advice_config[] based
 API to newer advice_if_enabled() and advice_enabled() API.


* ba/object-info (2021-08-31) 1 commit
  (merged to 'next' on 2021-09-03 at 6d47f59ab4)
 + protocol-caps.c: fix memory leak in send_info()

 Leakfix.


* cb/ci-build-pedantic (2021-08-11) 1 commit
  (merged to 'next' on 2021-09-08 at c47fb2d7cc)
 + ci: run a pedantic build as part of the GitHub workflow

 CI update.


* cb/makefile-apple-clang (2021-08-06) 3 commits
  (merged to 'next' on 2021-08-30 at 9fe8f1a9b3)
 + build: catch clang that identifies itself as "$VENDOR clang"
 + build: clang version may not be followed by extra words
 + build: update detect-compiler for newer Xcode version

 Build update for Apple clang.


* cb/remote-ndebug-fix (2021-09-02) 1 commit
  (merged to 'next' on 2021-09-03 at a47f44ca9d)
 + remote: avoid -Wunused-but-set-variable in gcc with -DNDEBUG

 Build fix.


* dd/diff-files-unmerged-fix (2021-08-25) 1 commit
  (merged to 'next' on 2021-08-30 at 63a1bdddfc)
 + diff-lib: ignore paths that are outside $cwd if --relative asked

 "git diff --relative" segfaulted and/or produced incorrect result
 when there are unmerged paths.


* dd/t6300-wo-gpg-fix (2021-08-25) 2 commits
  (merged to 'next' on 2021-08-30 at 59f5669dd6)
 + t6300: check for cat-file exit status code
 + t6300: don't run cat-file on non-existent object

 Test fix.


* es/walken-tutorial-fix (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-01 at 73719bee8a)
 + doc: fix syntax error and the format of printf

 Typofix.


* ga/send-email-sendmail-cmd (2021-08-24) 1 commit
  (merged to 'next' on 2021-08-30 at 1bb659c66c)
 + t9001: PATH must not use Windows-style paths

 Test fix.


* gh/gitweb-branch-sort (2021-06-10) 1 commit
  (merged to 'next' on 2021-09-08 at a51cf7e283)
 + gitweb: use HEAD as secondary sort key in git_get_heads_list()

 Tie-break branches that point at the same object in the list of
 branches on GitWeb to show the one pointed at by HEAD early.


* jb/midx-revindex-fix (2021-08-23) 1 commit
 - multi-pack-index: fix *.rev cleanups with --object-dir

 An implementation in "multi-pack-index write" that takes object
 directory inconsistently used that and the object store of the
 default repository, causing segfaults and possibly corrupting
 repositories.

 Discard.  This has been absorbed in another topic.
 cf. <c0c24993-77e2-51a1-c352-0399c59f1f94@ramsayjones.plus.com>


* jh/sparse-index-resize-fix (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-01 at 5ee2615670)
 + sparse-index: copy dir_hash in ensure_full_index()

 The sparse-index support can corrupt the index structure by storing
 a stale and/or uninitialized data, which has been corrected.


* jk/log-warn-on-bogus-encoding (2021-08-27) 2 commits
  (merged to 'next' on 2021-09-08 at 56fe25cc53)
 + docs: use "character encoding" to refer to commit-object encoding
 + logmsg_reencode(): warn when iconv() fails

 Doc update plus improved error reporting.


* jk/t5323-no-pack-test-fix (2021-08-25) 1 commit
  (merged to 'next' on 2021-08-30 at 2892635eaf)
 + t5323: drop mentions of "master"

 Test fix.


* js/advise-when-skipping-cherry-picked (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-01 at bc883fce56)
 + sequencer: advise if skipping cherry-picked commit

 "git rebase" by default skips changes that are equivalent to
 commits that are already in the history the branch is rebased onto;
 give messages when this happens to let the users be aware of
 skipped commits, and also teach them how to tell "rebase" to keep
 duplicated changes.


* js/maintenance-launchctl-fix (2021-08-24) 2 commits
  (merged to 'next' on 2021-08-30 at 12a5da47e7)
 + maintenance: skip bootout/bootstrap when plist is registered
 + maintenance: create `launchctl` configuration using a lock file

 "git maintenance" scheduler fix for macOS.


* ka/want-ref-in-namespace (2021-09-01) 3 commits
  (merged to 'next' on 2021-09-01 at a1075a92a9)
 + docs: clarify the interaction of transfer.hideRefs and namespaces
 + upload-pack.c: treat want-ref relative to namespace
 + t5730: introduce fetch command helper

 "git upload-pack" which runs on the other side of "git fetch"
 forgot to take the ref namespaces into account when handling
 want-ref requests.


* me/t5582-cleanup (2021-08-24) 1 commit
  (merged to 'next' on 2021-08-30 at e92258e72c)
 + t5582: remove spurious 'cd "$D"' line

 Test fix.


* mh/credential-leakfix (2021-08-25) 1 commit
  (merged to 'next' on 2021-08-30 at be9e67bddc)
 + credential: fix leak in credential_apply_config()

 Leak fix.


* mh/send-email-reset-in-reply-to (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-03 at 3a60892d9a)
 + send-email: avoid incorrect header propagation

 Even when running "git send-email" without its own threaded
 discussion support, a threading related header in one message is
 carried over to the subsequent message to result in an unwanted
 threading, which has been corrected.


* mk/clone-recurse-submodules (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-03 at 9787178599)
 + clone: set submodule.recurse=3Dtrue if submodule.stickyRecursiveClone =
enabled

 After "git clone --recurse-submodules", all submodules are cloned
 but they are not by default recursed into by other commands.  With
 submodule.stickyRecursiveClone configuration set, submodule.recurse
 configuration is set to true in a repository created by "clone"
 with "--recurse-submodules" option.


* mt/quiet-with-delayed-checkout (2021-08-26) 1 commit
  (merged to 'next' on 2021-08-30 at d243498893)
 + checkout: make delayed checkout respect --quiet and --no-progress

 The delayed checkout code path in "git checkout" etc. were chatty
 even when --quiet and/or --no-progress options were given.


* ps/fetch-omit-formatting-under-quiet (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-01 at 2440a8a2aa)
 + fetch: skip formatting updated refs with `--quiet`

 "git fetch --quiet" optimization to avoid useless computation of
 info that will never be displayed.


* ps/ls-refs-strbuf-optim (2021-08-25) 1 commit
  (merged to 'next' on 2021-08-30 at e4cbc7243a)
 + ls-refs: reuse buffer when sending refs

 Micro-optimization for the wire protocol driver.


* rs/archive-use-object-id (2021-08-27) 1 commit
  (merged to 'next' on 2021-09-08 at 02899d8aea)
 + archive: convert queue_directory to struct object_id

 Code cleanup.


* rs/branch-allow-deleting-dangling (2021-08-27) 1 commit
  (merged to 'next' on 2021-08-30 at 35b9d158e8)
 + branch: allow deleting dangling branches with --force

 "git branch -D <branch>" used to refuse to remove a broken branch
 ref that points at a missing commit, which has been corrected.


* rs/git-mmap-uses-malloc (2021-08-24) 1 commit
  (merged to 'next' on 2021-08-30 at 6339c8e657)
 + compat: let git_mmap use malloc(3) directly

 mmap() imitation used to call xmalloc() that dies upon malloc()
 failure, which has been corrected to just return an error to the
 caller to be handled.


* rs/more-fspathcmp (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-01 at 3052b89438)
 + merge-recursive: use fspathcmp() in path_hashmap_cmp()

 Code simplification.


* rs/show-branch-simplify (2021-08-27) 1 commit
  (merged to 'next' on 2021-09-08 at 047750a6fa)
 + show-branch: simplify rev_is_head()

 Code cleanup.


* rs/xopen-reports-open-failures (2021-08-25) 2 commits
  (merged to 'next' on 2021-08-30 at a8588775c8)
 + use xopen() to handle fatal open(2) failures
 + xopen: explicitly report creation failures

 Error diagnostics improvement.


* sg/column-nl (2021-08-26) 1 commit
  (merged to 'next' on 2021-08-30 at a3cb0f4745)
 + column: fix parsing of the '--nl' option

 The parser for the "--nl" option of "git column" has been
 corrected.


* sg/set-ceiling-during-tests (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-01 at 5378ce3817)
 + test-lib: set GIT_CEILING_DIRECTORIES to protect the surrounding repos=
itory

 Buggy tests could damage repositories outside the throw-away test
 area we created.  We now by default export GIT_CEILING_DIRECTORIES
 to limit the damage from such a stray test.


* tb/add-objects-in-unpacked-packs-simplify (2021-08-29) 3 commits
  (merged to 'next' on 2021-09-01 at 66b0f8564d)
 + builtin/pack-objects.c: remove duplicate hash lookup
 + builtin/pack-objects.c: simplify add_objects_in_unpacked_packs()
 + object-store.h: teach for_each_packed_object to ignore kept packs

 Code simplification with reduced memory usage.


* tk/fast-export-anonymized-tag-fix (2021-08-31) 1 commit
  (merged to 'next' on 2021-09-03 at 15ce1ab44f)
 + fast-export: fix anonymized tag using original length

 The output from "git fast-export", when its anonymization feature
 is in use, showed an annotated tag incorrectly.


* uk/userdiff-php-enum (2021-08-31) 1 commit
  (merged to 'next' on 2021-09-03 at 5c9eb654fe)
 + userdiff: support enum keyword in PHP hunk header

 Update the userdiff pattern for PHP.


* zh/cherry-pick-advice (2021-08-23) 1 commit
  (merged to 'next' on 2021-09-01 at 6ff491cc09)
 + cherry-pick: use better advice message

 The advice message that "git cherry-pick" gives when it asks
 conflicted replay of a commit to be resolved by the end user has
 been updated.

--------------------------------------------------
[New Topics]

* en/stash-df-fix (2021-09-08) 3 commits
 - stash: restore untracked files AFTER restoring tracked files
 - stash: avoid feeding directories to update-index
 - t3903: document a pair of directory/file bugs

 Fix "git stash" corner case where the tentative change involves
 changing a directory to a file (or vice versa).


* js/pull-release-packs-before-fetching (2021-09-08) 2 commits
 - pull: release packs before fetching
 - commit-graph: when closing the graph, also release the slab
 (this branch is used by js/run-command-close-packs.)

 "git pull" was taught to close open file descriptors to the
 packfiles before spawning "git fetch" to help auto-gc that may be
 invoked by it.


* ab/http-drop-old-curl-plus (2021-09-10) 8 commits
 - http: don't hardcode the value of CURL_SOCKOPT_OK
 - http: centralize the accounting of libcurl dependencies
 - http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
 - http: correct version check for CURL_HTTP_VERSION_2
 - http: drop support for curl < 7.18.0 (again)
 - Makefile: drop support for curl < 7.9.8 (again)
 - INSTALL: mention that we need libcurl 7.19.4 or newer to build
 - INSTALL: don't mention the "curl" executable at all

 Conditional compilation around versions of libcURL has been
 straightened out.


* ds/mergies-with-sparse-index (2021-09-09) 6 commits
 - sparse-index: integrate with cherry-pick and rebase
 - sequencer: ensure full index if not ORT strategy
 - t1092: add cherry-pick, rebase tests
 - merge-ort: expand only for out-of-cone conflicts
 - merge: make sparse-aware with ORT
 - diff: ignore sparse paths in diffstat
 (this branch uses ds/sparse-index-ignored-files.)

 Various mergy operations have been prepared to work efficiently
 with the sparse index.

 Will merge to 'next'.


* jk/http-backend-handle-proto-header (2021-09-09) 1 commit
 - http-backend: handle HTTP_GIT_PROTOCOL CGI variable

 Taking advantage of the CGI interface, http-backend has been
 updated to enable protocol v2 automatically when the other side
 asks for it.

 Will merge to 'next'.


* js/run-command-close-packs (2021-09-09) 4 commits
 - Close object store closer to spawning child processes
 - run_auto_maintenance(): implicitly close the object store
 - run-command: offer to close the object store before running
 - run-command: prettify the `RUN_COMMAND_*` flags
 (this branch uses js/pull-release-packs-before-fetching.)

 The run-command API has been updated so that the callers can easily
 ask the file descriptors open for packfiles to be closed immediately
 before spawning commands that may trigger auto-gc.

 Will merge to 'next'.


* jt/add-submodule-odb-clean-up (2021-09-09) 3 commits
 - revision: remove "submodule" from opt struct
 - repository: support unabsorbed in repo_submodule_init
 - submodule: remove unnecessary unabsorbed fallback
 (this branch uses jt/grep-wo-submodule-odb-as-alternate.)

 More code paths that uses the hack to add submodule's object
 database to the set of alternate object store have been cleaned up.


* jx/ci-l10n (2021-09-09) 1 commit
 - ci: new github-action for git-l10n code review

 CI help for l10n.


* jk/t5562-racefix (2021-09-09) 1 commit
 - t5562: use alarm() to interrupt timed child-wait

 Test update.

 Will merge to 'next'.


* rs/no-mode-to-open-when-appending (2021-09-09) 1 commit
 - refs/files-backend: remove unused open mode parameter

 The "mode" word is useless in a call to open(2) that does not
 create a new file.  Such a call in the files backend of the ref
 subsystem has been cleaned up.

 Will merge to 'next'.


* rs/setup-use-xopen-and-xdup (2021-09-09) 1 commit
 - setup: use xopen and xdup in sanitize_stdfds

 Code clean-up.

 Will merge to 'next'.


* rs/use-xopen-in-index-pack (2021-09-10) 1 commit
 - index-pack: use xopen in init_thread

--------------------------------------------------
[Stalled]

* ab/pack-objects-stdin (2021-07-09) 5 commits
 - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
 - pack-objects.c: do stdin parsing via revision.c's API
 - revision.[ch]: add a "handle_stdin_line" API
 - revision.h: refactor "disable_stdin" and "read_from_stdin"
 - upload-pack: run is_repository_shallow() before setup_revisions()

 Introduce handle_stdin_line callback to revision API and uses it.

 Waiting for reviews.


* es/config-based-hooks (2021-09-09) 6 commits
 - hook: allow out-of-repo 'git hook' invocations
 - hook: include hooks from the config
 - hook: introduce "git hook list"
 - hook: allow parallel hook execution
 - fixup! hook: run a list of hooks instead
 - hook: run a list of hooks instead
 (this branch uses ab/config-based-hooks-base.)

 Revamp the hooks subsystem to allow multiple of them to trigger
 upon the same event and control via the configuration variables.

 On hold.
 This is an interim one that goes with the updated ab/config-based-hooks-=
base.


* jh/builtin-fsmonitor (2021-09-03) 37 commits
 - fixup! fsmonitor--daemon: implement handle_client callback
 - SQUASH??? https://github.com/git/git/runs/3438543601?check_suite_focus=
=3Dtrue#step:5:136
 - BANDAID: sparse fixes
 - t7527: test FS event reporing on MacOS WRT case and Unicode
 - fsmonitor: handle shortname for .git
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - fsmonitor: force update index after large responses
 - fsmonitor: enhance existing comments
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon: periodically truncate list of modified files
 - t7527: create test for fsmonitor--daemon
 - t/perf/p7519: add fsmonitor--daemon test cases
 - t/perf: avoid copying builtin fsmonitor files into test repo
 - t/perf/p7519: speed up test using "test-tool touch"
 - t/helper/test-touch: add helper to touch a series of files
 - fsmonitor--daemon: implement handle_client callback
 - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
 - fsmonitor-fs-listen-macos: add macos header files for FSEvent
 - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
 - fsmonitor--daemon: create token-based changed path cache
 - fsmonitor--daemon: define token-ids
 - fsmonitor--daemon: add pathname classification
 - fsmonitor: do not try to operate on bare repos
 - fsmonitor--daemon: implement 'start' command
 - fsmonitor--daemon: implement 'run' command
 - fsmonitor-fs-listen-macos: stub in backend for MacOS
 - fsmonitor-fs-listen-win32: stub in backend for Windows
 - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daem=
on
 - fsmonitor--daemon: implement 'stop' and 'status' commands
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: use IPC to query the builtin FSMonitor daemon
 - fsmonitor: config settings are repository-specific
 - help: include fsmonitor--daemon feature flag in version info
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - fsmonitor--daemon: update fsmonitor documentation
 - fsmonitor--daemon: man page
 - simple-ipc: preparations for supporting binary messages.

 An attempt to write and ship with a watchman equivalent tailored
 for our use.

 Expecting a reroll post 2.33 release.


* es/superproject-aware-submodules (2021-08-19) 5 commits
 - fixup! introduce submodule.superprojectGitDir record
 - submodule: record superproject gitdir during 'update'
 - submodule: record superproject gitdir during absorbgitdirs
 - introduce submodule.superprojectGitDir record
 - t7400-submodule-basic: modernize inspect() helper

 A configuration variable in a submodule points at the location of
 the superproject it is bound to (RFC).

 Looking good.


* en/zdiff3 (2021-06-15) 2 commits
 - update documentation for new zdiff3 conflictStyle
 - xdiff: implement a zealous diff3, or "zdiff3"

 "Zealous diff3" style of merge conflict presentation has been added.

 Expecting a reroll.
 cf. <CABPp-BE7-E03+x38EK-=3DAE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.co=
m>


* ao/p4-avoid-decoding (2021-04-12) 2 commits
 - git-p4: do not decode data from perforce by default
 - git-p4: avoid decoding more data from perforce

 "git p4" in Python-2 days used to accept a lot more kinds of data
 from Perforce server as uninterrupted byte sequence, but after
 switching to Python-3, too many things are expected to be in UTF-8,
 which broke traditional use cases.

 Will discard.
 Have been stalled for too long.
 cf. <20210504220153.1d9f0cb2@ado-tr>


* tv/p4-fallback-encoding (2021-04-30) 1 commit
 - git-p4: git-p4.fallbackEncoding to specify non UTF-8 charset

 "git p4" learns the fallbackEncoding configuration variable to
 safely accept changeset descriptions that aren't written in UTF-8.

 Will discard.
 Have been stalled for too long.
 cf. <CAKu1iLUaLuAZWqjNK4tfhhR=3DYaSt4MdQ+90ZY-JcEh_SeHyYCw@mail.gmail.co=
m>


* ab/fsck-unexpected-type (2021-09-07) 22 commits
 - fsck: report invalid object type-path combinations
 - fsck: report invalid types recorded in objects
 - object-store.h: move read_loose_object() below 'struct object_info'
 - fsck: don't hard die on invalid object types
 - object-file.c: use "enum" return type for unpack_loose_header()
 - object-file.c: return -2 on "header too long" in unpack_loose_header()
 - object-file.c: return -1, not "status" from unpack_loose_header()
 - object-file.c: guard against future bugs in loose_object_info()
 - object-file.c: stop dying in parse_loose_header()
 - object-file.c: split up ternary in parse_loose_header()
 - object-file.c: simplify unpack_loose_short_header()
 - object-file.c: add missing braces to loose_object_info()
 - object-file.c: make parse_loose_header_extended() public
 - object-file.c: don't set "typep" when returning non-zero
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

 Needs review.

--------------------------------------------------
[Cooking]

* bs/install-strip (2021-09-05) 1 commit
  (merged to 'next' on 2021-09-08 at 40cfa71c8d)
 + make: add INSTALL_STRIP option variable

 "make INSTALL_STRIP=3D-s install" allows the installation step to use
 "install -s" to strip the binaries as they get installed.

 Will merge to 'master'.


* cb/pedantic-build-for-developers (2021-09-03) 3 commits
  (merged to 'next' on 2021-09-10 at b8df102019)
 + developer: enable pedantic by default
 + win32: allow building with pedantic mode enabled
 + gettext: remove optional non-standard parens in N_() definition

 Update the build procedure to use the "-pedantic" build when
 DEVELOPER makefile macro is in effect.

 Will merge to 'master'.


* js/scalar (2021-09-08) 15 commits
 - scalar: accept -C and -c options before the subcommand
 - scalar: implement the `version` command
 - scalar: implement the `delete` command
 - scalar: teach 'reconfigure' to optionally handle all registered enlist=
ments
 - scalar: allow reconfiguring an existing enlistment
 - scalar: implement the `run` command
 - scalar: teach 'clone' to support the --single-branch option
 - scalar: implement the `clone` subcommand
 - scalar: implement 'scalar list'
 - scalar: let 'unregister' handle a deleted enlistment directory gracefu=
lly
 - scalar: 'unregister' stops background maintenance
 - scalar: 'register' sets recommended config and starts maintenance
 - scalar: create test infrastructure
 - scalar: start documenting the command
 - scalar: create a rudimentary executable

 Add pieces from "scalar" to contrib/.


* ps/update-ref-batch-flush (2021-09-03) 1 commit
  (merged to 'next' on 2021-09-10 at 4ae19a5f34)
 + update-ref: fix streaming of status updates

 "git update-ref --stdin" failed to flush its output as needed,
 which potentially led the conversation to a deadlock.

 Will merge to 'master'.


* ab/no-more-check-bindir (2021-09-07) 1 commit
  (merged to 'next' on 2021-09-08 at 4fddb3864f)
 + Makefile: remove the check_bindir script

 Build simplification.

 Will merge to 'master'.


* ab/send-email-config-fix (2021-09-07) 1 commit
  (merged to 'next' on 2021-09-08 at c2000e9689)
 + send-email: fix a "first config key wins" regression in v2.33.0

 Regression fix.

 Will merge to 'master'.


* ab/tr2-leaks-and-fixes (2021-09-07) 6 commits
  (merged to 'next' on 2021-09-10 at 14f0dd5580)
 + tr2: log N parent process names on Linux
 + tr2: do compiler enum check in trace2_collect_process_info()
 + tr2: leave the parent list empty upon failure & don't leak memory
 + tr2: stop leaking "thread_name" memory
 + tr2: clarify TRACE2_PROCESS_INFO_EXIT comment under Linux
 + tr2: remove NEEDSWORK comment for "non-procfs" implementations

 The tracing of process ancestry information has been enhanced.

 Will merge to 'master'.


* bs/doc-bugreport-outdir (2021-09-07) 1 commit
  (merged to 'next' on 2021-09-08 at 5ea3df204d)
 + Documentation: fix default directory of git bugreport -o

 Docfix.

 Will merge to 'master'.


* jc/prefix-filename-allocates (2021-09-07) 1 commit
  (merged to 'next' on 2021-09-10 at a5221ea92e)
 + hash-object: prefix_filename() returns allocated memory these days

 Leakfix.

 Will merge to 'master'.


* kr/doc-webserver-config-for-v2 (2021-09-07) 1 commit
 - Docs: web server must setenv GIT_PROTOCOL for v2

 Hints to set GIT_PROTOCOL environment in various CGI environments
 are added to the documentation.

 Will discard.


* rs/range-diff-avoid-segfault-with-I (2021-09-07) 1 commit
  (merged to 'next' on 2021-09-10 at e8bac5f9ea)
 + range-diff: avoid segfault with -I

 "git range-diff -I... <range> <range>" segfaulted, which has been
 corrected.

 Will merge to 'master'.


* so/diff-index-regression-fix (2021-09-07) 1 commit
  (merged to 'next' on 2021-09-08 at ca17912ed3)
 + diff-index: restore -c/--cc options handling

 Recent "diff -m" changes broke "gitk", which has been corrected.

 Will merge to 'master'.


* tb/pack-finalize-ordering (2021-09-09) 9 commits
  (merged to 'next' on 2021-09-10 at 7b39c39e31)
 + pack-objects: rename .idx files into place after .bitmap files
 + pack-write: split up finish_tmp_packfile() function
 + builtin/index-pack.c: move `.idx` files into place last
 + index-pack: refactor renaming in final()
 + builtin/repack.c: move `.idx` files into place last
 + pack-write.c: rename `.idx` files after `*.rev`
 + pack-write: refactor renaming in finish_tmp_packfile()
 + bulk-checkin.c: store checksum directly
 + pack.h: line-wrap the definition of finish_tmp_packfile()

 The order in which various files that make up a single (conceptual)
 packfile has been reevaluated and straightened up.  This matters in
 correctness, as an incomplete set of files must not be shown to a
 running Git.

 Will merge to 'master'.


* ab/reverse-midx-optim (2021-09-07) 1 commit
  (merged to 'next' on 2021-09-08 at 1972c5931b)
 + pack-write: skip *.rev work when not writing *.rev

 The code that optionally creates the *.rev reverse index file has
 been optimized to avoid needless computation when it is not writing
 the file out.

 Will merge to 'master'.


* ab/sanitize-leak-ci (2021-09-07) 3 commits
 - tests: add a test mode for SANITIZE=3Dleak, run it in CI
 - CI: refactor "if" to "case" statement
 - Makefile: add SANITIZE=3Dleak flag to GIT-BUILD-OPTIONS

 CI learns to run the leak sanitizer builds.

 Will merge to 'next'?


* jc/trivial-threeway-binary-merge (2021-09-05) 1 commit
  (merged to 'next' on 2021-09-08 at d6ba0735d8)
 + apply: resolve trivial merge without hitting ll-merge with "--3way"

 The "git apply -3" code path learned not to bother the lower level
 merge machinery when the three-way merge can be trivially resolved
 without the content level merge.

 Will merge to 'master'.


* ms/customizable-ident-expansion (2021-09-01) 1 commit
 - keyword expansion: make "$Id$" string configurable

 Instead of "$Id$", user-specified string (like $FreeBSD$) can be
 used as an in-blob placeholder for keyword expansion.


* pb/test-use-user-env (2021-09-07) 3 commits
  (merged to 'next' on 2021-09-08 at 6fa5d96723)
 + test-lib-functions: keep user's debugger config files and TERM in 'deb=
ug'
 + test-lib-functions: optionally keep HOME, TERM and SHELL in 'test_paus=
e'
 + test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'

 Teach "test_pause" and "debug" helpers to allow using the HOME and
 TERM environment variables the user usually uses.

 Will merge to 'master'.


* js/retire-preserve-merges (2021-09-07) 11 commits
  (merged to 'next' on 2021-09-10 at f645ffd7a3)
 + sequencer: restrict scope of a formerly public function
 + rebase: remove a no-longer-used function
 + rebase: stop mentioning the -p option in comments
 + rebase: remove obsolete code comment
 + rebase: drop the internal `rebase--interactive` command
 + git-svn: drop support for `--preserve-merges`
 + rebase: drop support for `--preserve-merges`
 + pull: remove support for `--rebase=3Dpreserve`
 + tests: stop testing `git rebase --preserve-merges`
 + remote: warn about unhandled branch.<name>.rebase values
 + t5520: do not use `pull.rebase=3Dpreserve`

 The "--preserve-merges" option of "git rebase" has been removed.

 Will merge to 'master'.


* mr/bisect-in-c-4 (2021-09-02) 6 commits
 - bisect--helper: retire `--bisect-next-check` subcommand
 - bisect--helper: reimplement `bisect_run` shell
 - bisect--helper: reimplement `bisect_visualize()`shell function in C
 - run-command: make `exists_in_PATH()` non-static
 - t6030-bisect-porcelain: add test for bisect visualize
 - t6030-bisect-porcelain: add tests to control bisect run exit cases

 Rewrite of "git bisect" in C continues.

 Expecting a reroll.
 cf. <xmqqtuj2h7cp.fsf@gitster.g>


* en/remerge-diff (2021-08-31) 7 commits
 - doc/diff-options: explain the new --remerge-diff option
 - show, log: provide a --remerge-diff capability
 - tmp-objdir: new API for creating and removing primary object dirs
 - merge-ort: capture and print ll-merge warnings in our preferred fashio=
n
 - ll-merge: add API for capturing warnings in a strbuf instead of stderr
 - merge-ort: add ability to record conflict messages in a file
 - merge-ort: mark a few more conflict messages as omittable

 A new presentation for two-parent merge "--remerge-diff" can be
 used to show the difference between mechanical (and possibly
 conflicted) merge results and the recorded resolution.

 What's the status of this one?


* sg/test-split-index-fix (2021-09-07) 7 commits
 - read-cache: fix GIT_TEST_SPLIT_INDEX
 - tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
 - read-cache: look for shared index files next to the index, too
 - t1600-index: disable GIT_TEST_SPLIT_INDEX
 - t1600-index: don't run git commands upstream of a pipe
 - t1600-index: remove unnecessary redirection
 - Merge branch 'ds/sparse-index-ignored-files' into sg/test-split-index-=
fix
 (this branch uses ds/sparse-index-ignored-files.)

 Test updates.


* ab/refs-errno-cleanup (2021-08-25) 4 commits
 - refs: make errno output explicit for refs_resolve_ref_unsafe
 - refs: explicitly return failure_errno from parse_loose_ref_contents
 - branch tests: test for errno propagating on failing read
 - refs: add failure_errno to refs_read_raw_ref() signature
 (this branch uses ab/refs-files-cleanup and hn/refs-errno-cleanup.)

 The "remainder" of hn/refs-errno-cleanup topic.


* jv/pkt-line-batch (2021-09-01) 2 commits
  (merged to 'next' on 2021-09-10 at c31d871c9a)
 + upload-pack: use stdio in send_ref callbacks
 + pkt-line: add stdio packet write functions

 Reduce number of write(2) system calls while sending the
 ref advertisement.

 Will merge to 'master'.


* ab/unbundle-progress (2021-09-07) 4 commits
 - bundle: show progress on "unbundle"
 - index-pack: add --progress-title option
 - bundle API: change "flags" to be "extra_index_pack_args"
 - bundle API: start writing API documentation

 Add progress display to "git bundle unbundle".

 Will merge to 'next'.


* lh/systemd-timers (2021-09-07) 3 commits
  (merged to 'next' on 2021-09-10 at b27d72031a)
 + maintenance: add support for systemd timers on Linux
 + maintenance: `git maintenance run` learned `--scheduler=3D<scheduler>`
 + cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" function

 "git maintenance" scheduler learned to use systemd timers as a
 possible backend.

 Will merge to 'master'.


* ps/fetch-optim (2021-09-01) 7 commits
  (merged to 'next' on 2021-09-08 at 99f865125d)
 + fetch: avoid second connectivity check if we already have all objects
 + fetch: merge fetching and consuming refs
 + fetch: refactor fetch refs to be more extendable
 + fetch-pack: optimize loading of refs via commit graph
 + connected: refactor iterator to return next object ID directly
 + fetch: avoid unpacking headers in object existence check
 + fetch: speed up lookup of want refs via commit-graph

 Optimize code that handles large number of refs in the "git fetch"
 code path.

 Will merge to 'master'.


* ar/submodule-run-update-procedure (2021-08-24) 1 commit
 - submodule--helper: run update procedures from C

 Reimplementation of parts of "git submodule" in C continues.

 Will merge to 'next'.


* ds/sparse-index-ignored-files (2021-09-07) 10 commits
 - sparse-checkout: clear tracked sparse dirs
 - sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
 - attr: be careful about sparse directories
 - sparse-checkout: create helper methods
 - sparse-index: use WRITE_TREE_MISSING_OK
 - sparse-index: silently return when cache tree fails
 - unpack-trees: fix nested sparse-dir search
 - sparse-index: silently return when not using cone-mode patterns
 - t7519: rewrite sparse index test
 - Merge branch 'ds/add-with-sparse-index' into ds/sparse-index-ignored-f=
iles
 (this branch is used by ds/mergies-with-sparse-index and sg/test-split-i=
ndex-fix.)

 In cone mode, the sparse-index codepath learned to remove ignored
 files (like build artifacts) outside the sparse cone, allowing the
 entire directory outside the sparse cone to be removed, which is
 especially useful when the sparse patterns change.

 Will merge to 'next'.


* jt/grep-wo-submodule-odb-as-alternate (2021-09-08) 8 commits
  (merged to 'next' on 2021-09-08 at 67612d0b7f)
 + t7814: show lack of alternate ODB-adding
 + submodule-config: pass repo upon blob config read
 + grep: add repository to OID grep sources
 + grep: allocate subrepos on heap
 + grep: read submodule entry with explicit repo
 + grep: typesafe versions of grep_source_init
 + grep: use submodule-ODB-as-alternate lazy-addition
 + submodule: lazily add submodule ODBs as alternates
 (this branch is used by jt/add-submodule-odb-clean-up.)

 The code to make "git grep" recurse into submodules has been
 updated to migrate away from the "add submodule's object store as
 an alternate object store" mechanism (which is suboptimal).

 Will merge to 'master'.


* ar/submodule-add-more (2021-08-10) 10 commits
 - submodule--helper: rename compute_submodule_clone_url()
 - submodule--helper: remove resolve-relative-url subcommand
 - submodule--helper: remove add-config subcommand
 - submodule--helper: remove add-clone subcommand
 - submodule--helper: convert the bulk of cmd_add() to C
 - dir: libify and export helper functions from clone.c
 - submodule--helper: remove repeated code in sync_submodule()
 - submodule--helper: refactor resolve_relative_url() helper
 - submodule--helper: add options for compute_submodule_clone_url()
 - Merge branch 'ar/submodule-add-config' into ar/submodule-add
 (this branch uses ar/submodule-add-config.)

 More parts of "git submodule add" has been rewritten in C.

 Will merge to 'next'.


* ab/lib-subtest (2021-08-05) 11 commits
 - test-lib tests: assert 1 exit code, not non-zero
 - test-lib tests: refactor common part of check_sub_test_lib_test*()
 - test-lib tests: avoid subshell for "test_cmp" for readability
 - test-lib tests: assert no copy/pasted mock test code
 - test-lib tests: get rid of copy/pasted mock test code
 - test-lib tests: don't provide a description for the sub-tests
 - test-lib tests: stop using a subshell in write_sub_test_lib_test()
 - test-lib tests: split up "write and run" into two functions
 - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
 - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
 - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest

 Updates to the tests in t0000 to test the test framework.


* ab/only-single-progress-at-once (2021-07-23) 8 commits
 - progress.c: add & assert a "global_progress" variable
 - pack-bitmap-write.c: add a missing stop_progress()
 - progress.c: add temporary variable from progress struct
 - progress.c: stop eagerly fflush(stderr) when not a terminal
 - progress.c: call progress_interval() from progress_test_force_update()
 - progress.c: move signal handler functions lower
 - progress.c tests: test some invalid usage
 - progress.c tests: make start/stop verbs on stdin

 Further tweaks on progress API.

 On hold.
 cf. <20210901050406.GB76263@szeder.dev>


* ab/progress-users-adjust-counters (2021-09-09) 2 commits
  (merged to 'next' on 2021-09-10 at b50c37aa44)
 + entry: show finer-grained counter in "Filtering content" progress line
 + commit-graph: fix bogus counter in "Scanning merged commits" progress =
line

 The code to show progress indicator in a few codepaths did not
 cover between 0-100%, which has been corrected.

 Will merge to 'master'.


* ar/submodule-add-config (2021-08-10) 1 commit
 - submodule--helper: introduce add-config subcommand
 (this branch is used by ar/submodule-add-more.)

 Large part of "git submodule add" gets rewritten in C.

 Will merge to 'next'.


* dt/submodule-diff-fixes (2021-08-31) 3 commits
  (merged to 'next' on 2021-09-10 at 21b773f4fe)
 + diff --submodule=3Ddiff: don't print failure message twice
 + diff --submodule=3Ddiff: do not fail on ever-initialied deleted submod=
ules
 + t4060: remove unused variable

 "git diff --submodule=3Ddiff" showed failure from run_command() when
 trying to run diff inside a submodule, when the user manually
 removes the submodule directory.

 Will merge to 'master'.


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


* ab/make-tags-cleanup (2021-08-05) 5 commits
 - Makefile: normalize clobbering & xargs for tags targets
 - Makefile: remove "cscope.out", not "cscope*" in cscope.out target
 - Makefile: don't use "FORCE" for tags targets
 - Makefile: add QUIET_GEN to "cscope" target
 - Makefile: move ".PHONY: cscope" near its target

 Build clean-up for "make tags" and friends.

 Will merge to 'next'.


* tb/multi-pack-bitmaps (2021-09-09) 29 commits
  (merged to 'next' on 2021-09-10 at 71559ef435)
 + pack-bitmap: drop bitmap_index argument from try_partial_reuse()
 + pack-bitmap: drop repository argument from prepare_midx_bitmap_git()
  (merged to 'next' on 2021-09-08 at f2b7415bd8)
 + p5326: perf tests for MIDX bitmaps
 + p5310: extract full and partial bitmap tests
 + midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 + t7700: update to work with MIDX bitmap test knob
 + t5319: don't write MIDX bitmaps in t5319
 + t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 + t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 + t5326: test multi-pack bitmap behavior
 + t/helper/test-read-midx.c: add --checksum mode
 + t5310: move some tests to lib-bitmap.sh
 + pack-bitmap: write multi-pack bitmaps
 + pack-bitmap: read multi-pack bitmaps
 + pack-bitmap.c: avoid redundant calls to try_partial_reuse
 + pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
 + pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
 + pack-bitmap.c: introduce 'bitmap_num_objects()'
 + midx: avoid opening multiple MIDXs when writing
 + midx: close linked MIDXs, avoid leaking memory
 + midx: infer preferred pack when not given one
 + midx: reject empty `--preferred-pack`'s
 + midx: clear auxiliary .rev after replacing the MIDX
 + midx: fix `*.rev` cleanups with `--object-dir`
 + midx: disallow running outside of a repository
 + Documentation: describe MIDX-based bitmaps
 + pack-bitmap-write.c: free existing bitmaps
 + pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
 + pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps

 The reachability bitmap file used to be generated only for a single
 pack, but now we've learned to generate bitmaps for history that
 span across multiple packfiles.

 Will merge to 'master'.


* ab/config-based-hooks-base (2021-09-09) 36 commits
 - hooks: fix a TOCTOU in "did we run a hook?" heuristic
 - receive-pack: convert receive hooks to hook.h
 - post-update: use hook.h library
 - receive-pack: convert 'update' hook to hook.h
 - hooks: allow callers to capture output
 - run-command: allow capturing of collated output
 - reference-transaction: use hook.h to run hooks
 - hook tests: use a modern style for "pre-push" tests
 - hook tests: test for exact "pre-push" hook input
 - transport: convert pre-push hook to hook.h
 - hook: convert 'post-rewrite' hook in sequencer.c to hook.h
 - hook: provide stdin by string_list or callback
 - run-command: add stdin callback for parallelization
 - am: convert 'post-rewrite' hook to hook.h
 - hook: support passing stdin to hooks
 - run-command: allow stdin for run_processes_parallel
 - run-command: remove old run_hook_{le,ve}() hook API
 - receive-pack: convert push-to-checkout hook to hook.h
 - read-cache: convert post-index-change to use hook.h
 - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
 - git-p4: use 'git hook' to run hooks
 - send-email: use 'git hook run' for 'sendemail-validate'
 - git hook run: add an --ignore-missing flag
 - merge: convert post-merge to use hook.h
 - hooks: convert 'post-checkout' hook to hook library
 - am: convert applypatch to use hook.h
 - rebase: convert pre-rebase to use hook.h
 - gc: use hook library for pre-auto-gc hook
 - hook: add 'run' subcommand
 - hook-list.h: add a generated list of hooks, like config-list.h
 - hook.c users: use "hook_exists()" instead of "find_hook()"
 - hook.c: add a hook_exists() wrapper and use it in bugreport.c
 - hook.[ch]: move find_hook() from run-command.c to hook.c
 - Makefile: remove an out-of-date comment
 - Makefile: stop hardcoding {command,config}-list.h
 - Makefile: mark "check" target as .PHONY
 (this branch is used by es/config-based-hooks.)

 Restructuring of (a subset of) Emily's config-based-hooks series,
 to demonstrate that a series can be presented as a more logical and
 focused progression.

 Waiting for reviews.


* ab/serve-cleanup (2021-08-05) 10 commits
 - upload-pack: document and rename --advertise-refs
 - serve.[ch]: remove "serve_options", split up --advertise-refs code
 - {upload,receive}-pack tests: add --advertise-refs tests
 - serve.c: move version line to advertise_capabilities()
 - serve: move transfer.advertiseSID check into session_id_advertise()
 - serve.[ch]: don't pass "struct strvec *keys" to commands
 - serve: use designated initializers
 - transport: use designated initializers
 - transport: rename "fetch" in transport_vtable to "fetch_refs"
 - serve: mark has_capability() as static

 Code clean-up around "git serve".

 Will merge to 'next'.


* pw/diff-color-moved-fix (2021-08-05) 13 commits
 - diff: drop unused options parameter from cmp_in_block_with_wsd()
 - diff --color-moved: intern strings
 - diff: use designated initializers for emitted_diff_symbol
 - diff --color-moved-ws=3Dallow-indentation-change: improve hash lookups
 - diff --color-moved: stop clearing potential moved blocks
 - diff --color-moved: shrink potential moved blocks as we go
 - diff --color-moved: unify moved block growth functions
 - diff --color-moved: call comparison function directly
 - diff --color-moved-ws=3Dallow-indentation-change: simplify and optimiz=
e
 - diff: simplify allow-indentation-change delta calculation
 - diff --color-moved: avoid false short line matches and bad zerba color=
ing
 - diff --color-moved=3Dzebra: fix alternate coloring
 - diff --color-moved: add perf tests

 Originally merged to 'next' on 2021-08-05

 Long-overdue correctness and performance update to "diff
 --color-moved" feature.

 Expecting a reroll.
 cf. <8bec1a6d-5052-50c3-4100-e6348289d581@gmail.com>


* hn/reftable (2021-09-10) 20 commits
 - fixup! reftable: implement stack, a mutable database of reftable files=
.
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


* ab/refs-files-cleanup (2021-08-25) 13 commits
 - refs/files: remove unused "errno !=3D ENOTDIR" condition
 - refs/files: remove unused "errno =3D=3D EISDIR" code
 - refs/files: remove unused "oid" in lock_ref_oid_basic()
 - refs API: remove OID argument to reflog_expire()
 - reflog expire: don't lock reflogs using previously seen OID
 - refs/files: add a comment about refs_reflog_exists() call
 - refs: make repo_dwim_log() accept a NULL oid
 - refs/debug: re-indent argument list for "prepare"
 - refs/files: remove unused "skip" in lock_raw_ref() too
 - refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
 - refs: drop unused "flags" parameter to lock_ref_oid_basic()
 - refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
 - refs/packet: add missing BUG() invocations to reflog callbacks
 (this branch is used by ab/refs-errno-cleanup and hn/refs-errno-cleanup.=
)

 Continued work on top of the hn/refs-errno-cleanup topic.


* hn/refs-errno-cleanup (2021-08-25) 4 commits
 - refs: make errno output explicit for read_raw_ref_fn
 - refs/files-backend: stop setting errno from lock_ref_oid_basic
 - refs: remove EINVAL errno output from specification of read_raw_ref_fn
 - refs file backend: move raceproof_create_file() here
 (this branch is used by ab/refs-errno-cleanup; uses ab/refs-files-cleanu=
p.)

 Futz with the way 'errno' is relied on in the refs API to carry the
 failure modes up the callchain.

--------------------------------------------------
[Discarded]

* np/blame-ignore-revs-file-may-be-optional (2021-08-09) 1 commit
 - blame: add config `blame.ignoreRevsFileIsOptional`

 When the file named by blame.ignoreRevsFile configuration variable
 does not exist, it causes "git blame" to die.  Sometimes, it is
 useful if the files named by configuration variables can be made
 optional (it would allow ~/.gitconfig to give a filename, and make
 it effective only in repositories that have a file with that name).

 This uses an extra variable that marks that the variable is
 optional.  Yet another alternative is being discussed to define
 syntax for "optional" filename values, so that the same mechanism
 can be used for not just blame.ignoreRevsFile but other filenames.

 Queued just as a reminder of the theme.


* ab/test-tool-cache-cleanup (2021-08-24) 4 commits
 - read-cache perf: add a perf test for refresh_index()
 - test-tool: migrate read-cache-again to parse_options()
 - test-tool: migrate read-cache-perf to parse_options()
 - test-tool: split up test-tool read-cache

 Test code shuffling.

 Discarded.
 cf. <87tuj7xhqo.fsf@evledraar.gmail.com>

 * ow/clone-bare-origin (2021-08-03) 1 commit
 - clone: Allow combining --bare and --origin

 "git clone" did not like to take "--bare" and "--origin=3DX" at the
 same time; loosen the restriction.

 cf. <20210802174944.53745-1-oystwa@gmail.com>
