From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH v2] Make rebase save ORIG_HEAD if changing current branch
Date: Sun,  6 Jul 2008 04:40:58 -0400
Message-ID: <1215333658-84938-1-git-send-email-benji@silverinsanity.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 06 10:42:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFPot-00057k-E8
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 10:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbYGFIlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 04:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbYGFIlB
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 04:41:01 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:40195 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYGFIlA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 04:41:00 -0400
Received: from localhost.localdomain (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	by silverinsanity.com (Postfix) with ESMTP id 4AE131FFC021;
	Sun,  6 Jul 2008 08:40:45 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.1.324.gc55f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87506>

This makes rebase act a little more like merge when working on the
current branch.  This is particularly useful for `git pull --rebase`

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 If I followed the discussion the last time I sent this in correctly,
 the two issues were:

 - Ugly "echo > ORIG_HEAD" instead of pretty "git update-ref ORIG_HEAD"
 - Setting ORIG_HEAD at the wrong place

 Let me know if there are any other issues.

 git-rebase.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index e2d85ee..44db7e6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -434,3 +434,4 @@ do
 done
 
 finish_rb_merge
+git update-ref ORIG_HEAD $orig_head
-- 
1.5.6.1.324.gc55f7
