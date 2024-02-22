Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10C45975
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607842; cv=none; b=Ks1Z7I9uuzHqApG7j4A1BjgOeC69b6xy6DtdbrHkeU5o1ESqy8hbnpzOXC8HdJwfPWcCxf+VDOqTCPLnkpJaYHWhTvGnlCQvpfmr2WcXq9VTEeUNfg4UbDoVVVL8NkOP/mlIuNFykPHl+JWy7drVUXzmVgXCNrwepHkIwjZwOZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607842; c=relaxed/simple;
	bh=eUeq3XFhTyqAPcFk9hTCPzOkXa9eVSYd7OyNgVMpLpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJgN+i0rY7/9RcH/MKyMU5IvLiFlisHywb/1WsKRjcbyCcLQg+8eOIQiMQvdflTHPHboFiTiLTtU3V2b3/XR7ON2CEsuFvoU9a0yU9RLTZikBmZvqQGlsKscITC8FPo1Gf6lxqYVaCfIoc95nxDBanT+TmScXdm0qOz9lJ1rWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EuuVuj3M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HoQLwUrD; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EuuVuj3M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoQLwUrD"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id B0BF01C00086;
	Thu, 22 Feb 2024 08:17:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 22 Feb 2024 08:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708607839; x=1708694239; bh=N+VWDXmPpt
	QRbBziObKZoUQ+oOkMb8xKsLfGv08KTdU=; b=EuuVuj3Mf2Qg96+V5deDKmDhHR
	guEnAML6gOsgOSM6xO82u4r6Ic1C9IbqprejKQfs3iDeIlcBKyhn+1SukrGNP5J6
	YCHMMcaVDJ+Hm5zNXrBOs9W7T4Ri/otW4n6VpOReBP9CI16PvHTW2uGH+8NBJZtg
	4nkZvCXH3NfnBV5RFcdwuB24mzDmaKlUS0+wHLw0H3c9P6bcRYpAyaQ/5DQAdIoC
	hrUBdEled/x0+xmn+0uWhMAWrhWZji1N6+FszTwFHVv/mFuda52QCutIzKOeeqJR
	+fU26kLtokMCZW40o1YSVpOK35sN9ZzA6jz7XTMw0h18Krnh9dvv5mldi+Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708607839; x=1708694239; bh=N+VWDXmPptQRbBziObKZoUQ+oOkM
	b8xKsLfGv08KTdU=; b=HoQLwUrDmH2GIIpdlSJc1MYVYZARW9PHwUzu54FuGQkH
	5IKyL+d6dY4VJMtZs5+KXXS0YS5xHmOye9BPhaRTN60+WsIlThG+ktLhbkWgluBL
	ENiQHhWjWhkL9lryImIDbLadI847kIDsqx74V8QuTk7K3hOxT/690pvjBfOAHT/r
	P+v/eBFGrA+E45koAKstwMRFQLnJdK7gyS83JuDikJHMC8BSyrla2bqvYiFbgBVj
	VtiM13UcQAdiSy14QNQm/IqqbRyNRIFzhsmZuRcBbA+DC0jEVBMYmRzhU7jDz81i
	PseigZ4DMgf1e5lwY/vV+OnKxR4iQk/qVkv4uAYUqQ==
X-ME-Sender: <xms:X0nXZXnwhTAZXXv6obAzzY6RucM4U1XTLmJBWkV1COMlDce9GuaUyw>
    <xme:X0nXZa01luS-1IuQW84A0kHZwtzJliKUWU8k9Vhp4ec1UjMottCuMvasMR8Fw8wuY
    4wLPgqV9aPmhTONww>
X-ME-Received: <xmr:X0nXZdqgCsHWMQY954vPDtev8-UGDUTijmaZZ2npY2Ulycku4JQgDBztBekp7XWVgkzhJk-UneYdrYGLRKHSg_qb9JnvzXD3qz3HwH6TmFyRqc1_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:X0nXZfnE5VcMyg7tqW344l6NpwUDzq-GYG7MflnreNusLjugst31BQ>
    <xmx:X0nXZV1YnJt6_cM-Xu1ik2n2_OgeWIZideqn8OOjRVqhJcincFtktw>
    <xmx:X0nXZevJl1UucD9oOL_p0Rv4ddGyhIwhhDmHGjDVNMCezmz3p6_X3g>
    <xmx:X0nXZQRZbE0pROv2YK0fLOoppsfXJbbSPGgX7jeMPdgW0xJb0-8scrkajqw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 08:17:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3e49aef5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Feb 2024 13:13:09 +0000 (UTC)
Date: Thu, 22 Feb 2024 14:17:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 5/5] for-each-ref: add new option to include root refs
Message-ID: <ZddJWWrSpxEdI6lS@tanuki>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240211183923.131278-1-karthik.188@gmail.com>
 <20240211183923.131278-6-karthik.188@gmail.com>
 <ZdcJzs2vNkHJsjyN@tanuki>
 <CAOLa=ZQkqC7ahWUn=9aZksQOietGEY9M9Chj=uLTPHoXm8MuiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PPf69zsFF8nEdjIT"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQkqC7ahWUn=9aZksQOietGEY9M9Chj=uLTPHoXm8MuiQ@mail.gmail.com>


--PPf69zsFF8nEdjIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 04:57:04AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >> @@ -2781,6 +2790,16 @@ static struct ref_array_item *apply_ref_filter(=
const char *refname, const struct
> >>
> >>  	/* Obtain the current ref kind from filter_ref_kind() and ignore unw=
anted refs. */
> >>  	kind =3D filter_ref_kind(filter, refname);
> >> +
> >> +	/*
> >> +	 * When printing HEAD with all other refs, we want to apply the same=
 formatting
> >> +	 * rules as the other refs, so we simply ask it to be treated as a p=
seudoref.
> >> +	 */
> >> +	if (filter->kind =3D=3D FILTER_REFS_KIND_MASK && kind =3D=3D FILTER_=
REFS_DETACHED_HEAD)
> >> +		kind =3D FILTER_REFS_PSEUDOREFS;
> >
> > I'm not sure why exactly we need to munge the kind here. Would be great
> > if the comment explained what the actual difference would be.
> >
>=20
> So the difference is
>=20
> $ git for-each-ref --include-root-refs
> 9eda75497d43f2f9c70c1e14afb865108f9b4b49 commit	FETCH_HEAD
> ee99ac41aeb4129866710fc5771f11e1c1742dee commit	HEAD
> 96c8a0712e569dd2812bf4fb5e72113caf326500 commit	ORIG_HEAD
>=20
> vs
>=20
> $ git for-each-ref --include-root-refs | grep -v refs/
> b4b94355057280749620c47999a4b45dc60f2681 commit	(HEAD detached at b4b9435=
505)
> 9eda75497d43f2f9c70c1e14afb865108f9b4b49 commit	FETCH_HEAD
> ee99ac41aeb4129866710fc5771f11e1c1742dee commit	ORIG_HEAD
>=20
> This is because in `get_refname` we provide head description. But in
> git-for-each-ref we don't want this, we want the format to be consistent.

Ah, makes sense, thanks for the explanation! Briefly mentioning this in
the comment should help readers to understand this a lot faster.

Patrick

--PPf69zsFF8nEdjIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXXSVgACgkQVbJhu7ck
PpSTqw//RXTcoRsJmb1+CkQiVRfBysrKl7azm1yxLNtrYQjaSa66itwXYW5eWXdd
4p7IW0SMB60xIMTvAoRADSBqgrM3e1sPrj6o/ZKR3RCQ/KMxEs6X2UPvF1eaqcDM
AfwLY1/t7pB0a4yVuiFGY7wq+l9EV1ld1cPN6pIldPiKCUU6cvshvTFeig1V+xcJ
TVeCgWZslM53sh8Sre8t3DDLIbammnM3jlzPxqTIDlteGlh0nfcx/d10nu6xZZ1L
XeTHiy7TbhFKwF+XGaXbyavEYlFSwUIypz7V0BkChWgZRXUTRI4EjyBBC2CDQfE4
ou/Tutu+FzadwlCtAU3Cez0BC8RJ59jqVJjwOqCsbodniC9XHPWD+lvlOVIX78R3
nqtd3yKxSfa80HuZEKGNK/bnqtYtZa/Fbhd7hL8HX8AgEuXEOEOhB71Ze0EqgD0V
vnqncKezS5YWHbyGrq02FkNWqyTvQhkh4Yj5c8mtTdGfw48LT0tV4UokftIihmrm
9tkrr8JLJRPl3DRW3VgPMQjOJDOzLd4V+Fu8BNHzYhQvCmkP9yyQlJWApYWIG1m5
mKKri/viHKWFwScjzEwspSP5WWX2fjiUOT0MdBPfIKqVImILKC7AKqA1Wso8Yp67
rQkgwjM4Sb8BkRZ/ecLkbmYa9pxM+xWlwAVlhfkUV9kODv6hngM=
=H+WX
-----END PGP SIGNATURE-----

--PPf69zsFF8nEdjIT--
