Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6E1DC184
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459432; cv=none; b=mB0J4hgMVOSlVHsMUdcMiCPaxs5hLVKAml0WqvOI306nAl7BHD8TIWB0hlXXjoN2HxJRaBkWY+i3psDU/At2wDoe65qqMu5I1pE6GPc4AZ90wRTcv2tMYntFUQST1oXqiRRflcl1ubj5fIQSVEbeg2fNmGiZquSjrW1K5PLgxDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459432; c=relaxed/simple;
	bh=GId2DRvSy2UpTTDm2JrSEIahwLADUjCUOeElt3d/+RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6xRrGy0KB4kXRPoYDZ73lVwcdOd6ZTQ/jS99e5c++tWi/MaVlClmFXSxtyzaKBMLi2YX95fyHuo5s8CNBm1qeMcURuXdBCKIVtdJSgKwCUf1fEJALhz4RbmG4Ewb125gbl/Q8FZPxg280wi20dKJiPYM6vpBO4g4K7bgNuePPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RDhcU/AE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lTalcxjE; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RDhcU/AE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lTalcxjE"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 00C841380262;
	Wed,  4 Sep 2024 10:17:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 04 Sep 2024 10:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459429; x=1725545829; bh=TlRGhMjL8G
	Kt0MeuQPZKuIUcKjkxJTtM7No+MIgUooU=; b=RDhcU/AEyhGaU5x7K2o4RR66f3
	0sdOYVcd7vheweqzI/n01btIV7kGP2Oe+hypZWbHJQ0PS5uzotMU5SVaFUpf4GD/
	N4+/J6htCfxNndWBnJmV2ehNfaeZ2ehyPF27j90C4SrTGraBXJ0c9yyCjxbItkH9
	pRQrA2tKERxoPmxwRUNTXJK3MahsVypNl6zknaEVlxpAuq6Wyi0sYs2bme1dQads
	g7hB2z8fFW8GUKgEsYsKTDyYL4cH/oAeZwL6ury7ODcn0b8UeTUfgkDHlXfvPiGV
	4y6cIbjQ2npex9ptqzDO35HLwBtFr7qv0HzJVvVUDhi2CrGCEcVTa581gqfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459429; x=1725545829; bh=TlRGhMjL8GKt0MeuQPZKuIUcKjkx
	JTtM7No+MIgUooU=; b=lTalcxjEr8gQ5TrdNoWMhnIWztsYgL/EuRyavn5nBDog
	HTMZhei1Ggnr8/m82WQ6PrJivfrNOfsNDFDCJ21VnfG+9poXlD0mX2NNg7ZIKkn5
	li0zHxfXD5glupCYSPsRciw74hEZS8cGmfjzv0Y8CJKfDtUEwOrN62yAOQZSml3z
	VAVu6QUh6JQsGgY70IYmPlSeOIdt+ZVAG3c4JQRJ+X8hX58MBFtRpj1nRCxQHFH2
	T5A91pDOhzbJxSchrD39AKvOC0re2eBu8XQrEYZVDGN1v2vl8SDG1RD7011pnPFa
	+dVKVvNetTNWiK74lKSqUO4WwY44nZujysS7bFhzJg==
X-ME-Sender: <xms:5WvYZpRgTeBCYZLmKRutiNdWUu-KMy1qbEIXUcd5mwiz6wBn2sZI4Q>
    <xme:5WvYZiwzHa7zq5qGn2EPUu_PVWjMRQdqef0HOjunJ28Yhb4hF_TJop1T1AFLTe0ZB
    GXYgr4KZASyHPge3w>
X-ME-Received: <xmr:5WvYZu2pWKplp75W9j5dIqBUfBieXzzYCAoXgc46EYGzRhW-y0Bz77Kiqwz8P0sVYt8PWMsvL9h_GWagohnjLs3H-lqtTm1a838rCfMuPWbb2Us>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
    dprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhhssg
    gvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:5WvYZhC0yqFhWcshdoEmqbyY6wFg1kmsm5eq_WafdytR089N2DzgHA>
    <xmx:5WvYZijPGBy0VxCQDDbvVkKGeM2cvUDG6O4WUbUcnhWCnu4XORjn7Q>
    <xmx:5WvYZlrAdGp8Kv1Gdb-CmYwmJNyWS3XPekRnwCJKOHzuJYTQCxXfgA>
    <xmx:5WvYZthTHAonlPWZ6d5hfAtZwIPxm6mxnqEFZb8nIAPGiMJtjSYUoQ>
    <xmx:5WvYZtP4NF61hgmpDQIvblBlGa3kiNJPWuVzvkcyA73LTUUMUz2v5R6I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:17:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f3f4fd80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:16:59 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:17:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 08/14] Makefile: make hdr-check depend on generated headers
Message-ID: <3d3fe443b9a3f368287efa709cd744583da358e1.1725459142.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725459142.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725459142.git.ps@pks.im>

The "hdr-check" Makefile target compiles each of our headers as a
standalone code unit to ensure that they are not missing any type
declarations and can be included standalone.

With the next commit we will wire up the clar unit testing framework,
which will have the effect that some headers start depending on
generated ones. While we could declare that dependency explicitly, it
does not really feel very maintainable in the future.

Instead, we do the same as in the preceding commit and have the objects
depend on all of our generated headers. While again overly broad, it is
easy to maintain and generating headers is not an expensive thing to do
anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index efd305ab358..8c4487dd0c6 100644
--- a/Makefile
+++ b/Makefile
@@ -3284,7 +3284,7 @@ HCC = $(HCO:hco=hcc)
 	@echo '#include "git-compat-util.h"' >$@
 	@echo '#include "$<"' >>$@
 
-$(HCO): %.hco: %.hcc FORCE
+$(HCO): %.hco: %.hcc $(GENERATED_H) FORCE
 	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
 
 .PHONY: hdr-check $(HCO)
-- 
2.46.0.519.g2e7b89e038.dirty

