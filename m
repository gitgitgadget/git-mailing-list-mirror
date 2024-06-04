Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EFE145358
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504649; cv=none; b=sd7T2U/pVGd7XC3o4/uEfx0juAKwtfkvs97B7PnZg5kTtEX0GS9C3Hn2xtRN2sEJw86DY8xJfUdfe9nTHP/pwgRc7GtNR7EEV3cJO3YjEkxcWiHbYrs8GMFQ+iy3ae9pbJCCAUdllX/XtcFggAN3G03LFr6l7k192ZO0RshdDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504649; c=relaxed/simple;
	bh=u9MdXh5bg1KbGqISFy++nOUffLO+WUmHeKSk4873/y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+cG9LVlCSTrIXyhwW4tkYeVsHUwxArVHuntdLKQUp/5dtnoiSDYl7MqLIxTSJk2Ey4/1Wwj5YUYtfdMm20Sa0OY68MxxwizolrlLXclEzXVN8GT2rolNyEiYQLtxWRZGlVWYd2HmvXjwTDJz2M0yuJPlhRl4eM+zolCr1hU6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lR9wttp9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VSpiPhg+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lR9wttp9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VSpiPhg+"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8E1791140092;
	Tue,  4 Jun 2024 08:37:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 08:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504647; x=1717591047; bh=42LaTYPhaw
	5GQYlR9ygOxLxVbyuo1yyXu1flRPEeQJU=; b=lR9wttp92G33sMlB0PTP7TA+kp
	nPOlmO5cjXCe5P+p/gw+ns62PnuIR7xjDQQ9aLhNjYn7PUQeSMVc8NGRSAoGokts
	Zjizk8KNX108/KjTeKZVpqLewOEQKHCzDGR6htH3tG7mnGfQOpd/FaWW14kqp9Fy
	lchW1nb6hJ+gVWBXFToRAPuFwItNyMxX/3Q0oYP4kti/+3QY+9SXNTbDeqsJ4RIZ
	DRqE0GVdWNUs8oeUhQ/Y9DlBbT8ytvzwdkvFuHITTej44naMJ1YhO/SRpdGbNjVP
	O0rG1eOcCHqpeYc4Hy0xtrcoQdNbpRT58E3Fn46Uw4WFVuJx56inIiwbx6eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504647; x=1717591047; bh=42LaTYPhaw5GQYlR9ygOxLxVbyuo
	1yyXu1flRPEeQJU=; b=VSpiPhg+ARpP6AS0yXP4a+uqNN3ZYOrwQWlnib4Iwq1z
	Cozb3iKWPRTn2KhoRGFBJQS09VPnCyBFmACstQZvjlU9uMDhmrUDP1VaPEEON6k0
	PinJb8oxUYttETVHV4UfbojImL1EDHFwJHkf2s2IG1C0786K9Z6sAtWb/enyhGYi
	JTbPNdFWpiyfERSS/ED0DAMyy8e16O/wsy6K9sMsuhd6QEUebD1FU7RQykCRg8dn
	wjMCgPRENlTl77I5thfQkcEKvFB/6QRHXKZHC1wIRqDAT1V4mwg88qPUXGjMWQN6
	sn+gxS2UmOoZiVe6jsLGhsXwEoT4xLAdlAJvC/A3uA==
X-ME-Sender: <xms:hwpfZvpOQFRLIWg6mHd4s4onsLKqFrp8kShVzcHATUXuG3AUSDtjcw>
    <xme:hwpfZppYxIhHmxZBGfqDEy1E_9WX0SLJ7pNCa2xzGp3RbMn63CHLPEKb9pIVFpP0n
    ih7pSSe-Gw9K3u0IA>
X-ME-Received: <xmr:hwpfZsNtjNRN5N7lcPDSTHTALbwx_lcrtIoFyUkak9tokfsAlRzkDNmDp0Wwk-teqyPrLKr48EI7RFd29EYlNtwerxZTExBWqL_BL2CfDLT6TTU5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:hwpfZi5aDzmXVTmYvKGbLsoqMszz9b0XGpqXN_T-PCkCfGHfcISKVA>
    <xmx:hwpfZu59OlnZJkH8G9WUzhsaY8BITM-9GW9MmPK6EE3j91BYnhFqeQ>
    <xmx:hwpfZqgOWofKKpWxQvPev7LVTxVUtogsfNMODystKQIcuEgJL2Z4Fg>
    <xmx:hwpfZg6_ADBZEv2ZEWyVCHDeu70EAUTQmNCKrpGQn93PT3GrHLb59Q>
    <xmx:hwpfZp3huUqu_GF6K2TT9BAuSM6QqINohfFrLQb4PC6sfReGlnDrmLDz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6d9b0e8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:36:59 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 07/27] diff: cast string constant in `fill_textconv()`
Message-ID: <6e631a9ea46aa563d197f4a057698a0af53ad50f.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jl2mFLmr0Y7GSiL7"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--Jl2mFLmr0Y7GSiL7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `fill_textconv()` function is responsible for converting an input
file with a textconv driver, which is then passed to the caller. Weirdly
though, the function also handles the case where there is no textconv
driver at all. In that case, it will return either the contents of the
populated filespec, or an empty string if the filespec is invalid.

These two cases have differing memory ownership semantics. When there is
a textconv driver, then the result is an allocated string. Otherwise,
the result is either a string constant or owned by the filespec struct.
All callers are in fact aware of this weirdness and only end up freeing
the output buffer when they had a textconv driver.

Ideally, we'd split up this interface to only perform the conversion via
the textconv driver, and BUG in case the caller didn't provide one. This
would make memory ownership semantics much more straight forward. For
now though, let's simply cast the empty string constant to `char *` to
avoid a warning with `-Wwrite-strings`. This is equivalent to the same
cast that we already have in `fill_mmfile()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index ffd867ef6c..cecda216cf 100644
--- a/diff.c
+++ b/diff.c
@@ -7235,7 +7235,7 @@ size_t fill_textconv(struct repository *r,
=20
 	if (!driver) {
 		if (!DIFF_FILE_VALID(df)) {
-			*outbuf =3D "";
+			*outbuf =3D (char *) "";
 			return 0;
 		}
 		if (diff_populate_filespec(r, df, NULL))
--=20
2.45.1.410.g58bac47f8e.dirty


--Jl2mFLmr0Y7GSiL7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCoMACgkQVbJhu7ck
PpR94A//VTNLleWvKee5l4bpTnPtg843MUvmvPD0hecTWocp0pRieeIpl8tXzNog
dipcSHmgEaWgVKi+3uGrpVpHa0tnLaOsgKrRjSLGFpK7ZQ/CybZbLlqh3n1RuZRF
92cL1sVYumGq/4amZvz/i199YtNt1DNVXt78NgNP1WUONA/F9zfPV4nq8IVl2yRV
wvhtZzlvJsoko7QsJNBv6eEdu+h2bKDxZHiC/mRO3SbeBOr0HIGBCuNHPVpM7rX4
W7KhYfIS2hMrbe6JDrI27vSC4seAGqxMI8tYa+jNPsQZyXMEyRAYTRwQGTTq6Ab5
kaPE94/ihmqzbnskGAkK7dOUiQlH7AM6hL1W6sIp3xAIfOQziHNTubhLsp6AQYS8
0TVGubla0pPEqN8/kmiLae7bWUC9eN7m0QiPTczsBfiw/mHORavkaV4eceDnkm5A
HWRtLb8hm1QMBceTEOR0xaiQLsMqGmXkzZ5Lp4XywbdIIH+ZaoFGnp0Xizx8cNuj
lhjWdwTAp00CmxrwEvqDW1sLF7skDSxFxxEVvpFUVwSNsmFujXekYTmFy0ZJxfkq
D7R2qxajx/qx0bKtnplrwP+VpB/32hmBkvGWVeINQ7DepJB/vCwNmbH4B3Q+w8iR
pV9J2SHR1nb+jaGkfbpOLqbrf3OEz23iaeZwp4FBzLhlaYW0K9I=
=yNSe
-----END PGP SIGNATURE-----

--Jl2mFLmr0Y7GSiL7--
