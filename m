Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3217EC7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 15:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbjEIPPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbjEIPPA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 11:15:00 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B8340C2
        for <git@vger.kernel.org>; Tue,  9 May 2023 08:14:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 54BB95C0214;
        Tue,  9 May 2023 11:14:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 May 2023 11:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683645296; x=1683731696; bh=N/
        pJSSV0r18Ke3n3GJLcYqKGJDT4Vu3duhUPoz/Vmqg=; b=TEsB3OxInYJD21g2nP
        ch9AtZsLLwRV9BcGhqbCSoe487XKLw48CGBn5V7GRF9KkbL9caezR4ePG1B3C7kP
        9CxM0uXdpPGm/353HvGPFXKyZ0pmNTRVo/VrAOn+yaxUQ8u74IEeWGSkphKxIUql
        fui1DaFYAjQ0Ht845/2sBMhrLuEx0s/qbVV/GpF369PGKlNxweMVRLxhXjjVsvXS
        m8MPsyjFuaxS0KKVQ2dRxlaLi0ovxib53Nmu+8L0ANBSfFAj2McGcVdvEx/cFzXi
        dfHn3+hZYui7dhYAZdKj77lKCtmaBsqxH/HJJwK57542xdv8wpt3y/OYcTD0TJgW
        zy9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683645296; x=1683731696; bh=N/pJSSV0r18Ke
        3n3GJLcYqKGJDT4Vu3duhUPoz/Vmqg=; b=IPNnB+yORUc57xj9iVuvpmhqfORgf
        5Te7j6gRQ7Q5UQICXyjGZtKKz2yr/GQihrvYZvlfGmyfdYS97jmMjRtP1q4TFrZr
        BBEWU3+k72b22nddPnbGvlqf55khjwLT+l49s4R5Zk/7IjSbf/qWBhnUypJPUMol
        +n5gpEdG1VPv7OkZLwIu9dUjaCI7hAJuCNfOJ5pKSCwcaQ9N5dYo2gvSjBc3k3Os
        VEx5JuNogN93Juvb15SfV3aqbfI6pD2NLvXOWJQ1FEYiVTXnjd0CEqW4L1Bna6oN
        qg+yn6nOG8qC7ZWIUeRjJXpQ39bqOAYHmYzx8xcEnvdAcn+LPRHEXH7qw==
X-ME-Sender: <xms:cGNaZO76442qE2AyHhe8MFIX-xxwqguFn6Q0qxPZtcVgDSVWQ0DGwg>
    <xme:cGNaZH7H4TzfbXoe2MSy2-gqrXc9qEAKGL2xP827Agqkbch2211fEFbSSGX3BH6bd
    5lV2xWwPvwhcBLQnQ>
X-ME-Received: <xmr:cGNaZNd85eiwT1pzjE1WXjZdiLysknDFoiwoHfkAtivaWDh1RGcAh-ft5t6CxP0Oblw0P5m_P2jC5yFAjQ-pLD2gEXlqShLuU4WKF-FNGrs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeguddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:cGNaZLK99iQeLzVs8kc60B2Er1Zl-uCBL6-u9NpPAazANlCFD81V1A>
    <xmx:cGNaZCJ12OM501tA2hK8SkSrujRcpiTZzTyZzlqHVpUzBZY5OtJG6Q>
    <xmx:cGNaZMwHpXTs0xkzednSXIHn1eOrls0i45pLEUL-dmr9iRvtyplClw>
    <xmx:cGNaZO0aQkOzuKXUNT4x9Xla6hOaNDvNr3OqOr1erwlHue0tcchyKg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 11:14:54 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id d90a34cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 15:14:44 +0000 (UTC)
Date:   Tue, 9 May 2023 17:14:49 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/15] ref-filter: add ref_filter_clear()
Message-ID: <ZFpjaUaDl7eUCh8N@ncase>
References: <cover.1683581621.git.me@ttaylorr.com>
 <c804ba3620476713bd0535a315876378149ad7dd.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3dCh3euIGtXWKIWw"
Content-Disposition: inline
In-Reply-To: <c804ba3620476713bd0535a315876378149ad7dd.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3dCh3euIGtXWKIWw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 05:59:52PM -0400, Taylor Blau wrote:
> From: Jeff King <peff@peff.net>
>=20
> We did not bother to clean up at all in branch/tag, and for-each-ref
> only hit a few elements. So this is probably cleaning up leaks, but I
> didn't check yet.

Nit: it sounds like there still is the intent to check whether this does
fix leaks. How about updating the commit message to either not mention
the intent or perform the check?

Patrick

--3dCh3euIGtXWKIWw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaY2kACgkQVbJhu7ck
PpTqCw//bTqVMUI9QNWiG49N+LkdMedMbsZFIRWi91TzIwkU5IU0PLqcIR3A8bjr
PaDh7v34PFJPqpLEHymBYNtKLKCfu5Q6U+P/NE55pL0j9RMiIXP+lH4gFzCyXRWv
ZT6BtSAxwFHoEGxF3SIUkVJvtOcHvX35uSOHfTf2NgdFjac4uPIM1i2pSB44VmKm
ntfCgM6F1mBAK+h4cQ3wwJ9c4NiC96M3CDsZbqA0OyaiwUPMyRlwMJIiZu4D9Bml
6C7B58ng4c/Q5SyPqtIomBzW2agz9Y2VIUfzBnMsLrMb2Z2ZsRE34j3yPzGOuUPZ
lz+Epv6f5jsHAcNlQZw4jW0O0TxWVcI6vv1u2o4ZtOhA4mQYuKWnpGvoSapVnCOd
hWaI1vhKzmwwt+72CFlFxoWZVk9q92ZlQhLqUhd1wZtjlNCJZxJ7+XtauYr3vvYG
LTvb7rYyIoczcDUv1nhWdk7kcM/yknnOjw0erU23YkOD++InCa5oH+7fQrnsciNW
gtCeE3B+RHgGO1gp7GoBtMFwMRVb44TwPo2PGoC3eQmCwbiNDKYdH/LgeRrC/q00
qgRchMheAIYKJNGN+H23YZqG2ucjCaPoYck1m4Y7/VGZBiGqJOzcwrf81kdAh03i
6wC5/DgQQADBzIN4gRp6Z9D4V3v6Ryt1JSAfNl3USSdcyPh6w2U=
=FlrU
-----END PGP SIGNATURE-----

--3dCh3euIGtXWKIWw--
