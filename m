Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5AFC433FE
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 00:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbiCSAY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiCSAYz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 20:24:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4374F1275AF
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r10so13729467wrp.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzj4y6yv4m9Hbw1Uf1zEHUoKjuX46Y6d7XAvi/q4cMQ=;
        b=ngrM2vtc15ctb0cTYIx8+D7LIo3fnk9s1r3Yt1+aJnZMwIpKpSK4VST0A0gfX7Q31t
         0RVaDZ1T0CWyAwxnTTJQTMGeZ3uxzuq1DBeRGkj2vozWPOgqT5J1eVXIfYtuXZI4QSkP
         9T+nclBzGKeH+jBk/Hc/+f0p5wSsnG3hsAVIOnYhXV1sN28B/Ueyc1rIbZvdQa/WrcnY
         18qT38I9vfJF4w7LH72WM27mVAJXQnYEC4OaeXTsuiJe1BHvk5Y7OMZWvq2n6hViXK7F
         NzM0ppQm2CwhvXZmSfh7poRiB8BaE3XF9w48LsAolqu+xFQDkPkb+w/6QCde8jBf7leU
         AVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzj4y6yv4m9Hbw1Uf1zEHUoKjuX46Y6d7XAvi/q4cMQ=;
        b=W1MA7KU8rVc5ASyE0o+SP7xH0vPZ6hu0z4LyVjOZQc2++AVjVXnSg85RCBdOVCQCt7
         m3oy+6QGuskuHGC+AMelZMicbFiDIlnBKSU7HuF+4AZnQqiJu9BDSxRTEG9THufUWIoG
         81t/ri1K+0opXJgWSPAVcKWYjDEDBGjAolheje1pnZTJ2rxyl8oN6bCVEPs7bTYi0318
         Teco+uEU4ZtanF1rgX/N/CxJZsXJBxtLtw/boEkmH+LgVduuRRwWofoAWeQo9FSts8v1
         8FhzipS2QdYkuRlY4+XjXXas7xm1lhfRk/A69KK27OiDiQ5axUEJM3tH6eyRxFa99cMx
         eW3g==
X-Gm-Message-State: AOAM5327+zI564wUgIv7pp/RrN07A6WgaXWT49TzDcO8soVL3RfVgRhc
        JBQfDJkPYCVXxBKdKiK8jJM/S90ivamIzw==
X-Google-Smtp-Source: ABdhPJzuhqGzIdD42UVuyuy6pVtW6tF5wKFvfUeq0lxmGN9UuwzlKPF6WumzlRndJeA3tc898SvL0g==
X-Received: by 2002:adf:eb48:0:b0:203:f854:86cc with SMTP id u8-20020adfeb48000000b00203f85486ccmr3802522wrn.102.1647649412297;
        Fri, 18 Mar 2022 17:23:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b00389d4bdb3d2sm14865519wml.36.2022.03.18.17.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 17:23:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 0/8] unpack-objects: support streaming blobs to disk
Date:   Sat, 19 Mar 2022 01:23:17 +0100
Message-Id: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1438.g8874c8eeb35
In-Reply-To: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com>
References: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series by Han Xin was waiting on some in-flight patches that
landed in 430883a70c7 (Merge branch 'ab/object-file-api-updates',
2022-03-16).

This series teaches "git unpack-objects" to stream objects larger than
core.bigFileThreshold to disk. As 8/8 shows streaming e.g. a 100MB
blob now uses ~5MB of memory instead of ~105MB. This streaming method
is slower if you've got memory to handle the blobs in-core, but if you
don't it allows you to unpack objects at all, as you might otherwise
OOM.

Changes since v10:

 * Renamed the new test file, its number conflicted with a
   since-landed commit-graph test.

 * Some minor code changes to make diffs to the pre-image smaller
   (e.g. the top of the range-diff below)

 * The whole "find dest.git" to see if we have loose objects is now
   either a test for "do we have objects at all?" (--dry-run mode), or
   uses a simpler implementation. We could use
   "test_stdout_line_count" for that.

 * We also test that as we use "unpack-objects" to stream directly to
   a pack that the result is byte-for-byte the same as the source.

 * A new 4/8 that I added allows for more code sharing in
   object-file.c, our two end-state functions now share more logic.

 * Minor typo/grammar/comment etc. fixes throughout.

 * Updated 8/8 with benchmarks, somewhere along the line we lost the
   code to run the benchmark mentioned in the commit message...

1. https://lore.kernel.org/git/cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com/

Han Xin (4):
  unpack-objects: low memory footprint for get_data() in dry_run mode
  object-file.c: refactor write_loose_object() to several steps
  object-file.c: add "stream_loose_object()" to handle large object
  unpack-objects: use stream_loose_object() to unpack large objects

Ævar Arnfjörð Bjarmason (4):
  object-file.c: do fsync() and close() before post-write die()
  object-file.c: factor out deflate part of write_loose_object()
  core doc: modernize core.bigFileThreshold documentation
  unpack-objects: refactor away unpack_non_delta_entry()

 Documentation/config/core.txt   |  33 +++--
 builtin/unpack-objects.c        | 109 +++++++++++---
 object-file.c                   | 250 +++++++++++++++++++++++++++-----
 object-store.h                  |   8 +
 t/t5351-unpack-large-objects.sh |  61 ++++++++
 5 files changed, 397 insertions(+), 64 deletions(-)
 create mode 100755 t/t5351-unpack-large-objects.sh

Range-diff against v10:
1:  e46eb75b98f ! 1:  2103d5bfd96 unpack-objects: low memory footprint for get_data() in dry_run mode
    @@ builtin/unpack-objects.c: static void use(int bytes)
      {
      	git_zstream stream;
     -	void *buf = xmallocz(size);
    -+	unsigned long bufsize;
    -+	void *buf;
    ++	unsigned long bufsize = dry_run && size > 8192 ? 8192 : size;
    ++	void *buf = xmallocz(bufsize);
      
      	memset(&stream, 0, sizeof(stream));
    -+	if (dry_run && size > 8192)
    -+		bufsize = 8192;
    -+	else
    -+		bufsize = size;
    -+	buf = xmallocz(bufsize);
      
      	stream.next_out = buf;
     -	stream.avail_out = size;
    @@ builtin/unpack-objects.c: static void unpack_delta_entry(enum object_type type,
      		hi = nr;
      		while (lo < hi) {
     
    - ## t/t5328-unpack-large-objects.sh (new) ##
    + ## t/t5351-unpack-large-objects.sh (new) ##
     @@
     +#!/bin/sh
     +#
    @@ t/t5328-unpack-large-objects.sh (new)
     +	git init --bare dest.git
     +}
     +
    -+test_no_loose () {
    -+	test $(find dest.git/objects/?? -type f | wc -l) = 0
    -+}
    -+
     +test_expect_success "create large objects (1.5 MB) and PACK" '
     +	test-tool genrandom foo 1500000 >big-blob &&
     +	test_commit --append foo big-blob &&
     +	test-tool genrandom bar 1500000 >big-blob &&
     +	test_commit --append bar big-blob &&
    -+	PACK=$(echo HEAD | git pack-objects --revs test)
    ++	PACK=$(echo HEAD | git pack-objects --revs pack)
     +'
     +
     +test_expect_success 'set memory limitation to 1MB' '
    @@ t/t5328-unpack-large-objects.sh (new)
     +
     +test_expect_success 'unpack-objects failed under memory limitation' '
     +	prepare_dest &&
    -+	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
    ++	test_must_fail git -C dest.git unpack-objects <pack-$PACK.pack 2>err &&
     +	grep "fatal: attempting to allocate" err
     +'
     +
     +test_expect_success 'unpack-objects works with memory limitation in dry-run mode' '
     +	prepare_dest &&
    -+	git -C dest.git unpack-objects -n <test-$PACK.pack &&
    -+	test_no_loose &&
    ++	git -C dest.git unpack-objects -n <pack-$PACK.pack &&
    ++	test_stdout_line_count = 0 find dest.git/objects -type f &&
     +	test_dir_is_empty dest.git/objects/pack
     +'
     +
2:  48bf9090058 = 2:  6acd8759772 object-file.c: do fsync() and close() before post-write die()
3:  0e33d2a6e35 = 3:  f7b02c307fc object-file.c: refactor write_loose_object() to several steps
-:  ----------- > 4:  20d97cc2605 object-file.c: factor out deflate part of write_loose_object()
4:  9644df5c744 ! 5:  db40f4160c4 object-file.c: add "stream_loose_object()" to handle large object
    @@ Commit message
         Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object-file.c ##
     @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +	strbuf_addf(&filename, "%s/", get_object_directory());
     +	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
     +
    -+	/* Common steps for write_loose_object and stream_loose_object to
    -+	 * start writing loose oject:
    ++	/*
    ++	 * Common steps for write_loose_object and stream_loose_object to
    ++	 * start writing loose objects:
     +	 *
     +	 *  - Create tmpfile for the loose object.
     +	 *  - Setup zlib stream for compression.
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +	/* Then the data itself.. */
     +	do {
     +		unsigned char *in0 = stream.next_in;
    ++
     +		if (!stream.avail_in && !in_stream->is_finished) {
     +			const void *in = in_stream->read(in_stream, &stream.avail_in);
     +			stream.next_in = (void *)in;
     +			in0 = (unsigned char *)in;
     +			/* All data has been read. */
     +			if (in_stream->is_finished)
    -+				flush = Z_FINISH;
    ++				flush = 1;
     +		}
    -+		ret = git_deflate(&stream, flush);
    -+		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
    -+		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
    -+			die(_("unable to write loose object file"));
    -+		stream.next_out = compressed;
    -+		stream.avail_out = sizeof(compressed);
    ++		ret = write_loose_object_common(&c, &stream, flush, in0, fd,
    ++						compressed, sizeof(compressed));
     +		/*
     +		 * Unlike write_loose_object(), we do not have the entire
     +		 * buffer. If we get Z_BUF_ERROR due to too few input bytes,
5:  4550f3a2745 = 6:  d8ae2eadb98 core doc: modernize core.bigFileThreshold documentation
-:  ----------- > 7:  2b403e7cd9c unpack-objects: refactor away unpack_non_delta_entry()
6:  6a70e49a346 ! 8:  5eded902496 unpack-objects: use stream_loose_object() to unpack large objects
    @@ Commit message
         malloc() the size of the blob before unpacking it, which could cause
         OOM with very large blobs.
     
    -    We could use this new interface to unpack all blobs, but doing so
    -    would result in a performance penalty of around 10%, as the below
    -    "hyperfine" benchmark will show. We therefore limit this to files
    -    larger than "core.bigFileThreshold":
    -
    -        $ hyperfine \
    -          --setup \
    -          'if ! test -d scalar.git; then git clone --bare
    -           https://github.com/microsoft/scalar.git;
    -           cp scalar.git/objects/pack/*.pack small.pack; fi' \
    -          --prepare 'rm -rf dest.git && git init --bare dest.git' \
    -          ...
    -
    -        Summary
    -          './git -C dest.git -c core.bigFileThreshold=512m
    -          unpack-objects <small.pack' in 'origin/master'
    -            1.01 ± 0.04 times faster than './git -C dest.git
    -                    -c core.bigFileThreshold=512m unpack-objects
    -                    <small.pack' in 'HEAD~1'
    -            1.01 ± 0.04 times faster than './git -C dest.git
    -                    -c core.bigFileThreshold=512m unpack-objects
    -                    <small.pack' in 'HEAD~0'
    -            1.03 ± 0.10 times faster than './git -C dest.git
    -                    -c core.bigFileThreshold=16k unpack-objects
    -                    <small.pack' in 'origin/master'
    -            1.02 ± 0.07 times faster than './git -C dest.git
    -                    -c core.bigFileThreshold=16k unpack-objects
    -                    <small.pack' in 'HEAD~0'
    -            1.10 ± 0.04 times faster than './git -C dest.git
    -                    -c core.bigFileThreshold=16k unpack-objects
    -                    <small.pack' in 'HEAD~1'
    +    We could use the new streaming interface to unpack all blobs, but
    +    doing so would be much slower, as demonstrated e.g. with this
    +    benchmark using git-hyperfine[0]:
    +
    +            rm -rf /tmp/scalar.git &&
    +            git clone --bare https://github.com/Microsoft/scalar.git /tmp/scalar.git &&
    +            mv /tmp/scalar.git/objects/pack/*.pack /tmp/scalar.git/my.pack &&
    +            git hyperfine \
    +                    -r 2 --warmup 1 \
    +                    -L rev origin/master,HEAD -L v "10,512,1k,1m" \
    +                    -s 'make' \
    +                    -p 'git init --bare dest.git' \
    +                    -c 'rm -rf dest.git' \
    +                    './git -C dest.git -c core.bigFileThreshold={v} unpack-objects </tmp/scalar.git/my.pack'
    +
    +    Here we'll perform worse with lower core.bigFileThreshold settings
    +    with this change in terms of speed, but we're getting lower memory use
    +    in return:
    +
    +            Summary
    +              './git -C dest.git -c core.bigFileThreshold=10 unpack-objects </tmp/scalar.git/my.pack' in 'origin/master' ran
    +                1.01 ± 0.01 times faster than './git -C dest.git -c core.bigFileThreshold=1k unpack-objects </tmp/scalar.git/my.pack' in 'origin/master'
    +                1.01 ± 0.01 times faster than './git -C dest.git -c core.bigFileThreshold=1m unpack-objects </tmp/scalar.git/my.pack' in 'origin/master'
    +                1.01 ± 0.02 times faster than './git -C dest.git -c core.bigFileThreshold=1m unpack-objects </tmp/scalar.git/my.pack' in 'HEAD'
    +                1.02 ± 0.00 times faster than './git -C dest.git -c core.bigFileThreshold=512 unpack-objects </tmp/scalar.git/my.pack' in 'origin/master'
    +                1.09 ± 0.01 times faster than './git -C dest.git -c core.bigFileThreshold=1k unpack-objects </tmp/scalar.git/my.pack' in 'HEAD'
    +                1.10 ± 0.00 times faster than './git -C dest.git -c core.bigFileThreshold=512 unpack-objects </tmp/scalar.git/my.pack' in 'HEAD'
    +                1.11 ± 0.00 times faster than './git -C dest.git -c core.bigFileThreshold=10 unpack-objects </tmp/scalar.git/my.pack' in 'HEAD'
    +
    +    A better benchmark to demonstrate the benefits of that this one, which
    +    creates an artificial repo with a 1, 25, 50, 75 and 100MB blob:
    +
    +            rm -rf /tmp/repo &&
    +            git init /tmp/repo &&
    +            (
    +                    cd /tmp/repo &&
    +                    for i in 1 25 50 75 100
    +                    do
    +                            dd if=/dev/urandom of=blob.$i count=$(($i*1024)) bs=1024
    +                    done &&
    +                    git add blob.* &&
    +                    git commit -mblobs &&
    +                    git gc &&
    +                    PACK=$(echo .git/objects/pack/pack-*.pack) &&
    +                    cp "$PACK" my.pack
    +            ) &&
    +            git hyperfine \
    +                    --show-output \
    +                    -L rev origin/master,HEAD -L v "512,50m,100m" \
    +                    -s 'make' \
    +                    -p 'git init --bare dest.git' \
    +                    -c 'rm -rf dest.git' \
    +                    '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold={v} unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum'
    +
    +    Using this test we'll always use >100MB of memory on
    +    origin/master (around ~105MB), but max out at e.g. ~55MB if we set
    +    core.bigFileThreshold=50m.
    +
    +    The relevant "Maximum resident set size" lines were manually added
    +    below the relevant benchmark:
    +
    +      '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=50m unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'origin/master' ran
    +            Maximum resident set size (kbytes): 107080
    +        1.02 ± 0.78 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=512 unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'origin/master'
    +            Maximum resident set size (kbytes): 106968
    +        1.09 ± 0.79 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=100m unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'origin/master'
    +            Maximum resident set size (kbytes): 107032
    +        1.42 ± 1.07 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=100m unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'HEAD'
    +            Maximum resident set size (kbytes): 107072
    +        1.83 ± 1.02 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=50m unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'HEAD'
    +            Maximum resident set size (kbytes): 55704
    +        2.16 ± 1.19 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=512 unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'HEAD'
    +            Maximum resident set size (kbytes): 4564
    +
    +    This shows that if you have enough memory this new streaming method is
    +    slower the lower you set the streaming threshold, but the benefit is
    +    more bounded memory use.
     
         An earlier version of this patch introduced a new
         "core.bigFileStreamingThreshold" instead of re-using the existing
    @@ Commit message
         split up "core.bigFileThreshold" in the future if there's a need for
         that.
     
    +    0. https://github.com/avar/git-hyperfine/
         1. https://lore.kernel.org/git/20211210103435.83656-1-chiyutianyi@gmail.com/
         2. https://lore.kernel.org/git/20220120112114.47618-5-chiyutianyi@gmail.com/
     
    @@ Commit message
         Helped-by: Derrick Stolee <stolee@gmail.com>
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/config/core.txt ##
     @@ Documentation/config/core.txt: usage, at the slight expense of increased disk usage.
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	return data->buf;
     +}
     +
    -+static void write_stream_blob(unsigned nr, size_t size)
    ++static void stream_blob(unsigned long size, unsigned nr)
     +{
     +	git_zstream zstream = { 0 };
     +	struct input_zstream_data data = { 0 };
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +		.read = feed_input_zstream,
     +		.data = &data,
     +	};
    ++	struct obj_info *info = &obj_list[nr];
     +
     +	data.zstream = &zstream;
     +	git_inflate_init(&zstream);
     +
    -+	if (stream_loose_object(&in_stream, size, &obj_list[nr].oid))
    ++	if (stream_loose_object(&in_stream, size, &info->oid))
     +		die(_("failed to write object in stream"));
     +
     +	if (data.status != Z_STREAM_END)
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	git_inflate_end(&zstream);
     +
     +	if (strict) {
    -+		struct blob *blob =
    -+			lookup_blob(the_repository, &obj_list[nr].oid);
    -+		if (blob)
    -+			blob->object.flags |= FLAG_WRITTEN;
    -+		else
    ++		struct blob *blob = lookup_blob(the_repository, &info->oid);
    ++
    ++		if (!blob)
     +			die(_("invalid blob object from stream"));
    ++		blob->object.flags |= FLAG_WRITTEN;
     +	}
    -+	obj_list[nr].obj = NULL;
    ++	info->obj = NULL;
     +}
     +
    - static void unpack_non_delta_entry(enum object_type type, unsigned long size,
    - 				   unsigned nr)
    + static int resolve_against_held(unsigned nr, const struct object_id *base,
    + 				void *delta_data, unsigned long delta_size)
      {
    --	void *buf = get_data(size);
    -+	void *buf;
    -+
    -+	/* Write large blob in stream without allocating full buffer. */
    -+	if (!dry_run && type == OBJ_BLOB && size > big_file_threshold) {
    -+		write_stream_blob(nr, size);
    -+		return;
    -+	}
    +@@ builtin/unpack-objects.c: static void unpack_one(unsigned nr)
      
    -+	buf = get_data(size);
    - 	if (buf)
    - 		write_object(nr, type, buf, size);
    - }
    + 	switch (type) {
    + 	case OBJ_BLOB:
    ++		if (!dry_run && size > big_file_threshold) {
    ++			stream_blob(size, nr);
    ++			return;
    ++		}
    ++		/* fallthrough */
    + 	case OBJ_COMMIT:
    + 	case OBJ_TREE:
    + 	case OBJ_TAG:
     
    - ## t/t5328-unpack-large-objects.sh ##
    -@@ t/t5328-unpack-large-objects.sh: test_description='git unpack-objects with large objects'
    + ## t/t5351-unpack-large-objects.sh ##
    +@@ t/t5351-unpack-large-objects.sh: test_description='git unpack-objects with large objects'
      
      prepare_dest () {
      	test_when_finished "rm -rf dest.git" &&
     -	git init --bare dest.git
     +	git init --bare dest.git &&
    -+	if test -n "$1"
    -+	then
    -+		git -C dest.git config core.bigFileThreshold $1
    -+	fi
    ++	git -C dest.git config core.bigFileThreshold "$1"
      }
      
    - test_no_loose () {
    -@@ t/t5328-unpack-large-objects.sh: test_expect_success 'set memory limitation to 1MB' '
    + test_expect_success "create large objects (1.5 MB) and PACK" '
    +@@ t/t5351-unpack-large-objects.sh: test_expect_success 'set memory limitation to 1MB' '
      '
      
      test_expect_success 'unpack-objects failed under memory limitation' '
     -	prepare_dest &&
     +	prepare_dest 2m &&
    - 	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
    + 	test_must_fail git -C dest.git unpack-objects <pack-$PACK.pack 2>err &&
      	grep "fatal: attempting to allocate" err
      '
      
      test_expect_success 'unpack-objects works with memory limitation in dry-run mode' '
     -	prepare_dest &&
     +	prepare_dest 2m &&
    - 	git -C dest.git unpack-objects -n <test-$PACK.pack &&
    - 	test_no_loose &&
    + 	git -C dest.git unpack-objects -n <pack-$PACK.pack &&
    + 	test_stdout_line_count = 0 find dest.git/objects -type f &&
      	test_dir_is_empty dest.git/objects/pack
      '
      
     +test_expect_success 'unpack big object in stream' '
     +	prepare_dest 1m &&
    -+	git -C dest.git unpack-objects <test-$PACK.pack &&
    ++	git -C dest.git unpack-objects <pack-$PACK.pack &&
     +	test_dir_is_empty dest.git/objects/pack
     +'
     +
     +test_expect_success 'do not unpack existing large objects' '
     +	prepare_dest 1m &&
    -+	git -C dest.git index-pack --stdin <test-$PACK.pack &&
    -+	git -C dest.git unpack-objects <test-$PACK.pack &&
    -+	test_no_loose
    ++	git -C dest.git index-pack --stdin <pack-$PACK.pack &&
    ++	git -C dest.git unpack-objects <pack-$PACK.pack &&
    ++
    ++	# The destination came up with the exact same pack...
    ++	DEST_PACK=$(echo dest.git/objects/pack/pack-*.pack) &&
    ++	test_cmp pack-$PACK.pack $DEST_PACK &&
    ++
    ++	# ...and wrote no loose objects
    ++	test_stdout_line_count = 0 find dest.git/objects -type f ! -name "pack-*"
     +'
     +
      test_done
-- 
2.35.1.1438.g8874c8eeb35

