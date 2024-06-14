Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10832145B34
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347359; cv=none; b=WKLpvrGytP9KogQ5aCaM1OlqiPUwymlGD/ozxHBqSAvu8zx23Qu96nHAwfCsEqeSiTmGlKNOeqEpGu4yle33XAcVuEeCeFFNgNxF5opRYe6Ydj4vL2FJ6YMDCJ6CsVKfYqRNsrpKDpm3Ug2lnCOm1tH7dr+uoowDL3hvHE8ySUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347359; c=relaxed/simple;
	bh=qt/aFgrHDJwsyjrLPzXJO1x5NnVCWx1dQbwOWMH5Jwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tww/JIwBO213gE18UnSKd9hh3JpqEfhBQgzR6p3rIoPOMPExXhbJfi4DSNyOXGxfCG0aovPhpBFqiuW5/RmDmwbPUoDo7KeLtBPVkKScdVD2ThMw3W6eNlG6VsvJFc/7/2VyWlLCMdNYBUxBqvIfRzCYf4fmJgQSWeyX6eL+SGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MVwjzQgT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c7k5WPes; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MVwjzQgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c7k5WPes"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0567911401C5;
	Fri, 14 Jun 2024 02:42:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 14 Jun 2024 02:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347357; x=1718433757; bh=6CaQYsKSPT
	DPvIFOfDyg4pduqC4EYTNMWjvQ3d0N9LU=; b=MVwjzQgTmD91e2h3PvMzNIanbC
	gVUOcOePKK5J/i89Jf5CnSZT9nEZNKzujWF4yfFaMorvNA7NQcPx949wPTuNrgOs
	96xz0psTIqz6dzZcw6vgUMZdkrwnVaOIBC85l8JJOVHvi07oNQkWJa2iXR6X8Ocu
	mvEzWUXSssatU0mkbw++j1JkxtrRWj7QpqwE9ko08vWJSxkXEYZuSzh51zuOQTRf
	Mt96Uc4dk58lHl6uX16k2LKKkKwYAjISa0lglS9AyJGZAyCPRwPKrVnT696H/L3m
	iaGFrhZU8OVGrC3o5uhfGyRBE+QG39uAytWibTTyKZTxxUtKtIiyqCCk/xVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347357; x=1718433757; bh=6CaQYsKSPTDPvIFOfDyg4pduqC4E
	YTNMWjvQ3d0N9LU=; b=c7k5WPesVXwTGaMrspSooBVKfRXe13gi4rmHeLneEPzm
	9wXqMP4wpSCmqgt3zmQQ2vjqHzMdjwa6Vgf7/SuFELpAbQwTnG4Ap/k6/ApqRDNv
	0FS2cXrwvgkkPcpw8mHTZih9i0zmf07HMcpsKmUNL0t+jvhkaE8V7AXvvlXihWFH
	1MGyot1wlhGF+c6jl4eNj8ToU7BkOfRu3ZaysI9GcDPD2dJc66sRcyuiubLKPuzt
	jR1pmLT88tzVV9OXHFd5+8RO2fAEqzm67rHBubaNVagw7cgMHHlss/uG5LvO8Isq
	ojKbuK1rLnC9jzlqQ/vqkbAACF3QI9ZqwIFh1uTcXA==
X-ME-Sender: <xms:XOZrZknSTxy9hdn7Wxcw0DNr5w1CKpWjqI3EkjBdoEY0IQ6i2Q6mJA>
    <xme:XOZrZj07LDaROSQjvjORJ1AV1MDpJeon5FpP_TfqZfoId--sof-rB_GJCFIo4IH2-
    fDqcWYgmPoZHIYcjQ>
X-ME-Received: <xmr:XOZrZipfqkfyeEaNJfoQQGdFdxo_KSclCY4MV5XYdxN_Chw86N0zTVOkOTkduf2UJVaSW0zMT79DAENEwKDJcHYefypeHpbQJaEmSRHmeeWKeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:XOZrZgmtpQAxkAKkQ2hV8ZETyXNxeB11SVfCQ7sfoFLDrkwDYWb7Mg>
    <xmx:XOZrZi2HkK4tYW0fiHni2guYJgY_GAm5ts_3dIafbUw0D76mKSwuWw>
    <xmx:XOZrZnuYXlFxu192qPY0ou0eVzXZRk9FCFOwq_BsPKmFnSHYSIOeTg>
    <xmx:XOZrZuX_RlBQaA4MR4z37paxpqk8PfZaao_lZvl18pIaClSyThY4Jw>
    <xmx:XOZrZjJmt51bVask_zY08aV6frDcVPLzTLEwVVjA_HEqF8pmiq5xRYuT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:42:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 15f35879 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:42:17 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:42:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v7 0/4] docs: document upcoming breaking changes
Message-ID: <cover.1718345026.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QBYSp545e8Ev2TZa"
Content-Disposition: inline
In-Reply-To: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>


--QBYSp545e8Ev2TZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is another and hopefully the last version of this patch series that
starts to document upcoming breaking changes in Git.

Changes compared to v6:

  - Fix a typo in the third commit.

  - Document the version number schema and when we bump which part of
    our version, including historical 1.x days.

  - Drop the wrong remark that Git 1.6 should've been 2.0.

Thanks!

Patrick

Patrick Steinhardt (4):
  docs: introduce document to announce breaking changes
  BreakingChanges: document upcoming change from "sha1" to "sha256"
  BreakingChanges: document removal of grafting
  BreakingChanges: document that we do not plan to deprecate
    git-checkout

 Documentation/BreakingChanges.txt | 135 ++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/BreakingChanges.txt

Range-diff against v6:
1:  a260bbf281 ! 1:  6348f27b59 docs: introduce document to announce breaki=
ng changes
    @@ Documentation/BreakingChanges.txt (new)
     +The Git project irregularly releases breaking versions that deliberat=
ely break
     +backwards compatibility with older versions. This is done to ensure t=
hat Git
     +remains relevant, safe and maintainable going forward. The release ca=
dence of
    -+breaking versions is typically measured in multiple years. The last b=
reaking
    -+releases were:
    ++breaking versions is typically measured in multiple years. We had the=
 following
    ++major breaking releases in the past:
     +
    -+* Git 1.6, released in August 2008. In retrospect, this release shoul=
d likely
    -+  have bumped the major version.
    ++* Git 1.6.0, released in August 2008.
     +* Git 2.0, released in May 2014.
     +
    ++We use <major>.<minor> release numbers these days, starting from Git =
2.0. For
    ++future releases, our plan is to increment <major> in the release numb=
er when we
    ++make the next breaking release. Before Git 2.0, the release numbers w=
ere
    ++1.<major>.<minor> with the intention to increment <major> for "usual"=
 breaking
    ++releases, reserving the jump to Git 2.0 for really large backward-com=
patibility
    ++breaking changes.
    ++
     +The intent of this document is to track upcoming deprecations for fut=
ure
     +breaking releases. Furthermore, this document also tracks what will _=
not_ be
     +deprecated. This is done such that the outcome of discussions documen=
t both
2:  f7c6a66f71 =3D 2:  d0ec38a25a BreakingChanges: document upcoming change=
 from "sha1" to "sha256"
3:  b25b91a5e7 ! 3:  deee0bbf66 BreakingChanges: document removal of grafti=
ng
    @@ Documentation/BreakingChanges.txt: Cf. <2f5de416-04ba-c23d-1e0b-83bb=
655829a7@zom
     +* Support for grafting commits has long been superseded by git-replac=
e(1).
     +  Grafts are inferior to replacement refs:
     ++
    -+  ** Grafts are a local-only mechanism and cannot be shared across re=
ositories.
    ++  ** Grafts are a local-only mechanism and cannot be shared across
    ++     repositories.
     +  ** Grafts can lead to hard-to-diagnose problems when transferring o=
bjects
     +     between repositories.
     ++
4:  4fafccc3b9 =3D 4:  25b20bb0ca BreakingChanges: document that we do not =
plan to deprecate git-checkout
--=20
2.45.2.457.g8d94cfb545.dirty


--QBYSp545e8Ev2TZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr5lUACgkQVbJhu7ck
PpTkCBAAh3ydtIdgEqjT3pDhBGRHBOeLrcJ0uB3sDhF4baibv8y89NuS9pXy3h4w
6Z60hETlwwT+lXt5tsU621UvYPitVVcGcsOOFZsr2tij3iWNtr+NRFV8prNQI/cc
DAcJ2JtakwC8BnBGaC+BSs1RcFOoMF6iW17jO3lfyHO2kA90s3mHQwTLQVM0IgOs
pNJ1WrsOGYRqoON5nOtI7slqQRWddWuXE4R1ebG6WtguBb7DyJiYq6bp7/orvivC
vW/3nNWKnJydbWkxmV9hBwSHQ2LNY96fTPnusgT28377ZKv5/hhqmQEvaMVEosV+
gKZFdtCqnT4/HiXXaoE5D6wmkMWEH1Q5HvQgHX+A8K50/wUULOhZgJSBg1Oz2ICG
COEPLdmVnI0bulp4Vi1vbkOF4cuoOfjg0ZkRV+BuADu6LNyZOu8a7QjOmL03jyI8
PI1Uoq871o+ATg2px0ITSDqlpLrrMam9/zBGXd9SgLsga6cGzPW0JbNY5bVg4JIA
dU33qOCZxm8KwVnUTs4UwUP39+m7QUEb6U41MypY4JMA6Ag8EDbsR2UXNMbmyDi0
GM/NoFLnKjSzOZI0m+6S3ohIFPKFqxVgk84IMFGP+pYT9Wnr8lxdsWkJJ73/TZWw
pMmVQhvEZJGBlVSog0C1rihfPZXejPwXgMM0QVPWknri1ERn4YQ=
=TIfs
-----END PGP SIGNATURE-----

--QBYSp545e8Ev2TZa--
