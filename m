Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE186172BC7
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971079; cv=none; b=MhKdCezJWQgPTapxuKj7avvc+oNZQGn2HeYcPYAfKHHr0+msNAguKfiRJO+G9SYc8R8zQ8VbjL+v0vGD41mjPjclxxOy+jNcsn3V/5eiMeSQzBKzTNCj+3jvkgepjJPl587WkKweaNr6FOJd1XBbv6GIf/w+GTIR1ZIK904zV1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971079; c=relaxed/simple;
	bh=649sxEkfbyEgKdBSmEH4E2AYxN2zPI5KRDKA1QfzRhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwJgMfZE4DQ6QsGHs1dZGLIOY0EtD9yL4hSuetajfqF8/5ixQemPozP+d2p//1NlUGP57h97vbOGyu3wM6gggfzm4hodHU0YS9ossR5tOwjLhLpeDPEftYqm+sk7A95908V7W044gp9flgndQN/mf5VwZJgYLdqLm09bo0ZvzXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtnx/XGP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtnx/XGP"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f8395a530dso15175715ad.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971076; x=1719575876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvYjIX0ZHgx6Fah/TwVqpIKAcMFiTLbs4NjX2pklekk=;
        b=Wtnx/XGPSulXXry9OQQjQEvV8wTt69Om7r74wFWesd2rtiLuX0L36F5+NbdTueHomy
         8Qeqr6R8SDZEFfM4Y83CvBr3JkMIxNm20K0nkuehQrcTKE14lzFFJ7KEdWXzDK6ewMam
         ffpvn9USK0wQoGsb1XPyaW2weK34F7jFvMRKwMww6rWEYO3o4UYsVCCBw3tUK0Ua8gCm
         tM8xVhnXioKH5CEJNG1SzuZ2q3c7c3unZck9Puie/FOgGS63S5vpmg69vtFyEHGQupp5
         w9ghevXd+jxfFDmG0PgEWnCsM6ITTTulRyhMn4DdvvTZIBaS8Vt20g8GjRHI8hxe0KW2
         uqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971076; x=1719575876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvYjIX0ZHgx6Fah/TwVqpIKAcMFiTLbs4NjX2pklekk=;
        b=vDQFzwEgBCiwJFCR23MYqhyzt6BTNPXgXq0UIu3HX6OyzxANNIXAIbQCImCjukzOgY
         8bz2ESDCjaSy8gfHf9YTqlxThbzMaa5wB67GFlgKhIq+3RGTG3iTGA7/wWfLl86XaKDa
         qkHwbDYP2vh7NG8eWio9Ilg9iu4SL1H6ghDIaJYDvEbsglZjwvDjQ9DfRH8Qhz1h/AMd
         xKE39WSyFGWaThTIJwRM6GHW/vDuQ5vynE8RqzumBokTqDlCuUJT9hSC2fKmmsHCHQqd
         EvXlvhMMkcm5c2dlWEacpSMbVlTBpfWUXvfpdNQxYZXCdjfbYNUnEmarLoZpTobLSA5K
         P5Vw==
X-Gm-Message-State: AOJu0YyMjyY0e8SgOzrfuSNJ5re2pT4GRl9MUcrp6S6IoquHM2EA9nAS
	kWCsEyH7cZVTyqyQHDBZfWJ4sjDaKGksE+lLrfzIZ47d40RehhsMO/Q5xA==
X-Google-Smtp-Source: AGHT+IHQUEr7vfSrrniMEmv76YukFD1EYgnYT4D9bbet/D7Qn1YFxOB54PqhIkWqU307hfeAQoG3Vg==
X-Received: by 2002:a17:903:1211:b0:1f7:3314:524a with SMTP id d9443c01a7336-1f9aa3bc7e8mr99341765ad.6.1718971076257;
        Fri, 21 Jun 2024 04:57:56 -0700 (PDT)
Received: from Ubuntu.. ([106.206.204.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ee9sm12407195ad.180.2024.06.21.04.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:57:55 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/11] t-reftable-record: add comparison tests for obj records
Date: Fri, 21 Jun 2024 17:21:00 +0530
Message-ID: <20240621115708.3626-6-chandrapratap3519@gmail.com>
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

In the current testing setup for obj records, the comparison
functions for obj records, reftable_obj_record_cmp_void() and
reftable_obj_record_equal_void() are left untested.

Add tests for the same by using the wrapper functions
reftable_record_cmp() and reftable_record_equal() for
reftable_index_record_cmp_void() and reftable_index_record_equal_void()
respectively.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 9644f1de71..1f9c830631 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -307,6 +307,44 @@ static void test_key_roundtrip(void)
 	strbuf_release(&roundtrip);
 }
 
+static void test_reftable_obj_record_comparison(void)
+{
+
+	uint8_t id_bytes[] = { 0, 1, 2, 3, 4, 5, 6 };
+	uint64_t offsets[] = { 0, 16, 32, 48, 64, 80, 96, 112};
+	struct reftable_record in[3] = {
+		{
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj.hash_prefix = id_bytes,
+			.u.obj.hash_prefix_len = 7,
+			.u.obj.offsets = offsets,
+			.u.obj.offset_len = 8,
+		},
+		{
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj.hash_prefix = id_bytes,
+			.u.obj.hash_prefix_len = 7,
+			.u.obj.offsets = offsets,
+			.u.obj.offset_len = 5,
+		},
+		{
+			.type = BLOCK_TYPE_OBJ,
+			.u.obj.hash_prefix = id_bytes,
+			.u.obj.hash_prefix_len = 5,
+		},
+	};
+
+	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
+
+	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
+	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+
+	in[1].u.obj.offset_len = in[0].u.obj.offset_len;
+	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
+}
+
 static void test_reftable_obj_record_roundtrip(void)
 {
 	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
@@ -451,6 +489,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
+	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

