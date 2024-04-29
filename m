Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5D1118A
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372457; cv=none; b=CJb1EHSxbKHlgKGdzCX7Ms+jPqC6Qvo3aJFMz/f2jjk0YR/p6HDj0NWpVz6ComUog7f2zUIdmwRiV0r+dO48E93NFQR0xbm5ExRXV59X2X3A+6JSSc0qFGAI2zhQJIUFToO1STS6tQ7pS70oH4I4DKzThcJ1EcNsiuE1rqra170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372457; c=relaxed/simple;
	bh=3BOEtcokFGdtGN6wLvEIY8gD+12qVRFNl7v73Ktl4Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJVmZO1xOzF0+EqkdtsUpFcifDnwxJZHcE99fdOXCAcA/xv0wJ2NVpCD0Avlml7Nrmd7ipAW1jrvC15C8bHXw4qGsa3WathtWWv1662LRvl28fQsmbAk5wcn2VBNEs2E8qhlHyHQcxg1PwZ9ajgzFbdZ2HUKNgr2HCGH6Bm8/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L/lR3N4n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DwhZJP6S; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L/lR3N4n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DwhZJP6S"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8B65011400D9;
	Mon, 29 Apr 2024 02:34:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Apr 2024 02:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372454; x=1714458854; bh=YmiSYdb97J
	f/E6nUSVycfMnFmMZJkB04APS/3AHxmQk=; b=L/lR3N4nhHg24/YiSwJnI5ZWdM
	SrruaJT7FrEj4B7JzISRNuR4bM3Qlal36/CAeD4EVvukl5S4Rs3nH59zOoYE3VmU
	XD8dKms0P6Q4fqEVy8NDmv0tQStR9yaJ1igWQwEVBYG38BnECKbTzaUSuV5qA154
	UyHO01Tl6OOvK0jEUqfAqbIe7nHZbesXRB3q1ofPtfsg4bwCR0MlWW5hAM1L0YXP
	xKB9LwSSxft4H0l06s+r9/6uPhqPkqQCCXuppzc6KcBU66PTL1xWzA89AWqVdSYm
	j3GThcKGDdhzwHgdwyIMbS63pNAFzZKmZB33e4UXekW6uPMAwcOkOLiw4bpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372454; x=1714458854; bh=YmiSYdb97Jf/E6nUSVycfMnFmMZJ
	kB04APS/3AHxmQk=; b=DwhZJP6ShMEvqaWPHfnc1al0jWiRS8tnmDr8zCakesBE
	sUBZeqJiwO/EKUth67fng9rPdj/DEKIkirA0HJoDrbFKxi4KYoD7r1e8bhfa8xAK
	vfP2NaFkebx8j/ENNIja7p0KSob2igtPDSSaHOPsi94QW+XQZY1+cji7pev1rjxW
	XoHEui8uQSCMMSPxJQOGm8m8N6m+uDnCRdM926v9MwA8TbK4lZZI8epDqf2I4am+
	y5/aZsd+TBSK1nNr22DVJzKlqTyydZKFSKwwm1CkzT7/V/63fAr+xfXhJyHm1otQ
	/sDHlOJOQX0e2RC+Z6pVBLHwU8mu79Lr4qSYiyb05g==
X-ME-Sender: <xms:Zj8vZuJgT27ywZDRRlAUVjOsukjdeX-0MjNKEDIh0nNHMPwQ9L6luQ>
    <xme:Zj8vZmJoJd3LXT_rLje5oZjQT7B9CGUU6MPoIVXSC4oZxEWIbvOih1lE1CexmVNDY
    TqUcNLu3gTwEPz2ZQ>
X-ME-Received: <xmr:Zj8vZuvVbfLnJiH9WE-PVKX1lGUI-HUddVs_i6j-0VD2EvkMunhXcuq_GW8Wf-4HDq94lM5ktlNmZo01VrpZPvvOsWVM9KE_OKP8LNSrQg5Apad6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepveeigedvtdeufeetffekkeejueehffdujefhteeuueffheetvedtvdejveekfedv
    necuffhomhgrihhnpehhthhtphdqfhgvthgthhdqughumhgsrdhshhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Zj8vZjajfCp6IhI1mBtove5VYUk5nX6I6wPTfwa3fOGa3DqiT49BuA>
    <xmx:Zj8vZlbGv5fklWLMi-ahj4V2ARlxHgAbGxSVyZ74B5ZPqYLU0AFaqw>
    <xmx:Zj8vZvBSB9WFNULOK45OQDRXcmeB6YTMZM3JH5nWgy0H1T1BzLa0mg>
    <xmx:Zj8vZraBf1CIvrHZ2hDFkZjEydi0zZ_r6ohpukUMuBC3PVZ0FyW9Dg>
    <xmx:Zj8vZkVRP7BJaVCFFGAxbx_Upt65iLLfdg7ETXAn_puRi3z2tsFcB51r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:34:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9493ae6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:33:52 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:34:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 00/13] Stop relying on SHA1 fallback for `the_hash_algo`
Message-ID: <cover.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7g6evmVLWcx5JcpP"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--7g6evmVLWcx5JcpP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that stops relying on the
SHA1 fallback configured for `the_hash_algo`.

There's only a single change compared to v2, which is a new patch that
fixes a segfault in the commit-graph fuzzer.

Thanks!

Patrick

Patrick Steinhardt (13):
  path: harden validation of HEAD with non-standard hashes
  path: move `validate_headref()` to its only user
  parse-options-cb: only abbreviate hashes when hash algo is known
  attr: don't recompute default attribute source
  attr: fix BUG() when parsing attrs outside of repo
  remote-curl: fix parsing of detached SHA256 heads
  builtin/rev-parse: allow shortening to more than 40 hex characters
  builtin/blame: don't access potentially unitialized `the_hash_algo`
  builtin/bundle: abort "verify" early when there is no repository
  builtin/diff: explicitly set hash algo when there is no repo
  builtin/shortlog: don't set up revisions without repo
  oss-fuzz/commit-graph: set up hash algorithm
  repository: stop setting SHA1 as the default object hash

 attr.c                       | 31 +++++++++++++++------
 builtin/blame.c              |  5 ++--
 builtin/bundle.c             |  5 ++++
 builtin/diff.c               |  9 ++++++
 builtin/rev-parse.c          |  5 ++--
 builtin/shortlog.c           |  2 +-
 oss-fuzz/fuzz-commit-graph.c |  1 +
 parse-options-cb.c           |  3 +-
 path.c                       | 53 ------------------------------------
 path.h                       |  1 -
 remote-curl.c                | 19 ++++++++++++-
 repository.c                 |  2 --
 setup.c                      | 53 ++++++++++++++++++++++++++++++++++++
 t/t0003-attributes.sh        | 15 ++++++++++
 t/t0040-parse-options.sh     | 17 ++++++++++++
 t/t1500-rev-parse.sh         |  6 ++++
 t/t5550-http-fetch-dumb.sh   | 15 ++++++++++
 17 files changed, 168 insertions(+), 74 deletions(-)

Range-diff against v2:
 1:  a986b464d3 =3D  1:  5134f35cda path: harden validation of HEAD with no=
n-standard hashes
 2:  a347c7e6ca =3D  2:  589b6a99ef path: move `validate_headref()` to its =
only user
 3:  c0a15b2fa6 =3D  3:  9a63c445d2 parse-options-cb: only abbreviate hashe=
s when hash algo is known
 4:  1b5f904eed =3D  4:  929bacbfce attr: don't recompute default attribute=
 source
 5:  26909daca4 =3D  5:  8f20aec1ee attr: fix BUG() when parsing attrs outs=
ide of repo
 6:  0b99184f50 =3D  6:  53439067a1 remote-curl: fix parsing of detached SH=
A256 heads
 7:  ccfda3c2d2 =3D  7:  1f74960760 builtin/rev-parse: allow shortening to =
more than 40 hex characters
 8:  1813e7eb5c =3D  8:  2d985abca1 builtin/blame: don't access potentially=
 unitialized `the_hash_algo`
 9:  31182a1fc6 =3D  9:  f3b23d28aa builtin/bundle: abort "verify" early wh=
en there is no repository
10:  78e19d0a1b =3D 10:  7577b6b96c builtin/diff: explicitly set hash algo =
when there is no repo
11:  51bcddbc31 =3D 11:  509c79d1d3 builtin/shortlog: don't set up revision=
s without repo
 -:  ---------- > 12:  660f976129 oss-fuzz/commit-graph: set up hash algori=
thm
12:  e8126371e1 =3D 13:  95909c2da5 repository: stop setting SHA1 as the de=
fault object hash
--=20
2.45.0-rc1


--7g6evmVLWcx5JcpP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP2AACgkQVbJhu7ck
PpSIJRAAhuKC1iEqQgWnla6OiUasq6tkbbJAlv1eAIEvjG7tQ94opleOOdmlVciH
qIgucSKhuKkdW7nsJR5bPzIictiq3i4NLsQ4J8n/6AnKB8Lp9vKAoHav8kSoSUxK
zgU6hjzRfbq9r6SgEUsQq6L/R2yX3N6kVZI6XhjEbDO9aGrMSwZGev79skr4mW+s
tvGgsI69pJJwS+CgQX0QEZ69pzkk6HD6cCCP0YAlJXwFey/hlygVI26fnhVjS3Xh
KTjkq5s5/r2esoR52RlOMOvR7tHIdsItFmfkLk9b0weLlGycRmpjIckvDYohLI38
sQ1FyjJ16TZKAhaWBKFjGYSeB8va/p6/GcHeYu7DzrPlemUKetU+0gUiGasA8uyU
xCo7uOsgtslbM7z0gbNGijhWppZjq6uARM3yMdFzfv3sJ95zd9uopLHbtjwEGAPw
fAmEmcwZdtIyQ5HyBvRN+HAiHStchjlb+Gk+XSDIsql7hKH4TDc7VY4YFi7+20xa
Ti0REkQkv5IXKfWZoK/vguRf6PDcGXRvKhhnya8JLDvkEkDMowxHeo5N2YA5xAYD
x/mAo0G1Wvk3z9cz2TtzX9Md6/EVbRQTrdtHP82hXD/B43OXOeHfXOgnqj8/Spby
EEuVTJ8qmVcR7lfEaULH4UQ0oR092Jk/y9jG9uSeozumEFisrLs=
=AQew
-----END PGP SIGNATURE-----

--7g6evmVLWcx5JcpP--
