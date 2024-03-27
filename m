Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6574F3839D
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529221; cv=none; b=LdIxUjZgP3WyCD2RVY+0oxgmg92i/rwbX0iSNLQdNgRddwpForWqRC5pnAgfM9hs7KUuk4eBqtFgKCeG1VKa+AKocHXyB7zn6HzZYnb46IkM7Yaf+zLgqxExddUYl5DZ/DA0Vm0HlLl8pW1gbTD1dRWjeQOkudDIpXPR7FHPUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529221; c=relaxed/simple;
	bh=0hZh4HvmpRkVKPbPbUdpoomP+SSkcRTYh1icR6JxZXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuONsJgtfbKS7kwy3BHtZCh5Nun//v/NioomTbkKg7l+Usla75X2Fa52DGeGzZKbNyPwrImCWKa3JtWID094xREADaw3xoMgQDtKB4WEfKkUBdUUQ7Fb4K3nPUV5AfqegMXDZ2G4dNEag/bgdGXCevlVbcL3f5giUWvdmuQTJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iAuIRxza; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hclJrOm0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iAuIRxza";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hclJrOm0"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7EC8F138015E;
	Wed, 27 Mar 2024 04:46:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Mar 2024 04:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529218; x=1711615618; bh=Fm5NvVRU2K
	UlKrHIrU3AIKavbMKok8AgdYtqodM2LpE=; b=iAuIRxza/35/5XVu0ZXX/RaRos
	ibIWFp3GWuaa48aOu55B9E6yScoPp3cLgsdJVnQQiiinUQzMlnDq3hPyigMdy2Nd
	ZteQeDEyAsU4azkv1TJPeFfQqKvhmnzAQQuf6x258YJdteGSGRkkYKGj6lPZjKFD
	qhnwDZJi4AlUxsA/F2lTZUfxq8uI8AdNVRO/oOWenJZinN/jyjKGOwAGInIPyzs7
	WJk5yU2P35EHNTTXnw+1uCLnIglDUxHQJGV+mvqNgNPLpKlseTRXMs70PM6qSSQw
	ld3G+5yDI/4/WujtBpEAciL/FRbKb8HabW0BAMPDL6uGlvdVxtXowtTiPj0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529218; x=1711615618; bh=Fm5NvVRU2KUlKrHIrU3AIKavbMKo
	k8AgdYtqodM2LpE=; b=hclJrOm0uzgGawxN2RDh04TVM2HQeGyypszpNQb3aRsv
	wlL/WhthFWzVW1Ol5Id5gylovr0GLsexkuhz/gd11+LSvFA9qnIbtC9qp7EZ5jJI
	7jPEAycG+Po1Ec9s67NzR54EsDijnP/FUU8tYJJkwF5ta+VfLVO7MFhUXhhgL+XL
	LlUsOCVzuPPx73u28+s3cTMTYgf7ppd5My7M1DfwMaNwrA0L24NeoOPVb9uc9I0L
	bGhvUUoVv2JpzFXwg/dTb223Tupc8kCjkc54QWPrNo8KPY2rWkERrRMbx4KLf4Vf
	DKCrREV6lsvzEvIcKdIbPMM3Nko7cp5n2Enshr+d9w==
X-ME-Sender: <xms:At0DZiO2kqMr0ETGTUBMtCl2VGzvEcZgp0SmplPaGdlPRhY4E2MEfg>
    <xme:At0DZg8bVf_r-6vDdAn8QKaK4GET_PE4vtM6xLx7kllOZ4OFYUpFut8lNoTykzlUS
    3VxTY409Dt1puduYg>
X-ME-Received: <xmr:At0DZpRXwBifeBmFGwRzTEi8feN7wTgXX4ZGgK7AmhLq0f-yVgnZW9HGYce6lLlN4WAxUTz2wZi7DZIZ9z01cSY8F9c_bhCp3BDsq-Dpl-TCOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:At0DZiuu57FqU9_YfOQagcJQZCrfJa3b4BmIO_Np_Cpx4dpP2YCqHw>
    <xmx:At0DZqeOB_yMXucun__STBGjLU66t0_suJoTRMHZmROPOBbWXm09-A>
    <xmx:At0DZm1jPO5caf30Jc2e9nZt1kuM6AtaYGAVzBySNiZSccoRnfiVOg>
    <xmx:At0DZu_UI1K1LVlCMQy_JmPkAAVXsE8lDTFQKbs2USIgTxCNsarWiQ>
    <xmx:At0DZguHB1SJk44upDj_pwC3is2V-F6hwZ_j-D_-eEOgl8i3Fd1l4A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:46:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 68c81058 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:46:43 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:46:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/13] builtin/config: introduce "remove-section"
 subcommand
Message-ID: <d610b5fda1c6e92cb5ecaf451e3f2c66a7253f73.1711527812.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9qwibRKgHcPGnEN3"
Content-Disposition: inline
In-Reply-To: <cover.1711527811.git.ps@pks.im>


--9qwibRKgHcPGnEN3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new "remove-section" subcommand to git-config(1). Please
refer to preceding commits regarding the motivation behind this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt | 11 +++++++----
 builtin/config.c             | 32 ++++++++++++++++++++++++++++++++
 t/t1300-config.sh            |  4 ++--
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 0695eeae22..b9ca5e83a2 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git config set' [<file-option>] [--type=3D<type>] [--all] [--value=3D<val=
ue>] [--fixed-value] <name> <value>
 'git config unset' [<file-option>] [--all] [--value=3D<value>] [--fixed-va=
lue] <name> <value>
 'git config rename-section' [<file-option>] <old-name> <new-name>
-'git config' [<file-option>] --remove-section <name>
+'git config remove-section' [<file-option>] <name>
 'git config' [<file-option>] --get-colorbool <name> [<stdout-is-tty>]
 'git config' [<file-option>] -e | --edit
=20
@@ -95,6 +95,9 @@ unset::
 rename-section::
 	Rename the given section to a new name.
=20
+remove-section::
+	Remove the given section from the configuration file.
+
 [[OPTIONS]]
 OPTIONS
 -------
@@ -180,9 +183,6 @@ See also <<FILES>>.
 	section in linkgit:gitrevisions[7] for a more complete list of
 	ways to spell blob names.
=20
---remove-section::
-	Remove the given section from the configuration file.
-
 --fixed-value::
 	When used with the `value-pattern` argument, treat `value-pattern` as
 	an exact string instead of a regular expression. This will restrict
@@ -321,6 +321,9 @@ recommended to migrate to the new syntax.
 --rename-section <old-name> <new-name>::
 	Replaced by `git config rename-section <old-name> <new-name>`.
=20
+--remove-section <name>::
+	Replaced by `git config remove-section <name>`.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
diff --git a/builtin/config.c b/builtin/config.c
index 99d9ac6341..6be6717f26 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -21,6 +21,7 @@ static const char *const builtin_config_usage[] =3D {
 	N_("git config set [<file-option>] [--type=3D<type>] [--all] [--value=3D<=
value>] [--fixed-value] <name> <value>"),
 	N_("git config unset [<file-option>] [--all] [--value=3D<value>] [--fixed=
-value] <name> <value>"),
 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
+	N_("git config remove-section [<file-option>] <name>"),
 	NULL
 };
=20
@@ -49,6 +50,11 @@ static const char *const builtin_config_rename_section_u=
sage[] =3D {
 	NULL
 };
=20
+static const char *const builtin_config_remove_section_usage[] =3D {
+	N_("git config remove-section [<file-option>] <name>"),
+	NULL
+};
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
@@ -971,12 +977,38 @@ static int cmd_config_rename_section(int argc, const =
char **argv, const char *pr
 	return 0;
 }
=20
+static int cmd_config_remove_section(int argc, const char **argv, const ch=
ar *prefix)
+{
+	struct option opts[] =3D {
+		CONFIG_LOCATION_OPTIONS,
+		OPT_END(),
+	};
+	int ret;
+
+	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_remove_se=
ction_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	check_write();
+	check_argc(argc, 1, 1);
+
+	handle_config_location(prefix);
+
+	ret =3D git_config_rename_section_in_file(given_config_source.file,
+						argv[0], NULL);
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
 	OPT_SUBCOMMAND("rename-section", &subcommand, cmd_config_rename_section),
+	OPT_SUBCOMMAND("remove-section", &subcommand, cmd_config_remove_section),
 	OPT_END(),
 };
=20
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 4818c495bd..2f8d0310b1 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -703,7 +703,7 @@ cat >> .git/config << EOF
 EOF
=20
 test_expect_success 'remove section' '
-	git config --remove-section branch.zwei
+	git config ${mode_prefix}remove-section branch.zwei
 '
=20
 cat > expect << EOF
@@ -2476,7 +2476,7 @@ test_expect_success 'refuse --fixed-value for incompa=
tible actions' '
 	test_must_fail git config --file=3Dconfig --fixed-value --get-urlmatch de=
v.null bogus &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-urlmatch de=
v.null bogus &&
 	test_must_fail git config ${mode_prefix}rename-section --file=3Dconfig --=
fixed-value dev null &&
-	test_must_fail git config --file=3Dconfig --fixed-value --remove-section =
dev &&
+	test_must_fail git config ${mode_prefix}remove-section --file=3Dconfig --=
fixed-value dev &&
 	test_must_fail git config ${mode_prefix}list --file=3Dconfig --fixed-valu=
e &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-color dev.n=
ull &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-colorbool d=
ev.null &&
--=20
2.44.GIT


--9qwibRKgHcPGnEN3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3P4ACgkQVbJhu7ck
PpQaww//ZlS0kmnTRKHig2XW5dMKG8KC1tG/p4RONWW+/JmzX8zDhpTuuNbzK7eC
RKSJPhNz7qhLwoSAqXO3Rzhz9zR7wGZSr/6F5hYGf6L10rWvdhAnA2O/Q4tu0hG8
zwohYz2Fv6nDKBB3ziZP2T2TyiVUvoHtAJZZ95XnAkE9UvX16xaa3lz/DNsLeC0K
yZNBOOrFsBL+VXEs4e2YnPjcxy5Yy95IhgKPIJUJTul+mpgWi7+QLzHvSKikGJYA
WEqVX/uLWoErX4XQnVEVKp2SLgmfTtkA4VDTtY7Xnu9AogyItBluoTciicvYvWuc
hKpRBlCgKqQ4vj+oag9q+k1wrWafePYQtKkLNJ0p7wwmB9NO6xIA33KDIoeTXAB3
+gJeOcLEytMjPsjJYyGGnigWqFiEIXjrxmq8xiX9cgI72rZXzFf5U/xNVSTOYSZ2
LTqgKu9JuuoO5IadJnS2sh5q4z7ZYzNtzIfRiOXA9/X1b9bOH1T0VdANlI9uBpuc
i/GHz9KdTLTyTnt/Q6m0NaX++sgqPmE/EsrccXa/wOSGi92mDooRcQrrXnxCG/6P
05tOr9k5arbRvl9djv/72MfPnqvz281YapFl3+3YRp7HckAFAS+fXFbLQPu6WY6V
3aKFIoOyRz/lCphbdutPIQ1gPyA3w3wyptfDpBJ+qeaMEvZ90Qs=
=vVrN
-----END PGP SIGNATURE-----

--9qwibRKgHcPGnEN3--
