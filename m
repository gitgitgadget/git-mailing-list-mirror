From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2009, #04; Mon, 19)
Date: Mon, 19 Jan 2009 01:13:30 -0800
Message-ID: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 10:15:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOqDn-000199-Ss
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 10:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbZASJNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 04:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbZASJNl
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 04:13:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028AbZASJNg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 04:13:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 393DD91AC3;
	Mon, 19 Jan 2009 04:13:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BCCDD91AC0; Mon,
 19 Jan 2009 04:13:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 732A322A-E609-11DD-BF01-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106335>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* jk/color-parse (Sat Jan 17 10:38:46 2009 -0500) 2 commits
 + expand --pretty=format color options
 + color: make it easier for non-config to parse color specs

* sb/hook-cleanup (Sat Jan 17 04:02:55 2009 +0100) 5 commits
 + run_hook(): allow more than 9 hook arguments
 + run_hook(): check the executability of the hook before filling
   argv
 + api-run-command.txt: talk about run_hook()
 + Move run_hook() from builtin-commit.c into run-command.c (libgit)
 + checkout: don't crash on file checkout before running post-
   checkout hook

* js/maint-all-implies-HEAD (Sat Jan 17 22:27:08 2009 -0800) 2 commits
 - bundle: allow the same ref to be given more than once
 - revision walker: include a detached HEAD in --all

* tr/previous-branch (Sat Jan 17 19:08:12 2009 +0100) 6 commits
 - Fix parsing of @{-1}@{1}
 - interpret_nth_last_branch(): avoid traversing the reflog twice
 - checkout: implement "-" abbreviation, add docs and tests
 - sha1_name: support @{-N} syntax in get_sha1()
 - sha1_name: tweak @{-N} lookup
 - checkout: implement "@{-N}" shortcut name for N-th last branch

* rs/ctype (Sat Jan 17 16:50:37 2009 +0100) 4 commits
 + Add is_regex_special()
 + Change NUL char handling of isspecial()
 + Reformat ctype.c
 + Add ctype test

* mh/unify-color (Sun Jan 18 21:39:12 2009 +0100) 2 commits
 - move the color variables to color.c
 - handle color.ui at a central place

* jf/am-failure-report (Sun Jan 18 19:34:31 2009 -0800) 2 commits
 + git-am: re-fix the diag message printing
 + git-am: Make it easier to see which patch failed

* cb/add-pathspec (Wed Jan 14 15:54:35 2009 +0100) 2 commits
 - remove pathspec_match, use match_pathspec instead
 - clean up pathspec matching

* sg/maint-gitdir-in-subdir (Fri Jan 16 16:37:33 2009 +0100) 1 commit
 + Fix gitdir detection when in subdir of gitdir

This has my "don't do the fullpath if you are directly inside .git"
squashed in, so it should be much safer.

* am/maint-push-doc (Sun Jan 18 15:36:58 2009 +0100) 4 commits
 + Documentation: avoid using undefined parameters
 + Documentation: mention branches rather than heads
 + Documentation: remove a redundant elaboration
 + Documentation: git push repository can also be a remote

* sp/runtime-prefix (Sun Jan 18 13:00:15 2009 +0100) 5 commits
 - Windows: Revert to default paths and convert them by
   RUNTIME_PREFIX
 - Modify setup_path() to only add git_exec_path() to PATH
 - Add calls to git_extract_argv0_path() in programs that call
   git_config_*
 - git_extract_argv0_path(): Move check for valid argv0 from caller
   to callee
 - Move computation of absolute paths from Makefile to runtime (in
   preparation for RUNTIME_PREFIX)

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

This gives Porcelains (like gitweb) the information on the commit _before_
the one that the final blame is laid on, which should save them one
rev-parse to dig further.  The line number in the "previous" information
may need refining, and sanity checking code for reference counting may
need to be resurrected before this can move forward.

* db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
 - Support fetching from foreign VCSes
 - Add specification of git-vcs helpers
 - Add "vcs" config option in remotes

The "spec" did not seem quite well cooked yet, but in the longer term I
think something like this to allow interoperating with other SCMs as if
the other end is a native git repository is a very worthy goal.

----------------------------------------------------------------
[Actively cooking]

* kb/lstat-cache (Sun Jan 18 16:14:54 2009 +0100) 5 commits
 + lstat_cache(): introduce clear_lstat_cache() function
 + lstat_cache(): introduce invalidate_lstat_cache() function
 + lstat_cache(): introduce has_dirs_only_path() function
 + lstat_cache(): introduce has_symlink_or_noent_leading_path()
   function
 + lstat_cache(): more cache effective symlink/directory detection

This is the tenth round, now in 'next'.

* lh/submodule-tree-traversal (Mon Jan 12 00:45:55 2009 +0100) 3 commits
 - builtin-ls-tree: enable traversal of submodules
 - archive.c: enable traversal of submodules
 - tree.c: add support for traversal of submodules

Still getting active reviews.

* lt/maint-wrap-zlib (Wed Jan 7 19:54:47 2009 -0800) 1 commit
 + Wrap inflate and other zlib routines for better error reporting

Needs the "free our memory upon seeing Z_MEM_ERROR and try again" bits
extracted from Shawn's patch on top of this one.

* jk/signal-cleanup (Sun Jan 11 06:36:49 2009 -0500) 3 commits
 - pager: do wait_for_pager on signal death
 - refactor signal handling for cleanup functions
 - chain kill signals for cleanup functions

Sorry, I lost track.  What is the status of this one?

* js/diff-color-words (Sat Jan 17 17:29:48 2009 +0100) 7 commits
 - color-words: make regex configurable via attributes
 - color-words: expand docs with precise semantics
 - color-words: enable REG_NEWLINE to help user
 - color-words: take an optional regular expression describing words
 - color-words: change algorithm to allow for 0-character word
   boundaries
 - color-words: refactor word splitting and use ALLOC_GROW()
 - Add color_fwrite_lines(), a function coloring each line
   individually

Dscho's series that was done in response to Thomas's original; two agreed
to work together on this codebase.

* ks/maint-mailinfo-folded (Tue Jan 13 01:21:04 2009 +0300) 5 commits
 - mailinfo: tests for RFC2047 examples
 - mailinfo: add explicit test for mails like '<a.u.thor@example.com>
   (A U Thor)'
 - mailinfo: more smarter removal of rfc822 comments from 'From'
 + mailinfo: 'From:' header should be unfold as well
 + mailinfo: correctly handle multiline 'Subject:' header

I think "more smarter" one is too aggressive for our purpose.  Perhaps not
removing comments at all would be what we want.

* js/patience-diff (Thu Jan 1 17:39:37 2009 +0100) 3 commits
 + bash completions: Add the --patience option
 + Introduce the diff option '--patience'
 + Implement the patience diff algorithm

* js/notes (Tue Jan 13 20:57:16 2009 +0100) 6 commits
 + git-notes: fix printing of multi-line notes
 + notes: fix core.notesRef documentation
 + Add an expensive test for git-notes
 + Speed up git notes lookup
 + Add a script to edit/inspect notes
 + Introduce commit notes

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

----------------------------------------------------------------
[Graduated to "master"]

* ds/uintmax-config (Mon Nov 3 09:14:28 2008 -0900) 1 commit
 + autoconf: Enable threaded delta search when pthreads are supported

See if anybody screams.

* gb/gitweb-opml (Fri Jan 2 13:49:30 2009 +0100) 2 commits
 + gitweb: suggest name for OPML view
 + gitweb: don't use pathinfo for global actions

* mv/apply-parse-opt (Fri Jan 9 22:21:36 2009 -0800) 2 commits
 + Resurrect "git apply --flags -" to read from the standard input
 + parse-opt: migrate builtin-apply.

* tr/rebase-root (Fri Jan 2 23:28:29 2009 +0100) 4 commits
 + rebase: update documentation for --root
 + rebase -i: learn to rebase root commit
 + rebase: learn to rebase root commit
 + rebase -i: execute hook only after argument checking

Looked reasonable.

* mh/maint-commit-color-status (Thu Jan 8 19:53:05 2009 +0100) 2 commits
 + git-status -v: color diff output when color.ui is set
 + git-commit: color status output when color.ui is set

* rs/maint-shortlog-foldline (Tue Jan 6 21:41:06 2009 +0100) 1 commit
 + shortlog: handle multi-line subjects like log --pretty=oneline et.
   al. do

* rs/fgrep (Sat Jan 10 00:18:34 2009 +0100) 2 commits
 + grep: don't call regexec() for fixed strings
 + grep -w: forward to next possible position after rejected match

* as/autocorrect-alias (Sun Jan 4 18:16:01 2009 +0100) 1 commit
 + git.c: make autocorrected aliases work

* tr/maint-no-index-fixes (Wed Jan 7 12:15:30 2009 +0100) 3 commits
 + diff --no-index -q: fix endless loop
 + diff --no-index: test for pager after option parsing
 + diff: accept -- when using --no-index

* jc/maint-format-patch (Sat Jan 10 12:41:33 2009 -0800) 1 commit
 + format-patch: show patch text for the root commit

* ap/clone-into-empty (Sun Jan 11 15:19:12 2009 +0300) 2 commits
 + Allow cloning to an existing empty directory
 + add is_dot_or_dotdot inline function

* gb/gitweb-patch (Thu Dec 18 08:13:19 2008 +0100) 4 commits
 + gitweb: link to patch(es) view in commit(diff) and (short)log view
 + gitweb: add patches view
 + gitweb: change call pattern for git_commitdiff
 + gitweb: add patch view

----------------------------------------------------------------
[Will merge to "master" soon]

* kb/am-directory (Wed Jan 14 16:29:59 2009 -0800) 2 commits
 + git-am: fix shell quoting
 + git-am: add --directory=<dir> option

This is "third-time-lucky, perhaps?" resurrection.  I do not think I'd be
using this very often, but it originated from a real user request.

* jc/maint-format-patch-o-relative (Mon Jan 12 15:18:02 2009 -0800) 1 commit
 + Teach format-patch to handle output directory relative to cwd

----------------------------------------------------------------
[On Hold]

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 . diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 . git-am --forge: add Signed-off-by: line for the author
 . git-am: clean-up Signed-off-by: lines
 . stripspace: add --log-clean option to clean up signed-off-by:
   lines
 . stripspace: use parse_options()
 . Add "git am -s" test
 . git-am: refactor code to add signed-off-by line for the committer

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 . revision --simplify-merges: incremental simplification
 . revision --simplify-merges: prepare for incremental simplification

* jk/valgrind (Thu Oct 23 04:30:45 2008 +0000) 2 commits
 . valgrind: ignore ldso errors
 . add valgrind support in test scripts

* wp/add-patch-find (Thu Nov 27 04:08:03 2008 +0000) 3 commits
 . In add --patch, Handle K,k,J,j slightly more gracefully.
 . Add / command in add --patch
 . git-add -i/-p: Change prompt separater from slash to comma

* jc/grafts (Wed Jul 2 17:14:12 2008 -0700) 1 commit
 . [BROKEN wrt shallow clones] Ignore graft during object transfer

* jc/replace (Fri Oct 31 09:21:39 2008 -0700) 1 commit
 . WIP
