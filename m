Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591D8C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 12:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjEIMlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 08:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjEIMli (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 08:41:38 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69921468A
        for <git@vger.kernel.org>; Tue,  9 May 2023 05:41:36 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id ABA6A5C00B9;
        Tue,  9 May 2023 08:41:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 09 May 2023 08:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683636095; x=1683722495; bh=tU
        1TGhDx4LBJROWXeGpkMPivpNhh+orwA5S3McgMdDs=; b=GjExC0UUOwxk26FIkB
        M4l6PrF/szXrfwBP0tVl/BO3BwPaNFY4200yXeW7tbJ8fKDbMlJj7iHTG/kZYxxf
        TS/BtbPROaOIZvgzRk2qvJT2Z4K3NtbCgKgSfjCWEtUqengvUBclWIF1Qt9j4MQj
        PSVb/4g+Domy64EpHwdQfm9h4bwIMUDBf5nVhIOeWuG5nnQOaxfR4YYb0rLLl5cB
        qLlQmKhU22jgzeXi27T8oIUCprHBDI3obSdXjwzbRTLPgHWQd91nmp51KIx3DYba
        8OpSVbRL8iutgOGCoslw6wmQhS+gF/Ebl4slKIELislTbobny6ZcY0utU6YIPIK1
        NPdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683636095; x=1683722495; bh=tU1TGhDx4LBJR
        OWXeGpkMPivpNhh+orwA5S3McgMdDs=; b=kD1MUVcDrbr1XiGF9wgdsZBiMbu5D
        pXwSyxo14JempLZRZOCkI6YZRygXxiV/L6SXxQnt4GhglaOVQWsudGNF4Xsb4qqq
        r7IhvAV2bOMN3xVw/tYBEVGXvaohT4/AYtp4+QvDoxJ/L/PcPnSRNRnQpaPK0/XI
        0gNrvuesh6y9xYfdRDMWviUFwLt8qVHIdK9zWjy6ekqIo1DsNhs0XY4WRiHsgxmX
        iYvxbrBCKlo4biGqAnOydHQKT16fC/Ias6sh6D4f0Dh3+SNa7/B8mdIfeH0dIcB4
        XDKfSivdiA4f8wjSlgTXFkXWSkAo4PE1c5gWwQGmfwDupFaY9AfRKcUjA==
X-ME-Sender: <xms:fz9aZNY4cDPDp2Euvem9EjpTxuZUc9Sr-8-uowM25ZUBWxbcZ8UFmw>
    <xme:fz9aZEaTFvtwYii3V-xCjXMVBKiLsT3iMsAJxX3x_zEzhkmHUKJNVbbjoShWv_CoP
    ZZ_k7Kq95WPdMFVqA>
X-ME-Received: <xmr:fz9aZP_w1aDhZRMjGlfuc4JdYmBA5FPUrcU51MLVpPC6DlWeJsL2bl8k-28qxFaq4LZ5u-3A7KDM_1NoirfZcGSaFmW6LGJRLdPNJEEupWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:fz9aZLoilEOAfFrkfIxiUMU5NJg32rrP-Q53Vuxa0x57WzSpRdm-vQ>
    <xmx:fz9aZIqpAWnruXliT__M66mM482b2HdoIBjAoK2uRBNGPpanjTLCbw>
    <xmx:fz9aZBTIJazrWVxc2aoAMFFiHZzec6PZZE45_Cfm_5rKQBR-30RqBg>
    <xmx:fz9aZBnAjPT5qehDv7pQQwwsHBVqDwlG5w6dCeOsCeVWoyLeMVrCjA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 08:41:33 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ac836c5a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 12:41:23 +0000 (UTC)
Date:   Tue, 9 May 2023 14:41:28 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v3 1/8] fetch: fix `--no-recurse-submodules` with
 multi-remote fetches
Message-ID: <ZFo_eMAwq8LEXBhh@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683113177.git.ps@pks.im>
 <4b2b0cfe15ca6b3c9058bc9cb6944ba05d60a228.1683113177.git.ps@pks.im>
 <kl6llehy1lo7.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7wJf4NezhSMbbaQN"
Content-Disposition: inline
In-Reply-To: <kl6llehy1lo7.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7wJf4NezhSMbbaQN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 03:51:52PM -0700, Glen Choo wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > +test_expect_success "fetch --all with --no-recurse-submodules only fet=
ches superproject" '
> > +	test_when_finished "git -C downstream remote remove second" &&
> > +
> > +	# We need to add a second remote, otherwise --all falls back to the
> > +	# normal fetch-one case.
> > +	git -C downstream remote add second .. &&
> > +	git -C downstream fetch --all &&
> > +
> > +	add_submodule_commits &&
> > +	add_superproject_commits &&
> > +	old_commit=3D$(git rev-parse --short HEAD~) &&
> > +	new_commit=3D$(git rev-parse --short HEAD) &&
> > +
> > +	git -C downstream fetch --all --no-recurse-submodules >actual.out 2>a=
ctual.err &&
> > +
> > +	cat >expect.out <<-EOF &&
> > +	Fetching origin
> > +	Fetching second
> > +	EOF
> > +
> > +	cat >expect.err <<-EOF &&
> > +	From $(test-tool path-utils real_path .)/.
> > +	   $old_commit..$new_commit  super      -> origin/super
> > +	From ..
> > +	   $old_commit..$new_commit  super      -> second/super
> > +	EOF
> > +
> > +	test_cmp expect.out actual.out &&
> > +	test_cmp expect.err actual.err
> > +'
>=20
> The test looks okay, though is there a reason you didn't copy the style
> of the previous test? It is nearly exactly what you want, I think, like
> (untested)
>=20
>   test_expect_success "fetch --all with --no-recurse-submodules only fetc=
hes superproject" '
>     test_when_finished "rm -fr src_clone" &&
>     git clone --recurse-submodules src src_clone &&
>     (
>       cd src_clone &&
>       git remote add secondary ../src &&
>       git config submodule.recurse true &&
>       git config fetch.parallel 0 &&
>       git fetch --all 2>../fetch-log
>     ) &&
>     grep "Fetching submodule" fetch-log >fetch-subs &&
>     test_must_be_empty fetch-subs
>   '
>=20
> which has the handy benefit of not needing the test-tools invocation.

That is indeed much simpler, thanks.

Patrick

--7wJf4NezhSMbbaQN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaP3cACgkQVbJhu7ck
PpRH3g/9GXTdR0e0xxq6rgdPWZ1aJdnkbx077uldCJ8R9Or5UoStCoB/CsQ5x2qp
cyzhNjAyV8sw1UT95z5lvLUqQ9hAStblFRsyBTGV+CobBrugTCChMDGYXcNcB9CP
ukbvUSjrWigxG4lsI/UsjwVThddlKZZgAKjH25bCUwkTI5O0Ew5NHBOeqFeS20pM
szqdB8YgvFSqyAfTZQYi1IRyA5un0lrHOSGXxNquI8+UpJdQKkUYje4LPYQcsFew
kC/TjCdIkytInazVjs7/JX+CLDRn0O/ZRxwo882W3EaWkZONiAG4ZKcbpUAJLG3L
GbYEMytAVNtg7iIgv/FRiLhNdS/fDXFmSqi+OUR/OBlBDt5LjYhyEkEm3e6NJ4ys
mEAVs8urVFeKhc0s7QCvtoNIM6FW6CuxX1uRh6gIu68pjZFRah/GzpXl6ORLBwrW
jtgpQYHGd+B3XHviasHp1aKtzUJy38GZmZRY9zM6kmVPUYY9+7Na1uJn25YLTyCC
tGwcdGNQg+vbuD/dhqvxwGp6xcsLEJ28Rwdp45XKGTjnxhC488MqNaExJpj/t60u
AzzcszBlqD9OCQAzteUBrAtSuZ8q4U6PcEmQB/2GN+mEwjscH5ZZnBkiNjFM4GOt
36ps1xrNwsIZPvF/D9H0GhEDGNQPJi51MLQtoX7XcnH759lh7ZU=
=fWEI
-----END PGP SIGNATURE-----

--7wJf4NezhSMbbaQN--
