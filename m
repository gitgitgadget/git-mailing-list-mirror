Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB9311C12
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591617; cv=none; b=taBH1AT+M+vwJ/AzT8Xs1karhCJ8RoH/VLyZx2oM95Xh10FN7htXRi08KyZN6e1rSDEoc437XpxQ9yBlgtkq5+oJW3TLIFbIfDyOUAetzFB0+3OZN2RjV1hMG0B+y4UUFgeD1zGhR2cFhPCzwVspcX7jG4HMMqinLPVGfYT9FSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591617; c=relaxed/simple;
	bh=vURjA1BXq2RwuhfvJx8aYZEKc1g5rDZdxFBwG7qJKBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=na1Z8qpt6PVgpZQyHFmZ8dof1+eNJeaON9cxELYl5yKR0aCVHts4L+eiQqIM8qf7+RgSwpmoOn/47jr/OZkzHAIfU7jDkrf8RGAlLBCfd+uziSr0pcqzSyea4WyxBagldPSrZ4/VYuq6L4cIcjIb/uVEWlBnHT1GfpB4MEUbj8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IrYSlRVl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DVnWu4P9; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IrYSlRVl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DVnWu4P9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6350A1D0025D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 19 Aug 2025 04:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591615;
	 x=1755678015; bh=A6LbOdRNPN3VcSkaq8nin3BLRkKGdmTqkFEOYym+7Io=; b=
	IrYSlRVlBbrMJ8oGWOqQMg3VBWa9D8FOrYuDfZP0uQzPQg/UVKngjhve8VM56qaA
	fdIZ+nB8JVsboFw3zfG1DKhVMRCwvXTK5A0d2v9SE5XkV32pzL2EQeHMedjYkAi0
	p8sb1RpFXvxgzCXrqncKl6/EMUwuOcKunpINweMhSPOOtM2sVszUYCfJ085K5Tdp
	1ugvqV0SdOgVIz30WEB0rzWUA2+2Gp8jmz+pp4LQFwNglSrAgkGGJ1OCY5MNCfZ5
	RRmDbJRxalA2Qu5VNudEqA9buXLrAj4Owqe0fA2ubJ5KadN2CekntOPX4s1kJ7av
	qT7NiezKhzDMuzbPgmWmyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591615; x=
	1755678015; bh=A6LbOdRNPN3VcSkaq8nin3BLRkKGdmTqkFEOYym+7Io=; b=D
	VnWu4P9b2EGYVmibJn/Xys56HXBGh9N6JbGUho3wRl0G3IYcZ/3oCdw22ShPbdnG
	48JR3dnQP/RTQ8dTtSCd1Vc+1QpvRDca2pVnCgqTEtO5YWVEMWP5UvHxN07Ha2tG
	kBmq3VzcoMaegWit85hOzZ/py1ulm/zi4NWiOhK/pbzV0opy1wpijKKSFH3J2xwI
	0CUPe0sQ8a8pYJTFtbvB54k3PsBq+bWLoC6UBJrLV3QKn6BXHrZCE55qimXjKset
	J6cdAT9Xd9bEBGUOa6WXpDeXRaNu2Zrvsck6UUO9bzrumj0ul2xgKjc/iWtuSp8/
	bBzPEtAbBSgWJ+1uUZEwQ==
X-ME-Sender: <xms:vzOkaF097AWPIDCLEFEHM2Ukn_AdjKsoqGoZcSrJZ7TqryQQLfnh3g>
    <xme:vzOkaOEZlng-jVqGhKiBkCiKiR1nGgr7u3cQUxaOu_zyvE6eTFVFKO-ZYcD22K4ym
    MNqKFcnp0XnXDQ3xQ>
X-ME-Received: <xmr:vzOkaPSrCpVr2gawKDsyg5f-96Y_TmQd4M7gMJ1EKYeCAxbIahgIhx8s7_zQn-y7XT7VGlcmoYwpRBvghHi1nB-OMolDiXOirCPAwGpqGS_X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:vzOkaFBkHcq_YAPPz5yaKBkKJUmAzbOz2-j0Q-zG2pC0Zod6exPY0w>
    <xmx:vzOkaP2CDhIjlUL3s7lWshaviAAxyUVoXVFy3JVfGc9T0eBkH8RlaQ>
    <xmx:vzOkaDUdGPAMrE-bL1AylEGTd6QkCIHVIWKMsq1vVwjwg4jquxJWFA>
    <xmx:vzOkaBmt8Z_OTQKtM9jG1zUSNLD0dmIKtvOovYaaEm8TQ-soDqAl0w>
    <xmx:vzOkaD89qtIAPO-LlChT1vjTv8LR5HYvTOntpQ_FdqPqAKcdfU-QRPCD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0b2981fd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:20:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:42 +0200
Subject: [PATCH 13/16] packfile: move `get_multi_pack_index()` into
 "midx.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-13-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `get_multi_pack_index()` function is declared and implemented in the
packfile subsystem, even though it really belongs into the multi-pack
index subsystem. The reason for this is likely that it needs to call
`packfile_store_prepare()`, which is not exposed by the packfile system.
In a subsequent commit we're about to add another caller outside of the
packfile system though, so we'll have to expose the function anyway.

Do so now already and move `get_multi_pack_index()` into the MIDX
subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     |  6 ++++++
 midx.h     |  2 ++
 packfile.c |  8 +-------
 packfile.h | 10 +++++++++-
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index d30feda019..c1b2f141fa 100644
--- a/midx.c
+++ b/midx.c
@@ -95,6 +95,12 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 	return 0;
 }
 
+struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
+{
+	packfile_store_prepare(source->odb->packfiles);
+	return source->midx;
+}
+
 static struct multi_pack_index *load_multi_pack_index_one(struct repository *r,
 							  const char *object_dir,
 							  const char *midx_name,
diff --git a/midx.h b/midx.h
index 076382de8a..8d6ea28682 100644
--- a/midx.h
+++ b/midx.h
@@ -100,6 +100,8 @@ void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
 				 struct strbuf *buf, const char *object_dir,
 				 const unsigned char *hash, const char *ext);
 
+struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
+
 struct multi_pack_index *load_multi_pack_index(struct repository *r,
 					       const char *object_dir,
 					       int local);
diff --git a/packfile.c b/packfile.c
index f7916543a6..bc32c45fe6 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1004,7 +1004,7 @@ static void packfile_store_prepare_mru(struct packfile_store *store)
 		list_add_tail(&p->mru, &store->mru);
 }
 
-static void packfile_store_prepare(struct packfile_store *store)
+void packfile_store_prepare(struct packfile_store *store)
 {
 	struct odb_source *source;
 
@@ -1035,12 +1035,6 @@ struct packed_git *get_packed_git(struct repository *r)
 	return r->objects->packfiles->packs;
 }
 
-struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
-{
-	packfile_store_prepare(source->odb->packfiles);
-	return source->midx;
-}
-
 struct packed_git *get_all_packs(struct repository *r)
 {
 	packfile_store_prepare(r->objects->packfiles);
diff --git a/packfile.h b/packfile.h
index 4971f18f51..1522da96f8 100644
--- a/packfile.h
+++ b/packfile.h
@@ -104,6 +104,15 @@ void packfile_store_free(struct packfile_store *store);
  */
 void packfile_store_close(struct packfile_store *store);
 
+/*
+ * Prepare the packfile store by loading packfiles and multi-pack indices for
+ * all alternates. This becomes a no-op if the store is already prepared.
+ *
+ * It shouldn't typically be necessary to call this function directly, as
+ * functions that access the store know to prepare it.
+ */
+void packfile_store_prepare(struct packfile_store *store);
+
 /*
  * Clear the packfile caches and try to look up any new packfiles that have
  * appeared since last preparing the packfiles store.
@@ -205,7 +214,6 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
-struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
 struct packed_git *get_all_packs(struct repository *r);
 
 /*

-- 
2.51.0.261.g7ce5a0a67e.dirty

