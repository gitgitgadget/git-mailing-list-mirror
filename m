Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272C2F60CF
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926519; cv=none; b=c1OR0cQvpJSlEBx6oFjlOKcQU7tUs4RYTHUktw9cRyzNxoVeKVX4EXx4QdPYwpgZtlB3uwbfkxVzkN+SyPuRi4zJFEmb6ZDMwy7/NvlEiOurXsFLQoHqZbjEM1q2vb03Y5iddcSdyCwnVGcU2Yo4GoUs2tk55g9BHcSNo5HKRXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926519; c=relaxed/simple;
	bh=Glcl9LUWP1z1d1quEqONW+gjHwlxzFYKESuT24FviCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEo90Y/1acN4w1dOdgshlioQ59TadvU/8wAkg8PNHUf+dEPsZIPvwoVpin7qFdzNOkt+ftfKjGdvnbm1e40YmbmkEYfEZ0vQbOAmwonzh2pYGmb7TQADIJDvdAmsdDjlIZHP62EkXeEozfGBZ0biOaRv7yC1/5YY6yVqu42MfB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=flteQ6Ux; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xtjr+rm9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="flteQ6Ux";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xtjr+rm9"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 717D2EC024D;
	Mon, 15 Sep 2025 04:55:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 15 Sep 2025 04:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926516;
	 x=1758012916; bh=f0hYS1N9Gxw1ECLXPkdiMn58Z4u8M55Oblyd/wjk2YY=; b=
	flteQ6UxVrmPkmcFtmCXVmdzAoA2qzhc7NZ8b4m54EUqH0Ky+IwLzngaXbkZbTE7
	JqwHOt+tE4CV7Juhi/67SA6pWOr7WjIcZ1cH0DcXxDoFCsHUAK5IMsRffI5SaJ3a
	QeNjrZaUZD8p61amLQYRThy4r4uidVenhWuKHJDKntzeXF1ulo9uvW11ijKfZ/5y
	EoSAeQeUn1KVGhKwIRBmd2iu4LAGi7lydQ5PFjCTRRcw5ZY/yX7oHE4yW4l3SpFe
	Y+Rqw5II9CaaxnJq4c1qV9SQOxtNsMA2T1CCVHSBXuiDTMet/Jw4vQkcYpEAweax
	UXwRn4x2uVjFeC6Bs/fbRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926516; x=
	1758012916; bh=f0hYS1N9Gxw1ECLXPkdiMn58Z4u8M55Oblyd/wjk2YY=; b=X
	tjr+rm9lXBQxlrjopWKncNSrByrFuBUJhPdRtReOaKmddtwNkmn7Mv97T2gr1+7y
	JaroHNd4dmq6aRchY8DqnwnI38tompRyxLXLu/WvFWXFg2hArrUSZt19yDJCMPge
	kzYsfvRVh8DHLW4vI5XiJEyuEgBOQvXGY7p82jPKD+V6WKqgxRas1BvPfTON+qC5
	NcbQh9WVPfOjt8dLEvP1b9OKKJuJjv35gyVFTtnCU4AVpcJrl7M9mgUdM2NNwv6/
	J/Wb3OVSXBBrAZ2GBffllL3Jhr0h9fempNF00eHMb007Osp7H/U5QLlxW3Ffrqtx
	cw9DGfMydnx7DcQb37X7g==
X-ME-Sender: <xms:dNTHaG1kzzk9lSnLeN23fIJ30qoPSsCGeBDrg2BvFGa_xfuOLQBxog>
    <xme:dNTHaElDFq_4OUT-i2Gm09_oSy_ryzDxS17uQGikc2J-g8_XoIlWkITokIzcguLy7
    M6gcZC-FGOa_S3dIw>
X-ME-Received: <xmr:dNTHaFVm22ezbYv-heNBROpxX0oAsSnet4SOe7daQ-1l9xKm6B7Y-f_7eR5g6QEJrwkqp57qrBN8CQhd07TPOH6of9dPwgOyeLZt1OOVpswwlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dNTHaCutzJcCwqwGNtmAN4AHTzBZpsxlYzzBn8tcvT0rk8_WAYRn2A>
    <xmx:dNTHaAa3WncKZRzizG4-tcsxnbmtoxLaXFSXX7BDGD7M739v3l0-Hg>
    <xmx:dNTHaJWZ0JXUhcdfRq8qGagsRpqRugfwTvEZqhTSIUZRvuDRsfWYcg>
    <xmx:dNTHaNSDmvZRjxHUUaSwFSiT6FPHfOUdzO7Ls9SQ_iQVM2Ylp19xTQ>
    <xmx:dNTHaF61dhSkpkKv5-jXuoUVxM7eORCzGeNT_gK0ajBOpKUL1oH0uYIc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:55:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dcd29aea (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:55:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:33 +0200
Subject: [PATCH v5 15/15] packfile: refactor `get_packed_git_mru()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-15-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
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
index de351b757a..61bbbdfb83 100644
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
index cd5431b6aa..5a7caec292 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1048,10 +1048,10 @@ struct packed_git *packfile_store_get_all_packs(struct packfile_store *store)
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
index 1afb9cd664..e7a5792b6c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -148,6 +148,11 @@ struct packed_git *packfile_store_get_packs(struct packfile_store *store);
  */
 struct packed_git *packfile_store_get_all_packs(struct packfile_store *store);
 
+/*
+ * Get all packs in most-recently-used order.
+ */
+struct list_head *packfile_store_get_packs_mru(struct packfile_store *store);
+
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a
@@ -232,8 +237,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-struct list_head *get_packed_git_mru(struct repository *r);
-
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
  * for speed.

-- 
2.51.0.450.g87641ccf93.dirty

