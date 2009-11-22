From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2 v2] user-manual: Document that "git merge" doesn't like uncommited changes.
Date: Sun, 22 Nov 2009 23:26:18 +0100
Message-ID: <1258928778-32419-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 22 23:30:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCKwU-0005Bn-GQ
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 23:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442AbZKVW3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 17:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755420AbZKVW3u
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 17:29:50 -0500
Received: from imag.imag.fr ([129.88.30.1]:55117 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753390AbZKVW3u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 17:29:50 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nAMMQnT3022484
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 22 Nov 2009 23:26:49 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NCKtN-0004PS-Fj; Sun, 22 Nov 2009 23:26:49 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NCKtN-0008RY-Eh; Sun, 22 Nov 2009 23:26:49 +0100
X-Mailer: git-send-email 1.6.5.3.435.g5f2e3.dirty
In-Reply-To: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 22 Nov 2009 23:26:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133460>

We explain the user why uncommited changes can be problematic with merge,
and point to "commit" and "stash" for the solution. While talking about
commited Vs uncommited changes, we also make it clear that the result of
a merge is normally commited.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/user-manual.txt |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 269ec47..c09f4b2 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1183,7 +1183,23 @@ $ git merge branchname
 -------------------------------------------------
 
 merges the development in the branch "branchname" into the current
-branch.  If there are conflicts--for example, if the same file is
+branch.
+
+A merge is made by combining the changes made in "branchname" and the
+changes made up to the latest commit in your current branch since
+their histories forked. The work tree is overwritten by the result of
+the merge when this combining is done cleanly, or overwritten by a
+half-merged results when this combining results in conflicts.
+Therefore, if you have uncommitted changes touching the same files as
+the ones impacted by the merge, Git will refuse to proceed. Most of
+the time, you will want to commit your changes before you can merge,
+and if you don't, then linkgit:git-stash[1] can take these changes
+away while you're doing the merge, and reapply them afterwards.
+
+If the changes are independant enough, Git will automatically complete
+the merge and commit the result (or reuse an existing commit in case
+of <<fast-forwards,fast-forward>>, see below). On the other hand,
+if there are conflicts--for example, if the same file is
 modified in two different ways in the remote branch and the local
 branch--then you are warned; the output may look something like this:
 
@@ -1679,7 +1695,7 @@ Sharing development with others
 Getting updates with git pull
 -----------------------------
 
-After you clone a repository and make a few changes of your own, you
+After you clone a repository and commit a few changes of your own, you
 may wish to check the original repository for updates and merge them
 into your own work.
 
-- 
1.6.5.3.435.g5f2e3.dirty
