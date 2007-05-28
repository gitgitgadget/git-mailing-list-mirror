From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's new in git-gui.git
Date: Mon, 28 May 2007 18:49:49 -0400
Message-ID: <20070528224949.GC7044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 00:50:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hso2O-00030x-NB
	for gcvg-git@gmane.org; Tue, 29 May 2007 00:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351AbXE1Wtz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 18:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757543AbXE1Wtz
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 18:49:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60136 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757351AbXE1Wty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 18:49:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hso22-0003mY-4v; Mon, 28 May 2007 18:49:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6029020FBAE; Mon, 28 May 2007 18:49:50 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48650>

I got around to working on git-gui this week.  Yay me.  Updates for
both the stable (0.7.x) series and the new development series
(0.8.x), and some roadmap items.  See below...

--- Stable ---

The following changes since gitgui-0.7.1
  Shawn O. Pearce (1):
        git-gui: Gracefully handle bad TCL_PATH at compile time

are available in the git repository at:

  repo.or.cz:/srv/git/git-gui.git maint

Shawn O. Pearce (3):
      git-gui: Tighten internal pattern match for lib/ directory
      Correct key bindings to Control-<foo>
      git-gui: Guess our share/git-gui/lib path at runtime if possible

 Makefile   |   12 ++++++++++--
 git-gui.sh |   17 +++++++++--------
 2 files changed, 19 insertions(+), 10 deletions(-)

The final commit in this series has been tagged as gitgui-0.7.2
and should be packaged as part of the next maintenance release of
git 1.5.2.  All are trivial fixes for minor issues raised since
0.7.1 was released.

--- Development ---

The following changes since gitgui-0.7.2
  Shawn O. Pearce (1):
        git-gui: Guess our share/git-gui/lib path at runtime if possible

are available in the git repository at:

  repo.or.cz:/srv/git/git-gui.git master

Shawn O. Pearce (9):
      git gui 0.8.0
      git-gui: GUI support for running 'git remote prune <name>'
      git-gui: Show the git-gui library path in 'About git-gui'
      git-gui: Enable verbose Tcl loading earlier
      git-gui: Provide fatal error if library is unavailable
      git-gui: Disable tearoff menus on Windows, Mac OS X
      git-gui: Allow users to rename branches through 'branch -m'
      git-gui: Allow users to delete remote branches
      git-gui: Expose the merge.diffstat configuration option

 GIT-VERSION-GEN              |    2 +-
 git-gui.sh                   |   87 +++++++----
 lib/branch_rename.tcl        |  137 +++++++++++++++++
 lib/option.tcl               |   17 ++-
 lib/remote.tcl               |   11 ++
 lib/remote_branch_delete.tcl |  348 ++++++++++++++++++++++++++++++++++++++++++
 lib/transport.tcl            |   16 ++-
 7 files changed, 586 insertions(+), 32 deletions(-)
 create mode 100644 lib/branch_rename.tcl
 create mode 100644 lib/remote_branch_delete.tcl

This is actually the start of the 0.8.0 development cycle.  It is
stable enough for git.git's master branch.  I don't anticipate this
version of git-gui being packaged with any git earlier than 1.5.3.

Some major new features have been added:

 - Rename an existing branch (git-brach -m).
 - Delete an existing remote branch.
 - Prune expired tracking branches.
 - Automatically prune expired tracking branches during fetch.

I'm hoping to do a lot more before 0.8.0 goes final.  Which is part
of the reason why I don't expect this to be packaged with anything
earlier than 1.5.3.

--- Roadmap ---

Looking ahead, I'd like to see some improvement in the following
areas.  It would be nice if some Tcl/Tk-minded individuals were
willing to dive and help.  ;-)

 - Initial repository creation
 - Initial repository cloning
 - Select an existing repository from an OS native file dialog

   These are mostly about better supporting the MinGW environment
   (or a Cygwin environment) where some users are not used to
   performing operations through a command line terminal window.
   Sometimes being able to start an application through an icon
   and have it prompt you for initial configuration is exactly what
   the user wants.

   At the same time we probably should support running against a
   bare repository, at least for the cases of the "browser" and
   "blame" subcommands.

 - Blame viewer coloring should be less horrid
 - Blame viewer should support digging into the prior version
 - Jump to line in blame viewer (use vi's :nnn syntax?)
 - Find substring in blame viewer (use vi's / syntax?)

   These have been discussed before.  The current blame viewer is
   useful, but not fun to look at.  It also doesn't let you dig
   back into history further than the revision it was started on.

   Now that the blame viewer is cleaned up and uses git-gui's
   "class/field/method" system this is probably a lot easier to
   get done (pre-0.7.0 that code was just a disaster).

 - Fetch+merge from arbitrary URL and branch(es)

   Aka "git pull", but in a GUI.  Pulling from random URLs is not
   uncommon in the Git user community and we should support it as
   a first-class operation in git-gui.

   The UI I just put in for deleting remote branches may offer a
   good starting point for this, as it does an async ls-remote to
   get the available branch heads.

 - Preserve author during amend
 - Set commit author line

   These sort of go hand-in-hand.  Currently there is no way to enter
   an author; the authorship of a commit is always the current user.
   But I know a few people using git-gui who really should be doing
   `git commit --author=$someoneelse` every once in a while, as
   they are committing files for $someoneelse.

   I'm also getting bit by the amend bug myself when I apply
   patches from other people and then go back and try to tweak
   something minor.

-- 
Shawn.
