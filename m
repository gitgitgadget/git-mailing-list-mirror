Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A960B8A
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059343; cv=none; b=sWFo4k0LHLApqErZhnJtfA6eYw3KUTJU8kyEENWixQa2LRqCPZzSfg0xjPbHk/8wK7teC/4bRkZ8JiaPOUbRfpO+MSnSL0qLhULAQNUIZl5dJCNXIZdGpg6F9WMe59pzEjkUhvQZaA/3R5o/j9w5pGZFeaOjp0QJ8FiObKTiOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059343; c=relaxed/simple;
	bh=DfGmrpYBNuZ8RsV9p0Dcft/WUldzJRvg3zHIvQsp+8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP48de3iKDbQo+4tD7lpq4msSW9TTG3ibmtQZXrfNsbhf/pBzYVa5tr1p5xr1uuNGCTzhRfiSocGSmg9el8Pdlf5RjOpVl3PkpYWShwk2lWVK0AqTWVjNLYEM3Loj0W4QUoOcwGqStYNHjXPucKR4cmaR576br7EmK081WSS11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hFSLzJjn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IsNWc/t5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hFSLzJjn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IsNWc/t5"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id EB36913801DF;
	Wed, 16 Oct 2024 02:15:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 16 Oct 2024 02:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729059340; x=1729145740; bh=z1enpIoo6a
	8NqW8s3BSfIHrYqlKxDqYYH53xy8A5fos=; b=hFSLzJjnqULaWXNdX7sgKfeIjJ
	iDlKn1TtyxWUkxi9JucNxtd6vHvu+DRScV+hWiJhFezA6da9dxikpQVAI0AWBi7s
	UDFUxcCm+pF5BBCXHz2St+CtBSD6C5rr7DwDEUHt1tHiQ2TzV6JXDogPUksnIlCz
	vvFgPZmNa9tXiBEvjHDJ2CGloSOwiux/z307SbEbhpiL9Gv92R/spMRzeUBdQnb4
	X4kGdh1FG+uPlaGoYu50ZPzmLXNPHxkSulj3KjhwuzxeEmfw+uyXyokqxFAoHOK7
	vNTnqMsRNXsI/p7PEDWNz4wKnllunoym4BtxhQcBekr/wnjf8jSDBV860xtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729059340; x=1729145740; bh=z1enpIoo6a8NqW8s3BSfIHrYqlKx
	DqYYH53xy8A5fos=; b=IsNWc/t5sH9bUBG44eiov292OT4y5SW9WMhE8vjXHyWI
	hjlOyf34BgGBeCHAdt4N/ktWJ4Mu6I5s9fkx0WVAt9GfEydCxlIbnLOGZ9Ct+qag
	lf6p0Rc55Nrtx2PfM7OKQO1Rof+xgtZ4mAQZgMDvlS5QYQPWSpEx0Krb5MIwk+om
	ooFLt8ru4TgThjsfjYVte6iZhcGKmuzZWIEd7ow+HNAq8RVXGtzFIENkiXssQPxP
	0duicqNOo6JYv4xMrkZY7M18uFzO2te1S9UNr5oykSBJWsqXHRmX6W0WN/KQ83Og
	5R4vdVdQrBPH5wAMhF/mfsEEx9fV4tiPZOvCXPGbrg==
X-ME-Sender: <xms:DFoPZ3TyDcJ5HqlbYqweGFGJjphsAJAsHMIMFuZeg4qIPT6UJdYA5A>
    <xme:DFoPZ4yPqorfodKHmN4XvzrU96bxk5vS4GhemNnDyc7lE-Vg1NOZj4vZW4v42LwXS
    Tm_xyGZVGjIIhmwiQ>
X-ME-Received: <xmr:DFoPZ80-B_wAf630vUGFXZ_9Z8l2Qdi8AJbyuPGwkbDdscbbtdXwcU2vnPlgknWEdyIp4p66Hmv86_gIG2Jo4MOtlXW-i_X-nJz-kWRxiDl55Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghj
    ihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehfihhvvgdvfedutddtfeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DFoPZ3BXYcGvsS7H8d6ayUzC2fIMeSDNxRdHw_6T-cCgCGF4zCTiIw>
    <xmx:DFoPZwifhMI9bypIzQxJG28u_VPAayKlLaa2GbDHFYHw1GJ2psNwow>
    <xmx:DFoPZ7qCnwXlysNXW0MH94W31U0byDzycuBAi-nJsMwoiydF2uIiPQ>
    <xmx:DFoPZ7hWc_bvfLMJ3w21gSgEN0Yu99HrG2K0JISSVvzyB_bjnbpYVQ>
    <xmx:DFoPZ5vFSxzdEHLzUeP6x_48kMqEJrIen9BRLlR3BC3zcuUufk29o_Xi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 02:15:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3b220d33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 06:14:21 +0000 (UTC)
Date: Wed, 16 Oct 2024 08:15:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] repository: move git_*_encoding configs to repo scope
Message-ID: <Zw9Z_xcHKcjKVUB4@pks.im>
References: <20241015144935.4059-1-five231003@gmail.com>
 <20241015144935.4059-2-five231003@gmail.com>
 <Zw6SsUyZ0oA0XqMK@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw6SsUyZ0oA0XqMK@ArchLinux>

On Wed, Oct 16, 2024 at 12:05:05AM +0800, shejialuo wrote:
> There are many builtins will execute this config setups by calling
> "config.c::git_default_config" and then "git_default_i18n_config". If we
> need to use "repo" pointer, we may need to wrap this pointer. (This is
> not the problem and it is not hard).
> 
> But what if the "repo" pointer is NULL? We still need to set the value
> of these environment variables. Because when using "git-mailinfo(1)"
> outside of the repo, we still need to set "git_commit_encoding"
> according to the user's config.
> 
> So, from this perspective, I don't think it's a good idea to put these
> two configs into "struct repository". Because we can use these two
> configs outside of the repo, if we put them into "struct repository", it
> is strange.
> 
> However, I either don't know which way we would apply. So, I cannot give
> accurate answer here.
> 
> ---
> 
> Patrick, I wanna ask you a question here. What's your envision here in
> above situation. As you can see, if we put some configs into "struct
> repository" and we run the builtins outside of the repo where we need to
> set up configs, the "repo" is NULL. And we will get into trouble.
> 
> My idea is that if a config could be used outside of the repo, then we
> should not put it into "struct repository".

I guess it would be nice to have a set of convenice functions in our
config code that know to handle the case where the passed-in repository
is `NULL`. If so, they'd only parse the global- and system-level config.
If it is set, it would parse all three of them.

I also kind of agree that it should likely not be put into the `struct
repository` in that case. I think where exactly to put things will
always depend on the current usecase. I bet that in most cases, we
should be able to get away with not storing the value anywhere global at
all, which would be the best solution in my opinion:

  - It can either be stored on the stack if we don't have to pass it
    around everywhere.

  - It can be passed around in a specific structure if we pass the value
    within in a certain subsystem, only.

  - Or we can parse it on an as-needed basis if it happens deep down in
    the calling stack when it's used essentially everwhere.

Now there will be situations where we used to store things globally as a
caching mechanism, and not caching it may have performance impacts. But
I guess that most cases do not fall into this category.

Patrick
