Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C814C2356B2
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564945; cv=none; b=QW54cWljySWYfMk9Nl9alV6wS6y8g9E37tgCNAVYjLDkD0nMa1ZPk0Of7BP8CbXA5AedsEzNkDhUdD7vFcKA4nG86aIhsIWFZFzAfrbmOCVaB/tUAmphp2FZ40dMtFjPTptjSV1KKnVM3R326kQuYiOGu9ccTIpLLKvlfQHzBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564945; c=relaxed/simple;
	bh=MowmkSgeFc7r6kl7TS2lvWeMMTRYbvRLLJhG1BJSpPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+YXHsJoVrZzIU9JvvIgyoCDLsezVwJOMgeFNx7fA+WEaQRoJrB8HXwHKEkbR5AJd1+J3qZ9jhaixVDGFmc+DWxYv5HEWJf1K6uJbDesz2gHIMp1W6Ipdp5NaDXs/Ukg8qAV2beUP+w9ofT7bfZX26lNBVhaCDawb5ja5TXd5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xb9SDWBr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gI6y9+Ek; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xb9SDWBr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gI6y9+Ek"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E21EC13801FF;
	Fri, 25 Apr 2025 03:09:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 25 Apr 2025 03:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564942;
	 x=1745651342; bh=5OQ/tKuOMagpv+XWI7Uj/aXXXcRjZ/hyW0aDT1xN2uk=; b=
	xb9SDWBr5Zw/eEnUEoropQMljZ6QlW1bTqAU8RPNHDSjzvdanyaEGe38NR+KqDTD
	ZjfO7YpWqTgG0ytt8oyMtJiexNd84Ggy5gs54Tkn2lv0OVhh8HFVZSksTm1pxpb2
	ZlowGkVKUKaiTbiqBNqp+Ht/5ThGPA7GFjYU+o4Q4Uf2hpvYuxsgzA6tXdXqx39W
	jKMnc5HdNhJFFMSCkwtcY+i5pWsp5iB7LExvVfjPYQpuEEM4kv25AvqeaOHThRJ/
	QjTOXBFDvrUxZ5XMjNFCLh+utojt/NXa3SJQPIyAr+7bpNRpsNPiZC/H8luybYV+
	oCv2Rj1MBf9f6vuxRaMGGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564942; x=
	1745651342; bh=5OQ/tKuOMagpv+XWI7Uj/aXXXcRjZ/hyW0aDT1xN2uk=; b=g
	I6y9+Ek6Z0Njt138fyjwcD1enOuvKpNhFrCVgpsiidBwpPQVnvU2b7D0tVDo9MhW
	N4wT/0pRp/8A7ioUy9yYSdETXm86UCbgftEJExJL1qMZogCAKsxQgQjvRIyUOmJ3
	EtQMFK0WFviOW4aTPgYlFL4Loes5SBsXes4HSJHS0PEce5AL7WJx3DR7NvH4d4fB
	Tz+r6YK4tJ14dfaugIQzrwoWl+7rFKQGNFDLo/nDXMUVLyOdtsXumRNjKAoJpN+t
	Cr/sAsDb2JkOXp/2w6xleZM6dmxDoG8rMr8NEpRo6NN83PdI75Mcyi+RrpEkVNE6
	giFs1HLG5vNy7xYbudgEw==
X-ME-Sender: <xms:DjULaDTR1r5eexQVX7SWYPvvGI5K5qYfVA_vWi58ICYtP7uifkJfUQ>
    <xme:DjULaEznUX1szTlQBZoy_tFaqASohMaCGGaRW194zTeLkQOoHh6_Gtnqia4Pp6c2m
    1JlVRE8dW6NhNKoCA>
X-ME-Received: <xmr:DjULaI0bHgsIdqp3DW8KS7aSYNbNPayrf0D2obyMjR1aSfTPkTs9xvl1mFK9BVovyyIGEZGRHDRN5AS4SffMAe3UNwRynzXgLE-Lrpca>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:DjULaDDVcbnrC0fgsRCsmCqFD9QYQzE23UlC-j-Wju3TFwtos5mBJg>
    <xmx:DjULaMiphJ9cb1HBhAtrCcw5sbw2CQ4Mw9Tpmu23Tjbx-J2CF52_8A>
    <xmx:DjULaHqWTJGW5H_-I-RWhm0QhsIZ4kkoBLKPwZzHSUI7AF965Ep5Ug>
    <xmx:DjULaHg_46OHzSpj-gDXlgdfGEUT85Brjbn_KoY10TdMzz5rX9HN4Q>
    <xmx:DjULaD-a72YQ2pPDDgsPjDZKEFc28GZgUrZAkQ_SHx04_etA2Gm4475s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:09:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d08e528a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:09:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:08:56 +0200
Subject: [PATCH v2 05/13] object-store: allow fetching objects via
 `has_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-object-store-cleanups-v2-5-63f1695b7700@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

We're about to fully remove `repo_has_object_file()` in favor of
`has_object()` given that the latter has better defaults: it neither
reloads packfiles by default nor does it fetch any promised objects in
case they are missing.

The latter usecase keeps us from converting a couple of callsites that
currently do fetch objects though. It is not really clear whether _all_
of those callsites should be fetching objects, but for a subset of them
it is the desired behaviour indeed.

Introduce a new flag `HAS_OBJECT_FETCH_PROMISOR` that causes the
function to optionally fetch missing objects which are part of a
promisor pack.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-store.c |  9 ++++++---
 object-store.h | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/object-store.c b/object-store.c
index 0cbad5a19a0..0d873868a6d 100644
--- a/object-store.c
+++ b/object-store.c
@@ -937,12 +937,15 @@ void *read_object_with_reference(struct repository *r,
 int has_object(struct repository *r, const struct object_id *oid,
 	       unsigned flags)
 {
-	int quick = !(flags & HAS_OBJECT_RECHECK_PACKED);
-	unsigned object_info_flags = OBJECT_INFO_SKIP_FETCH_OBJECT |
-		(quick ? OBJECT_INFO_QUICK : 0);
+	unsigned object_info_flags = 0;
 
 	if (!startup_info->have_repository)
 		return 0;
+	if (!(flags & HAS_OBJECT_RECHECK_PACKED))
+		object_info_flags |= OBJECT_INFO_QUICK;
+	if (!(flags & HAS_OBJECT_FETCH_PROMISOR))
+		object_info_flags |= OBJECT_INFO_SKIP_FETCH_OBJECT;
+
 	return oid_object_info_extended(r, oid, NULL, object_info_flags) >= 0;
 }
 
diff --git a/object-store.h b/object-store.h
index 5bbdaba92d1..c6055376f49 100644
--- a/object-store.h
+++ b/object-store.h
@@ -266,12 +266,16 @@ int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
 			     struct object_info *, unsigned flags);
 
-/* Retry packed storage after checking packed and loose storage */
-#define HAS_OBJECT_RECHECK_PACKED 1
+enum {
+	/* Retry packed storage after checking packed and loose storage */
+	HAS_OBJECT_RECHECK_PACKED = (1 << 0),
+	/* Allow fetching the object in case the repository has a promisor remote. */
+	HAS_OBJECT_FETCH_PROMISOR = (1 << 1),
+};
 
 /*
  * Returns 1 if the object exists. This function will not lazily fetch objects
- * in a partial clone.
+ * in a partial clone by default.
  */
 int has_object(struct repository *r, const struct object_id *oid,
 	       unsigned flags);

-- 
2.49.0.901.g37484f566f.dirty

