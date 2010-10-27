From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/34] t1510: setup case #15
Date: Wed, 27 Oct 2010 21:49:21 +0700
Message-ID: <1288190977-30875-19-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:52:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Mm-0007lz-3A
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760726Ab0J0OwB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:52:01 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56867 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760681Ab0J0OwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:52:00 -0400
Received: by mail-yw0-f46.google.com with SMTP id 9so444465ywk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HKGsdXqtzLJ76wRfG/kg7Fd/APY9+Wc6wLZ7162f71s=;
        b=P2nfGfsnllTkFGYVIyTxHu8qMwZaoJwj7HbvrjLOgOpr0fC4P7ad50MBsV+Ho1OZAv
         l1Myr5tCBsMH1MAzyEbY/wt3a1TJRXWL4VGO/kLg7UW9NlWAJAVr+NIhhNSnrfqYi8rI
         K+GgsN5KjOEzmMP2AnUgN/SKGD7YDA5wBJCkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=B91j/EzVXnSohHqLFhGwBxQ3wejfRaLJoG89qW11Kwunrzzi24bbuaOaexEz1zsrnZ
         V9JzVPJdKMkYhc13U23LsI6aTKhK7x3St1+mj2MsT+9oPD6YUhoQ1Cz6GYniNcjsZtJY
         /4lOByqCj1ULVVW2N4O2p+SZDkSKM2zlWZoc8=
Received: by 10.150.140.4 with SMTP id n4mr17714830ybd.316.1288191119079;
        Wed, 27 Oct 2010 07:51:59 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id y21sm6443142yhc.14.2010.10.27.07.51.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:51:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:51:55 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160062>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  268 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 268 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 0cd00ea..47c8814 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1950,4 +1950,272 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
 '
=20
+#
+# case #15
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #7 except that git_dir is set by .git file
+
+test_expect_success '#15: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 15 15/sub 15/sub/sub 15.wt 15.wt/sub 15/wt 15/wt/sub &&
+	cd 15 &&
+	git init &&
+	git config core.worktree non-existent &&
+	mv .git ../15.git &&
+	echo gitdir: ../15.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/15" test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/15" test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D. test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/15" test_repo =
15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >15/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/15" test_repo 15/sub
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D../.. test_repo =
15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/15/wt" test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3Dwt test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/15/wt" test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/15/wt" test_re=
po 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D../../wt test_re=
po 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/15/wt" test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D.. test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 15
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 15/=
sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 15/sub/sub
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 15/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
