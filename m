Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660F41C2E4
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572372; cv=none; b=flR6rLxpnjEQQttClMeTmibzWFSAJsbzfG/botGWf686VlphCj2NZIFkoZluOuX1EtuN995o4sDTbUDFPHUe0baugd7+u0oTZFAHUEXaUyvk0alR7U/FaKHknxSW+Ii4JHKGAwllsIkCn3/2gcnzWakLVmRq5NglMVG+vu89amI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572372; c=relaxed/simple;
	bh=7IQtjRf7DT7CQ/heD7IHaoKEhVXQFpaP4lYTP0tQ/DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czb9p//ZQFe7fc5tP1upZmeUVGK+R0+TRa5aZCfvRAdbq8O0AlgOqcme/3wrW7Ulio92S4lvFkfuVHX2zlB4tGv1DSWI5Tq1YWT0ps8OMcscrD1F810lDY9qRYXjMjQluMupDLoop5GWuCSI9iaNdto6TzqAReCaJn1UAMbNhCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jNUuds1x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TXZInQel; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jNUuds1x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TXZInQel"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8967A140012E
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:26:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 04 Jun 2026 07:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572369;
	 x=1780658769; bh=KkVGyV+j8os+dnCd7m/phChS76sxC3PUceGOGEw8amY=; b=
	jNUuds1xzJTILdi3T+Og/WUDBewX0M78hhllMf1n3fqpPNQfKO+5rxied6uFxF/O
	E1oLdzsljy+vbnMFGs53xdP12xjo9NALIXK9fFPyd6R/i+jMbKrpCNR1tD/Hc15K
	8G9AsljdN7B6KvM+NUm50GKGn2CAjMliqrwI7KWNeRKJCUhjsIy+s32+BMZ9RfDH
	r3ymI+0WFijHQwfve1oPTYhkn/CFyhmUszoSWQGiTa/nqsxtY0wXf3iYVFSK/XzX
	PCGG0nJlOtvePXoRx7hGsOcEOoc4c7dW25ib0/M13mdQ4sNJl8pGc1FAY6ytmiuv
	QeqPSnFcZ1UvF+/lynEb0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572369; x=
	1780658769; bh=KkVGyV+j8os+dnCd7m/phChS76sxC3PUceGOGEw8amY=; b=T
	XZInQelCdTJzmdzA2nIasnTF05h4QxKPz8dNyXyNaemBk4bN4n8gfZkTUBIrqtMV
	ffBj6tElhAOvEUueXnqMH07hKRFIt3RRa3/WIyK1BTfg/QyqqWa7pjkZfpS65/sn
	gmXorrS5k1X77Z/omYISFoPJJiEa30nya2fDuSw/LPx03rBl/TwRzQeqgIyFl3EP
	mnO4pMti8yDWaskdD4Oag0JNw7o6XE1QoZSJOjGIok4oCVMZDmejc+Vekwbve562
	yLtKJ65sqI/pB+qvAXQTXoHBS7moM0Olt3mLuy0ybpjrQZKFVnmcNmsrDdPfOU2B
	AmVt4UiIMutaqTGSDuPvQ==
X-ME-Sender: <xms:0WAhaqs0wfwm_eaIrzgzCTjfc2CtBDyom80wLOnnrxnzisoMxoynCA>
    <xme:0WAhamYj2bHzdppK5ruD7FuW_fWtscFyZVzQsEXBB-yZ3CbKGyzCKjiNZ8_M5kone
    oy_vekCFyaFG2IMlL9KvUflJprQWVBQhhco3yh0KaaQjx2soqFG>
X-ME-Received: <xmr:0WAharYhbGH4b7eTxvgm9Ow6-hVkVPCv5LaxhQOdkvXom9fn7kAQGGIlVQcEqKPj0-gdp4xoNnjhneMoZ5Pajtn7IXjcn6uCnbH1HyAtoiM>
X-ME-Proxy-Cause: dmFkZTFvnA675j0G3ICDI+LZmYwOEOXh/b/yEDmzKkrE8aQYc50VNbL1KC+FHkeBxhcdlH
    vQ5UOaZjlApbEZns9afrBb4UK8FcHYsqaadyPGbWhpCCukm6RXLWi4sajRdd3/BU9ka0TD
    gRG0wzzva0tPoKBPOKkw1xB41pQmi6LFeix12yvELH4HwfWbQ9SJPNcYIRXAI+Gkz8cgSF
    95vgpUqVdvp9oIhEjL5+ClnPTZCkZwcjNgSNfPiEhrni1DNmEowxjumkmcl8mkXWAm0IDT
    b/QjErvyK7uaT3AgWPm4/wwlPiGchhp0i+uA9V/0/f/IsP6DU2oMzDE7/+yzfGYNB132rn
    6dnxii2npagnkkBEovrLID+9SDMWVBaC7BO/yBMcw6EVf9SlCKncmBdcKYMaDFagtzjwxC
    seqKggk8gjWf62bzV9sy0LNFCXuWof/Xntsk/xzDJzQZMkSIOmzxvT9O0WkX/rEVCBd1df
    faH8VM1iTFaHZ+a2AvWRpB572V/UMnbA84j6ZOnLZ51jkdwjpyxPd4DfkyZwMc2cKEZMu1
    YP2gMCa7oPObc+vzbDaG4To1npjV3ArNz8KdHIvytkEVHiZyRHvRfZ8l2xVk09NFEWO73b
    1zhIERBH5SZzKdcMpFlauyiZJ5m9O+y8rJ9KWXp8+P7bO2zZtMOPWKT8CMlg
X-ME-Proxy: <xmx:0WAhaqVfkfEjC7-JVJvkk7QdBKUNHeZoorIRtRHZOtUYLdpwsQzsuw>
    <xmx:0WAhaq3sFFrOrgQWu8bhW53aapUkpC8KVieCeqjcytXZCu54mJKAOw>
    <xmx:0WAhapYgsx7gYtNfv5vtYrPnLnbdz2mY92ixN-aCZNh6VWs-J1yPxg>
    <xmx:0WAhalqt0i4h8qWAsiGkZormohGNc66d0vRS91Ce9Wh-j9172hU-cg>
    <xmx:0WAhatyWuPmLQqjGgdvDnkXEl0j9WpnHKA9sErYsI_bkf_QKI7ZRprmO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:26:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3905a0b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:26:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:39 +0200
Subject: [PATCH 12/16] odb/source-packed: wire up `find_abbrev_len()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-12-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Move `packfile_store_find_abbrev_len()` and its associated helpers from
"packfile.c" into "odb/source-packed.c" and wire it up as the
`find_abbrev_len()` callback of the "packed" source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |   2 +-
 odb/source-packed.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.c          | 111 ---------------------------------------------------
 packfile.h          |   5 ---
 4 files changed, 113 insertions(+), 117 deletions(-)

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
index 013d8a50f8..b801b62023 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -370,6 +370,117 @@ static int odb_source_packed_count_objects(struct odb_source *source,
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
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
@@ -583,6 +694,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.read_object_stream = odb_source_packed_read_object_stream;
 	packed->base.for_each_object = odb_source_packed_for_each_object;
 	packed->base.count_objects = odb_source_packed_count_objects;
+	packed->base.find_abbrev_len = odb_source_packed_find_abbrev_len;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/packfile.c b/packfile.c
index 5cb14b28de..69f6354ed0 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2120,117 +2120,6 @@ int for_each_object_in_pack(struct packed_git *p,
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
index 9f5b5c145a..8d23bec644 100644
--- a/packfile.h
+++ b/packfile.h
@@ -229,11 +229,6 @@ int for_each_object_in_pack(struct packed_git *p,
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
2.54.0.1064.gd145956f57.dirty

