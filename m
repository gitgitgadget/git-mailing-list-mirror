Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FCFC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 11:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiBQLNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 06:13:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239696AbiBQLNo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 06:13:44 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759FD1ED1CF
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 03:13:23 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CE5EF3200C17;
        Thu, 17 Feb 2022 06:13:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Feb 2022 06:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=oLZFOzqj3GFSeYgDOVnD1/m2cRgAF4iicH0Byz
        zh2pA=; b=sKjd93YZo9bJQaN6p676N4b9yzc3PQRsZMvWXqiLoJQIL1Z0LkJ3Mx
        K04GaI7q7PaXiCP+6PQLIzV1j/jodByFBwZiBf0ru4+21icmBxSwxPiufiT245z0
        YKfdVCIP+SECjfupUDvGHgTOfwBW98u+zOqtXDWBdMfdGhNALUKI2aFkUFZxusPr
        I09x3qSbbYFeaJoB+sX3jgpj7AWWSMfAoYmMPfeUq+rQfxZrx5ILPei0c4K3F4IS
        dffB9iJKCZ7Ns7+A2OvmfRKhcJnfouRRFJDt2oHH4y0N59iRr63CabmyKFBKbxE4
        WSYfUzPvm+E7ON4CEDSWbVTQbTmQR8Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oLZFOzqj3GFSeYgDO
        VnD1/m2cRgAF4iicH0Byzzh2pA=; b=VAVHVilDaJ/mloli6CcIx0n0dYASyWdIo
        8jKEtB2xDMLvrZTytLd9NpxcSGitoLyt45Ip95DMwTnWRAdpc/OyPf2GoYOroNYc
        jO5X+RB7TInD0ty7l8ma9Y4VsILPPnL7rhSkhUsxacC8Xi7grHH4FNa6gOomfI+5
        QhTPOI6H978QNjPxMJJcHacOocS0wDopKYkHwTaA1LE7MjCA/goI5pLBMjO4xDsM
        pxvYMmOcUueDYZK5bqnidEzNSqJiTFZWl8kquGxM+IU4yyY5yI8iKCkA3MSwMgi3
        nukgamTdsoWSztxFEE3m6Tn0GPoqXpAHyWSK3oV5Tjk2+WQVosymA==
X-ME-Sender: <xms:zy0OYsKJJ7M9cboI96WkIb7oM0ozr-S7Ei9JAm0hFrI_0o0HKa0U4A>
    <xme:zy0OYsIPaFBZLlzC7gNyuY1VYldb0Vj7jfZrNolv8ODqytWzBhWMdtqqBs41_JnDc
    1d4AmuYqfESKPNnOA>
X-ME-Received: <xmr:zy0OYstZr3SX83AItfckVxQeIeGAibU6aG9ENZoIAYXFuVfpq-GUiazZj5bnSankpTXsFLtU3iC_Wj4-thumCxiDIwrBlLYSB5WLfXBOfEnjxfx3NNnDcc0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:zy0OYpYJXU-8eRr26CrBMCbls2b9j0NvtBO-K42Ft8GB2qH8MLIRug>
    <xmx:zy0OYjadxYf0qLzGaMuUICHUsbZjHwOOYadlzmJs17MaPT4LHJvEpA>
    <xmx:zy0OYlAQEZ0NFkSXOBl2hGzCg8wNupIiT2pEgSyIXpTjRbA5IpTwOw>
    <xmx:0C0OYkDFAyt4cmqqjYHPZK-v55aDO6AjHvAhuPgaaR0-w8tQgF32NA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 06:13:18 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 84f1013a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 11:13:15 +0000 (UTC)
Date:   Thu, 17 Feb 2022 12:13:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] fetch: increase test coverage of fetches
Message-ID: <Yg4tyssgW9OAu6K/@ncase>
References: <cover.1644565025.git.ps@pks.im>
 <e133c14f569116156bbd3e0ca4874e8eb54b76b8.1644565025.git.ps@pks.im>
 <CAP8UFD2HswmXhqYTAMxQ0iYFtsErMS=DB18iv52Ujs=cAW9ytw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aMTTlTRenS8RARIm"
Content-Disposition: inline
In-Reply-To: <CAP8UFD2HswmXhqYTAMxQ0iYFtsErMS=DB18iv52Ujs=cAW9ytw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aMTTlTRenS8RARIm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2022 at 07:19:19AM +0100, Christian Couder wrote:
> On Fri, Feb 11, 2022 at 8:38 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > The `--atomic` flag is missing test coverage for pruning of deleted
> > references and backfilling of tags, and of course both aren't covered
> > correctly by this flag.
>=20
> It's not clear to me what "both aren't covered correctly by this flag"
> actually means here. If it means that pruning of deleted references
> and backfilling of tags don't work correctly when --atomic is used,
> then it could be stated more clearly. Otherwise this seems to just be
> repeating the first part of the sentence.

Yeah, the commit message was a bit lazy to be honest. I've reworded it
to hopefully make clearer what one is looking at.

> > Furthermore, we don't have tests demonstrating
> > error cases for backfilling tags.
> >
> > Add tests to cover those testing gaps.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
>=20
> > +test_expect_success 'atomic fetch with failing backfill' '
> > +       git init clone3 &&
> > +
> > +       # We want to test whether a failure when backfilling tags corre=
ctly
> > +       # aborts the complete transaction when `--atomic` is passed: we=
 should
> > +       # neither create the branch nor should we create the tag when e=
ither
> > +       # one of both fails to update correctly.
> > +       #
> > +       # To trigger failure we simply abort when backfilling a tag.
> > +       write_script clone3/.git/hooks/reference-transaction <<-\EOF &&
> > +               #!/bin/sh
> > +
> > +               while read oldrev newrev reference
> > +               do
> > +                       if test "$reference" =3D refs/tags/tag1
> > +                       then
> > +                               exit 1
> > +                       fi
> > +               done
> > +       EOF
> > +
> > +       test_must_fail git -C clone3 fetch --atomic .. $B:refs/heads/so=
mething &&
> > +
> > +       # Creation of the tag has failed, so ideally refs/heads/somethi=
ng
> > +       # should not exist. The fact that it does is demonstrates that =
there is
>=20
> s/The fact that it does is demonstrates/The fact that it does demonstrate=
s/
>=20
> > +       # missing coverage in the `--atomic` flag.
>=20
> Maybe s/missing coverage/a bug/ would make things clearer.
>=20
> > +       test $B =3D "$(git -C clone3 rev-parse --verify refs/heads/some=
thing)"
> > +'
>=20
> As this patch series is about fixing buggy parts of the behavior with
> --atomic, I think it would make more sense to use test_expect_failure,
> instead of test_expect_success, in this test, and to check that we
> have the correct behavior, instead of checking that we have the buggy
> behavior.
>=20
> Of course when later in this patch series the buggy behavior is fixed,
> then test_expect_failure should be replaced with test_expect_success.

The downside of using `test_expect_failure` is that one cannot easily
see what exactly is broken in the testcase. Yes, you can document it,
but when using `test_expect_success` the huge advantage is that you can
see exactly what behaviour is changing in subsequent commits by just having=
 a look
at the diff of the test which adapts it from its initially-broken state
to the newly-fixed behaviour.

> > +test_expect_success 'atomic fetch with backfill should use single tran=
saction' '
> > +       git init clone4 &&
> > +
> > +       # Fetching with the `--atomic` flag should update all reference=
s in a
> > +       # single transaction, including backfilled tags. We thus expect=
 to see
> > +       # a single reference transaction for the created branch and tag=
s.
> > +       cat >expected <<-EOF &&
> > +               prepared
> > +               $ZERO_OID $B refs/heads/something
> > +               $ZERO_OID $S refs/tags/tag2
> > +               committed
> > +               $ZERO_OID $B refs/heads/something
> > +               $ZERO_OID $S refs/tags/tag2
> > +               prepared
> > +               $ZERO_OID $T refs/tags/tag1
> > +               committed
> > +               $ZERO_OID $T refs/tags/tag1
> > +       EOF
>=20
> The comment says that we expect to see a single reference transaction,
> but the expected file we create seems to show 2 transactions. So I
> think here too, we should use test_expect_failure, instead of
> test_expect_success, and check that we have the correct behavior
> instead of a buggy one.

Same comment as above. I've also amended the commit message to say why
we're introducing the tests like this.

> > +       write_script clone4/.git/hooks/reference-transaction <<-\EOF &&
>=20
> Here there is no #!/bin/sh while other uses of write_script in your
> patch have it. If it's not necessary, it could be removed in the other
> uses.

Good point, I always forget that the shebang is added automatically by
this helper.

> > +               ( echo "$*" && cat ) >>actual
> > +       EOF
> > +
> > +       git -C clone4 fetch --atomic .. $B:refs/heads/something &&
> > +       test_cmp expected clone4/actual
> > +'
>=20
> I took a quick look at the 2 other tests after this one, and I think
> test_expect_failure should be used there too, instead of
> test_expect_success.

Patrick

--aMTTlTRenS8RARIm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOLckACgkQVbJhu7ck
PpSxzg/+OiT6JWgs59DuamwMusoF3z3wlpEpdKfTp6EcaBGjTixYcfNnheUGMGXP
8E1+C5+5ptT6Hq49I6k/2+qtgfr7wqxOE4BEdNGok9dS0m04GPjmi6xeGWzF/eLw
3Js1Ps9u0MVJeI6r5xbH7FFpqKKJvvPs891niEAFPEZkvrVD7gPUBipIxrH+jIzt
MOSaA+aUvyb5eiFEWfn49hrB7PHADy7JbB16M0i++MhuCzGhKJBsAv/uiS+3fwI+
0eK850ot2vcayeXP6MUMEHJD7bPqrIl5OLDuisS4aMbOzCCyMc1qHKD8OOewiKEc
QpvBvXGGmcPV+xFMPc0LQoygfVv9Q3zNaQOCyxXTphNP6UN766S0dJmNkkzNiWOu
Y9F9NmRAxD3DDimOW2b4sc760+sRIufrXooW88LntXPV32lJyMSOjaNK6EzX/VK3
rHJsmleqIaVPK984ICg+l9V005qOOmtgrW/QoDlVCgZN+P0InefE56GkoW/8qFnK
6zbjdoalWdA20QtXa2eCuVncmtIVXvv/3tfHjkeQ2xIz6MjCbHrQMIB6TX9mzTeb
0wI78MnShQpw1Lo0hNva6b3nGMGaus33XS2LLfJR0ZKY8jrq3uVAtQTUJ5rkw1Yl
8S2Ef40XD4qoIGPnUT446XR4eEQfAKaeTHEIYBfaNIxlf38mquE=
=QmOt
-----END PGP SIGNATURE-----

--aMTTlTRenS8RARIm--
