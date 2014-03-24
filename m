From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/27] update-ref --stdin: Make error messages more consistent
Date: Mon, 24 Mar 2014 18:56:44 +0100
Message-ID: <1395683820-17304-12-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:58:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS99E-0002Oo-Gq
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbaCXR6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:58:36 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:58414 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753777AbaCXR5c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:32 -0400
X-AuditID: 12074414-f79d96d000002d2b-b3-5330720b91d6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 3B.8E.11563.B0270335; Mon, 24 Mar 2014 13:57:31 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xh028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:29 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqMtdZBBssGuThsXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO2PBhGlMBUc1Ki5+ncbawPhXoYuRk0NCwETi2MvF
	jBC2mMSFe+vZQGwhgcuMEg/+JHUxcgHZJ5gkjj1uZwdJsAnoSizqaWYCsUUE1CQmth1iASli
	FrjCKHHl43YWkISwQKDEyu5mMJtFQFVi0cEJzCA2r4CrxKxD+5khtslJTPm9AGwoJ1B8a/th
	ZojNLhI7PvYyTWDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWldBMjJPRE
	djAeOSl3iFGAg1GJhzfC2CBYiDWxrLgy9xCjJAeTkigvWy5QiC8pP6UyI7E4I76oNCe1+BCj
	BAezkgivZThQjjclsbIqtSgfJiXNwaIkzvttsbqfkEB6YklqdmpqQWoRTFaGg0NJgndqIVCj
	YFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCg24ouB0QGS4gHaWwvSzltckJgLFIVo
	PcWoKCXOe60AKCEAksgozYMbC0sorxjFgb4U5p0P0s4DTEZw3a+ABjMBDQ5v0gMZXJKIkJJq
	YORO/GFY8KP5Qdl6m7tn3UOzvKelNrGknfjXLfqiuMx2q8q73T6Vr5PXz5K6cbSBzUbI58uk
	KSUKeYqMMlH7N+Ux7uLQM8s88Mc3Sb9y/UKWN3eqTCfvUJ4bulnQQqx4d3zE1NcH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244852>

The old error messages emitted for invalid input sometimes said
"<oldvalue>"/"<newvalue>" and sometimes said "old value"/"new value".
Convert them all to the former.  Update the tests accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  |  8 ++++----
 t/t1400-update-ref.sh | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 13a884a..e4c0854 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -40,7 +40,7 @@ static void update_store_new_sha1(const char *command,
 				  const char *newvalue)
 {
 	if (*newvalue && get_sha1(newvalue, update->new_sha1))
-		die("%s %s: invalid new value: %s",
+		die("%s %s: invalid <newvalue>: %s",
 		    command, update->ref_name, newvalue);
 }
 
@@ -49,7 +49,7 @@ static void update_store_old_sha1(const char *command,
 				  const char *oldvalue)
 {
 	if (*oldvalue && get_sha1(oldvalue, update->old_sha1))
-		die("%s %s: invalid old value: %s",
+		die("%s %s: invalid <oldvalue>: %s",
 		    command, update->ref_name, oldvalue);
 
 	/* We have an old value if non-empty, or if empty without -z */
@@ -198,7 +198,7 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 		die("create %s missing <newvalue>", update->ref_name);
 
 	if (is_null_sha1(update->new_sha1))
-		die("create %s given zero new value", update->ref_name);
+		die("create %s given zero <newvalue>", update->ref_name);
 
 	if (*next != line_termination)
 		die("create %s has extra input: %s", update->ref_name, next);
@@ -220,7 +220,7 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (!parse_next_arg(input, &next, &oldvalue)) {
 		update_store_old_sha1("delete", update, oldvalue.buf);
 		if (update->have_old && is_null_sha1(update->old_sha1))
-			die("delete %s given zero old value", update->ref_name);
+			die("delete %s given zero <oldvalue>", update->ref_name);
 	} else if (!line_termination)
 		die("delete %s missing [<oldvalue>] NUL", update->ref_name);
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index f6c6e96..ef61fe3 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -518,21 +518,21 @@ test_expect_success 'stdin update ref fails with wrong old value' '
 test_expect_success 'stdin update ref fails with bad old value' '
 	echo "update $c $m does-not-exist" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update $c: invalid old value: does-not-exist" err &&
+	grep "fatal: update $c: invalid <oldvalue>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin create ref fails with bad new value' '
 	echo "create $c does-not-exist" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $c: invalid new value: does-not-exist" err &&
+	grep "fatal: create $c: invalid <newvalue>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin create ref fails with zero new value' '
 	echo "create $c " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $c given zero new value" err &&
+	grep "fatal: create $c given zero <newvalue>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -556,7 +556,7 @@ test_expect_success 'stdin delete ref fails with wrong old value' '
 test_expect_success 'stdin delete ref fails with zero old value' '
 	echo "delete $a " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: delete $a given zero old value" err &&
+	grep "fatal: delete $a given zero <oldvalue>" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -840,14 +840,14 @@ test_expect_success 'stdin -z update ref fails with wrong old value' '
 test_expect_success 'stdin -z update ref fails with bad old value' '
 	printf $F "update $c" "$m" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $c: invalid old value: does-not-exist" err &&
+	grep "fatal: update $c: invalid <oldvalue>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin -z create ref fails with bad new value' '
 	printf $F "create $c" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $c: invalid new value: does-not-exist" err &&
+	grep "fatal: create $c: invalid <newvalue>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -878,7 +878,7 @@ test_expect_success 'stdin -z delete ref fails with wrong old value' '
 test_expect_success 'stdin -z delete ref fails with zero old value' '
 	printf $F "delete $a" "$Z" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete $a given zero old value" err &&
+	grep "fatal: delete $a given zero <oldvalue>" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
-- 
1.9.0
