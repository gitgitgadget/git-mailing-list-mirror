Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056D3C433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 08:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiAHI4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 03:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiAHI4e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 03:56:34 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDB0C061574
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 00:56:34 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v25so7878211pge.2
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 00:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ta75UCWo4uaFf+Myyrd3yxCCpaAj5zRZZziSce7FLFg=;
        b=B19Wm1MkLi4ScQzGOhQ/eqtGa6aFBiMEC6Nv9lmRHPTfxz112d+TEZO1gpCknnA7LQ
         Tpfl2l+BczbvRwRbJKoKXY08Q3hCF6+zKVbmVnaFhdd4uPQkXPpx64xfl2dbkr9gKRoy
         LB7vICqiOlDPJhHchtijM0POz2mhC/RYCL4ZHwbbfrLiPBUrJ91Oh/iJn/ljWdz6uniC
         /hX5l8Eyyg0O0X8CLR+NvQ8GFT9AJERKjR/cIR1bFCQDAhvsUM0woQVP/quGHnhIsXqy
         VwXXRA97SkHMJs8YZO2JXVB4UM6tt/xtAx7UsVDiZ0w0kWcWngcUnZQp5VYvyUkSCSuK
         0Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ta75UCWo4uaFf+Myyrd3yxCCpaAj5zRZZziSce7FLFg=;
        b=FtwbUtYU6j3SYiOgu8ACS0WLADxWHxS0DIZE9X6etsQtu+r1n9aHnVZeQgZoHcIjvN
         p2vdRo9ZydQKIr9zXQsJu1P5RJll4lGciZ0fCmHwIOU7kNiT2KXYIbfSx/PBjr7COjpm
         CvAZEGrTCZhM3aDXe/tZMamWeJDJyRLIxCcF8Kmu3Kij87IUoGe7LjK3pNZGKgtZv9gr
         O1t6gcA+d5qxmcox/N7hVni5PD1FURuF7WsUwtV3kOqgHILGouj5iVmbhu7QLrtf0bYF
         kSwsvFGaGG2EVFRhmuq9jb2J4+VKuQeK9bY4s64MIdIqeedia1iGM6nqZ+aMiaQC0MI1
         ZjzA==
X-Gm-Message-State: AOAM532B5VzrCpDqVd4ltsGb11c6cAQmN0JKTNI+h0PPJRm5IE0AX+Nx
        xb9lhVDylPr4o2G9oh8WkbY=
X-Google-Smtp-Source: ABdhPJz65Uyn0AtQqFhCUxmqYpoxLqNZxbqUmRfyPHvCxGmW65ezewcADdXSm9W5gXes8GtcrqI0Qw==
X-Received: by 2002:a63:7148:: with SMTP id b8mr37114750pgn.616.1641632194259;
        Sat, 08 Jan 2022 00:56:34 -0800 (PST)
Received: from localhost.localdomain ([58.100.34.57])
        by smtp.gmail.com with ESMTPSA id x25sm1240990pfu.113.2022.01.08.00.56.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jan 2022 00:56:33 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v8 2/6] object-file.c: refactor write_loose_object() to several steps
Date:   Sat,  8 Jan 2022 16:54:15 +0800
Message-Id: <20220108085419.79682-3-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gc288e771b4.agit.6.5.6
In-Reply-To: <20211217112629.12334-1-chiyutianyi@gmail.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

When writing a large blob using "write_loose_object()", we have to pass
a buffer with the whole content of the blob, and this behavior will
consume lots of memory and may cause OOM. We will introduce a stream
version function ("stream_loose_object()") in latter commit to resolve
this issue.

Before introducing a stream vesion function for writing loose object,
do some refactoring on "write_loose_object()" to reuse code for both
versions.

Rewrite "write_loose_object()" as follows:

 1. Figure out a path for the (temp) object file. This step is only
    used in "write_loose_object()".

 2. Move common steps for starting to write loose objects into a new
    function "start_loose_object_common()".

 3. Compress data.

 4. Move common steps for ending zlib stream into a new funciton
    "end_loose_object_common()".

 5. Close fd and finalize the object file.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 149 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 105 insertions(+), 44 deletions(-)

diff --git a/object-file.c b/object-file.c
index eb1426f98c..5d163081b1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1743,6 +1743,25 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
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
@@ -1828,7 +1847,8 @@ static inline int directory_size(const char *filename)
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
  */
-static int create_tmpfile(struct strbuf *tmp, const char *filename)
+static int create_tmpfile(struct strbuf *tmp, const char *filename,
+			  unsigned flags)
 {
 	int fd, dirlen = directory_size(filename);
 
@@ -1836,7 +1856,9 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
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
@@ -1846,17 +1868,72 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
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
 
+static int start_loose_object_common(struct strbuf *tmp_file,
+				     const char *filename, unsigned flags,
+				     git_zstream *stream,
+				     unsigned char *buf, size_t buflen,
+				     git_hash_ctx *c,
+				     enum object_type type, size_t len,
+				     char *hdr, int hdrlen)
+{
+	int fd;
+
+	fd = create_tmpfile(tmp_file, filename, flags);
+	if (fd < 0)
+		return -1;
+
+	/*  Setup zlib stream for compression */
+	git_deflate_init(stream, zlib_compression_level);
+	stream->next_out = buf;
+	stream->avail_out = buflen;
+	the_hash_algo->init_fn(c);
+
+	/*  Start to feed header to zlib stream */
+	stream->next_in = (unsigned char *)hdr;
+	stream->avail_in = hdrlen;
+	while (git_deflate(stream, 0) == Z_OK)
+		; /* nothing */
+	the_hash_algo->update_fn(c, hdr, hdrlen);
+
+	return fd;
+}
+
+static void end_loose_object_common(int ret, git_hash_ctx *c,
+				    git_zstream *stream,
+				    struct object_id *parano_oid,
+				    const struct object_id *expected_oid,
+				    const char *die_msg1_fmt,
+				    const char *die_msg2_fmt)
+{
+	if (ret != Z_STREAM_END)
+		die(_(die_msg1_fmt), ret, expected_oid);
+	ret = git_deflate_end_gently(stream);
+	if (ret != Z_OK)
+		die(_(die_msg2_fmt), ret, expected_oid);
+	the_hash_algo->final_oid_fn(parano_oid, c);
+}
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime, unsigned flags)
@@ -1871,28 +1948,18 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 	loose_object_path(the_repository, &filename, oid);
 
-	fd = create_tmpfile(&tmp_file, filename.buf);
-	if (fd < 0) {
-		if (flags & HASH_SILENT)
-			return -1;
-		else if (errno == EACCES)
-			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
-		else
-			return error_errno(_("unable to create temporary file"));
-	}
-
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
+	/* Common steps for write_loose_object and stream_loose_object to
+	 * start writing loose oject:
+	 *
+	 *  - Create tmpfile for the loose object.
+	 *  - Setup zlib stream for compression.
+	 *  - Start to feed header to zlib stream.
+	 */
+	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
+				       &stream, compressed, sizeof(compressed),
+				       &c, OBJ_NONE, 0, hdr, hdrlen);
+	if (fd < 0)
+		return -1;
 
 	/* Then the data itself.. */
 	stream.next_in = (void *)buf;
@@ -1907,30 +1974,24 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		stream.avail_out = sizeof(compressed);
 	} while (ret == Z_OK);
 
-	if (ret != Z_STREAM_END)
-		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
-		    ret);
-	ret = git_deflate_end_gently(&stream);
-	if (ret != Z_OK)
-		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
-		    ret);
-	the_hash_algo->final_oid_fn(&parano_oid, &c);
+	/* Common steps for write_loose_object and stream_loose_object to
+	 * end writing loose oject:
+	 *
+	 *  - End the compression of zlib stream.
+	 *  - Get the calculated oid to "parano_oid".
+	 */
+	end_loose_object_common(ret, &c, &stream, &parano_oid, oid,
+				N_("unable to deflate new object %s (%d)"),
+				N_("deflateEnd on object %s failed (%d)"));
+
 	if (!oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
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
-	return finalize_object_file(tmp_file.buf, filename.buf);
+	return finalize_object_file_with_mtime(tmp_file.buf, filename.buf,
+					       mtime, flags);
 }
 
 static int freshen_loose_object(const struct object_id *oid)
-- 
2.34.1.52.gc288e771b4.agit.6.5.6

