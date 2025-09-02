Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8782F5318
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810144; cv=none; b=WjFK1vea9zw8VgU+6H0ATgXBOiwYH0+SDuHjQpa3VX5lseGxL7EqeW8/kbTL8UgPRFxoJsMCZvE3x6KOKk+vfA7Nyg7fU237xwtBolZuE9A4Yo7ewLayk/w0hvz6yaJGBU7XDMs/e5m+CSmFGkg9T32x+7fVGC3NyzjQEsg2Gt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810144; c=relaxed/simple;
	bh=11ulTHQ0PPC6yGwIeJiyuaP+WTir7pgOfNMShhALnrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JY+N7Y/TfgpcafRRMiJDLQsOhnkyJYjN91SVTndvkBmNxI506OagCMp8TSpbLGPJTZIbaJhKkYouO8Vph9On74OShZj1NAlNaT87oY4OY0iz63LUEAEYKqI0lJMXKygeqRt3pscjWrAS4KLrHqxvOsxcdjxfr6yWeJFCrJBFhTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cRvMItEH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZg7WDiY; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cRvMItEH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZg7WDiY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A996C1400237;
	Tue,  2 Sep 2025 06:49:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 02 Sep 2025 06:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810141;
	 x=1756896541; bh=E6DfaYQ4whVOZNvOz+/Y4H/0bTTv2b5OibqSsShcLc4=; b=
	cRvMItEHleY9Rd/RAsAcyRHZ1yCKSDNQonhAzJnAhQmiaUnDbB+ivesrIfI2issk
	6He454g9s+VwAvPJzsd7DNNYlW8JpVJT86Mkv/EEhexCiNoBD5tpaatO1SdB4z3M
	SkzDMKsSn7rgtOpbLU98TyEkauboEK4hN9K+NVArPbl7TSp/YeB33T6y3PfICqQ3
	1QJS/D7Wk85iL6Ez/b7Sj9hnm9DzYWiOVvDAcUiIQcOtD0HjrdFlJdujU1r9wkY0
	U6fZhgy6jgzf1F/yjCvXEqJzoyVvf5SUJFyBCdUmTYAmdFzEsMFMoBSYbfy1zZzs
	0+oYphPu7GkF+3odM9s1yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810141; x=
	1756896541; bh=E6DfaYQ4whVOZNvOz+/Y4H/0bTTv2b5OibqSsShcLc4=; b=W
	Zg7WDiY7TOKSOuVgu/W3jzAsw0Vf8M2tk5D+ZcVg687L3px9WCxzOgCXG1LW3iyT
	ioXD5YBROIqBlEl2bDL3rtipGeh3HpBfqB9smI7wLDTU7tIgeO7SxxK5s9cCO31K
	x8whFV+O78POC9EmJ6NKYaX62RpUi6erN5Rp/YMgIpQBfBkcy9yQsKhglnOdjIO0
	3l3+91w8O17yiKqRLnp9+ze6Km9wdOEiPOt/yPUJSSrUsVN8+KDtp2pCUuPYR7b2
	oPYrVotw3pi6IhV83RuHd2npLoL+lzgbJ33iOGzo5WWcPzFXX1fNk88dHQQYeZPf
	o9xtJe4h5ARULU9h/USNQ==
X-ME-Sender: <xms:ncu2aH4ek3-o1eXtZNZIcPV2nDJiJfpNE_2udRbMwmsm6eQAdl6Z5g>
    <xme:ncu2aIbCQ4JevbCCjDy8yNSpjDPAZK5u-Iaqf4iQIbiEmRwDouAu1S12vItSeoz9e
    3WQ-vWpwg7ML4zS_Q>
X-ME-Received: <xmr:ncu2aE5hx2QFBOcMrdxSd0f0AUtVXk5-UNkKEUIsVhclRe5XY8uMQByBdAaQDqfVW2B6Sz6UaA5rKBicfngLaHC3kZa84DCxZIUTzihiULqCPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ncu2aDA_TpeAyfqVG6u3IrkMNB8VTX7E0dsDM_X46Ro5j21aWWhpLw>
    <xmx:ncu2aCdhUp1nZ4o5fsgRKctYpoz3wiATDFMMiWXyM9QVygMyDIwQFQ>
    <xmx:ncu2aKKvibcyEzVitJc4IzWSAKiZsi9z2Fuuro0eFTwW2QDN67LEiA>
    <xmx:ncu2aF2VNDZz8IHQe0p1iOxNJj_2TkDdhyv6LDkOMZXRYMt2h1IrjA>
    <xmx:ncu2aGNhAei0shKAFB-q4g2ijPUWLn85JGMDYagxX52pYrzSKcq2xcgx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:49:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 93e43f45 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:49:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:31 +0200
Subject: [PATCH v3 06/15] odb: move kept cache into `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-6-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
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
 packfile.h | 14 ++++++++++++++
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/odb.h b/odb.h
index 8ee1f8bb43..1c998a2478 100644
--- a/odb.h
+++ b/odb.h
@@ -132,15 +132,9 @@ struct object_database {
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
index 98207aa380..6ae7f22d65 100644
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
2.51.0.384.g4c02a37b29.dirty

