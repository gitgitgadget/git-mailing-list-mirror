Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3272079C
	for <e@80x24.org>; Sat, 12 Nov 2016 02:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966338AbcKLCYl (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 21:24:41 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35213 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938481AbcKLCYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 21:24:36 -0500
Received: by mail-pf0-f195.google.com with SMTP id i88so3126191pfk.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 18:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5BYiUp0wPrKtt0ky9jJxGM0rktQ5vDmpSFQSKXDhMk=;
        b=aLpFl802AcnXnBpYh1df26o82oGwAPtrvt+jagR0EizdS4uAOd4qmq2/hFQQ8yDeCN
         LjmkhGtEKvP6eFXnA0s6VOx8ud8IR8WhjMWLvD57aPiL94ZxlRQqxJN5sJTJpXgJ/dUf
         a8w0djzY0bTXZkSq+Gj4Fwt1kunJ2GgslI4/bICl41WEF3+FummGQxWr0uv5BmzQFFdG
         bgST8WfQ0P7rYUVvykPY01AK4KXpx9j8+DF7EXp9TkxM86i4JcqKR0iK/0di4vk9UGXo
         OkcwXOBvk5lb19T/qn21lpBt6Lra1T1aLKFFkhJC2hW+biYtzah3FsWsIXQo2cJi1IDb
         y3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5BYiUp0wPrKtt0ky9jJxGM0rktQ5vDmpSFQSKXDhMk=;
        b=Q2KBnNCKoKDR4p2R+XgU38oLUj6ZoC2PL6F8YGgkRpILPe+HmFQ3+4p8MIF7Wf71vA
         zh5rLIAWfmX4aSRP1GH1DGjSTZaQ7cdR2bFWHuwxyRlrUeabhD32F9UM0op0uGzoNXUT
         h1Ib3f6MCeWyASmm7VUmdla4aWf2/Dg3GF0y3D3msA0H0G4AVs8LbQEouoQXYGrj2C/e
         otTtUXvRabft25pnBifqf7IgiWzvxZkf/g5wQd6xwBxdeY9Uhv3zPesT3hQ4EIAeLq2h
         +DEoCW5E2gM5ClJhuFLAS6rEZN7Rx4awspxQbhLd+PPxrduEdwkYyI7y7RmCrEzbdDyl
         6TgA==
X-Gm-Message-State: ABUngvdjYI60oxs2Z8JkxACBJuWH4amyNNV9vLW6bab8BM8uw+SwruxWxFWAm53VEPfacA==
X-Received: by 10.98.52.194 with SMTP id b185mr12848636pfa.41.1478917438143;
        Fri, 11 Nov 2016 18:23:58 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id s8sm18018604pfj.45.2016.11.11.18.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 18:23:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Nov 2016 09:23:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/11] copy.c: convert bb_(p)error_msg to error(_errno)
Date:   Sat, 12 Nov 2016 09:23:29 +0700
Message-Id: <20161112022337.13317-4-pclouds@gmail.com>
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

