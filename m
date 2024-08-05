Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF91547E0
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859910; cv=none; b=CArChjHmLtYAyk4vm52sLXiquDrbcgwoWSDSqfh6YR21SkfkTK6uFUx6SCIU10LBdprtVIFLn3zAZ4abJqSIjs1wPTTRctynjk1nHvDBvkjFlsQ7BV+D26CsXRZb5aL4BUJdhD/TeiYkgS77FWbgH42jkZ1JB3Np0ob6vDlzk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859910; c=relaxed/simple;
	bh=ntMgudczVxQdo21AHD8K5gGQkYqlM78djT1+JfQPBuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQJ83mB1snUeq8qgbjLMusAfGgzgjzu0qoGPar1ZQ7WXgLMmNHoRAQ8SMa0lUF6ZFrcoSbyCTl838OAp+foxSaHNxiEko6WtE+ELvZPefY4cHrvNfv65AL5/+3Y7c9+ejSYf4cZBx9brMrqnm213zsNGfq900avr1tHb2O91kPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DYzWmBrC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZYypzFT+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DYzWmBrC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZYypzFT+"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 26BA1138FCC7;
	Mon,  5 Aug 2024 08:11:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 08:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722859908; x=1722946308; bh=kHMVTtul7A
	KsS+UO5rXcUS+RLDKs8KcJhkZVM++KYZQ=; b=DYzWmBrCkJfHfZLIE9CJmyl53J
	Ws5f6R8UlgEhE7ciSgtJSJ98cU1pOMJ3MlyD3sasKEZ4P3a0ZAbH7lzreCPpq9wb
	ro3Mu0UcSMlPiB+xD5wt0gu8p6wz8KS0cr+iyJhfgFiPuKP+2kgcSUJ96bJ2CXAm
	Nwd1BD2gpjTiFXiJKT9CL+0+Sri5E6mQfcbhyx2E0lXzA8TRbLLQTG9R1olPGRNO
	U65fciQJ+QWuPUu5gzKksnCCAKRWH/z51dyNaK8KAWqwsdTWBdp7oT6Vy1DfIDgR
	himJvZdhoRTspOkUNqjfWmeqTUPEycQRh55Oba0clA/WL6gnNtMwjbbVnr+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722859908; x=1722946308; bh=kHMVTtul7AKsS+UO5rXcUS+RLDKs
	8KcJhkZVM++KYZQ=; b=ZYypzFT+nc3dYtxDdMgu749oSV9jsgveQ08c4AFZO0xh
	COSSdqUiIIgVLfJq6ZQa8Gw/qzCCwBCWeBKnM79jcxlnp+GCcHaQ/YFl61XfBQ4C
	Txy6qe+kPYLADxKPkFHUVxgnahe11QR2bZAOfN9Y6e1muxX4psvDjlL8laM2JK5F
	L3pJAo19gyOy7Y1mvnJSV77ELgb98sNegbIuWkkuirry1yRNvN0j3L+gGF8lBUz0
	TnJkmAKTkjOSBmoD5+JbX9T+s8jErF0gEmmXAqQfRYSCyKpSynYRhy8MKjb1gzfa
	QdNk4iCFgusn9KNIIHSWnQwTsMQtmVgHPNMUs5prvg==
X-ME-Sender: <xms:hMGwZmaxOLvnaAfydTbeGnClPqp54Fry0euUHMbNLAuH-N7icoI0JQ>
    <xme:hMGwZpZIg-zf9kHW3xbRy6iMmbIe7KC3VEBSTsWfvEfnGw-cAI3sZEUNzY29Pnsrr
    -Phk6A4Ttci4SUffg>
X-ME-Received: <xmr:hMGwZg8ExZzl9T3j0nKPcwS-tLN_PHxZ9ixwHyd_9HGQI45EWFFI-73zuHphh10kQck9AC_K1-nqO6jRFA7yN1NPgeZna4gr2WC25ecrIBWXZ4xwfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:hMGwZoqgP8awjipS9S7RgPGThOgxuuulKSyBycBn1v2NSei2hh21-Q>
    <xmx:hMGwZhobz3qcFb389EN39d1cfAOtrxXPT2zGBwFXsIaAI65s7vPTSw>
    <xmx:hMGwZmSCZmVKGg2hXxGMGxKmfrF7MU8zn4mX6FnaggmfBFkPa8lnKA>
    <xmx:hMGwZhrumKQcCi4dRvfyKGe40wpG3Nyzi2LGNHezBiRE5ci5veFYng>
    <xmx:hMGwZo2xFESSYbQnDKzPULfbHonJOuDazno84r2d4Vgc1w3JZR0Vj4HL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 08:11:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d53732d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 12:11:46 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:11:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] reftable/stack: handle locked tables during
 auto-compaction
Message-ID: <ZrDBgIS5P3ytepQF@tanuki>
References: <cover.1722435214.git.ps@pks.im>
 <dc2217830700acaac50d96361352ff433aa57a4d.1722435214.git.ps@pks.im>
 <xmqqo76a8q4l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y60HZMWlflnm/Rn0"
Content-Disposition: inline
In-Reply-To: <xmqqo76a8q4l.fsf@gitster.g>


--y60HZMWlflnm/Rn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 04:24:42PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > +			} else if (errno =3D=3D EEXIST) {
> >  				err =3D REFTABLE_LOCK_ERROR;
> > -			else
> > +				goto done;
> > +			} else {
> >  				err =3D REFTABLE_IO_ERROR;
> > -			goto done;
> > +				goto done;
> > +			}
> >  		}
> > =20
> >  		/*
> > @@ -1270,7 +1308,7 @@ static int stack_compact_range(struct reftable_st=
ack *st,
> >  	 * delete the files after we closed them on Windows, so this needs to
> >  	 * happen first.
> >  	 */
> > -	err =3D reftable_stack_reload_maybe_reuse(st, first < last);
> > +	err =3D reftable_stack_reload_maybe_reuse(st, first_to_replace < last=
_to_replace);
>=20
> What is this change about?
>=20
> No code changed that computes first_to_replace and last_to_replace?
> Perhaps before this step, using first/last and using
> first_to_replace/last_to_replace did not make any difference,
> because we never dealt with a case where we failed to lock any of
> the tables?
>=20
> I am wondering if this would be helped by a no-op clarification
> before the actual behaviour change, similar to how step 4/8 added
> the nlocks variable.

As we know that we always want to replace the same set of tables, just
with different offsets, it follows that `first - last` is always equal
to `first_to_replace - last_to_replace`.

So this is a no-op change, let me just drop it.

Patrick

--y60HZMWlflnm/Rn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawwX8ACgkQVbJhu7ck
PpTSEw//X3OTU9eWJJhL2fbcwzAmZAoWx2MZU++04PNNlfVwdn03Bd6z56M1dtnl
zzRBbYSD4EMBgCvL/XGG20xW3s/66++Mk0MbI4XKDlz5ibN3lFATDymGgNBugcce
uZ4vUuZHyLhyYor5rzSh7SJdGnJ/nuSzj9w7G3dhzIl9zqiGULLcuJunxDYLDKEo
8JsawUgFYUL4+8wR0eP1WCuB9UoKXhiZCmYsv1Am3L3P5MsppoKwkOPdGggn/o1k
vwXSleyS44hZYUJ7E9LjWjDwVW3zDZWztvfYvCRcyN+TcuJkcAgogZ0c3OtgH1+2
XBHe4q2VN+2wpbn+ycOQsq9h3P+2pfkgd9pDplU2H6xPtLHRM7hyh4pvW3LXIyy7
RqPiDvx1I9fvueXZrD+I/Botmn5zVguaqG79RMusTKM5waD8qzR2GwoeirSWVHsQ
7shdAoGLh/kS+LQj5mJXr5cIbvSn3fC1651Gwl5odI6bszPF1ymZHPOxhVU/iMMo
MighSUG6QO3TvChUoBzrj4gJZ4D0cdaU8l6DXE46YH+abqZfzLaKAhAiWmGH9sfF
ViSCPXw+V67xyYj8sWgBMCJLjb5/sIolgk0jHZiRFT7b8DFL1a8Ey4h8pPTCmFwq
ulyNAIGJQfzymarBZKNlD0zhQmD2ULYUVWtWiLNtnIBUsnE0OoQ=
=VuGM
-----END PGP SIGNATURE-----

--y60HZMWlflnm/Rn0--
