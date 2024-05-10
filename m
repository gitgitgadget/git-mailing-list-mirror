Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3595616D4F4
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340273; cv=none; b=a/ImFT+RMt/Ev4NpmtoY5P9HRvONpMnqIFp2ZIJJtscov3CJxs/5w7ujWcT+EVmapnVENrCmvZwwc5FpzYJqOKyoC+bEK2R6OOVF4jsw20L+Kp4jSyd9YwAPDMgNDXJQZigMX7qQO5UOUraL1ENd6OhSQgkCYpsrBAW0F/ha9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340273; c=relaxed/simple;
	bh=ycnFuipyBouGhB18tMkbMyevESP/O5x/vVP6rvdDlgo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hBqQNCXwO/zJJUPKvoLlyB+cLWo/H7C7y/jCQqaGombZW9Nur2fQHbrxDzi+lGaBczRuWRbXeXORvxtdJvB5gpg+ak2JQIoU50RmICdmxmETpo2esciciTE7dq50gEEyQhtXg+Ifh9O6XjVVSIA7oBAWnECddojSaUamu2UxnEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b2N59bkI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZUe+2lx3; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b2N59bkI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZUe+2lx3"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 5A46B1C000CF
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:24:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 07:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1715340268; x=1715426668; bh=nuFi7CGN5ldnkywy7X11fbiTXU90wIV1
	6/H4GJ600sI=; b=b2N59bkIkTmdC4OMvhpYGkRinXc2vHCguGx++S2Rq+bzZqEt
	o9faa2E77ky0rfrtbqLp0XaeD4QQ24QWJb/20jaaRfZERV/F8+Baoij1GFeREwy+
	ZUpCD7nOMNTf54gbrmcBOroeAqE6FDmnfM0s/JQYJfwNuPNuZ4IeYQWRHSLNPljM
	OCbztBMMkecld/aNwHSDoQ2SjFMmHT1i84DX5qhggUI2jmEZERqGdjfNFseZZUKA
	6toJ8hKfLtI94YsKyImoTaw787hyfHNTw17+SnXsqTg1NFajxhJFaKrayrloFp6E
	SDsanAuv2nH4+aJjgsT9mxBgmg2EhKWPOXBHYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1715340268; x=1715426668; bh=nuFi7CGN5ldnkywy7X11fbiTXU90wIV16/H
	4GJ600sI=; b=ZUe+2lx3sy+O5j7jE9vSUPFgz+9CeyUKtYB+24F/ApnC69VoUV5
	fPOmY/duJcgxRUVGZJKRZvY0I/DgZJMk97ta9YdRjw4Wqs5vW9Hp+hq4sLMkG4rA
	Als64Y8QO/Dn1tbCZB/u6Y/2xrQdzqdxsr+Wb58nHU9cIAhpP1Bm/LYU9+th6kin
	KF9pxQIltJ8A4fCqzmmxq9AupZAvNvAwlzAbV8WszG0UeKu2c0iWQ0tBHWCVnEqs
	4Oj5tVy2E1S2vqhkSSFVkocQga0AdC9j1C04qclULjdDzlQ4NHT+x3zQDlC/Qd4V
	o+wRYkSbVH3M2uZmcJjI5RXNB9NbLE9ydYw==
X-ME-Sender: <xms:7AM-ZuVrFir2p1xm5kWclV9SJjEU02W28TczV8nVj1M6_BXlU_CA8w>
    <xme:7AM-ZqnKjWW6MSwoy9-wNarr9Y6SR9-ntClR0Y2V5-F76JBRewnv5Lhbkt2s95UK6
    GntuuaHfol1wLKllQ>
X-ME-Received: <xmr:7AM-ZiZ4n_oSteIDksFnj_DKhcmPk4V0BUKQNpPhNoJ8scJoN1rPe1Lb2ZxPqQpL8SMgyQaFS4Bu5UaTmcdqhK7XgkZg4SHOeMCNcqffdYp95dPeHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7AM-ZlW4w_deuGOd6XK0_RXVvMULpNYdenl8NRGv0wqehHZe1ts50A>
    <xmx:7AM-ZomekTYTLi36-GZECdPOLJu2LSrvtULszO2coKw0VBEQb_HB0w>
    <xmx:7AM-ZqcyooW0d75qXUHZSH855mHQ-dizc4aPCCqmBsjIIKcprYHSIg>
    <xmx:7AM-ZqEsI5a08Vy2jagghhV0iDfW1F3qTBRO2-PMI8N7IBN6eqO_Yg>
    <xmx:7AM-ZkuZVwpPQKZBx4MF7CfQpv5x5gNeXstI4_HnfRDCZkddX_hIiCQY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:24:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 48405bbf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:24:12 +0000 (UTC)
Date: Fri, 10 May 2024 13:24:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/21] builtin/config: remove global state
Message-ID: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wd9neV6lnsTfe23Z"
Content-Disposition: inline


--Wd9neV6lnsTfe23Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

we have quite a lot of global state in git-config(1). For one, this
global state is used to track options passed by the user. And second,
there is a lot of global state that is really only used to pass data
between caller and callbacks.

This global state makes it quite hard to understand interactions at
times. This only became harder now with the introduction of subcommands,
where a whole lot less of the global state is even relevant in the first
place. As an example, this global state has made it quite easy for a bug
to sneak into the new subcommands where `check_write()` was called
before the global data it access is initialized (see patch 6).

This patch series refactors the code such that we have no more global
state in "builtin/config.c". It's rather long, but most of the patches
are really quite trivial and only move code around. So overall, I think
it shouldn't be too bad to review this. But please, let me know if you
disagree and I'll happily split this series into two.

The patch series depends on 7b91d310ce (builtin/config: display
subcommand help, 2024-05-06).

Thanks!

Patrick

Patrick Steinhardt (21):
  builtin/config: stop printing full usage on misuse
  builtin/config: move legacy mode into its own function
  builtin/config: move subcommand options into `cmd_config()`
  builtin/config: move legacy options into `cmd_config()`
  builtin/config: move actions into `cmd_config_actions()`
  builtin/config: check for writeability after source is set up
  config: make the config source const
  builtin/config: refactor functions to have common exit paths
  builtin/config: move location options into local variables
  builtin/config: move display options into local variables
  builtin/config: move type options into display options
  builtin/config: move default value into display options
  builtin/config: move `respect_includes_opt` into location options
  builtin/config: convert `do_not_match` to a local variable
  builtin/config: convert `value_pattern` to a local variable
  builtin/config: convert `regexp` to a local variable
  builtin/config: convert `key_regexp` to a local variable
  builtin/config: convert `key` to a local variable
  builtin/config: track "fixed value" option via flags only
  builtin/config: convert flags to a local variable
  builtin/config: pass data between callbacks via local variables

 builtin/config.c  | 964 +++++++++++++++++++++++++---------------------
 config.c          |   4 +-
 config.h          |   2 +-
 t/t1300-config.sh |   9 +-
 4 files changed, 546 insertions(+), 433 deletions(-)

--=20
2.45.GIT


--Wd9neV6lnsTfe23Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+A+YACgkQVbJhu7ck
PpTyWw//RyAu20VJKsVkTAhDHdVwbHeDenhywF2/JSSrqSwV/gIxWwtViTbU9Fii
xFV7SZ7baxkLqg9KLuxgHgCVu+iHn6a+DwqUTvo3mlEHTfoDLdoKco7Th6DnPbYu
0bSUxop+0CFWSDUJ9p8Qxiv1yGyUdQ5LPErealX5dmO0F2Uvpz5hdDBcAdTT3UCz
bMD54kWW0ZbDeA+8Qd78tNCgy/hYQJfLucrZ0gaQ+QphzlLEe/a8Rlzsfg6bjnMc
/6Dlbm6kOt8SkDQEKSLWTYqRN2OvebzvEp1+T4Uou5/qm46gomx2KPA6p876ozfM
pkNd62TIzkP8VcmQCPH7j1UaIuLearwT+aMtptM41suGJnOdi4tCbAgkaBL63HG8
t4W2pzAzJasDJmqR1neUc30xoVcc36XsNTdH3ilmK8PjszcxO7dpZuToc7W9AzT5
4KTcdzVyoKGCiH+shbki/MuHupcoEcCfQyrYAH3lGuk+YiBz5d+7uFGM3VDtpGU5
+8HazKMWV8AlMvC9MDuqkzKVWtyTf7W7ajwWZLBw1zsHwe/HmFv3pKgn0E9Gv8yO
dqqqe8DvIFMYg+dJqvuhj+hARw+rfo1/fgdR20NistMGNQbzB4QrL08BPA0guYZ8
iKwdqMm0bQhAcEW3Asi9FUM33VFG1IGKfzk/w4x6mYwkV0zxOAg=
=cccq
-----END PGP SIGNATURE-----

--Wd9neV6lnsTfe23Z--
