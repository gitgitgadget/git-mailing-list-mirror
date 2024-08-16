Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84E1C37A3
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830923; cv=none; b=YeHwR2K3uq5OPf3G6yhIVm4AVL70a0e9+1gvD/EKX3E4WvQGRG+nLsLZOvvvsRxCKEkyN6TX5Fa/cNVIa0Aph/zrzMoCZfzi99iy0CnwvoN0pCC4yToAXxaufqfZpIF9anIEDD80D1kiEgqNbSOLPfLEoz3OHdd50Z2MI6TGFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830923; c=relaxed/simple;
	bh=00DSGfPLW/XvZDWPOGM0q9ycacB+83y8Yf9tdtfmb6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncg69zFYFQBhoFLjzw5QlT8MoUxE52Gbx/JR+uCaXkg4LSe7sEg59nOHtAYEpr8/bX6UYNMTLj9gAn/tiZ+zoFMyHRSdutohtaM8LVmBVpB92cuOKeZ50OlByogyYoSaRi2NRNyHgNL/ZRLmle1pfh720htwqayfmKWZQzw2cKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmMAiZwW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmMAiZwW"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d2b921c48so1787113b3a.1
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723830921; x=1724435721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIpeNtuc1TErdzaJjKxPmo3P9FdzNmjqrFWjOhfJBIw=;
        b=MmMAiZwWVSa9PY9v3fj1x06yTPjtIYb70G4twiZ6CqEYK/LySFmsLMYby3YEokV9H3
         Ykx/uWavUT4frMLKX0aSO/EWv7jNpyP1TcRuSpzu7bOqZdvbCbJaZHpZnOPgFpuTLJVb
         YKPqnQjEDUKaLJig3xrtIw+oNnsUEqVnpYAKsbrkGdlQr/Ia26OccCESeDK8usuYMHlk
         /SdZ+nOVN0bwOQfIvSkU9y3uHSr9W2RtpMZqSbjLQitRIh6SAn+UgdYXop5vhXWvahd9
         HP9Jo7Gdvm+6AsdwkSlIdRxG7eQ3LzWeiT9s13OvhbUhM4yhAsl4VbEENjyNWFW8pEvH
         fjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830921; x=1724435721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIpeNtuc1TErdzaJjKxPmo3P9FdzNmjqrFWjOhfJBIw=;
        b=ZSiZGm0MmXDVDwNLvFtTRJob6R6pdK6M8Go6jS/p2wKM3WRSdpmRAwvdAWGr/keF2A
         G5MjmdX96QgtpzCebFNMxNqJULObE8an8YdYAIEhi8/7VgPMIEdhV0j+ib2RupUX9Zoz
         TR6cDrUWjaCOK3dbgqHEgCPKnoOPHLMyt85rttsY5NYEnhLUld93VCMUyD1YFeBcRbTN
         06XNpSHDDspEX1oYvDooK4n0ajpWo1KgDvFHveT1eQShWXAJOfSAj6WzxgUYvkfDV4vx
         +LTNEtu5/WjYy6+eSiNFZPBNeAMmmefWzlvqg0f8cw3va90rtwQ78QDDFFjQVtyzeWvq
         nFMA==
X-Gm-Message-State: AOJu0Yxtt1GlhheT8llWaZh1fLc3iR81DHctVXrjnnG715urN+WFB9Cn
	c9rRKRYKOQ+7W+8xbg1v8a/toajhAgeCOo+I2D2nyMHaAkOcIU+YTmgvIQ==
X-Google-Smtp-Source: AGHT+IHuo9qeKhlt6ruINufh5JH1cVgLq7RhrtXGnJ8fA3B/XNpVjDvXpDZn3e9+Pf7KbJblozBQCQ==
X-Received: by 2002:a05:6a00:4649:b0:70d:347e:713c with SMTP id d2e1a72fcca58-713c4f37f15mr4414574b3a.28.1723830920722;
        Fri, 16 Aug 2024 10:55:20 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.209])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af1e907sm2985600b3a.173.2024.08.16.10.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:55:20 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 10/11] t-reftable-block: add tests for obj blocks
Date: Fri, 16 Aug 2024 22:55:33 +0530
Message-ID: <20240816175414.5169-11-chandrapratap3519@gmail.com>
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
for obj blocks. Add a test that exercises these operations for obj
blocks.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 1256c7df6a..7671a40969 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -190,9 +190,91 @@ static void t_log_block_read_write(void)
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
+	int ret;
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
+		uint8_t bytes[] = { i, i + 1, i + 2, i + 3, i + 5 }, *allocated;
+		allocated = reftable_malloc(ARRAY_SIZE(bytes));
+		DUP_ARRAY(allocated, bytes, ARRAY_SIZE(bytes));
+
+		rec.u.obj.hash_prefix = allocated;
+		rec.u.obj.hash_prefix_len = 5;
+
+		recs[i] = rec;
+		ret = block_writer_add(&bw, &rec);
+		rec.u.obj.hash_prefix = NULL;
+		rec.u.obj.hash_prefix_len = 0;
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

