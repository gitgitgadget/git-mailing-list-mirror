Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6677018044
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763483; cv=none; b=uy1dFqnoI4kJHhsIaQiAsUsIHrJExqWqGPygghjkSLcC4bJZOB9HzEp8eL4/sUZXaSh4JYyLpRN7ifgK05nTrJNGOVoXvAucg2rZUdnaJ0q2zGyUGrS9gDWsR1SMaI8vrYyfPTVHyHbFPIIW7MGepvqtwHI9DO3PnSqwg6zkJEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763483; c=relaxed/simple;
	bh=x9qTqgFDH8brbGUfMgATpo/0EY6VjEh1JxT3a4iyHjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXJM9Rn0vDwzH0r+5UeaWD/zYvZVj6ZdaKAQzhAhZ9r0huL+E6gmWRGc2K4n1GRBElp9daWcR7QbrZPgPw5G0T86v8troM+GfjRmEAH3wuQeJIMsrw5RN2Cmk2SEKQa6GlxcMR63306JzhfWQtkH3WgDjRUcd+drMGttwIr4ch4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUBuuWll; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUBuuWll"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b5117ae06so1257953b3a.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 22:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720763480; x=1721368280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ3CxG+DYTEAVgOP0dqoO8ewH480oDIKciMtDvo1YO0=;
        b=jUBuuWllIZH/UMZtWSvWwR46D4VyrSTcMWo8kdoKL/bV8zQQ84ezjOpCADwcb4Tb94
         uO7Zoq7JfJvelCiMywkFYC/5bBtLBloiSi5I0XrMcsIc5R9UzaVIBL3D1zo9i+2GcG4K
         ymoyIekpLC/6dPOOfGnRirXh9L6qchU0qLJdEa7o69fot+075xT/u4SO2xqFGv8y6LSW
         u8KzxfFWx04ivMkNhMvdFVaMocURFN5/RywlJ9qXGbvii6/HGY/b4wrX3to6j9Ll79GN
         ZAFDCyA9p7rgSH/lfJz1BLV+N7Kuvg3F2XY9NmiVN97O1MYf1M9038usepKCAIK/xdUb
         1HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720763480; x=1721368280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZ3CxG+DYTEAVgOP0dqoO8ewH480oDIKciMtDvo1YO0=;
        b=Ht+1LD2ykAcD0yjKgMqziQg2qsFlp2jykNatkbKqdD1xUYj+pvUUO7O44Urya4cD/9
         lPiO2Mq2SOjOCk/Dc5pzr+KNoDKXP5Vx0eVPf9nfwKeJnPQAFFUlT4AoczEFtFEWlrRG
         KafoIGaNH28r7cbTXLdGUpeGtgu65i7lfZFo81EVQ4Lgs21gJUtSgKfHw/lOfqfQynp3
         rOsSdqnYYTlLvn9KzB+1S4aYtiCVU8ML7iml/N2CoWvwz/gUlCTvZcV3gNQFgCIKDQit
         RgB9D03YpGGTRQhKSgKS5fu3GZWOTpzA/XcCaYUpgQzsS4skw5BbBndl/jiCF3WMParq
         Zv5w==
X-Gm-Message-State: AOJu0YyPDRjQ5TxjgzjNp3dMfIyOSxJBRNoAIKQwnhoo7FSocMyAQGgy
	2m1cl4in0aABZ7zHtwoF0/Jl7u18PkfzflGM0931oZZ+4nA1C96dCb+bIQ==
X-Google-Smtp-Source: AGHT+IFd3fu2EyfTv1XNKpRd552wFF5Hut/dLwgfiIgZICWOZK4tNloK7CABUYTsH3rQcsQRpVJpcQ==
X-Received: by 2002:a05:6a00:1810:b0:706:7276:6287 with SMTP id d2e1a72fcca58-70b434f34c8mr13949125b3a.1.1720763480199;
        Thu, 11 Jul 2024 22:51:20 -0700 (PDT)
Received: from Ubuntu.. ([117.96.148.106])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b4397f475sm6604651b3a.150.2024.07.11.22.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:51:19 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v4 2/7] t: harmonize t-reftable-merged.c with coding guidelines
Date: Fri, 12 Jul 2024 11:08:58 +0530
Message-ID: <20240712055041.6476-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240712055041.6476-1-chandrapratap3519@gmail.com>
References: <20240711040854.4602-1-chandrapratap3519@gmail.com>
 <20240712055041.6476-1-chandrapratap3519@gmail.com>
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
- Array indices should preferably be of type 'size_t', not 'int'.
- It is fine to use C99 initial declaration in 'for' loop.

While at it, use 'ARRAY_SIZE(x)' to store the number of elements
in an array instead of hardcoding them.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 68 +++++++++++++-------------------
 1 file changed, 28 insertions(+), 40 deletions(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 78a864a54f..9791f53418 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -27,11 +27,11 @@ static int noop_flush(void *arg)
 }
 
 static void write_test_table(struct strbuf *buf,
-			     struct reftable_ref_record refs[], int n)
+			     struct reftable_ref_record refs[], size_t n)
 {
 	uint64_t min = 0xffffffff;
 	uint64_t max = 0;
-	int i = 0;
+	size_t i;
 	int err;
 
 	struct reftable_write_options opts = {
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
@@ -65,10 +63,9 @@ static void write_test_table(struct strbuf *buf,
 }
 
 static void write_test_log_table(struct strbuf *buf,
-				 struct reftable_log_record logs[], int n,
+				 struct reftable_log_record logs[], size_t n,
 				 uint64_t update_index)
 {
-	int i = 0;
 	int err;
 
 	struct reftable_write_options opts = {
@@ -79,7 +76,7 @@ static void write_test_log_table(struct strbuf *buf,
 	w = reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
 	reftable_writer_set_limits(w, update_index, update_index);
 
-	for (i = 0; i < n; i++) {
+	for (size_t i = 0; i < n; i++) {
 		int err = reftable_writer_add_log(w, &logs[i]);
 		check(!err);
 	}
@@ -93,7 +90,7 @@ static void write_test_log_table(struct strbuf *buf,
 static struct reftable_merged_table *
 merged_table_from_records(struct reftable_ref_record **refs,
 			  struct reftable_block_source **source,
-			  struct reftable_reader ***readers, int *sizes,
+			  struct reftable_reader ***readers, size_t *sizes,
 			  struct strbuf *buf, size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
@@ -121,8 +118,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 
 static void readers_destroy(struct reftable_reader **readers, size_t n)
 {
-	int i = 0;
-	for (; i < n; i++)
+	for (size_t i = 0; i < n; i++)
 		reftable_reader_free(readers[i]);
 	reftable_free(readers);
 }
@@ -142,15 +138,14 @@ static void t_merged_single_record(void)
 	} };
 
 	struct reftable_ref_record *refs[] = { r1, r2 };
-	int sizes[] = { 1, 1 };
+	size_t sizes[] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2) };
 	struct strbuf bufs[2] = { STRBUF_INIT, STRBUF_INIT };
 	struct reftable_block_source *bs = NULL;
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
 
@@ -220,18 +214,18 @@ static void t_merged_refs(void)
 	};
 
 	struct reftable_ref_record *refs[] = { r1, r2, r3 };
-	int sizes[3] = { 3, 1, 2 };
+	size_t sizes[3] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
 	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
 	struct reftable_block_source *bs = NULL;
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
@@ -271,7 +262,7 @@ static void t_merged_refs(void)
 static struct reftable_merged_table *
 merged_table_from_log_records(struct reftable_log_record **logs,
 			      struct reftable_block_source **source,
-			      struct reftable_reader ***readers, int *sizes,
+			      struct reftable_reader ***readers, size_t *sizes,
 			      struct strbuf *buf, size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
@@ -352,18 +343,18 @@ static void t_merged_logs(void)
 	};
 
 	struct reftable_log_record *logs[] = { r1, r2, r3 };
-	int sizes[3] = { 2, 1, 1 };
+	size_t sizes[3] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
 	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
 	struct reftable_block_source *bs = NULL;
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
+	size_t i;
 
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
2.45.GIT

