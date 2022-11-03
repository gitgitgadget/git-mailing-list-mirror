Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A9EC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 14:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiKCOhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 10:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiKCOhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 10:37:37 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57BD17893
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 07:37:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1AB193200991;
        Thu,  3 Nov 2022 10:37:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 03 Nov 2022 10:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667486255; x=1667572655; bh=FFD24A/xbX
        MeT74z3uHqQuZDT6K+j9OzjqzodJFgEsY=; b=y5rLqfhyOItg4BjQoPq1It+ybC
        H6D6kMbaQd5Flc0C+jOvc0kDwafvhwGw3rMXWat/OpKO20HlSb04MFLSaG+cjU6G
        HNaZrx0CK5oIzbdCoy/4USZ499mQMn6QWvuWg2AOv1w33MKEBpBsj4u2Rj//Kw/O
        ynUs+tn7OguM7aSlTUQgiKZKuNENXVPEFQp8LW3VZrusuCm8tQx2vJ9FeQ5bsdQm
        nEzO0J1VvlayRvMvlXdztDGEl35gmoz8anEo2vOVgKhTR0k8yVpLtq7F+Lpr7bHU
        VPnZFWDsBXrRHeuw/SCD+tXpqZhpGeVPogI69/15oc6x86RoiEU3iemWbirw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667486255; x=1667572655; bh=FFD24A/xbXMeT74z3uHqQuZDT6K+
        j9OzjqzodJFgEsY=; b=UDgqvWRGgyRSTlWAHr3rNmjQjINGhHsWbXlNVwFxJwXZ
        wSTz9ZnRlGT1g7gV9OuO6qNxADcJj9hOrsXfdWTmERNKyTiJ16xYNcXQcaB28fxK
        MjswSSlSoyIiJrhrfifMSM6Oz9Ii2Ws9edcGAZb2up8cf8dkcafVXHDsXAeuapbv
        91t/NUps8dvjTns6AXiS/peogH0Pa+Z0EG/H/gflC4/ACJcy+9Dp314Taxj84kUJ
        mGhpfbZVI7fcBPJJ54DTRJMBDsRuid7fk+5BfnfpL80Q7IHV4HGcidP1fVIcNUSG
        sL+ZSAO84j2ZKbFEqk4v8o+kkEsAd3YUA4SpB3V5fA==
X-ME-Sender: <xms:L9JjY9VDqnzUFTWmSADAiVJ2-IqYpYZ5lYhddp4tdZnISnoStOpDtA>
    <xme:L9JjY9lbwpMdtR8-qhImibv4UjJg8kGRkRva91MqequPy67VLjJipxViewOR1XbAS
    q3TN9jGwoYV4-L7Aw>
X-ME-Received: <xmr:L9JjY5Zpsll12MUvblN2dOYWJC-owK4kFXSKjybzW4xSOhUMyVI4Jx1qVy1eiC7KIB8W0-6ajZtfDDRiKuEVRaVu2Ffw3dmgaWKvU3sACEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:L9JjYwUl_ypiCr2Hb1MDeD0B9b0a3JA6IUQ5XIFo7tCaH_3w3liyzg>
    <xmx:L9JjY3kFxTxGW8hrfzRcne-TH13BpwI3r2MACQQLDEuDQEw8lhbNLA>
    <xmx:L9JjY9emQF0necdWr_CVOTVRpTFbmU4VNR4ae1wn25ggDbGG1v8zTA>
    <xmx:L9JjY1hwsLiDu-2AtfUyjatwUfjzpLVxIq-ELa47jSP3NCLGpvzkGg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Nov 2022 10:37:34 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e0dc13f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Nov 2022 14:37:15 +0000 (UTC)
Date:   Thu, 3 Nov 2022 15:37:32 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 2/3] revision: add new parameter to specify all visible
 refs
Message-ID: <3ccd8fc0e35407e5c9ff896165f122b10598e0e2.1667485737.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667485737.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SCkJdlRvnGi2q9Kt"
Content-Disposition: inline
In-Reply-To: <cover.1667485737.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SCkJdlRvnGi2q9Kt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Users can optionally hide refs from remote users in git-upload-pack(1),
git-receive-pack(1) and others via the `transfer.hideRefs`, but there is
not an easy way to obtain the list of all visible or hidden refs right
now. We'll require just that though for a performance improvement in our
connectivity check.

Add a new pseudo-ref `--visible-refs=3D` that pretends as if all refs have
been added to the command line that are not hidden. The pseudo-ref
requiers either one of "transfer", "uploadpack" or "receive" as argument
to pay attention to `transfer.hideRefs`, `uploadpack.hideRefs` or
`receive.hideRefs`, respectively.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/rev-list-options.txt |  15 +++--
 builtin/rev-list.c                 |   1 +
 builtin/rev-parse.c                |   1 +
 revision.c                         |  34 +++++++++-
 t/t6021-rev-list-visible-refs.sh   | 102 +++++++++++++++++++++++++++++
 5 files changed, 145 insertions(+), 8 deletions(-)
 create mode 100755 t/t6021-rev-list-visible-refs.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-op=
tions.txt
index 1837509566..a0e34b0e2b 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -180,14 +180,19 @@ endif::git-log[]
 	is automatically prepended if missing. If pattern lacks '?', '{asterisk}',
 	or '[', '/{asterisk}' at the end is implied.
=20
+--visible-refs=3D[transfer|receive|uploadpack]::
+	Pretend as if all the refs that have not been hidden via either one of
+	`transfer.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs` are
+	listed on the command line.
+
 --exclude=3D<glob-pattern>::
=20
 	Do not include refs matching '<glob-pattern>' that the next `--all`,
-	`--branches`, `--tags`, `--remotes`, or `--glob` would otherwise
-	consider. Repetitions of this option accumulate exclusion patterns
-	up to the next `--all`, `--branches`, `--tags`, `--remotes`, or
-	`--glob` option (other options or arguments do not clear
-	accumulated patterns).
+	`--branches`, `--tags`, `--remotes`, `--glob` or `--visible-refs` would
+	otherwise consider. Repetitions of this option accumulate exclusion
+	patterns up to the next `--all`, `--branches`, `--tags`, `--remotes`,
+	`--glob` or `--visible-refs` option (other options or arguments do not
+	clear accumulated patterns).
 +
 The patterns given should not begin with `refs/heads`, `refs/tags`, or
 `refs/remotes` when applied to `--branches`, `--tags`, or `--remotes`,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3acd93f71e..f719286cf8 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -38,6 +38,7 @@ static const char rev_list_usage[] =3D
 "    --tags\n"
 "    --remotes\n"
 "    --stdin\n"
+"    --visible-refs=3D[transfer|receive|uploadpack]\n"
 "    --quiet\n"
 "  ordering output:\n"
 "    --topo-order\n"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8f61050bde..31617bf3d5 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -77,6 +77,7 @@ static int is_rev_argument(const char *arg)
 		"--topo-order",
 		"--date-order",
 		"--unpacked",
+		"--visible-refs=3D",
 		NULL
 	};
 	const char **p =3D rev_args;
diff --git a/revision.c b/revision.c
index 0760e78936..ef9e2947af 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "object-store.h"
 #include "tag.h"
 #include "blob.h"
@@ -1523,6 +1524,8 @@ struct all_refs_cb {
 	struct rev_info *all_revs;
 	const char *name_for_errormsg;
 	struct worktree *wt;
+	struct string_list hidden_refs;
+	const char *hidden_refs_section;
 };
=20
 int ref_excluded(struct string_list *ref_excludes, const char *path)
@@ -1542,11 +1545,13 @@ static int handle_one_ref(const char *path, const s=
truct object_id *oid,
 			  int flag UNUSED,
 			  void *cb_data)
 {
+	const char *stripped_path =3D strip_namespace(path);
 	struct all_refs_cb *cb =3D cb_data;
 	struct object *object;
=20
-	if (ref_excluded(cb->all_revs->ref_excludes, path))
-	    return 0;
+	if (ref_excluded(cb->all_revs->ref_excludes, path) ||
+	    ref_is_hidden(stripped_path, path, &cb->hidden_refs))
+		return 0;
=20
 	object =3D get_reference(cb->all_revs, path, oid, cb->all_flags);
 	add_rev_cmdline(cb->all_revs, object, path, REV_CMD_REF, cb->all_flags);
@@ -1561,6 +1566,7 @@ static void init_all_refs_cb(struct all_refs_cb *cb, =
struct rev_info *revs,
 	cb->all_flags =3D flags;
 	revs->rev_input_given =3D 1;
 	cb->wt =3D NULL;
+	string_list_init_dup(&cb->hidden_refs);
 }
=20
 void clear_ref_exclusion(struct string_list **ref_excludes_p)
@@ -1596,6 +1602,13 @@ static void handle_refs(struct ref_store *refs,
 	for_each(refs, handle_one_ref, &cb);
 }
=20
+static int hide_refs_config(const char *var, const char *value, void *cb_d=
ata)
+{
+	struct all_refs_cb *cb =3D cb_data;
+	return parse_hide_refs_config(var, value, cb->hidden_refs_section,
+				      &cb->hidden_refs);
+}
+
 static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
 {
 	struct all_refs_cb *cb =3D cb_data;
@@ -2225,7 +2238,7 @@ static int handle_revision_opt(struct rev_info *revs,=
 int argc, const char **arg
 	    !strcmp(arg, "--bisect") || starts_with(arg, "--glob=3D") ||
 	    !strcmp(arg, "--indexed-objects") ||
 	    !strcmp(arg, "--alternate-refs") ||
-	    starts_with(arg, "--exclude=3D") ||
+	    starts_with(arg, "--exclude=3D") || starts_with(arg, "--visible-refs=
=3D") ||
 	    starts_with(arg, "--branches=3D") || starts_with(arg, "--tags=3D") ||
 	    starts_with(arg, "--remotes=3D") || starts_with(arg, "--no-walk=3D"))
 	{
@@ -2759,6 +2772,21 @@ static int handle_revision_pseudo_opt(struct rev_inf=
o *revs,
 		parse_list_objects_filter(&revs->filter, arg);
 	} else if (!strcmp(arg, ("--no-filter"))) {
 		list_objects_filter_set_no_filter(&revs->filter);
+	} else if (skip_prefix(arg, "--visible-refs=3D", &arg)) {
+		struct all_refs_cb cb;
+
+		if (strcmp(arg, "transfer") && strcmp(arg, "receive") &&
+		    strcmp(arg, "uploadpack"))
+			die(_("unsupported section for --visible-refs: %s"), arg);
+
+		init_all_refs_cb(&cb, revs, *flags);
+		cb.hidden_refs_section =3D arg;
+		git_config(hide_refs_config, &cb);
+
+		refs_for_each_ref(refs, handle_one_ref, &cb);
+
+		string_list_clear(&cb.hidden_refs, 1);
+		clear_ref_exclusion(&revs->ref_excludes);
 	} else {
 		return 0;
 	}
diff --git a/t/t6021-rev-list-visible-refs.sh b/t/t6021-rev-list-visible-re=
fs.sh
new file mode 100755
index 0000000000..9e12384dcf
--- /dev/null
+++ b/t/t6021-rev-list-visible-refs.sh
@@ -0,0 +1,102 @@
+#!/bin/sh
+
+test_description=3D'git rev-list --visible-refs test'
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
+	HIDDEN=3D$(git rev-parse refs/hidden/commit)
+'
+
+test_expect_success 'invalid section' '
+	echo "fatal: unsupported section for --visible-refs: unsupported" >expect=
ed &&
+	test_must_fail git rev-list --visible-refs=3Dunsupported 2>err &&
+	test_cmp expected err
+'
+
+test_expect_success '--visible-refs without hiddenRefs' '
+	git rev-list --visible-refs=3Dtransfer >out &&
+	cat >expected <<-EOF &&
+	$HIDDEN
+	$TAG
+	$COMMIT
+	EOF
+	test_cmp expected out
+'
+
+test_expect_success 'hidden via transfer.hideRefs' '
+	git -c transfer.hideRefs=3Drefs/hidden/ rev-list --visible-refs=3Dtransfe=
r >out &&
+	cat >expected <<-EOF &&
+	$TAG
+	$COMMIT
+	EOF
+	test_cmp expected out
+'
+
+test_expect_success '--all --not --visible-refs=3Dtransfer without hidden =
refs' '
+	git rev-list --all --not --visible-refs=3Dtransfer >out &&
+	test_must_be_empty out
+'
+
+test_expect_success '--all --not --visible-refs=3Dtransfer with hidden ref=
' '
+	git -c transfer.hideRefs=3Drefs/hidden/ rev-list --all --not --visible-re=
fs=3Dtransfer >out &&
+	cat >expected <<-EOF &&
+	$HIDDEN
+	EOF
+	test_cmp expected out
+'
+
+test_expect_success '--visible-refs with --exclude' '
+	git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude=3Drefs/tags/* =
--visible-refs=3Dtransfer >out &&
+	cat >expected <<-EOF &&
+	$COMMIT
+	EOF
+	test_cmp expected out
+'
+
+for section in receive uploadpack
+do
+	test_expect_success "hidden via $section.hideRefs" '
+		git -c receive.hideRefs=3Drefs/hidden/ rev-list --visible-refs=3Dreceive=
 >out &&
+		cat >expected <<-EOF &&
+		$TAG
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "--visible-refs=3D$section respects transfer.hideRefs=
" '
+		git -c transfer.hideRefs=3Drefs/hidden/ rev-list --visible-refs=3D$secti=
on >out &&
+		cat >expected <<-EOF &&
+		$TAG
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "--visible-refs=3Dtransfer ignores $section.hideRefs"=
 '
+		git -c $section.hideRefs=3Drefs/hidden/ rev-list --visible-refs=3Dtransf=
er >out &&
+		cat >expected <<-EOF &&
+		$HIDDEN
+		$TAG
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+
+	test_expect_success "--visible-refs=3D$section respects both transfer.hid=
eRefs and $section.hideRefs" '
+		git -c transfer.hideRefs=3Drefs/tags/ -c $section.hideRefs=3Drefs/hidden=
/ rev-list --visible-refs=3D$section >out &&
+		cat >expected <<-EOF &&
+		$COMMIT
+		EOF
+		test_cmp expected out
+	'
+done
+
+test_done
--=20
2.38.1


--SCkJdlRvnGi2q9Kt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNj0isACgkQVbJhu7ck
PpSTkQ/+Owed+RSrJn6tYrtLWN7BYaXUeCNdTSeUyBpPGZbVN4XZkcCLtNnxFTij
i3Ouw6JVHD8zEjQMeIVwMeWU5pk4gjpfwoyHqM/30mT6Rfw5MOiPnOaH35qp4aYH
iCRw2rBjMjJimsoDEc9aE8FKlHEdDc8nfutCeMr9bwbsKiWdzLz/hmwgvjBuA6Iv
FV8XYt360a0e6F3r4zwHRT3kytzqh3jV1BE+QRhav68pGnHsGKjF9wYSSHnzh2gl
QnZQBdUdHFVxbrEuERJaVoFei5v7uzHXzKZfcpkVSV3r1dIPvQcqXDzL835Rb+Gg
GVXyZW+mBC4lPznGzugwD80Lj+s6XHoG14l6H3r4DkKrbdGc2HZfN7Y9IJ6yOtaI
nSV/NbJR7GvAbpxcdhRVhrzRe5Lx4mctU3rqCrOSX2gt7Cc+FQOkkKWeebtbxlhr
mqQRmmVr3lEdeSJRox8/TwYFFHn/y7QIkOxWgEmbyk0xTOfO1uDW8HVoO+avqqwl
zl2dSDikppchI1Ji51oBab5JO0TwLHA1ZVPtOEaxEBO52H1ZWU1YA6BylNaSUcNA
D/NsfaJMEbL0LphCmmFygQFc7b9GfMMlJrwmIg1GlWJvMiEfHPCg0hh3pZwHCujV
8mzjoG1JMxRNoQC7JvOAGva4tQH1vfPCKJbzbHl8IsTgLdYXsBw=
=a/wV
-----END PGP SIGNATURE-----

--SCkJdlRvnGi2q9Kt--
