Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ACE2E8E07
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761969; cv=none; b=q0lQkvJ9IWc8JuvnjDjscCUqJWe+qFkr8BjhptiNUXq4wKNt3Q47xX/cRIVQX1/b8tiO5hP7VJBc6Huuv+Xr6UFY4tVGjNg4E0OszXHqaREvM3Y14l0oI6D3RkTaSzy+ruLFiwKNyzqyNxcQOBNOOKKC84PTLqXqdbBApgq0KLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761969; c=relaxed/simple;
	bh=/hVwTrdfIiyqM9a8n0vhizuoGL2Pc4dRZ6l8YoEwF4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+muAF9tCbI2C9u69zcfQE3PyC/nUSCh40gDSExJNWRS7VjTQs2bnI8B2etIk6/Kpz62JP9TgmTPULgbU8tvKe/gNjL/gre0oXp7uM/ycU4AWMWWSHR1j5WQr7bBRFltWWdCjIaZRV7P1mJ753BRiR5iaxzUE/PUCEq5gdKruuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M90oDQYt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SjbB7IaG; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M90oDQYt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SjbB7IaG"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1AC0D14000BB;
	Thu, 21 Aug 2025 03:39:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 21 Aug 2025 03:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761967;
	 x=1755848367; bh=WBHDzNU4Bwb2bPjzji0la0kWfLxCpq7JdJ4CXVpH6Es=; b=
	M90oDQYtQSmmE65QCZz3v7JiiBDb2yTtoEUXLEq63OUgjeLDfvja3NrCuA+wUeZg
	GDRfwp811BJO9aANM7gWhmNkppyIeBfdPAo0hIqusfl6vO3kelXyeSLvUO3+lma9
	cY1jpm63NRLrW6c3kzY/r129b1N2mVGg3r4tBNBfazQS9GBSLEWrvQcATc+9aPOK
	A3dH9uX/V/59xa6SlaT5Obo0Z8LaKxDcO3AJbW2RAfqHbvTnushnp2nTpigIasTM
	YeYcWcQkDJbRY4JJKD3YGUdtI3K8e8qSXfhZrF4Vk8LQZsOHQN/5Lty74Xg7yuH8
	u4Y8j2kPlBMgt8bsFkWR8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761967; x=
	1755848367; bh=WBHDzNU4Bwb2bPjzji0la0kWfLxCpq7JdJ4CXVpH6Es=; b=S
	jbB7IaGlEvrZ6L777uOoX5ZRzg5Q2ImeZ5etf7oiWIV7gAFyFBobexPebhQ0BLdo
	GkS+oKrjxyEzUUkMi1eKFMtWwk1yPPBG5VHLNYUImbNECttyiqAYJywrz1byCYfb
	Ofo7LknwFfKtanYY2DJflZ4wocXRx2UluQu2YqxS6S1G3uCA1dcZ+qO/EHIwBFJt
	rDXKY04/JwAax8GKdHMQJhdj/ZMHmyJ2gnfOYHXzO4vlRhJCOty6smRvfTFWKwpc
	ViMgwGbsdLMOP1fMjZYMa7VwaR8jLgLB9Mtp3Dhu19+B3183ivGzcqgElIZXf5pl
	xT2bNydzED/0M0Al1JP0A==
X-ME-Sender: <xms:Ls2maODFY7owZA8NLHKd4wf_SwfOiR_taB8_UKInBlfya9uK20tvAg>
    <xme:Ls2maLyIQN8Ohd6L22iCSeX_30RCm8EZ2OjZ5WdzKbZGfrhKJ91UvLhW_VaFCA4iE
    bjL37oN376u-KJ4aw>
X-ME-Received: <xmr:Ls2maLCjbQfSPorzZMYoNL-V18o66IFosF2ehkdaK8ECQYiknbCkkaBjLYKfFc2nzOX45qj6JtyOxikO_WE7VdpFDd3H-_tfzE5XfdeTHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vght
X-ME-Proxy: <xmx:Ls2maIZNYJsgahHpBcz7Vw8IXcEMfCfKvrnzwQNKC83Y7fiziegoLw>
    <xmx:Ls2maDjnwGOZGzUDQVtDaIypyb-MHAuSX1UtSbmaHEKdfxIvZNKItg>
    <xmx:Ls2maK7MUe6cHvO1eswOMp0KERjrrr0Qy_mJPm3nSHJ-C51gnNhQuA>
    <xmx:Ls2maK46T-7vPg_WpHDZoGxlfbIWidPtJzl6eWYsndiwQaSMlizHbQ>
    <xmx:L82maPZZifjNeeuF3jnkyg7Bl1d6YVNDzv8-N74_Bu14W3L_RnY2GA_h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f255374d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:04 +0200
Subject: [PATCH v2 06/16] odb: move kept cache into `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-6-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
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
 odb.h      |  8 +-------
 packfile.c | 16 ++++++++--------
 packfile.h |  5 +++++
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/odb.h b/odb.h
index 1505e39729..f1736b067c 100644
--- a/odb.h
+++ b/odb.h
@@ -124,15 +124,9 @@ struct object_database {
 	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
 
 	/*
-	 * private data
-	 *
-	 * should only be accessed directly by packfile.c
+	 * Should only be accessed directly by packfile.c
 	 */
 	struct packfile_store *packfiles;
-	struct {
-		struct packed_git **packs;
-		unsigned flags;
-	} kept_pack_cache;
 
 	/*
 	 * This is meant to hold a *small* number of objects that you would
diff --git a/packfile.c b/packfile.c
index 91a7a4064f..07c574f359 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2092,19 +2092,19 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
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
@@ -2127,11 +2127,11 @@ struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
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
index d48d46cc1b..74cea1a4a9 100644
--- a/packfile.h
+++ b/packfile.h
@@ -64,6 +64,11 @@ struct packfile_store {
 	 */
 	struct packed_git *packs;
 
+	struct {
+		struct packed_git **packs;
+		unsigned flags;
+	} kept_cache;
+
 	/* A most-recently-used ordered version of the packs list. */
 	struct list_head mru;
 

-- 
2.51.0.261.g7ce5a0a67e.dirty

