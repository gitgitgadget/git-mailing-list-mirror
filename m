Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C0146D5D
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588310; cv=none; b=WiEWVVQzBExJw1e3VQ2fEuh2xWpKRqXppejOpF3qGa+l2NDPTHa/le13cDwfjutqaMhEPe+rYMihLPAEGDZLUR28pundYdC1IlEeDwCfAA7GBjHutO1T0LLqrjQUZleOSNbvQzUfbhD1gU1pLGXRJ+/BjG/bVxZhGKrrKDxhW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588310; c=relaxed/simple;
	bh=0nwwyIrkFFvFbP0oeO2sHsl45gaByKAmmBCvKlDsgFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOp9zkYrwUljdFjRjPVaHlqjq+2lv8t4uEHd8NWH0SvE0ayFe358DrpiXV7Wm/MTIEtarVuGuYgrZoLxoQmY86l+TVoWa7UQmOHcyXIxPB8DhEhJYqEAjBcTOtmJgJJIIcnl5UqhF3+USs2C6aribCs1rsKXH2jJuEpTKS1SpkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H1UlPiCv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NfCw4Ww/; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H1UlPiCv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NfCw4Ww/"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 018021800082;
	Mon, 13 May 2024 04:18:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 04:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715588307; x=1715674707; bh=2KSA/rGdWb
	e7fOkX/TDtw+s0EfN9c/dQ9NUvzIyNLI8=; b=H1UlPiCvTqXP/zHiWB6jEungK1
	bdYnG6UwP87bGWHhLaEBB950Fhww3B5/LkmAe4PoG/NFnq8yvAAsZOzzIb3+nPeZ
	RUqPpQvFujfY3+H7ojgNG/P8Bz+KyNOEvkPC5hNZ4+sTXFl2gvTSz8hOZSh72lH4
	L3OPMcir9e+u7vpqSwu+TPBX+QPpycoUhzwcNT4T7yh14zgSDoKUm7WdtUa81yxJ
	WqeXCfw23Du7e0GTU0tXJkkNkG3x5uWLw1QsY/Y+L+dXX1kcHhRNgwmm+RmkjWg+
	GuqyKb9H/k2Mehe2PwZ3VcX3meMRdHU2b0LqUdw/KqsRx5YwMrGiG8WeKMTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715588307; x=1715674707; bh=2KSA/rGdWbe7fOkX/TDtw+s0EfN9
	c/dQ9NUvzIyNLI8=; b=NfCw4Ww/J0pwOrZrTvzFnoxQXFq1WaLo3DU7fMNZIdeR
	LiRafLOitgk9sF4K2P1Cmt/eahZ4N83gPt36t+DaSPaLQI18yNKLzKiriGPb2dwK
	nuo/1d81L9NCXEt22IBZBRYLbr00QeYnkAK7LpfRSywtl4mC+DJO4pinJiD/xqvF
	obmHKv0dZZSc3SR7aUJGIETPevI5oSnSR4ExrJYjnGSTxCYKM9gfyqEiB9NWc11e
	l+LsipsmFxmOXnDe2BMQKyXaVv0z0p2BFEc5qc7WtgtvcjgXpahlpXzs0XA8IQTw
	NY3OgSR29cf/nBWDegd2qBDr3jXCVLvinnMXsa3+ZQ==
X-ME-Sender: <xms:08xBZrinX8ZvqaoUWZbEMg3OdbJ2UmooXoeT8o9ZNiUEIHyTOo5_-Q>
    <xme:08xBZoDV_9znR4dVXrDX5ZLMAsFH7smjRjj0apnHQSVdXUfnn2OGUwo4scm6QcLeM
    5Caqhje4bQKj3SCHg>
X-ME-Received: <xmr:08xBZrE_H7xAKcGHzjgN2QdBaA4t7H408WGfw3wplDe6XnmXyHo1SYk02JP6NlntGZZDmDpMLHhJIIrJbG2cvbcf7f6YKpPFM8nq8FBoeVcR5mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:08xBZoSQlqb_A-uq5khy-n4NxNSqt5I32QdnLMElciQkkqencOrfAg>
    <xmx:08xBZozk5SH7hllCIYPpkQsLfhMpxCcY8gMZULAj-nHV3PvqW7OQkA>
    <xmx:08xBZu6zLpS2ENFPQqHSCt1Sv50d1trE6XiygqX9M3zT1avkUsAEvg>
    <xmx:08xBZtwBkMO9yUZ9bedhwVMeKV5JOB0dCM9M5DtSwIlUStwdlk9bwg>
    <xmx:08xBZitwdeRY2UZqaog1HulmZs0CsyvR70ydnGwzgU2uefjUYdkHlScu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:18:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8475065c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:18:07 +0000 (UTC)
Date: Mon, 13 May 2024 10:18:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/11] reftable: use `uint16_t` to track restart interval
Message-ID: <b3fe81b7b7f0175fa456142f9c8c502bf7f0e5fb.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PcpFqZXcNvucQ5DP"
Content-Disposition: inline
In-Reply-To: <cover.1715587849.git.ps@pks.im>


--PcpFqZXcNvucQ5DP
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
index e91f3d2790..1c8f25ee6e 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -29,7 +29,7 @@ struct block_writer {
 	uint32_t header_off;
=20
 	/* How often to restart keys. */
-	int restart_interval;
+	uint16_t restart_interval;
 	int hash_size;
=20
 	/* Offset of next uint8_t to write. */
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 03df3a4963..94804eaa68 100644
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
2.45.GIT


--PcpFqZXcNvucQ5DP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBzM8ACgkQVbJhu7ck
PpRLXA//b5K9N7JXbTUtnsz0UtVuYdKVj2qk0zg6JsJ8gmJHngIAicWr3Fu6RYk6
/kPTOrpXDWUBrqpQxsu9DiwKsojXugkOcYI6Pbgy2sfKHywFtQk9cyujPXr0N8Mn
gj78RG6HfCOqm45BuTMq+jmDhDrdIpMn3x9dTp1L9YD3EnyGHN7gkwkOrz6mEAkH
F9izU87J6SlCnSfmbErxiA9uJfgZntYGR37mP0R7IDg4ew3lKlPe+1OhASlKaPLm
IZVK5o/1Oe6dArMlDIfTld57+el1uNqwUuX18T8VBHoP6MX27aEJGSD9xw57D7Qw
4IV89A5x3FCieG37OiZBJmv70/NGz67uQj5M4JJeY4tp1erqVCUQThwGYhTPNQ8N
vgnJse9IbkQfvSx5L4txGIqhU8nvsKxMJIqmM//G86PdcogwyeKbL1092yYL7SrR
c0I3W2w9+hXmqKPwcFWcY8FbVbmdHMjCBPoui0S10HR7LA3PBymiQMocO3tQCHwc
gDo9//lNYel+6etZxrKkZi+W2at5TWdc76s2RZ69CqwpSY/4VJrqjAUP8xJRe2rK
vm4gMUyBGElziqIxbbPIuYCj4nT5KWaSU9ksHcg+XWd39Cb5cF4iGEt8hJESj5V0
N6EzAX9vwqOorlY3EMlgJNLpPXzb8X9Z/Frc+E38oauu4OUU8os=
=68s8
-----END PGP SIGNATURE-----

--PcpFqZXcNvucQ5DP--
