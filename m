Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D87C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 05:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbiKQFrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 00:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbiKQFrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 00:47:32 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4465766CAA
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 21:47:00 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A980F3201B64;
        Thu, 17 Nov 2022 00:46:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Nov 2022 00:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668664019; x=1668750419; bh=balop0vbgh
        TdhRMvhZbnixgP37p4OA2HhHDTZwWOSzE=; b=U/xK2K6dJTGkOhWtGObxIEo9ey
        QGc6Hifs9giKgrMksc+vrkTZGxTQjiaCiNNxX6fKiopRJuF58Ea/Q6ZiMB3Y2oqz
        vNZVOlH+eEyhgbG4362YDO4/Xg1VChq8vZEe6YExM6fITJapn0TINm9LgK08/8ZM
        eIth5YMg+N4CjP2f8zcghuq8ylLJjeWVIGxY2NV2Tr191LtBo++ZK4buy4dHhBYi
        IgGs8Wt9KQ4b5nVHLXR0G7Mtr9V1oCXLaLuycB+DPTqGY6voZmZjZOHl86v88o0v
        yjnjweVpFvyBxzdgrkLqGemtGEYJrdG525qs9BCmByMGF8P0W7qTwEldR3Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668664019; x=1668750419; bh=balop0vbghTdhRMvhZbnixgP37p4
        OA2HhHDTZwWOSzE=; b=sYduqftH2DCLM39Zdk44ZVoTxUR1Q+9ATu4Z7ErEyzbT
        R6/3gVi92G5OM7SB3zY5WjKnZE4SZaKCC4W6JQfCiqqltEEtMa/IwPQReAv/WJIo
        IVCWGt7jxH7aSRhTWNHklccRJYEJGBc7Uf4WctGZJKPnic3Sb1io7lQvCJxtkJe2
        fIlNX4iCQ0IgDa7s+ozHBuB6kOp908zJ9MC/vvtjXD5UyeicFVtyngTglTIq9q1w
        fgXo/IGJv/uPv/4/Iqny+/DvC7l8s4cYwq33UxDcQNWY644+OH0VNr4ByAxufqQy
        tpwHQtNtYxleSyvJNhs73t5YIOydj1yegwC9rR3+MQ==
X-ME-Sender: <xms:08p1Y_VwX7fygG5DuuQANHMFmGJ1n2VI4PF-WIz8tn_Gah3GKQ2B8w>
    <xme:08p1Y3lS8bINCppcLMaHh0HKVfZRTD-8KZ2HuEADKa0stP7wc97SqWYe4z1l0jzA0
    7MX6FxPvpSyR-Qk9Q>
X-ME-Received: <xmr:08p1Y7Yrxe1VyxSaIPRe_AVTE1F1Vxn3l2ABv3OFq1RQUBa-0oFWz5uzFt-rw3xc0gKlobTMgDq14ahho7YKXWzK7gmUC5Q15y_yR0Dzj2FKCJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:08p1Y6WM5MbUlSl4Jw3n6No2aSw9c1bpvIZFj6c-MdfmSDa5vpjwDQ>
    <xmx:08p1Y5nkCwCOP7uCbEGLKILF0SxGw-s09J0Z-AaCJ3nV07TnI-nLaw>
    <xmx:08p1Y3dnZKCeBfOscTc9OCE0R9MsoUM-hAXIIFUvpo5zZ8b4gIe0ag>
    <xmx:08p1Y_ikD8wNVU-ewa3u1AJYocp_9caOxCldk8T8kO_tCulbrEK6mw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 00:46:57 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 76a5a5de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Nov 2022 05:46:43 +0000 (UTC)
Date:   Thu, 17 Nov 2022 06:46:56 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 5/7] revision: add new parameter to exclude hidden refs
Message-ID: <d86a3342f61e2f44c976f379aea4a3463fb6fd98.1668663796.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668663795.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JYJt8rvo33GkNFRB"
Content-Disposition: inline
In-Reply-To: <cover.1668663795.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JYJt8rvo33GkNFRB
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
 revision.c                         |  55 +++++++++-
 revision.h                         |  16 +++
 t/t6021-rev-list-exclude-hidden.sh | 163 +++++++++++++++++++++++++++++
 5 files changed, 241 insertions(+), 1 deletion(-)
 create mode 100755 t/t6021-rev-list-exclude-hidden.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-op=
tions.txt
index 1837509566..ff68e48406 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -195,6 +195,13 @@ respectively, and they must begin with `refs/` when ap=
plied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
=20
+--exclude-hidden=3D[receive|uploadpack]::
+	Do not include refs that would be hidden by `git-receive-pack` or
+	`git-upload-pack` by consulting the appropriate `receive.hideRefs` or
+	`uploadpack.hideRefs` configuration along with `transfer.hideRefs` (see
+	linkgit:git-config[1]). This option affects the next pseudo-ref option
+	`--all` or `--glob` and is cleared after processing them.
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
index fe3ec98f46..bc32fb819a 100644
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
@@ -1536,6 +1543,8 @@ void init_ref_exclusions(struct ref_exclusions *exclu=
sions)
 void clear_ref_exclusions(struct ref_exclusions *exclusions)
 {
 	string_list_clear(&exclusions->excluded_refs, 0);
+	string_list_clear(&exclusions->hidden_refs, 0);
+	exclusions->hidden_refs_configured =3D 0;
 }
=20
 void add_ref_exclusion(struct ref_exclusions *exclusions, const char *excl=
ude)
@@ -1543,6 +1552,35 @@ void add_ref_exclusion(struct ref_exclusions *exclus=
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
+	cb->exclusions->hidden_refs_configured =3D 1;
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
+	if (exclusions->hidden_refs_configured)
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
@@ -2221,7 +2259,7 @@ static int handle_revision_opt(struct rev_info *revs,=
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
@@ -2687,6 +2725,8 @@ static int handle_revision_pseudo_opt(struct rev_info=
 *revs,
 		}
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
+		if (revs->ref_excludes.hidden_refs_configured)
+			return error(_("--exclude-hidden cannot be used together with --branche=
s"));
 		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
@@ -2696,9 +2736,13 @@ static int handle_revision_pseudo_opt(struct rev_inf=
o *revs,
 			    for_each_good_bisect_ref);
 		revs->bisect =3D 1;
 	} else if (!strcmp(arg, "--tags")) {
+		if (revs->ref_excludes.hidden_refs_configured)
+			return error(_("--exclude-hidden cannot be used together with --tags"));
 		handle_refs(refs, revs, *flags, refs_for_each_tag_ref);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--remotes")) {
+		if (revs->ref_excludes.hidden_refs_configured)
+			return error(_("--exclude-hidden cannot be used together with --remotes=
"));
 		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if ((argcount =3D parse_long_opt("glob", argv, &optarg))) {
@@ -2710,18 +2754,27 @@ static int handle_revision_pseudo_opt(struct rev_in=
fo *revs,
 	} else if ((argcount =3D parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
 		return argcount;
+	} else if ((argcount =3D parse_long_opt("exclude-hidden", argv, &optarg))=
) {
+		exclude_hidden_refs(&revs->ref_excludes, optarg);
+		return argcount;
 	} else if (skip_prefix(arg, "--branches=3D", &optarg)) {
 		struct all_refs_cb cb;
+		if (revs->ref_excludes.hidden_refs_configured)
+			return error(_("--exclude-hidden cannot be used together with --branche=
s"));
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--tags=3D", &optarg)) {
 		struct all_refs_cb cb;
+		if (revs->ref_excludes.hidden_refs_configured)
+			return error(_("--exclude-hidden cannot be used together with --tags"));
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--remotes=3D", &optarg)) {
 		struct all_refs_cb cb;
+		if (revs->ref_excludes.hidden_refs_configured)
+			return error(_("--exclude-hidden cannot be used together with --remotes=
"));
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
 		clear_ref_exclusions(&revs->ref_excludes);
diff --git a/revision.h b/revision.h
index 5c8ab16047..adb810c2f8 100644
--- a/revision.h
+++ b/revision.h
@@ -87,6 +87,19 @@ struct ref_exclusions {
 	 * patterns matches, the reference will be excluded.
 	 */
 	struct string_list excluded_refs;
+
+	/*
+	 * Hidden refs is a list of patterns that is to be hidden via
+	 * `ref_is_hidden()`.
+	 */
+	struct string_list hidden_refs;
+
+	/*
+	 * Indicates whether hidden refs have been configured. This is to
+	 * distinguish between no hidden refs existing and hidden refs not
+	 * being parsed.
+	 */
+	char hidden_refs_configured;
 };
=20
 /**
@@ -94,6 +107,7 @@ struct ref_exclusions {
  */
 #define REF_EXCLUSIONS_INIT { \
 	.excluded_refs =3D STRING_LIST_INIT_DUP, \
+	.hidden_refs =3D STRING_LIST_INIT_DUP, \
 }
=20
 struct oidset;
@@ -456,10 +470,12 @@ void show_object_with_name(FILE *, struct object *, c=
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
index 0000000000..32b2b09413
--- /dev/null
+++ b/t/t6021-rev-list-exclude-hidden.sh
@@ -0,0 +1,163 @@
+#!/bin/sh
+
+test_description=3D'git rev-list --exclude-hidden test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit_bulk --id=3Dcommit --ref=3Drefs/heads/branch 1 &&
+	COMMIT=3D$(git rev-parse refs/heads/branch) &&
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
+		test_must_fail git rev-list --exclude-hidden=3D$section --exclude-hidden=
=3D$section 2>err &&
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
+	test_expect_success "$section: excluded hidden refs can be used with mult=
iple pseudo-refs" '
+		git -c transfer.hideRefs=3Drefs/ rev-list --exclude-hidden=3D$section --=
all --exclude-hidden=3D$section --all >out &&
+		test_must_be_empty out
+	'
+
+	test_expect_success "$section: works with --glob" '
+		git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude-hidden=3D$sec=
tion --glob=3Drefs/h* >out &&
+		cat >expected <<-EOF &&
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
+
+	for pseudoopt in remotes branches tags
+	do
+		test_expect_success "$section: fails with --$pseudoopt" '
+			test_must_fail git rev-list --exclude-hidden=3D$section --$pseudoopt 2>=
err &&
+			test_i18ngrep "error: --exclude-hidden cannot be used together with --$=
pseudoopt" err
+		'
+
+		test_expect_success "$section: fails with --$pseudoopt=3Dpattern" '
+			test_must_fail git rev-list --exclude-hidden=3D$section --$pseudoopt=3D=
pattern 2>err &&
+			test_i18ngrep "error: --exclude-hidden cannot be used together with --$=
pseudoopt" err
+		'
+	done
+done
+
+test_done
--=20
2.38.1


--JYJt8rvo33GkNFRB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmN1ys8ACgkQVbJhu7ck
PpTiNBAArRhawX9EuTa8kI5H/khe+FoqA5Nnidtik7Y0Xr3gP3w5kRZmDl71R+X2
+XmFznKI5EPWUcJ/K3sneRiXmPBHWK/vR1DEk5AAnosNpcp8BtCZiFKkhnKGL/Dh
/E03Qa1F0aJ+vI7P1UWVHDAlOWUrz1VienRkZ1Ihxx7agHw7rpdITGSJz3FYRjXB
I7j5YtDd3ujJViP9S3KnXUD5A9ycYXEd3ieusRwKMW0/YkSyLptRcEIeBgAQX0qT
y6WiGOZHQY9XtXn5Fo3QoMKjSKXkN5OBuz4Xa85GILxlueBy6JMywK1f+TfDM8n5
srA9FZWxPpoDMiyeIcksI/DZMRqwETcinWbI2eeGUwjrvaiOAI/X7uSHx5+cnRSC
n2i+UIJOdBEi7x4Lho7f24AbFyoU6EJsAsopNr6rShuIcprNRuWfS67HzMP7vr3c
ccc6coXWUU130kfPPyUgFfeDs3BJuop44aQJhwaDcc2svpQoRmv5XWutYSLHGNuC
RPW9J2tu86b3rDJtV1pac+ADa7s1VRAygQcZiVbp/j1X9WG5+RXz93RTGZ1eSMgn
V64Qvw+u9n3e4Av34Qi0hxo3U4CtRtRGkc6GaqLdQEISzg8bIw7mx/PjCz7P20uo
D//QY70rH3+u4lZrQh+s3fUWqODnIAvJWhIVbHP0dDIKN9JJeNM=
=CAzR
-----END PGP SIGNATURE-----

--JYJt8rvo33GkNFRB--
