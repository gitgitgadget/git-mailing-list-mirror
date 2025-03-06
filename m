Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D352C210190
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273736; cv=none; b=JbmCnLI6Vd2n/HEQnZR7gEvNZv3EbkAVK2B8Pi9j6Cvj873e2ZrjMehRKXZiCPNBEjoyqcbg4YdGLT/IZr/9wYob5Xocq1eFJS4lNDe/Kwn+e0V8cB1j7kKWBEiZmNvrt9RxsT+vuibidyFTUMnEGfkgEDG1D9bfY8do2hsIfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273736; c=relaxed/simple;
	bh=pv8ud+1MjJ9xodgqkR1kb4AuamYpEC7kMXOqprQGKcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3oT2lqSU1UZ6ahuoH7SoDvbtBhnZg5AttpVXw6Nb9loadpbXEw92M6vHplvPDKgkEL5x0ymiS3sbQwCKgi4ZUkDe+/qvGr7Hfzmccdhi5iZc4kU6cH/eMC/QuGS1KN1qquxntYF6PwZI+8b8ZbCEhEGgWc3px8bJVzxVmLNNio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IymkYseg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WmyCEKME; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IymkYseg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WmyCEKME"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id C027911401DC;
	Thu,  6 Mar 2025 10:08:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Thu, 06 Mar 2025 10:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273732;
	 x=1741360132; bh=vKCwJZlssfutLO7eX3AOqrMh0+EqAiVDpdgdMz3CBVQ=; b=
	IymkYseg4j73MXpDKWLJtQQC3gjN4kbeKTJ502Y+vj2oe9c8IeX7OSksN9XpSawP
	8JWI03Op0zwO6ODLdGKJk8A5XNDy4T/Vb9pA+Wq6XtUH0vVj/qcS0tkX1I9tP7p4
	MDOzYRvxeEjxKXj1PRJ1HjFvkgYXzFC097y8cefdQFsOkj2dfXnr87vSJdu9JT4G
	M2b4pTh/L3SF2GPO1qyKKQG37rGvizBRvppJ9O/b2yz6T7RjpYVYJd5WNufJx9lN
	y5TzNYtbb2seLtwfSFL1jnV9OUJ1ijaE+ZyQIJmmVVfztTa9wE71Wj0ymLVURECt
	2NrulV2CCmcmTgjngPCALg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273732; x=
	1741360132; bh=vKCwJZlssfutLO7eX3AOqrMh0+EqAiVDpdgdMz3CBVQ=; b=W
	myCEKMERV2WZLAY4EuANN9jB2qCRjD1OgOn4Ga976eaTVn9nD8BygCK2Jme2Cgxt
	8I7dmb47cBOsqW2r4HfvXFsg+/e7oiygeGXc46bYv0dQgMJq0+8rVWumJB9/+TZT
	B2695J9AxGgC+93VJrOmEVj7fXlZHV84YpCmbpIYfzi+yoZ4AMn7tEKm9t7kALva
	uMReP2EnOXLkErp9dCY4HPay1p3qvEA+Nz6SZOVd7zrpjRo/x5CJlecpkf5JkHRU
	KR1lsDEgY8ScHI64HZKQ3y8/rnuKhwvy37Qe8zK6Xpi1t0/F1rieIyu+94/pwweu
	JM/2ZvsjmelGq22gjFK0g==
X-ME-Sender: <xms:hLrJZ5rKKMT7YFOM513xajMH4YAn2u86cGuZ_BHde_4NZs2vZJfpow>
    <xme:hLrJZ7q7UsXWt4kGEqLlRVPvIb_lCKgcL_QNuIr7YSvgYksq4-p483i80VHxqJmbJ
    KWXn3OSOacg7LGVBQ>
X-ME-Received: <xmr:hLrJZ2Niu6tqwv3rDvrsEk2lWHXKyEP-euD0CWtApOJkZjMC6pLoMluZNgeyJ6RJH4tuBOkpNJuk6HTkViJy2KyRDOC8fzPH0ktKWF2LgK2ppQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhhvg
    hjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:hLrJZ05CVUsO7vujkaOrZD3XP1buY_09u_27-X88qz6m4ke06cTymw>
    <xmx:hLrJZ44TC61czL5d0EMI4GjcW5tpqnoLpOnvv7Gsn66v2XJ9zmlsWA>
    <xmx:hLrJZ8iDF01BhKrxiDnerKVY9eeaHKvDD22uw98eFdqc_cy8BepEgw>
    <xmx:hLrJZ65dZlIQDnEI4SA5Zm9iHwtmlrrimLklehyeMzzAb5hXlivsng>
    <xmx:hLrJZ3aoKoJkwpv4BOgEII7kuk6TZvjkWhXqK-qYQ2iqhZ7UXE-HAPpF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eb443f1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:41 +0100
Subject: [PATCH v5 10/16] refs/iterator: provide infrastructure to re-seek
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-pks-update-ref-optimization-v5-10-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
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
2.49.0.rc0.416.g627208d89d.dirty

