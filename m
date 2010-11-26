From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/47] t1510: setup case #18
Date: Fri, 26 Nov 2010 22:32:17 +0700
Message-ID: <1290785563-15339-22-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:41:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Qk-0004mb-6U
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171Ab0KZPle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:41:34 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:42582 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998Ab0KZPld (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:41:33 -0500
Received: by pxi15 with SMTP id 15so352657pxi.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1dGnBXAvcZPqG9dKVxjt6PR42lUWauz14H9crEw1BHo=;
        b=ZxcH+Y7Q98FeDU1N6/GtuQfzGzD4uG6l1yOzKnG6JO4dEls9Xoq1eBw4H+IJVLNLOC
         LFCgX3n/l/7Ei1ftTMbkmgt0Jev/cumGxRS4Rcu/RGAnJLbKnq8q49nGQjhapgsbINmp
         NiMc9oXsQgd9nlbQ2ZnWAZUy5/DJ/kYpBPVFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PIGhqQrBN68h6SoN/VBI14WJ3VJ5Awuc2rJ2yrXbGHDTisH2li7TQCaq9mC9hIScIP
         1mukn0OTiyep5ABCUhIbZYmO9kCZ04TIwhVoIkBFxgUpISfd3/37XopKZSi5Vv4bwUiz
         WIZPrWMcj6jYWYMuFV2gQdDkrsmN1CSmMc2gM=
Received: by 10.143.29.1 with SMTP id g1mr2521138wfj.83.1290786092924;
        Fri, 26 Nov 2010 07:41:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id q13sm2681158wfc.17.2010.11.26.07.41.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:41:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:40:20 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162237>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   71 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index e298a16..069af70 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2489,4 +2489,75 @@ EOF
 	test_repo 17/sub
 '
=20
+#
+# case #18
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+#  - no worktree (rule #8)
+#  - cwd is unchanged
+#  - prefix is NULL
+#  - git_dir is set to $GIT_DIR
+#  - cwd can't be outside worktree
+
+test_expect_success '#18: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 18 18/sub &&
+	cd 18 &&
+	git init &&
+	mkdir .git/wt .git/wt/sub &&
+	git config core.bare true &&
+	cd ..
+'
+
+test_expect_success '#18: (rel) at root' '
+	cat >18/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/18
+setup: prefix: (null)
+EOF
+	 test_repo 18 .git
+'
+
+test_expect_success '#18: at root' '
+	cat >18/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/18/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/18
+setup: prefix: (null)
+EOF
+	 test_repo 18 "$TRASH_DIRECTORY/18/.git"
+'
+
+test_expect_success '#18: (rel) in subdir' '
+	cat >18/sub/expected <<EOF &&
+setup: git_dir: ../.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/18/sub
+setup: prefix: (null)
+EOF
+	test_repo 18/sub ../.git
+'
+
+test_expect_success '#18: in subdir' '
+	cat >18/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/18/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/18/sub
+setup: prefix: (null)
+EOF
+	test_repo 18/sub "$TRASH_DIRECTORY/18/.git"
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
