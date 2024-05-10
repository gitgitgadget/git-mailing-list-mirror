Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9755467A
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337006; cv=none; b=GKigXhj78QC9qVzo3Q+d7lJGXz1dr/L59Za5IdImRYqnK44B+MC9Xz/ijfawEGWqgnlRUONWzvbZ4NvhrxjxPGf9YGFPUTqjkrvog1FxIt/DNNcHuurORCzLD4qRC3UYypBe5idg0w9jM16n3MYAbxSa55quTDEiLNVYbojmptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337006; c=relaxed/simple;
	bh=jlrl32PHZ06yIBttA3hkNThi9QUxNVP9pq1AoJgN4dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY+h7XS2nOj2ZL5Xke/MeL+cb10G8FQxDkBMaJYSD1Zvdt6pZVi5N/ySjPTrgumyqBoE1xyHkpXd6OmiCqRspoSIwo1ltAHgc6zti7cLjkQaxlcMW/pqsYR/bUNMj8nYu+p24H1d77oabZFItvwMwVes0Jjenq+lXgfYxYN5fHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TYCi9cmT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E5u0bbc7; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TYCi9cmT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E5u0bbc7"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 928EC1C000D3;
	Fri, 10 May 2024 06:30:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 May 2024 06:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715337004; x=1715423404; bh=V1hNh4T/yt
	DNcWNn3EU1CI74zS6631AzKSw5ILiVqt8=; b=TYCi9cmTX+33U0ESAsvccNiYaM
	mEvL4+uJta84VNOEqp2g5HVSE7fgmqkNH0p1NPDAXEmu5u9Yk7uYpKtLCE8EhPPn
	donRmMoIYJmtrLuRVs/pmtQATPdzRbv6SbStTKTI5pT9rQDsIY0OU7r1/GCc+8zg
	dUrHqGBHT0DM6x6zRFNToTrRNHnk0iB0HWA+4IGQi550Baj/fFS6QPT53zk3bR/n
	Njgn/6bfuYYbLsvk6lngHk7TEDQ10eDQdbK4+VBs3Bs+RNmWpVuHLkBMdKza/g1k
	xuwkn32j/1PAzUAz+34jFJH43ozid1Hw3eyLaImRZw/KLb0PslkzGue2GPlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715337004; x=1715423404; bh=V1hNh4T/ytDNcWNn3EU1CI74zS66
	31AzKSw5ILiVqt8=; b=E5u0bbc7fIKufpXqNVCLUW5fbJGGdeH130xigbD6eB1T
	VrDpdx22BP3ebB+dDaq6ymPm/+YLnPF4REdfbitP2vStB6BTU3WALd+hWU5Acmpo
	cRiiPg9kOSdAGiNRnyH0ytixnyUB5ul33m8Z+BoZjUKEm5rGf02SL0DSy4Hi09pu
	GORu/Q2fbLXObmHrP2i2xsDegQx9OC9wzXBWKUtJNB6qOh2vu1tdzOXPnnVaxQ5F
	wqL3V/1za8OXQp6aPN0IrEaciMpGaTik3JF9pZ3KyG66buqgZmoiCvLzVxtGdTBt
	VUKdb04Q1OfyeaW2Dw61wU/fCvySkonwnqecWP5Npw==
X-ME-Sender: <xms:K_c9ZoIJvdbMbluHQDXVuVxSTdKHMvAsnbpYciRYUit6X2xWZcCgqQ>
    <xme:K_c9ZoL01QyB7SWBUPgAOGbhH9NpZI1YUYJ4ZMyPwg3oiuoDVKv09eHsO12jCu2hF
    bqmo-N1GbA9CyW0XQ>
X-ME-Received: <xmr:K_c9Zos__ss-Mfd_c5Vdw866LWU66v9GNdgDS5qzA0EGp-34IKnAn--W-J0F4TwJqIKkbB9GGeCjFS-t_Fp-ZlEzbevWHC2pPzAQEUxa99o2yPmmWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdevudfhteeiveehheeiffduheevjeffveefieeiudetffeitdejgefgvdfghedu
    necuffhomhgrihhnpegrlhhlohifrghnhihshhgrudhinhifrghnthdrihhtnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mh
X-ME-Proxy: <xmx:K_c9ZlZcX6teCes7PTJvBB79PWaxi-fwVNSAQCajRY4zDAw67emzVA>
    <xmx:LPc9ZvZYG5QpSFIGYyA2ljpQYW3AoTn5BGHgsbRFgDWZzzKCRIT5RA>
    <xmx:LPc9ZhCBQHmDKue0t1Xzg2dtC4ZVUbbiBnvGKPV4S5GNENUccRdwag>
    <xmx:LPc9ZlblyOF3Xgif-qJ_s7EbG4jgdg3kHYFa4XpPANwpIGPjZ8N4Mw>
    <xmx:LPc9ZrH4cS46BpOASVtrp4lyw2eIckzQlI-5SI3aRDXCq0nLKOTzcBHJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:30:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 36fb6d3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:29:50 +0000 (UTC)
Date: Fri, 10 May 2024 12:30:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 09/11] refs/reftable: allow disabling writing the object
 index
Message-ID: <6bc240fd0cb99d888e5d19423a53a475b6a455ca.1715336798.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NnXpbtQJ1fvVbF3K"
Content-Disposition: inline
In-Reply-To: <cover.1715336797.git.ps@pks.im>


--NnXpbtQJ1fvVbF3K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Besides the expected "ref" and "log" records, the reftable library also
writes "obj" records. These are basically a reverse mapping of object
IDs to their respective ref records so that it becomes efficient to
figure out which references point to a specific object. The motivation
for this data structure is the "uploadpack.allowTipSHA1InWant" config,
which allows a client to fetch any object by its hash that has a ref
pointing to it.

This reverse index is not used by Git at all though, and the expectation
is that most hosters nowadays use "uploadpack.allowAnySHA1InWant". It
may thus be preferable for many users to disable writing these optional
object indices altogether to safe some precious disk space.

Add a new config "reftable.indexObjects" that allows the user to disable
the object index altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/reftable.txt |  6 +++
 refs/reftable-backend.c           |  2 +
 t/t0613-reftable-write-options.sh | 69 +++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/Documentation/config/reftable.txt b/Documentation/config/refta=
ble.txt
index 16b915c75e..6e4466f3c5 100644
--- a/Documentation/config/reftable.txt
+++ b/Documentation/config/reftable.txt
@@ -31,3 +31,9 @@ A maximum of `65535` restart points per block is supporte=
d.
 +
 The default value is to create restart points every 16 records. A value of=
 `0`
 will use the default value.
+
+reftable.indexObjects::
+	Whether the reftable backend shall write object blocks. Object blocks
+	are a reverse mapping of object ID to the references pointing to them.
++
+The default value is `true`.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 9972dfc1a3..63b75f770d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -247,6 +247,8 @@ static int reftable_be_config(const char *var, const ch=
ar *value,
 		if (restart_interval > UINT16_MAX)
 			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);
 		opts->restart_interval =3D restart_interval;
+	} else if (!strcmp(var, "reftable.indexobjects")) {
+		opts->skip_index_objects =3D !git_config_bool(var, value);
 	}
=20
 	return 0;
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-opt=
ions.sh
index e0a5b26f58..e2708e11d5 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -214,4 +214,73 @@ test_expect_success 'restart interval exceeding maximu=
m supported interval' '
 	)
 '
=20
+test_expect_success 'object index gets written by default with ref index' '
+	test_config_global core.logAllRefUpdates false &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		for i in $(test_seq 5)
+		do
+			printf "update refs/heads/branch-%d HEAD\n" "$i" ||
+			return 1
+		done >input &&
+		git update-ref --stdin <input &&
+		git -c reftable.blockSize=3D100 pack-refs &&
+
+		cat >expect <<-EOF &&
+		header:
+		  block_size: 100
+		ref:
+		  - length: 53
+		    restarts: 1
+		  - length: 95
+		    restarts: 1
+		  - length: 71
+		    restarts: 1
+		  - length: 80
+		    restarts: 1
+		obj:
+		  - length: 11
+		    restarts: 1
+		EOF
+		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'object index can be disabled' '
+	test_config_global core.logAllRefUpdates false &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		for i in $(test_seq 5)
+		do
+			printf "update refs/heads/branch-%d HEAD\n" "$i" ||
+			return 1
+		done >input &&
+		git update-ref --stdin <input &&
+		git -c reftable.blockSize=3D100 -c reftable.indexObjects=3Dfalse pack-re=
fs &&
+
+		cat >expect <<-EOF &&
+		header:
+		  block_size: 100
+		ref:
+		  - length: 53
+		    restarts: 1
+		  - length: 95
+		    restarts: 1
+		  - length: 71
+		    restarts: 1
+		  - length: 80
+		    restarts: 1
+		EOF
+		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
--=20
2.45.0


--NnXpbtQJ1fvVbF3K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY99ycACgkQVbJhu7ck
PpS6Tw/+I1sZnetM8kerr5/Lg+cr2id7IbGi3riTGfXK9TffW0OdW5j00hXmhBj8
Cfr4+9toO5IU/7rCKXFDN4UhK7/WX6g8mJG7Mkz196HAqEHUUrmcvoMFjYAVTYIo
o1CN4JEGUbdeilrUrA66YcTn/9YsBHGh0HF9LnqQhBl/AiDco/lY1BZ/aNrmPmBL
YEjtPsfLNfT3nUtF7l4jS1M8Px550wzpTJCsed0EDv3x3DkgGh2hvJyO0gL0KyTU
Z73isoGdvnbTinc3xYN2E0O+KkATQu9nxOFuq+tI/+N3f6mJ2XzubEkvF06y2ZFm
UUQzMrknCO5cOGWfaSvE2alUIUldbrRrEq8vol2SApheMOiYeDniuPy5rDuH/4Ss
AASK5c2CY90q9ARxEKTy9HqrOZuSr7QzBHxHDk+3vHWdo7zdAI2R03d5YtUK4b9a
luE+YbXjkCPCcqGGRSb8+22lXEdJXSjz+pFLOA2BJseko66d9zzk4JqqbQ8PAHfd
D6Cj7oFWMv/WR3qgecl+QitEx7WAsVfvjC4osfqj9GT2UId/wACMHhCGt+bysE59
SUmc/jt508FTcfSAa3SGmoAuBazSyi/oAKAdU4F63uwrfPDjarWihaRMQy6RVoDT
v2ek9S6zaJhlNPpSz9L+KqH4bQ4LOiEtNe3gX7FHMHgTgMj3DCg=
=Uedd
-----END PGP SIGNATURE-----

--NnXpbtQJ1fvVbF3K--
