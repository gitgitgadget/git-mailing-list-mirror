From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2013, #01; Mon, 1)
Date: Mon, 01 Apr 2013 13:56:11 -0700
Message-ID: <7vppyehswk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 22:56:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMlmX-0003n4-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 22:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757681Ab3DAU4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 16:56:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757531Ab3DAU4O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 16:56:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1544F11633;
	Mon,  1 Apr 2013 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=j
	GkJ1n9M86aHjeIaZegUgI851Nk=; b=M67+gy7U6OnqT2bWMbjgSNNGweKYgCisq
	fiMf9Z3i5bni+XkphsR8i7H/SbDEXGgwhv4CgpImHsV5Shjmlh0l9Cs41xpCVk5q
	Musvoqn5+p/LFGPqexqW09h1h5FMUrwCMIJkoBDTLKj6y6MFrsXzWZ2XfJtI/fzG
	HJeEknK840=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=tDl
	Gu8/HtUtVhYUPhGzbIq9be3RLtQrVrCHy2ZnWa/BDmCIBVMzuK2oC6hGtziFtLAV
	LNsgG+vjMXvakyZZECN5R35Do4reYwz7I59HqNNdgB1gabDBpwrg4n+TteZYgMku
	P1SPk8B6193R/UDsVqcTolBgW5OQ3x8QDZmPI9ag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0805311632;
	Mon,  1 Apr 2013 20:56:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0BA911630; Mon,  1 Apr
 2013 20:56:12 +0000 (UTC)
X-master-at: cc3e4eba723570bf77902c017611ee02bb86c8b3
X-next-at: 5a7d8b8c6ff8c59f4ad782e539b1d511ca6f2e63
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9656C7EA-9B0E-11E2-8D5A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219706>

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

* bc/append-signed-off-by (2013-02-23) 13 commits
  (merged to 'next' on 2013-03-26 at 0e3c79b)
 + git-commit: populate the edit buffer with 2 blank lines before s-o-b
 + Unify appending signoff in format-patch, commit and sequencer
 + format-patch: update append_signoff prototype
 + t4014: more tests about appending s-o-b lines
 + sequencer.c: teach append_signoff to avoid adding a duplicate newline
 + sequencer.c: teach append_signoff how to detect duplicate s-o-b
 + sequencer.c: always separate "(cherry picked from" from commit body
 + sequencer.c: require a conforming footer to be preceded by a blank line
 + sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
 + t/t3511: add some tests of 'cherry-pick -s' functionality
 + t/test-lib-functions.sh: allow to specify the tag name to test_commit
 + commit, cherry-pick -s: remove broken support for multiline rfc2822 fields
 + sequencer.c: rework search for start of footer to improve clarity

 Consolidates codepaths that inspect log-message-to-be and decide to
 add a new Signed-off-by line in various commands.  I think there is
 no negative behaviour change in this series, but please report any
 iffy behaviour change immediately if you notice one.


* jc/nobody-sets-src-peer-ref (2013-03-04) 1 commit
  (merged to 'next' on 2013-03-26 at 9d13c02)
 + match_push_refs(): nobody sets src->peer_ref anymore

 Dead code removal.

 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.


* jc/remove-export-from-config-mak-in (2013-03-05) 3 commits
  (merged to 'next' on 2013-03-26 at a789220)
 + Fix `make install` when configured with autoconf
 + Makefile: do not export mandir/htmldir/infodir
 + config.mak.in: remove unused definitions

 config.mak.in template had an "export" line to cause a few
 common makefile variables to be exported; if they need to be
 expoted for autoconf/configure users, they should also be exported
 for people who write config.mak the same way.  Move the "export" to
 the main Makefile.  Also, stop exporting mandir that used to be
 exported (only) when config.mak.autogen was used.  It would have
 broken installation of manpages (but not other documentation
 formats).

 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.


* jk/common-make-variables-export-safety (2013-02-25) 1 commit
  (merged to 'next' on 2013-03-26 at 8b7bb16)
 + Makefile: make mandir, htmldir and infodir absolute

 Make the three variables safer to be exported to submakes by
 ensuring that they are full paths so that they can be used as
 installation location.

 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.


* jk/index-pack-correct-depth-fix (2013-03-20) 1 commit
  (merged to 'next' on 2013-03-26 at c56e839)
 + index-pack: always zero-initialize object_entry list

 "index-pack --fix-thin" used uninitialize value to compute delta
 depths of objects it appends to the resulting pack.


* jk/pkt-line-cleanup (2013-03-21) 20 commits
  (merged to 'next' on 2013-03-26 at 2bb3b75)
 + do not use GIT_TRACE_PACKET=3 in tests
 + remote-curl: always parse incoming refs
 + remote-curl: move ref-parsing code up in file
 + remote-curl: pass buffer straight to get_remote_heads
 + teach get_remote_heads to read from a memory buffer
 + pkt-line: share buffer/descriptor reading implementation
 + pkt-line: provide a LARGE_PACKET_MAX static buffer
 + pkt-line: move LARGE_PACKET_MAX definition from sideband
 + pkt-line: teach packet_read_line to chomp newlines
 + pkt-line: provide a generic reading function with options
 + pkt-line: drop safe_write function
 + pkt-line: move a misplaced comment
 + write_or_die: raise SIGPIPE when we get EPIPE
 + upload-archive: use argv_array to store client arguments
 + upload-archive: do not copy repo name
 + send-pack: prefer prefixcmp over memcmp in receive_status
 + fetch-pack: fix out-of-bounds buffer offset in get_ack
 + upload-pack: remove packet debugging harness
 + upload-pack: do not add duplicate objects to shallow list
 + upload-pack: use get_sha1_hex to parse "shallow" lines

 Cleans up pkt-line API, implementation and its callers to make them
 more robust.  Even though I think this change is correct, please
 report immediately if you find any unintended side effect.


* jn/push-tests (2013-03-19) 3 commits
  (merged to 'next' on 2013-03-26 at da891db)
 + push test: rely on &&-chaining instead of 'if bad; then echo Oops; fi'
 + push test: simplify check of push result
 + push test: use test_config when appropriate

 Update t5516 with style fixes.


* kb/name-hash (2013-02-27) 1 commit
  (merged to 'next' on 2013-03-26 at 750490a)
 + name-hash.c: fix endless loop with core.ignorecase=true

 The code to keep track of what directory names are known to Git on
 platforms with case insensitive filesystems can get confused upon
 a hash collision between these pathnames and looped forever.

 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.


* nd/branch-show-rebase-bisect-state (2013-03-23) 7 commits
  (merged to 'next' on 2013-03-26 at cd666f6)
 + status, branch: fix the misleading "bisecting" message
 + branch: show more information when HEAD is detached
 + status: show more info than "currently not on any branch"
 + wt-status: move wt_status_get_state() out to wt_status_print()
 + wt-status: split wt_status_state parsing function out
 + wt-status: move strbuf into read_and_strip_branch()
 + Merge branch 'jc/reflog-reverse-walk' into nd/branch-show-rebase-bisect-state

 "git status" shows a bit more info during a bisect/rebase session.


* nd/index-pack-threaded-fixes (2013-03-19) 2 commits
  (merged to 'next' on 2013-03-26 at e508c77)
 + index-pack: guard nr_resolved_deltas reads by lock
 + index-pack: protect deepest_delta in multithread code

 "index-pack --verify-stat" used a few counters outside protection
 of mutex, possibly showing incorrect numbers.


* rr/test-3200-style (2013-03-20) 1 commit
  (merged to 'next' on 2013-03-26 at 1214287)
 + t3200 (branch): modernize style

 Churns.


* sr/am-show-final-message-in-applying-indicator (2013-03-21) 1 commit
  (merged to 'next' on 2013-03-26 at 9ecb143)
 + git-am: show the final log message on "Applying:" indicator

 In addition to the case where the user edits the log message with
 the "e)dit" option of "am -i", replace the "Applying: this patch"
 message with the final log message contents after applymsg hook
 munges it.

--------------------------------------------------
[New Topics]

* jc/sha1-name-object-peeler (2013-03-31) 2 commits
  (merged to 'next' on 2013-04-01 at cdb4a18)
 + peel_onion(): teach $foo^{object} peeler
 + peel_onion: disambiguate to favor tree-ish when we know we want a tree-ish
 (this branch is used by mh/rev-parse-verify-doc.)

 There was no good way to ask "I have a random string that came from
 outside world. I want to turn it into a 40-hex object name while
 making sure such an object exists".  A new peeling suffix ^{object}
 can be used for that purpose, together with "rev-parse --verify".


* jm/branch-rename-nothing-error (2013-03-31) 1 commit
  (merged to 'next' on 2013-04-01 at 5e5cdaf)
 + branch: give better message when no names specified for rename

 "git branch -m" without any argument noticed an error, but with an
 incorrect error message.

 Will merge to 'master'.


* rr/prompt-revert-head (2013-03-31) 1 commit
  (merged to 'next' on 2013-04-01 at 1fc21eb)
 + bash: teach __git_ps1 about REVERT_HEAD

 The prompt string generator did not notice when we are in a middle
 of a "git revert" session.

 Will merge to 'master'.


* rr/send-email-perl-critique (2013-03-31) 3 commits
 - send-email: use the three-arg form of open in recipients_cmd
 - send-email: drop misleading function prototype
 - send-email: use "return;" not "return undef;" on error codepaths

 Broken down from an earlier discussion to pick up reasonable bits
 with explanation, to demonstrate how it should be done.

 Will merge to 'next'.


* tr/valgrind (2013-04-01) 4 commits
  (merged to 'next' on 2013-04-01 at a973c52)
 + tests: notice valgrind error in test_must_fail
 + tests --valgrind: provide a mode without --track-origins
 + tests: parameterize --valgrind option
 + t/README: --valgrind already implies -v

 Let us use not just memgrind but other *grind debuggers.

 Will merge to 'master'.


* mh/rev-parse-verify-doc (2013-04-01) 2 commits
 - SQUASH???
 - rev-parse: clarify documentation for the --verify option
 (this branch uses jc/sha1-name-object-peeler.)

 "rev-parse --verify" was documented in a misleading way.


* rs/submodule-summary-limit (2013-04-01) 1 commit
  (merged to 'next' on 2013-04-01 at 3c18cfe)
 + submodule summary: support --summary-limit=<n>

 "submodule summary --summary-limit" option did not support
 "--option=value" form.

 Will merge to 'master'.


* tb/shared-perm (2013-04-01) 2 commits
 - path.c: optimize adjust_shared_perm()
 - optimize set_shared_perm() in path.c:
 (this branch uses tb/cygwin-shared-repository.)

 Simplifies adjust_shared_perm() implementation.


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


* jl/submodule-deinit (2013-04-01) 1 commit
 - submodule deinit: clarify work tree removal message

 A finishing touch to the new topic in 1.8.3.

 Will merge to 'next'.

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

* js/log-gpg (2013-03-27) 1 commit
  (merged to 'next' on 2013-03-29 at 9a1b2d3)
 + log: read gpg settings for signed commit verification

 Teach "show/log" honor gpg.program configuration just like other
 parts of the code that use GnuPG.

 Will merge to 'master'.


* jc/t5516-pushInsteadOf-vs-pushURL (2013-03-28) 1 commit
  (merged to 'next' on 2013-04-01 at bed2879)
 + t5516: test interaction between pushURL and pushInsteadOf correctly

 Update a test to match the documented interaction between pushURL
 and pushInsteadOf.


* jk/merge-tree-added-identically (2013-03-27) 1 commit
 - merge-tree: fix "same file added in subdir"

 We would most likely want to change things the other way around.


* rr/triangle (2013-03-28) 6 commits
 - remote.c: introduce branch.<name>.pushremote
 - remote.c: introduce remote.pushdefault
 - remote.c: introduce a way to have different remotes for fetch/push
 - t5516 (fetch-push): drop implicit arguments from helper functions
 - t5516 (fetch-push): update test description
 - remote.c: simplify a bit of code using git_config_string()

 Support "pull from one place, push to another place" workflow
 better by introducing remote.pushdefault (overrides the "origin"
 thing) and branch.*.pushremote (overrides the branch.*.remote).

 Expecting a reroll.


* sg/gpg-sig (2013-03-31) 5 commits
 - pretty printing: extend %G? to include 'N' and 'U'
 - merge/pull Check for untrusted good GPG signatures
 - merge/pull: verify GPG signatures of commits being merged
 - commit.c/GPG signature verification: Also look at the first GPG status line
 - Move commit GPG signature verification to commit.c

 Teach "merge/pull" to optionally verify and reject commits that are
 not signed properly.


* tr/log-tree-optim (2013-03-28) 1 commit
  (merged to 'next' on 2013-03-29 at 5a6795d)
 + Avoid loading commits twice in log with diffs

 Optimize "log" that shows the difference between the parent and the
 child.

 Will merge to 'master'.


* jk/config-with-empty-section (2013-03-29) 1 commit
  (merged to 'next' on 2013-04-01 at 7972aa9)
 + t1300: document some aesthetic failures of the config editor

 Document that "git config --unset" does not remove an empty section
 head after removing the last variable in a section, and adding a
 new variable does not try to reuse a leftover empty section head.

 Will merge to 'master'.


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

 Will merge to 'master'.


* jc/apply-ws-fix-tab-in-indent (2013-03-29) 2 commits
  (merged to 'next' on 2013-03-29 at 26eb6e9)
 + test: resurrect q_to_tab
  (merged to 'next' on 2013-03-26 at 46c6bda)
 + apply --whitespace=fix: avoid running over the postimage buffer

 "git apply --whitespace=fix" was not prepared to see a line getting
 longer after fixing whitespaces (e.g. tab-in-indent aka Python).

 Will merge to 'master'.


* jk/no-more-self-assignment (2013-03-25) 2 commits
  (merged to 'next' on 2013-03-26 at 31ec9ac)
 + match-trees: simplify score_trees() using tree_entry()
 + submodule: clarify logic in show_submodule_summary

 This started as a topic to reduce "type var = var" self assignment
 tricks that were used to squelch "variable used uninitialized perhaps?"
 warning from some compilers, but resulted in rewriting logic with
 a version that is simpler and easier to understand for humans.

 Will merge to 'master'.


* ap/combine-diff-coalesce-lost (2013-03-25) 1 commit
  (merged to 'next' on 2013-03-29 at f6a05ca)
 + combine-diff: coalesce lost lines optimally

 Attempts to minimize "diff -c/--cc" output by coalescing the same
 lines removed from the parents better, but with an O(n^2)
 complexity.

 Will cook in 'next' to see if people with real-world usage scream.


* bk/document-commit-tree-S (2013-03-25) 1 commit
  (merged to 'next' on 2013-03-26 at 8ee205f)
 + commit-tree: document -S option consistently

 Will merge to 'master'.


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

 Will merge to 'master'.


* js/iterm-is-on-osx (2013-03-29) 1 commit
  (merged to 'next' on 2013-04-01 at 201fed2)
 + git-web--browse: recognize any TERM_PROGRAM as a GUI terminal on OS X

 Add more logic to detect graphic environment of OS X by simply
 checking TERM_PROGRAM has some value, not Apple_Terminal, to detect
 iTerm.app and any other.

 Will merge to 'master'.


* tb/cygwin-shared-repository (2013-03-25) 1 commit
  (merged to 'next' on 2013-03-29 at dbeb068)
 + Make core.sharedRepository work under cygwin 1.7
 (this branch is used by tb/shared-perm.)

 Cygwin port has a faster-but-lying lstat(2) emulation whose
 incorrectness does not matter in practice except for a few
 codepaths, and setting permission bits to directories is a codepath
 that needs to use a more correct one.

 Will merge to 'master'.


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

 Will merge to 'master'.


* nd/checkout-paths-reduce-match-pathspec-calls (2013-03-27) 1 commit
  (merged to 'next' on 2013-03-29 at fbcc004)
 + checkout: avoid unnecessary match_pathspec calls

 Consolidate repeated pathspec matches on the same paths, while
 fixing a bug in "git checkout dir/" code started from an unmerged
 index.

 Will merge to 'master'.


* jc/merge-tag-object (2013-04-01) 3 commits
 - t6200: test message for merging of an annotated tag
 - t6200: use test_config/test_unconfig
  (merged to 'next' on 2013-03-29 at aeec39c)
 + merge: a random object may not necssarily be a commit

 "git merge $(git rev-parse v1.8.2)" behaved quite differently from
 "git merge v1.8.2" as if v1.8.2 were written as v1.8.2^0 and did
 not pay much attention to the annotated tag payload.

 This makes the code notice the type of the tag object, in addition
 to the dwim_ref() based classification the current code uses
 (i.e. the name appears in refs/tags/) to decide when to special
 case merging of tags.

 Will merge to 'next'.


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


* jn/add-2.0-u-A-sans-pathspec (2013-04-01) 5 commits
 - git add: -u/-A now affects the entire working tree
 - add -A: only show pathless 'add -A' warning when changes exist outside cwd
 - add -u: only show pathless 'add -u' warning when changes exist outside cwd
 - add: make warn_pathless_add() a no-op after first call
 - add: make pathless 'add [-u|-A]' warning a file-global function

 Replaces jc/add-2.0-u-A-sans-pathspec topic by not warning against
 "add -u/-A" that is ran without pathspec when there is no change
 outside the current directory.

 Expecting a reroll and then merge the bottom bits to 'next'.
 $gmane/219342


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


* sw/safe-create-leading-dir-race (2013-03-26) 1 commit
  (merged to 'next' on 2013-03-26 at 744bb50)
 + safe_create_leading_directories: fix race that could give a false negative

 Will merge to 'master'.


* jc/add-2.0-delete-default (2013-03-08) 3 commits
 - git add <pathspec>... defaults to "-A"
 - git add: start preparing for "git add <pathspec>..." to default to "-A"
 - builtin/add.c: simplify boolean variables

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 There seemed to be some interest in this topic, so resurrected and
 rebased on top of recent documentation updates to propose a
 possible transition plan.

 Will cook in 'next' until Git 2.0.


* tr/line-log (2013-03-28) 5 commits
  (merged to 'next' on 2013-04-01 at 5be920c)
 + Speed up log -L... -M
 + log -L: :pattern:file syntax to find by funcname
 + Implement line-history search (git log -L)
 + Export rewrite_parents() for 'log -L'
 + Refactor parse_loc

 Will merge down to 'master' with warts and all, hoping they get
 fixed eventually in-tree.


* jc/push-2.0-default-to-simple (2013-03-18) 15 commits
 - advice: Remove unused advice_push_non_ff_default
 - t5570: do not assume the "matching" push is the default
 - t5551: do not assume the "matching" push is the default
 - t5550: do not assume the "matching" push is the default
 - doc: push.default is no longer "matching"
 - push: switch default from "matching" to "simple"
 - t9401: do not assume the "matching" push is the default
 - t9400: do not assume the "matching" push is the default
 - t7406: do not assume the "matching" push is the default
 - t5531: do not assume the "matching" push is the default
 - t5519: do not assume the "matching" push is the default
 - t5517: do not assume the "matching" push is the default
 - t5516: do not assume the "matching" push is the default
 - t5505: do not assume the "matching" push is the default
 - t5404: do not assume the "matching" push is the default

 Will cook in 'next' until Git 2.0.
