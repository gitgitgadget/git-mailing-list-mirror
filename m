Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3C59B5F
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199287; cv=none; b=S69mQn4wFQX/om0SrWINcoRf8jP4pLgcfy5Y/Jb6rLy5pAVk70BMbbC85phjTCxOUa50TXxR5RPvyKRD72DmjSOVdS1EpJqzzsmFzrIPu/1N7h4bJsrT/vrYOdmk2tNKGxQGqYjiLj1hCJ6RVXaIGRrq3XdUk2u/0yN5PP+SK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199287; c=relaxed/simple;
	bh=0fIdfrWnygGJLogBus3Ubd0XS4Ts+Hg51f48CFPhV+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHkQ6d/ytQmwF4CcYzjR13mvAFK+RPG1z0u7dezILleKtAAxQnayOCzgXnPTmqx+sBCDWrhWBjhhLqLfehHlaoU7tgnmQtH4Z3erKUIYsQ++wJvrNOGU4fuZ0QYT8OxPmVU+gZDVN5oytf9BBtE5YKF7Xot0kv9SFa2QlQikxyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UDaAaJNq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mkpFB0aH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UDaAaJNq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mkpFB0aH"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BDDDE1140114;
	Mon, 11 Mar 2024 19:21:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Mar 2024 19:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199284; x=1710285684; bh=uo5SrOs3D/
	BGpvm4+6ll8FlMMdzEZ+a1fTH8PsLxFH0=; b=UDaAaJNqhURoYRd6U2L72lXoqW
	VaDhkixsFBDB05B7YD7CIhoM76hs4FZitq0HLL+aWAqqqWlmyNyhIMX63M/rHivj
	wNFzum7hxlEvf49zuR0KpLTBO07dDk5LGzMEeOaHJr5YgeXLfpVRUPGlzh1R4x8b
	91YQKkZ2M+ObfeAHbmtRcIyMWnhcnBreINMl9AOkZj0U4tJHp6aa+WNZxY/nodSJ
	+yGQAhpwO5dbhy+7+543g5+fB5ApGtPX85YYnJ11QXuf2odh+BjkeHrNpTJ+ki1Q
	jwv+kA3ZnBZJkfc6iN+FIkM4RBw4MWGbFWc1gBBZEGToewgyAXGF5CGXUbVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199284; x=1710285684; bh=uo5SrOs3D/BGpvm4+6ll8FlMMdzE
	Z+a1fTH8PsLxFH0=; b=mkpFB0aHd2ZRa0fQW4S58MVWTjJ3rgqB6KPt1fP6EaSf
	QpB8XUztL1H+Pc4XFxxsYP6AH1zpkiLziGwV3nZsbWYMErtXKZMAntlPLrshXInG
	p2rb1g9BC4C7UrS2swmXXpaiAjsRJXIQxWcCH9mtNOMdLRVl6FwfT7IpzOrGiGUT
	8qULVRzed+OQ9mjJ441/ZXLA6OQ7f+NG8/PdQaHvxi1LaQF83zfKlB3dKpk/f+Dc
	MykbRRJvrd3AXdhWBHVsR2/mQJV2gXL1vxT+xUz1kyJjcJ4Bu8Lt68vnmhjRgcOd
	+1VFRZUV4m3nuWzdt5PBm+2jM9JJW5VcY1X2U0GwrA==
X-ME-Sender: <xms:9JHvZXQQ16DvThgj9XmjRubMT2aAwwL70p9AyAvjfDBeKm1YZtG7LA>
    <xme:9JHvZYxVQL8Uu-3ObU9TLwpcfKjW0heqHk7ukqrGKKaM1loRaEeHwLaX-ZAx4ohVy
    7t_PR1u8O2bQhCRZg>
X-ME-Received: <xmr:9JHvZc2MsHfISdz_21gpNHuVjFl6FwHb7WjEadSPavJoUpCXiV0HxX-MZr42PzeysLKYIxhzoCD11jH4hPnUn4tLhHKXsUYBFYsPC64zjWKMaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:9JHvZXCNi2yRnoORqFTvOyLyrdFmcE-7FgAV63suAtFUaim9sAwG1Q>
    <xmx:9JHvZQidAVhaeiuUGNIa-AAkR2b_WoxnHrvtH3-KKrlZTxuJxMk6UQ>
    <xmx:9JHvZbqoCyD6pM8WOHcCm_uOc7QZ__XN1rOnC8ebB7ZS4BOoI4s5rA>
    <xmx:9JHvZbV6uSQ8qcfDZe0Z4jK3rn7PAhCeS2nPGF7xdHm5FwUZiOnVsA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:21:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 285d0766 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:16:43 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:21:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/13] builtin/config: introduce "rename-section"
 subcommand
Message-ID: <a3c66431b0c3fd71a89417cce98ba42a722d3ea4.1710198711.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1710198711.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YWbkzQweKvCK5uHO"
Content-Disposition: inline
In-Reply-To: <cover.1710198711.git.ps@pks.im>


--YWbkzQweKvCK5uHO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new "rename-section" subcommand to git-config(1). Please
refer to preceding commits regarding the motivation behind this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt | 11 +++++++----
 builtin/config.c             | 32 ++++++++++++++++++++++++++++++++
 t/t1300-config.sh            | 22 +++++++++++-----------
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 42e659ae63..ebde360c1e 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git config get' [<file-option>] [<display-option>] [--includes] [--all] [=
--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<defa=
ult>] <name>
 'git config set' [<file-option>] [--type=3D<type>] [--all] [--value=3D<val=
ue>] [--fixed-value] <name> <value>
 'git config unset' [<file-option>] [--all] [--value=3D<value>] [--fixed-va=
lue] <name> <value>
-'git config' [<file-option>] --rename-section <old-name> <new-name>
+'git config rename-section' [<file-option>] <old-name> <new-name>
 'git config' [<file-option>] --remove-section <name>
 'git config' [<file-option>] --get-colorbool <name> [<stdout-is-tty>]
 'git config' [<file-option>] -e | --edit
@@ -92,6 +92,9 @@ unset::
 	multi-valued config options, whereas `--value` will unset all config
 	options whose values match the given pattern.
=20
+rename-section::
+	Rename the given section to a new name.
+
 [[OPTIONS]]
 OPTIONS
 -------
@@ -180,9 +183,6 @@ See also <<FILES>>.
 --remove-section::
 	Remove the given section from the configuration file.
=20
---rename-section::
-	Rename the given section to a new name.
-
 --fixed-value::
 	When used with the `value-pattern` argument, treat `value-pattern` as
 	an exact string instead of a regular expression. This will restrict
@@ -317,6 +317,9 @@ recommended to migrate to the new syntax.
 --unset-all <name> [<value-pattern>]::
 	Replaced by `git config unset [--value=3D<pattern>] --all <name>`.
=20
+--rename-section <old-name> <new-name>::
+	Replaced by `git config rename-section <old-name> <new-name>`.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
diff --git a/builtin/config.c b/builtin/config.c
index e62a09061f..09e8f47b8e 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -20,6 +20,7 @@ static const char *const builtin_config_usage[] =3D {
 	N_("git config get [<file-option>] [<display-option>] [--includes] [--all=
] [--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<d=
efault>] <name>"),
 	N_("git config set [<file-option>] [--type=3D<type>] [--all] [--value=3D<=
value>] [--fixed-value] <name> <value>"),
 	N_("git config unset [<file-option>] [--all] [--value=3D<value>] [--fixed=
-value] <name> <value>"),
+	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
 	NULL
 };
=20
@@ -43,6 +44,11 @@ static const char *const builtin_config_unset_usage[] =
=3D {
 	NULL
 };
=20
+static const char *const builtin_config_rename_section_usage[] =3D {
+	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
+	NULL
+};
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
@@ -940,11 +946,37 @@ static int cmd_config_unset(int argc, const char **ar=
gv, const char *prefix)
 		return git_config_set_in_file_gently(given_config_source.file, argv[0], =
NULL);
 }
=20
+static int cmd_config_rename_section(int argc, const char **argv, const ch=
ar *prefix)
+{
+	struct option opts[] =3D {
+		CONFIG_LOCATION_OPTIONS,
+		OPT_END(),
+	};
+	int ret;
+
+	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_rename_se=
ction_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	check_write();
+	check_argc(argc, 2, 2);
+
+	handle_config_location(prefix);
+
+	ret =3D git_config_rename_section_in_file(given_config_source.file,
+						argv[0], argv[1]);
+	if (ret < 0)
+		return ret;
+	else if (!ret)
+		die(_("no such section: %s"), argv[0]);
+
+	return 0;
+}
+
 static struct option builtin_subcommand_options[] =3D {
 	OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
 	OPT_SUBCOMMAND("get", &subcommand, cmd_config_get),
 	OPT_SUBCOMMAND("set", &subcommand, cmd_config_set),
 	OPT_SUBCOMMAND("unset", &subcommand, cmd_config_unset),
+	OPT_SUBCOMMAND("rename-section", &subcommand, cmd_config_rename_section),
 	OPT_END(),
 };
=20
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 06d34b1d6a..0020296df6 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -590,7 +590,7 @@ weird
 EOF
=20
 test_expect_success 'rename section' '
-	git config --rename-section branch.eins branch.zwei
+	git config ${mode_prefix}rename-section branch.eins branch.zwei
 '
=20
 cat > expect << EOF
@@ -609,7 +609,7 @@ test_expect_success 'rename succeeded' '
 '
=20
 test_expect_success 'rename non-existing section' '
-	test_must_fail git config --rename-section \
+	test_must_fail git config ${mode_prefix}rename-section \
 		branch."world domination" branch.drei
 '
=20
@@ -618,7 +618,7 @@ test_expect_success 'rename succeeded' '
 '
=20
 test_expect_success 'rename another section' '
-	git config --rename-section branch."1 234 blabl/a" branch.drei
+	git config ${mode_prefix}rename-section branch."1 234 blabl/a" branch.drei
 '
=20
 cat > expect << EOF
@@ -641,7 +641,7 @@ cat >> .git/config << EOF
 EOF
=20
 test_expect_success 'rename a section with a var on the same line' '
-	git config --rename-section branch.vier branch.zwei
+	git config ${mode_prefix}rename-section branch.vier branch.zwei
 '
=20
 cat > expect << EOF
@@ -662,11 +662,11 @@ test_expect_success 'rename succeeded' '
 '
=20
 test_expect_success 'renaming empty section name is rejected' '
-	test_must_fail git config --rename-section branch.zwei ""
+	test_must_fail git config ${mode_prefix}rename-section branch.zwei ""
 '
=20
 test_expect_success 'renaming to bogus section is rejected' '
-	test_must_fail git config --rename-section branch.zwei "bogus name"
+	test_must_fail git config ${mode_prefix}rename-section branch.zwei "bogus=
 name"
 '
=20
 test_expect_success 'renaming a section with a long line' '
@@ -675,7 +675,7 @@ test_expect_success 'renaming a section with a long lin=
e' '
 		printf "  c =3D d %1024s [a] e =3D f\\n" " " &&
 		printf "[a] g =3D h\\n"
 	} >y &&
-	git config -f y --rename-section a xyz &&
+	git config ${mode_prefix}rename-section -f y a xyz &&
 	test_must_fail git config -f y b.e
 '
=20
@@ -685,7 +685,7 @@ test_expect_success 'renaming an embedded section with =
a long line' '
 		printf "  c =3D d %1024s [a] [foo] e =3D f\\n" " " &&
 		printf "[a] g =3D h\\n"
 	} >y &&
-	git config -f y --rename-section a xyz &&
+	git config ${mode_prefix}rename-section -f y a xyz &&
 	test_must_fail git config -f y foo.e
 '
=20
@@ -695,7 +695,7 @@ test_expect_success 'renaming a section with an overly-=
long line' '
 		printf "  c =3D d %525000s e" " " &&
 		printf "[a] g =3D h\\n"
 	} >y &&
-	test_must_fail git config -f y --rename-section a xyz 2>err &&
+	test_must_fail git config ${mode_prefix}rename-section -f y a xyz 2>err &&
 	grep "refusing to work with overly long line in .y. on line 2" err
 '
=20
@@ -1987,7 +1987,7 @@ test_expect_success POSIXPERM,PERL 'preserves existin=
g permissions' '
 	git config imap.pass Hunter2 &&
 	perl -e \
 	  "die q(badset) if ((stat(q(.git/config)))[2] & 07777) !=3D 0600" &&
-	git config --rename-section imap pop &&
+	git config ${mode_prefix}rename-section imap pop &&
 	perl -e \
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) !=3D 0600"
 '
@@ -2476,7 +2476,7 @@ test_expect_success 'refuse --fixed-value for incompa=
tible actions' '
 	test_must_fail git config --file=3Dconfig --fixed-value --add dev.null bo=
gus &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-urlmatch de=
v.null bogus &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-urlmatch de=
v.null bogus &&
-	test_must_fail git config --file=3Dconfig --fixed-value --rename-section =
dev null &&
+	test_must_fail git config ${mode_prefix}rename-section --file=3Dconfig --=
fixed-value dev null &&
 	test_must_fail git config --file=3Dconfig --fixed-value --remove-section =
dev &&
 	test_must_fail git config ${mode_prefix}list --file=3Dconfig --fixed-valu=
e &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-color dev.n=
ull &&
--=20
2.44.0


--YWbkzQweKvCK5uHO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkesACgkQVbJhu7ck
PpSXMRAAqTTbwfCllj6feGDVDOpu9aLHSnuXtkl1zuB8lxzjJVkOQVP16cA6sQMQ
LGzs/53R6FZGxm6tpRDwni5oL2KS5fsoU4hImEazBhTbv7g9pTW3/MPZyDySESnY
QaOFFoVe16RTM9ffF+zA0jq2ogF2TpyTvDh9ZTYtWSsK5TreP1KBAuGrrr73YIiP
+UMdSfLyYgMUngDSPsjx6Mueslcy4NVbtWUJh5n04Nnny1oYYEkOFbWmg48HszXr
oH/6NmEW7LUguT6CwxXGjNpcoghKNf10dQgLGGJwHxBIfN6HQtPocU7CM4F1x+49
75EIBaGDPA6BI5bEVlbdgKOV2jumZw3FZbMkuOM2jMr9Yai5GQ/SLMKbfe+U95Vx
Zx3ROVEkw58sRjgUe9pY5uVKQ4gmqFgY1bIKAhXQWmPcExKuZBXWXCLLK3Vo0ii8
AGUN7XPSlTiPSNRVdcuWP0ZCFXWalpfke4cg1GNYY127gLaOoBv0NynKNImtiOp/
jnV//UmDQm2UUnDW08hlfh9LR8PWGYZNwrzfHMJobYxg4gnFcrsZulTqhlgcIH48
0SrjfeoEvl3SAwefla4rqBoKaujCgEjT5rNWAyAt77am0utYiAgfaZUoWverpklK
eW8U2knzuhr2pqxZpY70H+EMw6CU/OPQU68TmfnEhad2Ti/vc2g=
=KuD/
-----END PGP SIGNATURE-----

--YWbkzQweKvCK5uHO--
