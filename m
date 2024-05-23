Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88108493
	for <git@vger.kernel.org>; Fri, 24 May 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716508836; cv=none; b=XwVgAi8q1NAUNB80Wj3AGQDwptguOmhZP3tb4a3VAiF0tUL6Z3ym4aVL6/4pYdVEKUXx66zNFMCPK0OY3qbdDcgfp/sLjvIsbVEqZmbvx7VDLo9kX9aYpMRmMxn4khACauhJw1YSwxQ++VZDSCjotq95g0p3l1TWlWkHIFDjk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716508836; c=relaxed/simple;
	bh=Ur5CYVL+OVTXt+dZqGwgtCn+VLtv73i1TbPphlDAQI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKJDgwens/sAJvDWSYbANF0B+EONZ+76vzqr82dmWTz8dk3/MtJI+pgkJ2ld1r0jh+kxJxtzOjd3J7f4+deveTLM0R9DodVbjnlP5GpUhfPH//9j9rm/53dHwx4NKiR0oT8PgwYQC5Tn/cFX8BNsFcOzCGHU6UNomVLQXM/iBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gu4gx0K1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu4gx0K1"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f8e9878514so329039b3a.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716508834; x=1717113634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqF14g+xzfp6dpH+QnGhFvHPX0wcZ8IzypPesrV3JjU=;
        b=gu4gx0K1xi/btqkM03uBMi99BlIXx0g/S8b3sEypEGPuscshlwJCXsyMnUGCCj256M
         Y634wVedU9LJwlxGzJaM7MCdO8UxPYzas9q2pNSxPyPqJQ2JDeqp/gq8+co6lYZ2BKoU
         Jk7ic4shYS9EO4upS3nfwP51FhDe9cPGUW7MfRxFs5iRXMqKsBLIQmXW+Yhia4Uksn7t
         2cy1NaBA1vkMZc96YwJB6lP3I15BkRbOHDjpOJifXKzeTPSkM1TN4BSMtKm6fJAq2zKo
         1DozQAQ5PX/TR2nGNjLi1CQDTxyX7ZvKAT8nJi9XILd4gqzB7DPWNLc7gpydYscjfPB7
         gASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716508834; x=1717113634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqF14g+xzfp6dpH+QnGhFvHPX0wcZ8IzypPesrV3JjU=;
        b=SPItyiVPawt1xhwTjds2drkUETkNqQ85sndDny+cFPKzFxfdnj1AF0e/qAi2LjE7YM
         ucuI0gMW+IrdbIcDPqyZ8orceUd8QzIeybyf/DnMi9MTYkLINWZUTkdpyy3BiWvb8Pys
         UBl5C2xE1eGm6HVfHLq6x+lYRhJCtzMVvUfKoqT+szv+Ia8WjvudcJ2cqZe7tw3LHKdX
         /F00swbyA1hUaThnINmd8idKiW513/JgUd1dDTJJjysyk/KJyoh5lj2ol7slGOa2U6Ih
         mlmeIvZW3HFAYwQ+zMldf7gGk7iW6qLcJW8yKrBhk4ETvVElV8VYkEXC4yTn5QMEX4Pu
         xvgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfO4WuUNEq9eHF824hEZRwvYFbkgcun0nj4KoLWRLdWmqHz1g65TSmVeOJpRu4n4kyLr0FoUBfkaKKXA2qZxd40U26
X-Gm-Message-State: AOJu0YyT7C8IjGaWIE2sLGw4QkDrQByqLG/kN8sJvucKFlTouUWrIKqj
	K+Y6lRnRWPE84tcLkajOcMeARYdEiLhmodIjNwBhcoKpSWOkUN/iWAVZrzaR1Po=
X-Google-Smtp-Source: AGHT+IF7AdXNW4O/xc9vM0QkBZvQDVpjqPYsBLspEBbgKK7Ia/ed9gl9WutAGsHDNAIeRZT1yjGgZg==
X-Received: by 2002:a05:6a20:2446:b0:1af:6911:7ff4 with SMTP id adf61e73a8af0-1b212cc727amr1253181637.7.1716508833917;
        Thu, 23 May 2024 17:00:33 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc05ab4asm165454b3a.59.2024.05.23.17.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 17:00:33 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: ach.lumap@gmail.com
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im
Subject: [PATCH v3 3/3] t/: port helper/test-sha256.c to unit-tests/t-hash.c
Date: Fri, 24 May 2024 05:29:45 +0530
Message-ID: <20240523235945.26833-4-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523235945.26833-1-shyamthakkar001@gmail.com>
References: <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240523235945.26833-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t/helper/test-sha256 and t/t0015-hash test the hash implementation of
SHA-256 in Git with basic SHA-256 hash values. Port them to the new
unit testing framework for better debugging, simplicity and faster
runtime. The necessary building blocks are already implemented in
t-hash in the previous commit which ported test-sha1.

The 'sha256' subcommand of test-tool is still not removed, because it
is used by pack_trailer() in lib-pack.sh, which is used in many tests
of the t53** series.

Helped-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Co-authored-by: Achu Luma <ach.lumap@gmail.com>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t0015-hash.sh       | 34 ----------------------------------
 t/unit-tests/t-hash.c | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 34 deletions(-)
 delete mode 100755 t/t0015-hash.sh

diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
deleted file mode 100755
index 2264e702d5..0000000000
--- a/t/t0015-hash.sh
+++ /dev/null
@@ -1,34 +0,0 @@
-#!/bin/sh
-
-test_description='test basic hash implementation'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-test_expect_success 'test basic SHA-256 hash values' '
-	test-tool sha256 </dev/null >actual &&
-	grep e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 actual &&
-	printf "a" | test-tool sha256 >actual &&
-	grep ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb actual &&
-	printf "abc" | test-tool sha256 >actual &&
-	grep ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad actual &&
-	printf "message digest" | test-tool sha256 >actual &&
-	grep f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650 actual &&
-	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha256 >actual &&
-	grep 71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73 actual &&
-	# Try to exercise the chunking code by turning autoflush on.
-	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" |
-		test-tool sha256 >actual &&
-	grep cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0 actual &&
-	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" |
-		test-tool sha256 >actual &&
-	grep e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35 actual &&
-	printf "blob 0\0" | test-tool sha256 >actual &&
-	grep 473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813 actual &&
-	printf "blob 3\0abc" | test-tool sha256 >actual &&
-	grep c1cf6e465077930e88dc5136641d402f72a229ddd996f627d60e9639eaba35a6 actual &&
-	printf "tree 0\0" | test-tool sha256 >actual &&
-	grep 6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321 actual
-'
-
-test_done
diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
index 89dfea9cc1..0f86cd3730 100644
--- a/t/unit-tests/t-hash.c
+++ b/t/unit-tests/t-hash.c
@@ -32,11 +32,24 @@ static void check_hash_data(const void *data, size_t data_length,
 	TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GIT_HASH_SHA1), \
 	     "SHA1 (%s) works", #literal)
 
+
+/* Works with a NUL terminated string. Doesn't work if it should contain a NUL  character. */
+#define TEST_SHA256_STR(data, expected) \
+	TEST(check_hash_data(data, strlen(data), expected, GIT_HASH_SHA256), \
+	     "SHA256 (%s) works", #data)
+
+/* Only works with a literal string, useful when it contains a NUL character. */
+#define TEST_SHA256_LITERAL(literal, expected) \
+	TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GIT_HASH_SHA256), \
+	     "SHA256 (%s) works", #literal)
+
 int cmd_main(int argc, const char **argv)
 {
 	struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
+	struct strbuf alphabet_100000 = STRBUF_INIT;
 
 	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
+	strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 100000);
 
 	TEST_SHA1_STR("", "da39a3ee5e6b4b0d3255bfef95601890afd80709");
 	TEST_SHA1_STR("a", "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8");
@@ -48,7 +61,19 @@ int cmd_main(int argc, const char **argv)
 	TEST_SHA1_LITERAL("blob 3\0abc", "f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f");
 	TEST_SHA1_LITERAL("tree 0\0", "4b825dc642cb6eb9a060e54bf8d69288fbee4904");
 
+	TEST_SHA256_STR("", "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
+	TEST_SHA256_STR("a", "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");
+	TEST_SHA256_STR("abc", "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
+	TEST_SHA256_STR("message digest", "f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650");
+	TEST_SHA256_STR("abcdefghijklmnopqrstuvwxyz", "71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73");
+	TEST_SHA256_STR(aaaaaaaaaa_100000.buf, "cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0");
+	TEST_SHA256_STR(alphabet_100000.buf, "e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35");
+	TEST_SHA256_LITERAL("blob 0\0", "473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813");
+	TEST_SHA256_LITERAL("blob 3\0abc", "c1cf6e465077930e88dc5136641d402f72a229ddd996f627d60e9639eaba35a6");
+	TEST_SHA256_LITERAL("tree 0\0", "6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321");
+
 	strbuf_release(&aaaaaaaaaa_100000);
+	strbuf_release(&alphabet_100000);
 
 	return test_done();
 }
-- 
2.45.1

