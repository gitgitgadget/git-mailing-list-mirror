Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41B2BE7AF
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994685; cv=none; b=hWdKN2UCelkfKok0UdQ8VJHWfA+8cPBOC9tjN4e0FCklO3oAus/p8nq+mMmeoQ+7Ne0fLTe/6Cm+Z8y3P10f1gcDSBFIeho7Mwjd76vdink4qPKt3UuNTHd2PFBcAHUEqNZ1w981pKP/w33sMqqVHQY1yBCpWc9wi3nIdIzwAw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994685; c=relaxed/simple;
	bh=bA1WRZkO2hhmmOYl3rlu8aAQr5dIOLL64q+2xUbjLDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XswOnINGsPcJX8yfbEF/0I05NsZpMriWrbetNsomtp6EbZ2pL5J4SpThbPITjfo7wT2cr8F+jZnnA+uk9BOhwkoenMNR741kh9cbeUn2CztKgsZFLczbvYZ5Pl7nffVlpMIToWUWARFrQClfCXV7kATth5P0OT12Lfi2m0uzYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qTWKzqt7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HofXoD/S; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qTWKzqt7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HofXoD/S"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 25BBE1D0011E;
	Thu,  9 Oct 2025 03:24:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 09 Oct 2025 03:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759994682; x=1760081082; bh=eY2oszvKnJ
	otsIxvSPZNr5RP1c3LLm9VkRhwzdNVBuw=; b=qTWKzqt7D3aDQsf7giu3Pr93q/
	qRSoJp9DmwwQLq+Aux7IKyay6trdDW16UFDSCeMc2Ubf5CY8nxXy1r+wLsgfYgRJ
	/HN0a/vapw8iEdkgaPy0sz9Ba2opyYFzlUXYL98KdKLyfLI5aXPsO4meFkUGyc8N
	xSCI32DaDGCk3oA4BAzqfQleI74/bmIsdGEcvrJZNB1oedDUeacXaXNjfdxeg/yy
	a7cKzkv0M9P6uYCdW54UwlY0+5yG+i2Kny3uTgpgYxN/Qsyj/SSg3KhvxSCXKshr
	vW6ttaRx6z/75zr7Rme/mJSy8NjH3ksdxv1nwb53u7uj/xz1r410+nOYwQ2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759994682; x=1760081082; bh=eY2oszvKnJotsIxvSPZNr5RP1c3LLm9VkRh
	wzdNVBuw=; b=HofXoD/Sct40aft1AxWWnojpx6m8Wj/T/HbhWKhkoojq4xKG+7F
	3E2soJWZlZESoeUTCV9vCp+OCWxHmnlMQiY/bSEaGTPe81qARUtaLy9DIMxamP8S
	hKm5RV3YfC3I167CR0kVSCXwDmEkpaM2iLiX09Ta+OqUiWbWjcUe20A8bfm0HTSF
	EUwdjUh7PumZtGH1Zt+IUBnWURbo+2C/01bWm9vdagAq+u9pqvCUmJC06mUxfxG+
	0c9/kCllVDLfgPg2RfxiklpTJOYQOJ7DvGQou5AoJ8uYwxq8Qr6SOdOLwARn4XpX
	ojJqSFBbsseQ7H0GKUWfpYBcJywKxVIdARg==
X-ME-Sender: <xms:OWPnaBg2bgrYbPRmYSsPC0mdr4xVpQGsA9BW1CCgBfyiQuo4w4lj2Q>
    <xme:OWPnaIScdCLBPsev1qf65012kV1O_C5KE1vI-fJqKs5UWOaWfBovK3l6OaxB_pRSt
    NqkGeje1ojs2JbFNEJTIkQWgZAJzt32DYvQF7ODjQXC9hfQu7eG5w>
X-ME-Received: <xmr:OWPnaDUYOR05KrauXDdqmF3BBcQg45qEJ3C0YOovyG9VfCRrZl30vcwzHW00TE2FlW4dmYBKUbfJLnCHyU8NwrqND_QHMU5dItrLMM3tZ74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OWPnaMRampKljR1Q4pzXGOuYuTxStI_LPqnxOl8RpkGbOBHvs9yigA>
    <xmx:OWPnaNmRqQVowcB1RyiIZ8zyJQ_5F0Ul6UkW90T4w0maeBN_1cru0Q>
    <xmx:OWPnaC5vlbbuahgsTcqeUs-_BSF4ztZE9I7vgkXHip6l4tVt_fjYpA>
    <xmx:OWPnaDgGxtX-mQ1CyGPpNkju5ARzdyu7EspMwbbTjw5JuCnluty0vA>
    <xmx:OWPnaP4I_aTVvqyj3FicQ5JGPKzMZTeuaLlMiGB3-YNp5V9V5EZZhLvF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 03:24:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2ed36ec (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 07:24:38 +0000 (UTC)
Date: Thu, 9 Oct 2025 09:24:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
Message-ID: <aOdjM8F6WvTEBIo_@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
 <20251009053825.GB1614343@coredump.intra.peff.net>
 <aOdRsR-k77uTWJRb@pks.im>
 <20251009063956.GA1622884@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009063956.GA1622884@coredump.intra.peff.net>

On Thu, Oct 09, 2025 at 02:39:56AM -0400, Jeff King wrote:
> On Thu, Oct 09, 2025 at 08:09:53AM +0200, Patrick Steinhardt wrote:
> 
> > > I do have one minor complaint, though: the name of that struct. I have a
> > > feeling that the name "struct reference" may cause confusion down the
> > > road because it's so generic, and because "references" and "refs" are so
> > > common in the code. From the names, when would I know when to use
> > > "struct reference" and when "struct ref"?
> > > 
> > > Could we give it a name that ties it to the iteration interface?
> > > Something like iterated_ref, each_ref_data, etc?
> > > 
> > > I know this is minor (and will be annoying to adjust your series), but
> > > I'd rather raise the point now than realize later that it's confusing
> > > and try to change it then.
> > 
> > It is puzzling indeed. I would claim that in this case it is not `struct
> > reference` that is misnamed: what it contains is as close as you get to
> > a representation of a reference. It's rather `struct ref` that is
> > misnamed, as it carries a lot of data that is only valid in the context
> > of a remote.
> > 
> > Another approach could thus be to rename `struct ref` to `struct
> > remote_ref`, which I would claim would be a clear win for better semantics.
> > It's used in lots of places though, which is a valid counter argument.
> 
> I am not so much arguing that "struct reference" is misnamed, as that it
> is sufficiently generic that people will reach for it when it is not the
> appropriate tool. It is for passing the ref data to the iterator
> callback, but it probably doesn't make sense in other contexts. Would we
> ever expect anybody to declare their own "struct reference" in a local
> function? I don't think so.

Hm. The thing is: if `struct reference` is established in our code base,
and if it is a simple representation of a reference, then I think it
might even be a good thing to having it. I could for example see that we
gain more interfaces over time that use it.

For example, functions like `refs_read_ref()` could totally be adapted
to use the same struct, and I would claim that this is a good thing.
We'd basically have a single central structure that allows us to get a
reference out of the "refs" subsystem with metadata.

This would for example allow us to make the peeling infrastructure
available in contexts where we don't use an iterator, which is something
that we cannot do right now. In the end, what this would enable is to
have higher-level interfaces for references.

So yes, `struct reference` is rather generic. But if it's the ref system
owning it I think it's sensible, because references are basically what
this subsystem is all about. This is somewhat equivalent to `struct
object`: the struct name is generic, but it's the basic building block
for our object subsystem.

> And yes, "struct ref" suffers somewhat from the same problem. It is
> mostly about using refs in one specific space, but the name does not
> really help clarify that. I wouldn't mind seeing that improved, but yes,
> it would be a noisy patch. I don't know if remote_ref is the right name,
> though (the "peer_ref" links mean we store both local and remote refs in
> it, IIRC).

If we decide to do it it should definitely be a standalone patch (or
patch series). I'm also open for different naming suggestions, but for
now this is the best I could come up with.

Thanks!

Patrick
