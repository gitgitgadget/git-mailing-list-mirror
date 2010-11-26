From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/47] t1510: setup case #11
Date: Fri, 26 Nov 2010 22:32:10 +0700
Message-ID: <1290785563-15339-15-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:38:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0O0-00039S-FT
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab0KZPiv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:38:51 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:32866 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab0KZPiu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:38:50 -0500
Received: by pwj3 with SMTP id 3so401026pwj.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KjYslQcNAftoPdUWW6gJuj3Y4WhuywmGJXC7BalL5rI=;
        b=iLCB/ef+rgV9wIPTteI0WXbMGN+gTfKpL18bUQ8CtPk9eM+V1K2+iKelJ2ZN96Vs+d
         h3GRceInuc0/3XGhfBFDZuEZ2url9M28K3gffZF5yBdjpYD5LTuoxUK6uimeACDu4uTw
         aT1eEScuaPdRBLdEB7D/u3Fq+dyiGsGjcqwCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dkHHZKE/Pda3dk45MnjAQbVKfG8CC13mARmmqOMvGy0P9XAOwKFwiEKNNO9YfhAhVw
         A5+BqhyLheWyHT2jC8SiauhlGrm+bIDI6JyJ2QF1xGC9fG8R4/Y0RvlxmKqXv7NL4W17
         ZaZHrhCoZ3fPcykXmoYUornasu+gT1kWEGMMc=
Received: by 10.142.88.11 with SMTP id l11mr2485030wfb.314.1290785929800;
        Fri, 26 Nov 2010 07:38:49 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id e14sm2679438wfg.8.2010.11.26.07.38.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:38:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:37:37 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162229>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  267 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 267 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 3f19ff1..ac95808 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1300,4 +1300,271 @@ EOF
 	test_repo 10/sub ../.git
 '
=20
+#
+# case #11
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #3 except that git_dir is set by .git file
+
+test_expect_success '#11: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 11 11/sub 11/sub/sub 11.wt 11.wt/sub 11/wt 11/wt/sub &&
+	cd 11 &&
+	git init &&
+	mv .git ../11.git &&
+	echo gitdir: ../11.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	test_repo 11 .git "$TRASH_DIRECTORY/11"
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	test_repo 11 .git .
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	test_repo 11 "$TRASH_DIRECTORY/11/.git" "$TRASH_DIRECTORY/11"
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	test_repo 11 "$TRASH_DIRECTORY/11/.git" .
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: sub/sub/
+EOF
+	test_repo 11/sub/sub ../../.git "$TRASH_DIRECTORY/11"
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: sub/sub/
+EOF
+	test_repo 11/sub/sub ../../.git ../..
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >11/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: sub/
+EOF
+	test_repo 11/sub "$TRASH_DIRECTORY/11/.git" "$TRASH_DIRECTORY/11"
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: sub/sub/
+EOF
+	test_repo 11/sub/sub "$TRASH_DIRECTORY/11/.git" ../..
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	test_repo 11 .git "$TRASH_DIRECTORY/11/wt"
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	test_repo 11 .git wt
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	test_repo 11 "$TRASH_DIRECTORY/11/.git" wt
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	test_repo 11 "$TRASH_DIRECTORY/11/.git" "$TRASH_DIRECTORY/11/wt"
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 11/sub/sub ../../.git "$TRASH_DIRECTORY/11/wt"
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 11/sub/sub ../../.git ../../wt
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 11/sub/sub "$TRASH_DIRECTORY/11/.git" ../../wt
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 11/sub/sub "$TRASH_DIRECTORY/11/.git" "$TRASH_DIRECTORY/11/=
wt"
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/
+EOF
+	test_repo 11 .git "$TRASH_DIRECTORY"
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/
+EOF
+	test_repo 11 .git ..
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/
+EOF
+	test_repo 11 "$TRASH_DIRECTORY/11/.git" ..
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/
+EOF
+	test_repo 11 "$TRASH_DIRECTORY/11/.git" "$TRASH_DIRECTORY"
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/sub/sub/
+EOF
+	test_repo 11/sub/sub ../../.git "$TRASH_DIRECTORY"
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/sub/sub/
+EOF
+	test_repo 11/sub/sub ../../.git ../../..
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/sub/sub/
+EOF
+	test_repo 11/sub/sub "$TRASH_DIRECTORY/11/.git" ../../../
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/sub/sub/
+EOF
+	test_repo 11/sub/sub "$TRASH_DIRECTORY/11/.git" "$TRASH_DIRECTORY"
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
