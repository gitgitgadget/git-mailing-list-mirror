Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A46E84E03
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545009; cv=none; b=t3DPyvt3fnkKRpRXseybHtNvy8DE1G7mLkI3wy6JBcKpZmhQQo3ybGvLETXP67EbOh2Sa3E2LhqrPHbMu/RbwaEq5EvSqmD9IVe1eWo47SGFJc+2Vjr5eBe0IPYtERy7DQ1twcIljs+1P31et1yuDN1rm4gaqllQsbW07ib2B18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545009; c=relaxed/simple;
	bh=u3T+m3/vhAg6Ct/YqzYf2lIXdp2Iguxm2eNPFlxWqVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPOrUQx0fXizxanIj3H4CrSHAFkSICm0CSGYx5EUEtRqL+eKSTwt7FEfvoZ3B8551qP2idiZpoRnkVXYYQpyJxyIaNMaXLsCXnvw0xJoahQbsPvAxPRQY3smYwWluOlSwkVmnKfpqDIPYOWu1Rva5cELpWptf+nXztgvlM3JajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iynXmqQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBEZqfjv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iynXmqQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBEZqfjv"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8999B13800EE;
	Fri, 24 May 2024 06:03:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 06:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545006; x=1716631406; bh=uq/Upr2JKH
	nLeA5m6+KxhRQlPhUS1I5t1aXAJHakMpY=; b=iynXmqQXBQgDXl/mZV8goI8OnE
	7TB9KeJYgNn3IKCE753pNo7sKAlMApbZOe8r5PJjH41d0/HNv7N3izTTg4g+UV3F
	2yroaQY7M4Wz9f/AAbLM8smdi5LwLFr+FIwWbiZ/KhLnp0oE/PIpE+ed2HFOxDot
	ywnYWP714Vi9HgyN3XiDo0XhA1Bbu7lhKRWZwYD8wOgqCOBX36AndM1R+D3rd56P
	DIy6Pg+mRSULvo9GYw2QpZ7LSI9Nd6aWtS8oJL4ndCdZAt+LnUS1taRSYXaX5ucm
	NkSwU1x+TGYJxZ7tRgjX/h0Y8sXIG60gBgQ7IBYO+WLf02h909hx0UUfrsDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545006; x=1716631406; bh=uq/Upr2JKHnLeA5m6+KxhRQlPhUS
	1I5t1aXAJHakMpY=; b=kBEZqfjvGV5pvM99fjJOODO7LVEGYU4LOvKdEGnbvI0W
	mkZskEL6HuSVJ/wgMDuAKcAQ/kIeeBKLs6sHBwXosSLLp2BW5KtW/SZaJwWy6S4k
	tchWofc1kB9qnVfi53fZsZLWFO3OVQozQ0OXVcdeFK8JG9OvdsSwGsVfMhG0XkQn
	9Cl1VUNaTr4M4bfTYNIzkH8b+2rQu9Yui6r/I/jAzyfn9s5KtM/5jFWELiBjBbp3
	9MUvIX7dY0onbcN0qPcgBmKbtaVDP51ka4lRqgyIuaQtlwRq/i6jGrSorsMGoIwt
	MzAGtgAH3xBn+DTE9Lq5FY6sid7gUwIrr2F/pA/jyQ==
X-ME-Sender: <xms:7mVQZrb8ThQDEqvIG_oUPn9xnQbo_hYBkgmwUF7sRwAQvK1Xv1eUmA>
    <xme:7mVQZqY5a7BMm7MclJMwDJ3UjYFAehY4bQW-jHxVrqU4DN7JAebq6FhUQ9I0djXl7
    Q2mN22ECpBPWZ1v6g>
X-ME-Received: <xmr:7mVQZt8H24Pf7kKb3CKSCBEIVQknIn8PPAlenLhVudoNB-dfheMNS1hpG2M6Upmn9DhFhNDxhZHjLRzJ4VhIh-wM81VFcuMl0qcDXJ5Vy7KJuX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepfeehieduieeigfffheeggfegiedtudfgkeeutdetheeuudevffeggfelgedtveel
    necuffhomhgrihhnpeegtddrihhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7mVQZhogzNUyB4G1l7gm2tN7ulzs574MdtFiT_QRepAG-c4MHymRHA>
    <xmx:7mVQZmrL_Mz8N5he2D0PqMETvNbeiR6ZOng942Lja0QEXXX71zrqaQ>
    <xmx:7mVQZnR0All48qMHT_Dyg-djCC6fzSXk3qdFJJxHUtu3IoggxJ9KTA>
    <xmx:7mVQZupeOYC3SADiKVZWz4A7r9z_59_epZgwgHMTmXw9ACMhqJddKA>
    <xmx:7mVQZpV0EcaD9ZYVXH14weuXLaMtGOX5sX5z5ptYVG2mx5x3kwCUGe08>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:03:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 77e2744f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:03:19 +0000 (UTC)
Date: Fri, 24 May 2024 12:03:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/21] t: mark a bunch of tests as leak-free
Message-ID: <ceade7dbba0ad82bfca979f95a946ba54a16236c.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YcpvuDYBLnVr9R+t"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--YcpvuDYBLnVr9R+t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are a bunch of tests which do not have any leaks:

  - t0411: Introduced via 5c5a4a1c05 (t0411: add tests for cloning from
    partial repo, 2024-01-28), passes since its inception.

  - t0610: Introduced via 57db2a094d (refs: introduce reftable backend,
    2024-02-07), passes since its inception.

  - t2405: Passes since 6741e917de (repository: avoid leaking
    `fsmonitor` data, 2024-04-12).

  - t7423: Introduced via b20c10fd9b (t7423: add tests for symlinked
    submodule directories, 2024-01-28), passes since e8d0608944
    (submodule: require the submodule path to contain directories only,
    2024-03-26). The fix is not ovbiously related, but probably works
    because we now die early in many code paths.

  - t9xxx: All of these are exercising CVS-related tooling and pass
    since at least Git v2.40. It's likely that these pass for a long
    time already, but nobody ever noticed because noone has CVS on their
    machine.

Mark all of these tests as passing.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0411-clone-from-partial.sh      | 1 +
 t/t0610-reftable-basics.sh         | 1 +
 t/t2405-worktree-submodule.sh      | 1 +
 t/t7423-submodule-symlinks.sh      | 1 +
 t/t9200-git-cvsexportcommit.sh     | 1 +
 t/t9401-git-cvsserver-crlf.sh      | 1 +
 t/t9600-cvsimport.sh               | 1 +
 t/t9601-cvsimport-vendor-branch.sh | 1 +
 t/t9602-cvsimport-branches-tags.sh | 1 +
 t/t9603-cvsimport-patchsets.sh     | 2 ++
 t/t9604-cvsimport-timestamps.sh    | 2 ++
 11 files changed, 13 insertions(+)

diff --git a/t/t0411-clone-from-partial.sh b/t/t0411-clone-from-partial.sh
index c98d501869..932bf2067d 100755
--- a/t/t0411-clone-from-partial.sh
+++ b/t/t0411-clone-from-partial.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'check that local clone does not fetch from promisor re=
motes'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'create evil repo' '
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index cc5bbfd732..b06c46999d 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -10,6 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable
 export GIT_TEST_DEFAULT_REF_FORMAT
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 INVALID_OID=3D$(test_oid 001)
diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index 11018f37c7..1d7f605633 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -5,6 +5,7 @@ test_description=3D'Combination of submodules and multiple =
worktrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 base_path=3D$(pwd -P)
diff --git a/t/t7423-submodule-symlinks.sh b/t/t7423-submodule-symlinks.sh
index 3d3c7af3ce..f45d806201 100755
--- a/t/t7423-submodule-symlinks.sh
+++ b/t/t7423-submodule-symlinks.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'check that submodule operations do not follow symlinks'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'prepare' '
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index a44eabf0d8..3d4842164c 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -4,6 +4,7 @@
 #
 test_description=3D'Test export of commits to CVS'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 if ! test_have_prereq PERL; then
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index a34805acdc..a67e6abd49 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -12,6 +12,7 @@ repository using cvs CLI client via git-cvsserver server'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 marked_as () {
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 5680849218..41fcf3606b 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -4,6 +4,7 @@ test_description=3D'git cvsimport basic tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-cvs.sh
=20
 if ! test_have_prereq NOT_ROOT; then
diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-vendor-=
branch.sh
index 116cddba3a..e007669495 100755
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ b/t/t9601-cvsimport-vendor-branch.sh
@@ -35,6 +35,7 @@ test_description=3D'git cvsimport handling of vendor bran=
ches'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-cvs.sh
=20
 setup_cvs_test_repository t9601
diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-branche=
s-tags.sh
index e5266c9a87..3768e3bd8c 100755
--- a/t/t9602-cvsimport-branches-tags.sh
+++ b/t/t9602-cvsimport-branches-tags.sh
@@ -7,6 +7,7 @@ test_description=3D'git cvsimport handling of branches and =
tags'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-cvs.sh
=20
 setup_cvs_test_repository t9602
diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index 19f38f78f2..2a387fdbaa 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -12,6 +12,8 @@
 # bug.
=20
 test_description=3D'git cvsimport testing for correct patchset estimation'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-cvs.sh
=20
 setup_cvs_test_repository t9603
diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps=
=2Esh
index 2d03259729..9cf0685d56 100755
--- a/t/t9604-cvsimport-timestamps.sh
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'git cvsimport timestamps'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-cvs.sh
=20
 test_lazy_prereq POSIX_TIMEZONE '
--=20
2.45.1.216.g4365c6fcf9.dirty


--YcpvuDYBLnVr9R+t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZecACgkQVbJhu7ck
PpSoDA/+LexSOihPL6cxdbYU9aNpN7kXwFP+S60g0sRDm6PL0m6vS24ywg01VgGZ
PFFDM2f/J4EYeaQ3jgfb8vazwh9G1MKYWSZl5DoTWqB6AyPDcfqMK44QxUWxZzl4
rspda6cRyBAszSvmffSQ2XrR++H8Rl5GTphWdOBqJ+PD7SYHZCf9geV5owEmlICC
xKlhxz26NRF+W4V5pVMKLKB2UIDV90DJsUFmH7+2ZjkkQ0n4/Un62yy41fWrXl/n
oDlYXTIqz5ifAnh4LdvKObCx9c3DDX4ovxIUnjFAO/DcXWOhJ/3tnzzlkDFrHMtX
/xmKZMt+f1ZqC8/KAILIgrmWEfsERHu7Cqv3ja4yvycs0hU4kT/XFYBoUe/Sr0Gk
kTiSvpsgyj4/Q1rX2q49GWIMqGzHM+rJR+9W0c9M6fmn5lIxorrRCxfPXnNfbEE8
rhHmMqr5L0gbJHyZTS7gFpFrWZ+pAYKZgfJIU0DkAqjmBwmGnwhOcIpyxCZn6qyM
Ez3CnLF3KjrgoEdQuJASsMt8oBgp/Fr2gEUzRUaJ+zxZ95l9THYr7UQtO/1w6KTa
vbgxUYTs0Bk9ZFcGhAzfKCWM8XqqbfWXpKy7m70OwtrP2fUYAE6ZuvYxt10MCTAG
cHIsSH7hYqU2B7F52yyplqNEves4yWCBKwyszi6vBEJOzbEp0cQ=
=Zxsi
-----END PGP SIGNATURE-----

--YcpvuDYBLnVr9R+t--
