Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926D4C43334
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 02:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349566AbiFKCos (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 22:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347920AbiFKCoq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 22:44:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5927A3F4A28
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 19:44:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gd1so988716pjb.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 19:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAHnND6bDK2oZQJf5VQQH8A7hAEVL5pBw/UAWDyn6/Y=;
        b=Z8epYP+8N0zhFAUPVFhrCgQndzxbOLHZppfEHwTwTIp16xWALROyctD9JR+qyY14DY
         /t8gZ3BSgCuCtY0M82DtlT+iFJD2EIelBHe8guyYnuKXRnsBR7QBsmbLwdHZCUdZ/wY4
         mYzjBU6giZTta3rv8yA1D/ytP8ro8tMZBJlxqA+PPU+DeOHUwhdoekqkFWIa+9CHr0Hl
         DOpkyD/snY6zQ5tZa7LoZSev9/h014nAybBLDCdH1Ml18x3FpjpddGInbKFmw17GTYG9
         BRYb9NMzUi9nF3bW1Txo3tdwvvplu11V4lm4kPKp4VvO9fZVfOLw7pyG4Gg5h4NOTb3I
         smpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAHnND6bDK2oZQJf5VQQH8A7hAEVL5pBw/UAWDyn6/Y=;
        b=G7JljJHdWO1sn+K9IrF6/n9B+Z7u5igeoeaDNOb3s2nY5qUBWggTvLuin1Ge2CtHMt
         5hBYVFZ73cYDiOsHiMAICYLoc2gx//qxrkmXLCTlwucID2VGSWJURqqx9chdKdjlKVM+
         BfCfavasjnQD+MSTzOFbxjKqEDPbzjX6Tuep/NT+FLvBr6qsS1FBkBf56ZsPtHwBvPaX
         5xkieD+Xu7b+HDrbvHLhMIvauAjpWp2F0UWFrVmD+406vm4vOq1VJpWGysMekSWCrCmf
         UVdrVcJc/Xkb3JKOTqp6eOXLEtDLiS597O/ALJrEbgBfvARbBLznMytiKasdZau9tEqw
         mqbQ==
X-Gm-Message-State: AOAM5330djoHoO2ZKliNeu7VJ69OP/z7By84lp/oZjoQumM0Z4WOFs9n
        OBjlJe/5TeASTBeCCo62ixs=
X-Google-Smtp-Source: ABdhPJybisjALzRIDT4EtJ85S/hVvU03aiH0eqDv2eLtMhCZTDeSIDP7lZV+jaFE27motpLWYL7xbw==
X-Received: by 2002:a17:903:181:b0:167:97e3:f67e with SMTP id z1-20020a170903018100b0016797e3f67emr21249272plg.151.1654915484806;
        Fri, 10 Jun 2022 19:44:44 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:80c:ca60:6957:cd88:1852:9438])
        by smtp.gmail.com with ESMTPSA id l13-20020a62be0d000000b0051ba90d55acsm257077pff.207.2022.06.10.19.44.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 19:44:44 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>, chiyutianyi@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        neerajsi@microsoft.com, newren@gmail.com, philipoakley@iee.email,
        stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v15 2/6] object-file.c: refactor write_loose_object() to several steps
Date:   Sat, 11 Jun 2022 10:44:17 +0800
Message-Id: <a1e090d338ed9761336d78104bd7df71953138b4.1654914555.git.chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654914555.git.chiyutianyi@gmail.com>
References: <cover.1654871915.git.chiyutianyi@gmail.com> <cover.1654914555.git.chiyutianyi@gmail.com>
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
version function ("stream_loose_object()") in later commit to resolve
this issue.

Before introducing that streaming function, do some refactoring on
"write_loose_object()" to reuse code for both versions.

Rewrite "write_loose_object()" as follows:

 1. Figure out a path for the (temp) object file. This step is only
    used in "write_loose_object()".

 2. Move common steps for starting to write loose objects into a new
    function "start_loose_object_common()".

 3. Compress data.

 4. Move common steps for ending zlib stream into a new function
    "end_loose_object_common()".

 5. Close fd and finalize the object file.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <chiyutianyi@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 98 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 24 deletions(-)

diff --git a/object-file.c b/object-file.c
index 79eb8339b6..b5bce03274 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1951,6 +1951,74 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	return fd;
 }
 
+/**
+ * Common steps for loose object writers to start writing loose
+ * objects:
+ *
+ * - Create tmpfile for the loose object.
+ * - Setup zlib stream for compression.
+ * - Start to feed header to zlib stream.
+ *
+ * Returns a "fd", which should later be provided to
+ * end_loose_object_common().
+ */
+static int start_loose_object_common(struct strbuf *tmp_file,
+				     const char *filename, unsigned flags,
+				     git_zstream *stream,
+				     unsigned char *buf, size_t buflen,
+				     git_hash_ctx *c,
+				     char *hdr, int hdrlen)
+{
+	int fd;
+
+	fd = create_tmpfile(tmp_file, filename);
+	if (fd < 0) {
+		if (flags & HASH_SILENT)
+			return -1;
+		else if (errno == EACCES)
+			return error(_("insufficient permission for adding "
+				       "an object to repository database %s"),
+				     get_object_directory());
+		else
+			return error_errno(
+				_("unable to create temporary file"));
+	}
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
+/**
+ * Common steps for loose object writers to end writing loose objects:
+ *
+ * - End the compression of zlib stream.
+ * - Get the calculated oid to "oid".
+ */
+static int end_loose_object_common(git_hash_ctx *c, git_zstream *stream,
+				   struct object_id *oid)
+{
+	int ret;
+
+	ret = git_deflate_end_gently(stream);
+	if (ret != Z_OK)
+		return ret;
+	the_hash_algo->final_oid_fn(oid, c);
+
+	return Z_OK;
+}
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime, unsigned flags)
@@ -1968,28 +2036,11 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
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
+	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
+				       &stream, compressed, sizeof(compressed),
+				       &c, hdr, hdrlen);
+	if (fd < 0)
+		return -1;
 
 	/* Then the data itself.. */
 	stream.next_in = (void *)buf;
@@ -2007,11 +2058,10 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	if (ret != Z_STREAM_END)
 		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
 		    ret);
-	ret = git_deflate_end_gently(&stream);
+	ret = end_loose_object_common(&c, &stream, &parano_oid);
 	if (ret != Z_OK)
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
-	the_hash_algo->final_oid_fn(&parano_oid, &c);
 	if (!oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
-- 
2.36.1

