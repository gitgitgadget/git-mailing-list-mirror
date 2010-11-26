From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/47] t1510: setup case #14
Date: Fri, 26 Nov 2010 22:32:13 +0700
Message-ID: <1290785563-15339-18-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:40:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0P5-0003kh-V0
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab0KZPj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:39:57 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52330 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0KZPj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:39:56 -0500
Received: by pva4 with SMTP id 4so351386pva.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=350c7x6OriL9rcGh1e2P7tUF49p6JvKZiyC8t2LtcSw=;
        b=qKSW7yxU0xQ2AcgyiBgmk/SVzfIurhRMqTV70cw/6dYeWm3ylthvFlHwfbM77ELp9U
         Rq2xT8ZnbYcSCbk7f9ww9QZ5s5VVXOE1ypjjOOrZ1LZfbfEj/SS5dQYgPSzKGzQ0yFnP
         OlWy53wwIdz/tZ5m7DoYDtpOpxsGiRFYCotYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xkMWoEPvIx58vviRsJQK5vO6nx2MlHImt4pYy3rhpFtjAwJnTC7zAvUn3WeS73P6a6
         r8RvMRVSchWNikBMoFvc1BG8b30O0M5fFz9BIqiyO7XO/NkcCVYqjg8JTOSZpI0CVdZp
         83ENbIF+EwVBHfHXwktHmG63am6TolBhw6cy8=
Received: by 10.142.217.9 with SMTP id p9mr2523179wfg.212.1290785996388;
        Fri, 26 Nov 2010 07:39:56 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id f5sm2680306wfg.14.2010.11.26.07.39.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:39:55 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:38:46 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162233>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  291 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 291 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index c2cc504..617a14d 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1666,4 +1666,295 @@ EOF
 	test_repo 13/sub
 '
=20
+#
+# case #14
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #6 except that git_dir is set by .git file
+
+test_expect_success '#14: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 14 14/sub 14/sub/sub 14.wt 14.wt/sub 14/wt 14/wt/sub &&
+	cd 14 &&
+	git init &&
+	mv .git ../14.git &&
+	echo gitdir: ../14.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14 at root'=
 '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14" &&
+	test_repo 14 .git
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14(rel) at =
root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14 &&
+	test_repo 14 .git
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14 at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14" &&
+	test_repo 14 "$TRASH_DIRECTORY/14/.git"
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14(rel) at root'=
 '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14 &&
+	test_repo 14 "$TRASH_DIRECTORY/14/.git"
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14 in subdi=
r' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14" &&
+	test_repo 14/sub/sub ../../.git
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14(rel) in =
subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14 &&
+	test_repo 14/sub/sub ../../.git
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14 in subdir' '
+	cat >14/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14" &&
+	test_repo 14/sub "$TRASH_DIRECTORY/14/.git"
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14(rel) in subdi=
r' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14 &&
+	test_repo 14/sub/sub "$TRASH_DIRECTORY/14/.git"
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt at ro=
ot' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14/wt" &&
+	test_repo 14 .git
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14/wt &&
+	test_repo 14 .git
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt(rel) at ro=
ot' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14/wt &&
+	test_repo 14 "$TRASH_DIRECTORY/14/.git"
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14/wt" &&
+	test_repo 14 "$TRASH_DIRECTORY/14/.git"
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt in su=
bdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14/wt" &&
+	test_repo 14/sub/sub ../../.git
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14/wt &&
+	test_repo 14/sub/sub ../../.git
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt(rel) in su=
bdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14/wt &&
+	test_repo 14/sub/sub "$TRASH_DIRECTORY/14/.git"
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt in subdir'=
 '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14/wt" &&
+	test_repo 14/sub/sub "$TRASH_DIRECTORY/14/.git"
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D.. at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	test_repo 14 .git
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D..(rel) at roo=
t' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
 &&
+	test_repo 14 .git
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D..(rel) at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
 &&
+	test_repo 14 "$TRASH_DIRECTORY/14/.git"
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D.. at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	test_repo 14 "$TRASH_DIRECTORY/14/.git"
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D.. in subdir' =
'
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	test_repo 14/sub/sub ../../.git
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D..(rel) in sub=
dir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
 &&
+	test_repo 14/sub/sub ../../.git
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D..(rel) in subdir' =
'
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
 &&
+	test_repo 14/sub/sub "$TRASH_DIRECTORY/14/.git"
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D.. in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	test_repo 14/sub/sub "$TRASH_DIRECTORY/14/.git"
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
