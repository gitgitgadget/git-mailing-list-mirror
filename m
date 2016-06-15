From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2014, #04; Thu, 20)
Date: Thu, 20 Mar 2014 14:09:10 -0700
Message-ID: <xmqq4n2sy3ux.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 22:09:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQkDN-0007oH-RQ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 22:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759899AbaCTVJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 17:09:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759527AbaCTVJP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 17:09:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82FA876F6A;
	Thu, 20 Mar 2014 17:09:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
	M8/tBnKEJqu2NCE0/5ym2M27jE=; b=bpEcdxcRgdOX++Q8Sui+tsg0CHpJukGR+
	hdolM7XEaOi0DC080r0X56+F2xeIFMXxwj47kSG3xggvWvtyURZQp27hOeK6zs67
	Logf7iHxcu5xNhdZrVrcIHfAIuOvE1hMTT+b80WbB2Qfew9S+ZxY/YHgNVb3glx9
	8X+Wj/CDro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=qA/
	WbEkRYlsVQy0vx1lmYuF0hgOfVDRsx2hqDoOB0ursErSxKqFoIzQ1N95GOvZMRTr
	DOP6Fb4mJ9pD/WZhxg+cSuft0oTXVlzoTbynwzg8EEwUV7NnnReiVm4XU8L1q/15
	GOAwpqwmPsVNRlQPpki6aXqHflSpV9WvQ0afLwJ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E95676F67;
	Thu, 20 Mar 2014 17:09:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3448576F62;
	Thu, 20 Mar 2014 17:09:13 -0400 (EDT)
X-master-at: 5172cb3bcb2c7e1a609e34cfae64e3b181e0226a
X-next-at: 4443bfdcdf4b1e25b48040987632afd841c9b636
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E349DDDC-B073-11E3-A8BE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244583>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

More topics merged to 'master', some of which have been cooking
before the v1.9.0 final release, many of them fallouts from GSoC
microprojects.  Many topics that have been marked to be discarded
are finally discarded.

Quite a few topics are still outside 'pu' and I suspect some of the
larger ones deserve deeper reviews to help moving them to 'next'.
In principle, I'd prefer to keep any large topic that touch core
part of the system cooking in 'next' for at least a full cycle, and
the sooner they get merged to 'next', the better.  Help is greatly
appreciated.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bg/install-branch-config-skip-prefix (2014-03-06) 2 commits
  (merged to 'next' on 2014-03-12 at 9d04564)
 + branch: use skip_prefix() in install_branch_config()
 + t3200-branch: test setting branch as own upstream


* dd/find-graft-with-sha1-pos (2014-02-27) 1 commit
  (merged to 'next' on 2014-03-12 at 0383d59)
 + commit.c: use the generic "sha1_pos" function for lookup

 Replace a hand-rolled binary search with a call to our generic
 binary search helper function.


* dd/use-alloc-grow (2014-03-03) 14 commits
  (merged to 'next' on 2014-03-12 at ed82259)
 + sha1_file.c: use ALLOC_GROW() in pretend_sha1_file()
 + read-cache.c: use ALLOC_GROW() in add_index_entry()
 + builtin/mktree.c: use ALLOC_GROW() in append_to_tree()
 + attr.c: use ALLOC_GROW() in handle_attr_line()
 + dir.c: use ALLOC_GROW() in create_simplify()
 + reflog-walk.c: use ALLOC_GROW()
 + replace_object.c: use ALLOC_GROW() in register_replace_object()
 + patch-ids.c: use ALLOC_GROW() in add_commit()
 + diffcore-rename.c: use ALLOC_GROW()
 + diff.c: use ALLOC_GROW()
 + commit.c: use ALLOC_GROW() in register_commit_graft()
 + cache-tree.c: use ALLOC_GROW() in find_subtree()
 + bundle.c: use ALLOC_GROW() in add_to_ref_list()
 + builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()

 Replace open-coded reallocation with ALLOC_GROW() macro.


* fc/transport-helper-fixes (2014-02-24) 7 commits
  (merged to 'next' on 2014-03-12 at 5d7c69a)
 + remote-bzr: support the new 'force' option
 + test-hg.sh: tests are now expected to pass
 + transport-helper.c: do not overwrite forced bit
 + transport-helper: check for 'forced update' message
 + transport-helper: add 'force' to 'export' helpers
 + transport-helper: don't update refs in dry-run
 + transport-helper: mismerge fix

 Updates transport-helper, fast-import and fast-export to allow the
 ref mapping and ref deletion in a way similar to the natively
 supported transports.


* jc/no-need-for-env-in-sh-scripts (2014-03-06) 1 commit
  (merged to 'next' on 2014-03-12 at dfd3234)
 + *.sh: drop useless use of "env"


* jc/tag-contains-with (2014-03-07) 1 commit
  (merged to 'next' on 2014-03-12 at e120644)
 + tag: grok "--with" as synonym to "--contains"


* jk/clean-d-pathspec (2014-03-11) 2 commits
  (merged to 'next' on 2014-03-12 at aaae6ee)
 + clean: simplify dir/not-dir logic
 + clean: respect pathspecs with "-d"

 "git clean -d pathspec" did not use the given pathspec correctly
 and ended up cleaning too much.


* jk/detect-push-typo-early (2014-03-05) 3 commits
  (merged to 'next' on 2014-03-12 at da522e7)
 + push: detect local refspec errors early
 + match_explicit_lhs: allow a "verify only" mode
 + match_explicit: hoist refspec lhs checks into their own function

 Catch "git push $there no-such-branch" early.


* jk/diff-filespec-cleanup (2014-02-24) 1 commit
  (merged to 'next' on 2014-03-12 at 184c2aa)
 + diffcore.h: be explicit about the signedness of is_binary

 Portability fix to a topic already in v1.9


* jk/doc-deprecate-grafts (2014-03-05) 1 commit
  (merged to 'next' on 2014-03-12 at 8d34916)
 + docs: mark info/grafts as outdated


* jk/repack-pack-keep-objects (2014-03-03) 1 commit
  (merged to 'next' on 2014-03-12 at 3fd2335)
 + repack: add `repack.packKeptObjects` config var


* jn/branch-lift-unnecessary-name-length-limit (2014-03-05) 1 commit
  (merged to 'next' on 2014-03-12 at bd0fb0e)
 + branch.c: delete size check of newly tracked branch names


* mh/simplify-cache-tree-find (2014-03-05) 6 commits
  (merged to 'next' on 2014-03-12 at c29aa24)
 + cache_tree_find(): use path variable when passing over slashes
 + cache_tree_find(): remove early return
 + cache_tree_find(): remove redundant check
 + cache_tree_find(): fix comment formatting
 + cache_tree_find(): find the end of path component using strchrnul()
 + cache_tree_find(): remove redundant checks


* nd/sha1-file-delta-stack-leakage-fix (2014-02-24) 1 commit
  (merged to 'next' on 2014-03-12 at 9d1a621)
 + sha1_file: fix delta_stack memory leak in unpack_entry

 Fix a small leak in the delta stack used when resolving a long
 delta chain at runtime.


* rm/strchrnul-not-strlen (2014-03-10) 1 commit
  (merged to 'next' on 2014-03-12 at fad8f12)
 + use strchrnul() in place of strchr() and strlen()


* rs/grep-h-c (2014-03-11) 2 commits
  (merged to 'next' on 2014-03-12 at 0341bd8)
 + grep: support -h (no header) with --count
 + t7810: add missing variables to tests in loop

 "git grep" learns to handle combination of "-h (no header)" and "-c
 (counts)".


* sh/finish-tmp-packfile (2014-03-03) 2 commits
  (merged to 'next' on 2014-03-12 at 410d45d)
 + finish_tmp_packfile():use strbuf for pathname construction
 + Merge branch 'sh/write-pack-file-warning-message-fix' into sh/finish-tmp-packfile


* sh/use-hashcpy (2014-03-06) 1 commit
  (merged to 'next' on 2014-03-12 at cf2735a)
 + Use hashcpy() when copying object names


--------------------------------------------------
[New Topics]

* jk/lib-terminal-lazy (2014-03-14) 1 commit
  (merged to 'next' on 2014-03-20 at 5de832f)
 + t/lib-terminal: make TTY a lazy prerequisite

 The test helper lib-terminal always run an actual test_expect_* when
 included, which screwed up with the use of skil-all that may have to
 be done later.

 Will merge to 'master'.


* ah/doc-gitk-config (2014-03-20) 1 commit
  (merged to 'next' on 2014-03-20 at d671b60)
 + Documentation/gitk: document the location of the configulation file

 Will merge to 'master'.


* as/grep-fullname-config (2014-03-20) 1 commit
 - grep: add grep.fullName config variable


* fr/add-interactive-argv-array (2014-03-18) 1 commit
  (merged to 'next' on 2014-03-20 at 9d65f3d)
 + add: use struct argv_array in run_add_interactive()

 Will merge to 'master'.


* jk/pack-bitmap (2014-03-17) 1 commit
  (merged to 'next' on 2014-03-20 at bba6246)
 + pack-objects: turn off bitmaps when skipping objects

 Instead of dying when asked to (re)pack with the reachability
 bitmap when a bitmap cannot be built, just (re)pack without
 producing a bitmap in such a case, with a warning.

 Will merge to 'master', and probably to 'maint' later.


* jk/pack-bitmap-progress (2014-03-17) 2 commits
  (merged to 'next' on 2014-03-20 at c7a83f9)
 + pack-objects: show reused packfile objects in "Counting objects"
 + pack-objects: show progress for reused packfiles

 The progress output while repacking and transferring objects showed
 an apparent large silence while writing the objects out of existing
 packfiles, when the reachability bitmap was in use.

 Will merge to 'master', and probably to 'maint' later.


* jk/subtree-prefix (2014-03-17) 1 commit
  (merged to 'next' on 2014-03-20 at 81367fa)
 + subtree: initialize "prefix" variable

 A stray environment variable $prefix could have leaked into and
 affected the behaviour of the "subtree" script.

 Will merge to 'master'.


* nd/gc-aggressive (2014-03-17) 4 commits
 - gc --aggressive: three phase repacking
 - gc --aggressive: make --depth configurable
 - pack-objects: support --keep
 - environment.c: fix constness for odb_pack_keep()


* nd/index-pack-error-message (2014-03-17) 1 commit
  (merged to 'next' on 2014-03-20 at 4d722ac)
 + index-pack: report error using the correct variable

 Will merge to 'master'.


* rr/doc-merge-strategies (2014-03-17) 1 commit
  (merged to 'next' on 2014-03-20 at d31f415)
 + Documentation/merge-strategies: avoid hyphenated commands

 Will merge to 'master'.


* us/printf-not-echo (2014-03-18) 2 commits
  (merged to 'next' on 2014-03-20 at 41205c8)
 + test-lib.sh: do not "echo" caller-supplied strings
 + rebase -i: do not "echo" random user-supplied strings

 Will merge to 'master'.


* bb/diff-no-index-dotdot (2014-03-19) 2 commits
  (merged to 'next' on 2014-03-20 at 352f48c)
 + diff-no-index: replace manual "."/".." check with is_dot_or_dotdot()
 + diff-no-index: rename read_directory()

 Will merge to 'master'.


* bg/rebase-off-of-previous-branch (2014-03-19) 1 commit
 - rebase: allow "-" short-hand for the previous branch

 Will merge to 'next'.


* dt/tests-with-env-not-subshell (2014-03-19) 1 commit
 - tests: use "env" to run commands with temporary env-var settings


* hs/simplify-bit-setting-in-fsck-tree (2014-03-20) 1 commit
 - fsck: use bitwise-or assignment operator to set flag


* mm/status-porcelain-format-i18n-fix (2014-03-20) 2 commits
 - SQUASH??? fix decl-after-stmt and simplify
 - status: disable translation when --porcelain is used


* ss/test-on-mingw-rsync-path-no-absolute (2014-03-19) 1 commit
  (merged to 'next' on 2014-03-20 at 2b7b95d)
 + t5510: Do not use $(pwd) when fetching / pushing / pulling via rsync

 Will merge to 'master'.


* sz/mingw-index-pack-threaded (2014-03-19) 1 commit
 - Enable index-pack threading in msysgit.

 Still under discussion among Windows folks

--------------------------------------------------
[Stalled]

* bc/blame-crlf-test (2014-02-18) 1 commit
 - blame: add a failing test for a CRLF issue.

 I have a feeling that a fix for this should be fairly isolated and
 trivial (it should be just the matter of paying attention to the
 crlf settings when synthesizing the fake commit)---perhaps somebody
 can squash in a fix to this?


* jk/makefile (2014-02-05) 16 commits
 - FIXUP
 - move LESS/LV pager environment to Makefile
 - Makefile: teach scripts to include make variables
 - FIXUP
 - Makefile: auto-build C strings from make variables
 - Makefile: drop *_SQ variables
 - FIXUP
 - Makefile: add c-quote helper function
 - Makefile: introduce sq function for shell-quoting
 - Makefile: always create files via make-var
 - Makefile: store GIT-* sentinel files in MAKE/
 - Makefile: prefer printf to echo for GIT-*
 - Makefile: use tempfile/mv strategy for GIT-*
 - Makefile: introduce make-var helper function
 - Makefile: fix git-instaweb dependency on gitweb
 - Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

 Simplify the Makefile rules and macros that exist primarily for
 quoting purposes, and make it easier to robustly express the
 dependency rules.

 Expecting a reroll.


* kb/fast-hashmap-pack-struct (2014-02-24) 1 commit
 - hashmap.h: make sure map entries are tightly packed

 I am inclined to drop this; an alternative is to replace it with
 the "more portable" one that uses #pragma, which I am willing to
 try doing so on 'pu', though.


* po/everyday-doc (2014-01-27) 1 commit
 - Make 'git help everyday' work

 This may make the said command to emit something, but the source is
 not meant to be formatted into a manual pages to begin with, and
 also its contents are a bit stale.  It may be a good first step in
 the right direction, but needs more work to at least get the
 mark-up right before public consumption.

 Will hold.


* jk/branch-at-publish-rebased (2014-01-17) 5 commits
 - t1507 (rev-parse-upstream): fix typo in test title
 - implement @{publish} shorthand
 - branch_get: provide per-branch pushremote pointers
 - branch_get: return early on error
 - sha1_name: refactor upstream_mark

 Give an easier access to the tracking branches from "other" side in
 a triangular workflow by introducing B@{publish} that works in a
 similar way to how B@{upstream} does.

 Meant to be used as a basis for whatever Ram wants to build on.

 Will hold.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jl/submodule-recursive-checkout (2013-12-26) 5 commits
 - Teach checkout to recursively checkout submodules
 - submodule: teach unpack_trees() to update submodules
 - submodule: teach unpack_trees() to repopulate submodules
 - submodule: teach unpack_trees() to remove submodule contents
 - submodule: prepare for recursive checkout of submodules

 Expecting a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* hv/submodule-ignore-fix (2013-12-06) 4 commits
 - disable complete ignorance of submodules for index <-> HEAD diff
 - always show committed submodules in summary after commit
 - teach add -f option for ignored submodules
 - fix 'git add' to skip submodules configured as ignored

 Teach "git add" to be consistent with "git status" when changes to
 submodules are set to be ignored, to avoid surprises after checking
 with "git status" to see there isn't any change to be further added
 and then see that "git add ." adds changes to them.

 I think a reroll is coming, so this may need to be replaced, but I
 needed some practice with heavy conflict resolution.  It conflicts
 with two changes to "git add" that have been scheduled for Git 2.0
 quite badly, and I think I got the resolution right this time.

 Waiting for a reroll.


* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Temporarily ejected from 'pu', to try out jk/pack-bitmap, which
 this topic conflicts with.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* ap/remote-hg-skip-null-bookmarks (2014-03-19) 1 commit
 - remote-hg: do not fail on invalid bookmarks

 Will merge to 'next'.


* jn/wt-status (2014-03-12) 4 commits
  (merged to 'next' on 2014-03-14 at 8ac862c)
 + wt-status: lift the artificual "at least 20 columns" floor
 + wt-status: i18n of section labels
 + wt-status: extract the code to compute width for labels
 + wt-status: make full label string to be subject to l10n

 Unify the codepaths that format new/modified/changed sections and
 conflicted paths in the "git status" output and make it possible to
 properly internationalize their output.

 Will merge to 'master'.


* es/sh-i18n-envsubst (2014-03-12) 1 commit
  (merged to 'next' on 2014-03-14 at e4d5603)
 + sh-i18n--envsubst: retire unused string_list_member()

 Will merge to 'master'.


* mh/remove-subtree-long-pathname-fix (2014-03-13) 2 commits
  (merged to 'next' on 2014-03-17 at 68cc994)
 + entry.c: fix possible buffer overflow in remove_subtree()
 + checkout_entry(): use the strbuf throughout the function

 Will merge to 'master'.


* nd/indent-fix-connect-c (2014-03-13) 1 commit
  (merged to 'next' on 2014-03-17 at a109efc)
 + connect.c: SP after "}", not TAB

 Will merge to 'master'.


* pw/branch-config-message (2014-03-13) 1 commit
 - install_branch_config(): simplify verbose messages logic

 Among the many attempts to microproject #8, this seemed to be the
 most "done" among the table based ones; I however tend to think
 that the original with minimum refactoring would be easier to read.


* ys/fsck-commit-parsing (2014-03-19) 2 commits
 - fsck.c:fsck_commit(): use skip_prefix() to verify and skip constant
 - fsck.c:fsck_ident(): ident points at a const string

 Will merge to 'next'.


* jk/warn-on-object-refname-ambiguity (2014-03-13) 4 commits
  (merged to 'next' on 2014-03-17 at 3f8e98e)
 + rev-list: disable object/refname ambiguity check with --stdin
 + cat-file: restore warn_on_object_refname_ambiguity flag
 + cat-file: fix a minor memory leak in batch_objects
 + cat-file: refactor error handling of batch_objects

 Will merge to 'master'.


* jk/diff-funcname-cpp-regex (2014-03-05) 1 commit
 - diff: simplify cpp funcname regex

 It appears that Peff and Hannes agreed to base the final version
 not on this one, but Hannes's version.


* bp/commit-p-editor (2014-03-18) 7 commits
 - run-command: mark run_hook_with_custom_index as deprecated
 - merge hook tests: fix and update tests
 - merge: fix GIT_EDITOR override for commit hook
 - commit: fix patch hunk editing with "commit -p -m"
 - test patch hunk editing with "commit -p -m"
 - merge hook tests: use 'test_must_fail' instead of '!'
 - merge hook tests: fix missing '&&' in test

 Will merge to 'next'.


* cp/am-patch-format-doc (2014-03-17) 2 commits
  (merged to 'next' on 2014-03-17 at 7437c77)
 + Documentation/git-am: typofix
  (merged to 'next' on 2014-03-12 at 17c3ada)
 + Documentation/git-am: Document supported --patch-format options

 Will merge to 'master'.


* dm/configure-iconv-locale-charset (2014-03-11) 1 commit
  (merged to 'next' on 2014-03-20 at 4443bfd)
 + configure.ac: link with -liconv for locale_charset()

 Will merge to 'master'.


* jk/mv-submodules-fix (2014-03-17) 2 commits
  (merged to 'next' on 2014-03-17 at 7cae3b1)
 + mv: prevent mismatched data when ignoring errors.
 + builtin/mv: fix out of bounds write

 Will merge to 'master'.


* nd/upload-pack-shallow (2014-03-11) 1 commit
  (merged to 'next' on 2014-03-14 at d40b8c3)
 + upload-pack: send shallow info over stdin to pack-objects

 Will merge to 'master'.


* jc/stash-pop-not-popped (2014-02-26) 1 commit
  (merged to 'next' on 2014-03-14 at 9ba1de8)
 + stash pop: mention we did not drop the stash upon failing to apply

 "stash pop", upon failing to apply the stash, refrains from
 discarding the stash to avoid information loss.  Be more explicit
 in the error message.

 The wording may want to get a bit more bikeshedding.

 Will merge to 'master'.


* cn/fetch-prune-overlapping-destination (2014-02-28) 2 commits
 - fetch: handle overlaping refspecs on --prune
 - fetch: add a failing test for prunning with overlapping refspecs

 Protect refs in a hierarchy that can come from more than one remote
 hierarcies from incorrect removal by "git fetch --prune".

 Comments?


* dk/skip-prefix-scan-only-once (2014-03-03) 1 commit
  (merged to 'next' on 2014-03-14 at ff375fc)
 + skip_prefix(): scan prefix only once

 Update implementation of skip_prefix() to scan only once; given
 that most "prefix" arguments to the inline function are constant
 strings whose strlen() can be determined at the compile time, this
 might actually make things worse with a compiler with sufficient
 intelligence.

 Will merge to 'master'.


* jk/shallow-update-fix (2014-03-17) 3 commits
  (merged to 'next' on 2014-03-17 at 011942e)
 + shallow: verify shallow file after taking lock
  (merged to 'next' on 2014-03-12 at ce5abbf)
 + shallow: automatically clean up shallow tempfiles
 + shallow: use stat_validity to check for up-to-date file

 Serving objects from a shallow repository needs to write a
 temporary file to be used, but the serving upload-pack may not have
 write access to the repository which is meant to be read-only.

 Will merge to 'master'.


* nd/tag-version-sort (2014-02-27) 1 commit
  (merged to 'next' on 2014-03-14 at 4e7f714)
 + tag: support --sort=<spec>

 Allow v1.9.0 sorted before v1.10.0 in "git tag --list" output.

 Will merge to 'master'.


* tc/commit-dry-run-exit-status-tests (2014-02-24) 1 commit
  (merged to 'next' on 2014-03-12 at b839886)
 + demonstrate git-commit --dry-run exit code behaviour


* nd/commit-editor-cleanup (2014-02-25) 3 commits
  (merged to 'next' on 2014-03-17 at 986605d)
 + commit: add --cleanup=scissors
 + wt-status.c: move cut-line print code out to wt_status_add_cut_line
 + wt-status.c: make cut_line[] const to shrink .data section a bit

 "git commit --cleanup=<mode>" learned a new mode, scissors.


* nd/multiple-work-trees (2014-03-17) 28 commits
 - count-objects: report unused files in $GIT_DIR/repos/...
 - gc: support prune --repos
 - gc: style change -- no SP before closing bracket
 - prune: strategies for linked checkouts
 - checkout: detach if the branch is already checked out elsewhere
 - checkout: clean up half-prepared directories in --to mode
 - checkout: support checking out into a new working directory
 - use new wrapper write_file() for simple file writing
 - wrapper.c: wrapper to open a file, fprintf then close
 - setup.c: support multi-checkout repo setup
 - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 - setup.c: convert check_repository_format_gently to use strbuf
 - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 - setup.c: convert is_git_directory() to use strbuf
 - git-stash: avoid hardcoding $GIT_DIR/logs/....
 - *.sh: avoid hardcoding $GIT_DIR/hooks/...
 - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 - $GIT_COMMON_DIR: a new environment variable
 - commit: use SEQ_DIR instead of hardcoding "sequencer"
 - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 - reflog: avoid constructing .lock path with git_path
 - *.sh: respect $GIT_INDEX_FILE
 - git_path(): be aware of file relocation in $GIT_DIR
 - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 - path.c: rename vsnpath() to do_git_path()
 - git_snpath(): retire and replace with strbuf_git_path()
 - path.c: make get_pathname() call sites return const char *
 - path.c: make get_pathname() return strbuf instead of static buffer

 Replaced with v5 (with minor fixes already squashed in).


* ks/tree-diff-nway (2014-03-04) 19 commits
 - combine-diff: speed it up, by using multiparent diff tree-walker directly
 - tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
 - Portable alloca for Git
 - tree-diff: reuse base str(buf) memory on sub-tree recursion
 - tree-diff: no need to call "full" diff_tree_sha1 from show_path()
 - tree-diff: rework diff_tree interface to be sha1 based
 - tree-diff: diff_tree() should now be static
 - tree-diff: remove special-case diff-emitting code for empty-tree cases
 - tree-diff: simplify tree_entry_pathcmp
 - tree-diff: show_path prototype is not needed anymore
 - tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
 - tree-diff: move all action-taking code out of compare_tree_entry()
 - tree-diff: don't assume compare_tree_entry() returns -1,0,1
 - tree-diff: consolidate code for emitting diffs and recursion in one place
 - tree-diff: show_tree() is not needed
 - tree-diff: no need to pass match to skip_uninteresting()
 - tree-diff: no need to manually verify that there is no mode change for a path
 - combine-diff: move changed-paths scanning logic into its own function
 - combine-diff: move show_log_first logic/action out of paths scanning

 Instead of running N pair-wise diff-trees when inspecting a
 N-parent merge, find the set of paths that were touched by walking
 N+1 trees in parallel.  These set of paths can then be turned into
 N pair-wise diff-tree results to be processed through rename
 detections and such.  And N=2 case nicely degenerates to the usual
 2-way diff-tree, which is very nice.


* nd/log-show-linear-break (2014-03-20) 2 commits
 - log: add --show-linear-break to help see non-linear history
 - object.h: centralize object flag allocation

 Attempts to show where a single-strand-of-pearls break in "git log"
 output.

 The implementation seems to have got worse compared to the previous
 round.  Will hold.


* tr/remerge-diff (2014-02-26) 5 commits
 . log --remerge-diff: show what the conflict resolution changed
 . name-hash: allow dir hashing even when !ignore_case
 . merge-recursive: allow storing conflict hunks in index
 . revision: fold all merge diff variants into an enum merge_diff_mode
 . combine-diff: do not pass revs->dense_combined_merges redundantly
 (this branch uses tr/merge-recursive-index-only.)

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 RFC.  This latest round clashes with the kb/fast-hashmap topic in
 'master'.


* lt/request-pull (2014-03-13) 6 commits
  (merged to 'next' on 2014-03-17 at 21a598d)
 + request-pull: documentation updates
 + request-pull: resurrect "pretty refname" feature
 + request-pull: test updates
 + request-pull: pick up tag message as before
 + request-pull: allow "local:remote" to specify names on both ends
 + request-pull: more strictly match local/remote branches

 Discard the accumulated "heuristics" to guess from which branch the
 result wants to be pulled from and make sure what the end user
 specified is not second-guessed by "git request-pull", to avoid
 mistakes.

 Will merge to 'master'.


* cc/interpret-trailers (2014-03-07) 11 commits
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands in config file
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from stdin
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from stdin and arguments
 - trailers: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.


* tr/merge-recursive-index-only (2014-02-05) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()
 (this branch is used by tr/remerge-diff.)

 Will hold.
