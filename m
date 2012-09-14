From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 08/11] t7810-grep: test multiple --grep with and without --all-match
Date: Fri, 14 Sep 2012 11:46:40 +0200
Message-ID: <04dd784c3a4a5bce6463ee0aaf3130f6e822ba2f.1347615361.git.git@drmicha.warpmail.net>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 11:47:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCSUP-00076D-JI
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 11:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621Ab2INJrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 05:47:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46468 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754172Ab2INJq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 05:46:58 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CD59B205CB;
	Fri, 14 Sep 2012 05:46:57 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 14 Sep 2012 05:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=TB
	b5mWHD85F9tEbtqzg75DWUBm8=; b=N69UoJSujdwNltoipUdsVlJGe8aSrvZquD
	K1Bgb48wboOmGAbaWLExRUuJwr87GvFPL/bL3XGuWCZNjZvTVFZVKOvUYAeM+N1V
	7SL/aO9iDRQ6U/8dnhQ377wBpU+QhAWPkjO0/R7PNoptdvQk8Xk8rDgKlKno7Klx
	DQ+c/3J/8=
X-Sasl-enc: Sim4gwbin2GT+6B9B2JJWHC1I0Gz64iu1LacMQRoeOdA 1347616017
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 72A6548360A;
	Fri, 14 Sep 2012 05:46:57 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.592.g41e7905
In-Reply-To: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347615361.git.git@drmicha.warpmail.net>
References: <cover.1347615361.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205471>


Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7810-grep.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 180e998..b841909 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -479,6 +479,22 @@ test_expect_success 'log grep (6)' '
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
1.7.12.592.g41e7905
