Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011151422C8
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985772; cv=none; b=guzlumiM0HypBV1+ipTThTv8WGu43j0FAgSRKFHLXCL9KN4ktoYir2u22xfWSGO9JemBo2UgcUoEqBtZPuC6ebEmnxWc82XDf2z1ABuTcOaZ1Gf8WDKxePUdr9+EK9P828VzXKxDU4eserkyYYR/ZZH9NEFvbv+j13X0Fqq522c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985772; c=relaxed/simple;
	bh=Ss1VB/uUENm5md1f3EGbXrTdcBpiUElKICUKS/UY3JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8ghnTwUJFBK2BpD5gkWwRqahOuiix1bokf3JTRi7iEKKSZxBND1n2XEaHgQGaPpfzIX/c8CKDPo9PNqtVAxYOjwXdxwWIf9jrWa6Z1Eqbuz4n+UbbxaOujqpIB0+8K3g8n2CgQC1iLhTy6pYaeAA0uzO5/8bv12B6LNixD0fLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RAtoBt2c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EgHGwavR; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RAtoBt2c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EgHGwavR"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 9DE651C0012D;
	Mon,  6 May 2024 04:56:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 May 2024 04:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985769; x=1715072169; bh=gwC+j5Czuy
	0VX22T5SwqguHl2Mx1/wA+6DXwHuM52uw=; b=RAtoBt2c1bZLCxMM+iJgG72Kzl
	ALmzQ+HChL5kVNBsMo4eDBfhmZS7SBHxs8EG0gqJ8Hr9+ke3PqtmJybWJDlw0vRj
	WaPT6QUCQ2BrbzeLkmOaQ/ZnW2Q88aUggboQhoFgA9diqi9+ox9PPSNSjVPz3bWt
	J9kWKLSkx0Vlm8NIsXzFF/RK78ai3C5AodCRt2Fa0zmi0YgcAp7ScTN14suv4OXC
	kcxzpCZT8ChDGdz9k4jxFgfOMmJejc7ETTunsWWIrh9rBrPzNCq3G+8SCaQUgzpn
	4lf/78OwriFiDN0E+8RsMFExFUy1z75MbX1kmJausthsyHw5j+1cUgX01jLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985769; x=1715072169; bh=gwC+j5Czuy0VX22T5SwqguHl2Mx1
	/wA+6DXwHuM52uw=; b=EgHGwavRQvvs9UkVBzdFHg5evrVFZRd6J3Z8CxMhyYQ7
	SnU7WVCclf10WbTKEFuKcehS7eO5kEuBkWy+Caax8/43AJ6luCYzYIvEeVC3t46f
	Wl8xdFv2reEYceDi8DgWnMDFYy9ATF9ctDQKcyuZFjd/P1tI7LXkBcnequ6+SsDf
	XuNIM4qVghBZ9NoG7hNljFDHVz/dRVo0wO2kYqTr+ozAnj3Flo4+60i0sr/Ev3OD
	7G3Qks0xoN3naDcOChxAKNclqvGhJgRyhHb62EG5YW69QjMCFD0ARgbq33ZqPkG4
	0FXJEVFUAkIOpP2T5OKntdn5qNtX7doRxPjChI7mng==
X-ME-Sender: <xms:KZs4ZktiUqPTyof32kLjtUd0g6hnYiqLl_QKgqBqTKeubAEk7BiXGw>
    <xme:KZs4ZhdYfX2JySNVdiX6FKr1K0Qf04JKcX-R0ihBUty0hIFSeP-cBOv0DlBg9sjsk
    -kDPRGOzu2HrBF6Gg>
X-ME-Received: <xmr:KZs4ZvyDFyojD_l7OWO0oDJRXaSPJxCZ62KdkkF_8npTzPX4N7OOuRXfpP3LKQOQcfkBSCXLH80JR2i5Wt_3qCkXTA_wv4-mPoYdDHbTNF6Tfq7n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:KZs4ZnMGy4WXW17OBUxt777SpmuNTN4q14oSdCehMNsI_1crTSiSBg>
    <xmx:KZs4Zk_VhEdA8rZGLladvJ4FIncDRNphnXWqpP7A9jd-JdIs5-Wyww>
    <xmx:KZs4ZvVo7nL1LxIIrsTQZ-AbU8pWPqikR3q62ZRqiH7hKecEeq1jdA>
    <xmx:KZs4ZtdfSMxBdXVzEJ9f7WfMQEMdgezAtcdRx4-gc2pTKl78TA21Vg>
    <xmx:KZs4ZoRj32RGZ-DGLqYAsLuyucE_lac0astNZsp9WdNeApvVES5yZNW_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:56:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b3e24957 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:56:02 +0000 (UTC)
Date: Mon, 6 May 2024 10:56:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 03/14] builtin/config: move "fixed-value" option to
 correct group
Message-ID: <36abda0e02016eac027f4fb59cd912f2c5b60e05.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hq7sTmriKEk5FQpI"
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>


--Hq7sTmriKEk5FQpI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--fixed-value` option can be used to alter how the value-pattern
parameter is interpreted for the various actions of git-config(1). But
while it is an option, it is currently listed as part of the actions
group, which is wrong.

Move the option to the "Other" group, which hosts the various options
known to git-config(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 59ae5996eb..054019b70c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -643,7 +643,6 @@ static struct option builtin_config_options[] =3D {
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
@@ -663,6 +662,7 @@ static struct option builtin_config_options[] =3D {
 	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
 	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable co=
mment string (# will be prepended as needed)")),
+	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
 	OPT_END(),
 };
=20
--=20
2.45.0


--Hq7sTmriKEk5FQpI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4myQACgkQVbJhu7ck
PpSREg//dtiRDI8Gj9JjCjAiMW5awPLoE8F3uViU4X9g93MTViN99GB11pSXwCIM
l/wKU43CYItU9PDKuVbr8WnUXc3/05hSrXAU8CelevbgMLszOZbGLXasU1rzaVAr
3HDANalN2LggB6RuHvFxp0NeMiwqnea9DcBoYzF5jciylCms/ivMRNp4g3FVFtSJ
grGhhgAh+vGPhAjyHWyt82gw8X0bcOOhiE54rk0ypoT6NDvjF7BIbQUfAROqKCdt
FEuYwmgL0W7yfPYfjN6OHDY6PXSZpVQV7T/4UG44hmDyo35jIUaNd/4fChUIG0Q7
n9okuLsBRmJX+xUK0fVBKR5NID0Of3BVCj2J7ZxbIxWJYERyBpfycHhixbJww+NX
RIWYNNF1zPfKK71vyHwW29nzrg9w76GlBYwfQiN1l0fYhfJq2X1YErPxFxbLzCm/
/KPjocwxNRqBFIZLahXDE0HjPKJVElyViicH3N0RY5mhYVyrW5cb7nUT3nwrILa6
Vh9ohogTzGJSR8Wztc4SuwZzn7b5m8HGKNZV19PtDAkmconZiXANqNq6KxeQ2nW5
2W8pkRcGU2Hw+stvptM19ttoF7quOCEzUPrXQSN6wFbjY4BHPlocFXg5haX9xNZM
3Be550QyAomuasYM9kgeILoXbfSCB9cIAgZ2Vwj8r6cZTBuWyZI=
=/Cz3
-----END PGP SIGNATURE-----

--Hq7sTmriKEk5FQpI--
