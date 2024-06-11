Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF95175571
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094782; cv=none; b=Emjf4utb8S3iW3HVi+V5SuwqZ5vE4aOTi7MTk0+8e0QfWXwT3nmoNaXmrpiZf3rP0xuWoOsBN8NM6GQz+Yw86kC61l0YAEN1LPANNa3mx7AuXI0uGrq/igJTA9KA/ZQC/4Hl9fHJ2fnipSVtNE68wvIgsx3MwbnuljQnC5xI4cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094782; c=relaxed/simple;
	bh=L2kOQvVmitR9fKv557cUouCHnCFAU5dqKoO9TVT+NHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8VYM8SY0hmxgVfeoHnTFhsq4WisRqXAHF7b6BpXIfrx8epKFDoE1Gk7FW0UUOb9wl1F6MgrXOn5rFwuNSxUTGrvhF6DBGOqZpqyxrG+i8rgRi5AkVUH8RiHEpABBFtmVnehzJhynA/paqVUuzw9/Tatp1I03fnNMi+7vWYWGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDAYXEpr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDAYXEpr"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ff6fe215c6so4644589b3a.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 01:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718094780; x=1718699580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w84840wpWTiEFCwuNJLf+jbnu/yNvhoCiinN3sTzrPY=;
        b=aDAYXEprgtT626z4XDQ8666uWGqu1R8NQAiTBno4O/EhNNqX3Pr9ZLUY+OAeOri8pa
         2ig4jY2vS609G6XwAnCwVnHuQR1o/CVokw0X/Fmc4t2Gfc6aZPHpDDdJA9+lrK6iRisX
         D7E4PxPcusSBtjLEDTsz+sE+2rospuRP3fHlbFh7JNl6oMBKlvEV7PJuWfAYYMe3JZUW
         EEVpE0SyjJLcD75RDGIgKGn8usoqdmZuCk22lfNy1QgrZcFi6Ny6xXs1lriRLIOSqvx9
         oKWTrtFOePpJFMLziun3UcOtvDWVofee1pbwsofDH0QJb7BcTpVfw1h53AqZnh9UMT+e
         cVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094780; x=1718699580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w84840wpWTiEFCwuNJLf+jbnu/yNvhoCiinN3sTzrPY=;
        b=MeSRgiRZ0vhtV631lI5RR9nD7tLAnuZMyBYp5tg5ldklyx+CXxMRasq/zZTE/S2T+D
         GFxnnfi+G/OZpp5anJK9EXGjS7a7DfolM9YqVUBLwUNTWtavsSY2NpHz5NfDOztrfyF/
         BR012S7Qq+bSO1sYv5A63HJEwziSjS21vGsReq7z8gvSOwp3skToNTLuNai0IqbsyrqQ
         F0+TDgOaOv1jicwYb0Fa9JdmwKN9sSHRYH1NAB2BaJdi+uD6sZUwn2JmIPqsM1dFxIFp
         NewRn3Bj4upVvAqvO75gyfrofAIS1FMK5nlPKfPphH/8YY8V6JCxYLrkCxeuWGC1K2Rf
         Q/sg==
X-Gm-Message-State: AOJu0Yyu+TivnBmGTiZDKb0ypwE5mlntG7XcR9wwI4RL7X+YSJU7OtyN
	GrtekHeD0j1uH7s7dwPZPhN4aU3+jO2Pw0cKe6j3/B4fnGCKpjgK3S4j4A==
X-Google-Smtp-Source: AGHT+IE1wNCG5YxQeLSKFYFixcI4KC/GgbvLf5tFT+Sw1kfsMHFnSlcibVr4A+84i11goZCEa4Kehw==
X-Received: by 2002:a05:6a20:7483:b0:1b7:bdb3:7bc0 with SMTP id adf61e73a8af0-1b7bdb3848amr5389865637.44.1718094779882;
        Tue, 11 Jun 2024 01:32:59 -0700 (PDT)
Received: from Ubuntu.. ([106.206.199.126])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7041cff68d0sm5776170b3a.185.2024.06.11.01.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:32:59 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/7] t-reftable-pq: make merged_iter_pqueue_check() callable by reference
Date: Tue, 11 Jun 2024 13:49:22 +0530
Message-ID: <20240611083157.9876-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240611083157.9876-1-chandrapratap3519@gmail.com>
References: <20240606154712.15935-1-chandrapratap3519@gmail.com>
 <20240611083157.9876-1-chandrapratap3519@gmail.com>
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

