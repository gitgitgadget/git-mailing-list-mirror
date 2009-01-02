From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 4/4] rebase: update documentation for --root
Date: Fri,  2 Jan 2009 23:28:29 +0100
Message-ID: <9d771e75cb9b50937d968995ed33a6f483b0567b.1230935095.git.trast@student.ethz.ch>
References: <200901022320.14055.trast@student.ethz.ch>
 <6a754e4198413c4051a6085c5e5baab163835463.1230935095.git.trast@student.ethz.ch>
 <7c74d8be216b4667f470e34644c4aa26dcfe0cfb.1230935095.git.trast@student.ethz.ch>
 <43e09eaf2b9a9a3805b9262957ece32190ae4c32.1230935095.git.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>, bss@iguanasuicide.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 23:30:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIsWu-0008K5-9N
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174AbZABW23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757938AbZABW20
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:28:26 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:57648 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757656AbZABW2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 17:28:25 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:28:23 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:28:23 +0100
X-Mailer: git-send-email 1.6.1.71.gaaa47.dirty
In-Reply-To: <43e09eaf2b9a9a3805b9262957ece32190ae4c32.1230935095.git.trast@student.ethz.ch>
In-Reply-To: <6a754e4198413c4051a6085c5e5baab163835463.1230935095.git.trast@student.ethz.ch>
References: <6a754e4198413c4051a6085c5e5baab163835463.1230935095.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 02 Jan 2009 22:28:23.0064 (UTC) FILETIME=[6C0CE180:01C96D29]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104431>

Since the new option depends on --onto and omission of <upstream>, use
a separate invocation style, and omit most options to save space.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-rebase.txt |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c8ad86a..3d6d429 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,10 +8,11 @@ git-rebase - Forward-port local commits to the updated upstream head
 SYNOPSIS
 --------
 [verse]
-'git rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
-	[-s <strategy> | --strategy=<strategy>] [--no-verify]
-	[-C<n>] [ --whitespace=<option>] [-p | --preserve-merges]
-	[--onto <newbase>] <upstream> [<branch>]
+'git rebase' [-i | --interactive] [options] [--onto <newbase>]
+	<upstream> [<branch>]
+'git rebase' [-i | --interactive] [options] --onto <newbase>
+	--root [<branch>]
+
 'git rebase' --continue | --skip | --abort
 
 DESCRIPTION
@@ -22,7 +23,8 @@ it remains on the current branch.
 
 All changes made by commits in the current branch but that are not
 in <upstream> are saved to a temporary area.  This is the same set
-of commits that would be shown by `git log <upstream>..HEAD`.
+of commits that would be shown by `git log <upstream>..HEAD` (or
+`git log HEAD`, if --root is specified).
 
 The current branch is reset to <upstream>, or <newbase> if the
 --onto option was supplied.  This has the exact same effect as
@@ -255,6 +257,15 @@ OPTIONS
 --preserve-merges::
 	Instead of ignoring merges, try to recreate them.
 
+--root::
+	Rebase all commits reachable from <branch>, instead of
+	limiting them with an <upstream>.  This allows you to rebase
+	the root commit(s) on a branch.  Must be used with --onto, and
+	will skip changes already contained in <newbase> (instead of
+	<upstream>).  When used together with --preserve-merges, 'all'
+	root commits will be rewritten to have <newbase> as parent
+	instead.
+
 include::merge-strategies.txt[]
 
 NOTES
-- 
1.6.1.71.gaaa47.dirty
