From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH v2] t/t9001-send-email.sh: fix '&&' chain in some tests
Date: Tue,  4 Jan 2011 21:56:58 +0100
Message-ID: <1294174618-14571-1-git-send-email-ospite@studenti.unina.it>
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 22:03:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaE2I-00061r-99
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 22:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab1ADVDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 16:03:12 -0500
Received: from smtp208.alice.it ([82.57.200.104]:45031 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005Ab1ADVDM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 16:03:12 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2011 16:03:11 EST
Received: from jcn (82.57.107.216) by smtp208.alice.it (8.5.124.08)
        id 4C1A27160E5B95F6; Tue, 4 Jan 2011 21:57:02 +0100
Received: from ao2 by jcn with local (Exim 4.72)
	(envelope-from <ospite@studenti.unina.it>)
	id 1PaDwD-0003nW-9f; Tue, 04 Jan 2011 21:57:01 +0100
X-Mailer: git-send-email 1.7.2.3
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164518>

t/README recommends chaining test assertions.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Hi sorry for the delay,

the only change wrt. v1 is the use of test_might_fail with
git config --unset as requested by Jonathan.

Note that in t9001-send-email.sh and other tests git config --unset is used
without the test_might_fail handler some other times, you might wat to check
this.

Thanks and best regards,
   Antonio Ospite
   http://ao2.it

 t/t9001-send-email.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1dc4a92..ace3c78 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -265,7 +265,7 @@ test_expect_success $PREREQ 'Author From: in message body' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
-	sed "1,/^\$/d" < msgtxt1 > msgbody1
+	sed "1,/^\$/d" < msgtxt1 > msgbody1 &&
 	grep "From: A <author@example.com>" msgbody1
 '
 
@@ -276,7 +276,7 @@ test_expect_success $PREREQ 'Author From: not in message body' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
-	sed "1,/^\$/d" < msgtxt1 > msgbody1
+	sed "1,/^\$/d" < msgtxt1 > msgbody1 &&
 	! grep "From: A <author@example.com>" msgbody1
 '
 
@@ -298,7 +298,7 @@ test_expect_success $PREREQ 'Invalid In-Reply-To' '
 		--in-reply-to=" " \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches \
-		2>errors
+		2>errors &&
 	! grep "^In-Reply-To: < *>" msgtxt1
 '
 
@@ -617,7 +617,7 @@ EOF
 "
 
 test_expect_success $PREREQ '--suppress-cc=sob' '
-	git config --unset sendemail.cccmd
+	test_might_fail git config --unset sendemail.cccmd &&
 	test_suppression sob
 '
 
-- 
1.7.2.3
