Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0431C1B1436
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641821; cv=none; b=VYOs6XCFjeKXctCOnttzvFNsS7AV4xPJc6u76lCchvX/lkm4Vl3zic4w6vkaB59Tg+Akg1jedVPoU5nidxg7A/Q8JxlrfLvuVUzMKik+fPuk6CoALZO6dgO7Vz7UHnIdNFVspt34yfET3AoCiJs0BlrTMWeWkVB1q07Jb7EJ4Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641821; c=relaxed/simple;
	bh=R1LhvsBc92jDqTQjmfEV17sA/OuO4hpCm2/Rev2zVls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogup+2cB/vES06AU5UK5MpY7KhqNkXRjLj8eXknZ9IE/8c5SMc3qKxKDUQqj2CGdYzGKfBTUs1preVLFzBQByNfWEEY1iaIl54cMncG5HTWFGSCpJERfAlR5BQ+lB5xs2bt1Dqb6G4g6ruqm0LK4fwattMpfgBhA15StGdqL9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bvjCf7b0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=azj47FJc; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bvjCf7b0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="azj47FJc"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AEE25114E981;
	Wed, 14 Aug 2024 09:23:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Aug 2024 09:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641818; x=1723728218; bh=W7bzZ0VcEu
	lRp5MWxYPzouxeLuPigOyzwWv6l/UqvKA=; b=bvjCf7b0UA31Z9rKMVU4zNSqMX
	F2CTvceG8KBHYzE2Efjs3vaiZumatR++tsqfEO/S/NRsH945Mvz7Koc/ue1mgI3f
	Q/1J+Zr5RY4P4UaTKcQz5wtOCzShKpyRIFFUlDt54Pe5m/tXifGRhgZwATO5HCRl
	qRDPxsPzn0hxf93tXMwQ44USWinwoLlsRn8d7wQxZAvL3lr53uE9dKECdr+v0kcL
	6P9lGMDKuicajlH44cFPK/U3aa8HQeVB3qMuT+ntxR67p3AZ1Kn1Esj6ntLQA3g5
	0Cl023zXilAucQ1WGlGuG/3LePxDCEVEo5I3jaurQSrzp6YLSp7o0X9EQaxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641818; x=1723728218; bh=W7bzZ0VcEulRp5MWxYPzouxeLuPi
	gOyzwWv6l/UqvKA=; b=azj47FJcKvt9YULPtsAHPJO/DFNE6l2kzF7/cbI23666
	/yFQWGxHETUBQW7GCbyQc6tcy/XM/qylygf0jJelALQqHxOcKZ+KGIINStSXsEMr
	wBxRfmbZgOjWoFq4jUDjBCEPVptNKjI/i+8wE65jHx6DYfim45fzWDixC4J+B24x
	WWm0/QsxyuA6GZJ7YxhX8dxgatC8HIk5d5TtKHjoN3naNXc4IG3NWmSyndWS8D4b
	gjPtt6+X4Gm1HmAuk0R+xWajnDdj3XpLs4cE13Gyyk5to5jj7TW/N2e3bAgjR1CS
	z2HTeGGpPSNGTooW9yBH5sIi3P8TTo9rbhCRUiCEpw==
X-ME-Sender: <xms:2q-8ZlWJ-95jQYhdRzTc53NTijzZjlgrqCQ4y8ewokiI1vRlROC4Aw>
    <xme:2q-8ZlnzzYZb-ZkTdzcUSYWYjIoaEc3tiNNuWr5auilhnAdRl7J0ikbgBxYqYLyZn
    Pq14aDE9aMPtusihg>
X-ME-Received: <xmr:2q-8ZhbrvulMKA3qaKsL53zXK1xupPNmFid5p2b79w2EMBX7AIh3omRdMHcOM-Dl81unnBYaY-ajxV2s5IWPIy6MNo0q3MRTH7u4umUtecr8xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2q-8ZoVIqx6yl8uq0LR810Q1c0TAoYcycsdgsOQCSzgeqcOS_VUG7g>
    <xmx:2q-8Zvki9V5LfgR8lqsszJkKfd_msv7IerwAg1PsBEG4cX00VvmfKQ>
    <xmx:2q-8Zlc2PljrurIUSs1yz6rbRiDPieUQimLWNo3mpw7ang959MTIeQ>
    <xmx:2q-8ZpHeIHTdV7o7wVmn5SPLmG5_YgarsyVSdgSrl7ltr5qzpEyaMA>
    <xmx:2q-8Zkw2GvAvAo5N7qeL_ifsIxIhzffCEdUZLSIso2y3QlyVXtHjT4GB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:23:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 39b58157 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:23:18 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:23:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 14/15] t/helper: refactor to not use `struct
 reftable_table`
Message-ID: <5390be75c37cd9fac964d1ba2160110ef5ba9dde.1723640107.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723640107.git.ps@pks.im>

The `struct reftable_table` interface in our "reftable" test helper gets
used such that we can easily print either a single table, or a merged
stack. This generic interface is about to go away.

Prepare the code for this change by using merged tables instead. When
printing the stack we've already got one. When using a single table, we
can create a merged table from it to adapt.

This removes the last user of the generic interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-reftable.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 234fb80010..c1942156b5 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -3,7 +3,6 @@
 #include "hex.h"
 #include "reftable/system.h"
 #include "reftable/reftable-error.h"
-#include "reftable/reftable-generic.h"
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-reader.h"
 #include "reftable/reftable-stack.h"
@@ -33,7 +32,7 @@ static void print_help(void)
 	       "\n");
 }
 
-static int dump_table(struct reftable_table *tab)
+static int dump_table(struct reftable_merged_table *mt)
 {
 	struct reftable_iterator it = { NULL };
 	struct reftable_ref_record ref = { NULL };
@@ -41,13 +40,12 @@ static int dump_table(struct reftable_table *tab)
 	const struct git_hash_algo *algop;
 	int err;
 
-	reftable_table_init_ref_iter(tab, &it);
-
+	reftable_merged_table_init_ref_iterator(mt, &it);
 	err = reftable_iterator_seek_ref(&it, "");
 	if (err < 0)
 		return err;
 
-	algop = &hash_algos[hash_algo_by_id(reftable_table_hash_id(tab))];
+	algop = &hash_algos[hash_algo_by_id(reftable_merged_table_hash_id(mt))];
 
 	while (1) {
 		err = reftable_iterator_next_ref(&it, &ref);
@@ -77,8 +75,7 @@ static int dump_table(struct reftable_table *tab)
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
 
-	reftable_table_init_log_iter(tab, &it);
-
+	reftable_merged_table_init_log_iterator(mt, &it);
 	err = reftable_iterator_seek_log(&it, "");
 	if (err < 0)
 		return err;
@@ -118,15 +115,13 @@ static int dump_stack(const char *stackdir, uint32_t hash_id)
 	struct reftable_stack *stack = NULL;
 	struct reftable_write_options opts = { .hash_id = hash_id };
 	struct reftable_merged_table *merged = NULL;
-	struct reftable_table table = { NULL };
 
 	int err = reftable_new_stack(&stack, stackdir, &opts);
 	if (err < 0)
 		goto done;
 
 	merged = reftable_stack_merged_table(stack);
-	reftable_table_from_merged_table(&table, merged);
-	err = dump_table(&table);
+	err = dump_table(merged);
 done:
 	if (stack)
 		reftable_stack_destroy(stack);
@@ -135,10 +130,12 @@ static int dump_stack(const char *stackdir, uint32_t hash_id)
 
 static int dump_reftable(const char *tablename)
 {
-	struct reftable_block_source src = { NULL };
-	int err = reftable_block_source_from_file(&src, tablename);
+	struct reftable_block_source src = { 0 };
+	struct reftable_merged_table *mt = NULL;
 	struct reftable_reader *r = NULL;
-	struct reftable_table tab = { NULL };
+	int err;
+
+	err = reftable_block_source_from_file(&src, tablename);
 	if (err < 0)
 		goto done;
 
@@ -146,9 +143,15 @@ static int dump_reftable(const char *tablename)
 	if (err < 0)
 		goto done;
 
-	reftable_table_from_reader(&tab, r);
-	err = dump_table(&tab);
+	err = reftable_merged_table_new(&mt, &r, 1,
+					reftable_reader_hash_id(r));
+	if (err < 0)
+		goto done;
+
+	err = dump_table(mt);
+
 done:
+	reftable_merged_table_free(mt);
 	reftable_reader_free(r);
 	return err;
 }
-- 
2.46.0.46.g406f326d27.dirty

