Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EADC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 14:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349626AbiFJOtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348608AbiFJOsA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 10:48:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5AE31DE3
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u2so24058725pfc.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdvSoqzcUsqZjm6DpC5TzqgfLDBezMYtYyvwFUVvZgw=;
        b=B4Wo8iXjO+1Oug1B+DvQfFcWaMzZOSMRmn2kXaWEqtw6pX871+8i17HjdTalUc1XpG
         zFNdBwvWKqO49/TaZ07eBJdRBkCMI3HM7TRL7jk+3ZOZGqv9WxakLMEKbNDNxHIlAahh
         miYq2YuyCaKCWvvZF79371uza+UTahapThTPr2hNgCHTDQDuRMen2GjdRHrIFbGkKQh2
         8L8/Mfv+U/uY0QzIu9KotR9Pq6c95vrfjaXvbLKPe+ixbfeL8WMcjgtzydX+ZWNI52lh
         XhLTLf7pE7GJHWpo1uziYIOO/Jp1b42kNOl1t4X7mqmx9VWGza2HUltND/Dbpjtnhvba
         2aDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdvSoqzcUsqZjm6DpC5TzqgfLDBezMYtYyvwFUVvZgw=;
        b=ComPZhBPFmM7wJlbPcSxCLlvl8ejp83w7PjvdN8DOqlkjAjh45yX8g0YFcJPnTygmf
         VGCgmm7CZecqVbMTIBQEzO0aEeOyBj7/4yJAVoMs79ch1NxRBI5IVaA2wOC5O/wBgDrW
         eds7TcynhXm/R1U/wQCgsf7pqjWYjsT77fHht8sqBmBBmfTXl4oOx83a5nrxhllHHA6F
         fhmomuo3ss5WR5ksseAhEq9BLYM4O9dXOsSlaN5HTFTcoLt7jQNrR2ABTRqEVlmFbJOm
         HW8RB8W50pzM5FhUC2HBB+ioK/ke37oGRwvD26J08TviIAwT2Fee537e1m6AfnaXNtIH
         yTyg==
X-Gm-Message-State: AOAM530NEzAMDjpDDfKfipJ0slWYc6yRKvg2WpRYA4714X948PJ65U4H
        RVsMN8n9fbX9wbfRu4BWMzU=
X-Google-Smtp-Source: ABdhPJx6eOuSc3fQ+wknici99lblBp4kFZO2PoMISf2oLMmV3XfTehs02SoFSiH5fI4WNm/w9FqP2Q==
X-Received: by 2002:a63:f0d:0:b0:401:9819:c6ee with SMTP id e13-20020a630f0d000000b004019819c6eemr7524533pgl.450.1654872466320;
        Fri, 10 Jun 2022 07:47:46 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id lx9-20020a17090b4b0900b001e292e30129sm1840434pjb.22.2022.06.10.07.47.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 07:47:45 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>, chiyutianyi@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        neerajsi@microsoft.com, newren@gmail.com, philipoakley@iee.email,
        stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v14 7/7] unpack-objects: use stream_loose_object() to unpack large objects
Date:   Fri, 10 Jun 2022 22:46:07 +0800
Message-Id: <d236230a4c5edf5e1c2685468c8ec0441743066e.1654871916.git.chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654871915.git.chiyutianyi@gmail.com>
References: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com> <cover.1654871915.git.chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

Make use of the stream_loose_object() function introduced in the
preceding commit to unpack large objects. Before this we'd need to
malloc() the size of the blob before unpacking it, which could cause
OOM with very large blobs.

We could use the new streaming interface to unpack all blobs, but
doing so would be much slower, as demonstrated e.g. with this
benchmark using git-hyperfine[0]:

	rm -rf /tmp/scalar.git &&
	git clone --bare https://github.com/Microsoft/scalar.git /tmp/scalar.git &&
	mv /tmp/scalar.git/objects/pack/*.pack /tmp/scalar.git/my.pack &&
	git hyperfine \
		-r 2 --warmup 1 \
		-L rev origin/master,HEAD -L v "10,512,1k,1m" \
		-s 'make' \
		-p 'git init --bare dest.git' \
		-c 'rm -rf dest.git' \
		'./git -C dest.git -c core.bigFileThreshold={v} unpack-objects </tmp/scalar.git/my.pack'

Here we'll perform worse with lower core.bigFileThreshold settings
with this change in terms of speed, but we're getting lower memory use
in return:

	Summary
	  './git -C dest.git -c core.bigFileThreshold=10 unpack-objects </tmp/scalar.git/my.pack' in 'origin/master' ran
	    1.01 ± 0.01 times faster than './git -C dest.git -c core.bigFileThreshold=1k unpack-objects </tmp/scalar.git/my.pack' in 'origin/master'
	    1.01 ± 0.01 times faster than './git -C dest.git -c core.bigFileThreshold=1m unpack-objects </tmp/scalar.git/my.pack' in 'origin/master'
	    1.01 ± 0.02 times faster than './git -C dest.git -c core.bigFileThreshold=1m unpack-objects </tmp/scalar.git/my.pack' in 'HEAD'
	    1.02 ± 0.00 times faster than './git -C dest.git -c core.bigFileThreshold=512 unpack-objects </tmp/scalar.git/my.pack' in 'origin/master'
	    1.09 ± 0.01 times faster than './git -C dest.git -c core.bigFileThreshold=1k unpack-objects </tmp/scalar.git/my.pack' in 'HEAD'
	    1.10 ± 0.00 times faster than './git -C dest.git -c core.bigFileThreshold=512 unpack-objects </tmp/scalar.git/my.pack' in 'HEAD'
	    1.11 ± 0.00 times faster than './git -C dest.git -c core.bigFileThreshold=10 unpack-objects </tmp/scalar.git/my.pack' in 'HEAD'

A better benchmark to demonstrate the benefits of that this one, which
creates an artificial repo with a 1, 25, 50, 75 and 100MB blob:

	rm -rf /tmp/repo &&
	git init /tmp/repo &&
	(
		cd /tmp/repo &&
		for i in 1 25 50 75 100
		do
			dd if=/dev/urandom of=blob.$i count=$(($i*1024)) bs=1024
		done &&
		git add blob.* &&
		git commit -mblobs &&
		git gc &&
		PACK=$(echo .git/objects/pack/pack-*.pack) &&
		cp "$PACK" my.pack
	) &&
	git hyperfine \
		--show-output \
		-L rev origin/master,HEAD -L v "512,50m,100m" \
		-s 'make' \
		-p 'git init --bare dest.git' \
		-c 'rm -rf dest.git' \
		'/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold={v} unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum'

Using this test we'll always use >100MB of memory on
origin/master (around ~105MB), but max out at e.g. ~55MB if we set
core.bigFileThreshold=50m.

The relevant "Maximum resident set size" lines were manually added
below the relevant benchmark:

  '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=50m unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'origin/master' ran
        Maximum resident set size (kbytes): 107080
    1.02 ± 0.78 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=512 unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'origin/master'
        Maximum resident set size (kbytes): 106968
    1.09 ± 0.79 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=100m unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'origin/master'
        Maximum resident set size (kbytes): 107032
    1.42 ± 1.07 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=100m unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'HEAD'
        Maximum resident set size (kbytes): 107072
    1.83 ± 1.02 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=50m unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'HEAD'
        Maximum resident set size (kbytes): 55704
    2.16 ± 1.19 times faster than '/usr/bin/time -v ./git -C dest.git -c core.bigFileThreshold=512 unpack-objects </tmp/repo/my.pack 2>&1 | grep Maximum' in 'HEAD'
        Maximum resident set size (kbytes): 4564

This shows that if you have enough memory this new streaming method is
slower the lower you set the streaming threshold, but the benefit is
more bounded memory use.

An earlier version of this patch introduced a new
"core.bigFileStreamingThreshold" instead of re-using the existing
"core.bigFileThreshold" variable[1]. As noted in a detailed overview
of its users in [2] using it has several different meanings.

Still, we consider it good enough to simply re-use it. While it's
possible that someone might want to e.g. consider objects "small" for
the purposes of diffing but "big" for the purposes of writing them
such use-cases are probably too obscure to worry about. We can always
split up "core.bigFileThreshold" in the future if there's a need for
that.

0. https://github.com/avar/git-hyperfine/
1. https://lore.kernel.org/git/20211210103435.83656-1-chiyutianyi@gmail.com/
2. https://lore.kernel.org/git/20220120112114.47618-5-chiyutianyi@gmail.com/

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/core.txt   |  4 +-
 builtin/unpack-objects.c        | 69 ++++++++++++++++++++++++++++++++-
 t/t5351-unpack-large-objects.sh | 43 ++++++++++++++++++--
 3 files changed, 109 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index f2e75dd824..a599dcb96b 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -468,8 +468,8 @@ usage, at the slight expense of increased disk usage.
 * Will be generally be streamed when written, which avoids excessive
 memory usage, at the cost of some fixed overhead. Commands that make
 use of this include linkgit:git-archive[1],
-linkgit:git-fast-import[1], linkgit:git-index-pack[1] and
-linkgit:git-fsck[1].
+linkgit:git-fast-import[1], linkgit:git-index-pack[1],
+linkgit:git-unpack-objects[1] and linkgit:git-fsck[1].
 
 core.excludesFile::
 	Specifies the pathname to the file that contains patterns to
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 32e8b47059..43789b8ef2 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -351,6 +351,68 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 		write_object(nr, type, buf, size);
 }
 
+struct input_zstream_data {
+	git_zstream *zstream;
+	unsigned char buf[8192];
+	int status;
+};
+
+static const void *feed_input_zstream(struct input_stream *in_stream,
+				      unsigned long *readlen)
+{
+	struct input_zstream_data *data = in_stream->data;
+	git_zstream *zstream = data->zstream;
+	void *in = fill(1);
+
+	if (in_stream->is_finished) {
+		*readlen = 0;
+		return NULL;
+	}
+
+	zstream->next_out = data->buf;
+	zstream->avail_out = sizeof(data->buf);
+	zstream->next_in = in;
+	zstream->avail_in = len;
+
+	data->status = git_inflate(zstream, 0);
+
+	in_stream->is_finished = data->status != Z_OK;
+	use(len - zstream->avail_in);
+	*readlen = sizeof(data->buf) - zstream->avail_out;
+
+	return data->buf;
+}
+
+static void stream_blob(unsigned long size, unsigned nr)
+{
+	git_zstream zstream = { 0 };
+	struct input_zstream_data data = { 0 };
+	struct input_stream in_stream = {
+		.read = feed_input_zstream,
+		.data = &data,
+	};
+	struct obj_info *info = &obj_list[nr];
+
+	data.zstream = &zstream;
+	git_inflate_init(&zstream);
+
+	if (stream_loose_object(&in_stream, size, &info->oid))
+		die(_("failed to write object in stream"));
+
+	if (data.status != Z_STREAM_END)
+		die(_("inflate returned (%d)"), data.status);
+	git_inflate_end(&zstream);
+
+	if (strict) {
+		struct blob *blob = lookup_blob(the_repository, &info->oid);
+
+		if (!blob)
+			die(_("invalid blob object from stream"));
+		blob->object.flags |= FLAG_WRITTEN;
+	}
+	info->obj = NULL;
+}
+
 static int resolve_against_held(unsigned nr, const struct object_id *base,
 				void *delta_data, unsigned long delta_size)
 {
@@ -483,9 +545,14 @@ static void unpack_one(unsigned nr)
 	}
 
 	switch (type) {
+	case OBJ_BLOB:
+		if (!dry_run && size > big_file_threshold) {
+			stream_blob(size, nr);
+			return;
+		}
+		/* fallthrough */
 	case OBJ_COMMIT:
 	case OBJ_TREE:
-	case OBJ_BLOB:
 	case OBJ_TAG:
 		unpack_non_delta_entry(type, size, nr);
 		return;
diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
index 8d84313221..8ce8aa3b14 100755
--- a/t/t5351-unpack-large-objects.sh
+++ b/t/t5351-unpack-large-objects.sh
@@ -9,7 +9,8 @@ test_description='git unpack-objects with large objects'
 
 prepare_dest () {
 	test_when_finished "rm -rf dest.git" &&
-	git init --bare dest.git
+	git init --bare dest.git &&
+	git -C dest.git config core.bigFileThreshold "$1"
 }
 
 test_expect_success "create large objects (1.5 MB) and PACK" '
@@ -17,7 +18,10 @@ test_expect_success "create large objects (1.5 MB) and PACK" '
 	test_commit --append foo big-blob &&
 	test-tool genrandom bar 1500000 >big-blob &&
 	test_commit --append bar big-blob &&
-	PACK=$(echo HEAD | git pack-objects --revs pack)
+	PACK=$(echo HEAD | git pack-objects --revs pack) &&
+	git verify-pack -v pack-$PACK.pack >out &&
+	sed -n -e "s/^\([0-9a-f][0-9a-f]*\).*\(commit\|tree\|blob\).*/\1/p" \
+		<out >obj-list
 '
 
 test_expect_success 'set memory limitation to 1MB' '
@@ -26,16 +30,47 @@ test_expect_success 'set memory limitation to 1MB' '
 '
 
 test_expect_success 'unpack-objects failed under memory limitation' '
-	prepare_dest &&
+	prepare_dest 2m &&
 	test_must_fail git -C dest.git unpack-objects <pack-$PACK.pack 2>err &&
 	grep "fatal: attempting to allocate" err
 '
 
 test_expect_success 'unpack-objects works with memory limitation in dry-run mode' '
-	prepare_dest &&
+	prepare_dest 2m &&
 	git -C dest.git unpack-objects -n <pack-$PACK.pack &&
 	test_stdout_line_count = 0 find dest.git/objects -type f &&
 	test_dir_is_empty dest.git/objects/pack
 '
 
+test_expect_success 'unpack big object in stream' '
+	prepare_dest 1m &&
+	git -C dest.git unpack-objects <pack-$PACK.pack &&
+	test_dir_is_empty dest.git/objects/pack
+'
+
+BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+
+test_expect_success 'unpack big object in stream (core.fsyncmethod=batch)' '
+	prepare_dest 1m &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git -C dest.git $BATCH_CONFIGURATION unpack-objects <pack-$PACK.pack &&
+	grep fsync/hardware-flush trace2.txt &&
+	test_dir_is_empty dest.git/objects/pack &&
+	git -C dest.git cat-file --batch-check="%(objectname)" <obj-list >current &&
+	cmp obj-list current
+'
+
+test_expect_success 'do not unpack existing large objects' '
+	prepare_dest 1m &&
+	git -C dest.git index-pack --stdin <pack-$PACK.pack &&
+	git -C dest.git unpack-objects <pack-$PACK.pack &&
+
+	# The destination came up with the exact same pack...
+	DEST_PACK=$(echo dest.git/objects/pack/pack-*.pack) &&
+	test_cmp pack-$PACK.pack $DEST_PACK &&
+
+	# ...and wrote no loose objects
+	test_stdout_line_count = 0 find dest.git/objects -type f ! -name "pack-*"
+'
+
 test_done
-- 
2.36.1

