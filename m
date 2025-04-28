Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7A1A3145
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745822966; cv=none; b=rNF6BOu9ZRE3SqvXJNHylFwhw+j4LFAv8Y5Iz4hlj6QcLf1E6cxJtmAYBf6RtpzEmHwYeppk/nxZzIyKyxl1nUsmv3vYQJdh2EhRVMTtJmFvLiNFjSeP4JGuqW+fPcIAj//KePjLSRnO8VJoC9+8xrA0ngJsGTx1lOJHw8Fofro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745822966; c=relaxed/simple;
	bh=mTZBsGZiApWDftbeik0wZUv+z+OqF8aE5f+sicrotR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYyJ7gHemKAETJJHKQiS9fl5BiL1y5THDpzn15M5tPiWXk84ghUaaUBPJVQpfCPr8HqNplUh5MW4rJawMTsdcyk29CSYN8cmM5k4N2mTlW+JO6b4nKchYnM692ML+AcidnAw9qQYW/PjyBAO01D3ZjyWiPJLzSTAdUameb5tLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m8X7KFd0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ilpi1FPX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m8X7KFd0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ilpi1FPX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D0E1114021D;
	Mon, 28 Apr 2025 02:49:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 28 Apr 2025 02:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745822961; x=1745909361; bh=chM5SfWHIn
	h+Ssd750c/Wu9MVoiqudc6mr4DLvBLXfE=; b=m8X7KFd0SVAi9112EhZb2tFILF
	Joi1oSV6FQaGpETpGnjFb42TEfy4WfqMTXPJN/88PeN1uCKWhEIx9jA/M9z3PnLb
	qMkr4XVhnP+LORBceMM3mxkqS4vBjWoxiB1yufN/x1jq5I88gpRJv7lMcXhK8e2s
	9Sq6EIF+FkuFai14ftxsIXZlydOgTM7+WZzoYW0K54PRGxlPnSmDCN9G3dszpyca
	KQOYJInM5S3H+knXB78fdutzDtFNDl63zB/GiPtvPZxhGSEHvd39cYIGTJoZ9a4h
	gb9xc8lTNbomscwV0XjT699Rz0yTTRtA8PSzzKw36/REtbTY1pBevdSVE8GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745822961; x=1745909361; bh=chM5SfWHInh+Ssd750c/Wu9MVoiqudc6mr4
	DLvBLXfE=; b=Ilpi1FPXRnDunzH+886O1sp5l5qKtQu9Sx7q/4zwyKeWDs/lezk
	hUYpT1jO/G8oEPno4+VLsJQGEPfwLbQyQ0hkdZ8tVQly4HnCFS36j8k1knPgkaxf
	g5aO0935ERL3IzhvAnSFchQxeyDpyegFsflq9urrhEDWOzzTbavmqvrXhu8GGO7a
	MSEVFe+nWwAXw9Z1I509t6VQTSF+zpesH443x4UiNXcD9/9zFii+2XtwxKRFsiog
	iS0omdWtrlDYtxKQsJwmIKXQyBbKLD7qgfcxTePl1/X5J2QU5YlwB2DmUo8bLgJ+
	ORTpF3HQBFZR/JV05mvUzj3+JlTqaRpztLQ==
X-ME-Sender: <xms:8SQPaAOPisqKoQp-BwdliUtuowsYDhItnzomN1vrXv0bC8JiBYwBAw>
    <xme:8SQPaG-yNXJnTbbbWPmT9B25mAv_KBgxu7U1DatZBadTLclUB-B3O4QC0axirUn75
    LqGXbHRMeqZyrqz9w>
X-ME-Received: <xmr:8SQPaHQL4ZYR5QIPukDfltoS15bgJZLgvCfggoU0eCbRkwF5O5dRqy7OK-ucoHjZiw76pDT8TdR60LQXQjo2dFA3dRtcQSAeXFyGSilIpPsq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedtleeije
    fgledutedtffdtffetledtudeilefggeejheduffetieelffeiteffgfenucffohhmrghi
    nhepvggtlhhiphhsvgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8SQPaIuE79nwMNIdJPSCwASh4IMnvcpDM2td86mY19FBRVhR69jLQw>
    <xmx:8SQPaIcVePIq2mPLfTyTDGe_WbfqnbJ6YT5p91hhO62MQ22QYQr76A>
    <xmx:8SQPaM0Q04tI21dC8OJe6UbRvIu_D7lz434Ngr6Byt4dhSux1JiFtw>
    <xmx:8SQPaM_mj9_Pd4hMeTY7XtrpUpmzqyFgiVVW3-amo-gnyprjS3OTMQ>
    <xmx:8SQPaOreX_M_o1xQJfmcz1IAljep1eIlbDLpRlnXGZ8E1d-hykCNFd03>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 02:49:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2dd3a91e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Apr 2025 06:49:19 +0000 (UTC)
Date: Mon, 28 Apr 2025 08:49:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: repo.eclipse.org outage breaking all our linux CI jobs
Message-ID: <aA8k6XLM1Mt37Oq-@pks.im>
References: <xmqqfrhxtdg9.fsf@gitster.g>
 <aAui8hrhm1qAxGcU@ArchLinux>
 <xmqqikmsuv2e.fsf@gitster.g>
 <aAzp49aUREpSsCrZ@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAzp49aUREpSsCrZ@ArchLinux>

On Sat, Apr 26, 2025 at 10:12:51PM +0800, shejialuo wrote:
> On Fri, Apr 25, 2025 at 08:20:25AM -0700, Junio C Hamano wrote:
> > shejialuo <shejialuo@gmail.com> writes:
> > 
> > > I want to know whether we should use the "cache" mechanism of CI for
> > > these third-party softwares? I somehow feel strange that we would
> > > download these softwares in every CI.
> > 
> > It also feels wasteful to me that the CI jobs need to do a full
> > install-dependencies.sh over and over, instead of running it once
> > (per platform type), dumping the state, and let all the other jobs
> > on the same platform type to restart from that state ;-).
> 
> That's right. I'll investigate how to implement this.

It would be nice if we could adapt the Linux-based jobs to use
pre-seeded Docker images. The idea would be that those images are only
built once and then used by later steps of the pipeline. In theory, this
could even be extended so that we only rebuild images as-needed when
something changes so that the images are reused for multiple pipelines.

Another big benefit would be that this results in a fully-reproducible
environment for developers that can in theory be uploaded to a container
registry. So if you see that something fails only with a specific job
image, you can now trivially fetch that image and try to reproduce the
issue in the exact same image as CI used.

Patrick
