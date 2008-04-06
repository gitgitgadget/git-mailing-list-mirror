From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.11
Date: Sun, 6 Apr 2008 22:05:33 +0200
Message-ID: <20080406200533.GA20537@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 22:07:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jib8N-0003SA-2T
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 22:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbYDFUFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 16:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbYDFUFi
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 16:05:38 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:47733 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbYDFUFh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 16:05:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 1FD1C19BB20
	for <git@vger.kernel.org>; Sun,  6 Apr 2008 22:05:36 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30230-16 for <git@vger.kernel.org>; Sun,  6 Apr 2008 22:05:33 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 5C22019BB32
	for <git@vger.kernel.org>; Sun,  6 Apr 2008 22:05:33 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 4F5306DF845
	for <git@vger.kernel.org>; Sun,  6 Apr 2008 22:04:11 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 469F51DC88C; Sun,  6 Apr 2008 22:05:33 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78918>

Hello,

This tig release brings many fixes and improvements to the user
interface. Fix pager mode and disable view rely on git directory.  The
date and author columns as well as references can now be toggled on and
off. Local (unsigned) tags are now shown as references and the builtin
reference colors have been changed to highlight the current branch and
the remote tracked by the current branch. The status and stage views are
now reloaded after running external commands (e.g. git commit) so they
stay up to date. Finally, add a blame view accessible from the command
line (tig blame [rev] file), status view as well as the tree view (by
pressing 'B').

Options that were deprecated in 0.10 has been removed except for -S and
the old -- handling is also gone. Unless anybody complains tig diff will
probably also go, while I am still considering what to do with the log
subcommand.

For next release I hope that horizontal scrolling will be fixed. With
the recent interest in textual representation of commit graphs, fixing
or rewriting tig's graph rendering could also be a good addition.

What is tig?
------------
Tig is a ncurses-based text-mode interface for git. It functions mainly
as a git repository browser, but can also act as a pager for output from
various git commands.

 Homepage:	http://jonas.nitro.dk/tig/
 Manual:	http://jonas.nitro.dk/tig/manual.html
 Tarballs:	http://jonas.nitro.dk/tig/releases/
 Gitfeed:	git://repo.or.cz/tig.git
 Gitweb:	http://repo.or.cz/w/tig.git

Changes in this release
-----------------------
Below is the diffstat and shortlog for changes made in this release.

 TODO          |    5 +-
 VERSION       |    2 +-
 asciidoc.conf |    2 +-
 configure.ac  |   12 +-
 manual.txt    |   10 +-
 tig.1.txt     |   12 +-
 tig.c         | 1652 ++++++++++++++++++++++++++++++++++++++++-----------------
 tigrc.5.txt   |  109 +++--
 8 files changed, 1271 insertions(+), 533 deletions(-)

Dominik Vogt (4):
      New actions toggle-date, toggle-author, and toggle-refs.
      Fixed displaying local tags.
      New config options show-author, show-date, show-refs, show-line-numbers.
      Call realloc() less often because it is potentially slow.

Jonas Fonseca (58):
      0.11.git
      TODO: --boundary flag is already used
      utf8_length: add reserve flag for reserving a trailing character
      draw_text: minor cleanup to use fewer local variables
      draw_text: reduce indentation level
      Fix index refreshing into separate call so diff-files is always run
      configure: test for git binary and improve config subcommand test
      tigrc(5): Improve documentation of new show-* options
      Move unrelated UTF-8 setup code out of parse_options
      Use rewritten parent info from --parents to simplify the revgraph
      draw_text: remove unused col argument
      Simplify subcommand option parsing by moving it out of the loop
      Add hack to allow view loading to have multiple phases
      Add blame view
      Various fixes and improvements of the new blame view
      More blame view fixes
      Remove deprecated options and cleanup option parsing
      blame: Fix opening from subdirectory and consecutive invokations
      Save current branch from rev-parse output and highlight it
      Show the current branch in the status view
      Rename "main-delim" color to the more generic "delimiter"
      Add support for preparing the initial commit in the status view
      Oops, fix delimiter documentation
      Avoid reloading the status view when nothing was updated
      Fix uninitialized variable warning
      Fix and improve status refreshing after updating
      Improve perfomance and usability when updating many files
      stage: disable whitespace warnings from git apply when staging updates
      Fix pager mode by always doing the isatty()
      Disable opening views that require a git directory when in pager mode
      Add action to maximize the current view; bound to M by default
      Add draw_lineno() and use when drawing the blame and pager view
      Show the tracked remote branch with bold text
      Make local tags and normal branches use normal font-weight
      status: use draw_text completely
      Merge branch 'master' of remote-server:src/tig
      Do not load repository references when acting as a pager
      Rename load_repo_config() to load_git_config()
      Share the line number colors between blame view and others
      Use werase() instead of wclear() when reloading a view
      When toggling options redraw the view instead of the whole display
      Add support for refreshing of the stage view
      Reload the status and stage views after a run request has been handled
      Improve staging of diff chunks
      Error out when starting up in empty main or blame view
      Fix compatibility for git rev-parse without --symbolic-full-name
      Revert "When toggling options redraw the view instead of the whole display"
      Use 3 as the minimum width of formatted line numbers
      Avoid splitting the view when navigating stage view in full screen
      Squelsh output of update-index when loading the status view
      Make the main and blame view share date drawing and date colors
      Setup colors for the selected line in draw_view_line()
      Minor cleanup in blame_draw
      Use tables for listing the UI colors
      Remove unused blame line attributes
      Update copyright notice for the manual
      Use sans-serif font for the README page
      tig-0.11

Stefan Naewe (1):
      Output extra \n on tig -h

-- 
Jonas Fonseca
