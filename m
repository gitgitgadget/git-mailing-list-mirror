Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605EEC07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC2560FF4
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhGSKBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 06:01:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57517 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236349AbhGSKBL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Jul 2021 06:01:11 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id ED93B5C0109;
        Mon, 19 Jul 2021 06:41:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 19 Jul 2021 06:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ktvHRBdFX710DbTs85Z6OZw7CSV
        RQYez/B33i4EwTlg=; b=oxP7BoJcI11IEcWX4r6Ko42iZWAafRnuox6p0sya4mP
        l8RW7K1DSJ81MNEVBGLNC+AHRUxW0iWm5FqtxontqWmK/LlG9JqEUSwUhM8PLexO
        bOJ7rc2vsgGhnO0Yp7IfNEDZ4JGPX2JHwgdp35/7XaepCMMoPmsPttgsLI33k81P
        VW9lCoym+pvK40ynUu080XXMa15pFEo0HY5kyA0PxCPslvIWmgM6NyRKuCGp9Eys
        GW59XO5+/Pszladpta8KieUKSLCd6ItMkOh2/i1H3clMthqEQJmz2sGI+AUfn7Bb
        MQYMmdIFGsRcHnGCsfSnWZNxUftW6EfAi7yCFU6PlBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ktvHRB
        dFX710DbTs85Z6OZw7CSVRQYez/B33i4EwTlg=; b=AMhVrrzMyWHtljvwmTmpJu
        RGqiCoIZmkRVCEp8hLnn+MovrJssc+sTKJ2jB+YdbGpZOeOtRFqcGv7s6RL99njt
        CIjBj6TUz/dvajpzndjkHOie2Z1WPkQA2sUP6JGpQO/aIQZ8yNYvk9To1H0FT9Ex
        H/3bxQJy7/NUt6SBMbI2Ts6QG5jWAUrC9+1HQurKHHFMB01fxCmRgzT4PoL6b8/w
        m1GX+lplvBWIKA8d6bZuFg/7/G5l0S+jF164+YKsKd7xHeMQGvwlIVNVz0wtQgGy
        8XzOjEcLtDmYEhZsSeSOa2Z1UFxogqoW8FObjo3K5FZoB4VkAKRp1bvNg+4VescQ
        ==
X-ME-Sender: <xms:7lb1YHWTSBxpbxwaG2XZqHms27MFuJ8o5_8Lm35QXEtORLaTgB4HfQ>
    <xme:7lb1YPkCNO2ZnsLRZkJqgUrraoVHZIioNGJMWrcniuQ3V6fYcBu4IcQAjDlsfm3X8
    NfuIfz9EtUWb7gYfA>
X-ME-Received: <xmr:7lb1YDZSvVxAbFfJZqyNQtMufAjkQLwcm9lkDdYnkWj9YIg41thquEboOtRicso0Yuh94z_4CZGQT0VPqlGUn3onDoyUCDV6SFROn60EtAFqpJuxyg7y8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedtgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:7lb1YCXxI3eg8ao9WGDYzCUrNerze193kNvtJDmuB2hzpGrbBPupQg>
    <xmx:7lb1YBmvVKU2ayC1Aj2CMm4C3xMgttC29C_Dyj0nxF7MrNiOCnL12g>
    <xmx:7lb1YPefURTGFrVJxJLl1bVn-CKY4vs_g4UqhV2MK2cN3A_hVopa1Q>
    <xmx:7lb1YBscGJ-nlOafm4nVJKAuiVRdHSZuhpkMw8v1uALxfH7kB58Upw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jul 2021 06:41:49 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2c83a14f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Jul 2021 10:41:44 +0000 (UTC)
Date:   Mon, 19 Jul 2021 12:41:43 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Message-ID: <YPVW50Q6oyTxQ4D4@ncase>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <YPUrSB8+zEur+ZBt@ncase>
 <YPU48uSCxXbsjvGW@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N/GOe+9vjitFuWM7"
Content-Disposition: inline
In-Reply-To: <YPU48uSCxXbsjvGW@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--N/GOe+9vjitFuWM7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 19, 2021 at 04:33:54AM -0400, Jeff King wrote:
> On Mon, Jul 19, 2021 at 09:35:36AM +0200, Patrick Steinhardt wrote:
>=20
> > On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
> > [snip]
> > > * ps/perf-with-separate-output-directory (2021-07-02) 1 commit
> > >  - perf: fix when running with TEST_OUTPUT_DIRECTORY
> > >=20
> > >  Test update.
> > >=20
> > >  What's the status of this one?
> >=20
> > From my point of view this is ready, but it's still missing reviews so
> > far. The lack of interest seems to indicate that nobody has hit the
> > issue so far, and I wonder why that is. Am I the only one who sets
> > TEST_OUTPUT_DIRECTORY to a tmpfs directory in his config.mak to speed up
> > tests?
>=20
> I had marked it to look at, but just hadn't gotten around to it. I just
> gave it a review (but the upshot is that it looks fine to me).
>=20
> I don't set TEST_OUTPUT_DIRECTORY myself; instead I do:
>=20
>   GIT_TEST_OPTS =3D --root=3D/path/to/tmpfs
>=20
> TBH, I had never really considered using TEST_OUTPUT_DIRECTORY for this
> (--root predates it, and was written explicitly for the tmpfs case). But
> I also think --root is more convenient:
>=20
>   - "make test" will run in the tmpfs for speed, but "./t1234-foo.sh -i"
>     will run locally, which makes it easy to "cd" in to inspect the
>     result
>=20
>   - likewise, I find accessing the results in t/test-results/*.out a
>     little more convenient
>=20
> But all of that is preference. I don't think you're wrong to use
> TEST_OUTPUT_DIRECTORY this way, but the above points might be
> interesting to you.

It is, thanks a lot for the hint. But given your first point about
direct execution, this in fact makes me want TEST_OUTPUT_DIRECTORY in
contrast to `--root=3D/path/to/tmpfs`: especially in the context of perf
tests, I never run all of them together given that it takes such a long
time. So I instead either run them directly or via the `./run` script,
and in both cases I definitely want to have them in tmpfs given that
there's a lot of disk churn if you're using biggish repos.

Patrick

--N/GOe+9vjitFuWM7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmD1VuYACgkQVbJhu7ck
PpS/nA/+NHZz/2Nw2sAKTgWYcr8y1Z28+BpDzdPoxHm6+/3NEWBneC1fVmlGmEVt
EbvCOSuQ76QewPFWsBz6dDFEtjz4p/WqMY8D8AN92LzHdqZCiIbvdBEdAAmKilat
aOH3yfU1TM9o99gqnnVc7zRZNVPZMobJpzWSFp//p8pmxFyvBNpgCFMrpmqr99Zi
Tjewo6yZSDsJYVcpTrAfSHPbmMAEqMyB2imAoPPgZ/UkjS0kXu6GPl6kEUnQomyH
bpzP3IX8aUjOrqAv+sY5C1JMUp8mJCedtEPI6VZzemR4SKWJWOzq98NQ2Ihvf6uf
mKooIUDnTrr31wPnuqL5HjstWUzduYRfQ7M7HB9Hg6iS1JUO1FjjvMxp6uuHZVeb
o5ZpB8f9n7ZNvAfanWR21gKafRFHBTgT1rSOqfLgltO88prOSiKdABF1Qrky9jXC
A2Pi7Xqau1UDTEVkQck5H1CnP5qK3P0f+DNJevS9Ozj2CU40esGawVIVjF09YE5e
UROCh5cuXP/HEZY77dCnmgR5cAnoO/39+9fQF6mFjbuT4Z7yj6+HrHe1JwLmOqEW
GPQA64Wdw1eW0Kt5JzqmGjfwVcPKjCBAwslKSJSBvosk87KsVKCY4TC4JFftdaIp
IwxQftsp5y95cp+o3FFFMWGyQdur+LEtHYQ5+d7CXM2NzugsyVY=
=Jjmw
-----END PGP SIGNATURE-----

--N/GOe+9vjitFuWM7--
