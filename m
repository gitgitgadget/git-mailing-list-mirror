Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2102E8B95
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553866; cv=none; b=HZGIvGuKWjyTjrBDf0iYQMx126KglvV4grGQDy9Fj8ST6H3aeumGLSexHzslEnWAru2lPaG8YRpZKTD2wLxg9olxH+G9cT82U4gfK7uMwNo6zLlkiZlazHIvtYuQ9aLSqWVXmANa0QrRT8rg4U4xlu8TvDcog/32xV5VQIqDakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553866; c=relaxed/simple;
	bh=q2n0xzyeI+GGqWNeOmcuDRKdj91oCerh973Xh4Z1bHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2CthJB4LRecemLaR8n2R6vJDROGwcNnE6DVF60Y1NLg/vCb/KBqB1eZEVtPSF5WQLgwRPJM0wSMimYZM5GbgBGvAt+YcxNX1hBzVWMz56jVNO/WFLFuxgXCItlseNQDsSmwMesOfWJ1T3Vn6zizDArpNzNrZtrj3ktneBlnGOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DGTEj6Ob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uFVUpLRH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DGTEj6Ob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uFVUpLRH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C6C83140023F;
	Mon, 27 Oct 2025 04:31:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Oct 2025 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761553863;
	 x=1761640263; bh=N1DYCUztwjPi5bS/xo5NMjOiioRj/U7XmdqfgKqV/lY=; b=
	DGTEj6Obaqo9Di9Sr3Wi99t7WhaH/OPreitsD6mZqEWiXKxoz0bfole+njXijh8K
	S+1md9ILHBbZhS9cgmKT1zWyYppX+GgNDy7UrtpRtLkZyDsSrcbcHwU6JCSRPmTx
	LZ6IUzNkpZbv0LRbiEtRZ4PN8Tb8FYupM49pQN/mX5kPrExUX0ebddu+sd71jg+S
	xC1WzyTysItYzDzWSkV4CrHh5U0Hd4TMK0nZcGed9SLfOLjaqLl1dUkYcKSmdPB4
	PMKKM3fpukqycLZLL9vNeSGs86b1/t2MMtcaDLEw4LfYYBit+VuKCnXNq/xJsM6x
	+nIvDhB1pvGpuPFU43UlFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761553863; x=
	1761640263; bh=N1DYCUztwjPi5bS/xo5NMjOiioRj/U7XmdqfgKqV/lY=; b=u
	FVUpLRHLVPjav/8cElwn6QecsbnEOsdVKdTEXdApEKZliSbNeTn8B8vUAmIaJq59
	Og7+aqG6pv9QAhpQYezdQjBZRvsb6yGkwZ9gL9OupT7cQA3gw7b0l1NeHmmbKLhN
	3XYzi13A7hrTYUceaY9TBryz3fF/q3zuL0qqLq643hngUORBdQGVLKqsyL2hsT0z
	IPUjh5hUHx3K3R3zEl4jxuypvhB3yZBogu+SPvHd9JfGjjYfr0izdcuA6RAx9JvZ
	QaltTt9zPW0oBOzt6v82u8rW8XmUozqezUJThLbslq4CbYQddhyX1I4/H21wYAQA
	gc6pM90bn4ihGRwDmEiuw==
X-ME-Sender: <xms:xy3_aAPWeNuIA6UC6qTTe2pKHIZFBCSTR7WA9LanR3AiTKOCzlk1XQ>
    <xme:xy3_aN23qgIiG2U5ZVNya_kVmsTwKrWBskYTPQzw6yhdHBDBhEvunRzO1bMZYD1BG
    r17NL8H57FRxH9gFKO_LZD_mV8lZ_PnDXljx48E-pOed-XMd_MrVw>
X-ME-Received: <xmr:xy3_aPlpr0yeep-c4ri-64XN6pav-YXtCpYD42LUZ29A50kdh_e8ihyLZFdygRA4NygwxH1GoMpFQQ058wc_6R37pWeKb897y11CF6SRGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xy3_aEX_EmXrnf715MM60sUH9G1FXV39vMgmvHpTdkzfE69LSS0pFA>
    <xmx:xy3_aFtrIHkYEbQXTQhv3CMtduBWVknIGtYgXmqhQzNnIzDDgqyFKA>
    <xmx:xy3_aHbRIZkwsD-mudaClUdWz5P5M0ylJ-_1n8SAbEUQbdTpY33gHA>
    <xmx:xy3_aEV7l1i34k6Bz9X1RgqroE6zSiSEqsHDC6LpMCMPHqud57f6kQ>
    <xmx:xy3_aDrxrC1VOSUaZDZqYlDhi6hlhVtkzDjtxYaeomnFp93lyewwD7Fo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:31:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aff4dacb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 08:31:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 09:30:52 +0100
Subject: [PATCH v4 02/10] builtin/gc: make `too_many_loose_objects()`
 reusable without GC config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-pks-maintenance-geometric-strategy-v4-2-18049e4a0adf@pks.im>
References: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
In-Reply-To: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
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

