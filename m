Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA97861FD7
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510344; cv=none; b=rLw0pn/dDqDkt8QzU0xsFAEFMakf1cda0WagTQ9prSK8kXiXMjM+bg08lo/AvBxv7aoXx2g4M6CW6IPzy5dYYzndzZOX50lFp4BRGA3bbDJktINBGhJuiTi7C1EjMibgyUpgFgTbYERVjysWLYik8CXGUzhwTVNmpEOwvTxc7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510344; c=relaxed/simple;
	bh=5/4H8T14qF00xhOPgedV8y88tKFC4uefNxD2j1/X0fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/EvsaWVRzBvtNLM8ubYnckXkSLJZGEWamugAWSeJq5dE9PTxfbT8mRbnv/u0TGFqZXG3Bnr2QxyS21kbA0SDltmfdRUPk6UT8jygMxYHB4MgID3D1SeoPq8XHhj5uMYfHSP7Pd5azIh2DjaQVbmHJ+TqTrgdeQpWy+82P6cKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk2aKgPb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk2aKgPb"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc611a0f8cso50175025ad.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 04:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722510342; x=1723115142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0CXY29J8zlZlC6l5RNBhTYRF6wdOz523B8Qj+iJiKc=;
        b=Uk2aKgPbsUhs33ot/N/kDpfMc4ryQbrdh8v4oXnkI1cyRznrAOtpirdIGEbUe5rryR
         9HLFhdVvgc9ClfByoLR9REKAETqUcdyHNJKv243XiqFa0ScxmwwucW/p97kgPjyknC00
         1/8bxnlNGkMAH25QfEMbSoUoBAJX9oN/wXo7uXdq06c9AvTi2Kg41jQs4t6wGx3BAfnB
         /ZFXoNgMxd8i8HEe5QzqvO33Ow0AwOaP61iEO+8jK27gFvP2p6OzZxT1VX3jDMCvr5BA
         pCAHXhRtL5uH90VaOM5sqFcxOkTQ7HJGAS/pZb1s5u/Oql/alSkjDtxKnpZ1qUv9kqBO
         gLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510342; x=1723115142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0CXY29J8zlZlC6l5RNBhTYRF6wdOz523B8Qj+iJiKc=;
        b=fTeR8HrgEXxlUbXaFlJc1fxYpyll1w/sxp3fW7DhfFeejd1XmgwGdhO/94tm+b4VM8
         +eElDcy9J0QqMykFAN50iBxXQiKOZjQQilHt6N0MwLxm2CzuaoVko9OJhSwS7faBk2xa
         Ff00+t+vQwJ3KXB0jGiHnAuaoTKY5OXnAgQgu5We0XFGN/ov9i1KuUXzURPx8orn3T0c
         +NXXB+j7JAcq+eX5bYFQAWDyKAvtIbKmM2xe36wdEGPSHRzUu3HGO55ZSC/RV4QL7rcC
         AfcVaOcjCsfODMUpbZPqVtLsAXPkBn3FA6Gi5DbIfvBl33X50U1+iuSMgfG5x1TSUp1+
         2U6Q==
X-Gm-Message-State: AOJu0YybX26d4GqZ39564XQfOYl9ItJwbtIx0pCBfpZ6zu2P3rugoN4Z
	ZtH+ZbyL+OpkT9NahZGgeDiBpDTNPAzGKm3h2NKbkhj6Ci3mUkikP7I1Rg==
X-Google-Smtp-Source: AGHT+IFpIPipJPTYURs7rHvhEDTvbw/EMSHQYrRUH4aS1CX0Rv03fS+fZ1jzPwaImltFrx8y6954pQ==
X-Received: by 2002:a17:903:32d1:b0:1fd:aa8d:ace5 with SMTP id d9443c01a7336-1ff4ce8b6f1mr27099305ad.23.1722510341638;
        Thu, 01 Aug 2024 04:05:41 -0700 (PDT)
Received: from Ubuntu.. ([106.194.76.199])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7edd90dsm136663985ad.161.2024.08.01.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:05:41 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 7/7] t-reftable-pq: add tests for merged_iter_pqueue_top()
Date: Thu,  1 Aug 2024 16:29:48 +0530
Message-ID: <20240801110453.5087-8-chandrapratap3519@gmail.com>
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
index 70ff89507d..039bd0f1f9 100644
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
@@ -81,9 +88,11 @@ static void t_pq_index(void)
 	} while (i != 1);
 
 	for (i = N - 1; i > 0; i--) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
 		merged_iter_pqueue_check(&pq);
 
+		check(pq_entry_equal(&top, &e));
 		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
 		check_int(e.index, ==, i);
 		if (last)
@@ -94,10 +103,50 @@ static void t_pq_index(void)
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
+	} while (i != 1);
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

