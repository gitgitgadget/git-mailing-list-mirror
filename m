Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687051667EC
	for <git@vger.kernel.org>; Wed, 29 May 2024 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966282; cv=none; b=fQdkq+ZHiUc2fsbDx8fP4zMXNkphRBQj18oI03cta0rIk4dyzcS0Owxw4HEECpQ+pzbxDsChnQzIWGwVUI3v7oSDmkW2rD2YfHPaH9fJX+MO3v2TorsCzETxZqB6WpJ/jLKLW8urDVjWIZFqk0G0hV3Pe6wYX5vHM9dJKHHDJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966282; c=relaxed/simple;
	bh=imdnwdQUYDNWkCiEh4mYuhPwizZLaM7MOlyvKNKB1vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwmTEryb5yv/1rX5+eCLuvrhdrhl5qxfMzuvV9tDVr1x21lDxfUDJmXjphuqVoYRtjMLN0ixL++I1+AwqrBq3vINn3xqmsUfTjVeFJmhy/RZ95ljpIJ++r2K4X1/FuatA6ZIl26bd6HWKkbj6obctMPrfT91Q0i9GUcnnT1AWqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4S1Snc8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4S1Snc8"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f8eba8f25eso1408769b3a.3
        for <git@vger.kernel.org>; Wed, 29 May 2024 00:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716966278; x=1717571078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJZL6qpmxYDLfog5CD0nPWSmmHVEn+XkBlmUnCocPwc=;
        b=m4S1Snc84afkEba1BnwbJMIRVYlPQiBxuhBf7733zO4PZPEPzjXqPGYICQfC+82pqJ
         B4QFF7OQvspcAMBoV/28pjI7s79tXeXa4OZnUCXxOFhxm5UZS87WFwChagymQUa5br86
         1yMvQy/PVtlb1e5ug/yE1ncCD5sAeEYJdF4W+5dUpW3Nwag+Qx3neGEWCOdo0DKDYcUx
         7eRmh5GAX/exWPj7GLNyZNKHcgu6WdKaS/ApKs+Vl25jhZaoYaQXfpZCypCmxBJY/pTH
         wDSlP5pxLbsVm9GhFCfNlo5r3qittlLgqMzceXoWPeSnWeJa3/PbehP0K63z/GZR7VOs
         nnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966278; x=1717571078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJZL6qpmxYDLfog5CD0nPWSmmHVEn+XkBlmUnCocPwc=;
        b=I4gRio+GMZ0CDC5uJAEF3X6PyGEkKhXhk+PyH3UUsYt7oG8bf2d623+NbaN9GgfReL
         3Ylz1oIydBkarpmYmUT2vO2Ro26VAfBZSB0Frsis41rGxearqf20UT/u0msuPyIF8HBQ
         YIrfHLm2MPZIsgYYEVoXH1HCVNXxlk2NNgqgRwk3kYRgw9SHy22ZXdVb1nXxPSdoblNE
         07TUmLGwTmcPCQMoLRy1oHcHOxRx0aGOyRo/4XLGguYz832b3J0ULm82hVcHx9BL1wXU
         bMb1NwOg2es6x8J6cTFfvJ2CyhBPpUQwkITDSuFSmDD9zHxbTXk/p72ercNQZjKg4ZdP
         i87w==
X-Gm-Message-State: AOJu0YzN3h97wQUqV1IvxX+uauhK31AjrmtC7V9ECjc7nzBGFgDbcM1f
	dJbgS/zyIOxiR9zuc3RVRZAqTPjFD78kjwQ9WcGabJTt4GLHmNp2pmrLhn850vo=
X-Google-Smtp-Source: AGHT+IGmWgtCDtM/8HbWkw/NdS00lb24420BAxUPeeDkITzxNvtbgfAJiHVQfT4bemtIvwPuixRTPw==
X-Received: by 2002:aa7:9316:0:b0:6f8:b990:aafb with SMTP id d2e1a72fcca58-6f8f2b48beamr14096139b3a.7.1716966278380;
        Wed, 29 May 2024 00:04:38 -0700 (PDT)
Received: from Ubuntu.. ([171.51.188.185])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ea03sm7473376b3a.39.2024.05.29.00.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:04:37 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v2 3/4] t: move tests from reftable/record_test.c to the new unit test
Date: Wed, 29 May 2024 12:25:11 +0530
Message-ID: <20240529070341.4248-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240529070341.4248-1-chandrapratap3519@gmail.com>
References: <--in-reply-to=20240528113856.8348-1-chandrapratap3519@gmail.com>
 <20240529070341.4248-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

common_prefix_size(), get_be24() and put_be24() are functions defined
in reftable/basics.{c, h}. Move the tests for these functions from
reftable/record_test.c to the newly ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/record_test.c           | 37 -----------------------------
 t/unit-tests/t-reftable-basics.c | 40 ++++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/reftable/record_test.c b/reftable/record_test.c
index c158ee79ff..58290bdba3 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -64,31 +64,6 @@ static void test_varint_roundtrip(void)
 	}
 }
 
-static void test_common_prefix(void)
-{
-	struct {
-		const char *a, *b;
-		int want;
-	} cases[] = {
-		{ "abc", "ab", 2 },
-		{ "", "abc", 0 },
-		{ "abc", "abd", 2 },
-		{ "abc", "pqr", 0 },
-	};
-
-	int i = 0;
-	for (i = 0; i < ARRAY_SIZE(cases); i++) {
-		struct strbuf a = STRBUF_INIT;
-		struct strbuf b = STRBUF_INIT;
-		strbuf_addstr(&a, cases[i].a);
-		strbuf_addstr(&b, cases[i].b);
-		EXPECT(common_prefix_size(&a, &b) == cases[i].want);
-
-		strbuf_release(&a);
-		strbuf_release(&b);
-	}
-}
-
 static void set_hash(uint8_t *h, int j)
 {
 	int i = 0;
@@ -258,16 +233,6 @@ static void test_reftable_log_record_roundtrip(void)
 	strbuf_release(&scratch);
 }
 
-static void test_u24_roundtrip(void)
-{
-	uint32_t in = 0x112233;
-	uint8_t dest[3];
-	uint32_t out;
-	put_be24(dest, in);
-	out = get_be24(dest);
-	EXPECT(in == out);
-}
-
 static void test_key_roundtrip(void)
 {
 	uint8_t buffer[1024] = { 0 };
@@ -411,9 +376,7 @@ int record_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_ref_record_roundtrip);
 	RUN_TEST(test_varint_roundtrip);
 	RUN_TEST(test_key_roundtrip);
-	RUN_TEST(test_common_prefix);
 	RUN_TEST(test_reftable_obj_record_roundtrip);
 	RUN_TEST(test_reftable_index_record_roundtrip);
-	RUN_TEST(test_u24_roundtrip);
 	return 0;
 }
diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index 55fcff12d9..b02ca02040 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -99,13 +99,38 @@ static void test_parse_names_drop_empty(void)
 
 static void test_common_prefix(void)
 {
-	struct strbuf s1 = STRBUF_INIT;
-	struct strbuf s2 = STRBUF_INIT;
-	strbuf_addstr(&s1, "abcdef");
-	strbuf_addstr(&s2, "abc");
-	check_int(common_prefix_size(&s1, &s2), ==, 3);
-	strbuf_release(&s1);
-	strbuf_release(&s2);
+	struct strbuf a = STRBUF_INIT;
+	struct strbuf b = STRBUF_INIT;
+	struct {
+		const char *a, *b;
+		int want;
+	} cases[] = {
+		{"abcdef", "abc", 3},
+		{ "abc", "ab", 2 },
+		{ "", "abc", 0 },
+		{ "abc", "abd", 2 },
+		{ "abc", "pqr", 0 },
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
+		strbuf_addstr(&a, cases[i].a);
+		strbuf_addstr(&b, cases[i].b);
+		check_int(common_prefix_size(&a, &b), ==, cases[i].want);
+		strbuf_reset(&a);
+		strbuf_reset(&b);
+	}
+	strbuf_release(&a);
+	strbuf_release(&b);
+}
+
+static void test_u24_roundtrip(void)
+{
+	uint32_t in = 0x112233;
+	uint8_t dest[3];
+	uint32_t out;
+	put_be24(dest, in);
+	out = get_be24(dest);
+	check_int(in, ==, out);
 }
 
 int cmd_main(int argc, const char *argv[])
@@ -116,6 +141,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_binsearch(), "binary search with binsearch works");
 	TEST(test_names_length(), "names_length retuns size of a NULL-terminated string array");
 	TEST(test_names_equal(), "names_equal compares NULL-terminated string arrays");
+	TEST(test_u24_roundtrip(), "put_be24 and get_be24 work");
 
 	return test_done();
 }
-- 
2.45.GIT

