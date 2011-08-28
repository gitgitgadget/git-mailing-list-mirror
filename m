From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 1/5] t6040: test branch -vv
Date: Sun, 28 Aug 2011 16:54:28 +0200
Message-ID: <5632527678d4e5ab5d6e7890e6620e663aa7e484.1314543252.git.git@drmicha.warpmail.net>
References: <cover.1314367414.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 16:54:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qxgl7-0008Rv-P4
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 16:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab1H1Oyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 10:54:44 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58008 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751279Ab1H1Oyj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 10:54:39 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0A37820EF1;
	Sun, 28 Aug 2011 10:54:38 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 28 Aug 2011 10:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=nv
	5BBAdCJrQwCTSBw1BV1iiLNzs=; b=AiAMhZAlgrrMmEt2Sa2KDfcVK/5TfAkbnC
	Yv0Zsjrpin1b9nb/LUcvQzZU6x6YORS7kzc78fLreZWcPCmxmzTmuatdLPZ/EMoL
	NHeNJ3+NKxXuuNn8CbUjhPZwLC5XtYgiNwSeLHSs3gqBuA1PSPNhRNAvN38UJTFK
	d87AaO11E=
X-Sasl-enc: /bfC53IMBGJ8TJQ1+Q+q8yzaqNlAxdgDaedy27YjPdeY 1314543277
Received: from localhost (p54859364.dip0.t-ipconnect.de [84.133.147.100])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 508D0A00251;
	Sun, 28 Aug 2011 10:54:37 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <cover.1314367414.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1314543252.git.git@drmicha.warpmail.net>
References: <cover.1314543252.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180269>

t6040 has a test for 'git branch -v' but not for 'git branch -vv'.
Add one.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6040-tracking-info.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 19de5b1..19272bc 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -51,6 +51,22 @@ test_expect_success 'branch -v' '
 	test_i18ncmp expect actual
 '
 
+cat >expect <<\EOF
+b1 origin/master: ahead 1, behind 1
+b2 origin/master: ahead 1, behind 1
+b3 origin/master: behind 1
+b4 origin/master: ahead 2
+EOF
+
+test_expect_success 'branch -vv' '
+	(
+		cd test &&
+		git branch -vv
+	) |
+	sed -n -e "$script" >actual &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'checkout' '
 	(
 		cd test && git checkout b1
-- 
1.7.6.845.gc3c05
