Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13819C433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 08:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiAHI4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 03:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAHI4a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 03:56:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C35C061574
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 00:56:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so14779239pjj.2
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 00:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbQTcb7iiUKFzp4F618MOYyI8HpsjIR/VL4vbK+4lyM=;
        b=WSSBYvONVWUgM267a9hiC7IHv/cnyyAVX7A1wVhLnqajV2soz5mAV3+yzs/NNsCEOx
         U0ofpUF0samkoscbBzFQgqMebJOUSuRUQ2r3u2y440sUCk5OlELyhA9wBTKUSeoAKw75
         2ABu+pAAr7b1CJ1kVDK+TYJek2nggemvZtUr/bk7p93pkYc5uQHW7EOohO75YB3fk3QC
         FoCSNE/N95lHY8zq5FWk/bWi899T8gZGel43JIvkcMKYTfBj7ateOLWVi9Ov5beQ5314
         jZZrRYlgnzVej0bwqGxRuNqmiaSquEoRgws+nZYOKB/+6AnkbY81I0xZwS71zsK8Jgu7
         11+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbQTcb7iiUKFzp4F618MOYyI8HpsjIR/VL4vbK+4lyM=;
        b=LdVwRg59HkSaZWbpaCOZitKMV4SERylvCAsgFco+PQBJi6db/iTxNfqt78Lyj82lCA
         GLaXpPi4H/LnoLNKRakiH9kpsFQJKroBgbvxGMKytgfszBCmDOwIjKRlzil7WoH+t++6
         T9yKCiLXLuDLl4/UaQx3Y3lkx9712tLIAY3Ge/7wciBMeGCEOd5fe+2urWWMbyClXzCN
         EB9He4S7Xj1bb/86A1Bx0XB8nqfVONdm5tNM2fVVliaCBOk133hr8tQzNl5xQ7JdZc2B
         +l3x9xtWCbfSQkr3LCQvpYkVKx9eMpY5lbfL5is4OG/DLP464QRj5bosoPbCP1uoqDpV
         pYMQ==
X-Gm-Message-State: AOAM532PBzpf0UfaYNlCWhweFZ5ZKaoWuTMHVwI3OziEng3nm1epQc+O
        TLdiAxd4ebXRist/7/5w5RE=
X-Google-Smtp-Source: ABdhPJwpPiTsfshIUyUzvHpFBU0157NhffR7CCB4tuLlt8rYp4ILztPJJ83D5BbMfAb57G86R+PQ/Q==
X-Received: by 2002:a17:90b:14e:: with SMTP id em14mr17654891pjb.12.1641632189049;
        Sat, 08 Jan 2022 00:56:29 -0800 (PST)
Received: from localhost.localdomain ([58.100.34.57])
        by smtp.gmail.com with ESMTPSA id x25sm1240990pfu.113.2022.01.08.00.56.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jan 2022 00:56:28 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v8 0/6] unpack large blobs in stream
Date:   Sat,  8 Jan 2022 16:54:13 +0800
Message-Id: <20220108085419.79682-1-chiyutianyi@gmail.com>
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

Changes since v7:
* Use functions "assert_no_loose()" and "assert_no_pack()" to do tests instead
  of "find" sugguseted by Ævar Arnfjörð Bjarmason[1].

* "get_data()" now use the global "dry_run" and it will release the buf before
  returning.

* Add a new commit "object-file.c: remove the slash for directory_size()"
  sugguseted by Ævar Arnfjörð Bjarmason[2].

* Add "int is_finished" to "struct input_stream" who will tell us if there is 
  next buffer in the stream.

* Remove the config "core.bigFileStreamingThreshold" introduced in v5, and keep
  using "core.bigFileThreshold". Until now, the config variable has been used in
  the cases listed in "unpack-objects: unpack_non_delta_entry() read data in a
  stream", this new case belongs to the packfile category.

* Remove unnecessary explicit cast in "object-file API: add a 
  format_object_header() function" sugguseted by René Scharfe[3].

1. https://lore.kernel.org/git/211221.86bl1arqls.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/211221.8635mmrpps.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/b2dee243-1a38-531e-02b1-ffd66c465fa5@web.de/

Han Xin (5):
  unpack-objects: low memory footprint for get_data() in dry_run mode
  object-file.c: refactor write_loose_object() to several steps
  object-file.c: remove the slash for directory_size()
  object-file.c: add "stream_loose_object()" to handle large object
  unpack-objects: unpack_non_delta_entry() read data in a stream

Ævar Arnfjörð Bjarmason (1):
  object-file API: add a format_object_header() function

 builtin/index-pack.c            |   3 +-
 builtin/unpack-objects.c        | 110 +++++++++++--
 bulk-checkin.c                  |   4 +-
 cache.h                         |  21 +++
 http-push.c                     |   2 +-
 object-file.c                   | 272 ++++++++++++++++++++++++++------
 object-store.h                  |   9 ++
 t/t5329-unpack-large-objects.sh |  69 ++++++++
 8 files changed, 422 insertions(+), 68 deletions(-)
 create mode 100755 t/t5329-unpack-large-objects.sh

Range-diff against v7:
1:  a8f232f553 < -:  ---------- unpack-objects.c: add dry_run mode for get_data()
-:  ---------- > 1:  bd34da5816 unpack-objects: low memory footprint for get_data() in dry_run mode
3:  a571b8f16c ! 2:  f9a4365a7d object-file.c: refactor write_loose_object() to reuse in stream version
    @@ Metadata
     Author: Han Xin <hanxin.hx@alibaba-inc.com>
     
      ## Commit message ##
    -    object-file.c: refactor write_loose_object() to reuse in stream version
    +    object-file.c: refactor write_loose_object() to several steps
     
    -    We used to call "get_data()" in "unpack_non_delta_entry()" to read the
    -    entire contents of a blob object, no matter how big it is. This
    -    implementation may consume all the memory and cause OOM.
    +    When writing a large blob using "write_loose_object()", we have to pass
    +    a buffer with the whole content of the blob, and this behavior will
    +    consume lots of memory and may cause OOM. We will introduce a stream
    +    version function ("stream_loose_object()") in latter commit to resolve
    +    this issue.
     
    -    This can be improved by feeding data to "stream_loose_object()" in
    -    stream instead of read into the whole buf.
    +    Before introducing a stream vesion function for writing loose object,
    +    do some refactoring on "write_loose_object()" to reuse code for both
    +    versions.
     
    -    As this new method "stream_loose_object()" has many similarities with
    -    "write_loose_object()", we split up "write_loose_object()" into some
    -    steps:
    -     1. Figuring out a path for the (temp) object file.
    -     2. Creating the tempfile.
    -     3. Setting up zlib and write header.
    -     4. Write object data and handle errors.
    -     5. Optionally, do someting after write, maybe force a loose object if
    -    "mtime".
    +    Rewrite "write_loose_object()" as follows:
    +
    +     1. Figure out a path for the (temp) object file. This step is only
    +        used in "write_loose_object()".
    +
    +     2. Move common steps for starting to write loose objects into a new
    +        function "start_loose_object_common()".
    +
    +     3. Compress data.
    +
    +     4. Move common steps for ending zlib stream into a new funciton
    +        "end_loose_object_common()".
    +
    +     5. Close fd and finalize the object file.
     
         Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
     
      ## object-file.c ##
    @@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const char *filenam
      	return fd;
      }
      
    -+static void setup_stream_and_header(git_zstream *stream,
    -+				    unsigned char *compressed,
    -+				    unsigned long compressed_size,
    -+				    git_hash_ctx *c,
    -+				    char *hdr,
    -+				    int hdrlen)
    ++static int start_loose_object_common(struct strbuf *tmp_file,
    ++				     const char *filename, unsigned flags,
    ++				     git_zstream *stream,
    ++				     unsigned char *buf, size_t buflen,
    ++				     git_hash_ctx *c,
    ++				     enum object_type type, size_t len,
    ++				     char *hdr, int hdrlen)
     +{
    -+	/* Set it up */
    ++	int fd;
    ++
    ++	fd = create_tmpfile(tmp_file, filename, flags);
    ++	if (fd < 0)
    ++		return -1;
    ++
    ++	/*  Setup zlib stream for compression */
     +	git_deflate_init(stream, zlib_compression_level);
    -+	stream->next_out = compressed;
    -+	stream->avail_out = compressed_size;
    ++	stream->next_out = buf;
    ++	stream->avail_out = buflen;
     +	the_hash_algo->init_fn(c);
     +
    -+	/* First header.. */
    ++	/*  Start to feed header to zlib stream */
     +	stream->next_in = (unsigned char *)hdr;
     +	stream->avail_in = hdrlen;
     +	while (git_deflate(stream, 0) == Z_OK)
     +		; /* nothing */
     +	the_hash_algo->update_fn(c, hdr, hdrlen);
    ++
    ++	return fd;
    ++}
    ++
    ++static void end_loose_object_common(int ret, git_hash_ctx *c,
    ++				    git_zstream *stream,
    ++				    struct object_id *parano_oid,
    ++				    const struct object_id *expected_oid,
    ++				    const char *die_msg1_fmt,
    ++				    const char *die_msg2_fmt)
    ++{
    ++	if (ret != Z_STREAM_END)
    ++		die(_(die_msg1_fmt), ret, expected_oid);
    ++	ret = git_deflate_end_gently(stream);
    ++	if (ret != Z_OK)
    ++		die(_(die_msg2_fmt), ret, expected_oid);
    ++	the_hash_algo->final_oid_fn(parano_oid, c);
     +}
     +
      static int write_loose_object(const struct object_id *oid, char *hdr,
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
     -	stream.next_out = compressed;
     -	stream.avail_out = sizeof(compressed);
     -	the_hash_algo->init_fn(&c);
    -+	fd = create_tmpfile(&tmp_file, filename.buf, flags);
    -+	if (fd < 0)
    -+		return -1;
    - 
    +-
     -	/* First header.. */
     -	stream.next_in = (unsigned char *)hdr;
     -	stream.avail_in = hdrlen;
     -	while (git_deflate(&stream, 0) == Z_OK)
     -		; /* nothing */
     -	the_hash_algo->update_fn(&c, hdr, hdrlen);
    -+	/* Set it up and write header */
    -+	setup_stream_and_header(&stream, compressed, sizeof(compressed),
    -+				&c, hdr, hdrlen);
    ++	/* Common steps for write_loose_object and stream_loose_object to
    ++	 * start writing loose oject:
    ++	 *
    ++	 *  - Create tmpfile for the loose object.
    ++	 *  - Setup zlib stream for compression.
    ++	 *  - Start to feed header to zlib stream.
    ++	 */
    ++	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
    ++				       &stream, compressed, sizeof(compressed),
    ++				       &c, OBJ_NONE, 0, hdr, hdrlen);
    ++	if (fd < 0)
    ++		return -1;
      
      	/* Then the data itself.. */
      	stream.next_in = (void *)buf;
     @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *hdr,
    + 		stream.avail_out = sizeof(compressed);
    + 	} while (ret == Z_OK);
    + 
    +-	if (ret != Z_STREAM_END)
    +-		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
    +-		    ret);
    +-	ret = git_deflate_end_gently(&stream);
    +-	if (ret != Z_OK)
    +-		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
    +-		    ret);
    +-	the_hash_algo->final_oid_fn(&parano_oid, &c);
    ++	/* Common steps for write_loose_object and stream_loose_object to
    ++	 * end writing loose oject:
    ++	 *
    ++	 *  - End the compression of zlib stream.
    ++	 *  - Get the calculated oid to "parano_oid".
    ++	 */
    ++	end_loose_object_common(ret, &c, &stream, &parano_oid, oid,
    ++				N_("unable to deflate new object %s (%d)"),
    ++				N_("deflateEnd on object %s failed (%d)"));
    ++
    + 	if (!oideq(oid, &parano_oid))
    + 		die(_("confused by unstable object source data for %s"),
    + 		    oid_to_hex(oid));
      
      	close_loose_object(fd);
      
-:  ---------- > 3:  18dd21122d object-file.c: remove the slash for directory_size()
-:  ---------- > 4:  964715451b object-file.c: add "stream_loose_object()" to handle large object
-:  ---------- > 5:  3f620466fe unpack-objects: unpack_non_delta_entry() read data in a stream
2:  0d2e0f3a00 ! 6:  8073a3888d object-file API: add a format_object_header() function
    @@ builtin/index-pack.c: static void *unpack_entry_data(off_t offset, unsigned long
      	if (!is_delta_type(type)) {
     -		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX,
     -				   type_name(type),(uintmax_t)size) + 1;
    -+		hdrlen = format_object_header(hdr, sizeof(hdr), type, (uintmax_t)size);
    ++		hdrlen = format_object_header(hdr, sizeof(hdr), type, size);
      		the_hash_algo->init_fn(&c);
      		the_hash_algo->update_fn(&c, hdr, hdrlen);
      	} else
    @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
     -	header_len = xsnprintf((char *)obuf, sizeof(obuf), "%s %" PRIuMAX,
     -			       type_name(type), (uintmax_t)size) + 1;
     +	header_len = format_object_header((char *)obuf, sizeof(obuf),
    -+					 type, (uintmax_t)size);
    ++					 type, size);
      	the_hash_algo->init_fn(&ctx);
      	the_hash_algo->update_fn(&ctx, obuf, header_len);
      
    @@ http-push.c: static void start_put(struct transfer_request *request)
      
      	unpacked = read_object_file(&request->obj->oid, &type, &len);
     -	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
    -+	hdrlen = format_object_header(hdr, sizeof(hdr), type, (uintmax_t)len);
    ++	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
      
      	/* Set it up */
      	git_deflate_init(&stream, zlib_compression_level);
    @@ object-file.c: static void write_object_file_prepare(const struct git_hash_algo
      
      	/* Sha1.. */
      	algo->init_fn(&c);
    +@@ object-file.c: int stream_loose_object(struct input_stream *in_stream, size_t len,
    + 
    + 	/* Since oid is not determined, save tmp file to odb path. */
    + 	strbuf_addf(&filename, "%s/", get_object_directory());
    +-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(OBJ_BLOB), len) + 1;
    ++	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
    + 
    + 	/* Common steps for write_loose_object and stream_loose_object to
    + 	 * start writing loose oject:
     @@ object-file.c: int force_object_loose(const struct object_id *oid, time_t mtime)
      	buf = read_object(the_repository, oid, &type, &len);
      	if (!buf)
4:  1de06a8f5c < -:  ---------- object-file.c: add "write_stream_object_file()" to support read in stream
5:  e7b4e426ef < -:  ---------- unpack-objects: unpack_non_delta_entry() read data in a stream
-- 
2.34.1.52.gc288e771b4.agit.6.5.6

