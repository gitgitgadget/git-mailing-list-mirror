From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 6/7] Fix tests under GETTEXT_POISON on git-remote
Date: Tue, 28 Aug 2012 06:59:16 +0800
Message-ID: <89668a45ea6ffe2a537dc6116062d5994252534d.1346108242.git.worldhello.net@gmail.com>
References: <cover.1346108242.git.worldhello.net@gmail.com>
 <1954d94a032f1cedee953a7db5da8f6d37e4c7d9.1346108242.git.worldhello.net@gmail.com>
 <4e2f6d25bc4588f478bb3b6866290f2feabc03d0.1346108242.git.worldhello.net@gmail.com>
 <19564c3c4288172ab1cf2c7097a750f5689faba8.1346108242.git.worldhello.net@gmail.com>
 <c7c8ebb234e8bd0771cfd7d2f715f06d86e5c472.1346108242.git.worldhello.net@gmail.com>
 <c89b2d6f6636e693c27ed52fb57231664a61336b.1346108242.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 00:59:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68Hg-00081z-Pc
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 00:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab2H0W7j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 18:59:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61072 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab2H0W7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 18:59:36 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so8239394pbb.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Mrv332ZIaJ0tE6t7uOtKMUJ+Y9QCrbVXEeGHBnZsB+E=;
        b=YCcskf69iGsuKvPOtx4snhptEPlzg4A0T5YZerRSYLWABZ/beu9LJ45pjFUPSiNKqV
         M+wDvTFz99uBqWhaO5u4JjyhsH1WnVUN3XdRutDKAsnJhsN+WJPoDFOq0tuNlZA/x06O
         1BqoWfqYmMeRS6V0igsHY0dQPU+T+CUzQhTgEBAxJe5Ii4Fs//SqvF1JKG4LHBOjEOzY
         eaHDyKQE7jzGh3iPhKKm0A9BRjsxX5x/8vlveVr3rHjqSadid9P+MJWbpcruwZfBwZnB
         hosiB24sm424Hm55tRSchJ4sSdeJEMo6oiJjz0zpUoTQselJqIY7hZYysfUYhZAyjepT
         OHhA==
Received: by 10.68.221.42 with SMTP id qb10mr37700885pbc.155.1346108376702;
        Mon, 27 Aug 2012 15:59:36 -0700 (PDT)
Received: from localhost.foo.bar ([123.115.151.199])
        by mx.google.com with ESMTPS id qn13sm15577687pbb.71.2012.08.27.15.59.33
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 15:59:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.g949df84
In-Reply-To: <c89b2d6f6636e693c27ed52fb57231664a61336b.1346108242.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346108242.git.worldhello.net@gmail.com>
References: <cover.1346108242.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204384>

Use i18n-specific test functions in test scripts for git-remote, and
bypass some testcases using C_LOCALE_OUTPUT prereq flag. This issue
was was introduced in v1.7.10-233-gbb16d5:

    bb16d5 i18n: remote: mark strings for translation

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5505-remote.sh | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e8af6..4b720 100755
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
+test_expect_success C_LOCALE_OUTPUT 'check tracking for add another re=
mote' '
+(
+	cd test &&
+	check_remote_track origin master side &&
+	check_remote_track second master side another
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
1.7.12.92.g949df84
