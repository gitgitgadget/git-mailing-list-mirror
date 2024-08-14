Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4BF1B14F0
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637559; cv=none; b=liQu++a7/8jWIPcqS4GXn21EArN5HWX+nzOMll5UdH7FsWQSooxYkzNLggGk5hFTpZFls7is5yQld5TI36S+U9GtelSis+7yIag9un8v2ag+XvlqMYCoyYDQnqxXgFfZ+Wa9mC2PZELYb2q5qhWVS+taf9QPbEP6P2bdyBumoYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637559; c=relaxed/simple;
	bh=r/orRq5NVdr0A+yc+fafHvC7uvFN9YSPa15/C+bevEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ks4nN5HQrXVL+4uaYwPFa/Y5C3YjoZ6/Dlisx0rnvNLChQGSCpf7DmRX8XwK6xVqCshfC/MvC+xfjjEu3aj84cC9FKluSayWfQFkouFe9c25nwnhNSfpfKOUtCLhQuCxIpoaam5jzD2ITJXDNFmthPtIAYUDgM+IpNxBRCBt6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/chfrBu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/chfrBu"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7106e2d0ec1so4646939b3a.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723637557; x=1724242357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/6ISN2bUz//ZFk79xAly2edYb7RZ/ZpJ9d6HEFUWZc=;
        b=c/chfrBu8aKZbPIjlnXFHZMEAUpPkOUQlZmm9rOhMUvmEFXVdnheJ3d07MR9neLHhp
         W+CI5PMHu2RawLtRbZskeQFLa/eNn74bpvlMl/qe/VxbGxvw/bHlEdC206YUKnAAYtW7
         PJv9i6Vsg1wCXPmn+PMOULQafh/kF4zeLzfAFR0POS45bXVcvMiTE6MIq+C9ESqHGatb
         6dlh5bIFJGBEPN//0pSRmJk3i8ARd21OhZwRVkg9gb8Ab//66Qc/1AOHz9pkVorHGSs9
         Muz7Jfx7n5CClI4k7uXsRXueIRUF24E0esFCry04fIDeGyMo6Hs6eb88PPE6HT4rIusQ
         7wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637557; x=1724242357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/6ISN2bUz//ZFk79xAly2edYb7RZ/ZpJ9d6HEFUWZc=;
        b=t5ZeBH2zkw/+F8IlzTy+oGmOP5y2GcQjC/B6uMjPiQkwmeO0tZqL/0ri8P+xvXnbRJ
         SYNRAGzg9nsqiP2ZEHmmOFJQx8X6PUpwYyspcis3cTdRCYkQwyzVoYwbfyJj/AGO67rK
         +TYYzFK0HKgS+jw6562Emo5XVkORzLM0bEj3/ajBdtkMU5wLKaHTosXdP8Hw5w24XZLr
         yhWkfGOY6IFE2ajB+vd29Q0Vm6m9Dk0O+s3j/LJg79I5KAQbsuovAJM+Rgkja/rROfoI
         IZ6rQnqYU5Osh4Gk0EyC1xa2xYdWtYVl7X5bn5EeUyReHquhi5yPFN1jDG/P1SNgURLF
         Aslw==
X-Gm-Message-State: AOJu0YzURTbLbWQxH3SxuoLQesb7sNOp0mV1/3UUoHkXL9WEMmmhkrr+
	t+m4NdHXDSL4+MG1fQHBC2GsPyLzJrzC8luRRqNoSnPGm8QyJNyEvLxzvX85mXc=
X-Google-Smtp-Source: AGHT+IGhDlZrLEVp2vvOyekK0kES2fDogNFUfD37x3Qk3nq+DlS67XZ4a6hEjvpjt2fj96XVE5gL3Q==
X-Received: by 2002:a05:6a00:2193:b0:706:726b:ae60 with SMTP id d2e1a72fcca58-712671242c5mr3149369b3a.17.1723637557258;
        Wed, 14 Aug 2024 05:12:37 -0700 (PDT)
Received: from Ubuntu.. ([106.205.236.194])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5875200sm7195450b3a.37.2024.08.14.05.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:12:36 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 10/10] t-reftable-block: add tests for index blocks
Date: Wed, 14 Aug 2024 17:33:18 +0530
Message-ID: <20240814121122.4642-11-chandrapratap3519@gmail.com>
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
for index blocks. Add a test that exercises these operations for
index blocks.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 85 +++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 34d37fe1a7..bbf6a5371e 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -264,8 +264,93 @@ static void t_obj_block_read_write(void)
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
+	int n;
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
+		n = block_writer_add(&bw, &recs[i]);
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
+
+		want.len--;
+		n = block_iter_seek_key(&it, &br, &want);
+		check_int(n, ==, 0);
+
+		n = block_iter_next(&it, &rec);
+		check_int(n, ==, 0);
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

