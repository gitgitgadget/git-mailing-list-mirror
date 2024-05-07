Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F16A8C1
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057585; cv=none; b=u18Hv8vJZwO3A9O8ZfjW/D4SI2xxyPiorlXxbIo7o9wI1qy4jPqLRyAV0yft6qQwjYw5WFiR7cTdR69ffYPSHscKfefBY7RLDAK3bYYEAF2pgQYPd/D1Whne3Y4+rLTkPIJDZjjPGExsX8ZtdcC+Jf3Xj+D270mHPO9uKr7iEWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057585; c=relaxed/simple;
	bh=4z6VVdXr8vb2a17XIjM1oOFkNbGGLPKEO9Y6A92qzSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecOBbEHj+AlDyp/j+/Eu06klGHQFTjn6nWMOYQfWcHJaujDi/yNzSlJbZoSBZMbV2qOq/KvBOyzFW2IUtYku5Mrbn3QNk+ZvEmXX6Rxz4o0VzTT63mV7gIlDy5XlLH4HgjwjTe8pNXpD6jE4ukifRN6S4WzaSCcN78/UyHuGR2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EexDwsNJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FbmruDAD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EexDwsNJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FbmruDAD"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 00B3B114012B;
	Tue,  7 May 2024 00:53:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 07 May 2024 00:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057579; x=1715143979; bh=19Yy678alB
	a7qlJ+4Z3NvIW+R7r/nPyIchOt+UuX00A=; b=EexDwsNJ+z2z4a2ownI5eNyd9L
	Sg2FKSG/wT40YpUx7sudsU7fdjrKBezTexK7hKgJYfLN/rq9HlswmdPUFCoXemtq
	sRXf4n7+TP3SoHece29P3nodxlwqvajEW4WHWHG6wmbDfq6ngJ8nYVzRE4uWsGfH
	3YWDrEantaGVpKA/Qc8th8xvVt3wjQqd+z8xrGWivsg4ZH0KD4ww5xLswLAiRfji
	x+/4/dFpY2B1Ku6F3o4+FAsXrGvymWrt6PmiN2uR87x0FC60+tg/qVhgxcBrMA5w
	5pySWdXCcL7rgxLy4TY/cdVf8AXD82J0hVFDUAgznFmK2r0NPzAHc+eeHyLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057579; x=1715143979; bh=19Yy678alBa7qlJ+4Z3NvIW+R7r/
	nPyIchOt+UuX00A=; b=FbmruDADtMR0y0N11V70bLTqJuQMZAng4Ufu5cJx2nnt
	xfluJtS3yOkmvsVe43ojfBrSMPFkpfUnnDC1n3N59PDW4SMiui1R5/JnUNG5CqJD
	7yQjWlOUK7prw1Eeep6MCaVg9mZJD1baWot9Ark00sAWWIESCD3O3JVjHcY7ajAC
	SFDM9coSdKYdMyFOTuMVg6fB9yNWaHXvD74KXL66A4nPsiPzP3884PqG1FLh6SCG
	hZmAXnmesNi3c4eJdjBcBzT2So0dUbsHvwt57GkiqwC1Ot8DlVcJpVXJWCYfcHn6
	/u86FENr+ABEKmGA+jG+Rur58Tu96S3DXfUfRSBfkw==
X-ME-Sender: <xms:q7M5Zn2aFjbtvnZWIcBpdGgEF0M7n3PEmd7Xfwmg0b1rxGxMUQk4Og>
    <xme:q7M5ZmExnm9jU34TZC4Lw92O76oiC4WfV4oPfVjgRVdF3zX9j9dLuYsiuFpktH09j
    qQCHzCzStCv_jzNwQ>
X-ME-Received: <xmr:q7M5Zn6EhEGQSMzbCBnqPsseyyvXdvqcu8UGUKiesswgZwskT6Dp22Ye23sCjcB85_2q3sOfEhOK1KNRXNiD-E8ItPMkuxTFcvbu0FLtkE8X4DEc0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:q7M5Zs0JgaEyTKAQCy6Ts8BdHKDidxoUtmFUsjxmNB7jIR_Mgro8OQ>
    <xmx:q7M5ZqEe_70oGBrHnx-ytGtNnrBK-T3gZfrcewWh07vop6cbxzqKYw>
    <xmx:q7M5Zt9Md3ajX-Tk7qKFqgNeGSDWNlIgZr8ZMvx93aknJst4luo_8A>
    <xmx:q7M5ZnmmDVKLpynUlKMKGxhJ2UI6YuctCIt7lbCaTecRdb5h-R0Wig>
    <xmx:q7M5ZmgrlpmFBdbGePj7cfaLr3uapWcrgRU8QglVKrCoCeGjcyV4ligz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:52:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6577c52a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:52:51 +0000 (UTC)
Date: Tue, 7 May 2024 06:52:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 03/13] parse-options-cb: only abbreviate hashes when hash
 algo is known
Message-ID: <1a0859eaf118090b4d172792e63ee9a6ba752b71.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1wCbqSfzUIwk14iS"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--1wCbqSfzUIwk14iS
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
@@ -6,8 +6,9 @@
 #include "date.h"
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "setup.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "oid-array.h"
=20
@@ -28,9 +29,9 @@ int parse_opt_abbrev_cb(const struct option *opt, const c=
har *arg, int unset)
 			return error(_("option `%s' expects a numerical value"),
 				     opt->long_name);
 		if (v && v < MINIMUM_ABBREV)
 			v =3D MINIMUM_ABBREV;
-		else if (v > the_hash_algo->hexsz)
+		else if (startup_info->have_repository && v > the_hash_algo->hexsz)
 			v =3D the_hash_algo->hexsz;
 	}
 	*(int *)(opt->value) =3D v;
 	return 0;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 8bb2a8b453..45a773642f 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -175,8 +175,25 @@ test_expect_success 'long options' '
 	test_must_be_empty output.err &&
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
 	EOF
--=20
2.45.0


--1wCbqSfzUIwk14iS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s6cACgkQVbJhu7ck
PpSZxQ/+KhcaMyhcHYgJUsW8uGtjqEzjyrajpsO+4zB4HGLw4amBe2Qt/gJgenyi
8d/gkUKmBB6KF2ig1SidedoHVZuMNTSA7YGrwn+BeuPiLm5q+Pjnsx3CWLRhBHVi
yfXD3BVqLqqP2QTYoIFVUiqRQDRk/XCZNDVanT/HABL2doR0FvmUyDvmSEYx0jvw
URi/oEjjkBQ2GedBCo9hwDl19Bqep+ZrIYc6noo7YJiZC0oMbkfqtrSmVAdD+jbq
XirrPCbuC8kafHjeL0hvFw9v9yRs4En3eead3PKpbWguUYJD/nwapiMoO1LrCLQu
9QmrXt4YqUWICCV6/wdiG5ybMjnzbzXDvYeiZNtunMfnw+vx8LXPsFA3Bx3CeDix
eG30JHdjgnfxLCs8dBKZF+4tbeMekj/BJ64yJN+xIh/YCyros1Tvn4MVlV6mMgAv
mp1ExfisXgZ1f1PsNNNGoNtYO/RwCRnU6978t+YSAlBqyDb0ZwL2b4gt5QggTuGH
9QOvD068SdrSxqvDoyoAUNWWW27d/ZjNYbh8Xgg9bYWbiJUkT5bmVN1VrqFYmCxq
QCR638yHlal41oEMykyj7LsBxAGxnelK6HkiyBhYzLRcS6wL/gvvfR+SMk6wuDHy
5Bn3IV8+6PoUk35R4UbZ6GkUweIIA3cRfT+f3zWvILcQbuo93y8=
=jk+s
-----END PGP SIGNATURE-----

--1wCbqSfzUIwk14iS--
