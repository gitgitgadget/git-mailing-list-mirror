From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 18/27] update-ref --stdin: harmonize error messages
Date: Mon,  7 Apr 2014 15:48:09 +0200
Message-ID: <1396878498-19887-19-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:50:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9wB-0003at-2v
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbaDGNuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:50:01 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57538 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755383AbaDGNtD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:49:03 -0400
X-AuditID: 12074411-f79ab6d000002f0e-f3-5342accb72cb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.AF.12046.BCCA2435; Mon,  7 Apr 2014 09:48:59 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaP026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:57 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqHt6jVOwwc05PBY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oz3F2ewFdz1qTi9bg5TA+M52y5GDg4JAROJ+5cj
	uxg5gUwxiQv31rN1MXJxCAlcZpRomNrJBOEcY5L4+qKNDaSKTUBXYlFPMxOILSKgJjGx7RAL
	SBGzwBVGiSsft7OATBUWcJP4NtUKxGQRUJWYPjsCpJxXwFXi1bKHjBDL5CROHpvMCmJzAsVn
	HLoFFhcScJG4v+YYywRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJTSjcx
	QsJOcAfjjJNyhxgFOBiVeHhXHHIMFmJNLCuuzD3EKMnBpCTK+3yZU7AQX1J+SmVGYnFGfFFp
	TmrxIUYJDmYlEV6u1UA53pTEyqrUonyYlDQHi5I4L98SdT8hgfTEktTs1NSC1CKYrAwHh5IE
	73qQRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQXMQXAyMDJMUDtHcu2N7igsRc
	oChE6ylGXY5byzc2Mgmx5OXnpUqJ85aAFAmAFGWU5sGtgCWZV4ziQB8L824AqeIBJii4Sa+A
	ljABLTF0BVtSkoiQkmpg5Gt9+vXKNoNT9Zebl+icTH+xJcH69S61z383lwVNk7j0Lm9LbbLT
	iakfMiTPPVD8c/sc0weuVbrz/5YYSN6+dOaG9K3OPTubqg6ZPm0t/nb7+btMBY/U 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245858>

Make (most of) the error messages for invalid input have the same
format [1]:

    $COMMAND [SP $REFNAME]: $MESSAGE

Update the tests accordingly.

[1] A few error messages are left with their old form, because
    $COMMAND and $REFNAME aren't passed all the way down the call
    stack.  Maybe those sites should be changed some day, too.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  | 24 ++++++++++++------------
 t/t1400-update-ref.sh | 32 ++++++++++++++++----------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0d5f1d0..423c5c3 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -202,19 +202,19 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 
 	update->ref_name = parse_refname(input, &next);
 	if (!update->ref_name)
-		die("update line missing <ref>");
+		die("update: missing <ref>");
 
 	if (parse_next_sha1(input, &next, update->new_sha1,
 			    "update", update->ref_name,
 			    PARSE_SHA1_ALLOW_EMPTY))
-		die("update %s missing <newvalue>", update->ref_name);
+		die("update %s: missing <newvalue>", update->ref_name);
 
 	update->have_old = !parse_next_sha1(input, &next, update->old_sha1,
 					    "update", update->ref_name,
 					    PARSE_SHA1_OLD);
 
 	if (*next != line_termination)
-		die("update %s has extra input: %s", update->ref_name, next);
+		die("update %s: extra input: %s", update->ref_name, next);
 
 	return next;
 }
@@ -227,17 +227,17 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 
 	update->ref_name = parse_refname(input, &next);
 	if (!update->ref_name)
-		die("create line missing <ref>");
+		die("create: missing <ref>");
 
 	if (parse_next_sha1(input, &next, update->new_sha1,
 			    "create", update->ref_name, 0))
-		die("create %s missing <newvalue>", update->ref_name);
+		die("create %s: missing <newvalue>", update->ref_name);
 
 	if (is_null_sha1(update->new_sha1))
-		die("create %s given zero <newvalue>", update->ref_name);
+		die("create %s: zero <newvalue>", update->ref_name);
 
 	if (*next != line_termination)
-		die("create %s has extra input: %s", update->ref_name, next);
+		die("create %s: extra input: %s", update->ref_name, next);
 
 	return next;
 }
@@ -250,19 +250,19 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 
 	update->ref_name = parse_refname(input, &next);
 	if (!update->ref_name)
-		die("delete line missing <ref>");
+		die("delete: missing <ref>");
 
 	if (parse_next_sha1(input, &next, update->old_sha1,
 			    "delete", update->ref_name, PARSE_SHA1_OLD)) {
 		update->have_old = 0;
 	} else {
 		if (is_null_sha1(update->old_sha1))
-			die("delete %s given zero <oldvalue>", update->ref_name);
+			die("delete %s: zero <oldvalue>", update->ref_name);
 		update->have_old = 1;
 	}
 
 	if (*next != line_termination)
-		die("delete %s has extra input: %s", update->ref_name, next);
+		die("delete %s: extra input: %s", update->ref_name, next);
 
 	return next;
 }
@@ -275,7 +275,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 
 	update->ref_name = parse_refname(input, &next);
 	if (!update->ref_name)
-		die("verify line missing <ref>");
+		die("verify: missing <ref>");
 
 	if (parse_next_sha1(input, &next, update->old_sha1,
 			    "verify", update->ref_name, PARSE_SHA1_OLD)) {
@@ -286,7 +286,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	}
 
 	if (*next != line_termination)
-		die("verify %s has extra input: %s", update->ref_name, next);
+		die("verify %s: extra input: %s", update->ref_name, next);
 
 	return next;
 }
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 1db0689..48ccc4d 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -371,7 +371,7 @@ test_expect_success 'stdin fails on junk after quoted argument' '
 test_expect_success 'stdin fails create with no ref' '
 	echo "create " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create line missing <ref>" err
+	grep "fatal: create: missing <ref>" err
 '
 
 test_expect_success 'stdin fails create with bad ref name' '
@@ -383,19 +383,19 @@ test_expect_success 'stdin fails create with bad ref name' '
 test_expect_success 'stdin fails create with no new value' '
 	echo "create $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $a missing <newvalue>" err
+	grep "fatal: create $a: missing <newvalue>" err
 '
 
 test_expect_success 'stdin fails create with too many arguments' '
 	echo "create $a $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $a has extra input:  $m" err
+	grep "fatal: create $a: extra input:  $m" err
 '
 
 test_expect_success 'stdin fails update with no ref' '
 	echo "update " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update line missing <ref>" err
+	grep "fatal: update: missing <ref>" err
 '
 
 test_expect_success 'stdin fails update with bad ref name' '
@@ -407,19 +407,19 @@ test_expect_success 'stdin fails update with bad ref name' '
 test_expect_success 'stdin fails update with no new value' '
 	echo "update $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update $a missing <newvalue>" err
+	grep "fatal: update $a: missing <newvalue>" err
 '
 
 test_expect_success 'stdin fails update with too many arguments' '
 	echo "update $a $m $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update $a has extra input:  $m" err
+	grep "fatal: update $a: extra input:  $m" err
 '
 
 test_expect_success 'stdin fails delete with no ref' '
 	echo "delete " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: delete line missing <ref>" err
+	grep "fatal: delete: missing <ref>" err
 '
 
 test_expect_success 'stdin fails delete with bad ref name' '
@@ -431,13 +431,13 @@ test_expect_success 'stdin fails delete with bad ref name' '
 test_expect_success 'stdin fails delete with too many arguments' '
 	echo "delete $a $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: delete $a has extra input:  $m" err
+	grep "fatal: delete $a: extra input:  $m" err
 '
 
 test_expect_success 'stdin fails verify with too many arguments' '
 	echo "verify $a $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: verify $a has extra input:  $m" err
+	grep "fatal: verify $a: extra input:  $m" err
 '
 
 test_expect_success 'stdin fails option with unknown name' '
@@ -532,7 +532,7 @@ test_expect_success 'stdin create ref fails with bad new value' '
 test_expect_success 'stdin create ref fails with zero new value' '
 	echo "create $c " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $c given zero <newvalue>" err &&
+	grep "fatal: create $c: zero <newvalue>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -556,7 +556,7 @@ test_expect_success 'stdin delete ref fails with wrong old value' '
 test_expect_success 'stdin delete ref fails with zero old value' '
 	echo "delete $a " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: delete $a given zero <oldvalue>" err &&
+	grep "fatal: delete $a: zero <oldvalue>" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -697,7 +697,7 @@ test_expect_success 'stdin -z fails on unknown command' '
 test_expect_success 'stdin -z fails create with no ref' '
 	printf $F "create " >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create line missing <ref>" err
+	grep "fatal: create: missing <ref>" err
 '
 
 test_expect_success 'stdin -z fails create with bad ref name' '
@@ -721,7 +721,7 @@ test_expect_success 'stdin -z fails create with too many arguments' '
 test_expect_success 'stdin -z fails update with no ref' '
 	printf $F "update " >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update line missing <ref>" err
+	grep "fatal: update: missing <ref>" err
 '
 
 test_expect_success 'stdin -z fails update with too few args' '
@@ -765,7 +765,7 @@ test_expect_success 'stdin -z fails update with too many arguments' '
 test_expect_success 'stdin -z fails delete with no ref' '
 	printf $F "delete " >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete line missing <ref>" err
+	grep "fatal: delete: missing <ref>" err
 '
 
 test_expect_success 'stdin -z fails delete with bad ref name' '
@@ -868,7 +868,7 @@ test_expect_success 'stdin -z create ref fails with bad new value' '
 test_expect_success 'stdin -z create ref fails with empty new value' '
 	printf $F "create $c" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $c missing <newvalue>" err &&
+	grep "fatal: create $c: missing <newvalue>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -892,7 +892,7 @@ test_expect_success 'stdin -z delete ref fails with wrong old value' '
 test_expect_success 'stdin -z delete ref fails with zero old value' '
 	printf $F "delete $a" "$Z" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete $a given zero <oldvalue>" err &&
+	grep "fatal: delete $a: zero <oldvalue>" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
-- 
1.9.1
