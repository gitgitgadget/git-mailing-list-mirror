Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B6199E8C
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358735; cv=none; b=Auf6+wVqAlyq6mVa6Vhc4CTwLofwYPL6Qifc+5JQaZ33ApPNiJX9L5QYYe+psIMj3Xw1xV7+WT9byHZMiDImFP84VwONUyHDagw/GzhbSgiEcvph/+0cH8erwN7zmwxuL2c8/KySnzGlF3jb5xIPbf2s+dLfqd9W66PwXn+hVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358735; c=relaxed/simple;
	bh=ZBvpDLNHNjoQCJ3AZJra3cFXcfo2DTAZf2kQPpx1UIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2mIF3vmPP1YemuJw1r92Aqxp2BbwxHvA04Apm8BjYurBXWMz1rh1TzCtiGM/JYx0qiPRR5x4GSwcjwZosK1BJp6aPGj9tR8pnkRZXizPBaRvEpBDLpHjUPnLHm6ndFgnVyJLVsEetDAG1Xvha6MJN+C8RWUwSB20QPsSwseykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4oI1GZa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4oI1GZa"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f70509b811so14962675ad.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 02:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718358733; x=1718963533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOyBXezJzIQcgORZHKSHMuaHcOuwfGm1OzY8yhzYeac=;
        b=i4oI1GZa36JxhhmhGLJ2z8I98wcDeR6f+hfOVXkREMgpBbtrwAjl98ZyBmeMdLmCFX
         hJtGLEMpISV48B5sCsZw3KV7/BiHhu8zsvHRQghGS1/Xt5IQsQXG/34b1rYMjDQjEZdF
         h1nz+RgHMZ5hXMh6zDLXonIbvAHqmx/5uu+AAaJ7MW7ILe4WFwzPW/TMKFf0KBBfzK0w
         pgQpZoaeFA86jcLD0FKlU2HVv/nRS/cJeBUZcokh+FGH0GEwluAnH71N5tO3B60aHzKL
         FcFpj2K42Yl0YLmsPHTl+0dVEvQrXrDYQdtGKwhKuN1VvDZAF4t1m8+3cfUYXczapHS+
         Mz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358733; x=1718963533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOyBXezJzIQcgORZHKSHMuaHcOuwfGm1OzY8yhzYeac=;
        b=Fw2aiuY1QfG6EOK3VTjo9FatUUfvgYwg0HN4u6zwX5ifq/7ZaOF4d9d8eLrQcAHnDH
         gzp40G2eFLpqGFFRCktPYGypBUFhDNjN/Us35SxR6PTbJrKJYoq3yhaoiY/VSn5pNwXF
         IHeTRj9zQjJkBjaxE+SQZ0WBl2uL8QLulgjUkCE/4IdIyHGoJ5kUA6o7WBnWoq0JjvHH
         C8bGraeJgPycYTYph1DQhR4tSC3mUD2gCXEbhIjgaWzKNmEqU5F8JsIHV4/ghr1xtQq2
         G9EN7e1hZfWBP+Yj0ygLJhsJ/C4HuFQuVTlexEiAXXgI+phWcQneVAu9/Rzfd3HJ4LFC
         9Osw==
X-Gm-Message-State: AOJu0YxLhGHLM4kzcHnTqLxKV2J0ucXr+O4yZ3tGudrB0n/jMB1uzC54
	fO4VxaPz5aQYwukFVZH7Navud9+fPDbZNZk59v6JcuFG/NWDxc4DerQIwZEHZQ8=
X-Google-Smtp-Source: AGHT+IGwtSqlfEZ1cadv6UDyH5fnkPgZhJXr6oJ/8E/rZTBQ5lWCGIxpuukVlUoKWvnsHHQyvXftBg==
X-Received: by 2002:a17:902:ce89:b0:1f7:13db:527b with SMTP id d9443c01a7336-1f8625c3579mr28259905ad.7.1718358732635;
        Fri, 14 Jun 2024 02:52:12 -0700 (PDT)
Received: from Ubuntu.. ([117.96.146.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f868b83afesm9230005ad.156.2024.06.14.02.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:52:12 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 4/7] t-reftable-pq: make merged_iter_pqueue_check() static
Date: Fri, 14 Jun 2024 15:18:04 +0530
Message-ID: <20240614095136.12052-5-chandrapratap3519@gmail.com>
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

merged_iter_pqueue_check() is a function previously defined in
reftable/pq_test.c (now t/unit-tests/t-reftable-pq.c) and used in
the testing of a priority queue as defined by reftable/pq.{c, h}.
As such, this function is only called by reftable/pq_test.c and it
makes little sense to expose it to non-testing code via reftable/pq.h.

Hence, make this function static and remove its prototype from
reftable/pq.h.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/pq.h                | 1 -
 t/unit-tests/t-reftable-pq.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/reftable/pq.h b/reftable/pq.h
index f796c23179..707bd26767 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -22,7 +22,6 @@ struct merged_iter_pqueue {
 	size_t cap;
 };
 
-void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
 void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e);
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index a47a9473f3..7d151f8582 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -10,7 +10,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/pq.h"
 
-void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+static void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
 {
 	for (size_t i = 1; i < pq.len; i++) {
 		size_t parent = (i - 1) / 2;
-- 
2.45.2.404.g9eaef5822c

