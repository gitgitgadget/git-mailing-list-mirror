Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED70F1CAAF
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803821; cv=none; b=BA4dYiPQ37hut5nQxng2YOM+rrip3y38OmAwKhnxr2mGrnnZ6WlRBaplt5U9QH05PV/4dHJAobgNXmeRMuf4legiIAgEXwYNolcrtmDZeXWlbfU+Dyoey10GL1SI/RM4NOU7uho2LMBOncIi6lufKmcGFqQPhfEHWiU5esWRgNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803821; c=relaxed/simple;
	bh=vDXg/qT4ZtZ8++jaOSNqa1ZHIkf0i3uHNKo7A8piWfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvUEgRhQKERpy3nGq9OxQbH7Rf/AsMwxwGOa+niKfL8b6GT+81umUogq1PAnt2gEMRG8wuFupcqEHzUQkC87KmRPRoxZyu0EkyAANzZ2rZws8CW+fetVqOWBIUtvP24xTM7Rhk7NHNb6pLRpOmd0HLrvenjXVJEMqY5iZKZd650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ap4nc/sD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BvTwPkhV; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ap4nc/sD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BvTwPkhV"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 13BEC138057D;
	Wed, 24 Jul 2024 02:50:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 24 Jul 2024 02:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721803818; x=1721890218; bh=CgWOmYNIL5
	+ALhWT4zyCzEy7kJzAh9x3lYV/Tnr4mXY=; b=Ap4nc/sDcLJ0LQEr/+69mwXd3T
	YyobDCHSMTALJfpW9iThYwYBsqw9l6pFuIp3KRe6jO29CxuXl8tyJhkD6dyit9wP
	flzLfld0IbYWbs1dDWKdhheQHwbr5psP8sNFg+pHCf4JgwnedAqRuQ03+Po6zwGb
	pwGD7GZ43d7lzFrRX8VfO75M/vaRl2bAZpOKKO3uQB8f+tUag6gKhTE1WqKEuJBl
	ECkbUfyLPK69UIe+0bcofmrnCNDZdgqi9NeoNVPAWD5lxQIIfcn7RQIy3uGB8Ebo
	p9+b+9BgrTERuwYWO04Pmw206T/LfwCPsiGI9nYHAkYy9dAYXIeCW44m6UDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721803818; x=1721890218; bh=CgWOmYNIL5+ALhWT4zyCzEy7kJzA
	h9x3lYV/Tnr4mXY=; b=BvTwPkhVP9hZMnOE2HJ6Pdb38sTiIEBcIVVlXYSXzUVd
	eZe7Qtq90mchtQO7Bv26xHAXIHyPf09390DWsuVbV2Y2ecUmRCGGpSRkltVUZYoo
	6C7U3sRWhDQf/zFWtiCi+a5N49aMkwwc9tVsDX6b9CYLcAgjybMyIhtYOUyL+yQT
	LfjZahc93i0gv2JltwDY5u6LzxUczdgZXs8re75Jq5rx746TdMZdZpYtveNM5M1n
	34avqQsp3IhWYF1uQnXnNOJ1T8jScuJ04NU4x/S3A/nneqtQ+TVqJZOfSDwyJhiG
	sItKrqZKjH9jSXYdqM3y0M1LUL3HnPsJMiDNg6cvig==
X-ME-Sender: <xms:KaSgZgEu6R2cZSG_FATGYoOj03-lkQ8jGYiI0-MKzRmrem889bgPJA>
    <xme:KaSgZpWYf8psJbNaXxaSxB2GdpANPK8UzEJNM-mtOjFygSCRgChqkhEOcITZQQjSD
    13AZZJNKy2f6Dyhdw>
X-ME-Received: <xmr:KaSgZqItJrJG7-ETBEq0a3kqfnPpmu5oEl4WNXfo1bgB190j_Pe2gMUzcDHr5tezs2o4kc5sSBE_5F2DmKK9uLA1z6rimriBP7STLZQtFxOL2qKT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    pedt
X-ME-Proxy: <xmx:KaSgZiFmfPlynpKph6h-iAn8w-RNkVQfKutiHOcykEUqSo93TatCMQ>
    <xmx:KaSgZmXmaP7pJQA8OuuykjIIQJHFZM6bSECAljU-DbccD5wlTy8JXA>
    <xmx:KaSgZlNzqw3DEcDJp0rGFszYPl2MWmgEG6wVheH2Y0zrCQOMEPVMxg>
    <xmx:KaSgZt09vpgc4i3uCCIXPPYatJrCJNbmfeeiwG2dduPCqbGil0N0eg>
    <xmx:KqSgZoIVck59vtKbN4go-h0K0fZxXT3X21khsN3hmFMU6dozYxDYJT_P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 02:50:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5f13e729 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 06:48:58 +0000 (UTC)
Date: Wed, 24 Jul 2024 08:50:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, gitster@pobox.com,
	jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v6 1/6] clang-format: indent preprocessor directives
 after hash
Message-ID: <ZqCkJHC3ivdNVm9E@tanuki>
References: <20240718081605.452366-1-karthik.188@gmail.com>
 <20240723082111.874382-1-karthik.188@gmail.com>
 <20240723082111.874382-2-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IXvIjh0yn9GBkW2p"
Content-Disposition: inline
In-Reply-To: <20240723082111.874382-2-karthik.188@gmail.com>


--IXvIjh0yn9GBkW2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 10:21:06AM +0200, Karthik Nayak wrote:
> We do not have a rule around the indentation of preprocessor directives.
> This was also discussed on the list [1], noting how there is often
> inconsistency in the styling. While there was discussion, there was no
> conclusion around what is the preferred style here. One style being
> indenting after the hash:
>=20
>     #if FOO
>     #  if BAR
>     #    include <foo>
>     #  endif
>     #endif
>=20
> The other being before the hash:
>=20
>     #if FOO
>       #if BAR
>         #include <foo>
>       #endif
>     #endif
>=20
> Let's pick the former and add 'IndentPPDirectives: AfterHash' value to
> our '.clang-format'. There is no clear reason to pick one over the
> other, but it would definitely be nicer to be consistent.
>=20
> [1]: https://lore.kernel.org/r/xmqqwmmm1bw6.fsf@gitster.g
>=20
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

This doesn't necessarily have to be part of this patch series, but I
think that we should document this as part of our CodingGuidelines, as
well. I planned to send an update to the coding guidelines soon anyway,
so I can handle that once this topic lands.

Patrick

--IXvIjh0yn9GBkW2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagpCMACgkQVbJhu7ck
PpQpOBAAmOHh/cGkip4hGH9e1Jrk8SwTHdi/UsDhDZVEtlOHY66vgwiyA0fcGrGc
vUDxA9eHpX5oC1zIFi9vqTOb4fXGJdUfUOSXSFWIpdPAvSB1W4/n6HUHgFmP7NEM
Mx6UQlC+f10DeM806cW0b43EzI4olCM00TZ1FrMaXAnWOSip9q+A78XsTVyflOVh
Gyxzsl76n462QGGelLA98/uHfbO9aYxtYn336YMNjLVqk/ovjj2EEhmgThIEtK32
845h8EMBos/ssWMIBBuqGqWI+E3+sSS0NOB9QnLrj5vosaLX4ASB3nClR6SbvmN8
N+0hi3VNHvOaN2mNxD5giAxjE5x/Kn9OL1FBR2sDsNZzZKAHf7TIW0/aCNAsyyT+
+X4tKhduGqxPHEp+MXz6oJoXHf7d1LZ9mzPsxQzqwby3+JNTDLVboyo6t7K8LL8E
8bVCOQwsGxn5alLrxYBrbprgRLXB8Ao9vdc45PBJHQwCgLkBARkZNAAeL7zDPcnC
GQdBz9qqul/B2fwsCf10DazmLGmWtgiyK1xjc+/o1uEMDqv1DLu2GV0Nslw8RTQ5
L5Jo1m2R9h1TRcyW8RAxT0WbfCz3XGCTvEpkXAEaS/Dl+vn2m1quuiijb7XuKV93
w63RjrTnxqLQyWlDtC9mNQtviF0vGO2B+kKMM2ebwOIssd/x3Nc=
=iSaG
-----END PGP SIGNATURE-----

--IXvIjh0yn9GBkW2p--
