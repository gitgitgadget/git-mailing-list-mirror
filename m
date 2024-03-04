Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1AC1171E
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709534657; cv=none; b=PBykbjdWvx5t/U3Fg4uSqu2w9ZWVWTNrOWLaf/0+bXBXNwJMVj34/HRUhNGY3JUW+4SuOPGiRU7+h3xSx4B5NEUnaZSMsRmvf0UfKikS5EcbxDy+xzq4uXKJtPAxbWRKlfBQ1dnDVOPZQIVTlOZXGEoLBB2HpVom4SDttzsyxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709534657; c=relaxed/simple;
	bh=m0kKO9yFQA4w8gI9fZayTrNbMj0idkJM4PWXhGK87DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6oMUcA6l+QvaSVnV3jWiAlS87fOiGAGWHDv1mY0N7aZoA84v6wHRYa7PWCJCGHLjVTNFu4hY0C00t6tnbMicE4ii2G3NOW1bZ5TOQWrmexxh8EkN6pmRFgTrGh8yYeFM+ubzAFTO8I2sxDhLAQHGohZzEm4eQt59+5JW81NdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i8xCCQpw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UwfJM2rM; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i8xCCQpw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UwfJM2rM"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id EC2B932001FC;
	Mon,  4 Mar 2024 01:44:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 01:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709534653; x=1709621053; bh=g9bjiZVGTX
	E/fmfdGdpnB+A/R5dNZjYYhkWhnZHCpCI=; b=i8xCCQpwH9sv5XEyeeg5+S1yBe
	7GvZVAQm31QJkntP5nGc44a1SuQrq1CjeVWuLGmEge4sFNGJZrG3uiAzNG62+9U/
	js+yuAgqWl0sUWDyJ5OICVTb55oOaOeBOAH7XENAMAw8803b5hNTnRTCRRgPJwiy
	Kdq3go5QvIzrxedFmkKUgUwg6RfMEC/ZQWm1GjyPwjTaT1Ih4z+BmoJIxVs5iuQP
	kZDbUPZqO+ACoCSt+wXZ3jWMB0JN1ULt2hTzxaS4JcXHh6UjzIcscPoVsUfBnVaf
	h98cHUrN+UhKH6pLpeeiMpTMTe1YEgL1HmuUHvcJn9PonrAmFvKH2O+MnxWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709534653; x=1709621053; bh=g9bjiZVGTXE/fmfdGdpnB+A/R5dN
	ZjYYhkWhnZHCpCI=; b=UwfJM2rMw14A53cslWSac2NCxv+yUJZ/YzQvpZ+XbmEN
	vgsclikXLU7aT3e5A5fbO0tQgYwKmwYfR+DS6yS7Z6MNfsBc5ES6lytF2454IB9k
	1GZ+JoAz1ASq989NiKLcxoEBlZog4vVxA/3vwZ893mMig9iII+8mK8Di7rU31TUD
	tQGkVsjbKUuLKFDXjcBdjdmbutb42PxV1swOCls6YLjR6oPLMJPRO7A6RuwQazR6
	FN+2HF2gr+fb3D+10jcb70rJ92UBWARhO6M7mMFfPJHHmS9hxz0su61jtJUQZxGB
	KJDwdcNVY9E5QNnT0kFbLMvxCF57+65MQykTCvmybA==
X-ME-Sender: <xms:vW3lZWkX9FSaYXjWFA4oNHQKB0Ceuh5DmcfNppybRTKjHjA630ZQ8A>
    <xme:vW3lZd1puGPckTiC8IIDKK-3CALB_XnM6-o9daxVM__YnjWE4NooF6-cucLWdaDef
    Jf_YMvu6z3kzJerWw>
X-ME-Received: <xmr:vW3lZUr5vVlTuEsHEg6i3RrHXanCEDn2olfb8xfjO-IbUns5zF2I8wTx1H_m_G6wf_TR7dVqrteFU86zu1y61V6XOOlgSFZRBsJQJB2-DgBE7dM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeigdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:vW3lZakM9yS6aARyGNyOa0caZhaeif0c-dbSI5NPPIWZYZVLPVkzpQ>
    <xmx:vW3lZU3-nygB278wrqqNVauTJxyCwswdXEVgwJo39ZksRQdDEYHK7g>
    <xmx:vW3lZRsRe8CF0cGnYLglNFgdRMNhe84B_kBHCuSpfIV3AX9Sb951lw>
    <xmx:vW3lZRxfDGOmCFkEJSSIWKGOZW6zl8hAcw06GpLNRqXeMWGoB-JwNQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 01:44:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a2d1ae2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 06:39:48 +0000 (UTC)
Date: Mon, 4 Mar 2024 07:44:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 1/2] refs/reftable: don't fail empty transactions in repo
 without HEAD
Message-ID: <ZeVtuqEAelfiA2J9@tanuki>
References: <cover.1709041721.git.ps@pks.im>
 <95be968e10bd02c64448786e690bbefe5c082577.1709041721.git.ps@pks.im>
 <CAOLa=ZSycN0iYbBP-rXKW5=tNJLaSd0q8+Vm=CzNfsP2nR0sJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n6yKll9dhdtIRWXY"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSycN0iYbBP-rXKW5=tNJLaSd0q8+Vm=CzNfsP2nR0sJg@mail.gmail.com>


--n6yKll9dhdtIRWXY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 03:32:35AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Under normal circumstances, it shouldn't ever happen that a repository
> > has no HEAD reference. In fact, git-update-ref(1) would fail any request
> > to delete the HEAD reference, and a newly initialized repository always
> > pre-creates it, too.
> >
> > But in the next commit, we are going to change git-clone(1) to partially
> > initialize the refdb just up to the point where remote helpers can find
> > the repository. With that change, we are going to run into a situation
> > where repositories have no refs at all.
> >
> > Now there is a very particular edge case in this situation: when
> > preparing an empty ref transacton, we end up returning whatever value
> > `read_ref_without_reload()` returned to the caller. Under normal
> > conditions this would be fine: "HEAD" should usually exist, and thus the
> > function would return `0`. But if "HEAD" doesn't exist, the function
> > returns a positive value which we end up returning to the caller.
> >
> > Fix this bug by resetting the return code to `0` and add a test.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  refs/reftable-backend.c    |  1 +
> >  t/t0610-reftable-basics.sh | 13 +++++++++++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index a14f2ad7f4..45568818f0 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -821,6 +821,7 @@ static int reftable_be_transaction_prepare(struct r=
ef_store *ref_store,
> >  				      &head_referent, &head_type);
> >  	if (ret < 0)
> >  		goto done;
> > +	ret =3D 0;
> >
>=20
> So this is not really a problem in this function, it's more of that
> `refs.c:ref_transaction_prepare` checks if `ret` is non-zero.

Well, yes. I'd claim that it is a problem in this function because it
returns positive even though the transaction was prepared successfully.

> Nit: would be nice to have a comment about why overriding this value is
> ok.

True.

> >  	for (i =3D 0; i < transaction->nr; i++) {
> >  		struct ref_update *u =3D transaction->updates[i];
> > diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> > index 6a131e40b8..c5f4d23433 100755
> > --- a/t/t0610-reftable-basics.sh
> > +++ b/t/t0610-reftable-basics.sh
> > @@ -328,6 +328,19 @@ test_expect_success 'ref transaction: writes are s=
ynced' '
> >  	EOF
> >  '
> >
> > +test_expect_success 'ref transaction: empty transaction in empty repo'=
 '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	test_commit -C repo --no-tag A &&
> > +	COMMIT=3D$(git -C repo rev-parse HEAD) &&
>=20
> why do we do this?

Oh, true, this isn't actually needed.

Patrick

--n6yKll9dhdtIRWXY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlbbkACgkQVbJhu7ck
PpRM5Q/9E+quTOG8v8ipMEuEmSGL7De1H9aoAZf0IBnBWeGV3ep8UDeifFY4hZRf
JKZWPAIYt74C9KgXnCOBTu8FyFh1sQkMFAYIuDtyhxQzO4WopfH3MMtUPQ9Skt5G
bjXBEGGttfOMkPagw04+RMZSPdqvEb7znH65hPFy5jwJ5oVrJTCosT/vun9olH8v
EYRX5vdcw83FBZR33cthWJPNivwD5BEBU1ruSPozONellJjTNJ0UsbslsIuXWfbo
3iNE9xc0vXB0AL8y9VFaaGOj+pAnKZSfIJ8Pl7e4QAOr47aXwR6yC3Mers4ThYAV
7PWjt1/tzn5Hz7/sVb47VnliowGQbKUejZDtLci0f1FpOp5OnBxQ+vR7QB/6ur4E
Grd+h0Mz+XFtXhUMXDQpdWC5eseb7xW0tRoPkENhDZjB+szYwndRev1Ka5iEBVbG
VI/BuMyo1yxK03Z3r7b1wCdYmBAWbFICTjUReDgUkuq8t+anDFEj5nmv+j2/IRzd
GU9fhisiR2vX8gbs8hH+XIua0zOWmX3BrsnBcP27djgKeCAtB6TL9K4uaZJerlft
xkzAdvYHGnJWoKSdApWOdcQwIsZYGXkyaJyxkR8PBy8+0yrbjBLnHxyTy7oCDPjR
B81pbb1RNSCds/yXcdygGdogXep3Pw6f/BGdOKCE0NeQUBxTAvs=
=hTlq
-----END PGP SIGNATURE-----

--n6yKll9dhdtIRWXY--
