Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A93C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC77B6101E
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbhGSKPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 06:15:48 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56693 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236339AbhGSKPq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Jul 2021 06:15:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DB725C0057;
        Mon, 19 Jul 2021 06:56:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 19 Jul 2021 06:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=u43fYK/tmUkK/BlwP3xUl+lCNG8
        qQLUyKdtPGWGqszM=; b=IClwsPuMDGl9dUgpAbD5wpMYhBnRZpNjk4Mw8IpjHzh
        MtNMIszQvwJS5ZtqJ9euq9qRrLiLI5ZfYTLamG24jbWOuOMHwR0UNqmyk6AGjzoK
        hKrh3yXdOXssQQ/DCFV8JvhbA1BngJkrRPVUMFvbUHaxvNmz7ZjVmFonQ4VpL+m/
        585ijTxMWOrvhJX0fK0ux3nG744X9HuxxNobW2V512dJXFZLpkMolUci1m8aU+SD
        1sxhzCIYrx2jOozMgmkAhPCjXl5ZH0Fgg4pHSxOXL9FSJG3zvx7GiF7LmCSMeXPt
        7+MvEhv146xOVMdke+GSfJfvyz0cmCNPkFG0/UiN/ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=u43fYK
        /tmUkK/BlwP3xUl+lCNG8qQLUyKdtPGWGqszM=; b=Ad82qbE8YYILhBHKlcKDUU
        blmf99xJBWW6hDgTVlNSFn2TC+9lpPFEgIf0pDPS//94eSz+ZfFCBzppLz1dvjFs
        4ajqLvgLxivl6AD6qvnPyKUk4sco1qEYHl2Voc7s0Zw9fSHoeLgS0mLvLBWviGOi
        GlYflRVZtTNwDMVE40U6a//Sph8LXjl38ukjj7I1TfxibsWT6yxH4DHZ+jsB2XQW
        ddkMUrzUq3Q27C03yBTWI0s8NLDQN6dcjQmvXsloiAajCOKyTCnImVmgxfaSAax2
        gaGV0SExpYiyrKEj8jAX2T/sJ/pAkxuKgZRFFZ7KhgCwStIOErWTLvz7+0z/lTmQ
        ==
X-ME-Sender: <xms:WVr1YLSEKWTxPC3nELfy9vLZZgkrHlENcg7KGNUjPdQ3dgK-b77ojw>
    <xme:WVr1YMxUzagWvMePUeq3k9LCmhzuX3JJCXi_xOyaIWyGSI9urrcPA5puNOiveAl_I
    COUwXw3f7ZW1oZ-1A>
X-ME-Received: <xmr:WVr1YA27DGUBNb64nPXZFh2GwUpgGxNkBBezyvZ1ed8ebQzxOIbKjWtZcCluU7eCZwZ88o3JxYmF1lO4E2XtplcTqJl2aTZHfU-bfyWmt6P7NYhzkZY2aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedtgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdeffeelvedvheeuhfegjefgkedvudehheeggeetleejkefhieeiieeuvdegvdetnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghdpmhgrkhdrihhtnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:WVr1YLC-WHEOEpqn8bfoRnLtstwJmBvhwRoKSF22XBlS-37V7BC5wg>
    <xmx:WVr1YEgVn6TIpwCl2cokILPd9PtRd0idgWGq9T2MczkHiGhnjJ7A-A>
    <xmx:WVr1YPpbIZTA-lhfHLNNw4N0Mmoc6i3Gs8zXqTcnsdQVYrNgdVP9kQ>
    <xmx:Wlr1YHuD7I7j5XFuRiR32C1u3kDyG4zaEPSLXmWfCvgtcDNJd4gi1A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jul 2021 06:56:25 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7ce2329f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Jul 2021 10:56:23 +0000 (UTC)
Date:   Mon, 19 Jul 2021 12:56:22 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Message-ID: <YPVaVvcamOB0RZV+@ncase>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <YPUrSB8+zEur+ZBt@ncase>
 <60f52f7a52671_1e0a42083b@natae.notmuch>
 <YPU5NyoDrQquWOYo@coredump.intra.peff.net>
 <60f5573312036_13ce8720841@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G1Z8KhBSFweXsOkw"
Content-Disposition: inline
In-Reply-To: <60f5573312036_13ce8720841@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--G1Z8KhBSFweXsOkw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 19, 2021 at 05:42:59AM -0500, Felipe Contreras wrote:
> Jeff King wrote:
> > On Mon, Jul 19, 2021 at 02:53:30AM -0500, Felipe Contreras wrote:
> >=20
> > > Patrick Steinhardt wrote:
> > > > On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
> > > > [snip]
> > > > > * ps/perf-with-separate-output-directory (2021-07-02) 1 commit
> > > > >  - perf: fix when running with TEST_OUTPUT_DIRECTORY
> > > > >=20
> > > > >  Test update.
> > > > >=20
> > > > >  What's the status of this one?
> > > >=20
> > > > From my point of view this is ready, but it's still missing reviews=
 so
> > > > far. The lack of interest seems to indicate that nobody has hit the
> > > > issue so far, and I wonder why that is. Am I the only one who sets
> > > > TEST_OUTPUT_DIRECTORY to a tmpfs directory in his config.mak to spe=
ed up
> > > > tests?
> > >=20
> > > No, I do the same, and this other fix for TEST_OUTPUT_DIRECTORY is be=
ing
> > > ignored even harder:
> > >=20
> > > https://lore.kernel.org/git/20210707030709.3134859-1-felipe.contreras=
@gmail.com/
> >=20
> > Note that the linked patch will break Patrick's, because we would no
> > longer set TEST_OUTPUT_DIRECTORY in GIT-BUILD-OPTIONS.
>=20
> Is Patrick's patch specific to GIT-BUILD-OPTIONS? Or can
> TEST_OUTPUT_DIRECTORY be taken from the environment?
>=20
> Either way I think the priority should be to make the standard tests
> work with TEST_OUTPUT_DIRECTORY.

Right now, TEST_OUTPUT_DIRECTORY as defined in config.mak will be
written into GIT-BUILD-OPTIONS, which then gets sourced by test-lib.sh
automatically. So even if you execute tests directly and not via the
Makefile, it'll still pick up the correct output directory you've
specified in your config.mak. It would likely be possible to take it
=66rom the environment, but that makes the calling interface much more
fragile given that you'll have to remember to always set the envvar.

Patrick

--G1Z8KhBSFweXsOkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmD1WlUACgkQVbJhu7ck
PpTqSw/8DS6EtR3QuRo2XEsaKSV190fPpkoEJqrnvGz9sxInS6x8fCtg9bHh34er
na4S+X7nHy087MxDyl80PeIZEeZdTA189uLun0VFEuJF/Si0TvfblWPYhp3j9bq7
rL8oMjXCsO1MyqDtlIzeMKMzZmctOd7iIynjkGcfhAwki3OeekpNgkezn4IlGJqT
imB34K6HS1eFOOhsxZe5Jnqh0hHoOxyqq2WHIoBzL8K2kSg/kOL/KrFKlxAZD4Cb
UW045GJtrB7JmKpQxVdV+7T0GH/OfQqcTA9yLgc5q2o04DZ3yBY7o+naY/hoCoFi
tInzP05LT7RU/FH2pQ49dZOGn0wsPApTyVmeKaVFuRQy9DYJNFdafubI85vsQIiK
Des088tsmbd9uD3vbL3J7sJkI0yOTrLIwucXqWI1NfGp8oDr6mCbyk6GOS3/v8qH
ro0ABb+pHdr/Zj74FEiTW8lBgk14S80iRSj4/6KHIcyqivI9RA/1uV7HGAyPxi9p
NXG0wvKWLnKsm/gx6yHesYiLm02SDGq/MPkU6EItMWObOUwy1ReoI2EchL00JMlt
n44AkZevx8+r+I9mI4QdusOZ/crtKu1l2d2D6ygT6f+/6ZE6a4ow0R3SPBePv649
Nq3iFCNtyOTMHv8ojOMtiu1qNz/MqiAYh25LojX8Ji6oXIdi/wU=
=7igf
-----END PGP SIGNATURE-----

--G1Z8KhBSFweXsOkw--
