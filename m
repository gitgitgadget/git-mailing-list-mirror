Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5134BA21
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947624; cv=none; b=BLuGjMtHpFRXv8LtK7iufzbBv3BR4JyQCbNxmp+DcrTEZ+Fbyasc18KwaLo+nGh4Xls8CCDJaO6lyU/peeTArvmQ52/+l6a81FfGUfNwb+GnKRhup2SDIvnYz1ct1yEfnEQwf7wMZESIlC8MJCmPtJX/0iVEVP3zfxx1KRzNMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947624; c=relaxed/simple;
	bh=RBuhbHUASw1xK5WCLAF9O+SK+9MhtLKYwXNhILjvl78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g24cmA45bH8jIeho71+lfvSZsJs8cS0IAMhSkzyILWaotZfkCkED4OFtUuLvGAFeD2blQbi1KucAu+VgtBvZXE7elktca+qusQIi5l859sbu2ASFjtZDZygiuKTdgKG/9+YhKBDYa3qXvP4Lgc1V9WkHioV9TktmzPrQPO+7W5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FBIz6EVn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w8kmBOH+; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FBIz6EVn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w8kmBOH+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4BB014000CE;
	Fri,  9 Jan 2026 03:33:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 03:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947620;
	 x=1768034020; bh=yxcj9g722dQzc8vwYpHlM9tioAi4oM5OPa1M+sc/K8U=; b=
	FBIz6EVnRdmLQr7SuBRj16SwFuGsbBTVfAtTFdZZreO+iVwcLyDXgMusfu2kwHeh
	3YK7qkFCi62kx8MzzNrr5wBcT7MJ+bKb1MBj4BZLSK5xtNpTXtNcU2AmqukndFRh
	0/K7fZHWAPGo13WCsP7dRO/PEwau0LjRffdhIghiigmDL/hEdk/KFYWD84J0eWyd
	md5oRX7TBhufDt83QPp+G58KGN/7PF1laIqgTI/2SFsdGMRrJpA6x05bw47NneXV
	GMaUkPV4/DjLnlxCw7Y9pPS18hLsyS0S7oBxm/ysQRko78DpbgoEVQjF74ck4ybt
	eCqVnJ5qcbRhetA0/3urpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947620; x=
	1768034020; bh=yxcj9g722dQzc8vwYpHlM9tioAi4oM5OPa1M+sc/K8U=; b=w
	8kmBOH+WSWaJYDKEfmmnKz1IejvN8VERyUB6klFI6+kwqwQn+PBvHQW3XvnwyGLH
	vN2AKE7B76Kw6dqs/jDY+uNdX5T8DYw30gWd4Rp32hj5+R/7a4iaupi1TWgnyn4Z
	6X+XswjntXKidwH1EArrhvDMtWQ3yGsaAemvHWfq3PNpbY7wlL3X/RH54EDEhyMd
	SwwdhU7+QkFnbTATrp/n+ZXGnbDsWND7gWUTjG6m7F1LwHLsYwmbkdjm49u/f3Cr
	Hk98nmV4cxVxeULKU36s+YuR1sxXjrMTTnYpT7m4dcW0o7emidIV3INnasgzlEmf
	mkDURGaEnXDoO0kbWEnGQ==
X-ME-Sender: <xms:ZL1gaVGAAdJRXng9ihw6vUM-wG-3FsPFbc45vprHqEfntSohc-8ggA>
    <xme:ZL1gaRUpx6_MRiotUi7X6FgZPK9krw6wjJ4JPhkTmXBvj8XBCMSTAdRIjM_5qt9u7
    0kUu-jYOipxoiX8tUf4yMD_SZbV6SeMGz0949U54L31LHp8wTyP7Q>
X-ME-Received: <xmr:ZL1gacJp-0mbTeQqxBmWhR8t3CE6NWGbH1Lfpv251b6LIYXf1XIcfx9APDkWq8YejDZPyMdkHmNsQZjPUQVvcwe4xAergyZi15X27w9K-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgs
    lhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:ZL1gaZ9hCPWm2JOBuzopawUzB70CgRk9LB4uyb_5hD1rOafEaXA0PQ>
    <xmx:ZL1gaXKgG2qcVKmTZK6C3hV0Y9YCxXHADppOwYrKWXO8_XteZqnAhg>
    <xmx:ZL1gaWkKmBNX71KXWFT3kWUB4STFNSTuO3Li1W3bm1pKceqONCbGWg>
    <xmx:ZL1gaTPYzR_Z599cb1zUcftIhz0YkTv1kQjBDqEnaGJPy08ZTLimxw>
    <xmx:ZL1gaWHzc2py57wBH65P6aKt9E-725vVteT-0GdYsgII4uLms6CbmVFp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:33:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3340d995 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:33:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 09:33:18 +0100
Subject: [PATCH v3 10/10] packfile: move MIDX into packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-pks-pack-store-via-source-v3-10-877fd7b7bf81@pks.im>
References: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
In-Reply-To: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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
2.52.0.542.g9473a8513b.dirty

