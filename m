Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF7B15351B
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745205; cv=none; b=t3oFapFKJuK/00RuMb77qcmsFi4S06hRpk82YXUx+ll5kEqPVeCzM/qHrERZ60hHQU5RGtYjTx5UvWhuTzVu/zIBXa9FkADszoAX5Io3Ko5TG4WCF+PtDB10N3Gt0i+158w410svkwyMbBphYpYayZqLAKKf68Ym0uL0hEJ3QhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745205; c=relaxed/simple;
	bh=lJ0cXIohnlHeDOyqRbU1Afyp/eEh9NcQnt1UB/p/M8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IR4lRT3c6h4zdccx30ad7aE7Pm4f8RMtgFNQWfYUv/+FpUoCDapKzxkF07RJdmfXgY1Ek6e7KCjrCN/S5lX+3ukMIApCMq2nQtcB1kCf4U64os4vLIywIUJ3MdS9jNviLQJxVWV0T5eCYiQScrsxfC8MwRdJWTqjH8NoHQbFies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxlYofwP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxlYofwP"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc6a017abdso26478095ad.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721745203; x=1722350003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5Wp7fD3+IzmQYf4uzeVp+sx/sYc2G2N5WK5mg2pfmo=;
        b=PxlYofwPWsxVHF43BdMk+rWso/5z4AMXTEcPzJjtw7TysauFUBqFy/hCpaoIYOUpaf
         ZiDVLXVRvyPhJr2jnpqe9YOOCvsqIi+j4h4DLPP2rsSAMCJAXVr3T83UIsjqv/uc507E
         oD3c1pieVAgq0OTC7+q56pN+4GTxrh3P/djXlexkW6f1vMtNBiGRVB5y7oiQxLYDirRQ
         F7Ub+Ap2ncuSCB4sd7sWJMorQHWAc+YPwKsY4hmypzTbSi6PxK+glqUnczuTR6Fkj6l+
         CqOzaS/yYOgPDX28aOLFb4P+1MAwyYkvgtulyArI/wjt6gNegs0mRY2xyqxQArDhXwsI
         5Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745203; x=1722350003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5Wp7fD3+IzmQYf4uzeVp+sx/sYc2G2N5WK5mg2pfmo=;
        b=R2q41+ti2kKyj8Zo+6ZmuppZ9XP7eSKj/QtCfRaDLgSEbPHrP52sPvgv737xUSfOuT
         t9sCKi2x5qvcDzOdXy7CmwzupHoM2jCcyp+UaB+6INFIuQ1pEdXvLJOIVhaoavAv/+fA
         ZPYq+1CgPHr+qNsV/NT8hGXZCbBy22gDu1KIvKwH9lzESCCD3N8HePh/vFAc2YH/enwO
         yS2LtXeRP/U8f/Xczi1eYe7spxZXZZVtSJl4SCbvHssTNfV5kU9JFIBTHM8iLjlCxy7X
         AYS/Kd+wiimz+SjjwoCc59JTII1xmVSboK7M96wfGYxcQTdghWV0LzzBX98MMiph0SjQ
         LjQQ==
X-Gm-Message-State: AOJu0YxFqpgZ2SA+sAhUNnceDJiP9kHbsz7sr3OhffkLMnmokUR/Zl2/
	Sv4/kDAVpBXEk2WlG/0PI7vEFWrlHqR1W3XjjAyn01Fz5mYssxim2PsI8oUbXRQ=
X-Google-Smtp-Source: AGHT+IHUHwY1yePncITm5Z/FaH+lMJ07ksAwnL4eWzNJW1JFpem8vzIzeoYiiNfy47wsa/m74ShfjQ==
X-Received: by 2002:a17:902:ea0d:b0:1fb:1faa:96b7 with SMTP id d9443c01a7336-1fd74573a79mr79400725ad.9.1721745202619;
        Tue, 23 Jul 2024 07:33:22 -0700 (PDT)
Received: from Ubuntu.. ([223.176.63.81])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f256c09sm75301305ad.2.2024.07.23.07.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:33:22 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 5/7] t-reftable-pq: make merged_iter_pqueue_check() callable by reference
Date: Tue, 23 Jul 2024 19:47:15 +0530
Message-ID: <20240723143032.4261-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240723143032.4261-1-chandrapratap3519@gmail.com>
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
 <20240723143032.4261-1-chandrapratap3519@gmail.com>
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
index 220e82be19..9230dd9b9e 100644
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
 
@@ -40,13 +40,13 @@ static void t_pq(void)
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
2.45.GIT

