Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEDCC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 19:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbiLNTR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 14:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbiLNTRw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 14:17:52 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C552AE29
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:17:51 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z8-20020aa79588000000b00576e8050ec9so4641181pfj.5
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PokTXdcWDIu6o20ogSe6ikWoZlBf2JTCrAgI3zvJZJU=;
        b=YrWaTrVMBb4kFhSGlnNfKqIH9sPlhEjjMv6lRbFqZRExN62m94BrZobxM3uT/dR1hW
         1Pozg8vvbXKhN88q4KeRcoWVRXh36bDa1mcC469ibSlDsUrxkH0SaNrT+B/SFy4VBg/C
         /XkSO5WGdAzU57tlOAmsfSsEFcjBhuauoetmIIItReH6scdtglo/HJng2Ejm14R27rZo
         XMU60ZlnLXxTCQ9YSspuTzNXSgiFL9XCrr5M1ei7G6dtbMo6Z5DIRyMx4lPClyJgOQ4u
         Jw/ngGbt4xydgAJKHkcP2ok/Yf2OAVygqFoZ27EYDoRfe0B0v2ssVxRVNfbtdyRIBJDB
         lqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PokTXdcWDIu6o20ogSe6ikWoZlBf2JTCrAgI3zvJZJU=;
        b=WsgOxhCro4VrJHZaVqNtIps/XL5lcIaWbyDLcHlHMiQvZbUS7ZgRtmLJAYrIyNtQS8
         tSToaX5jZ4AdXlxynVHZU0mNueYfHkT1x1dezTzPRrTvNnFLRX14u1Y9gF7dMsqdvouv
         Gzlo5JlR+QIq5B3K2FB6z1JMXcE87oI2u2Qq9RvlcSJSJbQBNQGpl2V9lgmim1BIkKIa
         ffO8GrdgMbj/6MLBoOQERRTKIA2CbiPx0xqGMswGlWhOvE76m0sHl7640m/59J5BeO9N
         RUs6Q2EoWOsAHQuU1xF7HUz+YZLC5DyAI64vp0MvX8SzF0kqQmeDo0anj2RuGCBCipbE
         iT4w==
X-Gm-Message-State: ANoB5pnqNFL9EPaFXTnPC+93X4svPQ4iKsno0CCKcxOvwJFfXYT1HXz4
        Kzcde2MP/m4d+zMG0+WP+PsBQyEHKaNPPISuaTnroyymMXlsOdxjy41HQ0/4MG+lrCn/8exI1vJ
        lQVc1rbaQFDiDJVMHACHnL7TSWEGUTIozQ3P3SUhSo+zrMETT/GPq36x0kLaqJstm83w/+waOTW
        P9
X-Google-Smtp-Source: AA0mqf6v/Y9xZJxi+uPe6M+RBzUbu21hVi71WVmF6zhtbJZ8rsAFSXN0JltHmlQLa0MUdPng1Yc8mcqJQOsffJ+WeVky
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:1c4:b0:189:e149:a1af with
 SMTP id e4-20020a17090301c400b00189e149a1afmr16318707plh.18.1671045470980;
 Wed, 14 Dec 2022 11:17:50 -0800 (PST)
Date:   Wed, 14 Dec 2022 11:17:41 -0800
In-Reply-To: <cover.1671045259.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1671045259.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <4b2fb687432c2ce1471d9eb02e86b3acc43cc953.1671045259.git.jonathantanmy@google.com>
Subject: [PATCH v6 2/4] object-file: refactor map_loose_object_1()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function can do 3 things:
 1. Gets an fd given a path
 2. Simultaneously gets a path and fd given an OID
 3. Memory maps an fd

Keep 3 (renaming the function accordingly) and inline 1 and 2 into their
respective callers.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/object-file.c b/object-file.c
index cf724bc19b..429e3a746d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1211,35 +1211,25 @@ static int quick_has_loose(struct repository *r,
 }
 
 /*
- * Map the loose object at "path" if it is not NULL, or the path found by
- * searching for a loose object named "oid".
+ * Map and close the given loose object fd. The path argument is used for
+ * error reporting.
  */
-static void *map_loose_object_1(struct repository *r, const char *path,
-			     const struct object_id *oid, unsigned long *size)
+static void *map_fd(int fd, const char *path, unsigned long *size)
 {
-	void *map;
-	int fd;
-
-	if (path)
-		fd = git_open(path);
-	else
-		fd = open_loose_object(r, oid, &path);
-	map = NULL;
-	if (fd >= 0) {
-		struct stat st;
+	void *map = NULL;
+	struct stat st;
 
-		if (!fstat(fd, &st)) {
-			*size = xsize_t(st.st_size);
-			if (!*size) {
-				/* mmap() is forbidden on empty files */
-				error(_("object file %s is empty"), path);
-				close(fd);
-				return NULL;
-			}
-			map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!fstat(fd, &st)) {
+		*size = xsize_t(st.st_size);
+		if (!*size) {
+			/* mmap() is forbidden on empty files */
+			error(_("object file %s is empty"), path);
+			close(fd);
+			return NULL;
 		}
-		close(fd);
+		map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
 	}
+	close(fd);
 	return map;
 }
 
@@ -1247,7 +1237,12 @@ void *map_loose_object(struct repository *r,
 		       const struct object_id *oid,
 		       unsigned long *size)
 {
-	return map_loose_object_1(r, NULL, oid, size);
+	const char *p;
+	int fd = open_loose_object(r, oid, &p);
+
+	if (fd < 0)
+		return NULL;
+	return map_fd(fd, p, size);
 }
 
 enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
@@ -2789,13 +2784,16 @@ int read_loose_object(const char *path,
 		      struct object_info *oi)
 {
 	int ret = -1;
+	int fd;
 	void *map = NULL;
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 	unsigned long *size = oi->sizep;
 
-	map = map_loose_object_1(the_repository, path, NULL, &mapsize);
+	fd = git_open(path);
+	if (fd >= 0)
+		map = map_fd(fd, path, &mapsize);
 	if (!map) {
 		error_errno(_("unable to mmap %s"), path);
 		goto out;
-- 
2.39.0.314.g84b9a713c41-goog

