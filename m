Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1291B14E0
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637556; cv=none; b=LDCNwMocSYbrOeLfGGKlNdCqRs68jSliPjK6rW/K9sQ3RNSGufBU/IScVHI6Dfts6PbQmByViDbCTEeZXkw92xm6UPwdk4gtNH0LzUcmQEAo31JKRRmRHUhaQHzrzyVbyOtRAnHRLT9N26iuuu64ZoYEE/tsGngQ6U3N+8C2ANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637556; c=relaxed/simple;
	bh=jCmSlQsEALm46t1imMVvfax0xwT6yTFSzu5OXBU/zPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUStu+4L4fcd9ZWqj/bP1HbgRTwjURRuUhZhoCdR0K5NGGCRZ0f6N+ymnjYChGQQ2u8Q0V4FPcBtJg4IsP02Eqgmd5IhOpjL6dVW2UTQWEeth6uQPbj4RskHHLgzFZ1nzDrncrNpLn6UntgzUOgpTwa7pnOhj8aa7owEN1whX3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Koz5mXVe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Koz5mXVe"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-710dc3015bfso632605b3a.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723637554; x=1724242354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SalHpdCC/cBvZJeQzsN38DRBcGIUfg1wbGKqy+JZGqk=;
        b=Koz5mXVeTVRjxCLD90P6S97aEM4gRKbbo2zlszT7a1FjkbqQnV2yfkOf1ko6vE1tKV
         6cQxj1q34i3Wox5BhbBgWWIwmZlacHcHN892eY0CD3CWdLXXOLvfiHTn5zorbDQewDSv
         DZZQXiP6nL9/pN3wSijLvM93Et+MnFbxMXGBEQr9uzudWH1frjYTqGCopWwdv3F8gOq4
         0//Z4Ddrn0A3VfwQ66QKyg5ISUQcH++ja2hrtMCDjEQC15+5/vyVd8OPj1V4DWsecaSS
         khSoP+ID8PpnVGfQLARlgGl0B3piJMWh8a4OViP0tY+qezjYxXYYTPEI4BSTQwoS+g0f
         SPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637554; x=1724242354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SalHpdCC/cBvZJeQzsN38DRBcGIUfg1wbGKqy+JZGqk=;
        b=N2GPOub0PKWbPVZrmbWgDW4a/SPLesF7xFIcIpaknzngp7ssEs6M1R9WS23euiBUPZ
         r6b++PrzXIO943ab0k/IlV2E5urb3R5gQx+gOo9TE5sOk8/cWXKWVD0gRO29q5P3oZ7X
         Ie8FRBaZBVcceGyiX4Y9jRXZfC7I/tNPPFm40EoDSQIJNgnUkLoNb2bjgXJomSnblzsN
         nRBfTCiSSWNrItS3R+hbl2tEuP6El/mDe7cZvTtkh7TJxVHtR78sDRcZwE2ULJ//30e7
         otVsgZ9w4ALt5FThTp74hvKLzdyaB745c5LtkHi4Vfbj0BMd3jLuqGbOM9lVCiEhwulP
         stCQ==
X-Gm-Message-State: AOJu0Yyc/aMkaRzrOTjhtH8bTK5xhapDWUbpgDf+euq2hrf82RHHQh9F
	kAyH4VLmiqXzqjbBDfWInz7hA/iIDxJ4jp0IftFuLyn/Vvbyp9fiyKsi2nKsWsE=
X-Google-Smtp-Source: AGHT+IF18BHzIaZhR2ikYC64/1x2dhGiou6nFXH33V4UXkB9OKdiniYY033mSEe4y54NLL6vUhshvQ==
X-Received: by 2002:aa7:88cd:0:b0:70d:2709:3b53 with SMTP id d2e1a72fcca58-7126a42247cmr3522777b3a.4.1723637553680;
        Wed, 14 Aug 2024 05:12:33 -0700 (PDT)
Received: from Ubuntu.. ([106.205.236.194])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5875200sm7195450b3a.37.2024.08.14.05.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:12:33 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/10] t-reftable-block: add tests for obj blocks
Date: Wed, 14 Aug 2024 17:33:17 +0530
Message-ID: <20240814121122.4642-10-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240814121122.4642-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup, block operations are left unexercised
for obj blocks. Add a test that exercises these operations for obj
blocks.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 79 +++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 01ef10e7a6..34d37fe1a7 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -186,9 +186,88 @@ static void t_log_block_read_write(void)
 		reftable_record_release(&recs[i]);
 }
 
+static void t_obj_block_read_write(void)
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
+		.type = BLOCK_TYPE_OBJ,
+	};
+	size_t i = 0;
+	int n;
+	struct block_reader br = { 0 };
+	struct block_iter it = BLOCK_ITER_INIT;
+	struct strbuf want = STRBUF_INIT;
+
+	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	block.len = block_size;
+	block.source = malloc_block_source();
+	block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
+			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
+
+	for (i = 0; i < N; i++) {
+		uint8_t *bytes = reftable_malloc(sizeof(uint8_t[5]));
+		memcpy(bytes, (uint8_t[]){i, i+1, i+2, i+3, i+5}, sizeof(uint8_t[5]));
+
+		rec.u.obj.hash_prefix = bytes;
+		rec.u.obj.hash_prefix_len = 5;
+
+		recs[i] = rec;
+		n = block_writer_add(&bw, &rec);
+		rec.u.obj.hash_prefix = NULL;
+		rec.u.obj.hash_prefix_len = 0;
+		check_int(n, ==, 0);
+	}
+
+	n = block_writer_finish(&bw);
+	check_int(n, >, 0);
+
+	block_writer_release(&bw);
+
+	block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
+
+	block_iter_seek_start(&it, &br);
+
+	for (i = 0; ; i++) {
+		int r = block_iter_next(&it, &rec);
+		check_int(r, >=, 0);
+		if (r > 0)
+			break;
+		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+	}
+
+	for (i = 0; i < N; i++) {
+		block_iter_reset(&it);
+		reftable_record_key(&recs[i], &want);
+
+		n = block_iter_seek_key(&it, &br, &want);
+		check_int(n, ==, 0);
+
+		n = block_iter_next(&it, &rec);
+		check_int(n, ==, 0);
+
+		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
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
 	TEST(t_log_block_read_write(), "read-write operations on log blocks work");
+	TEST(t_obj_block_read_write(), "read-write operations on obj blocks work");
 	TEST(t_ref_block_read_write(), "read-write operations on ref blocks work");
 
 	return test_done();
-- 
2.45.GIT

