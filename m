Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F613D61E
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467189; cv=none; b=WpuwrTreH7qBBMgi1kl26l+u5TlgQLiBDF+3C1N4MUfE4ns0SxFDUsrd5XWy4vP4cFc9gsnPI3VcmmS/1lOmRkcyNmdflKAhHO5qhuQ99bDJw4nkw6w5y65ifFiau/5TQrmx4aeViuglyi/ncQSdwtxa8wLcnjJaTvg2yKCTkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467189; c=relaxed/simple;
	bh=ATvhDk7HoD70R21giR7+aUllzJrHsDaiYjlFOwcjIeE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bncWSedVTUA5edzAGdSHFiK96JgYKnBptR9sPIwDgs7IJB1OXg6Gh9o+OXH43L0xeyHBTAyVqYV5NnjblBALqBPH8SdsXBbaQqXFBdRoELuXJEBwVHRG/K8oCBlKa1vauHMWHexHPRsFgrym/IPdplVmNpEULNRIeJ9AtE1nn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BK/4hJTh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXjDQUN0; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BK/4hJTh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXjDQUN0"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1314D1800103
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:26:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 23 May 2024 08:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467186; x=1716553586; bh=rWfiPUyHXj
	KAB04rbYqQdWTDIyX0gwZ0p6xqr121A7c=; b=BK/4hJTh+ZtjxO1coul4QFqCkI
	Au1N65+ykwD1nNPFc373odUOYnLos7T5jCTMeILwQP0TM08EZpxoi4NI4NgRxKyT
	PP8EG9TxERL/6puI1vz5grn+6KHgwr+jRrDq8kXfgGwPahl4lC2K9mgnwHRqgwmE
	febFxwSGqxOkoTkXqzOKlWnIteg/EV0GQPcJa1Kklvzthb9IMtgAK/ZcTTdh0DTt
	4M5/CtMeaSQYU20dbRI6wEAPTkvzPH/hzClpsYzYecHDPVG0p4LI2O2B6nVdDwsP
	bKF1TsKn4910r2nHDsEUc0VKTpJqjmA/oteg3LqdyuUzpYnIDcumvMmnoj+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467186; x=1716553586; bh=rWfiPUyHXjKAB04rbYqQdWTDIyX0
	gwZ0p6xqr121A7c=; b=SXjDQUN0OA9QAlYyDdlVaqxUQ9tGWMvmLhBYHeO9uhlg
	cMP92M3Ect0RGR0WXO1YTCvnE7nz5aSFj9S2xypygtXrbB9VOvCB8PrxLaTios1y
	RSq51OA4uCCVkRHJA3ZIc8svGwaVqZgdkh+NenFtwc9DjMgNqr/LzOwkJ6YShi6S
	aMOmG/fxq3378yne9v+NAbktZTIKn1pMJ4SFnuTsqI68QYhoieY/DEHh4I1+o63Z
	gLc0kGeeRriftc+xzXiGtlA3TUa6vxqoOAqx5Rg/BfG2YFEbij8m3N9a+wr/wv5r
	yNDbrJbphIL4tkbYNeZnsiHDNyMIRtCv63NDp136IQ==
X-ME-Sender: <xms:8jVPZpb54WhbFiQ9Cp_Z2NGfnlIksVthM32HByJr6w0Mxr11NO9FyQ>
    <xme:8jVPZgYlsiD8nSPHVC5uzaZggmETXr985GrNwlheHq-7fSxYWZxFrMlG4b88a4mrI
    TqG7vwO-boOdHn8fg>
X-ME-Received: <xmr:8jVPZr9_BUZnr3gQrIb4yeNcLdfNBb4e-n2amOoGAkghgKMakSqj6gA5oBfG-MIlNvtCIrF-Z0jidTU67i4DDQ4CBq76FiTt-7MG6cNSgmx2mOTtmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8jVPZnpqFGz0dYBLtRDGiaJHQgmOMVUDSjpJjkWxY8wFeoeM_JFLbA>
    <xmx:8jVPZkq2Fo1pSCCtwpiAAPAvY9dw9R9CGru748HCKh-F0wFnePVejQ>
    <xmx:8jVPZtS1kDNiTQkIB-U9xHOs1JZx6NeyT559Xrg1CgnZut_hjxYT8A>
    <xmx:8jVPZsp0B-IPNtptMiRTG7LOFkVS1eFLriJ9bgzkvkZricj7tOwylg>
    <xmx:8jVPZhCLvOFud6eS9MptKdco_avteomTwK2yybc20AkLTZ8NWtTWdVPm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:26:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 78ae7500 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:26:19 +0000 (UTC)
Date: Thu, 23 May 2024 14:26:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/20] submodule: fix leaking memory for submodule entries
Message-ID: <24362604b2390d69a58c2064d9da0fe248070d46.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="penX9MXJT+vFSeRi"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--penX9MXJT+vFSeRi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `free_one_config()` we never end up freeing the `url` and `ignore`
fields and thus leak memory. Fix those leaks and mark now-passing tests
as leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule-config.c                     | 2 ++
 t/t1013-read-tree-submodule.sh         | 1 +
 t/t2013-checkout-submodule.sh          | 1 +
 t/t3007-ls-files-recurse-submodules.sh | 1 +
 t/t7112-reset-submodule.sh             | 1 +
 5 files changed, 6 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index 11428b4ada..ec45ea67b9 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -91,6 +91,8 @@ static void free_one_config(struct submodule_entry *entry)
 	free((void *) entry->config->path);
 	free((void *) entry->config->name);
 	free((void *) entry->config->branch);
+	free((void *) entry->config->url);
+	free((void *) entry->config->ignore);
 	free((void *) entry->config->update_strategy.command);
 	free(entry->config);
 }
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index bfc90d4cf2..cf8b94ebed 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'read-tree can handle submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index b2bdd1fcb4..3c1d663d94 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'checkout can handle submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recu=
rse-submodules.sh
index 61771eec83..f04bdc8c78 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -6,6 +6,7 @@ This test verifies the recurse-submodules feature correctly=
 lists files from
 submodules.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup directory structure and submodules' '
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index a3e2413bc3..b0d3d93b0b 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'reset can handle submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
--=20
2.45.1.216.g4365c6fcf9.dirty


--penX9MXJT+vFSeRi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNe4ACgkQVbJhu7ck
PpTNVBAAgo/k05Ajnj3ANvfIzkHL4zfIDa/RYHv03nvzC2tADcDU+JbkS5SVLyb0
OAvSqpdp40nyZ65gW72a0MojeO753uGcDSGYGwhXdvHKTO7D5U+4QXIg39mXFQQp
J2CS0IaD+nrBeMms9FbLge4ik8K9RdcwALVXPGIMw1Rb+HgdB3Drz4K75DJl7gHd
PT1qQshE1YH6r6dCXS4a46rracoV9NqmkpWnO0xxi/qoaWw+EhTgKDk4kGmr7WDr
cMW/7/Mmhn0weVxLGWE/nXmwXEMxZC3jLpCXKM4/ugJV77lGs3ZWQP4bmnIMr5MY
C8MJaX1PcihdaeG3xf2TMutqukgwogH8XRNMxeF6f1ymHKCewxfuXOXv/gamEQ5f
pBWrErqfUBtYznxpH+XE9Yxhjcr0zKsbD7lVfRlxqa6KPpwv7R3kwwjASt5B53ce
dvlPO3+vxBsYibfBDlUb5g1BF4SpUJT2+T8JQrhRvLnduWEwU+ogFTj5SdjwNcYY
DB6Fh8zc/gbn6WewXnxRo/Y4X7WoUsmQfDmDvy/ZgJEpLbxpQBSCWE+89To1fJIb
/vmkRSJcd/qM+HSjXmOsfmW4H47F0uyJp5Yqj1VQltjMnMClPEoJD4OSYWAUmC4d
8zLHi9UPW9st2Qxy5zlDhMcMH5NwMqVleZAXoGff4nedSXAv5tc=
=AiTB
-----END PGP SIGNATURE-----

--penX9MXJT+vFSeRi--
