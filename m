Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230219A29F
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358741; cv=none; b=SSPzVAVrXNh8Jl/OxpcvIOd58XtQ6ulIAOXVTxhXh5K7f4+fRME2cM1BiC8eqDtPZW6djwiDT8gXiE2ztHZjcMeT7tV9FldAXX0LT+qdl1OEvoSqyr+s7Z7H+tnXmpiYqeKjfLhZ6+eM+MrgR1pJg9FXK7GsmBC19ySRteaL0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358741; c=relaxed/simple;
	bh=eziVbiL0LUGaEg6d4C+WXfmKilNXwroxU5hjbTdR3E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJbi3zql0AfPkHqjwGZYrwh91aNlNbWQK7gayKsN9wPZ9ZByOmcj3pJTcbIzMfKlfpJz1+NI0P4WMzIad5/r72NceTbN1UcFkTkGCowSttvFayQLxunC9GxHAfTGSsG3zIBc7wIPV+RVHtBt2b9qyn59JV2ikLOgX3NQFzyMRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV5vDwY1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV5vDwY1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f7028196f2so17030595ad.2
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 02:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718358739; x=1718963539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A1jaJbvylBYtbwBpSmIIsBRdMautt6SxxGgpkJHVVg=;
        b=OV5vDwY1EwUVRuRB5ikDkuzPxvGN9HB6wG0jCtGcWVnpiO/rNsQuDmW+xO7ipz8MWR
         563NxELHyaKQ28uoEvw7LMWRhFAoZ2eU0yVp1UpyV57E6ae/swuBCfqeWByFQuHRlihj
         O0J/E5yYOzTsxY1kYjfUsl3WD+1zzcFjOUCP4QytpBgulreipj6eLO2kPEJKoz1Vtiuk
         j1nmbpFVUlIQMWSx6zSQe4oevRmXhj9wAXsQVesEBOcHQOodA7VUssq5NPtgwacU0C/4
         85WxvrQTK/aD4yPuFItd9rk9n/bSG7VNzXwb/5JVP0Pw3TxOxahjYJveJkRBYXocTle0
         /qZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358739; x=1718963539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A1jaJbvylBYtbwBpSmIIsBRdMautt6SxxGgpkJHVVg=;
        b=iRKGVqMNeMXjtVNRX4IpRpOqQI5jU6qNA2larcriosiP5KpiCTNxdjN6YbvN1soKlJ
         K+a9fulD8YCSNqAbDj9Wr1XfrwraWj3Uv+E2JXYXZRn9tquFhyL1awhZKTZEyxXq5Mwe
         SSr3c2nTwn1e/xBNWE8KWukDc134I/ncb8ZH+7tsASuKWe+QtMlf5J0THvTCeloJHt4k
         mxC1t4faiyeTwT2Wjx8KploVfWNzcoFgOAaZVY97KBSwvfwF079Kdp1C0rRlf5Fvfngi
         5zf3X0LpLxovPBBEaB31Au9gdXNuqBX/Vazf/2Rk0R4atdeFtlyXFaLcHNlHPzK0g7pz
         PAGA==
X-Gm-Message-State: AOJu0YxozIjF7PtNnU+lp4V9dG5nhBGEqE1qhKuVcZkKj7+UYwXC6/KB
	pYu27MGO/AyWWFX4WSXpyPG/8Yi5e+m6zQAJr5qxePEo1ajuZFvNbU8NXiVnM1U=
X-Google-Smtp-Source: AGHT+IFFlGa/N7f9jIXFLJDTbeeyt6Vf8VtYXpML75+KPzRleeGSwFMHn6dDhDhLfQLCoNPunOrQBw==
X-Received: by 2002:a17:902:d2c6:b0:1f4:71ef:98f8 with SMTP id d9443c01a7336-1f8625ce864mr25301415ad.16.1718358738884;
        Fri, 14 Jun 2024 02:52:18 -0700 (PDT)
Received: from Ubuntu.. ([117.96.146.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f868b83afesm9230005ad.156.2024.06.14.02.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:52:18 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 6/7] t-reftable-pq: add test for index based comparison
Date: Fri, 14 Jun 2024 15:18:06 +0530
Message-ID: <20240614095136.12052-7-chandrapratap3519@gmail.com>
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

