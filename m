Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE227A931
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913150; cv=none; b=N1qIj6iPYx3ZexERxXRLDJq0NzyxSwnpmpFYwuycUu78JGWqU5ttgq6f3l0X70yxWTIdONfKD/q767odvfrgw4w9652M0w6vLTUwijTs1OD2eL573O3nyxqeZCV95ZSWcY0eS/PujsmXPetsepBPmbdXBEsTlCTNyv/fTKa4rVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913150; c=relaxed/simple;
	bh=QEf4eLOO8Cy6NmDLnowch0PzTRRS+8u1aoQp3DuR954=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gcVmfKBvsLY1RJkq5zp/28TRFfi34AetZWmnaeXbPA7reA2Xc6ueGfKsDEogDlWu2QIYMksEmeFS3feRd/jxC+4yZ7D1DE/ZYi+CAbkLD/3GhvXUlBmEhERGOx/+TBfYgd8pb2+oaIN/WakfNoWBR4l9fmVlHuJu1rNXn2cdJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rHRmuOSY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ATHIkxpL; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rHRmuOSY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ATHIkxpL"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A9811140282;
	Tue, 29 Apr 2025 03:52:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 29 Apr 2025 03:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745913148;
	 x=1745999548; bh=VysVkyHeMBX5oEdJr+On2S9mdIlD2POopnERyDJLheE=; b=
	rHRmuOSY5T69kgozHNKUI++o1oqh8qYvqzuAGg9nybxq6NiV91w64V8miKujxtKw
	P7SdbYr0QEjr+IZCIyG4StzYkM3h8fH7dzo1y/Xa+EL3RsCSi2LZ21yNCAltIbaT
	kUtv+ZyZxziQ1H7Ad8VckoFuOUpbjhjkuNP296+OdZ0vuyFu+4UDlz1VfspOwwmu
	VxCgAfOhZWj95qcmvkaQMJn68IW46RUTr2cTq4FGhOKqDv7SOysGAkgm5pau/amR
	aGUlnPSaqUE4+xrtKSnxHT/gG2LzBfOsHCMGFkFXl1ZXaEa77kyBWqZDKo6QSrnr
	FcgaBMnTfeowwW8LwklaLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745913148; x=
	1745999548; bh=VysVkyHeMBX5oEdJr+On2S9mdIlD2POopnERyDJLheE=; b=A
	THIkxpLXhDD4CY4rx3pf1S7JdKjGEgcCQH25wAhGbdrL4jsZbw2zHqY9uO+pmq4f
	1KWaq9SisU/CwbTgQZ+4tftnxJtPslLidkPhA7w0wXABQL5lRpvMSsRxpF2i6rkd
	YEeqH1dLT9sqefRDQPoZZM2LnU638WRj6NuOGYsqgop/H6+2D2wUIyV2zG/aEg/c
	HmpFQnlfp+KQzNKU1igZv4cJXgUCokIYOfsi16/48W1vf26r16J4FACEGp8kxR6A
	/z+0gh7A42Va1ytziEu5GqVVvwSpO7gXRgzQL+kQRpCQQWXUykvgxS4f+GtnQZ+Z
	nS9bUaeCXgLoyhxPcmsHg==
X-ME-Sender: <xms:O4UQaNgxAJ37lc-4mvRWWaHe52YsCwDhIxa4q6kWVMN7bMg2tRKHPQ>
    <xme:O4UQaCBl85AC_dnpOpP-hGd4FxXRep-iuoQk4QPZJh8sARGggBImuM4XJNaDVEgrl
    IR0QNmwYIrYTaymDg>
X-ME-Received: <xmr:O4UQaNEmXVWleEdWZMyjDcTRFRw_m0a-z9PliYlRL4jLzta7ZDW9WIoO_0sIoi53ye3h6ISCxNv9j_8qDRgrvBtBHbDUcfokeDjf3Fh23kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:O4UQaCS5GFUSx3dlrFcCiXsZemV3_viV0bQuJ1R6QiLZxlbNBVEGsg>
    <xmx:PIUQaKzwUJNBFm7f3ruDo7oYlkvZZ1aaYcZ_n24HFfRC3PRwSlBznw>
    <xmx:PIUQaI6dJ_nW4RsdjJacJBGH2rwa5zag9RvFTssGxeLsz4od7-qJCg>
    <xmx:PIUQaPw68YJ_QWdjispUNDGRkfyJRw2i4auHIN7HzsfJBQwS1B06Ig>
    <xmx:PIUQaNt45KFRfdnJNUz56QYSXzsG3DQZxTacj09I_KXIlw6TsRvavCxO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 03:52:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 47d2362d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 07:52:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Apr 2025 09:52:19 +0200
Subject: [PATCH v3 5/7] object-store: allow fetching objects via
 `has_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-pks-object-store-cleanups-v3-5-42902bad09a1@pks.im>
References: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
In-Reply-To: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We're about to fully remove `repo_has_object_file()` in favor of
`has_object()`. The latter function does not yet have a way to fetch
missing objects via a promisor remote though, which means that it cannot
fully replace all usecases of `repo_has_object_file()`.

Introduce a new flag `HAS_OBJECT_FETCH_PROMISOR` that causes the
function to optionally fetch missing objects which are part of a
promisor pack. This flag will be used in the subsequent commit.

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
index 9dc39a7c91e..f0e111464c2 100644
--- a/object-store.h
+++ b/object-store.h
@@ -262,12 +262,16 @@ int oid_object_info_extended(struct repository *r,
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
2.49.0.967.g6a0df3ecc3.dirty

