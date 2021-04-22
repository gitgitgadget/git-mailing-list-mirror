Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270C2C433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 05:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A9761027
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 05:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhDVFhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 01:37:34 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:43511 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229547AbhDVFhe (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Apr 2021 01:37:34 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2D8BEFBB;
        Thu, 22 Apr 2021 01:36:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 22 Apr 2021 01:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=OV9ZLi+bN8NdlESYd8OWHc/WHMS
        /EKLsDOkmGgsn5Yc=; b=W/YkbKGo1BQzdKraE7KdP9Cl9Sg04Zh+LbQXCJyZ47w
        6Ym3EDnvivJDwvxt+1n5b/XoQ5O+ne2WGjq/OdxHF1+ybXdPEDrZPMky9spA2zEN
        KOU2lM9IDgSznskZaU9+AhlkbhVA9IJ6GBzx+VFt5tUgbZ/pim2k3q+R/qV/E0uY
        Bm8jR2lxAY6PY9KuJIehZNozttnrnFAVdk3Oab4MfUZUraq2/i2PHP0zuRlYPVvw
        FDfDsKUjkLGUx5FsBjE9szn7gU9M0Hgv2nPGfRcYCLeJw9vAx/+D7+aHV1Etbfms
        HK8+ROZ86P1GRxrncyFzKQ1/LirPsnz74R1mhiHjJKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=OV9ZLi
        +bN8NdlESYd8OWHc/WHMS/EKLsDOkmGgsn5Yc=; b=DxWUlPRLN2Atoeo1/fDZSG
        HIuVDmS0ybs4YJCPsrq5IxnfEOuAcKqKhtbgDkOHV/nZuHhAenvCDTayE8wT3vkV
        6MwcqX8SiaPx+cd5u24t8whNebEWpfKUCgM4XivDAf/0WqjxYWyJa3ooYqq4CLh3
        R4/Ijr/oR6DIdBrJEyeBAZiaqf4PP93k42hMMTJUhx8fpuYwgd4BY+DYBF4FR9Tq
        IUdRjquAOYvFBNfZm9iLxnfin6YTW/+MoVsIHC+QDtDDqUBGw14lxsrUy9m8vKF+
        3+TmCfDHRe+nNQvJU+ODo0SyTur1FmAVnfmd+dlBdqOTvmYBb4F47GcqvqSlXGYw
        ==
X-ME-Sender: <xms:dguBYDXorjvvpmn875hL3IBWN4QueXn0Wb2e2bpaLrZEFKPZYv3DRA>
    <xme:dguBYLmY6tzoGg9i826wpM0ciD_AVXZecFzNev0ROucvO4eiBU4XXP_w-9KvEjxOx
    0fwG8_twN4uihcD0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtledgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtffejieduudelhedvgfetieefleehjeetvdetudeitdetvddtfffffefhvdfggfen
    ucfkphepjeejrddukeefrdeiiedruddvieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:dguBYPaUBQVx2GftWRu7-lrKyaRg7zqmtH2RV_JBYvv0QVelhoqwyw>
    <xmx:dguBYOXc4BIUDZWJloCNm6yi8kuB85fvxpSx9xMDr1VU2FZx6hZnMg>
    <xmx:dguBYNmPk4V2tX-x04lDGYUI7r_AkHUx0cObzlkYyP_lEr7-uQzGxg>
    <xmx:dguBYDgX2rtQa94ZRO6wvhbFcItvegRMPZ3Rz_GkFHGY3nxTw3udYg>
Received: from vm-mail.pks.im (x4db7427e.dyn.telefonica.de [77.183.66.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A1BE1080067;
        Thu, 22 Apr 2021 01:36:53 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 87056d7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 22 Apr 2021 05:36:47 +0000 (UTC)
Date:   Thu, 22 Apr 2021 07:36:45 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/3] config: allow overriding of global and system
 configuration
Message-ID: <YIELbYi5Wz6OALqL@ncase>
References: <cover.1618297711.git.ps@pks.im>
 <cover.1618835148.git.ps@pks.im>
 <7e7506217e4aac82e3a03013d24e6f885383ecd3.1618835148.git.ps@pks.im>
 <20210421204637.GA2947267@szeder.dev>
 <20210421210614.GB2947267@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BTqhYlWV7/wnNk7k"
Content-Disposition: inline
In-Reply-To: <20210421210614.GB2947267@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BTqhYlWV7/wnNk7k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 21, 2021 at 11:06:14PM +0200, SZEDER G=E1bor wrote:
> On Wed, Apr 21, 2021 at 10:46:37PM +0200, SZEDER G=E1bor wrote:
> > On Mon, Apr 19, 2021 at 02:31:16PM +0200, Patrick Steinhardt wrote:
[snip]
> > test_expect_success 'override global and system config' '
> >         test_when_finished rm -f "$HOME"/.config/git &&
> >=20
> >         cat >"$HOME"/.gitconfig <<-EOF &&
> >         [home]
> >                 config =3D true
> >         EOF
> >         mkdir -p "$HOME"/.config/git &&
> >         cat >"$HOME"/.config/git/config <<-EOF &&
> >         [xdg]
> >                 config =3D true
> >         EOF
> >         cat >.git/config <<-EOF &&
> >         [local]
> >                 config =3D true
> >         EOF
> >         cat >custom-global-config <<-EOF &&
> >         [global]
> >                 config =3D true
> >         EOF
> >         cat >custom-system-config <<-EOF &&
> >         [system]
> >                 config =3D true
> >         EOF
> >=20
> >         cat >expect <<-EOF &&
> >         global  xdg.config=3Dtrue
> >         global  home.config=3Dtrue
> >         local   local.config=3Dtrue
> >         EOF
> >         git config --show-scope --list >output &&
> >         test_cmp expect output &&
> >=20
> >         sane_unset GIT_CONFIG_NOSYSTEM &&
>=20
> Unsetting GIT_CONFIG_NOSYSTEM like this does affect the environment of
> all subsequent tests and their git commands will then try to look at
> the system config file.
>=20
> Putting this 'sane_unset' and the rest of this test case in a subshell
> seems to fix the issue.

Ah, that makes sense. Thanks for digging into the issue, I'll send a fix
for this later today.

Patrick

--BTqhYlWV7/wnNk7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmCBC2wACgkQVbJhu7ck
PpTfYA/+NPxaE1lHxuirTmx2KBkvE+IOTac0AH3yDbZxnu1DIlB0B10FBwOrCr0w
1VMgMdAsK2xyGKOpilYCMOrSOSUIr3bqYqTU7SQ+FJ43hPzNr+Lh9oa0ovjyX0ks
AS9t6T31GEUiikgmBk6BcGVYl1Mxw3ZTWXbJTzovOeiK9QztgIx9UN2+wn8NNJu0
0k3IJaqM8vEbOq4F5ChzVd3HyMueodi6VJGesmQ+kwsP6F7WAGvjdlNn2hv+Sqql
a2utKCOrTGWjsgDkPl2pg3P0xJsQ+XWflpl6UhbLWFn/HrELbY7BE4pVC8MQFhaR
cBFdF21PgqgLNyP53gKnUuA3vXJ2JQUz4RPXmicBymbKVUajr39BoXSm+v6yXQys
+maVjjZh8UZ083ucj6xodXJN6LCcWq/4A76wDYOOwJrdH1ddjh/lXb+m3ZuXjHCf
B7sqs0sppSqi8AS8sxOWZnXOCrKm3iO48GZZFNWpFt2jjMCLCR36J6FM6Y7LaEOb
OV+BQNqiiaJrXRSnSaz1DfZJPf9Hb0DsEpV+odLEseeYkYhikkcTHQsbkXBUs7LV
EQSWo/0lQZ3RXzdCNQTlHLyYoEyiQXhU/bh2P22iggJEHnia2ilCNAFxj4sfY31g
6QA5DiBOriz74snqD6rooxpgcBPphUFQK5rblbAqJZFHoCmbHPs=
=PtPL
-----END PGP SIGNATURE-----

--BTqhYlWV7/wnNk7k--
