Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260D36AF2
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529183; cv=none; b=a2WgM4MbaK40lteiXpu0OW0m55IVxTATlPZ8+wzsfHTYAQxr2O9YnANyFbh3Tz6KKRibT33JHiNFJ920fcDf0/al0BLq4H4HCHvME4SrFHSZ1v3WvwkfI2Yblui+qnPOB8REyg4BoKUQPjfOMtVFQCAaerAH/jjMeSKi0XM+XCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529183; c=relaxed/simple;
	bh=/rLmN3QTBnLEvYSi2snJW9OwpBF5jH9k+YW3/JrgSDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQ+9qKoTDkd1vfoH45Gy3QYize/Oy6HQASgdoj4nxGVZAzojt1SY4Y7ozIPDDTc3l+K3OAKOzYlyGXed4L8lui42Nqu3KYYeL4av9oaJ/fUgPueY1gnFH7nUUSjsYY9jN8RnTv+nvDhIV+idW6wCGOxqynbjmYOcEntGOV99XV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DIyc914N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wpURbxTJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DIyc914N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wpURbxTJ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id D6715138015D;
	Wed, 27 Mar 2024 04:46:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 04:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529180; x=1711615580; bh=VTT50xVHGw
	/CuyLD27jjlSMxuLO3OB4s+fDOaHqTI2Y=; b=DIyc914NpKdoNHnUODfC9j/dLS
	SH524ZFO8iWoQ7ZBM1upVzIk/+ErOKQvD+niqcnXgJNzML5N8zugLFc9gsdY7BgY
	mdrY48tKTymsAG5LcHdK7fi7xmHxRKGRMN38blgOpPduM0e60fXAs356HRN6vDoN
	D05N57gc5e/Pq53UAetrcfC5ZOSxHiOME6wrMvcQ4t54y65Jd012BkoRhMqGWCBs
	LLzwUkfaiLi/O4sdklatGy4DAtl6Ivn/zXXU8gP57k2g7a9LdxRant7/zdny+WIv
	y8CV1e6iyQhVMT0KxnxjcEYc2zqI0mCtx5h/zjNFYX0n5HayG6imwy9c247Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529180; x=1711615580; bh=VTT50xVHGw/CuyLD27jjlSMxuLO3
	OB4s+fDOaHqTI2Y=; b=wpURbxTJ5FNRX5XTwaqYEMPz1Y1TvilRwnWZhMPSS0Iz
	W0LiSoA27z0dlMvCvaLmmHY0jYwkN4BJHJBGb8igUqnRh0m6XPih5S9ftUOPwkFJ
	u3Oph3mFtiRno3tYuGPf+Dnf5UjQKFQ5UYqkJY6WssOCVt3tAgSyywYrTqxbLdUh
	67TEaaBMWkg7AV9ztccS6wVwmIXWDug6M7EDl586tHlI4RWE+hWCiRTf6AzM7i5/
	AK8phS5Mu2V+75khWZHL40gkdR+BvpPJa1YQQTCgbRfmFNEAm/rnywtDalZzqZwk
	yQgPOzptjjQzWon7+Rk1gJfeNKNkdO5xNPwBHd8lGQ==
X-ME-Sender: <xms:3NwDZov6eFMshqD9u5U8rhVwdY7SrU2bWSDaWbAh3To_P9MQm8rP8A>
    <xme:3NwDZlertQUzYHQbPmeU-lsqJIAVI81ZllIYJxRbclnh3Zzmj9lilQcr66kbleADO
    Kw8-wqvKDRiqbTLWA>
X-ME-Received: <xmr:3NwDZjx23gNOyN8JBwsgoDrtub1WfibkP6lbYNVXTU0tlYFNRnyNqQQAoPfSZPHJoskDdClnQO8FCc2xRs6EbtPJkR7_KwNTVGWpNhTvINzSxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:3NwDZrOrJdCcFgFOuVh2N0DlZdTVrbl51gkPZ4Dq8KcTIoX1KzMaIQ>
    <xmx:3NwDZo-xlDcNAJP_AJgTYZq5w86Xofzdxp7mnQs0zpdCiYI9LmBzpQ>
    <xmx:3NwDZjWwkHRqPcT0UEf2ai7zCktpnqkZRopWVN0SrMX0e-ZhFjNGgQ>
    <xmx:3NwDZhc2ZHn1_jTKpqM5PVYiSJgqCJ3T0tVQitaFz-YcxXcmynTinA>
    <xmx:3NwDZlO5TBReyhL6ENCgfVB1oQBE4Xhf__GXwSeNNYrEObhQtnliKg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:46:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1362d847 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:46:06 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:46:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/13] builtin/config: move "fixed-value" option to
 correct group
Message-ID: <ff428d8a2224505cc5b18afb4aaef8bf697da9d8.1711527812.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fjl4W32sSeaSZIYv"
Content-Disposition: inline
In-Reply-To: <cover.1711527811.git.ps@pks.im>


--fjl4W32sSeaSZIYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--fixed-value` option can be used to alter how the value-pattern
parameter is interpreted for the various submodes of git-config(1). But
while it is an option, it is currently listed as part of the submodes
group the command, which is wrong.

Move the option to the "Other" group, which hosts the various options
known to git-config(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 6eb6aff917..fcd6190f12 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -642,7 +642,6 @@ static struct option builtin_config_options[] =3D {
 	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-n=
ame"), ACTION_RENAME_SECTION),
 	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTI=
ON_REMOVE_SECTION),
 	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
-	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
 	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [de=
fault]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [s=
tdout-is-tty]"), ACTION_GET_COLORBOOL),
@@ -661,6 +660,7 @@ static struct option builtin_config_options[] =3D {
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")),
 	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
+	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
 	OPT_END(),
 };
=20
--=20
2.44.GIT


--fjl4W32sSeaSZIYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3NkACgkQVbJhu7ck
PpQ3Jg/7Bwoexwgs3ANvGhT0ZZCi3j3tCrmLHtAeFjm13X5yH1FflOpcgZhuW62p
4UBGGudRl7tvhyQnnxuKtDGdOzBNE8+Wz/O6A+VdnQHG4D5UIuCGkQDbH6XtBv+x
3GQo+H1ebycZ/gRvFvKexmo0Zmud7GNaIIEk+a8TEk769bMEl6KVAX0cfS14s4cR
P1Bm6fhVl3QDsMxi3ZQ8TnMvHdtlDd0eUc5L2/PbBb22bdS/NUa1lrXusshSHp2m
rZLJsih41VWdP/lCUbpKQO3pKcxODDjBDgYuHr5FyLiCQoU9E3BnB0yWjCm+gNne
bCoT5kTW/9hyg0BQNBt1/0U99e14J/xBS9YK2O+JaTbuT2qmBpLGQAfnWLhDBb9g
h1ulcJ342clZRiCUeQbArTxezfV7JtEU0ilrBFu8ruKPPKbXDsyX9/RPzm67GNUN
qhEJElnQUYsJmS+XYgh1BImYvi0jT7WkxuOhlZoR5NEg9JXL1uZ0oOFiroxlcTDe
rCv/5wsgbCJv+c6giI7mJd8UUPOgHIimSi3qfHAwj1lAB3oRmLZHGlWMa39Mf5Vd
VAVJ+Cl3x0/S9MeItWzzdLwdQ1ySs2oKr53ql8Wc8UVrwNEdZuBOSO9tR2AuFYAx
Go9xKRbaMzgN5AhGTEFBVnhGYVpLJ6JuW7e+iWKkpFQNOuzwGE8=
=19JJ
-----END PGP SIGNATURE-----

--fjl4W32sSeaSZIYv--
