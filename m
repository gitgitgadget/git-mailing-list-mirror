Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6FD40DFC8
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935718; cv=none; b=oVtm15Y6AoTXROcOk2EMnV+9C0FqLruwg4mcZ2osdJY/471fRFm6zq2ImOp/85ppHwvnGn5M7dGA4fmHYK6voXcysnHISje4pl5GpDbL6afdl3sokj3yHjkWMKq8Uf/lz0UhJbXqc0qvMc3o0D9BQC9uXXt1wbRdAH/0EvvQGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935718; c=relaxed/simple;
	bh=FcMRNXPNpz/e8zXcoJdWAKI2a7FC6JuN2jBUNMO6edI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aQxZln2jmZrV6vEmaRzaXb+fPQuWhpIW6e4O2PC0QUFAByoVftMeiUh8qJQVdhZFj/P9p+27OOpHo3wXJhrRRtNzDYp4uCqRRZGoLZ4LmxaDVlP4o177ADJu6+1CFwN1lvv4ePFXcRkVImjJk47dYqosr/TFaWvjd1zkS74C0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VNoRiCTd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bro1Wqe1; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VNoRiCTd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bro1Wqe1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4DB6914000F5
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:08:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 06:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790935714;
	 x=1791022114; bh=MGPoBqUHUSHektnE5U/i6zyRkabBZ6mi8/Cznn34eSE=; b=
	VNoRiCTdzqaWzHUBLNgxS+4iKr+MpIn/25+HgL7QGOj4kWmW9pqLwpFX05dOfqBf
	dGkIkUe3zWjZvALG1a1G4Ihh5WeLrJSbc77DET2Nf2K2BE7kfe/Ix1osU54Qy6ir
	lpXDp0409FKvL9mAuUD6jPH5FErujCjiM3b0pYV7mZHTogEeEmQfSLpyw79sdRRj
	6HM50gjgjPOPWTdLcpydrM5TrXgvmd/kYlfsx0LL+szZDPTQAy0q/6CpUGG5fO7m
	Nw1aE7yGOlquPiMTiBJIZ+2xxYhSO5px7UDDr8fYuWNK7ywqonP0TzR380xdGA/u
	XWIBsRng6jrj5PYm95qhsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790935714; x=
	1791022114; bh=MGPoBqUHUSHektnE5U/i6zyRkabBZ6mi8/Cznn34eSE=; b=b
	ro1Wqe1JtoOyn1fR4ZPws/xIhICfxu+D2obGAlUVqrqg1gW3N8Ix59xeMBO04AHd
	Z2yw2W+JJKoKpa8HLvXmqnwwq+NSKQLGSWAIEAwMy97FBqc730f2iFH/RYmtkRLX
	j9YKyhTtQ36h4NGT7hq9l0Q0Qq1ULiN08IWoLQUQjgx4uqyuF5LkB39K6rQeVRA/
	Z9gxVRGEE+vtDYRaJ9YTCHfnBo/fmcCAkzs3/0IbOJ06peiRLxJGrxMVTxAWcsN+
	l00r6psuZsihrL9Jay3fbnfcCwP4CPoMJpjgYJfViJA26HseSvU1Vp1uO4+4xm1p
	4HPorIJoGyW2GtJ+oDWBg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935714; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZbJD6dvlF3o6c6i7mvFNy1Z9Ri5HuNeXk6jy9RQzerPMx6U
	aITxg3GKbJEeKcM7qsadoDkXjGLqlZXZP8Qfq2gvnoZ2l2QvfIXRMG3ceiqDCJpE
	A2FcisCp4qVNkasJOp45RlRjoON65riYDDAriU5K2zQ95eEqEjtmdfKWxs64tC0N
	nBTOnAzxkwbQbfhVXenJTQ6UrDuXW6jYAYuLvhkZl1MMR1BsfgTS5H0Zb/fXdoxg
	+NvTTxomScc2LBLhhuSsk8XWZySyu/OFHoowwxkQZvebU+BtrwbfC7PVW2MB8PMA
	6YthvDZTJf4I6SBBCGooMiC1sPl9tb0a3BqoskA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vOOdGYtoMXHj787829j7+I861iZegXAQPYIHkKBdPSo=:FcMRNXPNpz/e8zXcoJdWAKI2a7FC6JuN2jBUNMO6edI=;
X-ME-Sender: <xms:ooK_amDf2d1vrcfJLzdtIJxjGv0JWY5MZNCdhtEapKe77f8WxQ7Xaw>
    <xme:ooK_andwlAeWETAqbilGRBGDDL0iJdfHkaPcFQ9aUtxN5dNJigCRRLN5VRWJnxOYn
    4-XRvW0nDYhm1g-Q_23z-BHlSED6OrH7ZYXjs5MoOphNJMEDTmyUg>
X-ME-Received: <xmr:ooK_avM3FfPz0gLHz2dOTIe4ywFZaCowVY2oaioDgcjoslGD9tvjzw>
X-ME-Proxy-Cause: dmFkZTF34l82022tRH/XgLve1GnCAagsK1/sNQ03J1wZMCaKRfCFCANyInDwpxNlKo26XL
    EXnDaIhvf6eeyj8SFpLxHe7kMLyAMTddf/VH/Rk//b+JdUzKpEnqhJ/mj6T6WBc3r6ZJE/
    Hr1v675783mYwdLtIr+rwnhjt9V2Sg0kW0Y2Oh+akYz5iWsSjkq3O4mWIO7qqzL2LqWlBu
    4qb3Nz76srjHiKLX7WGKMZWL03bhjvTx5w07iAecZ2+wGDzrZnOrFMya6obWUIWKlk9RXi
    ATp2I5KNGIOri6x7B1ZipZsHWqVLLL4aev/pKUNaysgOv1nDj7mFcdqRSD+T2EP7frLRXO
    48DLQjnw3kx+3QK13jRogSyVKoV7rbiITbGAex04cL2wQBaPbhcSxLsNcVsBNMzNz1ajfo
    iEIsupnlue0ZcJASdjT/tf6NornuxMlIh6A+cBLtmxYOYVfDeK055oUBORDNiOOfq4KDce
    yyoAQkIOv0N+h9e1IHtym7N3PpY3LLmASEifv+iTbi+eAgOSUBGmZauKNO4vzt9HaZO2qu
    VJ/Vphrwu2b7m1JehlfG8rmKTQ6xBg7uG9iZeb6Al8vTW69SfkA+oGOjpTn8aqxmLhXIAv
    uNm5r8y4ReBEb+EYS143RRdpXhZf6kMhZf5qkC4cQyAYs8tz4hwBAqF+Ks6Q
X-ME-Proxy: <xmx:ooK_ap6lxkYtvyx3t46nChxgIPLV6ffnaiit0M0un3o6uvbUQMnCiQ>
    <xmx:ooK_arJtLe6N3_V8XUt2j6arNLPzbX1RlVZ0bDrMiunU7e_VS3_JiQ>
    <xmx:ooK_areNqHeAqmqeq-nq6VTK1Kiu9szPmY388hURJY9NhSc6Bh_Dlg>
    <xmx:ooK_amfKycflaQAdOO_hEOq4l69nVzN7mN8y5EdofF7TgXm8U0eavQ>
    <xmx:ooK_apCYRzPKVoBLpuWOnMoC-mJtsnIAb7fH39BvJuxI6LfizkMesdJL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:08:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c12624b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:08:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 12:08:13 +0200
Subject: [PATCH 02/13] commit-graph: stop depending on `struct odb_source`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-odb-move-alternates-v1-2-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

To read or write a commit graph we require access to the repository that
the graph should be read from or written for as well as the object
directory to derive its location. Instead of passing in these two bits
of information explicitly though, we pass in a `struct odb_source`,
which carries with it both of these pieces of information.

But ultimately, this is somewhat flawed as we now assume that the source
even has an on-disk representation, and furthermore we assume that the
commit graphs would live in ".git/objects/info". This is true for the
"files" backend, but it's not necessarily true for any other backend
that we may eventually want to introduce. So eventually, we'll want to
evolve the commit-graph subsystem to become agnostic of the backend's
layout and let the backend itself decide where to read a commit graph
from or where to write it to.

We're not there yet to do that switch, but the current design is already
causing issues for the intent of this patch series where we want to move
alternates into the "files" backend.

Convert the subsystem to take a repository plus an object directory path
instead. This unblocks moving around alternates, and it's also a step
in the right direction for moving commit graphs into the source in a
later series.

Note that we previously compared the `struct odb_source` pointers of two
commit graphs to figure out whether they were located in the same object
directory, whereas we now have to compare their paths. Callers may pass
in those paths in different forms though, for example relative to the
current working directory or as absolute paths. Convert the object
directory into an absolute path both when loading and when writing
commit graphs so that the comparisons become more robust.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c     |  10 ++--
 builtin/commit.c           |   2 +-
 builtin/fetch.c            |   4 +-
 builtin/gc.c               |   3 +-
 builtin/merge.c            |   2 +-
 commit-graph.c             | 115 +++++++++++++++++++++++++--------------------
 commit-graph.h             |  31 ++++++++----
 t/helper/test-read-graph.c |   3 +-
 t/t4216-log-bloom.sh       |   4 +-
 9 files changed, 102 insertions(+), 72 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index b5784ad3c7..a986f08a94 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -104,8 +104,8 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 	source = odb_find_source_or_die(the_repository->objects, opts.obj_dir);
-	graph_name = get_commit_graph_filename(source);
-	chain_name = get_commit_graph_chain_filename(source);
+	graph_name = get_commit_graph_filename(source->path);
+	chain_name = get_commit_graph_chain_filename(source->path);
 	if (open_commit_graph(graph_name, &fd, &st))
 		opened = OPENED_GRAPH;
 	else if (errno != ENOENT)
@@ -123,7 +123,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opened == OPENED_NONE)
 		return 0;
 	else if (opened == OPENED_GRAPH)
-		graph = load_commit_graph_one_fd_st(source, fd, &st);
+		graph = load_commit_graph_one_fd_st(the_repository, source->path, fd, &st);
 	else
 		graph = load_commit_graph_chain_fd_st(the_repository->objects, fd, &st,
 						      &incomplete_chain);
@@ -297,7 +297,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	source = odb_find_source_or_die(the_repository->objects, opts.obj_dir);
 
 	if (opts.reachable) {
-		if (write_commit_graph_reachable(source, flags, &write_opts))
+		if (write_commit_graph_reachable(the_repository, source->path, flags, &write_opts))
 			result = 1;
 		goto cleanup;
 	}
@@ -334,7 +334,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 		stop_progress(&progress);
 	}
 
-	if (write_commit_graph(source,
+	if (write_commit_graph(the_repository, source->path,
 			       opts.stdin_packs ? &pack_indexes : NULL,
 			       opts.stdin_commits ? &commits : NULL,
 			       flags,
diff --git a/builtin/commit.c b/builtin/commit.c
index 840b6b4083..0e750f6157 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1959,7 +1959,7 @@ int cmd_commit(int argc,
 		      "new index file. Check that disk is not full and quota is\n"
 		      "not exceeded, and then \"git restore --staged :/\" to recover."));
 
-	git_test_write_commit_graph_or_die(the_repository->objects->sources);
+	git_test_write_commit_graph_or_die(the_repository);
 
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(the_repository, quiet);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2decc6cfd..a4b21d2651 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -15,6 +15,7 @@
 #include "refspec.h"
 #include "object-name.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "oidset.h"
 #include "oid-array.h"
 #include "commit.h"
@@ -2900,7 +2901,8 @@ int cmd_fetch(int argc,
 			commit_graph_flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 		trace2_region_enter("fetch", "write-commit-graph", the_repository);
-		write_commit_graph_reachable(the_repository->objects->sources,
+		write_commit_graph_reachable(the_repository,
+					     the_repository->objects->sources->path,
 					     commit_graph_flags,
 					     NULL);
 		trace2_region_leave("fetch", "write-commit-graph", the_repository);
diff --git a/builtin/gc.c b/builtin/gc.c
index 57a3520263..7acd4f3215 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -733,7 +733,8 @@ int cmd_gc(int argc,
 	}
 
 	if (the_repository->settings.gc_write_commit_graph == 1)
-		write_commit_graph_reachable(the_repository->objects->sources,
+		write_commit_graph_reachable(the_repository,
+					     the_repository->objects->sources->path,
 					     !opts.quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 5b4eb23a83..d7bf209114 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1863,7 +1863,7 @@ int cmd_merge(int argc,
 	if (squash) {
 		finish(head_commit, remoteheads, NULL, NULL);
 
-		git_test_write_commit_graph_or_die(the_repository->objects->sources);
+		git_test_write_commit_graph_or_die(the_repository);
 	} else
 		write_merge_state(remoteheads);
 
diff --git a/commit-graph.c b/commit-graph.c
index 73814c1622..80ebc6a542 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,6 +1,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "config.h"
 #include "csum-file.h"
 #include "environment.h"
@@ -28,7 +29,7 @@
 #include "tree.h"
 #include "chunk-format.h"
 
-void git_test_write_commit_graph_or_die(struct odb_source *source)
+void git_test_write_commit_graph_or_die(struct repository *repo)
 {
 	int flags = 0;
 	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
@@ -37,7 +38,7 @@ void git_test_write_commit_graph_or_die(struct odb_source *source)
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	if (write_commit_graph_reachable(source, flags, NULL))
+	if (write_commit_graph_reachable(repo, repo->objects->sources->path, flags, NULL))
 		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
 }
 
@@ -196,21 +197,21 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	return 0;
 }
 
-char *get_commit_graph_filename(struct odb_source *source)
+char *get_commit_graph_filename(const char *dir)
 {
-	return xstrfmt("%s/info/commit-graph", source->path);
+	return xstrfmt("%s/info/commit-graph", dir);
 }
 
-static char *get_split_graph_filename(struct odb_source *source,
+static char *get_split_graph_filename(const char *dir,
 				      const char *oid_hex)
 {
-	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", source->path,
+	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", dir,
 		       oid_hex);
 }
 
-char *get_commit_graph_chain_filename(struct odb_source *source)
+char *get_commit_graph_chain_filename(const char *dir)
 {
-	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", source->path);
+	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", dir);
 }
 
 static struct commit_graph *alloc_commit_graph(void)
@@ -253,7 +254,8 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_one_fd_st(struct odb_source *source,
+struct commit_graph *load_commit_graph_one_fd_st(struct repository *repo,
+						 const char *dir,
 						 int fd, struct stat *st)
 {
 	void *graph_map;
@@ -262,7 +264,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct odb_source *source,
 
 	graph_size = xsize_t(st->st_size);
 
-	if (graph_size < graph_min_size(source->odb->repo->hash_algo)) {
+	if (graph_size < graph_min_size(repo->hash_algo)) {
 		close(fd);
 		error(_("commit-graph file is too small"));
 		return NULL;
@@ -270,9 +272,9 @@ struct commit_graph *load_commit_graph_one_fd_st(struct odb_source *source,
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	ret = parse_commit_graph(source->odb->repo, graph_map, graph_size);
+	ret = parse_commit_graph(repo, graph_map, graph_size);
 	if (ret)
-		ret->odb_source = source;
+		ret->dir = absolute_pathdup(dir);
 	else
 		munmap(graph_map, graph_size);
 
@@ -410,6 +412,7 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 
 	graph = alloc_commit_graph();
 
+	graph->repo = r;
 	graph->hash_algo = r->hash_algo;
 	graph->num_chunks = *(unsigned char*)(data + 6);
 	graph->data = graph_map;
@@ -490,7 +493,8 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 	return NULL;
 }
 
-static struct commit_graph *load_commit_graph_one(struct odb_source *source,
+static struct commit_graph *load_commit_graph_one(struct repository *repo,
+						  const char *dir,
 						  const char *graph_file)
 {
 	struct stat st;
@@ -501,17 +505,18 @@ static struct commit_graph *load_commit_graph_one(struct odb_source *source,
 	if (!open_ok)
 		return NULL;
 
-	g = load_commit_graph_one_fd_st(source, fd, &st);
+	g = load_commit_graph_one_fd_st(repo, dir, fd, &st);
 	if (g)
-		g->filename = xstrdup(graph_file);
+		g->filename = absolute_pathdup(graph_file);
 
 	return g;
 }
 
-static struct commit_graph *load_commit_graph_v1(struct odb_source *source)
+static struct commit_graph *load_commit_graph_v1(struct repository *repo,
+						 const char *dir)
 {
-	char *graph_name = get_commit_graph_filename(source);
-	struct commit_graph *g = load_commit_graph_one(source, graph_name);
+	char *graph_name = get_commit_graph_filename(dir);
+	struct commit_graph *g = load_commit_graph_one(repo, dir, graph_name);
 	free(graph_name);
 
 	return g;
@@ -666,8 +671,8 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 
 		valid = 0;
 		for (source = odb->sources; source; source = source->next) {
-			char *graph_name = get_split_graph_filename(source, line.buf);
-			struct commit_graph *g = load_commit_graph_one(source, graph_name);
+			char *graph_name = get_split_graph_filename(source->path, line.buf);
+			struct commit_graph *g = load_commit_graph_one(odb->repo, source->path, graph_name);
 
 			free(graph_name);
 
@@ -700,29 +705,31 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 	return graph_chain;
 }
 
-static struct commit_graph *load_commit_graph_chain(struct odb_source *source)
+static struct commit_graph *load_commit_graph_chain(struct repository *repo,
+						    const char *dir)
 {
-	char *chain_file = get_commit_graph_chain_filename(source);
+	char *chain_file = get_commit_graph_chain_filename(dir);
 	struct stat st;
 	int fd;
 	struct commit_graph *g = NULL;
 
-	if (open_commit_graph_chain(chain_file, &fd, &st, source->odb->repo->hash_algo)) {
+	if (open_commit_graph_chain(chain_file, &fd, &st, repo->hash_algo)) {
 		int incomplete;
 		/* ownership of fd is taken over by load function */
-		g = load_commit_graph_chain_fd_st(source->odb, fd, &st, &incomplete);
+		g = load_commit_graph_chain_fd_st(repo->objects, fd, &st, &incomplete);
 	}
 
 	free(chain_file);
 	return g;
 }
 
-struct commit_graph *read_commit_graph_one(struct odb_source *source)
+struct commit_graph *read_commit_graph_one(struct repository *repo,
+					   const char *dir)
 {
-	struct commit_graph *g = load_commit_graph_v1(source);
+	struct commit_graph *g = load_commit_graph_v1(repo, dir);
 
 	if (!g)
-		g = load_commit_graph_chain(source);
+		g = load_commit_graph_chain(repo, dir);
 
 	return g;
 }
@@ -767,7 +774,7 @@ static struct commit_graph *prepare_commit_graph(struct repository *r)
 		return NULL;
 
 	for (source = r->objects->sources; source; source = source->next) {
-		r->objects->commit_graph = read_commit_graph_one(source);
+		r->objects->commit_graph = read_commit_graph_one(r, source->path);
 		if (r->objects->commit_graph)
 			break;
 	}
@@ -866,7 +873,7 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
 		die("invalid parent position %"PRIu32, pos);
 
 	load_oid_from_graph(g, pos, &oid);
-	c = lookup_commit(g->odb_source->odb->repo, &oid);
+	c = lookup_commit(g->repo, &oid);
 	if (!c)
 		die(_("could not find commit %s"), oid_to_hex(&oid));
 	commit_graph_data_at(c)->graph_pos = pos;
@@ -1103,7 +1110,7 @@ static struct tree *load_tree_for_commit(struct commit_graph *g,
 				graph_pos - g->num_commits_in_base);
 
 	oidread(&oid, commit_data, g->hash_algo);
-	set_commit_tree(c, lookup_tree(g->odb_source->odb->repo, &oid));
+	set_commit_tree(c, lookup_tree(g->repo, &oid));
 
 	return c->maybe_tree;
 }
@@ -1126,7 +1133,7 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 
 struct write_commit_graph_context {
 	struct repository *r;
-	struct odb_source *odb_source;
+	char *dir;
 	char *graph_name;
 	struct oid_array oids;
 	struct commit_stack commits;
@@ -1902,7 +1909,8 @@ static int add_ref_to_set(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-int write_commit_graph_reachable(struct odb_source *source,
+int write_commit_graph_reachable(struct repository *repo,
+				 const char *dir,
 				 enum commit_graph_write_flags flags,
 				 const struct commit_graph_opts *opts)
 {
@@ -1911,20 +1919,20 @@ int write_commit_graph_reachable(struct odb_source *source,
 	int result;
 
 	memset(&data, 0, sizeof(data));
-	data.repo = source->odb->repo;
+	data.repo = repo;
 	data.commits = &commits;
 
 	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
 		data.progress = start_delayed_progress(
-			source->odb->repo,
+			repo,
 			_("Collecting referenced commits"), 0);
 
-	refs_for_each_ref(get_main_ref_store(source->odb->repo), add_ref_to_set,
+	refs_for_each_ref(get_main_ref_store(repo), add_ref_to_set,
 			  &data);
 
 	stop_progress(&data.progress);
 
-	result = write_commit_graph(source, NULL, &commits,
+	result = write_commit_graph(repo, dir, NULL, &commits,
 				    flags, opts);
 
 	oidset_clear(&commits);
@@ -2103,10 +2111,10 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 		strbuf_addf(&tmp_file,
 			    "%s/info/commit-graphs/tmp_graph_XXXXXX",
-			    ctx->odb_source->path);
+			    ctx->dir);
 		ctx->graph_name = strbuf_detach(&tmp_file, NULL);
 	} else {
-		ctx->graph_name = get_commit_graph_filename(ctx->odb_source);
+		ctx->graph_name = get_commit_graph_filename(ctx->dir);
 	}
 
 	if (safe_create_leading_directories(ctx->r, ctx->graph_name)) {
@@ -2116,7 +2124,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	if (ctx->split) {
-		char *lock_name = get_commit_graph_chain_filename(ctx->odb_source);
+		char *lock_name = get_commit_graph_chain_filename(ctx->dir);
 
 		repo_hold_lock_file_for_update_mode(ctx->r, &lk, lock_name,
 						    LOCK_DIE_ON_ERROR, 0444);
@@ -2205,7 +2213,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	if (ctx->split && ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
 		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
-		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->odb_source, new_base_hash);
+		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->dir, new_base_hash);
 
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
 		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2]);
@@ -2245,7 +2253,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 				}
 			}
 		} else {
-			char *graph_name = get_commit_graph_filename(ctx->odb_source);
+			char *graph_name = get_commit_graph_filename(ctx->dir);
 			unlink(graph_name);
 			free(graph_name);
 		}
@@ -2253,7 +2261,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
 		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] =
 			xstrdup(hash_to_hex_algop(file_hash, ctx->r->hash_algo));
-		final_graph_name = get_split_graph_filename(ctx->odb_source,
+		final_graph_name = get_split_graph_filename(ctx->dir,
 					ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1]);
 		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
@@ -2305,7 +2313,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 	    flags != COMMIT_GRAPH_SPLIT_REPLACE) {
 		while (g && (g->num_commits <= st_mult(size_mult, num_commits) ||
 			    (max_commits && num_commits > max_commits))) {
-			if (g->odb_source != ctx->odb_source)
+			if (strcmp(g->dir, ctx->dir))
 				break;
 
 			if (unsigned_add_overflows(num_commits, g->num_commits))
@@ -2327,10 +2335,10 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
 		    "should be 1 with --split=replace");
 
 	if (ctx->num_commit_graphs_after == 2) {
-		char *old_graph_name = get_commit_graph_filename(g->odb_source);
+		char *old_graph_name = get_commit_graph_filename(g->dir);
 
 		if (!strcmp(g->filename, old_graph_name) &&
-		    g->odb_source != ctx->odb_source) {
+		    strcmp(g->dir, ctx->dir)) {
 			ctx->num_commit_graphs_after = 1;
 			ctx->new_base_graph = NULL;
 		}
@@ -2500,13 +2508,13 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	if (ctx->opts && ctx->opts->expire_time)
 		expire_time = ctx->opts->expire_time;
 	if (!ctx->split) {
-		char *chain_file_name = get_commit_graph_chain_filename(ctx->odb_source);
+		char *chain_file_name = get_commit_graph_chain_filename(ctx->dir);
 		unlink(chain_file_name);
 		free(chain_file_name);
 		ctx->num_commit_graphs_after = 0;
 	}
 
-	strbuf_addstr(&path, ctx->odb_source->path);
+	strbuf_addstr(&path, ctx->dir);
 	strbuf_addstr(&path, "/info/commit-graphs");
 	dir = opendir(path.buf);
 
@@ -2548,16 +2556,15 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	strbuf_release(&path);
 }
 
-int write_commit_graph(struct odb_source *source,
+int write_commit_graph(struct repository *r,
+		       const char *dir,
 		       const struct string_list *const pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
 		       const struct commit_graph_opts *opts)
 {
-	struct repository *r = source->odb->repo;
 	struct write_commit_graph_context ctx = {
 		.r = r,
-		.odb_source = source,
 		.append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0,
 		.report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0,
 		.split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0,
@@ -2588,6 +2595,8 @@ int write_commit_graph(struct odb_source *source,
 		return 0;
 	}
 
+	ctx.dir = absolute_pathdup(dir);
+
 	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
@@ -2710,6 +2719,7 @@ int write_commit_graph(struct odb_source *source,
 cleanup:
 	free(ctx.graph_name);
 	free(ctx.base_graph_name);
+	free(ctx.dir);
 	commit_stack_clear(&ctx.commits);
 	oid_array_clear(&ctx.oids);
 	clear_topo_level_slab(&topo_levels);
@@ -2762,7 +2772,7 @@ static int verify_one_commit_graph(struct commit_graph *g,
 				   struct progress *progress,
 				   uint64_t *seen)
 {
-	struct repository *r = g->odb_source->odb->repo;
+	struct repository *r = g->repo;
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid;
 	struct commit *seen_gen_zero = NULL;
@@ -2926,7 +2936,7 @@ int verify_commit_graph(struct commit_graph *g, int flags)
 		if (!(flags & COMMIT_GRAPH_VERIFY_SHALLOW))
 			total += g->num_commits_in_base;
 
-		progress = start_progress(g->odb_source->odb->repo,
+		progress = start_progress(g->repo,
 					  _("Verifying commits in commit graph"),
 					  total);
 	}
@@ -2949,6 +2959,7 @@ void free_commit_graph(struct commit_graph *g)
 
 		if (g->data)
 			munmap((void *)g->data, g->data_len);
+		free(g->dir);
 		free(g->filename);
 		free(g->bloom_filter_settings);
 		free(g);
diff --git a/commit-graph.h b/commit-graph.h
index 13ca4ff010..bccf9c5c84 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -21,7 +21,7 @@
  * call this method outside of a builtin, and only if you know what
  * you are doing!
  */
-void git_test_write_commit_graph_or_die(struct odb_source *source);
+void git_test_write_commit_graph_or_die(struct repository *repo);
 
 struct commit;
 struct bloom_filter_settings;
@@ -29,8 +29,8 @@ struct repository;
 struct object_database;
 struct string_list;
 
-char *get_commit_graph_filename(struct odb_source *source);
-char *get_commit_graph_chain_filename(struct odb_source *source);
+char *get_commit_graph_filename(const char *dir);
+char *get_commit_graph_chain_filename(const char *dir);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st,
 			    const struct git_hash_algo *hash_algo);
@@ -85,12 +85,13 @@ struct commit_graph {
 	const unsigned char *data;
 	size_t data_len;
 
+	struct repository *repo;
 	const struct git_hash_algo *hash_algo;
 	unsigned char num_chunks;
 	uint32_t num_commits;
 	struct object_id oid;
+	char *dir;
 	char *filename;
-	struct odb_source *odb_source;
 
 	uint32_t num_commits_in_base;
 	unsigned int read_generation_data;
@@ -114,12 +115,20 @@ struct commit_graph {
 	struct bloom_filter_settings *bloom_filter_settings;
 };
 
-struct commit_graph *load_commit_graph_one_fd_st(struct odb_source *source,
+/*
+ * Load commit graphs from the given object directory `dir`. The directory may
+ * be given as a relative path; it is canonicalized internally so that graphs
+ * loaded from the same directory compare equal regardless of how the caller
+ * spelled the path.
+ */
+struct commit_graph *load_commit_graph_one_fd_st(struct repository *repo,
+						 const char *dir,
 						 int fd, struct stat *st);
 struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 						   int fd, struct stat *st,
 						   int *incomplete_chain);
-struct commit_graph *read_commit_graph_one(struct odb_source *source);
+struct commit_graph *read_commit_graph_one(struct repository *repo,
+					   const char *dir);
 
 struct repo_settings;
 
@@ -171,11 +180,17 @@ struct commit_graph_opts {
  * and a negative value on failure. Note that if the repository
  * is not compatible with the commit-graph feature, then the
  * methods will return 0 without writing a commit-graph.
+ *
+ * The object directory `dir` may be given as a relative path; it is
+ * canonicalized internally so that it compares equal to the directory of
+ * graphs that have already been loaded.
  */
-int write_commit_graph_reachable(struct odb_source *source,
+int write_commit_graph_reachable(struct repository *repo,
+				 const char *dir,
 				 enum commit_graph_write_flags flags,
 				 const struct commit_graph_opts *opts);
-int write_commit_graph(struct odb_source *source,
+int write_commit_graph(struct repository *r,
+		       const char *dir,
 		       const struct string_list *pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 9f07b9c25a..a75c817e47 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -4,6 +4,7 @@
 #include "commit-graph.h"
 #include "repository.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "bloom.h"
 #include "setup.h"
 
@@ -81,7 +82,7 @@ int cmd__read_graph(int argc, const char **argv)
 
 	prepare_repo_settings(the_repository);
 
-	graph = read_commit_graph_one(source);
+	graph = read_commit_graph_one(the_repository, source->path);
 	if (!graph) {
 		ret = 1;
 		goto done;
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index ad2686669d..f57a3d6621 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -755,7 +755,7 @@ test_expect_success PERL_TEST_HELPERS 'Bloom reader notices too-small data chunk
 test_expect_success PERL_TEST_HELPERS 'Bloom reader notices out-of-bounds filter offsets' '
 	check_corrupt_graph BIDX 12 FFFFFFFF &&
 	# use grep to avoid depending on exact chunk size
-	test_grep "warning: ignoring out-of-range offset (4294967295) for changed-path filter at pos 3 of .git/objects/info/commit-graph" err
+	test_grep "warning: ignoring out-of-range offset (4294967295) for changed-path filter at pos 3 of $(pwd)/.git/objects/info/commit-graph" err
 '
 
 test_expect_success PERL_TEST_HELPERS 'Bloom reader notices too-small index chunk' '
@@ -773,7 +773,7 @@ test_expect_success PERL_TEST_HELPERS 'Bloom reader notices out-of-order index o
 	# actually reading from the bogus offsets anyway.
 	corrupt_graph BIDX 4 0000000c00000005 &&
 	echo "warning: ignoring decreasing changed-path index offsets" \
-		"(12 > 5) for positions 1 and 2 of .git/objects/info/commit-graph" >expect.err &&
+		"(12 > 5) for positions 1 and 2 of $(pwd)/.git/objects/info/commit-graph" >expect.err &&
 	git -c core.commitGraph=false log -- A/B/file2 >expect.out &&
 	git -c core.commitGraph=true log -- A/B/file2 >out 2>err &&
 	test_cmp expect.out out &&

-- 
2.56.0.379.gc618271300.dirty

