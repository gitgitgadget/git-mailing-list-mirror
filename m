From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add a manual page for git-stash
Date: Sat, 30 Jun 2007 16:44:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706301644190.4438@racer.site>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site>
 <200706300539.l5U5dHLh003989@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 17:44:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4f7u-0007HY-U8
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 17:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835AbXF3Pop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 11:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754767AbXF3Pop
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 11:44:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:47914 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754821AbXF3Poo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 11:44:44 -0400
Received: (qmail invoked by alias); 30 Jun 2007 15:44:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 30 Jun 2007 17:44:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/A86YI0YzAC8V1VzqpuQsUSpQDjR3gh1txWe7+9u
	MDvNILtv1h9Ql9
X-X-Sender: gene099@racer.site
In-Reply-To: <200706300539.l5U5dHLh003989@mi1.bluebottle.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51221>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-stash.txt |  116 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 116 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-stash.txt

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
new file mode 100644
index 0000000..b109f6e
--- /dev/null
+++ b/Documentation/git-stash.txt
@@ -0,0 +1,116 @@
+git-stash(1)
+=============
+
+NAME
+----
+git-stash - Stash the changes in a dirty working directory away
+
+SYNOPSIS
+--------
+[verse]
+'git-stash' [clear]
+'git-stash' [list | show | apply] [<stashname>]
+
+DESCRIPTION
+-----------
+Use 'git stash' when you want to record the current state of the
+working directory and the index, but want to go back to a clean
+working directory.
+
+For example, if you have to pull, but are in the middle of some
+interesting work, not yet ready to be committed, use git-stash.
+
+The default operation (when called without options), is to save
+the changes away.
+
+
+OPTIONS
+-------
+clear::
+	Undo _all_ stashes (dangerous!).
+
+list [<stashname>]::
+	List all stashed states.
+
+show [<stashname>]::
+	Show a combined diff of the stashed working directory, index and
+	HEAD.
+
+apply [<stashname>]::
+	Try to apply the stashed changes to the current HEAD. You need
+	a clean working directory for that, i.e. you must not have changes
+	relative to HEAD in your working directory or index.
+
+<stashname>::
+	A name of a stashed state. Typically something like 'stash@{2}'
+	or 'stash@{2.days.ago}'.
+
+
+EXAMPLES
+--------
+
+Get to a clean working directory, quick:
+
+---------------------
+$ git stash
+---------------------
+
+See what you stashed:
+
+---------------------
+$ git stash list
+---------------------
+
+Inspect the last stashed state:
+
+---------------------
+$ git stash show
+---------------------
+
+Inspect the second last stashed state:
+
+--------------------------
+$ git stash show stash@{1}
+--------------------------
+
+Apply the second last stashed state:
+
+---------------------------
+$ git stash apply stash@{1}
+---------------------------
+
+
+DISCUSSION
+----------
+
+The state is saved as three commits:
+
+- HEAD,
+- a commit which contains the state of the index, which has HEAD as a
+  parent, and
+- a commit which contains the state of the working directory (only the
+  tracked files, though), which has both HEAD and the second commit
+  as parents.
+
+The third commit holds the complete information of the stash, and is
+stored as the ref 'refs/stash'.
+
+Since that commit does not have any reference to other stashed states,
+the stash listing relies on the reflog of 'refs/stash'. Therefore,
+the stashed states are garbage collected like all the other reflogs.
+
+
+SEE ALSO
+--------
+gitlink:git-commit[1],
+gitlink:git-log[1],
+gitlink:git-reflog[1]
+
+Author
+------
+Written by Johannes E. Schindelin <johannes.schindelin@gmx.de>
+
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.5.2.2.3249.g33841
