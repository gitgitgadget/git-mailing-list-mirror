Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8B4B1B56
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382997; cv=none; b=fuNnVDoENtYEx7KM/nqumnC5fo3sOvDyfAn5OQJv4vZTiQUA9iK5JFNEzPI5r09yFkaAiTjZ62xTCe6IbAnAaxLgWmTUCTVe6/Z/U8odq6Ma6ZSrz9sCnD9iYPE09KIygrCQfNWUaT5pgcNbEjE+l6v6bKx+QGDmUrpZXZfMzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382997; c=relaxed/simple;
	bh=aMw/T6Dv5f0zblW+7hNH072DRer+SRs6S+b7/96uBLQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b1R4Crhi+aRHWhTVYCKSs88/jQGxByP7fvoAVkJL+YOsOGmHJ6/RFt2wsHSLhfJYe94/Wr7ANKDXBARMsJdlUO8WUBAp3Y8Vnd8MGy61JrsV75LcMRzg4wNfLJiUDie8iYpsTJqHfZjBKSHKsVkcAlWttvnOxzzWq1lwQKzl1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAflGCiQ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAflGCiQ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917bab38b14so46257946d6.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791382989; x=1791987789; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gaxpOrQzBlPoEG/X3TjBpRXQhyI9P+Qs+ljJ7YMkc4c=;
        b=JAflGCiQ2ZptSMFDvTYBPNwa0HFuc3MbfYAGUTOJNpbvFXx2j/3oniwewXbUOp0g0l
         234x9nyHktNAMuaQmWkX4SOSosln71sn6b5pszYHir6PYYIUSsRq/ZPDk5T8xiWsyEo1
         9mTWJAQCcqLJ5+n+h+BFb8Iozxi7qup8Xw+JyehTb5CTNjXLhLFg4YA8NON84k6NwaJK
         ZSeOpwbQ8uVE0jlZkaFv31l2iGaTgnYpmkzG8lEFftt34w9QCrhRIHfOI986dynGWxLi
         09kQqVFHQvCJ8zDMkXNU4TjPE4nJ+LonxZdQA6cpvfR8MBBQV6Tz6/QJPFSkV7cXI6eS
         G3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791382989; x=1791987789;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaxpOrQzBlPoEG/X3TjBpRXQhyI9P+Qs+ljJ7YMkc4c=;
        b=ygqbWTEkXpw0swqTKdKYNXyuOxtCTNefO7CtIfBbytXf48X/KaeWiwQe7fe+P85QRC
         IG8VRZwr/IlBzywW1YFqMEAJaJUzZ56+2YsDApUUQIgdw29VFtO95wrP6mqKZaKw/qvN
         PrCrm2xLjHY3mBdi2FHZGZoOQ3XyMfg4wpLx2eOaSG6GXC6+vuDZlEpfF/aPwmOotZx2
         yaGKZ297lj/S82VJtHgN2/keXV8xU+KzJmJit2lr1zZBpylzJOqEA1HsnxedHdh0ZRkL
         pHV8W5XXbyh4Qe8gKDWD3Gr9TMhGYKc1oDfOPL3WR+1oNxg94agB3cC5q5UraWWBUsqD
         FwZw==
X-Gm-Message-State: AFuF++m9B1cBg4y0MyCZHb93hreyY4y/e6Pd+iXMKVzZyh6j0IEuZG/S
	zdDZeDlrNzUE+FRzmcLTmNqKcaoteLhqxMyj9sjwaXL/34ijg0jdwyAr9hsBLQ==
X-Gm-Gg: AYBFou2ynGqPhcy6+LXxvQWkQRQYNd5g/0rwCOraJEnAo0OZA4VAx8+BY4UVEPv43+W
	Vpdr+WGybAQkcC4hEsYwiWMeWzovgj3Bjvsi0mv30V6HiBxMfd5B3GH0McuGtklW2GXBMA06NFj
	yb4j+SYqqmEYdilshAc4lofx2t9w8thMHZ2E5TvJxJhFl2sjPzm1MlZOnBqTQLGHocNGbKftqWg
	9AbyGmSxaKqcqf//gDcrOa9R777syhIjRry6WNbcv6XxeDJrND6osxfiG7P9pXgDjLfp7ZP2Ex+
	H/uQacMHi+p08vKZNpoaa6e8sFUgUwSRtfFaXS2EQVAtdPysxzkenyKHC1T1mZR0zROwro1/dl8
	ny/Jo5AigJszEnueONg/JZDwJdvgWfI6kczFB+7SpsXlCmjT4TyMDRLZ27/B7PDm/wPRuwGrMFt
	ouSdEiH8Ou2Dd2gfJ/lsyH3446H+9Br38vn6DNy0P7XFGJ3xBk5gJbz4NE0TaGmgotTKj3Ovc=
X-Received: by 2002:a05:6214:411e:b0:914:483b:82ea with SMTP id 6a1803df08f44-9199785f5b1mr48841356d6.33.1791382987974;
        Wed, 07 Oct 2026 07:23:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-919982ac110sm17756146d6.18.2026.10.07.07.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 07:23:06 -0700 (PDT)
Message-Id: <01da9857bcd847bec4eb85d8f57ea1cdc40b1758.1791382977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2239.v3.git.1791382977.gitgitgadget@gmail.com>
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
	<pull.2239.v3.git.1791382977.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Oct 2026 14:22:57 +0000
Subject: [PATCH v3 2/2] fetch: write commit-graph using updated refs only
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

When fetch.writeCommitGraph was introduced in 50f26bd035 (fetch: add
fetch.writeCommitGraph config setting, 2019-09-02), the stated goal
was to stay updated with the latest commits after fetching new
objects.  The implementation used write_commit_graph_reachable()
because it was the only API available, but two things have changed
since then:

 1. write_commit_graph() was added, and it accepts an explicit set of
    commits as seeds, enabling more targeted commit-graph updates.

 2. The ref-scanning callback add_ref_to_set() became more expensive
    in 630cd5194e (commit-graph.c: peel refs in 'add_ref_to_set',
    2020-07-22) when it started to validate the refs against the odb
    for correctness.  On a repository with many refs, this makes the
    full reachable scan unnecessarily costly for a targeted fetch.

Optimize the commit-graph write by using only the newly updated refs
as seeds instead of scanning all refs after every fetch.  To keep
this change small, skip the optimization for multi-remote fetches
(since that would require propagating the set of refs across process
boundaries).

This relies on the commit-graph write being additive, keeping the
commits that are already in the graph.  fetch already operates in
this mode (COMMIT_GRAPH_WRITE_SPLIT) and now that becomes
required for correctness.  Without that mode, the write would
replace the commit-graph and lose other commits.

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
 t/t5537-fetch-shallow.sh | 22 +++++++++++++
 5 files changed, 143 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d8..d73eca77aa 100644
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
+		 * Shallow-rejected refs are not stored and their history
+		 * is incomplete, so skip them.
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
index f323ceebd2..16bfaba0f0 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -135,6 +135,28 @@ test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
 	)
 '
 
+test_expect_success 'fetch.writeCommitGraph skips refs that require changes in .git/shallow' '
+	git clone --no-local --depth=2 .git shallow-graph &&
+	git -C shallow-graph checkout --orphan no-shallow &&
+	test_commit -C shallow-graph --no-tag no-shallow &&
+	git init notshallow-graph &&
+	git -C notshallow-graph -c fetch.writeCommitGraph=true \
+		fetch ../shallow-graph/.git "refs/heads/*:refs/remotes/shallow/*" &&
+	test_commit -C shallow-graph --no-tag no-shallow-2 &&
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
