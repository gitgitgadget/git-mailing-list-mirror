Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48834C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 21:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiLIVok (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 16:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiLIVof (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 16:44:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61604303EF
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 13:44:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 195-20020a2505cc000000b0071163981d18so6368545ybf.13
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 13:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IC3BUgof840lhumwoRwCw8PH+u3UlMHZYmpnyBupWOU=;
        b=tkCi1y8qVN4IhMstv1A1nasex/FK9mFUAjKu19pCiOg/RNk3A3Rs7zt72DhZZRJ9bv
         Hk6qu5wJquciV0DU92HceqAw5FicjdRJpzPwb2ZKleoHKrxDoTX+H3QaMpo3Rnd0qa1/
         Z21FjWVUIhxUhTIvELgfJ5WsnEQma46p0U5iIcEz0B/oFy9m5Xrswxnu+fYneg9Uf4WG
         wl4+6ZST6QjiQ7zEsnFB49sTQU1El1iNFABRHS42hzOdPv4ZNQr5BCHHrBaUEW6oVOrJ
         QPHQBxs+RpPfR120hK7OMh1LqpXg1ne1wUuijupOS/ey4SrPEmh5FxLiDuK/P+y5bzU0
         BHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IC3BUgof840lhumwoRwCw8PH+u3UlMHZYmpnyBupWOU=;
        b=2zana7/ZCzE++a1DrBNF7WvIIbBdg0tX9DI6n9Cr0daziw7soCrYfUJGrOJKzIkhHS
         +xkC+GvEUz+jni7wcuQTBEGaFa11/X8v2UbjADm7TAftQgRNzWaSPq5MQ1IYb8xb3yHd
         AsdqxlHMq5MZjZB/gsX5J8CQjt93RzRqguVDVmAHheAX1BL8A3qZSK2D4rqC+G+eHjpQ
         zfefLr53qku3r24R9oDr6EEOrUQneJtdfI1SN1wMQyt3izmp7mJgCHc6v03rMSI7x5jp
         hjyDL5rjsVMDWfvS9g2+QidIM3PPBbARXWvN5c4iAEbDIjK6ArGpe9wUyoC/ZiuJyAzb
         5iNA==
X-Gm-Message-State: ANoB5pnCxfCmKpXMDeTZCrCiFBnAaI1eDzSWKWveDY/bQ8vd1Tl6UQ7K
        Nlvwnt71HhuuQ7yLRDb9c6sE7ZgBk/tdy8nyeOd7sqF4dKzVxEMcdQA5KcJ3nacUT2ntL251r1j
        c6wkO7fGDU4dnWDIhKadeJsO2ouJ6/rAPZsfSYHPdmU6D6eoWAAzBO6hqjxD9F7n9uytATnMgJo
        qi
X-Google-Smtp-Source: AA0mqf65A6irwbQyleOQhrWa08L9X05wdVXkJ5Cn0mSwWhiQIHxHzToCtN/gKCUCbjTF5FTB/JB2wb42zcQSxGVFlfMw
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d613:0:b0:6f9:6faa:d508 with
 SMTP id n19-20020a25d613000000b006f96faad508mr37307153ybg.421.1670622273593;
 Fri, 09 Dec 2022 13:44:33 -0800 (PST)
Date:   Fri,  9 Dec 2022 13:44:23 -0800
In-Reply-To: <cover.1670622176.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670622176.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <4b2fb687432c2ce1471d9eb02e86b3acc43cc953.1670622176.git.jonathantanmy@google.com>
Subject: [PATCH v4 2/4] object-file: refactor map_loose_object_1()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        avarab@gmail.com
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
2.39.0.rc1.256.g54fd8350bd-goog

