Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC912D948C
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578973; cv=none; b=ueNhu/MQPbRpgkxr3EZZNTIRm4nSOx7XFwlqbXOZZPEEkA7YzEUSGe8rpKGQzwLF/za/dsj3TZFpVO45HlbRrCVG00r7bpuKKq4DtQnvRxH8wfOekzHTbZlAwM2oSQOgqJsbSqat7IUrn5KSwpCPUm/PP/VIyZDC+efcrDsGeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578973; c=relaxed/simple;
	bh=6I6938/KtljqerfPpglB+uJtgoYN2SN2CZGn3dp8tL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkecZBrwW4tFeVNlysAZQD3C0L0zuYWUtZXGmVx/L7vCWwFaE3aUhgJWXMIlZyzde1vx7jfK4PyVxFtJhPh3svjdnP4bAOwPLmErExGuBUNuIf42esF1FMELvllg9AZy0G3+Fu9aPBttdXNO2P6nKaz/3YD9wuQOnzRRNHYNGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y6kyVWPN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lv3D9N+p; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y6kyVWPN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lv3D9N+p"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EBAD114002D5;
	Tue, 15 Jul 2025 07:29:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 15 Jul 2025 07:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752578969;
	 x=1752665369; bh=+IcxAJRXnHpCDiqZmBMs1G7XOXjjGtO45vdEWn3l2kc=; b=
	y6kyVWPNadsPVCz0PGT2mYTlzW6G7igLWFp0hWgBXwLlS83i7lFmHHgOoqOemaQJ
	u82bQj/rIGroSgb6kLnmBVklXxz+biiZ12X2D/Ui7CIOBpgwd/a13dXPtm1nZk1C
	I1leNwGM82/MFrNYuwjF+hoK39a05oh4ySZrwl/DJC02DbxuSSxzVigzaLZ+Ydhp
	F0Xj4CwFkySTbCputuoceDgC3JpENkeaor2SU/7HUdY618VkqVuxFuwYdbvp2MtQ
	PDgJJQgO/1Q1TomC5mHWXKvw/SPP9wTLNd8eI92X4+qM0ml3YZxOyPLzMJ1Yv0dQ
	xg1mrR7eLIo0EGUcnfyjIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752578969; x=
	1752665369; bh=+IcxAJRXnHpCDiqZmBMs1G7XOXjjGtO45vdEWn3l2kc=; b=l
	v3D9N+phDwQFKidWbyB1hWQaEaKCh12DYBtU3GhPS49RKbwX0xUuYbxPsdqqKNU4
	fQysr7JmpRcuPPqsH78Mva5O5mYvkB7TiC4Nea9+/9MnK8lMrTcrt9QzjXyfbBDs
	rVZwMgNl51MMhDl4M5NtqQZeTcLCnwz3/zi//DOMmYqas7nC2Cojy/EoxigrTbx0
	CwZ2bcyQ48Xhb0ccS9Q3SkHJvx+85AU3SIk3fQznarf4qFr7DolHy4iA5Gssomj+
	Uu9/a/ceoM3Bq+epUhcV1lIb9IQMeFaCOmy9tTMrIe0+HnTS6ZlqpjOwUKcFGiun
	NkuhGSl2TBFJGtf1IrNng==
X-ME-Sender: <xms:mTt2aDsjVxUMUuFNzICZFI4ybqVupUCM66VcNYT_28jUvGSowfPSqg>
    <xme:mTt2aCQQRd2XBGAS3c2j1r8vfoJG2XXz4O_ol3D7WesApC9-quSsafcoMBPA7VDIx
    jyUiej2CSb8vqu4rQ>
X-ME-Received: <xmr:mTt2aBNtWQmHEQ_1nxTOBecdvHiQLVv5HO254NSZX-Hr5_AwFlwnSwwKbl7062BhjwoiWAop4ozVtZdKngzuOLzpcAp9a3vIbXnSQWGBdr8uxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mTt2aPbQLKkm_cN2KUze_lFTyRemGxe74o6LOcjRKEzfmVw4-WVakQ>
    <xmx:mTt2aDwQhcpkYIqOX4P6oCHm8hEWZmVrr3iTJdkiIDUfFAX7IUlcpw>
    <xmx:mTt2aCK4uuHfmvzUGZUhG8Tbzoru3sqJ2e8qM1dzBJHs72CtbvtiCQ>
    <xmx:mTt2aFqFWbyahtkYKVtohuFHscfyrSVI_Cs-Wtd6pVBtSLPIy--iFA>
    <xmx:mTt2aEtNe_Lz6fDpUkV2ClzJ-VgsYZi6mfYd0G5JCWH0MjrCDOnzlM0q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 07:29:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51be5a7b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 11:29:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Jul 2025 13:29:18 +0200
Subject: [PATCH v2 1/7] midx: start tracking per object database source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-b4-pks-midx-via-odb-alternate-v2-1-b0ca0b4b516e@pks.im>
References: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
In-Reply-To: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Multi-pack indices are tracked via `struct multi_pack_index`. This data
structure is stored as a linked list inside `struct object_database`,
which is the global database that spans across all of the object
sources.

This layout causes two problems:

  - Object databases consist of multiple object sources (e.g. one source
    per alternate object directory), where each multi-pack index is
    specific to one of those sources. Regardless of that though, the
    MIDX is not tracked per source, but tracked globally for the whole
    object database. This creates a mismatch between the on-disk layout
    and how things are organized in the object database subsystems and
    makes some parts, like figuring out whether a source has an MIDX,
    quite awkward.

  - Multi-pack indices are an implementation detail of how efficient
    access for packfiles work. As such, they are neither relevant in the
    context of loose objects, nor in a potential future where we have
    pluggable backends.

Refactor `prepare_multi_pack_index_one()` so that it works on a specific
source, which allows us to easily store a pointer to the multi-pack
index inside of it. For now, this pointer exists next to the existing
linked list we have in the object database. Users will be adjusted in
subsequent patches to instead use the per-source pointers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 19 +++++++++++--------
 midx.h     |  3 ++-
 odb.h      |  9 ++++++++-
 packfile.c |  4 +++-
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/midx.c b/midx.c
index 3c5bc821730..2f64c26058f 100644
--- a/midx.c
+++ b/midx.c
@@ -724,28 +724,29 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 	return 0;
 }
 
-int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local)
+int prepare_multi_pack_index_one(struct odb_source *source, int local)
 {
+	struct repository *r = source->odb->repo;
 	struct multi_pack_index *m;
-	struct multi_pack_index *m_search;
 
 	prepare_repo_settings(r);
 	if (!r->settings.core_multi_pack_index)
 		return 0;
 
-	for (m_search = r->objects->multi_pack_index; m_search; m_search = m_search->next)
-		if (!strcmp(object_dir, m_search->object_dir))
-			return 1;
-
-	m = load_multi_pack_index(r, object_dir, local);
+	if (source->midx)
+		return 1;
 
+	m = load_multi_pack_index(r, source->path, local);
 	if (m) {
 		struct multi_pack_index *mp = r->objects->multi_pack_index;
 		if (mp) {
 			m->next = mp->next;
 			mp->next = m;
-		} else
+		} else {
 			r->objects->multi_pack_index = m;
+		}
+		source->midx = m;
+
 		return 1;
 	}
 
@@ -837,6 +838,8 @@ void clear_midx_file(struct repository *r)
 	if (r->objects && r->objects->multi_pack_index) {
 		close_midx(r->objects->multi_pack_index);
 		r->objects->multi_pack_index = NULL;
+		for (struct odb_source *source = r->objects->sources; source; source = source->next)
+			source->midx = NULL;
 	}
 
 	if (remove_path(midx.buf))
diff --git a/midx.h b/midx.h
index 9d1374cbd58..639a6f50e45 100644
--- a/midx.h
+++ b/midx.h
@@ -8,6 +8,7 @@ struct pack_entry;
 struct repository;
 struct bitmapped_pack;
 struct git_hash_algo;
+struct odb_source;
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -123,7 +124,7 @@ int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pa
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
-int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
+int prepare_multi_pack_index_one(struct odb_source *source, int local);
 
 /*
  * Variant of write_midx_file which writes a MIDX containing only the packs
diff --git a/odb.h b/odb.h
index e922f256802..f09dba1fe1d 100644
--- a/odb.h
+++ b/odb.h
@@ -13,6 +13,7 @@ struct oidmap;
 struct oidtree;
 struct strbuf;
 struct repository;
+struct multi_pack_index;
 
 /*
  * Compute the exact path an alternate is at and returns it. In case of
@@ -55,6 +56,13 @@ struct odb_source {
 	/* Map between object IDs for loose objects. */
 	struct loose_object_map *loose_map;
 
+	/*
+	 * private data
+	 *
+	 * should only be accessed directly by packfile.c and midx.c
+	 */
+	struct multi_pack_index *midx;
+
 	/*
 	 * This is a temporary object store created by the tmp_objdir
 	 * facility. Disable ref updates since the objects in the store
@@ -75,7 +83,6 @@ struct odb_source {
 };
 
 struct packed_git;
-struct multi_pack_index;
 struct cached_object_entry;
 
 /*
diff --git a/packfile.c b/packfile.c
index af9ccfdba62..8bdd85fc7e7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -372,6 +372,8 @@ void close_object_store(struct object_database *o)
 	if (o->multi_pack_index) {
 		close_midx(o->multi_pack_index);
 		o->multi_pack_index = NULL;
+		for (struct odb_source *source = o->sources; source; source = source->next)
+			source->midx = NULL;
 	}
 
 	close_commit_graph(o);
@@ -1037,7 +1039,7 @@ static void prepare_packed_git(struct repository *r)
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		int local = (source == r->objects->sources);
-		prepare_multi_pack_index_one(r, source->path, local);
+		prepare_multi_pack_index_one(source, local);
 		prepare_packed_git_one(r, source->path, local);
 	}
 	rearrange_packed_git(r);

-- 
2.50.1.404.ge9779f6434.dirty

