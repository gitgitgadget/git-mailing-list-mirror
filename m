Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991952D8DB1
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728895; cv=none; b=Iv9j0G9wr/EySUtniNTJTcb2si1Zt78Hg7EivpPKLEqOWvTXLfsj1NFuwDRyTFsfjQ+dJj1F3eS2PUDv/jQFMXh7lf0TS3ptJiaJA/W/7Ed9F+tvb2uY36HxrAiV67aAp2p/QAZ1etXSguhVBLQp5KVlM7pL2Vf/s4PDYXRAqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728895; c=relaxed/simple;
	bh=Xk/asF+a9CFh+TzV6WR9UyHt+6lfp6K3KAc6TF30V/o=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA4oV2ni5yIzl2JHq0SSCHGl5XgKJGepYEa5O7m8Ea/oW10EUqKILQmUyQKGEG+zSI0pxjnhMrW8lpKkXPRKKh6sz+OcsYs8/Ki6wrFWL0xy9DhoGGM6ac1OEkUt9LrL/LCzXTNAHZump6b9RRdNKr5VuAiZS+aKxr55460SHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jrVTbD14; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V+rmXuoO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jrVTbD14";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V+rmXuoO"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C62BDEC0304;
	Wed, 29 Oct 2025 05:08:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 29 Oct 2025 05:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761728890; x=1761815290; bh=xUV0pOUSQe
	6KaYNjkboDkNkF6ROIkWLOyAgggyIyMOI=; b=jrVTbD14lnmxlN+xSSwxkJlcmX
	VPBUGuE7xeH+F4vi6Ha1yBEWvQgqtvomCE3223B7zfI3/5jf0NhYCDhpKoUjkwOc
	t9Xm88wkCjuLi0Xvalu2hgKHQ0h//RWoMkIpjBnEbx52D9AU0ppeBaAeK4fQqAuD
	qvmBSJak3KLvcFODIYHgKnsHA1oYGdrrUzHVXqtVHpbqBkjn0hVNUmpPxjjFhRyr
	lI6f3G60/gsxHSyjoq0q4Z+MNl39GDKURna8mn2Vw1naGs3UKg5arHoW545yQPSA
	AmcUALUnniMUelpZFT6iUWnwFMlQyr3lKmLY0bcrDK13gifLPvIN9upP4gZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761728890; x=1761815290; bh=xUV0pOUSQe6KaYNjkboDkNkF6ROIkWLOyAg
	ggyIyMOI=; b=V+rmXuoOo4QK9hbYmCWmMGya1kKelGgM8R0yfxZKlpnuxGc8tIG
	/tmMRYnTMmz3ApIk5DBWZftMprpE9K2hUWBUw5s9adHwO9nKUPG7Cxy5RO6wXjGM
	qp5is+DDWog8d43ULOWM0jumDbUTVOh9vNbPuT750FgqqJMW2Q4YiHxhavaMUd26
	g98sQktxZ3WD8fBo/6ZRvLnVhpVbMspFo6lleixAnLUcLhSVkFep9RiJbyQB34IK
	3wAEQCGzFb+k/XT1cHj0Q25+GPP+NbsgwSqmM6OB3XXcskCyNhJirse0J6whLuv3
	jwIcrL8JOdM/AB7c8QY3QkfQthQdlPZpSgw==
X-ME-Sender: <xms:etkBab0PCPeZu6Y12rRMNEHKIUELujopxo8pfvs6BTY-BE4kgdFmTQ>
    <xme:etkBaRFC_Teh9LC851SnUWY-yO6mLvnhq9VTpHQRpo1UxPWofz5yEIYGOJ1anWWl9
    f3saLwvOssUO3opN_DpiJPMefOtlz1pTUrCSLasrkAf7ojnXNUqdQ>
X-ME-Received: <xmr:etkBaQ51xnOPiej4GE1_to57mvQSLYfAI62u5iJhEZnCY_0VyyuTZFAlCwrBTCYllDebvUsuS7ul0xXH_OLg29ZdIoyNLVeTY-Z_zwN5PLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ehkeeffeeggedvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnh
    gurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:etkBaft4sn6-sHaYrz60hm74G5M6h93al_tj6jnoTtYObK8KEBNVgA>
    <xmx:etkBaZ46VCn8WvD20_gcraXwIlEjtUwGbrQIkXkqatNWlSMYtk7aMw>
    <xmx:etkBaSU3xaGfOTOHpy1Nd8LHALjijY-kT8iG6Z12eUVEAsks1I2FUQ>
    <xmx:etkBaT_MioRWKQ7Ln9Gnj1WPrcw2RtySNCKaCLqc78KdkgZC7R14vw>
    <xmx:etkBaVrO117ZX53SZ0QoXQ4rhY2RGsY3wwo-i_H63ve_yJKIrCyoXyju>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 05:08:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 781e90c0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 29 Oct 2025 09:08:08 +0000 (UTC)
Date: Wed, 29 Oct 2025 10:08:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 04/14] rust: add a ObjectID struct
Message-ID: <aQHZda5I0JPSRwv1@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-5-sandals@crustytoothpaste.net>
 <aQCKD--ZmKnwBWs9@pks.im>
 <aQFhpAinB6HLC-Tw@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQFhpAinB6HLC-Tw@fruit.crustytoothpaste.net>

On Wed, Oct 29, 2025 at 12:36:52AM +0000, brian m. carlson wrote:
> On 2025-10-28 at 09:17:03, Patrick Steinhardt wrote:
> > We typically don't have these headers for our C code, so why have it
> > over here?
> 
> This is explained in the cover letter.
> 
> > An alternative to represent this type would be to use an enum:
> > 
> >     pub enum ObjectID {
> >         SHA1([u8; GIT_SHA1_RAWSZ]),
> >         SHA256([u8; GIT_SHA256_RAWSZ]),
> >     }
> > 
> > That would give us some type safety going forward, but it might be
> > harder to work with for us?
> 
> I agree that would be a nicer end state, but that can't be cast from C,
> which we do later in the series.  The goal is to have a type that is
> suitable for FFI between C and Rust and we will be able to switch once
> we have no more C code using this type.

Fair.

I'm mostly asking all of these questions because this is our first Rust
code in Git that is a bit more involved. So it's likely that this code
will set precedent for how future code will look like, and ideally I'd
like us to have code that is idiomatic Rust code.

With the FFI code it's of course going to be a mixed bag, as we are
somewhat bound by the C interfaces. But in the best case I'd imagine
that we have low-level FFI primitives that bridge the gap between C and
Rust, and then we build a higher-level interface on top of that which
allows us to use it in an idiomatic fashion.

I guess all of this will require a lot of iteration anyway as we gain
more familiarity with Rust in our codebase. And things don't have to be
perfect on the first try *shrug*

Thanks!

Patrick
