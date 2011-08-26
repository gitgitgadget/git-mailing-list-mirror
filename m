From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/5] t6040: test branch -vv
Date: Fri, 26 Aug 2011 16:05:11 +0200
Message-ID: <5632527678d4e5ab5d6e7890e6620e663aa7e484.1314367414.git.git@drmicha.warpmail.net>
References: <20110825175301.GC519@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 16:05:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwx2C-0007RU-WE
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 16:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134Ab1HZOFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 10:05:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36124 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755126Ab1HZOFU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 10:05:20 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 12F81207ED;
	Fri, 26 Aug 2011 10:05:20 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 26 Aug 2011 10:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=nv
	5BBAdCJrQwCTSBw1BV1iiLNzs=; b=RFQvT2t2Rq2Ll7UDhcxhWPc92UT/HbKwaU
	bVG26lghXyD3QBfCn7pE2h/AErecEDBYhwKTUmNwGTmsigGUf/dkGyM3qDx8iEYa
	Fz6wOwrYjNK8otfgfIL+xWF0vRkNvMxjA1zqZbnf01Uj/KJGkGrGN1irjYfGGAQ8
	kMEWsdMZ0=
X-Sasl-enc: mf7f7SjjDAcI59tjWH5Oz6nGiNwJTlMR5mekrmg+ijNG 1314367519
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 898D1B00093;
	Fri, 26 Aug 2011 10:05:19 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <20110825175301.GC519@sigill.intra.peff.net>
In-Reply-To: <cover.1314367414.git.git@drmicha.warpmail.net>
References: <cover.1314367414.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180165>

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
