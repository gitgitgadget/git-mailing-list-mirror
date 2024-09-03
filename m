Received: from pfhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6A81A4E9D
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354902; cv=none; b=cIQ7MWTuRe9PYADbjSRvAO0QwDwTEhkijCVuGUVbb9k9hvEwrua6k7ciz3JJhDLUtuhHVML9veEWZPeaWsdzWcpQT6xkOypbN8wtLNJdiTcOdb5yx8ktmlkftozsmUbnHEgjBgSBqjeFVaQNaY877YKFanXsww8/zqxKjYPjkRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354902; c=relaxed/simple;
	bh=zVqsPlib8PMvr6ODTBec02rNDMQoOxe2VgGGMCYr7Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObUY44RJYGWYNYSXK8b7lcZwJ17NB1UCihm0JaEdPsS5JwKB8Ueb0w/bQ9/CjENtJlEQM9VJoH6IAUBZDLscI6lt9drTUKwo9C+rNHFrjaTpUOMebi8WwbmxZmL95yQh9GdzsrO/RhdlYEdPjX/1MlMAryP5HjdEpm9cip/NBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hKiFtQuJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XH1d2UbR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hKiFtQuJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XH1d2UbR"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45F4411402E4;
	Tue,  3 Sep 2024 05:15:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Sep 2024 05:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354900; x=1725441300; bh=Kpi7ujAAof
	vmC0k8soQrOCXibyRPAb5PmzEemCzlapw=; b=hKiFtQuJsULw5xGrh6b2mvwDOz
	ztYMJNn7OoMza8l2TNyXZx5JpjEUVOYA3MP+PF54XqZRc0V6ax/8D5HpyqC1l3So
	rBwat12ec8b1i6zS6AebEchfxCE+E61599wd4BQ2E1AyX5AyZHNWrTzAIdaDACyR
	fHP6ZgLA9VWyVS9JnKmSVrNLnvpF5Gbs3wz5JBg+kITwQEMSR2f1eGIE1joQVv9A
	mypp7lXuju+m26k5p3qOdJR9tLpv9aGaR4g0JH96vLwAjcu9+kaaMmTR8RG8VGpb
	55+B4p45uJ/aMApniObgFb4ktAxx9KhnAZlBmEObrTB/CWpU7IYJpwxr9awg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354900; x=1725441300; bh=Kpi7ujAAofvmC0k8soQrOCXibyRP
	Ab5PmzEemCzlapw=; b=XH1d2UbRG+OMNPLutF/Tx8Wfj2R1nFEaf12OelbnPEqN
	mvuVwkWirLa26fFoyBHvNi5DNdJ/k8qdaT0tdaoImAPeeAWRPbWwCFvaODrPPSt9
	2vgUXcpk3AHRgQxuzio0Lu1es2ZCbGnspi7So3mBXZX/Ip0ztdWGUz+/dPRKLseU
	6G5/O7gaECJ6Awm5dfoime3vwwnjp5xjD2ZfxYoJR1u1sy8kUXXO4hvZzLBl+j0Y
	tfoZ8geXkOSIAhzQjv/XRNRLLotD6GHAFeTCU6kMbW4TBdAPm71oDwi9b2DRls8E
	7hQSKUgjXvH9buVNjg3Y77WN8w9chB2ENvFbzrGAAA==
X-ME-Sender: <xms:lNPWZqYG_jjB7lMNk91MxxI0xWgPtIRncwMmfcn9u_x1gMzzonQgeQ>
    <xme:lNPWZtYUINtaVnCVqnnAPKD_FKrHwBAdKCdrZfmsyuOEBJmq3ywUDV9oA5-bWJlw1
    AVcBnfMoJGaeft_yA>
X-ME-Received: <xmr:lNPWZk97CeAdTxyadaB5_wbytEYnSwtxgZK0roN1h-JYB9172lVa8KA3GpVMfc-EKKAnAr-ohYvx4jL1oEhzUjd7ObWWNS7OxciWWv2MnP4WWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvggufi
    grrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhouges
    ughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
    pdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpd
    hrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:lNPWZsrmiVyJ3EkG6AiMXyp4BqNWG7__8gs5MtDPpSOAen9FnH0x1w>
    <xmx:lNPWZlqEjHY-qoExqi9QH-wocoKOE5BQCWzVxwuW1pu-Milrc6G-7g>
    <xmx:lNPWZqTSm0id4vWprVaLYlZiO9FyPfZOFGfr3-TWg9SxHpDAuRwwdQ>
    <xmx:lNPWZlqZZcNO4M2HItiSQ99gOShd9hK5ZItrUs2cLd7DSVB8ethxfA>
    <xmx:lNPWZg1ObgNEqcymYgo3WCgBYdvvml_9HeGbbwsHjlG06k0nocshqCAe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:14:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9271de2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:14:51 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:14:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 08/14] Makefile: make hdr-check depend on generated headers
Message-ID: <3d3fe443b9a3f368287efa709cd744583da358e1.1725349234.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725349234.git.ps@pks.im>

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
2.46.0.421.g159f2d50e7.dirty

