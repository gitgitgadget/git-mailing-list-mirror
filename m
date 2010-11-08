From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t1020-subdirectory: test alias expansion in a subdirectory
Date: Mon,  8 Nov 2010 09:32:03 +0100
Message-ID: <627dc7921dc64a16063e77d542cf9edb22631ddd.1289205059.git.git@drmicha.warpmail.net>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 09:34:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFNAt-0005R7-32
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 09:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab0KHIdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 03:33:54 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:45234 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753453Ab0KHIdx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 03:33:53 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E2C923BA;
	Mon,  8 Nov 2010 03:33:52 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 08 Nov 2010 03:33:52 -0500
X-Sasl-enc: KSnJRkU4TcGQEeXO07ewmaZffrm6tsMC9wRC9/3z2HCf 1289205232
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 630444091AE;
	Mon,  8 Nov 2010 03:33:52 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160914>

Add a test for alias expansion in a subdirectory of the worktree.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

---
    65f3a9e (Remove all logic from get_git_work_tree(), 2010-11-01) breaks this test,
    which is why I am adding it.
    
    In fact, we don't really have tests for alias expansion at all, but that's a different issue.

 t/t1020-subdirectory.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index a3ac338..1fd187c 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -110,6 +110,14 @@ test_expect_success 'read-tree' '
 	)
 '
 
+test_expect_success 'alias expansion' '
+	(
+		git config alias.ss status &&
+		cd dir &&
+		git status &&
+		git ss
+	)
+'
 test_expect_success 'no file/rev ambiguity check inside .git' '
 	git commit -a -m 1 &&
 	(
-- 
1.7.3.2.193.g78bbb
