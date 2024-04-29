Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21B12E6C
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372469; cv=none; b=Jkqr637yVLP5XmVvCLJff3wxUlmR3U/ySXzmb/gSi+qTFSxTlSHSwBpP4SCXIzOiPQPQbR5rjxQc8DIAH0IMyBdQLz1ePAcGiS2wv7Cmjk8LAp1vdaYQfLRK6qOSTw3JXgziQX0Ucx1L7SepsnxH7sxvAlK1dDx21H7y9AjCelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372469; c=relaxed/simple;
	bh=lq1/Q4NcbAOzb4qnG4cjgoWsOJzEhCV4TB1a9vrV2fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtObgCvPjXRr9psb4k5cBR1KYnd8/gE/Ws2zVYyEZCsrau8NIj4FZ+PtkIBzGrzsV4mtubWT8ZkRqEkTVym/78DO7U2ZqsJD7WZT0LuA+3IwmLDFrgTWI6pHA0mSjveX1xQzm0Cs2ZCyMVU/xk+rtR1D8Z8Ha4GZhu/4CKwCq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E66zncUk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EXx7dv0m; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E66zncUk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EXx7dv0m"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 37CFB1140136;
	Mon, 29 Apr 2024 02:34:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 02:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372467; x=1714458867; bh=u2I5oCWjaI
	0xikJwQ7ebCKKH0awgUhxgKfsdpvUWxWU=; b=E66zncUkC3IzVyzVgolzVRVk3r
	tP3JPSA0zegD6VH/pyatNm10KBDunsmgcsWOJq25hL+bHlUY09d+pzq7WpYxy/tv
	1NGmOqYtRz1xU7zm6rSQEbt+bUq2qDkHBPNpoUUbcuxqZffbwhwhoP40LxvMukNl
	D4ZRxSK+JBpidFv8z/tNfZ8hH1QhLHh5lhIf8L+t0pyGbuI/ma3O351lrk3Po+HN
	Y3LhjXkNqkNqDnNhVspNnF1C9tRSPkJsfjvb4yYTY3BeCyyeuCoFhPPGFW2Ewpqb
	HyEPUvJ6G6LRHDtGXaUpSCQ5tiqBQJFW8lZ8xk0eJlfOlRc8ZoFtJRnetuKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372467; x=1714458867; bh=u2I5oCWjaI0xikJwQ7ebCKKH0awg
	UhxgKfsdpvUWxWU=; b=EXx7dv0m8bUEWKJ2xIx+5RUy+0OwqcNT1fuL/+yAqllp
	u3fadJ4b3PDa25Nt4O4sFGSdIL2/uWDQAc64K8rS/clwVKQnjCiiiJTLOwcVHrhF
	OrFj6TVyYOAdAXYouod4XjAq6911GOpYkiqhW4/cEaPrgn7J2O9h7muPrrPM8PmF
	CVh7KQJhxIRjIK4fbrNqWEIxCLE2Ah+ecTPTvApL3e18mVDG7mHMtmeZSvvW8Ffw
	e949+kahE223t2teVWMOoAv4+wFy30GKkhqhbKHv30WjSXZ2x3sbYpIMgReaQMRd
	zb58+UHHDG6QRTZNLixX0AJ5BykDMQkB30msdy8iGQ==
X-ME-Sender: <xms:cz8vZonu_ZqSpvLfPEUNjFHedfaczeL70_jKf6ucaNt-Fk_xkUivUw>
    <xme:cz8vZn3Crx6Rwa_R0k7t7-K3OXR3AvRMAYlnVVcg7kiQeTCSmNm2QUi7mF6zmc4re
    6J-plyRiCBLCUBS1g>
X-ME-Received: <xmr:cz8vZmp1LqJiYFAfU7mLuAWul_a3M8iTPIYqO2QOt_GM38UDk4QA-Zm4bLy_t3NWMPBKQWReiPO6ODLcSIO-clg1jWKT4VuLKtEVgdTP0zlfIjB_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:cz8vZkmm4DnCjSq07DRL2OowXn6cooLPoq2SsqvOXSh7I6-U21pA_Q>
    <xmx:cz8vZm0nnE9Yfsb77qBTTvIFADSH8vuifTfWnaIVBwqELM7vyIn3Aw>
    <xmx:cz8vZrtTS5A5VOP-MCBCLifWDRYbirc1S4eyi9U4j3uQifqx2Wq2fw>
    <xmx:cz8vZiU6TuqQANXKqW1IjwdW9APoO0qWdg63G8PwsXWKY6YRQuEWhA>
    <xmx:cz8vZpQIfYEAyKQyfoGHV71t6mKhy3SrC8Ye8_K87ZXvstaljlN8aJVO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:34:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 31754d62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:34:06 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:34:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 03/13] parse-options-cb: only abbreviate hashes when hash
 algo is known
Message-ID: <9a63c445d21fb6d9179c6fb8a96e0c221ddf16a4.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aycyDSS8vZPyLb5j"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--aycyDSS8vZPyLb5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `OPT__ABBREV()` option can be used to add an option that abbreviates
object IDs. When given a length longer than `the_hash_algo->hexsz`, then
it will instead set the length to that maximum length.

It may not always be guaranteed that we have `the_hash_algo` initialized
properly as the hash algorithm can only be set up after we have set up
`the_repository`. In that case, the hash would always be truncated to
the hex length of SHA1, which may not be what the user desires.

In practice it's not a problem as all commands that use `OPT__ABBREV()`
also have `RUN_SETUP` set and thus cannot work without a repository.
Consequently, both `the_repository` and `the_hash_algo` would be
properly set up.

Regardless of that, harden the code to not truncate the length when we
didn't set up a repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options-cb.c       |  3 ++-
 t/t0040-parse-options.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index bdc7fae497..d99d688d3c 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -7,6 +7,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "setup.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "oid-array.h"
@@ -29,7 +30,7 @@ int parse_opt_abbrev_cb(const struct option *opt, const c=
har *arg, int unset)
 				     opt->long_name);
 		if (v && v < MINIMUM_ABBREV)
 			v =3D MINIMUM_ABBREV;
-		else if (v > the_hash_algo->hexsz)
+		else if (startup_info->have_repository && v > the_hash_algo->hexsz)
 			v =3D the_hash_algo->hexsz;
 	}
 	*(int *)(opt->value) =3D v;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 8bb2a8b453..45a773642f 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -176,6 +176,23 @@ test_expect_success 'long options' '
 	test_cmp expect output
 '
=20
+test_expect_success 'abbreviate to something longer than SHA1 length' '
+	cat >expect <<-EOF &&
+	boolean: 0
+	integer: 0
+	magnitude: 0
+	timestamp: 0
+	string: (not set)
+	abbrev: 100
+	verbose: -1
+	quiet: 0
+	dry run: no
+	file: (not set)
+	EOF
+	test-tool parse-options --abbrev=3D100 >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'missing required value' '
 	cat >expect <<-\EOF &&
 	error: switch `s'\'' requires a value
--=20
2.45.0-rc1


--aycyDSS8vZPyLb5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP28ACgkQVbJhu7ck
PpRbyA/+OdR351Xao6vLJ9A8RWavVR2qSnOUAIV2lj+lb0a8E5/ABXrAAzaaKqMM
9cjNkFY/KDzmoIOD8EBHyXg5Iy4XBLWDttJ0HlZaSh4F7UdbRJVs90hGnW0MDrQg
AanuS813/to9HNWppddC2nPY3QzJX1RU3O84A3Om94mxVoHhJdyK0UV8vmHg+Gzw
mA3nsxf0x59KcZ6csLgG376FeEO9dyD0em2+DhwZ8OrpMUivhoxLBJyzSxOMboC4
fPZK+TEhaAkE9m4pcHXi6k/CnWptb0XnUCGSYdxYqldrSHsuaBUKZpwe1SNX2BZn
+VgFNRu+DGvrv6CLXGfrsZIKYAqzdTJa7EKrEJ63CKP6+F8c+KVmXhfryS/CKCXf
Ho9ffN5AjTcko9lcWbcgIs5k7Z2II9hOPH9eft67DwaGKm7uAMyeSfJ/75TsuMEX
+vVoZB/4ptKDE2MuzRk5EjEllVmBlepvufXN4B1I3xFxld0U3XZKyQgIGBHAuTR0
5pPCOwzJA4Yt4YFZccKaLXNCcbVS39R0pfAY/FSx82I2hVYUEa+whPDe3YjnB5Fk
gMOf9oFQcLMwO1xIUeOyKGLHMzRKjhvoVJkhm4ydIEO+eT2xBGk7jUgotoPicjZq
8avSk9lu7tVjRzWQKiiW1XATPjwHcSaos9qR5gy24clOB5+IKg4=
=UdHD
-----END PGP SIGNATURE-----

--aycyDSS8vZPyLb5j--
