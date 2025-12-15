Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046B328B5D
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784221; cv=none; b=m7QnWr3qAjnPlO10o++FkBIXL8KgdYdEY9aeA58xUuQQpMamjLC0ow4PgSBHSAGdeGKHRjvFfkNgyWPQHyGL5WQvtFedg51azdgEWZIVZdn3whxJWp54IdXPdqnEWRiPssir3ZFqjIDZ6RdqZ2SE4jZDOm7G7Dx6YbWHkP91M5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784221; c=relaxed/simple;
	bh=mhSCmOEUeOo55BR3kus3J467JuqZWUwqhHn2Va3aQ9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5wLK05EMpGAYybofxMeiWGtzuz2ZAk2qhKaaz5rhaJx7RGVOO0OFBr07mBAjBClnV7WmvW2AZ7UYRlb8WPo0MA9kA5mKqDM5QptxGVql0EKeo2E5d1y2TjyXNFK57UkzeHVW/nX1DecoHlFuUZP33uu6vMEcBHasUg7fzUS5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lXvtGzRQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZTYM7XdF; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lXvtGzRQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZTYM7XdF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A640CEC00A6
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 15 Dec 2025 02:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765784215;
	 x=1765870615; bh=5EpXMpxY8iEZe42wEkIfhOKJAKRENMf7NpMIaAi97gs=; b=
	lXvtGzRQwXswHGjK1zblzyZAKybzPrNFHSV8eQxUtR9OYOVcXZLbUvxEZQ1fg9bS
	lrcnxHiIufybhm3ddWYhQL90ewz+lpSHltBqLEMw2f9Kjf299TioIQbgn1C/nbuN
	QkdpvUkK2g7L6fix2kTXLo+aIhUELnSkyp8gD+t8geuHIxgU2u16xMEo8AfUCKk+
	Ct3V0PE3G36QcJs0gXISxHdoDxBYfHWFNFquVvwgvLivUrT2pfhuUgwG3wOY5Lir
	ulN/VUlcvlZbVnljjBt4nvsZ9zIb1jS7thPD6TfCeF4el5V/c5/z8NALo5xeag/Z
	z7NSvhwnEIEpuFW4toaIgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765784215; x=
	1765870615; bh=5EpXMpxY8iEZe42wEkIfhOKJAKRENMf7NpMIaAi97gs=; b=Z
	TYM7XdFEAeOmoCe9h8P+RfEXoG2kvna+IG6MRr58jle2DL3IcMxJHFQWSW8YelD5
	9IKPLJiNWbVnfmgtR+rV74hiUHr2T42Y3JjETYO6T/+3X0T9Ng/eLwNwYXW9n8iM
	jeldb1koxKauJ61+3JZQ6npe4M8XMVWiaDkFTpovMrNBdhQn9IjZ8PEfbJjEDqSU
	dzcZDL2IWeTU9NGr+E7Lyxu/qQqb4sLcihbp9a2ia5LgNBqDnZlRZB40jgTO9XnR
	FxscnY2IEPZpPBavFlyvGWeFhEsgjwJRQUcwwxf/65msn8WYaV9LVhVpVo9okN+t
	ezqSMkYpdmI3sabSwbWSA==
X-ME-Sender: <xms:l7o_aU0agY5Aq8D9UKQ0d7qz0oEqUxCf33dfKAlZp9rFpVeVeN5n2w>
    <xme:l7o_aWB1NVaeDBqhzuiXbfVXnI_Xw00YuWDTJ71KV7oOyAYu6ymK-HbXhCAuS_pUw
    C4LBk9F_udLXMyXFgRSab5tvBBWgxGWNX7a-mJjd_orLA9xImJQ0A>
X-ME-Received: <xmr:l7o_aSil2axsjJ2U_ZYTZ6yOIOkOHC0ciE5Jw7_qsZKhwIqY0iJzG1fEbTyeU8DxEQSLla-CKcfpR-nfL_P5dHwRVaE-T0WZdEl5aXAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefiedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:l7o_aS_DYnyvHVZebeP9IjCsGP0MoMyAwaK59zhXMm_YJAJxTWh_0Q>
    <xmx:l7o_aW9K4gPBDsWeH9xRPm_ESyZxa2BWdlk18oC8FzppR2V7fC3B3g>
    <xmx:l7o_aTBYOJj7Duza8wVvelIcbE0q4MhdultLr6tBULDPM_TxHW7PnA>
    <xmx:l7o_aey1d2oM_gKCMZGQZR7HA9hrZzoZ54JrIZQyY3qTgi0Usr054w>
    <xmx:l7o_aWE82s17TbF9Nx902Z_4YxnwEQsAtaSg6Mbf9otwFg4y8wTT-jtY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 47fdb2c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Dec 2025 07:36:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Dec 2025 08:36:29 +0100
Subject: [PATCH 10/10] packfile: move MIDX into packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-b4-pks-pack-store-via-source-v1-10-433aac465295@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The multi-pack index still is tracked as a member of the object database
source, but ultimately the MIDX is always tied to one specific packfile
store.

Move the structure into `struct packfile_store` accordingly. This
ensures that the packfile store now keeps track of all data related to
packfiles.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 14 +++++++-------
 odb.c      |  8 +-------
 odb.h      |  7 -------
 packfile.c | 12 ++++++++----
 packfile.h |  3 +++
 5 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/midx.c b/midx.c
index dbb2aa68ba..fa7a7e5d13 100644
--- a/midx.c
+++ b/midx.c
@@ -96,7 +96,7 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 {
 	packfile_store_prepare(source->packfiles);
-	return source->midx;
+	return source->packfiles->midx;
 }
 
 static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *source,
@@ -709,12 +709,12 @@ int prepare_multi_pack_index_one(struct odb_source *source)
 	if (!r->settings.core_multi_pack_index)
 		return 0;
 
-	if (source->midx)
+	if (source->packfiles->midx)
 		return 1;
 
-	source->midx = load_multi_pack_index(source);
+	source->packfiles->midx = load_multi_pack_index(source);
 
-	return !!source->midx;
+	return !!source->packfiles->midx;
 }
 
 int midx_checksum_valid(struct multi_pack_index *m)
@@ -803,9 +803,9 @@ void clear_midx_file(struct repository *r)
 		struct odb_source *source;
 
 		for (source = r->objects->sources; source; source = source->next) {
-			if (source->midx)
-				close_midx(source->midx);
-			source->midx = NULL;
+			if (source->packfiles->midx)
+				close_midx(source->packfiles->midx);
+			source->packfiles->midx = NULL;
 		}
 	}
 
diff --git a/odb.c b/odb.c
index f159fbdd99..902251f9ed 100644
--- a/odb.c
+++ b/odb.c
@@ -1078,14 +1078,8 @@ struct object_database *odb_new(struct repository *repo,
 void odb_close(struct object_database *o)
 {
 	struct odb_source *source;
-
-	for (source = o->sources; source; source = source->next) {
+	for (source = o->sources; source; source = source->next)
 		packfile_store_close(source->packfiles);
-		if (source->midx)
-			close_midx(source->midx);
-		source->midx = NULL;
-	}
-
 	close_commit_graph(o);
 }
 
diff --git a/odb.h b/odb.h
index c97b41c58c..300c3c0c46 100644
--- a/odb.h
+++ b/odb.h
@@ -54,13 +54,6 @@ struct odb_source {
 	/* Should only be accessed directly by packfile.c and midx.c. */
 	struct packfile_store *packfiles;
 
-	/*
-	 * private data
-	 *
-	 * should only be accessed directly by packfile.c and midx.c
-	 */
-	struct multi_pack_index *midx;
-
 	/*
 	 * Figure out whether this is the local source of the owning
 	 * repository, which would typically be its ".git/objects" directory.
diff --git a/packfile.c b/packfile.c
index 0e4c63e11d..097dd8d85d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -990,7 +990,8 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	size_t base_len = full_name_len;
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
-	    !(data->source->midx && midx_contains_pack(data->source->midx, file_name))) {
+	    !(data->source->packfiles->midx &&
+	      midx_contains_pack(data->source->packfiles->midx, file_name))) {
 		char *trimmed_path = xstrndup(full_name, full_name_len);
 		packfile_store_load_pack(data->source->packfiles,
 					 trimmed_path, data->source->local);
@@ -1087,8 +1088,8 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 {
 	packfile_store_prepare(store);
 
-	if (store->source->midx) {
-		struct multi_pack_index *m = store->source->midx;
+	if (store->midx) {
+		struct multi_pack_index *m = store->midx;
 		for (uint32_t i = 0; i < m->num_packs + m->num_packs_in_base; i++)
 			prepare_midx_pack(m, i);
 	}
@@ -2094,7 +2095,7 @@ static int find_pack_entry(struct packfile_store *store,
 	struct packfile_list_entry *l;
 
 	packfile_store_prepare(store);
-	if (store->source->midx && fill_midx_entry(store->source->midx, oid, e))
+	if (store->midx && fill_midx_entry(store->midx, oid, e))
 		return 1;
 
 	for (l = store->packs.head; l; l = l->next) {
@@ -2454,6 +2455,9 @@ void packfile_store_close(struct packfile_store *store)
 			BUG("want to close pack marked 'do-not-close'");
 		close_pack(e->pack);
 	}
+	if (store->midx)
+		close_midx(store->midx);
+	store->midx = NULL;
 }
 
 struct odb_packed_read_stream {
diff --git a/packfile.h b/packfile.h
index 2fb87a26d6..fb832a33e3 100644
--- a/packfile.h
+++ b/packfile.h
@@ -100,6 +100,9 @@ struct packfile_store {
 		unsigned flags;
 	} kept_cache;
 
+	/* The multi-pack index that belongs to this specific packfile store. */
+	struct multi_pack_index *midx;
+
 	/*
 	 * A map of packfile names to packed_git structs for tracking which
 	 * packs have been loaded already.

-- 
2.52.0.351.gbe84eed79e.dirty

