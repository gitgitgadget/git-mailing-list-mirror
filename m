Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 225FF1FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 08:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbcFYINX (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 04:13:23 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34611 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcFYINT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 04:13:19 -0400
Received: by mail-lf0-f67.google.com with SMTP id l184so23922866lfl.1
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 01:13:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3cc+JNy0CsTxM57vqujXSxt3Ib7nOoazC1WrvIRhW7A=;
        b=br7fJZhoE4K/+vLRvJLvfLt05eireS4mmGixPKLHnYfamx5tMaL31J9oTVK0opBAWO
         jJDHOY7bqEPbWbYvsbZHEOaFKKh4EIIlPoCMtiB2OdYDxPN/aLh7xTFDW8kwD0ZnfDKo
         7okUiJleXes3A07UJWqX8ervvDWvPZkIUVtfEqD2CGCbPxvfGxxjjOMNErLNfKA9haK4
         /b5ooDX2pNcsz22j3RyfyqQBv1g92Tudp/JPuz9tPL7U7khLk7+mw5ihVyWYjFn/oPKr
         kRhW8eJOQK8W2iCPj90Hcuw6Jl9qy74WDrrdcfvoLv78a9leMW/OqOuKi0oKpSP60Zoh
         sYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cc+JNy0CsTxM57vqujXSxt3Ib7nOoazC1WrvIRhW7A=;
        b=OFfOq35pW3bLgplnqWGVZjzbLDXYgI8bD0N1cfV8zreksP80t5nHOcXUqYtcrlbJtC
         yeEKcPE/ATtpimVN0wNc7I7ZzsRQiZX+CNCT012Ve7TdjuqtArNmfLUDw+PpLvX2uAO/
         5hQ20TJ09/vc+e+suhflxMp3Sb5Jk0YUYmaD99rHu5sgmTDf2trrkA0OcZP2h6DGLWwO
         1rcWEAlSAgEREflJuoXjzLR6pbVnu7DHLrRkiCUvjlpq/a/CSNhD3MCjoSL3DABmOxUZ
         mgFA2l3umbizKqoALXFIzXte78ms0PKuAJp9MjgEeQ5aCCG4id6orzQUgsXgjGMwHGxz
         0JbQ==
X-Gm-Message-State: ALyK8tLHRRZL+ZgQ3Xt+1RIlclhKJa1R9c02yRyoXZGLM97ix2xjQ7gcIzeSlmJZJDL1Jw==
X-Received: by 10.25.76.195 with SMTP id z186mr2127303lfa.155.1466841282374;
        Sat, 25 Jun 2016 00:54:42 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g79sm1536122ljg.26.2016.06.25.00.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 00:54:41 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/10] copy.c: convert bb_(p)error_msg to error(_errno)
Date:	Sat, 25 Jun 2016 09:54:26 +0200
Message-Id: <20160625075433.4608-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625075433.4608-1-pclouds@gmail.com>
References: <20160625075433.4608-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.8.2.526.g02eed6d

