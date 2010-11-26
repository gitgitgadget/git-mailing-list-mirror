From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/47] t1510: setup case #21
Date: Fri, 26 Nov 2010 22:32:20 +0700
Message-ID: <1290785563-15339-25-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:43:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0SV-0005sJ-W7
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab0KZPnW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:43:22 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52690 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184Ab0KZPnU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:43:20 -0500
Received: by pva4 with SMTP id 4so351834pva.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BI7rYIbhu8VFDpeUhn3NiaW3wWBET8w8MHXnryGn9cI=;
        b=T3FKS941R8fPnP8HLM7yOBQdY7DYhf8onI75sAmnks2C8WVzg6KkmIYsYCYJ1Xmxcr
         WX0Sxn6nvtjKxtdwGzt6ylRxgXmukCD4Jcdb1HGApommHT+hRSasQ82x422tUEQKrTD/
         q2tRy/NJz7pmVjrwu2xJ0cvE6Oblk+Yj8fox8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=moq+/CyGNWXMwQBeYze/dlNH6ILvjkAwGF33ekm+bH4PF0YNSIwU4MPY280QRJvwpG
         xcidGUAf3Typ1tiW+fHnPKBE68PflUhEoux3SBf633AvRwQO1A8gJjLn6zSg2x8SKg/A
         wqXN3fXAfw7ZZavtAPkgRdFOv8JrtXieUhp78=
Received: by 10.142.211.20 with SMTP id j20mr2493645wfg.408.1290786200219;
        Fri, 26 Nov 2010 07:43:20 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id y42sm2684598wfd.10.2010.11.26.07.43.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:43:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:41:39 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162240>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  130 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index db52f36..47d6c4b 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2954,4 +2954,134 @@ EOF
 	test_repo 20/sub
 '
=20
+#
+# case #21.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+# GIT_WORK_TREE/core.worktree are ignored -> #20.1
+
+test_expect_success '#21.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 21 21/sub &&
+	cd 21 &&
+	git init &&
+	git config core.worktree non-existent &&
+	GIT_WORK_TREE=3Dnon-existent-too &&
+	export GIT_WORK_TREE &&
+	mkdir .git/wt .git/wt/sub &&
+	cd ..
+'
+
+test_expect_failure '#21.1: at .git' '
+	cat >21/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git
+setup: prefix: (null)
+EOF
+	test_repo 21/.git
+'
+
+test_expect_failure '#21.1: in .git/wt' '
+	cat >21/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 21/.git/wt
+'
+
+test_expect_failure '#21.1: in .git/wt/sub' '
+	cat >21/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 21/.git/wt/sub
+'
+
+#
+# case #21.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# GIT_WORK_TREE/core.worktree are ignored -> #20.2
+
+test_expect_success '#21.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/21/.git/config" core.bare true
+'
+
+test_expect_failure '#21.2: at .git' '
+	cat >21/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git
+setup: prefix: (null)
+EOF
+	test_repo 21/.git
+'
+
+test_expect_failure '#21.2: in .git/wt' '
+	cat >21/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 21/.git/wt
+'
+
+test_expect_failure '#21.2: in .git/wt/sub' '
+	cat >21/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 21/.git/wt/sub
+'
+
+test_expect_failure '#21.2: at root' '
+	cat >21/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21
+setup: prefix: (null)
+EOF
+	test_repo 21
+'
+
+test_expect_failure '#21.2: in subdir' '
+	cat >21/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/sub
+setup: prefix: (null)
+EOF
+	test_repo 21/sub
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
