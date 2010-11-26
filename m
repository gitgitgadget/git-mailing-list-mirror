From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/47] t1510: setup case #19
Date: Fri, 26 Nov 2010 22:32:18 +0700
Message-ID: <1290785563-15339-23-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:42:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0R0-0004x0-9s
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031Ab0KZPlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:41:55 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56990 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab0KZPly (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:41:54 -0500
Received: by pwj3 with SMTP id 3so401439pwj.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Q7oVvuD+oikUIqNMdp2huStT6MVvErX93IJtINBNvZs=;
        b=bJzD+uZeAy8tVlXOOOH598FZUjHegjZEMAnH/aZgEtQV06S4t/hd9OlZHTzEZkXq8G
         w0lc2CZZtXmsn9HgbaHcpWrvBRGno6YiiOMZRMofXnhFQh48dm+KOjh27XtbI876tl6v
         QNNvMGXFjq0xNkFwzV5RJbEmcKEatCObw/Zyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WxmaVtq0BFYioBn0z3sXHfaFamr0BxgeBMURW1g749ouGX+gwujoaMTOFAPcdNMku4
         AtKRTqYoWNBCZfJkUqE+307Xsy8atZq5EIqt2QsasKTwtEjUiCegFIXMlLRtkwtL+/S6
         cKFzVc/KV01Jz5W3yWXeoeYWIfWP8eB41bayQ=
Received: by 10.142.179.21 with SMTP id b21mr2510746wff.432.1290786114148;
        Fri, 26 Nov 2010 07:41:54 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id b11sm2678010wff.21.2010.11.26.07.41.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:41:53 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:40:39 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162238>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  266 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 266 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 069af70..954e7fe 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2560,4 +2560,270 @@ EOF
 	test_repo 18/sub "$TRASH_DIRECTORY/18/.git"
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
+	test_repo 19 .git "$TRASH_DIRECTORY/19"
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
+	test_repo 19 .git .
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	test_repo 19 "$TRASH_DIRECTORY/19/.git" "$TRASH_DIRECTORY/19"
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
+	test_repo 19 "$TRASH_DIRECTORY/19/.git" .
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
+	test_repo 19/sub/sub ../../.git "$TRASH_DIRECTORY/19"
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
+	test_repo 19/sub/sub ../../.git ../..
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >19/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: sub/
+EOF
+	test_repo 19/sub "$TRASH_DIRECTORY/19/.git" "$TRASH_DIRECTORY/19"
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
+	test_repo 19/sub/sub "$TRASH_DIRECTORY/19/.git" ../..
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	test_repo 19 .git "$TRASH_DIRECTORY/19/wt"
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
+	test_repo 19 .git wt
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	test_repo 19 "$TRASH_DIRECTORY/19/.git" wt
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	test_repo 19 "$TRASH_DIRECTORY/19/.git" "$TRASH_DIRECTORY/19/wt"
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
+	test_repo 19/sub/sub ../../.git "$TRASH_DIRECTORY/19/wt"
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
+	test_repo 19/sub/sub ../../.git ../../wt
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
+	test_repo 19/sub/sub "$TRASH_DIRECTORY/19/.git" ../../wt
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 19/sub/sub "$TRASH_DIRECTORY/19/.git" "$TRASH_DIRECTORY/19/=
wt"
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/
+EOF
+	test_repo 19 .git "$TRASH_DIRECTORY"
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
+	test_repo 19 .git ..
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/
+EOF
+	test_repo 19 "$TRASH_DIRECTORY/19/.git" ..
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/
+EOF
+	test_repo 19 "$TRASH_DIRECTORY/19/.git" "$TRASH_DIRECTORY"
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
+	test_repo 19/sub/sub ../../.git "$TRASH_DIRECTORY"
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
+	test_repo 19/sub/sub ../../.git ../../..
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
+	test_repo 19/sub/sub "$TRASH_DIRECTORY/19/.git" ../../../
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/sub/sub/
+EOF
+	test_repo 19/sub/sub "$TRASH_DIRECTORY/19/.git" "$TRASH_DIRECTORY"
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
