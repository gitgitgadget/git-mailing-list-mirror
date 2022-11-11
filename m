Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1623C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 06:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiKKGud (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 01:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiKKGuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 01:50:25 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E077238
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 22:50:15 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D8B6E3200934;
        Fri, 11 Nov 2022 01:50:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 11 Nov 2022 01:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668149414; x=1668235814; bh=xX+Js5IEQI
        +g0MkdCSI9uMtBeidvZ5NgjkT47DgB5l0=; b=KCEG4bMu6Ly34XsfYiieIuw5Rv
        IVOcskoO86KVNXG1F9bqW6q/3ysUhmDzwV8+1lOkUkjd9sL7XU6gV9OvIpAvOkvd
        Fez3IPG9/PSxPwncOI4OrVnpAm58zmkIx2GzqeJCvEoqT01BjOzH7RM+vTCet2Q+
        PbharqMNQhOstqW9gVWmEC5CP1Swi3GgrmuPLM4+JXG2uncFcnqhgqf2TEIMrW/U
        mHA1B4etUV+JAPPqn+PoYfp5aOJxwYD119bsvT+qNmXhJ3ZOpU7/sNJlP98QlS9x
        LEH9TJOqG3Nba0aJi3sWxJcFsNwSTk44mplqY6+S8jMeYbFoXlqJ56fafZhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668149414; x=1668235814; bh=xX+Js5IEQI+g0MkdCSI9uMtBeidv
        Z5NgjkT47DgB5l0=; b=CCIMqNYiIEahiuF0QkDWvs7fZiSgcAV+KlIM5urKtDtw
        7+kdrp7evA8Buu3OXWI2+8LtxpQ9cHC19R5cceVVh/S1gL2NzUR8jUfxyBHf1f8V
        s+MqWgNIEw2NgLUbjdWUC9oBu3UeNQeLdZttZupuseNExiLPk/nYDZJWZIrlAE7g
        SGwKiEc0sJlTDcAbfHM804OEHO4srSNb9qaePKTUH+r/3/6bln+FVzpMTpTk6DIg
        z8wL5J2VsLbwYHJpNjbhoPMsizmol0ZM3TX5tqHkpFcohCC3emMd+BpIKiOrXP5C
        magKfRhkO8YQLdu45tFNBEHMUJH/+HEgvrG8Sm720g==
X-ME-Sender: <xms:pvBtYzMNBkCyVHyg2gSeUYQwCUF6m8mGFXQKXA6GBiytFeEtHxy4bw>
    <xme:pvBtY9-MaV-7vGbwpzu0R5EBGH6eU3ulDBM75ZXgAO_0E72CoT6tNTx3ur297Hwx5
    WN1RhFT3NOSO8iyaA>
X-ME-Received: <xmr:pvBtYyStdau06CoAwDDyF3onKWV69DBxxnp1LvV_PLLkavBVeo857y0Yy_0tKB7ODg3dIhfhtJLcW-pW_EhkawWtdiCwf-AMeTd-Ku-GrYPVgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeehgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:pvBtY3t8vNQ1jWwfdLn4XOS9Tr6CEiA4XiZBfxlGCfKIk_VeamUqxQ>
    <xmx:pvBtY7dGv5ODTM-jkzAmF-gDfqO0_tWUDaqOqyxUJMaa4kQq1om3_A>
    <xmx:pvBtYz0ilCWbpcZdaDe7dYhQcxMzDJaxPRT4LucBsGfCjm_xZ8ve6A>
    <xmx:pvBtY36y1ZSxmw2FIZW9H8WjgWpP3YMM32G4mEGRSbLaKDGwUoQhIA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Nov 2022 01:50:12 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 62daf3c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Nov 2022 06:50:10 +0000 (UTC)
Date:   Fri, 11 Nov 2022 07:50:10 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 5/7] revision: add new parameter to exclude hidden refs
Message-ID: <b5a4ce432a97b8af6cb854aaf4aecb12dda95612.1668149149.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mcqiQPGSrUm6GAou"
Content-Disposition: inline
In-Reply-To: <cover.1668149149.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mcqiQPGSrUm6GAou
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
index 0000000000..018796d41c
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


--mcqiQPGSrUm6GAou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNt8KEACgkQVbJhu7ck
PpSJcA/+J7iFBCKaMoEPqRmBt3mZQJhxkGPFI5HwoDfhSsRZn6p9InVEuRquyHdO
t6MU89pCH0nPtfInBlBLfgjAcAHwozQoH8+GZfrjd5Mr0nGQvxtlK9BuOq6NCse7
0/NFAEAC7nRXZh0f41H65KUFlONIqDzWqnXsKoIgUwAp8gA3z3ttuVRntsThNKfp
JUOYQBWXL7Q38+EeHrOLBsFmylysD+cWa5e5EHXLHiGAtrA7GHX0Ih3oidac3Z4t
sNsWXeXMXBL+XWRAJKo1GTTLXDEgOZkfYMfJl2rm48tKBwOtz0ovde2ZG0EgocOy
8fX47NzOens/cOc6fuZdaMMhvSByN6M0mt3+JVM6pVZJ9OeAZf1JWEYzNVD57m8R
2j+e1PbGNowwTdMom9jTuTbY55UghBd2XOti5yNkJugDXh5UXeUKbHbfP0dOO3hr
9/ZA16VyXU5UEYkUGWPJb3dDJ5NdTXAWcHShAJJNEcuhLwHBLPj0V1IdNoqpaniN
5RuxIszDk6MdR2xJ/h1NRtV083f9lfz4qPsri55EnW/95R1OUs7MuVRJbi1yWmxU
Mzo1hmNsn3LcsD1gzlTowS/JRsK7zMNvpYiUtfH+wxjTybelijQUKXnl7rVMKhLv
CQ50b/TIRzpSRWlG+aTZJ6uwk47RccSaQbxGPLsGlMyYkY9pR9g=
=O/5/
-----END PGP SIGNATURE-----

--mcqiQPGSrUm6GAou--
