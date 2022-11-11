Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8576FC43219
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 06:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiKKGu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 01:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiKKGuW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 01:50:22 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8E4742C7
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 22:50:11 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 41CDA32008C3;
        Fri, 11 Nov 2022 01:50:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 11 Nov 2022 01:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668149409; x=1668235809; bh=LocJ8dfo9C
        auVuLbVRV26U2s6/04fz2AQstx0lmlE+M=; b=vvMhj/5EwYsCQ5x8DGdfQp2LYo
        EkTVfy2IWAA0KlBJ94XwbrA4uwKESCqPpDeHF+k0m3X7AveaDBVRzeu0sBiAYMx7
        OA9HJsOYwHGK83YJmp4aXCkyzY6KJyJ8VU4kqgUAKKYQ+dFtjQrEOBAhL/R9x0em
        DEDg3FNny61SteX5aYRPPQhJ+8Y+bB474i7IQdEg7LvCpw7BpP3OouCnuJitU6bh
        OVrUlxyzduQeRZOiDGYK1Uv83eAI/kgEYEdsDWSELJaQlr2qFKnOHCGvzsn8pglB
        j/SB5nkz36Es+7gKCHZBM37QrzW8mIpqwXwn6yX8UMyGzXxCq+UxaclSGVEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668149409; x=1668235809; bh=LocJ8dfo9CauVuLbVRV26U2s6/04
        fz2AQstx0lmlE+M=; b=RgsY3jOfgClJJCkMByq5ZvToQ7TdeDBboDl8mMQRSQGk
        QNYc2H2Kq5YawKwDfUh6bNlVpL5Hxrug8t2MjnoAYU4eLyLfBR5YrdoJxbue7xyy
        ibSkfQrMJN7pOx96644jUd94kwJNIAfu6ZqvYJc2hf/r6hg1LsNxZ3PhUrL6ql+G
        a/tIKP2RS3X1pt+IwhOVJuP3DcYUa8poa05l7F6Ap9hJF1auvn8JOKLDCKIfHbbo
        iaua2zCOryxVFqMBYYr4XUjaTZmcEPNzvhyFGlafm04U4S6mB/QxSpkuivshKm/u
        NcsNmxSC2Ywofh9Ip+7oXF75m0ElwCt1HvAhF70r0Q==
X-ME-Sender: <xms:ofBtY0UyRN0CfJr2sm1tqUcVyl0zAnmxyoG1-Vfy4K63A45q87uiwA>
    <xme:ofBtY4mBxfBjuaIKmjiQ7nn2oi2K2XDDIQlJeoB4gDmMPdIPvmRiHG1HvVkOMaEcQ
    k_dgSDcNo59LvnmcA>
X-ME-Received: <xmr:ofBtY4aVJSbmaQIXdqkygm22TXCozYvbtsEu9ujBMFcMCMZQShvv3_UES8OzDymWXz0-GP0NfqkWtRP9XpbRqtsAGUTe49gri_gGRcbVVtNh2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeehgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ofBtYzV6wlJdX4qTeHqBgv69T2Qk7wZ-rEKOKY651PUVwLZ1L8gYWw>
    <xmx:ofBtY-lqudEmdJ3hanE_STYl93g-cr8MYAH_qnOZgccOb1TyR6HOfQ>
    <xmx:ofBtY4d3sv8OuIV8jqudXDCUm-eE3Kuxsc73fPkBQuyD4-gwLuo1Gw>
    <xmx:ofBtYwinadO0177LdC6laUAaBiWOV9yY7b65kEaNBZ1oBVSHMdSF8Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Nov 2022 01:50:08 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id bc112d80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Nov 2022 06:50:06 +0000 (UTC)
Date:   Fri, 11 Nov 2022 07:50:06 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 4/7] revision: introduce struct to handle exclusions
Message-ID: <ad41ade33216bc6b977b93a13557991bc02a7605.1668149149.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zWAiuIxMojCbNmJr"
Content-Disposition: inline
In-Reply-To: <cover.1668149149.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zWAiuIxMojCbNmJr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The functions that handle exclusion of refs work on a single string
list. We're about to add a second mechanism for excluding refs though,
and it makes sense to reuse much of the same architecture for both kinds
of exclusion.

Introduce a new `struct ref_exclusions` that encapsulates all the logic
related to excluding refs and move the `struct string_list` that holds
all wildmatch patterns of excluded refs into it. Rename functions that
operate on this struct to match its name.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c |  8 ++++----
 revision.c          | 48 +++++++++++++++++++++------------------------
 revision.h          | 27 +++++++++++++++++++------
 3 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8f61050bde..7fa5b6991b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -39,7 +39,7 @@ static int abbrev_ref_strict;
 static int output_sq;
=20
 static int stuck_long;
-static struct string_list *ref_excludes;
+static struct ref_exclusions ref_excludes =3D REF_EXCLUSIONS_INIT;
=20
 /*
  * Some arguments are relevant "revision" arguments,
@@ -198,7 +198,7 @@ static int show_default(void)
 static int show_reference(const char *refname, const struct object_id *oid,
 			  int flag UNUSED, void *cb_data UNUSED)
 {
-	if (ref_excluded(ref_excludes, refname))
+	if (ref_excluded(&ref_excludes, refname))
 		return 0;
 	show_rev(NORMAL, oid, refname);
 	return 0;
@@ -585,7 +585,7 @@ static void handle_ref_opt(const char *pattern, const c=
har *prefix)
 		for_each_glob_ref_in(show_reference, pattern, prefix, NULL);
 	else
 		for_each_ref_in(prefix, show_reference, NULL);
-	clear_ref_exclusion(&ref_excludes);
+	clear_ref_exclusions(&ref_excludes);
 }
=20
 enum format_type {
@@ -863,7 +863,7 @@ int cmd_rev_parse(int argc, const char **argv, const ch=
ar *prefix)
 			}
 			if (!strcmp(arg, "--all")) {
 				for_each_ref(show_reference, NULL);
-				clear_ref_exclusion(&ref_excludes);
+				clear_ref_exclusions(&ref_excludes);
 				continue;
 			}
 			if (skip_prefix(arg, "--disambiguate=3D", &arg)) {
diff --git a/revision.c b/revision.c
index be755670e2..fe3ec98f46 100644
--- a/revision.c
+++ b/revision.c
@@ -1517,35 +1517,30 @@ static void add_rev_cmdline_list(struct rev_info *r=
evs,
 	}
 }
=20
-int ref_excluded(struct string_list *ref_excludes, const char *path)
+int ref_excluded(const struct ref_exclusions *exclusions, const char *path)
 {
 	struct string_list_item *item;
-
-	if (!ref_excludes)
-		return 0;
-	for_each_string_list_item(item, ref_excludes) {
+	for_each_string_list_item(item, &exclusions->excluded_refs) {
 		if (!wildmatch(item->string, path, 0))
 			return 1;
 	}
 	return 0;
 }
=20
-void clear_ref_exclusion(struct string_list **ref_excludes_p)
+void init_ref_exclusions(struct ref_exclusions *exclusions)
 {
-	if (*ref_excludes_p) {
-		string_list_clear(*ref_excludes_p, 0);
-		free(*ref_excludes_p);
-	}
-	*ref_excludes_p =3D NULL;
+	struct ref_exclusions blank =3D REF_EXCLUSIONS_INIT;
+	memcpy(exclusions, &blank, sizeof(*exclusions));
 }
=20
-void add_ref_exclusion(struct string_list **ref_excludes_p, const char *ex=
clude)
+void clear_ref_exclusions(struct ref_exclusions *exclusions)
 {
-	if (!*ref_excludes_p) {
-		CALLOC_ARRAY(*ref_excludes_p, 1);
-		(*ref_excludes_p)->strdup_strings =3D 1;
-	}
-	string_list_append(*ref_excludes_p, exclude);
+	string_list_clear(&exclusions->excluded_refs, 0);
+}
+
+void add_ref_exclusion(struct ref_exclusions *exclusions, const char *excl=
ude)
+{
+	string_list_append(&exclusions->excluded_refs, exclude);
 }
=20
 struct all_refs_cb {
@@ -1563,7 +1558,7 @@ static int handle_one_ref(const char *path, const str=
uct object_id *oid,
 	struct all_refs_cb *cb =3D cb_data;
 	struct object *object;
=20
-	if (ref_excluded(cb->all_revs->ref_excludes, path))
+	if (ref_excluded(&cb->all_revs->ref_excludes, path))
 	    return 0;
=20
 	object =3D get_reference(cb->all_revs, path, oid, cb->all_flags);
@@ -1901,6 +1896,7 @@ void repo_init_revisions(struct repository *r,
=20
 	init_display_notes(&revs->notes_opt);
 	list_objects_filter_init(&revs->filter);
+	init_ref_exclusions(&revs->ref_excludes);
 }
=20
 static void add_pending_commit_list(struct rev_info *revs,
@@ -2689,10 +2685,10 @@ static int handle_revision_pseudo_opt(struct rev_in=
fo *revs,
 			init_all_refs_cb(&cb, revs, *flags);
 			other_head_refs(handle_one_ref, &cb);
 		}
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
 		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
 		read_bisect_terms(&term_bad, &term_good);
 		handle_refs(refs, revs, *flags, for_each_bad_bisect_ref);
@@ -2701,15 +2697,15 @@ static int handle_revision_pseudo_opt(struct rev_in=
fo *revs,
 		revs->bisect =3D 1;
 	} else if (!strcmp(arg, "--tags")) {
 		handle_refs(refs, revs, *flags, refs_for_each_tag_ref);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--remotes")) {
 		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_exclusions(&revs->ref_excludes);
 	} else if ((argcount =3D parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref(handle_one_ref, optarg, &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_exclusions(&revs->ref_excludes);
 		return argcount;
 	} else if ((argcount =3D parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
@@ -2718,17 +2714,17 @@ static int handle_revision_pseudo_opt(struct rev_in=
fo *revs,
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--tags=3D", &optarg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--remotes=3D", &optarg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--indexed-objects")) {
diff --git a/revision.h b/revision.h
index afe1b77985..5c8ab16047 100644
--- a/revision.h
+++ b/revision.h
@@ -81,6 +81,21 @@ struct rev_cmdline_info {
 	} *rev;
 };
=20
+struct ref_exclusions {
+	/*
+	 * Excluded refs is a list of wildmatch patterns. If any of the
+	 * patterns matches, the reference will be excluded.
+	 */
+	struct string_list excluded_refs;
+};
+
+/**
+ * Initialize a `struct ref_exclusions` with a macro.
+ */
+#define REF_EXCLUSIONS_INIT { \
+	.excluded_refs =3D STRING_LIST_INIT_DUP, \
+}
+
 struct oidset;
 struct topo_walk_info;
=20
@@ -103,7 +118,7 @@ struct rev_info {
 	struct list_objects_filter_options filter;
=20
 	/* excluding from --branches, --refs, etc. expansion */
-	struct string_list *ref_excludes;
+	struct ref_exclusions ref_excludes;
=20
 	/* Basic information */
 	const char *prefix;
@@ -439,12 +454,12 @@ void mark_trees_uninteresting_sparse(struct repositor=
y *r, struct oidset *trees)
 void show_object_with_name(FILE *, struct object *, const char *);
=20
 /**
- * Helpers to check if a "struct string_list" item matches with
- * wildmatch().
+ * Helpers to check if a reference should be excluded.
  */
-int ref_excluded(struct string_list *, const char *path);
-void clear_ref_exclusion(struct string_list **);
-void add_ref_exclusion(struct string_list **, const char *exclude);
+int ref_excluded(const struct ref_exclusions *exclusions, const char *path=
);
+void init_ref_exclusions(struct ref_exclusions *);
+void clear_ref_exclusions(struct ref_exclusions *);
+void add_ref_exclusion(struct ref_exclusions *, const char *exclude);
=20
 /**
  * This function can be used if you want to add commit objects as revision
--=20
2.38.1


--zWAiuIxMojCbNmJr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNt8J0ACgkQVbJhu7ck
PpScPxAAmpLUY3sPTjYAaqMOTqLOQpKQU/aH4RTZQ3gB17Hg54TGDuBQUyG6Jnm0
/kTEEWAW13Y+Ja6aBDYHSxmLhg12A1OrfubVPipimZwIBWQlQ3QifVN44oSDzCad
eu+a06KpauDl5TEpxf07KUFn/5rdCK8tDXyYVonBgp4EBtu6e1TctNO3cgazRs8T
Wyw7VHe2Y2vfzt4GZX61moM1DAG4Qkwjb2jvUbddusUcxbjN3cD9dphmM2qaqiHJ
2GZJBNNA4y/f3NzICMvUeDJU75VMV+5Vz9n9dDHTkdz+CYRFMNVn2czCFNV/WXDX
26xnIDknjnVTHCh4AZwa4dfwbK8/ijmBIKJtC370vGYpbMGMDsYibUZYgTMOZCAV
l6eiIG/grm1CKQsMlc49NCbYMRrJr3uikJwDf1jYC9Vev3vp3c0Fu67Xp3/t6ThO
wJTmXtCeo/W4kwMWLCSyZRNBxwmzD/ghzJJK2vaWFp1d2ql6xiNY0QE1rD2e2kzm
QZFuRASbJnzapCqa/CoIdkR6QLUHMGs/raCY4lx8sjP973B0MI9S9Tkrr/uXZV3H
Lp1JAJ4RKNNvrFYoEGwq3DXoQ2lcMcZUiqRG+0ldZTSipdbuAjha0uduBp9Of1Ej
XKBJ/K+0xfFtvRzTUStrhIPJM/hjuEZn0bPCgMX6H8bnrVldGTU=
=ild1
-----END PGP SIGNATURE-----

--zWAiuIxMojCbNmJr--
