Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937967C40
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442972; cv=none; b=II05j1YPvsywFpwGtTnJwhUxtDPzKa+Hjk1FkUKRiucYnskcLLtnZquTIzoylCyv44Qatjft1SZAEdq/zGpB5fWwGMbBMRmPX1qh1s09UTAMo9E5+7WAWPTb0MRVT5SMpMUFt9f64ZPK9Lqwj2GK7ZPeY8T32AqiE0qq8Gr4CJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442972; c=relaxed/simple;
	bh=mj+XMOTEQ1tVSk49H4wNdVXxkcaymiePObr1I4uF1xM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TjSuRpecWZz+5aXdF8ACEiYO1E2biBp6KZIODweE08qEnDB0XjwaIKFzM6BLHJFEVeAuFMfKnjPcK3FhNv+Vq5k+SL6rCN7R5ffwBinmdeHu719ljockYtkCWN6dde4LfxuUwJKUU8rvlocRqIehdhdXFnmmxIJiMM7iiS0v704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ASs4KTBd; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ASs4KTBd"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78313f4d149so1077311985a.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442969; x=1706047769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmn9fLMdffx5U61Q0oW8gq9ibGFbe2pfqlCbhU8FYg8=;
        b=ASs4KTBdfmqTR0DTldqlTYf1WSWgJ+n2PwC8sPjNXvYAUlVphG5vvaUc+3PKY/jTYO
         mmp5Iq/s61zll0S6ChTq8xJRjGZBAC0g7aADyuDsMyLI+UjauACbd0GhtCL1tL2lSB+e
         0tPnlgYsF0thtShZhx5qAkBP5WqTEir3ElV9MbEZjybXhQDCFm4RQ+YNkiNlRhRG3C2V
         gb4UtywhW72FExzsitSORIiYH+lpdM+YR+niqTzB3WhE2J+oTfLEInzEPNKLfTQk46GV
         HYBxWcBw74Yc0u9ZEU8BcxBwww9vyA+3cutXICwjT0+JsWUK1P/4az97FHxBoTzXSgA4
         bL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442969; x=1706047769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmn9fLMdffx5U61Q0oW8gq9ibGFbe2pfqlCbhU8FYg8=;
        b=hUMrFdVzkm/kvRnRTGLTfoedCteTzL08xjRep8gdCCodz5Gy1i4GSv297iDYUV51zO
         3je0jZ0Df8LvreAPCqrHWpBwyFy8QuGpDdmKDJvf9IopdS6Ofcc98DzBatVMQ43w1/3/
         CrAtkHs4z3LJDXeND6+dXG5IH46r686VMTpEUSlQgDPcngRo5gKimkjA1WKHytyCutWF
         dQmHPKkASiwYtlSlsvd4imPneR8Lkxu65uO2OeKu7Kasb6+YN/7W6qQ7JUr+rXBy2cqc
         HrvY6/bimKp9sWA8niBdohe8GA2ZMqngOrIeh56LgXGT2TjJMtLvsnEsOYKm2rCqVx7g
         Ufow==
X-Gm-Message-State: AOJu0Yx5HF08i3rPt1R4vzSXV9y7Gvihx0FhK33EvdadfDlkj5erRQWi
	ns5+pmY10XXPM2aU/MhCNKxLeV3JPbeQOPaqhrNN7YGn/2btxQ==
X-Google-Smtp-Source: AGHT+IHvX5Ob158jMTB8wjDRn/YqY5u6y19pSwC+NGDFXXzPW7ngzafFItqETxYNUoX6zcb0UaYWkg==
X-Received: by 2002:a05:620a:2620:b0:783:53f0:5084 with SMTP id z32-20020a05620a262000b0078353f05084mr7065706qko.9.1705442969529;
        Tue, 16 Jan 2024 14:09:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id vy3-20020a05620a490300b00781eb1e7779sm4042726qkn.94.2024.01.16.14.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:29 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 09/17] repo-settings: introduce
 commitgraph.changedPathsVersion
Message-ID: <a77dcc99b4eb0a19dc6c09a40a84785413502126.1705442923.git.me@ttaylorr.com>
References: <cover.1697653929.git.me@ttaylorr.com>
 <cover.1705442923.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1705442923.git.me@ttaylorr.com>

A subsequent commit will introduce another version of the changed-path
filter in the commit graph file. In order to control which version to
write (and read), a config variable is needed.

Therefore, introduce this config variable. For forwards compatibility,
teach Git to not read commit graphs when the config variable
is set to an unsupported version. Because we teach Git this,
commitgraph.readChangedPaths is now redundant, so deprecate it and
define its behavior in terms of the config variable we introduce.

This commit does not change the behavior of writing (Git writes changed
path filters when explicitly instructed regardless of any config
variable), but a subsequent commit will restrict Git such that it will
only write when commitgraph.changedPathsVersion is a recognized value.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/commitgraph.txt | 26 ++++++++++++++++++++++---
 commit-graph.c                       |  5 +++--
 oss-fuzz/fuzz-commit-graph.c         |  2 +-
 repo-settings.c                      |  6 +++++-
 repository.h                         |  2 +-
 t/t4216-log-bloom.sh                 | 29 +++++++++++++++++++++++++++-
 6 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index 30604e4a4c..e68cdededa 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -9,6 +9,26 @@ commitGraph.maxNewFilters::
 	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
 
 commitGraph.readChangedPaths::
-	If true, then git will use the changed-path Bloom filters in the
-	commit-graph file (if it exists, and they are present). Defaults to
-	true. See linkgit:git-commit-graph[1] for more information.
+	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if true, and
+	commitGraph.changedPathsVersion=0 if false. (If commitGraph.changedPathVersion
+	is also set, commitGraph.changedPathsVersion takes precedence.)
+
+commitGraph.changedPathsVersion::
+	Specifies the version of the changed-path Bloom filters that Git will read and
+	write. May be -1, 0 or 1. Note that values greater than 1 may be
+	incompatible with older versions of Git which do not yet understand
+	those versions. Use caution when operating in a mixed-version
+	environment.
++
+Defaults to -1.
++
+If -1, Git will use the version of the changed-path Bloom filters in the
+repository, defaulting to 1 if there are none.
++
+If 0, Git will not read any Bloom filters, and will write version 1 Bloom
+filters when instructed to write.
++
+If 1, Git will only read version 1 Bloom filters, and will write version 1
+Bloom filters.
++
+See linkgit:git-commit-graph[1] for more information.
diff --git a/commit-graph.c b/commit-graph.c
index 00113b0f62..91c98ebc6c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -459,7 +459,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 			graph->read_generation_data = 1;
 	}
 
-	if (s->commit_graph_read_changed_paths) {
+	if (s->commit_graph_changed_paths_version) {
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   graph_read_bloom_index, graph);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
@@ -555,7 +555,8 @@ static void validate_mixed_bloom_settings(struct commit_graph *g)
 		}
 
 		if (g->bloom_filter_settings->bits_per_entry != settings->bits_per_entry ||
-		    g->bloom_filter_settings->num_hashes != settings->num_hashes) {
+		    g->bloom_filter_settings->num_hashes != settings->num_hashes ||
+		    g->bloom_filter_settings->hash_version != settings->hash_version) {
 			g->chunk_bloom_indexes = NULL;
 			g->chunk_bloom_data = NULL;
 			FREE_AND_NULL(g->bloom_filter_settings);
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index 2992079dd9..325c0b991a 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -19,7 +19,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	 * possible.
 	 */
 	the_repository->settings.commit_graph_generation_version = 2;
-	the_repository->settings.commit_graph_read_changed_paths = 1;
+	the_repository->settings.commit_graph_changed_paths_version = 1;
 	g = parse_commit_graph(&the_repository->settings, (void *)data, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);
diff --git a/repo-settings.c b/repo-settings.c
index 30cd478762..c821583fe5 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -23,6 +23,7 @@ void prepare_repo_settings(struct repository *r)
 	int value;
 	const char *strval;
 	int manyfiles;
+	int read_changed_paths;
 
 	if (!r->gitdir)
 		BUG("Cannot add settings for uninitialized repository");
@@ -53,7 +54,10 @@ void prepare_repo_settings(struct repository *r)
 	/* Commit graph config or default, does not cascade (simple) */
 	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
 	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
-	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
+	repo_cfg_bool(r, "commitgraph.readchangedpaths", &read_changed_paths, 1);
+	repo_cfg_int(r, "commitgraph.changedpathsversion",
+		     &r->settings.commit_graph_changed_paths_version,
+		     read_changed_paths ? -1 : 0);
 	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
 	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
 
diff --git a/repository.h b/repository.h
index 5f18486f64..f71154e12c 100644
--- a/repository.h
+++ b/repository.h
@@ -29,7 +29,7 @@ struct repo_settings {
 
 	int core_commit_graph;
 	int commit_graph_generation_version;
-	int commit_graph_read_changed_paths;
+	int commit_graph_changed_paths_version;
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;
 	int command_requires_full_index;
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 484dd093cd..642b960893 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -435,7 +435,7 @@ test_expect_success 'setup for mixed Bloom setting tests' '
 	done
 '
 
-test_expect_success 'ensure incompatible Bloom filters are ignored' '
+test_expect_success 'ensure Bloom filters with incompatible settings are ignored' '
 	# Compute Bloom filters with "unusual" settings.
 	git -C $repo rev-parse one >in &&
 	GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=3 git -C $repo commit-graph write \
@@ -485,6 +485,33 @@ test_expect_success 'merge graph layers with incompatible Bloom settings' '
 	test_must_be_empty err
 '
 
+test_expect_success 'ensure Bloom filter with incompatible versions are ignored' '
+	rm "$repo/$graph" &&
+
+	git -C $repo log --oneline --no-decorate -- $CENT >expect &&
+
+	# Compute v1 Bloom filters for commits at the bottom.
+	git -C $repo rev-parse HEAD^ >in &&
+	git -C $repo commit-graph write --stdin-commits --changed-paths \
+		--split <in &&
+
+	# Compute v2 Bloomfilters for the rest of the commits at the top.
+	git -C $repo rev-parse HEAD >in &&
+	git -C $repo -c commitGraph.changedPathsVersion=2 commit-graph write \
+		--stdin-commits --changed-paths --split=no-merge <in &&
+
+	test_line_count = 2 $repo/$chain &&
+
+	git -C $repo log --oneline --no-decorate -- $CENT >actual 2>err &&
+	test_cmp expect actual &&
+
+	layer="$(head -n 1 $repo/$chain)" &&
+	cat >expect.err <<-EOF &&
+	warning: disabling Bloom filters for commit-graph layer $SQ$layer$SQ due to incompatible settings
+	EOF
+	test_cmp expect.err err
+'
+
 get_first_changed_path_filter () {
 	test-tool read-graph bloom-filters >filters.dat &&
 	head -n 1 filters.dat
-- 
2.43.0.334.gd4dbce1db5.dirty

