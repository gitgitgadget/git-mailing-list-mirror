From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.10
Date: Mon, 17 Mar 2008 03:03:04 +0100
Message-ID: <20080317020304.GA19249@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 03:04:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb4iR-0003lL-C6
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 03:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758175AbYCQCDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 22:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755488AbYCQCDL
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 22:03:11 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:35011 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758158AbYCQCDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 22:03:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 9544F19BB40
	for <git@vger.kernel.org>; Mon, 17 Mar 2008 03:03:07 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06671-07 for <git@vger.kernel.org>; Mon, 17 Mar 2008 03:03:04 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id E34D519BB3F
	for <git@vger.kernel.org>; Mon, 17 Mar 2008 03:03:04 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id B5A426DF835
	for <git@vger.kernel.org>; Mon, 17 Mar 2008 03:02:13 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id CF9151DC4AD; Mon, 17 Mar 2008 03:03:04 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77409>

Hello,

A new version of tig is available! It brings many documentation
improvements, bug fixes, and some much needed updates to work better
with git (e.g. by using --no-color and avoiding to use git-diff). On
startup, tig will now attempt to first read a system-wide configuration
file before loading the user specific configuration file. Cherry picking
from inside tig has been generalized, making it possible to wire
external commands, which can access information about the current
commit, to a keybinding.

Among possible incompatible changes, option parsing has been changed to
be more similar with gitk's by deprecating almost all tig options, so to
startup in the status view use `tig status'! Building the documentation
(sadly?) now depends on DocBook XSL 1.72 to reduce the number of
accumulated AsciiDoc and XSL hacks.

In the pipeline for the next release are improved rename support in the
status view and encoding and drawing fixes from Dominik Vogt. The
deprecated options will probably also go away, including the special
handling of "--".

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

 .gitignore                  |    5 +-
 INSTALL                     |   12 +-
 Makefile                    |   48 +++---
 TODO                        |   10 +
 VERSION                     |    2 +-
 asciidoc.conf               |   28 ++-
 config.make.in              |    1 +
 contrib/tig-completion.bash |   44 ++---
 manpage.xsl                 |   55 -----
 manual.txt                  |   65 +++++--
 tig.1.txt                   |  112 +++++++----
 tig.c                       |  470 +++++++++++++++++++++++++++++++-----------
 tigrc.5.txt                 |  109 +++++++----
 13 files changed, 620 insertions(+), 341 deletions(-)

Dominik Vogt (8):
      Minor formatting and spelling fixes.
      Add documentation for undocumented color options.
      Added color option main-revgraph to color the revision graph.
      Added action tree-parent and bound it to backspace by default.
      Removed trailing whitespace.
      Updated .gitignore
      Added examples to tig(1) manpage
      Add system-wide configuration file and new config file environment vars

James Bowes (1):
      Add missing = for comparison in obsolete actions check

Jari Aalto (1):
      Makefile: add ASCIIDOC_FLAGS

Jonas Fonseca (24):
      tig-0.10.git
      Unify REQ_NONE and REQ_UNKNOWN by moving REQ_NONE to be the last request
      Add support binding keys to running external commands
      Obsolete the cherry-pick action and define as builtin external command
      Improve sanity check error messages
      Collect remaining string in last entry when parsing config file lines
      Use get_key_name() in get_key()
      Fix crash when opening mergetool for lines that are not unmerged
      Rearrange the order of option parsing
      Use --no-color option when calling git-log and git-diff
      Avoid using git-diff since it might run external diff drivers
      manual: remove section on porcelains
      Ignore HTML files in general
      Install manpages in $(prefix)/share/man
      TODO: Mention tig.c splitting and revgraph rewrite
      Update manpages to not contain contain so many formatting workarounds
      INSTALL: Document the optional documentation tools
      Replace the manpage XSL workarounds with AsciiDoc conf workarounds
      Simplify documentation building and fix asciidoc.conf dependency
      Drop -B from diff options
      Add support for showing boundary commits in the main view
      Make it possible to overwrite the default (terminal) colors
      Make command line parsing more compatible with gitk
      tig-0.10

-- 
Jonas Fonseca
