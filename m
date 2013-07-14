From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 39/46] Rename field "raw" to "_raw" in struct pathspec
Date: Sun, 14 Jul 2013 15:36:02 +0700
Message-ID: <1373790969-13000-40-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:40:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHqo-0003VB-42
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab3GNIkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:40:08 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:54199 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab3GNIkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:40:06 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so10274753pac.26
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gbB9tUnqs2lUJHOstAqEb9UUEbnQaQt+rAx8VgtH7Yo=;
        b=JwOesM3ViIDL4WDmU5JhTQ4PYAtdwZE1csn8FaXJBaIYTVZo6ao/MMaMqOOGagiI+s
         AXNer9GqH5MtGAOfW2XeQOjyafmFK5B98Eo4YM4G1NBwUMc38BVt0PJWsJ5m8TnGbtCc
         FOnid5Ho4n5R2CBdnQzMDCmtFOIbBCaasIdtnTBB/zMboSiF1Eabmje4DQINuvNrX6Jt
         heIwkl9xhFnwOGOW0yGqqliaHDFsMO0EUsD49L4jihm/kouCf2P/YMAn6032HQHwbRr2
         bGB/csj/9iXJm/mCqAIcYqe0RbV7wUCsjhapiYOlbuQJxf0jXnXP4639Jy55IEEvqWJT
         x1vg==
X-Received: by 10.66.122.99 with SMTP id lr3mr50905745pab.187.1373791206148;
        Sun, 14 Jul 2013 01:40:06 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id we2sm57862781pab.0.2013.07.14.01.40.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:40:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:40:17 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230351>

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
index bdb03f3..1c4f48e 100644
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
index 9423fbb..bf22498 100644
--- a/dir.c
+++ b/dir.c
@@ -152,7 +152,7 @@ int fill_directory(struct dir_struct *dir, const st=
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
@@ -1293,7 +1293,7 @@ int read_directory(struct dir_struct *dir, const =
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
index 3d1386d..da802e2 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -287,7 +287,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		raw[0] =3D prefix;
 		raw[1] =3D NULL;
 		pathspec->nr =3D 1;
-		pathspec->raw =3D raw;
+		pathspec->_raw =3D raw;
 		return;
 	}
=20
@@ -297,7 +297,7 @@ void parse_pathspec(struct pathspec *pathspec,
=20
 	pathspec->nr =3D n;
 	pathspec->items =3D item =3D xmalloc(sizeof(*item) * n);
-	pathspec->raw =3D argv;
+	pathspec->_raw =3D argv;
 	prefixlen =3D prefix ? strlen(prefix) : 0;
=20
 	for (i =3D 0; i < n; i++) {
@@ -357,7 +357,7 @@ const char **get_pathspec(const char *prefix, const=
 char **pathspec)
 		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, pathspec);
-	return ps.raw;
+	return ps._raw;
 }
=20
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
diff --git a/pathspec.h b/pathspec.h
index 31a9c96..0f6739d 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -11,7 +11,7 @@
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
