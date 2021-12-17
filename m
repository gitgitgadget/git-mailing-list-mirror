Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BE1C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 11:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhLQL2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhLQL2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 06:28:46 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AF4C061747
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:28:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gn2so1963005pjb.5
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ZZ0AA9BLSQgUeabISUg6i9XDF+qvBIEwRKD0GlrlP4=;
        b=KYBpPj+DMpjOYMn7hdQxXJH0BoyOpenU8dhP5DyuUzuVO1RVD0Te9/92N3hgrWhYFG
         bl8V/zxf4Q7jqHu1GbFSA8JGkmY55sULlJRs0FEDxbBFOhhWGoIhQfNbjyiFZctDyo7i
         Qx9do1YLKvnIB9fbluZJQe7QSrZTi50uxp9iil7mJf6QY61Fv23Gb0/dX4pQu+GXb0bb
         o5XCEhjFg8D2OYAD/KZMHBlVCjHog8uPxKpr3bhQHFO1Dp1KbyGQhC7H+J9FFs/zMArX
         ptSCqCLXrQS8VdRmMw+6Yajy9Puk/g/IZDM3X786BTsPtXTa2iE8AA41ORKWizDhli+i
         vvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ZZ0AA9BLSQgUeabISUg6i9XDF+qvBIEwRKD0GlrlP4=;
        b=MzcsDiUU3sh5XbCjCeaBpYkGSJ8cXCPWb2Pzv5NpAsG0PSJ88okQRE2wulXl6dX1yU
         CTSHzIX7X66+WW8QgZOZxuMg93daAIRP+1YCpmILSac+/JAVJ2wMp7KGqzs5kcB0ZabJ
         LVUZILLRnEqpAarITttTJvdE8nWCvL+g2GUHgb31qGPuvIOAa+GDqot1od4ZEEizEHgs
         mLmJAONCA/DA1k/bSJTTxQMtTBo4B9Q4vZo93+jyyT5qKnXAHXqT8iGwb/q7RSLBMYGh
         Hug11fYJffvF/GWT0+5HA49srWoi7Z7p6UkPBlZOAXLNBtRbCpm6X4qxXuQhWd02gg8p
         TB9g==
X-Gm-Message-State: AOAM533/Qks16Mi7OX/jv/I2hfeFeVTeNfoGh1G2ubAWUur0yrGKBeAK
        PtJbz86hXWz21zB+x4F7PtJkzMxTl2epMhDR
X-Google-Smtp-Source: ABdhPJyiQOwukz9Ys4C4BzjjrezKn+U6I7in4mm6WP5TvJhmurrlVoL/kPK9kRt5jxGaLAy8v5TMMQ==
X-Received: by 2002:a17:902:f54e:b0:148:e8ae:ffde with SMTP id h14-20020a170902f54e00b00148e8aeffdemr68822plf.25.1639740525851;
        Fri, 17 Dec 2021 03:28:45 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.97])
        by smtp.gmail.com with ESMTPSA id f10sm5194673pge.33.2021.12.17.03.28.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 03:28:45 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v6 3/6] object-file.c: refactor write_loose_object() to reuse in stream version
Date:   Fri, 17 Dec 2021 19:26:26 +0800
Message-Id: <20211217112629.12334-4-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gfcc2252aea.agit.6.5.6
In-Reply-To: <20211210103435.83656-1-chiyutianyi@gmail.com>
References: <20211210103435.83656-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

We used to call "get_data()" in "unpack_non_delta_entry()" to read the
entire contents of a blob object, no matter how big it is. This
implementation may consume all the memory and cause OOM.

This can be improved by feeding data to "stream_loose_object()" in
stream instead of read into the whole buf.

As this new method "stream_loose_object()" has many similarities with
"write_loose_object()", we split up "write_loose_object()" into some
steps:
 1. Figuring out a path for the (temp) object file.
 2. Creating the tempfile.
 3. Setting up zlib and write header.
 4. Write object data and handle errors.
 5. Optionally, do someting after write, maybe force a loose object if
"mtime".

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 98 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 35 deletions(-)

diff --git a/object-file.c b/object-file.c
index 95fcd5435d..dd29e5372e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1751,6 +1751,25 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
 	algo->final_oid_fn(oid, &c);
 }
 
+/*
+ * Move the just written object with proper mtime into its final resting place.
+ */
+static int finalize_object_file_with_mtime(const char *tmpfile,
+					   const char *filename,
+					   time_t mtime,
+					   unsigned flags)
+{
+	struct utimbuf utb;
+
+	if (mtime) {
+		utb.actime = mtime;
+		utb.modtime = mtime;
+		if (utime(tmpfile, &utb) < 0 && !(flags & HASH_SILENT))
+			warning_errno(_("failed utime() on %s"), tmpfile);
+	}
+	return finalize_object_file(tmpfile, filename);
+}
+
 /*
  * Move the just written object into its final resting place.
  */
@@ -1836,7 +1855,8 @@ static inline int directory_size(const char *filename)
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
  */
-static int create_tmpfile(struct strbuf *tmp, const char *filename)
+static int create_tmpfile(struct strbuf *tmp, const char *filename,
+			  unsigned flags)
 {
 	int fd, dirlen = directory_size(filename);
 
@@ -1844,7 +1864,9 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	strbuf_add(tmp, filename, dirlen);
 	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
 	fd = git_mkstemp_mode(tmp->buf, 0444);
-	if (fd < 0 && dirlen && errno == ENOENT) {
+	do {
+		if (fd >= 0 || !dirlen || errno != ENOENT)
+			break;
 		/*
 		 * Make sure the directory exists; note that the contents
 		 * of the buffer are undefined after mkstemp returns an
@@ -1854,17 +1876,48 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 		strbuf_reset(tmp);
 		strbuf_add(tmp, filename, dirlen - 1);
 		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
-			return -1;
+			break;
 		if (adjust_shared_perm(tmp->buf))
-			return -1;
+			break;
 
 		/* Try again */
 		strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
 		fd = git_mkstemp_mode(tmp->buf, 0444);
+	} while (0);
+
+	if (fd < 0 && !(flags & HASH_SILENT)) {
+		if (errno == EACCES)
+			return error(_("insufficient permission for adding an "
+				       "object to repository database %s"),
+				     get_object_directory());
+		else
+			return error_errno(_("unable to create temporary file"));
 	}
+
 	return fd;
 }
 
+static void setup_stream_and_header(git_zstream *stream,
+				    unsigned char *compressed,
+				    unsigned long compressed_size,
+				    git_hash_ctx *c,
+				    char *hdr,
+				    int hdrlen)
+{
+	/* Set it up */
+	git_deflate_init(stream, zlib_compression_level);
+	stream->next_out = compressed;
+	stream->avail_out = compressed_size;
+	the_hash_algo->init_fn(c);
+
+	/* First header.. */
+	stream->next_in = (unsigned char *)hdr;
+	stream->avail_in = hdrlen;
+	while (git_deflate(stream, 0) == Z_OK)
+		; /* nothing */
+	the_hash_algo->update_fn(c, hdr, hdrlen);
+}
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime, unsigned flags)
@@ -1879,31 +1932,15 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 	loose_object_path(the_repository, &filename, oid);
 
-	fd = create_tmpfile(&tmp_file, filename.buf);
+	fd = create_tmpfile(&tmp_file, filename.buf, flags);
 	if (fd < 0) {
-		if (flags & HASH_SILENT)
-			ret = -1;
-		else if (errno == EACCES)
-			ret = error(_("insufficient permission for adding an "
-				      "object to repository database %s"),
-				    get_object_directory());
-		else
-			ret = error_errno(_("unable to create temporary file"));
+		ret = -1;
 		goto cleanup;
 	}
 
-	/* Set it up */
-	git_deflate_init(&stream, zlib_compression_level);
-	stream.next_out = compressed;
-	stream.avail_out = sizeof(compressed);
-	the_hash_algo->init_fn(&c);
-
-	/* First header.. */
-	stream.next_in = (unsigned char *)hdr;
-	stream.avail_in = hdrlen;
-	while (git_deflate(&stream, 0) == Z_OK)
-		; /* nothing */
-	the_hash_algo->update_fn(&c, hdr, hdrlen);
+	/* Set it up and write header */
+	setup_stream_and_header(&stream, compressed, sizeof(compressed),
+				&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
 	stream.next_in = (void *)buf;
@@ -1932,16 +1969,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 	close_loose_object(fd);
 
-	if (mtime) {
-		struct utimbuf utb;
-		utb.actime = mtime;
-		utb.modtime = mtime;
-		if (utime(tmp_file.buf, &utb) < 0 &&
-		    !(flags & HASH_SILENT))
-			warning_errno(_("failed utime() on %s"), tmp_file.buf);
-	}
-
-	ret = finalize_object_file(tmp_file.buf, filename.buf);
+	ret = finalize_object_file_with_mtime(tmp_file.buf, filename.buf, mtime, flags);
 cleanup:
 	strbuf_release(&filename);
 	strbuf_release(&tmp_file);
-- 
2.34.1.52.gfcc2252aea.agit.6.5.6

