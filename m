Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0316C443
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336996; cv=none; b=LbNM6B3TTzYptxesXOgePfZMqX1BMZYm/9p5OqSgrbWVVS2hTtd8aiQ1dhFTc5tO7mSas2P/pqKS9qIFO3Y0S+dYcGaJqHBODJKOOKSCoMG0IXvldQDhDmgblvQgMx5BE+egeJEHDEqDrK9ZKJENYD5YMeYvRjdN4RhgcF7tfeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336996; c=relaxed/simple;
	bh=QPg5ZB/M/IGceeUAMAmd8EOlRjqGFtvCWvzo6Sl20WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRUNKPkxGs+ZEOxCSRbJxjk3f6DLiUNoWiHta3C26ftSkp+R1NKBtNg4AlsVNrpVvFAugxrhnJJ2A6FJvhVTlVK3xFdxJ3TJj3Sw4x+FFORK8y2af9D2qN/pB17uMZZtlAg5x9JuknvDGxNF6BmBZCxzwxrtGF250/Xb/+0ch+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b6OuZrZ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NnjF9QEW; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b6OuZrZ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NnjF9QEW"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 829F818000BA;
	Fri, 10 May 2024 06:29:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 06:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336994; x=1715423394; bh=X8u/shzkQA
	QX0JpI/efeOG8pkPrL8vibrojcuSAeQhM=; b=b6OuZrZ8EBbVJOrQPXnbYsl2fz
	IH7aaYgguVbSMZaIp4GDPBGWbkxcWwPQmcfTz1EkUEY7/MtzIrEpc1b2PzHNfrnd
	eeBKzuVgRcUbbe29qL/kMoFvRbLDZT8SgRWtKvCWyN2aMAn+Fmi1PORXh10onCFo
	Pzij+2SufwlpD8h2DMmaph9zkWeSI4DGEfShPmES6rFQo06s/UUCmrpjfvITqZEr
	L/7go6D2n9TK2eOWhLlUBo/FOdZpfzeblQDFljL38Rz2JBFpJX+8KpTFubM2UD6n
	Wi62KyaXl0p+X5plG7NbBXPADFZuEEylcWvNYWkrOHb2jC1Hn5q1Y9kENmXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336994; x=1715423394; bh=X8u/shzkQAQX0JpI/efeOG8pkPrL
	8vibrojcuSAeQhM=; b=NnjF9QEWJMvDwxUfAu5yW8oYzuiuLVIbIvM+dP/G6eSP
	JOyTpEt0I8TBWEotp2bIojbVbx7cq3qCyU6Rvo2MZdpuM4hkyEqZjWF0EbiBCZ5f
	snTxIL2UClkFFbbi4savkbyX+aqg6/NQ1CwlOQGQ0HSiwxCnUWIwJ5tSh25JoP7C
	JOKUlG1tUarDriTt7vpEZGXzAPX/tZ7CDijdSDTcwdSXjqoeTGNx14PAKb9GL2wV
	ILQB/b+2asdNk1zRDQ+t4aaAMwPc/zTZwh74VQLxmFz1Urj+M00hIaLnKxFYIsky
	2ehFbBSvqC2BvCUazR5SF6su2WUJvO2PmIcWGdyk8g==
X-ME-Sender: <xms:Ifc9ZjmHhkRJi5alWeOHNf0KpFGb5VxTnJ8TwBau6pBVW_FTBjwrbw>
    <xme:Ifc9Zm3lRmnOCuaZ5Faf_YMldVFs4OBQ8C1Q7ozC14qhfoqBdVvGfCifvzBO9EsMk
    SnJZSNtTs90L9Z7xw>
X-ME-Received: <xmr:Ifc9Zpr1K4MtuH9ctvcL1u9yEG17Yf6Oayzdh3aoSIUmUp_87dVhT1tHa8OSZQxTJCkguE9_CzLS428ZBj0_STc9ROv9IrBMNdcCHFVZtbhzqRxusw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Ivc9ZrlaO5OyudCnkU4sAbukVC2IALCtWcoIFiU-IIEzZMh5J5scuw>
    <xmx:Ivc9Zh2bl1DaYjd-eF2HN1x6Qw3R31hAwdPbvqb9MU-v2DxeJAWZEw>
    <xmx:Ivc9Zqu1iyt-SK4cr0_iZL2bFHbwufGEmoWt33_kkNa2MF3Okut19w>
    <xmx:Ivc9ZlWN9UXmjJhyP233D8FfrXHsUcDcIavFiW6_eLA6xxnzMBJ9BQ>
    <xmx:Ivc9ZqwFN7_xi3YVtyTnATBBrSjOdKYgVkAhBx_c3-RhBewQ-VCs8cXv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:29:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 39f125cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:29:40 +0000 (UTC)
Date: Fri, 10 May 2024 12:29:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 07/11] reftable: use `uint16_t` to track restart interval
Message-ID: <05e8d1df2d9921426b803d71b22ba3dba188836c.1715336798.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QBpJYJ9sEx2Df4Yy"
Content-Disposition: inline
In-Reply-To: <cover.1715336797.git.ps@pks.im>


--QBpJYJ9sEx2Df4Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The restart interval can at most be `UINT16_MAX` as specified in the
technical documentation of the reftable format. Furthermore, it cannot
ever be negative. Regardless of that we use an `int` to track the
restart interval.

Change the type to use an `uint16_t` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.h           | 2 +-
 reftable/reftable-writer.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/block.h b/reftable/block.h
index ea4384a7e2..cd5577105d 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -25,7 +25,7 @@ struct block_writer {
 	uint32_t header_off;
=20
 	/* How often to restart keys. */
-	int restart_interval;
+	uint16_t restart_interval;
 	int hash_size;
=20
 	/* Offset of next uint8_t to write. */
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 44cb986465..4cd8ebe6c7 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -28,7 +28,7 @@ struct reftable_write_options {
 	unsigned skip_index_objects : 1;
=20
 	/* how often to write complete keys in each block. */
-	int restart_interval;
+	uint16_t restart_interval;
=20
 	/* 4-byte identifier ("sha1", "s256") of the hash.
 	 * Defaults to SHA1 if unset
--=20
2.45.0


--QBpJYJ9sEx2Df4Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY99x4ACgkQVbJhu7ck
PpTiwQ//ZeKpLApBIFfocuAU0xgcuQLwnzKyYPohupNFMdYTkAz/7TOdL23qrLbc
gIuUXo4A1p6O+R2ogV+7Jx6FZ0IQ50Iqcbm8wGGRZ68Y3wKRqjHUTCs5pOPEaqX8
tOyS9z/kVY6bRHUJtiNNEenDmo9CZySDIwf/3Lw0EIlt/UyM14vhOjYCt45fJSp6
MVV6LpLfwj8neQTS1VhBtMbSffx2CyTcggIvZ35ysU6dBN4dcBdZlmtZQVTv3oDB
CFKrML6sCaFczS8mU+lc+HMsrkHK7hN8x4HVQMZTaiS4qClQm71hdE9I66HKSI2j
KeT+F2nmDWAk/SjwpNwx0UgH4U+dbrGmLzAaHCE5qwadcsK+Yajho/ebO6+BWaVf
VJmCgcxY9fMKe2HtwBq1MQjz8GxpeW5mXL9GmX6y4U8YPW+o6xOeV4dEfa/aFCIz
c/pKDQy1H2zULYcRA9N4Y6IYtKNeU2nQnQRIdCvtAwqUJDYejl4Xw3+QldTzZm6w
NcY0SI7JNx6OI7xfS9GBO8n5ZZsREiBPWCzL23GDhkUuwxqhXLyKhkXoO3PSC1Cj
pWk25MrsocwaelMP1x9BLG6Uc2vZ3y0mvSwO3AT3i1nmKnadpu3gZenRX/QzEJn6
VzZ4ywLl6Vn2nWjN4X4lX+bkQ82ZnTyciG12oGIzSC7N6OawK9c=
=q4EZ
-----END PGP SIGNATURE-----

--QBpJYJ9sEx2Df4Yy--
