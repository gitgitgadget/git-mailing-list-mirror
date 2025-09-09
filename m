Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F93203A5
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415807; cv=none; b=j4w/cfMIA8la702asQq7hRkfMBWnfF+nQFfTITEKgXnFPpB6Pji90esE5XdWmYvisliwIcwZPUbIZUi+nJXzPnDwpl5wAPf0vXqSBpwSGeb8eckA3BjzNQodnUNnDQsajdr/r4mURMISxk6aNfRjOHjVzUJukMIeAWIE1tJHUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415807; c=relaxed/simple;
	bh=z0LWYr3tmWuRwgFRi/hbThEkDZOsP5BB01kRk3gkcwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PyloACOwFyJ6fxedBpkzOGjn3W4iaPsxXAQiJaZyRPztdCowVQtKRhx59ldvgXE8zHqx9Z8keVPh7bOjt54qAaj1qyrNfbYWEQqG3XH/EUo8pjJi805bS2jiNwuSsMVVBbZZj363RZLNC0Ix68pcdHTkxCfQkEE/AbButPwKEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tWapg7q1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hKQ0GAB7; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tWapg7q1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hKQ0GAB7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id ECB4BEC0F4C;
	Tue,  9 Sep 2025 07:03:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 09 Sep 2025 07:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415804;
	 x=1757502204; bh=be7y+p0HkppJvxdEK/JatISKAydGt1E43AJfT5X9K68=; b=
	tWapg7q1eoRayyMJQkMWqqV3YArBo06Yvho//ISL4zvOjig15ZR/fusEdiJBmP00
	YQkirO/7msmHD1WcULFw0MulOiuKKwXfKT09KnrE0RCE8vMVz60mfiLxyapQGPKq
	s4eTHrZzPqfWcBCWLoNfxRSoLTRJrcs3NlnnO8xvOCA9CWvjWoqgRwQK4hyAx92o
	peBTty4LI2yNwfop9nE7v7gWXaPihi6bk5rzhMKrNwhCYs6JyastXd60TdNDwizN
	GWeikdckBjUPcK74q7q7v7hmZ6MgpDks9CR2pdFsrwmN++FyWuvnR7Kk7A0pI0/j
	myoyJn8YCsuWYHM5CxQBEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415804; x=
	1757502204; bh=be7y+p0HkppJvxdEK/JatISKAydGt1E43AJfT5X9K68=; b=h
	KQ0GAB7oPbRglNsPwRewtHJyuHh6Lh/Aw701hdQe6jL0qsC5BxLB6M04akZgHurn
	qx+jLIVMeirxeA0CC7kJ9jgaKXnkJ3vsIT0T849WOiVwaNcx0EEbP/JOIy93XbtI
	RDo5yfU6ZRE4kJNbHYO/2fv1yWP78qMBSw5yMx6JUL5Rj5nzoYNBpCF15FDH7w51
	QD3ULn4QxZWfFUaph+j+yox62QJGYxNZlIAmb/L/rKTaE2ft6jBu+xPfE/cw2dtV
	GZBGd9TltjoK5CPubT4ehbAG/EvgAz8Il+0Jni3URQM7gxZCGeAvX8NEzR/Kpdp1
	kdjCBRAbXPptIyMlCpstw==
X-ME-Sender: <xms:fAnAaEvBkqdrcd1Mef0tQdXWJPjam2zzlq3E583HuRGbobyYQO8gMA>
    <xme:fAnAaM9BXBHshzIv_klBHtr-2HyYOFJGhnGb7AOAmKuK3C1fR61kiI_WbLCOcE2WG
    vxr7WuaqrcU-ECCjA>
X-ME-Received: <xmr:fAnAaGMp3flMhOO6E87hanTujfzemG1Lgb1qBlAmaUL3_22sMsJjbSfyEI-_csDjaQhkvDmdo1RTXeU6r713lLkXnBCe4fkP__IFpZjRiuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fAnAaCFOs0x5VwMXufn5ozcWO_bZRV4PJ_rzP3kCmeTCFLwcVtI1lg>
    <xmx:fAnAaMRD8miZI2wMbCxOxcyL8ESfyHlKMUA4ZoXJWT-xL4bD7obiwA>
    <xmx:fAnAaHs68h6dSe5iDZ7XWNAAGvqd8GUMkww7lVfEc3bn6YFB_enGCw>
    <xmx:fAnAaMKpglhcbOIHyJFNbGMqQEMt1SNIIfj6jIdhS-LZVaVPX1w-RQ>
    <xmx:fAnAaOqUuV0Tb4FW409FIM3OsAmZbRBKEu90vJNnzmN79S8TfzjByDs_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8cf51efa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Sep 2025 13:03:05 +0200
Subject: [PATCH v4 06/15] odb: move kept cache into `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-pks-packfiles-store-v4-6-151c4ba3619f@pks.im>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
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
index b0bfe62b5d..2145a4edb1 100644
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

