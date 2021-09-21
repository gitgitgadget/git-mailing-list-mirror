Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD64EC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 00:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA4A6124A
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 00:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbhIUAFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 20:05:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60614 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhIUADd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 20:03:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8CE414A5DB;
        Mon, 20 Sep 2021 20:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=3TVGFbTgHFw+i0IobdkpaCbQP
        DghC9dEi/Z2E+kLX5U=; b=ADvk3JCdeH3wZBcsdlNl+05SOHX/zCs4ZnCPWFPaF
        F1ahLH3z5j5t/SVWXSkq5Wqc83yjzP9ZXaSlgm3ffAY8R9SKYvP4r6VXFzenoGq9
        zpHx5ukXewojOhaFzUPg8Or0e5406EuebrfWNGu6NRTLTi74GxRKrHwiVW4dSAt+
        fw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B23A714A5DA;
        Mon, 20 Sep 2021 20:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F22ED14A5D9;
        Mon, 20 Sep 2021 20:02:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2021, #06; Mon, 20)
X-master-at: 99c99ed8259bf070cd8ae7b51a94904b7cf5c161
X-next-at: d22421fcc6e5254ac802caac9a2af0b5cf0fb5d7
Date:   Mon, 20 Sep 2021 17:02:00 -0700
Message-ID: <xmqq1r5iaj9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 266D84A2-1A6F-11EC-8DFE-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
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

The seventh batch is out.

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

* ab/make-tags-cleanup (2021-08-05) 5 commits
  (merged to 'next' on 2021-09-12 at 79584f3c60)
 + Makefile: normalize clobbering & xargs for tags targets
 + Makefile: remove "cscope.out", not "cscope*" in cscope.out target
 + Makefile: don't use "FORCE" for tags targets
 + Makefile: add QUIET_GEN to "cscope" target
 + Makefile: move ".PHONY: cscope" near its target

 Build clean-up for "make tags" and friends.


* ab/progress-users-adjust-counters (2021-09-09) 2 commits
  (merged to 'next' on 2021-09-10 at b50c37aa44)
 + entry: show finer-grained counter in "Filtering content" progress line
 + commit-graph: fix bogus counter in "Scanning merged commits" progress =
line

 The code to show progress indicator in a few code paths did not
 cover between 0-100%, which has been corrected.


* ab/serve-cleanup (2021-08-05) 10 commits
  (merged to 'next' on 2021-09-12 at ea87ede873)
 + upload-pack: document and rename --advertise-refs
 + serve.[ch]: remove "serve_options", split up --advertise-refs code
 + {upload,receive}-pack tests: add --advertise-refs tests
 + serve.c: move version line to advertise_capabilities()
 + serve: move transfer.advertiseSID check into session_id_advertise()
 + serve.[ch]: don't pass "struct strvec *keys" to commands
 + serve: use designated initializers
 + transport: use designated initializers
 + transport: rename "fetch" in transport_vtable to "fetch_refs"
 + serve: mark has_capability() as static
 (this branch is used by jk/reduce-malloc-in-v2-servers.)

 Code clean-up around "git serve".


* ab/tr2-leaks-and-fixes (2021-09-07) 6 commits
  (merged to 'next' on 2021-09-10 at 14f0dd5580)
 + tr2: log N parent process names on Linux
 + tr2: do compiler enum check in trace2_collect_process_info()
 + tr2: leave the parent list empty upon failure & don't leak memory
 + tr2: stop leaking "thread_name" memory
 + tr2: clarify TRACE2_PROCESS_INFO_EXIT comment under Linux
 + tr2: remove NEEDSWORK comment for "non-procfs" implementations

 The tracing of process ancestry information has been enhanced.


* ab/unbundle-progress (2021-09-07) 4 commits
  (merged to 'next' on 2021-09-12 at d7bacb391e)
 + bundle: show progress on "unbundle"
 + index-pack: add --progress-title option
 + bundle API: change "flags" to be "extra_index_pack_args"
 + bundle API: start writing API documentation

 Add progress display to "git bundle unbundle".


* ar/submodule-add-config (2021-08-10) 1 commit
  (merged to 'next' on 2021-09-12 at fdabb4f0fc)
 + submodule--helper: introduce add-config subcommand
 (this branch is used by ar/submodule-add-more.)

 Large part of "git submodule add" gets rewritten in C.


* ar/submodule-add-more (2021-08-10) 10 commits
  (merged to 'next' on 2021-09-12 at efebf6dad3)
 + submodule--helper: rename compute_submodule_clone_url()
 + submodule--helper: remove resolve-relative-url subcommand
 + submodule--helper: remove add-config subcommand
 + submodule--helper: remove add-clone subcommand
 + submodule--helper: convert the bulk of cmd_add() to C
 + dir: libify and export helper functions from clone.c
 + submodule--helper: remove repeated code in sync_submodule()
 + submodule--helper: refactor resolve_relative_url() helper
 + submodule--helper: add options for compute_submodule_clone_url()
 + Merge branch 'ar/submodule-add-config' into ar/submodule-add
 (this branch uses ar/submodule-add-config.)

 More parts of "git submodule add" has been rewritten in C.


* ar/submodule-run-update-procedure (2021-08-24) 1 commit
  (merged to 'next' on 2021-09-12 at fbe417715d)
 + submodule--helper: run update procedures from C
 (this branch is used by ar/submodule-update.)

 Reimplementation of parts of "git submodule" in C continues.


* cb/pedantic-build-for-developers (2021-09-03) 3 commits
  (merged to 'next' on 2021-09-10 at b8df102019)
 + developer: enable pedantic by default
 + win32: allow building with pedantic mode enabled
 + gettext: remove optional non-standard parens in N_() definition

 Update the build procedure to use the "-pedantic" build when
 DEVELOPER makefile macro is in effect.


* ds/mergies-with-sparse-index (2021-09-09) 6 commits
  (merged to 'next' on 2021-09-12 at 1535fa2dae)
 + sparse-index: integrate with cherry-pick and rebase
 + sequencer: ensure full index if not ORT strategy
 + t1092: add cherry-pick, rebase tests
 + merge-ort: expand only for out-of-cone conflicts
 + merge: make sparse-aware with ORT
 + diff: ignore sparse paths in diffstat
 (this branch is used by ds/add-rm-with-sparse-index; uses ds/sparse-inde=
x-ignored-files.)

 Various mergy operations have been prepared to work efficiently
 with the sparse index.


* ds/sparse-index-ignored-files (2021-09-07) 10 commits
  (merged to 'next' on 2021-09-12 at 6993c73000)
 + sparse-checkout: clear tracked sparse dirs
 + sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
 + attr: be careful about sparse directories
 + sparse-checkout: create helper methods
 + sparse-index: use WRITE_TREE_MISSING_OK
 + sparse-index: silently return when cache tree fails
 + unpack-trees: fix nested sparse-dir search
 + sparse-index: silently return when not using cone-mode patterns
 + t7519: rewrite sparse index test
 + Merge branch 'ds/add-with-sparse-index' into ds/sparse-index-ignored-f=
iles
 (this branch is used by ds/add-rm-with-sparse-index, ds/mergies-with-spa=
rse-index and sg/test-split-index-fix.)

 In cone mode, the sparse-index code path learned to remove ignored
 files (like build artifacts) outside the sparse cone, allowing the
 entire directory outside the sparse cone to be removed, which is
 especially useful when the sparse patterns change.


* dt/submodule-diff-fixes (2021-08-31) 3 commits
  (merged to 'next' on 2021-09-10 at 21b773f4fe)
 + diff --submodule=3Ddiff: don't print failure message twice
 + diff --submodule=3Ddiff: do not fail on ever-initialied deleted submod=
ules
 + t4060: remove unused variable

 "git diff --submodule=3Ddiff" showed failure from run_command() when
 trying to run diff inside a submodule, when the user manually
 removes the submodule directory.


* jk/t5562-racefix (2021-09-09) 1 commit
  (merged to 'next' on 2021-09-12 at 22d4bfa14b)
 + t5562: use alarm() to interrupt timed child-wait

 Test update.


* js/pull-release-packs-before-fetching (2021-09-08) 2 commits
  (merged to 'next' on 2021-09-12 at 05cdcab392)
 + pull: release packs before fetching
 + commit-graph: when closing the graph, also release the slab
 (this branch is used by js/run-command-close-packs.)

 "git pull" was taught to close open file descriptors to the
 packfiles before spawning "git fetch" to help auto-gc that may be
 invoked by it.


* js/run-command-close-packs (2021-09-09) 4 commits
  (merged to 'next' on 2021-09-12 at 97c3614c78)
 + Close object store closer to spawning child processes
 + run_auto_maintenance(): implicitly close the object store
 + run-command: offer to close the object store before running
 + run-command: prettify the `RUN_COMMAND_*` flags
 (this branch uses js/pull-release-packs-before-fetching.)

 The run-command API has been updated so that the callers can easily
 ask the file descriptors open for packfiles to be closed immediately
 before spawning commands that may trigger auto-gc.


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


* jv/pkt-line-batch (2021-09-01) 2 commits
  (merged to 'next' on 2021-09-10 at c31d871c9a)
 + upload-pack: use stdio in send_ref callbacks
 + pkt-line: add stdio packet write functions

 Reduce number of write(2) system calls while sending the
 ref advertisement.


* lh/systemd-timers (2021-09-07) 3 commits
  (merged to 'next' on 2021-09-10 at b27d72031a)
 + maintenance: add support for systemd timers on Linux
 + maintenance: `git maintenance run` learned `--scheduler=3D<scheduler>`
 + cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" function

 "git maintenance" scheduler learned to use systemd timers as a
 possible backend.


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


* rs/no-mode-to-open-when-appending (2021-09-09) 1 commit
  (merged to 'next' on 2021-09-12 at a3ea25c5f1)
 + refs/files-backend: remove unused open mode parameter

 The "mode" word is useless in a call to open(2) that does not
 create a new file.  Such a call in the files backend of the ref
 subsystem has been cleaned up.


* rs/setup-use-xopen-and-xdup (2021-09-09) 1 commit
  (merged to 'next' on 2021-09-12 at 544b481d15)
 + setup: use xopen and xdup in sanitize_stdfds

 Code clean-up.


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
 (this branch is used by tb/midx-write-propagate-namehash and tb/repack-w=
rite-midx.)

 The reachability bitmap file used to be generated only for a single
 pack, but now we've learned to generate bitmaps for history that
 span across multiple packfiles.


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

--------------------------------------------------
[New Topics]

* ab/repo-settings-cleanup (2021-09-20) 5 commits
 - repository.h: don't use a mix of int and bitfields
 - repo-settings.c: simplify the setup
 - read-cache & fetch-negotiator: check "enum" values in switch()
 - environment.c: remove test-specific "ignore_untracked..." variable
 - wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c

 Code cleanup.

 Will merge to 'next'?
 cf. <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
 Looks like we got an implicit Ack from Derrick?


* ah/connect-parse-feature-v0-fix (2021-09-20) 1 commit
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


* da/difftool (2021-09-20) 4 commits
 - difftool: add a missing space to the run_dir_diff() comments
 - difftool: use a strbuf to create a tmpdir path without repeated slashe=
s
 - Merge branch 'da/difftool-dir-diff-symlink-fix' into da/difftool
 - Merge branch 'ab/retire-option-argument' into da/difftool
 (this branch uses ab/retire-option-argument and da/difftool-dir-diff-sym=
link-fix.)

 Code clean-up in "git difftool".


* da/difftool-dir-diff-symlink-fix (2021-09-20) 1 commit
 - difftool: fix symlink-file writing in dir-diff mode
 (this branch is used by da/difftool.)

 "git difftool --dir-diff" mishandled symbolic links.

 Will merge to 'next'.


* en/removing-untracked-fixes (2021-09-20) 7 commits
 - Documentation: call out commands that nuke untracked files/directories
 - Comment important codepaths regarding nuking untracked files/dirs
 - unpack-trees: avoid nuking untracked dir in way of locally deleted fil=
e
 - unpack-trees: avoid nuking untracked dir in way of unmerged file
 - Split unpack_trees 'reset' flag into two for untracked handling
 - t2500: add various tests for nuking untracked files
 - Merge branch 'en/am-abort-fix' into en/removing-untracked-fixes
 (this branch uses en/am-abort-fix.)

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


* tb/commit-graph-usage-fix (2021-09-20) 1 commit
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

* jk/reduce-malloc-in-v2-servers (2021-09-15) 12 commits
  (merged to 'next' on 2021-09-16 at 40cfe41efc)
 + ls-refs: reject unknown arguments
 + serve: reject commands used as capabilities
 + serve: reject bogus v2 "command=3Dls-refs=3Dfoo"
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


* jt/submodule-name-to-gitdir (2021-09-15) 1 commit
  (merged to 'next' on 2021-09-16 at c658fbfdb8)
 + submodule: extract path to submodule gitdir func

 Code refactoring.

 Will merge to 'master'.


* ma/doc-git-version (2021-09-14) 1 commit
  (merged to 'next' on 2021-09-16 at 54a6a3f8b5)
 + documentation: add documentation for 'git version'

 Doc update.

 Will merge to 'master'.


* ma/help-w-check-for-requested-page (2021-09-14) 1 commit
  (merged to 'next' on 2021-09-16 at 292dd7174d)
 + help: make sure local html page exists before calling external process=
es

 The error in "git help no-such-git-command" is handled better.

 Will merge to 'master'.


* ns/batched-fsync (2021-09-14) 5 commits
 - core.fsyncobjectfiles: performance tests for add and stash
 - update-index: use the bulk-checkin infrastructure
 - core.fsyncobjectfiles: add windows support for batch mode
 - core.fsyncobjectfiles: batched disk flushes
 - bulk-checkin: rename 'state' variable and separate 'plugged' boolean

 The "core.fsyncobjectfiles" configuration variable can now be set
 to "batch" for improved performance.

 Will merge to 'next'?


* cb/plug-leaks-in-alloca-emu-users (2021-09-16) 2 commits
  (merged to 'next' on 2021-09-16 at 2eecae2de3)
 + t0000: avoid masking git exit value through pipes
 + tree-diff: fix leak when not HAVE_ALLOCA_H

 Leakfix.

 Will merge to 'master'.


* jh/builtin-fsmonitor-part1 (2021-09-20) 7 commits
 - t/helper/simple-ipc: convert test-simple-ipc to use start_bg_command
 - run-command: create start_bg_command
 - simple-ipc/ipc-win32: add Windows ACL to named pipe
 - simple-ipc/ipc-win32: add trace2 debugging
 - simple-ipc: move definition of ipc_active_state outside of ifdef
 - simple-ipc: preparations for supporting binary messages.
 - trace2: add trace2_child_ready() to report on background children

 Built-in fsmonitor (part 1).


* kz/revindex-comment-fix (2021-09-15) 1 commit
  (merged to 'next' on 2021-09-16 at b4797add3a)
 + pack-revindex.h: correct the time complexity descriptions

 Header comment fix.

 Will merge to 'master'.


* cb/cvsserver (2021-09-16) 3 commits
 - Documentation: cleanup git-cvsserver
 - git-cvsserver: protect against NULL in crypt(3)
 - git-cvsserver: use crypt correctly to compare password hashes

 "git cvsserver" had a long-standing bug in its authentication code,
 which has finally been corrected (it is unclear and is a separate
 question if anybody is seriously using it, though).

 Will merge to 'next'.


* cb/unicode-14 (2021-09-17) 1 commit
  (merged to 'next' on 2021-09-20 at 7873b310ad)
 + unicode: update the width tables to Unicode 14

 The unicode character width table (used for output alignment) has
 been updated.

 Will merge to 'master'.


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

 Will merge to 'master'.


* ab/align-parse-options-help (2021-09-12) 4 commits
 - parse-options: properly align continued usage output
 - git rev-parse --parseopt tests: add more usagestr tests
 - send-pack: properly use parse_options() API for usage string
 - parse-options API users: align usage output in C-strings

 When "git cmd -h" shows more than one line of usage text (e.g.
 the cmd subcommand may take sub-sub-command), parse-options API
 learned to align these lines, even across i18n/l10n.

 Will merge to 'next'?


* ab/help-config-vars (2021-09-10) 6 commits
 - fixup! help / completion: make "git help" do the hard work
 - help / completion: make "git help" do the hard work
 - help: correct logic error in combining --all and --config
 - help tests: add test for --config output
 - help: correct usage & behavior of "git help --guides"
 - help: correct the usage string in -h and documentation

 Teach "git help -c" into helping the command line completion of
 configuration variables.

 Will merge to 'next'?


* en/am-abort-fix (2021-09-10) 3 commits
  (merged to 'next' on 2021-09-13 at 11f3d2dc90)
 + am: fix incorrect exit status on am fail to abort
 + t4151: add a few am --abort tests
 + git-am.txt: clarify --abort behavior
 (this branch is used by en/removing-untracked-fixes.)

 When "git am --abort" fails to abort correctly, it still exited
 with exit status of 0, which has been corrected.

 Will merge to 'master'.


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


* ab/gc-remove-unused-call (2021-09-12) 1 commit
  (merged to 'next' on 2021-09-13 at 14f69ed198)
 + gc: remove unused launchctl_get_uid() call

 Code clean-up.

 Will merge to 'master'.


* ab/test-tool-run-command-cleanup (2021-09-12) 1 commit
  (merged to 'next' on 2021-09-13 at 086310d0f4)
 + test-tool run-command: fix flip-flop init pattern

 Code clean-up.

 Will merge to 'master'.


* ab/unused-script-helpers (2021-09-12) 4 commits
  (merged to 'next' on 2021-09-15 at 14e6b0f26e)
 + test-lib: remove unused $_x40 and $_z40 variables
 + git-bisect: remove unused SHA-1 $x40 shell variable
 + git-sh-setup: remove unused "pull with rebase" message
 + git-submodule: remove unused is_zero_oid() function

 Code clean-up.

 Will merge to 'master'.


* cb/unix-sockets-with-windows (2021-09-14) 3 commits
  (merged to 'next' on 2021-09-16 at e2921332ef)
 + git-compat-util: include declaration for unix sockets in windows
 + credential-cache: check for windows specific errors
 + t0301: fixes for windows compatibility

 Adjust credential-cache helper to Windows.

 Will merge to 'master'.


* ds/add-rm-with-sparse-index (2021-09-12) 14 commits
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

 Expecting a reroll.
 cf. <922bdab1-c521-84b5-51c1-a0413fd67394@gmail.com>


* en/tests-cleanup-leftover-untracked (2021-09-12) 1 commit
  (merged to 'next' on 2021-09-13 at cf38118205)
 + tests: remove leftover untracked files

 Test clean-up.

 Will merge to 'master'.


* jk/strvec-typefix (2021-09-12) 1 commit
  (merged to 'next' on 2021-09-13 at e07858581d)
 + strvec: use size_t to store nr and alloc

 Correct nr and alloc members of strvec struct to be of type size_t.

 Will merge to 'master'.


* rs/drop-core-compression-vars (2021-09-12) 1 commit
  (merged to 'next' on 2021-09-13 at 3bd06626c3)
 + compression: drop write-only core_compression_* variables

 Code clean-up.

 Will merge to 'master'.


* rs/packfile-bad-object-list-in-oidset (2021-09-12) 5 commits
  (merged to 'next' on 2021-09-13 at 80e72f5f97)
 + packfile: use oidset for bad objects
 + packfile: convert has_packed_and_bad() to object_id
 + packfile: convert mark_bad_packed_object() to object_id
 + midx: inline nth_midxed_pack_entry()
 + oidset: make oidset_size() an inline function

 Replace a handcrafted data structure used to keep track of bad
 objects in the packfile API by an oidset.

 Will merge to 'master'.


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


* ab/retire-option-argument (2021-09-12) 4 commits
  (merged to 'next' on 2021-09-15 at 0bd7ce1161)
 + parse-options API: remove OPTION_ARGUMENT feature
 + difftool: use run_command() API in run_file_diff()
 + difftool: prepare "diff" cmdline in cmd_difftool()
 + difftool: prepare "struct child_process" in cmd_difftool()
 (this branch is used by da/difftool.)

 An oddball OPTION_ARGUMENT feature has been removed from the
 parse-options API.

 Will merge to 'master'.


* po/git-config-doc-mentions-help-c (2021-09-13) 1 commit
  (merged to 'next' on 2021-09-13 at bddbd5c25d)
 + doc: config, tell readers of `git help --config`

 Doc update.

 Will merge to 'master'.


* pw/rebase-of-a-tag-fix (2021-09-13) 11 commits
 - rebase: dereference tags
 - rebase: use lookup_commit_reference_by_name()
 - rebase: use our standard error return value
 - rebase: remove redundant strbuf
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

 Expecting a reroll.


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

 Will merge to 'master'.


* jt/add-submodule-odb-clean-up (2021-09-09) 3 commits
 - revision: remove "submodule" from opt struct
 - repository: support unabsorbed in repo_submodule_init
 - submodule: remove unnecessary unabsorbed fallback

 More code paths that uses the hack to add submodule's object
 database to the set of alternate object store have been cleaned up.

 Will merge to 'next'.


* jx/ci-l10n (2021-09-09) 1 commit
 - ci: new github-action for git-l10n code review

 CI help for l10n.

 Will merge to 'next'.


* rs/use-xopen-in-index-pack (2021-09-10) 1 commit
  (merged to 'next' on 2021-09-16 at 186eaaae56)
 + index-pack: use xopen in init_thread

 Code clean-up.

 Will merge to 'master'.


* js/scalar (2021-09-14) 15 commits
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


* ps/update-ref-batch-flush (2021-09-15) 2 commits
  (merged to 'next' on 2021-09-15 at 39a69141e3)
 + t1400: avoid SIGPIPE race condition on fifo
  (merged to 'next' on 2021-09-10 at 4ae19a5f34)
 + update-ref: fix streaming of status updates

 "git update-ref --stdin" failed to flush its output as needed,
 which potentially led the conversation to a deadlock.

 Will merge to 'master'.


* ab/sanitize-leak-ci (2021-09-20) 2 commits
 - tests: add a test mode for SANITIZE=3Dleak, run it in CI
 - Makefile: add SANITIZE=3Dleak flag to GIT-BUILD-OPTIONS

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
 + pull: remove support for `--rebase=3Dpreserve`
 + tests: stop testing `git rebase --preserve-merges`
 + remote: warn about unhandled branch.<name>.rebase values
 + t5520: do not use `pull.rebase=3Dpreserve`

 The "--preserve-merges" option of "git rebase" has been removed.

 Will cook in 'next'.


* mr/bisect-in-c-4 (2021-09-13) 6 commits
  (merged to 'next' on 2021-09-15 at 2af7f048d4)
 + bisect--helper: retire `--bisect-next-check` subcommand
 + bisect--helper: reimplement `bisect_run` shell function in C
 + bisect--helper: reimplement `bisect_visualize()` shell function in C
 + run-command: make `exists_in_PATH()` non-static
 + t6030-bisect-porcelain: add test for bisect visualize
 + t6030-bisect-porcelain: add tests to control bisect run exit cases

 Rewrite of "git bisect" in C continues.

 Will merge to 'master'.


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


* sg/test-split-index-fix (2021-09-07) 7 commits
 - read-cache: fix GIT_TEST_SPLIT_INDEX
 - tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
 - read-cache: look for shared index files next to the index, too
 - t1600-index: disable GIT_TEST_SPLIT_INDEX
 - t1600-index: don't run git commands upstream of a pipe
 - t1600-index: remove unnecessary redirection
 - Merge branch 'ds/sparse-index-ignored-files' into sg/test-split-index-=
fix

 Test updates.

 Will merge to 'next'?


* ab/refs-errno-cleanup (2021-08-25) 4 commits
 - refs: make errno output explicit for refs_resolve_ref_unsafe
 - refs: explicitly return failure_errno from parse_loose_ref_contents
 - branch tests: test for errno propagating on failing read
 - refs: add failure_errno to refs_read_raw_ref() signature
 (this branch uses ab/refs-files-cleanup and hn/refs-errno-cleanup.)

 The "remainder" of hn/refs-errno-cleanup topic.


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

 Will merge to 'next'?


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

 Will merge to 'next'?


* hn/refs-errno-cleanup (2021-08-25) 4 commits
 - refs: make errno output explicit for read_raw_ref_fn
 - refs/files-backend: stop setting errno from lock_ref_oid_basic
 - refs: remove EINVAL errno output from specification of read_raw_ref_fn
 - refs file backend: move raceproof_create_file() here
 (this branch is used by ab/refs-errno-cleanup; uses ab/refs-files-cleanu=
p.)

 Futz with the way 'errno' is relied on in the refs API to carry the
 failure modes up the callchain.

 Will merge to 'next'?

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
 cf. <CAKu1iLUaLuAZWqjNK4tfhhR=3DYaSt4MdQ+90ZY-JcEh_SeHyYCw@mail.gmail.co=
m>


* jh/builtin-fsmonitor (2021-09-03) 37 commits
 . fixup! fsmonitor--daemon: implement handle_client callback
 . SQUASH??? https://github.com/git/git/runs/3438543601?check_suite_focus=
=3Dtrue#step:5:136
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
 . t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daem=
on
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
