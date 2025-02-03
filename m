Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C75F1FCFCC
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569839; cv=none; b=L+36ecY6WJZg82A8xcB9tEkbQmYxk6skj4HtyIbRIs2w0XSk7QdXjZxvnLn8LsYOC9sWMNgHE+hNON2xQxMC1hBdlTBX9dt/vnPYG5k5/H2qgVkk5rj4CHPoA9Xve8YCpOMdkNXR9X3FxsJAd3pwhReppePb5KD7KRlz6NPbB2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569839; c=relaxed/simple;
	bh=OpdW/mGF9XMYQK2mmgK7mjXfmpbqUbG8DHR3+VDRkKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c1cdNuYmYKJU9Kow1i61SbaBC/s6r9ljvuyM11eF8nqvNwJ4TC7yUz5KaIbXl+QlYRxotJ+zD/8StNYMazQjs71xlqiA55wxfU1egLOJzIU8qRyR85RNV0LyDHTp8EVBiKZTdKSXh7Dum7uCmLPVfhUAJoLrUI5v5pyud72qodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L573I/1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n1CFEyPu; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L573I/1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n1CFEyPu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B53151380848;
	Mon,  3 Feb 2025 03:03:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 03 Feb 2025 03:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569836;
	 x=1738656236; bh=l4VUXgzw5pxuPC3yEw3GSC389AAQPeKDWOwkXFtTC8I=; b=
	L573I/1uo0bhp5crY/9iiPx64KKZCR3Dl941ut6YuGrcWY7zj3IfwarQ0UulNdYA
	x8QhnDwkCYPiCq/y83MjU7axE3R1msNS3geQU90NeLDU016btFg+1F89DKcUoLNs
	6G/ppdew3G4GlwTl0fBCM36LuBNeOQZVdzlWTpFCJ4Huyy8c1JR9ALlRcOtUWwvx
	Hl82ttD3ATkdDZrlZKSRkMkZnug+nLmODWH1PZK1qJIYFOKaiPv+6keR4iSUr6Zb
	qWoCDj0vWCD9bZEgqiB+zXXBEnUICa8A4sk9Gis7Va1FIlv36yjiOYQqe3PgqS/S
	Sv5YZhKBNpxBH1959ayElg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569836; x=
	1738656236; bh=l4VUXgzw5pxuPC3yEw3GSC389AAQPeKDWOwkXFtTC8I=; b=n
	1CFEyPux6whe9/E14bINn5d+snoYzDHRnAeAvogMDTZBdjIuaUFJYLy9cpDzZTgN
	HVYcFUvh7QI8nLVilLn+PVirYV8G5+0TYGjtW7fuN9OI8ajOPO2/Pp2zJ12V353d
	YE3qIA4xdCcypOeceB7G14R3CYISXa+hBGykcWHMwWfJfUKo1ctNwftP9gtQKUFL
	T5gta4H49Xk6Tms8Zxb25Cf/QrMABLnERTJR9aK+Hv5YGuQUrDixxDgNIie/375t
	UXrGHtjRjAF8dzw9tg39n7YxPWLzXxnPoJ9U+ebJ5ggFgFS9p3ag6Nd5NJt2dvUt
	fdZEBVsjLbaMBIwrJp/TQ==
X-ME-Sender: <xms:bHigZ_zzNRa_wDmez9tsNesABLVM26fAM2k3QZUikWDq0nEM75hlXg>
    <xme:bHigZ3Rmc6q1HMWMl7LBS8Ffo7ZA1DzbwO8WZFxPxJtCZS_QzbvGyFVisfPkjKcmi
    27wCUCE6s1QenHcqQ>
X-ME-Received: <xmr:bHigZ5Uvf0MxwQHmHq1HFPDyDBT_j7X4Cg23bDfpk5DVJnikCIn18I3_85-v0VqysutaAHpNDPkK6jGFJaINnWv4eoppDK2KPct8uvT7Tq1ZcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bHigZ5iMJlp_7s4GDPDuAKEDfgQqEXoAMthobLRuU50AxD-grDIKLQ>
    <xmx:bHigZxAxHq1afrZm6us89w2Af9YE06Mzs0XxCrVti4DSXgnhrWJQ5w>
    <xmx:bHigZyLglXHqnd7IzBOehYJEUL769RdjBWU3e6ru3NhOcf9v2h0SEQ>
    <xmx:bHigZwCMJJI3pBO0MrmjTKdGCMMmdowvuMtsd3NeTDTlR284ttbjDQ>
    <xmx:bHigZ8-amxqfOBS6BzuQqj5wtXTpQ4la9NKlIYaKPzD-ZyBxlGndAjBo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8fdab8ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:44 +0100
Subject: [PATCH v3 13/18] reftable/basics: stop using `SWAP()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-13-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
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
2.48.1.502.g6dc24dfdaf.dirty

