Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E5171087
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357839; cv=none; b=Sw2RlXM5MpnyPZ3B/1gFjxUBkKHiSbUwjGAbTYwzx+5Sc4Rxt5Uqk8hUcOuhONJv6KGKOe1j1SEoFQYdtTEiwwdWH41p0Qw7ULh6YGqKAXigtYwWPpx1vUZckwDFxkBqS7SF13tBj9KyqsS1unzKrJbxCZ2GCUyFNjX4uYxWjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357839; c=relaxed/simple;
	bh=RgK7uvnZG2ZR7F1tjmbgAo65+haP9eJl7X+o0whpuHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m89tvE4DYS/wx0kXXByZTXmHP9b3u1nsN2ia9YbO6l3gVit5cKyLwolWjn4/miCZozikcmXphCXWl6kJk64tL9dx/IS2FzK99+NI/OS0tSarjmcHLBRqqm1Vz3mGDdwN/S4OfK9sMhjHYi3jFCKJX4JlUPyx6HFNZp/0hs2RJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xg+wNlwZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRQY5tV2; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xg+wNlwZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRQY5tV2"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 806015C0058;
	Mon, 25 Mar 2024 05:10:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 05:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711357836; x=1711444236; bh=HNA1yShZbN
	kwHRRbV/h6+ZVDD5Rs1Gy04tb+o7Oaujk=; b=Xg+wNlwZ8oGijueEpqz7z87jS6
	PD5N/gDeeS1EVpXdJhMEa5hAfya8h0zrcRJx2bI7mk7X+nldomeh/58+LYB2yaAm
	9Drvj/r2KT9i6Scr5t64PopbzL6UWLDll4/3zTwq9BJ95h3XX/0E8zuPq+++pzgt
	TVd4RqzaokPY56qXecB/hL1MUuT795OxTeLzFSwV/wgtY6Bzq2QkpTrBDQlj77t7
	puVP+ih42yasoIlp4Oc/GYgmeIDCSfxobYyn9XkGDfTPmHasuIP79uFyGZB8osNd
	k5DcWDL+KY3RHDgKuqeHV3puRLqyqZEVPY7b0sjtTdvqksGuLRErv3UgD7PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711357836; x=1711444236; bh=HNA1yShZbNkwHRRbV/h6+ZVDD5Rs
	1Gy04tb+o7Oaujk=; b=NRQY5tV2tirzSoNCV16r6f0rMOQgk1vXPxRDCBUWXKJR
	/3VUUR+MHIJdNMicuiPLutzBbGnzWwA4v01o3F7HoR9mxPJ97jr5hVnpW98CSpqq
	Ml8YO92BccsbCrrSFsHZ0I38AbWSJZve+ejD6Rhm7SuWBpWwiVeS/f1qNcGJwM7M
	0u2fMUXnnF3hn5OdNc2N9ePjofHNy7H/giNAoD9auoOTtAXHDmJi1otmPO1xEwAJ
	oBG0Yosigk9fAy0m/QhUm/eIDvfIHC8pqYvvFiyJt+4ROtr9ZIoFAogxv6piy5pj
	bcuheC0cxCcKURTQHnM+HoE81s7ktUT8AHBTc4Mcbw==
X-ME-Sender: <xms:jD8BZobH9pht0RlZfjC0E_nH61jarkH1btDn_iyqIYljDvzvHnBzkQ>
    <xme:jD8BZjZ000OgRgXAyr2_nbb_U7pRydgp3dHp94SVANcRBjNDhgAetxJHiZPGSgT87
    _A7CwF_i6yRHDpnVA>
X-ME-Received: <xmr:jD8BZi9XmcgSOjFkA-TCj4ZUrlmwHkNHTl31-0LAN0PLmR8qi8PdUSu2eoXNH_zC3V-R_yjqZD5EvknXPCTToKPSI1hxRbsTqvmr4ifjE8cR8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtlecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:jD8BZirF1ZNDPnzwGlBt6tjifonM2kkeBi3-WbdmMlShWPIJJPPIow>
    <xmx:jD8BZjpzJGxkCSljUhJpFn2SqS3mOQILneQ-5hSweEkbX7os-QOiUg>
    <xmx:jD8BZgTIadFK2_MhNbnYcDMEmoocxyUn3TtUA5XEqPeS6h4A41qSpQ>
    <xmx:jD8BZjpTC4ISoud7bJJXF_qPFlIbwnzotSWeEYDmXFClSyJO9OIwiw>
    <xmx:jD8BZiWqGfznZLYsLwOyHRLFEEhl2kKcd6DejhW0nVmFtIK-xoabvA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 05:10:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a7d87de5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 09:10:23 +0000 (UTC)
Date: Mon, 25 Mar 2024 10:10:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 03/15] reftable/stack: use error codes when locking fails
 during compaction
Message-ID: <ZgE_h_su_Y_HfGXR@tanuki>
References: <cover.1710706118.git.ps@pks.im>
 <ae2130ffda2135bdea11ea6764c08e98a2cc4905.1710706118.git.ps@pks.im>
 <CAOLa=ZS6uF3fuor3V2F_GM__JNRpUAyLcrVDbCHsJ6JStL96cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JgfIT+WrFOQaMzP6"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS6uF3fuor3V2F_GM__JNRpUAyLcrVDbCHsJ6JStL96cA@mail.gmail.com>


--JgfIT+WrFOQaMzP6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 03:14:10PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index eaa8bb9c99..ba15c48ddd 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -1003,7 +1003,7 @@ static int stack_compact_range(struct reftable_st=
ack *st,
> >  					LOCK_NO_DEREF);
> >  	if (err < 0) {
> >  		if (errno =3D=3D EEXIST)
> > -			err =3D 1;
> > +			err =3D REFTABLE_LOCK_ERROR;
> >  		else
> >  			err =3D REFTABLE_IO_ERROR;
> >  		goto done;
> >
>=20
> The comment at the top of the function now needs to be re-written with
> this change.

Good catch, will fix.

Patrick

--JgfIT+WrFOQaMzP6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBP4YACgkQVbJhu7ck
PpQVaA/9E9ScmlUtvbL9kAJhAW1rCfhx2IXlCW4os70uI2YqThg6gqG/Gk5hvGfd
hqZhVht57ZxKXOnQnK/LIx4SxaE/xTJj6ORCO6gCbFy58PtzoymTXhSl4JWXQ3Z+
VGYJCqGtEO6cRJsTqdYRMKuXrjR0DyzmJSO6oCEWvT94EZj6wp+dp0eEwY1Y7Een
OarKbxmSLqf6l4O4UihLdbJUyp1+q/yS1hd9I/TEzs4/OdE/fikLY+ThJeY0X9v+
YfkQh0sV3IXYkMY0zrBxDjIlP3fbg08LnVu8Rw8/f4Z/f3OmkxPl+AwlpS8OF7uD
64ASQ9UVsBWLClN7of1lo+k+TE9QYC9rwNVm+yseHS4lf8aCMcDIcVEctdllHAje
wMmVuVPF+zl0uX9Ak9OnqHbvvEJ9JdEBbfHCfmei0BO8cE06kOZK0Ij35QTV+qvd
m2r1LtjNlzfoEVgHjPeP25hNq6LLXVHyT4gkx+6/UBNlJWkzZDQwyK3fzDBoCgsz
LT/6g46qkCV57cbrHyv8dt/S28+bxtsJEABcu1D7rjyVWOA/qsx5q8tsOWGqyKSX
zbp4BUUxfy+HGOSzb57WPq6O4TvMyYaMBCXA96x4wAR0gng+GExsx1lkFqGv9uGN
SPXrm9GRcIUGhTiNgnseYTfHQlsfNn8RVjRPGVCPLUlphRK+qWM=
=cd57
-----END PGP SIGNATURE-----

--JgfIT+WrFOQaMzP6--
