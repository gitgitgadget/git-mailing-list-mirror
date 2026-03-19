Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8F38B15C
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903200; cv=none; b=Lfc0ErkFAM0PNWGhyraBoNbYRh6NMVBqklxXcj/Gn47P87oSSy5qWQaPNzZHgIo6BaAf7dvrBVRFZWsFrLGyT/gF+4CHwEZvjKRICIUDFcfCeA9bZtRhicfgGzHjCcFUuOM9d3mrfjjlFszcns6OwMXxrE1x2mtnBbRrfxpql0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903200; c=relaxed/simple;
	bh=vsMuQGbv1CHvSgfedoQqMWid2Wxkxv29xDlmxLD3DEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTc6kKzkmifMkZvi0tcgzFpdS/QIUMmKdh5PoPytVNrijNZEiXSSSrlpry8LTNTQY53GDHGjFy2RXJD3iIoWbyxi+PRUwNiIFPDaliIW0WlX1FttldfGWnHyTdmxoMA2ZuAfz6w5JyUCpVwtDWgvTfMvlXhAzzQi5o7aHLfgGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WF73gy6f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2pIm2B2P; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WF73gy6f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2pIm2B2P"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D874DEC026F
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 02:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903197;
	 x=1773989597; bh=HkxMB1qOh26B2J9PNIl2hVIp9sxO1tZNiBXNm2RXnW0=; b=
	WF73gy6fDUCfpDgCo4Sdoa2GFkrgGP5yPTjjSQN09fXZglpe66Vx26cYMDC11Ttp
	ru2jL2ijOStRQi5VQ6u/ApBoT5qinUqnT7Pn7Lvwp53hsF1cVbVI3U9bhO+8tf81
	CJGaJ91sVS1i8IoYqcGBECTn0SC1aQeXEgUZ0B9wlLlefqB0z30b37wcl8BJjg7i
	QCMb5n5fi2Po0JmX+Lbjz6BiA4L3xSs2/eLuMq8PkaaS85/OZG8aJXeYN/EHblvp
	q3Cnrg6Ky4doVd6fPMXBYqhdA4Mf+TwnMRoX5S4qkJ//ldzemAnmSUG7g7tXu8WH
	npABnJtcLgvqu+npGmzsJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903197; x=
	1773989597; bh=HkxMB1qOh26B2J9PNIl2hVIp9sxO1tZNiBXNm2RXnW0=; b=2
	pIm2B2P5HwQzfg1ySZMDvobM3z+nt746lZNiUXARbxq/7fJAUAYDFrunX3Wj02vY
	cEBnHNqKZQuNdaC3MGroccQqbuJTlvDQETIh2VlQ/AuKqQ3yiQ6nzmV9n5WzK9E3
	ZYkRgZdSzy+r82gzWkTqL+AZod8Rn4Q01zVil/rPBIC3pZOsy4JNWUPFvemOUNxq
	vglvaURKiuB7+ToC1+OQtwkdl9TtLtpHDO8vX4LqOf/6lMxAYFUmabQwTrBkPW2n
	FQudMMo95ylUS47QP+hREgnm/IajrEtYWf95KiFHyzk1rkrQuutJl0cQAmnCMPRr
	wGMSE1hk9ZO5MYlt0xqIA==
X-ME-Sender: <xms:XZ27aehupADjoMqet4Gwn5rwByH2Rl4rSnKeC2QQe6E-iKyDCDKmyw>
    <xme:XZ27aV-9JxaZS6ocxNppJ9kVxSSrUTOCs_ljEZlRGawRJhn0FOAVKs0Vqour9iOdL
    DS4M9HNjZ-tIcJGElauhQT8ybo_FMZnU6YgmXTGPKEl6cilhoVn2g>
X-ME-Received: <xmr:XZ27abtmxZTl5qwQ1Hw3uedbA2zbL0mbcZOZaw2_JmFy8B19J2AQPmKQm73f9jR5Isi0Qj7FsAv2vYlL4DUw59ll1zFiVZMqb3DP3EO-URo2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:XZ27acZAMvlWWmIUdfsvP5nbPb-us9RO_fFEMwrt6VHSPEnuZelh5g>
    <xmx:XZ27abptREykaCDI7nvrcXa0_2n65RE4Yrn5dpn4mSHYRur3b8UQSQ>
    <xmx:XZ27aR_B2ig55n4BXq-Acj6FrPZnM2n5cbdXzXDFt8IkoIpiL4b2Ow>
    <xmx:XZ27aa8dOeilwokjML6U_CmjF4Fi2XPl7ULHzJmPUcrwcJwBO0TNXg>
    <xmx:XZ27abhN8KUaKE4rrHpquBfRCUWhXbIMHaqJR0YiroiFVJsi2zuDasa->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db5a030a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:03 +0100
Subject: [PATCH 05/14] object-name: move logic to iterate through packed
 prefixed objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-5-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Similar to the preceding commit, move the logic to iterate through
objects that have a given prefix into "packfile.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c |  94 +++----------------------------
 packfile.c    | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+), 87 deletions(-)

diff --git a/object-name.c b/object-name.c
index 929a68dbd0..ff0de06ff9 100644
--- a/object-name.c
+++ b/object-name.c
@@ -100,8 +100,6 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 	/* otherwise, current can be discarded and candidate is still good */
 }
 
-static int match_hash(unsigned, const unsigned char *, const unsigned char *);
-
 static int match_prefix(const struct object_id *oid, struct object_info *oi UNUSED, void *arg)
 {
 	struct disambiguate_state *ds = arg;
@@ -122,103 +120,25 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 		odb_source_loose_for_each_object(source, NULL, match_prefix, ds, &opts);
 }
 
-static int match_hash(unsigned len, const unsigned char *a, const unsigned char *b)
-{
-	do {
-		if (*a != *b)
-			return 0;
-		a++;
-		b++;
-		len -= 2;
-	} while (len > 1);
-	if (len)
-		if ((*a ^ *b) & 0xf0)
-			return 0;
-	return 1;
-}
-
-static void unique_in_midx(struct multi_pack_index *m,
-			   struct disambiguate_state *ds)
-{
-	for (; m; m = m->base_midx) {
-		uint32_t num, i, first = 0;
-		const struct object_id *current = NULL;
-		int len = ds->len > ds->repo->hash_algo->hexsz ?
-			ds->repo->hash_algo->hexsz : ds->len;
-
-		if (!m->num_objects)
-			continue;
-
-		num = m->num_objects + m->num_objects_in_base;
-
-		bsearch_one_midx(&ds->bin_pfx, m, &first);
-
-		/*
-		 * At this point, "first" is the location of the lowest
-		 * object with an object name that could match
-		 * "bin_pfx".  See if we have 0, 1 or more objects that
-		 * actually match(es).
-		 */
-		for (i = first; i < num && !ds->ambiguous; i++) {
-			struct object_id oid;
-			current = nth_midxed_object_oid(&oid, m, i);
-			if (!match_hash(len, ds->bin_pfx.hash, current->hash))
-				break;
-			update_candidates(ds, current);
-		}
-	}
-}
-
-static void unique_in_pack(struct packed_git *p,
-			   struct disambiguate_state *ds)
-{
-	uint32_t num, i, first = 0;
-	int len = ds->len > ds->repo->hash_algo->hexsz ?
-		ds->repo->hash_algo->hexsz : ds->len;
-
-	if (p->multi_pack_index)
-		return;
-
-	if (open_pack_index(p) || !p->num_objects)
-		return;
-
-	num = p->num_objects;
-	bsearch_pack(&ds->bin_pfx, p, &first);
-
-	/*
-	 * At this point, "first" is the location of the lowest object
-	 * with an object name that could match "bin_pfx".  See if we have
-	 * 0, 1 or more objects that actually match(es).
-	 */
-	for (i = first; i < num && !ds->ambiguous; i++) {
-		struct object_id oid;
-		nth_packed_object_id(&oid, p, i);
-		if (!match_hash(len, ds->bin_pfx.hash, oid.hash))
-			break;
-		update_candidates(ds, &oid);
-	}
-}
-
 static void find_short_packed_object(struct disambiguate_state *ds)
 {
+	struct odb_for_each_object_options opts = {
+		.prefix = &ds->bin_pfx,
+		.prefix_hex_len = ds->len,
+	};
 	struct odb_source *source;
-	struct packed_git *p;
 
 	/* Skip, unless oids from the storage hash algorithm are wanted */
 	if (ds->bin_pfx.algo && (&hash_algos[ds->bin_pfx.algo] != ds->repo->hash_algo))
 		return;
 
 	odb_prepare_alternates(ds->repo->objects);
-	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
-		struct multi_pack_index *m = get_multi_pack_index(source);
-		if (m)
-			unique_in_midx(m, ds);
-	}
+	for (source = ds->repo->objects->sources; source; source = source->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
 
-	repo_for_each_pack(ds->repo, p) {
+		packfile_store_for_each_object(files->packed, NULL, match_prefix, ds, &opts);
 		if (ds->ambiguous)
 			break;
-		unique_in_pack(p, ds);
 	}
 }
 
diff --git a/packfile.c b/packfile.c
index a6f3d2035d..2539a371c1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2371,6 +2371,177 @@ static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
 	}
 }
 
+static int match_hash(unsigned len, const unsigned char *a, const unsigned char *b)
+{
+	do {
+		if (*a != *b)
+			return 0;
+		a++;
+		b++;
+		len -= 2;
+	} while (len > 1);
+	if (len)
+		if ((*a ^ *b) & 0xf0)
+			return 0;
+	return 1;
+}
+
+static int for_each_prefixed_object_in_midx(
+	struct packfile_store *store,
+	struct multi_pack_index *m,
+	const struct odb_for_each_object_options *opts,
+	struct packfile_store_for_each_object_wrapper_data *data)
+{
+	int ret;
+
+	for (; m; m = m->base_midx) {
+		uint32_t num, i, first = 0;
+		int len = opts->prefix_hex_len > m->source->odb->repo->hash_algo->hexsz ?
+			m->source->odb->repo->hash_algo->hexsz : opts->prefix_hex_len;
+
+		if (!m->num_objects)
+			continue;
+
+		num = m->num_objects + m->num_objects_in_base;
+
+		bsearch_one_midx(opts->prefix, m, &first);
+
+		/*
+		 * At this point, "first" is the location of the lowest
+		 * object with an object name that could match "opts->prefix".
+		 * See if we have 0, 1 or more objects that actually match(es).
+		 */
+		for (i = first; i < num; i++) {
+			const struct object_id *current = NULL;
+			struct object_id oid;
+
+			current = nth_midxed_object_oid(&oid, m, i);
+
+			if (!match_hash(len, opts->prefix->hash, current->hash))
+				break;
+
+			if (data->request) {
+				struct object_info oi = *data->request;
+
+				ret = packfile_store_read_object_info(store, current,
+								      &oi, 0);
+				if (ret)
+					goto out;
+
+				ret = data->cb(&oid, &oi, data->cb_data);
+				if (ret)
+					goto out;
+			} else {
+				ret = data->cb(&oid, NULL, data->cb_data);
+				if (ret)
+					goto out;
+			}
+		}
+	}
+
+	ret = 0;
+
+out:
+	return ret;
+}
+
+static int for_each_prefixed_object_in_pack(
+	struct packfile_store *store,
+	struct packed_git *p,
+	const struct odb_for_each_object_options *opts,
+	struct packfile_store_for_each_object_wrapper_data *data)
+{
+	uint32_t num, i, first = 0;
+	int len = opts->prefix_hex_len > p->repo->hash_algo->hexsz ?
+		p->repo->hash_algo->hexsz : opts->prefix_hex_len;
+	int ret;
+
+	num = p->num_objects;
+	bsearch_pack(opts->prefix, p, &first);
+
+	/*
+	 * At this point, "first" is the location of the lowest object
+	 * with an object name that could match "bin_pfx".  See if we have
+	 * 0, 1 or more objects that actually match(es).
+	 */
+	for (i = first; i < num; i++) {
+		struct object_id oid;
+
+		nth_packed_object_id(&oid, p, i);
+		if (!match_hash(len, opts->prefix->hash, oid.hash))
+			break;
+
+		if (data->request) {
+			struct object_info oi = *data->request;
+
+			ret = packfile_store_read_object_info(store, &oid, &oi, 0);
+			if (ret)
+				goto out;
+
+			ret = data->cb(&oid, &oi, data->cb_data);
+			if (ret)
+				goto out;
+		} else {
+			ret = data->cb(&oid, NULL, data->cb_data);
+			if (ret)
+				goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	return ret;
+}
+
+static int packfile_store_for_each_prefixed_object(
+	struct packfile_store *store,
+	const struct odb_for_each_object_options *opts,
+	struct packfile_store_for_each_object_wrapper_data *data)
+{
+	struct packfile_list_entry *e;
+	struct multi_pack_index *m;
+	bool pack_errors = false;
+	int ret;
+
+	if (opts->flags)
+		BUG("flags unsupported");
+
+	store->skip_mru_updates = true;
+
+	m = get_multi_pack_index(store->source);
+	if (m) {
+		ret = for_each_prefixed_object_in_midx(store, m, opts, data);
+		if (ret)
+			goto out;
+	}
+
+	for (e = packfile_store_get_packs(store); e; e = e->next) {
+		if (e->pack->multi_pack_index)
+			continue;
+
+		if (open_pack_index(e->pack)) {
+			pack_errors = true;
+			continue;
+		}
+
+		if (!e->pack->num_objects)
+			continue;
+
+		ret = for_each_prefixed_object_in_pack(store, e->pack, opts, data);
+		if (ret)
+			goto out;
+	}
+
+	ret = 0;
+
+out:
+	store->skip_mru_updates = false;
+	if (!ret && pack_errors)
+		ret = -1;
+	return ret;
+}
+
 int packfile_store_for_each_object(struct packfile_store *store,
 				   const struct object_info *request,
 				   odb_for_each_object_cb cb,
@@ -2386,6 +2557,9 @@ int packfile_store_for_each_object(struct packfile_store *store,
 	struct packfile_list_entry *e;
 	int pack_errors = 0, ret;
 
+	if (opts->prefix)
+		return packfile_store_for_each_prefixed_object(store, opts, &data);
+
 	store->skip_mru_updates = true;
 
 	for (e = packfile_store_get_packs(store); e; e = e->next) {

-- 
2.53.0.1055.ga2ffed1127.dirty

