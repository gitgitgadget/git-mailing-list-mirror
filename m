Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256B1327E5
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660637; cv=none; b=s4jVnd9qplV+ZDCNXET5QExvrjyJgw74yAaT6mMQxXnNDSINXE7SpvbVFsi4UIuV/FyRhxx5F3wCtaXQoOQI0tF2Sz6ZDSKtfSHZHi1FV1MAJcaqqBfkzQPIwgmtQ/sPbLxwmHfbubyQYR2JLX46RpAcvOuZXkNN2mUngkRhehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660637; c=relaxed/simple;
	bh=nxGHuT2wMkcElOFugJXOkTq8Kpf/nPoOV7viKGjvxBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAaHS6k5oufLpUCgieDnmdewdkXLc9YzqRNxqtLmTK1KXKoHVaofkV0nSL3JLgkIG4qgn4wUsI4+oYwz0Cg048vmPP2oNP3GePMQLghTfkm43nt9MkhxA2jjq5WJUmuUKG4rkq7REIpjuaQFg/ztag1/RFAd9HpuBARYJgiaWEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+xfcO5Z; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+xfcO5Z"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6c7df306e86so502633a12.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717660635; x=1718265435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObKsWVnXc6Yl+tO/MHcJd+VKjrh9mp9W8H1SVeJXPsc=;
        b=S+xfcO5ZcC+/dgB1pl18YcGpz65KVPAPEOP+tcnUpNpiz2VKA00yvGksTN4gpgoSRM
         VQ+YUsUF3n7ELBhUrV15uV3ZntkrxWsI4P3aVM9vQZoPDfq9LHL+s9pJfhTlsiuG+GYz
         U4w62rJSpU/5QvwdrBg9LwVtQeA24ib2NGXZBzf5I6Br8Ib18UkvD7UtoP8qUEsvXaqo
         CGj39T3Nu0jUlawi7B6JUpSTZMT5L0x7iMFtzzTeRmi1g2rRGCvyGXDVXzUgbL2ba0V0
         VVXMmdsoPWppjDVDHsiHa2UWAm8HPEPNp49a2CMnV6vCDX+mjMG+1GVwnb+02rGbfvJa
         OHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660635; x=1718265435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObKsWVnXc6Yl+tO/MHcJd+VKjrh9mp9W8H1SVeJXPsc=;
        b=VN8+3sJRpcmSLWyeY3oXOrWQ4U0M0FjhaJpzTxJ+uKQRUgexXbFuvlzjDmcg+TRYSE
         loh/z27ghNyWLHHmfvLr0uLEEduqkSoC+k0zvlFQUpEhiZWNEtAwtYgu6b1LVCwCHJNW
         7zSpnBKg1UVZ8SY8xPEFZsVMHQtdLuvVd3xyxfSSzoa1WKPt8C72FChV6ShI3JlsQ9s2
         CRijmzXhWaSiMog6iSa/J1+4VqK1Sqy1IKBk447ZHOGEkzbH4o9mzRjoFYJ1RAobiyNU
         Vp5cXu1ZoFERExkQHxbb0CWfw3NnA3p3gwwGufT0c9JVIDzGenhOwcqPWTX4joSEOKef
         z0IA==
X-Gm-Message-State: AOJu0YwjJr6K444FD+dIp98bbbLcCMt947dB36LmXrQTbrWdimdEEZWh
	qy5bWu1kNprYOnnUb09zkHsjDLbIS/QpWaEWSqoG0KMo/F3jn5nivgOaBpS3
X-Google-Smtp-Source: AGHT+IE9b2V2wOGau4DqnvRJ2pn1qYOiJXgEeU4ZZANVJ7CSYepfJAVP4ZAQFekUI2LP51FnmX0SmA==
X-Received: by 2002:a05:6a20:3ca4:b0:1ad:878:5006 with SMTP id adf61e73a8af0-1b2b6eab172mr5022515637.14.1717660634898;
        Thu, 06 Jun 2024 00:57:14 -0700 (PDT)
Received: from Ubuntu.. ([27.61.69.112])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7ed6b2sm8192415ad.246.2024.06.06.00.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:57:14 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH 1/6] reftable: clean up reftable/pq.c
Date: Thu,  6 Jun 2024 13:10:45 +0530
Message-ID: <20240606075601.6989-2-chandrapratap3519@gmail.com>
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

According to Documentation/CodingGuidelines, control-flow statements
with a single line as their body must omit curly braces. Make
reftable/pq.c conform to this guideline. Besides that, remove
unnecessary newlines and variable assignment.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/pq.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/reftable/pq.c b/reftable/pq.c
index 7fb45d8c60..0401c47068 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -27,22 +27,16 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 	pq->heap[0] = pq->heap[pq->len - 1];
 	pq->len--;
 
-	i = 0;
 	while (i < pq->len) {
 		int min = i;
 		int j = 2 * i + 1;
 		int k = 2 * i + 2;
-		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i])) {
+		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i]))
 			min = j;
-		}
-		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min])) {
+		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min]))
 			min = k;
-		}
-
-		if (min == i) {
+		if (min == i)
 			break;
-		}
-
 		SWAP(pq->heap[i], pq->heap[min]);
 		i = min;
 	}
@@ -53,19 +47,15 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)
 {
 	int i = 0;
-
 	REFTABLE_ALLOC_GROW(pq->heap, pq->len + 1, pq->cap);
 	pq->heap[pq->len++] = *e;
 
 	i = pq->len - 1;
 	while (i > 0) {
 		int j = (i - 1) / 2;
-		if (pq_less(&pq->heap[j], &pq->heap[i])) {
+		if (pq_less(&pq->heap[j], &pq->heap[i]))
 			break;
-		}
-
 		SWAP(pq->heap[j], pq->heap[i]);
-
 		i = j;
 	}
 }
-- 
2.45.2.404.g9eaef5822c

