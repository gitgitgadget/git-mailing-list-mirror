Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8F257AFE
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794988; cv=none; b=VJ4GxZtHo7lZspiyB0iqMd79q9Nq7nHKt11cqF2fwTKxiFwhvVgweboGAStgk5Yo5bhXZaK4Vana4dslNGppyXrlJtOkpW09XloKjhD/08CGeLuFRWdK2GZwQItPfVc3d9zs3rvrwRjzOELPoI9+8B/XoDT8Yh6meo/2pFyWNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794988; c=relaxed/simple;
	bh=2Rs3T6Nk4x0Y4+Jzg+zwoSOY36EXw5B47DxFCxrhLl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PtcNZlIbIAo3hLukmspjiUmr8kI0uBugY4VlyAFQQXW8c3mdjo2/ApUfTzyV57O0/pF/Wu7uIlIvr5rz2hqlRRzcvi+AghgQmxpR5sCTCChGDDa01f+H1wTb1gxWtCbrhpP4OVK+EYKu3O/SNWQjKdNZ9+ui1vwixZxjhNhmuRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sf/HqO80; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IEKi8/qr; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sf/HqO80";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEKi8/qr"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 65D0E2540278;
	Wed, 12 Mar 2025 11:56:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 12 Mar 2025 11:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794985;
	 x=1741881385; bh=sK48vln2Hog3cXv/L4ADv8rzUxxzh7VHq1CkACqojTs=; b=
	Sf/HqO80AqTpo6VQNl5TSaGNdWIDeTcyFvq682KJm+6Kt052OdpYflqfWydz7M+a
	H0mNtbbcPmwXu9LdXHkJ5wPhe34i4w2zyu9gYnR+kBKylw8fTcf8LFMOGsu3U6vK
	g89atSNPAeAKvX/214iNNExf8A9Pqe/zB694C2EqcLhGmOw6+XFPlA1FNTETX/c7
	QCykbxLlJaOLCuh8LJT5ecEvfHGr7AIPh4Edx2/vI1My47ewjr8VZeCvjkE2594p
	0HO9fIEq6rGDOhzx+OWSk7tweCztCy3kXU1Jjiev3aGaR4fX6g+VDbdClZfDGtVw
	i/agWvToMMj1hyeolFlA6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794985; x=
	1741881385; bh=sK48vln2Hog3cXv/L4ADv8rzUxxzh7VHq1CkACqojTs=; b=I
	EKi8/qriCKSiiW+mZ6ztSKWJUiBuIbQo06AmODG/9PrdOlU/BOzsewtDa8vNaJWl
	j2mlPt9dFKXdSy44mDvQlMh+PRa6NISDyWPr7u9/1L3Xrr5ewWHZwuIESA8jRaZ5
	XfxG1YDCDBMkomlfF0WSTRNWoKAjIm2Kpn0UHePZP3tp4sUXU2TbV5xY9Ljhnr2g
	sOeV1bnCbqE+7rMjKIS5xvpTHM9q/uOFWqNowvwC9tQseXV8ffJJ+PyUaPhbLUYs
	WmU76InbFRiStll0jmhCcNuiVY3DUocAhPaHajiEHIfEvwyGjRvmxWqIlIHx44y1
	5K86e7HATnDUEMxsM6uHw==
X-ME-Sender: <xms:qa7RZ--YKXJ5ZYeOan7XK8hMHHu-2b8QeLlhwo42EMy_W12_qs9uEA>
    <xme:qa7RZ-vzZoHJfzQPE-zby8UKDWdHqxIDsESs_FImLcVeJSxEM3Ae00X7oMoRIDlBH
    UEL2zKxzQu7HcwNkA>
X-ME-Received: <xmr:qa7RZ0BV_zV3a_4dX9uFQOZQN24yD3b3fpelG8eEZLG43RlMlcs8PkkAJ8mJX6qI6Z0bAEafLodfyotiUvRfzZ0m301mg2KZrDFWJRtTyxX4D7o0ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:qa7RZ2c4MsBgAd3co3llqJOO1JM88B5lciTpYeJXj460xbe15jdqew>
    <xmx:qa7RZzNSRoH_cAGZsulQY8-ZuY5alcB6w2ojyYRBv3CzuE6Q4PWyZA>
    <xmx:qa7RZwlutbr1u7cIgZ2frWKQ317hkiE1FAvWULkH05sAJtG1RIEUeg>
    <xmx:qa7RZ1uBBTHFLWeFDEd6CbFT2838ZFGVx83t0GClqdZYn_lWsw08gA>
    <xmx:qa7RZ-dO8UH112ut59EVfuYoL1yWJw5j78CXSWlIvze07zU8s7UBA0VZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 601addad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:18 +0100
Subject: [PATCH v6 12/16] refs/iterator: implement seeking for reftable
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pks-update-ref-optimization-v6-12-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking of reftable iterators. As the low-level reftable
iterators already support seeking this change is straight-forward. Two
notes though:

  - We do not support seeking on reflog iterators. It is unclear what
    seeking would even look like in this context, as you typically would
    want to seek to a specific entry in the reflog for a specific ref.
    There is currently no use case for this, but if one arises in the
    future, we can still implement seeking at that later point.

  - We start to check whether `reftable_stack_init_ref_iterator()` is
    successful.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 57d8512fe80..6a60b26d1b9 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -547,7 +547,7 @@ struct reftable_ref_iterator {
 	struct reftable_ref_record ref;
 	struct object_id oid;
 
-	const char *prefix;
+	char *prefix;
 	size_t prefix_len;
 	char **exclude_patterns;
 	size_t exclude_patterns_index;
@@ -718,6 +718,20 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_OK;
 }
 
+static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				      const char *prefix)
+{
+	struct reftable_ref_iterator *iter =
+		(struct reftable_ref_iterator *)ref_iterator;
+
+	free(iter->prefix);
+	iter->prefix = xstrdup_or_null(prefix);
+	iter->prefix_len = prefix ? strlen(prefix) : 0;
+	iter->err = reftable_iterator_seek_ref(&iter->iter, prefix);
+
+	return iter->err;
+}
+
 static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				      struct object_id *peeled)
 {
@@ -744,10 +758,12 @@ static void reftable_ref_iterator_release(struct ref_iterator *ref_iterator)
 			free(iter->exclude_patterns[i]);
 		free(iter->exclude_patterns);
 	}
+	free(iter->prefix);
 }
 
 static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
 	.advance = reftable_ref_iterator_advance,
+	.seek = reftable_ref_iterator_seek,
 	.peel = reftable_ref_iterator_peel,
 	.release = reftable_ref_iterator_release,
 };
@@ -806,8 +822,6 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 
 	iter = xcalloc(1, sizeof(*iter));
 	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable);
-	iter->prefix = prefix;
-	iter->prefix_len = prefix ? strlen(prefix) : 0;
 	iter->base.oid = &iter->oid;
 	iter->flags = flags;
 	iter->refs = refs;
@@ -821,8 +835,11 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 	if (ret)
 		goto done;
 
-	reftable_stack_init_ref_iterator(stack, &iter->iter);
-	ret = reftable_iterator_seek_ref(&iter->iter, prefix);
+	ret = reftable_stack_init_ref_iterator(stack, &iter->iter);
+	if (ret)
+		goto done;
+
+	ret = reftable_ref_iterator_seek(&iter->base, prefix);
 	if (ret)
 		goto done;
 
@@ -2014,6 +2031,13 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_OK;
 }
 
+static int reftable_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
+					 const char *prefix UNUSED)
+{
+	BUG("reftable reflog iterator cannot be seeked");
+	return -1;
+}
+
 static int reftable_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 					 struct object_id *peeled UNUSED)
 {
@@ -2032,6 +2056,7 @@ static void reftable_reflog_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable reftable_reflog_iterator_vtable = {
 	.advance = reftable_reflog_iterator_advance,
+	.seek = reftable_reflog_iterator_seek,
 	.peel = reftable_reflog_iterator_peel,
 	.release = reftable_reflog_iterator_release,
 };

-- 
2.49.0.rc2.394.gf6994c5077.dirty

