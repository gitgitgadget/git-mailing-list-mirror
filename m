Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED9A2E65B
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637285; cv=none; b=LoKDilg6EoQxF5GlOekezcbUV6JiFleC+9phA6T3yP3BA5M4JGQ1sa9M4czs2YHt7Ax+LbuT1lyl7FDBvgYBZ+ANTY9EAr4inzKCd6j+GNrpJ9gsMYVGQ9MzzDef7RBZkTRrOThLY582FaS0Vz3sU9/sUJHCopQ/OvnxVB7FEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637285; c=relaxed/simple;
	bh=MHiyf47d9D8CLI7k2lK+oxpGCMxZLFCLQDzgSzHJD4E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwFx+CZlWATFQpzaUdrgtjx6AV7y+5/GiiLdp1awu9KYewAegR2c0rWJ66qfeBiLy2/ZNy6tIeeUEryvXVqwAc7YQ3EWfy3Q5sk551s8mDlahEyupiT5ylZfH44DKCUldPQqMdiRI/nf40IbXE++Cpb9oSzjm5LvfsmhFC51BgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZioT7vHT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NbhSoexY; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZioT7vHT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NbhSoexY"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D61EC114010E;
	Thu,  2 May 2024 04:08:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 02 May 2024 04:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637282; x=1714723682; bh=Iq4MB7+4bt
	XUrmo5VVGmtxB6USVEhOkybZjrhHqXEkw=; b=ZioT7vHTgh/WwzfYJ7sj7eNwfc
	GU/CVWMlI6WvmCuBtVSF8Qto65XwOm8bsWL/IY1WqShQOs1TRtU4N//6/lhDWMAO
	Bcgx3kLBolK8D3Gjc08usL9rKOjjl2FtJYKZP906WKaIjKKtnm4QvcCoQ3ngz6MY
	YCiCO5sTvd0umxlf5hoBdaFSv2d4Jt9jaEaWo4DczDg5wM1BYlIAKai6UzTIx3Wp
	QFlCDcQ2uHiegZE7Tjri3fQTUJ0Yq8YRy4VmpOoswRHygzhDl8G9mHP3yXy11xGN
	kfkNzTM9dztU7YQFXMnvb6hUtFIcLljsPv5Ul58gF2bhC8g/5HZqf5nNDqHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637282; x=1714723682; bh=Iq4MB7+4btXUrmo5VVGmtxB6USVE
	hOkybZjrhHqXEkw=; b=NbhSoexY/iGYZhihEg+5FW8QSHre00hwEnp45QUpX8Kf
	O5wVOoNGkzJ+6LCee0scXDPDB21HsjrDTjMuGpKKrSLp618MFnWr8aN5LtOBrw7P
	A3YjwPJfw3gPc2vn+wsxfWNWx6/fBU8ZnKTfXUp+0FlUHxGTpEvlDYOaSrYsQ3ik
	N6oSBNNhFYywa+vjJ4ijTo6O0ZRc2MWunbD0AUesMNNv4DxXX1zhhWnjV3GgK4R5
	8s1xaku/LjwFp8Mzn+CyhsfYhuF+uRyPjObnOJgZ5wm/u4N28hPzQ44ESraybQJL
	k7QTMPSVAqTTZg+s2cowUZuc4OYmHUHlhP8aSnAo8Q==
X-ME-Sender: <xms:4kkzZl0FqGvpRZZFbUukhgkWstor2oVEc8C4a04OP9lzDPcrWwtvNA>
    <xme:4kkzZsHyDasgBUcsQ8nBUSsq5BUDxqBX7aY36NfBkwy64iWTVW-pIuoPgVUc-hGgF
    U5CiGoM38AR3Yi_nQ>
X-ME-Received: <xmr:4kkzZl4aVnwKxDBq83_pTInazXk46fLPOVpAR094x6BIZ32_d5cdBzLooqCBTk4jC3ks3UTX6gjRyXhMarK5czO_D2rsNKmWWR5ywwmHTQQ2vS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephe
    eghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:4kkzZi0a5WNeXJr8_ZxH4V0vY-kCEeiJYPLPNd-07st5qTOo7OCytA>
    <xmx:4kkzZoFX0MGQmIKWWnyDnuGweyDLE8aBosPgDTh3OhKcZ74SkUX6rQ>
    <xmx:4kkzZj_EJb5wMGww_zoD9r-IfmZ8YZDRcfzcb6IR8te63LTrytVdRA>
    <xmx:4kkzZlm6FuP6tlxjo0dg-ACZS57xRmIKhb7dOzI8YiJ-tM254W3NYQ>
    <xmx:4kkzZtMDjs9rvVt1fRqedQ_ITMpi4P0I9GAa2eY4auPADqDMID9hBsAh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:08:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f7941cc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:07:35 +0000 (UTC)
Date: Thu, 2 May 2024 10:07:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/10] refs: root refs can be symbolic refs
Message-ID: <ZjNJ3j2wSgui_cG8@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
 <e90b2f8aa98493e9cd3f2c04cb58318780f9f6e5.1714479928.git.ps@pks.im>
 <zmnute2cow2rbrv3cj5cq4roieyzssaxcnorxhorzyp3wfgllt@ubhsw6dpi5js>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NiVn+HzznunV34PV"
Content-Disposition: inline
In-Reply-To: <zmnute2cow2rbrv3cj5cq4roieyzssaxcnorxhorzyp3wfgllt@ubhsw6dpi5js>


--NiVn+HzznunV34PV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:09:57PM -0500, Justin Tobler wrote:
> On 24/04/30 02:26PM, Patrick Steinhardt wrote:
[snip]
> > diff --git a/refs.c b/refs.c
> > index 5b89e83ad7..ca9844bc3e 100644
> > --- a/refs.c
> > +++ b/refs.c
> ... =20
> >  int is_headref(struct ref_store *refs, const char *refname)
> >  {
> > -	if (!strcmp(refname, "HEAD"))
> > -		return refs_ref_exists(refs, refname);
> > +	struct strbuf referent =3D STRBUF_INIT;
> > +	struct object_id oid =3D { 0 };
> > +	int failure_errno, ret =3D 0;
> > +	unsigned int flags;
> > =20
> > -	return 0;
> > +	/*
> > +	 * Note that we cannot use `refs_ref_exists()` here because that also
> > +	 * checks whether its target ref exists in case refname is a symbolic
> > +	 * ref.
> > +	 */
> > +	if (!strcmp(refname, "HEAD")) {
> > +		ret =3D !refs_read_raw_ref(refs, refname, &oid, &referent,
> > +					 &flags, &failure_errno);
> > +	}
> > +
> > +	strbuf_release(&referent);
> > +	return ret;
> >  }
>=20
> I'm not quite sure I understand why we are changing the behavior of
> `is_headref()` here. Do we no longer want to validate the ref exists if
> it is symbolic?

The implementation does not conform to the definition of a "HEAD" ref.
Even before this patch series, a "HEAD" ref could either be a symbolic
or a regular ref. So to answer the question of "Is this a HEAD ref?" you
only need to check whether the ref exists, not whether its target
exists.

> In a prior commit, `is_headref()` is commented to mention that we check
> whether the reference exists. Maybe that could use some additional
> clarification?

Which particular commit do you refer to? It's not part of this series,
is it?

Patrick

--NiVn+HzznunV34PV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzSd0ACgkQVbJhu7ck
PpSmrw//RfLI04FZJ1bBwNAhe0fV8tXI22naiNrYgonqX/2ZmT2Q7AVWJC4VGEEi
3h4VAzjrJLmt1DLTraz77udlgr/3v37//+Q0TwdQbmj0de2yIgY6EoLLmwcj3sMt
zkYoKSPNtyd0rHcXRCJKShG79qEisKnB+oR9V3ASxj3cInA/h7sJepzV4u7YTQvL
C5kzKrfwHjJi6HCWDOSNyJSTCCkG0kYGQ/+TvjBvMfUnt6tjdkVjm7XVrO9JZU8x
IbM4j2EY2YDiJwhFQJ88FBhJJxTNMe/YD5yiI/Tvp4maKnjPAfrejUZe7dycnI25
A2wCfnIurnLMc05vAPu9yWWOTBC6+yTwOsdBf3LkjzRiL3otm/uIzHD2ia1i4V77
YjTE6a7gVpCHyijyp01esJbCsuuMOFy9VQn5rW4HMw6IstTlqxhU90L5Pn7ZDtb3
AammMPB5bjjEcYfXkJytu4+12nfV+6lqlFZyOxbZaYSJgXTfPIFM1br4ZhmYgfmk
fSF/isVEEojiZX1cSGBlyQQLk+46imeJCZEBdoDZ9p/UApSMEquDKRMAdUD3KqUW
VVPBg5RfaofkPsjbSg6NFYEqAeQ/acYpimYApm7qq+9Nk18Ld8zC7VWOgqQ0QsJu
RFGsbLev4rDIyG5yN88+zlcewO6YN4O5ZRLYr4SV/DSBiCS8K+4=
=wztu
-----END PGP SIGNATURE-----

--NiVn+HzznunV34PV--
