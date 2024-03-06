Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B0763FC
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724715; cv=none; b=sq+LZqohl+49dg7zI1Ub/Oao6V6PBvrgtO9wJFKuHsyg0Xlgi5I7fNMABAV7AgjIgAaSoWgLEY7tBu/ZtHB1v6CuKn9nPTmJjubPLZqW/29mA7702HNB3Kjwoud/82S70Z/S16fkkKLPRId+8C3hx3sh5PwZy2U+SqpAY1g2rHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724715; c=relaxed/simple;
	bh=WslLQBtU0zyG6UecKpzYQ5W1L7PXL7MfUdwvsslWFgo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czu8G85d7S0C5ho2zXhhl/g2ZgOvtvG/pQRvgfE/iau4bNIZ9TGgJBzen5lEcGKmORUSMQWClZgNAJOMnJEch8pmIFggqELAf2nhABfgpwCzZkFtN65tV/seRJDXf5CST3N6dnN36sY0tacQQj/OeGCIg5i5gWEDvzL/Iz7wc7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s/4ja3/J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bG/srSqU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s/4ja3/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bG/srSqU"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AE50111400B3
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 06:31:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 06:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709724712; x=1709811112; bh=tvRA2uqLRs
	1GolxBY3XEM7xmQT8gJUNn9j++HcHTSVo=; b=s/4ja3/J/Ff/AgYGAsYlzft1GK
	DfkCCL8dy8G1bFoa5jMC1WFOYOj5bScQpdreOECB8O39/gYL+WxB9Zts8xoFyYoC
	InWdMDVr88H3GIE/ojLMchAKs8LXRXAJ33JZarVEKvVBy6uRL12zdzaRiRjpwwAm
	ma0QXtWd/vOLs+qvSvPbEB8Y4ZGowy8opse5SI+Dowk46mrIlOpo/PmyOUb7ypW0
	Be8+RNHeke62LkOu5Rfqsb5ENbmxphkpVSHhrknJI87Tf9YE0/6pq+cpcCqYhHT/
	U4JUSMJA28kfbpQ1wCp2E5LH4cNPwa1CfzcerYVWQlp/9EenQDuerhi+qC9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709724712; x=1709811112; bh=tvRA2uqLRs1GolxBY3XEM7xmQT8g
	JUNn9j++HcHTSVo=; b=bG/srSqUAd8CjjfvNwYQ1lVmVf0CwcG6sjb3V6HKCIGE
	ofqxsefZwC2oUQMEn4yWCPwD2h/TYGo0zJwRH6K9NcY5Fo+4E/kAhjbjEn7aIplr
	EzwPqprhITq9lQIiZmzdlrLpzqNzryYZkk5gi8Vc8kwm/3bgYcP6P4xHUJlr0RyY
	7IH42PSdQ6eGXTXXQx1x89fpbsMj0csw13Kvflz8E6ItUBbQ8eH0Kjql7O/HuzRX
	KzWxyBdbPo9nuRijXKTb5xXklY6QdwGctHACjacLWAc62GbYUhXvY7t8lfYuCx5j
	wGHoWv2PMzK0Vq5A/3vGVzbYslOy9+FIURhSS9pilA==
X-ME-Sender: <xms:KFToZTVDGXFkT6P-AYbGKAGIzxYhpHa6TuNYsH4L3VpGnhYWFbxyqA>
    <xme:KFToZblX9QyQdXuwNjMlC2j_mugoIl6r0WrgLhmHX--NKyxQgvyQD3mv7uOBUCW1-
    J0FPqaUEcbRrRqKmQ>
X-ME-Received: <xmr:KFToZfbnMjVufuva_XZzZps_yR_6HgYk57xSeGtcmhBhMKYCSytplFqI1HuQljJE6503lBMHXY_qrWAJyA2-070zV51zoCW4tqysEzXbMDqANIPf1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KFToZeUzv9LMm6AI81zHPRZgIhCML6GnmEWCFVL-iXDr5Wr0DbDx-A>
    <xmx:KFToZdmaaC2zoWt2uzJnRL-RXDaj1DWAne6r7Wn73RKeWYfLA81LTg>
    <xmx:KFToZbeAm78wRiAEL1NBUHhiSXH_lOqWwI8uQCYAlVsww1b1a_aatQ>
    <xmx:KFToZdv2UMIMxxlL4IATsKTc8JKGRzRW0WJo_FvvNJOSjsYP_XhPzg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Mar 2024 06:31:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7c68d29d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Mar 2024 11:27:23 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:31:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/8] builtin/config: track subcommands by action
Message-ID: <e39774d6495767c6505999bdc33110678139e347.1709724089.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Od2KU+v50Ab73AY/"
Content-Disposition: inline
In-Reply-To: <cover.1709724089.git.ps@pks.im>


--Od2KU+v50Ab73AY/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Part of `cmd_config()` is a rather unwieldy switch statement that
invokes the correct subcommand function based on which action has been
requested by the user. Now that we have converted actions to be tracked
via a `OPT_CMDMODE()`, we know that the `actions` variable will
only ever have at most one bit set. This allows us to convert the
variable to use an `enum` instead, and thus to create an array that maps
=66rom this newly introduced `enum` to the corresponding subcommand
function.

Refactor the code to do so. Besides allowing us to get rid of the giant
switch statement, this refactoring will also make it easier to introduce
proper subcommands to git-config(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 207 +++++++++++++++++++++++------------------------
 1 file changed, 99 insertions(+), 108 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index a6ab9b8204..0d58397ef5 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -20,6 +20,26 @@ static const char *const builtin_config_usage[] =3D {
 	NULL
 };
=20
+enum config_action {
+	ACTION_NONE,
+	ACTION_GET,
+	ACTION_GET_ALL,
+	ACTION_GET_REGEXP,
+	ACTION_REPLACE_ALL,
+	ACTION_ADD,
+	ACTION_UNSET,
+	ACTION_UNSET_ALL,
+	ACTION_RENAME_SECTION,
+	ACTION_REMOVE_SECTION,
+	ACTION_LIST,
+	ACTION_EDIT,
+	ACTION_SET,
+	ACTION_SET_ALL,
+	ACTION_GET_COLOR,
+	ACTION_GET_COLORBOOL,
+	ACTION_GET_URLMATCH,
+};
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
@@ -33,10 +53,12 @@ static char delim =3D '=3D';
 static char key_delim =3D ' ';
 static char term =3D '\n';
=20
+static parse_opt_subcommand_fn *subcommand;
+static enum config_action action =3D ACTION_NONE;
 static int use_global_config, use_system_config, use_local_config;
 static int use_worktree_config;
 static struct git_config_source given_config_source;
-static int actions, type;
+static int type;
 static char *default_value;
 static int end_nul;
 static int respect_includes_opt =3D -1;
@@ -46,30 +68,6 @@ static int show_scope;
 static int fixed_value;
 static int config_flags;
=20
-#define ACTION_GET (1<<0)
-#define ACTION_GET_ALL (1<<1)
-#define ACTION_GET_REGEXP (1<<2)
-#define ACTION_REPLACE_ALL (1<<3)
-#define ACTION_ADD (1<<4)
-#define ACTION_UNSET (1<<5)
-#define ACTION_UNSET_ALL (1<<6)
-#define ACTION_RENAME_SECTION (1<<7)
-#define ACTION_REMOVE_SECTION (1<<8)
-#define ACTION_LIST (1<<9)
-#define ACTION_EDIT (1<<10)
-#define ACTION_SET (1<<11)
-#define ACTION_SET_ALL (1<<12)
-#define ACTION_GET_COLOR (1<<13)
-#define ACTION_GET_COLORBOOL (1<<14)
-#define ACTION_GET_URLMATCH (1<<15)
-
-/*
- * The actions "ACTION_LIST | ACTION_GET_*" which may produce more than
- * one line of output and which should therefore be paged.
- */
-#define PAGING_ACTIONS (ACTION_LIST | ACTION_GET_ALL | \
-			ACTION_GET_REGEXP | ACTION_GET_URLMATCH)
-
 #define TYPE_BOOL		1
 #define TYPE_INT		2
 #define TYPE_BOOL_OR_INT	3
@@ -842,6 +840,25 @@ static int cmd_config_get_colorbool(int argc, const ch=
ar **argv, const char *pre
 	return get_colorbool(argv[0], argc =3D=3D 2);
 }
=20
+static parse_opt_subcommand_fn *subcommands_by_action[] =3D {
+	[ACTION_LIST] =3D cmd_config_list,
+	[ACTION_EDIT] =3D cmd_config_edit,
+	[ACTION_SET] =3D cmd_config_set,
+	[ACTION_SET_ALL] =3D cmd_config_set_all,
+	[ACTION_ADD] =3D cmd_config_add,
+	[ACTION_REPLACE_ALL] =3D cmd_config_replace_all,
+	[ACTION_GET] =3D cmd_config_get,
+	[ACTION_GET_ALL] =3D cmd_config_get_all,
+	[ACTION_GET_REGEXP] =3D cmd_config_get_regexp,
+	[ACTION_GET_URLMATCH] =3D cmd_config_get_urlmatch,
+	[ACTION_UNSET] =3D cmd_config_unset,
+	[ACTION_UNSET_ALL] =3D cmd_config_unset_all,
+	[ACTION_RENAME_SECTION] =3D cmd_config_rename_section,
+	[ACTION_REMOVE_SECTION] =3D cmd_config_remove_section,
+	[ACTION_GET_COLOR] =3D cmd_config_get_color,
+	[ACTION_GET_COLORBOOL] =3D cmd_config_get_colorbool,
+};
+
 static struct option builtin_config_options[] =3D {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -851,20 +868,20 @@ static struct option builtin_config_options[] =3D {
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object")),
 	OPT_GROUP(N_("Action")),
-	OPT_CMDMODE(0, "get", &actions, N_("get value: name [value-pattern]"), AC=
TION_GET),
-	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [value-patter=
n]"), ACTION_GET_ALL),
-	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: name-re=
gex [value-pattern]"), ACTION_GET_REGEXP),
-	OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for the U=
RL: section[.var] URL"), ACTION_GET_URLMATCH),
-	OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching variable=
s: name value [value-pattern]"), ACTION_REPLACE_ALL),
-	OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"), ACT=
ION_ADD),
-	OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [value-patt=
ern]"), ACTION_UNSET),
-	OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [value=
-pattern]"), ACTION_UNSET_ALL),
-	OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-name n=
ew-name"), ACTION_RENAME_SECTION),
-	OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name"), =
ACTION_REMOVE_SECTION),
-	OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
-	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
-	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slot=
 [default]"), ACTION_GET_COLOR),
-	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: slo=
t [stdout-is-tty]"), ACTION_GET_COLORBOOL),
+	OPT_CMDMODE(0, "get", &action, N_("get value: name [value-pattern]"), ACT=
ION_GET),
+	OPT_CMDMODE(0, "get-all", &action, N_("get all values: key [value-pattern=
]"), ACTION_GET_ALL),
+	OPT_CMDMODE(0, "get-regexp", &action, N_("get values for regexp: name-reg=
ex [value-pattern]"), ACTION_GET_REGEXP),
+	OPT_CMDMODE(0, "get-urlmatch", &action, N_("get value specific for the UR=
L: section[.var] URL"), ACTION_GET_URLMATCH),
+	OPT_CMDMODE(0, "replace-all", &action, N_("replace all matching variables=
: name value [value-pattern]"), ACTION_REPLACE_ALL),
+	OPT_CMDMODE(0, "add", &action, N_("add a new variable: name value"), ACTI=
ON_ADD),
+	OPT_CMDMODE(0, "unset", &action, N_("remove a variable: name [value-patte=
rn]"), ACTION_UNSET),
+	OPT_CMDMODE(0, "unset-all", &action, N_("remove all matches: name [value-=
pattern]"), ACTION_UNSET_ALL),
+	OPT_CMDMODE(0, "rename-section", &action, N_("rename section: old-name ne=
w-name"), ACTION_RENAME_SECTION),
+	OPT_CMDMODE(0, "remove-section", &action, N_("remove a section: name"), A=
CTION_REMOVE_SECTION),
+	OPT_CMDMODE('l', "list", &action, N_("list all"), ACTION_LIST),
+	OPT_CMDMODE('e', "edit", &action, N_("open an editor"), ACTION_EDIT),
+	OPT_CMDMODE(0, "get-color", &action, N_("find the color configured: slot =
[default]"), ACTION_GET_COLOR),
+	OPT_CMDMODE(0, "get-colorbool", &action, N_("find the color setting: slot=
 [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
 	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type),
 	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL),
@@ -976,33 +993,43 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
 		key_delim =3D '\n';
 	}
=20
-	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
-		error(_("--get-color and variable type are incoherent"));
-		usage_builtin_config();
-	}
-
-	if (actions =3D=3D 0)
+	if (action =3D=3D ACTION_NONE) {
 		switch (argc) {
-		case 1: actions =3D ACTION_GET; break;
-		case 2: actions =3D ACTION_SET; break;
-		case 3: actions =3D ACTION_SET_ALL; break;
+		case 1: action =3D ACTION_GET; break;
+		case 2: action =3D ACTION_SET; break;
+		case 3: action =3D ACTION_SET_ALL; break;
 		default:
 			usage_builtin_config();
 		}
+	}
+	if (action <=3D ACTION_NONE || action >=3D ARRAY_SIZE(subcommands_by_acti=
on))
+		BUG("invalid action %d", action);
+	subcommand =3D subcommands_by_action[action];
+
+	if (type && (subcommand =3D=3D cmd_config_get_color ||
+		     subcommand =3D=3D cmd_config_get_colorbool)) {
+		error(_("--get-color and variable type are incoherent"));
+		usage_builtin_config();
+	}
+
 	if (omit_values &&
-	    !(actions =3D=3D ACTION_LIST || actions =3D=3D ACTION_GET_REGEXP)) {
+	    subcommand !=3D cmd_config_list &&
+	    subcommand !=3D cmd_config_get_regexp) {
 		error(_("--name-only is only applicable to --list or --get-regexp"));
 		usage_builtin_config();
 	}
=20
-	if (show_origin && !(actions &
-		(ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST))) {
+	if (show_origin &&
+	    subcommand !=3D cmd_config_get &&
+	    subcommand !=3D cmd_config_get_all &&
+	    subcommand !=3D cmd_config_get_regexp &&
+	    subcommand !=3D cmd_config_list) {
 		error(_("--show-origin is only applicable to --get, --get-all, "
 			"--get-regexp, and --list"));
 		usage_builtin_config();
 	}
=20
-	if (default_value && !(actions & ACTION_GET)) {
+	if (default_value && subcommand !=3D cmd_config_get) {
 		error(_("--default is only applicable to --get"));
 		usage_builtin_config();
 	}
@@ -1011,28 +1038,19 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 	if (fixed_value) {
 		int allowed_usage =3D 0;
=20
-		switch (actions) {
-		/* git config --get <name> <value-pattern> */
-		case ACTION_GET:
-		/* git config --get-all <name> <value-pattern> */
-		case ACTION_GET_ALL:
-		/* git config --get-regexp <name-pattern> <value-pattern> */
-		case ACTION_GET_REGEXP:
-		/* git config --unset <name> <value-pattern> */
-		case ACTION_UNSET:
-		/* git config --unset-all <name> <value-pattern> */
-		case ACTION_UNSET_ALL:
+		if (subcommand =3D=3D cmd_config_get ||
+		    subcommand =3D=3D cmd_config_get_all ||
+		    subcommand =3D=3D cmd_config_get_regexp ||
+		    subcommand =3D=3D cmd_config_unset ||
+		    subcommand =3D=3D cmd_config_unset_all) {
+			/* git config --<action> <name> <value-pattern> */
 			allowed_usage =3D argc > 1 && !!argv[1];
-			break;
-
-		/* git config <name> <value> <value-pattern> */
-		case ACTION_SET_ALL:
-		/* git config --replace-all <name> <value> <value-pattern> */
-		case ACTION_REPLACE_ALL:
+		} else if (subcommand =3D=3D cmd_config_set_all ||
+			   subcommand =3D=3D cmd_config_replace_all) {
+			/* git config --<action> <name> <value> <value-pattern> */
 			allowed_usage =3D argc > 2 && !!argv[2];
-			break;
-
-		/* other options don't allow --fixed-value */
+		} else {
+			/* other options don't allow --fixed-value */
 		}
=20
 		if (!allowed_usage) {
@@ -1043,42 +1061,15 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		config_flags |=3D CONFIG_FLAGS_FIXED_VALUE;
 	}
=20
-	if (actions & PAGING_ACTIONS)
+	/*
+	 * The actions "ACTION_LIST | ACTION_GET_*" which may produce more than
+	 * one line of output and which should therefore be paged.
+	 */
+	if (subcommand =3D=3D cmd_config_list ||
+	    subcommand =3D=3D cmd_config_get_all ||
+	    subcommand =3D=3D cmd_config_get_regexp ||
+	    subcommand =3D=3D cmd_config_get_urlmatch)
 		setup_auto_pager("config", 1);
=20
-	if (actions =3D=3D ACTION_LIST) {
-		return cmd_config_list(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_EDIT) {
-		return cmd_config_edit(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_SET) {
-		return cmd_config_set(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_SET_ALL) {
-		return cmd_config_set_all(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_ADD) {
-		return cmd_config_add(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_REPLACE_ALL) {
-		return cmd_config_replace_all(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_GET) {
-		return cmd_config_get(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_GET_ALL) {
-		return cmd_config_get_all(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_GET_REGEXP) {
-		return cmd_config_get_regexp(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_GET_URLMATCH) {
-		return cmd_config_get_urlmatch(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_UNSET) {
-		return cmd_config_unset(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_UNSET_ALL) {
-		return cmd_config_unset_all(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_RENAME_SECTION) {
-		return cmd_config_rename_section(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_REMOVE_SECTION) {
-		return cmd_config_remove_section(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_GET_COLOR) {
-		return cmd_config_get_color(argc, argv, prefix);
-	} else if (actions =3D=3D ACTION_GET_COLORBOOL) {
-		return cmd_config_get_colorbool(argc, argv, prefix);
-	}
-
-	BUG("invalid action");
+	return subcommand(argc, argv, prefix);
 }
--=20
2.44.0


--Od2KU+v50Ab73AY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoVCUACgkQVbJhu7ck
PpQ7/g//fAYT1Y3UFsQs593h6Jh4PltSbbS6blnxWMx4lY/EfCqmLqIA1eOp9dK+
oyyMnrgZhmV/ZcVomDUHVbZDmaU7ytv57AGncbLzfgumhLGGrhuLX3fbyBaKVFzQ
Z6l8OByu5KHYbUtHFIth8x2cmBMI5ZfeIAXH5oYfOAA9D3XJjZetp5B1yJ7rEE33
M2aedupI5vCBMtcS6cQy6juUBxlZhibCCP1Jo3Mh3T64DpAN59Z1whtaE+ylaEuU
cjNW48B6XR8QsAqPDsryWcuISP7DLcAyQRHX2IytctTZ+jWWPEZo3qOVOLZKmYm4
WSJpv1+yHkVXXtInIjxKF3pXINInoEb1WgoMGp+hKMZ9WnxCMRVhHNlBW0DhIGoa
iV/9SLQceg1tvpw6QumgtbDBuEBbAkhBD0iJjR/kS9cKghY2+mqrdTiO787vP1OU
7XlQOa6DO8V3yzyirmA4aVVTbvs9LiDirB0HTaduILwpAxBmph+Y8WzOMyb2QKHG
Dqi7kLmxru6bc5vpt+cZt3C0c8xvhr/xOApQfInWEiFu7IesMiqHhParhG0CCcOm
82WMqIfbAf26sjcT5deO5H9bkBGtRNCBwC+xvRkYvZpmBmbXwc6/eOiQd//OsOk1
C0pI6RJHoO+4//fGd5vhsWF2CEmhj0C5MHsEJH8dhGittsJlNu8=
=ql+y
-----END PGP SIGNATURE-----

--Od2KU+v50Ab73AY/--
