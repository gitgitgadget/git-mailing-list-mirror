Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6F45D1B9
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930026; cv=none; b=R46acvaIvSHhoaAdoqt0nwPKhTMBGx+CV4HuHQJP8RUxhc+hFJqneHiyWVrlZ2vu5dhCfNMvVQmyM1kPnApU9ow9MiRceWVN9c4WdXyILzzaczt0YJhYUL545zu+j0LLzsRtgvGUVOcQIA82jR/JhR3vLirZT4PQ2fa/ABm5mfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930026; c=relaxed/simple;
	bh=Z3rD3ZENUwQVtqnW8NrObJzPLghDlIRPGbNX3sgjGxg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TVNIfG6RoYp4zlzWUdIgMHdweBdZUSN51PbmXM9YBRewkhqtvQkF/RRkpB2AScHVuf3Qyb6MQY1tZUnbhkzh2RbzQ3urLhVoTMR5PoSbYs7Ll+2lI7Cwsu1bTW2P8Wz0H3I0a5THeVUEXi2LSaQ5oc8x/KNC1BujqCycbkuvWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bduzh5kt; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bduzh5kt"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91788e38a27so39414736d6.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790930022; x=1791534822; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gzbwCoX7xA1T6Os2eR/u2qSPwydn3ojbt1XeHIzF1AA=;
        b=bduzh5kto61dc89Mpz7e90RtzrrdRZ60zaCapPVr7wF+uEeIrjeERhBSYuXvdfr2xZ
         oecnUn8FuxB6YwVRBSUd3SN2Kl+6hZXXVaFmVp+gOpu06rNyXAvbhyWUZZeBPSsHZoGW
         n765Itq4lp2Va/GaY1s5RSMeqhMmtQsv5hta+Hz0RB63qeJZsmA8ewd8ktWkc6pBq3nD
         UEBTtKysNcvwSgSRoMFQPBlZ/I6Zva3s1hDNHqF9QK74I2MDf6xz5rtUfeC2AUcfcv3a
         IfnhDHxWO4WzxhQmL3JLu++eL75qz7TxTrtb1hFQEIHfXnxOL+YKr6ppWeB61x0ASAMN
         neOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790930022; x=1791534822;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzbwCoX7xA1T6Os2eR/u2qSPwydn3ojbt1XeHIzF1AA=;
        b=rHmCPb7nE7x5irCsCTAeKuzMZoT2TtJbKJhOM0o//wCiK1NVNuLKLFochW7kyiBLKI
         edApTp8jAiZVuK+iOGQ/hPt2uidWJtq16K1efhvM0QmWYHLzvQrJPUyC5BhbSxh2CyQG
         YnQmz+eAeNunE0VuNBJ6KYzZsP1O34bDM28v8Vhmn+w0Q7Wyjcw0G4wwA5s/wDR5vN7h
         TjQgYuTc5xp25/yS3GrczCSfid6SsWxli/WRbim4QdS/r5lhQBwf388avluL+YVWEHSs
         ggYBsxvZN3espRTw0tIZ36MgwlUuCfFq9oQVDNjYN++Sly3U5NdhCrW96AFqpiM4oW5/
         OY+w==
X-Gm-Message-State: AFq9FYJzrqqQw07Qi+ZjHqLhD+IJQEHyHipqgeCr5TxsE/Agnx1PvWfI
	LwoRFyDVDje6bpYPPPzr6tOYU1+ppoT1MD251ig3/VnWMsbpFJzaDsOxpn8KDQTB
X-Gm-Gg: AYBFou2puCm8chMlfMdDveSLp33eauwiu17QW25WJ9/dWrerqDjfsann2x5Uu/ptLlK
	zTlqBgXtDc2ZCBCs+spEA2b1a1rBl7YfGX1OylYPSURwUE5NldozJhf4Bpf54z28YbtuwgrSLN4
	BNRdQMhgU0yjaH9bDR9ZyZrlWEFC6OQGFCxnGFRcFoDpX8TGnnuGCLlTImsSrO6mSYGDZTxDy4I
	DSTEbkZR+uYK9/OS/12TT0W0+xfHVuxNKWEO0s5Y6IexmXTaN18gr/4hDxSKzPJzmmPXh13avNc
	7E3BbXlW2kbOLMynHbyB2lAqAb/HtZ9pam4vJydlSe6lQ+SCN2HNc5MiqejUcTWDWxQHcskfGj4
	Mj1iHwj8aVnPTEb0MnP4mko5jRBSDIupU70FZZzk2K7r9c8zJBYI6i88y6KbBHcOsA5WgEh2xi/
	KdWAVke+djbyV86rjR8AU6Cq1RVhaq+3kHpeiimVQHb1A6i8yCrX/2vWZf2XxYWzyvZJcAlskj
X-Received: by 2002:a05:6214:5284:b0:914:511f:b415 with SMTP id 6a1803df08f44-917c0135381mr40600966d6.37.1790930022035;
        Fri, 02 Oct 2026 01:33:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.159.48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0c3c2a2sm14362836d6.47.2026.10.02.01.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:33:41 -0700 (PDT)
Message-Id: <fee92f3c2009f8f282fe98e6b16d403704db9ad9.1790930019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 08:33:38 +0000
Subject: [PATCH 2/2] fetch: write commit-graph using updated refs only
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
In split mode, close_reachable() walks from the updated tips and
stops at commits already present in the graph, efficiently adding
the newly fetched history.  This reachability closure also covers
auto-followed tags, since their targets are reachable from the
fetched tips that caused them to be auto-followed.

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

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 builtin/fetch.c  | 65 +++++++++++++++++++++++++++++++++++++++++-------
 commit-graph.c   |  2 +-
 commit-graph.h   |  1 +
 t/t5510-fetch.sh | 58 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d8..8ad7331640 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1903,10 +1903,30 @@ out:
 	return retcode;
 }
 
+static void collect_updated_tips(struct oidset *tips, struct ref *ref_map)
+{
+	struct ref *rm;
+	for (rm = ref_map; rm; rm = rm->next) {
+		struct commit *commit;
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
@@ -2111,6 +2131,8 @@ static int do_fetch(struct transport *transport,
 
 	commit_fetch_head(&fetch_head);
 
+	collect_updated_tips(updated_tips, ref_map);
+
 	if (set_upstream) {
 		struct branch *branch = branch_get("HEAD");
 		struct ref *rm;
@@ -2427,7 +2449,8 @@ static inline void fetch_one_setup_partial(struct remote *remote,
 static int fetch_one(struct remote *remote, int argc, const char **argv,
 		     int prune_tags_ok, int use_stdin_refspecs,
 		     const struct fetch_config *config,
-		     struct list_objects_filter_options *filter_options)
+		     struct list_objects_filter_options *filter_options,
+		     struct oidset *updated_tips)
 {
 	struct refspec rs = REFSPEC_INIT_FETCH(the_hash_algo);
 	int i;
@@ -2494,7 +2517,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack_atexit);
 	sigchain_push(SIGPIPE, SIG_IGN);
-	exit_code = do_fetch(gtransport, &rs, config, filter_options);
+	exit_code = do_fetch(gtransport, &rs, config, filter_options,
+			     updated_tips);
 	sigchain_pop(SIGPIPE);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
@@ -2535,6 +2559,12 @@ int cmd_fetch(int argc,
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
@@ -2822,7 +2852,13 @@ int cmd_fetch(int argc,
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
@@ -2899,11 +2935,21 @@ int cmd_fetch(int argc,
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
@@ -2927,6 +2973,7 @@ int cmd_fetch(int argc,
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
index a8d38d9176..e0b4d75d96 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1087,6 +1087,64 @@ test_expect_success 'fetch.writeCommitGraph' '
 	)
 '
 
+test_expect_success 'fetch.writeCommitGraph adds fetched commits incrementally' '
+	git init incremental-source &&
+	test_commit -C incremental-source one &&
+	git clone incremental-source incremental-dest &&
+	git -C incremental-dest commit-graph write --reachable --split &&
+	test_commit -C incremental-source two &&
+	test_commit -C incremental-source three &&
+	(
+		cd incremental-dest &&
+		git -c fetch.writeCommitGraph=true fetch origin &&
+		test-tool read-graph commit-info three two
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
-- 
gitgitgadget
