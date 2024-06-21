Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553A3172BC7
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971097; cv=none; b=WCkLN5tjkTtdAYJunxRu4C5Tu0KED/Pbnb54OkOsNgMKD3nFLppOBKHk1z7cZhX292pXUnxIwpUn3hZ/wqRJg1pwJtnrxCXTDBQZKzmjjgAt2cEVU1gkN3XsU0P/KAmMtqdCZ/RhIUzMXP/tl042QWoLP/Zt0BnTiV7kpyDg4HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971097; c=relaxed/simple;
	bh=5HuxIaQtqJmWfQDU4ik/hynvUZHvVbK4jJ7+Ev5MtTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8LQyknqwg5R2/XlzskWpjpvl+lZpbiYbVdaFiQJzjDoLsR8g6bx4iajIJ43qSJpaq3Fk/E1HdwlCV5Pe9QOtIc3H5tDjoMbV3bkF/PL+YD48qsUFdsg86NNl87AC8liZnG9joaErL01pZK/MfQcPAfd+YzxHgsd9YO1XTpV5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRJuUR6D; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRJuUR6D"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-701b0b0be38so1703762b3a.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971095; x=1719575895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OunLGBMB2r/G8aJZ9CXDWZYdLx8suSo4CLsmg1lc9II=;
        b=cRJuUR6DXOIfJC3Itki/DzxWGhxOcuFNWqd9hYExOA1LEU8AqrOu8+d47GEWHA70OJ
         F372R0A/nlaobqsePlA332rCou44eQMZTyVPpFb/AIM2cwkMgkiUNkt9vls9f8AUjRNT
         rilas4VfSeDoTWC2lk1eknHjJ2w4Jl++UbWKofhkLZVWazPENV8OtLnhuc8t19b1c5Xk
         u0i3vupHd1S8UcbR9JKTD2b+1oqWjLv71u8IvcwKNalVKRGKf7lOTMdYMYJHXlh/okI0
         4AnEZhs52ibOsIfk5S46HLM+x5a1OQFyd78OqmGpsgpexfbJAYbWIC2zK1J7YRuQ4er0
         xg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971095; x=1719575895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OunLGBMB2r/G8aJZ9CXDWZYdLx8suSo4CLsmg1lc9II=;
        b=i6mJttrzhhhLrD1rFdsen5pP6XELtkuGu5R5zFvdQ5cy7eAkGl9xMoVHlTwrvj27Qq
         vF5fmUAGmzgxIdOPrMWFMUbySDZL8APD5X4OpzsG2D4RD8H29af2zcBY+sgWk8HNxsZi
         b0dQ5HMeDEusZepHFvOjRc32bSydaBdkNvivfZACYGmRKXK2QoXXEw914lezh2ZtfB48
         c3lCZuU/5grUiUqbVIdr1pSFcnDdhw4ETCmNTsOi13OoWOz78yEyQhiO8hBBW5+EY8m3
         n/l2mnBBLhO4Mdd2YtqILWwE+vuk1q32SIEqaABznGtBxW1fSwbPfzJKZJkaXEA0Sueo
         gdpA==
X-Gm-Message-State: AOJu0YxRt6jJPOxszq8Efe6jfAOf29NoQd9CsLA8nNi3fJEPqYGhe6bX
	M4B8AswPK41XC6gpoPbFO9HUNN+4KhE0vGP0O7oBgxHrpsh31MCjdAkX8Q==
X-Google-Smtp-Source: AGHT+IEMAKamZkUPVU+XD7Fs7FOIyCFai/Ksgd5cyYCwuIlzcTV8N2c7cuRG3/jRF6omO6FrA5fQgw==
X-Received: by 2002:a05:6a20:47dd:b0:1b6:f34c:95b3 with SMTP id adf61e73a8af0-1bcbb60fca3mr7260862637.59.1718971095268;
        Fri, 21 Jun 2024 04:58:15 -0700 (PDT)
Received: from Ubuntu.. ([106.206.204.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ee9sm12407195ad.180.2024.06.21.04.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:58:14 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 11/11] t-reftable-record: add tests for reftable_log_record_compare_key()
Date: Fri, 21 Jun 2024 17:21:06 +0530
Message-ID: <20240621115708.3626-12-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240621115708.3626-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_log_record_compare_key() is a function defined by
reftable/record.{c, h} and is used to compare the keys of two
log records when sorting multiple log records using 'qsort'.
In the current testing setup, this function is left unexercised.
Add a testing function for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index b949617c88..d480cc438a 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -214,6 +214,30 @@ static void test_reftable_log_record_comparison(void)
 		reftable_record_release(&in[i]);
 }
 
+static void test_reftable_log_record_compare_key(void)
+{
+	struct reftable_log_record logs[14] = { 0 };
+	size_t N = ARRAY_SIZE(logs), i;
+
+	for (i = 0; i < N; i++) {
+		if (i < N / 2) {
+			logs[i].refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
+			logs[i].update_index = i;
+		} else {
+			logs[i].refname = xstrdup("refs/heads/master");
+			logs[i].update_index = i;
+		}
+	}
+
+	QSORT(logs, N, reftable_log_record_compare_key);
+
+	for (i = 1; i < N; i++)
+		check(reftable_log_record_compare_key(&logs[i - 1], &logs[i]) < 0);
+
+	for (i = 0; i < N; i++)
+		reftable_log_record_release(&logs[i]);
+}
+
 static void test_reftable_log_record_roundtrip(void)
 {
 	struct reftable_log_record in[] = {
@@ -519,6 +543,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
 	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
 	TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
+	TEST(test_reftable_log_record_compare_key(), "reftable_log_record_compare_key works");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

