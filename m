Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94DF199FC3
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244169; cv=none; b=lXQE6ZuHrjaNGiP5X5JTAvKIVLJE+pNxiTtGsHQ7JKgEUf0Vh+ferirB/0TBfNp+yqMhg0x7I8cBR8lLRYtUjZG3lUfYU6DeaG4gjI6r+1LY7bS72/VPHEfNkan/Wfukc9lQ9LD6FvdygLfPL3qb9nUO0H5WAcb0W0Hmv4tVh4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244169; c=relaxed/simple;
	bh=wJKV2tdiOT/dOv8NgoPzyKm7m3SyNM9m5l5q7KkpsKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvXpPmgBhxWiwOG3EeJVw/qtq1pOipQyzgh51UOWRiCydA/2Pr+O2+/0xq6poGyyndeKQCM2sS5N1V3IIVvdwtCAfHHO1WwnyKJcp8Jmsus0/XpqixQwhVcHfO+EKnopcJMsSKZI0wCEGGCF1GP2uVtyyMzGqd8063rvA5JQbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig4dx189; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig4dx189"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7aa7703cf08so4789105a12.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 05:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244167; x=1724848967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA2MIQWXsrevxhhnoP/S3q0wxA4C/2w9mZem0FNtT4s=;
        b=ig4dx189YnTfZVY1fWADxEo+8b9kcikNzpvsHzMDWkMStUXNbbEt+JmLKVOoEggb7K
         rtvj1y1Ac0I9vJ4qqVYPCIuMjyHCtCKu4Ppgl5q4lQzsre3Zhdpfr6yzAjGY01btZ3px
         T862yXZ0wTbGXaJJsXQZXB/Y7UQC9RfhT25SsBJrg/nu2SJgf/0Q+KnrgH7LLcdLfCx1
         sRPL4qN7LrKsV9prkTgNCWHPZXgCxzYbqmSu3PVGvZlEVEvAA/ay8K/iDd8dLNwVSutR
         LCyuRN8NQLGT2XhwPbuyzugpq0fTWnOwoMI4U99QbHOr52eW+ft5omm0xSn2PLJFqLJq
         JTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244167; x=1724848967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lA2MIQWXsrevxhhnoP/S3q0wxA4C/2w9mZem0FNtT4s=;
        b=QxHrMA7uxUUZD7Ynhlp7clgBsB1CaooohmK5tnfpR3ak6rry70nqrpvUKfjsSYTX9u
         qCtEKgbbgyNXL3xxzE5H+1oQEcr0ERJjZroOrLlyx8WYQsmUr+yED+q5uCZoMc4bd2RP
         VXGgHpGKTBF5K4/qSKn81gs5a5veXypfKZ4KbkGdm3kmL9pzIcLPewi6Yzx4NfzG98E6
         fnxs5uCfWB7j2Xr93tSJ6Z6JGsysM9h7eppn9jNTOXQC9IEmvEFT10/DdZ7HIOKbE+79
         RsHK3fmucawk4ge/J3xE8sxEvGdLUwEjbAgjD2iWC8UBHrO8lIRCsC5CJTIrQVC8dicW
         E3BA==
X-Gm-Message-State: AOJu0YwSu5tTqkJwZAgd7jR+JQoP8U8Ki0qvsk9+nSgktwkUioeUQBmO
	tJzCwmYuvp5j/FuilZwtEBj+gqxu5I9RCGSW+soRKIryZFG63RjvvNDTLpq7
X-Google-Smtp-Source: AGHT+IF9np0YEMPaOouSIqgp2OjrqlAMsFITexRWT5lY1Sb+z3iTiSKqXYVkAppOd5xyIrkJbPaNUg==
X-Received: by 2002:a05:6a21:920b:b0:1c6:fbc8:670d with SMTP id adf61e73a8af0-1cada148a32mr2563704637.43.1724244166758;
        Wed, 21 Aug 2024 05:42:46 -0700 (PDT)
Received: from Ubuntu.. ([27.59.95.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5ebba8853sm1670963a91.56.2024.08.21.05.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:42:46 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 11/11] t-reftable-block: add tests for index blocks
Date: Wed, 21 Aug 2024 18:01:01 +0530
Message-ID: <20240821124150.4463-12-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240821124150.4463-1-chandrapratap3519@gmail.com>
References: <20240816175414.5169-1-chandrapratap3519@gmail.com>
 <20240821124150.4463-1-chandrapratap3519@gmail.com>
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
 t/unit-tests/t-reftable-block.c | 88 +++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index beb2d6f81b..582a8e6036 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -272,8 +272,96 @@ static void t_obj_block_read_write(void)
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
+	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
+
+	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	block.len = block_size;
+	block_source_from_strbuf(&block.source, &buf);
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
+	strbuf_release(&buf);
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

