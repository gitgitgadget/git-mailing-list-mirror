Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE77153BC2
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666314; cv=none; b=RNl2ZMqDAMh1NgW5l1A6FWgpQJQIMrzKccvkdbdjDgMXXJm/pt6R+6mMGTzapXWB/vs7matdFGmgyzSAnPTHsiDTxk1wR+5WX6ZdzePJ+5KuHMBZzhfqw6y3L5z7+2k0mUBqTphsfATN2DBgCwKfNaH/hQOGnoTB6wP9D17DB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666314; c=relaxed/simple;
	bh=yuwBIyCrNeAhYtQc/pth5ZynEH4S7DOcRDT7pCdJ2Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqcQ5T5Pv4mVPQz6C3UuV3bGt0zfq+exkgHoBY6hpW599Jhv2HKATn2O8GxvsutXdWhyq9xmgpFVCFkIHS7Sn690fagxYQAXu/1uyYjFSyG67IwBfkY6Jd+HmLKHwN2uoBgQkkv4t5Is+q3v+joHBMiBkTtBVF1+IXcU6j5r08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d5R/iNU4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fNOn2/ah; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d5R/iNU4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fNOn2/ah"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 27099138010E;
	Thu,  6 Jun 2024 05:31:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 06 Jun 2024 05:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717666312; x=1717752712; bh=FL+jlV9UQ4
	ryboSf3SFsKrfdd4joKMyrlyfQ267iwqg=; b=d5R/iNU4By9Bbno9QZv+xqcShv
	8PZ00q+FeD9VYRbiO0/cqLdPpT7bxzJjiMsyjg75keP8JMTjvD5AM7SrxLmXf1dH
	09otcLfMGijK4rsxCj/PTEwpTo9DyTJ6+3KYlrQoyrenoXQgBEjk1dIhLFmMtGu6
	0Shn5WPjc8KGs/A2whbKS0iAlMQMQheT82eg+7A04E5tCHoZyKN55g0nhmbP7YY4
	XaODTAl8AGzN+lCoYHHR9IxXF2BFlpKek+GHE3itZQVQzL4eb/WOXvZXNGPPmyLi
	ON0v7Iz6jYg2P33OfMWCZZzyiIdF5OEb02fYPZOKRMv5PG3+NlHI7JD9dN+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717666312; x=1717752712; bh=FL+jlV9UQ4ryboSf3SFsKrfdd4jo
	KMyrlyfQ267iwqg=; b=fNOn2/ah3kwJJIXg/cuc1LUdypA7LLvfWOSahiYuWq8Q
	yl+a7sGn8mh+dTYs7cXl7m3OFGTODojXTqNsjcEDfGrywFfjIlbqBR+pd9OAMfkh
	XvYGEyiGE6Dm0rKENWFkits3IfFTShEwK9PIWdoxhYValRAOBvpe7Oqy+ycSpvh/
	m1xqJSceQdy/QVV8AfT63ULcA7zovPfbUcrr4ktDu6shETT7cM8nIi+wQvYlBUZH
	T2Vl2MA5OE5Qmfqt0qT7qPeCYG9oE2oTYdDLktUI936b/5xRhBhcF0JmUJh8fcCW
	bbbIECZkf0DEcze40+fu7H8a8RbQ4xORlcc7R5ZSaA==
X-ME-Sender: <xms:B4JhZuO7369vlxyM_uikG4-cAH6HQBmakAfystHJQFd5JcZFXAr7Mw>
    <xme:B4JhZs8NSzxnyL3qTX-lNN6GO5VViHP6ZabWSTmt3kHzBGZOEjh9lFvZD39tY062K
    4tgJ0ccagP5Y41KPQ>
X-ME-Received: <xmr:B4JhZlQzkU5QpB99cRbPplxZJf4Z6KgHw_euReQe5Qe-DhmJuLfN484fMThu5bqdLGYMAxJV3oyztx193MqCAZfgt7bkTTu679fwJ1T9_c9VQM5->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:B4JhZuu-Q1aNWP7enadVPodITVihF1I7UfLYLyqTaBJQoj0g67obeA>
    <xmx:B4JhZmcwR5_veUZPoc2HdGPaScBJp2-nb4hUHWWhBb7cbbO6Noritg>
    <xmx:B4JhZi3CpjgqVMI9qLzi_8qTgXmJ3cKPxXjkUhBbWDVa0qs9rM-oiQ>
    <xmx:B4JhZq-sjmsra2Bm4EUsexAI0B7iPuIxoOvHfIwdGLc_nR69cFuWfA>
    <xmx:CIJhZm5gQsn8M6B4FCtoGEj9HX17wFqo0bO3ATYF9fHtulh-TAVRfqOZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 05:31:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id df4cb0f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 09:31:17 +0000 (UTC)
Date: Thu, 6 Jun 2024 11:31:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] ci: compile "linux-gcc-default" job with -Og
Message-ID: <bdf0e40a770c57b63e7519983d37b97a85ce07bf.1717662814.git.ps@pks.im>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717662814.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WB13/4tIfqQEiWz+"
Content-Disposition: inline
In-Reply-To: <cover.1717662814.git.ps@pks.im>


--WB13/4tIfqQEiWz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have recently noticed that our CI does not always notice variables
that may be used uninitialized. While it is expected that compiler
warnings aren't perfect, this one was a but puzzling because it was
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
other jobs that use "ubuntu:latest" so that we do not loose coverage for
warnings diagnosed only on `-O2` level.

To make it easier to set up the optimization level in our CI, add
support in our Makefile to specify the level via an environment
variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

I was a little torn whether we really want to name the variable `O`
here because it feels so easy to set it by accident. We could rename
this to `OPTIMIZATION` or `OPTIMIZATION_LEVEL`, but that's quite a
mouthful.

Alternatively, if we don't want to have this variable in the first
place, then I'm also happy to adapt the script itself to pass the
optimization level via an argument.

 Makefile                  | 3 ++-
 ci/run-build-and-tests.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 59d98ba688..ff57c94fdf 100644
--- a/Makefile
+++ b/Makefile
@@ -1357,7 +1357,8 @@ endif
 # tweaked by config.* below as well as the command-line, both of
 # which'll override these defaults.
 # Older versions of GCC may require adding "-std=3Dgnu99" at the end.
-CFLAGS =3D -g -O2 -Wall
+O ?=3D 2
+CFLAGS =3D -g -O$(O) -Wall
 LDFLAGS =3D
 CC_LD_DYNPATH =3D -Wl,-rpath,
 BASIC_CFLAGS =3D -I.
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 98dda42045..0f00dbd289 100755
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
+	export O=3Dg
+	;;
 linux-gcc)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 	;;
--=20
2.45.2.409.g7b0defb391.dirty


--WB13/4tIfqQEiWz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhggAACgkQVbJhu7ck
PpSTPQ//aClmx+wKrEhgGNihy0V95c9ThMWFgGRV/0JqeMqM790LfFZh7zxAlWxT
6oz3T+Lerocf5Di1nxTTwWiGeSym4Vzf5D68k7rv4yWEZCHnwUGm9ZZca1rzh+CP
8aUh4J2ZqD38gHoY5ol6MYJVJ9Le9LWZAsfWoUT62pOycf8AjECL1k3MVQ4HRvrE
4cSMLWdbIp4u1w7f9VQ89SGWFovlLkvVYqcrUes1sslO86Oukf//9ssCEQ1LrGHe
LZHmQZEq/xCGYbcOmkhDyucnQY3dlYXmqdDxuUca3wp5ewetEpO5zSUs3zinfq71
5BBGMQIkZt/xaLmCrH43Hb4wzZmSS+zEehKH380W9dg2vfGraSqOkxieSQrDJHV/
l6ANQm7Mc59jGBG9dbMeRkhHf8PKLZ890fL9pshVNgd4sKjsCI7iijPWQ7HcFG2o
6dK9J6QFNRCVk97UVt1lgoWD6CrWQVdTVNn34IFp33iHFURh1tQ/gcMy77xC1Unz
ghihAlF7c6xkUfV+liJ2BdxI5ZaTAfn4/GeNzzdS0TQAfsbJqAd2jfVdDEdTK7mc
0+NZ3Joq7f7ZIdMey06HVKLAVfAeVeS8aALS103FNuzTp8UC3BsxEo58VTx1gclX
J7720us9NuQ4LrIUhu0eerYW+tpzkaMHBGqh4cz+/W/GXfQ0GMI=
=KNcE
-----END PGP SIGNATURE-----

--WB13/4tIfqQEiWz+--
