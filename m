Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA791CA82
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848849; cv=none; b=f9YO81R9tDKusMPLxOCh6MHqcGPX1V4EDYAn/h4FXYb6sN13iVltq8Pk7rvdF9BHprcEESqjUBuzGXutcB1Xk1/6JrpSJZy34HJ3i/Dq6Un/T69oohoH4sIezQ17fvvEjzQnxtVwABFYN5OCTttp11Kr2Ea2ggwwspElmC6aA0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848849; c=relaxed/simple;
	bh=K+8W+CWhkqzv4mRJIslBxQMbfhB5Ozfq1vUsaAcnkYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkuxNluYx/IAeFbub1kEEm+ME+u8Pl707Hc7NkPhK3Ir8AOvtpKj+J7hQkFKMLH/5j7etYKn2ZwoomG5cfOh4JhGHPwkqhyjvXOkptldVHua3rSjGgxgiSbzR/WTVasUcPbGqpLSQqZsUt9agLVQZmHD0St9dBBuQ8aCeCv51gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l5gzSTzF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QMJGIbdO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l5gzSTzF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QMJGIbdO"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8DDAA1140163;
	Tue, 23 Apr 2024 01:07:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 23 Apr 2024 01:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848845; x=1713935245; bh=5VGdG/uG1V
	/khdlujrDaP0JgJWHPvmBGbmTv1s6E03Q=; b=l5gzSTzFAnEqgkqsM8XBY/iRBN
	oUPu+xGlkLSxVxGRoW58hzqT8rPb/NXqRsP1TG/lbrz9Yf8f7I8d5K63AvygXNE/
	iYWElykivE6cLpR0iCjer/ha3DLNCI7NtpY8OHuZTkHmgGm/PEN3UmlInVmVcCDA
	blclP2/if2iWWixDb7/pt1h3EIRXLdJsjjmr3jPoPqpKhU/0K8H8/7pfgxcLP2Yp
	to+0c3+yBgeCE1xF83KC1rngFahlVvOaHcxTknXvr4ID18zWKlxawPLwB9LSfewj
	Ae3yE7gy1yRyfaMmllN2lpos65TS0MUfAp3QyuAextuUXUm/hsrWbePjZlqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848845; x=1713935245; bh=5VGdG/uG1V/khdlujrDaP0JgJWHP
	vmBGbmTv1s6E03Q=; b=QMJGIbdOhqiTvJLw03lBSG4iwtmmoW4igC0KZ7yKFJTd
	JO/6jW+ovAhI041EoBTWpeHAszYudYuQxh0jfCFXbruvT9BIHEE7ys1QaslxtBy3
	2Yjl1dcRiOB/was3lrHslnvMfz8YJfg4To3rjGbDUmT1J2C3aYoL7ixLnr4c4A9c
	nVTtsqrMpb2Vxl8M9C5MEtCJOMMLmQ8M7MyUu4JRdsiSd7w8CqDe1A12Q15GbnSh
	YywGXWiph+6N+4zu07ra61voPgZkQnzj6AoCzXp7a2UnQIJBLDrvQEOd+qFyybLQ
	pI2O6upUqqCtKm+ykd+7wvhMVEfeQ3eFYgLBPIMTdg==
X-ME-Sender: <xms:DUInZvm5XJAPEUCZG_6gRBcHTJhDKwzqzHRXJepnbugw7wnpwBB3PA>
    <xme:DUInZi0BE25u1x4Upz6wZGHBrP4llbx7dAxJPmktrVeP1JqhDNp17_SSEwqfjidW3
    WpFHS9hDS9-wsa2iQ>
X-ME-Received: <xmr:DUInZlpGAgQrvIkXrot27RA6PfeDputS-gz-ODa-pLaecCmHtuq-wa8RhhSURMiGKPtnb1zhTiJX7XNs8yvthhcs4dC138pGRrXEc_cjY-qu1l83>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepveeigedvtdeufeetffekkeejueehffdujefhteeuueffheetvedtvdejveekfedv
    necuffhomhgrihhnpehhthhtphdqfhgvthgthhdqughumhgsrdhshhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:DUInZnk8COyeeK_dTNdfibZJ_pZUpDTghA0UeR3nErczHDGQOnfr2A>
    <xmx:DUInZt05ps_Y2NX1DkY6kj3IWp8748A78z9dvUz-XFZHDqfEbPK7Iw>
    <xmx:DUInZmvNZUBLI6gkpBEHuyTVWYDEtPB-Def8Lf5ysDHCUy706bXtKA>
    <xmx:DUInZhUqKH2fduL2gS-3_fUFSXoAXzA8GpKBpS-icFr2mSOyzoWFmQ>
    <xmx:DUInZoQGS4k5SVT5hXS_0AG_kMg2Nf1BP6VEOMFpCMRD-2vn1pTWS2Ch>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:07:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id de26459b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:07:15 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:07:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 00/12] Stop relying on SHA1 fallback for `the_hash_algo`
Message-ID: <cover.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HfytWfSGBIqX8ARz"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--HfytWfSGBIqX8ARz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that causes us to stop
relying on the SHA1 default hash.

Changes compared to v1:

    - Various typo fixes in commit messages.

    - Added another patch that moves `validate_headref()` into "setup.c"
      to clarify that it is only used during repository discovery.

    - Indented a diff in a commit message so that git-am(1) is happy.

Thanks!

Patrick

Patrick Steinhardt (12):
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
  repository: stop setting SHA1 as the default object hash

 attr.c                     | 31 +++++++++++++++-------
 builtin/blame.c            |  5 ++--
 builtin/bundle.c           |  5 ++++
 builtin/diff.c             |  9 +++++++
 builtin/rev-parse.c        |  5 ++--
 builtin/shortlog.c         |  2 +-
 parse-options-cb.c         |  3 ++-
 path.c                     | 53 --------------------------------------
 path.h                     |  1 -
 remote-curl.c              | 19 +++++++++++++-
 repository.c               |  2 --
 setup.c                    | 53 ++++++++++++++++++++++++++++++++++++++
 t/t0003-attributes.sh      | 15 +++++++++++
 t/t0040-parse-options.sh   | 17 ++++++++++++
 t/t1500-rev-parse.sh       |  6 +++++
 t/t5550-http-fetch-dumb.sh | 15 +++++++++++
 16 files changed, 167 insertions(+), 74 deletions(-)

Range-diff against v1:
 1:  aa4d6f508b !  1:  a986b464d3 path: harden validation of HEAD with non-=
standard hashes
    @@ Commit message
         current version of Git doesn't understand yet. We'd still want to =
detect
         the repository as proper Git repository in that case, and we will =
fail
         eventually with a proper error message that the hash isn't underst=
ood
    -    when trying to set up the repostiory format.
    +    when trying to set up the repository format.
    =20
         It follows that we could just leave the current code intact, as in
         practice the code change doesn't have any user visible impact. But=
 it
         also prepares us for `the_hash_algo` being unset when there is no
    -    repositroy.
    +    repository.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
 -:  ---------- >  2:  a347c7e6ca path: move `validate_headref()` to its on=
ly user
 2:  5daaaed2b9 !  3:  c0a15b2fa6 parse-options-cb: only abbreviate hashes =
when hash algo is known
    @@ Commit message
         parse-options-cb: only abbreviate hashes when hash algo is known
    =20
         The `OPT__ABBREV()` option can be used to add an option that abbre=
viates
    -    object IDs. When given an length longer than `the_hash_algo->hexsz=
`,
    -    then it will instead set the length to that maximum length.
    +    object IDs. When given a length longer than `the_hash_algo->hexsz`=
, then
    +    it will instead set the length to that maximum length.
    =20
         It may not always be guaranteed that we have `the_hash_algo` initi=
alized
    -    properly as the hash algortihm can only be set up after we have se=
t up
    +    properly as the hash algorithm can only be set up after we have se=
t up
         `the_repository`. In that case, the hash would always be truncated=
 to
         the hex length of SHA1, which may not be what the user desires.
    =20
 3:  ae91a27ffc !  4:  1b5f904eed attr: don't recompute default attribute s=
ource
    @@ Commit message
         variable is the null object ID then we try to look up the attr sou=
rce,
         otherwise we skip over it.
    =20
    -    This has approach is flawed though: the variable will never be set=
 to
    +    This approach is flawed though: the variable will never be set to
         anything else but the null object ID in case there is no attr sour=
ce.
         Consequently, we re-compute the information on every call. And in =
the
         worst case, when we silently ignore bad trees, this will cause us =
to try
 4:  53c8e1cd7c =3D  5:  26909daca4 attr: fix BUG() when parsing attrs outs=
ide of repo
 5:  32a429fb60 =3D  6:  0b99184f50 remote-curl: fix parsing of detached SH=
A256 heads
 6:  9cb7baa50c =3D  7:  ccfda3c2d2 builtin/rev-parse: allow shortening to =
more than 40 hex characters
 7:  e189a4ad15 =3D  8:  1813e7eb5c builtin/blame: don't access potentially=
 unitialized `the_hash_algo`
 8:  bc4bda3508 =3D  9:  31182a1fc6 builtin/bundle: abort "verify" early wh=
en there is no repository
 9:  39e56dab62 ! 10:  78e19d0a1b builtin/diff: explicitly set hash algo wh=
en there is no repo
    @@ Commit message
         hashing the files that we are diffing so that we can print the "in=
dex"
         line:
    =20
    -    ```
    -    diff --git a/a b/b
    -    index 7898192..6178079 100644
    -    --- a/a
    -    +++ b/b
    -    @@ -1 +1 @@
    -    -a
    -    +b
    -    ```
    +        ```
    +        diff --git a/a b/b
    +        index 7898192..6178079 100644
    +        --- a/a
    +        +++ b/b
    +        @@ -1 +1 @@
    +        -a
    +        +b
    +        ```
    =20
         We implicitly use SHA1 to calculate the hash here, which is because
         `the_repository` gets initialized with SHA1 during the startup rou=
tine.
10:  508e28ed1e ! 11:  51bcddbc31 builtin/shortlog: don't set up revisions =
without repo
    @@ Commit message
         repository in that context, it is thus unsupported to pass any rev=
isions
         as arguments.
    =20
    -    Reghardless of that we still end up calling `setup_revisions()`. W=
hile
    +    Regardless of that we still end up calling `setup_revisions()`. Wh=
ile
         that works alright, it is somewhat strange. Furthermore, this is a=
bout
         to cause problems when we unset the default object hash.
    =20
11:  f86a6ff3ba =3D 12:  e8126371e1 repository: stop setting SHA1 as the de=
fault object hash

base-commit: 21306a098c3f174ad4c2a5cddb9069ee27a548b0
--=20
2.45.0-rc0


--HfytWfSGBIqX8ARz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQgcACgkQVbJhu7ck
PpQuDw/8CeNEem3lpLwOQ5OW4N+6N/dxhTKjaKp0K3Nx8hol4xmmZImFQa9KdKtL
fzEMdry4Zd23hLs+A+BxKV/A0Kgl6K8JHuVHoLB2IgYJsW9RMko6emchjifi6kQO
8/tXxdKBX3pdfVpWA3DaL1R2ipKICgCUh4v6Jd5rXUAyD2Zg61WtnAK7RgisaDcD
C0B10+zHLDVDeScx3Gti7CudUuM5dD4ZLtDJUvNqdOO1cPpVycE5JhQd+iKG98z7
bRX+Va5MkbXk6HuJpK+isl5VLcvrMx4hhgYZ/TIFoYpkPGNvbIgKli0k4+Kr+UwN
r+R3RK0Y00PSPalhvQ68oYYlIFqcFAFHZABB6X7OJ1NAm4urbtDW4vxoYTI74GE/
HS2qhFu4yX2nisGqdm/9AXeJGpH+X5S5JYVSB34FAJCWBfFnx7seQkc9+4JHl/hb
YUecHCIdtUn4TVRCgSwn2FPesJvlBJV+5+vwm0liXcukL89AnM0tagJ88YLEnog/
pGHSWpMFeLrTKXybKVWUC8kTyQwfrwnmAmRf0XoEo6h1jYHXzH/fTdOI6C4jqyfv
d8cW3rXiTgjlD7dZbaD1xXeZOGCBgf8E2S1KQiQrWhmyoz9d6hMVCr7Zw2ujWBCs
gGZ8dpwUhoYEEEnqM9oiUpDiwVP7TOUx3/gCsqHkWNp5tmbKl8s=
=2pF6
-----END PGP SIGNATURE-----

--HfytWfSGBIqX8ARz--
