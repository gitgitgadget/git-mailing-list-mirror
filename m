Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373385922
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408041; cv=none; b=mAwXo7iHLBsWWBsNdgdSn29K8odfoDR5ALeEwX/I8we6pS1XGAEve+CQ76kTP4nJlcToZQcYlBExDrnRDDUG4Y/s/mZvX7a5UcU60OlupzEEWR2fhj+aQu5TaOcaA2KyMELyEFAD3tUUAzCdcKmD7u+Yhf6HG3AZ9BHb0dAqUzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408041; c=relaxed/simple;
	bh=pnJWmy/iUd/McklPqCjN6+GekeVgwy14fn4dcpHxHw0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7OS7ha8Yejm8NpyNm/Q5bQrjaY/zkeEUjl3RqD3ntTQ+sVGQ6c8lbmLYxRD3GpSWSPi80FVmsu5HmG22W0SLKOAaekCkgt8yyR9QNvfZjGKxk6i0sUhyIgR5A9Wc2fIlLDfrwNecwFuTRNYBpJ5vcYtn95yN1hteRac7sVrNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GR/6SlIk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=epXkCQvC; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GR/6SlIk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="epXkCQvC"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id C73E118000AC
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408039; x=1717494439; bh=oR9J8uP8u/
	BT4lYwOlVSyFQhLAW/V1QocfGDRDiVWmE=; b=GR/6SlIkrMSvnJDke8aKVEUSD1
	bfu09CotosLLNVTzF4/cjmPaeouJL3bp3zY8s7CHo2d9GlwnRo7xwcif+DHdUkQW
	Q1M/72nP5W+QCiZDw9jwa+GfWUm21vS23iHinpgBQPl30qU+xHWCJezmJDOi4sJ1
	ztj2HXWaw0sTsMtYrE3Z25JTtL44R95crX9JZ6/mO4rvUQ5q1AV0ByD41OiLpGlq
	UkwzKKg8l1qa0j0Zdpc3iJhwPkaVcEZtaZ/4Z/RjxnMms6wrg7eV/l7JPP/PXXuU
	T6ljyrk1uuqqyoL/9V44dcugzhCHstmIe57Y1oh4RT4nxRT32Iv331otJo4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408039; x=1717494439; bh=oR9J8uP8u/BT4lYwOlVSyFQhLAW/
	V1QocfGDRDiVWmE=; b=epXkCQvCFyXwYkg3j3oDSQOo4MItc7MqoKAKE9f5oid7
	Re4kWVkd4IBf9XDZKIivgkjpa0pzAUU29SIeEvVv5RAqmCnsfPV14uDAuUBHlhTZ
	DZxNi8qsvRHjs/I4wz7zvGmn672Sxb4Pbs3ecNVek9ZVU0gSK/uMabZsYZHMRyaO
	mH4vZdlUkrOc3+GxI2e1gCKdeFEO4MIH1nna4ebS12U+oSzARQvHmP1TrtaLaby4
	OMNPLcW+KjMOoYK0lHhe14uKJJwKqxjl3EcvTQsShKdn2aOybnLFnSb2/VDJwJY9
	ujH+Z9xUqHTU0IWYJziXgLMm/4abxg+JwyS/3Y7XPA==
X-ME-Sender: <xms:J5FdZrfr7_xVZ9_Art_Aj58Df3T7YSv_7sOr-mBIHvXaBPbw8H_uBg>
    <xme:J5FdZhPjl4aWRus-nAwDtiLe_bGDF_ozF_N-87umFO_I_adW7BXYxyRA220cEpG2S
    1alzJgQh2v3cpBWMg>
X-ME-Received: <xmr:J5FdZkgZk4tfB4KIxhAEhxmv3GliMcoIPMQhA65c315MjrvyqTxRmTJK5ildr0ztkgdEq1tdk-EQtLoC5ONCDcYrVr7AGcKykMeBaoNGHoZhFCEf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:J5FdZs_fm5nsegJtnVQ-GXpeH4YoCQqzr0zQ2Kn_Wk5TLGhx0wKcKA>
    <xmx:J5FdZnsJioPL8TEIXjn0pkolsxPK2k10rRcMjx56wciYz6PMLRSPVQ>
    <xmx:J5FdZrEnle4S7IOnYJzAXh91_Nn_HnMDhcgOhfenRfceHxRNTaHF_Q>
    <xmx:J5FdZuN99B6-H1H6_3QZ_XEnPH3vznQ1dY_Zi6Vt3isd5y3u0-UuRw>
    <xmx:J5FdZgV2W6IJRBzByGWvFJdnPhNM6gMC4P_oLlQvckGS3CzU6R1Ph_uq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:47:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 303f5cbd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:54 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:47:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/29] builtin/difftool: plug memory leaks in `run_dir_diff()`
Message-ID: <8349f6acbd9309f8b50a07c1583b4946d25fdc64.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b6ymqhAvluTd9S0w"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--b6ymqhAvluTd9S0w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're leaking a bunch of memory leaks in `run_dir_diff()`. Plug them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/difftool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index a130faae4f..63308b1ca7 100644
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
2.45.1.410.g58bac47f8e.dirty


--b6ymqhAvluTd9S0w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkSMACgkQVbJhu7ck
PpR8Tw//aQiUgDtOxXX8v1RFAK7k7ORExT2Gw94oSK+s9L6MeDbYa4i6DDQa8vRH
n26VlLxr9hoBzaToZGWCe+I/19Mfj3a27+mP/PSOZ8axgl2Hycup5zaGjB6rYuao
fKtRXqZEAw7Z+FGmtJwGvoRWd5lfkMppK5k+nmulMUWO8449/sToG+j00q6Ymgvo
1uVRRVe8yOfxy70OTEDVLf+R3BhurnKiu0Srq94N1oh64E4p4GeexadKRlHG8Ap8
q353blIvW53YaXRd2apJu/tMzAm/ha+36shzPzHdIyNEJxBpBoSza4ISrc5YwhVU
NmVp4DzJjuGy+XqSMAk3p1W8/J5i5i7LEfNhpkiNNeVlBF6tWJ/BTo70fhMljHBK
tPEXfivvVh9cNETcBN+FO1H1CH7a+96hrN/HI1XGp7kfS9dAaWhvEY12rKgS5gjj
4vMHP9pW+OyNTnmjkR7nPl8eLromoHtPLyYWwA1Llo1FcQ/xXr8Om41yrqOLS16U
jujxmKb7Ved4n18XdIZMffev+0C9YUFiFLZWtHqt+K54o2jA3lTumVJ7KAOZwZKD
X/wnlVJZxJO4XiEICizx5NgaumxlKbJI6XJxKzUHljndQ3PP7j1JwZD2J+Uv9smq
BrgBi0DTHTmE9hbkMzWqwAN/DzG+zw7tAeSdB8ZfV+JjK528aZY=
=Ouwu
-----END PGP SIGNATURE-----

--b6ymqhAvluTd9S0w--
