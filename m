Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B817582
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456469; cv=none; b=W5tHvZqdBdhlccFq2p0FMKTJCKrz6Z9lJPuoK+NNJezQHETJVDLm10XBsOzZdfbd4j3eJ+/9GZZ0kUYFA0uoCuyC4fHVY85D2L4VjV1VhJFhTJhF6NIY0P+y/wEYppsYg161tt1tcwjIVm4NI9GX5Q54sIXPBNi10jUbq6dM/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456469; c=relaxed/simple;
	bh=KdcRGJSJVkh7Zfxe31SYOIkRotYKi3+TT9+Uhxazw+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipPjA43ZI7YK8xWHwUV5y75aWAUnO1Rnact5wUp8JQ9A+PoF+8o0zyBbYGXR/N6DRyidLFbfbn706RZqRJC7SsKaHyHuyE7rQ5mkcxYVmqD5QAeeM237m57AM1yTQcUDlC+5phfFSOF9TNKrkGYqvd01/q3LUPQIGf5PRtS7c5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=graXDkKy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ao2w2jOf; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="graXDkKy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ao2w2jOf"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 93C641380097;
	Tue, 30 Apr 2024 01:54:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 01:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714456466; x=1714542866; bh=KdcRGJSJVk
	h7Zfxe31SYOIkRotYKi3+TT9+Uhxazw+A=; b=graXDkKyRImOT+q9hU+atOIA7E
	zr6hFfYFsObhide2DxoYJjkJftkWlep/v03eZGe3zvaWCB3DeDXQ6SnqXdGtLa0R
	B5iGTyeNAUTJ1UqE1NEX0ngmEuVG9fenEBSc+qOlIzBbHSJDC/ZjU3/2MwRhd7c4
	SwppV/FE2NxZbXHJQjIrgbNb70dZhlDONcGjuEeHLDfNs9YDzbmwdxqno24sDWMK
	k6efeWpJILoL+W81oqD7RWQRMH4S6/i+qf4rBW1Dg42WVRVYvsloo5OCg985OgEJ
	8qPxRKVSR3b9KB9j0UbU1Cgo4Q5jBsXJ71uSTog7k9fE3Z9FnccOUxl1gZCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714456466; x=1714542866; bh=KdcRGJSJVkh7Zfxe31SYOIkRotYK
	i3+TT9+Uhxazw+A=; b=ao2w2jOfRFE61p/s0HdqfJ4VB2u5/9LavkQIKbEJXP2X
	Fzn+c9robYL3JWagZHBTIcdFBfxkP4xGfJEQ6WrTawe58ws7QMMROJx1TB2In47M
	FosnkeEYYcd6zm5xpdEbBP1pxWo7a7FmtulaYuyFyUbPCq/bKGOD5Hkv/rcGa1TL
	8do3bI/OGsnkkso3UrY1YdxaAefzPCGRXzacM04ivvEepKCetAyOR4+L2Ofkgwg5
	dgeiwG61UZP5gfjkJVMDVXklLH/cR+fYlS2QpMVlOgq2F0wKcxI4Kt4Z6aRNgt2i
	7Q9852AIPhFDPdDQjs5rlCspFaDPkW/vxYDmDZC+Pg==
X-ME-Sender: <xms:kocwZoqm9QCL3CZEnQOrBI5BSzWn9pd-36hvbZ7d0Ma3rUaW6XqKhQ>
    <xme:kocwZuoAZpeDCdG5iKfsdK7UiKun9JlZxeVlJ7FZbUXGF90TsO1mfiv0fA0nMI4aV
    HdzKnxYK7rf0McIeg>
X-ME-Received: <xmr:kocwZtP3WNaCEzmdZRTwcANFyCm1IRCISDV5AA1A2mH5w6__imuUXn3dO13BFaThcwYO3WQfU0bA6hpN-Ue5KyMJzdnBIyqhbfKnsNAV8vTcUAuPsQWD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kocwZv6C8Ocfy70Wy5SL6IFBNXbtYtrurE49RmJM4XGeP6pburVsdA>
    <xmx:kocwZn6-gxkRJrYmZg5RhhTwMNqxwMGQpCKplS86O4Z_LLrcEKu5iQ>
    <xmx:kocwZvjrS5ulikd664JpulTy1mzYvDIbJqSQkFRv1moZlTRzIpRiaQ>
    <xmx:kocwZh7akWA9WU4YWskqtCX_10Yzkp5wUFPLU7reHFzbkcUpiFFWQQ>
    <xmx:kocwZq1OjYaQG7MWageQL7gRcGTDS3ylEgu3EM3rEoWcdhWt_yjJuqfo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 01:54:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 18347a01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 05:54:03 +0000 (UTC)
Date: Tue, 30 Apr 2024 07:54:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Passaro via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH v3 2/3] builtin/tag.c: add --trailer arg
Message-ID: <ZjCHju27OJTm8V1k@tanuki>
References: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
 <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
 <5b6239167b8d7c26f96e5c23d0d82b7a3a9b01fe.1714416865.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b26Usm4vxBBfFp5s"
Content-Disposition: inline
In-Reply-To: <5b6239167b8d7c26f96e5c23d0d82b7a3a9b01fe.1714416865.git.gitgitgadget@gmail.com>


--b26Usm4vxBBfFp5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 06:54:22PM +0000, John Passaro via GitGitGadget wro=
te:
> From: John Passaro <john.a.passaro@gmail.com>
>=20
> git-tag currently supports interpreting trailers from an annotated tag
> message, using --list --format=3D"%(trailers)". There is no ergonomic way
> to add trailers to an annotated tag message.
>=20
> In a previous patch, we refactored git-commit's implementation of its
> --trailer arg to the trailer.h API. Let's use that new function to teach
> git-tag the same --trailer argument, emulating as much of git-commit's
> behavior as much as possible.
>=20
> Signed-off-by: John Passaro <john.a.passaro@gmail.com>
> Helped-by: Patrick Steinhardt <ps@pks.im>

Same comment here regarding the order of trailers.

Other than that this commit looks good to me, thanks!

Patrick

--b26Usm4vxBBfFp5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYwh40ACgkQVbJhu7ck
PpSr4A/+NnJme71Gqy1xfFj8nNznswQ1CmwVNzs/k+8cj3MczJtEWTSNygvycR6w
jBK1y6DtGGhwAQQ3qL/9PE3wYV8S2ztwWvf4eeIkx//+J/Dzl1u7C/gIHqcX+i+P
LuSCNfu11pa8Jl8ShzTHBCE5QxeuRw3kOvcBv85va6MKG9P/5woW780XBt4gHc6Y
c6Es1Ueso5jZ5A+6mAPvtd7Geap9RQ4Rzmxvcu+5EMi8vvBiqC9icDPR/kP/zr6o
Ip+GPnmkfR5Df+MTdHGA9SEd0zlKh01UNEnkCVkt0Ohhc0AJmSnCTkolcwjL01dw
F+wYNZXAeWur3FZ81BMVLfq06TriV6Uldv+d4OqvuLnho2NpKEV8XpK96g3hrDb0
GFxzjRPlarOL+KUBJk8xNNOWPF5/0bCfuVXUZsp0nhOILq5VCAx7XFeX/7AZdpdm
iJDrXqZY5Yq5wkfQunSqtxSAuaE6bxRHvGe2Mt/6UATpkanOCz4qHD5XAQWN3srP
+P6r0PY7COmj/Noa+YcJ9wRxRgukLCCe6IzzntSTPdUt8lTqiJfyfd7tykPnP7Ok
TarP3q8lXgt+IvMxQPA92bKL0WZis7FK5vN/0g5qhPifLqGt70df33qWovW/gtGI
AGBvNzPomzNMy2mFAmoaj97zrnZSjIdXT9bC0/+kjFODJM27ygc=
=JdYV
-----END PGP SIGNATURE-----

--b26Usm4vxBBfFp5s--
