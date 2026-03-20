Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EFB359A79
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990499; cv=none; b=Ha7bUwQ6nrS4SSRTU6TsEqGCHpcV8R3+EH4pLogQHKEIEo32XZ3X0F0IOXM01fu2IhyvoERp8YdJYMSREHWNv+eMveYyC4e5SA7oqhdohVgOhfujbXFRH2+u7kyCgmZ8n/M6TZDS3cs5W93DclrpiCQ4q/LP+um4la30HvB42EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990499; c=relaxed/simple;
	bh=Fh27lIlHMD3sdyjW6/U1MJC+GOHfn3QY4upgwfFncyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Exzew+3dnOLOPXqzC061WdHapS2KkuGmBeRZ5N/OENDwvXSj5xzN97iIMNPOe+etp0RZWyjBpUn8t56af8/zelQhxC57QUkxz+O37UFwAxy2gmjrMAwUzOVaZV3fgopxKl/OstUbDw9JVyOPIx0XSl7fPNi9+/RMJKEZ88dOfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OnaZHoje; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gIQHiyX0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OnaZHoje";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gIQHiyX0"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 70CA2EC018B;
	Fri, 20 Mar 2026 03:08:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Mar 2026 03:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990497;
	 x=1774076897; bh=p6NULCxQbu8fg/B0r86Md4AE3dnQ92KYEJnH5jAOs5U=; b=
	OnaZHojen0g53UZmIX2cl5MOT6sEYAIth5rNmcc+4JD3OWxTLYOi3vuWy07hYOb1
	VjW7rtlPEQldvjPra83I2kKkzmAE6Vaffe1yxcTPfIolkcDUnmDIR82SKaI2kDoS
	5SPTF6dzqTUtR/xKw/Uz02v5WSpDCqDyrq1HDus9HdvmOGJI2JR0QkDJj3fR7/2U
	m+cJalIW9QlcLru6n7Fk7osVpBGY1J0O72O6YucLoBC9pBkm0yLOSxQT23J54shE
	VxGw0TCdz3dy5uA6r2XogGgHP3qIWgn/Sc9OXNFJ+Rc42+c+/PtwvtndPMpiy0oJ
	HsjFcHRLm3OIpkXpw/XQJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990497; x=
	1774076897; bh=p6NULCxQbu8fg/B0r86Md4AE3dnQ92KYEJnH5jAOs5U=; b=g
	IQHiyX0J1btK4RaZZkzvmbqPJ90fwlTvqQHF2MX3q3mCz/foychQm1+NK0pS5IaM
	eVyBa6wnwkeqokC8yXnwWpqq6LZyR4aS3FzjIbEvsL+LssMD1m7KL3I+7Ub683OF
	8paQngjS/kwxd6RTbx4kXNfVvwpe7+60q+56rbY/dHkqChzIErQG5FHLuBPyyfmj
	5ImAQ0KSU2QjUJfpsZKrRLxxznbT3FRqGMVSOvuxWzyWxou532OFJCBs8eYqDzEs
	pyE+K3y7cQS9UTLwPgNZk5GTsbUFBfqzzYk/CFe7k9JbsrQMeyOv48w1Z4Yd95e+
	I1WQ5w+OKzxYsbzUlyvXQ==
X-ME-Sender: <xms:YfK8aSnB93AKA-xAy7Ji9CX0vkFo7t7KWCHP3HmsUKzn4o_KydsZ0A>
    <xme:YfK8aRQMpgIovOU1TQq_lphwqzGF6IkK3-GhZtxRNkFu6E8suaGd-xsDuUK67QyPL
    Rx2V2DVfrwRrBC1UKH-DMQxv9hIZIciq2FB29PfYJsDM3oZf0DgzA>
X-ME-Received: <xmr:YfK8aeAke_5TZVGeAIF1xjQdE1eIHbYt6M1Fd16zzoNWOv8u0IdUoFN4xwyUHh2_BtuHfnp_Ns0M_nbXinZHCcxLQ4E6uGqRaxeAHT3r0RCu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:YfK8aQR32iSCp5X5vTW7iDmRSwUaNMaEdytvUx_cecUGPCn9iby7DA>
    <xmx:YfK8aUrAA5Ln5P9BzhgIZwfJzQvOb8tUKlCEzjHqUsk5yXHrB537FQ>
    <xmx:YfK8aazcJAUZgX7V6SJcZphljcLgUqDZ8BLvS2w3iu_IzrLeptGfgw>
    <xmx:YfK8aRKHV1PGBzoE3Vet_u4osUnkP-ye5F6a2frutGtvCTr7n48V8Q>
    <xmx:YfK8aWpx2tlrgPiPiIVDAnKTt7K7HKatYr-ixRNKySYwPYeJssobjfsb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:08:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4e972dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:08:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:39 +0100
Subject: [PATCH v2 13/14] object-file: move logic to compute packed
 abbreviation length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-13-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Same as the preceding commit, move the logic that computes the minimum
required prefix length to make a given object ID unique for the packfile
store into a new function `packfile_store_find_abbrev_len()` that is
part of "packfile.c". This prepares for making the logic fully generic
via pluggable object databases.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 135 ++++++----------------------------------------------------
 packfile.c    | 111 +++++++++++++++++++++++++++++++++++++++++++++++
 packfile.h    |   5 +++
 3 files changed, 128 insertions(+), 123 deletions(-)

diff --git a/object-name.c b/object-name.c
index 4e21dbfa97..bb2294a193 100644
--- a/object-name.c
+++ b/object-name.c
@@ -582,115 +582,6 @@ static unsigned msb(unsigned long val)
 	return r;
 }
 
-struct min_abbrev_data {
-	unsigned int init_len;
-	unsigned int cur_len;
-	struct repository *repo;
-	const struct object_id *oid;
-};
-
-static int extend_abbrev_len(const struct object_id *oid,
-			     struct min_abbrev_data *mad)
-{
-	unsigned len = oid_common_prefix_hexlen(oid, mad->oid);
-	if (len != hash_algos[oid->algo].hexsz && len >= mad->cur_len)
-		mad->cur_len = len + 1;
-	return 0;
-}
-
-static void find_abbrev_len_for_midx(struct multi_pack_index *m,
-				     struct min_abbrev_data *mad)
-{
-	for (; m; m = m->base_midx) {
-		int match = 0;
-		uint32_t num, first = 0;
-		struct object_id oid;
-		const struct object_id *mad_oid;
-
-		if (!m->num_objects)
-			continue;
-
-		num = m->num_objects + m->num_objects_in_base;
-		mad_oid = mad->oid;
-		match = bsearch_one_midx(mad_oid, m, &first);
-
-		/*
-		 * first is now the position in the packfile where we
-		 * would insert mad->hash if it does not exist (or the
-		 * position of mad->hash if it does exist). Hence, we
-		 * consider a maximum of two objects nearby for the
-		 * abbreviation length.
-		 */
-		mad->init_len = 0;
-		if (!match) {
-			if (nth_midxed_object_oid(&oid, m, first))
-				extend_abbrev_len(&oid, mad);
-		} else if (first < num - 1) {
-			if (nth_midxed_object_oid(&oid, m, first + 1))
-				extend_abbrev_len(&oid, mad);
-		}
-		if (first > 0) {
-			if (nth_midxed_object_oid(&oid, m, first - 1))
-				extend_abbrev_len(&oid, mad);
-		}
-		mad->init_len = mad->cur_len;
-	}
-}
-
-static void find_abbrev_len_for_pack(struct packed_git *p,
-				     struct min_abbrev_data *mad)
-{
-	int match = 0;
-	uint32_t num, first = 0;
-	struct object_id oid;
-	const struct object_id *mad_oid;
-
-	if (p->multi_pack_index)
-		return;
-
-	if (open_pack_index(p) || !p->num_objects)
-		return;
-
-	num = p->num_objects;
-	mad_oid = mad->oid;
-	match = bsearch_pack(mad_oid, p, &first);
-
-	/*
-	 * first is now the position in the packfile where we would insert
-	 * mad->hash if it does not exist (or the position of mad->hash if
-	 * it does exist). Hence, we consider a maximum of two objects
-	 * nearby for the abbreviation length.
-	 */
-	mad->init_len = 0;
-	if (!match) {
-		if (!nth_packed_object_id(&oid, p, first))
-			extend_abbrev_len(&oid, mad);
-	} else if (first < num - 1) {
-		if (!nth_packed_object_id(&oid, p, first + 1))
-			extend_abbrev_len(&oid, mad);
-	}
-	if (first > 0) {
-		if (!nth_packed_object_id(&oid, p, first - 1))
-			extend_abbrev_len(&oid, mad);
-	}
-	mad->init_len = mad->cur_len;
-}
-
-static void find_abbrev_len_packed(struct min_abbrev_data *mad)
-{
-	struct packed_git *p;
-
-	odb_prepare_alternates(mad->repo->objects);
-	for (struct odb_source *source = mad->repo->objects->sources; source; source = source->next) {
-		struct multi_pack_index *m = get_multi_pack_index(source);
-		if (m)
-			find_abbrev_len_for_midx(m, mad);
-	}
-
-	repo_for_each_pack(mad->repo, p)
-		find_abbrev_len_for_pack(p, mad);
-}
-
 void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
 				   const struct object_id *oid, int abbrev_len)
 {
@@ -707,14 +598,14 @@ void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 }
 
 int repo_find_unique_abbrev_r(struct repository *r, char *hex,
-			      const struct object_id *oid, int len)
+			      const struct object_id *oid, int min_len)
 {
 	const struct git_hash_algo *algo =
 		oid->algo ? &hash_algos[oid->algo] : r->hash_algo;
-	struct min_abbrev_data mad;
 	const unsigned hexsz = algo->hexsz;
+	unsigned len;
 
-	if (len < 0) {
+	if (min_len < 0) {
 		unsigned long count;
 
 		if (odb_count_objects(r->objects, ODB_COUNT_OBJECTS_APPROXIMATE, &count) < 0)
@@ -738,25 +629,23 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 		 */
 		if (len < FALLBACK_DEFAULT_ABBREV)
 			len = FALLBACK_DEFAULT_ABBREV;
+	} else {
+		len = min_len;
 	}
 
 	oid_to_hex_r(hex, oid);
 	if (len >= hexsz || !len)
 		return hexsz;
 
-	mad.repo = r;
-	mad.init_len = len;
-	mad.cur_len = len;
-	mad.oid = oid;
-
-	find_abbrev_len_packed(&mad);
-
 	odb_prepare_alternates(r->objects);
-	for (struct odb_source *s = r->objects->sources; s; s = s->next)
-		odb_source_loose_find_abbrev_len(s, mad.oid, mad.cur_len, &mad.cur_len);
+	for (struct odb_source *s = r->objects->sources; s; s = s->next) {
+		struct odb_source_files *files = odb_source_files_downcast(s);
+		packfile_store_find_abbrev_len(files->packed, oid, len, &len);
+		odb_source_loose_find_abbrev_len(s, oid, len, &len);
+	}
 
-	hex[mad.cur_len] = 0;
-	return mad.cur_len;
+	hex[len] = 0;
+	return len;
 }
 
 const char *repo_find_unique_abbrev(struct repository *r,
diff --git a/packfile.c b/packfile.c
index 2539a371c1..ee9c7ea1d1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2597,6 +2597,117 @@ int packfile_store_for_each_object(struct packfile_store *store,
 	return ret;
 }
 
+static int extend_abbrev_len(const struct object_id *a,
+			     const struct object_id *b,
+			     unsigned *out)
+{
+	unsigned len = oid_common_prefix_hexlen(a, b);
+	if (len != hash_algos[a->algo].hexsz && len >= *out)
+		*out = len + 1;
+	return 0;
+}
+
+static void find_abbrev_len_for_midx(struct multi_pack_index *m,
+				     const struct object_id *oid,
+				     unsigned min_len,
+				     unsigned *out)
+{
+	unsigned len = min_len;
+
+	for (; m; m = m->base_midx) {
+		int match = 0;
+		uint32_t num, first = 0;
+		struct object_id found_oid;
+
+		if (!m->num_objects)
+			continue;
+
+		num = m->num_objects + m->num_objects_in_base;
+		match = bsearch_one_midx(oid, m, &first);
+
+		/*
+		 * first is now the position in the packfile where we
+		 * would insert the object ID if it does not exist (or the
+		 * position of the object ID if it does exist). Hence, we
+		 * consider a maximum of two objects nearby for the
+		 * abbreviation length.
+		 */
+
+		if (!match) {
+			if (nth_midxed_object_oid(&found_oid, m, first))
+				extend_abbrev_len(&found_oid, oid, &len);
+		} else if (first < num - 1) {
+			if (nth_midxed_object_oid(&found_oid, m, first + 1))
+				extend_abbrev_len(&found_oid, oid, &len);
+		}
+		if (first > 0) {
+			if (nth_midxed_object_oid(&found_oid, m, first - 1))
+				extend_abbrev_len(&found_oid, oid, &len);
+		}
+	}
+
+	*out = len;
+}
+
+static void find_abbrev_len_for_pack(struct packed_git *p,
+				     const struct object_id *oid,
+				     unsigned min_len,
+				     unsigned *out)
+{
+	int match;
+	uint32_t num, first = 0;
+	struct object_id found_oid;
+	unsigned len = min_len;
+
+	num = p->num_objects;
+	match = bsearch_pack(oid, p, &first);
+
+	/*
+	 * first is now the position in the packfile where we would insert
+	 * the object ID if it does not exist (or the position of mad->hash if
+	 * it does exist). Hence, we consider a maximum of two objects
+	 * nearby for the abbreviation length.
+	 */
+	if (!match) {
+		if (!nth_packed_object_id(&found_oid, p, first))
+			extend_abbrev_len(&found_oid, oid, &len);
+	} else if (first < num - 1) {
+		if (!nth_packed_object_id(&found_oid, p, first + 1))
+			extend_abbrev_len(&found_oid, oid, &len);
+	}
+	if (first > 0) {
+		if (!nth_packed_object_id(&found_oid, p, first - 1))
+			extend_abbrev_len(&found_oid, oid, &len);
+	}
+
+	*out = len;
+}
+
+int packfile_store_find_abbrev_len(struct packfile_store *store,
+				   const struct object_id *oid,
+				   unsigned min_len,
+				   unsigned *out)
+{
+	struct packfile_list_entry *e;
+	struct multi_pack_index *m;
+
+	m = get_multi_pack_index(store->source);
+	if (m)
+		find_abbrev_len_for_midx(m, oid, min_len, &min_len);
+
+	for (e = packfile_store_get_packs(store); e; e = e->next) {
+		if (e->pack->multi_pack_index)
+			continue;
+		if (open_pack_index(e->pack) || !e->pack->num_objects)
+			continue;
+
+		find_abbrev_len_for_pack(e->pack, oid, min_len, &min_len);
+	}
+
+	*out = min_len;
+	return 0;
+}
+
 struct add_promisor_object_data {
 	struct repository *repo;
 	struct oidset *set;
diff --git a/packfile.h b/packfile.h
index fa41dfda38..45b35973f0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -369,6 +369,11 @@ int packfile_store_for_each_object(struct packfile_store *store,
 				   void *cb_data,
 				   const struct odb_for_each_object_options *opts);
 
+int packfile_store_find_abbrev_len(struct packfile_store *store,
+				   const struct object_id *oid,
+				   unsigned min_len,
+				   unsigned *out);
+
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2

-- 
2.53.0.1055.ga2ffed1127.dirty

