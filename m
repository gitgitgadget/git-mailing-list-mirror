From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-1.1
Date: Fri, 12 Oct 2012 15:05:57 +0200
Message-ID: <20121012130557.GA20702@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 15:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMfST-0002YF-P6
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 15:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932941Ab2JLNjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2012 09:39:10 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:33349 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311Ab2JLNjI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 09:39:08 -0400
X-Greylist: delayed 1967 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Oct 2012 09:39:08 EDT
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id E0F4C19BCF1
	for <git@vger.kernel.org>; Fri, 12 Oct 2012 15:06:18 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31213-12 for <git@vger.kernel.org>; Fri, 12 Oct 2012 15:06:14 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id AAF3719BCAF
	for <git@vger.kernel.org>; Fri, 12 Oct 2012 15:06:14 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 9D8E16DFB71
	for <git@vger.kernel.org>; Fri, 12 Oct 2012 15:06:14 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 9E9BA266A1; Fri, 12 Oct 2012 15:05:57 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207543>

Hello,

I've release tig version 1.1 with a bunch of improvements and bug fixes=
=2E
Note that tig no longer uses move/copy detection by default to work
better on large repository. See the release notes below on how to
restore the old behavior.

What is tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainl=
y
as a git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various git
commands.

 - Homepage:	http://jonas.nitro.dk/tig/
 - Manual:	http://jonas.nitro.dk/tig/manual.html
 - Tarballs:	http://jonas.nitro.dk/tig/releases/
 - Git URL:	git://github.com/jonas/tig.git=20
 - Gitweb:	http://repo.or.cz/w/tig.git

Release notes
-------------
Incompatibilities:

 - Disable diff move/copy detection by default, boosting diff
   performance on larger projects. Use git config 'diff.renames' option
   (git-wide) to set your preferred behavior. Environment variable
   TIG_DIFF_OPTS can be used to restore the old behavior.
 - Values set for author-width and filename-width will result in widths
   one character bigger than previously.

Improvements:

 - Typing a text in the prompt will be interpreted as a tig command.
   Prefixing the command with a '!' will execute this system command in
   an external pager. Entering a single key will execute the
   corresponding key binding.
 - Basic support for wrapping long line in pager, diff, and stage views=
=2E
   Enable using: `set wrap-lines =3D yes`. (GH #2)
 - User-defined commands prefixed with a '?' means prompt before
   execution. Example: `bind main B !?git rebase -i %(commit)`.
 - User-defined commands prefixed with a '<' means exit after execution=
=2E
   Example: `bind main C !<git commit`. (GH #66)
 - User-defined commands are executed unquoted to support shell command=
s.
   Example: `bind generic I !@sh -c "echo -n %(commit) | xclip -selecti=
on c"`.
   (GH #65)
 - Configure case-insensitive searches using: `set ignore-case =3D yes`=
=2E
 - Add "deleted mode" line type for better diff coloring.
 - Open editor when requesting edit action from within a file diff.
 - Update AX_WITH_CURSES to build under Cygwin.
 - Improve tigrc(5) documentation. (Debian #682766)
 - Allow to build on Mac OS 10.7 without the configure script. (GH #25)
 - Add option to split the view vertically instead of horizontally.
   Example: `set vertical-split =3D yes'. (GH #76)
 - Add 'show-id' and 'id-width' options to configure the display of
   commit IDs in the main view and ID width in the blame view. (GH #77)
 - Allow to override git-based encoding to UTF-8 by setting
   'i18n.commitencoding' or 'gui.encoding'.
 - Improve autobuild support to track generated files and work with
   autoreconf 2.61.
 - Commit IDs are read from stdin when --stdin is given; works for main
   and diff view, e.g. `tig --no-walk --stdin < cherry-picks.txt`.
 - Add option to disable focusing of the child view when it's opened.
   Disable using: `set focus-child =3D no`. (GH #83)
 - Allow to open blob related with added content in a diff. (GH #91)

Bug fixes:

 - Fix commit graph regression when a path spec is specified. (GH #53)
 - Main view: only show staged/unstaged changes for the current branch.
 - Support submodules created with current version of git. (GH #54)
 - Fix diff status message for file diffs with no content changes.
 - Fix parent blaming when tig is launched in subdirectory. (GH #70)
 - Do not show deleted branch when reloading the branch view.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 .gitignore                     |    2 +
 INSTALL                        |    8 +
 Makefile                       |   35 +-
 NEWS                           |   57 ++-
 autogen.sh                     |   22 +
 config.make.in                 |   12 +-
 configure.ac                   |   13 +-
 contrib/announcement.sh        |    2 +-
 contrib/aspell.dict            |  338 ++++++------
 contrib/ax_with_curses.m4      |  544 ++++++++++++++++---
 contrib/config.make-Darwin     |    3 +
 contrib/tig.spec.in            |    4 +
 contrib/update-release-docs.sh |   53 ++
 git.h                          |   36 +-
 io.c                           |   64 ++-
 io.h                           |    9 +-
 manual.txt                     |   47 +-
 refs.c                         |    2 +-
 test-graph.c                   |    2 +-
 tig.1.txt                      |    3 +-
 tig.c                          |  960 +++++++++++++++++++++++---------
 tig.h                          |   51 ++-
 tigrc.5.txt                    |  142 ++++-
 23 files changed, 1806 insertions(+), 603 deletions(-)

     1	Beat Bolli
     1	Donald Chai
     1	Douglas Livingstone
     1	Hugo Schmitt
     1	Jiri Jaburek
    43	Jonas Fonseca
     2	Petr Uzel
     2	Rich Healey
     1	Ryan Schlesinger
     8	Samuel Bronson
     3	Valentin Haenel
     1	Victor Foitzik
     7	Vivien Didelot
     1	=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec

--=20
Jonas Fonseca
