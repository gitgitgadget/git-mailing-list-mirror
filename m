Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793AD3DF001
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335763; cv=none; b=OybEWb23TIY2QWK5rlADHN6s6J9AeLt31+aIhW8uiSP9pBNyqCYo6TjDm643mU56h2mNH1HNqCrZPu23M1VOvZEcI4+MqzVxrfjlNYaqycqKtLybCExgzbK7Yx0Y5/vViMVvFet1vTwC5j2zcyZio4/rAqGOL0MDN+WJwG1qiII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335763; c=relaxed/simple;
	bh=kGxbW4ZzDYwONSyBNXwox0MAGNlwpg+nQfqMHsEFl88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKjZnpA8PmCRACnFwEd7LAH9BLZuRj3KUeLhuaMc0nXgGLeBzYq4kig85oZX2+rn62GHkITeNP2HzVyZY7L8JABa3soI4e1a45/PA2E0U+/kMijb9Wo7Irl6pTTLfgqwbLZgG/i5BWdHxtvgFH0bZ7BFNVj9C49xtxn8OOUjVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EXq8B2oS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u96olBEf; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EXq8B2oS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u96olBEf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9279C1D000BB;
	Wed,  2 Sep 2026 03:56:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 03:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788335760; x=1788422160; bh=DPmswOiJIc
	8B1aJ7ozNwb/Nk9fIM+VjoJkBWx4MAGQw=; b=EXq8B2oScNp7PU49MD7gV1cQxe
	dbaPcOcxgqtm9uRXSDiPkpXYjWODs0aSSPedY5umWOGygaOQ+rdIbcP/MhaSpfLd
	pBY3WzK9WrYnFSGO+0KFQmRPEkVeAeFfDo0vVikhNy2HOx81UGmxC/0nZo0feZoq
	FXGDVYlCMA8rumaiAvnV7MTH+AwCH8ho4Wc826Hlwcy2x70BpO9BWzRe92BziMRg
	fFpXn/EcVHHFMvl+0w3zfN2SLZ2gFIlWSjpuzbljxfdJTsj72HtmkuhnIxVcpTbq
	YkOoev/8v1hbfnZ6BnR21BPt1HOgMiNfikwQRTZSpvCaA9e9vkRNNLGdLtNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788335760; x=1788422160; bh=DPmswOiJIc8B1aJ7ozNwb/Nk9fIM+VjoJkB
	Wx4MAGQw=; b=u96olBEfd/E2tOhdaXP1TKQ+hKCBa0OthmwSPgkPMiyhjCytxjP
	xtSCxAm7vj7rlbfzBKxrpDVySkvCHLQOCMk4eB5A4gfUbZapITy1Bql0jNwlPQLr
	WXLqD6pCC0b2d1OyIjEpLUOwEmhi5kDYd+2+RB8Hvus8lDcj2rO0Cof2QR96sZPO
	JEdbODfsudvqajYeGdzylWY4Qo/PPX41ajTQM3k7cWH2bnyJ1zZswvfm98s0PwH7
	4ancZtIVN25M3JIkAFmcDkTmGdr7TmsRQbQOFNlfrrgvmILvAI2QW5T9DZfQQWFA
	ZaMx/UakFKtduUMguXW0iC4pIHUQ/7DxeOA==
X-ME-Sender: <xms:kNaXarm5ZCyQyJ-olXYPgVYAxjAXvxHAtigG4qeSUcB9C3LDLXk3kg>
    <xme:kNaXal0Kem3pfEk9HT0Ua9AYN44ZEu79TAYdmqHb9XiZ93_9dP7D5L3W9smI_SSO_
    W6TuX9ziJq7CAARxYid1W5R30qbEx3M54RRGldsAkIrNsksAs2ERA>
X-ME-Received: <xmr:kNaXamoF7OOyb5I3tnq4_TGVakXJoVH_D-6Q6fxBI_YGcWZ-bnhmUhX0JgR_i7dN-iid1MI>
X-ME-Proxy-Cause: dmFkZTFXZtKyDrqg+tChC4mxadTTXoUzlAE+8c7a3U8gNjnjbCwwoMch6dLoG9VvWw0GQn
    l8NigQVkpyeM0cbUgqvDxp30maeuv3uGiat9Vaqdl6ipIOZl4rUvlETCsW6G1h4v2yMQ2G
    eTkMWEUcMMjpUWKhvXn5yYWaVuP9VL5dxHDK2xJxRNrWhxTKTn3ILyyRabmDfkJ6tvRqmK
    6Zhw5xEsnwnC0F1scPvJrlDae2yzY14M/zput3QQ4rronwJ1kmMpLxHCSR+ckz/kBC1ft1
    LiKvDjJDR3mbodaAMXF7MSUtGT9Z5aw5Xm2Sf1CixNt6XtZ7Ipk/GUcFJx1TU9NexCMJd7
    /hPNtPrC9/sqjnFf4FAkfPgk7XI9XAIPtQakS1hvVNJZV/rhs3NPfiA4+4SItdU83Bo00O
    +tYc2IHpjMfYzqUE4vVG4nnfy5jz+cUo+zKEtRjjeYtaV1PTa/dd3uofMkn+g6VZSNFXv6
    PN9/7gC6dp+BVGuqwH3jDTktPJolS8A1nrgZxZVc2dpH0B+pEguY6W+UduC8bzARdmDIzt
    ZToAoVerNCFGnHSXlr3Zya5DvFe/6WWQfxZh9Q547hSYNvjdP8Om0zJosedrkILQt+Ib4B
    cOFgrUHOFSud97nM3s182aTYQWbxAaiRcCAoMb+vz6DiI4Nw32s6XH88T8Nw
X-ME-Proxy: <xmx:kNaXaieYM9ux_oFHmGM2lBticnXTBU_nxwEWXWa1yVsNrcho4f7W0g>
    <xmx:kNaXaloI4HI58b6UGggsb9VsKLccnRDGncqblkiYjRL2zXnpdra5OQ>
    <xmx:kNaXajG4cj7wQrnumbqZm_IrximMut3ZaWeGc0uVTPRt0nuBvYuj5A>
    <xmx:kNaXaluGa3t41WzrhHsRxo-QfzbBsbEYtFldcQggup2nHgs8m1IbJg>
    <xmx:kNaXav-spijr55snTR8wZi0lal_7WoeDM6wrg-yB6jLfxG39TQXMw3bf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 03:55:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0676f607 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 07:56:03 +0000 (UTC)
Date: Wed, 2 Sep 2026 09:55:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: use system asciidoctor
Message-ID: <apfWhYF6nmcFGKE3@pks.im>
References: <20260902071113.GA70165@coredump.intra.peff.net>
 <20260902071613.GB641414@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902071613.GB641414@coredump.intra.peff.net>

On Wed, Sep 02, 2026 at 03:16:13AM -0400, Jeff King wrote:
> Our CI Documentation builds have pinned asciidoctor since 615a6c37e1
> (ci: stick with Asciidoctor v1.5.8 for now, 2019-03-29). Back then a few
> changes were needed to build with the then-new v2.0.0.
> 
> We've since made those changes, in f6461b82b9 (Documentation: fix build
> with Asciidoctor 2, 2019-09-15) and other commits. So it is not only
> safe to use newer versions of asciidoctor, but preferable: it's what
> people are likely to use for actually building the documentation in
> practice!
> 
> I don't think there's any need to pin to a specific version. We can just
> use what ships in our Ubuntu image, which should give us an arbitrary
> representative version (and if it changes and something breaks, we'd
> want to know).

Makes sense.

One thing that we might have to worry about is compatibility with _old_
versions of asciidoctor. Now that we're using a more modern version of
it we might start relying on features that weren't available in older
versions, and we wouldn't notice anymore. So we kind of have the reverse
problem now.

The best-case scenario would be if asciidoctor had something like a
compatibility mode where you can ask it to complain about features that
aren't available in a specific cutoff version. But I have no idea
whether such a thing even exists.

Also, I'm not sure though whether this concern is something that we
really have to care about, I may be overthinking this quite a bit. So
please don't read this as a "Let's not use a modern version", but rather
as me writing down my unfiltered thoughts.

>  ci/install-dependencies.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 2f61fbb07c..d57dce5663 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -164,9 +164,9 @@ sparse)
>  		libexpat-dev gettext zlib1g-dev sparse
>  	;;
>  Documentation)
> -	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby
> +	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby \
> +		asciidoctor
>  
> -	sudo gem install --version 1.5.8 asciidoctor
>  	sudo gem install concurrent-ruby

Huh. I was wondering whether we can now stop installing Ruby altogether,
but we still install the "concurrent-ruby" Gem. But what even is that,
and what do we use it for?

It's originally been introduced via 974cdca345 (doc: introduce a
synopsis typesetting, 2024-09-24), but unfortunately the commit message
does not document why we have to install that Gem now. I couldn't find
any reasoning in the mailing list thread, either.

Patrick
