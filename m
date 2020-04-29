Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147B3C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E108520757
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="p7MDWin9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgD2Rgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2Rgh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 13:36:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C661FC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:36:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fu13so1034121pjb.5
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m8WPRTZAA4ifjAR9b5/RmtGZJzGpRFy5RWTfVKbAGNM=;
        b=p7MDWin97u9/qwvuq817NQxJIQDjBLWEyMAy2uycqaoXZ6EVvt1ivwNOONDZJ3FeHJ
         xX+5Ee57JpsgvuZcDGIFyy6lXHmFKvbsrOkzvmAlzZVkktTuaVy79J9OnHzJjNRsZppB
         kTAHE1G5uv12Ew+nwvIr3dulq363l+sJ2HTvJQOKZXlnMAsnb56xJI5HTsK+Q47sBg1/
         IyIFa8BX2ohwh6/DtdVefBv7pupeCG3cIc/CkPBnt3GU37wu39+2xKb0S2/ciXc8QIGF
         RA8Npq6ZcVFWl404euaMtzrIAAK1xr8pZlVxwLWa0p3vjFgD0gxf3d3JWVa9uQbfimmh
         m/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m8WPRTZAA4ifjAR9b5/RmtGZJzGpRFy5RWTfVKbAGNM=;
        b=JbeN0xJgA0Fx6tsFQg57lJdG+tjtv+rZB/bVWE+liGyuPZ3xDao8dFAi3kgJwBa/21
         zZYf1J0t245mP7Mi3MdeTQb9knk4AlGdLhGpEFsb66lSIRY9PyJlXvuAsGiEjY0yOsoK
         9XVxJueBFKvlb/gCgcbzbfPGVDiXKmup4dz9Om2UcFokrxjUN/kVrKhjkXDNKgbc0Iy0
         w07qEa0aPAjRlALq6ka4krv3qvl+tX0/5hPdiT/YYHydwDceE6axqrDX1CdCO37grhJx
         ZoC2tOC6UvDUCF5UgC8O1s2HewWm/5BG+Xf0LHvZ9CQEd1phlsZ8KBRXJ919Dg7z86ol
         97Fg==
X-Gm-Message-State: AGi0PuaO9zxKV8yrPBpGMiIarX+56ct+SeAV8SvCGQJGyMTk50vXggJm
        McXHn4W+0fHKt7QBNBq0bqCcUt1sCKa4aQ==
X-Google-Smtp-Source: APiQypI/hHhUfvIfeMokZKBdG7vGt9THszpzHOIIFtbSqQrfB+aaLzZKN8ofe/tZQ8hxoPvY/4Vq9A==
X-Received: by 2002:a17:90a:25ea:: with SMTP id k97mr4547408pje.122.1588181796784;
        Wed, 29 Apr 2020 10:36:36 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y7sm1541901pfq.21.2020.04.29.10.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:36:36 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:36:35 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: [PATCH v3 2/5] lockfile.c: introduce 'hold_lock_file_for_update_mode'
Message-ID: <c1c84552bc69218299ce182388b6a888b3c71056.1588181626.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588181626.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588181626.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use 'hold_lock_file_for_update' (and the '_timeout') variant to
acquire a lock when updating references, the commit-graph file, and so
on.

In particular, the commit-graph machinery uses this to acquire a
temporary file that is used to write a non-split commit-graph. In a
subsequent commit, an issue in the commit-graph machinery produces
graph files that have a different permission based on whether or not
they are part of a multi-layer graph will be addressed.

To do so, the commit-graph machinery will need a version of
'hold_lock_file_for_update' that takes the permission bits from the
caller.

Introduce such a function in this patch for both the
'hold_lock_file_for_update' and 'hold_lock_file_for_update_timeout'
functions, and leave the existing functions alone by inlining their
definitions in terms of the new mode variants.

Note that, like in the previous commit, 'hold_lock_file_for_update_mode'
is not guarenteed to set the given mode, since it may be modified by
both the umask and 'core.sharedRepository'.

Note also that even though the commit-graph machinery only calls
'hold_lock_file_for_update', that this is defined in terms of
'hold_lock_file_for_update_timeout', and so both need an additional mode
parameter here.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 lockfile.c | 18 ++++++++++--------
 lockfile.h | 32 ++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 8e8ab4f29f..cc9a4b8428 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -70,7 +70,8 @@ static void resolve_symlink(struct strbuf *path)
 }
 
 /* Make sure errno contains a meaningful value on error */
-static int lock_file(struct lock_file *lk, const char *path, int flags)
+static int lock_file(struct lock_file *lk, const char *path, int flags,
+		     int mode)
 {
 	struct strbuf filename = STRBUF_INIT;
 
@@ -79,7 +80,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		resolve_symlink(&filename);
 
 	strbuf_addstr(&filename, LOCK_SUFFIX);
-	lk->tempfile = create_tempfile(filename.buf);
+	lk->tempfile = create_tempfile_mode(filename.buf, mode);
 	strbuf_release(&filename);
 	return lk->tempfile ? lk->tempfile->fd : -1;
 }
@@ -99,7 +100,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
  * exactly once. If timeout_ms is -1, try indefinitely.
  */
 static int lock_file_timeout(struct lock_file *lk, const char *path,
-			     int flags, long timeout_ms)
+			     int flags, long timeout_ms, int mode)
 {
 	int n = 1;
 	int multiplier = 1;
@@ -107,7 +108,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 	static int random_initialized = 0;
 
 	if (timeout_ms == 0)
-		return lock_file(lk, path, flags);
+		return lock_file(lk, path, flags, mode);
 
 	if (!random_initialized) {
 		srand((unsigned int)getpid());
@@ -121,7 +122,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 		long backoff_ms, wait_ms;
 		int fd;
 
-		fd = lock_file(lk, path, flags);
+		fd = lock_file(lk, path, flags, mode);
 
 		if (fd >= 0)
 			return fd; /* success */
@@ -169,10 +170,11 @@ NORETURN void unable_to_lock_die(const char *path, int err)
 }
 
 /* This should return a meaningful errno on failure */
-int hold_lock_file_for_update_timeout(struct lock_file *lk, const char *path,
-				      int flags, long timeout_ms)
+int hold_lock_file_for_update_timeout_mode(struct lock_file *lk,
+					   const char *path, int flags,
+					   long timeout_ms, int mode)
 {
-	int fd = lock_file_timeout(lk, path, flags, timeout_ms);
+	int fd = lock_file_timeout(lk, path, flags, timeout_ms, mode);
 	if (fd < 0) {
 		if (flags & LOCK_DIE_ON_ERROR)
 			unable_to_lock_die(path, errno);
diff --git a/lockfile.h b/lockfile.h
index 9843053ce8..db93e6ba73 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -90,6 +90,15 @@
  * functions. In particular, the state diagram and the cleanup
  * machinery are all implemented in the tempfile module.
  *
+ * Permission bits
+ * ---------------
+ *
+ * If you call either `hold_lock_file_for_update_mode` or
+ * `hold_lock_file_for_update_timeout_mode`, you can specify a suggested
+ * mode for the underlying temporary file. Note that the file isn't
+ * guaranteed to have this exact mode, since it may be limited by either
+ * the umask, 'core.sharedRepository', or both. See `adjust_shared_perm`
+ * for more.
  *
  * Error handling
  * --------------
@@ -156,12 +165,20 @@ struct lock_file {
  * file descriptor for writing to it, or -1 on error. If the file is
  * currently locked, retry with quadratic backoff for at least
  * timeout_ms milliseconds. If timeout_ms is 0, try exactly once; if
- * timeout_ms is -1, retry indefinitely. The flags argument and error
- * handling are described above.
+ * timeout_ms is -1, retry indefinitely. The flags argument, error
+ * handling, and mode are described above.
  */
-int hold_lock_file_for_update_timeout(
+int hold_lock_file_for_update_timeout_mode(
 		struct lock_file *lk, const char *path,
-		int flags, long timeout_ms);
+		int flags, long timeout_ms, int mode);
+
+static inline int hold_lock_file_for_update_timeout(
+		struct lock_file *lk, const char *path,
+		int flags, long timeout_ms)
+{
+	return hold_lock_file_for_update_timeout_mode(lk, path, flags,
+						      timeout_ms, 0666);
+}
 
 /*
  * Attempt to create a lockfile for the file at `path` and return a
@@ -175,6 +192,13 @@ static inline int hold_lock_file_for_update(
 	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
 }
 
+static inline int hold_lock_file_for_update_mode(
+		struct lock_file *lk, const char *path,
+		int flags, int mode)
+{
+	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode);
+}
+
 /*
  * Return a nonzero value iff `lk` is currently locked.
  */
-- 
2.26.0.113.ge9739cdccc

