Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0201BF2A
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001511; cv=none; b=jgJU1NPIlzDuxy+PRdKCGAqdHTUyNHuJPFh4RuQoE8FSya9eZPLj5RbHC4YlNTe+oA8GjBPtCDbW4bOG9xPqRGTc8s4QBTcaFHrFWEGyuLO2Lqla68n3O/f7eMBjBQhVSJrHOt9jzjGHCMReP7Z6oUS3Fj0vIsW055WGZbF9ENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001511; c=relaxed/simple;
	bh=23MU8QhdrWYAA0snxcJBjtAr2tozhvI4VMJyAs2875k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3lNlnvcHbdl5u4dxeogtC+der71nzyyf4i6RZuSOZ8bvl0YbFDd3I57xinc0oN1Op85R+Bwm+9C6aPXwyO4IvGnFCEiPuXHKYvR/Ww4maDaxB10vOXSHl69slBaDxcXbxa+OuTbRVAEOkJLX7dPCw2xz5oVMplIkdV+NPSUBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Em4p1ob0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xz50JU+h; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Em4p1ob0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xz50JU+h"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 396E11C00122;
	Mon, 10 Jun 2024 02:38:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 10 Jun 2024 02:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718001508; x=1718087908; bh=5V/ZB05/+a
	YEt7I2fCifiE1/9/fuTyFb1sL4Y9gLi4Q=; b=Em4p1ob039lS0Nvc7fD+ksQ3jj
	YDERCrbB+rpFyCD8MurMUNyB3t1Qyl5CeOPSp/94gQ624jFoca9ue7xpWCqJqlVM
	QTOt55UnYQbzfvsbfGSZkqQ9SKZo/2jONiUsqQL2XwtzDWk9QTqtJsNQNkVTVann
	kSo2Ki33ja/vQ7Fxb/7gg2V24ba7cK7aLaTxqBFeFOJfe6iI+1TMuj8QFKb/I6cN
	0sbgk1Ah1sSyJ4ib00hnEeMNK+/i90UoLSF35WEtNmMRBK3LqS9c0hZezU1U+Qpd
	GT6ltBP0303CrZj51KmcVZgaHzI3c96ICi+L5VLaM/2smD879gp0M0dRqGEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718001508; x=1718087908; bh=5V/ZB05/+aYEt7I2fCifiE1/9/fu
	TyFb1sL4Y9gLi4Q=; b=Xz50JU+h3zBSMANUBIcogjPtele4zN2aXGjw4dEz+9DU
	aA5TWx7B3jIeOnkqk3bKItxoWnwgrIQnIVfYECPFwU9JPiTQ0Wme/zGE48y1UzwK
	cdoZ7oi0kGKEpIuZAuyjCbqIHjDJ/ubL551WLJOPch3MdoeA8iYbB6lUTl0QC3nl
	X6Zmcx+un9xJ6bJxeiyhiZ20kpYoDL8xx5DA53Vs5IneQrHCXbjHLoonizdCm+sQ
	dQDm+8iSaahq8HB0O5vMpMM4dBo7ujEUWAUjlA/IBvd781+bP1iElYtDzMqrLCKY
	YijuDDQLYIfVxIfB7PXEZCVGeMDpxin0e8OsI2hFVQ==
X-ME-Sender: <xms:ZJ9mZo5PquIH6jov_j2hDRyAZvurp-qNfmpVKa6Ib2lM0sHlr5xi1g>
    <xme:ZJ9mZp6P20iGkxLXLRg9ZoIv_nbUM5qrk73rijfq3Wb592v_CgwhHyaQdPE3ak4be
    eWNTUVpvjscoFB3Vw>
X-ME-Received: <xmr:ZJ9mZndyjKmvqkAm1xLdRBpQO5JLe2FaTGjfSaK_NEt9CKb4yKY9Gh4XKnN6-EjhQWBAIpZMrv4BjJL6c3ZJdxh6rfMZ7bSjR9QgQso3QpEbFDWe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ZJ9mZtISO1xW6DLbZiw6DPmUv6lVG3OqS3u3821RFkvxsBxYW464rA>
    <xmx:ZJ9mZsJz6wmk00FGXkfVVrVe9B1gTGoWTF-YU8Q5nRcrot66IRgfLA>
    <xmx:ZJ9mZuwx_zYNqdhHlP0SE6c_VW8K094kqJQTSpMNjPcVO0n1_3BkLw>
    <xmx:ZJ9mZgLbr9GbJ9PhWAaZATSELKroQRn8efMQDKJPyujpXHqe0--IvA>
    <xmx:ZJ9mZg1pq0e5HjGykBaONeGTQcHiGH0_yl0mLNPvAV5n3RuYL3cdl8lR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 02:38:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eaf38979 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Jun 2024 06:38:20 +0000 (UTC)
Date: Mon, 10 Jun 2024 08:38:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/2] ci: compile "linux-gcc-default" job with -Og
Message-ID: <03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
References: <cover.1717655210.git.ps@pks.im>
 <cover.1718001244.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xozUxVfJ1xVtKt8g"
Content-Disposition: inline
In-Reply-To: <cover.1718001244.git.ps@pks.im>


--xozUxVfJ1xVtKt8g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have recently noticed that our CI does not always notice variables
that may be used uninitialized. While it is expected that compiler
warnings aren't perfect, this one was a bit puzzling because it was
rather obvious that the variable can be uninitialized.

Many compiler warnings unfortunately depend on the optimization level
used by the compiler. While `-O0` for example will disable a lot of
warnings altogether because optimization passes go away, `-O2`, which is
our default optimization level used in CI, may optimize specific code
away or even double down on undefined behaviour. Interestingly, this
specific instance that triggered the investigation does get noted by GCC
when using `-Og`.

While we could adapt all jobs to compile with `-Og` now, that would
potentially mask other warnings that only get diagnosed with `-O2`.
Instead, adapt the "linux-gcc-default" job to compile with `-Og`. This
job is chosen because it uses the "ubuntu:latest" image and should thus
have a comparatively recent compiler toolchain, and because we have
other jobs that use "ubuntu:latest" so that we do not lose coverage for
warnings diagnosed only on `-O2` level.

To make it easier to set up the optimization level in our CI, add
support in our Makefile to specify the level via an environment
variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 98dda42045..40106c6c36 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -13,6 +13,15 @@ esac
 run_tests=3Dt
=20
 case "$jobname" in
+linux-gcc-default)
+	# Warnings generated by compilers are unfortunately specific to the
+	# optimization level. With `-O0`, many warnings won't be shown at all,
+	# whereas the optimizations performed by our default optimization level
+	# `-O2` will mask others. We thus use `-Og` here just so that we have
+	# at least one job with a different optimization level so that we can
+	# overall surface more warnings.
+	export CFLAGS_APPEND=3D-Og
+	;;
 linux-gcc)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 	;;
--=20
2.45.2.436.gcd77e87115.dirty


--xozUxVfJ1xVtKt8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZmn2AACgkQVbJhu7ck
PpQlKg/+IFk2Zp1YvILJrywH0+gQ+fHzyyeGrPZPkqmD9XEFs2I0xxY+cZXnhWfO
Xh4S8HWvWTmItJ01UzzuZCnbswvbdYH533cvo7b8ObKEmNpez8aMuPWZAWhyJ7sx
dFD+hapbCGxGcjVjwNoOtXuNwequefnOb3C442TD+6UwtsdAXBI+KPVXIxkeshBY
qeYnLhereyR7AHEbQK3i5sAFoQXCv0XezcNtdJVsV3anZgaEvNsbYs4d6cJH02PO
jm2wW+bHbnHf/he7Iyo4C2OxVQcgo4pOwRetdZCWxxl1yxksBTiaiqe6N298hU2C
6e6wb7Ot4FPwqs6VNMoR26VsepLz4JAk3VzjQRp2zsd3NgMj2i8cZZqQnjcmeX44
1SCG9pgubNNfLd61XnFvLMpFmNTl353oAqY5sMiQJRZaLtXg4dDAz2zTh2+kMtvu
ZjKn57ITcPlBIMEM3iAYnTeWoQu/72fGcOmvoaeRStoo9m8eT3RDE7LYqbbfQ7z0
B/Qyqm7w2fDBvxLHxso0kCaMWnBijfniwGtZwMJ5LdUxuquGhqw75bSz11IzkAaz
I9MHlJprWxldU3HuEgWgA1B3g2Uti6wmmxV8qIS5luI95Z1f3oi4xiArD6Hy/801
dFubkT7LeDrSaNVlIOkCup8BoCupcA3YR/sYHFDSJG062nm64iE=
=EbZf
-----END PGP SIGNATURE-----

--xozUxVfJ1xVtKt8g--
