Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89C14F9D4
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730227; cv=none; b=L89RlpwqAYXpp8k6yWc40lJuvO9C5eRd86hRFib8tNlF36Kc1qSgh/W7y/peMOrdC0oXZLZd1R29JHV55rU1+OLrzNLlIJTwXOdgNnkQO/y4zTlTVCV9KOVknHKIOYxmlkCqT4zsOnHElz3FeJltC6pWT/EwCYc2q7pxXciYksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730227; c=relaxed/simple;
	bh=z2FW5MjCjqXtzrM3pRuDDGG9CGaOx73RJ9AkTwtGuBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwCosT4A1DbKiPkDkJ33Xk4WWIL75UkFyJPC1prEMiIDolEvV2E8A4xKtb8vIoyxw3zzv3b9y25tUj/DfXL2XqsoM3HaT1xUSJX8CcuWiqdPIljQ9AClr9vCf+sWwUdQ3mNT01vlVAS2VnQTOJRXE/163gceK7zDyS1naumeHa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MxnXvqRk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cMIFcuwS; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MxnXvqRk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cMIFcuwS"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 997401800137;
	Fri,  3 May 2024 05:57:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 03 May 2024 05:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730224; x=1714816624; bh=Q0yr31PVVG
	s7dF3BUhRWTaRJuQTKyGETlB88is82/a8=; b=MxnXvqRkgnmKk8kHRY1Nr5+5jZ
	2gVLOGyuqB/RB+U30C7aRtLGd3vw7mPvA75W0ydCDwHt+gHSMJeIYZYUdS/CA7la
	FphIMdMVuP1okzu0WB9yIPlTmZbZmBC0GNNUzYnZRLUQvkCyRDuJQB/9JCSxANpl
	rdxZlaExTXnj2lh1Wuas5aZ493ybfQL1Okf+k6T9cKC69Tr9Tzu7ekbF506R0QlX
	93Ut58pJA/ou7fh8qt13nkG8tf5eSfqNKAI2y14EfawLMWbSkbz+ElgZ2pCwImAm
	6BD/sJxxSbPvOKOsVaie32Sbzq6zbhn6GJqOGNko9wJfHK4r+7/qJeVccuvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730224; x=1714816624; bh=Q0yr31PVVGs7dF3BUhRWTaRJuQTK
	yGETlB88is82/a8=; b=cMIFcuwSpsbYE2ha8yh1RFr7I6Ims9zdD04mBlzUqY+8
	XAXy4FYOQuqMG/tVpQnGMP6VNYVoblNvBKSiJ+gCLlBppOa3sdZWLN6KA/dqiBS/
	JgZPeNyWKAGoIBUguWNQMALcIc3yZelols+eQHDbkhElsED0RD1oqEI2AVKfkw5E
	W8Cm3MetmdkVnRT18E4U6xIUTtcXjoI0LDEpgi80A+30RC0ngqy02MaaafXDy7kD
	+vt9cVLbnZrSarDRb9gKIKDpakCADlARvrbSmh6CQ55MygopKu/TVomt5oNaS1iR
	Y3GugRCJXTdWJPZO1rBrbevogsoOnhJ4HMNzajYbDA==
X-ME-Sender: <xms:8LQ0ZiE2XrgHxtsihzNZAjsi5HVBE0PJs5G1Q5UWoMCCWqTgGym-ow>
    <xme:8LQ0ZjXOIPHn1Oz8HWzMBvcE0c-gfDTBA57mfZdP51Vn35U9lTL8ZOt_vQvVcz9YI
    ornS9IMa56WpS1maA>
X-ME-Received: <xmr:8LQ0ZsLCdypBc_46n3uDsv9IOJXCC_CAjRDi9-amPd5UYlLo360EHP9Trg0C9XRGhDdXeGzvA6FwIIOfvwk-IdmYrxbVZ7dUTXPT1eEYYlP1ccvd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:8LQ0ZsGks7kOnOrV0ylAv8EV5Qc0ahsnZ68QqOZ_Dvr5keY4sKApAQ>
    <xmx:8LQ0ZoVQsvN4S-BaO-fNxtFBTPfa0pTFFHohr0Ev_8veeDPDRzQ7dA>
    <xmx:8LQ0ZvNixghikl1aAvVSHHVBMvRML8PAi2U99AQEklWNeb8Y3djhZA>
    <xmx:8LQ0Zv0EAF6umky9e2JYgC-A8HX-dlj-zfxPQ5lxrm4y2W1e3aU3HQ>
    <xmx:8LQ0ZqJluR4yE8YgIRHBP5zpm2-Z6oHoqGPLbayyNQb2CDvARWU1CGJ1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:57:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9eb1410d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:56:34 +0000 (UTC)
Date: Fri, 3 May 2024 11:57:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 04/14] builtin/config: use `OPT_CMDMODE()` to specify modes
Message-ID: <1bc39188409c8239c95555148487cfba7550475f.1714730169.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BBxbFCSMlgGFvRR2"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--BBxbFCSMlgGFvRR2
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
index 054019b70c..8991533e08 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -632,20 +632,20 @@ static struct option builtin_config_options[] =3D {
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
@@ -769,10 +769,6 @@ int cmd_config(int argc, const char **argv, const char=
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
index 9b65d9eaf5..86dc70769a 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2738,4 +2738,17 @@ test_expect_success 'includeIf.hasconfig:remote.*.ur=
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
2.45.0


--BBxbFCSMlgGFvRR2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tOsACgkQVbJhu7ck
PpTAXxAAhFGgS+KrnJTx4FApb9TPWhgo5Wg4pYEu+LNcwyjKHL95aaBDXYjRQUHs
rGxA3cq2RvNiLuy9OuPC/dLh4ggtJcdLwA25aypHh29Xbmufoe/HkzgWjU3GeEjU
WwD5R2+IExr7QAIiTIb1kLe1LkTqetGQPA20V+ZbFjpKqffWrl92yCXrB8oC2UjL
VFtoyIj7VwQzyn4U1F3yZzqciE/GJ7pOCmYWLnJUA2dRtOzFEZoWcFARO+gT3/vm
m84u4i76mSINO2mLzBhOYwvVN0TRzUlnkxqGZmyMS14fQ+2OWCSag3runsJvKPes
ipp6V7v9Td05NbQSFCKBCrB+6VZvjNcLAZ68MvioIY0mRhxesd+e6WwlFgENIpEo
hZI4xG3kjfQwklyDP2QZVLq46WM8g8ZQKjX0eB8y4F+s+DoLEopzZv+hPgR1uK8w
ktLSZSgbArv7m2HR5dWPqYbhUoVL6itsyzzsJT4A8PITbJuP6UNpHAhi7o17zFtS
97s/jHwvJijJgrqT4U9FOW+y0dvph2IeBhkYSI5tv2I1dYQFdbb5gNpbdHvjyT0J
zcK1BIeQDO7iGgKxm3dsC/UwPW+y634R57tt43xf9A/llaUl3bwlA/pNAFn6GovA
Echw/esug5QOjG4bHKopDyuBf/TXwRE5ZXSZTn4nkdySiAzAXKg=
=w8L/
-----END PGP SIGNATURE-----

--BBxbFCSMlgGFvRR2--
