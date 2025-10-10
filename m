Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE501F4C8E
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760073759; cv=none; b=jaaMCuLyfF5p9tnXjwn1IE7OAwUeSCUNOiysDag39GPdrqd0/3K9A3sGiiOZdfvIcAZSrEVn+DjGtto78mzrD1xaUAfv3PeYIqOvucxUhXaXNCevHP92PKY9iYGKVtdyFYE5RD9fa48t1Iy4Ge2Y8R1qG+sW6vf9f3XiQiw7sJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760073759; c=relaxed/simple;
	bh=Ef8ia1xNz7RIAFst3n9sVxGNEc0B95/dg9uH4lNL8Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb+pDipAoFX8esp/pJgt2YugtUKApelTbJgPC5q0q86902oNad5Fx7XY9vKoSRYgNz2RDGTZTF2Fn8g7UnbR96UnfMNGztbZVKPVlDi8LYZ6Y3PJIl4X/AMlTxO0bvgiVkQrtgGG2Iknb3Z3N7VgryFmnbz8Ov7DAvn1PTqXVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gJz5//OO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cFa604bm; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gJz5//OO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cFa604bm"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C90F7EC029B;
	Fri, 10 Oct 2025 01:22:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 10 Oct 2025 01:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760073755; x=1760160155; bh=vBP/zvsvvb
	sjX+ChlJxYLM+e15/qhch1qtgBJsJJ+74=; b=gJz5//OOkKSqCnc3FhLs06fQl/
	6XtEXC7ydNiHbU/6A0z3cOqQgARUJcva6GTTh5ggcJWbXIVkRwcVnhwcYNrtE4il
	DyC5ZYfgc5hOlo5R0ccDeZRCoTj/NHKDsA7mR1s0pVHb2ldhfLrYtljTFpFhHr8h
	wPjvCa5yCcwWBbgAYPKDKN5Mgebyw/Btfw3vClloOKINxZkbJ7G3MJNeHCkOjwl5
	9kXbhzEsK6nO8GtRZ9B56oDi05LSCOcMU2akMGU4HAZRN+Uq2GnnyrsMJuGuqVta
	IB7lKhO1O7VKTDt47yOTis8AbQAgr/ZlgdFn11laYa83MKMeGtOZDztzYCUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760073755; x=1760160155; bh=vBP/zvsvvbsjX+ChlJxYLM+e15/qhch1qtg
	BJsJJ+74=; b=cFa604bmov8X6Y1y3cy+Ut0eAUu4KGxq8IxbUvqEvnT5Fcr5oj8
	8SfCnlyDE3dZ5RT+Fv5JaG4SRwjft0RHfwVmDRjfzDrBGgR9i2FpcA19WuUnk4aV
	whXqtW9BHV9NUn9jKnrP3xVBbPZqs8Q0X/T4o8PwAW8oRz0t0m3Gm29J2R9WlBPX
	gYXHfSPBOdeEVjNFHBpSBFxiYywhd8jSkMv9kDPVQAzNBeNDqYt3ZrHiIPMGIYsK
	jnol41mEYCwXZFHltyteG+GVwY/NYjHKxlDMeFc3v8Pk4nbi/g7Jbg/YveByMeck
	an24OkfPvCLVlHW3iL0M7b5gMKWzO11xn9Q==
X-ME-Sender: <xms:G5joaIveJVe0EBMbTY7x4VOL5zVsBIM_CeGkycEknuD0wHJEvxH6iA>
    <xme:G5joaHunAtKnPOTY3hFRPa0bsYK81ydfss8oQxftGaePkIcD7238U5gwljPeSCHdE
    v1M86mhBMBSGrRggAv7_tTEX7-4X6ARLlSFHEVg9oDMou237lGW10k>
X-ME-Received: <xmr:G5joaGCtQcjIILFaF6wlj9B1JmLKvQ6ZBjxIkoWnbEflkw0uswflLR28_nOBVa3FP1Eah1rmECUN-HvOi18m0-uvyMo7ZHBZWI9LhnrW-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:G5joaBOA6ui2fWWK6K7WmRrbbxmSpEe2JNm2nUSVgjk2YDD8LX7dzQ>
    <xmx:G5joaHxuIq5zao83CVh5OtWFLkOTCDcenbHEZ8BkGOWh-oe5ItxWGQ>
    <xmx:G5joaJXSicgyUlCEduXCQYFHuJBUY0SYor_jlGqiQn-ZQh-mcOCyrw>
    <xmx:G5joaBPjFgHGLBAE-9kkaFSKTXXuq0PHgElyKGPjexM66q2tNVrWHw>
    <xmx:G5joaHtbfZbhMsIncoI9uAux7FCv3GA4ac6WTiFACXDZDLECjKlg7ueD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 01:22:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33920dc2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 05:22:32 +0000 (UTC)
Date: Fri, 10 Oct 2025 07:22:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
Message-ID: <aOiYFPTNLL1Fgz5V@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
 <20251009053825.GB1614343@coredump.intra.peff.net>
 <aOdRsR-k77uTWJRb@pks.im>
 <20251009063956.GA1622884@coredump.intra.peff.net>
 <aOdjM8F6WvTEBIo_@pks.im>
 <20251010051242.GC1897715@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010051242.GC1897715@coredump.intra.peff.net>

On Fri, Oct 10, 2025 at 01:12:42AM -0400, Jeff King wrote:
> On Thu, Oct 09, 2025 at 09:24:35AM +0200, Patrick Steinhardt wrote:
> 
> > > I am not so much arguing that "struct reference" is misnamed, as that it
> > > is sufficiently generic that people will reach for it when it is not the
> > > appropriate tool. It is for passing the ref data to the iterator
> > > callback, but it probably doesn't make sense in other contexts. Would we
> > > ever expect anybody to declare their own "struct reference" in a local
> > > function? I don't think so.
> > 
> > Hm. The thing is: if `struct reference` is established in our code base,
> > and if it is a simple representation of a reference, then I think it
> > might even be a good thing to having it. I could for example see that we
> > gain more interfaces over time that use it.
> > 
> > For example, functions like `refs_read_ref()` could totally be adapted
> > to use the same struct, and I would claim that this is a good thing.
> > We'd basically have a single central structure that allows us to get a
> > reference out of the "refs" subsystem with metadata.
> 
> I agree that if it became the standard representation, then having the
> generic name would be good. I guess I'm just skeptical that it will
> become/remain that, and not grow gross appendages like the fetch/push
> status fields of "struct ref". But maybe I am just too pessimistic. ;)
> 
> I do agree that it would be nice for refs_read_ref() and other refstore
> functions to use this as a common type for returning results. Even if it
> later gained more fields that were specific to the ref subsystem, they'd
> still make sense in that context.
> 
> So I dunno. I could go either way (keeping your series as-is, or using a
> new name).
> 
> > > And yes, "struct ref" suffers somewhat from the same problem. It is
> > > mostly about using refs in one specific space, but the name does not
> > > really help clarify that. I wouldn't mind seeing that improved, but yes,
> > > it would be a noisy patch. I don't know if remote_ref is the right name,
> > > though (the "peer_ref" links mean we store both local and remote refs in
> > > it, IIRC).
> > 
> > If we decide to do it it should definitely be a standalone patch (or
> > patch series). I'm also open for different naming suggestions, but for
> > now this is the best I could come up with.
> 
> That makes sense. The only reason to touch it here would be if we wanted
> to free up the name "struct ref" to use right now. I think that is a
> better name than "struct reference", but given all of the existing uses
> of "struct ref", it is probably not worth the hassle to switch now.

I think I'd like to avoid doing such a swap in this series, as it may
easily cause confusion and create problems for any in-flight series.
From my point of view I also think that neither of these names is
clearly superior over the other.

So to move forward, how about we land this as-is and I promise to follow
up with another series that:

  - Renames `struct ref` as proposed.

  - Introduces `struct reference` into more of our APIs?

Thanks!

Patrick
