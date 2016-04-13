From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/25] copy.c: import copy_file() from busybox
Date: Wed, 13 Apr 2016 20:15:24 +0700
Message-ID: <1460553346-12985-4-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:16:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKeQ-0003v9-8X
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760585AbcDMNQF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:16:05 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34347 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759970AbcDMNQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:16:03 -0400
Received: by mail-pa0-f68.google.com with SMTP id hb4so3923908pac.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+67FiLYpVpweI7Kg9mpKDi4rf6N2/56IWF+XQxl4Ls=;
        b=vd8Npad1NqloooDtUXDyy6LEaYPwzAFVM8Q4+tLQIEvk2Qyq/nSzIVQV8WSkyNUmcr
         SsMcVFEwKbPUOJ2t1mfdlCyq4lv1YkQyE6w/njz7E1pDfm+lcUzFo16E5YvM3FyH2lop
         GCZCETgcuD7+ciFDuVWrLgpsdTyEXYzaWRfFMLQOR9Qb0mjTEKDVUFdSsNomlzqiPzAt
         VvpPBzEr9HhwtPdPPbLX3WtbbmKOOHGi4QoHAtCeDIj2NdKycIMZl6wZj9dOeDHkb8sh
         KUhN5oyLvZ6qAUQku2BnSJFQZcLi8tjjiI0p7SAO0L6ibnzB7y2taCRPWvQqDp5Rra3S
         uitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+67FiLYpVpweI7Kg9mpKDi4rf6N2/56IWF+XQxl4Ls=;
        b=FaQXkllPhTxzViJn72e1/yEtrSUjX8BMRqkY4XfyPLkadk94txuHOklmX5KMmCgTam
         hBegU/F3T9mIezGPAxBego810tk8xr/dk2q8jBV2goryxMP5ODC2o2GeWOHoJdk4gWd8
         sZ0ddJt5Iu1ycbLIFWZpcvrhEVQKrO5b0QuoUrNfinaAjvqY9PVCyOI3jR9+KhHwILn7
         Um7Ek1dILaTpRHYatF08lFYO+iGw3vaw51AZJf3/KsGQ6NRzAy63saPryhBKjJ4BbDyw
         XeKsa17j7OIr5xeNr32EtvQ6INocS27aZMvlWhqkf9uqdU05JuDS9ynradUkccAJqo5n
         GPMw==
X-Gm-Message-State: AOPr4FUOT4LpJL2O5fH1fDX/9ma3cZGNnZuBlTJ+yu+0RyCEpmILod5QZ0tIgsAkIigVhw==
X-Received: by 10.66.102.70 with SMTP id fm6mr12666394pab.98.1460553363003;
        Wed, 13 Apr 2016 06:16:03 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id n19sm51173814pfi.53.2016.04.13.06.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:16:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:16:09 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291424>

This is busybox's unmodified copy_file() in libbb/copy_file.c from the
GPL2+ commit f2c043acfcf9dad9fd3d65821b81f89986bbe54e (busybox: fix
uninitialized memory when displaying IPv6 addresses - 2016-01-18)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 copy.c | 331 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 331 insertions(+)

diff --git a/copy.c b/copy.c
index 574fa1f..29e9d5b 100644
--- a/copy.c
+++ b/copy.c
@@ -65,3 +65,334 @@ int copy_file_with_time(const char *dst, const char=
 *src, int mode)
 		return copy_times(dst, src);
 	return status;
 }
+
+#if 0
+/* Return:
+ * -1 error, copy not made
+ *  0 copy is made or user answered "no" in interactive mode
+ *    (failures to preserve mode/owner/times are not reported in exit =
code)
+ */
+int FAST_FUNC copy_file(const char *source, const char *dest, int flag=
s)
+{
+	/* This is a recursive function, try to minimize stack usage */
+	/* NB: each struct stat is ~100 bytes */
+	struct stat source_stat;
+	struct stat dest_stat;
+	smallint retval =3D 0;
+	smallint dest_exists =3D 0;
+	smallint ovr;
+
+/* Inverse of cp -d ("cp without -d") */
+#define FLAGS_DEREF (flags & (FILEUTILS_DEREFERENCE + FILEUTILS_DEREFE=
RENCE_L0))
+
+	if ((FLAGS_DEREF ? stat : lstat)(source, &source_stat) < 0) {
+		/* This may be a dangling symlink.
+		 * Making [sym]links to dangling symlinks works, so... */
+		if (flags & (FILEUTILS_MAKE_SOFTLINK|FILEUTILS_MAKE_HARDLINK))
+			goto make_links;
+		bb_perror_msg("can't stat '%s'", source);
+		return -1;
+	}
+
+	if (lstat(dest, &dest_stat) < 0) {
+		if (errno !=3D ENOENT) {
+			bb_perror_msg("can't stat '%s'", dest);
+			return -1;
+		}
+	} else {
+		if (source_stat.st_dev =3D=3D dest_stat.st_dev
+		 && source_stat.st_ino =3D=3D dest_stat.st_ino
+		) {
+			bb_error_msg("'%s' and '%s' are the same file", source, dest);
+			return -1;
+		}
+		dest_exists =3D 1;
+	}
+
+#if ENABLE_SELINUX
+	if ((flags & FILEUTILS_PRESERVE_SECURITY_CONTEXT) && is_selinux_enabl=
ed() > 0) {
+		security_context_t con;
+		if (lgetfilecon(source, &con) >=3D 0) {
+			if (setfscreatecon(con) < 0) {
+				bb_perror_msg("can't set setfscreatecon %s", con);
+				freecon(con);
+				return -1;
+			}
+		} else if (errno =3D=3D ENOTSUP || errno =3D=3D ENODATA) {
+			setfscreatecon_or_die(NULL);
+		} else {
+			bb_perror_msg("can't lgetfilecon %s", source);
+			return -1;
+		}
+	}
+#endif
+
+	if (S_ISDIR(source_stat.st_mode)) {
+		DIR *dp;
+		const char *tp;
+		struct dirent *d;
+		mode_t saved_umask =3D 0;
+
+		if (!(flags & FILEUTILS_RECUR)) {
+			bb_error_msg("omitting directory '%s'", source);
+			return -1;
+		}
+
+		/* Did we ever create source ourself before? */
+		tp =3D is_in_ino_dev_hashtable(&source_stat);
+		if (tp) {
+			/* We did! it's a recursion! man the lifeboats... */
+			bb_error_msg("recursion detected, omitting directory '%s'",
+					source);
+			return -1;
+		}
+
+		if (dest_exists) {
+			if (!S_ISDIR(dest_stat.st_mode)) {
+				bb_error_msg("target '%s' is not a directory", dest);
+				return -1;
+			}
+			/* race here: user can substitute a symlink between
+			 * this check and actual creation of files inside dest */
+		} else {
+			/* Create DEST */
+			mode_t mode;
+			saved_umask =3D umask(0);
+
+			mode =3D source_stat.st_mode;
+			if (!(flags & FILEUTILS_PRESERVE_STATUS))
+				mode =3D source_stat.st_mode & ~saved_umask;
+			/* Allow owner to access new dir (at least for now) */
+			mode |=3D S_IRWXU;
+			if (mkdir(dest, mode) < 0) {
+				umask(saved_umask);
+				bb_perror_msg("can't create directory '%s'", dest);
+				return -1;
+			}
+			umask(saved_umask);
+			/* need stat info for add_to_ino_dev_hashtable */
+			if (lstat(dest, &dest_stat) < 0) {
+				bb_perror_msg("can't stat '%s'", dest);
+				return -1;
+			}
+		}
+		/* remember (dev,inode) of each created dir.
+		 * NULL: name is not remembered */
+		add_to_ino_dev_hashtable(&dest_stat, NULL);
+
+		/* Recursively copy files in SOURCE */
+		dp =3D opendir(source);
+		if (dp =3D=3D NULL) {
+			retval =3D -1;
+			goto preserve_mode_ugid_time;
+		}
+
+		while ((d =3D readdir(dp)) !=3D NULL) {
+			char *new_source, *new_dest;
+
+			new_source =3D concat_subpath_file(source, d->d_name);
+			if (new_source =3D=3D NULL)
+				continue;
+			new_dest =3D concat_path_file(dest, d->d_name);
+			if (copy_file(new_source, new_dest, flags & ~FILEUTILS_DEREFERENCE_=
L0) < 0)
+				retval =3D -1;
+			free(new_source);
+			free(new_dest);
+		}
+		closedir(dp);
+
+		if (!dest_exists
+		 && chmod(dest, source_stat.st_mode & ~saved_umask) < 0
+		) {
+			bb_perror_msg("can't preserve %s of '%s'", "permissions", dest);
+			/* retval =3D -1; - WRONG! copy *WAS* made */
+		}
+		goto preserve_mode_ugid_time;
+	}
+
+	if (flags & (FILEUTILS_MAKE_SOFTLINK|FILEUTILS_MAKE_HARDLINK)) {
+		int (*lf)(const char *oldpath, const char *newpath);
+ make_links:
+		/* Hmm... maybe
+		 * if (DEREF && MAKE_SOFTLINK) source =3D realpath(source) ?
+		 * (but realpath returns NULL on dangling symlinks...) */
+		lf =3D (flags & FILEUTILS_MAKE_SOFTLINK) ? symlink : link;
+		if (lf(source, dest) < 0) {
+			ovr =3D ask_and_unlink(dest, flags);
+			if (ovr <=3D 0)
+				return ovr;
+			if (lf(source, dest) < 0) {
+				bb_perror_msg("can't create link '%s'", dest);
+				return -1;
+			}
+		}
+		/* _Not_ jumping to preserve_mode_ugid_time:
+		 * (sym)links don't have those */
+		return 0;
+	}
+
+	if (/* "cp thing1 thing2" without -R: just open and read() from thing=
1 */
+	    !(flags & FILEUTILS_RECUR)
+	    /* "cp [-opts] regular_file thing2" */
+	 || S_ISREG(source_stat.st_mode)
+	 /* DEREF uses stat, which never returns S_ISLNK() =3D=3D true.
+	  * So the below is never true: */
+	 /* || (FLAGS_DEREF && S_ISLNK(source_stat.st_mode)) */
+	) {
+		int src_fd;
+		int dst_fd;
+		mode_t new_mode;
+
+		if (!FLAGS_DEREF && S_ISLNK(source_stat.st_mode)) {
+			/* "cp -d symlink dst": create a link */
+			goto dont_cat;
+		}
+
+		if (ENABLE_FEATURE_PRESERVE_HARDLINKS && !FLAGS_DEREF) {
+			const char *link_target;
+			link_target =3D is_in_ino_dev_hashtable(&source_stat);
+			if (link_target) {
+				if (link(link_target, dest) < 0) {
+					ovr =3D ask_and_unlink(dest, flags);
+					if (ovr <=3D 0)
+						return ovr;
+					if (link(link_target, dest) < 0) {
+						bb_perror_msg("can't create link '%s'", dest);
+						return -1;
+					}
+				}
+				return 0;
+			}
+			add_to_ino_dev_hashtable(&source_stat, dest);
+		}
+
+		src_fd =3D open_or_warn(source, O_RDONLY);
+		if (src_fd < 0)
+			return -1;
+
+		/* Do not try to open with weird mode fields */
+		new_mode =3D source_stat.st_mode;
+		if (!S_ISREG(source_stat.st_mode))
+			new_mode =3D 0666;
+
+		// POSIX way is a security problem versus (sym)link attacks
+		if (!ENABLE_FEATURE_NON_POSIX_CP) {
+			dst_fd =3D open(dest, O_WRONLY|O_CREAT|O_TRUNC, new_mode);
+		} else { /* safe way: */
+			dst_fd =3D open(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
+		}
+		if (dst_fd =3D=3D -1) {
+			ovr =3D ask_and_unlink(dest, flags);
+			if (ovr <=3D 0) {
+				close(src_fd);
+				return ovr;
+			}
+			/* It shouldn't exist. If it exists, do not open (symlink attack?) =
*/
+			dst_fd =3D open3_or_warn(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
+			if (dst_fd < 0) {
+				close(src_fd);
+				return -1;
+			}
+		}
+
+#if ENABLE_SELINUX
+		if ((flags & (FILEUTILS_PRESERVE_SECURITY_CONTEXT|FILEUTILS_SET_SECU=
RITY_CONTEXT))
+		 && is_selinux_enabled() > 0
+		) {
+			security_context_t con;
+			if (getfscreatecon(&con) =3D=3D -1) {
+				bb_perror_msg("getfscreatecon");
+				return -1;
+			}
+			if (con) {
+				if (setfilecon(dest, con) =3D=3D -1) {
+					bb_perror_msg("setfilecon:%s,%s", dest, con);
+					freecon(con);
+					return -1;
+				}
+				freecon(con);
+			}
+		}
+#endif
+		if (bb_copyfd_eof(src_fd, dst_fd) =3D=3D -1)
+			retval =3D -1;
+		/* Careful with writing... */
+		if (close(dst_fd) < 0) {
+			bb_perror_msg("error writing to '%s'", dest);
+			retval =3D -1;
+		}
+		/* ...but read size is already checked by bb_copyfd_eof */
+		close(src_fd);
+		/* "cp /dev/something new_file" should not
+		 * copy mode of /dev/something */
+		if (!S_ISREG(source_stat.st_mode))
+			return retval;
+		goto preserve_mode_ugid_time;
+	}
+ dont_cat:
+
+	/* Source is a symlink or a special file */
+	/* We are lazy here, a bit lax with races... */
+	if (dest_exists) {
+		errno =3D EEXIST;
+		ovr =3D ask_and_unlink(dest, flags);
+		if (ovr <=3D 0)
+			return ovr;
+	}
+	if (S_ISLNK(source_stat.st_mode)) {
+		char *lpath =3D xmalloc_readlink_or_warn(source);
+		if (lpath) {
+			int r =3D symlink(lpath, dest);
+			free(lpath);
+			if (r < 0) {
+				bb_perror_msg("can't create symlink '%s'", dest);
+				return -1;
+			}
+			if (flags & FILEUTILS_PRESERVE_STATUS)
+				if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
+					bb_perror_msg("can't preserve %s of '%s'", "ownership", dest);
+		}
+		/* _Not_ jumping to preserve_mode_ugid_time:
+		 * symlinks don't have those */
+		return 0;
+	}
+	if (S_ISBLK(source_stat.st_mode) || S_ISCHR(source_stat.st_mode)
+	 || S_ISSOCK(source_stat.st_mode) || S_ISFIFO(source_stat.st_mode)
+	) {
+		if (mknod(dest, source_stat.st_mode, source_stat.st_rdev) < 0) {
+			bb_perror_msg("can't create '%s'", dest);
+			return -1;
+		}
+	} else {
+		bb_error_msg("unrecognized file '%s' with mode %x", source, source_s=
tat.st_mode);
+		return -1;
+	}
+
+ preserve_mode_ugid_time:
+
+	if (flags & FILEUTILS_PRESERVE_STATUS
+	/* Cannot happen: */
+	/* && !(flags & (FILEUTILS_MAKE_SOFTLINK|FILEUTILS_MAKE_HARDLINK)) */
+	) {
+		struct timeval times[2];
+
+		times[1].tv_sec =3D times[0].tv_sec =3D source_stat.st_mtime;
+		times[1].tv_usec =3D times[0].tv_usec =3D 0;
+		/* BTW, utimes sets usec-precision time - just FYI */
+		if (utimes(dest, times) < 0)
+			bb_perror_msg("can't preserve %s of '%s'", "times", dest);
+		if (chown(dest, source_stat.st_uid, source_stat.st_gid) < 0) {
+			source_stat.st_mode &=3D ~(S_ISUID | S_ISGID);
+			bb_perror_msg("can't preserve %s of '%s'", "ownership", dest);
+		}
+		if (chmod(dest, source_stat.st_mode) < 0)
+			bb_perror_msg("can't preserve %s of '%s'", "permissions", dest);
+	}
+
+	if (flags & FILEUTILS_VERBOSE) {
+		printf("'%s' -> '%s'\n", source, dest);
+	}
+
+	return retval;
+}
+#endif
--=20
2.8.0.rc0.210.gd302cd2
