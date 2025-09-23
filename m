Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDD2321274
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622650; cv=none; b=tQCKPb4FfiEjiup9S7VOXj9jDSIoXoA+moL3XeITmhMtTddnAbM8OXB+q14VOX0iL9QK5ayeULQhHgEE7+etOqMCP9y3AaUTaCU0/NJGPz4Led1nO3O4MBGoMiTULpar/fjGtuj0TzPyjN1DfZqb3oH2BzaviUsLqyEQN+MBtao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622650; c=relaxed/simple;
	bh=kQdBBMPMviC5fsrF7X74Y5dDU+kAzztD6qcPjttlwOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KtaDN/awUvMPp8ky9CAXxDeMuGifIFTUYdqSutQ6IZMg9Is9o1XLsFRoA/DptfygkihjM2dYNOVxkvw43TCP0O6x0OxaFM9I1GxT6oeI6cKCfO47U9wvB13DisReVxMiu7s54ub05mY7h+FPp9jzA8hUEM5gkkfMropBNm5YZ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NiMBdp5M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cl7KSzXR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NiMBdp5M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cl7KSzXR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1F0C7A01ED;
	Tue, 23 Sep 2025 06:17:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 06:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622647;
	 x=1758709047; bh=FtsG2kAwa2bhk6ZOqa3pZnFF0wCO4vnyKXfiPKKeMG0=; b=
	NiMBdp5MDe7dauZbKZVK63D/QYEEYW5R0p3bnbGWsQFmODMtr/H+PAb4fYEr4S16
	pKoYQe+xmPPhjHseYiWp1ztvnAYkiqQ0VwVL9PxiqFxXrldOLENop/ottlvgRKDF
	TVyWYJeBcFtxuczw9NesxUQKH/YEHHnQUQGxOrV27+UG0gqF6qEsGnk3NECCueMX
	73BH7Vz8p+spnqGtDDxW+jThEJyA9tcnkvvwWJI+xQ818yxo22K+aV6PSiJxgkVH
	h7J/zUfG7qIpj+fabqqoDFQESFNx27YW37IKCtkcLOe8JN0nhc2zil/5R2Stxhi5
	ZtyxLSZQZfXmWwI8S6ovyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622647; x=
	1758709047; bh=FtsG2kAwa2bhk6ZOqa3pZnFF0wCO4vnyKXfiPKKeMG0=; b=c
	l7KSzXRCF7uUPzTpmyQE/UZWDfbux0YOVZplXGd5jih+J0m31mNt6uJg8RjxHwuA
	k1yiGP9OOH+4d2wuXofJTa+PJ8tj9a+R8kjBoxrlZHsVSwUhNOs22PKXCbBMX2nA
	DNs0SI8uwWBtdeFAnr6vlL29hMapEf/APMdXotu8YtDbdVp4VbhqOS2ZmSXTlNGG
	/E/wtG1YghmafSm8/xEczMbNVfWo5lBwsvnOqNN48KnDQN8/CAocV/Aizj1eIyBW
	nWEFUdvXz09d6ABUtVp2quxPlbbcQa3ucf7byBiyJESS+ZKmz61ujk/x793kD9ut
	8ODgZ9+7fNaf372SEkDuw==
X-ME-Sender: <xms:t3PSaMkQzfsW3a5NrBlIRr5p8SVBzFf-v1_qgfL8S8N1RFc7JZQUHQ>
    <xme:t3PSaPj8ITKS1Qnuk1KcLZmAckeYDcy4Yoj6z9FEFjnNohSnl7cjo3w-KBgqOhfxK
    rJRFqxWZ3s4hsDnMRiyYBgjjB27lylDg8mPmcuyLh1b6rWhm7Yf>
X-ME-Received: <xmr:t3PSaEfgIm8r_IPxLzLWdwuxp8VzYKqdGCRXsQvkeUQ0tNmYDHlEO2IPbirK-xs7TdmXgx9_Ko7lDHa3GbJ19p9ORe6ex1gtCCTGGzJIn1eF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:t3PSaPi3ut7XNPs50vqfTgQZ8feKFX9SAS3nPPK9xpeSAh1i43UDdQ>
    <xmx:t3PSaMzz3qXFRQSCV58rEAMGxIraLeLx2FD01-nantga6gYN0McL9A>
    <xmx:t3PSaLM0Nybg0j2r8Sb9u0V1M4niRiuISGe-2cv5qiGMFu2N2RvwPA>
    <xmx:t3PSaNW45rs-quIm7tlKUU_29mrhSmV7OOrmfRzJhCnrUax1D1BDRw>
    <xmx:t3PSaJ70LhZyqa6EZDKSMAjL0f2xuqUUbMWJDw8JSH0Vwsg73A0hGOLE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db830ab5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 12:17:05 +0200
Subject: [PATCH v6 06/15] odb: move kept cache into `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-packfiles-store-v6-6-b48f2a882759@pks.im>
References: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The object database tracks a cache of "kept" packfiles, which is used by
git-pack-objects(1) to handle cruft objects. With the introduction of
the `struct packfile_store` we have a better place to host this cache
though.

Move the cache accordingly.

This moves the last bit of packfile-related state from the object
database into the packfile store. Adapt the comment for the `packfiles`
pointer in `struct object_database` to reflect this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      | 10 +---------
 packfile.c | 16 ++++++++--------
 packfile.h | 14 ++++++++++++++
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/odb.h b/odb.h
index 3044b6a661..9dd7bb6bc3 100644
--- a/odb.h
+++ b/odb.h
@@ -131,16 +131,8 @@ struct object_database {
 	struct commit_graph *commit_graph;
 	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
 
-	/*
-	 * private data
-	 *
-	 * Should only be accessed directly by packfile.c and midx.c.
-	 */
+	/* Should only be accessed directly by packfile.c and midx.c. */
 	struct packfile_store *packfiles;
-	struct {
-		struct packed_git **packs;
-		unsigned flags;
-	} kept_pack_cache;
 
 	/*
 	 * This is meant to hold a *small* number of objects that you would
diff --git a/packfile.c b/packfile.c
index 861d7ffd6f..95a78f267f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2091,19 +2091,19 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 static void maybe_invalidate_kept_pack_cache(struct repository *r,
 					     unsigned flags)
 {
-	if (!r->objects->kept_pack_cache.packs)
+	if (!r->objects->packfiles->kept_cache.packs)
 		return;
-	if (r->objects->kept_pack_cache.flags == flags)
+	if (r->objects->packfiles->kept_cache.flags == flags)
 		return;
-	FREE_AND_NULL(r->objects->kept_pack_cache.packs);
-	r->objects->kept_pack_cache.flags = 0;
+	FREE_AND_NULL(r->objects->packfiles->kept_cache.packs);
+	r->objects->packfiles->kept_cache.flags = 0;
 }
 
 struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
 {
 	maybe_invalidate_kept_pack_cache(r, flags);
 
-	if (!r->objects->kept_pack_cache.packs) {
+	if (!r->objects->packfiles->kept_cache.packs) {
 		struct packed_git **packs = NULL;
 		size_t nr = 0, alloc = 0;
 		struct packed_git *p;
@@ -2126,11 +2126,11 @@ struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
 		ALLOC_GROW(packs, nr + 1, alloc);
 		packs[nr] = NULL;
 
-		r->objects->kept_pack_cache.packs = packs;
-		r->objects->kept_pack_cache.flags = flags;
+		r->objects->packfiles->kept_cache.packs = packs;
+		r->objects->packfiles->kept_cache.flags = flags;
 	}
 
-	return r->objects->kept_pack_cache.packs;
+	return r->objects->packfiles->kept_cache.packs;
 }
 
 int find_kept_pack_entry(struct repository *r,
diff --git a/packfile.h b/packfile.h
index d48d46cc1b..bf66211986 100644
--- a/packfile.h
+++ b/packfile.h
@@ -64,6 +64,20 @@ struct packfile_store {
 	 */
 	struct packed_git *packs;
 
+	/*
+	 * Cache of packfiles which are marked as "kept", either because there
+	 * is an on-disk ".keep" file or because they are marked as "kept" in
+	 * memory.
+	 *
+	 * Should not be accessed directly, but via `kept_pack_cache()`. The
+	 * list of packs gets invalidated when the stored flags and the flags
+	 * passed to `kept_pack_cache()` mismatch.
+	 */
+	struct {
+		struct packed_git **packs;
+		unsigned flags;
+	} kept_cache;
+
 	/* A most-recently-used ordered version of the packs list. */
 	struct list_head mru;
 

-- 
2.51.0.536.g15c5d4f767.dirty

