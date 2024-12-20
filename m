Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A80215197
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734720000; cv=none; b=pwy6bLobd3YeGhD3nrTdOQtNLnrhUsVhxJqJ5Emsfo/pzHjmCiPmeiiX0fnCLJG9ZaJyiwNolQLK39zpA2Vvq3Rr+4r6aWGTpNE1LCyETezh0G24659iLaYAMI+24VEePFDmeQHTKIHLabLwquwZ7Nq9Ma9crJRbo4bD+nAQd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734720000; c=relaxed/simple;
	bh=NGJcB1cunpPVTpuJgcBPuF+wAd693pQXnNpWvYECvcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUbo6unhlOPd3Jz3fbpdk0gNGQsEXHBt3VUD5dUL9mg2EmSJfCflNaVe7MiW7FEAs3+akWOyfb8pNqGs2oxB2Wqoqn0QhdCOZXNjLLKD+QLoOwbVtnVgPp7K/CmYVL8w7bP8RAjD0L8/BncAus4ihhwqlMdtsAMBkZTcpvABKNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R+Twt+fA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uz1vdFCt; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R+Twt+fA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uz1vdFCt"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 913A02540149;
	Fri, 20 Dec 2024 13:39:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 20 Dec 2024 13:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734719997; x=1734806397; bh=L8FnBNYCcy
	/hc+tib9arXdElPVUlw4QxApEICMoAORM=; b=R+Twt+fArJjBAY5MDUozxBIoFf
	JHwPUUl/D1XzLSgxvAmcTPaB9PN5hz48Z62Zi4ZltN95dXzJ+doJHvSfJCtKtCD3
	DCqtOExvI5Ov64sDiiG85RW2BbfagDrOJLtpaFfn4NIzGyRKsdLTEi7dTuMKztwy
	rUAhTHzhenzsN3xiZ1N1R0zMF/YbCW60mzejR4Ba722+T0YQ0CfRaW61tTm3uW48
	3AmW3dsoRPmp5mxi8SDfpGbMtmtJ7/qU8I6FfUIKILlCRv0oIY96XmZSkyUa6DZx
	Vhi0eK6Ifa7xnuy5a9eGGhXXnTVGKCV9ErAsmDJM5ACXRkJG4tI7JDXDlQyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734719997; x=1734806397; bh=L8FnBNYCcy/hc+tib9arXdElPVUlw4QxApE
	ICMoAORM=; b=Uz1vdFCtRUq+Aj3vIVYejixBfZkss+1lhaCqBJLgMKg3rIyJEis
	WOJWTQPg/eYjJwFRGL5sxRb6UbnZNdIMSN2N/Wr822SFYXW++kCbivYedAq4L48S
	gj9GHquu29e6j/3nxisinHYurqEKMlzYffZsO7gZbGQI23byqNGEYdzMkGmSoYIa
	uLDwZj1ruWFrO4Z+JSKm93CFvUDpO6HGvcgpjFcNvnPkHsFQVLHOw2i9qXvKus30
	sxUGOWUrNlMovdEKoOOJNACLAS2xWYzUvtbxDJ+aY2rzjf0lGpSFkZ0clk6HEXRs
	24lHsHwNMTcQ0+upXuIhFPSU+ycmqpie9Qw==
X-ME-Sender: <xms:_bllZ6mlERmuh30Gbpm-t4TMtTiBd6eZF2LIp-_aQXf0Sf3sez5j2g>
    <xme:_bllZx17GxVwla5ch6SPoBs6Llrm6TIheFsl29uOY1yDI06fQnVr491M1TDghi-TX
    bF447_zq1fk73ha0w>
X-ME-Received: <xmr:_bllZ4rRa0lePb4uFrvNj_o2MRzVT2DcQP86cTjyruszgrHsiUSe5ELdUvW9C-pP2-3xhaIl1oBLP86hGGCl78gOdpy6I4YVbVRgmbZ8MuQeCf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_bllZ-mfRT26UZhRh5g6pFdezcOU8hRipbKsvFZbnVsVCNmBpxfKIw>
    <xmx:_bllZ40wYFli8JIhH3l7K1gOcUC7NsIZ0sgwWZ1qiJLP0IKOcVGjIg>
    <xmx:_bllZ1v2dQIHbxezs-1Aa29cIKM2lQ_byo3n7gp1pPHo_ZUxjSZnOQ>
    <xmx:_bllZ0U4EYAXRNPGHzwKKngrj4u7dY3zsJ7PZwdtq6BA5vYm3uQpOg>
    <xmx:_bllZ7SqFYYgqYywvnerEoPhT-45DHgdseDtj58uooQOUTemsLIWHKLM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 13:39:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b1f0691 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 18:38:00 +0000 (UTC)
Date: Fri, 20 Dec 2024 19:39:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: respect build info declared in
 "config.mak"
Message-ID: <Z2W56ux3mLnfJ43Q@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-4-f1457a5e8c38@pks.im>
 <20241220155433.GC152570@coredump.intra.peff.net>
 <Z2WfirfrpYYFgYdw@pks.im>
 <20241220175136.GA203033@coredump.intra.peff.net>
 <Z2WxIRcV0LOvx6OX@pks.im>
 <20241220182427.GA213015@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220182427.GA213015@coredump.intra.peff.net>

On Fri, Dec 20, 2024 at 01:24:27PM -0500, Jeff King wrote:
> On Fri, Dec 20, 2024 at 07:02:09PM +0100, Patrick Steinhardt wrote:
> 
> > > Is there a case you found that doesn't work?
> > 
> > Yes:
> > 
> >     $ make GIT-VERSION-FILE GIT_VERSION=foo
> >     GIT_VERSION=foo
> >     make: 'GIT-VERSION-FILE' is up to date.
> >     $ cat GIT-VERSION-FILE
> >     GIT_VERSION=foo
> > 
> >     # And now run without GIT_VERSION set.
> >     make: 'GIT-VERSION-FILE' is up to date.
> >     GIT_VERSION=foo
> > 
> > So the value remains "sticky" in this case. And that is true whenever
> > you don't set GIT_VERSION at all, we always stick with what is currently
> > in that file.
> 
> Ah, right. Even though we have a recipe to build it, and make knows it
> must be built (because it depends on FORCE), make will read it (and all
> includes) first before executing any rules.
> 
> Something like this seems to work:
> 
> diff --git a/Makefile b/Makefile
> index 788f6ee172..0eb08d98f4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -596,7 +596,12 @@ GIT-VERSION-FILE: FORCE
>  	$(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" GIT-VERSION-FILE.in $@ && \
>  	NEW=$$(cat $@ 2>/dev/null || :) && \
>  	if test "$$OLD" != "$$NEW"; then echo "$$NEW" >&2; fi
> +# Never include it on the first read-through, only after make has tried to
> +# refresh includes. We do not want the old values to pollute our new run of the
> +# rule above.
> +ifdef MAKE_RESTARTS
>  -include GIT-VERSION-FILE
> +endif
>  
>  # Set our default configuration.
>  #

Oh, nifty! Playing around with it indeed seems to make things work, and
it's simpler than what I have.

> But I don't know if there are any gotchas (I did not even know about
> MAKE_RESTARTS until digging in the docs looking for a solution here).

Good question indeed. I was wondering whether Make restarts at all in
case where none of the included Makefiles change. But it very much seems
like it does.

The next question is since when the option has been available, as it's
quite, and the answer is that it has been introduced via 978819e1 (Add a
new variable: MAKE_RESTARTS, to count how many times make has re-exec'd.
When rebuilding makefiles, unset -B if MAKE_RESTARTS is >0.,
2005-06-25), which is Make v3.81. Even macOS has that to the best of my
knowledge.

It still does feel somewhat hacky in the end.

> If we can stop including it as a Makefile snippet entirely, I think that
> is easier to reason about.

I very much agree, but it's a non-trivial change. I'll leave that for a
future iteration.

I'm a bit torn now. I have a solution locally that feels less hacky, but
it requires a bit more shuffling. If the eventual goal would be to get
rid of the include in the first place it feels somewhat pointless to do
these changes.

Patrick
