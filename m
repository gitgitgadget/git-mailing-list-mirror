Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C166C00528
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjHASmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjHASmM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:42:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015352690
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:42:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5704995f964so71511967b3.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915320; x=1691520120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m62EFluf3rrteAkRTvi8Wb5maZSXv4vILhSfCu3DXRU=;
        b=jd195zbwjqPQV1ol/yvluUAQUF7ik3gzpQ0Q2D3ulig+lOzDYIVudGJO29u7/MY1W0
         YrCVRg8edHh/0mUXMhyT1Nzkb0RHeS06oEssBMKp2iDNbPPCgExjWkCeUKbzsl6AI01G
         Z3oz3k2Y3kqr9e2mKWHeOC9yyj4iFXYw33OtrnNfW1FR/xkj7+MAqrhTkLENKhGa+8vA
         g/wviT6pGqc0aLJbEfK0pgtiM94wDk65Q7+5Kxh7POCsBSw1xGL5M7j04W8cpVqoXd+q
         N1weV7heB6RA7o9ULEeN3eGH4wpboq0aphAjq1ba1E1cK5F8Pc6Bc5Kv91AFkLGgkhy0
         C1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915320; x=1691520120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m62EFluf3rrteAkRTvi8Wb5maZSXv4vILhSfCu3DXRU=;
        b=YHkf9jbHByvpJlbSyV7dPuby+meRU2b72x0Qz3M2pRYKFf8K0mnZyg4/3JwDs5F4qT
         984nYespEmg8dGnpp4pWocJQ8MbRyW/uIpj7IWQP03RJSFWsg/3st9lu+T89O8FP3Hzj
         79AOVKea+tUAgIcXgjqwM48dvJ2V4OL7ZE27n/7FMROwGoOXG+ZntAx8kMqUVQpn7PCt
         4549iAYYQlQxkus+jTJ0sSRl45wDdnZPAdJ+swgi17+zLmL9zRJulzzBkx8GM0niyrQj
         mYpwsEcNPvz0EfqqWoYOHol1LupxbIEVmjJ86tOvZORxTw5AhZgZPYJO9lJOShMx5R4E
         8qFA==
X-Gm-Message-State: ABy/qLY12X6Ly+VRnj4UT+qq145iyct9on2mkif/aAZ6r6jwN0I5Udlv
        FDMP/PXUvrBSVSHyyOP2UqPAyJYVTyjqTWBc6M13kQw8hiy+SoGUPfmlJma9b/QQWyuvy+c96+7
        +KOpUGt9Lnk6mPo4TZi9Ntj+/5tYp4UoxhaDAM5Vkem3VW+B3nfm251+lF/QxAs9CvckjmTEg/z
        Z6
X-Google-Smtp-Source: APBJJlG/To7UZ+Ei6hu9WejucXIwCgiDN+NuN+/NH7e1mx8ALCu4eiw48tE5e8EpyaZ+16bSVYw7M6L2akNDYhIxyESl
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:a487:6e54:d296:9521])
 (user=jonathantanmy job=sendgmr) by 2002:a81:af0d:0:b0:57a:793:7fb0 with SMTP
 id n13-20020a81af0d000000b0057a07937fb0mr119385ywh.3.1690915320264; Tue, 01
 Aug 2023 11:42:00 -0700 (PDT)
Date:   Tue,  1 Aug 2023 11:41:41 -0700
In-Reply-To: <cover.1690912539.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1690912539.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <60f4faeff9e3c53c69acc85f033c33c1be632400.1690912539.git.jonathantanmy@google.com>
Subject: [PATCH v7 6/7] repo-settings: introduce commitgraph.changedPathsVersion
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---
 Documentation/config/commitgraph.txt | 23 ++++++++++++++++++++---
 commit-graph.c                       |  2 +-
 oss-fuzz/fuzz-commit-graph.c         |  2 +-
 repo-settings.c                      |  6 +++++-
 repository.h                         |  2 +-
 5 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index 30604e4a4c..2dc9170622 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -9,6 +9,23 @@ commitGraph.maxNewFilters::
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
+	write. May be -1, 0 or 1.
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
index efc697e437..1f26c07de4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -401,7 +401,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 			graph->read_generation_data = 1;
 	}
 
-	if (s->commit_graph_read_changed_paths) {
+	if (s->commit_graph_changed_paths_version) {
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
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
index 525f69c0c7..db8fe817f3 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -24,6 +24,7 @@ void prepare_repo_settings(struct repository *r)
 	int value;
 	const char *strval;
 	int manyfiles;
+	int read_changed_paths;
 
 	if (!r->gitdir)
 		BUG("Cannot add settings for uninitialized repository");
@@ -54,7 +55,10 @@ void prepare_repo_settings(struct repository *r)
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
-- 
2.41.0.585.gd2178a4bd4-goog

