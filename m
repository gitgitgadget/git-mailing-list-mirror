Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0564C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 01:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E62A207E8
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 01:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GsQqwubX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgF3BAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 21:00:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60036 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgF3BAU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 21:00:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0CD883FCD;
        Mon, 29 Jun 2020 21:00:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=H
        aKetAQNpzAYUR8jmnzkve5YRt0=; b=GsQqwubXl7v8k6RKyd4igaj3A8aLz8W0t
        /S8LPmdD1gkUeo+pqPx3P4PndgvP0c5P2KgG7GG8f0BpoN1NXoOF2DuyF4h4leQF
        DCSfyJVo+rtQELCh6QP3BzTa/eRL9YRpdBN6u4LojHSAFkZLlGh4wcyObHBV+C1+
        2h/tt3Fbys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=v0A
        2aM0usvrbNkR/3ikncyzq5bC2fvUWTMxyhr9fWPF76H/zyJCfVk6LhjKQXgGirlm
        Z04Pk85b1V+hx1UPciOJb9I5qVW4b8cXaumk4CiyFavKjRbu3P34a8T/HiF9u3D1
        6sY/fznIiKeoliGThBHaB4HqXm+nYDROU+WdMVjQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A74E083FCC;
        Mon, 29 Jun 2020 21:00:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E694B83FC9;
        Mon, 29 Jun 2020 21:00:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2020, #06; Mon, 29)
X-master-at: a08a83db2bf27f015bec9a435f6d73e223c21c5e
X-next-at: 050319c2ae82f2fac00eac9d80a1d91394d99aec
Date:   Mon, 29 Jun 2020 18:00:11 -0700
Message-ID: <xmqqa70lfjvo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CF33840-BA6D-11EA-A956-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

More topics graduate to the 'master' and to the 'next' branches.  I
expect that this week would be slower than usual due to US holidays
but hopefully we'd be able to merge most of the impactful topics by
the -rc0.  Some large-ish topics may have to be left for the next
cycle, as usual.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* dl/diff-usage-comment-update (2020-06-23) 2 commits
  (merged to 'next' on 2020-06-23 at 48d685cd45)
 + builtin/diff: fix botched update of usage comment
  (merged to 'next' on 2020-06-19 at b53a12bb66)
 + builtin/diff: update usage comment

 An in-code comment in "git diff" has been updated.


* rs/commit-reach-leakfix (2020-06-19) 1 commit
  (merged to 'next' on 2020-06-22 at fcc1e385f0)
 + commit-reach: plug minor memory leak after using is_descendant_of()

 Leakfix.


* rs/pull-leakfix (2020-06-19) 1 commit
  (merged to 'next' on 2020-06-22 at d80a6b9ca3)
 + pull: plug minor memory leak after using is_descendant_of()

 Leakfix.


* rs/retire-strbuf-write-fd (2020-06-19) 2 commits
  (merged to 'next' on 2020-06-22 at c175b54f2a)
 + strbuf: remove unreferenced strbuf_write_fd method.
 + bugreport.c: replace strbuf_write_fd with write_in_full

 A misdesigned strbuf_write_fd() function has been retired.


* sk/diff-files-show-i-t-a-as-new (2020-06-22) 1 commit
  (merged to 'next' on 2020-06-22 at 825a823416)
 + diff-files: treat "i-t-a" files as "not-in-index"
 (this branch is used by js/diff-files-i-t-a-fix-for-difftool.)

 "git diff-files" has been taught to say paths that are marked as
 intent-to-add are new files, not modified from an empty blob.


* xl/upgrade-repo-format (2020-06-05) 4 commits
  (merged to 'next' on 2020-06-19 at 02bf7a9d8c)
 + check_repository_format_gently(): refuse extensions for old repositories
 + sparse-checkout: upgrade repository to version 1 when enabling extension
 + fetch: allow adding a filter after initial clone
 + repository: add a helper function to perform repository format upgrade

 Allow runtime upgrade of the repository format version, which needs
 to be done carefully.

 There is a rather unpleasant backward compatibility worry with the
 last step of this series, but it is the right thing to do in the
 longer term.

--------------------------------------------------
[New Topics]

* mt/hash-to-hex-thread-safety (2020-06-26) 2 commits
 - hex: make hash_to_hex_algop() and friends thread-safe
 - compat/win32/pthread: add pthread_once()

 hash_to_hex() used a set of rotating static buffers, which was not
 safe to use in a threaded environment.  This has been made safer by
 using thread-local storage.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Expecting a reroll.
 cf. <20200416152145.wp2zeibxmuyas6y6@feanor>


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

 Expecting a response to reviews.
 cf. <nycvar.QRO.7.76.6.2005230007260.56@tvgsbejvaqbjf.bet>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* bc/http-push-flagsfix (2020-06-23) 1 commit
  (merged to 'next' on 2020-06-25 at 1dabb1f61b)
 + http-push: ensure unforced pushes fail when data would be lost

 The code to push changes over "dumb" HTTP had a bad interaction
 with the commit reachability code due to incorrect allocation of
 object flag bits, which has been corrected.

 Will merge to 'master'.


* cb/is-descendant-of (2020-06-23) 1 commit
  (merged to 'next' on 2020-06-25 at ca0eaddf5e)
 + commit-reach: avoid is_descendant_of() shim

 Code clean-up.

 Will merge to 'master'.


* jk/fast-export-anonym-alt (2020-06-25) 11 commits
  (merged to 'next' on 2020-06-29 at 8a8d83e2ca)
 + fast-export: use local array to store anonymized oid
 + fast-export: anonymize "master" refname
 + fast-export: allow seeding the anonymized mapping
 + fast-export: add a "data" callback parameter to anonymize_str()
 + fast-export: move global "idents" anonymize hashmap into function
 + fast-export: use a flex array to store anonymized entries
 + fast-export: stop storing lengths in anonymized hashmaps
 + fast-export: tighten anonymize_mem() interface to handle only strings
 + fast-export: store anonymized oids as hex strings
 + fast-export: use xmemdupz() for anonymizing oids
 + t9351: derive anonymized tree checks from original repo

 "git fast-export --anonymize" learned to take customized mapping to
 allow its users to tweak its output more usable for debugging.

 Will merge to 'master'.


* js/diff-files-i-t-a-fix-for-difftool (2020-06-25) 2 commits
  (merged to 'next' on 2020-06-29 at a9fcdabb3b)
 + difftool -d: ensure that intent-to-add files are handled correctly
 + diff-files --raw: show correct post-image of intent-to-add files

 "git difftool" has trouble dealing with paths added to the index
 with the intent-to-add bit.

 Will merge to 'master'.


* js/pu-to-seen (2020-06-25) 3 commits
  (merged to 'next' on 2020-06-25 at 06c9e5a885)
 + tests: reference `seen` wherever `pu` was referenced
 + docs: adjust the technical overview for the rename `pu` -> `seen`
 + docs: adjust for the recent rename of `pu` to `seen`

 The documentation and some tests have been adjusted for the recent
 renaming of "pu" branch to "seen".

 Will merge to 'master'.


* mk/pb-pretty-email-without-domain-part-fix (2020-06-23) 1 commit
  (merged to 'next' on 2020-06-25 at 81a3aca46b)
 + doc: fix author vs. committer copy/paste error

 Docfix.

 Will merge to 'master'.


* mf/submodule-summary-with-correct-repository (2020-06-24) 2 commits
 - submodule: use submodule repository when preparing summary
 - revision: use repository from rev_info when parsing commits

 "git diff/show" on a change that involves a submodule used to read
 the information on commits in the submodule from a wrong repository
 and gave a wrong information when the commit-graph is involved.

 Needs tests.


* rs/pack-bits-in-object-better (2020-06-24) 1 commit
  (merged to 'next' on 2020-06-25 at b3cb296341)
 + revision: reallocate TOPO_WALK object flags

 By renumbering object flag bits, "struct object" managed to lose
 bloated inter-field padding.

 Will merge to 'master'.


* es/worktree-code-cleanup (2020-06-24) 1 commit
  (merged to 'next' on 2020-06-29 at 91ffd85a31)
 + worktree: avoid dead-code in conditional

 Code cleanup.

 Will merge to 'master'.


* ra/send-email-in-reply-to-from-command-line-wins (2020-06-29) 1 commit
 - send-email: restore --in-reply-to superseding behavior

 "git send-email --in-reply-to=<msg>" did not use the In-Reply-To:
 header with the value given from the command line, and let it be
 overridden by the value on In-Reply-To: header in the messages
 being sent out (if exists).

 Expecting a reroll/redesign.
 Does not behave sensibly for a multi-patch series.


* en/sparse-status (2020-06-22) 3 commits
  (merged to 'next' on 2020-06-25 at 404403a075)
 + git-prompt: include sparsity state as well
 + git-prompt: document how in-progress operations affect the prompt
 + wt-status: show sparse checkout status as well

 "git status" learned to report the status of sparse checkout.

 Will merge to 'master'.


* ps/ref-transaction-hook (2020-06-19) 1 commit
  (merged to 'next' on 2020-06-22 at 3a23dcdbdc)
 + refs: implement reference transaction hook

 A new hook.

 Will merge to 'master'.


* bc/sha-256-cvs-svn-updates (2020-06-22) 14 commits
  (merged to 'next' on 2020-06-25 at e0d1c87fcf)
 + git-cvsexportcommit: port to SHA-256
 + git-cvsimport: port to SHA-256
 + git-cvsserver: port to SHA-256
 + git-svn: set the OID length based on hash algorithm
 + perl: make SVN code hash independent
 + perl: make Git::IndexInfo work with SHA-256
 + perl: create and switch variables for hash constants
 + t/lib-git-svn: make hash size independent
 + t9101: make hash independent
 + t9104: make hash size independent
 + t9100: make test work with SHA-256
 + t9108: make test hash independent
 + t9168: make test hash independent
 + t9109: make test hash independent
 (this branch uses bc/sha-256-part-2; is tangled with hn/reftable.)

 CVS/SVN interface have been prepared for SHA-256 transition

 Will merge to 'master'.


* ds/commit-graph-bloom-updates (2020-06-26) 10 commits
 - commit-graph: check all leading directories in changed path Bloom filters
 - revision: empty pathspecs should not use Bloom filters
 - revision.c: fix whitespace
 - commit-graph: check chunk sizes after writing
 - commit-graph: simplify chunk writes into loop
 - commit-graph: unify the signatures of all write_graph_chunk_*() functions
 - commit-graph: persist existence of changed-paths
 - bloom: fix logic in get_bloom_filter()
 - commit-graph: change test to die on parse, not load
 - commit-graph: place bloom_settings in context
 (this branch uses sg/commit-graph-cleanups.)

 Updates to the changed-paths bloom filter.

 Will merge to 'next'.


* es/get-worktrees-unsort (2020-06-22) 2 commits
  (merged to 'next' on 2020-06-25 at 732d93a36d)
 + worktree: drop get_worktrees() unused 'flags' argument
 + worktree: drop get_worktrees() special-purpose sorting option

 API cleanup for get_worktrees()

 Will merge to 'master'.


* jl/complete-git-prune (2020-06-22) 1 commit
  (merged to 'next' on 2020-06-25 at 64f30b8b41)
 + bash-completion: add git-prune into bash completion

 Add "git prune" to the completion (in contrib/), which could be
 typed by end-users from the command line.

 Will merge to 'master'.


* js/default-branch-name (2020-06-24) 9 commits
  (merged to 'next' on 2020-06-25 at 8f962f9219)
 + testsvn: respect `init.defaultBranch`
 + remote: use the configured default branch name when appropriate
 + clone: use configured default branch name when appropriate
 + init: allow setting the default for the initial branch name via the config
 + init: allow specifying the initial branch name for the new repository
 + docs: add missing diamond brackets
 + submodule: fall back to remote's HEAD for missing remote.<name>.branch
 + send-pack/transport-helper: avoid mentioning a particular branch
 + fmt-merge-msg: stop treating `master` specially
 (this branch is used by hn/reftable.)

 The name of the primary branch in existing repositories, and the
 default name used for the first branch in newly created
 repositories, is made configurable, so that we can eventually wean
 ourselves off of the hardcoded 'master'.

 Will merge to 'master'.


* ss/cmake-build (2020-06-26) 8 commits
 - ci: modification of main.yml to use cmake for vs-build job
 - cmake: support for building git on windows with msvc and clang.
 - cmake: support for building git on windows with mingw
 - cmake: support for testing git when building out of the source tree
 - cmake: support for testing git with ctest
 - cmake: installation support for git
 - cmake: generate the shell/perl/python scripts and templates, translations
 - Introduce CMake support for configuring Git

 CMake support to build with MSVC for Windows bypassing the Makefile.

 Waiting for a (hopefully final) review.


* ak/commit-graph-to-slab (2020-06-17) 4 commits
  (merged to 'next' on 2020-06-25 at 9a10ae18d3)
 + commit-graph: minimize commit_graph_data_slab access
 + commit: move members graph_pos, generation to a slab
 + commit-graph: introduce commit_graph_data_slab
 + object: drop parsed_object_pool->commit_count

 A few fields in "struct commit" that do not have to always be
 present have been moved to commit slabs.

 Will merge to 'master'.


* dl/test-must-fail-fixes-5 (2020-06-24) 4 commits
  (merged to 'next' on 2020-06-29 at efe53a7588)
 + lib-submodule-update: pass 'test_must_fail' as an argument
 + lib-submodule-update: prepend "git" to $command
 + lib-submodule-update: consolidate --recurse-submodules
 + lib-submodule-update: add space after function name

 The effort to avoid using test_must_fail on non-git command continues.

 Will merge to 'master'.


* sg/commit-graph-cleanups (2020-06-08) 10 commits
 - commit-graph: simplify write_commit_graph_file() #2
 - commit-graph: simplify write_commit_graph_file() #1
 - commit-graph: simplify parse_commit_graph() #2
 - commit-graph: simplify parse_commit_graph() #1
 - commit-graph: clean up #includes
 - diff.h: drop diff_tree_oid() & friends' return value
 - commit-slab: add a function to deep free entries on the slab
 - commit-graph-format.txt: all multi-byte numbers are in network byte order
 - commit-graph: fix parsing the Chunk Lookup table
 - tree-walk.c: don't match submodule entries for 'submod/anything'
 (this branch is used by ds/commit-graph-bloom-updates.)

 The changed-path Bloom filter is improved using ideas from an
 independent implementation.

 Under review.
 cf. <20200627155610.GN2898@szeder.dev>
 cf. <20200627163335.GO2898@szeder.dev>
 cf. <20200627155348.GM2898@szeder.dev>


* es/config-hooks (2020-05-21) 4 commits
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 What's the status of this one?  Abandoned?


* pw/rebase-i-more-options (2020-06-26) 5 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_free
 - rebase -i: support --committer-date-is-author-date
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.

 Waiting for a (hopefully final) review.


* mt/grep-sparse-checkout (2020-06-12) 6 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - t/helper/test-config: facilitate addition of new cli options
 - t/helper/test-config: return exit codes consistently
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.

 Review needed on 4/6; otherwise looking sane.
 cf. <CABPp-BGdEyEeajYZj_rdxp=MyEQdszuyjVTax=hhYj3fOtRQUQ@mail.gmail.com>


* bc/sha-256-part-2 (2020-06-19) 44 commits
  (merged to 'next' on 2020-06-22 at dc153f366d)
 + remote-testgit: adapt for object-format
 + bundle: detect hash algorithm when reading refs
 + t5300: pass --object-format to git index-pack
 + t5704: send object-format capability with SHA-256
 + t5703: use object-format serve option
 + t5702: offer an object-format capability in the test
 + t/helper: initialize the repository for test-sha1-array
 + remote-curl: avoid truncating refs with ls-remote
 + t1050: pass algorithm to index-pack when outside repo
 + builtin/index-pack: add option to specify hash algorithm
 + remote-curl: detect algorithm for dumb HTTP by size
 + builtin/ls-remote: initialize repository based on fetch
 + t5500: make hash independent
 + serve: advertise object-format capability for protocol v2
 + connect: parse v2 refs with correct hash algorithm
 + connect: pass full packet reader when parsing v2 refs
 + Documentation/technical: document object-format for protocol v2
 + t1302: expect repo format version 1 for SHA-256
 + builtin/show-index: provide options to determine hash algo
 + t5302: modernize test formatting
 + packfile: compute and use the index CRC offset
 + t3200: mark assertion with SHA1 prerequisite
 + setup: set the_repository's hash algo when checking format
 + fetch-pack: parse and advertise the object-format capability
 + t5562: pass object-format in synthesized test data
 + builtin/clone: initialize hash algorithm properly
 + remote-curl: implement object-format extensions
 + transport-helper: implement object-format extensions
 + docs: update remote helper docs for object-format extensions
 + builtin/receive-pack: detect when the server doesn't support our hash
 + connect: detect algorithm when fetching refs
 + fetch-pack: detect when the server doesn't support our hash
 + connect: make parse_feature_value extern
 + send-pack: detect when the server doesn't support our hash
 + connect: add function to detect supported v1 hash functions
 + transport: add a hash algorithm member
 + pkt-line: add a member for hash algorithm
 + connect: add function to fetch value of a v2 server capability
 + connect: add function to parse multiple v1 capability values
 + remote: advertise the object-format capability on the server side
 + wrapper: add function to compare strings with different NUL termination
 + connect: have ref processing code take struct packet_reader
 + Documentation: document v1 protocol object-format capability
 + t1050: match object ID paths in a hash-insensitive way
 (this branch is used by bc/sha-256-cvs-svn-updates and hn/reftable.)

 SHA-256 migration work continues.

 Will merge to 'master'.


* jx/proc-receive-hook (2020-05-18) 11 commits
 - doc: add documentation for the proc-receive hook
 - transport: parse report options for tracking refs
 - t5411: test updates of remote-tracking branches
 - receive-pack: new config receive.procReceiveRefs
 - refs.c: refactor to reuse ref_is_hidden()
 - receive-pack: feed report options to post-receive
 - doc: add document for capability report-status-v2
 - New capability "report-status-v2" for git-push
 - receive-pack: add new proc-receive hook
 - t5411: add basic test cases for proc-receive hook
 - transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Needs review.


* hn/reftable (2020-06-29) 23 commits
 - fixup! Reftable support for git-core
 - Add "test-tool dump-reftable" command.
 - Add reftable testing infrastructure
 - git-prompt: prepare for reftable refs backend
 - vcxproj: adjust for the reftable changes
 - Add GIT_DEBUG_REFS debugging mechanism
 - Hookup unittests for the reftable library.
 - Reftable support for git-core
 - Add standalone build infrastructure for reftable
 - Add reftable library
 - Add .gitattributes for the reftable/ directory
 - Iterate over the "refs/" namespace in for_each_[raw]ref
 - Move REF_LOG_ONLY to refs-internal.h
 - Treat REVERT_HEAD as a pseudo ref
 - Treat CHERRY_PICK_HEAD as a pseudo ref
 - Treat BISECT_HEAD as a pseudo ref
 - Make refs_ref_exists public
 - Write pseudorefs through ref backends.
 - checkout: add '\n' to reflog message
 - t3432: use git-reflog to inspect the reflog for HEAD
 - lib-t6000.sh: write tag using git-update-ref
 - Merge branch 'bc/sha-256-part-2' into HEAD
 - Merge branch 'js/default-branch-name' into HEAD
 (this branch uses bc/sha-256-part-2 and js/default-branch-name; is tangled with bc/sha-256-cvs-svn-updates.)

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

--------------------------------------------------
[Discarded]

* jc/credential-store-file-format-doc (2020-04-27) 1 commit
 . credential-store: document the file format a bit more

 Now has become a part of Carlo's credential-store fix patches.


* js/ci-skip-on-github-workflow (2020-05-02) 1 commit
 . ci: respect the [skip ci] convention in our GitHub workflow "CI/PR"

 Allow contributors to mark a branch/push that it does not have to
 be built via GitHub actions, in a way similar to how Travis lets
 them mark the commits with an embedded "[skip ci]" string.

 Superseded by dd/ci-only-on-selective-branches topic.


* dd/ci-only-on-selective-branches (2020-05-05) 2 commits
 - CI: limit GitHub Actions to designated branches
 - SubmittingPatches: advertise GitHub Actions CI

 Instead of always building all branches of all forks of our project
 at GitHub via GitHub Actions, only build when branches with known
 and specific names are updated, and also a pull request.

 Superseded by jk/ci-only-on-selected-branches


* jk/fast-export-anonym (2020-06-22) 4 commits
  (merged to 'next' on 2020-06-22 at b517b2f707)
 + fast-export: allow dumping the path mapping
 + fast-export: refactor path printing to not rely on stdout
 + fast-export: anonymize "master" refname
 + fast-export: allow dumping the refname mapping

 The way refnames are anonymized has been updated and a way to help
 debugging using the anonymized output hsa been added.

 Superseded by 'jk/fast-export-anonym-alt'.
