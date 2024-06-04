Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ADA1EB27
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717483519; cv=none; b=GL6jKFkffVrGe/X3p9X8ABrx5NZ4zMEZTcyLDenwWb3KRrA4XE21CHaD7aTy4uRqCZyTVyX2xmJuFVB+WFCqi56GOLPNp5Mo6BtbZ8hADYCkNjSB/H5vPl0S7TqFka1W/f6JVaAHHSpLefHbR5DwJCNCIGfJpK4TV5eZVz4YYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717483519; c=relaxed/simple;
	bh=L5GCHk4tVWEgE4a19crGGN+0iXydT272ztScqlUL9RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CODI27bcf05wROAom0NKfhaDwZxR1QMuuP/cNiOZHaK2RszKrBtEG3y3Mo+Xx6+pnvMR9RrDrNpMMtv0TP8uC+iNQY+8/1ZhuXu+FPeiefnwcQuAber2jBCQ4kRNf3n0odwLTa2/m46BJZbRJ0XGgEfVuDJUvDG6+7NnJhQgLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WB3RhU3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQOwZnYA; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WB3RhU3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQOwZnYA"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 711F01C001E6;
	Tue,  4 Jun 2024 02:45:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 04 Jun 2024 02:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717483516; x=1717569916; bh=PhBIZiBKdy
	X1w1HPXza+gktD090azX/RgMe+VvnlpF4=; b=WB3RhU3S9ODXDS9+hUlYJpx4JB
	dcvQ00QSfmbqJxWMC2G8Lq91WCn1geSNbHgvkqcGmUuVGxptQ2cgi7IfrvWmUgMG
	7nGWL4es9K5zv7YlpAaqbcr5Xdqq36MoANfrdzCvqBUStIE571OS1UgNChWoWep0
	rrs57vgaGcEmZglIQFw572Gxmy3YiK5zJVP1DdUc8JribbS13OiXRDWi+KwS9Ynh
	2ORHGNcOAk5Sc4fhlk7rFJ8dcRmsQdDnY5RTRjn+CtnedsknZT0trYgNibeujel8
	lzvM6edMHNEZ8KWMB6BRPeeOd7FjAar+MhDovdSJ+/wIxpixxWkJYEtEgbwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717483516; x=1717569916; bh=PhBIZiBKdyX1w1HPXza+gktD090a
	zX/RgMe+VvnlpF4=; b=dQOwZnYAJTOXiupFxWtUr1FNUeBEotfQyaOqGDSyyio1
	ecb6/7gmaw5h2AjR2jdmwC8BOPlmFP+5dL40IlkJYD1twklmr91sLC8jMDVrUkwq
	eBgIOAz9p5Lm6d9eKg+7CssWEX+AmpncxrF+UZ6uovoedBteUyE8yTZjR6lsEkDF
	pQl/UhXqkKvefliLZjoo94N51+ttbSebFS9SnHmi34nLL7dPwn0jsDXhCA7+itkv
	WSdeHiVKax2L7AtHcCFrRSAz4x122vmbVipkPS6hUgBVuFk6pEf41787Fd0zxipf
	X26Pf2MO737fy8QSE2olC1h5hK1IcN0mbotfzVxKvg==
X-ME-Sender: <xms:-7deZnAc2-PzUav-Qd3Q-XkqRkboTFTEnbiXZp2bKCj8AwLwz8fzpA>
    <xme:-7deZtjXDX88Pvzt4V-ih8fN15ru4CzNO_mTbpSNQ0ETmqOk5GxshYhknBPeB5kRX
    kVsns5rJzuEl3BwaA>
X-ME-Received: <xmr:-7deZilPUcv9Unl7Xu_qm0mo0rAOpGhcRAYcqpI4XkVT0JHCXwUsj-ri8dk0foyPwLUcaUwWxDcqrfMAO0CE2ySiwT6EfJFKrZfCdUibUnjLqwGO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-7deZpz2bGvBaQgaOf5ymmrgUlrW2eSBDdkjMKd81FOsGV32idv36A>
    <xmx:-7deZsTsCH-z5kBhucOEM9KH7R0LWy6JMpA8RKBph8BdGXnx4Jqy3w>
    <xmx:-7deZsaDG9nVPNd2YEWn6xxNRk9T1cPjGCYDjGJQgCgXQS-1aZSERw>
    <xmx:-7deZtSQQMp-4Zuo0SO12Fc7H8jCWFttyUA0-hcnWbyaexy8bo9abg>
    <xmx:_LdeZndOU5xe75vsaGVZNLg3-KrOWB2Lr9si6niqvtl0OyzCrEhTZCPh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 02:45:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2ef1cad1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 06:44:48 +0000 (UTC)
Date: Tue, 4 Jun 2024 08:45:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 20/29] sequencer: fix leaking string buffer in
 `commit_staged_changes()`
Message-ID: <Zl6390B6kUu5TlBM@framework>
References: <cover.1717402439.git.ps@pks.im>
 <48bcd0ac80ee0b60eeda2bcedf55003a5049f289.1717402439.git.ps@pks.im>
 <758f2321-dc63-4209-8b54-99b74b6bb897@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4RBFz7opnCWTUNY/"
Content-Disposition: inline
In-Reply-To: <758f2321-dc63-4209-8b54-99b74b6bb897@gmail.com>


--4RBFz7opnCWTUNY/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 02:14:20PM +0100, Phillip Wood wrote:
> Hi Patrick
>=20
> On 03/06/2024 10:48, Patrick Steinhardt wrote:
> > @@ -5259,12 +5277,13 @@ static int commit_staged_changes(struct reposit=
ory *r,
> >   				}
> >   			unuse_commit_buffer:
> >   				repo_unuse_commit_buffer(r, commit, p);
> > -				if (res)
> > -					return res;
> > +				if (res) {
> > +					ret =3D res;
> > +					goto out;
> > +				}
>=20
> Having 'ret' and 'res' in this block is a bit confusing - we could delete
> the declaration for 'res' and  either replace its use with 'ret', or rena=
me
> 'ret' to 'res' in this patch.

Yeah, let's just drop the local `res` variable here and use `ret`
instead.

> Apart from that this all looks sensible to me, it is nice to see the numb=
er
> of leaks going down.
>=20
> Thanks

Thanks!

Patrick

--4RBFz7opnCWTUNY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZet/cACgkQVbJhu7ck
PpTpFw/+IkJ0DzUSNT4VfyrOLtirtFSummywoPqQ4ig2EMxyVmJRHB+KnYQ/8Mh8
M5LIYcylEmryXx/vYD9rDLKktnO1RYka0kQ1/g1Y4MkUHgVJ4qxcRwErxedaRRK4
+F3NmzCE6GBF/hTdMPaw0Uql5Hb89ry3aRHziPcjcR0Z/E+HfU2QhQIG7VNGEnvi
c4YTuTerEM6jO36DzTAyXF0dlXwHGOZRH/A+Zo9Ru7FBwUvxSxJbcjpl6tBgHGfc
20D+BIg5BRvAV7mkhC4RB59yDshXXxleotQf7QId2hjZL8gvDMkez5xxS6lPainT
wPbGeHwOvIZ2wC/HPKYTzRHJ0GzSHg3eqzkWQo6JyQCZnOyEyj5ZWeQYcMUPx4Id
XJiAKGjJ2nyuil1Vkw0S2WWOpk1ZVxOogTWT9VFSBHlAV0dWyYZaz84uoU0D42kd
FN8i2sqGliMuejVFZCilPzGsqT3xpeHwfS2gKdUjoU7REguc+odKj/hYcVWqa/km
fC8QjIQMok93zsuwvSbIqbZWva2tHfHKwZmoOXz/QhXOK7JgRQYd+yht/TzuZbvs
ZQZIj/Peat6f/+vfUicedJLoX/T1QF/fTaZaNmPmaw5+Pszb9OHF0iBHoFLFqgR4
Q+g1hdYn/fmClJpvdCpKWBlc8RtFoYG9a+WxSCfQv3n1qd8Txj4=
=NmMC
-----END PGP SIGNATURE-----

--4RBFz7opnCWTUNY/--
