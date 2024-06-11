Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C832174ED2
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094774; cv=none; b=A0e2ceEVwRUhpH8NFy7b+R/y1BhyvaBKKnk3+QToRnWxy8oTW0MDxbb9dBA/CMCHTaMgnrMb5Ml27EzVZx7NCizN73lDV4ElPwZOUkT9ecSlmP0QDJ2zpi5IuFY/Zllh90FDjrOHFJB014IUIC2LGU4aRSz+Q8cEq7v/4Z4ysYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094774; c=relaxed/simple;
	bh=1SMy+HLFZaRWGacGhMAscNwlXmzcVFWmTLAuvx9q4/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhM+loMIKtBkup/UURRIDlQDk7ug55Tmb6n0HnA0N/R5TXBOXCYWiNNBoyDJA/c6tPtTckaEa1JMalL9U/e9OamV0b7f99vXl7Ab1wyIfhYrfQzIGUwgunRZuU0XrOGZK8Ohg/7LaAMDhBP1gWdFv8U6ow/b23IyM1stxtvUNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADEdSKe0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADEdSKe0"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70435f4c330so688012b3a.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718094771; x=1718699571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqG20YL81BWLyY5VT4U5Fr8w3V6SG4cyQPmHmgVX9AQ=;
        b=ADEdSKe0bu/zvTvkkDC64PHUTcCTI5aGwv0vNhGoe3qqGbUwP4QJuidugw9boBzFVH
         u3dl8opcgqx6oWDk2zLHbEeExuhlqI33l5Xnno8savJvdZdTKbWKrH7NtRBjWphh19uN
         elrh6t4zl0vBEImwAIE/SSKwrLSMTiA8IZ0T16bhxh+zQh3shIf9E+/Lp6MxMswwMmLZ
         vfqkw6WooDYsdoWMrgmQgivPqQRGrjHYiM00fOlNRKNG08Pz9wWhWhNr9PsKxggfSc0h
         +1KCujA/JC3sF5chbDxRlqAxTP47Uvsq/Cx3KYE2MKngm9WU6YYuhj+/Z/h0bIf2FTUG
         SEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094771; x=1718699571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqG20YL81BWLyY5VT4U5Fr8w3V6SG4cyQPmHmgVX9AQ=;
        b=oqtl6Jv/LLWsh1ZmQIZFOSxOJIkPi/W28ie6QvN8bf6atwwigL+xiJFa9Ea2CoC4wY
         EYxASZAAxBj8Gaj8zoCyEGYXqYGpdFdwYChz7dtr+Xche+8LFngGiVk1PAoPVIukHxcZ
         zV+fAs4esMWU0h6I0hRcJh+JnwNwBqNr529hWnH8DUu2Xua/2o+n3mZsdmAFPOhYC2yH
         jpeqi+1Dxe4xoIDiDqU5dDDaYsL/aj/ETUExoLBjDEWAc6ZK5c7MlJCHHev4hrXdD6K9
         mAsGwUmVeAwAUwA2ZeUk5wpAB6PXNCuT+sHqVVo8eXMhiXvn57SJJbPCbLxR3gs8Zv5R
         7IdA==
X-Gm-Message-State: AOJu0Yyl1H+3+P4nLUV0tC1+kjxpOVU4g4EUwkuO6j0DgwkbfTyl8pgD
	E+FdYZGdTwuhedzxH7uWuq+cW9LOhhfceG5v6JMVp0akjXRnhiT1zZkzFg==
X-Google-Smtp-Source: AGHT+IHQVdraAJZSepzf2a9CIpKrqPIVTMJ6nyBa7upx2jFoY1oIZUz0rExtGEZweC4Tbm6fvV0n6Q==
X-Received: by 2002:a05:6a00:3cc2:b0:6f8:b260:ae9b with SMTP id d2e1a72fcca58-7040c72c63cmr11175155b3a.27.1718094771389;
        Tue, 11 Jun 2024 01:32:51 -0700 (PDT)
Received: from Ubuntu.. ([106.206.199.126])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7041cff68d0sm5776170b3a.185.2024.06.11.01.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:32:50 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/7] reftable: change the type of array indices to 'size_t' in reftable/pq.c
Date: Tue, 11 Jun 2024 13:49:19 +0530
Message-ID: <20240611083157.9876-3-chandrapratap3519@gmail.com>
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

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/pq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/reftable/pq.c b/reftable/pq.c
index 1a180c5fa6..2b5b7d1c0e 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -22,15 +22,15 @@ int pq_less(struct pq_entry *a, struct pq_entry *b)
 
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 {
-	int i = 0;
+	size_t i = 0;
 	struct pq_entry e = pq->heap[0];
 	pq->heap[0] = pq->heap[pq->len - 1];
 	pq->len--;
 
 	while (i < pq->len) {
-		int min = i;
-		int j = 2 * i + 1;
-		int k = 2 * i + 2;
+		size_t min = i;
+		size_t j = 2 * i + 1;
+		size_t k = 2 * i + 2;
 		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i]))
 			min = j;
 		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min]))
@@ -46,14 +46,14 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 
 void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)
 {
-	int i = 0;
+	size_t i = 0;
 
 	REFTABLE_ALLOC_GROW(pq->heap, pq->len + 1, pq->cap);
 	pq->heap[pq->len++] = *e;
 
 	i = pq->len - 1;
 	while (i > 0) {
-		int j = (i - 1) / 2;
+		size_t j = (i - 1) / 2;
 		if (pq_less(&pq->heap[j], &pq->heap[i]))
 			break;
 		SWAP(pq->heap[j], pq->heap[i]);
-- 
2.45.2.404.g9eaef5822c

