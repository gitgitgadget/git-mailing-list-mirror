Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702E14A096
	for <git@vger.kernel.org>; Thu,  9 May 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243148; cv=none; b=szmjy+oYbygb1ztvJogYhGZBIiE2ygWzRSMt/vs9sCZ3P8tTVT4cEf6K1L12LkNP254NBzK8ZOtNEKwMEWDAKaQicfx5lyif4l6/aCMizjX2muMnhlzmjO0Eus+DE3/vhAIy05q0Kepk9uS1bpw4E8yFdr1qke9zj7dWFxjwg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243148; c=relaxed/simple;
	bh=Ni/yHhDLUzT90PzcApeyFmQY6jqOpdljsV7Cqj1R1MY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JJF8Kd9lT2h99i2PnmtEGH/+Rmp7dQTXUL44cMl3i2dQMBTfjmO4btwDd7XHk55fayeq6ZsksbTrG0JbWiOJu3ECX1y6esu4ZTtjQ+5K32NQT3NF6FvvVYjdb3Cx+PQiAhiuYwaUfB6J5rr/X5gOH45fvLTMHpOKr/AUWLQh4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pthHOr4T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HYUHlK2f; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pthHOr4T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HYUHlK2f"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id E78B21C000A6
	for <git@vger.kernel.org>; Thu,  9 May 2024 04:25:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 09 May 2024 04:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1715243133; x=1715329533; bh=1ikDQlfWZo3jcIEWyym8uCvDN5KTiiwu
	P5BBUeMv+Pk=; b=pthHOr4TPi5WO88CyQq4La1lT9GH+ZQ+8C6UZAQD5wN4K8ut
	RXyQk1IrZCJREaHIaSHLlB4plJFCVnUg1O+lju8RSIcvf17/o4pXwikyUWQFkkCa
	Nf+6hwpZOQeiNVjX5dL2aQk31KGAvCIWw793FzthmQkDj3iF62fjeC6P5PV4We43
	JsmWGgSa80WvpixnRHXAvr1/yczAEd7UVxJgMi13HNUgECuYnVY8GYJ0icDXw7th
	BIR4hzmblxYqF3nBz3E889VS5Boxi46Na0dsgMbKfqaKs/YulI+TDhRI0igZKKLI
	cYfH2VxLIKF+d2CggdOKSeGcDBwl6hJB1Sx2zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1715243133; x=1715329533; bh=1ikDQlfWZo3jcIEWyym8uCvDN5KTiiwuP5B
	BUeMv+Pk=; b=HYUHlK2fH3byNhHcGxliaoiyDwZzRvZYoP4NukLx5oxNLzTlvVt
	PPISJ3Z6JazCaScCrABL6xF6W2IygzJzEIB+HR5zjAPLV6QyBMbmk/ZamkBd97ce
	h+DJ+RZan20xg0g7gkgHpRLNRrY73ky3bsBr2wJ7oZJKTT9/LsZi2uPD/TY3HVYP
	jVuGxJtxtyU/5Ur69nLxbjWT2wdEXXnNJjwVpPwBmx6CNVzY3A9mMsofnEk12jfi
	vF4ZyBwKJGTrkkkyLSKh+s2naFSi4TckIhN7m66IM54yUIHaH/ACydHum+/PRGds
	xhEybirp+c2NQ2aBL5JXWL7WU/uG46Qie1Q==
X-ME-Sender: <xms:fYg8Zt99OSsem79h0DpKrhIlmlhWwYcf1RUu9_q912Mvzpn4iZDI3w>
    <xme:fYg8ZhsOG8IF3QaaceWFndjEoAyXS11Ohy_13vHsulBKPL84sSk3ydHtNnEv6vaWS
    hjcSEuQhd6ZQS1cNQ>
X-ME-Received: <xmr:fYg8ZrCbdVZpFw9k_7uK4bBVyZR50T_UW1kDJKz2rgIBvlgCU8G7ZTqKCKovbKxZTlzSMFW952nuOuOyWKP8dtfcMhFLZiGAovZa-SUMvrfadBime9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefvddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeljefhgedvheelkeefueeigfeuvedvudffhf
    ejfeegvdeggfegudejgfeivdefnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpshhh
    qddrtghipdhinhhsthgrlhhlqdguvghpvghnuggvnhgtihgvshdrshhhnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:fYg8ZhfWFuXrvk7gB140GeNuPktTOwL-EWQzze_Z1dc4kzemz4hCVA>
    <xmx:fYg8ZiOWiZrqsaIHx5AHzJ2b7okPITGZjL5s2Pu9HUVOHtJYKsa4UA>
    <xmx:fYg8Zjn7oqxFjzUuFulQpLpc24kAQ_J7R584jxj5RyTtqh5ED-UEPw>
    <xmx:fYg8Zsu-Q2hyXYoWIwm-PKX7-mEUnY6z62ELWLFiJ6B30bccMeke0Q>
    <xmx:fYg8Zk3tkwxxP-EYbdcaRvjs0tGIryYeK03J5ULmQ6cD0boMLzIJoHPd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 May 2024 04:25:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 20035fde (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 May 2024 08:25:19 +0000 (UTC)
Date: Thu, 9 May 2024 10:25:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH] gitlab-ci: fix installing dependencies for fuzz smoke tests
Message-ID: <5a92a4aa9edd9653df71b284f07461c7906f97e2.1715241343.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j6c84EQtJyRaZ23J"
Content-Disposition: inline


--j6c84EQtJyRaZ23J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There was a semantic merge conflict between 9cdeb34b96 (ci: merge
scripts which install dependencies, 2024-04-12), which has merged
"ci/install-docker-dependencies.sh" into "ci/install-dependencies.sh"
and c7b228e000 (gitlab-ci: add smoke test for fuzzers, 2024-04-29),
which has added a new fuzz smoke test job that makes use of the
now-removed script.

Adapt the job to instead use the new script to install dependencies.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

This patch is based on 0f3415f1f8 (The second batch, 2024-05-08), which
contains the refactorings that merged the two dependency installation
scripts into one. Other than that, I have pulled in two dependencies:

  - ps/enable-minimal-fuzzers-at-gitlab, which is the topic I'm fixing.

  - ps/ci-python-2-deprecation, which is required to make jobs based on
    "ubuntu:latest" pass in the first place. Other than that there is no
    textual dependency on this topic, which means that there is no need
    to pull this in as an actual dependency.

With this, all jobs pass again. See [1] for an example run.

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/147

 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3836351d07..dfc3c88bec 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -100,7 +100,7 @@ test:fuzz-smoke-tests:
   variables:
     CC: clang
   before_script:
-    - ./ci/install-docker-dependencies.sh
+    - ./ci/install-dependencies.sh
   script:
     - ./ci/run-build-and-minimal-fuzzers.sh
=20

base-commit: 33a6a5abc0e6c276c9a07468bd3500245c97ad72
--=20
2.44.0


--j6c84EQtJyRaZ23J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY8iHIACgkQVbJhu7ck
PpR+3xAAhO6Uwmj30U9vqp/bGqfnJ6BEHEuQ2xw6tCQg1IfI4Uk8/IANesXboutC
1O6aDX/g2cwvbfOQYST3ZOe73EffoClbbQyG37mZamW54Eg/r3nYOgooQM0ax6nV
xJTcbTSXMEv1Mdf0Pzkic8p0xdgHo5NWJzsMEEy8i7Sn0eWewgdWbRqj3Q4oxWM+
xxQA2o2vw2Pjp0L1jlH5r+KQTBNLH6A/IOIbMG5KpVev51c4sFO3M0aj9OnhE+mQ
bc2k9t772Qw9zUpBMQwdOUM0aF8a5BwpNzYs6BrFDEe4ck5K/pSPHcBzns5zm0J8
YEOeWioJiIWHGNVKbpF+GKiiuHRhnNV5Xz9+jcpMQaIOBBbXc2hTK0NIt5FaVlUN
TyhXxayGxPRnfg2BbYymzHRjo6PzjHP1C7mgjgxKohkuCzhg+DjfaY4axlYrclqj
SxWrhjszTzR6RI2/D5O/S03SiKJdB69MXBvcXaiDDehG/N3m/8mPcLAJSOnDW1n/
5GLIvzg9o7//Z0sZwXsB3fMXft+f33UI4qoZqcLdvOOLrFdcZsbAb6OoJQzjXEFF
w13APopNWF1LZ7yFgGw87eNzAQaWHH50vENvQl9bJv8WlypdqOao6f8suFuXwXYG
oHs+O6rHkKKBCBPWmAUkCQ5dpmcFmZ75r7Acc1wuEZeK8nxEtmo=
=NrBi
-----END PGP SIGNATURE-----

--j6c84EQtJyRaZ23J--
