Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36E137C35
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745190; cv=none; b=TpFDyzhYOo5XSQtwKOW0OafDSVce8hNkhI7jXu8XmN3uFu5f3ekj1cCC6e7CvvxUCb3+NViXjmWIDKhfxBP2LAWQHGcHZ/ovrbAO9QlwIa9NOz6yDi36/nNkC3PIjL5vM/Zx0gUOsea9K417BTzK1r3XiV9riJNYAMr8Amv/smc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745190; c=relaxed/simple;
	bh=Ch9IZEpNJ0cH6eYonm3vUx7fLgsy+IIMfyoZyxabwXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzuBkGpcZwGMfS5s7vGZhyH+T8G0rHfWbubd3iVEkwdF1L2epTTHf6L/2tWChYjbF+gTUTVPUnWFa7gFfr/2YMH0aspWSdsrlmBHSdWgNDqovTYqvtC8qnMWyu4WBOcgRFAY3BEWkhOw/Uc96m6LXABe1r6bhKOFtht4bwnK0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+0i1jlC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+0i1jlC"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc49c1f3e5so41979355ad.1
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721745188; x=1722349988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TO9HpLg2gW7SQ0bGvzar5ZyGO7efRxvFdcyIwYNcC7k=;
        b=g+0i1jlCQlLTR/cSE4HGUKxuSpXnBW8TupkJe6yQV9kUArhTdi1wg3BuyuTkPocUMC
         +aADHPuysDT3VWEUl8sm7EAhSK73eYUzqLvkO/Oe4G1k90iMHMdQSJOgme9KdpJ85CKg
         1h9QTxgd5yN231Dwy3B2xG6KqMdCkE1xb6jWKzoAJnhgpHIm7wlWWF78goAdgASGutAs
         H57uRvGoN5d3yKjzAl9gsZPuG1+mLIxKuTmm5fz4udWUdQr33SGXnRpBURTgC9ryhU/y
         tBYSafm8ugGJUZ2tQiNXek/Ye+2L/GXgpnWI9yxZn7buImX0rkO2SzCXTRMtaMIZSYp+
         c9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745188; x=1722349988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TO9HpLg2gW7SQ0bGvzar5ZyGO7efRxvFdcyIwYNcC7k=;
        b=j4ewI6IiMNV+zjhh9TK8Ztx87rcKW+IqO3rn3u9cM4PlBj4QcH7AoY3j0xxk+10VIt
         n27uDOPH9D2ru4ZKDILHiFYkobyh7JJA1ER1cuqLDX7SV2O+n87gnXYevKWv3twhkF3d
         ZCP4KwCHJwJRgbGk562OTbjCKBS5KZbkw4DpynoXAJ0xn6GZTZdQifLfKfAsICVlOIY3
         xvFjai3DRVRAwUIBZz/QzVF8GfjZdYEVtySr+lFLV4cLaK+KbsLe/Aa2oq5ywXHHnONn
         mA814ae8ast49tB4uys7HwLFsbbKu1OJGlWKc3D7SwVu9ESKBZgbFR6ayLBzCr1ioj85
         QOdA==
X-Gm-Message-State: AOJu0YyjOUqXYbs4boMh7BMJ7FpJmoSpfiZDCksSxVx2UZDzGd1uclQQ
	PiptvFunOL84vMp0gZoO9Gjtl10sqyTF0fOxM1cOhZsc7P+4cIyC+1ovszI/rp4=
X-Google-Smtp-Source: AGHT+IGsX55sLP2iwkg4BKSve7DXUkOAYMQcXyfewffXuvy4fxvrc7yK5EJk51qLKj2P+HqwgLPvBg==
X-Received: by 2002:a17:902:fac8:b0:1fb:dedd:aa65 with SMTP id d9443c01a7336-1fd74660a72mr50626625ad.42.1721745187412;
        Tue, 23 Jul 2024 07:33:07 -0700 (PDT)
Received: from Ubuntu.. ([223.176.63.81])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f256c09sm75301305ad.2.2024.07.23.07.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:33:06 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v5 0/7] t: port reftable/pq_test.c to the unit testing framework 
Date: Tue, 23 Jul 2024 19:47:10 +0530
Message-ID: <20240723143032.4261-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240614095136.12052-1-chandrapratap3519@gmail.com>
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reftable library comes with self tests, which are exercised
as part of the usual end-to-end tests and are designed to
observe the end-user visible effects of Git commands. What it
exercises, however, is a better match for the unit-testing
framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
2023-12-09), which is designed to observe how low level
implementation details, at the level of sequences of individual
function calls, behave.

Hence, port reftable/pq_test.c to the unit testing framework and
improve upon the ported test. The first two patches in the series
are preparatory cleanup, the third patch moves the test to the unit
testing framework, and the rest of the patches improve upon the
ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v5:
- Rebase the branch on top of the  latest master branch
- Rename tests according to unit-tests' conventions
- remove 'pq_test_main()' from reftable/reftable-test.h

CI/PR for v5: https://github.com/gitgitgadget/git/pull/1745

Chandra Pratap(7):
reftable: remove unncessary curly braces in reftable/pq.c
reftable: change the type of array indices to 'size_t' in reftable/pq.c
t: move reftable/pq_test.c to the unit testing framework
t-reftable-pq: make merged_iter_pqueue_check() static
t-reftable-pq: make merged_iter_pqueue_check() callable by reference
t-reftable-pq: add test for index based comparison
t-reftable-pq: add tests for merged_iter_pqueue_top()

Makefile                     |   2 +-
reftable/pq.c                |  29 +++-----
reftable/pq.h                |   1 -
reftable/pq_test.c           |  74 ---------------------
reftable/reftable-tests.h    |   1 -
t/helper/test-reftable.c     |   1 -
t/unit-tests/t-reftable-pq.c | 155 +++++++++++++++++++++++++++++++++++++++++++
7 files changed, 166 insertions(+), 97 deletions(-)

Range-diff against v4:
<rebase commits>
  1:  d3c5605ea2 = 382:  acd9d26aaf reftable: remove unncessary curly braces in reftable/pq.c
  2:  3c333e7770 = 383:  2e0986207b reftable: change the type of array indices to 'size_t' in reftable/pq.c
  3:  bf547f705a ! 384:  df06b6d604 t: move reftable/pq_test.c to the unit testing framework
    @@ Commit message
         t: move reftable/pq_test.c to the unit testing framework

         reftable/pq_test.c exercises a priority queue defined by
    -    reftable/pq.{c, h}. Migrate reftable/pq_test.c to the unit
    -    testing framework. Migration involves refactoring the tests
    -    to use the unit testing framework instead of reftable's test
    -    framework.
    +    reftable/pq.{c, h}. Migrate reftable/pq_test.c to the unit testing
    +    framework. Migration involves refactoring the tests to use the unit
    +    testing framework instead of reftable's test framework, and
    +    renaming the tests to align with unit-tests' standards.

         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

      ## Makefile ##
    -@@ Makefile: THIRD_PARTY_SOURCES += sha1dc/%
    - UNIT_TEST_PROGRAMS += t-ctype
    - UNIT_TEST_PROGRAMS += t-mem-pool
    +@@ Makefile: UNIT_TEST_PROGRAMS += t-oidmap
    + UNIT_TEST_PROGRAMS += t-oidtree
      UNIT_TEST_PROGRAMS += t-prio-queue
    + UNIT_TEST_PROGRAMS += t-reftable-basics
     +UNIT_TEST_PROGRAMS += t-reftable-pq
    + UNIT_TEST_PROGRAMS += t-reftable-record
      UNIT_TEST_PROGRAMS += t-strbuf
      UNIT_TEST_PROGRAMS += t-strcmp-offset
    - UNIT_TEST_PROGRAMS += t-trailer
    -@@ Makefile: REFTABLE_TEST_OBJS += reftable/basics_test.o
    +@@ Makefile: REFTABLE_OBJS += reftable/writer.o
      REFTABLE_TEST_OBJS += reftable/block_test.o
      REFTABLE_TEST_OBJS += reftable/dump.o
      REFTABLE_TEST_OBJS += reftable/merged_test.o
     -REFTABLE_TEST_OBJS += reftable/pq_test.o
    - REFTABLE_TEST_OBJS += reftable/record_test.o
      REFTABLE_TEST_OBJS += reftable/readwrite_test.o
      REFTABLE_TEST_OBJS += reftable/stack_test.o
    + REFTABLE_TEST_OBJS += reftable/test_framework.o
    +
    + ## reftable/reftable-tests.h ##
    +@@ reftable/reftable-tests.h: license that can be found in the LICENSE file or at
    + int basics_test_main(int argc, const char **argv);
    + int block_test_main(int argc, const char **argv);
    + int merged_test_main(int argc, const char **argv);
    +-int pq_test_main(int argc, const char **argv);
    + int record_test_main(int argc, const char **argv);
    + int readwrite_test_main(int argc, const char **argv);
    + int stack_test_main(int argc, const char **argv);

      ## t/helper/test-reftable.c ##
     @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
    - 	record_test_main(argc, argv);
    + 	/* test from simple to complex. */
      	block_test_main(argc, argv);
      	tree_test_main(argc, argv);
     -	pq_test_main(argc, argv);
    @@ t/unit-tests/t-reftable-pq.c: license that can be found in the LICENSE file or a
      	}
      }

    - static void test_pq(void)
    +-static void test_pq(void)
    ++static void t_pq(void)
      {
     -	struct merged_iter_pqueue pq = { NULL };
     +	struct merged_iter_pqueue pq = { 0 };
    @@ t/unit-tests/t-reftable-pq.c: static void test_pq(void)
      {
     -	RUN_TEST(test_pq);
     -	return 0;
    -+	TEST(test_pq(), "pq works");
    ++	TEST(t_pq(), "pq works");
     +
     +	return test_done();
      }
  4:  7dd3a2b27f = 385:  40745ab18e t-reftable-pq: make merged_iter_pqueue_check() static
  5:  c803e7adfc ! 386:  ee8432ac4a t-reftable-pq: make merged_iter_pqueue_check() callable by reference
    @@ t/unit-tests/t-reftable-pq.c: license that can be found in the LICENSE file or a
      	}
      }

    -@@ t/unit-tests/t-reftable-pq.c: static void test_pq(void)
    +@@ t/unit-tests/t-reftable-pq.c: static void t_pq(void)
      		};

      		merged_iter_pqueue_add(&pq, &e);
  6:  0b03f3567d ! 387:  94a77f5a60 t-reftable-pq: add test for index based comparison
    @@ t/unit-tests/t-reftable-pq.c: static void merged_iter_pqueue_check(const struct
      	}
      }

    --static void test_pq(void)
    -+static void test_pq_record(void)
    +-static void t_pq(void)
    ++static void t_pq_record(void)
      {
      	struct merged_iter_pqueue pq = { 0 };
      	struct reftable_record recs[54];
    -@@ t/unit-tests/t-reftable-pq.c: static void test_pq(void)
    +@@ t/unit-tests/t-reftable-pq.c: static void t_pq(void)
      	merged_iter_pqueue_release(&pq);
      }

    -+static void test_pq_index(void)
    ++static void t_pq_index(void)
     +{
     +	struct merged_iter_pqueue pq = { 0 };
     +	struct reftable_record recs[14];
    @@ t/unit-tests/t-reftable-pq.c: static void test_pq(void)
     +
      int cmd_main(int argc, const char *argv[])
      {
    --	TEST(test_pq(), "pq works");
    -+	TEST(test_pq_record(), "pq works with record-based comparison");
    -+	TEST(test_pq_index(), "pq works with index-based comparison");
    +-	TEST(t_pq(), "pq works");
    ++	TEST(t_pq_record(), "pq works with record-based comparison");
    ++	TEST(t_pq_index(), "pq works with index-based comparison");

      	return test_done();
      }
  7:  0cdfa6221e ! 388:  9a76f87bd1 t-reftable-pq: add tests for merged_iter_pqueue_top()
    @@ t/unit-tests/t-reftable-pq.c: static void merged_iter_pqueue_check(const struct
     +	return !reftable_record_cmp(a->rec, b->rec) && (a->index == b->index);
     +}
     +
    - static void test_pq_record(void)
    + static void t_pq_record(void)
      {
      	struct merged_iter_pqueue pq = { 0 };
    -@@ t/unit-tests/t-reftable-pq.c: static void test_pq_record(void)
    +@@ t/unit-tests/t-reftable-pq.c: static void t_pq_record(void)
      	} while (i != 1);

      	while (!merged_iter_pqueue_is_empty(pq)) {
    @@ t/unit-tests/t-reftable-pq.c: static void test_pq_record(void)
      		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
      		if (last)
      			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
    -@@ t/unit-tests/t-reftable-pq.c: static void test_pq_index(void)
    +@@ t/unit-tests/t-reftable-pq.c: static void t_pq_index(void)
      	}

      	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
    @@ t/unit-tests/t-reftable-pq.c: static void test_pq_index(void)
      		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
      		check_int(e.index, ==, i);
      		if (last)
    -@@ t/unit-tests/t-reftable-pq.c: static void test_pq_index(void)
    +@@ t/unit-tests/t-reftable-pq.c: static void t_pq_index(void)
      	merged_iter_pqueue_release(&pq);
      }

    -+static void test_merged_iter_pqueue_top(void)
    ++static void t_merged_iter_pqueue_top(void)
     +{
     +	struct merged_iter_pqueue pq = { 0 };
     +	struct reftable_record recs[14];
    @@ t/unit-tests/t-reftable-pq.c: static void test_pq_index(void)
     +
      int cmd_main(int argc, const char *argv[])
      {
    - 	TEST(test_pq_record(), "pq works with record-based comparison");
    - 	TEST(test_pq_index(), "pq works with index-based comparison");
    -+	TEST(test_merged_iter_pqueue_top(), "merged_iter_pqueue_top works");
    + 	TEST(t_pq_record(), "pq works with record-based comparison");
    + 	TEST(t_pq_index(), "pq works with index-based comparison");
    ++	TEST(t_merged_iter_pqueue_top(), "merged_iter_pqueue_top works");

      	return test_done();
      }

