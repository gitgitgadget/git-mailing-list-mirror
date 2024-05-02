Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA524A0E
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632732; cv=none; b=FBPUsZktldN1H9xsP501s9YkCByTJWiXX/KKUGY2jvtPOYODs5uerZ5qT1/IMU/xBzqAyAXw3IMdcCB+ZYJ32SvoPxNKKHSIoXBLiOBqxKUSBDXjt7srpqYIr5JWXsRT1Y/kVqB1+A8ml9XlLlTXQTC7X0IjfKG7O0huQjTKdew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632732; c=relaxed/simple;
	bh=DMa7YorWs6qN2HC4D/sOzWM8AZexY4TFGppjp3KhHUM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm0LhFVWCQJ60TFg2Wu8jSK7fmcVl2aQUeCdMFBSIZTi9ejP+jsKPUbOuUso+TqEpraED4i6C6SmvMQqoubCYgQsajYwYCVC6FoBwUkG4q6uNL7c13/xw1x5wfSrRD50EaysqGUb5u8D7/nEvW455zkx1RGSL/Jo7oPmsDmdhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=roc7V4lK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Grd9aj6V; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="roc7V4lK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Grd9aj6V"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6AEFD11400CA
	for <git@vger.kernel.org>; Thu,  2 May 2024 02:52:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 May 2024 02:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714632729; x=1714719129; bh=jOZ/nVo3ci
	uX/XcMkTwPXvB6JqMdUK802enhZbN2XHs=; b=roc7V4lK8HrY60yqf5rXndOfX2
	pTyjjktQYdgl0InsI3JbCWbL38RvgMTG1QzxCgWNjD/+KABTPZeJVjP1+yZI6esa
	nV3EpMGMt74fZ1EjbA4ELSlGgtTOZJccStqVVr85XQH4Pg9bMsDoyB0Ygao/Antu
	018NitrKytvqr6Cc7M3I23gUEuA3nazhHUpm8XxK9jXkudasua19uFYQ7rVIkq6t
	+eelCF2G43XJ7B8xCrYOaAD7t7rIaLfS+xjV24G5wk00r8/6zfHkdcF9hvBIV3ou
	758oKOD1Hx6nIZlWZJ92FDUwTzYTIqxjS3Z7IE1u8SuzvjhWDYf1eUJOwgTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714632729; x=1714719129; bh=jOZ/nVo3ciuX/XcMkTwPXvB6JqMd
	UK802enhZbN2XHs=; b=Grd9aj6Ved1TdyFRwoqJrjEggEpOmBIRnCq2WJtGRHGp
	z3fMvV1YRfJdNlbEBa1+OflSn6VjfJXADM9hTPPrjO2ZlQKcZ7MswdwOYwZJyIn6
	oRO2vyEM2Zz5JcocZWeKZXojwnMa3pP1Qs5CNLkuedqhctkC8oF8ngGhye5VSKBi
	bl9QcvuHLUz0KCztS5Mog197iRn9vdnBVAQ5g8r6nFmBt3yrjd5drg5G+00JPxHY
	ASS3FlyZ7TxQ0YEEsDKOKjWjfk0cn6wSlW7V6RgJFrd0u43kCwT/UF3zmh+IEIIa
	2vev3KFaqfMBkt3Yv7RQWGbbjisyvQGZmlVZ/HeRCA==
X-ME-Sender: <xms:GTgzZr3QQAa3TXkd8ZRiXZXwR3GD_f3iQ6drE1VMh3pMz82ZtF18OA>
    <xme:GTgzZqHKVIGLP0J_bu6lkwlb-C7XxpilL9RFoOw9w0R89ku74rw_lOtes-bcZCRC1
    YRtc5Za78ujhldK7A>
X-ME-Received: <xmr:GTgzZr5E86C8If1VpXOZyflYQare4906hXfCZuCVE7hV9uQ4OdF3m6yz9yxJf3H6mlZgqbKLoJ-00fQrPv9i9-xehKtbH7fD5L0tylQJDIjsgPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GTgzZg1lYn9Bi43j5_nirUwuw9bYt2Whff5onv1X1OQByXEf5igvZA>
    <xmx:GTgzZuF47k1tFbOHU7aggIjGYDm3wuuUu1Ul1YZs2PAjJaIcrr0A6w>
    <xmx:GTgzZh86dn2aWBoFMP9FUsby16gDrmmuaGxReNvPPNe9QGg_fc4URg>
    <xmx:GTgzZrkqwIzjMLaiq6OJ3Vm4GgiNpwcoCC8bv3_OkjM0TWY-gxyb-w>
    <xmx:GTgzZgMlqlHEipD7tQeJzBEmE8q0msRjhb95Oewf2sjjMGeedrqXr7-6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 May 2024 02:52:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d92da9b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 May 2024 06:51:43 +0000 (UTC)
Date: Thu, 2 May 2024 08:52:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/11] refs/reftable: allow configuring restart interval
Message-ID: <653ec4dfa59b20e0ca9ef76bb5f2c1725c2bc078.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7LbzzjJlo7WKxTvo"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--7LbzzjJlo7WKxTvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a new option `reftable.restartInterval` that allows the user to
control the restart interval when writing reftable records used by the
reftable library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/reftable.txt | 19 ++++++++++++++
 refs/reftable-backend.c           |  6 +++++
 t/t0613-reftable-write-options.sh | 43 +++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/Documentation/config/reftable.txt b/Documentation/config/refta=
ble.txt
index fa7c4be014..16b915c75e 100644
--- a/Documentation/config/reftable.txt
+++ b/Documentation/config/reftable.txt
@@ -12,3 +12,22 @@ readers during access.
 +
 The largest block size is `16777215` bytes (15.99 MiB). The default value =
is
 `4096` bytes (4kB). A value of `0` will use the default value.
+
+reftable.restartInterval::
+	The interval at which to create restart points. The reftable backend
+	determines the restart points at file creation. The process is
+	arbitrary, but every 16 or 64 records is recommended. Every 16 may be
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
index c2c47a3bc1..a786143de2 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -243,6 +243,12 @@ static int reftable_be_config(const char *var, const c=
har *value,
 			die("reftable block size cannot exceed 16MB");
 		opts->block_size =3D block_size;
 		return 0;
+	} else if (!strcmp(var, "reftable.restartinterval")) {
+		unsigned long restart_interval =3D git_config_ulong(var, value, ctx->kvi=
);
+		if (restart_interval > UINT16_MAX)
+			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);
+		opts->restart_interval =3D restart_interval;
+		return 0;
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
2.45.0


--7LbzzjJlo7WKxTvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzOBUACgkQVbJhu7ck
PpSjMg//ZQ1NES1QqUA3eWvo2F1hS2cWsB7MGTQ8ig2uLJZTyM40RsrScERexQjD
p4z0mEOPruUuWmEjASoJ5raoQ9WSum/KBl7lvuL02Ug4J2b1fMUfukWC3+/VRdlF
UPd5Q8Kbi9FtI5aPtv/oF5cA+z8t2HBdUTjrcY3G/TNCnu1JLsN/5Xv4qF8VN5fP
bRp+lUywLKj6QRIQMWD8DurfZ9fIA4ZfEv0Kg++kJIq6sRcdheckwFw2jaYxjLoX
ZQ8y6ku6VsLOz0TxskH3jzLXocqECQlXRBHD1pGTut69ljdteyFS/N0DmGrMiAdW
4vj72gBRUpdqscJxtmvAjyR2KUDTaYQvsvjMrazD+Wc5mVb/6mUPL3JAXPgijQNb
pbxb5BvFyR4IiaZZJ4pCXBmohc3aR9IMq86v1Z9TqfEfmsfbyor3iDyTZg4fiVTr
5T0/ufnkxxNnY9QWhJegKfLuQnmjBowAeZjl7s3YMrVdpjmudQuz8rLB7QqRjfy7
ICExI0YRwAogBmiqFaqehCmczpAMZfv6McjnMV2vBYW3AaQp6XOolkD8hRDksiu8
nAaPKzDjME+vxbQlZSd776QFre+4hADqLV7jYemjQ3yzb3L2YNd/+a7UA2nC1AtG
SChYicM80cHnMTvOM8kxKzYfS5KaG2qQHGd77eDN5revpCNKc7g=
=wq6R
-----END PGP SIGNATURE-----

--7LbzzjJlo7WKxTvo--
