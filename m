From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v2] Add reference for status letters in documentation.
Date: Sun, 02 Nov 2008 14:37:28 +0100
Message-ID: <20081102133611.6115.51449.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 14:39:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwdAj-0003CP-NI
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 14:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbYKBNhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 08:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753786AbYKBNhq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 08:37:46 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:50501 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443AbYKBNho (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 08:37:44 -0500
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 3EE6D32A6EC
	for <git@vger.kernel.org>; Sun,  2 Nov 2008 14:37:43 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 21FC132A7D7
	for <git@vger.kernel.org>; Sun,  2 Nov 2008 14:37:43 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 0885CA003
	for <git@vger.kernel.org>; Sun,  2 Nov 2008 14:37:29 +0100 (CET)
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99841>

Also fix error in diff_filepair::status documentation, and point to
the in-code reference as well as the doc.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

Since diffcore.h is for devs anyway, it is IMHO a good idea to let it
also point to the in-code doc.

 Documentation/diff-format.txt |   16 ++++++++++++++++
 diffcore.h                    |    2 +-
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 400cbb3..aafd3a3 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -46,6 +46,22 @@ That is, from the left to the right:
 . path for "dst"; only exists for C or R.
 . an LF or a NUL when '-z' option is used, to terminate the record.
 
+Possible status letters are:
+
+- A: addition of a file
+- C: copy of a file into a new one
+- D: deletion of a file
+- M: modification of the contents or mode of a file
+- R: renaming of a file
+- T: change in the type of the file
+- U: file is unmerged (you must complete the merge before it can
+be committed)
+- X: "unknown" change type (most probably a bug, please report it)
+
+Status letters C and M are always followed by a score (denoting the
+percentage of similarity between the source and target of the move or
+copy), and are the only ones to be so.
+
 <sha1> is shown as all 0's if a file is new on the filesystem
 and it is out of sync with the index.
 
diff --git a/diffcore.h b/diffcore.h
index 713cca7..5b63458 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -62,7 +62,7 @@ struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
 	unsigned short int score;
-	char status; /* M C R N D U (see Documentation/diff-format.txt) */
+	char status; /* M C R A D U etc. (see Documentation/diff-format.txt or DIFF_STATUS_* in diff.h) */
 	unsigned broken_pair : 1;
 	unsigned renamed_pair : 1;
 	unsigned is_unmerged : 1;
