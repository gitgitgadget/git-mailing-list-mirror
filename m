Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D7CC4321E
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 12:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiKGMRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 07:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiKGMRW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 07:17:22 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61382BE9
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 04:17:20 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C5A313200922;
        Mon,  7 Nov 2022 07:16:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Nov 2022 07:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667823394; x=1667909794; bh=DenOB/Iprp
        jo+CqHNzVaLx9E48iNOHyB/i8jydz+6MY=; b=qeKJO2ppEL3nWzJKGwlZ85x8Ht
        XAL0r4vS0pYWmgrEbHFfbTDMOqdZkyzvZp6cXw8OeVXHa9Y3UMY2nWJ0kPGUanuP
        X5+i9q+RCCw4qkQeFQKu1t/mvs0opLNnQ89upcwQDehAdtHZc7qZfnp5BJhx6cYq
        UTPmLqFMJxBKdxOsLyppesc/6AokxFv7Il1oUjrrrwLN+9DnJFtRMxlW7X75nV5P
        aAfA/oUgbxLaubWlxWKkF+aAHicj1Byy9SILtW7ZPhdSDYGVPFmuM/yD6ovRN7n2
        Ln1hcT7UfKAjvW/0mj5P1blifQq70YebMuM9oHKXgqUxBjc+xiauejCsmSkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667823394; x=1667909794; bh=DenOB/Iprpjo+CqHNzVaLx9E48iN
        OHyB/i8jydz+6MY=; b=ssZSsXm3GGPuJDgCRISCuaHz6sBuGVHXgJ4zmwew6T3q
        7pbST/UQnF0M5zUtGBXdkfGCrI5z+ohrvzGbiL8994QKOmRAyXMBdRqPNdmsAIB7
        c/2OtjoXtSmKOe6gwJpM1oVz5lCtQYD16iuX87x+tIZMags1Z4HgknXEmpd+QmiT
        RK4N6oMZEfxp0OpQb3q8yGwV5pHb07ndLSIFdef3qv28M6RB7sLt/kg4/YyqtWyi
        WphxzcuDhVrFopuQ2LPY5RCpCgLGCFolhh03bPWLq+xZOieYWs2Ps0YinMSJyC3H
        3TY8frBN6aMSNkKs+kfB9O+CHwBFBRsF5TXB5Hpvnw==
X-ME-Sender: <xms:IvdoY-jTYnJPvbwfKDaJJl-jfDqUcbWuvV0aRmSfyxYLjOu3ye0Tew>
    <xme:IvdoY_DFTFCrFjbfjlZP_B-W8brfjGaKyiBaenp-iMaGTyS3UrSztaMhckRWfctqL
    aq26Jfw0rabmxKwhA>
X-ME-Received: <xmr:IvdoY2E_JrsyzUDHfeVGPBE-rJKlLD1SAQtY-3q0Lb4V6xxBPz529HC3I7k4SD69qmFkzCVtKAEOWZgcwaxDNYIfrsKFFMlREcc_prqRthDV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IvdoY3SOidyYzgNLEyDPL0Yr3rNtkCgNMVlqLLg5bT1Dq3PtmlFEVQ>
    <xmx:IvdoY7yjwaM2GZElFEnzxHMBe8ihIHRdiHBewU_17HDCfu_B4xvVIw>
    <xmx:IvdoY147xCwItYuH7COZp5ItLUq_kZ71zrHbvc_25TOns-g9dtnoqQ>
    <xmx:IvdoY79uaYJwomgxMEm3UQ12GIhLcAV9cmv13tHGN4Y9Hf7p2OoNrw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 07:16:33 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 76abf4db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 7 Nov 2022 12:16:30 +0000 (UTC)
Date:   Mon, 7 Nov 2022 13:16:31 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 3/6] revision: introduce struct to handle exclusions
Message-ID: <2a6a67df1d470bf790025d55095c237ddc6a6bd6.1667823042.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6Ydx+mFW2VadKVkS"
Content-Disposition: inline
In-Reply-To: <cover.1667823042.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6Ydx+mFW2VadKVkS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The functions that handle exclusion of refs work on a single string
list. We're about to add a second mechanism for excluding refs though,
and it makes sense to reuse much of the same architecture for both kinds
of exclusion.

Introduce a new `struct ref_exclusions` that encapsulates all the logic
related to excluding refs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c |  8 ++++----
 revision.c          | 47 ++++++++++++++++++++-------------------------
 revision.h          | 22 +++++++++++++++------
 3 files changed, 41 insertions(+), 36 deletions(-)

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
index be755670e2..e5eaaa24ba 100644
--- a/revision.c
+++ b/revision.c
@@ -1517,35 +1517,29 @@ static void add_rev_cmdline_list(struct rev_info *r=
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
+	string_list_init_dup(&exclusions->excluded_refs);
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
@@ -1563,7 +1557,7 @@ static int handle_one_ref(const char *path, const str=
uct object_id *oid,
 	struct all_refs_cb *cb =3D cb_data;
 	struct object *object;
=20
-	if (ref_excluded(cb->all_revs->ref_excludes, path))
+	if (ref_excluded(&cb->all_revs->ref_excludes, path))
 	    return 0;
=20
 	object =3D get_reference(cb->all_revs, path, oid, cb->all_flags);
@@ -1901,6 +1895,7 @@ void repo_init_revisions(struct repository *r,
=20
 	init_display_notes(&revs->notes_opt);
 	list_objects_filter_init(&revs->filter);
+	init_ref_exclusions(&revs->ref_excludes);
 }
=20
 static void add_pending_commit_list(struct rev_info *revs,
@@ -2689,10 +2684,10 @@ static int handle_revision_pseudo_opt(struct rev_in=
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
@@ -2701,15 +2696,15 @@ static int handle_revision_pseudo_opt(struct rev_in=
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
@@ -2718,17 +2713,17 @@ static int handle_revision_pseudo_opt(struct rev_in=
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
index afe1b77985..87d6824c55 100644
--- a/revision.h
+++ b/revision.h
@@ -81,6 +81,14 @@ struct rev_cmdline_info {
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
 struct oidset;
 struct topo_walk_info;
=20
@@ -103,7 +111,7 @@ struct rev_info {
 	struct list_objects_filter_options filter;
=20
 	/* excluding from --branches, --refs, etc. expansion */
-	struct string_list *ref_excludes;
+	struct ref_exclusions ref_excludes;
=20
 	/* Basic information */
 	const char *prefix;
@@ -439,12 +447,14 @@ void mark_trees_uninteresting_sparse(struct repositor=
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
+#define REF_EXCLUSIONS_INIT { .excluded_refs =3D STRING_LIST_INIT_DUP }
+
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


--6Ydx+mFW2VadKVkS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNo9x4ACgkQVbJhu7ck
PpQmeQ//e87A4+3Ot2zt5TjZ1MjI3GbNBU4VbeN3pC9M6UD/xchOzhEnLFqUw1Km
u2h23jB+V4Op2je55MOAni3cDdLNGxsg3Vo3xOMBtiOT8DNFQJltnepoPtEMsHwG
5VLI2t/BiRL85Dp7nVEgzH1vKxL3K/mzXj0azYHIvy4KR1h/4eyJE0pDCKZqMKU/
iq3yjGLy+Wld/8fPwggXA6EPvDclutWrSBiQyZHioe/jwLZkipTWSnXNcPW8Mn/f
QIEZrwRVjOegOQnRCaa2qXywoiY9hdBdis3qEhSaiICfBpoXwyj68U4VP/EEgxL/
uY/giy/DcBaOHPHSrMtcLtR1w1XixcjLMHjy8D5D6e787PxcZ7xBXTfke3P4YUEu
Kyzwi7cGiHDEH57LuS2UKr7xD67aicVeCLHhF/eF52f0ZxWcW2Z63RQBc6kbYmHh
qG9o6Ms1C0QbhnW4B4qsZT+Wr3uzIGGii4dZqXKxLEbCv2VsI0u4Xq8asKXm/y+o
5oaTYwpqHFOh8CGlvjkTZDQr+dTlBt2tD9RFQIApYRzphbmICLA3y01/didIzsCH
pHJAxE2ggO5KCpJdX9tGER4le3JvqndvVec++7o9g/jcinWO8GiC5IWuR4MozztA
pOo+6WiqRb/FfGn/p8DnyoazOlDZCgo+ezbwjLDlYiv+2YhxTFQ=
=/Fms
-----END PGP SIGNATURE-----

--6Ydx+mFW2VadKVkS--
