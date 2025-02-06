Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E145225A4E
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828352; cv=none; b=H1xXCY8QmvcA1wfUc9Kvi1Eqj7l4QuRYY5rPbm7Qk5nAkLyJ9p60M79QXNA0KUShQzPYkdiDOnBIEUcakChPOnb+EWeJdnZAF5IBAh/iTuHyhy+belJ58jORKGIF2TbM7IN3SNrYpIng3Hh35RjMRbBqnB2s6CekXVJ94QJAIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828352; c=relaxed/simple;
	bh=wJQB3Xwbb3brOH65MuUuYdVulAsCToeuEBz+zJ4dqE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6earjL1WPC1Z0lALhpgmM0tGwD7BiKZytmyy2ysWXONGIFdeXLPXkZjATjx3QtwBNbZtOKYDYWMJjdT3yzmBOcW7QPxzUs21A76sZjfXwx27lKisDnkdaLMz+2/PfmxRJXKWwygqKNCzILBtX2iW9iMF1vPc+H5JZkiVoFb0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ewXBng2C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WLYigA3s; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ewXBng2C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WLYigA3s"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 62EEA114006D;
	Thu,  6 Feb 2025 02:52:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 06 Feb 2025 02:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828350;
	 x=1738914750; bh=xolPDAwbMxvxkjDgj336+/U2TWPKlfYMJZsI25zUOS8=; b=
	ewXBng2CnuI8OiO+rF1kfea3ASa7qVidBoT7OoUXvpHgaHpM8/zVo1Yt2rnDQL7T
	S/nTuSo2Euwbdca5U6HFlAxcvD5rtF08SSvpF9DmVQi2MvLG5QXbkNqB4DnPcSOI
	IMoX5dUrN49GZiaG47WM4UAYAQ/VLte+zqYz2TGLvIL3yknejbZAHlmjqe9T1H1N
	D2lApvCaCWfDcGBEtPceBq5xCtvBWhrQvmeJXID+MJ7B6xHyX4oA+zYUg+zKCbPw
	gh73G/FbuYk2YUzKaklHDtZ6xZ9cmHJCh4bU8ZsVO+3GKcOPcIiTc1Rjs5gWS6CA
	HlUB6fKRwkk3POLc38Savw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828350; x=
	1738914750; bh=xolPDAwbMxvxkjDgj336+/U2TWPKlfYMJZsI25zUOS8=; b=W
	LYigA3sampVKUEAAxVS6XxQIt8a+GFBVLvxAE5VbovIeZT0LNvtFmeO42kQvT536
	aAVt3cv2zO1Xcm3GX3MhAtNGx8Tt7S0A8XlmsR/r2wbtRzPxnRRf220sThx3CdWh
	jGLzfwetbe1wWqy/Ne/pHa4r2tkChuoVhhvFzoYNUvHuyX//hH+D3JR7+UDHYLpC
	o6LQEvi4oQyzWCJ7FgWetoKA7yAX7xizKXBJrURbr4acgdltFu1d5G7uzhWlaXDN
	+Cn/2AcrzUa3rm5qPfPgqrkWMaZy/MYImfefPwitQKGs3kcuJt7/n1NW8HMyidD4
	PQhtb5otTBnfKiO19bQUg==
X-ME-Sender: <xms:PmqkZ_yzvHeN-CekpvfmMgFvAconkuVxoEsHi6Qel7gwnVpsBHnZ6g>
    <xme:PmqkZ3QmU0EoQAXzgILZtTs560gkVP0qmjCh3PfyyepxHUMI-dqT9lB1qoVTzmCQd
    4eLguU2YHxKEVD6hQ>
X-ME-Received: <xmr:PmqkZ5XvQ4f1xFv8m3nIITC5rTJz5VsSI5nE2KcF5nusUwoU4Am97V5qNnK06-nqHFTJeE5C_cP9L_I1dK3Dw39AkqaJ9toKKiIp27RTygGx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguth
    hhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PmqkZ5hMbPnvGGXhM0j5H2U25f1WNHXgrN7IbTpYjxUq0BsxjLm4gA>
    <xmx:PmqkZxDxUCjgLapGLMx6pPJ0vkH5VWL0MHBj674jABWZkxt_cCirKA>
    <xmx:PmqkZyKgsX5gjHEnM1SBlfgBJM4dlbr_uAevHAYXQuSY3egPu7KHow>
    <xmx:PmqkZwBMdRWsR0SXjVjv6iWysGPJ7Smrtg1QFU3fRTf_gCQnl9L-Aw>
    <xmx:PmqkZ06azbZSYo4x4U5u9vLKDTIMs4QdyYMRTBFUQZ6T__pxrbBiuAPf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e061ec43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:15 +0100
Subject: [PATCH v4 13/18] reftable/basics: stop using `SWAP()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-13-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
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

