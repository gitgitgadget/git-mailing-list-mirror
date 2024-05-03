Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24E6150989
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730216; cv=none; b=WPEbs0b8YmLy4dg0LtnizYoGllMCWmxp5GPnkjnEw5Qt963ZLR7LzLYQ96TacfG1XizdcK5Z6sPFXvduPgOeN0HuPuqG8d/ttc9VZR79Vc7zfqD7cY/K05seyF1OLh9Cf7UV3ZrtXXmcKGVctk99rLTiDXVtMRF4pNyUdovIlms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730216; c=relaxed/simple;
	bh=qCXGTtFySRcSXGwWwJKnSorJIFBX1DJtwrSb8/CROsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOtZdnn/lCyUn/BLupDAknZDvH26XXFH83jDt7qTF1zgG0Q5/RJ/Ph+rRxeS/YpB+dLPnrm3ZhQu25QMJI+d419A/2BperMZN2r0Dxy5Y+CvfU78ssZY6KzA8lS44F6MqcduAAsGXFRWs3JDSvX20YIg5e+2qJB21UO+5dgq2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kKUZcRwU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zu3rCPLN; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kKUZcRwU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zu3rCPLN"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9363A18000BE;
	Fri,  3 May 2024 05:56:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 03 May 2024 05:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730213; x=1714816613; bh=iuNBRHMfjI
	80jL/K/TN0CsSjs2y7hqRdoJ2s6dffbeM=; b=kKUZcRwU1uNcVeaP9XcxFvjMnj
	XNRmQJVTbHkaOom/IF3H4T4+SPFeiEudqGDEwC6bTIwvulKOJtE9ujK9BIc43x/L
	GwWrSl9Vz4Mw4J966mCscSDwAOkZDlbsurAskhZDjNCLl6sPNHT/gtIJxVtyEMT0
	8IoqRGdHxtwU18No/r2cd5zS31VNN+GwK8j+fCzPGrwhqz00K98ZJRnmpz36nAyN
	8Zv1S/J1yZL6BlG36xjuibK9kq+2E+PRtAzYzdgVQX9a2dzp8A8BRppU25SCoPld
	eYLAnZxdhOnhbPcuqGdzMlO2OJqaaC4SHMTCViMIBrHjnwhc5r/5Cc+eKZxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730213; x=1714816613; bh=iuNBRHMfjI80jL/K/TN0CsSjs2y7
	hqRdoJ2s6dffbeM=; b=Zu3rCPLNSPW3OH4N+3VRLOJazXQ3dsNIAiZgFnIPVDgT
	ectfiLUxQVERssevcNybsrmP3c7b94wutc+e+u3U0fxb/pyuqH8SbfT4SC1SlaJ6
	4dCLx8ux1OVOTWHU084xWN6tai5GHZiSQuMOn/lRMeZEUZVoXIANHbpQ3lTmD9Hz
	Vzz9MSOSu/xSJFJ7McT0aF3Zam8+t5LoHaUZw/Z+UeXHtAAfv2D2ncYCK+zBeGBn
	RDyfloC4YHWlHewrUy23F3B4fgm6X44e/Kx4lN+ZPzE5qGkbrYS4icZZ/y4VYZxp
	32LnfDnpB7swYBBPiZ8m44+znmV+xbHw73ZmMPW7mg==
X-ME-Sender: <xms:5bQ0Zhd0Yj-Nkun_V_GCATHeK7J4d49v1Twyr7BcOsZeEjSGC_-Tyg>
    <xme:5bQ0ZvMzYrBMjxvePdUPcNk3RyWsm8BTRdAUtoUn5MwAIxn6Ty0sP03RSzxw98f7v
    DTUTRSFW5KgmECjIA>
X-ME-Received: <xmr:5bQ0ZqjI4OmTl54BorNLUGHrHPo6-Cyf5Vzqohqo5EG21qvp6rCG5ekOhZY9g05qVS31HFyJi8ZTIpFf3AVFBKFb9xWC-lOJ7FC2UGDjvFb8crwB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:5bQ0Zq_Lv3gTEylq4jGEeaOEKLhz-k4komXWfTUkCZFmo9UZlEnv-g>
    <xmx:5bQ0Ztu3QH4k8yYxmdB-xHm3Q6og-xhy4qQAZiX4-97PraCRNXAANw>
    <xmx:5bQ0ZpGmh8_82zGbPPOTc1blDIcsvnnpBxFd48WImxWewlUN67I6UA>
    <xmx:5bQ0ZkPDsfqEeRBxYc0heExiw93tbdWgyJe9aZ1tTcQQcQcP8Oqq_Q>
    <xmx:5bQ0ZhgNwcKvKyZZ22L7lH1x-nlA8VlYuo7SvuKIJsgWFtHDn9USm9TA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:56:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 351bd342 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:56:24 +0000 (UTC)
Date: Fri, 3 May 2024 11:56:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 02/14] builtin/config: move option array around
Message-ID: <8f0804ab4864438bd34a8bab5ff44f504aa8d443.1714730169.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o9pR0jnTV7AW/VO+"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--o9pR0jnTV7AW/VO+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move around the option array. This will help us with a follow-up commit
that introduces subcommands to git-config(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 96 ++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 40456c0770..59ae5996eb 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -135,54 +135,6 @@ static int option_parse_type(const struct option *opt,=
 const char *arg,
 	return 0;
 }
=20
-static struct option builtin_config_options[] =3D {
-	OPT_GROUP(N_("Config file location")),
-	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
-	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
-	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
-	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config=
 file")),
-	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")),
-	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object")),
-	OPT_GROUP(N_("Action")),
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
-	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
-	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
-	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [de=
fault]"), ACTION_GET_COLOR),
-	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [s=
tdout-is-tty]"), ACTION_GET_COLORBOOL),
-	OPT_GROUP(N_("Type")),
-	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type),
-	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL),
-	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_I=
NT),
-	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"=
), TYPE_BOOL_OR_INT),
-	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string=
"), TYPE_BOOL_OR_STR),
-	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directo=
ry name)"), TYPE_PATH),
-	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date")=
, TYPE_EXPIRY_DATE),
-	OPT_GROUP(N_("Other")),
-	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
-	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
-	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direct=
ives on lookup")),
-	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")),
-	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)")),
-	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
-	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable co=
mment string (# will be prepended as needed)")),
-	OPT_END(),
-};
-
-static NORETURN void usage_builtin_config(void)
-{
-	usage_with_options(builtin_config_usage, builtin_config_options);
-}
-
 static void check_argc(int argc, int min, int max)
 {
 	if (argc >=3D min && argc <=3D max)
@@ -671,6 +623,54 @@ static char *default_user_config(void)
 	return strbuf_detach(&buf, NULL);
 }
=20
+static struct option builtin_config_options[] =3D {
+	OPT_GROUP(N_("Config file location")),
+	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
+	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
+	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
+	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config=
 file")),
+	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")),
+	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object")),
+	OPT_GROUP(N_("Action")),
+	OPT_BIT(0, "get", &actions, N_("get value: name [value-pattern]"), ACTION=
_GET),
+	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-pattern]")=
, ACTION_GET_ALL),
+	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex =
[value-pattern]"), ACTION_GET_REGEXP),
+	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: =
section[.var] URL"), ACTION_GET_URLMATCH),
+	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: n=
ame value [value-pattern]"), ACTION_REPLACE_ALL),
+	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_=
ADD),
+	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-pattern]=
"), ACTION_UNSET),
+	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-pat=
tern]"), ACTION_UNSET_ALL),
+	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-n=
ame"), ACTION_RENAME_SECTION),
+	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTI=
ON_REMOVE_SECTION),
+	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
+	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
+	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
+	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [de=
fault]"), ACTION_GET_COLOR),
+	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [s=
tdout-is-tty]"), ACTION_GET_COLORBOOL),
+	OPT_GROUP(N_("Type")),
+	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type),
+	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL),
+	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_I=
NT),
+	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"=
), TYPE_BOOL_OR_INT),
+	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string=
"), TYPE_BOOL_OR_STR),
+	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directo=
ry name)"), TYPE_PATH),
+	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date")=
, TYPE_EXPIRY_DATE),
+	OPT_GROUP(N_("Other")),
+	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
+	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
+	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direct=
ives on lookup")),
+	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")),
+	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)")),
+	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
+	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable co=
mment string (# will be prepended as needed)")),
+	OPT_END(),
+};
+
+static NORETURN void usage_builtin_config(void)
+{
+	usage_with_options(builtin_config_usage, builtin_config_options);
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit =3D !startup_info->have_repository;
--=20
2.45.0


--o9pR0jnTV7AW/VO+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tOAACgkQVbJhu7ck
PpS9Iw/+JNpkWomZiKKoTX12lvnoxfrJrhsgBaHt9ojnYGbCaqmfLqvV9VdXNSDQ
DqoOY2X2HWXxhGnvpG3vjyZ4AmFLONgrScu4PNkYCmEZ6+RgKKQn0/mwBER1iFZP
QL39NhAOgO9Wg0QQFjDjmM05QTBFzP+J+xBrpkzOjA0nVOvZWqhsHlISyc8i3S3s
lQyyzFdaLpSQ+KQ+4VoOssdafz/oIoiD+hqpFqwYCu/TVlvV7ZPlqU+WY4cPdDP8
Tc6GHS72KFZm+JQ8TxbmsyNFoupIDr4qFL5yjqdjBkSP7aDdoWSetVVmi9Qdd6iq
auCziGdLRcJiUAcRcCKNQ/gzxmf97iRqNd0r/W6dXk6fTzI1wZ2hEPel352TJIZe
mB5GtA1CuU0h0VppU53Z0g7QvSYjv7Zqg2mYBIxzKDDwXSyzg/6qaLeGRU/rmbh7
V107n67uix/FrTvHksMt/7SnGuttyjxzMQzv6KCcC9qGgT0df0NII3QlejxyFUm7
HZ07u+AjTA+lnjtRCG9+l2ODuxyveG+5eFiWobavGcJ7TF8njdfMrK15yCopTrgy
8EmH4lcu+d+bYUXE/3U5rDM0ZuONFIkyt/fws1Y4KjamkfwC68gaSEyhI1wPn0wH
FHb/ZWIhaujbFNVTyfa9KeeqyRTXbrOZNtwMUgARh5JOopQejP4=
=URiw
-----END PGP SIGNATURE-----

--o9pR0jnTV7AW/VO+--
