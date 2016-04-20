From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/12] worktree.c: mark current worktree
Date: Wed, 20 Apr 2016 20:24:45 +0700
Message-ID: <1461158693-21289-5-git-send-email-pclouds@gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 15:26:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ass95-0004sf-RO
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbcDTN0P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 09:26:15 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32849 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbcDTN0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:26:13 -0400
Received: by mail-pa0-f46.google.com with SMTP id zm5so17978184pac.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OEc6ZcITpQSG4Gi6HCBglMSGasm1AblYyZkH9gT5jBE=;
        b=j7xmla2eqh6aTnaU4qokfUOrnfSu+mMBIGvGnA5H8lG7NWOz5vb8K5givbPUX1cc+H
         R1Nsz/0Nmgv0LT7GgFRypzlXD4DXseOxh/f9td6CvTVuWyJ7cCjMd585eHDXE0cFpvUy
         VELSJk3g6hrYfCIXDtd3C5r3yuBX0LMRNqBDNmKgodbLqI+moIEJdTKFYT0uN1h9xacv
         F8wfWsxrYVpYDfDP+Yl+Og1ZSNgBWwsUza52mTZ1WcCk8E8KtEkcwb3sNBvQJqEGN00A
         iw3Hj4HadUNnWGrOKf6yivVjf1veKVmMdZnYA6WtY+MC1z5z94gmRYT/NCc2FlrPuOKl
         O7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OEc6ZcITpQSG4Gi6HCBglMSGasm1AblYyZkH9gT5jBE=;
        b=cYPesKzMq5cKfJcrVbbzQFy2St6PY28d+2XWmYJA1Y8bkRtAkxjjMYGUXpheLl7Uep
         FYJt+Qsa3rDRK3vZKTD1DWTt1XZ4Az9CCgIOAQ6O14glye4LZM9s9J/Zki9nNMvFOpiW
         OPTtS6qGiHsDuF36ueZyRC/wFNgY0PE2CcHCO4XG5qJfxpCEXU7U0l7RWeS/ICDAikbb
         09a+X7nKaC/2aqhLf/7Ar7N3wA0h8192hqh3F/oZsHqtRfa+zT6saQU09msb2jvzy5r2
         L11WzKsQXPX8PXf70qEJIHM8GHpthZeRtdltunIJ9Lr8PDm48fCOIFeoRMng+lOa6fkv
         15Yg==
X-Gm-Message-State: AOPr4FW+PzHjGyDKjyqWGoJrK/qGTnZgZ7lzv/XE3DEsjkTCZJakyBDNYN+1Hw9eYu6U9Q==
X-Received: by 10.66.132.37 with SMTP id or5mr12190317pab.144.1461158766595;
        Wed, 20 Apr 2016 06:26:06 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id y128sm2672324pfb.13.2016.04.20.06.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 06:26:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:26:18 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292014>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 18 +++++++++++++++++-
 worktree.h |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index 360ba41..452f64a 100644
--- a/worktree.c
+++ b/worktree.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "strbuf.h"
 #include "worktree.h"
+#include "dir.h"
=20
 void free_worktrees(struct worktree **worktrees)
 {
@@ -94,6 +95,7 @@ static struct worktree *get_main_worktree(void)
 	worktree->is_bare =3D is_bare;
 	worktree->head_ref =3D NULL;
 	worktree->is_detached =3D is_detached;
+	worktree->is_current =3D 0;
 	add_head_info(&head_ref, worktree);
=20
 done:
@@ -138,6 +140,7 @@ static struct worktree *get_linked_worktree(const c=
har *id)
 	worktree->is_bare =3D 0;
 	worktree->head_ref =3D NULL;
 	worktree->is_detached =3D is_detached;
+	worktree->is_current =3D 0;
 	add_head_info(&head_ref, worktree);
=20
 done:
@@ -150,10 +153,11 @@ done:
 struct worktree **get_worktrees(void)
 {
 	struct worktree **list =3D NULL;
+	struct strbuf git_dir =3D STRBUF_INIT;
 	struct strbuf path =3D STRBUF_INIT;
 	DIR *dir;
 	struct dirent *d;
-	int counter =3D 0, alloc =3D 2;
+	int i, counter =3D 0, alloc =3D 2;
=20
 	list =3D xmalloc(alloc * sizeof(struct worktree *));
=20
@@ -178,6 +182,18 @@ struct worktree **get_worktrees(void)
 	}
 	ALLOC_GROW(list, counter + 1, alloc);
 	list[counter] =3D NULL;
+
+	strbuf_addstr(&git_dir, absolute_path(get_git_dir()));
+	for (i =3D 0; i < counter; i++) {
+		struct worktree *wt =3D list[i];
+		strbuf_addstr(&path, absolute_path(get_worktree_git_dir(wt)));
+		wt->is_current =3D !strcmp_icase(git_dir.buf, path.buf);
+		strbuf_reset(&path);
+		if (wt->is_current)
+			break;
+	}
+	strbuf_release(&git_dir);
+	strbuf_release(&path);
 	return list;
 }
=20
diff --git a/worktree.h b/worktree.h
index d71d7ec..625fb8d 100644
--- a/worktree.h
+++ b/worktree.h
@@ -8,6 +8,7 @@ struct worktree {
 	unsigned char head_sha1[20];
 	int is_detached;
 	int is_bare;
+	int is_current;
 };
=20
 /* Functions for acting on the information about worktrees. */
--=20
2.8.0.rc0.210.gd302cd2
