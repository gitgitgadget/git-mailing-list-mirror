From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 5/7] user-manual: detached HEAD
Date: Mon, 16 Apr 2007 00:37:14 -0400
Message-ID: <7738.93939699537$1176698260@news.gmane.org>
References: <11766982362087-git-send-email->
 <11766982361830-git-send-email->
 <1176698236722-git-send-email->
 <11766982363767-git-send-email->
 <11766982363276-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 06:37:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdIy4-0008Sb-Bu
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 06:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbXDPEh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 00:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754488AbXDPEh1
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 00:37:27 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36500 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbXDPEhS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 00:37:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdIxo-0005YZ-TC; Mon, 16 Apr 2007 00:37:16 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <11766982363276-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44576>

From: J. Bruce Fields <bfields@citi.umich.edu>

Add a brief mention of detached HEADs and .git/HEAD.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   44 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 49e936f..bff072f 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -495,8 +495,48 @@ git checkout -b <new> <start-point>::
 	create a new branch <new> referencing <start-point>, and
 	check it out.
 
-It is also useful to know that the special symbol "HEAD" can always
-be used to refer to the current branch.
+The special symbol "HEAD" can always be used to refer to the current
+branch.  In fact, git uses a file named "HEAD" in the .git directory to
+remember which branch is current:
+
+------------------------------------------------
+$ cat .git/HEAD
+ref: refs/heads/master
+------------------------------------------------
+
+Examining an old version without creating a new branch
+------------------------------------------------------
+
+The git-checkout command normally expects a branch head, but will also
+accept an arbitrary commit; for example, you can check out the commit
+referenced by a tag:
+
+------------------------------------------------
+$ git checkout v2.6.17
+Note: moving to "v2.6.17" which isn't a local branch
+If you want to create a new branch from this checkout, you may do so
+(now or later) by using -b with the checkout command again. Example:
+  git checkout -b <new_branch_name>
+HEAD is now at 427abfa... Linux v2.6.17
+------------------------------------------------
+
+The HEAD then refers to the SHA1 of the commit instead of to a branch,
+and git branch shows that you are no longer on a branch:
+
+------------------------------------------------
+$ cat .git/HEAD
+427abfa28afedffadfca9dd8b067eb6d36bac53f
+git branch
+* (no branch)
+  master
+------------------------------------------------
+
+In this case we say that the HEAD is "detached".
+
+This can be an easy way to check out a particular version without having
+to make up a name for a new branch.  However, keep in mind that when you
+switch away from the (for example, by checking out something else), you
+can lose track of what the HEAD used to point to.
 
 Examining branches from a remote repository
 -------------------------------------------
-- 
1.5.1.1.98.gedb4f
