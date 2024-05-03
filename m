Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763114F9D4
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730221; cv=none; b=fSXT1kDR06bS8uoehVy1HQVxriocZs8ItTHiHNzQ6Z0VSlpRVStiavF6pu029eoZ5/WHh7JH5pCFIq7i1ADQNiprOT/1/bTS6OrZYuopM3DYaZVQy7k8DuOvHVKn7SMjONbKMQHW56Txu6z32HEfd1V4OHDtYruolc+fcqcwlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730221; c=relaxed/simple;
	bh=3VF3B5+NxibywnMZl6zbr9tCN6MrYF6m36hfY7/PCM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKOzeETXgRGK+aw23Qegrjpy8FOAbbsC5CZWjIixI3Cu4fXt0oyaeOOUM/QT0VI9tIDJ3+yijzkv9KWToq0ePG5oD5oFS8ut4aM0gLlyC+18BIiLiTBQJMgylcW2IjNdKqxiwJovwqxgY5ki1pfXqJ0TuSZWTX2fT9YPtb2VoDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mqEu8+ct; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OhCrdtM4; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mqEu8+ct";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OhCrdtM4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2574B180007F;
	Fri,  3 May 2024 05:56:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 03 May 2024 05:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730218; x=1714816618; bh=4TXdXIuu/J
	OBruw3/VaPAWBorp5L5GS7sh6+ZNfHvsM=; b=mqEu8+ctBMdUINF6aN3LbMPzoT
	X69h537E4SsEXrx+yiZBrhMTt5Dhn1uORzmrXVc5I9+9Y1l0fruCwU6hOngC3Hm7
	yaEEXZOBYAP+a8bL/N2CWxwYGwjeJXmvfP3qHmbq3jfwSyog5JUaSgBMmcPU1iAw
	oBNL9X3QSfWcCoxciWdnq9WKu/NoKFdys+imwFHvR59AkO4ZctHJK2AJd5XoCDxP
	xM+T/8k4awxMQlcBzofKedvooSIjizQyZ4LE1zBlet0PxS2T0SeJtNyPRXQK2D8z
	63K35+VCXB6V0p/2BJojDNN/1MI/TjuC8MO+sS/jNs5faJxpHXLrt2+eRyjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730218; x=1714816618; bh=4TXdXIuu/JOBruw3/VaPAWBorp5L
	5GS7sh6+ZNfHvsM=; b=OhCrdtM4sOBAuE5vl5vInDdgsfIi5xOJH2IpXlCPyC65
	WQ2fPLjVr9tWWPqr0QQ8pklKSY7UyhGgCSOd+ME1M6gspKHcTjCwv1H/vK+aB72r
	a8vCcPpUyhbtnp2WdFIsLW5SYwQUkmmBs/Hk7wjPeRC0ot8rv53S3jR58fteOqvJ
	uBw6NDORHpmu+IBD0a2UDN30L2r68oNJR8oeksg5X1nh/uYv+IDW0v6oRwOX7wY1
	bk9LBLsaCv7V1gYYtEFwwKoUrLupKX5hqXr0YD5ObxmlEm9ODMZl09bJXsYKz+M4
	duFu2JSmiF010otvugr647C+f6dV9aCMeUHhbNf/kA==
X-ME-Sender: <xms:6rQ0ZkruwyAkEwoGwBp_BUippH1Z1sOIZRTecdZIjZtHiAUlT3yupw>
    <xme:6rQ0ZqoNsRtHHzz4jkplz-5nwp0iZZ776OaKQVqbv31tm4HJz8sf7VquJvOR-B5Fu
    1PRj5HHj-l7KK_q8g>
X-ME-Received: <xmr:6rQ0ZpPlwdh2Fc2r0pvAkvR4_bI11Egwilk1rJdEfa7IYHV1l-Om_D1v5fVqSGPBn-Ds9TBKnHXJsLsde-Zrb5STIVQSfivdMO8LWaA5xvxMpF_q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:6rQ0Zr49OOEs_hXluGslJLXbaawcJ96pUiZ1hIWjUaIIROD7iJScUg>
    <xmx:6rQ0Zj7C1leflpa8OB1FbTyXWISHqrDeamrcdYrVc1BeJS_4FPqnqg>
    <xmx:6rQ0ZrgEA6-18vrTN1puvc3ydHefUgl9tdG26oR-ETGe5RwQhJTUIQ>
    <xmx:6rQ0Zt7jw5aI2LHz3q8urUibD5TkMyp1pL3gp889sR3sngthWLY3xw>
    <xmx:6rQ0Zgt6kT6sew0bAa-1R_W9mEgENnTHdHpkSYIU9YgyqSn3M9P2JrC1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:56:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ade386b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:56:29 +0000 (UTC)
Date: Fri, 3 May 2024 11:56:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 03/14] builtin/config: move "fixed-value" option to
 correct group
Message-ID: <ddcd8031d7e399b126344d82d3373a2b2ed7fb8f.1714730169.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l7QWwQrfelhUOQ4j"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--l7QWwQrfelhUOQ4j
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


--l7QWwQrfelhUOQ4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tOYACgkQVbJhu7ck
PpR0mw/9HLq/jLnnw6cS0fY8vr36pZ32dBlPDmj56E13uafQXo+UUOWoXgcEdbxA
HGKn3yQop+2AwpYfyw4c37e57f3b8SxwBo4jEGeXaHtT/125SeN5nyJFy/i6/aMa
k81EgSmV0PP+E0q3QhzIik0I4Y1LGkpC9UEvC25dXCvxUbhENtbNba6rB/5PU/rV
+gMlUigBabOv38stjhQzhacsdFbrhRJTWo09sk/UjdR2fE8jbsNVEI+PrCz5mpkr
/vGem/eEekXNeDFwN9WzfD0jqG76iJIGTb1bWnce5PtmITa3CkPFffCFepZ+idWS
aX+PnxHE0I/mVz+Wu0/j7DntM9QjwlK6uVh6Oth+fu7hTXEmDlo/Gt9aZoGUm24g
9pgd1/ubrILa5CLYYTCynPgCOgntSwBmOgItbWo87S56lY+j1ek8O7NAoQruWifm
AkmLJeVmUx12QqJXMrhDemg95kLgkJArDgiT7eNKXVAMFQ7eiId59qHlrcw07hSx
u0nEhiR5X/5R6nvNbqZDRAiqd2MkL7vc+CUfvX0T0xcydjVwgz8Kx6OZn9eikk3n
AjZr04f9v8Hd1H0XVFg8c010hkFGYcS+QjFdyEeP1Vr1d1W7lHLvzdUjAfQ8Wfiw
fT5rIlbnQhcTV6wF+q8RIDyVphd93eBmUR3Ep9gpjiPOrSbScok=
=2Wmi
-----END PGP SIGNATURE-----

--l7QWwQrfelhUOQ4j--
