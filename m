From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 11/27] update-ref --stdin: make error messages more consistent
Date: Mon,  7 Apr 2014 15:48:02 +0200
Message-ID: <1396878498-19887-12-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:50:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9wP-0003kl-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbaDGNuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:50:21 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44172 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755345AbaDGNsq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:46 -0400
X-AuditID: 12074413-f79076d000002d17-55-5342acbddca2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.78.11543.DBCA2435; Mon,  7 Apr 2014 09:48:45 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaI026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:43 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLt3jVOwwZ7rihY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxjM7ezFRzVqHj1I6mB8a9CFyMnh4SAicTnO73s
	ELaYxIV769m6GLk4hAQuM0o8nnWMBcI5xiTx9u4NJpAqNgFdiUU9zWC2iICaxMS2Q2BFzAJX
	GCWufNzOApIQFgiUWDN3ChuIzSKgKvHv1wewFbwCrhIrr9xmgVgnJ3Hy2GRWEJsTKD7j0C1G
	EFtIwEXi/ppjLBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3ECAk9
	4R2Mu07KHWIU4GBU4uFdecgxWIg1say4MvcQoyQHk5Io7/NlTsFCfEn5KZUZicUZ8UWlOanF
	hxglOJiVRHi5VgPleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvI0g
	jYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg2IgvBkYHSIoHaO9csL3FBYm5QFGI
	1lOMilLivCUgCQGQREZpHtxYWEJ5xSgO9KUw73OQKh5gMoLrfgU0mAlosKEr2OCSRISUVANj
	T8/mzVuv7538ekvL1yu/TMxuqy2pe3hRVf7snpe7A3dPaIsRaPo+5Xrxe2OrnjWlD5fdkC/J
	+3UvaIuF/74j3cu6Y4q22xV+br/4Z+v3lrmGPI9s36cF7F9xPLNDYnPG5G8OR9ot 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245861>

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
1.9.1
