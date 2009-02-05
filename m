From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.14
Date: Thu, 5 Feb 2009 21:44:36 +0100
Message-ID: <20090205204436.GA6072@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 21:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVB7O-0006kr-CX
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713AbZBEUov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 15:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676AbZBEUou
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:44:50 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:36540 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753619AbZBEUos (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 15:44:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id F12C552C35E
	for <git@vger.kernel.org>; Thu,  5 Feb 2009 21:44:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pgVsQ5bYD4SJ for <git@vger.kernel.org>;
	Thu,  5 Feb 2009 21:44:42 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id DF1DE52C3DC
	for <git@vger.kernel.org>; Thu,  5 Feb 2009 21:44:36 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 522BC6DF8AC
	for <git@vger.kernel.org>; Thu,  5 Feb 2009 21:42:54 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id CC01E39AA03; Thu,  5 Feb 2009 21:44:36 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108613>

Hello,

Here is a much needed update fixing multiple regressions from the
introduction of the IO API in 0.13. Among improvements is the much
requested ability to restore the position in the stage view when staging
diff hunks. Also noteworthy is the many optimizations of the screen
updating to make it work better across slow links. Finally, beware that
a handful of incompatibilities can cause problems.

What is tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainly
as a git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various git
commands.

 - Homepage:	http://jonas.nitro.dk/tig/
 - Manual:	http://jonas.nitro.dk/tig/manual.html
 - Tarballs:	http://jonas.nitro.dk/tig/releases/
 - Git URL:	git://repo.or.cz/tig.git 
 - Gitweb:	http://repo.or.cz/w/tig.git

Release notes
-------------
Incompatibilities:

 - The screen-resize action has been deprecated. It had no real use for
   users and was never meant to be exposed.
 - The "tree-parent" action was renamed to "parent". Warnings will be
   emitted for transition.
 - Remove parsing of deprecated option -S and subcommands log and diff.
 - The "author" color replaces "main-author". Setting the latter will
   now set the "author" color.

Improvements:

 - Horizontal scrolling. Bound to Left/Right by default.
 - Read tigrc(5) options from git configuration files using the syntax:

	[tig] show-rev-graph = true
	[tig "color"] cursor = yellow red bold 
	[tig "bind"] generic = P parent

 - Tree view: avoid flickering when updating.
 - Tree view: annotate entries with commit information.
 - Tree & blob view: open any blob in an editor.
 - Stage & main view: restore view position when reloading.
 - Blame view: load blame for parent commit. For merge commits the parent
   is queried. Bound to ',' by default via the existing "parent" action.
 - Abbreviate author names to initials when the width of the author column
   is below 6 characters.

Bug fixes:

 - Tree view: fix memory corruption bug when updating.
 - Tree view: improve handling of empty trees.
 - Status view: fix reverting of unmerged files.
 - Fix regression for non-UTF-8 locales corrupting the view data.
 - Fix regression parsing multiple spaces in ~/.tigrc.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 BUGS                |    2 -
 INSTALL             |    2 +-
 Makefile            |   22 +-
 NEWS                |   43 +-
 TODO                |   58 +-
 VERSION             |    2 +-
 contrib/aspell.dict |  147 ++++
 contrib/release.sh  |   75 ++
 manual.txt          |   48 +-
 tig.1.txt           |   14 +-
 tig.c               | 1784 +++++++++++++++++++++++++++----------------
 tigrc.5.txt         |   91 ++-
 12 files changed, 1520 insertions(+), 768 deletions(-)

     1	Jeff King
    76	Jonas Fonseca
     1	Stefan Naewe

-- 
Jonas Fonseca
