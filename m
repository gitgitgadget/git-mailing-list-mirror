Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C71CA82
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848864; cv=none; b=iVIPxs2oA9xm8CnDzq83IEiGrulTnQjVmnfLNXNq6g3tMR5VmjIXWeuYZ8tbhKU9CB9QoQku2g44GrgsD8RBr1hBc7DrV+FloRcz6V5GyNRo17RnhH8NDsGVatmIzCmK0xn5a9ak3gGtALV9HVJHjFfNZBHQkY1Hz7cQDB6e/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848864; c=relaxed/simple;
	bh=X1mR1swojSrf9rVYpv/Xb58qH6w0FbF6e9l92U8qu9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0yq1tIVXbYSUzNAxwVVAfLd1ldIb+1kjgiiv73RnIVxK7oZoM5F99wORyhG1jMjZ3ccSrXfxuK7/gUMccx4z1CPS2NDQEDrN257G9orY+z8h3lRAr+v3hTQY9JVIiY5dQ0Oremchc1woouml2U71MABeDH+1kX7OI3ACBEIpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TkWN/NGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ks1DbnOh; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TkWN/NGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ks1DbnOh"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E336B114017D;
	Tue, 23 Apr 2024 01:07:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 23 Apr 2024 01:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848861; x=1713935261; bh=+goAfq/ig2
	Ixx63alixTfrGeGeORuU+Wn9xNxn626AA=; b=TkWN/NGx3I3rP3ncYhTNJT84ID
	66iSzdhnsNqyMU4tloDDkbDF+AEkPkNHUa/q1bfBe+93+Uy2YuNoZgd95ItVcapP
	fGdjdahKXmvc8eHoCZOTbymIO7uDyj6HNhXAUWYX5bJcMlf1lc/ewB1azWd5AoTo
	pnPJuSmJSoKqd7EJbZx4O4gCX7rWs3lxRCL8guPFgMreFEgEod+YfqCooM4Vz5JF
	ABGpCZKhAwlbqJdZ5BHiTWq2AG6FdGU64idd4RrxgO5GLnezLcZsndhX9mijyrQU
	+O0V8LN1sKYSNH1y4Ut+TIrpExbGZZR+VJhWE4zrEcXtK9J4CjDRF5898xNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848861; x=1713935261; bh=+goAfq/ig2Ixx63alixTfrGeGeOR
	uU+Wn9xNxn626AA=; b=ks1DbnOhhRPx7k0nYprzJmZgeTRA34/yxinb/SrwATtG
	+bxEsgqBhFlyGeShlmEN4dP6nyC0XN5lDvMExSa63jhy66kCazhptBfEhetz/MAH
	rpSl+IIC0s9I1sQSX1DvNeqz4zjgucdu23nLZdxH6tYquVB9XeWh6xWaB0f/XpTf
	hKwsznY5x86teCCehgmJSbhNk8loQsCjGfd08j0m1dU6QWFwu5LqYTvKQ3mr/qsf
	YU4Lf6jc5sVxls/sAkFGnB6QEFb894m5A92exVRqrnENs0CWcDgR7STTg+pckx78
	dMUzkTiF55pMGzcXhjObZ6miN5T8MpI8FfxWsgm64g==
X-ME-Sender: <xms:HUInZhF7zb1kXwgV6qfHFRCdSjMit0e96i03ExCXsR0TYQpBDObGyg>
    <xme:HUInZmXIsOYiBNz_3j1_O_x1sft8VTkG6u-InEmFocLLy3XSOsGSYgn-IB1xSZ0ez
    vVhVIqT3XamuuzD2Q>
X-ME-Received: <xmr:HUInZjJpzFdVsKJIDgcClGSoT0-pkT2XmDLcDDJgKwlM1rLvtmCNeZ4ptRZThsBsrSjF3i-HzKl-u6rq2yM_iCuzpodpnmwWlukrPMUli-USey7y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HUInZnEih6N8ECz2moxYcfxcYEwo-a1k-1ZPjp8TS_gtY4nKW8_FbQ>
    <xmx:HUInZnX06gPAez7_svKda3PrPBIlHqyInX-ocLk70yMbMjAF6E-z5A>
    <xmx:HUInZiPQbRUFvBvmf7-szM6TbBnW3x8f5tIj3uxNKJViV4SDqjVxYg>
    <xmx:HUInZm2ionVdMjFK2vGNErm_Jgnro8uHDls8Zama71na2V148fyeUQ>
    <xmx:HUInZtwxi64DWRk6q2JJotUeg7IH14wlg_WxPfcRsKxAMxco-5oANVVj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:07:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2c2e1e5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:07:33 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:07:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 03/12] parse-options-cb: only abbreviate hashes when hash
 algo is known
Message-ID: <c0a15b2fa68396c763ccd8745a54e16c2941f6a0.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G3Zt1qA47i1dbwbL"
Content-Disposition: inline
In-Reply-To: <cover.1713848619.git.ps@pks.im>


--G3Zt1qA47i1dbwbL
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
2.45.0-rc0


--G3Zt1qA47i1dbwbL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQhgACgkQVbJhu7ck
PpRBFQ/+P7evWCJuN4HxlbDd3APAGz7MyU0FtM7jzh7MuRDX/A7UpUfim4MAMEkR
2GVrDMdgF/cs0sc8Rk6ud69HB+gcAJpz3BX9Eefpaa7g3WbK0I+BYdURy2GajhLZ
zke/vEHU/urZt77VVbPR2l/0Ae4BQpcnv6GklO+rRR83KkIP7cgNc8plSdV9Y44v
UzKRfAz78qVHaHZ+IJmaHdkohrls9yegETAVQQIL1Nz4uKbXy0JL0IhDQg3pQ0pb
YWdiKQav+atwYExbePDVS93kMDL/Le4H4F8Zk6eNtC3CIyqJf5TD5OADvXtJvrki
clQ/QobQSrwmEILJ4qqgu7ZdoS/naOAvKyFHrHm3J4OwRbxBduPoUykO5S8Qelhb
JlQNxarKSAh6vjdZcYNpE8KsRr1Kv2syBrA2PZ0y4q84kDxBRsvLPS2Lxgos8wzW
AXSQcIHB839KLJpwVi4ilMOfU1lpwYNAlkhjXvWFj1Yp2SEX++DtWAbQxgKYcFm7
6QplokZrWSEifuYKfYyohx6D6mKHjP1UEeEnyPVfJ5jQKwCoo++uttO2z0i47uHJ
FyT94za60d8fWZLqzidIWUE8OjZECa2yUpeKF5L+urxzRKM4vcyw+mwVGWwGWTnZ
P20ypy3Tq2GohTPsPQH04RH332SBlJXjhaESM0Dgf59Ymv1pbsU=
=eJ6W
-----END PGP SIGNATURE-----

--G3Zt1qA47i1dbwbL--
