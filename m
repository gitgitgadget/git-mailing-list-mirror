Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BEE174EEB
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094788; cv=none; b=qxaDpGHfie6Z0FdMIONBYZHZ+fi+GZpbJbDNlYyRjqFWX8/HCYH5eY9WvrDt+/Zsq7ZE6hFlS3PVJy9bq00mwuh1HhXek2pToD5GmSF88E22Z4epV3nzFAN2Uhi/33JxTo1ngsnlOCbUsexT5aemwpixiNndv/oHnJFMJJluOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094788; c=relaxed/simple;
	bh=M3NmnPJY+UewlcIXn2gNvLekbAtEtQCb1WnANKxJPUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sa4K49YFq15h9D/1IcNL79LiiwFVcYi+5PbUvPfn1PK80B7+xuG2n3RjEI52ey/OZxKsSbsSgY9FoEEyHQ8CnieaYWTNAJXlRNGHiTwsTNdDA1LWhrXd4BndWsvGLCcd6fd5TZ+ncyuIlWimv+r8Yvtp3fAKBSexNOwl5OWsRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZaQmQzO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZaQmQzO"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f4603237e0so3496740b3a.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718094786; x=1718699586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTbXFHflckCzDT75U/jzwQ6rjk8DD6Zkca0vVmURxp8=;
        b=OZaQmQzOD/NnNg7TahQNoVhtyWmKFVg/fxANHjR8oCnHB0kjAFjByLXCeaFYbZHAli
         it0mVorUQiqIeCagpp93ae9NxK7P7Rr/bbF4+HLerI1V440tPxUF+I2LBOMmwaEd749P
         8wjZSodus+kvYoZ9UXNVHwytMBhrPqdQJtw9dOz6E981dSL13j8fh1XACovWRuQxGJFU
         rSlB3FqR0pzcO+WgkiyWc4laGGFtdPCKrJYOQNocQppyBcrfTckcIiK7lH/z07W3SKlv
         99EEBkglCOQ25SRheMeiySa/Rr+lF2kuIq1FhCQSMSa50+cSTUOD2xPTo9MO+xlFplVa
         FTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094786; x=1718699586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTbXFHflckCzDT75U/jzwQ6rjk8DD6Zkca0vVmURxp8=;
        b=VVpApJQN1Lu7CaTPTlT55v4JhFsCfzGhUXP6Cf0/4xlN6XlWyf849ecPog1DWiZ9qR
         RvfTSLgu3U61FL98duYYr8P83BT+z8Fvf4PyN5sGMZa0vk01Hy+DFVhMy5sxxt27pP4m
         3jy/Z1xfc5u42C6R3l38tMzWkU/KbZJRZNZpG7Ym8jOzoi9pVH4B28QUE5+KFjoVQOi/
         EZhZTRlZ7+ZjHcKdXZL1j9OK2GSYuDlJnzoo3A7yDXiI+KIa775gcGT/kSrCZZJI1J3Y
         Ffo8gBcRjTBSaaupuQLFjtg695iYZWh7k+91yQVcCbej1swpexE6emCL/GKFa9ULW5Hm
         s/+Q==
X-Gm-Message-State: AOJu0YyGMZxOvSkws6kjPZnG7czdNkNofHBre4be8tabqW/iDFt2qan0
	NCeYQOS1H8IyZqz4kvSWWPn+oaNN/1RLH/ViMSUswXevW3yUKSzJKm/xMQ==
X-Google-Smtp-Source: AGHT+IEH2oM2zcIBzYBvyGSsOyZog67hc2PiVdRG4a1K4QkDjDYlp18kstXIiJibqxmiYjiYt5RCgw==
X-Received: by 2002:a05:6a21:3396:b0:1b6:5b3a:9a4c with SMTP id adf61e73a8af0-1b86bbacd9emr2612254637.2.1718094785587;
        Tue, 11 Jun 2024 01:33:05 -0700 (PDT)
Received: from Ubuntu.. ([106.206.199.126])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7041cff68d0sm5776170b3a.185.2024.06.11.01.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:33:05 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 7/7] t-reftable-pq: add tests for merged_iter_pqueue_top()
Date: Tue, 11 Jun 2024 13:49:24 +0530
Message-ID: <20240611083157.9876-8-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240611083157.9876-1-chandrapratap3519@gmail.com>
References: <20240606154712.15935-1-chandrapratap3519@gmail.com>
 <20240611083157.9876-1-chandrapratap3519@gmail.com>
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

