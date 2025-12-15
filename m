Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024BB31AF2A
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784217; cv=none; b=ZPyzBn8p/KrUA/pBgvYbT1DwO9eVZRnd7NfEM9G7xAnr7aBHeKXPoL16n3agJc+fAaSjBOqjI6DucRayTOjx/DphNSZ/XVFZjEo+j9RvbpjQGTt2QD9jPkuMHP5I1QCRmhvKaS/m+6R+wRM+GB52jWoyvloh99u1G74gP339RII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784217; c=relaxed/simple;
	bh=ZeANN6uRIshGkHjUlLFOLBVTOPKD9tNnOWy0qvfAtG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mB4CCO4b+WNQweXULYDw4tb9W6PIhRbQPBlRXqa5QgEhC0Ln10SrB1+gevvC0QrPaoSat7np11ZpYBcWDEterfhzXk8+fa1KNt/XeEqYR5U8p5zrflNst7XdaAYOeO7bD+IlZSvP4DwsfsYawKtIlR2L6BgSxXRB+GIzasp+tHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZOnCV23D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hFkd1wzL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZOnCV23D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hFkd1wzL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E563F14000B1
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 15 Dec 2025 02:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765784212;
	 x=1765870612; bh=/9C83sc2Ty9tFXkY8k92WO8gNwmFFVP9U+GqsHcjg64=; b=
	ZOnCV23D72MosaRWwUAcpsjcYMX6X+mDPut3G8NcE6QY42m3IE/OceaRo4gU7eCr
	v2AWBafLGoAjdRgeEoq+LuFD4h9qF2pg5sjXx1yKhbOjU1jvJ9zk+MMaX5SarD3e
	RWhSqpc77hmz4MzVXr0fW2ubICyQz2zxhk+G8aKhB7eHCqqeFCawugZyoauWuFvz
	BZ1YWeTIPoORlR9ovJ8u5XIdh+z25cmy1Yw4PChvy+aOfFLyLAGY2/GOf6nMpBPe
	Uc6f0sosL+hvdkKS/HvfPoHq6DLNv/CxNvP6qiIDqsR+qyCZwsyU/GtUF1nxya/z
	L6tJWKmc1XuvJXj9mFSAlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765784212; x=
	1765870612; bh=/9C83sc2Ty9tFXkY8k92WO8gNwmFFVP9U+GqsHcjg64=; b=h
	Fkd1wzLrRjn5feQKKJAZLeGdqpi7TDLzAky+47PFVeHr6XWMFNwroTIGxub3Iwfu
	I5g59CSKgc16Hf8fO3uKNRjoHO/znOfjB6tjTTEs2iN/Hr1rbpvy8Z0wEIezVx63
	U/VtBbu9dK1qkLjAlGTgajToDh9doxz/NsP/e6IzpydXdBD6nzCo68M5jUcks5US
	6IXF50XqCwb058yTYxkS9oIG4hR4zmVGSk2WODcc0e8Q26lkj0Z45sUmlKrJpwET
	Xz8n08uRQBVVPzFtxqSQ31wL4Gu0hv/S1tL780MK6Lg5cROmBiVkiUXQqnKIlaKG
	2JR8srBhJuTGlqyOXzESQ==
X-ME-Sender: <xms:lLo_aSE9zwhmg8oQ9AcKn14p8yQzn10JmK1jQ7JWh40LNw_EQqQMNA>
    <xme:lLo_aaTBNJArC-5WOFzXC6lS54bw2TDntWTIIAyNl4zacBSY6sb5SM0i9kEmoo8Ar
    dHh71_yjIem9890Ybjsdsok4n_I9dmPxf6qo3Pe_pZh6qL2LpNsHg>
X-ME-Received: <xmr:lLo_aRw2wgNFOJXMlIlG3c1pgwTE9kbEiWM50o_dfKJMWgIS-igQ1k1urn1CHoP3s-9bPbAj8s7QXT9_YJkHJYaxRvCJB8fFu17_8ael>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefiedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:lLo_aROzk6iWM2P-LDFxKuPYiRgXWW-qhtRnHUvrTgioGw8jB048bw>
    <xmx:lLo_aYNGb6r6ZRCeb03cm6mKvyHiXAOnpMaFccRXXZGieXm9gdyJVw>
    <xmx:lLo_abSkKee70814e2pXEI5pG5Gl-cfsgH8nuZ1GtPG9si99iBW8Iw>
    <xmx:lLo_aSDio9PfIcEao7g0csUhj05odi16Ev8uBv1QvV6hT1_27oYHOA>
    <xmx:lLo_aUXtdputLyBOaTphpOGaZ8vGuUxnu5AkyRtGDINcwlYXX7poekb6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc151e0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Dec 2025 07:36:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Dec 2025 08:36:28 +0100
Subject: [PATCH 09/10] packfile: refactor `find_pack_entry()` to work on
 the packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-b4-pks-pack-store-via-source-v1-9-433aac465295@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `find_pack_entry()` doesn't work on a specific packfile
store, but instead works on the whole repository. This causes a bit of a
conceptual mismatch in its callers:

  - `packfile_store_freshen_object()` supposedly acts on a store, and
    its callers know to iterate through all sources already.

  - `packfile_store_read_object_info()` behaves likewise.

The only exception that doesn't know to handle iteration through sources
is `has_object_pack()`, but that function is trivial to adapt.

Refactor the code so that `find_pack_entry()` works on the packfile
store level instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/packfile.c b/packfile.c
index 3bce1b150d..0e4c63e11d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2087,29 +2087,23 @@ static int fill_pack_entry(const struct object_id *oid,
 	return 1;
 }
 
-static int find_pack_entry(struct repository *r,
+static int find_pack_entry(struct packfile_store *store,
 			   const struct object_id *oid,
 			   struct pack_entry *e)
 {
-	struct odb_source *source;
-
-	for (source = r->objects->sources; source; source = source->next) {
-		packfile_store_prepare(r->objects->sources->packfiles);
-		if (source->midx && fill_midx_entry(source->midx, oid, e))
-			return 1;
-	}
+	struct packfile_list_entry *l;
 
-	for (source = r->objects->sources; source; source = source->next) {
-		struct packfile_list_entry *l;
+	packfile_store_prepare(store);
+	if (store->source->midx && fill_midx_entry(store->source->midx, oid, e))
+		return 1;
 
-		for (l = source->packfiles->packs.head; l; l = l->next) {
-			struct packed_git *p = l->pack;
+	for (l = store->packs.head; l; l = l->next) {
+		struct packed_git *p = l->pack;
 
-			if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
-				if (!source->packfiles->skip_mru_updates)
-					packfile_list_prepend(&source->packfiles->packs, p);
-				return 1;
-			}
+		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
+			if (!store->skip_mru_updates)
+				packfile_list_prepend(&store->packs, p);
+			return 1;
 		}
 	}
 
@@ -2120,7 +2114,7 @@ int packfile_store_freshen_object(struct packfile_store *store,
 				  const struct object_id *oid)
 {
 	struct pack_entry e;
-	if (!find_pack_entry(store->source->odb->repo, oid, &e))
+	if (!find_pack_entry(store, oid, &e))
 		return 0;
 	if (e.p->is_cruft)
 		return 0;
@@ -2141,7 +2135,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	struct pack_entry e;
 	int rtype;
 
-	if (!find_pack_entry(store->source->odb->repo, oid, &e))
+	if (!find_pack_entry(store, oid, &e))
 		return 1;
 
 	/*
@@ -2217,8 +2211,17 @@ struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *st
 
 int has_object_pack(struct repository *r, const struct object_id *oid)
 {
+	struct odb_source *source;
 	struct pack_entry e;
-	return find_pack_entry(r, oid, &e);
+
+	odb_prepare_alternates(r->objects);
+	for (source = r->objects->sources; source; source = source->next) {
+		int ret = find_pack_entry(source->packfiles, oid, &e);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 int has_object_kept_pack(struct repository *r, const struct object_id *oid,

-- 
2.52.0.351.gbe84eed79e.dirty

