From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] gitk: Heed the lines of context in merge commits.
Date: Wed, 13 Feb 2008 17:27:30 +0100
Message-ID: <47B31A72.7020502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 17:28:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPKSu-0003Ca-8l
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 17:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501AbYBMQ1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 11:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755814AbYBMQ1d
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 11:27:33 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:48921 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756501AbYBMQ1c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 11:27:32 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JPKRu-0007Lj-1u; Wed, 13 Feb 2008 17:27:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 78A1569F; Wed, 13 Feb 2008 17:27:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73800>

From: Johannes Sixt <johannes.sixt@telecom.at>

There is an edit box where the number of context lines can be chosen.
But it was only used when regular diffs were displayed, not for
merge commits. Fix this.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 gitk |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 7a97cc8..b20fa81 100644
--- a/gitk
+++ b/gitk
@@ -5028,13 +5028,14 @@ proc getblobline {bf id} {
 proc mergediff {id l} {
     global diffmergeid mdifffd
     global diffids
+    global diffcontext
     global parentlist
     global limitdiffs viewfiles curview

     set diffmergeid $id
     set diffids $id
     # this doesn't seem to actually affect anything...
-    set cmd [concat | git diff-tree --no-commit-id --cc $id]
+    set cmd [concat | git diff-tree --no-commit-id --cc -U$diffcontext $id]
     if {$limitdiffs && $viewfiles($curview) ne {}} {
 	set cmd [concat $cmd -- $viewfiles($curview)]
     }
-- 
1.5.4.43.gbd39-dirty
