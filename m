From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2013, #02; Fri, 5)
Date: Fri, 05 Apr 2013 15:27:11 -0700
Message-ID: <7vip40bolc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:52:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWQo-0001b9-An
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163054Ab3DEW1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:27:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40546 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162792Ab3DEW1P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 18:27:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03C0814425;
	Fri,  5 Apr 2013 22:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=1
	oqmPqHrFsI+wFf2jLlROQnsWX0=; b=xQvSfteK98ppOXl6052cEXQmOrLRS2ejT
	dvc/zvzEZ12TQub85+aioIjciLW0NiwfvWSJR9LErTHPKqkNMGCLcgWNpQw0k+NZ
	qHeT1JsSfu0AbQBb2iulxjFfAGeTM5Fobzmevdlt7EHyyGnIkPZyqcN5Zm27yPwL
	7evvhpKE/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=uhz
	q1PSLa9y7poPlLEKYtjz8WEtbpv3Q2BUCudc+3JUKBnXbvLovpVQs1LU31d7zE/+
	GdBzmgklkodAF4y7SfbtMmeHf+KWp16Pg4EIhdjqpYOVUHXf308unOfhVqJUAdTh
	Q+cKPBwYQGhLQLq6iHuOya3ojoM7rEJ+ef4emc2A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED6EA14424;
	Fri,  5 Apr 2013 22:27:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A81A114423; Fri,  5 Apr
 2013 22:27:12 +0000 (UTC)
X-master-at: 21ccebec0dd1d7e624ea2f22af6ac93686daf34f
X-next-at: 2c8b7bf47c81acd2a76c1f9c3be2a1f102b76d31
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F64E4784-9E3F-11E2-8E8B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220238>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

A handful of topics that have been stalled for quite a while have
been discarded; for those that are not superseded by something else,
interested parties can still resubmit a reroll, but without any
advances, we do not get any benefit from carrying them in my tree.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bk/document-commit-tree-S (2013-03-25) 1 commit
  (merged to 'next' on 2013-03-26 at 8ee205f)
 + commit-tree: document -S option consistently


* jc/apply-ws-fix-tab-in-indent (2013-03-29) 2 commits
  (merged to 'next' on 2013-03-29 at 26eb6e9)
 + test: resurrect q_to_tab
  (merged to 'next' on 2013-03-26 at 46c6bda)
 + apply --whitespace=fix: avoid running over the postimage buffer

 "git apply --whitespace=fix" was not prepared to see a line getting
 longer after fixing whitespaces (e.g. tab-in-indent aka Python).


* jc/directory-attrs-regression-fix (2013-03-28) 6 commits
  (merged to 'next' on 2013-03-29 at a3dce2b)
 + t: check that a pattern without trailing slash matches a directory
 + dir.c::match_pathname(): pay attention to the length of string parameters
 + dir.c::match_pathname(): adjust patternlen when shifting pattern
 + dir.c::match_basename(): pay attention to the length of string parameters
 + attr.c::path_matches(): special case paths that end with a slash
 + attr.c::path_matches(): the basename is part of the pathname

 Fix 1.8.1.x regression that stopped matching "dir" (without
 trailing slash) to a directory "dir".


* jc/merge-tag-object (2013-04-01) 3 commits
  (merged to 'next' on 2013-04-03 at 94b5c7d)
 + t6200: test message for merging of an annotated tag
 + t6200: use test_config/test_unconfig
  (merged to 'next' on 2013-03-29 at aeec39c)
 + merge: a random object may not necssarily be a commit

 "git merge $(git rev-parse v1.8.2)" behaved quite differently from
 "git merge v1.8.2" as if v1.8.2 were written as v1.8.2^0 and did
 not pay much attention to the annotated tag payload.

 This makes the code notice the type of the tag object, in addition
 to the dwim_ref() based classification the current code uses
 (i.e. the name appears in refs/tags/) to decide when to special
 case merging of tags.


* jc/sha1-name-object-peeler (2013-03-31) 2 commits
  (merged to 'next' on 2013-04-01 at cdb4a18)
 + peel_onion(): teach $foo^{object} peeler
 + peel_onion: disambiguate to favor tree-ish when we know we want a tree-ish
 (this branch is used by mh/rev-parse-verify-doc.)

 There was no good way to ask "I have a random string that came from
 outside world. I want to turn it into a 40-hex object name while
 making sure such an object exists".  A new peeling suffix ^{object}
 can be used for that purpose, together with "rev-parse --verify".


* jc/t5516-pushInsteadOf-vs-pushURL (2013-03-28) 1 commit
  (merged to 'next' on 2013-04-01 at bed2879)
 + t5516: test interaction between pushURL and pushInsteadOf correctly

 Update a test to match the documented interaction between pushURL
 and pushInsteadOf.


* jk/check-corrupt-objects-carefully (2013-03-29) 10 commits
  (merged to 'next' on 2013-03-29 at b6a04a7)
 + clone: leave repo in place after checkout errors
 + clone: run check_everything_connected
 + clone: die on errors from unpack_trees
 + add tests for cloning corrupted repositories
 + streaming_write_entry: propagate streaming errors
 + add test for streaming corrupt blobs
 + avoid infinite loop in read_istream_loose
 + read_istream_filtered: propagate read error from upstream
 + check_sha1_signature: check return value from read_istream
 + stream_blob_to_fd: detect errors reading from stream

 Have the streaming interface and other codepaths more carefully
 examine for corrupt objects.


* jk/config-with-empty-section (2013-03-29) 1 commit
  (merged to 'next' on 2013-04-01 at 7972aa9)
 + t1300: document some aesthetic failures of the config editor

 Document that "git config --unset" does not remove an empty section
 head after removing the last variable in a section, and adding a
 new variable does not try to reuse a leftover empty section head.


* jk/difftool-no-overwrite-on-copyback (2013-03-29) 5 commits
  (merged to 'next' on 2013-03-29 at 9f42d34)
 + t7800: run --dir-diff tests with and without symlinks
 + t7800: fix tests when difftool uses --no-symlinks
 + t7800: don't hide grep output
 + difftool: don't overwrite modified files
 + t7800: move '--symlinks' specific test to the end

 Try to be careful when difftool backend allows the user to write
 into the temporary files being shown *and* the user makes changes
 to the working tree at the same time. One of the changes has to be
 lost in such a case, but at least tell the user what he did.


* jk/no-more-self-assignment (2013-03-25) 2 commits
  (merged to 'next' on 2013-03-26 at 31ec9ac)
 + match-trees: simplify score_trees() using tree_entry()
 + submodule: clarify logic in show_submodule_summary

 This started as a topic to reduce "type var = var" self assignment
 tricks that were used to squelch "variable used uninitialized perhaps?"
 warning from some compilers, but resulted in rewriting logic with
 a version that is simpler and easier to understand for humans.


* jl/submodule-deinit (2013-04-01) 1 commit
  (merged to 'next' on 2013-04-03 at 2ef485c)
 + submodule deinit: clarify work tree removal message

 A finishing touch to the new topic in 1.8.3.


* jm/branch-rename-nothing-error (2013-03-31) 1 commit
  (merged to 'next' on 2013-04-01 at 5e5cdaf)
 + branch: give better message when no names specified for rename

 "git branch -m" without any argument noticed an error, but with an
 incorrect error message.


* js/iterm-is-on-osx (2013-03-29) 1 commit
  (merged to 'next' on 2013-04-01 at 201fed2)
 + git-web--browse: recognize any TERM_PROGRAM as a GUI terminal on OS X

 Add more logic to detect graphic environment of OS X by simply
 checking TERM_PROGRAM has some value, not Apple_Terminal, to detect
 iTerm.app and any other.


* js/log-gpg (2013-03-27) 1 commit
  (merged to 'next' on 2013-03-29 at 9a1b2d3)
 + log: read gpg settings for signed commit verification

 Teach "show/log" honor gpg.program configuration just like other
 parts of the code that use GnuPG.


* mh/rev-parse-verify-doc (2013-04-02) 1 commit
  (merged to 'next' on 2013-04-03 at a09c332)
 + rev-parse: clarify documentation for the --verify option

 "rev-parse --verify" was documented in a misleading way.


* nd/checkout-paths-reduce-match-pathspec-calls (2013-03-27) 1 commit
  (merged to 'next' on 2013-03-29 at fbcc004)
 + checkout: avoid unnecessary match_pathspec calls

 Consolidate repeated pathspec matches on the same paths, while
 fixing a bug in "git checkout dir/" code started from an unmerged
 index.


* rr/prompt-revert-head (2013-03-31) 1 commit
  (merged to 'next' on 2013-04-01 at 1fc21eb)
 + bash: teach __git_ps1 about REVERT_HEAD

 The prompt string generator did not notice when we are in a middle
 of a "git revert" session.


* rr/send-email-perl-critique (2013-03-31) 3 commits
  (merged to 'next' on 2013-04-03 at d552868)
 + send-email: use the three-arg form of open in recipients_cmd
 + send-email: drop misleading function prototype
 + send-email: use "return;" not "return undef;" on error codepaths

 Broken down from an earlier discussion to pick up reasonable bits
 with explanation, to demonstrate how it should be done.


* rs/submodule-summary-limit (2013-04-01) 1 commit
  (merged to 'next' on 2013-04-01 at 3c18cfe)
 + submodule summary: support --summary-limit=<n>

 "submodule summary --summary-limit" option did not support
 "--option=value" form.


* sg/gpg-sig (2013-03-31) 5 commits
  (merged to 'next' on 2013-04-03 at 9c13a17)
 + pretty printing: extend %G? to include 'N' and 'U'
 + merge/pull Check for untrusted good GPG signatures
 + merge/pull: verify GPG signatures of commits being merged
 + commit.c/GPG signature verification: Also look at the first GPG status line
 + Move commit GPG signature verification to commit.c

 Teach "merge/pull" to optionally verify and reject commits that are
 not signed properly.


* sw/safe-create-leading-dir-race (2013-03-26) 1 commit
  (merged to 'next' on 2013-03-26 at 744bb50)
 + safe_create_leading_directories: fix race that could give a false negative


* tb/cygwin-shared-repository (2013-03-25) 1 commit
  (merged to 'next' on 2013-03-29 at dbeb068)
 + Make core.sharedRepository work under cygwin 1.7
 (this branch is used by tb/shared-perm.)

 Cygwin port has a faster-but-lying lstat(2) emulation whose
 incorrectness does not matter in practice except for a few
 codepaths, and setting permission bits to directories is a codepath
 that needs to use a more correct one.


* tr/log-tree-optim (2013-03-28) 1 commit
  (merged to 'next' on 2013-03-29 at 5a6795d)
 + Avoid loading commits twice in log with diffs

 Optimize "log" that shows the difference between the parent and the
 child.


* tr/valgrind (2013-04-01) 4 commits
  (merged to 'next' on 2013-04-01 at a973c52)
 + tests: notice valgrind error in test_must_fail
 + tests --valgrind: provide a mode without --track-origins
 + tests: parameterize --valgrind option
 + t/README: --valgrind already implies -v

 Let us use not just memgrind but other *grind debuggers.

--------------------------------------------------
[New Topics]

* cn/commit-amend-doc (2013-04-05) 1 commit
  (merged to 'next' on 2013-04-05 at 4c42e59)
 + Documentation/git-commit: reword the --amend explanation
 (this branch is used by jc/detached-head-doc.)

 Will merge to 'master'.


* fc/remote-helpers-test-updates (2013-04-04) 4 commits
  (merged to 'next' on 2013-04-04 at 0612744)
 + remote-hg: fix hg-git test-case
 + remote-bzr: remove stale check code for tests
 + remote-helpers: fix the run of all tests
 + remote-bzr: avoid echo -n
 (this branch is used by fc/transport-helper-waitpid.)

 Will merge to 'master'.


* fc/remote-hg (2013-04-04) 13 commits
 - remote-hg: push to the appropriate branch
 - remote-hg: update tags globally
 - remote-hg: force remote push
 - remote-hg: update remote bookmarks
 - remote-hg: refactor export
 - remote-hg: split bookmark handling
 - remote-hg: redirect buggy mercurial output
 - remote-hg: trivial test cleanups
 - remote-hg: make sure fake bookmarks are updated
 - remote-hg: fix for files with spaces
 - remote-hg: properly report errors on bookmark pushes
 - remote-hg: add missing config variable in doc
 - remote-hg: trivial cleanups

 The "forced push" may need to become optional behaviour.
 Also the tip one was found faulty.

 Expecting a reroll.


* fc/transport-helper-waitpid (2013-04-04) 2 commits
 - transport-helper: check if remote helper is alive
 - run-command: add new check_command helper
 (this branch uses fc/remote-helpers-test-updates.)

 Seems to be solving a real problem at a wrong level.


* jk/bisect-prn-unsigned (2013-04-03) 1 commit
  (merged to 'next' on 2013-04-04 at 2c4df36)
 + bisect: avoid signed integer overflow

 Will merge to 'master'.


* jk/diffcore-break-divzero (2013-04-03) 1 commit
  (merged to 'next' on 2013-04-04 at b7632e0)
 + diffcore-break: don't divide by zero

 Will merge to 'master'.


* jk/filter-branch-come-back-to-original (2013-04-02) 1 commit
  (merged to 'next' on 2013-04-04 at 621684a)
 + filter-branch: return to original dir after filtering

 Will merge to 'master'.


* jk/set-upstream-error-cases (2013-04-02) 5 commits
  (merged to 'next' on 2013-04-04 at b58c26b)
 + branch: give advice when tracking start-point is missing
 + branch: mention start_name in set-upstream error messages
 + branch: improve error message for missing --set-upstream-to ref
 + branch: factor out "upstream is not a branch" error messages
 + t3200: test --set-upstream-to with bogus refs

 Will merge to 'master'.


* js/rerere-forget-protect-against-NUL (2013-04-04) 2 commits
  (merged to 'next' on 2013-04-05 at 426d4e2)
 + rerere forget: do not segfault if not all stages are present
 + rerere forget: grok files containing NUL

 A few bugfixes to "git rerere" working on corner case merge
 conflicts.

 Will merge to 'master'.


* mc/count-objects-kibibytes (2013-04-03) 1 commit
  (merged to 'next' on 2013-04-05 at f4e50e8)
 + count-objects: output "KiB" instead of "kilobytes"

 The command reports the total diskspace used to store loose objects
 in kibibytes, but it was labelled as "kilobytes".  The number now
 is shown with "KiB", e.g. "6750 objects, 50928 KiB".

 If you have scripts that decide when to run "git repack" by parsing
 the output from "git count-objects", this release may break them.
 Sorry about that.  One of the scripts shipped by git-core itself
 also had to be adjusted.  You may want to consider updating such
 scripts to always call "git gc --auto" to let it decide when to
 repack for you.

 Will merge to 'master'.


* mm/status-during-revert (2013-04-02) 2 commits
  (merged to 'next' on 2013-04-04 at 1282528)
 + status: show commit sha1 in "You are currently reverting" message
 + status: show 'revert' state and status hint

 Will merge to 'master'.


* po/help-guides (2013-04-03) 5 commits
  (merged to 'next' on 2013-04-04 at 3d99b28)
 + doc: include --guide option description for "git help"
 + help: mention -a and -g option, and 'git help <concept>' usage.
 + builtin/help.c: add list_common_guides_help() function
 + builtin/help.c: add --guide option
 + builtin/help.c: split "-a" processing into two

 "git help" learned "-g" option to show the list of guides just like
 list of commands are given with "-a".

 Will merge to 'master'.


* jk/http-dumb-namespaces (2013-04-04) 1 commit
 - http-backend: respect GIT_NAMESPACE with dumb clients

 Allow smart-capable HTTP servers to be restricted via the
 GIT_NAMESPACE mechanism when talking with commit-walker clients
 (they already do so when talking with smart HTTP clients).


* jk/rm-removed-paths (2013-04-04) 3 commits
  (merged to 'next' on 2013-04-05 at ce9a926)
 + t3600: document failure of rm across symbolic links
 + t3600: test behavior of reverse-d/f conflict
 + rm: do not complain about d/f conflicts during deletion

 A handful of test cases and a corner case bugfix for "git rm".

 Will merge to 'master'.


* jl/submodule-mv (2013-04-03) 3 commits
 - Teach mv to update the path entry in .gitmodules for moved submodules
 - Teach mv to move submodules using a gitfile
 - Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Seems to break tests in 'pu' but it may be a mismerge with
 nd/magic-pathspecs topic.


* mg/texinfo-5 (2013-04-03) 1 commit
  (merged to 'next' on 2013-04-04 at bd84440)
 + Documentation: Strip texinfo anchors to avoid duplicates

 Strip @anchor elements in the texinfo output of the documentation,
 as a single document created by concatenating our entire manual set
 will produce many duplicates that makes newer texinfo unhappy.

 Will merge to 'master'.


* sr/log-SG-no-textconv (2013-04-05) 6 commits
  (merged to 'next' on 2013-04-05 at 7f06945)
 + diffcore-pickaxe: unify code for log -S/-G
 + diffcore-pickaxe: fix leaks in "log -S<block>" and "log -G<pattern>"
 + diffcore-pickaxe: port optimization from has_changes() to diff_grep()
 + diffcore-pickaxe: respect --no-textconv
 + diffcore-pickaxe: remove fill_one()
 + diffcore-pickaxe: remove unnecessary call to get_textconv()

 "git log -S/-G" started paying attention to textconv filter, but
 there was no way to disable this.  Make it honor --no-textconv
 option.

 Will merge to 'master'.


* tr/perl-keep-stderr-open (2013-04-04) 2 commits
 - t9700: do not close STDERR
 - perl: redirect stderr to /dev/null instead of closing

 Closing (not redirecting to /dev/null) the standard error stream is
 not a very smart thing to do.  Later open may return file
 descriptor #2 for unrelated purpose, and error reporting code may
 write into them.

 Will merge to 'next'.


* jc/detached-head-doc (2013-04-05) 1 commit
 - glossary: extend "detached HEAD" description
 (this branch uses cn/commit-amend-doc.)


* jk/diff-algo-finishing-touches (2013-04-05) 2 commits
 - diff: allow unstuck arguments with --diff-algorithm
 - git-merge(1): document diff-algorithm option to merge-recursive


* jk/diff-graph-submodule-summary (2013-04-05) 1 commit
 - submodule: print graph output next to submodule log

--------------------------------------------------
[Stalled]

* jc/format-patch (2013-02-21) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

--------------------------------------------------
[Cooking]

* tb/shared-perm (2013-04-05) 2 commits
  (merged to 'next' on 2013-04-05 at 2481155)
 + path.c: optimize adjust_shared_perm()
 + path.c: simplify adjust_shared_perm()

 Simplifies adjust_shared_perm() implementation.

 Will merge to 'master'.


* nd/pretty-formats (2013-04-01) 12 commits
 - pretty: support %>> that steal trailing spaces
 - pretty: support truncating in %>, %< and %><
 - pretty: support padding placeholders, %< %> and %><
 - pretty: add %C(auto) for auto-coloring on the next placeholder
 - pretty: two phase conversion for non utf-8 commits
 - utf8: keep NULs in reencode_string()
 - pretty: get the correct encoding for --pretty:format=%e
 - pretty: save commit encoding from logmsg_reencode if the caller needs it
 - utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
 - utf8.c: move display_mode_esc_sequence_len() for use by other functions
 - pretty: share code between format_decoration and show_decorations
 - pretty-formats.txt: wrap long lines

 A mixed bag of a bugfix and two fun enhancements on pretty formats
 placeholder.

 Expecting a reroll.


* jk/merge-tree-added-identically (2013-03-27) 1 commit
 - merge-tree: fix "same file added in subdir"

 We would most likely want to change things the other way around.

 Expecting a reroll.


* rr/triangle (2013-04-02) 6 commits
  (merged to 'next' on 2013-04-04 at 2d2c8ee)
 + remote.c: introduce branch.<name>.pushremote
 + remote.c: introduce remote.pushdefault
 + remote.c: introduce a way to have different remotes for fetch/push
 + t5516 (fetch-push): drop implicit arguments from helper functions
 + t5516 (fetch-push): update test description
 + remote.c: simplify a bit of code using git_config_string()

 Support "pull from one place, push to another place" workflow
 better by introducing remote.pushdefault (overrides the "origin"
 thing) and branch.*.pushremote (overrides the branch.*.remote).

 Will merge to 'master'.


* ap/combine-diff-coalesce-lost (2013-03-25) 1 commit
  (merged to 'next' on 2013-03-29 at f6a05ca)
 + combine-diff: coalesce lost lines optimally

 Attempts to minimize "diff -c/--cc" output by coalescing the same
 lines removed from the parents better, but with an O(n^2)
 complexity.

 Will cook in 'next' to see if people with real-world usage scream.


* kb/status-ignored-optim (2013-03-19) 8 commits
  (merged to 'next' on 2013-04-01 at 0c12ed9)
 + dir.c: git-status: avoid is_excluded checks for tracked files
 + dir.c: replace is_path_excluded with now equivalent is_excluded API
 + dir.c: unify is_excluded and is_path_excluded APIs
 + dir.c: move prep_exclude and factor out parts of last_exclude_matching
 + dir.c: git-status --ignored: don't list empty directories as ignored
 + dir.c: git-status --ignored: don't list empty ignored directories
 + dir.c: git-status --ignored: don't list files in ignored directories
 + dir.c: git-status --ignored: don't drop ignored directories

 "git status --ignored" had many corner case bugs.  Also the command
 has been optimized by taking advantage of the fact that paths that
 are already known to the index do not have to be checked against
 the .gitignore mechanism most of the time.

 Will cook in 'next'.

 This codepath is used not only by status but also in add and clean,
 so a bug in it can result in lost data.  Extra sets of eyeballs are
 very much appreciated.


* jn/add-2.0-u-A-sans-pathspec (2013-04-03) 6 commits
 - git add: -u/-A now affects the entire working tree
  (merged to 'next' on 2013-04-05 at eae93ef)
 + add -A: only show pathless 'add -A' warning when changes exist outside cwd
 + add -u: only show pathless 'add -u' warning when changes exist outside cwd
 + add: make warn_pathless_add() a no-op after first call
 + add: add a blank line at the end of pathless 'add [-u|-A]' warning
 + add: make pathless 'add [-u|-A]' warning a file-global function

 "git add -u/-A" without any pathspec traditionally limited its
 operation to the current directory when run from a subdirectory,
 but in Git 2.0, they will affect the entire working tree.  Start
 training users to explicitly say "." or ":/" to smooth out the
 transition hump with the earlier parts of this series, and flip the
 default as the final step.

 Will cook in 'next' until Git 2.0.


* tr/packed-object-info-wo-recursion (2013-03-27) 3 commits
  (merged to 'next' on 2013-03-29 at b1c3858)
 + sha1_file: remove recursion in unpack_entry
 + Refactor parts of in_delta_base_cache/cache_or_unpack_entry
 + sha1_file: remove recursion in packed_object_info

 Attempts to reduce the stack footprint of sha1_object_info()
 and unpack_entry() codepaths.

 Will cook in 'next'.


* nd/magic-pathspecs (2013-03-31) 45 commits
 - Rename field "raw" to "_raw" in struct pathspec
 - pathspec: support :(glob) syntax
 - pathspec: make --literal-pathspecs disable pathspec magic
 - pathspec: support :(literal) syntax for noglob pathspec
 - Kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
 - parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
 - parse_pathspec: make sure the prefix part is wildcard-free
 - tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
 - Remove match_pathspec() in favor of match_pathspec_depth()
 - Remove init_pathspec() in favor of parse_pathspec()
 - Remove diff_tree_{setup,release}_paths
 - Convert common_prefix() to use struct pathspec
 - Convert add_files_to_cache to take struct pathspec
 - Convert {read,fill}_directory to take struct pathspec
 - Convert refresh_index to take struct pathspec
 - Convert report_path_error to take struct pathspec
 - checkout: convert read_tree_some to take struct pathspec
 - Convert unmerge_cache to take struct pathspec
 - Convert run_add_interactive to use struct pathspec
 - Convert read_cache_preload() to take struct pathspec
 - reset: convert to use parse_pathspec
 - add: convert to use parse_pathspec
 - check-ignore: convert to use parse_pathspec
 - archive: convert to use parse_pathspec
 - ls-files: convert to use parse_pathspec
 - rm: convert to use parse_pathspec
 - checkout: convert to use parse_pathspec
 - rerere: convert to use parse_pathspec
 - status: convert to use parse_pathspec
 - commit: convert to use parse_pathspec
 - clean: convert to use parse_pathspec
 - Guard against new pathspec magic in pathspec matching code
 - parse_pathspec: support prefixing original patterns
 - parse_pathspec: support stripping/checking submodule paths
 - parse_pathspec: support stripping submodule trailing slashes
 - parse_pathspec: a special flag for max_depth feature
 - Convert some get_pathspec() calls to parse_pathspec()
 - parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
 - parse_pathspec: save original pathspec for reporting
 - Add parse_pathspec() that converts cmdline args to struct pathspec
 - pathspec: add copy_pathspec
 - pathspec: i18n-ize error strings in pathspec parsing code
 - Move struct pathspec and related functions to pathspec.[ch]
 - clean: remove unused variable "seen"
 - setup.c: check that the pathspec magic ends with ")"

 Migrate the rest of codebase to use "struct pathspec" more.

 Will merge to 'next' after all the dust settles.


* jc/add-2.0-delete-default (2013-03-08) 3 commits
 - git add <pathspec>... defaults to "-A"
  (merged to 'next' on 2013-04-05 at 199442e)
 + git add: start preparing for "git add <pathspec>..." to default to "-A"
 + builtin/add.c: simplify boolean variables

 In Git 2.0, "git add pathspec" will mean "git add -A pathspec".  If
 you did this in a working tree that tracks dir/lost and dir/another:

 $ rm dir/lost
 $ edit dir/another
 $ git add dir

 The last step will not only notices and records updated
 dir/another, but also notices and records the removal of dir/lost
 in the index.

 Start training the users for this change to say --no-all when they
 want to ignore the removal to smooth the transition hump.

 Will cook in 'next' until Git 2.0.


* tr/line-log (2013-04-05) 7 commits
  (merged to 'next' on 2013-04-05 at 5afb00c)
 + log -L: fix overlapping input ranges
 + log -L: check range set invariants when we look it up
  (merged to 'next' on 2013-04-01 at 5be920c)
 + Speed up log -L... -M
 + log -L: :pattern:file syntax to find by funcname
 + Implement line-history search (git log -L)
 + Export rewrite_parents() for 'log -L'
 + Refactor parse_loc

 Will merge down to 'master'
 with warts and all, hoping they get fixed eventually in-tree.


* jc/push-2.0-default-to-simple (2013-04-03) 13 commits
 - push: switch default from "matching" to "simple"
  (merged to 'next' on 2013-04-05 at 1b42c19)
 + t5570: do not assume the "matching" push is the default
 + t5551: do not assume the "matching" push is the default
 + t5550: do not assume the "matching" push is the default
 + t9401: do not assume the "matching" push is the default
 + t9400: do not assume the "matching" push is the default
 + t7406: do not assume the "matching" push is the default
 + t5531: do not assume the "matching" push is the default
 + t5519: do not assume the "matching" push is the default
 + t5517: do not assume the "matching" push is the default
 + t5516: do not assume the "matching" push is the default
 + t5505: do not assume the "matching" push is the default
 + t5404: do not assume the "matching" push is the default

 Update the test suite that still assumed the push.default will
 forever be 'matching'.  In Git 2.0, that will no longer be the
 case.

 Will cook in 'next' until Git 2.0.
