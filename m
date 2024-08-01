Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1644B189505
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510325; cv=none; b=EgUy2/512YLMRi4s9a0gfRkOuMQwSO6CnMwWUJgzFg7ptWJajqLpVa3+G8JtXTJSJWS/HQzoRRIBmXV4zo+ojmNutAwcCRYKdT7RYMI/UAdYogwlTUtNKN/7BE5fEcnaDTSgcFANpdH3hZnjJoj6gPMT6G/WFsciAZVL8HAOcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510325; c=relaxed/simple;
	bh=hWXgMZ34iw7PGAEbfN9sMooQpaywW4W6Yp/28C6kGHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU3x52i1gFW7TW1YpXKX40AcQLnRzm6p7M4C4WZ3GOPuDzZ0C0LqU8qMUa0QEnntog/N8N3wx/iQ0I5ohuEsnfbhg20GY2N1CFQTWHkumyZcQeggRYzbxt+tAVd39nvUhzy8qssvU3Ehv6A5RE9tf1pmEYXTwSbqLdBWYXbvpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hADuzR5B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hADuzR5B"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd66cddd4dso61221725ad.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722510323; x=1723115123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NuaX3k1wXTe8+nrMWrHgqNmNsBhzatJwf158k3A+PY=;
        b=hADuzR5B/T69z5rhD0TIKeDJoiUhShXrf4BEAyJwqe20GFtWh9cHGVGP1ifagYKkoj
         kd7OEhgycdH+KMkBbIhKbS46n7nKfnjsGfbMDUgSxl5SBXtaQf3vHZcqqdfEzC/tK+ZA
         ++SBQ4/rsh0vM95/bMJJJdwWnauwC7K3DFo/EhND8vc1SxlkTcESbkqZeB1tEywNot9A
         On35JibvNfgPrwjPV4QFdGN0RVD0ehyHVEuMOI8RZC0ej1Q4g4+2na0H07S+XafC6pdt
         GW3zdZ09sXpE7rnnEdpUe5YfIjdCWMKO+lJ1bawt7iY37uI9ImICye9Y9lmrWeN6NsCg
         2a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510323; x=1723115123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NuaX3k1wXTe8+nrMWrHgqNmNsBhzatJwf158k3A+PY=;
        b=K9xL6Bgdzsrvn/4DIcAo9GhVbBy8gdSF4wup4LlQXE8umUMdpbOvRvHiR9sYYe3HPs
         fli8mlmUPKttvJXvMZnQvZyEU5WL5icAFnWQVoA00qvarqFFjPDg6iDLD9pX1iBgzK3w
         fNN6vRSJtYOVlMEJbxGaL9QCJYe5nCJI2jC6B6O6QWRZJGRikYzhNW9fKUhMggq2Zsbp
         j1jY/mFV7puCw9WsfS+B+zFfXrO/D74p2QV9G3e/qvTu1kki6oIpK3rrHK1355dshbTY
         5Wjnm3JcrKNpW4if0m5/fd/uVq3GsTuGBPuxQSJIc1delIirf7t8YCDUg8FiHQlxNIZx
         Jmig==
X-Gm-Message-State: AOJu0YyLViu0/2UsAj2pNzWktAoxHQzErJweb++9FgzqAWfpIHkb72yU
	5HoU7ePv2yRiMEZQDD/M3A4GMElgXQ1JpBAv7+o2D3kFJI7NsN7BJD3WMQ==
X-Google-Smtp-Source: AGHT+IFp4TR5wRNz+iZLXt9SXu1/UA3ifrfbPFjG2GeDxLl3UkUXPHBaI4ohaWi7i99X8RnqG7DSNg==
X-Received: by 2002:a17:902:fac3:b0:1fb:5b83:48d9 with SMTP id d9443c01a7336-1ff4cfd1dc8mr20805385ad.37.1722510323014;
        Thu, 01 Aug 2024 04:05:23 -0700 (PDT)
Received: from Ubuntu.. ([106.194.76.199])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7edd90dsm136663985ad.161.2024.08.01.04.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:05:22 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 1/7] reftable: remove unnecessary curly braces in reftable/pq.c
Date: Thu,  1 Aug 2024 16:29:42 +0530
Message-ID: <20240801110453.5087-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240801110453.5087-1-chandrapratap3519@gmail.com>
References: <20240725093855.4201-1-chandrapratap3519@gmail.com>
 <20240801110453.5087-1-chandrapratap3519@gmail.com>
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
 reftable/pq.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/reftable/pq.c b/reftable/pq.c
index 7fb45d8c60..1a180c5fa6 100644
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
@@ -60,12 +54,9 @@ void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry
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
2.45.GIT

