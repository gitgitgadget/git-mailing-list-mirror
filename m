Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003D721765B
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764580732; cv=none; b=pMXeNwf+SdC+/y3ocK/eW3zlzPKExtcCZr7R/uGo2bANnvB6nZ5fKwgQ25eYmp6hfVwYQPNGtDQU4KZc8sCoilvOawgp+ikTau5qfSGsLoXqxrOCdTbe39aCNYdnwB2ShESw1SSkP0PC3jESrK4qUoRAKYyQjvzldCGrQaNTk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764580732; c=relaxed/simple;
	bh=UWHe4LqiktG4cNiSN5fbVp+zhGlqopApYDoYZfVBt6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCrNMQLnKKwiLerAxQXT0LR8+uywjvUPDOuij2MK8rRi2dlJrJMdUodQqga3VsG+c9M2+d182gi60lDU1UIiz6NQ12XF/YeWp6BgDOfEWov7BOejLSiS1udyqsayzsEoMlhtRiF7Mn64AbKCan/LsWaljVYPYfXnC1IvaJU0DU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nnu6xk6A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NIFPLZDH; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nnu6xk6A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NIFPLZDH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 026291400218;
	Mon,  1 Dec 2025 04:18:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 01 Dec 2025 04:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764580728; x=1764667128; bh=NF7vItARtc
	ev47pe/9oGVDo7YFm+ZZ1R3X/0Cg17COA=; b=Nnu6xk6ANRlRtjF8zofU1YWeAJ
	X6Oh0ydZnkhZRvK03eq4uPuYNsXp/eZSHnCblKy+wJofsDTKKkK9tq8HB41rnHka
	cgJEQZ93bWaXKONmoLEQ4hNRQuCQwKKHlQvuvGSi2MRClNFO+l0Ua21mPNvXHK76
	V2QLjeGRFoep6rvYdfJCj54NpoAVR1eteNnPvjqebt4ql/+B3TSZ0fIPSy0P5ZPM
	99SjP8EXvGj1vyyMVAIBYZ1mfSYhi9g4ygKgNxlHJWsS+QIV9k2XVt2+Dotg7kyY
	rxfoV6MBY6EgTxF7xsX8r1BU1wYMpaJe4p9gJM57YI8XAq+4iiZ0pa1Z7QYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764580728; x=1764667128; bh=NF7vItARtcev47pe/9oGVDo7YFm+ZZ1R3X/
	0Cg17COA=; b=NIFPLZDH9+RkkXzci+NupktrvUmfaXWHueKgjPjDbMxDUjueXqM
	0bdOzFSXpLCZ8rIXjHI9G/grmecIz17yUT7ztOwk0aVGWcVd1em/hd4sJyfe81RK
	wepWjROfCdT3yGJ84w5Wd1U1p6Z4P1zPaBM13aMyxba2Drg+AcbmdN4xk1e+xDIh
	3mGDDL5bf9+CuKK9dmRoNTxc5gtp/F6+MLvMdHzEXiw4QvOn3LY/DgDIr5Tys1Wt
	EFO+fjVl6LoWdSQ6dxZzMnde9zEnGnw9jg36A7q0Cz0N5NMKbGESHl/gABzN/DbE
	C9USFJWNj+EuDruPPRCm9Bhz8j/eSawof1w==
X-ME-Sender: <xms:eF0taWUfHmkt96XE3ZjMnbobK1NuDK5s-IuY4-MORgTl8TJlmOcdLQ>
    <xme:eF0taZncUrzm5M6DcQbHNebCN4ehRGlEdjLTY2D_XcAia3wFUKEjtzLtrVabaF4Sj
    bIdxOaKwfD9keAgevCmfmvF0vUQEuLIe66Kz7dmqmCYrGXMbu3nZg>
X-ME-Received: <xmr:eF0tafZwbxqYvwLYyZzIT3M8NKlyj5GQm4UKzI0umavD-mlogg4TiwIemnHPYXsyBq5kCgtd4QdyLH_2MXD3V82FkWbFCbI1K17cuOd5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eF0tacMq2LDNVqW3rGjfHkvrDD51v24WZaQA64hx6-fevqU9FS8vQQ>
    <xmx:eF0tacacerVh1IddOGnImVWaLdMpaH693rVh-zIMoGeiKpdy81r1bg>
    <xmx:eF0taS3yLPcVJjPdZkVgprQgeA_cArJFZO4M8xr39TZ3AB2iRnrX5g>
    <xmx:eF0taaeeHm_UhCh56QUU0mQxcWpF7dAKM9IiAibOjiAmgrHeHtR3ig>
    <xmx:eF0taa4mt9ndIcRKPUgXZz1guLoVWdnayeTHdJaCwhvK1cJo0L_INV0W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 04:18:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b61d6de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 09:18:46 +0000 (UTC)
Date: Mon, 1 Dec 2025 10:18:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] replay: do not copy "gpgsign-sha256" header
Message-ID: <aS1dcz6i5_phTUEG@pks.im>
References: <4f04af5790353b074cf122c450c1cd3f8d1cecf3.1764167611.git.phillip.wood@dunelm.org.uk>
 <xmqqh5ugog2l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5ugog2l.fsf@gitster.g>

On Wed, Nov 26, 2025 at 09:32:18AM -0800, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > When "git replay" replays a commit it copies the extended headers
> > across from the original commit. However, if the original commit
> > was signed, we do not want to copy the header associated with the
> > signature is it wont be valid for the new commit. The code already
> > knows to avoid coping the "gpgsig" header but does not know to avoid
> > copying the "gpgsig-sha256" header.  Add that header to the list of
> > exclusions to match what "git commit --amend" does.
> >
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> > We should perhaps think about how we can centralize this list of
> > exclusions as we now have three copies of it in builtin/commit.c,
> > builtin/replay.c and sequencer.c.

Yeah, that would make sense indeed. We've currently got three different
versions of this array in "builtin/replay.c", "builtin/commit.c" and in
"sequencer.c". Furthermore, we've got `gpg_sig_headers` declared as a
variable in `commit.c`, but that one is a bit different.

Anyway, the patch itself is an obvious improvement and bug fixg, so
improving the maintainability is certainly something we can leave for
a future patch series. #leftoverbits

> > This patch is based on maint to make it easier to backport.
> > Unfortunately that means it conflicts with ps/history which moves the
> > code that's changed here to a new file. I'm happy to rebase on on top
> > of that branch if we decide it is not worth backporting this.
> 
> I'd rather give priority to fixes over new development.

I'll make sure to rebase git-history(1) on top of your patch in the next
version.

Thanks!

Patrick
