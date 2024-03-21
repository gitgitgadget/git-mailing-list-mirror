Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4622683CCF
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026148; cv=none; b=ak1RSzwpN2baPRAibIiczcj5A63UBivoNBWYl0W0VUw+GsJ9AAzM1KSe7/cbUzN1a9Bw2UGY0o1L58gIXqAoHQcgJty2lmJakoT1EtmCL3K/UzvnmX2X+X4rD3nu8x2lTaVke+j5WZqnIWoYW+UtM+wX/VYVwjLvwvDpp5oUuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026148; c=relaxed/simple;
	bh=FouqlRTiYJk/tpnZaybG8wkOuCxAFpCeLxTmQ+St3+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBVZkUFafBM+/d3dawu6zB2R/M24LYPsF4UXiHNzUzCusvbduYb82EzgD+eNkQNCTcobt7CLQqRibxHHN4TIaElwskpedT57dSgokSxpRkQLwAZBDbX9CbuJKRHFpskyvIuqwAokfR7IE/kLUM5HmVfYQiq18SWkO4mwdTFld8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PYPCb7PB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RrtFbZgz; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PYPCb7PB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RrtFbZgz"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 0C9BF1C000D9;
	Thu, 21 Mar 2024 09:02:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 21 Mar 2024 09:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711026145; x=1711112545; bh=GDWOWp+Hmv
	zA9ePP97w8xbHN6g+QK7z5JHJuFrTmUgI=; b=PYPCb7PBHURfg0Vah/eWH7O5/m
	m1DRGDfM4vM8f6SrcjluC6oR4CTsbmblpiQI4vA5yfz/b4dL+xBdsGWEl7G3S6No
	1WbkeLbFNN4e0nqL7B8jmHt5NGToQ1LdyfZ8Ux0SJ8cZxtwxl0B5x+RN6gPyZwEG
	tyew4TJTvtzEaUVE8gG+8ie4zdohRR5ZjFYw47CnDNbal1VpTqTNjkylAucZF1YV
	2MvG/y/SueAg2/z8ZRQgYjKRUIWsA9el5gc9bEzJ2QOZrQHsD6WqKSggzSyXKvcq
	lXtwblCPBrpZ02lr7dJ1nXA6Jr5o3j85eeKTjAVh3v5moOp9z4neW2/dOtmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711026145; x=1711112545; bh=GDWOWp+HmvzA9ePP97w8xbHN6g+Q
	K7z5JHJuFrTmUgI=; b=RrtFbZgzg7gKgvMm8AQ116Inme+pHdKELWWG157CdUWc
	UzgpHppvRvNk2CRbL/CfZG1lOoUaAymLBY7eJVT3XFnfSBjwWgH3Yx1OmHYHJRiV
	XXHqOEALk2AWaAv2OQ/92syIlQ65OJcPw5c63dBzCkaeI6ZyHNzzcNU26MAqhZcR
	U2tCwAgTdkHFZstCUY/KaLuRIxLoiBiyYWc5XvjL0G3pkfj0S2/HX7KggDCM86aB
	BWEJgLi0tmkTzrxoGzDmWiGW/kSfqQInLaU54/T9xsNKCV2qQ1xlCyd3UCJKo1aK
	qsoQrLBUOIFPZPlhO44ztQD+BTMEB9ToBCbvK0dr3w==
X-ME-Sender: <xms:4S_8ZTrY_XOxFD87v8wdrwHm_be2reC_ttMQJ47hNIe56FvzTsUGqA>
    <xme:4S_8ZdpIx1xOeB8SacCWzSVUl1F6uir3p5DHV9T1dZ5nMM-sq7coks9buf2Qn9BM1
    CGXYArwKR46lpTzKA>
X-ME-Received: <xmr:4S_8ZQM5prg_bJ6M8OgzF4plj8BR_gYokSs3tBmmWNHJRbf_5RktEbxVVcforZoR4wBOKxPzjTA8x62V5YzMdIlDeZaDfznc5KySLufb-w-bvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeuhfeuieejhfffgedvhfdvffeghffhgedtveeulefftdfgvdejtdfhvdelheeufeen
    ucffohhmrghinheplhhishhtrdhsohenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:4S_8ZW5kpmONz_gF27Yjbksls6JgYXevh1HRnRmTqfNIl0e3HbK4cA>
    <xmx:4S_8ZS5bvyHv0zlb91ohvI1AmccGZXCkz4fc7Qmx5EwgDcWC-zvK3Q>
    <xmx:4S_8ZejCs70iluUGGwoGGGGAflgGS-vtVbbSw4RWnb_5SUCuXBs-Xw>
    <xmx:4S_8ZU7-I5eNSy6cxAx-QGlSBM8j4fs7zjH4IIvhzAtL2s8nMrWZxg>
    <xmx:4S_8ZUQKGkZ4TJ993wcdbIsjIaTvelrCCjQ6MHEtEEFvESm3b9ogjNpPqLU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:02:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 97bc44c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 13:02:18 +0000 (UTC)
Date: Thu, 21 Mar 2024 14:02:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Aryan Gupta <garyan447@gmail.com>, git@vger.kernel.org,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [GSoC] Discuss: Implement =?utf-8?Q?su?=
 =?utf-8?B?cHBvcnQgZm9yIHJlZnRhYmxlcyBpbiDigJhkdW1i4oCZ?= HTTP transport
Message-ID: <Zfwv24OnsD0pDQ7D@tanuki>
References: <CAMbn=B7MtohTm=J+XL8iwx_CuWo47jM-v=e=p+k6hY2CKWX+Og@mail.gmail.com>
 <xmqqa5n1ak1f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y8+czNZO3g5kueNm"
Content-Disposition: inline
In-Reply-To: <xmqqa5n1ak1f.fsf@gitster.g>


--y8+czNZO3g5kueNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 02:39:24PM -0700, Junio C Hamano wrote:
> Aryan Gupta <garyan447@gmail.com> writes:
>=20
> > In simple
> > words what I understand is I just need to add support for the server
> > side nothing is to be done for the client side.
>=20
> Hmph.  The "dumb" transport is kept primarily to allow folks, who
> can only use web hosting that serves nothing but static files, to
> publish their repositories, and requiring more things to be done on
> the "dumb" server side sounds somewhat backwards to me.
>=20
> To be quite honest, I personally doubt that this topic makes much
> sense in this age and day---I've felt that the dumb HTTP walker
> outlived its usefulness for the past 10 years already.  But perhaps
> I am biased by the first-world access to the internet?

Even though I proposed this project in the first place I don't disagree
with you. The dumb HTTP protocol is indeed quite esoteric nowadays, and
if we want to put it officially into "maintenance" mode then I would not
mind to drop that proposed project.

The reason why I added this project is that I found it to be interesting
as a thought experiment. The reason why we have "info/refs" is to help
out clients of the dumb HTTP transport to figure out actual refs in the
repository because they typically live in many separate files. But what
I realized is that we don't actually need it with the reftable format
anymore because we basically already have a definitive list of all files
that a client needs to download to acquire all refs: "tables.list".

So theoretically speaking we can implement support for dumb HTTP with
reftables by having the client download "tables.list" and then fetch all
the "*.ref" files listed in it. Whether that is sensible may be a
different question.

Anyway. If we think that the dumb HTTP protocol extension is dumb then
I'd rather want to pull the plug on the proposed GSoC project now rather
than later to not lead down potential contributors the wrong path. But
in that case I think we might want to make the deprecated state of that
protocol official.

Patrick

--y8+czNZO3g5kueNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8L9oACgkQVbJhu7ck
PpRamQ//ad58aSOmIZJX9vuhmHooYMOhxmutDvLEnVT4Ju/3vS0V+NLjAJlAcjNK
LaQbd752qHtN/Zn/eMjzmV27pzK448uSKkmkiczqNGoOxh0+TkDyCeLxvVE+rpq5
OMhymLkYRDu/AYa7KVwJJPW50bgD9F5NE7zduLscFCIVEUtpUD49id9bKZxMOtXp
rt6b2Zq91LaQDauRoWf1nMzKvyHzMuhN8IWBTuJwU6Lte6rQWe+5DF/RrLw6Ewym
YU5O5ZeZtgUSHfjfqlVzDo7SLK188a7RoGgG9vHbO9viqUGy9jdVLw/cgDlqWqV9
GvwQSH7jYIMpa9Hnj0AxzgH4oHyESTjHpShEbzJO29tMsA6mPhcOwnMlmLz5EtIg
G7vcZu31ffiFD7mONjYsfqT7haNKnNYW9vg/qbam2YPqh6f5VQ0wgA+Z67hwFKlT
3FPZjh0kRz9SaTO6ob4ndhDH7vGblXfHdWXR40Z4RtMvYij+Daz0SbZpLMEW1Ghc
yoD2denavJyVFFPfAL9h1/7Ah6n+mry5eKzsEPUU24rMCvrpYOTE0E1vExatFb8q
NhnkfKtpSagGWzasOHg63X1qXIBZVUA+i0evT1SiZhTVUFIxHHqH/bFJq5KDcNXW
sDcBTq09Nkz6rmdLXYxHr8O1yeAMJFtStxxxgHcD5DM164T6s3I=
=6xFN
-----END PGP SIGNATURE-----

--y8+czNZO3g5kueNm--
