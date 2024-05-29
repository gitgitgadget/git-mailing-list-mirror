Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86962F37
	for <git@vger.kernel.org>; Wed, 29 May 2024 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969653; cv=none; b=qdIUw5g+UZ35rAUKD9XJmmpT7CpBtOLiwMkw8kwcSLFFXDvcF7Fal9PW/A0QWu92J2bGAOr6Q4cHTq2+nreuEDXEGUK0+tGHG7TUyFfkhLFvNynZI80JWyT2EwSvWk5yUmiqTtir9eyEH+6cqo0doSLBvT3yw800MUWfWbUT8w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969653; c=relaxed/simple;
	bh=41qOgnAUikFUYpaM1JjiMT4UnzH2JxIOBoKWxADfhvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWiuUBer8TKK0+t2dTkl/Xt2XEMiaxGB+DxWu2JPcCpPQo/NydUfAPq/YkBFI42Zx51Ryhg3pHnfFGhqrRijTHP7Ys1ixmurAeo3fYP63z12w6BoWe1/WnCay0ug8+zRhP8+v4f90/vJptb//sNbt4ypIWCGW6V8ptqmf/nL+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5BO9ior; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5BO9ior"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f48b825d8cso12813425ad.2
        for <git@vger.kernel.org>; Wed, 29 May 2024 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716969651; x=1717574451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FflWN+BtRY1niIAq3UL0dUpHXHPAkYpP9CiSAXIHib0=;
        b=Q5BO9ior3/JCUa5i3+eINR4kdpzhJknbq12y64xmRiBqf1DMIqsCoGXubKM05/DNvh
         2R0L1szjzwcvpAgICtL7MOKUxkpYuYSGR6nCw/5Lek+Sgw1WDXdrhRzrZ08d9gD7053+
         H08jOU/vq74Y3bYCyiU/etiiTx3a0gm2PDOYGh0tT54yDBq11MGagil7YkX0ZKnhe3RU
         8XOkvWe2W+mbW4QeXSAQc6m9v5pDOUdmqNItOVd1tM4cZfhjaLXGmzqe3l3WsgOCfMwf
         3PxLvjYV+P7goWXlh8S+iOUhV+H2g49SQVxvKoMSgGQbd5HuZSk1oGcoXA2vfv6N9dix
         O4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716969651; x=1717574451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FflWN+BtRY1niIAq3UL0dUpHXHPAkYpP9CiSAXIHib0=;
        b=i1TI7RNDd+Vi1gw0oVdOFY8C1SWcjumhWEKejbgL7AyT7PnE2K9u2bjhDuqKW0CKkG
         IDkMXJURI+orsh62PYHww7F9VDIieYVrd+qiSmUAwk3URysUUVApbblfBQ5Qtjd9wVGI
         orvUVYjuhjIIQgku82IQEwF/m+LKqX9+gfQdBqlBe5mQfismUx41yeyVvnCkfdJ8qA+c
         H+ilKdcoB7RQJnR+Q7FpRZcgw52rYVMZe58HQ91vwiznEhGwELSy9gQ972s5JqHgMJoQ
         EFUHrk3SDg24yvIs3fX5ggc69XfPdh9EtbetOOJtQvKaatYvkwTRZY8W9M+QNX3PVwLH
         P2HQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/yXuKrqt3kSuIR+n2rZBAWmN/4vJtX2yRTA8a2JlEbfMOWFe+SC2rTk2ZmSCwnF2WE/EjZA2NzBDH/ujzHI1a4NGI
X-Gm-Message-State: AOJu0Yy1te2MBf8Ol6YBsPD/uUozx2MrjfP0kS0tPbfZTqg/ShhopHs0
	6WF1FAw3oRied9yqV14VqwzMDIf6qA7owEqNtsoht4h6SjLsbgoK
X-Google-Smtp-Source: AGHT+IE7Nw7kph9S3Kn85/SZjHLtKI4nhfoAJI2I8LYGpU6oMonY5ynx+F7kewaTEVfe86t602Z78g==
X-Received: by 2002:a17:903:2451:b0:1f3:4f23:455d with SMTP id d9443c01a7336-1f449026aaemr150115275ad.49.1716969650949;
        Wed, 29 May 2024 01:00:50 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f478a651f6sm68290875ad.101.2024.05.29.01.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:00:50 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: shyamthakkar001@gmail.com
Cc: ach.lumap@gmail.com,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im
Subject: [GSoC][PATCH v5 0/2] t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash
Date: Wed, 29 May 2024 13:30:28 +0530
Message-ID: <20240529080030.64410-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240526084345.24138-1-shyamthakkar001@gmail.com>
References: <20240526084345.24138-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5:
- addressd Patrick's feedback about formatting
- changed macros to be in do while loop instead of simple block,
  according to Patrick's feedback

Ghanshyam Thakkar (2):
  strbuf: introduce strbuf_addstrings() to repeatedly add a string
  t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash

 Makefile                    |  1 +
 builtin/submodule--helper.c |  4 +-
 json-writer.c               |  5 +--
 strbuf.c                    |  9 ++++
 strbuf.h                    |  5 +++
 t/t0015-hash.sh             | 56 ------------------------
 t/unit-tests/t-hash.c       | 86 +++++++++++++++++++++++++++++++++++++
 7 files changed, 103 insertions(+), 63 deletions(-)
 delete mode 100755 t/t0015-hash.sh
 create mode 100644 t/unit-tests/t-hash.c

Range-diff against v4:
1:  cd831fabf5 = 1:  cd831fabf5 strbuf: introduce strbuf_addstrings() to repeatedly add a string
2:  6ce8f57af1 ! 2:  c82ead8e48 t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash
    @@ t/unit-tests/t-hash.c (new)
     +		return;
     +	}
     +
    -+	for (int i = 1; i < ARRAY_SIZE(hash_algos); i++) {
    ++	for (size_t i = 1; i < ARRAY_SIZE(hash_algos); i++) {
     +		git_hash_ctx ctx;
     +		unsigned char hash[GIT_MAX_HEXSZ];
     +		const struct git_hash_algo *algop = &hash_algos[i];
    @@ t/unit-tests/t-hash.c (new)
     +
     +/* Works with a NUL terminated string. Doesn't work if it should contain a NUL character. */
     +#define TEST_HASH_STR(data, expected_sha1, expected_sha256) \
    -+	{ \
    ++	do { \
     +		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
     +		TEST(check_hash_data(data, strlen(data), expected_hashes), \
     +		     "SHA1 and SHA256 (%s) works", #data); \
    -+	}
    ++	} while (0)
     +
     +/* Only works with a literal string, useful when it contains a NUL character. */
     +#define TEST_HASH_LITERAL(literal, expected_sha1, expected_sha256) \
    -+	{ \
    ++	do { \
     +		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
     +		TEST(check_hash_data(literal, (sizeof(literal) - 1), expected_hashes), \
     +		     "SHA1 and SHA256 (%s) works", #literal); \
    -+	}
    ++	} while (0)
     +
     +int cmd_main(int argc, const char **argv)
     +{
    @@ t/unit-tests/t-hash.c (new)
     +	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
     +	strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 100000);
     +
    -+	TEST_HASH_STR(
    -+		"", "da39a3ee5e6b4b0d3255bfef95601890afd80709",
    ++	TEST_HASH_STR("",
    ++		"da39a3ee5e6b4b0d3255bfef95601890afd80709",
     +		"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
    -+	TEST_HASH_STR(
    -+		"a", "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8",
    ++	TEST_HASH_STR("a",
    ++		"86f7e437faa5a7fce15d1ddcb9eaeaea377667b8",
     +		"ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");
    -+	TEST_HASH_STR(
    -+		"abc", "a9993e364706816aba3e25717850c26c9cd0d89d",
    ++	TEST_HASH_STR("abc",
    ++		"a9993e364706816aba3e25717850c26c9cd0d89d",
     +		"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
    -+	TEST_HASH_STR(
    -+		"message digest", "c12252ceda8be8994d5fa0290a47231c1d16aae3",
    ++	TEST_HASH_STR("message digest",
    ++		"c12252ceda8be8994d5fa0290a47231c1d16aae3",
     +		"f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650");
    -+	TEST_HASH_STR(
    -+		"abcdefghijklmnopqrstuvwxyz", "32d10c7b8cf96570ca04ce37f2a19d84240d3a89",
    ++	TEST_HASH_STR("abcdefghijklmnopqrstuvwxyz",
    ++		"32d10c7b8cf96570ca04ce37f2a19d84240d3a89",
     +		"71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73");
    -+	TEST_HASH_STR(
    -+		aaaaaaaaaa_100000.buf, "34aa973cd4c4daa4f61eeb2bdbad27316534016f",
    ++	TEST_HASH_STR(aaaaaaaaaa_100000.buf,
    ++		"34aa973cd4c4daa4f61eeb2bdbad27316534016f",
     +		"cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0");
    -+	TEST_HASH_STR(
    -+		alphabet_100000.buf, "e7da7c55b3484fdf52aebec9cbe7b85a98f02fd4",
    ++	TEST_HASH_STR(alphabet_100000.buf,
    ++		"e7da7c55b3484fdf52aebec9cbe7b85a98f02fd4",
     +		"e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35");
    -+	TEST_HASH_LITERAL(
    -+		"blob 0\0", "e69de29bb2d1d6434b8b29ae775ad8c2e48c5391",
    ++	TEST_HASH_LITERAL("blob 0\0",
    ++		"e69de29bb2d1d6434b8b29ae775ad8c2e48c5391",
     +		"473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813");
    -+	TEST_HASH_LITERAL(
    -+		"blob 3\0abc", "f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f",
    ++	TEST_HASH_LITERAL("blob 3\0abc",
    ++		"f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f",
     +		"c1cf6e465077930e88dc5136641d402f72a229ddd996f627d60e9639eaba35a6");
    -+	TEST_HASH_LITERAL(
    -+		"tree 0\0", "4b825dc642cb6eb9a060e54bf8d69288fbee4904",
    ++	TEST_HASH_LITERAL("tree 0\0",
    ++		"4b825dc642cb6eb9a060e54bf8d69288fbee4904",
     +		"6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321");
     +
     +	strbuf_release(&aaaaaaaaaa_100000);
-- 
2.45.1

