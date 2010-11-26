From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/47] t1510: setup case #23
Date: Fri, 26 Nov 2010 22:32:22 +0700
Message-ID: <1290785563-15339-27-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0T5-0006D5-I2
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241Ab0KZPoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:44:05 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:38815 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab0KZPoD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:44:03 -0500
Received: by pxi15 with SMTP id 15so353025pxi.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xCV7QwMy8EmkQ81oLoreSwMZd3IH2UAtSpVYKrnuhmA=;
        b=IpqQ3Q5QuxOIgPN4DPia3z7VuTaKuRnHTEu9+VfmvXXiAu+pkDzWpjs/+yZ2EUjvXc
         qhlfYLmW/hoSlkI+iTlf62aI7I0uuJhLh4Sv9ge+5OWW2X98phqWXUhwZQ6ltzjVYGQw
         d+dy6BtWgSQ7+DVT8aD/wZonBanJW8a3HC6ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lsX78gQqx0l6jhj8lWMQP1P3+/lgRkNHghUNzLopJPzhrTlDF/1DkZdJddCPPCrEuV
         sidYhEyx18UtiMHEuvwLsIFLDA0Kj0+By88shL9/sGqEChpJpr/mpmL+UP/ZncvVUOww
         +dr0vN41Z9IAJqJg1jE/g1m+YajhcfNxYT2IM=
Received: by 10.142.213.21 with SMTP id l21mr2502467wfg.272.1290786243303;
        Fri, 26 Nov 2010 07:44:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id b11sm2685539wff.9.2010.11.26.07.43.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:44:02 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:42:53 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162242>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  267 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 267 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 0027274..07af3cc 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3421,4 +3421,271 @@ test_expect_failure '#22.2: at root' '
 	)
 '
=20
+#
+# case #23
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# core.worktree is overridden by GIT_WORK_TREE -> #19
+
+test_expect_success '#23: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 23 23/sub 23/sub/sub 23.wt 23.wt/sub 23/wt 23/wt/sub &&
+	cd 23 &&
+	git init &&
+	git config core.bare true &&
+	git config core.worktree non-existent &&
+	cd ..
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >23/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	test_repo 23 .git "$TRASH_DIRECTORY/23"
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >23/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	test_repo 23 .git .
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	test_repo 23 "$TRASH_DIRECTORY/23/.git" "$TRASH_DIRECTORY/23"
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	test_repo 23 "$TRASH_DIRECTORY/23/.git" .
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: sub/sub/
+EOF
+	test_repo 23/sub/sub ../../.git "$TRASH_DIRECTORY/23"
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: sub/sub/
+EOF
+	test_repo 23/sub/sub ../../.git ../..
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >23/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: sub/
+EOF
+	test_repo 23/sub "$TRASH_DIRECTORY/23/.git" "$TRASH_DIRECTORY/23"
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: sub/sub/
+EOF
+	test_repo 23/sub/sub "$TRASH_DIRECTORY/23/.git" ../..
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	test_repo 23 .git "$TRASH_DIRECTORY/23/wt"
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >23/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	test_repo 23 .git wt
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	test_repo 23 "$TRASH_DIRECTORY/23/.git" wt
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	test_repo 23 "$TRASH_DIRECTORY/23/.git" "$TRASH_DIRECTORY/23/wt"
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 23/sub/sub ../../.git "$TRASH_DIRECTORY/23/wt"
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 23/sub/sub ../../.git ../../wt
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 23/sub/sub "$TRASH_DIRECTORY/23/.git" ../../wt
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 23/sub/sub "$TRASH_DIRECTORY/23/.git" "$TRASH_DIRECTORY/23/=
wt"
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/
+EOF
+	test_repo 23 .git "$TRASH_DIRECTORY"
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/
+EOF
+	test_repo 23 .git ..
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/
+EOF
+	test_repo 23 "$TRASH_DIRECTORY/23/.git" ..
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/
+EOF
+	test_repo 23 "$TRASH_DIRECTORY/23/.git" "$TRASH_DIRECTORY"
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/sub/sub/
+EOF
+	test_repo 23/sub/sub ../../.git "$TRASH_DIRECTORY"
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/sub/sub/
+EOF
+	test_repo 23/sub/sub ../../.git ../../..
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/sub/sub/
+EOF
+	test_repo 23/sub/sub "$TRASH_DIRECTORY/23/.git" ../../../
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/sub/sub/
+EOF
+	test_repo 23/sub/sub "$TRASH_DIRECTORY/23/.git" "$TRASH_DIRECTORY"
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
