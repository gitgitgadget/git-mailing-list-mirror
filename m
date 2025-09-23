Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB5320CAC
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622657; cv=none; b=ITG7+/XV5ZTxPm4x3eYmZAbX0NXCNceu5SYMCm0UHNo7RIWlCed5ZBIxnzm8uvdCo+HN5+/T4QlGLR/jSSynDq7NLLdHJfG3JEGQtBEl9YlDmHpI9xHkQGNG3VU+tmfV3OtcfSPjJoWKIj424ov++Ps8P8YjDKHGudpNPfTKprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622657; c=relaxed/simple;
	bh=euoRLbYq2ihYRSY31Svx44v6IV0dWGFdNd0cujLzqbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYn3pemEyNTAkwdHpmbY3dZ33htVyJVljriDFThq1oQZK3ysHbqeSbn5/OiZ8728OUml5dcJJxXoNI7lwQekyJcQEyo8MdnW64r7Y13autPT5CkZub+tWUxvIqcaA5eSCHwCuVsS0gzqANBl7V9FCeMnH2uTsc43fKvq/TQxjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l1dU1ufU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cf9C/cxD; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l1dU1ufU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cf9C/cxD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 237D27A01DD;
	Tue, 23 Sep 2025 06:17:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 23 Sep 2025 06:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622653;
	 x=1758709053; bh=80pe9MUADvliAN4FlqwkwTMx6LGFhMzB5XwyWKKjAYY=; b=
	l1dU1ufUN/HuH5bWNFRvh5afEd4SZFnWxQdHEQ5Rz9so83Z28JusTjdNjirxqxGW
	31asVqg6cnTz0x0vptgOjz3uuYXduf8CDkoQGTAwemuv66twIIqlqiAvW8d2fkjq
	NWPJhNxxKdhoWYLNhWTmhKWNSvsCc9Gcp/YGW427WTnpl5pcNiFacdeY+xeTQGUV
	orLFeNFSP6L4LnTCztFAJQdzFNyBRs0qL9ai5HDBmzb0vUYqVNJa8YpgpVK0Ulnw
	BG+3/nZs6rZT6oF9r9J8dqQtLRfWlDY9ifo5ykTAbZu3wooMxEbN0jKZ0KURMRBw
	7FUia32T2oa9YuhkVXHlUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622653; x=
	1758709053; bh=80pe9MUADvliAN4FlqwkwTMx6LGFhMzB5XwyWKKjAYY=; b=c
	f9C/cxDMZcdmcT8bPHbIRzzSl1hH5vxBp6GiiF4FO1syup1mmMORClfxKwLRd0SN
	PCtCAn5aGyhZLOV0RxzTAA0uQ48R/o6En6aa5PaMa34+d1n0fnfWui/y5ypQQwkP
	01JjYOL5dfASWJO1n97tcLqpPsfsG+K9OlrMNMkMktptODb4sY15e71eHwenj0RL
	vX+lqVJKZzzkedVnRuDY63E2KZNtmU/sP9EFnFcGRXoTJ5amtkbzyyVsH6whNPw6
	r46W6A8AgmeBoo7rUWjFyKK38myEjKaYOs6d0GsSMWpQiIWybsUuYWt5VtpcHIlE
	PUDQxf5BHQk2YUlzz9B2w==
X-ME-Sender: <xms:vXPSaN-KuKOyanCDBbljJoeaw17p1FL-nwuBmEihCfB0wq_Sz-d1Xw>
    <xme:vXPSaFa8XOHxDM6o0AfPGpbsKJ8uQ_FT4fY3L1BkInyTlWD1MhwXEw3BrUGnsVJFN
    TO4Of_WhVbhwJ3tGsCBnir_ISdKWnEm7aM29x4ipatxR7FR0DviFg>
X-ME-Received: <xmr:vXPSaE3PvMEAO7GzS0FJXBQqwgs60QvpnEdUhU6KjVIU4jD3D1RUcQC-BJpWwGe_aWgAxVaf5hJYm3Dnr4HEvf8b63pe9Hh9iL2PK3OPZbg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomh
X-ME-Proxy: <xmx:vXPSaIbhjOR2y5Y70lp6MUEBmM1_ILuphm5XPz3sLiv8ID6Wrh1ViA>
    <xmx:vXPSaEI5mGRZZMCjOPLdNPqZ_aC_BFX3oQ8-MhFNr4eGTHk5hNVHjw>
    <xmx:vXPSaPHLSSwMg5UE3xjB1vm-KQbISQ0yCx0x2v5YsxLSBUVTzX8ceg>
    <xmx:vXPSaDvS2jajJcSTaaomsfVNUXEL6xYwcc9LT1HU4Tsr63gXlxsRqA>
    <xmx:vXPSaCYnS3ACr5X7rMj-FxLGSCjjSc8blYA1w_yNUIPEYCRGchFjbsW2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d903aad (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 12:17:07 +0200
Subject: [PATCH v6 08/15] packfile: refactor `prepare_packed_git()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-packfiles-store-v6-8-b48f2a882759@pks.im>
References: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The `prepare_packed_git()` function and its friends are responsible for
loading packfiles as well as the multi-pack index for a given object
database. Refactor these functions to accept a packfile store instead of
a repository to clarify their scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/packfile.c b/packfile.c
index 5588a7ad6d..095c85919b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -974,37 +974,32 @@ static int sort_pack(const struct packed_git *a, const struct packed_git *b)
 	return -1;
 }
 
-static void rearrange_packed_git(struct repository *r)
-{
-	sort_packs(&r->objects->packfiles->packs, sort_pack);
-}
-
-static void prepare_packed_git_mru(struct repository *r)
+static void packfile_store_prepare_mru(struct packfile_store *store)
 {
 	struct packed_git *p;
 
-	INIT_LIST_HEAD(&r->objects->packfiles->mru);
+	INIT_LIST_HEAD(&store->mru);
 
-	for (p = r->objects->packfiles->packs; p; p = p->next)
-		list_add_tail(&p->mru, &r->objects->packfiles->mru);
+	for (p = store->packs; p; p = p->next)
+		list_add_tail(&p->mru, &store->mru);
 }
 
-static void prepare_packed_git(struct repository *r)
+static void packfile_store_prepare(struct packfile_store *store)
 {
 	struct odb_source *source;
 
-	if (r->objects->packfiles->initialized)
+	if (store->initialized)
 		return;
 
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next) {
+	odb_prepare_alternates(store->odb);
+	for (source = store->odb->sources; source; source = source->next) {
 		prepare_multi_pack_index_one(source);
 		prepare_packed_git_one(source);
 	}
-	rearrange_packed_git(r);
+	sort_packs(&store->packs, sort_pack);
 
-	prepare_packed_git_mru(r);
-	r->objects->packfiles->initialized = true;
+	packfile_store_prepare_mru(store);
+	store->initialized = true;
 }
 
 void reprepare_packed_git(struct repository *r)
@@ -1027,25 +1022,25 @@ void reprepare_packed_git(struct repository *r)
 
 	r->objects->approximate_object_count_valid = 0;
 	r->objects->packfiles->initialized = false;
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	obj_read_unlock();
 }
 
 struct packed_git *get_packed_git(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	return r->objects->packfiles->packs;
 }
 
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 {
-	prepare_packed_git(source->odb->repo);
+	packfile_store_prepare(source->odb->packfiles);
 	return source->midx;
 }
 
 struct packed_git *get_all_packs(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 
 	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
 		struct multi_pack_index *m = source->midx;
@@ -1060,7 +1055,7 @@ struct packed_git *get_all_packs(struct repository *r)
 
 struct list_head *get_packed_git_mru(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	return &r->objects->packfiles->mru;
 }
 
@@ -1078,7 +1073,7 @@ unsigned long repo_approximate_object_count(struct repository *r)
 		unsigned long count = 0;
 		struct packed_git *p;
 
-		prepare_packed_git(r);
+		packfile_store_prepare(r->objects->packfiles);
 
 		for (source = r->objects->sources; source; source = source->next) {
 			struct multi_pack_index *m = get_multi_pack_index(source);
@@ -2068,7 +2063,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 {
 	struct list_head *pos;
 
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 
 	for (struct odb_source *source = r->objects->sources; source; source = source->next)
 		if (source->midx && fill_midx_entry(source->midx, oid, e))

-- 
2.51.0.536.g15c5d4f767.dirty

