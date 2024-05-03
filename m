Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06614F9F4
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730236; cv=none; b=pDUDRJ8zQXUuHH0G5A3SbZGmHNyN6rCso3Tpi8ScXm7sfNaquuN9rI3PC0RPH9kUcFuvzkKtql36psTKf8lDHVlQ4AgtrkO1c9cDXB8T4l1h8UcqVHSWF2c4f54f4dKpXzwL9xSm7zuXWK9D20b/fyDzZvdpydlpc/GxcmkmyXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730236; c=relaxed/simple;
	bh=LL9V6w2wrfe4JTAwuQbuAhrORCjbI3r56zP0PsT2FT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7CgNDF8cETfsX4FOmCCh0/PB1b6pRBJaqswnCzpz3h5j9F38PZroHZzd08nqWNhimpf1vJPo5qHGE6ISBJNj/qmnXOWpCfFOfXUvl3lfCFzTqqoWDyLkmfvgzMSe3dok5/4x2AhOsh0P85ZAJaTZTuD+FD5/rFFW7GQPOmNhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T0sd3iKr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PCe3kUSP; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T0sd3iKr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PCe3kUSP"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id B11321C000CF;
	Fri,  3 May 2024 05:57:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 03 May 2024 05:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730233; x=1714816633; bh=hmzn6sR9hi
	Gr5OpHp1wVq76p7J3Mx5ROClZCGTu3Hds=; b=T0sd3iKr1kkKic2FV5UBDIVza3
	7vtypsb1sulSNZrjtAgivvZqGfhK4L7u+GbYsyhYBAqrcqb2hLSiMmitT0VudSmi
	K7LbdaIrf1pX+WM5VX1lH/2AiLvxOnjg6J5XLPGjWMBfFi3b7ZHDt1zlZpUSXNZz
	L/AA134VOGbwtrUYoq2QMtd8kxLaPX3NXrV++tet7PiQBWVtvC+jJhCVCAgcWGeh
	6Ke/+93uhCHczb0v1/7R77OD9mA0CGAMntA74EsLkd9YkWBStmjSROHnsU2ZHcM7
	RCDlIihP6ogs1trpNLtjlhsW0XFmhtNeTxUnwYg7Gbx7WNeRdvsw5nOPMLbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730233; x=1714816633; bh=hmzn6sR9hiGr5OpHp1wVq76p7J3M
	x5ROClZCGTu3Hds=; b=PCe3kUSPtoyY4DaEltywNlpT2q38ckyrsbL1CEjNQp3Q
	K/20wpxmy5GoFs8iOEF/j9TKZNStCHN6e+zwmFbyKtfv6bekqPM2W6SALfmR6Hmu
	5tdca9ndN/+/xGDzPLaMLFRi4ZGSEAnkzm0DhmXwqsL0ks/9FPuG9tZQfxzf2UGt
	VRDfk6vlnruFIVoOp9k4LApSfvLem0vJf64ZFxzo+FBXk+Vcpr/zOhxNwxGRk1BD
	mEAFOkxlByHtz9Kaqy8uFF2K7Y8FUhDXwaM2/94nw8lKVOgOjsmR5sKSOegEuXAh
	DQyXwLbhj5T860iGZUmvIYA2xAR6tRek9i6MZ6vmRA==
X-ME-Sender: <xms:-bQ0ZpCyl6si56m-LXL-isWLhMQ5yIgXvlwD7BnnIczO86nimoastg>
    <xme:-bQ0ZniDuh5cLaWowpqgYA_ar3GQT0qwK84WplRx3YZryWB3jJo1A2dy4XB01zxD9
    awTp5guWdehgCmxVQ>
X-ME-Received: <xmr:-bQ0ZkkiiOFumvoIKHpBE-IQmqwfb_7SyF5PVAxgS1fl-TKEAroXussaU7sQJmaXmTVI0q9QbaofkCtmTRC-TH6etvo-0u91vTZLUzq4J4qPqkDM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-bQ0Zjyb84N-ABfYbGwZh3Y4gbOEfEytGXqGzIbFAcpIBv1deHUwew>
    <xmx:-bQ0ZuTExGucG-ZQ0V6oqRvtrRzBaqRw1Nj676XkxMOnMexiWdRwAQ>
    <xmx:-bQ0ZmZJw2YKd-fld5C5W-W91nfOudXkVaCanLa-egA-QtmUVh_BiA>
    <xmx:-bQ0ZvR1vcUnOzy8Nejc8IrWt1odbG9aRYD64dgfmA8CrmfZQqdDKA>
    <xmx:-bQ0ZtHbllUMKQBZzvAIsgPjLxZbGTOw617sDw8aoJu4pa03zfZc9MtZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:57:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d6bbcf3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:56:44 +0000 (UTC)
Date: Fri, 3 May 2024 11:57:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 06/14] builtin/config: pull out function to handle `--null`
Message-ID: <cb1714c493fe556c7a55fada2e83d97e04bf4748.1714730170.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0fkpa1h8uzDpMaZY"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--0fkpa1h8uzDpMaZY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pull out function to handle the `--null` option, which we are about to
reuse in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8c7cd30cb4..59877065f8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -698,6 +698,14 @@ static void handle_config_location(const char *prefix)
 	}
 }
=20
+static void handle_nul(void) {
+	if (end_nul) {
+		term =3D '\0';
+		delim =3D '\n';
+		key_delim =3D '\n';
+	}
+}
+
 static struct option builtin_config_options[] =3D {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -760,12 +768,7 @@ int cmd_config(int argc, const char **argv, const char=
 *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
 	handle_config_location(prefix);
-
-	if (end_nul) {
-		term =3D '\0';
-		delim =3D '\n';
-		key_delim =3D '\n';
-	}
+	handle_nul();
=20
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
 		error(_("--get-color and variable type are incoherent"));
--=20
2.45.0


--0fkpa1h8uzDpMaZY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tPQACgkQVbJhu7ck
PpRV2g//X/b/6q+27IIZB/IyzBIEf0+chZaj1IBPVvYirkUGuQ9Mm+YQtz/rfaaM
wJGC1zPxvoH6ce0PLzv1dma0y43xgvf9m9F34iVklIA14K96cyiCq/lyUeALb2Eg
HBIx3/R4YkpCtUoiQdTy/SWBOvxYtWM1mVXzSor3HTUSlBRnPS167KPSDbRnPVoP
C96U8T2mzFJ1Z1Tt5aVrdxFxtgAHqSSw4nRjZrIHzZIS9PSLTRgzpIurFQQdXJ41
dK4SI6YLhE1D++HvwTvHySIhPzonHd8wfX5Oc+Ku8lHoIWL9HXDgbWxr6ANa+vwc
C2f1tVNU+y7fZ91S5QaNdtMhJFClulJE3/TWPH9roR1q2rGQxiIQuDo127bY6D6f
Leo1M7vsOSrvWA1cnrS0i/MaU3gVnFjhi4zclazkiQ+P422Yb83Riwt2csc5Ct8k
JO9M9XgOc8ep3gzgMsmmEmvuHa11HrX6dC3xfeBcdVuTQ8wIGpVwxbg9ixXfg+Vh
RjIT4iobhcf0zSR/bPYYf1H3JgOAQnS9UNWA1LVN5GvAxav62E0mELUm33a/zM+Y
rFR2BsE0Flhe7GVLKAk0vFc7TN0tJsDepFprsasCVja/7uIBlU+Hu9rS94rLb7un
i/JKRr1w8mrSk9HOdBdWC8tFSH4ybrKb5z/Y7CghrsvwR9glWgc=
=j31d
-----END PGP SIGNATURE-----

--0fkpa1h8uzDpMaZY--
