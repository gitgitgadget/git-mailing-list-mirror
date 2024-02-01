Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585EF1586E6
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776783; cv=none; b=KzW47GjOzFkKlPH0nIqgNRIUP8ECKi2ngAhVhbZxIVo8QZLDfO8VuYxxBYmX/rW2RqmdYy27a8vXmUKg5WHxAHOzMjeICBcT2R50KfHhqVIOkOzPadFb67NISiDKMjAFqo1zHW1fHzBWKvaOnh/khyHCB1N0pzHsxKjhcg83aiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776783; c=relaxed/simple;
	bh=Dp3SXomAOCJS5i+prfRT1aABK30qk7yUPZKhbfzc63A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjeXntkw2At5DCzHLq8zjCb+RMgracep/FnBFfrBws6sV0Aw7zn0NyjtrgiEe2Zmklo2kQyQV59aiE0QA21ADYIc74BMgDnk//Pi5IhNBbbHUzGV2ImOR13nIQqkxfepHE1An6BUAcKW/Ky/JdUkK4C6sCmEQM4Ekn2mBpey1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l/mY2OgU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uJhZ38sa; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l/mY2OgU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uJhZ38sa"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 356B01800087;
	Thu,  1 Feb 2024 03:39:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 01 Feb 2024 03:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706776779; x=1706863179; bh=eEXYbywNtp
	1YPb3PIWUJlRAKw6sKXo3SpOX5ZHIXJcQ=; b=l/mY2OgUK/1l6eHP1XbehWbgFi
	yWUc8ga0Mquv/EvMMu6Sxf6q7bjsvsKHySYQL34UTTk7ZOuviXayQHxP0hHQe/wl
	d5YI1ucgxk3v3jdKoglQH7i4O9fi8ZE1raipeOE2QsKbD6hnH1AMDRfBnj0b/PHT
	2iAjKTWOgehdsuQUlv3cogLJydz5a65jzMAlT+LKI8Ehcus8wQTrTxPalzO6lieM
	LZfa8NXVvdHK3k4zgDlZysoX0GizhpokdUWlyZggL1kWmdySY9OTkFk/sao0Tra0
	T9U5vbETyFL35SIxsNq1FbKU7FXxoB5f3kX7sJ4wW99Afm5IH6vzmKozhXCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706776779; x=1706863179; bh=eEXYbywNtp1YPb3PIWUJlRAKw6sK
	Xo3SpOX5ZHIXJcQ=; b=uJhZ38saOTWxecGVj4Yi5qDZ6RnhrugmiG5E383RFscA
	KRp5//0lnSr5o11jjFkvyZG7dvdfWt22TqPPGSiUK2hkZg5WjfqAeID75XjMswPB
	eF1KhfrauC4FCf6tqQxnK3Ww/7rHwiT40I6CHhzc4eWE9lVtiebB2POJnYuIYM6T
	sxaJExxze+F9JMLFd5whRDV8zHb8z6kzrRPP1DblAS5n0SN9IBgYWxLLsB5HRO3F
	wU7ES0le11f1juVO5Hkl8SdfdWw5OQhDFQBDdxJ4nCqhos7QZ3hR+4/E3djbVJDB
	rC2gKDwhXPBPpJ9H4uiMkAZKEHxQ9Q5dFTjjY3ZheQ==
X-ME-Sender: <xms:y1i7ZQub_TjDTjfDLn7Ns7aTdTY_MVVwrJpzx0dOOod5t08T8sqZcA>
    <xme:y1i7ZdcBYd2jvwAXZvhUtKONQsrchlb2IicO1EwaY80rxHviOcMih80iCiPWmPy4a
    kos1LhgIukBr1AJOQ>
X-ME-Received: <xmr:y1i7ZbxKiYU9TnYxXqevT2OPKMniFQO_MnufblFO8CXC_LHRhRt_OrJfVSg5cbCyIrFdfhptBGBJJZrcSBZonEv5VWdIOIEglAlmsxYCUDPd6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtd
    fhgeeftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:y1i7ZTMmzWbeHXIJBHapulu-KisO3_PbnUAolCyq0VEl576kcuEG3w>
    <xmx:y1i7ZQ_a8sKT5q12gbvuP1691OUvWlS-xukXmlHkLCInsmNMgVDtVw>
    <xmx:y1i7ZbXuCrplJnf9_5I2LNL4U3NmHpBI5unie1x62Jd2Krop9zU9JQ>
    <xmx:y1i7ZSJ6s4heTxljRFUx96BzsEC7vivTQ4cmy6LW6xX_fpkkY1j3GehSRqs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 03:39:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 999d03cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 08:36:13 +0000 (UTC)
Date: Thu, 1 Feb 2024 09:39:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] reftable/writer: simplify writing index records
Message-ID: <ZbtYxgpK_FL3vYL1@tanuki>
References: <cover.1706263918.git.ps@pks.im>
 <b0982baacf74a4501ce5c543b294bc15d6937875.1706263918.git.ps@pks.im>
 <b96f8ce1-f597-447b-b410-e135626e03d0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JzAftr9f98Mnxro8"
Content-Disposition: inline
In-Reply-To: <b96f8ce1-f597-447b-b410-e135626e03d0@app.fastmail.com>


--JzAftr9f98Mnxro8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 04:55:33PM +0100, Kristoffer Haugsbakk wrote:
> Hi
>=20
> It looks like this isn=E2=80=99t in `next` yet so I=E2=80=99ll leave a co=
mment.
>=20
> > @@ -405,6 +405,7 @@ static int writer_finish_section(struct reftable_wr=
iter *w)
> >  		w->index =3D NULL;
> >  		w->index_len =3D 0;
> >  		w->index_cap =3D 0;
> > +
>=20
> This part and the next quoted one seem to be an unrelated edit by
> `clang-format`. They could perhaps be grouped in their own patch.

I'll just drop this newline change here, it indeed does make the reader
wonder what's going on. I'll keep the other one though -- it does not
quite feel sensible to move it into its own patch.

Thanks!

Patrick

> > -				abort();
> > -			}
> >  		}
> > -		for (i =3D 0; i < idx_len; i++) {
> > +
> > +		for (i =3D 0; i < idx_len; i++)
> >  			strbuf_release(&idx[i].last_key);
> > -		}
> >  		reftable_free(idx);
> >  	}
>=20
> --=20
> Kristoffer Haugsbakk

--JzAftr9f98Mnxro8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7WMUACgkQVbJhu7ck
PpRdfA//Q0xXn1qRB3WPPCvH2xONq6IhgxOuKxX4bZeBM2IG8sjaGnB/ji9f0A5R
wCPYCxrh4zuM6NP0n7y6r0x53/2uvMOgNETjPQLE2o6ADOTmh/fW9GWw5ajlsdk1
9FcOo4qWZCvOnl4gKNihfsOXyqy6mJocDJqTTGlzb/+m+vVgUVA0yY9H5wRVCWzn
zyEe/WLG6FqGIiFtJYoi33ekCbzPgAHegdfAXoyEb9m7+qvDvGIJrLVJvRAHpKIX
F3ExlhQrfjVdV9ZV322yO62fZ3Qx0cGRcrbu3wbXu4aL9O7WOXB5X3+0110Vafk1
brzgkxdATZ7eo+3xQT6celp5+MeO08L9ZXwkX1iv5lheOmUIFWmZYI0S1GDOQ0M3
tIe/03SA7OaeOegG1z3jZu7r1nSlFVvQhULnS37UqQxa2aLoWo298UGpn57tYetu
u2UWwhTAi7SUR6yYJ2yQBQpW2QIVUQC6rf3fppr/pRMVQGCzstVHE7lKpU6VQ6xI
v7QKU08wFmKQ/ztbCTe8fmq7/y922MyFjLbuEWCRrdPFNlyvxmKC1nYK+DYoOPRj
U78ogsD4/luz3c+iHwZ1+uFUwUe+/pcmEtbCWrwTpquFoLnk8rdUPH9INwx8EamR
tEOOWt9FzXcef+PHc2W8oMMRUWB8zL1s5Ns5nO/H4kirt1ORwPk=
=GMp7
-----END PGP SIGNATURE-----

--JzAftr9f98Mnxro8--
