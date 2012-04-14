From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v2 5/5] i18n: mark @{upstream} error messages for translation
Date: Sat, 14 Apr 2012 09:54:35 +0200
Message-ID: <1334390075-25467-6-git-send-email-zbyszek@in.waw.pl>
References: <20120412204055.GA21018@sigill.intra.peff.net>
 <1334390075-25467-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 14 09:56:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIxqn-000861-IO
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 09:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174Ab2DNH4s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 03:56:48 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34848 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115Ab2DNH4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 03:56:48 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SIxqg-0001I9-Va; Sat, 14 Apr 2012 09:56:47 +0200
X-Mailer: git-send-email 1.7.10.226.gfe575
In-Reply-To: <1334390075-25467-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195477>

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 sha1_name.c                   |    8 ++++----
 t/t1507-rev-parse-upstream.sh |   10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 361708b..c633113 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -861,15 +861,15 @@ int interpret_branch_name(const char *name, struc=
t strbuf *buf)
 	 * points to something different than a branch.
 	 */
 	if (!upstream)
-		return error("HEAD does not point to a branch");
+		return error(_("HEAD does not point to a branch"));
 	if (!upstream->merge || !upstream->merge[0]->dst) {
 		if (!ref_exists(upstream->refname))
-			return error("No such branch: '%s'", cp);
+			return error(_("No such branch: '%s'"), cp);
 		if (!upstream->merge)
-			return error("No upstream configured for branch '%s'",
+			return error(_("No upstream configured for branch '%s'"),
 				     upstream->name);
 		return error(
-			"Upstream branch '%s' not stored as a remote-tracking branch",
+			_("Upstream branch '%s' not stored as a remote-tracking branch"),
 			upstream->merge[0]->src);
 	}
 	free(cp);
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream=
=2Esh
index e742ce0..d6e5761 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -129,7 +129,7 @@ test_expect_success 'branch@{u} error message when =
no upstream' '
 	fatal: Needed a single revision
 	EOF
 	error_message non-tracking@{u} 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success '@{u} error message when no upstream' '
@@ -138,7 +138,7 @@ test_expect_success '@{u} error message when no ups=
tream' '
 	fatal: Needed a single revision
 	EOF
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success 'branch@{u} error message with misspelt branch' '
@@ -147,7 +147,7 @@ test_expect_success 'branch@{u} error message with =
misspelt branch' '
 	fatal: Needed a single revision
 	EOF
 	error_message no-such-branch@{u} 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success '@{u} error message when not on a branch' '
@@ -157,7 +157,7 @@ test_expect_success '@{u} error message when not on=
 a branch' '
 	EOF
 	git checkout HEAD^0 &&
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success 'branch@{u} error message if upstream branch not f=
etched' '
@@ -166,7 +166,7 @@ test_expect_success 'branch@{u} error message if up=
stream branch not fetched' '
 	fatal: Needed a single revision
 	EOF
 	error_message bad-upstream@{u} 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success 'pull works when tracking a local branch' '
--=20
1.7.10.226.gfe575
