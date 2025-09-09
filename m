Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382E3203B2
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415836; cv=none; b=O9CsuDlQm7vA8LzhWMfk64lML6odII9CZUgawedz+r2yVqmpnXMEm9yV5f2k098WwIlpqj5JnG1PkdPlzKlBGJ/DIpcEelYxMtPzM0VzqkLfwcNaM1mtk1VPuc9RZ8ng1Yrk94L1dXHOv/ubx8SqyceKW6N6SZ+vk+PMtA238vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415836; c=relaxed/simple;
	bh=pT+YDmMUbMxRMluxyt/VbozkxUxuEcNOwRyHQCWU0AA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mCkhvwHXjphO2jhQmntKIysXif+nM+wGzi8BP9yYRhpbXrIcjgBrXTcWE2oM8T2ZdSZR16rSNl1gFut6mndE0Qe2D958D9YtQTj8tjVMF1vTxrHQKEVTbUbQcwMe9/05dm58LF7KEJLgpJb4B0SNrLLmLZx7i+txt/9w7Ox5fOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tTluxXpr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PrRtNxbK; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tTluxXpr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PrRtNxbK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E322714001AD;
	Tue,  9 Sep 2025 07:03:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Sep 2025 07:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415833;
	 x=1757502233; bh=eeRUU8HjSeuxQ61Qza09ojszQWQiS1NG6Z68WBmaMOo=; b=
	tTluxXpre4foFVK1/bZcl3SmgHQRxGJLlz2EtBH/dgrbwtxRtqZhHFwhAcTABJL1
	WWpgcDHTuaoMGuYiSFCYTONdpey/VOv5+QGFX5ZjM669Na+CFkM5w5EkjP6AVs69
	GHh2WRWkO+vvxnJyGVcCPBhlQN/fHhoW/aftlsTYrgtm6FE2MIJEiYz0Da0llYuH
	9uUk1QemoQQ0rLD8GraVCljAS0Hy+ZLlAtzJCAmoTMWIkaFU8X9u4sOSdGrrkkui
	dx2Kr0wCqXb8TigUxNwIdNUPfCkT+8rXIVFX6776+2mNPKaeDrqwr7shX/xFvu16
	YbjQxG+ufnO3q9g1gAWkEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415833; x=
	1757502233; bh=eeRUU8HjSeuxQ61Qza09ojszQWQiS1NG6Z68WBmaMOo=; b=P
	rRtNxbKh8w3JkADSmJrpUPNt+PMlx0PoH4ZgILdewmsMgGKgAeqmUqCXUB2GlG7u
	EvO2tcSSuPGXI+d7JOK3Mf1TjXq6vy2hLZi04SULj6OXGRmFUl0lnFpbh7Vm1Dyj
	xsZnJd4wIqmnL2DjMGnI+eRE0CQjDdlVwuxRLBzGevP8RHqdE20Hw49SMUyKOWVY
	WMj63o4H+YFIxZ3VsRWIhI3Zc4ylASma8KVxr2oqQB07h1TXh85530rzoC+8PEoy
	S5dBzq6VXGQ7txiSKGW042IEEW2RAt4Bo7pdDc81By6r/bKF+2pDCcZHvDb59Th+
	Q2JolpaFhela/io/QWKUA==
X-ME-Sender: <xms:mQnAaGGitC8IzeZqv-IRTuLMm2UmefvajN4HmgDGYYMEywBmrug7LQ>
    <xme:mQnAaC3cSgxggSitdCIw7usAg9MxE3sgK5msLQOoFXHl3dvy_uJTMeIehh_VjiPuZ
    e1qSeBQPclLTGXUsw>
X-ME-Received: <xmr:mQnAaGlXzQJnesa7Pz4D7ppMX9X6-teab7fX342EPEpxZTvoX44rGuTCda4khaI9-zlIa1PJka1Z2x3l7dc-x9V_5SOhtDsZlldAC9xUMTk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepkeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:mQnAaK9K2IXVcdYHze5JVatluI8CS6qvsK6WjNaBJ58Pm2LazK-NCA>
    <xmx:mQnAaDpgge-Lp5ILPqNuXmCKhNLCLp8Vk4IRgXxrgFZAtEl6Fgcfbw>
    <xmx:mQnAaLlcO46xLrEZPTd4xG66jal_0lLrt3x9v_q5jwPvCpwYv1IZYg>
    <xmx:mQnAaCjykcQUwEAGKceT_M9TCUC2-bu4tTmQS3IxDn9zGJRRwV-dAQ>
    <xmx:mQnAaOKabAmrP06Aaze9Nxk2vpg0ZGGLghWMnTbE-t_0Ffy_sOhdfOeF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5091efd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Sep 2025 13:03:14 +0200
Subject: [PATCH v4 15/15] packfile: refactor `get_packed_git_mru()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-pks-packfiles-store-v4-15-151c4ba3619f@pks.im>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `get_packed_git_mru()` function prepares the packfile store and then
returns its packfiles in most-recently-used order. Refactor it to accept
a packfile store instead of a repository to clarify its scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 4 ++--
 packfile.c             | 6 +++---
 packfile.h             | 7 +++++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 914c6e641d..9558ab883e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1748,12 +1748,12 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		}
 	}
 
-	list_for_each(pos, get_packed_git_mru(the_repository)) {
+	list_for_each(pos, packfile_store_get_packs_mru(the_repository->objects->packfiles)) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
 		if (!exclude && want > 0)
 			list_move(&p->mru,
-				  get_packed_git_mru(the_repository));
+				  packfile_store_get_packs_mru(the_repository->objects->packfiles));
 		if (want != -1)
 			return want;
 	}
diff --git a/packfile.c b/packfile.c
index 8c45d7d116..2f7c277d4a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1042,10 +1042,10 @@ struct packed_git *packfile_store_get_packs(struct packfile_store *store)
 	return store->packs;
 }
 
-struct list_head *get_packed_git_mru(struct repository *r)
+struct list_head *packfile_store_get_packs_mru(struct packfile_store *store)
 {
-	packfile_store_prepare(r->objects->packfiles);
-	return &r->objects->packfiles->mru;
+	packfile_store_prepare(store);
+	return &store->mru;
 }
 
 /*
diff --git a/packfile.h b/packfile.h
index 86f2c07101..e21ebd75d4 100644
--- a/packfile.h
+++ b/packfile.h
@@ -142,6 +142,11 @@ void packfile_store_add_pack(struct packfile_store *store,
  */
 struct packed_git *packfile_store_get_packs(struct packfile_store *store);
 
+/*
+ * Get all packs in most-recently-used order.
+ */
+struct list_head *packfile_store_get_packs_mru(struct packfile_store *store);
+
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a
@@ -226,8 +231,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-struct list_head *get_packed_git_mru(struct repository *r);
-
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
  * for speed.

-- 
2.51.0.450.g87641ccf93.dirty

