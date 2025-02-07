Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A481E0487
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929139; cv=none; b=PYbonxQnlD2UczyxuhzSag9RqpkExEHyicY2Qi3hGnY6y5ccYMnh6N0AsesH3v57QgKUubqYxeLIepx/Z2SX2yZYf0umsuV5nOpYGHKq+gJZmKVB0HnctKdDaEvNAa4YI48Ac6Aq6M2eJG+GFl130RBTVZr60URSp93j1Hfnk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929139; c=relaxed/simple;
	bh=wJQB3Xwbb3brOH65MuUuYdVulAsCToeuEBz+zJ4dqE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0T6THj0fh/ry6DAPxO71TQs2XAhaAXfcMgNedeLzu9H1187jFeiAMoJ3tCTXZIzG1Vuto9lFIMmUTZr9WEZhc2OH9qi9dsIwPF5d8b4FEZ9FdA1IS0Xvg8C/jf6nTJDxSeK59e93L9dzMHLsZSyxXFiTzTRNoDRIsSehQSSA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eghb0Gfe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EIUT2dHe; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eghb0Gfe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EIUT2dHe"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70AFC11400D8;
	Fri,  7 Feb 2025 06:52:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 07 Feb 2025 06:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929136;
	 x=1739015536; bh=xolPDAwbMxvxkjDgj336+/U2TWPKlfYMJZsI25zUOS8=; b=
	eghb0GfeFTyHas1pdIFFu1PFAQsr0f62mgVWhwyI+arZvyrrMRWdnPWNZ60msrI2
	j4VrTvmJmtsO2bSBXBiuicPVnfrSlXZl6UVZu1+uboCHFb7dOHfmIk/NHf67xdqG
	/AfX1c8Wcxb62nWVO2Gf7JHt3Pt9OX0O7EkTa42kMkoFQum/hTwi4vWibNYzQTGI
	HrwrPGB8vdAs7rhs8nLmUMnOlsFs2EtHnXMEL41KJWxgn6MtJSiM6FLxj1j1kH3O
	JNx4EEF8f0oW5GN2Fs7cVWl/T+8gusSrbdiTTAbQAmolo1dgeRfPFdkyezvJJt9v
	sybsRBx7CY94xAqM6gG1fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929136; x=
	1739015536; bh=xolPDAwbMxvxkjDgj336+/U2TWPKlfYMJZsI25zUOS8=; b=E
	IUT2dHeWRZDAmOrdXeA+IMoDRXkPBgN5yy1DOtQrDCUnGNlfvQi4m2BTHiExh+LN
	GVeXsJdacFwbJFe5nT6M7aK/0wIKI01XUhsgdsxU6mMh6ixvFgDEotwADSXpolU/
	it5uboPeepnsUL+dVcM4t3YUDTQe+FrkvwVrIM+YKAofX+TJ/j+MjGBUNFbLXzb9
	UlRjl1nGTbwgSbbcTMV0piaJ/TABaZt/JXBi4wDN94Ii4GiJun9HsAj9kcq4xTsV
	AClI4no89nE1yej/HKNRFpt+8oUtNZnTnpbVGnfEq0JObNfpHozmPFHrWRlC6aKI
	IlavHpA3CwZClDvl35DJA==
X-ME-Sender: <xms:8POlZ1mwRmXBKVyWDsxQkJ1-JU_Gd2WrBw087soADeePj7DPy5GITA>
    <xme:8POlZw0oi6nU-tnLwP6Enp-eyRJQDXVKCnQesVeVGUVyJF15WT4dD-oyp013Igen_
    MNJWHVwHfO3Lw5VHA>
X-ME-Received: <xmr:8POlZ7oTmF87GjFHIDYmD2CdV57qaqHcuBFM31vN0GFjmUTdtgudf8Zy7qApHBUUtNQFDx4qCcd0EVnD8XqT_-r60XJBtcxadA481XIEBIsLVp50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8POlZ1nu1BUh5hSPtcjNxyQRlfTH4GbTIwMDClWUMk1N81ON7fCr1A>
    <xmx:8POlZz02Hb5BIa0ajIzz96nFtoYY4Mc-qIE90zCra0YkXZ6TcfZ-AA>
    <xmx:8POlZ0uCTZiHLnDqaxcvasQ-q1wN1bC3P_EBlMeQ1lt55j4wAtPI2Q>
    <xmx:8POlZ3Vt0RWaiLK5KkUxtRbtqcM9P52pSSxqeNUYCyoIftad340gBw>
    <xmx:8POlZz9gecTFh3h1JvjdGkLq-b5-zKdnCWFZxecYRIFnM5UlTc7y47v3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9caa1253 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:52:08 +0100
Subject: [PATCH v5 13/18] reftable/basics: stop using `SWAP()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-13-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
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
index 3552bafa99..9a1edf39a0 100644
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
2.48.1.538.gc4cfc42d60.dirty

