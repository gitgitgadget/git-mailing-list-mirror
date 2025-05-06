Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537C144304
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746518248; cv=none; b=W8b++yQ//m61CaT71y30YgEzl0KX2bjip8YVRIHFaGxdja+457pbMwsrrjTqUwayCogTpVwWqtVgb1FhSAyk0jvI0+ri2IY0DvuRz/jq/kK3oVxQZrp1I5Z/TmecHoRixzf9pq8TcJNJYLZP96ON9SYOYZxRaD75pb1/M9/tCZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746518248; c=relaxed/simple;
	bh=OeG9jdJSPK1BTP6qbSxPl/PXG65kdFHxFtvifjcvH2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTKGcfOYntYRZJOC/y3fWIhqLfiEREsy8ITOsSfcZ0agPEWv1amJrcEznFd2SRRHYfWXx0Dn370B+eB3r2psm6JMHtXGDzoFtX+F69kiIlgEw3Y9eok92V/yY14jQLc0CRdpkCIuNhzeR2g1Tp+l0JsCtS20kIME5PbcKAVeSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tuLzEX4U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KCvdFziv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tuLzEX4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KCvdFziv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F537114010D;
	Tue,  6 May 2025 03:57:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 May 2025 03:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746518245; x=1746604645; bh=wRFd2uBVGh
	TGIrT+PdT7mH9fN0uo/NI9RP/n6SLg/Eo=; b=tuLzEX4Upp6tq7XOIBJgkkJNUp
	vn/D+awSv7VpZ5rqFe1T0kxImE5QnD+Z6MR2zqej+4FqC0PU0SUIsL7HtrIGjKmQ
	Xld0+jcSwJoNCkwYrNsWsUn9qJbI3e6XG5PUY4eWW5OLyyT9UqOzdyYohyC0mZsr
	RmMsPDDylsj6VR7VHfSVxzb1CfdwG8SVJ1OL6dqqRpJxTlDzBpxHIP2Gphrc7GoQ
	eSxKyShIeDhMn+1J60bDBi63yHwgHPa7m/eK9pfEYVW/9GqIOKWsLXqtUhVXn6eG
	nS3fG3oxPohzUKIlfrlBnZB9rCKpljbURPk3F1805ZGGDEqDpTdVQ4wyFazA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746518245; x=1746604645; bh=wRFd2uBVGhTGIrT+PdT7mH9fN0uo/NI9RP/
	n6SLg/Eo=; b=KCvdFzivCpaUx1cYT7ZKlC+RG42O/xdklKf/K/lBMshiXqqHzjj
	FfS+IM9eip2ZmxqywKN0aWVNYm1fyqmK3Kx810WuroK/le7apdCarPbuJHMgsOJT
	OmKjK0eaW3uuKAkM+KPGbDSsb4PXG36YAUXEC4Syx6L2qRyB0U3AdVmrx9DCSTv1
	EQJJByJ6uu/opl/Qxyr6xD6RlXa5vjWs5T5skRzukQLP4Y3iJgltuPoTM1/XLJku
	g+7xeNYzDn51qYB5DvmF4ZW/gRk8Kq8ltrqbTN7eD+yP0F1nZIcsSRrG7Tg/EV0M
	omnNH2SjDwhZ+gJi6HM9SgqJVbBd7FFZL8g==
X-ME-Sender: <xms:5MAZaCHOeXJAzVHF72sWSbzucsswCYTFz11PbLTQ0JKa-cySTNBBpA>
    <xme:5MAZaDWGcBlxgPRsHLyKjlj53ImpYCIH4WhH6-uW9B2YSagRe6qaCBwMvnPmrDTYg
    c_So9-Jz3nYHdDLmg>
X-ME-Received: <xmr:5MAZaMIauZNK9YYistCzt_nHmNLLPOpBxxTTadUnU8vkWxFGO1ovz1Hl-az53j1rxH5jKCtPmO3B1uryFg1zIhgmdiPlkRJ_t-9o4-OC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghouggvsehkhhgr
    uhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:5MAZaMEcll_-VH8fO-SAU4-59vRzKp1F9gcsLq5DUZ29yt7naYeO2Q>
    <xmx:5MAZaIVo76w417YK-rN_rGCdISOlYIJGJbJCeduhkCh6KxOBOU657Q>
    <xmx:5MAZaPOaWesJq6WUxP5omtonKGPI8MuRV7C_ZdqIjY_51PS3HANtIA>
    <xmx:5MAZaP3c_rpOOqHS3w6tnO00WvzSF0Rfv_2AtDGV1_7k6YarMg5iPQ>
    <xmx:5cAZaPrwhLhu3yzLQL3HqIIWjYVuVPDl6akyx81SYQyPfrKx4HyxPN3G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 03:57:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bcabf822 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 6 May 2025 07:57:21 +0000 (UTC)
Date: Tue, 6 May 2025 09:57:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] ci(win+Meson): build in Release mode
Message-ID: <aBnA3KNOfAo9EbpS@pks.im>
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
 <pull.1908.v2.git.1746282346370.gitgitgadget@gmail.com>
 <aBhVWMabOFYRUjvD@pks.im>
 <5e2fdccc-2c52-805f-ff9c-b9e0e72614ac@gmx.de>
 <aBiIPe7EVTBxENUp@pks.im>
 <xmqqmsbroxxs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsbroxxs.fsf@gitster.g>

On Mon, May 05, 2025 at 08:54:23AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> I am afraid that getting rid of asserts in Git's codebase won't ever be
> >> able to address the challenge that Git -- despite much reluctance --
> >> relies on a couple of external dependencies that might at any point in
> >> time cause `assert()` to be called, e.g. due to unexpected changes in the
> >> CI runner images.
> >
> > Good point indeed, I haven't considered this.
> 
> Thanks both for a discussion.  Let's replace and queue this, and
> fast track it down to 'maint'.
> 
> Here is a range-diff for my tentative rebasing the patch on 'maint';
> I'll make sure merging it up to 'master' would match exactly the
> result of applying the original patch directly to 'master' before
> queuing.
> 
> Thanks!
> 
> 
> 1:  f3ae94b175 ! 1:  184abdcf05 ci(win+Meson): build in Release mode
>     @@ Commit message
>          patch is still needed.
>      
>          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>     +    Acked-by: Patrick Steinhardt <ps@pks.im>
>     +    [jc: rebased on 'maint' to enable fast-tracking the change down]
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>      
>       ## .github/workflows/main.yml ##
>     @@ .github/workflows/main.yml: jobs:
>             run: pip install meson ninja
>           - name: Setup
>             shell: pwsh
>     --      run: meson setup build --vsenv -Dperl=disabled -Dcredential_helpers=wincred
>     -+      run: meson setup build --vsenv -Dbuildtype=release -Dperl=disabled -Dcredential_helpers=wincred
>     +-      run: meson setup build -Dperl=disabled -Dcredential_helpers=wincred
>     ++      run: meson setup build -Dbuildtype=release -Dperl=disabled -Dcredential_helpers=wincred
>           - name: Compile
>             shell: pwsh
>             run: meson compile -C build

Am I reading this diff correctly that we drop the `--vsenv` flag? I
think we should keep it around as it was a bug in the first place that
we didn't have it.

I guess this is done because we didn't have the flag in "maint" yet. But
I'm not even sure whether the fix would be needed in case we don't build
with Visual Studio, as the MinGW toolchain probably doesn't have the
same behaviour with asserts (but please correct me if I'm wrong, Dscho).
So maybe we should also cherry-pick 85e1d6819fb (ci: use Visual Studio
for win+meson job on GitHub Workflows, 2025-03-31) at the same time.

Patrick
