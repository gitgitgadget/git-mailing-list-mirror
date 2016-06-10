From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/6] t1404: remove "prefix" argument to test_update_rejected
Date: Fri, 10 Jun 2016 10:14:45 +0200
Message-ID: <cd193d74753c0c5e34995dc5c1df1e8881ba5bcb.1465544913.git.mhagger@alum.mit.edu>
References: <cover.1465544913.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, David Turner <novalis@novalis.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 10:15:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBHbF-0001ft-IJ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 10:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbcFJIPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 04:15:14 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63207 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751068AbcFJIPA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 04:15:00 -0400
X-AuditID: 1207440c-c53ff70000000b85-f6-575a7702cbaa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 7F.2A.02949.2077A575; Fri, 10 Jun 2016 04:14:58 -0400 (EDT)
Received: from michael.fritz.box (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5A8EpD4028943
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 04:14:57 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1465544913.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqMtUHhVu8GqdgUXXlW4mi4beK8wW
	T+beZba4vWI+s8WSh6+ZLbqnvGW0+NHSw+zA7vH3/Qcmj52z7rJ7PHzVxe7R1X6EzeNZ7x5G
	j4uXlD0+b5ILYI/itklKLCkLzkzP07dL4M64NL2TveCmYsWeCecZGxh/SnUxcnJICJhIzNr7
	nKmLkYtDSGAro0THnDlQzkkmiV2Nb1hAqtgEdCUW9TQzgdgiAmoSE9sOsYAUMQt0Mkmc2ANR
	JCzgL/HuYR87iM0ioCrxcv9+MJtXIEri97dtrBDr5CQuT3/ABmJzClhInL4+AcwWEjCX+De7
	iX0CI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqGermZJXqpKaWbGCFhxrOD8ds6mUOM
	AhyMSjy8Ebsiw4VYE8uKK3MPMUpyMCmJ8u4MjAoX4kvKT6nMSCzOiC8qzUktPsQowcGsJMIr
	BpLjTUmsrEotyodJSXOwKInzqi5R9xMSSE8sSc1OTS1ILYLJynBwKEnwqpUBNQoWpaanVqRl
	5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDoiC+GBgHICkeoL0VIO28xQWJuUBRiNZTjLocR/bf
	W8skxJKXn5cqJc67qBSoSACkKKM0D24FLKm8YhQH+liYVxNkFA8wIcFNegW0hAloyfIj4SBL
	ShIRUlINjN6+Mj9OSe45EPSzK3Y715LikIq9Px7UPm5YcfzWoyIvsdMBvUa/m+ffmzph3mv2
	R0euLxIJ7Jw+ZWaty6W1D2TXnOCfviM8Y1H/cZN1atUtEYVlan6bJzebNh3lCfB2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296953>

The tests already set a variable called prefix and passed its value as
the first argument to this function. The old argument handling was
overwriting the global variable with its same value rather than creating
a local variable.

So change test_update_rejected to refer to the global variable rather
than taking the prefix as an argument.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1404-update-ref-errors.sh | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 2818460..541cad1 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -4,11 +4,10 @@ test_description='Test git update-ref error handling'
 . ./test-lib.sh
 
 test_update_rejected () {
-	prefix="$1" &&
-	before="$2" &&
-	pack="$3" &&
-	create="$4" &&
-	error="$5" &&
+	before="$1" &&
+	pack="$2" &&
+	create="$3" &&
+	error="$4" &&
 	printf "create $prefix/%s $C\n" $before |
 	git update-ref --stdin &&
 	git for-each-ref $prefix >unchanged &&
@@ -37,7 +36,7 @@ test_expect_success 'setup' '
 test_expect_success 'existing loose ref is a simple prefix of new' '
 
 	prefix=refs/1l &&
-	test_update_rejected $prefix "a c e" false "b c/x d" \
+	test_update_rejected "a c e" false "b c/x d" \
 		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x$Q"
 
 '
@@ -45,7 +44,7 @@ test_expect_success 'existing loose ref is a simple prefix of new' '
 test_expect_success 'existing packed ref is a simple prefix of new' '
 
 	prefix=refs/1p &&
-	test_update_rejected $prefix "a c e" true "b c/x d" \
+	test_update_rejected "a c e" true "b c/x d" \
 		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x$Q"
 
 '
@@ -53,7 +52,7 @@ test_expect_success 'existing packed ref is a simple prefix of new' '
 test_expect_success 'existing loose ref is a deeper prefix of new' '
 
 	prefix=refs/2l &&
-	test_update_rejected $prefix "a c e" false "b c/x/y d" \
+	test_update_rejected "a c e" false "b c/x/y d" \
 		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x/y$Q"
 
 '
@@ -61,7 +60,7 @@ test_expect_success 'existing loose ref is a deeper prefix of new' '
 test_expect_success 'existing packed ref is a deeper prefix of new' '
 
 	prefix=refs/2p &&
-	test_update_rejected $prefix "a c e" true "b c/x/y d" \
+	test_update_rejected "a c e" true "b c/x/y d" \
 		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x/y$Q"
 
 '
@@ -69,7 +68,7 @@ test_expect_success 'existing packed ref is a deeper prefix of new' '
 test_expect_success 'new ref is a simple prefix of existing loose' '
 
 	prefix=refs/3l &&
-	test_update_rejected $prefix "a c/x e" false "b c d" \
+	test_update_rejected "a c/x e" false "b c d" \
 		"$Q$prefix/c/x$Q exists; cannot create $Q$prefix/c$Q"
 
 '
@@ -77,7 +76,7 @@ test_expect_success 'new ref is a simple prefix of existing loose' '
 test_expect_success 'new ref is a simple prefix of existing packed' '
 
 	prefix=refs/3p &&
-	test_update_rejected $prefix "a c/x e" true "b c d" \
+	test_update_rejected "a c/x e" true "b c d" \
 		"$Q$prefix/c/x$Q exists; cannot create $Q$prefix/c$Q"
 
 '
@@ -85,7 +84,7 @@ test_expect_success 'new ref is a simple prefix of existing packed' '
 test_expect_success 'new ref is a deeper prefix of existing loose' '
 
 	prefix=refs/4l &&
-	test_update_rejected $prefix "a c/x/y e" false "b c d" \
+	test_update_rejected "a c/x/y e" false "b c d" \
 		"$Q$prefix/c/x/y$Q exists; cannot create $Q$prefix/c$Q"
 
 '
@@ -93,7 +92,7 @@ test_expect_success 'new ref is a deeper prefix of existing loose' '
 test_expect_success 'new ref is a deeper prefix of existing packed' '
 
 	prefix=refs/4p &&
-	test_update_rejected $prefix "a c/x/y e" true "b c d" \
+	test_update_rejected "a c/x/y e" true "b c d" \
 		"$Q$prefix/c/x/y$Q exists; cannot create $Q$prefix/c$Q"
 
 '
@@ -101,7 +100,7 @@ test_expect_success 'new ref is a deeper prefix of existing packed' '
 test_expect_success 'one new ref is a simple prefix of another' '
 
 	prefix=refs/5 &&
-	test_update_rejected $prefix "a e" false "b c c/x d" \
+	test_update_rejected "a e" false "b c c/x d" \
 		"cannot process $Q$prefix/c$Q and $Q$prefix/c/x$Q at the same time"
 
 '
-- 
2.8.1
