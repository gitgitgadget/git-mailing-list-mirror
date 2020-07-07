Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F817C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 05:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A95520774
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 05:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CfRvTWqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgGGF5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:57:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62747 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgGGF5R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 01:57:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 60134D97A9;
        Tue,  7 Jul 2020 01:57:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=B
        yytVGr9Rf/x/B3M4ZlALeZ4Gpk=; b=CfRvTWqxvZjeYPalcmnFss/PDIq/N5pHA
        DcbCiV9G4wi6PDnzlw2UVfI6WP0Mm32ukjzgab1lsigRfkp6h+DnfLKMToB6dwpJ
        LTYAMhjGIaJZ2PY1BATadhoq22wgX/Cn1UxKkNiUZ42UKqmzjJvkztsTRCYy2yfQ
        9THcYpy8nA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=sn0
        +DwyAGv+YWSvX89BW3vFnIhCrS8SgBR2eyFtxFCvM1Oyk58ge24rGArCZ5jZn5cy
        Jbj6RM7bSbLlmbwP7GQYyISQ1zyss2kdzmEGSBvShUtJlPF2tU8lKOtP6SX0StEZ
        UxP8CHCStryWH0TMev3TgETKKTGdLH88OPw7oFII=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56402D97A8;
        Tue,  7 Jul 2020 01:57:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 834B8D97A7;
        Tue,  7 Jul 2020 01:57:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2020, #01; Mon, 6)
X-master-at: 4a0fcf9f760c9774be77f51e1e88a7499b53d2e2
X-next-at: b3809f4674cea6e2f5db8a478a39b85851690c7d
Date:   Mon, 06 Jul 2020 22:57:04 -0700
Message-ID: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B029441A-C016-11EA-A3D6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

We are about to tag the -rc0 "preview" and enter pre-release freeze
period.  The change to let users name the initial branch that gets
prepared in a newly created repository has now been merged to be
included in the upcoming release.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to 'master']

* ak/commit-graph-to-slab (2020-06-17) 4 commits
  (merged to 'next' on 2020-06-25 at 9a10ae18d3)
 + commit-graph: minimize commit_graph_data_slab access
 + commit: move members graph_pos, generation to a slab
 + commit-graph: introduce commit_graph_data_slab
 + object: drop parsed_object_pool->commit_count

 A few fields in "struct commit" that do not have to always be
 present have been moved to commit slabs.


* bc/http-push-flagsfix (2020-06-23) 1 commit
  (merged to 'next' on 2020-06-25 at 1dabb1f61b)
 + http-push: ensure unforced pushes fail when data would be lost

 The code to push changes over "dumb" HTTP had a bad interaction
 with the commit reachability code due to incorrect allocation of
 object flag bits, which has been corrected.


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
 (this branch uses bc/sha-256-part-2.)

 CVS/SVN interface have been prepared for SHA-256 transition


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
 (this branch is used by bc/sha-256-cvs-svn-updates.)

 SHA-256 migration work continues.


* cb/is-descendant-of (2020-06-23) 1 commit
  (merged to 'next' on 2020-06-25 at ca0eaddf5e)
 + commit-reach: avoid is_descendant_of() shim

 Code clean-up.


* dl/test-must-fail-fixes-5 (2020-06-24) 4 commits
  (merged to 'next' on 2020-06-29 at efe53a7588)
 + lib-submodule-update: pass 'test_must_fail' as an argument
 + lib-submodule-update: prepend "git" to $command
 + lib-submodule-update: consolidate --recurse-submodules
 + lib-submodule-update: add space after function name

 The effort to avoid using test_must_fail on non-git command continues.


* en/sparse-status (2020-06-22) 3 commits
  (merged to 'next' on 2020-06-25 at 404403a075)
 + git-prompt: include sparsity state as well
 + git-prompt: document how in-progress operations affect the prompt
 + wt-status: show sparse checkout status as well

 "git status" learned to report the status of sparse checkout.


* es/get-worktrees-unsort (2020-06-22) 2 commits
  (merged to 'next' on 2020-06-25 at 732d93a36d)
 + worktree: drop get_worktrees() unused 'flags' argument
 + worktree: drop get_worktrees() special-purpose sorting option

 API cleanup for get_worktrees()


* es/worktree-code-cleanup (2020-06-24) 1 commit
  (merged to 'next' on 2020-06-29 at 91ffd85a31)
 + worktree: avoid dead-code in conditional

 Code cleanup.


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


* jl/complete-git-prune (2020-06-22) 1 commit
  (merged to 'next' on 2020-06-25 at 64f30b8b41)
 + bash-completion: add git-prune into bash completion

 Add "git prune" to the completion (in contrib/), which could be
 typed by end-users from the command line.


* js/default-branch-name (2020-06-30) 10 commits
  (merged to 'next' on 2020-07-01 at c38d766581)
 + contrib: subtree: adjust test to change in fmt-merge-msg
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

 The name of the primary branch in existing repositories, and the
 default name used for the first branch in newly created
 repositories, is made configurable, so that we can eventually wean
 ourselves off of the hardcoded 'master'.


* js/diff-files-i-t-a-fix-for-difftool (2020-07-01) 2 commits
  (merged to 'next' on 2020-07-01 at cf5d18635c)
 + difftool -d: ensure that intent-to-add files are handled correctly
 + diff-files --raw: show correct post-image of intent-to-add files

 "git difftool" has trouble dealing with paths added to the index
 with the intent-to-add bit.


* js/pu-to-seen (2020-06-25) 3 commits
  (merged to 'next' on 2020-06-25 at 06c9e5a885)
 + tests: reference `seen` wherever `pu` was referenced
 + docs: adjust the technical overview for the rename `pu` -> `seen`
 + docs: adjust for the recent rename of `pu` to `seen`

 The documentation and some tests have been adjusted for the recent
 renaming of "pu" branch to "seen".


* mk/pb-pretty-email-without-domain-part-fix (2020-06-23) 1 commit
  (merged to 'next' on 2020-06-25 at 81a3aca46b)
 + doc: fix author vs. committer copy/paste error

 Docfix.


* ps/ref-transaction-hook (2020-06-19) 1 commit
  (merged to 'next' on 2020-06-22 at 3a23dcdbdc)
 + refs: implement reference transaction hook

 A new hook.


* rs/pack-bits-in-object-better (2020-06-24) 1 commit
  (merged to 'next' on 2020-06-25 at b3cb296341)
 + revision: reallocate TOPO_WALK object flags

 By renumbering object flag bits, "struct object" managed to lose
 bloated inter-field padding.

--------------------------------------------------
[New Topics]

* bw/fail-cloning-into-non-empty (2020-07-06) 1 commit
 - git clone: don't clone into non-empty directory

 "git clone --separate-git-dir=$elsewhere" used to stomp on the
 contents of the existing directory $elsewhere, which has been
 taught to fail when $elsewhere is not an empty directory.

 Expecting a reroll.
 with improved commit log message.
 cf. <xmqqv9j08dxo.fsf@gitster.c.googlers.com>


* cc/cat-file-usage-update (2020-07-01) 1 commit
  (merged to 'next' on 2020-07-06 at 270769a009)
 + cat-file: add missing [=<format>] to usage/synopsis

 Doc/usage update.

 Will merge to 'master'.


* cc/pretty-contents-size (2020-07-06) 2 commits
 - ref-filter: add support for %(contents:size)
 - Documentation: clarify %(contents:XXXX) doc

 "git for-each-ref --format=<>" learned %(contents:size).

 Expecting a reroll.
 with clarified semantics and tests with various object types
 cf. <xmqq5zb09v4e.fsf@gitster.c.googlers.com>


* ls/mergetool-meld-auto-merge (2020-07-06) 1 commit
 - Support auto-merge for meld to follow the vim-diff behavior

 The 'meld' backend of the "git mergetool" learned to give the
 underlying 'meld' the '--auto-merge' option, which would help
 reduce the amount of text that requires manual merging.

 Expecting a reroll.
 with final fixes and readability improvements.
 cf. <xmqqzh8c8eda.fsf@gitster.c.googlers.com>


* pb/log-rev-list-doc (2020-07-06) 4 commits
 - rev-list-description.txt: fix Asciidoc syntax
 - git-log.txt: include rev-list-description.txt
 - git-rev-list.txt: move description to separate file
 - git-log.txt: add links to 'rev-list' and 'diff' docs

 "git help log" has been enhanced by sharing more material from the
 documentation for the underlying "git rev-list" command.

 Expecting a reroll.
 with reordering the last one to make it preparatory clean-up.
 cf. <xmqqimf087pq.fsf@gitster.c.googlers.com>
 cf. <xmqqeepo87hz.fsf@gitster.c.googlers.com>


* rs/line-log-until (2020-07-06) 1 commit
  (merged to 'next' on 2020-07-06 at 84d6bc67fa)
 + revision: disable min_age optimization with line-log

 "git log -Lx,y:path --before=date" lost track of where the range
 should be because it didn't take the changes made by the youngest
 commits that are omitted from the output into account.

 Will merge to 'master'.


* ta/wait-on-aliased-commands-upon-signal (2020-07-06) 2 commits
 - Wait for child on signal death for aliases to externals
 - Wait for child on signal death for aliases to builtins

 When an aliased command, whose output is piped to a pager by git,
 gets killed by a signal, the pager got into a funny state, which
 has been corrected (again).

 Expecting a reroll.
 with improved log messages.
 cf. <20200706211403.GB85133@coredump.intra.peff.net>


* tb/upload-pack-filters (2020-07-06) 4 commits
 - upload-pack.c: introduce 'uploadpack.filter.tree.maxDepth'
 - upload-pack.c: pass 'struct list_objects_filter_options *'
 - upload-pack.c: allow banning certain object filter(s)
 - list_objects_filter_options: introduce 'list_object_filter_config_name'

 The component to respond to "git fetch" request is made more
 configurable to selectively allow or reject object filtering
 specification used for partial cloning.

 Waiting for reviews.
 cf. <cover.1593720075.git.me@ttaylorr.com>


* vs/completion-with-set-u (2020-07-01) 1 commit
  (merged to 'next' on 2020-07-06 at 72b1eca511)
 + completion: nounset mode fixes

 The command line completion support (in contrib/) used to be
 prepared to work with "set -u" but recent changes got a bit more
 sloppy.  This has been corrected.

 Will merge to 'master'.

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

* mt/hash-to-hex-thread-safety (2020-06-26) 2 commits
 - hex: make hash_to_hex_algop() and friends thread-safe
 - compat/win32/pthread: add pthread_once()

 hash_to_hex() used a set of rotating static buffers, which was not
 safe to use in a threaded environment.  This has been made safer by
 using thread-local storage.

 Expecting a reroll.
 cf. <CAHd-oW6A2aBHg80R9kyifvF7thwzam5EYYoN9d2TaBcHJrcKWw@mail.gmail.com>


* mf/submodule-summary-with-correct-repository (2020-06-24) 2 commits
 - submodule: use submodule repository when preparing summary
 - revision: use repository from rev_info when parsing commits

 "git diff/show" on a change that involves a submodule used to read
 the information on commits in the submodule from a wrong repository
 and gave a wrong information when the commit-graph is involved.

 Needs tests.


* ra/send-email-in-reply-to-from-command-line-wins (2020-07-01) 1 commit
  (merged to 'next' on 2020-07-06 at 3892a1ab88)
 + send-email: restore --in-reply-to superseding behavior

 "git send-email --in-reply-to=<msg>" did not use the In-Reply-To:
 header with the value given from the command line, and let it be
 overridden by the value on In-Reply-To: header in the messages
 being sent out (if exists).

 Will merge to 'master'.


* ds/commit-graph-bloom-updates (2020-07-01) 10 commits
  (merged to 'next' on 2020-07-06 at 177e6b362e)
 + commit-graph: check all leading directories in changed path Bloom filters
 + revision: empty pathspecs should not use Bloom filters
 + revision.c: fix whitespace
 + commit-graph: check chunk sizes after writing
 + commit-graph: simplify chunk writes into loop
 + commit-graph: unify the signatures of all write_graph_chunk_*() functions
 + commit-graph: persist existence of changed-paths
 + bloom: fix logic in get_bloom_filter()
 + commit-graph: change test to die on parse, not load
 + commit-graph: place bloom_settings in context
 (this branch uses sg/commit-graph-cleanups.)

 Updates to the changed-paths bloom filter.

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


* sg/commit-graph-cleanups (2020-06-08) 10 commits
 + commit-graph: simplify write_commit_graph_file() #2
 + commit-graph: simplify write_commit_graph_file() #1
 + commit-graph: simplify parse_commit_graph() #2
 + commit-graph: simplify parse_commit_graph() #1
 + commit-graph: clean up #includes
 + diff.h: drop diff_tree_oid() & friends' return value
 + commit-slab: add a function to deep free entries on the slab
 + commit-graph-format.txt: all multi-byte numbers are in network byte order
 + commit-graph: fix parsing the Chunk Lookup table
 + tree-walk.c: don't match submodule entries for 'submod/anything'
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


* hn/reftable (2020-07-06) 4 commits
 - Treat BISECT_HEAD as a pseudo ref
 - checkout: add '\n' to reflog message
 - t3432: use git-reflog to inspect the reflog for HEAD
 - lib-t6000.sh: write tag using git-update-ref

 Preliminary clean-up of the refs API in preparation for adding a
 new refs backend "reftable".

 Expecting a reroll.
 The second one should be dropped, and possibly replaced with a
 patch that moves message normalization from backends to the more
 generic layer.
 cf. <xmqqmu4ca31g.fsf@gitster.c.googlers.com>

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
