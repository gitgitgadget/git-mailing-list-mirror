Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6716C6A9
	for <git@vger.kernel.org>; Tue, 28 May 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896385; cv=none; b=smnmCfCsHO/PFfK/aPAPTwrNZlJWQdlgsbG/P++G12+B2bRwrxZHZyFo60cqZPDD2knLg62s+Dk06Z/HwLHQALX45gBvx7BYiGmwxnSNMYGvbSs07l2KwNgMH2LIWsgMX29Al9Znqq7mpNTj+ySjUWrwJE6WNa4ggQGzfKn3baA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896385; c=relaxed/simple;
	bh=pMNUeOzn7M1rh+F5d04DQx+KV7WycS8NhBr4YkBuH/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZLOV95CGlgmKTOpaQvErHQ2Rgu08P76KM+yEyicQFHfycV6eUchlIlIYNyhwQ86gFp/+wG8JMSKboL2bj9HA4+9fzpeOonYRAc8JG3M/pGkaTlEiWhWZQl68HrPNhGWHhNODYMxkNCyi1zb5kSlsdpbu117slnEHOODY2oUC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OysKzo+P; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OysKzo+P"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-68197edc2d3so551215a12.2
        for <git@vger.kernel.org>; Tue, 28 May 2024 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716896383; x=1717501183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxD8BEJQJKG4AvOXMD02ezCH/SF0ooOMvhJ0z02cKUM=;
        b=OysKzo+PIGOqq+hSvBofqAceXtJfCIgesW9oaosx16DVCbEJt1ktncnmo292n61AEr
         4SycDXJetxKuLaHBKTie7hsVgiQJVhIMA0JzKqzXJSde4zXMcWpN1TVzX7XrqKu+/xE5
         Z/e9A2ZCVVtziNiHAfykkBVFxAyIQ3P4KlVlj0qG6irBh7lhHtyRXBKDsI2hsqu5lxsg
         dg0blZHbREony1zCiF7nUQ9ab2DQtfSQsc8oGYknRYLE72LTy1lOdI/NgwPPyyWJ8k4j
         /InfW77fUPZ4MRGMAR9vjBJCjJwx7Glwc+kwJI4NShjRrDZrbp4h6/ETVxgB4O3sgdNH
         zPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896383; x=1717501183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxD8BEJQJKG4AvOXMD02ezCH/SF0ooOMvhJ0z02cKUM=;
        b=MiEPjFD6AJC0YJmHsq74KmMxcEFCtnuTvqtKSALMIpbh86MNADXRl0WzgPpDgK0/Qh
         ehGx5VujVz5HBRlKt2CfBh8SOJcm9ilTN2tDUYN6/L+qis2cIdc46Hwnkffqbasa7JG4
         bPDrIVh4afg/Yqh5MVpw071stiX2WhoTkRwlS/dL5Ko1l79U4LuLx8BBTtrmRsr0rkbO
         pcvICtDMWFtnvU2HAvYjEuyrFca/uKZdlFDnLbAWOqp7IUPaqW7pZGJGaw1RFKxCGwn9
         reEJ6l95iyf3KqeNrqi4rM01G9mW5MFNRlEOsdovWtTrsPSYfR70AgZ+V/ZiwTxfcxE/
         j6kQ==
X-Gm-Message-State: AOJu0YxNduKTFH/ZPmJ3v/+ExtTfUTkRuF/udGKeTW6zvmNZtLzRdZMQ
	FAmMepI0OU5mfbKdzRQD2M6TIXdUXibpFstIa1KTFOG0fksNAC5cZow7xy/l
X-Google-Smtp-Source: AGHT+IHdrH9+maKCp+nOqOM3QVCWU46lvECyPcKf5MK05yKFMF4c1Iy3dhgKTBnLveotwdlSBSZjSw==
X-Received: by 2002:a05:6a21:1f03:b0:1af:9ee6:25c4 with SMTP id adf61e73a8af0-1b212f34931mr9951534637.42.1716896381585;
        Tue, 28 May 2024 04:39:41 -0700 (PDT)
Received: from Ubuntu.. ([171.51.165.3])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-682229ddfe5sm7375738a12.53.2024.05.28.04.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 04:39:41 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] t: improve upon reftable/basics_test.c in the unit testing framework
Date: Tue, 28 May 2024 17:00:03 +0530
Message-ID: <20240528113856.8348-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240528113856.8348-1-chandrapratap3519@gmail.com>
References: <20240528113856.8348-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance the new test for reftable/basics.{c, h} in the unit testing
framework. The enhancements include:
- Move tests for functions in reftable/basics.{c, h} from
reftable/record_test.c and reftable/stack_test.c to the new unit test.
- Add tests for functions that are not currently tested, like put_be16.
- Improve the test-cases for the already existing tests.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/record_test.c           | 37 ---------------
 reftable/stack_test.c            | 25 -----------
 t/unit-tests/t-reftable-basics.c | 77 +++++++++++++++++++++++++++-----
 3 files changed, 65 insertions(+), 74 deletions(-)

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
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 7889f818d1..6f6af11e53 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -102,29 +102,6 @@ static void test_read_file(void)
 	(void) remove(fn);
 }
 
-static void test_parse_names(void)
-{
-	char buf[] = "line\n";
-	char **names = NULL;
-	parse_names(buf, strlen(buf), &names);
-
-	EXPECT(NULL != names[0]);
-	EXPECT(0 == strcmp(names[0], "line"));
-	EXPECT(NULL == names[1]);
-	free_names(names);
-}
-
-static void test_names_equal(void)
-{
-	char *a[] = { "a", "b", "c", NULL };
-	char *b[] = { "a", "b", "d", NULL };
-	char *c[] = { "a", "b", NULL };
-
-	EXPECT(names_equal(a, a));
-	EXPECT(!names_equal(a, b));
-	EXPECT(!names_equal(a, c));
-}
-
 static int write_test_ref(struct reftable_writer *wr, void *arg)
 {
 	struct reftable_ref_record *ref = arg;
@@ -1048,8 +1025,6 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 int stack_test_main(int argc, const char *argv[])
 {
 	RUN_TEST(test_empty_add);
-	RUN_TEST(test_names_equal);
-	RUN_TEST(test_parse_names);
 	RUN_TEST(test_read_file);
 	RUN_TEST(test_reflog_expire);
 	RUN_TEST(test_reftable_stack_add);
diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index b6088e1ddd..53fce33d53 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -51,36 +51,87 @@ static void test_names_length(void)
 	check_int(names_length(a), ==, 2);
 }
 
+static void test_names_equal(void)
+{
+	char *a[] = { "a", "b", "c", NULL };
+	char *b[] = { "a", "b", "d", NULL };
+	char *c[] = { "a", "b", NULL };
+
+	check(names_equal(a, a));
+	check(!names_equal(a, b));
+	check(!names_equal(a, c));
+}
+
 static void test_parse_names_normal(void)
 {
-	char in[] = "a\nb\n";
+	char in1[] = "line\n";
+	char in2[] = "a\nb\nc";
 	char **out = NULL;
-	parse_names(in, strlen(in), &out);
+	parse_names(in1, strlen(in1), &out);
+	check_str(out[0], "line");
+	check(!out[1]);
+	free_names(out);
+
+	parse_names(in2, strlen(in2), &out);
 	check_str(out[0], "a");
 	check_str(out[1], "b");
-	check(!out[2]);
+	check_str(out[2], "c");
+	check(!out[3]);
 	free_names(out);
 }
 
 static void test_parse_names_drop_empty(void)
 {
-	char in[] = "a\n\n";
+	char in[] = "a\n\nb\n";
 	char **out = NULL;
 	parse_names(in, strlen(in), &out);
 	check_str(out[0], "a");
-	check(!out[1]);
+	/* simply '\n' should be dropped as empty string */
+	check_str(out[1], "b");
+	check(!out[2]);
 	free_names(out);
 }
 
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
+static void test_be_roundtrip(void)
+{
+	uint32_t in = 0x112233;
+	uint8_t dest[3];
+	uint32_t out;
+	/* test put_be24 and get_be24 roundtrip */
+	put_be24(dest, in);
+	out = get_be24(dest);
+	check_int(in, ==, out);
+	/* test put_be16 and get_be16 roundtrip */
+	in = 0xfef1;
+	put_be16(dest, in);
+	out = get_be16(dest);
+	check_int(in, ==, out);
 }
 
 int cmd_main(int argc, const char *argv[])
@@ -90,6 +141,8 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_parse_names_drop_empty(), "parse_names drops empty string");
 	TEST(test_binsearch(), "binary search with binsearch works");
 	TEST(test_names_length(), "names_length retuns size of a NULL-terminated string array");
+	TEST(test_names_equal(), "names_equal compares NULL-terminated string arrays");
+	TEST(test_be_roundtrip(), "put_be24, get_be24 and put_be16 work");
 
 	return test_done();
 }
-- 
2.45.GIT

