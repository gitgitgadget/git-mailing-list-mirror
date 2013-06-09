From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 45/45] Rename field "raw" to "_raw" in struct pathspec
Date: Sun,  9 Jun 2013 13:26:18 +0700
Message-ID: <1370759178-1709-46-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:29:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ8Q-0002D1-A1
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab3FIG3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:29:46 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:58918 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab3FIG3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:29:45 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so194434pdi.41
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lloMe2gtoB+Ct8OBSkvchuwoSex9gyVdkq2wCCCJLCo=;
        b=Hh+ALfF7UTms0Vt6K6oUU9FYqCZY3iCVV9NV7j57kmS+71MOhXqEPp7P72o8Bz6XZX
         UwF2Z3a/RdMGHOgQHXp0lUpWxQqQmNjn4uq4mjLEtF1pI8ju7jpQqtUwz3ad+U4oTJxO
         gyC3GPNujUnnPY3hh529vgqkWyC7h6KAozHIHMQ+prvJIIXt9rWNqP64GUqkL+RtHCKp
         jXvFxU3ddHx1UhX/E8mJgT2IUOWe44TTnR5Z5l1e05H8UL3evq2lg70SQmnG73C038s0
         CcWCOVf0Rov9FDzDx6ht3Ess2k8mon7hUqoQbGP+tkwNw3I3v823COQyOxUIy0YHhyjp
         zBBQ==
X-Received: by 10.66.37.43 with SMTP id v11mr9125103paj.108.1370759385084;
        Sat, 08 Jun 2013 23:29:45 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id vv6sm10266830pab.6.2013.06.08.23.29.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:29:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:31:16 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226937>

This patch is essentially no-op. It helps catching new use of this
field though. This field is introduced as an intermediate step for the
pathspec conversion and will be removed eventually. At this stage no
more access sites should be introduced.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-tree.c | 2 +-
 dir.c             | 4 ++--
 pathspec.c        | 6 +++---
 pathspec.h        | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 1056634..7882352 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -36,7 +36,7 @@ static int show_recursive(const char *base, int basel=
en, const char *pathname)
 	if (ls_options & LS_RECURSIVE)
 		return 1;
=20
-	s =3D pathspec.raw;
+	s =3D pathspec._raw;
 	if (!s)
 		return 0;
=20
diff --git a/dir.c b/dir.c
index 7e931af..0a79929 100644
--- a/dir.c
+++ b/dir.c
@@ -158,7 +158,7 @@ int fill_directory(struct dir_struct *dir, const st=
ruct pathspec *pathspec)
 	len =3D common_prefix_len(pathspec);
=20
 	/* Read the directory and prune it */
-	read_directory(dir, pathspec->nr ? pathspec->raw[0] : "", len, pathsp=
ec);
+	read_directory(dir, pathspec->nr ? pathspec->_raw[0] : "", len, paths=
pec);
 	return len;
 }
=20
@@ -1308,7 +1308,7 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const stru
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
=20
-	simplify =3D create_simplify(pathspec ? pathspec->raw : NULL);
+	simplify =3D create_simplify(pathspec ? pathspec->_raw : NULL);
 	if (!len || treat_leading_path(dir, path, len, simplify))
 		read_directory_recursive(dir, path, len, 0, simplify);
 	free_simplify(simplify);
diff --git a/pathspec.c b/pathspec.c
index e3581da..8ae1f8c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -376,7 +376,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		raw[0] =3D prefix;
 		raw[1] =3D NULL;
 		pathspec->nr =3D 1;
-		pathspec->raw =3D raw;
+		pathspec->_raw =3D raw;
 		return;
 	}
=20
@@ -386,7 +386,7 @@ void parse_pathspec(struct pathspec *pathspec,
=20
 	pathspec->nr =3D n;
 	pathspec->items =3D item =3D xmalloc(sizeof(*item) * n);
-	pathspec->raw =3D argv;
+	pathspec->_raw =3D argv;
 	prefixlen =3D prefix ? strlen(prefix) : 0;
=20
 	for (i =3D 0; i < n; i++) {
@@ -447,7 +447,7 @@ const char **get_pathspec(const char *prefix, const=
 char **pathspec)
 		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
 		       prefix, pathspec);
-	return ps.raw;
+	return ps._raw;
 }
=20
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
diff --git a/pathspec.h b/pathspec.h
index 7608172..5ba42e5 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -15,7 +15,7 @@
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
 struct pathspec {
-	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
+	const char **_raw; /* get_pathspec() result, not freed by free_pathsp=
ec() */
 	int nr;
 	unsigned int has_wildcard:1;
 	unsigned int recursive:1;
--=20
1.8.2.83.gc99314b
