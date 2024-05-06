Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398CC28DD1
	for <git@vger.kernel.org>; Mon,  6 May 2024 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714977334; cv=none; b=KUFRDv9EIz+wOwdpFaWMy4KyBHoqLjiAoe8DAXh3RJPtamg1Pi81k1I0QSOXhlfbV3JwTZ92PL2QK6EiUoM+Rf8OongTTIoKHNNJ/m//BfXEolSGT62Slaqp0HqbmjRMaS0GklGJPq5FsAYQFlaf+ppXuJ8GFoNSjTVP/NskzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714977334; c=relaxed/simple;
	bh=kT2s3ZRObWslLtmg2p1Kxd0b41djdtkUn1Q5Fp8qubo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usmnm73P02ECch/2vkq1BSpef6hZXne92hKfNgUKvajOlMudVE6lKyFMb6rD48eqUI46ix6nWwbOKhSZbLveuCg3I89lroKoIkvwD+lTApx3Ae2qKK2xzBmyp/SCQhjYc1KaSeViyZETcUrry3BkkzUwIZna4uzyPBeqnp6C9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t68Y9xq8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NsVaLcTz; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t68Y9xq8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NsVaLcTz"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 224CF1C000AC;
	Mon,  6 May 2024 02:35:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 06 May 2024 02:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714977329; x=1715063729; bh=l0Q+yQchAj
	mb/7BPfmvzLlIulnfWoq3RGHKkVt5ZVGw=; b=t68Y9xq8qnnTcrZTfuMMtPLSpT
	1+Ojf6r16ykR9xE7NzasP6qu+n5Pvb+cwy8k0oe0A4KQD7Z4ujA7QRLzpKyC2rSm
	2tU7WTaMpFCKDV+83KSoRdqvsRrT8Ow+lQOoI7HJo/+/PN7NmsjcaEkavxQFGa7z
	ZuKTm86jUYZK/KDWWQuzMXju2Z+4DQjj1tPdvGWWhW6saVteR9Lcv4HT7EAcvkX9
	TghBA1AB1jQtfD+PDmIPM+lKQ7Pt6FQSQWcse2526zRSBXiMgFI4JIZssVbLHpS7
	B4286QF4xaYhHDSXV3bAmd7BPVLAghHeIA3nEile77LqV1p76shGKO/CJ/yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714977329; x=1715063729; bh=l0Q+yQchAjmb/7BPfmvzLlIulnfW
	oq3RGHKkVt5ZVGw=; b=NsVaLcTzihXvBsM3uXTeZMYRfuQY2uvp1tAjr3LMm/2X
	sL4py84RCt37Q35b7FkWo2qPlRqnwjJRBOJpxKF2mh1MRsY8NVRkZDNEwXbXTPc2
	lyxW7cOSOv4ryYSdvL3pnX5imMl0F++atNW1rkhvvVmFgJlBkn2yC1y2VCNZlGR8
	Adv8ieO8SXlwnmQ3nILy5/tsQe5k2jC50A5ntK8s/XOSkzomKW8zpAEMYkDYL2bO
	zlzLvIB5WSX6exNfnpozsa9Qq0msgYqlhxPm9XX3qJ5rvVXr1qjvykFvIBlyNV04
	/bFZsu4EZFI/voO4UpFsJ9g9CuW8hFhTkf2/MJZJRw==
X-ME-Sender: <xms:MXo4Zh30KaK6QE4DmJ3lK0YjTjn5l_H77Ipi1v99tPlZmesUpLGdqQ>
    <xme:MXo4ZoEa4TW5wCoR0AQKYO1fn9PvQ1DFyIJOTdrTCZbhkFIi3mZxLAmcFX31xheMS
    A_heXqhms1CmJkJQA>
X-ME-Received: <xmr:MXo4Zh6H9HLh_wXrMd5haYVA7x-Z7UeV6LWQRKas4SCCBIcPKOdvQFmst8E-8eZ4q3nx-uJGpYhK3q8RUtOLBWS6gBoMSDEcYHcIKiCyh__1ZhG1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:MXo4Zu3nDXyznjA4GiXXWBnpMRcekBGVW2avDZno9iC-xHz8RQhRew>
    <xmx:MXo4ZkFyCuGcWiatUnZlE_zReVtV4B6naD_VEarsWwE9O3Lr_h0XWw>
    <xmx:MXo4Zv-n62ZXLohv1PHL7mgmBVf4qUdp3Bn1gDzJB8ScAfWAH9lrFA>
    <xmx:MXo4Zhkz9_5VYlj3yTQAzVl9YAVZHx6xuVRVG-fTvW_IpPdo2DNSCw>
    <xmx:MXo4ZoBuOzC4PLtDGcd7euoqKHulv1wMM5dpnFPftHprzmOVLTDwl9Uk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 02:35:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6fc93997 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 06:35:20 +0000 (UTC)
Date: Mon, 6 May 2024 08:35:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/5] cocci: apply rules to rewrite callers of "refs"
 interfaces
Message-ID: <Zjh6K2mxcwTPIJgY@tanuki>
References: <cover.1714717057.git.ps@pks.im>
 <5109468b356637b8b4521a3e96ba228622804ca0.1714717057.git.ps@pks.im>
 <ZjUxlLyyvmHNifDp@nand.local>
 <xmqqy18q66sp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8aehxpeTEKoXl3E7"
Content-Disposition: inline
In-Reply-To: <xmqqy18q66sp.fsf@gitster.g>


--8aehxpeTEKoXl3E7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 12:20:54PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>=20
> > I don't think it's wrong per-se to use the_repository here, but it does
> > create something to clean up in the future.
>=20
> Very true.  This change can be mechanically reproduced on top of an
> updated codebase.  Such a semantic fix should come on top and it is
> better to leave them clearly separated.

Agreed. As I mentioned in my patch series that gets rid of `the_index`,
I'm taking a bottom-up approach to these kinds of refactorings. At every
step, I want to move `the_repository` one layer further up the call
chain. This of course means that we're now in a state where many of the
callers already have a proper repository at hand, but don't use it.
Those would then get addressed in the next step.

I think leaving that cleanup to a future series needs to be fine. While
it punts some work to the future, that is a necessity in any large-scope
refactorings like getting rid of `the_repository` anyway. Otherwise, the
scope of any such patch series would likely explode.

But to me, the main benefit is that we do not have to worry about
whether the refactoring is correct or not. We know that it behaves
exactly the same as before, which may not be the case when we started to
use caller-provided repositories. So I'd rather want to keep mechanical
patch series like this one separated from patch series that actually
start to change semantics.

Patrick

--8aehxpeTEKoXl3E7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4eioACgkQVbJhu7ck
PpQcvw/9ESIn+WX6PHs0ZiOXcrHiPr3f15jWsp/YR9ouKUXjS15zy/JfKXbTH8sA
wI9hREwEMUsJB7/1Tpk9lxguu9BT0Obfdr+lQUlDOQWL1X0IBzxvHd/nMoFtqbw0
YoLI8dxnNh8d2eYpVnTj9TD9VFi5fodxas0v5tR+j/oF9RKs9MMRsPq2ICOuOebd
2yeexGNXtPDfjWeldkcKyLbUvILcHUK4IXv8hJ3PiSkVNjvrElrdvKnpOzM9Jui0
QVUYPH431epuKG5sbCLuuM54/GqP83aFVR3Q+r7Hup1if3zUf0rgM9fksDzmjWUA
ffMa/CC89+f3nCV19JgxqaNWvZbe+Kk9UsAuumJ7DHFfzja/c2UJmMDc9Ht6oKAJ
JLZmhDBNS/G7cxeY/mzlHOTN79n4brt2fkK+UpGboU4uAfl6YUkphxBzadtztqHv
deHi/Vsu7aJ580moc8NJ0SZtfFD8ynkvqG6u0RB4N4KjpWSFfh9zSsI9k+iJuhUU
fhUP4h0AVVUjjtTQLCjPcRli7H1VEN6uoGkJwr746ughTbkn1PhtJCI5/lc5CsnE
W5pLpoBPGbmrMY14orhLSONlZHpmk5sJ1CFdij+96qP69F1ewafZ+RX1+NbG43tY
C3L4mTesJpFkrj16AtwRrXY+RRj7Y2JDd9FJ5AV5KX5zugXyGuI=
=OUMm
-----END PGP SIGNATURE-----

--8aehxpeTEKoXl3E7--
