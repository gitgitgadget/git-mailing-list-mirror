Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB2AC07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A6161026
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhGSKLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 06:11:47 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51237 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235621AbhGSKLq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Jul 2021 06:11:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C9875C00D1;
        Mon, 19 Jul 2021 06:52:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 19 Jul 2021 06:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=C0IiQ8RcDUoL5pXxbVIb3v3+/MG
        XXmWcB8azI3zdjXk=; b=Nqz3NjXThbM7tiQZP6rpHNIE1imGHww/s6S+IYQyXYP
        2V/yXKkv7/K+NIf8S1axCXk8+oeNM5LHTBE6dB9vvIryfNVHQMG+uc5+Yhb9i/7b
        pFE6+RXMo884fJI/qexgw29Lr47ZctqXsJIZa6+I8GYdFssTH8L4K3B44jYGbavE
        Q94nKL9SgPurtD7Yiuut5E1NpcAgA2BtcZ7Y+EIELHiPnRrkyTsaFtrp6yPTU/eV
        tXA35kATinFLiXVtUz9xI6V7QBHIT5yXOF2j7dZdHuJNwikLYQkzwFoO+yqN/FUH
        FhJXnG9ntzNFjS9HYgXaPiu5k4wK3Wre/UQ7SvEIj6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=C0IiQ8
        RcDUoL5pXxbVIb3v3+/MGXXmWcB8azI3zdjXk=; b=GoqgfP9f3cHN9TXmWw+wIo
        8yfqn24KLKPX5n3BdKLxUiRjyMIYa9ocY3AqDOiOo/MCIolW46CQYhLUtQK7Xxy6
        odHIp7IbAyDU9nBMZ6I5ih2YLQzH5wVF//riMMb/ND2yYjqt5JBGbVJ6nPI785Hb
        OHNfySFxUmLR0w5AhuDl6w7S1RjSdQiOiDh/oM5OEXdHhXTR/E+yp+lf8Kx8W/XY
        K7iHW6m5HTuj4y/ggkvioY1x5SBJf2xP3t1RaEwmNCPrGX/dh2li4Vl21wyta2aC
        JLaQ42kGUu6EzIUpHPIiyTw+EvVDof27XsWxKuBzvZfTQHQ9UWNeGQMo6UFH0AQA
        ==
X-ME-Sender: <xms:aln1YGj_qRV7HWGG00kaV0oy5SQLzUyWHNBYUAD4EFL11_1aVBOE4w>
    <xme:aln1YHBLr-AwXJjoLOkyM2opDjWixsA5lrP17zIMRq_fVHGNLcq0JxOmzNwwJbma2
    Bo1FPiaU0m-wGvb3g>
X-ME-Received: <xmr:aln1YOEWCsvAm-rLKoSJklm8UOISHvlyCWjt_beCxeX2LmWOt3n-QNaAJa5J0qThz1toFdSMGfYP3_St7YFvTHB65eKFE-cESDZaqL4xITFYeAngvESivA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedtgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:aln1YPRPKf4Wp4Nil_bnIZQy3-QW3lgW2mNfF_iq81a3UfMm5_hn4Q>
    <xmx:aln1YDwHoN4gCKULBkooSzZjicT1B8e4Il6UZtgowhL6OviJWNNjVw>
    <xmx:aln1YN6Y2cTtYnKhjb_MmexBPa77FyX2-3OgKwe_CQMg-dmcDZW_qA>
    <xmx:aln1YO8_liMozrtSY1uLFYIu9qGoqi6uuR-83Y2hKkpQjkCggQPs5g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jul 2021 06:52:25 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 71d0b356 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Jul 2021 10:52:23 +0000 (UTC)
Date:   Mon, 19 Jul 2021 12:52:22 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] perf: fix when running with TEST_OUTPUT_DIRECTORY
Message-ID: <YPVZZl1FI0D8kK6C@ncase>
References: <005cc9a695f7f9b17190293821369763e9bae662.1623834515.git.ps@pks.im>
 <cb9d948646e8181e9c9c8dc35b37d48c692a92fb.1624024532.git.ps@pks.im>
 <YPU2+bG8Nge5FKWv@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MKHAyJ17QAh67gTz"
Content-Disposition: inline
In-Reply-To: <YPU2+bG8Nge5FKWv@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MKHAyJ17QAh67gTz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 19, 2021 at 04:25:29AM -0400, Jeff King wrote:
> On Fri, Jun 18, 2021 at 03:56:08PM +0200, Patrick Steinhardt wrote:
[snip]
> > diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> > index 601d9f67dd..f5ed092ee5 100644
> > --- a/t/perf/perf-lib.sh
> > +++ b/t/perf/perf-lib.sh
> > @@ -45,7 +45,7 @@ export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR G=
IT_TEST_CMP
> >  MODERN_GIT=3D$GIT_BUILD_DIR/bin-wrappers/git
> >  export MODERN_GIT
> > =20
> > -perf_results_dir=3D$TEST_OUTPUT_DIRECTORY/test-results
> > +perf_results_dir=3D$TEST_RESULTS_DIR
>=20
> This line puzzled me a bit. Isn't $TEST_RESULTS_DIR already defined to
> be $TEST_OUTPUT_DIRECTORY/test-results? If the change here is just for
> clarity / readability that's OK by me. I just want to make sure I'm not
> missing something.

Yes it is, and IIRC the change was just for clarity as you assume. The
logic to derive the results directory was essentially duplicated across
perf-lib.sh and test-lib.sh without much of a reason, given that we
always set TEST_RESULTS_DIR in test-lib.sh.

Thanks for your review!

Patrick

--MKHAyJ17QAh67gTz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmD1WWUACgkQVbJhu7ck
PpRIzQ/7Bk4PSUZk+zt4010nhoHzuLA7v3udG0f7de8oxWlq8/oj/j4i5KzNIqeF
99Y5DR279tgfmNQM13n6Lr8BF0JUXJm3re6jf0ajyWP2EFcQsL/9gg2WUFuzUvfc
eR4TVYPlBtAOtzj0tl5Gu1eH5OsuaeVedj0WaPPoe/dxYThYZ1bDGfQBDJQlaRHS
CcrYPzia/Sngcjfqu9DQu9H9btErCVJY6wONvljEX09jGNmAEFqhdsSPixntSH6+
NGC3dPYlKKemMhed35fq9ix/arcSXClzuyp/b7sFqGEEc+u+4Xh/wk9OE5HyuhYd
eqBuFIp+ZM0pzS3qBuGKWNERNgIoJursKH8FjF4scIj53g5ucRHTmE1xv7IXFB7a
i14CV5cUaVxELOnaR2dMA6F+X0n5g5p/cM1pC5QbLjsql82XZxYmB2zYbuNz4Cht
7Z4WfuUiSdHcV6S5St35h5VFa7f/CcLKgruPI24fCFhxL07Wo+lK+e4+i0AZRDYn
vnORLWmiPmbvN1dU1qScCuzJs8/9Uhs87vawjq4c8QdDiCdX+uHxpZCVorz0m0++
xwi/beyt7t6p7hprO/n9Wh1rjE8yvibi9SVP2/WjeVGiA9y1Xc+wQ+KahzLcWDdq
Jwct2yQgMeY1rcGtYyia+7eGu/bI3y1rK8k81NkOUlZaWPjEY3o=
=JLih
-----END PGP SIGNATURE-----

--MKHAyJ17QAh67gTz--
