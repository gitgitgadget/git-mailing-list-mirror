Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A7B58ACC
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199196; cv=none; b=aocrVRmW5brbBiM6a5Wokm9MFyH69NFT69BHMLLB9M8kB+wKngwFHMLF9yI5KQ0W1JSbR/ijGkiuG4XM2byu7mW3Qpohub3hmQm2H7jfSvdzOGmLjnWE73uR/JS0meUkRGn9EuRZZH9gED1j2SKmdUG5XYtbmFz3UkGNyKl/ioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199196; c=relaxed/simple;
	bh=qLn3ga+j2hwKX2SEseOP0NqGTA2RJoHjhItPAqm3WPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlMt+8woQvdQvD7OD0sTRKThpVaSKQvS/tfb9QN7nw4To/45xf1Hr08Mim6ZU7sexJU6qqortO0fWmtW0D48ZEPqUFr0Cs/K1tDa2gMIcP9AKxUrzLvCLVFfKS+M3Z4yhJXhbrvdauBrmd5WhhXwe6IqpPevpYKmtJcBGDjMinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eqGiqBCQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b7YsFX7K; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eqGiqBCQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b7YsFX7K"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id B7FE7138012A;
	Mon, 11 Mar 2024 19:19:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Mar 2024 19:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199192; x=1710285592; bh=yPM3h59r6f
	5zyjuO4uQEkBDheTCwUuilpYgJChsP9rE=; b=eqGiqBCQZULKX0EY823uDM+dWv
	UKmWPHQdbhtJ5ghA2rx2t6n4fGRaY46vcuVeyL315NXkoONab+2DW98SN5pn6ZCP
	SQNwEP9lN8MphLIl1t8M3BQo9pYTcgK91JVFzj1au63mNWji7ajmjCUjUls67uye
	EVgSiOUUI4nKm9zr8pskCd+u13++9nOerm+5McC7SKJ4ffx2SapEZtcrBx/SOFPQ
	BmtP5QNTwoLkwFy4Wo9O6Inh0Qm4mwlIwLOYX/WnnYf3PEiurZPPRy9AK0qOA3bQ
	pJpRIVDxkKiANNi5hnvcZ35ng+jq9cHnjroZ+Z55G4Pfw1ZR7X2FPTX1+FeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199192; x=1710285592; bh=yPM3h59r6f5zyjuO4uQEkBDheTCw
	UuilpYgJChsP9rE=; b=b7YsFX7KZtUdsTYQ+EXCHKb4jhAer2voDTcN/MrbimhK
	BbxByS1a6wQPrwHW95oQVlltFqrgaDKeK2D7bcgxzmJcqMRHfaqt4c69Crlt0quR
	IWjwQ47td6N9kRw1ovw1GvWCIqoy7rYcMybt6RAOFDKwJCFMRIuNAU2I47LnErcQ
	uQ6k6595Ufo13Rm51rkIOtDJ2FMqq9Lodxn1QBf/RXfRVXvBZA+XGxfbjrZ33eAd
	fKW/Jn/gdhiOdJDD6ao0StfFk6QcIhWKyUY5r6NVkLrOv42Tufj+/mOmmp/HR/T4
	/GDQuKIG2f/PxYiLqM+nVndMm/6E+zveuwXngomtaA==
X-ME-Sender: <xms:mJHvZSbdTebrlY4C-zmI8HGzfVZbvUL2hnwyJVQbf4jYNn3uASVqyg>
    <xme:mJHvZVZp1R5DagbuWGvakwuNIV8huN2jplL2QPb9No-1Q0gLXcG6dirgPYzx3ZJKH
    3twOHQgwRHAoqU0cw>
X-ME-Received: <xmr:mJHvZc91KYSOOLhFO95nK3Q6rWvwJUVuj1bEOgRi4-jCMVnd9QOQA1ktKfuNX9YTx23QYrYUkiyx0c0346IHU7i6Sjq1AVDPMJq1ELmpQXWbuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:mJHvZUqPNucy7QyRzPb0M7XREHpjAEvtJdyfj7JEaQX049oANZBePQ>
    <xmx:mJHvZdpCc_c_8sUkdzL4ES43IFdDNdW655S-x-TiwihVq942dezXRw>
    <xmx:mJHvZSTvARjLK3JQZaWkM6WWlt7lBtrkuGhTOeaLHOWenYH1Ks1ppg>
    <xmx:mJHvZefXJDYD8HyLcLcWMlcz9OlpKR-tgdB_BHRrQO5G3HiNArMIxA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:19:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ecc11975 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:15:11 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:19:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/13] builtin/config: move option array around
Message-ID: <1f21e7fa0d27f013fcffd5285ff36bf8a281ea2d.1710198711.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1710198711.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L0qw/xWNbGwEg38o"
Content-Disposition: inline
In-Reply-To: <cover.1710198711.git.ps@pks.im>


--L0qw/xWNbGwEg38o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move around the option array. This will help us with a follow-up commit
that introduces subcommands to git-config(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 94 ++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index b55bfae7d6..6eb6aff917 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -134,53 +134,6 @@ static int option_parse_type(const struct option *opt,=
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
@@ -669,6 +622,53 @@ static char *default_user_config(void)
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
2.44.0


--L0qw/xWNbGwEg38o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkY8ACgkQVbJhu7ck
PpQgrA//b7cA3dBMdwJcjeTVOWtF/5ytjazz25IV9k74xY+saVk4nXsUw0DYByui
G4JnGFAredrkH1s9vuKeV1R4tSmv0MF/rxzmZwtHNd41QvdRAZpBHeuC4E6sVycA
j+iptqu4Qqy6C03ibALHfa+/4OA5nUA6yEx7R/3udWAw52hsjRnHrB5NBG6udsa4
5DUSy8xLSyJD1MEeWUZxrvnfs6FxadRhmGVmW3PlLF+eIwkJkTeRb+8nTmfPbxFc
CbTQpp+aHBx/mo9t9kkdRj7vk7MIhuE5sFqoL5D1Mou0j/3UIDQSzdAWyXFers/9
Ht9gKmR6m3NZ76yYFpP9wyvlyMnZkZ9rYdJ5IK2lm3d4P2npnCxJ6vgW3NA489SN
LIkXcwX1jsPRYWPBEtB9TiahLux9czoCGLXd0FAG4biMG4QG7xLvdWvsU2lQQgWl
GynML6WIvysaZ2r5u6gjBj1D0mjHgTZ7ZrdPT92hTFV5vkdk1HGqxHCN3j9g5+q8
aVrl3PriKx5lxFhf3s/0pjYFFioi8dN0gIoOijDB+4jHk0PrlDmT5nQqyyUaO1tF
wvUnvmM1JU97r45zB57mMfDAm6WUog+4KNpVmK0zKRTkNlwQaZcczC8spxwLm0E5
xVzbG+wlkS3ptmjYvK5rEuA0Bm6g/u5vmEsdxur0LCCPfibvRZE=
=XXwT
-----END PGP SIGNATURE-----

--L0qw/xWNbGwEg38o--
