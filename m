From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/26] copy.c: convert bb_(p)error_msg to (sys_)error
Date: Tue, 16 Feb 2016 20:29:06 +0700
Message-ID: <1455629367-26193-6-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:29:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfhM-0002TB-4w
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbcBPN3o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:29:44 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35762 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230AbcBPN3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:29:43 -0500
Received: by mail-pa0-f52.google.com with SMTP id ho8so104946395pac.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cuwsJEN51rjVxFL4wrEZGzO4Tbf8FE2Xg73qGTwT5pM=;
        b=u+iFODrjbT3dT6Zt4ta5yOtoMXILN1hzzx9pGHUEn/E+kxJNT503azX9FooYK/FId6
         PelNaKAFwQqd8fLQppZrk6mxqxZ54zEL40eXLbTt/XmXp+0JJY2PqdPPLJ62M83So9w4
         2R1f6spsYXWNGUv/gE9x0OhKdE1yViX08RKARoXaMKPrPBy1vkwrQ9y3AO5YayyL5XS1
         J+l6Oq+lk2bdNxPH8qvoS0tYetSJolMeCqLc7K8zI+C607xpD4waAa3g68eszP7hCsJJ
         WvVtVJihjRTkkml4Co2NWzL5BMl56O7+e1a3TjQZ6r6LVSY+leNYwD838iwMkA7rydrH
         HVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=cuwsJEN51rjVxFL4wrEZGzO4Tbf8FE2Xg73qGTwT5pM=;
        b=iiL9YhPOdtUqbXugPGgMhAP6wdleaBcbEaUr5TbtfgqPqMtqr02DXVA8+iTl8RJQjh
         NOM/ezDfg2KFqKngfIzxV6yezauw7eyHUjs+VEfc3PLOMDU82xVX/lKtkB5FGtagFzVQ
         VuHdRhu5Ca628yIY8G9NqBQUUZb2P1cLf0OlBPGEHeihjiI0RBPChOB1mGcCTSFOS2dY
         RC3YrIcm6BTTYPOJm9ORMo+M0jBfMBfZ2ndMu65PtK0olW1qPALuINVDnuxfZlFw0Oh1
         +/jyzYyLevttwfRyl7L+iW1aHeeM4SKlHQ0ta06TuQyPUuytuNnT7JBGa2VTIES9Zusk
         NVAQ==
X-Gm-Message-State: AG10YOSsi5cwUlZ5d4WK+wyHI2YGmgS3FmfCbooGmqw2FO5YHbQV+qqCatBQeOdX4udYIQ==
X-Received: by 10.66.251.194 with SMTP id zm2mr31525506pac.131.1455629383002;
        Tue, 16 Feb 2016 05:29:43 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id r77sm45957905pfa.47.2016.02.16.05.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:29:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:30:06 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286365>

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
2.7.0.377.g4cd97dd
