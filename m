Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F1B165FA9
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337001; cv=none; b=bP0M6AVpA0Eup7rEVPWuBHNptWpnlje5Nm6LLNeQGEcCXkkt5X26/EtTKWyLS3cHqgQsAKP0rQfUllu03HniH5Zcjam+cxS+Ud2LE1ZKUfa6pcU1agwMyloNZ+MHEP1Hzqey/WQq2HI0DmzAo+vnD/TXJ03uyWWLgookhKv9RDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337001; c=relaxed/simple;
	bh=VsfLnbHiG2m07njE5cPOYPUZeD+f9MtCqe2SX0WQX2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7cEaJ/XCJIHDxyjfWMidUhRALyNARnQV7RlEWwKPov0SSPZyElu3mLZWPWqX5nNoqYvRHnq2UtMn3WXpG95EKSe/aHN7hYintO0oINTVmIvuFqGe6+V2bMyj2pgtTEnmp1SkniqKQxw5ZdKLvAbh45mBM4BZam25+D+xJbV+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TXfzBrxW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZMogNNgb; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TXfzBrxW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZMogNNgb"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 5A6371C000D3;
	Fri, 10 May 2024 06:29:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 06:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336998; x=1715423398; bh=RYS9Y2gvp0
	ExQ3iP7CTzvHI2QaBTTQwBlP92Tc/qzQ0=; b=TXfzBrxW0WveweZk9zAsbAohoE
	5/KS+R4l0p4QCeogydjr8wBxqzxYw5xDSdaVkZEPpb/LBPbtv1RodZfWBkJogfts
	NVR/9tXhoncW4GV7BeyURQUBN+A4qceM3tLTppGL2QmJDnn6f040QfF2bR9RYFM7
	3AuvmELz+4Ko08E1M9wSYTsuOoU7MyB6r0PZM3rT7Nq6bhUtQbTC+F2piKptgU3O
	JTbddxpBkGVH53pVwLMvkFjjuAPH+YXYh2RH1TWlO5Bi4aGe/SE/dPQj79BTPrjs
	ClkPUS5PV5AYAHkGv1Tw+KkptlA0mnrVp3XzWUBxO0kfC7PQsmKpJ6rAbxKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336998; x=1715423398; bh=RYS9Y2gvp0ExQ3iP7CTzvHI2QaBT
	TQwBlP92Tc/qzQ0=; b=ZMogNNgb4uvEJ3p+kEnRwJfT4lqVx7DHrx7Q/U4hQxVj
	5FXKVTv3qNmcqzMSZYFLXsYi3Zy1xdaEocyKkqswlsDU0U+m3Uzn0Mn1o6uHYIKe
	9taG1IbFJuK3EgQ4C/FLmEVbE7PWnjjbHYmJzjTC5MTqhISqTN0UcrBXTJS4l+BQ
	emBGtGMhK3XSZ+eVw/+pDTCL0mI1/E1k90inBpVgTs03+VjiUxrXcp3+LEM8Hvrd
	RbM74jVvXAdOEZjfvAFPhTKK3YcagcdQzhYNtBqTJo85ULDY4dyLU4uYu/cufmz5
	fiNpkAaAUqPQPY7MDFNQErIaxCNCFylxaoVJcxkMtQ==
X-ME-Sender: <xms:Jvc9ZrQF-qEAl7DoESRgBADa9xDS2olxX2vvod0jalYcVWeT2uH98Q>
    <xme:Jvc9ZsxBejoRORZX7pIZiavAKEk-d2STbc5lFPk0NY47omXzA2IGxcp8YaZ30kf4L
    KjRT5IzJeN7hr9MPQ>
X-ME-Received: <xmr:Jvc9Zg2km0TVtZopl4pyHCE6WJOnTXYvfogAIUDXuk1PcxcXAQtMijWi7nIKAhfhmd38IhBFoUoko1C9gB1Fw64Jv69O3EmSSPtr0VnKM565v4lkmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Jvc9ZrDzh9IzmrGfTn48Xf-XXTP2tYDrPuO62Csxba_5UOfnxH-ZbA>
    <xmx:Jvc9ZkimVkuNZ7H_0ZLqt2k-UnFM3yMGfOdmdnKqIC5WjYJqXBzZRQ>
    <xmx:Jvc9ZvoYkCiH3Ea0nNVYoendkyEIbuVJ1dYpnHsk5Q58gHZ9CQbxVA>
    <xmx:Jvc9ZvjP4AA3qEjQTOZ7ZhnfYraRGEDfsEEYj_3wz3UA-XN2V1gmBQ>
    <xmx:Jvc9Ztvj4IE1uaXE1zhNyFY0A20y72YA8Sg2Ni4k0QQ3e5N9dEronEUt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:29:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c11b8a59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:29:45 +0000 (UTC)
Date: Fri, 10 May 2024 12:29:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 08/11] refs/reftable: allow configuring restart interval
Message-ID: <bc0bf65553c8dd89bf5fcaa592fc3427507f1993.1715336798.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ZZmVUPS46BMiUex"
Content-Disposition: inline
In-Reply-To: <cover.1715336797.git.ps@pks.im>


--7ZZmVUPS46BMiUex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a new option `reftable.restartInterval` that allows the user to
control the restart interval when writing reftable records used by the
reftable library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/reftable.txt | 19 ++++++++++++++
 refs/reftable-backend.c           |  5 ++++
 t/t0613-reftable-write-options.sh | 43 +++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

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
index bd9999cefc..9972dfc1a3 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -242,6 +242,11 @@ static int reftable_be_config(const char *var, const c=
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
2.45.0


--7ZZmVUPS46BMiUex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY99yMACgkQVbJhu7ck
PpQx+Q/+LDtHSWrDRZDty8hLHHkvmxYY5p5bfiKlyHyjtPz4KUOySSnfJxF/2nW2
+QfLko7s7+Pn26E7jaKx8vFKhxhxWGLVjfTCaEapBVvOX08vj6yO8aiQFsjDEIza
nrUP5WyZLR0fBkPscL2HlRZ0u0VvDWE6loVxIh8xXM2NuYe9/ex1Pyx3lOCBD/rq
zaWBeh/Vks1683iYldWAbwtiRSdFD0X7JQnBDB1sRZKJ47ZrLAzkrbJjxT3N8Dg0
V68baQMyFzbKuL2uk1mkMTcnb9VL/nWYO2reidUrZAamGNw2jyB4NEZtdhO9mOt1
Qw5HGN8S+BFi6aFmZWXunZ+CNGOC0qnAWAkj+Dd3PRsxHY6pmxBGbWFl9JFKleck
Byb3RvSvhgPoLeXUYONLnYYFvqCmQJqazbRBgoehSgAwgmtIfdWGD++ab8GxNUMq
fgINA6UfXi9Pqxgyrkeb0FzJsbUqBwGBLnmrRrJIquCr32czaWP11Onta5YoenbI
w12YsO7xlQhUvvOszC3jA5jITLoxgxKnKcILo7E07ewIR9ddtzefnY3LpfmvIsgP
U8CjRAic/6iwZ3OEuZan6sY3mjYwDka4PjSFfOd81w58XAW1b9/6cBtPNHdP05jH
7Ye7A002EViVl/wBTZG1CDT6gvc95qXLE+klS3z9zTFB20HgYgo=
=PEXK
-----END PGP SIGNATURE-----

--7ZZmVUPS46BMiUex--
