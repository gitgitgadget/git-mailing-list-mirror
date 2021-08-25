Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6535CC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 15:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444B56108F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 15:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbhHYPoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 11:44:32 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:60043 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240408AbhHYPob (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Aug 2021 11:44:31 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D48643200B54;
        Wed, 25 Aug 2021 11:43:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Aug 2021 11:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=47u7Wd8Ipsuqb5SVqGrjyKj0ueq
        lwxyEFR1GK2nS+AI=; b=K0JBWqbsDwZslL5G5GFqcmFrEunplcJZLnNrcUcHTWL
        3vYjpKEsM1YlHgR6odH7kNAQM7Xm4cmYUgoJPdFpNjNWPUN7JyH2WE5dME37g1F4
        /ZAshyNGBw4tIkuEL7Q9gpE5EloEjp4UlMKYwWv13X3eDwV5mIeSazonrXMvMskC
        LpY8ejgF+NX6PQSl8rn8uu0tlP1aTFHARyU3bgTtBjoDbpK5aJaHZTmAWZzShXgV
        4iXZvgB78S3MYpSRgc9vnlHw9hAHQAjzyKGwyDxSHJL6R+2yWkYTmPUEL4lgJqGF
        o65vaCjsuYISfYPYgevygJQ+sZBOMeikwMOtHSxd0ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=47u7Wd
        8Ipsuqb5SVqGrjyKj0ueqlwxyEFR1GK2nS+AI=; b=dpaQS+3kxBOUoi39Mx5W7w
        liFQhFLWMD7Gv05q+TmEaobXrXaMTMCU4VVtBIhT3J+mwcio8dpoNUbUIgKqEqM/
        bfErlX0zfTXKaNJ/f+xVvnHGEKv6tdGco/EDRtxrenFTXbeTy14y4DiK7e+ETqqo
        J+f56qKglfRAI9JTrdI004ll+AdHyRDnsMmHWQRYPQkjRIneSextsqRkT1Gvf5eP
        sCRs5BuWA3Lix/2rvS+xfXf/z/dOKU2zm1dkA2spJ3lg76f6jHE2RGTGGwRCxpvM
        gZh6ZKHjeunMbQ61pvitHtkFHPqb8i0S38G99P2WKCyPvDl9nVjIUEdzapUSoOkg
        ==
X-ME-Sender: <xms:MGUmYQqDx-tDN91guofpFQ2yTdN9w_7bSfvrLX-ljZ2qOIHhpnE3iQ>
    <xme:MGUmYWrj22RF5zD97LUhtHQNhkwfHnY-eWVrP47oUBD2cvkummb-Naf2Mv0AW2kq9
    C3WKP_UcA1MvD2UMA>
X-ME-Received: <xmr:MGUmYVNoCQklJW9WsxeEepSs6yT-N9WddueWwX-SU7iKmZILKeHXxxhLo3XGMB2jfNYhTAnrxa9X0d5k7AGJVjp9FZTiIUJg-TEqqNVVUUrQUHQwAXaMJv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtledgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:MGUmYX5pI7g0fr-CoHjBFfZhZg-eSKmnn9zLkUUp4mRST8z4j82i0Q>
    <xmx:MGUmYf7iRvjYIx67PweQbyi5KDSnRwTYUxkMsiee0r1SSMR4YZIaPA>
    <xmx:MGUmYXh2LW1tc6_8D5YdN3-0p1_Ha4rFVN8wq_JepjLjAqTonUKTyA>
    <xmx:MWUmYcgcTsutJqkTXdz447BaRdJrmuIpS2C_hWLMV0CEC5UhxPAfcw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Aug 2021 11:43:43 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e4146c4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Aug 2021 15:43:40 +0000 (UTC)
Date:   Wed, 25 Aug 2021 17:43:39 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ls-refs: reuse buffer when sending refs
Message-ID: <YSZlK2y74wmYQcSd@ncase>
References: <ccd03e685af0f5cf25c68272a758fc88d115e37a.1629899211.git.ps@pks.im>
 <705fee2c-7711-ac99-f692-ab08cd7b4e26@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CLn4Jj3MiyO8ejmy"
Content-Disposition: inline
In-Reply-To: <705fee2c-7711-ac99-f692-ab08cd7b4e26@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CLn4Jj3MiyO8ejmy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2021 at 10:50:30AM -0400, Derrick Stolee wrote:
> On 8/25/2021 9:49 AM, Patrick Steinhardt wrote:
> > Improve this by passing in a buffer via the `ls_refs_data` struct which
> > is then reused on each reference. In a repository with about 2.3M refs,
> > this speeds up local mirror fetches by about 2%:
> >=20
> >     Benchmark #1: HEAD~: git-fetch
> >       Time (mean =C2=B1 =CF=83):     25.415 s =C2=B1  0.131 s    [User:=
 22.722 s, System: 4.740 s]
> >       Range (min =E2=80=A6 max):   25.240 s =E2=80=A6 25.543 s    5 runs
> >=20
> >     Benchmark #2: HEAD: git-fetch
> >       Time (mean =C2=B1 =CF=83):     24.922 s =C2=B1  0.110 s    [User:=
 22.404 s, System: 4.476 s]
> >       Range (min =E2=80=A6 max):   24.825 s =E2=80=A6 25.081 s    5 runs
> >=20
> >     Summary
> >       'HEAD: git-fetch' ran
> >         1.02 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@kps.im>
> > ---
> >=20
> > Note that while this topic applies on top of "master", I've done the
> > benchmark on top of my other optimizations for fetches. It's cheating a
> > bit, but it's easier to see that the optimization does something when
> > the remaining constant part is lower.
>=20
> I don't mind demonstrating an optimization using the other work.
>=20
> Perhaps this would be better grouped with those other changes?
> I know that the text is independent and merges cleanly without it,
> but it can be helpful to think about the effort as one unified
> topic instead of juggling multiple, especially because I don't
> see the other one needing many revisions.

I don't know. I just happen to revisit this topic every few days, and
every time I stumble upon some more performance improvements. It would
feel wrong to shift the goalposts of the other series every time I find
something new, so I instead opt for separate patch series.

If this proves to be annoying for reviewers, then feel free to shout at
me and I'll change my approach.

Thanks for your review!

Patrick

--CLn4Jj3MiyO8ejmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEmZSoACgkQVbJhu7ck
PpTXKw/7BJLThpK4HpVb63S8NQm9nE7CbAlMCdY044jUJHlmnhr1SwKYgauX6l+m
8cJ4Im9CjIl0x8hm0WcMz/bU9K288s7VXRhF4Z/OizSXQHhDtzPs1bgl2Wz4CZNQ
SFNS7Nhkdi5ticc9HXjM9kRxiIxaBMB1Io9qBDWWcZI/Wx9dRam+bUCCT7lJNHRg
Ll9w5aUK4KOt/SehSOT0wdEHLgVQUrdjpDXzZsl/HV/qFnugI07zwL0krwxWW/O1
N8yo0Go8af+2e4czp51UXFAGjqZlhHAQ595aFTYYXLwu8HG6croO6BMjQGfI+jpg
XtKE1CcIUi8jpVTAin32J5T74+n3aadBOQiCC4jeoI0D1v52N8MzTKUaoGsnDUH7
UZNkZkfjyYVwDy62GDjxrM5ZBIXQUGvDLOUsow7z5LpJP3hTEVG/SOCrz4e8A7BT
tAzp453DQ6X/yFcmJ4XpO8DGa0PQLgxoOfvjlpTfHqluW343NbzWfFYphHU/QvVT
0tQqqDaHXnx6YwnltTMbuoRscqZjwHL9GW4CbUvbo9uj3uhKWvhPhDQsXlENb3yx
KxI16S00Faw8oOdQcAB2DGrdfqOBFT4HJYGa+swcxuYY9BGB4bEPjWpLc0z0Z5ma
uE6Ry2gnAqQEQV21M2/OGVWR6t1K1WiT7WDNPFoqGyAnOuy6UVk=
=EO00
-----END PGP SIGNATURE-----

--CLn4Jj3MiyO8ejmy--
