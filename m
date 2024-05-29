Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA14187337
	for <git@vger.kernel.org>; Wed, 29 May 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002956; cv=none; b=TJCBefZ1+62J0ty9WMAo/CKxGk2i2abwg4LVL4AQTaTGJj1uFDRRQsN8xjblneGYfYTiDr8p0aP3NGs+/gfDQuX+zhcBe++xOJa7Z93cnB32B2038eDLz5POCgMeXg0bX9n+Jn7WycYArwi5brYLkkcvKT6dTEfGoE/PkXTdSEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002956; c=relaxed/simple;
	bh=imdnwdQUYDNWkCiEh4mYuhPwizZLaM7MOlyvKNKB1vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5tUk/SdQqBprjoqH096Jh+E7TXDcPgScuIAhPsFcmkehRfA4hul5yvz6po95ErcJ+pSvW+6Q+mP0TEPd6wAzV8M+pecBlhzc2EVgoXFqBGx4fRkpq0NeZkGR75FA5KZQXWxuN21sSjhH594cycVF3ExMOEwqP4nkzIqrWVEl0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpPl+V9Y; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpPl+V9Y"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-681bee6bb13so156964a12.1
        for <git@vger.kernel.org>; Wed, 29 May 2024 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717002954; x=1717607754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJZL6qpmxYDLfog5CD0nPWSmmHVEn+XkBlmUnCocPwc=;
        b=mpPl+V9YL5zg98F/Txf6YmHBEOQoT08sdYyXHIP2CZiUNb5tpoFomlBK1A2ZtrJwXY
         tEatBFvGLxJdGl2D3+CfMA6qz6duRhPalvAIhyyGyRPkU2S8QqwZNYJSJUjN5WL3tgUy
         4o9MPrxZ+CqpHl/lBmB2P+kbdMij3zP6nC7piHjpY46ixe5r6FT4QCc5AgEZvL15qvYI
         mdnm2r5OKfZsgDhYn8zr6J/0HMkMVp7mQNtmGCIACYdV8CxXcdDupl8pa66oVsbB9CJ2
         7x9A0GVEPiXPcMlRzdrZFzYkXiiusPRYe9ENFHiqhavNKWpIgNL8lVBPTiOgsGIELYK6
         7xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717002954; x=1717607754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJZL6qpmxYDLfog5CD0nPWSmmHVEn+XkBlmUnCocPwc=;
        b=t0Phodh+frGRoqfmZhV+4fMN5X7Na3GUJmvaG/YG3J01kFXk2rHBKuchsi0ySQ+ai6
         Q0mwLsmjKwh3wtcjEgb2Y0sKOqNd39tx55CNJs4Rp8JpMWECwN2AKP1UdQWnLH94nWet
         tpwet0mDlTvh3T00ofUMCymiM0IYo0MmUscZpbz5aV25XLaTPuHM7TJyLiAf8wh/sKGI
         UdtlezUW2IP9Xr9C/bxP2XURQHwX3I3RJn0cE+up6V0UhXrxssiKZzxbTF7k8oyMDwnq
         CZzK/VZSRcc5Q3s6lWUvMAO7G6wbGy/H904iFAZu2PggFG3BEdhkKx6NABgl6isHoQ4G
         jZTQ==
X-Gm-Message-State: AOJu0Yyme3l3KwQk7Rlhi3Lnv5krIolODtQd2ZxeqJvy7W2K+BvMdHh2
	IpH94bmSbRb/o5g4QTVounylqRSI4hp1OlXRfbGXliIJ8i1WBg1EZ2j0OxsPt+w=
X-Google-Smtp-Source: AGHT+IHadA/2DERl0/vUgi/0tYx0Iee4DvKIe3MT0csbE0CkFDa+i4s+5iG4SCdwIsjYraDn0SLhGA==
X-Received: by 2002:a17:902:d485:b0:1f3:1092:ab45 with SMTP id d9443c01a7336-1f4eaaebf79mr34448495ad.26.1717002953702;
        Wed, 29 May 2024 10:15:53 -0700 (PDT)
Received: from Ubuntu.. ([171.51.169.75])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f4757734b6sm79720225ad.234.2024.05.29.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 10:15:53 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v3 3/5] t: move tests from reftable/record_test.c to the new unit test
Date: Wed, 29 May 2024 22:29:29 +0530
Message-ID: <20240529171439.18271-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240529171439.18271-1-chandrapratap3519@gmail.com>
References: <20240529070341.4248-1-chandrapratap3519@gmail.com>
 <20240529171439.18271-1-chandrapratap3519@gmail.com>
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

