Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9B3C470
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660802; cv=none; b=FywS8GMpV9oOQt/YSs2FfNY9Od2ExvoDKDoXMWD2sN9JymgKZLV1W7l/nWADSLx50Cr4RtLNUcOSgt0qbYidUs4tvBEvH4syJv4nDhf/yzkXFf76QwWCa9P9VHty3cajZxI7NJz3fmrmw8e6IfErF1WTKZ895dfWfm9hGmCrwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660802; c=relaxed/simple;
	bh=n3gYA0yCi9v/AdMhnU1FMebqiOLuiI0+KwZ3mBbwqck=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O+qGHlQGkXY4tnvletp4C40yzC2o0BTzzxH76SXflJ68TUKMaJs4BZx1JnlDQitAr7REaHSuw7sR4JFcXRv6qXW8kcezLXKEWnsz3Ix5nWFvHxBU8Ldfs665NflLcm3TIl5VUUf1TAZq9c7JGE8BKbGcjk8nKNdCKrXPu/7SdM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sFVO3PE+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OAy+mS5P; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sFVO3PE+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OAy+mS5P"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 2EBFD3200AE6
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 05:39:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 19 Jan 2024 05:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1705660798; x=1705747198; bh=OoLW7RPnLmgIEIZ2Dj6LhXbtD7SwTctu
	ZpqTWo/hZSQ=; b=sFVO3PE+CbGFjtZlw4UwSoObfcmZh4o0rkR4EgkwuXU3tUVk
	mZaea/5k9qBt3d8748lRmRw8o/Hzsa/xJT4KiPWi4NlIoWchcyxbw92BFYP66z4H
	jizO/meI/PxWt9W75pCyTh3ngKNOBTs9Grn8uuJRuceR7CS9y9AmDFohaxbrl9tm
	Il7y3KjzR5FWwjrF4bxRXEY8xTISkRHIQi5uyjCMDbmJYW+j36BLTxZ428vdV5rN
	/RRgEo/cQ88I+A5dhi5OUrjb++90HQPD2LnbIqN3D0xxKP7bIPsDuPDrMqU7KhgC
	GdvvYV4oBMtSeB5/Ikxn1xcvWyM+PLDV9SSxkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1705660798; x=1705747198; bh=OoLW7RPnLmgIEIZ2Dj6LhXbtD7SwTctuZpq
	TWo/hZSQ=; b=OAy+mS5P4e+9ZaUBMzHp8EiENgxRrAiHPlnfpY4xvai4JDwSgen
	wcTEQx05kg/8p2jhwC9opXjcYq0h4t9gehcP17hZdzE/ZaZBCWnHyKzZbdyHVxYr
	KrSNyhltaH6F2KYkZSFOl9gspd8hvZIDu/c/2nqXhqceetv77FiMJdwNt6uhpC80
	iiX0+sewqWqZ/eSlXySkpzbkIOxpTrdk6aTqpFsd6P0GJyuIfQLkpypWAY6RoKhS
	cuZAQDpB0F/DBMUYlTm+5hV+NK63ejdJjh6efjIs5e1gvB2jVxLsmGvx35WylbXF
	YMTfo/lWhmBIljmNo/9R1ikEec/WdzF0O4A==
X-ME-Sender: <xms:flGqZeB8vmd6ZKTcZK-nMfZFguQ2C46wxpA1M0YkNWhltUHDG_zoBg>
    <xme:flGqZYiHwvafKsTcZntUQUUxN-a1McscsxYoJD0b_4Hfe_t7HeWb-Zk9oOY7VzJ8X
    xuec58azkd3CWrTmQ>
X-ME-Received: <xmr:flGqZRk9WK_3WuDwKfzMfSEvTAmCLZ8V7dZRQe7mvgRYo8zXW0zWnsToGyjbTiQ2I87AUs0mH0mhbxSVFRqarLhOMhVLoIwuC3KIh305RZKWpzcQhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnheptdevgfelleeiteeggefgvdevgfekleevieffle
    egudffffevieehledtgeevuedtnecuffhomhgrihhnpehpuhgslhhitgdqihhnsghogidr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hpshesphhkshdrihhm
X-ME-Proxy: <xmx:flGqZczlZTU92bIHS4qetk6EHvdhTr1CydVR02cye6M5SkinupIJsQ>
    <xmx:flGqZTTkK0U6AC6KF5Pj7Zzs2bBn64e4uchV8FIbqEb9hzJKNl3NOA>
    <xmx:flGqZXZ-jdtAok6oqk1TdmNwjPaDp1Ixxtwc-qi-DuWGrvjolOvb1Q>
    <xmx:flGqZWMjrR8wjHa5mYVO5MbKDMuaJfGDLtEdHxYyySXQGvn-XAO8lQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Jan 2024 05:39:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d530880b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Jan 2024 10:36:58 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:39:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/7] refs: convert special refs to become normal pseudo-refs
Message-ID: <cover.1705659748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PjIiHQ87bkIhr0R3"
Content-Disposition: inline


--PjIiHQ87bkIhr0R3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series is a follow-up to the one that introduced
`is_special_ref()` [1]. Back then, we agreed that the list of special
refs ought to shrink over time [2] so that only the actually-special
refs FETCH_HEAD and MERGE_HEAD remain, which is exactly what I'm doing
now.

Patrick

[1]: https://public-inbox.org/git/cover.1701243201.git.ps@pks.im/
[2]: https://public-inbox.org/git/ZXlfeWtDgr1GQFCL@tanuki/

Patrick Steinhardt (7):
  sequencer: clean up pseudo refs with REF_NO_DEREF
  sequencer: delete REBASE_HEAD in correct repo when picking commits
  refs: convert AUTO_MERGE to become a normal pseudo-ref
  sequencer: introduce functions to handle autostashes via refs
  refs: convert MERGE_AUTOSTASH to become a normal pseudo-ref
  refs: redefine special refs
  Documentation: add "special refs" to the glossary

 Documentation/glossary-content.txt | 14 +++++
 branch.c                           |  5 +-
 builtin/commit.c                   |  2 +-
 builtin/merge.c                    | 27 ++++-----
 builtin/rebase.c                   |  2 +-
 merge-ort.c                        | 19 +++---
 path.c                             |  2 -
 path.h                             |  2 -
 refs.c                             | 35 +++--------
 repository.c                       |  2 -
 repository.h                       |  2 -
 sequencer.c                        | 95 ++++++++++++++++++++++++------
 sequencer.h                        |  3 +
 13 files changed, 132 insertions(+), 78 deletions(-)


base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
--=20
2.43.GIT


--PjIiHQ87bkIhr0R3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqUXkACgkQVbJhu7ck
PpT8sg/+LBdJ/PfRGyNhWXQcU7LiwYQdfBVekywNtvz+q1i3uxg1tARcRoyGcytp
GZeX3OodjqmestiZAimXS8ESzOJPK/w2UlSb5IA5UvtWY1sNow3jhbG1JsxhpR06
R6FY9/hTJghoiUrwlhVXN1dY36UyVmSY8/sSORwLnq7R9MGzsYBlR6iutLpIGSoD
mqQDv9xrCpQr0088iid5tcrbrdUus5Bq3A1fa3e6e1T/fovvGj4ZMvOOe3hdC8hy
3EEwwu0omyM9NlMtQz12dAdywQ11LENQP6++N7swQ59m0L4be25XqjNAwTbhZs9x
xUo6fS5e6jur5QTVu/Qj7I9rQvkH3ozoekJ0EesoJR+5UP5SzdZqYL96qBeli9WP
yJ3dtDtqkkOG3C8F4pfQ6uQC5b1WkpXnsqdkZL/tL3lmyCh791FagVb8aWzrawih
DyPnapIrDcZW3LEF1kyiYugR+U1AcT3C+NdJx7ju+GyEQ14UkecBUQMHOuQNpb0p
2gXx26neZiSWMA5TVrjptWvbQfO2318fr110CJKPjxChKsuxSHz1xTV7xIqQ6a7m
horvre09mRWGxxbF1JRnU+X901TsGSjQzaZ4mDUsRZsaxBC/YtLfiIj28U2c5L1R
Xr4xQnY/payvm9G5Hug10LHZfpvc5hwpv586uM/hRzCdEjukDrE=
=NEU8
-----END PGP SIGNATURE-----

--PjIiHQ87bkIhr0R3--
