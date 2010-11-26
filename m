From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/47] t1510: setup case #17
Date: Fri, 26 Nov 2010 22:32:16 +0700
Message-ID: <1290785563-15339-21-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:41:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0QT-0004da-O6
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143Ab0KZPlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:41:16 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59356 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063Ab0KZPlP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:41:15 -0500
Received: by pva4 with SMTP id 4so351543pva.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UFf3yA42F8lSInieFfIJtHASLrLBt/BO2fLhVoSw6vY=;
        b=fWM7TIm9tqppihEcYt5FHTx/QKXE4G2pgD51P9htGHMTLYIUokNaJhogZKRa0Cgsnl
         egtZAKcDUWQl3GKOEgK1eYO2TQcReBRPMxbha2N83zsmoS+lhvakHjQOSa11f+a0AIdf
         uPMha9neiaJfI65edRffMv15ahEGvaSki2Vyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EIP06YM3GpLkeyDHkzho1uO+uDszSYD3Mt9fdQfR2fGfVUOJuusg8iNx3+zrN9sLb4
         CbDN+ZRL67RsuV3WjC0lb21NO4f9dtuaOplUz9LNPkoYgK4vX7cL9KQCX8W3LPkLxjLp
         G6CPs3nM/v0iLBtsvzeqEIV/Ir2QiKX58c67E=
Received: by 10.142.48.2 with SMTP id v2mr2507366wfv.277.1290786074629;
        Fri, 26 Nov 2010 07:41:14 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w22sm2679118wfd.19.2010.11.26.07.41.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:41:13 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:39:56 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162236>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  129 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 129 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 0f7a2d9..e298a16 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2360,4 +2360,133 @@ EOF
 	test_repo 16/sub
 '
=20
+#
+# case #17.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+# GIT_WORK_TREE is ignored -> #16.1 (with warnings perhaps)
+
+test_expect_success '#17.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 17 17/sub &&
+	cd 17 &&
+	git init &&
+	mkdir .git/wt .git/wt/sub &&
+	GIT_WORK_TREE=3Dnon-existent &&
+	export GIT_WORK_TREE &&
+	cd ..
+'
+
+test_expect_failure '#17.1: at .git' '
+	cat >17/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git
+setup: prefix: (null)
+EOF
+	test_repo 17/.git
+'
+
+test_expect_failure '#17.1: in .git/wt' '
+	cat >17/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 17/.git/wt
+'
+
+test_expect_failure '#17.1: in .git/wt/sub' '
+	cat >17/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 17/.git/wt/sub
+'
+
+#
+# case #17.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# GIT_WORK_TREE is ignored -> #16.2 (with warnings perhaps)
+
+test_expect_success '#17.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/17/.git/config" core.bare true
+'
+
+test_expect_failure '#17.2: at .git' '
+	cat >17/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git
+setup: prefix: (null)
+EOF
+	test_repo 17/.git
+'
+
+test_expect_failure '#17.2: in .git/wt' '
+	cat >17/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 17/.git/wt
+'
+
+test_expect_failure '#17.2: in .git/wt/sub' '
+	cat >17/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 17/.git/wt/sub
+'
+
+test_expect_failure '#17.2: at root' '
+	cat >17/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17
+setup: prefix: (null)
+EOF
+	test_repo 17
+'
+
+test_expect_failure '#17.2: in subdir' '
+	cat >17/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/sub
+setup: prefix: (null)
+EOF
+	test_repo 17/sub
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
