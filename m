Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3719E967
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761991; cv=none; b=SaocOHAKT5wQWxx8SOOtikMQHKU0Rfsn7vwD+mdebQBclXDyZkcban4C30lpyFo1ZwqukhPYO1nVQxW6KFpo7JeBst8BCt5A/8Uyr5YqqtfTob7yEcNMAtIO4+KY6zDeI7x/CiQipgfqpyCdE/wqRDlvjCXeaG4r/MCvNP87gfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761991; c=relaxed/simple;
	bh=SheCD3BkoLX/+ePbaq/1r3gAcC8uJo9h5pW3VxI9g4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=saaKaif7n6mWuhjgyGHJ1bB38b3HhVrESJfjmRX9bNAH8H/uB6YeCf4+bihvTpTzsuZ8rLlj7yWe71t60XHxOZsPMTD9IZ7BT084A+19wF8FIDC8vJaAvaOfsUkmzr1xggtfXY2Qh++wbU+UIFuDOxSZP52YM5GbuvFTDLnpBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hLIwriOI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wqw526mB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hLIwriOI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wqw526mB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1CFE814000B6;
	Thu, 21 Aug 2025 03:39:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 21 Aug 2025 03:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761989;
	 x=1755848389; bh=Kio5L+e+mpZdYjL6o99w9kP9pNvVG97c9eIqLjk+UGE=; b=
	hLIwriOIpQ/BG6OOZuaGNSLPz5LhugrBVApUKGVX7zf+ALragzSjYZCRXZ5oujyy
	NBSvUDL4s8fAyW0ReFgO3/EkKqpdoRiuGDApHTO/F92lMoUgbG6GsQD2SDTBjmU1
	42nYRo7VACo2KgfYNm/PA+FF58i3trHVs5kh5U0Z/q36fZdOuezdhgs5CRu9GYLp
	ccnbrBokyUKfJbC/AdzFKvf797bd2itJVvtYvsRmhSvuos6SrYSoYwzcmgbius/V
	BFH2lCwm0zitZYmekrfMqDpvCObsY1dfT97F0ozgJkkXdXTxnTCw6EOmO/KEY5Eu
	Ae23bxqE+sK3aiqnVua/Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761989; x=
	1755848389; bh=Kio5L+e+mpZdYjL6o99w9kP9pNvVG97c9eIqLjk+UGE=; b=W
	qw526mBDfZkpMI4HxirkepO6GPBjwgFdhjxamz91w3+pS6UpzGbEFoeB/zDezeQq
	VW0MmKS9Gn/fmUzrHnOm7j5YZmKpgpW72wAAb5sSuIr5SWQ/GTKMx3XFkskRPLxm
	f/PygL5hFuqb28lMKiTnB353U4JijS2Q4LCgH5VWfrvQSDdHpTiP6dUD8IC1O8fM
	HH9yqWS+e2SsM3HdXG/vMYpJ5aFjbp7lS7KPAq2u5XG837TYaxMCxeZz+4FdlIpA
	5wRcS71B5gYN8L2f6mbpfVPetm1hwcmsBOSLXNq01n/lXIBsbjngxJCeAomOlbT9
	1fM6VZtcU9u8GKqNi823g==
X-ME-Sender: <xms:RM2maNIXo2q3kauQ-yqijdQYwTCIVBqoGY55JqHC4r6qoLoG471ZUw>
    <xme:RM2maMbY7TS0DhkGVbGcHsmGmgFeGsTeikhbMcckYRP1ia76_V0VhypInVaEVgiW_
    vaX_Uzt7EsbCW7W9g>
X-ME-Received: <xmr:RM2maPKzWa33O-R2keam0cn96-jLFhaYiD6l8FyJixj4chRbvm-VRiJPJWUQwkgd80kkwoVwjePIA1zskARtOZ8P1a2cjxMfiN-nqfK-1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vght
X-ME-Proxy: <xmx:RM2maKCFVpARGF9ZM7o0eSnm8DmSjadK0c_1dOrSKErFDDcWVauhIQ>
    <xmx:RM2maEom9io7TDFbTFqmwAiYq3tZDGoUiNJx0fJWrGU6dwgyI4sRSQ>
    <xmx:RM2maFjTP1etbBMPwlsWlP0uwCe18EG9fBxkEb_dVOo30jp8UxMVlA>
    <xmx:RM2maBDNXAbcLh2tY3q9kDLg53RlXEiLv-HeSWqQyGnV2EAFQRc0gA>
    <xmx:Rc2maODF0h04YjdI-SCfIC1RrIArgmthm6qtkl_yLd8ojzMLrUPsj7Wh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3879d862 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:11 +0200
Subject: [PATCH v2 13/16] packfile: move `get_multi_pack_index()` into
 "midx.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-13-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
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
index f7a9967c9d..16384e0865 100644
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
index c4e5516f9e..816b762770 100644
--- a/packfile.h
+++ b/packfile.h
@@ -103,6 +103,15 @@ void packfile_store_free(struct packfile_store *store);
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
@@ -204,7 +213,6 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
-struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
 struct packed_git *get_all_packs(struct repository *r);
 
 /*

-- 
2.51.0.261.g7ce5a0a67e.dirty

