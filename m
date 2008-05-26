From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sun, 25 May 2008 18:22:17 -0700
Message-ID: <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 03:23:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0RQk-0001OR-Eq
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 03:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbYEZBW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 21:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbYEZBW0
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 21:22:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbYEZBWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 21:22:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F0742F7E;
	Sun, 25 May 2008 21:22:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 95B752F7A; Sun, 25 May 2008 21:22:19 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31707D4C-2AC2-11DD-9318-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82886>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

It's been a while since the last issue of this series.  I've been
swamped, and haven't had a chance to spend enough time on reviewing and
accepting patches.

A rough timeline from now on.

 * 1.5.6-rc0 has been tagged.  Expect a few minor breakages ;-)

 * Fixes of 'master' continues, with newer -rcX tagged every once in a
   while.

 * 1.5.6 Final (2008-06-08).

There are a few known breakages I want to see addressed that are not in
here before 1.5.6 (no not any new features but pure bugfixes).

----------------------------------------------------------------
[New Topics]

* sj/merge (Sat May 3 16:55:47 2008 -0700) 6 commits
 - Introduce fast forward option only
 - Head reduction before selecting merge strategy
 - Restructure git-merge.sh
 - Introduce -ff=<fast forward option>
 - New merge tests
 - Documentation for joining more than two histories

This will interfere with Miklos's rewrite of merge to C but it appears
neither will happen by 1.5.6 anyway.

* jc/diff-no-no-index (Fri May 23 22:28:56 2008 -0700) 3 commits
 + "git diff": do not ignore index without --no-index
 + diff-files: do not play --no-index games
 + tests: do not use implicit "git diff --no-index"

This was done in response to recently discovered interaction with stgit;
we were too eater to invoke --no-index behaviour without being asked.
Currently it even drops the behaviour when you ask to compare two paths
that are outside of git work tree if your current directory is inside it,
which I think could safely resurrect, and then the whole thing will be
ready for 1.5.6.

----------------------------------------------------------------
[Graduated to "master"]

* js/config-cb (Wed May 14 18:46:53 2008 +0100) 1 commit
 + Provide git_config with a callback-data parameter

* jc/apply-whitespace (Sat May 17 02:02:44 2008 -0700) 3 commits
 + builtin-apply: do not declare patch is creation when we do not
   know it
 + builtin-apply: accept patch to an empty file
 + builtin-apply: typofix

We were loose when parsing a patch that adds contents to an empty file.
This fix would be nice to have in 1.5.6.

* js/mailinfo (Fri May 16 14:03:30 2008 +0100) 3 commits
 + mailsplit: minor clean-up in read_line_with_nul()
 + mailinfo: apply the same fix not to lose NULs in BASE64 and QP
   codepaths
 + mailsplit and mailinfo: gracefully handle NUL characters

When "am" processes a patch that modifies a line with NUL, we used to
chomp the patch line there, resulting in rejects.  This patch fixes the
issue partially, only when the message is not encoded in BASE64 nor
Quoted-Printable.  I suspect its handling of a MIME attachment may still
wrong, but otherwise this should fix the breakage reported earlier.

* mo/cvsserver (Wed May 14 22:35:48 2008 -0600) 3 commits
 + git-cvsserver: add ability to guess -kb from contents
 + implement gitcvs.usecrlfattr
 + git-cvsserver: add mechanism for managing working tree and current
   directory

* js/cvsexportcommit (Wed May 14 15:29:49 2008 +0100) 2 commits
 + cvsexportcommit: introduce -W for shared working trees (between
   Git and CVS)
 + cvsexportcommit: chomp only removes trailing whitespace

CVS interoperability improvements.

* ar/t6031 (Sun May 18 16:57:27 2008 +0200) 1 commit
 + Fix t6031 on filesystems without working exec bit

* jc/unpack-trees-reword (Sat May 17 12:03:49 2008 -0700) 1 commit
 + unpack-trees: allow Porcelain to give different error messages

Makes safety message from "git checkout switch-to-this-branch" a bit
easier to read, and opens up the possibility to reword messages from other
commands that use unpack-trees machinery.

* jc/add-n-u (Wed May 21 12:04:34 2008 -0700) 1 commit
 + "git-add -n -u" should not add but just report

* js/ignore-submodule (Wed May 14 18:03:59 2008 +0100) 3 commits
 + Ignore dirty submodule states during rebase and stash
 + Teach update-index about --ignore-submodules
 + diff options: Introduce --ignore-submodules

* sp/ignorecase (Thu May 15 07:19:54 2008 +0200) 5 commits
 + t0050: Fix merge test on case sensitive file systems
 + t0050: Add test for case insensitive add
 + t0050: Set core.ignorecase case to activate case insensitivity
 + t0050: Test autodetect core.ignorecase
 + git-init: autodetect core.ignorecase

* bc/repack (Thu May 15 22:37:31 2008 -0400) 6 commits
 + Documentation/git-repack.txt: document new -A behaviour
 + let pack-objects do the writing of unreachable objects as loose
   objects
 + add a force_object_loose() function
 + builtin-gc.c: deprecate --prune, it now really has no effect
 + git-gc: always use -A when manually repacking
 + repack: modify behavior of -A option to leave unreferenced objects
   unpacked

* db/clone-in-c (Tue May 20 14:15:14 2008 -0400) 11 commits
 + clone: fall back to copying if hardlinking fails
 + builtin-clone.c: Need to closedir() in copy_or_link_directory()
 + builtin-clone: fix initial checkout
 + Build in clone
 + Provide API access to init_db()
 + Add a function to set a non-default work tree
 + Allow for having for_each_ref() list extra refs
 + Have a constant extern refspec for "--tags"
 + Add a library function to add an alternate to the alternates file
 + Add a lockfile function to append to a file
 + Mark the list of refs to fetch as const

* pb/push (Mon Apr 28 11:32:12 2008 -0400) 1 commit
 + add special "matching refs" refspec

This first patch is a good enhancement without hurting any existing users.
We need a staged introduction of the second and later patches, and many
people including me did not agree the later ones in the series are
desirable.

* ap/svn (Mon May 12 17:09:49 2008 -0700) 4 commits
 + git-svn: add test for --add-author-from and --use-log-author
 + git-svn: add documentation for --add-author-from option.
 + git-svn: Add --add-author-from option.
 + git-svn: add documentation for --use-log-author option.

Some tweak for output might be needed, but I'll leave that to actual
git-svn users.

* ar/batch-cat (Wed Apr 23 15:17:47 2008 -0400) 13 commits
 + change quoting in test t1006-cat-file.sh
 + builtin-cat-file.c: use parse_options()
 + git-svn: Speed up fetch
 + Git.pm: Add hash_and_insert_object and cat_blob
 + Git.pm: Add command_bidi_pipe and command_close_bidi_pipe
 + git-hash-object: Add --stdin-paths option
 + Add more tests for git hash-object
 + Move git-hash-object tests from t5303 to t1007
 + git-cat-file: Add --batch option
 + git-cat-file: Add --batch-check option
 + git-cat-file: Make option parsing a little more flexible
 + git-cat-file: Small refactor of cmd_cat_file
 + Add tests for git cat-file

The series is meant to speed up git-svn by avoiding many individual
invocations of git-cat-file, started by Adam Roben and finished by Michele
Ballabio.

----------------------------------------------------------------
[Stalled]

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 + "git push": tellme-more protocol extension

Allows common ancestor negotiation for git-push to help people with shared
repository workflow in certain minority situations.  The lack of protocol
support has been bugging me for quite some time, and that was the reason I
did this.

This needs debugging.

* jc/blame (Wed Apr 2 22:17:53 2008 -0700) 5 commits
 + git-blame --reverse
 + builtin-blame.c: allow more than 16 parents
 + builtin-blame.c: move prepare_final() into a separate function.
 + rev-list --children
 + revision traversal: --children option

The blame that finds where each line in the original lines moved to.  This
may help a GSoC project that wants to gather statistical overview of the
history.  The final presentation may need tweaking (see the log message of
the tip commit on the series).

* js/rebase-i-sequencer (Sun Apr 27 02:55:50 2008 -0400) 17 commits
 + Use perl instead of tac
 + Fix t3404 assumption that `wc -l` does not use whitespace.
 + rebase -i: Use : in expr command instead of match.
 + rebase -i: update the implementation of 'mark' command
 + Add option --preserve-tags
 + Teach rebase interactive the tag command
 + Add option --first-parent
 + Do rebase with preserve merges with advanced TODO list
 + Select all lines with fake-editor
 + Unify the length of $SHORT* and the commits in the TODO list
 + Teach rebase interactive the merge command
 + Move redo merge code in a function
 + Teach rebase interactive the reset command
 + Teach rebase interactive the mark command
 + Move cleanup code into it's own function
 + Don't append default merge message to -m message
 + fake-editor: output TODO list if unchanged

This may complement the proposed "sequencer" GSoC project.  Dscho seems to
have quite a strong objection to the 'mark' syntax and mechanism being
unnecessarily complex.  Let's wait and see if a less complex but equally
expressive alternative materializes...

----------------------------------------------------------------
[On Hold]

* dr/ceiling (Mon May 19 23:49:34 2008 -0700) 4 commits
 - Eliminate an unnecessary chdir("..")
 - Add support for GIT_CEILING_DIRECTORIES
 - Fold test-absolute-path into test-path-utils
 - Implement normalize_absolute_path

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will be
hit due to tcl/tk's limitation, so I am holding this back for now.

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 - merge: remove deprecated summary and diffstat options and config
   variables

This needs to be held back, as it actually removes the support for
features that the main part of the series deprecates, until 1.6.0 or
later.

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, but git-shell may need to be updated.

* jc/cherry-pick (Wed Feb 20 23:17:06 2008 -0800) 3 commits
 - WIP: rethink replay merge
 - Start using replay-tree merge in cherry-pick
 - revert/cherry-pick: start refactoring call to merge_recursive

This is meant to improve cherry-pick's behaviour when renames are
involved, by not using merge-recursive (whose d/f conflict resolution is
quite broken), but unfortunately has stalled for some time now.

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

Just my toy at this moment.

* jc/diff-words (Sun May 11 12:33:48 2008 -0700) 2 commits
 - diff --color-words: a bit of tweak
 - diff --color-words reimplementation

This series did not pan out well.  I briefly thought that perhaps I should
discard them and replace with the "not just whitespace" one from Ping Yin
first, hoping that we can clean the overall logic up later, but perhaps
the whole thing can get a fresh restart after 1.5.6.  I'll drop this
altogether the next round.
