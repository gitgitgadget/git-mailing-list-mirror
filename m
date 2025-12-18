Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F392D8DB0
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040958; cv=none; b=b2YjTZWY+UDsnHixHwgHC0mfnQyM+/UyzQgTB4nzWfL4O6WkwnAAMMdB1LjrRuHwxk88C3fLBYcBpU6Aiw9WQTh9b3EucmwD87gtQwfl5BY6oAN08gK6iCPwTdsMrS3vrQnLFlFTtoYBNpGnctP9uaAOxkYqxgDRTjAcVA3fgS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040958; c=relaxed/simple;
	bh=agTNb2DTmYJtXxMH9NM5CdGtaih6noEA68avP0NJ7CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaNn9yCnOuVsFKQyOmUIa2ZkslL+2Bem1V8hbjNwQNEdoZFb/YRdWJ9BjuDiE6DKilCVxb/LTEYSZwDoElHTRzuU4ENOgT1dBZypmv21QgyuaX2D6i2/n1+EQHH3R8Le7qEf2IpZjAEMLSwJy11HjpwUT9FXZ1OkPL2lFRtwIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hvmrykrG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FT1BPSkm; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hvmrykrG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FT1BPSkm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5ED8C7A019E;
	Thu, 18 Dec 2025 01:55:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 01:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766040956;
	 x=1766127356; bh=pVBnFeMQa/I720PmasXUFUlUTk9LJFvp0S4tN/qhT3I=; b=
	hvmrykrGOqHc/Yfaw/mXn7q7epTrXf8gLF06pfmobzcBOaNxUq3lcl+smqCO/ERN
	Ek1R4X7jXOmheIr7ysvT8qeT0W86RQdTSQEFF2nEzQqHchBjAXlUG3xZ2ScHnk5E
	/KB4mlneaxedA/3uxP1KUC4oVCVpEsO/E9KLGiS6YYCLl03OZw1aWSY5w10f9UkI
	BQvSHam+75BUPSHW7zozGW/njQiuH4aFcBqagiRC9QtgbdyfRBuXSTeYc6lSW3Og
	YcRwaN991PmjZAQXIENqds74geH/3JqipXeRZn+GErRu1ikPETyP/EYePiqn8tuB
	tULjO1wFbZUs5fRlA7fCAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766040956; x=
	1766127356; bh=pVBnFeMQa/I720PmasXUFUlUTk9LJFvp0S4tN/qhT3I=; b=F
	T1BPSkmvXO0a/KR4DKTUiMNiN7j3r32sWurUktgvjMpnKzqWUPjK5dBW0xHD04Ms
	5Yc/kAmfS1s2hHrixRy7r0VTmgYTSHxr8v4YEgabqVIcUvoHgXigB3u3o/jqyg9+
	HhNSpsk/0UJWWIa5XEkBVaayv4QDRvKz4sX68Rx6ut2nAtIHDgD80z+iXSQwHEp1
	/kYtO2ROsYoptKJTJZW0n5gplXEvcUah+w7vF7NW5aw+lzHfpmLFcKUCyMIT8pTv
	yCKw1kvzqM4ckklRQvCdyUWAp/ahX8d2U8JaKumzLMDC7KkUd+4fsaVFfO9y7E8Q
	WdqDtFWTHiLOzQt5QPdCA==
X-ME-Sender: <xms:fKVDac6xweYQ_HsB-bhRMCH8nOK6JDs6ZcyHPyCD04mT1WPXIfkB1g>
    <xme:fKVDaT5os6y0z1QHgv17zcNrqNQBB8poW3kpAW9kiQLzIxtu20sXLIORQevYKh2JG
    wwPhQN6U8Mr3K6UhkgpaKl-ynloCGROFW35Tu-WPCziblLhQ9jERw>
X-ME-Received: <xmr:fKVDaZEMfMlp9q0TBYfEYCFmAhTizJHnc6DGReSzb3UbFBWpB2z4KO4oAHtGMgYoI_T_9KYkeJnPQQv29XUPAQvhNpLYz0MT-DetRqa9Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fKVDacToobhJl4u05oxw34jVEDYaA9KW-E2PXWZgA4woUSa3ng1AZw>
    <xmx:fKVDaSuxhoryMEynPPDYJuykicPQ5BFErUKTDNX8p4p8mxRQx-BSvA>
    <xmx:fKVDabz8wTmaFpMxeID-ZeEw1BPSXpEs4EdSVtoFW-YNhAJntYaLDw>
    <xmx:fKVDac42jsGiQWqAGZBnQPktmnPtoVx0b1AXCaLdAW7YPRyWT68pyQ>
    <xmx:fKVDaaqZguhrQigL9CD6YkAkOtUX64A-iVDAIPyMAZ-pmqrNep6Cxp6s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:55:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a40cbc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:55:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:55:29 +0100
Subject: [PATCH v2 10/10] packfile: move MIDX into packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-pack-store-via-source-v2-10-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
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
index 08a666d538..92baf8ee88 100644
--- a/packfile.h
+++ b/packfile.h
@@ -101,6 +101,9 @@ struct packfile_store {
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

