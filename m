Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41B31195D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591596; cv=none; b=rHl/T+6yHeEdappQybssLDhrbPnUwuHLAbYf3X/rVh0R8KrA2JY45sAusJO8d/q7mgJAwMDy6HD46IG66eHgXLKSW2y+dwH48lmlEzv4OVs5TLRyycTAyr30VT7NLs3betNdFb6HIpsAvgfIvSLR5h7EZNpSEKpHV/My+pgYSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591596; c=relaxed/simple;
	bh=xiQSzTyTxMTn2m8eO//dheezAbe3AMbedSUNH93C41g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eOx2Q4tn7fbedbVGVH0DTa+9a7+SeC8tKaPXxp0wPz0ZMb+3keqGFyYqz8dadt9fUwx5b6tc1tW/ocakByFvE+H+HUIn0MRvj/CXJ0anTU8nI+xDcvOIW75x/ewoXEMJzCYUZc8FaDS4tIgIZt+PVFIxW8YHBWzmpQPBzpwJWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TT0q9dvD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CkVWYcR5; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TT0q9dvD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CkVWYcR5"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EAF37A0283
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 19 Aug 2025 04:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591594;
	 x=1755677994; bh=28V1Ay9uy4l5KzIGeniYfUP3MS0oGi4NMdakpcRI3LM=; b=
	TT0q9dvD3zPy8F38lBGENMTKAjV0wNY+XUaQhkzuj+UgyPcUc8Nlstbv4/FhoHv4
	cOQYlBFmzfe8IGaSLc2bUs+mK8afkRkea5zGe7xQWEu3SNxrgf8aZrxWGErJGFtH
	u5j41WviycOvEY/IEhDZavJXk5ZBTnnZ8md5drT2ZdeYsZHJ8enyZmlQgCpStGZK
	krDEAbv7z4xaXtu3QGEB5k3TZ9Hjy83aubBntJ5DOALvdGafXImo8GmPUwOjtnia
	5diR7toLgHv8JaZ520IticB1z/1WyZUHijPA4owte6YN95kJvPfkUidXBEaPFZan
	HyDX1yaVRvjmaJabKgi4ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591594; x=
	1755677994; bh=28V1Ay9uy4l5KzIGeniYfUP3MS0oGi4NMdakpcRI3LM=; b=C
	kVWYcR5ijsas13aAsL/9TmXnkynVhqsRz6wpAEQYwI215XfSu/zypfQqqre5r9P1
	naNV7dg3KCjOVOPuPNWiQN8+nztD4hKccAmnpRmBfTByaBA5yLr2ZGdIFNmCJ9Z6
	PkGlzR93Amhg1MKRqto79n/52N+HFDiIuTk6hE6i7rq0/0zZC2XRN2UlwfMPzci8
	cM9MsTU5AXqhrZ+dJe8F7WhqHp/kHV16O2beiHa/COLYVL+nsA3cVq3rCv47mghZ
	35cRWJKccNkCTIavVPIhBHooWakf1T194GogSOVfbrp7xsZ7a3Q8tY14t4Lfqx2d
	t3Bw/AOJ90XUGHj8K6WkA==
X-ME-Sender: <xms:qjOkaGfNYIpNz4d30oLMe358lcBMGlFnRGTZY7IsGJ4IMSm1ZKq9bQ>
    <xme:qjOkaCNq2AxqMzW4BkXszZGNCEM__OVQ1WF7_8S6Gy2P7StoSaG3EkKQdMPNhPKyu
    dMhbVF6eZjiHFxEig>
X-ME-Received: <xmr:qjOkaA4kOoKMX4IAwoeQz4L3lBorHWSwziHDN5wJHt5LNgy-LSSmwl2OSwNvcsWbjMsQ3zI7GDOQ8fN18YuX_-DOmNKExf7eUuROmmjyg412>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:qjOkaGLjMrFMcYuf9awPm0r5kAv4htaL0JMD3O6bVTiDpPZsJj6S7A>
    <xmx:qjOkaKfJ94YtHi27lCOYxk2MigPxKsCMpuKLrJNIcEAKuXw4xMZ5yA>
    <xmx:qjOkaJfvn93YT6fVyLqZMH__LzfypxXCiZYNlLzzXmUZQYvMqYaXvw>
    <xmx:qjOkaNNMIrgGgYUxysokTWLXqtrRD3buTvsZNb6it0BRdRmfZaWfZw>
    <xmx:qjOkaNGkRf4b5iRGvETJAu3Ja9NQXFoPANCdpGMRZKIcg5CZBRXTv1zE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e158d19 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:19:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:35 +0200
Subject: [PATCH 06/16] odb: move kept cache into `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-6-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The object database tracks a cache of "kept" packfiles, which is used by
git-pack-objects(1) to handle cruft objects. With the introduction of
the `struct packfile_store` we have a better place to host this cache
though.

Move the cache accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      |  9 +--------
 packfile.c | 16 ++++++++--------
 packfile.h |  5 +++++
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/odb.h b/odb.h
index 2dc3bdc79d..f1736b067c 100644
--- a/odb.h
+++ b/odb.h
@@ -124,17 +124,10 @@ struct object_database {
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
-
 	/*
 	 * This is meant to hold a *small* number of objects that you would
 	 * want odb_read_object() to be able to return, but yet you do not want
diff --git a/packfile.c b/packfile.c
index f82856c19e..f33445a5ff 100644
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
index 3022f3a19e..f46ea9ceec 100644
--- a/packfile.h
+++ b/packfile.h
@@ -65,6 +65,11 @@ struct packfile_store {
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

