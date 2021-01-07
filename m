Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6634C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A8A221E9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbhAGGhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:37:43 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39217 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbhAGGhn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jan 2021 01:37:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A51605C0101;
        Thu,  7 Jan 2021 01:36:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 07 Jan 2021 01:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=HP09JHQ7TQNQGwgjgmDtHXj6hil
        y3wWMzIZ+XeCLZSs=; b=dkdtEXnJAmHDNRnGJofFxYA53MtEffojVUXq/6CqDeB
        FtfZHnBoluREoupjYCIp0KVY/D0KbVjjiqMyc1Ck9ArHbP/oUDyHB+Rave6w5OyL
        X00qgvE7PaVc6NXRwxY2frvC0BBp7RCNH9w+QrHrN9p9YNF6k1iR46UaX3GCv/y9
        tO2U8VBaFs8A7XHVQZbOe5e54PlhaL9DTzTGZN8tt41LVbB9A70R4t7l6FXAXLW9
        wqDvHY0al1cyU8xPDMAaabzPmoiJQKeM2OHg/Z/tOzCEmZbz9/HfP7xQMPdfywKF
        +r6aIXTP2yOerfIfStf6bRUnYDWvvCBAE9Ck/mgjJew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HP09JH
        Q7TQNQGwgjgmDtHXj6hily3wWMzIZ+XeCLZSs=; b=n9vXKONr/9PbNo2Qb/GhgN
        gTXwNGD1aE8PGHnEbGIh4/pTrj82D5PDIhXREQp+nftCl2nEDU1IuvqGV4H57tlt
        7rD5owaWrsnTY2Cz8LBnu8Kmqj2sUH6p3jrbpGo4yLgw9K36R3SE8ly+z6EH7RDQ
        7NwJwcpO9Kv6yA3WoeaLnZmIa7LPHb1RUYvSlxEFVlnglQR/E2Mfeb0a7PENsE0i
        63pfh9hoH4rij2Am5cZaLyGv/ck4n1iNtoKSUZ/IDGOROHDv86m3v+7w4xk5BUkM
        LZcc73Z0WusHP/iFVB39ZU/PFYs7dDT+jJNCYa42/IkbKrMOlrCaSehsl8lfP/Eg
        ==
X-ME-Sender: <xms:Aqz2X8zt9YXoE21uPSY8AULLiJbKzz9KHwJYvqePDdUPdVNWRgs_CQ>
    <xme:Aqz2XwSkYWXRSkATfwQPdUIT6CUjgoNVJn0dZxaKmnbr4V58RyfzLHxHi357pyGep
    HggALNkZmWwP1lEBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeguddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddufedrfeegrddvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:A6z2X-XF_obWup9nxHLCRINRDPgzQhw86_Z0eDtna-TpwbabHHDbNg>
    <xmx:A6z2X6hsRapMmPRYX-1NAG9SThqA8KBHSPinrMURAX0QfOciaZIyLA>
    <xmx:A6z2X-D3UfY9PimNn-9pUkSusk-sMAn8Nr2qOY58CBbTHurajkm0RA>
    <xmx:A6z2X5MwOHQF_J4dAa7KNhgmXzTO4-6VqhT14YzJaIaAUOMEeZfALQ>
Received: from vm-mail.pks.im (dynamic-077-013-034-232.77.13.pool.telefonica.de [77.13.34.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 26B301080057;
        Thu,  7 Jan 2021 01:36:50 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8ed2eaf5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 7 Jan 2021 06:36:43 +0000 (UTC)
Date:   Thu, 7 Jan 2021 07:36:42 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v6 0/8] config: allow specifying config entries via env
Message-ID: <cover.1610001187.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mc/nTQ6Cm6Feh0D4"
Content-Disposition: inline
In-Reply-To: <cover.1606214397.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mc/nTQ6Cm6Feh0D4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the sixth version of my patch series which aims to implement a
way to pass config entries via the environment while avoiding any
requirements to perform shell quoting on the user's side.

The only change in this version is improved formatting and wording of
the documentation as proposed by Junio. Please see the attached
range-diff.

Patrick

Jeff King (3):
  quote: make sq_dequote_step() a public function
  config: store "git -c" variables using more robust format
  config: parse more robust format in GIT_CONFIG_PARAMETERS

Patrick Steinhardt (5):
  git: add `--super-prefix` to usage string
  config: add new way to pass config via `--config-env`
  config: extract function to parse config pairs
  environment: make `getenv_safe()` a public function
  config: allow specifying config entries via envvar pairs

 Documentation/git-config.txt |  16 +++
 Documentation/git.txt        |  24 +++-
 cache.h                      |   1 +
 config.c                     | 205 ++++++++++++++++++++++++++++----
 config.h                     |   1 +
 environment.c                |   8 +-
 environment.h                |  12 ++
 git.c                        |   3 +
 quote.c                      |  15 ++-
 quote.h                      |  18 ++-
 t/t1300-config.sh            | 220 ++++++++++++++++++++++++++++++++++-
 11 files changed, 484 insertions(+), 39 deletions(-)
 create mode 100644 environment.h

Range-diff against v5:
1:  470521e728 =3D 1:  cd3de0743a git: add `--super-prefix` to usage string
2:  56c9221c4c ! 2:  9b8461010e config: add new way to pass config via `--c=
onfig-env`
    @@ Documentation/git.txt: config file). Including the equals but with a=
n empty valu
      --type=3Dbool` will convert to `false`.
     =20
     +--config-env=3D<name>=3D<envvar>::
    -+	Like `-c <name>=3D<var>` except the value is the name of an
    ++	Like `-c <name>=3D<value>`, give configuration variable
    ++	'<name>' a value, where <envvar> is the name of an
     +	environment variable from which to retrieve the value. Unlike
     +	`-c` there is no shortcut for directly setting the value to an
     +	empty string, instead the environment variable itself must be
    -+	set to the empty strin. Errors if the `<envvar>` does not exist
    ++	set to the empty string.  It is an error if the `<envvar>` does not =
exist
     +	in the environment. `<envvar>` may not contain an equals sign
     +	to avoid ambiguity with `<name>`s which contain one.
    -+
    -+	This is useful for cases where you want to pass transitory
    -+	configuration options to git, but are doing so on OS's where
    -+	other processes might be able to read your cmdline
    -+	(e.g. `/proc/self/cmdline`), but not your environ
    -+	(e.g. `/proc/self/environ`). That behavior is the default on
    -+	Linux, but may not be on your system.
    -+
    -+	Note that this might add security for variables such as
    -+	`http.extraHeader` where the sensitive information is part of
    -+	the value, but not e.g. `url.<base.insteadOf` where the
    -+	sensitive information can be part of the key.
    +++
    ++This is useful for cases where you want to pass transitory
    ++configuration options to git, but are doing so on OS's where
    ++other processes might be able to read your cmdline
    ++(e.g. `/proc/self/cmdline`), but not your environ
    ++(e.g. `/proc/self/environ`). That behavior is the default on
    ++Linux, but may not be on your system.
    +++
    ++Note that this might add security for variables such as
    ++`http.extraHeader` where the sensitive information is part of
    ++the value, but not e.g. `url.<base>.insteadOf` where the
    ++sensitive information can be part of the key.
     +
      --exec-path[=3D<path>]::
      	Path to wherever your core Git programs are installed.
3:  5729f5d406 =3D 3:  9d4c8d7be9 quote: make sq_dequote_step() a public fu=
nction
4:  8c6cdd57a0 =3D 4:  0a9b085fe5 config: extract function to parse config =
pairs
5:  ff96e59e79 =3D 5:  b96686c9cd config: store "git -c" variables using mo=
re robust format
6:  d832f3dedf =3D 6:  6597700ffb config: parse more robust format in GIT_C=
ONFIG_PARAMETERS
7:  2f51a0c5fc =3D 7:  cade8fb12f environment: make `getenv_safe()` a publi=
c function
8:  dfceffd8d4 ! 8:  4e3f208d13 config: allow specifying config entries via=
 envvar pairs
    @@ Documentation/git-config.txt: GIT_CONFIG_NOSYSTEM::
     +	pairs are processed. These environment variables will override values
     +	in configuration files, but will be overridden by any explicit optio=
ns
     +	passed via `git -c`.
    -+
    -+	This is useful for cases where you want to spawn multiple git comman=
ds
    -+	with a common configuration but cannot depend on a configuration fil=
e,
    -+	for example when writing scripts.
    +++
    ++This is useful for cases where you want to spawn multiple git commands
    ++with a common configuration but cannot depend on a configuration file,
    ++for example when writing scripts.
     +
     =20
      [[EXAMPLES]]
--=20
2.30.0


--mc/nTQ6Cm6Feh0D4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/2q/kACgkQVbJhu7ck
PpSyIg/5Abw64LcszF5fUXid5xz8NHn6Q5/XtKhf1xHNC2Ujg5pD+gdCY6wyMp8E
z8nDpNJl4mpj42Bl3w3I6b7wniC/2bXWn31CDx1l9K4L3Cy21CmhB7BTe+jkmU4m
y93M/fviCdlYqAZ48uY4WcxovLkjHmWTOA/1J4NQb4NoiAC3OGR8NePmQFKbwhfn
sphDaE7wkiZJPcCwmsO/0gIX/6pHBFod0PUnOmlXoiDzP7e7UZDnijsMJGCFxjaZ
8ErW77OpdY89Wdy2owP1jr0QXtnnZK6eZgGmdIVrcTeCj5csoKS4UzVIToCi5lTq
TcgazzPsTLvz0onP7Nk0zg51wOAKjnWmWmtWixfB53A4LNAxj0/lQHyHVIlSJ0ZU
wnr6y3B2WMHP/DJzVhj907Ea0+gJEpyj44X/9PX18eRRU2GlHWlHN+a7UhV9x66v
yptt4fjSVq4Ir9qLeBLzDk+D3xM89H4tvKzY9IzgHIh7miypKktNLkxT3fskqO7Y
2untddemKBgktjmf5bANzFs8BDuMQcJ/TGeZfoGfReFH7DeINpiLT705yaXf5JMm
oNkCa6Exi4b5ras6WThBLBKhjAPjtpVUeWKovW/0hf7buQLiYfIsorWdcLmGT4t5
urTv6lAH2agBomNwWimvGxdITohXQuAVDOQmTRt3RwLyNYUgdx4=
=A3i7
-----END PGP SIGNATURE-----

--mc/nTQ6Cm6Feh0D4--
