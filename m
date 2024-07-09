Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A54136671
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503561; cv=none; b=hu2JoWSU9Bi96y+elezvM5Sy7qVcVZkv87xP6cPBvRGVhpvROE+GKPw7bjMucz3TYSNrNf0B0Wb91oIuLTtYfSMhwnY5v+L+948U/K4MJcyOXjiAEAc5up0HGwNXpft9a2fl/aP7GDDSsI61DnNyNq59B2Ri16guzDnFYsHVGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503561; c=relaxed/simple;
	bh=cGIHtOwoscmnOKFe2LqJMBO+gli5cuaDLe+tPiUr5u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRfODt3ll+oWo3yfgtAR7n29I2SZQt33uwJjsFanlU5zl+kRwxLlU+UZ7aZvOC4jIwifRnu68yWJc27Nt6VRM3Sq0jTh9F6VxRHvimwdGfLeDZWVMp6vfeWX2jLFYPwY1YhmDkut9StkNmWZKRfgYeWQNBLFNfX59bvLmttqh4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+ALSENR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+ALSENR"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b0d0fefe3so2280102b3a.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 22:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720503559; x=1721108359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFWQCVwO+ogmeF/SIN7zC6Cfva4zSQg9aFCsxP3GfXs=;
        b=Z+ALSENRrF1eG6KB8weuK/r8SkV85Iu+kKgC5Fod5QbBxaHEXPUMiJaAOH4xtiD2W5
         qnHu59sWIL+0YVNQKJEEFuX3mWN9OrJX5rv7/+ijKSbcnblWQ+tXt9GA3bQExl+4w4pt
         IvsQOSjx8gCxFoCw6V9tCvgmW0/xHReDCUCxZbzDb9dXS7AHM5cy4MjhRDr1QpKmss7d
         cnHktFGTNsTYNKeVdp3DkXRkM5uPx99pwa7IeC86NWlcra/yWyQqoRwK6wqAFKgjzsKs
         KhIxZYihr4b6m/7yrjCTuBn88jqv/JUmWcfp+mTwQRtscEwKQ/VOIVkKwF0E1COoHX3o
         FeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720503559; x=1721108359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFWQCVwO+ogmeF/SIN7zC6Cfva4zSQg9aFCsxP3GfXs=;
        b=Z9ic8k4VVL6kaqz3i1jtypfvcBAuNC5YnPCv7kOXbo+lUC6NiXHfUrPfjamgX1HyC4
         tgxOGJ4W08XEynkaPxBcKoOVBUoW31Yqt+0Y7qnm2WakLxVnt3gQ0uj5+RfJfaMistNG
         zNixHbcjOZSk44fv+EJgP18ZpXAARiPQj1kqa9DtV83QF17WFGSDDTDoRnvqMm3whCaZ
         GB26ZLkSfQiqGifUiekArxEgmQ3wjeWyLS8TdX965m+qDGii6NQ5Ho+w46TXw9McxHlv
         Ol2EfElzDW1u421JWX+FpmAKhqWvoFxUHX2RAMGnO7eD4aRhk1k/F8eUd+iPOaSCrqAx
         m1Mg==
X-Gm-Message-State: AOJu0Yzyg+4D+U34eWPqzmHgNwtygzwG2tKHZDl1+ZEnTu9aCnkQiZK8
	GOY8RCfmcjW6bT+Oq5InKCbrezKoIUzmbEXuIS1SEt4D7ZDTZ+xIzJ1u2g==
X-Google-Smtp-Source: AGHT+IG+65hOsqDWOscYWgGpzLLuyKaEA/AODXqY7QL6kMn8zNeGYSP2SEqzVY9OeqnRp17ymou0pQ==
X-Received: by 2002:a05:6a00:3c92:b0:70b:2a:15da with SMTP id d2e1a72fcca58-70b434f6485mr1978556b3a.4.1720503558525;
        Mon, 08 Jul 2024 22:39:18 -0700 (PDT)
Received: from Ubuntu.. ([117.96.144.60])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-77d61922ee6sm718448a12.46.2024.07.08.22.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 22:39:17 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	karthik.188@gmail.com
Subject: [GSoC][PATCH v2 0/7] t: port reftable/merged_test.c to the unit testing framework
Date: Tue,  9 Jul 2024 10:58:39 +0530
Message-ID: <20240709053847.4453-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240703171131.3929-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
testing framework written entirely in C was introduced to the Git project
aimed at simplifying testing and reducing test run times.
Currently, tests for the reftable refs-backend are performed by a custom
testing framework defined by reftable/test_framework.{c, h}. Port
reftable/merged_test.c to the unit testing framework and improve upon
the ported test.

The first patch in the series moves the test to the unit testing framework,
and the rest of the patches improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v2:
- Rename test functions & description to be more explanatory
- Remove a redundant comment in patch 1
- Add the 3rd patch which makes improvements to a test
- Add the 4th patch which makes apt function parameters 'const'
- Remove a redundant check in patch 6

CI/PR: https://github.com/gitgitgadget/git/pull/1755

Chandra Pratap (7):
[PATCH 1/7] t: move reftable/merged_test.c to the unit testing framework
[PATCH 2/7] t: harmonize t-reftable-merged.c with coding guidelines
[PATCH 3/7] t-reftable-merged: improve the test for t_merged_single_record()
[PATCH 4/7] t-reftable-merged: improve the const-correctness of helper functions
[PATCH 5/7] t-reftable-merged: add tests for reftable_merged_table_max_update_index
[PATCH 6/7] t-reftable-merged: use reftable_ref_record_equal to compare ref records
[PATCH 7/7] t-reftable-merged: add test for REFTABLE_FORMAT_ERROR

Makefile                                                   |   2 +-
t/helper/test-reftable.c                                   |   1 -
reftable/merged_test.c => t/unit-tests/t-reftable-merged.c | 202 +++++++++++++++----------------
3 files changed, 103 insertions(+), 102 deletions(-)

Range-diff against v2:
1:  f4d5da52f5 ! 1:  0d71deffad t: move reftable/merged_test.c to the unit testing framework
    @@ t/unit-tests/t-reftable-merged.c: static void readers_destroy(struct reftable_re
      }
      
     -static void test_merged_between(void)
    -+static void t_merged_between(void)
    ++static void t_merged_single_record(void)
      {
      	struct reftable_ref_record r1[] = { {
      		.refname = (char *) "b",
    @@ t/unit-tests/t-reftable-merged.c: static void test_merged_between(void)
      }
      
     -static void test_merged(void)
    -+static void t_merged(void)
    ++static void t_merged_refs(void)
      {
      	struct reftable_ref_record r1[] = {
      		{
    @@ t/unit-tests/t-reftable-merged.c: static void test_default_write_opts(void)
      
      	reftable_reader_free(rd);
      	reftable_merged_table_free(merged);
    -@@ t/unit-tests/t-reftable-merged.c: static void test_default_write_opts(void)
    + 	strbuf_release(&buf);
    + }
      
    - /* XXX test refs_for(oid) */
    +-/* XXX test refs_for(oid) */
      
     -int merged_test_main(int argc, const char *argv[])
     +int cmd_main(int argc, const char *argv[])
    @@ t/unit-tests/t-reftable-merged.c: static void test_default_write_opts(void)
     -	RUN_TEST(test_merged);
     -	RUN_TEST(test_default_write_opts);
     -	return 0;
    -+	TEST(t_merged_logs(), "merged table with log records");
    -+	TEST(t_merged_between(), "seek ref in a merged table");
    -+	TEST(t_merged(), "merged table with multiple updates to same ref");
     +	TEST(t_default_write_opts(), "merged table with default write opts");
    ++	TEST(t_merged_logs(), "merged table with multiple log updates for same ref");
    ++	TEST(t_merged_refs(), "merged table with multiple updates to same ref");
    ++	TEST(t_merged_single_record(), "ref ocurring in only one record can be fetched");
     +
     +	return test_done();
      }
2:  fb0f0946b4 ! 2:  a449e2edcf t: harmonize t-reftable-merged.c with coding guidelines
    @@ t/unit-tests/t-reftable-merged.c: merged_table_from_records(struct reftable_ref_
      		reftable_reader_free(readers[i]);
      	reftable_free(readers);
      }
    -@@ t/unit-tests/t-reftable-merged.c: static void t_merged_between(void)
    +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_single_record(void)
      	struct reftable_reader **readers = NULL;
      	struct reftable_merged_table *mt =
      		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
    @@ t/unit-tests/t-reftable-merged.c: static void t_merged_between(void)
      	int err;
      
      	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
    -@@ t/unit-tests/t-reftable-merged.c: static void t_merged_between(void)
    +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_single_record(void)
      	reftable_iterator_destroy(&it);
      	readers_destroy(readers, 2);
      	reftable_merged_table_free(mt);
    @@ t/unit-tests/t-reftable-merged.c: static void t_merged_between(void)
      	reftable_free(bs);
      }
      
    -@@ t/unit-tests/t-reftable-merged.c: static void t_merged(void)
    +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_refs(void)
      	struct reftable_reader **readers = NULL;
      	struct reftable_merged_table *mt =
      		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
    @@ t/unit-tests/t-reftable-merged.c: static void t_merged(void)
      
      	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
      	err = reftable_iterator_seek_ref(&it, "a");
    -@@ t/unit-tests/t-reftable-merged.c: static void t_merged(void)
    +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_refs(void)
      	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
      
      	while (len < 100) { /* cap loops/recursion. */
    @@ t/unit-tests/t-reftable-merged.c: static void t_merged(void)
      		int err = reftable_iterator_next_ref(&it, &ref);
      		if (err > 0)
      			break;
    -@@ t/unit-tests/t-reftable-merged.c: static void t_merged(void)
    +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_refs(void)
      	reftable_iterator_destroy(&it);
      
      	check_int(ARRAY_SIZE(want), ==, len);
-:  ---------- > 3:  bba993bb26 t-reftable-merged: improve the test t_merged_single_record()
-:  ---------- > 4:  4d508eaa02 t-reftable-merged: improve the const-correctness of helper functions
3:  85731b6358 ! 5:  1c9ba26c22 t-reftable-merged: add tests for reftable_merged_table_max_update_index
    @@ Commit message
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
     
      ## t/unit-tests/t-reftable-merged.c ##
    -@@ t/unit-tests/t-reftable-merged.c: static void t_merged(void)
    +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_refs(void)
      	check(!err);
      	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
      	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
4:  5d6fd842ac < -:  ---------- t-reftable-merged: use reftable_ref_record_equal to compare ref records
-:  ---------- > 6:  309c7f412e t-reftable-merged: use reftable_ref_record_equal to compare ref records
5:  d8cbb73533 = 7:  2cd7f5b0b4 t-reftable-merged: add test for REFTABLE_FORMAT_ERROR

