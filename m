Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3425D8E9
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734818; cv=none; b=lEkRY8OxPnjO+xzt6D3QHAcMama4/3CKozg1XBQdTmUWYuiXz7n2LHrvdKktoY1nWfRLVye1JnBG0KwFbcK6MbLn2TSNtQVH1cGRpQjNdwyKppE27MBTDChNyH5FH++gEphjn4GdU7trsD06Bt9LoWKSV569I9t2fRxJ0w3fFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734818; c=relaxed/simple;
	bh=u0Pot8lrmKwaV46nhhT39ZhmWEGQ4GAJEXpf0t4Ce7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=giTf1/PB1+t0Vs9C+wWkwXHvIsAB1SZsotP0boHNKpOrh98ZYDGljoVmi063BO9iiBBaBwvnMSjjEmO+webT/v0f+UTy4ly1l4hyYuao9xadyDIdL0B/rXfI2+/oquIHMi8pV0w1+3wVpG1n3XrgR9Un4GuM97tA/JJPUqKPlcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cu1qTR2Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JH34JeXn; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cu1qTR2Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JH34JeXn"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EAB9611403CF;
	Fri, 28 Feb 2025 04:26:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 04:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734814;
	 x=1740821214; bh=7lPdAuFPzCZiXX4UqaT713X8qFwhdLXaTjFGfgLiOHk=; b=
	Cu1qTR2ZB7KXdH1tW3EtM/gf9rFKFAqxR5zS4BcQazOsVuk/ywHe6mHmjXvScjau
	VIrwQiNmqQwGFIVFnt4KPrfevDCXtHZIUMmDZ6gvnK9ZepQGbBwOoEn6SgkqQ6nX
	gjMzzK661NWSWIu/3beBh8f5mP55vE8fPaajm+Nnzso43Fz/Y19v0EOEYUdTVE9F
	83yaRJalrELJRU0nNAVspgD/0QPLw313nzynT/6mWfyFho5vFEIzMm+uvMpt0Mm5
	H1f1DRQX6PquFC5inXzO14pKzrFUT65JqIVNhbOWmJYmSwQBI150gByD6qcrIDWq
	bJMcPY+R2WD76LuV3Bmw7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734814; x=
	1740821214; bh=7lPdAuFPzCZiXX4UqaT713X8qFwhdLXaTjFGfgLiOHk=; b=J
	H34JeXnoLfSXWzuPJb0WOojICCl0Sm8wytnZek5rybb+NhAapj+zqtDsnWDRN8G2
	rUkPUTuVi4Oiu6DU01W4H2GbQoeVT5TyEMKC6VMFg5CwgZSTm1XsnxhzJzzv6u8o
	88pN72N2Bq/qcwWJVuJ4Q+w5N3tPoQQc73hZt6OfcgI8e+gyNFjHNjYkkFCNWPTj
	Q0SteThktC1s5f24YRHJVXS2xa1Lq6kyKTPdS/k+We/UxfY5Xmg9gDArzPxsb6Y5
	UIq2Ird7LivOApkZTgUljc0a4hjU6gItMuMfFcLH38swfkaVsmOsACWO/wmxKbU+
	+Y27lpyolzmoJX1fyCxCg==
X-ME-Sender: <xms:XoHBZyIE39u6uUWPj_DZJ9fud7XQeq-Bf5fwtXQbV0XTvDsrX3F87A>
    <xme:XoHBZ6Jq-Y7yVzErcfmCvvDtQCOEHOEWtU-22YUrE6nWWcskaJttV-eLhJ65t4UNR
    6h_7Dz6vxXDMmXI1g>
X-ME-Received: <xmr:XoHBZytLuLY_Hyi8NH0Zy10REku0wYBAO22rwxq8daYeQ7PGgj5odVnV7arXdcM-ulcd09TCVeQkDdVrtOposiFAIJBEhOQWsBW92c4GscmIEat2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XoHBZ3YPiDqAnfwyv4K5OY-y8Ajd5qXe9sJEAFPEgOrVPVVxT6oQWw>
    <xmx:XoHBZ5Zd3vr5y_YpYvXlpmcV6ARravckmH8JT7BIEBsfQ9r8sQIOIg>
    <xmx:XoHBZzA58XP59yWtyIU6ZUj-vnaGGzTy_eiQEzFwIBCOVtI6AyQFEQ>
    <xmx:XoHBZ_YK9OGg8OOKN0fweIKcLfrVOpnxiIdPMztaSVu2tJAkjJ4cTQ>
    <xmx:XoHBZ17h-kPnS5FIlBBxzD3gn9_PyWjMLGPysgmz3wUtDVYuHTGfkhW9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46378e1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:47 +0100
Subject: [PATCH v4 10/16] refs/iterator: provide infrastructure to re-seek
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-pks-update-ref-optimization-v4-10-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Reftable iterators need to be scrapped after they have either been
exhausted or aren't useful to the caller anymore, and it is explicitly
not possible to reuse them for iterations. But enabling for reuse of
iterators may allow us to tune them by reusing internal state of an
iterator. The reftable iterators for example can already be reused
internally, but we're not able to expose this to any users outside of
the reftable backend.

Introduce a new `.seek` function in the ref iterator vtable that allows
callers to seek an iterator multiple times. It is expected to be
functionally the same as calling `refs_ref_iterator_begin()` with a
different (or the same) prefix.

Note that it is not possible to adjust parameters other than the seeked
prefix for now, so exclude patterns, trimmed prefixes and flags will
remain unchanged. We do not have a usecase for changing these parameters
right now, but if we ever find one we can adapt accordingly.

Implement the callback for trivial cases. The other iterators will be
implemented in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/debug.c         | 11 +++++++++++
 refs/iterator.c      | 24 ++++++++++++++++++++++++
 refs/refs-internal.h | 24 ++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/refs/debug.c b/refs/debug.c
index a9786da4ba1..5390fa9c187 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -169,6 +169,16 @@ static int debug_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return res;
 }
 
+static int debug_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct debug_ref_iterator *diter =
+		(struct debug_ref_iterator *)ref_iterator;
+	int res = diter->iter->vtable->seek(diter->iter, prefix);
+	trace_printf_key(&trace_refs, "iterator_seek: %s: %d\n", prefix ? prefix : "", res);
+	return res;
+}
+
 static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -189,6 +199,7 @@ static void debug_ref_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable debug_ref_iterator_vtable = {
 	.advance = debug_ref_iterator_advance,
+	.seek = debug_ref_iterator_seek,
 	.peel = debug_ref_iterator_peel,
 	.release = debug_ref_iterator_release,
 };
diff --git a/refs/iterator.c b/refs/iterator.c
index aaeff270437..757b105261a 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -15,6 +15,12 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ref_iterator->vtable->advance(ref_iterator);
 }
 
+int ref_iterator_seek(struct ref_iterator *ref_iterator,
+		      const char *prefix)
+{
+	return ref_iterator->vtable->seek(ref_iterator, prefix);
+}
+
 int ref_iterator_peel(struct ref_iterator *ref_iterator,
 		      struct object_id *peeled)
 {
@@ -50,6 +56,12 @@ static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator UNUSED)
 	return ITER_DONE;
 }
 
+static int empty_ref_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
+				   const char *prefix UNUSED)
+{
+	return 0;
+}
+
 static int empty_ref_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 				   struct object_id *peeled UNUSED)
 {
@@ -62,6 +74,7 @@ static void empty_ref_iterator_release(struct ref_iterator *ref_iterator UNUSED)
 
 static struct ref_iterator_vtable empty_ref_iterator_vtable = {
 	.advance = empty_ref_iterator_advance,
+	.seek = empty_ref_iterator_seek,
 	.peel = empty_ref_iterator_peel,
 	.release = empty_ref_iterator_release,
 };
@@ -368,6 +381,16 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				    const char *prefix)
+{
+	struct prefix_ref_iterator *iter =
+		(struct prefix_ref_iterator *)ref_iterator;
+	free(iter->prefix);
+	iter->prefix = xstrdup_or_null(prefix);
+	return ref_iterator_seek(iter->iter0, prefix);
+}
+
 static int prefix_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				    struct object_id *peeled)
 {
@@ -387,6 +410,7 @@ static void prefix_ref_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable prefix_ref_iterator_vtable = {
 	.advance = prefix_ref_iterator_advance,
+	.seek = prefix_ref_iterator_seek,
 	.peel = prefix_ref_iterator_peel,
 	.release = prefix_ref_iterator_release,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 74e2c03cef1..8f18274a165 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -327,6 +327,22 @@ struct ref_iterator {
  */
 int ref_iterator_advance(struct ref_iterator *ref_iterator);
 
+/*
+ * Seek the iterator to the first reference with the given prefix.
+ * The prefix is matched as a literal string, without regard for path
+ * separators. If prefix is NULL or the empty string, seek the iterator to the
+ * first reference again.
+ *
+ * This function is expected to behave as if a new ref iterator with the same
+ * prefix had been created, but allows reuse of iterators and thus may allow
+ * the backend to optimize. Parameters other than the prefix that have been
+ * passed when creating the iterator will remain unchanged.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int ref_iterator_seek(struct ref_iterator *ref_iterator,
+		      const char *prefix);
+
 /*
  * If possible, peel the reference currently being viewed by the
  * iterator. Return 0 on success.
@@ -445,6 +461,13 @@ void base_ref_iterator_init(struct ref_iterator *iter,
  */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
+/*
+ * Seek the iterator to the first reference matching the given prefix. Should
+ * behave the same as if a new iterator was created with the same prefix.
+ */
+typedef int ref_iterator_seek_fn(struct ref_iterator *ref_iterator,
+				 const char *prefix);
+
 /*
  * Peels the current ref, returning 0 for success or -1 for failure.
  */
@@ -459,6 +482,7 @@ typedef void ref_iterator_release_fn(struct ref_iterator *ref_iterator);
 
 struct ref_iterator_vtable {
 	ref_iterator_advance_fn *advance;
+	ref_iterator_seek_fn *seek;
 	ref_iterator_peel_fn *peel;
 	ref_iterator_release_fn *release;
 };

-- 
2.49.0.rc0.375.gae4b89d849.dirty

