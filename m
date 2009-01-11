From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2009, #02; Sun, 11)
Date: Sun, 11 Jan 2009 01:51:53 -0800
Message-ID: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 10:53:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLx0b-00045K-4A
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 10:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbZAKJwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 04:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbZAKJwD
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 04:52:03 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbZAKJv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 04:51:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC8C58F94D;
	Sun, 11 Jan 2009 04:51:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7553C8F94C; Sun,
 11 Jan 2009 04:51:55 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7C4AC990-DFC5-11DD-870F-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105157>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The ones marked with '.' do not appear in any of the branches,
but I am still holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* rs/fgrep (Sat Jan 10 00:18:34 2009 +0100) 2 commits
 + grep: don't call regexec() for fixed strings
 + grep -w: forward to next possible position after rejected match

* lt/zlib-wrap-xprm (Wed Jan 7 19:54:47 2009 -0800) 1 commit
 - Wrap inflateInit to retry allocation after releasing pack memory

Need to clean up the log message, perhaps rebase it to maint-1.6.0 and
start cooking in 'next'.

* jc/maint-format-patch (Sat Jan 10 12:41:33 2009 -0800) 1 commit
 + format-patch: show patch text for the root commit

* tr/maint-no-index-fixes (Wed Jan 7 12:15:30 2009 +0100) 3 commits
 + diff --no-index -q: fix endless loop
 + diff --no-index: test for pager after option parsing
 + diff: accept -- when using --no-index

* gb/gitweb-opml (Fri Jan 2 13:49:30 2009 +0100) 2 commits
 - gitweb: suggest name for OPML view
 - gitweb: don't use pathinfo for global actions

* mh/maint-commit-color-status (Thu Jan 8 19:53:05 2009 +0100) 2 commits
 - git-status -v: color diff output when color.ui is set
 - git-commit: color status output when color.ui is set

* ks/maint-mailinfo-folded (Thu Jan 8 01:43:42 2009 +0300) 1 commit
 - mailinfo: correctly handle multiline 'Subject:' header

* js/patience-diff (Thu Jan 1 17:39:37 2009 +0100) 3 commits
 - bash completions: Add the --patience option
 - Introduce the diff option '--patience'
 - Implement the patience diff algorithm

All of the above 'pu' topics are ready for 'next'.

* ap/clone-into-empty (Fri Jan 9 02:24:23 2009 +0300) 2 commits
 - Use is_pseudo_dir_name everywhere
 - Allow cloning to an existing empty directory

There is an updated patch that only refactors the repeated code to check
if a dirent is dot or dot-dot posted, which I should have picked up to
replace these but I haven't yet (the "clone into empty" can and should
build on top of it).

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* ds/uintmax-config (Mon Nov 3 09:14:28 2008 -0900) 1 commit
 - autoconf: Enable threaded delta search when pthreads are supported

This automatically enables threaded delta search code when autoconf
detects pthreads are usable.  I haven't heard neither positive nor
negative comments from minority platforms that might be harmed, but
this feels like the right thing to do, so perhaps the best course of
action is to merge this down to 'master' and see if anybody screams.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

This gives Porcelains (like gitweb) the information on the commit _before_
the one that the final blame is laid on, which should save them one
rev-parse to dig further.  The line number in the "previous" information
may need refining, and sanity checking code for reference counting may
need to be resurrected before this can move forward.

----------------------------------------------------------------
[Actively cooking]

* mv/apply-parse-opt (Fri Jan 9 22:21:36 2009 -0800) 2 commits
 + Resurrect "git apply --flags -" to read from the standard input
 + parse-opt: migrate builtin-apply.

* rs/maint-shortlog-foldline (Tue Jan 6 21:41:06 2009 +0100) 1 commit
 + shortlog: handle multi-line subjects like log --pretty=oneline et.
   al. do

* tr/rebase-root (Fri Jan 2 23:28:29 2009 +0100) 4 commits
 - rebase: update documentation for --root
 - rebase -i: learn to rebase root commit
 - rebase: learn to rebase root commit
 - rebase -i: execute hook only after argument checking

I should be able to find time to read this over again and merge to
'next' sometime this week.

* as/autocorrect-alias (Sun Jan 4 18:16:01 2009 +0100) 1 commit
 + git.c: make autocorrected aliases work

* js/notes (Sat Dec 20 13:06:03 2008 +0100) 4 commits
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

* gb/gitweb-patch (Thu Dec 18 08:13:19 2008 +0100) 4 commits
 - gitweb: link to patch(es) view in commit(diff) and (short)log view
 - gitweb: add patches view
 - gitweb: change call pattern for git_commitdiff
 - gitweb: add patch view

----------------------------------------------------------------
[Graduated to "master"]

* mh/maint-sendmail-cc-doc (Mon Dec 29 00:37:25 2008 +0100) 1 commit
 + doc/git-send-email: mention sendemail.cc config variable

* rs/diff-ihc (Sun Dec 28 19:45:32 2008 +0100) 1 commit
 + diff: add option to show context between close hunks

* js/maint-merge-recursive-r-d-conflict (Mon Dec 22 23:10:20 2008 +0100) 1 commit
 + merge-recursive: mark rename/delete conflict as unmerged

* mk/gitweb-feature (Mon Dec 15 22:16:19 2008 -0800) 1 commit
 + gitweb: unify boolean feature subroutines

* cb/merge-recursive-fix (Mon Dec 15 02:41:24 2008 -0800) 3 commits
 + Merge branch 'cb/maint-merge-recursive-fix' into cb/merge-
   recursive-fix
 + merge-recursive: do not clobber untracked working tree garbage
 + modify/delete conflict resolution overwrites untracked file

* cb/maint-merge-recursive-fix (Sun Dec 14 19:40:09 2008 -0800) 2 commits
 + merge-recursive: do not clobber untracked working tree garbage
 + modify/delete conflict resolution overwrites untracked file

* wp/add-p-goto (Thu Dec 4 10:22:40 2008 +0000) 2 commits
 + Add 'g' command to go to a hunk
 + Add subroutine to display one-line summary of hunks

* jn/gitweb-blame (Thu Dec 11 01:33:29 2008 +0100) 3 commits
 + gitweb: cache $parent_commit info in git_blame()
 + gitweb: A bit of code cleanup in git_blame()
 + gitweb: Move 'lineno' id from link to row element in git_blame

* mv/um-pdf (Wed Dec 10 23:44:50 2008 +0100) 1 commit
 + Add support for a pdf version of the user manual

* kk/maint-http-push (Tue Dec 23 11:31:15 2008 +0300) 1 commit
 + http-push: support full URI in handle_remote_ls_ctx()

----------------------------------------------------------------
[Will merge to "master" soon]

* nd/grep-assume-unchanged (Sat Dec 27 15:21:03 2008 +0700) 2 commits
 + grep: grep cache entries if they are "assume unchanged"
 + grep: support --no-ext-grep to test builtin grep

* as/maint-shortlog-cleanup (Tue Dec 30 22:01:44 2008 +0100) 1 commit
 + builtin-shortlog.c: use string_list_append(), and don't strdup
   unnecessarily

* jc/maint-ls-tree (Wed Dec 31 19:00:50 2008 +0900) 2 commits
 + Document git-ls-tree --full-tree
 + ls-tree: add --full-tree option

* js/bundle-tags (Fri Jan 2 19:08:46 2009 +0100) 1 commit
 + bundle: allow rev-list options to exclude annotated tags

* js/add-not-submodule (Fri Jan 2 19:08:40 2009 +0100) 1 commit
 + git add: do not add files from a submodule

* pb/maint-git-pm-false-dir (Mon Dec 29 01:25:00 2008 +0100) 1 commit
 + Git.pm: correctly handle directory name that evaluates to "false"

* pj/maint-ldflags (Sun Jan 4 21:27:41 2009 -0500) 1 commit
 + configure clobbers LDFLAGS

* fe/cvsserver (Fri Jan 2 16:40:14 2009 +0100) 2 commits
 + cvsserver: change generation of CVS author names
 + cvsserver: add option to configure commit message

* js/maint-bisect-gitk (Fri Jan 2 19:08:00 2009 +0100) 1 commit
 + bisect view: call gitk if Cygwin's SESSIONNAME variable is set

* np/no-loosen-prune-expire-now (Tue Dec 30 14:45:11 2008 -0500) 1 commit
 + objects to be pruned immediately don't have to be loosened

* cb/maint-unpack-trees-absense (Thu Jan 1 21:54:33 2009 +0100) 3 commits
 + unpack-trees: remove redundant path search in verify_absent
 + unpack-trees: fix path search bug in verify_absent
 + unpack-trees: handle failure in verify_absent

* mc/cd-p-pwd (Tue Dec 30 07:10:24 2008 -0800) 1 commit
 + git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on
   OS X

* mh/cherry-default (Thu Jan 1 22:56:29 2009 +0100) 2 commits
 + Documentation: clarify which parameters are optional to git-cherry
 + git-cherry: make <upstream> parameter optional

----------------------------------------------------------------
[Will drop]

* as/commit-signoff (Mon Dec 29 12:16:45 2008 +0100) 1 commit
 - [WIP] Add a commit.signoff configuration option to always use --
   signoff in commit

The semantics when "git commit" was used as a backend for other actions
such as rebase and cherry-pick was unclear.

----------------------------------------------------------------
[On Hold]

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use,
but gitk will be hit due to tcl/tk's limitation, so I am holding
this back for now.

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer
