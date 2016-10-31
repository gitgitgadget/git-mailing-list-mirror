Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3AD02021E
	for <e@80x24.org>; Mon, 31 Oct 2016 21:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947302AbcJaVuB (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 17:50:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50720 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S946858AbcJaVt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 17:49:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8DB54B5BB;
        Mon, 31 Oct 2016 17:49:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=V
        NFHbL6DWhzFl//qosVsiK0xN1g=; b=B+o8asgpLyXS3U3rT+ffZQOHabWrNL5ne
        MngUbDrJfnXra6PICNNF1frseKyndXKzWHthqGgr7YoKqwvOumTczI7Tk/K2cwhs
        MwYSSFe5eUk4ltYDdpRvZG8x16tabR5z+L3hgs1ecM9fAkr+rOA6cxe5D3dniJIb
        Cr0DumIHP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=i8X
        fm8RS+fvlEFqhCfl3Cv6oFII0+yL/8tYDJCuYIqFqvq1RzamjzOSwRZ/E7h9euTH
        d8J3zCqc4R7Fa8zk4oafI5pfYB3Uwg7DhBT1+2rRIH5AxA/XEN0RWk31DTrUHzSf
        d/g8t+2B+BOIL3C31cunK1avBEuW/U4bpxnIN5wM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0FEB4B5BA;
        Mon, 31 Oct 2016 17:49:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02D764B5B9;
        Mon, 31 Oct 2016 17:49:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2016, #09; Mon, 31)
X-master-at: 1fe8f2cf461179c41f64efbd1dc0a9fb3b7a0fb1
X-next-at: 2c8536d0921902ede8654c83a512865ff5ecd153
Date:   Mon, 31 Oct 2016 14:49:54 -0700
Message-ID: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6394B30-9FB3-11E6-862D-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Git v2.10.2, the second maintenance release for 2.10.x track, has
been tagged.  On the master front, an early preview v2.11.0-rc0 has
been tagged.  An updated, slightly slipped from the original,
schedule is found at http://tinyurl.com/gitCal and I am hoping that
we can conclude this cycle before US Thanksgiving.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ak/pre-receive-hook-template-modefix (2016-10-28) 1 commit
  (merged to 'next' on 2016-10-28 at 86d95836a3)
 + pre-receive.sample: mark it executable

 A trivial clean-up to a recently graduated topic.


* ak/sh-setup-dot-source-i18n-fix (2016-10-30) 1 commit
  (merged to 'next' on 2016-10-31 at 538a72700e)
 + git-sh-setup: be explicit where to dot-source git-sh-i18n from.

 Recent update to git-sh-setup (a library of shell functions that
 are used by our in-tree scripted Porcelain commands) included
 another shell library git-sh-i18n without specifying where it is,
 relying on the $PATH.  This has been fixed to be more explicit by
 prefixing $(git --exec-path) output in front.


* aw/numbered-stash (2016-10-26) 1 commit
  (merged to 'next' on 2016-10-26 at 8d9325fa3a)
 + stash: allow stashes to be referenced by index only

 The user always has to say "stash@{$N}" when naming a single
 element in the default location of the stash, i.e. reflogs in
 refs/stash.  The "git stash" command learned to accept "git stash
 apply 4" as a short-hand for "git stash apply stash@{4}".


* jk/common-main (2016-10-27) 1 commit
  (merged to 'next' on 2016-10-28 at fcdd4f8a26)
 + git-compat-util: move content inside ifdef/endif guards

 A trivial clean-up to a recently graduated topic.


* jk/rebase-config-insn-fmt-docfix (2016-10-30) 1 commit
  (merged to 'next' on 2016-10-31 at d48e20ffa2)
 + doc: fix missing "::" in config list

 Documentation fix.


* jt/trailer-with-cruft (2016-10-21) 8 commits
  (merged to 'next' on 2016-10-27 at b5d1a21811)
 + trailer: support values folded to multiple lines
 + trailer: forbid leading whitespace in trailers
 + trailer: allow non-trailers in trailer block
 + trailer: clarify failure modes in parse_trailer
 + trailer: make args have their own struct
 + trailer: streamline trailer item create and add
 + trailer: use list.h for doubly-linked list
 + trailer: improve const correctness
 (this branch is used by jt/use-trailer-api-in-commands.)

 Update "interpret-trailers" machinery and teaches it that people in
 real world write all sorts of crufts in the "trailer" that was
 originally designed to have the neat-o "Mail-Header: like thing"
 and nothing else.


* ls/filter-process (2016-10-17) 14 commits
  (merged to 'next' on 2016-10-19 at ffd0de042c)
 + contrib/long-running-filter: add long running filter example
 + convert: add filter.<driver>.process option
 + convert: prepare filter.<driver>.process option
 + convert: make apply_filter() adhere to standard Git error handling
 + pkt-line: add functions to read/write flush terminated packet streams
 + pkt-line: add packet_write_gently()
 + pkt-line: add packet_flush_gently()
 + pkt-line: add packet_write_fmt_gently()
 + pkt-line: extract set_packet_header()
 + pkt-line: rename packet_write() to packet_write_fmt()
 + run-command: add clean_on_exit_handler
 + run-command: move check_pipe() from write_or_die to run_command
 + convert: modernize tests
 + convert: quote filter names in error messages

 The smudge/clean filter API expect an external process is spawned
 to filter the contents for each path that has a filter defined.  A
 new type of "process" filter API has been added to allow the first
 request to run the filter for a path to spawn a single process, and
 all filtering need is served by this single process for multiple
 paths, reducing the process creation overhead.


* ls/git-open-cloexec (2016-10-25) 3 commits
  (merged to 'next' on 2016-10-26 at f7259cbddb)
 + read-cache: make sure file handles are not inherited by child processes
 + sha1_file: open window into packfiles with O_CLOEXEC
 + sha1_file: rename git_open_noatime() to git_open()
 (this branch is used by jc/git-open-cloexec.)

 Git generally does not explicitly close file descriptors that were
 open in the parent process when spawning a child process, but most
 of the time the child does not want to access them. As Windows does
 not allow removing or renaming a file that has a file descriptor
 open, a slow-to-exit child can even break the parent process by
 holding onto them.  Use O_CLOEXEC flag to open files in various
 codepaths.


* nd/test-helpers (2016-10-27) 1 commit
  (merged to 'next' on 2016-10-31 at 9780fe6d90)
 + valgrind: support test helpers

 Update to the test framework made in 2.9 timeframe broke running
 the tests under valgrind, which has been fixed.


* rs/commit-pptr-simplify (2016-10-30) 1 commit
  (merged to 'next' on 2016-10-31 at ddeed2e66a)
 + commit: simplify building parents list

 Code simplification.


* sc/fmt-merge-msg-doc-markup-fix (2016-10-28) 1 commit
  (merged to 'next' on 2016-10-31 at 198c259bb2)
 + Documentation/fmt-merge-msg: fix markup in example

 Documentation fix.

--------------------------------------------------
[New Topics]

* jc/push-default-explicit (2016-10-28) 1 commit
 - push: do not use potentially ambiguous default refspec

 A lazy "git push" without refspec did not internally use a fully
 specified refspec to perform 'current', 'simple', or 'upstream'
 push, causing unnecessary "ambiguous ref" errors.

 Needs updates to the tests.


* jt/use-trailer-api-in-commands (2016-10-28) 4 commits
 - sequencer: use trailer's trailer layout
 - trailer: have function to describe trailer layout
 - trailer: avoid unnecessary splitting on lines
 - commit: make ignore_non_trailer take buf/len

 Commands that operate on a log message and add lines to the trailer
 blocks, such as "format-patch -s", "cherry-pick (-x|-s)", and
 "commit -s", have been taught to use the logic of and share the
 code with "git interpret-trailer".

--------------------------------------------------
[Stalled]

* hv/submodule-not-yet-pushed-fix (2016-10-10) 3 commits
 - batch check whether submodule needs pushing into one call
 - serialize collection of refs that contain submodule changes
 - serialize collection of changed submodules

 The code in "git push" to compute if any commit being pushed in the
 superproject binds a commit in a submodule that hasn't been pushed
 out was overly inefficient, making it unusable even for a small
 project that does not have any submodule but have a reasonable
 number of refs.

 Waiting for review.
 cf. <cover.1475851621.git.hvoigt@hvoigt.net>


* sb/push-make-submodule-check-the-default (2016-10-10) 2 commits
 - push: change submodule default to check when submodules exist
 - submodule add: extend force flag to add existing repos

 Turn the default of "push.recurseSubmodules" to "check" when
 submodules seem to be in use.

 Will hold to wait for hv/submodule-not-yet-pushed-fix


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

* nd/rebase-forget (2016-10-28) 1 commit
 - rebase: add --forget to cleanup rebase, leave HEAD untouched

 "git rebase" learned "--forget" option, which allows a user to
 remove the metadata left by an earlier "git rebase" that was
 manually aborted without using "git rebase --abort".

 Waiting for a reroll.


* jc/git-open-cloexec (2016-10-31) 3 commits
 - sha1_file: stop opening files with O_NOATIME
 - git_open_cloexec(): use fcntl(2) w/ FD_CLOEXEC fallback
 - git_open(): untangle possible NOATIME and CLOEXEC interactions

 The codeflow of setting NOATIME and CLOEXEC on file descriptors Git
 opens has been simplified.

 We may want to drop the tip one.


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2016-10-26 at 220e160451)
 + setup_git_env: avoid blind fall-back to ".git"

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* jc/reset-unmerge (2016-10-24) 1 commit
 - reset: --unmerge

 After "git add" is run prematurely during a conflict resolution,
 "git diff" can no longer be used as a way to sanity check by
 looking at the combined diff.  "git reset" learned a new
 "--unmerge" option to recover from this situation.


* jc/merge-base-fp-only (2016-10-19) 8 commits
 . merge-base: fp experiment
 - merge: allow to use only the fp-only merge bases
 - merge-base: limit the output to bases that are on first-parent chain
 - merge-base: mark bases that are on first-parent chain
 - merge-base: expose get_merge_bases_many_0() a bit more
 - merge-base: stop moving commits around in remove_redundant()
 - sha1_name: remove ONELINE_SEEN bit
 - commit: simplify fastpath of merge-base

 An experiment of merge-base that ignores common ancestors that are
 not on the first parent chain.


* tb/convert-stream-check (2016-10-27) 2 commits
 - convert.c: stream and fast search for binary
 - read-cache: factor out get_sha1_from_index() helper

 End-of-line conversion sometimes needs to see if the current blob
 in the index has NULs and CRs to base its decision.  We used to
 always get a full statistics over the blob, but in many cases we
 can return early when we have seen "enough" (e.g. if we see a
 single NUL, the blob will be handled as binary).  The codepaths
 have been optimized by using streaming interface.

 Waiting for review.
 The tip seems to do too much in a single commit and may be better split.
 cf. <20161012134724.28287-1-tboegi@web.de>
 cf. <xmqqd1il5w4e.fsf@gitster.mtv.corp.google.com>


* pb/bisect (2016-10-18) 27 commits
 - bisect--helper: remove the dequote in bisect_start()
 - bisect--helper: retire `--bisect-auto-next` subcommand
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--bisect-write` subcommand
 - bisect--helper: `bisect_replay` shell function in C
 - bisect--helper: `bisect_log` shell function in C
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: `bisect_state` & `bisect_head` shell function in C
 - bisect--helper: `bisect_autostart` shell function in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 - t6030: no cleanup with bad merge base
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Move more parts of "git bisect" to C.

 Waiting for review.


* st/verify-tag (2016-10-10) 7 commits
 - t/t7004-tag: Add --format specifier tests
 - t/t7030-verify-tag: Add --format specifier tests
 - builtin/tag: add --format argument for tag -v
 - builtin/verify-tag: add --format to verify-tag
 - tag: add format specifier to gpg_verify_tag
 - ref-filter: add function to print single ref_array_item
 - gpg-interface, tag: add GPG_VERIFY_QUIET flag

 "git tag" and "git verify-tag" learned to put GPG verification
 status in their "--format=<placeholders>" output format.

 Waiting for a reroll.
 cf. <20161007210721.20437-1-santiago@nyu.edu>


* sb/attr (2016-10-28) 37 commits
 - completion: clone can initialize specific submodules
 - clone: add --init-submodule=<pathspec> switch
 - submodule update: add `--init-default-path` switch
 - pathspec: allow escaped query values
 - pathspec: allow querying for attributes
 - pathspec: move prefix check out of the inner loop
 - pathspec: move long magic parsing out of prefix_pathspec
 - Documentation: fix a typo
 - attr: keep attr stack for each check
 - SQUASH???
 - attr: convert to new threadsafe API
 - attr: make git_check_attr_counted static
 - attr.c: outline the future plans by heavily commenting
 - attr.c: always pass check[] to collect_some_attrs()
 - attr.c: introduce empty_attr_check_elems()
 - attr.c: correct ugly hack for git_all_attrs()
 - attr.c: rename a local variable check
 - attr.c: pass struct git_attr_check down the callchain
 - attr.c: add push_stack() helper
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

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.
 Building on top of the updated API, the pathspec machinery learned
 to select only paths with given attributes set.

 Waiting for review.


* va/i18n-perl-scripts (2016-10-20) 14 commits
 - i18n: difftool: mark warnings for translation
 - i18n: send-email: mark string with interpolation for translation
 - i18n: send-email: mark warnings and errors for translation
 - i18n: send-email: mark strings for translation
 - i18n: add--interactive: mark status words for translation
 - i18n: add--interactive: remove %patch_modes entries
 - i18n: add--interactive: mark edit_hunk_manually message for translation
 - i18n: add--interactive: i18n of help_patch_cmd
 - i18n: add--interactive: mark patch prompt for translation
 - i18n: add--interactive: mark plural strings
 - i18n: clean.c: match string with git-add--interactive.perl
 - i18n: add--interactive: mark strings with interpolation for translation
 - i18n: add--interactive: mark simple here-documents for translation
 - i18n: add--interactive: mark strings for translation

 Porcelain scripts written in Perl are getting internationalized.

 Waiting for review.
 cf. <20161010125449.7929-1-vascomalmeida@sapo.pt>


* jc/latin-1 (2016-09-26) 2 commits
  (merged to 'next' on 2016-09-28 at c8673e03c2)
 + utf8: accept "latin-1" as ISO-8859-1
 + utf8: refactor code to decide fallback encoding

 Some platforms no longer understand "latin-1" that is still seen in
 the wild in e-mail headers; replace them with "iso-8859-1" that is
 more widely known when conversion fails from/to it.

 Will hold to see if people scream.


* sg/fix-versioncmp-with-common-suffix (2016-09-08) 5 commits
 - versioncmp: cope with common leading parts in versionsort.prereleaseSuffix
 - versioncmp: pass full tagnames to swap_prereleases()
 - t7004-tag: add version sort tests to show prerelease reordering issues
 - t7004-tag: use test_config helper
 - t7004-tag: delete unnecessary tags with test_when_finished

 The prereleaseSuffix feature of version comparison that is used in
 "git tag -l" did not correctly when two or more prereleases for the
 same release were present (e.g. when 2.0, 2.0-beta1, and 2.0-beta2
 are there and the code needs to compare 2.0-beta1 and 2.0-beta2).

 Waiting for a reroll.
 cf. <20160908223727.Horde.jVOOJ278ssZ3qkyjkmyqZD-@webmail.informatik.kit.edu>


* jc/pull-rebase-ff (2016-07-28) 1 commit
 - pull: fast-forward "pull --rebase=true"

 "git pull --rebase", when there is no new commits on our side since
 we forked from the upstream, should be able to fast-forward without
 invoking "git rebase", but it didn't.

 Needs a real log message and a few tests.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2016-10-11 at 8928c8b9b3)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 cf. <5671DB28.8020901@kdbg.org>

 Will cook in 'next'.
