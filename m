Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81414290
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094768; cv=none; b=OSbrgHJrEfHfLfYCqQE6hTWXBWdnkrOpsUosjabuEspswinnd4CkCImxMaMcTGJBOW77dhAgynqTcAAFO0llLqZrnNor8WVmgM6AVaGJq7GLPelGAyoD3UCuq4XFDw2XOzEa5FdXVJYGd1vNmivYFuSI1cfBidyZgSDy7l4GwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094768; c=relaxed/simple;
	bh=BXdBFo8OYNAmSQT6EtRuyIhNBVfx7z8ZLLjtViJ9lTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMz9VoHpcSKZc7CHWHYenSEVjqcF/35O9/qetPfsQK0sLiyMK2N0ntvAGz7/Z0UUKquBzwa6b4GJ5ZloHICRG+ssGK8fSaL+LU72/OYQIMPF7pnm8rqcCNSe6pH2/0loueK7ETv5+PeP0MaGnSw5dadvo/tiql6GUeLxtokMhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0J9uD8L; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0J9uD8L"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7041ed475acso2608076b3a.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 01:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718094766; x=1718699566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZdd+po+9LZIhRytKg6xeyVieG2Q0etKa8kgWOGnbpI=;
        b=l0J9uD8LkZ0+C2adE1wJHmKERNHr6jp1hMvmaGUb/BaHt+JewYdgj1ii4qKCJZ4FLt
         T/Y8jeLIPwxHmRt3tYI2alaF6Ya7l6mozR9K13z1YxZTg14x20tzGcl92gSiJa8EMHZM
         tbQH1DLv4j/m1ntHn7MG2dKPKAqXUQ9245A6IQx7PPhpKY+T0Jt4z6DcN5mHq+V+NeBw
         uO+Ua9SfNpZLmSk9FguePDRwDDs2UOBofR/kCnqI/8e7Pk00W2oBj4wKa/xMwQa3nOtM
         zR21EOEoB8hNL7ww7EWN8iBoNX1R5p5f9VWOXOEI3MsGkiygB1fTJhXoyICYSLtLE5nL
         8ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094766; x=1718699566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZdd+po+9LZIhRytKg6xeyVieG2Q0etKa8kgWOGnbpI=;
        b=LjN/VGpb57x5+wqeaTNyDLlKWW+ykK/xp88JvzT4Lqcc/9UTxR8yWLAdbVh2mvAr6j
         Xk7I9p/9l4mzRuHPchNeMNIB/Bv1JYgkTMNau7Xmr4sh51t18YP6xxxzifj1DskSEBL/
         jdlFvBeufnBspsZdbPfAFv9mWGcISAwwyGAcDG3Cy3JqGis5L2EXcBaOp99bFoT82c0t
         JWtdZvMCNRTkGWfhHwD+7HC+Aiq2vF6r7GOFanKFrk7MqZWT75rdomdJNQQV0Vg3OM1l
         7AYHPsLrQO8XGwkpSaFJFe4mwCP0Q69Ad6FxHBODNXzA45onlH1ysuJB3ngkficoAO+f
         ELwQ==
X-Gm-Message-State: AOJu0YztVQQoDquXpIDUUMoR4mAA+uhAUcbKmYAisS6jnIE1cKK2UTWM
	LrSQdw3VHHZPK6vSKVdmU+RkTCVTX4NL0AJqh0UN7TowAss9fp/ICMLyrg==
X-Google-Smtp-Source: AGHT+IGFv2U0WlUUUHcea413Xx1S0aDso6D/xPik5VoVe5+aPHn5r/O8ESJ1n1qhY9I19skC/4kd4g==
X-Received: by 2002:a05:6a20:1592:b0:1b6:15b2:822 with SMTP id adf61e73a8af0-1b615b20ad6mr6852342637.27.1718094765788;
        Tue, 11 Jun 2024 01:32:45 -0700 (PDT)
Received: from Ubuntu.. ([106.206.199.126])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7041cff68d0sm5776170b3a.185.2024.06.11.01.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:32:45 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v3 0/7] t: port reftable/pq_test.c to the unit testing framework
Date: Tue, 11 Jun 2024 13:49:17 +0530
Message-ID: <20240611083157.9876-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240606154712.15935-1-chandrapratap3519@gmail.com>
References: <20240606154712.15935-1-chandrapratap3519@gmail.com>
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

The first two patches in the series are preparatory cleanup, the third patch
moves the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v3:
- Add another cleanup patch for reftable/pq.c
- Change the commit title of the first patch
- Re-introduce a lost newline in the first patch

CI/PR for v3: https://github.com/gitgitgadget/git/pull/1745

Chandra Pratap(7):
reftable: remove unncessary curly braces in reftable/pq.c
reftable: change the type of array indices to 'size_t' in
t: move reftable/pq_test.c to the unit testing framework
t-reftable-pq: make merged_iter_pqueue_check() static
t-reftable-pq: make merged_iter_pqueue_check() callable
t-reftable-pq: add test for index based comparison
t-reftable-pq: add tests for merged_iter_pqueue_top()

Makefile                     |   2 +-
reftable/pq.c                |  29 +++--------
reftable/pq.h                |   1 -
reftable/pq_test.c           |  74 ----------------------------
t/helper/test-reftable.c     |   1 -
t/unit-tests/t-reftable-pq.c | 155 +++++++++++++++++++++++++++++++++++++++++++++
6 files changed, 166 insertions(+), 96 deletions(-)

Range-diff against v2:
1:  9ac1035c07 ! 1:  d3c5605ea2 reftable: clean up reftable/pq.c
    @@ Metadata
     Author: Chandra Pratap <chandrapratap3519@gmail.com>
     
      ## Commit message ##
    -    reftable: clean up reftable/pq.c
    +    reftable: remove unncessary curly braces in reftable/pq.c
     
         According to Documentation/CodingGuidelines, control-flow statements
         with a single line as their body must omit curly braces. Make
    @@ reftable/pq.c: struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pque
      		SWAP(pq->heap[i], pq->heap[min]);
      		i = min;
      	}
    -@@ reftable/pq.c: struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
    - void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)
    - {
    - 	int i = 0;
    --
    - 	REFTABLE_ALLOC_GROW(pq->heap, pq->len + 1, pq->cap);
    - 	pq->heap[pq->len++] = *e;
    - 
    +@@ reftable/pq.c: void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry
      	i = pq->len - 1;
      	while (i > 0) {
      		int j = (i - 1) / 2;
-:  ---------- > 2:  1873fb02ce reftable: change the type of array indices to 'size_t' in reftable/pq.c
2:  f24dc84877 = 3:  3cccf8266a t: move reftable/pq_test.c to the unit testing framework
3:  ce42fd1288 = 4:  4b63849694 t-reftable-pq: make merged_iter_pqueue_check() static
4:  226d72aa6a = 5:  3698a7189f t-reftable-pq: make merged_iter_pqueue_check() callable by reference
5:  00cb440f11 = 6:  d58c8f709e t-reftable-pq: add test for index based comparison
6:  dd44486c28 = 7:  69521f0ff7 t-reftable-pq: add tests for merged_iter_pqueue_top()

