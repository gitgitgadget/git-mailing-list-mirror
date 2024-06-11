Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CC1176FA7
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097635; cv=none; b=EcPng6tT1W9qo1AqgVi4MckqM3FmMtMXRTku/3cZEhhNJoZMX7jA7Okwng/6cLmqLVdDu/DzSWzJyry82J/Jhv1UNEweWesN9tH+zAEdmVFTWjQ3edAwsbYq0SsUW1IZkyYIiIu3pZlAcyg/gnNcfEfNpGWZITExQxaWivRY4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097635; c=relaxed/simple;
	bh=+33Y4l8pTaDg5HX3c3rwZvqaJwc4QVM9+sjBqOEBTnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGfiZaaqHSfZpIsxm2OukOmULHta/gETSeZjG3oVuX03lC6IX+6MEyGAJ7hwnL6M5K44aYKmVfOmN9cPPH5m+wiIFOr7cWKT8DD0fEB405aL+djZ+nFRIatpHTpKKMcftRyMwsA3bx9Q0vljZW+7ftsXTZQWBLHihgDZXEaVQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eeISFjPw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NHBW3RLm; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eeISFjPw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NHBW3RLm"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 618DC18000B8;
	Tue, 11 Jun 2024 05:20:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 11 Jun 2024 05:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097632; x=1718184032; bh=cV8/EY9QjY
	4EfJ9jLoD7OB6I9zxtI9NtGFv32P3II/g=; b=eeISFjPw9zDasbO+Ek75wRpg5J
	XTo6LEHeD44UKSpoNfiA5OUu7NfBhN2mk8sFDfNc6J8frThgvHwZ7FTw7qaYQlsj
	zIP72TCdukduabiKJMc8Hj4/lqh3Khc4wQp2vtEaD9YeQDXFHjxgJ0yi6YUMjwud
	BO2F3Ek9N1zuVrCDQ/hCp32ed0KNvUc3DmlvQWGaLhE4qmMwBWdkvN9jvao0h4j/
	hrQZFuyih8MAkKmu7FuThv1Oklo/V9mRJkfwiaat32Vt2YS1uWKIe2L8efnlogr6
	vbGJNq7TIcsq+qHmv8x+8LcsXqVZ4urf9sHOJc+QjgbZPV7nup+XMhxMEW2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097632; x=1718184032; bh=cV8/EY9QjY4EfJ9jLoD7OB6I9zxt
	I9NtGFv32P3II/g=; b=NHBW3RLm9fzapXsLfj50Lf+nl0lgjrbhHItKuDW9H17x
	wlMFOWYRtUw3rZKpAVrOnjRjbTYziymEGbjb1ypM2uCNm75tFqBwMxdTn/nNSRef
	aC6psuNF3+QO7w6HPaMS+iB+taAOo4kyrNnt0C+Fm5RcJQDBHj/3aqWZhQQsT37o
	GL9TmtS+vm4wol0leqQXQWLgREVKWbIcGs1qIOa7T6qJMQiNZpOldPh3G875rM+8
	i6tXsmoA06qLa6Ycf5fa8ww2vtRgvBnXH0JlX//3rvtugim7QzxDli2vNAIxs5C5
	mgDNh5DU/CoEpBFpavgSqf7a2eXgwXbizkqETqZDYQ==
X-ME-Sender: <xms:3xZoZl_e_N6Ov5pCfiP_wKrTwKgu7L5pk7aJXrnR8mtzoMXNiwfs6g>
    <xme:3xZoZpsk_sq0iTW7XYp9zIOIVbXEoIymg8D3vxCQGDEzEOsdkvs0jwWlPq9elRvok
    -AOJlmc65g9RCWz-g>
X-ME-Received: <xmr:3xZoZjAwXeNZe2vN3pMAJ9ZaROqajCe2pVJXKQC_fbmakOWvG8CDVhYlcBrHKSArFpiOX68RyqMhrEC_qm_7CQssuLq-oe1KDYCxPg_Myt5OPdWca-QD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:3xZoZpcQHNkQd65_V4Pg03NS99e3LPzUaixLrKC80INhfoopOjbk-A>
    <xmx:3xZoZqN-UiH0VunNJDoGe1NegHLNe1iW8NUZzfZNYCcF1Iq1-1tReA>
    <xmx:3xZoZrn5EOdTdiMD9T0Eb3DiAXyYHttl0yfTe_KnUiBQ046Ug8jWHA>
    <xmx:3xZoZksbwLlntSiazNOiQ6cJQivC3afEB9N9OApcs_Cwy72QHTMOjw>
    <xmx:4BZoZnp9rzgJaRJ7ebHNtJKCguhyRWc_2XcIUifGU3qY74VpUlFUmVzf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1c80b862 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:20:22 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:20:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 16/29] builtin/stash: fix leak in `show_stash()`
Message-ID: <707d798f7873eb772c724774e1fe6d3b499c759d.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MtTeuEUuAl34FcwO"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--MtTeuEUuAl34FcwO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We leak the `revision_args()` variable. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/stash.c              | 2 ++
 t/t3420-rebase-autostash.sh  | 1 +
 t/t3907-stash-show-config.sh | 1 +
 3 files changed, 4 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index 628d848a0b..1ed0a9a5d9 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -975,7 +975,9 @@ static int show_stash(int argc, const char **argv, cons=
t char *prefix)
 	log_tree_diff_flush(&rev);
=20
 	ret =3D diff_result_code(&rev.diffopt);
+
 cleanup:
+	strvec_clear(&revision_args);
 	strvec_clear(&stash_args);
 	free_stash_info(&info);
 	release_revisions(&rev);
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 1a820f1481..63e400b89f 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -7,6 +7,7 @@ test_description=3D'git rebase --autostash tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t3907-stash-show-config.sh b/t/t3907-stash-show-config.sh
index 10914bba7b..7a2eb98b86 100755
--- a/t/t3907-stash-show-config.sh
+++ b/t/t3907-stash-show-config.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Test git stash show configuration.'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.45.2.436.gcd77e87115.dirty


--MtTeuEUuAl34FcwO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFtwACgkQVbJhu7ck
PpSGaRAAnFhbpz1pwRBgzru4xqi/lJTieA9JOBVlWz9CJbl/9+RETzsS5ejobxFe
CrPOXY/c9pbiKxMVi1s5FqQOmB1lkFGmOnvkcZFLXsEDLNcIuH5AkfnEn0rlsg6P
cHcs83Hx7EEnNzrU9k1cPxdX9Y/sH7LKtd62682bh3C9IMZ7ZYgug71TyvnYokSK
esTuvMaXtfojRgemzEp5KaVOM4JuF25UfFP5iRScOYEjy1rUauVkzzgYkOkR4j+r
x9qxFhuIHGowmtvlA0/N9uI7RWZri8irRYAF88AYbWRgndstqgYChXB4YfdM0bG8
VAT9xhYh+YQQdX6UAP5IbFrLbWX2q50Q9y2GScnDQbcFgOjxvjGUqeucFYo6s1G+
0Qtq/bojqKXBXX7v+AAp+Ya+xKpSDVqLhc+ffMAxf5MIJPYPtJaaSVQP0b2J5cgb
ujjGBqU49PBXX9iZ7Ie5xR/nSn7zfLsoC1aSvS1zfekfcYV1EBfl83qFGOZnINT6
701VJfAxxSKGsE8rEuTenpe5uZHZBYh3eoCh5FSS93nZoOUqfeOiMXodrYVRUdrL
jXgb8aNFO94bBmz5YjBzzne3XbUaYOkxdoDQ7kLjdp9iyoMIDpEfapGDJu8KSrmO
6/vOoP+c/yM875sFhSz75xNzRPILs8N5p8rua0BlptTb4kt6rZ0=
=mrpm
-----END PGP SIGNATURE-----

--MtTeuEUuAl34FcwO--
