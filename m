Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC8197525
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688916; cv=none; b=doAYJ40eTJB/TUC41nAM2lEidbq9946isZ99cN8vC9X6JIFWbtFg8lPqtT49Ig2qLN4AbUhPtrMMOnHE7WqySKhNqoTjWI/MPXqHqsae5MaodakH+W21OIxk5jzyr0R8sysqCvXeTz0VHpK5kGhPnZsBnK+TvmzJzDzSJvvfsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688916; c=relaxed/simple;
	bh=eziVbiL0LUGaEg6d4C+WXfmKilNXwroxU5hjbTdR3E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbmoH2JNYspmejkTD+FuojvRIgjkquTkBx2yY9oElgI9JCX73wfQBS5ZOHeGpaOAgqLLOmsxpR0O0iFP7ihblyOnJ4HfqE3+I54FcUxBQ9dIacDr/TEtqfLJPc70wBCXcLQwFPQ5bvGJAfIQus3pXLlXeaJDOnyZ6pLSSovF9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsTTGoQW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsTTGoQW"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6342c5faaso10359095ad.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717688914; x=1718293714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A1jaJbvylBYtbwBpSmIIsBRdMautt6SxxGgpkJHVVg=;
        b=ZsTTGoQWfrSRT2mF+zmH9Q7hFg9JSUk6haDHOBJmxcYqfHzNK1WAWNMrTzztVdOYH1
         ie9+u4zx4jlvnl4NEoy1TQRa8SGQ1hURjxltYXg2SAC8LgPkfrHBfzwpty+HZ1eE/jTu
         z6KoInJA2ifpfLbNPmX0pQALztCUtUNf1YIz9hbrY2PQl0bhDurJTnfipfCykf+zWflV
         cMsa/pFWux1hSpB+Q4hTvZC7UGcgPSyumbP5CyTO7FkLtWRzHu4ZfkMdliYUUJwwI1hc
         c2rqUSamb77StgwwiZpP/3fS0z0ZfYKV9AilmHjK0xj/hncSqHMEviC3JNKrDFCkv4MO
         J9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688914; x=1718293714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A1jaJbvylBYtbwBpSmIIsBRdMautt6SxxGgpkJHVVg=;
        b=YY5/1p/WGVracE9WHTOV32PE5poKpJJBCZu5US7FBk0hUtKixnmDTa08wfe9oFfx2d
         upwOy0YsxczJcI/rISOV13gcEc+lrjmZOdKc+m2mllKRtEXT1SudKIlbvPr/RsVJjfw0
         ssUhulXBh1IjOgICXcP55knmFsixE7rWmcF8PpfRaDU95WqWxzVPxwIVPykd6zVJ5Yj6
         2mKXwyvwxrDJvbRMiQe4mkhW3gDmDOUvFW+QRW6rPqvb8GzG1/pCD7bKa8zB79rGrn6s
         lq5pYXCTGoZuDD3oo/C5fqz9sm/RKrhxII8gUHSEFND6vrAddUOE454uNQNvzSo/F+et
         seyg==
X-Gm-Message-State: AOJu0YwILRX5BGhbd4IsdtQbTBbPzrxzRWaPKUmGG05FCFuFbZjBOJXk
	N/22aU+mdGD2bKjj7eSAnnrbdCA/oVTRqij5BxU9Qb88ffIzVfV/kxcRuSYbPdM=
X-Google-Smtp-Source: AGHT+IE31tjwmsC2VifZpmR73enGL2sJLlxtEppqYwpOEAr1TSOLC51+tJ6jsIgbHuCtauNTHz4FEg==
X-Received: by 2002:a17:902:e883:b0:1f3:2e5d:902d with SMTP id d9443c01a7336-1f6d02d2274mr98875ad.4.1717688913980;
        Thu, 06 Jun 2024 08:48:33 -0700 (PDT)
Received: from Ubuntu.. ([223.176.20.76])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd76fa8fsm16937405ad.100.2024.06.06.08.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:48:33 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v2 5/6] t-reftable-pq: add test for index based comparison
Date: Thu,  6 Jun 2024 20:53:41 +0530
Message-ID: <20240606154712.15935-6-chandrapratap3519@gmail.com>
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

When comparing two entries, the priority queue as defined by
reftable/pq.{c, h} first compares the entries on the basis of
their ref-record's keys. If the keys turn out to be equal, the
comparison is then made on the basis of their update indices
(which are never equal).

In the current testing setup, only the case for comparison on
the basis of ref-record's keys is exercised. Add a test for
index-based comparison as well. Rename the existing test to
reflect its nature of only testing record-based comparison.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-pq.c | 43 ++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index 774c4194e5..e114a8cb0f 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -18,7 +18,7 @@ static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 	}
 }
 
-static void test_pq(void)
+static void test_pq_record(void)
 {
 	struct merged_iter_pqueue pq = { 0 };
 	struct reftable_record recs[54];
@@ -59,9 +59,48 @@ static void test_pq(void)
 	merged_iter_pqueue_release(&pq);
 }
 
+static void test_pq_index(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[14];
+	char *last = NULL;
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
+		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		merged_iter_pqueue_check(&pq);
+
+		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
+		check_int(e.index, ==, i);
+		if (last)
+			check_str(last, e.rec->u.ref.refname);
+		last = e.rec->u.ref.refname;
+	}
+
+	for (i = 0; i < N; i++)
+		reftable_record_release(&recs[i]);
+	merged_iter_pqueue_release(&pq);
+}
+
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(test_pq(), "pq works");
+	TEST(test_pq_record(), "pq works with record-based comparison");
+	TEST(test_pq_index(), "pq works with index-based comparison");
 
 	return test_done();
 }
-- 
2.45.2.404.g9eaef5822c

