Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2282080DD
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578180; cv=none; b=hT9fw0K1GXck9WHxAWGKKlMNY0qMw2rovBi0vfAXhiEtGlacrbL2q5dfqvh7WPT58gGFq7EvxrekdHTaATtHO1I76rZHlWryXFCq0+JSYu+bfX1Q2fCVJlr6B3HuySRyZeJ9ZGvWcheYIbvFHYvwLF7+fgEcaMEFknG+YeyuyOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578180; c=relaxed/simple;
	bh=X98/ivykRTNhYk7OmJdZpjEwdCnhyCYGAgsA5RNhIzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOc+v16spAGLMH0MQvgW1ZF77DXzTyimPj0kq+1JBctBS3wcdD+dibKoV6ots+bcewgvczw2wYL0cKFRN1Aq9ndMmLDaeAQLbqAn5Y9bB4ZacOQIEuJjl21lnXRQ09miiTTLhCK4GMmSj/CvbXpdmF+NPH7c5gRDB6omNR406nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZF0XsLzz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PjolrqS5; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZF0XsLzz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PjolrqS5"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 117FE25400E5;
	Wed,  2 Apr 2025 03:16:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 02 Apr 2025 03:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743578176; x=1743664576; bh=KrofwZLlV2
	0Kba/L7JAa/KMl7T3uG2hKa8pX0lUbkFE=; b=ZF0XsLzz3Ip9nyyO1ulLuRns4f
	Xybq0XxKKIITJTudrSGNTZHaX+NP2l/KUB2T5hPBNmks+jLPJ3D1zpukTLXD//zL
	EjhIxlFGxKfaN874zpKmnfF0K9VhU1FMtqjWbskOsBsyUEXezPm1mbapDNF02F73
	T3GBZcQeSbdfvxUevZLJzWZsaOfiqDuYrbbN5lqZKcHqe5Zt3pQ5ZRl29t5+IUzB
	nf5FNKd0VwneD1ux9NcTeVQTCRGckBx1CueQojPkdEFYuYGeNa0Wx3Rnt/CLBlZ1
	rhst8O5946kdu4E+EV5ElnGywEAD7pvh21w71PxCpI2aveE88GihsDYAEFqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743578176; x=1743664576; bh=KrofwZLlV20Kba/L7JAa/KMl7T3uG2hKa8p
	X0lUbkFE=; b=PjolrqS5Iw7DsRr6Xav72lhp4ZjSS1PLVOHu09eKfdTVXMa7Trz
	P9+4LkBGfqcDRU9gPw79Qrv5+uzNqIfQSUy3s70PNA1VWM1PeEf+djK399v4Pbw5
	1+GJ016ucj3Zzd87UJCHsyA33Rd7Ny+eIITywuvjCZkGwLOcLoK+wG4pf47/Lyvy
	zJsqWvSS+ggMEQkDiX1eSVwfyFtOABjl4rMyUz8o5YSa0l/hYabo66vejs2a+7qs
	vDQvcKA244zc9TAXdrqg6kDkzqGKwNbece0g2JwRIYOwf0MPe7+FLnIq8hLIk0Az
	V0dQt+HLLuz44ctcuzpjuH9hU1P6ZddF+2A==
X-ME-Sender: <xms:QOTsZ9ffKGG24f_yXBblN0OaORMPR87l_DlUUacJO2g1RciweH8KNA>
    <xme:QOTsZ7OUrCt9XXSHQHc4BAQ7RF_ORsFtSQWNDGVlkHx79EbTI0cZTUHZfyftlwMlo
    NoGiFYA4owhnUFgBw>
X-ME-Received: <xmr:QOTsZ2h6eOwfcaNxMurnFQTYkOYenxy07sOtBG3DQ6YyXerOL8NKbp94g37qD6RhSiMgKtyLig3-j7BC_KbHiobRVwIdNu1kqRyz3hqcgX1aZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QOTsZ2_6CDoitzS1NFiLEDWbdIhDT0t_xwt6YAdQ4l32iQ3uSBBREg>
    <xmx:QOTsZ5sfaiPYnBeRaldGvwMUvBf2eEIcLcJDBHon-LBkjbbnjfV54g>
    <xmx:QOTsZ1FTX3q5njKGfzEhl68b4pVmzhhfLYdc8-QRuaeN3yt8zjef-A>
    <xmx:QOTsZwPRuj7ywzwTO7BBgQkIy4vo8dtA4WUE8upam3OlpC15q5QSwA>
    <xmx:QOTsZ6ib5UEshRRv_UMz7Y3VIr2rjdahdV8NyZ7AEfa8Abf1uXrwePsc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 03:16:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0756d747 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 07:16:13 +0000 (UTC)
Date: Wed, 2 Apr 2025 09:16:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 12/20] t: refactor tests depending on Perl to print
 data
Message-ID: <Z-zkOFD8PRS4L7Ed@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
 <20250327-b4-pks-t-perlless-v3-12-b436de9da1b8@pks.im>
 <4d461a62-9cf5-c64d-cd97-c70ef53afbac@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d461a62-9cf5-c64d-cd97-c70ef53afbac@gmx.de>

On Tue, Apr 01, 2025 at 08:35:25PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Thu, 27 Mar 2025, Patrick Steinhardt wrote:
> 
> > A bunch of tests rely on Perl to print data in various different ways.
> > These usages fall into the following categories:
> >
> >   - Print data conditionally by matching patterns. These usecases can be
> >     converted to use awk(1) rather easily.
> >
> >   - Print data repeatedly. These usecases can typically be converted to
> >     use a combination of `test-tool genzeros` and sed(1).
> 
> It might be even more elegant to teach `genzeros` to generate streams of
> bytes other than NUL.

Agreed, that would feel more elegant indeed (well, despite the name
being inaccurate now). I decided against doing this so that we don't
have to introduce too many tools, but wouldn't mind doing so if you or
other people feel strongly about it.

> >   - Print data in reverse. These usecases can be converted to use
> >     awk(1).
> 
> Or, in one case, `sort -r`.

True, fixed.

Patrick
