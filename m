Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6DC211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 22:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeLEWc6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 17:32:58 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:58192 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLEWc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 17:32:57 -0500
Received: by mail-it1-f201.google.com with SMTP id n124so17912667itb.7
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 14:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=/ohj4nZbUM+NRK4JxQNk/zvwvcSjo7AQBLrRXYNwEo0=;
        b=qB+SEneLk0dfTPpr7mdLI8YJbvEW8diHvsiN68hm83RcCQ4cujO6oOYaMYz13m/sHr
         p6A6VjuzBNJ3FMhnBBkiRgFF9TSdlzccu1G96YmYZAOb1I3NiGY6jpZNWr4ZO5oWJ28e
         a1QDrwolAgYiIE5c3PPKqXcMPQyuwDOipq0f4ql5JjzQXX7dsJlRjY9KLrDi8ybZI/4/
         u5Kl/BzqVYSv8uWdAMMWJ8V1TjOSwDsRcAT6VKklqft4F5vMklieTe6ti0qucKXnb0FR
         ZzbTn5BbTZtqUCas3IPh5f8jJdC+nbRDT7XTADpaSDfOJFAQWUK/NftTTFKb6hcC/xpX
         wZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=/ohj4nZbUM+NRK4JxQNk/zvwvcSjo7AQBLrRXYNwEo0=;
        b=hIY1tyYK/pZ+SfqJu6e1cdJtQxVJcUZDAvDQg6+leeGAryHzxO4PL4Rn0lIGTJXIxK
         Ws+F++kBX4oA4M8GJNOnUdKTPZGaNcUplvtvs3FL2wLXG/lGvR0o8wOkAYXgrTyjN71T
         0OlK8voxmV+jdCpD1PV3HwGrZvBARMrxgaKl6rAn/NQtbD8M6b6ZorgwWGBzGrmmNss8
         90r1RK58W3c0DBIYsusdSD2I7bjZtGSTHKgm4VQt/ohg2SmfDhhLow8RLa3K7zfED2Hs
         hILxKLmOQkX0VgchOOLBAsnbBCh13x5CuUb53GRvWakwSKEmokeCvHBvPTtxMmINv//s
         rn5Q==
X-Gm-Message-State: AA+aEWZjYl8NarXSmUqu9+XTi9w3kzYQwzlRv73O9SecJ3T4lfImAK/7
        2Y7eAHgbkD7thUXZ7HWc7agRyOypwXdmBI+CXkc4M0+PHGW3B9vPAIBIT+/BeGniFkJ5OvcHhNB
        0gnDlHv27ArFQOeijs6wNBtWhCpxFXxlALTt0xSe8c9N4EdIIjcPw7SwoG3NURPs=
X-Google-Smtp-Source: AFSGD/W8LQ8/8bTG1/uYtsetNyob1Lm479dlDGitghtV9Qs8PUtq83+3gnFpiLXGnbAvHAKslJIRwzfzy3+QuQ==
X-Received: by 2002:a24:1c5:: with SMTP id 188mr9183509itk.12.1544049176664;
 Wed, 05 Dec 2018 14:32:56 -0800 (PST)
Date:   Wed,  5 Dec 2018 14:32:50 -0800
In-Reply-To: <cover.1544048946.git.steadmon@google.com>
Message-Id: <53e62baaa8769bf8e90991e32e0d123cc6629559.1544048946.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH 1/2] commit-graph, fuzz: Add fuzzer for commit-graph
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Breaks load_commit_graph_one() into a new function,
parse_commit_graph(). The latter function operates on arbitrary buffers,
which makes it suitable as a fuzzing target.

Adds fuzz-commit-graph.c, which provides a fuzzing entry point
compatible with libFuzzer (and possibly other fuzzing engines).

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore          |  1 +
 Makefile            |  1 +
 commit-graph.c      | 63 +++++++++++++++++++++++++++++++++------------
 fuzz-commit-graph.c | 18 +++++++++++++
 4 files changed, 66 insertions(+), 17 deletions(-)
 create mode 100644 fuzz-commit-graph.c

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..8bcf153ed9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+/fuzz-commit-graph
 /fuzz_corpora
 /fuzz-pack-headers
 /fuzz-pack-idx
diff --git a/Makefile b/Makefile
index 1a44c811aa..6b72f37c29 100644
--- a/Makefile
+++ b/Makefile
@@ -684,6 +684,7 @@ SCRIPTS = $(SCRIPT_SH_INS) \
 
 ETAGS_TARGET = TAGS
 
+FUZZ_OBJS += fuzz-commit-graph.o
 FUZZ_OBJS += fuzz-pack-headers.o
 FUZZ_OBJS += fuzz-pack-idx.o
 
diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..0755359b1a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -46,6 +46,10 @@
 #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
 			+ GRAPH_FANOUT_SIZE + GRAPH_OID_LEN)
 
+struct commit_graph *parse_commit_graph(void *graph_map, int fd,
+					size_t graph_size);
+
+
 char *get_commit_graph_filename(const char *obj_dir)
 {
 	return xstrfmt("%s/info/commit-graph", obj_dir);
@@ -84,16 +88,10 @@ static int commit_graph_compatible(struct repository *r)
 struct commit_graph *load_commit_graph_one(const char *graph_file)
 {
 	void *graph_map;
-	const unsigned char *data, *chunk_lookup;
 	size_t graph_size;
 	struct stat st;
-	uint32_t i;
-	struct commit_graph *graph;
+	struct commit_graph *ret;
 	int fd = git_open(graph_file);
-	uint64_t last_chunk_offset;
-	uint32_t last_chunk_id;
-	uint32_t graph_signature;
-	unsigned char graph_version, hash_version;
 
 	if (fd < 0)
 		return NULL;
@@ -108,27 +106,61 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		die(_("graph file %s is too small"), graph_file);
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	ret = parse_commit_graph(graph_map, fd, graph_size);
+
+	if (ret == NULL) {
+		munmap(graph_map, graph_size);
+		close(fd);
+		exit(1);
+	}
+
+	return ret;
+}
+
+/*
+ * This function is intended to be used only from load_commit_graph_one() or in
+ * fuzz tests.
+ */
+struct commit_graph *parse_commit_graph(void *graph_map, int fd,
+					size_t graph_size)
+{
+	const unsigned char *data, *chunk_lookup;
+	uint32_t i;
+	struct commit_graph *graph;
+	uint64_t last_chunk_offset;
+	uint32_t last_chunk_id;
+	uint32_t graph_signature;
+	unsigned char graph_version, hash_version;
+
+	/*
+	 * This should already be checked in load_commit_graph_one, but we still
+	 * need a check here for when we're calling parse_commit_graph directly
+	 * from fuzz tests. We can omit the error message in that case.
+	 */
+	if (graph_size < GRAPH_MIN_SIZE)
+		return NULL;
+
 	data = (const unsigned char *)graph_map;
 
 	graph_signature = get_be32(data);
 	if (graph_signature != GRAPH_SIGNATURE) {
 		error(_("graph signature %X does not match signature %X"),
 		      graph_signature, GRAPH_SIGNATURE);
-		goto cleanup_fail;
+		return NULL;
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
 	if (graph_version != GRAPH_VERSION) {
 		error(_("graph version %X does not match version %X"),
 		      graph_version, GRAPH_VERSION);
-		goto cleanup_fail;
+		return NULL;
 	}
 
 	hash_version = *(unsigned char*)(data + 5);
 	if (hash_version != GRAPH_OID_VERSION) {
 		error(_("hash version %X does not match version %X"),
 		      hash_version, GRAPH_OID_VERSION);
-		goto cleanup_fail;
+		return NULL;
 	}
 
 	graph = alloc_commit_graph();
@@ -152,7 +184,8 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
 			error(_("improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
 			      (uint32_t)chunk_offset);
-			goto cleanup_fail;
+			free(graph);
+			return NULL;
 		}
 
 		switch (chunk_id) {
@@ -187,7 +220,8 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 
 		if (chunk_repeated) {
 			error(_("chunk id %08x appears multiple times"), chunk_id);
-			goto cleanup_fail;
+			free(graph);
+			return NULL;
 		}
 
 		if (last_chunk_id == GRAPH_CHUNKID_OIDLOOKUP)
@@ -201,11 +235,6 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	}
 
 	return graph;
-
-cleanup_fail:
-	munmap(graph_map, graph_size);
-	close(fd);
-	exit(1);
 }
 
 static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
new file mode 100644
index 0000000000..420851d0d2
--- /dev/null
+++ b/fuzz-commit-graph.c
@@ -0,0 +1,18 @@
+#include "object-store.h"
+#include "commit-graph.h"
+
+struct commit_graph *parse_commit_graph(void *graph_map, int fd,
+					size_t graph_size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	struct commit_graph *g;
+
+	g = parse_commit_graph((void *) data, -1, size);
+	if (g)
+		free(g);
+
+	return 0;
+}
-- 
2.20.0.rc2.403.gdbc3b29805-goog

