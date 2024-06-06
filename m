Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B4196D9C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688896; cv=none; b=gLgqL8yT1rIJO2TLcLZ2J+SiIALzI3Zr/+LHIUDvi1fbOO1ux7s7/f3UXYMoYn3iwrqNcj/oqc23NILRzA/LbJKYxx3JZSCj1GKCnhWR+HV7mK//TKRNSyt8SmI+nfQ2j81CFotbUp7qSBf1gVol1SeHeCXpQr80m7ZPgnmqHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688896; c=relaxed/simple;
	bh=VqvpYY+jW7J8HU58iDvCTfoXAJ65Sh2kwwjL05W97T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFcpcZBMVbEoiAa1/rZVgTF/254pLw4hcnzsP8VQDGWyEhkPQ3cEB9C4CIG6ZU8KG+mm+G12RA7N9gkasxPvWFKqa3Y+8OvKZHxrroGQ85akNuI5xkwAVBBRIRv4sXQoDg3th7isz14NBwQBwfuvyG0wGr0SFuf3IgGWR2UlDwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIhbKCdI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIhbKCdI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6262c0a22so16205025ad.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717688894; x=1718293694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uX1mQRgTcUh7CnIHidqNhIizX0jjIwDKyqOb+1/3Ew=;
        b=WIhbKCdIUv/2gFX0p0p8/La7tcK4RK3YO0DLxvZebQkDGbUrjKAVD5UazeYYJWk6Ey
         JKsK3QSmzrIYQbXg3JAfSP6wgd9LlpBUv7Wf+Uqjio2Ms9tPJ8Yjb4f3ZRrzhXoViawa
         7PaNLb++8moZ9Ilyfa45nMZMojOxI1GBwHUb+3kTiTp4iFbeVsIwMSe+kwLZ8B6kbM+j
         uZuPlXasBJp3pfVDMuwOr18ZhmkxJ8WEQwJWJ8s7h7ABIZ0qHKWwoLJKuVYh3aoF0QwC
         sEjJQI85s+pIKc2LQhaMcfmnBawAIslCqHRt9Sfv5UgTMk3lOEeHmF3cpfRiaqiZNqbi
         4GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688894; x=1718293694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uX1mQRgTcUh7CnIHidqNhIizX0jjIwDKyqOb+1/3Ew=;
        b=Dm9AyYflxxIgva/esenfhhah/7o0pD/3juXsUe6jUsB2p1hft8Hmp0WiNjQT5iLz7j
         af9lO7mf7Ao+0HSrov6CXlmV5o1Ne+VhFUDB36uwbPIPXtAahZLdRmkl+sCih3q1yyYK
         5ETdt9q1ZsmFhO3xlZd5/+spCxRs4R043ji+JgBvX73W0RHDejCE360inOpIKCzJEKfx
         ifkj4oFv7RLpPIIf70EIKU8iT07OldGsYTnko4H/mTKwX6jj97JgFaTTJMIj+wT057v5
         FM6pn3apASExsgLGxG5Lw3BO/NMyZcYczV3f+xGkPZXL6W3kTdDkZS2bf2CNAYSjptbL
         Z+fA==
X-Gm-Message-State: AOJu0YyCYanPPgs9TyOPAIyhPS4cefxi/GOgzAOhJW+hpERjWiHVpcod
	7RLft22V32C1kSBW4LZUCnv95VkWSEyI9ae2L3g+fBp4POHlIDUU3XvdXOMHjq0=
X-Google-Smtp-Source: AGHT+IHkkvuD/UCJgKXxiOf3VC5Sb+vibAEIhXznXRkNbpCOxQVrnLYbNZgbgNH0G/1U5d/GCZJ/eA==
X-Received: by 2002:a17:903:1d1:b0:1f6:3580:65c9 with SMTP id d9443c01a7336-1f6d019ef6fmr784155ad.26.1717688893481;
        Thu, 06 Jun 2024 08:48:13 -0700 (PDT)
Received: from Ubuntu.. ([223.176.20.76])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd76fa8fsm16937405ad.100.2024.06.06.08.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:48:13 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v2 0/6] t: port reftable/pq_test.c to the unit testing
Date: Thu,  6 Jun 2024 20:53:36 +0530
Message-ID: <20240606154712.15935-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240606075601.6989-1-chandrapratap3519@gmail.com>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
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
reftable/pq_test.c to the unit testing framework and improve upon
the ported test.

The first patch in the series is preparatory cleanup, the second patch
moves the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v2:
- Change data type of index variable 'i' to 'size_t' from 'int'
- Use correct format specifier for 'size_t' types
- Improve the test for merged_iter_pqueue_top() by asserting equality
  between 'top.rec' and the corresponding record in 'recs' array

CI/PR for v2: https://github.com/gitgitgadget/git/pull/1745

Chandra Pratap (6):
reftable: clean up reftable/pq.c
t: move reftable/pq_test.c to the unit testing framework
t-reftable-pq: make merged_iter_pqueue_check() static
t-reftable-pq: make merged_iter_pqueue_check() callable
t-reftable-pq: add test for index based comparison
t-reftable-pq: add tests for merged_iter_pqueue_top()

Makefile                     |   2 +-
reftable/pq.c                |  18 +++--------
reftable/pq.h                |   1 -
reftable/pq_test.c           |  74 ----------------------------
t/helper/test-reftable.c     |   1 -
t/unit-tests/t-reftable-pq.c | 155 +++++++++++++++++++++++++++++++++++++++++++++
6 files changed, 160 insertions(+), 91 deletions(-)


Range-diff against v1:
1:  f18b610f63 ! 1:  f24dc84877 t: move reftable/pq_test.c to the unit testing framework
    @@ t/unit-tests/t-reftable-pq.c: license that can be found in the LICENSE file or a
      {
     -	int i;
     -	for (i = 1; i < pq.len; i++) {
    -+	for (int i = 1; i < pq.len; i++) {
    - 		int parent = (i - 1) / 2;
    +-		int parent = (i - 1) / 2;
     -
     -		EXPECT(pq_less(&pq.heap[parent], &pq.heap[i]));
    ++	for (size_t i = 1; i < pq.len; i++) {
    ++		size_t parent = (i - 1) / 2;
     +		check(pq_less(&pq.heap[parent], &pq.heap[i]));
      	}
      }
    @@ t/unit-tests/t-reftable-pq.c: license that can be found in the LICENSE file or a
      	for (i = 0; i < N; i++) {
      		struct strbuf refname = STRBUF_INIT;
     -		strbuf_addf(&refname, "%02d", i);
    -+		strbuf_addf(&refname, "%02ld", (long)i);
    ++		strbuf_addf(&refname, "%02"PRIuMAX, (uintmax_t)i);

      		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
      		recs[i].u.ref.refname = strbuf_detach(&refname, NULL);
2:  798e0adfeb ! 2:  ce42fd1288 t-reftable-pq: make merged_iter_pqueue_check() static
    @@ t/unit-tests/t-reftable-pq.c: license that can be found in the LICENSE file or a
     -void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
     +static void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
      {
    - 	for (int i = 1; i < pq.len; i++) {
    - 		int parent = (i - 1) / 2;
    + 	for (size_t i = 1; i < pq.len; i++) {
    + 		size_t parent = (i - 1) / 2;
3:  8412672105 ! 3:  226d72aa6a t-reftable-pq: make merged_iter_pqueue_check() callable by reference
    @@ t/unit-tests/t-reftable-pq.c: license that can be found in the LICENSE file or a
     -static void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
     +static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
      {
    --	for (int i = 1; i < pq.len; i++) {
    -+	for (int i = 1; i < pq->len; i++) {
    - 		int parent = (i - 1) / 2;
    +-	for (size_t i = 1; i < pq.len; i++) {
    ++	for (size_t i = 1; i < pq->len; i++) {
    + 		size_t parent = (i - 1) / 2;
     -		check(pq_less(&pq.heap[parent], &pq.heap[i]));
     +		check(pq_less(&pq->heap[parent], &pq->heap[i]));
      	}
4:  2ef5b8b0b1 ! 4:  00cb440f11 t-reftable-pq: add test for index based comparison
    @@ t/unit-tests/t-reftable-pq.c: static void test_pq(void)
      	merged_iter_pqueue_release(&pq);
      }

    -+
     +static void test_pq_index(void)
     +{
     +	struct merged_iter_pqueue pq = { 0 };
5:  838e67d2a3 ! 5:  dd44486c28 t-reftable-pq: add tests for merged_iter_pqueue_top()
    @@ t/unit-tests/t-reftable-pq.c: static void test_pq_record(void)
      		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
      		if (last)
      			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
    -@@ t/unit-tests/t-reftable-pq.c: static void test_pq_record(void)
    - 	merged_iter_pqueue_release(&pq);
    - }
    -
    --
    - static void test_pq_index(void)
    - {
    - 	struct merged_iter_pqueue pq = { 0 };
     @@ t/unit-tests/t-reftable-pq.c: static void test_pq_index(void)
      	}

    @@ t/unit-tests/t-reftable-pq.c: static void test_pq_index(void)
     +		merged_iter_pqueue_check(&pq);
     +	}
     +
    -+	while (!merged_iter_pqueue_is_empty(pq)) {
    ++	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
     +		struct pq_entry top = merged_iter_pqueue_top(pq);
     +		struct pq_entry e = merged_iter_pqueue_remove(&pq);
     +
     +		merged_iter_pqueue_check(&pq);
     +		check(pq_entry_equal(&top, &e));
    -+		for (i = 0; i < pq.len; i++) {
    -+			check(pq_less(&top, &pq.heap[i]));
    -+			check_int(top.index, >, i);
    ++		check(reftable_record_equal(top.rec, &recs[i], GIT_SHA1_RAWSZ));
    ++		for (size_t j = 0; i < pq.len; j++) {
    ++			check(pq_less(&top, &pq.heap[j]));
    ++			check_int(top.index, >, j);
     +		}
     +	}
     +
