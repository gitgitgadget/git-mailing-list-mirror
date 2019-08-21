Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F110E1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 22:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfHUWYO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 18:24:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53708 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbfHUWYO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 18:24:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F7E716F53F;
        Wed, 21 Aug 2019 18:23:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=I
        WhpvDUItlN6UD+5kK2G7PRXvCA=; b=laNNHnRWYxp/vcOyRFQSpw19G4icqkg0f
        4wzItMzG0s1nquRedPDbkxAIss8TnkBHHi2yrM4VxRgMacJtQa9x+GjXaaPdqQZE
        HvwBXDib9VvgjHuZNbjT6RnT0MTdRwDRoz11Lfr8u1goHHi/ZKxEY/UcWtsAqqk4
        NUBisR69vE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=ehV
        /ynXQnhVPypUYtRoNfQ2r9Lo1JROe38oYVQ9RRW77BAZWzC7bje1P9iT0SyZ1SPD
        oR3gkktkWQ3cinfTUB+nZTTQ5KjqrJZqBhBx/xdPLjB4l5XPxkKLORCrICQIbJgr
        I5U103wK/FDRVvGYe+uLlfb4otfHA9KDU+M/c3Hc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6733516F53D;
        Wed, 21 Aug 2019 18:23:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1A6216F53C;
        Wed, 21 Aug 2019 18:23:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2019, #05; Wed, 21)
X-master-at: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
X-next-at: 17f5b7556cbe9867bed85982f386e41d9db77e19
Date:   Wed, 21 Aug 2019 15:23:57 -0700
Message-ID: <xmqqr25eqhs2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EC69164-C462-11E9-B47A-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The first batch of topics post 2.23 will be merged to 'master' and
'next' will be rewound to become empty, soon.  After that, 'next'
will grow merging only smaller fixes and cleanup topics first.
Bigger stuff will then follow after the dust settles.  All of the
above hopefully will happen before the end of the month.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* cb/curl-use-xmalloc (2019-08-15) 1 commit
 - http: use xmalloc with cURL
 (this branch uses jk/drop-release-pack-memory.)

 Tell cURL library to use the same malloc() implementation, with the
 xmalloc() wrapper, as the rest of the system, for consistency.

 Will merge to 'next'.


* sg/diff-indent-heuristic-non-experimental (2019-08-15) 1 commit
 - diff: 'diff.indentHeuristic' is no longer experimental

 We promoted the "indent heuristics" that decides where to split
 diff hunks from experimental to the default a few years ago, but
 some stale documentation still marked it as experimental, which has
 been corrected.

 Will merge to 'next'.


* en/checkout-mismerge-fix (2019-08-16) 1 commit
 - checkout: remove duplicate code

 Fix a mismerge that happened in 2.22 timeframe.

 Will merge to 'next'.


* en/merge-recursive-cleanup (2019-08-19) 24 commits
 - merge-recursive: alphabetize include list
 - merge-recursive: add sanity checks for relevant merge_options
 - merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
 - merge-recursive: split internal fields into a separate struct
 - merge-recursive: avoid losing output and leaking memory holding that output
 - merge-recursive: comment and reorder the merge_options fields
 - merge-recursive: consolidate unnecessary fields in merge_options
 - merge-recursive: move some definitions around to clean up the header
 - merge-recursive: rename merge_options argument to opt in header
 - merge-recursive: rename 'mrtree' to 'result_tree', for clarity
 - merge-recursive: use common name for ancestors/common/base_list
 - merge-recursive: fix some overly long lines
 - cache-tree: share code between functions writing an index as a tree
 - merge-recursive: don't force external callers to do our logging
 - merge-recursive: remove useless parameter in merge_trees()
 - merge-recursive: exit early if index != head
 - Ensure index matches head before invoking merge machinery, round N
 - merge-recursive: remove another implicit dependency on the_repository
 - merge-recursive: future-proof update_file_flags() against memory leaks
 - merge-recursive: introduce an enum for detect_directory_renames values
 - merge-recursive: provide a better label for diff3 common ancestor
 - merge-recursive: enforce opt->ancestor != NULL when calling merge_trees()
 - checkout: provide better conflict hunk description with detached HEAD
 - merge-recursive: be consistent with assert

 The merge-recursive machiery is one of the most complex parts of
 the system that accumulated cruft over time.  This large series
 cleans up the implementation quite a bit.

 Will merge to 'next'.


* bc/hash-independent-tests-part-5 (2019-08-20) 14 commits
 - t4009: make hash size independent
 - t4002: make hash independent
 - t4000: make hash size independent
 - t3903: abstract away SHA-1-specific constants
 - t3800: make hash-size independent
 - t3600: make hash size independent
 - t3506: make hash independent
 - t3430: avoid hard-coded object IDs
 - t3404: abstract away SHA-1-specific constants
 - t3306: abstract away SHA-1-specific constants
 - t3305: make hash size independent
 - t3301: abstract away SHA-1-specific constants
 - t3206: abstract away hash size constants
 - t3201: abstract away SHA-1-specific constants

 Preparation for SHA-256 upgrade continues in the test department.

 Expecting a reroll.
 cf. <20190818203417.GG365197@genre.crustytoothpaste.net>


* bc/object-id-part17 (2019-08-19) 26 commits
 - midx: switch to using the_hash_algo
 - builtin/show-index: replace sha1_to_hex
 - rerere: replace sha1_to_hex
 - builtin/receive-pack: replace sha1_to_hex
 - builtin/index-pack: replace sha1_to_hex
 - packfile: replace sha1_to_hex
 - wt-status: convert struct wt_status to object_id
 - cache: remove null_sha1
 - builtin/worktree: switch null_sha1 to null_oid
 - builtin/repack: write object IDs of the proper length
 - pack-write: use hash_to_hex when writing checksums
 - sequencer: convert to use the_hash_algo
 - bisect: switch to using the_hash_algo
 - sha1-lookup: switch hard-coded constants to the_hash_algo
 - config: use the_hash_algo in abbrev comparison
 - combine-diff: replace GIT_SHA1_HEXSZ with the_hash_algo
 - bundle: switch to use the_hash_algo
 - connected: switch GIT_SHA1_HEXSZ to the_hash_algo
 - show-index: switch hard-coded constants to the_hash_algo
 - blame: remove needless comparison with GIT_SHA1_HEXSZ
 - builtin/rev-parse: switch to use the_hash_algo
 - builtin/blame: switch uses of GIT_SHA1_HEXSZ to the_hash_algo
 - builtin/receive-pack: switch to use the_hash_algo
 - fetch-pack: use parse_oid_hex
 - patch-id: convert to use the_hash_algo
 - builtin/replace: make hash size independent

 Preparation for SHA-256 upgrade continues.

 Looked mostly OK, with a possible update.
 cf. <20190820223606.GJ365197@genre.crustytoothpaste.net>


* bm/repository-layout-typofix (2019-08-19) 1 commit
 - repository-layout.txt: correct pluralization of 'object'

 Typofix.

 Will merge to 'next'.


* bw/rebase-autostash-keep-current-branch (2019-08-21) 1 commit
 - rebase.c: make sure the active branch isn't moved when autostashing

 "git rebase --autostash <upstream> <branch>", when <branch> is
 different from the current branch, incorrectly moved the tip of the
 current branch, which has been corrected.


* dl/format-patch-cover-letter-subject (2019-08-21) 1 commit
 - format-patch: learn --infer-cover-subject option
 (this branch uses dl/format-patch-doc-test-cleanup.)

 "git format-patch --cover-letter" learned to optionally use the
 first paragraph (typically a single-liner) of branch.*.description
 as the subject of the cover letter.


* dl/format-patch-doc-test-cleanup (2019-08-21) 14 commits
 - config/format.txt: specify default value of format.coverLetter
 - SQUASH???
 - Doc: add more detail for git-format-patch
 - SQUASH???
 - t4014: stop losing return codes of git commands
 - t4014: remove confusing pipe in check_threading()
 - t4014: use test_line_count() where possible
 - t4014: drop redirections to /dev/null
 - t4014: use indentable here-docs
 - t4014: remove spaces after redirect operators
 - t4014: use sq for test case names
 - t4014: move closing sq onto its own line
 - t4014: s/expected/expect/
 - t4014: drop unnecessary blank lines from test cases
 (this branch is used by dl/format-patch-cover-letter-subject.)

 The documentation and tests for "git format-patch" have been
 cleaned up.


* ds/midx-expire-repack (2019-08-20) 1 commit
 - packfile.h: drop extern from function declaration

 Code cleanup.

 Will merge to 'next'.


* jt/diff-lazy-fetch-submodule-fix (2019-08-20) 1 commit
 - diff: skip GITLINK when lazy fetching missing objs

 On-demand object fetching in lazy clone incorrectly tried to fetch
 commits from submodule projects, while still working in the
 superproject, which has been corrected.

 Will merge to 'next'.


* mp/for-each-ref-missing-name-or-email (2019-08-19) 1 commit
 - ref-filter: initialize empty name or email fields

 "for-each-ref" and friends that shows refs did not protect themselves
 against ancient tags that did not record tagger names when asked to
 show "%(taggername)", which have been corrected.

 May want a test or two.


* nd/diff-parseopt (2019-08-20) 1 commit
 - parseopt: move definition of enum parse_opt_result up

 Compilation fix.

 Will merge to 'next'.


* pw/rebase-i-show-HEAD-to-reword (2019-08-19) 3 commits
 - sequencer: simplify root commit creation
 - rebase -i: check for updated todo after squash and reword
 - rebase -i: always update HEAD before rewording

 "git rebase -i" showed a wrong HEAD while "reword" open the editor.

 May want to split out the last one into a separate topic.
 Will merge to 'next'.


* rs/pax-extended-header-length-fix (2019-08-19) 4 commits
 - archive-tar: turn length miscalculation warning into BUG
 - archive-tar: use size_t in strbuf_append_ext_header()
 - archive-tar: fix pax extended header length calculation
 - archive-tar: report wrong pax extended header length

 "git archive" recorded incorrect length in extended pax header in
 some corner cases, which has been corrected.

 Will merge to 'next'.


* rs/sort-oid-array-thread-safe (2019-08-20) 1 commit
 - sha1-name: make sort_ambiguous_oid_array() thread-safe

 Prepare get_short_oid() codepath to be thread-safe.

 Will merge to 'next'.


* sb/userdiff-dts (2019-08-19) 1 commit
 - userdiff: Add a builtin pattern for dts files

 Device-tree files learned their own userdiff patterns.

 Will merge to 'next'.


* sg/line-log-tree-diff-optim (2019-08-21) 2 commits
 - line-log: avoid unnecessary full tree diffs
 - line-log: extract pathspec parsing from line ranges into a helper function

 Optimize unnecessary full-tree diff away from "git log -L" machinery.

 Will merge to 'next'.


* tg/t0021-racefix (2019-08-21) 1 commit
 - t0021: make sure clean filter runs

 A test fix.

 Will merge to 'next'.


--------------------------------------------------
[Stalled]

* js/trace2-json-schema (2019-07-25) 3 commits
 . ci: run trace2 schema validation in the CI suite
 . trace2: add a schema validator for trace2 events
 . trace2: add a JSON schema for trace2 events

 The JSON output produced by "trace2" subsystem now has JSON schema
 defined on it, to allow us validate the output and catch deviation.

 The CI integration may be a bit too heavy-handed.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* jc/format-patch-delay-message-id (2019-04-05) 1 commit
 - format-patch: move message-id and related headers to the end

 The location "git format-patch --thread" adds the Message-Id:
 header in the series of header fields has been moved down, which
 may help working around a suspected bug in GMail MSA, reported at
 <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


* jt/fetch-cdn-offload (2019-03-12) 9 commits
 - SQUASH???
 - upload-pack: send part of packfile response as uri
 - fetch-pack: support more than one pack lockfile
 - upload-pack: refactor reading of pack-objects out
 - Documentation: add Packfile URIs design doc
 - Documentation: order protocol v2 sections
 - http-fetch: support fetching packfiles by URL
 - http: improve documentation of http_pack_request
 - http: use --stdin when getting dumb HTTP pack

 WIP for allowing a response to "git fetch" to instruct the bulk of
 the pack contents to be instead taken from elsewhere (aka CDN).


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Expecting a reroll.
 cf. <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Anybody who wants to champion this topic?
 I am personally not yet quite convinced if this is worth pursuing.

--------------------------------------------------
[Cooking]

* py/git-gui-do-quit (2019-08-07) 2 commits
 - Merge branch 'py/call-do-quit-before-exit' of github.com:gitster/git-gui into py/git-gui-do-quit
 - git-gui: call do_quit before destroying the main window

 "git gui" learned to call the clean-up procedure before exiting.

 Will merge to 'next'.


* rs/nedalloc-fixlets (2019-08-07) 2 commits
  (merged to 'next' on 2019-08-09 at 0e9286fb70)
 + nedmalloc: avoid compiler warning about unused value
 + nedmalloc: do assignments only after the declaration section

 Compilation fix.

 Will merge to 'master'.


* jk/perf-no-dups (2019-08-12) 1 commit
  (merged to 'next' on 2019-08-14 at 3010a7d19f)
 + t/perf: rename duplicate-numbered test script

 Test & perf scripts must use unique numeric prefix, but a pair
 shared the same number, which is fixed here.

 Will merge to 'master'.


* en/fast-import-merge-doc (2019-08-12) 1 commit
  (merged to 'next' on 2019-08-14 at 65efc63345)
 + git-fast-import.txt: clarify that multiple merge commits are allowed

 Doc update.

 Will merge to 'master'.


* bc/reread-attributes-during-rebase (2019-08-19) 2 commits
 - apply: reload .gitattributes after patching it
 - path: add a function to check for path suffix

 The "git am" based backend of "git rebase" ignored the result of
 updating ".gitattributes" done in one step when replaying
 subsequent steps.

 Will merge to 'next'.


* jk/drop-release-pack-memory (2019-08-13) 1 commit
 - packfile: drop release_pack_memory()
 (this branch is used by cb/curl-use-xmalloc.)

 xmalloc() used to have a mechanism to ditch memory and address
 space resources as the last resort upon seeing an allocation
 failure from the underlying malloc(), which made the code complex
 and thread-unsafe with dubious benefit, as major memory resource
 users already do limit their uses with various other mechanisms.
 It has been simplified away.

 Will merge to 'next'.


* sg/complete-configuration-variables (2019-08-13) 11 commits
 - completion: complete config variables and values for 'git clone --config='
 - completion: complete config variables names and values for 'git clone -c'
 - completion: complete values of configuration variables after 'git -c var='
 - completion: complete configuration sections and variable names for 'git -c'
 - completion: split _git_config()
 - completion: simplify inner 'case' pattern in __gitcomp()
 - completion: use 'sort -u' to deduplicate config variable names
 - completion: deduplicate configuration sections
 - completion: add tests for 'git config' completion
 - completion: complete more values of more 'color.*' configuration variables
 - completion: fix a typo in a comment

 Command line completion updates for "git -c var.name=val"

 Will merge to 'next'.


* sg/worktree-remove-errormsg (2019-08-13) 1 commit
  (merged to 'next' on 2019-08-14 at e5444969c9)
 + worktree remove: clarify error message on dirty worktree

 Error message update/clarification.

 Will merge to 'master'.


* mt/threaded-grep-in-object-store (2019-08-13) 4 commits
 - grep: re-enable threads in some non-worktree cases
 - grep: disable grep_read_mutex when possible
 - grep: allow locks to be enabled individually
 - object-store: add lock to read_object_file_extended()


* pd/fetch-jobs (2019-08-13) 5 commits
 . fetch: make --jobs control submodules and remotes
 . fetch: add the --submodule-fetch-jobs option
 . fetch: add the fetch.jobs config key
 . fetch: add the "--fetch-jobs" option
 . fetch: rename max_children to max_children_for_submodules

 "git fetch --jobs" is getting taught to also run fetch jobs in
 parallel when fetching from multiple remote repositories.


* cb/fetch-set-upstream (2019-08-19) 1 commit
 - pull, fetch: add --set-upstream option

 "git fetch" learned "--set-upstream" option to help those who first
 clone from their private fork they intend to push to, add the true
 upstream via "git remote add" and then "git fetch" from it.


* sg/commit-graph-validate (2019-08-05) 3 commits
  (merged to 'next' on 2019-08-09 at 87f61abb73)
 + commit-graph: error out on invalid commit oids in 'write --stdin-commits'
 + commit-graph: turn a group of write-related macro flags into an enum
 + t5318-commit-graph: use 'test_expect_code'

 The code to write commit-graph over given commit object names has
 been made a bit more robust.

 Will merge to 'master'.


* sg/show-failed-test-names (2019-08-05) 2 commits
  (merged to 'next' on 2019-08-09 at c49ece8a0d)
 + tests: show the test name and number at the start of verbose output
 + t0000-basic: use realistic test script names in the verbose tests

 The first line of verbose output from each test piece now carries
 the test name and number to help scanning with eyeballs.

 Will merge to 'master'.


* js/pre-merge-commit-hook (2019-08-07) 4 commits
 - merge: --no-verify to bypass pre-merge-commit hook
 - git-merge: honor pre-merge-commit hook
 - merge: do no-verify like commit
 - t7503: verify proper hook execution

 A new "pre-merge-commit" hook has been introduced.

 Will merge to 'next'.


* jk/eoo (2019-08-06) 3 commits
 - gitcli: document --end-of-options
 - parse-options: allow --end-of-options as a synonym for "--"
 - revision: allow --end-of-options to end option parsing

 The command line parser learned "--end-of-options" notation; the
 standard convention for scripters to have hardcoded set of options
 first on the command line, and force the command to treat end-user
 input as non-options, has been to use "--" as the delimiter, but
 that would not work for commands that use "--" as a delimiter
 between revs and pathspec.

 Will merge to 'next'.


* jk/repo-init-cleanup (2019-08-06) 3 commits
 - config: stop checking whether the_repository is NULL
 - common-main: delay trace2 initialization
 - t1309: use short branch name in includeIf.onbranch test

 Further clean-up of the initialization code.


* cb/pcre2-chartables-leakfix (2019-08-06) 3 commits
 - grep: avoid leak of chartables in PCRE2
 - grep: make PCRE2 aware of custom allocator
 - grep: make PCRE1 aware of custom allocator

 WIP.


* jh/trace2-pretty-output (2019-08-09) 7 commits
 - trace2: cleanup whitespace in perf format
 - trace2: cleanup whitespace in normal format
 - quote: add sq_append_quote_argv_pretty()
 - trace2: trim trailing whitespace in normal format error message
 - trace2: remove dead code in maybe_add_string_va()
 - trace2: trim whitespace in region messages in perf target format
 - trace2: cleanup column alignment in perf target format

 Output from trace2 subsystem is formatted more prettily now.

 Will merge to 'next'.


* sc/pack-refs-deletion-racefix (2019-08-02) 1 commit
  (merged to 'next' on 2019-08-09 at 6bd6c85fbb)
 + pack-refs: always refresh after taking the lock file

 "git pack-refs" can lose refs that are created while running, which
 is getting corrected.

 Will merge to 'master'.
 Performance impact unclear but let's let correctness take priority
 for now.
 cf. <20190816204906.GA29853@sigill.intra.peff.net>


* vn/restore-empty-ita-corner-case-fix (2019-08-02) 2 commits
  (merged to 'next' on 2019-08-09 at ad2d7630d1)
 + restore: add test for deleted ita files
 + checkout.c: unstage empty deleted ita files

 "git checkout" and "git restore" to re-populate the index from a
 tree-ish (typically HEAD) did not work correctly for a path that
 was removed and then added again with the intent-to-add bit, when
 the corresponding working tree file was empty.  This has been
 corrected.

 Will merge to 'master'.


* ds/feature-macros (2019-08-13) 6 commits
 - repo-settings: create feature.experimental setting
 - repo-settings: create feature.manyFiles setting
 - repo-settings: parse core.untrackedCache
 - commit-graph: turn on commit-graph by default
 - t6501: use 'git gc' in quiet mode
 - repo-settings: consolidate some config settings

 A mechanism to affect the default setting for a (related) group of
 configuration variables is introduced.

 Will merge to 'next'.


* mt/grep-submodules-working-tree (2019-07-30) 1 commit
  (merged to 'next' on 2019-08-02 at e1a46a195f)
 + grep: fix worktree case in submodules

 "git grep --recurse-submodules" that looks at the working tree
 files looked at the contents in the index in submodules, instead of
 files in the working tree.

 Will merge to 'master'.


* jk/tree-walk-overflow (2019-08-01) 6 commits
  (merged to 'next' on 2019-08-02 at 116467c77a)
 + tree-walk: harden make_traverse_path() length computations
 + tree-walk: add a strbuf wrapper for make_traverse_path()
 + tree-walk: accept a raw length for traverse_path_len()
 + tree-walk: use size_t consistently
 + tree-walk: drop oid from traverse_info
 + setup_traverse_info(): stop copying oid

 Codepaths to walk tree objects have been audited for integer
 overflows and hardened.

 Will merge to 'master'.


* sg/t5510-test-i18ngrep-fix (2019-07-31) 1 commit
  (merged to 'next' on 2019-08-02 at 678564fda2)
 + t5510-fetch: fix negated 'test_i18ngrep' invocation
 (this branch is used by sg/do-not-skip-non-httpd-tests.)

 Test fix.

 Will merge to 'master'.


* sg/do-not-skip-non-httpd-tests (2019-08-02) 3 commits
  (merged to 'next' on 2019-08-02 at e700df0693)
 + t: warn against adding non-httpd-specific tests after sourcing 'lib-httpd'
 + t5703: run all non-httpd-specific tests before sourcing 'lib-httpd.sh'
 + t5510-fetch: run non-httpd-specific test before sourcing 'lib-httpd.sh'
 (this branch uses sg/t5510-test-i18ngrep-fix.)

 Test fix.

 Will merge to 'master'.


* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


* ra/rebase-i-more-options (2019-08-20) 6 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_rename
 - rebase -i: support --committer-date-is-author-date
 - sequencer: add NULL checks under read_author_script
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learned a few options that are known by "git
 rebase" proper.

 Looking good.


* js/rebase-r-strategy (2019-07-31) 16 commits
 - rebase -r: do not (re-)generate root commits with `--root` *and* `--onto`
 - t3418: test `rebase -r` with merge strategies
 - t/lib-rebase: prepare for testing `git rebase --rebase-merges`
 - rebase -r: support merge strategies other than `recursive`
 - t3427: fix another incorrect assumption
 - t3427: accommodate for the `rebase --merge` backend having been replaced
 - t3427: fix erroneous assumption
 - t3427: condense the unnecessarily repetitive test cases into three
 - t3427: move the `filter-branch` invocation into the `setup` case
 - t3427: simplify the `setup` test case significantly
 - t3427: add a clarifying comment
 - rebase: fold git-rebase--common into the -p backend
 - sequencer: the `am` and `rebase--interactive` scripts are gone
 - .gitignore: there is no longer a built-in `git-rebase--interactive`
 - t3400: stop referring to the scripted rebase
 - Drop unused git-rebase--am.sh

 "git rebase --rebase-merges" learned to drive different merge
 strategies and pass strategy specific options to them.

 Will merge to 'next'.


* js/builtin-add-i (2019-07-18) 11 commits
 - built-in add -i: implement the `help` command
 - built-in add -i: use color in the main loop
 - built-in add -i: support `?` (prompt help)
 - built-in add -i: show unique prefixes of the commands
 - Add a function to determine unique prefixes for a list of strings
 - built-in add -i: implement the main loop
 - built-in add -i: color the header in the `status` command
 - built-in add -i: refresh the index before running `status`
 - built-in add -i: implement the `status` command
 - diff: export diffstat interface
 - Start to implement a built-in version of `git add --interactive`

 The beginning of rewriting "git add -i" in C.

 Expecting a response and possibly a reroll.
 cf. <xmqqwofyozka.fsf@gitster-ct.c.googlers.com>
 cf. <xmqqsgqmoyz1.fsf@gitster-ct.c.googlers.com>


* es/walken-tutorial (2019-08-07) 1 commit
 - documentation: add tutorial for revision walking

 A tutorial on object enumeration.


* ab/pcre-jit-fixes (2019-08-19) 8 commits
 - grep: under --debug, show whether PCRE JIT is enabled
 - grep: do not enter PCRE2_UTF mode on fixed matching
 - grep: stess test PCRE v2 on invalid UTF-8 data
 - grep: create a "is_fixed" member in "grep_pat"
 - grep: consistently use "p->fixed" in compile_regexp()
 - grep: stop using a custom JIT stack with PCRE v1
 - grep: stop "using" a custom JIT stack with PCRE v2
 - grep: remove overly paranoid BUG(...) code
 (this branch uses ab/no-kwset.)

 A few simplification and bugfixes to PCRE interface.


* md/list-objects-filter-combo (2019-06-28) 10 commits
 - list-objects-filter-options: make parser void
 - list-objects-filter-options: clean up use of ALLOC_GROW
 - list-objects-filter-options: allow mult. --filter
 - strbuf: give URL-encoding API a char predicate fn
 - list-objects-filter-options: make filter_spec a string_list
 - list-objects-filter-options: move error check up
 - list-objects-filter: implement composite filters
 - list-objects-filter-options: always supply *errbuf
 - list-objects-filter: put omits set in filter struct
 - list-objects-filter: encapsulate filter components

 The list-objects-filter API (used to create a sparse/lazy clone)
 learned to take a combined filter specification.

 Will merge to 'next'.


* cc/multi-promisor (2019-06-25) 15 commits
 - Move core_partial_clone_filter_default to promisor-remote.c
 - Move repository_format_partial_clone to promisor-remote.c
 - Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
 - remote: add promisor and partial clone config to the doc
 - partial-clone: add multiple remotes in the doc
 - t0410: test fetching from many promisor remotes
 - builtin/fetch: remove unique promisor remote limitation
 - promisor-remote: parse remote.*.partialclonefilter
 - Use promisor_remote_get_direct() and has_promisor_remote()
 - promisor-remote: use repository_format_partial_clone
 - promisor-remote: add promisor_remote_reinit()
 - promisor-remote: implement promisor_remote_get_direct()
 - Add initial support for many promisor remotes
 - fetch-object: make functions return an error code
 - t0410: remove pipes after git commands

 Teach the lazy clone machinery that there can be more than one
 promisor remote and consult them in order when downloading missing
 objects on demand.

 Will merge to 'next'.


* jc/format-patch-noclobber (2019-02-22) 1 commit
 - format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Will discard.


* dl/rebase-i-keep-base (2019-04-25) 6 commits
 - rebase: teach rebase --keep-base
 - rebase: fast-forward --fork-point in more cases
 - rebase: fast-forward --onto in more cases
 - rebase: refactor can_fast_forward into goto tower
 - t3432: test rebase fast-forward behavior
 - t3431: add rebase --fork-point tests

 "git rebase --keep-base <upstream>" tries to find the original base
 of the topic being rebased and rebase on top of that same base,
 which is useful when running the "git rebase -i" (and its limited
 variant "git rebase -x").

 The command also has learned to fast-forward in more cases where it
 can instead of replaying to recreate identical commits.

 On hold.
 cf. <20190508001252.15752-1-avarab@gmail.com>
 cf. <20190719210156.GA9688@archbookpro.localdomain>


--------------------------------------------------
[Discarded]

* ab/no-kwset (2019-07-01) 10 commits
  (merged to 'next' on 2019-07-15 at ed0479ce3d)
 + grep: use PCRE v2 for optimized fixed-string search
 + grep: remove the kwset optimization
 + grep: drop support for \0 in --fixed-strings <pattern>
 + grep: make the behavior for NUL-byte in patterns sane
 + grep tests: move binary pattern tests into their own file
 + grep tests: move "grep binary" alongside the rest
 + grep: inline the return value of a function call used only once
 + t4210: skip more command-line encoding tests on MinGW
 + grep: don't use PCRE2?_UTF8 with "log --encoding=<non-utf8>"
 + log tests: test regex backends in "--encode=<enc>" tests
 (this branch is used by ab/pcre-jit-fixes.)

 Retire use of kwset library, which is an optimization for looking
 for fixed strings, with use of pcre2 JIT.

 Kicked out of 'next' to give the topic a chance to get rebooted.
