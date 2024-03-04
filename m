Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3630336AFD
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548771; cv=none; b=TFJ3xYAkg5mEkmy89VB41oNa3a3g4y3gmt8YCPK+lAYmzbTpZv5WQCxE0npf9GuDvmJagcg/gCXy6Kj5Q+fjTYUwxqaGZF7mZStYtlTC8m0Lh4oee00D0kQ9EZSTe1jyBSbAN9TCgopysYz2djEX8pMIcFszN7P3O9LW/W2aEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548771; c=relaxed/simple;
	bh=Rwnuke5+gE5kevMAybDtDp6aA2w8p+KfRDT2TM2ElGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcxeGRaREXCoEydA7A4TT58A6R9Z4lTLS5v+vw2VmtTAwzYzudtmxoFWrmIvG2XEKN0dzwe8TUAmzCJ8tzYnC8cg5EC5Op+Iu9cOD5QNmeLvUCrQyDDyrMV8JVQmDJp2WzGL9yzyWwj/bIJBvwvqicnfBHL3SMJhe1HIHxkMNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lmuZxCkm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOVVUTIZ; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lmuZxCkm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOVVUTIZ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 2856E1C000A6;
	Mon,  4 Mar 2024 05:39:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 05:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709548767; x=1709635167; bh=alb7hjI/Ia
	vPnWjvhpaxRdyZxM0Xr9KMJd81jJQelPo=; b=lmuZxCkmZNHZFx/z4fw3SBTbTe
	ctCoFlijHaJGceugPwNRL52geh2jqpV5e+Hvs7f0mJxxw3gZZTtj4OKmcBdEIYx4
	qPSHqGhxaMM8UPOtn1RO9YkkhpM9/ljnRpUWl0N1Khcs06nTdche5w8iSySM94DH
	yf4Kw5JyNrhoMLFhEqCK0LE3zOiBFShIb3yZvYwRo5vgGLZFGvkhY3xFiHN5EfLc
	r9QnR8hevt4AfWM/edNuo4VYGahwdmiqVH/+4uIlFRPEecj+Emwp3iBz0gr7aMnW
	D/oeKs/hh1P8RALJPSX+fSuu3PvrtkCpGuYuEeVEhd/jekMdTxXXk4AIF56A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709548767; x=1709635167; bh=alb7hjI/IavPnWjvhpaxRdyZxM0X
	r9KMJd81jJQelPo=; b=TOVVUTIZ65CoWJnuDfx+wr9moI4NJbNDSwMuhVICB1Eo
	D2Lu9ljqfuKSnszrUF657XcHZHEnL5699Yh84RSDCChuTiD7iHTv542JE7TqT3+V
	qUuj+HCyaFw3soY4xZuoE0FTVT5tPKdERC6R64u8cTvwZ8vY2wIwjdJ0tPBfYjf8
	RPrbRoW8aDhg6OfiP4Pyi9bzXc9IXnmT29mlcLoTrMJrIH9ROEUlsKDS7xW4S9Sx
	l5w6QXl0DwqHRQwuHBRr7w1ANx3+7Wpj02InDba3TEWPEE8wico0S5Nr8IDP8daz
	50Ehkq8xf15UgrZrf5FeCa4B7TvgI03GntuuOtOzLQ==
X-ME-Sender: <xms:36TlZd4N6-bqjQ1MCg6D71tRvPsU0l1bmnUu4ftdOyVB7BWB0rbyHQ>
    <xme:36TlZa53KBW89AMQcMPOfrrvHbSJO3A4NoUTKxL826gFTHRJir77jX3vbw1uHEfpv
    2-ypADzKzVcfiD20A>
X-ME-Received: <xmr:36TlZUehiY27EXvsNerTjAe1kLwIE1grxeJkyV6Q54-PmuKPTXUFq1DxxloHqWRMe0u4UZWiL1NTBguoQKC6R-Pttk7ppggkpIMmZimhqCKML-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:36TlZWLh1m60GlHknYHo-9C2k4r1nnxPtcyA74jAiUUburm4vdzFvw>
    <xmx:36TlZRLHlz7Yfiv6937b7tNjTyL6RD0U32-9SjywMxNZWd8G1CsiKA>
    <xmx:36TlZfyK-KRHcvi5B0n8r97cJVsOYJiCSVy6n6gk1LVEQQcytCHpqg>
    <xmx:36TlZYXkmQZj-_513l7jdzqzvXZo9WJQhNUJr2dtRhAjbaTQSqFNaTZLprs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:39:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af37d48b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:34:58 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:39:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/12] reftable/record: decode keys in place
Message-ID: <ZeWk2WL18-XGjTlO@tanuki>
References: <cover.1707895758.git.ps@pks.im>
 <f0663c1d62d13d01afb1fa6c3760a38741bdfc8e.1707895758.git.ps@pks.im>
 <CZGA0UX31LAO.1QWOAGQ6BUKIS@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OL5oZu1z9GW/DJQy"
Content-Disposition: inline
In-Reply-To: <CZGA0UX31LAO.1QWOAGQ6BUKIS@jamesliu.io>


--OL5oZu1z9GW/DJQy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 11:13:49AM +1100, James Liu wrote:
> On Wed Feb 14, 2024 at 6:46 PM AEDT, Patrick Steinhardt wrote:
> > -	strbuf_reset(key);
> > -	strbuf_add(key, last_key.buf, prefix_len);
> > -	strbuf_add(key, in.buf, suffix_len);
> > +	strbuf_setlen(last_key, prefix_len);
> > +	strbuf_add(last_key, in.buf, suffix_len);
> >  	string_view_consume(&in, suffix_len);
> > =20
> >  	return start_len - in.len;
>=20
> Since we're using `strbuf`, there's no need to worry about extra bytes
> for the null terminator here right?

Exactly, the `struct strbuf` interface handles this for us.

Patrick

--OL5oZu1z9GW/DJQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpNgACgkQVbJhu7ck
PpR67A/+NBmNMW3rT/ObSNIoXagqzHQ/aYLe0iY1SZOUpvYiAdOjpHd05AxHAAJK
IvPWD5aexKr9e5ePcVk4vAIPpf0IsK3qRlGSS9YllYBwBhGuAQrdlKOY9n+svFRH
4Y3fd4QrptHGrg7PTGXh67TWwWf1EZAiwqe/fWQeplLi6N4+xM2+94/pMB1jbFNG
frpwbbDVGALRT98iyeFf40T/lONgNsv0kFRyPosUaG6OfFT+uX8+qzcgQ5cjOMPL
cMrH3Ftp+tBk685UzDxqNYyxRKKrGLxLDcq8lzrLUvEqukauq18gHiIaRfjmj3/n
XgN8OlosukKuCmG0EMtiAUj6l1X+ajvnkBMJXv7uQhEom4F+sAb2IlkgNE/M95eV
9DYVD3YO6dQDOstM3F7qF0wV+/iIgf0zh9y7VGukoLFDr5pDoy98dP976uP2NsQw
1q1i0k7YuUugdweF5LLxk9tFejODRAnwO122oQkeTaqV+yp1Wrz5zM//Tr+umgJT
i0gieT/ElhswcgRk+wdE9sR5+ft/NRJ0yiFGBeYjbvy/ni1TeMjMfm0vUpMl9ROC
bomYy5sPj4AR8Zl8Wo2/nif/1WK+i1uBqEwGzzP8cITkAdRDGq37GgOoDlOKgt5B
3u1YDgumYseMEkWGcbxKPd8NdA973M/u5SekvJcZaDJ/Qdvhmus=
=hMc6
-----END PGP SIGNATURE-----

--OL5oZu1z9GW/DJQy--
