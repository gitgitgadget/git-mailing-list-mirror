Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB6AC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 11:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiATLWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 06:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiATLWo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 06:22:44 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D544C06175D
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:22:30 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i17so5224183pfk.11
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTAZHWjWzKv9abjH/CePc2uNxRFWpH0jwXf9oaBslEk=;
        b=l+RO9+w1CSK77Tx+D+7N0M+rXzd/JXGuqInWsp1lq+kTi9ScSKWq+BcD3vosK3aR4w
         w/2bp/VOyk4+7F6yyd1h6q+vplovIuTuYmVSgqTKzr+OGmXkVkqYHH7YluQmTk4bB4XM
         OzgXxaMfBxPdUklAkRQ1sl6Sr41BDV+WsjsGAuKsNswr03CX/o5FdxseORrFE3GkJILy
         JTS5n+ydQSTUsq2L4t7gw36KE/o/TOXlXvgz3wwJ82AzvkYIlG09i/l2eitlmwKVc8Ff
         nKLKBiK/PlRIcu5cXWnTDzpAy+MI1onJdd+ytrZd7pRHonu8Jt+d1lUkrHPh15WCCBH8
         oNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTAZHWjWzKv9abjH/CePc2uNxRFWpH0jwXf9oaBslEk=;
        b=py4Ukoo94G4H8aIyR8iJyXpHhi5WZRqDNFGE+LBoLIUTPLszJoaiZn5H0tv4g8gyco
         b1LHD1pJb0wcO/sx3pbs7Png38G5or5fwyb+/Wd/NkC43KiWKjdASNf8YeLQhhKHhdfw
         2HSd4hQ5O1W+9SEVOzsQ7TDnpHFYUvmGA9s6VliFHn2JKZ9DyTPPCvgeyfWufIXKgKvN
         QWf9EOYJCHaCpvzezh8MAoHXvOSXG/ATqy8lN9HWNRkYq57EJggSPjt4C9yjqxzlGICM
         60jPkNtbfkonnYSvCChkWYpDqRAFjYp1zrMPP/p5I2XkN348DgkyCmJRJrAafoxG4ZEz
         INyA==
X-Gm-Message-State: AOAM530RzvDX5/StX07+blqcLe5XmjmZSonLrDgic4NpRv1gLHhj5AEJ
        vOqEWDCTD5lzLgLM4wQy0/A=
X-Google-Smtp-Source: ABdhPJyMVofh7B70gEi2jn+sR09JvGEkYknTmIM1iZa3iWtNrt84+83IuCDFCljQ057oQlaZ4QVa9g==
X-Received: by 2002:a63:1d1:: with SMTP id 200mr16570844pgb.290.1642677749707;
        Thu, 20 Jan 2022 03:22:29 -0800 (PST)
Received: from localhost.localdomain ([58.100.34.57])
        by smtp.gmail.com with ESMTPSA id x18sm2998989pfh.192.2022.01.20.03.22.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jan 2022 03:22:29 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v9 1/5] unpack-objects: low memory footprint for get_data() in dry_run mode
Date:   Thu, 20 Jan 2022 19:21:10 +0800
Message-Id: <20220120112114.47618-2-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gc288e771b4.agit.6.5.6
In-Reply-To: <20220108085419.79682-1-chiyutianyi@gmail.com>
References: <20220108085419.79682-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

As the name implies, "get_data(size)" will allocate and return a given
size of memory. Allocating memory for a large blob object may cause the
system to run out of memory. Before preparing to replace calling of
"get_data()" to unpack large blob objects in latter commits, refactor
"get_data()" to reduce memory footprint for dry_run mode.

Because in dry_run mode, "get_data()" is only used to check the
integrity of data, and the returned buffer is not used at all, we can
allocate a smaller buffer and reuse it as zstream output. Therefore,
in dry_run mode, "get_data()" will release the allocated buffer and
return NULL instead of returning garbage data.

Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/unpack-objects.c        | 39 +++++++++++++++++++--------
 t/t5328-unpack-large-objects.sh | 48 +++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 11 deletions(-)
 create mode 100755 t/t5328-unpack-large-objects.sh

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295b..c6d6c17072 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -96,15 +96,31 @@ static void use(int bytes)
 	display_throughput(progress, consumed_bytes);
 }
 
+/*
+ * Decompress zstream from stdin and return specific size of data.
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
+	unsigned long bufsize;
+	void *buf;
 
 	memset(&stream, 0, sizeof(stream));
+	if (dry_run && size > 8192)
+		bufsize = 8192;
+	else
+		bufsize = size;
+	buf = xmallocz(bufsize);
 
 	stream.next_out = buf;
-	stream.avail_out = size;
+	stream.avail_out = bufsize;
 	stream.next_in = fill(1);
 	stream.avail_in = len;
 	git_inflate_init(&stream);
@@ -124,8 +140,15 @@ static void *get_data(unsigned long size)
 		}
 		stream.next_in = fill(1);
 		stream.avail_in = len;
+		if (dry_run) {
+			/* reuse the buffer in dry_run mode */
+			stream.next_out = buf;
+			stream.avail_out = bufsize;
+		}
 	}
 	git_inflate_end(&stream);
+	if (dry_run)
+		FREE_AND_NULL(buf);
 	return buf;
 }
 
@@ -325,10 +348,8 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 {
 	void *buf = get_data(size);
 
-	if (!dry_run && buf)
+	if (buf)
 		write_object(nr, type, buf, size);
-	else
-		free(buf);
 }
 
 static int resolve_against_held(unsigned nr, const struct object_id *base,
@@ -358,10 +379,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
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
@@ -397,10 +416,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
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
diff --git a/t/t5328-unpack-large-objects.sh b/t/t5328-unpack-large-objects.sh
new file mode 100755
index 0000000000..45a3316e06
--- /dev/null
+++ b/t/t5328-unpack-large-objects.sh
@@ -0,0 +1,48 @@
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
+test_no_loose () {
+	glob=dest.git/objects/?? &&
+	echo "$glob" >expect &&
+	eval "echo $glob" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success "create large objects (1.5 MB) and PACK" '
+	test-tool genrandom foo 1500000 >big-blob &&
+	test_commit --append foo big-blob &&
+	test-tool genrandom bar 1500000 >big-blob &&
+	test_commit --append bar big-blob &&
+	PACK=$(echo HEAD | git pack-objects --revs test)
+'
+
+test_expect_success 'set memory limitation to 1MB' '
+	GIT_ALLOC_LIMIT=1m &&
+	export GIT_ALLOC_LIMIT
+'
+
+test_expect_success 'unpack-objects failed under memory limitation' '
+	prepare_dest &&
+	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
+	grep "fatal: attempting to allocate" err
+'
+
+test_expect_success 'unpack-objects works with memory limitation in dry-run mode' '
+	prepare_dest &&
+	git -C dest.git unpack-objects -n <test-$PACK.pack &&
+	test_no_loose &&
+	test_dir_is_empty dest.git/objects/pack
+'
+
+test_done
-- 
2.34.1.52.gc288e771b4.agit.6.5.6

