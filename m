Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83F5C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 12:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 922FB613B9
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 12:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhFPMbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 08:31:21 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33337 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233034AbhFPMbL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Jun 2021 08:31:11 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 209215C0175;
        Wed, 16 Jun 2021 08:29:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 16 Jun 2021 08:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=oMAyxeQTZ6AXr3FaAZCcUj3K4Bq
        dqegYfAN1X14SK98=; b=AqCXmc0ldvvRkb0HB3lHCtFJg82EgHlZKZOXIbRAxxC
        tcD8igvEgAIK25+o1rRaM+lErSgCUonMM7McHohFXtwpL+PyRUXo0i3wqEBTSGns
        j9J7EX6hXTYwMSL7cna3Sq+xer5d6oQuBwZuyRFYTjRgyDrhTGlkE83YV9iZvLQO
        q1DemFUoW4WbtFtmgu0+eSXkTDujbVXVgtwD31XyidGGAwSRhkLSLvLjwlDBFqsr
        okdHWZxLQtQgw9/LPRR1n3o3G4FE8H9o3FBR6ISq3G8CO+Xfc/SP7W0lwfMLRUUb
        6YR0GyJ9j1Zuz1bH9fBFiXrJPiuFNOKL/swuRasBGfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=oMAyxe
        QTZ6AXr3FaAZCcUj3K4BqdqegYfAN1X14SK98=; b=biyKMaxdZUJt5039ArigEp
        DPbsZxcJhGQ/s9Zo+asYbkz0dayOkVot5Fd85ysZ1+WHROAkQ6ICELkaXBxT0RWc
        r+F8sxprD0cWJyAMF/pwFWMm8cqWMHaGe4aLA4IXyQ8oTSAI3lNKaLlc67u3ugSc
        xUaGWQduUf4fYmE6CwmDHTyC5ghwNGnGlzqg5t+KQVCGdZLvI926YXdqD0+VBve1
        4gI2dTQpvE792t8YFcUbODbzfC8t4OeiwTUYjmFbaPZ7oMFnfg3piy+Im80+E46Y
        o1MZ3wrXgcg1isNsqnwoT3sz0Xo49CGCgDS6a/zhJ1d0k8BoV1oc3gftfWPz6FUQ
        ==
X-ME-Sender: <xms:kO7JYNp4EIw_tpCWtxzl2zHyrVOtzo97YvMh621mYrt--4N6JTUhow>
    <xme:kO7JYPpshSza9eB-cvdV5Sr-s_JkUV3EnQ0rHwGTz1uQYci-4wG4zSNHDfLJLlU7I
    54JDVFgfIOieEGKIg>
X-ME-Received: <xmr:kO7JYKNakA7rdtJysmfjPLHYA03UV2U93_g1Bh4M8s3uauY18y65gek5beuZNPvKxRaX2hbrX0I993dqxbtu5PLu6vlCt2yc4YRgear3TUa6de5nQl4Se-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:kO7JYI51DBL6ZbjvQOjFI2e4u31vLP8CBpjWwHI8rxpPYxRj1CCxhQ>
    <xmx:kO7JYM5lF6BbArbJIHg4IOhel_GxbFJ9Ib4v6Bkq4z3vHj1uRJiAQQ>
    <xmx:kO7JYAgJPC4XDm4yLooP_aM_lB51P4neoTsl-QFYfzXp5MwoKjW1TQ>
    <xmx:ke7JYKRke1t42QI9f7ICwAI310ellc9SEmQuNp7_9CMpS5z-2xlsRg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jun 2021 08:29:04 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8ad90abf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Jun 2021 12:29:01 +0000 (UTC)
Date:   Wed, 16 Jun 2021 14:31:04 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] bitmaps: don't recurse into trees already in the bitmap
Message-ID: <YMnvCI/jksyn2flD@tanuki>
References: <YMcExxF7DI6k+sZ+@coredump.intra.peff.net>
 <YMdGGL6v8LrbcAJP@coredump.intra.peff.net>
 <471cb9be-bb72-6a37-ede8-f9421d9d3ebe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0TUjrvidw1nNDBju"
Content-Disposition: inline
In-Reply-To: <471cb9be-bb72-6a37-ede8-f9421d9d3ebe@gmail.com>
X-TUID: TVmLBTzwuNlZ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0TUjrvidw1nNDBju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 15, 2021 at 10:17:04AM -0400, Derrick Stolee wrote:
> On 6/14/2021 8:05 AM, Jeff King wrote:
[snip]
> > But here are numbers from some other real-world repositories (that are
> > not public). This one's tree is comparable in size to linux.git, but has
> > ~16k refs (and so less complete bitmap coverage):
> >=20
> >   Test                         HEAD^               HEAD
> >   ---------------------------------------------------------------------=
----
> >   5310.4: simulated clone      38.34(39.86+0.74)   33.95(35.53+0.76) -1=
1.5%
> >   5310.5: simulated fetch      2.29(6.31+0.35)     2.20(5.97+0.41) -3.9%
> >   5310.7: rev-list (commits)   0.99(0.86+0.13)     0.96(0.85+0.11) -3.0%
> >   5310.8: rev-list (objects)   11.32(11.04+0.27)   6.59(6.37+0.21) -41.=
8%
> >=20
> > And here's another with a very large tree (~340k entries), and a fairly
> > large number of refs (~10k):
> >=20
> >   Test                         HEAD^               HEAD
> >   ---------------------------------------------------------------------=
----
> >   5310.3: simulated clone      53.83(54.71+1.54)   39.77(40.76+1.50) -2=
6.1%
> >   5310.4: simulated fetch      19.91(20.11+0.56)   19.79(19.98+0.67) -0=
=2E6%
> >   5310.6: rev-list (commits)   0.54(0.44+0.11)     0.51(0.43+0.07) -5.6%
> >   5310.7: rev-list (objects)   24.32(23.59+0.73)   9.85(9.49+0.36) -59.=
5%
> >=20
> > This patch provides substantial improvements in these larger cases, and
> > have any drawbacks for smaller ones (the cost of the bitmap check is
> > quite small compared to an actual tree traversal).
>=20
> These many-refs scenarios make sense as something that is difficult to
> verify using a single fork of an open-source project, but is common in
> many closed-source projects that do not use forking to reduce the ref
> count per repo.

Agreed. What I typically do to emulate this is to use some version of
following command to create refs for "$n" commits.

    git log --all --format=3D"tformat:create refs/commit/%h %H" |
        shuf | head -n "$n" | git update-ref --stdin

It's obviously not ideal given that resulting refs are distributed at
random. But combined with a sufficiently large repo, it's still helped
me at times to reproduce adverse performance at times.

Anyway, the patch does look good to me and sounds like it may help with
some of the cases where I have observed adverse performance with bitmaps
enabled in the past. Thanks!

Patrick

--0TUjrvidw1nNDBju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDJ7wcACgkQVbJhu7ck
PpRtnRAAqrLchAcdZpUBeD5V0WKoMbekZPVdte0IjOfnKKmL02kz9Hzk0LOlx/+0
gafG1lOm4/2gAQjg9HeyTF6wG8ipYFNDnFRoprWksigFN9ey1kV5dmCUUdNUm7d2
zcwdYpZeONrAgQxkDAaAH8v3RewK//j2yBsdb0MjF89clU4JxZ0wjKBmjNCImVu2
IHHMVxx0ELcWj0zy6LiaiyRwgKtegCUmE0lvSV/PiKjZzQ7jQOHDvcgUZRJHdWff
AvrNpiynBjppH+vzJGJxs6MI2j2AWZdnUTUzdvhuzrQ3B0sEE6FIOYlEPALEQH2m
rh1TiPcE4NhecffWVfkZog7RkVTCQGLKUBUdabzsF18Z3xIbH/JADivvjJrcaIQ8
st39BH/FuEOaBrLHIHv2yK6H/CRz0bwSZLeyAKg0hj4JK7ZX+ZJJ4fkzMbdy/Geh
+SIJDgn5e682cYTuiXcvlaPHmJVQqnBQ7Ry0V3h24BxeWbW5LbVTsNPtUwxGjnlw
wgZI1alUQJSTyc0dW9UeB8I9YAdcx7+uwWk2BdmThGk12hcqUf/kO2Lk1DCM98sX
E39EgQr9FmxG0uSW2xDgTcHK8MsSYCgqPKS+WRxzl27GzcHfabFToxrVuxvqayji
c4jN8KWIH2iKaZG2VhyDEp4EeVgATykYw5YrFYyvU+8/OQ/xTD4=
=N4If
-----END PGP SIGNATURE-----

--0TUjrvidw1nNDBju--
