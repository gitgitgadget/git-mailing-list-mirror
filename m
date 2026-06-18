Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C82DE702
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794272; cv=none; b=bJhhYYDB1QZ6T6cPZXaNwZmW7g5z3JJzLf1bZhjjEj3L8E046GDFjG6YCi6mcdB9N92t8IFKI48FPMpWOvltOjt4gZYKrzbzBMaU4UaZi1vDs3RgxuQx22p/PW/TPeRQSWSMZw7GgvxmzbMrEpLD4vD21JySQ9oi1oq8/lkJ7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794272; c=relaxed/simple;
	bh=aL3qJ3dfImzB4a8KvjtVY+MUAiG28rt2BFDUeTH+CHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaIV+hxc1c2noFWVYrtXgYWMh7bJ9wB2nop3XsA32STLn9xe8NNZ1H6pdqetqCwzqccvqk8QLGiT8a2+1XJVhWZkIDt0iWBcoZd4W9d6ZatuJs11n/6U7ZAt1YHdnmdyXkpDe4J/sFv3dYLprMUJVbw3fyaaoZd1aatMcNK1Jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tMGjuTMs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JaEmoKrF; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tMGjuTMs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JaEmoKrF"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 036641D000D9;
	Thu, 18 Jun 2026 10:51:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 18 Jun 2026 10:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781794269; x=1781880669; bh=o0FR2Sv1mE
	27tP/ZtvsiO+QqWu8GXjy+dU04GjvIgEs=; b=tMGjuTMsxWZDfH3WTyHMQd234t
	POUOKgAcTpsMiscwj/jyL3LL4Q+aZvlk6/LtO3i7UUCVqCchwDeZy7HbFgbvcJLC
	0ZEnEpPSYudHBAU9DmpMd7IzPCRODARXtXbuugRYdJg72EjsNli98oc02HG/l18L
	d7opOscyUelrBg1DhnBvOvNEuV/QbwAogGTYb0pjeCkZUFDlcdRSbqL5ErubBjdV
	M9Dbf/oKJiNM+Z0hH6i+Jq6m65hjgnG80kvsPMM3RCibFsapM0G6j+YAwSpusSfI
	Pocy+nWPnMOq+cUKWXv8fEBDaYFG5fhhXK71JA1q+GlAQKSkQFAvr/rnOBQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781794269; x=1781880669; bh=o0FR2Sv1mE27tP/ZtvsiO+QqWu8GXjy+dU0
	4GjvIgEs=; b=JaEmoKrFlI+LsDp6bZhnVJiSvws4We8X6QjJe4CMaMQGJU/m4fd
	alucbV3T3OwV34JhqDxQuaIykiRMS/F1daFehrM7vY4JrK5dkDbc3C8UpAE5Xt0q
	Rwn/A79x4gq/stv2W6GpTU3bfeAQDd4xkTMOqRXpTdi74jCozEIV5uOdvQ+p+7px
	PlLp/cLPKKSM/Muhhs8L5s6ndnxGV36uuNHMGuECtX1Hz7axdv2k/9TMw8bnZOE4
	tNaZw2DXMhOqrwYi2F940NVvbbElrA0/XU8n8NIsNs+0xjN0JfwztqMhwnzAB7bU
	/xyFQwJVy7DGfTlGvnJgaoRd3bSxA4k73fQ==
X-ME-Sender: <xms:3QU0ahvNXzLWi1S4SOqdLoNXdKq3m6zCiM1EZ7zDm9xzUcyHAuSs6g>
    <xme:3QU0ahdXI2fIw9BbJmNOxEVLgB6tGd2KsGTEImOn9qBsEUS2TVEdJoHWaWUH1QJ_B
    awcSn-kbRQeTCSugTlqxxatTTVuA-sBVkIS2pBOPAsm97HPi_4R7g>
X-ME-Received: <xmr:3QU0apzMaFMaCT4-ZRBY-BMDo_QJsOx6610NFDPmj_8Bwg3vKn1-SO0M6RHtUY4i-4ibfQWLN2OnKYCTrb-XWH4WUGVU738kCbFjWc1zkQ>
X-ME-Proxy-Cause: dmFkZTF8x0tP7w/J94sOkCjK9wrJZ6iZhJgJDavtp5dVLAvX0RiIh0/A4crQtL9XM1Xm1p
    qikB8cL0cAVAORc+DWO7lNb7p8f8vAB2HOFVwIEMm2TV4Qz0f1ufMAvKi5YRqN9gHjGHe1
    wvkQgBwqedrV68nJj3og5CMz0QBO1VyS/EcrqgpXIpF6JUrmFgXWJstnDQwkplixZDo0F8
    ENIp7qdF2uAP4Iczy81oaIkY3zvNELbGt1ckASdyOD6uzLd3JODfBEYpbPXoL3zS2hGrwx
    8vioRBR57NvQ00+AHXtNof4oAuCMu4YvaLrQ46cd3i7IHcKnYmacO/ODqlxORu/i6vp0E/
    xo4EO/QizXNVmCezGVaqd8zyu9pabEUDrFU3Ygn5AjJZzQP7rNBH6RBMvs+zbLRru+t0b1
    zgYcU+mVqNVWniDnkUakov+Ju4/XZN5szlwUDdbsmxQxx1rUiAepp0Vvopvymw/9kFxoTx
    6V337gc2j8t9nXPBGoaINYaPTDYZHkWnoF6Sb/YEoqhI+2eoLJtOKSEulJTRFsLGcGLt3B
    bwiAg3m7zNitnz8jxSEkqDFJhVbd6SMGB9QY/Sgek4lQ0VR/f5YmrNa5jZb+YIzlaY8WVs
    FvOgVyh7yvq3F/PNfhoNUIqcwoKYBGdvP49hoyE6Mkuq39Df8AyqGUJ5NM/Q
X-ME-Proxy: <xmx:3QU0anFUY2y-ZPishaO2THUjMdaJ_G4NEjycEhQ202OztEZDQ2RiSA>
    <xmx:3QU0atyvlefcSrGEQywcIxMny_V27MlhQI5dT-0OcGEUyWVji-KKhA>
    <xmx:3QU0aovWIUzm6op3l5xEl0OlArgBSrEO1d06-VACJ-K-zZSR1Og2cg>
    <xmx:3QU0aq1OOKsBmJpz8INLrANNxPKN3Jl_Zgssa_MlPXnRkK1pLmlfTw>
    <xmx:3QU0ai2ebJpQi-PcDjSwO-tES7h6fNa-B1z27VPtkiFtrufAUTWUoA7l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 10:51:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e60ddf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 14:51:06 +0000 (UTC)
Date: Thu, 18 Jun 2026 16:51:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 7/8] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Message-ID: <ajQF1yyCUOdzC4Jq@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-7-f4854aa99859@pks.im>
 <ajLoiCS2mXP49eAJ@denethor>
 <ajOJM8EvGWWkYNuL@pks.im>
 <ajP7W7KsXz4Wk262@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajP7W7KsXz4Wk262@denethor>

On Thu, Jun 18, 2026 at 09:15:00AM -0500, Justin Tobler wrote:
> On 26/06/18 07:59AM, Patrick Steinhardt wrote:
> > On Wed, Jun 17, 2026 at 01:41:40PM -0500, Justin Tobler wrote:
> > > Is this really the best signal to indicate that a repository ref store
> > > has not been initialized? Temporarily setting the storage format to
> > > REF_STORAGE_FORMAT_UNKNOWN feels rather awkward and suggests to me that
> > > `include_by_branch()` probably shouldn't be using it to begin with if
> > > its not reliable.
> > 
> > True, but we don't really have a better signal to the best of my
> > knowledge. Ideally, we'd be able to use the existence `r->refs_private`
> > as signal. But that doesn't really work as the reference database is
> > lazily constructed, and the recursion happens in the exact function that
> > would construct it in the first place. And there indeed are cases where
> > reading the configuration is the first caller of `get_main_ref_store()`.
> 
> Ok, my first thought was also whether we could use the existence of the
> ref store as a signal, but I guess that won't work here.
> 
> > My first internal iteration tried to make this non-lazily constructed so
> > that we can use it as a proper signal. But that led to a bunch of
> > problems where we now parsed configuration way earlier than we currently
> > do, and that in turn led to all kinds of errors. I was able to fix all
> > of those errors except one: we expect `git config set` to work in a
> > misconfigured repository so that the user can fix the misconfig without
> > having to manually edit the Git configuration files. But when
> > constructing the refdb eagerly we will die early in such cases.
> > 
> > We could again work around that issue, but that unfortunately evolved
> > into a proper mess that I eventually discarded as unworkable. I think
> > this is an inherent design flaw: constructing the refdb requires us to
> > be able to parse the configuration, but constructing the configuration
> > may require us to construct the refdb. So this awkwardness is built into
> > Git's design, unfortunately.
> > 
> > So I'd really love to have a better signal, as I fully agree that the
> > above workaround is nothing more but a hack. But I'm just not sure what
> > that signal would be. And this version here does exactly what we want:
> > we honor "onbranch" conditionals in all cases, except when constructing
> > the main reference store. Even if it's ugly.
> 
> Could we embed an `initialized` boolean in `struct ref_store` that gets
> set when the ref store is properly initialized and use that as a signal
> instead? I'm not sure how complex introducing this would be though.

We could, but I'm not sure what that would really buy us. It would
basically be one more bit of state that we have to track going forward,
and thus one more source of inconsistencies.

Patrick
