Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10A0C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 20:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiLHU5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 15:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLHU5W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 15:57:22 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF989856E
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 12:57:19 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r126-20020a632b84000000b004393806c06eso1751308pgr.4
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 12:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9OoDBP7BJA65Rln1WW347sVNHFjzrPX6KpvyHaLduo=;
        b=jyv1iVqZPyxRn+N7ujMWwqzGO35G6uRDk4h4LUmEMypo8JFsniuUF9dPbmsYNLOgCS
         DvLxGYcDRpFK9GO5KVTc7QipCc25Ccyw7nIkCZBwIiK6E1q68udKwLeUm6YgVvYcukAn
         b3JYKfXIIXLCKMnQ1daqYlf3dqZHZYZ6KqtxqDa3oA6nljJf3CnN2ByxdtPqIN924LFJ
         QtRQfKntCwKv5xVgTK6M+u/zYI02HuY2xPH622By841BOiYJwtHMTNLgHTc6/TJ90T/9
         FnQ8Te16zB6W0qWMfQF5x/HPqTmrCO5LbdOXlZ+Qn9oCXW62yZK8LwUuaoHtImrE5aWD
         LV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9OoDBP7BJA65Rln1WW347sVNHFjzrPX6KpvyHaLduo=;
        b=Pms+jfRJvaoLRoL0K8xKh6/IHHcbID/Sl1F5c2pLzsgPjNyfaTJvFmn97hEMBpC9yN
         2LsLd3l3EcTX4/r8DBWws43P2A2AEJ/1Vrl8kmx5Vq8M2qa/gQTtHcm8OLEsWTa4hAEx
         lzNxyqPf8BigazaiRsM9mlhOZp5OU8N29pHY3FEWW/Dsf782i2EV/n/Du76YYfW6CAks
         rFFCJQYi4wkdA2BHTq8FdhfuaWQHVHLIBaeoNc+RmHklRuFqHNFyNysKS0ID3oHt/Eg1
         vKKtpSLcUTNeuShXVALhPAhgZVk7/6axTBxUkx+Cf0n1bElxoH2M9a2NpfiFdb5VjAS6
         Y5EQ==
X-Gm-Message-State: ANoB5pnKusJMJZ4t0kHIVpQsIqokR4mT7jsLWM5/KMjR+9v+6iiDMPPE
        1WXQ01SOjy5hHf9xSMjOxa+FUx3694tw2LV/dfxmKnb84fw6h3vj7U10xDBrPO2VbZf21pguFH5
        nNOZr7DegWtPnshoNUzpiQGej0LleU1KOWFnJQfisTqdO+nb6wdlh560wZHhR2MhLKApHqZtp//
        km
X-Google-Smtp-Source: AA0mqf6W5b5ZeSclPPkIRKESCW1OBcw/vH37QZT4XZp+hr+KEKHuD2xEXL8fCRyraXouwqCebeDXdcW6ZTHYdXM48lrF
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:500f:0:b0:478:bc19:a510 with
 SMTP id e15-20020a63500f000000b00478bc19a510mr15887040pgb.288.1670533038831;
 Thu, 08 Dec 2022 12:57:18 -0800 (PST)
Date:   Thu,  8 Dec 2022 12:57:06 -0800
In-Reply-To: <cover.1670532905.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670532905.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <7419e4ac7053ab2d89a4cdc4612e5baeca48ce9f.1670532905.git.jonathantanmy@google.com>
Subject: [PATCH v3 2/4] object-file: refactor map_loose_object_1()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        avarab@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function can do 3 things:
 1. Gets an fd given a path
 2. Simultaneously gets a path and fd given an OID
 3. Memory maps an fd

Split this function up. Only one caller needs 1, so inline that. As for
2, a future patch will also need this functionality and, in addition,
the calculated path, so extract this into a separate function with an
out parameter for the path.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c | 60 +++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/object-file.c b/object-file.c
index cf724bc19b..d99d05839f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1211,43 +1211,48 @@ static int quick_has_loose(struct repository *r,
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
 
+static void *map_loose_object_1(struct repository *r,
+				const struct object_id *oid,
+				unsigned long *size,
+				const char **path)
+{
+	const char *p;
+	int fd = open_loose_object(r, oid, &p);
+
+	if (fd < 0)
+		return NULL;
+	if (path)
+		*path = p;
+	return map_fd(fd, p, size);
+}
+
 void *map_loose_object(struct repository *r,
 		       const struct object_id *oid,
 		       unsigned long *size)
 {
-	return map_loose_object_1(r, NULL, oid, size);
+	return map_loose_object_1(r, oid, size, NULL);
 }
 
 enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
@@ -2789,13 +2794,16 @@ int read_loose_object(const char *path,
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

