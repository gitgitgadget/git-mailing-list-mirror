Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB5DC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 11:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhLULyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 06:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLULyR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 06:54:17 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F22CC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:54:17 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p18so10539887pld.13
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=deu0QkVId9Ic4Y9s1VwTx/5DQg59AFVjWrAeGt7KDIM=;
        b=AVhx1zdmBEu+V+/qjHkYx8MmBXxMErPZnU2D9XlkyBn8eJEgkcFn81jU0NAjaLXSZ0
         h9VgepyAA6vOEdOvxCxDVoVA+kxRo4XZlOULcrSOFBBQneDpjb3QjpT+1ceVj1MTMfDQ
         sYaJ/dCgLAoJQCyj/kN9YgkNisTetNRGynARFfnikxbs2MPPECvikuD7zrAriZ+H+zOC
         greyXybFDhbAZA53LhJ3pfwkv7rb+WpP6XNKl6COG0pOeRDQJDCdfNpdDfLM8VGMix76
         hHVpqfZfer0ESfHQ4tj0aGfPh9JFi5abhrg1ty29H4NCTU8Q3F9bINMcc9gFzJ6OMYqy
         Yxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=deu0QkVId9Ic4Y9s1VwTx/5DQg59AFVjWrAeGt7KDIM=;
        b=uf92/iiKE9T9lNMhO6e6V41gYROF1G/tYQjmW/DHF0nibgmdPTsCWL0UIJoxIuvNax
         unIYaGcgeEkTQtGRu+FHRfcnSYyToPIvPjWnnm6UIeyASx5BEunrihnx0l4/AnvlQQxx
         Wp8T1RkMSAhwu7Ucqpa585+AUgm5/wyy//PxYg8VDXrhadwDIECEYsAjsN87M8L+LFgM
         4jCHTnPgNH1gSC5GFx8dpFYlkgmH5AhEHdf+LFoCH1ozwooSBW2wAYzBoZvhpTYkgHVF
         scnHFMqvPN8NshJjQza+wm5vj5ceoku8eOvwhnjW7sMocFS+wImT5uofpZMzDWJyVeVn
         Rmqg==
X-Gm-Message-State: AOAM5334iQ5PC+GOQcmHgm9Wzb7dnoJoqQ57H22OtGjlodOGSjWqNJAy
        l7yeIPrRFULd/6G8Ry892WM=
X-Google-Smtp-Source: ABdhPJzwS6pFGsZwvMxx785vrHyG6QCnETOSSTLfUsUcCh7Xh11g4ElJu9/KbaQGZv+qCYWiQJVVuQ==
X-Received: by 2002:a17:90a:c788:: with SMTP id gn8mr3698532pjb.212.1640087656665;
        Tue, 21 Dec 2021 03:54:16 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id s30sm20513742pfw.57.2021.12.21.03.54.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Dec 2021 03:54:16 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v7 0/5] unpack large blobs in stream
Date:   Tue, 21 Dec 2021 19:51:56 +0800
Message-Id: <20211221115201.12120-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.g80008efde6.agit.6.5.6
In-Reply-To: <20211217112629.12334-1-chiyutianyi@gmail.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

Changes since v6:
* Remove "object-file.c: release strbuf in write_loose_object()" which is not
  needed anymore. Thanks to René Scharfe[1] for reporting this.

* Reorder the patch series and put "unpack-objects.c: add dry_run mode for get_data()"
  and its testcases to the front.

* Replace "refactor object header generation into a function" with
  "object-file API: add a format_object_header() function" sugguested by
  Ævar Arnfjörð Bjarmason[2].

* Export "write_stream_object_file()" instead of "reusing write_object_file_flags()"
  sugguested by René Scharfe[3]. The new flag "HASH_STREAM" has been removed.

* Fix the directory creation error and the "strbuf dir" leak in
  "write_stream_object_file()".

* Change "unsigned long size" to "size_t size" in "write_stream_blob()" and
  "get_data()" in "unpack-objects.c".

1. https://lore.kernel.org/git/c860c56f-ce25-4391-7f65-50c9d5d80c2c@web.de/
2. https://lore.kernel.org/git/RFC-patch-1.1-bda62567f6b-20211220T120740Z-avarab@gmail.com/
3. https://lore.kernel.org/git/e959e4f1-7500-5f6b-5bd2-2f060287eeff@web.de/

Han Xin (4):
  unpack-objects.c: add dry_run mode for get_data()
  object-file.c: refactor write_loose_object() to reuse in stream
    version
  object-file.c: add "write_stream_object_file()" to support read in
    stream
  unpack-objects: unpack_non_delta_entry() read data in a stream

Ævar Arnfjörð Bjarmason (1):
  object-file API: add a format_object_header() function

 Documentation/config/core.txt       |  11 ++
 builtin/index-pack.c                |   3 +-
 builtin/unpack-objects.c            |  94 ++++++++++++-
 bulk-checkin.c                      |   4 +-
 cache.h                             |  22 +++
 config.c                            |   5 +
 environment.c                       |   1 +
 http-push.c                         |   2 +-
 object-file.c                       | 199 ++++++++++++++++++++++------
 object-store.h                      |   9 ++
 t/t5590-unpack-non-delta-objects.sh |  91 +++++++++++++
 11 files changed, 392 insertions(+), 49 deletions(-)
 create mode 100755 t/t5590-unpack-non-delta-objects.sh

Range-diff against v6:
1:  59d35dac5f < -:  ---------- object-file.c: release strbuf in write_loose_object()
2:  2174a6cbad < -:  ---------- object-file.c: refactor object header generation into a function
5:  1acbb6e849 ! 1:  a8f232f553 unpack-objects.c: add dry_run mode for get_data()
    @@ builtin/unpack-objects.c: static void use(int bytes)
      }
      
     -static void *get_data(unsigned long size)
    -+static void *get_data(unsigned long size, int dry_run)
    ++static void *get_data(size_t size, int dry_run)
      {
      	git_zstream stream;
     -	void *buf = xmallocz(size);
    -+	unsigned long bufsize;
    ++	size_t bufsize;
     +	void *buf;
      
      	memset(&stream, 0, sizeof(stream));
    @@ builtin/unpack-objects.c: static void unpack_delta_entry(enum object_type type,
      		if (dry_run || !delta_data) {
      			free(delta_data);
      			return;
    +
    + ## t/t5590-unpack-non-delta-objects.sh (new) ##
    +@@
    ++#!/bin/sh
    ++#
    ++# Copyright (c) 2021 Han Xin
    ++#
    ++
    ++test_description='Test unpack-objects with non-delta objects'
    ++
    ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    ++export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    ++
    ++. ./test-lib.sh
    ++
    ++prepare_dest () {
    ++	test_when_finished "rm -rf dest.git" &&
    ++	git init --bare dest.git
    ++}
    ++
    ++test_expect_success "setup repo with big blobs (1.5 MB)" '
    ++	test-tool genrandom foo 1500000 >big-blob &&
    ++	test_commit --append foo big-blob &&
    ++	test-tool genrandom bar 1500000 >big-blob &&
    ++	test_commit --append bar big-blob &&
    ++	(
    ++		cd .git &&
    ++		find objects/?? -type f | sort
    ++	) >expect &&
    ++	PACK=$(echo main | git pack-objects --revs test)
    ++'
    ++
    ++test_expect_success 'setup env: GIT_ALLOC_LIMIT to 1MB' '
    ++	GIT_ALLOC_LIMIT=1m &&
    ++	export GIT_ALLOC_LIMIT
    ++'
    ++
    ++test_expect_success 'fail to unpack-objects: cannot allocate' '
    ++	prepare_dest &&
    ++	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
    ++	grep "fatal: attempting to allocate" err &&
    ++	(
    ++		cd dest.git &&
    ++		find objects/?? -type f | sort
    ++	) >actual &&
    ++	test_file_not_empty actual &&
    ++	! test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'unpack-objects dry-run' '
    ++	prepare_dest &&
    ++	git -C dest.git unpack-objects -n <test-$PACK.pack &&
    ++	(
    ++		cd dest.git &&
    ++		find objects/ -type f
    ++	) >actual &&
    ++	test_must_be_empty actual
    ++'
    ++
    ++test_done
-:  ---------- > 2:  0d2e0f3a00 object-file API: add a format_object_header() function
3:  8a704ecc59 ! 3:  a571b8f16c object-file.c: refactor write_loose_object() to reuse in stream version
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
      	loose_object_path(the_repository, &filename, oid);
      
     -	fd = create_tmpfile(&tmp_file, filename.buf);
    -+	fd = create_tmpfile(&tmp_file, filename.buf, flags);
    - 	if (fd < 0) {
    +-	if (fd < 0) {
     -		if (flags & HASH_SILENT)
    --			ret = -1;
    +-			return -1;
     -		else if (errno == EACCES)
    --			ret = error(_("insufficient permission for adding an "
    --				      "object to repository database %s"),
    --				    get_object_directory());
    +-			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
     -		else
    --			ret = error_errno(_("unable to create temporary file"));
    -+		ret = -1;
    - 		goto cleanup;
    - 	}
    - 
    +-			return error_errno(_("unable to create temporary file"));
    +-	}
    +-
     -	/* Set it up */
     -	git_deflate_init(&stream, zlib_compression_level);
     -	stream.next_out = compressed;
     -	stream.avail_out = sizeof(compressed);
     -	the_hash_algo->init_fn(&c);
    --
    ++	fd = create_tmpfile(&tmp_file, filename.buf, flags);
    ++	if (fd < 0)
    ++		return -1;
    + 
     -	/* First header.. */
     -	stream.next_in = (unsigned char *)hdr;
     -	stream.avail_in = hdrlen;
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
     -			warning_errno(_("failed utime() on %s"), tmp_file.buf);
     -	}
     -
    --	ret = finalize_object_file(tmp_file.buf, filename.buf);
    -+	ret = finalize_object_file_with_mtime(tmp_file.buf, filename.buf, mtime, flags);
    - cleanup:
    - 	strbuf_release(&filename);
    - 	strbuf_release(&tmp_file);
    +-	return finalize_object_file(tmp_file.buf, filename.buf);
    ++	return finalize_object_file_with_mtime(tmp_file.buf, filename.buf,
    ++					       mtime, flags);
    + }
    + 
    + static int freshen_loose_object(const struct object_id *oid)
4:  96f05632a2 ! 4:  1de06a8f5c object-file.c: make "write_object_file_flags()" to support read in stream
    @@ Metadata
     Author: Han Xin <hanxin.hx@alibaba-inc.com>
     
      ## Commit message ##
    -    object-file.c: make "write_object_file_flags()" to support read in stream
    +    object-file.c: add "write_stream_object_file()" to support read in stream
     
         We used to call "get_data()" in "unpack_non_delta_entry()" to read the
         entire contents of a blob object, no matter how big it is. This
         implementation may consume all the memory and cause OOM.
     
    -    This can be improved by feeding data to "stream_loose_object()" in a
    -    stream. The input stream is implemented as an interface.
    -
    -    When streaming a large blob object to "write_loose_object()", we have no
    -    chance to run "write_object_file_prepare()" to calculate the oid in
    -    advance. So we need to handle undetermined oid in a new function called
    -    "stream_loose_object()".
    +    This can be improved by feeding data to "write_stream_object_file()"
    +    in a stream. The input stream is implemented as an interface.
     
    +    The difference with "write_loose_object()" is that we have no chance
    +    to run "write_object_file_prepare()" to calculate the oid in advance.
         In "write_loose_object()", we know the oid and we can write the
         temporary file in the same directory as the final object, but for an
         object with an undetermined oid, we don't know the exact directory for
         the object, so we have to save the temporary file in ".git/objects/"
         directory instead.
     
    -    We will reuse "write_object_file_flags()" in "unpack_non_delta_entry()" to
    -    read the entire data contents in stream, so a new flag "HASH_STREAM" is
    -    added. When read in stream, we needn't prepare the "oid" before
    -    "write_loose_object()", only generate the header.
         "freshen_packed_object()" or "freshen_loose_object()" will be called
    -    inside "stream_loose_object()" after obtaining the "oid".
    +    inside "write_stream_object_file()" after obtaining the "oid".
     
    +    Helped-by: René Scharfe <l.s.r@web.de>
         Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
     
    - ## cache.h ##
    -@@ cache.h: int ie_modified(struct index_state *, const struct cache_entry *, struct stat *,
    - #define HASH_FORMAT_CHECK 2
    - #define HASH_RENORMALIZE  4
    - #define HASH_SILENT 8
    -+#define HASH_STREAM 16
    - int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
    - int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
    - 
    -
      ## object-file.c ##
     @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
      	return 1;
      }
      
    -+static int stream_loose_object(struct object_id *oid, char *hdr, int hdrlen,
    -+			       const struct input_stream *in_stream,
    -+			       unsigned long len, time_t mtime, unsigned flags)
    ++int write_stream_object_file(struct input_stream *in_stream, size_t len,
    ++			     enum object_type type, time_t mtime,
    ++			     unsigned flags, struct object_id *oid)
     +{
    -+	int fd, ret, err = 0, flush = 0;
    ++	int fd, ret, flush = 0;
     +	unsigned char compressed[4096];
     +	git_zstream stream;
     +	git_hash_ctx c;
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +	static struct strbuf tmp_file = STRBUF_INIT;
     +	static struct strbuf filename = STRBUF_INIT;
     +	int dirlen;
    ++	char hdr[MAX_HEADER_LEN];
    ++	int hdrlen = sizeof(hdr);
     +
    ++	/* Since "filename" is defined as static, it will be reused. So reset it
    ++	 * first before using it. */
    ++	strbuf_reset(&filename);
     +	/* When oid is not determined, save tmp file to odb path. */
     +	strbuf_addf(&filename, "%s/", get_object_directory());
     +
     +	fd = create_tmpfile(&tmp_file, filename.buf, flags);
    -+	if (fd < 0) {
    -+		err = -1;
    -+		goto cleanup;
    -+	}
    ++	if (fd < 0)
    ++		return -1;
    ++
    ++	hdrlen = format_object_header(hdr, hdrlen, type, len);
     +
     +	/* Set it up and write header */
     +	setup_stream_and_header(&stream, compressed, sizeof(compressed),
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +
     +	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
     +		unlink_or_warn(tmp_file.buf);
    -+		goto cleanup;
    ++		return 0;
     +	}
     +
     +	loose_object_path(the_repository, &filename, oid);
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +		struct strbuf dir = STRBUF_INIT;
     +		strbuf_add(&dir, filename.buf, dirlen - 1);
     +
    -+		if (mkdir_in_gitdir(dir.buf) < 0) {
    -+			err = -1;
    -+			goto cleanup;
    ++		if (mkdir_in_gitdir(dir.buf) && errno != EEXIST) {
    ++			ret = error_errno(_("unable to create directory %s"), dir.buf);
    ++			strbuf_release(&dir);
    ++			return ret;
     +		}
    ++		strbuf_release(&dir);
     +	}
     +
    -+	err = finalize_object_file_with_mtime(tmp_file.buf, filename.buf, mtime, flags);
    -+cleanup:
    -+	strbuf_release(&tmp_file);
    -+	strbuf_release(&filename);
    -+	return err;
    ++	return finalize_object_file_with_mtime(tmp_file.buf, filename.buf, mtime, flags);
     +}
     +
      int write_object_file_flags(const void *buf, unsigned long len,
      			    const char *type, struct object_id *oid,
      			    unsigned flags)
    -@@ object-file.c: int write_object_file_flags(const void *buf, unsigned long len,
    - 	char hdr[MAX_HEADER_LEN];
    - 	int hdrlen = sizeof(hdr);
    - 
    -+	/* When streaming a large blob object (marked as HASH_STREAM),
    -+	 * we have no chance to run "write_object_file_prepare()" to
    -+	 * calculate the "oid" in advance.  Call "stream_loose_object()"
    -+	 * to write loose object in stream.
    -+	 */
    -+	if (flags & HASH_STREAM) {
    -+		hdrlen = generate_object_header(hdr, hdrlen, type, len);
    -+		return stream_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
    -+	}
    -+
    - 	/* Normally if we have it in the pack then we do not bother writing
    - 	 * it out into .git/objects/??/?{38} file.
    - 	 */
     
      ## object-store.h ##
     @@ object-store.h: struct object_directory {
    @@ object-store.h: struct object_directory {
      };
      
     +struct input_stream {
    -+	const void *(*read)(const struct input_stream *, unsigned long *len);
    ++	const void *(*read)(struct input_stream *, unsigned long *len);
     +	void *data;
     +};
     +
      KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
      	struct object_directory *, 1, fspathhash, fspatheq)
      
    +@@ object-store.h: static inline int write_object_file(const void *buf, unsigned long len,
    + 	return write_object_file_flags(buf, len, type, oid, 0);
    + }
    + 
    ++int write_stream_object_file(struct input_stream *in_stream, size_t len,
    ++			     enum object_type type, time_t mtime,
    ++			     unsigned flags, struct object_id *oid);
    ++
    + int hash_object_file_literally(const void *buf, unsigned long len,
    + 			       const char *type, struct object_id *oid,
    + 			       unsigned flags);
6:  476aaba527 ! 5:  e7b4e426ef unpack-objects: unpack_non_delta_entry() read data in a stream
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	int status;
     +};
     +
    -+static const void *feed_input_zstream(const struct input_stream *in_stream,
    ++static const void *feed_input_zstream(struct input_stream *in_stream,
     +				      unsigned long *readlen)
     +{
     +	struct input_zstream_data *data = in_stream->data;
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	return data->buf;
     +}
     +
    -+static void write_stream_blob(unsigned nr, unsigned long size)
    ++static void write_stream_blob(unsigned nr, size_t size)
     +{
     +	git_zstream zstream;
     +	struct input_zstream_data data;
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	data.zstream = &zstream;
     +	git_inflate_init(&zstream);
     +
    -+	if (write_object_file_flags(&in_stream, size,
    -+				    type_name(OBJ_BLOB),
    -+				    &obj_list[nr].oid,
    -+				    HASH_STREAM))
    ++	if (write_stream_object_file(&in_stream, size, OBJ_BLOB, 0, 0,
    ++				     &obj_list[nr].oid))
     +		die(_("failed to write object in stream"));
     +
     +	if (zstream.total_out != size || data.status != Z_STREAM_END)
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	git_inflate_end(&zstream);
     +
     +	if (strict) {
    -+		struct blob *blob = lookup_blob(the_repository, &obj_list[nr].oid);
    ++		struct blob *blob =
    ++			lookup_blob(the_repository, &obj_list[nr].oid);
     +		if (blob)
     +			blob->object.flags |= FLAG_WRITTEN;
     +		else
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	void *buf;
     +
     +	/* Write large blob in stream without allocating full buffer. */
    -+	if (!dry_run && type == OBJ_BLOB && size > big_file_streaming_threshold) {
    ++	if (!dry_run && type == OBJ_BLOB &&
    ++	    size > big_file_streaming_threshold) {
     +		write_stream_blob(nr, size);
     +		return;
     +	}
    @@ environment.c: size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
      const char *editor_program;
      const char *askpass_program;
     
    - ## t/t5590-unpack-non-delta-objects.sh (new) ##
    -@@
    -+#!/bin/sh
    -+#
    -+# Copyright (c) 2021 Han Xin
    -+#
    -+
    -+test_description='Test unpack-objects when receive pack'
    -+
    -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    -+
    -+. ./test-lib.sh
    -+
    -+prepare_dest () {
    -+	test_when_finished "rm -rf dest.git" &&
    -+	git init --bare dest.git &&
    -+	git -C dest.git config core.bigFileStreamingThreshold $1 &&
    -+	git -C dest.git config core.bigFileThreshold $1
    -+}
    -+
    -+test_expect_success "setup repo with big blobs (1.5 MB)" '
    -+	test-tool genrandom foo 1500000 >big-blob &&
    -+	test_commit --append foo big-blob &&
    -+	test-tool genrandom bar 1500000 >big-blob &&
    -+	test_commit --append bar big-blob &&
    -+	(
    -+		cd .git &&
    -+		find objects/?? -type f | sort
    -+	) >expect &&
    -+	PACK=$(echo main | git pack-objects --revs test)
    -+'
    -+
    -+test_expect_success 'setup env: GIT_ALLOC_LIMIT to 1MB' '
    -+	GIT_ALLOC_LIMIT=1m &&
    -+	export GIT_ALLOC_LIMIT
    -+'
    -+
    -+test_expect_success 'fail to unpack-objects: cannot allocate' '
    + ## t/t5590-unpack-non-delta-objects.sh ##
    +@@ t/t5590-unpack-non-delta-objects.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + prepare_dest () {
    + 	test_when_finished "rm -rf dest.git" &&
    + 	git init --bare dest.git
    ++	if test -n "$1"
    ++	then
    ++		git -C dest.git config core.bigFileStreamingThreshold $1
    ++		git -C dest.git config core.bigFileThreshold $1
    ++	fi
    + }
    + 
    + test_expect_success "setup repo with big blobs (1.5 MB)" '
    +@@ t/t5590-unpack-non-delta-objects.sh: test_expect_success 'setup env: GIT_ALLOC_LIMIT to 1MB' '
    + '
    + 
    + test_expect_success 'fail to unpack-objects: cannot allocate' '
    +-	prepare_dest &&
     +	prepare_dest 2m &&
    -+	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
    -+	grep "fatal: attempting to allocate" err &&
    -+	(
    -+		cd dest.git &&
    -+		find objects/?? -type f | sort
    -+	) >actual &&
    -+	test_file_not_empty actual &&
    -+	! test_cmp expect actual
    -+'
    -+
    + 	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
    + 	grep "fatal: attempting to allocate" err &&
    + 	(
    +@@ t/t5590-unpack-non-delta-objects.sh: test_expect_success 'fail to unpack-objects: cannot allocate' '
    + 	! test_cmp expect actual
    + '
    + 
     +test_expect_success 'unpack big object in stream' '
     +	prepare_dest 1m &&
    ++	mkdir -p dest.git/objects/05 &&
     +	git -C dest.git unpack-objects <test-$PACK.pack &&
     +	git -C dest.git fsck &&
     +	(
    @@ t/t5590-unpack-non-delta-objects.sh (new)
     +	test_must_be_empty actual
     +'
     +
    -+test_expect_success 'unpack-objects dry-run' '
    -+	prepare_dest 1m &&
    -+	git -C dest.git unpack-objects -n <test-$PACK.pack &&
    -+	(
    -+		cd dest.git &&
    -+		find objects/ -type f
    -+	) >actual &&
    -+	test_must_be_empty actual
    -+'
    -+
    -+test_done
    + test_expect_success 'unpack-objects dry-run' '
    + 	prepare_dest &&
    + 	git -C dest.git unpack-objects -n <test-$PACK.pack &&
-- 
2.34.1.52.g80008efde6.agit.6.5.6

