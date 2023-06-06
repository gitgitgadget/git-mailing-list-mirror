Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD90FC77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 07:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbjFFHBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 03:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjFFHBP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 03:01:15 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE47AE51
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 00:01:14 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1D3343200488;
        Tue,  6 Jun 2023 03:01:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 06 Jun 2023 03:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686034873; x=1686121273; bh=G4
        fzQ1h61yMcnuGxtg+idH6tAR/of9HWuDvSUPXOAx8=; b=PLNTgL2puMnV4zQlvg
        vL1gzVOz9/MeG8Vw6lz4/m1CS1kLZcEB2EqawB4HMz4Jd5B20foRiuZARm+AX6FF
        XMgIWDcbJyCA87f/swc4RYpSwOWUnpNdsaqDVbsit51kgnwPgR/zksLLpts0ewSv
        C2V1ekL8a94tjRN63Pya9ccdN0RfgLMLq2ADAZBvZI0KEiMAGoyaPMrx2xTcgtpF
        4Ar3Y2XCopWjxyPOLGaDf1J7/yh2edCE1R8Q5ATqyVuA3jw7HLj8MgmMHHX6xKhm
        RXQWFqp52ApYBXAeARwXktr3D1jPncGpOGXuPO88gNhTiDKIh2K0i5nUP/0rx2SX
        Trtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686034873; x=1686121273; bh=G4fzQ1h61yMcn
        uGxtg+idH6tAR/of9HWuDvSUPXOAx8=; b=nMR5dRkgddb1mnjYD4tO1f3jUifTn
        bJv6l+YXQvywNFzKXm1dM10wk/aEUkAp4CJtbPri4jTtjtuMFX9z3QAPreK0sZr+
        k5AJsVKoAnSDYQym0nY+YDXHZYIW6wrHBgsOIZ9tWcAvgz6bBnuHcnR2IqIBMDit
        57p3ftcW9Gq46pqn+Nu6mkFf0JE9HD7/L/BtGHm+2pLfkVpE6TZmWnFeuft4vM1V
        heN+mslbEVkUm9hlQcRDdN37c/d0TLgRomfRk4Fa+stlnKnkSPmPWuJbIhFexQ3C
        KYVEjdnj9mk5Wz19LIhQTdZLm8rOtySlKCMyFWutl4gJNKgqqzb2jX2IA==
X-ME-Sender: <xms:udl-ZAfAPcXkROGbfTSGn0ps77fL1b7yt7DoqkPFYDooydEC4695rg>
    <xme:udl-ZCMpO9bDeDLxxpihI8kYNQrt1dIgqb5av9rRckKRBygIi1LifcfZKcPAuzOxk
    oiVrFxqxMg-A2mrkA>
X-ME-Received: <xmr:udl-ZBhOypslQ05g-sw5XfKsjMKYGL3hNPNefu4zDmmycUh6yebggzG1CK-wc7r8B7hIH2yllQfSAl3j80Rue106aAYgGAKriW_F7gLqyZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeefvdelfeeuteegiedtkeehleffkeekgfffudfhuddvfefftdehkeeihfekjeek
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:udl-ZF88UCqgh2QcKzd5iQFEOyhJal87QNlbdRdHNKalYqwQgqTVQg>
    <xmx:udl-ZMvSPmCw7w7roky3OjhUp96HWHQMGTHwQ_bGeOxmaw-LAWawnw>
    <xmx:udl-ZMG-LErWcNE5xM1JzX9Y9MHqU564zx_zV3SHIXKrxv3LFB_dkQ>
    <xmx:udl-ZOLhbl7zglzVuR9lKWwCNTgchJzjQn6rpIFnS4kUrHZbEyKeOQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 03:01:11 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ee111d09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 07:00:08 +0000 (UTC)
Date:   Tue, 6 Jun 2023 09:01:10 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/16] refs: implement jump lists for packed backend
Message-ID: <ZH7ZtmUrlyJ8H0aP@ncase>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jtx4OKIAjHoiheLF"
Content-Disposition: inline
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jtx4OKIAjHoiheLF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 03:23:07PM -0400, Taylor Blau wrote:
> Here is a reroll of my series to implement jump (n=E9e skip) lists for the
> packed refs backend.
>=20
> Not a ton has changed since last time, but some notable things that have
> changed include:
>=20
>   - Renaming "skip lists" to "jump lists" to clarify that this
>     implementation does not use the skip list data structure.
>   - Patch reorganization, splitting out `find_reference_location_end()`
>     more sensibly, rewording patch messages, etc.
>   - Addresses feedback from Junio and Patrick Steinhardt's helpful
>     reviews.
>=20
> As usual, a range-diff is included below for convenience.
>=20
> Given that we are expecting -rc0 today, we should aim to not let review
> of this topic direct our attention away from testing the release
> candidates. We can get more serious about it on the other side of 2.41.
>=20
> Thanks in advance for another look.

I didn't have many comments in this round. Personally though I'd split
up this patch series into two in order to land the individual parts
faster, where the first part introduces `git for-each-ref --exclude` and
the second part introduces the jump list for the packed-refs backend.

Each of these have merit on their own, and especially the first part
should require less discussion. Furthermore, by splitting it up the
review becomes easier to manage as 16 patches does require quite a long
attention span to handle.

Anyway, this is just a suggestion from my sided, please feel free to
ignore.

Patrick

--jtx4OKIAjHoiheLF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+2bUACgkQVbJhu7ck
PpSkYhAArgsTebGPhgpPlgCuFAe8piBUY1XxyOIvb2+p0laKRQFQfvUAPz1Qg/DB
D16cgOrAgMg8AV97zU5oKLqAPlp1MhSqq6HTw+ekNo9KGWSp1aXqXiu9yjxAiwsG
nQvhk0S8IDRC8LbgxLt2qrVPRGTWi2jie96YIEO8SrOfrslQGiZAcccjvcy6csZw
e+Hj/TuqP5YONf0niqpWwFrWBaOEcbQ8UNIg8xQbr4mEKU5lmfJuiUZ0O/Ge3quh
B2rg+m1smn0FKFYZvpeVkqan8c7sul9RX1+LsXGh0XRnJ/oBuLKOIx7Xj0ozeqS+
iOHbGAg+PEWJxeFPSLobOju9V4VICMBi0FTOZxv3G6wLvpqL0P0LL1MftYapg+bN
F3/E0HwSfj5i1jtcLJZVp34Q+Q/8vN1J1idbaqVDv7FdjhDrE16MoUfSiqObrtna
gvn6RhbVcG+B0op1BMPuTo0uW5IpkCMgL+f+dDVWYOfC6WvvOPE+7bRGzDNwtPzW
YEp9P3z7ku6bxYBVLPVtZCUG3GKQ/TqAPGxZApFk3tyuQBc377FTcF9/m0kL0VI+
J9z1+Md7oTumxcFaAMVIEkIelZsN7rsRntNVpkU5jCyjp679D1wuRoA8G/f+TqzX
z5otcEcaa39jCqcMpugcRXcKXH4RR8IHeawayCcepuSQavd3gs8=
=JPSr
-----END PGP SIGNATURE-----

--jtx4OKIAjHoiheLF--
