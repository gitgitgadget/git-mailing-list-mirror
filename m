Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A2198821
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900371; cv=none; b=Bbbe5X14NR5ALO5lDs5iGk1e0qxDUjqaYRJqAAQ+pa9mbKXCgoQCiNCbcVskXEuIdHMQfndhExyeuOSXVoNhR00AVK8DY3clkb4ikjA591qeG6vSbgUMzljrQk88DRFD0lsIdG9jwrdsTYfMOSngfkDznZOhqHL6LC6EOYkIyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900371; c=relaxed/simple;
	bh=kVq0yKkzEQTByLqpd9+loMj1Ib08rmLXVdjNvrfKJZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgbef8bksxB7m158MwOyXUm/GmgWr2bGlDy1jHzX0NkFcIEd/ju7WdeiyaImDQB2PTVD5AsnZwCOsf1/mxZuZ93ZMFjEFuRfmQ6jEaEXkEHJJIZ6okD/1etDT9ytjLjiB3nMjFU83Zla18QSmBEsMx70EP+RxUB47M3P71a9314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4mqfqSM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4mqfqSM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc60c3ead4so5574115ad.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900367; x=1722505167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymcb9lUS3jzCVZZyQwyVYMQQ4fFRzCW/OMd3OKhoyWU=;
        b=D4mqfqSMwJ2i8kCJN2gnU8MeMuocNIYvRHxYheiPWe5v4kFeKrFwwZa/JqMU2Iy1fG
         0fLXQl3NcfQ2vdpqeAez2QVwmLStM90fRLyQpNdia2VXzPRoLQbbOtqECfbXJtHPtn31
         J7FbHcYXPIdpYXwOiS9E3YES7Kvui0gm9opynCg1XDi9yrLhFwaVN/Z42NIR1djIrUqk
         7Aj1qW412U+x1I7eylgBdgjFIZ6PVNW6xkqKdExC0gra+pIRoNb24yx7uSy7DGMZ9Rye
         GXavbpxedgTfV5RI7n2ICS9fZ0cNYkPjry7hHpABDPr8NbvDNBW8dKdyaeuoy5aRPcyi
         okjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900367; x=1722505167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymcb9lUS3jzCVZZyQwyVYMQQ4fFRzCW/OMd3OKhoyWU=;
        b=H1y0vu6VHEasbtuEAHCRwjJXyxxQ2I8YsDPj/z1WQpjOXN1keVPzfdNBSiQV+O5zir
         bSHwwoP69dEykhtkkrdsHWeSqVfXyWmT2gQGhTFHpWyk0biTDgNQuLRiHHt5991eoJay
         1eYsibr9ifGuwp/eVT8GTUE+KRAEFnA+v24EHDyVGW4Q8eTFiGyBTvtb/ecB40BM60Pn
         pY3THtPfLKsdAHQMCj7Pa+wB30dDh+QgSBvysYKku7k66C7HskuXqRyqoLMwTAYyO1Vh
         kV60a1/nNvep8aoIgyvSbcpRPNTLS+3koPGOSA/unvw8fA0FauaUIjjQEijfk1DrStSB
         +91g==
X-Gm-Message-State: AOJu0Yya3JAhzV5mjsZKM45jxCkKHJ9H5EQfSWl+tXrHodjXgJlceEjN
	ZwZS0RMBHoAvm0zpwCJIIeP8EEB4/JamnOujtJ4YRjk04QyUUd6q4fSaKA==
X-Google-Smtp-Source: AGHT+IEdkB96z8z7qz6nV4bdonLksr+LvIu/J090fZmI4r/C/Kc2DGlliF5E6mFgaPAWDBr2ml/s+w==
X-Received: by 2002:a17:903:41d1:b0:1fb:8a0e:76f9 with SMTP id d9443c01a7336-1fed38b456fmr23946345ad.39.1721900366749;
        Thu, 25 Jul 2024 02:39:26 -0700 (PDT)
Received: from Ubuntu.. ([117.96.151.20])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7cf1db4sm9950895ad.87.2024.07.25.02.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:39:26 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v6 0/7] t: port reftable/pq_test.c to the unit testing framework
Date: Thu, 25 Jul 2024 14:55:52 +0530
Message-ID: <20240725093855.4201-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240723143032.4261-1-chandrapratap3519@gmail.com>
References: <20240723143032.4261-1-chandrapratap3519@gmail.com>
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
Changes in v6:
- Use modulo loop to pseudo-randomly insert elements in
  t_pq_index() in patch 6.
- Use 'xstrfmt' for refnames instead of using a 'strbuf'
  in t_pq_record() in patch 6.
- Use string literals instead of 'xstrdup' for refnames in
  t_pq_index() and t_merged_iter_pqueue_top() in patch 6 & 7.
- Use modulo loop to pseudo-randomly insert elements in
  t_merged_iter_pqueue_top() in patch 7

CI/PR for v6: https://github.com/gitgitgadget/git/pull/1745

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
t/unit-tests/t-reftable-pq.c | 154 +++++++++++++++++++++++++++++++++++++++++++
7 files changed, 165 insertions(+), 97 deletions(-)

Range-diff against v5:
1:  94a77f5a60 ! 1:  f5c30187e1 t-reftable-pq: add test for index based comparison
    @@ Commit message
         index-based comparison as well. Rename the existing test to
         reflect its nature of only testing record-based comparison.

    +    While at it, replace 'strbuf_detach' with 'xstrfmt' to assign
    +    refnames in the existing test. This makes the test conciser.
    +
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
    @@ t/unit-tests/t-reftable-pq.c: static void merged_iter_pqueue_check(const struct
      {
      	struct merged_iter_pqueue pq = { 0 };
      	struct reftable_record recs[54];
    +@@ t/unit-tests/t-reftable-pq.c: static void t_pq(void)
    + 	char *last = NULL;
    +
    + 	for (i = 0; i < N; i++) {
    +-		struct strbuf refname = STRBUF_INIT;
    +-		strbuf_addf(&refname, "%02"PRIuMAX, (uintmax_t)i);
    +-
    + 		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
    +-		recs[i].u.ref.refname = strbuf_detach(&refname, NULL);
    ++		recs[i].u.ref.refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
    + 	}
    +
    + 	i = 1;
     @@ t/unit-tests/t-reftable-pq.c: static void t_pq(void)
      	merged_iter_pqueue_release(&pq);
      }
    @@ t/unit-tests/t-reftable-pq.c: static void t_pq(void)
     +static void t_pq_index(void)
     +{
     +	struct merged_iter_pqueue pq = { 0 };
    -+	struct reftable_record recs[14];
    ++	struct reftable_record recs[13];
     +	char *last = NULL;
     +	size_t N = ARRAY_SIZE(recs), i;
     +
     +	for (i = 0; i < N; i++) {
     +		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
    -+		recs[i].u.ref.refname = xstrdup("refs/heads/master");
    ++		recs[i].u.ref.refname = (char *) "refs/heads/master";
     +	}
     +
    -+	for (i = 0; i < N; i++) {
    ++	i = 1;
    ++	do {
     +		struct pq_entry e = {
     +			.rec = &recs[i],
     +			.index = i,
    @@ t/unit-tests/t-reftable-pq.c: static void t_pq(void)
     +
     +		merged_iter_pqueue_add(&pq, &e);
     +		merged_iter_pqueue_check(&pq);
    ++		i = (i * 7) % N;
     +	}
    ++	while (i != 1);
     +
    -+	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
    ++	for (i = N - 1; i > 0; i--) {
     +		struct pq_entry e = merged_iter_pqueue_remove(&pq);
     +		merged_iter_pqueue_check(&pq);
     +
    @@ t/unit-tests/t-reftable-pq.c: static void t_pq(void)
     +		last = e.rec->u.ref.refname;
     +	}
     +
    -+	for (i = 0; i < N; i++)
    -+		reftable_record_release(&recs[i]);
     +	merged_iter_pqueue_release(&pq);
     +}
     +
2:  9a76f87bd1 ! 2:  394540a789 t-reftable-pq: add tests for merged_iter_pqueue_top()
    @@ t/unit-tests/t-reftable-pq.c: static void t_pq_record(void)
      		if (last)
      			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
     @@ t/unit-tests/t-reftable-pq.c: static void t_pq_index(void)
    - 	}
    + 	while (i != 1);

    - 	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
    + 	for (i = N - 1; i > 0; i--) {
     +		struct pq_entry top = merged_iter_pqueue_top(pq);
      		struct pq_entry e = merged_iter_pqueue_remove(&pq);
      		merged_iter_pqueue_check(&pq);
    @@ t/unit-tests/t-reftable-pq.c: static void t_pq_index(void)
     +static void t_merged_iter_pqueue_top(void)
     +{
     +	struct merged_iter_pqueue pq = { 0 };
    -+	struct reftable_record recs[14];
    ++	struct reftable_record recs[13];
     +	size_t N = ARRAY_SIZE(recs), i;
     +
     +	for (i = 0; i < N; i++) {
     +		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
    -+		recs[i].u.ref.refname = xstrdup("refs/heads/master");
    ++		recs[i].u.ref.refname = (char *) "refs/heads/master";
     +	}
     +
    -+	for (i = 0; i < N; i++) {
    ++	i = 1;
    ++	do {
     +		struct pq_entry e = {
     +			.rec = &recs[i],
     +			.index = i,
    @@ t/unit-tests/t-reftable-pq.c: static void t_pq_index(void)
     +
     +		merged_iter_pqueue_add(&pq, &e);
     +		merged_iter_pqueue_check(&pq);
    ++		i = (i * 7) % N;
     +	}
    ++	while (i != 1);
     +
    -+	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
    ++	for (i = N - 1; i > 0; i--) {
     +		struct pq_entry top = merged_iter_pqueue_top(pq);
     +		struct pq_entry e = merged_iter_pqueue_remove(&pq);
     +
    @@ t/unit-tests/t-reftable-pq.c: static void t_pq_index(void)
     +		}
     +	}
     +
    -+	for (i = 0; i < N; i++)
    -+		reftable_record_release(&recs[i]);
     +	merged_iter_pqueue_release(&pq);
     +}
     +

