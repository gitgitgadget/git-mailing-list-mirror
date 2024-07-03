Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB991849DF
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026740; cv=none; b=ZlJoHeJp05+ARU6edcozaUaVpFBskMUve6uP5lLj/w4EWTMiGL+YI7Zp2GF9h0zk/twaQ9gpvSPmP9NbC4qDl3ZEtcfvd2q7ys4n8ssFlQuYw7XAZxiSmhaH3nuE1T7/8ex6SI9HVl0Kzukp6w+Wu1htvE8ZPwFA8pyf/J82keI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026740; c=relaxed/simple;
	bh=Sv8sY0HCo+TNmEWlreQTRco7HIzEiWZfuDUOSLkpolM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Akrs5Cgupma7VpnNERvHDp2PeNIFRsVeZMAZ9W9LEzbw38gfECQDQ47E3ZDGO9Fezg9Tv18H0u4VVQ53qDOptwR29cgJViZdwYcTexV46xBpXMTcbFnpxszghAwo/IoUP1wGsO8eEiP+v3TGZT/gqpPguP9TSOHnaP4EOXK9Yyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwsuBX+H; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwsuBX+H"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-70b2421471aso3550613a12.0
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026737; x=1720631537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqvizdpcOzly+bK5Xnz5ZpguxaCBrn5V8w7Bq+KOgHY=;
        b=HwsuBX+Hz+P1CzJlOOxeVw36ZYOMPr0oELiuLQuJCX0Vh201Pa13iHdMmQWUoFhcfn
         55baAMF3IerVWucY/JpTcGcwJ2daQyd4jMXIPi1qelzXI/CWDA//S6Q+v8uGPgPOSxXp
         513wPiXiSPxIH6pnEPZG7U4P52qt+HhkU2jvS6lET1RqADwaQZmfhBLlRBKtcTLFJws6
         h55YQwd/SMwoGU9nJH82MFvuxXJrx/JI4IWElOyXCS4wGp9i1wc95JoWSUm0ioscn9Y/
         6VeomaQLxRTSyRAgJs5qBLMmpve98W0TO36Cq5og+o+gdIGPa3bJFgIWQ4JziiZKBnUX
         MFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026737; x=1720631537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqvizdpcOzly+bK5Xnz5ZpguxaCBrn5V8w7Bq+KOgHY=;
        b=nJ+CiUaqEfg0aUvioY2UCwrRIdo5mEcBGQBQDUosjs2dqV6llIf8lJ5g5OTRODio/t
         AXPJGwIVNU9551oJgkiXPyd8aV+3+ClEqGx2I04FK6Mv7LCn2kM8VcsQJy13IDViubRB
         HkD5vzfwlls2nJhN85NgITLe6w9xIno6kqFVBmU+UJ10jCRhPG8z3DJEJF4f9oih/3fV
         qumdGnFI2PQf2yN3/BlD6LHy5lCYmHjvgiNrwhtLclkqn2aAVw8OBj9UWcKV4hh9PhTB
         Fs66wJch+V0twVl5ucKRqa28niiu2RZJzUn9G62nX6Ox8s2tAbqZBQvnKVoHgof6/nAo
         C+Sw==
X-Gm-Message-State: AOJu0Yyt0W0XSZK929CKX8v2IV6iLEC4xOCQjXw4nzPYhZV7ZP7Zb/yQ
	69p9mRkfjY2hJBdNluYBUQp3TSaHIhRVkfDvzmZX0DlEhHifQQeBSKN3+Q==
X-Google-Smtp-Source: AGHT+IG2mhJ2gRgaSYntCiPO11Sldu4+wmKpLlUlCJFV+PClEPRnP9BIJZulwCKuNXiLkW82E9XLpA==
X-Received: by 2002:a05:6a20:7348:b0:1be:bf38:7b1b with SMTP id adf61e73a8af0-1bef61201a6mr12559932637.33.1720026737214;
        Wed, 03 Jul 2024 10:12:17 -0700 (PDT)
Received: from Ubuntu.. ([223.176.57.184])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70803ecf966sm10678860b3a.124.2024.07.03.10.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:12:16 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 2/5] t: harmonize t-reftable-merged.c with coding guidelines
Date: Wed,  3 Jul 2024 22:31:42 +0530
Message-ID: <20240703171131.3929-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240703171131.3929-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
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
index 1718489f06..28bf6f6696 100644
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
@@ -148,9 +144,8 @@ static void t_merged_between(void)
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
@@ -164,9 +159,8 @@ static void t_merged_between(void)
 	reftable_iterator_destroy(&it);
 	readers_destroy(readers, 2);
 	reftable_merged_table_free(mt);
-	for (i = 0; i < ARRAY_SIZE(bufs); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
 		strbuf_release(&bufs[i]);
-	}
 	reftable_free(bs);
 }
 
@@ -226,12 +220,12 @@ static void t_merged(void)
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
@@ -240,7 +234,7 @@ static void t_merged(void)
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
 
 	while (len < 100) { /* cap loops/recursion. */
-		struct reftable_ref_record ref = { NULL };
+		struct reftable_ref_record ref = { 0 };
 		int err = reftable_iterator_next_ref(&it, &ref);
 		if (err > 0)
 			break;
@@ -251,18 +245,15 @@ static void t_merged(void)
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

