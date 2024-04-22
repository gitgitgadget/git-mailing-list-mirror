Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB131804E
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765088; cv=none; b=fy7M6IUpJSFXHT5y8H9lBLLodVV7dtj0IlabMDdcvcq+3lbrx7QHwOTl9md7x18Jscuw3gHzToL9KbWOurdF7ApxIUhJTEwyshtvfvJ9gRTPrbmYX4XhYRoE39JYG0jJDViplMtPN2MkIlgmtHNwnvZWhEruR4Nipk2pGaALJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765088; c=relaxed/simple;
	bh=ry9QQCROoIY4TrM04Q2xoB//GZAyLzlOQ9NRUSyciUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNfaMT+m2VOR+OyGy7xUElprbBA46If2m0ztHtKbZNRfYnYeh2RB//GuhGcyRLh5tHHiABUa5bSi7so6FUhuJ7CALf8K+WzbzLkBOdpt0bmOBD/ffyNNqlIXiZ4waCbroTIReN+aftvCLCWMTvOIghQSD5MzdvUfs6Hh7K9VzBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IZXHQPzN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZELJUPiN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IZXHQPzN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZELJUPiN"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id D66F71380052;
	Mon, 22 Apr 2024 01:51:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 22 Apr 2024 01:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713765084; x=1713851484; bh=ieBoGEzS0w
	cObJfO+LdlH+RyNEI/u0T1l6hOQCq9S4c=; b=IZXHQPzNTzgql1DAr7VYTKFRtl
	GoFCBUnWifLcAw6xI50jHZfJXfTc0BNMEFwyi0v+RdcusgEuni+hFPVL5F7AU87i
	MGMsgcg2bLK78sJE83E1iA67UQbiwg+ajIAls2eeQ8YiIWOt9Ax6nmb9cQM7THcx
	TvH/lGA3LPlUnxrLm4oYxTo0Qk8uMnCDiGX18VelcTzVrja3ZHI3NaYE3te3eyVX
	jHcWGxhnWV0Zq6hut+ZcoOeBXMTvrxS5Ixw7YEaTWAX4e41EOAyakaj0nkpwK7JF
	bp1bHCXjruzP0CEsaxe0SQhfI0mBcOK8vtrEwINLcf3BYTA+HcW2esn/fKsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713765084; x=1713851484; bh=ieBoGEzS0wcObJfO+LdlH+RyNEI/
	u0T1l6hOQCq9S4c=; b=ZELJUPiNvp3Co/+U+pBN9JhvGrgV3wzMeRXYfOy7atic
	lBfybb6bemW0Xy9HWwMftwMoY8k3LipzzDJZdT0LjOek3rGNYQUX9qtdchuRVyUI
	BYN91l6IQCBVCz5Foufhsdxh4Y/lcZyTbvHbBar0cuxdHp0j90Bkx4uB7j014rJv
	ely2YNDKiOT3e2arlHljWNzaatfq5ZhQMWZdkxnfcX/plxq/arkHsbBM/uAlkZDQ
	s9RHm/v58x/O02HHdA1Fft9EDozD4MqMd7opEUHOEGX+5di/5bK80cAa9KXB/tqF
	QiZSiVlf+zcIOWrsTBvocVK++nVijlDNTzURoUInMg==
X-ME-Sender: <xms:3PolZo6dyfZDtIEixZC8hpuT67hfmR3EmmFwJ_enDbxfEkL5lUDz_w>
    <xme:3PolZp7FQ-LtM-iNnmXyfIoghPOdIALW2t01vDZzloR8a_8yJC11lJ9auHf61n0v6
    qOKtYomlOsBxmJ8Aw>
X-ME-Received: <xmr:3PolZndwb2MxKjBfPmnVfncfBnpBhJOR16oMbq_QoMS5gwXxghpoomeVBcIXrfE8ww7srO82OUvEogcO2l3GjhU9nDewAeH7Gvp-WEgvrLpA2wCp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekkedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:3PolZtI4FZodcjglB_pU3QMWLshAgU3PHfWvXU7QjpaVtzazDu97ow>
    <xmx:3PolZsKh8WX2e5qFjGwwapBgSBfjTJL99zUC_ZyXgoB0aDMfpFuFyA>
    <xmx:3PolZuzH9FoxzDrt0wVHbkv-ocd1tiTTWjNDoQj8ApPl9rJyMoZT6g>
    <xmx:3PolZgK5BA5GVn_pKtEQv0Q6itAQTSBd5wy9tkzJpyBmpgShg8iaFQ>
    <xmx:3PolZhGmvw2BDPtlzvHD59XkNf_7EHbu5I_Ea0jzk7iyRsPlbv09Qfwb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 01:51:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 117605e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Apr 2024 05:51:16 +0000 (UTC)
Date: Mon, 22 Apr 2024 07:51:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] docs: remove duplicate entry and fix typo in 2.45
 changelog
Message-ID: <ZiX616G0PPp1jICn@tanuki>
References: <pull.1711.git.git.1713642690371.gitgitgadget@gmail.com>
 <xmqqseze1seh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yohNLlOKGUeikY2N"
Content-Disposition: inline
In-Reply-To: <xmqqseze1seh.fsf@gitster.g>


--yohNLlOKGUeikY2N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 11:29:10AM -0700, Junio C Hamano wrote:
> "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: Orgad Shaneh <orgads@gmail.com>
> >
> > Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> > @@ -110,9 +110,6 @@ Performance, Internal Implementation, Development S=
upport etc.
> >     clean.requireForce has been simplified, together with the
> >     documentation.
> > =20
> > - * The code to iterate over refs with the reftable backend has seen
> > -   some optimization.
> > -
> >   * Uses of xwrite() helper have been audited and updated for better
> >     error checking and simpler code.
>=20
> Interesting.  It is likely that we had two topics that did things
> that summarised down to the same description.  They are=20
>=20
>  448a74e1 (Merge branch 'ps/reftable-iteration-perf-part2', 2024-03-14)
>  9f67cbd0 (Merge branch 'ps/reftable-iteration-perf', 2024-02-26)
>=20
> I do not know which is better between removing the second entry
> (which is what this patch is doing, as the entries are in
> chronological order of the topics' graduation to 'master'), or
> amending it to say "has seen some more optimization".

Squashing these into a single entry should be fine in my opinion. The
split was artificial anyway to make the review process easier.

Patrick

--yohNLlOKGUeikY2N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYl+tIACgkQVbJhu7ck
PpShtRAAodh/sqxZXNnJvza37BHdXVgV0FvYKdFkJTZW9F+WsTDz5QdJM1v4dp+e
63QUW2ANHwkMyXoc1bGXZAd2Y9lGkxo8/Y513MphqSliJ7UFp5PqTVQrNUfBKI68
g1Z9iwCj180MMBX9x8fBZNCyDtLjldQFFaGSeNHqdP5iTsgSds4SG2W1G2b9Fmqs
ZTbem7QEnegD++14GjoxhyP+Pe98TUNPHfGJdSvmtQC519NzYE7xMls1Z/mVGhZT
yl0Bz2kuCYonXVFMgw7BeXUyTrbPnRp8ia2+mp9K5ZOpItIAywEvRS45t408J4F3
7pRIsOYzqu8iKGoWCGTLVsy9ER0JtD4oet8RzO07LCUQyftdlegKLG0jc+6fmaIx
O962tS6FDrcregUsS3XKhijEn8NaPh49utEgf4HFkEG78u0F8LBI/xnUBSkATkN+
Xc8iXFh04NQwUSb/gMzam4osIPB47qzxCZhqv3n9J11/Nh/9C94uwOlF0s0XO4n2
dGON94JO7iFzBiD1nGfha0FZYSNEMmLu3f3JspC82yBDYo/la8hEWPG3Ey9XxcyI
iQ18tFn40jZ7dUTx5WhYgsLqIVzovzFWPt6wrg/rm9Ekryqig6xK6dH2UJbIZCCV
dA67obXZEGs1A1X/k4IXC/g32OWo+QbCdzHHA1Z75l87axcAAM4=
=De+W
-----END PGP SIGNATURE-----

--yohNLlOKGUeikY2N--
