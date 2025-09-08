Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6E747F
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313867; cv=none; b=MNN3d/nixuKbhdh523rYKFK1vweNUtF+/EzIIA1a4N5Dj7BD+sIFFYYnYUCct7/XlwwFmIYE1IhE4WhHgDD3O5Ml8LD/wHjEI6Mz9ewKC9OMaJbZNt8aLyy2uHbVs0yOm6WVqEZiJquOuIUqGpArurkeuIBHZEx3MMnySur3qQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313867; c=relaxed/simple;
	bh=aqUdKRMD/PgYmckNnBG0Yog+cpN1yVEjIIlMtA5/5wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOAvZ1ukV/Jkr3mtSKtFG62go4ZJ074zY3PF6zOdonxXqNTZBhz2wU98xrjQaUbMoCZqHRehrJydrS0C4qgsVI9QyK/DvXzpcjdyOlShqRs4XW2YoToUMc7Zj0EeKxDwJjlbS6ya7mQ+OJY+TuLZHBvfkwTDxeQRxQXP1gKjVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qifC1M5l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UfdObivU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qifC1M5l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UfdObivU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 421427A0030;
	Mon,  8 Sep 2025 02:44:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 02:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757313864; x=1757400264; bh=YkkKFA/UJ+
	RUyysp7u3SWK/iOgycINd0hJIM+XzOjsw=; b=qifC1M5lrcphpfI+owJ2DiKF+U
	ZPMb3nhCr86ppzD02kWq3bXASKBKn53/FQLxCSk/7LwmwplLjNylCRl3Zv1o7dW5
	sL66LQNsuDDRYZjh7WT0L7w+HIYddcUKDkaDG6nuavLcu34ejKLVSefEfZEFfipP
	bv2XAR/Ri6qFDX9wDTbDdVtKyRbci8EDig0oHi6aySjUhbIejFQ0IdtASd8i9AmJ
	u0YB2UI5W37G5NUZIal29n/2nrQ0qYEAALrPLO7tZJC40KdYnHFMIlNPyY9ZhV7I
	Scfdmzlx6onCTIOs0BhCEOnYnnYMKT0CifydJ3Q0xcB18u+NCuTvSP7vMHww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757313864; x=1757400264; bh=YkkKFA/UJ+RUyysp7u3SWK/iOgycINd0hJI
	M+XzOjsw=; b=UfdObivUQXkwCIKG+L5Tp0Go04ray+Reh1jdffw+YdjLm+WtBxP
	y4zMOn+eiZZv+RqAKgFUUm1ggkXv44Lhrz7KDtRVpv9Zqt+4clYsEV9xF3q1+X2d
	Y+aWnvZdzQOyF1Z8j9w+SFeYB/add2OtCtwV4hD7kHLFy5Aded0IYgPSVuP170UP
	A/FNyTys4IwkvU/4+1/9c1tPta6YT5TfLFuYV7SOny88y/0YHI37q5iOp9ly+Gdo
	Crbl5KWY5S2uPQJo8fUTs6Oz1GpNDs6jGp0PZHRlzQ7Qu6zHN9OKA4YZZpO7mumZ
	PMogtCGHUMleaoicUirrFVrLL0XFXUJf6nA==
X-ME-Sender: <xms:R3u-aI8Xidgl4q6TO0Zr6NFJEbqr3cVZ5A6JVSkVzaFbNWAyK6CG_Q>
    <xme:R3u-aA0TGVqPwF4ETWb2p1LWjiUCzUzXzV4kj0d93tTLObwg24ywLAuXk7L4FAqaH
    p9yPCDnFQelBVUblQ>
X-ME-Received: <xmr:R3u-aFff-0BlyeSMOhdDGCwC6lznJUDzlPLQJ_TeJtseiHuh3btRBfMZGo-2cb7Z9KLjalk1OjzC9a-1uEWyNm8Mo6SPvUmXB8XN9iHiZdUQHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:R3u-aPDh4PgZgWZbcb4Iqg3xxANQSdBGDv-rTegT3Rtq3bXDKuMRCA>
    <xmx:R3u-aE_3ZIengoowZpWxVYBrI_HdmqkfcBPwQ8lyid9XDPU3NwE-LQ>
    <xmx:R3u-aLpLLW-6LKyt7aQ9kWcBeEu6zc0lp5jG1c1MEZur1Or4Pg_kUA>
    <xmx:R3u-aGHNdFcMn0_dx0CScVjrQJK1t0dxfVGWfWFfp6OY5la5xPHmsg>
    <xmx:SHu-aDpxJCcdt8fgMbORD9pdU03nQzDoLyAA8mzhcR0iYg43NZnKmfm4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:44:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe2791fd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:44:20 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:44:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint"
 subsystem
Message-ID: <aL57QdS2DAFUOgsl@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
 <8A7DBC60-286A-48FE-A3D3-CAFC11FD3AEA@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A7DBC60-286A-48FE-A3D3-CAFC11FD3AEA@gmail.com>

On Sun, Sep 07, 2025 at 04:07:17PM -0400, Ben Knoble wrote:
> > diff --git a/src/varint.rs b/src/varint.rs
> > new file mode 100644
> > index 00000000000..3d41760a555
> > --- /dev/null
> > +++ b/src/varint.rs
> > @@ -0,0 +1,92 @@
> > +use std::os::raw::c_int;
> > +use std::os::raw::c_uchar;
> > +
> > +#[no_mangle]
> > +pub unsafe extern "C" fn decode_varint(bufp: *mut *const c_uchar) -> usize {
> > +    let mut buf = *bufp;
> > +    let mut c = *buf;
> > +    let mut val = usize::from(c & 127);
> > +
> > +    buf = buf.add(1);
> > +
> > +    while (c & 128) != 0 {
> > +        val += 1;
> > +        if val == 0 || val.leading_zeros() < 7 {
> > +            return 0; // overflow
> 
> Hm. I thought overflows panic in debug builds, in which case checking
> afterwards is too late? Does unsafe change that?

I've added a test now and made this an explicit `wrapping_add()`.

Patrick
