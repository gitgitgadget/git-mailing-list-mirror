From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 3/5] Documentation/reset: promote 'examples' one section up
Date: Fri, 16 Jul 2010 11:44:40 +0200
Message-ID: <a9c412a9659828ae32c970f78b78d735b338e8d2.1279273256.git.trast@student.ethz.ch>
References: <cover.1279273256.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 16 11:45:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZhTx-0000OW-W8
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 11:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868Ab0GPJpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 05:45:09 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:43493 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964858Ab0GPJpG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 05:45:06 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Jul
 2010 11:45:03 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 16 Jul
 2010 11:44:43 +0200
X-Mailer: git-send-email 1.7.2.rc3.259.g43154
In-Reply-To: <cover.1279273256.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151142>

Move the examples section upwards, before the discussion that gives
the gory details.  Adjust the style of the heading accordingly.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-reset.txt |  216 ++++++++++++++++++++++---------------------
 1 files changed, 109 insertions(+), 107 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 46b2d2a..41edf41 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -82,113 +82,7 @@ OPTIONS
 	Be quiet, only report errors.
 
 
-DISCUSSION
-----------
-
-The tables below show what happens when running:
-
-----------
-git reset --option target
-----------
-
-to reset the HEAD to another commit (`target`) with the different
-reset options depending on the state of the files.
-
-In these tables, A, B, C and D are some different states of a
-file. For example, the first line of the first table means that if a
-file is in state A in the working tree, in state B in the index, in
-state C in HEAD and in state D in the target, then "git reset --soft
-target" will put the file in state A in the working tree, in state B
-in the index and in state D in HEAD.
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       A       B     C    D     --soft   A       B     D
-				--mixed  A       D     D
-				--hard   D       D     D
-				--merge (disallowed)
-				--keep  (disallowed)
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       A       B     C    C     --soft   A       B     C
-				--mixed  A       C     C
-				--hard   C       C     C
-				--merge (disallowed)
-				--keep   A       C     C
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       B       B     C    D     --soft   B       B     D
-				--mixed  B       D     D
-				--hard   D       D     D
-				--merge  D       D     D
-				--keep  (disallowed)
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       B       B     C    C     --soft   B       B     C
-				--mixed  B       C     C
-				--hard   C       C     C
-				--merge  C       C     C
-				--keep   B       C     C
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       B       C     C    D     --soft   B       C     D
-				--mixed  B       D     D
-				--hard   D       D     D
-				--merge (disallowed)
-				--keep  (disallowed)
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       B       C     C    C     --soft   B       C     C
-				--mixed  B       C     C
-				--hard   C       C     C
-				--merge  B       C     C
-				--keep   B       C     C
-
-"reset --merge" is meant to be used when resetting out of a conflicted
-merge. Any mergy operation guarantees that the work tree file that is
-involved in the merge does not have local change wrt the index before
-it starts, and that it writes the result out to the work tree. So if
-we see some difference between the index and the target and also
-between the index and the work tree, then it means that we are not
-resetting out from a state that a mergy operation left after failing
-with a conflict. That is why we disallow --merge option in this case.
-
-"reset --keep" is meant to be used when removing some of the last
-commits in the current branch while keeping changes in the working
-tree. If there could be conflicts between the changes in the commit we
-want to remove and the changes in the working tree we want to keep,
-the reset is disallowed. That's why it is disallowed if there are both
-changes between the working tree and HEAD, and between HEAD and the
-target. To be safe, it is also disallowed when there are unmerged
-entries.
-
-The following tables show what happens when there are unmerged
-entries:
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       X       U     A    B     --soft  (disallowed)
-				--mixed  X       B     B
-				--hard   B       B     B
-				--merge  B       B     B
-				--keep  (disallowed)
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       X       U     A    A     --soft  (disallowed)
-				--mixed  X       A     A
-				--hard   A       A     A
-				--merge  A       A     A
-				--keep  (disallowed)
-
-X means any state and U means an unmerged index.
-
-Examples
+EXAMPLES
 --------
 
 Undo a commit and redo::
@@ -382,6 +276,114 @@ $ git reset --keep start                    <3>
 <3> But you can use "reset --keep" to remove the unwanted commit after
     you switched to "branch2".
 
+
+DISCUSSION
+----------
+
+The tables below show what happens when running:
+
+----------
+git reset --option target
+----------
+
+to reset the HEAD to another commit (`target`) with the different
+reset options depending on the state of the files.
+
+In these tables, A, B, C and D are some different states of a
+file. For example, the first line of the first table means that if a
+file is in state A in the working tree, in state B in the index, in
+state C in HEAD and in state D in the target, then "git reset --soft
+target" will put the file in state A in the working tree, in state B
+in the index and in state D in HEAD.
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       A       B     C    D     --soft   A       B     D
+				--mixed  A       D     D
+				--hard   D       D     D
+				--merge (disallowed)
+				--keep  (disallowed)
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       A       B     C    C     --soft   A       B     C
+				--mixed  A       C     C
+				--hard   C       C     C
+				--merge (disallowed)
+				--keep   A       C     C
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       B       B     C    D     --soft   B       B     D
+				--mixed  B       D     D
+				--hard   D       D     D
+				--merge  D       D     D
+				--keep  (disallowed)
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       B       B     C    C     --soft   B       B     C
+				--mixed  B       C     C
+				--hard   C       C     C
+				--merge  C       C     C
+				--keep   B       C     C
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       B       C     C    D     --soft   B       C     D
+				--mixed  B       D     D
+				--hard   D       D     D
+				--merge (disallowed)
+				--keep  (disallowed)
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       B       C     C    C     --soft   B       C     C
+				--mixed  B       C     C
+				--hard   C       C     C
+				--merge  B       C     C
+				--keep   B       C     C
+
+"reset --merge" is meant to be used when resetting out of a conflicted
+merge. Any mergy operation guarantees that the work tree file that is
+involved in the merge does not have local change wrt the index before
+it starts, and that it writes the result out to the work tree. So if
+we see some difference between the index and the target and also
+between the index and the work tree, then it means that we are not
+resetting out from a state that a mergy operation left after failing
+with a conflict. That is why we disallow --merge option in this case.
+
+"reset --keep" is meant to be used when removing some of the last
+commits in the current branch while keeping changes in the working
+tree. If there could be conflicts between the changes in the commit we
+want to remove and the changes in the working tree we want to keep,
+the reset is disallowed. That's why it is disallowed if there are both
+changes between the working tree and HEAD, and between HEAD and the
+target. To be safe, it is also disallowed when there are unmerged
+entries.
+
+The following tables show what happens when there are unmerged
+entries:
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       X       U     A    B     --soft  (disallowed)
+				--mixed  X       B     B
+				--hard   B       B     B
+				--merge  B       B     B
+				--keep  (disallowed)
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       X       U     A    A     --soft  (disallowed)
+				--mixed  X       A     A
+				--hard   A       A     A
+				--merge  A       A     A
+				--keep  (disallowed)
+
+X means any state and U means an unmerged index.
+
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com> and Linus Torvalds <torvalds@osdl.org>
-- 
1.7.2.rc3.259.g43154
