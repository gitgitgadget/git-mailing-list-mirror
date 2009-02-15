From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.14.1
Date: Mon, 16 Feb 2009 00:11:01 +0100
Message-ID: <20090215231101.GA7032@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 00:12:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYqAB-00018L-Pq
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 00:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbZBOXLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 18:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbZBOXLI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 18:11:08 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:55033 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754098AbZBOXLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 18:11:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id D414C52C3B6
	for <git@vger.kernel.org>; Mon, 16 Feb 2009 00:11:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rUgzvbArpm+6 for <git@vger.kernel.org>;
	Mon, 16 Feb 2009 00:11:01 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id C181452C3AD
	for <git@vger.kernel.org>; Mon, 16 Feb 2009 00:11:01 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id CE2076DF823
	for <git@vger.kernel.org>; Mon, 16 Feb 2009 00:09:03 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id AD50539AA07; Mon, 16 Feb 2009 00:11:01 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110082>

Hello,

A minor update to tig fixing some of the things that was recently
discussed in the thread following the 0.14 release. Horizontal scrolling
should now be working as should digging through history using the blame
view. Thanks to those who provided feedback goes out to those who
provided feedback and 

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
Improvements:

 - Status view: improve "on branch" information inspired by the prompt
   code in git's bash completion script.
 - Colors for 256-capable terminals can be specified as colorN.
 - Entering a number in the prompt will jump to that line number.
 - Handle core.worktree by setting GIT_DIR and GIT_WORK_TREE.
 - Make behavior of horizontal scrolling configurable by setting the
   'horizontal-scroll' variable to a number or a percentage. Defaults to
   scrolling 50% of the view width.

Bug fixes:

 - Status view: show error when failing to open a file.
 - Status view: report failures to update a file.
 - Blame view: fix problem with uninitialized variable.
 - Blame view: use line number information when loading blame for
   specific commit.
 - Fix handling of quoted strings in the config file.
 - Fix horizontal scrolling glitches.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 NEWS                |   26 ++-
 VERSION             |    2 +-
 contrib/aspell.dict |   12 +-
 manual.txt          |    4 +-
 tig.c               |  877 +++++++++++++++++++++++++------------------
 tigrc.5.txt         |   44 ++-
 6 files changed, 587 insertions(+), 378 deletions(-)

Carsten Brockmann (1):
      manual: Correct the keys to move the cursor one line up/down

Jeff King (2):
      Fix uninitialized variable in string_expand_length
      Handle blaming beyond the creation of file more gracefully

Jonas Fonseca (41):
      Cleanup and simplify option file parsing
      Refactor the int_map interface into new enum_map interface
      Use enum_map for handling obsolete request names
      Use enum_map for handling obsolete color names
      Remove unused OPEN_BACKGROUNDED flag
      Remove the need for the OPEN_NOMAXIMIZE flag
      Refactor and unify timezone parsing
      Simplify setting the default for the system configuration file
      Improve on branch information in the status view
      Warn users about integers in ~/.tigrc being out of bound
      Jump to line when a number is entered in the prompt
      Improve restoring of the view position to bound the offset
      Introduce common view position update helper
      Make the blame view expand tabs at drawing time
      Use file and line number information when loading blame for commit
      Blame view: add guesstimation of line number when blaming parent commit
      NEWS: Mention Jeff's uninitialized variable bug fix
      Use check_blame_commit when handling REQ_ENTER
      Mark enum_maps and other data tables as const
      Move setting of remote branch from repo config to separate function
      Optimize read_repo_config_option to reduce string comparisons
      Add support for handling core.worktree
      Fix io_strerror return type
      Refactor and share view maximization code from view-close handling
      Status view: upon failure to open a file show error message
      Use putenv instead of setenv
      Ignore broken pipe signals
      Status view: report failures to update a file
      Tree view: draw submodule entry modes as "m---------"
      tigrc(5): fix error in examples for the set command
      Make behavior of horizontal scrolling configurable
      Fix the view clearing to only be effective for displayed views
      tigrc(5): suggest git aliases for external commands requiring shell ops
      Remove limitation of horizontal scrolling
      Fix horizontal scrolling
      Refactor draw_lineno to use draw_graphic
      Fix bug in draw_space to not access memory outside the space buffer
      Fix draw_lineno to always set the static format buffer
      Keep the cursor fixed while initial stage progress is reported
      Remove unneeded doupdate from view_driver
      tig-0.14.1

Sebastian Harl (1):
      Fix handling of quoted strings in the config file

Witold Filipczyk (1):
      Add support for 256 colors by allowing "colorN" names similar to Mutt

-- 
Jonas Fonseca
