Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95434887C
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947599; cv=none; b=cqj83drHvO65TMZS+Qnk754325PNAeWE+qQENumT071h7LSFNRjtHJ3b6HjfzQgwjw0/yI8L36Q5FSV7Wc75UOPmW1ZwkYapH0w/AIXA7MvdOT4RgyS7R/JXmQtqIqIXqv2L+2l7kDOPjuPXlHJMJKBvvTZPEBFYIGXKAGJVwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947599; c=relaxed/simple;
	bh=YUBOwC7Lb9yeajCVbDZvvZMkM3ApfJQ2zDV4X0eZm5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNHmkld4m8JWAuyXxXmayxbhZsBCVdTcvkRLrv/HNmVJDDgkfmVFYlfNsNpymW7AV6/oFMq/MhOrJcZ+UY8oKrCNbHhWeAaR4veggau8m7+4caKlG2S9K/S4hXWuzpfNWkgNGanKKL0ghmz9JslMCmKdQc63YgeGtR4TtpPAkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M/I9vZ9z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wy8R730q; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M/I9vZ9z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wy8R730q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61E34140005E;
	Fri,  9 Jan 2026 03:33:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 03:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947597;
	 x=1768033997; bh=RMBGYRN8r+YPbpU0uSK9GulzVYArBi8nkDiOgZtw0dQ=; b=
	M/I9vZ9zRtExs8Ua9yYan3okbdibi1KixlVEyCrmgfFO2+g8OY944Qq0P4cvFsSx
	GbvCMd+l6ccswHqqjigzknUggHzScUQ2OvQtFq7xWXdMSxemsT9JMfnX/YCpi4nP
	ZJbhNQ1glmAOkzqxuSDG8pCh3WxUHxibN8VKuaOQ16SVfbSkA2oEAgpS/R60hei4
	CSGdN1QkFyFFQSYyX5UX/Pu9uh6N9+afDDfRjbXNLrgRwtwJzCQecppO2cbAIdpY
	5k0d4aqDEIOHVwopr/xY5080u5irxJCLn4dLV/uoyu4CLuBP2zfp3TShSw4O2oru
	5SAwwxTDOQ1yAHW1bQRQRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947597; x=
	1768033997; bh=RMBGYRN8r+YPbpU0uSK9GulzVYArBi8nkDiOgZtw0dQ=; b=w
	y8R730q/Eh1sLxfNQvus9ukLfucUqqlrpy3t7wIOzhANnACmdk6eVxaFEwYbKlgy
	ULzTUdNhZJn7rX3YB1f8cppbI8e/KuM6qnIoheA1MJCGSUIhSFwfsclvbZNcinZ4
	nybNRaMxcUI4AXPzwNGfjU9+1U8tsojYQgR/Q19UMCVJH9l/yodS4whNPLRs6ATp
	9FKh9C46IW8A2bDjqer/ET/fwM15gkWw1uJgcaF8ptPYX02DJ9fpVUZgThtaZCs/
	E7X9Le7ydttVfJYOBOqX1FmJmO7Mo1IXKst52guCekf3mTLxAReMcBvkkguuVAfI
	Y2JDvRf/bqngV0ScTSf4A==
X-ME-Sender: <xms:Tb1gadaQwDIdwEaUvRsyK0YkdcO9ZnmxNTHV8lkUPfBmnBImK0IMdw>
    <xme:Tb1gabavlBryZzpmvCEb4GCY1HmbQFCljdoKCrIqzTTSteCF4fsBJdvOtc6EJXwxW
    0MeWA3Ja5Gbbv7N-4fviznagva3JhtQjPcmXGHtUYjXkc1gJ3e2WQ>
X-ME-Received: <xmr:Tb1gaU9i3iR6ryutNJ7ZFmqklo24Na832YdRt33j2i3Lp_GpT5kfaj5zCXLdncyDnSfTWwovBi7Gb1WJrEffpeGLFjY0dBsIBayiSqUpVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Tb1gaajj9npZHTjmeEIdEKd1B-O45v_J8g1e7D2cRJ2dJ4Zdex548w>
    <xmx:Tb1gaUcUyWeM5vFgY0FKwoyBFaoswpc7FTkbZMrJgs5wz9Nl34bW1A>
    <xmx:Tb1gaRq632rTyn9KPRya60j9VBtTpCFkYWS-PKCbZuFW2I2jfoUMpg>
    <xmx:Tb1gaZCsWCbL5pckl_L56Os6umDg2rjeft36kb04ma4UdbhbBz9QXA>
    <xmx:Tb1gaZ-k8kJShgsJuzG_yZnso9fYV6K7e3ULG5H9OCrS9AlVgIxuJyCR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:33:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 89e61b84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:33:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 09:33:09 +0100
Subject: [PATCH v3 01/10] packfile: create store via its owning source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-pks-pack-store-via-source-v3-1-877fd7b7bf81@pks.im>
References: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
In-Reply-To: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

In subsequent patches we're about to move the packfile store from the
object database layer into the object database source layer. Once done,
we'll have one packfile store per source, where the source is owning the
store.

Prepare for this future and refactor `packfile_store_new()` to be
initialized via an object database source instead of via the object
database itself.

This refactoring leads to a weird in-between state where the store is
owned by the object database but created via the source. But this makes
subsequent refactorings easier because we can now start to access the
owning source of a given store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c      |  2 +-
 packfile.c | 20 ++++++++++----------
 packfile.h |  6 +++---
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/odb.c b/odb.c
index 45b6600800..94144a69f5 100644
--- a/odb.c
+++ b/odb.c
@@ -1056,7 +1056,6 @@ struct object_database *odb_new(struct repository *repo,
 
 	memset(o, 0, sizeof(*o));
 	o->repo = repo;
-	o->packfiles = packfile_store_new(o);
 	pthread_mutex_init(&o->replace_mutex, NULL);
 	string_list_init_dup(&o->submodule_source_paths);
 
@@ -1065,6 +1064,7 @@ struct object_database *odb_new(struct repository *repo,
 	o->sources = odb_source_new(o, primary_source, true);
 	o->sources_tail = &o->sources->next;
 	o->alternate_db = xstrdup_or_null(secondary_sources);
+	o->packfiles = packfile_store_new(o->sources);
 
 	free(to_free);
 
diff --git a/packfile.c b/packfile.c
index c88bd92619..0a05a10daa 100644
--- a/packfile.c
+++ b/packfile.c
@@ -876,7 +876,7 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
 
 	p = strmap_get(&store->packs_by_path, key.buf);
 	if (!p) {
-		p = add_packed_git(store->odb->repo, idx_path,
+		p = add_packed_git(store->source->odb->repo, idx_path,
 				   strlen(idx_path), local);
 		if (p)
 			packfile_store_add_pack(store, p);
@@ -1068,8 +1068,8 @@ void packfile_store_prepare(struct packfile_store *store)
 	if (store->initialized)
 		return;
 
-	odb_prepare_alternates(store->odb);
-	for (source = store->odb->sources; source; source = source->next) {
+	odb_prepare_alternates(store->source->odb);
+	for (source = store->source->odb->sources; source; source = source->next) {
 		prepare_multi_pack_index_one(source);
 		prepare_packed_git_one(source);
 	}
@@ -1092,7 +1092,7 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 {
 	packfile_store_prepare(store);
 
-	for (struct odb_source *source = store->odb->sources; source; source = source->next) {
+	for (struct odb_source *source = store->source->odb->sources; source; source = source->next) {
 		struct multi_pack_index *m = source->midx;
 		if (!m)
 			continue;
@@ -2121,7 +2121,7 @@ int packfile_store_freshen_object(struct packfile_store *store,
 				  const struct object_id *oid)
 {
 	struct pack_entry e;
-	if (!find_pack_entry(store->odb->repo, oid, &e))
+	if (!find_pack_entry(store->source->odb->repo, oid, &e))
 		return 0;
 	if (e.p->is_cruft)
 		return 0;
@@ -2142,7 +2142,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	struct pack_entry e;
 	int rtype;
 
-	if (!find_pack_entry(store->odb->repo, oid, &e))
+	if (!find_pack_entry(store->source->odb->repo, oid, &e))
 		return 1;
 
 	/*
@@ -2152,7 +2152,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (oi == &blank_oi)
 		return 0;
 
-	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
+	rtype = packed_object_info(store->source->odb->repo, e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, oid);
 		return -1;
@@ -2411,11 +2411,11 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
-struct packfile_store *packfile_store_new(struct object_database *odb)
+struct packfile_store *packfile_store_new(struct odb_source *source)
 {
 	struct packfile_store *store;
 	CALLOC_ARRAY(store, 1);
-	store->odb = odb;
+	store->source = source;
 	strmap_init(&store->packs_by_path);
 	return store;
 }
@@ -2534,7 +2534,7 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
 
 	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
 	    oi.u.packed.is_delta ||
-	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
+	    repo_settings_get_big_file_threshold(store->source->odb->repo) >= size)
 		return -1;
 
 	in_pack_type = unpack_object_header(oi.u.packed.pack,
diff --git a/packfile.h b/packfile.h
index 59d162a3f4..33cc1c1654 100644
--- a/packfile.h
+++ b/packfile.h
@@ -77,7 +77,7 @@ struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
  * A store that manages packfiles for a given object database.
  */
 struct packfile_store {
-	struct object_database *odb;
+	struct odb_source *source;
 
 	/*
 	 * The list of packfiles in the order in which they have been most
@@ -129,9 +129,9 @@ struct packfile_store {
 
 /*
  * Allocate and initialize a new empty packfile store for the given object
- * database.
+ * database source.
  */
-struct packfile_store *packfile_store_new(struct object_database *odb);
+struct packfile_store *packfile_store_new(struct odb_source *source);
 
 /*
  * Free the packfile store and all its associated state. All packfiles

-- 
2.52.0.542.g9473a8513b.dirty

