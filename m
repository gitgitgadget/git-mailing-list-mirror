Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D609712E44
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985534; cv=none; b=UIlAEmhXUvg6eDOs3UQjh+xUaIhiuajxVdnZjAaRh5mslhMBsBWrASBNzkc7NrDE2B/FOTZ8ZFdfVgidktBV3sBgHtHIYpBa9PFzx3PRs2rDz9o9ZYSVch+8ZXNbxyJhPcoXoBipUBrvFXa8LdiFkpklNBm8u+9FtVDfr7UbOjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985534; c=relaxed/simple;
	bh=kycv6tg0AnRSIpeso3ErNffApEPw8y3hmBYKG5gzAUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asUPFvPG7kPIZfU6Zu3b47P9zBYzdsYXUKNMnaQk5pwBUy2u4ZkAs8yAyE5E3q41ivG5ROyBxAjRULjs1pZYiMEf5G84d6Ib8HOej6fdTFbmxdclGBYl8ZiVmoyOqshFxEhtfsD5XpRG6alNreu2B6EQI2lePa3NaW8s0rtExew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AAJDzwz7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3E1zjvK; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AAJDzwz7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3E1zjvK"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id A4BB05C0004;
	Thu, 15 Feb 2024 03:25:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 15 Feb 2024 03:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707985530; x=1708071930; bh=XAjKEf/HmZ
	ytQImjqMm7wqAWniohCaNn0BAc91oHYkE=; b=AAJDzwz7p94ekAd9V0Rg5ORg/N
	c4ylwCtXebGpdhUWgBVueoTv1yhUknF6o2eyGnAono4tZHAXjAV1LqpqyIoH4FAe
	WSVRlLK3mds1E/f7C30eCvd2JCQMoPkYAQQgFtHLIXbdmCx9ZVTyFH/f7mUHj0yy
	d0keYOb/oBjYB0S9+pQgM198qskectcGabDwbAP+1jNXaAp43jI9RPQ0XQj5oma/
	8eRkcgwGofOPKQ451GofPT28UX9kwIU+00SjIXFFvpo3TkZjDEA6q8ZBpqzR02i3
	LESyV/V59SN7i+2Or2XM9faqiKmqByDCr8BDVNJk20r8t0A30rDnd+wAQrxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707985530; x=1708071930; bh=XAjKEf/HmZytQImjqMm7wqAWnioh
	CaNn0BAc91oHYkE=; b=A3E1zjvKp2NrJ7xYlxoCEUMSkZy1gRfQddppSHtjoYqp
	t1cgaMDsfe5996LNHLfkKE4Vd9hu+aRyfY3aO1D9FEbOGaIO3O0ZLH03XcrGZBx+
	eX/rs/Q3ZZLBMqk9cgJQIKOnzqnuDdI59sL5Fjc0OHyZfzBuKofFU9wTCHN7FatB
	YAI7XuoUuepYqB7Drmj3Y5HInKSl8h0kY8xcI/QHptKWG2SpiFs5rkIYXB6B9eTO
	RfceUNEo+v5G9mElUPOyVxyMvAlkBgGdJFVWNnuv2a2QBHwIhe3mPS96qSEp7htm
	dN+1CQeINwAEQFKEcVmUQmlW0JbgpvCQDhlZPt//0Q==
X-ME-Sender: <xms:esrNZfd2rlS-eKZtZktOlYJQwO619-O3z_ZQmzsi98Rr6jQ4UUY1CA>
    <xme:esrNZVOt1PJD8MI-nI2R7ySBEbFWv1kj9iExI7-njWT7cU42TH_WBjfGmaBxbodQo
    w0NEATbB8QytE-yyw>
X-ME-Received: <xmr:esrNZYi2KjJVqWJx8auWehBintyUIQC_hGWC3GySD7B1GyQgru6Fh66lKE6_kUO1HUzXBsOgLdF96RQCUN6yQUiEGHFIzzgvh74wNDTuaRD->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:esrNZQ9UcTZux9pOIHNzqT0Ag2smKuketleMeOU8LV_RRX3FKETyNQ>
    <xmx:esrNZbsI3rsujyf3DPFO2emVF-Y0eSpxbtD_wRJAKW6gnkjk88VCAg>
    <xmx:esrNZfFVrDCbenaPkkoltTaQuR5y0PRqR0cuiUIbG9Qdjo1IayB7gg>
    <xmx:esrNZU5S3UOBoHLstUeOauZsTbHRtnyKWYw1reTwfZOVdim7hY7F6w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 03:25:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2aad0484 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 08:21:36 +0000 (UTC)
Date: Thu, 15 Feb 2024 09:25:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] t: drop more REFFILES prereqs
Message-ID: <cover.1707985173.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uTDGqWHwdKMJBak/"
Content-Disposition: inline
In-Reply-To: <cover.1707463221.git.ps@pks.im>


--uTDGqWHwdKMJBak/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that drops the REFFILES
prereq from more tests, thereby increasing test coverage of the reftable
backend.

There's only a single change compared to v1, addressing Junio's
feedback. Please refer to the below range-diff.

Thanks!

Patrick

Patrick Steinhardt (7):
  t: move tests exercising the "files" backend
  t0410: convert tests to use DEFAULT_REPO_FORMAT prereq
  t1400: exercise reflog with gaps with reftable backend
  t1404: make D/F conflict tests compatible with reftable backend
  t1405: remove unneeded cleanup step
  t2011: exercise D/F conflicts with HEAD with the reftable backend
  t7003: ensure filter-branch prunes reflogs with the reftable backend

 t/t0410-partial-clone.sh         |  4 +-
 t/t0600-reffiles-backend.sh      | 91 ++++++++++++++++++++++++++++++++
 t/t1301-shared-repo.sh           | 16 ------
 t/t1400-update-ref.sh            | 50 +++---------------
 t/t1404-update-ref-errors.sh     | 37 ++++++-------
 t/t1405-main-ref-store.sh        |  6 ---
 t/t2011-checkout-invalid-head.sh | 17 +++---
 t/t3200-branch.sh                | 29 ----------
 t/t3400-rebase.sh                | 10 ----
 t/t7003-filter-branch.sh         |  5 +-
 10 files changed, 125 insertions(+), 140 deletions(-)

Range-diff against v1:
1:  2eca90234f =3D 1:  6891cdfdb3 t: move tests exercising the "files" back=
end
2:  feef6a3e6c ! 2:  2dd87f3126 t0410: enable tests with extensions with no=
n-default repo format
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    t0410: enable tests with extensions with non-default repo format
    +    t0410: convert tests to use DEFAULT_REPO_FORMAT prereq
    =20
         In t0410 we have two tests which exercise how partial clones behav=
e in
         the context of a repository with extensions. These tests are marke=
d to
    -    require a default repository using SHA1 and the "files" backend be=
cause
    -    we explicitly set the repository format version to 0.
    +    require a repository using SHA1 and the "files" backend because we
    +    explicitly set the repository format version to 0, and setting up =
either
    +    the "objectFormat" or "refStorage" extensions requires a repository
    +    format version of 1.
    =20
    -    Changing the repository format version to 0 is not needed though. =
The
    -    "noop" extension is ignored as expected regardless of what the ver=
sion
    -    is set to, same as the "nonsense" extension leads to failure regar=
dless
    -    of the version.
    -
    -    Stop setting the version so that these tests can execute with SHA2=
56 and
    -    "reftable" repositories.
    +    We have recently introduced a new DEFAULT_REPO_FORMAT prerequisite.
    +    Despite capturing the intent more directly, it also has the added
    +    benefit that it can easily be extended in the future in case we ad=
d new
    +    repository extensions. Adapt the tests to use it.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ t/t0410-partial-clone.sh: test_expect_success 'convert shallow clone=
 to partial
      '
     =20
     -test_expect_success SHA1,REFFILES 'convert to partial clone with noop=
 extension' '
    -+test_expect_success 'convert to partial clone with noop extension' '
    ++test_expect_success DEFAULT_REPO_FORMAT 'convert to partial clone wit=
h noop extension' '
      	rm -fr server client &&
      	test_create_repo server &&
      	test_commit -C server my_commit 1 &&
    - 	test_commit -C server my_commit2 1 &&
    - 	git clone --depth=3D1 "file://$(pwd)/server" client &&
    --	test_cmp_config -C client 0 core.repositoryformatversion &&
    - 	git -C client config extensions.noop true &&
    +@@ t/t0410-partial-clone.sh: test_expect_success SHA1,REFFILES 'conver=
t to partial clone with noop extension'
      	git -C client fetch --unshallow --filter=3D"blob:none"
      '
     =20
     -test_expect_success SHA1,REFFILES 'converting to partial clone fails =
with unrecognized extension' '
    -+test_expect_success 'converting to partial clone fails with unrecogni=
zed extension' '
    ++test_expect_success DEFAULT_REPO_FORMAT 'converting to partial clone =
fails with unrecognized extension' '
      	rm -fr server client &&
      	test_create_repo server &&
      	test_commit -C server my_commit 1 &&
    - 	test_commit -C server my_commit2 1 &&
    - 	git clone --depth=3D1 "file://$(pwd)/server" client &&
    --	test_cmp_config -C client 0 core.repositoryformatversion &&
    - 	git -C client config extensions.nonsense true &&
    - 	test_must_fail git -C client fetch --unshallow --filter=3D"blob:none"
    - '
3:  9d8eed354e =3D 3:  ed57913eb9 t1400: exercise reflog with gaps with ref=
table backend
4:  70c6f98012 =3D 4:  212949689f t1404: make D/F conflict tests compatible=
 with reftable backend
5:  25cf00c36f =3D 5:  67d6aede63 t1405: remove unneeded cleanup step
6:  64d2548bbc =3D 6:  24051cc246 t2011: exercise D/F conflicts with HEAD w=
ith the reftable backend
7:  7adf510f73 =3D 7:  8fb6de37ce t7003: ensure filter-branch prunes reflog=
s with the reftable backend

base-commit: 4fc51f00ef18d2c0174ab2fd39d0ee473fd144bd
--=20
2.44.0-rc0


--uTDGqWHwdKMJBak/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXNynUACgkQVbJhu7ck
PpT4ChAAo838Gs3L9MfgzNa1pdxXUwTAP9EXM3uvSjOk7Nam4S5exrqFSlvGsFHo
bI/TjZkymK2KuXZYst/HN4RYe6e9Hj2l95gEt1zbcolVOFD69tn/0Bc2SX1bXn1S
xQb3toI0tpnkVvAy8hBI5hnWDQw3fgcDjQT8XN9hqJx/dYdtACTfebv6hAo+dYSv
Nb0YWWxxL4cb58SdYXy2k3iQ+gY+ycwDFYdnb6wfGNIZUkHtlsQxO7HLkZFM/21A
/0AXDu5ZKyCinnPTRHETyJfYkFWPf/yn9sYf+U/wqaPTm/9mTGdM1H0h3lCLwVM8
BqFsK+LZkWgsnOmDsLYoXKzdp314HEKXtr0dGirkjU2Mfiyf2BI0X7z0GATXeuqN
rjuA16p2y1GxZbt+aVzQ/XcFfDliwJ7Oyp/lbJnLUVBziLsgj92Pgw8DXUckqs1O
LAT7soP+aFnImLSBBo88bcKIFCpBbXZeTxbWW6MCxYNIbaI4KOLO5FlGIrbu5XFv
p3JEAsgYy8O/9Mmf8MMCGVUJDwxa7q8NXKB8HIP4oXhSiDuao3Dm9fNtwb9jD3DM
LJQB6iB7cqNARTjG7CMvB8RoeZwd3PnsSV9FKtAq04XWc8VCQqUdRVOCoYDDXzzD
ksDih74lvvdetzuLg+14PozjuNQYkNA34WtAwy+veCULpNQxsZM=
=GYMo
-----END PGP SIGNATURE-----

--uTDGqWHwdKMJBak/--
