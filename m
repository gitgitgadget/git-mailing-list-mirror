From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2013, #02; Fri, 5)
Date: Fri, 05 Jul 2013 02:09:11 -0700
Message-ID: <7v4nc98jbc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 11:09:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv213-0000Ko-Ki
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 11:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212Ab3GEJJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 05:09:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753718Ab3GEJJO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 05:09:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54715285A8;
	Fri,  5 Jul 2013 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=J
	Zy/fkU/SWm2zfTg4kiTnrE3f9o=; b=K+0o4uxRvICQqj1rFQ/SaY1xEcUmMLQQE
	qS5YSJ6RsW4Fyz8VGqk5wV+xhJJUXH4NK3nDCbnhbmuJm+yDzoW/T1hcuPNCgSke
	2XlnRA8hboBJwWwVCAIBnc9ncDCpcTlMHlC8U+ETzAxvPcEfYxVJh7lRL+sbbSEm
	LkFQSEwA/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=drZ
	73BfOKcoW2K/wQErUEzC5lz4jclPt5lD/AL5/8CEfOImfHm92WQe3EDmjHNQXPBI
	sfw4nj4CBZ8XSvEjJliWq+wEOECbKK0PfR9EXqqVwhK26vdRW6Xmc/TG35S7+V2H
	Oa7lWnWrzd10aBxs7uwPCryyJoQkmd7vHkqdWigc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49210285A7;
	Fri,  5 Jul 2013 09:09:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16039285A3;
	Fri,  5 Jul 2013 09:09:13 +0000 (UTC)
X-master-at: f8abaebab3fe1a1b873f9636ea410ac4007c8fa8
X-next-at: 0346b8459f4201954d9ada6dccc8e6ff9f59269c
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F6E3358-E552-11E2-9564-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229645>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

We are in the middle of 5th week now in the 11-week releace cycle
for 1.8.4 (http://tinyurl.com/gitCal), and quite a few topics have
graduated to 'master'.  I'd expect the rest of the week to be slow.

Please help ensure the quality of the upcoming release by testing
the tip of 'master' (and if you are so inclined, 'next') early.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* tr/test-v-and-v-subtest-only (2013-06-29) 9 commits
  (merged to 'next' on 2013-06-30 at 1c5fac1)
 + perf-lib: fix start/stop of perf tests
  (merged to 'next' on 2013-06-26 at 8ff4d84)
 + test-lib: support running tests under valgrind in parallel
 + test-lib: allow prefixing a custom string before "ok N" etc.
 + test-lib: valgrind for only tests matching a pattern
 + test-lib: verbose mode for only tests matching a pattern
 + test-lib: self-test that --verbose works
 + test-lib: rearrange start/end of test_expect_* and test_skip
 + test-lib: refactor $GIT_SKIP_TESTS matching
 + test-lib: enable MALLOC_* for the actual tests

 Allows N instances of tests run in parallel, each running 1/N parts
 of the test suite under Valgrind, to speed things up.

--------------------------------------------------
[New Topics]

* jc/t1512-fix (2013-07-01) 2 commits
 - get_short_sha1(): correctly disambiguate type-limited abbreviation
 - t1512: correct leftover constants from earlier edition

 A test that should have failed but didn't revealed a bug that needs
 to be corrected.

 Will merge to 'next'.


* jk/fetch-pack-many-refs (2013-07-02) 3 commits
 - fetch-pack: avoid quadratic behavior in rev_list_push
 - commit.c: make compare_commits_by_commit_date global
 - fetch-pack: avoid quadratic list insertion in mark_complete

 Fetching between repositories with many refs employed O(n^2)
 algorithm to match up the common objects, which has been corrected.

 Will merge to 'next'.


* jk/format-patch-from (2013-07-03) 2 commits
 - teach format-patch to place other authors into in-body "From"
 - pretty.c: drop const-ness from pretty_print_context

 "git format-patch" learned "--from[=whom]" option, which sets the
 "From: " header to the specified person (or the person who runs the
 command, if "=whom" part is missing) and move the original author
 information to an in-body From: header as necessary.

 Will merge to 'next'.


* ms/remote-tracking-branches-in-doc (2013-07-03) 1 commit
 - Change "remote tracking" to "remote-tracking"

 Will merge to 'next'.


* tf/gitweb-extra-breadcrumbs (2013-07-04) 1 commit
 - gitweb: allow extra breadcrumbs to prefix the trail

 An Gitweb installation that is a part of larger site can optionally
 show extra links that point at the levels higher than the Gitweb
 pages itself in the link hierarchy of pages.

 Will merge to 'next'.


* bc/commit-invalid-utf8 (2013-07-04) 2 commits
 - commit: reject overlong UTF-8 sequences
 - commit: reject invalid UTF-8 codepoints

 Will merge to 'next'.


* bc/send-email-use-port-as-separate-param (2013-07-04) 1 commit
 - send-email: provide port separately from hostname

 Will merge to 'next'.


* ml/cygwin-does-not-have-fifo (2013-07-05) 1 commit
 - test-lib.sh - cygwin does not have usable FIFOs

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* hv/config-from-blob (2013-05-12) 5 commits
 - do not die when error in config parsing of buf occurs
 - teach config --blob option to parse config from database
 - config: make parsing stack struct independent from actual data source
 - config: drop cf validity check in get_next_char()
 - config: factor out config file stack management

 Waiting for a reroll.
 $gmane/223964


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.
 $gmane/225137


* jl/submodule-mv (2013-04-23) 5 commits
 - submodule.c: duplicate real_path's return value
 - rm: delete .gitmodules entry of submodules removed from the work tree
 - Teach mv to update the path entry in .gitmodules for moved submodules
 - Teach mv to move submodules using a gitfile
 - Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Waiting for a reroll.
 $gmane/226294


* jk/list-objects-sans-blobs (2013-06-06) 4 commits
 . archive: ignore blob objects when checking reachability
 . list-objects: optimize "revs->blob_objects = 0" case
 . upload-archive: restrict remote objects with reachability check
 . clear parsed flag when we free tree buffers

 Attempt to allow "archive --remote=$there $arbitrary_sha1" while
 keeping the reachability safety.

 Seems to break some tests in a trivial and obvious way.


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicked back to 'pu'.


* mh/multimail (2013-04-21) 1 commit
 - git-multimail: a replacement for post-receive-email

 Waiting for the initial history to pull from.
 $gmane/223564


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* pb/stash-refuse-to-kill (2013-07-01) 2 commits
  (merged to 'next' on 2013-07-05 at 78ecc59)
 + git stash: avoid data loss when "git stash save" kills a directory
 + treat_directory(): do not declare submodules to be untracked

 "git stash save" is not just about "saving" the local changes, but
 also is to restore the working tree state to that of HEAD. If you
 changed a non-directory into a directory in the local change, you
 may have untracked files in that directory, which have to be killed
 while doing so, unless you run it with --include-untracked.  Teach
 the command to detect and error out before spreading the damage.

 This needed a small fix to "ls-files --killed".

 Will merge to 'next'.


* es/contacts (2013-07-03) 3 commits
 - contrib: contacts: interpret committish akin to format-patch
 - contrib: contacts: add ability to parse from committish
 - contrib: add git-contacts helper

 A helper to read from a set of format-patch output files or a range
 of commits and find those who may have insights to the code that
 the changes touch by running a series of "git blame" commands.

 Still needs to add mailmap support and other niceties but the
 basics already look sound, and the enhancements can be done
 in-tree. Assuming that "git contact" is something we may want to
 have as a member of the official set of commands someday, that is.

 Will merge to 'next'.


* jk/bash-completion (2013-06-30) 2 commits
  (merged to 'next' on 2013-07-01 at 6daca44)
 + completion: learn about --man-path
 + completion: handle unstuck form of base git options

 Will merge to 'master'.


* cp/submodule-custom-update (2013-07-03) 1 commit
 - submodule update: allow custom command to update submodule working tree

 In addition to the choice from "rebase, merge, or checkout-detach",
 allow a custom command to be used in "submodule update" to update
 the working tree of submodules.

 Will merge to 'next'.


* mv/merge-ff-tristate (2013-07-02) 1 commit
 - merge: handle --ff/--no-ff/--ff-only as a tri-state option

 The configuration variable "merge.ff" was cleary a tri-state to
 choose one from "favor fast-forward when possible", "always create
 a merge even when the history could fast-forward" and "do not
 create any merge, only update when the history fast-forwards", but
 the command line parser did not implement the usual convention of
 "last one wins, and command line overrides the configuration"
 correctly.

 Will merge to 'next'.


* rr/rebase-reflog-message-reword (2013-06-23) 2 commits
 - rebase -i: use a better reflog message
 - rebase: use a better reflog message
 (this branch uses rr/rebase-checkout-reflog.)

 "git rebase [-i]" used to leave just "rebase" as its reflog message
 for some operations. This rewords them to be more informative.

 Will merge to 'next'.


* bp/mediawiki-preview (2013-07-04) 7 commits
 - git-remote-mediawiki: Add preview subcommand into git mw
 - git-remote-mediawiki: Adding git-mw command
 - git-remote-mediawiki: Factoring code between git-remote-mediawiki and Git::Mediawiki
 - git-remote-mediawiki: Update tests to run with the new bin-wrapper
 - git-remote-mediawiki: New git bin-wrapper for developement
 - wrap-for-bin: Make bin-wrappers chainable
 - git-remote-mediawiki: Introduction of Git::Mediawiki.pm

 Looks like this is in a fairly good shape?


* fg/submodule-clone-depth (2013-07-03) 1 commit
 - Add --depth to submodule update/add

 Allow shallow-cloning of submodules with "git submodule update".

 Will merge to 'next'.


* jc/pull-training-wheel (2013-06-27) 1 commit
 - pull: require choice between rebase/merge on non-fast-forward pull

 Make "git pull" refuse with "it does not fast forward; choose between
 'pull --merge' and 'pull --rebase'".

 John Keeping seems to want to restrict this to "git pull" without
 any other argument. I personally do not have a strong opinion
 either way, but I'm inclined to take such a patch to loosen the new
 logic with other people's support.  Hint, hint...


* as/log-output-encoding-in-user-format (2013-07-05) 7 commits
  (merged to 'next' on 2013-07-05 at d2c99e5)
 + t4041, t4205, t6006, t7102: use iso8859-1 rather than iso-8859-1
  (merged to 'next' on 2013-07-01 at 3318aa8)
 + t4205: replace .\+ with ..* in sed commands
  (merged to 'next' on 2013-06-28 at 4063330)
 + pretty: --format output should honor logOutputEncoding
 + pretty: Add failing tests: --format output should honor logOutputEncoding
 + t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
 + t7102 (reset): don't hardcode SHA-1 in expected outputs
 + t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs

 "log --format=" did not honor i18n.logoutputencoding configuration
 and this is a beginning of the series that attempts to fix it.

 Will merge to 'master'.


* jc/maint-diff-core-safecrlf (2013-06-25) 1 commit
  (merged to 'next' on 2013-07-03 at db8a2a6)
 + diff: demote core.safecrlf=true to core.safecrlf=warn

 "git diff" refused to even show difference when core.safecrlf is
 set to true (i.e. error out) and there are offending lines in the
 working tree files.

 Will merge to 'master'.


* jk/fast-import-empty-ls (2013-06-23) 4 commits
 - fast-import: allow moving the root tree
 - fast-import: allow ls or filecopy of the root tree
 - fast-import: set valid mode on root tree in "ls"
 - t9300: document fast-import empty path issues

 Waiting for reviews.
 $gmane/228741


* af/rebase-i-merge-options (2013-07-02) 1 commit
 - Do not ignore merge options in interactive rebase

 "git rebase -i" now honors --strategy and -X options.

 Will merge to 'master'.


* rj/cygwin-remove-cheating-lstat (2013-06-25) 1 commit
 - cygwin: Remove the Win32 l/stat() implementation

 Seems that this gives different performance results to different
 people.

 A replacement WIP has been posted.
 $gmane/229280


* jc/triangle-push-fixup (2013-06-24) 5 commits
  (merged to 'next' on 2013-06-26 at 73cbb69)
 + t/t5528-push-default: test pushdefault workflows
 + t/t5528-push-default: generalize test_push_*
 + push: change `simple` to accommodate triangular workflows
 + config doc: rewrite push.default section
 + t/t5528-push-default: remove redundant test_config lines
 (this branch is tangled with rr/triangle-push-fix.)

 Earlier remote.pushdefault (and per-branch branch.*.pushremote)
 were introduced as an additional mechanism to choose what
 repository to push into when "git push" did not say it from the
 command line, to help people who push to a repository that is
 different from where they fetch from.  This attempts to finish that
 topic by teaching the default mechanism to choose branch in the
 remote repository to be updated by such a push.

 The 'current', 'matching' and 'nothing' modes (specified by the
 push.default configuration variable) extend to such a "triangular"
 workflow naturally, but 'upstream' and 'simple' have to be updated.

 . 'upstream' is about pushing back to update the branch in the
 remote repository that the current branch fetches from and
 integrates with, it errors out in a triangular workflow.

 . 'simple' is meant to help new people by avoiding mistakes, and
 will be the safe default in Git 2.0.  In a non-triangular
 workflow, it will continue to act as a cross between 'upstream'
 and 'current' in that it pushes to the current branch's
 @{upstream} only when it is set to the same name as the current
 branch (e.g. your 'master' forks from the 'master' from the
 central repository).  In a triangular workflow, this series
 tentatively defines it as the same as 'current', but we may have
 to tighten it to avoid surprises in some way.

 Will merge to 'master'.


* jg/status-config (2013-06-24) 4 commits
  (merged to 'next' on 2013-07-03 at 6ac1ada)
 + status/commit: make sure --porcelain is not affected by user-facing config
 + commit: make it work with status.short
 + status: introduce status.branch to enable --branch by default
 + status: introduce status.short to enable --short by default

 "git status" learned status.branch and status.short configuration
 variables to use --branch and --short options by default (override
 with --no-branch and --no-short options from the command line).

 The bottom two has been graduated to 'master' but then reverted.
 The tip two are quick attempts to fix the fallout.  The one for
 status.short looks correct; the other one, while it is correct,
 is unfortunately overly complex in order not to introduce an
 unnecessary regression.

 Will merge to 'master'.


* jc/reflog-doc (2013-06-19) 1 commit
 - setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates this, but it
 is a leaf user that does not call out to or dot-sources other
 scripts, so fixing it is not all that urgent.


* mh/ref-races-optim-invalidate-cached (2013-06-20) 1 commit
 - refs: do not invalidate the packed-refs cache unnecessarily

 This requires the platform lstat() to be correct to avoid false
 negatives.


* rr/rebase-checkout-reflog (2013-06-17) 5 commits
  (merged to 'next' on 2013-07-01 at 27cfd27)
 + checkout: respect GIT_REFLOG_ACTION
  (merged to 'next' on 2013-06-27 at 4d99efa)
 + status: do not depend on rebase reflog messages
 + t/t2021-checkout-last: "checkout -" should work after a rebase finishes
 + wt-status: remove unused field in grab_1st_switch_cbdata
 + t7512: test "detached from" as well
 (this branch is used by rr/rebase-reflog-message-reword.)

 Invocations of "git checkout" used internally by "git rebase" were
 counted as "checkout", and affected later "git checkout -" to the
 the user to an unexpected place.

 The "bugfix" bits of the series is here.  The follow-up part to
 reword reflog messages for steps in "rebase" are split to another
 topic.

 Will merge to 'master'.


* jx/clean-interactive (2013-06-26) 16 commits
 - test: run testcases with POSIX absolute paths on Windows
 - test: add t7301 for git-clean--interactive
 - git-clean: add documentation for interactive git-clean
 - git-clean: add ask each interactive action
 - git-clean: add select by numbers interactive action
 - git-clean: add filter by pattern interactive action
 - git-clean: use a git-add-interactive compatible UI
 - git-clean: add colors to interactive git-clean
 - git-clean: show items of del_list in columns
 - git-clean: add support for -i/--interactive
  (merged to 'next' on 2013-06-26 at f7be2d8)
 + git-clean: refactor git-clean into two phases
 + write_name{_quoted_relative,}(): remove redundant parameters
 + quote_path_relative(): remove redundant parameter
 + quote.c: substitute path_relative with relative_path
 + path.c: refactor relative_path(), not only strip prefix
 + test: add test cases for relative_path

 Add "interactive" mode to "git clean".

 The early part to refactor relative path related helper functions
 looked sensible. The actual "clean interactive" may want to be
 discussed further by interested parties before the topic is fully
 merged to 'next'.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.
