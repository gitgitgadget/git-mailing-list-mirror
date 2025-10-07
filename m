Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC41A9F8D
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834750; cv=none; b=ahI2TI6HeTDf0LbFf3pdvgjhnOhlEwoPicYg0BrSiq7q/PrFfd54dNQVLgkPVEWnJnxd9iFKLYUInqXyekPWJNnDQbZMGZBVZ1Sq5i2lxDyd4F3qxtO8VRa/awqRi85sY0G8abMiK+ti1/5FyLhIz0AJmMe403E5NffzOuau5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834750; c=relaxed/simple;
	bh=Fo8wzBhUn0pVe8k7TrnD7Gy80TgWlAHznIRYm2d0s/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKj3Fe6r14qwiQqWL/ceSrpsLBqLV5yE8YO6grXhPe/B2JIpLsQ+IhrOeaIHEtNJgWVr+TQncXeEAR3TkgK5JQOdUJA4oGJ7qyDDTJPxSlDRvhjO3MHSqUR+J4AQ6dbNylhQRRdyhbQdTAakNLLmxUb7ZhGmkrJX5Te1RBNVMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EhrdUcwX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Od+NZnwV; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EhrdUcwX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Od+NZnwV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 901587A0084
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 06:59:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 07 Oct 2025 06:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759834746;
	 x=1759921146; bh=m0hoRN3eN+plq+264+M017ftRputyK0OA3QCuZVK5ow=; b=
	EhrdUcwXhpEB6p3jDX3cJyEU93AaxX0fWPo/99y+vuTL+FoRXya/QVVgyio/ZSle
	DSls7XQTba1FGthKKNAd+4rY+VsCxBPz80n1fPPf2Ylq6F3aYDgxzort65+kq9ZB
	gQ24FoMbYu/SJ3PHjgwfFuwKy7hsLLeOm1d8Orv33kD2avAXbPgh0UOpEoMAICFZ
	b3qY0Mh0ZTPVMqeMQ50DEvYAdWMk03Lsjs3ZQdgFW9lYF+1SHhthcoFvoPlLz9yc
	eTcClNid7L1+qK5GvEbFGOP/TMIWDaF7NSOCVQrZBN6Oum1PJwwkYAR3TUa5CBqV
	WIgjIQb98GB1Zq+PoMz/7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759834746; x=
	1759921146; bh=m0hoRN3eN+plq+264+M017ftRputyK0OA3QCuZVK5ow=; b=O
	d+NZnwV2p2EYk0a3gSuCMficmchCS2mhxVohYVefIEyPYwaV++0FROCswnG55GoU
	I3rX8Zcw9IBq1yQFQTjNla6sZv3qO60g90TKP72gXdgoLLSKmuv4Y/lET41p/3lL
	S/L5uPsgx5QC3keZX8UDphQcoUD2BuVhQiQNnLH7/JM0YBB/slC/f2NYgYxbCJLW
	oq4Ks0iVzvGQOAfdMWmnofWo+ZxW1vqRCH0//XOGHlEzZSdK1w9Owrtwbwp5NqHH
	itOIYwBZMWA/7cO90VqkNVOrlYuUgKNiPhJgc+no+RobU2skc3/ihQyYmHNRmxOw
	X+E3VqXw59K9K3eUyIqZw==
X-ME-Sender: <xms:evLkaH2mYyDZzUuS0iXHcprvpfl15KJSCQ8LWbGaq4sCo2qITqQymg>
    <xme:evLkaNBF3tkOIS2P81Mf8jHcr9NvN4XDvRirU6_dMvNgGVbFGZbTYDIPDEADNT7vl
    RbGfazbw6hhmmHevlhZ6Xf-6ZEFGqEEjQjKDqDPu14wriAVJe5R>
X-ME-Received: <xmr:evLkaNgEP66EUV8Goiw4QdoQAQR3YhltnSHXmcinlJws81UiyEn6hGmkMZ9K2_h-m0pCVNTmfFHjovfakT22jBWTOE9F-10bnx0zqWTuv3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:evLkaB-hxP4HLB_3qIt9MY_RuRmVQ8fYoY51hAMUAYKYY7aqjOdzjw>
    <xmx:evLkaJ9pMy4JJhgs1OzbPZIEh0h6OnqgMv8bmMNFTKZByFiE_HD1ZQ>
    <xmx:evLkaKC_B9-iI9jTjPgzVzynkU0uGWi7fUR0Iipe3Xp2OQyX0R2Scg>
    <xmx:evLkaJxg9WIYkVvch4PjRH_ssDbPHbQ9ZvARq7N544tOSRDqI8kGUQ>
    <xmx:evLkaFF2Lz3DD8beTqWPXyKS6lLWe9gPH1_eE1jkr30JAvVGKtHYSRob>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Oct 2025 06:59:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b9f92b6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Oct 2025 10:59:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 12:58:40 +0200
Subject: [PATCH 03/13] refs: refactor reference status flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-3-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The reference flags encode information like whether or not a reference
is a symbolic reference or whether it may be broken. This information is
stored in a `int flags` bitfield, which is in conflict with our modern
best practices; we tend to use an unsigned integer to store flags.

Change the type of the field to be `unsigned`. While at it, refactor the
individual flags to be part of an `enum` instead of using preprocessor
defines.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/refs.h b/refs.h
index 2b24a3d997..8f484e2ffc 100644
--- a/refs.h
+++ b/refs.h
@@ -333,27 +333,28 @@ struct ref_transaction;
  * stored in ref_iterator::flags. Other bits are for internal use
  * only:
  */
+enum reference_status {
+	/* Reference is a symbolic reference. */
+	REF_ISSYMREF = (1 << 0),
 
-/* Reference is a symbolic reference. */
-#define REF_ISSYMREF 0x01
+	/* Reference is a packed reference. */
+	REF_ISPACKED = (1 << 1),
 
-/* Reference is a packed reference. */
-#define REF_ISPACKED 0x02
-
-/*
- * Reference cannot be resolved to an object name: dangling symbolic
- * reference (directly or indirectly), corrupt reference file,
- * reference exists but name is bad, or symbolic reference refers to
- * ill-formatted reference name.
- */
-#define REF_ISBROKEN 0x04
+	/*
+	 * Reference cannot be resolved to an object name: dangling symbolic
+	 * reference (directly or indirectly), corrupt reference file,
+	 * reference exists but name is bad, or symbolic reference refers to
+	 * ill-formatted reference name.
+	 */
+	REF_ISBROKEN = (1 << 2),
 
-/*
- * Reference name is not well formed.
- *
- * See git-check-ref-format(1) for the definition of well formed ref names.
- */
-#define REF_BAD_NAME 0x08
+	/*
+	 * Reference name is not well formed.
+	 *
+	 * See git-check-ref-format(1) for the definition of well formed ref names.
+	 */
+	REF_BAD_NAME = (1 << 3),
+};
 
 /* A reference passed to `for_each_ref()`-style callbacks. */
 struct reference {
@@ -370,8 +371,8 @@ struct reference {
 	 */
 	const struct object_id *oid;
 
-	/* A bitfield of `REF_` flags. */
-	int flags;
+	/* A bitfield of `enum reference_status` flags. */
+	unsigned flags;
 };
 
 /*

-- 
2.51.0.764.g787ff6f08a.dirty

