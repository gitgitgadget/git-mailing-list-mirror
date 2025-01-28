Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516061EE7BE
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052909; cv=none; b=lxU+sv30w6bIpTSy/4rBrLcTYEgrmYH1pziHF9z5fAFsBmpBCbaN9FsWjHnLTY4VH7koE2hwPSGoVtTPWLtJLA8Xm8CHynKTwKYNkmrNQ4h2uhzylwnqrxheaM8dwxqWiuhDykLvWL0qiU1mXDkMoYDk0wZ5ZaOtaGnrFzPQuJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052909; c=relaxed/simple;
	bh=JGkLARkeVoePA3IqCRJ5YFc2eBFUwobECUxEBi303kY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Onqm8MPR4fC/ez3457zgPGiUe2pgZEUGKrU034q719vtInLDJDFVshix3Vph81gUb2DMKCj7uRrjaAvzlufkGqjiwZNYx6IdJLNpN56sbXBDBfoiD1YTzuKTzgXhNwr0pTacgmip1qlTVr6kgQ9OsotZl070sBLuhzTS03X/ukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nV45zm0V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gO868Bfy; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nV45zm0V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gO868Bfy"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9FB5A254024D;
	Tue, 28 Jan 2025 03:28:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 28 Jan 2025 03:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052907;
	 x=1738139307; bh=DeNYQnmLw74mHIsyKpGYPDqi9jnUXrQF+XnjaP+/bEc=; b=
	nV45zm0V+1xYi8pl3UlKouxh8LI2EWBi0lApu8KopqtVRbpR2MmWUOHhZTHGm6Qb
	VO8i7nGMwANPy+Wzb7vw0WKrUEhRqg9915clRv3ZsbdOeOP/ZoB6Z7jVpZi3BBgo
	bVQAYS4IobC6sODjFvW0uprvJtirMFhEO0s48YnYmw95cMrEDx7EBtKkhlnBItLB
	9EzL63aHGpuPjWBLBzY55zTa31jd0IjnrFeKpGHj8uAX4VeGyC016h+349hl0YcK
	avqKUtM9U5mNDiGQSyLQi9qZJplla/xlv6tHthADDHxMelDorGS+uUAGCTzgjjkZ
	HhmRsqmblxro7j9lXkW21w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052907; x=
	1738139307; bh=DeNYQnmLw74mHIsyKpGYPDqi9jnUXrQF+XnjaP+/bEc=; b=g
	O868BfyWQMCc/tfnD+v8M5FvdGSy7tkoyxxqnCL+kCZDxTWfp5+RQJ5uwtclXY7c
	K/csCoPqqSisnn0t7ke5hBqRE2GGuERtSmBDP6LboX1ktxdH65Q8q494p4I+b8oX
	w4QR+4Unw0i8FfVgwXepFJMjEcjcv+uD8i6VqfhxFemn128vHUPSl19L/dZGeOOj
	c0t7mYTEe9zRuTLMPiE0UHnkiBrgV/l04VCHEoHucp1qy8duICHLHMzG9PHKXxr+
	FQ7AxXRrmmEoIidaLc3JVh9/N6dfMkj4itZs79kN/A4mI4SJhvHtCn0RCwkovUPy
	eOOgH3JHKr02+85NdYg6g==
X-ME-Sender: <xms:K5WYZ16aJ5bncFt0BiW8evCKZz_MxEyl9JspCQaOOMBH6uYaStGQ7Q>
    <xme:K5WYZy5KK56rLZTZlGtYmt4NNr8OsrfTEbfTo0OSW1DOaZrXI6itoqc9rGxiKrn2-
    arVMreuXkx45olDIQ>
X-ME-Received: <xmr:K5WYZ8dB3Hp0s1g0WRkFIOb7JAPa4cqe_tdcdZsVsn2BZ54P9jq-eewtK-6zOtdpUMneWqdGx8cleQURWxhvWmSAe1USg3W5RKSerJli_Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvght
    hhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:K5WYZ-I3OK3IhnGD0V3vmb51XRFfki-dc-vDjzCeP82uVbpY2ZYw-A>
    <xmx:K5WYZ5KbwP_tKW58Dk2BFHaOo8cCcoP-JpJIECSaT98qhBPhXyKAgA>
    <xmx:K5WYZ3wFRnj6Q1TwEYg0r6WVM0t9FMHQTyLl9uA43JxeRRkKVIJTdQ>
    <xmx:K5WYZ1JPqycwt9HNWSlpCBp8r62SW0k8-HMOzKbA2vsQgmu6HYvfjg>
    <xmx:K5WYZ2G2JD3ESbgLJiM08urpn2Ilq9m9oeveoTwZ4Gi_tvlDTU7ldm29>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5c914c53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:14 +0100
Subject: [PATCH v2 13/20] reftable/basics: stop using `SWAP()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-13-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Stop using `SWAP()` macro in favor of an open-coded variant of it. Note
that this also requires us to open-code the build assert that `SWAP()`
itself uses to verify that the size of both variables matches.

This is done to reduce our dependency on the Git codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h |  9 +++++++++
 reftable/merged.c |  2 +-
 reftable/pq.c     |  4 ++--
 reftable/record.c | 16 ++++++++--------
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index c1ddbaec3f..59000798f0 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -266,6 +266,15 @@ static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
 # define strdup(str) REFTABLE_BANNED(strdup)
 #endif
 
+#define REFTABLE_SWAP(a, b) do {								\
+	void *_swap_a_ptr = &(a);								\
+	void *_swap_b_ptr = &(b);								\
+	unsigned char _swap_buffer[sizeof(a) - 2 * sizeof(a) * (sizeof(a) != sizeof(b))];	\
+	memcpy(_swap_buffer, _swap_a_ptr, sizeof(a));						\
+	memcpy(_swap_a_ptr, _swap_b_ptr, sizeof(a));						\
+	memcpy(_swap_b_ptr, _swap_buffer, sizeof(a));						\
+} while (0)
+
 /* Find the longest shared prefix size of `a` and `b` */
 size_t common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
 
diff --git a/reftable/merged.c b/reftable/merged.c
index 563864068c..4ff1553772 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -155,7 +155,7 @@ static int merged_iter_next_entry(struct merged_iter *mi,
 	}
 
 	mi->advance_index = entry.index;
-	SWAP(*rec, *entry.rec);
+	REFTABLE_SWAP(*rec, *entry.rec);
 	return 0;
 }
 
diff --git a/reftable/pq.c b/reftable/pq.c
index ef8035cfd9..82394a972d 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -57,7 +57,7 @@ int merged_iter_pqueue_remove(struct merged_iter_pqueue *pq, struct pq_entry *ou
 
 		if (min == i)
 			break;
-		SWAP(pq->heap[i], pq->heap[min]);
+		REFTABLE_SWAP(pq->heap[i], pq->heap[min]);
 		i = min;
 	}
 
@@ -81,7 +81,7 @@ int merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry
 		size_t j = (i - 1) / 2;
 		if (pq_less(&pq->heap[j], &pq->heap[i]))
 			break;
-		SWAP(pq->heap[j], pq->heap[i]);
+		REFTABLE_SWAP(pq->heap[j], pq->heap[i]);
 		i = j;
 	}
 
diff --git a/reftable/record.c b/reftable/record.c
index 286659c098..d86cd65bb4 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -237,11 +237,11 @@ static int reftable_ref_record_copy_from(void *rec, const void *src_rec,
 	size_t refname_cap = 0;
 	int err;
 
-	SWAP(refname, ref->refname);
-	SWAP(refname_cap, ref->refname_cap);
+	REFTABLE_SWAP(refname, ref->refname);
+	REFTABLE_SWAP(refname_cap, ref->refname_cap);
 	reftable_ref_record_release(ref);
-	SWAP(ref->refname, refname);
-	SWAP(ref->refname_cap, refname_cap);
+	REFTABLE_SWAP(ref->refname, refname);
+	REFTABLE_SWAP(ref->refname_cap, refname_cap);
 
 	if (src->refname) {
 		size_t refname_len = strlen(src->refname);
@@ -376,11 +376,11 @@ static int reftable_ref_record_decode(void *rec, struct reftable_buf key,
 		return n;
 	string_view_consume(&in, n);
 
-	SWAP(refname, r->refname);
-	SWAP(refname_cap, r->refname_cap);
+	REFTABLE_SWAP(refname, r->refname);
+	REFTABLE_SWAP(refname_cap, r->refname_cap);
 	reftable_ref_record_release(r);
-	SWAP(r->refname, refname);
-	SWAP(r->refname_cap, refname_cap);
+	REFTABLE_SWAP(r->refname, refname);
+	REFTABLE_SWAP(r->refname_cap, refname_cap);
 
 	REFTABLE_ALLOC_GROW_OR_NULL(r->refname, key.len + 1, r->refname_cap);
 	if (!r->refname) {

-- 
2.48.1.362.g079036d154.dirty

