From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 07/11] t7810-grep: bring log --grep tests in common form
Date: Fri, 14 Sep 2012 11:46:39 +0200
Message-ID: <83691edd7d999104649b311b98acfe5b782415f3.1347615361.git.git@drmicha.warpmail.net>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 11:47:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCSUl-0007S2-Vs
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 11:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab2INJrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 05:47:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39800 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754118Ab2INJq4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 05:46:56 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 575522007B;
	Fri, 14 Sep 2012 05:46:56 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 14 Sep 2012 05:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Ho
	6gUXhXUIe9RMuOLCMVGTCmxi4=; b=uvQH0qyIyVwVisi/cB1MSttlZrAOcu4pt/
	QoPn5AtdMQ9tEHLKZdyaYsnStT3amJ830imv1jaH5occlN40C1j5ziuQTO6vWEb7
	DBkWCXj0jtOTkgwdLtzm8O5f+ETcKbs6z4AFP72YLgAGpdpCetB69/FzBUJ+XonA
	G3KnW7XK4=
X-Sasl-enc: YGkXWR4n9osE8y27WY/U8foRM+NL9SpxE9z0Bxgj93/m 1347616015
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EEC428E03D5;
	Fri, 14 Sep 2012 05:46:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.592.g41e7905
In-Reply-To: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347615361.git.git@drmicha.warpmail.net>
References: <cover.1347615361.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205476>

The log --grep tests generate the expected out in different ways.
Make them all use command blocks so that subshells are avoided and the
expected output is easier to grasp visually.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7810-grep.sh | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 24e9b19..180e998 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -435,31 +435,41 @@ test_expect_success 'log grep setup' '
 
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
 
@@ -473,7 +483,9 @@ test_expect_success 'log --grep --author implicitly uses all-match' '
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
1.7.12.592.g41e7905
