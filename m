Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6CE154C1E
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745195; cv=none; b=mc9xtI6NuuTQm6sm7zjmABijE5VhaU3v9uxvSQrRHSn/DQGp4RydbTuzraQ6/JhzCuzrXSFGKYEmYakimqpd+FwVVv5EEc6LSLTqGSR0HpNIgBLRnDjeAWlAz5XhBS1p0C06JM8gpmsJh8I+Vx9pSy+H7cFzzT+BDJjPw7FJFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745195; c=relaxed/simple;
	bh=7fe8b1Q8Pk/pmk9PSJwbpwxLZnOxvrkFTJnvVqloIGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyhtS6YytKdK3GObEofa0ABRCsi0xeswsRXHVJ3CD7upApet/bLq3LTIN+7Zgn5o/rnkjYpjf3ZFeNtiXqmkx3hct0B0UDHzg3rM7S42VZelSnIH5sDbQ48LQnAc0iM5Cd1VYEAM9/o/Vckgztc0yHEFtW/87Vzc+CWP3Ocym68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+EeCTDG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+EeCTDG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc587361b6so42733645ad.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721745193; x=1722349993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylQ+xgFjJ2e2nKDrWOjwE4C50vKRhEy7qTSwCzeQ9JE=;
        b=C+EeCTDGQ/NPbUsaFHADVU0v7bUV+A7ojxXP8HHpVSpTYdnOcKoUaxEW/yXwogsL/Q
         FUYcU23kQPSEwK1hcfzrz9jbabp9e/3gLmEL4ZFeV4LTFsJFqByLx0WRjV+QVHa1Cy3P
         RWfP9J9d4wXrE/toDra2heWHG6T0ExKPEB59+tp2oyk5iz2irOXrRK1Z78DuLdmg/SCU
         F29jtcQvccw1ugIpnla/QcY/SK/i0t/3rBHMOn5UIJ7L8Rz4E5K7/w2R/Dk+NgZ9faW4
         4eTNIMaK8OemDZx5LZ54pK3GyK51077NHmnrRHYhuqn3hb43ngfP8pDzCruhK/Nw0mvK
         u/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745193; x=1722349993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylQ+xgFjJ2e2nKDrWOjwE4C50vKRhEy7qTSwCzeQ9JE=;
        b=cViVAXhThZt+h6AlqWKu8ZtgGVk1L5Z4eYDr+sKbVdicndPvl8np7tqFNcw6WRCcLS
         wU/ZatmcFgkCfnI+fo2mM9i0xOjiM9GMiholuclXO+8ku5oSi9K6k+uCy1kRcYzilQN5
         WuMvzgNIg3bgis/TlH2Q/oWRAc7Zazpi6dvXQ7dVP0/wYeB5DcrnbXhPkGyirJ7QkpZB
         053tSQwYJfFxDGjO5Pt2w8IOSvJ8i6Fpdxf8UkW3JJLefi0RS0u7wuZsblrlklWs90Hf
         UzWFlIZY4Lkm0+otUZ0AiwBRncey6Cl0ta8lBWsF3gskv5sh17bm1SMBQlQ/maewpY1P
         7qUQ==
X-Gm-Message-State: AOJu0YzqTFvRCt9fvgBo3rrPvvgciDZJEBfVwSemgqJjmbMR+ydri8If
	GD27FcQ+rZ9wvMexGNsuwjMzK1rIlPGHsa76XHdjlpL1NHBpm8WDQ93kzRo2lxs=
X-Google-Smtp-Source: AGHT+IGpjsTS53f5y0dBNEp7Ibn7+9Rx9W20Yq9/cGb+Mt4nE5plpWtRMHbWvqDfjpkz1AwITDduZg==
X-Received: by 2002:a17:903:32cf:b0:1fc:327a:1f48 with SMTP id d9443c01a7336-1fd74573663mr85086945ad.12.1721745193123;
        Tue, 23 Jul 2024 07:33:13 -0700 (PDT)
Received: from Ubuntu.. ([223.176.63.81])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f256c09sm75301305ad.2.2024.07.23.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:33:12 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 2/7] reftable: change the type of array indices to 'size_t' in reftable/pq.c
Date: Tue, 23 Jul 2024 19:47:12 +0530
Message-ID: <20240723143032.4261-3-chandrapratap3519@gmail.com>
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
2.45.GIT

