Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD931DC182
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474698; cv=none; b=msBsdVa0rejXDZWKLk7nLQ3UQBun4ZkEFTZUfDiC186tD86vg/A1Gk9SQsArzbAftM8j1yeZ83JioK3vh4dTZT9vntoRryu4dLE8IkbM5CjpOU7r+qZ70DAf2fZR0gSU/HwWOHAOTl25hNaAoPP7b04AyFgaai8tFDJIRFSOqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474698; c=relaxed/simple;
	bh=aEdchJXb2gYAcnnq3iPgxRktUF38NNRriVLbrhgV4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pk6rcAWACOWCaN/4UmR2eEd8/fdtbCcULCbVz1WLH0SIf9IN5gzRureOMe1t+CE4T2OJOHPX3V0wXCd0quq0a2TWOFygX/kR4Nt2vMuCK/M+NffNaZAMmO7gjV1aCA6unUXw0PQ+VekbQLYHuifMkzQg/ogMjoPYKTpJNwSuZ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SGY4yaqC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kOfAS8TG; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SGY4yaqC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kOfAS8TG"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 75C1D1140151;
	Fri,  6 Dec 2024 03:44:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 06 Dec 2024 03:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733474694; x=1733561094; bh=+PX5hpfMu/
	xNcO/XRXuG9T95XIMQrDX+P++cp1rZwhA=; b=SGY4yaqCN6+WFrq+VpfTPv9N/S
	R/69HkTPzX91er4U/BYfH9vFZTGqiBhP4rx+1AAmiWqVR/fEMB6YStqg+dUOrhi6
	9rbA/buNSg+31WTvX+v426XfiJQaP6swbDEYXennZjX7/NY4nOdbfF9TuwL/9xsx
	wREsg6R9x8LVyN6Ry06WkmGjvJStmppvXPb/5H5atkNZTtthaVHpAJuX+Vq2Kaw8
	CMnkMXYzpfmWhXjkL1G7SfapTEfTsNlkre4EuT5xXxRm98qp4UrVYmBjM5tSN1Mi
	b2AMyRrgj443VFXG4ClZooxKAoVQQDgEmO2wvXwzT6D0m9cxd1juRj13w03Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733474694; x=1733561094; bh=+PX5hpfMu/xNcO/XRXuG9T95XIMQrDX+P++
	cp1rZwhA=; b=kOfAS8TG6wuj5ynP6u9Vwzhf+mHuHXOal07cMK6yqTGCaE8+Stb
	TsvLpYLPOXIB5ESYRVls4JH6lI56b1beHzp2KTgWCya/qNdY9oF8NhDXn+mVvcIL
	vZR2BzNGXej/ufAMik64x157lrlQbjsdjWv4S9kGGRI8N53H8XJlsElun+hpUzXc
	4gt/osvxUdBeOC7rEpM9LZpQlrMJhM19Fsxe623dS8Wcge997DMUoK85pqCLo0iw
	EycFK0YNcpNXwqm0EPDb1UY2itorR+AQaJXgna4nXNrw1ovbc17ZUGYrrwlET7Cy
	DT1AwUGkIPqhmA4ToU1N2OQFSsPPXgGlQYw==
X-ME-Sender: <xms:hrlSZ6XCsZrYO6AmexbTZtIBVZu1QdCz_TqxVuJt1MtFe_mz-ofQSQ>
    <xme:hrlSZ2k6omDvn-oCm-XWiVjYEQLIZ-X-6PBPnYT9v-WgHOKzh1mlhvoHg_lKQitns
    olKyKorVKhVh8fd-A>
X-ME-Received: <xmr:hrlSZ-aMucN_3bY4BA9_TOGrQlWMgROBuwqXWEwodaaFTqOWRy_vaO_k5EKCotzvB2moRJmf7PLfvohXgUta623TDwu5uny0WXEjF4o0FatTKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hrlSZxUOg6fO6M_kkOKsycZCS0cqWHrPQ1zvfG6zdIXa6YVrzeI8tA>
    <xmx:hrlSZ0mhE3-l0y1jqJTsZVY70_Mu4tvYIVEganZXGULqfLfce7NIcA>
    <xmx:hrlSZ2fedTwnnuxshecE6TqzyQMD53TwRk3-gbPELG3MYONn1a4GCA>
    <xmx:hrlSZ2HNkW_41TJER8XAHDRZNBWlXpL93nKYwzJs6scgVrQX4127TA>
    <xmx:hrlSZ1BHUTP4zT0-7YZM7ZA3p9i3A15ngEzy0Pcr7G3TxPFmG7qEl_hU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 03:44:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id efb463af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 08:43:26 +0000 (UTC)
Date: Fri, 6 Dec 2024 09:44:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, shejialuo <shejialuo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/15] sign-compare: 32-bit support
Message-ID: <Z1K5ZfWG_aKpq-9U@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
 <20241205-pks-sign-compare-v3-7-e211ee089717@pks.im>
 <20241205193439.GC2629822@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205193439.GC2629822@coredump.intra.peff.net>

On Thu, Dec 05, 2024 at 02:34:39PM -0500, Jeff King wrote:
> On Thu, Dec 05, 2024 at 10:36:29AM +0100, Patrick Steinhardt wrote:
> 
> > @@ -24,7 +23,7 @@ static void verify_buffer_or_die(struct hashfile *f,
> >  
> >  	if (ret < 0)
> >  		die_errno("%s: sha1 file read error", f->name);
> > -	if (ret != count)
> > +	if ((size_t)ret != (size_t)count)
> >  		die("%s: sha1 file truncated", f->name);
> 
> You really only need the cast on the left-hand side here. "count" is
> already an unsigned value (and will get promoted as necessary on a
> system where "unsigned int" is smaller than "size_t").
> 
> It's probably not hurting too much, but my philosophy is that we should
> do as few casts as strictly necessary. Casts are a blunt instrument for
> telling the compiler we know what we are doing, and can cover up issues
> (in this case a false positive, but imagine "count" was switched to
> "int").

Fair, will adapt.

> IMHO "count" should probably be a size_t here anyway, since we are
> dealing with a buffer size. If you look at the call stack, it is based
> on hashfile.buffer, which we'd expect to be small. But it is initialized
> from a size_t, so really it is one errant hashfd_internal() from being a
> truncation bug. That's not a mistake I expect to be likely, but I think
> we are better off in general making code as obviously/trivially correct
> as possible.

Agreed, it's also something I've been pushing for when doing reviews.

> I think truncation is getting out of scope for your series, though, so
> probably not worth doing right at this moment.

Agreed, as well.

> > diff --git a/pkt-line.c b/pkt-line.c
> > index 90ea2b6974b1d0957cfdc5e2f9a2c30720723f12..f48b558ad23dd99f334d2d60e954ce9a83ac6114 100644
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -363,7 +363,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
> >  	}
> >  
> >  	/* And complain if we didn't get enough bytes to satisfy the read. */
> > -	if (ret != size) {
> > +	if ((size_t)ret != (size_t)size) {
> >  		if (options & PACKET_READ_GENTLE_ON_EOF)
> >  			return -1;
> 
> Likewise here, "size" is already unsigned.
> 
> 
> I also wondered if there was a safer solution than a bare cast here.
> Both of these are OK because the lines immediately before them checked
> for the negative value, but there's nothing at the compiler level to
> enforce that.
> 
> I guess a solution that uses the type system would be akin to Option
> from Rust, et al. A helper that checks for negative values and also
> promotes to an unsigned type, like:
> 
>   ssize_t ret = read_in_full(fd, buf, count);
>   size_t bytes_read;
> 
>   if (!signed_to_unsigned(ret, &bytes_read))
> 	die_errno(...); /* error */
>   if (bytes_read != count)
>         ...

The function is kind of curious anyway. It returns an `int` that has
been assigned the `ssize_t`, which may overflow. Callers don't care for
the number of bytes read in the first place though, so we can just adapt
the function to return an error code, only. I'll do that.

> I don't know if there's a more ergonomic way that ditches the extra
> variable. Or if there are enough cases like this to merit having a
> helper.

We already have `cast_size_t_to_int()`, `cast_size_t_to_long()` and
`cast_size_t_to_uint32_t()`, all of which cause us to die in case the
cast needs to truncate. I think we can easily extend this mechanism
going forward.

Patrick
