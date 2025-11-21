Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E53532F76E
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706802; cv=none; b=dVevEZzqEaQ6iZsbqbyD0lfZi+jGz5Zw6MTwDU7rO25CKRVAfkxrb77+gqZu8SvCEPDKJ/XgsBPSGvJTgjhfjsw1Ofke58QT0KIyWCPf4tBdYZWgYorHp8hQ5MXFF7TdpcbDxkWF2txBGDsPUirTcKITQ1bcXqujLsZXMZuOi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706802; c=relaxed/simple;
	bh=JaoxtS50ZJDPwNpZIHdaq0FH25bKYl0/1iJpSdt71Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJsfGpdO658UKl5ui3vUDoKq25Nod/HWxNdKcv51yfAnCncNoFDG+LhbUeL/ppcn9nYZV6FPLJZ6XB9pA+WYdIsS0hkH3TwCOHT5SJIhUPGXxxu9L0UKKhAZJZ/UW7jvzMWKbMNqXXb0LjwGPTGoDSntUfGe8dTJv1sCE8FVavI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FohoiZWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k1tOkR0i; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FohoiZWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k1tOkR0i"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 489597A01AB;
	Fri, 21 Nov 2025 01:33:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 01:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763706800; x=1763793200; bh=1F1Q7+haI+
	lhZ7jBwmtKyYmtyo5zXSSD9/N8PMMUw1w=; b=FohoiZWlTh7Z8DRuK3/CXlvkBU
	Dz/M7SXPO7UV9mTmPP1mDz03Qf8rZ43x2nwlTL76WFd4Zx/DCe/9B+22SQXLQ+iD
	xamRv26MB+wX+kD8dIkUyAG8wFuEaYdQUpauOktyl+MimCUYaIK3ffwji/buK6ho
	pSLlloj7d0//T1A0qrn8yZ8AQ8S7FmnUvJ0o2P2rQlVZp0Uymqgr+uhsO+paF/YB
	KVpKmeEro7u5GkKvEqqxPbFJHr1AEMqI/Q1NHtgVYnCef2qAGxb0t0nx2fhvmIQ4
	0XJq8enhvh3okqt5vXF1I4LekUUAeg2aTAzpfTGyBRwuG6FIDn5rek/kTWMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763706800; x=1763793200; bh=1F1Q7+haI+lhZ7jBwmtKyYmtyo5zXSSD9/N
	8PMMUw1w=; b=k1tOkR0inIoX16wODdnwjLHaNnSFF92qSs4TzQJXqLj8i5nmgnI
	4h9eqbpxj2tUgbX3QBXu3BjRXKj2jrDtAngIf3JS0rqJyZhYpvlQUUvsnt/vbhfG
	kOAxowdS3EQ+Z+k+4nB/SG+09yjKlM1RVXaA/0YpS0LrMWnTjbcpV3bODCAUNFY1
	SPeZyOI7Fs1hRtxPsVGdSo+oVimL5rDzJWGEtqsNUQo8IWzH/jIaCW1EATmeR5wI
	vvqdorvTEDuRBJ6yVij1iwqlPndtqNmLS4qSVD8ouTiNLNhXBOSC6ldwViAWyYZz
	Ef//R5kyMzQr8nOAPCrwztI/h4SAjr+kW+w==
X-ME-Sender: <xms:rwcgaVkjpdciUGq70xm0-nnEjdm6RDlrm2aldmavtGEuugo9yOCP3g>
    <xme:rwcgaW2iscs522z1KXoOwQjbaOKA9Mph8oKZQpLe2fmWyUlLbN8znNUqZGz6sQpkW
    2oeC5fGv4oiJm0TadyovVnMhWBcKKFmsU6eUM9BF5IjdukSUG6DHA>
X-ME-Received: <xmr:rwcgaZQMVcn18PENf-TqzkEOby3cP7Jqzc9fMi0GrP44yrfxjT0Rffx4dbMJhZ1vu8TJjG2ifdSqWlsUebYTNF04X49hloHGlIsnVrUAsI5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rwcgaQuczTrGkBBweBOIhCQ2v5q8RD9CxIDkvlT4vX9jCBgu7NjCXQ>
    <xmx:rwcgaWbQpxER7epr-nQlrYSwRpybivWwvnfkRBJgWhH1mulr-VpDnA>
    <xmx:rwcgadtKT3nWeT8UsGXQgD3hZegXPWcQU6bZfZ_LQudY8dN7BCqSPw>
    <xmx:rwcgaQFUfKskSJP095aCh-0g3zSw7bELqAI8W7soRcDDudleIWzrKQ>
    <xmx:sAcgaeXrfKhEaIR_kBdexWLBWK0MS_7vFy0AG_xUZyNnPUpcT-mo_c5t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 01:33:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e361bd1d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 06:33:18 +0000 (UTC)
Date: Fri, 21 Nov 2025 07:33:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 14/18] streaming: make the `odb_read_stream` definition
 public
Message-ID: <aSAHq9_Wa2eXko1R@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
 <20251119-b4-pks-odb-read-stream-v1-14-adacf03c2ccf@pks.im>
 <CAOLa=ZT_VFfbfLVdvHUqK5C6k4zROLQs0Pt5rOWL_hE_BSfGeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT_VFfbfLVdvHUqK5C6k4zROLQs0Pt5rOWL_hE_BSfGeg@mail.gmail.com>

On Wed, Nov 19, 2025 at 11:27:29AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/streaming.h b/streaming.h
> > index 95c2a434fa..3a850e3efc 100644
> > --- a/streaming.h
> > +++ b/streaming.h
> > @@ -6,11 +6,24 @@
> >
> >  #include "object.h"
> >
> > -/* opaque */
> >  struct object_database;
> >  struct odb_read_stream;
> >  struct stream_filter;
> >
> > +typedef int (*odb_read_stream_close_fn)(struct odb_read_stream *);
> > +typedef ssize_t (*odb_read_stream_read_fn)(struct odb_read_stream *, char *, size_t);
> > +
> > +/*
> > + * A stream that can be used to read an object from the object database without
> > + * loading all of it into memory.
> > + */
> > +struct odb_read_stream {
> > +	odb_read_stream_close_fn close;
> > +	odb_read_stream_read_fn read;
> > +	enum object_type type;
> > +	unsigned long size; /* inflated size of full object */
> > +};
> > +
> >  struct odb_read_stream *open_istream(struct repository *, const struct object_id *,
> >  				       enum object_type *, unsigned long *,
> >  				       struct stream_filter *);
> >
> 
> If we're returning an `struct odb_read_stream` anyways, why take in
> pointers for object size and object type? They'll be the same as
> `odb_read_stream.type` and `odb_read_stream.size` no?

Yeah, they are now, so we could change it. But I wasn't really sure
whether this is all that useful in the first place, and didn't quite
feel like doing another tree-wide change.

But I did the change now, and I think it's a net improvement. So let me
add it as another patch at the end of this series.

Thanks for your review!

Patrick
