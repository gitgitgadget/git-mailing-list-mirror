Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0511C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbjEJMfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbjEJMfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:35:16 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3997A244
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:35:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9D0933200926;
        Wed, 10 May 2023 08:35:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 May 2023 08:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722106; x=1683808506; bh=ZG
        bkQAF52GzFHmdIinjQS35TmUXJwfCQ2wyAZsrrwDs=; b=TcBMbPwkukHbXInfbB
        z/fvrYAr8sPn20ufdjt1NrPLm7t/qXbBXqTCOqpK8VfWQUHm1bagY1gozECgnAd6
        DFNtr2Fyu3jeFmjxkEPoNEbPWsdB+sxWjJx0XZ8+ijC6IBmtRccEDtx69c9yelGq
        dvZRLwx5F8xFOTWASnrMh//a0IR/9rqfkfCNnBv4DUY+pI1TaS4LM+w75Kg3IW2a
        aBH7FfZTcG03+tGS4XZk8mG0Mw4A3avsgrD6y5ujHQt2cVEr5cRkoDX7TX3rLPaj
        4QYqbQoN7F0Nx+EnhHVvmmlnTD9bJvhGDkCb7sTJnfxLX+uZ95x5p3AXHVnAVb/Z
        tfRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722106; x=1683808506; bh=ZGbkQAF52GzFH
        mdIinjQS35TmUXJwfCQ2wyAZsrrwDs=; b=OCFWVuMCd8LwhiyBe87Qw9VrR9Eo4
        nUKjuFfdf7WLuG5zvBHop3OqFekBxYid9vQc6f/2sl8jxdNgvPEr+pwdp/wrt2zj
        KeUV25v7qTjTuR5FDtHVbzHjUIE47cuvBvK7uoqi3xN95zXuDNAKnUvnar1P3ghC
        vt2U3exmJjgYXKjHT8T6mKI/lzaEhlMFmeutdGbLVAtvE897vjalQV8zvbSuFEbw
        TFpVNOBe5LC1SrIFvQTlZ3mlncK/tYGeEKmKrdwhuiaTRB8+UVLBlHsPaSXGC8ZL
        sq/njoUek6h5uaZ9RH3HMXMw/UTCqUlcFLeDD9kpflVWM6E+kTJEsZ6Fg==
X-ME-Sender: <xms:eo9bZArYbcQneS2C1CjBPLBRoSF2KL_pv4BWQlHGkBK3af8APOFJkA>
    <xme:eo9bZGoUDHA6_QvtpsDWoJ_n-ofkNRyTJ-5HRQtTlftw4TyHaSFq7m7tSnzUeyl03
    MofN7woW6DeRHBkGA>
X-ME-Received: <xmr:eo9bZFNFlEQQiKsdPynJXoUH8zE2nSnB0z9Q3SBhm-mlInrZd71tIQkDZqlLLs77T4qKiDGVhEDQKr4zWqn9mYiOwAagQJ1cI3qpQzvv2k9q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:eo9bZH6C0ZBEgXZxcnGjwBA0RbseemVpw930m4jj3K7Wj2O9skCDvQ>
    <xmx:eo9bZP6H3bDgIOa62_h8QmPA7FaPcU1J1VLT-YlqhAu3D4nbBReOhg>
    <xmx:eo9bZHi3j3nW5l4r5jAhVu8JAFB8Lu15aFvxxV7oC6gjwU9Zbq8jjA>
    <xmx:eo9bZC0k38LZyT1b97Y3pWvrUhS8a-GDapdBdnA5fFvXtQI09kYECQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:35:05 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id fd576748 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:34:55 +0000 (UTC)
Date:   Wed, 10 May 2023 14:35:03 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 5/8] fetch: introduce `display_format` enum
Message-ID: <ZFuPd8sPOFcbFohW@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
 <80ac00b0c4b0fde61a3edf48d996e3a60327a54d.1683636885.git.ps@pks.im>
 <xmqq5y91xnou.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EvDy8SZaQX47v8OQ"
Content-Disposition: inline
In-Reply-To: <xmqq5y91xnou.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EvDy8SZaQX47v8OQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 01:19:29PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > -	display_state->refcol_width =3D 10;
> > -	for (rm =3D ref_map; rm; rm =3D rm->next) {
> > -		int width;
> > +	switch (display_state->format) {
> > +	case DISPLAY_FORMAT_FULL:
> > +	case DISPLAY_FORMAT_COMPACT: {
> > +		struct ref *rm;
> > =20
> > -		if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
> > -		    !rm->peer_ref ||
> > -		    !strcmp(rm->name, "HEAD"))
> > -			continue;
> > +		display_state->refcol_width =3D 10;
> > +		for (rm =3D ref_map; rm; rm =3D rm->next) {
> > +			int width;
> > =20
> > -		width =3D refcol_width(rm, display_state->compact_format);
> > +			if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
> > +			    !rm->peer_ref ||
> > +			    !strcmp(rm->name, "HEAD"))
> > +				continue;
> > =20
> > -		/*
> > -		 * Not precise calculation for compact mode because '*' can
> > -		 * appear on the left hand side of '->' and shrink the column
> > -		 * back.
> > -		 */
> > -		if (display_state->refcol_width < width)
> > -			display_state->refcol_width =3D width;
> > +			width =3D refcol_width(rm, display_state->format =3D=3D DISPLAY_FOR=
MAT_COMPACT);
> > +
> > +			/*
> > +			 * Not precise calculation for compact mode because '*' can
> > +			 * appear on the left hand side of '->' and shrink the column
> > +			 * back.
> > +			 */
> > +			if (display_state->refcol_width < width)
> > +				display_state->refcol_width =3D width;
> > +		}
> > +
> > +		break;
> > +	}
> > +	default:
> > +		BUG("unexpected display format %d", display_state->format);
> >  	}
>=20
> Due to reindentation, the patch is noisier than what it does (which
> should be "nothing, other than allowing another value in the .format
> member").
>=20
> It makes me wonder if it would make it easier to read to move the
> bulk of this code to a helper function.  If we are to give a name to
> what is being done in the above hunk, what would it be?  It computes
> display->refcol_width in which all records would fit, but presumably
> if we are to add more things to be shown per ref and align them in a
> simlar way, we would compute widths for these other things there as
> well.  Perhaps compute_display_alignment() or somesuch?

The code already has such a function and calls it `refcol_width()`, but
it only computes the width for a single reference. The most natural
thing to do here would thus be to merge the loop over the references
into that function. This would also allow us to skip some weirdness,
like the fact that we skip some references inside `refcol_width()` while
we skip other references in the `ref_map` loop.

This refactoring is also quite noisy, but it makes the code simpler
overall and will make the patch introducing the enum less so.

Patrick

--EvDy8SZaQX47v8OQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj3YACgkQVbJhu7ck
PpRsAw//UXXegWBmyJPmfEo6zuNj2k6cgzrWP6lOQThWIHb3GL46z60l2Pf+CoV3
olUUdbS+WdaiVKkqMsiqNR11S6H0V32NCSxaRg7GaKhORK+nfeAFV4W/6OkspJDR
O6Bbo30xjfoK2rmC+zGlOFPQTZLopva1GBDiZPrIcEUZjqv2dkF81ZdLLHkPpgl5
7TO12LsX1DbHunY1wCcoxry3JDgDo3cRO3ZmbR1d7JnG8EB+zB4tsSXRYfCJBK11
jd7Jktg2GN0mKv/jnvCzOizMrY8YN8scia50u2uYsWRU1wzAau6yP0J9hGhSGlOk
OByOeIPhy96vIJyXMZvCD3ah+8ift/UHyAyz+bkCMybb6VNaoDNnbEOK8mxpeGMe
Mz9GJCAfYyo1GAC+MBUW3p0MyZTn13kRXrdfUZ1fJc3UUR75Bt2eeiE4ohjTy1ex
TNvj9YLRbH7ZBtY2sYb2XCKg2iADo0jHDWsKfQxVZXXZlb2Pd/VY/zyHWzHmz8H5
lcbHaDg82zAqtzP8z/moxeq2vfyDjRwnsFOCYW26LXc/QCZk6fmMFV7ahSoDrXNM
vN8wGGSTWywGSuh0gjIOrP4cc3FFa7RnddG83R1ACXE+Vd17hlUkGy7FDmH+53QB
J3KMhj5mS/Wmpq9pJZWeSBsRyvF7PT2oO3up/PQiTSNs9c8xLsc=
=GCLK
-----END PGP SIGNATURE-----

--EvDy8SZaQX47v8OQ--
