Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59C19AA6A
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358744; cv=none; b=j7KhgGQyoA6vMBqyoXJl3iSE6mxwa/YbXHISsW+zwSEmzVuGrzhj6saRe/7uREB9leihSnR1Mc/7r8ZULT5Z27KxfdhrBpN3Mpe8kTqTh0wFmZMudCsgZRX8C9jAAfvT9f4q3puA8Z1nY4clUQwYVIsuxR1yXf5KzSM7UsnFWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358744; c=relaxed/simple;
	bh=M3NmnPJY+UewlcIXn2gNvLekbAtEtQCb1WnANKxJPUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbD0ORz1F1IGv5L92XtU3DIUN74RFUFHj3sMHxAAzj3ebaQapWsJS3qkmads/No9yXWT8VBJRnlWZlOgzyeeFIT6QaylH17TZWEZ9BfzzlbD0OR8aoeP8KtCdYGe3u7frZfOAm4WJa2gVYFjQ5A+ElY4cbWylFN6refq+5LXDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2npOs8i; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2npOs8i"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f7274a453bso18031125ad.2
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718358742; x=1718963542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTbXFHflckCzDT75U/jzwQ6rjk8DD6Zkca0vVmURxp8=;
        b=A2npOs8iqJ42OIZ+f44GcGIwJKL3h4uovku6NQ3iYkw8fb/nYwx6NHVyx/Y/nJevyv
         gd4MQ2qWgbMorVtIVfvqp1iVw25C3NPsPqE6ADs+qFFEgfwhIsm7xX8LU5vKUojC68yl
         ab5bqcJfXAW4O/FIL4MlifbZ4aSfMJZ8GYSMReOnaklbwAURgDV8eL0oaEppcRolA+hZ
         lCJbgJgsM/7x/Psf5RKwlMCrbsqm40bGcNqHiG4BnmpdLeTh7vZKvS5M12vINbquZIGD
         FIF+5GqcwFbLqv0LFxhEnXf62QfeEOAdaMk++1+TiZztgzo+9pQLU3K6l0onzEyv/Cvv
         /S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358742; x=1718963542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTbXFHflckCzDT75U/jzwQ6rjk8DD6Zkca0vVmURxp8=;
        b=ueXWGj0w/t7XYbihcnZsNUf/X8MsCkiQkJdYgpIuFIy7dFEKsYrcZS6T459L7+oAnm
         LaI0IJ4oLhLghjzQH29VWL9sPsN3meztUDRQCjgvLa4epUqv3+x71EupHp8NfEa0PS5A
         V79VeQCvqsAK7aRsK9L+sRQdSScGUuhLkoWZpFNyua5Xt4gM1KJWWZy2u0EUC3QwWIAN
         EJ0S53UWOg6mdjgKdqe7X9OuSfs+ElCHHdCBbJHieRmyQcRvIu6x57rs7AW07exU7WKb
         zXO+qLfkOQ9URxv4HYZSv4y6ILAWNPEgidKkZnFVwhdYEsVdoE2Pg1GB+Ifoa+ueRZvF
         xFcA==
X-Gm-Message-State: AOJu0YzUptjOwnkrzmjltNZ7w91Rk6sSGbAosihhwEA49EX/kwyemwwb
	NaWJqSKiw2rWZ6SqbvRjPufLdEsK4CzFEyZz5sEnP03kj5YWyvAm9aW3jkFW4dk=
X-Google-Smtp-Source: AGHT+IHpJ9r3tS+lkT23tOwbBNNzOyJbeX40IIqMuayqM/BPhpBVhIg07KYIpEtue4IC2G3+IFtSfg==
X-Received: by 2002:a17:903:2290:b0:1f7:2a3a:dda2 with SMTP id d9443c01a7336-1f8627d473emr22860495ad.32.1718358742098;
        Fri, 14 Jun 2024 02:52:22 -0700 (PDT)
Received: from Ubuntu.. ([117.96.146.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f868b83afesm9230005ad.156.2024.06.14.02.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:52:21 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 7/7] t-reftable-pq: add tests for merged_iter_pqueue_top()
Date: Fri, 14 Jun 2024 15:18:07 +0530
Message-ID: <20240614095136.12052-8-chandrapratap3519@gmail.com>
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

merged_iter_pqueue_top() as defined by reftable/pq.{c, h} returns
the element at the top of a priority-queue's heap without removing
it. Since there are no tests for this function in the existing
setup, add tests for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-pq.c | 49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index e114a8cb0f..0e93cc97b1 100644
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
@@ -82,9 +89,11 @@ static void test_pq_index(void)
 	}
 
 	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
 		merged_iter_pqueue_check(&pq);
 
+		check(pq_entry_equal(&top, &e));
 		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
 		check_int(e.index, ==, i);
 		if (last)
@@ -97,10 +106,50 @@ static void test_pq_index(void)
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
+	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
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

