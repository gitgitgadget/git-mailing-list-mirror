Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11791153517
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666303; cv=none; b=j6mGwY8m2yjrv0G+GnX2tDgKJW4WluKXeCZ5a46tNtTybRB8zfQoBgL3bG7fa1nlI2Ca9mqlT/sEa0Hif6KPYUiZjqyPvuQbUKbKIyKr5a6Avb4OiGdw8boIBqaMbRRkBtXNy/yNkljEbLwfMKuZ7rrb0L5bllHuNPMTAy1PtW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666303; c=relaxed/simple;
	bh=ZaO2BsMk7l5iWbH/IfIqD/OhFIRHOvBXeEqj9ZgbhJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBoi2gfFGDponGrLPcWvKhgLgwGf8BWXdNdzALgBxLTgssQ4Hff0CdNWW1/xjKMHDlJNqg9hpvsUWi3GfRKoW3rFKTUY9r7h9FYWgiXmw7Bc6pMUqOCcteXyi7tKcxQqZnaV9mvdHOcvKaHY9ayd7/HvvlduY67Dv6BgHfV/SOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=La6WV2cU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AR6gmZ40; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="La6WV2cU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AR6gmZ40"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2E3D21140163;
	Thu,  6 Jun 2024 05:31:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 06 Jun 2024 05:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717666301; x=1717752701; bh=hR3qS00X8D
	CQFlsiLIU5Xl5TNy68c//HMN95VKGeY9w=; b=La6WV2cU036OPj5OQxAEFRlygP
	dU5A3qtgt1HHN4L4CmGe3VdKMZES59mYDSd1hUyqklGNrIAfBaVroEmwu8/w8ADI
	Kfc1wmdb4pWC9fRQMVD6AMImE0BEJ/JaKzq2kRq3YWAjALCoBahx8LAoCulYPIG9
	CCDuXBWnFKF23+NtfKAQRaJ810VklmfJ6xRuSQh6irgG/FD9OmVGkwrVwebo+pYu
	5Rllafydn3ecsjbtrEt5m/zoOEYZXqVZSHXExehE/OXhtIwDZDTD5K8oCKTCmY84
	/Wljb9+Qxq3lv1TLWSDAP/Fdd5H5kNqe8WNslQoMZMFUFqLGbre0TqzJsCaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717666301; x=1717752701; bh=hR3qS00X8DCQFlsiLIU5Xl5TNy68
	c//HMN95VKGeY9w=; b=AR6gmZ40RjX0gMc7ja04Mur+vJRLsnnwKGHOQ9jZigma
	cPtMeEZp3JmVDr0W+aHrViReev9YXsaCdqj2wR0Y6yQpK02EFnRXubDDTta0cO+7
	T0A8HwaB5RCiqmIQWK8eusTmMt2EAmPDWChzesAmTBh7jc1cjOXuD29oSxumCZVN
	6XCI95BOd+XJwGIue28o8DGIt0MVT/2FosTTqDlBdBjATFaTEMD/gXzJSSlwTA9s
	VW6FfErG2jbPV7z36GkXyb568Gt3Nq2AyutYzmKENdfY5eoXvtmEmIpIXG2SdAIp
	dj2rPPASZotZ3cyd627uNMYOdY5Z/r1OcKfUjfCE9A==
X-ME-Sender: <xms:_IFhZkcwo7R3AWhgmUWyrN-tvJgY8BlvgdZZ1uDWJCDd9Uh983SU4Q>
    <xme:_IFhZmN0ReJYxrifQ5hyETfObLydh5XxxMPddPdSIN7Z6YfMeoF9ntHfSIxvJ2uND
    Q1cte-g6a23XDZuZw>
X-ME-Received: <xmr:_IFhZljYx9pefQUZqnA4QQR11lRPIOrLzplS21hiUReQUYtPeGFPDAGSB1nlFsnYhOeDD8ZzjACfbIpeajMnsmTTM3Vcux89CTduh1y6pHpOcz5E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_YFhZp-Zebn8PFlSkA9noq4om_8yBSV-D1ePmJPsfPs0b7HK_Tydyw>
    <xmx:_YFhZgsHo_WZu8NUYKZEEbrJivDnJ7BrEuWOudCP4IbEC63VBuD0Rg>
    <xmx:_YFhZgF-yJdZK4KwgoO2F7R3g5nS2U1-0mZ1rUwCN0n8rWwV97JOSQ>
    <xmx:_YFhZvMdHDtk7cNIDqhMcE4xfSEeVnxzP1Sua9GfKjFW2h0v6vzzGg>
    <xmx:_YFhZsJC6NHPz4HHlnwAxSlwYCgUCGN7h8GsNh-GOngLjI1Jq9MDsFo9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 05:31:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 53fd21df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 09:31:07 +0000 (UTC)
Date: Thu, 6 Jun 2024 11:31:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] ci: detect more warnings via `-Og`
Message-ID: <cover.1717662814.git.ps@pks.im>
References: <20240606080552.GA658959@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PUymp7WtpVr59xCg"
Content-Disposition: inline
In-Reply-To: <20240606080552.GA658959@coredump.intra.peff.net>


--PUymp7WtpVr59xCg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that modifies one of our
CI jobs to compile with `-Og`. We have noticed that it may surface more
warnings that we do not see with `-O2`, so this should help to find more
bugs up front.

Changes compared to v1:

  - Instead of adapting the "pedantic" job, we now adapt
    "linux-gcc-default" to compile with `-Og`. This is because that job
    uses ubuntu:latest and thus a recent compiler, and there are other
    jobs with ubuntu:latest that continue to compile with `-O2`. So this
    is a strict improvement of coverage for diagnostics.

  - Add a way to override the optimization level to our Makefile, as
    suggested by Peff.

Patrick

Patrick Steinhardt (2):
  ci: fix check for Ubuntu 20.04
  ci: compile "linux-gcc-default" job with -Og

 Makefile                  | 3 ++-
 ci/lib.sh                 | 2 +-
 ci/run-build-and-tests.sh | 9 +++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  f91004a438 =3D 1:  f91004a438 ci: fix check for Ubuntu 20.04
2:  351dec4a4d ! 2:  bdf0e40a77 ci: let pedantic job compile with -Og
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    ci: let pedantic job compile with -Og
    +    ci: compile "linux-gcc-default" job with -Og
    =20
         We have recently noticed that our CI does not always notice variab=
les
         that may be used uninitialized. While it is expected that compiler
    @@ Commit message
    =20
         While we could adapt all jobs to compile with `-Og` now, that would
         potentially mask other warnings that only get diagnosed with `-O2`.
    -    Instead, only adapt the "pedantic" job to compile with `-Og`.
    +    Instead, adapt the "linux-gcc-default" job to compile with `-Og`. =
This
    +    job is chosen because it uses the "ubuntu:latest" image and should=
 thus
    +    have a comparatively recent compiler toolchain, and because we have
    +    other jobs that use "ubuntu:latest" so that we do not loose covera=
ge for
    +    warnings diagnosed only on `-O2` level.
    +
    +    To make it easier to set up the optimization level in our CI, add
    +    support in our Makefile to specify the level via an environment
    +    variable.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    + ## Makefile ##
    +@@ Makefile: endif
    + # tweaked by config.* below as well as the command-line, both of
    + # which'll override these defaults.
    + # Older versions of GCC may require adding "-std=3Dgnu99" at the end.
    +-CFLAGS =3D -g -O2 -Wall
    ++O ?=3D 2
    ++CFLAGS =3D -g -O$(O) -Wall
    + LDFLAGS =3D
    + CC_LD_DYNPATH =3D -Wl,-rpath,
    + BASIC_CFLAGS =3D -I.
    +
      ## ci/run-build-and-tests.sh ##
    -@@ ci/run-build-and-tests.sh: pedantic)
    - 	# Don't run the tests; we only care about whether Git can be
    - 	# built.
    - 	export DEVOPTS=3Dpedantic
    +@@ ci/run-build-and-tests.sh: esac
    + run_tests=3Dt
    +=20
    + case "$jobname" in
    ++linux-gcc-default)
     +	# Warnings generated by compilers are unfortunately specific to the
     +	# optimization level. With `-O0`, many warnings won't be shown at al=
l,
     +	# whereas the optimizations performed by our default optimization le=
vel
     +	# `-O2` will mask others. We thus use `-Og` here just so that we have
     +	# at least one job with a different optimization level so that we can
     +	# overall surface more warnings.
    -+	cat >config.mak <<-EOF
    -+	export CFLAGS=3D-Og
    -+	EOF
    - 	run_tests=3D
    ++	export O=3Dg
    ++	;;
    + linux-gcc)
    + 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
      	;;
    - esac
--=20
2.45.2.409.g7b0defb391.dirty


--PUymp7WtpVr59xCg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhgfcACgkQVbJhu7ck
PpTVBw/+J02JfAYTHcdmhxo7yfH2RZ95Bgc//nsSjtnCVeplMkOBSnfTxjJ2kr1K
cdynistusPgx3JmQRz6vYhA2cWBmue2nUyc6KHA54Yz+tlAIXs/PXi12raZp7g0N
jrHiRXTz5+ON2oe4eTBeIkhDv6PlLek6YmC9LvXE+0LaQhVts/ObvtidWhtCRBih
U9Vxj8S0rqriNA2LWM61L/iw5OwJFmv5ITj6DqChBZoWdRHjFONrnew2zOGGLnRH
PqicdR9UPu6sWeYCKOj0N5TBJUEjDbiSkxcMRRyAelHEn8G80O0neu5XURo2EmeT
RyeW00/gyq7Q+2FNHuYZitsB+2IEnejtVbEdfSBgT7N6GMie3q50iarAaO2dvrd+
596g+BnHiAde3wbWEAzQm8QalyKogdrDHHd8SQ1S/1LL9xEb3xabVfbR63MgUGjM
dPtA4b7bM+OP2Pee32T+vilzjRGSsN+o7MsQAedhlTwsOv7DdfmnxKafpo3E17zx
3+uYrAeup26MeAN8IKf925ncAbWLOcGXHaCejKkaXjjWVfe81od8QSO6GL4XhlCN
cr5Mu3LyDWNfePekYj6dhPds2KzGnVSCWU4Xusv2Vc7HneT5c+fMO9ioHI71Xj3D
/BSXWfGMyY2UsrGFBKEPqrxWO1wE6JCh+cw4ffuFT59woAq41Jc=
=uMku
-----END PGP SIGNATURE-----

--PUymp7WtpVr59xCg--
