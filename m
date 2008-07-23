From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] rebase -i: When an 'edit' stops, mention the commit
Date: Wed, 23 Jul 2008 09:46:35 +0200
Message-ID: <4886E1DB.7020308@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 09:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLZ4a-0007fw-8M
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 09:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbYGWHqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 03:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbYGWHqn
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 03:46:43 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:65322 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbYGWHqm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 03:46:42 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KLZ3U-0007VN-8N; Wed, 23 Jul 2008 09:46:40 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 062D56B7; Wed, 23 Jul 2008 09:46:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89608>

From: Johannes Sixt <johannes.sixt@telecom.at>

In a rebase session where more than one commit is to be 'edit'ed, and the
user spends considerable time to 'edit' a commit, it is easy to forget what
one wanted to 'edit' at the individual commits. It would be helpful to see
at which commit the rebase stopped.

Incidentally, if the rebase stopped due to merge conflicts or other errors,
the commit was already reported ("Could not apply $sha1..."), but when
rebase stopped after successfully applying an "edit" commit, it would not
mention it. With this change the commit is reported.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e63a864..4e334ba 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -277,7 +277,7 @@ do_next () {
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		make_patch $sha1
 		: > "$DOTEST"/amend
-		warn
+		warn "Stopped at $sha1... $rest"
 		warn "You can amend the commit now, with"
 		warn
 		warn "	git commit --amend"
-- 
1.6.0.rc0.956.g7bc0

	
