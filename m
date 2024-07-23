Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE57154C0A
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745192; cv=none; b=W+q4x1zooRfnWbVui+8WJycXDnsyQ5uxpVx2d5Z2bMat0YR+pckFV/5SDMg4ALPkBQT/bYkS+Pt72Y2FQl+DeL54TxbFIGzxpplb6WTNvR+iH4AdsyiAr6XBInEOQwCFSmiGbihMgrDZ7FjHsrLMG9J7fVPwQcBmlaVSHxbT4Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745192; c=relaxed/simple;
	bh=hWXgMZ34iw7PGAEbfN9sMooQpaywW4W6Yp/28C6kGHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDOjao/02MKC74oXyVWjO8zJ/+nChEmW3KBST8Nal0v7naWUKXtG+D3qYGjWlQxz+rP6VkNfvpAxPMLW5XKKe74tFF12JG8yt2uCzZEWvaci24JZCmVZatO4YdESwAAz0jgjS1XH7rHhTA3z49g6QLpvTajCKv7P6Si8BiUAz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGvjjtqV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGvjjtqV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc47abc040so5928285ad.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721745190; x=1722349990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NuaX3k1wXTe8+nrMWrHgqNmNsBhzatJwf158k3A+PY=;
        b=WGvjjtqV65qlIw0+86R1CBX6kd0gpS33qn6DKEolA4lwGLLSe/oheaZBOiVZUMsotD
         CdppaiwGPGE8A3+zoGHU6Q01WY0VqrjrccIk8Bi8Pkd6ZojyyozIq+rBWjlk+1PhsQOl
         oCKFOp/aEB+pH1unNSLe70vgj0xdDjdYxP2UBbseDF/s82S8gn4jLXwJ0rknmavUJVh0
         U14A9ngpAHdl6lDOEXYrDpofe1jcMqzz7Nj7+QOuVGTGZlvHPKRy5MtvrJ7rV5i2ukYn
         GXuM5gL6yF7sCnAXYLxpBOc4I+UCmR2n/sTusgu6YBYdJqE0Ys2pXyX5LIV2CgVbXJ76
         entw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745190; x=1722349990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NuaX3k1wXTe8+nrMWrHgqNmNsBhzatJwf158k3A+PY=;
        b=cpvzZso3R5UYU5NDeEbNFTtTaSiL/p9tOUuq83nHU8K4xkgGGWQ1NPrPAM+64zYOA6
         lMcH9PE95HfkVVo9or9oOkX2Z0i/5T1VsNzfpWO2CoVh9Y/cQiwpU+d9G4uf33Uyf3Ey
         yLsfEuUhRp0JMw3WJCD7/D/0SR4kngLmgR9F1RYvrE/JhSV9rCbzWVC0SoboYLvwxsfC
         tHy0KGXjcQuFSSAsiq25AOrwy46E5QEsLfQK5+avBvD7UEaLbVznPTkVIx5T9lUxYXPt
         oZIeHG5qvikdYaBR92InuwoTLEApoRpUqNilBwH1WJHYWSndwH5fPd+ayl5NA5rJYLLJ
         uTAQ==
X-Gm-Message-State: AOJu0YwVQVVRnBVxwIaR+GAOCeLlTVqYf/Su3qwFcyOcdKLYE1USomn+
	K5u9dh37xrBkheWEiCYkZBrQP5XTH72KCXqRxdMGdvwCM7+lSdBY/mW1L3xKFFQ=
X-Google-Smtp-Source: AGHT+IFk1kDKajDEqsYZMZmpNu3yhu5sFyDFB/tC9ssUqCAfH9EeO2AneFa8XG+KFRGqeppiedL0iw==
X-Received: by 2002:a17:903:191:b0:1fd:93d2:fb67 with SMTP id d9443c01a7336-1fd93d3012amr54678545ad.52.1721745190425;
        Tue, 23 Jul 2024 07:33:10 -0700 (PDT)
Received: from Ubuntu.. ([223.176.63.81])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f256c09sm75301305ad.2.2024.07.23.07.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:33:10 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 1/7] reftable: remove unncessary curly braces in reftable/pq.c
Date: Tue, 23 Jul 2024 19:47:11 +0530
Message-ID: <20240723143032.4261-2-chandrapratap3519@gmail.com>
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

