Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B65D725
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418101; cv=none; b=IYGBWEomhMjttSe/R6yfvQUSAuoc2H1MiirynqLkzL2uX8wDemrZDgRU6wKsp32Fo+8zfh9G/FcK2crM8jEoZ9E6RMqXF9El7YN25+aA26y4jHjLFx8TfgQqAMU9faaYF04G5a4KqGS/Qf7Z90n2UF6lAUeXCJ31qwHPNFTd9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418101; c=relaxed/simple;
	bh=RgpUScIlUnl9A31/X1IuXzLd89zeU1xJeHqGg0w08w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9DtLOX1OY8YLeo38CHFv5BIgdNsGYktkwxQzlByRbSPULTPKWSPIbDqi9suMR6clrrRg7bQni2xL8NgIwKfAZ/Z61ZErD1iCN9njmmlgY2uSWnLxkW/HYcPF/R3rxoSgH4BwNuXYsKnC9+dyon+4RXCbjtKeGne3eDtLlJzuEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EfdkdJQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bCzGHodN; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EfdkdJQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bCzGHodN"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 53A361C0007F;
	Tue, 20 Feb 2024 03:34:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 20 Feb 2024 03:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708418097; x=1708504497; bh=eqnnPiDswV
	LdlKAzdxQaAQY0Swsq5Qa1TyRgbEnmoHQ=; b=EfdkdJQ1CIgID3Bqeo2pfgMRHE
	OUB5hyZHWKTk5Fh6RTqMhtqolT8TAJrn/PlF3aaYm9VLLqx+vyHlfSjZ+peRNv5H
	Z64qHVfUDwJZNqd4UwE1yLPn2+sXkUECkAOFQsRfHEd7SY2JSOtsQWfN4otyYBtg
	KYrr2evkrG3s9cKXvHluLOSNTmsOoqxrD4iibPH8m9KsksXnaCrjU2H4Ej3nqM3l
	B58mSqBk5i5BEpa3eBz5gvs4H/WqZHvnPVJZotLGm51LeeRF65i9oAUuShp24f0P
	+mrXjLsXoK2CEQSAGvJl7vMyCjGrcwLFMwMe2y9noDGZZcfA1kFsbOBs8Xqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708418097; x=1708504497; bh=eqnnPiDswVLdlKAzdxQaAQY0Swsq
	5Qa1TyRgbEnmoHQ=; b=bCzGHodNoBGNj6dSPOpvStZSmLglKEzufzr0tpSJglmZ
	0XpF1DfPZriG85TATi0KUbz6ZKq6zuFMhMCJWRGz0VEK1R3NGqb6xTfhOdSSBmql
	tV80WMpnsY0NrkBipb0WnsRBB2Lmt8gTiRGw3p7u7pCkE8CM1+bqHG6B+uZVLORg
	nKBUUl64UiQsBdhwSi69N8XpFYYj19xZoGAdud4Zq3t1tgHUxneKBgdna6JZDGqP
	ip+//wNmjIrtXKrbWi5CT/Iolx/1JPpenWYdoG0StpJezOTCpV/AIPp+QgRUZZO4
	CmXplCqCBAGuVaHSOyjuCKf1tWnSWgUrmXEaEbtMMw==
X-ME-Sender: <xms:MWTUZc6X0OKY0ufy-PpJr9K1cbTr8QjFdJN8iF6mg1g-SPiRwnX4Mw>
    <xme:MWTUZd7SEdlhQDRgdNcnWT55-HZ-CbbPReJkZWyVANkJXoDZQBbqvPDla7dmi6CGK
    YuWL2jV2uimnXQlhQ>
X-ME-Received: <xmr:MWTUZbeUElDOTFyqEnsgMOvwge8PUjAxsTjzK4ylfHUDRvOSrEjt7c3-Oxqw0kD8boXZihWBrGkjX29gGZrodsdwwxVqBiKrs_AhP_W_OjX7JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MWTUZRIoHdmzQNVLdNyF2iiRZCVOetNciQB2hrdfi7zBiVJJdFy8yQ>
    <xmx:MWTUZQIARmz0zikc4yyAOc5JxkMwHyy9JWerisJoSxEGx2Jw_cmESQ>
    <xmx:MWTUZSxpjjyL25DpinYJnEoW4Ju2V-8Ir4x23RP-_R3S2KSFYrk_4A>
    <xmx:MWTUZXVLHGqnkQfemnkCN2dQu6oKsqthwwvqHHIvwr_asTyeGxqsMwV_43E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 03:34:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7bf12652 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 08:30:54 +0000 (UTC)
Date: Tue, 20 Feb 2024 09:34:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] refs/files: sort reflogs returned by the reflog
 iterator
Message-ID: <ZdRkLylHKj44tstQ@tanuki>
References: <cover.1708353264.git.ps@pks.im>
 <e4e4fac05c7f4bcac8ef96bdebb8a68eef40ead4.1708353264.git.ps@pks.im>
 <xmqq34to0znj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4DytrztpiUI1eNNa"
Content-Disposition: inline
In-Reply-To: <xmqq34to0znj.fsf@gitster.g>


--4DytrztpiUI1eNNa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 04:04:16PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > We use a directory iterator to return reflogs via the reflog iterator.
> > This iterator returns entries in the same order as readdir(3P) would and
> > will thus yield reflogs with no discernible order.
> >
> > Set the new `DIR_ITERATOR_SORTED` flag that was introduced in the
> > preceding commit so that the order is deterministic. While the effect of
> > this can only been observed in a test tool, a subsequent commit will
> > start to expose this functionality to users via a new `git reflog list`
> > subcommand.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  refs/files-backend.c           | 4 ++--
> >  t/t0600-reffiles-backend.sh    | 4 ++--
> >  t/t1405-main-ref-store.sh      | 2 +-
> >  t/t1406-submodule-ref-store.sh | 2 +-
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 75dcc21ecb..2ffc63185f 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -2193,7 +2193,7 @@ static struct ref_iterator *reflog_iterator_begin=
(struct ref_store *ref_store,
> > =20
> >  	strbuf_addf(&sb, "%s/logs", gitdir);
> > =20
> > -	diter =3D dir_iterator_begin(sb.buf, 0);
> > +	diter =3D dir_iterator_begin(sb.buf, DIR_ITERATOR_SORTED);
> >  	if (!diter) {
> >  		strbuf_release(&sb);
> >  		return empty_ref_iterator_begin();
> > @@ -2202,7 +2202,7 @@ static struct ref_iterator *reflog_iterator_begin=
(struct ref_store *ref_store,
> >  	CALLOC_ARRAY(iter, 1);
> >  	ref_iterator =3D &iter->base;
> > =20
> > -	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0=
);
> > +	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 1=
);
>=20
> This caught my attention.  Once we apply this patch, the only way
> base_ref_iterator_init() can receive 0 for its last parameter
> (i.e. 'ordered') is via the merge_ref_iterator_begin() call in
> files_reflog_iterator_begin() that passes 0 as 'ordered'.  If we
> force files_reflog_iterator_begin() to ask for an ordered
> merge_ref_iterator, then we will have no unordered ref iterators.
> Am I reading the code right?

Ah, true indeed. The "files" reflog iterator was the only remaining
iterator that wasn't ordered. I'll include an additional patch on top
that drops the `ordered` bit altogether.

Patrick

--4DytrztpiUI1eNNa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUZC4ACgkQVbJhu7ck
PpT7Gg/+O6ncYUMox5tnxag2P71G96aGIbcaMrUz0285V8atoyjVjI5Z7YyP2Wyj
Ef6ybHugf9USUWiIxAKwBCViVpQpoLAR6onk7VHu7dkF3ftKcwoxJScnA8oqjU4B
pmKG3Xo+Wr6nFo/j6pFYF+pVls+mWgblKmxAxTdU8UjoIi2skXKnI+J/LYU6EHu+
2D4RTOiGFDBilbQb/T0q7hATzoCED5/EbnAV2Eg1GcmG1DztzPtsdVD1d+0x5oiA
yfPcl/5TzKPOx2FH20AZpvaCebK4ochtXAnonDwk5ovASbXQyV+gCOr5vk540Quw
b3OZDDojrKT31H0TuFSy6P8mGapd0FpZ+xLAz5akiMDr4mnocpnjLvVZJgYn8fpS
cDtEzMb4l4xaK83sUAEUxR4JZm9Pa/yprMw/bM8Vixcv1XCM73lSpTTFu+M0PWFV
H1n+z4ABvjQjI6iFihJVXIhYFUoNZbips1+04Zh6WGfXvVEI6OzaQrl9q9WwzaU7
uLcWIrfnmGcwCgls5HK2Tc5W0ATA2qBAbpbqZU6bVjc3to3fgMUb2eZiCTHgSbd2
i+WU6sNVk9P18kSOAQppgZT2VQVlktgTpWuxowAdBXorKkH1A4fseoeYDs3h8KI3
qUPiwc46WKIRGEQbVdekt5l63TXX24ooJP3Ta1TbbZP9Fz2b6oE=
=58XK
-----END PGP SIGNATURE-----

--4DytrztpiUI1eNNa--
