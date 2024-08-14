Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4D1B1439
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641766; cv=none; b=NY+iBvA+rOsra09XIidATwo3QEk2P7R+tqxXLYlVwq6NZIQuySSiMWHoKWywdhBtgY4020w60nqmQHjZNlmp2NnShcpyXGe50Z/EHfwK15RLSI3DRHaq7h9b6l5gNppaPIpNVzJY336npKA9x4MXSiEnDxh4ZIbFfLRxUGqH/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641766; c=relaxed/simple;
	bh=ZiCLUi/BUqvxOdjN//zYawYCHFEi7nYpsw6HleDgafs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=area/V7oLrDK2aYYIEhd9v3wL5hY8A4XZY/u42xYR7QPytVJdtkyvCLqSQcpyqLQkE+zoNLmyMdpLtCG0rH7MTuokvdWO6Rfj5iiWnIDblL1NM398lWijcODxvGzOSnociIIsZw5M3C/a8E3rzqG4KrMhkOYrYrY1/AWCbpMoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dobpi77z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XAZgjTHi; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dobpi77z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XAZgjTHi"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2DEA1138FC13;
	Wed, 14 Aug 2024 09:22:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 09:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641764; x=1723728164; bh=M5mbTth+1a
	44lg4toqj2ICmCYVSy1NhOJWo3fQUJ4NU=; b=Dobpi77zK2LosyrVGGGu+YFkIO
	4CkqoM5fJ+w/+bxjYkSGCTmYYBlnB4itP10LEETB9ZyJblJgJy6awiviS7eTEeHn
	xFfKOYAXJeZPlBnqkoRmxcdpzFWODo0wyy6sc5qcQxgWOub2ISDzehjl6fJAdHOg
	A478pN9y3NCCOiCf0sXTZrKTNV7ct0BD23lIKPhqZLEJaqfAtHIDBUk7gUvP1pIz
	q6drH9/+Bhnsf8JB4arX/C4bcKIPMDpikAKled7g80siOavOqGQDu+BRc2KUFTw5
	UK+ctm45/tRScMcQJNLZQ+guLu7nkz20B7KbETtD+Vx5ZXmzrVp5tl3rXgfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641764; x=1723728164; bh=M5mbTth+1a44lg4toqj2ICmCYVSy
	1NhOJWo3fQUJ4NU=; b=XAZgjTHiSCqBHa5eegVyexBX4HgQcKJzT/ZOgHXFCZ19
	Xeb6xunOI+iwyd8sLBHt9dQeipyVCsDxDwqDn+UaCOD9YUV4BYDL/P/IGKr6mXN9
	kEm9kOwWaDIGv2I9OKNwzB9bjIdfGmzGtHT5u67WQ5//2v7JD1A8onG3wE3COGxO
	ErRYhFy1QtucUu35zFsb7fgRGyC3U80uMv0L3j5janzodsxDzZD8mrW9PUJ38roZ
	HTWwCbqcTQUc4p61M+sBlUSpgN45uVpGPZtUIP7JeX26vXXToabmB03zdnM0YMNh
	muJBUnm6vdloGwtAGBDdUafP8TZZogjVtIj85c0a0A==
X-ME-Sender: <xms:pK-8ZspsES-Z_FW7wGPdnaWhPfEIRTj40X_xv3diU1qTvDI7uRyqZA>
    <xme:pK-8ZirqVnC4Pqp3OX-d0GtSTEy33IMaHpVOil4N9rOq2x6YrFtpVhgDDSWQKoejP
    4eSiEIqsIxPRpd6Zw>
X-ME-Received: <xmr:pK-8ZhPIey35E9xOmSt_LtKwLSEyBRXTRSOHbY6njYczXpN8a6tboj3gJ5cZkoh1n6j6DEWDh-zAzrj-6RUsx-WOPhZf7D6aAsj6QXYeg1qCZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pK-8Zj6u3MOi-Rwm9k2mofNuKqURvvrEuuSGXaa3Gxr-l4PtFcA1Dw>
    <xmx:pK-8Zr6o7UoDs_iT26MnCzCKxebRYSyLVfzZd9v_fME71NjjfvOA0w>
    <xmx:pK-8Zjgp2kAV_A9ifSfxCAKHmX0N-vv3lGMxo0s7MRum7B0qSOOp2g>
    <xmx:pK-8Zl5uKaDswZ71HTSxwXkgWdyg8aQpsADAOA3TgQ6F-7kgi4IcvQ>
    <xmx:pK-8ZrHPsWYSNjuEfawjnfaqpc1l8WdKKAO4ASWI-JBguRNCnwfmq9Ez>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:22:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 313792f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:22:23 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:22:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 01/15] reftable/merged: expose functions to initialize
 iterators
Message-ID: <472c169b501d060a90607c6ca9552eee807cb286.1723640107.git.ps@pks.im>
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

We do not expose any functions via our public headers that would allow a
caller to initialize a reftable iterator from a merged table. Instead,
they are expected to go via the generic `reftable_table` interface,
which is somewhat roundabout.

Implement two new functions to initialize iterators for ref and log
records to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c          | 12 ++++++++++++
 reftable/reftable-merged.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/reftable/merged.c b/reftable/merged.c
index 6adce44f4b..8d78b3da71 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -254,6 +254,18 @@ void merged_table_init_iter(struct reftable_merged_table *mt,
 	iterator_from_merged_iter(it, mi);
 }
 
+void reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
+					     struct reftable_iterator *it)
+{
+	merged_table_init_iter(mt, it, BLOCK_TYPE_REF);
+}
+
+void reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
+					     struct reftable_iterator *it)
+{
+	merged_table_init_iter(mt, it, BLOCK_TYPE_LOG);
+}
+
 uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *mt)
 {
 	return mt->hash_id;
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index 14d5fc9f05..4deb0ad22e 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -36,6 +36,14 @@ int reftable_new_merged_table(struct reftable_merged_table **dest,
 			      struct reftable_table *stack, size_t n,
 			      uint32_t hash_id);
 
+/* Initialize a merged table iterator for reading refs. */
+void reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
+					     struct reftable_iterator *it);
+
+/* Initialize a merged table iterator for reading logs. */
+void reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
+					     struct reftable_iterator *it);
+
 /* returns the max update_index covered by this merged table. */
 uint64_t
 reftable_merged_table_max_update_index(struct reftable_merged_table *mt);
-- 
2.46.0.46.g406f326d27.dirty

