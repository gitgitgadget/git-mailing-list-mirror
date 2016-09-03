Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 978E01FBB0
	for <e@80x24.org>; Sat,  3 Sep 2016 02:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbcICCRb (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 22:17:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64349 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753260AbcICCR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 22:17:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64B2A3C2E0;
        Fri,  2 Sep 2016 22:17:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=f
        u76BzH8TIscHO39v2HW0tMKvmo=; b=t+V+B0JEcPZ7Fq5l2/+Mnp0nd0YGaF36a
        fHzuoTbH7gfq+EX507Yow5jVVVUTY4+2dU/wvQzscM1kdidu4TCyM6zYJl8UyL4e
        CkpoWeEczAFZtOWHhMF0suPXamIP4kfsfHDL43E75W6h5/x2MZwGZXe0YiQMzxVD
        6mOHM4e4w0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=QFC
        6FyQN5NfGaMZVPb2+CaA96vJqGfiYUT8ZCD0h3ZpNQE5gwUf5K7U2WN7SjkyJG3+
        h84ZG+qzIvh8c/21f+xwUqMMi3JAr9pzDD69Ump31muZL+kipMF5+4Fhtmt89JYe
        QKpqhoS2YY/5k397qNlnUtFzADMy+Xk+KNC03BMw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BA253C2DF;
        Fri,  2 Sep 2016 22:17:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 657C23C2DE;
        Fri,  2 Sep 2016 22:17:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2016, #01; Fri, 2)
X-master-at: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
X-next-at: f2ff48496e8dc270b21b0290a2a3e4ef98e352ed
Date:   Fri, 02 Sep 2016 19:17:21 -0700
Message-ID: <xmqqfuphsp5a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CD8E8C2-717C-11E6-84B1-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Git 2.10 has been tagged.  In a few days, many topics that have been
cooking in 'next' would be merged to 'master'; as usual, I plan to
keep the tip of 'next' closed for a week or so and encourage people
to pay more attention to possible regressions than to show their
shiny new toys, and then open the new cycle by rebuilding 'next'
after that.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/submodule-anchor-git-dir (2016-09-01) 1 commit
 - submodule: avoid auto-discovery in prepare_submodule_repo_env()

 Having a submodule whose ".git" repository is somehow corrupt
 caused a few commands that recurse into submodules loop forever.

 Will merge to 'next'.


* jc/forbid-symbolic-ref-d-HEAD (2016-09-02) 1 commit
 - symbolic-ref -d: do not allow removal of HEAD

 "git symbolic-ref -d HEAD" happily removes the symbolic ref, but
 the resulting repository becomes an invalid one.  Teach the command
 to forbid removal of HEAD.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.

 While I think it would make it easier for people to experiment and
 build on if the topic is merged to 'next', I am at the same time a
 bit reluctant to merge an unproven new topic that introduces a new
 file format, which we may end up having to support til the end of
 time.  It is likely that to support a "prime clone from CDN", it
 would need a lot more than just "these are the heads and the pack
 data is over there", so this may not be sufficient.

 Will discard.


* jc/blame-reverse (2016-06-14) 2 commits
 - blame: dwim "blame --reverse OLD" as "blame --reverse OLD.."
 - blame: improve diagnosis for "--reverse NEW"

 It is a common mistake to say "git blame --reverse OLD path",
 expecting that the command line is dwimmed as if asking how lines
 in path in an old revision OLD have survived up to the current
 commit.

 Has been waiting for positive responses without seeing any.

 Will discard.


* jc/attr (2016-05-25) 18 commits
 - attr: support quoting pathname patterns in C style
 - attr: expose validity check for attribute names
 - attr: add counted string version of git_attr()
 - attr: add counted string version of git_check_attr()
 - attr: retire git_check_attrs() API
 - attr: convert git_check_attrs() callers to use the new API
 - attr: convert git_all_attrs() to use "struct git_attr_check"
 - attr: (re)introduce git_check_attr() and struct git_attr_check
 - attr: rename function and struct related to checking attributes
 - attr.c: plug small leak in parse_attr_line()
 - attr.c: tighten constness around "git_attr" structure
 - attr.c: simplify macroexpand_one()
 - attr.c: mark where #if DEBUG ends more clearly
 - attr.c: complete a sentence in a comment
 - attr.c: explain the lack of attr-name syntax check in parse_attr()
 - attr.c: update a stale comment on "struct match_attr"
 - attr.c: use strchrnul() to scan for one line
 - commit.c: use strchrnul() to scan for one line
 (this branch is used by jc/attr-more, sb/pathspec-label and sb/submodule-default-paths.)

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.

 I wanted to polish this topic further to make the attribute
 subsystem thread-ready, but because other topics depend on this
 topic and they do not (yet) need it to be thread-ready.

 As the authors of topics that depend on this seem not in a hurry,
 let's discard this and dependent topics and restart them some other
 day.

 Will discard.


* jc/attr-more (2016-06-09) 8 commits
 - attr.c: outline the future plans by heavily commenting
 - attr.c: always pass check[] to collect_some_attrs()
 - attr.c: introduce empty_attr_check_elems()
 - attr.c: correct ugly hack for git_all_attrs()
 - attr.c: rename a local variable check
 - fixup! d5ad6c13
 - attr.c: pass struct git_attr_check down the callchain
 - attr.c: add push_stack() helper
 (this branch uses jc/attr; is tangled with sb/pathspec-label and sb/submodule-default-paths.)

 The beginning of long and tortuous journey to clean-up attribute
 subsystem implementation.

 Needs to be redone.
 Will discard.


* sb/submodule-default-paths (2016-06-20) 5 commits
 - completion: clone can recurse into submodules
 - clone: add --init-submodule=<pathspec> switch
 - submodule update: add `--init-default-path` switch
 - Merge branch 'sb/pathspec-label' into sb/submodule-default-paths
 - Merge branch 'jc/attr' into sb/submodule-default-paths
 (this branch uses jc/attr and sb/pathspec-label; is tangled with jc/attr-more.)

 Allow specifying the set of submodules the user is interested in on
 the command line of "git clone" that clones the superproject.

 Will discard.


* sb/pathspec-label (2016-06-03) 6 commits
 - pathspec: disable preload-index when attribute pathspec magic is in use
 - pathspec: allow escaped query values
 - pathspec: allow querying for attributes
 - pathspec: move prefix check out of the inner loop
 - pathspec: move long magic parsing out of prefix_pathspec
 - Documentation: fix a typo
 (this branch is used by sb/submodule-default-paths; uses jc/attr; is tangled with jc/attr-more.)

 The pathspec mechanism learned ":(attr:X)$pattern" pathspec magic
 to limit paths that match $pattern further by attribute settings.
 The preload-index mechanism is disabled when the new pathspec magic
 is in use (at least for now), because the attribute subsystem is
 not thread-ready.

 Will discard.


* mh/connect (2016-06-06) 10 commits
 - connect: [host:port] is legacy for ssh
 - connect: move ssh command line preparation to a separate function
 - connect: actively reject git:// urls with a user part
 - connect: change the --diag-url output to separate user and host
 - connect: make parse_connect_url() return the user part of the url as a separate value
 - connect: group CONNECT_DIAG_URL handling code
 - connect: make parse_connect_url() return separated host and port
 - connect: re-derive a host:port string from the separate host and port variables
 - connect: call get_host_and_port() earlier
 - connect: document why we sometimes call get_port after get_host_and_port

 Rewrite Git-URL parsing routine (hopefully) without changing any
 behaviour.

 It has been two months without any support.  We may want to discard
 this.


* sb/bisect (2016-04-15) 22 commits
 . SQUASH???
 . bisect: get back halfway shortcut
 . bisect: compute best bisection in compute_relevant_weights()
 . bisect: use a bottom-up traversal to find relevant weights
 . bisect: prepare for different algorithms based on find_all
 . bisect: rename count_distance() to compute_weight()
 . bisect: make total number of commits global
 . bisect: introduce distance_direction()
 . bisect: extract get_distance() function from code duplication
 . bisect: use commit instead of commit list as arguments when appropriate
 . bisect: replace clear_distance() by unique markers
 . bisect: use struct node_data array instead of int array
 . bisect: get rid of recursion in count_distance()
 . bisect: make algorithm behavior independent of DEBUG_BISECT
 . bisect: make bisect compile if DEBUG_BISECT is set
 . bisect: plug the biggest memory leak
 . bisect: add test for the bisect algorithm
 . t6030: generalize test to not rely on current implementation
 . t: use test_cmp_rev() where appropriate
 . t/test-lib-functions.sh: generalize test_cmp_rev
 . bisect: allow 'bisect run' if no good commit is known
 . bisect: write about `bisect next` in documentation

 The internal algorithm used in "git bisect" to find the next commit
 to check has been optimized greatly.

 Was expecting a reroll, but now pb/bisect topic starts removinging
 more and more parts from git-bisect.sh, this needs to see a fresh
 reroll.

 Will discard.
 cf. <1460294354-7031-1-git-send-email-s-beyer@gmx.net>


* sg/completion-updates (2016-02-28) 21 commits
 . completion: cache the path to the repository
 . completion: extract repository discovery from __gitdir()
 . completion: don't guard git executions with __gitdir()
 . completion: consolidate silencing errors from git commands
 . completion: don't use __gitdir() for git commands
 . completion: respect 'git -C <path>'
 . completion: fix completion after 'git -C <path>'
 . completion: don't offer commands when 'git --opt' needs an argument
 . rev-parse: add '--absolute-git-dir' option
 . completion: list short refs from a remote given as a URL
 . completion: don't list 'HEAD' when trying refs completion outside of a repo
 . completion: list refs from remote when remote's name matches a directory
 . completion: respect 'git --git-dir=<path>' when listing remote refs
 . completion: fix most spots not respecting 'git --git-dir=<path>'
 . completion: ensure that the repository path given on the command line exists
 . completion tests: add tests for the __git_refs() helper function
 . completion tests: check __gitdir()'s output in the error cases
 . completion tests: consolidate getting path of current working directory
 . completion tests: make the $cur variable local to the test helper functions
 . completion tests: don't add test cruft to the test repository
 . completion: improve __git_refs()'s in-code documentation

 Has been waiting for a reroll for too long.
 cf. <1456754714-25237-1-git-send-email-szeder@ira.uka.de>

 Will discard.


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Has been waiting for a review for too long without seeing anything.

 Will discard.


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Has been waiting for a reroll for too long.
 cf. <xmqq60ypbeng.fsf@gitster.mtv.corp.google.com>

 Will discard.


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.

 Will discard.

--------------------------------------------------
[Cooking]

* bh/diff-highlight-graph (2016-08-31) 6 commits
  (merged to 'next' on 2016-08-31 at 523a15f)
 + diff-highlight: avoid highlighting combined diffs
 + diff-highlight: add multi-byte tests
 + diff-highlight: ignore test cruft
 + diff-highlight: add support for --graph output
 + diff-highlight: add failing test for handling --graph output
 + diff-highlight: add some tests

 "diff-highlight" script (in contrib/) learned to work better with
 "git log -p --graph" output.

 Will merge to 'master'.


* jc/am-read-author-file (2016-08-30) 1 commit
 - am: refactor read_author_script()

 Extract a small helper out of the function that reads the authors
 script file "git am" internally uses.

 Will merge to 'next'.
 This by itself is not useful until a second caller appears in the
 future for "rebase -i" helper.


* jk/test-lib-drop-pid-from-results (2016-08-30) 1 commit
 - test-lib: drop PID from test-results/*.count

 The test framework left the number of tests and success/failure
 count in the t/test-results directory, keyed by the name of the
 test script plus the process ID.  The latter however turned out not
 to serve any useful purpose.  The process ID part of the filename
 has been removed.

 Will merge to 'next'.


* js/sequencer-wo-die (2016-08-29) 14 commits
 - sequencer: lib'ify save_opts()
 - sequencer: lib'ify save_todo()
 - sequencer: lib'ify save_head()
 - sequencer: lib'ify create_seq_dir()
 - sequencer: lib'ify read_populate_opts()
 - sequencer: lib'ify read_populate_todo()
 - sequencer: lib'ify read_and_refresh_cache()
 - sequencer: lib'ify prepare_revs()
 - sequencer: lib'ify walk_revs_populate_todo()
 - sequencer: lib'ify do_pick_commit()
 - sequencer: lib'ify do_recursive_merge()
 - sequencer: lib'ify write_message()
 - sequencer: do not die() in do_pick_commit()
 - sequencer: lib'ify sequencer_pick_revisions()

 Lifts calls to exit(2) and die() higher in the callchain in
 sequencer.c files so that more helper functions in it can be used
 by callers that want to handle error conditions themselves.

 Waiting for a reroll.


* jk/squelch-false-warning-from-gcc-o3 (2016-08-31) 2 commits
 - color_parse_mem: initialize "struct color" temporary
 - error_errno: use constant return similar to error()

 Will merge to 'next'.


* hv/doc-commit-reference-style (2016-08-26) 1 commit
  (merged to 'next' on 2016-08-31 at 68fb778)
 + SubmittingPatches: use gitk's "Copy commit summary" format

 A small doc update.
 Will merge to 'master'.


* cc/receive-pack-limit (2016-08-24) 3 commits
  (merged to 'next' on 2016-08-25 at bc74b5b)
 + receive-pack: allow a maximum input size to be specified
 + unpack-objects: add --max-input-size=<size> option
 + index-pack: add --max-input-size=<size> option

 An incoming "git push" that attempts to push too many bytes can now
 be rejected by setting a new configuration variable at the receiving
 end.

 Will merge to 'master'.


* jk/format-patch-number-singleton-patch-with-cover (2016-08-23) 1 commit
  (merged to 'next' on 2016-08-25 at a4737fb)
 + format-patch: show 0/1 and 1/1 for singleton patch with cover letter

 "git format-patch --cover-letter HEAD^" to format a single patch
 with a separate cover letter now numbers the output as [PATCH 0/1]
 and [PATCH 1/1] by default.

 Will merge to 'master'.


* cp/completion-negative-refs (2016-08-24) 1 commit
 - completion: support excluding refs

 The command-line completion script (in contrib/) learned to
 complete "git cmd ^mas<HT>" to complete the negative end of
 reference to "git cmd ^master".

 Waiting for a review.


* jk/delta-base-cache (2016-08-23) 7 commits
  (merged to 'next' on 2016-08-25 at f1c141a)
 + t/perf: add basic perf tests for delta base cache
 + delta_base_cache: use hashmap.h
 + delta_base_cache: drop special treatment of blobs
 + delta_base_cache: use list.h for LRU
 + release_delta_base_cache: reuse existing detach function
 + clear_delta_base_cache_entry: use a more descriptive name
 + cache_or_unpack_entry: drop keep_cache parameter

 The delta-base-cache mechanism has been a key to the performance in
 a repository with a tightly packed packfile, but it did not scale
 well even with a larger value of core.deltaBaseCacheLimit.

 Will merge to 'master'.


* js/cat-file-filters (2016-08-24) 4 commits
 - cat-file: support --textconv/--filters in batch mode
 - cat-file --textconv/--filters: allow specifying the path separately
 - cat-file: introduce the --filters option
 - cat-file: fix a grammo in the man page

 Even though "git hash-objects", which is a tool to take an
 on-filesystem data stream and put it into the Git object store,
 allowed to perform the "outside-world-to-Git" conversions (e.g.
 end-of-line conversions and application of the clean-filter), and
 it had the feature on by default from very early days, its reverse
 operation "git cat-file", which takes an object from the Git object
 store and externalize for the consumption by the outside world,
 lacked an equivalent mechanism to run the "Git-to-outside-world"
 conversion.  The command learned the "--filters" option to do so.

 Waiting for a reroll.
 cf. <xmqqmvk2qcv8.fsf@gitster.mtv.corp.google.com>


* sb/push-make-submodule-check-the-default (2016-08-24) 1 commit
 - push: change submodule default to check

 Turn the default of "push.recurseSubmodules" to "check".

 Alas, this reveals that the "check" mode is too inefficient to use
 in real projects, even in ones as small as git itself.
 cf. <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>


* ak/curl-imap-send-explicit-scheme (2016-08-17) 1 commit
 - imap-send: Tell cURL to use imap:// or imaps://

 When we started cURL to talk to imap server when a new enough
 version of cURL library is available, we forgot to explicitly add
 imap(s):// before the destination.  To some folks, that didn't work
 and the library tried to make HTTP(s) requests instead.

 Needs review and testing.


* rt/help-unknown (2016-08-30) 3 commits
  (merged to 'next' on 2016-08-30 at db2a5b0)
 + help: make option --help open man pages only for Git commands
 + help: introduce option --exclude-guides
 + Merge branch 'js/no-html-bypass-on-windows' into rt/help-unknown

 "git nosuchcommand --help" said "No manual entry for gitnosuchcommand",
 which was not intuitive, given that "git nosuchcommand" said "git:
 'nosuchcommand' is not a git command".

 Will merge to 'master'.


* po/range-doc (2016-08-13) 12 commits
  (merged to 'next' on 2016-08-31 at d29870b)
 + doc: revisions: sort examples and fix alignment of the unchanged
 + doc: revisions: show revision expansion in examples
 + doc: revisions - clarify reachability examples
 + doc: revisions - define `reachable`
 + doc: gitrevisions - clarify 'latter case' is revision walk
 + doc: gitrevisions - use 'reachable' in page description
 + doc: revisions: single vs multi-parent notation comparison
 + doc: revisions: extra clarification of <rev>^! notation effects
 + doc: revisions: give headings for the two and three dot notations
 + doc: show the actual left, right, and boundary marks
 + doc: revisions - name the left and right sides
 + doc: use 'symmetric difference' consistently

 Clarify various ways to specify the "revision ranges" in the
 documentation.

 Will merge to 'master'.


* jk/diff-submodule-diff-inline (2016-08-31) 8 commits
  (merged to 'next' on 2016-09-02 at 734e42c)
 + diff: teach diff to display submodule difference with an inline diff
 + submodule: refactor show_submodule_summary with helper function
 + submodule: convert show_submodule_summary to use struct object_id *
 + allow do_submodule_path to work even if submodule isn't checked out
 + diff: prepare for additional submodule formats
 + graph: add support for --line-prefix on all graph-aware output
 + diff.c: remove output_prefix_length field
 + cache: add empty_tree_oid object and helper function

 The "git diff --submodule={short,log}" mechanism has been enhanced
 to allow "--submodule=diff" to show the patch between the submodule
 commits bound to the superproject.

 Will merge to 'master'.


* jk/reduce-gc-aggressive-depth (2016-08-11) 1 commit
  (merged to 'next' on 2016-08-11 at 6810c6f)
 + gc: default aggressive depth to 50

 "git gc --aggressive" used to limit the delta-chain length to 250,
 which is way too deep for gaining additional space savings and is
 detrimental for runtime performance.  The limit has been reduced to
 50.

 Will hold to see if people scream.


* ks/pack-objects-bitmap (2016-08-09) 2 commits
 - pack-objects: use reachability bitmap index when generating non-stdout pack
 - pack-objects: respect --local/--honor-pack-keep/--incremental when bitmap is in use

 Waiting for the review discussion to settle.
 cf. <20160818175222.bmm3ivjheokf2qzl@sigill.intra.peff.net>
 cf. <20160818180615.q25p57v35m2xxtww@sigill.intra.peff.net>


* sb/submodule-clone-rr (2016-08-17) 8 commits
  (merged to 'next' on 2016-08-31 at 08b4b7d)
 + clone: recursive and reference option triggers submodule alternates
 + clone: implement optional references
 + clone: clarify option_reference as required
 + clone: factor out checking for an alternate path
 + submodule--helper update-clone: allow multiple references
 + submodule--helper module-clone: allow multiple references
 + t7408: merge short tests, factor out testing method
 + t7408: modernize style

 "git clone --resurse-submodules --reference $path $URL" is a way to
 reduce network transfer cost by borrowing objects in an existing
 $path repository when cloning the superproject from $URL; it
 learned to also peek into $path for presense of corresponding
 repositories of submodules and borrow objects from there when able.

 Will merge to 'master'.


* jh/status-v2-porcelain (2016-08-12) 9 commits
  (merged to 'next' on 2016-08-31 at e71f595)
 + status: unit tests for --porcelain=v2
 + test-lib-functions.sh: add lf_to_nul helper
 + git-status.txt: describe --porcelain=v2 format
 + status: print branch info with --porcelain=v2 --branch
 + status: print per-file porcelain v2 status data
 + status: collect per-file data for --porcelain=v2
 + status: support --porcelain[=<version>]
 + status: cleanup API to wt_status_print
 + status: rename long-format print routines

 Enhance "git status --porcelain" output by collecting more data on
 the state of the index and the working tree files, which may
 further be used to teach git-prompt (in contrib/) to make fewer
 calls to git.

 Will merge to 'master'.


* mh/diff-indent-heuristic (2016-08-23) 6 commits
 - diff: improve positioning of add/delete blocks in diffs
 - xdl_change_compact(): introduce the concept of a change group
 - recs_match(): take two xrecord_t pointers as arguments
 - is_blank_line(): take a single xrecord_t as argument
 - xdl_change_compact(): only use heuristic if group can't be matched
 - xdl_change_compact(): fix compaction heuristic to adjust ixo

 Output from "git diff" can be made easier to read by selecting
 which lines are common and which lines are added/deleted
 intelligently when the lines before and after the changed section
 are the same.  A command line option is added to help with the
 experiment to find a good heuristics.

 Waiting for a reroll.
 cf. <a27aa17e-f602-fc49-92b3-2198e4772e47@ramsayjones.plus.com>


* cc/apply-am (2016-08-29) 41 commits
 - builtin/am: use apply API in run_apply()
 - apply: learn to use a different index file
 - apply: pass apply state to build_fake_ancestor()
 - apply: refactor `git apply` option parsing
 - apply: change error_routine when silent
 - usage: add get_error_routine() and get_warn_routine()
 - usage: add set_warn_routine()
 - apply: don't print on stdout in verbosity_silent mode
 - apply: make it possible to silently apply
 - apply: use error_errno() where possible
 - apply: make some parsing functions static again
 - apply: move libified code from builtin/apply.c to apply.{c,h}
 - apply: rename and move opt constants to apply.h
 - builtin/apply: rename option parsing functions
 - builtin/apply: make create_one_file() return -1 on error
 - builtin/apply: make try_create_file() return -1 on error
 - builtin/apply: make write_out_results() return -1 on error
 - builtin/apply: make write_out_one_result() return -1 on error
 - builtin/apply: make create_file() return -1 on error
 - builtin/apply: make add_index_file() return -1 on error
 - builtin/apply: make add_conflicted_stages_file() return -1 on error
 - builtin/apply: make remove_file() return -1 on error
 - builtin/apply: make build_fake_ancestor() return -1 on error
 - builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
 - builtin/apply: make gitdiff_*() return -1 on error
 - builtin/apply: make gitdiff_*() return 1 at end of header
 - builtin/apply: make parse_traditional_patch() return -1 on error
 - builtin/apply: make apply_all_patches() return 128 or 1 on error
 - builtin/apply: move check_apply_state() to apply.c
 - builtin/apply: make check_apply_state() return -1 instead of die()ing
 - apply: make init_apply_state() return -1 instead of exit()ing
 - builtin/apply: move init_apply_state() to apply.c
 - builtin/apply: make parse_ignorewhitespace_option() return -1 instead of die()ing
 - builtin/apply: make parse_whitespace_option() return -1 instead of die()ing
 - builtin/apply: make parse_single_patch() return -1 on error
 - builtin/apply: make parse_chunk() return a negative integer on error
 - builtin/apply: make find_header() return -128 instead of die()ing
 - builtin/apply: read_patch_file() return -1 instead of die()ing
 - builtin/apply: make apply_patch() return -1 or -128 instead of die()ing
 - apply: move 'struct apply_state' to apply.h
 - apply: make some names more specific

 "git am" has been taught to make an internal call to "git apply"'s
 innards without spawning the latter as a separate process.

 Waiting for a reroll.


* jk/pack-objects-optim-mru (2016-08-11) 4 commits
  (merged to 'next' on 2016-08-11 at c0a7dae)
 + pack-objects: use mru list when iterating over packs
 + pack-objects: break delta cycles before delta-search phase
 + sha1_file: make packed_object_info public
 + provide an initializer for "struct object_info"

 "git pack-objects" in a repository with many packfiles used to
 spend a lot of time looking for/at objects in them; the accesses to
 the packfiles are now optimized by checking the most-recently-used
 packfile first.

 Will hold to see if people scream.


* jk/rebase-i-drop-ident-check (2016-07-29) 1 commit
  (merged to 'next' on 2016-08-14 at 6891bcd)
 + rebase-interactive: drop early check for valid ident

 Even when "git pull --rebase=preserve" (and the underlying "git
 rebase --preserve") can complete without creating any new commit
 (i.e. fast-forwards), it still insisted on having a usable ident
 information (read: user.email is set correctly), which was less
 than nice.  As the underlying commands used inside "git rebase"
 would fail with a more meaningful error message and advice text
 when the bogus ident matters, this extra check was removed.

 Will hold to see if people scream.
 cf. <20160729224944.GA23242@sigill.intra.peff.net>


* dp/autoconf-curl-ssl (2016-06-28) 1 commit
 - ./configure.ac: detect SSL in libcurl using curl-config

 The ./configure script generated from configure.ac was taught how
 to detect support of SSL by libcurl better.

 Needs review.


* jc/pull-rebase-ff (2016-07-28) 1 commit
 - pull: fast-forward "pull --rebase=true"

 "git pull --rebase", when there is no new commits on our side since
 we forked from the upstream, should be able to fast-forward without
 invoking "git rebase", but it didn't.

 Needs a real log message and a few tests.


* ex/deprecate-empty-pathspec-as-match-all (2016-06-22) 1 commit
  (merged to 'next' on 2016-07-13 at d9ca7fb)
 + pathspec: warn on empty strings as pathspec

 An empty string used as a pathspec element has always meant
 'everything matches', but it is too easy to write a script that
 finds a path to remove in $path and run 'git rm "$paht"', which
 ends up removing everything.  Start warning about this use of an
 empty string used for 'everything matches' and ask users to use a
 more explicit '.' for that instead.

 The hope is that existing users will not mind this change, and
 eventually the warning can be turned into a hard error, upgrading
 the deprecation into removal of this (mis)feature.

 Will hold to see if people scream.


* mh/ref-store (2016-06-20) 38 commits
 - refs: implement iteration over only per-worktree refs
 - refs: make lock generic
 - refs: add method to rename refs
 - refs: add methods to init refs db
 - refs: make delete_refs() virtual
 - refs: add method for initial ref transaction commit
 - refs: add methods for reflog
 - refs: add method iterator_begin
 - files_ref_iterator_begin(): take a ref_store argument
 - split_symref_update(): add a files_ref_store argument
 - lock_ref_sha1_basic(): add a files_ref_store argument
 - lock_ref_for_update(): add a files_ref_store argument
 - commit_ref_update(): add a files_ref_store argument
 - lock_raw_ref(): add a files_ref_store argument
 - repack_without_refs(): add a files_ref_store argument
 - refs: make peel_ref() virtual
 - refs: make create_symref() virtual
 - refs: make pack_refs() virtual
 - refs: make verify_refname_available() virtual
 - refs: make read_raw_ref() virtual
 - resolve_gitlink_ref(): rename path parameter to submodule
 - resolve_gitlink_ref(): avoid memory allocation in many cases
 - resolve_gitlink_ref(): implement using resolve_ref_recursively()
 - resolve_ref_recursively(): new function
 - read_raw_ref(): take a (struct ref_store *) argument
 - resolve_gitlink_packed_ref(): remove function
 - resolve_packed_ref(): rename function from resolve_missing_loose_ref()
 - refs: reorder definitions
 - refs: add a transaction_commit() method
 - {lock,commit,rollback}_packed_refs(): add files_ref_store arguments
 - resolve_missing_loose_ref(): add a files_ref_store argument
 - get_packed_ref(): add a files_ref_store argument
 - add_packed_ref(): add a files_ref_store argument
 - refs: create a base class "ref_store" for files_ref_store
 - refs: add a backend method structure
 - refs: rename struct ref_cache to files_ref_store
 - rename_ref_available(): add docstring
 - resolve_gitlink_ref(): eliminate temporary variable

 The ref-store abstraction was introduced to the refs API so that we
 can plug in different backends to store references.

 Needs a fixup.
 cf. <576D9885.2020901@ramsayjones.plus.com>


* nd/shallow-deepen (2016-06-13) 27 commits
 - fetch, upload-pack: --deepen=N extends shallow boundary by N commits
 - upload-pack: add get_reachable_list()
 - upload-pack: split check_unreachable() in two, prep for get_reachable_list()
 - t5500, t5539: tests for shallow depth excluding a ref
 - clone: define shallow clone boundary with --shallow-exclude
 - fetch: define shallow boundary with --shallow-exclude
 - upload-pack: support define shallow boundary by excluding revisions
 - refs: add expand_ref()
 - t5500, t5539: tests for shallow depth since a specific date
 - clone: define shallow clone boundary based on time with --shallow-since
 - fetch: define shallow boundary with --shallow-since
 - upload-pack: add deepen-since to cut shallow repos based on time
 - shallow.c: implement a generic shallow boundary finder based on rev-list
 - fetch-pack: use a separate flag for fetch in deepening mode
 - fetch-pack.c: mark strings for translating
 - fetch-pack: use a common function for verbose printing
 - fetch-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move rev-list code out of check_non_tip()
 - upload-pack: make check_non_tip() clean things up on error
 - upload-pack: tighten number parsing at "deepen" lines
 - upload-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move "unshallow" sending code out of deepen()
 - upload-pack: remove unused variable "backup"
 - upload-pack: move "shallow" sending code out of deepen()
 - upload-pack: move shallow deepen code out of receive_needs()
 - transport-helper.c: refactor set_helper_option()
 - remote-curl.c: convert fetch_git() to use argv_array

 The existing "git fetch --depth=<n>" option was hard to use
 correctly when making the history of an existing shallow clone
 deeper.  A new option, "--deepen=<n>", has been added to make this
 easier to use.  "git clone" also learned "--shallow-since=<date>"
 and "--shallow-exclude=<tag>" options to make it easier to specify
 "I am interested only in the recent N months worth of history" and
 "Give me only the history since that version".

 Needs review.

 Rerolled.  What this topic attempts to achieve is worthwhile, I
 would think.


* pb/bisect (2016-08-23) 27 commits
 . bisect--helper: remove the dequote in bisect_start()
 . bisect--helper: retire `--bisect-auto-next` subcommand
 . bisect--helper: retire `--bisect-autostart` subcommand
 . bisect--helper: retire `--check-and-set-terms` subcommand
 . bisect--helper: retire `--bisect-write` subcommand
 . bisect--helper: `bisect_replay` shell function in C
 . bisect--helper: `bisect_log` shell function in C
 . bisect--helper: retire `--write-terms` subcommand
 . bisect--helper: retire `--check-expected-revs` subcommand
 . bisect--helper: `bisect_state` & `bisect_head` shell function in C
 . bisect--helper: `bisect_autostart` shell function in C
 . bisect--helper: retire `--next-all` subcommand
 . bisect--helper: retire `--bisect-clean-state` subcommand
 . bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 . bisect--helper: `bisect_start` shell function partially in C
 . bisect--helper: `get_terms` & `bisect_terms` shell function in C
 . bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 . bisect--helper: `check_and_set_terms` shell function in C
 . bisect--helper: `bisect_write` shell function in C
 . bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 . bisect--helper: `bisect_reset` shell function in C
 . wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 . t6030: explicitly test for bisection cleanup
 . bisect--helper: `bisect_clean_state` shell function in C
 . bisect--helper: `write_terms` shell function in C
 . bisect: rewrite `check_term_format` shell function in C
 . bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 GSoC "bisect" topic.

 I'd prefer to see early part solidified so that reviews can focus
 on the later part that is still in flux.  We are almost there but
 not quite yet.


* kn/ref-filter-branch-list (2016-05-17) 17 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - branch, tag: use porcelain output
 - ref-filter: allow porcelain to translate messages in the output
 - ref-filter: add `:dir` and `:base` options for ref printing atoms
 - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 - ref-filter: introduce symref_atom_parser() and refname_atom_parser()
 - ref-filter: introduce refname_atom_parser_internal()
 - ref-filter: make "%(symref)" atom work with the ':short' modifier
 - ref-filter: add support for %(upstream:track,nobracket)
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: move get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: include reference to 'used_atom' within 'atom_value'
 - ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 Rerolled.
 Needs review.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 cf. <5671DB28.8020901@kdbg.org>
