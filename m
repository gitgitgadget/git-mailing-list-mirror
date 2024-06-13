Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3D136E37
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259295; cv=none; b=rDOjSdnY7YplFXc56nmpNykEfhiMnoyqaUCLHXmreUI1swuNWxN6tcrPHpNYPofldJkGplFPfvHuEuB6DvJ9oo5mqYLHRc+b61qR5isjqcQl5ONBt+a+cPRaGwn7jnIgm83yksGmNuwSVkfDVx/6tyucv/iII1ttZkEf8++APFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259295; c=relaxed/simple;
	bh=eUcLBmHIeuQ5u7+hWUyL35EKRCcHOSHug/8a0vowiHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfU3RsOvbceOXSh/Peru4UBXeKfXovRm9+n7BQBnRY1Si3ZAM50fU66wWFEgGS09+CDZ31nCrO0JIihhpYo66w80GKbvS1BqXaZQIPP74vnh47/PtEDChBwetVtYYnlzyWQPyrZBgJ0x1UULz32XdSUUIFVuwl6fXO5+0GB+B6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vs7BnJVP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BpGNl6tK; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vs7BnJVP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BpGNl6tK"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 367401C000A6;
	Thu, 13 Jun 2024 02:14:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 13 Jun 2024 02:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259292; x=1718345692; bh=Tm8RlfYOVk
	Wzv5nzxlL6MPoU5X5cKffBHEsi/FsL3nY=; b=Vs7BnJVP/E7YG/q9PuOVFYdhsI
	8953dIRKUoU4Kvg3SpK/CNRxE0bBlNav/snoUm2yNX44//T4hNESP1YTm1uK7i5O
	mEi2uHEFHxrKfw20qwKKPcn3iZBaL14Gvr2G+ks0lVzVrRDUm41HoLbuYGVPhVVb
	VgtR6ryuL1noXuRgPTRrmCkGPfLOUzEaKYzLPNTTuXjgtaE1Jm1qDe15rPZMMgFI
	2VDm5QNeLaPlUrAhP+JQjJzA+KFEpie2ZR0qDEbfKIYn4Zatp8tc3KjsAePB9/sp
	kmrHmts860TS59LryMGMvhtBPN9iYicXW9mWMfb07rcN0ZOm9f85pu7+o5PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259292; x=1718345692; bh=Tm8RlfYOVkWzv5nzxlL6MPoU5X5c
	KffBHEsi/FsL3nY=; b=BpGNl6tK9XP8sNQwJSd9YPKY1g6wli5Yj8xGE8ynESRv
	WQ7Xobr2L43pUx+VIjAJtXZ1zubS8cgCSdsQrzBVUanFbX7yejz9QDGW4lKaja6z
	ksClxYzO/GeIi/dYyz0UQbLXZeO/3ozq94NBJEIg3imvJSYHMIkXVDaVO955ivk0
	plYpDh9f3EB72nhikzUSdWCGUkLIWX8rQoHlpSItVlu0Wi4TZZf2GrD32e0iSBs/
	eHz+qE4CWWes5PtT4DHecCrvTgT3ivT+mfWP4VnpUZGPS9ZWOh6JTM/4djWMdXG5
	umZD8u5NAseRp8OUgXY+9mGwVabwyPXEmIjFRW4yqA==
X-ME-Sender: <xms:XI5qZhUcqHWPJHARzFDrV_u67_xLxu9hqupZ_FPs2kur9lO2TNOOzA>
    <xme:XI5qZhnvIIM-sw8BJQSuzeONJGdUt8X-wCp5wADXCutSwbkxiHBb93exruNcPBjf1
    h8sVzYV61YgiQGDDA>
X-ME-Received: <xmr:XI5qZtabQnxhghJ-gN4-_Xlu8xEmJ1GFqMlfOlsk0y24PIUsP5eaTeXBrM-s9hgIPkgXd5JLdjiRMXbfPhmxp_AhHRfECm4NxSWFjvT0ldPY7pFjxWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:XI5qZkUKikIqvECcjBWKFZeyxG3yRI-kh-j3mzuGP69aNDwFaZkHiA>
    <xmx:XI5qZrkh4OM8XMcBiEwFIbQpt7yN3BFU9czhcu-C2_yd05oHzGSpnA>
    <xmx:XI5qZhcuLWolR-KsG1dOSxmpdB4OZkbmEsdwIpkIKuxxy3-qksdWqQ>
    <xmx:XI5qZlHbdq73tfUzF9Y_5IEE4dLPKXzrZ87LPrXWIHYRLhwe2PwarQ>
    <xmx:XI5qZpifbpdpP19r8kqcY9X6hHhZrGxG4Sk7qeTZM3Z_Qv2H5UQX0wJs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:14:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b1f0a34f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:14:38 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:14:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 18/20] t/helper: fix segfault in "oid-array" command
 without repository
Message-ID: <470aea1fc85b0dce983ce5a81aeac28df62e8ea7.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z8jh964vSU5JFsM6"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--Z8jh964vSU5JFsM6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "oid-array" test helper can supposedly work without a Git
repository, but will in fact crash because `the_repository->hash_algo`
is not initialized. This is because `oid_pos()`, which is used by
`oid_array_lookup()`, depends on `the_hash_algo->rawsz`.

Ideally, we'd adapt `oid_pos()` to not depend on `the_hash_algo`
anymore. That is a bigger untertaking though, so instead we fall back to
SHA1 when there is no repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-oid-array.c |  4 ++++
 t/t0064-oid-array.sh      | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index aafe398ef0..076b849cbf 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "hex.h"
 #include "oid-array.h"
@@ -17,6 +19,8 @@ int cmd__oid_array(int argc UNUSED, const char **argv UNU=
SED)
 	int nongit_ok;
=20
 	setup_git_directory_gently(&nongit_ok);
+	if (nongit_ok)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
=20
 	while (strbuf_getline(&line, stdin) !=3D EOF) {
 		const char *arg;
diff --git a/t/t0064-oid-array.sh b/t/t0064-oid-array.sh
index 88c89e8f48..de74b692d0 100755
--- a/t/t0064-oid-array.sh
+++ b/t/t0064-oid-array.sh
@@ -15,6 +15,24 @@ echoid () {
 	done
 }
=20
+test_expect_success 'without repository' '
+	cat >expect <<-EOF &&
+	4444444444444444444444444444444444444444
+	5555555555555555555555555555555555555555
+	8888888888888888888888888888888888888888
+	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+	EOF
+	cat >input <<-EOF &&
+	append 4444444444444444444444444444444444444444
+	append 5555555555555555555555555555555555555555
+	append 8888888888888888888888888888888888888888
+	append aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+	for_each_unique
+	EOF
+	nongit test-tool oid-array <input >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ordered enumeration' '
 	echoid "" 44 55 88 aa >expect &&
 	{
--=20
2.45.2.457.g8d94cfb545.dirty


--Z8jh964vSU5JFsM6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjlgACgkQVbJhu7ck
PpSTNxAAnz7nxzSGm2xOPrruoN6LZtbCQ/BS0GSgVJ2/ytH+f0tEchvxPxTZp/ei
Mc9N1x2Iokn8VWHlAJpWWJ15nID6VSZGfthMnvVA1i1v/rJvvmPb4Ai/JZdHHXC4
c9cpmESK1uqNAE+a8Oa2Heub/lCWVyTpkdQe/ND2Gubdo4fbiZrmlp6QSVggOwB6
cvl/C8zmh7jdRAKrqbh28ao+h5GY+Y/ApDOpPsLfXFmZKlXWbbsL98E7aITcAXEx
yZDjhNoCf7aqRGg2wKvci5oDAQY/PtfuwcKMmI2CBATGTm81qM3XEEcqXREw9Q0b
5AcGAqrQ4nYWPUWpz9k9EsUS8RLB4RgjPZUcYMIjFUPSDMhgQj8RL21Vja46SjMc
AcqTVwsRQIKdKFxL4YRM3E8atGGUg1UxxruXVvsWOPkrojH7SJKsBeUIQEBIojOW
8nCDr27KrqHnpLyTBzp00Mow7Z0aCQsO1664lNvKKQ4XL23z43aUS/Yf4saUOoEX
4uisiTXAW9AOnN01jWiSeeb3ibjaz91JRbXWoQaXDkTwUdUAngHiEXPYRyWUwfH6
acLP8EV+ET/3SdIJ8LLmdm+hcp7BjdIdc1+KOMAjpnOJNDR3eGe40PRr4FF1IIin
isAAQltgEvajIfMFDghm0zipiRZ1SxfZEmeblsPt6mcipzoBueM=
=IOvI
-----END PGP SIGNATURE-----

--Z8jh964vSU5JFsM6--
