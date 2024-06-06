Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52574197A7A
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688911; cv=none; b=QYB5GBGIXJvRP/FiU8v6qiLR+i22kBvsCx5b2t0iMI6h1604AY8N1V0mzc3FXdb97ZVtoCUK9ZPeTH6dkU5srYpDafCuzdQJb0wlBOiJMxPUZIq1RT2C+D0A3uwkqvnuTvOHTkPZNEHpUq2qUuxK2+8K2VWfWflr6b05qGQg1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688911; c=relaxed/simple;
	bh=L2kOQvVmitR9fKv557cUouCHnCFAU5dqKoO9TVT+NHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tF1jyHAl/RBTrGO+qaRpz8GTbcDpY4brKGwOVtWpMeI93tMDQwFRvVVFw5c5VaIoqrm9CMd6cYCmze4OVl3kCI9jexG8H0d9KJklKjIj+q2dS09QicnbZxJUPLE6eJIsz6RH/kUIYJS0LTHlfJLCyZswWIwask88hIdNYzOhk5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkNTYpOA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkNTYpOA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f62217f806so10816655ad.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717688909; x=1718293709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w84840wpWTiEFCwuNJLf+jbnu/yNvhoCiinN3sTzrPY=;
        b=RkNTYpOAFHo8MWAuNPSHr76BFCANBrqkwDuhZc4snoHKWHIQUfhMBaImeAXTWZw1ME
         N+pppJlUSTsxsOZe1fZN8zNaZw0aG5KwSKusDespN9z1K81l6QewHy9D2a1kBNYuUtkm
         9KipYw7bru9RDhKTL7j20au9z1SS/+TSi1mmiShAARXwCBEUYlmnZQsQ47hUI+1vBUaX
         MnNXCbVfaL2Zh9YvIPM5MUFqi+6SUxuTXQB2YLzTe3mjYjo3DJLz+rO2aE50dUQDm89Y
         klDyRmFBmtgGb19nuIwo9awpwgKL59Dlp3tcUXnlFK5kyqNJg3hKCWplszfwtgSQUGXn
         tDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688909; x=1718293709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w84840wpWTiEFCwuNJLf+jbnu/yNvhoCiinN3sTzrPY=;
        b=juh7N4zuHDbGLpoED1R9uN+N6npJmeREi1wLd/PPRWLzC37ovOqxnpH8qPe2w19Llr
         DHHtLSgrpskWgpptOu3flOSstW1TlGFKVimKuXj6Yyi5ZLUtTJqV0GML5qHOCoNP60i1
         IdpfEF3fuPRDNGPdKlGFOmVKEC6Y2qd9c6qxM+U6tMA8ExmGMgaA39pbXNWiwX/dOvya
         fbb56RTsfxqachsCZlcoiGMukWMH9dgsGqbvDCtu+OaN0abEKfG22scbhG7ztz8Tv4HB
         BCQwyB2CSl0ue2wQK3MBy/skRVl1jac5FcBMwMD+50kHNR4E11uHb2D0a/76nHf2nUpz
         J4fA==
X-Gm-Message-State: AOJu0YwEHU/BsfKMnE5Zm1FjR2/+J5r6CJec2etXmteHV/K4ycMQTc18
	4HwObhMbIf/ZGgjWt3HbR6mUZuxWxem20Buh8q++q49iOJxdxPQqMIZEN0EiEn8=
X-Google-Smtp-Source: AGHT+IFL/4CiGdq6dX0VgIvFqeQx3fZoRa3DhehUhjSoUOEEOx13nO41B7B2lkss7Lux7h3qTUZ7qA==
X-Received: by 2002:a17:902:ce91:b0:1f4:b9d3:adce with SMTP id d9443c01a7336-1f6d02dd8cbmr180425ad.27.1717688909292;
        Thu, 06 Jun 2024 08:48:29 -0700 (PDT)
Received: from Ubuntu.. ([223.176.20.76])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd76fa8fsm16937405ad.100.2024.06.06.08.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:48:29 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v2 4/6] t-reftable-pq: make merged_iter_pqueue_check() callable by reference
Date: Thu,  6 Jun 2024 20:53:40 +0530
Message-ID: <20240606154712.15935-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240606154712.15935-1-chandrapratap3519@gmail.com>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
 <20240606154712.15935-1-chandrapratap3519@gmail.com>
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

