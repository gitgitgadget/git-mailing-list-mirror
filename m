Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757F4C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2322C23B77
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgLILxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:53:36 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:47183 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731060AbgLILxa (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Dec 2020 06:53:30 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E1905A57;
        Wed,  9 Dec 2020 06:52:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 09 Dec 2020 06:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yL6vfi3sUB3S8PIZeZMoi/llDGk
        GFjtMfeTubNhE7Z4=; b=uE4P4K4efS2201agtW3P/oXfIqtia/rITqEIwBiCB/9
        zw0CRUnDV2OdncsLdSkrvKcnSVKPcg75Z62N441uwzVMiUVe/3zkNE4VAigm0ODo
        DZZ0KHSaeAHKZpOvHRz4U+9w6v6YeMU31jsc2uIfe00ErnMaAGF+rX9XL9J39G13
        bhXHkhQaKodl+2zCTqIabC6RK++bNmLQHz4nQnejnjd/a9n953PfIA3W/DH+JWKG
        0xFj8RcH3xOt6Sh5X53Rg+V+j5rFIQ36q9/IFcbkBpGpo7ig9914DNj+PrFIn2Lc
        L6lixw49LHRQ0CTjPPqbXP785xyOggo6uwqESyh/mAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yL6vfi
        3sUB3S8PIZeZMoi/llDGkGFjtMfeTubNhE7Z4=; b=ETTy2ytfachuBuOVUIV2Ty
        3HfwKNRt94tNFubTQwuH0BoverqxCxg3cJHSVCLcnIqPywckmhfdQNUvs0Fd/bpc
        oHHxENzJa6sE/oiTI+4KU3J8/bmAhgDyuTbaVyA+1FFV3QxIaOMNHjs5oaKkGNK7
        4aA1iFU6qcBpvE8dTFaLU+Nh5Euc1f0ou5VOLq7hXU+imLtucCaGYn5pzbmSJzas
        AIc47Cfajg/evyLTwEtMFPkr2rFFSOXd0KhQOM4a34tvz+uzoTL/23qaTjU/n0HG
        fPIVCUZEgUcd2XFRbiTUO0dkBsYCIxllLnv/Pxdf9Nhk+tHsaoIebcc+CPMMX9Eg
        ==
X-ME-Sender: <xms:drrQXxR40Ycvy28cEafh0WMQ_Z3a6JMfIG5URqqkjYe356zDwVt2gw>
    <xme:drrQX6w0eFguHgFuTnpyWIe1A-2K1N2N5RfF5pxAZofazVYaOGXS8K-lgyySYWqKj
    -GnQ6W5ygMC-F9WlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedriedurdduvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:drrQX21NcVjaftrbWywd_n-kRTIvVSNlnZcXoL9P1BiKpuoz2AZOBQ>
    <xmx:drrQX5BRLZ_3DmN8RG-LfLtBZu9NUIpUwZxyQuuAxYbBJe9SWgDfHA>
    <xmx:drrQX6jelsoA9ittWePAaMS-JZEK3NWEe7YU8NjKs_kNpXqpYlWeYA>
    <xmx:d7rQX7tg0rWKCvdFk-TWa2eusT5OBIrTDJm9hy25h0_2FDQqw6a1gA>
Received: from vm-mail (dynamic-078-055-061-128.78.55.pool.telefonica.de [78.55.61.128])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3E2B7108006B;
        Wed,  9 Dec 2020 06:52:21 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id 349d2b1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Dec 2020 11:52:17 +0000 (UTC)
Date:   Wed, 9 Dec 2020 12:52:16 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 0/6] config: allow specifying config entries via env
Message-ID: <cover.1607514692.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VwY3XAvwWaik90wF"
Content-Disposition: inline
In-Reply-To: <cover.1606214397.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VwY3XAvwWaik90wF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series which aims to implement a
way to pass config entries via the environment while avoiding any
requirements to perform shell quoting on the user's side.

Given that the What's Cooking report notes that my third version is
about to be dropped dropped because the `--config-env` way of doing
things is preferred, I've now adopted that approach. I've taken the
patch which Peff posted originally (with one change strchr->strrchr) and
added documentation and tests to it.

This patch series still includes my old proposal as it would actually be
a better fit for our usecase at GitLab I have in mind, which is to put
all configuration which applies to all git commands into the commands
instead of using a config file for this. I have structured the series in
such a way though that those patches come last -- so if you continue to
think this approach shouldn't make it in, please feel free to drop
patches 3-6.

Patrick

Patrick Steinhardt (6):
  git: add `--super-prefix` to usage string
  config: add new way to pass config via `--config-env`
  environment: make `getenv_safe()` non-static
  config: extract function to parse config pairs
  config: refactor parsing of GIT_CONFIG_PARAMETERS
  config: allow specifying config entries via envvar pairs

 Documentation/git-config.txt |  12 +++
 Documentation/git.txt        |  11 ++-
 cache.h                      |   1 +
 config.c                     | 120 +++++++++++++++++++++-----
 config.h                     |   1 +
 environment.c                |   8 +-
 environment.h                |  12 +++
 git.c                        |   3 +
 t/t1300-config.sh            | 160 ++++++++++++++++++++++++++++++++++-
 9 files changed, 300 insertions(+), 28 deletions(-)
 create mode 100644 environment.h

--=20
2.29.2


--VwY3XAvwWaik90wF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/Qum8ACgkQVbJhu7ck
PpRmog//bjwePWtNEMZEneJDFxw3IvOhggB3K4a+qlK4Us4arxn1E6kUrFVU2ft1
6f7XiTXM7VMSX7tA2jG9eU3jfaHK54Jp954zDPtvo25hMULEpuJtqbkD5F+FQG43
9Lnfsss5cu7pNOrqqi8cLYwpf2kAaEFW/ZwZCzkNC53f2Ef3qFR78UWpuR/2G2Uu
Z06cPKlE5sFI0V4F/2ooBTyXzRNCuOinUNqNXLGytbhsXslFJ7iq8d8MTLKME8ZV
rbvW3r46pCUbubI6g/T2EXoJgrV0OnM9xG5apx2lWOeSHpVr/cGUax87qAmeNbbp
ecrk8TMKMYq3HLiNyvW1wsgKE8MaxHC/RvPoBaQmrGbcXNGdGHkt2KIuSRhqZ1MZ
N4o23zO9TlF1M7Us+kxGE0t5tUKaaab8jLO7s2R2OxhK2uxOweAqKdt/VlbSDawK
YJQXDoIU3CXxpA+l+KWEP/8yqtBTaGurMTNWJQ4qP5XJh95kfMtOVey07qRl4BTg
A2WxWuquzcTv98fz7GJbDjS2YWJrygGNSxz2VQtUZk+sVOga9REIqbsFkHnVzDDz
gFXH+f1x7tkYObEE5YE1mRizjkDHy5scULj+kZG+HXXpWlLRBRhZpT/vXKT3lCo3
AtvYldMXrwHq/UEosDzJNlYkSUkioM1pVzHHdp5Fp4s98oQNhPE=
=DgGu
-----END PGP SIGNATURE-----

--VwY3XAvwWaik90wF--
