Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24FC147C6D
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588314; cv=none; b=XE1Kl1fYEP87ivCy1SLmLhRWZu4qu6Vh/Eq/WKIh7xCWgz9W1u7IV7VApRH4JbsqYTtkjVe2hAWRNB0tOSYECCahpY4FkoRkeSV1rONDQjTb6Un8NR1bsID2OweMQZ5Hz5+vWPxakbADoeCsg/arzr/v+GjScqAHtqo/z1jm1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588314; c=relaxed/simple;
	bh=e9hUv0eEfvujMa/Fdelfd0KbS5Od3phy2QaFNSYrRKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzTlOtb3OD67voYEpu828k0QFxI38P/JtJxBwwiBEifxGmLhXbZO5+NH82tW2j+uaWpG+IgGonp7bbswyyx7cUJ8Z4Ehqq4NQJ6dCoDa+I13AL9dTvXUixw6iDih5cW5poKOYUUwK88mIu7XdDsqSzKqwGj2rQxNSskXbAxjpHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W0x8XknP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bN571ejv; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W0x8XknP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bN571ejv"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 24F711800101;
	Mon, 13 May 2024 04:18:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 04:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715588311; x=1715674711; bh=V/Z7zdog0o
	CyriN+gHIoyFw4qbwIj6mQN36ho3mb3gU=; b=W0x8XknP4K27bJkw+uGfo9z647
	wtCsr8XrnXtSfwE0DgoD6KN4wYBdRcrRlpnKy5pLPwaQxmG/As+ZCEYhrnSCx8ua
	R1mwJ1dg0fEOPANceugTSO5zGaJLvhkejuwZ1liKFiW5C/YsY5qEhXUb8lYfSZk4
	yaJ1COk8oHEjFtsc/ySCm9yMtLixLViJJDDy2FiQgKz9NkNbHa+1Th4ze6/0kP6F
	SGHGOB83Ac45OKw7I2Br53Rn+AYQlUG8eUujpasuPnU+pv/NboGMJwU/3O9AvqR4
	yerX1ps//SFHkmTcFUV7merx4agnZVTBMIlts5lIaIB/xkjuAvnmj2FMvNrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715588311; x=1715674711; bh=V/Z7zdog0oCyriN+gHIoyFw4qbwI
	j6mQN36ho3mb3gU=; b=bN571ejvNdGL3ozRAV0HrYiSiKRNYxEtlGSK+M91bPb0
	xpbYx4cb/M26Zy9lvB2nmwsTfE2TGqjVsO9ShRi9ArYkD1Wb403id/+zdTf92Jyd
	aAG77aZfMmR0R/PinTVPgXEjCyQYeHITf280L13/7TgRk/YllZqCeG71kKIa1RQ4
	coap0VN+zz7I8315aa+YS4zYVGQo+Wa66Je4Md5TL/pcfcwkJItrgnanF7wFb+n0
	i9ePha+XMkGWU2m4zW4gPgoszigaz0aMXWvdA/Tlpj/WJFr8KFf7FXnJDJqwVBtz
	wRqEH/l5JMBi6lZdVw8J38pUyZ50vdUD+emny7Kf+Q==
X-ME-Sender: <xms:18xBZu6UJn2xibi8Pcpe_70E0C-GEjwNQQQxUIjyxHwUxCTf5hoDDg>
    <xme:18xBZn5ZmeppwmFkfmSlRMdV6za0J3QWPQIDsOFKODkYtffPbpEStEH_dbu2_fRjP
    AtOInUEppK--jgPrQ>
X-ME-Received: <xmr:18xBZtemOmXpzUdaXxgsmnjDnrucIe0ZzhP0EE3cKcaWs5fKpPKGu3j0rYcz4qFXkzohvBeyMCFCfyMek73OncH7eL6AMv9eztU1yoO7XpFICaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:18xBZrKf9VDsO-_VIHyKDqYyJ63skdM0b4fvaZ6SmnhXEaYTjnVwNQ>
    <xmx:18xBZiKvavbB2PUWO3TsNnZ0oJCjjbsE81I_E8Q2C9hMmipS29iqPQ>
    <xmx:18xBZsy5AzUf8O3QR_Dim356p_qvkfuwzbIEhFeHkf7DK0Bn7D3IyQ>
    <xmx:18xBZmL1MI727O5qInU-0eU5DDRwTfcVYN-wmIbY36pK2uVv53SUQw>
    <xmx:18xBZnEO02bJKpAYHB-wrC9-nCqqf_vjqXUnljedzlcmg4eENn94KyMI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:18:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c5c6ea7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:18:12 +0000 (UTC)
Date: Mon, 13 May 2024 10:18:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/11] refs/reftable: allow configuring restart interval
Message-ID: <2b1579570798a325f8a5c97438b1fdeef65aa049.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bixzXFQe/kL9O/fF"
Content-Disposition: inline
In-Reply-To: <cover.1715587849.git.ps@pks.im>


--bixzXFQe/kL9O/fF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a new option `reftable.restartInterval` that allows the user to
control the restart interval when writing reftable records used by the
reftable library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/reftable.txt | 18 +++++++++++++
 refs/reftable-backend.c           |  5 ++++
 t/t0613-reftable-write-options.sh | 43 +++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/Documentation/config/reftable.txt b/Documentation/config/refta=
ble.txt
index fa7c4be014..2374be71d7 100644
--- a/Documentation/config/reftable.txt
+++ b/Documentation/config/reftable.txt
@@ -12,3 +12,21 @@ readers during access.
 +
 The largest block size is `16777215` bytes (15.99 MiB). The default value =
is
 `4096` bytes (4kB). A value of `0` will use the default value.
+
+reftable.restartInterval::
+	The interval at which to create restart points. The reftable backend
+	determines the restart points at file creation. Every 16 may be
+	more suitable for smaller block sizes (4k or 8k), every 64 for larger
+	block sizes (64k).
++
+More frequent restart points reduces prefix compression and increases
+space consumed by the restart table, both of which increase file size.
++
+Less frequent restart points makes prefix compression more effective,
+decreasing overall file size, with increased penalties for readers
+walking through more records after the binary search step.
++
+A maximum of `65535` restart points per block is supported.
++
+The default value is to create restart points every 16 records. A value of=
 `0`
+will use the default value.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8d0ae9e285..a2880aabce 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -240,6 +240,11 @@ static int reftable_be_config(const char *var, const c=
har *value,
 		if (block_size > 16777215)
 			die("reftable block size cannot exceed 16MB");
 		opts->block_size =3D block_size;
+	} else if (!strcmp(var, "reftable.restartinterval")) {
+		unsigned long restart_interval =3D git_config_ulong(var, value, ctx->kvi=
);
+		if (restart_interval > UINT16_MAX)
+			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);
+		opts->restart_interval =3D restart_interval;
 	}
=20
 	return 0;
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-opt=
ions.sh
index 8bdbc6ec70..e0a5b26f58 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -171,4 +171,47 @@ test_expect_success 'block size exceeding maximum supp=
orted size' '
 	)
 '
=20
+test_expect_success 'restart interval at every single record' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		for i in $(test_seq 10)
+		do
+			printf "update refs/heads/branch-%d HEAD\n" "$i" ||
+			return 1
+		done >input &&
+		git update-ref --stdin <input &&
+		git -c reftable.restartInterval=3D1 pack-refs &&
+
+		cat >expect <<-EOF &&
+		header:
+		  block_size: 4096
+		ref:
+		  - length: 566
+		    restarts: 13
+		log:
+		  - length: 1393
+		    restarts: 12
+		EOF
+		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'restart interval exceeding maximum supported interval=
' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		cat >expect <<-EOF &&
+		fatal: reftable block size cannot exceed 65535
+		EOF
+		test_must_fail git -c reftable.restartInterval=3D65536 pack-refs 2>err &&
+		test_cmp expect err
+	)
+'
+
 test_done
--=20
2.45.GIT


--bixzXFQe/kL9O/fF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBzNMACgkQVbJhu7ck
PpR/yg/+KLdmEkqKpThU0kcFH2agcRayT6L0gi7fftMdt/yo71bZ1+EAehmT5DR2
DPYJTWNx9A16fpueFPDOg6PNLAt15nbqyYVCafUOz+V8cy1ssBj2gBX2Dbm7cSk9
E5KcShFg1utXZ4XHsAFcVbI3Djingnpk0Ao+4MMTI9dndfN5w4u7+pgxS2+IZDKs
fpukXBnYYWx//STdVepE9n1rj3f8gec8u2nJu4pMYI0X5YGIX9TTfpGy9M5C31wN
jrDGj35SD0wSiZuYYX/kOCrrhbV4XpM/dMcIkVDc1wBDVgW9zglI4UR4grleE9to
YMdXCE63oD56A+4IeXJZrs2+rCXRdIPCpPrlj2l1O/Na+BOhwtG6LvKU9NmZ43nm
7ngqjW7K20A7as8+2Yydb4BiRSZ6bBnA0y9Z/oRe54a1qnGg9iHAjF+L5K6p0yCU
+OrAj2mPkRBqQiKj7JcFy9ZM9QMZ/Oyol3IuSuX/FUhhd38guBINnme0XqX5VZWI
7u4tiwgbXsMN6CuipCznpEcIL+lbgiTBO7q1yQiR3KMVR3We0Clwk5Nhnzml/KVb
I1nAa040R+8lqLXPvL/vwfB+dbvrBPit8/8EneqpNPOVwnHcwrXF5RVOO5MzFW4B
3iU11XBq2b7V3FY0WrRHx6i+E7v1SM2Z06elltyM8raZ9q1QeDY=
=U3f2
-----END PGP SIGNATURE-----

--bixzXFQe/kL9O/fF--
