From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/6] t7810-grep: bring log --grep tests in common form
Date: Thu, 13 Sep 2012 16:04:39 +0200
Message-ID: <cbc677f1acfc4d2f29d69e7f6d4b1b780f6e40dd.1347544259.git.git@drmicha.warpmail.net>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 16:04:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCA2L-0006kX-Mo
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 16:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab2IMOEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 10:04:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36686 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755164Ab2IMOEs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 10:04:48 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A433A208EC;
	Thu, 13 Sep 2012 10:04:47 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 13 Sep 2012 10:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=zR
	O6LyzV0ato/mIMBHnuOxxusIE=; b=AaW6B/ZPvSr4plh6VsE6w0ZbQ6Iv/yd0w3
	dBUt70nEHvptIYkT4lDqgH70nn6wQug7fhcuaS/tCUqakjznJSEDwTdGQfZedq/R
	YIDc+RyIBG87TdchkqAkJjGQP5psJfPDDxrAQM52xFWbYhiE4D9NyxCU89YXpxrI
	djLqVaCZ4=
X-Sasl-enc: qOj39OUaxGNPPQQgRBghJWED8s550S9vGLnxX+b3CgeA 1347545087
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3E4028E01C8;
	Thu, 13 Sep 2012 10:04:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.463.gbd9d638
In-Reply-To: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347544259.git.git@drmicha.warpmail.net>
References: <cover.1347544259.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205375>

The log --grep tests generate the expected out in different ways.
Make them all use command blocks so that subshells are avoided and the
expected output is easier to grasp visually.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7810-grep.sh | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 35d357d..9b683ac 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -502,31 +502,41 @@ test_expect_success 'log grep setup' '
 
 test_expect_success 'log grep (1)' '
 	git log --author=author --pretty=tformat:%s >actual &&
-	( echo third ; echo initial ) >expect &&
+	{
+		echo third && echo initial
+	} >expect &&
 	test_cmp expect actual
 '
 
 test_expect_success 'log grep (2)' '
 	git log --author=" * " -F --pretty=tformat:%s >actual &&
-	( echo second ) >expect &&
+	{
+		echo second
+	} >expect &&
 	test_cmp expect actual
 '
 
 test_expect_success 'log grep (3)' '
 	git log --author="^A U" --pretty=tformat:%s >actual &&
-	( echo third ; echo initial ) >expect &&
+	{
+		echo third && echo initial
+	} >expect &&
 	test_cmp expect actual
 '
 
 test_expect_success 'log grep (4)' '
 	git log --author="frotz\.com>$" --pretty=tformat:%s >actual &&
-	( echo second ) >expect &&
+	{
+		echo second
+	} >expect &&
 	test_cmp expect actual
 '
 
 test_expect_success 'log grep (5)' '
 	git log --author=Thor -F --pretty=tformat:%s >actual &&
-	( echo third ; echo initial ) >expect &&
+	{
+		echo third && echo initial
+	} >expect &&
 	test_cmp expect actual
 '
 
@@ -540,7 +550,9 @@ test_expect_success 'log --grep --author implicitly uses all-match' '
 	# grep matches initial and second but not third
 	# author matches only initial and third
 	git log --author="A U Thor" --grep=s --grep=l --format=%s >actual &&
-	echo initial >expect &&
+	{
+		echo initial
+	} >expect &&
 	test_cmp expect actual
 '
 
-- 
1.7.12.463.gbd9d638
