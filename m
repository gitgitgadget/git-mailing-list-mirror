Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1CF13BC35
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660645; cv=none; b=ehN4HyvaJO5g8NwSuJe0Chj1FxtAsc0nXLjVcfQGR0d23N1j37bGpc7H24uZ17Oh1YfBqYWtb+KxNI1XJyVe9o+bLjRsMvT6CB07G48bW/4CJXcR83jColnq3uKGqpz6TNICWVh2sktilpuhNMV9weuyUl4XZCVrpH9JYEPB0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660645; c=relaxed/simple;
	bh=D9nQ2fEUIFfTJnU7qIz1ApVrJNrk/Bf8EA+KDXb9HEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9yxAteUUgg1rJJUCZ9ed+3ut6t6bOb8yhTEl/NXXQpe3gyoBham8oNGlz7WkNGUBTdRMXmOIrGf2c2LrC6C4RS022ZtfOnpO3Vbg3rcT1on5RD70wM3hOxsvbNiaSGMI1Sbo6/56Y+Q/V/0QEorQdCF8gGISnjtzI/ukzUdYOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHTtadfA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHTtadfA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6c7cdec83so178455ad.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717660643; x=1718265443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QenudIcxVUzKolxgrGVwZKl4XyKKumgzlhfspZL21Ns=;
        b=WHTtadfAhh7LsQzMcTuaP/h6dJ/1vRPeZIN4FJrW8uWzQSoDIUWg+OM3dr4F+b0e5N
         2QyZuxfFHphFoAgk0VFcn7dh/VWK4syvE+f+3eVeZMcXwk8KSt9FHmK75hJZS94jzVoy
         tnfQ7DxFsjspSFHQvIv8xBhOeqjyjSCW7PMTTIiwRWqer06wNj2oHsAzVhc/jcWtTP0r
         HCuNeZTeLRMX6FpM+eftjBUauO7IVuA/8BIciFyczMJBYuGosad+JRASXdvv2h0/YPv0
         Yfy8FfgQ6NmvniPFQ4o34A9wb2Rx8WZk/r82sFHQc+7QgH3LQMPTZ+knDiW5ZsOCRGPg
         H0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660643; x=1718265443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QenudIcxVUzKolxgrGVwZKl4XyKKumgzlhfspZL21Ns=;
        b=YOBz8uQDkF1jrlZaKQfzHV+0n8YdmjSl4kZDRMDwuewH112orzrBM6GsN+p7xEtH6e
         dpOhh79vueXkmLrqBoBBO00xQJE9eGL8gEg+f+DG8AjJkVuDmrnk9YFcs5S0ICz7XjdD
         DxS+ylGmuowlPEymNyc6rmkcI+hd6PuU0Zvtan+lST/1Bm7eQOYtWD/ua8jrxBSjPJcf
         zE3CZ1FIH1mS7EhtGi7K9KVdMcvZw6dW2tW2YMj3qzks3hw/Wi9+gm1Z4h2lb9fx8vzT
         oXLofiEN+kHnw/RSBaxTi3WFNravMV+uCWg4GH63RgAEL0LJrDfS5ff0Ouet+j92Gcf1
         NJlQ==
X-Gm-Message-State: AOJu0Yzf4k4uSt4pejwVgKOK7HVfgBzkfh6ohHzI3x/OXGb3nS8FluXY
	/zxydSV9bDoQyylE/sXdrkZzgFmPUVl6qR56K5AVlg9mWVBMsxRyvNqA3XiA
X-Google-Smtp-Source: AGHT+IFFw0B8/O49Le+FiS/LqQK1bsfhF5NL6CiI/QQwKHmMIcVOqNmdXbCpd1Kjwj9z14HCuFTkJA==
X-Received: by 2002:a17:902:d2ca:b0:1f6:5013:7842 with SMTP id d9443c01a7336-1f6a5a12932mr61535185ad.27.1717660643518;
        Thu, 06 Jun 2024 00:57:23 -0700 (PDT)
Received: from Ubuntu.. ([27.61.69.112])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7ed6b2sm8192415ad.246.2024.06.06.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:57:23 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH 4/6] t-reftable-pq: make merged_iter_pqueue_check() callable by reference
Date: Thu,  6 Jun 2024 13:10:48 +0530
Message-ID: <20240606075601.6989-5-chandrapratap3519@gmail.com>
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
index 5c5a4ecdc5..30bf9cb492 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -10,11 +10,11 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/pq.h"
 
-static void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 {
-	for (int i = 1; i < pq.len; i++) {
+	for (int i = 1; i < pq->len; i++) {
 		int parent = (i - 1) / 2;
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

