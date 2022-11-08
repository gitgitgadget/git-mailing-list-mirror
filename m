Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D8AC43217
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 10:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiKHKEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiKHKDw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 05:03:52 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C78A8
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 02:03:51 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AA35A5C018F;
        Tue,  8 Nov 2022 05:03:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 08 Nov 2022 05:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667901830; x=1667988230; bh=N8n5aoTuzg
        oG9iiPjZve5lCQaOlAX3sB3BPsMAbYhcE=; b=WjY9QS4f/3UNoSI/PQq18snqrc
        1MuJXJF4vYFpn09nRAT0buqjSlNtaRhoI+HjYbGN9dhO8XqOrYV6s7uPyaCxI6R8
        YXkowBXB6iXhYDD+PVbuvuiWGBHVBW5hoaKtMONUOAm4zgbK6niS9PDG/5nOI0sG
        XLKlYDbMOoiFjDc9pcYGNUE+XSjOy83tsko5YMKsQgE5Dp9nzvgjs694AOMZtTFR
        lpw82iSXijVowy+sQiQJ055upRtT5MqvArC+e8MCHS2BbmG+6vJAWABULSFzoBlu
        verdCdlBZ2supr7hqUcVeyoGtG5XY4os9YIQ0xPMW67V5DpeU3KvRbklAnUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667901830; x=1667988230; bh=N8n5aoTuzgoG9iiPjZve5lCQaOlA
        X3sB3BPsMAbYhcE=; b=gaNHnv4jeDw6+s9C4T2M+m/stX+z65TZ2a/oDOX/WfWC
        tCPt5vu6CG9Ex6BjK8yCGqCnHXEOG1XB1RQVQ37B0CIPyQtVVgMF1pkimmPuXEDS
        KlL713kxZvqXL5Ca7BELWqg9JGwNgnxnKIdLvKFPW/BBYFvCeIkeArHCSMDF+waE
        vtjYJleHi267PvQdqVntm0Wbaf75CN/k25j/YyJFrXDxr/knBBgH+d3onzo8TmDk
        X+jtkV4c9+nOU1rUSXGaOdBQmYWqKQIfMHNvV3jmGrAlMUkq9/mWlLnqNdToQG6n
        HfeqlxAl9bds79Gu6+f1NtDEMKmrXr0CmqaBTtHIGg==
X-ME-Sender: <xms:hilqY2PBYk1ffFbOw1GSQRCp9xU3rYMVbhgn27fMcqo2ORMVhRkc_Q>
    <xme:hilqY09lBRbj3yD_XddqkUYwxTuP7IqyHOoUPb4u2yJKQ7BDBEVTMJYteJyCgXBC6
    GY2IDcAtDUtDVtA1Q>
X-ME-Received: <xmr:hilqY9R0hRdcgea0fZO9xgZZmSVBaustFp2isEuPU2jmiyS2idOlXqGMU0RvSJi90uv4Cl-aMRdaHM2wUqZwbG2Cs975sQbdmh6U7SBwWogG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedtgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hilqY2uiHLt5txZQMO6gUg6S0N8YbUukQ5SBRLRfquUVqWJ_JigK9g>
    <xmx:hilqY-cNBSb_TTXu3V4tFKqTBehLWfo8wkLjVgUITXno6nG1uFNDcw>
    <xmx:hilqY60Rf16c4ghVZPCR1Se1yCHyibCRI0HIxDO4iH9cPwaZKTS7VQ>
    <xmx:hilqY-4fBQEG43jPeoa9zg3hO-rM-Q0qf6V-gB1YIXu_TZCEZ9ZGGw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 05:03:49 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 813c824a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 10:03:44 +0000 (UTC)
Date:   Tue, 8 Nov 2022 11:03:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 3/6] revision: introduce struct to handle exclusions
Message-ID: <265b292ed5c2de19b7118dfe046d3d9d932e2e89.1667901510.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667901510.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HFtxpFt9yFeL4Gyt"
Content-Disposition: inline
In-Reply-To: <cover.1667901510.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HFtxpFt9yFeL4Gyt
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


--HFtxpFt9yFeL4Gyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNqKYIACgkQVbJhu7ck
PpTzexAAqffJ8RdRXPcNBHnLIXPIsGXLUBUaTxdMqeFtxDL7gyFUpRTcuNgTRsqB
PUObeMlXfqgaxLU4n9Vp0ePr22ZeTRzU7MHvO5hBFfBXocXMP7qNypA0mGvzJA1E
jRvbIe1kkfxZObfB9WyMMkQHVf2aKUwyNnXcDYllL7vQz32b36R8SwXBPs+IZRsG
uvRcXFUo/8Hphp1ditTFkx4MtEBMvqhPUz3W11o6717TsVifdDyrrynnsyS+MoW6
mqXj6JIlVSDb4VxaUYC3tQeKPuoaMrKny0rtS/LF6MGOAr6tTbXgJPlhqg2yg1DZ
7p5GgDqN4myNdxU/bPDXKHroINlb0ctLrAl9Qbag2/OaO5kuag96Nl6vdX7Mky3f
BufKD/Uz8ARINgLJ+oylfDX8oEAw5DoqBUulMgRZL0xbUMPTHPMLM8Xbi4Zc1lHQ
i3hS3gaIu5Spcj0LUuJRMtZl8i7cTXKyp6HFRu9a6KnNpK8Thdb29fouLHWW0H5A
d2OLIVf4DABNSwMD6wtZFJKNqIjiZMPMKOxePG8KpZKDkpulCIfaRwVyTwWBkCtq
RNT0AyV8am6n9wRXvbt/W0FCciTCZUe2NFad2ZO/GwUvAmv9cJMw1zJdZ50J0ktu
1qMrunTVcZRkgVsz7Vb820JhsSkL4Ia6RswYFT0+td+DeglAD9I=
=y/UT
-----END PGP SIGNATURE-----

--HFtxpFt9yFeL4Gyt--
