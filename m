From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 3/3] rebase: update documentation for --root
Date: Tue, 30 Dec 2008 13:29:48 +0100
Message-ID: <e9bb872d202b13ac41cffe11f3ebf768cd40dd41.1230639970.git.trast@student.ethz.ch>
References: <200812301323.30550.trast@student.ethz.ch>
 <7b2902d36a4790670f20f786d4ea2e26052a6e71.1230639970.git.trast@student.ethz.ch>
 <3c7d0d7e84b6841041d23e16bf04d65ebea503a4.1230639970.git.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 13:31:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHdkh-0002dh-5A
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 13:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbYL3M3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 07:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbYL3M3y
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 07:29:54 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:57067 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbYL3M3v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 07:29:51 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Dec 2008 13:29:46 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Dec 2008 13:29:46 +0100
X-Mailer: git-send-email 1.6.1.20.g7f5c5.dirty
In-Reply-To: <3c7d0d7e84b6841041d23e16bf04d65ebea503a4.1230639970.git.trast@student.ethz.ch>
In-Reply-To: <7b2902d36a4790670f20f786d4ea2e26052a6e71.1230639970.git.trast@student.ethz.ch>
References: <7b2902d36a4790670f20f786d4ea2e26052a6e71.1230639970.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 30 Dec 2008 12:29:46.0643 (UTC) FILETIME=[4CF4B630:01C96A7A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104181>

Since the new option depends on --onto and omission of <upstream>, use
a separate invocation style, and omit most options to save space.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Changed since v1: remark about the effect of --root --preserve-merges.

 Documentation/git-rebase.txt |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c8ad86a..e3b4b83 100644
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
@@ -255,6 +257,13 @@ OPTIONS
 --preserve-merges::
 	Instead of ignoring merges, try to recreate them.
 
+--root::
+	Rebase all commits reachable from <branch>, instead of
+	limiting them with an <upstream>.  This allows you to rebase
+	the root commit(s) on a branch.  Must be used with --onto.
+	When used together with --preserve-merges, 'all' root commits
+	will be rewritten to have <newbase> as parent instead.
+
 include::merge-strategies.txt[]
 
 NOTES
-- 
1.6.1.20.g7f5c5.dirty
