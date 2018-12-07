Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13C720A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLGW1b (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:27:31 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48714 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGW1a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:27:30 -0500
Received: by mail-pg1-f202.google.com with SMTP id r16so3526230pgr.15
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fUuaWZ9uILJ9U3kozA7uwqoXi2bGUMszdd9WsCZFdQk=;
        b=rVNQoLMk0cL3nUGoc+PfXxS7l6TwvjDDXJusGK87ccVOrwI6GTH0LPgBncJ3ctBcHy
         RQFPsLTvMX2Of0oI4D3oOdMf9Zw76ktmAu/evgsFRunfNwbjEfiZsilrWix86yR1Ld/l
         W1cMplK1hYtD6k2Y2XlOoNsHrVOziS1MLyRztY0g6cz9nHiZ5MB7psm3My21GQM9zYFJ
         AcI2mAbTsexIbA1SNg7t44oF5RNH0WjAgNrym82f2ipyNUK5jj/gN5Aa9Pq316vKIgsw
         MZVDZm6I5eYqbD9o/ZaKU6vB3Dq/WffK0whTI2sFdXo5CUWMplInjfHt0dKVhMPMpu84
         P6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fUuaWZ9uILJ9U3kozA7uwqoXi2bGUMszdd9WsCZFdQk=;
        b=EX9iS9h06bBGspOmxsmpQ/cbSzg3YDUFz8tH8I+Sp4/tLmIlWgluZvAr5tGwYszQnJ
         uAxY6WcOJJhUYYQMiXR3oECSiRE9429FKi9WwTHevVw7MBt3b1KF9ZXAgqdTFGU+LCNr
         2dAyG4dE0787VS7c0qfvYxuZYyrkyT4SplNeMhhUW1Pw2cK/viknS3NqK+b7w1jeOyhJ
         xUP2udNbW7em3Cn1ZKhegleegofehwClkKEOoRzVP3H9oQrwedlscSSEHQwniWVYeuGM
         x5M9xDBNWQ7TLxbnkfhlWFEHQq1SzBYZuQs34HjcgZd5kPU8iG/tLkwN3nmQtyB6DsVo
         63hA==
X-Gm-Message-State: AA+aEWbVnyXOEoHvLdBeceLOndPhtTZ1H6Qiky+TruLTF45oVqEEFXZj
        4q9HJml5v972Ub3/qekpaDlc4qBQwkIvT6w9fZKrwkAVP0WuT0Bms+LbrzpSLGiXDX0z2GNsIGF
        2GWxq/rT8+DXtnTNDKlRyaCSrhM+/BcG94cGfEv4j4aa/R6Pq3Jc6IUXFGa4QP1c=
X-Google-Smtp-Source: AFSGD/UqEWHL/gME1/fMyGQb/7LtkHfI/4CackTh5MlY0LvjRZKNVx4YyFmQaJAl+18+is6yVQ1UPhAbEIHuew==
X-Received: by 2002:a63:da56:: with SMTP id l22mr2017069pgj.6.1544221649731;
 Fri, 07 Dec 2018 14:27:29 -0800 (PST)
Date:   Fri,  7 Dec 2018 14:27:22 -0800
In-Reply-To: <cover.1544221121.git.steadmon@google.com>
Message-Id: <0b57ecbe1b6c72d95311ba1bb30ea1ed9fd7e3e5.1544221121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544127439.git.steadmon@google.com> <cover.1544221121.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v3 1/3] commit-graph, fuzz: Add fuzzer for commit-graph
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Breaks load_commit_graph_one() into a new function,
parse_commit_graph(). The latter function operates on arbitrary buffers,
which makes it suitable as a fuzzing target. Since parse_commit_graph()
is only called by load_commit_graph_one() (and the fuzzer described
below), we omit error messages that would be duplicated by the caller.

Adds fuzz-commit-graph.c, which provides a fuzzing entry point
compatible with libFuzzer (and possibly other fuzzing engines).

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore          |  1 +
 Makefile            |  1 +
 commit-graph.c      | 53 ++++++++++++++++++++++++++++++---------------
 commit-graph.h      |  3 +++
 fuzz-commit-graph.c | 16 ++++++++++++++
 5 files changed, 57 insertions(+), 17 deletions(-)
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
index 40c855f185..07dd410f3c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -84,16 +84,10 @@ static int commit_graph_compatible(struct repository *r)
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
@@ -108,27 +102,55 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		die(_("graph file %s is too small"), graph_file);
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	ret = parse_commit_graph(graph_map, fd, graph_size);
+
+	if (!ret) {
+		munmap(graph_map, graph_size);
+		close(fd);
+		exit(1);
+	}
+
+	return ret;
+}
+
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
+	if (!graph_map)
+		return NULL;
+
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
@@ -152,7 +174,8 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
 			error(_("improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
 			      (uint32_t)chunk_offset);
-			goto cleanup_fail;
+			free(graph);
+			return NULL;
 		}
 
 		switch (chunk_id) {
@@ -187,7 +210,8 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 
 		if (chunk_repeated) {
 			error(_("chunk id %08x appears multiple times"), chunk_id);
-			goto cleanup_fail;
+			free(graph);
+			return NULL;
 		}
 
 		if (last_chunk_id == GRAPH_CHUNKID_OIDLOOKUP)
@@ -201,11 +225,6 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	}
 
 	return graph;
-
-cleanup_fail:
-	munmap(graph_map, graph_size);
-	close(fd);
-	exit(1);
 }
 
 static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
diff --git a/commit-graph.h b/commit-graph.h
index 9db40b4d3a..813e7c19f1 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -54,6 +54,9 @@ struct commit_graph {
 
 struct commit_graph *load_commit_graph_one(const char *graph_file);
 
+struct commit_graph *parse_commit_graph(void *graph_map, int fd,
+					size_t graph_size);
+
 /*
  * Return 1 if and only if the repository has a commit-graph
  * file and generation numbers are computed in that file.
diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
new file mode 100644
index 0000000000..cf790c9d04
--- /dev/null
+++ b/fuzz-commit-graph.c
@@ -0,0 +1,16 @@
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
+	g = parse_commit_graph((void *)data, -1, size);
+	free(g);
+
+	return 0;
+}
-- 
2.20.0.rc2.12.g4c11c11dec

