Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0EB368974
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062789; cv=none; b=S+NnviMrShJHUaDcSH7p7NbJEdaR4JUYk99tksYx+hhUNgZRYC4ZO6LjSBSCtCbE3/DtNc0G9LRMyxyE/3ggPp+ppKHMS6UUpo+oLCmljkMpnaW+C9L2G+g7+22iOzbjyEyHp1sHMrQifl9UFhhfcBxntkXDlXGyM0LQxhDyXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062789; c=relaxed/simple;
	bh=6Q29XBPesQH8mmbGRAb3YyOLQBV6pIEKCMx68PPRb5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U24cbgOYn9jOD09y+qnjkFgBwfgKCNfuPSD/kch6r+iXTtbEQk2r9tJXGmPobjMWitu0cTYriMHXxDLlAlR6prny14rGI+gMsRuqmn/LVl3HWN4ylYk12dAec5scwCCtQLsqVGGWn7cgJiKJJ9OuZvbO4/gYWThBVQU7EwlOun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SRpEZ5qO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BNC/W8KF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SRpEZ5qO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BNC/W8KF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0856B7A00D2
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 18 Aug 2026 10:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787062786;
	 x=1787149186; bh=NvVUH5WN7uoy8K8YjjxTt2PCiHLHnyqSZ/Zit9mIfCc=; b=
	SRpEZ5qOyH/Knp+XeFzjSOY5ZXWi3yBnKhJwBI+bl6gADIExXyQsS9wQgSYGTjJ9
	NX4PTMGdLI6a5ybua2BDvX3QIYIzYLqNsiAKxb1o46O8oH6n/wflR9M1oLa8ZJMP
	2tDe8Npsx0M2It14cQzquH9EBxX2sR2v4nYsK854QeCm+fffbBSoQquaAO853+mJ
	Auft46EuD9IShOZZdpua6wA/riQ0bx1cWi/5Mb7Q5zCTRLb78bmR5UOhrPwfTa5G
	s1zqitRoQyw7p98Fkh6tSDd+aen5Df0LJVPI+YywFjgxsSk2YhmIrpbqIteQtsX1
	NOW9Qr1+FbXaanpBwx2YOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787062786; x=
	1787149186; bh=NvVUH5WN7uoy8K8YjjxTt2PCiHLHnyqSZ/Zit9mIfCc=; b=B
	NC/W8KFZYGd432+vANiMxQVCkLnkBMTVRmgMXLNoA9x6UmuLZA5CiaFjfv484FeY
	l8aQsTV7ioEecDZU0PgWlHA0/OA9rpN3shSkWQ06xBz+wT4SMg1tD/P+qgZZeJPM
	jUhmX4HRFC65dfV/1gyrI2T4rXgM5EDTgpvSQIZsIBMN5h7+gfv6P3xsFPdGiRbJ
	AiVHnp+pQJnDwAARYdBtvBk5KTOQSR0+G8jrOBRYDpArW/+RNnz5TqvNEdCS6Gfr
	0DFVaKGDWDpKVndzvPhqmMbmkZl1r0DeeRrLx/B6nOuytPIeHJtjL6kSQ7tMBHlj
	3/HQYOmXY7l262VFkehnA==
X-ME-Sender: <xms:AmqEavOVL3hhCK7R44ZjQcrJhZ6IduKA9R2WYQaq7I0GauFaH-omeQ>
    <xme:AmqEag4_n4nc081OasX6lIS0S8_IIAzujNZCWSoR2L908zeU1jjyNIiJ-blf3S_0t
    TCQp33qfjkTPTCSTmIno1_kuPrRYDMw6zDzaqnAMbQYOAPeVyTwUdc>
X-ME-Received: <xmr:AmqEaj7YfmyI9AxNRj03FRnGkKso370qhyXqSVDhwO4Uw10_W4XRpm1CSsnH6yiE7mvZN6vk3rsM6tCYcdMoTxqJp2f1x2KW9C0QGu34>
X-ME-Proxy-Cause: dmFkZTFi9gTDGN5rU6v5bk4puH/TN6PnebWJZuvNiMPwE2cjL/TcvdlYqVaQ+lghmSk/qN
    WCasTuwVGcAbpI1P2OnhaZi0kO9rwywa2//F8UO4KwrYPyqIVy8n3cjkIejGy2zTwRJWTO
    2g4RZKKUqC/L0EQ1DOWFvX9CJk/85pj90zgi9yL3SAXHLijFYCUIGa9l2nu9m1z149jyrj
    iVnndofBls0dTQZrLD/SJsERHbs2ZKG9wFCTkCpCcBmjHjSfmbQUtLdkHp0u/JktXsA4/v
    2ltnMeFDVWCfVv6/ePXXwP1mhEgz1iDdYm09PKsAH+RLX1v7QmJBJ4XCDQs1kQLkCd/4Ce
    NbGyhAXOrPzDTUU2UsRvwc5dCDFCyfO2TU/HLEl/uJVp1vpPkGNRo/Nq+d4AMH9VCNi0jL
    /xwTVpKtFSDa9JRDiTs42INtimqK6bhc6JZPJHgkJhKWwaOmEv8f5bjfcdn7JVCJd+Hmak
    kEgqMdR1ehpegxLSiqZP0Ji5xSMuFhwfLWqUI9zYfFkp7zI8Git0CU+yj2I9nFmfHtAP+V
    5dQ+ONJB2LJtrvojub4vjdkx2YZoSKW08vCPH4pgCh7TDjxMDD+rMynP8pmi4G8NGw/eIz
    GXucvFLtWtZaAI+iXDrnn+tvYHSCp7lUIC4XyQdbhCnvsvO8eEOgwK/Ze5kQ
X-ME-Proxy: <xmx:AmqEao1H563BikL34pEuCIIxa-GlCPpJP0NrfNH2pQX7bRBDvpJKCQ>
    <xmx:AmqEanUa47IBBcZ0hdzVxAUg5AYQitN4vWuygZdYrLNaqZsFPOT_hQ>
    <xmx:AmqEar5O_s9rry2xaiiLsK40rzz4IQILZEQAetu3sVGL35oa6j1orA>
    <xmx:AmqEamJELXQAJ_FS_g4uCuSXij2XqPqC7Py4GtFhCvZ35shrG6htyw>
    <xmx:AmqEaj-UIKTQr5tEIL7CEJVH9R7L8RaaP5kjK8v_6BHXb-vWw73sVwPY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d814206 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 18 Aug 2026 14:19:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Aug 2026 16:19:30 +0200
Subject: [PATCH 3/7] odb/source-packed: flag known-bad objects as corrupt
 and not missing
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-pks-odb-generic-corrupt-objects-v1-3-ec234567510f@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When reading a packed object that doesn't verify we mark it as bad and
indicate to the caller that we failed reading the object despite the
fact that it supposedly exists. This matches the semantics we have now
established in a preceding commit, where we discern failure to read a
corrupt object from a missing object.

What doesn't work yet though is when a call tries to read an object that
has already been marked as corrupt in a previous call. In that case,
`find_pack_entry()` will tell us that the object in question does not
exist, and consequently we'll not flag the object as corrupt but as
missing.

Fix this issue by bubbling up whether the object is corrupt and, if so,
which packfile contains the corrupted object. We don't yet need the
latter information about the specific packfile, so we could've just as
well made this a `bool *corrupted` pointer. But we'll need information
about the containing packfile in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c    |  2 +-
 midx.c                    | 10 +++++++---
 midx.h                    |  3 ++-
 odb/source-packed.c       | 23 +++++++++++++++++------
 packfile.c                | 10 +++++++---
 packfile.h                |  3 ++-
 t/helper/test-read-midx.c |  2 +-
 7 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ec5b6f206..10c2471024 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1786,7 +1786,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		struct multi_pack_index *m = get_multi_pack_index(files->packed);
 		struct pack_entry e;
 
-		if (m && fill_midx_entry(m, oid, &e)) {
+		if (m && fill_midx_entry(m, oid, &e, NULL)) {
 			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
 			if (want != -1)
 				return want;
diff --git a/midx.c b/midx.c
index 76c3f92cc3..37f082dbdd 100644
--- a/midx.c
+++ b/midx.c
@@ -591,7 +591,8 @@ uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 
 int fill_midx_entry(struct multi_pack_index *m,
 		    const struct object_id *oid,
-		    struct pack_entry *e)
+		    struct pack_entry *e,
+		    struct packed_git **bad_pack)
 {
 	uint32_t pos;
 	uint32_t pack_int_id;
@@ -618,8 +619,11 @@ int fill_midx_entry(struct multi_pack_index *m,
 		return 0;
 
 	if (oidset_size(&p->bad_objects) &&
-	    oidset_contains(&p->bad_objects, oid))
+	    oidset_contains(&p->bad_objects, oid)) {
+		if (bad_pack && !*bad_pack)
+			*bad_pack = p;
 		return 0;
+	}
 
 	e->offset = nth_midxed_offset(m, pos);
 	e->p = p;
@@ -1028,7 +1032,7 @@ int verify_midx_file(struct odb_source_packed *source, unsigned flags)
 
 		nth_midxed_object_oid(&oid, m, pairs[i].pos);
 
-		if (!fill_midx_entry(m, &oid, &e)) {
+		if (!fill_midx_entry(m, &oid, &e, NULL)) {
 			midx_report(_("failed to load pack entry for oid[%d] = %s"),
 				    pairs[i].pos, oid_to_hex(&oid));
 			continue;
diff --git a/midx.h b/midx.h
index 939c18e588..1f2f2d5321 100644
--- a/midx.h
+++ b/midx.h
@@ -117,7 +117,8 @@ uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos);
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n);
-int fill_midx_entry(struct multi_pack_index *m, const struct object_id *oid, struct pack_entry *e);
+int fill_midx_entry(struct multi_pack_index *m, const struct object_id *oid,
+		    struct pack_entry *e, struct packed_git **bad_pack);
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
 int midx_layer_contains_pack(struct multi_pack_index *m,
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0890704e76..50e9be3b4c 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -13,18 +13,19 @@
 
 static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
-			   struct pack_entry *e)
+			   struct pack_entry *e,
+			   struct packed_git **bad_pack)
 {
 	struct packfile_list_entry *l;
 
 	odb_source_prepare(&store->base, 0);
-	if (store->midx && fill_midx_entry(store->midx, oid, e))
+	if (store->midx && fill_midx_entry(store->midx, oid, e, bad_pack))
 		return 1;
 
 	for (l = store->packs.head; l; l = l->next) {
 		struct packed_git *p = l->pack;
 
-		if (!p->multi_pack_index && packfile_fill_entry(p, oid, e)) {
+		if (!p->multi_pack_index && packfile_fill_entry(p, oid, e, bad_pack)) {
 			if (!store->skip_mru_updates)
 				packfile_list_prepend(&store->packs, p);
 			return 1;
@@ -40,6 +41,7 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
 					      enum object_info_flags flags)
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct packed_git *bad_pack = NULL;
 	struct pack_entry e;
 	int ret;
 
@@ -51,8 +53,17 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
 	if (flags & OBJECT_INFO_SECOND_READ)
 		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);
 
-	if (!find_pack_entry(packed, oid, &e))
+	if (!find_pack_entry(packed, oid, &e, &bad_pack)) {
+		/*
+		 * The lookup may have failed because the object is known to
+		 * be corrupt in one of our packfiles, in which case the
+		 * corresponding pack entries are skipped. Report the object
+		 * as corrupt instead of as missing in that case.
+		 */
+		if (bad_pack)
+			return -1;
 		return 1;
+	}
 
 	/*
 	 * We know that the caller doesn't actually need the
@@ -77,7 +88,7 @@ static int odb_source_packed_read_object_stream(struct odb_read_stream **out,
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
 	struct pack_entry e;
 
-	if (!find_pack_entry(packed, oid, &e))
+	if (!find_pack_entry(packed, oid, &e, NULL))
 		return -1;
 
 	return packfile_read_object_stream(out, oid, e.p, e.offset);
@@ -583,7 +594,7 @@ static int odb_source_packed_freshen_object(struct odb_source *source,
 		timesp = &times;
 	}
 
-	if (!find_pack_entry(packed, oid, &e))
+	if (!find_pack_entry(packed, oid, &e, NULL))
 		return 0;
 	if (e.p->is_cruft)
 		return 0;
diff --git a/packfile.c b/packfile.c
index 0eee45055f..34e2f9bb8b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1859,13 +1859,17 @@ int is_pack_valid(struct packed_git *p)
 
 int packfile_fill_entry(struct packed_git *p,
 			const struct object_id *oid,
-			struct pack_entry *e)
+			struct pack_entry *e,
+			struct packed_git **bad_pack)
 {
 	off_t offset;
 
 	if (oidset_size(&p->bad_objects) &&
-	    oidset_contains(&p->bad_objects, oid))
+	    oidset_contains(&p->bad_objects, oid)) {
+		if (bad_pack && !*bad_pack)
+			*bad_pack = p;
 		return 0;
+	}
 
 	offset = find_pack_entry_one(oid, p);
 	if (!offset)
@@ -1962,7 +1966,7 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
-			if (packfile_fill_entry(p, oid, &e))
+			if (packfile_fill_entry(p, oid, &e, NULL))
 				return 1;
 		}
 	}
diff --git a/packfile.h b/packfile.h
index e1f77152b5..3229a6ed47 100644
--- a/packfile.h
+++ b/packfile.h
@@ -294,7 +294,8 @@ off_t find_pack_entry_one(const struct object_id *oid, struct packed_git *);
 
 int packfile_fill_entry(struct packed_git *p,
 			const struct object_id *oid,
-			struct pack_entry *e);
+			struct pack_entry *e,
+			struct packed_git **bad_pack);
 
 int is_pack_valid(struct packed_git *);
 void *unpack_entry(struct repository *r, struct packed_git *, off_t,
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index fb16ec0176..27a05da957 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -82,7 +82,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 		for (i = 0; i < m->num_objects; i++) {
 			nth_midxed_object_oid(&oid, m,
 					      i + m->num_objects_in_base);
-			fill_midx_entry(m, &oid, &e);
+			fill_midx_entry(m, &oid, &e, NULL);
 
 			printf("%s %"PRIu64"\t%s\n",
 			       oid_to_hex(&oid), e.offset, e.p->pack_name);

-- 
2.55.0.822.g20453c30eb.dirty

