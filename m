From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/47] t1510: setup case #2
Date: Fri, 26 Nov 2010 22:32:01 +0700
Message-ID: <1290785563-15339-6-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:36:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0LE-0001Vp-La
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab0KZPf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:35:59 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:47820 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0KZPf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:35:58 -0500
Received: by pxi15 with SMTP id 15so351958pxi.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1ArNYCBe/oGN2tTg+alm5A1fSf+o7FqjATtAoRw+3ns=;
        b=KN0TqhvNGawux93g9xFNFDdgP8u0ex84lIt0sflz/S9ZczD5w/HbCjQSNcskDaEgvy
         UJcXwaEic57VMmBBaU0cZvEFwJN/cqJ0mQK0MsCvBVEv8OyJE4Sm/TNikdsncocPc1JB
         /N+D0rwX3BOoE56Mtu7VgDvRBorPOpB/zVXok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XTZ8TyjWkw9Fd2LLlGbuMi4lHVwIXnb9+WJiZnZN4iItKfjONptVqgInrdKBmyF+vo
         SfM35msbLjmWSx4YzV8GFEdJzMkeE2FRrtvDjpfwEq4DSsZ9HDptb6CgfYqvRKfkdisr
         nuKkMjdl5bf0NATvrXV9zRp/4Zo6zVccNSMV4=
Received: by 10.143.7.6 with SMTP id k6mr2483414wfi.347.1290785757959;
        Fri, 26 Nov 2010 07:35:57 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w14sm2673182wfd.18.2010.11.26.07.35.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:35:56 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:34:48 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162221>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   67 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 4e9c425..febf9c4 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -152,4 +152,71 @@ EOF
 	test_repo 1/sub
 '
=20
+#
+# case #2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is at original cwd
+#  - cwd is unchanged
+#  - prefix is NULL
+#  - git_dir is set to $GIT_DIR
+#  - cwd can't be outside worktree
+
+test_expect_success '#2: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 2 2/sub &&
+	cd 2 && git init && cd ..
+'
+
+test_expect_success '#2: at root' '
+	cat >2/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/2/.git
+setup: worktree: $TRASH_DIRECTORY/2
+setup: cwd: $TRASH_DIRECTORY/2
+setup: prefix: (null)
+EOF
+	test_repo 2 "$TRASH_DIRECTORY/2/.git"
+'
+
+test_expect_success '#2: in subdir' '
+	cat >2/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/2/.git
+setup: worktree: $TRASH_DIRECTORY/2/sub
+setup: cwd: $TRASH_DIRECTORY/2/sub
+setup: prefix: (null)
+EOF
+	test_repo 2/sub "$TRASH_DIRECTORY/2/.git"
+'
+
+test_expect_success '#2: relative GIT_DIR at root' '
+	cat >2/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/2
+setup: cwd: $TRASH_DIRECTORY/2
+setup: prefix: (null)
+EOF
+	test_repo 2 .git
+'
+
+test_expect_success '#2: relative GIT_DIR in subdir' '
+	cat >2/sub/expected <<EOF &&
+setup: git_dir: ../.git
+setup: worktree: $TRASH_DIRECTORY/2/sub
+setup: cwd: $TRASH_DIRECTORY/2/sub
+setup: prefix: (null)
+EOF
+	test_repo 2/sub ../.git
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
