Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238FB33B6CB
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993729; cv=none; b=HhSWpWwob7DZ8qv4sKi3/+imGwQtU9HefPxtnGMemy/TNoChb9yxok9ITSKvUOyX9piVWjFXvvZp8ze5KUd9l5DQIFSVoRrHOhPYPHpzMiPC9vwSoK18Vm38Sa7Bmul1cqvB9vHiiVobD0Mih1TWZcm95VYfX9wniEdk4uY7kDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993729; c=relaxed/simple;
	bh=9RKgltBbvurCkFIcUZiYq6swSjn4NSAxYYgbVve0X3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oEw0lcjFq/+VluzG6gf2KnYL1JkQUYaAkBPHO7Srt+GKB8EsVp6u96uN9IQfv9bg5THnucUDn7uF2ihEYcXW+CnuubA/Q08XDfauGqfq0J1lja4HI3ZJmm/pcqYiTqrzsm0+dVIdjC3OhlDQTaCW8+u7G/jn8xswtOaJlRiwEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iRthAPvq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cwA7s7d6; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iRthAPvq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cwA7s7d6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BCBB1D000D7;
	Thu,  2 Jul 2026 08:02:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Jul 2026 08:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993727;
	 x=1783080127; bh=D8i3IWTx/9BGynhxSd7Y9PkBSqN40gpTIAkZB9WJBKw=; b=
	iRthAPvqZ+CCpnlTw1fxdFJSOSnPEoPKU2RSrBGM/rfWLcbzAvnFKo7AGypF7LYw
	vuhMoQ8fD40qeOSVYGKC0K6kOgSF+hTvacE1VKP6Jom31dZzSm/O0U1wqZ+8rXLN
	TpndMw0XxThas9bLweC3+qGbMKLmI87/Qtbf/CEZKEuBEaVL29TrLk8MVmYJw618
	bNKiBA60SQzfgSyN+HdcL254v+GbGGuwCOkntWjpZ4mYrjCFqRxUVGsHV+++H9Ua
	e+lP+xMV8BT1AWpyYd2K9wblr491y3SRqkh5wbDEgbpu8LB+1b+sQmeuYVWoa4GH
	+Y9SJO1h1Y6UM1577Xwsog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993727; x=
	1783080127; bh=D8i3IWTx/9BGynhxSd7Y9PkBSqN40gpTIAkZB9WJBKw=; b=c
	wA7s7d6r3PryfV6tqu7cM/NEAE86a6yodz12MIkjdw4UXy1xA1yFZjSzKuLVVw+d
	fu0WNCsPKwecjBp0pl9c2NXqFdUj0Mg1LXJIDnRxqktBTUqwUBBznbFAX0B3W18m
	oxY0sV1cWLr8iJLijpR8me3sBsqSHcF3kL+K93nGXMeu3g5o7z9unTAwbIFX4hEf
	UyAYzWaMF284TINs2X2NEKAL8kwFtLrIZLbyGoUxP3IIWv+SnLbkOB8Ff0R095Kq
	YPWE8ksEy/9Q3t8oTnyBy9ukg0S1bn898KYCiCHQXW+NlKodF2OIZh34FN51zClz
	Hm/Tyl+HcFNfCBSY98rVw==
X-ME-Sender: <xms:P1NGaqCNkfria759Tj7w3PWTwVTmeWsYbDQUCDD83Rs0pnSYU7v_Iw>
    <xme:P1NGar8EiXZ1DmuEezjAs9Y_bPrDhe_2nu1u9roaZLHUx6qenO4ClXYIIrFxOB_fE
    5Tc1NwgeSUHu7N4i_jYsDu7d_ZMVYdf6E1X0nChHOLers3Pfjtwiw>
X-ME-Received: <xmr:P1NGaq-nLMnpAhHU2c8eYCd-_wwXZXBSkGSg5PvZF0vuY0MAy7U4Csmb8leUGxO0DGyRDhCHz49OAJw2AvrfVjhk78XeqHI8cZoHB7wP1eIipg>
X-ME-Proxy-Cause: dmFkZTGUfKwS0plvaBJCNefM2Kw2aZYundJYr4MZPNkDKxKmaiBcZPfSGOW7Mdo8z7/vce
    Hkfp9gmiH/BKYSmaX4AyL5+ORNc2mtgs2BadLuXAuVSoU5Rm/tNC9ymqJFjPflN6vK1w7F
    K/HRQT2FJREcWvj/TwhfvsxTvWDwJ4s87X0l/GUd4fty0Qfc8D+e5yyEtCf7UQYMrVz4b9
    tBkMNZsNLX67aBxsJRvXGZ9sYGZgTNZgJUuvCegzp5PlwWV59WYeiL8Lt55YLC1G7E/TMz
    1xuQNKGpmK6mAbHwOkz6IsdeiqSkFEEY81gNS+niPAXRTr7ERidiH4dDCd7gzLLqN27eAq
    8sKLBu7WqOZqxF5QJeLk4cRjeG3/nZ7UeYLeTrFBjjcmsitOFARPVy5ZAoZ5MY4XGf1vLO
    cOsWE/Thcv9BRt5xdFNraMLO/l+lZC1jM+O/i/2T6X/ehCfGjehE6330oAuTBb2ARGCCcT
    b3VHPIHe2zyYHdH3VEp+hahuoSdRnf2Uwotf80D54yaytNyNN8Oixwv6JhCaqtX5DN8dke
    6aOdimHE17DlRlU3JA7wRXsj3jIwlS8QyTaZAoFalxscMTzfJwg0m565Q/Tk6BmInIceTu
    gdIX9luLSNMi8yN6oXwUbyuAB9w0nbWvCXCmdtGXeJfR7In7UIaoPNlmH2Xg
X-ME-Proxy: <xmx:P1NGaicjyQb-rKj-vdyzvV8M7LBNNyq0OBQIHi0YguM0mJNf8Qoe-Q>
    <xmx:P1NGajF9jj2AkC2IHS0RkxLBUtx9pupAO5ZkelaM_90Mhgol6qsi7A>
    <xmx:P1NGagfV4iuM0_pzQ_wpNG9nQkVAYfSiK5jkPz3exBmyMo7vKl8_fA>
    <xmx:P1NGatEHQF3qmhemnhOLtIKDaNljtD8ZlwZumJexwlCjXoAPU33pqw>
    <xmx:P1NGar9zRVKn122QKu3V27wGooXsSUgpxNkGWGgvK2xOSicYf8xdF9hk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:02:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec2c289a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:02:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:01:59 +0200
Subject: [PATCH v2 1/6] packfile: thread odb_source_packed through
 packed_object_info()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-odb-drop-whence-v2-1-b0af7468ad95@pks.im>
References: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
In-Reply-To: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Add an optional `struct odb_source_packed *source` parameter to
`packed_object_info()` and `packed_object_info_with_index_pos()`. This
parameter is unused at this point in time, but it will be used in a
follow-up commit so that we can record the source of a specific object.

Note that callers in "odb/source-packed.c" pass the already-available
source, but all other callers pass `NULL` instead. This is fine though,
as we only care about populating this info when called via the packed
store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     | 2 +-
 builtin/pack-objects.c | 4 ++--
 commit-graph.c         | 2 +-
 odb/source-packed.c    | 4 ++--
 pack-bitmap.c          | 2 +-
 packfile.c             | 8 +++++---
 packfile.h             | 6 ++++--
 t/helper/test-bitmap.c | 2 +-
 8 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0f3dbd9850..8726485f1f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -497,7 +497,7 @@ static void batch_object_write(const char *obj_name,
 			data->info.sizep = &data->size;
 
 		if (pack)
-			ret = packed_object_info(pack, offset, &data->info);
+			ret = packed_object_info(NULL, pack, offset, &data->info);
 		else
 			ret = odb_read_object_info_extended(the_repository->objects,
 							    &data->oid, &data->info,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index bc5f9ef321..620d9ce085 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2463,7 +2463,7 @@ static void drop_reused_delta(struct object_entry *entry)
 
 	oi.sizep = &size;
 	oi.typep = &type;
-	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(NULL, IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to odb_read_object_info, which may find another copy.
@@ -3804,7 +3804,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 	ofs = nth_packed_object_offset(p, pos);
 
 	oi.typep = &type;
-	if (packed_object_info(p, ofs, &oi) < 0) {
+	if (packed_object_info(NULL, p, ofs, &oi) < 0) {
 		die(_("could not get type of object %s in pack %s"),
 		    oid_to_hex(oid), p->pack_name);
 	} else if (type == OBJ_COMMIT) {
diff --git a/commit-graph.c b/commit-graph.c
index c6d9c5c740..9dc8bd5eee 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1538,7 +1538,7 @@ static int add_packed_commits(const struct object_id *oid,
 	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.typep = &type;
-	if (packed_object_info(pack, offset, &oi) < 0)
+	if (packed_object_info(NULL, pack, offset, &oi) < 0)
 		die(_("unable to get type of object %s"), oid_to_hex(oid));
 
 	return add_packed_commits_oi(oid, &oi, data);
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 42c28fba0e..43fb53b72d 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -59,7 +59,7 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
 	if (!oi)
 		return 0;
 
-	ret = packed_object_info(e.p, e.offset, oi);
+	ret = packed_object_info(packed, e.p, e.offset, oi);
 	if (ret < 0) {
 		mark_bad_packed_object(e.p, oid);
 		return -1;
@@ -99,7 +99,7 @@ static int odb_source_packed_for_each_object_wrapper(const struct object_id *oid
 		off_t offset = nth_packed_object_offset(pack, index_pos);
 		struct object_info oi = *data->request;
 
-		if (packed_object_info_with_index_pos(pack, offset,
+		if (packed_object_info_with_index_pos(data->store, pack, offset,
 						      &index_pos, &oi) < 0) {
 			mark_bad_packed_object(pack, oid);
 			return -1;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 83eb47a28b..35774b6f0c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1877,7 +1877,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 			ofs = pack_pos_to_offset(pack, pos);
 		}
 
-		if (packed_object_info(pack, ofs, &oi) < 0) {
+		if (packed_object_info(NULL, pack, ofs, &oi) < 0) {
 			struct object_id oid;
 			nth_bitmap_object_oid(bitmap_git, &oid,
 					      pack_pos_to_index(pack, pos));
diff --git a/packfile.c b/packfile.c
index 1d1b23b6cc..2b741d7a76 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1324,7 +1324,8 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, &ent->ent);
 }
 
-int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
+int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
+				      struct packed_git *p, off_t obj_offset,
 				      uint32_t *maybe_index_pos, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
@@ -1446,10 +1447,11 @@ int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
 	return ret;
 }
 
-int packed_object_info(struct packed_git *p, off_t obj_offset,
+int packed_object_info(struct odb_source_packed *source,
+		       struct packed_git *p, off_t obj_offset,
 		       struct object_info *oi)
 {
-	return packed_object_info_with_index_pos(p, obj_offset, NULL, oi);
+	return packed_object_info_with_index_pos(source, p, obj_offset, NULL, oi);
 }
 
 static void *unpack_compressed_entry(struct packed_git *p,
diff --git a/packfile.h b/packfile.h
index 2329a69701..e1f77152b5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -320,9 +320,11 @@ extern int do_check_packed_object_crc;
  * Look up the object info for a specific offset in the packfile.
  * Returns zero on success, a negative error code otherwise.
  */
-int packed_object_info(struct packed_git *pack,
+int packed_object_info(struct odb_source_packed *source,
+		       struct packed_git *pack,
 		       off_t offset, struct object_info *);
-int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
+int packed_object_info_with_index_pos(struct odb_source_packed *source,
+				      struct packed_git *p, off_t obj_offset,
 				      uint32_t *maybe_index_pos, struct object_info *oi);
 
 void mark_bad_packed_object(struct packed_git *, const struct object_id *);
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index b130832b81..8547ef67e2 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -52,7 +52,7 @@ static int add_packed_object(const struct object_id *oid,
 
 	entry = packlist_alloc(packed, oid);
 	entry->idx.offset = nth_packed_object_offset(pack, pos);
-	if (packed_object_info(pack, entry->idx.offset, &oi) < 0)
+	if (packed_object_info(NULL, pack, entry->idx.offset, &oi) < 0)
 		die("could not get type of object %s",
 		    oid_to_hex(oid));
 	oe_set_type(entry, type);

-- 
2.55.0.795.g602f6c329a.dirty

