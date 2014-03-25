From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 094/144] t7505-prepare-commit-msg-hook.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:39 -0700
Message-ID: <1395735989-3396-95-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:29:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMjg-0001Gx-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbaCYI3V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:29:21 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:51717 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbaCYI2T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:19 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so129830pdj.22
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FdiXSTOJQfvh7+BSwo6BhI7VF+Xz5CoQYtx58ivjbp4=;
        b=1DqC4Xv/EhIr37CJ0TyT2q/7QCCStEvyehkJ3jTcbZjor5iWiBTeWe6UrhkTJ6EM7n
         2YhGpU4Bi6IdEc7EX+6iaTHkKjRCOZRv4QaX4mT01tprS89gBGCj1Z2Pwc7ayoHQJfx1
         hxsqDMLtXhIFFIOOej1hZS/9WsswXrD3NS/YBkXAF4twv2HVbXV5oLz8Gnq4Hb3jpfT/
         1zzX+cfuTy3FAIPa8+D2Jog9LtYsbkZEU4ljKxOa+JWstqZT0McyHd34MDhltcSPRX79
         +0rxES9Co0RIzsK869MZvJBV67dHl/olAEP62v/NM4FfSJ431eYciQr/Dc/J2Pot0/AB
         /lVQ==
X-Received: by 10.66.233.99 with SMTP id tv3mr22944362pac.97.1395736099272;
        Tue, 25 Mar 2014 01:28:19 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244946>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t7505-prepare-commit-msg-hook.sh |   32 ++++++++++++++++------------=
----
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commi=
t-msg-hook.sh
index 3573751..e3baf16 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -53,7 +53,7 @@ test_expect_success 'with hook (-m)' '
 	echo "more" >> file &&
 	git add file &&
 	git commit -m "more" &&
-	test "`git log -1 --pretty=3Dformat:%s`" =3D "message (no editor)"
+	test "$(git log -1 --pretty=3Dformat:%s)" =3D "message (no editor)"
=20
 '
=20
@@ -62,7 +62,7 @@ test_expect_success 'with hook (-m editor)' '
 	echo "more" >> file &&
 	git add file &&
 	GIT_EDITOR=3D"\"\$FAKE_EDITOR\"" git commit -e -m "more more" &&
-	test "`git log -1 --pretty=3Dformat:%s`" =3D message
+	test "$(git log -1 --pretty=3Dformat:%s)" =3D message
=20
 '
=20
@@ -71,7 +71,7 @@ test_expect_success 'with hook (-t)' '
 	echo "more" >> file &&
 	git add file &&
 	git commit -t "$(git rev-parse --git-dir)/template" &&
-	test "`git log -1 --pretty=3Dformat:%s`" =3D template
+	test "$(git log -1 --pretty=3Dformat:%s)" =3D template
=20
 '
=20
@@ -80,7 +80,7 @@ test_expect_success 'with hook (-F)' '
 	echo "more" >> file &&
 	git add file &&
 	(echo more | git commit -F -) &&
-	test "`git log -1 --pretty=3Dformat:%s`" =3D "message (no editor)"
+	test "$(git log -1 --pretty=3Dformat:%s)" =3D "message (no editor)"
=20
 '
=20
@@ -89,17 +89,17 @@ test_expect_success 'with hook (-F editor)' '
 	echo "more" >> file &&
 	git add file &&
 	(echo more more | GIT_EDITOR=3D"\"\$FAKE_EDITOR\"" git commit -e -F -=
) &&
-	test "`git log -1 --pretty=3Dformat:%s`" =3D message
+	test "$(git log -1 --pretty=3Dformat:%s)" =3D message
=20
 '
=20
 test_expect_success 'with hook (-C)' '
=20
-	head=3D`git rev-parse HEAD` &&
+	head=3D$(git rev-parse HEAD) &&
 	echo "more" >> file &&
 	git add file &&
 	git commit -C $head &&
-	test "`git log -1 --pretty=3Dformat:%s`" =3D "$head (no editor)"
+	test "$(git log -1 --pretty=3Dformat:%s)" =3D "$head (no editor)"
=20
 '
=20
@@ -108,40 +108,40 @@ test_expect_success 'with hook (editor)' '
 	echo "more more" >> file &&
 	git add file &&
 	GIT_EDITOR=3D"\"\$FAKE_EDITOR\"" git commit &&
-	test "`git log -1 --pretty=3Dformat:%s`" =3D default
+	test "$(git log -1 --pretty=3Dformat:%s)" =3D default
=20
 '
=20
 test_expect_success 'with hook (--amend)' '
=20
-	head=3D`git rev-parse HEAD` &&
+	head=3D$(git rev-parse HEAD) &&
 	echo "more" >> file &&
 	git add file &&
 	GIT_EDITOR=3D"\"\$FAKE_EDITOR\"" git commit --amend &&
-	test "`git log -1 --pretty=3Dformat:%s`" =3D "$head"
+	test "$(git log -1 --pretty=3Dformat:%s)" =3D "$head"
=20
 '
=20
 test_expect_success 'with hook (-c)' '
=20
-	head=3D`git rev-parse HEAD` &&
+	head=3D$(git rev-parse HEAD) &&
 	echo "more" >> file &&
 	git add file &&
 	GIT_EDITOR=3D"\"\$FAKE_EDITOR\"" git commit -c $head &&
-	test "`git log -1 --pretty=3Dformat:%s`" =3D "$head"
+	test "$(git log -1 --pretty=3Dformat:%s)" =3D "$head"
=20
 '
=20
 test_expect_success 'with hook (merge)' '
=20
-	head=3D`git rev-parse HEAD` &&
+	head=3D$(git rev-parse HEAD) &&
 	git checkout -b other HEAD@{1} &&
 	echo "more" >> file &&
 	git add file &&
 	git commit -m other &&
 	git checkout - &&
 	git merge other &&
-	test "`git log -1 --pretty=3Dformat:%s`" =3D merge
+	test "$(git log -1 --pretty=3Dformat:%s)" =3D merge
 '
=20
 cat > "$HOOK" <<'EOF'
@@ -151,7 +151,7 @@ EOF
=20
 test_expect_success 'with failing hook' '
=20
-	head=3D`git rev-parse HEAD` &&
+	head=3D$(git rev-parse HEAD) &&
 	echo "more" >> file &&
 	git add file &&
 	! GIT_EDITOR=3D"\"\$FAKE_EDITOR\"" git commit -c $head
@@ -160,7 +160,7 @@ test_expect_success 'with failing hook' '
=20
 test_expect_success 'with failing hook (--no-verify)' '
=20
-	head=3D`git rev-parse HEAD` &&
+	head=3D$(git rev-parse HEAD) &&
 	echo "more" >> file &&
 	git add file &&
 	! GIT_EDITOR=3D"\"\$FAKE_EDITOR\"" git commit --no-verify -c $head
--=20
1.7.10.4
