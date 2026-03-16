Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4A34887B
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645213; cv=none; b=dsh1zeAHqFJFs4FTpyHTcai1QdbGhf1rJ6Ng6pYCUL9BZMCL8k/FjvLnT2JBqpOnZJNuWW9TObh20BplM8+pATi6M0DXH6ImJXgIZAVBye+rNiTPEjFIQBs9WoHEriG+sOnn30+ZuGLn61DABUR3d/umPI2O7ERVmzwwou0WfX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645213; c=relaxed/simple;
	bh=UdE7xYMKNlRwJ701dlAQIedGKB+mbZ14CmXqfRdcMG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJiu7YsUyeM98IG68h1ynMbUCZj4tFJRbb6u9FezWHy4GTK4sTBC0WlVkyzz5GmHjwgQSnbXvqFX7KpjVRPAx5z1nAC0LgB8qTeiZOqXjxlGZbf0HeD1vt5ExJxNA9mrFAl7WDArQIySZYYFj67m0ZKbRoy4VmezXDhPuggpti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MPSmZmOO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YGUbUJWw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MPSmZmOO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YGUbUJWw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E1A5C140005E;
	Mon, 16 Mar 2026 03:13:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 16 Mar 2026 03:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773645211; x=1773731611; bh=CAtIZU+//3
	GJMfDnGBPmeySDks/DuZLqrj0iAIfWioA=; b=MPSmZmOOjcyME+aDz3biONtpMD
	LNGn5nXDJDCW1k8f2wd1khglGmm0PzcdKKLSimr1Oek0KF3X/Pgd6gsRN4+r0PVo
	3MeRWsF52YsPsW5NbEYULGWrgakMDtZ7ZyItWqcKkpTI1No40GWaQ+ewsVfVJrIl
	6riBuBCJs4Stt/0S7ZntAMc/1rtIBJe1DQEK2y6bbQmGxudh3a9y0wi6K322CUem
	36HDPTAjQxlqMLFZUAdRVH5MYyoT02+JRnbWS7d/AgwZjHa0YqVHVl87afuOfAio
	0ChDeBH4HmiNxasEfaymgfq8H+bV7IMyb3/+adr6UJJ5flgQDyiYVt9bnu8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773645211; x=1773731611; bh=CAtIZU+//3GJMfDnGBPmeySDks/DuZLqrj0
	iAIfWioA=; b=YGUbUJWwGPWiaIXkiuPYgTyLJ2NPyzvk5DkSu2WkSopuCoQtaGK
	1WHYQVW1lyDtn5wjMyGz1MUZ6+nSsh7IAUl5lmlMfrfW2R5YEax5fjuy5VD5oeWs
	KxGQidAVbd/tL5O1NmSRYYKU6iTL531TCD2TRtxbX9KGNT+JW7wQsK5YGXU0MnQC
	M/N6cWATuQjXpby7zSovnWl+ZCyBHybA2zLmbRnjKFwCvETyvKTH6Gpom1t7TLl3
	azvJ65LtX1Q9LG7VxIohpkLcObpgKdXZ7Xqy69D80MeCmkN2wzyvshVKv0S4GJd3
	sfEs4H3HIgJJrrLr153f5gKO+K9lMZvsrSg==
X-ME-Sender: <xms:m623aU8JGcYQoDFBR-0iSzxeMeYGAk8ESk69136VgdrLbWXFnqZ-Xg>
    <xme:m623aTuxCFHzt3nZ85QYLUnO7pG1RUV4OuFjMYF-BshzYis7N8ueKpeai8Muk7j3w
    d1pI3FOSIG3nixZiax0PK1aw3ACBmIJH7mkozMNZb7Ng3jOcq62qQ>
X-ME-Received: <xmr:m623afCFPEqXigWw573xSuSaeQlJyDs04R0b0eOM5Eiw-bZNGAN4ZPunYlYNkxUOALuAip2Boa2v10NV2xOCbcCGDZYbDg-o16aZRjbVctE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknh
    hosghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:m623aTW1em6zYSxcI--0m_8EwxyjZ_DpkazAdxYTrhg4sTdYxVPJ0g>
    <xmx:m623aVD7KfmrRMiFj0JYgZqrxZR3hZAmRFwwTtxOMd3rVHdtdKqRmQ>
    <xmx:m623ae8uACsn-TjWKWHMT2dGlqdLnUQd7Ak4zs55z820Ven2oZ1uTg>
    <xmx:m623aUHJfYfu-Hiz3laiYNRfAWvBfUeTKFMNMpJ0T-osSMPrIh-tcw>
    <xmx:m623aSh4mP_VV3Tcl1N3Eisixkbx3qvBY3mLLu1zzvFj1hZhJFr4sddr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 03:13:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e2855c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 07:13:29 +0000 (UTC)
Date: Mon, 16 Mar 2026 08:13:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/8] history: introduce "split" subcommand
Message-ID: <abetlsCTZaWPNK6U@pks.im>
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
 <xmqqy0jv1hor.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0jv1hor.fsf@gitster.g>

On Fri, Mar 13, 2026 at 03:35:32PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > this patch series introduces `git history split` as an easy way to split
> > up one commit into multiple commits. This subcommand has already been
> > introduced in earlier versions of my git-history(1) patch series, but I
> > eventually decided to evict them from this series so that we can rather
> > focus more on basic decisions.
> 
> We saw a few exchanges and comments but didn't see an blocker.
> Everybody happy with the series?

There wasn't a ton of discussion on this series, but a lot of it already
happened back when it was still part of the initial git-history(1)
introduction. So it has already evolved significantly, even if that's
not quite visible here.

From my perspective this is ready to go.

Thanks!

Patrick
