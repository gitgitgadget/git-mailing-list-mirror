Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB732233D86
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807436; cv=none; b=hcSQUjP/mzCQwMKPQvmvuBAT3wixag0iBuM4jSo08iqEk0fyAMIGGUHLZcvZF3YNI7qGXchrkUY3vHJMJd+JImQmE+ytOeQ5dN1tFP0+0Zs7eIGn+oHUvTuHfjKHsDhzFfApQkVydoeJieQEy8YpFNvxMcjham1Kf6BFnz7d46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807436; c=relaxed/simple;
	bh=vXe6dsYH/UJ66Dzrv6IQh6R1vyj0gK6uCqakXTjoVmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWfhJ+PwnuWqCuUQ1AKM3jzd8rnlKrxICWEX0Ye4ZirdZgsj9yMSugF28cKpeGsLlxwNp8877x3U68bDJ4S1i9xt9XcsX5H/QGct++isfz978Y26D1mYRu6+48PfXgNh078JVLN/dJHUq3XTfebmo97bG9DP2Q+4KiHs3KgqjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=byY3TT5G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W1WQRtQj; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="byY3TT5G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W1WQRtQj"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3BE021140185;
	Mon, 17 Feb 2025 10:50:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 17 Feb 2025 10:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807434;
	 x=1739893834; bh=hzRBof5FcLcH7RaVPec6qrcrnIKPePWwq9W/gB06RhI=; b=
	byY3TT5GCIyImxPVJWBEcA/LXhLbvkjaAzhN1n7kBwVhrkApsvsyJ1dRDAyG8RqU
	7aazHYG2e9Gbq0hEIrEtHFRGgAWSy5stKuEMXehu9+b1PMgE2kBkl/6ibSlnUcat
	46u1uEEtDPBfskMD2EjORMmIW3G78cuqH3FudaDnDvrnU6ylueYNFHEGRqD3Q7G2
	FD5DbkPSwVqzUnOgtaujkUGAq/YH5EZc8AF+emWlNc+9FtJ7BEzjDDQow9v1TdTa
	EI97tMQYVI+vvIqPsLmAhUS21PkU+erDiOG0xTSN63vroUU3ajYC9x8i4ZVw01tG
	pE+yb/3CIcjsinkX0lMwWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807434; x=
	1739893834; bh=hzRBof5FcLcH7RaVPec6qrcrnIKPePWwq9W/gB06RhI=; b=W
	1WQRtQjuUT6yZjEbSOnGXF5+wi5j7jyqfsyFZjNBBgMn6yzPudpW/Ttz9aU8icwS
	5j36iScxchUy3ejhuUu34sla/cEo6T2MipClwP4IoMN94REYwshRdDCpRa/ad3sx
	OXvfkCCX4CyfXYUNUc1qVh/jCPuwy4xf4ClsBQngTXksSiZdiomEzc9J+stYnQ0p
	EvAYZK0xI5Pwg0XK/iTdExtkjp/6YOzD/3qf4NqcjRm2m3pR7uaWfnAyzF3eexP5
	Us8aN5Lh+nUyQB+z9CgM83lhncf8GmMELQaHxmVTubGLvZS43ifazN1CTDyAGE2N
	8DyLzFyXMr0R4CyUUQ6jw==
X-ME-Sender: <xms:yVqzZ0eSokCKv9nLicLg2dHFn31hpU8k1D7-dtpaH2TAXwR8fyvo_w>
    <xme:yVqzZ2MuDkgW2s8-07KKMaM_kEvwGC1nIMxU6HkUU_rURM6p9lwQZiMt4RzuObwB1
    Ldn0RcnslRoOXgbCg>
X-ME-Received: <xmr:yVqzZ1gKWwCsMTTIXhqew4kAiFosmy87o9_wOmPsQOdF0btZpBxrat0c6dkL3wnl5RVtlFxa2ZQ0MpOHGS11Wfd1gNWtp-CEen8Zsp4mX1UNCkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:yVqzZ5_jERCjHEud06Hek6p3AQ5_v4KvGtNrvRPXI1q_9eZjMeTFyw>
    <xmx:yVqzZwuJ9t4edVXS-PYWc5NrNhM9lq3Nk7al1aHj98UKFj2_PaQlpw>
    <xmx:yVqzZwHYIs8Jvo96nnOutORNNG7VF1mLxMv-hieB5pNJfm7kQQBncA>
    <xmx:yVqzZ_NvcPGmHOAJYJMo_W0-rNEesXodkVWRby-tUZiHGElTDHbVOw>
    <xmx:ylqzZ0gXBUJeiCD4lWYKhqAvU45Rmnuh0787sU_1WMz4vfq339twwmh1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8b9dbc94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:22 +0100
Subject: [PATCH 08/14] refs/iterator: provide infrastructure to re-seek
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-pks-update-ref-optimization-v1-8-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Reftable iterators need to be scrapped after they have either been
exhausted or aren't useful to the caller anymore, and it is explicitly
not possible to reuse them for iterations. But enabling for reuse of
iterators may allow us to tune them by reusing internal state of an
iterator. The reftable iterators for example can already be reused
internally, but we're not able to expose this to any users outside of
the reftable backend.

Introduce a new `.seek` function in the ref iterator vtable that allows
callers to re-seek an iterator. It is expected to be functionally the
same as calling `refs_ref_iterator_begin()` with a different (or the
same) prefix.

Implement the callback for trivial cases. The other iterators will be
implemented in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/debug.c         | 11 +++++++++++
 refs/iterator.c      | 24 ++++++++++++++++++++++++
 refs/refs-internal.h | 23 +++++++++++++++++++++++
 3 files changed, 58 insertions(+)

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
index 27ff822cf43..5fade7e8408 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -325,6 +325,21 @@ struct ref_iterator {
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
+ * the backend to optimize.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int ref_iterator_seek(struct ref_iterator *ref_iterator,
+		      const char *prefix);
+
 /*
  * If possible, peel the reference currently being viewed by the
  * iterator. Return 0 on success.
@@ -443,6 +458,13 @@ void base_ref_iterator_init(struct ref_iterator *iter,
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
@@ -457,6 +479,7 @@ typedef void ref_iterator_release_fn(struct ref_iterator *ref_iterator);
 
 struct ref_iterator_vtable {
 	ref_iterator_advance_fn *advance;
+	ref_iterator_seek_fn *seek;
 	ref_iterator_peel_fn *peel;
 	ref_iterator_release_fn *release;
 };

-- 
2.48.1.666.gff9fcf71b7.dirty

