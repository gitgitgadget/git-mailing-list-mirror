From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] Documentation/git-read-tree: clarify 2-tree merge
Date: Mon, 15 Mar 2010 11:54:46 +0100
Message-ID: <21871a4ad4a908765851d8854a8190fa16d944b8.1268650319.git.git@drmicha.warpmail.net>
References: <8c627c4f1003131432g26598d22m9795177ab56a463e@mail.gmail.com>
Cc: Christian Halstrick <christian.halstrick@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 11:57:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr7zQ-0002er-CK
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 11:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935976Ab0COK5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 06:57:37 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53469 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934377Ab0COK53 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 06:57:29 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4ADA9E4C9A;
	Mon, 15 Mar 2010 06:57:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 15 Mar 2010 06:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=9Gcvj05ugqhjUPh/+5cW/S1xHr0=; b=dPgVG1PGqZRP5ShT7KKYAxAQ/Ymqla61TTVaDPXm+lqETsnqyTnZovEZL2+pqiYl4KMsWy3qSqQJQS7q/6yGtjjvqMK7C35pUTD9gyNt7NjhdG/tC231H6iv8aZyTs0MPyAI4Ar1Nx5vexGqFbuxoWxpf8Q4a8RvTbZwxNBCRPk=
X-Sasl-enc: W5emilPrsInCcttcQ1JH2c56CmNT0GN3EdknCpeNCok9 1268650648
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8958420B51;
	Mon, 15 Mar 2010 06:57:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.1.300.gd855a
In-Reply-To: <8c627c4f1003131432g26598d22m9795177ab56a463e@mail.gmail.com>
In-Reply-To: <5fb2461fbc5266c8be5ba09c4d74b621c718374e.1268650319.git.git@drmicha.warpmail.net>
References: <5fb2461fbc5266c8be5ba09c4d74b621c718374e.1268650319.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142202>

Clarify the description of the 2-tree merge by defining the terms
which are used in the table, and by applying some small linguistic
changes.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-read-tree.txt |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 5aaf0d5..88b20e3 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -130,7 +130,7 @@ Single Tree Merge
 ~~~~~~~~~~~~~~~~~
 If only 1 tree is specified, 'git read-tree' operates as if the user did not
 specify `-m`, except that if the original index has an entry for a
-given pathname, and the contents of the path matches with the tree
+given pathname, and the contents of the path match with the tree
 being read, the stat info from the index is used. (In other words, the
 index's stat()s take precedence over the merged tree's).
 
@@ -154,22 +154,24 @@ When two trees are specified, the user is telling 'git read-tree'
 the following:
 
      1. The current index and work tree is derived from $H, but
-        the user may have local changes in them since $H;
+        the user may have local changes in them since $H.
 
      2. The user wants to fast-forward to $M.
 
 In this case, the `git read-tree -m $H $M` command makes sure
 that no local change is lost as the result of this "merge".
-Here are the "carry forward" rules:
+Here are the "carry forward" rules, where "I" denotes the index,
+"clean" means that index and work tree coincide, and "exists"/"nothing"
+refer to the presence of a path in the specified commit:
 
-        I (index)           H        M        Result
+        I                   H        M        Result
        -------------------------------------------------------
      0  nothing             nothing  nothing  (does not happen)
      1  nothing             nothing  exists   use M
      2  nothing             exists   nothing  remove path from index
-     3  nothing             exists   exists,  use M if "initial checkout"
+     3  nothing             exists   exists,  use M if "initial checkout",
 				     H == M   keep index otherwise
-				     exists   fail
+				     exists,  fail
 				     H != M
 
         clean I==H  I==M
@@ -187,7 +189,7 @@ Here are the "carry forward" rules:
      12 yes   no    N/A     exists   nothing  fail
      13 no    no    N/A     exists   nothing  fail
 
-        clean (H=M)
+        clean (H==M)
        ------
      14 yes                 exists   exists   keep index
      15 no                  exists   exists   keep index
@@ -202,26 +204,26 @@ Here are the "carry forward" rules:
      21 no    yes   no      exists   exists   fail
 
 In all "keep index" cases, the index entry stays as in the
-original index file.  If the entry were not up to date,
+original index file.  If the entry is not up to date,
 'git read-tree' keeps the copy in the work tree intact when
 operating under the -u flag.
 
 When this form of 'git read-tree' returns successfully, you can
-see what "local changes" you made are carried forward by running
+see which of the "local changes" that you made were carried forward by running
 `git diff-index --cached $M`.  Note that this does not
-necessarily match `git diff-index --cached $H` would have
+necessarily match what `git diff-index --cached $H` would have
 produced before such a two tree merge.  This is because of cases
 18 and 19 --- if you already had the changes in $M (e.g. maybe
 you picked it up via e-mail in a patch form), `git diff-index
 --cached $H` would have told you about the change before this
 merge, but it would not show in `git diff-index --cached $M`
-output after two-tree merge.
+output after the two-tree merge.
 
-Case #3 is slightly tricky and needs explanation.  The result from this
+Case 3 is slightly tricky and needs explanation.  The result from this
 rule logically should be to remove the path if the user staged the removal
 of the path and then switching to a new branch.  That however will prevent
 the initial checkout from happening, so the rule is modified to use M (new
-tree) only when the contents of the index is empty.  Otherwise the removal
+tree) only when the content of the index is empty.  Otherwise the removal
 of the path is kept as long as $H and $M are the same.
 
 3-Way Merge
-- 
1.7.0.1.300.gd855a
