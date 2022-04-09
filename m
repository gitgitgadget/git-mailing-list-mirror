Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52CEC433F5
	for <git@archiver.kernel.org>; Sat,  9 Apr 2022 06:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbiDIGyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Apr 2022 02:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiDIGyV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Apr 2022 02:54:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D41AF20
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 23:52:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b6-20020a5b0b46000000b0063dcbfa6dd3so8357843ybr.2
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 23:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=6dYUx2asI7cA8qzViFkAOjF68cIvKw0NvgaE8quVxEM=;
        b=Z2khKXSlGHh0tA+m31i3kVwQEE6pEnGXM4TzfuhF7QQGbsmsfdy6XcD9qzyuGy65/S
         hpD29tAzQ3cr/ol9tVSJ20qKb2YXQonW3fwHkwt8x7/Zy4P0Ty8jEAoKrd8KO/BEf1aM
         dRNE6KMlgJ0dZhkH83KGdKYs5ziLXGiimLJK1vJRQmMRu4VmPw5nwU+cOB91jrMb+dcH
         Tqs+cFicgcn1GDzhUtji7lUHGpbOZMSt5R0HNzz2clY6vKJf8a1DTLsoIqy7x3vvR/23
         tQs5Dt6EXg0xvCkqHqEGof03Rh1MznKd0/WlmvtdFK1OPaHeEanQ3qYCIj1TFDXYBxFf
         oMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=6dYUx2asI7cA8qzViFkAOjF68cIvKw0NvgaE8quVxEM=;
        b=Z/ViC1EHRVSZ4ASZQD79cDW+4YY7xEGqOypvzoZxc83ybF3sOKwWH/9KdAknXp8FYb
         RdsKr5SFUskk2AI1k7KIwpDcBs7iYMnH3cuqkmrbmqddgmipGdVLoFCqqxuf8DFXSmHY
         CpHQVNAVp2kHRJs+LawZBpVI/RrqAjkejX+7yv0dKDRZGnDM/QMOnvNbHaqRB4HqZ37M
         INqSO1l+8VkvROPyrircKaQpwc3RvILlOdyUp2te1H8v4+SSH+B7dYmFYxvzZQC0qpWp
         wYW+uBbJ6vxJlIx2P8ukrWpI644+hdCq/U5NYD3FXi6KnV7dHtgqgIew9En92B5nF7R0
         C7QA==
X-Gm-Message-State: AOAM5335Ft22cfu6+qSxYj1nUo9clfM2/2qB9L0Oda52AC0BHaKgck2P
        n6548wgsLf57wWkKopp5KT+0+ickj6fWcaFgVHZ1PhmZ6dC3t1MemyKQrhlGBiH/gRWq/3Avhqs
        dpvkAaVps8Aei1/4qKANWZqT4oA0r+dJdxgZ4g8kcVfAnfY93gm0XzmCu7KfwiWM=
X-Google-Smtp-Source: ABdhPJzZhY9eVzcibqDv88ckwFtclPoFPopGxJGfJ/JZT2mZ4a4or9jzbz0hvvIq8T7Vq7rfpP3Y7eWOAE7HrA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:e11f:3ca:fe42:191e])
 (user=steadmon job=sendgmr) by 2002:a81:5215:0:b0:2eb:572a:939a with SMTP id
 g21-20020a815215000000b002eb572a939amr18971567ywb.137.1649487132423; Fri, 08
 Apr 2022 23:52:12 -0700 (PDT)
Date:   Fri,  8 Apr 2022 23:52:10 -0700
In-Reply-To: <Yjt6mLIfw0V3aVTO@nand.local>
Message-Id: <2c2bfc7b43c92dc7c0a4c47a2c88dadeb39c763b.1649486398.git.steadmon@google.com>
Mime-Version: 1.0
References: <Yjt6mLIfw0V3aVTO@nand.local>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [RFC PATCH v2] commit-graph: refactor to avoid prepare_repo_settings
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, derrickstolee@github.com,
        lessleydennington@gmail.com, gitster@pobox.com, vdye@github.com,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

Prior to ab14d0676c (commit-graph: pass a 'struct repository *' in more
places, 2020-09-09), parsing a commit-graph was a pure function
depending only on the contents of the commit-graph itself. Commit
ab14d0676c introduced a dependency on a `struct repository` pointer, and
later commits such as b66d84756f (commit-graph: respect
'commitGraph.readChangedPaths', 2020-09-09) added dependencies on config
settings, which were accessed through the `settings` field of the
repository pointer. This field was initialized via a call to
`prepare_repo_settings()`.

In 44c7e62 (2021-12-06, repo-settings:prepare_repo_settings only in git
repos), prepare_repo_settings was changed to issue a BUG() if it is
called by a process whose CWD is not a Git repository.

This series of changes broke fuzz-commit-graph, which attempts to parse
arbitrary fuzzing-engine-provided bytes as a commit graph file.
commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
since we run the fuzz tests without a valid repository, we are hitting
the BUG() from 44c7e62 for every test case.

Fix this by moving the majority of the implementaiton of
`parse_commit_graph()` into a new function,
`parse_commit_graph_settings()` that accepts a repo_settings pointer.
This allows fuzz-commit-graph to continue to test the commit-graph
parser implementation without relying on prepare_repo_settings().

Additionally, properly initialize the
repo_settings.commit_graph_generation_version field in
prepare_repo_settings(). Load the value from the config if present, and
default to version 2 otherwise.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
I've taken the diff from Taylor's message Yjt6mLIfw0V3aVTO@nand.local
with a small tweak to the fuzzer: I didn't see that the commit graph
settings were being initialized anywhere outside of
prepare_repo_settings(), so I manually initialized them in
fuzz-commit-graph. I've also moved the commit-graph settings in
prepare_repo_settings() to their own section, as suggested by =C3=86var.

I've tried to combine Taylor's explanation from his email with the
commit message from my original patch. Taylor, if you feel like anything
needs to be changed please let me know or feel free to resend with your
changes. Thanks again for providing this fix!

 commit-graph.c      | 22 ++++++++++------------
 commit-graph.h      |  2 ++
 fuzz-commit-graph.c |  8 +++++++-
 repo-settings.c     | 12 +++++++++++-
 repository.h        |  1 +
 5 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 265c010122..c54a734619 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -96,13 +96,6 @@ define_commit_slab(commit_graph_data_slab, struct commit=
_graph_data);
 static struct commit_graph_data_slab commit_graph_data_slab =3D
 	COMMIT_SLAB_INIT(1, commit_graph_data_slab);
=20
-static int get_configured_generation_version(struct repository *r)
-{
-	int version =3D 2;
-	repo_config_get_int(r, "commitgraph.generationversion", &version);
-	return version;
-}
-
 uint32_t commit_graph_position(const struct commit *c)
 {
 	struct commit_graph_data *data =3D
@@ -335,6 +328,13 @@ static int graph_read_bloom_data(const unsigned char *=
chunk_start,
=20
 struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size)
+{
+	prepare_repo_settings(r);
+	return parse_commit_graph_settings(&r->settings, graph_map, graph_size);
+}
+
+struct commit_graph *parse_commit_graph_settings(struct repo_settings *s,
+						 void *graph_map, size_t graph_size)
 {
 	const unsigned char *data;
 	struct commit_graph *graph;
@@ -371,8 +371,6 @@ struct commit_graph *parse_commit_graph(struct reposito=
ry *r,
 		return NULL;
 	}
=20
-	prepare_repo_settings(r);
-
 	graph =3D alloc_commit_graph();
=20
 	graph->hash_len =3D the_hash_algo->rawsz;
@@ -402,14 +400,14 @@ struct commit_graph *parse_commit_graph(struct reposi=
tory *r,
 	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
 	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
=20
-	if (get_configured_generation_version(r) >=3D 2) {
+	if (s->commit_graph_generation_version >=3D 2) {
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
 			&graph->chunk_generation_data);
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
 			&graph->chunk_generation_data_overflow);
 	}
=20
-	if (r->settings.commit_graph_read_changed_paths) {
+	if (s->commit_graph_read_changed_paths) {
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
@@ -2288,7 +2286,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split =3D flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->opts =3D opts;
 	ctx->total_bloom_filter_data_size =3D 0;
-	ctx->write_generation_data =3D (get_configured_generation_version(r) =3D=
=3D 2);
+	ctx->write_generation_data =3D (r->settings.commit_graph_generation_versi=
on =3D=3D 2);
 	ctx->num_generation_data_overflows =3D 0;
=20
 	bloom_settings.bits_per_entry =3D git_env_ulong("GIT_TEST_BLOOM_SETTINGS_=
BITS_PER_ENTRY",
diff --git a/commit-graph.h b/commit-graph.h
index 04a94e1830..0f0d28b129 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -95,6 +95,8 @@ struct commit_graph *read_commit_graph_one(struct reposit=
ory *r,
 					   struct object_directory *odb);
 struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size);
+struct commit_graph *parse_commit_graph_settings(struct repo_settings *s,
+					void *graph_map, size_t graph_size);
=20
 /*
  * Return 1 if and only if the repository has a commit-graph
diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
index e7cf6d5b0f..e53a2635f6 100644
--- a/fuzz-commit-graph.c
+++ b/fuzz-commit-graph.c
@@ -11,7 +11,13 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t s=
ize)
 	struct commit_graph *g;
=20
 	initialize_the_repository();
-	g =3D parse_commit_graph(the_repository, (void *)data, size);
+	/*
+	 * Manually initialize commit-graph settings, to avoid the need to run
+	 * in an actual repository.
+	 */
+	the_repository->settings.commit_graph_generation_version =3D 2;
+	the_repository->settings.commit_graph_read_changed_paths =3D 1;
+	g =3D parse_commit_graph_settings(&the_repository->settings, (void *)data=
, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);
=20
diff --git a/repo-settings.c b/repo-settings.c
index b4fbd16cdc..26241c1c2c 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -10,6 +10,13 @@ static void repo_cfg_bool(struct repository *r, const ch=
ar *key, int *dest,
 		*dest =3D def;
 }
=20
+static void repo_cfg_int(struct repository *r, const char *key, int *dest,
+			 int def)
+{
+	if (repo_config_get_int(r, key, dest))
+		*dest =3D def;
+}
+
 void prepare_repo_settings(struct repository *r)
 {
 	int experimental;
@@ -41,11 +48,14 @@ void prepare_repo_settings(struct repository *r)
 		r->settings.core_untracked_cache =3D UNTRACKED_CACHE_WRITE;
 	}
=20
-	/* Boolean config or default, does not cascade (simple)  */
+	/* Commit graph config or default, does not cascade (simple) */
 	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
+	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_grap=
h_generation_version, 2);
 	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_grap=
h_read_changed_paths, 1);
 	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_grap=
h, 1);
 	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commi=
t_graph, 0);
+
+	/* Boolean config or default, does not cascade (simple)  */
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_inde=
x, 1);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
diff --git a/repository.h b/repository.h
index ca837cb9e9..4f8275f97c 100644
--- a/repository.h
+++ b/repository.h
@@ -29,6 +29,7 @@ struct repo_settings {
 	int initialized;
=20
 	int core_commit_graph;
+	int commit_graph_generation_version;
 	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;

base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
--=20
2.35.1.1178.g4f1659d476-goog

