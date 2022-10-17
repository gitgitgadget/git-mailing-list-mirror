Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AFCC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 02:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJQCXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJQCXc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 22:23:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C46444B3
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso11748491wma.1
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u8xPLS2v7BwRZyTpchM0gF0aTO+EpZNRYLutPsguao=;
        b=obH6Xe1H9mWa5ji2pfINit/0k6b0bivaGM0WVb5ehMWmT9dwoelo3303iu3C7i4QJ0
         4kIGu0e7RQdPZm/x+McqcrPopNMBb1miD6HIAxPPX5PgQcjl9GnW2qGKoMMr/8xWZQUU
         tkhw8pVCyhe0wgoNbaSD2WUghU0MIEB75dLaV49gqFUL7unjiK9oIGbiutoyDCy5/Si0
         2+7etIquLu+4nsu4nXI2pU9IdAkMo8W4+MHOuhLV5pz+6Qcf4B0pe25WTiScl2OgpCUY
         fvG67cFcUY9/kelYowZrUarxTTW3Lut905mVDJY2DAYQzWkI1t++M8gAhlxAtTCOjTrH
         dYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5u8xPLS2v7BwRZyTpchM0gF0aTO+EpZNRYLutPsguao=;
        b=Dux4pZ3G1fhF8/Trdkqop3oP2E7qsWL5klA+7eCRYjBK5aUzczl9PuDS8RMHFPghpz
         qmGtGgD9Z/VMyWtdstbdX2sgNjd+Ii+KTSRhMn+08vwUdRT7t0VPw6IwFgDC0A9313yk
         l2oIjOa8y2THSHjL02jg3cR1GzaEg45EZ/k1hw2OSMbdFYn3xQnqeq5GXCo/Uo6xMzXy
         SURdHLKPTngyHpPIzWUOcsXBE4Yy0C5/a76wsMMw2Px8GG4EUtY8b3/ymp3gObqhMGie
         olgVpiyuVZQOSSVFhmCDL7Np4nBGN8IcytZtTls1cVMY9AVAIFyAGAE5zOjK/OuxdQIV
         iNYw==
X-Gm-Message-State: ACrzQf1OPKd/fGiLyjvVYb3vLOC2t2n7RX4RD45lI3w1cPbork9bJrNT
        +HlVYh/O89YIuYxlENKRohIo4WFtAzY=
X-Google-Smtp-Source: AMsMyM70xOH5857xeMqAbYKqp9U/vTGJdpyEH0/hdGnDSxRZvdh0zdh0iHC2lfDxV43jbe95t4MFXw==
X-Received: by 2002:a05:600c:4410:b0:3c6:f04b:daa2 with SMTP id u16-20020a05600c441000b003c6f04bdaa2mr5760970wmn.186.1665973408865;
        Sun, 16 Oct 2022 19:23:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c35d000b003a84375d0d1sm14940183wmq.44.2022.10.16.19.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 19:23:28 -0700 (PDT)
Message-Id: <1b9b049d64fc4ea919c94e57b74a1760b3837892.1665973401.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
From:   "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 02:23:18 +0000
Subject: [PATCH v3 6/9] archive: pass repo objects to write_archive handlers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heather Lapointe <alpha@alphaservcomputing.solutions>

Use contextual repos instead of the_repository or args->repo
to ensure that submodules will be handled correctly
since they use multiple repo instances.

Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
---
 archive-tar.c | 15 ++++++++++-----
 archive-zip.c | 15 +++++++++------
 archive.c     | 38 ++++++++++++++++++++++----------------
 archive.h     | 14 +++++++++++---
 4 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 3e4822b6840..5a2d42ff229 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -18,6 +18,7 @@ static unsigned long offset;
 static int tar_umask = 002;
 
 static int write_tar_filter_archive(const struct archiver *ar,
+					struct repository *repo,
 				    struct archiver_args *args);
 
 /*
@@ -246,7 +247,9 @@ static void write_extended_header(struct archiver_args *args,
 	write_blocked(buffer, size);
 }
 
-static int write_tar_entry(struct archiver_args *args,
+static int write_tar_entry(
+			   struct repository *repo,
+			   struct archiver_args *args,
 			   const struct object_id *oid,
 			   const char *path, size_t pathlen,
 			   unsigned int mode,
@@ -316,7 +319,7 @@ static int write_tar_entry(struct archiver_args *args,
 		if (buffer)
 			write_blocked(buffer, size);
 		else
-			err = stream_blocked(args->repo, oid);
+			err = stream_blocked(repo, oid);
 	}
 	return err;
 }
@@ -422,12 +425,13 @@ static int git_tar_config(const char *var, const char *value, void *cb)
 }
 
 static int write_tar_archive(const struct archiver *ar UNUSED,
+			     struct repository *repo,
 			     struct archiver_args *args)
 {
 	int err = 0;
 
 	write_global_extended_header(args);
-	err = write_archive_entries(args, write_tar_entry);
+	err = write_archive_entries(repo, args, write_tar_entry);
 	if (!err)
 		write_trailer();
 	return err;
@@ -462,6 +466,7 @@ static void tgz_write_block(const void *data)
 static const char internal_gzip_command[] = "git archive gzip";
 
 static int write_tar_filter_archive(const struct archiver *ar,
+					struct repository *repo,
 				    struct archiver_args *args)
 {
 #if ZLIB_VERNUM >= 0x1221
@@ -484,7 +489,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 		gzstream.next_out = outbuf;
 		gzstream.avail_out = sizeof(outbuf);
 
-		r = write_tar_archive(ar, args);
+		r = write_tar_archive(ar, repo, args);
 
 		tgz_deflate(Z_FINISH);
 		git_deflate_end(&gzstream);
@@ -506,7 +511,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 		die_errno(_("unable to redirect descriptor"));
 	close(filter.in);
 
-	r = write_tar_archive(ar, args);
+	r = write_tar_archive(ar, repo, args);
 
 	close(1);
 	if (finish_command(&filter) != 0)
diff --git a/archive-zip.c b/archive-zip.c
index 0456f1ebf15..2c1f943a6cc 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -283,7 +283,9 @@ static int entry_is_binary(struct index_state *istate, const char *path,
 
 #define STREAM_BUFFER_SIZE (1024 * 16)
 
-static int write_zip_entry(struct archiver_args *args,
+static int write_zip_entry(
+			   struct repository *repo,
+			   struct archiver_args *args,
 			   const struct object_id *oid,
 			   const char *path, size_t pathlen,
 			   unsigned int mode,
@@ -340,7 +342,7 @@ static int write_zip_entry(struct archiver_args *args,
 
 		if (!buffer) {
 			enum object_type type;
-			stream = open_istream(args->repo, oid, &type, &size,
+			stream = open_istream(repo, oid, &type, &size,
 					      NULL);
 			if (!stream)
 				return error(_("cannot stream blob %s"),
@@ -349,7 +351,7 @@ static int write_zip_entry(struct archiver_args *args,
 			out = NULL;
 		} else {
 			crc = crc32(crc, buffer, size);
-			is_binary = entry_is_binary(args->repo->index,
+			is_binary = entry_is_binary(repo->index,
 						    path_without_prefix,
 						    buffer, size);
 			out = buffer;
@@ -426,7 +428,7 @@ static int write_zip_entry(struct archiver_args *args,
 				break;
 			crc = crc32(crc, buf, readlen);
 			if (is_binary == -1)
-				is_binary = entry_is_binary(args->repo->index,
+				is_binary = entry_is_binary(repo->index,
 							    path_without_prefix,
 							    buf, readlen);
 			write_or_die(1, buf, readlen);
@@ -459,7 +461,7 @@ static int write_zip_entry(struct archiver_args *args,
 				break;
 			crc = crc32(crc, buf, readlen);
 			if (is_binary == -1)
-				is_binary = entry_is_binary(args->repo->index,
+				is_binary = entry_is_binary(repo->index,
 							    path_without_prefix,
 							    buf, readlen);
 
@@ -619,6 +621,7 @@ static int archive_zip_config(const char *var, const char *value,
 }
 
 static int write_zip_archive(const struct archiver *ar UNUSED,
+				 struct repository *repo,
 			     struct archiver_args *args)
 {
 	int err;
@@ -629,7 +632,7 @@ static int write_zip_archive(const struct archiver *ar UNUSED,
 
 	strbuf_init(&zip_dir, 0);
 
-	err = write_archive_entries(args, write_zip_entry);
+	err = write_archive_entries(repo, args, write_zip_entry);
 	if (!err)
 		write_zip_trailer(args->commit_oid);
 
diff --git a/archive.c b/archive.c
index 15f3ac92dfc..2cca7bc5c8a 100644
--- a/archive.c
+++ b/archive.c
@@ -134,7 +134,9 @@ static int check_attr_export_subst(const struct attr_check *check)
 	return check && ATTR_TRUE(check->items[1].value);
 }
 
-static int write_archive_entry(const struct object_id *oid, const char *base,
+static int write_archive_entry(
+		struct repository *repo,
+		const struct object_id *oid, const char *base,
 		int baselen, const char *filename, unsigned mode,
 		void *context)
 {
@@ -160,7 +162,7 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 
 	if (!S_ISDIR(mode)) {
 		const struct attr_check *check;
-		check = get_archive_attrs(args->repo->index, path_without_prefix);
+		check = get_archive_attrs(repo->index, path_without_prefix);
 		if (check_attr_export_ignore(check))
 			return 0;
 		args->convert = check_attr_export_subst(check);
@@ -169,7 +171,7 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-		err = write_entry(args, oid, path.buf, path.len, mode, NULL, 0);
+		err = write_entry(repo, args, oid, path.buf, path.len, mode, NULL, 0);
 		if (err)
 			return err;
 		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
@@ -180,14 +182,14 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 
 	/* Stream it? */
 	if (S_ISREG(mode) && !args->convert &&
-	    oid_object_info(args->repo, oid, &size) == OBJ_BLOB &&
+	    oid_object_info(repo, oid, &size) == OBJ_BLOB &&
 	    size > big_file_threshold)
-		return write_entry(args, oid, path.buf, path.len, mode, NULL, size);
+		return write_entry(repo, args, oid, path.buf, path.len, mode, NULL, size);
 
 	buffer = object_file_to_archive(args, path.buf, oid, mode, &type, &size);
 	if (!buffer)
 		return error(_("cannot read '%s'"), oid_to_hex(oid));
-	err = write_entry(args, oid, path.buf, path.len, mode, buffer, size);
+	err = write_entry(repo, args, oid, path.buf, path.len, mode, buffer, size);
 	free(buffer);
 	return err;
 }
@@ -207,7 +209,9 @@ static void queue_directory(const struct object_id *oid,
 	oidcpy(&d->oid, oid);
 }
 
-static int write_directory(struct archiver_context *c)
+static int write_directory(
+		struct repository *repo,
+		struct archiver_context *c)
 {
 	struct directory *d = c->bottom;
 	int ret;
@@ -217,8 +221,8 @@ static int write_directory(struct archiver_context *c)
 	c->bottom = d->up;
 	d->path[d->len - 1] = '\0'; /* no trailing slash */
 	ret =
-		write_directory(c) ||
-		write_archive_entry(&d->oid, d->path, d->baselen,
+		write_directory(repo, c) ||
+		write_archive_entry(repo, &d->oid, d->path, d->baselen,
 				    d->path + d->baselen, d->mode,
 				    c) != READ_TREE_RECURSIVE;
 	free(d);
@@ -257,9 +261,9 @@ static int queue_or_write_archive_entry(
 		return READ_TREE_RECURSIVE;
 	}
 
-	if (write_directory(c))
+	if (write_directory(r, c))
 		return -1;
-	return write_archive_entry(oid, base->buf, base->len, filename, mode,
+	return write_archive_entry(r, oid, base->buf, base->len, filename, mode,
 				   context);
 }
 
@@ -269,7 +273,9 @@ struct extra_file_info {
 	void *content;
 };
 
-int write_archive_entries(struct archiver_args *args,
+int write_archive_entries(
+		struct repository *repo,
+		struct archiver_args *args,
 		write_archive_entry_fn_t write_entry)
 {
 	struct archiver_context context;
@@ -290,7 +296,7 @@ int write_archive_entries(struct archiver_args *args,
 			len--;
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)len, args->base);
-		err = write_entry(args, &args->tree->object.oid, args->base,
+		err = write_entry(repo, args, &args->tree->object.oid, args->base,
 				  len, 040777, NULL, 0);
 		if (err)
 			return err;
@@ -345,12 +351,12 @@ int write_archive_entries(struct archiver_args *args,
 			if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
 				err = error_errno(_("cannot read '%s'"), path);
 			else
-				err = write_entry(args, &fake_oid, path_in_archive.buf,
+				err = write_entry(repo, args, &fake_oid, path_in_archive.buf,
 						  path_in_archive.len,
 						  canon_mode(info->stat.st_mode),
 						  content.buf, content.len);
 		} else {
-			err = write_entry(args, &fake_oid,
+			err = write_entry(repo, args, &fake_oid,
 					  path, strlen(path),
 					  canon_mode(info->stat.st_mode),
 					  info->content, info->stat.st_size);
@@ -711,7 +717,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	parse_treeish_arg(argv, &args, prefix, remote);
 	parse_pathspec_arg(argv + 1, &args);
 
-	rc = ar->write_archive(ar, &args);
+	rc = ar->write_archive(ar, repo, &args);
 
 	string_list_clear_func(&args.extra_files, extra_file_info_clear);
 	free(args.refname);
diff --git a/archive.h b/archive.h
index 08bed3ed3af..bfbbd3274bd 100644
--- a/archive.h
+++ b/archive.h
@@ -41,7 +41,10 @@ const char *archive_format_from_filename(const char *filename);
 #define ARCHIVER_HIGH_COMPRESSION_LEVELS 4
 struct archiver {
 	const char *name;
-	int (*write_archive)(const struct archiver *, struct archiver_args *);
+	int (*write_archive)(
+		const struct archiver *,
+		struct repository *,
+		struct archiver_args *);
 	unsigned flags;
 	char *filter_command;
 };
@@ -51,12 +54,17 @@ void init_tar_archiver(void);
 void init_zip_archiver(void);
 void init_archivers(void);
 
-typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
+typedef int (*write_archive_entry_fn_t)(
+					struct repository *repo,
+					struct archiver_args *args,
 					const struct object_id *oid,
 					const char *path, size_t pathlen,
 					unsigned int mode,
 					void *buffer, unsigned long size);
 
-int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
+int write_archive_entries(
+	struct repository *repo,
+	struct archiver_args *args,
+	write_archive_entry_fn_t write_entry);
 
 #endif	/* ARCHIVE_H */
-- 
gitgitgadget

