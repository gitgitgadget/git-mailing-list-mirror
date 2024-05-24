Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62885274
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545072; cv=none; b=Bl/R5ek5FpNKUVc88oMpe541eSKnyJuG7IMozDcohYShGSfG6ZYAEX4n1c3D8sCy/IWS2n+ToQ0gdDDMHfLZZs3LSLcwyJuhczWxgkwRF9a5+FvW3PWX7vfP2BbJGM0l4WrvaVlX+HplrMZ/iILkYwdR6SzxdcJSnPtaZ4mAILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545072; c=relaxed/simple;
	bh=MwRwNXdBa9TPSFCHLsrC+POgvGefqnDDRvJSHe+56EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqj/T72Z7ZrnXGPUx7spdhzOAE/NNE1870gOLymVkvrw3r3fcO3j8nSJAfOHJ1imsKiKBG5l2eObys6r80s6LG7NZmkHTVDjXBa5tGjWBuWFfe7HdpHYxiIvVGDkoBo/KHg6LILAZ16ty0jtdzKUz99dLN+2Pu1REGdCGh2vM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gWuwJmVv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AhcMdlCR; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gWuwJmVv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AhcMdlCR"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7415B11400C2;
	Fri, 24 May 2024 06:04:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 24 May 2024 06:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545070; x=1716631470; bh=RHtbWEJ3Iw
	gg/wuAMNTVhYEuqwgM+J+yUAP3WYjp0Pg=; b=gWuwJmVvyfkkMXPTdTCnlS8+4i
	Dmc1Ah6k8Wh6hpIBk8RX5UYsnEYJxZKGc8O7PXG3DwjLWa11jZxnpPNbFuj4t0Vv
	tKMG5Kwr6lhAWvC/V/0TSD4E0aVdqg/HVEY+4T95hywQyf2PFViJgEec8YeP/wO3
	o9KT99eBwY8z/NIEmQPFPdtjYrInGILoYqN4XlEhBmgeSb7lWWKct1e7jieFLvX6
	YaGEaXGoC0Nkcx+yEZG+H6NHNFWSGAn5Wh0O0qtVQrz0yKf6X4CLPWsGYxNHGFe3
	NpMjsnB2e82UAQcV4VBAZxuzGfBad+9IO+pHnpdOBlP7KMMXi4vCCjsaH+bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545070; x=1716631470; bh=RHtbWEJ3Iwgg/wuAMNTVhYEuqwgM
	+J+yUAP3WYjp0Pg=; b=AhcMdlCR4dJCb46MBa5q2UThBxPf4K0LOB0h6xobilEB
	OFDQacgDMFoMFayue+wZHSQk9WsdiL8CDC3rEVqjQddW4453zCsgBw2smpolq6U4
	NFyJey6w8EVR80oZNkY7wAK4uwDcvXfb/+WW1flRDI8q7Zikc5UkdJ6a8VznAecd
	Z5v2l0UJhq3QIGd98bzezr5PRwz4dTwOtlpNd3TvQ8vvrO6EzEjRYcAzvvAlaIF/
	+nE+lm45q2EHLlZ7Ax/oZ5lndopmZC987Wyb0gdbvInSz/W+EAReu1T1ySkQten2
	vuq23VY23lEalxfwHyIc+8YydFoPzPGpF7UBMWGCCg==
X-ME-Sender: <xms:LmZQZstlVTLittvZj_BwqCdoXu1UFRUq2Tp35CkIq1NBdpA9u_I6zw>
    <xme:LmZQZpfV6lC3NiKgcIy4Yi1ik8B2sn1IV_VrSUCMAzs0ih7WF4EzUVbM1eNgwiYhR
    m1--m1OUMDamh-oYA>
X-ME-Received: <xmr:LmZQZnzzdkCNnXoaLLI1KvOg_xJ1PFrzKmkPsg4kD4spB62PI6w4LtzLxS7-KO5MnuK7LVSvySLm8N8a7tGi3K3-TlVnvdT7BumwOavW0Z11RgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:LmZQZvN_mpTlkHAYiW4xT3U7NXx_37l-448q1c6am2ud6abSq63p1Q>
    <xmx:LmZQZs-QBP9yXcBmm6TQLW8WrcHKW3hh1YZdZVrSo45jXXL06l1iOw>
    <xmx:LmZQZnU-xjCoP-eF5l7qm-2YTD9A-0QPCAJOdjR_1EbA2ACD0F93Bw>
    <xmx:LmZQZldH_1wyGKdtYgtUzVvdgE1lE5DDOQzRyHlVn_1ObkYHl5yDRw>
    <xmx:LmZQZrYd6gGSj3ufZnT5jFCyTBURoHGS4y0EUmrvX6RD46B8IOoDG5xH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:04:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 15055dda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:04:26 +0000 (UTC)
Date: Fri, 24 May 2024 12:04:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/21] submodule: fix leaking memory for submodule entries
Message-ID: <cd8a992f08a0bb63d93d2ab8562a0d74129b6ee3.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E5DfUBFQpNEKbQr+"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--E5DfUBFQpNEKbQr+
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


--E5DfUBFQpNEKbQr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZikACgkQVbJhu7ck
PpT/Aw/8DrfUUefRUGYxcp4hIA+P+etjMc/RcpbAFY7APAe94MVNlJOouXZP7CyO
Tv01w3FgdBP6TV9exeumLqwEBNzA+IR9IU0wWB5TlHf9tPvmb4T1hRU19HhDnkln
G8pTIvhnAfYIW4SqOmleXCkvF/x8U5Kvd8MiXrfWYx6pFla77ZD24Flh8W4uFrma
hjbdODMtTjOO3euJ2viG/ZzxrwQBtR3rSTg0z4w1sLOnCFEwrRxjTMoQndKFmTF7
R1Zj4tn6J66uZeO5b5tvqtGaEdFT9tKQgEOV7m5i8NevzwTFPRZWZcijawQXQPgR
YXuyPNdj1aMbgKlBC1jtLkUnfAPTLIJX0VB4OuZPjlGjIWsxAYv6SSpcy1SFDPUK
UGbD6/w7KN3QsNcqe+Twj9tr6om0dvNG1gk/rzcu3BnqVpM5xL2mpEu8o3vyiBxv
e+ENjk8ZSVIignPx5i5G6E2s4Ifw2MSn1bt1DS4sUED1U3jXh+UhVXz8L0Gi8BfC
LrPTVjZSrviSmsz4/nFAuLgQPNlo0poqCp4A2542B46zjZM2v+zgFP6sGQ1cNY9m
wI1RDCCl9O268A0SBf+9I0SxxGUJVK9zWhHZRFscfFN2wN6uyUhMGEXaizg6vJad
GnEclwrx70R2MNY+EvOPN9NdJwT1Zqv7n1sHUD04Dwem1uNX0CM=
=Vp6v
-----END PGP SIGNATURE-----

--E5DfUBFQpNEKbQr+--
