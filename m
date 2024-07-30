Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A394190496
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324280; cv=none; b=nKhj1IhkUTWHAAdI6Nn2kPQtW1AzLclxr+ek3NRgQidDntYbkovz6+6K6DqjqSuEkTbJBv7tLAHqaeeuVG+DVH2+fIx7jjQy66c6pdIOw0BftT1Sdik/ByO++evYOM/TpBDWE1g0Pc8tNysnnE1fOcYiPbowz3+4GpWcyl3iEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324280; c=relaxed/simple;
	bh=GgLpQoRv7Fx21M1XDEgGZzZUV/9xyDuQmC82RwPD8ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG4blkOEDBTJDMtSL7VlHQlgXJQi0M78SciijZEkLymXkTzADLFI5hkJ9stO6dm6EVzWbII+BRyn+dXCF4NBRMLh55nel2UVwaWWzwbZiv7ec5o4aTTLTd9HUQlXbiNDr2aWsNVCeNyh09iVQoiIQXXHzbGlp+VbBu8z1mNFCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L9/whRTR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Plzq7px9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L9/whRTR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Plzq7px9"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 75DD513807B8;
	Tue, 30 Jul 2024 03:24:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Jul 2024 03:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722324277; x=1722410677; bh=YhklpRPYhG
	tG/gtSI4jjNDmA5UEWNtTwK3lJxQGV318=; b=L9/whRTR1jk0p43bmUFhePdRJ5
	q8nGYCcPqjoxLqXUflFS6+1WzxpOb5rghiW2GPXj8XumjuaXWtx7u6ZMRyGhSCpe
	9hKE/cPHjmeKsQjF6/burde1nMoxzNPrOIaf2g3nzN0R88/iscG6YHag2fyQQ2AC
	HQIRm764TRIJWJHuuzelFcGQQJwF62xXsmORA25D+xuazD1tQRPLGJcyYzXWGLcv
	sM5yRherRdvlX4i2WAEOadAk+CZEoM/cNj6qO4v/VPNf2xOX+nRDH/RbAw/fH6F8
	yRv1PTH3xLQ3DBqiO0uxUOAYNSUgS1raGeYOjhk3orA9x1r0Ha7ANw0GZykQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722324277; x=1722410677; bh=YhklpRPYhGtG/gtSI4jjNDmA5UEW
	NtTwK3lJxQGV318=; b=Plzq7px93S1qbH/1qvcy3ooBHQZ98P2vsKH9c6rtAaJv
	ZUepqVVzUCibIq2viXedxN+EsTntg0d5qoAjD5EFpqaZjPI2jZM3kN1cbj9BWY9y
	vimu5YbieuTH5blb4/PT5gvCrfyGrwNAoNuuo/jL9AXdNLcDyjOAgJ6eRSPYEtjD
	i1zABI4PmdJsoK3BPhU0eSxTV/uVKYzKruP6L1qp7mn1bprXHzn76AtfsY2st0rD
	gnsy0/hkUP19RJhCmsFixKnb1x4+JaRa2K63Ohf6ueS1SmorCfIrIh11VQmnRvSi
	sHKJlTufrQLe/UXcFX315IWGcs0mLb1ILj6xs8VUHQ==
X-ME-Sender: <xms:NZWoZuPrv77CqzMbocEphAdgdgnbeBbqjSGWkXe881dgvXiQ2MOQ2A>
    <xme:NZWoZs993zy2zBlNsK13-ZAEtAVt3cF5em3xcXatmm512z8Yl6tDM_skj0ZRczdaJ
    sp-etS1Eweft4fJOQ>
X-ME-Received: <xmr:NZWoZlTjZCrxrah6bhJg0UqYE-VwP_z7y6sL8C8vyQudlBg5J6uSPqCc6xhOgjEi6iadaOR7nqmrT5JtiUwRD5bh47-MIMFAu4qu6YqJ4iA5bro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:NZWoZuuuhV-rF5a7ENrcpnkb5MsYVqQldMILbThTgkuyS6kRTQ0QIQ>
    <xmx:NZWoZmdg-g3TECNNHSUFjQN8Kh6sd_6M4nJEaW23C3PyRv8nOJkuXw>
    <xmx:NZWoZi0yEphjV2nVgBM08Qs0estLb7PXMXM7LZ3I4KWh3_3pU6RVmA>
    <xmx:NZWoZq9c7dKo5DylojcDq5pYag_a4Nx-tSu-RN4TOL4rP8QcqjTdEg>
    <xmx:NZWoZl4yZghaXEM1K3stdCdEOe0R5KmZUxZ6Eol6in46j-D0gpuoac_m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 03:24:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7867fbe2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 07:23:09 +0000 (UTC)
Date: Tue, 30 Jul 2024 09:24:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/5] clang-format: fix indentation width for preprocessor
 directives
Message-ID: <c33ad700d68b5d8b5940dd803d116ec19bb75c7e.1722323818.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im>
 <cover.1722323818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PiIqS2Oi0FOyPqb0"
Content-Disposition: inline
In-Reply-To: <cover.1722323818.git.ps@pks.im>


--PiIqS2Oi0FOyPqb0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In [1], we have improved our clang-format configuration to also specify
the style for how to indent preprocessor directives. But while we have
settled the question of where to put the indentation, either before or
after the hash sign, we didn't specify exactly how to indent.

With the current configuration, clang-format uses tabs to indent each
level of nested preprocessor directives, which is in fact unintentional
and never done in our codebase. Instead, we use a mixture of indenting
by either one or two spaces, where using a single space is somewhat more
common.

Adapt our clang-format configuration accordingly by specifying an
indentation width of one space.

[1]: <20240708092317.267915-1-karthik.188@gmail.com>

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .clang-format | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.clang-format b/.clang-format
index 16fd12253e..0b82f3c776 100644
--- a/.clang-format
+++ b/.clang-format
@@ -100,11 +100,13 @@ BreakStringLiterals: false
 # Switch statement body is always indented one level more than case labels.
 IndentCaseLabels: false
=20
-# Indents directives before the hash.
+# Indents directives before the hash. Each level uses a single space for
+# indentation.
 # #if FOO
-# #  include <foo>
+# # include <foo>
 # #endif
 IndentPPDirectives: AfterHash
+PPIndentWidth: 1
=20
 # Don't indent a function definition or declaration if it is wrapped after=
 the
 # type
--=20
2.46.0.dirty


--PiIqS2Oi0FOyPqb0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaolTAACgkQVbJhu7ck
PpQcmg/+NRZX2AXVywQMGwGcuPus0m1/mhAA+YNATkHvbsbey+Od0RgZJYU0bcDq
UgOlnaXckh1fBhXX3V3qT8t9cg4jxKRX9oNbmZzOWFZzGK2/eyiWfJw8qJU5CODm
jBEDIRLnnezvJ+mPx2fyoEWY2MaC8QfALF298ScwI15wBX/3Jkt64EwTkHX0Bj5+
v/H0XsUI8pOjfGVM4LL/c4HjiweNJ1YNZAB+tuUcubBkQL5R0tccueqPXhvgpZAr
wHesEF7fQVHUsfbu+4ew1/gHalrUaTcoO9+rwVYXiSuidCw7fw/04X2IwV63nmtf
kh1ZOYTy7N5/to1YhLVqLcRAYyFmiy+3EWONUA30TaMpsUwrH440eL/uef2ed2/L
ah/5cyqzawSOQpVL8bmqqDNF8Q02JKLcXOUW8q4mwWtaRwGt1gQGbs4CYzBZsruL
WKWxbj8eJhRVd83Fv6yt/JltaSo6i5zfw/ngSpDxwmJTv6/3rzCMObznPdPkUyOp
OdtKL6b/J+P1yMH2S96nhv/pKx61er2MQOBVBE/od4I79kGagKRozYJls+meilzt
K4JPtnQ+O8R2KHjQpjY62cq4EiU+cLFH/8O2F8cTiEqPmcH+zdKtgQBgCNmvJIwN
WCASDZlOiAskL5EBXi2NcURjl78ij9T6HwHkQ1YqEiVi/6K98Wg=
=EsGq
-----END PGP SIGNATURE-----

--PiIqS2Oi0FOyPqb0--
