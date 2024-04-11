Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BD1442FA
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826655; cv=none; b=YDeISWIXziiQmqtHY/knyyCSTTgDs9fTBZrmaQ0ZWphT37oKMp7x5WPzrzHTaYha34coflORyft0PPprVYMf77yYWLDXp7WUQPrAGtayauhlfuuhKXILeDMbYrRa+MZB3HXBGS6KEGbe+CGfZQHIXwfT3T1Dw8MQ6f423CdSyHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826655; c=relaxed/simple;
	bh=zLDMggoUrZWFoaxmQwA8QMbLai7xUZDp7x5xz7iXy2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoHeO3kZ95vhPE+glJgE79KTKsdut6nMdCcjMOrbqleikHCprGt97fRL2X6RdxTSVj6KKcfqILfnzxp8ZC/M9ou/JUMKMoFVFJg9uV6WkEMLT8OImZSRvRw9xyjyvYHN+V6iZ4nmYdTnAosX0/xRSiCysTG/K6HsPvr0wlckX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iUq70cMS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nzFwlfhu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iUq70cMS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nzFwlfhu"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E2D0E1140198;
	Thu, 11 Apr 2024 05:10:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 11 Apr 2024 05:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826650; x=1712913050; bh=tjsVx4nQhx
	ZS45gfmhMJ/ocdUu92HV7bOMCb/JVjw2E=; b=iUq70cMS7omFvmLbGpRSAEYn4G
	vWDqkiwCEPsJKIqazu1VwaYO69rL0gTo3MY7MqDrq7ebMP5hbnCR8gZ85DffFRGn
	eNwqi+JJoLd2kJ4GNZDA/wlOI5WMS3r7yeIwRodCLNUsg2YQ0EtXlgp2erO9sgBd
	CqSnHdAZ5YQrM7LZ181Y1gd+hj5sbicKOmda6gsDZeZZzWtzSLAAB8FpKnpPSTKC
	rQI6n2W18Cnu8TEY+KfBeaP72TAO0PJz1bO+YywjcFfLEy7bYGED6quQrY/4164L
	llyU0HyaTESYYudnXFbz/URwdcNyRNcCLeGbzOsL+93WXKUuP8+zgRs86E5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826650; x=1712913050; bh=tjsVx4nQhxZS45gfmhMJ/ocdUu92
	HV7bOMCb/JVjw2E=; b=nzFwlfhuMioec0NjWoqU9RqxDYqKpDFTuEppBDl/TXED
	T4CLXbw7yH3rTFlomp3v8QLbNJnfNKGPsbOgNSYadYdnvKArCU9yFWJ5bA8yJPYr
	riqGCkY4RWmN+x0+D+XBTrHkXBj6ZEH3tQWnDEPXtTFrlU/fzlSkikFNfEAHhJOJ
	xAfN9IXry0LZV06gKVyRaLi7AJNs9i09QaxXHL/01nKRLMP7121OQXdc/HllQqHD
	WjmQlL6NrPHh0ni+QQTFQsCNWeM8AhOL5GCgbTxMfqddB7ofVUY8hLkimDAzrnMp
	XlvsvGOIN6lqsgY0BVN0OkL9/ZcNMvBFE0vAbdDlBw==
X-ME-Sender: <xms:GqkXZoAU4Zye39enkGoJbkT_y0z-DzQdiBL_Wp6JoRQRmRnPjxUoNw>
    <xme:GqkXZqjWNjL8RNRBZC6Cw1pSqn77XjVcy_p0aNyEM_YXYDIZC7T54h5vskoSo_Wej
    uDqQQduFS6LSHVmTw>
X-ME-Received: <xmr:GqkXZrmtdDDxDRLLWye7n0REN4gdvn1gw2EKmYcs1ldD2HUtSI90tiQu6R3k8C63QWHwG98N1nvp9TdlVxHsULT2qJ1Sc71zsGc56k1wvqAlqmyr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:GqkXZuyZMU_NG9x1KLE9_t-q-SAE_lBbNvQKSxO05w7t1HoRXt3WfA>
    <xmx:GqkXZtRVPBK217Vxtk6L6Y-FMskxVSCngPofVcuNMYUi9IY5L9QE3g>
    <xmx:GqkXZpafI3G8D3l0-KGbZIaNwwz-S5dHut0SrCfdWsHdubHpiKiG4Q>
    <xmx:GqkXZmRIcdJOAww9VpEQp_neMD0PIvxIw8Nww33jVl2bUl45-XLM1Q>
    <xmx:GqkXZuRaI2QAUecMh6aVBuyTNJLCmezrjAHmKPQfmqeWSH8hU45cNpX4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:10:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0ae94a03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:10:37 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:10:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 09/13] ci: make Perforce binaries executable for all users
Message-ID: <f7399382f2aa5d17424a065bd72ab2fa915947f0.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WxyJK1fgkrtPpbRV"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--WxyJK1fgkrtPpbRV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The Perforce binaries are only made executable for the current user. On
GitLab CI though we execute tests as a different user than "root", and
thus these binaries may not be executable by that test user at all. This
has gone unnoticed so far because those binaries are optional -- in case
they don't exist we simply skip over tests requiring them.

Fix the setup so that we set the executable bits for all users.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index e673797115..0b9bb686d8 100755
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
 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
--=20
2.44.GIT


--WxyJK1fgkrtPpbRV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqRYACgkQVbJhu7ck
PpQAYxAAokbHBl0RNY742t6MjXctTZlUFCDN9O10j3tYyPUUrGybGbItfsvwSMWj
EydgrcZXBquHkidGKM2mnAvFwwrIQF6psJKnXie4xKBMlk1h3jvZSTTbWDs0vPFW
xndbDagw2VudSn0A1DEzesuiLKzuPMW2fANYvPv1gW34LEVyjf0PWIvKXggokreb
Af6fyfdKeGwOS63AL+7Js+/V3Dz0z7BNx31qFe2jBZnqZrF4Nsd4IQl1TZ66JO1C
rGylNmsQA3uQZ+slEAQ4YFpmYRnpljWaBQJQJ8zPPOLHcABOnm7glvbE9K3+hei4
iKc++YWeD2OeHD20tE+c3PoKM9kgOFI6SMjllevFRFm7P/hwbqTNqt98cCkPjq1o
8GYtZd4q5gX8OqUizYGDOnXMmd0/uqFyCLl+zvAC6+EcJ2wByQJ6PzBeytTE1Q2q
Z4QvNO1k6EStUmKPTU8Lc3Rzo0Am+rmk358jb8X8WtEK8brltl9h4VCv6pHOx4Jv
DELYDQnvwkkfwcYryFkA3wmIQts2M6fL0iYclbdYzfaxRqlNLA1xSudJandx8/oM
kmPZceVz4696RhXC8Lyt3ZmSCIip80eQjY+PDVChqYPm47t3y18k2jHbNfXJVyCr
QLUbguE4XyFhPbzuaCmDXd55tGKZblW9MfhQFTnD8DTf0QXmCZM=
=xf/O
-----END PGP SIGNATURE-----

--WxyJK1fgkrtPpbRV--
