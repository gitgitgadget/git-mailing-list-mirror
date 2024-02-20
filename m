Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBBE2E3E5
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418071; cv=none; b=oPhx0xk5Rob5CnwbL36IJL34ghsr0QebGzneM+gzmSj5gYXn+FG2ikWfingz/u/RoeTWb8kYAipX3uWd4AkU/xW80u+Pivatyn4ptWmX5FhVy+LYNq8XmUxvnhja5bQudXUP5fMPfmUtzWDDV8v85fmEPFIOT7PcQqRV/C71mMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418071; c=relaxed/simple;
	bh=ozDCCHaushRDGT7beQC1g6FsC+z1el6Ya0xYlzR+twU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3QJNTFHcaKVQmHr0V1JopAcGmuGz/xBmaiQSsd7yifv6DANFPKRquJj300nxagJ57YGCRa4ImEEVIsNgwN6cWVe3quAEJ5ZJVlL4tcvYox9/e6K4bqZHDDXDMMtzqQRGBH7mprV7z6uwtUmu7HA68kK8cvxRu4ahK+Z4n+FaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lhDxxGsH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K1RFc10h; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lhDxxGsH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K1RFc10h"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2B07A1800090;
	Tue, 20 Feb 2024 03:34:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 20 Feb 2024 03:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708418068; x=1708504468; bh=2fNWvosX1t
	mcBUzALBcnINBidFSQWShuwXbOwBW91Q4=; b=lhDxxGsHbnQ2wbx8NLibHqh8wn
	cF6ennfCHI14iQz0VHieCo+bGzPgcq7ru/B0cRf6EYflIElUhkATA6w1Ek1W7OqI
	+TLuypKOj1vAq1s9mNmMCku7i1zOEHMVy3NEbEyfVWYczJN6wc57RaAAc0doWFO3
	8MVGI8osceXDUpHZg9cGEpYnV2lm72J4oOLjD7tHTtVF0KGZXpTf0Xejv0BlrWAD
	kgzhinzuX9fjCvYSZ+xIMQmwBzct8Rmw6/Y+f4W1VhPjzXHgQixpK57KnteNA63m
	HnyzXe+kgod6c8iDz+bQBEOD5Cr4GBqBB4n0umFls3QR4p5CZ6EGyMw3XzXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708418068; x=1708504468; bh=2fNWvosX1tmcBUzALBcnINBidFSQ
	WShuwXbOwBW91Q4=; b=K1RFc10hkN0d3plfaV82kkYIgPsmXhjvdSHDMH4HJ2h4
	F1uz0dyyaCrbWAtSCVqd9AEhCg1OKd7YvSjkY5VASHv19xDL9I9BYC4N8y+JfKWc
	SiIj6QPJyC56Z5t3w5y6J0+tI4oS/bHm9hHYnZH5t36tq+LWjkfKdWL+vgkdMwNu
	7cd78TkJID4c7AofsbjxrZj6Y25lNq9WWZChRqSm9rSUio+lpeBT/SY6pJU7RLDJ
	/xCdKUhqQ32a7hO9rTR03PViLkZLRJXXczKWGXCz5NO5tfiZQxelsFS2nT/xhTP7
	/Ng038rRS/aoKe1FXRSda1OejJLvh5E8SfvGJIdrGw==
X-ME-Sender: <xms:FGTUZW0tj52G-3B8ZbXwOCFRmMlOJdHzyzBLEkpG-FS5bVYOAdba0A>
    <xme:FGTUZZFhOGesM0-ZMH5Mz0G6BSkvTXdUqCm4VoaUMjVISoySmDmpvZggB3ZVCnb6_
    Z4zhQ1J94M1XAkVeA>
X-ME-Received: <xmr:FGTUZe4otkF6dVkmpQHtKuFjkT565K6KYUaHtTnwF0SnXNAvK8DGspU-__NxrHndHNwDzrRzbtIyhMDFtHUUKrKIXF9TUunhoMowqrmP6Lfgqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:FGTUZX2toAdguGL_rnCMtqzw4E3FaNgqKQLKz8oulxjltc8Grv6aJg>
    <xmx:FGTUZZHwxyxDuAfTVOkPA0YYxaKOxLufnxX1ASlZ14w8OhrVYkI4Gw>
    <xmx:FGTUZQ9Q1rehjpZbSFNK5n_fWA42YItP23vNjbqdg94Y9gHUBYmtGw>
    <xmx:FGTUZeQe8IRz_ZLsOt4mj_CSUjMdqFIS4HtDYXfftEGuX5vZe-_vj-kKd3M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 03:34:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8f0cf9cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 08:30:25 +0000 (UTC)
Date: Tue, 20 Feb 2024 09:34:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] refs: drop unused params from the reflog iterator
 callback
Message-ID: <ZdRkEbh-8SKNteDm@tanuki>
References: <cover.1708353264.git.ps@pks.im>
 <be512ef268b910852ff11df181d89c483ffc18ab.1708353264.git.ps@pks.im>
 <xmqqplwsyotj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W0q+vAlKpSbWxuZR"
Content-Disposition: inline
In-Reply-To: <xmqqplwsyotj.fsf@gitster.g>


--W0q+vAlKpSbWxuZR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 04:14:16PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The ref and reflog iterators share much of the same underlying code to
> > iterate over the corresponding entries. This results in some weird code
> > because the reflog iterator also exposes an object ID as well as a flag
> > to the callback function. Neither of these fields do refer to the reflog
> > though -- they refer to the corresponding ref with the same name. This
> > is quite misleading. In practice at least the object ID cannot really be
> > implemented in any other way as a reflog does not have a specific object
> > ID in the first place. This is further stressed by the fact that none of
> > the callbacks except for our test helper make use of these fields.
>=20
> Interesting observation.  Of course this will make the callstack
> longer by another level of indirection ...

It actually doesn't -- the old code had a `do_for_each_ref_helper()`
that did the same wrapping, so the level of indirection is exactly the
same. Over there we have it to drop the unused `struct repository`
parameter.

Patrick

> > +struct do_for_each_reflog_help {
> > +	each_reflog_fn *fn;
> > +	void *cb_data;
> > +};
> > +
> > +static int do_for_each_reflog_helper(struct repository *r UNUSED,
> > +				     const char *refname,
> > +				     const struct object_id *oid UNUSED,
> > +				     int flags,
> > +				     void *cb_data)
> > +{
> > +	struct do_for_each_reflog_help *hp =3D cb_data;
> > +	return hp->fn(refname, hp->cb_data);
> > +}
>=20
> ... but I think it would be worth it.
>=20
> > +/*
> > + * The signature for the callback function for the {refs_,}for_each_re=
flog()
> > + * functions below. The memory pointed to by the refname argument is o=
nly
> > + * guaranteed to be valid for the duration of a single callback invoca=
tion.
> > + */
> > +typedef int each_reflog_fn(const char *refname, void *cb_data);
> > +
> >  /*
> >   * Calls the specified function for each reflog file until it returns =
nonzero,
> >   * and returns the value. Reflog file order is unspecified.
> >   */
> > -int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void =
*cb_data);
> > -int for_each_reflog(each_ref_fn fn, void *cb_data);
> > +int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, vo=
id *cb_data);
> > +int for_each_reflog(each_reflog_fn fn, void *cb_data);
>=20
> Nice simplification.

--W0q+vAlKpSbWxuZR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUZBAACgkQVbJhu7ck
PpRBlRAAgOTtBcUKqgtQ58Bd4Mrp4OPeddj1UONxgKSmRgI2ISPBivlkBdrpS31o
3cSgXdyCIzuDrI4aAcQUMym+KkmC8/ludRuTpxbs2dobNiIJ0RpAjmxkqXrjH3Ly
n7SVNJnadm1p0ZKhF1iP1xn5QuaIcSCyHgeYjAcSgbWeetgoaadhDkgSbyoj2B+m
eYdpzI+ua/jAgXRx4A+LLIsRFhSVgt9f37eTVGitkIO4QQ1iXztX7yWd71cu/GJe
TfME/0CcqrkI5nZ1FgDS1FwDQ/QJ6pPGowNTybBU5cx8cNM5pmgnzuYfU6xOyZLf
FyTlq2YTE+eK4L7d0l9SlhFz3v2QAFrFxp29ic4eHv8ahRkk0dgcmIY9pXXabsOX
wsGFgl57IO743dD5MwU244dBvCwyDwqMFS8qBaw3AhINr/l1ywoW0o5S11Yx8ek7
fu/wcXo2TMSsEF9ZXm7HDL1OncPwAcfGKNhd1xSp0/1VDRjNfN0pWGUUcrfNJRxO
+k+FTQv/Zer0fBcBMgwdgqqdNOJk8CmrBS2H3VLyMZfi/FnDHz1DlNgifpyRaJou
upqk/IEHI3we4s4hJ3R7wXtrAOCPre5FD/qV/8ya9nizpPzNXmirDTjzsw9s7a2C
4zVDXqSaQ1qiWCcCWLT7PV38u3ewjww7IbfMeAg9nRiwVY7aNPU=
=PE5U
-----END PGP SIGNATURE-----

--W0q+vAlKpSbWxuZR--
