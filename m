From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 14/21] Documentation: Preliminary docs on 'git notes merge'
Date: Sat,  9 Oct 2010 03:13:32 +0200
Message-ID: <1286586819-3636-15-git-send-email-johan@herland.net>
References: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:14:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4O1R-0003NB-5W
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933109Ab0JIBOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:14:40 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:51322 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428Ab0JIBOj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:14:39 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4O1G-0001lM-Au; Sat, 09 Oct 2010 03:14:38 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158564>

This patch has been improved by the following contributions:
- Stephen Boyd: Use "automatically resolves" instead of "auto-resolves"
- Stephen Boyd: Remove unbalanced '('

Cc: Stephen Boyd <bebarino@gmail.com>
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
1.7.3.1.104.g92b87a
