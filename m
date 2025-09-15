Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311AC2F361C
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926490; cv=none; b=Bq5zmC4+Vz6COMsOaxLJovAbGqifrW6QrEQNT4Vesa7luSN8fUP5xtTbsmGv1D+e1M1lXhMmcAXUnbmO1cUNY5nvdPysiMsZh/x87aY+NAOlzu7LOVj6yjUr4fRdzo012A8yjePMJvS1QdzrQTtiQPTZt09PI2+LGioVjiJjvsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926490; c=relaxed/simple;
	bh=UvKcFCJhWsakCuxyAg1b3h0TcusLtaojJ7U6V9DnNW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dWKyTimjbf/UrTWvPBz1HJ409A9L3c4X9oAOH4sk7Va3C4l5X4JnCBqdIgpqI7tB1HsJYMYjYfKVPMVfJylYA4JsG0eJLlJYhnh63kFDlbcpdqNnY+DDjycZ9VdYolA5I3a3sf7tEqiaRVfc3G1VqLocrQ9LGR1/iAYxxpj7GZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dC+lgXLa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SY0h8UOj; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dC+lgXLa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SY0h8UOj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63707140002D;
	Mon, 15 Sep 2025 04:54:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 04:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926487;
	 x=1758012887; bh=nJeCwNlT+2V/R5i3G0gFun0YShwAvu4BDzsh/rJmVgI=; b=
	dC+lgXLaQXrzk49iYNRhpRw6tq0UGEZSqEZ405XLiNPYCNKlOHMcNdd04hYnSkmh
	6qywXcZcOZkWtgILw6atQY4AHdMDAEK14mDsm4tOPuKyv0PY1zPoHmMYIGikruqs
	y2dYFCSUtA9fH1n2U5KLqGp7DbuS573b32ELZKgS2iDqxUksoPBZpFRuKnZzEo2E
	WCN3yG08lrwpXzzFBwh1q3mJPSM+lptyKtZ6JyNeHEtEM8U85REyyQv3crELKBkQ
	BQKYe9vMlJ243wwiPa2Fa+AEnkUaxYXeDp0YSTAgwFLfcL5xRv7aH1RzAiogxiVh
	iGpFOEkCa8iMhK219l1Gew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926487; x=
	1758012887; bh=nJeCwNlT+2V/R5i3G0gFun0YShwAvu4BDzsh/rJmVgI=; b=S
	Y0h8UOjse/th3zkvjwU2NzdivafLrKfspA1qXIStcYvRqXjyr8CUEovFGsMB5ZPP
	pi5mpdkJ5+bkAvy166q4r6Dl7PegSmhKVUMNksbpr6dCQlXnXJN7pa/SbO7l5PWS
	tsYtID635A3quwSB65VahbbNHF5JVQMX5WOWdS6t1OMfspeZvzY+VxUSEfhUIgdn
	4vCn/rY7koMT6DNLpYmamjrUsxg6FToXKUCzDIGPVO1mzSEs6yXkZs3urwLUcVPO
	JZCeqL1c0nAMGHhlOq0Zj4n6Z8PXn0rKFfLC2iVQmyUmvQU3BLj2fBkuntgqsfM+
	A1jYt0t17UoS60rqefvng==
X-ME-Sender: <xms:V9THaHWPjRZUUqb3CE6MOb61m2KHqTT4n7pDF8zfsse3e4a4NB-3Vg>
    <xme:V9THaLHFFyJQpGkcCo3mHniPlyPw1QXzvBUVl9_E4LMQutJzMrVbwwbFS-NGUoM0g
    jiTYI2QNNkFIi99qA>
X-ME-Received: <xmr:V9THaJ1ciSK5CJSz5tyqu-9cIXvzL09HEo0oObnWYz1a4J4xQ4abwkWvv9P1tRy40vPTtojhqJU6ygOAyNhOu9xIwWRcQBPleb6ncjD2LXJdGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:V9THaNM5g9lRnIJa2eyQQAjmbF1VdM9fhD-3IjcHzjLr2dzH1Ola3g>
    <xmx:V9THaI6KU8969q8Hoq6vGakjFPt2RjsMcw-Vbx181tRh5aj9m5KGOg>
    <xmx:V9THaH3aLooHMTfM-TFuewh7luGInNR4MKKDKsL6loPPFZNY9XfmgA>
    <xmx:V9THaJyW7LaUPJ52JmbyQTaB1kBIHe5HIbeVcCcXvngP0TKtp2oFhQ>
    <xmx:V9THaAYSFzrJR4vWX83EPTBsKTkfbSDrR9_uZN6m4-Dc46Pki9uXNxU0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:54:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ee030bb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:54:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:24 +0200
Subject: [PATCH v5 06/15] odb: move kept cache into `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-6-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
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
2.51.0.450.g87641ccf93.dirty

