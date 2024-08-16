Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4771C68A5
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830926; cv=none; b=KIAfqjYkMdCucjNqglXRTqngFXMnotCbP+ikwS5GkLmUYqjMtFuG1bLxbYqy3McsNqxL+ulPLg14tAtw1ULOA0o1M7yvNhUeBUD3Ve4S/Seiv91QXdKOkxHWs1EftY5kgD7sTMX6YXmTZoekVJJr0SGE6hiPFC/2NmjthupWjPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830926; c=relaxed/simple;
	bh=jWCvz37HxYRsW1HkF37FzDUtF3hxdTUH3I+E5qapNCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtHQcT8wC91TozEpLlLpJ5myoWKp7FC9q0y3zNez1pSDBgHhtwAigjyw+p/XBN+9GE0NhlJejdQ4VjinX9SjobkB6xWWBqwVWPgSVDzlm5a1b/Me0sosV1ZJ4MeCoo7POUOCdJdyYGValCXDrbZF3TJASIbx1vd9z0cpmsnHwl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQBDOYqN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQBDOYqN"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7126d62667bso1466172b3a.3
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723830923; x=1724435723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBAGzow4IBdSCx+zdMkCm4RQTjz4LEzlEDC2srhwpbE=;
        b=eQBDOYqNUIDerQINPwhb+WvMMpHRDWLXASxI0PxKwI0hX/uXNEudILqVqWpuYuHO4q
         18ZXMWGRq8i0sNBXVaxrggqPg5h15ToRu00N6LA7Jxk6Ro11Y7eyuROyI6Wh5/ikcQBq
         6D5gX9DX+C4zup3WU4fNAj2GiX7sG0pqNPSw8JYjE1ajCRqfzqYho6nCk2y7rf8CbvaQ
         KmiLkd3f6w6DcR8EjyJ26UkZbTU9BGnBXhBaNRxPYj/864oyDrygGgq1emJzQmG/Earm
         lvFfG1aJcZ7FgpENp7UM8EnxQskb4fSBHQwc85ASvfypiq73MV2pkjufJAYPADYZ2WDy
         azLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830923; x=1724435723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBAGzow4IBdSCx+zdMkCm4RQTjz4LEzlEDC2srhwpbE=;
        b=AtDDZADK0kyqYbYd/OkGQYQSim98kdE/BE/DYXuLccm2bCg0Imgd8Wgk79ZLGirA3a
         JCbQ4ZU5BcgJ+jjDvCdfjLx9viWmsibbgn7KUNvp/PqhFlevJTA1ApxodeVzVbFDlk4k
         VFmLkjL8qRIz5NJJVvrBHWY13ulZsYmrSf83oCWy3YCClghW/s05QQY9yi6JWhmR3s3X
         sIuN2dP4KWO0km6K9D18QpUU64An9cTYr9d65+ToU/94Dujzc94m5anFMivwzhNaqOFY
         s7mH/LLaXTKUEkK7p57LSBJSiBaTLQlrDKjlC6zZiKSvuWxazIDvDovRLANI2g1wh9M5
         yu/A==
X-Gm-Message-State: AOJu0YzcGKZOgRekI0Vk6MsInMO+9+RhRbQCHZA9nL+mRtnazxXbVilY
	3Cjfv4v0/g2eyl3usZUBAxG/z5XpOY2ee9qyzJJdPZWailQyyqCKyqm3HA==
X-Google-Smtp-Source: AGHT+IF/7EQc1b/0WgrQhWG1EoKIEqhsOZhfloAgAVDAw9JPCZe1faHs3B3sjJF8OQUT3bVxSfIdzg==
X-Received: by 2002:a05:6a00:85a9:b0:70d:39d9:4523 with SMTP id d2e1a72fcca58-713c4e08726mr3455541b3a.7.1723830923392;
        Fri, 16 Aug 2024 10:55:23 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.209])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af1e907sm2985600b3a.173.2024.08.16.10.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:55:23 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 11/11] t-reftable-block: add tests for index blocks
Date: Fri, 16 Aug 2024 22:55:34 +0530
Message-ID: <20240816175414.5169-12-chandrapratap3519@gmail.com>
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

In the current testing setup, block operations are left unexercised
for index blocks. Add a test that exercises these operations for
index blocks.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 87 +++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 7671a40969..c2b67a11bc 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -271,8 +271,95 @@ static void t_obj_block_read_write(void)
 		reftable_record_release(&recs[i]);
 }
 
+static void t_index_block_read_write(void)
+{
+	const int header_off = 21;
+	struct reftable_record recs[30];
+	const size_t N = ARRAY_SIZE(recs);
+	const size_t block_size = 1024;
+	struct reftable_block block = { 0 };
+	struct block_writer bw = {
+		.last_key = STRBUF_INIT,
+	};
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_INDEX,
+		.u.idx.last_key = STRBUF_INIT,
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
+	block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
+			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
+
+	for (i = 0; i < N; i++) {
+		strbuf_init(&recs[i].u.idx.last_key, 9);
+
+		recs[i].type = BLOCK_TYPE_INDEX;
+		strbuf_addf(&recs[i].u.idx.last_key, "branch%02"PRIuMAX, (uintmax_t)i);
+		recs[i].u.idx.offset = i;
+
+		ret = block_writer_add(&bw, &recs[i]);
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
+		reftable_record_key(&recs[i], &want);
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
+	TEST(t_index_block_read_write(), "read-write operations on index blocks work");
 	TEST(t_log_block_read_write(), "read-write operations on log blocks work");
 	TEST(t_obj_block_read_write(), "read-write operations on obj blocks work");
 	TEST(t_ref_block_read_write(), "read-write operations on ref blocks work");
-- 
2.45.GIT

