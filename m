Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281DE381B10
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280000; cv=none; b=TFXx9QX10d5AVQUElr3GRz+G1/AHgkeJrBZ7Njd5M4xf7BK1HCs5el5vwje4CT4W62ubW/ja4t6PFS/5fKpFue60OW65N2L1+fx39ZHvGevq9XyPHOB1N1wZVNvN9vheZdu0xZT8yj6uGsPP0vIQUaGTKiN59Orl+jYbTJ9DwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280000; c=relaxed/simple;
	bh=88RPenELvhlCvyjMgYRWHQowCAfs8C/gZGNa/3LgvgY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W17rhm6DthyrWNc/RrWtA44VzOuiAIv8RqEDUP6CVEsijhmHqTFYP/Oyy0yyb/LW2pZkgfxyWpANwH7G1z9SHUTP5kmlsU8FKSe17qAD4Niuo9FxQx/qgEnkJhJ/Z26vuwiNI1DJcmhFHTilolKKb1VXHCPcsslnPS7DBAYtPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRVXx//x; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRVXx//x"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-14129667240so201641c88.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 02:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791279997; x=1791884797; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4E2TgrjKalJ8mtwPc3mMeXrQE+p/F/OnznhDORNwQXY=;
        b=YRVXx//xiflA36rs8GBeR/CsxLD7FL2CFlWm0+/IRruKcBNAG8+EOVnBcXUrgIeXlC
         N6jF1NiUok7c6S3YAfsVroaMxUDocJaSR+lolje6Zzv8rok9yGM0+nnpMj6rRR8VRhIF
         gVBJWF+2+ZdPGhzYN22nkt3a3JmmTzYI7mqJJcT6K9H3d9gts2fR9IMy26phcaIE1R6+
         iurZ2OG9Z3vP5XYoFUNR7a9LAGHoMasKeJpbjWJse3el8FEUuPDUdkaZPnUHez/9iwXY
         n7HIt1au0urLMTbmAQoWNJOIznNgNNwQB7vCLfSvPcBh9phLEoySbSKCfPPJb5LuZn85
         fK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791279997; x=1791884797;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4E2TgrjKalJ8mtwPc3mMeXrQE+p/F/OnznhDORNwQXY=;
        b=oKeaIomoyWDqXsRvShzVq0+vxXavbX8G7YOAa4QkmH9KVAsSVPHL+cbzAcqpJ+3UCX
         xpLzKXI4JPy6zxbOan19rcgNxrFnDqazgfOgtAqBBVsYUYF/6/malKZhmIGqGltk5hCb
         zm0sZCrtMx9h/wO0+wAdcYynIkkjRDAdIGsUrtX9axVGqAVRilPC/ld15afRcyp5UIz/
         seYy2q4HdSC2E/m33Ar4abaEsv6Zh4YAxRotuihJB4bJ/WGtRDkRQD5k8ZvqsH77x/6F
         T1NyT0n3jfHPxt00i9lixwvMwuH5Lnb34LSH8DW7OXpcUrBX+rJVrJsqoGYVSUdQLvuT
         oypw==
X-Gm-Message-State: AFuF++k0WpA74hicLmpuZUAi/EDcpBO4GcF4SwpEQgpzijfzN4+Izj0O
	+r3Gqb9EnBvkQ+w1V+xCIaPctQkYdtP38ICz6ziNTmboYKqix+ARoC3QVn9zeKvH
X-Gm-Gg: AYBFou0TqiOMZlHgBeYH3BRE8fYTZBY6O40u2UN3rxwP29MI3T9qYlB2Z2wUHOzmUGG
	Oakkm5nx0+eFhi8kUJjlzjTRQAKSxNR821H2GKXZ5eUOyvTTdi7IQE1xiLQo95zrxZFsKxldeUo
	jNDB9Wqw1SYz+GxUWmVQTYiOlom47phckSS1FhDPAiTSvtH5ArYrpAcNuJjdeSCp9bd+Zud4H+3
	rPDI4BW9JpQsWQrpE5ogXmTj7tbSdwV94lzwr2AAKuMbXDVvpQpD9cH5iRDgxc6Vw5wz2K+Q/UP
	qlliQ8qrfXhlTwv4DiE0hJshyz3s9pdjOd4QHgcCtJTBGRuFg9dZOQr5cLsuBq/Z8D8wvcvbGac
	JG7vjOx+nlBxiBZV4Kj+bzstOrGSeyoA/Nn8zXnr8vBUhGAwkCqpxEimCdDyikhdXxcSpYiG1q9
	61cVVyEg9ZM73ClO8QaqEB+whiB+YPCEx8dx3eqpWVnqIO2nOidm3jFZq7Dv6rKMJuajSqr13xD
	A==
X-Received: by 2002:a05:7023:88c:b0:159:aa67:2893 with SMTP id a92af1059eb24-15ecb3ba907mr1213017c88.30.1791279997157;
        Tue, 06 Oct 2026 02:46:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.108.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d84ec510dsm8177126c88.13.2026.10.06.02.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:46:36 -0700 (PDT)
Message-Id: <7507354cc97bb63b3bcdc4a089b5387da28500a0.1791279992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2239.v2.git.1791279992.gitgitgadget@gmail.com>
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
	<pull.2239.v2.git.1791279992.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 09:46:32 +0000
Subject: [PATCH v2 2/2] fetch: write commit-graph using updated refs only
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

When fetch.writeCommitGraph was introduced in

    50f26bd035 (fetch: add fetch.writeCommitGraph config
                setting, 2019-09-02),

the stated goal was to stay updated with the latest commits after
fetching new objects.  The implementation used
write_commit_graph_reachable() because it was the only API available,
but two things have changed since then:

 1. write_commit_graph() was added, and it accepts an explicit set of
    commits as seeds, enabling more targeted commit-graph updates.

 2. The ref-scanning callback add_ref_to_set() became more expensive
    in
        630cd5194e (commit-graph.c: peel refs in 'add_ref_to_set',
                    2020-07-22)
    when it started to validate the refs against the odb
    for correctness.  On a repository with many refs, this makes the
    full reachable scan unnecessarily costly for a targeted fetch.

Optimize the commit-graph write by using only the newly updated refs
as seeds instead of scanning all refs after every fetch.  To keep
this change small, skip the optimization for multi-remote fetches
(since that would require propagating the set of refs across process
boundaries).

Since do_fetch() already knows which refs were updated, collect them
into an oidset and then pass them directly to write_commit_graph().
fetch always writes the commit-graph in split mode, so this adds a
new layer on top of the existing chain rather than replacing it:
close_reachable() walks from the updated tips and stops at commits
already present in the graph, so the new layer only contains the
newly fetched history, and commits covered by the existing layers
remain covered.  This relies on split mode; a non-split write would
replace the graph with just the closure of the seeds.

The reachability closure also covers auto-followed tags, since their
targets are reachable from the fetched tips that caused them to be
auto-followed.

Refs that are rejected because they would require changes to
.git/shallow are skipped, just like store_updated_refs() does.  Their
objects are received but their history is incomplete, so walking from
them would make the commit-graph write fail.

After fetch_one() returns, call prepare_commit_graph() (which is
made non-static by this commit) to determine the graph-write mode:

 - If no commit-graph exists yet, fall back to the full reachable
   scan so the first graph creation covers all refs.

 - If a commit-graph exists and the fetch updated at least one ref,
   write incrementally using only the new refs as seeds.

 - If a commit-graph exists but the fetch is a no-op, skip the
   commit-graph write entirely.

 - For the multi-remote path (fetch --all), where child processes
   do the actual fetching, fall back to the full reachable scan.

Full commit-graph coverage of all refs remains the responsibility
of "git maintenance", "git gc" and "git commit-graph write".
Regular Git operations may trigger "git maintenance run --auto",
which periodically rebuilds the commit-graph from all reachable
refs.

The effect was measured on a synthetic setup: git.git with 200K
extra packed refs (~206K total), a local file:// remote, an existing
split commit-graph and a warm page cache.  The times below are the
median of 9 runs of the trace2 region fetch/write-commit-graph:

    scenario          before    after
    no-op fetch       380 ms    (skipped)
    1 ref updated     357 ms    9.3 ms
    10 refs updated   359 ms    8.9 ms

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 builtin/fetch.c          | 69 ++++++++++++++++++++++++++++++++++------
 commit-graph.c           |  2 +-
 commit-graph.h           |  1 +
 t/t5510-fetch.sh         | 59 ++++++++++++++++++++++++++++++++++
 t/t5537-fetch-shallow.sh | 28 ++++++++++++++++
 5 files changed, 149 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d8..574c361530 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1903,10 +1903,34 @@ out:
 	return retcode;
 }
 
+static void collect_updated_tips(struct oidset *tips, struct ref *ref_map)
+{
+	struct ref *rm;
+	for (rm = ref_map; rm; rm = rm->next) {
+		struct commit *commit;
+		/*
+		 * Like store_updated_refs(), skip shallow-rejected refs:
+		 * they are not stored, and their history is incomplete.
+		 */
+		if (rm->status == REF_STATUS_REJECT_SHALLOW)
+			continue;
+		if (is_null_oid(&rm->old_oid))
+			continue;
+		if (rm->peer_ref &&
+		    oideq(&rm->old_oid, &rm->peer_ref->old_oid))
+			continue;
+		commit = lookup_commit_reference_gently(the_repository,
+							&rm->old_oid, 1);
+		if (commit)
+			oidset_insert(tips, &commit->object.oid);
+	}
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config,
-		    struct list_objects_filter_options *filter_options)
+		    struct list_objects_filter_options *filter_options,
+		    struct oidset *updated_tips)
 {
 	struct ref_transaction *transaction = NULL;
 	struct ref *ref_map = NULL;
@@ -2111,6 +2135,8 @@ static int do_fetch(struct transport *transport,
 
 	commit_fetch_head(&fetch_head);
 
+	collect_updated_tips(updated_tips, ref_map);
+
 	if (set_upstream) {
 		struct branch *branch = branch_get("HEAD");
 		struct ref *rm;
@@ -2427,7 +2453,8 @@ static inline void fetch_one_setup_partial(struct remote *remote,
 static int fetch_one(struct remote *remote, int argc, const char **argv,
 		     int prune_tags_ok, int use_stdin_refspecs,
 		     const struct fetch_config *config,
-		     struct list_objects_filter_options *filter_options)
+		     struct list_objects_filter_options *filter_options,
+		     struct oidset *updated_tips)
 {
 	struct refspec rs = REFSPEC_INIT_FETCH(the_hash_algo);
 	int i;
@@ -2494,7 +2521,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack_atexit);
 	sigchain_push(SIGPIPE, SIG_IGN);
-	exit_code = do_fetch(gtransport, &rs, config, filter_options);
+	exit_code = do_fetch(gtransport, &rs, config, filter_options,
+			     updated_tips);
 	sigchain_pop(SIGPIPE);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
@@ -2535,6 +2563,12 @@ int cmd_fetch(int argc,
 	int negotiate_only = 0;
 	int porcelain = 0;
 	int i;
+	enum {
+		GRAPH_WRITE_REACHABLE,
+		GRAPH_WRITE_TIPS,
+		GRAPH_WRITE_SKIP,
+	} graph_write_mode = GRAPH_WRITE_REACHABLE;
+	struct oidset updated_tips = OIDSET_INIT;
 
 	struct option builtin_fetch_options[] = {
 		OPT__VERBOSITY(&verbosity),
@@ -2822,7 +2856,13 @@ int cmd_fetch(int argc,
 		}
 		trace2_region_enter("fetch", "fetch-one", the_repository);
 		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
-				   &config, &filter_options);
+				   &config, &filter_options, &updated_tips);
+		if (prepare_commit_graph(the_repository)) {
+			if (oidset_size(&updated_tips))
+				graph_write_mode = GRAPH_WRITE_TIPS;
+			else
+				graph_write_mode = GRAPH_WRITE_SKIP;
+		}
 		trace2_region_leave("fetch", "fetch-one", the_repository);
 	} else {
 		int max_children = max_jobs;
@@ -2899,11 +2939,21 @@ int cmd_fetch(int argc,
 		if (progress)
 			commit_graph_flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-		trace2_region_enter("fetch", "write-commit-graph", the_repository);
-		write_commit_graph_reachable(the_repository->objects->sources,
-					     commit_graph_flags,
-					     NULL);
-		trace2_region_leave("fetch", "write-commit-graph", the_repository);
+		if (graph_write_mode != GRAPH_WRITE_SKIP) {
+			trace2_region_enter("fetch", "write-commit-graph",
+					    the_repository);
+			if (graph_write_mode == GRAPH_WRITE_TIPS)
+				write_commit_graph(
+					the_repository->objects->sources,
+					NULL, &updated_tips,
+					commit_graph_flags, NULL);
+			else
+				write_commit_graph_reachable(
+					the_repository->objects->sources,
+					commit_graph_flags, NULL);
+			trace2_region_leave("fetch", "write-commit-graph",
+					    the_repository);
+		}
 	}
 
 	if (enable_auto_gc) {
@@ -2927,6 +2977,7 @@ int cmd_fetch(int argc,
 	}
 
  cleanup:
+	oidset_clear(&updated_tips);
 	string_list_clear(&list, 0);
 	list_objects_filter_release(&filter_options);
 	return result;
diff --git a/commit-graph.c b/commit-graph.c
index 983c11ce85..d042752ff4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -733,7 +733,7 @@ struct commit_graph *read_commit_graph_one(struct odb_source *source)
  * On the first invocation, this function attempts to load the commit
  * graph if the repository is configured to have one.
  */
-static struct commit_graph *prepare_commit_graph(struct repository *r)
+struct commit_graph *prepare_commit_graph(struct repository *r)
 {
 	struct odb_source *source;
 
diff --git a/commit-graph.h b/commit-graph.h
index 13ca4ff010..7e48b0ccc0 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -31,6 +31,7 @@ struct string_list;
 
 char *get_commit_graph_filename(struct odb_source *source);
 char *get_commit_graph_chain_filename(struct odb_source *source);
+struct commit_graph *prepare_commit_graph(struct repository *r);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st,
 			    const struct git_hash_algo *hash_algo);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a8d38d9176..72dcb7fd43 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1087,6 +1087,65 @@ test_expect_success 'fetch.writeCommitGraph' '
 	)
 '
 
+test_expect_success 'fetch.writeCommitGraph adds fetched commits incrementally' '
+	git init incremental-source &&
+	test_commit -C incremental-source one &&
+	git clone incremental-source incremental-dest &&
+	test_commit -C incremental-dest local &&
+	git -C incremental-dest commit-graph write --reachable --split &&
+	test_commit -C incremental-source two &&
+	test_commit -C incremental-source three &&
+	(
+		cd incremental-dest &&
+		git -c fetch.writeCommitGraph=true fetch origin &&
+		test-tool read-graph commit-info three two local
+	)
+'
+
+test_expect_success 'fetch.writeCommitGraph does not add unrelated commits' '
+	git init unrelated-source &&
+	test_commit -C unrelated-source initial &&
+	git clone unrelated-source unrelated-dest &&
+	git -C unrelated-dest commit-graph write --reachable --split &&
+	test_commit -C unrelated-source fetched &&
+	(
+		cd unrelated-dest &&
+		test_env GIT_TEST_COMMIT_GRAPH=0 test_commit local-only &&
+		git -c fetch.writeCommitGraph=true fetch origin &&
+		test-tool read-graph commit-info fetched &&
+		test_expect_code 1 \
+			test-tool read-graph commit-info local-only 2>/dev/null
+	)
+'
+
+test_expect_success 'fetch.writeCommitGraph skips write on no-op fetch' '
+	git init noop-source &&
+	test_commit -C noop-source one &&
+	git clone noop-source noop-dest &&
+	git -C noop-dest commit-graph write --reachable --split &&
+	(
+		cd noop-dest &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+			git -c fetch.writeCommitGraph=true fetch origin &&
+		test_region ! fetch write-commit-graph trace2.txt
+	)
+'
+
+test_expect_success 'fetch.writeCommitGraph falls back to reachable scan without existing graph' '
+	git init first-graph-source &&
+	test_commit -C first-graph-source base &&
+	git clone first-graph-source first-graph-dest &&
+	test_commit -C first-graph-source fetched &&
+	(
+		cd first-graph-dest &&
+		test_commit local &&
+		rm -rf .git/objects/info/commit-graphs &&
+		rm -f .git/objects/info/commit-graph &&
+		git -c fetch.writeCommitGraph=true fetch origin &&
+		test-tool read-graph commit-info fetched local base
+	)
+'
+
 test_expect_success 'fetch.writeCommitGraph with submodules' '
 	test_config_global protocol.file.allow always &&
 	git clone dups super &&
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index f323ceebd2..624bd124be 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -135,6 +135,34 @@ test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
 	)
 '
 
+test_expect_success 'fetch.writeCommitGraph skips refs that require changes in .git/shallow' '
+	git clone --no-local --depth=2 .git shallow-graph &&
+	(
+		cd shallow-graph &&
+		git checkout --orphan no-shallow &&
+		commit no-shallow
+	) &&
+	git init notshallow-graph &&
+	git -C notshallow-graph -c fetch.writeCommitGraph=true \
+		fetch ../shallow-graph/.git "refs/heads/*:refs/remotes/shallow/*" &&
+	(
+		cd shallow-graph &&
+		commit no-shallow-2
+	) &&
+	rejected=$(git -C shallow-graph rev-parse main) &&
+	(
+		cd notshallow-graph &&
+		git -c fetch.writeCommitGraph=true \
+			fetch ../shallow-graph/.git "refs/heads/*:refs/remotes/shallow/*" &&
+		git for-each-ref --format="%(refname)" >actual.refs &&
+		echo refs/remotes/shallow/no-shallow >expect.refs &&
+		test_cmp expect.refs actual.refs &&
+		test-tool read-graph commit-info shallow/no-shallow &&
+		test_expect_code 1 \
+			test-tool read-graph commit-info $rejected 2>/dev/null
+	)
+'
+
 test_expect_success 'fetch --update-shallow' '
 	(
 	cd shallow &&
-- 
gitgitgadget
