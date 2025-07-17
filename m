Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9922046B3
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748987; cv=none; b=AskMpLlftqPvEeSvS1yiORxkCQfViYKSGhs9sFZA3zEL0/kQymFHc9Z8QXCNm3kWik3p3jz8vrro2FE3S9E4YKbBseV1NngKSdcxGoLdKeckbPlxcbnGlcydejY9KWNURtm/GfcLAM6lIXYCA9J5zI7BTJDHk0niA1xUcXpiRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748987; c=relaxed/simple;
	bh=fD3fZGgHHTWvZRP4ITUHlWfN+bWK3tHdd6QR6AwVqPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZOjf8D0aTaL2pIhPBrwFjTVoMh6aJsPstmvYE8pM4Gh9CIw8bWGXsV48y+XJEbCDZdkhKmKWlkLlU/EVOBH7BgVQ60bkR4eb3ckAUsJK2exzd/DrIGeOJHfTBUhZJbPkE1PCbOPFzcTBQbecSKF1RRCKgH3eGFi96I6Okkiiok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t5duBOnU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ByD0Pmee; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t5duBOnU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ByD0Pmee"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4DB187A01A3;
	Thu, 17 Jul 2025 06:43:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 17 Jul 2025 06:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752748983; x=1752835383; bh=/2gPgNO8o8
	zHZl+Ix1VKPCeoUbsq3WreOVL7CUtSZRA=; b=t5duBOnUAMJUdwBFF8Nmi8HWSw
	0cfAomyLtgkbHIA4VeqMXerBmfrmXUMnky87FYptldI0weO8qdX3lzJkxBqbzpTx
	L8tLqhKynGzexMauuQvaoSd6OkYmPPMqNp1Zz5fGncUAe989nBjG+nL9CP/CtJai
	a6bKm0uqEnWItY651B+ZQ6+9rJK0x569I8kYaOsKhKYlvM/+wjbMrt6/dmbCu9fS
	zOwbWAKLDbbVazfu7tnp4/snBYKMKkz95paTURcH5sYT6z5ht+5lD+8NJPd1pZnE
	ZN5ShPGLhz7WEy55mWnpGPiCjxW51DVEvR2d5ylxwRn462psOo6vluGhNgmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752748983; x=1752835383; bh=/2gPgNO8o8zHZl+Ix1VKPCeoUbsq3WreOVL
	7CUtSZRA=; b=ByD0Pmeew361kAArG4yK89VBbpWC5Kc5uqqhRPaDfml46JdjKE+
	FD8nITEvrl9OdYs/3i7iM6N6GEb5hhfrgafEvKYBD/1Hm0WVhwqOAIvO0l4gabZs
	TmptDlBtCZS+fMmCrJCnWanHHOwBm9KeKg2AvRmTe+HGH6SdwqwpKYqIVofWbuyI
	KMwoOe/Ay1UDSgaf3H74V8gnuPRfuCFE33KRGgY/IjxPm8xm2GHDozVHdSIQRMEe
	wz32qBrp/jR6BQ4LuRBPYnKDUrQmRg4xMDkJtXoGdTDV2cwR06veFJjfFcekOKZw
	4e4Zp8zHZ1cAiLyRxYsvbcGMNWthNtwqNQQ==
X-ME-Sender: <xms:ttN4aCFEy4bLu3DNQ__paMpaX53uEtxBmx8RcIMsIZ_hsYUzyKJWoA>
    <xme:ttN4aIg2bJgs2_HJJaZ5tS_ow-8fg-2eKBMYzGS8NEL9-YhNZaHi4WbIPEhSyUc4U
    -75CJ26a5OGgh6qiQ>
X-ME-Received: <xmr:ttN4aNBlKTWDrOcXCcQM4LLGb9hzN0ghauGi6cm1g1lU0pg6GAlV_FGIWJVgvT2bpoujctpaX1iVUAtHX68GPH_GtsFdy9qH7oHa7ykrOCvj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhsfigrlh
    gurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtgho
    mhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ttN4aCSKnJJcJ_QgY3kj578BImopMDvsXjPaVDXpr0UEn2GxMPUogw>
    <xmx:ttN4aKUJp9TBJ9ecd7iUCKU45j_some6UMEUf7oX2eNpxgiuGLfDFg>
    <xmx:ttN4aDcuAx8loEYKPBWZDnE6ezsrGIZP2ShDWsys3qsw1wkdjkKiDg>
    <xmx:ttN4aOLMIGph4a0ClHbqDif7mzJhamKUIIgD3vRIPqg5uilvOaPm6g>
    <xmx:t9N4aJ-9Oa5YUEp83V5tCiVMegecngoeJzCZSu4bsqx8WS_y8tlLwegY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 06:43:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 996458a5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 10:42:59 +0000 (UTC)
Date: Thu, 17 Jul 2025 12:42:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	git@vger.kernel.org, karthik.188@gmail.com, ben.knoble@gmail.com,
	phillip.wood@dunelm.org.uk, jltobler@gmail.com
Subject: Re: [GSoC RFC PATCH v4 0/4] repo: add new command for retrieving
 repository info
Message-ID: <aHjTrycXSUs7XQVG@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <aHYuwlWlbkc600Ps@ugly>
 <xmqqecuhiekv.fsf@gitster.g>
 <aHjPf2so4BzQkYRO@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHjPf2so4BzQkYRO@ugly>

On Thu, Jul 17, 2025 at 12:25:03PM +0200, Oswald Buddenhagen wrote:
> On Tue, Jul 15, 2025 at 09:49:52AM -0700, Junio C Hamano wrote:
> > Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
> > > the obvious followup idea would then be "meta", but that suggests
> > > that
> > > it isn't only a read-only command, which i think it is supposed to
> > > remain?
> > 
> > "git repository query"
> > "git repository stat"
> > ...?
> > 
> yes, but one could also add "git repository set" or some such. as such
> symmetry is reasonable to expect, people might be confused by its absence.
> an obviously read-only command like "query" would preclude this.

Well, right now it's exclusively read-only, true. But that doesn't mean
that there will never be a use case for adding a writing subcommand to
it.

Patrick
