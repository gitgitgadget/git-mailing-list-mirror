Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_META_ALL,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8042C4727E
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB9620796
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C/ycFckh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgJFULf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:11:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53067 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJFULd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 16:11:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BD2D84713;
        Tue,  6 Oct 2020 16:11:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=+
        nnx0vP1QfE0dSgZ8iyAM3o+3u8=; b=C/ycFckhOqIgV08g3zJHZM7cQz3zdLGjL
        KV2E3VUYsg441br0WVjSUXYhqpFQTD6IbizDomo0imok6XNnhQOfr0vLd0He8qFT
        z4/hvc81cS5McuoFHGJD/TjyvO4wuCfRNRPNS2nZdvpL66hyL4pHz69VgXbdtsE+
        Mb3GBXebcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=lcv
        rjuEdUrX1vz2IQ9eVX3ud9sYbOjybLS2BLigNc5+GTs8Xxx0lLIgHi8xVbXVDQ5f
        gTmrAT8hfy5pGU76+51nD6kU5/P3Sd+DtQo/b501Kq8LQD1PeLYksATU5vobifu3
        bo87vTlerdwwA28+xURdc1UnRFTEhCM6PbBVizwM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 938BE84712;
        Tue,  6 Oct 2020 16:11:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C08184711;
        Tue,  6 Oct 2020 16:11:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2020, #01; Mon, 5)
X-master-at: d98273ba77e1ab9ec755576bc86c716a97bf59d7
X-next-at: c238dab514479c86f2794b853c4f3b6271c1e0d6
Date:   Tue, 06 Oct 2020 13:11:24 -0700
Message-ID: <xmqq8scj5d3n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C3EE286-0810-11EB-9354-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The preview release for the upcoming Git 2.29 has been tagged.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to 'master']

* ab/mediawiki-fixes (2020-09-21) 18 commits
  (merged to 'next' on 2020-09-25 at 878693716e)
 + remote-mediawiki: use "sh" to eliminate unquoted commands
 + remote-mediawiki: annotate unquoted uses of run_git()
 + remote-mediawiki: convert to quoted run_git() invocation
 + remote-mediawiki: provide a list form of run_git()
 + remote-mediawiki tests: annotate failing tests
 + remote-mediawiki: fix duplicate revisions being imported
 + remote-mediawiki tests: use CLI installer
 + remote-mediawiki tests: use inline PerlIO for readability
 + remote-mediawiki tests: replace deprecated Perl construct
 + remote-mediawiki tests: use a more idiomatic dispatch table
 + remote-mediawiki tests: use "$dir/" instead of "$dir."
 + remote-mediawiki tests: change `[]` to `test`
 + remote-mediawiki tests: use test_cmp in tests
 + remote-mediawiki tests: use a 10 character password
 + remote-mediawiki tests: use the login/password variables
 + remote-mediawiki doc: don't hardcode Debian PHP versions
 + remote-mediawiki doc: link to MediaWiki's current version
 + remote-mediawiki doc: correct link to GitHub project

 Modernization and fixes to MediaWiki remote backend.


* al/ref-filter-merged-and-no-merged (2020-09-26) 1 commit
  (merged to 'next' on 2020-09-29 at 748a286753)
 + ref-filter: plug memory leak in reach_filter()

 Hotfix.


* au/complete-restore-s (2020-09-26) 2 commits
  (merged to 'next' on 2020-09-29 at 7bbf508562)
 + completion: complete refs after 'git restore -s'
 + completion: use "prev" variable instead of introducing "prevword"

 The command line completion (in contrib/) learned that "git restore
 -s <TAB>" is often followed by a refname.


* cc/bisect-start-fix (2020-09-25) 1 commit
  (merged to 'next' on 2020-09-29 at 637011d04a)
 + bisect: don't use invalid oid as rev when starting

 "git bisect start X Y", when X and Y are not valid committish
 object names, should take X and Y as pathspec, but didn't.


* ds/in-merge-bases-many-optim-bug (2020-10-02) 1 commit
  (merged to 'next' on 2020-10-04 at b736873ada)
 + commit-reach: fix in_merge_bases_many bug
 (this branch is used by sk/force-if-includes.)

 in_merge_bases_many(), a way to see if a commit is reachable from
 any commit in a set of commits, was totally broken when the
 commit-graph feature was in use, which has been corrected.


* eg/mailinfo-doc-scissors (2020-09-28) 1 commit
  (merged to 'next' on 2020-09-29 at 4694f22fe9)
 + Doc: show example scissors line

 The explanation of the "scissors line" has been clarified.


* jc/blame-ignore-fix (2020-09-24) 2 commits
  (merged to 'next' on 2020-09-29 at 96fbdb57fb)
 + blame: validate and peel the object names on the ignore list
 + t8013: minimum preparatory clean-up

 "git blame --ignore-rev/--ignore-revs-file" failed to validate
 their input are valid revision, and failed to take into account
 that the user may want to give an annotated tag instead of a
 commit, which has been corrected.


* jc/fmt-merge-msg-suppress-destination (2020-09-27) 1 commit
  (merged to 'next' on 2020-09-29 at 2b1f8ee654)
 + config/fmt-merge-msg.txt: drop space in quote

 Docfix.


* jc/sequencer-stopped-sha-simplify (2020-09-25) 1 commit
  (merged to 'next' on 2020-09-29 at 9af3360572)
 + sequencer: stop abbreviating stopped-sha file

 Code simplification.


* jk/diff-cc-oidfind-fix (2020-09-30) 1 commit
  (merged to 'next' on 2020-10-04 at 637072574f)
 + combine-diff: handle --find-object in multitree code path

 "log -c --find-object=X" did not work well to find a merge that
 involves a change to an object X from only one parent.


* jk/drop-unaligned-loads (2020-09-24) 2 commits
  (merged to 'next' on 2020-09-29 at 29c05387a0)
 + Revert "fast-export: use local array to store anonymized oid"
 + bswap.h: drop unaligned loads

 Compilation fix around type punning.


* jk/format-auto-base-when-able (2020-10-01) 1 commit
  (merged to 'next' on 2020-10-04 at ab8f65b8c5)
 + format-patch: teach format.useAutoBase "whenAble" option

 "git format-patch" learns to take "whenAble" as a possible value
 for the format.useAutoBase configuration variable to become no-op
 when the  automatically computed base does not make sense.


* jk/refspecs-negative (2020-09-30) 1 commit
  (merged to 'next' on 2020-10-04 at 2948e90fab)
 + refspec: add support for negative refspecs

 "git fetch" and "git push" support negative refspecs.


* jk/shortlog-group-by-trailer (2020-09-27) 8 commits
  (merged to 'next' on 2020-09-29 at 3706b06db5)
 + shortlog: allow multiple groups to be specified
 + shortlog: parse trailer idents
 + shortlog: rename parse_stdin_ident()
 + shortlog: de-duplicate trailer values
 + shortlog: match commit trailers with --group
 + trailer: add interface for iterating over commit trailers
 + shortlog: add grouping option
 + shortlog: change "author" variables to "ident"

 "git shortlog" has been taught to group commits by the contents of
 the trailer lines, like "Reviewed-by:", "Coauthored-by:", etc.


* jk/unused (2020-09-30) 10 commits
  (merged to 'next' on 2020-10-01 at 440a7a0a7a)
 + dir.c: drop unused "untracked" from treat_path_fast()
 + sequencer: handle ignore_footer when parsing trailers
 + test-advise: check argument count with argc instead of argv
 + sparse-checkout: fill in some options boilerplate
 + sequencer: drop repository argument from run_git_commit()
 + push: drop unused repo argument to do_push()
 + assert PARSE_OPT_NONEG in parse-options callbacks
 + env--helper: write to opt->value in parseopt helper
 + drop unused argc parameters
 + convert: drop unused crlf_action from check_global_conv_flags_eol()

 Code cleanup.


* js/cmake-vs (2020-09-30) 10 commits
  (merged to 'next' on 2020-10-01 at 40be8c6094)
 + hashmap_for_each_entry(): workaround MSVC's runtime check failure #3
 + cmake (Windows): recommend using Visual Studio's built-in CMake support
 + cmake (Windows): initialize vcpkg/build dependencies automatically
 + cmake (Windows): complain when encountering an unknown compiler
 + cmake (Windows): let the `.dll` files be found when running the tests
 + cmake: quote the path accurately when editing `test-lib.sh`
 + cmake: fall back to using `vcpkg`'s `msgfmt.exe` on Windows
 + cmake: ensure that the `vcpkg` packages are found on Windows
 + cmake: do find Git for Windows' shell interpreter
 + cmake: ignore files generated by CMake as run in Visual Studio

 Using the CMake support we added some time ago for real with Visual
 Studio build revealed there were lot of usability improvements
 possible, which have been carried out.


* js/default-branch-name-part-2 (2020-09-26) 5 commits
  (merged to 'next' on 2020-09-30 at 3fb4047ce3)
 + t9902: avoid using the branch name `master`
 + tests: avoid variations of the `master` branch name
 + t3200: avoid variations of the `master` branch name
 + fast-export: avoid using unnecessary language in a code comment
 + t/test-terminal: avoid non-inclusive language

 Update the tests to drop word 'master' from them.


* js/no-builtins-on-disk-option (2020-09-21) 3 commits
  (merged to 'next' on 2020-09-25 at 6b976da4d2)
 + ci: stop linking built-ins to the dashed versions
 + Optionally skip linking/copying the built-ins
 + msvc: copy the correct `.pdb` files in the Makefile target `install`

 The installation procedure learned to optionally omit "git-foo"
 executable files for each 'foo' built-in subcommand, which are only
 required by old timers that still rely on the age old promise that
 prepending "git --exec-path" output to PATH early in their script
 will keep the "git-foo" calls they wrote working.

 The old attempt to remove these executables from the disk failed in
 the 1.6 era; it may be worth attempting again, but I think it is
 worth to keep this topic separate from such a policy change to help
 it graduate early.


* jt/keep-partial-clone-filter-upon-lazy-fetch (2020-09-28) 2 commits
  (merged to 'next' on 2020-10-01 at 77c4c6094c)
 + fetch: do not override partial clone filter
 + promisor-remote: remove unused variable

 The lazy fetching done internally to make missing objects available
 in a partial clone incorrectly made permanent damage to the partial
 clone filter in the repository, which has been corrected.


* ma/worktree-cleanups (2020-09-27) 7 commits
  (merged to 'next' on 2020-10-01 at 369dcfb161)
 + worktree: use skip_prefix to parse target
 + worktree: rename copy-pasted variable
 + worktree: update renamed variable in comment
 + worktree: inline `worktree_ref()` into its only caller
 + wt-status: introduce wt_status_state_free_buffers()
 + wt-status: print to s->fp, not stdout
 + wt-status: replace sha1 mentions with oid

 Code clean-up.


* mr/bisect-in-c-2 (2020-09-24) 6 commits
  (merged to 'next' on 2020-09-29 at a15f1729d2)
 + bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
 + bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
 + bisect--helper: reimplement `bisect_autostart` shell function in C
 + bisect--helper: introduce new `write_in_file()` function
 + bisect--helper: use '-res' in 'cmd_bisect__helper' return
 + bisect--helper: BUG() in cmd_*() on invalid subcommand

 Rewrite of the "git bisect" script in C continues.


* mt/delta-base-cache-races (2020-09-28) 2 commits
  (merged to 'next' on 2020-09-29 at ee2d60c077)
 + packfile: fix memory leak in add_delta_base_cache()
 + packfile: fix race condition on unpack_entry()

 A race that leads to an access to a free'd data was corrected in
 the codepath that reads pack files.


* nl/credential-crlf (2020-10-03) 1 commit
  (merged to 'next' on 2020-10-04 at 213256c1e6)
 + credential: treat CR/LF as line endings in the credential protocol

 Loosen the parser in the receiving end of the credential protocol
 to allow credential helper to terminate lines with CRLF line
 ending, as well as LF line ending.


* pb/submodule-doc-fix (2020-10-04) 1 commit
  (merged to 'next' on 2020-10-04 at c535486479)
 + gitsubmodules doc: invoke 'ls-files' with '--recurse-submodules'

 Doc update.


* pm/gitk-update (2020-10-03) 11 commits
  (merged to 'next' on 2020-10-04 at fd505ccfc1)
 + Merge remote-tracking branch 'paulus/master' into pm/gitk-update
 + gitk: Resize panes correctly when reducing window size
 + gitk: replace tabs with spaces
 + gitk: fix the context menu not appearing in the presence of submodule diffs
 + gitk: Un-hide selection in areas with non-default background color
 + gitk: add diff lines background colors
 + gitk: be prepared to be run in a bare repository
 + gitk: Preserve window dimensions on exit when not using ttk themes
 + gitk: don't highlight files after submodules as submodules
 + gitk: fix branch name encoding error
 + gitk: rename "commit summary" to "commit reference"

 "gitk" update.


* rs/archive-add-file (2020-09-19) 3 commits
  (merged to 'next' on 2020-10-04 at fffc088553)
 + Makefile: use git-archive --add-file
 + archive: add --add-file
 + archive: read short blobs in archive.c::write_archive_entry()

 "git archive" learns the "--add-file" option to include untracked
 files into a snapshot from a tree-ish.


* sn/fast-import-doc (2020-10-04) 1 commit
  (merged to 'next' on 2020-10-04 at fdf196b997)
 + fast-import: fix typo in documentation

 Doc update.


* so/combine-diff-simplify (2020-09-29) 1 commit
  (merged to 'next' on 2020-09-30 at d45e33ebb0)
 + diff: get rid of redundant 'dense' argument

 Code simplification.


* tb/upload-pack-filters (2020-09-27) 1 commit
  (merged to 'next' on 2020-09-29 at 3dde767170)
 + config/uploadpack.txt: fix typo in `--filter=tree:<n>`

 Hotfix.


* td/submodule-update-quiet (2020-10-01) 1 commit
  (merged to 'next' on 2020-10-01 at 4ae8bee636)
 + submodule update: silence underlying merge/rebase with "--quiet"

 "git submodule update --quiet" did not squelch underlying "rebase"
 and "pull" commands.

--------------------------------------------------
[New Topics]

* mk/diff-ignore-regex (2020-10-01) 2 commits
 - t: add -I<regex> tests
 - diff: add -I<regex> that ignores matching changes

 "git diff" family of commands learned the "-I<regex>" option to
 ignore hunks whose changed lines all match the given pattern.

 Expecting review response.

--------------------------------------------------
[Stalled]

* sv/t7001-modernize (2020-09-25) 11 commits
 - t7001: move cleanup code from outside the tests into them
 - t7001: use `test` rather than `[`
 - t7001: use here-docs instead of echo
 - t7001: put each command on a separate line
 - t7001: use ': >' rather than 'touch'
 - t7001: change (cd <path> && git foo) to (git -C <path> foo)
 - t7001: remove whitespace after redirect operators
 - t7001: change the style for cd according to subshell
 - t7001: remove unnecessary blank lines
 - t7001: use TAB instead of spaces
 - t7001: convert tests from the old style to the current style

 Test script modernization.

 Expecting a reroll.
 cf. <20200925170256.11490-1-shubhunic@gmail.com>


* ew/decline-core-abbrev (2020-09-01) 1 commit
 - core.abbrev <off|false|no> disables abbreviations

 Allow the configuration to specify no abbreviation regardless of
 the hash algorithm.

 Expecting a reroll.  The intent is very good.


* bc/rev-parse-path-format (2020-09-08) 1 commit
 - rev-parse: add option for absolute or relative path formatting

 "git rev-parse" can be explicitly told to give output as absolute
 or relative path.

 Expecting a reroll.
 cf. <20200909222333.GH241078@camp.crustytoothpaste.net>


* ar/fetch-transfer-ipversion (2020-09-16) 1 commit
 - config: option transfer.ipversion to set transport protocol version for network fetches

 Adds transfer.ipversion configuration variable.

 Needs more work.


* vv/send-email-with-less-secure-apps-access (2020-08-29) 1 commit
 - Documentation/git-send-email.txt: Mention less secure app access might need to enable.

 Doc update.

 Expecting a reroll.
 cf. <xmqqwo1hi9nv.fsf@gitster.c.googlers.com>
 cf. <xmqqft85i72s.fsf@gitster.c.googlers.com>


* jc/war-on-dashed-git (2020-08-27) 1 commit
 - git: catch an attempt to run "git-foo"

 The first step to remove on-disk binaries for built-in subcommands
 by soliciting objections.

 On hold for now.


* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Discard for now.
 cf. <xmqqv9gu7c61.fsf@gitster.c.googlers.com>
 cf. <20200911214358.acl3hy2e763begoo@feanor>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* mt/parallel-checkout-part-1 (2020-10-05) 20 commits
  (merged to 'next' on 2020-10-05 at 571e16d68a)
 + parallel-checkout: drop unused checkout state parameter
  (merged to 'next' on 2020-10-04 at 20438c1143)
 + ci: run test round with parallel-checkout enabled
 + parallel-checkout: add tests related to .gitattributes
 + parallel-checkout: add tests related to clone collisions
 + parallel-checkout: add tests for basic operations
 + checkout-index: add parallel checkout support
 + builtin/checkout.c: complete parallel checkout support
 + make_transient_cache_entry(): optionally alloc from mem_pool
 + parallel-checkout: support progress displaying
 + parallel-checkout: make it truly parallel
 + unpack-trees: add basic support for parallel checkout
 + entry: add checkout_entry_ca() which takes preloaded conv_attrs
 + entry: move conv_attrs lookup up to checkout_entry()
 + entry: extract cache_entry update from write_entry()
 + entry: make fstat_output() and read_blob_entry() public
 + entry: extract a header file for entry.c functions
 + convert: add conv_attrs classification
 + convert: add get_stream_filter_ca() variant
 + convert: add [async_]convert_to_working_tree_ca() variants
 + convert: make convert_attrs() and convert structs public

 Parallel checkout.

 Will cook in 'next'.


* dl/diff-merge-base (2020-09-21) 10 commits
 - contrib/completion: complete `git diff --merge-base`
 - builtin/diff-tree: learn --merge-base
 - builtin/diff-index: learn --merge-base
 - t4068: add --merge-base tests
 - diff-lib: define diff_get_merge_base()
 - diff-lib: accept option flags in run_diff_index()
 - contrib/completion: extract common diff/difftool options
 - git-diff.txt: backtick quote command text
 - git-diff-index.txt: make --cached description a proper sentence
 - t4068: remove unnecessary >tmp

 "git diff A...B" learned "git diff --merge-base A B", which is a
 longer short-hand to say the same thing.

 Expecting a reroll.
 cf. <xmqqblhyepup.fsf@gitster.c.googlers.com>


* sb/clone-origin (2020-09-30) 7 commits
 - clone: allow configurable default for `-o`/`--origin`
 - clone: read new remote name from remote_name instead of option_origin
 - clone: validate --origin option before use
 - refs: consolidate remote name validation
 - remote: add tests for add and rename with invalid names
 - clone: use more conventional config/option layering
 - clone: add tests for --template and some disallowed option pairs

 "git clone" learned clone.defaultremotename configuration variable
 to customize what nickname to use to call the remote the repository
 was cloned from.

 Will merge to 'next'.


* sk/force-if-includes (2020-10-03) 4 commits
  (merged to 'next' on 2020-10-04 at 09c4c1e088)
 + t, doc: update tests, reference for "--force-if-includes"
 + push: parse and set flag for "--force-if-includes"
 + push: add reflog check for "--force-if-includes"
 + Merge branch 'ds/in-merge-bases-many-optim-bug' into sk/force-if-includes

 "git push --force-with-lease[=<ref>]" can easily be misused to lose
 commits unless the user takes good care of their own "git fetch".
 A new option "--force-if-includes" attempts to ensure that what is
 being force-pushed was created after examining the commit at the
 tip of the remote ref that is about to be force-replaced.

 Will merge to 'master'.


* hn/reftable (2020-10-01) 13 commits
 . reftable: "test-tool dump-reftable" command.
 . reftable: rest of library
 . reftable: file level tests
 . reftable: read reftable files
 . reftable: write reftable files
 . reftable: a generic binary tree implementation
 . reftable: reading/writing blocks
 . reftable: (de)serialization for the polymorphic record type.
 . reftable: utility functions
 . reftable: add a barebones unittest framework
 . vcxproj: adjust for the reftable changes
 . reftable: define the public API
 . reftable: add LICENSE

 The reftable backend for the refs API.

 Expecting a reroll.
 Seems not to build for Windows folks.
 cf. <nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaqbjf.bet>
 cf. <nycvar.QRO.7.76.6.2010021557570.50@tvgsbejvaqbjf.bet>


* ds/maintenance-part-3 (2020-10-05) 7 commits
 - maintenance: add troubleshooting guide to docs
 - maintenance: use default schedule if not configured
 - maintenance: add start/stop subcommands
 - maintenance: add [un]register subcommands
 - for-each-repo: run subcommands on configured repos
 - maintenance: add --schedule option and config
 - maintenance: optionally skip --auto process
 (this branch uses ds/maintenance-part-2.)

 Parts of "git maintenance" to ease writing crontab entries (and
 other scheduling system configuration) for it.

 cf. <20201005195701.14268-1-martin.agren@gmail.com>


* es/config-hooks (2020-09-09) 9 commits
 - run_commit_hook: take strvec instead of varargs
 - commit: use config-based hooks
 - hook: replace run-command.h:find_hook
 - hook: add 'run' subcommand
 - parse-options: parse into strvec
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 Expecting a reroll.
 cf. <20201005212751.GH331156@google.com>


* mt/grep-sparse-checkout (2020-09-10) 9 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - config: make do_git_config_sequence receive a 'struct repository'
 - t/helper/test-config: unify exit labels
 - t/helper/test-config: diagnose missing arguments
 - t/helper/test-config: be consistent with exit codes
 - t1308-config-set: avoid false positives when using test-config
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.


* ds/maintenance-part-2 (2020-09-25) 8 commits
  (merged to 'next' on 2020-10-04 at c2a46f390c)
 + maintenance: add incremental-repack auto condition
 + maintenance: auto-size incremental-repack batch
 + maintenance: add incremental-repack task
 + midx: use start_delayed_progress()
 + midx: enable core.multiPackIndex by default
 + maintenance: create auto condition for loose-objects
 + maintenance: add loose-objects task
 + maintenance: add prefetch task
 (this branch is used by ds/maintenance-part-3.)

 "git maintenance", an extended big brother of "git gc", continues
 to evolve.

 Will cook in 'next'.
