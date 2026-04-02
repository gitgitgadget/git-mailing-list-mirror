Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D7223336
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775156287; cv=none; b=Kyg14zOrTmuV0z6BzizfNs5pbI+gujC4o8vSmYNZ/h7e3N47aOMT1G16aeOqtW/gNtLIeiX4NvDy8WhYoJjYB37Gu+yPKBxpegveYfndM9MRJjPrO+CnOjCjRYRuosAKonKsvRFDhSjW5o71pgW1YszuIeXfo7Tmz/tV0Ayo814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775156287; c=relaxed/simple;
	bh=OHGLsmZccEV0m9cGkK84c7KsZnt/nUlyiCtp8zAAUTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Msg/jh567q21iW84uBcjZcUAuk/RFJb5rd0EhV9wDmY46OdGP/hRVPrVoaM41LtgS6VwbY8psWFRtKR8QRT6HyOUHgjPkVHygH0IHElj9nSr3OCRN0gvEtDHswLIyHhu0cLLbWYJLYScAS9JkMMuNQja3oe1ngsDDLXvTtpxkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VH+vheGn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fIWdyAj+; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VH+vheGn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fIWdyAj+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A7D1D1D001C6;
	Thu,  2 Apr 2026 14:58:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 02 Apr 2026 14:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775156284;
	 x=1775242684; bh=K17vkGTNuVe5k+5va0nOtfYLr4zx1HJ2QtO1OV02IAg=; b=
	VH+vheGneoE/dDxfE0YgXJwsUKVDPz3SpCUJrKvzeN+RDtpY9j9c+SeevChRSY0X
	gEP6IiJu8O/7w+I2Mut0xcyivsDHxfCeA2rYoMucQlcRS3Z5nO/Qe8tBmJrfYmU8
	vh4NYujlwOGkTnVrcyKQzJ7fF7bjekN8GtPou/irkebwhfE+y7ZY4dkfdHofRw5k
	wVzld623Xl63w2rVmzJnmlGgg82XHAagNEJhKRFm6s3LJReehKKlOFng1lWeD4kj
	Y+5WY3f84Kl39jUKcIVMAsmXtOxLiPhsmQBbhlsJtCoxCRrgPZsyEHKDmkUVryRi
	PTFZQ2Fy8lveblIbMdkPzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775156284; x=
	1775242684; bh=K17vkGTNuVe5k+5va0nOtfYLr4zx1HJ2QtO1OV02IAg=; b=f
	IWdyAj+lbbbrCjuO7sirlfeRwgEeARfDIJ1WLNvulikRgY6N2dmlXMZtSjV0z0bR
	xszLxSYbyfyKLpkcvZPsnOYQfecCdPhRUMTNBbGYiTKZu0VZgBlX41QodYUYMU3H
	OzpX90P4/Y0IO2071pHG+9rw72S03W7a49/vOZTiQNI3PLQYY5YRG9Dqg1YXm50a
	+HFJZZCmvv2Qn2YM1z2+xCTBIkHOu+6YYABYhLAZ43JdaMoDyk36UMm6loZRfOQa
	lPZcU+5pCgXwljv2jqxdBX037brNshipydLVsTIqVfoFv94MklV8NjCVq8DyP9fS
	ECbMA8PIWHFUyCRWRCkhA==
X-ME-Sender: <xms:PLzOad8BsQ2oWWY-3BStkZ9xLFHH8zZJ8LhaEBRIeTFriXGifzCUPA>
    <xme:PLzOaYkMzRKsWvb8BztuWfCa-lFqyjqTE7LToibaziJoWGm8vKoTAIHheySPWUmPc
    JL6StB0CBfL1yNmv0TRiwwosFUAD4eUkGdp2Ji8OLp-7WasMZhlNA>
X-ME-Received: <xmr:PLzOaTX_7zlgL1y_NtfcArg1XbKFeuNOxH9qUmYgHAnDHemzSAyk_38DFkSePSPhaxdCSdBtmns1v437MFgPi_2rTTemXHIWEPXy_nFZ1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeikeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    etheffvddtleettdetueeukedugeettedutdegueeukeetheefueevvdeitddtveenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrfedvtdehudehfeegudeisehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtg
    homhdprhgtphhtthhopegskhhkrghrrggtrgihsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:PLzOadFx9gpIbL-4tQwJIEE4YIeeKx-oxHTwEFViOmH-hpqNpxrafw>
    <xmx:PLzOaff48XRTCESmOFy7bql4WrH7W3UFApesd_D7xZwBPoM5EspFWw>
    <xmx:PLzOaeJEZerS0sdQPacJ8_kLMSgYTsilH5T97PcWAhvqTTA6N9iTSw>
    <xmx:PLzOaUGokpu5hS7cHi2lCNO5zLnMTT3bFL-OhXofeKeE4aFuUw9mzg>
    <xmx:PLzOaXHt9rJl02GRoh4Yn0Gw63HHgGcm2AxczjbU9Yw7XRwF61xAZmqc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 14:58:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9402e319 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 18:58:01 +0000 (UTC)
Date: Thu, 2 Apr 2026 20:57:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Tian Yuchen <a3205153416@gmail.com>
Subject: Re: [PATCH v3 1/5] refs: add struct repository parameter to
 branchname helpers
Message-ID: <ac68ME2j5CXzVgxF@pks.im>
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-2-shreyanshpaliwalcmsmn@gmail.com>
 <ac4aZRveWXjOtxgB@pks.im>
 <ac6K5UnVdw67Rfpy@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac6K5UnVdw67Rfpy@gmail.com>

On Thu, Apr 02, 2026 at 08:03:45PM +0300, Burak Kaan Karaçay wrote:
> Hi,
> 
> On Thu, Apr 02, 2026 at 09:27:33AM +0200, Patrick Steinhardt wrote:
> > On Sun, Mar 29, 2026 at 03:46:39PM +0530, Shreyansh Paliwal wrote:
> > > diff --git a/refs.c b/refs.c
> > > index 685a0c247b..5cdc8858c5 100644
> > > --- a/refs.c
> > > +++ b/refs.c
> > > @@ -758,10 +758,10 @@ void copy_branchname(struct strbuf *sb, const char *name,
> > >  	strbuf_add(sb, name + used, len - used);
> > >  }
> > > 
> > > -int check_branch_ref(struct strbuf *sb, const char *name)
> > > +int check_branch_ref(struct repository *repo, struct strbuf *sb, const char *name)
> > >  {
> > >  	if (startup_info->have_repository)
> > > -		copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
> > > +		copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);
> > >  	else
> > >  		strbuf_addstr(sb, name);
> > > 
> > 
> > I have to agree with Tian's comment on v2, this part here looks wrong. I
> > don't think we should depend on `startup_info` here, but we should
> > exclusively rely on whether or not the caller has passed in a
> > repository. And that will likely require a bit more scrutiny to figure
> > out whether there are any callers that shouldn't pass in a repository
> > because it's not initialized.
> > 
> > Alternatively, we could go with Tian's suggestion of checking for `repo
> > && repo->gitdir`.
> > 
> > Patrick
> 
> This approach actually leads to a bug and segfault in a specific edge
> case when running 'git check-ref-format'. The current tests don't cover
> this scenario, but they can be extended to catch it.

> If GIT_DIR is set to a non-existent path,
> 'startup_info->have_repository' becomes '0' but 'repo->gitdir' still
> holds the invalid path. As a result, the code enters the first condition
> and crashes. The case can be tested with this command:
> 
> $ git --git-dir='non-existing' check-ref-format --branch @{-1}
> 
> Modifying the behavior of 'repo->gitdir' might solve the issue, but I
> belive that falls outside the scope of this patch. After a quick search,
> I found a prophecy from Peff about the 'startup_info->have_repository':
> 
> [1] https://lore.kernel.org/git/20190806124954.GA13649@sigill.intra.peff.net/

If we cannot make it work in this patch series, the next question is
whether we actually want to give the false sense of `check_branch_ref()`
being independent of global state, or whether we want to leave it as-is
for now and then do a follow-up patch series where we fix the issue and
adapt the interface.

Patrick
