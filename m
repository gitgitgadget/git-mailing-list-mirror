Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A8364AC
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529188; cv=none; b=NyWOd4IP76KyiBQggzpfp0oPTEnphBzg+KaDVkJa+u/NVo7RISxyzNg7nlaaL7BY6QOXTXDzcZRjGqka2ZBn9AUuwqLuEg02yncqmr/9CzI7jS/to6zDvOadcZx2ifSGceV2/XlE4bHNeAED3AxRZZLceWLkrJAXRHOSME7S+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529188; c=relaxed/simple;
	bh=bQ3VDhldcKiE5scyIFs2vKzLMUfb8yOTjYZaKyzh9J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx5G9CTfCOo0+AuJVSMACgN0hrh11LoDIR9cWfPvYsqCAv6l4+Pb1e2VPr4/DvshwouS1gYjcqJca+LQncgXH1w/zIn4xROM/83NgQY/G9Z7JBOuhkow0vpp+4vup/0RgFktMNQPHGWResy5ezO7Mnpd4N6cWK2Jay//jGGwf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OocniTLm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pSGg4BUy; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OocniTLm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pSGg4BUy"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7F2BA11400CE;
	Wed, 27 Mar 2024 04:46:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Mar 2024 04:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529185; x=1711615585; bh=sAm3/vWkR4
	LQpQhBEHnpuznP7FrbTC9ZZeGJHD4lOUM=; b=OocniTLmfeel8ZZg4wynj0uPxV
	vE7xeO1PUlPMdWHnXJreauuJ0ZSD7GoanwcnnExV5Q/R+y9urz9LnRBt/l94hnl5
	F536axJko11RzSBxPq5Fb1sy6gdwr1urfbeVO4ZjurXx0YmN+cJVTU9DSetZ8sDs
	HNUKZYJcV4HAhmPpjSpNMPdzve8RgymdJjbabOKOBZv5is1Z8QnhJCjvL9MXpPoL
	zqlMFZh9kScvPZIgRHciwB3sdog3NXQdSR/PQBnFzqytv1j0116K2+N+TFLIMSPn
	evHE4iLrVJujhauYPEfGqM76iK3co1Og/19dHNiBAvHiC0Y/vt4lphIFxHGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529185; x=1711615585; bh=sAm3/vWkR4LQpQhBEHnpuznP7Frb
	TC9ZZeGJHD4lOUM=; b=pSGg4BUyts19O8aMKOFHeemp6J+ls5FUwgVmj0o0bk0+
	BUmjnaZh+L2O0A673WhqGZeAtMIet5f0h/v/KIRmK/Ij/Ablax61XjNqokUaPCKB
	S17gz2kYtR5B6hv28Pd7PRM/LWmBGjWCgacJQPRBlFopjhLxMO952TD7RAcMWEnl
	J6LX1kfeKd2Ju09wd6tkROx3OOga+9PrEBQ9TirSyOzzC2zBlNgGkHia54mWIcRm
	gYFsFT/cTsMWlDGCHc8dvsqbwhtqNgDo31CDPJrTT9jA8idjP9Y+DzpevW3q4zB+
	I6S9VwYPSwL6ZJlkPGGCYIiFf+KAC1Dyw59O1Iz1sw==
X-ME-Sender: <xms:4dwDZmoRh9lkH36MQbIFSDhUiRCJ1FPgypUSlzjCo4XkjNL3dFL00A>
    <xme:4dwDZkrC1TkDJ7iJoZG6lceLM5oRfmvqVJcsuw8FEpYDk1uq3WXu66MN1uwd6m0n2
    9vySP9zrjSByRK68w>
X-ME-Received: <xmr:4dwDZrONKuxQe7xTRFxBckQsfd06rVTQPbTR9A-FIw7F8mW1UACywMKbOoRusklzBKVZ9__bUy5Lh8NJElWkm2OR98lXFxt7vuaQ3_EKStdrHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:4dwDZl6TVOmjpStJDtEDR3PJO8Z6AbXJi4zR9PuBvvHizxjMZ9h0xA>
    <xmx:4dwDZl73VPBBQuQHGl_Iu0LrwLT1lYgzWmv8gp8wecURpSnCyJTv-Q>
    <xmx:4dwDZlhj-rnLhhzacU8r1k_ZqvT2spoxXrEbivPnIlelGOxTZ-42Hw>
    <xmx:4dwDZv7tmnz7ImO6CvDSp-yojKXlohXDiQSHEofJ3s-qng5ztqBbOA>
    <xmx:4dwDZgZzvBb_xeHJI3nAB8ZeXyK8kjy_F7dBM7CBrg-M9PJgbCJW8g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:46:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc988da0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:46:10 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:46:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/13] builtin/config: use `OPT_CMDMODE()` to specify modes
Message-ID: <e049c05713482b74b80c63ac1326cac81b2c347d.1711527812.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="urWoORzzLNBTB68b"
Content-Disposition: inline
In-Reply-To: <cover.1711527811.git.ps@pks.im>


--urWoORzzLNBTB68b
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

While at it, format optional placeholders for arguments to conform to
our style guidelines by using `[<placeholder>]`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c  | 32 ++++++++++++++------------------
 t/t1300-config.sh | 13 +++++++++++++
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index fcd6190f12..a293161be4 100644
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
+	OPT_CMDMODE(0, "get", &actions, N_("get value: name [<value-pattern>]"), =
ACTION_GET),
+	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [<value-patte=
rn>]"), ACTION_GET_ALL),
+	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: name-re=
gex [<value-pattern>]"), ACTION_GET_REGEXP),
+	OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for the U=
RL: section[.var] URL"), ACTION_GET_URLMATCH),
+	OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching variable=
s: name value [<value-pattern>]"), ACTION_REPLACE_ALL),
+	OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"), ACT=
ION_ADD),
+	OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [<value-pat=
tern>]"), ACTION_UNSET),
+	OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [<valu=
e-pattern>]"), ACTION_UNSET_ALL),
+	OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-name n=
ew-name"), ACTION_RENAME_SECTION),
+	OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name"), =
ACTION_REMOVE_SECTION),
+	OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
+	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
+	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slot=
 [<default>]"), ACTION_GET_COLOR),
+	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: slo=
t [<stdout-is-tty>]"), ACTION_GET_COLORBOOL),
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
2.44.GIT


--urWoORzzLNBTB68b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3N0ACgkQVbJhu7ck
PpReZQ/8DDinHn/fDBp2v9m8Fth+X4jdmv9XKDgXO0CXiMZxgogL6Mb2ZZsUDahs
rHKrND2H2GpySNM25v4sGVF4mKGaz2j4MQodyxNShtJkFBlH1rSWkyjQYODdpc8a
dNmCg2O3ioX8Nno6pf1jk22UifSG4WZGMmpehOzCVSjSRZRRg9/hDDdT+79NR2Ye
rbVgStotPz7lX/QnG8t/wWQbDr8B+1yNbSmMbPAOqoBrYETwvM3QNZ8GOVdqIWI+
D7Ocq1vGQ7AjHpoxs9logwxyfD/oMC0lpkqXfKJRspT1qtB3pfII5/JiYFQGDJP7
bL2JJXFtnkfjFBfmGOi9cjcxO2DjVOJTMRixImAe8DSJtCzyDqVuRD6TnUcPm+wD
SWwRqHJfWo0WmsfZa8Ef7e2o46UyXVrxMChHCDm15qThb8rIbr0kw3QrP3jS9iOE
yU+gu9n5Eb9h5xbKEmxPuVOJTlf2xdG2KHtu16tcBW5x61FglV4Sv5MWQDiroiiU
ptW0/X1b+2iviPX/0pioH75XEv03DkPP5gFJEdpuUtqLNTdOSdEzvKN7pHop/Gnw
Rv0k9a6xs/h8uX+QG5M78M3Mj6a+Jwx4a/6Ahb/euv5ogwRiKSBZ9MTz4glWh4TK
nfJjA2OGN5g220jtubXZDADHmp+pMLnMJHCO3IIbUBPxRr2BivA=
=mzmg
-----END PGP SIGNATURE-----

--urWoORzzLNBTB68b--
