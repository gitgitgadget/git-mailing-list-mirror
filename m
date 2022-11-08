Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23562C4167B
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 10:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiKHKEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiKHKD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 05:03:56 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FD817AB8
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 02:03:55 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1873A5C0135;
        Tue,  8 Nov 2022 05:03:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 08 Nov 2022 05:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667901835; x=1667988235; bh=SIXamLHN18
        Z2W0UoAZn8tvn3XoSZIzXUcVGjZVXKAew=; b=C/h3hI5ZD0lZCudjhZnVbwnmV3
        llVXGfb/dP3RzYvLaCnilIJysAWJ1BVzYAWzRxnKbL6hBMJ5F3MAxzKtsWoB6lPn
        LDRZAgWocDPOm8/qKf2ECpxdWl5uvRCrvlzofmHZvbdJdNxW5QjceZF4KCsAhz4y
        CPw42qdJOrpwNQ4WtPKSDuG7K7tg/lBDtd7WgxkRU2RBWws+QaxU4PtPUioxKQDn
        e7F/D0O/8jDWRlJXoUWun8vWBfp82xkaUgcmkXAPotO0Lm2XtumE/o/5KZsuAXkc
        XNCGy7fgjH5OWqsFE9D3DKcw4soyHlzA0JfKwbNYnWacfeAvf71heyIMVLyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667901835; x=1667988235; bh=SIXamLHN18Z2W0UoAZn8tvn3XoSZ
        IzXUcVGjZVXKAew=; b=F+aFFP4bn48+WxtE0cVmqeDwsRhh/FbdBDL4FoSxX5vV
        5c6NSSOhIXMcf/Z33bI0cNVMav/vXuOHVXEdsKdysHx6OY9Q18bmNQ1suzG/PfFC
        wFaJbIAFTCO2fNu5Ws3vyNBG4LApShUpy34OVCgeADkkdq7Ml0U7VKf+xDmWZYH/
        Fog7JUHLz44/P1XAZ9B+Aa5KK1wjN9TOhxEujR7nX3DZessfhf0CILJaOdK5+kEo
        3k+/jy/TBxBvedEBWA0ByPsrCc6dXDpnLkEaOnrhYMPHkVmJx4caYs07UfnWzZkn
        fG6XKmBlJFdrHRs7d1k1OYSmNQEb1AkuIgxjPxiQow==
X-ME-Sender: <xms:iilqY0AElZ2F7_eUeongKRzDb5PYKTOcaftyn-yDgvGgMzJYO97B4Q>
    <xme:iilqY2hrOq2fqk0WUCMQNBb5rEvm_Zw6VBcegssFuEBolbAP1kK-i-qFJ5F0mEPe5
    VYCPKIdp9ssPnplwQ>
X-ME-Received: <xmr:iilqY3mDn2l-5uSjoAsg_cSH2lFanCmkBmsAHzeBpxPNdRPvxyS8zFiX_HWtfFidPCwTBlQ_zBBQykg2mDKiWIocnFHc7AJoIfOtZDX44wlz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedtgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:iilqY6wcea9EU7Xjrh0jB4wmGfBjt36f_2X_I17E7V3Sujmqt-1eew>
    <xmx:iilqY5SBJ1l_hWx_yS6D36ybL4gTe_MWjbGO0ivddzJ6kvb3xOfGsg>
    <xmx:iilqY1bAk8HlcFSaSA1HrZAoRH_xugtuBF2ceXGtS1p3ELFbd1SdwA>
    <xmx:iylqY7eal9RgqzRVxwlaEenjKRpZMr44QkQYHKpnOsRxXt1AwPEAYg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 05:03:53 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 02d3bc36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 10:03:48 +0000 (UTC)
Date:   Tue, 8 Nov 2022 11:03:51 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 4/6] revision: add new parameter to exclude hidden refs
Message-ID: <c7fa6698dbe7b0eb5e2b9c4725e9bdc6cdb22983.1667901510.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667901510.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y7j1AyStsYahsk2L"
Content-Disposition: inline
In-Reply-To: <cover.1667901510.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Y7j1AyStsYahsk2L
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
 revision.c                         |  41 ++++++++-
 revision.h                         |   9 ++
 t/t6021-rev-list-exclude-hidden.sh | 137 +++++++++++++++++++++++++++++
 5 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100755 t/t6021-rev-list-exclude-hidden.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-op=
tions.txt
index 1837509566..5b46781b35 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -195,6 +195,13 @@ respectively, and they must begin with `refs/` when ap=
plied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
=20
+--exclude-hidden=3D[receive|uploadpack]::
+	Do not include refs that have been hidden via either one of
+	`receive.hideRefs` or `uploadpack.hideRefs` (see linkgit:git-config[1])
+	that the next `--all`, `--branches`, `--tags`, `--remotes` or `--glob`
+	would otherwise consider. This option is cleared when seeing one of
+	these pseudo-refs.
+
 --reflog::
 	Pretend as if all objects mentioned by reflogs are listed on the
 	command line as `<commit>`.
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3acd93f71e..d42db0b0cc 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -38,6 +38,7 @@ static const char rev_list_usage[] =3D
 "    --tags\n"
 "    --remotes\n"
 "    --stdin\n"
+"    --exclude-hidden=3D[receive|uploadpack]\n"
 "    --quiet\n"
 "  ordering output:\n"
 "    --topo-order\n"
diff --git a/revision.c b/revision.c
index fe3ec98f46..b726cfd255 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "object-store.h"
 #include "tag.h"
 #include "blob.h"
@@ -1519,11 +1520,17 @@ static void add_rev_cmdline_list(struct rev_info *r=
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
@@ -1536,6 +1543,7 @@ void init_ref_exclusions(struct ref_exclusions *exclu=
sions)
 void clear_ref_exclusions(struct ref_exclusions *exclusions)
 {
 	string_list_clear(&exclusions->excluded_refs, 0);
+	string_list_clear(&exclusions->hidden_refs, 0);
 }
=20
 void add_ref_exclusion(struct ref_exclusions *exclusions, const char *excl=
ude)
@@ -1543,6 +1551,34 @@ void add_ref_exclusion(struct ref_exclusions *exclus=
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
+	if (strcmp(section, "receive") && strcmp(section, "uploadpack"))
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
@@ -2221,7 +2257,7 @@ static int handle_revision_opt(struct rev_info *revs,=
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
@@ -2710,6 +2746,9 @@ static int handle_revision_pseudo_opt(struct rev_info=
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
index 5c8ab16047..a96fefebf1 100644
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
 /**
@@ -94,6 +100,7 @@ struct ref_exclusions {
  */
 #define REF_EXCLUSIONS_INIT { \
 	.excluded_refs =3D STRING_LIST_INIT_DUP, \
+	.hidden_refs =3D STRING_LIST_INIT_DUP, \
 }
=20
 struct oidset;
@@ -456,10 +463,12 @@ void show_object_with_name(FILE *, struct object *, c=
onst char *);
 /**
  * Helpers to check if a reference should be excluded.
  */
+
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
index 0000000000..4ab50e7f4f
--- /dev/null
+++ b/t/t6021-rev-list-exclude-hidden.sh
@@ -0,0 +1,137 @@
+#!/bin/sh
+
+test_description=3D'git rev-list --exclude-hidden test'
+
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
+for section in receive uploadpack
+do
+	test_expect_success "$section: passed multiple times" '
+		echo "fatal: --exclude-hidden=3D passed more than once" >expected &&
+		test_must_fail git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclud=
e-hidden=3D$section --exclude-hidden=3D$section 2>err &&
+		test_cmp expected err
+	'
+
+	test_expect_success "$section: without hiddenRefs" '
+		git rev-list --exclude-hidden=3D$section --all >out &&
+		cat >expected <<-EOF &&
+		$NAMESPACE
+		$HIDDEN
+		$TAG
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "$section: hidden via transfer.hideRefs" '
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
+	test_expect_success "$section: hidden via $section.hideRefs" '
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
+	test_expect_success "$section: respects both transfer.hideRefs and $secti=
on.hideRefs" '
+		git -c transfer.hideRefs=3Drefs/tags/ -c $section.hideRefs=3Drefs/hidden=
/ rev-list --exclude-hidden=3D$section --all >out &&
+		cat >expected <<-EOF &&
+		$NAMESPACE
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "$section: negation without hidden refs marks everyth=
ing as uninteresting" '
+		git rev-list --all --exclude-hidden=3D$section --not --all >out &&
+		test_must_be_empty out
+	'
+
+	test_expect_success "$section: negation with hidden refs marks them as in=
teresting" '
+		git -c transfer.hideRefs=3Drefs/hidden/ rev-list --all --exclude-hidden=
=3D$section --not --all >out &&
+		cat >expected <<-EOF &&
+		$HIDDEN
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "$section: hidden refs and excludes work together" '
+		git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude=3Drefs/tags/*=
 --exclude-hidden=3D$section --all >out &&
+		cat >expected <<-EOF &&
+		$NAMESPACE
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "$section: excluded hidden refs get reset" '
+		git -c transfer.hideRefs=3Drefs/ rev-list --exclude-hidden=3D$section --=
all --all >out &&
+		cat >expected <<-EOF &&
+		$NAMESPACE
+		$HIDDEN
+		$TAG
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "$section: operates on stripped refs by default" '
+		GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3Drefs/namespaced/ re=
v-list --exclude-hidden=3D$section --all >out &&
+		cat >expected <<-EOF &&
+		$HIDDEN
+		$TAG
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "$section: does not hide namespace by default" '
+		GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3Drefs/namespaces/nam=
espace/ rev-list --exclude-hidden=3D$section --all >out &&
+		cat >expected <<-EOF &&
+		$NAMESPACE
+		$HIDDEN
+		$TAG
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "$section: can operate on unstripped refs" '
+		GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3D^refs/namespaces/na=
mespace/ rev-list --exclude-hidden=3D$section --all >out &&
+		cat >expected <<-EOF &&
+		$HIDDEN
+		$TAG
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+done
+
+test_done
--=20
2.38.1


--Y7j1AyStsYahsk2L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNqKYYACgkQVbJhu7ck
PpR4YA//Tj3FyON+F/FhLIt1UiogXpaZjF+lDZtM60nMBrMlMcVT5BzhEES8g6s8
/floNHUOKAGrQpXOwl4WjoBJzXbuF/EblGewyN4GEHZtEUTe4ErC0MDeadoSZYL0
QI8dYVpefqf8sGvAC+zAvztowmRcGMfeFWv335d6OaIFc1XTNiGD2TuVociqv4pe
5moKK3+XN/oseEvKmVCGCTGxMI/64udEWxb/9gvSTSn+RrIAWmhTcNGUHhNdnCOP
9Iwh+fY+A5e+sS2GIKpdFGa6Fx3MOPG+tzqbguVJ2pK4ZwhkwWxlL2kJNf/cNJiR
e/w7fLdSAp+OdCLicBE5EB4S7Oh09QduHzxHzsaTqPSL3sRWZqpdyX32gN25h5oj
1+aoXqt5O0DVOZ5YiKUG855JQYG6nBrO/Xo6ff78wiw0LqlCA7KCtAOT2sQdrVW4
lW3LcXD2jgBbY03lVsTnx90STOEN1k7SSZlhaRF50I5FBR3w6Ge7RlkoUVbPEBaf
dpJLmotFa7SNMVRAuH2Mlqawmo0ofvUeIJRh/U2LdueGzKHGYMVK7JG8ghv4sEh7
9SJJ0dtQAQF/GxQrjGuu4FbMiRqiE2f0o3TohYTb24IdIzYx7+9E4ijaWyQMDr20
QNjyCfmtFnS+wGCZMok9yBSWQQ+g4zCd9n6NmDti7YQlnV1GVKU=
=IdiJ
-----END PGP SIGNATURE-----

--Y7j1AyStsYahsk2L--
