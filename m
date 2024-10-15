Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F282140E50
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990159; cv=none; b=nsAJ2eLyknQc9S33Bbnvtok2V+Vuwq6e3pDG9G23Nnq48owdYAGELsPjtiu3KJEL+1nIJ2lkxZQkScf2ujRSvUnsN0nZWB1Wi3dV4WbNbZJFj1hKMFpzoaHg9bvRE1nq6Z3c2uYkzvzuN6V2qZbrxFikcvcrzrWQWNL/nIOeKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990159; c=relaxed/simple;
	bh=fOqcoPCW2JrUNr6CuZn1qlKA8XCnHcDrhIKEqAF7Jhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=py8jbhexFxf15AkfRk/YIARSPgZjJ25x5Z4KFhus9L0ljxWM4gDd18CwyleyooST2HJYnF3W09mAl0I8RHoLqTgPi9w6j8rWpTZO6h2HOXl4FvtKuJLb098/MyvTFliMF/vaLZJqVtYTpYE3aYOWQ04bx1grv1jqIbNKRpA3fTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=izc/Dzpm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UFrJFlAm; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="izc/Dzpm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UFrJFlAm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D8D911400B8;
	Tue, 15 Oct 2024 07:02:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 07:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728990156;
	 x=1729076556; bh=furQefetPfdFO0e7FwnsolpmjOcIaBoC0X3I2EatYjA=; b=
	izc/DzpmJuulGgOqSYVWMCZAFm8Bx1Y3vOmhbebVYIlK1Xn7qAKzdq6GYYC15IDX
	PvfW4OOgkBaD3/aIINlySO2L4oLuUZELD1L1XwY+CPpRm4LleLGQRtc5UA+XTuYM
	MbBvTxHVffkR47Es4+7CeUMjoaNA3oxfFrm0ZiNzu97cHZJMCtaS9yv8+tgUJvEn
	CoNMZ38iCuj/IB1HB0+Vj0UJ0dc4uNdWP4sz20QQmnyWNyZubGJQHAN+p24bVdKe
	JV606S6c8eGUElL3xPaCKE3l4Cm3fiTbOh6T93CTfGO5U4MDjXuNiJUUY/jMFhOL
	KtWbwr+2ZAE8w25CGy8Csg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728990156; x=
	1729076556; bh=furQefetPfdFO0e7FwnsolpmjOcIaBoC0X3I2EatYjA=; b=U
	FrJFlAmRdL2dxZwRNXwi+/fL2voxpjfAQePt95gNz8Hp4eAQcVXGqw8PfBoJm/kV
	Og47pOc3yhxCTEdlAQj3JYwTpfWinleoxBGlmf0ctdearZCUDDcRHUlS4c45ggyB
	j2aKnPpnc8sjFiXUnZskEHw3akw+V0+du8WSz/ymWs09YRiA7Lk0e8Vgd0ASwxbo
	RqMrS08bdZlWGkZxbX+AFuBgdIyyO+h+4xiqTBJCxftoz2kV9ygBgTr4FRhGqX/6
	bXTBMi/9JNyrFUSphTlkJX7IOWTyg34D2osl/2VibL7Djy98dlhhl2ZU8r8v2F7Q
	nYjXRXPf3rz9ubbVJeJIg==
X-ME-Sender: <xms:y0sOZ3LlfVjcn__ZgYtc7WN6CqtmmjpLY9qkeoBzdExmjc-48Q-73g>
    <xme:y0sOZ7I5zXJ2GCE0jt-bNnAn4jI-W1W_aPx2VQ2CMxPQAtBWnyUe4sNFUKl5E0QUy
    wymzKIvHPL6EBUxcg>
X-ME-Received: <xmr:y0sOZ_vUr8bN3cS6VHOhNMfOkQq5Gfq0zPkczW8uydAIgBqT_rAsd_4M3NUMKytK0bBbh_vH4UsWwoe6QHKH1Aof0B5AFNsKc0gkeE-eK6o8-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhhfihgtkhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehluhgtrgdrmhhilhgrnhgvshhiohesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:y0sOZwadftgEYmpMqb6sHBBQGYAhakQdMKH-zONkImHxJrlxq5m0nw>
    <xmx:y0sOZ-YDyCCesDVOlwVzlix5bwkpqLfXzzUfJRA7QcYXhfCUaaG3bg>
    <xmx:y0sOZ0DpmDUzZchsHbNNT_oo3SRohttS1jNSS1LUdMXE-EXJRw8Bpw>
    <xmx:y0sOZ8ZhSC1GIb3TDmJzDL4Q63YnMUdd_Z7HLJSVPfxLk1PYd8OrDQ>
    <xmx:zEsOZ1UjnjuJNF_ytSxXrTDq1wVEYhU9-4cgQkq-WsCDQ-8cGCeS0K4E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:02:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e7aca970 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:01:17 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:02:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Luca Milanesio <luca.milanesio@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Martin Fick <mfick@nvidia.com>
Subject: Re: Should object repacking only update server-info for packs
 instead of doing it for refs?
Message-ID: <Zw5LwB2ap1QnmG6L@pks.im>
References: <LV8PR12MB9407CB282D1FD4998C659D29C2442@LV8PR12MB9407.namprd12.prod.outlook.com>
 <569E3AEA-AC68-4186-B38C-2E47DAB9890E@gmail.com>
 <Zw2MVqi0FLcMuR8Z@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw2MVqi0FLcMuR8Z@nand.local>

On Mon, Oct 14, 2024 at 05:25:42PM -0400, Taylor Blau wrote:
> On Mon, Oct 14, 2024 at 09:33:17PM +0100, Luca Milanesio wrote:
> > > It seems counterintuitive that an operation designed to repack
> > > objects would be performing maintenance of any sort on refs?
> >
> > True, it should not touch info/refs IMHO, as you’re really not
> > changing any refs.
> 
> Right. I don't think that the current behavior is a bug, but just that
> it's doing unnecessary work from within 'git repack' to update the
> info/refs file when it's known ahead of time that the refs haven't
> changed.
> 
> I think it's reasonable to skip this step when repacking, but of course
> we would still want to update info/packs (assuming that the repack
> wasn't a noop, of course).

It certainly may be reasonable. But in my opinion, it would be even more
reasonable to not use the dumb HTTP transport at all. If you don't there
is no reason to run git-update-server-info(1) in the first place, so
you'd neither generate info/refs nor info/packs.

We have been discussing in the past whether the dumb HTTP protocol
should be deprecated, and in the context of that discussion we were also
wondering whether we should start disabling git-update-server-info(1) by
default. Users don't generally need this, and most server operators
don't need this nowadays, either. So why generate data that is useless
in almost all cases?

Patrick
