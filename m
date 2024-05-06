Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F291420DE
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985777; cv=none; b=PebgJ6eFB0GDmHeMe7jdZV/gq4xaCustuLDBNbGygWd+STCtVPR/Yfw0NtYKOo/v3r4IZ0PRWqdf0NYbdZc4TCBlKJd5N/opgZFinQBsagpcy9llRcPGKVQjmc5r/5+sXTKHSzFzuavl6TzKvsVI3UyMjP/zCKWKRiEdQsWZd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985777; c=relaxed/simple;
	bh=puDoClsU04jpz74LIsJGT47S936YbKyzzygcaiTn2os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nggBmdebcwJ1agkL6yH8YbMAcHrFgOLmlXzZ5iQChMU7arw0viTApSJp81Mb28d6vYweTpKFtHj+DrHp+Sc/n1mCsIIvmeUQD7k5GwSs9jXsK+6vKWsMOcptYSJgx5O5G8PUOxxGb/hGvYQdRZ13cRR4nk6MqZm1wfQ/DOoD1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EPnn95Os; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RHV53I0d; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EPnn95Os";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RHV53I0d"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8352218000CC;
	Mon,  6 May 2024 04:56:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 May 2024 04:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985774; x=1715072174; bh=DOGCGjhOnw
	nwCf4ERCd1BX6OtTk0w+YcE/AbOq90+2k=; b=EPnn95OsipkBRTE4kOmAgpQlyu
	MSo98AxK4U8xMdHxXXh0xSrwfdYjg6IDPOH4pnaTYX4hqHtB9bU7DHeLqO+gJcUm
	faHuaEm/73eVIRB0xjiDKnrHvoLiuHEb6HwJ4RIscxwB8VmQabd38z5y6rNsbRY0
	fVQIcS4Tzh5Xsp4rskpme1iBV+EXhVS+Wad9amXLEIp/SMxutg6FqBDp0jG0KCEt
	3BEdob+1jb+ALmfGsgcmhOpYavzCMhpHiDQRKP1k62DfoRWi+43Qz6ATAhQx0iKx
	ph2yeIHVHe1VjDbqmNeORlCaVX06Xu6cmyuUgrnv9bGCqvLFtKQqPBvUl8ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985774; x=1715072174; bh=DOGCGjhOnwnwCf4ERCd1BX6OtTk0
	w+YcE/AbOq90+2k=; b=RHV53I0dEF0TzEv5y4f8Ewy8JXepwvsJlI4hl0dnGKOx
	LZy0yew96xBpWSoNFMpccaaREdxJpg1p6yyYVokDWYSUWa0RJQWYn9HOaX2eWpG+
	LGi/XxnYr0AbxZDWZgj7ZCu4WIlTskCKVQyAoxwfPw8TXb2DdVYWVaUTajte7TMF
	+Abi6t3BhMEGtNotri9+SzEsA5sMIl4ZqJcz3z+rzq5hMk1eKsZTj8h/HbPVXzhv
	rfFZ7D1TYWYYf0Ncq3gn3rZe2+0P06ZlSQv6uu5yb40NktVOud3rEHCysJMpuDTQ
	IYavNQZ5MK2KUy8LQXbGYJIB6I0QoqdXk5BIZn/VIw==
X-ME-Sender: <xms:LZs4ZmW-w8d9di0CNoiNcudmHgrWTVAuGOFRgIjS7cMjdYGoDn51lQ>
    <xme:LZs4ZinreE7WPvc_JdOBxIXNj8U70kYHbdxrIPlIcxgT0GIp4911qymlyitQfv7Qo
    KtTt0NfwSWYASbncA>
X-ME-Received: <xmr:LZs4ZqZO71uJ6SNm0VKHefdhSRM9ruapHptfJHn90NK8at7fE9u5ah3O1fymHItaVRzj5pRJMGfu6UW-mXHVHzSEpV4g8mfFAUraOYiTUzOiqVEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Lps4ZtUMed-wqyEKI80gmnQgzlI-6T4keIYnetnnLF1IDmsaOyRqGg>
    <xmx:Lps4ZgmZsa5p1vYPOOu8qt_RiMZu7qm33xcMzjXWW8yk5tybNLR9uA>
    <xmx:Lps4ZifbTlROaRI51Ub0XS7YmK4JUdGUA4mV_3NLIRo3mLZtW9Y9lw>
    <xmx:Lps4ZiHrCQtRSIBix0I_qnKJqs4uGKm9duZK98RBr1A6vz6YVI6RQw>
    <xmx:Lps4Zq4sR1Hq9mo7_KCGjOUQATNPBzSFtayZEBWDGMRCeWJfV9DS1G9p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:56:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c2e191da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:56:06 +0000 (UTC)
Date: Mon, 6 May 2024 10:56:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 04/14] builtin/config: use `OPT_CMDMODE()` to specify modes
Message-ID: <34b66f9c8754e4cd8df934aa4d6ffdc51129e402.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lSHZ42W4FA/IkSLH"
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>


--lSHZ42W4FA/IkSLH
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


--lSHZ42W4FA/IkSLH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4mykACgkQVbJhu7ck
PpSvRg/6AxeTllx/dtDAmZHtP3PMz0JqOcupXj7qtllhULGO6ZV9hEDcebnw1FD0
EzkxjBQa0/W3arlFPXKRGSwhCGxZee/erpqHOvefHxB+GcvJ1CMKHNEQ+21lMAqk
eRPpOUjRVvaXhmxyPzbG3oORUqPwyJNlDnEAHFomrrXfOcUHqJ1xtQRkPnO1TS8g
dBr1rQwFORiyMINzK4U5Nos3obTjZ6bLvEwh06f6tDq5qpBESUiAxu4HRNOdkzXP
IvuG0RtRMbppomNoCNT9GfM1+YUBnOnJnjbLieMsMLIwUMO0k/5aAHNGaTfNZ4S2
32eOasQE4L+Z8po4N6LzKCcepfkxi64Y8vQDNL/8a67MRRRxUKmA4ZPtQ4T4hhaJ
Fly4gTYI2Coqr+7uhYU6nrNc7Uuls+gz+Mjtvm3cnVWgK8ouHO5HPbvccSDuoOLs
DKYhu98+N8aHet3USNnSUeXIHceC6o/2n4TS9c1hJQenO6dM/fQ3s0OYmdW/RxGU
R4cCWBy1gAbMr9nFw6f75n5/jU+aSKlunBjQHMd7lepL2SaRky9FDm5d44Ce0Pba
5jUb18U9bSMafeUQRu8iTPZrDTeRRTeeGIgkjWMSapd6rnugl//ze24qTtze/XnA
srKcGDjdYsuFetUWAYq+LkWpA6d/zFRg0KkJ4pHSx/brGh+yrf0=
=YXur
-----END PGP SIGNATURE-----

--lSHZ42W4FA/IkSLH--
