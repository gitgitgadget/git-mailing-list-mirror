Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C493440F72F
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720957; cv=none; b=I0wz/hEtwwI0LM3F4vPOktAHcTsjL9tocqnmYbhBOX959IZVTpusvTEeG6bcRdukKzlOlAM68XUDoYMkcX+1gH3jbM0mzWd8MoUSiOayx7e9AyQJBSz5dznwFpaYcVuRYkLAaUWf7pjJnG9t26yQYFIE9GTx5LY7udnH/dP3blo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720957; c=relaxed/simple;
	bh=aDLbFYEhuzzoQWNvJw/1/cHQHti1CQYJYuVfJMlp7eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUyS7NOK5FumnQFMHW2AkslOpPrw00bKgZJANP1RZPiBiAZ1OcWrVt2PLWPcEb1++nd9ooCl9tl5qvMleskXXGHzs0qUS3J8GE+MgikVNOGHq+166FUNaLgK6sJdUIbp6ggU8VOTfgl097HBkXi/IrS/JKak87HwDQfiBGnBX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ly+CzTQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qVxI58D/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ly+CzTQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qVxI58D/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 036D91D00128;
	Wed, 22 Jul 2026 07:49:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Jul 2026 07:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784720954; x=1784807354; bh=w7owvquzmU
	Ng4cvI4ncly5RxtwUiONev8Zs9Gx4rtDY=; b=Ly+CzTQ1OjJOX4ZQd7STwthmPv
	EaRIwmrtU5jynbZX6kDCsKaL+/u7TrC9O+v2U7EUNuUkHAFMVFMl4y29UIkAf7B7
	yKAzhDnwyFkrpU6giqtQjqslB81gN7jz3imUvWo+kCLpbif2qvTDUqttjvGSM7Kj
	HOijxiSCSdDV0DgTVW0A1mQnYBb5dP+wtXKDHUVUHuGCBtqMdBpbZyE6f1MsajkF
	TDRtYvNVQ/H+f5LNjqdTK5NpOM0XhkgHzF8Q883p4zE20+nN0BK08TKIRQwWiv0U
	d8mGiqA5e0YwTX3lG7JIB8ki8pZJCqeDopUuOXvgg7BDxWwDbooHhpsP+8RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784720954; x=1784807354; bh=w7owvquzmUNg4cvI4ncly5RxtwUiONev8Zs
	9Gx4rtDY=; b=qVxI58D/PbiRVtqdYA3hWOrrXb71xBAHDOAO3cwsejGsfyVPB2h
	2QTAYSRFuL+8txF+3GG5Q6sL9I3TztHaN2aZn8w+IjsrilupdWBNrRyftT1egduj
	zPpXAVGTAyjLjjhzaAoohe6tSO6ifGlIvcu7f3RGTY416c+zPeAxDeL099rIal9s
	qJir+ipUkF/xxEc1p/ZHPgBICnkrO4N92SYZaPS7tntY9pL9FX9lJeBadS8GdBUJ
	gvcn/UhVY0tles0CjFGPv6A1MgE/mEnrcTpMP08k+nwNx57qPB/0u5o+hQ7pRuRl
	BZxax5MI7I25MXdwUGhsHyWZnXDMohEZsog==
X-ME-Sender: <xms:Oq5gaufSDtpMnKRKoTgJoiFSfgqYGevxETjx1AVnvMi8qeWWqT4bWQ>
    <xme:Oq5gavE87AOooQT4jMipD0WAPx2RwhGMueTW2tOTtLrMKqEZALIrWPiuITo3Pz6f8
    UeyClA4xebXbQDrso9ZUOz-ys9FK4FrUOrZSpDp1bcPs-V0S1XUHw>
X-ME-Received: <xmr:Oq5gan0LlbnDmPW9gmACjR8YwaRDAEjxB4CX4JbbAMS8mWb5JVQFxIEjvQ4AnbewLsp5NYoQK6mMlHzJ6mMcpgsaUPEdiWzdbYUslMhxvw>
X-ME-Proxy-Cause: dmFkZTFSkiyGg6hAL81hu2tjpSz/0YPyrnNH0FtLPTtuX2fIVXLqcvDUTUjts/eboO1xd9
    N4y9IiG0sUsh3ElDmuDAu37jc0jWniKUameooGsQrw0anGesjyqBovI+1p6iVJkM5GUPLr
    aqRekQHbqq8lCX8ufWq0/NvpOngNboKhznv+IfoRu0MBqmcZhiQvG40fSyIIcsgFDhrXEW
    oEWyHkUS6VvhJ8FTK2/4g7FbOngHhetTR/2IczidGbaauxq5/E/yjRR5MT4MIeK9747o3b
    9EsmjU/tBLhyJQL45EnaQiM28w3tpzpH+dxQHND90Ty1D+ZXCWBc24kXg1hv9yqVf0LOIx
    QxkY8eooS8Z/S+vhuW2EIRcdsyh7vdHA06CZqcZgnviPfPMF50VuMTqBCHHYm9MWB07oIh
    BPsmEHl7wTdkZ2MVB29yFmLXnIEahUDwqZ+JNFbilt2udS/2d75IqURHaSkwNci1a/f/G6
    aSGXmes3G4SW7/vRbWVIREMHLcJ2JmOJzm2jegKYIsQ7qc21FYJsAj+D2dMPMQBAcIKuiI
    nEw/wQK4wDG+ps8XDP5MG8FDoGIVzf7z/AuhBaaxQ27TN1ll3A0WEwpKsTl3qKeKKZ6loW
    4IJ+Vu7Ho5Sg9iZh5g0XC+lrEBQxG4l1YWKEpD0jwBOs9/AxRQdOpc+AxIGw
X-ME-Proxy: <xmx:Oq5ganlcpW9Fbz-WJ0_9SBSJ4nvOSEU2cHZDzeDQo7NaOJJUlZ165Q>
    <xmx:Oq5gan_SHn2zAA7FaijhpfLyU4cIwEJEy9xgzHZ358FqCcJwBRxN5w>
    <xmx:Oq5gasoTTirc5JUSgwa855L3BkfCvPyzi9fshDLCSgOFjWvN8N-7kA>
    <xmx:Oq5gagkxd-lclMr4mHJ3q-SPr56qTA5_xQcKZZ7LAEXKiuz-MzUTWA>
    <xmx:Oq5gatDw3TeE4VwiX2igbM6Sho4lrZHJCkiidtawmKYxhFlkvEzjCGCj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 07:49:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 009c51a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jul 2026 11:49:11 +0000 (UTC)
Date: Wed, 22 Jul 2026 13:49:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	Wolfgang Kritzinger <wkritzinger@atlassian.com>,
	git@vger.kernel.org, jltobler@gmail.com
Subject: Re: Performance regression in connectivity check during receive-pack
 (git 2.54)
Message-ID: <amCuLpT6vYzo1GF8@pks.im>
References: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
 <20260721035733.GA581473@coredump.intra.peff.net>
 <xmqqtsps76f1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtsps76f1.fsf@gitster.g>

On Tue, Jul 21, 2026 at 07:40:02AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > Yeah, and that type of regression makes sense for what a593373b09 was
> > trying to do. But I think the v2.54 behavior is wrong. We should check
> > all packs before any loose objects.
> >
> > I'm not sure of the correct fix. This is working against the whole "odb
> > sources are independent and abstract" refactoring that a593373b09 was
> > going for. But I think it's an important optimization. I guess the
> > abstract version would be that each source has "fast" and "slow" lookups
> > or something like that, and we check all fast ones before slow ones. But
> > that is pretty gross.
> >
> > I'll leave it to Patrick to ponder further. I haven't really been paying
> > a lot of attention to the odb refactoring.
> 
> I think checking the fast sources before the slow ones is probably
> the best we can do if we want to retain the 'each odb source is an
> opaque object' abstraction.

Seeing that this is about the `tmp_objdir` case: one of the things that
Justin and I wanted to work on anyway is that we want to stop modifying
the list of sources during transactions in the first place. It always
felt kind of gross that we're modifying the sources when creating a
transaction, as the only reason that we do this for is so that the
writes actually go to the temporary object directory instead of to the
primary object source. And that doesn't make a lot of sense to begin
with.

The alternative to this would be to instead have logic in functions like
`odb_write()` that checks whether we have an active transaction or not.
If so, the write would go into the transaction directly instead of going
into the primary source, and consequently we wouldn't even have to
modify the list of sources at all.

This shouldn't create too much of a problem, as we typically don't
intend to even read objects that we've written into the transaction
immediately. It would avoid that we try to read objects from the
temporary object directory. And it would also allow us to eventually
move all the logic to write objects into the transactions exclusively.

I'm currently out of office though, and will be on vacation next week.
I'll explore this area a bit more though once I'm back in office in two
weeks.

Patrick
