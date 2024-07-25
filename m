Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A60198832
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900383; cv=none; b=aCH63AZMFi1JW49l6YB1+bE+2LCU1Q1oRXOk/Oas0KGkxKMSgbFk9u5F4ePbCkN7yrty1kE/11B474sEAsKfS6j7TRHgwtHY8ACZBKwLD6pdoH+KL8W8NGUrVFDfT3HgOBUrgMMaRJ/yOdJ9i8ORE1/40fCbB88wn4hGl+lV+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900383; c=relaxed/simple;
	bh=lJ0cXIohnlHeDOyqRbU1Afyp/eEh9NcQnt1UB/p/M8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8fCgPXgFHy4ZnWrleBPAUqNHjyMbejgg6Rzr9K66zkz18GtCYEin2XSI2HyYyrY5oaXaC8aOmA+zHAHPQjw6eZkNeWhj3pjCk/2bycDpQwyW3+JpHzDFmjx7EwCZO2LTORNBVrHcLsBcg807KTkpIj25yDCRVspxUVl4UKjk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5xGy92F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5xGy92F"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso4173375ad.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900381; x=1722505181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5Wp7fD3+IzmQYf4uzeVp+sx/sYc2G2N5WK5mg2pfmo=;
        b=N5xGy92FSXsauOuNq+Uf9gDLk0ymDGioyHvd0CK9tRewjYeP2mVfvajY3CoeclDJUG
         mj0zZXvUvU7I33JxSj59Fm5by/qouah9On5ogOq1yWxK/9WQCR1QNn/jMzOVt1Uug+o9
         Hk50b2HeKbxIaUkzQMuGAiHqE1Jioo5CLFsZYU9fabW+N3F1Ye9v+mGcMV82bpoZN2Qg
         M/LNpNTjy+rQdULzWOayKt61arDAvq6jzTV2vKnCjd2m4/v1QhMIV8P9+XKb/92K3IPK
         NG5utiBtM/DkwrLBRu+aEnohDuUuTDBaMTD8+v9G5oINQqTW56L8TnTiVC1Dz1mJzwfT
         wa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900381; x=1722505181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5Wp7fD3+IzmQYf4uzeVp+sx/sYc2G2N5WK5mg2pfmo=;
        b=XZpsUwcACWVY0gkkpo3Ph/Fje1yWlTGtrhKRSSdY5utqqvdpa8czj2YyodCdycksAw
         4aeckXYflAW0oxiom28bPN3GvkP2ONvu6foGi2sP5CGS4WAvgf2rapXrWCz4ds2luei/
         rn3EtcWdzW9DhvK18yeutBXS9xEriyovK8TTcdcHBFbG1CrsnQYtrsOqa6CBZPzIJB4V
         pKBCUihSBOdwM9N1E8rTFGaAzCPBwOsKBkbTg0c3oZr0aMW158NhJaxq15ykFqV+EkRE
         1aFnUTu3fIjF4t5RpKgcwoQjGmrT1h1+JyUtH0fmuuARh3mYudcpuCWyGc8Flk0v4Ww4
         GABg==
X-Gm-Message-State: AOJu0YzOgcHS1uMdSrhDNNP8iLvjoCVt6JOlQaUBCq0PO/tObe1j6Q3l
	SRa+rO4SC0667pMXRxRM1axaomS48EaZJx4x2m6bJJnPUT1sDiHVAplMsQ==
X-Google-Smtp-Source: AGHT+IGSqMLuhrp359PWJnKpRK6vIvjxvJRUvs+NmBveq6LRMAAOgAYfEHGPbntdmy5zI6kbU8hyMg==
X-Received: by 2002:a17:902:fb0e:b0:1f7:1b08:dda9 with SMTP id d9443c01a7336-1fed924ff52mr11674615ad.8.1721900381069;
        Thu, 25 Jul 2024 02:39:41 -0700 (PDT)
Received: from Ubuntu.. ([117.96.151.20])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7cf1db4sm9950895ad.87.2024.07.25.02.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:39:40 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 5/7] t-reftable-pq: make merged_iter_pqueue_check() callable by reference
Date: Thu, 25 Jul 2024 14:55:57 +0530
Message-ID: <20240725093855.4201-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240725093855.4201-1-chandrapratap3519@gmail.com>
References: <20240723143032.4261-1-chandrapratap3519@gmail.com>
 <20240725093855.4201-1-chandrapratap3519@gmail.com>
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

