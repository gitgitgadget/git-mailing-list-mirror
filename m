Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30107FBA5
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724707; cv=none; b=prdox6wNjkVHg2pf4T6sFJBfGDZrKRwqQbt5quxB42WVOD3G4UTFF/2u8yHULmasTF5HuMUBSm/XPYlBaP/CNe27un7HQAg0MtqVGmbqstDfHhNJ92xcVu2fVhcmyUOy2oiyWnxrEqZGdKF23+DBLPDkZx+tpVOCp7lm6agtVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724707; c=relaxed/simple;
	bh=+tyrTuqhu4N6kOmtI9lBR4/ozeIqvIk3L2/PzIdSFMQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMSVLMQp5iL5hj0CkfzToMg1dBQak+/EFPRcEAB2KcTJmrSmD+Trec2oC72uicVqGryQqcHdyMqRWY8WYcIWk7QdOT7cYl59WAONjZu9x+8n+Rm+cafL/9v/HIsMmE8I6QdRgUjsF0qhhBHzcOFYV9XNs1habZOIB8iQBuOis8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XjFQrm8t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SB4fbh2G; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XjFQrm8t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SB4fbh2G"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F406711400D9
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 06:31:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 06 Mar 2024 06:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709724704; x=1709811104; bh=0JDoXiHCXt
	blsTQzRV+ve3MyFZ69lw/k5MmilvQ7F6w=; b=XjFQrm8t6J8pTZi8w+GEeeokIr
	pvY5OkFOgK5W6T9+fAdrdTmDtH/TaGuct/kv3Knj/HJ5NQVguWt+9JUWHPY2U9vG
	+XNhXQoN5HvhlH3lEIcNxpsa8Ii209vQKrVFkvrbGev2xDLNS38fVFnYzeozCtCP
	BWeL7s8dBhudn99U79d9HlvlzpzJ5qdtbMtJskPZhoY2JBu78toWDIK62a6cQRwU
	21wWv5wZBGNip6ngz0cBbDxGr7ZemZzXGyoYTohLlrKfxSTsadDIC721kmF1b8tB
	rmUpvO6upKhHm09+i84IncQ3oJKbPUGOJNi/5vIukEnDy714UHiMtG16c+Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709724704; x=1709811104; bh=0JDoXiHCXtblsTQzRV+ve3MyFZ69
	lw/k5MmilvQ7F6w=; b=SB4fbh2Gk287wCfcQDkggxQeH+TplFu/Jj33JqINJ/6f
	01moel5ngrXtUz3B5D/ospJ/yZjetTkpDt+uAS6BusbXBe7HSf87i1/KhteS24mQ
	bnyO7pP4OnnPNQ3wGgY1gpQry6uatTXMXNisTJWsKT74/ryX8HO44/xV22rfCsrC
	BgbeK1VHuyisoIvfWzsF+eYfCOdfrYtzHaYR+V6aVS7b1XaDBkQrVKE4o+/A31cU
	jMHUJGiqD4G8ML+G4XoL3HsN/EtckoutIBJ1LywJMRETN9n2374kc1VBMhfjZ0Kj
	XyoPhk1Qf8xPslAMZlkjc9lDPM94Su+VzM8xNNHioA==
X-ME-Sender: <xms:IFToZZiOH6g_nt8R1BuyFXqlHoFq18yf8GzG8YTBTALHBl18oty-sQ>
    <xme:IFToZeBionsPTnFOrvaq0cTvxXnhkZaOonCIAZKzX25QxhVJeFNiQYLK3qe_7pkj6
    SbazP5rv61MlkD-Yw>
X-ME-Received: <xmr:IFToZZGx2eaOJaCyw8KuIW79iWB_47gFyp_0gv8Hk_7VbMGuP1CZzKqFr8JQaNSGpar--zNkAzLrz7C8yq0rUxfYbVeMjYh7erxh90p6F69LmoWUqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:IFToZeRMyJSqP4F6By5W0O3N23EOBg-mWP6p9Caz1DQJ7rNE0RJ8Bg>
    <xmx:IFToZWxZ0STU04rEAOvK7yU5ZQ9bsZ3RBQhy5wRUQeoC-KqiB13Z2Q>
    <xmx:IFToZU638Fv7AZHkJD1Cezrm7MC9fOzrRXdk04ZhuMmuH6vgxnBTHw>
    <xmx:IFToZbqQ3mmnv2Cl0uhlgOSIhGcRsHx1y6AZcvJVdqkK0YqxlPdiGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Mar 2024 06:31:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 614662ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Mar 2024 11:27:15 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:31:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/8] builtin/config: use `OPT_CMDMODE()` to specify modes
Message-ID: <41e5bf1d6aa35a32f961b7f9d82a70781674eed0.1709724089.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jX41lGyG32WkdMr4"
Content-Disposition: inline
In-Reply-To: <cover.1709724089.git.ps@pks.im>


--jX41lGyG32WkdMr4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-config(1) command has various different modes which are
accessible via e.g. `--get-urlmatch` or `--unset-all`. These modes are
declared with `OPT_BIT()`, which causes two minor issues:

  - The respective modes also have a negated form `--no-get-urlmatch`,
    which is unintended.

  - We have to manually handle exclusiveness of the modes.

Switch these options to instead use `OPT_CMDMODE()`, which is made
exactly for this usecase. Remove the now-unneeded check that only a
single mode is given, which is now handled by the parse-options
interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c  | 32 ++++++++++++++------------------
 t/t1300-config.sh | 13 +++++++++++++
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index fcd6190f12..8a2d1a5de7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -631,20 +631,20 @@ static struct option builtin_config_options[] =3D {
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object")),
 	OPT_GROUP(N_("Action")),
-	OPT_BIT(0, "get", &actions, N_("get value: name [value-pattern]"), ACTION=
_GET),
-	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-pattern]")=
, ACTION_GET_ALL),
-	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex =
[value-pattern]"), ACTION_GET_REGEXP),
-	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: =
section[.var] URL"), ACTION_GET_URLMATCH),
-	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: n=
ame value [value-pattern]"), ACTION_REPLACE_ALL),
-	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_=
ADD),
-	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-pattern]=
"), ACTION_UNSET),
-	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-pat=
tern]"), ACTION_UNSET_ALL),
-	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-n=
ame"), ACTION_RENAME_SECTION),
-	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTI=
ON_REMOVE_SECTION),
-	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
-	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
-	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [de=
fault]"), ACTION_GET_COLOR),
-	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [s=
tdout-is-tty]"), ACTION_GET_COLORBOOL),
+	OPT_CMDMODE(0, "get", &actions, N_("get value: name [value-pattern]"), AC=
TION_GET),
+	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [value-patter=
n]"), ACTION_GET_ALL),
+	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: name-re=
gex [value-pattern]"), ACTION_GET_REGEXP),
+	OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for the U=
RL: section[.var] URL"), ACTION_GET_URLMATCH),
+	OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching variable=
s: name value [value-pattern]"), ACTION_REPLACE_ALL),
+	OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"), ACT=
ION_ADD),
+	OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [value-patt=
ern]"), ACTION_UNSET),
+	OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [value=
-pattern]"), ACTION_UNSET_ALL),
+	OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-name n=
ew-name"), ACTION_RENAME_SECTION),
+	OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name"), =
ACTION_REMOVE_SECTION),
+	OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
+	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
+	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slot=
 [default]"), ACTION_GET_COLOR),
+	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: slo=
t [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
 	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type),
 	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL),
@@ -767,10 +767,6 @@ int cmd_config(int argc, const char **argv, const char=
 *prefix)
 		usage_builtin_config();
 	}
=20
-	if (HAS_MULTI_BITS(actions)) {
-		error(_("only one action at a time"));
-		usage_builtin_config();
-	}
 	if (actions =3D=3D 0)
 		switch (argc) {
 		case 1: actions =3D ACTION_GET; break;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 31c3878687..2d1bc1e27e 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2612,4 +2612,17 @@ test_expect_success 'includeIf.hasconfig:remote.*.ur=
l forbids remote url in such
 	grep "fatal: remote URLs cannot be configured in file directly or indirec=
tly included by includeIf.hasconfig:remote.*.url" err
 '
=20
+test_expect_success 'negated mode causes failure' '
+	test_must_fail git config --no-get 2>err &&
+	grep "unknown option \`no-get${SQ}" err
+'
+
+test_expect_success 'specifying multiple modes causes failure' '
+	cat >expect <<-EOF &&
+	error: options ${SQ}--get-all${SQ} and ${SQ}--get${SQ} cannot be used tog=
ether
+	EOF
+	test_must_fail git config --get --get-all 2>err &&
+	test_cmp expect err
+'
+
 test_done
--=20
2.44.0


--jX41lGyG32WkdMr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoVB0ACgkQVbJhu7ck
PpQwCQ/6A1tkOrBHQs3meA/Tlc64bLhJTBVpURdLGeoT7PacS0gNqwiqCHuaLOfx
9nM2pKGZtqw/lk3PgR9Klcqcl/bgCUGYIKxMC9/L2lTUYowGsPHm8/tmJ7OCG7em
15EJtB9BPL8+0BKdWedsq8yABntwuRooyPGnOpVzEoFH3GUamsclH2k2yStyfSkG
2GR6BRn8I4NpKHh3GC6vK0kd/uL1Eoq0ur9+g+F0p66V9GpwR1C0HqOeoFe+qpNx
NBUBw4eVAptrfV0HHw0Ae7bzmCjgtpIvLbW7R5cHZfxt2MLlNymHH/EnDLgR7pmz
wC/S31XVg2DTxdojWqFcrIHAlNdDYCufx/8T1t9sgFHAwWNmj49I/2IAQF71gXPO
cpim5VZDZ9Q45IiJZ303ts/4tpR1NyR5erQZX/GTU7UiKJEMQBrMN290O8k/Fn7u
G4NBdFHxTn/noahSOy3to7ZEvGDJicMIPppN06xIKT0znZiPsoX4cPMie9B0mX9s
t+AbKWBaQIAnh/lW2mMwbkuSc15Kj4W+9qVfUc6yCntnavHfJU6JqL/egWJifRDn
0FTKUkmj760reV7E6qinyfNXp3cfP22B22DnusFrk/0spQWSsNORl/E7EamUDdN4
OKPotcaq3jaOo5NNA40nI7v6MJEYpo+8kxq3L21XB448racNDiQ=
=6au4
-----END PGP SIGNATURE-----

--jX41lGyG32WkdMr4--
