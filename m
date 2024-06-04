Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAFB146A73
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504716; cv=none; b=f1WI/wdbCM6L4EO46o5LSOiHW85dwUlms61/43kfMW2m1VEHv39KP+pBlp7ngQKLYF7bWCDrKuNGaxCBDig1S+8o87VfKWOAzCg09gmHHVyALxhFg60Enj7thswJt4r+D8MLPEb7P8s2W3vCkTWy5eKVd1dP4obUzHYddfbf6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504716; c=relaxed/simple;
	bh=l0sMvvuKHlFixEJDFZuOOlLmhHOPdpnl8DCfUWUNaRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6MNaHt28dejV+kdY84tvtdHpSekQ7yVBYincCa1SXFM/kUkP21fDx0HSf2kpuie8Lxt3OP6atNBsgkUiYINtdGaPLeGOq00y457xFjQW0kKQ2DavwidW/Jg5td/FS03Ixd2EUjhp96TXMQAI5dVG/UyLBahU5TJc4YA3BMwnNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mhM/LM+0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VGtGoosK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mhM/LM+0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VGtGoosK"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id DB68C1380157;
	Tue,  4 Jun 2024 08:38:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 08:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504713; x=1717591113; bh=tgd0ku8TQs
	WIChVm7M9+tXjHsGFr03hkgFw+dz2/mtU=; b=mhM/LM+0Ce1fFvWz+gNTHIfSbe
	FmNkBx3F+XgVRQtwMgR8bgGfEveMQLByGTqtRO5U4ViqCi/5Eh+yPyfjoMSoqEIQ
	uos2+zyjSR4S+wcoB/21j24w0lc+hULP0tCwXC/sEEcD/LapqgLNmu+O+41wT/F5
	6etzTm7C873ftJ86ObfyuWX0ayegDp5fRCv825iXflsIGH7akZ//HPms9eO1nFNy
	BLP4OfzgSNi/0Wy4uD3apYBZZ77gQLfk33AuBBxbQELa0c74Kce10sQvizZL3ysw
	MMbte2WO5WElRFQZ73LoK8lTPVthKVfb4Ga+t0TkXiMtXd59wmA/ewaFUNMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504713; x=1717591113; bh=tgd0ku8TQsWIChVm7M9+tXjHsGFr
	03hkgFw+dz2/mtU=; b=VGtGoosKq9jtv7uBh7SmZmEhuEgvt9lw4DT1WoFm3sSD
	R3eJOvPoSPGlUB/p7RCOYwkKemQjPGp7GCFxEpdc7P9LqbcbGjHlgogFvg1g9ath
	JCwug7oR2i3Npy1eytR4+eu15xLgv6RolvanL1rFbc0iuuOJF+EI2pLtGHemDyyp
	VSR3OHUGNpObxh/RzOD/RyP6YcwpIgX6AlI7bL+zFwJL/NQFwK/YDcjzB8/GGBye
	wTa10tDlmEjLK6qsqeAFY45YKqGVH7pPO5XVGlRMBU1jM1ecLBcX324iMpO04cF9
	i052jzsj8mwlPh+/ayoPQE0IxjkN8ozvk0i7PEvUAw==
X-ME-Sender: <xms:yQpfZuc8geZuv4xNO5Vu2TaIJVrXf7zwm8ayaSezAOBaonTe-U8Exw>
    <xme:yQpfZoOUqACWs16hbTOIeFQzNL6abQeuLJcZu7pxpnD-__XmyElfZS2xqgsCgS-u4
    ZQUTs3fe4dxZ7EITQ>
X-ME-Received: <xmr:yQpfZvhFWTfXIj1tkKr8RGIDF4LA2kuRFWU3Q2Gos_ooDtiZK5K3zUEMNqy7l5KV8hfYkU9oBAyABULwLB1ZLF8cXWTVfaxmvAaelxsPfaZX-ry->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yQpfZr8GY5sRFKKn8_J4zU5ZgC9vORHqYWEoJdhYvxwVkyvKJjjjiQ>
    <xmx:yQpfZqs9kTffKYncFfsgpjVp3EyKyHQvrtJJK9nawjcg3DYPmU9ZHg>
    <xmx:yQpfZiGAycpHGeg791Qg64TrsVypa6rYLmJ4s7dIi3qUomKW3sCmxA>
    <xmx:yQpfZpPF8o_s_hF-qAdnyV42uEjgvOJfNg-qTixjt01tUik0hjx_9Q>
    <xmx:yQpfZsJTMofaBLDzN9yAno7DIE34PAZhsT78h23yKOxzkjbGEf01kp8C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:38:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 84fe4af0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:38:06 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:38:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 20/27] revision: always store allocated strings in output
 encoding
Message-ID: <27660b908ca6ca0a1d992d0f2e6f2989742fe956.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SSqWdilgqtoe0XpL"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--SSqWdilgqtoe0XpL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `git_log_output_encoding` variable can be set via the `--encoding=3D`
option. When doing so, we conditionally either assign it to the passed
value, or if the value is "none" we assign it the empty string.
Depending on which of the both code paths we pick though, the variable
may end up being assigned either an allocated string or a string
constant.

This is somewhat risky and may easily lead to bugs when a different code
path may want to reassign a new value to it, freeing the previous value.
We already to this when parsing the "i18n.logoutputencoding" config in
`git_default_i18n_config()`. But because the config is typically parsed
before we parse command line options this has been fine so far.

Regardless of that, safeguard the code such that the variable always
contains an allocated string. While at it, also free the old value in
case there was any to plug a potential memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c             | 3 ++-
 t/t3900-i18n-commit.sh | 1 +
 t/t3901-i18n-patch.sh  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 7ddf0f151a..2ee6886078 100644
--- a/revision.c
+++ b/revision.c
@@ -2650,10 +2650,11 @@ static int handle_revision_opt(struct rev_info *rev=
s, int argc, const char **arg
 	} else if (!strcmp(arg, "--invert-grep")) {
 		revs->grep_filter.no_body_match =3D 1;
 	} else if ((argcount =3D parse_long_opt("encoding", argv, &optarg))) {
+		free(git_log_output_encoding);
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding =3D xstrdup(optarg);
 		else
-			git_log_output_encoding =3D "";
+			git_log_output_encoding =3D xstrdup("");
 		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
 		revs->reverse ^=3D 1;
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index f27d09cfd9..db7b403bc1 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'commit and log output encodings'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 compare_with () {
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 4b37f78829..5f0b9afc3f 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -8,6 +8,7 @@ test_description=3D'i18n settings and format-patch | am pip=
e'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check_encoding () {
--=20
2.45.1.410.g58bac47f8e.dirty


--SSqWdilgqtoe0XpL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCsUACgkQVbJhu7ck
PpToHhAAqwTnOLcUZjDIgC0g1HeuhhToE8ymdgB07KRC0VMurJuTtF0PP+1uoXYK
rCmmJ5V73buYV/5dQzilHpOprl58GPHsBz8BSrHgT9DMNokw1osnPPNGs1UpakeA
icEcjWYAMJEzkiPDJXD+17B+xyCy0jGcW2ZX/8GNFhR9taf02A1UuJopR+w+DrDa
uDxxiHHhAxgydKYlFupvXHz04iUQG7bbzoYlk00NwqDSDVK8pRSW0Rt4aB2XjbVt
ZDvC3fYInf+tyko4KoEogAL3niBZadKFdEl0z2G5qHUWnfiMR54rQBnyn0m4kNeW
tD42BtCSMdCG/U5OFYJ9w4PPpTipogna5tYQ7wL9AYVjnQRlA0yBl79rZ84skLft
kpuuNTdN0f0zFZOOqBHHxJBJWdqWxFUSpVL1qrZtZoFEeFNQFNHNf6yk0Lk0fbxR
e2fZSnOlb2xakl2nkLD+qHYLqTamZ6zSlQycIw2BKyKv1IXDLNhO5Nd2u/JY7BHY
ZKDtc8vGL669RQ7YR+wJmRPYHP8Q9UVZMwhFCqddu1WUqdgUaj5Ptis/MZVsH1GA
jlGZMeNmQmQaKwFPCaijF7zE5ECEZHmJ0/8dT5wRcqxMvNHJkYaiygQ0KdydDHya
LOd2NWszC19dYFAWe47z3J9ZcWzgmeIz3o7Me8gDFHIg8vuJ9VQ=
=fL2T
-----END PGP SIGNATURE-----

--SSqWdilgqtoe0XpL--
