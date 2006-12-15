X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Align section headers of 'git status' to new 'git add'.
Date: Thu, 14 Dec 2006 19:13:55 -0500
Message-ID: <20061215001355.GB26755@spearce.org>
References: <2d2d4a64dab54a6d156b599afd69d7607fb228f6.1166141607.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 00:14:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <2d2d4a64dab54a6d156b599afd69d7607fb228f6.1166141607.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34448>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0iI-00072C-9f for gcvg-git@gmane.org; Fri, 15 Dec
 2006 01:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752059AbWLOAN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 19:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWLOAN7
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 19:13:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44243 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752055AbWLOAN6 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 19:13:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gv0hu-0007JB-7U; Thu, 14 Dec 2006 19:13:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1C54720FB65; Thu, 14 Dec 2006 19:13:55 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Now that 'git add' is considered a first-class UI for 'update-index'
and that the git add documentation states "Even modified files must
be added to the set of changes about to be committed" we should
make the output of 'git status' align with that documentation and
common usage.

So now we see a status output such as:

  # Added but not yet committed:
  #   (will commit)
  #
  #       new file: x
  #
  # Changed but not added:
  #   (use "git add" on files to include for commit)
  #
  #       modified:   x
  #
  # Untracked files:
  #   (use "git add" on files to include for commit)
  #
  #       y

which just reads better in the context of using 'git add' to
manipulate a commit (and not a checkin, whatever the heck that is).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-runstatus.txt |    6 +++---
 Documentation/git-status.txt    |    6 +++---
 Documentation/tutorial-2.txt    |   10 +++++-----
 wt-status.c                     |    4 ++--
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-runstatus.txt b/Documentation/git-runstatus.txt
index 89d7b92..e76ef05 100644
--- a/Documentation/git-runstatus.txt
+++ b/Documentation/git-runstatus.txt
@@ -16,9 +16,9 @@ DESCRIPTION
 Examines paths in the working tree that has changes unrecorded
 to the index file, and changes between the index file and the
 current HEAD commit.  The former paths are what you _could_
-commit by running 'git-update-index' before running 'git
-commit', and the latter paths are what you _would_ commit by
-running 'git commit'.
+commit by running 'git-add' before running 'git commit', and
+the latter paths are what you _would_ commit by running
+'git commit'.
 
 If there is no path that is different between the index file and
 the current HEAD commit, the command exits with non-zero status.
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index ce7857e..0dd9136 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -15,9 +15,9 @@ DESCRIPTION
 Examines paths in the working tree that has changes unrecorded
 to the index file, and changes between the index file and the
 current HEAD commit.  The former paths are what you _could_
-commit by running 'git-update-index' before running 'git
-commit', and the latter paths are what you _would_ commit by
-running 'git commit'.
+commit by running 'git-add' before running 'git commit', and
+the latter paths are what you _would_ commit by running
+'git commit'.
 
 If there is no path that is different between the index file and
 the current HEAD commit, the command exits with non-zero
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index f7f2e1c..918a562 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -341,23 +341,23 @@ situation:
 ------------------------------------------------
 $ git status
 #
-# Updated but not checked in:
+# Added but not yet committed:
 #   (will commit)
 #
 #       new file: closing.txt
 #
 #
-# Changed but not updated:
-#   (use git-update-index to mark for commit)
+# Changed but not added:
+#   (use "git add" on files to include for commit)
 #
 #       modified: file.txt
 #
 ------------------------------------------------
 
 Since the current state of closing.txt is cached in the index file,
-it is listed as "updated but not checked in".  Since file.txt has
+it is listed as "added but not yet committed".  Since file.txt has
 changes in the working directory that aren't reflected in the index,
-it is marked "changed but not updated".  At this point, running "git
+it is marked "changed but not added".  At this point, running "git
 commit" would create a commit that added closing.txt (with its new
 contents), but that didn't modify file.txt.
 
diff --git a/wt-status.c b/wt-status.c
index f9ed54f..8cc4d5d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -162,7 +162,7 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
 {
 	int i;
 	if (q->nr)
-		wt_status_print_header("Changed but not updated",
+		wt_status_print_header("Changed but not added",
 				"use \"git add\" on files to include for commit");
 	for (i = 0; i < q->nr; i++)
 		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
@@ -178,7 +178,7 @@ void wt_status_print_initial(struct wt_status *s)
 	read_cache();
 	if (active_nr) {
 		s->commitable = 1;
-		wt_status_print_header("Updated but not checked in",
+		wt_status_print_header("Added but not yet committed",
 				"will commit");
 	}
 	for (i = 0; i < active_nr; i++) {
-- 
