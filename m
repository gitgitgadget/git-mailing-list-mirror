Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD9CC43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiGNVnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiGNVnL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:43:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45286EEAF
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:43:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w15-20020a25ac0f000000b0066e50e4a553so2533373ybi.16
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QwlKb5kxbwVQ/mFKll1cL7e0JFuqiqp4wT1D0aoCkqM=;
        b=eCBSCPFeAnNeyE0TCi9WNA4r2GbFSFwdRKOUPmxu4IE4F4dpZdztI7hpVzW6X7ZqBg
         l7VItF4AMiRFex3jnBrMi7+JlOj3bGBo/kZ0eEIakaI4ELEps5c9cZj1FB2EoJMzfJ9A
         GJSIUo9sgaWlbOQvZC8R8HvJV/8h39RlcRd8NRoHLG5ZhnVXsnBakRfIYmDRxUoI8GcT
         ccA0c76X/CpaZKUwMwIc1khSf1ZT6pSoaN0efPKggqzd54L9Ee0fl6L/7klcTlMaEFcn
         UlCSDbBxHYzvzN1ghrbju0g6rMRDkZ8DvzWNvw/NaGAJ1wjwMMquTz+KXLg7u4vflu3Z
         8qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QwlKb5kxbwVQ/mFKll1cL7e0JFuqiqp4wT1D0aoCkqM=;
        b=mxFxoUDVYAWjzp9tJE4rhO8Lxlm6R5sq3IwB278W8C3WJw+9H11ZE9rKRn7OmRzy2X
         etxH4ujgdAL+hh2xJL3Klp9ruL7FclpyWUkqr3BP1uBSvtDzsRu5xKbRYkuNPKZw/nmf
         vidU0d9BMov8iH8LFSP2oES0PJNG57y9H1klj8yNYqLyajL9PS78Aa3Xrg5JvXMU3mbS
         4ArD5NeUcRJMDGcHqGrdBDCQFYuDlekdpPFIs9UHGMybKwNlwHkd5UW23WChjk3v+pUY
         RJk8XJto0cEA5+GOqeJ5ge+eyUT0UiIQ4e+s/NWvyqyMwbHZit9DclYLegWFUfrS8TjV
         KJcg==
X-Gm-Message-State: AJIora/tPGgztvb8uCyBUuI2ye9lHbNxGTnDjoQl5CEuASgpdZeltMO8
        yNtdj9Y0pssogrbhipc049NW/rqB9YapP9PaVFafhmB3zWfTE51Cfe0Q/xT/SYJ1+eWqei9yRGk
        ZpvkDvROcFJvSdC8+FV9tuzJU+iZK9e490GXHeWM+krYzYhzRX2ggPfgu5v0/Bmg=
X-Google-Smtp-Source: AGRyM1tM9jWocgOmTAHKz2Uty6AIJOGSFouiGX9sBLI7YDno2G1OPTaxWcNoC9AaUgdt8WjKjRdVBJ+UxiyVAQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:8983:501b:77cd:111d])
 (user=steadmon job=sendgmr) by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP
 id w9-20020a05690210c900b00668e27c08f7mr10711271ybu.128.1657834989159; Thu,
 14 Jul 2022 14:43:09 -0700 (PDT)
Date:   Thu, 14 Jul 2022 14:43:06 -0700
In-Reply-To: <Yjt6mLIfw0V3aVTO@nand.local>
Message-Id: <fd70b6119153b165a62ee4f693dbe47031cfb2be.1657834657.git.steadmon@google.com>
Mime-Version: 1.0
References: <Yjt6mLIfw0V3aVTO@nand.local>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4] commit-graph: pass repo_settings instead of repository
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

The parse_commit_graph() function takes a 'struct repository *' pointer,
but it only ever accesses config settings (either directly or through
the .settings field of the repo struct). Move all relevant config
settings into the repo_settings struct, and update parse_commit_graph()
and its existing callers so that it takes 'struct repo_settings *'
instead.

Callers of parse_commit_graph() will now need to call
prepare_repo_settings() themselves, or initialize a 'struct
repo_settings' directly.

Prior to ab14d0676c (commit-graph: pass a 'struct repository *' in more
places, 2020-09-09), parsing a commit-graph was a pure function
depending only on the contents of the commit-graph itself. Commit
ab14d0676c introduced a dependency on a `struct repository` pointer, and
later commits such as b66d84756f (commit-graph: respect
'commitGraph.readChangedPaths', 2020-09-09) added dependencies on config
settings, which were accessed through the `settings` field of the
repository pointer. This field was initialized via a call to
`prepare_repo_settings()`.

Additionally, this fixes an issue in fuzz-commit-graph: In 44c7e62
(2021-12-06, repo-settings:prepare_repo_settings only in git repos),
prepare_repo_settings was changed to issue a BUG() if it is called by a
process whose CWD is not a Git repository.

The combination of commits mentioned above broke fuzz-commit-graph,
which attempts to parse arbitrary fuzzing-engine-provided bytes as a
commit graph file. Prior to this change, parse_commit_graph() called
prepare_repo_settings(), but since we run the fuzz tests without a valid
repository, we are hitting the BUG() from 44c7e62 for every test case.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Range-diff against v3:
1:  9b56496b08 ! 1:  fd70b61191 commit-graph: refactor to avoid prepare_repo_settings
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    commit-graph: refactor to avoid prepare_repo_settings
    +    commit-graph: pass repo_settings instead of repository
    +
    +    The parse_commit_graph() function takes a 'struct repository *' pointer,
    +    but it only ever accesses config settings (either directly or through
    +    the .settings field of the repo struct). Move all relevant config
    +    settings into the repo_settings struct, and update parse_commit_graph()
    +    and its existing callers so that it takes 'struct repo_settings *'
    +    instead.
    +
    +    Callers of parse_commit_graph() will now need to call
    +    prepare_repo_settings() themselves, or initialize a 'struct
    +    repo_settings' directly.
     
         Prior to ab14d0676c (commit-graph: pass a 'struct repository *' in more
         places, 2020-09-09), parsing a commit-graph was a pure function
    @@ Commit message
         repository pointer. This field was initialized via a call to
         `prepare_repo_settings()`.
     
    -    In 44c7e62 (2021-12-06, repo-settings:prepare_repo_settings only in git
    -    repos), prepare_repo_settings was changed to issue a BUG() if it is
    -    called by a process whose CWD is not a Git repository.
    -
    -    This series of changes broke fuzz-commit-graph, which attempts to parse
    -    arbitrary fuzzing-engine-provided bytes as a commit graph file.
    -    commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
    -    since we run the fuzz tests without a valid repository, we are hitting
    -    the BUG() from 44c7e62 for every test case.
    +    Additionally, this fixes an issue in fuzz-commit-graph: In 44c7e62
    +    (2021-12-06, repo-settings:prepare_repo_settings only in git repos),
    +    prepare_repo_settings was changed to issue a BUG() if it is called by a
    +    process whose CWD is not a Git repository.
     
    -    Fix this by moving the majority of the implementaiton of
    -    `parse_commit_graph()` into a new function,
    -    `parse_commit_graph_settings()` that accepts a repo_settings pointer.
    -    This allows fuzz-commit-graph to continue to test the commit-graph
    -    parser implementation without relying on prepare_repo_settings().
    -
    -    Additionally, properly initialize the
    -    repo_settings.commit_graph_generation_version field in
    -    prepare_repo_settings(). Load the value from the config if present, and
    -    default to version 2 otherwise.
    +    The combination of commits mentioned above broke fuzz-commit-graph,
    +    which attempts to parse arbitrary fuzzing-engine-provided bytes as a
    +    commit graph file. Prior to this change, parse_commit_graph() called
    +    prepare_repo_settings(), but since we run the fuzz tests without a valid
    +    repository, we are hitting the BUG() from 44c7e62 for every test case.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## commit-graph.c ##
    -@@ commit-graph.c: define_commit_slab(commit_graph_data_slab, struct commit_graph_data);
    - static struct commit_graph_data_slab commit_graph_data_slab =
    - 	COMMIT_SLAB_INIT(1, commit_graph_data_slab);
    +@@ commit-graph.c: struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
    + 	}
    + 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
    + 	close(fd);
    +-	ret = parse_commit_graph(r, graph_map, graph_size);
    ++	prepare_repo_settings(r);
    ++	ret = parse_commit_graph(&r->settings, graph_map, graph_size);
      
    --static int get_configured_generation_version(struct repository *r)
    --{
    --	int version = 2;
    --	repo_config_get_int(r, "commitgraph.generationversion", &version);
    --	return version;
    --}
    --
    - uint32_t commit_graph_position(const struct commit *c)
    - {
    - 	struct commit_graph_data *data =
    + 	if (ret)
    + 		ret->odb = odb;
     @@ commit-graph.c: static int graph_read_bloom_data(const unsigned char *chunk_start,
    + 	return 0;
    + }
      
    - struct commit_graph *parse_commit_graph(struct repository *r,
    +-struct commit_graph *parse_commit_graph(struct repository *r,
    ++struct commit_graph *parse_commit_graph(struct repo_settings *s,
      					void *graph_map, size_t graph_size)
    -+{
    -+	prepare_repo_settings(r);
    -+	return parse_commit_graph_settings(&r->settings, graph_map, graph_size);
    -+}
    -+
    -+struct commit_graph *parse_commit_graph_settings(struct repo_settings *s,
    -+						 void *graph_map, size_t graph_size)
      {
      	const unsigned char *data;
    - 	struct commit_graph *graph;
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
      		return NULL;
      	}
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
      		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
      			   &graph->chunk_bloom_indexes);
      		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
    -@@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
    - 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
    - 	ctx->opts = opts;
    - 	ctx->total_bloom_filter_data_size = 0;
    --	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
    -+	ctx->write_generation_data = (r->settings.commit_graph_generation_version == 2);
    - 	ctx->num_generation_data_overflows = 0;
    - 
    - 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
     
      ## commit-graph.h ##
    -@@ commit-graph.h: struct commit_graph *read_commit_graph_one(struct repository *r,
    +@@ commit-graph.h: struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
    + 						 struct object_directory *odb);
    + struct commit_graph *read_commit_graph_one(struct repository *r,
      					   struct object_directory *odb);
    - struct commit_graph *parse_commit_graph(struct repository *r,
    +-struct commit_graph *parse_commit_graph(struct repository *r,
    ++
    ++/*
    ++ * Callers should initialize the repo_settings with prepare_repo_settings()
    ++ * prior to calling parse_commit_graph().
    ++ */
    ++struct commit_graph *parse_commit_graph(struct repo_settings *s,
      					void *graph_map, size_t graph_size);
    -+struct commit_graph *parse_commit_graph_settings(struct repo_settings *s,
    -+					void *graph_map, size_t graph_size);
      
      /*
    -  * Return 1 if and only if the repository has a commit-graph
     
      ## fuzz-commit-graph.c ##
    +@@
    + #include "commit-graph.h"
    + #include "repository.h"
    + 
    +-struct commit_graph *parse_commit_graph(struct repository *r,
    ++struct commit_graph *parse_commit_graph(struct repo_settings *s,
    + 					void *graph_map, size_t graph_size);
    + 
    + int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
     @@ fuzz-commit-graph.c: int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
      	struct commit_graph *g;
      
    @@ fuzz-commit-graph.c: int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size
     +	 */
     +	the_repository->settings.commit_graph_generation_version = 2;
     +	the_repository->settings.commit_graph_read_changed_paths = 1;
    -+	g = parse_commit_graph_settings(&the_repository->settings, (void *)data, size);
    ++	g = parse_commit_graph(&the_repository->settings, (void *)data, size);
      	repo_clear(the_repository);
      	free_commit_graph(g);
      

 commit-graph.c      | 11 +++++------
 commit-graph.h      |  7 ++++++-
 fuzz-commit-graph.c | 12 ++++++++++--
 repo-settings.c     | 12 +++++++++++-
 repository.h        |  1 +
 5 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 265c010122..f305b65117 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -264,7 +264,8 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	ret = parse_commit_graph(r, graph_map, graph_size);
+	prepare_repo_settings(r);
+	ret = parse_commit_graph(&r->settings, graph_map, graph_size);
 
 	if (ret)
 		ret->odb = odb;
@@ -333,7 +334,7 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 	return 0;
 }
 
-struct commit_graph *parse_commit_graph(struct repository *r,
+struct commit_graph *parse_commit_graph(struct repo_settings *s,
 					void *graph_map, size_t graph_size)
 {
 	const unsigned char *data;
@@ -371,8 +372,6 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 		return NULL;
 	}
 
-	prepare_repo_settings(r);
-
 	graph = alloc_commit_graph();
 
 	graph->hash_len = the_hash_algo->rawsz;
@@ -402,14 +401,14 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
 	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
 
-	if (get_configured_generation_version(r) >= 2) {
+	if (s->commit_graph_generation_version >= 2) {
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
 			&graph->chunk_generation_data);
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
 			&graph->chunk_generation_data_overflow);
 	}
 
-	if (r->settings.commit_graph_read_changed_paths) {
+	if (s->commit_graph_read_changed_paths) {
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
diff --git a/commit-graph.h b/commit-graph.h
index 04a94e1830..c89b336791 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -93,7 +93,12 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 						 struct object_directory *odb);
 struct commit_graph *read_commit_graph_one(struct repository *r,
 					   struct object_directory *odb);
-struct commit_graph *parse_commit_graph(struct repository *r,
+
+/*
+ * Callers should initialize the repo_settings with prepare_repo_settings()
+ * prior to calling parse_commit_graph().
+ */
+struct commit_graph *parse_commit_graph(struct repo_settings *s,
 					void *graph_map, size_t graph_size);
 
 /*
diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
index e7cf6d5b0f..914026f5d8 100644
--- a/fuzz-commit-graph.c
+++ b/fuzz-commit-graph.c
@@ -1,7 +1,7 @@
 #include "commit-graph.h"
 #include "repository.h"
 
-struct commit_graph *parse_commit_graph(struct repository *r,
+struct commit_graph *parse_commit_graph(struct repo_settings *s,
 					void *graph_map, size_t graph_size);
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
@@ -11,7 +11,15 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	struct commit_graph *g;
 
 	initialize_the_repository();
-	g = parse_commit_graph(the_repository, (void *)data, size);
+	/*
+	 * Initialize the_repository with commit-graph settings that would
+	 * normally be read from the repository's gitdir. We want to avoid
+	 * touching the disk to keep the individual fuzz-test cases as fast as
+	 * possible.
+	 */
+	the_repository->settings.commit_graph_generation_version = 2;
+	the_repository->settings.commit_graph_read_changed_paths = 1;
+	g = parse_commit_graph(&the_repository->settings, (void *)data, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);
 
diff --git a/repo-settings.c b/repo-settings.c
index b4fbd16cdc..26241c1c2c 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -10,6 +10,13 @@ static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 		*dest = def;
 }
 
+static void repo_cfg_int(struct repository *r, const char *key, int *dest,
+			 int def)
+{
+	if (repo_config_get_int(r, key, dest))
+		*dest = def;
+}
+
 void prepare_repo_settings(struct repository *r)
 {
 	int experimental;
@@ -41,11 +48,14 @@ void prepare_repo_settings(struct repository *r)
 		r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
 	}
 
-	/* Boolean config or default, does not cascade (simple)  */
+	/* Commit graph config or default, does not cascade (simple) */
 	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
+	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
 	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
 	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
 	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
+
+	/* Boolean config or default, does not cascade (simple)  */
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
diff --git a/repository.h b/repository.h
index ca837cb9e9..4f8275f97c 100644
--- a/repository.h
+++ b/repository.h
@@ -29,6 +29,7 @@ struct repo_settings {
 	int initialized;
 
 	int core_commit_graph;
+	int commit_graph_generation_version;
 	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;

base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
-- 
2.37.0.170.g444d1eabd0-goog

