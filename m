From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/34] t1510: setup case #19
Date: Wed, 27 Oct 2010 21:49:25 +0700
Message-ID: <1288190977-30875-23-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:52:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Mo-0007lz-6p
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760880Ab0J0Owe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:52:34 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37043 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760681Ab0J0Owc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:52:32 -0400
Received: by ywk9 with SMTP id 9so445305ywk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=hLYV9rrL36dQ0vLqEcsc2QKDRwj/Ei410TTbplMjWtE=;
        b=ulY7T1jBBtWdREFmBwHU1QU6VvAqS0/nOJRagBmOgdje2pajUp3q0FwRCMpPmevC08
         NGql1udtcpW4OnVXFbALssbK+ob3xMmvgVSdL1+Efj3lTjk0I4bOC8MN1vSrnGmHHBgQ
         eTPUd+U53Hpr+qvBtYMISW0KIPb09uO5r+mtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oszT/MeW6IXPcDIo+SR/zLRmUqFIK+/uh4X3HV//NSRjMSkcFTDt39SNKzYmMb5m2S
         eCi+8cSIP6y8LDYlUk71UepBVM0Kc+oEb/BPIcp7Zyn7u10XrinXS1COQWuiDyu7KSPY
         kroQRqTgfTaboelVkxYkfNik7KiJWxdt+XVTk=
Received: by 10.151.83.13 with SMTP id k13mr5667792ybl.54.1288191149224;
        Wed, 27 Oct 2010 07:52:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id q4sm4997435yba.2.2010.10.27.07.52.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:52:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:52:26 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160057>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  266 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 266 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 0d32a6d..802bd5f 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2552,4 +2552,270 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/18/.git" test_repo 18/sub
 '
=20
+#
+# case #19
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - .git is a directory
+#  - core.worktree is not set
+#  - core.bare is set
+#
+# Output:
+#
+# bare repo is overridden by GIT_WORK_TREE -> #3
+
+test_expect_success '#19: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 19 19/sub 19/sub/sub 19.wt 19.wt/sub 19/wt 19/wt/sub &&
+	cd 19 &&
+	git init &&
+	git config core.bare true &&
+	cd ..
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >19/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/19" test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >19/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/19" test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D. test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/19" test_repo =
19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >19/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/19" test_repo 19/sub
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D../.. test_repo =
19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/19/wt" test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >19/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3Dwt test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/19/wt" test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/19/wt" test_re=
po 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D../../wt test_re=
po 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/19/wt" test_repo 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D.. test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 19/=
sub/sub
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 19/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
