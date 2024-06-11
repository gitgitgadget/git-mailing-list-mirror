Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FE4176ACD
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097610; cv=none; b=qhZBsxA2xlEmBFMiW5hCkp5PABwwecXu2RbF5KE7iL7uIqXK+Rqq004QWyQqzwtXY3HMI8pn+IobdxOnTJZdvR8lJuGBsQTerzADZxzhUQ4BXjrapnbPHv6DKWZh7SqFIsUXDuFE4LFVN+4jWkIBpqBIPFoxRpiq4rdQDQNiHu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097610; c=relaxed/simple;
	bh=KOB9dXif4sGHKJg/m707EbG4vZbmrLa8gJofcQqB8Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNFTpNa7w8pVc/ovakYElMVOY0BiLeSTxGtszLnbHloc19TrNwcum4bCcXJP2H2ASFyGMLD7RV63Ha7H8Rlprhhp/XlZHBlJl59bLEpDdAKlHDS6xViQsIkPuIMjIm1nDJx4xiGpQncEG1dIWjIIX+1SM/XNHguJhDUSpgI1b9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X7jwimwc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GqRvR2PM; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X7jwimwc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GqRvR2PM"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 6CA401C000FA;
	Tue, 11 Jun 2024 05:20:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 11 Jun 2024 05:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097608; x=1718184008; bh=4B5ZbApIaR
	TO3nSzWp2/Noh/4DC8DOUjmu3a5SIADAM=; b=X7jwimwco8TbCoPZRdjyhSaUam
	2xpOpC67op9QBaALk6BajiRTOOaZTPVtL6XJfgyG/KX1My9WVzRoAdOj+gVaoYWk
	dEqhCntzjpyJiwsZoK9oZBqVUOL7V87dpfpwDiFqQeNjFLs/l9xfQsrxyIXe8xN2
	Swuac2Gn1dp6rCCP6QD3xVRJpliFfQbswWd3Ue4HfLGPEC1YclEReWbYN919R/Bi
	hqaiZnY8o5r52QXZm06Gd3lD4V2CWcswsD1opE3USYWECqyPgm7QclO3LaB0ixzr
	quloCjIOso173ja6A6WdfXQdKJNd3zs4uW85auy0e3l1dCTrEIJxaWK8j/3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097608; x=1718184008; bh=4B5ZbApIaRTO3nSzWp2/Noh/4DC8
	DOUjmu3a5SIADAM=; b=GqRvR2PMrtmGKOw2GN+4B9zs58SlWelr64Nkyf/F/zz3
	lkl8FVu7PcAh5KbuopojCLum72U4jw1WIwJTFbGeCNCroUW5318CXkui+XF1Q3Eg
	b4ZiDdp1UXHBO/zDb/kpvSx/u+qulkjW6Pc+DFQwXw64dDWU6qdiiPg2EX/si6yK
	MqWfSh8XY36u+FYq+Wfh+LR/pg5RFu9fDgtpocKbmSmbwllCCNVghIez2tte8v0o
	dumt1NmBKm/V30NZm9YjTO/wLJqny315JPtONaIf4yFOh1RUQkR1b1WkM5nISNb2
	urdrlZV+/cg14xq6iJa6yPdq2YY50kvVETvxE227gQ==
X-ME-Sender: <xms:xxZoZmM8hUnbP3PTsJSSrXnNNwrgXgagA6uWKNtXqVO6wd1d-Thr9w>
    <xme:xxZoZk_ENc8kO1a5TK0Qje0MaB5gGeWuJwR3rxntxXtlrsvqa3mBvcffmSx2rx00h
    _p8TmrMSZB4QlZwuw>
X-ME-Received: <xmr:xxZoZtTnd_oyZ4ZIrenR8yjVaV-tcl9pQDyS0bx8AKrwacW6uTDvnu19-ek-NI7qAawHDJfxcUcoVDGK9lwuLJg8coTmc2-Mrqb2Zs3fFtzd1AO456ch>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:xxZoZmuZqTNC8odnd4MT6N0UmqA1DaRBiydnKWRAYpuZZ4J1VuAHYA>
    <xmx:xxZoZuc49NOmSPgHU7sMBUT65QZO3WDU13yQh85-KiVjUCjm_oED0w>
    <xmx:xxZoZq1g9vF4FzzCQ-UpCgp0OeAK59EeuxeXBY0qst8PTt_Epw4bmA>
    <xmx:xxZoZi8p3Pjt4uMH0e_AB6m3BnB6e6AVFtQFcE1ckBNLmNC8baE0Dg>
    <xmx:yBZoZu5Od4jVaWnVQ5gS-ItLYCza2aF-W6dBzd7lLRkNq3x8vAKGlhjA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id dd7a4bf1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:19:58 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:20:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 11/29] builtin/difftool: plug memory leaks in
 `run_dir_diff()`
Message-ID: <e6ff9a3f1c39a1cb69e8045268577174c6a0123c.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rigmLCLiwKym0a+i"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--rigmLCLiwKym0a+i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're leaking a bunch of memory leaks in `run_dir_diff()`. Plug them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/difftool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index a1794b7eed..dcc68e190c 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -662,6 +662,9 @@ static int run_dir_diff(const char *extcmd, int symlink=
s, const char *prefix,
=20
 	free(lbase_dir);
 	free(rbase_dir);
+	strbuf_release(&info);
+	strbuf_release(&lpath);
+	strbuf_release(&rpath);
 	strbuf_release(&ldir);
 	strbuf_release(&rdir);
 	strbuf_release(&wtdir);
--=20
2.45.2.436.gcd77e87115.dirty


--rigmLCLiwKym0a+i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFsMACgkQVbJhu7ck
PpRIGg//UOX0FmwnhTNSVyVADircTVJ98gpqvShFd2Ni3OH1T84LLiQQbuNLbixu
sviWQaIJFaPiY063uBnl42BDur3y+lVB0RAeM/wGsHfl0jvAAA4iXaSXYZcUeOBK
hoNl5nMPVuIK61ePrTIozO/JLhDGs6nA4kL7u5v0bwE6dhSvpesBFh1V8ffM46Ek
yEcayVFWRxzCsafu3kvkeuTsG1yuZKR9/YzXle43OnNyidcACM8layESykikbLsK
pr6rK6bO0j7Ep7bZiH2Psz8lVIdcqM1a8WDEMVvhx5BsxxFeGrggOIjDZ5lBagXT
0Gl0zStjvF4fKlF5jjPYTbVVlmyoQYf72aY3NZMH1xXw+mD7cSdw42K9B/A0iM/m
JH0/iC0WkkwfCvx0y3G/QWNNmOtn1RWRhIzkc1fZWo489u0AytlofsWLNh419p5G
0ycW//x+FyeCvRsoZ6qCPfJE/El+TokxNj9U/Q+CsX4OOsqPsDcwzIRb4AHrdBQo
g1CCnImAWLfkfOO1ZO+lc0VLmtRv9hYWtYqrIkafYgsc14dct5triF9YQNbOcUFF
WrdLZurUEhwBn6Qc69tSxFW35BW5lFTiVw2lFomPm3RcUtcKaG9o2TLP+VE6nVVc
fJcv4I6+kLUt4v8JWN+PbkaprnYjk4U4lRNhfmq6VCy08yeuJUQ=
=IPNt
-----END PGP SIGNATURE-----

--rigmLCLiwKym0a+i--
