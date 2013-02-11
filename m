From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] git-bisect.txt: clarify that reset quits bisect
Date: Mon, 11 Feb 2013 09:35:04 +0100
Message-ID: <d679f620f10ad7afc044c9f5dadcf433b388ad10.1360571552.git.git@drmicha.warpmail.net>
References: <5118A5F2.6000007@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Mohr <andi@lisas.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 09:35:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4orL-0002Dm-3z
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 09:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab3BKIfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 03:35:06 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43256 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753396Ab3BKIfE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2013 03:35:04 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4733920BBA;
	Mon, 11 Feb 2013 03:35:03 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 11 Feb 2013 03:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=79QCDsmsZHb22zD725POzdcw5
	NU=; b=bNjTQQRp3k9xJbnMAUPOiVspQ5s1/9PefTN3PQhoq1jWO5HVBPdSsk6MK
	+/+8qq0cBfoQeo0LuCiWN1WFSPWA4kmN/GTsGqxFbgcKFpUs0+e/GOY/Bajao72B
	2TV8eDGFQ79N3vj42GYqhwXu9fia/x3kLmhAi4sjEru6Z/WznM=
X-Sasl-enc: NTuBfBG4y3Ker2W3FaFF9vm2X/oRd07qngPOKvQ5wMiD 1360571702
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B79078E00B1;
	Mon, 11 Feb 2013 03:35:02 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.752.g32d147e
In-Reply-To: <5118A5F2.6000007@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216024>

"reset" can be easily misunderstood as resetting a bisect session to its
start without finishing it. Clarify that it actually quits the bisect
session.

Reported-by: Andreas Mohr <andi@lisas.de>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-bisect.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index b4831bb..f986c5c 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -83,7 +83,7 @@ Bisect reset
 ~~~~~~~~~~~~
 
 After a bisect session, to clean up the bisection state and return to
-the original HEAD, issue the following command:
+the original HEAD (i.e., to quit bisecting), issue the following command:
 
 ------------------------------------------------
 $ git bisect reset
@@ -284,6 +284,7 @@ EXAMPLES
 ------------
 $ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
 $ git bisect run make                # "make" builds the app
+$ git bisect reset                   # quit the bisect session
 ------------
 
 * Automatically bisect a test failure between origin and HEAD:
@@ -291,6 +292,7 @@ $ git bisect run make                # "make" builds the app
 ------------
 $ git bisect start HEAD origin --    # HEAD is bad, origin is good
 $ git bisect run make test           # "make test" builds and tests
+$ git bisect reset                   # quit the bisect session
 ------------
 
 * Automatically bisect a broken test case:
@@ -302,6 +304,7 @@ make || exit 125                     # this skips broken builds
 ~/check_test_case.sh                 # does the test case pass?
 $ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
 $ git bisect run ~/test.sh
+$ git bisect reset                   # quit the bisect session
 ------------
 +
 Here we use a "test.sh" custom script. In this script, if "make"
@@ -351,6 +354,7 @@ use `git cherry-pick` instead of `git merge`.)
 ------------
 $ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
 $ git bisect run sh -c "make || exit 125; ~/check_test_case.sh"
+$ git bisect reset                   # quit the bisect session
 ------------
 +
 This shows that you can do without a run script if you write the test
@@ -368,6 +372,7 @@ $ git bisect run sh -c '
 	rm -f tmp.$$
 	test $rc = 0'
 
+$ git bisect reset                   # quit the bisect session
 ------------
 +
 In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit that
-- 
1.8.1.2.752.g32d147e
