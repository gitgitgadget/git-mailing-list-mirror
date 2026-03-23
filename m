Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688DB3B6349
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278199; cv=none; b=G/h553k53uae5Ti5qnldc29MtSNsVXDt4lry77L/o6MAJP4WLxrECkpONM2l5xjKruo+uKu1i5e5b9645CUZU8WTyfk38jWwnOJjfwUJ+JrzHQN+t3uqX+BoVPDYgIvDIRNe1B76tNg8DAPG0uQbJ230w3qQiPVAbxqbqzhkiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278199; c=relaxed/simple;
	bh=AWXsToAR1ZBL3KnKVgeC+SD5rMf7wztrk8vQzRFoPcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=riWH2GbHK4CSquyvtMCTOZU7hbdHl8beHg2DH7Tfgwt3zi0BW1NomMKEL116sM1MJcjps3Sj47R1SyrbcCoBqd/zTZHSV1ci1OP9n9aR/r2hd252DksaCR+srRpE4QdBXF75kgZYxzbliAeBVHcifMBEjwRI5eLJdBPUmYrfXZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=beFXVxkd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XbH25HSV; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="beFXVxkd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XbH25HSV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A5ED67A0087;
	Mon, 23 Mar 2026 11:03:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 23 Mar 2026 11:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278197;
	 x=1774364597; bh=meskN4Zavh5SyO7ujXnQ3Rv0IUl42JZD/lc5ppa4Pbw=; b=
	beFXVxkdu/LTG9FIkfSUd04WlAcwL2/PnmkkFHAs/p1I17VwVzqBTN9T533OUSdq
	KFB8omZs2sPeeg2ZZ1Vcf+iwAZZIOJOaw63XOyC3wm3zUEc416OuI3tJQjn7bniO
	LkauZ3sKaH8OiNXlHC5+wW8gip38HrLpwM0vCVAAlhkmT6id5SjQfJeckQCGo+xp
	AiKpxdAXItm3tQ0Y/6lo8e8DS1DPBl+bEk/Bs0w0fiO5Zx1iIa6Z6T9nNz4t0JdF
	fbG2jdz7PvOb9W5xNcxupDmLtC+0Vo/nC93IvfWNB/qzeyt/OZSt8BTLH2DT2t3u
	59dONpVsUpl2POIb1+jEOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278197; x=
	1774364597; bh=meskN4Zavh5SyO7ujXnQ3Rv0IUl42JZD/lc5ppa4Pbw=; b=X
	bH25HSVWg76HlgR6GcPougduL7HTWF0Y5fojRLR3NdGWZSYGhQ78vEXn/XHymBiM
	TTjiSsg4AZ07lZw1GghYJqKMhUe53lEC9tSq83cgF6ITz2q/m0WvkY4K3Gub3oNS
	FXZdmYFQusKsLMZo2mwEglGtgWKo+e0SgUKi1YvbqBIucEwNlagK0hWL++q9xY9K
	c8IjuC4O7eduxjLeXBGAwD9O2SrY9TAgGJoPtvUBwg9veJSOTVNcN/aYddIdp3EE
	+Kls+TK3TXt1G6YEkp4SQnvL3QTy/3a+IzjtMokku+jNHq15+NdWwsg0LAZUq5UR
	UyreUVWzxT2P1huOTWEDw==
X-ME-Sender: <xms:NVbBaVEgCn52fm3yLCzVezIld-CWDJvS97k3dd5jooepCaRdYxP6UQ>
    <xme:NVbBaQUomKQ2Oq7OY9fdKfW4Yvi64HAoqcc-4yhfiqQxQR220ITyWi7htJqI298yO
    YFBs1eo6IooT0wNDQoe_XD_rjIm23jQrYQlVXTy8eI81ssRGcLyzg>
X-ME-Received: <xmr:NVbBaUx-ojdBFyLnJpzuhjFta9EbLMvSDap1II2RcgXO7iO7m1vV5ieHp-OHHv3g20Yhk3Dh2Mb2G3KCjJXQO6628K1PtxaeKAcosGxqIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NVbBaWNXkitUeHTk87nggrU9yUfLDVn1ywhYymat3eTCNghMPGZ3tg>
    <xmx:NVbBad6k3Fr6etqX9dAwogzWpfXKWJ9am0hw1eHwRhFuPhBKptxhQg>
    <xmx:NVbBafORUQolydNM2HstFXMxipLPZkLdyPL4ytgImoMW8TNWMSF51g>
    <xmx:NVbBaTkpdM9Y1KwPCFO48rlycilF5AP3on42Yobf8H8-png2tDuQtg>
    <xmx:NVbBaQer8sjVjBsE0uKe7zS8swcSCQNvmt4vwOTStLkE3IbLyRG3XJnC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 659bebc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Mar 2026 16:02:54 +0100
Subject: [PATCH v2 03/12] fsck: store repository in fsck options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-3-e8dc79bca651@pks.im>
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

The fsck subsystem relies on `the_repository` quite a bit. While we
could of course explicitly pass a repository down the callchain, we
already have a `struct fsck_options` that we pass to almost all
functions.

Extend the options to also store the repository to make it readily
available.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c           | 8 ++++----
 builtin/index-pack.c     | 2 +-
 builtin/mktag.c          | 4 ++--
 builtin/refs.c           | 4 ++--
 builtin/unpack-objects.c | 4 ++--
 fetch-pack.c             | 4 ++--
 fsck.c                   | 3 +++
 fsck.h                   | 4 ++++
 object-file.c            | 2 +-
 9 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 59e3b0f7ac..990d836918 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -243,7 +243,7 @@ static int mark_unreachable_referents(const struct object_id *oid,
 			object_as_type(obj, type, 0);
 	}
 
-	fsck_options_init(&options, FSCK_OPTIONS_DEFAULT);
+	fsck_options_init(&options, the_repository, FSCK_OPTIONS_DEFAULT);
 	options.walk = mark_used;
 	fsck_walk(obj, NULL, &options);
 	if (obj->type == OBJ_TREE)
@@ -987,7 +987,7 @@ static struct option fsck_opts[] = {
 int cmd_fsck(int argc,
 	     const char **argv,
 	     const char *prefix,
-	     struct repository *repo UNUSED)
+	     struct repository *repo)
 {
 	struct odb_source *source;
 	struct snapshot snap = {
@@ -1005,10 +1005,10 @@ int cmd_fsck(int argc,
 
 	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
 
-	fsck_options_init(&fsck_walk_options, FSCK_OPTIONS_DEFAULT);
+	fsck_options_init(&fsck_walk_options, repo, FSCK_OPTIONS_DEFAULT);
 	fsck_walk_options.walk = mark_object;
 
-	fsck_options_init(&fsck_obj_options, FSCK_OPTIONS_DEFAULT);
+	fsck_options_init(&fsck_obj_options, repo, FSCK_OPTIONS_DEFAULT);
 	fsck_obj_options.walk = mark_used;
 	fsck_obj_options.error_func = fsck_objects_error_func;
 	if (check_strict)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c8d28bcf8e..e4129bd605 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1909,7 +1909,7 @@ int cmd_index_pack(int argc,
 
 	disable_replace_refs();
 
-	fsck_options_init(&fsck_options, FSCK_OPTIONS_MISSING_GITMODULES);
+	fsck_options_init(&fsck_options, the_repository, FSCK_OPTIONS_MISSING_GITMODULES);
 	fsck_options.walk = mark_link;
 
 	reset_pack_idx_option(&opts);
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 9f37f9dede..f40264a878 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -75,7 +75,7 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 int cmd_mktag(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      struct repository *repo)
 {
 	static struct option builtin_mktag_options[] = {
 		OPT_BOOL(0, "strict", &option_strict,
@@ -94,7 +94,7 @@ int cmd_mktag(int argc,
 	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno(_("could not read from stdin"));
 
-	fsck_options_init(&fsck_options, FSCK_OPTIONS_STRICT);
+	fsck_options_init(&fsck_options, repo, FSCK_OPTIONS_STRICT);
 	fsck_options.error_func = mktag_fsck_error_func;
 	fsck_set_msg_type_from_ids(&fsck_options, FSCK_MSG_EXTRA_HEADER_ENTRY,
 				   FSCK_WARN);
diff --git a/builtin/refs.c b/builtin/refs.c
index 1719ada549..e3125bc61b 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -78,7 +78,7 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 }
 
 static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
-			   struct repository *repo UNUSED)
+			   struct repository *repo)
 {
 	struct fsck_options fsck_refs_options;
 	struct worktree **worktrees;
@@ -93,7 +93,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	};
 	int ret = 0;
 
-	fsck_options_init(&fsck_refs_options, FSCK_OPTIONS_REFS);
+	fsck_options_init(&fsck_refs_options, repo, FSCK_OPTIONS_REFS);
 
 	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
 	if (argc)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 9e4bb9d25c..d863912b24 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -613,7 +613,7 @@ static void unpack_all(void)
 int cmd_unpack_objects(int argc,
 		       const char **argv,
 		       const char *prefix UNUSED,
-		       struct repository *repo UNUSED)
+		       struct repository *repo)
 {
 	int i;
 	struct object_id oid;
@@ -627,7 +627,7 @@ int cmd_unpack_objects(int argc,
 
 	show_usage_if_asked(argc, argv, unpack_usage);
 
-	fsck_options_init(&fsck_options, FSCK_OPTIONS_STRICT);
+	fsck_options_init(&fsck_options, repo, FSCK_OPTIONS_STRICT);
 
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/fetch-pack.c b/fetch-pack.c
index 7339162368..84a21c5107 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1229,7 +1229,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	} else
 		alternate_shallow_file = NULL;
 
-	fsck_options_init(&fsck_options, FSCK_OPTIONS_MISSING_GITMODULES);
+	fsck_options_init(&fsck_options, the_repository, FSCK_OPTIONS_MISSING_GITMODULES);
 	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought,
 		     &fsck_options.gitmodules_found))
 		die(_("git fetch-pack: fetch failed."));
@@ -1675,7 +1675,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct strvec index_pack_args = STRVEC_INIT;
 	const char *promisor_remote_config;
 
-	fsck_options_init(&fsck_options, FSCK_OPTIONS_MISSING_GITMODULES);
+	fsck_options_init(&fsck_options, the_repository, FSCK_OPTIONS_MISSING_GITMODULES);
 
 	if (server_feature_v2("promisor-remote", &promisor_remote_config))
 		promisor_remote_reply(promisor_remote_config, NULL);
diff --git a/fsck.c b/fsck.c
index 1ff8208502..a05997703a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1381,6 +1381,7 @@ bool fsck_has_queued_checks(struct fsck_options *options)
 }
 
 void fsck_options_init(struct fsck_options *options,
+		       struct repository *repo,
 		       enum fsck_options_type type)
 {
 	static const struct fsck_options defaults[] = {
@@ -1423,6 +1424,8 @@ void fsck_options_init(struct fsck_options *options,
 	default:
 		BUG("unknown fsck options type %d", type);
 	}
+
+	options->repo = repo;
 }
 
 void fsck_options_clear(struct fsck_options *options)
diff --git a/fsck.h b/fsck.h
index 9c973b53b2..e77935c8a9 100644
--- a/fsck.h
+++ b/fsck.h
@@ -166,7 +166,10 @@ struct fsck_ref_report {
 	const char *path;
 };
 
+struct repository;
+
 struct fsck_options {
+	struct repository *repo;
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict;
@@ -235,6 +238,7 @@ enum fsck_options_type {
 };
 
 void fsck_options_init(struct fsck_options *options,
+		       struct repository *repo,
 		       enum fsck_options_type type);
 
 /*
diff --git a/object-file.c b/object-file.c
index 186b2ff764..24ed5d5577 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1281,7 +1281,7 @@ static int index_mem(struct index_state *istate,
 	if (flags & INDEX_FORMAT_CHECK) {
 		struct fsck_options opts;
 
-		fsck_options_init(&opts, FSCK_OPTIONS_DEFAULT);
+		fsck_options_init(&opts, the_repository, FSCK_OPTIONS_DEFAULT);
 		opts.strict = 1;
 		opts.error_func = hash_format_check_report;
 		if (fsck_buffer(null_oid(istate->repo->hash_algo), type, buf, size, &opts))

-- 
2.53.0.1118.gaef5881109.dirty

