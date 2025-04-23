Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84D26F45F
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394518; cv=none; b=TmgxDkRVIaHaWXq+KmLpbajZbXrryRc29eMuRdCgfcbUQfdYNuqoBFOmjrPuf3063dABAmGbBDB2Vx12YRwjw1XgJQbRXqPrN0qsxIFkbbsOyZp5t6rYq8BzO88Zct8/nEFhprdLDU/nYlgrWeH6gyZ9ucvoEvEilcmNmvWjuIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394518; c=relaxed/simple;
	bh=DTvIGeAqYKaoIODKitoEPhn+InOi7TLOyGxFauN5Wng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlk6EuePFSA394pjc9YsA6XOn0Ob4V3DDijX5zh6sNTmSUPjarPtD4HG6ZCawfjP6Dr2VDd47Rld0o3PN3LuD4HCEw9NT2KptIai7tLFLxTJn17N+aM1xDQws6zAHfto1WyoQ+UxeQwCTsvgeLzJLArR+07GCDLh74kAvJTK3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JCHOqHKW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hL/+1WYj; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JCHOqHKW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hL/+1WYj"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2515A13801A0
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Apr 2025 03:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394516;
	 x=1745480916; bh=DTkAGtZJJLWXA8zhGTR+ew/+MigYWjQWiYAcevIhS3Y=; b=
	JCHOqHKWYW5+CuwK3idISZ4ZpH/Vt9EWuc/5PbouqmR4zSQ3boiuvqy6HadT8ek5
	W+297h7NeA7gT3NIRwPwYkVuzllDSAAnDfcLo5MaZWLcg/jjdspA+gnJtCiZMACm
	hYszWTh6G3OXe1V7d0dhm8Hil+5UBlsHdtYKffF672DODIGi2gLJQIbiuu90fYhx
	WUCbDLLQ3nieA8bFEpt8xdJ1rITKZiDsP60wruLVV5RkQpF3Xne+RbFrgKHtGQ8C
	ZBv43bE3mQgipoIwsm58LZcEBvY22K/3swWZDqJJ49Muv7s1n+PFdxdht/Rgkbcd
	w9AtwGbhx/wZ+rwP58q1dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394516; x=
	1745480916; bh=DTkAGtZJJLWXA8zhGTR+ew/+MigYWjQWiYAcevIhS3Y=; b=h
	L/+1WYjaG6eDF67rYlqfENeOpXs6T9Ac2pTMSuH2CaY8pvY0XUJJYSgRanrbhW59
	4144rNsLgY8czeFoVhuq4ANUSabdAyARyvAtezJ07/K5YK+/UNP5Y3PQeYvnG65A
	kx5eKDMb+h8E+Z2BF8qvJ4qEEXc4gcQiqyrU0pO7BLGyivSlrVFy5AljfjfHJUXO
	5qziB4iMV5PpTzYs2jRJ8IZceYvNPuFBcmubWUDNWQkhqytPsCwLKVVNkEs56jW2
	ILibHYcwu9pyl8XbjttUqR5/gSuxfUraKNPf8eHghy3/y+Bf9QKwH9OpMDTBRHr7
	fXJG7bRtDg0xCJLkvDZ5g==
X-ME-Sender: <xms:VJsIaDrsyVKF4C7uIWQusHvU0E5U3A2FBmBXKrwXntdE9whnqtwEUw>
    <xme:VJsIaNrMowOkNqeR3GOIFskXTcfQ5GKvIkahD-cjPG_SoRDQKh0YF3z3J-iZu3CUh
    qUs_2-MmMLYKmuf9Q>
X-ME-Received: <xmr:VJsIaANtIpMGOEkLF80ZrNImjwqR1yWKYg2qAHGhEaoYth5qQcQ0SmEVLrOX_jNP2ZDKCpJ5DFHiH0DDRbx85IVc_oXByPjrjwSXFPtZSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VJsIaG6IQPF05rFS277kpY1ctxyx37S3vPRgPWHu4xFYxjRaR3Ra0A>
    <xmx:VJsIaC6vuBiNDiVQ5rIlbhIKtK3Ws1OeTF6nZZk3A3qAcUCJqmpyQQ>
    <xmx:VJsIaOiGVFeNi8wWthNHRteEZdno8dSVCHpr3HKZyj8iXN_i7mnmMg>
    <xmx:VJsIaE5yryC2666oX2Hs9goWnjW3UkHhhBYpRqct_sqTOrhIB-jARA>
    <xmx:VJsIaLGgYPEeS5uiMSGgWfxRbkZtmpgBd69Uett5DobrQV1rzCRcI4u8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5cb0005b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:23 +0200
Subject: [PATCH 13/13] object-store: drop `repo_has_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-13-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In the preceding commits we have converted all users of
`repo_has_object_file()` and its `_with_flags()` variant to instead use
`has_object()`. Drop these functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-store.c | 14 --------------
 object-store.h | 17 -----------------
 2 files changed, 31 deletions(-)

diff --git a/object-store.c b/object-store.c
index 2db34804e8f..2f51d0e3b03 100644
--- a/object-store.c
+++ b/object-store.c
@@ -949,20 +949,6 @@ int has_object(struct repository *r, const struct object_id *oid,
 	return oid_object_info_extended(r, oid, NULL, object_info_flags) >= 0;
 }
 
-int repo_has_object_file_with_flags(struct repository *r,
-				    const struct object_id *oid, int flags)
-{
-	if (!startup_info->have_repository)
-		return 0;
-	return oid_object_info_extended(r, oid, NULL, flags) >= 0;
-}
-
-int repo_has_object_file(struct repository *r,
-			 const struct object_id *oid)
-{
-	return repo_has_object_file_with_flags(r, oid, 0);
-}
-
 void assert_oid_type(const struct object_id *oid, enum object_type expect)
 {
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
diff --git a/object-store.h b/object-store.h
index c6055376f49..2330374990b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -280,23 +280,6 @@ enum {
 int has_object(struct repository *r, const struct object_id *oid,
 	       unsigned flags);
 
-/*
- * These macros and functions are deprecated. If checking existence for an
- * object that is likely to be missing and/or whose absence is relatively
- * inconsequential (or is consequential but the caller is prepared to handle
- * it), use has_object(), which has better defaults (no lazy fetch in a partial
- * clone and no rechecking of packed storage). In the unlikely event that a
- * caller needs to assert existence of an object that it fully expects to
- * exist, and wants to trigger a lazy fetch in a partial clone, use
- * oid_object_info_extended() with a NULL struct object_info.
- *
- * These functions can be removed once all callers have migrated to
- * has_object() and/or oid_object_info_extended().
- */
-int repo_has_object_file(struct repository *r, const struct object_id *oid);
-int repo_has_object_file_with_flags(struct repository *r,
-				    const struct object_id *oid, int flags);
-
 void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
 /*

-- 
2.49.0.901.g37484f566f.dirty

