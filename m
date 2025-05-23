Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DC6296158
	for <git@vger.kernel.org>; Fri, 23 May 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013154; cv=none; b=bmMKSrk3HJ29g2gL97GcVJFAjBSnBMxd/fVuyZnM5iCnO6lsPYW7RuWIpegxwfdUngVpsMi1KCa10X077wlYIlKVwFjkVRAZtvXeusScOcS3pd8OTuN6HaVZrSyg2HQHbibEtYvOT1Tk1Rd4FSlJAIhUT6bCQEUB4yUKltoIGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013154; c=relaxed/simple;
	bh=2F6hXs0HvDdXrdx3n47FGkUI9f7RCxNY/enFF4WeUm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IumWYZmhdxwvdZaDHTG8TntQpBMwNMCfoa/2GnHiIUDWv6VVDrO8dCTu4KqjLiVg4jodlKYE4KOhbBJGxmic1OiwVKxT9Sm/ItHwpE7UEeqq8ySdEu0iJ+VpdichgitpqvEEOqNjFASSQ+LzjLdxGOx9+7eSgjzAha6aSik89xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z6XmXowk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oBAr1YHh; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z6XmXowk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oBAr1YHh"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9ED6F138026E;
	Fri, 23 May 2025 11:12:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 23 May 2025 11:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748013150; x=1748099550; bh=Ivp6dCDOpJ
	QPxxxnedcWVuNUL+i09mRpaRFPhaP7ODk=; b=Z6XmXowkGRPkomrG7W/L65blLd
	cR8EeDGvyDORstnPW3zMNX1Wfhqrx2pyUVoCUn0XBXG0msi7/dFBDCXpPHJ8WMd8
	fV9VgRCuraIWdMZmBSGd1uA3N6IOkbNMvHUV4ZcZqTWCIWP9B6BKCnNaUqUz1jUX
	ls5kC9jTc/FLrxAd3gs9H/gnlVRbBuxsQ8K5Nr4egTc31X/SSZPryEl1VnHzNeF4
	GtUz7T2XK1oSg3AaTjIQ+fd6cdc37p73Vjs69EQ2A3GFUrF7W43lm6crwlMYPzmz
	9weupH+zRcEY8Iu5po09S1qVUEjXbbA742C/o2TLFut5BxyeVNGkROYmDXrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748013150; x=1748099550; bh=Ivp6dCDOpJQPxxxnedcWVuNUL+i09mRpaRF
	PhaP7ODk=; b=oBAr1YHhCKa3hanQqfKnUbkWo5V2agQBtxX6D0DegDbNOBnRRk3
	/NawxgklA7BSI3N+xy13WcARWKf722pifqfQ20qn/E9QljCxNy9gBpB/SRCTSetd
	rCZ3Adgr9EZKZRiNOr3es94oioUZU0Aq5uYHVv80gZxw7phvYAcDEZgRBr3DUo93
	PVPTVY44SxYuEHj9KaXk42jWH2qnauhtQC9hS4JuGqhExHXPhrXCiXXThqHQZ9Mj
	/+q54YIMd5cQvbfBc7+H5/WqLwN4vvnnaxVmOXWu/ipV3zWYmqNx3df4rANk5qap
	+WAIMJ29/MjicHq0KWaKRFTG24+dAEYkrhw==
X-ME-Sender: <xms:XpAwaITLBTMMHY2VW2_gLo7xmEXs0IHgDA-Lm-bfWB9VHleqdzy6wQ>
    <xme:XpAwaFxb9kuyd0bjvUGxHGuGFHyo3wsdZSp_75bKPe1qpn-x_AYM-MyTC8eByPPiF
    LKLNkP91xaIWLEa-Q>
X-ME-Received: <xmr:XpAwaF3mKaZI1v_GggvIfDOYnIfsTNegymMhVN8mV2E6mZP21IJ9r5YPGlTVo1_72Tnm2HPURE4BGBnHlFU0e7csdi6YQ-wC9bDU5Cx80hOq_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeludejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucgoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrug
    htuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepieeggeegvdetgeeljedu
    ieeftefhtdejhfegjeegffffieefudfggfduuedtuefhnecuffhomhgrihhnpehmrghkrd
    guvghvpdifohhrughprhgvshhsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepie
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepfhgvrhhnrghnugholhhimhgrsghushhinhgvshhssehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtth
    hopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvght
X-ME-Proxy: <xmx:XpAwaMAPbq3yeb7yyairWA3UB_4qtWa7CHEMqecUHrYbNd_IVE-O4Q>
    <xmx:XpAwaBj5Rvs8hw8nrKJ8EjpbklvNTWh3LW9Y6oNf2eZ-TKheeYMj_w>
    <xmx:XpAwaIo7CrText8BJgSzZQPgmhRLaRVVTpx2Dd5kj3YjfcEoMwmmnQ>
    <xmx:XpAwaEjnrtuk3g_18ogwIDuSPLJ0hKrNaAhTAOdNnEGfgj0_vubpIQ>
    <xmx:XpAwaF5hAJdWNSGblM1sxMLkSl3C79GarcBl_vXr30DiSC-wsZrzeXDY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 11:12:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c60335cd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 23 May 2025 15:12:27 +0000 (UTC)
Date: Fri, 23 May 2025 17:12:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Fernando Gouveia Lima <fernandolimabusiness@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	stolee@gmail.com, peff@peff.net
Subject: Re: [Newcomer PATCH] log-tree.c: Supress Wsign-compare-warning
Message-ID: <aDCQWr3MBX4L7sbA@pks.im>
References: <20250521202409.26879-1-fernandolimabusiness@gmail.com>
 <xmqqsekx8yef.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsekx8yef.fsf@gitster.g>

On Wed, May 21, 2025 at 02:08:40PM -0700, Junio C Hamano wrote:
> Fernando Gouveia Lima fernandolimabusiness@gmail.com writes:
> Quite honestly, -Wsign-compare is mostly garbage [*] and I wish we
> did not add it to the developer settings.  A more effective way to
> squelch them is not by sprinkling the casts like this, but to remove
> it from config.mak.dev ;-)
> 
> https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/

I'm still not of the opinion that it is garbage. We have tons of
locations where we mismatch integer types only because we never got a
warning from the compiler, and these have caused multiple stack
overflows in the past. The signal-to-noise ratio is high, that much is
certainly true. But if it helps us to avoid security issues in the
future I think that is acceptable.

I do agree though this not a good project for newcomers, as fixing those
bugs is quite intricate overall. So we should definitely remove this
project from the microprojects page.

And in case I'm the only one who thinks that the warning has merit I'm
also happy to be overruled and have it be removed from our developer
settings.

Patrick
