Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67349C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiLLWuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiLLWt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:49:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F62F6261
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:49:00 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-360b9418f64so146877027b3.7
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IC3BUgof840lhumwoRwCw8PH+u3UlMHZYmpnyBupWOU=;
        b=V7EqfOC+zLjtEk0G4pA3K5bAxxC2O+/v4fM4FUUjw2fTSCxobIHGnONL6juE9QWgHn
         3QSpefGevD6vsMAjeWal83F417ogEWLagwBlYVezulb2eqOlfVGr5mjsoDvovCGqXxm1
         +AROiYtVDjiOaoXdvBJm6V4BU1/d1952DFYG4ZeBYkSihY5jm55Dd3s2cfLVjhRrcmvA
         KkYjmDqc7t8158G04fkyhtUauEZ2qp6mECbFyAFnul7+UH70w5897Y63qVVMbLmfXDYC
         QPO7QPISFrwFG4lJFe/MWYB9j1QNM12B57GQyB/XNlDZXULkH3bW3dAoHpzOuLLkWHt2
         ocOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IC3BUgof840lhumwoRwCw8PH+u3UlMHZYmpnyBupWOU=;
        b=V4u96DHNXaZ1MwxfUVGKT6JAc8+A2VNigkyi0Ojul5RSGd61DNHmJB4ETkHTXfKFic
         dmSuPs+fvptDda1oV176OyNo4px2GsdVzT8SNbedqhttss6xAyQCyjgwTeykVUEN7LxN
         76xLH+tdRJ7fNEs+gJAMN1d7VPxn5RbjkbCptD7VKSp7ordjBKWFGBtSyS7agVyjLdPH
         xusg8x4RGecw/odc8xOwYod4H+bUXr7oq2i3bQ5PqG2K+Xp3XvzCV8Y6gyVGqWx/PlJh
         fQxaBjlQ23mvmJbyY+3vtkqXmybXkNmsrD18Ewshtc7Fq4bDxIihFKk8xRPnzqV6tnw+
         BqKA==
X-Gm-Message-State: ANoB5pl5o91G16vHSKGwcQifbOvveiHWX/BFdmDdFaGMO+4E4joBir73
        zxU3wF1C762avSNUa0TH4ctjC0KbMz2d06uAkAoISFzSyJgq9x7tk6OFS5i3s3m6P3rE72DQX0a
        xWFG2cNoyHVZxNoAio/xx60TnxNktJAr5US7pmAnqvkcfk07iKbZBLTRDsh9lD+1MS8PptxsC8Y
        gf
X-Google-Smtp-Source: AA0mqf43pdWUJ6v4bW3DcUZb4r3xNMcQs5CijKvp/Hlgb3ZG68N4/dnsJKITe5/SCbn+bCotVwoYd9zZCDy4c5nBECTa
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:e51:0:b0:3df:21db:24f3 with SMTP
 id 78-20020a810e51000000b003df21db24f3mr28168805ywo.25.1670885339394; Mon, 12
 Dec 2022 14:48:59 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:48:49 -0800
In-Reply-To: <cover.1670885252.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670885252.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <4b2fb687432c2ce1471d9eb02e86b3acc43cc953.1670885252.git.jonathantanmy@google.com>
Subject: [PATCH v5 2/4] object-file: refactor map_loose_object_1()
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
2.39.0.rc1.256.g54fd8350bd-goog

