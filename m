Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797E13C9AF
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660651; cv=none; b=trfJtcK9mMIx5YVze7zT/AXdrUvEPQHx41AKjUrd/DQlZsX5AR2hI4TpJD8gumFX0d+fEuW2535wYlHIYTOpUkpLP5g01oHg0rzyHMmuSElr/l1SLLBJfICbb+qBn3R10Vm+tQqrFiALvt4FIqMrUXtM2oFiO8IKdnGFeTG7LGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660651; c=relaxed/simple;
	bh=+hmp3eR/vLYiNE0paTLneD48vYtJgu5AzfMwehpwaew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OV73CNZcLiPi57r65qLe5Vjyo5BWxmMeICTFktND3h5DOFJ63WLow+tKJtAMY+6G7ZLBF9ec3xEPteMUPeczra2N3qY6XTN/k9ROfp3jyDBYkiie27A0bDy0HMay7pgyHdjfTz4q79NiUyu87ENh36OoTklEgtYtKhSNEj4Jg3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UylL7NTb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UylL7NTb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f480624d0fso6178405ad.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717660649; x=1718265449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41P4+uR8hPaF8yTksDevGPEqaxe357aIDTa9EsYKjqs=;
        b=UylL7NTbvUYyCAYpuXRPQfRbVHxCOdi1zxGAxLNtKsOt0JWfpVnN7A2yE388MWdRj5
         pH/KK+B3vYgidAH67WJCzfeVm3377FpkRIqDtCHQ925We4lIFnEGYe/ueeToMKn5R1+Q
         fQwEqm428d/ljXdQIVKDhr1NJf3a/sYxeFXiguTfL6wg7nwhoyiFHBzKP3+X/JFFE9CY
         ZWhqkNz9I4usJLlqpH9fLbWxbMCJBBrKKDDIPj9yfdpmjhqQdP5SnpDkt+S9VM8DokVH
         8/gVPjWNo63HXjZssZby29mcDJwuqAep3Cn0rnYWA0jCVf1RAQ9Fk8ylZOjNgepjUiN2
         q6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660649; x=1718265449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41P4+uR8hPaF8yTksDevGPEqaxe357aIDTa9EsYKjqs=;
        b=izPeF1qKCb2LVG5JqkUU4wHjCwBTxGTHZ9UCOixjbJYFvJszJRS7qkVfJthK6YutTf
         WDnqRGKJTSQzv/OLseDS7rR3hOMtCbueXP7PZ1fj1VNapkfhlXXnB2rejPeVXab5vkZ+
         L2w6BN3AnHKfpG+uv15oPE1W5mq1AyVPvf/7z1YJ2dFJfUBFevrYcF50wPwx/AGlFWgK
         sn0ufO36Mrdnn6kssxxGlQXqfqFRpyZRrjddqMAvTJgPJxZq+dfp2PzBgPhZMPuqHfev
         1HXuljW9FBAN0nhzJruYMOzOq5sZv4K6CAzZcwWC2u7ur2i3MtZIHKH7FQlZCx/SJJI3
         RUGQ==
X-Gm-Message-State: AOJu0YwLwksA+mpnfOg7h18CXiRw4zxwWHik6GxiYTO3CNrbA+om+VID
	Sy/IWdx6jmi6e8GWbG9OKZ4cOLmvQkUUcHwcYMnBQR1SP0UVKAcV9CXtHaFq
X-Google-Smtp-Source: AGHT+IG8MX+rkbk/CCRwmCjyX/MGtbd4CvwRv8tdhS3kkggOZzHhgChpSny4tffv/aEX24D2gab0Cg==
X-Received: by 2002:a17:902:e1c4:b0:1f4:a52a:dca4 with SMTP id d9443c01a7336-1f6a5a9ed36mr38280375ad.69.1717660649187;
        Thu, 06 Jun 2024 00:57:29 -0700 (PDT)
Received: from Ubuntu.. ([27.61.69.112])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7ed6b2sm8192415ad.246.2024.06.06.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:57:28 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH 6/6] t-reftable-pq: add tests for merged_iter_pqueue_top()
Date: Thu,  6 Jun 2024 13:10:50 +0530
Message-ID: <20240606075601.6989-7-chandrapratap3519@gmail.com>
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

merged_iter_pqueue_top() as defined by reftable/pq.{c, h} returns
the element at the top of a priority-queue's heap without removing
it. Since there are no tests for this function in the existing
setup, add tests for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-pq.c | 49 +++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index 6f6bf58307..768337912f 100644
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
 static void test_pq_record(void)
 {
 	struct merged_iter_pqueue pq = { 0 };
@@ -45,9 +50,11 @@ static void test_pq_record(void)
 	} while (i != 1);
 
 	while (!merged_iter_pqueue_is_empty(pq)) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
 		merged_iter_pqueue_check(&pq);
 
+		check(pq_entry_equal(&top, &e));
 		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
 		if (last)
 			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
@@ -59,7 +66,6 @@ static void test_pq_record(void)
 	merged_iter_pqueue_release(&pq);
 }
 
-
 static void test_pq_index(void)
 {
 	struct merged_iter_pqueue pq = { 0 };
@@ -83,9 +89,11 @@ static void test_pq_index(void)
 	}
 
 	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
 		merged_iter_pqueue_check(&pq);
 
+		check(pq_entry_equal(&top, &e));
 		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
 		check_int(e.index, ==, i);
 		if (last)
@@ -98,10 +106,49 @@ static void test_pq_index(void)
 	merged_iter_pqueue_release(&pq);
 }
 
+static void test_merged_iter_pqueue_top(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[14];
+	size_t N = ARRAY_SIZE(recs), i;
+
+	for (i = 0; i < N; i++) {
+		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
+		recs[i].u.ref.refname = xstrdup("refs/heads/master");
+	}
+
+	for (i = 0; i < N; i++) {
+		struct pq_entry e = {
+			.rec = &recs[i],
+			.index = i,
+		};
+
+		merged_iter_pqueue_add(&pq, &e);
+		merged_iter_pqueue_check(&pq);
+	}
+
+	while (!merged_iter_pqueue_is_empty(pq)) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
+		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+
+		merged_iter_pqueue_check(&pq);
+		check(pq_entry_equal(&top, &e));
+		for (i = 0; i < pq.len; i++) {
+			check(pq_less(&top, &pq.heap[i]));
+			check_int(top.index, >, i);
+		}
+	}
+
+	for (i = 0; i < N; i++)
+		reftable_record_release(&recs[i]);
+	merged_iter_pqueue_release(&pq);
+}
+
 int cmd_main(int argc, const char *argv[])
 {
 	TEST(test_pq_record(), "pq works with record-based comparison");
 	TEST(test_pq_index(), "pq works with index-based comparison");
+	TEST(test_merged_iter_pqueue_top(), "merged_iter_pqueue_top works");
 
 	return test_done();
 }
-- 
2.45.2.404.g9eaef5822c

