Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4321188587
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029061; cv=none; b=leQUpe+SiCxirRSlfiPppjMBCupcfMfFmoko904MulFeHoNKs+HQdqQZF0eEGLYALRlWxqH7Lmg+Ikzxudurn1C7+P5cTXq3Mu1Kk9oL++vXk0dW1OSuQOaE/Jv7ai9pyKvDExRKd8W0sRZEf3HkBHOLcVwCj9Xj5mErC+1l8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029061; c=relaxed/simple;
	bh=akWkaJyqjcoBsqG2IE53MkWLmPFM+VydKlGZ9+2wEt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+mJ0xlUFMXMiQyKoFQtwVXDP1QtyoOgqd1+87RoazH0XbZI/3vB0yWKmSS7dZt/p0wrD9V70V3SA+E4Z+OLPaiyqYXWxrkb3WaQBp4+wowbpCZBpvLMktSYCbGeOyS/Bgq0pPPk52zoceRmahb9Lyd2P27IHYMJ+GjFmkCjPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nxRCi1o2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZFycuJ9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nxRCi1o2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZFycuJ9"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7FF6E114021B;
	Mon,  7 Apr 2025 08:30:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 07 Apr 2025 08:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744029057; x=1744115457; bh=MKi0zXJr/i
	qvfEHICXmGJdH+YX82CFotbxR/UqZm4Mc=; b=nxRCi1o2z+/kchkAIvmzqQ6h1V
	8Y7VlptCc8GjFSLMws3zA3NBVArbQQzdbKv/4p9woKRCxptzkE+rsuzwcXLoiW3A
	1adbyJ2nElp6oWVL1KZSOtWg+iACOpk0VVeG5dTv8mz0G4LcCTAkN++f1aq7mdDt
	NL9bKns3nQzh5d85R1S+xOyZu5LejH5mv7cxlWxxWv74kqtuq9YnP9jJo3tsU34v
	eC6W+uLMf8r1QuapAf2Vdt1Hp6GdBYc2hEzAOYT6fd04wTD90ytP7r74AY+6ytgb
	ibIAmux/h2ttNaBFLpVhCbjPTXrdZHAciPD1vwfVk7YeeZKmYhV9GlwLFlRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744029057; x=1744115457; bh=MKi0zXJr/iqvfEHICXmGJdH+YX82CFotbxR
	/UqZm4Mc=; b=YZFycuJ9E4rWY+mDHiSKUMTnRo5+dxk7xcgdhtqXtRFLwcvdo7p
	xCBOh3vi7Qas0iD6bdzdmzdhU5eaSUvHEnvYQteyNHbUse9jr7giPJNZ4Ks74D7E
	Vv+i6fak1ScrcLdX6QwJFh/OFAiQMXtMGezZNpfsHQkI4ZRxlGD8PhKyVbI98GFv
	r3eiM2rIQ1Icf6ua3MlzGwMO77+f44w32DFPWKRfKub+Rw2n2xbJARJY2E+s7phm
	gaE89rVySY/74Dfy9LfBIfSw3tXyEfcQuC3FP+gRhsh6z5Zsr8n0GDigYNwInzt2
	fGGZjGlystUm/wE/e8BvHikerMl9GKBrcAw==
X-ME-Sender: <xms:gcXzZ_zpcn5EAxJ5c2d_uXlvgdRMiramahO29Uo1heMnnlTc2ocxVw>
    <xme:gcXzZ3QkbJljNwQPNPY97SvETUEV9rU4ndLSHVRJVkt7KZ-ClHPkQLHHDxjUm5BKL
    yCVj6w4HbIximSK2Q>
X-ME-Received: <xmr:gcXzZ5UVHKbCP98dWXl2cHbfG8xNDgre3P-7t9nN3Vvg3dZpEqEMldHBrIo74Hpm1bf8kvB5thuI1xU605gyiUAqp2knDkZ6iPpg8XGljYNJzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gcXzZ5h6mFUzko-CYdJekuKABFg87lQis7zqHwkNv5GpboFEiOViMA>
    <xmx:gcXzZxCHdIBouKldar4N_7tYo-oo4JiP7uX73eMJefLMAaDtmkdyhQ>
    <xmx:gcXzZyJ-nEYtGcR7IzNuPSnr9VJNPtrfkn27UiViglOcuzXg2iIRGQ>
    <xmx:gcXzZwDS6d-NO5g6J26xAueJtk23wDdGgtU1aBqbw6ULgemN8PD__A>
    <xmx:gcXzZ4f_EfPU23hX30FPAHJ-MyJeRkkjnQVf-mJzG1K5mS8dTz64ukrx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 08:30:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed80b041 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 12:30:56 +0000 (UTC)
Date: Mon, 7 Apr 2025 14:30:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/16] reftable/block: rename `block` to `block_data`
Message-ID: <Z_PFfwf4D8HtYr_a@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-6-ebed5247434c@pks.im>
 <y3lbo4dnuv46kgy7fhzcksdea2pdm6nsy43tjai6tcgd6b3w5u@w5zqty5tgpmt>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y3lbo4dnuv46kgy7fhzcksdea2pdm6nsy43tjai6tcgd6b3w5u@w5zqty5tgpmt>

On Wed, Apr 02, 2025 at 03:26:26PM -0500, Justin Tobler wrote:
> On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> > The `reftable_block` structure associates a byte slice with a block
> > source. As such it only holds the data of a reftable block without
> > actually encoding any of the details for how to access that data.
> > 
> > Rename the structure to instead be called `reftable_block_data`. Besides
> > clarifying that this really only holds data, it also allows us to rename
> > the `reftable_block_reader` to `reftable_block` in the next commit, as
> > this is the structure that actually encapsulates access to the reftable
> > blocks.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/block.c                    | 10 ++++-----
> >  reftable/block.h                    |  2 +-
> >  reftable/blocksource.c              | 44 ++++++++++++++++++-------------------
> >  reftable/blocksource.h              | 10 ++++-----
> >  reftable/iter.c                     |  4 ++--
> >  reftable/reftable-blocksource.h     | 14 ++++++------
> >  reftable/table.c                    | 14 ++++++------
> >  t/unit-tests/t-reftable-readwrite.c | 10 ++++-----
> >  8 files changed, 54 insertions(+), 54 deletions(-)
> [snip]  
> > diff --git a/reftable/block.h b/reftable/block.h
> > index 6afb1b2952a..c55d47c3c52 100644
> > --- a/reftable/block.h
> > +++ b/reftable/block.h
> > @@ -71,7 +71,7 @@ struct block_reader {
> >  	uint32_t header_off;
> >  
> >  	/* the memory block */
> > -	struct reftable_block block;
> > +	struct reftable_block_data block;
> 
> I wonder if we should rename the `reftable_block_data` here from `block`
> to `data`. In the next commit we rename `block_reader` to `block` which
> leads to `block->block` in some places which I think looks a bit funny.

Fair. Will rename it to `block_data` though to match the struct name.

Patrick
