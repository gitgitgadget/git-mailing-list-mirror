Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163C14F9DB
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742811; cv=none; b=STA4ra/qJV1rGMO5i2qU4DcERyQ3Z3hX3o9R7XTdTAbmu99JvQmX7qszo/RaX3AIOaZ7KycXTOE7dkZsdFJdTeDKilwGkP21OkR/fLIjgkMezRgKyedDWy17+8qGmF5VP3nBeb1j7I/fagLSocjPYBiBOUw3JAuCG16TbDj3fCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742811; c=relaxed/simple;
	bh=w2iN7ji5o9WhldeE1kKfKiVY7V8gSD0os3ukzuXcbCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLhk61s3AZOyWp+le+WLZ00mr4ATIKMO0pmuATq0ngnOjkPJy4gCNbsgFuBi2MdUHa8rfVn1SfIFIwyRvwj/UCtINh8zcfzUSd9YnZrb6QfPiyqjwKKiptvHT7qSm4kqJ6sGJwWL12AImKwp8OeYEpGPqCh4pgmq7fk0mTbQ4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ogOqRmSM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RCVOKLWF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ogOqRmSM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCVOKLWF"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EE7FE1140085;
	Fri,  7 Jun 2024 02:46:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 Jun 2024 02:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742808; x=1717829208; bh=OnzHzsbOmZ
	KNPQcUzeyUs9f+AZ+EPf1SZUOC41QFKv0=; b=ogOqRmSMCJVwQx9W4E0ztmqgV4
	g/IZuQ0OiE78jmzYsBwdPa7iCb7dkziDH6XYdsuvfnUKoqaYjHJkR+bfL4UrlTVA
	+On3bSpQoiVWEtqPqEne7Pcq6NuxEDLeqgZbax6iRifFhqfCfk2gxlttpw2VA48H
	c+1d99DqHoqMJJeD+xDegPpWJUEUUR08cVr5Iw9rDBfi7QVDlfv4SCIQNF0qY7cy
	IMbcrVlR/cwDX1xDA+OQA8T4J9Ki6biyslwX4nmzdj8bstAzMI0nhz0ozeB/tgMd
	7AxD5mooG111uJDuI70Fw+gzrqZQrGdZrYZDDobXLECdlY2b93l+uDIi9qbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742808; x=1717829208; bh=OnzHzsbOmZKNPQcUzeyUs9f+AZ+E
	Pf1SZUOC41QFKv0=; b=RCVOKLWFyaCH6tjEfkkG5fLV6c5hRA4jKIziHQSi0fRY
	OHQhgkBns+B/t6YBvDuh6IDWdljdNnhIhVd55FgOiqiZ3kwHCFUKp4S+GYgfSBVx
	1A9oIfRBqBxAPpNEWpGYtXGc111qmSPe/xJeLNBQ6fJXH2K9j8+1vmnbM783ig6O
	VP4riYGw9AaaducK/2fCilVolTUUhxWuCOtPY7tlJXuwXL7Tf609RgHXmtUAbQWm
	v01IF5+asUzTaE6qbhsIizIYJx+3ksjo47vsc0pkv/KmNmhRgngJoLY/4c7vIiwm
	6wCMGJRjdOl68RaotOlj+ol5VIoKSZPnATEM7g5cuQ==
X-ME-Sender: <xms:2KxiZom-_ZT33pAEwpfgDyrWuVcLmqw8yRbJdvfdXhRWPEL0lrYmhg>
    <xme:2KxiZn1SeyVOi38-y55IyYkKOfcym-Nc9iS_UMyJvRxAIdhsexhLz33K1QJ3d5Z39
    i0M3WW__4UyrRPeWg>
X-ME-Received: <xmr:2KxiZmrFOioz6D2tpJ36vWVVVUJeyNTt5IswzJlirfWUXHHXpkL9_tlHYVSy5EYPXPyYtMyNNB5Gr32gGjDPlyGfDS1_vPyWfeZBtvu1HVhIrOt5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:2KxiZkm2_vao5w-FDn9_lcDcgaEAnN9xp05jhp7_NDi3rvTAYkfTJg>
    <xmx:2KxiZm33yJcXFnhVdC66_yzMULMrjbhap9kiTpMCfl-CQzfiNqoqAA>
    <xmx:2KxiZrvjP063WDnXL-Yl5vDo0Gv32CT6JBr4KaPikJgz8GFU8yRhOA>
    <xmx:2KxiZiWKz0SmOdHfA32zMCsTfu7TQPQoIBE9yWoA0E_eNbNIytDJ5w>
    <xmx:2KxiZrzlXLkDNRxinco7KGXto9EKuNT27qXZrrwPAyXybQzjc6BLqjHL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:46:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 763a70dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:46:46 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:46:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/4] ci: compile "linux-gcc-default" job with -Og
Message-ID: <c7b5b62d9c5b6c737d9afe3d32382ccf835e23ce.1717742752.git.ps@pks.im>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717742752.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T88NZkYpO5l/UCS3"
Content-Disposition: inline
In-Reply-To: <cover.1717742752.git.ps@pks.im>


--T88NZkYpO5l/UCS3
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
index 2aaaf40f94..e5fbe7f531 100755
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


--T88NZkYpO5l/UCS3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZirNQACgkQVbJhu7ck
PpT2Lg/+MdWYBCsLj6QasXBcGaYEwUmn7BshBrok9yZNSQkhiZJJoP88hhA8PaAb
Uxgbwc9YnnBAHdv36vk9ttpaxZKpwaK3OL4HzJAp4s1YB75t6pMMBfHiUNO+rFoI
4d/CCXNDHo4LY4eA+n5cpYDj7LFLF4/CZM3dAUrG5hUy5rcq3uv9kiQVyLoaob8P
C6H4B+K7pQuiUEaBLFhFWeNGGFontWDLkE4qkhXcgl7qCryGOxc+Ko0Kh9hv/OWX
QDv0BHgViN2Dm7tIanhaA8Xj5yvqjAas+c6vBHRP5U7HMfAkQjy/8w2dXFzez7kR
po+pjSJX1UGGsn69ihuwFTycIGL61hcpYed+MrYNPh5ys0KCgfWbqTlN5VuenNlp
fMbQ87P+l6Ugp2Y0s6GwoT/MG7nCf1fI563Tg4gEs4CP51HftL9R7PPElWIMe/mp
cfOaU10v9oCtGLpYAjt+IVf0+G+Yb41sFEwz9sp2hm5KHkypXazjXTfM+eDLfY6H
Pn9LjwxikrlmoR67rL+XalcBacjrsJ3JN8c2N+nqAzsdHRYc57eoCOFejvPB3OiO
lRltj1zo7Z8eSD3PaGi6V4/V/o7V56g1S5wZiD/ug9W0QWywc5hKNS2hXr9MQyNs
PscrozmikQev66Era5jUNV8JvdLVu2xXmOsBshij02Z137Yryr0=
=xu5b
-----END PGP SIGNATURE-----

--T88NZkYpO5l/UCS3--
