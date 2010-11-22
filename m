From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH] t/t9001-send-email.sh: fix '&&' chain in some tests
Date: Mon, 22 Nov 2010 13:31:49 +0100
Message-ID: <1290429109-2318-1-git-send-email-ospite@studenti.unina.it>
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 22 13:34:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKVbh-0005Oq-67
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 13:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972Ab0KVMer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 07:34:47 -0500
Received: from smtp209.alice.it ([82.57.200.105]:41985 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754244Ab0KVMer (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 07:34:47 -0500
Received: from jcn (82.60.124.113) by smtp209.alice.it (8.5.124.08)
        id 4C1A27590ABC8205; Mon, 22 Nov 2010 13:34:43 +0100
Received: from ao2 by jcn with local (Exim 4.72)
	(envelope-from <ospite@studenti.unina.it>)
	id 1PKVbW-0001Tw-3h; Mon, 22 Nov 2010 13:34:42 +0100
X-Mailer: git-send-email 1.7.2.3
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161885>

t/README recommends chaining test assertions.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Hi,

there are a couple of tests I didn't fix here, they are storing intermediate
return values, see "confirm by default (due to cc)" and following in
t/t9001-send-email.sh

I don't know if chaining is correct already there.

Thanks,
   Antonio

 t/t9001-send-email.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index d1ba252..ac1af86 100755
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
 
@@ -574,7 +574,7 @@ EOF
 "
 
 test_expect_success $PREREQ '--suppress-cc=sob' '
-	git config --unset sendemail.cccmd
+	git config --unset sendemail.cccmd &&
 	test_suppression sob
 '
 
-- 
1.7.2.3
