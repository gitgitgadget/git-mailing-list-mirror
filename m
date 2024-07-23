Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3E615351B
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745211; cv=none; b=NZ65QlSOv34qTPUHSVj8AES8L3+5UZQtZN/rK6t1rmVmPoPFzIoBNASK7j1BTEu3WxDc0AEX6Re0jmkBD/XQEuYJciK+HVKxLdr2cwnNo2YrYr/GnvI5MGNlNsfAmXqauRHIOA/36zxzWLm4uC93S9sNqUfYzH6XVP2t9Om+4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745211; c=relaxed/simple;
	bh=MEGuSBUKeUzZpSZliSD/zkAMrhPHxdlWcalh5uHyUuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R04nZcjRYIL0aL0t5Xs+h3Ti94k7aIInoHClqoLzzkx+AORhvK+rqUbfroTD+Oj6BAAKSmxbpDbEXs6kvQftEauir5J7WWbIfTq/tbWnpUWK5pYxWX0KOgS4ECqBrB6eiwI3KmSRYR/+8xB/JhqC0jH4N+K/rXyA/UdLskhF0Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idXV7BSB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idXV7BSB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc4fcbb131so6031855ad.3
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721745209; x=1722350009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zju0wvK7Njs4pPvHRfCkm9410+AWuCSnYT0D62v7q0=;
        b=idXV7BSBeb6LhGSSym7DL8R+orcSkM/nrlmTCkJRDcMc3eHjcpI4E4Qw+KG4zKcmit
         lVxpSt7jWOsNt8VVICXrY3W3jzHt0oetu+gFleN/4zR13rMPGzo8HTsavvp5hsaNQ0lc
         1k2UdkguXOWxIPnNxu3bh7yHUiUr+ZTnyOmZnwDtHxJTZkiFwDqpreVZvFz4UrJIOtlW
         np7Wep55IfDOFG5RyHsnh8xC1R8IALGTbKYz+6V8Y1C5JN+vMioxm7hZBoWp/rrDkOKV
         nyv8wFvs6uM+qlocjF0XKYpVv74nr2/OFxCvhebPmZe2i2kjbhNUhw3+qse1KeRSopa2
         IPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745209; x=1722350009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zju0wvK7Njs4pPvHRfCkm9410+AWuCSnYT0D62v7q0=;
        b=SCbSus0mCsj0ToILxfResIHIiaivvXYhJkTnaobRuiVw/Sx3oxW1cCosT0wWYiWjkN
         uDOAiWz/krL8vN2+YAIsrhfTWPIkBMTfwoIAk+FohzoFUW2ZTZ08SxHigF3llnLteCgR
         3BJqziaVU/2RaxKCB4gCCNfTCkAHU/ZNkuPxxYuwHP/XUPIhWI5U27KSE/p1P/EzwPOG
         6ng2baddccrkVWsnlTVg6B0yWEctZRAdkNBFl9ReEGoHQcDaDIEx1ZhdDyk0Y6AWIH+Z
         UilUVsQ1XWuRngmyCS/SzAU47CZJXkzTbdZEeekNMGPKQgyVVRNsbXc4bWWZVk7KO+RX
         kMjQ==
X-Gm-Message-State: AOJu0Yx6/vk4ekypZLccAII1hdzdcbE5imYkJAs/59eVDWa9t7RAagdx
	YN4dj9EFSqE6eqyM/QcJ1lU9b/Wzb/4VY9tdCRHRRSSqEjhAgBqIb58nhdfUL1w=
X-Google-Smtp-Source: AGHT+IGHvRnSep0lx9VMzeRE/+PtDPSYlQscErNN9ugq1VrozK5bOA0QQ0k7bDn0PiyGUi+qEhxF/A==
X-Received: by 2002:a17:902:e844:b0:1fc:544d:4e2b with SMTP id d9443c01a7336-1fd7457c94cmr89710865ad.33.1721745208653;
        Tue, 23 Jul 2024 07:33:28 -0700 (PDT)
Received: from Ubuntu.. ([223.176.63.81])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f256c09sm75301305ad.2.2024.07.23.07.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:33:28 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 7/7] t-reftable-pq: add tests for merged_iter_pqueue_top()
Date: Tue, 23 Jul 2024 19:47:17 +0530
Message-ID: <20240723143032.4261-8-chandrapratap3519@gmail.com>
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
index 23c3f6888b..84b0a3b708 100644
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
@@ -45,9 +50,11 @@ static void t_pq_record(void)
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
 	}
 
 	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
 		merged_iter_pqueue_check(&pq);
 
+		check(pq_entry_equal(&top, &e));
 		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
 		check_int(e.index, ==, i);
 		if (last)
@@ -97,10 +106,50 @@ static void t_pq_index(void)
 	merged_iter_pqueue_release(&pq);
 }
 
+static void t_merged_iter_pqueue_top(void)
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
 	TEST(t_pq_record(), "pq works with record-based comparison");
 	TEST(t_pq_index(), "pq works with index-based comparison");
+	TEST(t_merged_iter_pqueue_top(), "merged_iter_pqueue_top works");
 
 	return test_done();
 }
-- 
2.45.GIT

