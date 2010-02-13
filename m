From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 21/30] Documentation: Generalize git-notes docs to 'objects'
 instead of 'commits'
Date: Sat, 13 Feb 2010 22:28:29 +0100
Message-ID: <1266096518-2104-22-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPaq-0002mJ-F2
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169Ab0BMVbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:31:08 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51460 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758109Ab0BMV3q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:46 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00EGDUDKVE80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:44 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:44 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139857>

Notes can annotate arbitrary objects (not only commits), but this is not
reflected in the current documentation.

This patch rewrites the git-notes documentation to talk about 'objects'
instead of 'commits'. However, the discussion on commit notes and how
they are displayed by 'git log' is largely preserved.

Finally, I add myself to the Author/Documentation credits, since most of
the lines in the git-notes code and docs are blamed on me.

Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 3973f90..84db2a4 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -3,37 +3,41 @@ git-notes(1)
 
 NAME
 ----
-git-notes - Add/inspect commit notes
+git-notes - Add/inspect object notes
 
 SYNOPSIS
 --------
 [verse]
-'git notes' (edit [-F <file> | -m <msg>] | show | remove | prune) [commit]
+'git notes' (edit [-F <file> | -m <msg>] | show | remove | prune) [object]
 
 DESCRIPTION
 -----------
-This command allows you to add/remove notes to/from commit messages,
-without changing the commit.  To discern these notes from the message
-stored in the commit object, the notes are indented like the message,
-after an unindented line saying "Notes:".
+This command allows you to add/remove notes to/from objects, without
+changing the objects themselves.
 
-To disable commit notes, you have to set the config variable
-core.notesRef to the empty string.  Alternatively, you can set it
-to a different ref, something like "refs/notes/bugzilla".  This setting
-can be overridden by the environment variable "GIT_NOTES_REF".
+A typical use of notes is to extend a commit message without having
+to change the commit itself. Such commit notes can be shown by `git log`
+along with the original commit message. To discern these notes from the
+message stored in the commit object, the notes are indented like the
+message, after an unindented line saying "Notes:".
+
+To disable notes, you have to set the config variable core.notesRef to
+the empty string.  Alternatively, you can set it to a different ref,
+something like "refs/notes/bugzilla".  This setting can be overridden
+by the environment variable "GIT_NOTES_REF".
 
 
 SUBCOMMANDS
 -----------
 
 edit::
-	Edit the notes for a given commit (defaults to HEAD).
+	Edit the notes for a given object (defaults to HEAD).
 
 show::
-	Show the notes for a given commit (defaults to HEAD).
+	Show the notes for a given object (defaults to HEAD).
 
 remove::
-	Remove the notes for a given commit (defaults to HEAD).
+	Remove the notes for a given object (defaults to HEAD).
 	This is equivalent to specifying an empty note message to
 	the `edit` subcommand.
 
@@ -54,11 +58,12 @@ OPTIONS
 
 Author
 ------
-Written by Johannes Schindelin <johannes.schindelin@gmx.de>
+Written by Johannes Schindelin <johannes.schindelin@gmx.de> and
+Johan Herland <johan@herland.net>
 
 Documentation
 -------------
-Documentation by Johannes Schindelin
+Documentation by Johannes Schindelin and Johan Herland
 
 GIT
 ---
-- 
1.7.0.rc1.141.gd3fd
