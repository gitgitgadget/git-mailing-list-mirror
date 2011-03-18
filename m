From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/3] t6009: use test_commit() from test-lib.sh
Date: Fri, 18 Mar 2011 15:50:24 +0100
Message-ID: <959b1f0c5afb87bde9fefbbe7c0b0947fb6780a7.1300459017.git.git@drmicha.warpmail.net>
References: <20110318085616.GA16703@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 15:54:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0b4A-0000wi-Ic
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 15:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821Ab1CROyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 10:54:01 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55494 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862Ab1CROx6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 10:53:58 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 20D6B20872;
	Fri, 18 Mar 2011 10:53:58 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 18 Mar 2011 10:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=FLSlRf7hbztYJqDQB1xTfLSSmWw=; b=sOqJP3iEMywP2S+fpBtSndAKQ492agl8X4Yz6eKtCrDhrRLYQddKeZjr4a1VXLd2YPMl02Cobcw4BthU1fM/QaINrpt3Hd5A/Uuh/RPU1KVvXwIzR+lv9D8S0bmgLEIPPr22jAqGVRRrC9bhjvSUi43SDAoVTQt5eQta3w6fqrY=
X-Sasl-enc: NvJ2acnrExXW3zGA5Baw/0Odrnj3KaU++NDID0hjfi/b 1300460037
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 97DDA441C88;
	Fri, 18 Mar 2011 10:53:57 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.464.gf81ff
In-Reply-To: <20110318085616.GA16703@sigill.intra.peff.net>
In-Reply-To: <cover.1300459016.git.git@drmicha.warpmail.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169327>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6009-rev-list-parent.sh |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 52f7b27..0f0e457 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -4,25 +4,18 @@ test_description='properly cull all ancestors'
 
 . ./test-lib.sh
 
-commit () {
-	test_tick &&
-	echo $1 >file &&
-	git commit -a -m $1 &&
-	git tag $1
-}
-
 test_expect_success setup '
 
 	touch file &&
 	git add file &&
 
-	commit one &&
+	test_commit one &&
 
 	test_tick=$(($test_tick - 2400)) &&
 
-	commit two &&
-	commit three &&
-	commit four &&
+	test_commit two &&
+	test_commit three &&
+	test_commit four &&
 
 	git log --pretty=oneline --abbrev-commit
 '
-- 
1.7.4.1.464.gf81ff
