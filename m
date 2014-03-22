From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 05/10] t4209: use helper functions to test --author
Date: Sat, 22 Mar 2014 18:15:55 +0100
Message-ID: <1395508560-19893-6-git-send-email-l.s.r@web.de>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 18:16:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRPXM-00025U-5t
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 18:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbaCVRQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 13:16:38 -0400
Received: from mout.web.de ([212.227.15.4]:57989 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948AbaCVRQf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 13:16:35 -0400
Received: from debian.fritz.box ([79.253.149.120]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M1XE9-1XFXB43yf3-00tXGu; Sat, 22 Mar 2014 18:16:20
 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395508560-19893-1-git-send-email-l.s.r@web.de>
X-Provags-ID: V03:K0:mkToP4nC7vHk6+Ldls+5OsW6sY+18XERdzcJKXY8zSjBljSaxh/
 9h3NrTH8xHLSHcN8GoS/FVVHu5K9bGOXHuzMmGqHbtvZvSJVOwQfkW0H/3OI8cbnjvy0Rkx
 p/PFkULXamwVlv3OO/dqA9oSUHrkKKQXmeLOFii5sMfWrEuNwXPkN6OLFlqIfgi7RZdT0if
 zu8AANsQ4BFXm1Q8X0Okw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244775>

Also add tests for case sensitive and non-matching cases.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4209-log-pickaxe.sh | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 873a10e..80aabe2 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -51,15 +51,10 @@ test_log	expect_nomatch	--grep InItial
 test_log_icase	expect_initial	--grep InItial
 test_log_icase	expect_nomatch	--grep initail
 
-test_expect_success 'log --author --regexp-ignore-case' '
-	git log --regexp-ignore-case --author=person --format=%H >actual &&
-	test_cmp expect_second actual
-'
-
-test_expect_success 'log --author -i' '
-	git log -i --author=person --format=%H >actual &&
-	test_cmp expect_second actual
-'
+test_log	expect_second	--author Person
+test_log	expect_nomatch	--author person
+test_log_icase	expect_second	--author person
+test_log_icase	expect_nomatch	--author spreon
 
 test_log	expect_nomatch	-G picked
 test_log	expect_second	-G Picked
-- 
1.9.1
