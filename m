Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EFE3B71CF
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678431; cv=none; b=AJc+cfMk0CyA+lAsYenO/Rp5HwC8whMNNkx5a/xcnkpOXaBcWmUSOR/eFhyZvtX85wI4mFMD1zIon/5aDX1LnpVKyt7fH9Y+6XlyFEnp6frktD4pGSZQw2h7DFvZFtO9PP53Vf7PmA/FgEo4aCffm48E2bG73MP7JsHBons3wPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678431; c=relaxed/simple;
	bh=FbTasby9SdEj01pMkAtQQyU+t34yif8oFkI5jFr3iSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRvNrLjpphkmJgeU15uBFbP29jh+uSxDlZvfDfnMOVpUxy99d4ioNd2N0j5Pcuqaha7/BlXSxcrqeq+uk4fmiAEOsrFNs5OYea/QN+iT1tdN0WadSDODHSv9qKN/BnB71YHJ14Xp+oQaNGSMV/HmZheU4e3GdyHPCAffctrV0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CCgfY7Sk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YwCqHjx+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CCgfY7Sk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YwCqHjx+"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id CA9101D00121;
	Wed, 17 Jun 2026 02:40:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 17 Jun 2026 02:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678429;
	 x=1781764829; bh=fDWsQelkcXqL6MKlY4TC8p9cTM1NpAjB9ISKWl+mQeE=; b=
	CCgfY7SkJd6rWZB2EoVQaBCuHWrn0L/akazrBh/7C12daC8nZ/7m7M3XzUdUaobe
	r1SOzy9+UiY15/evHxVYE9HEcX3eB89ZJAOb7wQATsbudgY1hjbggquPL4CzwzQ9
	nxY/inCNm/Xmy4fnrYJ4aC50vD/I6HbRYKFpOQ+KpJx9K151Mnhwyq0GGsW1Q1UA
	cfKd5tP+2n+gMCr8b4ozFMH/WdodtbprSXs9hh+RGkS8fZTo7kqqHVhkCGMUSRJv
	+NtxAjrcji3RyCZkRGATdGyLwzOiM/4h99m6GzhTwatF/qVsKw31ttqUYUKscSln
	uUPV8kOiEobtE+gFGnVVxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678429; x=
	1781764829; bh=fDWsQelkcXqL6MKlY4TC8p9cTM1NpAjB9ISKWl+mQeE=; b=Y
	wCqHjx+a3nCPOnmy7a2UrbfBrtqO5nbXwOpC+H+LzG0ad/1m+T9c3seyTlo/XZrn
	lkf0YZZ2rKrGCwJI3OPWyio0KrdEFMRsyVo984gqjhYs82vOAyKYTiQ2yTzM6iRt
	tzYU6pYPcD6MRkl8NZl0xijheFvcpFyNugXE4SeT6f5powzoAiSXKfnFFD35iA2f
	5zRsOn+0v+GoohlT/xo5ecWRCJ8KnrFIoTLkqhP1tX1fuj37Z9qPQdswoenBhqrs
	fYR+Kaus8UDMUgL8slvW/Qzbc57heVuJNr4GgwL1BKFKJOCkpnJllErdAgFNaial
	gOKnGNHHDlM/z0nw3M2+w==
X-ME-Sender: <xms:XUEyavoHrGa8vvCm4ymNhNm56iLg58u8t7SeJdh-gRo44zSrusw-3A>
    <xme:XUEyahH5sx5TIrWX3qd2c4V_uEyCTtDXPSFHm1UsjXeCtP9Ni3irA3a3TQZXwaL_l
    ixAova4clWUFvbs9LKxyHqKECftbZwW8zhtTUYVF_rMvKOF05kb>
X-ME-Received: <xmr:XUEyaplakFKxDlc1kFU3izk_5dmuhwTDzguysYefKh_43-yi_qFXkXz6MMy_V2r5gM6w6lK9YHxu_ETK5S9pvF8TWsif-HIHCru9ofo>
X-ME-Proxy-Cause: dmFkZTEnB39eLvyMgsk+d1zBATJAS2Dd09yZUP4TCe4zWysBccoWgY8Y+enBv1+9aJfPT8
    oVvaCC5MWGV30uZzKswgiCAK2gGSGYELp/F+QCNhRNY/bQx6x+ywijOIUW8TKDwAx48Lcx
    KhLHoOJu9m1Ux2Kfz7iOtjqmT/hnPJJkdtWT0xsGgHMCb1yqiVx9G0A93DDw8nseLTKulF
    USUks9qtFi47cv66z4EPIfMktSNXs9lIOpQJ4JZJ8Sqt4LT7yml6xL5bA1DQ7F1XoINCS5
    8+0eJLKjW+BUl0nBlxv0Wa8T6T4Bg1YQKal6uMYv+KeVZbCqw870pv0xnOpn9ZF3vGEMTp
    N8CngKgRyJxERpwsFZHUieh2/JG3nCIsgo56KgV6FytVSLpSL9ml7SxD58j9xxHXIHCTck
    M1sP3JpqtxCifeCk/v+QBYopkLxwLyz5NL1vLWRNiYMZZDSzh4TwCPEMwJ6jSqACK0PNYe
    7IZ4ICPkyTbeRSaxvPOG0lXRYWAfioYEABa3ynMr8JrN6vix/E0aA1cfu4aBzL0PSCGBDa
    P1nCX2gPVA1hq8MIjLl7+tLbmqirJ3UQdyajlsrCCfsE0XdOWvoq5p8RL28YBQDSAh5H66
    xHXPcMsO7asF9FQ3dFOWBsWMb13qAeuXLn8oxmH/xhWySCZv3T6olawfpjSA
X-ME-Proxy: <xmx:XUEyasmMsvT0kG3zvHCZa2-WVnPwxTr3Fy4doquDeHZEkk_0i7zhow>
    <xmx:XUEyaisDMBwPq20vw9_IlUJ9y_cBwco6OF9JgkU6kGpCLJdIRufW-A>
    <xmx:XUEyanl8f2P1LMKq8_6uEnA_FIPJoMPNt08ycJYwOSOZLZrvP3RCJA>
    <xmx:XUEyalu_ewIngsICJ0jze9M-QN5lA8DWCibP-I889u1hcENntZ_7Ow>
    <xmx:XUEyamg6qV_fcg-sD6Jj1qlV5jKNHMAdQ1BlORxNjjgOMfTkCdxFdgvi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3fe46fa3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:56 +0200
Subject: [PATCH v3 13/17] odb/source-packed: wire up `find_abbrev_len()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-13-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Move `packfile_store_find_abbrev_len()` and its associated helpers from
"packfile.c" into "odb/source-packed.c" and wire it up as the
`find_abbrev_len()` callback of the "packed" source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |   2 +-
 odb/source-packed.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.c          | 111 ---------------------------------------------------
 packfile.h          |   5 ---
 4 files changed, 114 insertions(+), 117 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 274923e0ba..8ad782dc7b 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -133,7 +133,7 @@ static int odb_source_files_find_abbrev_len(struct odb_source *source,
 	unsigned len = min_len;
 	int ret;
 
-	ret = packfile_store_find_abbrev_len(files->packed, oid, len, &len);
+	ret = odb_source_find_abbrev_len(&files->packed->base, oid, len, &len);
 	if (ret < 0)
 		goto out;
 
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 070a4e3958..b801b62023 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -370,6 +370,118 @@ static int odb_source_packed_count_objects(struct odb_source *source,
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
+static int odb_source_packed_find_abbrev_len(struct odb_source *source,
+					     const struct object_id *oid,
+					     unsigned min_len,
+					     unsigned *out)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct packfile_list_entry *e;
+	struct multi_pack_index *m;
+
+	m = get_multi_pack_index(&packed->files->base);
+	if (m)
+		find_abbrev_len_for_midx(m, oid, min_len, &min_len);
+
+	for (e = packfile_store_get_packs(packed); e; e = e->next) {
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
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -582,6 +694,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.read_object_stream = odb_source_packed_read_object_stream;
 	packed->base.for_each_object = odb_source_packed_for_each_object;
 	packed->base.count_objects = odb_source_packed_count_objects;
+	packed->base.find_abbrev_len = odb_source_packed_find_abbrev_len;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/packfile.c b/packfile.c
index 2da6bbe2b5..7f84094e53 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2037,117 +2037,6 @@ int for_each_object_in_pack(struct packed_git *p,
 	return r;
 }
 
-static int extend_abbrev_len(const struct object_id *a,
-			     const struct object_id *b,
-			     unsigned *out)
-{
-	unsigned len = oid_common_prefix_hexlen(a, b);
-	if (len != hash_algos[a->algo].hexsz && len >= *out)
-		*out = len + 1;
-	return 0;
-}
-
-static void find_abbrev_len_for_midx(struct multi_pack_index *m,
-				     const struct object_id *oid,
-				     unsigned min_len,
-				     unsigned *out)
-{
-	unsigned len = min_len;
-
-	for (; m; m = m->base_midx) {
-		int match = 0;
-		uint32_t num, first = 0;
-		struct object_id found_oid;
-
-		if (!m->num_objects)
-			continue;
-
-		num = m->num_objects + m->num_objects_in_base;
-		match = bsearch_one_midx(oid, m, &first);
-
-		/*
-		 * first is now the position in the packfile where we
-		 * would insert the object ID if it does not exist (or the
-		 * position of the object ID if it does exist). Hence, we
-		 * consider a maximum of two objects nearby for the
-		 * abbreviation length.
-		 */
-
-		if (!match) {
-			if (nth_midxed_object_oid(&found_oid, m, first))
-				extend_abbrev_len(&found_oid, oid, &len);
-		} else if (first < num - 1) {
-			if (nth_midxed_object_oid(&found_oid, m, first + 1))
-				extend_abbrev_len(&found_oid, oid, &len);
-		}
-		if (first > 0) {
-			if (nth_midxed_object_oid(&found_oid, m, first - 1))
-				extend_abbrev_len(&found_oid, oid, &len);
-		}
-	}
-
-	*out = len;
-}
-
-static void find_abbrev_len_for_pack(struct packed_git *p,
-				     const struct object_id *oid,
-				     unsigned min_len,
-				     unsigned *out)
-{
-	int match;
-	uint32_t num, first = 0;
-	struct object_id found_oid;
-	unsigned len = min_len;
-
-	num = p->num_objects;
-	match = bsearch_pack(oid, p, &first);
-
-	/*
-	 * first is now the position in the packfile where we would insert
-	 * the object ID if it does not exist (or the position of mad->hash if
-	 * it does exist). Hence, we consider a maximum of two objects
-	 * nearby for the abbreviation length.
-	 */
-	if (!match) {
-		if (!nth_packed_object_id(&found_oid, p, first))
-			extend_abbrev_len(&found_oid, oid, &len);
-	} else if (first < num - 1) {
-		if (!nth_packed_object_id(&found_oid, p, first + 1))
-			extend_abbrev_len(&found_oid, oid, &len);
-	}
-	if (first > 0) {
-		if (!nth_packed_object_id(&found_oid, p, first - 1))
-			extend_abbrev_len(&found_oid, oid, &len);
-	}
-
-	*out = len;
-}
-
-int packfile_store_find_abbrev_len(struct odb_source_packed *store,
-				   const struct object_id *oid,
-				   unsigned min_len,
-				   unsigned *out)
-{
-	struct packfile_list_entry *e;
-	struct multi_pack_index *m;
-
-	m = get_multi_pack_index(&store->files->base);
-	if (m)
-		find_abbrev_len_for_midx(m, oid, min_len, &min_len);
-
-	for (e = packfile_store_get_packs(store); e; e = e->next) {
-		if (e->pack->multi_pack_index)
-			continue;
-		if (open_pack_index(e->pack) || !e->pack->num_objects)
-			continue;
-
-		find_abbrev_len_for_pack(e->pack, oid, min_len, &min_len);
-	}
-
-	*out = min_len;
-	return 0;
-}
-
 struct add_promisor_object_data {
 	struct repository *repo;
 	struct oidset *set;
diff --git a/packfile.h b/packfile.h
index 0613fd3c63..79324e4010 100644
--- a/packfile.h
+++ b/packfile.h
@@ -217,11 +217,6 @@ int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn, void *data,
 			    enum odb_for_each_object_flags flags);
 
-int packfile_store_find_abbrev_len(struct odb_source_packed *store,
-				   const struct object_id *oid,
-				   unsigned min_len,
-				   unsigned *out);
-
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2

-- 
2.55.0.rc0.786.g65d90a0328.dirty

