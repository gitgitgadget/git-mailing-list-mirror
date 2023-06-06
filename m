Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7121C77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 07:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjFFHB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 03:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbjFFHBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 03:01:05 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9E2E68
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 00:01:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 11CA332005C1;
        Tue,  6 Jun 2023 03:01:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 03:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686034861; x=1686121261; bh=IB
        a00ZSL/d/MGmwTUxXRVJAoYBUEu7jtxwqBQpCzAUc=; b=op0Y+9YBiZFPpwZoWS
        OOj86LHdQWw3rSHSfROAW1xuBC6yrIq/uAc9wfaksz4EXcedbIfiYlRhhsBmqWWG
        CDoOVT3KBO9swGM6XQTCrF35805eUwF5fVrEbWYDwFLRO8ebzD6ZyxlvaukycDM7
        QX/BhF4R5U3OSG3sBnJVv1o9ZBxUCwo0y1v8ILb3x7YjOVkGhp9Jq7tdBHGTC/BN
        PQU4JWTI3/2QSJWMIyaTxTqMxsRAzCIFkC8a9I9OOvvaxeGubO77N8Pon8147y1K
        smZqNdofKwKQsEf/kbkFDWM41PZTd0Xvbk8rYDUuWE+PMKxHwI3A4p5bSg7U4DN7
        FEJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686034861; x=1686121261; bh=IBa00ZSL/d/MG
        mwTUxXRVJAoYBUEu7jtxwqBQpCzAUc=; b=DOgGhYe4b3Gjs5YvbEDD7A2C1efTv
        7F7+J2TWoh76FNy5bsTVOZl3OCnrYIcFoJ2nF2UtdkBVo6UM4SPA6rNfAOnuauyA
        WJPITbewpJYDge2MgXzKZ5UCBxOhUevyTcrOHZO9M3IVfl51MutucBUcbSaH70TT
        Au5s1tmm0/ubFxJLNR2eVAt8tzAvMrFQeWP+f4GV4s9bZnzWEepgoJ90Wg3Akjte
        q2JEXL4vzNKBj4mFDujkwAH1co+v8d/6hYRCYwrmzuJ0hsoE+XJYBBtNYlHM9Tw1
        HYfLbpT2yaIICvofgmNVXWGV5nKZ2sBWIBjPBkQeNHVvO1X47PLSmFFsQ==
X-ME-Sender: <xms:rdl-ZOODUpyM8U2FYQY7VNMmT0PbBb2UWK44Pi5XRBX7QvemwqUGzA>
    <xme:rdl-ZM812mhAV_-MBbu9a_n0rY4VzsBO3qvQt5L8T3Vw9_Lml__io1TI4f7AayJ2Z
    XwuFhhzrvvYjMYF-w>
X-ME-Received: <xmr:rdl-ZFQ7dcUO9MBbXDCQbQGeF927D9kAVWBNyyhT-E4odF4TPdKBv6h-tqairKTdfm3gkrzZNM2P1K0PFAMjSuXqKVZCils_Tgl8GyLdBco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:rdl-ZOsmizTpuAAJEApYmRcmzqbEy8RaF6SXRoUSnYxXeTKu469TrA>
    <xmx:rdl-ZGd4HktYFCcP3z99SR04RbiBVVXIujzyWLtOt4wt3d9nSNtKrg>
    <xmx:rdl-ZC1qAC6YMaYM-9xdsnqYVJ9iG4sfTMDrOWcEKwVRNUhMvhG6AQ>
    <xmx:rdl-ZF4KBz6lFPwdT3rbKnf9uFUEck6JThuUoDAXaJvSTKNafNd-zw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 03:01:00 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 56166d3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 06:59:56 +0000 (UTC)
Date:   Tue, 6 Jun 2023 09:00:58 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/16] revision.h: store hidden refs in a `strvec`
Message-ID: <ZH7ZqjYqyvSOHY8u@ncase>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
 <f765b50a8405f1653cbc2e79b375c979c4361550.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GcWKdcmbisd/leMu"
Content-Disposition: inline
In-Reply-To: <f765b50a8405f1653cbc2e79b375c979c4361550.1684178576.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GcWKdcmbisd/leMu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 03:23:39PM -0400, Taylor Blau wrote:
> In subsequent commits, it will be convenient to have a 'const char **'
> of hidden refs (matching `transfer.hiderefs`, `uploadpack.hideRefs`,
> etc.), instead of a `string_list`.
>=20
> Convert spots throughout the tree that store the list of hidden refs
> from a `string_list` to a `strvec`.
>=20
> Note that in `parse_hide_refs_config()` there is an ugly const-cast used
> to avoid an extra copy of each value before trimming any trailing slash
> characters. This could instead be written as:
>=20
>     ref =3D xstrdup(value);
>     len =3D strlen(ref);
>     while (len && ref[len - 1] =3D=3D '/')
>             ref[--len] =3D '\0';
>     strvec_push(hide_refs, ref);
>     free(ref);
>=20
> but the double-copy (once when calling `xstrdup()`, and another via
> `strvec_push()`) is wasteful.

I guess the proper way to fix this would be to introduce something like
a `strvec_push_nodup()` function that takes ownership. And in fact this
helper exists already, but it's declared as static. So we could get
around the ugly cast with a simple change to expose the helper function.

Patrick

--GcWKdcmbisd/leMu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+2akACgkQVbJhu7ck
PpQU4xAAhMQZP5Hb6SQCI/7o1SGadWlIElTO2Bv4GRCzp/hWRop45iDDwyB9cwQa
qSA/Hi/4jQ3qNhKU5DEyW6kIZ4Ptuu3tYiT1ILlQu7vzUNykDHBbFSalDdcVIz9w
xgBaVLDiLVmogkDA07Xv2Xv4nZ6h/QqxK6+oHb9dnbBlnQlLKM/7XAiIAPRo/5UL
hKG2EVzxY6r227s2uZ/6M3BDe4CtldYh0eZRQYxzfdpxuqqiFvCns1ATGR0UaYqE
8e1X+EBKkPDc1cnuniU2pCd6uwJFGcbqKrtqm59IykEyZMJhTbkUjA+yjH3Gifoi
eodxBvxeU0CUk8hwc7JaLkAFo2oxhiKZ29wRaOCpKHoEZFd4CAHvN61WBQ2CTDZo
xEYgx2om6J5zxlO1KYgEHZkErRd+jnvOqlDZzO/k9SXvkbAfLPL+lvxvcS4ercnN
JVfnRMlgcu3v9NvJIA9lMc4LqRwUlpGuGujS4uxbQYqbe/lYGHBGCtdW9J0aSHL4
LSjt0a/m2HjwfvOCGhWoze9YWj6AOx2ijh/U2I0lVjBHyeHBZSzTbr7bqusrMzJZ
/pMxXqXTaesLTTo9SbVcArG9W7ZAbCaPw31mdqHmwrkq23dG44U76nbQM5OVDgVh
lHcIzx6dp2KCR6qtipYOU08YSJnCfhZbGwePhPGqbMzeFksKUAg=
=XRi6
-----END PGP SIGNATURE-----

--GcWKdcmbisd/leMu--
