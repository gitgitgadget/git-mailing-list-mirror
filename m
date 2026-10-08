Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682D4718FB
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448583; cv=none; b=Aci+ORilc3XtATnuehkq3shLIrbH/IGm3CutfM+ifh30CNIW40o1d4gte9+4gRCZnmP3zpvPNZPc3nDyRhBirNe/K6uPLXiFqKsVgrRZ2XkpKFsvEDG35PgmtL+zLJH351QYAWAMCZumf22AJNhvopFPRLNyiLBgAObp/sVo8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448583; c=relaxed/simple;
	bh=b8H7hEQC6of4ikOU3o4f0X0vQQU/ow+vwzorl8OSUoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkfnBtdDlfm+jItkRuqNYLvc5zqX++bPP51CukbN/O3GDVH0ZfQRp/1HHgRUrZPDy0+zNTZGoXIllpA1F8I39JXhsotoRGILy1AsgG1V+POEbGyF2939SwXn9Id7ujlav3g4nynYU9PptWMjYy/9jWO9s5WFOtH7rgphJ5ur4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jE0oOayj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPEZyS7Y; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jE0oOayj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPEZyS7Y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2A181400137
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:36:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 08 Oct 2026 04:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791448580;
	 x=1791534980; bh=mCHyS9olUnY05XSWa6FUiNxGv+xmoXLVDqzJnsn/DVA=; b=
	jE0oOayjDqNh6LAtfE7YIZJCDfp9BIgIFe+vOzTA6JSCnY8KufkTHz8Qb4o6Imsi
	pmafLXMQK5Qd5GhSmcWSPCs+aV00HrGMJgtG+pHTistvjdOmxA+Xza/N/fBV7T64
	Qx3hritOUt4iY0JL6+gTslpIG90Y9PZxx9ZoBqQKzuWs1+rDmyZ6HhFCbRSBL0Wa
	U9OGmEaIdljA8CblePnaVipB3he8uoL+9SMAFoZBeJcsABzOkVaKKkucr6W1lyoF
	t6bcvgEOEwxBxn3BVaUmfoG0WVjl0XoNA2vbl4EKB5gfhzB5S6/zTWgoEcKON3Ue
	Goxz9iMd+kvyGMWK9iBJ/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791448580; x=
	1791534980; bh=mCHyS9olUnY05XSWa6FUiNxGv+xmoXLVDqzJnsn/DVA=; b=U
	PEZyS7Yzl557mt8BnMin63IuR+8y0OyZOZ4Rko1Bb+9glMFEWNjTbXnqsBixgOil
	BpUinR4n0nnXp3bMFBFBi6+gKsywPlCJpVxKLJdfr+IqD1eXRor2235g/2Vrp3nb
	cLBvyEDulwfd5SwXc5UxjoXQdazs66KNpE01Vn6Soq2wbT/YF0WS2I0P/dTVgLAY
	vowz2P66hTE1N2FbY5uX6aarHhWwRYyxuSReqqaPVaJj0gsyh55v+gNf7XVxx49F
	4XrddW+zJlbQsiKugIv1Vh4DzUdXzS641zZQE6z/mYjKDgpZCToOxMpTl4wWBw5h
	v27waBMGs0jIUMYsSfEbg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791448580; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vrvVt6aWyVS3iKmrUa6/9FFd0QIqBLDaw9atS5bHdF77n8M
	zQb3joSi+UXTffZnd5vwDyTpOM7vVCjw3dIw7fNE5iTAtraDfMkNTmQWBklx2fSH
	ivZ5YVewKg8vi0GTOtiX1JldfoTbzwWFR1M9PnV2WJB/uq3fcN+Ax0jJiW7KEZdJ
	DZyJVKnbaOdcKtQ+J2292P2WVT3O1BHqDonV7v4B5i+R0S1SZSHLVYRWPf7Yt4O3
	icYdTgMffY0ecd1i0JHOzRk9XVZFWJms1xU8TyBU6bn6/+Z/hzJ7la/+kXj/7DzW
	spe3mdEMRnzUZHzd5sWxHYAVSz3QAkUIbd564uA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:HKOwOIGyfd1xEQcJz1kGUNtUTjDTQNTvPWe3zLMFCO4=:b8H7hEQC6of4ikOU3o4f0X0vQQU/ow+vwzorl8OSUoY=;
X-ME-Sender: <xms:BFbHahb3oMyVio1HQQlSTj1seJN8XAqx3O7m6qwl_If0ZmsvBqme9A>
    <xme:BFbHauaXYnPh9MPese0RjQrY2-rKjOLVl7dXyae-B1tE-WcaXsdQIyslJZfw0KVGi
    PMveGH-nnfhjF7yGQfwBimtwYUsHQpdeUw5NiJB2hbUjw1e34vFAmY>
X-ME-Received: <xmr:BFbHahlHxGXcMFOe7_2FJiJWMKR4BXBmhEnYxczZiCqsclOtw4rdrw>
X-ME-Proxy-Cause: dmFkZTGTrBFKl8Y2D728a6iHluzdbQuClsZJrd0NvUJl/r6aTED1ekGkS+lTIgah9AM/RC
    XXqQZO3rKxKtgp/ow35kMpuPzpMxleBx4D6Md1g4fLMSmK6McoeoO85W2idnzSkPwg6LLG
    k6WgF0EuWvlfBJtWoMBu8t5FtKqdId600Ld1bcgoiAaVpLbMriJIx+tZY/vOaSJjIWvhab
    kUk/5kmIsR/r+o8ZpLrcaLQUs+7UpxyjziarEpXIgTRuSc8yXiN23HTk7CZJd3CvmVxWIK
    NQbXjgwnjv/oQMjXA3NIad6nTLt4378hsZpcRU5JLJJwT9R280Rh9egURr0HAQlDQrDca2
    JkGacwnyLOFSyHS92iDX2+Vg7BqV3wBfVdNM/13NI6cbmsD4BdWL/XAYWx4SAzYLJ193bX
    xBTXcV2iRAPNrclgs26Lk0lflDMA34jzXCs9oQH/eNSFub2RVEwq4hB58QOsiGorLYDH5+
    RjKuJH0nxY9X+cateCQWvM7aohluzDCnEULNpYt4LFzGZzB1cXEjxgJvakDLKruJZSAaqF
    J7DLOR5fgIBK+TwCdYiUc82SSrFfdl/F0KC4R/DKKDfqNPj8c0fitpppzvlOIQ3DL8kvSu
    B9IR5AXuRRcS3aX/kzj+eprt5YwZjm245QwY9DlqyLO1slZqW54JthN3IPdQ
X-ME-Proxy: <xmx:BFbHaqwEWQ1fCGFR6YVA4LFcB6UG-i2bQnZ_NfGuzy42x0LS4aMxLw>
    <xmx:BFbHavMCcAnEKYZrmtV3QfEV3JnLUavL3Jvow-lXKSZYjZVTXXsrpw>
    <xmx:BFbHauR-87a1_Ngy7wZI82Uzj-5-pWHCr7mKCA8CXTwDTkNlSqONvg>
    <xmx:BFbHataRcjdo23iRtUz8nuofEi1Iv_Pi-knXkGleb5-BP-rFpEJFOA>
    <xmx:BFbHanLzZroM2k0rvE-2WpRybdtQGmRDnrMNk7RG0Xebjd6iAub4OvUC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 04:36:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fb02b50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 08:36:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 10:35:55 +0200
Subject: [PATCH v2 05/13] odb: refactor `odb_find_source()` to yield dirs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-odb-move-alternates-v2-5-b47e8189baa5@pks.im>
References: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
In-Reply-To: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Similar as in the preceding commit, `odb_find_source()` can be used to
yield a single source by its object directory. This function is also
specific to the "files" backend once alternates are an implementation
detail thereof.

Refactor it to be specific to the "files" backend and return an `struct
odb_files_dir` to prepare for moving alternates into the "files" source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c     | 26 ++++++++++++++++----------
 builtin/multi-pack-index.c | 42 +++++++++++++++++++++---------------------
 odb.c                      | 26 --------------------------
 odb.h                      |  9 ---------
 odb/source-files.c         | 26 ++++++++++++++++++++++++++
 odb/source-files.h         |  6 ++++++
 t/helper/test-read-midx.c  |  8 ++++----
 7 files changed, 73 insertions(+), 70 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index a986f08a94..ff244c866f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,6 +9,7 @@
 #include "commit-graph.h"
 #include "odb.h"
 #include "odb/source.h"
+#include "odb/source-files.h"
 #include "progress.h"
 #include "replace-object.h"
 #include "strbuf.h"
@@ -68,7 +69,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 			struct repository *repo UNUSED)
 {
 	struct commit_graph *graph = NULL;
-	struct odb_source *source = NULL;
+	struct odb_files_dir *dir = NULL;
 	char *graph_name;
 	char *chain_name;
 	enum { OPENED_NONE, OPENED_GRAPH, OPENED_CHAIN } opened = OPENED_NONE;
@@ -103,9 +104,12 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-	source = odb_find_source_or_die(the_repository->objects, opts.obj_dir);
-	graph_name = get_commit_graph_filename(source->path);
-	chain_name = get_commit_graph_chain_filename(source->path);
+	dir = odb_source_files_find_dir(the_repository->objects, opts.obj_dir);
+	if (!dir)
+		die(_("could not find object directory matching %s"), opts.obj_dir);
+
+	graph_name = get_commit_graph_filename(dir->abspath);
+	chain_name = get_commit_graph_chain_filename(dir->abspath);
 	if (open_commit_graph(graph_name, &fd, &st))
 		opened = OPENED_GRAPH;
 	else if (errno != ENOENT)
@@ -123,7 +127,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opened == OPENED_NONE)
 		return 0;
 	else if (opened == OPENED_GRAPH)
-		graph = load_commit_graph_one_fd_st(the_repository, source->path, fd, &st);
+		graph = load_commit_graph_one_fd_st(the_repository, dir->abspath, fd, &st);
 	else
 		graph = load_commit_graph_chain_fd_st(the_repository->objects, fd, &st,
 						      &incomplete_chain);
@@ -226,7 +230,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 	struct oidset commits = OIDSET_INIT;
-	struct odb_source *source = NULL;
+	struct odb_files_dir *dir = NULL;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
 	struct progress *progress = NULL;
@@ -294,10 +298,12 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	source = odb_find_source_or_die(the_repository->objects, opts.obj_dir);
+	dir = odb_source_files_find_dir(the_repository->objects, opts.obj_dir);
+	if (!dir)
+		die(_("could not find object directory matching %s"), opts.obj_dir);
 
 	if (opts.reachable) {
-		if (write_commit_graph_reachable(the_repository, source->path, flags, &write_opts))
+		if (write_commit_graph_reachable(the_repository, dir->abspath, flags, &write_opts))
 			result = 1;
 		goto cleanup;
 	}
@@ -306,7 +312,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 		struct strbuf packname = STRBUF_INIT;
 		size_t dirlen;
 
-		strbuf_addf(&packname, "%s/pack/", source->path);
+		strbuf_addf(&packname, "%s/pack/", dir->abspath);
 		dirlen = packname.len;
 
 		while (strbuf_getline(&buf, stdin) != EOF) {
@@ -334,7 +340,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 		stop_progress(&progress);
 	}
 
-	if (write_commit_graph(the_repository, source->path,
+	if (write_commit_graph(the_repository, dir->abspath,
 			       opts.stdin_packs ? &pack_indexes : NULL,
 			       opts.stdin_commits ? &commits : NULL,
 			       flags,
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index a170ec80b9..fc8b494996 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -86,13 +86,13 @@ static int parse_object_dir(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static struct odb_source_files *handle_object_dir_option(struct repository *repo)
+static struct odb_source_packed *handle_object_dir_option(struct repository *repo)
 {
-	struct odb_source *source = odb_find_source(repo->objects, opts.object_dir);
-	if (!source)
+	struct odb_files_dir *dir = odb_source_files_find_dir(repo->objects, opts.object_dir);
+	if (!dir)
 		die(_("object directory is not an alternate of the current repository: '%s'"),
 		    opts.object_dir);
-	return odb_source_files_downcast(source);
+	return dir->packed;
 }
 
 static struct option common_opts[] = {
@@ -169,7 +169,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			     N_("refs snapshot for selecting bitmap commits")),
 		OPT_END(),
 	};
-	struct odb_source_files *source;
+	struct odb_source_packed *packed_source;
 	int ret;
 
 	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
@@ -204,7 +204,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 				   options);
 	}
 
-	source = handle_object_dir_option(repo);
+	packed_source = handle_object_dir_option(repo);
 
 	FREE_AND_NULL(options);
 
@@ -213,7 +213,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 		read_packs_from_stdin(&packs);
 
-		ret = write_midx_file_only(source->dirs->packed, &packs,
+		ret = write_midx_file_only(packed_source, &packs,
 					   opts.preferred_pack,
 					   opts.refs_snapshot,
 					   opts.incremental_base, opts.flags);
@@ -225,7 +225,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 	}
 
-	ret = write_midx_file(source->dirs->packed, opts.preferred_pack,
+	ret = write_midx_file(packed_source, opts.preferred_pack,
 			      opts.refs_snapshot, opts.flags);
 
 	free(opts.refs_snapshot);
@@ -239,7 +239,7 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 	struct multi_pack_index *m, *cur;
 	struct multi_pack_index *from_midx = NULL;
 	struct multi_pack_index *to_midx = NULL;
-	struct odb_source_files *source;
+	struct odb_source_packed *packed_source;
 	int ret;
 
 	struct option *options;
@@ -280,11 +280,11 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 				   options);
 	}
 
-	source = handle_object_dir_option(the_repository);
+	packed_source = handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
 
-	m = get_multi_pack_index(source->dirs->packed);
+	m = get_multi_pack_index(packed_source);
 
 	for (cur = m; cur && !(from_midx && to_midx); cur = cur->base_midx) {
 		const char *midx_csum = midx_get_checksum_hex(cur);
@@ -307,7 +307,7 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 			die(_("MIDX %s must be an ancestor of %s"), argv[0], argv[1]);
 	}
 
-	ret = write_midx_file_compact(source->dirs->packed, from_midx, to_midx,
+	ret = write_midx_file_compact(packed_source, from_midx, to_midx,
 				      opts.incremental_base, opts.flags);
 
 	return ret;
@@ -321,7 +321,7 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_verify_options[] = {
 		OPT_END(),
 	};
-	struct odb_source_files *source;
+	struct odb_source_packed *packed_source;
 
 	options = add_common_options(builtin_multi_pack_index_verify_options);
 
@@ -335,11 +335,11 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_verify_usage,
 				   options);
-	source = handle_object_dir_option(the_repository);
+	packed_source = handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
 
-	return verify_midx_file(source->dirs->packed, opts.flags);
+	return verify_midx_file(packed_source, opts.flags);
 }
 
 static int cmd_multi_pack_index_expire(int argc, const char **argv,
@@ -350,7 +350,7 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_expire_options[] = {
 		OPT_END(),
 	};
-	struct odb_source_files *source;
+	struct odb_source_packed *packed_source;
 
 	options = add_common_options(builtin_multi_pack_index_expire_options);
 
@@ -364,11 +364,11 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_expire_usage,
 				   options);
-	source = handle_object_dir_option(the_repository);
+	packed_source = handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
 
-	return expire_midx_packs(source->dirs->packed, opts.flags);
+	return expire_midx_packs(packed_source, opts.flags);
 }
 
 static int cmd_multi_pack_index_repack(int argc, const char **argv,
@@ -381,7 +381,7 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
 		OPT_END(),
 	};
-	struct odb_source_files *source;
+	struct odb_source_packed *packed_source;
 
 	options = add_common_options(builtin_multi_pack_index_repack_options);
 
@@ -396,11 +396,11 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_repack_usage,
 				   options);
-	source = handle_object_dir_option(the_repository);
+	packed_source = handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
 
-	return midx_repack(source->dirs->packed, (size_t)opts.batch_size, opts.flags);
+	return midx_repack(packed_source, (size_t)opts.batch_size, opts.flags);
 }
 
 int cmd_multi_pack_index(int argc,
diff --git a/odb.c b/odb.c
index 9b70859c23..1dc8647159 100644
--- a/odb.c
+++ b/odb.c
@@ -348,32 +348,6 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }
 
-struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir)
-{
-	struct odb_source *source;
-	char *obj_dir_real = real_pathdup(obj_dir, 1);
-	struct strbuf odb_path_real = STRBUF_INIT;
-
-	for (source = odb->sources; source; source = source->next) {
-		strbuf_realpath(&odb_path_real, source->path, 1);
-		if (!strcmp(obj_dir_real, odb_path_real.buf))
-			break;
-	}
-
-	free(obj_dir_real);
-	strbuf_release(&odb_path_real);
-
-	return source;
-}
-
-struct odb_source *odb_find_source_or_die(struct object_database *odb, const char *obj_dir)
-{
-	struct odb_source *source = odb_find_source(odb, obj_dir);
-	if (!source)
-		die(_("could not find object directory matching %s"), obj_dir);
-	return source;
-}
-
 static void fill_alternate_refs_command(struct repository *repo,
 					struct child_process *cmd,
 					const char *repo_path)
diff --git a/odb.h b/odb.h
index 3715351bb3..5c86572b5d 100644
--- a/odb.h
+++ b/odb.h
@@ -226,15 +226,6 @@ struct odb_fsck_options {
  */
 int odb_fsck(struct object_database *odb, struct odb_fsck_options *opts);
 
-/*
- * Find source by its object directory path. Returns a `NULL` pointer in case
- * the source could not be found.
- */
-struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir);
-
-/* Same as `odb_find_source()`, but dies in case the source doesn't exist. */
-struct odb_source *odb_find_source_or_die(struct object_database *odb, const char *obj_dir);
-
 /*
  * Replace the current writable object directory with the specified temporary
  * object directory and return the newly installed primary source. The former
diff --git a/odb/source-files.c b/odb/source-files.c
index 1f4cedaffa..e5e43b1543 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -967,6 +967,32 @@ static int odb_source_files_fsck(struct odb_source *source,
 	return ret;
 }
 
+struct odb_files_dir *odb_source_files_find_dir(struct object_database *odb, const char *obj_dir)
+{
+	char *obj_dir_real = real_pathdup(obj_dir, 1);
+	struct strbuf odb_path_real = STRBUF_INIT;
+	struct odb_files_dir *dir = NULL;
+	struct odb_source *source;
+
+	for (source = odb->sources; source; source = source->next) {
+		struct odb_source_files *files;
+
+		if (source->type != ODB_SOURCE_FILES)
+			continue;
+		files = odb_source_files_downcast(source);
+
+		strbuf_realpath(&odb_path_real, files->dirs->abspath, 1);
+		if (!strcmp(obj_dir_real, odb_path_real.buf)) {
+			dir = files->dirs;
+			break;
+		}
+	}
+
+	free(obj_dir_real);
+	strbuf_release(&odb_path_real);
+	return dir;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
diff --git a/odb/source-files.h b/odb/source-files.h
index 7f465853b1..77f4d842e0 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -72,4 +72,10 @@ static inline struct odb_source_files *odb_source_files_downcast(struct odb_sour
 	return container_of(source, struct odb_source_files, base);
 }
 
+/*
+ * Find "files" directory by its object directory path. Returns a `NULL`
+ * pointer in case the object directory could not be found.
+ */
+struct odb_files_dir *odb_source_files_find_dir(struct object_database *odb, const char *obj_dir);
+
 #endif
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 3f4bafff61..88a79fdfc8 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -16,13 +16,13 @@ static struct multi_pack_index *setup_midx(const char *object_dir,
 					   struct odb_source_packed **out)
 {
 	struct odb_source_packed *packed;
-	struct odb_source *source;
+	struct odb_files_dir *dir;
 
 	setup_git_directory(the_repository);
 
-	source = odb_find_source(the_repository->objects, object_dir);
-	if (source) {
-		packed = odb_source_files_downcast(source)->dirs->packed;
+	dir = odb_source_files_find_dir(the_repository->objects, object_dir);
+	if (dir) {
+		packed = dir->packed;
 	} else {
 		packed = odb_source_packed_new(the_repository->objects,
 					       object_dir, false);

-- 
2.56.0.406.ga2d225a756.dirty

