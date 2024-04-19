Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47527BB01
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520271; cv=none; b=tA6DKip9RQpk5IFLDjIWJTLmKLpTtRlQUe8V4+ATR89ABQcGdVQFoRo2oHcN5c31UGa8rUlc5UQIMNdP84N1LZGblh2zwEzBe77PQrUfFucmxNQDuSl0gDy/Gq6c1XjarBTVn0Ulth8ga7XAFZTYQqsvHKUHuVPniFLq4u7fsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520271; c=relaxed/simple;
	bh=Whv8bQHUjQCVH4PimFoJmtw2SKoJVe6UfQUKs1XOMWA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cEv2V3k+6HZCZQJRin8hD5g+JYD0QfU2C/J8WKlFdMVL1n9mv6wJNS37AFDyrDuHZuaDLv47+cnyqQI4heqmStKk36swhpgktn9qFOrEfm58wlgSPVjPI7Q2Vrt21HTlCJ1JdJitl79Q+UI0ztEWl6YZqPmWKLc4g/EoNzcnNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=diMqhVtR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ihl7TuRv; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="diMqhVtR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ihl7TuRv"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 25AD01C00142
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 19 Apr 2024 05:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1713520268; x=1713606668; bh=G4OajWLufntqnWQKsXwce6R48Xcll55B
	9/zuAYO1lC8=; b=diMqhVtRhhsWDZgSIRoyp7xAE2PducLZwqYm8qO2nJXxkxQN
	YtwzoNUPM6P6jmcQvumzglJBEiaS1Qdd54h0yTQQCWbUwHbF6yA/vSn4BWsQ5emj
	P1SF3QSEmzmZ8ao/yMJVZAWyDo7WulLYI7GT03tYo68t7Ttp8tbf/FfudTejLOGJ
	CPYljPGcXBBn/YEjugqRoHQLb0Oa/Ih+c2jBCd9zUVDBQSxDkhSvhSmaDgzzX5S0
	Fz0HsHBU/s/jIB6ARAqccrzHR6EZWoc8p+G+TBHHd1qcWThZlZUu9wgge5rIBy6j
	JN6160UbSWE8fp+zkaNmN//YCAK+vN9GhhXapQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1713520268; x=1713606668; bh=G4OajWLufntqnWQKsXwce6R48Xcll55B9/z
	uAYO1lC8=; b=ihl7TuRvIeZRxOMVEtOWSomwDXnAxDZUX3NPqK1wNSuhKFW3R6/
	jeuwRc0cNEwu2cSU9Wfa0ZpTxPHzyJfSiTX9wOwbYkTxrEvOb8C6/2mkF3NcETtP
	a+5mgimwd0227Hzb+E0OfeYGcCd0z66K1ci1iZjhPsq1QY7yOBVylp0aBOSg1eRL
	KNglnGlmiRCwYhlkUIuqwqcScC5llYwBnPMB6GGlldSuHeCcK1enHPCLTfR5+Sg/
	ezAxdZd0FlmJ0Tg01NVvO8w3w3+8keAwsAPk/r+qY2wt+4War7FDg6+LpPYY5myL
	B1kEudFukKQZE14q1YOleH9EJH3upYMNkcw==
X-ME-Sender: <xms:jD4iZhju8Oh-ZuEDyjSZ9uKJMnuK2bDRyaAMIP0ivkzeb4oCBlakVw>
    <xme:jD4iZmAMlTqofAf8DAPKDIVg15f_NfYBrKTwp3xqA2XTjaQH_YIaPCrVunx9Q-DBc
    mqHsTjv9MhIekSQAQ>
X-ME-Received: <xmr:jD4iZhHddHob7uTTjZaxmAaTxNX0NTw6bG2F_j5DXOENt-Q7QgaRjvRfjhRG1v_ZZx3lehOzcBvEylsEGSxIGclQ_MeNTdkqGtKpIu9NXceDGP5BaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepleehfeegieeuudegfeffhfejtdeukeduieeuud
    eivdetueeitdekffefffetteejnecuffhomhgrihhnpehhthhtphdqfhgvthgthhdqughu
    mhgsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:jD4iZmTS7vDtPsae1k8Y4UQdowwsI7NLb9lYXAlAAYsM0KKLSungVw>
    <xmx:jD4iZuwwKQ-4bV0JUWDcDDdbUyuWSB2EajMXteeMgRzCELWXvF_WcA>
    <xmx:jD4iZs549LgbQV8iFu8P7kDP_SeXGeqQSFa5YP1YeXIqGOu9FFJDAw>
    <xmx:jD4iZjwVJtkITeS2XtT1xENB5wd-_EdB8OlBiU2FcjSbNPBoJeuLeQ>
    <xmx:jD4iZjpGQAP4PRziBdWVgt2ntxxQQxa0ItF3jnnTaS7hFwNY7Ya-BhtE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 41d0032f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Apr 2024 09:50:39 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:51:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/11] Stop relying on SHA1 fallback for `the_hash_algo`
Message-ID: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hdlsv7kh9xdpDdRA"
Content-Disposition: inline


--Hdlsv7kh9xdpDdRA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

when starting up, Git will initialize `the_repository` by calling
`initialize_the_repository()`. Part of this is also that we set the hash
algo of `the_repository` to SHA1, which implicitly sets `the_hash_algo`
because it is a macro expanding to `the_repository->hash_algo`.

Usually, we eventually set up the correct hash algorithm here once we
have properly set up `the_repository` via `setup_git_directory()`. But
in some commands we actually don't require a Git repository, and thus we
will leave the SHA1 hash algorithm in place.

This has led to some subtle bugs when the context really asks for a
SHA256 repository, which this patch series corrects for most of the
part. Some commands need further work, like for example git-diff(1),
where the user might want to have the ability to pick a hash function
when run outside of a repository.

Ultimately, the last patch then drops the setup of the fallback hash
algorithm completely. This will cause `the_hash_algo` to be a `NULL`
pointer unless explicitly configured, and thus we now start to crash
when it gets accessed without doing so beforehand. This is a rather
risky thing to do, but it does catch bugs where we might otherwise
accidentally do the wrong thing. And even though I think it is the right
thing to do even conceptually, I'd be okay to drop it if folks think
that the risk is not worth it.

Patrick

Patrick Steinhardt (11):
  path: harden validation of HEAD with non-standard hashes
  parse-options-cb: only abbreviate hashes when hash algo is known
  attr: don't recompute default attribute source
  attr: fix BUG() when parsing attrs outside of repo
  remote-curl: fix parsing of detached SHA256 heads
  builtin/rev-parse: allow shortening to more than 40 hex characters
  builtin/blame: don't access potentially unitialized `the_hash_algo`
  builtin/bundle: abort "verify" early when there is no repository
  builtin/diff: explicitly set hash algo when there is no repo
  builtin/shortlog: don't set up revisions without repo
  repository: stop setting SHA1 as the default object hash

 attr.c                     | 31 ++++++++++++++++++++++---------
 builtin/blame.c            |  5 ++---
 builtin/bundle.c           |  5 +++++
 builtin/diff.c             |  9 +++++++++
 builtin/rev-parse.c        |  5 ++---
 builtin/shortlog.c         |  2 +-
 parse-options-cb.c         |  3 ++-
 path.c                     |  2 +-
 remote-curl.c              | 19 ++++++++++++++++++-
 repository.c               |  2 --
 t/t0003-attributes.sh      | 15 +++++++++++++++
 t/t0040-parse-options.sh   | 17 +++++++++++++++++
 t/t1500-rev-parse.sh       |  6 ++++++
 t/t5550-http-fetch-dumb.sh | 15 +++++++++++++++
 14 files changed, 115 insertions(+), 21 deletions(-)

--=20
2.44.GIT


--Hdlsv7kh9xdpDdRA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPoYACgkQVbJhu7ck
PpQZew/9G7/MlHWQ/1JiM54FVBwWSLY9pUQAjf38IavkVdpQGTXYVpYuDlhu2/C2
amOItPBB+2kQEEniyrvDxq9je0LKAHqvGzsJOGoBpggywySqlLjwfC0BOi0dtdu9
lg/fBGyfUuvMnTbDhcA2uwiN2EmhtnmgWBlzsresglFyTDyWiuEOvhwdJpfW2NmF
QyRGeH8MtIonItN31xeyi+t8pgnmIdcqN83e/MEK33jPhxGMWaR+8pHIkxv8HAb7
YS9GARnCurE2w+14uHBOS4DhP2RT2xzva2cZTBmuLut0dXMi+q3U2PogXzdrs+bU
20VdSjp6b8F/RNsDBybZ5BDZ042p1FEH7H5QMr83pKmKfhbeVEFn0eCImcziyVjn
UBen/1wGLTZU8BjFLBIfZ1Ac7q0/tCnLzVZGbOLxwXFc8tjtQSTrleLcU5z0+Bcw
7/Sh3N2qaS12Ka2/y5nBIb9sCF1LRjhB/VNJu3R3syb3Auuyi8Wfw3rtunzklDLA
5NMT+dhbl3XkXsKi0RwDcK9w+s3EKnnFJhc99w+e3pRlwawk78lGelWeAuwHo8F4
tYczzhrNJJG5FNUO+ZNEH7RfslGObqq49ZE8Cj6spV2BF671z2nrnq/lDYwVh2gj
8yg96VBHCh/REyWFnpMsvKoO6B2oT6Up8pi0Mpv3eDQwcYfkg1M=
=yJYR
-----END PGP SIGNATURE-----

--Hdlsv7kh9xdpDdRA--
