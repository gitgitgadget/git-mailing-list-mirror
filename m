Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40A199222
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358729; cv=none; b=Wx740UyoXETpBrxBGQeqE5lnGeCDiSCgaS/QX7R9iy5XI7Zw+f7c5wffK2kuqyFwbXB3jEu4FNawuIK5is/wNfmTcSFWqg80TGtvpRggT3BV8mKf/I220pKZyPQhRJmTMZAwDAv5z/7+Zw/lqamxuu3j9apkAqF+8u3UPRtxhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358729; c=relaxed/simple;
	bh=CH1nLTeOv7Bi4qpnrV1pGphhYJhb70s++MWgX94QalE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgQgDt0KXElGxiuIg7MvzkpzhC8D06+weo8VAfTAUU0aXjRPj+A8gX01SFzYbuc+Zx5O3UxrDOIeCR+oeXwIzogECHKcdWo268qjfFQwxLeLqpPQoMjlRzRiznlTjp9kZOYsmmvjUjnd3wR4QftlVWTR1W8z0D2NKuXBngyeWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frRHlhUD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frRHlhUD"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f65a3abd01so18033465ad.3
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 02:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718358727; x=1718963527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0fYVwNKYu1/eayMVZNM0L/hPabLRg+e4eJSmnX7zCk=;
        b=frRHlhUDg1vEOWGj83QgBliZKdor4NNaVpXLSihH+VidLT8aRPwInlw0sr+wKj0n8L
         vf18n+6p59gdN5+B9emcJPoFTqPinGGSRmoMsY/Vkv6Ew71wfyc+WHhmcE4Jau6alZXL
         PubL8rHZG6j50MH6++XwwBO6GLBhTppi/3DSQANH+Sobp4y4ZWjrCRSsTQ6EPOoyVxHJ
         V2ZEenbY+pq5p+nUHqffYo/ZklmQACv2Id/oxx0huf4pESohDKNxYGf9nObnalLvQoHQ
         4QuEhnoG2O8HcQV4oR5JF01haWSdXtlQXxJKjm9YeXq7ER4hyqk+NrqFttNnb86c1cKO
         BrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358727; x=1718963527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0fYVwNKYu1/eayMVZNM0L/hPabLRg+e4eJSmnX7zCk=;
        b=He/LbwB2pdlQZPA9kRungntJky2rnl05zaSD5QxfRKg4EJ9ESRq0Q0i3I1ZOqa0tAr
         aGzygjM6w/8RrPm7axlBajSiLulQFT2oPV4MCDP8Dffc60riuotIF/fmKvEdV0SOEWad
         8+9cellz7IGF1hvGCsXyzm/RD7FdfKcmtePIdxxvCWK1pu5ItdZwudFJ+KUTD3oIPlRT
         6lj3sFjD7AAgqE9EOZLM8NdqP6HDNobeXTVdINGKWENQ9/NSDIDrEqOMqrzQgf2YsZG7
         0mT1HvZK+nCAuPrK7Vvrzoc1ZimIWoUMOLeL+UlI4W3MEDDhgRA8YIuCU0LjJ0yXc3YO
         jN3g==
X-Gm-Message-State: AOJu0YyIAzBaO2NQE8+IbPJ5/it8qRcc30iCIeFLFv2CxOVTtkEA+UzE
	l2i13CVzEDkSY59fVRJClQJPjpyR39IYdzYj61P5wevYuwzxQTrtWITN40Uqif4=
X-Google-Smtp-Source: AGHT+IHyaQDaFf9mIvA7iM/slfJf4CIxmWly77e1kkcvWDKdNzAYrUExY1bs5UnrLVmzOrcNHLF6WQ==
X-Received: by 2002:a17:902:ea11:b0:1f7:1fb3:14cc with SMTP id d9443c01a7336-1f8625ce900mr29299315ad.18.1718358726823;
        Fri, 14 Jun 2024 02:52:06 -0700 (PDT)
Received: from Ubuntu.. ([117.96.146.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f868b83afesm9230005ad.156.2024.06.14.02.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:52:06 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 2/7] reftable: change the type of array indices to 'size_t' in reftable/pq.c
Date: Fri, 14 Jun 2024 15:18:02 +0530
Message-ID: <20240614095136.12052-3-chandrapratap3519@gmail.com>
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

The variables 'i', 'j', 'k' and 'min' are used as indices for
'pq->heap', which is an array. Additionally, 'pq->len' is of
type 'size_t' and is often used to assign values to these
variables. Hence, change the type of these variables from 'int'
to 'size_t'.

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

