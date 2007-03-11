From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 5/6] user-manual: fix rendering of history diagrams
Date: Sat, 10 Mar 2007 23:35:30 -0500
Message-ID: <1173587735398-git-send-email-bfields@citi.umich.edu>
References: <7vr6s42xgm.fsf@assigned-by-dhcp.cox.net> <11735877311383-git-send-email-bfields@citi.umich.edu> <11735877321525-git-send-email-bfields@citi.umich.edu> <11735877332438-git-send-email-bfields@citi.umich.edu> <11735877331883-git-send-email-bfields@citi.umich.edu> <11735877343565-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 05:36:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQFmt-0000sT-Dy
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 05:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933113AbXCKEfr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 23:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933122AbXCKEfr
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 23:35:47 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50450
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933113AbXCKEfn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 23:35:43 -0500
Received: from pad.fieldses.org (pad.fieldses.org [127.0.0.1])
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l2B4ZeRM022237;
	Sat, 10 Mar 2007 23:35:40 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l2B4ZZqo022236;
	Sat, 10 Mar 2007 23:35:35 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <11735877343565-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41908>

From: J. Bruce Fields <bfields@citi.umich.edu>

Asciidoc appears to interpret a backslash at the end of a line as
escaping the end-of-line character, which screws up the display of
history diagrams like

 o--o--o
	\
	 o--...

The obvious fix (replacing "\" by "\\") doesn't work.  The only
workaround I've found is to include all such diagrams in a LiteralBlock.
Asciidoc claims that should be equivalent to a literal paragraph, so I
don't understand why the difference--perhaps it's an asciidoc bug.

Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1e151b4..0919574 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -437,11 +437,14 @@ We will sometimes represent git history using diagrams like the one
 below.  Commits are shown as "o", and the links between them with
 lines drawn with - / and \.  Time goes left to right:
 
+
+................................................
          o--o--o <-- Branch A
         /
  o--o--o <-- master
         \
          o--o--o <-- Branch B
+................................................
 
 If we need to talk about a particular commit, the character "o" may
 be replaced with another letter or number.
@@ -1928,25 +1931,29 @@ $ git commit
 You have performed no merges into mywork, so it is just a simple linear
 sequence of patches on top of "origin":
 
-
+................................................
  o--o--o <-- origin
         \
          o--o--o <-- mywork
+................................................
 
 Some more interesting work has been done in the upstream project, and
 "origin" has advanced:
 
+................................................
  o--o--O--o--o--o <-- origin
         \
          a--b--c <-- mywork
+................................................
 
 At this point, you could use "pull" to merge your changes back in;
 the result would create a new merge commit, like this:
 
-
+................................................
  o--o--O--o--o--o <-- origin
         \        \
          a--b--c--m <-- mywork
+................................................
  
 However, if you prefer to keep the history in mywork a simple series of
 commits without any merges, you may instead choose to use
@@ -1963,9 +1970,11 @@ point at the latest version of origin, then apply each of the saved
 patches to the new mywork.  The result will look like:
 
 
+................................................
  o--o--O--o--o--o <-- origin
 		 \
 		  a'--b'--c' <-- mywork
+................................................
 
 In the process, it may discover conflicts.  In that case it will stop
 and allow you to fix the conflicts; after fixing conflicts, use "git
@@ -2073,24 +2082,30 @@ The primary problem with rewriting the history of a branch has to do
 with merging.  Suppose somebody fetches your branch and merges it into
 their branch, with a result something like this:
 
+................................................
  o--o--O--o--o--o <-- origin
         \        \
          t--t--t--m <-- their branch:
+................................................
 
 Then suppose you modify the last three commits:
 
+................................................
 	 o--o--o <-- new head of origin
 	/
  o--o--O--o--o--o <-- old head of origin
+................................................
 
 If we examined all this history together in one repository, it will
 look like:
 
+................................................
 	 o--o--o <-- new head of origin
 	/
  o--o--O--o--o--o <-- old head of origin
         \        \
          t--t--t--m <-- their branch:
+................................................
 
 Git has no way of knowing that the new head is an updated version of
 the old head; it treats this situation exactly the same as it would if
@@ -2151,9 +2166,11 @@ commit.  Git calls this process a "fast forward".
 
 A fast forward looks something like this:
 
+................................................
  o--o--o--o <-- old head of the branch
            \
             o--o--o <-- new head of the branch
+................................................
 
 
 In some cases it is possible that the new head will *not* actually be
@@ -2161,11 +2178,11 @@ a descendant of the old head.  For example, the developer may have
 realized she made a serious mistake, and decided to backtrack,
 resulting in a situation like:
 
+................................................
  o--o--o--o--a--b <-- old head of the branch
            \
             o--o--o <-- new head of the branch
-
-
+................................................
 
 In this case, "git fetch" will fail, and print out a warning.
 
-- 
1.5.0.gb75812-dirty
