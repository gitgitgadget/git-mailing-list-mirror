Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031201B1401
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637537; cv=none; b=ANx/380gGqRpn9xzS9593J9Q0WFjbemRlurMpr7FT1YGZ1US8CfE0WSWmEzd+hyR3fWKKsfpu54X5kl4trUckj1kffVbcdKDD6pdO22aWQ++Qu60JEVvmgJp/fmlPSbM6CzjjV1UvtkNGUsLIXMh9f7g8hQ3OZUh6e2AMZuRXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637537; c=relaxed/simple;
	bh=vCui7XsXJjFCiKnjX84iAM65Zp46VDWAhOoGASLdgsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaSy99Skf80VVkgzH6p3TMnmLg6SeZR1FxBJOtVkWT5vLnps7I+/g0jwnu2uHUH+eduiIk0zMKQZyydS2npQcX8PGC/9BNtGNTRf41nTNb9MDdfTdDcvj5NqizGM/PzROZ37+/OPM79EKAHL7jRsOAmBLh+0nL/TJkS+ckiJbb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD0vsbxj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD0vsbxj"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-710dc3015bfso632419b3a.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723637535; x=1724242335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g93O2EouZZlxjPMeKRhXphz580Gg4HHT2WpJpDctWMc=;
        b=VD0vsbxjGdQYs/egA7GSXl6uU+M/zDJjQKhm0JJg2m90q+7yIsBq/pcCbp0lniVBMF
         NGHFzRiDw53ss8LeJwfDRrE6qISi2YXL+Oqg1L5/CofBqbqfC4Iz0gVnVxyk3oTwxEH0
         Md8F95AbftODzntXi+oyYGwcSf01tLEowstwMSapX3wzCS4oK58MqhW+MM8DVX1pTbFj
         uZEFr+OXjY9/3gd0ovtZJ9oyjMILT1sw7GcCdvyTFKKiDIyMGNtkNiOZm1XAI0B0a+js
         PA2DlV+6NDCQPPekocSEtpVOOSlqCMSlwlcyLeTbcIAnRFwkgkLPQzGHd/0zE0y0+VTl
         NXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637535; x=1724242335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g93O2EouZZlxjPMeKRhXphz580Gg4HHT2WpJpDctWMc=;
        b=VxOiql1yRXsMQOpbnaBgMOh4PQb0X/EBFXwnTtfScDWOabLgt75oVocDpJ6ZXSK1dj
         P5pnp4GLNbgwBegpcj4Z5ScVI6KBL1uzJsL8akDH6LaCAsidsroXnxXIMi9HvdaWb3+P
         kUuHT0DWYkzQnfgU5H7uWiZ/6Axm5MpNBG/QoduFQBl/1xKUq8BopYnbcDJQa1B+EzmQ
         xePmNzl5f1+RDrzwDNgcLCa48X/EnQ/6yLxkhRhl34vjBal0Q9e9TlXl6ynfGT0cGVlB
         WcRKMQWfH5csaLF+UcsXF76a72Wh7BYGvDHqaHzVwS8OEt1XL3p4IYtTe9Gs3y0KJPJN
         9KiQ==
X-Gm-Message-State: AOJu0Yw6n2qS1j7iR9ceQ3j5rg5KTfJvpx3oCe6iTEb/7uPLeIOBqfJQ
	rsAsYZdly0c7gHp+FSdbKnwRFAC5otNQoa9XuosENw1ckTyjIaGt/a64Zrwkp4c=
X-Google-Smtp-Source: AGHT+IGE032GFbmZPdknRzhmjIv0FfaPfUL0dt9w9RlwibtIIfJdvk3Y/1bmtdsHoMGyDMtjVGzTBw==
X-Received: by 2002:a05:6a20:1e49:b0:1c8:ef0b:fcd7 with SMTP id adf61e73a8af0-1c8ef0bfce5mr2020586637.1.1723637534667;
        Wed, 14 Aug 2024 05:12:14 -0700 (PDT)
Received: from Ubuntu.. ([106.205.236.194])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5875200sm7195450b3a.37.2024.08.14.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:12:14 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/10] t-reftable-block: use reftable_record_equal() instead of check_str()
Date: Wed, 14 Aug 2024 17:33:11 +0530
Message-ID: <20240814121122.4642-4-chandrapratap3519@gmail.com>
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

In the current testing setup, operations like read and write for
reftable blocks as defined by reftable/block.{c, h} are verified by
comparing only the keys of input and output reftable records. This is
not ideal because there can exist inequal reftable records with the
same key. Use the dedicated function for record comparison,
reftable_record_equal() instead of key-based comparison.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 31d179a50a..baeb9c8b07 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -15,8 +15,8 @@ license that can be found in the LICENSE file or at
 static void t_block_read_write(void)
 {
 	const int header_off = 21; /* random */
-	char *names[30];
-	const size_t N = ARRAY_SIZE(names);
+	struct reftable_record recs[30];
+	const size_t N = ARRAY_SIZE(recs);
 	const size_t block_size = 1024;
 	struct reftable_block block = { 0 };
 	struct block_writer bw = {
@@ -47,11 +47,11 @@ static void t_block_read_write(void)
 		char name[100];
 		snprintf(name, sizeof(name), "branch%02"PRIuMAX , (uintmax_t)i);
 
-		rec.u.ref.refname = name;
+		rec.u.ref.refname = xstrdup(name);
 		rec.u.ref.value_type = REFTABLE_REF_VAL1;
 		memset(rec.u.ref.value.val1, i, GIT_SHA1_RAWSZ);
 
-		names[i] = xstrdup(name);
+		recs[i] = rec;
 		n = block_writer_add(&bw, &rec);
 		rec.u.ref.refname = NULL;
 		rec.u.ref.value_type = REFTABLE_REF_DELETION;
@@ -72,7 +72,7 @@ static void t_block_read_write(void)
 		check_int(r, >=, 0);
 		if (r > 0)
 			break;
-		check_str(names[j], rec.u.ref.refname);
+		check(reftable_record_equal(&recs[j], &rec, GIT_SHA1_RAWSZ));
 		j++;
 	}
 
@@ -82,7 +82,7 @@ static void t_block_read_write(void)
 	for (i = 0; i < N; i++) {
 		struct block_iter it = BLOCK_ITER_INIT;
 		strbuf_reset(&want);
-		strbuf_addstr(&want, names[i]);
+		strbuf_addstr(&want, recs[i].u.ref.refname);
 
 		n = block_iter_seek_key(&it, &br, &want);
 		check_int(n, ==, 0);
@@ -90,7 +90,7 @@ static void t_block_read_write(void)
 		n = block_iter_next(&it, &rec);
 		check_int(n, ==, 0);
 
-		check_str(names[i], rec.u.ref.refname);
+		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
 
 		want.len--;
 		n = block_iter_seek_key(&it, &br, &want);
@@ -98,7 +98,7 @@ static void t_block_read_write(void)
 
 		n = block_iter_next(&it, &rec);
 		check_int(n, ==, 0);
-		check_str(names[10 * (i / 10)], rec.u.ref.refname);
+		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
 
 		block_iter_close(&it);
 	}
@@ -108,7 +108,7 @@ static void t_block_read_write(void)
 	reftable_block_done(&br.block);
 	strbuf_release(&want);
 	for (i = 0; i < N; i++)
-		reftable_free(names[i]);
+		reftable_record_release(&recs[i]);
 }
 
 int cmd_main(int argc, const char *argv[])
-- 
2.45.GIT

