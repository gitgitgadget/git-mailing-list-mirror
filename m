From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/25] worktree.c: add update_worktree_location()
Date: Wed, 13 Apr 2016 20:15:38 +0700
Message-ID: <1460553346-12985-18-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:17:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKfj-0004bM-NE
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760670AbcDMNRX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:17:23 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35150 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725AbcDMNRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:17:21 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so4128301pfr.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6CVD3wh4bD5TAahr591LPLqmRKNvIOlcGlc7oox2rQo=;
        b=G9sbmq7VN56knzrRYNBhJh+Q0rkkuUxsNku3KULoVynfVD0GqD/oxRT20Q2oUrHYtq
         qoJ2AJPIvMGcPlREDCF+ZDMTAQGoJlK+NG17jRteLwqKs1UaCUOi8RSMJ2//2JQtqJDE
         VB21GHP4JyqxzyVuZt/YDB9s9HiuHHWzknWeJlBE+uh5moGzFM56YVJQcwnVF7YEs40/
         i4ertsdf4TBDeIV0JJmB56GlarCaGEVpc1gMk9rnFxo1YNgEQBEhPQQJNOPZVLmktZB3
         q4HuG9LIyXNQ4vbhUp6vrhHOP1nsphuO8BWwbCS+m0b7aw7rDlxJfGyypDAgGNKWh1df
         +zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6CVD3wh4bD5TAahr591LPLqmRKNvIOlcGlc7oox2rQo=;
        b=KLt4/Q1GqwFzSDaaJQdlFzoEtreqtY5nfJ0yB83UNFz+88+lLsmDVGJVMpZ9R2blvU
         QqizuvXHK2gMG6n+GiB5WmZYZfOjz7y8EXKhKcrM58Ne9Hedgcd9GVqqL/oZJYRNWvv3
         379154g/didGK0Wpks+0WmQNoqtg/QT2FyNW/5VZcM+r8Aq2b9QA3s0aYyf+mEKnDg5D
         Hxt6e4Gutf456xfLxqkPyHv1uxdpmA6x2n7l0wnJRrkwhvttpHeZo12slm+6SVB7x4cZ
         Yq/4hwcXJEDVrZ4w5kES/gXgxHFRJoStK27Mqxl6rhlnu40PVdn/Cmro2617avqBAmL3
         DJGQ==
X-Gm-Message-State: AOPr4FUOu18JuUgHNi2OCxdtxyzvIALXbNIW+zYVCLIBkFhH7s/FCwDya0RniCqFTF+RTg==
X-Received: by 10.98.18.1 with SMTP id a1mr12979498pfj.39.1460553440723;
        Wed, 13 Apr 2016 06:17:20 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id r17sm30309452pfj.39.2016.04.13.06.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:17:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:17:26 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291439>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 25 +++++++++++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/worktree.c b/worktree.c
index 28195b1..e526e25 100644
--- a/worktree.c
+++ b/worktree.c
@@ -282,6 +282,31 @@ int validate_worktree(const struct worktree *wt, i=
nt quiet)
 	return 0;
 }
=20
+int update_worktree_location(struct worktree *wt, const char *path_)
+{
+	struct strbuf path =3D STRBUF_INIT;
+	int ret =3D 0;
+
+	if (is_main_worktree(wt))
+		return 0;
+
+	strbuf_add_absolute_path(&path, path_);
+	if (strcmp_icase(wt->path, path.buf)) {
+		if (!write_file_gently(git_common_path("worktrees/%s/gitdir",
+						       wt->id),
+				       "%s/.git", real_path(path.buf))) {
+			free(wt->path);
+			wt->path =3D strbuf_detach(&path, NULL);
+			ret =3D 0;
+		} else
+			ret =3D sys_error(_("failed to update '%s'"),
+					git_common_path("worktrees/%s/gitdir",
+							wt->id));
+	}
+	strbuf_release(&path);
+	return ret;
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
diff --git a/worktree.h b/worktree.h
index 0d6be18..bbe40ef 100644
--- a/worktree.h
+++ b/worktree.h
@@ -44,6 +44,12 @@ extern int is_main_worktree(const struct worktree *w=
t);
 extern int validate_worktree(const struct worktree *wt, int quiet);
=20
 /*
+ * Update worktrees/xxx/gitdir with the new path.
+ */
+extern int update_worktree_location(struct worktree *wt,
+				    const char *path_);
+
+/*
  * Free up the memory for worktree
  */
 extern void clear_worktree(struct worktree *);
--=20
2.8.0.rc0.210.gd302cd2
