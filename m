Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56B62AD13
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132439; cv=none; b=c0FA/sZ6HBdp8/CTnvYBUGoi4hPiE4vRPPlHSMtNnAxFkHojtcl9zMhVp4E2jDNS8S93/AbaQhJzX08sHk8rbx/eilduqmkMqUUqt3XwPhdRhLAFxgAWUwG+t4RntlV2aweSw8mSLBBIe03ep9PrH3MvjlYOJsYenSRez91MX2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132439; c=relaxed/simple;
	bh=hoXZsYmltRG53VVkxUHMiBDpvvsjpdSnnAvh0vNKj9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVuACpSznTEofwcyp8GdQcItMrjd0pXM56H97ZQWBRoz/Rostz2sQEIdeAUiBNFnd80MLze7wn2f1wzW7L4LfEoO67y8BsswCQuAXvpzMm4jW2hXrOterF9rLd0YMbxg1wJgyaBwtgjmSwp+CTPjemfTLefzPKlg+XH8lct7tJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltY+c/Nu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltY+c/Nu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4508287895dso14378275e9.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749132434; x=1749737234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiwHaYW6fUB6QyavTe1BJnArC7JCJs3xVpoTuDmC4u8=;
        b=ltY+c/Nuh52M2WS1V90yY7+u+o8l7ploYmwHkMQ863eij3waAH0HhH6jkmgGw5wcDq
         UwUifwpzG3sjPpAMaKUnHhpwBbVQb4ARyfyqM0izSDUyGOT4XQzKj6xGjdtQUvcLFwVL
         vlmZn42C/Hxkgo08rbzgnJx11inVNv42KPZ+m4z1yOcC77BQFKymgxyG2DTIEdiGlxev
         45bg2hMoqSL0GIXO+Iltd62UTAUwJDCnZCZvDLXRbK6loEesCfF8o3OXOtZBj+Vva6te
         ViGgqZ9ATT0ag4g7uEMdixQ3x6R1ZJ3AS4WJPbyrFrUAMqit7wZMb8LC/Es7Y6E+NPZp
         Efbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749132434; x=1749737234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiwHaYW6fUB6QyavTe1BJnArC7JCJs3xVpoTuDmC4u8=;
        b=Ypl/zhC+pQEvYt3T+jy53os8Oyo1BH5Xkgyoh0hv6Y57AeJJqttjywnL9G3o3SUReg
         CaHq9xKYpT5s06LkzJIqUhutvfil36pR3mp33cfctnwehDtmkRg4/+BkXfg5/vqp/Ext
         flm3WBCIp1H8lciL4BJxb5cawCoc5FRu6elBoZtJPYCmRHj5JLIxTvuAz45IUQrEJlfe
         PJxeI6RCptHLRgGmDcuq+KXOVwcuTYSb2ju82dZW8wHq6UK9VRYZUIxfkLibwpq1NW49
         g1CyDey0dyWMo+mBx6Afixqr4nlxWJgDF+Z0gZ6sNgq7ULPWcq3it4bBYpGbls714wnl
         PeyQ==
X-Gm-Message-State: AOJu0YyRupp+VhjGvt5ENMhQngcwTKuXJyuUgJy1qsl5ItR86V14uObh
	rl7PAhnodBAYHk58O2nZ1tRagGwe1nr0wcjUNNAfi31zM+EFBxUdTXjbH+2u62/qn88=
X-Gm-Gg: ASbGncvtUiMayvCNeL2QTCIt1X/EvJGFSwGOUrmQtsMh6BbwlTAb41kdUK79Go2xwOR
	c3lVeYbzZ8/Vyu/Mb30auUqsZTwsr2D43yyRoqcIflRKZH/cKQt3V3go6Zt56w0Uf+J/BdPcc7W
	rY0tt920E+dOUdT382JV5zhkzJYmrB7lNQ4yCZxreCXxPntjT4GhKJdMR7k0c16XZETHQzTzFJI
	VlZANIrGjZnvyTv0a1uzqDn6/PIAt8yRBdTls8r3IG3PXRGPrOg9WIe4rxUEfO6QsWEJuxo7XH9
	XElM9+CByXvIp+JH7DxH8NCAQTecYSyWKuToK4dtTBndIw==
X-Google-Smtp-Source: AGHT+IHnU1Z9g05365VuE3Df8U4jciu6njvGymVg/MckXZwnfWMRiKPFdAcrxNRXzUGXJHrFMn9Mig==
X-Received: by 2002:a05:600c:8710:b0:451:df07:d8e0 with SMTP id 5b1f17b1804b1-451f8892a8dmr34451355e9.11.1749132431298;
        Thu, 05 Jun 2025 07:07:11 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fe39fc52sm8827305e9.27.2025.06.05.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:07:10 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v4 00/10] t/unit-tests: convert unit-tests to use clar
Date: Thu,  5 Jun 2025 15:06:34 +0100
Message-ID: <20250605140644.239199-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series marks the final batch of our existing unit test files
transitioned to the Clar testing framework. It covers all the
reftable-related test files, and is part of our ongoing effort to
standardize our testing framework to enhance its maintainability.

Changes in v4:
 - some code refactoring and cleanup based on review.

Thanks
Seyi

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>

Seyi Kuforiji (10):
  t/unit-tests: implement clar specific reftable test helper functions
  t/unit-tests: convert reftable basics test to use clar test framework
  t/unit-tests: convert reftable block test to use clar
  t/unit-tests: convert reftable merged test to use clar
  t/unit-tests: convert reftable pq test to use clar
  t/unit-tests: convert reftable table test to use clar
  t/unit-tests: convert reftable readwrite test to use clar
  t/unit-tests: convert reftable record test to use clar
  t/unit-tests: convert reftable stack test to use clar
  t/unit-tests: finalize migration of reftable-related tests

 Makefile                                      |  20 +-
 t/Makefile                                    |   1 -
 t/meson.build                                 |  42 +-
 t/unit-tests/lib-reftable.c                   |  35 +-
 t/unit-tests/lib-reftable.h                   |  15 +-
 t/unit-tests/t-reftable-basics.c              | 219 -----
 t/unit-tests/u-reftable-basics.c              | 227 +++++
 ...{t-reftable-block.c => u-reftable-block.c} | 164 ++--
 ...-reftable-merged.c => u-reftable-merged.c} | 160 ++--
 .../{t-reftable-pq.c => u-reftable-pq.c}      |  59 +-
 ...ble-readwrite.c => u-reftable-readwrite.c} | 403 ++++-----
 ...-reftable-record.c => u-reftable-record.c} | 250 +++---
 ...{t-reftable-stack.c => u-reftable-stack.c} | 780 ++++++++----------
 ...{t-reftable-table.c => u-reftable-table.c} |  73 +-
 14 files changed, 1117 insertions(+), 1331 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-basics.c
 create mode 100644 t/unit-tests/u-reftable-basics.c
 rename t/unit-tests/{t-reftable-block.c => u-reftable-block.c} (74%)
 rename t/unit-tests/{t-reftable-merged.c => u-reftable-merged.c} (77%)
 rename t/unit-tests/{t-reftable-pq.c => u-reftable-pq.c} (64%)
 rename t/unit-tests/{t-reftable-readwrite.c => u-reftable-readwrite.c} (68%)
 rename t/unit-tests/{t-reftable-record.c => u-reftable-record.c} (62%)
 rename t/unit-tests/{t-reftable-stack.c => u-reftable-stack.c} (59%)
 rename t/unit-tests/{t-reftable-table.c => u-reftable-table.c} (75%)

Range-diff against v3:
 1:  53a64f5551 =  1:  53a64f5551 t/unit-tests: implement clar specific reftable test helper functions
 2:  fec29d94d8 =  2:  fec29d94d8 t/unit-tests: convert reftable basics test to use clar test framework
 3:  57d7541caa !  3:  e717e4529d t/unit-tests: convert reftable block test to use clar
    @@ t/unit-tests/u-reftable-block.c: license that can be found in the LICENSE file o
      #include "strbuf.h"
      
     -static void t_ref_block_read_write(void)
    -+void test_reftable_block__index_read_write(void)
    ++void test_reftable_block__read_write(void)
      {
      	const int header_off = 21; /* random */
      	struct reftable_record recs[30];
    @@ t/unit-tests/u-reftable-block.c: static void t_ref_block_read_write(void)
     +				(uint8_t *) block_data.buf, block_size,
      				header_off, hash_size(REFTABLE_HASH_SHA1));
     -	check(!ret);
    -+	cl_assert(ret == 0);
    ++	cl_assert(!ret);
      
      	rec.u.ref.refname = (char *) "";
      	rec.u.ref.value_type = REFTABLE_REF_DELETION;
    @@ t/unit-tests/u-reftable-block.c: static void t_log_block_read_write(void)
      	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_LOG, (uint8_t *) block_data.buf, block_size,
      				header_off, hash_size(REFTABLE_HASH_SHA1));
     -	check(!ret);
    -+	cl_assert(ret == 0);
    ++	cl_assert(!ret);
      
      	for (i = 0; i < N; i++) {
      		rec.u.log.refname = xstrfmt("branch%02"PRIuMAX , (uintmax_t)i);
    @@ t/unit-tests/u-reftable-block.c: static void t_obj_block_read_write(void)
      	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_OBJ, (uint8_t *) block_data.buf, block_size,
      				header_off, hash_size(REFTABLE_HASH_SHA1));
     -	check(!ret);
    -+	cl_assert(ret == 0);
    ++	cl_assert(!ret);
      
      	for (i = 0; i < N; i++) {
      		uint8_t bytes[] = { i, i + 1, i + 2, i + 3, i + 5 }, *allocated;
    @@ t/unit-tests/u-reftable-block.c: static void t_index_block_read_write(void)
      	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_INDEX, (uint8_t *) block_data.buf, block_size,
      				header_off, hash_size(REFTABLE_HASH_SHA1));
     -	check(!ret);
    -+	cl_assert(ret == 0);
    ++	cl_assert(!ret);
      
      	for (i = 0; i < N; i++) {
      		char buf[128];
 4:  db11c0eb30 !  4:  dc176ad6d9 t/unit-tests: convert reftable merged test to use clar
    @@ t/unit-tests/u-reftable-merged.c: static void t_merged_single_record(void)
     +	cl_assert(!err);
      	err = reftable_iterator_seek_ref(&it, "a");
     -	check(!err);
    -+	cl_assert(err == 0);
    ++	cl_assert(!err);
      
      	err = reftable_iterator_next_ref(&it, &ref);
     -	check(!err);
     -	check(reftable_ref_record_equal(&r2[0], &ref, REFTABLE_HASH_SIZE_SHA1));
    -+	cl_assert(err == 0);
    ++	cl_assert(!err);
     +	cl_assert(reftable_ref_record_equal(&r2[0], &ref,
     +					    REFTABLE_HASH_SIZE_SHA1) != 0);
      	reftable_ref_record_release(&ref);
    @@ t/unit-tests/u-reftable-merged.c: static void t_merged_seek_multiple_times(void)
      	for (size_t i = 0; i < 5; i++) {
      		int err = reftable_iterator_seek_ref(&it, "c");
     -		check(!err);
    -+		cl_assert(err == 0);
    ++		cl_assert(!err);
      
     -		err = reftable_iterator_next_ref(&it, &rec);
     -		check(!err);
    @@ t/unit-tests/u-reftable-merged.c: static void t_default_write_opts(void)
      
     -	err = reftable_writer_add_ref(w, &rec);
     -	check(!err);
    -+	cl_assert(reftable_writer_add_ref(w, &rec) == 0);
    ++	cl_assert_equal_i(reftable_writer_add_ref(w, &rec), 0);
      
     -	err = reftable_writer_close(w);
     -	check(!err);
    -+	cl_assert(reftable_writer_close(w) == 0);
    ++	cl_assert_equal_i(reftable_writer_close(w), 0);
      	reftable_writer_free(w);
      
      	block_source_from_buf(&source, &buf);
 5:  60cf81862a !  5:  1694375fab t/unit-tests: convert reftable pq test to use clar
    @@ t/unit-tests/u-reftable-pq.c: static void merged_iter_pqueue_check(const struct
      {
      	int cmp;
     -	check(!reftable_record_cmp(a->rec, b->rec, &cmp));
    -+	cl_assert(reftable_record_cmp(a->rec, b->rec, &cmp) == 0);
    ++	cl_assert_equal_i(reftable_record_cmp(a->rec, b->rec, &cmp), 0);
      	return !cmp && (a->index == b->index);
      }
      
    @@ t/unit-tests/u-reftable-pq.c: static void t_pq_record(void)
      		struct pq_entry e;
      
     -		check(!merged_iter_pqueue_remove(&pq, &e));
    -+		cl_assert(merged_iter_pqueue_remove(&pq, &e) == 0);
    ++		cl_assert_equal_i(merged_iter_pqueue_remove(&pq, &e), 0);
      		merged_iter_pqueue_check(&pq);
      
     -		check(pq_entry_equal(&top, &e));
    @@ t/unit-tests/u-reftable-pq.c: static void t_pq_index(void)
      		struct pq_entry e;
      
     -		check(!merged_iter_pqueue_remove(&pq, &e));
    -+		cl_assert(merged_iter_pqueue_remove(&pq, &e) == 0);
    ++		cl_assert_equal_i(merged_iter_pqueue_remove(&pq, &e), 0);
      		merged_iter_pqueue_check(&pq);
      
     -		check(pq_entry_equal(&top, &e));
    @@ t/unit-tests/u-reftable-pq.c: static void t_merged_iter_pqueue_top(void)
      		struct pq_entry e;
      
     -		check(!merged_iter_pqueue_remove(&pq, &e));
    -+		cl_assert(merged_iter_pqueue_remove(&pq, &e) == 0);
    ++		cl_assert_equal_i(merged_iter_pqueue_remove(&pq, &e), 0);
      
      		merged_iter_pqueue_check(&pq);
     -		check(pq_entry_equal(&top, &e));
 6:  0eec9f7601 !  6:  9842215a17 t/unit-tests: convert reftable table test to use clar
    @@ t/meson.build: if perl.found() and time.found()
     
      ## t/unit-tests/t-reftable-table.c => t/unit-tests/u-reftable-table.c ##
     @@
    - #include "test-lib.h"
    +-#include "test-lib.h"
     -#include "lib-reftable.h"
    ++#include "unit-test.h"
     +#include "lib-reftable-clar.h"
      #include "reftable/blocksource.h"
      #include "reftable/constants.h"
 7:  36bdd9b003 !  7:  acc72b57b2 t/unit-tests: convert reftable readwrite test to use clar
    @@ t/unit-tests/u-reftable-readwrite.c: license that can be found in the LICENSE fi
      	int n;
      	uint8_t in[] = "hello";
     -	check(!reftable_buf_add(&buf, in, sizeof(in)));
    -+	cl_assert(reftable_buf_add(&buf, in, sizeof(in)) == 0);
    ++	cl_assert_equal_i(reftable_buf_add(&buf, in, sizeof(in)), 0);
      	block_source_from_buf(&source, &buf);
     -	check_int(block_source_size(&source), ==, 6);
     +	cl_assert_equal_i(block_source_size(&source), 6);
    @@ t/unit-tests/u-reftable-readwrite.c: static void write_table(char ***names, stru
      		refs[i].update_index = update_index;
      		refs[i].value_type = REFTABLE_REF_VAL1;
     -		t_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
    -+		cl_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
    ++		cl_reftable_set_hash(refs[i].value.val1, i,
    ++				     REFTABLE_HASH_SHA1);
      	}
      
      	for (i = 0; i < N; i++) {
    @@ t/unit-tests/u-reftable-readwrite.c: static void write_table(char ***names, stru
      		logs[i].update_index = update_index;
      		logs[i].value_type = REFTABLE_LOG_UPDATE;
     -		t_reftable_set_hash(logs[i].value.update.new_hash, i,
    +-				    REFTABLE_HASH_SHA1);
     +		cl_reftable_set_hash(logs[i].value.update.new_hash, i,
    - 				    REFTABLE_HASH_SHA1);
    ++				     REFTABLE_HASH_SHA1);
      		logs[i].value.update.message = (char *) "message";
      	}
      
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_buffer_size(void)
      					   .message = (char *) "commit: 9\n",
      				   } } };
     -	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
    -+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
    ++	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
    ++							      &opts);
      
      	/* This tests buffer extension for log compression. Must use a random
      	   hash, to ensure that the compressed part is larger than the original.
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_buffer_size(void)
     -	check(!err);
     -	err = reftable_writer_close(w);
     -	check(!err);
    -+	cl_assert(reftable_writer_add_log(w, &log) == 0);
    -+	cl_assert(reftable_writer_close(w) == 0);
    ++	cl_assert_equal_i(reftable_writer_add_log(w, &log), 0);
    ++	cl_assert_equal_i(reftable_writer_close(w), 0);
      	reftable_writer_free(w);
      	reftable_buf_release(&buf);
      }
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_overflow(void)
      		},
      	};
     -	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
    -+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
    ++	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
    ++							      &opts);
      
      	memset(msg, 'x', sizeof(msg) - 1);
      	reftable_writer_set_limits(w, update_index, update_index);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_overflow(void)
      	struct reftable_write_options opts = { 0 };
      	struct reftable_buf buf = REFTABLE_BUF_INIT;
     -	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
    -+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
    ++	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
    ++							      &opts);
      	struct reftable_log_record log = {
      		.refname = (char *)"refs/head/master",
      		.update_index = 0,
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_write_read(void)
      
     -		err = reftable_writer_add_ref(w, &ref);
     -		check(!err);
    -+		cl_assert(reftable_writer_add_ref(w, &ref) == 0);
    ++		cl_assert_equal_i(reftable_writer_add_ref(w, &ref), 0);
      	}
      
      	for (i = 0; i < N; i++) {
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_write_read(void)
      		log.update_index = i;
      		log.value_type = REFTABLE_LOG_UPDATE;
     -		t_reftable_set_hash(log.value.update.old_hash, i,
    -+		cl_reftable_set_hash(log.value.update.old_hash, i,
    - 				    REFTABLE_HASH_SHA1);
    +-				    REFTABLE_HASH_SHA1);
     -		t_reftable_set_hash(log.value.update.new_hash, i + 1,
    +-				    REFTABLE_HASH_SHA1);
    ++		cl_reftable_set_hash(log.value.update.old_hash, i,
    ++				     REFTABLE_HASH_SHA1);
     +		cl_reftable_set_hash(log.value.update.new_hash, i + 1,
    - 				    REFTABLE_HASH_SHA1);
    ++				     REFTABLE_HASH_SHA1);
      
     -		err = reftable_writer_add_log(w, &log);
     -		check(!err);
    -+		cl_assert(reftable_writer_add_log(w, &log) == 0);
    ++		cl_assert_equal_i(reftable_writer_add_log(w, &log), 0);
      	}
      
     -	n = reftable_writer_close(w);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_write_read(void)
     -		check(!err);
     -		check_str(names[i], log.refname);
     -		check_int(i, ==, log.update_index);
    -+		cl_assert(err == 0);
    ++		cl_assert(!err);
     +		cl_assert_equal_s(names[i], log.refname);
     +		cl_assert_equal_i(i, log.update_index);
      		reftable_log_record_release(&log);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_zlib_corruption(void)
      	struct reftable_block_source source = { 0 };
      	struct reftable_buf buf = REFTABLE_BUF_INIT;
     -	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
    -+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
    ++	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
    ++							      &opts);
      	const struct reftable_stats *stats = NULL;
      	char message[100] = { 0 };
     -	int err, i, n;
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_zlib_corruption(void)
     -
     -	n = reftable_writer_close(w);
     -	check_int(n, ==, 0);
    -+	cl_assert(reftable_writer_add_log(w, &log) == 0);
    ++	cl_assert_equal_i(reftable_writer_add_log(w, &log), 0);
     +	cl_assert_equal_i(reftable_writer_close(w), 0);
      
      	stats = reftable_writer_stats(w);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_read_write_seek(int ind
      
     -	check(!reftable_buf_addstr(&pastLast, names[N - 1]));
     -	check(!reftable_buf_addstr(&pastLast, "/"));
    -+	cl_assert(reftable_buf_addstr(&pastLast, names[N - 1]) == 0);
    -+	cl_assert(reftable_buf_addstr(&pastLast, "/") == 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&pastLast, names[N - 1]),
    ++					      0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&pastLast, "/"), 0);
      
      	err = reftable_table_init_ref_iterator(table, &it);
     -	check(!err);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_refs_for(int indexed)
      	struct reftable_block_source source = { 0 };
      	struct reftable_buf buf = REFTABLE_BUF_INIT;
     -	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
    -+	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
    ++	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf,
    ++							      &opts);
      	struct reftable_iterator it = { 0 };
     -	int N = 50, n, j, err, i;
     +	int N = 50, j, i;
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_refs_for(int indexed)
      
      		ref.value_type = REFTABLE_REF_VAL2;
     -		t_reftable_set_hash(ref.value.val2.value, i / 4,
    -+		cl_reftable_set_hash(ref.value.val2.value, i / 4,
    - 				    REFTABLE_HASH_SHA1);
    +-				    REFTABLE_HASH_SHA1);
     -		t_reftable_set_hash(ref.value.val2.target_value, 3 + i / 4,
    -+		cl_reftable_set_hash(ref.value.val2.target_value, 3 + i / 4,
    - 				    REFTABLE_HASH_SHA1);
    +-				    REFTABLE_HASH_SHA1);
    ++		cl_reftable_set_hash(ref.value.val2.value, i / 4,
    ++				     REFTABLE_HASH_SHA1);
    ++		cl_reftable_set_hash(ref.value.val2.target_value,
    ++				     3 + i / 4, REFTABLE_HASH_SHA1);
      
      		/* 80 bytes / entry, so 3 entries per block. Yields 17
      		 */
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_object_id_min_length(vo
      		ref.refname = name;
     -		err = reftable_writer_add_ref(w, &ref);
     -		check(!err);
    -+		cl_assert(reftable_writer_add_ref(w, &ref) == 0);
    ++		cl_assert_equal_i(reftable_writer_add_ref(w, &ref), 0);
      	}
      
     -	err = reftable_writer_close(w);
     -	check(!err);
     -	check_int(reftable_writer_stats(w)->object_id_len, ==, 2);
    -+	cl_assert(reftable_writer_close(w) == 0);
    ++	cl_assert_equal_i(reftable_writer_close(w), 0);
     +	cl_assert_equal_i(reftable_writer_stats(w)->object_id_len, 2);
      	reftable_writer_free(w);
      	reftable_buf_release(&buf);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_object_id_length(void)
     -	err = reftable_writer_close(w);
     -	check(!err);
     -	check_int(reftable_writer_stats(w)->object_id_len, ==, 16);
    -+	cl_assert(reftable_writer_close(w) == 0);
    ++	cl_assert_equal_i(reftable_writer_close(w), 0);
     +	cl_assert_equal_i(reftable_writer_stats(w)->object_id_len, 16);
      	reftable_writer_free(w);
      	reftable_buf_release(&buf);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_object_id_length(void)
     -	err = reftable_writer_close(w);
     -	check_int(err, ==, REFTABLE_EMPTY_TABLE_ERROR);
     +	cl_assert_equal_i(reftable_writer_add_ref(w, &ref), REFTABLE_API_ERROR);
    -+	cl_assert_equal_i(reftable_writer_close(w), REFTABLE_EMPTY_TABLE_ERROR);
    ++	cl_assert_equal_i(reftable_writer_close(w),
    ++			  REFTABLE_EMPTY_TABLE_ERROR);
      	reftable_writer_free(w);
      	reftable_buf_release(&buf);
      }
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_key_order(void)
     -	check(!err);
     -	err = reftable_writer_add_ref(w, &refs[1]);
     -	check_int(err, ==, REFTABLE_API_ERROR);
    -+	cl_assert(reftable_writer_add_ref(w, &refs[0]) == 0);
    -+	cl_assert_equal_i(reftable_writer_add_ref(w, &refs[1]), REFTABLE_API_ERROR);
    ++	cl_assert_equal_i(reftable_writer_add_ref(w, &refs[0]), 0);
    ++	cl_assert_equal_i(reftable_writer_add_ref(w, &refs[1]),
    ++			  REFTABLE_API_ERROR);
      
      	refs[0].update_index = 2;
     -	err = reftable_writer_add_ref(w, &refs[0]);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_multiple_indices(void)
      
     -		err = reftable_writer_add_ref(writer, &ref);
     -		check(!err);
    -+		cl_assert(reftable_writer_add_ref(writer, &ref) == 0);
    ++		cl_assert_equal_i(reftable_writer_add_ref(writer, &ref), 0);
      	}
      
      	for (i = 0; i < 100; i++) {
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_multiple_indices(void)
      
     -		err = reftable_writer_add_log(writer, &log);
     -		check(!err);
    -+		cl_assert(reftable_writer_add_log(writer, &log) == 0);
    ++		cl_assert_equal_i(reftable_writer_add_log(writer, &log), 0);
      	}
      
      	reftable_writer_close(writer);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_multi_level_index(void)
      
     -		err = reftable_writer_add_ref(writer, &ref);
     -		check(!err);
    -+		cl_assert(reftable_writer_add_ref(writer, &ref) == 0);
    ++		cl_assert_equal_i(reftable_writer_add_ref(writer, &ref), 0);
      	}
      	reftable_writer_close(writer);
      
 8:  df744c1458 !  8:  7b54300fac t/unit-tests: convert reftable record test to use clar
    @@ t/unit-tests/u-reftable-record.c: static void t_copy(struct reftable_record *rec
      
      	typ = reftable_record_type(rec);
     -	check(!reftable_record_init(&copy, typ));
    -+	cl_assert(reftable_record_init(&copy, typ) == 0);
    ++	cl_assert_equal_i(reftable_record_init(&copy, typ), 0);
      	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
      	/* do it twice to catch memory leaks */
      	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
     -	check(reftable_record_equal(rec, &copy, REFTABLE_HASH_SIZE_SHA1));
    -+	cl_assert(reftable_record_equal(rec, &copy, REFTABLE_HASH_SIZE_SHA1) != 0);
    ++	cl_assert(reftable_record_equal(rec, &copy,
    ++					REFTABLE_HASH_SIZE_SHA1) != 0);
      
      	reftable_record_release(&copy);
      }
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_ref_record_comparison(v
     -	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
     -	check(!cmp);
     +	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
    -+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
    -+	cl_assert(cmp == 0);
    ++	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
    ++	cl_assert(!cmp);
      
     -	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
     -	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
     -	check_int(cmp, >, 0);
    -+	cl_assert(reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1) == 0);
    -+	cl_assert(reftable_record_cmp(&in[1], &in[2], &cmp) == 0);
    ++	cl_assert(reftable_record_equal(&in[1], &in[2],
    ++					REFTABLE_HASH_SIZE_SHA1) == 0);
    ++	cl_assert_equal_i(reftable_record_cmp(&in[1], &in[2], &cmp), 0);
     +	cl_assert(cmp > 0);
      
      	in[1].u.ref.value_type = in[0].u.ref.value_type;
     -	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
     -	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
     -	check(!cmp);
    -+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
    -+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
    -+	cl_assert(cmp == 0);
    ++	cl_assert(reftable_record_equal(&in[0], &in[1],
    ++					REFTABLE_HASH_SIZE_SHA1) != 0);
    ++	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
    ++	cl_assert(!cmp);
      }
      
     -static void t_reftable_ref_record_compare_name(void)
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_ref_record_compare_name
     -	check_int(reftable_ref_record_compare_name(&recs[0], &recs[1]), <, 0);
     -	check_int(reftable_ref_record_compare_name(&recs[1], &recs[0]), >, 0);
     -	check_int(reftable_ref_record_compare_name(&recs[0], &recs[2]), ==, 0);
    -+	cl_assert(reftable_ref_record_compare_name(&recs[0], &recs[1]) < 0);
    -+	cl_assert(reftable_ref_record_compare_name(&recs[1], &recs[0]) > 0);
    -+	cl_assert_equal_i(reftable_ref_record_compare_name(&recs[0], &recs[2]), 0);
    ++	cl_assert(reftable_ref_record_compare_name(&recs[0],
    ++						   &recs[1]) < 0);
    ++	cl_assert(reftable_ref_record_compare_name(&recs[1],
    ++						   &recs[0]) > 0);
    ++	cl_assert_equal_i(reftable_ref_record_compare_name(&recs[0],
    ++							   &recs[2]), 0);
      }
      
     -static void t_reftable_ref_record_roundtrip(void)
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_ref_record_roundtrip(vo
     -		check_int(reftable_record_val_type(&in), ==, i);
     -		check_int(reftable_record_is_deletion(&in), ==, i == REFTABLE_REF_DELETION);
     +		cl_assert_equal_i(reftable_record_val_type(&in), i);
    -+		cl_assert_equal_i(reftable_record_is_deletion(&in),  i == REFTABLE_REF_DELETION);
    ++		cl_assert_equal_i(reftable_record_is_deletion(&in),
    ++				  i == REFTABLE_REF_DELETION);
      
      		reftable_record_key(&in, &key);
      		n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_ref_record_roundtrip(vo
      
     -		check(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
     -						 REFTABLE_HASH_SIZE_SHA1));
    -+		cl_assert(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
    -+											REFTABLE_HASH_SIZE_SHA1) != 0);
    ++		cl_assert(reftable_ref_record_equal(&in.u.ref,
    ++						    &out.u.ref,
    ++						    REFTABLE_HASH_SIZE_SHA1) != 0);
      		reftable_record_release(&in);
      
      		reftable_buf_release(&key);
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_log_record_comparison(v
     -	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
     -	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
     -	check_int(cmp, >, 0);
    -+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
    -+	cl_assert(reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1) == 0);
    -+	cl_assert(reftable_record_cmp(&in[1], &in[2], &cmp) == 0);
    ++	cl_assert_equal_i(reftable_record_equal(&in[0], &in[1],
    ++						REFTABLE_HASH_SIZE_SHA1), 0);
    ++	cl_assert_equal_i(reftable_record_equal(&in[1], &in[2],
    ++						REFTABLE_HASH_SIZE_SHA1), 0);
    ++	cl_assert_equal_i(reftable_record_cmp(&in[1], &in[2], &cmp), 0);
     +	cl_assert(cmp > 0);
      	/* comparison should be reversed for equal keys, because
      	 * comparison is now performed on the basis of update indices */
     -	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
     -	check_int(cmp, <, 0);
    -+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
    ++	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
     +	cl_assert(cmp < 0);
      
      	in[1].u.log.update_index = in[0].u.log.update_index;
     -	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
     -	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
    -+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
    -+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
    ++	cl_assert(reftable_record_equal(&in[0], &in[1],
    ++					REFTABLE_HASH_SIZE_SHA1) != 0);
    ++	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
      }
      
     -static void t_reftable_log_record_compare_key(void)
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_log_record_compare_key(
      
     -	check_int(reftable_log_record_compare_key(&logs[0], &logs[1]), <, 0);
     -	check_int(reftable_log_record_compare_key(&logs[1], &logs[0]), >, 0);
    -+	cl_assert(reftable_log_record_compare_key(&logs[0], &logs[1]) < 0);
    -+	cl_assert(reftable_log_record_compare_key(&logs[1], &logs[0]) > 0);
    ++	cl_assert(reftable_log_record_compare_key(&logs[0],
    ++						  &logs[1]) < 0);
    ++	cl_assert(reftable_log_record_compare_key(&logs[1],
    ++						  &logs[0]) > 0);
      
      	logs[1].update_index = logs[0].update_index;
     -	check_int(reftable_log_record_compare_key(&logs[0], &logs[1]), <, 0);
    -+	cl_assert(reftable_log_record_compare_key(&logs[0], &logs[1]) < 0);
    ++	cl_assert(reftable_log_record_compare_key(&logs[0],
    ++						  &logs[1]) < 0);
      
     -	check_int(reftable_log_record_compare_key(&logs[0], &logs[2]), >, 0);
     -	check_int(reftable_log_record_compare_key(&logs[2], &logs[0]), <, 0);
    -+	cl_assert(reftable_log_record_compare_key(&logs[0], &logs[2]) > 0);
    -+	cl_assert(reftable_log_record_compare_key(&logs[2], &logs[0]) < 0);
    ++	cl_assert(reftable_log_record_compare_key(&logs[0],
    ++						  &logs[2]) > 0);
    ++	cl_assert(reftable_log_record_compare_key(&logs[2],
    ++						  &logs[0]) < 0);
      	logs[2].update_index = logs[0].update_index;
     -	check_int(reftable_log_record_compare_key(&logs[0], &logs[2]), ==, 0);
     +	cl_assert_equal_i(reftable_log_record_compare_key(&logs[0], &logs[2]), 0);
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_log_record_roundtrip(vo
     -	check(!reftable_log_record_is_deletion(&in[0]));
     -	check(reftable_log_record_is_deletion(&in[1]));
     -	check(!reftable_log_record_is_deletion(&in[2]));
    -+	cl_assert(reftable_log_record_is_deletion(&in[0]) == 0);
    ++	cl_assert_equal_i(reftable_log_record_is_deletion(&in[0]), 0);
     +	cl_assert(reftable_log_record_is_deletion(&in[1]) != 0);
    -+	cl_assert(reftable_log_record_is_deletion(&in[2]) == 0);
    ++	cl_assert_equal_i(reftable_log_record_is_deletion(&in[2]), 0);
      
      	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
      		struct reftable_record rec = { .type = REFTABLE_BLOCK_TYPE_LOG };
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_log_record_roundtrip(vo
     -		check(reftable_log_record_equal(&in[i], &out.u.log,
     -						 REFTABLE_HASH_SIZE_SHA1));
     +		cl_assert(reftable_log_record_equal(&in[i], &out.u.log,
    -+											REFTABLE_HASH_SIZE_SHA1) != 0);
    ++						    REFTABLE_HASH_SIZE_SHA1) != 0);
      		reftable_log_record_release(&in[i]);
      		reftable_buf_release(&key);
      		reftable_record_release(&out);
    @@ t/unit-tests/u-reftable-record.c: static void t_key_roundtrip(void)
      
     -	check(!reftable_buf_addstr(&last_key, "refs/heads/master"));
     -	check(!reftable_buf_addstr(&key, "refs/tags/bla"));
    -+	cl_assert(reftable_buf_addstr(&last_key, "refs/heads/master") == 0);
    -+	cl_assert(reftable_buf_addstr(&key, "refs/tags/bla") == 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&last_key,
    ++					      "refs/heads/master"), 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&key,
    ++					      "refs/tags/bla"), 0);
      	extra = 6;
      	n = reftable_encode_key(&restart, dest, last_key, key, extra);
     -	check(!restart);
     -	check_int(n, >, 0);
    -+	cl_assert(restart == 0);
    ++	cl_assert(!restart);
     +	cl_assert(n > 0);
      
     -	check(!reftable_buf_addstr(&roundtrip, "refs/heads/master"));
    -+	cl_assert(reftable_buf_addstr(&roundtrip, "refs/heads/master") == 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&roundtrip,
    ++					      "refs/heads/master"), 0);
      	m = reftable_decode_key(&roundtrip, &rt_extra, dest);
     -	check_int(n, ==, m);
     -	check(!reftable_buf_cmp(&key, &roundtrip));
     -	check_int(rt_extra, ==, extra);
     +	cl_assert_equal_i(n, m);
    -+	cl_assert(reftable_buf_cmp(&key, &roundtrip) == 0);
    ++	cl_assert_equal_i(reftable_buf_cmp(&key, &roundtrip), 0);
     +	cl_assert_equal_i(rt_extra, extra);
      
      	reftable_buf_release(&last_key);
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_obj_record_comparison(v
     -	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
     -	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
     -	check(!cmp);
    -+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
    -+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
    -+	cl_assert(cmp == 0);
    ++	cl_assert_equal_i(reftable_record_equal(&in[0], &in[1],
    ++						REFTABLE_HASH_SIZE_SHA1), 0);
    ++	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
    ++	cl_assert(!cmp);
      
     -	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
     -	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
     -	check_int(cmp, >, 0);
    -+	cl_assert(reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1) == 0);
    -+	cl_assert(reftable_record_cmp(&in[1], &in[2], &cmp) == 0);
    ++	cl_assert_equal_i(reftable_record_equal(&in[1], &in[2],
    ++						REFTABLE_HASH_SIZE_SHA1), 0);
    ++	cl_assert_equal_i(reftable_record_cmp(&in[1], &in[2], &cmp), 0);
     +	cl_assert(cmp > 0);
      
      	in[1].u.obj.offset_len = in[0].u.obj.offset_len;
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_obj_record_comparison(v
     -	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
     -	check(!cmp);
     +	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
    -+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
    -+	cl_assert(cmp == 0);
    ++	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
    ++	cl_assert(!cmp);
      }
      
     -static void t_reftable_obj_record_roundtrip(void)
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_obj_record_roundtrip(vo
      		uint8_t extra;
      
     -		check(!reftable_record_is_deletion(&in));
    -+		cl_assert(reftable_record_is_deletion(&in) == 0);
    ++		cl_assert_equal_i(reftable_record_is_deletion(&in), 0);
      		t_copy(&in);
      		reftable_record_key(&in, &key);
      		n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_obj_record_roundtrip(vo
     +		cl_assert_equal_i(n, m);
      
     -		check(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1));
    -+		cl_assert(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1) != 0);
    ++		cl_assert(reftable_record_equal(&in, &out,
    ++						REFTABLE_HASH_SIZE_SHA1) != 0);
      		reftable_buf_release(&key);
      		reftable_record_release(&out);
      	}
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_index_record_comparison
     -	check(!reftable_buf_addstr(&in[0].u.idx.last_key, "refs/heads/master"));
     -	check(!reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master"));
     -	check(!reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch"));
    -+	cl_assert(reftable_buf_addstr(&in[0].u.idx.last_key, "refs/heads/master") == 0);
    -+	cl_assert(reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master") == 0);
    -+	cl_assert(reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch") == 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&in[0].u.idx.last_key,
    ++					      "refs/heads/master"), 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master"), 0);
    ++	cl_assert(reftable_buf_addstr(&in[2].u.idx.last_key,
    ++				      "refs/heads/branch") == 0);
      
     -	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
     -	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
     -	check(!cmp);
    -+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) == 0);
    -+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
    -+	cl_assert(cmp == 0);
    ++	cl_assert_equal_i(reftable_record_equal(&in[0], &in[1],
    ++						REFTABLE_HASH_SIZE_SHA1), 0);
    ++	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
    ++	cl_assert(!cmp);
      
     -	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
     -	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
     -	check_int(cmp, >, 0);
    -+	cl_assert(reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1) == 0);
    -+	cl_assert(reftable_record_cmp(&in[1], &in[2], &cmp) == 0);
    ++	cl_assert_equal_i(reftable_record_equal(&in[1], &in[2],
    ++						REFTABLE_HASH_SIZE_SHA1), 0);
    ++	cl_assert_equal_i(reftable_record_cmp(&in[1], &in[2], &cmp), 0);
     +	cl_assert(cmp > 0);
      
      	in[1].u.idx.offset = in[0].u.idx.offset;
     -	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
     -	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
     -	check(!cmp);
    -+	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
    -+	cl_assert(reftable_record_cmp(&in[0], &in[1], &cmp) == 0);
    -+	cl_assert(cmp == 0);
    ++	cl_assert(reftable_record_equal(&in[0], &in[1],
    ++					REFTABLE_HASH_SIZE_SHA1) != 0);
    ++	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
    ++	cl_assert(!cmp);
      
      	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
      		reftable_record_release(&in[i]);
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_index_record_roundtrip(
      	uint8_t extra;
      
     -	check(!reftable_buf_addstr(&in.u.idx.last_key, "refs/heads/master"));
    -+	cl_assert(reftable_buf_addstr(&in.u.idx.last_key, "refs/heads/master") == 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&in.u.idx.last_key,
    ++					      "refs/heads/master"), 0);
      	reftable_record_key(&in, &key);
      	t_copy(&in);
      
     -	check(!reftable_record_is_deletion(&in));
     -	check(!reftable_buf_cmp(&key, &in.u.idx.last_key));
    -+	cl_assert(reftable_record_is_deletion(&in) == 0);
    -+	cl_assert(reftable_buf_cmp(&key, &in.u.idx.last_key) == 0);
    ++	cl_assert_equal_i(reftable_record_is_deletion(&in), 0);
    ++	cl_assert_equal_i(reftable_buf_cmp(&key, &in.u.idx.last_key), 0);
      	n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
     -	check_int(n, >, 0);
     +	cl_assert(n > 0);
      
      	extra = reftable_record_val_type(&in);
    - 	m = reftable_record_decode(&out, key, extra, dest, REFTABLE_HASH_SIZE_SHA1,
    - 				   &scratch);
    +-	m = reftable_record_decode(&out, key, extra, dest, REFTABLE_HASH_SIZE_SHA1,
    +-				   &scratch);
     -	check_int(m, ==, n);
    ++	m = reftable_record_decode(&out, key, extra, dest,
    ++				   REFTABLE_HASH_SIZE_SHA1, &scratch);
     +	cl_assert_equal_i(m, n);
      
     -	check(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1));
    -+	cl_assert(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1) != 0);
    ++	cl_assert(reftable_record_equal(&in, &out,
    ++					REFTABLE_HASH_SIZE_SHA1) != 0);
      
      	reftable_record_release(&out);
      	reftable_buf_release(&key);
 9:  4a247de9e4 !  9:  8250eb25e8 t/unit-tests: convert reftable stack test to use clar
    @@ t/unit-tests/u-reftable-stack.c: static void t_read_file(void)
      
      	err = read_lines(fn, &names);
     -	check(!err);
    -+	cl_assert(err == 0);
    ++	cl_assert(!err);
      
      	for (size_t i = 0; names[i]; i++)
     -		check_str(want[i], names[i]);
    @@ t/unit-tests/u-reftable-stack.c: static void t_read_file(void)
      	struct reftable_ref_record *ref = arg;
     -	check(!reftable_writer_set_limits(wr, ref->update_index,
     -					  ref->update_index));
    -+	cl_assert(reftable_writer_set_limits(wr, ref->update_index,
    -+										 ref->update_index) == 0);
    ++	cl_assert_equal_i(reftable_writer_set_limits(wr,
    ++						     ref->update_index, ref->update_index), 0);
      	return reftable_writer_add_ref(wr, ref);
      }
      
    @@ t/unit-tests/u-reftable-stack.c: static void write_n_ref_tables(struct reftable_
      
     -		err = reftable_stack_add(st, &write_test_ref, &ref);
     -		check(!err);
    -+		cl_assert(reftable_stack_add(st, &write_test_ref, &ref) == 0);
    ++		cl_assert_equal_i(reftable_stack_add(st,
    ++						     &write_test_ref, &ref), 0);
      	}
      
      	st->opts.disable_auto_compact = disable_auto_compact;
    @@ t/unit-tests/u-reftable-stack.c: static int write_test_log(struct reftable_write
      
     -	check(!reftable_writer_set_limits(wr, wla->update_index,
     -					  wla->update_index));
    -+	cl_assert(reftable_writer_set_limits(wr, wla->update_index,
    -+										 wla->update_index) == 0);
    ++	cl_assert_equal_i(reftable_writer_set_limits(wr,
    ++						     wla->update_index,
    ++						     wla->update_index),  0);
      	return reftable_writer_add_log(wr, wla->log);
      }
      
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add_one(void)
     -	err = stat(scratch.buf, &stat_result);
     -	check(!err);
     -	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
    -+	cl_assert(reftable_buf_addstr(&scratch, dir) == 0);
    -+	cl_assert(reftable_buf_addstr(&scratch, "/tables.list") == 0);
    -+	cl_assert(stat(scratch.buf, &stat_result) == 0);
    -+	cl_assert_equal_i((stat_result.st_mode & 0777), opts.default_permissions);
    ++	cl_assert_equal_i(reftable_buf_addstr(&scratch, dir), 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&scratch,
    ++					      "/tables.list"), 0);
    ++	cl_assert_equal_i(stat(scratch.buf, &stat_result), 0);
    ++	cl_assert_equal_i((stat_result.st_mode & 0777),
    ++			  opts.default_permissions);
      
      	reftable_buf_reset(&scratch);
     -	check(!reftable_buf_addstr(&scratch, dir));
     -	check(!reftable_buf_addstr(&scratch, "/"));
    -+	cl_assert(reftable_buf_addstr(&scratch, dir) == 0);
    -+	cl_assert(reftable_buf_addstr(&scratch, "/") == 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&scratch, dir), 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&scratch, "/"), 0);
      	/* do not try at home; not an external API for reftable. */
     -	check(!reftable_buf_addstr(&scratch, st->tables[0]->name));
     +	cl_assert(!reftable_buf_addstr(&scratch, st->tables[0]->name));
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_uptodate(void)
     -
     -	err = reftable_stack_add(st2, write_test_ref, &ref2);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st1, dir, &opts) == 0);
    -+	cl_assert(reftable_new_stack(&st2, dir, &opts) == 0);
    -+	cl_assert(reftable_stack_add(st1, write_test_ref, &ref1) == 0);
    -+	cl_assert_equal_i(reftable_stack_add(st2, write_test_ref, &ref2),
    -+					  REFTABLE_OUTDATED_ERROR);
    -+	cl_assert(reftable_stack_reload(st2) == 0);
    -+	cl_assert(reftable_stack_add(st2, write_test_ref, &ref2) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st2, dir, &opts), 0);
    ++	cl_assert_equal_i(reftable_stack_add(st1, write_test_ref,
    ++					     &ref1), 0);
    ++	cl_assert_equal_i(reftable_stack_add(st2, write_test_ref,
    ++					     &ref2), REFTABLE_OUTDATED_ERROR);
    ++	cl_assert_equal_i(reftable_stack_reload(st2), 0);
    ++	cl_assert_equal_i(reftable_stack_add(st2, write_test_ref,
    ++					     &ref2), 0);
      	reftable_stack_destroy(st1);
      	reftable_stack_destroy(st2);
      	clear_dir(dir);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_transaction_api(vo
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      
      	reftable_addition_destroy(add);
      
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_transaction_api(vo
     -
     -	err = reftable_addition_commit(add);
     -	check(!err);
    -+	cl_assert(reftable_stack_new_addition(&add, st, 0) == 0);
    -+	cl_assert(reftable_addition_add(add, write_test_ref, &ref) == 0);
    -+	cl_assert(reftable_addition_commit(add) == 0);
    ++	cl_assert_equal_i(reftable_stack_new_addition(&add, st, 0), 0);
    ++	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
    ++						&ref), 0);
    ++	cl_assert_equal_i(reftable_addition_commit(add), 0);
      
      	reftable_addition_destroy(add);
      
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_transaction_api(vo
     -	check(!err);
     -	check_int(REFTABLE_REF_SYMREF, ==, dest.value_type);
     -	check(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1));
    -+	cl_assert(reftable_stack_read_ref(st, ref.refname, &dest) == 0);
    ++	cl_assert_equal_i(reftable_stack_read_ref(st, ref.refname,
    ++						  &dest), 0);
     +	cl_assert_equal_i(REFTABLE_REF_SYMREF, dest.value_type);
    -+	cl_assert(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1) != 0);
    ++	cl_assert(reftable_ref_record_equal(&ref, &dest,
    ++					    REFTABLE_HASH_SIZE_SHA1) != 0);
      
      	reftable_ref_record_release(&dest);
      	reftable_stack_destroy(st);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_transaction_with_r
     -	check(!err);
     -	err = reftable_addition_commit(add);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st1, dir, NULL) == 0);
    -+	cl_assert(reftable_new_stack(&st2, dir, NULL) == 0);
    -+	cl_assert(reftable_stack_new_addition(&add, st1, 0) == 0);
    -+	cl_assert(reftable_addition_add(add, write_test_ref, &refs[0]) == 0);
    -+	cl_assert(reftable_addition_commit(add) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st1, dir, NULL), 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
    ++	cl_assert_equal_i(reftable_stack_new_addition(&add, st1, 0), 0);
    ++	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
    ++						&refs[0]), 0);
    ++	cl_assert_equal_i(reftable_addition_commit(add), 0);
      	reftable_addition_destroy(add);
      
      	/*
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_transaction_with_r
     -	err = reftable_addition_commit(add);
     -	check(!err);
     +	cl_assert_equal_i(reftable_stack_new_addition(&add, st2, 0),
    -+					  REFTABLE_OUTDATED_ERROR);
    -+	cl_assert(reftable_stack_new_addition(&add, st2,
    -+										  REFTABLE_STACK_NEW_ADDITION_RELOAD) == 0);
    -+	cl_assert(reftable_addition_add(add, write_test_ref, &refs[1]) == 0);
    -+	cl_assert(reftable_addition_commit(add) == 0);
    ++						      REFTABLE_OUTDATED_ERROR);
    ++	cl_assert_equal_i(reftable_stack_new_addition(&add, st2,
    ++						      REFTABLE_STACK_NEW_ADDITION_RELOAD), 0);
    ++	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
    ++						&refs[1]), 0);
    ++	cl_assert_equal_i(reftable_addition_commit(add), 0);
      	reftable_addition_destroy(add);
      
      	for (size_t i = 0; i < ARRAY_SIZE(refs); i++) {
     -		err = reftable_stack_read_ref(st2, refs[i].refname, &ref);
     -		check(!err);
     -		check(reftable_ref_record_equal(&refs[i], &ref, REFTABLE_HASH_SIZE_SHA1));
    -+		cl_assert(reftable_stack_read_ref(st2, refs[i].refname, &ref) == 0);
    ++		cl_assert_equal_i(reftable_stack_read_ref(st2,
    ++							  refs[i].refname, &ref) , 0);
     +		cl_assert(reftable_ref_record_equal(&refs[i], &ref,
    -+											REFTABLE_HASH_SIZE_SHA1) != 0);
    ++						    REFTABLE_HASH_SIZE_SHA1) != 0);
      	}
      
      	reftable_ref_record_release(&ref);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_transaction_with_r
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      
      	for (size_t i = 0; i <= n; i++) {
      		struct reftable_ref_record ref = {
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_transaction_api_pe
     -
     -		err = reftable_addition_commit(add);
     -		check(!err);
    -+		cl_assert(reftable_stack_new_addition(&add, st, 0) == 0);
    -+		cl_assert(reftable_addition_add(add, write_test_ref, &ref) == 0);
    -+		cl_assert(reftable_addition_commit(add) == 0);
    ++		cl_assert_equal_i(reftable_stack_new_addition(&add,
    ++							      st, 0), 0);
    ++		cl_assert_equal_i(reftable_addition_add(add,
    ++							write_test_ref, &ref), 0);
    ++		cl_assert_equal_i(reftable_addition_commit(add), 0);
      
      		reftable_addition_destroy(add);
      
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction_fa
     -	check_int(st->merged->tables_len, ==, 1);
     -	check_int(st->stats.attempts, ==, 0);
     -	check_int(st->stats.failures, ==, 0);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    -+	cl_assert(reftable_stack_add(st, write_test_ref, &ref) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
    ++	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
    ++					     &ref), 0);
     +	cl_assert_equal_i(st->merged->tables_len, 1);
     +	cl_assert_equal_i(st->stats.attempts, 0);
     +	cl_assert_equal_i(st->stats.failures, 0);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_update_index_check
     -
     -	err = reftable_stack_add(st, write_test_ref, &ref2);
     -	check_int(err, ==, REFTABLE_API_ERROR);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    -+	cl_assert(reftable_stack_add(st, write_test_ref, &ref1) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
     +	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
    -+										 &ref2), REFTABLE_API_ERROR);
    ++					     &ref1), 0);
    ++	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
    ++					     &ref2), REFTABLE_API_ERROR);
      	reftable_stack_destroy(st);
      	clear_dir(dir);
      }
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_update_index_check
     -		err = reftable_stack_add(st, write_error, &i);
     -		check_int(err, ==, i);
     -	}
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
     +	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--)
    -+		cl_assert_equal_i(reftable_stack_add(st, write_error, &i), i);
    ++		cl_assert_equal_i(reftable_stack_add(st, write_error,
    ++						     &i), i);
      
      	reftable_stack_destroy(st);
      	clear_dir(dir);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add(void)
      		refs[i].update_index = i + 1;
      		refs[i].value_type = REFTABLE_REF_VAL1;
     -		t_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
    -+		cl_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
    ++		cl_reftable_set_hash(refs[i].value.val1, i,
    ++				     REFTABLE_HASH_SHA1);
      
      		logs[i].refname = xstrdup(buf);
      		logs[i].update_index = N + i + 1;
      		logs[i].value_type = REFTABLE_LOG_UPDATE;
      		logs[i].value.update.email = xstrdup("identity@invalid");
     -		t_reftable_set_hash(logs[i].value.update.new_hash, i, REFTABLE_HASH_SHA1);
    -+		cl_reftable_set_hash(logs[i].value.update.new_hash, i, REFTABLE_HASH_SHA1);
    ++		cl_reftable_set_hash(logs[i].value.update.new_hash, i,
    ++				     REFTABLE_HASH_SHA1);
      	}
      
     -	for (i = 0; i < N; i++) {
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add(void)
     -		check(!err);
     -	}
     +	for (i = 0; i < N; i++)
    -+		cl_assert(reftable_stack_add(st, write_test_ref, &refs[i]) == 0);
    ++		cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
    ++					     &refs[i]), 0);
      
      	for (i = 0; i < N; i++) {
      		struct write_log_arg arg = {
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add(void)
      		};
     -		int err = reftable_stack_add(st, write_test_log, &arg);
     -		check(!err);
    -+		cl_assert(reftable_stack_add(st, write_test_log, &arg) == 0);
    ++		cl_assert_equal_i(reftable_stack_add(st, write_test_log,
    ++						     &arg), 0);
      	}
      
     -	err = reftable_stack_compact_all(st, NULL);
     -	check(!err);
    -+	cl_assert(reftable_stack_compact_all(st, NULL) == 0);
    ++	cl_assert_equal_i(reftable_stack_compact_all(st, NULL), 0);
      
      	for (i = 0; i < N; i++) {
      		struct reftable_ref_record dest = { 0 };
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add(void)
     -		check(!err);
     -		check(reftable_ref_record_equal(&dest, refs + i,
     -						 REFTABLE_HASH_SIZE_SHA1));
    -+		cl_assert(reftable_stack_read_ref(st, refs[i].refname, &dest) == 0);
    ++		cl_assert_equal_i(reftable_stack_read_ref(st,
    ++							  refs[i].refname, &dest), 0);
     +		cl_assert(reftable_ref_record_equal(&dest, refs + i,
    -+											REFTABLE_HASH_SIZE_SHA1) != 0);
    ++						    REFTABLE_HASH_SIZE_SHA1) != 0);
      		reftable_ref_record_release(&dest);
      	}
      
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add(void)
     -		check(!err);
     -		check(reftable_log_record_equal(&dest, logs + i,
     -						 REFTABLE_HASH_SIZE_SHA1));
    -+		cl_assert(reftable_stack_read_log(st, refs[i].refname, &dest) == 0);
    ++		cl_assert_equal_i(reftable_stack_read_log(st,
    ++							  refs[i].refname, &dest), 0);
     +		cl_assert(reftable_log_record_equal(&dest, logs + i,
    -+											REFTABLE_HASH_SIZE_SHA1) != 0);
    ++						    REFTABLE_HASH_SIZE_SHA1) != 0);
      		reftable_log_record_release(&dest);
      	}
      
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add(void)
     -	err = stat(path.buf, &stat_result);
     -	check(!err);
     -	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
    -+	cl_assert(reftable_buf_addstr(&path, dir) == 0);
    -+	cl_assert(reftable_buf_addstr(&path, "/tables.list") == 0);
    -+	cl_assert(stat(path.buf, &stat_result) == 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&path, dir), 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&path, "/tables.list"), 0);
    ++	cl_assert_equal_i(stat(path.buf, &stat_result), 0);
     +	cl_assert_equal_i((stat_result.st_mode & 0777), opts.default_permissions);
      
      	reftable_buf_reset(&path);
     -	check(!reftable_buf_addstr(&path, dir));
     -	check(!reftable_buf_addstr(&path, "/"));
    -+	cl_assert(reftable_buf_addstr(&path, dir) == 0);
    -+	cl_assert(reftable_buf_addstr(&path, "/") == 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&path, dir), 0);
    ++	cl_assert_equal_i(reftable_buf_addstr(&path, "/"), 0);
      	/* do not try at home; not an external API for reftable. */
     -	check(!reftable_buf_addstr(&path, st->tables[0]->name));
     +	cl_assert(!reftable_buf_addstr(&path, st->tables[0]->name));
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add(void)
     -	check(!err);
     -	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
     +	cl_assert(!err);
    -+	cl_assert_equal_i((stat_result.st_mode & 0777), opts.default_permissions);
    ++	cl_assert_equal_i((stat_result.st_mode & 0777),
    ++			  opts.default_permissions);
      #else
      	(void) stat_result;
      #endif
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_iterator(void)
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      
      	for (i = 0; i < N; i++) {
      		refs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
      		refs[i].update_index = i + 1;
      		refs[i].value_type = REFTABLE_REF_VAL1;
     -		t_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
    -+		cl_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
    ++		cl_reftable_set_hash(refs[i].value.val1, i,
    ++				     REFTABLE_HASH_SHA1);
      
      		logs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
      		logs[i].update_index = i + 1;
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_iterator(void)
      		logs[i].value.update.email = xstrdup("johndoe@invalid");
      		logs[i].value.update.message = xstrdup("commit\n");
     -		t_reftable_set_hash(logs[i].value.update.new_hash, i, REFTABLE_HASH_SHA1);
    -+		cl_reftable_set_hash(logs[i].value.update.new_hash, i, REFTABLE_HASH_SHA1);
    ++		cl_reftable_set_hash(logs[i].value.update.new_hash, i,
    ++				     REFTABLE_HASH_SHA1);
      	}
      
     -	for (i = 0; i < N; i++) {
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_iterator(void)
     -		check(!err);
     -	}
     +	for (i = 0; i < N; i++)
    -+		cl_assert(reftable_stack_add(st, write_test_ref, &refs[i]) == 0);
    ++		cl_assert_equal_i(reftable_stack_add(st,
    ++						     write_test_ref, &refs[i]), 0);
      
      	for (i = 0; i < N; i++) {
      		struct write_log_arg arg = {
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_iterator(void)
      
     -		err = reftable_stack_add(st, write_test_log, &arg);
     -		check(!err);
    -+		cl_assert(reftable_stack_add(st, write_test_log, &arg) == 0);
    ++		cl_assert_equal_i(reftable_stack_add(st,
    ++						     write_test_log, &arg), 0);
      	}
      
      	reftable_stack_init_ref_iterator(st, &it);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_iterator(void)
      			break;
     -		check(!err);
     -		check(reftable_ref_record_equal(&ref, &refs[i], REFTABLE_HASH_SIZE_SHA1));
    -+		cl_assert(err == 0);
    ++		cl_assert(!err);
     +		cl_assert(reftable_ref_record_equal(&ref, &refs[i],
    -+											REFTABLE_HASH_SIZE_SHA1) != 0);
    ++						    REFTABLE_HASH_SIZE_SHA1) != 0);
      		reftable_ref_record_release(&ref);
      	}
     -	check_int(i, ==, N);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_iterator(void)
      
     -	err = reftable_stack_init_log_iterator(st, &it);
     -	check(!err);
    -+	cl_assert(reftable_stack_init_log_iterator(st, &it) == 0);
    ++	cl_assert_equal_i(reftable_stack_init_log_iterator(st, &it), 0);
      
      	reftable_iterator_seek_log(&it, logs[0].refname);
      	for (i = 0; ; i++) {
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_iterator(void)
      			break;
     -		check(!err);
     -		check(reftable_log_record_equal(&log, &logs[i], REFTABLE_HASH_SIZE_SHA1));
    -+		cl_assert(err == 0);
    ++		cl_assert(!err);
     +		cl_assert(reftable_log_record_equal(&log, &logs[i],
    -+											REFTABLE_HASH_SIZE_SHA1) != 0);
    ++						    REFTABLE_HASH_SIZE_SHA1) != 0);
      		reftable_log_record_release(&log);
      	}
     -	check_int(i, ==, N);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_log_normalize(void
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      
      	input.value.update.message = (char *) "one\ntwo";
     -	err = reftable_stack_add(st, write_test_log, &arg);
     -	check_int(err, ==, REFTABLE_API_ERROR);
     +	cl_assert_equal_i(reftable_stack_add(st, write_test_log,
    -+										 &arg), REFTABLE_API_ERROR);
    ++					     &arg), REFTABLE_API_ERROR);
      
      	input.value.update.message = (char *) "one";
     -	err = reftable_stack_add(st, write_test_log, &arg);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_log_normalize(void
     -	err = reftable_stack_read_log(st, input.refname, &dest);
     -	check(!err);
     -	check_str(dest.value.update.message, "one\n");
    -+	cl_assert(reftable_stack_add(st, write_test_log, &arg) == 0);
    -+	cl_assert(reftable_stack_read_log(st, input.refname, &dest) == 0);
    ++	cl_assert_equal_i(reftable_stack_add(st, write_test_log,
    ++					     &arg), 0);
    ++	cl_assert_equal_i(reftable_stack_read_log(st, input.refname,
    ++						  &dest), 0);
     +	cl_assert_equal_s(dest.value.update.message, "one\n");
      
      	input.value.update.message = (char *) "two\n";
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_log_normalize(void
     -	err = reftable_stack_read_log(st, input.refname, &dest);
     -	check(!err);
     -	check_str(dest.value.update.message, "two\n");
    -+	cl_assert(reftable_stack_add(st, write_test_log, &arg) == 0);
    -+	cl_assert(reftable_stack_read_log(st, input.refname, &dest) == 0);
    ++	cl_assert_equal_i(reftable_stack_add(st, write_test_log,
    ++					     &arg), 0);
    ++	cl_assert_equal_i(reftable_stack_read_log(st, input.refname,
    ++						  &dest), 0);
     +	cl_assert_equal_s(dest.value.update.message, "two\n");
      
      	/* cleanup */
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_log_normalize(void
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      
      	/* even entries add the refs, odd entries delete them. */
      	for (i = 0; i < N; i++) {
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_tombstone(void)
      		if (i % 2 == 0) {
      			refs[i].value_type = REFTABLE_REF_VAL1;
     -			t_reftable_set_hash(refs[i].value.val1, i,
    +-					    REFTABLE_HASH_SHA1);
     +			cl_reftable_set_hash(refs[i].value.val1, i,
    - 					    REFTABLE_HASH_SHA1);
    ++					     REFTABLE_HASH_SHA1);
      		}
      
    + 		logs[i].refname = xstrdup(buf);
     @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_tombstone(void)
      		logs[i].update_index = 1;
      		if (i % 2 == 0) {
      			logs[i].value_type = REFTABLE_LOG_UPDATE;
     -			t_reftable_set_hash(logs[i].value.update.new_hash, i,
    -+			cl_reftable_set_hash(logs[i].value.update.new_hash, i,
    - 					    REFTABLE_HASH_SHA1);
    +-					    REFTABLE_HASH_SHA1);
    ++			cl_reftable_set_hash(logs[i].value.update.new_hash, i, REFTABLE_HASH_SHA1);
      			logs[i].value.update.email =
      				xstrdup("identity@invalid");
      		}
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_tombstone(void)
     -		check(!err);
     -	}
     +	for (i = 0; i < N; i++)
    -+		cl_assert(reftable_stack_add(st, write_test_ref, &refs[i]) == 0);
    ++		cl_assert_equal_i(reftable_stack_add(st, write_test_ref, &refs[i]), 0);
      
      	for (i = 0; i < N; i++) {
      		struct write_log_arg arg = {
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_tombstone(void)
      		};
     -		int err = reftable_stack_add(st, write_test_log, &arg);
     -		check(!err);
    -+		cl_assert(reftable_stack_add(st, write_test_log, &arg) == 0);
    ++		cl_assert_equal_i(reftable_stack_add(st,
    ++						     write_test_log, &arg), 0);
      	}
      
     -	err = reftable_stack_read_ref(st, "branch", &dest);
     -	check_int(err, ==, 1);
    -+	cl_assert_equal_i(reftable_stack_read_ref(st, "branch", &dest), 1);
    ++	cl_assert_equal_i(reftable_stack_read_ref(st, "branch",
    ++						  &dest), 1);
      	reftable_ref_record_release(&dest);
      
     -	err = reftable_stack_read_log(st, "branch", &log_dest);
     -	check_int(err, ==, 1);
    -+	cl_assert_equal_i(reftable_stack_read_log(st, "branch", &log_dest), 1);
    ++	cl_assert_equal_i(reftable_stack_read_log(st, "branch",
    ++						  &log_dest), 1);
      	reftable_log_record_release(&log_dest);
      
     -	err = reftable_stack_compact_all(st, NULL);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_tombstone(void)
     -
     -	err = reftable_stack_read_log(st, "branch", &log_dest);
     -	check_int(err, ==, 1);
    -+	cl_assert(reftable_stack_compact_all(st, NULL) == 0);
    -+	cl_assert_equal_i(reftable_stack_read_ref(st, "branch", &dest), 1);
    -+	cl_assert_equal_i(reftable_stack_read_log(st, "branch", &log_dest), 1);
    ++	cl_assert_equal_i(reftable_stack_compact_all(st, NULL), 0);
    ++	cl_assert_equal_i(reftable_stack_read_ref(st, "branch",
    ++						  &dest), 1);
    ++	cl_assert_equal_i(reftable_stack_read_log(st, "branch",
    ++						  &log_dest), 1);
      	reftable_ref_record_release(&dest);
      	reftable_log_record_release(&log_dest);
      
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_hash_id(void)
     -
     -	err = reftable_stack_add(st, write_test_ref, &ref);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    -+	cl_assert(reftable_stack_add(st, write_test_ref, &ref) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
    ++	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
    ++					     &ref), 0);
      
      	/* can't read it with the wrong hash ID. */
     -	err = reftable_new_stack(&st32, dir, &opts32);
     -	check_int(err, ==, REFTABLE_FORMAT_ERROR);
    -+	cl_assert_equal_i(reftable_new_stack(&st32, dir, &opts32), REFTABLE_FORMAT_ERROR);
    ++	cl_assert_equal_i(reftable_new_stack(&st32, dir,
    ++					     &opts32), REFTABLE_FORMAT_ERROR);
      
      	/* check that we can read it back with default opts too. */
     -	err = reftable_new_stack(&st_default, dir, &opts_default);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_hash_id(void)
     -	check(!err);
     -
     -	check(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1));
    -+	cl_assert(reftable_new_stack(&st_default, dir, &opts_default) == 0);
    -+	cl_assert(reftable_stack_read_ref(st_default, "master", &dest) == 0);
    -+	cl_assert(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1) != 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st_default, dir,
    ++					     &opts_default), 0);
    ++	cl_assert_equal_i(reftable_stack_read_ref(st_default, "master",
    ++						  &dest), 0);
    ++	cl_assert(reftable_ref_record_equal(&ref, &dest,
    ++					    REFTABLE_HASH_SIZE_SHA1) != 0);
      	reftable_ref_record_release(&dest);
      	reftable_stack_destroy(st);
      	reftable_stack_destroy(st_default);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_hash_id(void)
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      
      	for (i = 1; i <= N; i++) {
      		char buf[256];
    @@ t/unit-tests/u-reftable-stack.c: static void t_reflog_expire(void)
      		logs[i].value.update.time = i;
      		logs[i].value.update.email = xstrdup("identity@invalid");
     -		t_reftable_set_hash(logs[i].value.update.new_hash, i,
    +-				    REFTABLE_HASH_SHA1);
     +		cl_reftable_set_hash(logs[i].value.update.new_hash, i,
    - 				    REFTABLE_HASH_SHA1);
    ++				     REFTABLE_HASH_SHA1);
      	}
      
    + 	for (i = 1; i <= N; i++) {
     @@ t/unit-tests/u-reftable-stack.c: static void t_reflog_expire(void)
      			.log = &logs[i],
      			.update_index = reftable_stack_next_update_index(st),
      		};
     -		int err = reftable_stack_add(st, write_test_log, &arg);
     -		check(!err);
    -+		cl_assert(reftable_stack_add(st, write_test_log, &arg) == 0);
    ++		cl_assert_equal_i(reftable_stack_add(st, write_test_log,
    ++						     &arg), 0);
      	}
      
     -	err = reftable_stack_compact_all(st, NULL);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reflog_expire(void)
     -
     -	err = reftable_stack_read_log(st, logs[11].refname, &log);
     -	check(!err);
    -+	cl_assert(reftable_stack_compact_all(st, NULL) == 0);
    -+	cl_assert(reftable_stack_compact_all(st, &expiry) == 0);
    -+	cl_assert_equal_i(reftable_stack_read_log(st, logs[9].refname, &log), 1);
    -+	cl_assert(reftable_stack_read_log(st, logs[11].refname, &log) == 0);
    ++	cl_assert_equal_i(reftable_stack_compact_all(st, NULL), 0);
    ++	cl_assert_equal_i(reftable_stack_compact_all(st, &expiry), 0);
    ++	cl_assert_equal_i(reftable_stack_read_log(st, logs[9].refname,
    ++						  &log), 1);
    ++	cl_assert_equal_i(reftable_stack_read_log(st, logs[11].refname,
    ++						  &log), 0);
      
      	expiry.min_update_index = 15;
     -	err = reftable_stack_compact_all(st, &expiry);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reflog_expire(void)
     -
     -	err = reftable_stack_read_log(st, logs[16].refname, &log);
     -	check(!err);
    -+	cl_assert(reftable_stack_compact_all(st, &expiry) == 0);
    -+	cl_assert_equal_i(reftable_stack_read_log(st, logs[14].refname, &log), 1);
    -+	cl_assert(reftable_stack_read_log(st, logs[16].refname, &log) == 0);
    ++	cl_assert_equal_i(reftable_stack_compact_all(st, &expiry), 0);
    ++	cl_assert_equal_i(reftable_stack_read_log(st, logs[14].refname,
    ++						  &log), 1);
    ++	cl_assert_equal_i(reftable_stack_read_log(st, logs[16].refname,
    ++						  &log), 0);
      
      	/* cleanup */
      	reftable_stack_destroy(st);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reflog_expire(void)
      static int write_nothing(struct reftable_writer *wr, void *arg UNUSED)
      {
     -	check(!reftable_writer_set_limits(wr, 1, 1));
    -+	cl_assert(reftable_writer_set_limits(wr, 1, 1) == 0);
    ++	cl_assert_equal_i(reftable_writer_set_limits(wr, 1, 1), 0);
      	return 0;
      }
      
    @@ t/unit-tests/u-reftable-stack.c: static void t_reflog_expire(void)
     -
     -	err = reftable_new_stack(&st2, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    -+	cl_assert(reftable_stack_add(st, write_nothing, NULL) == 0);
    -+	cl_assert(reftable_new_stack(&st2, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
    ++	cl_assert_equal_i(reftable_stack_add(st, write_nothing,
    ++					     NULL), 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st2, dir, &opts), 0);
      	clear_dir(dir);
      	reftable_stack_destroy(st);
      	reftable_stack_destroy(st2);
    @@ t/unit-tests/u-reftable-stack.c: static int fastlogN(uint64_t sz, uint64_t N)
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      
      	for (i = 0; i < N; i++) {
      		char name[100];
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction(vo
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      
      	for (size_t i = 0; i < N; i++) {
      		char name[20];
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction_wi
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      
      	write_n_ref_tables(st, 5);
     -	check_int(st->merged->tables_len, ==, 5);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction_wi
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      
      	for (i = 0; i <= n; i++) {
      		struct reftable_ref_record ref = {
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add_performs_auto_
      
     -		err = reftable_stack_add(st, write_test_ref, &ref);
     -		check(!err);
    -+		cl_assert(reftable_stack_add(st, write_test_ref, &ref) == 0);
    ++		cl_assert_equal_i(reftable_stack_add(st,
    ++						     write_test_ref, &ref), 0);
      
      		/*
      		 * The stack length should grow continuously for all runs where
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_compaction_with_lo
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      
      	write_n_ref_tables(st, 3);
     -	check_int(st->merged->tables_len, ==, 3);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_compaction_with_lo
      
     -	err = reftable_new_stack(&st1, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st1, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
      	write_n_ref_tables(st1, 3);
      
     -	err = reftable_new_stack(&st2, dir, &opts);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_compaction_with_lo
     -
     -	err = reftable_stack_compact_all(st1, NULL);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st2, dir, &opts) == 0);
    -+	cl_assert(reftable_stack_compact_all(st1, NULL) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st2, dir, &opts), 0);
    ++	cl_assert_equal_i(reftable_stack_compact_all(st1, NULL), 0);
      
      	reftable_stack_destroy(st1);
      	reftable_stack_destroy(st2);
    @@ t/unit-tests/u-reftable-stack.c: static void unclean_stack_close(struct reftable
      
     -	err = reftable_new_stack(&st1, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st1, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
      	write_n_ref_tables(st1, 3);
      
     -	err = reftable_new_stack(&st2, dir, &opts);
    @@ t/unit-tests/u-reftable-stack.c: static void unclean_stack_close(struct reftable
     -
     -	err = reftable_stack_compact_all(st1, NULL);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st2, dir, &opts) == 0);
    -+	cl_assert(reftable_stack_compact_all(st1, NULL) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st2, dir, &opts), 0);
    ++	cl_assert_equal_i(reftable_stack_compact_all(st1, NULL), 0);
      
      	unclean_stack_close(st1);
      	unclean_stack_close(st2);
    @@ t/unit-tests/u-reftable-stack.c: static void unclean_stack_close(struct reftable
     -	err = reftable_stack_clean(st3);
     -	check(!err);
     -	check_int(count_dir_entries(dir), ==, 2);
    -+	cl_assert(reftable_new_stack(&st3, dir, &opts) == 0);
    -+	cl_assert(reftable_stack_clean(st3) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st3, dir, &opts), 0);
    ++	cl_assert_equal_i(reftable_stack_clean(st3), 0);
     +	cl_assert_equal_i(count_dir_entries(dir), 2);
      
      	reftable_stack_destroy(st1);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_read_across_reload
      	/* Create a first stack and set up an iterator for it. */
     -	err = reftable_new_stack(&st1, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st1, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st1, dir, &opts), 0);
      	write_n_ref_tables(st1, 2);
     -	check_int(st1->merged->tables_len, ==, 2);
     +	cl_assert_equal_i(st1->merged->tables_len, 2);
      	reftable_stack_init_ref_iterator(st1, &it);
     -	err = reftable_iterator_seek_ref(&it, "");
     -	check(!err);
    -+	cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
    ++	cl_assert_equal_i(reftable_iterator_seek_ref(&it, ""), 0);
      
      	/* Set up a second stack for the same directory and compact it. */
      	err = reftable_new_stack(&st2, dir, &opts);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_reload_with_missin
      	/* Create a first stack and set up an iterator for it. */
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      	write_n_ref_tables(st, 2);
     -	check_int(st->merged->tables_len, ==, 2);
     +	cl_assert_equal_i(st->merged->tables_len, 2);
      	reftable_stack_init_ref_iterator(st, &it);
     -	err = reftable_iterator_seek_ref(&it, "");
     -	check(!err);
    -+	cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
    ++	cl_assert_equal_i(reftable_iterator_seek_ref(&it, ""), 0);
      
      	/*
      	 * Update the tables.list file with some garbage data, while reusing
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_reload_with_missin
      	write_file_buf(table_path.buf, content.buf, content.len);
     -	err = rename(table_path.buf, st->list_file);
     -	check(!err);
    -+	cl_assert(rename(table_path.buf, st->list_file) == 0);
    ++	cl_assert_equal_i(rename(table_path.buf, st->list_file), 0);
      
      	err = reftable_stack_reload(st);
     -	check_int(err, ==, -4);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_reload_with_missin
     -	check_str(rec.refname, "refs/heads/branch-0001");
     -	err = reftable_iterator_next_ref(&it, &rec);
     -	check_int(err, >, 0);
    -+	cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
    ++	cl_assert_equal_i(reftable_iterator_next_ref(&it, &rec), 0);
     +	cl_assert_equal_s(rec.refname, "refs/heads/branch-0000");
    -+	cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
    ++	cl_assert_equal_i(reftable_iterator_next_ref(&it, &rec), 0);
     +	cl_assert_equal_s(rec.refname, "refs/heads/branch-0001");
     +	cl_assert(reftable_iterator_next_ref(&it, &rec) > 0);
      
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_reload_with_missin
      	struct reftable_ref_record *ref = arg;
     -	check(!reftable_writer_set_limits(wr, ref->update_index, ref->update_index));
     -	check(!reftable_writer_add_ref(wr, ref));
    -+	cl_assert(reftable_writer_set_limits(wr, ref->update_index,
    -+										 ref->update_index) == 0);
    -+	cl_assert(reftable_writer_add_ref(wr, ref) == 0);
    ++	cl_assert_equal_i(reftable_writer_set_limits(wr,
    ++						     ref->update_index, ref->update_index), 0);
    ++	cl_assert_equal_i(reftable_writer_add_ref(wr, ref), 0);
      	return reftable_writer_set_limits(wr, ref->update_index, ref->update_index);
      }
      
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_invalid_limit_updates(vo
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, &opts), 0);
      
      	reftable_addition_destroy(add);
      
     -	err = reftable_stack_new_addition(&add, st, 0);
     -	check(!err);
    -+	cl_assert(reftable_stack_new_addition(&add, st, 0) == 0);
    ++	cl_assert_equal_i(reftable_stack_new_addition(&add, st, 0), 0);
      
      	/*
      	 * write_limits_after_ref also updates the update indexes after adding
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_invalid_limit_updates(vo
      	 */
     -	err = reftable_addition_add(add, write_limits_after_ref, &ref);
     -	check_int(err, ==, REFTABLE_API_ERROR);
    -+	cl_assert_equal_i(reftable_addition_add(add, write_limits_after_ref, &ref),
    -+					  REFTABLE_API_ERROR);
    ++	cl_assert_equal_i(reftable_addition_add(add,
    ++						write_limits_after_ref, &ref), REFTABLE_API_ERROR);
      
      	reftable_addition_destroy(add);
      	reftable_stack_destroy(st);
10:  bf271f4ddf ! 10:  8469fe3c0f t/unit-tests: finalize migration of reftable-related tests
    @@ Commit message
         tests to the Clar framework, Clar-specific versions of these functions
         in `lib-reftable-clar.{c,h}` were introduced.
     
    -    Now that all test files using these helpers have been converted to Clar, we
    -    can safely remove the original `lib-reftable.{c,h}` and rename the Clar-
    -    specific versions back to `lib-reftable.{c,h}`. This restores a clean and
    -    consistent naming scheme for shared test utilities.
    +    Now that all test files using these helpers have been converted to Clar,
    +    we can safely remove the original `lib-reftable.{c,h}` and rename the
    +    Clar- specific versions back to `lib-reftable.{c,h}`. This restores a
    +    clean and consistent naming scheme for shared test utilities.
     
         Finally, update our build system to reflect the changes made and remove
         redundant code related to the reftable tests and our old homegrown
    -    unit-testing setup.
    +    unit-testing setup. `test-lib.{c,h}` remains unchanged in our build
    +    system as some files particularly `t/helper/test-example-tap.c` depends
    +    on it in order to run, and removing that would be beyond the scope of
    +    this patch.
     
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
     
    @@ t/unit-tests/u-reftable-stack.c: void test_reftable_stack__add(void)
     
      ## t/unit-tests/u-reftable-table.c ##
     @@
    - #include "test-lib.h"
    + #include "unit-test.h"
     -#include "lib-reftable-clar.h"
     +#include "lib-reftable.h"
      #include "reftable/blocksource.h"
-- 
2.43.0

