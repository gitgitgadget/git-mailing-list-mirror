From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 14/23] Documentation: Preliminary docs on 'git notes merge'
Date: Tue, 09 Nov 2010 22:49:50 +0100
Message-ID: <1289339399-4733-15-git-send-email-johan@herland.net>
References: <1289339399-4733-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 22:50:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFw5J-0000PX-Fk
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 22:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470Ab0KIVua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 16:50:30 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61230 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457Ab0KIVu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 16:50:27 -0500
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBN005XL0NOCV30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Nov 2010 22:50:16 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 598B71799CC6_CD9C218B	for <git@vger.kernel.org>; Tue,
 09 Nov 2010 21:50:16 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 4219D1799C98_CD9C218F	for <git@vger.kernel.org>; Tue,
 09 Nov 2010 21:50:15 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBN00HVN0NLS730@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Nov 2010 22:50:13 +0100 (MET)
X-Mailer: git-send-email 1.7.3.2.173.gab1c9.dirty
In-reply-to: <1289339399-4733-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161082>

This patch has been improved by the following contributions:
- Stephen Boyd: Use "automatically resolves" instead of "auto-resolves"
- Stephen Boyd: Remove unbalanced '('

Thanks-to: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |   44 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 2981d8c..07a5042 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git notes' append [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [<object>]
 'git notes' show [<object>]
+'git notes' merge [-v | -q] [-s <strategy> ] <notes_ref>
 'git notes' remove [<object>]
 'git notes' prune [-n | -v]
 
@@ -83,6 +84,16 @@ edit::
 show::
 	Show the notes for a given object (defaults to HEAD).
 
+merge::
+	Merge the given notes ref into the current notes ref.
+	This will try to merge the changes made by the given
+	notes ref (called "remote") since the merge-base (if
+	any) into the current notes ref (called "local").
++
+If conflicts arise and a strategy for automatically resolving
+conflicting notes (see the -s/--strategy option) is not given,
+the merge fails (TODO).
+
 remove::
 	Remove the notes for a given object (defaults to HEAD).
 	This is equivalent to specifying an empty note message to
@@ -133,9 +144,23 @@ OPTIONS
 	Do not remove anything; just report the object names whose notes
 	would be removed.
 
+-s <strategy>::
+--strategy=<strategy>::
+	When merging notes, resolve notes conflicts using the given
+	strategy. The following strategies are recognized: "manual"
+	(default), "ours", "theirs" and "union".
+	See the "NOTES MERGE STRATEGIES" section below for more
+	information on each notes merge strategy.
+
+-q::
+--quiet::
+	When merging notes, operate quietly.
+
 -v::
 --verbose::
-	Report all object names whose notes are removed.
+	When merging notes, be more verbose.
+	When pruning notes, report all object names whose notes are
+	removed.
 
 
 DISCUSSION
@@ -163,6 +188,23 @@ object, in which case the history of the notes can be read with
 `git log -p -g <refname>`.
 
 
+NOTES MERGE STRATEGIES
+----------------------
+
+The default notes merge strategy is "manual", which is not yet
+implemented (TODO).
+
+"ours" automatically resolves conflicting notes in favor of the local
+version (i.e. the current notes ref).
+
+"theirs" automatically resolves notes conflicts in favor of the remote
+version (i.e. the given notes ref being merged into the current notes
+ref).
+
+"union" automatically resolves notes conflicts by concatenating the
+local and remote versions.
+
+
 EXAMPLES
 --------
 
-- 
1.7.3.2.173.gab1c9.dirty
