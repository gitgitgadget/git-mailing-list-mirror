Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B41428E2
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810157; cv=none; b=m9fVGB2xHoLjs4LjKzDMZ7RNcHBFEg4ifdTSADBEKoumzV2eaQN0XkYYLQBrM7jd3mrFSq4gP5l9AqqbtoDVuNhPE3O8B+4553jqbpmlr4YmZa7EqIrSPrWYAhWKcriRiv6DKALvRCTLudWbpw3PbEvOyXZkhJuK+a27+t8fDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810157; c=relaxed/simple;
	bh=QFxXNWcDHvilZkMTvFT0F+YRNAGQkLEt/9/CbmI5W7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpjxRE8gb6nnQ1iQtnIB09RkE04GDk2l2O8mRV8/f62QIl3gQ/oKqaiboIxbcvVVLSVsD+us0L8Xwsk58IihrkzGNXFHCNfCKmPUXlYuqWF0HZ4IlAycy/1J9WArr0HnkszLdMa1JH17JIyTV8P+14rcmZzRe0rXDTWiii9mkSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jqDUL27p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sobxgGvg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jqDUL27p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sobxgGvg"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 22A09138063A;
	Wed, 24 Jul 2024 04:35:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 24 Jul 2024 04:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721810154; x=1721896554; bh=vwhMV/Gp7b
	QESYisKw+GGaX2LJvWsiUcj6hxEBwWjUg=; b=jqDUL27pN05krRIpN2gXt1F1zN
	Ys9eNWf8+6PTScNPaW3otaYPW0H9ZLI5DMjLx8RV6ZIhURlP1UPg/B/Q7eEjdLcE
	rgA0Ey1YcyicZf/jYkP04hNXvZXuAiDM/rP38oSUsLVc1SIlKawiTeuVZEdvSW0v
	ah2zogTlqKW2O5tMddGCaxvhx8pf+hOHXmh1OQhvU72l8day6jWBbdS7XcB21SQY
	lgN3Q7aWKVHFShL7j7UPpzqOo/MQK3AEm312Gbct0NuQvsbXmDGu5RcD6o6l6rCy
	SqtONIQosVk86yAgV6yA4yftJUZB/q4Qf7xprPDY1d0g44aP/ncSA1KpB5BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721810154; x=1721896554; bh=vwhMV/Gp7bQESYisKw+GGaX2LJvW
	siUcj6hxEBwWjUg=; b=sobxgGvgEqzH2f/WKTV0Y0RKQ2GOa1ww01I+/zY9xWOJ
	hOiFaxk1GyCbbvp5BtUI67oCSuTA8lkyPXLQLkXBKftACYFdrcAFw5dKXK4QASvp
	E5EWpliS9ywq9daZ3DhGH+MPjsouQWNINGhT1yIaLkFYfaVOGjmPv1C/6c++KSJB
	p3PMIG4CPCQyqxYfcOgI8vgl626Uy1WvCwqBoKrh08BfGmIjN0j5NwrDI84QlBgx
	hCBF2tW9R8JIO3ZD7ZyqBhGM+n0p8/wyRPaj2ntL+s2ihNHC1WeY1IWMRTp0DdeC
	GtMIbzfSbTkTcHVYuF7h8og6vSzQyfLNLANiLPhgyg==
X-ME-Sender: <xms:6rygZrvBeWFS7vvc9J98St-gabd4YN7RbdhIH0vydjmBpwY7Wm6PgA>
    <xme:6rygZseaP-8hmeXxNvyDbJ4JBm3GGxvhVa58bQssGXbxtJrWhUv88UcbDdBjAHD_f
    nP9vuxZu6JaQO8HeQ>
X-ME-Received: <xmr:6rygZuwI-Dsp2b5TK4NNB2xIgvb4T9T5SNgxVjfKeLHNFEJm3uUsUTuDUTk1Q-xyF4i858iVzhWrxyDIDlRcQsPCVMlqma6gSRHPrBkk4zePFvvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:6rygZqNAE4cNHAG7XhqFe4lgN_ZnZlC-bnV1usaL2PrSaym1389SLA>
    <xmx:6rygZr-7zPtF2RMLEfWUWzVQ1G0AYpQgwgB_GRK2pLGLarTYnZIJnw>
    <xmx:6rygZqUm1F03MRYfC6Pi9RmUTiYWA2a73oj8TnGFxMV1UPchng7pJA>
    <xmx:6rygZsdDxrZiOpWpCH5JBbDrlwIFf7u43PbS6V49EDpaJLSsR9dVaA>
    <xmx:6rygZubb2tI0PEhpTNdA_nLssm75DkjuslDI2rwAx2Kgg_4RYbRUzUlZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 04:35:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 81e8cbe0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 08:34:29 +0000 (UTC)
Date: Wed, 24 Jul 2024 10:35:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 01/10] packfile: move sizep computation
Message-ID: <ZqC835glYpBFAqu8@tanuki>
References: <20240715003519.2671385-1-e@80x24.org>
 <20240715003519.2671385-2-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y4RHiX7eaHjWrNW7"
Content-Disposition: inline
In-Reply-To: <20240715003519.2671385-2-e@80x24.org>


--y4RHiX7eaHjWrNW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:35:10AM +0000, Eric Wong wrote:
> From: Jeff King <peff@peff.net>
>=20
> This makes the next commit to avoid redundant object info

Starting with "this" without mentioning what "this" is in the commit
subject reads a bit weird. I know you mention what you do in the commit
title, but we usually use fully self-contained commit messages here.

> lookups easier to understand.
>=20
> [ew: commit message]
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  packfile.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>=20
> diff --git a/packfile.c b/packfile.c
> index 813584646f..e547522e3d 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1527,7 +1527,8 @@ int packed_object_info(struct repository *r, struct=
 packed_git *p,
> =20
>  	/*
>  	 * We always get the representation type, but only convert it to
> -	 * a "real" type later if the caller is interested.
> +	 * a "real" type later if the caller is interested. Likewise...
> +	 * tbd.

This comment gets addressed in the next commit, so this should likely
not be changed here?

Patrick

--y4RHiX7eaHjWrNW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagvN4ACgkQVbJhu7ck
PpQ+FQ//axzrxyAo3f1AVLGlTv576GypN69a9VTQ1+FMx0A9BKhh62as7HDlWAnB
ubX67V8/JsTOotwfHxhpeYhc16yoWfY7y5Dqs2A+3d5jNIfA5I3NX+xyvKikbGed
JzqmWxbTFF+9r6s5jkhDyUSLzX1SCiXiHZRSOmjXJzuYkGAQymHyV50lRM1TozxO
7EQfAxyRO+Z1pnqmzqQ2V3U+9NLhWuGRIHkKIwkdcO6g8oyeUrNCjb13D/yrEmEx
u+rVOqry1gCOrHP3GeIlwttFV8PWW7VomWl7tfJdXJfpf5duKLWAcZFKxpywuX/v
ILCupZNXskt1Ew2R8VAt07Lo/70odv5gWBlRQhWJSLdwW4f3dB8+W/zp2x3gkjDU
ToP6v+yWP39i3J5mlkLssu2rzDxlhZgznUj+umKQkw794pK7nTbQnRMlacKlyPuZ
fGFMPeJeEnjYrFRsnawEE+Stl3OIbphF3cGOEUD+1ZP27Tk3Y/hHh4kzzw2DHJ5W
wIcVRM7Uuk9eONLDiaOyswA+86IF0OMPR9aFMZiOxEseilcjyfplwqiEQWxlHGAn
kDxOBNabyryFwE+sgkE9AwfKV7bBG41zvtrBB/MTposIz2c7GhgZvLYPWMvMkAJU
L44dbpDsgm6Q8Wk0jaeQ2r1B7Qr79kOLJNU6lxYOCpeJrK3wLEc=
=H4TR
-----END PGP SIGNATURE-----

--y4RHiX7eaHjWrNW7--
