Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C9BC77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbjEJMfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbjEJMfE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:35:04 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E179EF2
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:35:02 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5C00E3200918;
        Wed, 10 May 2023 08:35:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 10 May 2023 08:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722100; x=1683808500; bh=z6
        PA5APLk1b/bsa46QsdapxxnZyFsp089HLVgNM6JLM=; b=MiAFgKV30TlcC8GOXi
        fWlfC54KL1FBe/hIcl0pFfP8F3A4Pd3eyR+uXcqc/S5wWFt6Oem2eZSXGxsnZ20I
        j5enV1c0hCiliiKrAZ5HOOwmmIXKnTs84IpPMJyqMBQfGi0qwFTAMDWqwXuosYAz
        RZkQ1uIi9Z3UNfWk8EMRi+HdfjvjvdsmKcl/Ys5zHZ88D6j9AuPgezTXn21bpuAi
        tS4IforOS+hm2YS3i1QL48fyGj5b6SWg4LkSeXZxGFlFCRv9jrXigE3/yTxm0w1J
        p1f3lfsYCdr4/c9gsyJOpXzYKycJAYe94qMVKqPmdWu799DiJ7wJ6cmkfbNiJuD6
        DOxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722100; x=1683808500; bh=z6PA5APLk1b/b
        sa46QsdapxxnZyFsp089HLVgNM6JLM=; b=NZnM8UF2bPwV3vA5Vrlck4po1kF/h
        CLWt/56VDW7en+qRIZnxenE/LhR38UBCirTyUIRfGhOnkVdaB4XVtrHnb58HZueg
        TsmPV5/2k75bGwCiz/PgVCf64n9OptTMns25o2mMcl+jXjrqmWP4k3AQdquSRRC6
        adgPdeybPae/IofgEwImJtW6p8RzuxdyetrfeB+PLw+G9q9/Cm+xMiwD7O4w8UJt
        8MDpAhXKr5hCJDUShhEdS0vWtFRp02cK9SwnFAlvcBh+vdUDOGLOOkRcBGAskkOW
        PDHTRZd2dlD1n7qO1zOIhqvzJ3sj8iY0BKMbU0WAaFKpetFeqvtZpQXSw==
X-ME-Sender: <xms:dI9bZC91jkx-xuja1c_5ESAk4wELV8NQINfIxx1Inxqo9HXN2moITg>
    <xme:dI9bZCs7OqcbqOcs4eRxXbaak3oX507ffyGNE-VFlzYGCZWGipmT5s2Kql9M2K8bp
    0sv8AdnZxWm3ETi0g>
X-ME-Received: <xmr:dI9bZIAr-FEAheFNWzIP8gjNr28042IKJPuu-X87YSLBKQWClx8gdG_bJLve_K5ttNPp2Yny2hyFALVYODLPs7lcIexW2YAz3Pe9Pvw-diQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepffeijedtgfekhfehuedutdeutddtgefgieevfeeukedutdeffefgjeeuffffuddt
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mh
X-ME-Proxy: <xmx:dI9bZKfxojxe_VxVYa5PHloioe0RA5Ncc9-AQ4apop7xRgeXwQYg_g>
    <xmx:dI9bZHOytApoiJ73_XOU7cPIbA_M-lEvXKo0PcRMgXFV92xjfdVAxw>
    <xmx:dI9bZEnpLaRBQfCOLLhduknLOmJiLnMPNhyrpywKhejZKl94E3pFWw>
    <xmx:dI9bZMrC2q8gNjHDFD8xlAkO9TkqX8-Np0CGMn5U3NjpD-PpuvYjtA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:59 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 6d378db6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:34:49 +0000 (UTC)
Date:   Wed, 10 May 2023 14:34:57 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 4/8] fetch: fix missing from-reference when fetching
 HEAD:foo
Message-ID: <ZFuPcfeqCbJo4XcS@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
 <e599ea6d335d16b45fa75b223ea8db93e46c627d.1683636885.git.ps@pks.im>
 <xmqqednpxq27.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OZc4+RhpuHf98IX6"
Content-Disposition: inline
In-Reply-To: <xmqqednpxq27.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OZc4+RhpuHf98IX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 12:28:16PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > But it is not intended when displaying the updated references and would
> > cause us to miss the left-hand side of the displayed reference update:
> >
> > ```
> > $ git fetch origin HEAD:foo
> > From https://github.com/git/git
> >  * [new ref]                          -> foo
> > ```
> > The HEAD string is clearly missing from the left-hand side of the arrow,
> > which is further stressed by the point that the following commands show
> > the left-hand side as expected:
> >
> > ```
> > $ git fetch origin HEAD
> > From https://github.com/git/git
> >  * branch                  HEAD       -> FETCH_HEAD
>=20
> I do not mind being explicit and showing HEAD in this case for the
> sake of consistency.
>=20
> But speaking for the past developers, it was deliberate to omit what
> is common from the output to make it more terse, IIRC, and I think
> it is unfair to call it a "BUG".
>=20
> Back when we wrote git-fetch-script, the output was a lot more
> verbose, and through efforts like 165f3902 (git-fetch: more terse
> fetch output, 2007-11-03) and numerous others over time, we got to
> the current output.

That's fair. It's still not quite clear whether this behaviour is in
fact intentional though. Quoting 165f3902 (git-fetch: more terse
fetch output, 2007-11-03), the weird corner case is not documented:

    This makes the fetch output much more terse and prettier on a 80 column
    display, based on a consensus reached on the mailing list.  Here's an
    example output:

    Receiving objects: 100% (5439/5439), 1.60 MiB | 636 KiB/s, done.
    Resolving deltas: 100% (4604/4604), done.
    From git://git.kernel.org/pub/scm/git/git
     ! [rejected]        html -> origin/html  (non fast forward)
       136e631..f45e867  maint -> origin/maint  (fast forward)
       9850e2e..44dd7e0  man -> origin/man  (fast forward)
       3e4bb08..e3d6d56  master -> origin/master  (fast forward)
       fa3665c..536f64a  next -> origin/next  (fast forward)
     + 4f6d9d6...768326f pu -> origin/pu  (forced update)
     * [new branch]      todo -> origin/todo

I've reformulated the commit message to talk about an inconsistency
instead of a bug.

Patrick

--OZc4+RhpuHf98IX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj3AACgkQVbJhu7ck
PpT2Kw/6Ap2dndo3CJ2RYYJ6WKctjluYbGfw9Edsr2f+k7uEiSv1mi2Uo+pxZv+8
hdJpv5MBw455jO7Pd7ULI/jfRp3ej2NDWV5TQmUDLS2rDhaVnl1TBV1ibz1wHoak
ynzr6N8ei2I4UZoakW0ATLeuElhv7r/Uf0qacHleKQy1LS/rZ1GMx5wqYJFgSrmX
jCF4o2gvOgb4IQ+NkfSBrHPGOyOr7m3plF/8rR9YpIpRV74Z/YziC1bb+XY6463C
8m4cpXCMFZAwFScJ5MfGiV/DTKsLH4sD3Pz1jruBnBwff43yGuaOYsZ5RLvNCKBW
U+zzLJ0uHh22D2Z2tY7LH12Ia6g9kMRhgR7mWP1ai2cbRWclMftw3VdemhKgMuRW
PHdxpg0RYLr04pgKrXMXQKnNo2mLeOibKRBCytnI3mnCFDg4/AMKQETHLrkvYzg0
VH7m7X9Mcm5wQh3GFbCx8/4HZNLvdCu3xYGHeGN6WFKjzhwlvf/RjB2YqLr2NPo4
8oC9B5ny8/HauJoTw8+o7m63LapNFvf1Cy6HkGYUX2xCY4UBqDRV6vsdUDXkWcbG
6vo86g3dR+3YOO/HjYSb1bQTy/MZi2aUXae5YgP4AGocf/I3ugtqlRMpfuPRxOIT
h39C/gqVHjEjqieJkshPTUNWPkQGRG6+iDdj/KSOadsZr/1Ij6Q=
=Osyk
-----END PGP SIGNATURE-----

--OZc4+RhpuHf98IX6--
