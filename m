Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A2B3B2FE9
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278197; cv=none; b=bwHkXRN4U0nfovp4z6GnCzcaiqd/P7gcCtSX7FHXZ3oc2Njv1ZSOtlA8VcQnn2ch1JjFC33peCQodsFP2awxp+/AA1qw7JOov4uAxBdb84wovlYoLvDnfkyZEFWG1dekxEGzMV+g+4XJCdFRYhxNCqzX3ZJufwl3O8Tmd+L7A0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278197; c=relaxed/simple;
	bh=nJR2nY8ehEbrQVqXI/uEKZDdND5gO6KcGwEv4NU045s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxiVU2sqZIO6XBvRv5wfWnI6AXure6RT9QVyRKDr5EOCWN70oWQW8QElomfpD1pF+gP6V9YHzhvHvdYFJa3Knzudh3PMV/ifi5qpz3P2qWVqTuS+tGGb46rPYpfoR2I24ya7HQ/7AWaRm4HTjio9NEBKuWfoEBUCdAQhz+GiEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QSIGrAYt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zKY3/r4U; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QSIGrAYt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zKY3/r4U"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E53E7A0087;
	Mon, 23 Mar 2026 11:03:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 23 Mar 2026 11:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278195;
	 x=1774364595; bh=b01p6r+zAtwTNsxt3mrmR38l4SemJcyftFb63AP9vIo=; b=
	QSIGrAYt7z28Wbkji1cEEAv0XfjTdFtF7fMFXhS6JWGYeSqtSWjsoIDi0gz/hFNg
	zkuy8tAL49lpXQIOPOYfiDIZeIMtaCktxWLOX7SfcMvYvyn5WjE4St07wC2+91yC
	HWO+qZXVRSjD3fGl9c2HWnF9WRLwva1Q3jbnHHxlM2XBg7GQJQUU0XWNMj8zZNvC
	PpVUf3SCOftGv6iFqLgVTCZhIaizI1XrQsA8t3m1knViwxE3FiQMrs6iOKZ1Li4M
	MY2CsBliDKpDTOdmcRVa7YqqQZGfHb8bxFRO1jAqfLdCUhgt5L1AoFZweRPqru2X
	/KTbXSuaJPnloB+TRxaAEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278195; x=
	1774364595; bh=b01p6r+zAtwTNsxt3mrmR38l4SemJcyftFb63AP9vIo=; b=z
	KY3/r4UdfqEfGmMYZBKBGj9aKA/oKq1GMUnDbfsOocBh9EWBb72EDT8q38gRNwWK
	KB62UYhY8E935qJYH4fQ0QcVVCborcHDeupu89K96uV9hiJRsxbXivSb18sfMBY7
	YggB5BAynXEU9AvP8rESoD1wMolj+RO4Ui3F5xZyjxK4V7dFd9V7tMGfkqAqa9mG
	B13bTrvHJypPORmhwNJ/h8qs8ujaNNN5+EEo5IysIoDqMBcvZD/2DMMi5sM2DGAy
	DqqfHXKGYiFGP/iD1M3pbr8Pysac7eX+njFhfys3oVGWQynZECba/hrVtXtgT3v4
	H/M21CTb5NB/hi9K/WZCg==
X-ME-Sender: <xms:M1bBaVtOOgE3XefKDU7YLgZfS2vxcwiWNwxn4dyLxGEoVVssU_JrtQ>
    <xme:M1bBaUe-sOay1GU-I2f77lzJo8h61rrZIX7XoToeH_RTJSx9lD_myAoAKK5XRM7zE
    oi9ytR2LwxNJ9-qlEmTkUw31cm8kpP3gPOC7v-qaIBqaqM65Vnd7g>
X-ME-Received: <xmr:M1bBaWbE8TPiQb5etGgz5g0NwlcTVpkcA7cR9zmgjMpz_rSPqfNhWRC1s0MbiBBbEFkWIhfxebZ5gLbx5ZlhG_dsQRcpYySZl5m49dJH2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:M1bBaXWMRv5Oqc-6Qq-nZqYeBbz01zj6mpSkvuwBJ88zwu5fu9l9eA>
    <xmx:M1bBaYhp3YHD-HgYoiJAZKEGTF4QRTguLBr6n_kKc2I1HecU_THFkw>
    <xmx:M1bBaVUKDg8PMxMYlEQnb2mMkxxaL0LH3Wl75gfYXsZU7ZqZdAD8FQ>
    <xmx:M1bBafN2Mx5ZjUJpjmGhEEDjd_lh3yFBzouU7jo2VU38LJTIDUgUlg>
    <xmx:M1bBaRGmFCvGAMyLhshWEAn8rjyFkBG5mjtzYAEtEP01Pz3Uy2NXs94M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fac67141 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Mar 2026 16:02:53 +0100
Subject: [PATCH v2 02/12] fsck: initialize fsck options via a function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-2-e8dc79bca651@pks.im>
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We initialize the `struct fsck_options` via a set of macros, often in
global scope. In the next commit though we're about to introduce a new
repository field to the options that must be initialized, and naturally
we don't have a repo other than `the_repository` available in this
scope.

Refactor the code to instead intrdouce a new `fsck_options_init()`
function that initializes the options for us and move initialization
into function scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c           | 10 +++++++---
 builtin/index-pack.c     |  4 +++-
 builtin/mktag.c          |  3 ++-
 builtin/refs.c           |  4 +++-
 builtin/unpack-objects.c |  4 +++-
 fetch-pack.c             |  8 ++++++--
 fsck.c                   | 45 +++++++++++++++++++++++++++++++++++++++++++++
 fsck.h                   | 38 ++++++++++----------------------------
 object-file.c            |  3 ++-
 9 files changed, 81 insertions(+), 38 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9bab32effe..59e3b0f7ac 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -42,8 +42,8 @@ static int check_full = 1;
 static int connectivity_only;
 static int check_strict;
 static int keep_cache_objects;
-static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
-static struct fsck_options fsck_obj_options = FSCK_OPTIONS_DEFAULT;
+static struct fsck_options fsck_walk_options;
+static struct fsck_options fsck_obj_options;
 static int errors_found;
 static int write_lost_and_found;
 static int verbose;
@@ -224,7 +224,7 @@ static int mark_unreachable_referents(const struct object_id *oid,
 				      struct object_info *oi UNUSED,
 				      void *data UNUSED)
 {
-	struct fsck_options options = FSCK_OPTIONS_DEFAULT;
+	struct fsck_options options;
 	struct object *obj = lookup_object(the_repository, oid);
 
 	if (!obj || !(obj->flags & HAS_OBJ))
@@ -243,6 +243,7 @@ static int mark_unreachable_referents(const struct object_id *oid,
 			object_as_type(obj, type, 0);
 	}
 
+	fsck_options_init(&options, FSCK_OPTIONS_DEFAULT);
 	options.walk = mark_used;
 	fsck_walk(obj, NULL, &options);
 	if (obj->type == OBJ_TREE)
@@ -1004,7 +1005,10 @@ int cmd_fsck(int argc,
 
 	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
 
+	fsck_options_init(&fsck_walk_options, FSCK_OPTIONS_DEFAULT);
 	fsck_walk_options.walk = mark_object;
+
+	fsck_options_init(&fsck_obj_options, FSCK_OPTIONS_DEFAULT);
 	fsck_obj_options.walk = mark_used;
 	fsck_obj_options.error_func = fsck_objects_error_func;
 	if (check_strict)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d1e47279a8..c8d28bcf8e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -136,7 +136,7 @@ static int nr_threads;
 static int from_stdin;
 static int strict;
 static int do_fsck_object;
-static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
+static struct fsck_options fsck_options;
 static int verbose;
 static const char *progress_title;
 static int show_resolving_progress;
@@ -1908,6 +1908,8 @@ int cmd_index_pack(int argc,
 	show_usage_if_asked(argc, argv, index_pack_usage);
 
 	disable_replace_refs();
+
+	fsck_options_init(&fsck_options, FSCK_OPTIONS_MISSING_GITMODULES);
 	fsck_options.walk = mark_link;
 
 	reset_pack_idx_option(&opts);
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 7cf6e1230a..9f37f9dede 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -16,7 +16,7 @@ static char const * const builtin_mktag_usage[] = {
 };
 static int option_strict = 1;
 
-static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+static struct fsck_options fsck_options;
 
 static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
 				 void *fsck_report UNUSED,
@@ -94,6 +94,7 @@ int cmd_mktag(int argc,
 	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno(_("could not read from stdin"));
 
+	fsck_options_init(&fsck_options, FSCK_OPTIONS_STRICT);
 	fsck_options.error_func = mktag_fsck_error_func;
 	fsck_set_msg_type_from_ids(&fsck_options, FSCK_MSG_EXTRA_HEADER_ENTRY,
 				   FSCK_WARN);
diff --git a/builtin/refs.c b/builtin/refs.c
index 3064f888b2..1719ada549 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -80,7 +80,7 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 			   struct repository *repo UNUSED)
 {
-	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
+	struct fsck_options fsck_refs_options;
 	struct worktree **worktrees;
 	const char * const verify_usage[] = {
 		REFS_VERIFY_USAGE,
@@ -93,6 +93,8 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	};
 	int ret = 0;
 
+	fsck_options_init(&fsck_refs_options, FSCK_OPTIONS_REFS);
+
 	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
 	if (argc)
 		usage(_("'git refs verify' takes no arguments"));
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6fc64e9e4b..9e4bb9d25c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -29,7 +29,7 @@ static unsigned int offset, len;
 static off_t consumed_bytes;
 static off_t max_input_size;
 static struct git_hash_ctx ctx;
-static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+static struct fsck_options fsck_options;
 static struct progress *progress;
 
 /*
@@ -627,6 +627,8 @@ int cmd_unpack_objects(int argc,
 
 	show_usage_if_asked(argc, argv, unpack_usage);
 
+	fsck_options_init(&fsck_options, FSCK_OPTIONS_STRICT);
+
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/fetch-pack.c b/fetch-pack.c
index ec5abb92b5..7339162368 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1099,7 +1099,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 struct shallow_info *si,
 				 struct string_list *pack_lockfiles)
 {
-	struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
+	struct fsck_options fsck_options = { 0 };
 	struct repository *r = the_repository;
 	struct ref *ref = copy_ref_list(orig_ref);
 	struct object_id oid;
@@ -1228,6 +1228,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		alternate_shallow_file = setup_temporary_shallow(si->shallow);
 	} else
 		alternate_shallow_file = NULL;
+
+	fsck_options_init(&fsck_options, FSCK_OPTIONS_MISSING_GITMODULES);
 	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought,
 		     &fsck_options.gitmodules_found))
 		die(_("git fetch-pack: fetch failed."));
@@ -1655,7 +1657,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    struct string_list *pack_lockfiles)
 {
 	struct repository *r = the_repository;
-	struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
+	struct fsck_options fsck_options;
 	struct ref *ref = copy_ref_list(orig_ref);
 	enum fetch_state state = FETCH_CHECK_LOCAL;
 	struct oidset common = OIDSET_INIT;
@@ -1673,6 +1675,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct strvec index_pack_args = STRVEC_INIT;
 	const char *promisor_remote_config;
 
+	fsck_options_init(&fsck_options, FSCK_OPTIONS_MISSING_GITMODULES);
+
 	if (server_feature_v2("promisor-remote", &promisor_remote_config))
 		promisor_remote_reply(promisor_remote_config, NULL);
 
diff --git a/fsck.c b/fsck.c
index 0f02cf8f77..1ff8208502 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1380,6 +1380,51 @@ bool fsck_has_queued_checks(struct fsck_options *options)
 	       !oidset_equal(&options->gitattributes_found, &options->gitattributes_done);
 }
 
+void fsck_options_init(struct fsck_options *options,
+		       enum fsck_options_type type)
+{
+	static const struct fsck_options defaults[] = {
+		[FSCK_OPTIONS_DEFAULT] = {
+			.skip_oids = OIDSET_INIT,
+			.gitmodules_found = OIDSET_INIT,
+			.gitmodules_done = OIDSET_INIT,
+			.gitattributes_found = OIDSET_INIT,
+			.gitattributes_done = OIDSET_INIT,
+			.error_func = fsck_objects_error_function
+		},
+		[FSCK_OPTIONS_STRICT] = {
+			.strict = 1,
+			.gitmodules_found = OIDSET_INIT,
+			.gitmodules_done = OIDSET_INIT,
+			.gitattributes_found = OIDSET_INIT,
+			.gitattributes_done = OIDSET_INIT,
+			.error_func = fsck_objects_error_function,
+		},
+		[FSCK_OPTIONS_MISSING_GITMODULES] = {
+			.strict = 1,
+			.gitmodules_found = OIDSET_INIT,
+			.gitmodules_done = OIDSET_INIT,
+			.gitattributes_found = OIDSET_INIT,
+			.gitattributes_done = OIDSET_INIT,
+			.error_func = fsck_objects_error_cb_print_missing_gitmodules,
+		},
+		[FSCK_OPTIONS_REFS] = {
+			.error_func = fsck_refs_error_function,
+		},
+	};
+
+	switch (type) {
+	case FSCK_OPTIONS_DEFAULT:
+	case FSCK_OPTIONS_STRICT:
+	case FSCK_OPTIONS_MISSING_GITMODULES:
+	case FSCK_OPTIONS_REFS:
+		memcpy(options, &defaults[type], sizeof(*options));
+		break;
+	default:
+		BUG("unknown fsck options type %d", type);
+	}
+}
+
 void fsck_options_clear(struct fsck_options *options)
 {
 	free(options->msg_type);
diff --git a/fsck.h b/fsck.h
index 65ecbb7fe1..9c973b53b2 100644
--- a/fsck.h
+++ b/fsck.h
@@ -180,34 +180,6 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { \
-	.skip_oids = OIDSET_INIT, \
-	.gitmodules_found = OIDSET_INIT, \
-	.gitmodules_done = OIDSET_INIT, \
-	.gitattributes_found = OIDSET_INIT, \
-	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_objects_error_function \
-}
-#define FSCK_OPTIONS_STRICT { \
-	.strict = 1, \
-	.gitmodules_found = OIDSET_INIT, \
-	.gitmodules_done = OIDSET_INIT, \
-	.gitattributes_found = OIDSET_INIT, \
-	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_objects_error_function, \
-}
-#define FSCK_OPTIONS_MISSING_GITMODULES { \
-	.strict = 1, \
-	.gitmodules_found = OIDSET_INIT, \
-	.gitmodules_done = OIDSET_INIT, \
-	.gitattributes_found = OIDSET_INIT, \
-	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
-}
-#define FSCK_REFS_OPTIONS_DEFAULT { \
-	.error_func = fsck_refs_error_function, \
-}
-
 /* descend in all linked child objects
  * the return value is:
  *    -1	error in processing the object
@@ -255,6 +227,16 @@ int fsck_finish(struct fsck_options *options);
  */
 bool fsck_has_queued_checks(struct fsck_options *options);
 
+enum fsck_options_type {
+	FSCK_OPTIONS_DEFAULT,
+	FSCK_OPTIONS_STRICT,
+	FSCK_OPTIONS_MISSING_GITMODULES,
+	FSCK_OPTIONS_REFS,
+};
+
+void fsck_options_init(struct fsck_options *options,
+		       enum fsck_options_type type);
+
 /*
  * Clear the fsck_options struct, freeing any allocated memory.
  */
diff --git a/object-file.c b/object-file.c
index c62e5496e0..186b2ff764 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1279,8 +1279,9 @@ static int index_mem(struct index_state *istate,
 		}
 	}
 	if (flags & INDEX_FORMAT_CHECK) {
-		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
+		struct fsck_options opts;
 
+		fsck_options_init(&opts, FSCK_OPTIONS_DEFAULT);
 		opts.strict = 1;
 		opts.error_func = hash_format_check_report;
 		if (fsck_buffer(null_oid(istate->repo->hash_algo), type, buf, size, &opts))

-- 
2.53.0.1118.gaef5881109.dirty

