From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/12] dir.c: rename path_excluded() to is_path_excluded()
Date: Mon, 15 Oct 2012 13:27:56 +0700
Message-ID: <1350282486-4646-2-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:28:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeAM-0000eh-V8
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab2JOG2c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:28:32 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60685 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab2JOG2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:28:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4626454pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VFAoJ+b3g53U1unvt5urhm8z5XPWTBm7p6se/+2IuIk=;
        b=RRKrpbRTN7hqOaMnu21WwOodI//D3n77F6XOwa1W4D5469S007LQ/PccxMpSEzWWUn
         lX4GYjkO+eNHUTAvMt2oOeujvKGDLNcPNwyV8818dtqfVKriSDQT6hoOP+A+PYBLoIlZ
         ykRcFFBbyFlD70LdiTxXAprzp+79f9twpCVpMkk9DT5IMTwX3wEDA6nwhlt+OlV9Ptvs
         0pV2EocblAteaLu46boq0Ki0pSX7xXjSUfBAVBWsLOvQue40FM9FHT/KfmqVmyQZ2JDF
         0BuvMys1FpbNUiNuO7iLKSDX7BlVRvpuwd2FiwTEhgm8tsoK2Gsm5q8fEK/5PwKREvUZ
         k0tQ==
Received: by 10.66.75.162 with SMTP id d2mr30292103paw.27.1350282511758;
        Sun, 14 Oct 2012 23:28:31 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id c5sm8597545pay.5.2012.10.14.23.28.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:28:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:28:21 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207713>

=46rom: Adam Spiers <git@adamspiers.org>

Start adopting clearer names for exclude functions.  This 'is_*'
naming pattern for functions returning booleans was agreed here:

http://thread.gmane.org/gmane.comp.version-control.git/204661/focus=3D2=
04924

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c      | 2 +-
 builtin/ls-files.c | 2 +-
 dir.c              | 4 ++--
 dir.h              | 2 +-
 unpack-trees.c     | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 89dce56..c689f37 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -453,7 +453,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 			    && !file_exists(pathspec[i])) {
 				if (ignore_missing) {
 					int dtype =3D DT_UNKNOWN;
-					if (path_excluded(&check, pathspec[i], -1, &dtype))
+					if (is_path_excluded(&check, pathspec[i], -1, &dtype))
 						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
 				} else
 					die(_("pathspec '%s' did not match any files"),
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 31b3f2d..ef7f99a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -203,7 +203,7 @@ static void show_ru_info(void)
 static int ce_excluded(struct path_exclude_check *check, struct cache_=
entry *ce)
 {
 	int dtype =3D ce_to_dtype(ce);
-	return path_excluded(check, ce->name, ce_namelen(ce), &dtype);
+	return is_path_excluded(check, ce->name, ce_namelen(ce), &dtype);
 }
=20
 static void show_files(struct dir_struct *dir)
diff --git a/dir.c b/dir.c
index f7219b5..6dfb815 100644
--- a/dir.c
+++ b/dir.c
@@ -679,8 +679,8 @@ void path_exclude_check_clear(struct path_exclude_c=
heck *check)
  * A path to a directory known to be excluded is left in check->path t=
o
  * optimize for repeated checks for files in the same excluded directo=
ry.
  */
-int path_excluded(struct path_exclude_check *check,
-		  const char *name, int namelen, int *dtype)
+int is_path_excluded(struct path_exclude_check *check,
+		     const char *name, int namelen, int *dtype)
 {
 	int i;
 	struct strbuf *path =3D &check->path;
diff --git a/dir.h b/dir.h
index 69cc7d2..d40aeea 100644
--- a/dir.h
+++ b/dir.h
@@ -101,7 +101,7 @@ struct path_exclude_check {
 };
 extern void path_exclude_check_init(struct path_exclude_check *, struc=
t dir_struct *);
 extern void path_exclude_check_clear(struct path_exclude_check *);
-extern int path_excluded(struct path_exclude_check *, const char *, in=
t namelen, int *dtype);
+extern int is_path_excluded(struct path_exclude_check *, const char *,=
 int namelen, int *dtype);
=20
=20
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
diff --git a/unpack-trees.c b/unpack-trees.c
index 33a5819..3ac6370 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1372,7 +1372,7 @@ static int check_ok_to_remove(const char *name, i=
nt len, int dtype,
 		return 0;
=20
 	if (o->dir &&
-	    path_excluded(o->path_exclude_check, name, -1, &dtype))
+	    is_path_excluded(o->path_exclude_check, name, -1, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
--=20
1.8.0.rc0.29.g1fdd78f
