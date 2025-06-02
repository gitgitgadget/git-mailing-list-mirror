Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC621F8EFF
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860047; cv=none; b=libyEEb9ypBqC59ePY+iVIsqUNrNUafWKCp/xXg0ZAn/MUvJ5pCnJjlVy1wbG2vMKowxM5UUl+Dw9AZN5lBRcmQXt6WeVAEBTUI/qCxP2Odff30nIpkoSJc2faqi0JxiFQ6JryvAUwByBADOo4FxcHCl3CWeoPmt3nLLSOrE7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860047; c=relaxed/simple;
	bh=1z8ewkHIl3sCVlEvIb8FtSAKVvatxu0bdCihgJaFhL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUFYMcDEWF29jeV1Z1d9vu5EGgw1tZosp3Y+VQTGVK6agvKmLWJyB5bWpf8gZ0cn3OMfJzOuGZTnv9Da9gED74MLQ+hGLh46E8IRSTesDXXCIquvI1TikuUgu3y+gtCrDp6rV6s0hvOzapEAWS1yaepj9KoYNyPYXJ1tX7hzIs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H3YyKZK3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qgq0ekRW; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H3YyKZK3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qgq0ekRW"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 66D23254011F;
	Mon,  2 Jun 2025 06:27:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 02 Jun 2025 06:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748860044;
	 x=1748946444; bh=f6WbQu/IxNMbHHYbdNcU8LZOVSDJye+xpyvpqIl7H4A=; b=
	H3YyKZK3eIKfJzzQ86w/abfR5mdPBY1GP4/OTgexPY9v4hubHawonT6o/iWifcVG
	H0zEMREnZL6GVtGB3bAZzpmg2y++5Ap32gjMX6OIHyc1spjTU52F7Ld6DBECrqXr
	T/FZYyGue44ki0+XAHFFXvoFyCJzV9826em8H6Kn9GZYTz2M7XDwpn5SmQceECqo
	gI/JkJ0q5qGhE7kdfLuisRgBsVu4sGQX+MLY2YInoYSYVWq6fdYeuCpPHVp1GWRh
	ksAMZ8kb9ErfokZOw1KyPYuv8/bfG60Ia5/SIXYU/pkqjwNF9Zm2tOJD2TrJlSsm
	PR39PUy/BUjDp5YYUjHF2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748860044; x=
	1748946444; bh=f6WbQu/IxNMbHHYbdNcU8LZOVSDJye+xpyvpqIl7H4A=; b=Q
	gq0ekRWfmh+q8QnfLjCBMrcpS+Gk3LFi+hYwkT3vjf9ejhSwhF7rkNgmqcegz0T/
	B0/9l+jE5bwFFPQjGvtOq+DtLr4omke445NTd/hnErql3gmdYhpTIT5pQvf521op
	i9HV+f6VzN87k0wZNV+IbDgKLCuEmh3cpDH8fSQclBsxaubqT4+kJO70ELGRi0le
	kxk7/1tKJkmCa2m4gUz+m2MSD4NENrUEarmdCmEaTv6c5lNtUWtR36ScPditSDOY
	0yfrKH6g6jYQ7ZfVQXCBi7cFF4Y5Plb8B5NGssiEIprDzeFCDlpImBaEl/+sQKOo
	id0ra0vEIaFG2bXSw9k7w==
X-ME-Sender: <xms:jHw9aHJsKisV1Y3zx52z0OESBJmYN1YZnOial01hhjSv_LotsSVsAw>
    <xme:jHw9aLK0jJsSlUhoHtdwUriaZ3Fqe2IJSfh_YcL2X75Hqy9TzAxHTuImAdJlk5niF
    _7n8x7jB-hdFplfFQ>
X-ME-Received: <xmr:jHw9aPszuYzNjqv4cUDeQRfJt4kNjIzsatJdLTrl3Bc1EhI84oJCwB2U-uiNVlRRGYxtCeMoQu-3v13_CdPR8LAO_hlYaFFyDsCvPxH6SOnreQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeegfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghl
    rdgtohhm
X-ME-Proxy: <xmx:jHw9aAYQ1il6bU0592km8NbIz1Rg_YC-ylk5w4IiPLzHFCstPae4OA>
    <xmx:jHw9aOb6VVjGOFBPgzdPbfy9dppdPJE8K1i3cqPeC-jLdiUhGb3o0w>
    <xmx:jHw9aEAU9RyLxQB0hTM0xSBgMjS06Y5lpzAWoiiwN-O_nT87LJRM_A>
    <xmx:jHw9aMawKCLKpmZ-3_Uxj0JCSvCC7EbUf4jS9v5BfvWmjyJ75Wvyrw>
    <xmx:jHw9aDAd2UlWroke1sPiXi0m5X3bJd7sMNpC5WgwmXzzwA8rAyy0BITF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 06:27:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a17798c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 10:27:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 12:27:06 +0200
Subject: [PATCH v4 05/17] odb: get rid of `the_repository` in `find_odb()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-object-store-wo-the-repository-v4-5-e986804a7c62@pks.im>
References: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
In-Reply-To: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Get rid of our dependency on `the_repository` in `find_odb()` by passing
in the object database in which we want to search for the source and
adjusting all callers.

Rename the function to `odb_find_source()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 4 ++--
 midx-write.c           | 2 +-
 odb.c                  | 6 +++---
 odb.h                  | 7 ++++++-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f04eaba5259..77d7e88a98c 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -101,7 +101,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-	source = find_odb(the_repository, opts.obj_dir);
+	source = odb_find_source(the_repository->objects, opts.obj_dir);
 	graph_name = get_commit_graph_filename(source);
 	chain_name = get_commit_graph_chain_filename(source);
 	if (open_commit_graph(graph_name, &fd, &st))
@@ -289,7 +289,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	source = find_odb(the_repository, opts.obj_dir);
+	source = odb_find_source(the_repository->objects, opts.obj_dir);
 
 	if (opts.reachable) {
 		if (write_commit_graph_reachable(source, flags, &write_opts))
diff --git a/midx-write.c b/midx-write.c
index ba4a94950a8..f2cfb85476e 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -922,7 +922,7 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 	struct strbuf cur_path_real = STRBUF_INIT;
 
 	/* Ensure the given object_dir is local, or a known alternate. */
-	find_odb(r, obj_dir_real);
+	odb_find_source(r->objects, obj_dir_real);
 
 	for (cur = get_multi_pack_index(r); cur; cur = cur->next) {
 		strbuf_realpath(&cur_path_real, cur->object_dir, 1);
diff --git a/odb.c b/odb.c
index afb16f4c693..483b9b38414 100644
--- a/odb.c
+++ b/odb.c
@@ -448,14 +448,14 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }
 
-struct odb_source *find_odb(struct repository *r, const char *obj_dir)
+struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir)
 {
 	struct odb_source *source;
 	char *obj_dir_real = real_pathdup(obj_dir, 1);
 	struct strbuf odb_path_real = STRBUF_INIT;
 
-	prepare_alt_odb(r);
-	for (source = r->objects->sources; source; source = source->next) {
+	prepare_alt_odb(odb->repo);
+	for (source = odb->sources; source; source = source->next) {
 		strbuf_realpath(&odb_path_real, source->path, 1);
 		if (!strcmp(obj_dir_real, odb_path_real.buf))
 			break;
diff --git a/odb.h b/odb.h
index f1c903d103c..a9e802f5831 100644
--- a/odb.h
+++ b/odb.h
@@ -68,7 +68,6 @@ struct odb_source {
 void prepare_alt_odb(struct repository *r);
 int has_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
-struct odb_source *find_odb(struct repository *r, const char *obj_dir);
 typedef int alt_odb_fn(struct odb_source *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
 typedef void alternate_ref_fn(const struct object_id *oid, void *);
@@ -195,6 +194,12 @@ struct object_database {
 struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
+/*
+ * Find source by its object directory path. Dies in case the source couldn't
+ * be found.
+ */
+struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir);
+
 /*
  * Create a temporary file rooted in the object database directory, or
  * die on failure. The filename is taken from "pattern", which should have the

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

