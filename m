Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E71C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 06:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550112313C
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 06:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbhATGmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 01:42:43 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57967 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729912AbhATGaL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Jan 2021 01:30:11 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A3CF41738;
        Wed, 20 Jan 2021 01:29:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 20 Jan 2021 01:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=a5/3XDYj72nuIPtkjdTF2PX6y6D
        cqNN1zzWavhYNg1A=; b=KPstbpCcg8+KJUq+6fmvnRRXyRftVwFgYPvfqRQ4lH8
        U6A/LOAltYyz2ROgfnnert7A+eyq1tqzBF8Lc0hnK+Y2onVt+deNu0lGloF7YiA8
        BACMuBfGx1brpBAGt65lOEv1dQ3gyWMPVDl7bZJUarNiYgpm3CDioIPl9Vx3n34i
        nIqGlVtrgSzHR4QNFA5fXhDodntcuBN+lNJHjZPRoBW0HxmihPadYAeY6NIgR/de
        5XgHauOzM9EjyVPbGKNqWWw5AFz6MV2kxEpQJMTNA1KRZxrflcH2dD8QP4R4irzJ
        WPl9dCc9qBZy7vUipI94AhQrNiXtQx9enSKxVyJqwbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=a5/3XD
        Yj72nuIPtkjdTF2PX6y6DcqNN1zzWavhYNg1A=; b=rhkRJ/t7AD0kSSr+xoyfZd
        CDRKzFx9SdpYATP/00MhmTeWv9Dl36SM9O3ajNkT5n7weYmikMFX1XI+r4IqVSoL
        L60yDzzmUib7TmyWoGNy5/xur/jXZDmzuW8hbkCRd8ohr5h3tYSx903Z8R/zwUCl
        wIoB5K4/tYHV5b/7gO44LGiPs1SnJYPZRWITZgN6DO/4XGXOUhZuzDlU+vu4SUT6
        DaIcXyQCK6cPePIeDKe62glLAfmeODnfte+AcNIoP5w6ueU5oFLXoVYUIcxPBNI1
        NnUfAvLueCfalaSdervEf0z57cvETX3X/JjXjrm7ahfhQWaObEpfyrw5ktWzn31Q
        ==
X-ME-Sender: <xms:sM0HYOrm7eprfykGYive4Pp7JBcA5JCvZKudoArJAhxR2iK0t5pRiQ>
    <xme:sM0HYMqpb9hA7Y9i6rRYwQ1pSz4y6DBecSPAPEhv6FIq3lq0NpKzwM_haqEdf_G9Z
    9k-7nwYJzbUz-shRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddugdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeekledruddvrdefiedriedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:sM0HYDMfryO93m0szdzKhigWT5jywC-1ioyyV8ETIzyul03JTXecQw>
    <xmx:sM0HYN6Gf8ngWoVoe-4HACx4ft9-Oim5i8aervyuLYV81qTfzgTcTQ>
    <xmx:sM0HYN6kY3ODFR6aOdroav2RDuLfvtvofMeWPxkpq9gf2bcgw8T-Tg>
    <xmx:sc0HYA3YCPGRtpwLHWw5yOVIzASwMUTl8JAzX2oaCSucUeaBj22noA>
Received: from vm-mail.pks.im (dynamic-089-012-036-060.89.12.pool.telefonica.de [89.12.36.60])
        by mail.messagingengine.com (Postfix) with ESMTPA id D235F1080059;
        Wed, 20 Jan 2021 01:29:03 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c2de6e9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 20 Jan 2021 06:29:03 +0000 (UTC)
Date:   Wed, 20 Jan 2021 07:29:01 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v8 5/8] config: store "git -c" variables using more
 robust format
Message-ID: <YAfNrX1KNhHRbHmM@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
 <36c2a51b13e463a4aa8e5316447336927153d99d.1610453228.git.ps@pks.im>
 <YAHqHmGOUl53mfPa@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fCHQHV9wABN+0BlL"
Content-Disposition: inline
In-Reply-To: <YAHqHmGOUl53mfPa@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fCHQHV9wABN+0BlL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2021 at 02:16:46PM -0500, Jeff King wrote:
> On Tue, Jan 12, 2021 at 01:27:01PM +0100, Patrick Steinhardt wrote:
>=20
> > The previous commit added a new format for $GIT_CONFIG_PARAMETERS which
> > is able to robustly handle subsections with "=3D" in them. Let's start
>=20
> It looks like this commit and 6 got flipped from the original ordering
> (it's the "previous commit" talked about here). And indeed, running the
> tests on the individual commits in this series shows that we fail at
> this step (because we are writing the new format, but the reader is too
> strict to accept it).
>=20
> That doesn't matter to the end result, of course, but it hurts later
> bisecting. Just flipping patches 5 and 6 makes it all work.
>=20
> -Peff

Oops, yes. That always happens to me when I start using git-am(1). I see
that the patch series has been applied to "next" already, so does it
make any sense to resend with patches 5 and 6 flipped?

Patrick

--fCHQHV9wABN+0BlL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmAHza0ACgkQVbJhu7ck
PpQrvxAAlh/26k/6MtysNPiESVcvJc+J2CJIMKqkHBo24A5tOoUQ7Tq5mgdlkGlg
wQ3NCmfLBQeVPJl1I1SRRv53EyNYs9+O0Yc7/G1LeH3L1fsomYzIWMOi1OTqYYqd
ijWWNaKiebW1sjbNBRc3M6xxxeZVlmme2DKM8+ZCxDqejx+0pQkEptVUgY0+xu1H
PJVnLRrflqauRleK074dmpRLCsNlFeH3J5qarCYi/OqOmDc0yyU+7RLJDxxDmwQT
081oNIpmtbyNGgCkehg/ae8gwcbHT41CvnRHryrvHdqlWNXtrrVabC+kcd0i70yK
hUxzEimx6U2QZJNClEJS/EWcQoRD2BB2iZrDosZE6MULPj4oNtEZXg6/FOjkw7dK
J0xBLLsBXihgcCUpDGI3zIzgaG/nTGi9E03dw41yxHoojkJpAm46gcPyLuYTgu8O
tNLXjf0jPmo0J7sPuOacrLmebQJvo/Y+hwSQmpPcmBydn/te/flI1QbPXhNNAkes
5TnQT2FBEdcRcjFKbZwDdfDfP2/03Y+U6oZhihvhES8joZPMHneqIzBKb4lP4O98
bgvq0XrZcRBVJPYb5UNxQ51otz5bWpBavbRhs9YkjzKRVpbWlPAYx2s0EzF5DiD1
wnfOV/k+etwljrEs/ySWqfOVude4d8jBKHI/Ke8rBLkSKUdbCv4=
=fU40
-----END PGP SIGNATURE-----

--fCHQHV9wABN+0BlL--
