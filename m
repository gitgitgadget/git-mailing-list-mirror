Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D254284898
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289049; cv=none; b=CKjGZ8kYvw9c6DfL6xiVAjwI0kTat25uK87aDEDKVpV9kalJ6UXcY0BKuFIcNPa3I3PirIdLlhCIiM0XfZ3+3QtjVtM2JH/kj3XM0278hsUApX2NVGghPfKiJwP3WXw6r+cgboPy/IXQ+yI+z97+uBXL0NzbQ+5K1H0GWrTh65Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289049; c=relaxed/simple;
	bh=q2n0xzyeI+GGqWNeOmcuDRKdj91oCerh973Xh4Z1bHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qht5RNvWCXXo2X1qfBtUEpjsDOU11yNbCS78V6jJEf7Cran4hvtwzKjvn8F+Vd301ny0d3ZqgDLFo6SUnolYJs6Q42TDc0dqrPIBB1c5EwvKXjX+za5s7h227O0CmK2YcT4Wi1QEihTpybYDmlOD+Np0zfA4Tqdwbhk+HxRrLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VnyiYZdi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K/MxiNQv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VnyiYZdi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K/MxiNQv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FF521400157;
	Fri, 24 Oct 2025 02:57:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 02:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761289046;
	 x=1761375446; bh=N1DYCUztwjPi5bS/xo5NMjOiioRj/U7XmdqfgKqV/lY=; b=
	VnyiYZdieKaTexB42Tz0lxF3QzsrDAQMKx/EOTD672fnLSNnPRQ4VpuvIw1hB0cm
	iw+NmU1G0QR6s/jI/hPDI9zI8zd2OBokLvIJgcNupdYR4kha1J51Fxo0Hl85atCO
	W+A757JSqBXLms+1cVq5K2CpwRgmruq3fNNgYhfWd4xbRCTPBi+qgIZAaaQeDuo2
	3CG0Jd67utSmR7Ga8jAJkq50rsE0D2HbmVZg3980A3zLQskG/JHdB8XSRYl0Sm8L
	Xi24tUhN9QVIxYvPHDxYyUfR736eH9olFM4mdTQ+wftbTGu7XkggISM+qbisRCZg
	lcit0ifB6wZjc0IH7rWg4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761289046; x=
	1761375446; bh=N1DYCUztwjPi5bS/xo5NMjOiioRj/U7XmdqfgKqV/lY=; b=K
	/MxiNQvpTjd8Br7WFeJEW5ir+o18FPTB3z7lrUtYahRAHvboQmulgr7aQ4qmwO/E
	tUcQN7E7TMX+EJOdwsQT4/NK1xhOrsbwBlZ/NdY/DIGPVt8meXCByuozP3IVgPHE
	OxdevGVxcJjwhGRfur8NE9WRqYVwg1G0zdSY9b7r/q2mhQ0s0kwEAqAjK8wL8Q4F
	bYALOgvmjhuzAGfFujGMzicrLDIaEHEzat5I1XXdh345RDvgw1c+VEE7+4LmU4F/
	2hGNYe1M2sqJjB4fL1qEwgZsIOR8XYQ/KaVB6YHX9Qgr1Jmj+K1RQOmxxOzygs/0
	L/BKROa7OqbFCfeHxQESQ==
X-ME-Sender: <xms:ViP7aF7wnVyLFb4hp5_HHTuRxf8iZOI-DdIYQS-zJ0DVV6oMGtof7g>
    <xme:ViP7aJyyCIuutFDLxaoPDQAVhvbry49kHLdWojAwuARcVGCEnaqShs2qfEPdDvZjS
    6rsDaqYu4N0McT34492i9R77A9Rof4FzfoRq2xRJ7NnzoCTktu2_Q>
X-ME-Received: <xmr:ViP7aEzHDpYUjclUjyxFkIgpDDjBrjwyvnTsOaibW7z6g0f3mQsXHuNULbHdpWmAbnWZX2ryyJzp1HlAsOTySi8o93DBcn_shUKVqYbTEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ViP7aJxNClNFw3T7q3qLffjMcywzjdojTh9ja_21RetYLuCMs6x_0Q>
    <xmx:ViP7aGbwAqYCqvnvxJD9E1_35edXqUyRQY9GPUjfCrkD9r_xljopqw>
    <xmx:ViP7aCVZQGn5fNcGYO4TrFT7YzYZ3opf6SHNk_1In6I68y7y7OBWmw>
    <xmx:ViP7aMh60joLqlQEiZdL_9WAN1WQ54j4j_So9fNq5fHOHlG4HlqMyQ>
    <xmx:ViP7aOJfcnMnOasXpYDvaayyk5j2hb8Bn61wIMSH9UHei3PQuH4iigtp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:57:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e8c52981 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:57:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 08:57:15 +0200
Subject: [PATCH v3 02/10] builtin/gc: make `too_many_loose_objects()`
 reusable without GC config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-pks-maintenance-geometric-strategy-v3-2-9b5b3bdb4387@pks.im>
References: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
In-Reply-To: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

To decide whether or not a repository needs to be repacked we estimate
the number of loose objects. If the number exceeds a certain threshold
we perform the repack, otherwise we don't.

This is done via `too_many_loose_objects()`, which takes as parameter
the `struct gc_config`. This configuration is only used to determine the
threshold. In a subsequent commit we'll add another caller of this
function that wants to pass a different limit than the one stored in
that structure.

Refactor the function accordingly so that we only take the limit as
parameter instead of the whole structure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e9772eb3a30..026d3a1d714 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -447,7 +447,7 @@ static int rerere_gc_condition(struct gc_config *cfg UNUSED)
 	return should_gc;
 }
 
-static int too_many_loose_objects(struct gc_config *cfg)
+static int too_many_loose_objects(int limit)
 {
 	/*
 	 * Quickly check if a "gc" is needed, by estimating how
@@ -469,7 +469,7 @@ static int too_many_loose_objects(struct gc_config *cfg)
 	if (!dir)
 		return 0;
 
-	auto_threshold = DIV_ROUND_UP(cfg->gc_auto_threshold, 256);
+	auto_threshold = DIV_ROUND_UP(limit, 256);
 	while ((ent = readdir(dir)) != NULL) {
 		if (strspn(ent->d_name, "0123456789abcdef") != hexsz_loose ||
 		    ent->d_name[hexsz_loose] != '\0')
@@ -703,7 +703,7 @@ static int need_to_gc(struct gc_config *cfg, struct strvec *repack_args)
 
 		add_repack_all_option(cfg, &keep_pack, repack_args);
 		string_list_clear(&keep_pack, 0);
-	} else if (too_many_loose_objects(cfg))
+	} else if (too_many_loose_objects(cfg->gc_auto_threshold))
 		add_repack_incremental_option(repack_args);
 	else
 		return 0;
@@ -1057,7 +1057,7 @@ int cmd_gc(int argc,
 					     !opts.quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
-	if (opts.auto_flag && too_many_loose_objects(&cfg))
+	if (opts.auto_flag && too_many_loose_objects(cfg.gc_auto_threshold))
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 

-- 
2.51.1.930.gacf6e81ea2.dirty

