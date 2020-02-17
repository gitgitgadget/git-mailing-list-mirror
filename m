Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B41C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 22:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8393D2072C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 22:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fd7MiOdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgBQWIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 17:08:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58429 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgBQWIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 17:08:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E34AF5EF24;
        Mon, 17 Feb 2020 17:08:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=H
        WM+BmF7frxBqR5QhHhaYizqZ0g=; b=fd7MiOdDZnlkTvZFMevmERa2rir0wXvKd
        qqPhAb1NTGzINHI46sqytgXw5R4E2WqqhiqzmGtVCR+vXZeodHiTkqO2Ug1+E8pt
        DkC/I9ySmDm5veyw7z/CZ7LLDlLFTNrYc6M3DNSqJ7uC5Ur6fyH4WYEWSPa4ObzW
        yL7+5UMQ34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Ow/
        XXznk2PXKupF9Av+l62ZKABZR1Fn0JcjTfWxkuOBYpxDzYxIr34A7e87syy6Gz9j
        0y6fbWJJAkGWRbAlDkOwWB/UiaZ72Ei2F/d1h5WiXcbDuguR9UuAMgYdBVe2gYv3
        dCP3dZpv4jv8+pfEQsQpMMT4uxVen+jBFtf2t0EA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAE995EF23;
        Mon, 17 Feb 2020 17:08:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 301BC5EF22;
        Mon, 17 Feb 2020 17:08:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2020, #04; Mon, 17)
X-master-at: 51ebf55b9309824346a6589c9f3b130c6f371b8f
X-next-at: 3043dbfab8cba19275c80425d1436651d4be4a4a
Date:   Mon, 17 Feb 2020 14:08:38 -0800
Message-ID: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D0C4FE6-51D2-11EA-9CD0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Accumulated fixes on the 'master' front have been flushed to 'maint'
and a new maintenance release 2.25.1 has been tagged.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ag/edit-todo-drop-check (2020-01-28) 2 commits
  (merged to 'next' on 2020-02-07 at 687c82cd3a)
 + rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
 + sequencer: move check_todo_list_from_file() to rebase-interactive.c
 (this branch uses js/rebase-i-with-colliding-hash.)

 Allow the rebase.missingCommitsCheck configuration to kick in when
 "rebase --edit-todo" and "rebase --continue" restarts the procedure.


* ag/rebase-avoid-unneeded-checkout (2020-01-24) 1 commit
  (merged to 'next' on 2020-02-07 at b08da07534)
 + rebase -i: stop checking out the tip of the branch to rebase

 "git rebase -i" (and friends) used to unnecessarily check out the
 tip of the branch to be rebased, which has been corrected.


* bc/hash-independent-tests-part-8 (2020-02-07) 21 commits
  (merged to 'next' on 2020-02-11 at 127748e61a)
 + t6024: update for SHA-256
 + t6006: make hash size independent
 + t6000: abstract away SHA-1-specific constants
 + t5703: make test work with SHA-256
 + t5607: make hash size independent
 + t5318: update for SHA-256
 + t5515: make test hash independent
 + t5321: make test hash independent
 + t5313: make test hash independent
 + t5309: make test hash independent
 + t5302: make hash size independent
 + t4060: make test work with SHA-256
 + t4211: add test cases for SHA-256
 + t4211: move SHA-1-specific test cases into a directory
 + t4013: make test hash independent
 + t3311: make test work with SHA-256
 + t3310: make test work with SHA-256
 + t3309: make test work with SHA-256
 + t3308: make test work with SHA-256
 + t3206: make hash size independent
 + t/lib-pack: support SHA-256

 Preparation for SHA-256 migration continues.


* dl/test-must-fail-fixes-2 (2020-01-27) 16 commits
  (merged to 'next' on 2020-02-07 at 535e019692)
 + t4124: only mark git command with test_must_fail
 + t3507: use test_path_is_missing()
 + t3507: fix indentation
 + t3504: do check for conflict marker after failed cherry-pick
 + t3419: stop losing return code of git command
 + t3415: increase granularity of test_auto_{fixup,squash}()
 + t3415: stop losing return codes of git commands
 + t3310: extract common notes_merge_files_gone()
 + t3030: use test_path_is_missing()
 + t2018: replace "sha" with "oid"
 + t2018: don't lose return code of git commands
 + t2018: teach do_checkout() to accept `!` arg
 + t2018: be more discerning when checking for expected exit codes
 + t2018: improve style of if-statement
 + t2018: add space between function name and ()
 + t2018: remove trailing space from test description

 Test updates.


* ds/sparse-checkout-harden (2020-01-31) 15 commits
  (merged to 'next' on 2020-02-07 at 56c09b944f)
 + sparse-checkout: fix cone mode behavior mismatch
 + sparse-checkout: improve docs around 'set' in cone mode
 + sparse-checkout: escape all glob characters on write
 + sparse-checkout: use C-style quotes in 'list' subcommand
 + sparse-checkout: unquote C-style strings over --stdin
 + sparse-checkout: write escaped patterns in cone mode
 + sparse-checkout: properly match escaped characters
 + sparse-checkout: warn on globs in cone patterns
 + sparse-checkout: detect short patterns
 + sparse-checkout: cone mode does not recognize "**"
 + sparse-checkout: fix documentation typo for core.sparseCheckoutCone
 + clone: fix --sparse option with URLs
 + sparse-checkout: create leading directories
 + t1091: improve here-docs
 + t1091: use check_files to reduce boilerplate
 (this branch is used by ds/sparse-add.)

 Some rough edges in the sparse-checkout feature, especially around
 the cone mode, have been cleaned up.


* es/outside-repo-errmsg-hints (2020-02-16) 1 commit
  (merged to 'next' on 2020-02-16 at ed78b064b4)
 + prefix_path: show gitdir when arg is outside repo

 Error message clarification.


* hw/advice-add-nothing (2020-02-06) 2 commits
  (merged to 'next' on 2020-02-07 at 3c2a5c1868)
 + add: change advice config variables used by the add API
  (merged to 'next' on 2020-01-22 at 3fe4494fa6)
 + add: use advise function to display hints

 Two help messages given when "git add" notices the user gave it
 nothing to add have been updated to use advise() API.


* jh/notes-fanout-fix (2020-02-04) 2 commits
  (merged to 'next' on 2020-02-07 at a4ec94aee0)
 + notes.c: fix off-by-one error when decreasing notes fanout
 + t3305: check notes fanout more carefully and robustly

 The code to automatically shrink the fan-out in the notes tree had
 an off-by-one bug, which has been killed.


* jk/alloc-cleanups (2020-02-04) 4 commits
  (merged to 'next' on 2020-02-07 at f259621312)
 + tree-walk.c: break circular dependency with unpack-trees
 + traverse_trees(): use stack array for name entries
 + walker_fetch(): avoid raw array length computation
 + normalize_path_copy(): document "dst" size expectations

 Misc code clean-ups.


* jk/diff-honor-wserrhighlight-in-plumbing (2020-01-31) 1 commit
  (merged to 'next' on 2020-02-07 at acb077fdcb)
 + diff: move diff.wsErrorHighlight to "basic" config

 The diff-* plumbing family of subcommands now pay attention to the
 diff.wsErrorHighlight configuration, which has been ignored before;
 this allows "git add -p" to also show the whitespace problems to
 the end user.


* jk/doc-credential-helper (2020-02-14) 1 commit
  (merged to 'next' on 2020-02-16 at 0909d3f981)
 + doc: move credential helper info into gitcredentials(7)

 Docfix.


* jk/get-oid-error-message-i18n (2020-01-30) 3 commits
  (merged to 'next' on 2020-02-07 at 6bfe9235e5)
 + sha1-name: mark get_oid() error messages for translation
 + t1506: drop space after redirection operator
 + t1400: avoid "test" string comparisons

 A low-level API function get_oid(), that accepts various ways to
 name an object, used to issue end-user facing error messages
 without l10n, which has been updated to be translatable.


* jk/index-pack-dupfix (2020-02-04) 1 commit
  (merged to 'next' on 2020-02-07 at e6d79d432b)
 + index-pack: downgrade twice-resolved REF_DELTA to die()

 The index-pack code now diagnoses a bad input packstream that
 records the same object twice when it is used as delta base; the
 code used to declare a software bug when encountering such an
 input, but it is an input error.


* jk/mailinfo-cleanup (2020-02-11) 4 commits
  (merged to 'next' on 2020-02-11 at ab9890fbcb)
 + mailinfo: factor out some repeated header handling
 + mailinfo: be more liberal with header whitespace
 + mailinfo: simplify parsing of header values
 + mailinfo: treat header values as C strings
 (this branch uses rs/strbuf-insertstr.)

 Code clean-up.


* jk/packfile-reuse-cleanup (2020-01-23) 12 commits
  (merged to 'next' on 2020-02-07 at c543bc27fb)
 + pack-bitmap: don't rely on bitmap_git->reuse_objects
 + pack-objects: add checks for duplicate objects
 + pack-objects: improve partial packfile reuse
 + builtin/pack-objects: introduce obj_is_packed()
 + pack-objects: introduce pack.allowPackReuse
 + csum-file: introduce hashfile_total()
 + pack-bitmap: simplify bitmap_has_oid_in_uninteresting()
 + pack-bitmap: uninteresting oid can be outside bitmapped packfile
 + pack-bitmap: introduce bitmap_walk_contains()
 + ewah/bitmap: introduce bitmap_word_alloc()
 + packfile: expose get_delta_base()
 + builtin/pack-objects: report reused packfile objects

 The way "git pack-objects" reuses objects stored in existing pack
 to generate its result has been improved.


* jn/promote-proto2-to-default (2020-01-15) 5 commits
  (merged to 'next' on 2020-02-07 at 5597fd726b)
 + fetch: default to protocol version 2
 + protocol test: let protocol.version override GIT_TEST_PROTOCOL_VERSION
 + test: request GIT_TEST_PROTOCOL_VERSION=0 when appropriate
 + config doc: protocol.version is not experimental
 + fetch test: use more robust test for filtered objects

 The transport protocol version 2 becomes the default one.


* js/mingw-open-in-gdb (2020-02-14) 1 commit
  (merged to 'next' on 2020-02-16 at 6670f36d73)
 + mingw: add a helper function to attach GDB to the current process

 Dev support.


* js/rebase-i-with-colliding-hash (2020-01-23) 3 commits
  (merged to 'next' on 2020-02-07 at 670ba07c4d)
 + rebase -i: also avoid SHA-1 collisions with missingCommitsCheck
 + rebase -i: re-fix short SHA-1 collision
 + parse_insn_line(): improve error message when parsing failed
 (this branch is used by ag/edit-todo-drop-check.)

 "git rebase -i" identifies existing commits in its todo file with
 their abbreviated object name, which could become ambigous as it
 goes to create new commits, and has a mechanism to avoid ambiguity
 in the main part of its execution.  A few other cases however were
 not covered by the protection against ambiguity, which has been
 corrected.


* js/test-avoid-pipe (2020-02-14) 1 commit
  (merged to 'next' on 2020-02-16 at 090cac9c23)
 + t9001, t9116: avoid pipes

 Test clean-up.


* js/test-unc-fetch (2020-02-14) 1 commit
  (merged to 'next' on 2020-02-16 at a4ca01efef)
 + t5580: test cloning without file://, test fetching via UNC paths

 Test updates.


* js/test-write-junit-xml-fix (2020-02-12) 1 commit
  (merged to 'next' on 2020-02-16 at 2deb247550)
 + tests: fix --write-junit-xml with subshells

 Testfix.


* jt/connectivity-check-optim-in-partial-clone (2020-01-30) 2 commits
  (merged to 'next' on 2020-02-07 at ca5102fa58)
 + fetch: forgo full connectivity check if --filter
 + connected: verify promisor-ness of partial clone

 Unneeded connectivity check is now disabled in a partial clone when
 fetching into it.


* kw/fsmonitor-watchman-racefix (2020-01-23) 4 commits
  (merged to 'next' on 2020-02-07 at 3c42195a34)
 + fsmonitor: update documentation for hook version and watchman hooks
 + fsmonitor: add fsmonitor hook scripts for version 2
 + fsmonitor: handle version 2 of the hooks that will use opaque token
 + fsmonitor: change last update timestamp on the index_state to opaque token

 A new version of fsmonitor-watchman hook has been introduced, to
 avoid races.


* ld/p4-cleanup-processes (2020-01-30) 7 commits
  (merged to 'next' on 2020-02-07 at e8c573f01c)
 + git-p4: avoid leak of file handle when cloning
 + git-p4: check for access to remote host earlier
 + git-p4: cleanup better on error exit
 + git-p4: create helper function importRevisions()
 + git-p4: disable some pylint warnings, to get pylint output to something manageable
 + git-p4: add P4CommandException to report errors talking to Perforce
 + git-p4: make closeStreams() idempotent

 p4 updates.


* mr/show-config-scope (2020-02-10) 10 commits
  (merged to 'next' on 2020-02-11 at 904bca086e)
 + config: add '--show-scope' to print the scope of a config value
 + submodule-config: add subomdule config scope
 + config: teach git_config_source to remember its scope
 + config: preserve scope in do_git_config_sequence
 + config: clarify meaning of command line scoping
 + config: split repo scope to local and worktree
 + config: make scope_name non-static and rename it
 + t1300: create custom config file without special characters
 + t1300: fix over-indented HERE-DOCs
 + config: fix typo in variable name
 (this branch is used by bw/remote-rename-update-config and es/bugreport.)

 "git config" learned to show in which "scope", in addition to in
 which file, each config setting comes from.


* mt/threaded-grep-in-object-store (2020-01-17) 12 commits
  (merged to 'next' on 2020-02-07 at e86bab09e1)
 + grep: use no. of cores as the default no. of threads
 + grep: move driver pre-load out of critical section
 + grep: re-enable threads in non-worktree case
 + grep: protect packed_git [re-]initialization
 + grep: allow submodule functions to run in parallel
 + submodule-config: add skip_if_read option to repo_read_gitmodules()
 + grep: replace grep_read_mutex by internal obj read lock
 + object-store: allow threaded access to object reading
 + replace-object: make replace operations thread-safe
 + grep: fix racy calls in grep_objects()
 + grep: fix race conditions at grep_submodule()
 + grep: fix race conditions on userdiff calls

 Traditionally, we avoided threaded grep while searching in objects
 (as opposed to files in the working tree) as accesses to the object
 layer is not thread-safe.  This limitation is getting lifted.


* mt/use-passed-repo-more-in-funcs (2020-01-31) 7 commits
  (merged to 'next' on 2020-02-07 at 536709ab4b)
 + sha1-file: allow check_object_signature() to handle any repo
 + sha1-file: pass git_hash_algo to hash_object_file()
 + sha1-file: pass git_hash_algo to write_object_file_prepare()
 + streaming: allow open_istream() to handle any repo
 + pack-check: use given repo's hash_algo at verify_packfile()
 + cache-tree: use given repo's hash_algo at verify_one()
 + diff: make diff_populate_filespec() honor its repo argument

 Some codepaths were given a repository instance as a parameter to
 work in the repository, but passed the_repository instance to its
 callees, which has been cleaned up (somewhat).


* pk/status-of-uncloned-submodule (2020-02-04) 3 commits
  (merged to 'next' on 2020-02-07 at f6349f5f5f)
 + t7400: testcase for submodule status on unregistered inner git repos
 + submodule: fix status of initialized but not cloned submodules
 + t7400: add a testcase for submodule status on empty dirs

 The way "git submodule status" reports an initialized but not yet
 populated submodule has not been reimplemented correctly when a
 part of the "git submodule" command was rewritten in C, which has
 been corrected.


* rs/name-rev-memsave (2020-02-05) 11 commits
  (merged to 'next' on 2020-02-11 at 17616cb9b1)
 + name-rev: sort tip names before applying
 + name-rev: release unused name strings
 + name-rev: generate name strings only if they are better
 + name-rev: pre-size buffer in get_parent_name()
 + name-rev: factor out get_parent_name()
 + name-rev: put struct rev_name into commit slab
 + name-rev: don't _peek() in create_or_update_name()
 + name-rev: don't leak path copy in name_ref()
 + name-rev: respect const qualifier
 + name-rev: remove unused typedef
 + name-rev: rewrite create_or_update_name()

 Memory footprint and performance of "git name-rev" has been
 improved.


* rs/parse-options-concat-dup (2020-02-10) 4 commits
  (merged to 'next' on 2020-02-11 at a1685687ab)
 + parse-options: simplify parse_options_dup()
 + parse-options: const parse_options_concat() parameters
 + parse-options: factor out parse_options_count()
 + parse-options: use COPY_ARRAY in parse_options_concat()

 Code clean-up.


* rs/strbuf-insertstr (2020-02-10) 2 commits
  (merged to 'next' on 2020-02-11 at 5c89aa002f)
 + mailinfo: don't insert header prefix for handle_content_type()
 + strbuf: add and use strbuf_insertstr()
 (this branch is used by jk/mailinfo-cleanup.)

 Code clean-up.


* tb/commit-graph-object-dir (2020-02-04) 5 commits
  (merged to 'next' on 2020-02-07 at 5c85173df4)
 + commit-graph.h: use odb in 'load_commit_graph_one_fd_st'
 + commit-graph.c: remove path normalization, comparison
 + commit-graph.h: store object directory in 'struct commit_graph'
 + commit-graph.h: store an odb in 'struct write_commit_graph_context'
 + t5318: don't pass non-object directory to '--object-dir'
 (this branch is used by tb/commit-graph-split-merge.)

 The code to compute the commit-graph has been taught to use a more
 robust way to tell if two object directories refer to the same
 thing.

--------------------------------------------------
[New Topics]

* jk/object-filter-with-bitmap (2020-02-14) 15 commits
  (merged to 'next' on 2020-02-16 at 42425c3658)
 + pack-objects: support filters with bitmaps
 + pack-bitmap: implement BLOB_LIMIT filtering
 + pack-bitmap: implement BLOB_NONE filtering
 + bitmap: add bitmap_unset() function
 + rev-list: use bitmap filters for traversal
 + pack-bitmap: basic noop bitmap filter infrastructure
 + rev-list: allow commit-only bitmap traversals
 + t5310: factor out bitmap traversal comparison
 + rev-list: allow bitmaps when counting objects
 + rev-list: make --count work with --objects
 + rev-list: factor out bitmap-optimized routines
 + pack-bitmap: refuse to do a bitmap traversal with pathspecs
 + rev-list: fallback to non-bitmap traversal when filtering
 + pack-bitmap: fix leak of haves/wants object lists
 + pack-bitmap: factor out type iterator initialization

 The object reachability bitmap machinery and the partial cloning
 machinery were not prepared to work well together, because some
 object-filtering criteria partial clones use inherently rely on
 object traversal, but the bitmap machinery is an optimization to
 bypass that object traversal.  There however are some cases that
 they can work together, and they were taught about this case.

 Will merge to 'master'.


* hw/advise-ng (2020-02-16) 2 commits
 - advice: extract vadvise() from advise()
 - advice: refactor advise API

 Revamping of the advise API to allow more systematic enumeration of
 advice knobs in the future.

--------------------------------------------------
[Stalled]

* pw/advise-rebase-skip (2019-12-06) 9 commits
 - rebase -i: leave CHERRY_PICK_HEAD when there are conflicts
 - rebase: fix advice when a fixup creates an empty commit
 - commit: give correct advice for empty commit during a rebase
 - commit: encapsulate determine_whence() for sequencer
 - commit: use enum value for multiple cherry-picks
 - sequencer: write CHERRY_PICK_HEAD for reword and edit
 - cherry-pick: check commit error messages
 - cherry-pick: add test for `--skip` advice in `git commit`
 - t3404: use test_cmp_rev

 The mechanism to prevent "git commit" from making an empty commit
 or amending during an interrupted cherry-pick was broken during the
 rewrite of "git rebase" in C, which has been corrected.

 What's the status of this one?
 The tip two are still RFC.


* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* ds/sparse-add (2020-02-11) 4 commits
  (merged to 'next' on 2020-02-14 at 3799757bbe)
 + sparse-checkout: work with Windows paths
 + sparse-checkout: create 'add' subcommand
 + sparse-checkout: extract pattern update from 'set' subcommand
 + sparse-checkout: extract add_patterns_from_input()

 "git sparse-checkout" learned a new "add" subcommand.

 Will merge to 'master'.


* at/rebase-fork-point-regression-fix (2020-02-11) 1 commit
 - rebase: --fork-point regression fix

 The "--fork-point" mode of "git rebase" regressed when the command
 was rewritten in C back in 2.20 era, which has been corrected.

 Was waiting for discussion to settle.
 cf. <CAPig+cQ-3Ds41hr91fRo_GvuFMTP7zNVJtaSqi-Yccq4Pk-8Qg@mail.gmail.com>
 cf. <xmqq36dtwcvw.fsf@gitster-ct.c.googlers.com>


* hn/reftable (2020-02-10) 5 commits
 . Reftable support for git-core
 . Add reftable library
 . refs: document how ref_iterator_advance_fn should handle symrefs
 . create .git/refs in files-backend.c
 . refs.h: clarify reflog iteration order

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

 At v5.


* es/bugreport (2020-02-14) 15 commits
 - bugreport: summarize contents of alternates file
 - bugreport: list contents of $OBJDIR/info
 - bugreport: add packed object summary
 - bugreport: count loose objects
 - bugreport: collect list of populated hooks
 - bugreport: add config values from safelist
 - bugreport: generate config safelist based on docs
 - bugreport: include user interactive shell
 - bugreport: add git-remote-https version
 - bugreport: add compiler info
 - bugreport: add uname info
 - bugreport: gather git version and build info
 - bugreport: add tool to generate debugging info
 - help: add shell-path to --build-options
 - help: move list_config_help to builtin/help

 The "bugreport" tool.

 at v7.


* gs/commit-graph-path-filter (2020-02-12) 12 commits
 - (bytesex breakage band-aid)
 - commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
 - revision.c: use Bloom filters to speed up path based revision walks
 - commit-graph: add --changed-paths option to write subcommand
 - commit-graph: reuse existing Bloom filters during write.
 - commit-graph: write Bloom filters to commit graph file
 - commit-graph: examine commits by generation number
 - commit-graph: examine changed-path objects in pack order
 - commit-graph: compute Bloom filters for changed paths
 - diff: halt tree-diff early after max_changes
 - bloom: core Bloom filter implementation for changed paths
 - commit-graph: use MAX_NUM_CHUNKS

 Introduce an extension to the commit-graph to make it efficient to
 check for the paths that were modified at each commit using Bloom
 filters.

 Will be rerolled with bytesex fixes squashed in.
 Breakage due to byte-order dependency reported.


* mr/bisect-in-c-1 (2020-02-10) 13 commits
 - bisect: libify `bisect_next_all`
 - bisect: libify `handle_bad_merge_base` and its dependents
 - bisect: libify `check_good_are_ancestors_of_bad` and its dependents
 - bisect: libify `check_merge_bases` and its dependents
 - bisect: libify `bisect_checkout`
 - bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and its dependents
 - bisect--helper: return error codes from `cmd_bisect__helper()`
 - bisect: add enum to represent bisect returning codes
 - bisect--helper: introduce new `decide_next()` function
 - run-command: make `exists_in_PATH()` non-static
 - bisect: use the standard 'if (!var)' way to check for 0
 - bisect--helper: change `retval` to `res`
 - bisect--helper: convert `vocab_*` char pointers to char arrays

 Underlying machinery of "git bisect--helper" is being refactored
 into pieces that are more easily reused.


* bw/remote-rename-update-config (2020-02-10) 6 commits
  (merged to 'next' on 2020-02-14 at 30b1a477de)
 + remote rename/remove: gently handle remote.pushDefault config
 + config: provide access to the current line number
 + remote rename/remove: handle branch.<name>.pushRemote config values
 + remote: clean-up config callback
 + remote: clean-up by returning early to avoid one indentation
 + pull --rebase/remote rename: document and honor single-letter abbreviations rebase types

 "git remote rename X Y" needs to adjust configuration variables
 (e.g. branch.<name>.remote) whose value used to be X to Y.
 branch.<name>.pushRemote is now also updated.

 Will merge to 'master'.


* es/bright-colors (2020-02-11) 3 commits
  (merged to 'next' on 2020-02-14 at cc17dbc7e8)
 + color.c: alias RGB colors 8-15 to aixterm colors
 + color.c: support bright aixterm colors
 + color.c: refactor color_output arguments

 The basic 7 colors learned the brighter counterparts
 (e.g. "brightred").

 Will merge to 'master'.


* es/doc-mentoring (2020-02-14) 2 commits
  (merged to 'next' on 2020-02-17 at e3f3e316eb)
 + MyFirstContribution: rephrase contact info
  (merged to 'next' on 2020-02-05 at 3b05aabbcd)
 + MyFirstContribution: add avenues for getting help

 Doc for new contributors.

 Will merge to 'master'.
 cf. <xmqqr1yxnkab.fsf@gitster-ct.c.googlers.com>


* bk/p4-pre-edit-changelist (2020-02-14) 7 commits
 - git-p4: add RCS keyword status message
 - git-p4: add p4 submit hooks
 - git-p4: restructure code in submit
 - git-p4: add --no-verify option
 - git-p4: add p4-pre-submit exit text
 - git-p4: create new function run_git_hook
 - git-p4: rewrite prompt to be Windows compatible

 "git p4" learned four new hooks and also "--no-verify" option to
 bypass them (and the existing "p4-pre-submit" hook).

 Waiting for response to RFH from Windows/Python folks.
 cf. <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>


* en/fill-directory-exponential (2020-01-31) 6 commits
 - t7063: blindly accept diffs
 - dir: replace exponential algorithm with a linear one
 - dir: refactor treat_directory to clarify control flow
 - dir: fix confusion based on variable tense
 - dir: fix broken comment
 - dir: consolidate treat_path() and treat_one_path()

 The directory traversal code had redundant recursive calls which
 made its performance characteristics exponential wrt the depth of
 the tree, which was corrected.

 Still RFC?
 cf. <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
 cf. <CABPp-BF0SO92wxY-dM14Vxv6BGA5=T=CicdwbiaZ7c9w6-j2jQ@mail.gmail.com>


* tb/commit-graph-split-merge (2020-02-12) 3 commits
 - builtin/commit-graph.c: support '--input=none'
 - builtin/commit-graph.c: introduce '--input=<source>'
 - builtin/commit-graph.c: support '--split[=<strategy>]'

 The code to write out the commit-graph has been taught a few
 options to control if the resulting graph chains should be merged
 or a single new incremental graph is created.

 Waiting for the discussion to settle.
 cf. <20200212205028.GE4364@syl.local>


* am/pathspec-f-f-more (2020-02-10) 8 commits
 - stash push: support the --pathspec-from-file option
 - stash: eliminate crude option parsing
 - doc: stash: synchronize <pathspec> description
 - doc: stash: document more options
 - doc: stash: split options from description (2)
 - doc: stash: split options from description (1)
 - rm: support the --pathspec-from-file option
 - doc: rm: synchronize <pathspec> description

 "git rm" and "git stash" learns the new "--pathspec-from-file"
 option.


* dl/merge-autostash (2020-01-13) 17 commits
 - pull: pass --autostash to merge
 - t5520: make test_pull_autostash() accept expect_parent_num
 - merge: teach --autostash option
 - sequencer: unlink autostash in apply_autostash()
 - sequencer: extract perform_autostash() from rebase
 - rebase: generify create_autostash()
 - rebase: extract create_autostash()
 - reset: extract reset_head() from rebase
 - rebase: generify reset_head()
 - rebase: use apply_autostash() from sequencer.c
 - sequencer: make apply_rebase() accept a path
 - rebase: use read_oneliner()
 - sequencer: make read_oneliner() extern
 - sequencer: configurably warn on non-existent files
 - sequencer: use file strbuf for read_oneliner()
 - t7600: use test_write_lines()
 - Makefile: alphabetically sort += lists

 "git merge" learns the "--autostash" option.

 Expecting a reroll.
 cf. <20200123042906.GA29009@generichostname>


* yz/p4-py3 (2020-02-13) 14 commits
 - ci: use python3 in linux-gcc and osx-gcc and python2 elsewhere
 - git-p4: use python3's input() everywhere
 - git-p4: simplify regex pattern generation for parsing diff-tree
 - git-p4: use dict.items() iteration for python3 compatibility
 - git-p4: use functools.reduce instead of reduce
 - git-p4: fix freezing while waiting for fast-import progress
 - git-p4: use marshal format version 2 when sending to p4
 - git-p4: open .gitp4-usercache.txt in text mode
 - git-p4: convert path to unicode before processing them
 - git-p4: encode/decode communication with git for python3
 - git-p4: encode/decode communication with p4 for python3
 - git-p4: remove string type aliasing
 - git-p4: change the expansion test from basestring to list
 - git-p4: make python2.7 the oldest supported version

 Update "git p4" to work with Python 3.

 Hold.
 Waiting for SoB on the last step.
 cf. <xmqqk14qqj7n.fsf@gitster-ct.c.googlers.com>


* en/rebase-backend (2020-02-16) 20 commits
 - rebase: rename the two primary rebase backends
 - rebase: change the default backend from "am" to "merge"
 - rebase: make the backend configurable via config setting
 - rebase tests: repeat some tests using the merge backend instead of am
 - rebase tests: mark tests specific to the am-backend with --am
 - rebase: drop '-i' from the reflog for interactive-based rebases
 - git-prompt: change the prompt for interactive-based rebases
 - rebase: add an --am option
 - rebase: move incompatibility checks between backend options a bit earlier
 - git-rebase.txt: add more details about behavioral differences of backends
 - rebase: allow more types of rebases to fast-forward
 - t3432: make these tests work with either am or merge backends
 - rebase: fix handling of restrict_revision
 - rebase: make sure to pass along the quiet flag to the sequencer
 - rebase, sequencer: remove the broken GIT_QUIET handling
 - t3406: simplify an already simple test
 - rebase (interactive-backend): fix handling of commits that become empty
 - rebase (interactive-backend): make --keep-empty the default
 - t3404: directly test the behavior of interest
 - git-rebase.txt: update description of --allow-empty-message

 "git rebase" has learned to use the sequencer backend by default,
 while allowing "--am" option to go back to the traditional "am"
 backend.

 The last step may be rushing things a bit and may want to be
 taken separately.
 cf. <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
