Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919228313D
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784191; cv=none; b=L/Kuvr4ydotLoIAq0GLq4JtYWbc5Q/9XWFELTH5tzpc+MU6ugdN+zGUThLmltHE+C7WRmIpPWAtCXqzZYxiSx0IRgyKl5SBNz/YykIa/mG8O1P+Gm6mA5nzPw2Y1QbSkGK7P5yzjkae19MwGsj1RbxzCeHixrG8mO2cP2/e2rvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784191; c=relaxed/simple;
	bh=bBW5Ras0rJyLTuUmzBdENkPqOJLrDuwf9c2J+6PWMZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNtfTfV9JMuHh3fA7vSbTls46yXD87y4JiSZsDDISIjWLQilZaUX3IH+qcWLbWu4whMxaviW8MYAk75o2a4upe6TTmQOVwmrt8lbnk0U+JMsx/QwfhUVyNJnwMPTrm2UnOVj53Or/v+zJSQevvi668KwEeVzMax1oZ8yKVa6ipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uaezKlci; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xq96VYJ2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uaezKlci";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xq96VYJ2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 408A4EC009D
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Dec 2025 02:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765784188;
	 x=1765870588; bh=G7/lqDzH0LI+RwQ6hWLOrNx89kKtW3QD27ZWO5RGKvA=; b=
	uaezKlcipnx4ZFk/JRQ8QDu10SsaP9bCXAfSieKrge3PvXDz/mFAfXHJf8aYJEJd
	oTLw19Uran7NDV3ok+qkolVGCho+Xd6gCvVNWL1fkRbAAfk3U8OI9DqtIRtuqece
	//XzG/QKN9kIN0PJANboWN87xTee3dWB9HSFipIMVkO6akPThou5bQXWAk6EGdma
	zOJ5iO7muIhO+ULtakVaxhpiS1hk36q126StNcYVigkhCH+fwH6reGsITkIp8WLl
	y2IV0vsERf7OIaUPtDyGxNmgBG2mmuvwcne3+/LIScyyVmgWVanpAd7VYCvpWYd2
	GSFOYUjES0TrEBPEctWaYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765784188; x=
	1765870588; bh=G7/lqDzH0LI+RwQ6hWLOrNx89kKtW3QD27ZWO5RGKvA=; b=X
	q96VYJ2baXyxFdUThRLt4ICYsE7zXslf7J+ZcG1kA0zsY4OWdGgd10/wGF/ygrxm
	UKu3dXP/Eng2y9FOEOwajrt0RwJ8wxrzAmiGfrx/o73INW0TAwF7c51X34+ZLiYz
	T39ji07IiK6MSrhUmOvv7dQCZs9K9CK8C1Mx5812/bQAwfr4uO5C+bDhm93IkoKh
	roSSpOkzgM73EqCbh79HzDL0j6t3ALAP99QwSEtvCA+bLKdsbtQ/PkUXJ497Cmn9
	gAi31wvs1a4MsBahfG8bfrk5udfeF2L0n/Nkd6c0e5nb5ImmZANr+A/PqldsMJ0h
	yIB8s3pMgLX5UOnNtV+bA==
X-ME-Sender: <xms:fLo_aYEjgu1BsMcSg1URskyfknCL0PIbGTw9XtSbfKHl5Bvb0tGlKg>
    <xme:fLo_aYQY20sT-4UjN8U-eg03hMQ7aCH7Pysf_Eb0bk_Ra9CQQQXKE_4F1Ta44cxI1
    8uSt82RCcc09JJePkxiKZjRvdJt3vRFd2ELeyZujIb6qTMWS0mnHdM>
X-ME-Received: <xmr:fLo_aXxzIrLbTnSvruhsj_np3op6frq0ZC4bE2HNHy6e2hDQ17wFS7pCifLfWb_uG2C83-XR02bT5lrY7qGtB7I5Yo2ToJkO7bQCr49E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefiedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqdetfeejfedqtdegucdlhedtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgr
    thhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrth
    htvghrnhepkeeiveevgeeiveeiueevfeehffegueehteehgeffffekieejtdeufeelffdv
    veelnecuffhomhgrihhnpehprggtkhgvugdrihhsnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fLo_afMUMjN05KpP_u7_S8E2ChhM639IVL8WBgRBzuo69zz3mBlMQA>
    <xmx:fLo_aeMyTnYd3L_cpO6FlKR78RHPKldZ9MNdS0knVyTRw_X4ox6ASQ>
    <xmx:fLo_aZSJ8iVLwwqDz6o1jgBVByuy23KIj0xLZUJUg4PgYsoy6-0LSQ>
    <xmx:fLo_aYCVTksQdAT4Mn2LR-CljYkc5QSpUU0bEj0XGZC4IlQvl4bi1w>
    <xmx:fLo_aSWH8WOYv-qZfA4Jl3eXicVq3XP_6Xqf8vwxwLF0ihJPxW6OGhwD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d70aee9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Dec 2025 07:36:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Dec 2025 08:36:20 +0100
Subject: [PATCH 01/10] packfile: create store via its owning source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-b4-pks-pack-store-via-source-v1-1-433aac465295@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.52.0.351.gbe84eed79e.dirty

