Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107662C3268
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040955; cv=none; b=XSdBGE43K1T78ZcXT71RDRHJPXekSq3ubhoQF27+tdZvoS1OQ8NE/f6RE/2s7RXsjWWlWkUx+HetS5YnsJGFkVZBdfeb3QcKXHfnKmL6P/NxayL7QMqKh21GWU8OZK9BA/yISmsDi+bsvGtNdUt1JGXuIqQTd3lkrnklbStjmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040955; c=relaxed/simple;
	bh=ZeANN6uRIshGkHjUlLFOLBVTOPKD9tNnOWy0qvfAtG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqlD0TyDKttaeA3OWI5cMqrqXgIOmpbIZAJwSXzkRvxFeTLAlAqIshEiwFwEJ4nOonrB9zS9WH835EIzPxR+kTyFhE+XL6awiZGaNeHtiYhTOYhiNAyqSyfvLHbH9YgeRkzW9X4Us+QZYnKsey2VIeEwAWuvj1vaDvOh3pnbl5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SLAQuKea; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n9Qrl6NO; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SLAQuKea";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n9Qrl6NO"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 50F0D7A019E;
	Thu, 18 Dec 2025 01:55:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 01:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766040953;
	 x=1766127353; bh=/9C83sc2Ty9tFXkY8k92WO8gNwmFFVP9U+GqsHcjg64=; b=
	SLAQuKea5aQxSEVKAidaAyCh2fMeoSla/9gpXWiIF658A7VRMcbNU2XWZZmkPlPQ
	oA6x6FwK2BtleFnoK/V0hv5CW/3aKYB16Jby2e0AKllYYSHlb95e+grNbZ8Og6mK
	BQ6W7dKP3dAnHEhKWxCfGpJfK8m+I8m709cFbPvUkhEJD/gX+gEC7ENhiGAxtnp6
	X5JrsyAuZRJr9/Go723tuR6dsNhVZslc8N7k/c8XsM4j78hR8a59SgA16DUC5aa/
	l04cbnhCPvjAd/ls531d7WVPP18IckCXM8yb5y/f+Sx27eNswF6cjEloYDK0bK/r
	N/+57Uw54mpYeejPL2TeXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766040953; x=
	1766127353; bh=/9C83sc2Ty9tFXkY8k92WO8gNwmFFVP9U+GqsHcjg64=; b=n
	9Qrl6NOGO73bDH1vLo4SZNU2TdO4+ee7BdhfZiraF1S7pPjmLfsnWJHx7ioMf1u4
	o3vEicqFLmJWDV+uhDe1vG6vRhCb4OebZgeCmEQ036tp//uPdnaHIjhchdOPsgsS
	AFALNnZgXnmJs8+P/dg9pCh326KQOkEilPXCoIRXMcLk2CUCkJ8dqkQsqadLVjUj
	Hf2oEeTdvbWwhUhHSbogtP+dKIAJATo7kCi4+/6+DsdRobe7f4p+tMlK85mbzoN2
	ktSi5BV0fK5noZI8TXcDG4U8yeb+BLsBmOCfZETD80K3VlZ+YsVrjKX3Z/pW8biO
	SwZtALd+VYoPtqsE3AiWg==
X-ME-Sender: <xms:eaVDaRLiI7BCODCcqAq1YYqZ7ullsQD0fhGxViNeYNpiDW48Oa9W_g>
    <xme:eaVDaTINjxlUQQPI3gJWlU_FOLCBhZSxDdzDv9iIVgn4xo9JGEmA5S-6Ln9qww9-j
    szykwqkwWLGydn9ss500vcMeAe6KD8-Lq8Qa_MS80PkSPBIP-q8Sw>
X-ME-Received: <xmr:eaVDaXWAJCITaao5ertfph5yPfCU4N6f6SsWD13663x4_P7dptBZLdW1pTqZU1d7wchmnh8xoX2tz-1IiiXftCzJ8cm14U6g_yCyjLTGLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eaVDadgYql5gT8PgCQwAqmux5OlM18pLi2lLqvF_cRIVSTJRC_2U-A>
    <xmx:eaVDaa8hpUFwlCQlhym883qmk3FtA8VmmAQQpcx8H6OWquERKtlbMw>
    <xmx:eaVDafB8fryfkHxWjdlh_XXNjDnsD6pjOEHw_h0CDSOenZQ3w7jM8w>
    <xmx:eaVDafKE7w7LQTUb9jVsyJ-QJ-UoHQRMSVxNMMZGNKI87pKp0qEWfg>
    <xmx:eaVDaS4uv6xhtiaDGrTribtEMjEXaQAXpVCsuaUd63Tl2brKSui44xEl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:55:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c1eaa089 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:55:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:55:28 +0100
Subject: [PATCH v2 09/10] packfile: refactor `find_pack_entry()` to work on
 the packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-pack-store-via-source-v2-9-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
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

