From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Make t9128-git-svn-cmd-branch pass with svn 1.4
Date: Wed,  3 Dec 2008 10:30:17 +0100
Message-ID: <1228296617-25473-1-git-send-email-git@drmicha.warpmail.net>
References: <7vbpvtj4kl.fsf@gitster.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 10:31:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7o59-0007OK-O5
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 10:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbYLCJa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 04:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbYLCJa1
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 04:30:27 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36268 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750718AbYLCJa0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 04:30:26 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A9EBF1CB0A2
	for <git@vger.kernel.org>; Wed,  3 Dec 2008 04:30:25 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 03 Dec 2008 04:30:25 -0500
X-Sasl-enc: TuXb2YogFqNj7tqie0EchjCJWsanvbpzRni6ceNZqVUi 1228296624
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ECBEB1A051;
	Wed,  3 Dec 2008 04:30:24 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1
In-Reply-To: <7vbpvtj4kl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102233>

The copy command in svn 1.4 allows only one source (svn copy A D), whereas
the copy command in svn 1.5 allows multiple sources (svn copy A B C D).
This patch rewrites t9128 to use the backwards compatible form.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t9128-git-svn-cmd-branch.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t9128-git-svn-cmd-branch.sh b/t/t9128-git-svn-cmd-branch.sh
index e2b6696..252daa7 100755
--- a/t/t9128-git-svn-cmd-branch.sh
+++ b/t/t9128-git-svn-cmd-branch.sh
@@ -61,7 +61,9 @@ test_expect_success 'branch uses correct svn-remote' '
 	cd svn &&
 	mkdir mirror &&
 	svn add mirror &&
-	svn copy trunk tags branches mirror/ &&
+	svn copy trunk mirror/ &&
+	svn copy tags mirror/ &&
+	svn copy branches mirror/ &&
 	svn ci -m "made mirror" ) &&
 	rm -rf svn &&
 	git svn init -s -R mirror --prefix=mirror/ "$svnrepo"/mirror &&
-- 
1.6.1.rc1
