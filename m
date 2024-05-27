Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA90152DF2
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810359; cv=none; b=FPeoXnhmxkxyoZHH7/EckwIT2fqNWLyq8ivGxyI0Pe1nhyJaRsTRej/6+wsG2dTBS6G8N2n4P3y+wxO5pGa74LcoyR0hPu1hg2y39snDYX1wTVl1SARbsiZge5htCgSkwfSlROyXcqCHHVD/pk2GdOLOGP/rtrclGkZZTkcUBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810359; c=relaxed/simple;
	bh=G9D0nLm+fc1jJd8rIiTXVfwu6coZ8k23wF1cdh4VT44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huV3jZ26xm0wpNntG0pmqnBkPMTGyAXgjwVyH+8n4HADZh5Nli+xtvbBOKpllhTNhXCSJuxWGnX5aJAoLO1w1CpGSmt8keS72hda6zs+fVcwl69FH6lnkYuz+PRWvAIVaJocZOM4zbn8oAnNDDZWeQbnf53oZuN5jDPWZNb3CIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ANgNbraG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A+6J1aVs; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ANgNbraG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A+6J1aVs"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 09D201C000CD;
	Mon, 27 May 2024 07:45:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 27 May 2024 07:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810355; x=1716896755; bh=voUQ1pVznG
	D/RdgjR9VksNdZUXKuJSZCCpe70gSwTdc=; b=ANgNbraGnv1HjV6wgxUGFfqkf/
	4uAwNutjM05dkbqHWRd4OOX8OP0vJ5QPi/UBA0vttEsVA6v70mOwjIxBWjOYnHQP
	4rgL1EMabkHltNTP+hW+uRjJtisexBc0JAR5zG24xGi70tV/FQXin5iZA0sUR75H
	3szV2vgiVW6GtKmDf9vxOhzyJH1B7rMAVqThxyxlsGvaT/IPwKWCooWweAGWCgua
	djFgSrkX6swukPvZ/lzbev9Xr6dJRSbNSTkffkgVWcU1sAjv/qMkCDIC8nMmraws
	TCsz/7IUvsQLG/WbEmum6zlxKIp1ZXzZeWq8pxcWz0LeRmznhRg2L+v+SyDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810355; x=1716896755; bh=voUQ1pVznGD/RdgjR9VksNdZUXKu
	JSZCCpe70gSwTdc=; b=A+6J1aVsOXew2rKvsRcGTgDGayJe4hQVyAKq5/hfjehs
	Xl9n9ZGLCJ4rqrVqbTbySb9mnP2FFpWINhENaJNr+3x0anYqxUU4w/nTN+Z0iekU
	v+4zjq37UIespt7CzljwSE2uRfHLhPYDtXawqBXqGf3qqOmPNVQmA3esBY5yvIJG
	hHeiURUlxtegdmdyl0lu6kVCpTqYXQWg3gC3xOe6BjTz9CHzwNNdPbZDBXI+TC8d
	uwsG+QG1CXsOWqmaV9FrMRy6TetdeXoHuCW42uHG+BrtstndkxO4mwvJGvs49uqH
	DTAza1uhgPISBN0iaOiKEkdknLKjNTL2ilkUevQh0w==
X-ME-Sender: <xms:c3JUZqY4kBRomHFwb_xinde9YKZ8XXRqyFUf11kKVPlcrYhS1FwaTw>
    <xme:c3JUZtZeS8llvrhycGlbQMGHVAkrHMseWwNFv8qjhMw3kB6hh_I-I-T3w80hKCdHW
    L1ip9oiZPaMf0pXTg>
X-ME-Received: <xmr:c3JUZk_982Q_0hFG8LZGfkRqtqP_zZxNIqDyrzXjl-qEzDnQc0CEFdrVkZ5shGfYUVPPJvkurw4YBU_xRo6FNHyK1JjDjdIuUOPxoZjASLj8FSLRZnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepfeehieduieeigfffheeggfegiedtudfgkeeutdetheeuudevffeggfelgedtveel
    necuffhomhgrihhnpeegtddrihhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:c3JUZspAL338AOla5yuoq2Emw56w52pt07pwRqHjbe3fQnHTOlyIxg>
    <xmx:c3JUZlrWz-NMFKZ3SEOq_Ncqrl12jfmJnRnkPG3RGXOym9k3YWfIcQ>
    <xmx:c3JUZqS88eEJL485OTEaX3Kd9xFxrYb72YctSAI0BIbljvuYwQVlZg>
    <xmx:c3JUZlo7NvWpjiQ68_QxdQvTSCWenkS8NEd8LrZbUwzIVelBhbEazw>
    <xmx:c3JUZuD3drArUyuJxl2oQ4eXnGWRfEvLAhKbXcCQ-sJFJPZC4x3hlx4y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:45:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4b408a09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:45:44 +0000 (UTC)
Date: Mon, 27 May 2024 13:45:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 02/21] t: mark a bunch of tests as leak-free
Message-ID: <f305e4bc467a90a09015884b2f364fdf872ce3eb.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fpad05ZY/0jS7tFw"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--fpad05ZY/0jS7tFw
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
    2024-03-26). The fix is not obviously related, but probably works
    because we now die early in many code paths.

  - t9xxx: All of these are exercising CVS-related tooling and pass
    since at least Git v2.40. It's likely that these pass for a long
    time already, but nobody ever noticed because Git developers do not
    tend to have CVS on their machines.

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
2.45.1.246.gb9cfe4845c.dirty


--fpad05ZY/0jS7tFw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcm8ACgkQVbJhu7ck
PpTtSRAAnWfIsV8U+RXkOAoKRaa3hnhiNeMsfu/lRJPpfaAMqOBEqbh13xp+ATMr
p30Broc2/HQlKqD2xH0JQUMAE0bcyuXk0Yj6f3lGVzee5bEKTxpxO6RXvBxR0ZGy
tVQ6UXD+o7VpDpjFAy8H9VwaxSsZktvMCNM49Pvctw2CmS/TpuGZ+kK3b622oSCQ
SowIvtnPx9rCGRUGw3smBpo3qAs+zyMwuSF4cRVNLF6aot1G50uqCHSV5BXy2JOG
ESWJZddN18KMlgy58rYrq0pgnO4qrfiJ3sS8JZCMQ8jbs6SFB8uswUQd8HieS611
Dc6i/5aAMAbi/mtCivWntBB47vPNmPy7UKl4S2OkLMOE+KYFvYwfFV+bFccT/mi4
wpzSNR9GP9CjksIQRcictjVEUeTOllBN/9t4h/NGm8VhmFO9RwMz40ePu/Dphwjg
imO8hiUAXfIfH71JYi6PHhFBKQZy6SulX5uEXPojlVx+GL1wnrW8GWzlagU6d0n6
chkW6aiRsM+aJF/KO+BVmiqsF7HKq/EGY7Hs0Bn1F43dxrm7N+EPmqDjRVmTPYcf
5GT9ieEpHgrEnV5wOB7q1yVABqQY1MqO18Apz5Wg9RFn1wcVDSCbnwUfVNSbbeCX
vBzMXtQwdh5++9/RR9haN7K5hXHc4D21cLKG5KjHtOX41hdbuQo=
=ritl
-----END PGP SIGNATURE-----

--fpad05ZY/0jS7tFw--
