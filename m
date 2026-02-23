Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA83009C8
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862358; cv=none; b=S8HzpPz2PODJXcrDun6wy+vtuL2TcL8dEC5Q8qBlIsNiWA/OohLFH4n0Sea45VkV4sJ39b3FNdN0aVy2V+B53bsO9W3FXZ06dhQPkbmQKbjH8rTuvZMsN3txdUP0eJnCb/QOLg//qceezRvqiUg6t+aezkcheW1hEYEySYR9cWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862358; c=relaxed/simple;
	bh=8cnjH4tmvTLml/w5T/G7hwYpbRngZ8VyXNIifSkQ9wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foIqVAC+AoQwozAJBnoI4IQW3CM35gdy03YU4YwP5tDiBqn6uV8xiGB5O18x+lbAN6NmwSyBXtnweTTqEnI0FocySBe1EBRb4K+TuxnaZRbDfTXHTG5jspCptCFNFGY9a6ThwQu5ZJliDPGawsMQjwF+TB5xe9CWOtf9iMJ9ek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WhMNN8/6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kRGZcnSo; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WhMNN8/6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kRGZcnSo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE98A14001D4;
	Mon, 23 Feb 2026 10:59:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 23 Feb 2026 10:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771862354; x=1771948754; bh=BHcbZEI8oa
	3S+N1pKvDJTHs3jvDdbaP56sKDgokdQK8=; b=WhMNN8/6V1TzOQEFC7/2qBIPd4
	QnDVdPw3+6vTO6aHfDbb/UpLKwACWPeMfmHgdygNEi+U1J+fy2ceyotu49ajRtuq
	8OmbJ7923bGI8itSJgmSCj85ne+WAaPdMMcGkDaDKbVf36Tc52IIdtuXut4yxjt3
	YnJ04LnqQ1zjEA2dUxTFJYumSNxOhsjXX0yN6bbNtJTjhFoerwSq+UI0lP/khpOa
	cmlkP6O7ksH5qP9VSpr8izwI9GdEFV4GYihqGaMNKIhpHzbJU15rXlh6FDXTxFNx
	qqmwby0qjmVa43Iwzj7bzWofJ+wYyC4SS+GV0Vjmv2AfNeeHV9IpjdQ9JAXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771862354; x=1771948754; bh=BHcbZEI8oa3S+N1pKvDJTHs3jvDdbaP56sK
	DgokdQK8=; b=kRGZcnSoo+O3jmHcc45KcoTAjQ3hBg13z2TssiFePOzbd7LKETC
	0J3Xj4eG2UjoKKrnLOBbWkxNEX1V004eAMJQX/hjPPyjUm9buKvpT1jW84N5+kK7
	nu5fLjGLNZtSYzAlzR4RqrP3oEPA6tU/PwRanpu7Zdq9MsgQifA6xxt5Lgq+aKhS
	Vs+LujNMbjXY2wwPOZapLPgus5uxCxQ7MYCHCREymL/2DdVKQXBHvcoMmXZSza+m
	J6lX4pHHUM0g+2jCV+Vx7bplhUNH5DdDYU6l+kFFhwZgF/LW9f/86rQ/XVl1sV+r
	EEl9x15xP4a/zTuU2++4YDRZPx5XSd9GTmQ==
X-ME-Sender: <xms:UnmcaQoNWXtjFHp8kt8HQzqn3sGB9OtllQUjrC5WHyUn10bBZLx6rw>
    <xme:UnmcadpJCJs9n1F3ZYAjw1DiKm2-ZqqJvRmjBKqRrIZbFcyPwAVdWjnfh26poNFjN
    ayV9hddweW7_Zm1Hn7NGRfMsBm6ttfuf1oHUAmYD-hdEg6XMFd_zw>
X-ME-Received: <xmr:UnmcaaNbwwOkH5T3EHxd8fsKBnwauJLy08vuyP3AcD8-XqSR9lbIJahT6U2iA7JCWRO727MWpbei2ouYBsimBi2Rp4T9vqrqPniDiIAZVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthih
    thhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:UnmcaWyE5su2mpxiqyqe9getIxImnZ4GVsK0lVvQ5QpSP9nvdghWQw>
    <xmx:Unmcabuf8FS8sxm6aRcIYAoXiuyoQ5NZvtZfipGv0qYebdpkzKYeWA>
    <xmx:UnmcaX5S8BKgE34G0yo7iKx78Jw8xqIcDZJt3jIRHjJRwZVZG_plxg>
    <xmx:UnmcaSRng9K0YLpR4V2xm5-uDpug5tH4Vy1YUkOHt0BtQvoUMe2VRA>
    <xmx:UnmcadtpvBM0uv83a4lZ9STq5ecpr_P2QD_GSJhk6p53JU9tVSIH9nOk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 10:59:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id abbcd4b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 15:59:12 +0000 (UTC)
Date: Mon, 23 Feb 2026 16:59:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] packfile: expose function to read object stream for
 an offset
Message-ID: <aZx5Tc-rgih0S4gS@pks.im>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-3-c29036832b6e@pks.im>
 <20260223110722.GB215364@coredump.intra.peff.net>
 <aZxGMrGkVNeAdC1N@pks.im>
 <20260223131201.GC215671@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223131201.GC215671@coredump.intra.peff.net>

On Mon, Feb 23, 2026 at 08:12:01AM -0500, Jeff King wrote:
> On Mon, Feb 23, 2026 at 01:21:06PM +0100, Patrick Steinhardt wrote:
> 
> > > So your patch here might be making the problem a tiny bit worse, but not
> > > in a material way. I think we can ignore it for now.
> > 
> > I guess the "tiny bit worse" part is that we don't handle the case
> > anymore where `unpack_object_header()` returns `OBJ_BAD`. As you say, we
> > previously didn't fully parse the object anyway, so we couldn't have
> > detected all kinds of corruptions. But we definitely handled the case
> > where `unpack_object_header()` failed.
> 
> Yeah, I think that would cover it. Technically packed_object_info()
> could error on more cases (e.g., errors chasing delta bases for
> type/size info). But we would bail on trying to stream those anyway, so
> presumably any errors would be found via the non-streaming code paths in
> those cases.
> 
> > So maybe we should do something like the below patch?
> > [...]
> > @@ -2571,6 +2572,9 @@ int packfile_read_object_stream(struct odb_read_stream **out,
> >  	switch (in_pack_type) {
> >  	default:
> >  		return -1; /* we do not do deltas for now */
> > +	case OBJ_BAD:
> > +		mark_bad_packed_object(pack, oid);
> > +		return -1;
> >  	case OBJ_COMMIT:
> >  	case OBJ_TREE:
> >  	case OBJ_BLOB:
> 
> I think that restores the original behavior. But I'm not sure it's even
> worth it. We are still missing the much more likely case of a bit error
> in the actual zlib stream, which would not be caught until much later.
> 
> So yeah, if you want to feel better about making sure your patch keeps
> the behavior as identical as possible, I don't mind adding this. But it
> feels like the tip of the iceberg, and I'd be OK leaving it for later
> (or never).
> 
> My biggest objection is not the two lines above (which I actually think
> clarify what is going on) but rather this interface change:
> 
> >  int packfile_read_object_stream(struct odb_read_stream **out,
> > +				const struct object_id *oid,
> >  				struct packed_git *pack,
> >  				off_t offset);
> 
> Now we are back to taking an oid, except we don't ever use it to look up
> the object! So it's a little misleading that it's there at all. It may
> be the best we can do, though.

Yeah, I agree it's a bit ugly. But the function is not likely to gain a
lot of additional callers anyway, as it is an implementation detail of
the packfile store. So overall I think it's okayish.

> The only other way I could think of is for packfile_read_object_stream()
> to return a more detailed error: one of "success", "chose not to
> stream", or "broken object". And then the caller can call
> mark_bad_packed_object() as appropriate. In this case, I think
> packfile_store_read_object_stream() would do so, but verify_pack()
> probably would not choose to (it is not interested in fallbacks at all
> but is going through an individual pack).

We could of course have it return the `enum object_type` directly, which
gives us enough context to do this. But on the other hand it'd mean that
we might now miss adding calls to `mark_bad_packed_object()` in the
future, and it causes a bit of repetition across callsites.

So I think I lean towards my proposed patch.

Thanks!

Patrick
