Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B587B2C6B7
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917760; cv=none; b=YNxTosJFLd8fFLI1dlJz5vh4ktZNA4qbRjpEN1ULPJdosIYw8szOvgrsgruVMmwajX4LQclx4fkbRV7zVxBJQShklkdecntInabQYKPu5rehHhff5Ti1tf5xwokcwyGJ+RioDUxQP85Pj7IPU4I21e4GHTVJkBSZ0+NBYpi7ifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917760; c=relaxed/simple;
	bh=d7w6/eroum2pNULNG9G82EeFrNsBXaGkT26uegy8o4s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWf22QhW6471Urm+4QEz/VPQx5gs9zTAcKQA/GF8xJOKgfuaBG6cSCm2OQL/3czpiX2KEMja/+5yRmX4jBzGkSUByc6HseMtcvwFFWX9y0RBZuMwm0HI538xRCtPgo9RWZhuKmyDOooXWXK5W2xQ+d5ENs2y7bcgvNtjwNpKAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE3JIK42; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE3JIK42"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-254aec5a084so2544180fac.3
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719917758; x=1720522558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b0I8eQ5j/09P5fsrkA23erz03dHBjQ3Qa+BDvckQeGM=;
        b=VE3JIK42FBbxvNalVEkKtXjmnswa9nNLqCJez2YgDTCs5lO9uCzG14mhmohgzGtTUX
         oOH5Sroxgoitdyu7oEAefRuPk6bQuQCkoVFtlPPQosekIJ9EQ0ecdSrdisa1ZU6gUhGS
         MpYipTDI4L1xRTLZ1CslCfJFuMI8kSXWW19i81+QTtOE03Gn+qSF82zCjh0VUoOrz4xd
         J3PjO5PshHk6YpemWTB0cOoHlrZYuiBREYmak8K66MvopEeSS2KzaB46mNUQTRhyGoHy
         djMW/F7q7eGvWi8oVTh4XpZhDNkqgHwmmHc8xOfqcVMrK5r6eB+ti5qNH9PCp72EQ3dE
         RKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719917758; x=1720522558;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0I8eQ5j/09P5fsrkA23erz03dHBjQ3Qa+BDvckQeGM=;
        b=fsJEerszQ2T7yx4y7jflNW9SoLBl3HPSjCgk6a7Zmc/Vajm1X5MBjlUHXDMrcMonVc
         0jqggLNie7sdr5Wi4X1Hc5UERVAdl5VCyuXPHezOLn/K9QK2uAc4l7uD4ubAKt8mRAdC
         IMDh8fKh+TKI7ql7HpQ3v3R024Svh3+hjl/WnZoWUl0LARURJcjNAikww2zCDE9G1vOW
         /u2m4kwKDvWdfcAleho1G6zBs1krsLyDZhC7+68ShBZPU6pbMWuR94M/Cr04ljh32ohC
         0dBAbABGsq11dLlAPPama8OaVytT4/1IzYT082gAnF8HGumPqocJmNWufyUc2C3hWTuj
         NqqA==
X-Forwarded-Encrypted: i=1; AJvYcCUGFIY0ZD73PhD44fLZnhD2TDWqt3ONmlQnkuycO9D2gDpp/3oO3+uLWLdFP9gNTy2cZt6lI6gZquweXqn9qZRA0JFY
X-Gm-Message-State: AOJu0YzFCgQv4Fz2cbOE2v+toAFTMcVStQVnTGeQtqE2P51w2bGXAdiP
	psv+TbmwXZM+Jp0/mRFr9NcmGafBrKRVE5jtDL9aZYwTVxgrwOQJIfKmtCeMiEffhCdnBaPlaYv
	LBIY7blUBrVCZZ4EbGcxVPkSTTHrh2dsM
X-Google-Smtp-Source: AGHT+IHmxAcNtN1oiHlYM6GZaJQkUPsNlanLG4FekW/5rGfwve2aIXyQ1AKn3n0W2tI+tp4q2otYb1ki8nCOOft4qeY=
X-Received: by 2002:a05:6870:1491:b0:25d:7935:43ba with SMTP id
 586e51a60fabf-25db332b0fcmr7387267fac.5.1719917757482; Tue, 02 Jul 2024
 03:55:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jul 2024 06:55:56 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240702074906.5587-1-chandrapratap3519@gmail.com>
References: <20240628063625.4092-1-chandrapratap3519@gmail.com> <20240702074906.5587-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jul 2024 06:55:56 -0400
Message-ID: <CAOLa=ZT_x1Kf7EopU+RbBFzX3EPU5NWx6f8L9Uw=sM0MbCXDAQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 0/11] t: port reftable/record_test.c to the unit
 testing framework framework
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000fa61e0061c418e1f"

--000000000000fa61e0061c418e1f
Content-Type: text/plain; charset="UTF-8"

Hello,

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
> testing framework written entirely in C was introduced to the Git project
> aimed at simplifying testing and reducing test run times.
> Currently, tests for the reftable refs-backend are performed by a custom
> testing framework defined by reftable/test_framework.{c, h}. Port
> reftable/record_test.c to the unit testing framework and improve upon
> the ported test.
>
> The first patch in the series moves the test to the unit testing framework,
> and the rest of the patches improve upon the ported test.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
> ---
> Changes in v4:
> - Rename the tests to follow a 't_foo()' pattern instead
>   of 'test_foo()'
> - Use hard-coded test input in the 10th and 11th patch
>

Nice, I see my comments from the previous versions are addressed. It
looks good to me now!

> CI/PR: https://github.com/gitgitgadget/git/pull/1750
>
> Chandra Pratap (11):
> t: move reftable/record_test.c to the unit testing framework
> t-reftable-record: add reftable_record_cmp() tests for log records
> t-reftable-record: add comparison tests for ref records
> t-reftable-record: add comparison tests for index records
> t-reftable-record: add comparison tests for obj records
> t-reftable-record: add reftable_record_is_deletion() test for ref records
> t-reftable-record: add reftable_record_is_deletion() test for log records
> t-reftable-record: add reftable_record_is_deletion() test for obj records
> t-reftable-record: add reftable_record_is_deletion() test for index records
> t-reftable-record: add tests for reftable_ref_record_compare_name()
> t-reftable-record: add tests for reftable_log_record_compare_key()
>
> Makefile                         |   2 +-
> reftable/record_test.c           | 382 -------------------------
> t/helper/test-reftable.c         |   1 -
> t/unit-tests/t-reftable-record.c | 551 +++++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 552 insertions(+), 384 deletions(-)
>
> Range-diff against v3:
>  1:  c88fb5bcfa !  1:  c210a0da8f t: move reftable/record_test.c to the unit testing framework
>     @@ Commit message
>          reftable/record.{c, h}. Migrate reftable/record_test.c to the
>          unit testing framework. Migration involves refactoring the tests
>          to use the unit testing framework instead of reftable's test
>     -    framework.
>     +    framework, and renaming the tests to fit unit-tests' naming scheme.
>     +
>          While at it, change the type of index variable 'i' to 'size_t'
>          from 'int'. This is because 'i' is used in comparison against
>          'ARRAY_SIZE(x)' which is of type 'size_t'.
>     @@ reftable/record_test.c => t/unit-tests/t-reftable-record.c
>       */
>
>      -#include "record.h"
>     --
>     ++#include "test-lib.h"
>     ++#include "reftable/constants.h"
>     ++#include "reftable/record.h"
>     +
>      -#include "system.h"
>      -#include "basics.h"
>      -#include "constants.h"
>      -#include "test_framework.h"
>      -#include "reftable-tests.h"
>     -+#include "test-lib.h"
>     -+#include "reftable/constants.h"
>     -+#include "reftable/record.h"
>     -
>     - static void test_copy(struct reftable_record *rec)
>     +-
>     +-static void test_copy(struct reftable_record *rec)
>     ++static void t_copy(struct reftable_record *rec)
>       {
>     + 	struct reftable_record copy;
>     + 	uint8_t typ;
>      @@ t/unit-tests/t-reftable-record.c: static void test_copy(struct reftable_record *rec)
>       	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
>       	/* do it twice to catch memory leaks */
>     @@ t/unit-tests/t-reftable-record.c: static void test_copy(struct reftable_record *
>
>       	reftable_record_release(&copy);
>       }
>     +
>     +-static void test_varint_roundtrip(void)
>     ++static void t_varint_roundtrip(void)
>     + {
>     + 	uint64_t inputs[] = { 0,
>     + 			      1,
>      @@ t/unit-tests/t-reftable-record.c: static void test_varint_roundtrip(void)
>       			      4096,
>       			      ((uint64_t)1 << 63),
>     @@ t/unit-tests/t-reftable-record.c: static void test_varint_roundtrip(void)
>      -	}
>       }
>
>     - static void test_reftable_ref_record_roundtrip(void)
>     +-static void test_reftable_ref_record_roundtrip(void)
>     ++static void t_reftable_ref_record_roundtrip(void)
>       {
>       	struct strbuf scratch = STRBUF_INIT;
>      -	int i = 0;
>     @@ t/unit-tests/t-reftable-record.c: static void test_varint_roundtrip(void)
>       			.type = BLOCK_TYPE_REF,
>       		};
>      @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip(void)
>     + 		}
>     + 		in.u.ref.refname = xstrdup("refs/heads/master");
>
>     - 		test_copy(&in);
>     +-		test_copy(&in);
>     ++		t_copy(&in);
>
>      -		EXPECT(reftable_record_val_type(&in) == i);
>      +		check_int(reftable_record_val_type(&in), ==, i);
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip
>       						 GIT_SHA1_RAWSZ));
>       		reftable_record_release(&in);
>
>     +@@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip(void)
>     + 	strbuf_release(&scratch);
>     + }
>     +
>     +-static void test_reftable_log_record_equal(void)
>     ++static void t_reftable_log_record_equal(void)
>     + {
>     + 	struct reftable_log_record in[2] = {
>     + 		{
>      @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_equal(void)
>       		}
>       	};
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_equal(voi
>       	reftable_log_record_release(&in[1]);
>       }
>
>     - static void test_reftable_log_record_roundtrip(void)
>     +-static void test_reftable_log_record_roundtrip(void)
>     ++static void t_reftable_log_record_roundtrip(void)
>       {
>      -	int i;
>       	struct reftable_log_record in[] = {
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_roundtrip
>       		struct strbuf key = STRBUF_INIT;
>       		uint8_t buffer[1024] = { 0 };
>      @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_roundtrip(void)
>     +
>     + 		rec.u.log = in[i];
>     +
>     +-		test_copy(&rec);
>     ++		t_copy(&rec);
>     +
>       		reftable_record_key(&rec, &key);
>
>       		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_roundtrip
>       						 GIT_SHA1_RAWSZ));
>       		reftable_log_record_release(&in[i]);
>       		strbuf_release(&key);
>     +@@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_roundtrip(void)
>     + 	strbuf_release(&scratch);
>     + }
>     +
>     +-static void test_key_roundtrip(void)
>     ++static void t_key_roundtrip(void)
>     + {
>     + 	uint8_t buffer[1024] = { 0 };
>     + 	struct string_view dest = {
>      @@ t/unit-tests/t-reftable-record.c: static void test_key_roundtrip(void)
>       	strbuf_addstr(&key, "refs/tags/bla");
>       	extra = 6;
>     @@ t/unit-tests/t-reftable-record.c: static void test_key_roundtrip(void)
>
>       	strbuf_release(&last_key);
>       	strbuf_release(&key);
>     + 	strbuf_release(&roundtrip);
>     + }
>     +
>     +-static void test_reftable_obj_record_roundtrip(void)
>     ++static void t_reftable_obj_record_roundtrip(void)
>     + {
>     + 	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
>     + 	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
>      @@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip(void)
>       		},
>       	};
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip
>       		struct string_view dest = {
>       			.buf = buffer,
>      @@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip(void)
>     - 		test_copy(&in);
>     + 		int n, m;
>     + 		uint8_t extra;
>     +
>     +-		test_copy(&in);
>     ++		t_copy(&in);
>       		reftable_record_key(&in, &key);
>       		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
>      -		EXPECT(n > 0);
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip
>       		strbuf_release(&key);
>       		reftable_record_release(&out);
>       	}
>     +@@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip(void)
>     + 	strbuf_release(&scratch);
>     + }
>     +
>     +-static void test_reftable_index_record_roundtrip(void)
>     ++static void t_reftable_index_record_roundtrip(void)
>     + {
>     + 	struct reftable_record in = {
>     + 		.type = BLOCK_TYPE_INDEX,
>      @@ t/unit-tests/t-reftable-record.c: static void test_reftable_index_record_roundtrip(void)
>     +
>     + 	strbuf_addstr(&in.u.idx.last_key, "refs/heads/master");
>       	reftable_record_key(&in, &key);
>     - 	test_copy(&in);
>     +-	test_copy(&in);
>     ++	t_copy(&in);
>
>      -	EXPECT(0 == strbuf_cmp(&key, &in.u.idx.last_key));
>      +	check(!strbuf_cmp(&key, &in.u.idx.last_key));
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_index_record_roundtr
>      -	RUN_TEST(test_reftable_obj_record_roundtrip);
>      -	RUN_TEST(test_reftable_index_record_roundtrip);
>      -	return 0;
>     -+	TEST(test_reftable_log_record_equal(), "reftable_log_record_equal works");
>     -+	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
>     -+	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
>     -+	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
>     -+	TEST(test_key_roundtrip(), "reftable_encode_key and reftable_decode_key work");
>     -+	TEST(test_reftable_obj_record_roundtrip(), "record operations work on obj record");
>     -+	TEST(test_reftable_index_record_roundtrip(), "record operations work on index record");
>     ++	TEST(t_reftable_log_record_equal(), "reftable_log_record_equal works");
>     ++	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
>     ++	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
>     ++	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
>     ++	TEST(t_key_roundtrip(), "reftable_encode_key and reftable_decode_key work");
>     ++	TEST(t_reftable_obj_record_roundtrip(), "record operations work on obj record");
>     ++	TEST(t_reftable_index_record_roundtrip(), "record operations work on index record");
>      +
>      +	return test_done();
>       }
>  2:  45ac972538 !  2:  1e8a229cbd t-reftable-record: add reftable_record_cmp() tests for log records
>     @@ Commit message
>          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
>       ## t/unit-tests/t-reftable-record.c ##
>     -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip(void)
>     +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_ref_record_roundtrip(void)
>       	strbuf_release(&scratch);
>       }
>
>     --static void test_reftable_log_record_equal(void)
>     -+static void test_reftable_log_record_comparison(void)
>     +-static void t_reftable_log_record_equal(void)
>     ++static void t_reftable_log_record_comparison(void)
>       {
>      -	struct reftable_log_record in[2] = {
>      +	struct reftable_record in[3] = {
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip
>      +	check(!reftable_record_cmp(&in[0], &in[1]));
>       }
>
>     - static void test_reftable_log_record_roundtrip(void)
>     -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_index_record_roundtrip(void)
>     + static void t_reftable_log_record_roundtrip(void)
>     +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_index_record_roundtrip(void)
>
>       int cmd_main(int argc, const char *argv[])
>       {
>     --	TEST(test_reftable_log_record_equal(), "reftable_log_record_equal works");
>     -+	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
>     - 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
>     - 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
>     - 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
>     +-	TEST(t_reftable_log_record_equal(), "reftable_log_record_equal works");
>     ++	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
>     + 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
>     + 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
>     + 	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
>  3:  db76851f4b !  3:  f45611e493 t-reftable-record: add comparison tests for ref records
>     @@ t/unit-tests/t-reftable-record.c: static void set_hash(uint8_t *h, int j)
>       		h[i] = (j >> i) & 0xff;
>       }
>
>     -+static void test_reftable_ref_record_comparison(void)
>     ++static void t_reftable_ref_record_comparison(void)
>      +{
>      +	struct reftable_record in[3] = {
>      +		{
>     @@ t/unit-tests/t-reftable-record.c: static void set_hash(uint8_t *h, int j)
>      +	check(!reftable_record_cmp(&in[0], &in[1]));
>      +}
>      +
>     - static void test_reftable_ref_record_roundtrip(void)
>     + static void t_reftable_ref_record_roundtrip(void)
>       {
>       	struct strbuf scratch = STRBUF_INIT;
>     -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_index_record_roundtrip(void)
>     +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_index_record_roundtrip(void)
>
>       int cmd_main(int argc, const char *argv[])
>       {
>     -+	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
>     - 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
>     - 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
>     - 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
>     ++	TEST(t_reftable_ref_record_comparison(), "comparison operations work on ref record");
>     + 	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
>     + 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
>     + 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
>  4:  78aff923c6 !  4:  28387b65e0 t-reftable-record: add comparison tests for index records
>     @@ Commit message
>          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
>       ## t/unit-tests/t-reftable-record.c ##
>     -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip(void)
>     +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_obj_record_roundtrip(void)
>       	strbuf_release(&scratch);
>       }
>
>     -+static void test_reftable_index_record_comparison(void)
>     ++static void t_reftable_index_record_comparison(void)
>      +{
>      +	struct reftable_record in[3] = {
>      +		{
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_obj_record_roundtrip
>      +		reftable_record_release(&in[i]);
>      +}
>      +
>     - static void test_reftable_index_record_roundtrip(void)
>     + static void t_reftable_index_record_roundtrip(void)
>       {
>       	struct reftable_record in = {
>      @@ t/unit-tests/t-reftable-record.c: int cmd_main(int argc, const char *argv[])
>       {
>     - 	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
>     - 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
>     -+	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
>     - 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
>     - 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
>     - 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
>     + 	TEST(t_reftable_ref_record_comparison(), "comparison operations work on ref record");
>     + 	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
>     ++	TEST(t_reftable_index_record_comparison(), "comparison operations work on index record");
>     + 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
>     + 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
>     + 	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
>  5:  b0b3c98042 !  5:  6349ce15f4 t-reftable-record: add comparison tests for obj records
>     @@ Commit message
>          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
>       ## t/unit-tests/t-reftable-record.c ##
>     -@@ t/unit-tests/t-reftable-record.c: static void test_key_roundtrip(void)
>     +@@ t/unit-tests/t-reftable-record.c: static void t_key_roundtrip(void)
>       	strbuf_release(&roundtrip);
>       }
>
>     -+static void test_reftable_obj_record_comparison(void)
>     ++static void t_reftable_obj_record_comparison(void)
>      +{
>      +
>      +	uint8_t id_bytes[] = { 0, 1, 2, 3, 4, 5, 6 };
>     @@ t/unit-tests/t-reftable-record.c: static void test_key_roundtrip(void)
>      +	check(!reftable_record_cmp(&in[0], &in[1]));
>      +}
>      +
>     - static void test_reftable_obj_record_roundtrip(void)
>     + static void t_reftable_obj_record_roundtrip(void)
>       {
>       	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
>      @@ t/unit-tests/t-reftable-record.c: int cmd_main(int argc, const char *argv[])
>     - 	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
>     - 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
>     - 	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
>     -+	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
>     - 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
>     - 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
>     - 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
>     + 	TEST(t_reftable_ref_record_comparison(), "comparison operations work on ref record");
>     + 	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
>     + 	TEST(t_reftable_index_record_comparison(), "comparison operations work on index record");
>     ++	TEST(t_reftable_obj_record_comparison(), "comparison operations work on obj record");
>     + 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
>     + 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
>     + 	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
>  6:  5e6b004216 !  6:  9202c783b9 t-reftable-record: add ref tests for reftable_record_is_deletion()
>     @@ Commit message
>          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
>       ## t/unit-tests/t-reftable-record.c ##
>     -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip(void)
>     +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_ref_record_roundtrip(void)
>       	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
>       		struct reftable_record in = {
>       			.type = BLOCK_TYPE_REF,
>     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip
>       		};
>       		struct reftable_record out = { .type = BLOCK_TYPE_REF };
>       		struct strbuf key = STRBUF_INIT;
>     -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip(void)
>     - 		test_copy(&in);
>     +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_ref_record_roundtrip(void)
>     + 		t_copy(&in);
>
>       		check_int(reftable_record_val_type(&in), ==, i);
>      +		check_int(reftable_record_is_deletion(&in), ==, i == REFTABLE_REF_DELETION);
>  7:  a68be88ccb !  7:  4632a00e15 t-reftable-record: add log tests for reftable_record_is_deletion()
>     @@ Commit message
>          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
>       ## t/unit-tests/t-reftable-record.c ##
>     -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_roundtrip(void)
>     +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_log_record_roundtrip(void)
>       	set_hash(in[2].value.update.new_hash, 3);
>       	set_hash(in[2].value.update.old_hash, 4);
>
>  8:  02516add15 <  -:  ---------- t-reftable-record: add obj tests for reftable_record_is_deletion()
>  -:  ---------- >  8:  3826ed5ef3 t-reftable-record: add obj tests for reftable_record_is_deletion()
>  9:  541f9811d3 !  9:  1fba6d500c t-reftable-record: add index tests for reftable_record_is_deletion()
>     @@ Commit message
>          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
>       ## t/unit-tests/t-reftable-record.c ##
>     -@@ t/unit-tests/t-reftable-record.c: static void test_reftable_index_record_roundtrip(void)
>     +@@ t/unit-tests/t-reftable-record.c: static void t_reftable_index_record_roundtrip(void)
>       	reftable_record_key(&in, &key);
>     - 	test_copy(&in);
>     + 	t_copy(&in);
>
>      +	check(!reftable_record_is_deletion(&in));
>       	check(!strbuf_cmp(&key, &in.u.idx.last_key));
> 10:  c2aff283b1 <  -:  ---------- t-reftable-record: add tests for reftable_ref_record_compare_name()
> 11:  7bdfca3744 <  -:  ---------- t-reftable-record: add tests for reftable_log_record_compare_key()
>  -:  ---------- > 10:  3511e36c18 t-reftable-record: add tests for reftable_ref_record_compare_name()
>  -:  ---------- > 11:  97e5cbaeaf t-reftable-record: add tests for reftable_log_record_compare_key()

--000000000000fa61e0061c418e1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 99dc793022971acd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hRDNMc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWhYQy8wYmdWNjJVVEVZNUJpTURDelY1VzM3ZVA5RAozVGxFMEx5VHdO
cUdXREttaVJmNlhzUFg4eVVuRHQ3UjNBTmwrUlM2Q0NFZTdrMS9jbkVCTDgxSkVaZjBIbURwCjNH
NnBlM25JT0lZRmdLNDFWR0hDbTQ5dmhtU0lhOE1QZnhqbzEzK0lmUkljZHJQZzhleW5LOVFSYmVw
UjIybFkKYmg1dTUrZ2dsSEdFM2FIT21CdzJISWdtYW5Eb0lFcS81NHpDRmdaOFFVVmY0anlOR3U3
alJUWGQwR1J6cEVPZwpoZGpyV1Y4U0ZySTNrWmpnYUl2V2R3aitEV0dNdkFlT2E5QW13bE9rUXVj
TDFCY2VxSHgyTGlGL1ROYkFiS3F0Ck1GQnoxK212eUx0N1lLQk1kSklkdmU4MWpOV3dvaFdSRE54
Sk91SHpUeXJ0ZEVCWnBaVlBOTG9OVE1JV29XTjMKYmFBbzBaRC9LelFoV1I1OGM5OWl6RWg2ODZE
UDRWZElOTFY2YU5McTRVMVd4U29vbVpBeG1IYzVZS0RCRjNyWAozSTlrRG5yRW50ZEZvd2hvVUQz
dHR6QVU1Y1h2NjFMOEl1V3c4U1RwUDdVbHkwU2NsbWUyY2s3VWkvTDlHYXJGCmxmZVV1VUt4dmZF
bUJ3VFVzdlR2R2FqcmQweXlXeEE4ZEZCanpUST0KPWpVbksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fa61e0061c418e1f--
