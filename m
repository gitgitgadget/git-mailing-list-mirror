From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 6/7] Fix tests under GETTEXT_POISON on git-remote
Date: Mon, 27 Aug 2012 13:36:54 +0800
Message-ID: <f56c058cfd76d02ed42b0c5b7161bde6bd51ddd0.1346045253.git.worldhello.net@gmail.com>
References: <cover.1346045253.git.worldhello.net@gmail.com>
 <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com>
 <08d87cf811ed6ea328303b8ca26f1ab32cacfba9.1346045253.git.worldhello.net@gmail.com>
 <7398781c6d647557954f4a0c7df29fc98aad842b.1346045253.git.worldhello.net@gmail.com>
 <d20c47e9618f998b84934c0310f3de51d791e83f.1346045253.git.worldhello.net@gmail.com>
 <a2e20a1e1ae4be42b763904177cf634a6e291f15.1346045253.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 07:37:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5s19-00031a-6l
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 07:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab2H0Fhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 01:37:36 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47886 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab2H0Fhf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 01:37:35 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2294471dad.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 22:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=jV+kB80bhCJVeRlJLSSXGt+qn78tHkAbY6BTiNwa2FI=;
        b=UeAnWfZ9+vrrJZbU5ZrbfJ16yayjF5+fOpdU9WAuHtYCm0T5eGXydq65vG54e8WJrv
         kh+iWAqbuf82GDhezzYwarpC73LItaEbe+STvhLljO9s7Xi1A3cSJtjTCKORMDCuXVRC
         6l90bzB+F3ain+uaIVI9c085rQ7ONIsCHg0LhFAb7U0ZUlc0nBa1Ii7TqFEfx4mFZ88C
         dtkAw5OHKkCAS1d7CvMu5xmWpMjmSzJ3ZEm80Qi41Nlav8t5aiy4w6KCj7KMdYR0emRB
         csXuPJewequRHv1HYQeFO/+67u67Iolu5+O9M7qDQnbbrCB7ar4Zcdw0ddH3q35HdVdo
         ZIZA==
Received: by 10.68.193.194 with SMTP id hq2mr31924215pbc.93.1346045854733;
        Sun, 26 Aug 2012 22:37:34 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.231.150])
        by mx.google.com with ESMTPS id gf3sm13924207pbc.74.2012.08.26.22.37.30
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 22:37:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.gaa91cb5
In-Reply-To: <a2e20a1e1ae4be42b763904177cf634a6e291f15.1346045253.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346045253.git.worldhello.net@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com> <cover.1346045253.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204324>

Use i18n-specific test functions in test scripts for git-remote.
This issue was was introduced in v1.7.10-233-gbb16d5:

    bb16d5 i18n: remote: mark strings for translation

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5505-remote.sh | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e8af6..7f0cb 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -52,7 +52,7 @@ test_expect_success setup '
=20
 '
=20
-test_expect_success 'remote information for the origin' '
+test_expect_success C_LOCALE_OUTPUT 'remote information for the origin=
' '
 (
 	cd test &&
 	tokens_match origin "$(git remote)" &&
@@ -66,8 +66,6 @@ test_expect_success 'add another remote' '
 	cd test &&
 	git remote add -f second ../two &&
 	tokens_match "origin second" "$(git remote)" &&
-	check_remote_track origin master side &&
-	check_remote_track second master side another &&
 	check_tracking_branch second master side another &&
 	git for-each-ref "--format=3D%(refname)" refs/remotes |
 	sed -e "/^refs\/remotes\/origin\//d" \
@@ -77,6 +75,14 @@ test_expect_success 'add another remote' '
 )
 '
=20
+test_expect_success C_LOCALE_OUTPUT 'add another remote' '
+(
+	cd test &&
+	check_remote_track origin master side &&
+	check_remote_track second master side another &&
+)
+'
+
 test_expect_success 'remote forces tracking branches' '
 (
 	cd test &&
@@ -95,7 +101,7 @@ test_expect_success 'remove remote' '
 )
 '
=20
-test_expect_success 'remove remote' '
+test_expect_success C_LOCALE_OUTPUT 'remove remote' '
 (
 	cd test &&
 	tokens_match origin "$(git remote)" &&
@@ -131,8 +137,8 @@ EOF
 	git remote rm oops 2>actual2 &&
 	git branch -d foobranch &&
 	git tag -d footag &&
-	test_cmp expect1 actual1 &&
-	test_cmp expect2 actual2
+	test_i18ncmp expect1 actual1 &&
+	test_i18ncmp expect2 actual2
 )
 '
=20
@@ -192,7 +198,7 @@ test_expect_success 'show' '
 	 git config --add remote.two.push refs/heads/master:refs/heads/anothe=
r &&
 	 git remote show origin two > output &&
 	 git branch -d rebase octopus &&
-	 test_cmp expect output)
+	 test_i18ncmp expect output)
 '
=20
 cat > test/expect << EOF
@@ -217,7 +223,7 @@ test_expect_success 'show -n' '
 	 cd test &&
 	 git remote show -n origin > output &&
 	 mv ../one.unreachable ../one &&
-	 test_cmp expect output)
+	 test_i18ncmp expect output)
 '
=20
 test_expect_success 'prune' '
@@ -255,7 +261,7 @@ EOF
 test_expect_success 'set-head --auto fails w/multiple HEADs' '
 	(cd test &&
 	 test_must_fail git remote set-head --auto two >output 2>&1 &&
-	test_cmp expect output)
+	test_i18ncmp expect output)
 '
=20
 cat >test/expect <<EOF
@@ -285,7 +291,7 @@ test_expect_success 'prune --dry-run' '
 	 test_must_fail git rev-parse refs/remotes/origin/side &&
 	(cd ../one &&
 	 git branch -m side side2) &&
-	 test_cmp expect output)
+	 test_i18ncmp expect output)
 '
=20
 test_expect_success 'add --mirror && prune' '
@@ -705,7 +711,7 @@ test_expect_success 'remote prune to cause a dangli=
ng symref' '
 		cd seven &&
 		git remote prune origin
 	) >err 2>&1 &&
-	grep "has become dangling" err &&
+	test_i18ngrep "has become dangling" err &&
=20
 	: And the dangling symref will not cause other annoying errors &&
 	(
--=20
1.7.12.92.gaa91cb5
