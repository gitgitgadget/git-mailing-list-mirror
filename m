Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D589F1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 22:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390767AbfAOW0A (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 17:26:00 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:44149 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfAOW0A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 17:26:00 -0500
Received: by mail-qt1-f201.google.com with SMTP id j5so3815504qtk.11
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 14:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e0D2Q7gcDzj/gGaRh2cnHSQqOs2IqVFMwSdW//a6iio=;
        b=TQ7i2JW5pXm5CwHDPwgnMwcY78TVOKspXaKuB/rY+4I8/F/HWvTjUl3Vf/IHRsdZX7
         /rIKF2OoLsEsz/zEez4Wkj+8g3s2CbAg2DLty34P+m9krgtzwXfs+1bPI6sCyEupEDkR
         LY94tx04J4bXI+d1xmeLLBONWpsPbxDAZDGHhCwWgSi/qGsW6bS0HJ9/WALfGeGImIcI
         GyN0+214rvcUI4tCi/EyfgvNCZwQyP7aYrX7dnXTtC5vNjq5rUL1G/ishSSjpdb9fGZj
         wcjYvLYXdQo5+WPdnRyXi+usT+Da9gQ+XR6FfmSdUeA+Rsr9qpnTSVUoDiK7KdGoe1WF
         3NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e0D2Q7gcDzj/gGaRh2cnHSQqOs2IqVFMwSdW//a6iio=;
        b=kTQBT/0KG9yuejNNWXiRZx6z3yaV/E5FY7g045mbJQi7o1ldoBzfiE8OdMHAJJTHkB
         7zXTPQUnERs8ZaJCh/VJnFTAnifuF+cjkII/WquYVVO4IjGu/LDk5xG9AzDGcx1ZnGzr
         vK9YT+rAkE8cXnAkE4y9/un/4Uhj2Dbo+OGC7CBZZwIvn4U+oXO2EQAfc9DQ+Q4XhYV0
         iBqiSpzI3iU2mwaHAIq9mkNm6Uw3uzPdpE2kBLWNF4D4C6p8JuKL26UGGDR3AtmXo6nK
         +hklmJ2TJ/6tmI52ZWdbJ1M/O8e5/s3mc2UeFfKFM6fVOT7VWy0UMjkGX6VVJgYP64qX
         tVSQ==
X-Gm-Message-State: AJcUuken7aUTyQRGwlsPdxFeEy7SPszAeNwyGAL7Ct3iP60K/k4Zrn6R
        F7qnH3lS3Xz8JgzS7jbf8B6tmzYASzXa267EzH0xvb8bs/oMVghV42U7y/x9r/0G4z8CEmBiQBf
        1+8u7AG7JU5xbAyRtqLWvDCdORajbSKOMfQZt3AC2UkKzAsZ63/yFXAa2TOA3paM=
X-Google-Smtp-Source: ALg8bN7s79YMvuMuZ3KY+S03CpShKfYkVEcTUySMxtQezYyMqMbBFuMU0VuuzpCy1grWQgwC7dybycAFW6yhQg==
X-Received: by 2002:ac8:3364:: with SMTP id u33mr3439585qta.56.1547591159208;
 Tue, 15 Jan 2019 14:25:59 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:25:50 -0800
In-Reply-To: <cover.1547590928.git.steadmon@google.com>
Message-Id: <c4ec3fc3fc504c1d639845ea409108bb8f0b6d68.1547590928.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com> <cover.1547590928.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v6 1/3] commit-graph, fuzz: Add fuzzer for commit-graph
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Break load_commit_graph_one() into a new function, parse_commit_graph().
The latter function operates on arbitrary buffers, which makes it
suitable as a fuzzing target. Since parse_commit_graph() is only called
by load_commit_graph_one() (and the fuzzer described below), we omit
error messages that would be duplicated by the caller.

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
2.20.1.97.g81188d93c3-goog

