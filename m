Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3892C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 12:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiKGMRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 07:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiKGMR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 07:17:29 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21F82DFC
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 04:17:20 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 35F41320093C;
        Mon,  7 Nov 2022 07:16:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Nov 2022 07:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667823398; x=1667909798; bh=0A6D7hEVAG
        +8j9RpLk+ViMLgYnswG2EeoIXxkwbMO5I=; b=J201j7mi+QWEz7g7N+0/r32T75
        ga8B9Wrg09C15w3IpJPbp8Ss1kdoLXS9zZbupPQgWdjj3R0PrWA//ByYAVf5OCni
        aFlTL73nUTweDRm/8u1xnogg6w/n6CyA++ZxQL7UK9ZR1ijvaGIUMae3RLbsJcd3
        wnNDWpmfyFdezC5v/ponPFPBUoIy0wURc0PgrBRZ6Ohw1pqvDZHG/0SFBi2RJG2s
        25wT3ErDEswsb6TVP+vKykEtQisnHIxgIVqf4auWbsEBqnj4gBmsv9XgiKjC5xXI
        wY4nn/7Dq13Zq9amTPmxSRS/PpslCL/yd12mTrdOT0PIHsGFft1I0JyecJdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667823398; x=1667909798; bh=0A6D7hEVAG+8j9RpLk+ViMLgYnsw
        G2EeoIXxkwbMO5I=; b=r2lbFOTcdekBE/k7V+wOV9yTV0hGz2/rsrGU3sUPwBJb
        JuqiSoV1z4ObogCi8zk5AAUqX7tXVvIj16EnBN3/3ZLI1RMwFqVMYrgZJ7YDlXtu
        vBA2+Schr8DFRZTmYn6pACAaFeO3A+kBDsbqtdhTY73yAT+uuKGcIaUnIBOimWaE
        jqcunxZBW1LjJ2LVoUq4zdB/gTKAerhQrxZiDQIIgWRZfNNv2taHEDMIfcMI46u8
        rlVlZ3x5h0BTPfjsezSUa+PzvG1LvgOk034oPNy85jbRTfCZ1fQMHcbP1muDVj0y
        VNSWIQDE60oujsORDCvkcPSW1N9zcmbw4Nvvn6xNag==
X-ME-Sender: <xms:JvdoYyvXmkKxkvmJf81M50_o3V7J568bfl6Mc36TKhrFE0Wg-BlTGA>
    <xme:JvdoY3db2GYMygrhxAA3yUfTaGsOCu30EGLtV_ppy9_GR3XGGf7n5GEBe7UK6085A
    bwCEEeKPK7LVLtC2g>
X-ME-Received: <xmr:JvdoY9wzYKfj4FnNQE_Yl9E91ao0C5FlCDcpdovvcyEAlpe0lpMQ4yaZqIRcbqp7MewkrRarNj00yD6iXCNdmMJMmvnmv-dyGgZiy7z6fmI_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JvdoY9MoQY5IFMDlgxcxhfm1uaMRoBJnhi7RdPADeXAnabOYYv5NrA>
    <xmx:JvdoYy-4M_XFrsWcNbFx5Hb5lU2s9lUd87cOJybZqLSkhlgeUGAzNQ>
    <xmx:JvdoY1VCuuzZlmya3INMpzvVhXa_RnIAtaX84l3IB-c3KHn2mOAxGA>
    <xmx:JvdoY5a9Jnr-ifWvNCuGnm9vn65dmck1KnPEkr3ZinSpCjcsL3U3WA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 07:16:37 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id d5391083 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 7 Nov 2022 12:16:34 +0000 (UTC)
Date:   Mon, 7 Nov 2022 13:16:35 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 4/6] revision: add new parameter to exclude hidden refs
Message-ID: <de7c1aa210c2df9bdbbb6c19f44f72c37f56c5da.1667823042.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LJ+AdIDpjhLiQR5N"
Content-Disposition: inline
In-Reply-To: <cover.1667823042.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LJ+AdIDpjhLiQR5N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Users can optionally hide refs from remote users in git-upload-pack(1),
git-receive-pack(1) and others via the `transfer.hideRefs`, but there is
not an easy way to obtain the list of all visible or hidden refs right
now. We'll require just that though for a performance improvement in our
connectivity check.

Add a new option `--exclude-hidden=3D` that excludes any hidden refs from
the next pseudo-ref like `--all` or `--branches`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/rev-list-options.txt |   7 ++
 builtin/rev-list.c                 |   1 +
 revision.c                         |  43 +++++++-
 revision.h                         |   9 +-
 t/t6021-rev-list-exclude-hidden.sh | 159 +++++++++++++++++++++++++++++
 5 files changed, 217 insertions(+), 2 deletions(-)
 create mode 100755 t/t6021-rev-list-exclude-hidden.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-op=
tions.txt
index 1837509566..a178956613 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -195,6 +195,13 @@ respectively, and they must begin with `refs/` when ap=
plied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
=20
+--exclude-hidden=3D[transfer|receive|uploadpack]::
+	Do not include refs that have been hidden via either one of
+	`transfer.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs` that
+	the next `--all`, `--branches`, `--tags`, `--remotes` or `--glob` would
+	otherwise consider.  This option is cleared when seeing one of these
+	pseudo-refs.
+
 --reflog::
 	Pretend as if all objects mentioned by reflogs are listed on the
 	command line as `<commit>`.
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3acd93f71e..9eace06385 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -38,6 +38,7 @@ static const char rev_list_usage[] =3D
 "    --tags\n"
 "    --remotes\n"
 "    --stdin\n"
+"    --exclude-hidden=3D[transfer|receive|uploadpack]\n"
 "    --quiet\n"
 "  ordering output:\n"
 "    --topo-order\n"
diff --git a/revision.c b/revision.c
index e5eaaa24ba..45652f9b0b 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "object-store.h"
 #include "tag.h"
 #include "blob.h"
@@ -1519,22 +1520,30 @@ static void add_rev_cmdline_list(struct rev_info *r=
evs,
=20
 int ref_excluded(const struct ref_exclusions *exclusions, const char *path)
 {
+	const char *stripped_path =3D strip_namespace(path);
 	struct string_list_item *item;
+
 	for_each_string_list_item(item, &exclusions->excluded_refs) {
 		if (!wildmatch(item->string, path, 0))
 			return 1;
 	}
+
+	if (ref_is_hidden(stripped_path, path, &exclusions->hidden_refs))
+		return 1;
+
 	return 0;
 }
=20
 void init_ref_exclusions(struct ref_exclusions *exclusions)
 {
 	string_list_init_dup(&exclusions->excluded_refs);
+	string_list_init_dup(&exclusions->hidden_refs);
 }
=20
 void clear_ref_exclusions(struct ref_exclusions *exclusions)
 {
 	string_list_clear(&exclusions->excluded_refs, 0);
+	string_list_clear(&exclusions->hidden_refs, 1);
 }
=20
 void add_ref_exclusion(struct ref_exclusions *exclusions, const char *excl=
ude)
@@ -1542,6 +1551,35 @@ void add_ref_exclusion(struct ref_exclusions *exclus=
ions, const char *exclude)
 	string_list_append(&exclusions->excluded_refs, exclude);
 }
=20
+struct exclude_hidden_refs_cb {
+	struct ref_exclusions *exclusions;
+	const char *section;
+};
+
+static int hide_refs_config(const char *var, const char *value, void *cb_d=
ata)
+{
+	struct exclude_hidden_refs_cb *cb =3D cb_data;
+	return parse_hide_refs_config(var, value, cb->section,
+				      &cb->exclusions->hidden_refs);
+}
+
+void exclude_hidden_refs(struct ref_exclusions *exclusions, const char *se=
ction)
+{
+	struct exclude_hidden_refs_cb cb;
+
+	if (strcmp(section, "transfer") && strcmp(section, "receive") &&
+	    strcmp(section, "uploadpack"))
+		die(_("unsupported section for hidden refs: %s"), section);
+
+	if (exclusions->hidden_refs.nr)
+		die(_("--exclude-hidden=3D passed more than once"));
+
+	cb.exclusions =3D exclusions;
+	cb.section =3D section;
+
+	git_config(hide_refs_config, &cb);
+}
+
 struct all_refs_cb {
 	int all_flags;
 	int warned_bad_reflog;
@@ -2220,7 +2258,7 @@ static int handle_revision_opt(struct rev_info *revs,=
 int argc, const char **arg
 	    !strcmp(arg, "--bisect") || starts_with(arg, "--glob=3D") ||
 	    !strcmp(arg, "--indexed-objects") ||
 	    !strcmp(arg, "--alternate-refs") ||
-	    starts_with(arg, "--exclude=3D") ||
+	    starts_with(arg, "--exclude=3D") || starts_with(arg, "--exclude-hidde=
n=3D") ||
 	    starts_with(arg, "--branches=3D") || starts_with(arg, "--tags=3D") ||
 	    starts_with(arg, "--remotes=3D") || starts_with(arg, "--no-walk=3D"))
 	{
@@ -2709,6 +2747,9 @@ static int handle_revision_pseudo_opt(struct rev_info=
 *revs,
 	} else if ((argcount =3D parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
 		return argcount;
+	} else if ((argcount =3D parse_long_opt("exclude-hidden", argv, &optarg))=
) {
+		exclude_hidden_refs(&revs->ref_excludes, optarg);
+		return argcount;
 	} else if (skip_prefix(arg, "--branches=3D", &optarg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
diff --git a/revision.h b/revision.h
index 87d6824c55..fef5e063d1 100644
--- a/revision.h
+++ b/revision.h
@@ -87,6 +87,12 @@ struct ref_exclusions {
 	 * patterns matches, the reference will be excluded.
 	 */
 	struct string_list excluded_refs;
+
+	/*
+	 * Hidden refs is a list of patterns that is to be hidden via
+	 * `ref_is_hidden()`.
+	 */
+	struct string_list hidden_refs;
 };
=20
 struct oidset;
@@ -449,12 +455,13 @@ void show_object_with_name(FILE *, struct object *, c=
onst char *);
 /**
  * Helpers to check if a reference should be excluded.
  */
-#define REF_EXCLUSIONS_INIT { .excluded_refs =3D STRING_LIST_INIT_DUP }
+#define REF_EXCLUSIONS_INIT { .excluded_refs =3D STRING_LIST_INIT_DUP, .hi=
dden_refs =3D STRING_LIST_INIT_DUP }
=20
 int ref_excluded(const struct ref_exclusions *exclusions, const char *path=
);
 void init_ref_exclusions(struct ref_exclusions *);
 void clear_ref_exclusions(struct ref_exclusions *);
 void add_ref_exclusion(struct ref_exclusions *, const char *exclude);
+void exclude_hidden_refs(struct ref_exclusions *, const char *section);
=20
 /**
  * This function can be used if you want to add commit objects as revision
diff --git a/t/t6021-rev-list-exclude-hidden.sh b/t/t6021-rev-list-exclude-=
hidden.sh
new file mode 100755
index 0000000000..d08fc2da93
--- /dev/null
+++ b/t/t6021-rev-list-exclude-hidden.sh
@@ -0,0 +1,159 @@
+#!/bin/sh
+
+test_description=3D'git rev-list --exclude-hidden test'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit_bulk --id=3Dcommit --ref=3Drefs/heads/main 1 &&
+	COMMIT=3D$(git rev-parse refs/heads/main) &&
+	test_commit_bulk --id=3Dtag --ref=3Drefs/tags/lightweight 1 &&
+	TAG=3D$(git rev-parse refs/tags/lightweight) &&
+	test_commit_bulk --id=3Dhidden --ref=3Drefs/hidden/commit 1 &&
+	HIDDEN=3D$(git rev-parse refs/hidden/commit) &&
+	test_commit_bulk --id=3Dnamespace --ref=3Drefs/namespaces/namespace/refs/=
namespaced/commit 1 &&
+	NAMESPACE=3D$(git rev-parse refs/namespaces/namespace/refs/namespaced/com=
mit)
+'
+
+test_expect_success 'invalid section' '
+	echo "fatal: unsupported section for hidden refs: unsupported" >expected =
&&
+	test_must_fail git rev-list --exclude-hidden=3Dunsupported 2>err &&
+	test_cmp expected err
+'
+
+test_expect_success 'passed multiple times' '
+	echo "fatal: --exclude-hidden=3D passed more than once" >expected &&
+	test_must_fail git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude=
-hidden=3Dtransfer --exclude-hidden=3Dtransfer 2>err &&
+	test_cmp expected err
+'
+
+test_expect_success '--exclude-hidden without hiddenRefs' '
+	git rev-list --exclude-hidden=3Dtransfer --all >out &&
+	cat >expected <<-EOF &&
+	$NAMESPACE
+	$HIDDEN
+	$TAG
+	$COMMIT
+	EOF
+	test_cmp expected out
+'
+
+test_expect_success 'hidden via transfer.hideRefs' '
+	git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude-hidden=3Dtrans=
fer --all >out &&
+	cat >expected <<-EOF &&
+	$NAMESPACE
+	$TAG
+	$COMMIT
+	EOF
+	test_cmp expected out
+'
+
+test_expect_success '--all --exclude-hidden=3Dtransfer --not --all without=
 hidden refs' '
+	git rev-list --all --exclude-hidden=3Dtransfer --not --all >out &&
+	test_must_be_empty out
+'
+
+test_expect_success '--all --exclude-hidden=3Dtransfer --not --all with hi=
dden ref' '
+	git -c transfer.hideRefs=3Drefs/hidden/ rev-list --all --exclude-hidden=
=3Dtransfer --not --all >out &&
+	cat >expected <<-EOF &&
+	$HIDDEN
+	EOF
+	test_cmp expected out
+'
+
+test_expect_success '--exclude-hidden with --exclude' '
+	git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude=3Drefs/tags/* =
--exclude-hidden=3Dtransfer --all >out &&
+	cat >expected <<-EOF &&
+	$NAMESPACE
+	$COMMIT
+	EOF
+	test_cmp expected out
+'
+
+test_expect_success '--exclude-hidden is reset' '
+	git -c transfer.hideRefs=3Drefs/ rev-list --exclude-hidden=3Dtransfer --a=
ll --all >out &&
+	cat >expected <<-EOF &&
+	$NAMESPACE
+	$HIDDEN
+	$TAG
+	$COMMIT
+	EOF
+	test_cmp expected out
+'
+
+test_expect_success '--exclude-hidden operates on stripped refs by default=
' '
+	GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3Drefs/namespaced/ rev=
-list --exclude-hidden=3Dtransfer --all >out &&
+	cat >expected <<-EOF &&
+	$HIDDEN
+	$TAG
+	$COMMIT
+	EOF
+	test_cmp expected out
+'
+
+test_expect_success '--exclude-hidden does not hide namespace by default' '
+	GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3Drefs/namespaces/name=
space/ rev-list --exclude-hidden=3Dtransfer --all >out &&
+	cat >expected <<-EOF &&
+	$NAMESPACE
+	$HIDDEN
+	$TAG
+	$COMMIT
+	EOF
+	test_cmp expected out
+'
+
+test_expect_success '--exclude-hidden=3D may operate on unstripped refs' '
+	GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3D^refs/namespaces/nam=
espace/ rev-list --exclude-hidden=3Dtransfer --all >out &&
+	cat >expected <<-EOF &&
+	$HIDDEN
+	$TAG
+	$COMMIT
+	EOF
+	test_cmp expected out
+'
+
+for section in receive uploadpack
+do
+	test_expect_success "hidden via $section.hideRefs" '
+		git -c $section.hideRefs=3Drefs/hidden/ rev-list --exclude-hidden=3D$sec=
tion --all >out &&
+		cat >expected <<-EOF &&
+		$NAMESPACE
+		$TAG
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "--exclude-hidden=3D$section respects transfer.hideRe=
fs" '
+		git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude-hidden=3D$sec=
tion --all >out &&
+		cat >expected <<-EOF &&
+		$NAMESPACE
+		$TAG
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "--exclude-hidden=3Dtransfer ignores $section.hideRef=
s" '
+		git -c $section.hideRefs=3Drefs/hidden/ rev-list --exclude-hidden=3Dtran=
sfer --all >out &&
+		cat >expected <<-EOF &&
+		$NAMESPACE
+		$HIDDEN
+		$TAG
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "--exclude-hidden=3D$section respects both transfer.h=
ideRefs and $section.hideRefs" '
+		git -c transfer.hideRefs=3Drefs/tags/ -c $section.hideRefs=3Drefs/hidden=
/ rev-list --exclude-hidden=3D$section --all >out &&
+		cat >expected <<-EOF &&
+		$NAMESPACE
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+done
+
+test_done
--=20
2.38.1


--LJ+AdIDpjhLiQR5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNo9yIACgkQVbJhu7ck
PpSsKxAAgbro7+Cg9yiCSfUzWvEpm4QP653lWMOdOlSDYWETzlNyw3Sm3V9aD4IF
DPhagFlYaVwL6LtC2OEqFtlDjpgTYiAOcs7mNPL9vxzD/JqYcTmaQt+vhU+IqEeb
RGscBou5tvb1XZbhXWgzcbuR1ihRSBF/NFwAUpv9sjDSfPaXBSkmgQYvH0cdKlxm
n170e5jfUmF8RV/By838gBTmBcIfFxJ8muvaclXPOJxsmIjyj1oj4SffPYFbgzdt
oDGhqtu22/3y0eWWdJhG932tCNKo12T1ie/8QbeCih48Q2q4SHNge8oKYNBZCXvw
IDI0Pbl+qZKNA43acdxea3PPDAE7WGysUITTn+G/LQcBfU1BpQmTEffm012zB/Aa
jldR0wlY2yvSHbBM+HcfQEDRmgG1+H6ofWQ90Gt3QqnOkkCwpuZWLWGR0DGfAshL
Llg6CwAButGtTK6wWPHbQ6p+GYN5BlVOsbwYB3OuDYzq3aWmKoFH/kLHFZaEtUw3
tl8IRpBdwr1PIA1czjQHnZkZ5pUD27/zjQHkohy/rLRc2KM5TyTcgCfhQ9914Xlc
XFbJNj+NKfw1br5U1HmPnnR4NYXL7fdrvD3ttQYCpg5DT5vqheFwn/uloxxkaoZL
RiurMwbu9xZ0e6OvgFIIrlSEs+GRInLWzLzH0pdZBDUqAlks2gc=
=q8WI
-----END PGP SIGNATURE-----

--LJ+AdIDpjhLiQR5N--
