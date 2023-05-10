Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C30C7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 07:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbjEJHZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 03:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjEJHZb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 03:25:31 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DA92101
        for <git@vger.kernel.org>; Wed, 10 May 2023 00:25:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B57F75C02BC;
        Wed, 10 May 2023 03:25:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 10 May 2023 03:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683703527; x=1683789927; bh=tn
        9Ha7gqdgv3DT58JxirB1TZUDia332nS3qnVQEDAow=; b=ntyRfOy8kzcqusRGIN
        5GJGp0vLpdtTJzjHLu/3SWebjpNWWCnITaLXn7JYhEdzESlkrVC1Jm1/PN2ApBKq
        3c/OGfdooBnUtulJVdsEGzDb/WkmqgXKQ+x5fgg8Vea8o8ViPO8A4PtKZiEAptZ4
        1kw9WO+OgDYkqIq7avJFhQGUQ7/xurWmN/GY2v2xz4Ih9OVqm/vs0+GpgwkdT2Wl
        vbFnq7R2vn5DikT69BMd4buMSvj0SNnC8vb3ePwuZV1pe72Z1fZz6a5HM+sNOJqI
        rkX4s0q44W5YJVCxplF37q8PKlaSB4JCE2az6fAe9IpArXR+4KPFso2IQ0ont53c
        PFdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683703527; x=1683789927; bh=tn9Ha7gqdgv3D
        T58JxirB1TZUDia332nS3qnVQEDAow=; b=RuZFzjqdF7O8FyVZcGt0/ymMmb6Ms
        /A0wPEdjYXv0bK3d/XuwsqnSgATZ5wDhCfqha7JeQFapBHsdDMob9WaGzkLOuWRb
        RtjPa0kvndSeSdeCRmuxN3Azg4d9IrlrhopjdRKiEOsDXm0sgoQ54lWKSyx3ByQE
        TdvemEkUzs3b8Jdok8u7Wk7/JnSLzq7zPgvFF76sZGENuK6lJHObdPYMYD9+Zb4a
        SWFJY4bJagiOPvEkAXjtlMmA5Bu4TJjPAvhKcFInHDmWuarSsUpMeaO7+hAg6MPm
        el3vvGiRxbJ9h/0yoYGvD7YDk3mZPZ43cQHOm+kUKOfoboYek7rMLSK8g==
X-ME-Sender: <xms:50ZbZJ3O3norIYEOrxADnOytopbo9G6QDxOiN4JcTenvwokLFkT_ZA>
    <xme:50ZbZAEjMWXPrR4xmEBYTugUjceYdQWCVWki-BdT1rlSkYqgfN4737DNWdfwbKtIr
    9ST3sv75ue_LYtmJQ>
X-ME-Received: <xmr:50ZbZJ4lq1VK5vte_38dq_vBl7u1qmJjFjmrTSQRHEklVBKLy74xn3f29ECAUuykVoxB49IaxwnE8BNfpVLXVCzZuua5uKk4mUf-E2zUAV0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegfedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:50ZbZG1kNjTKj-XJe2j49mm624gY3TpvHi3XHBQUPy_raVs64XGuYw>
    <xmx:50ZbZMF0InAenYLxZhQsUrix7h10tPLXySRwWWO2rnXtcCnNeAdclg>
    <xmx:50ZbZH-4YzRQD3Wwh99jmFCN37acVVX6Cj3IPCRj0hPxhVO4KEJpxw>
    <xmx:50ZbZAAPdSFQsgFt2YenOK-wIl9fI4pVrKed2EkXyUKgRfy4PeGDbA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 03:25:26 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 47309cba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 07:25:14 +0000 (UTC)
Date:   Wed, 10 May 2023 09:25:21 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/15] refs/packed-backend.c: implement skip lists to
 avoid excluded pattern(s)
Message-ID: <ZFtG4S4XBboztTap@ncase>
References: <cover.1683581621.git.me@ttaylorr.com>
 <a39d1107c1f3e9fbd859a23aed72e63bbd394fa2.1683581621.git.me@ttaylorr.com>
 <ZFpjn-vjP6H_v_KD@ncase>
 <ZFqzW2vqcFJqqPXH@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A3inXVD8frr+vUMV"
Content-Disposition: inline
In-Reply-To: <ZFqzW2vqcFJqqPXH@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--A3inXVD8frr+vUMV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 04:55:55PM -0400, Taylor Blau wrote:
> On Tue, May 09, 2023 at 05:15:43PM +0200, Patrick Steinhardt wrote:
> > On Mon, May 08, 2023 at 06:00:08PM -0400, Taylor Blau wrote:
> >
> > > Note that this optimization is only possible when none of the excluded
> > > pattern(s) have special meta-characters in them. To see why this is t=
he
> > > case, consider the exclusion pattern "refs/foo[a]". In general, in or=
der
> > > to find the location of the first record that matches this pattern, we
> > > could only consider up to the first meta-character, "refs/foo". But t=
his
> > > doesn't work, since the excluded region we'd come up with would inclu=
de
> > > "refs/foobar", even though it is not excluded.
> >
> > Is this generally true though? A naive implementation would iterate
> > through all references and find the first reference that matches the
> > exclusion regular exepression. From thereon we continue to iterate until
> > we find the first entry that doesn't match. This may cause us to end up
> > with a suboptimal skip list, but the skip list would still be valid.
> >
> > As I said, this implementation would be naive as we're now forced to
> > iterate through all references starting at the beginning. I assume that
> > your implementation will instead use a binary search to locate the first
> > entry that matches the exclusion pattern and the last pattern. But the
> > way this paragraph is formulated makes it sound like this is a general
> > fact, even though it is a fact that derives from the implementation.
> >
> > I of course don't propose to change the algorithm here, but instead to
> > clarify where this restriction actually comes from and why the tradeoff
> > makes sense.
>=20
> In the example you include, it's possible. But consider something like:
>=20
>     $ git for-each-ref --exclude=3D'refs/foo[ac]'
>=20
> The region that matches that expression ("refs/fooa", "refs/fooc" and
> everything underneath them) does not have to appear as a continuous
> single region in the packed-refs file. If you have, say, "refs/foobar",
> that will appear between the two regions you want to exclude.
>=20
> So I think you *might* be able to do it in general, but at the very
> least it would involve splitting each character class and finding the
> start and end of any region(s) that it matches.
>=20
> Even so, you'd have to try and match each entry as you determine the
> width of the excluded region, at which point you're at par with
> enumerating them anyway and having the caller discard any entries it
> doesn't want.

Alternatively you could also do this on a best-effort basis and only
find the first matching region. But anyway, as said: I'm fine with the
limitations but think that we should document better where they come
=66rom. The current commit message sounds like the limitation is of
general nature even though it is in fact a conciously-chosen tradeoff
that allows us to make the implementation more efficient for most cases.

Patrick

--A3inXVD8frr+vUMV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbRuEACgkQVbJhu7ck
PpTglw//V9z4tm/Yv9MnUC7DRAbwXN7DXq4BikDB7bbXBYPWhQ1kzJP+i7UF/Xce
2Zc4ChL26h6Xz3Tm4jIN1BkWOpBzZRIrZb0fB/yOdmL+AftNcFW0HVQ7y7qvwhkZ
YddtydRNfNxuCymfisdefDt92zEYBcQNjQlF/02tl3M+v0eTnWafQDrKomIEq3/T
Eu3aEpAnBRmtX3w1qab5VzSj63gPQdX5l732qzIylkypYS2ootHVZmdfK/x/bvWx
OW44AWvz/nbDYCEkzVGlSTS5Iz89tmFC8huE/JQmqP/9N0rPQlkZJgUiuVvkvEvM
R7mBmlBN6LX3jTtTGqz5qCIyp6RCYj+/GFuIwIseD6QXp0E2frxPt+rqfgD5MYiw
JbS40tc5rI5f6ej5VAqj3NPU3TUCTxf4/T3iLANnlg65T3fgjOVCF40zXrtOri8R
ndNJL8nOO6X4SHSQzpuA6mDohNVNGVQQZ0w9WsWsgy+F/7Ft+8jkSJVK8gLi8GAY
DY/GtXVK957mMlJsEhxMJFYLUmao6nRmm2SUKo0aD9/wCBfO2RImAfj9U3tb8b4O
COivSHt3sG+Fz2ZvMcD+B4uWVzmvbE0KR06+ryP9/tCcl1oSo/x+vZSUyryTW5eu
UEbHmdsAduWdSvXzmab8fDl+qVpguc2cwEFEYO5e2oLEZl4tBvQ=
=Suzw
-----END PGP SIGNATURE-----

--A3inXVD8frr+vUMV--
