Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F6DC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 14:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiKCOhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 10:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKCOhc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 10:37:32 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E82410F4
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 07:37:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8ACA23200993;
        Thu,  3 Nov 2022 10:37:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Nov 2022 10:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667486250; x=1667572650; bh=CkTM7CaVF4
        pZMULZ+8Y5SGywqkvm9FnLXnuWTxEYJ7I=; b=Nw19Tzcpyr/hHutgFPYwsSAFdw
        yH8thwHqFGbaB6zllvU/J/3wjrbdu760lu5jJ3J42aVi9Cayd+6YDvXwwE4T1MG5
        UJAGGfPBaUSAcCf4q33Z9AXELK5iCP0WRuNE+D6Pgf8+mAUD8XFEO/lL7I66rpOT
        gF0qgkIQ0ldXy9W/NcWx3vWeW9siNGWTh410f6ee5o0UYYGjcY9Q7XKyuhyhx/4L
        cXlyg82Mfuxc8EChNGhLlr0TO87ze4ZlXa8ALN4gaD+M6LoWxGKCXSO7L7sWIIMU
        paxpfA+jOM3Tnn6NEVgSBr+oOfcOZwlQDEhYeT0367+qR+lCxyLRcjYsW8CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667486250; x=1667572650; bh=CkTM7CaVF4pZMULZ+8Y5SGywqkvm
        9FnLXnuWTxEYJ7I=; b=V7CA6lhJDg5kfS0U8U8RFQC4ibQ1mt2AcUPd5jr06uAb
        PKEFpNM7ZiI7KHHCdmeRp7PfoErxNS4KkSO62hopK+10YK8uWQ+Jy71lklxC7GSR
        J5TLiPu84VKrrZZpSuTJ2zm6zULDiyZBNC1XkKn89JezM4naT2NtxRcowfMmIFtS
        WH9d2XHDsZUrG/CgD+yZHTcvQpzpYnCxw6fZHSCPnNHoCJeQDooZh3MeVSxp34ln
        ASUzsm/jR+k5uZVhBNWmm5OEzzQKgX8ltQpeW9jdeyhvKkGuB3463FpxbZGvAdZT
        ySe4aJrv1IMiWtJ0eRhDkia//n9rWmLMmzpGHNir6w==
X-ME-Sender: <xms:KdJjY_5Gl1jG4duHiEnDifEag1pk5ndumhIyHxmTkd87LDNxpR8i-A>
    <xme:KdJjY06KT6BHe-FmnYTwBiXSF7BVuUiSr84D1rEN9p8T1aV3tPem6Ie2S0zgybMYC
    bg1GPgDyo1Id8x9Lw>
X-ME-Received: <xmr:KdJjY2dPaNPEGrKfq0wmfjTiAQf6xpWXD7Qf_TyKe3sbDsV1FfN2VyCI8kFwCb7ajStdRgaOC60S8e2P9Mm7Zw4kqZgWdAyWTerbYW4gLZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:KtJjYwLFl4RjnxndApuKdMOJQ3YFrdEJjKububjAp_oZI3p6EhlZvg>
    <xmx:KtJjYzJyumXIhf2OXrT5r4pSM0pdNWE5EF8321tVwhHdsAXjMvdTtQ>
    <xmx:KtJjY5wn-vVti1u16BKfxeFlDRjXGRYKYfBVUj3NR5aB6tB2h650rg>
    <xmx:KtJjY71kDZfODlCwlC0lxaPZ1OnutVtVGtPl4lU230GMN0GBan1VgA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Nov 2022 10:37:29 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 5450e6d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Nov 2022 14:37:07 +0000 (UTC)
Date:   Thu, 3 Nov 2022 15:37:25 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 0/3] receive-pack: only use visible refs for connectivity
 check
Message-ID: <cover.1667485737.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9X3vfGUdbzuf2zVh"
Content-Disposition: inline
In-Reply-To: <cover.1666967670.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9X3vfGUdbzuf2zVh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that tries to improve
performance of the connectivity check by only considering preexisting
refs as uninteresting that could actually have been advertised to the
client.

This version uses the same idea as v1, but it's basically rewritten
based on Taylor's idea of adding a `git rev-list --visible-refs=3D`
switch. This fixes two major concerns:

    1. The performance regression in repositories is now gone when there
       are no hidden refs. Previously, there was a 10% regression in one
       specific benchmark that was caused by reading advertised tips
       via stdin in git-rev-list(1).

    2. It fixes Jeffs concerns around a TOCTOU-style race with very slow
       clients. It could in theory happen that a push takes multiple
       days. With the previous idea of reusing advertised refs for the
       connectivity check, the end result would be that we perform the
       check with a set of refs that has been generated when the push
       started.

The series is structured as following:

    - Patch 1 does some preliminary cleanups to de-globalize the set of
      parsed hidden refs so that we can use the existing functions
      easily for the new `--visible-refs=3D` option.

    - Patch 2 adds the new `--visible-refs=3D` option to git-rev-list(1).

    - Patch 3 converts git-receive-pack(1) to use `--visible-refs=3D`
      instead of `--all`.

Overall the performance improvement isn't quite as strong as before:
we're only 4.5x faster compared to 6.5x in our repo. But I guess that's
still a good-enough improvement, doubly so that there are no downsides
for repos anymore that ain't got any hidden refs.

Patrick

Patrick Steinhardt (3):
  refs: get rid of global list of hidden refs
  revision: add new parameter to specify all visible refs
  receive-pack: only use visible refs for connectivity check

 Documentation/rev-list-options.txt |  15 +++--
 builtin/receive-pack.c             |  10 ++-
 builtin/rev-list.c                 |   1 +
 builtin/rev-parse.c                |   1 +
 connected.c                        |   5 +-
 connected.h                        |   6 ++
 ls-refs.c                          |  13 ++--
 refs.c                             |  14 ++--
 refs.h                             |   5 +-
 revision.c                         |  34 +++++++++-
 t/t6021-rev-list-visible-refs.sh   | 102 +++++++++++++++++++++++++++++
 upload-pack.c                      |  30 +++++----
 12 files changed, 196 insertions(+), 40 deletions(-)
 create mode 100755 t/t6021-rev-list-visible-refs.sh

--=20
2.38.1


--9X3vfGUdbzuf2zVh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNj0iQACgkQVbJhu7ck
PpS4DA/+J4h8QVuYP2Qg3eUYOTMniwDCWLAYpCRw1q1pyzsjgQ9PdhDu+VwOLG5r
NHDmHAd7rZMpLHVIEa5rVV3QDZmIoiH9O1qdqU/qqVYeLuUbmUawKq0+NJuUQNY2
qk/xBS+HhFexsTlpTc15yLwtxctcPV+JcbCMIYt3jtZeJsTdXgBfrQ0osbJcsrri
vmbRnGYaJn+j5ONsDD0XxQQKAxskC0NGI2/+XN0o0LJlDVJMIlJVFoKn2fcLeB5G
lvL8kn8xweaAqDtQexTJq2ZlpCfLpTiW19EsXR+fGc+6CrILHB8wj2N8HhbQB2Xo
0WzYkLMv1Rxuf4kaoumNohaeHc0K0ZEvwUFlBu657rzAocUjGs4rKro8+E1o5Gqj
KiexYOMxxkRAUECeRvq154TD/3HzkBI6jnoziGNbP9lx2egzgEiAp3RcIOExTCpW
UgUvI/yvGiAHIfITiE98N6yrMSMJNJ4oBTd+X+gbSwtdELgpB5JxGqELIUSK8yrM
e7bHFUQ7q6eKjZZ/rXJpoVV3NLiquWhnZw7frkoDdoQ2pQJJGC1bFLpl69BUioIV
VwQMfvxUsTe0rYVohgeUXUPyZ/hZHRfehS2c2p6dynVKruJeEEzBEqauD0KVY+FV
lsa/Ord2V1DJ7xmlaYlUY7oIGMTuxwoGI53kYWMu83pDt5MTfjY=
=Uq22
-----END PGP SIGNATURE-----

--9X3vfGUdbzuf2zVh--
