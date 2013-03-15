From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 02/45] clean: remove unused variable "seen"
Date: Fri, 15 Mar 2013 13:06:17 +0700
Message-ID: <1363327620-29017-3-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:24:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO4H-0003WG-H4
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab3COGYO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:24:14 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:50644 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab3COGYM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:24:12 -0400
Received: by mail-ia0-f176.google.com with SMTP id i18so2841770iac.7
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=B7fggGee4wy4I9ie+0JjiiqeEw4wyaPQDD9YkL6P38o=;
        b=vU74jn+y3JnRfm1+xm2b1nEuKd2FYHbgf205FRtDsV1t22/vw9oY9Q6ucWYCm3yfRf
         sOVdAdp3XsVgrZauSoht/Y51OegVaqIYxdZcrBdxSNWWxq6UScg+aG8l+lSKjk8oJCrS
         J95FcoDknqvR9Hdrj0GeMk7VRiiHbZUh1Zu0TVmyFU+U9+VsIUCnitSFtByEAQX3kWcR
         8lniwTlhN8PjmNcK12ie4v+c41y1UIBJ6EhFur7CNwuatTJNvzxyzRoFgEPbisn4L4/5
         E3qq7CWhqnCpCiFytRiPVoOaAQ4zGLfWJcXRZ7d5dugqBdxhCIIXLHh9+Tk6LW/Y9Fxg
         hLfA==
X-Received: by 10.50.5.180 with SMTP id t20mr414171igt.80.1363328652167;
        Thu, 14 Mar 2013 23:24:12 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id vb15sm731862igb.9.2013.03.14.23.24.09
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:24:11 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:07:14 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218189>


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
1.8.0.rc0.19.g7bbb31d
