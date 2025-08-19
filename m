Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0B311958
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591610; cv=none; b=JRJ08UhGr3nfPjVlVl4cr51wxpkZHPwvtz7q2FcWrNodKmO5MxWEL7ojRmsm5abxtXsRN4h5OEqc06RQwM97Pu9RfY7BYVVRFVfNhOyLBTrsNlAftcd3MkyXdhP5Me3L4RzaN61VzDqYRO10fMQbXqN3S2Fq/RYwn1QrDpKpCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591610; c=relaxed/simple;
	bh=+gdapN+7A+yjEr5/FgysVVQ1JCY/RU+AtMuz0y3z5wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uAjlqeg9rRIbHZoH6J548c1vPq4+PZlhodjWPcpz4sYxGqr9nKDY/HwjksYcefmgvGo/OjHRAcLzCpvIZnPR6jjXhB91HCN/U60JuDqYiBbyMBwJS54RpuAJez+koULd2NC0H4kdVlpddbEXCOuBwel+GDkdTrfFwLj2A3TcENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UDymZGEw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLQ96OFz; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UDymZGEw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLQ96OFz"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 702C11D00266
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 19 Aug 2025 04:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591608;
	 x=1755678008; bh=aqqo6qOzQi/AZkIHhYkJL05hQxVck3usPTIwQXHPsK4=; b=
	UDymZGEwhxg3MGTpzAcWytUqVtbv6EBvrnRjvjDMALURa55Xder4axXhdFiQnqti
	5VOdsBYI6wYMpZcG23hcQEz4Yt1peJPHaE6A6NIJ88T+iEA9wfZnGKNlvAxLyAAO
	gWhmYHCzJqR7bFKK8eg9frxmr2cPRu1RSTNn8If7ZWmZRMmIT7KlKJJPG506Izlz
	eW4wVYKTc6w1kmyHUNvAYmKYLk7P1tjhLdP2klzA/LPTmL0exqNPpg0uiZwTwq5/
	WGZRAPX2DR6942Z2BDT2T0BkaYplYA17gMBAQYiL6W2q27f3HdPRU/NBYOAeywux
	4cMpYoGo/2zwn+EB9TCfEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591608; x=
	1755678008; bh=aqqo6qOzQi/AZkIHhYkJL05hQxVck3usPTIwQXHPsK4=; b=f
	LQ96OFzcLBGCes+Ja4V8pSuwLRM83tNajVCpKtQGcICT4NkTXVUHTJzNNMo15e42
	kZpEzPFtky09E7T/9+8ADvUodqfAqw7dPWA4LSX7xX2BhJ8GzVWNbT8H4ZgeHxiL
	6ZcHgJvXkm/B1W50Zw9gd80NQDwxuGK+5etXO6t91S4kOd9zaS92/rLw/angVrUj
	kcR9AXjcXE3ImOf47cnyitK5L9A7Wq4fLy2Xrv6tqdnVe/2NE0RngDSy4G0/Y/1w
	DGic/mlmRqrusdci961cPxLK0pTDwWlT6U4eh93UJMDInJAkvFQiqWzU7/+mYsCa
	Ul05s5Ru5sqvab+yF4beA==
X-ME-Sender: <xms:uDOkaH-DMRvrHFuMtKyPg1ZpenMVjdZksm9C9vY1PYt1kKeQH3B_YQ>
    <xme:uDOkaFuCb-cyfoFFfnJw4__JD7QX642NPSHaVMyxmpwMB1OUgFxKo2xTK-VQLfstr
    rNFmJr4g6TuT7F-iw>
X-ME-Received: <xmr:uDOkaObD8TdAIzH4iBAQ7KJ1UR8sPaRHtRjdejQR7im9zpvLmMHsiL6LuSFHWS0uucT7rdnmB0zpHRN2x4rg9MsHPg3Bnw4aReW_-iUfg3va>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:uDOkaFoCHrXMt48odiHwa-EHKLDUjFj3Woc2I4hlXLZr35XozMbN8Q>
    <xmx:uDOkaD_Jhgzf5S1dCMNpemlJElbQQ5Eu8k-2vlojIAcxRbTzGQ4QwA>
    <xmx:uDOkaE9TRaULaXZo2Q65-AOcoqT0GV3QTVGTjWkF8ACkrDd7KFADdw>
    <xmx:uDOkaCsSxc5vp8FOeTzNRwL9PFvc6624b5Hadcd4UAMMifED7axsWA>
    <xmx:uDOkaMlxltsi70R7UROID2L22x4xyl3WgfKm0MAe-R7h_aNcrk3mmGGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58f26cb4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:20:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:40 +0200
Subject: [PATCH 11/16] packfile: always add packfiles to MRU when adding a
 pack
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-11-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When adding a packfile to it store we add it both to the list and map of
packfiles, but we don't append it to the most-recently-used list of
packs. We do know to add the packfile to the MRU list as soon as we
access any of its objects, but in between we're being inconistent. It
doesn't help that there are some subsystems that _do_ add the packfile
to the MRU after having added it, which only adds to the confusion.

Refactor the code so that we unconditionally add packfiles to the MRU
when adding them to a packfile store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 4 +---
 packfile.c | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 95e74c79c1..3cfe7884ad 100644
--- a/midx.c
+++ b/midx.c
@@ -476,10 +476,8 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 					struct packed_git, packmap_ent);
 	if (!p) {
 		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
-		if (p) {
+		if (p)
 			packfile_store_add_pack(r->objects->packfiles, p);
-			list_add_tail(&p->mru, &r->objects->packfiles->mru);
-		}
 	}
 
 	strbuf_release(&pack_name);
diff --git a/packfile.c b/packfile.c
index 186d182c7c..8b5e6b96ce 100644
--- a/packfile.c
+++ b/packfile.c
@@ -790,6 +790,7 @@ void packfile_store_add_pack(struct packfile_store *store,
 
 	hashmap_entry_init(&pack->packmap_ent, strhash(pack->pack_name));
 	hashmap_add(&store->map, &pack->packmap_ent);
+	list_add_tail(&pack->mru, &store->mru);
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);

-- 
2.51.0.261.g7ce5a0a67e.dirty

