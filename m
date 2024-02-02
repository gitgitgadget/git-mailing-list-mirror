Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD3817544
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706851308; cv=none; b=n2vcF6tMHPOuf5o5vZ0jqlJhXB7ysENcmxt4Mxz2ILRSPA1CpF7QPfbramg5dwV/YUVQnngA80NEkKUID7yqCvGFIfSnkUM1FX0XXSU86/dDvrp4XmOEfp07WXRW2VN9JBX9nMbSzdPuIHOjg03B/bIQnM/chxzs+yiL/DjgpYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706851308; c=relaxed/simple;
	bh=AToaF73Tk+Ox3GRj9COCEr9HdDtbfA8tgVZXoAwMdkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYY4rcL5WQEcU2FNjx+PuLH2PEtYUxZMRkiu0WmldgfvFIvHmEa2FPv9Ia8FtdULKlCukr0a5S8jiZgL24hhFuiY7sW2tD21zFFZJIDvdQSM6UiN21wESfzSHxSkXdjMpQJGpJ6YYG4nwW73KMSjX8VWD9UfPawF2/0MT9hso6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H+Vw/xTl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h29Z885a; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H+Vw/xTl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h29Z885a"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id ECD381C0007B;
	Fri,  2 Feb 2024 00:21:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 02 Feb 2024 00:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706851304; x=1706937704; bh=kyo9iZ8y+v
	fqVbCWfQyLyiNgbIUJGzMgBeIOc9zNL6s=; b=H+Vw/xTl0C5bGKBEsWwyycXbv8
	Eo1NbgRqCs07ELz7neVWxVE29h0MqvIJGqoDVL9lI+nfNZPmfjgvPdigEyxlno/F
	rDtOd5QDP2jnjkp0yxya4xAftgEBY2DAEYlvXcbLSCJJAEdW/5MqZ2M2xtyFqOl1
	X0CnGWOfO1aok8BdirAqSdwFTbY3rqT5j0DiMpCLzbH2KoDuBbPye1N4Xgka5A67
	aZWoXckUKf6kPFU9S3luRu7FeSrqV42erLR6+B3Hj8n112CXpKGry27n1g0hHv3u
	yxKlk11lrEPmFn85kH+ddlppluMsCM3CCiWcd4V2kjENFuBQTce473PBkr6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706851304; x=1706937704; bh=kyo9iZ8y+vfqVbCWfQyLyiNgbIUJ
	GzMgBeIOc9zNL6s=; b=h29Z885aIEoijZD/4SRZUlFiUiF7AzJgP6mkFOZJiEou
	cabmkAxCMu0IWJynHfD0KJVBWLp6yFPSstAz9JXTcCJDAbLdK+LTFSuCs9IwUS6B
	1FCk5/8kv8RXgQUFolzioUQC8jx2sMOoKUF1yPL/hd5BigYwE2ER6yCtSs/W5qeL
	2Uajh+DpNJxGehG3rgc2A6PP3SwKPGCLzuxrUZxZ26G1Qf2XSw6G5p3vPnpissXG
	xDZ+W8z4a+G1jJ5T7eT1wnusD6MGcCbXeQHHdmg19hj6pdZeQ0RKvLVi0CV+85Df
	g+HzQwY0hSN1E9gWEBOxDlkrRPQklE1SlrB8vXrMLw==
X-ME-Sender: <xms:6Hu8Zdn4OdDQF1aqCtsQG3-7F1T8HMKZche62SzbX5HPlk84grjOaA>
    <xme:6Hu8ZY0GRJy8O-gYAvYKjaZUF8ESjq4ctjy_Hd2SDRkuzWWNLktSvSULqtmoxU2tw
    A4h_htLo0EFcfzr5Q>
X-ME-Received: <xmr:6Hu8ZTrQNe6OOlvkD7wFox6gp5ZPjB8yz36Ts5utWuZCxeent5dNaIlMQCT5JSXBGWE974ma8R5bisNyclJ_Ze4ma5zHQdgPUqyFfzmJaHKOTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedufedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:6Hu8ZdkwWUxR_cEbyxE0InBjUfd96SP06iG2EhtvsJbPgSO9n_pD-Q>
    <xmx:6Hu8Zb2GLBaz9m8M6ghKhILO2CJhJHldNNFcLepCCp0ZtXcD48MNRw>
    <xmx:6Hu8ZcvIJQ836Lb4Itg4dQ8y66Ly0FDrz0CNjszLiWSseoB-9UiMTQ>
    <xmx:6Hu8ZWRqLmasrnpM8FfiY76qANNafCMX_ur1_flE6rZ3rXF5S5eM1MmjQ2g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 00:21:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 931d9ecc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Feb 2024 05:18:18 +0000 (UTC)
Date: Fri, 2 Feb 2024 06:21:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/9] reftable/stack: fix parameter validation when
 compacting range
Message-ID: <Zbx744Uln_UyyyYi@tanuki>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1706772591.git.ps@pks.im>
 <f134702dc5f656942baafbd80af46ad928ee1449.1706772591.git.ps@pks.im>
 <87o7d0p38k.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2CQITrvQcbbFjoig"
Content-Disposition: inline
In-Reply-To: <87o7d0p38k.fsf@iotcl.com>


--2CQITrvQcbbFjoig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 05:15:14PM +0100, Toon Claes wrote:
>=20
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index d084823a92..b6b24c90bf 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -1146,12 +1146,14 @@ static int stack_compact_range(struct reftable_=
stack *st, int first, int last,
> >  done:
> >  	free_names(delete_on_success);
> >
> > -	listp =3D subtable_locks;
> > -	while (*listp) {
> > -		unlink(*listp);
> > -		listp++;
> > +	if (subtable_locks) {
> > +		listp =3D subtable_locks;
> > +		while (*listp) {
> > +			unlink(*listp);
> > +			listp++;
> > +		}
> > +		free_names(subtable_locks);
> >  	}
> > -	free_names(subtable_locks);
> >  	if (lock_file_fd >=3D 0) {
> >  		close(lock_file_fd);
> >  		lock_file_fd =3D -1;
>=20
> Technically, this change is not needed, because `free_names()` deals
> with NULL pointers already.

It actually is, but it's easy to miss. The reason why I've started to
guard the code isn't `free_names()`. It's rather the `while (*listp)`,
where we dereference `listp` unconditionally. Before these refactorings,
`subtable_locks` would never be `NULL`. Now it can be though, and in
that case we would be dereferencing a `NULL` pointer.

Patrick

--2CQITrvQcbbFjoig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW8e+IACgkQVbJhu7ck
PpTX9A//c5AISVFR4MVBw919Nw6K+WKRleYleU92ezgIW3RtkYe1l0QeHVLKWbnJ
up3CrGQGbLCfJ0Vix66nXLsLJ6WzqS/FiXNVydTYWw3DB1DYM65HUyOUnTEsETFz
hqDuJdfsP+pddTZ2jzGiSL52Ej9QKGfufn8Zr9/4Hk19AeOY1fq3vz3NjzPH59o8
C6Q1hol66hDj8QhTGElhKGsXs2flF7/czVPOytfaFy57d79Rc3XMYaslTlHI1otQ
7/fDHZjQGTMt7siMObceIJeS1qGD8907TMLBvT0wi1quVWZJdpAjKLSnE2g4Vvp1
M+gbouBq1hYnfS9TPSO5lbUqXjSeoa8UZG5uPnEV5olA0nCzPCzyBGy/vUEzJNxJ
zQXObJa5VC0TZBgVqt3+mss5K7D1y90w1QUtHi8BTtupo5R/XtI23lwYWPYkgpBp
MkkDeSOzMt/HaRxw0yA0Li+/JVFLDQ2AfSGVknGed4L77FclcPRgGI9o1uyBnavo
YPekfagMt9mJZ2sRe8CK42VhAfsDg0vF3HrUB9sKGirRxAdBLhlpBMjIECc+WFKC
D3C99PirxVJUg6pUj+nYfrvp3P2ioSjXFF0dkVKdAGizN5g4vy8/M+EIwrEZv9Qt
qygnbGWsMiKycFSWb/+gulQ51kLQXvKPkXA+ZpelXkvundnf4wY=
=5K9L
-----END PGP SIGNATURE-----

--2CQITrvQcbbFjoig--
