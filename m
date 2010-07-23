From: Johan Herland <johan@herland.net>
Subject: [WIP/RFC 13/13] Documentation: Preliminary docs on 'git notes merge'
Date: Fri, 23 Jul 2010 12:15:04 +0200
Message-ID: <1279880104-29796-14-git-send-email-johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 12:15:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcFHz-0000y8-Po
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 12:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194Ab0GWKPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 06:15:31 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43952 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756180Ab0GWKP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 06:15:29 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6000GAW9TGM390@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:16 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id DD5051EA54DB_C496BB3B	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:15 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id C908E1EA3EBA_C496BB3F	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:14 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L60005R49T9TN00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:13 +0200 (MEST)
X-Mailer: git-send-email 1.7.2.220.gea1d3
In-reply-to: <1279880104-29796-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151515>

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index ce0ea03..f4ad4cc 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git notes' append [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [<object>]
 'git notes' show [<object>]
+'git notes' merge [-v | -q] [-X <strategy> ] <notes_ref>
 'git notes' remove [<object>]
 'git notes' prune [-n | -v]
 
@@ -83,6 +84,15 @@ edit::
 show::
 	Show the notes for a given object (defaults to HEAD).
 
+merge::
+	Merge the given notes ref into the current notes ref.
+	This will try to merge the changes made by the given
+	notes ref (called "remote") since the merge-base (if
+	any) into the current notes ref (called "local").
++
+If conflicts arise (and a strategy for auto-resolving conflicting notes
+(see the -X/--resolve option) is not given, the merge fails (TODO).
+
 remove::
 	Remove the notes for a given object (defaults to HEAD).
 	This is equivalent to specifying an empty note message to
@@ -132,8 +142,24 @@ OPTIONS
 	Do not remove anything; just report the object names whose notes
 	would be removed.
 
+-X <strategy>::
+--resolve=<strategy>::
+	When merging notes, resolve notes conflicts using the given
+	strategy. The following strategies are recognized: "manual"
+	(default), "ours", "theirs" and "union". "ours" automatically
+	resolves conflicting notes in favor of the local version (i.e.
+	the current notes ref). "theirs" auto-resolves notes conflicts
+	in favor of the remote version (i.e. the given notes ref being
+	merged into the current notes ref). "union" auto-resolves
+	notes conflicts by concatenating the local and remote versions.
+
+-q::
+--quiet::
+	When merging notes, operate quietly.
+
 -v::
 --verbose::
+	When merging notes, be more verbose.
 	When pruning notes, report all object names whose notes are
 	removed.
 
-- 
1.7.2.220.gea1d3
