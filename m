Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36DB33F6
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925660; cv=none; b=rd4lHf/JFcx0D+CqXYNBcmbEBFCRnKfUjt/L4aSIozeRW/kvgmH0ekZ0VfPy86htzS7JovNhcpLz+E3HQwOGF6O83fJz9xXNRgMDk/36KFoyXvHZmWhkctNPQ47naLEA2XN/T/Lz9CpQb+DMUJRDad7VDCeNhMEn2kjD9i4GpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925660; c=relaxed/simple;
	bh=aDm34fb6h6icaFnOySL93byQma3hSqlHGTRyhFyqQbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRiiJDturOklgYbkG94njULbUVi1+gw8Put8F2U8ApXG7PvaHctIeNSI1qCiEEP+LeuQfInkYjiF4JzOYdTq3S7FKtp5p6vNzNelu5qierb0NUqNxNo26gIFXtg7WwZ5t9Kjelf4uZVqLjjuyTSljKxxF/hZoQwcXpNhTUJmp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CT05aJ2L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=co1Qi9+F; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CT05aJ2L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="co1Qi9+F"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DFCBB1151AC6;
	Tue,  6 Aug 2024 02:27:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Aug 2024 02:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722925657; x=1723012057; bh=7btEyl1Kd9
	Hl9dbNilti85oNcpSZfTtQ3BKDaWfFa5Y=; b=CT05aJ2Lui3UJySjTERruXT6nr
	SsqDvpYVzII6y3K0e7ITBcxycIQVW1MfVm9wFN3vXpi8z6HoVUVYn+N4f5ug+VND
	Af5l9wJONDPlTc20JnqABaHtDW+V36JTIVNtwlk+NBoeKsIDdbpVdSUt7idCKRk9
	QaIackKPvWXKQ6DF/cd8wDlNdNIxZ/Ti3QJ+h9pf3ajaqSMN4G896u7IGCu/Tvmm
	wpocgeMBqOIx68dklS62VWB0pN2D9OOuq0xosmMRpioIGSU+aCrTjy2dE5gvjZBz
	kpp+YzwJcZbnowEiqYg76LLCCpgcA2iQ4O9nObVq4Z8axUDNeutNO4Puz7ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722925657; x=1723012057; bh=7btEyl1Kd9Hl9dbNilti85oNcpSZ
	fTtQ3BKDaWfFa5Y=; b=co1Qi9+FDinMqW4lwTbm7LlfVODnujtlr28XnBpP7CFv
	9MoPfoKzefeoN8TQmsMU3eVPQshFw710wLcWW6Y+LQYjKZqX9OD5daTyUzI7W5NR
	R5TTUnrnd83PIGwFsQYzShnfN5QpqWszIcrLqQuaYTYZtQEcblR8pVmN4LTGXw5H
	2gpOA/4JmX5eRa4d6mVC8JFl/vuvZVPQqb+CoxW/evE9Vq9fRunAyItuhtKzlUwL
	2/s5spaA9q1pyU7d5ROH6DCa4y7kV/BLUFfnlFVIK236Ev5K1Liaq0MmFgB6u4oR
	OIVcxDs/UOIvmX2PnYB6z4vTmcg775aNFdXLOXaTIg==
X-ME-Sender: <xms:WcKxZouUQc6-XH-2qWY-X9akPGe_t3tQsn9GIW56rnb05R8oQ79a2g>
    <xme:WcKxZlc9e39s9ZTI-uzxnpq4EwpMjJAY7oPQ5BD_oqB1xbf5UXFEw8n8vW4snUMmP
    LqBLJej1d6fQma1Zg>
X-ME-Received: <xmr:WcKxZjygKfae69Cbi0N7yAMIss535SmXRxIMjamCYPGgGfRfpLC7vZMchuxOMrYwwJxomT1y05f-unkX-HKaX7hBUgnJeQs9Ir5Fp-iREyzP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:WcKxZrON4jnL5OkPM09aBV-nV69O1Q6_Q-rCLtxBLJbgJbh7rB-t5w>
    <xmx:WcKxZo_rDEjDwnvuHUnHipIsHsSVuHAOotZga-Gn1hbwxr1oifyH3A>
    <xmx:WcKxZjVi3fPNJgnnki5SK5MZpAfIcfmcrAHto8L7MEbX9iYuoEHGqQ>
    <xmx:WcKxZhcA-KyDpi33PY3vxjAzAMABC_iWB_Xa6DvR5LArzTbhbkhfQQ>
    <xmx:WcKxZnb52fH2Zq3wyJdnHSVfVyrH8SK6_F-_9T2S-pENRY5k3qvzQVBi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 02:27:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id adf9c98d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 06:27:34 +0000 (UTC)
Date: Tue, 6 Aug 2024 08:27:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/5] doc: git-diff: apply new documentation guidelines
Message-ID: <ZrHCVmQvVH9MzpJ0@tanuki>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <515ddbf1dceacc0c186e3d31c13e76a5afc6c45f.1722801936.git.gitgitgadget@gmail.com>
 <ZrCXK8AmGSFwyqI4@tanuki>
 <5803739.DvuYhMxLoT@cayenne>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3gPtAGxuf01TEwma"
Content-Disposition: inline
In-Reply-To: <5803739.DvuYhMxLoT@cayenne>


--3gPtAGxuf01TEwma
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024 at 08:51:21PM +0200, Jean-No=C3=ABl AVILA wrote:
> On Monday, 5 August 2024 11:11:07 CEST Patrick Steinhardt wrote:
> > On Sun, Aug 04, 2024 at 08:05:32PM +0000, Jean-No=C3=ABl Avila via GitG=
itGadget=20
> wrote:
> > > @@ -225,11 +225,12 @@ CONFIGURATION
> > > =20
> > >  include::includes/cmd-config-section-all.txt[]
> > > =20
> > > +:git-diff: 1
> > >  include::config/diff.txt[]
> > > =20
> > >  SEE ALSO
> > >  --------
> > > -diff(1),
> > > +`diff`(1),
> >=20
> > This one looks curious to me. Why is this item formatted differently
> > than the next three? I would have expected it to be formatted as
> > something like linkgit:git-diff[1] instead of `diff`(1)`.
> >=20
>=20
> Here we are referring to the 'diff' command, not git-diff. That is why we=
 don't=20
> use the linkgit macro (which is used to generate cross links for html out=
put).
>=20
> Still, the general format of a reference to a man-page is to put the comm=
and=20
> name in bold, which our filters get by backquoting.=20

Oh, that makes sense of course. I totally forgot that there's a world
outside of Git. Thanks for the clarification!

Patrick

--3gPtAGxuf01TEwma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaxwlUACgkQVbJhu7ck
PpQIWhAAriW31mABc6HkUwH1ME7qxE300O7YN/6E/BpVlPXn6B5cdzaPJfm9Ckgy
aRp76Nb1mhe8X5guedJHlu8fmpXFEOPR0fUEBgjvF3ycb15zsNgmOfSIJOud8F3f
zAHlC5HfyLlhsJleHOSvEDtQ5BZXgXC2FVXVRaEGbyIUDNigf8CEpQ9+h1IEtCPj
RFLJa3sOtlvaEj46IdUovfSZ/DAN2SIDUFEtiJs4L9/ES/hM91/+mgiGnuKMztCc
XAqp7Y8hAYjpdpnLU8YmWCFJTSMrLjH+jcyw/Iu9psAQnv8M6Ooc6ludhP6urUZd
TFYoQu5p/6OfVYyTFZw0QVKAxb1OPfTRxb//dp9AAoiSxQgi7VZ/Mlcm3t9iuLpf
6x4GRwaq3lbWeXIDwUBX+UGGD/m7uo9uRVgNcwBh1sdZsu28tfs4LW4i7zPX2OZv
MVL5UPzD44DEpQe4FgXtN/zSK9Ij1PpoSkHFjKyax2Qcn3T7lfs7KruFC1mqefs3
Zdw4EHYN3+RvQ0L8AnA/VxksVxBeIf4woaB5hyaSVARGOq6oAIPgcuXvQ03WPNUe
1JJLSMzdB47349IAM8IWQc79+vPJ7nffmJyXw+vS1BuCtaUpUVzXkRbOvx/sPF3M
sjFuqKrDSs5k9Wi2LeYTJc/9nYBzaORfA4fnlL+uE9A7IWaLjcM=
=9AiX
-----END PGP SIGNATURE-----

--3gPtAGxuf01TEwma--
