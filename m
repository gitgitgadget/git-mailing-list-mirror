From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/25] copy.c: convert bb_(p)error_msg to (sys_)error
Date: Wed, 13 Apr 2016 20:15:26 +0700
Message-ID: <1460553346-12985-6-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:16:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKea-00040O-3a
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760622AbcDMNQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:16:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33198 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760586AbcDMNQO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:16:14 -0400
Received: by mail-pf0-f196.google.com with SMTP id e190so4119421pfe.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rr1U6c0r50P3/sOLiUEgC36BwA+MZhP/q42Uad+Ncvc=;
        b=y30zPdHfvWa9yRU7V2pIivffv1QQ2ZA5eNt5/mPXJHSuTVglf+ebARMzLUyD/SG41K
         fuO1feuiYoNUwpnDX9I672aUY4Mdgk2OidiNFseNZWPDMCqqCLWNzQuyz4Zz27EnemmG
         KxyajL7dpvsI8+zrCDlBg+edArqfEwFmLtE8Nf1GmLXkhRgTGpCrzxTtUx4pjVha3Pfv
         b9RT+orDvRfd2ElTrX9GBSJcJmOoGGVwXIaae+sktAgW7Ij4s05CETXCBu90JDNVu9Pg
         qd2rTX0nBXiYkCh4HbLj76rj6x/jOTiEA0Kq6xFxOyoY5s9dcxU9PvjEc5R8It7f0bcj
         8MqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rr1U6c0r50P3/sOLiUEgC36BwA+MZhP/q42Uad+Ncvc=;
        b=BATuyrvM2BDYH9maACkHtYHTtpv+bV75FAPnkkM+Ojoxw50uZZvwevFzAYfJlExFp9
         zymanXvFAmaLWClJRF/N+LOZVvlOkdRU4EmyiYWUg7QxbzAAzEgA3ylXPemvaXRanC/g
         1DLjJ/2UTb/kxRfiffaL9GfvqT13AFc4ZtVKww27FxbIo6FfAbampGFOirFrkriuapLJ
         iI1ViQ371mKDvFsDACUc4vExM7M+9Mu/dwRlFm54RvXru8MVsKUhql2iIMM/GJFmi0Ic
         QW79C/mIQPOMcTK1D5QMbCjLJmJSLFvNYX60I8VTwb45Xr3QYOezSXls5qqwdQwBlOdm
         stPw==
X-Gm-Message-State: AOPr4FVIqRi/btW0Gl536lzd8kbAA1xHeg9cgbjpj4e8KWIgHe2DGsKk8d52EQ+A9dbTbg==
X-Received: by 10.98.86.146 with SMTP id h18mr12807956pfj.9.1460553374125;
        Wed, 13 Apr 2016 06:16:14 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id x64sm51162481pfa.72.2016.04.13.06.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:16:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:16:20 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291426>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 copy.c | 85 ++++++++++++++++++++++++----------------------------------=
--------
 1 file changed, 31 insertions(+), 54 deletions(-)

diff --git a/copy.c b/copy.c
index d24a8ae..cdb38d5 100644
--- a/copy.c
+++ b/copy.c
@@ -82,23 +82,16 @@ int FAST_FUNC copy_file(const char *source, const c=
har *dest, int flags)
 	smallint dest_exists =3D 0;
 	smallint ovr;
=20
-	if (lstat(source, &source_stat) < 0) {
-		bb_perror_msg("can't stat '%s'", source);
-		return -1;
-	}
+	if (lstat(source, &source_stat) < 0)
+		return sys_error(_("can't stat '%s'"), source);
=20
 	if (lstat(dest, &dest_stat) < 0) {
-		if (errno !=3D ENOENT) {
-			bb_perror_msg("can't stat '%s'", dest);
-			return -1;
-		}
+		if (errno !=3D ENOENT)
+			return sys_error(_("can't stat '%s'"), dest);
 	} else {
-		if (source_stat.st_dev =3D=3D dest_stat.st_dev
-		 && source_stat.st_ino =3D=3D dest_stat.st_ino
-		) {
-			bb_error_msg("'%s' and '%s' are the same file", source, dest);
-			return -1;
-		}
+		if (source_stat.st_dev =3D=3D dest_stat.st_dev &&
+		    source_stat.st_ino =3D=3D dest_stat.st_ino)
+			return error(_("'%s' and '%s' are the same file"), source, dest);
 		dest_exists =3D 1;
 	}
=20
@@ -110,18 +103,14 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
=20
 		/* Did we ever create source ourself before? */
 		tp =3D is_in_ino_dev_hashtable(&source_stat);
-		if (tp) {
+		if (tp)
 			/* We did! it's a recursion! man the lifeboats... */
-			bb_error_msg("recursion detected, omitting directory '%s'",
-					source);
-			return -1;
-		}
+			return error(_("recursion detected, omitting directory '%s'"),
+				     source);
=20
 		if (dest_exists) {
-			if (!S_ISDIR(dest_stat.st_mode)) {
-				bb_error_msg("target '%s' is not a directory", dest);
-				return -1;
-			}
+			if (!S_ISDIR(dest_stat.st_mode))
+				return error(_("target '%s' is not a directory"), dest);
 			/* race here: user can substitute a symlink between
 			 * this check and actual creation of files inside dest */
 		} else {
@@ -134,15 +123,12 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
 			mode |=3D S_IRWXU;
 			if (mkdir(dest, mode) < 0) {
 				umask(saved_umask);
-				bb_perror_msg("can't create directory '%s'", dest);
-				return -1;
+				return sys_error(_("can't create directory '%s'"), dest);
 			}
 			umask(saved_umask);
 			/* need stat info for add_to_ino_dev_hashtable */
-			if (lstat(dest, &dest_stat) < 0) {
-				bb_perror_msg("can't stat '%s'", dest);
-				return -1;
-			}
+			if (lstat(dest, &dest_stat) < 0)
+				return sys_error(_("can't stat '%s'"), dest);
 		}
 		/* remember (dev,inode) of each created dir.
 		 * NULL: name is not remembered */
@@ -172,7 +158,7 @@ int FAST_FUNC copy_file(const char *source, const c=
har *dest, int flags)
 		if (!dest_exists
 		 && chmod(dest, source_stat.st_mode & ~saved_umask) < 0
 		) {
-			bb_perror_msg("can't preserve %s of '%s'", "permissions", dest);
+			sys_error(_("can't preserve permissions of '%s'"), dest);
 			/* retval =3D -1; - WRONG! copy *WAS* made */
 		}
 		goto preserve_mode_ugid_time;
@@ -196,10 +182,8 @@ int FAST_FUNC copy_file(const char *source, const =
char *dest, int flags)
 					ovr =3D ask_and_unlink(dest, flags);
 					if (ovr <=3D 0)
 						return ovr;
-					if (link(link_target, dest) < 0) {
-						bb_perror_msg("can't create link '%s'", dest);
-						return -1;
-					}
+					if (link(link_target, dest) < 0)
+						return sys_error(_("can't create link '%s'"), dest);
 				}
 				return 0;
 			}
@@ -238,10 +222,8 @@ int FAST_FUNC copy_file(const char *source, const =
char *dest, int flags)
 		if (bb_copyfd_eof(src_fd, dst_fd) =3D=3D -1)
 			retval =3D -1;
 		/* Careful with writing... */
-		if (close(dst_fd) < 0) {
-			bb_perror_msg("error writing to '%s'", dest);
-			retval =3D -1;
-		}
+		if (close(dst_fd) < 0)
+			retval =3D sys_error(_("error writing to '%s'"), dest);
 		/* ...but read size is already checked by bb_copyfd_eof */
 		close(src_fd);
 		/* "cp /dev/something new_file" should not
@@ -265,12 +247,10 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
 		if (lpath) {
 			int r =3D symlink(lpath, dest);
 			free(lpath);
-			if (r < 0) {
-				bb_perror_msg("can't create symlink '%s'", dest);
-				return -1;
-			}
+			if (r < 0)
+				return sys_error(_("can't create symlink '%s'"), dest);
 			if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
-				bb_perror_msg("can't preserve %s of '%s'", "ownership", dest);
+				sys_error(_("can't preserve %s of '%s'"), "ownership", dest);
 		}
 		/* _Not_ jumping to preserve_mode_ugid_time:
 		 * symlinks don't have those */
@@ -279,14 +259,11 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
 	if (S_ISBLK(source_stat.st_mode) || S_ISCHR(source_stat.st_mode)
 	 || S_ISSOCK(source_stat.st_mode) || S_ISFIFO(source_stat.st_mode)
 	) {
-		if (mknod(dest, source_stat.st_mode, source_stat.st_rdev) < 0) {
-			bb_perror_msg("can't create '%s'", dest);
-			return -1;
-		}
-	} else {
-		bb_error_msg("unrecognized file '%s' with mode %x", source, source_s=
tat.st_mode);
-		return -1;
-	}
+		if (mknod(dest, source_stat.st_mode, source_stat.st_rdev) < 0)
+			return sys_error(_("can't create '%s'"), dest);
+	} else
+		return error(_("unrecognized file '%s' with mode %x"),
+			     source, source_stat.st_mode);
=20
  preserve_mode_ugid_time:
=20
@@ -297,13 +274,13 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
 		times[1].tv_usec =3D times[0].tv_usec =3D 0;
 		/* BTW, utimes sets usec-precision time - just FYI */
 		if (utimes(dest, times) < 0)
-			bb_perror_msg("can't preserve %s of '%s'", "times", dest);
+			sys_error(_("can't preserve %s of '%s'"), "times", dest);
 		if (chown(dest, source_stat.st_uid, source_stat.st_gid) < 0) {
 			source_stat.st_mode &=3D ~(S_ISUID | S_ISGID);
-			bb_perror_msg("can't preserve %s of '%s'", "ownership", dest);
+			sys_error(_("can't preserve %s of '%s'"), "ownership", dest);
 		}
 		if (chmod(dest, source_stat.st_mode) < 0)
-			bb_perror_msg("can't preserve %s of '%s'", "permissions", dest);
+			sys_error(_("can't preserve %s of '%s'"), "permissions", dest);
 	}
=20
 	return retval;
--=20
2.8.0.rc0.210.gd302cd2
