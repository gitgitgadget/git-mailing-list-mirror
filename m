Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F03F1AA6
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995102; cv=none; b=L+PZQVjpzadfpUogEABUixj6Bv2lwVopUH8KNEZcpxqZN+WTjAeO3qam4/UDf1GjhBcxiFHuQcI59698YHM+K0VgmSUgIJMxbbUyJgyq1hUwiSH1MI98tEBl5SkyG5xMov6eznKvkGCse8iS8P1M/l7KEtopV6nm8VKKovj89Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995102; c=relaxed/simple;
	bh=NbVwKnzHOxsfdMEMgOVvuRyvu+0oMwNoPVJfh4J2fmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EX66ZR2F4wkSIPB7+Nu7dkHyIh82NekWeJUpZ6ipraAO8qLefe13iH0Xa2h1EG3CXcbhnygn/kDR+qkPTjv6oLERSebmHZ8QgnT7HUKN9XVt8TzVRUS2qoDxZB7g5VqrskD4idp6bG/FQEZ1E00mBUta4SI15bHyP5EDo6hXBws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cPvMc+s6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jmbQs6Pe; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cPvMc+s6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jmbQs6Pe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AEB461D00016;
	Tue,  9 Jun 2026 04:51:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Jun 2026 04:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995100;
	 x=1781081500; bh=Gc6A2RuGUhEW/SGkTRDqDt+KEOaHAMKfcJdu3p81RZU=; b=
	cPvMc+s6BXcN7U8IFkP28g/YfrdxhVyfObfQ8vr4P94VQf5gGntLXQKlvlR6ODZP
	ECXP0BARfEFlnlsC6j+WXi05bDTu/GlpAdI9nd1W7kNy1B8HCCXWKO8venDB/sZ9
	PYKFNzrTf6u/87yjAgQX9VgV9fPgK/dgpBRro01XGXPW2GxxDLU4N5NAgIEcsN0V
	jzDnGGW+USDc20IgOLYXNkeYMKd5yHjgUB1XUVvrGAaZChTfmdXfkzi4Olr4b1Ps
	Rm9xMmlrOb0AVDkRP9I0iUYqS7iwFslTVtMHwucVlG7UoNJxtdpVCldkI03VOpBP
	o3fum3IT0A5obyNSGNyUmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995100; x=
	1781081500; bh=Gc6A2RuGUhEW/SGkTRDqDt+KEOaHAMKfcJdu3p81RZU=; b=j
	mbQs6Pe0WH3sdk9LFhc86mWyiM+jrc1NznsJVIkO6UvIkrU8ikSGYAQCgA3nHNbg
	LtuE7+1Uxanfp4o2xCMXG3t6hU/LUX7o4wL/5hI3SM3SQo+MEV76t5VWtAwoATtb
	G/3kr+4ihPAydg62Rw4u0HZTfMUY3GXGKAhjk+kOysauKWUrS6quN0T82O5fiTcD
	RGGJgWI2Ju9VNrpCgC3A2gdY0GN94GcFGU5qXhGZGryg+dBQ30Z77Vt7hyMZk1Qx
	yM/pOWr5cDpVPHPbtUFx/xS9RN1R/hyyhm+adrc3HDvxsLoISna9p4ruZ6/4GcKB
	fCvzRk97uQrVhOpc34CaQ==
X-ME-Sender: <xms:HNQnahuUtXbMsO1O9ijQc7dkj9-ylPFoYE6oUx903mEB0_0QlTx29w>
    <xme:HNQnagfx13mCZ66GhJoyLeJXQpd_Ygv5Yr9Nq90-s_7NEgHlUJjk_GG9PgeHTSyJ_
    6GpNBJiqzb78Eg0S1P2SlznEjjzUxUEiKOGHqIfV3-cpnypA2wa0w>
X-ME-Received: <xmr:HNQnaibgOlwE979bxNCUxltdyu3aTAeJzoEBdpDyUfXuRARDW57ZgnbBUu7ZM9Qo4WbdOeK_9gV8F5kOm1rI7DQ9-pveVUR_s9IZq-BcT4A>
X-ME-Proxy-Cause: dmFkZTFScmXmBNtXOl4rqVqM8DAc19fyHinqrfJGsNjV/CE2oHckwvnGyvDfLnNUuwKybL
    TXXNE7zDSLzm9sqK7QnFjZefXQ77hB0yUpUORZINqHtbw80x5HeASQHzHrphN1o87wLUDo
    o+b2Dx90Cc3HLmwbZsks1v5Qe3wgVjPUMwX4Epw71mRv/T8ItHrE8RkWZrv81HY9CRlc3Z
    /OiNXFOpQwrN765XqADbyILD80acXbo1GJdpcquKP94bmw57TBOmknCC1tOk25qwSfgaav
    egwmPIOD8ZPaE7+A6cnzDiyYUxaYdFHC73rr/JrclTuz03BNq0lnxnglgQ3GRx5+ugY1OJ
    zn4PR6v5N1Cw8r+7UKxAj6J+KHCT9FaVH2z5mm2nn8qecFj7F3p79Pts10nd3o4QLeMZlV
    2nkExYR8yO+Evj94AjBQgwjOBZxnGdc0H9x6hoWaw2AK9XusrEmqy/U855UnB40WLXY+Hp
    jYSZM1WXh/AsxLmBE9O5fOEjica29FLkdrnaO065j0QQVA5WvMeeyweto4253kH/aFs+NP
    tgC6dtKfYc8i0/vClEvbwoD6/b2HmyOaeQTlPHLgk+3vwI/ii0MWnWUWgcl3gRcdkqFxgx
    BvFCjbOAagKJEpKbhwSHy1eTe3ipdHrSWQNAs4w8GncmD8nhETU3+NOCw3Vw
X-ME-Proxy: <xmx:HNQnajXdVekq9jKV-tkhxFpt9eX4RCBYm1kjHmHkc69aIb1vNLGn-A>
    <xmx:HNQnakhL70rYH3p9k93oPTJEVBDyw-EQdMSrKQtQHGpZ78ZyPyR6Pw>
    <xmx:HNQnahWpfVlLKnjxhAEut6sUnUCHIm0RcdvMjoGVBqbZDX0oduHQiw>
    <xmx:HNQnarOOWvHHf3klb4MzM5GNVX4gOgepZobfV1EY6hMFVf1ZBUNGTw>
    <xmx:HNQnascYZ0asGlC6C0qCYPkQypr-8EAnBQ5HmR7u25TuXUzjWxMN6tow>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21a9c5e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:51:06 +0200
Subject: [PATCH v2 13/17] odb/source-packed: wire up `find_abbrev_len()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-13-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
2.54.0.1136.gdb2ca164c4.dirty

