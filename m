Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E23C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 05:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiKQFrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 00:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbiKQFrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 00:47:04 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82A6EB46
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 21:46:56 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1F8B13201B62;
        Thu, 17 Nov 2022 00:46:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Nov 2022 00:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668664015; x=1668750415; bh=6ghDXpSjYn
        poA8T500zX+Op1h2IMSaJywU2suszV+OU=; b=QUWVx1NNGa2tYZknpstWUX7JB2
        umhYiGSZ+3+txK4awdIGX+xiUFTbuNvBM7zrAD5kKSz6gqXwI6kJ2p7z3ZfsdO/h
        Bx44xeo9VKoLJXZ+V1SSeC8xByO/QFqOnh5ggvlocdsHgcQ4D4awiATs8dfUv17U
        H8xIsn+/VCu3rjulpGhc7UWT4vKomeWlpL5ZiU0anPgkCCHpLbe3WGSYgC8kFa78
        DeXadmQaOYVEbah+ajGFW5r5gkEoeAR+EYwKGXogYOVtdLqA7ijosvi58QblUWkS
        2MQIc2O8hsCYffwzrBv5wb6Y3tQSvQQDhZpTy0wpr+/T+VADOJ1Vu2GeSZ0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668664015; x=1668750415; bh=6ghDXpSjYnpoA8T500zX+Op1h2IM
        SaJywU2suszV+OU=; b=Kg2bLxLeGYKtpksgWX47FfJfkx5pFDcgFKUYXGruSwlI
        FBLw2fh7N1vu+Nw7ecFJtPt+tJNYVpjEejogDP6f78+tz8FmrQpRJZ6/wGC5kMTg
        PbpF03x5ngzDMTGWtak4QNzM+XqALkuIdslupB2X9FljYXb/pAG8l9qi3G9gKhZ8
        RH1uevcvezmbZq9/XQ9vqy4Z01jitIRE4vulZEp1bOH+h1XCkoiAGvuJut+fJV45
        Yqyi9kYqrAXB+oBXc7/Z8ZLYdz6vEjMZhLS0aEUNlpYVTMEJ4A+ZDfO54bnbF280
        nP8/6jB6rk0M7HbDDcPg60lJRBqmCi/mmmtY5KCv3A==
X-ME-Sender: <xms:z8p1Y1-taohU8yHiHgWsVqMrCNk1_TnN4BncBDrxhmLfvcllsZu9tw>
    <xme:z8p1Y5tHuWrxVQhdhasMRW9LIsYUnU_Ucy3v27PJJ7vEUYY1eNZZzm9crVf0DYnYN
    kPTuPW_XZxOc9gxjQ>
X-ME-Received: <xmr:z8p1YzAXfUvi6KyKYIIEog4eFY9e5g2COtVXp2O2xLE-s9qmgF6GqnPLX9Qw36LFo2T57imYiHbQNUY3PX5CRpkAQ16U_7dGwkUv5qRkKPThf1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:z8p1Y5drO8wR2oPxJgvFuIkEyGYoLrFOZ2heuAtwnMBgWWEwYPZ9vg>
    <xmx:z8p1Y6M9brVEJPm3ojlVAPCAp_uBO6dYBKIJqa-C5Tj7_mOs90bdwA>
    <xmx:z8p1Y7lMe_j1J_HxIc6jira24IN5ZXaIIjsYJfkZr-XxYa0cgGVzOw>
    <xmx:z8p1Y3ow8X_yE8RMW5OAkeVDp2r5lbLZClYtaNfRzo_0L8c-R2ejqQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 00:46:54 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 966918a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Nov 2022 05:46:39 +0000 (UTC)
Date:   Thu, 17 Nov 2022 06:46:51 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 4/7] revision: introduce struct to handle exclusions
Message-ID: <805de80e6461e5f918e4359970eb400b7437fb68.1668663796.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668663795.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EKVZS1cP0fVaEMCP"
Content-Disposition: inline
In-Reply-To: <cover.1668663795.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EKVZS1cP0fVaEMCP
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


--EKVZS1cP0fVaEMCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmN1yssACgkQVbJhu7ck
PpQJnw/8Cmm+AVSUUO6ACSiWA7pOrySkCWoxwM0m7hLI26UabsOvkm12yDjO76uJ
BLsvMNsvO5FUJnHn4PfgcuH0wKKlutTFsvMqPLMxhVomDJGbgoKQ37I7gL70C16K
jR4CGPcHwIme8Y3QZIN86QuC94R8JCqaVB4o0IxbfCk7Q/nGn7nSumQ3JF365X9t
anOA25jDNx9TQixIPAPmxx3WcDd7ruqcv5UXKTSwHs3BIiptuwATSnAtRxJLEKCZ
FJhV2F7PHpxC3oVH+0+Pa2yb4kjFpLYP8jEdbjKQlKTUfgNEsRxsNU5d0nZEPjcn
QWgmc49HWVs4wGxx+H7XFfAhGNYVpCklrotrhtKAclvx/QpxsH5b542oSPQRzvLY
IGuZ1DdtHY+5rkxed4wovGE8iytkmNs7BhBMvDA1lzYgBBzRNJdWSppTCL5Qv6fk
x1bHbM9pkKh2RERXMy8NFRIz5zIn7wQrhIaDPsklfKrO4TT68gOtnJMm1NJ1kMXy
0ecDHmUYaGPoUa9qLwLWamU5k/8Bf/eCP4a/b2ARA+vnZH0Zd7oc4eeNOY8x4Lpe
qyILADGncvGgFbCMsmjrHUoAgbLdNyk3X+krcfFhU9q+oLzGGtXk4GkOQQS76Fcm
+hqejrdpl6yBXjB6TJfCuqyiqfzfQTudh2MzE7zd7hmkrbdXCeI=
=jbWG
-----END PGP SIGNATURE-----

--EKVZS1cP0fVaEMCP--
