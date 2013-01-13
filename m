From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/31] clean: remove unused variable "seen"
Date: Sun, 13 Jan 2013 19:35:09 +0700
Message-ID: <1358080539-17436-2-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:35:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMn4-0005Y0-D4
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922Ab3AMMfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:35:34 -0500
Received: from mail-da0-f50.google.com ([209.85.210.50]:51170 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876Ab3AMMfd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:35:33 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so1419789dan.9
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=AmE/co83PHETt8nW/VTYfmOoKWnmNSAAm14/Al2xkas=;
        b=Db5lgIABiuJ3cirIAva/O+N4vICFkqHAOopXfNMqKECfjvScALriBc42kP7yTApGld
         /m1DOkK51Jf1hpDRfFRdG7ktU+sWM4etc4Ls6x3QMVPur68G6hGmTHfWSRkEHzDxCXgr
         lq8McBEtlwWc8sedlFb+WFk7fpR1KLrKYf830d38PO7mpVQngka678frVKzUE1WV7EvG
         P50uAIcmS5Q5k+/jSTqleFW/cJqMYrnQxYDDnvv6LqJKMl2pAuSmUCDoWtC2JSy3tr/c
         QCxD0AI6pB1RC5GDsM6KFbuVjODkCg+JIF+HOsN+N//n2T6+Qj4oxf0TQ8WdWrlR2shH
         RwBg==
X-Received: by 10.66.85.74 with SMTP id f10mr222971289paz.38.1358080533341;
        Sun, 13 Jan 2013 04:35:33 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id d1sm6762055pav.6.2013.01.13.04.35.30
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:35:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:35:48 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213341>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 69c1cda..4cdabe0 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -46,7 +46,6 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 	struct strbuf buf =3D STRBUF_INIT;
 	struct string_list exclude_list =3D STRING_LIST_INIT_NODUP;
 	const char *qname;
-	char *seen =3D NULL;
 	struct option options[] =3D {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
 		OPT__DRY_RUN(&show_only, N_("dry run")),
@@ -105,9 +104,6 @@ int cmd_clean(int argc, const char **argv, const ch=
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
@@ -141,11 +137,9 @@ int cmd_clean(int argc, const char **argv, const c=
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
@@ -184,7 +178,6 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 			}
 		}
 	}
-	free(seen);
=20
 	strbuf_release(&directory);
 	string_list_clear(&exclude_list, 0);
--=20
1.8.0.rc2.23.g1fb49df
