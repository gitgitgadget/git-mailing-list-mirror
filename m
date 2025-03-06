Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1E20F08F
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273737; cv=none; b=LNOjXwNXhe365cDhcFgTLmIC0sG47YRDU3RyyrGONHuslMR4diR9w3SGq6Z/KD+xsBdbc/YYyQdfLvC09OKuwsnrSi7vLPqaBnkBmIPyIkvuzuPEHDn4SH1yLdECCIV2n53wC4M2re6NHSKe8vsVdzfvLegJh/OVDqbC8ZHvePc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273737; c=relaxed/simple;
	bh=UJNvGhux4NX9CzNSDnsHT01rFjCpiDAdonEkYb6Em6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QF/swQi07IihW3txNEgVaqJBXnO4DMsQeGBcjsF6RXmLwC6K5uzz7c1DZcd4wu/LvpminL6t6hejFzC6mtIGZMi7iC4PHjhRdprRKDN9pQYU4S+kKnTepSyECcJe56DSc6ulQ95/VQxO0SGheHDS1OX0JGp/GfB4yi/8WgDAq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZSHphhmy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WtX8j0Iv; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZSHphhmy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WtX8j0Iv"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 44FF3254016F;
	Thu,  6 Mar 2025 10:08:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 06 Mar 2025 10:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273734;
	 x=1741360134; bh=nNm0S+yS2lk8rd7nCGb527Lalq91mMEYhFqgFYfYwuE=; b=
	ZSHphhmy5zadken4pP+QTtqqBu9CAupfFx/K9hcNfrrGUXITCjj0DHIu8jMFRhsK
	hi0jKxZPnVir1m1DHbbsCokKCaPrbXy8CPFuRoKcL+CTPHq3phf4uqfiruMGl4ZG
	B9UsT4YWmtUSax2QSUD+59QT/ZYeazIPrkH06n+K94+nl6rciOIL6y+BRz12iqGv
	+o5ikqud8pOOcTutO9PISJjupD5MfOP9w/QsZbbYFCY7BF1m2rorhEIo1nY9iWQV
	6N8YJjhqEvtXZpnksJhwjx6KRtQUOJMsrrOuXXjtRTxtJRiKIjBabjqQhe1NN0wQ
	2lSKXbpw/ltfIZ7MclMH7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273734; x=
	1741360134; bh=nNm0S+yS2lk8rd7nCGb527Lalq91mMEYhFqgFYfYwuE=; b=W
	tX8j0IvpOkXnf816wyEZkzKb3D1+0eM7VZdo5gxj6Ejs/aJ3ua5T43jlwVsLfnOh
	9h8I8VPPCfwrnYQBrvjLBXo1BbwyvgeTvzyOIQblGhgWUwgZGOCyti2kIqmDCFys
	vnTyLDaRhzy4u0hlG5CmSNKGc5SgL+euiz3RAz6K/25xQCbEDsOgrmYkbE7qO/HD
	Rs5er5ovueOCKVfwnQHZ4bwu5TTOLOBM48QTpXnheYj5wMbUjxQaxQw6gE3305Ou
	ltB8zXWYoSr6WkDNTS3xHwRU5RdXXKwr5VOpnAhJk4C9Jw9fCbm0r4nZvRYfrtdJ
	RaDQtnsq+UYCryVXws2Uw==
X-ME-Sender: <xms:hbrJZ8HJZ1Xgcn-KJlqlqzjszrMLZI4CLtjmG4FruJdRUnbnWrA7VQ>
    <xme:hbrJZ1VpVkB3-6CFuGzXHhds8DcRvxcWEXF-1ZkOZ8xOV2f9Nro5hQgB4EokkHpu3
    A1rI1akPcYG4krBSA>
X-ME-Received: <xmr:hbrJZ2KPKc9QWUl9tmB1tLQieO-vLI1ByMqh9QULX7skrjJS5oPD56c8wqQyssKAny0mGNWCknuhI2spJrwN9N7txij2yvQrBMi-VdAbrCkCkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:hrrJZ-GEv_rMz4DYjrxNec1uNkUK9KJCeMn5LITwxQoeco-w_QJwsg>
    <xmx:hrrJZyV-na4Rx5rCYll8mrp4MPFO7xQzKdK-GnEGZMNdkDYlJL9NtQ>
    <xmx:hrrJZxOQZrnHsx_-RCvqxxdDslf_Ub6dvJEFodz5XC-4gyz14puj9w>
    <xmx:hrrJZ537PdQSbomQKJLIo-Yu0fPW_mjaYhQh_ykLJ7yZOOX13Xz_MQ>
    <xmx:hrrJZ9HysI-SUCKVL5rG4M1FVkGeciF-w3WCR0VGGK_tVFfZVzt6en7u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 29bb12c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:43 +0100
Subject: [PATCH v5 12/16] refs/iterator: implement seeking for reftable
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-pks-update-ref-optimization-v5-12-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
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
index 06543f79c64..b0c09f34433 100644
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
 
@@ -2015,6 +2032,13 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
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
@@ -2033,6 +2057,7 @@ static void reftable_reflog_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable reftable_reflog_iterator_vtable = {
 	.advance = reftable_reflog_iterator_advance,
+	.seek = reftable_reflog_iterator_seek,
 	.peel = reftable_reflog_iterator_peel,
 	.release = reftable_reflog_iterator_release,
 };

-- 
2.49.0.rc0.416.g627208d89d.dirty

