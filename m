Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB3372
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906584; cv=none; b=Y5dTaueJQKiesSPICJWCMwhOSukq+uZSBv7DCEmlkzTmkADnOD6z9LpzlI5hbCbdo6jPEJghU925+6wEt+dLRl7GSSn2/R6y9VT1IVWepzeYG8mb0MGZBlWF1AxTa+zFPHmuk9U5CEPuk5A7uo6/vT8Gjw8ggINWmYuEOF0B19E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906584; c=relaxed/simple;
	bh=q4jSDRsiP7hshcBONnP+scEUHZVikZvJk5fYN7Ucgy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYNLcYwhUEUYxcz98dzvLLw6mh6lr2Fp2T2My4psTDMKfi1o3mtyYot+/rrUqKPUMuzg1xcQTLFmjBr7m1Qv0sKC3unIObfZQ4b5EAc1aNQDtQ0kVjpSLpWwzuTxJ1vqhJGafoJq9xYC3fvgy7+qwlr+cmmVCXQFraZ1UVxqsR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HueSJ2gg; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HueSJ2gg"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-701f397e8ffso2175644a34.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906580; x=1720511380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXhDetRbpY40nhDyxbSBb6Ot+7AajBkV0OzIjWRRBxs=;
        b=HueSJ2ggQ6rM6x8XA2kDEQe0R+ZzFbrDhbDAwEnfVv2jVVjCJKAmC3Ur5JIx9LUMqv
         1LeB+LcNF/ej8A6HLx5xS9e4wcyrfe1OAdGgxbOMnDVzTwgUnkvOgLfmVknnAdg5oCFc
         OfSuXdqKhgEYzWSWNL56Kju5TZT/N9N7hfzVYRmyEboN+uH32q/jMrSCDAh9urZXAS7T
         1PSawHlFvQ1gqzt7ybSGzSSCDnb4VZJ9ZlafVpEpLz1EQH5yRhp4KqZBN7Jb0VIYezgu
         PLrROxnGZMNFoK7hMh2xjRiGyfJquHh0eCESRSAaF600rp3+scQqmYxXTeerE5sS23oz
         CXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906580; x=1720511380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXhDetRbpY40nhDyxbSBb6Ot+7AajBkV0OzIjWRRBxs=;
        b=J3NOCsNRb1dKmvA87HN5LqMvIrjiO9JHMRkCmFxVK+B8Azvcsme2oTOY2UmeZZsHJX
         KCyoJ3aEjGrw5PXbctM5QU1Bmv+kBoSvJKm9KHEz7lKrJLRiLOVWijFBP8f+tSxibd+N
         NIupxwfud/+PTvPwWzHN6IgUpD/elKRXUIC5jwtoSF7ovipT+uUCfz3XqWvHNJb4O9BQ
         4s65UylctgmRkqhEanH7lBqSJwSC72AAFYAYTHvydEQk452o2LGn6KsjNYycrGmey3dr
         NADp1uZ6LKPWSxgr41B53WaHyLomA9CHKrVmRgp7/vcYdJJx+NVfbHuOuL2m/hYQLqTc
         RTqQ==
X-Gm-Message-State: AOJu0Yw4fRvdpBhLMQl8BVx0BMLySsJqj9+YgrDJqyYOuetmDgWHuQUA
	bH49LxxFpdaleU/w65l89VmUb+lGvqFp/3UaUsOHpU4/l1eyyNo5xxv9GlxUZx8=
X-Google-Smtp-Source: AGHT+IGi92eeU7KNty8qYycumGkq33aUv+ga7Q+s0ya/LobBggBOIyur0gOz529tqXU7PhVRfYXWAw==
X-Received: by 2002:a9d:7a42:0:b0:700:cdae:507b with SMTP id 46e09a7af769-702076ed959mr10312195a34.30.1719906580113;
        Tue, 02 Jul 2024 00:49:40 -0700 (PDT)
Received: from Ubuntu.. ([106.206.197.80])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm7772626b3a.161.2024.07.02.00.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:49:39 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v4 0/11] t: port reftable/record_test.c to the unit testing framework framework
Date: Tue,  2 Jul 2024 12:52:13 +0530
Message-ID: <20240702074906.5587-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240628063625.4092-1-chandrapratap3519@gmail.com>
References: <20240628063625.4092-1-chandrapratap3519@gmail.com>
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
reftable/record_test.c to the unit testing framework and improve upon
the ported test.

The first patch in the series moves the test to the unit testing framework,
and the rest of the patches improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v4:
- Rename the tests to follow a 't_foo()' pattern instead
  of 'test_foo()'
- Use hard-coded test input in the 10th and 11th patch

CI/PR: https://github.com/gitgitgadget/git/pull/1750

Chandra Pratap (11):
t: move reftable/record_test.c to the unit testing framework
t-reftable-record: add reftable_record_cmp() tests for log records
t-reftable-record: add comparison tests for ref records
t-reftable-record: add comparison tests for index records
t-reftable-record: add comparison tests for obj records
t-reftable-record: add reftable_record_is_deletion() test for ref records
t-reftable-record: add reftable_record_is_deletion() test for log records
t-reftable-record: add reftable_record_is_deletion() test for obj records
t-reftable-record: add reftable_record_is_deletion() test for index records
t-reftable-record: add tests for reftable_ref_record_compare_name()
t-reftable-record: add tests for reftable_log_record_compare_key()

Makefile                         |   2 +-
reftable/record_test.c           | 382 -------------------------
t/helper/test-reftable.c         |   1 -
t/unit-tests/t-reftable-record.c | 551 +++++++++++++++++++++++++++++++++++++++++++++
4 files changed, 552 insertions(+), 384 deletions(-)

Range-diff against v3:
 1:  c88fb5bcfa !  1:  c210a0da8f t: move reftable/record_test.c to the unit testing framework
    @@ Commit message
         reftable/record.{c, h}. Migrate reftable/record_test.c to the
         unit testing framework. Migration involves refactoring the tests
         to use the unit testing framework instead of reftable's test
    -    framework.
    +    framework, and renaming the tests to fit unit-tests' naming scheme.
    +
         While at it, change the type of index variable 'i' to 'size_t'
         from 'int'. This is because 'i' is used in comparison against
         'ARRAY_SIZE(x)' which is of type 'size_t'.
    @@ reftable/record_test.c => t/unit-tests/t-reftable-record.c
      */

     -#include "record.h"
    --
    ++#include "test-lib.h"
    ++#include "reftable/constants.h"
    ++#include "reftable/record.h"
    +
     -#include "system.h"
     -#include "basics.h"
     -#include "constants.h"
     -#include "test_framework.h"
     -#include "reftable-tests.h"
    -+#include "test-lib.h"
    -+#include "reftable/constants.h"
    -+#include "reftable/record.h"
    -
    - static void test_copy(struct reftable_record *rec)
    +-
    +-static void test_copy(struct reftable_record *rec)
    ++static void t_copy(struct reftable_record *rec)
      {
    + 	struct reftable_record copy;
    + 	uint8_t typ;
     @@ t/unit-tests/t-reftable-record.c: static void test_copy(struct reftable_record *rec)
      	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
      	/* do it twice to catch memory leaks */
    @@ t/unit-tests/t-reftable-record.c: static void test_copy(struct reftable_record *

      	reftable_record_release(&copy);
      }
    +
    +-static void test_varint_roundtrip(void)
    ++static void t_varint_roundtrip(void)
    + {
    + 	uint64_t inputs[] = { 0,
    + 			      1,
     @@ t/unit-tests/t-reftable-record.c: static void test_varint_roundtrip(void)
      			      4096,
      			      ((uint64_t)1 << 63),
    @@ t/unit-tests/t-reftable-record.c: static void test_varint_roundtrip(void)
     -	}
      }

    - static void test_reftable_ref_record_roundtrip(void)
    +-static void test_reftable_ref_record_roundtrip(void)
    ++static void t_reftable_ref_record_roundtrip(void)
      {
      	struct strbuf scratch = STRBUF_INIT;
     -	int i = 0;
    @@ t/unit-tests/t-reftable-record.c: static void test_varint_roundtrip(void)
      			.type = BLOCK_TYPE_REF,
      		};
     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip(void)
    + 		}
    + 		in.u.ref.refname = xstrdup("refs/heads/master");

    - 		test_copy(&in);
    +-		test_copy(&in);
    ++		t_copy(&in);

     -		EXPECT(reftable_record_val_type(&in) == i);
     +		check_int(reftable_record_val_type(&in), ==, i);
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip
      						 GIT_SHA1_RAWSZ));
      		reftable_record_release(&in);

    +@@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip(void)
    + 	strbuf_release(&scratch);
    + }
    +
    +-static void test_reftable_log_record_equal(void)
    ++static void t_reftable_log_record_equal(void)
    + {
    + 	struct reftable_log_record in[2] = {
    + 		{
     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_equal(void)
      		}
      	};
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_equal(voi
      	reftable_log_record_release(&in[1]);
      }

    - static void test_reftable_log_record_roundtrip(void)
    +-static void test_reftable_log_record_roundtrip(void)
    ++static void t_reftable_log_record_roundtrip(void)
      {
     -	int i;
      	struct reftable_log_record in[] = {
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_roundtrip
      		struct strbuf key = STRBUF_INIT;
      		uint8_t buffer[1024] = { 0 };
     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_roundtrip(void)
    +
    + 		rec.u.log = in[i];
    +
    +-		test_copy(&rec);
    ++		t_copy(&rec);
    +
      		reftable_record_key(&rec, &key);

      		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_roundtrip
      						 GIT_SHA1_RAWSZ));
      		reftable_log_record_release(&in[i]);
      		strbuf_release(&key);
    +@@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_roundtrip(void)
    + 	strbuf_release(&scratch);
    + }
    +
    +-static void test_key_roundtrip(void)
    ++static void t_key_roundtrip(void)
    + {
    + 	uint8_t buffer[1024] = { 0 };
    + 	struct string_view dest = {
     @@ t/unit-tests/t-reftable-record.c: static void test_key_roundtrip(void)
      	strbuf_addstr(&key, "refs/tags/bla");
      	extra = 6;
    @@ t/unit-tests/t-reftable-record.c: static void test_key_roundtrip(void)

      	strbuf_release(&last_key);
      	strbuf_release(&key);
    + 	strbuf_release(&roundtrip);
    + }
    +
    +-static void test_reftable_obj_record_roundtrip(void)
    ++static void t_reftable_obj_record_roundtrip(void)
    + {
    + 	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
    + 	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip(void)
      		},
      	};
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip
      		struct string_view dest = {
      			.buf = buffer,
     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip(void)
    - 		test_copy(&in);
    + 		int n, m;
    + 		uint8_t extra;
    +
    +-		test_copy(&in);
    ++		t_copy(&in);
      		reftable_record_key(&in, &key);
      		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
     -		EXPECT(n > 0);
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip
      		strbuf_release(&key);
      		reftable_record_release(&out);
      	}
    +@@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip(void)
    + 	strbuf_release(&scratch);
    + }
    +
    +-static void test_reftable_index_record_roundtrip(void)
    ++static void t_reftable_index_record_roundtrip(void)
    + {
    + 	struct reftable_record in = {
    + 		.type = BLOCK_TYPE_INDEX,
     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_index_record_roundtrip(void)
    +
    + 	strbuf_addstr(&in.u.idx.last_key, "refs/heads/master");
      	reftable_record_key(&in, &key);
    - 	test_copy(&in);
    +-	test_copy(&in);
    ++	t_copy(&in);

     -	EXPECT(0 == strbuf_cmp(&key, &in.u.idx.last_key));
     +	check(!strbuf_cmp(&key, &in.u.idx.last_key));
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_index_record_roundtr
     -	RUN_TEST(test_reftable_obj_record_roundtrip);
     -	RUN_TEST(test_reftable_index_record_roundtrip);
     -	return 0;
    -+	TEST(test_reftable_log_record_equal(), "reftable_log_record_equal works");
    -+	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
    -+	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
    -+	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
    -+	TEST(test_key_roundtrip(), "reftable_encode_key and reftable_decode_key work");
    -+	TEST(test_reftable_obj_record_roundtrip(), "record operations work on obj record");
    -+	TEST(test_reftable_index_record_roundtrip(), "record operations work on index record");
    ++	TEST(t_reftable_log_record_equal(), "reftable_log_record_equal works");
    ++	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
    ++	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
    ++	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
    ++	TEST(t_key_roundtrip(), "reftable_encode_key and reftable_decode_key work");
    ++	TEST(t_reftable_obj_record_roundtrip(), "record operations work on obj record");
    ++	TEST(t_reftable_index_record_roundtrip(), "record operations work on index record");
     +
     +	return test_done();
      }
 2:  45ac972538 !  2:  1e8a229cbd t-reftable-record: add reftable_record_cmp() tests for log records
    @@ Commit message
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

      ## t/unit-tests/t-reftable-record.c ##
    -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip(void)
    +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_ref_record_roundtrip(void)
      	strbuf_release(&scratch);
      }

    --static void test_reftable_log_record_equal(void)
    -+static void test_reftable_log_record_comparison(void)
    +-static void t_reftable_log_record_equal(void)
    ++static void t_reftable_log_record_comparison(void)
      {
     -	struct reftable_log_record in[2] = {
     +	struct reftable_record in[3] = {
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip
     +	check(!reftable_record_cmp(&in[0], &in[1]));
      }

    - static void test_reftable_log_record_roundtrip(void)
    -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_index_record_roundtrip(void)
    + static void t_reftable_log_record_roundtrip(void)
    +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_index_record_roundtrip(void)

      int cmd_main(int argc, const char *argv[])
      {
    --	TEST(test_reftable_log_record_equal(), "reftable_log_record_equal works");
    -+	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
    - 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
    - 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
    - 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
    +-	TEST(t_reftable_log_record_equal(), "reftable_log_record_equal works");
    ++	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
    + 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
    + 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
    + 	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
 3:  db76851f4b !  3:  f45611e493 t-reftable-record: add comparison tests for ref records
    @@ t/unit-tests/t-reftable-record.c: static void set_hash(uint8_t *h, int j)
      		h[i] = (j >> i) & 0xff;
      }

    -+static void test_reftable_ref_record_comparison(void)
    ++static void t_reftable_ref_record_comparison(void)
     +{
     +	struct reftable_record in[3] = {
     +		{
    @@ t/unit-tests/t-reftable-record.c: static void set_hash(uint8_t *h, int j)
     +	check(!reftable_record_cmp(&in[0], &in[1]));
     +}
     +
    - static void test_reftable_ref_record_roundtrip(void)
    + static void t_reftable_ref_record_roundtrip(void)
      {
      	struct strbuf scratch = STRBUF_INIT;
    -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_index_record_roundtrip(void)
    +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_index_record_roundtrip(void)

      int cmd_main(int argc, const char *argv[])
      {
    -+	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
    - 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
    - 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
    - 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
    ++	TEST(t_reftable_ref_record_comparison(), "comparison operations work on ref record");
    + 	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
    + 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
    + 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
 4:  78aff923c6 !  4:  28387b65e0 t-reftable-record: add comparison tests for index records
    @@ Commit message
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

      ## t/unit-tests/t-reftable-record.c ##
    -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip(void)
    +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_obj_record_roundtrip(void)
      	strbuf_release(&scratch);
      }

    -+static void test_reftable_index_record_comparison(void)
    ++static void t_reftable_index_record_comparison(void)
     +{
     +	struct reftable_record in[3] = {
     +		{
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip
     +		reftable_record_release(&in[i]);
     +}
     +
    - static void test_reftable_index_record_roundtrip(void)
    + static void t_reftable_index_record_roundtrip(void)
      {
      	struct reftable_record in = {
     @@ t/unit-tests/t-reftable-record.c: int cmd_main(int argc, const char *argv[])
      {
    - 	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
    - 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
    -+	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
    - 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
    - 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
    - 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
    + 	TEST(t_reftable_ref_record_comparison(), "comparison operations work on ref record");
    + 	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
    ++	TEST(t_reftable_index_record_comparison(), "comparison operations work on index record");
    + 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
    + 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
    + 	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
 5:  b0b3c98042 !  5:  6349ce15f4 t-reftable-record: add comparison tests for obj records
    @@ Commit message
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

      ## t/unit-tests/t-reftable-record.c ##
    -@@ t/unit-tests/t-reftable-record.c: static void test_key_roundtrip(void)
    +@@ t/unit-tests/t-reftable-record.c: static void t_key_roundtrip(void)
      	strbuf_release(&roundtrip);
      }

    -+static void test_reftable_obj_record_comparison(void)
    ++static void t_reftable_obj_record_comparison(void)
     +{
     +
     +	uint8_t id_bytes[] = { 0, 1, 2, 3, 4, 5, 6 };
    @@ t/unit-tests/t-reftable-record.c: static void test_key_roundtrip(void)
     +	check(!reftable_record_cmp(&in[0], &in[1]));
     +}
     +
    - static void test_reftable_obj_record_roundtrip(void)
    + static void t_reftable_obj_record_roundtrip(void)
      {
      	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
     @@ t/unit-tests/t-reftable-record.c: int cmd_main(int argc, const char *argv[])
    - 	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
    - 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
    - 	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
    -+	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
    - 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
    - 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
    - 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
    + 	TEST(t_reftable_ref_record_comparison(), "comparison operations work on ref record");
    + 	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
    + 	TEST(t_reftable_index_record_comparison(), "comparison operations work on index record");
    ++	TEST(t_reftable_obj_record_comparison(), "comparison operations work on obj record");
    + 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
    + 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
    + 	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
 6:  5e6b004216 !  6:  9202c783b9 t-reftable-record: add ref tests for reftable_record_is_deletion()
    @@ Commit message
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

      ## t/unit-tests/t-reftable-record.c ##
    -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip(void)
    +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_ref_record_roundtrip(void)
      	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
      		struct reftable_record in = {
      			.type = BLOCK_TYPE_REF,
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip
      		};
      		struct reftable_record out = { .type = BLOCK_TYPE_REF };
      		struct strbuf key = STRBUF_INIT;
    -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip(void)
    - 		test_copy(&in);
    +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_ref_record_roundtrip(void)
    + 		t_copy(&in);

      		check_int(reftable_record_val_type(&in), ==, i);
     +		check_int(reftable_record_is_deletion(&in), ==, i == REFTABLE_REF_DELETION);
 7:  a68be88ccb !  7:  4632a00e15 t-reftable-record: add log tests for reftable_record_is_deletion()
    @@ Commit message
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

      ## t/unit-tests/t-reftable-record.c ##
    -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_roundtrip(void)
    +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_log_record_roundtrip(void)
      	set_hash(in[2].value.update.new_hash, 3);
      	set_hash(in[2].value.update.old_hash, 4);

 8:  02516add15 <  -:  ---------- t-reftable-record: add obj tests for reftable_record_is_deletion()
 -:  ---------- >  8:  3826ed5ef3 t-reftable-record: add obj tests for reftable_record_is_deletion()
 9:  541f9811d3 !  9:  1fba6d500c t-reftable-record: add index tests for reftable_record_is_deletion()
    @@ Commit message
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

      ## t/unit-tests/t-reftable-record.c ##
    -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_index_record_roundtrip(void)
    +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_index_record_roundtrip(void)
      	reftable_record_key(&in, &key);
    - 	test_copy(&in);
    + 	t_copy(&in);

     +	check(!reftable_record_is_deletion(&in));
      	check(!strbuf_cmp(&key, &in.u.idx.last_key));
10:  c2aff283b1 <  -:  ---------- t-reftable-record: add tests for reftable_ref_record_compare_name()
11:  7bdfca3744 <  -:  ---------- t-reftable-record: add tests for reftable_log_record_compare_key()
 -:  ---------- > 10:  3511e36c18 t-reftable-record: add tests for reftable_ref_record_compare_name()
 -:  ---------- > 11:  97e5cbaeaf t-reftable-record: add tests for reftable_log_record_compare_key()

