Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B038B140
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903220; cv=none; b=RCVnTPfbluYGA7VO3r6vaOCqWJpqxCh97I26GWc9C/Xt0agxay+FHoDnc1TujIBIxVQGk/XJKqdK1f7V0lzGmB3zydjG+zkmy8iYXN6J9eP8d6FaVC55BaQl/5F6+AKOflJ7dc7+1PGiYgVSC3D3CIqrvVzPPRi94D2ltN+hxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903220; c=relaxed/simple;
	bh=Fh27lIlHMD3sdyjW6/U1MJC+GOHfn3QY4upgwfFncyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TWxurOXqhX2eDoNDnYz+tOdMjm9uej3gANcQI654CJBTPaiePqob7ztisoQhdFG9uZQFc7ZxNoGtcVaCDayiuYka47S0QmaxL2B6rWF2m61EfhNaRt9N8uYS+CLiGr1c88DoonTrPqVre40ZPwmpBPG9T8WQAiGRbW1OuoXet9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m696wCEK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1ZRx6IT7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m696wCEK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1ZRx6IT7"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF7141400221
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 19 Mar 2026 02:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903217;
	 x=1773989617; bh=p6NULCxQbu8fg/B0r86Md4AE3dnQ92KYEJnH5jAOs5U=; b=
	m696wCEKhL411Rv39S16VZKg1Fs08XTQ02BSDEn79LfRBqernmuj0bl/9+kd+JHY
	mIzvQ/VnPUTkMJXhv/8pYBUDPrDVoI0eW3eNl2ovx7QGlsTnxmW871adCOhUJ2Id
	V6qXouomwtExPGdhnzLcYx38K9trzRF6syD+pt5RLKSkX4BLhVuUMLVzBRVZ7UYR
	hW19bU+2wrL1cPBexp6ncBy9sJ9FInOY7jj08GrzkV6UWyFYAEeKRTca9pi7OHN3
	zdmfOu0Y/I3MHWcc8y1nC92m+Kc5Af2Wmj3VBfxX6V4v5c1SAeZ/8lIUvAaikdbf
	ZA8a9naCVDlwz3xGkvUEqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903217; x=
	1773989617; bh=p6NULCxQbu8fg/B0r86Md4AE3dnQ92KYEJnH5jAOs5U=; b=1
	ZRx6IT7d/FbK4ZCkgbCmt/pVWZGQ6lDcgIN4bCYSUvqs2N/hgEmh3XsxIH/qpRCK
	JoDra2VufS4yWu2uhQ8Ix2nyKhwAg6cRYWWTDBiQ2MxrB64zfm+iOthDl5QIDfBD
	DwgtHN5V+fxCdt8pI5zcxS4eQIwPO9R+XTN4uLewJY7zlmMH/kOqcOPdp0Bbt030
	l5SLn/mObK2V76CJEDUYyBvXlysBYGsbw1VjoEEV/zNjvxih6QZukYujVXHlAXWf
	EiKua6FZSn9Pk6kJ+0oFfVHrd4rda678oAXUVbhBJd5IiG8oIFI41yTKnA53W+zw
	PRsi36abcKiKGR2KDwDUA==
X-ME-Sender: <xms:cZ27aZeoBMjq2zkQK6Y7opJ3YtLEpsX9FfuFrSmFWLPGgdyHPXZBOQ>
    <xme:cZ27aeKGR12sPzr4cpoD8iN6EwmKuJu2ZlaKuwC1Q285fOXPM0NiPKoOQnDQYKhaJ
    _kRqaQv4bHaKXxiu8KN5plQlkMwKaoXGZ178WCFyKlaYelemU7GzS4>
X-ME-Received: <xmr:cZ27aYLlHcstaaVGYUpNuv7nbT-jlrL4AeeFjT8cqybhz-KFZ23_L-b-IEmoHwR5LgTGaTktzV-tuHzgyk3XeAJG9PLFekM2m4bUd09sR3p6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:cZ27aYEFOxBL0LwJ6Tn03pmvhDV5NeLNLqfiYPt03iiajU6pJKiIMQ>
    <xmx:cZ27aVkzJIIqkKW07kdel7jCheIYJc15ZAUJ1iGErmiLq7j2ETTHvw>
    <xmx:cZ27adK_QjUPz3yGXjhuezIT8E-DZBDFA60spZpxDeiYh7KL4jjhow>
    <xmx:cZ27aeZhWaYH6MFJQRUNhK3cEA4IvDZgoIM4C-IMyFPqwZISGCxCGQ>
    <xmx:cZ27aTO3b9XIBtR1Uqw-YOyyHMV5MOzKq6d1tshE_yIz9RYUMiKHQuCO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c18149c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:11 +0100
Subject: [PATCH 13/14] object-file: move logic to compute packed
 abbreviation length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-13-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
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

