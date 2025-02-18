Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8AA23A560
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870528; cv=none; b=OngP18NEC9o4m6X6iEssJefVagCUIhdfNbaHghH0GKFsCYKkKMxPIFSoDTLRj2dNGcCG81eBDWrmUYM+YOV5zyf+yCeHPShApB3IEtsYOGqOEhAQ6CYp2NG6Rsc2JH/D9iIRXYE64BI/SxhWwl15FvP8t/qPf0MCC/WCtA4PsJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870528; c=relaxed/simple;
	bh=9BJGSuPcQiqT2438qAf1vYOZW8z5LQzmiNwdrD2xDFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o3fNrdtgkwljxdGrHpLjXdZZmZ+TbS0dLtW01McDin6IP4J5CuYV1oXgLA6WiO1TFOJXO8isYNykyBNlpeu2hE/AuXluduLHBgh9xRpU70IhQUyLrc7rCHj0nBUo8xlN2oK03CViL+JgK4U1A7VAoDiKIwr6BwVF6crwMKuks80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MJTIUT5w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=za16d13K; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MJTIUT5w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="za16d13K"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41A991140270;
	Tue, 18 Feb 2025 04:22:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 04:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870526;
	 x=1739956926; bh=5f9+uE2YJo2wP8+sm4w+hYAwgSykmKHjumj8SA2AEZ4=; b=
	MJTIUT5w+X2p5aiCAAsQLAVSiKeZAbhIZPxHvSa/wfOEJ81RgcbyKw1e0ViNHgUf
	FvTgZNvq2SJh6MaqLBUAOhq63o6ys7oiDbVCCooBeWBGM+2KSTfFv/XaCz3uI53L
	X/5JQQx0mydiMMRN9AU2HupMH8R9AAFHc5avsvkAogXey+5/hUFQv/OfUk2sUaUH
	0CWbQEK+VPAW2L5qy4/Kgk76g1rISOPFMaAGIs55MLYNIpJbe2j0N7Ggs90Z75in
	xeM9fcyD6bg7LnLsAXDEqH/mQnoK7ds+pJlFLm/p2UT6qqTQ4bHhtvCe6sq58XWJ
	3EB1Z+hZBKme132IiArOUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870526; x=
	1739956926; bh=5f9+uE2YJo2wP8+sm4w+hYAwgSykmKHjumj8SA2AEZ4=; b=z
	a16d13KHkBJ09Urjekr2vFiB7C4lgNeyYk42HqUrUdWkYAch5uz7dlqxtgGsFHYb
	13qrHhzZMOy7pG+yHZldVXKDxuGu5z6CgHUzzH0zeO/jD2Hqu2f9ZnokaxHEO+oJ
	7MkkOW8r8jCSpoA0k6hWSJVzf3/m/wYRn82OSi3TxDCA0yyOs+57wpFDnz1jxu1T
	8qiNioxfoIKFVk3Ld6sXizeDbqpGjOuBWG/VXG9wXjIqzJuRSLdbPW8TYDYDFQH9
	3mfxLA5lfkEHo+DBtgyJneu5EF5KzxJJJVLI+4500AmfgGf0Qc7jrwFNhwGysWdD
	1SjOHeqDmPgrkj1XtSbiQ==
X-ME-Sender: <xms:PlG0Z_jxuX1bA8mDPCpFh9jZq0f9Th2ehF7zsDINJn1levA-fGOhXg>
    <xme:PlG0Z8DyJgBJTfhuu2AXBZk9QjAz2oKaT7fVSAUpRHJeuVoHxjPEGrs59gi7Z1FV-
    -2kGrAcrPe5wmGU_Q>
X-ME-Received: <xmr:PlG0Z_EzDk-zZTm4xKu-Ulh1CQYxWU7ipVv3ojCS30xDhSIF9Lsm9DfwhF5RgR_CBTxbA8CTDZvSvQC4VN4mlb3Hvy4N7DbCdN414IlnG37Zo7JO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:PlG0Z8QPxpB2ZFxXOZ1hpW3axAtyixpb2h3Nj5_rxQ6u94lLKquD4w>
    <xmx:PlG0Z8ySclNu5knAfakmJ2CRDoKeip7YrfyOSsYRI0D1XIsQhkaJgQ>
    <xmx:PlG0Zy5lojRCsITkMlNm6gmnCR5sQanEuNhmp0ykrNeD0n_DX2n3xQ>
    <xmx:PlG0Zxz6Ee3U7siX8vznb22CNenIQXUq2a7QDfeZAo_RP5TQrHVR2Q>
    <xmx:PlG0ZznF5680dSPDINjcqqJLTtOKdG4spBUYn0gMfumbtVwfY3lfNdiK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:22:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b550cfe1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:22:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:49 +0100
Subject: [PATCH v6 13/18] reftable/basics: stop using `SWAP()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-13-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
index c1ddbaec3ff..59000798f0b 100644
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
index 563864068c1..4ff1553772a 100644
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
index ef8035cfd9b..82394a972db 100644
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
index 3552bafa994..9a1edf39a02 100644
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
2.48.1.666.gff9fcf71b7.dirty

