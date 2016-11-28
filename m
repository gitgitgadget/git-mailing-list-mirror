Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1605F1FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754284AbcK1JoC (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:44:02 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35585 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbcK1JoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:44:01 -0500
Received: by mail-pf0-f193.google.com with SMTP id i88so6193384pfk.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5BYiUp0wPrKtt0ky9jJxGM0rktQ5vDmpSFQSKXDhMk=;
        b=f6PBu+CQWsP46DA8dnU7H+LwrMIqhKAN5w1pKs9yJxMgpjsFhqO9Un6ynRaaCAsK81
         H2I20PFdreHvSqgy7+Kd9PvLAgN8CJUAbvh/SOQ7F1GdBDvRqWX9f4uaEZs2q+l/5rum
         3nebJl6buevYljBGiotXAYEuQrpL/0cwLWnpyPxePrvyTVTR3J+WjdUyv1JWG5FHgBSu
         fx9O/PDL2hfgGZr4fYicbL6Js7s11IB/ysTgBzqgkrbHfrkcEjbb6711rAkLAiTythxL
         BmIVGHbQDvdT1Fy068gQK3iHyw1ugbmOSY6lpuzMu7tCO0oEL7urCcB9DdaFZRUlKgm/
         7utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5BYiUp0wPrKtt0ky9jJxGM0rktQ5vDmpSFQSKXDhMk=;
        b=NWpRh5sl1ix1g2C9/IItzMyHmeoDofODeBdCmcR23HWbh0zMOPlJehXxOyLaeKSRcF
         WO+8O08WjmEMiH3KQVvpKwVmAUNjIcMSbOC2t6eQFYCbq0ce/yNgRuxsKpCRFO7Bssz4
         8XORAfaLtSja1CHUkF0nS51Q/6uFmP2Cd8pa98y6hPGZkw5CWhYJYt+KXj7fvVbe489A
         K7RYSEVzkFOEd5p2e+mdE2xb9/SaBLuWEjtLFjySDlgd44XeGON+07N036Swb7EAiHdh
         UeaiKD15lvub8V8ceeYUYk891xn2H/qoPWpoxdWnx9MueKqXSiS229o/0BB0tEvC/n7N
         txSg==
X-Gm-Message-State: AKaTC00RuMsaZNetuEUAlCTTjzzh1ClyTweLXYe1oNcNyKbYSVJ9ZZiVr5Os/xtBNE9XqQ==
X-Received: by 10.99.237.17 with SMTP id d17mr37864079pgi.48.1480326240246;
        Mon, 28 Nov 2016 01:44:00 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id s3sm85704609pfg.14.2016.11.28.01.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:43:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:43:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 03/11] copy.c: convert bb_(p)error_msg to error(_errno)
Date:   Mon, 28 Nov 2016 16:43:11 +0700
Message-Id: <20161128094319.16176-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161128094319.16176-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
 <20161128094319.16176-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 copy.c | 85 ++++++++++++++++++++++++------------------------------------------
 1 file changed, 31 insertions(+), 54 deletions(-)

diff --git a/copy.c b/copy.c
index b7a87f1..074b609 100644
--- a/copy.c
+++ b/copy.c
@@ -82,23 +82,16 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 	smallint dest_exists = 0;
 	smallint ovr;
 
-	if (lstat(source, &source_stat) < 0) {
-		bb_perror_msg("can't stat '%s'", source);
-		return -1;
-	}
+	if (lstat(source, &source_stat) < 0)
+		return error_errno(_("can't stat '%s'"), source);
 
 	if (lstat(dest, &dest_stat) < 0) {
-		if (errno != ENOENT) {
-			bb_perror_msg("can't stat '%s'", dest);
-			return -1;
-		}
+		if (errno != ENOENT)
+			return error_errno(_("can't stat '%s'"), dest);
 	} else {
-		if (source_stat.st_dev == dest_stat.st_dev
-		 && source_stat.st_ino == dest_stat.st_ino
-		) {
-			bb_error_msg("'%s' and '%s' are the same file", source, dest);
-			return -1;
-		}
+		if (source_stat.st_dev == dest_stat.st_dev &&
+		    source_stat.st_ino == dest_stat.st_ino)
+			return error(_("'%s' and '%s' are the same file"), source, dest);
 		dest_exists = 1;
 	}
 
@@ -110,18 +103,14 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 
 		/* Did we ever create source ourself before? */
 		tp = is_in_ino_dev_hashtable(&source_stat);
-		if (tp) {
+		if (tp)
 			/* We did! it's a recursion! man the lifeboats... */
-			bb_error_msg("recursion detected, omitting directory '%s'",
-					source);
-			return -1;
-		}
+			return error(_("recursion detected, omitting directory '%s'"),
+				     source);
 
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
@@ -134,15 +123,12 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 			mode |= S_IRWXU;
 			if (mkdir(dest, mode) < 0) {
 				umask(saved_umask);
-				bb_perror_msg("can't create directory '%s'", dest);
-				return -1;
+				return error_errno(_("can't create directory '%s'"), dest);
 			}
 			umask(saved_umask);
 			/* need stat info for add_to_ino_dev_hashtable */
-			if (lstat(dest, &dest_stat) < 0) {
-				bb_perror_msg("can't stat '%s'", dest);
-				return -1;
-			}
+			if (lstat(dest, &dest_stat) < 0)
+				return error_errno(_("can't stat '%s'"), dest);
 		}
 		/* remember (dev,inode) of each created dir.
 		 * NULL: name is not remembered */
@@ -172,7 +158,7 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 		if (!dest_exists
 		 && chmod(dest, source_stat.st_mode & ~saved_umask) < 0
 		) {
-			bb_perror_msg("can't preserve %s of '%s'", "permissions", dest);
+			error_errno(_("can't preserve permissions of '%s'"), dest);
 			/* retval = -1; - WRONG! copy *WAS* made */
 		}
 		goto preserve_mode_ugid_time;
@@ -196,10 +182,8 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 					ovr = ask_and_unlink(dest, flags);
 					if (ovr <= 0)
 						return ovr;
-					if (link(link_target, dest) < 0) {
-						bb_perror_msg("can't create link '%s'", dest);
-						return -1;
-					}
+					if (link(link_target, dest) < 0)
+						return error_errno(_("can't create link '%s'"), dest);
 				}
 				return 0;
 			}
@@ -238,10 +222,8 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 		if (bb_copyfd_eof(src_fd, dst_fd) == -1)
 			retval = -1;
 		/* Careful with writing... */
-		if (close(dst_fd) < 0) {
-			bb_perror_msg("error writing to '%s'", dest);
-			retval = -1;
-		}
+		if (close(dst_fd) < 0)
+			retval = error_errno(_("error writing to '%s'"), dest);
 		/* ...but read size is already checked by bb_copyfd_eof */
 		close(src_fd);
 		/* "cp /dev/something new_file" should not
@@ -265,12 +247,10 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 		if (lpath) {
 			int r = symlink(lpath, dest);
 			free(lpath);
-			if (r < 0) {
-				bb_perror_msg("can't create symlink '%s'", dest);
-				return -1;
-			}
+			if (r < 0)
+				return error_errno(_("can't create symlink '%s'"), dest);
 			if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
-				bb_perror_msg("can't preserve %s of '%s'", "ownership", dest);
+				error_errno(_("can't preserve %s of '%s'"), "ownership", dest);
 		}
 		/* _Not_ jumping to preserve_mode_ugid_time:
 		 * symlinks don't have those */
@@ -279,14 +259,11 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 	if (S_ISBLK(source_stat.st_mode) || S_ISCHR(source_stat.st_mode)
 	 || S_ISSOCK(source_stat.st_mode) || S_ISFIFO(source_stat.st_mode)
 	) {
-		if (mknod(dest, source_stat.st_mode, source_stat.st_rdev) < 0) {
-			bb_perror_msg("can't create '%s'", dest);
-			return -1;
-		}
-	} else {
-		bb_error_msg("unrecognized file '%s' with mode %x", source, source_stat.st_mode);
-		return -1;
-	}
+		if (mknod(dest, source_stat.st_mode, source_stat.st_rdev) < 0)
+			return error_errno(_("can't create '%s'"), dest);
+	} else
+		return error(_("unrecognized file '%s' with mode %x"),
+			     source, source_stat.st_mode);
 
  preserve_mode_ugid_time:
 
@@ -297,13 +274,13 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 		times[1].tv_usec = times[0].tv_usec = 0;
 		/* BTW, utimes sets usec-precision time - just FYI */
 		if (utimes(dest, times) < 0)
-			bb_perror_msg("can't preserve %s of '%s'", "times", dest);
+			error_errno(_("can't preserve %s of '%s'"), "times", dest);
 		if (chown(dest, source_stat.st_uid, source_stat.st_gid) < 0) {
 			source_stat.st_mode &= ~(S_ISUID | S_ISGID);
-			bb_perror_msg("can't preserve %s of '%s'", "ownership", dest);
+			error_errno(_("can't preserve %s of '%s'"), "ownership", dest);
 		}
 		if (chmod(dest, source_stat.st_mode) < 0)
-			bb_perror_msg("can't preserve %s of '%s'", "permissions", dest);
+			error_errno(_("can't preserve %s of '%s'"), "permissions", dest);
 	}
 
 	return retval;
-- 
2.8.2.524.g6ff3d78

