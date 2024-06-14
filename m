Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D519A29F
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358738; cv=none; b=W0BecXQCq+P7Q9l003gHtTkPKtT/V+jpBZTJ3mzdp6/FRpbpd4KzECjIDnPTNt9WUjMHO9arBbPCXzQ1bBk08LOa7ZYtK/BUhR5h4bwSmzWA0H112sTRbygZ1ipI5K2SUU0v3eU+FHyXqhaafxvhB+h0TyDaF7ZJKPTszLVCgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358738; c=relaxed/simple;
	bh=L2kOQvVmitR9fKv557cUouCHnCFAU5dqKoO9TVT+NHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN+LQmGjFyr9f0QO56u4um1+DnwKEkALLq0YiqryK/8bX+p3bE/WGLF+0g94om9NJdvWjhKAJNyLaYPus7ycESq08oapFQU2bao8lzSuzNJVH+P/FGKwdGgHy7N4tFj17qN/nQ5dBm3gDPOf5JVdwvXfzxA+McHNDTjjXe3H5Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPpl1Iji; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPpl1Iji"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f717b3f2d8so22192565ad.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 02:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718358736; x=1718963536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w84840wpWTiEFCwuNJLf+jbnu/yNvhoCiinN3sTzrPY=;
        b=IPpl1IjiCe6vkUqUHE4f/HtTJQiXEePqmoMqs3ov25CxTH3Dzq01UNVLvLoybgA1VP
         HG2q+vo8pznjRyMHtug1SFxOB7KjLG9WeXwAc3BW/d7ZvmuM6KLu1mmM78mKWJTx7bOm
         AItC1Iz48WEiSWNmyqxLSo1oaXsnILdaEGnjOphyTt09zMEOF9TvmiTJu4MeTXFCsXNB
         YQWhXpTLYev7pULSiFRDl6PyHy/OH0RjGT8qWBbQplpJtYtY0a8Lixuqgulemdt/30QR
         ENns7Cu961SNwo7aVEQnZ3P+2IgAB+gnCbbKle6owd5+79h/H2QgffjESMyvkx4tZiJH
         3FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358736; x=1718963536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w84840wpWTiEFCwuNJLf+jbnu/yNvhoCiinN3sTzrPY=;
        b=R+fd8Q0nIwsSEWDAkq4rUKzQEXKxgQKP0zA4Wp5AkrDdwgZuiV91CI6xBoGE8DZdND
         kckydS8h1sW65MUiHr+omNsAXMf8239Rsl6BG8MID0T0Nxok5s+8plnolDjsBXBrbkr0
         tvDfNIqBUuy3ssaPSk27CEtNEYOxBYBnKrGgJwlQle+oGc79n392n5BLXpZ552gPm/if
         abelikTEf+xclkbbQ8gPHwr52jIg13HX66Sj6uPTiICWCFB0TFmYl4bErRRJw2Y7Bl5M
         l1IMbwiFzs7FIlXmNFVXGUFLtBbcdEIQ3IuKbo8bqc76WI7xtuC8B3QXutjMi23amrCC
         lNRQ==
X-Gm-Message-State: AOJu0Ywb1e5R521Lh75gr0pLUOJ8rt+iW7l1oqDLrH9n3ctKDeyh5PqK
	QSu4pUoHWTKyFaBJYmo5p3vHLK9uW1kgFkEPfv9c0gQmcMZNMsDqMfWZ5dQxzfA=
X-Google-Smtp-Source: AGHT+IGXgCiRmOIrOwxusqUIxJ0VHOmzXLmN3ll02GrgNI0IUtUuJoVAl3BbbZAgrGFSNVm2dsSjbw==
X-Received: by 2002:a17:903:187:b0:1f6:521a:ba30 with SMTP id d9443c01a7336-1f84e1d315emr84956955ad.15.1718358735796;
        Fri, 14 Jun 2024 02:52:15 -0700 (PDT)
Received: from Ubuntu.. ([117.96.146.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f868b83afesm9230005ad.156.2024.06.14.02.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:52:15 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 5/7] t-reftable-pq: make merged_iter_pqueue_check() callable by reference
Date: Fri, 14 Jun 2024 15:18:05 +0530
Message-ID: <20240614095136.12052-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240614095136.12052-1-chandrapratap3519@gmail.com>
References: <20240611083157.9876-1-chandrapratap3519@gmail.com>
 <20240614095136.12052-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

merged_iter_pqueue_check() checks the validity of a priority queue
represented by a merged_iter_pqueue struct by asserting the
parent-child relation in the struct's heap. Explicity passing a
struct to this function means a copy of the entire struct is created,
which is inefficient.

Make the function accept a pointer to the struct instead. This is
safe to do since the function doesn't modify the struct in any way.
Make the function parameter 'const' to assert immutability.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-pq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index 7d151f8582..774c4194e5 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -10,11 +10,11 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/pq.h"
 
-static void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 {
-	for (size_t i = 1; i < pq.len; i++) {
+	for (size_t i = 1; i < pq->len; i++) {
 		size_t parent = (i - 1) / 2;
-		check(pq_less(&pq.heap[parent], &pq.heap[i]));
+		check(pq_less(&pq->heap[parent], &pq->heap[i]));
 	}
 }
 
@@ -40,13 +40,13 @@ static void test_pq(void)
 		};
 
 		merged_iter_pqueue_add(&pq, &e);
-		merged_iter_pqueue_check(pq);
+		merged_iter_pqueue_check(&pq);
 		i = (i * 7) % N;
 	} while (i != 1);
 
 	while (!merged_iter_pqueue_is_empty(pq)) {
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
-		merged_iter_pqueue_check(pq);
+		merged_iter_pqueue_check(&pq);
 
 		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
 		if (last)
-- 
2.45.2.404.g9eaef5822c

