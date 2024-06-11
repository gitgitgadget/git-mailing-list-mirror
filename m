Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A34317624A
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097686; cv=none; b=mx13b5jek9A+LTGzaQ9sEog+n/UMbIH7KOpt/1gj1xGrGTCXf64954+N2LmRoY/m+dbm1IubfRIKGuU7IOu4RNpxDWDtjcE+erB8p7qABDTrAguu2mRgqI9s2MpVZmDC+FRwZZOPMhJ3cRMSl8bDsHGue+ein7e7oC3BSB9bOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097686; c=relaxed/simple;
	bh=xmZ44wxhpb/uRKkVtog915Du1i0vx/N2qP0RsBYZ4bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3YzjGpVvhJ0BDc+7VtLEiBdI/sWqIlQDmQX1yQp7UKq9Cr8kLON+QFmJB4G9u5TQhg6/J/M1WCyIKz0Hg3zLgF9RqeashreiM3lLdhTX7rSBxz+OlxINSMxJApHRdTU1Eglizo3hzqwAhbEZwoPzVd/52jRZDsi4Mvlv0hmTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dLZC5d0q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CvlBUizG; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dLZC5d0q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CvlBUizG"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 38DE21C0009E;
	Tue, 11 Jun 2024 05:21:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 05:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097683; x=1718184083; bh=epuUICrvRw
	QlGULok/KMoGm3AwXfsXikpDPVEBYf/0k=; b=dLZC5d0q1jbmObo0g+G1wQk8gI
	EIbuBWGQ19WGPy7zB0WR8C6mW2Wozaj7oEupR0EGNZAjKBZqjtb0a2++KOQuPH0q
	HZeMxrR5nsJYHLfcyE4GJ2LLqNvZzuK5akdnW0mTbpQrg0X/y6s2aU3EqtI116q6
	UwHQeNmqoUECL/j+HrMVrRacluqj9Mcax5hnkYaVMY05+gEumlqKPKI7DcRrMyBW
	3m0NGKXfoo5ZNpm7bY5BT/XWrb1On/dWIB6hEtNW5HUAyF6wtup0UshVHxGM2god
	J4eh3BVGQCcdo/ZjzUBKiJ1KMio0mqHzBg4bruO6aCQGysXBLRHKH50XX1Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097683; x=1718184083; bh=epuUICrvRwQlGULok/KMoGm3AwXf
	sXikpDPVEBYf/0k=; b=CvlBUizGl4Sar8HTEL178AE/36pSeIf0sDWNvSOtgdUz
	tGmgHcigbhi6Vx9CpOfMPHheGvaCQSQ3Ty22SeZ1Ivy/UNXy6coThmKeKEINjvZS
	370SF+ysHNovzF2X4r/9mug2pFDY4ju2xVwRE1H8APtpJSNDYk6uSH4QnUrWeuCg
	S2sunmu8uNv17zQr8wiEU+2zihr6jcL0h/6cvmF0rGs2Lv8kAdf52gYmZK9l8d2W
	16vNmtBJl5VFlAvmHYUlaQAFDeZ/zL9thXtCx69zuzf3cuicbiKcrzKDkVhr1hZx
	laxVIHERAcFSW2Ep3juPo8FGecFXYs9bihM5286J7Q==
X-ME-Sender: <xms:ExdoZqj6YtEaP4OQwbmoV1RNgyUiayuvlMVFGpek5cdwDVKRu-hTdA>
    <xme:ExdoZrDFLR8brYAWQyTgjMeMyONRIWoQrb6jUXiFgnXd5QsO2OqCqXYrtf8jVr6B6
    PYbXCtZ0OzZjOaVYQ>
X-ME-Received: <xmr:ExdoZiGkuTvObkzMBTYLjnwhY2l4vcuzMM6iExTgIXlMDGalo_76S8ZimFoNFyL_vxXLRHsGQmCuS8jc5X8kW7ZndV4PmcAt7qar5QwgGOpbU5Q6Pekt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ExdoZjT0z2gKVFZhrtOExmxUrlSBpJxvga8EgnIWJuCGqlWDYTNjMw>
    <xmx:ExdoZnx2JeqImZja_TUAv2YLNM9KBmf7-AWeFYdHy7nHG7aoKZzkiQ>
    <xmx:ExdoZh53nZ3wLroBA8w5uG1s6fuqVdJYTj2YzBWpTbmwcdzaJ-fyaA>
    <xmx:ExdoZkw9VtvNcMXZcYnUTiWPX8t5VyV1Grw3gw2qJzG8F-DXiR_zIQ>
    <xmx:ExdoZn9iRt09JoO-YvxuQoDhsWKeQdt8xTimThJPcmvZISCnUYN2SMqg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:21:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 313184a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:21:13 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:21:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 27/29] blame: fix leaking data for blame scoreboards
Message-ID: <bd6db56a3f926abf73939e5094983e630a38db27.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2xpYvTLbgeDVWt/0"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--2xpYvTLbgeDVWt/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are some memory leaks when cleaning up blame scoreboards. Fix
those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 blame.c                           | 4 ++++
 t/t4061-diff-indent.sh            | 1 +
 t/t8002-blame.sh                  | 1 +
 t/t8004-blame-with-conflicts.sh   | 1 +
 t/t8006-blame-textconv.sh         | 2 ++
 t/t8009-blame-vs-topicbranches.sh | 2 ++
 t/t8011-blame-split-file.sh       | 2 ++
 t/t8012-blame-colors.sh           | 1 +
 t/t8014-blame-ignore-fuzzy.sh     | 2 ++
 9 files changed, 16 insertions(+)

diff --git a/blame.c b/blame.c
index 33586b9777..f97d0e9e1a 100644
--- a/blame.c
+++ b/blame.c
@@ -2928,6 +2928,10 @@ void setup_blame_bloom_data(struct blame_scoreboard =
*sb)
=20
 void cleanup_scoreboard(struct blame_scoreboard *sb)
 {
+	free(sb->lineno);
+	clear_prio_queue(&sb->commits);
+	oidset_clear(&sb->ignore_list);
+
 	if (sb->bloom_data) {
 		int i;
 		for (i =3D 0; i < sb->bloom_data->nr; i++) {
diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 7750b87ca1..2942e5d9b9 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -6,6 +6,7 @@ test_description=3D'Test diff indent heuristic.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
=20
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 0147de304b..3596634039 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -5,6 +5,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
 TEST_CREATE_REPO_NO_TEMPLATE=3D1
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 PROG=3D'git blame -c'
diff --git a/t/t8004-blame-with-conflicts.sh b/t/t8004-blame-with-conflicts=
=2Esh
index 35414a5336..2c2a0b33f9 100755
--- a/t/t8004-blame-with-conflicts.sh
+++ b/t/t8004-blame-with-conflicts.sh
@@ -6,6 +6,7 @@ test_description=3D'git blame on conflicted files'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup first case' '
diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 7683515155..42f8be25a3 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'git blame textconv support'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 find_blame() {
diff --git a/t/t8009-blame-vs-topicbranches.sh b/t/t8009-blame-vs-topicbran=
ches.sh
index 72596e38b2..30331713b9 100755
--- a/t/t8009-blame-vs-topicbranches.sh
+++ b/t/t8009-blame-vs-topicbranches.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'blaming trough history with topic branches'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Creates the history shown below. '*'s mark the first parent in the merge=
s.
diff --git a/t/t8011-blame-split-file.sh b/t/t8011-blame-split-file.sh
index bdda0c03fe..da1801f4d2 100755
--- a/t/t8011-blame-split-file.sh
+++ b/t/t8011-blame-split-file.sh
@@ -10,6 +10,8 @@ Note that we need to use "blame -C" to find the commit fo=
r all lines. We will
 not bother testing that the non-C case fails to find it. That is how blame
 behaves now, but it is not a property we want to make sure is retained.
 '
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # help avoid typing and reading long strings of similar lines
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index c3a5f6d01f..9a79c109f2 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -5,6 +5,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
 TEST_CREATE_REPO_NO_TEMPLATE=3D1
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 PROG=3D'git blame -c'
diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
index 0bd0341301..933222cea1 100755
--- a/t/t8014-blame-ignore-fuzzy.sh
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'git blame ignore fuzzy heuristic'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 pick_author=3D's/^[0-9a-f^]* *(\([^ ]*\) .*/\1/'
--=20
2.45.2.436.gcd77e87115.dirty


--2xpYvTLbgeDVWt/0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFw8ACgkQVbJhu7ck
PpQkEBAAjdzKhf0QHhkyZkmDkdQflEdiw2A0kfK6eUaF/RzD8poHYvjzCQodvA59
iCwQXOJC9loAM0gNXeOU3bv33QsCsTk406gzoHF1QI0k2bVlmQEWIf/7j766ADNz
X3/gba53JXre+eKXTj9IcEh0Bg/hKiZqXdhjE0/N9tyB+8a2hUoR/zq5dL61xkAo
6Ii6HQ04kExZ549HsIlDsgfLpS7g4przWX8vefNV2qB57Fl/ZjOYut7FAmzP5uTA
T0Hjl6zLUTgKQz0h59xa9Bp/453NOZehPdRBZaRY6PlQf+1QhFl1JDGB+i7vAkHC
dlk/4szyZuKv3fSvx7NWXHcztEZxINOchiyIZjYgnzOveUynUM5HZNKk1fwKRbxB
OYmBWOAxLIVQIxwf0WXktJVRbxD9YbzVttCg9biA7yuROVTH5Fh/omiWQgVpr887
0WZhNzCf0nLk4leU+2po/LErG36aTBjTdzrzPWVfMLfr89LgMXI97nwkTzJkr3Qk
wqnGaZGb5a3x6VWtcXtwsyEe/BXS3HIISScsOO7MzZHRUCX0T/oiNBtFac55lEHs
dm6fPKjgnEpL8Zbx/1IrEgyNXSRMXCuRIA+CwZoz6tVWKRqEmfr0BpSSBeyHu5LT
GlSCGwTGxNNTfNflalb20U6nJWRbhXEWcrTIY5PXAviI9Wl6eaA=
=HzAa
-----END PGP SIGNATURE-----

--2xpYvTLbgeDVWt/0--
