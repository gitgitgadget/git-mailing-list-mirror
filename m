Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517941AED37
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637553; cv=none; b=Rp+nTZehAwMesf6sDp9F2cgSSWGm9fHzkbGCwLloU2ReeQrkDhDh6B1tHIoEeT0glatkGRh+A70APreueW3Ov05t4m1vk2EIpbxNR1wjEzhC4KnXdOXPpJF5L9srXIOnr0QEn4gJWDFPKsLiJztBd3NoTutfgUHAibPKSJxaeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637553; c=relaxed/simple;
	bh=Ov4eLVtm6yT9uOUCtV5vJuXg3nTmt8xFArm/NwqQ/hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSJL1IUgzMxVs8paoY1xKg3wK4ggpm+1WlII4sq0kmNPEb7tofMwPkZrSVAlNvYOHyp0Vz3PIMzhatmf7ROg8tossLz/MxPV5Juh6ZakCWgDHS62kBXzZjQHNv4XzLaPL8czTFuqS+xCtyt/NXQuwTfQTitwWA0ln6GcsIVGLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEdRpoT3; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEdRpoT3"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-268a9645e72so4525772fac.1
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723637551; x=1724242351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKZXsDt2QUTqx5KDs/S2P2rC9mkkY4fDIDIWexniHKE=;
        b=NEdRpoT3YuR11dIbfAhjh3tipl343aUz6808qmtI4XEHg9lxqIciqV6OhqSVwR+RhQ
         cZA7l/GtkRUTJpaEVL3QxCo9gbYH5Y27ZTQGV9KhT1GDGTQWHkTSR6QHtAIt+1UoNZyk
         /VZH6E9dGoAAEnWIId/JxuQF6xabjJyKwXAGf6BT2ozGt6jO45zFlI5lZIueb/h3lukz
         zBksP+I+8Wau0bNPMFnXPTKbfzT+LQ8BudhOJWGz2sMBot5C8dqVQLBnaAsk+W8jaYgn
         21lGRZVuKj+my0iPmC4FGwr7RHNNQqMmCwCmTCbD6czD/semT9YK1yMvVxJ+I0Y+f9Jq
         vlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637551; x=1724242351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKZXsDt2QUTqx5KDs/S2P2rC9mkkY4fDIDIWexniHKE=;
        b=vlKHdt7t1zh7GYgQTVRxG3azns37zH8+FWtjPflP7TE6IOX6aiEzP6Fa8iNGOSYn3o
         u1mLTrytnvLUQlBfDcdn9U9wAoebFN4nNAxlZyblucLSnRGHMlxIcWK0SCf3Zo4Z+RN0
         SP3dBfKxuaWf4xDROyBJn+6EyxI3mZwjfwwP4EJY7KKkwXbdljrYi6shnHXXYqkqUKCR
         qKUD1WstdIGaWtb/PheHgzgLwSH/EFXxuL85Jof7BgdalkGgGqkKVAqxfFb1grG7p0rU
         pf2jqrh1+KiIKurgTd5gTXHTVVwCOnjGyBZ0lZSa2JYVqBinNjWqGEj+KzEgCNXzBSlH
         b2+w==
X-Gm-Message-State: AOJu0YzAgLyed2QSLjlNh4GE5w1ruHSzcdDxHKJsHNcQjIqFspPbqiUr
	/LnX6DT/X+d7o/o56yPJERty/2ewq4Pcqj6uM2LpjogdygfHog/ifU2IoqMOBHo=
X-Google-Smtp-Source: AGHT+IH6xYKtLQLMn2uyTM6Wc+rn9nv3CScz/9M7CNpwx0JUodfWuvYZtVBa97VUYKABozkF2w8ezg==
X-Received: by 2002:a05:6870:4722:b0:260:f97d:6473 with SMTP id 586e51a60fabf-26fe5bb929fmr2595677fac.38.1723637551023;
        Wed, 14 Aug 2024 05:12:31 -0700 (PDT)
Received: from Ubuntu.. ([106.205.236.194])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5875200sm7195450b3a.37.2024.08.14.05.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:12:30 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/10] t-reftable-block: add tests for log blocks
Date: Wed, 14 Aug 2024 17:33:16 +0530
Message-ID: <20240814121122.4642-9-chandrapratap3519@gmail.com>
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

In the current testing setup, block operations are only exercised
for ref blocks. Add another test that exercises these operations
for log blocks as well.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 90 ++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index fa289e10f2..01ef10e7a6 100644
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
@@ -101,9 +101,95 @@ static void t_block_read_write(void)
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
+	int n;
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
+		n = block_writer_add(&bw, &rec);
+		rec.u.log.refname = NULL;
+		rec.u.log.value_type = REFTABLE_LOG_DELETION;
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
+		strbuf_reset(&want);
+		strbuf_addstr(&want, recs[i].u.log.refname);
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
-	TEST(t_block_read_write(), "read-write operations on blocks work");
+	TEST(t_log_block_read_write(), "read-write operations on log blocks work");
+	TEST(t_ref_block_read_write(), "read-write operations on ref blocks work");
 
 	return test_done();
 }
-- 
2.45.GIT

