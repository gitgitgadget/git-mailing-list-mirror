From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/45] clean: remove unused variable "seen"
Date: Sun,  9 Jun 2013 13:25:34 +0700
Message-ID: <1370759178-1709-2-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:25:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ3q-0007xj-8T
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495Ab3FIGY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:24:59 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:47997 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab3FIGY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:24:59 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so5122314pbc.16
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8PoTihG5yYHoVBx+waOaLmd0vAx6+U2OLnBbI/my9uM=;
        b=zsMjub1Lii2DnxEDQfckTDySehYCXIrrQp0Wi0PofAPyNod8G3rVv9eusfrYt8AKMf
         vDgkXlZu2R3QXkr8vMG+fEd1z7cRPOek8x/CMf3j7jF3LLF/yMIXX/Zpj0w0CGEzGWu4
         yrQ3yKbuGp4ozkPyo8HC4xQDzlm414E4+IUAkg+x5HvPhera5y7gpPefh61zouNvPqF/
         7itr//mSMkanOubQuKHYF68mFfE62uYnoVqPrFScu5+dIs4ZbzT+aWfEO2tRXw/anJAn
         daDFq+FLWc2W3PzmkGtnmeKdMYJsImCfWcYmMfbNvwgZVTi2d1F6VNn6jZ+TOSUDxW4x
         7rRw==
X-Received: by 10.68.164.226 with SMTP id yt2mr5037859pbb.203.1370759098608;
        Sat, 08 Jun 2013 23:24:58 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id wi6sm5520438pbc.22.2013.06.08.23.24.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:24:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:26:30 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226893>


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
