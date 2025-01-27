Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCA1FFC7C
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983069; cv=none; b=CmaqvqwqXn6vyqr/rTbGU98KK+oBgds1+gh0synuZuMMT8b5VnvmTcbs/J1hi7My6Z6GYehuHuKk3xRLul/ZYvRlHfrPmOvwd8i+1021/2QSufPlWA9h8O6H93IbVRJdNb1LkTs+6HsNmoYFu7Jqpg5AJ0HmCbUVkdekY9CjJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983069; c=relaxed/simple;
	bh=JGkLARkeVoePA3IqCRJ5YFc2eBFUwobECUxEBi303kY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZfUX9fPKYto3teRvt4aw9I4tnS/csIkoFyPjCjIBWFv6Gx4GzH7G2EcsWM1D9TCfBQdc/kHrw0UVvf+7fRRVQNxqygI0natSHGb3oSKofBCWJ1b5kXZHHQtfyWFbwfPtMNEi3PpCvEfu2ez4L5QfDX8I9IXOgK1i8AIWhHiUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XE7w5W9s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nu7Rh1Lw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XE7w5W9s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nu7Rh1Lw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 46081114023E;
	Mon, 27 Jan 2025 08:04:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jan 2025 08:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983067;
	 x=1738069467; bh=DeNYQnmLw74mHIsyKpGYPDqi9jnUXrQF+XnjaP+/bEc=; b=
	XE7w5W9seBBsTOaHKWnkkrh5EljsoDxjRc7+AG9Z8mD17Px8yFpG6Rgw2Kw/BhbR
	m9ee79Hl5tsKYrQ6hVEWq89ShUgCzdWPmeBdloPebYnkJY27iErl9gOMUNbOXf2T
	iVBn9/pThZtBsUufEY44uMRIhEFJM/WwUI58VqpmrLeQC+O59Q1auKO2IucLl9C+
	elIogyW5I9pyo1UKOS2V+1a12jlnGHlOe+wgV0cKtjA+Ry6ji/q9/GLD3JNTgenT
	RDoQlKQuIY0xEooEwVKQldsd9eGLQsgpSGIiF7JL1X09DLAygFu383FROk00t1O2
	JMU9OJiDoH4ZBAYlwdJ8aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983067; x=
	1738069467; bh=DeNYQnmLw74mHIsyKpGYPDqi9jnUXrQF+XnjaP+/bEc=; b=N
	u7Rh1LwqEbirFvRY168Zfk1bMN/BZnH0u7JU1ZwojA0GomjbtLQeNWUQTpVBM7wY
	TBcSJqhfU+uxH9RdiuUXzgH6rQwYi+2ccGcFrHdV5P/WD81y+s/EhJ7VeBixhUWz
	PVOCHE8t53hUF3UuDi4Wmm3chfa5bkEbRV5sGS/Y9pBjHYZ2lpEhJ2w6FOZXbfxW
	L0ryWjkVStZjufnxMYnlSgJazWypXxgiq5j35ieNZ4gBPINPM/5C9PiFEn0rHZIm
	MESOswuUrWbZ37owLBYGXkCfVH5PmkNsol06GMtduwwg56GrBoRdiHCDQTOAsRJ+
	yJYJkWyd+rV7xVhkKU7Cw==
X-ME-Sender: <xms:W4SXZ3sw7ZCCI8qNhtD1Y7PRyQ1PdTcag4CMJEe-3Tu_vbzNMMpP_A>
    <xme:W4SXZ4dC5nHApThkjnZBNWmE3fUAo6DXfsZ9tMU0sqWQaB9SN4GhD6hBAusUyWkYq
    sSfR7GETmfgPHHvXw>
X-ME-Received: <xmr:W4SXZ6z1o7z0HhKMLS_xzUP4WAw0MPROfToCSNJU4gght9rjMjOfj1ZzhHPdAhY60pe1qgYt6ae6cRdZboUWywYzt8DlBRaQHM9x5vc63Cxt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:W4SXZ2OO-4chXb9MFlSvAkFMn7Qa-b1K9vkeHdFYY6QKXkDbpdAKdg>
    <xmx:W4SXZ39WkEH1jx_jiEmckZxvf7MrnFwQedrZjElhiOYcR3quXI2_6Q>
    <xmx:W4SXZ2WKJfiALgKXVSq_GZjR2rL-CJFIY6rxZ0OYRUvbAvAeZsMhAQ>
    <xmx:W4SXZ4c8DAAChd8do8yfnXm8YpvTKkdnlTJ8kEImsrV0pz9UAchI7Q>
    <xmx:W4SXZ5IUejdsV9dXklbCy8a5fZFPPdcJdxi3tjl9xjgSEvQ74JrDH_l0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4956ad0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:21 +0100
Subject: [PATCH 13/19] reftable/basics: stop using `SWAP()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-13-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
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

