Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B433F7
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655440; cv=none; b=fCVAzW4uj57lSn0tXN2/c3h7K3QZYEPo35DetsgC5xfYP6qi8H4DWL7j9pAbMOTTMkRVgc2h3dVDU5yNnfKB/KKQ3EhJ6B9B58JWwSV/Qur8m/php+eHiU0ljYMlyl1gx5E+rSSPIPcERZBS5inK75YnrN5paxPMP4DhRNIE3+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655440; c=relaxed/simple;
	bh=sB0kqqBX3P3JaRwi1G4uDcdbHE7B2nAqKxeq+hJWm60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf4GdDpWOKFVReiHbRkmsiAVDy3jPxKOfHVlKvVNSy+k9cD+oNPwv7D8yXgiFYGr7mqIAbwSubWwRa8qXULHQpdm1crFT9S1nsk72mBa5eNJqI7sfKw+fkrPfZ+btSVFGTDg0+qQ1IRN8y/rmZLyKGKpxiyD4P/+j+gZduRuNls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fr6rZvBF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PfxMrTU8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fr6rZvBF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PfxMrTU8"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 31CBA13800FF;
	Thu,  6 Jun 2024 02:30:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 06 Jun 2024 02:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717655438; x=1717741838; bh=PmfvErgxDM
	qqzwqWIIHYEAPKZIrNxibc6RGiSkPkYAY=; b=fr6rZvBFivbWWNz8ZMIgIPH58U
	bHDE0bfKAoR8lKm/zSmyClo+8AyXkAZfYT6aF/KbjflAGudlyK0+TgQ9ihyRlumW
	WW2jUHKBjdGrOWe7E9DH5q8ni6s+FkQAyOazvPjYzMTMcSz33PEqzuGdj5RFHXGM
	CHC0ZahEOfdEbeBm4jH91aBRZYfEEbQnnnOmz0SIEUDZktJpJ1UqLonsbo7dgT9p
	WOOadFkRweJPTuyiLbm14lgicmXPPERUaibMrE4EQOCmEUgvrcKmdTgpVdLWac14
	ywvxwIntvQ7F+jkJdgpMBuumE6zvfMjckHX95BnQWZbD8ZUoyY+aoZVfAL4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717655438; x=1717741838; bh=PmfvErgxDMqqzwqWIIHYEAPKZIrN
	xibc6RGiSkPkYAY=; b=PfxMrTU8EE1U6SqTUogIwVgTq3mJPNKE5jbfxKn5yPAv
	CsEAT057goXaWr9jJe4WunZwSdRECiMLv99O9ku0hT9N8yV3U2Hq+NUq/L2hbqru
	HtcVuO0PGlPG/v4DdaKrJBkpoNCtl5cyKW0wz/TuP5B1uid63JBz2t8DOSgm2JNl
	4nGiE4yBXSdKTccbyEf8prAy5Xvtf2FS/0La3ghX2IejdQ9UzNdl3/iww9wJT1Xy
	16897c4kAWokh/Fc7vAzIdSTfQs5aXkBL4Lj4WXwm2mdslg0C+9phL6L2Oef9WqJ
	yPCQ2n945rQ3ghPzAvzLNFchQqhmKf2xYfMWzzbJOw==
X-ME-Sender: <xms:jVdhZhT2_3XHZK7iL1sEyZ7mshZE-2hPqnN7L8dHc-oVRhzjXCrLfQ>
    <xme:jVdhZqzad6_ICsi2HF7Eu5xzve8W4vCeaJWwzdIhr6lD3vI3qB1dScyHVqdL-RXaI
    jR6jMxxpVL3gkwczA>
X-ME-Received: <xmr:jVdhZm37bhp0gts45cyAOgNWPNxOJWW5aRH1OdKwo9laX2SqM9T0rlElUFupiydUDNAwJnJ0De0akvyUiFqQvUP1wwdXuyMH9cxrlnVMe-Ps900t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jldhZpBnhIpzdCoORBEFbkhjPTiKv03G6ekt_JVMkF-rjATOljmk6g>
    <xmx:jldhZqg8b4RNXM-gn9-_6rU4iYS8plzyiWmQBZltC0towNfxAU28-w>
    <xmx:jldhZtpfom__zmHYvRHCIxpwoswC1_LUpzIQqSFBhmD3d7FNvYLMvQ>
    <xmx:jldhZlg91kU02wSnLalQyBhlB7MQmlm694lqY2_Lp8ZE5A0G6RGJTw>
    <xmx:jldhZrsmoWOeiAupx8UevMNpkguikOpHD-p-GO0xfh_Z6rKaNEjIs-TQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 02:30:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 11178211 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 06:30:06 +0000 (UTC)
Date: Thu, 6 Jun 2024 08:30:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] ci: let pedantic job compile with -Og
Message-ID: <351dec4a4d5a5619e7627e11a8e674e32125125e.1717655210.git.ps@pks.im>
References: <cover.1717655210.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WopGbZi/KLMjYnbS"
Content-Disposition: inline
In-Reply-To: <cover.1717655210.git.ps@pks.im>


--WopGbZi/KLMjYnbS
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
Instead, only adapt the "pedantic" job to compile with `-Og`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 98dda42045..e78e19e4a6 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -44,6 +44,15 @@ pedantic)
 	# Don't run the tests; we only care about whether Git can be
 	# built.
 	export DEVOPTS=3Dpedantic
+	# Warnings generated by compilers are unfortunately specific to the
+	# optimization level. With `-O0`, many warnings won't be shown at all,
+	# whereas the optimizations performed by our default optimization level
+	# `-O2` will mask others. We thus use `-Og` here just so that we have
+	# at least one job with a different optimization level so that we can
+	# overall surface more warnings.
+	cat >config.mak <<-EOF
+	export CFLAGS=3D-Og
+	EOF
 	run_tests=3D
 	;;
 esac
--=20
2.45.2.409.g7b0defb391.dirty


--WopGbZi/KLMjYnbS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhV4kACgkQVbJhu7ck
PpS74BAAnvStpPo+CLqHIVxiXwt69l2J0IlHf41HZ+3lQK0kI68hvWva/V08lD0h
GU12GXU6wyxTZJFERWQLN4VtkEkhguI+BWvRFDn5UEZk1oifL+v7xTbBRBLPrRLD
Ec3mVqQ4mRNF9EsBgjtpouHHYmQL+H036lyf9GKbeIr77V/Ee72vJR393BeePGQl
WSPQr/NRMr8VffwgHsvid55ART4J5VxIrFimycmqBXYIHCb7ETIPrsB/c2H4QUeu
9aTWGO99Y5wYAGGuDttAOo132vlLQUzO1wLnj+ULOviqNglN1yt8gmVEaqJ0y2ea
Ro7lD/u/eVxsEnZ9JrdUfix8ti2MlLKH2oJ8Da2LCzlbXjv2bu+fFJLPsTnOm9rj
xiNFjtBEe+1cbRJ6g7tP7h6HnOQTDfaaFH0lU092pX9CnMLWzy969ve6VMOSucIM
aHwMkmF3TUBflL84HxyfZupOg1zMego4GaHm6QP9b3hoOysEK/ocv9JGQd19Ryjk
4FvWpOz/SSge/v/Bj7Hpr9ygbvkyLcWNI93Y3InI9dl1Rhonful1M+DzxZ/UTmQ+
4tuW4/14LFzXDd1xoOoTaqM/0812JzYIhxyZsdX3DW57r7ARKf4Je3yH7ImOoMlj
d1FjH3YfzsdcrnC+Rg+YNuJlcAqRrRIK9PVNyWf5jcjlePD4BaA=
=4Qen
-----END PGP SIGNATURE-----

--WopGbZi/KLMjYnbS--
