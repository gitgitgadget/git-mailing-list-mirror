Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958AF2079C
	for <e@80x24.org>; Sat, 12 Nov 2016 02:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966361AbcKLCYq (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 21:24:46 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36833 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937243AbcKLCYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 21:24:36 -0500
Received: by mail-pg0-f67.google.com with SMTP id x23so3160766pgx.3
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 18:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7R2mQCLB0SkT2gyn12E26Ow+nmFbeZNDW5olsHj1xRY=;
        b=VTP1blUnJDZrD3Xt6Vjtxg73Vp3GCzFH3Xf1mSOkwRaa1s5lQ0pTXnxAFmfH9HAhb5
         7rtBbHF0pGnz9KTs2U95I78N5GWNOtQwB/MqJipwc76xS+qo/qTOd/ukVj9/+id3Ms7Z
         HAAc9dWvzY9VQDbCuZrPhQLhzRm8Pzvpqi0Fcf7RZC7XQSCObdWiR8Z9obiHFHzKDsrx
         QVAwTabm6izHT3CQ7sta9eqi3qdBF5Dvc6ApHL72tS2HHE9BVGTdDuePMx0hfYimwcVb
         aljcF8rxayKoYYc+vhvlPCdm+Kwe4imdZaNz2BIhvX2e+Fcjhs7+0H3YcU5zJaqexgn6
         GsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7R2mQCLB0SkT2gyn12E26Ow+nmFbeZNDW5olsHj1xRY=;
        b=OtOip2AH0SdBwxL4hk2yhDQrSFmaw50XxswMtEQvL0Ki1wYn1iN5T8/u5DSLyiaocO
         KBGSQqMz6MJu0Vl8yo3p8vr0/hrXZBc7A08kzhSeNYZD1guo/pNAuZD6PN7K7H5dYtun
         BnvwePJygORguEOMCjv1hAS7xk70AeuFvDSJ9XCYTass+RGKAG8vIgPdA8xo6qQkbqQb
         HosRI9Egveb3rePc+0tkQVlkzPb+mfjl7uqj7RW9jyhYxfDaxS3V1WZNw9RV7OuhJKbn
         ErM5Kxq2IeyD1fRXXm1Uc+bSfgKUCZ2dlrnhWTzdljoi4ErRBI1oChj71yFbGcP2/6S2
         P7EA==
X-Gm-Message-State: ABUngvd+hEffbnuRz/qM09nHsOcD+irrs7/K4MwWvEVG+gvcHLZ6WSnjiOQIVjoAffEg1w==
X-Received: by 10.98.223.203 with SMTP id d72mr13066223pfl.2.1478917428978;
        Fri, 11 Nov 2016 18:23:48 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id sh9sm18030435pac.41.2016.11.11.18.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 18:23:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Nov 2016 09:23:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/11] copy.c: import copy_file() from busybox
Date:   Sat, 12 Nov 2016 09:23:27 +0700
Message-Id: <20161112022337.13317-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161112022337.13317-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is busybox's unmodified copy_file() in libbb/copy_file.c from the
GPL2+ commit f2c043acfcf9dad9fd3d65821b81f89986bbe54e (busybox: fix
uninitialized memory when displaying IPv6 addresses -
2016-01-18). This is a no-op commit. More changes are needed before
this new code can compile.

This will be needed for implementing "git worktree move" where we have
to move a directory recursively. We can implement it from scratch, but
then we will have to deal with corner cases (failure to move, circular
symlinks...). And delegating the task to "/bin/mv" takes a way the
ability to clean things up properly when things fail and we may have
to deal with "mv" differences between platforms.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 copy.c | 331 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 331 insertions(+)

diff --git a/copy.c b/copy.c
index 4de6a11..79623ac 100644
--- a/copy.c
+++ b/copy.c
@@ -65,3 +65,334 @@ int copy_file_with_time(const char *dst, const char *src, int mode)
 		return copy_times(dst, src);
 	return status;
 }
+
+#if 0
+/* Return:
+ * -1 error, copy not made
+ *  0 copy is made or user answered "no" in interactive mode
+ *    (failures to preserve mode/owner/times are not reported in exit code)
+ */
+int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
+{
+	/* This is a recursive function, try to minimize stack usage */
+	/* NB: each struct stat is ~100 bytes */
+	struct stat source_stat;
+	struct stat dest_stat;
+	smallint retval = 0;
+	smallint dest_exists = 0;
+	smallint ovr;
+
+/* Inverse of cp -d ("cp without -d") */
+#define FLAGS_DEREF (flags & (FILEUTILS_DEREFERENCE + FILEUTILS_DEREFERENCE_L0))
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
+		if (errno != ENOENT) {
+			bb_perror_msg("can't stat '%s'", dest);
+			return -1;
+		}
+	} else {
+		if (source_stat.st_dev == dest_stat.st_dev
+		 && source_stat.st_ino == dest_stat.st_ino
+		) {
+			bb_error_msg("'%s' and '%s' are the same file", source, dest);
+			return -1;
+		}
+		dest_exists = 1;
+	}
+
+#if ENABLE_SELINUX
+	if ((flags & FILEUTILS_PRESERVE_SECURITY_CONTEXT) && is_selinux_enabled() > 0) {
+		security_context_t con;
+		if (lgetfilecon(source, &con) >= 0) {
+			if (setfscreatecon(con) < 0) {
+				bb_perror_msg("can't set setfscreatecon %s", con);
+				freecon(con);
+				return -1;
+			}
+		} else if (errno == ENOTSUP || errno == ENODATA) {
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
+		mode_t saved_umask = 0;
+
+		if (!(flags & FILEUTILS_RECUR)) {
+			bb_error_msg("omitting directory '%s'", source);
+			return -1;
+		}
+
+		/* Did we ever create source ourself before? */
+		tp = is_in_ino_dev_hashtable(&source_stat);
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
+			saved_umask = umask(0);
+
+			mode = source_stat.st_mode;
+			if (!(flags & FILEUTILS_PRESERVE_STATUS))
+				mode = source_stat.st_mode & ~saved_umask;
+			/* Allow owner to access new dir (at least for now) */
+			mode |= S_IRWXU;
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
+		dp = opendir(source);
+		if (dp == NULL) {
+			retval = -1;
+			goto preserve_mode_ugid_time;
+		}
+
+		while ((d = readdir(dp)) != NULL) {
+			char *new_source, *new_dest;
+
+			new_source = concat_subpath_file(source, d->d_name);
+			if (new_source == NULL)
+				continue;
+			new_dest = concat_path_file(dest, d->d_name);
+			if (copy_file(new_source, new_dest, flags & ~FILEUTILS_DEREFERENCE_L0) < 0)
+				retval = -1;
+			free(new_source);
+			free(new_dest);
+		}
+		closedir(dp);
+
+		if (!dest_exists
+		 && chmod(dest, source_stat.st_mode & ~saved_umask) < 0
+		) {
+			bb_perror_msg("can't preserve %s of '%s'", "permissions", dest);
+			/* retval = -1; - WRONG! copy *WAS* made */
+		}
+		goto preserve_mode_ugid_time;
+	}
+
+	if (flags & (FILEUTILS_MAKE_SOFTLINK|FILEUTILS_MAKE_HARDLINK)) {
+		int (*lf)(const char *oldpath, const char *newpath);
+ make_links:
+		/* Hmm... maybe
+		 * if (DEREF && MAKE_SOFTLINK) source = realpath(source) ?
+		 * (but realpath returns NULL on dangling symlinks...) */
+		lf = (flags & FILEUTILS_MAKE_SOFTLINK) ? symlink : link;
+		if (lf(source, dest) < 0) {
+			ovr = ask_and_unlink(dest, flags);
+			if (ovr <= 0)
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
+	if (/* "cp thing1 thing2" without -R: just open and read() from thing1 */
+	    !(flags & FILEUTILS_RECUR)
+	    /* "cp [-opts] regular_file thing2" */
+	 || S_ISREG(source_stat.st_mode)
+	 /* DEREF uses stat, which never returns S_ISLNK() == true.
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
+			link_target = is_in_ino_dev_hashtable(&source_stat);
+			if (link_target) {
+				if (link(link_target, dest) < 0) {
+					ovr = ask_and_unlink(dest, flags);
+					if (ovr <= 0)
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
+		src_fd = open_or_warn(source, O_RDONLY);
+		if (src_fd < 0)
+			return -1;
+
+		/* Do not try to open with weird mode fields */
+		new_mode = source_stat.st_mode;
+		if (!S_ISREG(source_stat.st_mode))
+			new_mode = 0666;
+
+		// POSIX way is a security problem versus (sym)link attacks
+		if (!ENABLE_FEATURE_NON_POSIX_CP) {
+			dst_fd = open(dest, O_WRONLY|O_CREAT|O_TRUNC, new_mode);
+		} else { /* safe way: */
+			dst_fd = open(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
+		}
+		if (dst_fd == -1) {
+			ovr = ask_and_unlink(dest, flags);
+			if (ovr <= 0) {
+				close(src_fd);
+				return ovr;
+			}
+			/* It shouldn't exist. If it exists, do not open (symlink attack?) */
+			dst_fd = open3_or_warn(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
+			if (dst_fd < 0) {
+				close(src_fd);
+				return -1;
+			}
+		}
+
+#if ENABLE_SELINUX
+		if ((flags & (FILEUTILS_PRESERVE_SECURITY_CONTEXT|FILEUTILS_SET_SECURITY_CONTEXT))
+		 && is_selinux_enabled() > 0
+		) {
+			security_context_t con;
+			if (getfscreatecon(&con) == -1) {
+				bb_perror_msg("getfscreatecon");
+				return -1;
+			}
+			if (con) {
+				if (setfilecon(dest, con) == -1) {
+					bb_perror_msg("setfilecon:%s,%s", dest, con);
+					freecon(con);
+					return -1;
+				}
+				freecon(con);
+			}
+		}
+#endif
+		if (bb_copyfd_eof(src_fd, dst_fd) == -1)
+			retval = -1;
+		/* Careful with writing... */
+		if (close(dst_fd) < 0) {
+			bb_perror_msg("error writing to '%s'", dest);
+			retval = -1;
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
+		errno = EEXIST;
+		ovr = ask_and_unlink(dest, flags);
+		if (ovr <= 0)
+			return ovr;
+	}
+	if (S_ISLNK(source_stat.st_mode)) {
+		char *lpath = xmalloc_readlink_or_warn(source);
+		if (lpath) {
+			int r = symlink(lpath, dest);
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
+		bb_error_msg("unrecognized file '%s' with mode %x", source, source_stat.st_mode);
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
+		times[1].tv_sec = times[0].tv_sec = source_stat.st_mtime;
+		times[1].tv_usec = times[0].tv_usec = 0;
+		/* BTW, utimes sets usec-precision time - just FYI */
+		if (utimes(dest, times) < 0)
+			bb_perror_msg("can't preserve %s of '%s'", "times", dest);
+		if (chown(dest, source_stat.st_uid, source_stat.st_gid) < 0) {
+			source_stat.st_mode &= ~(S_ISUID | S_ISGID);
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
-- 
2.8.2.524.g6ff3d78

