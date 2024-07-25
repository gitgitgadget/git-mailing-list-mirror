Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11347198A1D
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900389; cv=none; b=fQHV1hLt+Ijnqnu/NMsRXhpflY391Wlf8viLD7F4vOKFnI2V5LMsxYY+QnQ5e3KXcDMj3gWxYS1HeiQKvSih3EH/z19zoQX6Wbf0yurGyG4QjAeVn+97DiuWV6hjVfgbvs/ww2a1aFLJJMnLE17Zx5LodWO3zOi3uEQyfzcnAQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900389; c=relaxed/simple;
	bh=ZN/PDq+y0zYFyIOyJBSePiGywPwxMctj8LK5FKWfTiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv25Y9yNWMlvCVkgx34wiqSS6BDQfeOfdABz6tcME8rCMMMPGNZKPk5e9QwSIhfXrO6MHvDT6BMpoo6VsyOy6hGM1MEAWC0Psnh4Adz/Yb18HZ4SdzH3jD4jMdhMjGygajNod5lALcc+OXpFB8cWrrP7xp9ky6BOzEXRcNCSTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTelMOKU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTelMOKU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd90c2fc68so6254865ad.1
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900387; x=1722505187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqklXr1euhQFKvZitHjqojSzFjxl8I8DYdIbc0pX1Ek=;
        b=nTelMOKUluNH+BbSJx531pNbvkTSgtO7uK6Vlu0pIXr2jOXMAduN4SmUV+v8rC0wqw
         uEuvi69lI0YZ+PumgiXj0biI6czBMoy48Lsr8yKiJiD93K9oasVLAPzWVBoiCZsuIXei
         7v9V6gGls8hj2z6oT/0vxZTcpi9Q53Gesv8jjSaqWU4IXTJUybPavQo5ddYsd0n9iiH5
         Mm/8NNa/5guyouZZ60JtX+gmIGqhU4o8PHhUftm+XabtEnnjwIYB5quhO+yeyZwv/T7e
         Ekk2UfRu2rNelpSYFF/CaWx5E+zwdYBQXkmcfGAV9spi4GSma/T/FXjPgSo/v0NidDcH
         HVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900387; x=1722505187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqklXr1euhQFKvZitHjqojSzFjxl8I8DYdIbc0pX1Ek=;
        b=SN4VUzwIAaJ28YYlJqVFKSnxPMHmatSRE0AQMqFMS1xS2Y/Q+xrJnw6C/b1yI06KZL
         VHg8/JYSURGuxGQVqCfUoErLGz11LxYL3Cc5QyTib1vG6I2J6mupxTmvIDDx+vp+HuxD
         Yyb+SQZj14gtLMyP/qx+8zABF7kcsixZRSrDhhZYCo6SLv9N7zOw/KVCDGI8cbrrW/cs
         b7L65pC4anpGganEOKGujG2u21lhM2dThbrtCzs8jX7n7sAxYizeTCWKdwcqNBJH8xHd
         x36rVoPWn3cqcViGW+mGznvtgpOVakw2yEW9YZJWK1QpPz+aCJE+5rASpXNWU3N7yPOm
         AdWg==
X-Gm-Message-State: AOJu0YwHVUCyoCxASnt7tSJnuIJGrQbQJPS6+edAnuQmKtGFHC/FXHoX
	Eop9i1qKcfgXPyNc3mgiIjiFRSD2YlhEvlBvqZXmHQaZvhxaTMkKmqZPpA==
X-Google-Smtp-Source: AGHT+IHTI1pCkrLWMuFkQBGH4SqaxkaSYrfuUWaYnktankZjsQd2Rir/ajsk2zmgu3hvbPir3AGpZw==
X-Received: by 2002:a17:902:d491:b0:1fc:6a13:a394 with SMTP id d9443c01a7336-1fed3846907mr23780915ad.23.1721900386965;
        Thu, 25 Jul 2024 02:39:46 -0700 (PDT)
Received: from Ubuntu.. ([117.96.151.20])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7cf1db4sm9950895ad.87.2024.07.25.02.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:39:46 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 7/7] t-reftable-pq: add tests for merged_iter_pqueue_top()
Date: Thu, 25 Jul 2024 14:55:59 +0530
Message-ID: <20240725093855.4201-8-chandrapratap3519@gmail.com>
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

merged_iter_pqueue_top() as defined by reftable/pq.{c, h} returns
the element at the top of a priority-queue's heap without removing
it. Since there are no tests for this function in the existing
setup, add tests for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-pq.c | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index 67f3e4546c..ce322d7255 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -18,6 +18,11 @@ static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 	}
 }
 
+static int pq_entry_equal(struct pq_entry *a, struct pq_entry *b)
+{
+	return !reftable_record_cmp(a->rec, b->rec) && (a->index == b->index);
+}
+
 static void t_pq_record(void)
 {
 	struct merged_iter_pqueue pq = { 0 };
@@ -42,9 +47,11 @@ static void t_pq_record(void)
 	} while (i != 1);
 
 	while (!merged_iter_pqueue_is_empty(pq)) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
 		merged_iter_pqueue_check(&pq);
 
+		check(pq_entry_equal(&top, &e));
 		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
 		if (last)
 			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
@@ -82,9 +89,11 @@ static void t_pq_index(void)
 	while (i != 1);
 
 	for (i = N - 1; i > 0; i--) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
 		merged_iter_pqueue_check(&pq);
 
+		check(pq_entry_equal(&top, &e));
 		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
 		check_int(e.index, ==, i);
 		if (last)
@@ -95,10 +104,51 @@ static void t_pq_index(void)
 	merged_iter_pqueue_release(&pq);
 }
 
+static void t_merged_iter_pqueue_top(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[13];
+	size_t N = ARRAY_SIZE(recs), i;
+
+	for (i = 0; i < N; i++) {
+		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
+		recs[i].u.ref.refname = (char *) "refs/heads/master";
+	}
+
+	i = 1;
+	do {
+		struct pq_entry e = {
+			.rec = &recs[i],
+			.index = i,
+		};
+
+		merged_iter_pqueue_add(&pq, &e);
+		merged_iter_pqueue_check(&pq);
+		i = (i * 7) % N;
+	}
+	while (i != 1);
+
+	for (i = N - 1; i > 0; i--) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
+		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+
+		merged_iter_pqueue_check(&pq);
+		check(pq_entry_equal(&top, &e));
+		check(reftable_record_equal(top.rec, &recs[i], GIT_SHA1_RAWSZ));
+		for (size_t j = 0; i < pq.len; j++) {
+			check(pq_less(&top, &pq.heap[j]));
+			check_int(top.index, >, j);
+		}
+	}
+
+	merged_iter_pqueue_release(&pq);
+}
+
 int cmd_main(int argc, const char *argv[])
 {
 	TEST(t_pq_record(), "pq works with record-based comparison");
 	TEST(t_pq_index(), "pq works with index-based comparison");
+	TEST(t_merged_iter_pqueue_top(), "merged_iter_pqueue_top works");
 
 	return test_done();
 }
-- 
2.45.GIT

