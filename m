Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754F3258CC2
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794986; cv=none; b=eAS1VCVCmT6KlPd9p9yqEGojEP4W+F1pAwoK670izqaz/ZWEi40zIecRyjL09PpftnnEMyeRwubhevkdz/1aj9r3MJm0yZhTDoR1wvGppkhbpZo1zfNqfBPBha0if4RSJW085C95LXAl03QneVgpAwf/p3vPd/CViqIQtdsyFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794986; c=relaxed/simple;
	bh=clLnuC4xOE2mwWGZsGSbHv7SfzpE3gPHxEJYIQPgJHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1kE+R4zG0H5V8bqhkhFb5ZXsvUvCz/fV3D4+38Iiu912nIIwc2XVm70jDCMVLM34CwjaJFNW3Zv7P/0Gulbm+jY/KOLJxNNN1C4GbjRxVJYycPfDAm0BefSsJqUB6hCmPMmY3XKipXrvkdy3PlNgalAw9xXQvqV5VgkxjlbQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JsdyEa6X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JRGirDzs; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JsdyEa6X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JRGirDzs"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7440A254030A;
	Wed, 12 Mar 2025 11:56:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 12 Mar 2025 11:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794983;
	 x=1741881383; bh=MPkifl6idFsDZJDfinOJQ5Gy8gxFzCeZeqRZeEF8W5o=; b=
	JsdyEa6X0e/P0xgO2qMGHvqFRuxFqKuvJBe2kohNq3eD24nBxqj7jmNtfTcMZAGc
	tQ0cKonevwFFbM2jANDHCBfbazm+wqOh/y+cfLbEgdmNHd0I+a12KAFgRZ5H+Wjr
	qLPDwlWkEUBfeRsRXpv8u2l87zOm+Q4Z3tSWlYO4vMytQRkI8SnswvAvj4OxOyto
	bNS2UEHEy5c22UBJcyY/oIYbObBU2gfR5NH+OF6BiZxn5fTszlbZJ3NZMB2cnqcv
	HDaPvuVA4BpUkjyqEzlWSC8AerjmLuD1uRJ4sInBctCBQMPQLlg3iuSOtVlkOxC4
	Z0O6dq+Ar2YVg7/ZHHMg3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794983; x=
	1741881383; bh=MPkifl6idFsDZJDfinOJQ5Gy8gxFzCeZeqRZeEF8W5o=; b=J
	RGirDzsOtbB2QjJ3/PE9NAr6evysOkzbOhFdEHqKUDxrjs/N45PM5BO6vE2qzSaa
	BhNR+INd/nrMk66hkh2OR4PX7hfC9AvYnqwiVoXbBSWDTqRH703/ks+r6QXN3Cnw
	NzjVwrFnIWKhg2M28wK/VEpOzJSCrIi3qvOiky91Np6LBUi/5cBN8kv8U7FkEg/y
	2GLQMlJLFDGi5jbFI7eN7qg8Yuw4NhTJi2BBd+3tPAcCk4emQKOAgdvhJspNs1XY
	MSuctr1f8caIm005dXZsKq/sbKiQneO/+hk9MAIKGFM8xb7puTsT9myq1tX02ufl
	PtgoOZ5WN8HD+H087tukw==
X-ME-Sender: <xms:p67RZ9lmyq90uZNEW4DXd481IdxWmYJIQesNk0kBI77dOG652TH9WA>
    <xme:p67RZ43clves3wpUnUeK8rq3mVaKlcAxjsDj9UiOj38N7h5NaWMrSUK7ho_vO5edl
    Hll6MhDSBH74QL-mA>
X-ME-Received: <xmr:p67RZzruvoRnZQrgZAS8de7IVlDOE_Cq-ONNhfMTc-jPMZsLE86zjM9RqGoVh4fphiHi09ddd1jlZ0GL3QEONTQn9UJDOehag9CWxY9nbNj8XT1new>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:p67RZ9n2rj0Z2Lrf_SG_Q9-eDK9gEGknjfqcGYRfkb_T2BIjwLsmQw>
    <xmx:p67RZ73UlW_Q_6sYnWwBAEFbdo-FAXGeppCTxpv5Xfh8GV_COvDvbg>
    <xmx:p67RZ8v-D6UXidRZ-7I_pjgIQ_NSXF0fVdAFllJ4zHTq8lOs5YeEAg>
    <xmx:p67RZ_VvewY0xDrvobuyfO4xGgHYB1ZZLYsykMoxwOXis1zlgYi4hA>
    <xmx:p67RZwmkVM0xYvhZ9bCbFdRlieemOqG2FDpJvQcGaln75iFVofrDvewH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c86ed10b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:16 +0100
Subject: [PATCH v6 10/16] refs/iterator: provide infrastructure to re-seek
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pks-update-ref-optimization-v6-10-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
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
index d61474cba75..ea4db59481d 100644
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
@@ -373,6 +386,16 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
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
@@ -392,6 +415,7 @@ static void prefix_ref_iterator_release(struct ref_iterator *ref_iterator)
 
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
2.49.0.rc2.394.gf6994c5077.dirty

