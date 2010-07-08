From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t9118: avoid PEG revision identifier in tests
Date: Thu,  8 Jul 2010 21:16:35 +0200
Message-ID: <2f9f1bd8efb818456fcc386f419fc17f4e435e19.1278616418.git.git@drmicha.warpmail.net>
References: <4C361EB5.7010704@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Torsten Schmutzler <git-ts@theblacksun.eu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 21:16:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwaG-0002Xf-KP
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394Ab0GHTQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 15:16:27 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33156 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756929Ab0GHTQ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 15:16:26 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 44E5916525A;
	Thu,  8 Jul 2010 15:16:26 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 08 Jul 2010 15:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=lQAlJ/0LYEbZkdGy17nC7pghj2s=; b=PSnZOr5rpbGWt9RlxfQvr8meAqGJqEz1mdye2UBWm5jADVXRGzz4p5rXwXa+e7WEMlq7o4ja57Y9Ken0fSs6NchbmYFMaM8cxTELwBaMwOndBucZ9aMM88qY1BThjfarPVoOCFruKTBAee9k7gFKY+qvtxZ2B7OkPBonnx9VcUo=
X-Sasl-enc: ykCpaTh9ROWWpMAx7jWsQX/Td53y8K1zlI6GlE79i/8r 1278616585
Received: from localhost (p54859B9B.dip0.t-ipconnect.de [84.133.155.155])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7EDF92B458;
	Thu,  8 Jul 2010 15:16:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.rc1.212.g850a
In-Reply-To: <4C361EB5.7010704@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150599>

@ is SVN's identifier for PEG revisions. But SVN's treatment of PEG
identifiers in copy target URLs changed in r954995/r952973, i.e. between
1.6.11 and 1.6.12. They get eaten now (which is considered the right
way).

Therefore, avoid the @ in the tests with funky branch names.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This version is tested with svn 1.6.9 and 1.6.12.

 t/t9118-git-svn-funky-branch-names.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 7d7acc3..45d5b2d 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup svnrepo' '
 	svn_cmd cp -m "trailing .lock" "$svnrepo/pr ject/trunk" \
 			"$svnrepo/pr ject/branches/trailing_dotlock.lock" &&
 	svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
-			"$svnrepo/pr ject/branches/not-a@{0}reflog" &&
+			"$svnrepo/pr ject/branches/not-a%40{0}reflog" &&
 	start_httpd
 	'
 
-- 
1.7.2.rc1.212.g850a
