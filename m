From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 30/47] t1510: setup case #27
Date: Fri, 26 Nov 2010 22:32:26 +0700
Message-ID: <1290785563-15339-31-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:45:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0UV-000725-GO
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab0KZPpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:45:33 -0500
Received: from mail-pz0-f66.google.com ([209.85.210.66]:50652 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab0KZPpd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:45:33 -0500
Received: by pzk26 with SMTP id 26so457676pzk.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=cZ7fozF4g5vH1oUzHyCyPO185ljpjqcBIWjMB/3uhuw=;
        b=qHsdOhBNblSDG35tbGapuP19EGzieCPtLmLeQJZ3xwQc0psnpM/WbP6ObEnkm/I+Eu
         ANh7PcMK8uJkIQXJrBGsuFEFvbCunDuwUAiQKomlb3T229Qv80lHGud7DmIsyMzGnVnd
         BHT8xu8mMS/A5g/nXFS0uBcnXhAPck3OgCOpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tVSWeMhPsX8vlsio6Uz1i6GL2EMgMbwGhI0GRplZDCSZTfiZ/dYdA5DYmUEieesV6q
         zNC4qoQZvJEYGRR01Lm6cib7fxxumM0+EfpjEXObekdB36FzMJvZg857xv6whquRxsx/
         /ZRX/NLS+QpeIHodz0CHfPMYGMohPfJVLvJhM=
Received: by 10.142.201.5 with SMTP id y5mr2520352wff.221.1290786332658;
        Fri, 26 Nov 2010 07:45:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id v19sm2685914wfh.12.2010.11.26.07.45.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:45:30 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:44:15 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162246>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  268 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 268 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 0ad5e81..5c831d1 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3854,4 +3854,272 @@ EOF
 	test_repo 26/sub "$TRASH_DIRECTORY/26/.git"
 '
=20
+#
+# case #27
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - .git is a file
+#  - core.worktree is not set
+#  - core.bare is set
+#
+# Output:
+#
+# #19 except git_dir is set according to .git file
+
+test_expect_success '#27: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 27 27/sub 27/sub/sub 27.wt 27.wt/sub 27/wt 27/wt/sub &&
+	cd 27 &&
+	git init &&
+	git config core.bare true &&
+	mv .git ../27.git &&
+	echo gitdir: ../27.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	test_repo 27 .git "$TRASH_DIRECTORY/27"
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	test_repo 27 .git .
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	test_repo 27 "$TRASH_DIRECTORY/27/.git" "$TRASH_DIRECTORY/27"
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	test_repo 27 "$TRASH_DIRECTORY/27/.git" .
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: sub/sub/
+EOF
+	test_repo 27/sub/sub ../../.git "$TRASH_DIRECTORY/27"
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: sub/sub/
+EOF
+	test_repo 27/sub/sub ../../.git ../..
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >27/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: sub/
+EOF
+	test_repo 27/sub "$TRASH_DIRECTORY/27/.git" "$TRASH_DIRECTORY/27"
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: sub/sub/
+EOF
+	test_repo 27/sub/sub "$TRASH_DIRECTORY/27/.git" ../..
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	test_repo 27 .git "$TRASH_DIRECTORY/27/wt"
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	test_repo 27 .git wt
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	test_repo 27 "$TRASH_DIRECTORY/27/.git" wt
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	test_repo 27 "$TRASH_DIRECTORY/27/.git" "$TRASH_DIRECTORY/27/wt"
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 27/sub/sub ../../.git "$TRASH_DIRECTORY/27/wt"
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 27/sub/sub ../../.git ../../wt
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 27/sub/sub "$TRASH_DIRECTORY/27/.git" ../../wt
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 27/sub/sub "$TRASH_DIRECTORY/27/.git" "$TRASH_DIRECTORY/27/=
wt"
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/
+EOF
+	test_repo 27 .git "$TRASH_DIRECTORY"
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/
+EOF
+	test_repo 27 .git ..
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/
+EOF
+	test_repo 27 "$TRASH_DIRECTORY/27/.git" ..
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/
+EOF
+	test_repo 27 "$TRASH_DIRECTORY/27/.git" "$TRASH_DIRECTORY"
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/sub/sub/
+EOF
+	test_repo 27/sub/sub ../../.git "$TRASH_DIRECTORY"
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/sub/sub/
+EOF
+	test_repo 27/sub/sub ../../.git ../../..
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/sub/sub/
+EOF
+	test_repo 27/sub/sub "$TRASH_DIRECTORY/27/.git" ../../../
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/sub/sub/
+EOF
+	test_repo 27/sub/sub "$TRASH_DIRECTORY/27/.git" "$TRASH_DIRECTORY"
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
