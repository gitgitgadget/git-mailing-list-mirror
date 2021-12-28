Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDD2C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 23:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbhL1XB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 18:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhL1XBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 18:01:25 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867BEC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:01:25 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 88C9A5B214;
        Tue, 28 Dec 2021 23:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1640732484;
        bh=6NS8mP7oE7jvnKrXqnUVQ8eAF1dbkeGXFaD0ryWSzVE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dOKms5p89AjkriucvC7voYYmbPENyu2/7ZFRChmsBVLRWHRaZzj9UR3LsGcjJcSou
         UAX+Gw/vA/+bbEXYD658Sh8BAWfzZaoQAkyhNq6p7PJk5x7UakyUg9in+DLRBzTZQQ
         +WxJ923tEn2R8JzM1PvAfDURHBh+j6ae2qOWWjUIyxOtSGXhkBEEBLNR935QDJ1EY+
         Cn0K26+fV2vftoYEysiCou7t4mipWEJ+z0X3G/zp2rIkk8kAnXkLPqF4Ufe+8qqsED
         4LvIiRmmaVj/hE1A9mZREjMWgU9UzlotyiGeT3oWI4XXqa7Ta/HGSNH2aYn7pprpm3
         pfiulq9du+eDpyYczHZe6py/xMam1KKOxRSokdsn3lRAyL7LgDtsSGxqP2NaeXNAkJ
         sblVFF7J2Gt1wDQiAHtzE70TxPFok5uoaKDNygx+1Bu7r+9nWQN2L8sqn0QQvlR5zt
         W94ApwzfArKTfX/y2a4w8jMxmmjb3Va+NXmdCWX1oXE4eetRTi1
Date:   Tue, 28 Dec 2021 23:01:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH v2 1/8] show, log: provide a --remerge-diff capability
Message-ID: <YcuXQQHsl8iVdK8R@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <b3ae62083e14aecdfe909735b4daf0a36fa5e48c.1640419159.git.gitgitgadget@gmail.com>
 <20211228105600.h32jl5iwot3munww@gmail.com>
 <CABPp-BEJ+RiripJSonrOcJfRWKZDeoL83PDqE6beWwFqs1HxTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bKtLdJa8Ozuisnx0"
Content-Disposition: inline
In-Reply-To: <CABPp-BEJ+RiripJSonrOcJfRWKZDeoL83PDqE6beWwFqs1HxTQ@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bKtLdJa8Ozuisnx0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-12-28 at 22:34:03, Elijah Newren wrote:
> CC'ing brian in case he has comments on the sha256 stuff and whether
> he thinks there's a cleaner way to make my tests work with sha256.
> (brian: See the very end of the email.)
>=20
> On Tue, Dec 28, 2021 at 2:56 AM Johannes Altmanninger <aclopte@gmail.com>=
 wrote:
> >
> > On Sat, Dec 25, 2021 at 07:59:12AM +0000, Elijah Newren via GitGitGadge=
t wrote:
> > > +test_expect_success 'remerge-diff with both a resolved conflict and =
an unrelated change' '
> > > +     git log -1 --oneline ab_resolution >tmp &&
> > > +     cat <<-EOF >>tmp &&
> > > +     diff --git a/numbers b/numbers
> > > +     index a1fb731..6875544 100644
> > > +     --- a/numbers
> > > +     +++ b/numbers
> > > +     @@ -1,13 +1,9 @@
> > > +      1
> > > +      2
> > > +     -<<<<<<< b0ed5cb (change_a)
> > > +     -three
> > > +     -=3D=3D=3D=3D=3D=3D=3D
> > > +     -tres
> > > +     ->>>>>>> 6cd3f82 (change_b)
> > > +     +drei
> >
> > nice
> >
> > > +      4
> > > +      5
> > > +      6
> > > +      7
> > > +     -eight
> > > +     +acht
> > > +      9
> > > +     EOF
> > > +     # Hashes above are sha1; rip them out so test works with sha256
> > > +     sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
> >
> > Right, sha256 could cause many noisy test changes. I wonder if there is=
 a
> > more general way to avoid this; maybe default to SHA1 for existing test=
s?
>=20
> Not "could", but "does".  And this is not something to be avoided.
> The default testsuite we run in CI involves a run of
> GIT_TEST_DEFAULT_HASH=3Dsha256 under linux-clang.  Making these tests
> SHA1-only just reduces our coverage and makes the transition to SHA256
> harder; I think that's the opposite of the direction we want to go.
>
> These changes I've made here are sufficient to make these tests work
> under sha256; you can see the test results here:
> https://github.com/gitgitgadget/git/runs/4646949283?check_suite_focus=3Dt=
rue.
> Under "Run ci/run-build-and-tests.sh" note that there are two runs of
> tests, and the second has "export GIT_TEST_DEFAULT_HASH=3Dsha256"
> preceding it.
>=20
> There might be a cleaner way to make these tests sha256-compatible,
> but this seemed like a pretty simple way to me.

The question here is, do we care very much about testing these specific
hashes?  If so, then we should use test_oid_cache to set up some OIDs
and make sure they're correct for both SHA-1 and SHA-256, and then
replace them in the code with calls to test_oid.

However, my impression is that we probably don't care very much about
what the specific values are, and in that case, this is completely fine.
We do similar things elsewhere in the testsuite.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--bKtLdJa8Ozuisnx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYcuXQQAKCRB8DEliiIei
gV3KAQCtTNdkUBjShO57dPEWTCfWvFrDFTO9SKomaqvGdjUBbAEApyJPJXufoQAe
nQE6z05K2nzD6r6EYaVZEfSMgLbZKwE=
=hco7
-----END PGP SIGNATURE-----

--bKtLdJa8Ozuisnx0--
