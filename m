Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E694204E
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742791; cv=none; b=knDjMOM0g9z791UogPy+cu+5RwdGGHeK6C3gRcy+KgOwIN1STGBK/whiJR7OKDDusnMxGkhxy+TC62k6+TitObI2bIMFE0KzroZ37xW6AWQW//G1+qkeVq8zjB+BtGbzRdIcDoF7VYHejfPgEHAqVzwfAdTMa4Rp4YAHq6w5atY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742791; c=relaxed/simple;
	bh=w2ahtY0zuDQG/VS6vH8obvWPoiDrcpLPpWZzN5vjFAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxQkX+3tPSkXydIozpYm6nR1czzq7sfMHM3jUk+Ispli77CJDzMpYf7smb0Jmi0/EkzbJfymxFfAn6QrFid3ryoWDzzj882Io2Eg/9YzlvXj3pnNNKOBLBh78lNNf2LPFf/IWgV91/uGfyF5yGpn2vthHecgOOZcXVXdVvVL8eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nkvtCn57; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P38yKWdU; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nkvtCn57";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P38yKWdU"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3D2C413801D8;
	Fri,  7 Jun 2024 02:46:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 07 Jun 2024 02:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742789; x=1717829189; bh=c0J86MXiHO
	KHHaVE515eZfmeaeH0eUs8ANuCm0+uTic=; b=nkvtCn57lLmNaJC1lk7VdYEAK9
	bTv+ZXI3LzoNN6AV3aC12ol4X7lfBBR8zGoRCBJcdMg/0GXTZeyostneVORTPz+8
	lRvOrRPqloPWgDCCsVdn8/HthnQkr3f8UXbT++lK7PXvCEMYY+7UWEMvUkT6/ddY
	QO6ifUtjHn8bn8mD+oSCnhNB1hGdc804dB1TTDP2BYxtSMl/Xok2sq04fOR96ccO
	aGky2yG6DLbb3YMNDYeXR2Mdd6kyp/tnsBFqbE2AShz2Il11tAXTDF40fYiD3Nex
	reYpwTlmqGiGLgUO5TG67Ss7OvKjc33M2Jvxq6xAG9UngdlqMQFhcS+6CDoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742789; x=1717829189; bh=c0J86MXiHOKHHaVE515eZfmeaeH0
	eUs8ANuCm0+uTic=; b=P38yKWdUxTu4n9y00YpgfVJm7ISCAm8YCDiLWBKPWu4z
	U61SJiDbZt414h9zPiKFjE9Bc/zTI/E4BfN6gC8JHQZQyuNy4HG9Qfq3mF5S4G0K
	xgEcgV8tBRyRR6EAoKsbk+ElgZ63W1cAI7fgPE+DvYzwVakZ0fe5q/yJS0NUCCIk
	ChzNu8KP7n57/NhkEWwI+KBgSJ3ddZwLuXwNgIEcgE1FhA/fN5CyEa1THGxgD6/j
	KoXMyxILIXU/sKKiRsV9RPEx4V8nnYYuWVz173Uc1HD1ckeFdFZLJP3xHmuTHVNl
	O6/1tQPSpoASzViLrLPMgyOmZ9oWcQ/VIvcDQJOZGg==
X-ME-Sender: <xms:xaxiZnupwQOjC7UqgvmNHwVgE0NS15_MGrjU5gmhEVDfJA37o2K3kw>
    <xme:xaxiZofHE8f2Nl_TjXmtsCtTBAIOAKkEkF7afFV-8K7BXeyvVBtB1FE4lCQrPLI1_
    CosYtPx6G1CNQJzhw>
X-ME-Received: <xmr:xaxiZqyWg4IqmuUK99CpZhMWnQIetzZc_ml0SYXT5M_Dsr8Ry7gqiKcTQ2Ui_OT0zQvzuJIm9V3s6cszgfJZb82v9dC-Mt1TQ4DNWIgTfcsEnOct>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:xaxiZmMb2R51vjqqxMxvieiGhQmVVUoKIcNNvWFK056naj9DKUo-1g>
    <xmx:xaxiZn9fk4b_r5mVtc27CIzDNJBcdyr6c3-WGy0UhRvObkIAP9KFmA>
    <xmx:xaxiZmVfhmCAfoQ6_3CQ540VmGdPHvbDRR6AVXOxbWyluV4u9NTfKA>
    <xmx:xaxiZoftpMwxtwn75pgeE-PA3r0O2Sh7zJGz-0s9HWAUhMCYSDUI7g>
    <xmx:xaxiZqZs01Dgc3au4QPusmewFqjFlqJ0XX4VCVyi8H8NlStJrTHQyEEi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:46:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 606cf7f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:46:26 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:46:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/4] ci: detect more warnings via `-Og`
Message-ID: <cover.1717742752.git.ps@pks.im>
References: <20240606080552.GA658959@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XxQvgCAKV2LVrK84"
Content-Disposition: inline
In-Reply-To: <20240606080552.GA658959@coredump.intra.peff.net>


--XxQvgCAKV2LVrK84
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of this patch series that adapts one of our CI
jobs to compile with `-Og` for improved coverage of warnings.

Changes compared to v2:

  - Typo fixes for commit messages.

  - Replaced the `O` variable with `CFLAGS_APPEND`. If that isn't
    palatable to folks then I'll drop this altogether and will inline it
    into the CI script, duplicating the default CFLAGS there.

  - Start compiling with V=3D1 so that the change can actually be seen. It
    also shouldn't clutter the job output too much given that the build
    is in a collapsible section on both GitHub and GitLab.

Patrick

Patrick Steinhardt (4):
  ci: fix check for Ubuntu 20.04
  Makefile: add ability to append to CFLAGS and LDFLAGS
  ci: compile code with V=3D1
  ci: compile "linux-gcc-default" job with -Og

 Makefile                  |  2 ++
 ci/lib.sh                 |  2 +-
 ci/run-build-and-tests.sh | 11 ++++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

Range-diff against v2:
1:  f91004a438 =3D 1:  70fa755b4f ci: fix check for Ubuntu 20.04
-:  ---------- > 2:  d68539834f Makefile: add ability to append to CFLAGS a=
nd LDFLAGS
-:  ---------- > 3:  a3dfb7092a ci: compile code with V=3D1
2:  bdf0e40a77 ! 4:  c7b5b62d9c ci: compile "linux-gcc-default" job with -Og
    @@ Commit message
    =20
         We have recently noticed that our CI does not always notice variab=
les
         that may be used uninitialized. While it is expected that compiler
    -    warnings aren't perfect, this one was a but puzzling because it was
    +    warnings aren't perfect, this one was a bit puzzling because it was
         rather obvious that the variable can be uninitialized.
    =20
         Many compiler warnings unfortunately depend on the optimization le=
vel
    @@ Commit message
         Instead, adapt the "linux-gcc-default" job to compile with `-Og`. =
This
         job is chosen because it uses the "ubuntu:latest" image and should=
 thus
         have a comparatively recent compiler toolchain, and because we have
    -    other jobs that use "ubuntu:latest" so that we do not loose covera=
ge for
    +    other jobs that use "ubuntu:latest" so that we do not lose coverag=
e for
         warnings diagnosed only on `-O2` level.
    =20
         To make it easier to set up the optimization level in our CI, add
    @@ Commit message
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    - ## Makefile ##
    -@@ Makefile: endif
    - # tweaked by config.* below as well as the command-line, both of
    - # which'll override these defaults.
    - # Older versions of GCC may require adding "-std=3Dgnu99" at the end.
    --CFLAGS =3D -g -O2 -Wall
    -+O ?=3D 2
    -+CFLAGS =3D -g -O$(O) -Wall
    - LDFLAGS =3D
    - CC_LD_DYNPATH =3D -Wl,-rpath,
    - BASIC_CFLAGS =3D -I.
    -
      ## ci/run-build-and-tests.sh ##
     @@ ci/run-build-and-tests.sh: esac
      run_tests=3Dt
    @@ ci/run-build-and-tests.sh: esac
     +	# `-O2` will mask others. We thus use `-Og` here just so that we have
     +	# at least one job with a different optimization level so that we can
     +	# overall surface more warnings.
    -+	export O=3Dg
    ++	export CFLAGS_APPEND=3D-Og
     +	;;
      linux-gcc)
      	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
--=20
2.45.2.436.gcd77e87115.dirty


--XxQvgCAKV2LVrK84
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZirMAACgkQVbJhu7ck
PpShKBAAm6QP9TFbTU1ZT5XHC3BNDUtq8p+abfJBxYuFPUvp+XGAnyAX9IKohw1m
LTq5tNcCc0QHE7rrGMMfFLpK4aD4lfT4811v2XnKD6KtIQ/apFajLYk6oqxyHTLq
Zv/c4caX2ot+Dc8kV7v77A0LLgKb8bTLkMqFJDGFd4wObwE731KQpWX11j1XEHEf
A0xd2NvuAKTf4J6h4HrJFM10p1k8vc/H1cb1UyItbOGnWF5ITFBWI+1fa/zcdA1X
mENU4H/XfXjzL7m72teMBR5xyRWV0JIeT0EXv3IyiY1Dc3jylE8wfGU9J5A8+eIG
ADCMYpOwaTE3QRThmCxQAjIv89L15/R9wVOUuiIrrkFscqV3hAmNaMMyZS6Fop6w
01dfNwU2nGGDnVfKWJUDJYbOzCQGYorYgwMHSr3dAzE1tsdebv0k8GrWNk3A7cw4
l+Am46+pVhqrIsaXXpfPKIWApa8Ds3KQfyW6+1pLsgLbffe1Y247TVUgPBMh30LK
2wT2CP3Z84RpnTyIxTutpp5abqYvyiVONY4rbf0VCeA5IP1Mcm6RAuYKHOgd05X6
6ummOcI+9dnm7+8ZTjZNX73y2y9wtlqNowCN1g8dfaLBOPlJXovLGritAxYkkVxI
iYA+eh0EMVhJ6+0pYVqWks7mHNx45fwyjLd+GPxAA1K/RnzV26o=
=ypyc
-----END PGP SIGNATURE-----

--XxQvgCAKV2LVrK84--
