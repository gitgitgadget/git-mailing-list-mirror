Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9819EC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 14:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiFJOrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349599AbiFJOrP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 10:47:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEBD1F5357
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so2269294pjb.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4YGJ+ddtr5RlCelrNfaYsLPvQx8soXqleuAESoecdo=;
        b=n0ZaVuoLg7kLz14z1lUaMa5y2k1b8Sh/A8eMB+aA4TMTgdJ7vGFXRC5RRMt8Mmkzhp
         sU6Yzl/DqkPN2609C4AgZUFLRi9Aj0L465/KpBdddqSQAfIH0tkuPuKavUPX6UiVYUvR
         qtmstwRbMg0MGpnq+F/ekYVIVi1hGSTS2qWfJ+h5nalgQsqNv8SRGSjnNCcQn762HHV3
         WbfvXLFSMWwVni7W9IaPcWpuYE9SskcfmJBz5xHa3rRcMsC0SODrsx1gcS3VDyAfz2fO
         j+Xm2apqrO0P7org4erpf+d1dmRIXoCQjvr6BP3g3GAxDxhJO/Vw0I2UdZVeQ8BG62D3
         okkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4YGJ+ddtr5RlCelrNfaYsLPvQx8soXqleuAESoecdo=;
        b=HNMJACjaJ0BP0J2S0I+XDeWl2snKBNNYK7xTWMxSNyrCj12zv0D3I+xg4xCeO7jb28
         NuFOfekow6r/XtHWPDLl52/DeP1qbw7Ijcf4QJGtgkuSd6UQ1dF2gyd85/0uTjhlKDFO
         LuYdcyM7Ik+Dp8txArKHHkSy/MzyM1y0DAT6zTQM2bv2dl1NwPZUh+EVoPtpIdLtivmu
         cVivuy5gjzhQa07Rg8OivsQtLGIog3DpGr06CvlTEXodjpFrjkMzcFNOZKePKMfxos5c
         mlIFcX4CZRA7ZhPpaSyrWP6m+QGQ0KRJAzDruMRT4sdZkQPzwjPDbsZQaL9yq2FuEQD6
         jw/A==
X-Gm-Message-State: AOAM532y4rRAaDyD0KSchpLeCERj2wM+ysHRgWlapezAepWzVZ+UYO6h
        OTFwMk09ge+6pDM2m3nhw5U=
X-Google-Smtp-Source: ABdhPJwQCHn32NGhotysZChN4Qwo+Ph9N+ZQ1Tc5xK4dKyio0xhvJYXdrvMWv6VAeQ2M89je7w0yaQ==
X-Received: by 2002:a17:903:2592:b0:168:9708:ad73 with SMTP id jb18-20020a170903259200b001689708ad73mr14081137plb.59.1654872433744;
        Fri, 10 Jun 2022 07:47:13 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id lx9-20020a17090b4b0900b001e292e30129sm1840434pjb.22.2022.06.10.07.47.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 07:47:13 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>, chiyutianyi@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        neerajsi@microsoft.com, newren@gmail.com, philipoakley@iee.email,
        stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v14 1/7] unpack-objects: low memory footprint for get_data() in dry_run mode
Date:   Fri, 10 Jun 2022 22:46:01 +0800
Message-Id: <bf600a2fa85883193df22436be52ac8ca809aa33.1654871916.git.chiyutianyi@gmail.com>
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

As the name implies, "get_data(size)" will allocate and return a given
amount of memory. Allocating memory for a large blob object may cause the
system to run out of memory. Before preparing to replace calling of
"get_data()" to unpack large blob objects in latter commits, refactor
"get_data()" to reduce memory footprint for dry_run mode.

Because in dry_run mode, "get_data()" is only used to check the
integrity of data, and the returned buffer is not used at all, we can
allocate a smaller buffer and use it as zstream output. Make the function
return NULL in the dry-run mode, as no callers use the returned buffer.

The "find [...]objects/?? -type f | wc -l" test idiom being used here
is adapted from the same "find" use added to another test in
d9545c7f465 (fast-import: implement unpack limit, 2016-04-25).

Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/unpack-objects.c        | 37 ++++++++++++++++++++---------
 t/t5351-unpack-large-objects.sh | 41 +++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 11 deletions(-)
 create mode 100755 t/t5351-unpack-large-objects.sh

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 56d05e2725..32e8b47059 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -97,15 +97,27 @@ static void use(int bytes)
 	display_throughput(progress, consumed_bytes);
 }
 
+/*
+ * Decompress zstream from the standard input into a newly
+ * allocated buffer of specified size and return the buffer.
+ * The caller is responsible to free the returned buffer.
+ *
+ * But for dry_run mode, "get_data()" is only used to check the
+ * integrity of data, and the returned buffer is not used at all.
+ * Therefore, in dry_run mode, "get_data()" will release the small
+ * allocated buffer which is reused to hold temporary zstream output
+ * and return NULL instead of returning garbage data.
+ */
 static void *get_data(unsigned long size)
 {
 	git_zstream stream;
-	void *buf = xmallocz(size);
+	unsigned long bufsize = dry_run && size > 8192 ? 8192 : size;
+	void *buf = xmallocz(bufsize);
 
 	memset(&stream, 0, sizeof(stream));
 
 	stream.next_out = buf;
-	stream.avail_out = size;
+	stream.avail_out = bufsize;
 	stream.next_in = fill(1);
 	stream.avail_in = len;
 	git_inflate_init(&stream);
@@ -125,8 +137,17 @@ static void *get_data(unsigned long size)
 		}
 		stream.next_in = fill(1);
 		stream.avail_in = len;
+		if (dry_run) {
+			/* reuse the buffer in dry_run mode */
+			stream.next_out = buf;
+			stream.avail_out = bufsize > size - stream.total_out ?
+						   size - stream.total_out :
+						   bufsize;
+		}
 	}
 	git_inflate_end(&stream);
+	if (dry_run)
+		FREE_AND_NULL(buf);
 	return buf;
 }
 
@@ -326,10 +347,8 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 {
 	void *buf = get_data(size);
 
-	if (!dry_run && buf)
+	if (buf)
 		write_object(nr, type, buf, size);
-	else
-		free(buf);
 }
 
 static int resolve_against_held(unsigned nr, const struct object_id *base,
@@ -359,10 +378,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		oidread(&base_oid, fill(the_hash_algo->rawsz));
 		use(the_hash_algo->rawsz);
 		delta_data = get_data(delta_size);
-		if (dry_run || !delta_data) {
-			free(delta_data);
+		if (!delta_data)
 			return;
-		}
 		if (has_object_file(&base_oid))
 			; /* Ok we have this one */
 		else if (resolve_against_held(nr, &base_oid,
@@ -398,10 +415,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			die("offset value out of bound for delta base object");
 
 		delta_data = get_data(delta_size);
-		if (dry_run || !delta_data) {
-			free(delta_data);
+		if (!delta_data)
 			return;
-		}
 		lo = 0;
 		hi = nr;
 		while (lo < hi) {
diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
new file mode 100755
index 0000000000..8d84313221
--- /dev/null
+++ b/t/t5351-unpack-large-objects.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+#
+# Copyright (c) 2022 Han Xin
+#
+
+test_description='git unpack-objects with large objects'
+
+. ./test-lib.sh
+
+prepare_dest () {
+	test_when_finished "rm -rf dest.git" &&
+	git init --bare dest.git
+}
+
+test_expect_success "create large objects (1.5 MB) and PACK" '
+	test-tool genrandom foo 1500000 >big-blob &&
+	test_commit --append foo big-blob &&
+	test-tool genrandom bar 1500000 >big-blob &&
+	test_commit --append bar big-blob &&
+	PACK=$(echo HEAD | git pack-objects --revs pack)
+'
+
+test_expect_success 'set memory limitation to 1MB' '
+	GIT_ALLOC_LIMIT=1m &&
+	export GIT_ALLOC_LIMIT
+'
+
+test_expect_success 'unpack-objects failed under memory limitation' '
+	prepare_dest &&
+	test_must_fail git -C dest.git unpack-objects <pack-$PACK.pack 2>err &&
+	grep "fatal: attempting to allocate" err
+'
+
+test_expect_success 'unpack-objects works with memory limitation in dry-run mode' '
+	prepare_dest &&
+	git -C dest.git unpack-objects -n <pack-$PACK.pack &&
+	test_stdout_line_count = 0 find dest.git/objects -type f &&
+	test_dir_is_empty dest.git/objects/pack
+'
+
+test_done
-- 
2.36.1

