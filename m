Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDE51FBCAD
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569832; cv=none; b=ZtYQnV1qG4NjBwtitbcABa79DORfEL2wvxHQ8ZoS8T30dW1E5PX0ozspEUefkkLT9JUli3w5pGlhPFDv3ce9YopaW6nDwkTUqRnmOmRw3fgdT/HFWuXOF3KaS6TOd1o4YNdkIuP1gsvfI+kIsS+xTtWkkR3PyTbeYBy937Bv2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569832; c=relaxed/simple;
	bh=pZeqU9zUYifm0BvLSjOXMkRHoNX/bxo7/jgBc3tI1Go=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKppulZ66yKKiLd7w68ZPzmEuv0CZNWTZaTvXGHW+EAYArISUt3u36XBnvN1gAKocr+N37efYGpN9e0ADeJzq0W/Pt8/jIXbhvkVywRmU1SNTzoHWAg219801r9/V4sJavnjFugfeQoP8Y8DWlmfiu1Xy4o4UQq1z+UVydObhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qRDf2PKD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=idHKdPlf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qRDf2PKD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="idHKdPlf"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FB76138009C;
	Mon,  3 Feb 2025 03:03:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 03 Feb 2025 03:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569829;
	 x=1738656229; bh=sICT0fz0T9rmiR/egt+iZFDo/Yym8ns5nAb6b4tCCg0=; b=
	qRDf2PKDTrV1n66/07uDp6GdXAWZ5aJrdqZGAvzBZStG+crxUKbymcwuHruMFMPr
	7eleua25wnKDG40pPg7b1SHdrWx6BI43Kud/+vA7QwQSDBeuteK2zEVX2HQafbhm
	XGxj37Rq41V7IG9KJBsAoVTjj7FPbrppgIYZq46V5cUcMav2waT9fbQQwrjuHBIA
	96yLmxDgMO3VeDvG+DI5hlTeCEqP2T3lhjwAQxXcxXS3K0U7+oZE5RzlPWatYKPb
	47l/zMw3tMdoWr/ouol0Lqnw6gMo4RqK3vQKWwoaOfA5IPOm+CA97yoZ6a7PUMBk
	N/ulf+8cwX8IgKbZ1FX8Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569829; x=
	1738656229; bh=sICT0fz0T9rmiR/egt+iZFDo/Yym8ns5nAb6b4tCCg0=; b=i
	dHKdPlfK0XSMAJfSY6/nLvzh9VaOe+sNg4K+2qkzBu5bUbaKhJh6pr6IknWuVYK9
	d4sfJbFBq17eGE4/agrQDhTC3AuTaPCvYcGWIWDo9n21Qu7Nnd2niND9QYwirAHM
	dxqxw0Cy3FM3v5KmOcW7DrTuKVyeD2TyZbvCdpaegwM6TUIJRF4MV/+kCN523nlt
	YNUAJIQ5viF2XnChcFqbxibjWFsZOYWZQhmsm0IogBCWF3EQH6CA1xzzwP3XIqP4
	TPqhjK+v53ZAQ+c3YcJ3VIzhiDZ9o+s6OjdLYFij2cx5yaWcwpV8LIcZDW+lWjWP
	2947rV5Kui5FnSzE6ZIzw==
X-ME-Sender: <xms:ZXigZ3We7y5OYUKfaJa5254ZECeVF8oeSX5DHS0scvSA8szn63bz0w>
    <xme:ZXigZ_mxNRaGMwPCkwasuvYVTpuFUiyyn8GJFqa5QCccFtGtOJAf92KVi9M5wQsoV
    PzzpUoPUR5HMknm0Q>
X-ME-Received: <xmr:ZXigZzbVrqm1q6knqo7JE73nDcGvDA9wyexe90tO68UZydSuFeuzjPs8Pd-d1rv_Ub76DwuDZhLLbOoO8abHrNU_GAebQxpN84o0If-Syq1-dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegv
    thhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZXigZyW4qvmWJSqdF6jcAIW_t-SCI1RsSzTFUlK7FrNhmU6aHD1KUw>
    <xmx:ZXigZxlqgcNJqIGsyTCPWdkSm6Si8vAKzb8uBCNcRTQgf_98n0-FYQ>
    <xmx:ZXigZ_c-X4HCRpO0Y1dtLqoSYCUsZ9jPC25uIwKd7TX1VwrmM_4YXw>
    <xmx:ZXigZ7FKcVhvhIzJHDUX3MdQvSGgcoudDew65WzghBLBLo29iAt4Aw>
    <xmx:ZXigZ6AehdNE9kPn-wFliiyH94QRgyUNF5FJh5HXeo-1Ug6CrdVy8imC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e6dc3376 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:37 +0100
Subject: [PATCH v3 06/18] reftable/record: don't `BUG()` in
 `reftable_record_cmp()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-6-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The reftable library aborts with a bug in case `reftable_record_cmp()`
is invoked with two records of differing types. This would cause the
program to die without the caller being able to handle the error, which
is not something we want in the context of library code. And it ties us
to the Git codebase.

Refactor the code such that `reftable_record_cmp()` returns an error
code separate from the actual comparison result. This requires us to
also adapt some callers up the callchain in a similar fashion.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c                | 20 +++++++++++++++-----
 reftable/pq.c                    | 36 +++++++++++++++++++++++++++++-------
 reftable/pq.h                    |  2 +-
 reftable/record.c                | 10 ++++++----
 reftable/record.h                |  2 +-
 t/unit-tests/t-reftable-pq.c     | 16 ++++++++++++----
 t/unit-tests/t-reftable-record.c | 40 ++++++++++++++++++++++++++++------------
 7 files changed, 92 insertions(+), 34 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 4156eec07f..563864068c 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -66,8 +66,11 @@ static int merged_iter_seek(struct merged_iter *mi, struct reftable_record *want
 	int err;
 
 	mi->advance_index = -1;
-	while (!merged_iter_pqueue_is_empty(mi->pq))
-		merged_iter_pqueue_remove(&mi->pq);
+	while (!merged_iter_pqueue_is_empty(mi->pq)) {
+		err = merged_iter_pqueue_remove(&mi->pq, NULL);
+		if (err < 0)
+			return err;
+	}
 
 	for (size_t i = 0; i < mi->subiters_len; i++) {
 		err = iterator_seek(&mi->subiters[i].iter, want);
@@ -120,7 +123,9 @@ static int merged_iter_next_entry(struct merged_iter *mi,
 	if (empty)
 		return 1;
 
-	entry = merged_iter_pqueue_remove(&mi->pq);
+	err = merged_iter_pqueue_remove(&mi->pq, &entry);
+	if (err < 0)
+		return err;
 
 	/*
 	  One can also use reftable as datacenter-local storage, where the ref
@@ -134,11 +139,16 @@ static int merged_iter_next_entry(struct merged_iter *mi,
 		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
 		int cmp;
 
-		cmp = reftable_record_cmp(top.rec, entry.rec);
+		err = reftable_record_cmp(top.rec, entry.rec, &cmp);
+		if (err < 0)
+			return err;
 		if (cmp > 0)
 			break;
 
-		merged_iter_pqueue_remove(&mi->pq);
+		err = merged_iter_pqueue_remove(&mi->pq, NULL);
+		if (err < 0)
+			return err;
+
 		err = merged_iter_advance_subiter(mi, top.index);
 		if (err < 0)
 			return err;
diff --git a/reftable/pq.c b/reftable/pq.c
index 5591e875e1..ef8035cfd9 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -15,13 +15,18 @@ license that can be found in the LICENSE file or at
 
 int pq_less(struct pq_entry *a, struct pq_entry *b)
 {
-	int cmp = reftable_record_cmp(a->rec, b->rec);
+	int cmp, err;
+
+	err = reftable_record_cmp(a->rec, b->rec, &cmp);
+	if (err < 0)
+		return err;
+
 	if (cmp == 0)
 		return a->index > b->index;
 	return cmp < 0;
 }
 
-struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
+int merged_iter_pqueue_remove(struct merged_iter_pqueue *pq, struct pq_entry *out)
 {
 	size_t i = 0;
 	struct pq_entry e = pq->heap[0];
@@ -32,17 +37,34 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 		size_t min = i;
 		size_t j = 2 * i + 1;
 		size_t k = 2 * i + 2;
-		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i]))
-			min = j;
-		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min]))
-			min = k;
+		int cmp;
+
+		if (j < pq->len) {
+			cmp = pq_less(&pq->heap[j], &pq->heap[i]);
+			if (cmp < 0)
+				return -1;
+			else if (cmp)
+				min = j;
+		}
+
+		if (k < pq->len) {
+			cmp = pq_less(&pq->heap[k], &pq->heap[min]);
+			if (cmp < 0)
+				return -1;
+			else if (cmp)
+				min = k;
+		}
+
 		if (min == i)
 			break;
 		SWAP(pq->heap[i], pq->heap[min]);
 		i = min;
 	}
 
-	return e;
+	if (out)
+		*out = e;
+
+	return 0;
 }
 
 int merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)
diff --git a/reftable/pq.h b/reftable/pq.h
index 83c062eeca..ff39016445 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -22,7 +22,7 @@ struct merged_iter_pqueue {
 	size_t cap;
 };
 
-struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
+int merged_iter_pqueue_remove(struct merged_iter_pqueue *pq, struct pq_entry *out);
 int merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e);
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
 int pq_less(struct pq_entry *a, struct pq_entry *b);
diff --git a/reftable/record.c b/reftable/record.c
index 1e18f8dffb..b39d99fcc7 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1195,12 +1195,14 @@ int reftable_record_is_deletion(struct reftable_record *rec)
 		reftable_record_data(rec));
 }
 
-int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b)
+int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b,
+			int *cmp)
 {
 	if (a->type != b->type)
-		BUG("cannot compare reftable records of different type");
-	return reftable_record_vtable(a)->cmp(
-		reftable_record_data(a), reftable_record_data(b));
+		return -1;
+	*cmp = reftable_record_vtable(a)->cmp(reftable_record_data(a),
+					      reftable_record_data(b));
+	return 0;
 }
 
 int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, uint32_t hash_size)
diff --git a/reftable/record.h b/reftable/record.h
index e1846c294b..867810a932 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -134,7 +134,7 @@ struct reftable_record {
 int reftable_record_init(struct reftable_record *rec, uint8_t typ);
 
 /* see struct record_vtable */
-int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b);
+int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b, int *cmp);
 int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, uint32_t hash_size);
 int reftable_record_key(struct reftable_record *rec, struct reftable_buf *dest);
 int reftable_record_copy_from(struct reftable_record *rec,
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index d8a4c283a1..c128fe8616 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -21,7 +21,9 @@ static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 
 static int pq_entry_equal(struct pq_entry *a, struct pq_entry *b)
 {
-	return !reftable_record_cmp(a->rec, b->rec) && (a->index == b->index);
+	int cmp;
+	check(!reftable_record_cmp(a->rec, b->rec, &cmp));
+	return !cmp && (a->index == b->index);
 }
 
 static void t_pq_record(void)
@@ -49,7 +51,9 @@ static void t_pq_record(void)
 
 	while (!merged_iter_pqueue_is_empty(pq)) {
 		struct pq_entry top = merged_iter_pqueue_top(pq);
-		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		struct pq_entry e;
+
+		check(!merged_iter_pqueue_remove(&pq, &e));
 		merged_iter_pqueue_check(&pq);
 
 		check(pq_entry_equal(&top, &e));
@@ -90,7 +94,9 @@ static void t_pq_index(void)
 
 	for (i = N - 1; i > 0; i--) {
 		struct pq_entry top = merged_iter_pqueue_top(pq);
-		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		struct pq_entry e;
+
+		check(!merged_iter_pqueue_remove(&pq, &e));
 		merged_iter_pqueue_check(&pq);
 
 		check(pq_entry_equal(&top, &e));
@@ -129,7 +135,9 @@ static void t_merged_iter_pqueue_top(void)
 
 	for (i = N - 1; i > 0; i--) {
 		struct pq_entry top = merged_iter_pqueue_top(pq);
-		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		struct pq_entry e;
+
+		check(!merged_iter_pqueue_remove(&pq, &e));
 
 		merged_iter_pqueue_check(&pq);
 		check(pq_entry_equal(&top, &e));
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 6540bd20e3..5954966373 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -100,16 +100,20 @@ static void t_reftable_ref_record_comparison(void)
 			.u.ref.value.symref = (char *) "refs/heads/master",
 		},
 	};
+	int cmp;
 
 	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check(!cmp);
 
 	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
+	check_int(cmp, >, 0);
 
 	in[1].u.ref.value_type = in[0].u.ref.value_type;
 	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check(!cmp);
 }
 
 static void t_reftable_ref_record_compare_name(void)
@@ -209,17 +213,20 @@ static void t_reftable_log_record_comparison(void)
 			.u.log.update_index = 22,
 		},
 	};
+	int cmp;
 
 	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
 	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
+	check_int(cmp, >, 0);
 	/* comparison should be reversed for equal keys, because
 	 * comparison is now performed on the basis of update indices */
-	check_int(reftable_record_cmp(&in[0], &in[1]), <, 0);
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check_int(cmp, <, 0);
 
 	in[1].u.log.update_index = in[0].u.log.update_index;
 	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
 }
 
 static void t_reftable_log_record_compare_key(void)
@@ -396,16 +403,20 @@ static void t_reftable_obj_record_comparison(void)
 			.u.obj.hash_prefix_len = 5,
 		},
 	};
+	int cmp;
 
 	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check(!cmp);
 
 	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
+	check_int(cmp, >, 0);
 
 	in[1].u.obj.offset_len = in[0].u.obj.offset_len;
 	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check(!cmp);
 }
 
 static void t_reftable_obj_record_roundtrip(void)
@@ -486,19 +497,24 @@ static void t_reftable_index_record_comparison(void)
 			.u.idx.last_key = REFTABLE_BUF_INIT,
 		},
 	};
+	int cmp;
+
 	check(!reftable_buf_addstr(&in[0].u.idx.last_key, "refs/heads/master"));
 	check(!reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master"));
 	check(!reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch"));
 
 	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check(!cmp);
 
 	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
+	check_int(cmp, >, 0);
 
 	in[1].u.idx.offset = in[0].u.idx.offset;
 	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check(!cmp);
 
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
 		reftable_record_release(&in[i]);

-- 
2.48.1.502.g6dc24dfdaf.dirty

