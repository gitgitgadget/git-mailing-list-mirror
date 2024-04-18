Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8615FA6B
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442454; cv=none; b=jxBBh+WHAr/gcuJqur3d3zROb6gDxFiRg1WxifVu15HEU9gKuaESWSOD5qtEWlO+k9Ko2y0jnELQsoMbydfW2MVyOjs8IjHvlXye24ZPr+Yq7+GQMxseJX+YewwgjAFXiDflTwtBIp6haVGIKDmFqN3MZ31LlEw8BiEsIZbyAMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442454; c=relaxed/simple;
	bh=uZpWjTkoANPMAF1z+XW0KlDZ6AK4R9f9v43gDSdrUOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaY3t/nz5vPMC6gvCRninLOCa5WeB8BTJaGYxbL5SNfTZkmFAONYfbZB14eVfha16oH9M3S2SyT6TY9HMceg2OYqTmRKZncziJNr0t2BalrtqxrX1Qde86Nhg1WnTtjRm+JQFlQSQ3J2pucESlcrY++fGmivH9G0+5iq2BGQNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IRyUsjkq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNDYNonh; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IRyUsjkq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNDYNonh"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 40D5E13800F8;
	Thu, 18 Apr 2024 08:14:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 18 Apr 2024 08:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713442450; x=1713528850; bh=qZ+6XPVCCd
	1Tyk3vmgUfPZKEYifHI+pFhETTU7HUt7s=; b=IRyUsjkqHM2fF4XaP0JIgYo4dD
	L9gCHdyHXPRqYcfk9IIR960N7NsBQheuYC8k+5ngjDZ2Xhfu6XN/iUuXnq/5vWbG
	AhkMNkkxNXKFU1y8MLsTIw6iAN8B+664gO/Bm6JVfKcPww7QWKHvwldvfUe1rMEj
	TwzJXz66BX5MlSTgBEkjrEpp+v0A0rqHHYZnZAOOfDaI+0GTk7F3Du5HEJroPY+/
	51SivylH5vRB1WkaFfO4V85Nk+Bbcio51kiDXnfz6kSupNLpkNuSlkaDcf94+4Ui
	TYndzqyWurvAXvx+FI6T3vrvU82raL31e7SS0YM+kSByDk7T2sIatXKa5I9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713442450; x=1713528850; bh=qZ+6XPVCCd1Tyk3vmgUfPZKEYifH
	I+pFhETTU7HUt7s=; b=jNDYNonh+DZA54HuTVnDD31n1c51/2b15tSRehHKOQBX
	KNWE0MDjGk61u6QEwUnY6x4LIbOhWZdjB4wj64/RTe0ZPlRxHXRdsbnyQMj2YXIT
	8BgS35jk55XDGSQWilpbQur/HV1fdAIZ1D6E9kI124vDEs9jAbOStz0PXeJY6++j
	6Yw8XU9YmmNqlET6ThJIc9AjzXZSsAxcTHZ8/RFmx8l4joXioOGQEJ++oWEg2jUg
	sR7Rpb6Rj3PHqsTj/ubBE0tCERysRO1Fl2gJ32Zb5iFJmkSxthXXQOeMYb8QWvFj
	r93HANF2m0wU6gyrSXkIEk7qjLOAeALeqb64uylJXg==
X-ME-Sender: <xms:kQ4hZpDLTbGl5lF8KPHyhoE9VioRl37o1yg1SbRIclhU61DF7ZI2mg>
    <xme:kQ4hZngouTNc-cbdsqC_QRS53pSoMXI2kzvyGi3XGlYvEU-67iKFBGo7gAT7IOWCV
    jDgyu9_K9vP9Dgkrg>
X-ME-Received: <xmr:kQ4hZkljMraR55VJXdEeueLR5QDAQLEM90dJDA03chjUpu_cx3uOYysZkc0HV_0Om-SbMhLD5o4WurjeCUbc5rRpn_EPJ5MumNxhsBuHNnXHJ5N1yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kQ4hZjxI1_LG8Ar8drINRSd4nT8FVXZSL7s2AaXRcQA_wLHbcxakKA>
    <xmx:kQ4hZuRtI6xw_IUwE9NhUVzmwfzK86U7ioUDh2PuraeywfFsZ9Lwpg>
    <xmx:kQ4hZmY-56bvsvGfYw4Okzqcb4aqEsftwc5aaB84YyEjoQ15vQZRyg>
    <xmx:kQ4hZvTGKj9wKh_B7ONFK0vLyUBlvvKwhmnAeNOnn4pf1ZkcdRxSZA>
    <xmx:kg4hZkPASljqW4HkD6QUTit9V9SDpSxHxTuMqNKzeWA5-QTtu5Kekd0u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 08:14:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a8639cd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:13:41 +0000 (UTC)
Date: Thu, 18 Apr 2024 14:14:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] global: drop `the_index` variable
Message-ID: <cover.1713442061.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vUqevJ6qcZKlsTES"
Content-Disposition: inline
In-Reply-To: <cover.1713180749.git.ps@pks.im>


--vUqevJ6qcZKlsTES
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to drop
`the_index`.

Changes compared to v1:

  - This version goes a bit further now and completely drops the
    static `the_index` variable, as well. The repository's index gets
    allocated dynamically now, like all the other sub-structures like
    the ODB.

  - This also allows this series to remove `initialize_the_repository()`
    now. Instead, callers call `initialize_repository()` now.

There is still quite an ugly hack in `initialize_repository()` which
requires us to treat `the_repository` specially. This is because
`the_hash_algo` maps to `the_repository->hash_algo`, and we rely on it
being initialized to SHA1. So we need call `repo_set_hash_algo()` on
`the_repository`. On the other hand, we cannot set the hash algo on
repos which are not `the_repository`, because that breaks stuff, as
well.

I'm currently prepping another patch series that builds on top of this
series and cleans up this mess. It surfaces several bugs that got masked
by our setup, like for example `git rev-parse --short=3D` not working
correctly with SHA256 because we always truncate to the maximum length
of SHA1.

Patrick

Patrick Steinhardt (6):
  t/helper: stop using `the_index`
  builtin: stop using `the_index`
  repository: initialize index in `repo_init()`
  builtin/clone: stop using `the_index`
  repository: drop `the_index` variable
  repository: drop `initialize_the_repository()`

 builtin/add.c                        |  48 +++++------
 builtin/am.c                         |  36 ++++----
 builtin/cat-file.c                   |   4 +-
 builtin/check-attr.c                 |   5 +-
 builtin/check-ignore.c               |   7 +-
 builtin/checkout-index.c             |  22 ++---
 builtin/checkout.c                   |  87 ++++++++++---------
 builtin/clean.c                      |   7 +-
 builtin/clone.c                      |   7 +-
 builtin/commit.c                     |  81 +++++++++---------
 builtin/describe.c                   |   3 +-
 builtin/diff-tree.c                  |   3 +-
 builtin/diff.c                       |   6 +-
 builtin/difftool.c                   |   4 +-
 builtin/merge-index.c                |  17 ++--
 builtin/merge-tree.c                 |   3 +-
 builtin/merge.c                      |  31 ++++---
 builtin/mv.c                         |  68 +++++++--------
 builtin/pull.c                       |   4 +-
 builtin/read-tree.c                  |  15 ++--
 builtin/rebase.c                     |   3 +-
 builtin/replay.c                     |   1 -
 builtin/reset.c                      |  32 +++----
 builtin/rev-parse.c                  |   6 +-
 builtin/rm.c                         |  40 ++++-----
 builtin/stash.c                      |  45 +++++-----
 builtin/submodule--helper.c          |  21 +++--
 builtin/update-index.c               | 122 +++++++++++++--------------
 builtin/write-tree.c                 |   6 +-
 common-main.c                        |   2 +-
 oss-fuzz/fuzz-commit-graph.c         |   3 +-
 repository.c                         |  50 ++++++-----
 repository.h                         |   5 +-
 t/helper/test-cache-tree.c           |  17 ++--
 t/helper/test-dump-cache-tree.c      |   5 +-
 t/helper/test-dump-split-index.c     |  11 ++-
 t/helper/test-dump-untracked-cache.c |   3 +-
 t/helper/test-lazy-init-name-hash.c  |  39 +++++----
 t/helper/test-read-cache.c           |  11 ++-
 t/helper/test-scrap-cache-tree.c     |   7 +-
 t/helper/test-write-cache.c          |   3 +-
 41 files changed, 435 insertions(+), 455 deletions(-)

Range-diff against v1:
1:  7b5ec04efc =3D 1:  1baacc1fd8 t/helper: stop using `the_index`
2:  9d5f2eff8a ! 2:  371f69a2c9 builtin: stop using `the_index`
    @@ builtin/cat-file.c
       * Copyright (C) Linus Torvalds, 2005
       */
     -#define USE_THE_INDEX_VARIABLE
    ++
      #include "builtin.h"
      #include "config.h"
      #include "convert.h"
    @@ builtin/commit.c: static const char *prepare_index(const char **argv=
, const char
      		} else
      			warning(_("Failed to update main cache tree"));
     @@ builtin/commit.c: static const char *prepare_index(const char **arg=
v, const char *prefix,
    - 		add_files_to_cache(the_repository, also ? prefix : NULL,
    - 				   &pathspec, 0, 0);
    + 			exit(128);
    +=20
      		refresh_cache_or_die(refresh_flags);
     -		cache_tree_update(&the_index, WRITE_TREE_SILENT);
     -		if (write_locked_index(&the_index, &index_lock, 0))
3:  96256f9eb3 =3D 3:  416612e7e3 repository: initialize index in `repo_ini=
t()`
4:  881b6d2f7d =3D 4:  6fb1492018 builtin/clone: stop using `the_index`
5:  80c36225bc < -:  ---------- repository: drop global `the_index` variable
-:  ---------- > 5:  549f8c048f repository: drop `the_index` variable
-:  ---------- > 6:  ed722b9b4b repository: drop `initialize_the_repository=
()`
--=20
2.44.GIT


--vUqevJ6qcZKlsTES
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYhDosACgkQVbJhu7ck
PpQagQ//beuIyzmu/OFlj+YYTWsJCqK8+fmUOjBh3Kyl7R1D6NKK5uETmad2J7f+
XvhDUCI3RgXXDmwPisLP2+HljcMiltaBvwC1vr27ME4hcfFg0NIhq9+sTlgMztQU
w/7CzM87VHHPvlz4KVTH+3phZBNRZ3Nzv+U/spu08bZP78wi2pPPmbfrA73PVL0Y
IPwM4WKOy6yCqkJKp6xSh2KrghHLWTSHnKKXuxKxUawKOGaMsyE6InPUkelRRgzT
htl9h/dK7Ula4YVFTTkjD6grxsRaYUcDgsWpXE+I27JP0pShb8IXZ6JwVLNSGnv+
brrZXls//jzSuYribVU/waqMqvy5bQ3w2iQ9Lsj0bPUwU7OgiRMyeZ3STWeJh/Kt
mdR/I2TB8qOXt1xfJ1hsNmFuslDlc+EBaMmMc9Od/QD4TEfK3J49JY5Rremembvp
r3nef6ZkblT4t7vgZl1uWSuRlXVIArPvCew3xwkJraqtBvxDwmQKrdpEg6HzUhu2
Ppbc+2Q08Ws2oHGDqx0PaR2WgjGj0w+dCscdjOX64AyDMPD2YeiJSpS8ZsalfG80
5axBMF+9je3BByzfaYR4LLmswF6avR2d4KLldWesUCub+fHH45IomIfPDL3TY0r2
+GzroBeY1YwXBQ9BdQBxyNBEmTyZcC5wQmb7z8y6+ycEpf6gnL0=
=8tud
-----END PGP SIGNATURE-----

--vUqevJ6qcZKlsTES--
