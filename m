From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/4] t6018: make sure all tested symbolic names are different revs
Date: Thu, 13 May 2010 16:24:37 +0200
Message-ID: <48af27209549dda92ffb37a8d5186bbe5d217e54.1273760226.git.git@drmicha.warpmail.net>
References: <20100505033536.GB8779@coredump.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 16:25:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCZLP-0006Qf-Rt
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 16:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758302Ab0EMOYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 10:24:46 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56923 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757933Ab0EMOYo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 10:24:44 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 84A0EF56C9;
	Thu, 13 May 2010 10:24:44 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 13 May 2010 10:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=ma/cVPWMaAlT+fxJwgY6dngk228=; b=C+qWzrQ05HfFDExru9rMTuXj1SYgAnwAMUYFUEuQxQuG26WPxUbK8ZefQGY2fh4VEPPeku7x6zhzoX64YMQpbLZayiOtbo4lu2n8mx/pDZDqRnHkCZ1+JuugcvDPaSMP4xkSVHdAmjRHzdOY3Cjnrqvolhr4gxMSZp8RPt3SLOo=
X-Sasl-enc: +q7sXoo1tTC8B7dzfRIDs+irm1HqpVCBRqnOajJaJHx+ 1273760683
Received: from localhost (p54859DBB.dip0.t-ipconnect.de [84.133.157.187])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BD2195469F;
	Thu, 13 May 2010 10:24:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
In-Reply-To: <20100505033536.GB8779@coredump.intra.peff.net>
In-Reply-To: <cover.1273760226.git.git@drmicha.warpmail.net>
References: <cover.1273760226.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147012>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6018-rev-list-glob.sh |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index dbedc4d..a1320aa 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -34,7 +34,9 @@ test_expect_success 'setup' '
 	git checkout master &&
 	commit master2 &&
 	git tag foo/bar master &&
-	git update-ref refs/remotes/foo/baz master
+	commit master3 &&
+	git update-ref refs/remotes/foo/baz master &&
+	commit master4
 '
 
 test_expect_success 'rev-parse --glob=refs/heads/subspace/*' '
@@ -205,4 +207,16 @@ test_expect_success 'rev-list --remotes=foo' '
 
 '
 
+test_expect_success 'rev-list --locals' '
+
+	compare rev-list "master subspace-x someref other/three subspace/one subspace/two" "--localss"
+
+'
+
+test_expect_success 'rev-list --lrbranches' '
+
+	compare rev-list "master subspace-x someref other/three subspace/one subspace/two" "--lrbranches"
+
+'
+
 test_done
-- 
1.7.1.240.geeaa4d
