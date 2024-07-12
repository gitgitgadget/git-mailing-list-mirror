Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B5182C3
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763483; cv=none; b=IlVmwSuhy74CF/xJwf16zldNkW9oETPryH46BWnRq54V+BSO2nQVLU1HoZGovHN8ZSlTJjNDBYImNCumdmPNdy4pyk1O6up94gArDGDLOtK9HCGnKO6/2PAj8V+hlBwA7XOy2fX4GDpW0AFV7HIaDYR8BIO8JyCQX00Go++w2S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763483; c=relaxed/simple;
	bh=zMOc3i08fkgoEhiG3l4cyOZy3hVZnQWnVL1ewwYinVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hc36iXiyK1foHetR9UyKjYDBl9NuGzWaCI66rE1JBKRMnFUZ7nf81MqSU4Fddq18CJayhwJBibu0/xLudDtVD98xeUK8a3eaL8GJYTKsCbJaTJyYCdfs01r9xMN6Z3cF0T7OITrucGqgfn9HK2L4Svt7KbjMelwCD3by7Ayc2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDYF0baR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDYF0baR"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70af22a9c19so1300737b3a.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 22:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720763480; x=1721368280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ez5PQlbmtJ1nlREmiNMnvVjaRrMAhVHItwiOA6s2ugk=;
        b=hDYF0baRVLg529ojJWYiQYWpafXYHy3RoI1XXLeNpuQZkQFVEFjwJjvX4Lr4DkTxCS
         cZdpo1kCiHaTQ93Aj9Wh70Rx7ukdabRuuefckYEHaV/t5rnX97RSnryg0WOj7kcmrj8f
         qyrWGmOlQg5DmyKbRaHT1IH9lxAhnLno7vb2xgX0Sz+4cQya694tyT/fuYgiltvsS1sU
         jkAYztQDXYc8pER7SWqu5XMWClfNRagk+1ZDhM/mUgK0oRv/3YKa1+qXo5jN5iPBhxxi
         ZNVVz58Gll2r+7TpwnIlwdIpSU6oI0lFn6KGgnvZN5TVP+lTvb0E3+SjZRsh4IscvKTt
         XC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720763480; x=1721368280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ez5PQlbmtJ1nlREmiNMnvVjaRrMAhVHItwiOA6s2ugk=;
        b=sc5ku6nuNR46nemXjLFEb6SJUIZXPopofwtXK5uhHbpzSENl1Jd0WJBWoC/mz40+TJ
         lOIFbfHZyFk+3R9cM+hJGa2UQSDiuKBq4M33VXEQQGigYznNZWFKvf8aIjM5obS46RMx
         NQuft16yPBW7hZA0XmtVTWvYJmX3WXkIJFv+cehEIeazcbqr7Vq13HjFvjpGLF7R60Wj
         dmRspAUBD50VGAJIiy1wfVXFSeJiXk+2DzR8gZsZY/IZkx3EZf+GEYVGg2lO7rheyxlq
         wL26iyKWspPN2lpJn4K5wxdX+jJsPGkvyh++E81sJfVb6Y1Q5bIJFwZUV/OmJ4ZdopsF
         Uw4Q==
X-Gm-Message-State: AOJu0YwIDroq/P+wr0OzWvnfP9CpdZnOtiQN3PiYxZ+WO6Szda6Yapo9
	kzZ8svFJIsZN1QRjwEAIca9R5ckR78bdVie8oICdRy+SE1Ixy6AXerAQBg==
X-Google-Smtp-Source: AGHT+IHDl5EHsWcHYlkjnYi2ND8ywvPLKtL8NrXPgUlmhoXmaEfvu1SDHDU/i5gtXUOHjrgHXjBAJg==
X-Received: by 2002:a05:6a00:3e25:b0:705:9fc7:9133 with SMTP id d2e1a72fcca58-70b435e7ee2mr13075192b3a.23.1720763475433;
        Thu, 11 Jul 2024 22:51:15 -0700 (PDT)
Received: from Ubuntu.. ([117.96.148.106])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b4397f475sm6604651b3a.150.2024.07.11.22.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:51:14 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [GSoC][PATCH v4 0/7] t: port reftable/merged_test.c to the unit testing framework
Date: Fri, 12 Jul 2024 11:08:56 +0530
Message-ID: <20240712055041.6476-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240711040854.4602-1-chandrapratap3519@gmail.com>
References: <20240711040854.4602-1-chandrapratap3519@gmail.com>
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
Changes in v4:
- Make more variables 'size_t' and remove redundant initialization
  in patch 2 in-line with Junio's comments on v3.
- Use ARRAY_SIZE in patch 2 instead of hardcoding arrays' element counts.

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
reftable/reftable-tests.h				   |   1 -
reftable/merged_test.c => t/unit-tests/t-reftable-merged.c | 208 +++++++++++++++----------------
4 files changed, 106 insertions(+), 106 deletions(-)

Range-diff against v3:
1:  08c993f5f6 ! 1:  963b9397b2 t: harmonize t-reftable-merged.c with coding guidelines
    @@ Commit message
         - Single line control flow statements like 'for' and 'if'
           must omit curly braces.
         - Structs must be 0-initialized with '= { 0 }' instead of '= { NULL }'.
    -    - Array indices must be of type 'size_t', not 'int'.
    +    - Array indices should preferably be of type 'size_t', not 'int'.
         - It is fine to use C99 initial declaration in 'for' loop.
     
    +    While at it, use 'ARRAY_SIZE(x)' to store the number of elements
    +    in an array instead of hardcoding them.
    +
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
     
      ## t/unit-tests/t-reftable-merged.c ##
    +@@ t/unit-tests/t-reftable-merged.c: static int noop_flush(void *arg)
    + }
    + 
    + static void write_test_table(struct strbuf *buf,
    +-			     struct reftable_ref_record refs[], int n)
    ++			     struct reftable_ref_record refs[], size_t n)
    + {
    + 	uint64_t min = 0xffffffff;
    + 	uint64_t max = 0;
    +-	int i = 0;
    ++	size_t i;
    + 	int err;
    + 
    + 	struct reftable_write_options opts = {
     @@ t/unit-tests/t-reftable-merged.c: static void write_test_table(struct strbuf *buf,
      	struct reftable_writer *w = NULL;
      	for (i = 0; i < n; i++) {
    @@ t/unit-tests/t-reftable-merged.c: static void write_test_table(struct strbuf *bu
      	}
      
      	w = reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
    -@@ t/unit-tests/t-reftable-merged.c: static void write_test_log_table(struct strbuf *buf,
    - 				 struct reftable_log_record logs[], int n,
    +@@ t/unit-tests/t-reftable-merged.c: static void write_test_table(struct strbuf *buf,
    + }
    + 
    + static void write_test_log_table(struct strbuf *buf,
    +-				 struct reftable_log_record logs[], int n,
    ++				 struct reftable_log_record logs[], size_t n,
      				 uint64_t update_index)
      {
     -	int i = 0;
    @@ t/unit-tests/t-reftable-merged.c: static void write_test_log_table(struct strbuf
      	reftable_writer_set_limits(w, update_index, update_index);
      
     -	for (i = 0; i < n; i++) {
    -+	for (int i = 0; i < n; i++) {
    ++	for (size_t i = 0; i < n; i++) {
      		int err = reftable_writer_add_log(w, &logs[i]);
      		check(!err);
      	}
    +@@ t/unit-tests/t-reftable-merged.c: static void write_test_log_table(struct strbuf *buf,
    + static struct reftable_merged_table *
    + merged_table_from_records(struct reftable_ref_record **refs,
    + 			  struct reftable_block_source **source,
    +-			  struct reftable_reader ***readers, int *sizes,
    ++			  struct reftable_reader ***readers, size_t *sizes,
    + 			  struct strbuf *buf, size_t n)
    + {
    + 	struct reftable_merged_table *mt = NULL;
     @@ t/unit-tests/t-reftable-merged.c: merged_table_from_records(struct reftable_ref_record **refs,
      
      static void readers_destroy(struct reftable_reader **readers, size_t n)
    @@ t/unit-tests/t-reftable-merged.c: merged_table_from_records(struct reftable_ref_
      	reftable_free(readers);
      }
     @@ t/unit-tests/t-reftable-merged.c: static void t_merged_single_record(void)
    + 	} };
    + 
    + 	struct reftable_ref_record *refs[] = { r1, r2 };
    +-	int sizes[] = { 1, 1 };
    ++	size_t sizes[] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2) };
    + 	struct strbuf bufs[2] = { STRBUF_INIT, STRBUF_INIT };
    + 	struct reftable_block_source *bs = NULL;
      	struct reftable_reader **readers = NULL;
      	struct reftable_merged_table *mt =
      		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
    @@ t/unit-tests/t-reftable-merged.c: static void t_merged_single_record(void)
      }
      
     @@ t/unit-tests/t-reftable-merged.c: static void t_merged_refs(void)
    + 	};
    + 
    + 	struct reftable_ref_record *refs[] = { r1, r2, r3 };
    +-	int sizes[3] = { 3, 1, 2 };
    ++	size_t sizes[3] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
    + 	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
    + 	struct reftable_block_source *bs = NULL;
      	struct reftable_reader **readers = NULL;
      	struct reftable_merged_table *mt =
      		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
    @@ t/unit-tests/t-reftable-merged.c: static void t_merged_refs(void)
      	readers_destroy(readers, 3);
      	reftable_merged_table_free(mt);
      	reftable_free(bs);
    +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_refs(void)
    + static struct reftable_merged_table *
    + merged_table_from_log_records(struct reftable_log_record **logs,
    + 			      struct reftable_block_source **source,
    +-			      struct reftable_reader ***readers, int *sizes,
    ++			      struct reftable_reader ***readers, size_t *sizes,
    + 			      struct strbuf *buf, size_t n)
    + {
    + 	struct reftable_merged_table *mt = NULL;
     @@ t/unit-tests/t-reftable-merged.c: static void t_merged_logs(void)
    + 	};
    + 
    + 	struct reftable_log_record *logs[] = { r1, r2, r3 };
    +-	int sizes[3] = { 2, 1, 1 };
    ++	size_t sizes[3] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
    + 	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
    + 	struct reftable_block_source *bs = NULL;
      	struct reftable_reader **readers = NULL;
      	struct reftable_merged_table *mt = merged_table_from_log_records(
      		logs, &bs, &readers, sizes, bufs, 3);
    @@ t/unit-tests/t-reftable-merged.c: static void t_merged_logs(void)
      	size_t len = 0;
      	size_t cap = 0;
     -	int i = 0;
    -+	size_t i = 0;
    ++	size_t i;
      
      	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
      	err = reftable_iterator_seek_log(&it, "a");
2:  fa3085bd9b ! 2:  b7a0bd8165 t-reftable-merged: improve the test t_merged_single_record()
    @@ t/unit-tests/t-reftable-merged.c: static void t_merged_single_record(void)
     +	} };
      
     -	struct reftable_ref_record *refs[] = { r1, r2 };
    --	int sizes[] = { 1, 1 };
    +-	size_t sizes[] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2) };
     -	struct strbuf bufs[2] = { STRBUF_INIT, STRBUF_INIT };
     +	struct reftable_ref_record *refs[] = { r1, r2, r3 };
    -+	int sizes[] = { 1, 1, 1 };
    ++	size_t sizes[] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
     +	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
      	struct reftable_block_source *bs = NULL;
      	struct reftable_reader **readers = NULL;
3:  d491c1f383 ! 3:  e86d19a1c8 t-reftable-merged: improve the const-correctness of helper functions
    @@ t/unit-tests/t-reftable-merged.c: static int noop_flush(void *arg)
      }
      
      static void write_test_table(struct strbuf *buf,
    --			     struct reftable_ref_record refs[], int n)
    -+			     struct reftable_ref_record refs[], const int n)
    +-			     struct reftable_ref_record refs[], size_t n)
    ++			     struct reftable_ref_record refs[], const size_t n)
      {
      	uint64_t min = 0xffffffff;
      	uint64_t max = 0;
    @@ t/unit-tests/t-reftable-merged.c: static void write_test_table(struct strbuf *bu
      }
      
     -static void write_test_log_table(struct strbuf *buf,
    --				 struct reftable_log_record logs[], int n,
    +-				 struct reftable_log_record logs[], size_t n,
     -				 uint64_t update_index)
     +static void write_test_log_table(struct strbuf *buf, struct reftable_log_record logs[],
    -+				 const int n, const uint64_t update_index)
    ++				 const size_t n, const uint64_t update_index)
      {
      	int err;
      
    @@ t/unit-tests/t-reftable-merged.c: static void write_test_log_table(struct strbuf
      static struct reftable_merged_table *
      merged_table_from_records(struct reftable_ref_record **refs,
      			  struct reftable_block_source **source,
    --			  struct reftable_reader ***readers, int *sizes,
    +-			  struct reftable_reader ***readers, size_t *sizes,
     -			  struct strbuf *buf, size_t n)
    -+			  struct reftable_reader ***readers, const int *sizes,
    ++			  struct reftable_reader ***readers, const size_t *sizes,
     +			  struct strbuf *buf, const size_t n)
      {
      	struct reftable_merged_table *mt = NULL;
    @@ t/unit-tests/t-reftable-merged.c: static void t_merged_refs(void)
      static struct reftable_merged_table *
      merged_table_from_log_records(struct reftable_log_record **logs,
      			      struct reftable_block_source **source,
    --			      struct reftable_reader ***readers, int *sizes,
    +-			      struct reftable_reader ***readers, size_t *sizes,
     -			      struct strbuf *buf, size_t n)
    -+			      struct reftable_reader ***readers, const int *sizes,
    ++			      struct reftable_reader ***readers, const size_t *sizes,
     +			      struct strbuf *buf, const size_t n)
      {
      	struct reftable_merged_table *mt = NULL;
4:  ee9909f7ce = 4:  561ea9c5e9 t-reftable-merged: add tests for reftable_merged_table_max_update_index
5:  5ce16e9cfc = 5:  7f1a329e94 t-reftable-merged: use reftable_ref_record_equal to compare ref records
6:  d090e9ca5b = 6:  feaf46b765 t-reftable-merged: add test for REFTABLE_FORMAT_ERROR

