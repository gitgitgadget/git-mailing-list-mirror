Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01153C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3D864E90
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhBYH25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:28:57 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59847 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233733AbhBYH2z (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Feb 2021 02:28:55 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 95FCA9E2;
        Thu, 25 Feb 2021 02:28:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 25 Feb 2021 02:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=wxnNDtBzJ6J9NXfAgT4f/wGwHNy
        w4FybO9VeCqyp+og=; b=njsQKgQbYlsrxTgGfPZtUKp+3BrBztBZz9ucJWAa7zM
        Hh9zOM6rnM3q8PYYSzqOoZIDDslB3iwXQecQ4HnPDEsr4B1deMz3ecG+V7Ak9KQI
        pkF4peF6d+3VICdiixQVNVtZ59bha/j361OCIj7rEN6BUkNdlMU3JY2VO2Qzcr6W
        J/vaafU1ABWgytfkWW55ht6EeMrMWGGCjicgAMweQSIvXvrwL9XDF67B/6yqJS2T
        5YBj23rHcvAa09ZHo934wq+YGrX7DJjcs7Jkm7/jqQhA0ZkZb4DysHCvTfp3Tp6t
        6H6zR8mGeED+r4lwSc15uzKmB78BGu/MrQhToA1d7Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wxnNDt
        BzJ6J9NXfAgT4f/wGwHNyw4FybO9VeCqyp+og=; b=lM0UWaJDsFHd0lK5tfpbhR
        XuH32CPdpvBTxcPJV9q6OqXaUfoiWUXI3fUDCshdvovTyMcJqCQAKpCkkPs9kaxp
        zpnLsD8AIcvfJQjNSWeW2D49dvhGxt0iMO0KH+eBW3yIDYWx/QVSpLjVCPFL/pTk
        PXrelSbMy5eUbvRnaArcOq6KRyf1NIhVyhtypVEAWLJ0bOWBp5e6uERPrhwJU1Uk
        WfXXR1mB9ajCRKQ/ZwntAeaJogFZtVdU3uvURGnvwdRL7Hrhselko9X2DGtanV7L
        Xbg0/JdHqgIiQCoyglTEleztHJDeNaMIfiiN0sV0/dZj33sWCQ6q8k+8KhhpB4EA
        ==
X-ME-Sender: <xms:h1E3YFbyQrLQ-Hf8breN-PXu21VgJN2dqZrsA_GloiRh225e6YOmvA>
    <xme:h1E3YMaOeE8fadGSLoCuMtSaIj2aFOdo-kQ98aQwxdWy65vreHtIHW9fAf03iveOc
    Z4bcC0j7poYHt-RpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeekgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeefvdfhleehheelgeehtdevieeikeffudevvdduteefffejffejleelfeevhfen
    ucfkphepjeejrddukeefrddvfedrleenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:h1E3YH8Gg3C5XWHu2fb5JN092X1tswkepqZzsI8oI0nPWvp3_st8IA>
    <xmx:h1E3YDpKlwOLmQYhGdjOS6d5i8Y4m7sp-Eq0jbVvNL0UELUANmwdWw>
    <xmx:h1E3YAp71mluNuXGKe1G2sJYyKiPbQVFCLKk-E-hnJ1-i7bzJQgChQ>
    <xmx:iFE3YNCiU0l-nYgR0bLrnPsKVx-Dy0hfUh0i7c15z8yl2tcrI-rj7Q>
Received: from vm-mail.pks.im (x4db71709.dyn.telefonica.de [77.183.23.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1AAA91080066;
        Thu, 25 Feb 2021 02:28:07 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3d236d96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 25 Feb 2021 07:28:04 +0000 (UTC)
Date:   Thu, 25 Feb 2021 08:28:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yaron Wittenstein <yaron.wittenstein@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [QUESTION] Tracking HEAD changes?
Message-ID: <YDdRgwwuvZBGuSVP@ncase>
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
 <YDROhhrM5qJti1ir@coredump.intra.peff.net>
 <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
 <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
 <YDa/EupbrNa62r+D@coredump.intra.peff.net>
 <YDc3dinQ37FY8fhD@ncase>
 <CAGgn8PfdGBuB29Gxba6OmhSagjqwH2DNUv9XyJnXUhcKpJZBsA@mail.gmail.com>
 <YDdDUILUUXA1ytva@ncase>
 <xmqqim6gwrf8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y050GY97lurDdaGG"
Content-Disposition: inline
In-Reply-To: <xmqqim6gwrf8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--y050GY97lurDdaGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 24, 2021 at 11:13:47PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > So what you're observing is simply mirroring "reality": the order in
> > which git does its things here. There can be arbitrarily many
> > transactions in a given git command, and the only way this can be
> > changed is by changing how the command operating the transcations works.
>=20
> In other words, ref transaction is only about changes to the refs.
> There is no such "transaction" that treats a series of operations
> like object creation and index manipulation that may happen before a
> group of refs are updated as a single unit and make it atomic.

Exactly. Thanks for putting it into better words than I did.

Patrick

--y050GY97lurDdaGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA3UYIACgkQVbJhu7ck
PpSygw/8DfODYawqP2tTliaS3kCp3vTz2buM5QDa2ewC1Nzh2x0V2zZjIWmVCjK7
NRQIewHObjpLxKkZ+9Ra+3iprhrDridcZA8IpvX4BCAkUprK9tO8NYE7FuzT5xzm
E+7FNj+R4P1yIU4NMLpBJQYrje30ad2yGitr1KPN5dZuMb2D3f/io86rBRXA98Fi
H658LRxou6DzIdtB51cWnR9KEgJpZ3FTm/7jk8O2SDGTWISk+N+jHIsfqdYqmUPd
vDtQ/5tSIDWEtoDiWOTR1weQbtNGd0KtR97iJzdPf8HxXBu3GYqRy9jh8HF3sb68
YelkXDLORdtgAJsbKfnjO7yXbx1YsycHMVOFqAE6/c5dGRQoWgZ+Fp63HUhtClWA
T91JIWa+MzuG3RY2T1FK/TtI204EvGUsNrtMnPMRfLpe+/73sgHj64EAeMsIZ43f
i7+7IbKO1yDxfIhIpOsvnxa904OXCwK/grXDkw+Y/M5HAdM/gT+UbAE19J/mgRlZ
EiO/HVcb2uluRNGpt3CTUskolw7gcYozNkAFDAWo5RrLhLThe9T1ydmO+W5ny+v3
NL/jSQTtY9kDCYEts/NIisZdkNDdHSxLG0e2kLwSxUf6YP4d1/lHfNZQtCmIqscQ
J9JBDo0dCmrg7g9El74bkxAhaT35xp9WYOsxfCIblp+zh12t1uQ=
=ZRkP
-----END PGP SIGNATURE-----

--y050GY97lurDdaGG--
