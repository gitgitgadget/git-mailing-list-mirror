Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60671E869
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529217; cv=none; b=VMP5IiL8qwWBviyft8OVRd6MoBmyAkfYvopPqKM4lCNAec7/xSbp1eAUxaHMlVT94uT/xag8c7/U1fkuZf0d5NWEHiPMtTMjt6LHVrQDJN8lTUMZMPsokORcO84b1WyGfOKcU/ZFwaSRx1bvZ2nDtznIgGfj0OSl6xO/pKG89J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529217; c=relaxed/simple;
	bh=Pn3cjL/fHExJa2XZDRCqYm6LqCZBITD6FL+h+avHmig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwNN8fjRBSiDDZzBxB3OAUSvdpXkpjd0EST9hhjWL8BFMJNQMhsC9PDJoUroNRIS1g1qQOunSDzBVEAHor+lfXB6ZO1RmwVums0HKoXtMmkEv+7VDlcwGu555BKabO+s134JPcdpLfZf1PCA2LOGI7dTlGnttaAsOp/wXedjjHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KGJyzwIa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bWbvWj2m; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KGJyzwIa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bWbvWj2m"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id F0DBB138015F;
	Wed, 27 Mar 2024 04:46:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Mar 2024 04:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529214; x=1711615614; bh=JmOtyj9GKM
	dPQf3jgL3fNBI9u8HjlJb4gaDQwYp11Co=; b=KGJyzwIa+OqP0okxGkiMtxEqog
	79MsuKpA8WemKXBntExxymZxAS5Ah5FASmv1B0vP0pJt24Sxa3SF0/Mpv+BVMOdV
	oiGeQv1MBQ2H7lQLlncPWtpLZuknjtrHxYFt39vr+PMgn0UGx8w85LNiviSLmaHX
	1BXxGdrzive9puix5wMgW+KuC6JgPdQ2ocGcSVHrsls2T+8HmR8sEbNOlaSAtVj7
	2/0pUcRZGAZXhd1OT0Qcg9BDS50lr36oxl8hvBmZN1D7HuPO151RjK9upbi2X4qc
	BXKpJ5djyBpxozj4jNvm00VziKlx5Zf2CdZIaTVHyQyTENZ4JoQGBzNLEUVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529214; x=1711615614; bh=JmOtyj9GKMdPQf3jgL3fNBI9u8Hj
	lJb4gaDQwYp11Co=; b=bWbvWj2mPhI+Xog7IejNszv80B+FtxpL8MrP6Z4VOU4C
	VjJSjoJsjsqYqOqYWT96B3Jq8oExxWtyxMFzTrNIx4yT2zeNPUnAfpdq5dWoQix/
	5kuUuHJYLU/A33DoM882zC89Zerf6z4bPhE3BvfxwJ7pwwf/I7DjoVSni0QrmGVd
	irwJ1k7GLatoPyEnFP0H5GW93kdaUY8/c9/bmHOsYzQOt/n0LCqVL1B+ZVh+xZNs
	pL1m2G0fKbVEf3rVLfhW2kv1iNWDXBEwC6vz5V01Vj3tWjoNtXoCjEJTMcRCGwrs
	NFaezpjdmj/voX+eQ1HvfF1V/7Y9SWZqeZ6p0wXr4w==
X-ME-Sender: <xms:_twDZlDCr0tz-QsgTUcE-K9RDaLaThYW3nT9OJERkcZWYW2eTjzjZQ>
    <xme:_twDZji4H-zO0XPWmhkjj7FwAr_2_SaPfATkS-1LpPY3_Fw35AzEfZQxXnP8aLxVH
    w2S6bdqZQm5AoFFVg>
X-ME-Received: <xmr:_twDZgkYBGSZmhS8-eAMBkRTonzMvtGnMLxr-JBRA4AmXhw-PPNdz4LZrN-elaimNAOCwAbfPeBWzfhXZPbKRk5xR-Se7nfXwitQbOYn6N4xhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:_twDZvy9hX7WKPbnSbiV5BXGR5YtxaCJA4hug2td799eFYVdniSG0A>
    <xmx:_twDZqQQNvCntvpcv0auoJWe8AtXNOwDRlPLm727unNii9rGV2lTrg>
    <xmx:_twDZiYKD-qDD1FWMCm_B4gYj8YyaBF9JGRm63bHzzmWBNILKjBlZQ>
    <xmx:_twDZrQHK-0_rljr0L9uPwIvt8yHnqe4vX5bICTwSsJ92lJx--4gKg>
    <xmx:_twDZnTAR59bngaRVXP5kAjBqI9JrpwyWdY-OV_BEiGGVaMI1HiYQQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:46:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3f36a74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:46:39 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:46:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/13] builtin/config: introduce "rename-section"
 subcommand
Message-ID: <3e360b1f47864ebe738889fd46ea414829f8daf4.1711527812.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b7hOoxLEMi5C2j8Y"
Content-Disposition: inline
In-Reply-To: <cover.1711527811.git.ps@pks.im>


--b7hOoxLEMi5C2j8Y
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
index 4fbc73a19e..0695eeae22 100644
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
@@ -318,6 +318,9 @@ recommended to migrate to the new syntax.
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
index c53b68887e..99d9ac6341 100644
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
index c9610a1f5b..4818c495bd 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -589,7 +589,7 @@ weird
 EOF
=20
 test_expect_success 'rename section' '
-	git config --rename-section branch.eins branch.zwei
+	git config ${mode_prefix}rename-section branch.eins branch.zwei
 '
=20
 cat > expect << EOF
@@ -608,7 +608,7 @@ test_expect_success 'rename succeeded' '
 '
=20
 test_expect_success 'rename non-existing section' '
-	test_must_fail git config --rename-section \
+	test_must_fail git config ${mode_prefix}rename-section \
 		branch."world domination" branch.drei
 '
=20
@@ -617,7 +617,7 @@ test_expect_success 'rename succeeded' '
 '
=20
 test_expect_success 'rename another section' '
-	git config --rename-section branch."1 234 blabl/a" branch.drei
+	git config ${mode_prefix}rename-section branch."1 234 blabl/a" branch.drei
 '
=20
 cat > expect << EOF
@@ -640,7 +640,7 @@ cat >> .git/config << EOF
 EOF
=20
 test_expect_success 'rename a section with a var on the same line' '
-	git config --rename-section branch.vier branch.zwei
+	git config ${mode_prefix}rename-section branch.vier branch.zwei
 '
=20
 cat > expect << EOF
@@ -661,11 +661,11 @@ test_expect_success 'rename succeeded' '
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
@@ -674,7 +674,7 @@ test_expect_success 'renaming a section with a long lin=
e' '
 		printf "  c =3D d %1024s [a] e =3D f\\n" " " &&
 		printf "[a] g =3D h\\n"
 	} >y &&
-	git config -f y --rename-section a xyz &&
+	git config ${mode_prefix}rename-section -f y a xyz &&
 	test_must_fail git config -f y b.e
 '
=20
@@ -684,7 +684,7 @@ test_expect_success 'renaming an embedded section with =
a long line' '
 		printf "  c =3D d %1024s [a] [foo] e =3D f\\n" " " &&
 		printf "[a] g =3D h\\n"
 	} >y &&
-	git config -f y --rename-section a xyz &&
+	git config ${mode_prefix}rename-section -f y a xyz &&
 	test_must_fail git config -f y foo.e
 '
=20
@@ -694,7 +694,7 @@ test_expect_success 'renaming a section with an overly-=
long line' '
 		printf "  c =3D d %525000s e" " " &&
 		printf "[a] g =3D h\\n"
 	} >y &&
-	test_must_fail git config -f y --rename-section a xyz 2>err &&
+	test_must_fail git config ${mode_prefix}rename-section -f y a xyz 2>err &&
 	grep "refusing to work with overly long line in .y. on line 2" err
 '
=20
@@ -1986,7 +1986,7 @@ test_expect_success POSIXPERM,PERL 'preserves existin=
g permissions' '
 	git config imap.pass Hunter2 &&
 	perl -e \
 	  "die q(badset) if ((stat(q(.git/config)))[2] & 07777) !=3D 0600" &&
-	git config --rename-section imap pop &&
+	git config ${mode_prefix}rename-section imap pop &&
 	perl -e \
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) !=3D 0600"
 '
@@ -2475,7 +2475,7 @@ test_expect_success 'refuse --fixed-value for incompa=
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
2.44.GIT


--b7hOoxLEMi5C2j8Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3PoACgkQVbJhu7ck
PpQY2A/9Fy1/lPly61hkM+cpGLG93QM6cpqcGg7r9XvbtmdMaQgpAhZH29pgNMSP
CobfyWyy6f6cf6kT5u4kGbOHHwWN6YkHx83MXovOs2PhK28JYRZ1WN73x98vroXO
PFx+BAQBr9NATmKTaEYYYZ6BPgw8N/0w5DL26zzuVGCqLE3celwGnad/rr7+TJTQ
CtqAYu+F0v+o9nBONVmQ/jVMx0LQ3kMr7gzJu2fjBsc5DDQ5+XnhjxCQK8XHQFVl
JDgMOcmR2lNtzm/Zv0lUfb++eI30doRJvJeV+QdesjwYM3TIWFVbWrnWWv/xspUt
43raWDwQSKB2hpM43YN1WC/Q33159V/YtWCub5KbUYL/ie0Q3MdB8zcWQWt4kqqp
D94PuAjllAfP/N3Zjjm4p0EoM8VMyWLX4UO+QTCMb6ACgFxv59UktGMwv7+gIgX2
pvgJea9ob8lCCzGHs23cLHDT8PObEYB6hqNrp1OPB9agQQbR6jc4r4dZHCmIap/0
UkYKrFNGfO8mqt5BD4r7ZbCuYaiEjSuZsT0FGePA/Vd9JQ7mbTlLu2lx43NtVXwq
oKfJpoxb8ELfpg9+9icFJ4gUg/GZM7vKY6LAL10pY0dm3IEtc1o2Z8yZ61dZqGi5
253gShtJEmoDkK2IZ5tmHNW/hhse/ZXH5D6+yeCJw16SQYRXNuM=
=vCjl
-----END PGP SIGNATURE-----

--b7hOoxLEMi5C2j8Y--
