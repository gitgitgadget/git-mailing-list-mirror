Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7273313C3E7
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467121; cv=none; b=jNWBz3TKvVWGv07zoC1WhdlfW6aCFspTJxV+dtHi54EerMSs+PECGmVOIfl7fMQbkCFoXNZuCzvBqysJiGBwT6PjntVH6vSPtNRnbuVkiaMQ69WVaAsPDzrE4cwjrJvTzDM/DyzDob7lZbrKf9hFz9zniVoY+fDGHIknRvKXrH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467121; c=relaxed/simple;
	bh=0D2pjz+7570U0QXNQeC/Y6N6MUtfZaJrAELJsOOpalo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPJu8jIJTLEal6xKI/kb37K3Qd+/Zm94MrnZ9s10yeO63ifx5yqGaaG+wmTHjAYSc4XcnfARSccWRMcQp1B3epweWdpkwjoJUYcJnWKsTQL1CITAlp0G+hpRGtva5xzRRHopAAuL2h2fZvWwtPqMdgXukgazBfnmfzzsc/l8ylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hH94HE6f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXbnqhoS; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hH94HE6f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXbnqhoS"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id A5F261C00127
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 May 2024 08:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467118; x=1716553518; bh=k6JDapRFcI
	DgYbO9Etg3ck1/zf04+uup1pTcQiNNse0=; b=hH94HE6fDu6+nBQUZofmmFT9Pz
	zSr1krvKXfRVJMJy9FyNnG944O7Uyc5yrkSSmmWAAA4yMQ+9utWpltkSJOkli2s2
	XoCYxur0cbub21QIPWNLIYxVQthFepMtVnzDbHv32Hu0Sttuj3pE32Kx20tbLfr9
	Ts4C5VsDj9s0WdFPUFDZrwW11tAKqF8YCuYCcerkE94huZZdmIVYv+rKCcNbmgTd
	0q/UpZluUfcVU/rwOqvpFcTgX8iiuCF9YGkau9KYrASJeehXOcvm3MXhx0yxtZom
	PCQeT+zO291ofhn+4R7sXe3ITcmb0DUQ2G/wgb542QEOFXLXAiOrtDCYGARg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467118; x=1716553518; bh=k6JDapRFcIDgYbO9Etg3ck1/zf04
	+uup1pTcQiNNse0=; b=SXbnqhoSU+IXI4LS6mkOovf4oU+ysrqBi0qxwh65S0QB
	r++nNbVMqan9irMCIFG2xzcZBPyoOeKd8p6DfdOO05y22Yc2vTnesnqFAQaV3qwy
	oovvz06ey7pEWAttqj6CHGKQ0YBlItGwEE6WnEErGI3pkW8l0D6lHKkA/j/gC32g
	W9YlwBmVXwkUQ7SrVu0rObuXkbAGk5byUKu/MZ/Oi33Ci3xNA6x5Xdw+IGXZydWn
	RMQtZVsQDygmJfCW05qXo+DPb0gvUeILPBVKO8kI92FZB9IHH6I2+4EBF/XO2iyo
	v/3mPFi3D4YuNRlnK4JdgZ77wfc0RBYeEJQx8QwPeQ==
X-ME-Sender: <xms:rjVPZtJvLIxE63y8mUuKW0vc6Nf2K1FKlUJ70JpT2n9gJOL3BkfAMw>
    <xme:rjVPZpJk8BQaUTJjsoshhXznulRRUj-hFkjUo20vEUBjISX-F8wIGh6GIJXRIptKX
    rE90gwenqgDBjRrgw>
X-ME-Received: <xmr:rjVPZltWri6QRTXnK7H5_GXyXzi_ch9nDpz6OOzS4tIhBt1i3cU8SsYK7G3-lknaAbqBSXu0SZoql5ewAspgui140pvujFi42-7KP-wwKgQ9NLc6wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefhteetteeufefgieeikeelgeffgfekhf
    evffelvdeftdekffeltdffjeetvdeunecuffhomhgrihhnpeegtddrihhtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:rjVPZubyl0zQ7KBab9PdtHXdHoDt9l-s89p6MMT4uxdyCs7NBxGAlQ>
    <xmx:rjVPZkbUOL0X91wzRSI68xYgr7LU355nXkTxv7ISBMpK6uQOoaHn2w>
    <xmx:rjVPZiDiV4XQodZ1jc0QPFdoRUiEgnU1KBJvY0SWt1mNVlqwkmu_aA>
    <xmx:rjVPZiaZsWP3CwOP-1b7BKfKVl0v9GlgTdOd6ybezLcF3DriBmvkTg>
    <xmx:rjVPZvw0CFC5g1oOFbIJnYhZBrxqulcj1nie6QH_3XMT1pPc3RRaIg-M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:25:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8ecb08ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:25:11 +0000 (UTC)
Date: Thu, 23 May 2024 14:25:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/20] t: mark a bunch of tests as leak-free
Message-ID: <0e9fa9ca7386f527903887242008b5b0443ada69.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HtnG7sxEQr+9V+wU"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--HtnG7sxEQr+9V+wU
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

  - t4153: Passes since 71c7916053 (apply: plug a leak in apply_data,
    2024-04-23).

  - t7006: Passes since at least Git v2.40. I did not care to go back
    any further than that.

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
 t/t4153-am-resume-override-opts.sh | 1 +
 t/t7006-pager.sh                   | 1 +
 t/t7423-submodule-symlinks.sh      | 1 +
 t/t9200-git-cvsexportcommit.sh     | 1 +
 t/t9401-git-cvsserver-crlf.sh      | 1 +
 t/t9600-cvsimport.sh               | 1 +
 t/t9601-cvsimport-vendor-branch.sh | 1 +
 t/t9602-cvsimport-branches-tags.sh | 1 +
 t/t9603-cvsimport-patchsets.sh     | 2 ++
 t/t9604-cvsimport-timestamps.sh    | 2 ++
 13 files changed, 15 insertions(+)

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
diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-overrid=
e-opts.sh
index 4add7c7757..6bc377b917 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git-am command-line options override saved options'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index e56ca5b0fa..60e4c90de1 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Test automatic use of a pager.'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pager.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
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


--HtnG7sxEQr+9V+wU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNaoACgkQVbJhu7ck
PpQXvQ/+MSvqfnBBRaCV/lFWKJ1K/j92PuZ/awdaORtzIrM+V5nb3cXcPyUP6jEJ
o2XsOZuIaCzSBW5JL1JzWGx+TA84tND8lpNZngTfkH4F8lYKlVEVyUEqWn+4ThHN
HNCShFXAvOvuLq0khQh7JyHcxtd6J1s6qqfHGqJHnnDrac/MWGx6rCPuq1wD8zP6
MAYnyKmyB0isuMZiZZMNhSKUPwtoN3qzFWeEwQ4TFA2azKdpc3v/RZbcbQRlZtua
vajaxWljzsc+TcFaJIk79CkpuiNfDkekgEyedLkq8qy4Y6U+zy8/xtisDu6SOGNK
6MHRm3PhBzZv0AsBt/iFPIfoEbaTsy17FKKL7dfm7fujebxITx6M9iatM6E8cHzc
dnmpF/y+BhMieLAQletRDjxHwHkds8JXxPQsnE8fkcF5ZvABTcfLKOSfATKg9kZI
86smI8dhtDjlNVW6BVNgK/79emeP0NvjccKRJ4TkWv9JvJLLuAXUKVSTRPRz412a
dKfD5kyWb+uptlxEGqvRrrDiA0uu3pfFolkbxv77oDlK18dnhVzfT4MAU79PgTsg
jrrEzNfw6cFpMARaHpF39IyIPhHq3gZ0O4WPIxPwyVf3yO+Fx2v7zXjo/AjmxC6g
jm9ZaAdY9B9B4iJnXCh4EAqfIf7e9ZQTu+loqbjH8uJFvKojWfY=
=2A22
-----END PGP SIGNATURE-----

--HtnG7sxEQr+9V+wU--
