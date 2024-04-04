Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F476023
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237141; cv=none; b=HF1PKMqZQv0OQeuaof81Pm0U1oqeaWfPUsjwD/mT7L2XUrdhPRDHi+fFzoBgVHAuHBwNyENwSgbW7f936IOHW880aB8u9x3MuQCJ5lZ96siRiqp8pRK1fE2i0jAIKo+Y79A4zcG5l9iNBFCp7taQaCy7DQxITIWu2n9vBtIvJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237141; c=relaxed/simple;
	bh=JU8U6sFqKR7fduZ234TTX/9aVsyR2nLIJROH95Jed3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow2tt8FtxiwB1bnjkoRjCi5vounipjzbVQ4z/qbLhHS6+NztrWPrC9Sf16RSCeMcOw+yHOlasfnYFJ0lBxponpOb51Lj/VNklxDRXocIbskYzLKbOTe32RfJNJOQeEa1jxKLlKBbVUwDa6UiJWemUpaMIdac5KTTEQ5iIE8eWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VnKLikxA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WfO4HKyn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VnKLikxA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WfO4HKyn"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 06B33114013A;
	Thu,  4 Apr 2024 09:25:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 04 Apr 2024 09:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237139; x=1712323539; bh=wHNTpD+yq7
	kH1api0ikjRYYy53ZE1voW5xQDJIkzB/Q=; b=VnKLikxAIM+74/qONLj+v9UA/v
	wHXvp22k5cZGQOu11wgtk3OtCtLsZsRIYJ5WJDiQlFyONo+PGFAZ3hpPOwl6YYab
	I10rClHyKfmoonw41Pgjk7sJNPs2BHbh0+InAjbt3XefphGD785HVcfxsOjBzcVz
	7eTQvcjRe7F1IRS34KB8U8j2juHRcSoLMsDfPxCUaL1I9nISEur/nt95ir0JgbXZ
	CFjPDrjiFGjAKlC0Z9hK34lXNzkyT//BP3hSObSc1Fte18+LRYcEp+bOES1AbKgu
	cR5hDpdkRefLKDb6oUHAxa6qO2lEIEVQ9GpOip2hBnjKoHUCdXtR86zTd8+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237139; x=1712323539; bh=wHNTpD+yq7kH1api0ikjRYYy53ZE
	1voW5xQDJIkzB/Q=; b=WfO4HKyn6k353tdnWJUCTYp2KyFqMiH612iogqsogBkX
	zKnVbjqpigTMUFNRnQFHrPal8Xsw8/pOfT/Cqvr9mxLU6KEGNM9YKphUeSTpQAxT
	X034ud+sCS4ZJn2cqJGH6+7k2duShmngyd21JIZiwhBt2sW3D7k9mWzXHXYfE4Rg
	GSoPz3J5tVD3Oi8G1IHevZlDjAIvE6v+FBCMtWpS6jYq9cUe/ogtRNyaRd9xyY/K
	3GIc0HczKXCr7f4xNYZEfd1Eo1jrVwq01mzKk+4BpOl5czg0tvgLnUFmEVBf9TMN
	KLjBbq0yOi6KkQ1nnRepPG0hrrIjQlzZh0sH8Lj6Yg==
X-ME-Sender: <xms:UqoOZuLQ-lsOcUV86wV8RunZg_lAPiVSS5IWvGy-3lbVruPBsgbpdQ>
    <xme:UqoOZmIYxFUSxE-TP2L_-NEQHKMX-k9Iv_w8B1kqNWLy5phO-CJ4YY9vqKppf_qXH
    g-2f2E9jwl5iEeulA>
X-ME-Received: <xmr:UqoOZuvFHiB_ydm6kAvt7rdkyAgFjv02Wie7t03777xy3jXkQTCimFc4EFcm5VmP_VMBm-foRB9RDfr5g0pfpBzKbtNdga0kzHbvwj5bcUupivKv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:UqoOZjbTctYGTiEYJ92yRMYUGWcjt2eE0KRZqXTJhj1FqmUVH6YXBQ>
    <xmx:UqoOZlY2sj4_wl3ZZrSfr6ZM50U262Meu1oTL9c8tEaq0WmdvP_OGg>
    <xmx:UqoOZvAC4fp8xQXoUmRb5jLXJT0eCS3a6_PfK8YoqeBzqS4tfneyhA>
    <xmx:UqoOZrZxT0K7xCA7wN9N-t9ycCu6A6qSTskSj5mxRNFbTh7w4W_ETg>
    <xmx:UqoOZqMyJmL8875Hui263tE9nc7UXk_7ieCOAnl_EhzWh0ak40lR2k1J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a51412ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:25:34 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 08/12] ci: make Perforce binaries executable for all users
Message-ID: <22f86f8ccb9f3fb7f98ff57ddd09724fc9e44628.1712235356.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iK/Kun3inC/JONZA"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--iK/Kun3inC/JONZA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The Perforce binaries are only made executable for the current user. On
GitLab CI though we execute tests as a different user than "root", and
thus these binaries may not be executable by that test user.

Fix the setup so that we set the executable bits for all users.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index f4eb125fd2..068c478025 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -47,7 +47,7 @@ ubuntu-*)
 	mkdir --parents "$CUSTOM_PATH"
 	wget --quiet --directory-prefix=3D"$CUSTOM_PATH" \
 		"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
-	chmod u+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
+	chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
=20
 	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.g=
z"
 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$CUSTOM_=
PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
--=20
2.44.GIT


--iK/Kun3inC/JONZA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOqk4ACgkQVbJhu7ck
PpQHSQ/+K1EfCvzmet58634Fv0d81wT06J3XsoamX0G66non+ruqMa8RWTmwMV0K
54au/149br/ETF3Oh8JQtcaltVn8BxLAz0pqpqzyiCvxwPGZFhZ9Ab0PwspHBzKL
lNlV0UwJ0Z6HSg5I9zg4Q5kXJ3dSx1yWw3bBHExCUKznjWffQURNaMxXD2LUOBqw
stoh+i+xjSbAx9q9xcwYdnqg3scQz57d8HnzYUWVya4BnKED6Er3ZPCZWOjOADHt
w+OnpkIbb3Gy82EIvbuRh8SlELae8kXtwDWC139N3hK/zoW32ZxuKgb/7iJoLbqW
32ZwhLJ17MdNb4DXlAoOWHG4VtmIErq6NewjbLZ7dYgFpGFixW3JcBelqnLUMZri
zT+aZ9QqH7hun5ImV/N1i5V+1tTzHYzRGxzdsBnDu12OgdIAJlm3aqtSn2f7fTGY
vlxQpmgIohhU4GBnUWJRwdKkmWz76Fj20vUnHqxSVW/BVMieL0WmhhQvcrzihxlt
APIHeYkJkYAPMLP7sIPWEPpeZUIp5ySI4h/SxV7p8pDbiGS8CVDJt0dbVXydanrc
UbtSMgPCqGXZcSdGGq4tmLas7MocEAKcY0DtrWXftv9fR1YAWI5oWfrHf3mnf2JM
O1yyIMtWf/Ge3Hx8PrPGY9UoTRvlhLu6IG32Txd2OxI3A5j2FwI=
=z+oz
-----END PGP SIGNATURE-----

--iK/Kun3inC/JONZA--
