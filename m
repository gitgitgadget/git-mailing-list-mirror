Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450415ECD7
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924384; cv=none; b=u5nvLf18hxd4aIB4iYm9qQgZ3MZiRc7aC0Hti4LUmJb+CmTRG8dyftvz6V33R646W0SAOWi+WIL15pqYz5ZD+AJslU8UAIwAmyT1NTO4P51fKsiXdPKRQdCZ0w1h/hPSpFn5A41sQ163ETviu498EG2OiiqNWML3HJJbvL8NwzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924384; c=relaxed/simple;
	bh=FG3dpfTBpvcTC5cMxyU0Kp5f0P7L0unqD/WPVtARpbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9M7xY89UIOnHeSfpUAoglyGknWiHkwkUCkB8eq038pUyeAwinOzZQ9HV0vHmAp9/k2P4tzCjtnVEfUAB7cj82NWWJL98ZUToPinKCz9b0/pGZ9PAzlZvsKrel5B2e/yjGjMteWc0kfVlgWfUbTYvY7+DiXdBdBN4Dov5ZxVhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dHcIl0qU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aceKYYin; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dHcIl0qU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aceKYYin"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0D59C1D000A1;
	Sun, 23 Nov 2025 13:59:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 23 Nov 2025 13:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763924381; x=1764010781; bh=wEksO8lkqV
	o/PEzumwqglTKQNHHeDpRMSQaR/9ouWLs=; b=dHcIl0qU4eTito1vIWQF4wcUPs
	j2mszQtZRunAaNZ+8j8BaVQmWGniSoM2nFV8NqbGjipNZFz9IX6J4ybo57n0y192
	JLDgBa5UK8GI/ZlD39QXTs62DUsarcdwuzgPw52MkVK016BLUmH18qTqw+/KGy99
	V6f3/XjNMdTC0IsiSwR0gEtzQQy1vP3Tpd8VS1kTEK7/AxpcZOSSDcQ6TI2QojsG
	9I9imNzwFDIqr3DQuGE6ndLHlVHYRiSYNtfcXt4SQBCifh+IxeQ7H4HWoqGjy/f+
	lol0AcUlbdppaxE92KBwmvZe4SoTgSRGsX6S/02MHWcYjbYpxeExxU1ru0pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763924381; x=1764010781; bh=wEksO8lkqVo/PEzumwqglTKQNHHeDpRMSQa
	R/9ouWLs=; b=aceKYYiniD9gVFqrWu7sdjr+C6LChpGM4HFCTXqeNyr8xlarkWd
	nSvnHZTRzRqtewTHDVp9+PSxSeAvTlwiara+vRJ4lxws80H4xWIE/K2MR7+jDeLS
	NrxWhBk0fDP/VtVsKaIQK1y5O6UBoZdR6CNT0i/jritYRsPPZepqfoXeiSzmqQ9c
	F47/eC7QFIhRixVj7SCogsQmKtbY6dq0Fh2y/7oKLZWOrGFHSbGpcoGuYlKFdiYS
	0XVpr02XIVgB3ReT21+tGUra+JuZJi5YeTTavj1nbFEW5hjb7Ah0PneRgSfMKzWf
	VlVm00nCvxuE0EGPajyB/YOVSZ6yiR0EA8Q==
X-ME-Sender: <xms:nVkjaUMv8zGw46-wLx3b6vGaqvZEXw68DK1cvGKF4Wk46SgT7zHZ9w>
    <xme:nVkjaR8S9M_cnTXS7yj-VFdGg97kP0xsHdFnf5N61YHmzN81xGIXZ3kAXCiAa6nyh
    iseWs59un4ryz4uAgr2eGBqF-AWfc2znCCWJOEhUVNHHzaGl9SWDw>
X-ME-Received: <xmr:nVkjaQSfsddBCctIL8v6UWQIKl7YiwQ3msYmJpGYFHlFwtQZXN5WsJt_WOfh1FxibM2hwp64IqItPCZg5xe0lbAYBRN_b8vFSJvj2c72cHkwTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffefvdehvddtleffueetgeeuleevleegkefhuedtiedvudelhedviedvjeejgfffnecu
    ffhomhgrihhnpehprggtkhgvugdrihhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:nVkjablaTlTOsqGuQBVDMBKjXHz0SR-HpdswRCO2LHMNOTspvPK6OQ>
    <xmx:nVkjaYQMrAjo5DA4oynh0Q37va4UK18o9_2NOSi_i_dBeuSgHVii4w>
    <xmx:nVkjaRM6xpT-NS0sq1JNn7npqfqTL7BQxkd26GdVspDMc8BQ81UimA>
    <xmx:nVkjaZXfAvy82Ny2qdIA4FmhXBZEVRfIJkfjYmw8qqDoIWbnfb86Xg>
    <xmx:nVkjaTwybJvmXwTzpjjgHzYSGGsd_NV2R2Fv9-Yg--V5s16YFPyPy4K_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 13:59:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6d8ab8e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 18:59:40 +0000 (UTC)
Date: Sun, 23 Nov 2025 19:59:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 12/19] streaming: rely on object sources to create
 object stream
Message-ID: <aSNZmRHLIBievXkA@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
 <20251121-b4-pks-odb-read-stream-v2-12-ca8534963150@pks.im>
 <xmqqldjz41wp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldjz41wp.fsf@gitster.g>

On Fri, Nov 21, 2025 at 11:32:38AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > @@ -463,30 +461,15 @@ static int istream_source(struct odb_read_stream **out,
> >  			  struct repository *r,
> >  			  const struct object_id *oid)
> >  {
> > -	unsigned long size;
> > -	int status;
> > -	struct object_info oi = OBJECT_INFO_INIT;
> > -
> > -	oi.sizep = &size;
> > -	status = odb_read_object_info_extended(r->objects, oid, &oi, 0);
> > -	if (status < 0)
> > -		return status;
> > +	struct odb_source *source;
> >  
> > -	switch (oi.whence) {
> > -	case OI_LOOSE:
> > -		if (open_istream_loose(out, r, oid) < 0)
> > -			break;
> > -		return 0;
> > -	case OI_PACKED:
> > -		if (oi.u.packed.is_delta ||
> > -		    repo_settings_get_big_file_threshold(the_repository) >= size ||
> > -		    open_istream_pack_non_delta(out, r, oid, oi.u.packed.pack,
> > -						oi.u.packed.offset) < 0)
> > -			break;
> > +	if (!open_istream_pack_non_delta(out, r->objects, oid))
> >  		return 0;
> > -	default:
> > -		break;
> > -	}
> > +
> > +	odb_prepare_alternates(r->objects);
> > +	for (source = r->objects->sources; source; source = source->next)
> > +		if (!open_istream_loose(out, source, oid))
> > +			return 0;
> 
> Hmph.
> 
> Earlier we let odb_read_object_info_extended() decide which one of
> the duplicated objects (e.g., perhaps a loose object is still there
> after packing), and then used the one it picked.  I think the
> odb_read_object_info_extended() encodes a particular order with with
> solid reasons like "do in-core cached one first", "favor objects in
> pack over loose ones".
> 
> Now we instead let the first one with the object in the linked list
> of sources, which may be different, unless the linked list is
> created with the same "why one source needs to be given precedence
> over the others" reasoning.
> 
> I do not know if/how it matters, this somewhat changes the
> semantics, no?

The semantics are slightly different now in case multiple sources have
the object, true. I don't really think that this matters though: the
stream doesn't even indicate to the caller which source the stream has
been opened from, and neither does it indicate whether the object was
loose or packed. So assuming that there is no hash collision the result
would be the same, as the object contents should be similar independent
of the source.

Will update the commit message and add an explanation.

Patrick
