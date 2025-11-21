Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934EF32FA1D
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706773; cv=none; b=CzgfjH0m9CmxXWZrxQ/Pi+Os/Dhy1LmQqq4RQjGVzeeVwcVEjabgtWsOGvnqLjJOEWwqjg4jo6DwLPrBff2nwBVqP65jsOezVVxKzKoHlw94OK5qKQfLyI24DET52JbgprD3+4XIapFmkcuGfecniuwTGwnbx7q1+CEjDAx276M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706773; c=relaxed/simple;
	bh=xOdc+HsvKqhvruwAIFKwePYmsrjNt+nKHwAKzte537w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8Yyohug4NKeTBtJ5dzhFbYXRmB4d/m/F8PAO/twObQtsUcCFz5crEA2i/tpP97BvLLz7WFL/PR7LGO5kJQE1jx2tVyqMinyUCwSEmPi7TtN9DEyqRg89o8uuUz7QUtFVlz4t/kUYyi58YnswT/gEhsJ3OiKkKaurpgn1gE84+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f29IoghW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lmczp66d; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f29IoghW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lmczp66d"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B50567A01C1;
	Fri, 21 Nov 2025 01:32:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 01:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763706770; x=1763793170; bh=o2J09VXpgc
	e2Fx0ZH5izSWYFfr9tq6lS2s+dh47nqSA=; b=f29IoghWCnZyxCeQLA7Bv2mOOF
	hNhg38h7VYbVnsTXURzfWrZqaifap3euOAQp8Mp50IlHneGnawUWiC2mrRj+mZWS
	myuVPktqyyco/hIGDVdP7gfKxVhpywSeKP0H5x5+SK4BotsrvxSdB3NwBclH1Y1T
	cfhiW8kpO/32w9eb1sJY8KEYPJuO8QELlt9kfPcIeq6T+UYglO1EBbwSkBVLu+a5
	pkAzFyq+ntJmromkPc55YseW3lqiOm3mAXoDsiq+iDOUceS7eD9d2kK80hUNGwTv
	QM6ZJ8M0w6/xQySTyPhHbseNGSseX6aeawjBpkROfTxQ0y8i+E2q2usyWk7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763706770; x=1763793170; bh=o2J09VXpgce2Fx0ZH5izSWYFfr9tq6lS2s+
	dh47nqSA=; b=Lmczp66dHVLr6hu+7LsNTYKehoxMvh3oL19BBk84XoaxiU5gAGE
	Z2Hnj96l8Sb6MEDgE0GNsNK4LTS9Xzmn9E8DFWH0PZHirbA22Qoakiv7b2UElm3e
	OlVeyx8MmncEKb1UZmgNyzqPVIc+sb1iNguv0e2hpzP3wriXpHgUZ1uIlFcrPfxg
	LOBJUg7XtZKVbGqLVOu1ntHe+9MMTYCJ2qaFQXsMKLm2Alq4MPPd5PVJ4p+hkQEO
	dWkETeEZruBUADX+aER8wHFwie7R/nftbFU8LcVtSmMpNvucjEJkqOiplLPtTCEq
	hFtVUw04D3sH7CP+ARcFOPfoRH0Z8V20UHg==
X-ME-Sender: <xms:kgcgaV0oDj3bd9YBn_LYgI6_SAEjlvzla6MogE1Znv3PpO8D7W7DJg>
    <xme:kgcgaSFdmmudvG2YGfFD5dSLXp6JT62Pp3nuKOR-VY0P_xIE3F0Wh_Jpsd8SdIx2A
    PIObaCjx5IQFWIU_tHln3hsEiRy26KyHyBdG6EScdhC2AixtByJ5w>
X-ME-Received: <xmr:kgcgaThDGi1Lc7kLi_yWqbIuyzGh4z0iUWkM4xfMaMD8L0fRTMUb8mQCrh5VsbXUuLs-WqbM794u-0sY7l3q5032GUmXkAE91JoRlaiuWgQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kgcgad83DXytlbDvKNUw3cIix3ZJsYp7VYx8UZmXILeDvgs0Arldww>
    <xmx:kgcgaaqhLX-2m4WIeTrDGn3BRX92ZVK8XObYup3ddLPxVMRTFcn7cw>
    <xmx:kgcgac98_DcSB5q3PM1TrsqyNs6OhhofIVfeUXaq1FKZM2kFvMOguQ>
    <xmx:kgcgaeXQCxuVMi91QW79NesP0HUeG5WrMXYQpWC8mX8LtdA1GdbyCg>
    <xmx:kgcgaQUU7Dn1yQDf7lBy6vgM1nMQjKVlUBsYs2x3BAUTnbof_bif8doD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 01:32:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e477806 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 06:32:49 +0000 (UTC)
Date: Fri, 21 Nov 2025 07:32:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/18] streaming: allocate stream inside the
 backend-specific logic
Message-ID: <aSAHjQKO7R1TvPgj@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
 <20251119-b4-pks-odb-read-stream-v1-5-adacf03c2ccf@pks.im>
 <CAOLa=ZTF+xzhZv2yXp8L_URk8cjscycheD=Xgdxd=eRGtvpt2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTF+xzhZv2yXp8L_URk8cjscycheD=Xgdxd=eRGtvpt2A@mail.gmail.com>

On Wed, Nov 19, 2025 at 02:11:40AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > that is specific to backends in "streaming.c".
> >
> > Ideally though, the infrastructure would be reversed: we have a generic
> > `struct odb_read_stream` and some helper functions in "streaming.c",
> > whereas the backend-specific logic sits in the backend's subsystem
> > itself.
> >
> 
> Will this also mean that we move the backend specific functions like
> `open_istream_loose()` away from 'streaming.c'? Let's read on.

Yup, exactly.

> > This can be realized by using a design that is similar to how we handle
> > reference databases: instead of having a union of members, we instead
> > have backend-specific structures with a `struct odb_read_stream base`
> > as its first member. The backends would thus hand out the pointer to the
> > base, but internally they know to cast back to the backend-specific
> > type.
> >
> 
> Right.
> 
> > This means though that we need to allocate different structures
> > depending on the backend. To prepare for this, move allocation of the
> > structure into the backend-specific functions that open a new stream.
> > Subsequent commits will then create those new backend-specific structs.
> >
> 
> Who's in charge of free'ing these structs? I see that `close_istream()`
> calls the assigned `close()` function. So this could be handled on the
> backend level. But it also does `free(st)`.

Yeah, this'll be changed later: the `close()` callback will then only
close and release the backend-specific data. `odb_read_stream_close()`
is then responsible for freeing the stream itself.

> > @@ -338,12 +354,16 @@ static int close_istream_pack_non_delta(struct odb_read_stream *st)
> >  	return 0;
> >  }
> >
> > -static int open_istream_pack_non_delta(struct odb_read_stream *st,
> > +static int open_istream_pack_non_delta(struct odb_read_stream **out,
> >  				       struct repository *r UNUSED,
> >  				       const struct object_id *oid UNUSED,
> >  				       struct packed_git *pack,
> >  				       off_t offset)
> >  {
> > +	struct odb_read_stream stream = {
> > +		.close = close_istream_pack_non_delta,
> > +		.read = read_istream_pack_non_delta,
> > +	};
> 
> So this is now statically defined. Won't this cause an issue?

No, it doesn't, as we eventually copy the local stream weh ave here into
the allocated `out` pointer.

Patrick
