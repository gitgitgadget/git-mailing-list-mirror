Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10214F62
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162884; cv=none; b=tSl8hMowmNC78zMQpVs9kfg9zxU7XYrxh1ZRd4GeBl1PV1kSP6AZvIZMKZnYN979QKVE86mchs1tZZVUp46wRBZctJyPiOcqnWepWQbCrNnRc0w7MDKMYb8EjDttskgep/qsfEMhTwA/m9r0rVDnJ8GpXjoRVhBf/ip2cv25M5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162884; c=relaxed/simple;
	bh=ULaU+mTeBHS+tGt+GQqBrLOHIhEhu7eKsSUfgbNCZMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfVFhjdzIhvE25qDRtMk/XcvG9ij4QwqX8DORWUytsphLbRSj8Xw0tnoJlVL9f2vYqtw5X5UQXqA4e1CRvALGNNXnN0/V5QY/vo0XENgiFapjsUvbxybDiCuRr4oSboU57QiWZgewKE656f8GOwUObVchkQx9VmzZdioT4e5ft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VlbD4s1C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KRcRqm4A; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VlbD4s1C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRcRqm4A"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 53BD313804AF;
	Mon, 15 Apr 2024 02:34:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Apr 2024 02:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713162880; x=1713249280; bh=GcG98iXFL9
	YUmuLpL2KLlWj6ixCU487sSVkGJAOphiU=; b=VlbD4s1CGESO2E80DMbDVry2Fe
	m09yoPoK6XJTIGG0kqcrAUKB07A4maMEowf/240qHbfaLAZRz0Ql+Y7oNyFXWCon
	tBXOHgqFk9AvjVrRqm+lVnHK6IEk3YngATzyIO6LHC1ugKxktB9OvGDnMR33ftaj
	/GIg93u9h2hYtNXSHbpAXmfEYCEaC+Knd/soFgm4z07CGdMn5hFwYDSdLG2pJMNB
	r0UpuCzKTyiupgmqB6aS0J68gpSrxXb7NPUb/0AF2UTnmbNJpa3nHg5d1uz31Ag/
	BRjbSKW33hCyO9OkMpkTRSSlmQ/6Fa59z7SF6BwqKL7l4kpwd/kulHh9GI1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713162880; x=1713249280; bh=GcG98iXFL9YUmuLpL2KLlWj6ixCU
	487sSVkGJAOphiU=; b=KRcRqm4ABill8F1rHQjdyCpFT7vgBq1fAoSUIUSivboi
	xHM5Ad/2Yc0xk/rmleSDNNzaVGliHmQ8ZrDRIUK3XWduG3uIbBA+otBFcH0aAVxl
	TyqBsg7jU+feN8N1v+wM8BAamSA6B0WPs2wMlkY3BdvbP+EmaUJnfstNGa3OaeyJ
	QbtzpLU+PpUGxPzACpGmKY7K7CubQARD4q58EBUbj7cylbAShlYqRt3KB0tSU4kX
	KkDnTDIsmsSLSqvD+xCdzuJS9V4vwrggAHqyBVDHvHXX+WnmIhYmjuHXS2U6HjS8
	Am8QEOkw6ZYf88ZcQjSQG+u0hMVrTBFf+3K/Ggc4/g==
X-ME-Sender: <xms:gMocZrba_DWlkqsQgF8RERz5Fkn4DOnZXGhmxGynEGlpYdNDyauaig>
    <xme:gMocZqa_5uQw06Ea_HDG97V0ST6MEUtDn42ROG36psVdCztu_pqecZpLpiKkSyaOI
    WRT5Fea1-L2pXkylQ>
X-ME-Received: <xmr:gMocZt8V117RrgKhd9TMjG0PJ89VlaKTveT04zG-8O8cOCbGKbs_i7KdKhhYd4LHzYC4Aw5Feb_IgRCmp51t0bll22N3eJYVqXB8OVJBFR8u2U4Srg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:gMocZhoWsm9g6zRLZez4LEv_ao4wFjM-vdIFRFm2o24GiosXFVnt0A>
    <xmx:gMocZmqJ6ra4hah8KYkc49hyJhwy4Vx1kjH_scbh5iuG-ZigZtWOmQ>
    <xmx:gMocZnRa8LNuCCpKXEk-3CV9umqroo2qSCXrQpRQLonchYc6rhxJMQ>
    <xmx:gMocZupMKPxHLkJPn9rcXjBrpi5D1Q9LnZqld_atTksXuzWfS8CcPQ>
    <xmx:gMocZt2Zsa7S0UUPl_iGp8VoRiseSPdNwtb20uonD59-JoKUqSO3DA4h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 02:34:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5a86730e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Apr 2024 06:34:16 +0000 (UTC)
Date: Mon, 15 Apr 2024 08:34:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] pack-bitmap: gracefully handle missing BTMP chunks
Message-ID: <ZhzKeR9C4UVpEm29@tanuki>
References: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
 <Zhap8iyMYytCM+on@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LcEat7xlC5eKOYRG"
Content-Disposition: inline
In-Reply-To: <Zhap8iyMYytCM+on@nand.local>


--LcEat7xlC5eKOYRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:02:10AM -0400, Taylor Blau wrote:
> On Tue, Apr 09, 2024 at 07:59:25AM +0200, Patrick Steinhardt wrote:
[snip]
> > diff --git a/midx.c b/midx.c
> > index 41521e019c..6903e9dfd2 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -1661,9 +1661,10 @@ static int write_midx_internal(const char *objec=
t_dir,
> >  		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
> >  			  st_mult(ctx.entries_nr, sizeof(uint32_t)),
> >  			  write_midx_revindex);
> > -		add_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
> > -			  bitmapped_packs_concat_len,
> > -			  write_midx_bitmapped_packs);
> > +		if (git_env_bool("GIT_TEST_MIDX_WRITE_BTMP", 1))
> > +			add_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
> > +				  bitmapped_packs_concat_len,
> > +				  write_midx_bitmapped_packs);
>=20
> I wish that this were possible to exercise without a new
> GIT_TEST_-variable. I think there are a couple of alternatives:
>=20
> You could introduce a new GIT_TEST_MIDX_READ_BTMP variable, and then set
> that to control whether or not we read the BTMP chunk. This is what we
> did in:
>=20
>   - 28cd730680d (pack-bitmap: prepare to read lookup table extension,
>     2022-08-14), as well as in
>=20
>   - 7f514b7a5e7 (midx: read `RIDX` chunk when present, 2022-01-25)
>=20
> . I have a vague preference towards controlling whether or not we read
> the BTMP chunk (as opposed to whether or not we write it) as this
> removes a potential footgun for users who might accidentally disable
> writing a BTMP chunk (in which case you have to rewrite the whole MIDX)
> as opposed to reading it (in which case you just change your environment
> variable).
>=20
> Of course, that is still using a GIT_TEST_-variable, which is less than
> ideal IMHO. The other alternative would be to store a MIDX file as a
> test fixture in the tree (which we do in a couple of places). But with
> the recent xz shenanigans, I'm not sure that's a great idea either ;-).

I'm happy to convert this to use `GIT_TEST_MIDX_READ_BTMP` instead.

> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index 2baeabacee..f286805724 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -2049,7 +2049,25 @@ void reuse_partial_packfile_from_bitmap(struct b=
itmap_index *bitmap_git,
> >
> >  	load_reverse_index(r, bitmap_git);
> >
> > -	if (bitmap_is_midx(bitmap_git)) {
> > +	if (bitmap_is_midx(bitmap_git) &&
> > +	    (!multi_pack_reuse || !bitmap_git->midx->chunk_bitmapped_packs)) {
> > +		uint32_t preferred_pack_pos;
> > +		struct packed_git *pack;
> > +
> > +		if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0) {
> > +			warning(_("unable to compute preferred pack, disabling pack-reuse")=
);
> > +			return;
> > +		}
> > +
> > +		pack =3D bitmap_git->midx->packs[preferred_pack_pos];
> > +
> > +		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
> > +		packs[packs_nr].p =3D pack;
> > +		packs[packs_nr].bitmap_nr =3D pack->num_objects;
> > +		packs[packs_nr].bitmap_pos =3D 0;
> > +
> > +		objects_nr =3D packs[packs_nr++].bitmap_nr;
> > +	} else if (bitmap_is_midx(bitmap_git)) {
> >  		for (i =3D 0; i < bitmap_git->midx->num_packs; i++) {
> >  			struct bitmapped_pack pack;
> >  			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
>=20
> This all makes sense to me. I think we could make the result slightly
> more readable by handling the case where we're doing multi-pack reuse
> separately from the case where we're not.
>=20
> I tried to make that change locally to see if it was a good idea, and
> I'm reasonably happy with the result. I can't think of a great way to
> talk about it without just showing the resulting patch (as the
> inter-diff is fairly difficult to read IMHO). So here is the resulting
> patch (forging your s-o-b):

Yup, the result indeed looks nicer, thanks!

[snip]
> The way I would structure this series is to first apply the portion of
> the above patch *without* these lines:
>=20
> -	if (bitmap_is_midx(bitmap_git)) {
> +	if (!bitmap_is_midx(bitmap_git) ||
> +	    !bitmap_git->midx->chunk_bitmapped_packs)
> +		multi_pack_reuse =3D 0;
> +
>=20
> , so we're still able to reproduce the issue. Then, apply the remaining
> portions (the above diff, the test, and the GIT_TEST_MIDX_WRITE_BTMP
> stuff) to demonstrate that the issue is fixed via a separate commit.
>=20
> I'm happy to write that up, and equally happy to not do it ;-). Sorry
> for the lengthy review, but thank you very much for spotting and fixing
> this issue.

I'd prefer to leave it as a single patch. Junio has expressed at times
that he doesn't see much value in these splits only to demonstrate a
broken test. An interested reader can easily revert the fix and see that
the test would fail.

Patrick

--LcEat7xlC5eKOYRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYcynQACgkQVbJhu7ck
PpRRVg/9EKCLlAP2uyrT8U/aCD9gaXH/kGVWBWJFrdVoeiC/PjKzp/4KedyBI3LD
gBVvv0Nu7uU99l4b1QuH+o5pTDP3IZdjGAqnAuRmV4nRlG8w8LEzL36UXqiLJzyg
ZRSlt43tiqEFUdhj1UG6FOEEJT/hJfEq2Yv7ki+w0lM0hXalJMLOFppW6SQieSwq
OSaEumftJ46jbcolauN2R/w7vWK5Df42+jjfaQKH0VnjdaMrS8B4q1XmmuQL1s2R
f/Ryw2PIoTaZouGLBqSx2Ji6wd2aoHejraifw15Zs4Io3cEVedV/+Jrndhj6wgi4
V3fyMeda66YX2Qln2uRXN23vHiGId5m7+bPKKqfugjKq/aNPMdPkYlzdjhUjMzzj
Ge2Iyh4I50vw0kmboR2pneZkXairuV5Yclf4y73y7uNZzEXkeVNpYijShtsfHMzq
uHt/zISgR8mU9LogUVBRNyAv+Btg8m3hqrL1q8fOrMZbv5vCi7HD85ie75dhFpS7
hhC8Z8ar4tQFVGBmCE2xD6NULLcZrrFLofQAendY3mY8WyBI7ogJHNlY60l+5JBv
mYsfKXINJxSrJVRJ4tAyxHIP9pa3VzN/rYFGrvklYltKvam3SMn4nEXoa/kiA7pU
4hnKivSdCa1gujaJHw9UFBSZOTrdb7fpqrk9lkcIlFMPWMXVNxk=
=sPqS
-----END PGP SIGNATURE-----

--LcEat7xlC5eKOYRG--
