Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDAAC4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 15:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532C522CB3
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 15:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405019AbgLKOzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 09:55:37 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39893 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394582AbgLKOzO (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Dec 2020 09:55:14 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EE5385F2;
        Fri, 11 Dec 2020 09:54:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 11 Dec 2020 09:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=BL8Ar71zCI+xyBdQjTYtspTy3Kk
        MQV+ak40zXlAHDI0=; b=LDVe2plXLmuzZxrC93DLsq62qBhKKtTmQ+81zTbfiZ8
        tr5QLKvrAd2frN0KMkKBN/oggpG+naXQFbq92mARXLuU7ZFyAvS21e9knpyp1Rlt
        4BK0dvWDYoRfZ5DCF6F8IFyrrJicum8LRgKheUp7UzUFGrUZuj8kLMs9QUVxhjac
        6azDvec4dN3pxz3ZRyUWvkCmAdtMPIbD9i5dOjCYKeT/Tz67YYudmEKbAYDArscz
        lBK+qsg2j0DCKykvS6ahkW6c7gP5h0g9kmLQIQ55Nc1ybDrWSCigXnTx71c2Oy/G
        RtsZfLFauafMXbAETA9xOyW0Cq3IqxJvgI4o48JwTSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=BL8Ar7
        1zCI+xyBdQjTYtspTy3KkMQV+ak40zXlAHDI0=; b=CkyDrOmDT//GtPMQ+OYbFT
        o/rp9r9TiRZNnSoENFFCIQTKW/qcSiflSjMcx/2axGB31/yP3wFbS68K8fNWC181
        7rzXs8NcxwjmBYXPRVpGym7UrL9UIsk8atoo0Pi2PCGsj/QQyLPWB97ZkJVXE2wS
        mPA/ZiL5L/3OQzwLrrZVVsQCOvDGMWNAJd4etgbF0FBXbjB3z7l+JybvcpONG4NV
        rCppYTL7jVod+h9RduuutoVdbUPsIPuFBUnIb2LbAhGsFiZW6R3VQlRIDlS0b8Iz
        WFPuh+6MTt3a4iaKFiqJyBNdgjiorvFNIEKV/bmb5xzxLmXWr7ruUBFgL9K/gV6g
        ==
X-ME-Sender: <xms:D4jTXxJCSE8YwJf8xo_tCa3RkFsM7QU9Ct_oVjgtTXUb9vVQHVrM2Q>
    <xme:D4jTX0lFiuPw7NbLtlTmNnqS4vyOh7EMVS4TiJTsevLojzV16NOEOio77HP9z6f_S
    mL11Qj15csGq6wNQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddukeefrdehvddruddvieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:D4jTX3Ee6X1gF33KQiJX8Uw-tNq1xouOveHIdbEHbq9y-GQtXqUbpg>
    <xmx:D4jTX8H_kQQK6HfqlB_g5n9B-qnFAosB1Hidgqu528V0kNyAT9pYqg>
    <xmx:D4jTX8PGPqwJWpRYg_uVG95PG4oDaNvPIKnqxy8iA3nGDwjMJTavNg>
    <xmx:D4jTXzdmZJdDigB4IkTqqCIem1RZ5NC4gWHb2By9ZhP6SweZLcOc5Q>
Received: from vm-mail (x4db7347e.dyn.telefonica.de [77.183.52.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 497981080067;
        Fri, 11 Dec 2020 09:54:06 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id aecabf35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Dec 2020 14:54:05 +0000 (UTC)
Date:   Fri, 11 Dec 2020 15:54:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/6] config: add new way to pass config via
 `--config-env`
Message-ID: <X9OICyWMn0sSRb/3@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
 <871rfzxctq.fsf@evledraar.gmail.com>
 <X9D6IyPchkGkYgeB@coredump.intra.peff.net>
 <X9NzEfzjvdnvnX42@ncase>
 <X9OAcgPxyYIJo+J/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fpr8edCh5zGVGYKF"
Content-Disposition: inline
In-Reply-To: <X9OAcgPxyYIJo+J/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fpr8edCh5zGVGYKF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2020 at 09:21:38AM -0500, Jeff King wrote:
> On Fri, Dec 11, 2020 at 02:24:33PM +0100, Patrick Steinhardt wrote:
>=20
> > Do you want me to adopt your patches as part of this series?
>=20
> Yeah, if you're willing to. I don't mind spinning it off into its own
> series if you don't want to (the tricky part is that we're touching a
> couple of the same spots, though, so if you're willing to pick them up,
> I think that makes coordination easier).
>=20
> -Peff

I can do so. The only question that I have is whether I should rebase it
on top of 6/6 or on top of 2/6. It's hard for me to gauge whether 6/6 is
going to make it in or not due to the conflicting opinions on it. It
currently seems to me like we tend towards a "no", which is also what
the "What's cooking" report said. But there were also some opinions in
favor of it, which made me wonder. If this is a definitive "no", then
I'm happy to stop bothering with them to make the patch series easier to
manage.

Patrick

--fpr8edCh5zGVGYKF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/TiAsACgkQVbJhu7ck
PpQD7Q//Vbr8ZhgX1Bf4AMDawDPCBzeFX1zQ6RoQGrEzlZzPQHL92b2qz2hGSRV7
yYMXoZiVkBaobDstUDkwzzztc5MoX1p7psjZ9VYPRVGlvrp/oUz+TXRtwxksS4R9
Wqsz+T4xPG5jUekiB+EMRKs/XhjGKLEx83txX8xgqmHTjBEBQSvRn8B+eoRaK0Wc
IONPhRpFHkeSA9cEgOW+fqKq7mPc8S+h+uZLZgOawyTc2VcvQhMbFsUokOmpxx90
nCeqfkYJBFL9B9ER9OYSpuRZDuPCXTMoX59kSTo/tfAykDw3lT2ySIG97zxKmI2s
lwtsmyKG5euXe54G7zb2irFTqKuZIdEAz6JaETEHfVy5GUt5p5JOc24jpXGEuqcr
7FwHnrYbgEfN1AVUTMpLThWlS2WrgIMsmxTxL8GtfhQHwwyXDKuKLa14qPp+nnKE
kVORfN5HBpz3O8YGJRbMmcUsZVwHfF7tZP7Q6J+SBXB25vhcvke3623ChJIJNV3t
/CHYEjYwqTQlwm47XHbcvczGMQ83NqCrr1ghgugYVD0Gcz6CnGJ5IhGRJR8VNNmo
LYtJH8tJ7M2yK15Vdu5R+Rs/vQvj7m0GCtBj9gudFmPJCY99E03eH+rtrN2MuXMD
y5Iq5YjCnAbjWWkfd43efx8GsDt71RhbxGRFryTLIoUolqzPl1k=
=xxTW
-----END PGP SIGNATURE-----

--fpr8edCh5zGVGYKF--
