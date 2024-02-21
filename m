Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADF3D0DA
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509398; cv=none; b=CEoQAlZGW71GE+kB6Gb1Wov06CYYWfm1V23cdC2dhziEXTcixUz8ocuywA9lZ/0JDGnn8w+bKC1ndubWvQ+wLx02qyxSdCIjvXOTx5q6UaJZQ3e5sB3UprJEP4QwkWlSK4AFGe9rfLbXvWVKA/D0rKkYUgcXqgaKb6C23zTxs5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509398; c=relaxed/simple;
	bh=2m95oiCsu1rJrSo9ixNUnC/dItc58wHrFz+4D98qLIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ7FfMRpPG/SVNckQN0mOBDCXgwfV6hycKK2h3E7w1LmfCOpwaXubQ1u5Il/iomfiASRmTYdxXgj7vX/EsYjhFgu1p3CZRrcbybK3wiVLJfVBdp5ikdevzo8WRePSsNpCr3+FTVwAVHMmC8FkWZYtKsWVOhNZ+jXy7/sqJ19iLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RDQVcaSi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Shx8Ggkm; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RDQVcaSi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Shx8Ggkm"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id AA67013800BD;
	Wed, 21 Feb 2024 04:56:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 21 Feb 2024 04:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708509395; x=1708595795; bh=+HkP8swKF2
	OW+8Jk+AZj4WAyMybzJFPqsdMt+hYccwU=; b=RDQVcaSibFneI2+2kqUqEJHt53
	1DWmuCFKkbAuQWpKvjP6jxotgzdT4JVIikWC6zZcxCFR3LeULmmXPXmIlhuUpofR
	SPUaNJG9ANV9yZE5sHWg0LhUEmWLa9rfbag6YtEYYjiAZqDOr+1NQORBHLg0uwuW
	6/DPZeQKpeakx8lC8dwEo5Yov2qe4RPWTqIGrBNbgpjo3VuLoErjMNfpupGpObUj
	CuhXL6pscFLuDzYqnDNo7hkeM9ter6KiDGXFyal9/6Tj7SLBjmnDxYD2C1gPaLh0
	nPx9Ahbj7fD2a7qaV+KlBHPeBiffRCbmWU0JKY+MJj4v67ZNOJWMuqOyUFRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708509395; x=1708595795; bh=+HkP8swKF2OW+8Jk+AZj4WAyMybz
	JFPqsdMt+hYccwU=; b=Shx8Ggkmlk33cBu7pn3pf10eoruXhAEy86ATGtSCcCZg
	GGVu0bsyyxvsTJv+MR3h1BISWcwlepNVklityeqaWBhiOn2FKGM7YtT4qfAe2rId
	05x4eXCwq/IyYgogqUz4ASPqfr8AS5BrGmtMlSPXq8M9eKoIQXhclsqbfQo8gN0L
	99zJRUz8mItyWGvQycfgrvGw27fKBtkqbE1svGyJp2hqhuMOuq1Ta5gjvJAS6C/M
	SRz0XEt/3bNmDjAx7SJ34+wCwX099crOQLgT3CLuDoZMRzraqjqJtK3dZFGGkS8A
	zu5Gp2CM6ehE16A3ucjwYbaCYx2v0hJtIz1huHQBeA==
X-ME-Sender: <xms:08jVZa-i7cwdDUKmNyJlaTJ9RN6Ub8SgbfcjplmDc9KGH9pb9Hx-Ag>
    <xme:08jVZauaocSmtNnvRCPXZRszKP3AE05aBXO2bHMIKw1S5GVM_0yerRbZri-rARpK5
    IrjJ9CarPW2ZLvEzw>
X-ME-Received: <xmr:08jVZQDVyMDAi_v4XhUo1GQdn6GnWQJwHo5sYbUsoBoFc47l3Jcw0Ja3-MsvPsNaPoNq7T_F-trVHXhZlJoOdjGHJRtcQrKiDLmzo-6uHahu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:08jVZScdxCU6IzHtjaOGamdGFR0BvesmVNDDqo6WTJAOILiNqGeClQ>
    <xmx:08jVZfM36TT7eWdjv4tHzFp6miXTtEkv2YdgYrGgr93cxLg5c29Tbg>
    <xmx:08jVZcnAe95hSejYx0kAVi-PyIDgUtvv79DdNce-BAj-sQQHRkmL0A>
    <xmx:08jVZYYwums4lhwUfyWd-BRFbKldyvIZqBqBgOgZ3pZ9i44RYclUeA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 04:56:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c30942e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 09:52:30 +0000 (UTC)
Date: Wed, 21 Feb 2024 10:56:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Yasushi SHOJI <yasushi.shoji@gmail.com>
Subject: [PATCH 0/2] Detect empty or missing reflogs with `ref@{0}`
Message-ID: <cover.1708509190.git.ps@pks.im>
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+mNAl+H7j49VLVzv"
Content-Disposition: inline
In-Reply-To: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>


--+mNAl+H7j49VLVzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series addresses some shortcomings when parsing `ref@{n}`
syntax via `read_ref_at()` when the reflog is missing or empty:

  - First, as reported by Yasushi, git-show-branch(1) would segfault
    because the function does not report when the 0th entry wasn't
    found.

  - Second, `ref@{0}` would fall back to return the object ID of ref
    itself in case the reflog is empty or missing. This behaviour is
    quite confusing and only works by chance.

The series addresses both of these issues by detecting and reporting the
case where the reflog is empty or missing.

Patrick

Patrick Steinhardt (2):
  object-name: detect and report empty reflogs
  builtin/show-branch: detect empty reflogs

 builtin/show-branch.c          |  2 ++
 object-name.c                  | 10 ++++++----
 refs.c                         |  3 ++-
 t/t1506-rev-parse-diagnosis.sh |  8 ++++++++
 t/t1508-at-combinations.sh     | 29 +++++++++++++++++++++++++----
 t/t3202-show-branch.sh         | 25 +++++++++++++++++++++++++
 6 files changed, 68 insertions(+), 9 deletions(-)

--=20
2.44.0-rc1


--+mNAl+H7j49VLVzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXVyM8ACgkQVbJhu7ck
PpShDg/+OEiYVQpw36YryWsrSSGk8vXoXqB0gX62zgDqCEpRyEeP/rUz2X6slKwq
LzRRBJOywASnCRn10nYRFMMrVS0DC8lmZZiUQmu33sfVn1nj5ncVFNlEA2tFanGH
ZavkV0vr67qOwbmbEZU34foHi4H61hcGoADgfnEywQfgnBYL5Cm9K4shY8etuOng
Dt5MvQxA1WtcwcwarjlOljXj//oPbwLul64TWDRz6rTqf0TCmiuoWuMvSdEtBjKc
FOl9Qt8Uamamk/mIg0YGgF6DP81r4lCp9xDPqhG0fOpTCgNiiX8jl8aoghVLucba
1oKKLHCmThMWKRbmVPcE8PEPxwP9bGSPbXC7cU56NftiXyfE7TzbztGuKcbrHAbG
87NrS1nLiVYqJQrey47zErec/N26Az+M//QSP8PJsLcTsdgtBUMdKx0GIGJ8UYGW
nDR/CsSRRt+bggionf2WF29jC2xPvSx+HVsNp7nN3IEGWSZU4vNLw5409IjN5o+K
b0FLB10frCKPrNqRuaFkuoeaQEP3wg6Q75FvBDW62DoRRLTCp0Ay5hqzM9Vv4JJz
VTeUGEB514Hbr3iu+RVRWFlSjyIh0VUlxr2U/ak6LrJkX22mQD5Rka31nK+Pi6dx
GnRwApPmYODQjYlPHmz15dhWIIbfJ8XZ/Xp1EWiSCIgi+1lfVSM=
=m5eg
-----END PGP SIGNATURE-----

--+mNAl+H7j49VLVzv--
