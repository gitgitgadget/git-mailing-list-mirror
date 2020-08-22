Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B854DC433DF
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 08:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695CF208DB
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 08:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cxo3R9Ti";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCRt7ICs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgHVI7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 04:59:54 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57239 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgHVI7x (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Aug 2020 04:59:53 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 625265C00EA;
        Sat, 22 Aug 2020 04:59:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 22 Aug 2020 04:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/HbV6P47BxWdHPqO3P2DQVORS5P
        USBKFrPPH0HoPx0w=; b=Cxo3R9TiOjKO21B+rA9fW3t3UQfnNggxRWtFfjrn26h
        VCN6+gt82NVy+ru22rt9WNo0XtVSab/dF1Ch1b9ro0Gyv9Z9ge3g/rausLzbqIpX
        YTjGCTX/c0VlutDNAy0Pkg4iF8R/dBdTU3tuGyzfdLAR/QKfQV5vkGptayolZrmz
        jxADllzLdKeiNsw/klQ5WeH71nCeFgcMfOOgCeVs/afhyDqhNgZncIchLZfwFpLM
        ZE4LRtf6QcurKNjTd2/CJ1CGJUliDFWDbtp44KReZ5qg1m3fDg3HRsOicZsQB3A2
        wEv3u79bFbE2FI2d4LO9Onq+MnYTHpr7akCcJZrDt2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/HbV6P
        47BxWdHPqO3P2DQVORS5PUSBKFrPPH0HoPx0w=; b=eCRt7ICsMAS11NEa24ipsQ
        rVBhMcClmIt0V3PuFoVSwDLgxwxD4Tg2Jp76dOEg7CVXafb2C1J5xNNqi1i4EXoK
        iIi0tqQIiObJh3kLuM9/ovLs0TJYLFx1CLcuGwWjSyXz3o+g9MrAst+URMNxOA4p
        +w5LFvlJ2O2Qe3KV8ob0XJFPjmwivuaKkzVYP99pkBR3PMNXchIddo9A8PtE/bAp
        roVN+oTc/BbCCMv8y+gO0DjNjEBSxXvLgAOEEJh/cGHHXHM6kcpR5zDLtEAvCWzM
        MB+5kH9yhOWKgTns5YQJZ/7afEPCO2JNxXcwxrBxyGjs84tkPRMzBWSGJH7IbVjQ
        ==
X-ME-Sender: <xms:iN5AXz5hu85rJKeY66R-HqEHnLSZygEIIeaACifre9sTlluoBaWxIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddugedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudekfedrhedtrddugedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:iN5AX443RBA4MFMAJOXbYc0stAfGTIFJKu7EHq70pSOTVReRyX3j9A>
    <xmx:iN5AX6eTPYlw4P2K_OuFNDzozEYtT0kcQUd_NTDVM1G4RhP02dJXng>
    <xmx:iN5AX0JUt_aGKyO1uYF7RtCKjYcZoGNdhU-wX2FUnpoJkOY_cTnvDQ>
    <xmx:iN5AX5zeFCgxvm4nWrAnZrBtKY8XjBmJrCW2oiZ7YJhfAsVpQ1qPOw>
Received: from vm-mail.pks.im (x4db7328c.dyn.telefonica.de [77.183.50.140])
        by mail.messagingengine.com (Postfix) with ESMTPA id 50CA230600A3;
        Sat, 22 Aug 2020 04:59:51 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 87109f7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 22 Aug 2020 08:59:50 +0000 (UTC)
Date:   Sat, 22 Aug 2020 10:59:51 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] refs: remove lookup cache for reference-transaction hook
Message-ID: <20200822085951.GB1069@ncase.pks.im>
References: <0db8ad8cdb69afb9d6453bf60a808e8b82382a4e.1597998473.git.ps@pks.im>
 <20200821143727.GA3241139@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <20200821143727.GA3241139@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 10:37:27AM -0400, Jeff King wrote:
> On Fri, Aug 21, 2020 at 10:29:18AM +0200, Patrick Steinhardt wrote:
>=20
> > One case notably absent from those benchmarks is a single executable
> > searching for the hook hundreds of times, which is exactly the case for
> > which the negative cache was added. p1400.2 will spawn a new update-ref
> > for each transaction and p1400.3 only has a single reference-transaction
> > for all reference updates. So this commit adds a third benchmark, which
> > performs an non-atomic push of a thousand references. This will create a
> > new reference transaction per reference. But even for this case, the
> > negative cache doesn't consistently improve performance:
>=20
> Ah, right, I forgot that update-ref would use one single transaction. So
> what we were testing in our earlier discussion was not even useful. :)
>=20
> >  test_expect_success "setup" '
> > +	git init --bare target-repo.git &&
> >  	test_commit PRE &&
> >  	test_commit POST &&
> >  	printf "create refs/heads/%d PRE\n" $(test_seq 1000) >create &&
> >  	printf "update refs/heads/%d POST PRE\n" $(test_seq 1000) >update &&
> > -	printf "delete refs/heads/%d POST\n" $(test_seq 1000) >delete
> > +	printf "delete refs/heads/%d POST\n" $(test_seq 1000) >delete &&
> > +	printf "create refs/heads/branch-%d PRE\n" $(test_seq 1000) | git upd=
ate-ref --stdin
> >  '
>=20
> OK, we need these new branches to have something to push into and delete
> from the remote. They might impact the timings of the other tests,
> though (since we now have 1000 entries in .git/refs/heads/, which might
> affect filesystem performance). But it should do so uniformly, so I
> don't think it invalidates their results.
>=20
> However, I wondered...
>=20
> > +test_perf "nonatomic push" '
> > +	git push ./target-repo.git branch-{1..1000} &&
> > +	git push --delete ./target-repo.git branch-{1..1000}
> > +'
>=20
> ...if it might make the test more consistent (not to mention isolated
> from the cost of other parts of the push) if we used update-ref here, as
> well. You added the code necessary to control individual transactions,
> so I thought that:
>=20
>   printf 'start\ncreate refs/heads/%d PRE\ncommit\n' \
>     $(test_seq 1000) >create-transaction
>=20
> might work. But it doesn't, because after the first transaction is
> closed, we refuse to accept any other commands. That makes sense for
> "prepare", etc, but there's no reason we couldn't start a new one.
>=20
> Is that worth supporting? It would allow a caller to use a single
> update-ref to make a series of non-atomic updates, which is something
> that can't currently be done. And we're so close.

Yeah, I had the exact same thought and I do think it's useful to be able
to create multiple reference transactions per git-update-ref(1) session.
I might whip something up as soon as I find the time to do so, it really
shouldn't be a lot of work.

Patrick

> Even if it is, though, that's definitely outside the scope of this
> patch, and I think we should take it as-is with "push".
>=20
> -Peff

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl9A3oYACgkQVbJhu7ck
PpRrAw/8DNUEV1UAbWb9XhvbE10Ldr8/S0N+ohVqwA+JOTJ7fchjU6tOhVHhBVGz
XdwWLm/9RxiUYByTm82ywTOWLld2q6TEA/WFbvQAMJiWZvYXHjnXksplmua2/r3A
CjXMzHbieG+mJQPv1pszUO1ALDSIzyz/u2V5a3GifhYhvw3OGWEsqyy941Teoclz
EctEfgPBU/RRkGLQMyb/vw48GtQPIchcPWhvLeFlfQ69oGCLMr5AUlns/tZXKTQq
PX+7hVNVqWicKZwX/3d4hAP9EAPpocuS8UaP89v+i33MTyGHA8E5M40PSTpARH3k
I/e/shgythPaLxQ6MBWT64AQ9F4sbxMXQxt8g8QMMApjwZ3Px/PKzbRt3KerjvXT
cUoxQk6l6itD+vosRB0jvIlE2NslV2zkvGRMLi6PLh+egn50pJcuSO88hEQthShG
haht8uduveI/9SPhXCsD90s7qi6lPRm6dhQCeNXxt/d2QCHqsDyou+/oq66i2quj
ASkCXdYk2kHFomHQBNj41gKy4YMR0T243WtvaNl0VWwG/TWqwQiLSGuKn4BfHoZA
fuCgkc9kwDcqg5AcaNbM86TNWiO3fQ51nA2MGDdtc3O9lYZ2VtC7SBXErKWipOYe
vIsRammFmYczxKZJi47+63ixFaKnkPiZAlB9UvpqG9UKwaurcQY=
=SWxH
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
