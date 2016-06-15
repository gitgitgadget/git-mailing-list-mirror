From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Thu, 25 Feb 2016 15:14:21 -0800
Message-ID: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 00:14:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ57A-0003Ax-SG
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbcBYXO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:14:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752480AbcBYXOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:14:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 651CA47422;
	Thu, 25 Feb 2016 18:14:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=D
	6/ktNEK3L7/2ROncKlJmLuqsQ8=; b=gqo5m4zpDC84dhTKXiVr6Rem2bYrcDaSp
	rp5XS1rHWtKFSMRcxXJmbPp2Cpn9dlW/nmrzAi8VSTsyQrADnNX5VttChkfZ2ATl
	Rd2mc9Ds8FppLUMUOaIcA9/xskpa49gOAOdLow+M/6X+t23xBVqh7XPlgT/bqRXk
	xVLF7v6Y+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=EFo
	5KPSSrdZZBv8pd5rnTvHXM2i9zvu1OhppZutMY933kGiwJJszeSnx+oDeeHeEH/M
	fSpolKoqG5IMep0GHvie4mOGoxynB0L35gfy47R7R4RRlz5hmdA9xMdopAVh/bTC
	gcFteMUof/S4eCHXFS4w1pnBVer/pt1Okl3JlTM4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5807847421;
	Thu, 25 Feb 2016 18:14:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4EE4747420;
	Thu, 25 Feb 2016 18:14:23 -0500 (EST)
X-master-at: 56f37fda511e1615dc6df86c68f3b841711a7828
X-next-at: 947c399e45ebc1a76d1e80d7152aa630726ed7e6
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 81B73054-DC15-11E5-93DB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287486>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/http-empty-auth (2016-02-15) 1 commit
  (merged to 'next' on 2016-02-18 at 6d2fc88)
 + http: add option to try authentication without username

 Some authentication methods do not need username or password, but
 libcurl needs some hint that it needs to perform authentication.
 Supplying an empty username and password string is a valid way to
 do so, but you can set the http.[<url>.]emptyAuth configuration
 variable to achieve the same, if you find it cleaner.


* ce/https-public-key-pinning (2016-02-15) 1 commit
  (merged to 'next' on 2016-02-18 at f382cf0)
 + http: implement public key pinning

 You can now set http.[<url>.]pinnedpubkey to specify the pinned
 public key when building with recent enough versions of libcURL.


* ew/force-ipv4 (2016-02-12) 1 commit
  (merged to 'next' on 2016-02-18 at d0211b0)
 + connect & http: support -4 and -6 switches for remote operations

 "git fetch" and friends that make network connections can now be
 told to only use ipv4 (or ipv6).


* jc/am-i-v-fix (2016-02-17) 3 commits
  (merged to 'next' on 2016-02-18 at 331e518)
 + am -i: fix "v"iew
 + pager: factor out a helper to prepare a child process to run the pager
 + pager: lose a separate argv[]

 The "v(iew)" subcommand of the interactive "git am -i" command was
 broken in 2.6.0 timeframe when the command was rewritten in C.


* jk/lose-name-path (2016-02-12) 5 commits
  (merged to 'next' on 2016-02-18 at 85831a6)
 + list-objects: pass full pathname to callbacks
 + list-objects: drop name_path entirely
 + list-objects: convert name_path to a strbuf
 + show_object_with_name: simplify by using path_name()
 + http-push: stop using name_path

 The "name_path" API was an attempt to reduce the need to construct
 the full path out of a series of path components while walking a
 tree hierarchy, but over time made less efficient because the path
 needs to be flattened, e.g. to be compared with another path that
 is already flat.  The API has been removed and its users have been
 rewritten to simplify the overall code complexity.


* nd/dwim-wildcards-as-pathspecs (2016-02-10) 3 commits
  (merged to 'next' on 2016-02-18 at fc7caf4)
 + get_sha1: don't die() on bogus search strings
 + check_filename: tighten dwim-wildcard ambiguity
 + checkout: reorder check_filename conditional

 "git show 'HEAD:Foo[BAR]Baz'" did not interpret the argument as a
 rev, i.e. the object named by the the pathname with wildcard
 characters in a tree object.


* nd/exclusion-regression-fix (2016-02-15) 4 commits
  (merged to 'next' on 2016-02-18 at 85412ab)
 + dir.c: don't exclude whole dir prematurely
 + dir.c: support marking some patterns already matched
 + dir.c: support tracing exclude
 + dir.c: fix match_pathname()

 Another try to add support to the ignore mechanism that lets you
 say "this is excluded" and then later say "oh, no, this part (that
 is a subset of the previous part) is not excluded".


* nd/git-common-dir-fix (2016-02-12) 1 commit
  (merged to 'next' on 2016-02-18 at 957afc5)
 + rev-parse: take prefix into account in --git-common-dir

 "git rev-parse --git-common-dir" used in the worktree feature
 misbehaved when run from a subdirectory.


* nd/worktree-add-B (2016-02-15) 2 commits
  (merged to 'next' on 2016-02-18 at bf77016)
 + worktree add -B: do the checkout test before update branch
 + worktree: fix "add -B"

 "git worktree add -B <branchname>" did not work.


* sp/remote-curl-ssl-strerror (2016-02-15) 1 commit
  (merged to 'next' on 2016-02-18 at 1339fe4)
 + remote-curl: include curl_errorstr on SSL setup failures

 Help those who debug http(s) part of the system.

--------------------------------------------------
[New Topics]

* jg/credential-cache-chdir-to-sockdir (2016-02-23) 3 commits
  (merged to 'next' on 2016-02-25 at ad35811)
 + credential-cache--daemon: change to the socket dir on startup
 + credential-cache--daemon: disallow relative socket path
 + credential-cache--daemon: refactor check_socket_directory

 The "credential-cache" daemon process used to run in whatever
 directory it happened to start in, but this made umount(2)ing the
 filesystem that houses the repository harder; now the process
 chdir()s to the directory that house its own socket on startup.

 Will merge to 'master'.


* jk/no-diff-emit-common (2016-02-22) 3 commits
  (merged to 'next' on 2016-02-24 at 72626ea)
 + xdiff: drop XDL_EMIT_COMMON
 + merge-tree: drop generate_common strategy
 + merge-one-file: use empty blob for add/add base

 "git merge-tree" used to mishandle "both sides added" conflict with
 its own "create a fake ancestor file that has the common parts of
 what both sides have added and do a 3-way merge" logic; this has
 been updated to use the usual "3-way merge with an empty blob as
 the fake common ancestore file" approach used in the rest of the
 system.

 Will merge to 'master'.


* mm/push-default-warning (2016-02-25) 1 commit
  (merged to 'next' on 2016-02-25 at 753352f)
 + push: remove "push.default is unset" warning message

 Across the transition at around Git version 2.0, the user used to
 get a pretty loud warning when running "git push" without setting
 push.default configuration variable.  We started to tone down the
 warning message, given that the transition is over long time ago.

 Will merge to 'master'.


* mm/push-simple-doc (2016-02-23) 1 commit
  (merged to 'next' on 2016-02-25 at dc4f57c)
 + Documentation/git-push: document that 'simple' is the default

 The documentation did not clearly state that the 'simple' mode is
 now the default for "git push" when push.default configuration is
 not set.

 Will merge to 'master'.


* nd/shallow-deepen (2016-02-23) 25 commits
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
 - fetch-pack: use a common function for verbose printing
 - fetch-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move rev-list code out of check_non_tip()
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


* ps/plug-xdl-merge-leak (2016-02-23) 1 commit
  (merged to 'next' on 2016-02-25 at 523609e)
 + xdiff/xmerge: fix memory leak in xdl_merge

 Will merge to 'master'.


* jk/epipe-in-async (2016-02-25) 4 commits
  (merged to 'next' on 2016-02-25 at 4482ddf)
 + t5504: handle expected output from SIGPIPE death
 + test_must_fail: report number of unexpected signal
 + fetch-pack: ignore SIGPIPE in sideband demuxer
 + write_or_die: handle EPIPE in async threads

 Handling of errors while writing into our internal asynchronous
 process has been made more robust, which reduces flakiness in our
 tests.

 Will merge to 'master'.


* js/config-set-in-non-repository (2016-02-25) 1 commit
  (merged to 'next' on 2016-02-25 at a675267)
 + git config: report when trying to modify a non-existing repo config

 "git config section.var value" to set a value in per-repository
 configuration file should have failed when it was run outside any
 repository, but didn't.

 Will merge to 'master'.


* sb/submodule-module-list-fix (2016-02-24) 1 commit
  (merged to 'next' on 2016-02-25 at 21be607)
 + submodule helper list: respect correct path prefix

 A helper function "git submodule" uses since v2.7.0 to list the
 modules that match the pathspec argument given to its subcommands
 (e.g. "submodule add <repo> <path>") has been fixed.

 Will merge to 'master'.


* sb/submodule-fetch-nontip (2016-02-24) 1 commit
  (merged to 'next' on 2016-02-25 at 1e412f0)
 + submodule: try harder to fetch needed sha1 by direct fetching sha1

 When "git submodule update" did not result in fetching the commit
 object in the submodule that is referenced by the superproject, the
 command learned to retry another fetch, specifically asking for
 that commit that may not be connected to the refs it usually
 fetches.

 Will merge to 'master'.


* dt/initial-ref-xn-commit-doc (2016-02-25) 1 commit
  (merged to 'next' on 2016-02-25 at e32d0f6)
 + refs: document transaction semantics

 Will merge to 'master'.


* jk/pack-idx-corruption-safety (2016-02-25) 3 commits
 - use_pack: handle signed off_t overflow
 - nth_packed_object_offset: bounds-check extended offset
 - t5313: test bounds-checks of corrupted/malicious pack/idx files

 The code to read the pack data using the offsets stored in the pack
 idx file has been made more carefully check the validity of the
 data in the idx.

 Will merge to 'next'.


* ls/makefile-cflags-developer-tweak (2016-02-25) 1 commit
  (merged to 'next' on 2016-02-25 at 14bb065)
 + add DEVELOPER makefile knob to check for acknowledged warnings

 There is a new DEVELOPER knob that enables many compiler warning
 options in the Makefile.

 Will merge to 'master'.


* ma/update-hooks-sample-typofix (2016-02-25) 1 commit
  (merged to 'next' on 2016-02-25 at be49c79)
 + templates/hooks: fix minor typo in the sample update-hook

 Will merge to 'master'.


* mm/diff-renames-default (2016-02-25) 5 commits
  (merged to 'next' on 2016-02-25 at 947c399)
 + diff: activate diff.renames by default
 + log: introduce init_log_defaults()
 + t: add tests for diff.renames (true/false/unset)
 + t4001-diff-rename: wrap file creations in a test
 + Documentation/diff-config: fix description of diff.renames

 The end-user facing Porcelain level commands like "diff" and "log"
 now enables the rename detection by default.

 Will merge to 'master'.


* mm/readme-markdown (2016-02-25) 5 commits
  (merged to 'next' on 2016-02-25 at b8bda29)
 + README.md: move down historical explanation about the name
 + README.md: don't call git stupid in the title
 + README.md: move the link to git-scm.com up
 + README.md: add hyperlinks on filenames
 + README: use markdown syntax

 Move README to README.md and tweak its contents slightly to make it
 easier on the eyes.

 Will merge to 'master'.


* mp/upload-pack-use-embedded-args (2016-02-25) 1 commit
 - upload-pack: use argv_array for pack_objects

 The embedded args argv-array in the child process is used to build
 the command line to run pack-objects instead of using a separate
 array of strings.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Waiting for review.


* dg/subtree-rebase-test (2016-01-19) 1 commit
 - contrib/subtree: Add a test for subtree rebase that loses commits

 Reviewed up to v5.
 Will be rerolled.
 ($gmane/284426)


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
 - am: make a direct call to merge_recursive
 - merge_recursive_options: introduce the "gently" flag

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.

 Being able to make a direct call would be good in general, but as a
 performance thing, the change needs to be backed up by numbers.

 Needs review.

 I haven't gone through the "gently" change with fine toothed comb;
 I can see that the change avoids calling die(), but I haven't made
 sure that the program states (e.g. what's in the in-core index) are
 adjusted sensibly when it returns to the caller instead of dying,
 or the codepaths that used to die() are free of resource leaks.
 The original code certainly did not care the program states at the
 point of dying exactly because it knew it is going to exit, but now
 they have to care, and they need to be audited.


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for a reroll.
 ($gmane/284368).


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962

 Becoming tired of waiting for a reroll.
 with updated log message ($gmane/268061).
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

* sb/submodule-init (2016-02-25) 2 commits
 - submodule: port init from shell to C
 - submodule: port resolve_relative_url from shell to C
 (this branch uses sb/submodule-parallel-update; is tangled with dt/refs-backend-lmdb.)

 Update of "git submodule" to move pieces of logic to C continues.

 Comments?
 ($gmane/286092)


* ak/extract-argv0-last-dir-sep (2016-02-19) 1 commit
  (merged to 'next' on 2016-02-24 at f590eb0)
 + exec_cmd.c: use find_last_dir_sep() for code simplification

 Code simplification.

 Will merge to 'master'.


* az/p4-bare-no-rebase (2016-02-19) 1 commit
 - git-p4.py: Don't try to rebase on submit from bare repository

 "git p4 submit" attempts to do a rebase, which would fail if done
 in a bare repository.  Not doing this rebase would paper over the
 failure, which is what this patch does, but it is unclear what the
 side effect of not rebasing is.

 Needs a better explanation.


* ak/git-strip-extension-from-dashed-command (2016-02-21) 1 commit
  (merged to 'next' on 2016-02-24 at 8a84f91)
 + git.c: simplify stripping extension of a file in handle_builtin()

 Code simplification.

 Will merge to 'master'.


* jk/grep-binary-workaround-in-test (2016-02-23) 2 commits
  (merged to 'next' on 2016-02-25 at 0e96ae8)
 + t9200: avoid grep on non-ASCII data
 + t8005: avoid grep on non-ASCII data

 Recent versions of GNU grep are pickier when their input contains
 arbitrary binary data, which some of our tests uses.  Rewrite the
 tests to sidestep the problem.

 Will merge to 'master'.


* mg/work-tree-tests (2016-02-20) 1 commit
  (merged to 'next' on 2016-02-25 at ca8cbb0)
 + tests: rename work-tree tests to *work-tree*

 Traditionally, the tests that try commands that work on the
 contents in the working tree were named with "worktree" in their
 filenames, but with the recent addition of "git worktree"
 subcommand, whose tests are also named similarly, it has become
 harder to tell them apart.  The traditional tests have been renamed
 to use "work-tree" instead in an attempt to differentiate them.

 Will merge to 'master'.


* jk/more-comments-on-textconv (2016-02-22) 1 commit
  (merged to 'next' on 2016-02-24 at 4ccfdc5)
 + diff: clarify textconv interface

 The memory ownership rule of fill_textconv() API, which was a bit
 tricky, has been documented a bit better.

 Will merge to 'master'.


* cn/deprecate-ssh-git-url (2016-02-15) 1 commit
 - Disown ssh+git and git+ssh

 Needs toning down by replacing the condescendence with an
 explanation and enlightenment.
 ($gmane/286222)


* fa/merge-recursive-no-rename (2016-02-24) 7 commits
  (merged to 'next' on 2016-02-25 at 8f18cc1)
 + t3034: test deprecated interface
 + t3034: test option to disable renames
 + t3034: add rename threshold tests
 + merge-recursive: find-renames resets threshold
 + merge-strategies.txt: fix typo
  (merged to 'next' on 2016-02-18 at dd6125b)
 + merge-recursive: more consistent interface
 + merge-recursive: option to disable renames

 "git merge-recursive" learned "--no-renames" option to disable its
 rename detection logic.

 Will merge to 'master'.


* jk/tighten-alloc (2016-02-22) 22 commits
  (merged to 'next' on 2016-02-24 at 78b3251)
 + ewah: convert to REALLOC_ARRAY, etc
 + convert ewah/bitmap code to use xmalloc
 + diff_populate_gitlink: use a strbuf
 + transport_anonymize_url: use xstrfmt
 + git-compat-util: drop mempcpy compat code
 + sequencer: simplify memory allocation of get_message
 + test-path-utils: fix normalize_path_copy output buffer size
 + fetch-pack: simplify add_sought_entry
 + fast-import: simplify allocation in start_packfile
 + write_untracked_extension: use FLEX_ALLOC helper
 + prepare_{git,shell}_cmd: use argv_array
 + use st_add and st_mult for allocation size computation
 + convert trivial cases to FLEX_ARRAY macros
 + use xmallocz to avoid size arithmetic
 + convert trivial cases to ALLOC_ARRAY
 + convert manual allocations to argv_array
 + argv-array: add detach function
 + add helpers for allocating flex-array structs
 + harden REALLOC_ARRAY and xcalloc against size_t overflow
 + tree-diff: catch integer overflow in combine_diff_path allocation
 + add helpers for detecting size_t overflow
 + reflog_expire_cfg: NUL-terminate pattern field

 Update various codepaths to avoid manually-counted malloc().

 Will merge to 'master'.


* ps/config-error (2016-02-22) 15 commits
  (merged to 'next' on 2016-02-25 at b378629)
 + config: rename git_config_set_or_die to git_config_set
 + config: rename git_config_set to git_config_set_gently
 + compat: die when unable to set core.precomposeunicode
 + sequencer: die on config error when saving replay opts
 + init-db: die on config errors when initializing empty repo
 + clone: die on config error in cmd_clone
 + remote: die on config error when manipulating remotes
 + remote: die on config error when setting/adding branches
 + remote: die on config error when setting URL
 + submodule--helper: die on config error when cloning module
 + submodule: die on config error when linking modules
 + branch: die on config error when editing branch description
 + branch: die on config error when unsetting upstream
 + branch: report errors in tracking branch setup
 + config: introduce set_or_die wrappers

 Many codepaths forget to check return value from git_config_set();
 the function is made to die() to make sure we do not proceed when
 setting a configuration variable failed.

 Will merge to 'master'.


* ss/commit-dry-run-resolve-merge-to-no-op (2016-02-17) 1 commit
 - wt-status.c: set commitable bit if there is a meaningful merge.

 "git commit --dry-run" reported "No, no, you cannot commit." in one
 case where "git commit" would have allowed you to commit, and this
 improves it a little bit ("git commit --dry-run --short" still does
 not give you the correct answer, for example).


* tg/git-remote (2016-02-16) 4 commits
  (merged to 'next' on 2016-02-18 at 091d43e)
 + remote: use remote_is_configured() for add and rename
 + remote: actually check if remote exits
 + remote: simplify remote_is_configured()
 + remote: use parse_config_key

 The internal API to interact with "remote.*" configuration
 variables has been streamlined.

 Will merge to 'master'.


* ls/config-origin (2016-02-22) 4 commits
  (merged to 'next' on 2016-02-24 at 239fcc2)
 + config: add '--show-origin' option to print the origin of a config value
 + config: add 'origin_type' to config_source struct
 + rename git_config_from_buf to git_config_from_mem
 + t: do not hide Git's exit code in tests using 'nul_to_q'

 The configuration system has been taught to phrase where it found a
 bad configuration variable in a better way in its error messages.
 "git config" learnt a new "--show-origin" option to indicate where
 the values come from.

 Will merge to 'master'.


* nd/icase (2016-02-15) 12 commits
 - grep.c: reuse "icase" variable
 - diffcore-pickaxe: support case insensitive match on non-ascii
 - diffcore-pickaxe: "share" regex error handling code
 - grep/pcre: support utf-8
 - gettext: add is_utf8_locale()
 - grep/pcre: prepare locale-dependent tables for icase matching
 - grep/icase: avoid kwsset when -F is specified
 - grep/icase: avoid kwsset on literal non-ascii strings
 - test-regex: expose full regcomp() to the command line
 - test-regex: isolate the bug test code
 - grep: break down an "if" stmt in preparation for next changes
 - grep: allow -F -i combination

 "git grep -i" has been taught to fold case in non-ascii locales.

 Needs review.
 ($gmane/286137)


* tb/conversion (2016-02-23) 7 commits
  (merged to 'next' on 2016-02-25 at 1bb466d)
 + convert.c: correct attr_action()
  (merged to 'next' on 2016-02-12 at 6faf27b)
 + convert.c: simplify text_stat
 + convert.c: refactor crlf_action
 + convert.c: use text_eol_is_crlf()
 + convert.c: remove input_crlf_action()
 + convert.c: remove unused parameter 'path'
 + t0027: add tests for get_stream_filter()

 Code simplification.

 Will merge to 'master'.


* sb/submodule-parallel-update (2016-02-25) 11 commits
 - clone: allow an explicit argument for parallel submodule clones
 - submodule update: expose parallelism to the user
 - git submodule update: have a dedicated helper for cloning
 - run_processes_parallel: correctly terminate callbacks with an LF
 - run_processes_parallel: rename parameters for the callbacks
 - run-command: expose default_{start_failure, task_finished}
 - run_processes_parallel: treat output of children as byte array
 - submodule update: direct error message to stderr
 - fetching submodules: respect `submodule.fetchJobs` config option
 - submodule-config: drop check against NULL
 - submodule-config: keep update strategy around
 (this branch is used by dt/refs-backend-lmdb and sb/submodule-init.)

 A major part of "git submodule update" has been ported to C to take
 advantage of the recently added framework to run download tasks in
 parallel.

 Seems to break tests when merged to the tip of 'pu'.


* dt/refs-backend-lmdb (2016-02-25) 34 commits
 - SQUASH??? Minimum compilation band-aid
 - tests: add ref-storage argument
 - refs: tests for lmdb backend
 - refs: add LMDB refs storage backend
 - refs: break out resolve_ref_unsafe_submodule
 - config: read ref storage config on startup
 - refs: register ref storage backends
 - svn: learn ref-storage argument
 - clone: allow ref storage backend to be set for clone
 - refs: check submodules' ref storage config
 - init: allow alternate ref strorage to be set for new repos
 - refs: always handle non-normal refs in files backend
 - refs: resolve symbolic refs first
 - refs: on symref reflog expire, lock symref not referrent
 - refs: don't dereference on rename
 - refs: allow log-only updates
 - refs: move duplicate check to common code
 - refs: make lock generic
 - refs: handle non-normal ref renames
 - refs: add method to rename refs
 - refs: add methods to init refs db
 - refs: add method for delete_refs
 - refs: add method for initial ref transaction commit
 - refs: add methods for reflog
 - refs: add do_for_each_per_worktree_ref
 - refs: reduce the visibility of do_for_each_ref()
 - refs: add method for do_for_each_ref
 - refs: add methods for misc ref operations
 - refs: add a backend method structure with transaction functions
 - refs: move resolve_ref_unsafe into common code
 - files-backend: break out ref reading
 - refs: move for_each_*ref* functions into common code
 - refs: move head_ref{,_submodule} to the common code
 - Merge branch 'sb/submodule-parallel-update' into dt/refs-backend-lmdb
 (this branch uses sb/submodule-parallel-update; is tangled with sb/submodule-init.)

 Building on top of a few refs-backend preparatory series, LMDB
 based refs backend has been plugged into the system.

 ($gmane/286572)


* kn/ref-filter-atom-parsing (2016-02-17) 11 commits
  (merged to 'next' on 2016-02-18 at 9606218)
 + ref-filter: introduce objectname_atom_parser()
 + ref-filter: introduce contents_atom_parser()
 + ref-filter: introduce remote_ref_atom_parser()
 + ref-filter: align: introduce long-form syntax
 + ref-filter: introduce align_atom_parser()
 + ref-filter: introduce parse_align_position()
 + ref-filter: introduce color_atom_parser()
 + ref-filter: introduce parsing functions for each valid atom
 + ref-filter: introduce struct used_atom
 + ref-filter: bump 'used_atom' and related code to the top
 + ref-filter: use string_list_split over strbuf_split

 The ref-filter's format-parsing code has been refactored, in
 preparation for "branch --format" and friends.

 Will merge to 'master'.


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2016-02-08) 7 commits
 - rerere: do use multiple variants
 - t4200: rerere a merge with two identical conflicts
 - rerere: allow multiple variants to exist
 - rerere: delay the recording of preimage
 - rerere: handle leftover rr-cache/$ID directory and postimage files
 - rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
 - rerere: split conflict ID further

 "git rerere" can encounter two or more files with the same conflict
 signature that have to be resolved in different ways, but there was
 no way to record these separate resolutions.

 Needs further work on forget/gc.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007.  It has been reported that
 git-gui still uses the deprecated syntax, which needs to be fixed
 before this final step can proceed.
 ($gmane/282594)

--------------------------------------------------
[Discarded]

* dv/http-try-negotiate-at-least-once (2016-02-02) 1 commit
 . remote-curl: don't fall back to Basic auth if we haven't tried Negotiate

 bc/http-empty-auth satisfies the original need that triggered this
 topic better.


* ep/format-printf (2016-02-11) 22 commits
 . wt-status.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . utf8.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . transport-helper.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . trace.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . strbuf.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . remote.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . pkt-line.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . merge-recursive.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . imap-send.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . http-backend.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . fsck.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . daemon.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . config.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . color.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . cache.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . builtin/upload-archive.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . builtin/update-index.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . builtin/receive-pack.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . builtin/index-pack.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . argv-array.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . advice.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . git-compat-util.h: add the FORMAT_PRINTF macro

 Replace __attribute__((format(printf, a, b))) with
 FORMAT_PRINTF(a,b) everywhere in the code.

 It would be a different story if another compiler had the same
 feature implemented using a different syntax, in which case we
 could use conditionally #define what FORMAT_PRINTF(a,b) expands to,
 but because we do not have such a compiler supported, this change
 is a net negative, churning the code without buying us anything
 (yet).


* jk/merge-tree-merge-blobs (2016-02-16) 1 commit
 . merge_blobs: use strbuf instead of manually-sized mmfile_t

 "git merge-tree" (a throw-away demonstration) did not work very
 well when merging "both sides added a new file at the same path"
 case.

 Solved differently by jk/no-diff-emit-common topic.
