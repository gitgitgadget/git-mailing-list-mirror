Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6319755C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688898; cv=none; b=JK2rD10Ah0HeF2Ot6dNkF+YDEhy4AyS3ybvkgPWMTOQrTvuMiMWY06zmC7sf61U/8U2MSF7RhdbWhHzJI7PWTeeDZYgg4TWMvVGG0CvfTcFPvsBEDnV4/a2ASJIIdxB+b8Al/aVaDXY90LUEOrREXTSt+PoAOz8SHezIc92N8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688898; c=relaxed/simple;
	bh=nxGHuT2wMkcElOFugJXOkTq8Kpf/nPoOV7viKGjvxBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPVPcze7mU1OiqVkd8KGU5yIK+Fzil7j3iIzAcvxD/pgJMNWXwcM096GJGgZ7HynmDlU1BRqpvzFgjWBvPeeles9pnbrlkULsJhR+zXuHZmgPSD+3/HlU+WxGgLqfPvNM8v98c3IJNv5bIkU/BKQ9LRm0Yrz8vZA7opsbfDrA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLQb0lHJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLQb0lHJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6c7cded3fso4013445ad.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717688896; x=1718293696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObKsWVnXc6Yl+tO/MHcJd+VKjrh9mp9W8H1SVeJXPsc=;
        b=SLQb0lHJ2M+6UZBVIjHHRORvgUjyLSyX1iJHiZXIld4DK7ZtDhJk3Il3uTYJyvrhAQ
         3Rq1X/xTKP7bfMCu4pIoI+KjkxFm3vKWLyIPbL4Sl40l/fTqqsH0UDwgl5ChmCxglOw4
         r/jzH3gnBSbSVZGsamx5R7C51aN8/oS0LRKX5lErZZj79Sugi5xOnxLFHqY3jt35OINY
         C3zX9ZnFrupzCOTFeeFD6aUaX/KO4ItIhWgiEPB++2gR8UoZL/BNyXGcSmpWpBtj2RLv
         1zz5b36cUdB3goQWW1e4B2DYnkVjoe4JvsoMGTdkX1HRX+Rmow6rleNTLNXNP2ghgJKJ
         X1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688896; x=1718293696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObKsWVnXc6Yl+tO/MHcJd+VKjrh9mp9W8H1SVeJXPsc=;
        b=qnJMO6G8gW8HbH6oZXrDp6IM/KaZH5lXkk8S2HeXIbI4+fBuIvhUo7tP0wKTDfKPBe
         x0QqNrl8v/Y8fQih4jJjjbCAY0dcTixex/zW4Wm6OatdYj/dgAYIT4wyCGXap/K3ixct
         f76PXG0BKhgaixWB9wgr1RhGjSk0uY6MxHFfTQ9WvGwXGgJulitZLlXc0EIgPPTMR+eG
         sV1o37XX91AKbPvJWzueg6YZZXA73B2LqAuW21oSAWMMmzN6kIdkVTJTZ17unV0Q1z8J
         04hYh1gwqq7JAJx4yHr+7+OzgFsZeRrM2cDsMWbrRI3DYImaS9K4VFcLVFo6VwRorvKn
         KPTQ==
X-Gm-Message-State: AOJu0YyChLRN99WG9UJr6AAbh5R2BT3Q4vP90VWqoQAwJjchdhzt9qFl
	Vi6mLGdti8LYkX4AkAu7TR0rlq0lKHOqzZOihYyK1ciWFXUUTOyLaPs5trkt0aM=
X-Google-Smtp-Source: AGHT+IG9NH5wFMqNLu0LUcrZuDkn97Un3bm/+1vqSWH1dnlnWKhrX7pM9mKdvZoq/Cqz9jOshkGTyw==
X-Received: by 2002:a17:902:ed4c:b0:1e7:eeb3:e295 with SMTP id d9443c01a7336-1f6a5aa5a58mr57463075ad.69.1717688896327;
        Thu, 06 Jun 2024 08:48:16 -0700 (PDT)
Received: from Ubuntu.. ([223.176.20.76])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd76fa8fsm16937405ad.100.2024.06.06.08.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:48:15 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v2 1/6] reftable: clean up reftable/pq.c
Date: Thu,  6 Jun 2024 20:53:37 +0530
Message-ID: <20240606154712.15935-2-chandrapratap3519@gmail.com>
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

