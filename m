From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/26] update-ref --stdin: Make error messages more consistent
Date: Mon, 10 Mar 2014 13:46:29 +0100
Message-ID: <1394455603-2968-13-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:48:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzdD-0000Jh-Um
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbaCJMs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:48:26 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57764 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753558AbaCJMrN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:13 -0400
X-AuditID: 12074412-f79d46d000002e58-b7-531db45025c2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 82.41.11864.054BD135; Mon, 10 Mar 2014 08:47:12 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwa025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:11 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqBuwRTbY4Pd5E4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8a2lq8sBUc1KpasnMLYwPhXoYuRk0NCwETi5q6V
	7BC2mMSFe+vZuhi5OIQELjNKHL65EMo5wSSx4lYvE0gVm4CuxKKeZjBbREBNYmLbIRaQImaB
	K4wSn7/+AhslLOAncebsE7AiFgFVifPP97KA2LwCLhKH5k9jgVgnJzHl9wKwek6g+PQrD8Bs
	IQFniZd7mlknMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrppebWaKXmlK6iRESfEI7
	GNeflDvEKMDBqMTDe+CtTLAQa2JZcWXuIUZJDiYlUd6Ja2WDhfiS8lMqMxKLM+KLSnNSiw8x
	SnAwK4nwZi4GyvGmJFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfD6bgZq
	FCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFR3wxMD5AUjxAe7eBtPMWFyTmAkUh
	Wk8xKkqJ884BSQiAJDJK8+DGwlLKK0ZxoC+FeVtBqniA6Qiu+xXQYCagwc3HpUAGlyQipKQa
	GN1qttukh1+eye//7eirtBfWV2MF5Na3CVTrCpgzZkqc4PtWlaD8RJlRhcM1urzrRVWirM3n
	5Qvf1KZvf/tm/jmZpUfvv7G5aXvRTk/7+ekQrwPp7Sxmm8+36d08aBDS97Gm7ODF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243752>

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
index c5be870..3045ae7 100755
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
