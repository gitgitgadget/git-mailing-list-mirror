Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C45359A6A
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990477; cv=none; b=GrBkHqY31Q44Bn9hbk/+Z3782kBB186lsVjEEteIrNh5iDOzWcHdb1ajepTgguw+tLDc7E5ruQ1v7NcrbnyFRumaC4RCT/MFopTjz/DTdMrA8ch+k3xh6cMFVuAGBnxl0BqIGu0LHcNhh2f4HC9xQIvvVgk4k0jKFlsLKeh1mhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990477; c=relaxed/simple;
	bh=vsMuQGbv1CHvSgfedoQqMWid2Wxkxv29xDlmxLD3DEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWlkiaA/63YKG5WH5/wnpw2r/wXAE4KK4uEwVsRrXGUp/OqXnzrHPQtWGT+Q8kypxC0Jx+wXpDMaW1qW2Q2pASXp5xmj7+MhcT8QmrWvPjR0G+uQ4y7y1GqHVoYIReRvfDB9x1T+lWSVZSgDVg7xvx6zIAa2ENQNiv1Yu9z8UNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AB/o8zL+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/e/UIGi; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AB/o8zL+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/e/UIGi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 792DF1400011;
	Fri, 20 Mar 2026 03:07:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 20 Mar 2026 03:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990475;
	 x=1774076875; bh=HkxMB1qOh26B2J9PNIl2hVIp9sxO1tZNiBXNm2RXnW0=; b=
	AB/o8zL+knYBPjKtcc9baiSm3eiSLFkhRFYCDqFBj03D6+dtcd2C67oALzlGTgfD
	oOXidKyuuZqbfxNGCUmBhySYx8OYY7soLSdeKNmtzv/KNQR+yvSjM4VE0kpE+Z41
	jGgFxCgJuhyystB9P5CRdjaAPJEsG5I1uNpOJC+k87raJPlYNBZ1RpBujSwm7e+i
	ATkqqFQNJCpktj+ATv1sHjY49Or7bOuduBuFeygKnTe4YyRyGKOgPRktn0gT2D2y
	kBRogiE/XAcWeq3yuPZMa6boRL0LKIGcd4sk2Nu8UdOV3nGAOZ+n4QoA1CzEWOIC
	yVzzcDQIvf45WLQIo0yg2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990475; x=
	1774076875; bh=HkxMB1qOh26B2J9PNIl2hVIp9sxO1tZNiBXNm2RXnW0=; b=j
	/e/UIGiffJeyX5BRSO6Qv80kN3LSyzn+G787Gxm+mgSghJqhB2mNZM2VLksONhph
	2k+2fwJoIYJVJoaXD+VklZyxEzcDP+C0IcLAw1Sn6oeK3hYDpSCnFPAafj9KZyOp
	1jN5JMazR5aXjhHhBguZxfPSECz5FWS5H3GXEtzOD62jEhc8QtpPNGYTgXFqe1r3
	iXOtK1TT5SUyHvZqb8dHQoir/YofFOggLtfwPTbVL1tcwbO79gLAO+gSt1QdkdaS
	a+pQMICDWJNm7bucOC5PJvtxUiI7dd+RJMqXHbnwyyS4kNba3oW7tiMQT+bovEty
	YbKcdFvmYm5WjGDc+bt4g==
X-ME-Sender: <xms:S_K8aaQhMdf1J6C-VUsDE1tLwmV2L3UnvSXB5-ln__T-c0c1xM2v_w>
    <xme:S_K8aXOiJrGr82I4k3otQ5yS6e1E0v2Vo1htccTa3rxOs7NLlkXRcLLxg2Vtc1lZE
    gdgt-oNDorM-N0VYkWTOEc4bMqJoRwxScFi7MtBniP-0CAzBR1hoQ>
X-ME-Received: <xmr:S_K8aVOF6NPgKgG03yloV5uGHRbPRcx2xGAd3r5tTv-aTWYdh0qe6KN3oHsW_AXcu-_N0Lh31LfHgO5kHTzqi_K5eGM7QxGIEUmQVTcBnEXy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:S_K8afvZF-0xwJX8Eh0wOTzisH-d1QIPf7EXIQwlIJLFdLmFJJftRw>
    <xmx:S_K8aXXNxGgJvV0iXZBEUNuKlUye0-STma8WDj32GmI-BR0lpA2DIg>
    <xmx:S_K8afsZ0FRwQ96-4pxNtbgVpwsrjYMcec8Cu08TJr-kOqAdI2CfHw>
    <xmx:S_K8abWbKR9kBOyNqSgiClsT5iVYRjQoOIXZZNSx7Hb6s-3zDkmvZA>
    <xmx:S_K8aXO6uciZGnd_1fdllOntootOED9unZZ4iVwT4E-lg4YMgCWtYoPO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:07:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 184b2f6e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:07:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:31 +0100
Subject: [PATCH v2 05/14] object-name: move logic to iterate through packed
 prefixed objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-5-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
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

