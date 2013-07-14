From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/46] clean: remove unused variable "seen"
Date: Sun, 14 Jul 2013 15:35:24 +0700
Message-ID: <1373790969-13000-2-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:36:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHnE-000125-6v
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab3GNIg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:36:27 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35730 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:36:26 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so10211333pab.36
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8PoTihG5yYHoVBx+waOaLmd0vAx6+U2OLnBbI/my9uM=;
        b=NRgpeQLOTEUwnB6s99ZPmCcTlfyuJAS7kcl0mEpHWN8PuRwUjjqifMU9xaiIpbSl/D
         5R2B73i2elrDBYjmkp3sP7OEciQqiQhMn4kCNae72mYtSAfGD79sF2eaO87S7LeslYmo
         FNjNPJFQHRU1pvat2CPHHi4cXdwtzBhNy0aX0KRGAL7tVsWP6e8JfZnk2EFfQANrGiI6
         bMgqw6/vBiPqw/I+Uzi7VJbKXd7WyWeVReNN8N7oGjgezuF3NMzNtOb7r1dYdVp28S7h
         9xfdsiVzB9R1IJGw09BvZ49SVMO/8on4XfeHjtcnevqfmTXjOXFbGk7lOFM8uU+RReYl
         3nig==
X-Received: by 10.68.217.38 with SMTP id ov6mr49264704pbc.9.1373790986148;
        Sun, 14 Jul 2013 01:36:26 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id ot4sm57797651pac.17.2013.07.14.01.36.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:36:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:36:37 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230313>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 04e396b..f955a40 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -155,7 +155,6 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 	struct string_list exclude_list =3D STRING_LIST_INIT_NODUP;
 	struct exclude_list *el;
 	const char *qname;
-	char *seen =3D NULL;
 	struct option options[] =3D {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
@@ -214,9 +213,6 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
=20
 	fill_directory(&dir, pathspec);
=20
-	if (pathspec)
-		seen =3D xmalloc(argc > 0 ? argc : 1);
-
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
 		int len, pos;
@@ -250,11 +246,9 @@ int cmd_clean(int argc, const char **argv, const c=
har *prefix)
 		if (lstat(ent->name, &st))
 			continue;
=20
-		if (pathspec) {
-			memset(seen, 0, argc > 0 ? argc : 1);
+		if (pathspec)
 			matches =3D match_pathspec(pathspec, ent->name, len,
-						 0, seen);
-		}
+						 0, NULL);
=20
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
@@ -281,7 +275,6 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 			}
 		}
 	}
-	free(seen);
=20
 	strbuf_release(&directory);
 	string_list_clear(&exclude_list, 0);
--=20
1.8.2.83.gc99314b
