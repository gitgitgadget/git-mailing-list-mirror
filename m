Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D972233A
	for <git@vger.kernel.org>; Wed, 22 May 2024 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362379; cv=none; b=oxdTHQcNcm1EIEKm1Nw1HRNPBEIpcf48ErXv0k0jOjxOwa+KUEl0nWpYDtsnbhdo3j/EGNsv2d7PXqS6wRqgPVy4kTjjSr6xAiBMihpeRW5+GFz3ZGem03niyySC8MYCh1XFEKk0+5/AdMxEUE3tRPg6eYcEIMT5H+oBCh+p6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362379; c=relaxed/simple;
	bh=Ljl74sWWXhdGSliXl6yqfSvYNEc7DiAwhs7w50dh5yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajps2bWBH75kur+NhqzQ+hNu24GUQUUvppCkobtxC81ebIfgMDu5xXFhWzNwTJcglNn5s6D29Hr3mx+WKOve3XunZ8NZU0AKZ51HSQsdvnnUiztGhDclPDUxzvS/pWOTVI/jOUaIVIg3hyhmpiqfxQpaPJ6U2zZo3B1c/ZREWjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QePKtOxu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GnT/3daG; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QePKtOxu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GnT/3daG"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id B11001380105;
	Wed, 22 May 2024 03:19:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 22 May 2024 03:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716362376; x=1716448776; bh=898m4tmjBM
	8bmptqiRlmleuED6yQNjct0+3Hq0sRpEA=; b=QePKtOxuavuJPmgVpwnpuF7OTR
	dEosfv4SUi9xSPNZ+IsBOlPovjEpxm88WrY10WpIODOLlUK7OV1G+pLmIwqWh0/D
	LzbAeCyPrkllcvePL3og7A913h1bMPZoR/nAexC2MG17DXL8wJrCZ0MGYHxknGSQ
	Xstgwfule459bHXjUwGWZvEj/iHbUup6se2b1Ybc0VWGMiFWPicGpRBzheJJZlCq
	WEhbdz/+R8tktS1urWhzl7t0fALVh0EY19QyKW4loHsOm/mRwYpASmxzOPM6QOYA
	k4hBEM4t2ayVfXfPpkDEQwrcQuubZGhMeaI7rLyWMKRKce5sr+/fWjNJ868A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716362376; x=1716448776; bh=898m4tmjBM8bmptqiRlmleuED6yQ
	Njct0+3Hq0sRpEA=; b=GnT/3daGUsnUKokdRJTXNntvLlmRYXc49atpWn/UokcC
	7dCN3f5C6uejVM9snIM/HbTj/7VN36l9RKHUOKwixLXjzuYZBtJpEv5o0Ob8sUN9
	x/04s0Txs1ewxSP6dBvexW+KmfaWtHYFAMgJUOXuGLU+B3RxGtt67NHLXkUG1KQq
	DezzMcDkj5gKJQWTgkJDwadvL/76Hvh7ttVNf2HbnLwZH6aWWiIexQpdWJTXlBA6
	S/p82llCcd8Klf2D5ih2hr9CDavjKdIUDt8+AGnmZKXNw7795uLJqRGlQphi8ZXL
	TGXXknBkGSU0z024ri8LIHyEhazlnUCtQ9UKAXaCxQ==
X-ME-Sender: <xms:iJxNZia2BNN0xQQgUz4RDH9ivM1R-lqdIufJvxsRppkq7BPQfHSaWg>
    <xme:iJxNZlbOpTvKZCarQH0VgCo7ca4ih6Z7OUfC6B7deZPoS-OSxDyOyB8v5BAzTagbO
    6fH7hFalG3bbgm60A>
X-ME-Received: <xmr:iJxNZs92oh_bqpTt8W4c1BgdT0u4Xd2fzXq36wrRQzUs7O3epbQIuYJQoyo9ABKNctvB6wgQA6XVZ9R7rvirFABqXfT4u9sHAUxLf1gDBs6m5oKz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:iJxNZkr8obwaa6kmBo8jXM4NGZXGFBat2hYNpgwNORsIHDraxQicKA>
    <xmx:iJxNZtqrHtZIF23DmgEWoRdLgZdfugqUxo8DauoQXzIe8SygLYGE9Q>
    <xmx:iJxNZiSkU7No21IxlJyHWq-FOumUeWDK91BhNGwBDmQ38xXXadX2Ew>
    <xmx:iJxNZtrM4nsO0drCrbdZY-sq51OQAl4-g7ug1qCaM09DmkklscJMGg>
    <xmx:iJxNZulc6yswl4dlSevXglQdWevkrBh8tYHeZf0cU2iVpyGbBnLjkZj->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 03:19:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 25aa65b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 May 2024 07:19:31 +0000 (UTC)
Date: Wed, 22 May 2024 09:19:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/11] reftable/dump: support dumping a table's block
 structure
Message-ID: <Zk2chD_uAScoQJB4@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
 <c4377180ef9c92a28fa71b1cde90d80d901c8710.1715587849.git.ps@pks.im>
 <t7vrnm4kgyu5kl6evrfm6pvhwffwi5tku45tjds7mz7rpip2hz@77zv3givo7pp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IRNJ0ZiT3JjYEBOo"
Content-Disposition: inline
In-Reply-To: <t7vrnm4kgyu5kl6evrfm6pvhwffwi5tku45tjds7mz7rpip2hz@77zv3givo7pp>


--IRNJ0ZiT3JjYEBOo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 06:35:13PM -0500, Justin Tobler wrote:
> On 24/05/13 10:18AM, Patrick Steinhardt wrote:
> > +int reftable_reader_print_blocks(const char *tablename)
> > +{
> > +	struct {
> > +		const char *name;
> > +		int type;
> > +	} sections[] =3D {
> > +		{
> > +			.name =3D "ref",
> > +			.type =3D BLOCK_TYPE_REF,
> > +		},
> > +		{
> > +			.name =3D "obj",
> > +			.type =3D BLOCK_TYPE_OBJ,
> > +		},
> > +		{
> > +			.name =3D "log",
> > +			.type =3D BLOCK_TYPE_LOG,
> > +		},
> > +	};
>=20
> I noticed that we are not including all the block types. Would we ever
> want to also be able to dump index blocks? Or would they not be useful
> in this context?

Maybe. It wasn't really necessary to include index blocks in this
context as I was already able to extract all relevant information
without them. So I decided to skip them. We may iterate on this in the
future as required.

Patrick

--IRNJ0ZiT3JjYEBOo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZNnIMACgkQVbJhu7ck
PpTmGw//Sg9d0gIiQ4+Nei9H2fRx0Yap/rUUxyIQU4XkQ4ZjnYOVB9h+/39DXakd
jvj3+DAvtgwiuqSkBTzsDt6D5bO5kF9dQnRtGoth5ksj7Aq+EDXLqub8b/VGEryl
DPcC65Mk43UpOuXVXT6/Ct0X413UpRk/vse39OtIwSydM9qjXYejV4I/Q7yBX1Ef
XoAf+bP1PhdIcnug1MoePXRgfb2jwqMzE0rNpk3CEJtzDPCg9X91S/e+OYR0gBxe
Gk0HnROs4ZeVD4Vkfmy4Na5UTmdYIJb0FdOT2U4wENt1vIElJlUrgzu2xnGoksNB
P6cxI8R5RvEQ9UkBLEaMQ+0TF01/go9olfRN1rvEbWWbkJdymlDN155/L4ZW0Pjj
97ABQdZmf7+ZzH8SAaZjnyUMnWka4BhGMIP1A6NpYUqJcaSRLIn2xCh2iitqOihi
fTa2eMjnLgrGpcAXV9TcfO18hxwdfYUKGAOc4IiQ1CmunXgLu7lvCJ+3VQTB4Ktm
mGiGQhHcK6XbOpZuA3mIroP+bH535oIKsN4W7p0BWF7MQw/zbfm6lwgifa3a5ZHV
5N9z5SK/6XXj8fBDb1yjOFyLKSG2zeDiy6fyCfAUncw9bGsY8ZkRcGEb9HDxp5iZ
/hfn4MJHECn25TNvQUW4ZhohqNF2XIHpU7htJ5m6XPZKHi02yz4=
=TfGL
-----END PGP SIGNATURE-----

--IRNJ0ZiT3JjYEBOo--
