Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D128421EEE
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572374; cv=none; b=WrpKZcZa5Vbllhic6H+SA8FRwO0sWRqXm9i1lqvlaVJTfrCQrWClYHUaKEPc5DVnL18RPqd3hTBw1cUd+FeGn1lEewsrcdHTNFqntF7DX0m7DVX7C2ngEExPxOvSTOAlr773K5cMer7Oey8XlRyjDU65hrkNhWXeQhTrZTyjsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572374; c=relaxed/simple;
	bh=2KZC5MTWPUaS3NHHmya8D30Ui25YiEf5ABQcLzeaYew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpWjJKr7Wt0ZpTNuY7WvNLsZSo0vfxqZw5vFOtuDSNgBANTJvGgnLVlrlSi2NjYguMUG0WWAr4rspgsRT870IhruiWJAw2HF2Agj2Cjf8roDRv7mPhQbZ44pTedaL2Xh1DnmngVO7Y3ALejlJ9p2YbfPXdNT/X9Dsjk+7opWy/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CUzTclWc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MMrb2dJ5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CUzTclWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MMrb2dJ5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F490EC00CE
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:26:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 04 Jun 2026 07:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572372;
	 x=1780658772; bh=4NgTKev0zsQH1vp9YWzNytyIkfcr/gCXVBC0579iz9k=; b=
	CUzTclWcxU26AXfEK9XC1x8brxg6PSkgdxKN4uqW3Bok8JS+E8VLTNfN5h8zphvc
	f0oqnSSCi3iZr7cS52RdC+gz3/OleAuiEOC4PXymmckoHnPBBHDiVX1h0l+3G0py
	E61JbWyz7k0n6hqm0yUqbiBssbBtE3Co9p447OsUE9D89ep5RB69iRNxWugaw+tj
	DaNuudk5kGkgpJNA5dbAjbSVXnKdyL5UaQOmzVpyAaDsQWFckJ2p/JprUw/P1Btt
	gIhxKYaehS6G69mEeVHh4XQZJJot7HoDZxBV9T5hDb6rx0W6wJY6s5JvkvJKSc2M
	GjSsyoLnjFGwHWsdm5XJpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572372; x=
	1780658772; bh=4NgTKev0zsQH1vp9YWzNytyIkfcr/gCXVBC0579iz9k=; b=M
	Mrb2dJ5YBKikunfHDGopk1B2NBdpu9hZ9PMbRHpmJa0o/XC5mlu/FAq+XTUVPcdc
	GgyMRRkjJ0RHEjRKUK5K9rFgqKbSqhlSL3KFzV0yTD4t11whFrGMf8aCsCfFrrre
	+YcKDGEszDYQfGtO2PVStnQx8syes8LFkxKSuAT+oWbTafrE1S1OMyQfaYQTN8Pr
	3HYERGWY0OQ74ad+3TIQzZLsQ+qtdU0sA/V653W4D4iO5ClvJlyydyy/Wi3yrNUF
	zuKRdw8gwNtlkXqKbeByh7BvJUwbWsQI9hKsgGX6ouwayPHd1zFi8CfsT9P/jVNk
	GLFB6DW4K3F5ngIZBO7oA==
X-ME-Sender: <xms:1GAhap_DlQsrmosTqSnb_huvnSxo2QxUITKKKdASPYe_GJd3p2zXjw>
    <xme:1GAhako5uVvB8o8fy5QW4UODsrqhDKv2A1dSI8O_4Ms2OPcbkyn0DxmnRMMkvnQ-y
    SPYY4P6Rjbo-IS3lkaGASnFV-wq0MI4EZj9lcBkl-Zc9dlntocw>
X-ME-Received: <xmr:1GAhaspLsO_Lg0QNgNjmGT3xa6FTEkjdpUotRL14_mUkHFgYoXLeOe-3_Kivf_-Zs8x4iBF4rdQf6X3x6Xk4WV0akwOD87ekvE9H03zjG88>
X-ME-Proxy-Cause: dmFkZTEgCyScvAHJZtwScmArpd3MPVD65pRFEMle7OxDyvGrBgzCBJpJZt/i/e/55qfMB2
    OZ+A4mOijyyVR7BQZ8gApb6Lys3WwA/DRBZO1Z6gq18/NjHv9k/YmqxGulaGbdjpGbGIe8
    TR7oy8jORNRJjZkYPAiPkwIOcJg76HwsAVLzInKh/aA4zWo5I7a3yFoBSrwplR1bXvqyzb
    7cwWjx66LW0j/HaZcKLdC3JWI1rUB6+uoj5Ia8HwsvfkXaZepnJEy9rr0yADWxKwm6t/hJ
    h4TWvBlU4kw/rB+rZbM4p/EdiFJ50OcReCBplYqL1Hq7W/DA0KsY8Jaj3WslUYFsjaCmCn
    UJalElQ97S0rVB0PB5WfxU4+JbjLmaBphel8z56CUCwW0k7XCfYKZpdVDzWGj+wePuGRS6
    MAyZ0GdUHTn5MH1kCBlcEktdFOsum9cXTPX+8WHX1kXtIce3ePBN5liH3zKT1t1V1f6Tir
    +euCCdAlpDDm7HO976GETE5bowRktsJP/91hnsO3ei4uKkoXCopwbI+t3aBfnbUV+kWVuG
    0xVEiqnEivVtNttIyWzcllqm/vROpI+9zpi3geznOhFZMHxa3ye9Uu+4sUIoJ3nJLZIVBa
    eWHv90pHXpcUlpn70h+IGT1J1xG2eE5b8qQ7Sn+2Ck0pnbNm2TVQL2Cu+yuQ
X-ME-Proxy: <xmx:1GAhailC1eSlEB9tdGV_BPRZfHWnVEPw-eWINUHEvhCFJIgf4z7jvQ>
    <xmx:1GAhauH2LjW50oLhJUIlZ8rrKF4h06s1ycZ-6OeiW3NH9aRsIqpz2g>
    <xmx:1GAharow5E0DZaJJzOAHFeNF4ObNDexd-SKD5SyEx_nWkZUl70QZ7g>
    <xmx:1GAhaq7kZnS4FHZEpPHR4xbxB9gXztklru6ZKKaTngv9OpkaK1BM8Q>
    <xmx:1GAhatttMoHOQz0WoFVmmCERmvvr_HmAy6REt2P7U8uC0CCiMq3oJZUG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:26:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1245f9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:26:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:40 +0200
Subject: [PATCH 13/16] odb/source-packed: wire up `freshen_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-13-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Move `packfile_store_freshen_object()` and from "packfile.c" into
"odb/source-packed.c" and wire it up as the `freshen_object()` callback
of the "packed" source.

Note that this removes the last external caller of `find_pack_entry()`
from "packfile.c", which means that we can now make this function
static.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 26 +++++++++++++++++++++++---
 odb/source-packed.h |  6 ------
 packfile.c          | 16 ----------------
 packfile.h          |  3 ---
 5 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 8ad782dc7b..fa2e18e71b 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -152,7 +152,7 @@ static int odb_source_files_freshen_object(struct odb_source *source,
 					   const struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	if (packfile_store_freshen_object(files->packed, oid) ||
+	if (odb_source_freshen_object(&files->packed->base, oid) ||
 	    odb_source_freshen_object(&files->loose->base, oid))
 		return 1;
 	return 0;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index b801b62023..e40b52e445 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -9,9 +9,9 @@
 #include "odb/streaming.h"
 #include "packfile.h"
 
-int find_pack_entry(struct odb_source_packed *store,
-		    const struct object_id *oid,
-		    struct pack_entry *e)
+static int find_pack_entry(struct odb_source_packed *store,
+			   const struct object_id *oid,
+			   struct pack_entry *e)
 {
 	struct packfile_list_entry *l;
 
@@ -482,6 +482,25 @@ static int odb_source_packed_find_abbrev_len(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_packed_freshen_object(struct odb_source *source,
+					    const struct object_id *oid)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct pack_entry e;
+
+	if (!find_pack_entry(packed, oid, &e))
+		return 0;
+	if (e.p->is_cruft)
+		return 0;
+	if (e.p->freshened)
+		return 1;
+	if (utime(e.p->pack_name, NULL))
+		return 0;
+	e.p->freshened = 1;
+
+	return 1;
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -695,6 +714,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.for_each_object = odb_source_packed_for_each_object;
 	packed->base.count_objects = odb_source_packed_count_objects;
 	packed->base.find_abbrev_len = odb_source_packed_find_abbrev_len;
+	packed->base.freshen_object = odb_source_packed_freshen_object;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/odb/source-packed.h b/odb/source-packed.h
index aa2e80281b..6645f4f943 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -98,10 +98,4 @@ static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_so
  */
 void odb_source_packed_prepare(struct odb_source_packed *source);
 
-struct pack_entry;
-
-int find_pack_entry(struct odb_source_packed *store,
-		    const struct object_id *oid,
-		    struct pack_entry *e);
-
 #endif
diff --git a/packfile.c b/packfile.c
index 69f6354ed0..d7de0412ff 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1975,22 +1975,6 @@ int packfile_fill_entry(struct packed_git *p,
 	return 1;
 }
 
-int packfile_store_freshen_object(struct odb_source_packed *store,
-				  const struct object_id *oid)
-{
-	struct pack_entry e;
-	if (!find_pack_entry(store, oid, &e))
-		return 0;
-	if (e.p->is_cruft)
-		return 0;
-	if (e.p->freshened)
-		return 1;
-	if (utime(e.p->pack_name, NULL))
-		return 0;
-	e.p->freshened = 1;
-	return 1;
-}
-
 static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
 					     unsigned flags)
 {
diff --git a/packfile.h b/packfile.h
index 8d23bec644..ed49ab7f21 100644
--- a/packfile.h
+++ b/packfile.h
@@ -144,9 +144,6 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
 struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 					    const char *idx_path, int local);
 
-int packfile_store_freshen_object(struct odb_source_packed *store,
-				  const struct object_id *oid);
-
 enum kept_pack_type {
 	KEPT_PACK_ON_DISK = (1 << 0),
 	KEPT_PACK_IN_CORE = (1 << 1),

-- 
2.54.0.1064.gd145956f57.dirty

