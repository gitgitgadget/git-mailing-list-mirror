From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 45/45] Rename field "raw" to "_raw" in struct pathspec
Date: Fri, 15 Mar 2013 13:07:00 +0700
Message-ID: <1363327620-29017-46-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:29:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO99-0000Rm-2p
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab3COG3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:29:16 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:38422 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763Ab3COG3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:29:14 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so4019593ieb.31
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Re+hs/mxkTZ+0SC3mgmn6aS7UwhMBVILljwnBNIru50=;
        b=Gpr/IatvnLzDihYw0ofwb3ybkaBhyzKWnW2hOTOL1EkL8wPTRxb9edQlC+DQRadZbJ
         rxa6qp+Awq0BwtlI1AKPCu37KFH9bs/cwbsX6XcgBfW0vT4NCM5REg+ljg3OI7zKqbXl
         wBKAHnKr+O4w4VVB8Bc7XpoXAOVLVVflz/cKeZyRTpbjApOhiF2MxH0MefX0ave/2EF4
         qP3SeV4JStucBdRKlAdmea0iCwj/ce093zzTp+/TEiXmRF7okdCwQK/i9xGGdH8YyqZN
         POXkAte86FfaAeWWTuHiY8SwHSy1PoOA3fOzl0NrTIlIGWU4f2i8/1JbppMzmiydtwM2
         JFQQ==
X-Received: by 10.50.191.133 with SMTP id gy5mr423654igc.50.1363328954407;
        Thu, 14 Mar 2013 23:29:14 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ua6sm635346igb.0.2013.03.14.23.29.11
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:29:13 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:12:17 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218232>

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
index 77cd427..e52c899 100644
--- a/dir.c
+++ b/dir.c
@@ -115,7 +115,7 @@ int fill_directory(struct dir_struct *dir, const st=
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
@@ -1356,7 +1356,7 @@ int read_directory(struct dir_struct *dir, const =
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
index 7ddcf55..9640d88 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -365,7 +365,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		raw[0] =3D prefix;
 		raw[1] =3D NULL;
 		pathspec->nr =3D 1;
-		pathspec->raw =3D raw;
+		pathspec->_raw =3D raw;
 		return;
 	}
=20
@@ -375,7 +375,7 @@ void parse_pathspec(struct pathspec *pathspec,
=20
 	pathspec->nr =3D n;
 	pathspec->items =3D item =3D xmalloc(sizeof(*item) * n);
-	pathspec->raw =3D argv;
+	pathspec->_raw =3D argv;
 	prefixlen =3D prefix ? strlen(prefix) : 0;
=20
 	for (i =3D 0; i < n; i++) {
@@ -436,7 +436,7 @@ const char **get_pathspec(const char *prefix, const=
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
index 9a0c5d5..84f279d 100644
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
1.8.0.rc0.19.g7bbb31d
