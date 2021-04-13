Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8524C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C3C61244
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhDMHza (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:55:30 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53355 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhDMHza (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Apr 2021 03:55:30 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D6FE5C0174;
        Tue, 13 Apr 2021 03:55:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 13 Apr 2021 03:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=QJAqCGw5Mt3OgILNEaVb0gQVMyp
        BVwDivRXF4PW3BZA=; b=srmuexelmaK4xMifRx6x48HXfg5rfXOFrgcqQBGHWAc
        u2rTHpnBEYKhec/e4zTUYeTqMcgEXQ8Bm7tDoSAi4AhFIshMSsHRwiYT6+8ph4XN
        SddBvF+5vPDuw/YLOHvIX7j2cDl1paFZXzOMuyxEfby+SnS2GGeWXghkkUvJSoo2
        G2iC9Gw2l0vKDwax2gga//h0jsIkQtX5VLpwFvpeUi6zRoXrH40zfdktrgEF38qO
        r2vbisaHBVXFbY7Ek5rl8vXdxYFYHPinTsxvdXqeHpMUVUGlWRCahylJeAHE2+2i
        TCgbIX5iI8fM9nYMh7uPth9lcuNLet2DvIV9T11BrLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QJAqCG
        w5Mt3OgILNEaVb0gQVMypBVwDivRXF4PW3BZA=; b=nlBeaemWtlEC/VNkdqB51H
        7yEB8f41tIgvUf/IJGsWaa2hy9b08evyibdgQw8rDQS8TxETeWEc3EAbmbvj2fd6
        y1wcfNkEk+wFQRZpzaYCAt0KLl9C+IPNf2tOZqdUkKCd9Woa6jAZLm2XcsHgYdVb
        YlBDfkoc3b98EqWvsxacLGD9opT44jPOlwBZTTJTen1LkfeMw7lV5LNGRhfY7iKw
        2eWL4unmtElsWZ1xWr8krJckLmfMStdBRVUhBbybHo1MvdtwOkDDs9qBagWAhz9z
        8qfze9Xinnfa5qpUooRQmMK3AgzKZmIlmQfx9BA0WIUCpsq/9MyGEPEcVMwRqU1Q
        ==
X-ME-Sender: <xms:XU51YNgM0vHPeGOEaMiu6x-A9lMcaew5D4afoIZGSA-37c0Ydn7eqw>
    <xme:XU51YCCkDx3xvia4IFUUzlt7g3sCO9lJi5BRaq-GxUYJiMbJlvJ9RnTwoVBmBHTnV
    oO1FrKc-sWNKTMQ5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekkedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdeffedvhfelheehleeghedtveeiieekffduvedvudetfeffjeffjeelleefvefh
    necukfhppeekledrudegrdefhedrvddufeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:XU51YNH5_XG51vTsZAHfsU3-HvNk2EAW0WAGL00SyWAgDrIlAIhIVA>
    <xmx:XU51YCSQJIfQGHwXyPmz5O2BIXOHGdODNrkeSeuiYuThyjs-JZ8B8Q>
    <xmx:XU51YKx7hblwTM-oSEW-PGopJX75M2Oriij-tNcb51d1ZqicFu3MyQ>
    <xmx:Xk51YF_Sq0L1aRMSRah4a1z08Alzoi8Cm3DIn5jrVNbiE1f6za8mqQ>
Received: from vm-mail.pks.im (dynamic-089-014-035-213.89.14.pool.telefonica.de [89.14.35.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id C0E87108005C;
        Tue, 13 Apr 2021 03:55:08 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9b6c1a8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 13 Apr 2021 07:55:00 +0000 (UTC)
Date:   Tue, 13 Apr 2021 09:54:58 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/3] config: allow overriding of global and system
 configuration
Message-ID: <YHVOUhThkCJiSqmj@ncase>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
 <d27efc0aa847f3fb179307b3a265b3759b7d9570.1618297711.git.ps@pks.im>
 <YHVJNOjJhysn7LBy@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+X0lcQO0H9N9LUvd"
Content-Disposition: inline
In-Reply-To: <YHVJNOjJhysn7LBy@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+X0lcQO0H9N9LUvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 03:33:08AM -0400, Jeff King wrote:
> On Tue, Apr 13, 2021 at 09:11:52AM +0200, Patrick Steinhardt wrote:
>=20
> > +test_expect_success 'override global and system config with missing fi=
le' '
> > +	sane_unset GIT_CONFIG_NOSYSTEM &&
> > +	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYST=
EM=3D/dev/null git config --global --list >actual &&
> > +	test_must_fail env GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=3D=
does-not-exist git config --system --list >actual &&
> > +	GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=3Ddoes-not-exist=
 git version
> > +'
>=20
> I was slightly surprised to see these still marked as test_must_fail.
> But it's because git-config, when given a _specific_ file to read, will
> complain if the file doesn't exist. And that is true independent of your
> patch.

Yeah, surprising at first but then again it does feel sensible when
thinking about it: we ask git-config(1) to explitly list the
global/system-level configuration, and when it does not exist it does
feel sane to complain.

> There is one interesting implication there. Running:
>=20
>   GIT_CONFIG_SYSTEM=3D/dev/null git config --system --list
>=20
> does _not_ complain, even though:
>=20
>   GIT_CONFIG_NOSYSTEM=3D1 git config --system --list
>=20
> does. IMHO that is quite sensible, but I wanted to point it out, as
> using /dev/null is not an exact replacement for GIT_CONFIG_NOSYSTEM (in
> my opinion it is even better ;) ).

Whereas this is the other edge case: we do ask it to explicitly list the
system-level configuration, and it _does_ exist even though it's empty.
I wouldn't expect to get an error here, and I do prefer this behaviour
to NOSYSTEM, too.

Patrick

--+X0lcQO0H9N9LUvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB1TlIACgkQVbJhu7ck
PpQOXg//QKBBv2r7g88CMAKWMrRx3Xz+P0NzIWVHMLP064j5dSoakLWGePzNA+Yn
Nsoj4j3TrAEXXqvhXSItVnKkXRHsvKV6p8U0M6xXSmr8pV/UU4y1oDbFvzsEc51f
6jeG5VybOOWFFJr1sM1TYdzg7U2tpFgT95HpDY7CcY23lDzT8dxqYf25+FYp8VsM
xwzti24ThbBIETDUMDsPwA8yNRIXLdAhODL1ARsvvKxLlZbcUA/9GiHVAB4HSN49
a8avuxXK66DrtQU0HPLpXKokE/AJp9SrbjNLsWNpHgCx6l2KPH3PsIby++1EJOUz
Ss4LSD8EdG7uTvRpyGEzqySKdKijhxur0vMnWTPZnZbl83Z2eCwTNCeqelVPxvGb
8iZ6vMFVneCLuTwF5Gcua0R6587YqzAy6sHx5+PEKOfHRIDhYjrR1wwunXoKX8/Y
nAVxCJ7/yHzgpRvxkDT0/XyPa0Jex9RC1n9l1e2eJV+s4J2BbrAMHxQceWivoLFT
x8QWZQyiALeVCNB1QbHUJnlU94Sp1tYvb35CjBfFreBJjUqWJVMT+N15wwgC0kKn
P0WWc4FFjxzMk9qKSYxLhCCU6ZkHFn7yNjtXUZeBLFQEEgWIGiUo9b7nALAaSzMw
P7Atm5uuVTIY7OJoEO9c/ZliySlm9XMQun43uOV9odnNey+8kfU=
=+FBO
-----END PGP SIGNATURE-----

--+X0lcQO0H9N9LUvd--
