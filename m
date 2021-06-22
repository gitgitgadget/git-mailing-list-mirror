Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22DEC49EA2
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 10:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A86610C7
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 10:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFVKuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 06:50:21 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59311 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229995AbhFVKuU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 22 Jun 2021 06:50:20 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 28A975C012C;
        Tue, 22 Jun 2021 06:48:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 22 Jun 2021 06:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=OSrCdh/67RFh0luUFt712H12hQS
        5Jl7BXeLMgGkVZdc=; b=NILa571PqK+dZ0XuVGOpDhwoZicMIkkcg6hEew+I0sE
        IbEiNMQcy0XLYgugr/oMNPJ/WNQTpgHhajsNx99dE8GyRzlNtpSagoWzjG+z3L14
        ctjlxkIOskcLIF0GGspP9IOlDlkmsnbsJ+fs3673Gi+QkzBBQZukbIH+/oyPKvbZ
        3vKVV/YKeOQ3pAzFSw1dV8glmcVkqPsHGi32Zn5UPa+TyhvDRwTlugRejR/2KZ8L
        Bv+nrofVuck837QgF6PZLnb8twZu0jN/cuUjQsGMGRfBjwN9kqKRjgrFjpcPyHzp
        h9602+8382SsIWkm3k/0mIs1sa9FpCpb9uBYlYf3tmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OSrCdh
        /67RFh0luUFt712H12hQS5Jl7BXeLMgGkVZdc=; b=OySgzw2FB+4ZlpM3REn8g4
        MjEZTTzDPpg4aTvusqFrItiVrWSZzqsCOxYqo3UcEw9p4ehOJt0GJB1oAiZKqAoo
        Fc0B1vndsUTW59j1ioO0yHDmaL+BylJlCdN4j00RAJOVECUQDlYiRi3Th+Q5RrFQ
        IvGB6R8LUgmEO8xgm/bEdHU8Rr9jln9q+LPPCNuTaee+ZQXXxGpBhq/9zWoNSwL+
        RYSZXYAlPWKLPNW5eIacUrTZvjHyriwj7oNcYBnlMxyabAfrqlNtyS8WFa+Y9JXM
        gwJHk92R4qnLhlRq5p4JRbL2Bnyv/c3YBcZQe1COXqPp3sKmd7x03PS488353nbg
        ==
X-ME-Sender: <xms:47_RYFRXTmZa8g_AAuDiedMXLXenDpZni1Q49_Ux0WC-3gwSI4Y8Tw>
    <xme:47_RYOzCNpMbdgB9Su6hs8Jx7Th1-Ej6yBBPoCSNNogCqBEr_nbnXCyeYSkieMRa_
    j8C8AuzP4ydKUEL6w>
X-ME-Received: <xmr:47_RYK1eYTLJQPRZ3qr658z1SOpmRLCzuMFrQaNRliHpy_KnM6JzcVeOoFT6EA-YlWqyXogX4SUHlxomoyGPss92F5DMeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeguddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:47_RYNAp5IAIM2kDSTDnwmdNnHM1P5kkFW9nyD7HjaUfBy1r6TGv0g>
    <xmx:47_RYOhxugZZ-3P9GF54q4tKCH6YZUWPw15_FqVcWsXIpBMw2oq6fQ>
    <xmx:47_RYBqMfxItSIQsY73PWTxrnEjBbyaaUsG1LdhV69sdhFk0ahy-uA>
    <xmx:5L_RYCafyKlldt1NBExoVk3YPxGKiQpSDJ3HB-qfMHUG3t9Y30uhPw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jun 2021 06:48:03 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9dc496aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 22 Jun 2021 10:47:58 +0000 (UTC)
Date:   Tue, 22 Jun 2021 12:47:57 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bitmaps: don't recurse into trees already in the bitmap
Message-ID: <YNG/05+fmA0YPKj7@ncase>
References: <YMcExxF7DI6k+sZ+@coredump.intra.peff.net>
 <YMdGGL6v8LrbcAJP@coredump.intra.peff.net>
 <471cb9be-bb72-6a37-ede8-f9421d9d3ebe@gmail.com>
 <YMnvCI/jksyn2flD@tanuki>
 <YMyYz6Tavj5l6S8n@coredump.intra.peff.net>
 <YMyhCTaHmm6oNFpB@xps>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qfxAaLTyxNQ1pRWz"
Content-Disposition: inline
In-Reply-To: <YMyhCTaHmm6oNFpB@xps>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qfxAaLTyxNQ1pRWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 18, 2021 at 03:35:05PM +0200, Patrick Steinhardt wrote:
> On Fri, Jun 18, 2021 at 08:59:59AM -0400, Jeff King wrote:
> > On Wed, Jun 16, 2021 at 02:31:04PM +0200, Patrick Steinhardt wrote:
> >=20
> > > > These many-refs scenarios make sense as something that is difficult=
 to
> > > > verify using a single fork of an open-source project, but is common=
 in
> > > > many closed-source projects that do not use forking to reduce the r=
ef
> > > > count per repo.
> > >=20
> > > Agreed. What I typically do to emulate this is to use some version of
> > > following command to create refs for "$n" commits.
> > >=20
> > >     git log --all --format=3D"tformat:create refs/commit/%h %H" |
> > >         shuf | head -n "$n" | git update-ref --stdin
> > >=20
> > > It's obviously not ideal given that resulting refs are distributed at
> > > random. But combined with a sufficiently large repo, it's still helped
> > > me at times to reproduce adverse performance at times.
> >=20
> > Yeah, I've done something similar. But I'd caution people into reading
> > too much into performance tests from something like that. What I've
> > found over the years is that traversal and bitmap performance can be
> > somewhat sensitive to tree shape and bitmap placement (which in turn is
> > often influenced by ref placement, if you are using delta islands or the
> > recently added pack.preferBitmapTips).
> >=20
> > More than once I've spent many head-scratching hours trying to determine
> > why some real-world repo performs better or worse than expected. :)
>=20
> I couldn't agree more. I've also had my fair share of weird performance
> characteristics in completely unexpected ways. Unfortunately, it has
> made me become quite cautious about bitmaps given that they've already
> caused their fair share of perfomance regressions.
>=20
> But your work here actually encourages me to give it another try soonish
> and see what kind of repo shapes make them explode this time.
>=20
> Patrick

Today I've been experimenting with the connectivity check of
git-receive-pack(1) once again to see whether I'm able to get a
performance improvement if the git-rev-list(1) command spawned as part
of the connectivity check uses `--use-bitmap-index`.

Turns out the answer is "no": it has exactly the same performance
characteristics when pushing into a bitmapped repository (linux.git)
compared to the version not using a bitmap index, except for once case
where it performs 70x worse: force-pushing "master~10:master" into a
bitmapped repo takes 11s instead of 0.15s with bitmaps enabled.

Just leaving this here as a note for anybody (or myself) to pick up at a
later point.

Patrick

--qfxAaLTyxNQ1pRWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDRv9wACgkQVbJhu7ck
PpQAXRAAoyMWslu8J//KsBAyaSDTVvcnsEx0O+v4UBH/ui5XkKmXbGfxoK2b5uCN
C5GHupjxo6cDm9H0MKCmzBANpAy3Z01zAcqWnL4cXwk/HfCezvZP1uq3P8Vd4Uea
rC6vibgSRQ2IruSsMqY3c5+Vc3CqcH5q6Osj1yFikt4u68dnr8UkWts6/ZoUZVtP
VouOGvcsX6uEKhlfaZaUO6DHtv+YJjimG2/r/SBHF5CBO9BqjeLz5VyVKjsAhW9Z
zbgsWBT+2lASSSpdI4Ym5/eSeRUAmoFLJaU3pVCPs7dnnV9aTZx1MJBn1zbJaN/O
uZlqLSy4UMwpPThT8OEFKVxr6UiOPA2EsmOlhDcicFjk5+V0sXMJaZpoUElvFff+
HG5F5vFu2qTriwX6wpMq5Htaguhijh9XJMIePMqcDzJdSmsIkEG7udEALNC/TSlM
qHt1amgpnyflUGxctMgD7vGBz6GiISdVOxupQquqGBVneLtkFJFv9gZU3Jg0qDw3
UDFErhW7gU6uLYFEa1bYfGjXpSXGOvLEBSZ5uzi3Vkof4v9MMUoA5M8zR6DpuLvO
3DQSu7wytxJBLoigkgoS82aXt7jZuAOWWdtphFYFuVhucec9f9VuiR/UDGO2dCVg
CJfcm2cIS/la1l2lURYZzKVk/YrVyTdeGeGc6jicOnwsEY8qT7Y=
=cpNu
-----END PGP SIGNATURE-----

--qfxAaLTyxNQ1pRWz--
