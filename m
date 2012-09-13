From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/6] t7810-grep: test multiple --grep with and without --all-match
Date: Thu, 13 Sep 2012 16:04:40 +0200
Message-ID: <4a63f5bb100308e476c387e97b8e1fb64483d1a2.1347544259.git.git@drmicha.warpmail.net>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 16:05:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCA2M-0006kX-7K
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 16:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529Ab2IMOEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 10:04:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36519 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755135Ab2IMOEu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 10:04:50 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4773E20B12;
	Thu, 13 Sep 2012 10:04:49 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 13 Sep 2012 10:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=ds
	4owd608CxoDZBKwObih6I+tLA=; b=puAoAucT3sRmIzhfJrjqYOD5DpLGrIwOQM
	LpyNsG8VPAL7w1Oj/79J3SSMFcMSt0ULQJw/5mIQBdKBlUbMLrf2GnglqCnn4np5
	ETCR88qU5XKxacMeIv/2Jp9dOON/ijI5b4hd8yFAOPXHKmJ0Iof9cpvDPhCUFtN+
	OjUmq/HgI=
X-Sasl-enc: OAQ5DYO4YdAtRmtcSps9PPnpn2oerUT0muqXx+7sPUkE 1347545088
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BC3674837F8;
	Thu, 13 Sep 2012 10:04:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.463.gbd9d638
In-Reply-To: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347544259.git.git@drmicha.warpmail.net>
References: <cover.1347544259.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205376>


Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7810-grep.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 9b683ac..1db3dcb 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -546,6 +546,22 @@ test_expect_success 'log grep (6)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log with multiple --grep uses union' '
+	git log --grep=i --grep=r --format=%s >actual &&
+	{
+		echo fourth && echo third && echo initial
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --all-match with multiple --grep uses intersection' '
+	git log --all-match --grep=i --grep=r --format=%s >actual &&
+	{
+		echo third
+	} >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log --grep --author implicitly uses all-match' '
 	# grep matches initial and second but not third
 	# author matches only initial and third
-- 
1.7.12.463.gbd9d638
