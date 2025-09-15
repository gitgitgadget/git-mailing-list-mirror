Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867EA2F4A14
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926509; cv=none; b=cOPlxQ7fe6Iic/ij0nCzC1eqlw/uGn8cTYHa19PB5+S0GSQ8NVldXmYRRaKT2Srk3mry7xSyJsJ93QeoFVJM3tYCUMH5kxGWlvktLhQxR5/fq0uFMm83SYF4iLoO19WSmFhkytaW91fJ+2IiScdFp4swNyXl3ZRECKWD4Sk8a28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926509; c=relaxed/simple;
	bh=K5QnJaRZI/iz5lqB8EUlIrjMMVCt2qE9OjC/yxUSbDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNonBJOZW8cr93uK3MIWIyRD1Wq3WQ9wSn2EZ+7TIKZj3bgurgJ2bvZOud/ZP+Gv9xdR9Q2B9eKt9oj0u47+/xDyRLiyU9IihD83/1sIyJrY3BCID/a8P8IzSzTDIV/6JtOlW+xEhtr4XRRijHu78h6aIgYYCAF2KvQVacYSE2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N2NF5scb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bSQ5HYxp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N2NF5scb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSQ5HYxp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADF18140002D;
	Mon, 15 Sep 2025 04:55:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 04:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926506;
	 x=1758012906; bh=3MjESCKsh2GkbiYgkjIVULMJiqMG0SVKi0KMAlsIO04=; b=
	N2NF5scbFmGXbBgS1/0bZy1G1KqWJ86Xg37PFI+jl8qBaP98Q5BMyt2avkkyL5Tg
	WooluBZkyQcQEClDZivWgoNE5DgDnyH/IkrQDOKgwfOdPl9nGxO4TQ3fWWFf2s0L
	SR5/O5hP6HdFKZN3DMkMPx8cxpmhmnV+5+0A5P1gXn6/fJfM//hwhr1yoXj3L+S/
	jfrCXvfM1m3lcdcbyctATEXnPi5fkGT8+ZsFHBGRsbsvk2ceShX4t5J9GhYJJ/4v
	22dcpLq8NbY4Rzo2pZpctukmSoIAyWt7B7m/l9bSqw26uDwIQWIlJL50xUgDqc6g
	jxtWftGCZQlaJWES6e9brQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926506; x=
	1758012906; bh=3MjESCKsh2GkbiYgkjIVULMJiqMG0SVKi0KMAlsIO04=; b=b
	SQ5HYxpm2MYAuZ4dYnVrmj607PVn738iXIs84kE5L62XE2957XKZXB3KWr+Hjc+Z
	sRi72x4xiiy++eiIWO/f041WmFIeS/B0NQl3hZXzgXIEX67D62fItqbL5Oh29Mmd
	42qQJlJGZNizIHQthJQzvBolbblW6BDIPGBiaeUeRVTe3hzGeTTH/2U36ZdksTTV
	kV7JPHJ/nxZxCbQjKTwhjh6Oqr7x7RM/pIkm2dQvDuzj+HbbT2TjB15Yolc1oSeU
	f6+WbqGxAfNQwMFuR0hBFyn6UVjARguRIYl9gqPDB0Cu0yo3PnyKhG59IdTBCeyU
	9gjqseTN8QUYJKNLHRPyQ==
X-ME-Sender: <xms:atTHaIVwtRyIqD9C1Nw_ducPQXHSqWWMOyrGxupCbftoLEUZ2wFRsg>
    <xme:atTHaIH5BvCJuT9mEdG1oJrL9ScYu7KAiqC28h46nazmfN3J62oEUnfCxDxuWnT5O
    crYR89G2uQGBHpFLw>
X-ME-Received: <xmr:atTHaC1Mr93vbk-JWwp9CE75dvhAhN7WsUG2RIu2xXlqz19tdWXdwUftJ_k9oV5aD89rrTVtNPB9EzcFc5pUAvMp0u696b0O_nrzrfJWAvCu3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:atTHaCOapVYA6ErTIy_V0BCBI15d7-yIoPjnRRhs0Sn17myk5wCKQw>
    <xmx:atTHaJ5sPiPlHYCX0uxfbQdOxBUUpI8Q6_qH203_xKwCPlzm4heGOg>
    <xmx:atTHaE17C5Os9qAo8cBXCmHUTsDdKnxv-gl7tzTWopkzmSuYkPPIhQ>
    <xmx:atTHaCzvF1VvnXWacRHwvkJ4DqphUvXL5ZZF-YE4mCS5efYnYn5Szw>
    <xmx:atTHaFYSS87-6mR9idPeU1dK7tyeosgzJBZy07Hasp8HHRYUXRjlipia>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:55:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cbe2a448 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:55:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:30 +0200
Subject: [PATCH v5 12/15] packfile: move `get_multi_pack_index()` into
 "midx.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-12-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
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
 midx.h     |  1 +
 packfile.c |  8 +-------
 packfile.h | 10 +++++++++-
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index 3faeaf2f8f..1d6269f957 100644
--- a/midx.c
+++ b/midx.c
@@ -93,6 +93,12 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 	return 0;
 }
 
+struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
+{
+	packfile_store_prepare(source->odb->packfiles);
+	return source->midx;
+}
+
 static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *source,
 							  const char *midx_name)
 {
diff --git a/midx.h b/midx.h
index e241d2d690..6e54d73503 100644
--- a/midx.h
+++ b/midx.h
@@ -94,6 +94,7 @@ void get_midx_chain_filename(struct odb_source *source, struct strbuf *out);
 void get_split_midx_filename_ext(struct odb_source *source, struct strbuf *buf,
 				 const unsigned char *hash, const char *ext);
 
+struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
 struct multi_pack_index *load_multi_pack_index(struct odb_source *source);
 int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id);
 struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
diff --git a/packfile.c b/packfile.c
index 9224ca424c..7a9193e5ef 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1003,7 +1003,7 @@ static void packfile_store_prepare_mru(struct packfile_store *store)
 		list_add_tail(&p->mru, &store->mru);
 }
 
-static void packfile_store_prepare(struct packfile_store *store)
+void packfile_store_prepare(struct packfile_store *store)
 {
 	struct odb_source *source;
 
@@ -1033,12 +1033,6 @@ struct packed_git *get_packed_git(struct repository *r)
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
index fcefcbbef6..a9e561ac39 100644
--- a/packfile.h
+++ b/packfile.h
@@ -112,6 +112,15 @@ void packfile_store_free(struct packfile_store *store);
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
@@ -213,7 +222,6 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
-struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
 struct packed_git *get_all_packs(struct repository *r);
 
 /*

-- 
2.51.0.450.g87641ccf93.dirty

