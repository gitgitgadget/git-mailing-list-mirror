Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E75192586
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244166; cv=none; b=hS0iCFq5LU3S/yZ/sbYkz857ejm61kMODucbP3C+8GttKPekozgxwbjc78wFdE9sgEs2QM/bungcNi+k/4zTjY7fvLels2YJh5K0Y0bhOXB9Wc/KRTTYhb3dePW3rxEUsfqUYeTfLzI1tXxwsBmcbWDgtlPM25VWbmXBOx+Y6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244166; c=relaxed/simple;
	bh=iYKk8okwqT1ZkmPxBCL3Wet376IZ225JAdtS2YmzSeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fk0g7OhymdnomFaNO1teMVLqwRij9m1TVnChdiLJOxySWQOpfzKp0Bm8MGKkhy8tSuJ71K2B5PG5hR5kAtvZ9PqojKLCurNFE+1l6gPMJBVFKlIN0JQNBamd1KhdmZQFkM3QDIwYRIxBlDOXwYq5V5UL+OCw//TrryMIqAgRdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhphyUen; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhphyUen"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d5f5d8cc01so273854a91.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 05:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244164; x=1724848964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vu4GWyumjCarjjyBZsK9jums+9obFUPQeiyxHTI7TI=;
        b=XhphyUenCLULlYI8PZhYmgi99KQ94VAm9OQhz+Y8yMLEHARMBrkS0qWLyB6e0RGH5W
         MPjKDjYpsK5B5kTO7vkTKi8a01uON5WC4xQy9BNpa7E6MGdK+bwfrKE6xkBs+E0ktPWM
         BMFBqnNe4OwaPaBLkJLdGpf/wAAqXiVSNF/BVP9Cc6oOBwHz0OYYcfFddgoy7sAJBjmL
         JK8k0h1msoBaF5Gj9HhgNFWXBdFTivx+E82347BxJq28YvMGamQe9dQ8AQOxfxWo0yGH
         iXU8X6GS2RhTiwLFQO1uaxA9Ns6JINCmf3vbCN9Mp5abnc4wvNg5tChXA0bnZ+kTMPwY
         JlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244164; x=1724848964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vu4GWyumjCarjjyBZsK9jums+9obFUPQeiyxHTI7TI=;
        b=KnwELscy6B4wpIFDM1W9dmgkOGhhJAov5aVzoyjxjtVGFASEPG37ebI7P8V/+W7oU9
         Q/BC9chL6pXKiLNnnXSOF9iObtDxaPmZMBCgKsPx2UsFF73yn19mV7NzwufHoLz/ZDTi
         n+7GI+ds+MLM57mFEzd8Z65bBtrXipgrJQ/PTrAcZrQnqVMSsauQNrikNxrRcCqasR7Q
         XgoTRJkXuqNM5IKZ1ZaQe5P+M1ROfw3NfbHbX4jYE3QFa5tHDQsMynw44eg6E+25DNF4
         GkxKJIhY26fX+H+lkVcAmOVz9ZMZ9f+DW2E5d7+npg0HnWVEFjBD7qAqOxJeSi2iW5fX
         pryg==
X-Gm-Message-State: AOJu0YxSwxYdluAx5JCeKXrIaBu59tjsEAjEuKb7uTsuC/8z6+kqPyW0
	ii9OQ2DcfbHcyOCHoOVQtnUXXZO5UVLJ3Kj1XfXV/npxNTHbMd3yB1LxufBJ
X-Google-Smtp-Source: AGHT+IGT24ch0PpBUCqtiTNeC3faUIDLHALK6qQh/yT1EWmKSJ2mvJR+t1DYx4DwhMRH4+AyfGnmrg==
X-Received: by 2002:a17:90a:70c1:b0:2c8:4250:66a1 with SMTP id 98e67ed59e1d1-2d5e995c991mr3863788a91.3.1724244163941;
        Wed, 21 Aug 2024 05:42:43 -0700 (PDT)
Received: from Ubuntu.. ([27.59.95.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5ebba8853sm1670963a91.56.2024.08.21.05.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:42:43 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 10/11] t-reftable-block: add tests for obj blocks
Date: Wed, 21 Aug 2024 18:01:00 +0530
Message-ID: <20240821124150.4463-11-chandrapratap3519@gmail.com>
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
for obj blocks. Add a test that exercises these operations for obj
blocks.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 4c4fb39ab4..beb2d6f81b 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -191,9 +191,91 @@ static void t_log_block_read_write(void)
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
+	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
+
+	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	block.len = block_size;
+	block_source_from_strbuf(&block.source, &buf);
+	block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
+			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
+
+	for (i = 0; i < N; i++) {
+		uint8_t bytes[] = { i, i + 1, i + 2, i + 3, i + 5 }, *allocated;
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
+	strbuf_release(&buf);
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

