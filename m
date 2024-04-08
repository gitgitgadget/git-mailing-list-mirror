Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A6143864
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594027; cv=none; b=oXjdSLRk0CbNYMaZvGzxDJHExxklbQyV35HcQQZ/L9USip59Z+PyzGtbIkGEXwkH7HKKGWJUhMAfVbnQnc2GLwEzQNEd8m2y7A0zHAY+MQd6st4WPHuiWx012YvLx2XvrScaRLcXPJ1rxwquXbQ7zxVKMnWH6eTsti/jNFEfUjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594027; c=relaxed/simple;
	bh=bcNNkm+Wq6iyq0ZAdIbZC4pNIDp1X7R5OI8TJKTapTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbQ7KyBQFd38C0UaCQiejNjlykg/sk51RFvgPZUcvGTFwvezpnfotnUjPIPgRVuhq624OSGbK0OyIL6wbasvbrzmd0EeE4C3R0ZaJToS6GuZLHcyfd7pBRYcqhh002mLSqhUsUQV1HgW/bE/WfTujcyfL2skeaO9nNeGSKLFcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZUOIaBZ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JiYOe6PM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZUOIaBZ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JiYOe6PM"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 662571380086;
	Mon,  8 Apr 2024 12:33:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Apr 2024 12:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712594024; x=1712680424; bh=yoaqE5wrEj
	zu6H1npphOioCYa6O8sqMbZXWIpj4V8W8=; b=ZUOIaBZ7TqasO6bP8leXN4VzYF
	QRWmW+2C8c1zIFtoZyXKXhKU3qZqnUx3hkmC4my6FecdHR9qh3KTEQEbIVBFWJq+
	uq+5hk9bEzkK/dDjeolRsuFzibRlLiBhcNb9SX4C2B5IXwEOGDqUYPOnjx0vDDwx
	GG9Am29eNq8BeO7O/ypB/hdkdloGAjyPTN/8rCBOTSRVOcoJGTZjtRA93ADUv+Mv
	MwsA9jktIxiPmGeUmfT2ca/5vzs3Tgfof0HPeV7Q20r5SgkKH9Ggk2VOdkWkGT10
	lmm6nssN+We5fguR+abMUMU/EzaHTuVZJrVY56UVSQIiViQ44hQ6UNFh6VyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712594024; x=1712680424; bh=yoaqE5wrEjzu6H1npphOioCYa6O8
	sqMbZXWIpj4V8W8=; b=JiYOe6PMhQe1ZssfhIuIqIuee1i4W6zzcBx03q/71V7I
	a88OYGgAScZdPqxcBrgGgg3EUDy2DeUd/dCROofp+neKca54ko2/OOvg73gz7EJW
	HxOkNpJbnDKgMnr1oD4x7kDY1SWahHTNFC9ypXedDVeGbOIglu3wXf+0eFzEKc1Z
	51qMUJT23h7WX9ln8CgUjZ5TaB0OtEAUnmLMG4tZOI6Xu2t81t/01Z3QcTH3B9j5
	INKAoZ6LLeLbfikQGrtVXBTKKHOyNtQIS5v0utUFQdRaHyH4Kp1hDIjdA2PDaVcq
	Hl6PLUsSFc+aNttSXGOLLytG30SDr+6gjJ1WSjexUg==
X-ME-Sender: <xms:aBwUZkCJwRwL6sktD6f5VYJJKMnrVesXrcz2L2TYmOndzdVJa5E_-Q>
    <xme:aBwUZmgMrW7ddxtASf74jwFt6g4F6QAfDzh1ZEbmwi7w44_u_wK75KSz1h12w9Gdg
    AWngd_5SZSAmclSYA>
X-ME-Received: <xmr:aBwUZnkQFDBl0yB4wk_eh6ldN9wcPWSKQVNEdoC_I81lUe4_gvMv8AWSqsVIFHGgHzxvj_a7pWma1uixZgPrYWnkucsT8SthzK4nJOv6CPz1BnaT6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:aBwUZqwlx-EXajkJg3GlhG5UplViecuBiD-E3tss49Ac0jwLwBhaGA>
    <xmx:aBwUZpRWdyycUMUvrEbdI1Y_H0YVYFFd1LbF5QtTPzvaD3HscSLTHw>
    <xmx:aBwUZlZx78-EpHdHdVphFwMWmAnzc7tDhslQ718CIEIZOV-fUcdnuw>
    <xmx:aBwUZiQXrCopG1cJrY9AYGo0NHUw6fXdiVHgwlJynQ3SBbCZmGi4SA>
    <xmx:aBwUZnPms2v3nAchZs8Kc8UbdMqK_hzzUiiaIo02OCpDbHwWn2Nwlfcf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 12:33:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cd84fbd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 16:33:33 +0000 (UTC)
Date: Mon, 8 Apr 2024 18:33:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] reftable: use xmalloc() and xrealloc()
Message-ID: <ZhQcYe595pHlQf5j@tanuki>
References: <963961ee-0f1d-42b8-8dda-5838e7a2ed94@web.de>
 <ZhOETox9FTIOAShN@tanuki>
 <xmqq34rvg8tg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nSIhDhrbv7Il/EZ+"
Content-Disposition: inline
In-Reply-To: <xmqq34rvg8tg.fsf@gitster.g>


--nSIhDhrbv7Il/EZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 08:42:19AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > These are part of the library interfaces that should ideally not be tied
> > to the Git code base at all so that they can theoretically be reused by
> > another project like libgit2. So I think that instead of rewriting the
> > generic fallbacks we should call `reftable_set_alloc()` somewhen early
> > in Git's startup code.
>=20
> It sounds like a sensible approach to me on the surface.
>=20
> The reftable_subsystem_init() function, which would be the interface
> into "reftable library" from Git side, can call such customization
> functions supplied by the library.
>=20
> > It does raise the question what to do about the generic fallbacks.
>=20
> Generic fallbacks would be a plain vanilla malloc(), realloc(), and
> friends, right?

Yeah.

> > We could start calling `abort()` when we observe allocation
> > failures. It's not exactly nice behaviour in a library though,
> > where the caller may in fact want to handle this case.
>=20
> But they would not be able to "handle" it, unless their substitute
> alloc() function magically finds more memory and never runs out.  If
> you want to allow them to "handle" the situation, the library itself
> needs be prepared to see NULL returned from the allocator, and fail
> the operation it was doing, and return an error.  If the caller asks
> reftable_write_foo(), which may need to allocate some memory to
> finish its work, it would see NULL and say "sorry, I cannot
> continue", and return an error to its caller, I would imagine.
>=20
> I think there are two levels of "handling" allocation and its
> failure.  Substituting allocation functions would be a way to solve
> only one of them (i.e. somehow allow the library client to specify a
> way to supply you an unbounded amount of memory).  As long as the
> library is not willing to check allocation failures and propagate
> the error to the caller, you would have to "abort" the operation no
> matter what before returning the control back to your client, and at
> that point you would start wanting to make it customizable how to
> "abort".

I actually think that the reftable library _should_ be willing to check
for allocation failures and return proper error codes to the caller.
That would be quite an undertaking, but there is no need to do it all in
a single go. We can refactor the code over time to start handling such
failures.

> Their custom "abort" function might do longjmp() to try to "recover",
> or simply call die() in our case where Git is the library client, I
> guess.  So reftable_set_alloc() and reftable_set_abort() may need to
> be there.  If you make it mandatory to call them, you can punt and
> make it the responsibility of the library clients to worry about error
> handling, I guess?

That would be a possibility indeed. A custom "failure" function may try
to e.g. release caches such that the allocation can be retried. And if
everything fails then in theory, the caller could do a longjmp(3P).

In practice this could cause all kinds of problems though. Imagine for
example that we have acquired a lockfile and then subsequently an
allocation fails. If the application were to longjmp(3P) then all the
cleanup code would not be invoked at all, thus leaving behind a stale
lockfile.

Overall I think that handling allocation failures is the more flexible
approach in the long run, even though it requires more work.

Patrick

--nSIhDhrbv7Il/EZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYUHGAACgkQVbJhu7ck
PpQN5g/8D46bVtNlEif7rXfdYe7QCHyC/zd7Okf9edYl6tTYLno9W5nWrXpikB+h
i+Kzv0zeRD7B+w3v9yzRI60HD6loUdT1nIdprCWMRBonM7Z8hBZn4xGcKHEtfh2M
LAOENqlZGKeTJx4sQqHuEPxAvHzzFSCZX4sZP4jqh5H5SmhYk173X6M5D9a5EwQ6
saFtKB5vYUmjLLmrfa2hOGkUE7VWJqZ8lt5ex3lQ/2c9ftx6Q5JRHVjQojHlt8LP
LzjFPxAMujV2E4QV5ot/IDHJHeOXHEIUiJWCfp8G/7z7jS/FtPGHkkuwDWB5NeJa
KB/WxLxZ2EgBJOziPS8o1KR/x/DaI96jeMRhseKpynMjaPfnajySPE667bYGOG4/
s3OXtEBg7/v8p8RdX39VVeigDOR10czc7fCGVFhGVJ6fsOvQ1WyJ76VIpygjlql+
kDOV5NZ5ZYrv60rrgu30VdiZeDopepQkRXE1eYOHPWUsohVKsLRZyie2yZ9eEd3J
oqLDgg40DJ5ZLgTvphrNz0DsN4o6QqM/+z2II21G2H48atZfq9DBUdWuu7tKIUuJ
0jhef8zez1LuvRtzFOM1PrdU2pxbmSHxDb3g5f9HMUhlx2pX3u6tRbtg1Mvupblg
qCtFtKPFiaeL4tIac46Hr3a+rBRwcdLZ6kgRdGsWapdos0liZZw=
=nvyQ
-----END PGP SIGNATURE-----

--nSIhDhrbv7Il/EZ+--
