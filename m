Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3AD1C6894
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830920; cv=none; b=PN+GZjm/Kiotl5QSnxFxeqR8sAI35FgpiIRET5nuJRdfp4WW9Eh2EKQIyElNfDh384TFTXcc/gRnZ/Exkp6P1YTlQesun9WkVLexMtphHmN6omu/8hp+cSxuhOJ54/YM5Jwq3f7lyfdqrhotmy0EQ6E4q5vEddGO5g1OtB+A49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830920; c=relaxed/simple;
	bh=6BDAIqOVJbw+Q+aCwGDSA1w/XbzURRuCetAT0vKiknE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEHdzOQ5O/jQ+nuPAUUaL0cXMxs8M9vqG3unk88XLU90my1jCCCxn+7zJZoohHPcYYFctWvtIypQ5P6HycjoYs7aHz+avCkywlj/ov7EhDsSCFdNahPGeGrfbgPjbf1C3laJB7p3sRprHnSmTUQCiJ7k2PPfKj+ET5FQiC+Sm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgxPSTEL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgxPSTEL"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70eae5896bcso1979766b3a.2
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723830918; x=1724435718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+o2DCqXbPz9PCa0342XN1fugFDXb2RorhmLWbOzFed4=;
        b=mgxPSTELSSNrM//FYzIokK18BsvdfYYl1CxxpwZxeoBaYUHGLQ+xWE0H2qBpYc6gYP
         YmCPbSiXqJQQM4tH2PE8fefQLrAHf+DXN1pbznt/90fELcKWWsxDTjSwYA2+9hu1dX3Z
         cyavRnLIUIft77qIBsdVQ0Sqg9zC5VU3cBkpRfkytJc1HcZ4XM/q9miwqZYI4VUGnOVU
         olKAq9XUlDcVMjh+kE2g5rSMCbZgjovCw3E5ezr//FHYvwtOBmwHAiIaATiTmFP5e5KN
         XixqplogFoagDtVDHVifScoMfWYwaXU6m/YOQt0EhWqnhqDnU7Kcm9efT+qGnFmEtVEH
         gWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830918; x=1724435718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+o2DCqXbPz9PCa0342XN1fugFDXb2RorhmLWbOzFed4=;
        b=K/psLeGt97cRxrjg0rtuVfbvg/7FYSpuEfuqSZvVnXkxzPTTPvWKez82Xo5l3nVa0S
         Ikp482/BAkmAGzMEdmiyrmmaoRGif+q82WvsvQl5gv8M78esPI2wbN2jnZA9poDwH3Kt
         6RMEjC5UguAsQZpc9zopa0ilvZe6Fzgn9toJnhX13eElyaEWAZTwbRhgA0sL6e871lPU
         oi6b21v3c5QHUsH4dZF6AAolnveD0XWvZZcX3HxQXRj5z55W83EGrkEx0deGq9f5zhUz
         MCsxqWFr5XN5B2audyHR8Ol0U2zwOQkBI0FLvuZqZWZ2LM4RyBBpl1+pqppWm7/14Xtv
         gn4Q==
X-Gm-Message-State: AOJu0Yxbg73SmMAmu8SvzJtkaQ2ZGIrhszh0W1czR5bznhX72VfDNzpM
	PU0iAMTeMoGBd/cFBVAZU0A2ShDqiuTueVrjdpUn90v+RuZoynTD+d79jg==
X-Google-Smtp-Source: AGHT+IE7qIZJOIJOuISREPSD8AFTDQgQpE1uU5xRjEEamKbBYb/J2VezYYXWcncBcrXKf7HnMQXgfQ==
X-Received: by 2002:a05:6a20:c90e:b0:1be:e265:81fa with SMTP id adf61e73a8af0-1c90501facamr4670938637.35.1723830918171;
        Fri, 16 Aug 2024 10:55:18 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.209])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af1e907sm2985600b3a.173.2024.08.16.10.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:55:17 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 09/11] t-reftable-block: add tests for log blocks
Date: Fri, 16 Aug 2024 22:55:32 +0530
Message-ID: <20240816175414.5169-10-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240816175414.5169-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240816175414.5169-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup, block operations are only exercised
for ref blocks. Add another test that exercises these operations
for log blocks as well.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 92 ++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 6aa86a3edf..1256c7df6a 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -12,7 +12,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/reftable-error.h"
 
-static void t_block_read_write(void)
+static void t_ref_block_read_write(void)
 {
 	const int header_off = 21; /* random */
 	struct reftable_record recs[30];
@@ -103,9 +103,97 @@ static void t_block_read_write(void)
 		reftable_record_release(&recs[i]);
 }
 
+static void t_log_block_read_write(void)
+{
+	const int header_off = 21;
+	struct reftable_record recs[30];
+	const size_t N = ARRAY_SIZE(recs);
+	const size_t block_size = 2048;
+	struct reftable_block block = { 0 };
+	struct block_writer bw = {
+		.last_key = STRBUF_INIT,
+	};
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_LOG,
+	};
+	size_t i = 0;
+	int ret;
+	struct block_reader br = { 0 };
+	struct block_iter it = BLOCK_ITER_INIT;
+	struct strbuf want = STRBUF_INIT;
+
+	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	block.len = block_size;
+	block.source = malloc_block_source();
+	block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
+			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
+
+	for (i = 0; i < N; i++) {
+		rec.u.log.refname = xstrfmt("branch%02"PRIuMAX , (uintmax_t)i);
+		rec.u.log.update_index = i;
+		rec.u.log.value_type = REFTABLE_LOG_UPDATE;
+
+		recs[i] = rec;
+		ret = block_writer_add(&bw, &rec);
+		rec.u.log.refname = NULL;
+		rec.u.log.value_type = REFTABLE_LOG_DELETION;
+		check_int(ret, ==, 0);
+	}
+
+	ret = block_writer_finish(&bw);
+	check_int(ret, >, 0);
+
+	block_writer_release(&bw);
+
+	block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
+
+	block_iter_seek_start(&it, &br);
+
+	for (i = 0; ; i++) {
+		ret = block_iter_next(&it, &rec);
+		check_int(ret, >=, 0);
+		if (ret > 0) {
+			check_int(i, ==, N);
+			break;
+		}
+		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+	}
+
+	for (i = 0; i < N; i++) {
+		block_iter_reset(&it);
+		strbuf_reset(&want);
+		strbuf_addstr(&want, recs[i].u.log.refname);
+
+		ret = block_iter_seek_key(&it, &br, &want);
+		check_int(ret, ==, 0);
+
+		ret = block_iter_next(&it, &rec);
+		check_int(ret, ==, 0);
+
+		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+
+		want.len--;
+		ret = block_iter_seek_key(&it, &br, &want);
+		check_int(ret, ==, 0);
+
+		ret = block_iter_next(&it, &rec);
+		check_int(ret, ==, 0);
+		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
+	}
+
+	block_reader_release(&br);
+	block_iter_close(&it);
+	reftable_record_release(&rec);
+	reftable_block_done(&br.block);
+	strbuf_release(&want);
+	for (i = 0; i < N; i++)
+		reftable_record_release(&recs[i]);
+}
+
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(t_block_read_write(), "read-write operations on blocks work");
+	TEST(t_log_block_read_write(), "read-write operations on log blocks work");
+	TEST(t_ref_block_read_write(), "read-write operations on ref blocks work");
 
 	return test_done();
 }
-- 
2.45.GIT

