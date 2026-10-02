Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF98477291
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935724; cv=none; b=meG/OXCMdwQE7ytgml8vvmQWo9SeYQLZsD0YXGcUpHEw6UYqBKuZuix3TMtZacaGHVlBzf9m3VIjZUMTBKTRSO70Zn4UJw3HVMwO7MaSM9JmbI1vXQXi/8zvUiwqQCPFTMXiOmTLo3A4sMtc08fWwBl3lazsPRORZPVGuYPbUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935724; c=relaxed/simple;
	bh=v+Tn9ntKXkUCBfvvvUnuaKo3I4/8zEaUcUkxJjdg2bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQqFJ4H0GHiMNa26Y7A91bsFbpnwBivT3GhSFAuALJiZdsz1/HbpL3HvrmX53n6lZjZ9/3mTpq8G+g2iJhY5fw8aWpCT8TOhRKLkmwSqilx2sNNXAmj05N6a3T6r41MA4fmrWJlJOeVlm745LsWJWOHE4z2hmWiCM/zeFIKNj6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rYA6qLve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iAqVXgy5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rYA6qLve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iAqVXgy5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 49E94140013E
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:08:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 06:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790935721;
	 x=1791022121; bh=VSBGRqQbjZtIAkBFRcJPh1lepQtKFFEu+d42msftljA=; b=
	rYA6qLvevtUQJNDkVXvkqHC0SiXO7iAWAz/RWtrXqV5WL/gWJdsTNgGeqpGJcWV9
	ym8WIlJ9Ugnt8hgRDUk78zrd4REpO431xsoL02IF6UkgzPdSydzWZczoDmURBQHu
	Cbrz537Erm5INnCI9aBWQ4OF3qXru9d7wkzkrdia8lfcIr8GdCU6BEtgeOc/Fttv
	8QGuH9XC7Kupvt6ZNrihpXduj9fKbZkwrW/SnksZJMcXlTpWf5cYhZVedypbbcP2
	Cm2fYVdNvdPK1mspYua2mLmDYtX0/XIUWcDmXGRImenzMgzXTry7a1ZScOFYkVaE
	IzvxmAg7tF9gX0nNKHC3Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790935721; x=
	1791022121; bh=VSBGRqQbjZtIAkBFRcJPh1lepQtKFFEu+d42msftljA=; b=i
	AqVXgy5KyLsXrem7X3Z/miDTRRy3T0aMXm5/aFZgJ7CqbSOKRjjzZPJ7et1vU+wN
	hAGtwpEmqexHSOdOnSbJ8hPJD4Fztusc0+XUHDiYrdIkmI99y8HN0A+ZMyEteofM
	YdbyU54uXxHL4qW5+5Hh81Ot9tKltPui7xx+qM46HXTswE/XoYrLfIeoBsVnYQn9
	saf7VzUP6ydzMuJMlVKWveMwGIaeTxtpw3x1V9ERRL6/zOYuY8BqMFBdbt5NrER0
	a9fTI4EV18JJwvpRmzFUG3YaZi3qr4OmAx/ydMSZBLFnfgxnh3y64KOSJdUyAcAP
	+0RMkWTwdGV6IoIuD9FfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935721; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:POVnWrYYmwPd/o0FfNJLDfAjsl52/WbsfDQ6jQm2zGkX+T2
	FP++hhJhZzg4mf/AmtUzOJiknVejPweBwIKEmyYXyvmkf6qhHaovyLGChjUJ3ET2
	ISD4bI/KaICr6H3W8Dd7LybtBk2ujWfVhaDB7uJFiFSgMBLg1rmf+8eNfZ/Xh3Ja
	0Gf8HgcdXciKrCt5ocDFOMermZ6gbnVKDsTzAc1fmA/M+hCwMIc3ndtayi+WHo2B
	LuyHAu3XLZblfUBNkjLm8PhWgPhQy88OMTzAjN1JeYsUGu88qyBGBrGC+jouH/rc
	7keozRdwZ+3V9lL4YHNZ9P4sfYIVRZJVRqu3ZQA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OQpDhYw6SIHSmEGb4kz0QV94VzRe5bPSjc/z7ksuuGA=:v+Tn9ntKXkUCBfvvvUnuaKo3I4/8zEaUcUkxJjdg2bw=;
X-ME-Sender: <xms:qYK_amso2ZYJqgyGLgJq8iYq0VGJhwzjb4GCQt8dHdjmNkzhzzMkSg>
    <xme:qYK_aiZsCghoAHmVrPs-JU-hexqJo4SKh2kzbSvtZXfBQqN-a3RGBWdQCPZv-IGhQ
    d_Gc6Sjsb-BOt6-t6LDtp01KUiiF16Jn2Bzw36iG-Mm27KMCTpqDdE>
X-ME-Received: <xmr:qYK_anabxOwuXahXvMTb2_v1O8LN2Lb9sbKwFtv5vQ42RqiugAMcgw>
X-ME-Proxy-Cause: dmFkZTF34l82022tRH/XgLve1GnCAagsK1/sNQ03J1wZMCaKRfCFCANyInDwpxNlKo26XL
    EXnDaIhvf6eeyj8SFpLxHe7kMLyAMTddf/VH/Rk//b+JdUzKpEnqhJ/mj6T6WBc3r6ZJE/
    Hr1v675783mYwdLtIr+rwnhjt9V2Sg0kW0Y2Oh+akYz5iWsSjkq3O4mWIO7qqzL2LqWlBu
    4qb3Nz76srjHiKLX7WGKMZWL03bhjvTx5w07iAecZ2+wGDzrZnOrFMya6obWUIWKlk9RXi
    ATp2I5KNGIOri6x7B1ZipZsHWqVLLL4aev/pKUNaysgOv1nDj7mFcdqRSD+T2EP7frLRS1
    /H9ZxIJZI64PHpJTBBfcsCNAH7PJIR6iOU83OVHj3hOTBAjwv8MAztuR3CD2gxtnmko45F
    dcMtDqFnXU5Pz0D+yChCDvpmeNFx3wLB+QcSJ9Z5eiWnHsMJiFpskVOLlSyJfIZX9saUMV
    03zde0CLqGHK8UToQw7xw7jeXN2nkVrBZjEBkbwZpqKkmVNQK/Y10RvoDGKaenKNMZ9hqU
    ZuCIMD1egqrNbsvFXE10SSwn+8mhqPnUaFxE+gD6DtOW0kTXpdjZcVBHGuZR1t9G3dkKIU
    /QNDjh9LLqlRkKXCBcr1R8eluZLDcg9/HmeISEGGyrlH7Wi8Xhyia06RfT/Q
X-ME-Proxy: <xmx:qYK_amW2n4DfiLJGG1CFQ6IYIRXaCTrnU7VNoUQPokr89URIJyZcxA>
    <xmx:qYK_am1cIJ7y-M2I2a2tEsVbmpHhZFGdDeuzn6aSyKdQd66fuj3-Nw>
    <xmx:qYK_alY1-OJXQP7Vv0dlIoienoAsJHuYx1YVw05zDUq2KELVNNkFlg>
    <xmx:qYK_ahoD4XGYPi-6rZKm7RHNAtDwrQj8pCBoNWQr78tQiviypILJmg>
    <xmx:qYK_ahdpss8aoemqlM7HXNefY8RZ9ABv3Ex7fjtK5-PM9DMVubFG_Vep>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:08:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1ecabee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:08:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 12:08:16 +0200
Subject: [PATCH 05/13] odb: refactor `odb_find_source()` to yield dirs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-odb-move-alternates-v1-5-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.56.0.379.gc618271300.dirty

