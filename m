Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3F13C699
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503566; cv=none; b=sTbaxoKAOtWqBso3U6TDb9GbiPpsnUxAJd6Eu3WuInEXfQuYRPe2tRsAP0vNT4zZnkVRqvnjKjr0h4ZMuYv2yr5oTCjSIQjAKd1WNOkKQ1JddaWAAzVMXeWZ14x7cx2wxr7nppVZkbWxnjOpAqeLsQN0muZTfYCK/QiHcghXx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503566; c=relaxed/simple;
	bh=itnQfu0Oi8TL0VxbM6VKsYi7tx9KSFBzORCo2kprD5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKI9Vu1e4YIn8vvDIicGsoQNOoxYb1fhz1RR9RvzvFs7HJyIz9SvQolpDZQaw8z3853pfG4dXGnKT0Ua7kvnb6XkoS9AyRtWujDoHgCRPqWO+alPgj+ZPTvWI19X8l62hTsyVU0NrkeFChwdrRCBJSjCuA5dFY10TXZZtKPBp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Weg2WsS/; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Weg2WsS/"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64f4c11d2c9so37395147b3.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 22:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720503563; x=1721108363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvk7yyAF333g6TbWR0aaykoBlxXr8ejFrK6DYgyVXh4=;
        b=Weg2WsS/QYECk3Eu/BcmhxzFRIY2wj8ajK5Ub/85R1djGKK0GVbiXk6kDBAWOBAw0c
         4mTwkCDZT7hWpQ77d7sNby+W/Y6Isg3Pgq2IAvI5iw9vp4qZaxt2xlguRfNx+By9NUEV
         vXeQpxuUWTmdBLL7ilVWMsKQQMai6V1IsgwhetIbHa+LnC3ubvgi+NYYstlJglaJbeV1
         KaR6V3aj2UIL1cVsHstUEsQCBqBZaP7cZD1vhHRGeE6apETgVcXBtl6QGQDLhqFBLTev
         c9MfW5otJeRP/X3OzclYQ9lokV5YPUQr9Qrjr+dF4m829LgNuaCFB3sY1fB2QDBGyF+w
         uCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720503563; x=1721108363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yvk7yyAF333g6TbWR0aaykoBlxXr8ejFrK6DYgyVXh4=;
        b=Y+7aw9PeTDiNIX5wSd+e9maJpMCOVX4Dkd31L/4EhGhcPGCL30fb33/S7y8MJmyk97
         3TIlZclzdmDcBvRq7pqStB88c9YEoCT2PhhkRgaEiAgxiOH6q3+1F8PwNqoxI1/lIvbS
         fFZUkroFj1/fK21fRGDyBjl61I8s3/WqOfjhEFpJFS3EpvC2VQUS/XLJj5atHPym9vP1
         f9ibW0w+bdvQ2YnyBlZJaa4aGkfmJM+pgasenL2GHKdt7u61bH7Ea7HNR6I3f1m1jlt0
         H2pNSSboI0tvGmxMEmbipPOEHNN8zXKqD669M2Xw1ljTpgUxKV+3zJmEGAr9DqFEpg/I
         FoOg==
X-Gm-Message-State: AOJu0Yz9n2T/XYsPYl377iDUju3phmUkoOZcp2SBOIkkbMtf+dxyMZmn
	VXNrl8Hy+Ld0x92a63iDroc1oMhD5eZnA2eMzQvZHy8Q6EeooSwO7vR+CQ==
X-Google-Smtp-Source: AGHT+IGwukvIqcsRyGCN546k6vro4TGhvt5i0E7iKvcybaUyrpYwpA8qjc88XwShYuGvk+k1vg/9zg==
X-Received: by 2002:a05:690c:b8d:b0:650:11d9:b65a with SMTP id 00721157ae682-658f09d2252mr23397907b3.32.1720503563355;
        Mon, 08 Jul 2024 22:39:23 -0700 (PDT)
Received: from Ubuntu.. ([117.96.144.60])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-77d61922ee6sm718448a12.46.2024.07.08.22.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 22:39:22 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	karthik.188@gmail.com
Subject: [PATCH v2 2/7] t: harmonize t-reftable-merged.c with coding guidelines
Date: Tue,  9 Jul 2024 10:58:41 +0530
Message-ID: <20240709053847.4453-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240709053847.4453-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
 <20240709053847.4453-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Harmonize the newly ported test unit-tests/t-reftable-merged.c
with the following guidelines:
- Single line control flow statements like 'for' and 'if'
  must omit curly braces.
- Structs must be 0-initialized with '= { 0 }' instead of '= { NULL }'.
- Array indices must be of type 'size_t', not 'int'.
- It is fine to use C99 initial declaration in 'for' loop.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 52 ++++++++++++--------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 78a864a54f..a984116619 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -40,12 +40,10 @@ static void write_test_table(struct strbuf *buf,
 	struct reftable_writer *w = NULL;
 	for (i = 0; i < n; i++) {
 		uint64_t ui = refs[i].update_index;
-		if (ui > max) {
+		if (ui > max)
 			max = ui;
-		}
-		if (ui < min) {
+		if (ui < min)
 			min = ui;
-		}
 	}
 
 	w = reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
@@ -68,7 +66,6 @@ static void write_test_log_table(struct strbuf *buf,
 				 struct reftable_log_record logs[], int n,
 				 uint64_t update_index)
 {
-	int i = 0;
 	int err;
 
 	struct reftable_write_options opts = {
@@ -79,7 +76,7 @@ static void write_test_log_table(struct strbuf *buf,
 	w = reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
 	reftable_writer_set_limits(w, update_index, update_index);
 
-	for (i = 0; i < n; i++) {
+	for (int i = 0; i < n; i++) {
 		int err = reftable_writer_add_log(w, &logs[i]);
 		check(!err);
 	}
@@ -121,8 +118,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 
 static void readers_destroy(struct reftable_reader **readers, size_t n)
 {
-	int i = 0;
-	for (; i < n; i++)
+	for (size_t i = 0; i < n; i++)
 		reftable_reader_free(readers[i]);
 	reftable_free(readers);
 }
@@ -148,9 +144,8 @@ static void t_merged_single_record(void)
 	struct reftable_reader **readers = NULL;
 	struct reftable_merged_table *mt =
 		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
-	int i;
-	struct reftable_ref_record ref = { NULL };
-	struct reftable_iterator it = { NULL };
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_iterator it = { 0 };
 	int err;
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
@@ -164,9 +159,8 @@ static void t_merged_single_record(void)
 	reftable_iterator_destroy(&it);
 	readers_destroy(readers, 2);
 	reftable_merged_table_free(mt);
-	for (i = 0; i < ARRAY_SIZE(bufs); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
 		strbuf_release(&bufs[i]);
-	}
 	reftable_free(bs);
 }
 
@@ -226,12 +220,12 @@ static void t_merged_refs(void)
 	struct reftable_reader **readers = NULL;
 	struct reftable_merged_table *mt =
 		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
-	struct reftable_iterator it = { NULL };
+	struct reftable_iterator it = { 0 };
 	int err;
 	struct reftable_ref_record *out = NULL;
 	size_t len = 0;
 	size_t cap = 0;
-	int i = 0;
+	size_t i;
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
 	err = reftable_iterator_seek_ref(&it, "a");
@@ -240,7 +234,7 @@ static void t_merged_refs(void)
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
 
 	while (len < 100) { /* cap loops/recursion. */
-		struct reftable_ref_record ref = { NULL };
+		struct reftable_ref_record ref = { 0 };
 		int err = reftable_iterator_next_ref(&it, &ref);
 		if (err > 0)
 			break;
@@ -251,18 +245,15 @@ static void t_merged_refs(void)
 	reftable_iterator_destroy(&it);
 
 	check_int(ARRAY_SIZE(want), ==, len);
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < len; i++)
 		check(reftable_ref_record_equal(want[i], &out[i],
 						 GIT_SHA1_RAWSZ));
-	}
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < len; i++)
 		reftable_ref_record_release(&out[i]);
-	}
 	reftable_free(out);
 
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < 3; i++)
 		strbuf_release(&bufs[i]);
-	}
 	readers_destroy(readers, 3);
 	reftable_merged_table_free(mt);
 	reftable_free(bs);
@@ -358,12 +349,12 @@ static void t_merged_logs(void)
 	struct reftable_reader **readers = NULL;
 	struct reftable_merged_table *mt = merged_table_from_log_records(
 		logs, &bs, &readers, sizes, bufs, 3);
-	struct reftable_iterator it = { NULL };
+	struct reftable_iterator it = { 0 };
 	int err;
 	struct reftable_log_record *out = NULL;
 	size_t len = 0;
 	size_t cap = 0;
-	int i = 0;
+	size_t i = 0;
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
 	err = reftable_iterator_seek_log(&it, "a");
@@ -372,7 +363,7 @@ static void t_merged_logs(void)
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
 
 	while (len < 100) { /* cap loops/recursion. */
-		struct reftable_log_record log = { NULL };
+		struct reftable_log_record log = { 0 };
 		int err = reftable_iterator_next_log(&it, &log);
 		if (err > 0)
 			break;
@@ -383,10 +374,9 @@ static void t_merged_logs(void)
 	reftable_iterator_destroy(&it);
 
 	check_int(ARRAY_SIZE(want), ==, len);
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < len; i++)
 		check(reftable_log_record_equal(want[i], &out[i],
 						 GIT_SHA1_RAWSZ));
-	}
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
 	err = reftable_iterator_seek_log_at(&it, "a", 2);
@@ -397,14 +387,12 @@ static void t_merged_logs(void)
 	check(reftable_log_record_equal(&out[0], &r3[0], GIT_SHA1_RAWSZ));
 	reftable_iterator_destroy(&it);
 
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < len; i++)
 		reftable_log_record_release(&out[i]);
-	}
 	reftable_free(out);
 
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < 3; i++)
 		strbuf_release(&bufs[i]);
-	}
 	readers_destroy(readers, 3);
 	reftable_merged_table_free(mt);
 	reftable_free(bs);
@@ -422,7 +410,7 @@ static void t_default_write_opts(void)
 		.update_index = 1,
 	};
 	int err;
-	struct reftable_block_source source = { NULL };
+	struct reftable_block_source source = { 0 };
 	struct reftable_table *tab = reftable_calloc(1, sizeof(*tab));
 	uint32_t hash_id;
 	struct reftable_reader *rd = NULL;
-- 
2.45.2.404.g9eaef5822c

