From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.5
Date: Tue, 08 Apr 2008 23:51:00 -0700
Message-ID: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 08:52:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjUA7-0002WU-1A
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 08:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbYDIGvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 02:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbYDIGvR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 02:51:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbYDIGvP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 02:51:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 52AFB13603;
	Wed,  9 Apr 2008 02:51:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DE80913602; Wed,  9 Apr 2008 02:51:07 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79081>

The latest feature release GIT 1.5.5 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.5.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.5.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.5-1.$arch.rpm	(RPM)

We kept this cycle just slightly over two months, as the previous 1.5.4
cycle was painfully tooooo long.


GIT v1.5.5 Release Notes
========================

Updates since v1.5.4
--------------------

(subsystems)

 * Comes with git-gui 0.10.1

(portability)

 * We shouldn't ask for BSD group ownership semantics by setting g+s bit
   on directories on older BSD systems that refuses chmod() by non root
   users.  BSD semantics is the default there anyway.

 * Bunch of portability improvement patches coming from an effort to port
   to Solaris has been applied.

(performance)

 * On platforms with suboptimal qsort(3) implementation, there
   is an option to use more reasonable substitute we ship with
   our software.

 * New configuration variable "pack.packsizelimit" can be used
   in place of command line option --max-pack-size.

 * "git fetch" over the native git protocol used to make a
   connection to find out the set of current remote refs and
   another to actually download the pack data.  We now use only
   one connection for these tasks.

 * "git commit" does not run lstat(2) more than necessary
   anymore.

(usability, bells and whistles)

 * Bash completion script (in contrib) are aware of more commands and
   options.

 * You can be warned when core.autocrlf conversion is applied in
   such a way that results in an irreversible conversion.

 * A catch-all "color.ui" configuration variable can be used to
   enable coloring of all color-capable commands, instead of
   individual ones such as "color.status" and "color.branch".

 * The commands refused to take absolute pathnames where they
   require pathnames relative to the work tree or the current
   subdirectory.  They now can take absolute pathnames in such a
   case as long as the pathnames do not refer outside of the
   work tree.  E.g. "git add $(pwd)/foo" now works.

 * Error messages used to be sent to stderr, only to get hidden,
   when $PAGER was in use.  They now are sent to stdout along
   with the command output to be shown in the $PAGER.

 * A pattern "foo/" in .gitignore file now matches a directory
   "foo".  Pattern "foo" also matches as before.

 * bash completion's prompt helper function can talk about
   operation in-progress (e.g. merge, rebase, etc.).

 * Configuration variables "url.<usethis>.insteadof = <otherurl>" can be
   used to tell "git-fetch" and "git-push" to use different URL than what
   is given from the command line.

 * "git add -i" behaves better even before you make an initial commit.

 * "git am" refused to run from a subdirectory without a good reason.

 * After "git apply --whitespace=fix" fixes whitespace errors in a patch,
   a line before the fix can appear as a context or preimage line in a
   later patch, causing the patch not to apply.  The command now knows to
   see through whitespace fixes done to context lines to successfully
   apply such a patch series.

 * "git branch" (and "git checkout -b") to branch from a local branch can
   optionally set "branch.<name>.merge" to mark the new branch to build on
   the other local branch, when "branch.autosetupmerge" is set to
   "always", or when passing the command line option "--track" (this option
   was ignored when branching from local branches).  By default, this does
   not happen when branching from a local branch.

 * "git checkout" to switch to a branch that has "branch.<name>.merge" set
   (i.e. marked to build on another branch) reports how much the branch
   and the other branch diverged.

 * When "git checkout" has to update a lot of paths, it used to be silent
   for 4 seconds before it showed any progress report.  It is now a bit
   more impatient and starts showing progress report early.

 * "git commit" learned a new hook "prepare-commit-msg" that can
   inspect what is going to be committed and prepare the commit
   log message template to be edited.

 * "git cvsimport" can now take more than one -M options.

 * "git describe" learned to limit the tags to be used for
   naming with --match option.

 * "git describe --contains" now barfs when the named commit
   cannot be described.

 * "git describe --exact-match" describes only commits that are tagged.

 * "git describe --long" describes a tagged commit as $tag-0-$sha1,
   instead of just showing the exact tagname.

 * "git describe" warns when using a tag whose name and path contradict
   with each other.

 * "git diff" learned "--relative" option to limit and output paths
   relative to the current directory when working in a subdirectory.

 * "git diff" learned "--dirstat" option to show birds-eye-summary of
   changes more concisely than "--diffstat".

 * "git format-patch" learned --cover-letter option to generate a cover
   letter template.

 * "git gc" learned --quiet option.

 * "git gc" now automatically prunes unreachable objects that are two
   weeks old or older.

 * "git gc --auto" can be disabled more easily by just setting gc.auto
   to zero.  It also tolerates more packfiles by default.

 * "git grep" now knows "--name-only" is a synonym for the "-l" option.

 * "git help <alias>" now reports "'git <alias>' is alias to <what>",
   instead of saying "No manual entry for git-<alias>".

 * "git help" can use different backends to show manual pages and this can
   be configured using "man.viewer" configuration.

 * "gitk" does not restore window position from $HOME/.gitk anymore (it
   still restores the size).

 * "git log --grep=<what>" learned "--fixed-strings" option to look for
   <what> without treating it as a regular expression.

 * "git gui" learned an auto-spell checking.

 * "git push <somewhere> HEAD" and "git push <somewhere> +HEAD" works as
   expected; they push the current branch (and only the current branch).
   In addition, HEAD can be written as the value of "remote.<there>.push"
   configuration variable.

 * When the configuration variable "pack.threads" is set to 0, "git
   repack" auto detects the number of CPUs and uses that many threads.

 * "git send-email" learned to prompt for passwords
   interactively.

 * "git send-email" learned an easier way to suppress CC
   recipients.

 * "git stash" learned "pop" command, that applies the latest stash and
   removes it from the stash, and "drop" command to discard the named
   stash entry.

 * "git submodule" learned a new subcommand "summary" to show the
   symmetric difference between the HEAD version and the work tree version
   of the submodule commits.

 * Various "git cvsimport", "git cvsexportcommit", "git cvsserver",
   "git svn" and "git p4" improvements.

(internal)

 * Duplicated code between git-help and git-instaweb that
   launches user's preferred browser has been refactored.

 * It is now easier to write test scripts that records known
   breakages.

 * "git checkout" is rewritten in C.

 * "git remote" is rewritten in C.

 * Two conflict hunks that are separated by a very short span of common
   lines are now coalesced into one larger hunk, to make the result easier
   to read.

 * Run-command API's use of file descriptors is documented clearer and
   is more consistent now.

 * diff output can be sent to FILE * that is different from stdout.  This
   will help reimplementing more things in C.

Fixes since v1.5.4
------------------

All of the fixes in v1.5.4 maintenance series are included in
this release, unless otherwise noted.

 * "git-http-push" did not allow deletion of remote ref with the usual
   "push <remote> :<branch>" syntax.

 * "git-rebase --abort" did not go back to the right location if
   "git-reset" was run during the "git-rebase" session.

 * "git imap-send" without setting imap.host did not error out but
   segfaulted.
