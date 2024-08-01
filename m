Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A416DC03
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510340; cv=none; b=O1JmeyBfZdsPGfNuBz0qXI3+bak//oXIA6JCEujqeEQwfDDTXM4tNFf0rBjY28kX83JzIwHmR1mY8etie5ZqCZ+BO3YTqELfDJj7bMaMJ9yqTLAqo0/dISXOtFehkoiDQcNguuBAdrKry00dN+bFxfM99BdV1mS4My97kRaKhvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510340; c=relaxed/simple;
	bh=pynCJ6skDk71/w8A2Q4B2tpMQReMSryfYOPuH77CNCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nd00RsfkZCx5VtKrYBb2tgKy5LkZKRf6ZrwGdxihzucc34k0c8D6Hm2xsaSCVWXEdSyge0LT3dRM9F1NlUePACub3kuTaFna+C50Tad4z4QxsZwjjKed22jj123B8DIbIVlF/kV+rMDCYDUcKndLkqA40Q2/6iYytFzE4DAgFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpfW6//H; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpfW6//H"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc66fc35f2so14507975ad.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722510338; x=1723115138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaYsYjWQ/B9Fr4zsediOXWxGQvonmVtVMDxG1LPm0R0=;
        b=EpfW6//Hg/Lninhl4P4xsZ++g41x4ktpZ1glFo3QmwZ3d32e+ExgNJZOiAOUTvKcTi
         G3G7bv0jX2bM9rn98d9qMjathPDFFJ13C3brSsMDGgVgLL8b08hzX9pKrJBQZdn8Hoc8
         1eO3ZVvWZcl7qcDzMIISCON4+YlZGwFVqatfNVSckUO+rewQo467KvuuHL9Hs9p+5EE7
         Qpxj8XUAzsI0gM/4yIZ8R205CI6nNFhCETjzFw3HiXGcwvJmoM29bFAUegXcSVxCS7iN
         OcLcbfk2jd00MXss+N//CsFo55Q9iN65UsJxMI3DBBNQnr6muwctdw2NLFt5i7kJBCol
         /Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510338; x=1723115138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaYsYjWQ/B9Fr4zsediOXWxGQvonmVtVMDxG1LPm0R0=;
        b=Vps+MW9td8nA9sT+8Jn17MkMKVqaT2yc8rPo3Y2reNzuE9j4Sj8Sk3DeWE+KpMQ4Z3
         2WTZRj5ZvWYwsX2FuP7n/2qW8M9oqV5X3VASOyTvDVyL2p2EC0sIjJ+GTcc9/ZUDyN/h
         N7TR8QxW9SEBvNBB063uveWk7Ogx6WgtXaRrupitccN0kQxQ1ozo2xMGUEukW0bCm1LN
         Qx1hik1QNk3SRl++zy+Jn120q2tKn2EbdQ4hemwwEcDwbdNW2JIy5i9l2aCkjTyw5BYK
         www6D0Y6ep9PJ4+5u6JJq5Ak9RyVrJdVDX9IHZC+NIAgNfNtiv7g6jxrgzvbVxuqwswk
         jSKQ==
X-Gm-Message-State: AOJu0YxvNnEhW6zOy/SmI9bWuMujqDJiI3wevM6SJD8hfEaehqBEfb2x
	RGTyT3jeHp47J/8jAKQKscWg9UgGhqCU/snlreDTM4vNNOPFfFZZ4yCBVA==
X-Google-Smtp-Source: AGHT+IH+j7djkILUa1w3m8t/lWa/06LSmSBjNYeB7yKTfjWl50dzjCGsrS6M1mYLseCiclOACEHunw==
X-Received: by 2002:a17:903:1106:b0:1fa:1be4:1e48 with SMTP id d9443c01a7336-1ff5242861emr16940975ad.11.1722510337980;
        Thu, 01 Aug 2024 04:05:37 -0700 (PDT)
Received: from Ubuntu.. ([106.194.76.199])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7edd90dsm136663985ad.161.2024.08.01.04.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:05:37 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 6/7] t-reftable-pq: add test for index based comparison
Date: Thu,  1 Aug 2024 16:29:47 +0530
Message-ID: <20240801110453.5087-7-chandrapratap3519@gmail.com>
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

When comparing two entries, the priority queue as defined by
reftable/pq.{c, h} first compares the entries on the basis of
their ref-record's keys. If the keys turn out to be equal, the
comparison is then made on the basis of their update indices
(which are never equal).

In the current testing setup, only the case for comparison on
the basis of ref-record's keys is exercised. Add a test for
index-based comparison as well. Rename the existing test to
reflect its nature of only testing record-based comparison.

While at it, replace 'strbuf_detach' with 'xstrfmt' to assign
refnames in the existing test. This makes the test conciser.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-pq.c | 48 +++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index 9230dd9b9e..70ff89507d 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -18,7 +18,7 @@ static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 	}
 }
 
-static void t_pq(void)
+static void t_pq_record(void)
 {
 	struct merged_iter_pqueue pq = { 0 };
 	struct reftable_record recs[54];
@@ -26,11 +26,8 @@ static void t_pq(void)
 	char *last = NULL;
 
 	for (i = 0; i < N; i++) {
-		struct strbuf refname = STRBUF_INIT;
-		strbuf_addf(&refname, "%02"PRIuMAX, (uintmax_t)i);
-
 		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
-		recs[i].u.ref.refname = strbuf_detach(&refname, NULL);
+		recs[i].u.ref.refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
 	}
 
 	i = 1;
@@ -59,9 +56,48 @@ static void t_pq(void)
 	merged_iter_pqueue_release(&pq);
 }
 
+static void t_pq_index(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[13];
+	char *last = NULL;
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
+	merged_iter_pqueue_release(&pq);
+}
+
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(t_pq(), "pq works");
+	TEST(t_pq_record(), "pq works with record-based comparison");
+	TEST(t_pq_index(), "pq works with index-based comparison");
 
 	return test_done();
 }
-- 
2.45.GIT

