Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035371BDABF
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830895; cv=none; b=OaMyjx0MgX4onayF7QTeRvUhwieA9aZwZxMQRJgDGnCLLje6K1kVUjrxytuiuXtEmnTxk0y2X+RHaOxjezgmw5teIriifWHru6cuwgj8lUZaN1ahdgtvqumjtP040e9aTTxtA44Yqtz1rqxcYIVaMequMSyHhXJQSD3wcivz+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830895; c=relaxed/simple;
	bh=Hsa0UZmc7He5zXqlZZaONWzl00WJIZo+4l9hU9tWWPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tokRukB1tfITbZtUgZpbnlayHo7bvJTahl3fGKNaJ1HfyLBa+Spd8bypIw7agxz0D5C15BoVS1THhy4YDbXsxN+DOjlC9/LMJAbPGvIJMsHvoaCvAQG6ypFPQu84/5bg9WplvmxS9VsNqOgBEkgIQvAwzm9kTDJlA8KhqXL87/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq7Sffpz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq7Sffpz"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-710bdddb95cso1516505b3a.3
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723830893; x=1724435693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=colnNsluHtcggJOauFW3Zw/prTB5Fim5WRP+jCXiim4=;
        b=Yq7SffpzXRaQ8WuaJqF/YmCPPQVBefff6QzSSlc+sAqEuddYevWUp7ymxRXJI4Ww1e
         BbsNCTvatl5lo4NP1Qx6uHbwQfCjNzOVZd3v7zIc3lq+Du+nTMZeFEbe03ryJpEDxTiY
         /m7R3lnGRf6vAgTN4G8g3aihXVxOrckm13lH9eMCtAUqNaYUNFLij3oz33mz6cbOr4Ic
         5xAqqTGzEMdl1lPSJZ3aywnm2V+B8PGJb/P4NsMIdkDTfvURL2skXetk3/ElJshDj2Gd
         RpLqaD0rOhGKcMrK0dE9KaMG+vGhvFd/fAxiYMkooMqKM4SnaCUhBt6XTjzMnRxGBslp
         8Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830893; x=1724435693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=colnNsluHtcggJOauFW3Zw/prTB5Fim5WRP+jCXiim4=;
        b=RVJIeLIQ0DD2YQVToP34a0/qyLBpqIQMseNPcLPCpMDfJXFXRR4z5UOFiJkwF9rjQ7
         u9A6zDLZrSGX9laxfRhYhyJnn4ubsemOJbYtjhfgrNMMb4Pt6XSfMFQKony82vdJo+Ro
         NiMGHxOSv5DFDYI26O9eA+UHlPhFnafBipgkLntivZPaW2Uzwamkt94nyDmK6JLtf4Nu
         HNbltrYydfJ9skGEIHMIxV4lyMOFQd5nIhtnKgm7ofW+/o32i4bZbN9NCORcQjbSM14z
         cItnCFBhHdcpWaxhsexU4jnkTI4DUOXBOa3BFAjT15bZYvQ3IuBQDrni3cYgfFCVj9sp
         amXw==
X-Gm-Message-State: AOJu0YwINFipIw3Oew94VIUqJn9l48yBLPGXgWaW6GT/Alpe2RaOqRbI
	7tH6A5Un6G4xZ51eHFADYXTz+5OuQA4p789VwClNNOvBWVEo7b5L2v4Nxg==
X-Google-Smtp-Source: AGHT+IE1jdR4+p3nO9bE3jXLVyn2tA38i9XkwzaZIHn2gCqZvHSSMPHD8fy7OtNugbll9VSvEFpsrw==
X-Received: by 2002:a05:6a21:9214:b0:1c4:21c0:ea0f with SMTP id adf61e73a8af0-1c905028143mr4281950637.33.1723830892440;
        Fri, 16 Aug 2024 10:54:52 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.209])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af1e907sm2985600b3a.173.2024.08.16.10.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:54:51 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v2 00/11] t: port reftable/block_test.c to the unit testing framework
Date: Fri, 16 Aug 2024 22:55:23 +0530
Message-ID: <20240816175414.5169-1-chandrapratap3519@gmail.com>
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

The reftable library comes with self tests, which are exercised
as part of the usual end-to-end tests and are designed to
observe the end-user visible effects of Git commands. What it
exercises, however, is a better match for the unit-testing
framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
2023-12-09), which is designed to observe how low level
implementation details, at the level of sequences of individual
function calls, behave.

Hence, port reftable/block_test.c to the unit testing framework and
improve upon the ported test. The first patch in the series moves
the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v2:
- Split the first patch into two, one that moves the test to the
  unit testing framework and another that adds improvements.
- Fix a comma-error in the commit message of  patch 4
  (previously patch 3).
- Use 'ret' as the name for a variable that stores return codes
  rather than 'n' in all the tests.
- Add a check for 'i == N' in the block iterator loop in all
  the tests.
- Modify the obj test (patch 10) to no longer use magic numbers.
- Rebase the branch on top of the latest 'master' branch.

CI/PR: https://github.com/gitgitgadget/git/pull/1749

Chandra Pratap(11):
t: move reftable/block_test.c to the unit testing framework
t: harmonize t-reftable-block.c with coding guidelines
t-reftable-block: release used block reader
t-reftable-block: use reftable_record_equal() instead of check_str()
t-reftable-block: use reftable_record_key() instead of strbuf_addstr()
t-reftable-block: use block_iter_reset() instead of block_iter_close()
t-reftable-block: use xstrfmt() instead of xstrdup()
t-reftable-block: remove unnecessary variable 'j'
t-reftable-block: add tests for log blocks
t-reftable-block: add tests for obj blocks
t-reftable-block: add tests for index blocks

Makefile                        |   2 +-
reftable/block_test.c           | 123 ------------------------------
reftable/reftable-tests.h       |   1 -
t/helper/test-reftable.c        |   1 -
t/unit-tests/t-reftable-block.c | 368 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
5 files changed, 369 insertions(+), 126 deletions(-)

Range-diff against v2:
<rebase commits>
 1:  0712c3df22 !  1:  c0d8c4149f t: move reftable/block_test.c to the unit testing framework
    @@ Commit message
         framework and renaming the tests to follow the unit-tests'
         naming conventions.

    -    While at it, ensure structs are 0-initialized with '= { 0 }'
    -    instead of '= { NULL }' and array indices have type 'size_t'
    -    instead of 'int'.
    -
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
    @@ t/unit-tests/t-reftable-block.c: license that can be found in the LICENSE file o
      {
      	const int header_off = 21; /* random */
      	char *names[30];
    --	const int N = ARRAY_SIZE(names);
    --	const int block_size = 1024;
    --	struct reftable_block block = { NULL };
    -+	const size_t N = ARRAY_SIZE(names);
    -+	const size_t block_size = 1024;
    -+	struct reftable_block block = { 0 };
    - 	struct block_writer bw = {
    - 		.last_key = STRBUF_INIT,
    - 	};
    - 	struct reftable_record rec = {
    - 		.type = BLOCK_TYPE_REF,
    - 	};
    --	int i = 0;
    -+	size_t i = 0;
    - 	int n;
    - 	struct block_reader br = { 0 };
    - 	struct block_iter it = BLOCK_ITER_INIT;
    --	int j = 0;
    -+	size_t j = 0;
    - 	struct strbuf want = STRBUF_INIT;
    -
    - 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
     @@ t/unit-tests/t-reftable-block.c: static void test_block_read_write(void)
      	rec.u.ref.refname = (char *) "";
      	rec.u.ref.value_type = REFTABLE_REF_DELETION;
    @@ t/unit-tests/t-reftable-block.c: static void test_block_read_write(void)

      	for (i = 0; i < N; i++) {
      		char name[100];
    --		snprintf(name, sizeof(name), "branch%02d", i);
    -+		snprintf(name, sizeof(name), "branch%02"PRIuMAX , (uintmax_t)i);
    -
    - 		rec.u.ref.refname = name;
    - 		rec.u.ref.value_type = REFTABLE_REF_VAL1;
     @@ t/unit-tests/t-reftable-block.c: static void test_block_read_write(void)
      		n = block_writer_add(&bw, &rec);
      		rec.u.ref.refname = NULL;
    @@ t/unit-tests/t-reftable-block.c: static void test_block_read_write(void)
      	while (1) {
      		int r = block_iter_next(&it, &rec);
     -		EXPECT(r >= 0);
    --		if (r > 0) {
     +		check_int(r, >=, 0);
    -+		if (r > 0)
    + 		if (r > 0) {
      			break;
    --		}
    + 		}
     -		EXPECT_STREQ(names[j], rec.u.ref.refname);
     +		check_str(names[j], rec.u.ref.refname);
      		j++;
    @@ t/unit-tests/t-reftable-block.c: static void test_block_read_write(void)
      		block_iter_close(&it);
      	}
     @@ t/unit-tests/t-reftable-block.c: static void test_block_read_write(void)
    - 	reftable_record_release(&rec);
    - 	reftable_block_done(&br.block);
    - 	strbuf_release(&want);
    --	for (i = 0; i < N; i++) {
    -+	for (i = 0; i < N; i++)
    - 		reftable_free(names[i]);
    --	}
    + 	}
      }

     -int block_test_main(int argc, const char *argv[])
 -:  ---------- >  2:  017658ddb3 t: harmonize t-reftable-block.c with coding guidelines
 2:  3282dbeba1 =  3:  2042e2fde0 t-reftable-block: release used block reader
 3:  5a3fea003a !  4:  853efb0c0b t-reftable-block: use reftable_record_equal() instead of check_str()
    @@ Commit message
         comparing only the keys of input and output reftable records. This is
         not ideal because there can exist inequal reftable records with the
         same key. Use the dedicated function for record comparison,
    -    reftable_record_equal() instead of key-based comparison.
    +    reftable_record_equal(), instead of key-based comparison.

         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
    @@ t/unit-tests/t-reftable-block.c: license that can be found in the LICENSE file o
      	struct block_writer bw = {
     @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
      		char name[100];
    - 		snprintf(name, sizeof(name), "branch%02"PRIuMAX , (uintmax_t)i);
    + 		snprintf(name, sizeof(name), "branch%02"PRIuMAX, (uintmax_t)i);

     -		rec.u.ref.refname = name;
     +		rec.u.ref.refname = xstrdup(name);
    @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)

     -		names[i] = xstrdup(name);
     +		recs[i] = rec;
    - 		n = block_writer_add(&bw, &rec);
    + 		ret = block_writer_add(&bw, &rec);
      		rec.u.ref.refname = NULL;
      		rec.u.ref.value_type = REFTABLE_REF_DELETION;
     @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
    - 		check_int(r, >=, 0);
    - 		if (r > 0)
    + 			check_int(i, ==, N);
      			break;
    + 		}
     -		check_str(names[j], rec.u.ref.refname);
     +		check(reftable_record_equal(&recs[j], &rec, GIT_SHA1_RAWSZ));
      		j++;
    @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
     -		strbuf_addstr(&want, names[i]);
     +		strbuf_addstr(&want, recs[i].u.ref.refname);

    - 		n = block_iter_seek_key(&it, &br, &want);
    - 		check_int(n, ==, 0);
    + 		ret = block_iter_seek_key(&it, &br, &want);
    + 		check_int(ret, ==, 0);
     @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
    - 		n = block_iter_next(&it, &rec);
    - 		check_int(n, ==, 0);
    + 		ret = block_iter_next(&it, &rec);
    + 		check_int(ret, ==, 0);

     -		check_str(names[i], rec.u.ref.refname);
     +		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));

      		want.len--;
    - 		n = block_iter_seek_key(&it, &br, &want);
    + 		ret = block_iter_seek_key(&it, &br, &want);
     @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)

    - 		n = block_iter_next(&it, &rec);
    - 		check_int(n, ==, 0);
    + 		ret = block_iter_next(&it, &rec);
    + 		check_int(ret, ==, 0);
     -		check_str(names[10 * (i / 10)], rec.u.ref.refname);
     +		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));

 4:  7ca77be75c !  5:  0de1e0cbe2 t-reftable-block: use reftable_record_key() instead of strbuf_addstr()
    @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
     -		strbuf_addstr(&want, recs[i].u.ref.refname);
     +		reftable_record_key(&recs[i], &want);

    - 		n = block_iter_seek_key(&it, &br, &want);
    - 		check_int(n, ==, 0);
    + 		ret = block_iter_seek_key(&it, &br, &want);
    + 		check_int(ret, ==, 0);
 5:  0016d8828a !  6:  74187586c9 t-reftable-block: use block_iter_reset() instead of block_iter_close()
    @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
     +		block_iter_reset(&it);
      		reftable_record_key(&recs[i], &want);

    - 		n = block_iter_seek_key(&it, &br, &want);
    + 		ret = block_iter_seek_key(&it, &br, &want);
     @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
    - 		n = block_iter_next(&it, &rec);
    - 		check_int(n, ==, 0);
    + 		ret = block_iter_next(&it, &rec);
    + 		check_int(ret, ==, 0);
      		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
     -
     -		block_iter_close(&it);
 6:  49fe881f0e <  -:  ---------- t-reftable-block: use xstrfmt() instead of xstrdup()
 -:  ---------- >  7:  5e35cae987 t-reftable-block: use xstrfmt() instead of xstrdup()
 7:  5dbc756799 !  8:  bacd52a236 t-reftable-block: remove unnecessary variable 'j'
    @@ Commit message

      ## t/unit-tests/t-reftable-block.c ##
     @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
    - 	int n;
    + 	int ret;
      	struct block_reader br = { 0 };
      	struct block_iter it = BLOCK_ITER_INIT;
     -	size_t j = 0;
    @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)

     -	while (1) {
     +	for (i = 0; ; i++) {
    - 		int r = block_iter_next(&it, &rec);
    - 		check_int(r, >=, 0);
    - 		if (r > 0)
    + 		ret = block_iter_next(&it, &rec);
    + 		check_int(ret, >=, 0);
    + 		if (ret > 0) {
    + 			check_int(i, ==, N);
      			break;
    + 		}
     -		check(reftable_record_equal(&recs[j], &rec, GIT_SHA1_RAWSZ));
     -		j++;
     +		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
 8:  0916b8b2ca !  9:  6e8632d3e6 t-reftable-block: add tests for log blocks
    @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
     +		.type = BLOCK_TYPE_LOG,
     +	};
     +	size_t i = 0;
    -+	int n;
    ++	int ret;
     +	struct block_reader br = { 0 };
     +	struct block_iter it = BLOCK_ITER_INIT;
     +	struct strbuf want = STRBUF_INIT;
    @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
     +		rec.u.log.value_type = REFTABLE_LOG_UPDATE;
     +
     +		recs[i] = rec;
    -+		n = block_writer_add(&bw, &rec);
    ++		ret = block_writer_add(&bw, &rec);
     +		rec.u.log.refname = NULL;
     +		rec.u.log.value_type = REFTABLE_LOG_DELETION;
    -+		check_int(n, ==, 0);
    ++		check_int(ret, ==, 0);
     +	}
     +
    -+	n = block_writer_finish(&bw);
    -+	check_int(n, >, 0);
    ++	ret = block_writer_finish(&bw);
    ++	check_int(ret, >, 0);
     +
     +	block_writer_release(&bw);
     +
    @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
     +	block_iter_seek_start(&it, &br);
     +
     +	for (i = 0; ; i++) {
    -+		int r = block_iter_next(&it, &rec);
    -+		check_int(r, >=, 0);
    -+		if (r > 0)
    ++		ret = block_iter_next(&it, &rec);
    ++		check_int(ret, >=, 0);
    ++		if (ret > 0) {
    ++			check_int(i, ==, N);
     +			break;
    ++		}
     +		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
     +	}
     +
    @@ t/unit-tests/t-reftable-block.c: static void t_block_read_write(void)
     +		strbuf_reset(&want);
     +		strbuf_addstr(&want, recs[i].u.log.refname);
     +
    -+		n = block_iter_seek_key(&it, &br, &want);
    -+		check_int(n, ==, 0);
    ++		ret = block_iter_seek_key(&it, &br, &want);
    ++		check_int(ret, ==, 0);
     +
    -+		n = block_iter_next(&it, &rec);
    -+		check_int(n, ==, 0);
    ++		ret = block_iter_next(&it, &rec);
    ++		check_int(ret, ==, 0);
     +
     +		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
     +
     +		want.len--;
    -+		n = block_iter_seek_key(&it, &br, &want);
    -+		check_int(n, ==, 0);
    ++		ret = block_iter_seek_key(&it, &br, &want);
    ++		check_int(ret, ==, 0);
     +
    -+		n = block_iter_next(&it, &rec);
    -+		check_int(n, ==, 0);
    ++		ret = block_iter_next(&it, &rec);
    ++		check_int(ret, ==, 0);
     +		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
     +	}
     +
 9:  4794f2d610 ! 10:  d147d5e9a9 t-reftable-block: add tests for obj blocks
    @@ t/unit-tests/t-reftable-block.c: static void t_log_block_read_write(void)
     +		.type = BLOCK_TYPE_OBJ,
     +	};
     +	size_t i = 0;
    -+	int n;
    ++	int ret;
     +	struct block_reader br = { 0 };
     +	struct block_iter it = BLOCK_ITER_INIT;
     +	struct strbuf want = STRBUF_INIT;
    @@ t/unit-tests/t-reftable-block.c: static void t_log_block_read_write(void)
     +			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
     +
     +	for (i = 0; i < N; i++) {
    -+		uint8_t *bytes = reftable_malloc(sizeof(uint8_t[5]));
    -+		memcpy(bytes, (uint8_t[]){i, i+1, i+2, i+3, i+5}, sizeof(uint8_t[5]));
    ++		uint8_t bytes[] = { i, i + 1, i + 2, i + 3, i + 5 }, *allocated;
    ++		allocated = reftable_malloc(ARRAY_SIZE(bytes));
    ++		DUP_ARRAY(allocated, bytes, ARRAY_SIZE(bytes));
     +
    -+		rec.u.obj.hash_prefix = bytes;
    ++		rec.u.obj.hash_prefix = allocated;
     +		rec.u.obj.hash_prefix_len = 5;
     +
     +		recs[i] = rec;
    -+		n = block_writer_add(&bw, &rec);
    ++		ret = block_writer_add(&bw, &rec);
     +		rec.u.obj.hash_prefix = NULL;
     +		rec.u.obj.hash_prefix_len = 0;
    -+		check_int(n, ==, 0);
    ++		check_int(ret, ==, 0);
     +	}
     +
    -+	n = block_writer_finish(&bw);
    -+	check_int(n, >, 0);
    ++	ret = block_writer_finish(&bw);
    ++	check_int(ret, >, 0);
     +
     +	block_writer_release(&bw);
     +
    @@ t/unit-tests/t-reftable-block.c: static void t_log_block_read_write(void)
     +	block_iter_seek_start(&it, &br);
     +
     +	for (i = 0; ; i++) {
    -+		int r = block_iter_next(&it, &rec);
    -+		check_int(r, >=, 0);
    -+		if (r > 0)
    ++		ret = block_iter_next(&it, &rec);
    ++		check_int(ret, >=, 0);
    ++		if (ret > 0) {
    ++			check_int(i, ==, N);
     +			break;
    ++		}
     +		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
     +	}
     +
    @@ t/unit-tests/t-reftable-block.c: static void t_log_block_read_write(void)
     +		block_iter_reset(&it);
     +		reftable_record_key(&recs[i], &want);
     +
    -+		n = block_iter_seek_key(&it, &br, &want);
    -+		check_int(n, ==, 0);
    ++		ret = block_iter_seek_key(&it, &br, &want);
    ++		check_int(ret, ==, 0);
     +
    -+		n = block_iter_next(&it, &rec);
    -+		check_int(n, ==, 0);
    ++		ret = block_iter_next(&it, &rec);
    ++		check_int(ret, ==, 0);
     +
     +		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
     +	}
10:  40fcc98173 ! 11:  2b43b1ac9a t-reftable-block: add tests for index blocks
    @@ t/unit-tests/t-reftable-block.c: static void t_obj_block_read_write(void)
     +		.u.idx.last_key = STRBUF_INIT,
     +	};
     +	size_t i = 0;
    -+	int n;
    ++	int ret;
     +	struct block_reader br = { 0 };
     +	struct block_iter it = BLOCK_ITER_INIT;
     +	struct strbuf want = STRBUF_INIT;
    @@ t/unit-tests/t-reftable-block.c: static void t_obj_block_read_write(void)
     +		strbuf_addf(&recs[i].u.idx.last_key, "branch%02"PRIuMAX, (uintmax_t)i);
     +		recs[i].u.idx.offset = i;
     +
    -+		n = block_writer_add(&bw, &recs[i]);
    -+		check_int(n, ==, 0);
    ++		ret = block_writer_add(&bw, &recs[i]);
    ++		check_int(ret, ==, 0);
     +	}
     +
    -+	n = block_writer_finish(&bw);
    -+	check_int(n, >, 0);
    ++	ret = block_writer_finish(&bw);
    ++	check_int(ret, >, 0);
     +
     +	block_writer_release(&bw);
     +
    @@ t/unit-tests/t-reftable-block.c: static void t_obj_block_read_write(void)
     +	block_iter_seek_start(&it, &br);
     +
     +	for (i = 0; ; i++) {
    -+		int r = block_iter_next(&it, &rec);
    -+		check_int(r, >=, 0);
    -+		if (r > 0)
    ++		ret = block_iter_next(&it, &rec);
    ++		check_int(ret, >=, 0);
    ++		if (ret > 0) {
    ++			check_int(i, ==, N);
     +			break;
    ++		}
     +		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
     +	}
     +
    @@ t/unit-tests/t-reftable-block.c: static void t_obj_block_read_write(void)
     +		block_iter_reset(&it);
     +		reftable_record_key(&recs[i], &want);
     +
    -+		n = block_iter_seek_key(&it, &br, &want);
    -+		check_int(n, ==, 0);
    ++		ret = block_iter_seek_key(&it, &br, &want);
    ++		check_int(ret, ==, 0);
     +
    -+		n = block_iter_next(&it, &rec);
    -+		check_int(n, ==, 0);
    ++		ret = block_iter_next(&it, &rec);
    ++		check_int(ret, ==, 0);
     +
     +		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
     +
     +		want.len--;
    -+		n = block_iter_seek_key(&it, &br, &want);
    -+		check_int(n, ==, 0);
    ++		ret = block_iter_seek_key(&it, &br, &want);
    ++		check_int(ret, ==, 0);
     +
    -+		n = block_iter_next(&it, &rec);
    -+		check_int(n, ==, 0);
    ++		ret = block_iter_next(&it, &rec);
    ++		check_int(ret, ==, 0);
     +		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
     +	}
     +
