From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/47] t1510: setup case #10
Date: Fri, 26 Nov 2010 22:32:09 +0700
Message-ID: <1290785563-15339-14-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:38:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Nz-00039S-VM
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab0KZPic convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:38:32 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031Ab0KZPic (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:38:32 -0500
Received: by mail-pz0-f46.google.com with SMTP id 6so349039pzk.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jAtTFWRBiGYVtIUlMuMQ+nLuT+mcUU91DOahge1D85g=;
        b=Qbn2IQV6eUWNeb9/cemhsN2vQgQOWzHPu80vfXU/lR0bNc3z8Me9XoSck0eSuEyXws
         f2tniHgOixjh6LkvfFaNbwKC/eNbOfhdvQNy6Zoz/eIisv6+2c1SsXtwqFxoRZDaZdzi
         /qiu++F9WrqUs/+d96Cit1rbRLL3MFkX7eIGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UH9S3/+gKnCPbHizhDgE7jocaw/CnkBfRW7UIvduZlYaSc+AQEb/Ms8PIT5sY53Dus
         tljONMTAY8dnFfqPTsXcxH75xDLZ9busd2B7ZmSiAr+uJBRvzwF3gONw33adPUscgfI6
         jpqhxZ4ndpidDfujpTZ2rr8DARNJk6JhGKO+0=
Received: by 10.142.11.5 with SMTP id 5mr2495188wfk.312.1290785911861;
        Fri, 26 Nov 2010 07:38:31 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id v19sm2683544wfh.0.2010.11.26.07.38.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:38:30 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:37:16 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162230>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   67 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index e258869..3f19ff1 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1233,4 +1233,71 @@ EOF
 	test_repo 9/sub
 '
=20
+#
+# case #10
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #2 except that git_dir is set by .git file
+
+test_expect_success '#10: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 10 10/sub &&
+	cd 10 &&
+	git init &&
+	mv .git ../10.git &&
+	echo gitdir: ../10.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#10: at root' '
+	cat >10/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/10.git
+setup: worktree: $TRASH_DIRECTORY/10
+setup: cwd: $TRASH_DIRECTORY/10
+setup: prefix: (null)
+EOF
+	test_repo 10 "$TRASH_DIRECTORY/10/.git"
+'
+
+test_expect_failure '#10: in subdir' '
+	cat >10/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/10.git
+setup: worktree: $TRASH_DIRECTORY/10/sub
+setup: cwd: $TRASH_DIRECTORY/10/sub
+setup: prefix: (null)
+EOF
+	test_repo 10/sub "$TRASH_DIRECTORY/10/.git"
+'
+
+test_expect_failure '#10: relative GIT_DIR at root' '
+	cat >10/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/10.git
+setup: worktree: $TRASH_DIRECTORY/10
+setup: cwd: $TRASH_DIRECTORY/10
+setup: prefix: (null)
+EOF
+	test_repo 10 .git
+'
+
+test_expect_failure '#10: relative GIT_DIR in subdir' '
+	cat >10/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/10.git
+setup: worktree: $TRASH_DIRECTORY/10/sub
+setup: cwd: $TRASH_DIRECTORY/10/sub
+setup: prefix: (null)
+EOF
+	test_repo 10/sub ../.git
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
