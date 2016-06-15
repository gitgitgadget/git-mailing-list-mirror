From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2009, #02; Mon, 07)
Date: Mon, 07 Sep 2009 17:56:53 -0700
Message-ID: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 02:57:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkp1D-0000Cq-Kg
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 02:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbZIHA47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 20:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbZIHA47
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 20:56:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbZIHA45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 20:56:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BF8F2959E;
	Mon,  7 Sep 2009 20:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=2wOZ
	P6/9aSLUtOdJD9eYa466gRg=; b=dNsv/XVGjMQZBm3tgV4p8U5E7S9h/PxFnQCn
	JMLmG5k7Wox3YpEfLucOh5iGZGPJ0c3MCzw3Lyuc9ssr2jDNeJv/XRpDqKjgTXKa
	DqOtc+u3xBM/xKo6/b4t4PZynBtCuSkbVliXS1wm8cuNznEnG5b1q71JW8IL1h//
	fHs4Vqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=TBn
	mM2NudkSNTmhn+aHHNLZCsKou3qqWQksWs7QG/EFh3srVhkjO3gFM8kBC82V4Pdk
	u09QBSARrp/nmrbDiWUPP5ZbUgwJZ9hpKZCeLpn32zEdZgUkIBLdaW/m73C87yi8
	Mtgu5SRo1empEPoUbONLy/iTIsxAWc27Hr+nBzNc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A49F2959C;
	Mon,  7 Sep 2009 20:56:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7304E2959A; Mon,  7 Sep
 2009 20:56:54 -0400 (EDT)
X-master-at: 5ad9dce7e691106fecde413de8cc321b937367a6
X-next-at: 5f6b0ffff13f5cd762d0a5a4e1c4dede58e8a537
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 82327E3E-9C12-11DE-AB05-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127949>

What's cooking in git.git (Sep 2009, #02; Mon, 07)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

In 1.7.0, we plan to correct handful of warts in the interfaces everybody
agrees that they were mistakes.  The resulting system may not be strictly
backward compatible.  Currently planeed changes are:

 * refuse push to update the checked out branch in a non-bare repo by
   default

   Make "git push" into a repository to update the branch that is checked
   out fail by default.  You can countermand this default by setting a
   configuration variable in the receiving repository.

   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

 * refuse push to delete the current branch by default

   Make "git push $there :$killed" to delete the branch that is pointed at
   by its HEAD fail by default.  You can countermand this default by
   setting a configuration variable in the receiving repository.

   http://thread.gmane.org/gmane.comp.version-control.git/108862/focus=108936

 * git-send-email won't make deep threads by default

   Many people said that by default when sending more than 2 patches the
   threading git-send-email makes by default is hard to read, and they
   prefer the default be one cover letter and each patch as a direct
   follow-up to the cover letter.  You can countermand this by setting a
   configuration variable.

   http://article.gmane.org/gmane.comp.version-control.git/109790

 * git-status won't be "git-commit --dry-run" anymore

   http://thread.gmane.org/gmane.comp.version-control.git/125989/focus=125993

 * "git-diff -w --exit-code" will exit success if only differences it
   found are whitespace changes that are stripped away from the output.

   http://thread.gmane.org/gmane.comp.version-control.git/119731/focus=119751

During 1.6.5 cycle, 'next' will hold topics meant for 1.6.5 and 1.7.0.

I tagged and pushed out 1.6.5-rc0.  There are still some topics cooking in
'next' I would rather not leave out, but I've been hoping to keep this
cycle short, and I'm also hoping to tag the real 1.6.5 before I vanish for
about a week and half later in the month. so in the worst case there may
have to be a 1.6.6 to include the leftover topics.

--------------------------------------------------
[Graduated to "master"]

* np/maint-1.6.3-deepen (2009-09-03) 2 commits
  (merged to 'next' on 2009-09-06 at d597fba)
 + pack-objects: free preferred base memory after usage
 + make shallow repository deepening more network efficient

Further optimization and fixing of the object transfer around the "shallow
repository" codepaths.

* js/stash-dwim (2009-07-27) 1 commit.
  (merged to 'next' on 2009-08-16 at 67896c4)
 + Make 'git stash -k' a short form for 'git stash save --keep-index'
 (this branch is used by tr/reset-checkout-patch.)

* tr/reset-checkout-patch (2009-08-18) 10 commits.
  (merged to 'next' on 2009-09-03 at d4f2ed7)
 + stash: simplify defaulting to "save" and reject unknown options
  (merged to 'next' on 2009-08-27 at d314281)
 + Make test case number unique
  (merged to 'next' on 2009-08-18 at e465bb3)
 + tests: disable interactive hunk selection tests if perl is not available
  (merged to 'next' on 2009-08-16 at 67896c4)
 + DWIM 'git stash save -p' for 'git stash -p'
 + Implement 'git stash save --patch'
 + Implement 'git checkout --patch'
 + Implement 'git reset --patch'
 + builtin-add: refactor the meat of interactive_add()
 + Add a small patch-mode testing library
 + git-apply--interactive: Refactor patch mode code
 (this branch uses js/stash-dwim.)

DWIMmery of the two series tightened for safety a few days ago.  Otherwise
the same as what have been cooking in 'next' for a few weeks.

* jc/upload-pack-hook (2009-08-28) 2 commits
  (merged to 'next' on 2009-08-31 at f9933a5)
 + upload-pack: feed "kind [clone|fetch]" to post-upload-pack hook
 + upload-pack: add a trigger for post-upload-pack hook

* jk/clone-b (2009-08-26) 1 commit
  (merged to 'next' on 2009-08-30 at 10a68d1)
 + clone: add --branch option to select a different HEAD

* jc/mailinfo-scissors (2009-08-26) 5 commits
  (merged to 'next' on 2009-08-30 at 5fc6248)
 + mailinfo.scissors: new configuration
 + am/mailinfo: Disable scissors processing by default
 + Documentation: describe the scissors mark support of "git am"
 + Teach mailinfo to ignore everything before -- >8 -- mark
 + builtin-mailinfo.c: fix confusing internal API to mailinfo()

I didn't pick up the patch to simplify the definition of scissors. I do
not have strong opinion on it either way, and nobody on the list seemed to
care too much either.

--------------------------------------------------
[New Topics]

* cb/maint-1.6.3-grep-relative-up (2009-09-05) 2 commits.
  (merged to 'next' on 2009-09-07 at f9b5b48)
 + grep: accept relative paths outside current working directory
 + grep: fix exit status if external_grep() punts

1.6.5 material.

* jk/1.7.0-status (2009-09-05) 5 commits
 - docs: note that status configuration affects only long format
  (merged to 'next' on 2009-09-07 at 8a7c563)
 + commit: support alternate status formats
 + status: add --porcelain output format
 + status: refactor format option parsing
 + status: refactor short-mode printing to its own function
 (this branch uses jc/1.7.0-status.)

Gives the --short output format to post 1.7.0 "git commit --dry-run" that
is similar to that of post 1.7.0 "git status".

It might be a good idea to make the --short format part of 1.6.6 without
waiting for 1.7.0; it would require some branch shuffling to bring the
short-status patch earlier than the one that makes "status" different from
"commit --dry-run", though.

* jk/unwanted-advices (2009-09-06) 2 commits
 - status: make "how to stage" messages optional
 - push: make non-fast-forward help message configurable

Post 1.3.0 "newbie friendliness drive" introduced a lot of "helpful"
advice messages that are sometimes found to be irritating once the user
got used to working with git.  This series introduces a general mechanism
to allow us to make them less loud using the config mechanism.  The config
option hierarchy in these two are "message.*" but it is planned to be
renamed to "advice.*".

* jn/gitweb-show-size (2009-09-07) 1 commit
 - gitweb: Add 'show-sizes' feature to show blob sizes in tree view

* jt/pushinsteadof (2009-09-07) 2 commits
 - Add url.<base>.pushInsteadOf: URL rewriting for push only
 - Wrap rewrite globals in a struct in preparation for adding another set

Probably 1.6.5 material.

* lt/maint-traverse-trees-fix (2009-09-06) 1 commit.
 - Prepare 'traverse_trees()' for D/F conflict lookahead

Beginning of the fix to a rather nasty longstanding issue of merging trees
with ("a" "a-b"), ("a/b" "a-b") and just ("a-b").

* ne/rev-cache (2009-09-07) 7 commits
 . support for commit grafts, slight change to general mechanism
 . support for path name caching in rev-cache
 . full integration of rev-cache into git, completed test suite
 . administrative functions for rev-cache, start of integration into git
 . support for non-commit object caching in rev-cache
 . basic revision cache system, no integration or features
 . man page and technical discussion for rev-cache

Replaced but I do not think this is ready for 'pu' yet.

--------------------------------------------------
[Stalled]

* jh/notes (2009-08-27) 12 commits.
 - Add '%N'-format for pretty-printing commit notes
 - Add flags to get_commit_notes() to control the format of the note string
 - notes.c: Implement simple memory pooling of leaf nodes
 - Selftests verifying semantics when loading notes trees with various fanouts
 - Teach the notes lookup code to parse notes trees with various fanout schemes
 - t3302-notes-index-expensive: Speed up create_repo()
 - fast-import: Add support for importing commit notes
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

I heard the cvs-helper series depends on this one.  It seems that the
fan-out strategy is being rethought?

* je/send-email-no-subject (2009-08-05) 1 commit
  (merged to 'next' on 2009-08-30 at b6455c2)
 + send-email: confirm on empty mail subjects

The existing tests to covers the positive case (i.e. as long as the user
says "yes" to the "do you really want to send this message that lacks
subject", the message is sent) of this feature, but the feature itself
needs its own test to verify the negative case (i.e. does it correctly
stop if the user says "no"?)

* db/vcs-helper (2009-09-03) 16 commits
 - Allow helpers to report in "list" command that the ref is unchanged
 - Add support for "import" helper command
 - Add a config option for remotes to specify a foreign vcs
 - Allow programs to not depend on remotes having urls
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 - Use a clearer style to issue commands to remote helpers
 - Make the "traditionally-supported" URLs a special case
  (merged to 'next' on 2009-08-07 at f3533ba)
 + Makefile: install hardlinks for git-remote-<scheme> supported by libcurl if possible
 + Makefile: do not link three copies of git-remote-* programs
 + Makefile: git-http-fetch does not need expat
  (merged to 'next' on 2009-08-06 at 15da79d)
 + http-fetch: Fix Makefile dependancies
 + Add transport native helper executables to .gitignore
  (merged to 'next' on 2009-08-05 at 33d491e)
 + git-http-fetch: not a builtin
 + Use an external program to implement fetching with curl
 + Add support for external programs for handling native fetches
 (this branch is used by jh/cvs-helper.)

I'd really want to have this in 1.6.5 so that we can eject -lcurl from the
main "git" binary.  The patches in 'pu' got some review comments, and I
thought Daniel's responses were sensible.  Comments?

* jh/cvs-helper (2009-08-18) 8 commits
 - More fixes to the git-remote-cvs installation procedure
 - Fix the Makefile-generated path to the git_remote_cvs package in git-remote-cvs
 - Add simple selftests of git-remote-cvs functionality
 - git-remote-cvs: Remote helper program for CVS repositories
 - 2/2: Add Python support library for CVS remote helper
 - 1/2: Add Python support library for CVS remote helper
 - Basic build infrastructure for Python scripts
 - Allow helpers to request marks for fast-import
 (this branch uses db/vcs-helper.)

Builds on db/vcs-helper.  There is a re-roll planned.

* cc/sequencer-rebase-i (2009-08-28) 15 commits
 - rebase -i: use "git sequencer--helper --cherry-pick"
 - sequencer: add "--cherry-pick" option to "git sequencer--helper"
 - sequencer: add "do_commit()" and related functions working on "next_commit"
 - pick: libify "pick_help_msg()"
 - revert: libify cherry-pick and revert functionnality
 - rebase -i: use "git sequencer--helper --fast-forward"
 - sequencer: let "git sequencer--helper" callers set "allow_dirty"
 - sequencer: add "--fast-forward" option to "git sequencer--helper"
 - sequencer: add "do_fast_forward()" to perform a fast forward
 - rebase -i: use "git sequencer--helper --reset-hard"
 - sequencer: add "--reset-hard" option to "git sequencer--helper"
 - sequencer: add "reset_almost_hard()" and related functions
 - rebase -i: use "git sequencer--helper --make-patch"
 - sequencer: add "make_patch" function to save a patch
 - sequencer: add "builtin-sequencer--helper.c"

Migrating "rebase -i" bit by bit to C.
Not a 1.6.5 material yet.

--------------------------------------------------
[Cooking]

* pk/fast-import-tars (2009-09-03) 1 commit
  (merged to 'next' on 2009-09-07 at 8fbf027)
 + import-tars: Allow per-tar author and commit message.

* jc/maint-1.6.0-blank-at-eof (2009-09-05) 10 commits.
  (merged to 'next' on 2009-09-07 at 165dc3c)
 + core.whitespace: split trailing-space into blank-at-{eol,eof}
 + diff --color: color blank-at-eof
 + diff --whitespace=warn/error: fix blank-at-eof check
 + diff --whitespace=warn/error: obey blank-at-eof
 + diff.c: the builtin_diff() deals with only two-file comparison
 + apply --whitespace: warn blank but not necessarily empty lines at EOF
 + apply --whitespace=warn/error: diagnose blank at EOF
 + apply.c: split check_whitespace() into two
 + apply --whitespace=fix: detect new blank lines at eof correctly
 + apply --whitespace=fix: fix handling of blank lines at the eof

Hopefully in 1.6.5

* pk/fast-import-dirs (2009-09-03) 1 commit
  (merged to 'next' on 2009-09-07 at 836cba2)
 + Add script for importing bits-and-pieces to Git.

With an updated key-value quoting rules, which I haven't carefully looked
at.  I have to wonder if there are standard libraries to do this sort of
thing without having to hand-roll these logic every time.  But perhaps I
shouldn't be too picky on contrib/ material.

* jn/gitweb-blame (2009-09-01) 5 commits
 - gitweb: Minify gitweb.js if JSMIN is defined
 - gitweb: Create links leading to 'blame_incremental' using JavaScript
  (merged to 'next' on 2009-09-07 at 3622199)
 + gitweb: Colorize 'blame_incremental' view during processing
 + gitweb: Incremental blame (using JavaScript)
 + gitweb: Add optional "time to generate page" info in footer

Ajax-y blame.

* sr/gfi-options (2009-09-06) 6 commits
  (merged to 'next' on 2009-09-07 at 5f6b0ff)
 + fast-import: test the new option command
 + fast-import: add option command
 + fast-import: test the new feature command
 + fast-import: add feature command
 + fast-import: put marks reading in it's own function
 + fast-import: put option parsing code in separate functions

Perhaps 1.6.5 material but I wasn't sure.

* nd/sparse (2009-08-20) 19 commits
 - sparse checkout: inhibit empty worktree
 - Add tests for sparse checkout
 - read-tree: add --no-sparse-checkout to disable sparse checkout support
 - unpack-trees(): ignore worktree check outside checkout area
 - unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
 - unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
 - unpack-trees.c: generalize verify_* functions
 - unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
 - Introduce "sparse checkout"
 - dir.c: export excluded_1() and add_excludes_from_file_1()
 - excluded_1(): support exclude files in index
 - unpack-trees(): carry skip-worktree bit over in merged_entry()
 - Read .gitignore from index if it is skip-worktree
 - Avoid writing to buffer in add_excludes_from_file_1()
 - Teach Git to respect skip-worktree bit (writing part)
 - Teach Git to respect skip-worktree bit (reading part)
 - Introduce "skip-worktree" bit in index, teach Git to get/set this bit
 - Add test-index-version
 - update-index: refactor mark_valid() in preparation for new options

--------------------------------------------------
[For 1.7.0]

* jc/1.7.0-status (2009-09-05) 4 commits
  (merged to 'next' on 2009-09-06 at 19d4beb)
 + status: typo fix in usage
  (merged to 'next' on 2009-08-22 at b3507bb)
 + git status: not "commit --dry-run" anymore
 + git stat -s: short status output
 + git stat: the beginning of "status that is not a dry-run of commit"
 (this branch is used by jk/1.7.0-status.)

With this, "git status" is no longer "git commit --dry-run".

* jc/1.7.0-send-email-no-thread-default (2009-08-22) 1 commit
  (merged to 'next' on 2009-08-22 at 5106de8)
 + send-email: make --no-chain-reply-to the default

* jc/1.7.0-diff-whitespace-only-status (2009-08-30) 4 commits.
  (merged to 'next' on 2009-08-30 at 0623572)
 + diff.c: fix typoes in comments
  (merged to 'next' on 2009-08-27 at 81fb2bd)
 + Make test case number unique
  (merged to 'next' on 2009-08-02 at 9c08420)
 + diff: Rename QUIET internal option to QUICK
 + diff: change semantics of "ignore whitespace" options

This changes exit code from "git diff --ignore-whitespace" and friends
when there is no actual output.  It is a backward incompatible change, but
we could argue that it is a bugfix.

* jc/1.7.0-push-safety (2009-02-09) 2 commits
  (merged to 'next' on 2009-08-02 at 38b82fe)
 + Refuse deleting the current branch via push
 + Refuse updating the current branch in a non-bare repository via push

--------------------------------------------------
[I have been too busy to purge these]

* jc/log-tz (2009-03-03) 1 commit.
 - Allow --date=local --date=other-format to work as expected

Maybe some people care about this.  I dunno.

* jc/mailinfo-remove-brackets (2009-07-15) 1 commit.
 - mailinfo: -b option keeps [bracketed] strings that is not a [PATCH] marker

Maybe some people care about this.  I dunno.

* lt/read-directory (2009-05-15) 3 commits.
 . Add initial support for pathname conversion to UTF-8
 . read_directory(): infrastructure for pathname character set conversion
 . Add 'fill_directory()' helper function for directory traversal
