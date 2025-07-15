Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8E2DE701
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578994; cv=none; b=XEPm8x0huFA4mHOWsBfu/ORnex/UQoWruxI49TWFuGFtiv+Cb3JzJJq0DpsoHaN0patQHr7W6rHZKKBRCN5R/IESeezlGweARuki57CFcmwODSInHJ92kzAhgLy1pUw8XP2H1Vpvh70+zNt2rdioCjYxIZcXH7ZqUCtLb22Y9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578994; c=relaxed/simple;
	bh=t+MMzUfxlNZLZQLauq/Jlx5AhfzLWzOMPCU4rnX0NzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SIVDUBGuqL7Y703c3Eb9TfH0+eqf65zxoYhTV7Wp7L+Na5KbRoy9gEWsGc2n3uhcIgDWvBmMSXsb3GYd4a9c8JUvMSQLS1tPL/wi57SFRb3xiZAKiGpXit+MuSpj2zK52uKeJ13Dynz4G+OoDmd7rWfpF2cXmSGtJwWz3Q7gZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eUURZXEw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eBv1w3fe; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eUURZXEw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eBv1w3fe"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9EDF6EC0A47;
	Tue, 15 Jul 2025 07:29:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 15 Jul 2025 07:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752578991;
	 x=1752665391; bh=1EQPQZWE8aKQZRxRFpD46OLuR+aHtGFmQIN2+gI4oN4=; b=
	eUURZXEwOwrbWjcBvrGH4teSBbzpgAcp8JESYBBI2iluVL5PGjjv/UtQhDZeQX+g
	lWRv5RzzEKVX8mS0SHrKcSJn4I7S2fIEl2wA1mQ5rw6FGZUpXeS+u973r2TyZex7
	JnQxLabpEgou14CpyGxcE8DHmLAQgQXr2n0rjxNBwBcfy6jNYbGF0ufeMmG/hvfw
	Nv4bb6eEgorPMKo4M30BYhPaQk5HPpoceQzf6PthyCvr0oMYs96jes/hVjpIGbyf
	9b6qKykGaqboVL/nTxIlxYA+Fc6R0CMeXTNT7AFwFbREF93ocozjJa6lRm5nziyb
	jzNTuGWClHncZdONAUN8AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752578991; x=
	1752665391; bh=1EQPQZWE8aKQZRxRFpD46OLuR+aHtGFmQIN2+gI4oN4=; b=e
	Bv1w3fedAk37mOp4XaOuXc1tCf+xwGArEBzWBkWKtsIrhFUQFTf4Q5yDmr4ZfzA9
	vEPkgb3Bwfd8J/lMLQESXwRlXOXo4bCXqZRezBOB3IQlZxbm/LZrPpzRVGGR1eKV
	9V9DdE0AGmsaoSw/tCWjYeKJQRhPMv7dIQnMyQgpoxYEPNHx8BkcavOTPOBO0WGj
	Rzz/ZD4tylU5zh4d/DV755yR2DNillPWOZYSH9raOJWvKKmA69TixqM912PfVInZ
	dxLhJsp45fQK6aI4QVXGIZcf+f1EjqvL3minRr4Ix3DGqY43Al49qxzBA+HVig9u
	sQmxl5NMkCR6TKJH/n7iw==
X-ME-Sender: <xms:rzt2aMYTPpsBc9zYxBzJTHpXVtq1GD_jlOJlG9dmL5binI_8WlQ4dg>
    <xme:rzt2aB9dpDtBhpeRAiZw3mCq-uXGfiZdBcaoMvFtY7jGrevsv516bPrj7Cxh3K37z
    Oj6mgG2WE-Ntxd3EQ>
X-ME-Received: <xmr:rzt2aDiOWaQpYw_1glSQRTx6U2lEJXtyz99OnGqWZhi1W9qXSt9gSzikiOlVpDr-xRwGU5jVnnplLMYdKzfuritmBSnzd4kZFSOZoApp20FwLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:rzt2aJcTycgR1JxcDg_1KqF3_qtlBxQJWSN3226N4JQK_H3stpQAVA>
    <xmx:rzt2aCpPAXVNAdta_IfTCEpY260wyV1PYuL1k03AqotkN6SemJtjOQ>
    <xmx:rzt2aGCEUe2e4z1p26RGMTirNTI2qg5EweE6YZE3saU_m6OKeBGk2g>
    <xmx:rzt2aHaDUKymA4x1uwqYNDRR_tGgfeuwpRKL9MkEjB89U7c1cfeo4g>
    <xmx:rzt2aIe3J-D2DxvnHn_gliVPzcKFL5k0W-NwWw18P3Og-7Igd9WQPbgi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 07:29:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 91c2c052 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 11:29:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Jul 2025 13:29:23 +0200
Subject: [PATCH v2 6/7] packfile: stop using linked MIDX list in
 `get_all_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-b4-pks-midx-via-odb-alternate-v2-6-b0ca0b4b516e@pks.im>
References: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
In-Reply-To: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Refactor `get_all_packs()` so that we stop using the linked list of
multi-pack indices. Note that there is no need to explicitly prepare
alternates, and neither do we have to use `get_multi_pack_index()`,
because `prepare_packed_git()` already takes care of populating all data
structures for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 2d19c53ea96..ff33692f4b5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1086,12 +1086,13 @@ struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 
 struct packed_git *get_all_packs(struct repository *r)
 {
-	struct multi_pack_index *m;
-
 	prepare_packed_git(r);
-	for (m = r->objects->multi_pack_index; m; m = m->next) {
-		uint32_t i;
-		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++)
+
+	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
+		struct multi_pack_index *m = source->midx;
+		if (!m)
+			continue;
+		for (uint32_t i = 0; i < m->num_packs + m->num_packs_in_base; i++)
 			prepare_midx_pack(r, m, i);
 	}
 

-- 
2.50.1.404.ge9779f6434.dirty

