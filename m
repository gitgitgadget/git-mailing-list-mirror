From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sun, 25 Jun 2006 02:37:15 -0700
Message-ID: <7v7j35wp84.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Jun 25 11:37:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuR3R-0000VR-ET
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 11:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWFYJhS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 25 Jun 2006 05:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWFYJhS
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 05:37:18 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:11215 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932177AbWFYJhQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 05:37:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625093716.QSOD11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Jun 2006 05:37:16 -0400
To: git@vger.kernel.org
X-maint-at: be0c7e069738fbb697b0719f2252107261c9340e
X-master-at: 29f4ad867cd15f4029c280c417f4a0866d5229a9
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22600>

No v1.4.1-rc2 this weekend, as I am expecting a visitor today
and will mostly be offline.  But we got a dozen or so good fixes
and cleanups in "master" so far.

In "next", we have the following being cooked.  I expect most of
them to be in v1.4.1-rc2 sometime next week.  Please report
breakage on any of these if you see one.

 - "git rebase --merge" updates by Eric Wong.
 - "git diff -b -w" by Johannes.
 - "git cvsimport" multi-branch fixes by Martin and Johannes.
 - "git diff --color" can be controlled from $GIT_DIR/config.
 - "git merge --squash"; this may not be strictly needed as it
   can be emulated with repeated use of "cherry-pick -n" but it
   might be handy in some workflows.

In "pu", I have queued other bigger changes.  I do not think
most of them are v1.4.1 material yet.

 - "git format-patch --ignore-already-merged" fixes by
   Johannes; I am hoping to have this in v1.4.1.

 - Perl scripts clean-up and Git.xs by Pasky with a few fixes by
   me; in my mailbox there are several other patches in this
   series not in "pu" that primarily makes more scripts to use
   the new Perl infrastructure.  My feeling is that the series
   needs to be proven to have a sound infrastructure (building,
   testing and installation) on a bit wider platforms before
   starting to consider them for inclusion in "next".  We may be
   able to have the basics from this series in v1.4.1, but am
   still uneasy to convert any important scripts to use this,
   even in "next", at this moment.  Not just yet.

 - built-in "git am" by Lukas; it fails some tests which is not
   a good sign, and as I said in a separate message a few days
   ago, I think it is not worth going this route for something
   high-level as "am", so probably the next round I'd drop the
   last patch from the topic.  The patch to clean up cmd_apply()
   might be worth keeping and merging in "next", depending on
   how the Git.xs effort goes, though.

 - "git diff" option clean-ups by Timo Hirvonen; this is moving
   things in a good direction but as with any intrusive cleanups
   still has some rough edges.  I am hoping we can round them
   off soon to merge it in "next".

 - A new PPC SHA-1 implementation by linux@horizon.com; Linus
   showed that this does not make much difference in real life
   from performance point of view.  If it has other benefits
   (such as code size -- which I do not know how it fares), I am
   willing to merge it as it seems to be correct and does not
   seem to introduce regressions.  But I am not a PPC user so
   somebody needs to push my back on this one.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement.

   Jeff King:
      git-commit: allow -e option anywhere on command line

   Johannes Schindelin:
      patch-id: take "commit" prefix as well as "diff-tree" prefix
      apply: replace NO_ACCURATE_DIFF with --inaccurate-eof runtime fla=
g.

   Junio C Hamano:
      Makefile: do not recompile main programs when libraries have chan=
ged.
      usage: minimum type fix.
      git-pull: abort when fmt-merge-msg fails.
      diff --color: use reset sequence when we mean reset.
      repo-config: fix printing of bool

   Linus Torvalds:
      Tweak diff colors

   Martin Langhoff:
      git-repack -- respect -q and be quiet

   Matthias Kestenholz:
      add GIT-CFLAGS to .gitignore

   Peter Eriksen:
      Rename safe_strncpy() to strlcpy().

   Petr Baudis:
      Customizable error handlers

   Timo Hirvonen:
      git-merge: Don't use -p when outputting summary
      Clean up diff.c

   Yann Dirson:
      git-commit: filter out log message lines only when editor was run=
=2E


* The 'next' branch, in addition, has these.

   Eric Wong:
      rebase: allow --merge option to handle patches merged upstream
      rebase: cleanup rebasing with --merge
      rebase: allow --skip to work with --merge

   Johannes Schindelin:
      Teach diff about -b and -w flags
      cvsimport: always set $ENV{GIT_INDEX_FILE} to $index{$branch}

   Junio C Hamano:
      Makefile: add framework to verify and bench sha1 implementations.
      git-merge --squash
      test-sha1: test hashing large buffer
      diff --color: use $GIT_DIR/config

   Martin Langhoff:
      cvsimport: setup indexes correctly for ancestors and incremental =
imports


* The 'pu' branch, in addition, has these (this fails the tests).

   Johannes Schindelin:
      add diff_flush_patch_id() to calculate the patch id
      format-patch: introduce "--ignore-if-in-upstream"

   Junio C Hamano:
      Perl interface: add build-time configuration to allow building wi=
th -fPIC
      Perl interface: make testsuite work again.
      perl: fix make clean
      Git.pm: tentative fix to test the freshly built Git.pm

   Lukas Sandstr=F6m:
      Make it possible to call cmd_apply multiple times
      Make git-am a builtin

   Petr Baudis:
      Introduce Git.pm (v4)
      Git.pm: Implement Git::exec_path()
      Git.pm: Call external commands using execv_git_cmd()
      Git.pm: Implement Git::version()
      Add Error.pm to the distribution
      Git.pm: Better error handling
      Git.pm: Handle failed commands' output
      Git.pm: Enhance the command_pipe() mechanism
      Git.pm: Implement options for the command interface
      Git.pm: Add support for subdirectories inside of working copies
      Convert git-mv to use Git.pm
      Git.pm: assorted build related fixes.

   Timo Hirvonen:
      Merge with_raw, with_stat and summary variables to output_format
      Make --raw option available for all diff commands
      Set default diff output format after parsing command line
      DIFF_FORMAT_RAW is not default anymore
      --name-only, --name-status, --check and -s are mutually exclusive
      Remove awkward compatibility warts

   Unknown (linux@horizon.com):
      A better-scheduled PPC SHA-1 implementation.
