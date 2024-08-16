Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4427DA89
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793775; cv=none; b=Ddv9rAaxtxUMos3f9T73drWcidru2Ru37nMpBhHZbVOtcEwhnsisvb1Hkl2nrIudOpnG7XfelV5inQTpq2wDKMkKrSLQyvq3m5AdAioSbITxuIfftDWaMb3jxQhq/sy1ZwFmZb+Lw3sW/yLE7QcN53E2A0Dojm5GnTT4GleDSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793775; c=relaxed/simple;
	bh=mgBfpGYWtwrQbOJXcNh28IOdQwK/z4IWl+MvZKGObmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwY46VdTrB4miJM81OLkbblCN4qhLFh4P4Fep6gHVl9Y4Asuz578T/CYzS9O4rFif0VZ+5Q/+/Klaln7AbE8B+wxtrik7duLvjrtzTisJoscM96LP6EmhNf+Hao+f++qP1jLEsOnPQvLONpkHUhiXhdfqvO01Im92WqAECOVAc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oiQlac5I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZbviBoVP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oiQlac5I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZbviBoVP"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 30B321151B73;
	Fri, 16 Aug 2024 03:04:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 16 Aug 2024 03:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723791894; x=1723878294; bh=Az857i2Hlv
	3JlCrtn4Zxo7Zc0/kCKBtkkkVMWTVeLKc=; b=oiQlac5INpfrKx+LLYbPq2KhcR
	ftkvQqVG1ZLHZqVpm2e/cftDDhON8gaGEYYg/kfaGv+qNxCf2brs7apaEWnPgBlB
	rayMMyLzEtljjXt+oNgWCWi5feECySvxuK9o+NgkQ3yni1iFkKvDEwMg6Ukx5JsS
	ekQBxKEv8yQ7st2dyRq+KO1HNbv4c6CNF0Zmmt9vIjrQqixUYOt8RkS2s3BG29mw
	CzmD5LAnPFsB/MZaIpHlHxFQBelNumrzb8D3rbszfiv7s8rRp3bMybDCm/IurBRZ
	lyeG/yRkAHi+PjrG66La4WcvD2GcoJ32znjMUHDM7jPcXdtdRs/wdqLn1JcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723791894; x=1723878294; bh=Az857i2Hlv3JlCrtn4Zxo7Zc0/kC
	KBtkkkVMWTVeLKc=; b=ZbviBoVP8eZpqykfUQcic1ZON7n3t+iycjrvLokhZ9D8
	lE+xRR66sHqzcEGdoQb3Ls9RNWtgA37jEAbYGYy3ABlXvBy8XkGfccSE6DRRx4tx
	HT41ntPKMOYOF95SpM1XGAQuqhDNxTHhf5UhnOgzYq/r8Tt6Ocu79N1jFED3kRUb
	IGzjHZ/8E5dLu0pxIA4pkq0sSuLIebvTLU4DpAIxH2gq8vi9rTPLXBJKrFu2agVa
	3EHbBPNFbIs/htbPri2UUCNjYoiqSBC1N1+/KXknJZrOoKaSKLv4cI0iA6peVjSO
	Yxyi7CLW6r/oFipqQulGU2SFEbji+3RMrGhyMfGh/g==
X-ME-Sender: <xms:Fvq-Zp7Rfso5PfN3YPBOXe003PQWslHK8WX88eYxoJmdnj4LRf0R3w>
    <xme:Fvq-Zm5Q8bEMG-DsYWnAZqhFT1i3gzv6-Zel0rY_KRnmFUp4pXF-S4CWKwkL65S64
    D-AUcfkgGs1L5blSQ>
X-ME-Received: <xmr:Fvq-ZgdryhKYtX09Sf3njb2hNdvw1FNUqn25PnDsyYBS8ofu7iXCPOtTggvRxTA8O6t4lQaRleGQo-A1b_h_ehAlHT4M6vdPf0lZ_b3vyLlFSxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghp
    thhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhm
    rdhorhhgrdhukhdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthht
    ohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:Fvq-ZiJIr93VJ1t9KrLVgXSceGinS2VoiFDd8-t3yypt9ufn9uMFdg>
    <xmx:Fvq-ZtIGDBbH0wbR4rKLeJmVbkBq8awlGzfS2Pk_-3LQleQlXt0fLw>
    <xmx:Fvq-Zrwvvhegf5HxFFMABkzuPJVwA5CDq-VIvF1FjZvX0SVQJle33A>
    <xmx:Fvq-ZpLMynbDXxlmKDUD_Iznt5Kqf1f7FbVBKS268vzzD4oSLDtKFQ>
    <xmx:Fvq-Zk8jFrFEftj8IZHJ_OGxtt8yYs3mGMawTISBGACD1Si5k37f8Ffj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 03:04:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 242d61ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 07:04:29 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:04:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v5 5/9] Makefile: make hdr-check depend on generated headers
Message-ID: <06364b2b72202868c8fec804fd91264316e1595e.1723791831.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723791831.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723791831.git.ps@pks.im>

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
index 0736d3c88e..5384bf8104 100644
--- a/Makefile
+++ b/Makefile
@@ -3283,7 +3283,7 @@ HCC = $(HCO:hco=hcc)
 	@echo '#include "git-compat-util.h"' >$@
 	@echo '#include "$<"' >>$@
 
-$(HCO): %.hco: %.hcc FORCE
+$(HCO): %.hco: %.hcc $(GENERATED_H) FORCE
 	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
 
 .PHONY: hdr-check $(HCO)
-- 
2.46.0.46.g406f326d27.dirty

