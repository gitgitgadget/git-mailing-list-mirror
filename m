From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/42] t1510: setup case #15
Date: Fri, 29 Oct 2010 13:48:30 +0700
Message-ID: <1288334934-17216-19-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:51:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBioX-0006ZH-HA
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871Ab0J2Gvj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:51:39 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932830Ab0J2Gvi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:51:38 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qwEdALv17uM25W+sP38H379tpU78rEXj244AdvUaSpM=;
        b=srhyrGDyLqcuxFd97mifrK8bjian6+9Q/NtEYTCibetv+TRpmTx2gJ432F7yEnhuIy
         zDKiEN8CrtzM6o4/jsW8RT9j472uky1slx7NqhiNB5ZxDLeCQ/1c2x/8mHjAewQWGn69
         G6no2FJHpQYp4ATMXA1KyI5nB8lU/mcFmMTlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HRP70Oj1HgsInH1dIQLjfsRshF749zASl1evvv1vlBy6FG9ihBzDXsg/NnTXswP07G
         uP4ebfwVyGizo7vo/UvXMpmV5+nGWdYxnj6SvMrOOrtyC96RY6zYcpxs6Tv1aPF2TalF
         lq0ohpLxAWmG/blmYwyocCkRceeT0pksGhjc0=
Received: by 10.142.136.17 with SMTP id j17mr990680wfd.326.1288335098485;
        Thu, 28 Oct 2010 23:51:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w42sm1034112wfh.3.2010.10.28.23.51.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:51:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:51:37 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160286>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  268 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 268 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index c14ba8a..d10ab68 100755
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
