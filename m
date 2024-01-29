Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A525B5B5
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526459; cv=none; b=QampE2elEn1kNinjy0lt89l/6MlS2t8urxRSu93Ub+0ZjXmYfWpWL/CQbtAXa3pKG2gUemuadjJqWtrfIrlw1lQCc2bA2dxr/PDLXslWa34LWOn7q0Svhk4qF0piSWuwWsnqtOn39dhnG1nYW8RkOLKRXWtHfOjpehnvF6wMtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526459; c=relaxed/simple;
	bh=8TRzI0F857z3AIE8RJwf1MlsC5oPuf3+Iw2PAwCGmSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlxHd7okpl+F4j3omaG1Kgt6/AahGhyfSDzRcibJCYXdgVha1c6Ma1TDKRmBX6v2xm3kvEpkjQnUD8TxLO63QaKvd1GAF+fcj4/QBNjKaW3xKWjl4bUwavN1/wceiNL5Xa3GTiT0TQhwrXN/maobRdtR7YS/6xSldWu+T2SFDEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mi2HAuRT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yxxK8f1E; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mi2HAuRT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yxxK8f1E"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 4BECD5C00C7;
	Mon, 29 Jan 2024 06:07:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Jan 2024 06:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706526457; x=1706612857; bh=hDj1oRRAPU
	mhJqG6ff4IYYaPz2Dh0+RJAc27M2KIhSg=; b=mi2HAuRT9Hyon694Y6eR7kDbYC
	i8kaZcjAW6/kin2Vnfp11Z+SjFmSLon2mign9LMTf0yMx2lpvCBgozyOQ/fz0/eK
	ahP+aBskY3mXz5dl21mt+uWc4dK07IdGc9Sl05eI3jd8G3iyeItQn1TWlQGVZ7HQ
	6hnZKu4qyqDtmkC7lq0v28vzKabRiR46ohonSAneIMxpTrciepWejl/EThCDvC8N
	1aL9THabT5edWo5JzZEbD8XeNsZUcC7cNHoocNISSbJZowlCymG17cvqVI5J1taL
	CKbxhCzjM5o7xxv2K8L1oaIhLlIDF4iW3rUweKkegVl7TH7mrnVIpeLQTJqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706526457; x=1706612857; bh=hDj1oRRAPUmhJqG6ff4IYYaPz2Dh
	0+RJAc27M2KIhSg=; b=yxxK8f1EaUs1HQsWJORNSlXxWa3leIexULtgSiePWIGG
	kYEnFaIGOqTq1pg2bbpTCl+IHESMoHWqSHq7P0H0mu9n0T8LXKTjDbQtqpwhNbM6
	NCVeIfgaIEgCA4iCMsc0dfuBcg0fLMGbvJIeQJ1iyJgsb3GPAZNNiltnbOdXPUAK
	s3cxMUGeHyudSWwU6voialPuekSOHBDz5ZfxYl/YUu4yYlEImMAFlc6SBBX5yzdE
	+BeBbVDbUnSGCen+ZmDv/Yj5VMibXlUWKWTyf/KO4AD6r8p3OWbw4B/67vND0ZDG
	VbmHEYRKDQgYrCMpP5XcXZ0F85AU5/r521VrCYoiDQ==
X-ME-Sender: <xms:-Ya3ZZuHjbJKqxYvSAvBzGrRhHeUV8A4fORqx0Ay-FhIU4DfCgGLvA>
    <xme:-Ya3ZScb8uL8lKFsbwhuxMbWhJJfDaxbP15X_Xqob6C4W_V2Qpa2q141GAGMreORA
    Il9Yi-25HtSJ2UdaA>
X-ME-Received: <xmr:-Ya3ZczxzvamXfuvT1elQL94Ze9Q8ZNHOiMgY9ijs06WvyQ2kNdYa9e6juK3Ut9V1A6uhfwkI3i7D1iLA7edmfVxVy8l28zYNe0D3qCDjiubE8eFWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-Ya3ZQOoTRgEfkMqAyqWA638gg7vIvdLmNgin44_nyUSLnz08sTKQA>
    <xmx:-Ya3ZZ__CtfmxOLqv6qrLyZw7mIExsdamfIbcPWlN9ExveG9wMAyCA>
    <xmx:-Ya3ZQVN0nppbq184bugdxyXhIjRqkSGFT0zM6id0VpRwV5uIz2bAw>
    <xmx:-Ya3ZckJnyFR7qhSE6uVAeEsPgHsZiaz40xYNfnXVrxRcMBseyvzbA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 06:07:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 358aa565 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 11:04:19 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:07:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 5/6] t5526: break test submodule differently
Message-ID: <4b95277e2004ed2c60274ec99cee547129bd1eda.1706525813.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1706525813.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3dIKFp3DuK7XEv6+"
Content-Disposition: inline
In-Reply-To: <cover.1706525813.git.ps@pks.im>


--3dIKFp3DuK7XEv6+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 10f5c52656 (submodule: avoid auto-discovery in
prepare_submodule_repo_env(), 2016-09-01) we fixed a bug when doing a
recursive fetch with submodule in the case where the submodule is broken
due to whatever reason. The test to exercise that the fix works breaks
the submodule by deleting its `HEAD` reference, which will cause us to
not detect the directory as a Git repository.

While this is perfectly fine in theory, this way of breaking the repo
becomes problematic with the current efforts to introduce another refdb
backend into Git. The new reftable backend has a stub HEAD file that
always contains "ref: refs/heads/.invalid" so that tools continue to be
able to detect such a repository. But as the reftable backend will never
delete this file even when asked to delete `HEAD` the current way to
delete the `HEAD` reference will stop working.

Adapt the code to instead delete the objects database. Going back with
this new way to cause breakage confirms that it triggers the infinite
recursion just the same, and there are no equivalent ongoing efforts to
replace the object database with an alternate backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5526-fetch-submodules.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 7ab220fa31..5e566205ba 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -771,7 +771,7 @@ test_expect_success 'fetching submodule into a broken r=
epository' '
 	git -C dst fetch --recurse-submodules &&
=20
 	# Break the receiving submodule
-	test-tool -C dst/sub ref-store main delete-refs REF_NO_DEREF msg HEAD &&
+	rm -r dst/sub/.git/objects &&
=20
 	# NOTE: without the fix the following tests will recurse forever!
 	# They should terminate with an error.
--=20
2.43.GIT


--3dIKFp3DuK7XEv6+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3hvUACgkQVbJhu7ck
PpRlEg/9G2J2suVirO1gpMDORs1Jda+9Wjb75TkdKYKgOuHaq/GQhDyB96TgIFT1
paUOfaxe6N1Xz1F81g+R4zws140JINJOVfmeWYSfB2hvziO1Zn/v4aaLFmx9V+AE
65HEUws/TRbzSixYyqAsz6LAylGYE/S4zEMbFZDCJ9yzSElcFjsB2UTKpRFIPIat
OwVePe0eXoLUNnvlpI/8Zi57Cusem+42e7Pfk/e71fefOEU6/rjA6L3w74ovH3Df
N4y2rSbgUeRcxv4rzjIWBoHww/hRv5e4zf66rBx61iX0YugBkB1YCZ2dAY/vgRYJ
3rfl9ZbkjoFpdK6eOJ6KgLlocfnOrXhVOWjZG1KUwsyqSQ8yb1mFtc+ReMaxMFNR
YJg/2/hn2w/QJJSPo1FWV8SIp/aHkDFgJPGK4eNx9mp7P27SGvvIQ8RdJuwrvadd
j//mXVtLhR2+B0/5ELFK55V0qyBlkvv7xqzDFDb05UbONmvHl8RWyxiyL//pHqI9
hO4CfL7mB5i9pE/YQcWw9Z7bbl/DE76iBkY3x9ryPRWrtoJjzI1S3/lO1o4tFHtZ
Y12tdP4Jk8zXRfkNIhlLRPwiBdLF4/2KtinBaFXA+WOfQ87OqITGem52Fia/9QfX
qrre/lcTMT9/FQOfzkAusyBk9SLaj562XwGWwTvBo0r3rKNWrqU=
=jo2x
-----END PGP SIGNATURE-----

--3dIKFp3DuK7XEv6+--
