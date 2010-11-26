From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/47] t1510: setup case #7
Date: Fri, 26 Nov 2010 22:32:06 +0700
Message-ID: <1290785563-15339-11-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:37:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Mn-0002WE-SY
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab0KZPhf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:37:35 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57729 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0KZPhf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:37:35 -0500
Received: by pva4 with SMTP id 4so351120pva.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0QjzfNxzMixgc/7ml44rZqKMwA2FqOTICx2c5fLKHwo=;
        b=f+okedCtGgdPisI45fk+5cZ2kQDt87xlth2fSnk1bbUUViicndvKiz0FTdHAEPStvQ
         xF7cvoJbb+NM1lFgP3Fkqx+VghoTuIMP/0MEntTIFc+Iu0aTEJNLzmZRTQgjUMGKN5Ue
         vq+uFPGS4hKKJelHNcaRA15+1pP+pra/c/qCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AbDV8yV882y6EjVhWQU+FHK2yHWWUkoqm4mbBq51wtOpsRtT7XgXy5V6cMpp7GEFYT
         gfyfACtCxi3Y8vuOK0joZkzkya34g8xTE9x+k9zK2MeWmEgGY78zy84sEn5kiAEr54lr
         7a2b52SW5sD6gGg9goZasMcKfUZmbciudi16Q=
Received: by 10.142.252.3 with SMTP id z3mr2528093wfh.161.1290785854725;
        Fri, 26 Nov 2010 07:37:34 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w22sm2673405wfd.7.2010.11.26.07.37.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:37:33 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:36:23 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162226>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  266 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 266 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 4b2e60e..ccd7036 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -871,4 +871,270 @@ EOF
 	test_repo 6/sub/sub "$TRASH_DIRECTORY/6/.git"
 '
=20
+#
+# case #7
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# core.worktree is overridden by GIT_WORK_TREE -> #3
+
+test_expect_success '#7: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 7 7/sub 7/sub/sub 7.wt 7.wt/sub 7/wt 7/wt/sub &&
+	cd 7 &&
+	git init &&
+	git config core.worktree non-existent &&
+	cd ..
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	test_repo 7 .git "$TRASH_DIRECTORY/7"
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at ro=
ot' '
+	cat >7/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	test_repo 7 .git .
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	test_repo 7 "$TRASH_DIRECTORY/7/.git" "$TRASH_DIRECTORY/7"
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	test_repo 7 "$TRASH_DIRECTORY/7/.git" .
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir' =
'
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: sub/sub/
+EOF
+	test_repo 7/sub/sub ../../.git "$TRASH_DIRECTORY/7"
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in sub=
dir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: sub/sub/
+EOF
+	test_repo 7/sub/sub ../../.git ../..
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >7/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: sub/
+EOF
+	test_repo 7/sub "$TRASH_DIRECTORY/7/.git" "$TRASH_DIRECTORY/7"
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir' =
'
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: sub/sub/
+EOF
+	test_repo 7/sub/sub "$TRASH_DIRECTORY/7/.git" ../..
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	test_repo 7 .git "$TRASH_DIRECTORY/7/wt"
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at root=
' '
+	cat >7/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	test_repo 7 .git wt
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	test_repo 7 "$TRASH_DIRECTORY/7/.git" wt
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	test_repo 7 "$TRASH_DIRECTORY/7/.git" "$TRASH_DIRECTORY/7/wt"
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 7/sub/sub ../../.git "$TRASH_DIRECTORY/7/wt"
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in subd=
ir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 7/sub/sub ../../.git ../../wt
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 7/sub/sub "$TRASH_DIRECTORY/7/.git" ../../wt
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 7/sub/sub "$TRASH_DIRECTORY/7/.git" "$TRASH_DIRECTORY/7/wt"
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/
+EOF
+	test_repo 7 .git "$TRASH_DIRECTORY"
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at root=
' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/
+EOF
+	test_repo 7 .git ..
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/
+EOF
+	test_repo 7 "$TRASH_DIRECTORY/7/.git" ..
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/
+EOF
+	test_repo 7 "$TRASH_DIRECTORY/7/.git" "$TRASH_DIRECTORY"
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/sub/sub/
+EOF
+	test_repo 7/sub/sub ../../.git "$TRASH_DIRECTORY"
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in subd=
ir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/sub/sub/
+EOF
+	test_repo 7/sub/sub ../../.git ../../..
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/sub/sub/
+EOF
+	test_repo 7/sub/sub "$TRASH_DIRECTORY/7/.git" ../../../
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/sub/sub/
+EOF
+	test_repo 7/sub/sub "$TRASH_DIRECTORY/7/.git" "$TRASH_DIRECTORY"
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
