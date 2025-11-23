Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7F15ECD7
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924377; cv=none; b=QjrHVGtxlIMXh13Xzrepik2+5dIUGjVUSarHfOu89y45Gsi+9nPsPNEcRNYa5Uv4LaYSqSVmibQ8gtMmyiusObCeoU1lNZcU7CGOAorjBp6bPqryUKjANafo/zyi3Fgj4WE5uQS41c66XC3bRxed79rf/qKHE3a1yTPIpgb4u48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924377; c=relaxed/simple;
	bh=ofapga/jICLa5OdmXFxj57FA9dlHSb1bV9pE8eFKUzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKW9G/3SGUPoOdnKwiMqzHGF4+mMnKJ9O0Jm3gpc1OHdoumV8YLip0r9tMxhqTsYwwdl1LvMFI+EMaKtTehkK9N7uQKyTmUyrqXZ/aF4tPr5SuN3pXhqJBQWdHt+vNFRuW+YP6R+rEOe3QxOXD6K5jYGyMk3DRyOjlM1aI7I93c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DzyFIWJY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wdgkq7QW; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DzyFIWJY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wdgkq7QW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 896A27A0091;
	Sun, 23 Nov 2025 13:59:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 23 Nov 2025 13:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763924374; x=1764010774; bh=ZwzW7JkhET
	b9fAs2SViXiDStC+M7+srdbXEfR0b9qWw=; b=DzyFIWJYorCneRc5McVRRa9+9V
	iV9Km96hrurvCMoNgukhFzh6ZciNh6r/ZV4zVcbbwlN6NA0+hEu0i/wYnUsC9OPT
	WOBibZ7KOBukTvn0uUS7Ml1ldh1ftRO895mXyywDP4M4aJ1klAKwb9HuUNaSFmRg
	4ojtULV+2W0Lwx0IW8DFy2e0J4nD69JOIMY1PoNGNgLvHK65hSVm2rbEMFE8YAGA
	oddxj7sFSDsfSMUaseILC4xeAB7yEew6Tp4vdhjwcW6ZWnRAvcYdXeqTsmR7JF+5
	qRjD9HTu3lIJY49D2MSt2ZegJrK4CuVJXsn7CsZIVYX/nFlVnPe4hveYa5BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763924374; x=1764010774; bh=ZwzW7JkhETb9fAs2SViXiDStC+M7+srdbXE
	fR0b9qWw=; b=Wdgkq7QWK+ubxiQKlURO/uWYFWO0P4qALVQTxYI1x8i1PurkIqL
	5xqT0EbTbmcQCNxkWy3VajSGEP+voPrM5jNSfsVGuuvAE8IlLXp+Oe+S4VE8fquY
	XxgdcYAItX7nB+PQ5qZDQAEm3LLimR9QvQ0f1pHv247/8DZx6wKaWuc3bkp6cldd
	wBqWmRAqm5lkZPUWD1imdrzQJQ7sPY6DREy58mIYZpSgi6Jcfw0WMPh2Ml5JTz7b
	dqMUTYAtOvdJ4OIye4DH6mgI/6xSWbZsFK3n7llS/gvLNCpH7dr5vjbs+ExSnfGI
	LL9UDPc5/+1ymPwsRp2s+dQyb8L7XoYZlgQ==
X-ME-Sender: <xms:llkjacqOwzQPDniDDQhbj8OTMrZA3R-5riKIEz8BDC6Tb7j0gdNCSA>
    <xme:llkjaZoI9Fp6evAipzcqmCeOLutkaEk9Pn5w9Rydle-kg8GmpVG673dcIrvzI1kDS
    CxYiC4hmpkuq3TFQH0Lx0fWUrMzqyTLM2Dmjo47JRpzZATOLYl0KA>
X-ME-Received: <xmr:llkjaWMThOGCKb36qTlB5Y3WubD1giyOqUtv95xbHBJGv_s4pwSQaITH73syuFFkTCOLFeIKNfJ3NSC7DOqH0UwlQ-QUFT7Uu5FqQGpF_gRUMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:llkjaSxBC0HOCy0AN9ZR0_2jt5jUzDOqf6eb2IUurkzTE0OJ4SGJKg>
    <xmx:llkjaXt9KbgbzRp9XWOPJZl_4wisB1kJ7AkzLyUowCmy_pKpMA8Ymg>
    <xmx:llkjaT49YVZebwQ78gCFQvVf93TRpiIdayvj2gmRoQOSz3EIspAwKw>
    <xmx:llkjaeTaf-WsHCw2Ztk1F8UoZxuwDHnctDbLMRKzCZMKWk93F8p5LA>
    <xmx:llkjaVszeasz23NOhIwTHEGMH8jllROVvBUimWrnUb3oIrCZTO4oc_-U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 13:59:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 181b7d0e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 18:59:32 +0000 (UTC)
Date: Sun, 23 Nov 2025 19:59:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 02/19] streaming: drop the `open()` callback function
Message-ID: <aSNZklOl98TYRTUg@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
 <20251121-b4-pks-odb-read-stream-v2-2-ca8534963150@pks.im>
 <xmqqqztr45t5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqztr45t5.fsf@gitster.g>

On Fri, Nov 21, 2025 at 10:08:22AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When creating a read stream we first populate the structure with the
> > open callback function and then subsequently call the function. This
> > layout is somewhat weird though:
> >
> >   - The structure needs to be allocated and partially populated with the
> >     open function before we can properly initialize it.
> 
> It is unclear what are left for delayed initialization from this
> description.
> 
> >   - We never use the `open()` callback after having opened it initially.
> 
> I was not sure what this means in v1 and it still is not clear to
> me.  Naively the above reads as if it is somehow desirable if we can
> call open() after we have already called it on an object.  The flow
> being a caller (e.g., stream_blob_to_fd()) first ask open_istream(),
> which calls the open method after figuring out which backend knows
> about the object and how to open a stream on it, I am not sure what
> you want your second and subsequent uses of the open() calklbacks
> do.  Puzzled.

I actually mean the opposite, so exactly what you describe: why do we
store the `open()` callback in a member variable of the stream if it's
only ever called a single time, only, and is never called a second time
thereafter?

I'll rephrase this.

> > Instead, drop the callback entirely and refactor `istream_source()` so
> > that we open the streams immediately. This unblocks a subsequent step,
> > where we'll also start to allocate the structure in the source-specific
> > logic.
> 
> Because I do not think these open methods specific to each storage
> mechanism cascades into each other, open-coding the logic to
> dispatch into these open() methods in istream_source() itself,
> instead of setting the method there and then have the caller call
> it, is a perfectly fine simplification, I think.
> 
> > @@ -478,19 +477,14 @@ struct odb_read_stream *open_istream(struct repository *r,
> >  {
> >  	struct odb_read_stream *st = xmalloc(sizeof(*st));
> >  	const struct object_id *real = lookup_replace_object(r, oid);
> > -	int ret = istream_source(st, r, real, type);
> > +	int ret;
> >  
> > +	ret = istream_source(st, r, real, type);
> >  	if (ret) {
> >  		free(st);
> >  		return NULL;
> >  	}
> 
> A patch noise?

Will drop this line.

Thanks!

Patrick
