Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D735227B87
	for <git@vger.kernel.org>; Mon, 12 May 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060790; cv=none; b=M0zDgZjcX1LkScuU/qY8LcP1UM+Kmx1NpZvfHFQJiEsmAPQL4Ttm76Wvh5AZ2sJ8a+OP5hnvtro2kEtUVkiYZYMQHTwwg35nseCdwUYX3itigtMwMXYiuGuct2NGBsUrcYsuru8MQJYa0kMWkLUSRfMVuS+y0VxuROoB11sDO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060790; c=relaxed/simple;
	bh=dawIVP+tNoGYf1Da+JaSqUR+yNQVt+EA0mdLx4AKCy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2tPmqmePRd5Dry2uxtBknxYP8baF6EX9PljKN/T3dncUkHy2oBKMOsCUcxfeIEGvq8AwV88tXI7EcDYempISjHPfGX3GO0Lzy6TE9nPPG5OFNghUkGc20PD3fUxdIl/tp9c9LCPGapOfS0sVVB6rnf+Al4PUg663igtcvtgNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zXjz+E4+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KWwajfO3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zXjz+E4+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KWwajfO3"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A7A71140170;
	Mon, 12 May 2025 10:39:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 12 May 2025 10:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747060787; x=1747147187; bh=wEOHzrEqei
	IxDtckQDpVQVFw3oUS7hbMu4fjydXJXUo=; b=zXjz+E4+OZDlUelHfSYrwHoAJK
	5DHSD8h7RQFpdy40Xey1JXGgIrWSsJrSZSysSyb8oEAqb9HvOHO8ooETBD0NPWNN
	+5LeHoimvUXcRTANROif7CmxTrDvuhRwPBwVcSgm364nervjyelxjHqUI99asFho
	bcnGXrXFNQmT/CO0B6/jWSrarvZ4cUkd4KBNhzWa1w5zCAnDZmgaIQtXfv7jRjGA
	NHbONNM9bcu1lV7HlfiyXOCzdJl8St0ufai+wx32DzKS3boqTlRIS5lgllSOJvAE
	iYoIbIXf+Rotv1RrYwl8WKIm4CgnWPveto9U5LSN0KrlzcZjGenGgFjLhD5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747060787; x=1747147187; bh=wEOHzrEqeiIxDtckQDpVQVFw3oUS7hbMu4f
	jydXJXUo=; b=KWwajfO3N122JdnBE2+ozL6oLE6rfK5gOowmn63Otz1ObrXY1tD
	TKL5oDdt8jK6hlfNCsddrmtzMk2kMcw9FHlWoH/wd1y447WFThR0d1KaKx8da1Us
	dSLwzZRUBk1EvHiDr+JWEM4tTeJ/X1iUQzpB0MOw22w93+CTbvnmpV1ZuogobItF
	v5HDM81WcvGTX9eSYUu7RgunI4rvCC95rZ7qt1tFufeo7ciTkgrUVq/0OdHr6guW
	IPYqaR58D5KRhjOmCYM9pb3k3cl/RA1mjqPLWvB/hch4FL08TPe7/svOmPBtIE1j
	tjfGsIb639zM3+b1KvFm+UYB98qzF9mSGFg==
X-ME-Sender: <xms:MwgiaOzZSujducF7wycvEteMzP2z0SHaWy5eyLolN6Fq3Lk2oG0Lbw>
    <xme:MwgiaKTtLv1d1weAwWMnSX19DFUOqgX4JISj6XucU42b1mAdF3bTpqDF4E0d7F2rg
    Dtdpd1s6HF2LV75ew>
X-ME-Received: <xmr:MwgiaAXfDDmSRRxb9gxeQLjGm7urPdHeZMEYIdDth8Vtgx5L8peXbXaerxrNq6XPXpb9AFPSCDt9_RbjbGHgesn3OFvYJ5Ez_nsD7JSMlno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:MwgiaEjfWA67lhUBVGFIwvG-8kF2nrEb7kX39l5WnSXycTf--tDw6Q>
    <xmx:MwgiaACGFXfj0cRLUuJIuTDLDMY2qKmigosVtJ55sM73o1mlGn4q4g>
    <xmx:MwgiaFKqdBNcEe2-aW1X-_oSfft3Q2jEDH2KaMssrSUvO5N1poGz9g>
    <xmx:MwgiaHDC56u1tN6PQg96-ODMKVKV3f3ZaAr7X-s8Jqs6-WBJmw6-lw>
    <xmx:MwgiaO4chWbjZskREnrG5aaVYK5u8GBvd5rpyO5XEKsBOsqbFK_Z3Dx2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 10:39:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bcfcc3a4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 14:39:44 +0000 (UTC)
Date: Mon, 12 May 2025 16:39:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] packed-backend: fsck should allow an empty
 "packed-refs" file
Message-ID: <aCIIL6IWiiWiGbFd@pks.im>
References: <aCCtQDnWII-knmEc@ArchLinux>
 <aCCtx2mqihlc0M7H@ArchLinux>
 <aCGzIlLH_ESNg6-v@pks.im>
 <aCHoovrKiSUemBCL@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCHoovrKiSUemBCL@ArchLinux>

On Mon, May 12, 2025 at 08:25:06PM +0800, shejialuo wrote:
> On Mon, May 12, 2025 at 10:36:50AM +0200, Patrick Steinhardt wrote:
> > So I wonder whether ignoring empty files would cause us to miss such a
> > common error. But I guess if there are valid cases where we may end up
> > with an empty "packed-refs" file we cannot do anything about it.
> > 
> 
> I somehow think we would always write header in the Modern Git. But
> "create_snapshot" accept an empty existing "packed-refs" file at
> runtime.
> 
> And header is introduced in 694b7a1999 (repack_without_ref(): write peeled
> refs in the rewritten file, 2013-04-22). At this commit, we would always
> write the header into the "packed-refs" file.

So what happened before this commit? Would we end up writing a
completely empty file?

> But in runtime, we accept empty file or no header of the file content as we
> want to keep compatible. In my humble word, I think we should allow
> empty file at now. Then, In Git 3.0, we tighten all the rules (there
> must always be a header etc) and also update the runtime behavior.

I think it depends. If we can prove that Git (and other, third-party
implementations thereof) wouldn't have ever written such "packed-refs"
files then we should start warning now already, even if we accept such
files at runtime. Otherwise, if there were versions of Git that could
have ended up writing such files I agree that we have to accept this for
now.

But if we were to deprecate the ability to read an empty file I wouldn't
adapt both paths at the Git 3.0 boundary. If we decide that an empty
file is broken we should introduce the check for `git refs verify` way
before we tighten the runtime behaviour. Otherwise there isn't really an
opportunity for people to learn that we are about to remove this.

Patrick
