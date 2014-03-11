From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] t7810: add missing variables to tests in loop
Date: Tue, 11 Mar 2014 22:07:58 +0100
Message-ID: <531F7B2E.20209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 22:09:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNTuy-0004rt-0T
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 22:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719AbaCKVIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 17:08:52 -0400
Received: from mout.web.de ([212.227.17.11]:53740 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755709AbaCKVIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 17:08:51 -0400
Received: from [192.168.178.27] ([79.250.161.106]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M2dg1-1XCyXQ42ir-00sPh5; Tue, 11 Mar 2014 22:08:46
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
X-Provags-ID: V03:K0:M8HDIkwQZqaND8khUBcw+uivErvtjIshhN6yoBs0YUO+Gz5aEJZ
 uO4f3olWPQHVTIdpmGv8tQYUHltKULwRBUPxKKcZL3LAJH4FdESXL5z4wH0CZzAkzuUa5E6
 ud0IpnroQzHDgm4Vm6ik5CtOKc+dicuPSIWLinRDg1LZUuO6Gy6BcbkprTbEhVW37+bPCSZ
 iKMfnh2g5fMvirdn4FOKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243899>

Some tests in t7810-grep.sh are in a loop that runs them against HEAD and
the work tree.  In order for that to work the test code should use the
variables $L (display name), $H (HEAD or empty string) and $HC (revision
prefix for result lines); otherwise tests are just repeated with the same
target.  Add the variables where they're missing and make sure the test
description is wrapped in double quotes (instead of single quotes) to
allow variables to be expanded.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t7810-grep.sh | 58 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index f698001..46aaebc 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -105,7 +105,7 @@ do
 
 	test_expect_success "grep -w $L (w)" '
 		: >expected &&
-		test_must_fail git grep -n -w -e "^w" >actual &&
+		test_must_fail git grep -n -w -e "^w" $H >actual &&
 		test_cmp expected actual
 	'
 
@@ -240,92 +240,92 @@ do
 		test_cmp expected actual
 	'
 	test_expect_success "grep $L with grep.extendedRegexp=false" '
-		echo "ab:a+bc" >expected &&
-		git -c grep.extendedRegexp=false grep "a+b*c" ab >actual &&
+		echo "${HC}ab:a+bc" >expected &&
+		git -c grep.extendedRegexp=false grep "a+b*c" $H ab >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep $L with grep.extendedRegexp=true" '
-		echo "ab:abc" >expected &&
-		git -c grep.extendedRegexp=true grep "a+b*c" ab >actual &&
+		echo "${HC}ab:abc" >expected &&
+		git -c grep.extendedRegexp=true grep "a+b*c" $H ab >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep $L with grep.patterntype=basic" '
-		echo "ab:a+bc" >expected &&
-		git -c grep.patterntype=basic grep "a+b*c" ab >actual &&
+		echo "${HC}ab:a+bc" >expected &&
+		git -c grep.patterntype=basic grep "a+b*c" $H ab >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep $L with grep.patterntype=extended" '
-		echo "ab:abc" >expected &&
-		git -c grep.patterntype=extended grep "a+b*c" ab >actual &&
+		echo "${HC}ab:abc" >expected &&
+		git -c grep.patterntype=extended grep "a+b*c" $H ab >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep $L with grep.patterntype=fixed" '
-		echo "ab:a+b*c" >expected &&
-		git -c grep.patterntype=fixed grep "a+b*c" ab >actual &&
+		echo "${HC}ab:a+b*c" >expected &&
+		git -c grep.patterntype=fixed grep "a+b*c" $H ab >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success LIBPCRE "grep $L with grep.patterntype=perl" '
-		echo "ab:a+b*c" >expected &&
-		git -c grep.patterntype=perl grep "a\x{2b}b\x{2a}c" ab >actual &&
+		echo "${HC}ab:a+b*c" >expected &&
+		git -c grep.patterntype=perl grep "a\x{2b}b\x{2a}c" $H ab >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep $L with grep.patternType=default and grep.extendedRegexp=true" '
-		echo "ab:abc" >expected &&
+		echo "${HC}ab:abc" >expected &&
 		git \
 			-c grep.patternType=default \
 			-c grep.extendedRegexp=true \
-			grep "a+b*c" ab >actual &&
+			grep "a+b*c" $H ab >actual &&
 		test_cmp expected actual
 	'
 
 	test_expect_success "grep $L with grep.extendedRegexp=true and grep.patternType=default" '
-		echo "ab:abc" >expected &&
+		echo "${HC}ab:abc" >expected &&
 		git \
 			-c grep.extendedRegexp=true \
 			-c grep.patternType=default \
-			grep "a+b*c" ab >actual &&
+			grep "a+b*c" $H ab >actual &&
 		test_cmp expected actual
 	'
 
-	test_expect_success 'grep $L with grep.patternType=extended and grep.extendedRegexp=false' '
-		echo "ab:abc" >expected &&
+	test_expect_success "grep $L with grep.patternType=extended and grep.extendedRegexp=false" '
+		echo "${HC}ab:abc" >expected &&
 		git \
 			-c grep.patternType=extended \
 			-c grep.extendedRegexp=false \
-			grep "a+b*c" ab >actual &&
+			grep "a+b*c" $H ab >actual &&
 		test_cmp expected actual
 	'
 
-	test_expect_success 'grep $L with grep.patternType=basic and grep.extendedRegexp=true' '
-		echo "ab:a+bc" >expected &&
+	test_expect_success "grep $L with grep.patternType=basic and grep.extendedRegexp=true" '
+		echo "${HC}ab:a+bc" >expected &&
 		git \
 			-c grep.patternType=basic \
 			-c grep.extendedRegexp=true \
-			grep "a+b*c" ab >actual &&
+			grep "a+b*c" $H ab >actual &&
 		test_cmp expected actual
 	'
 
-	test_expect_success 'grep $L with grep.extendedRegexp=false and grep.patternType=extended' '
-		echo "ab:abc" >expected &&
+	test_expect_success "grep $L with grep.extendedRegexp=false and grep.patternType=extended" '
+		echo "${HC}ab:abc" >expected &&
 		git \
 			-c grep.extendedRegexp=false \
 			-c grep.patternType=extended \
-			grep "a+b*c" ab >actual &&
+			grep "a+b*c" $H ab >actual &&
 		test_cmp expected actual
 	'
 
-	test_expect_success 'grep $L with grep.extendedRegexp=true and grep.patternType=basic' '
-		echo "ab:a+bc" >expected &&
+	test_expect_success "grep $L with grep.extendedRegexp=true and grep.patternType=basic" '
+		echo "${HC}ab:a+bc" >expected &&
 		git \
 			-c grep.extendedRegexp=true \
 			-c grep.patternType=basic \
-			grep "a+b*c" ab >actual &&
+			grep "a+b*c" $H ab >actual &&
 		test_cmp expected actual
 	'
 done
-- 
1.9.0
