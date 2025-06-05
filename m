Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED11FC0EA
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106026; cv=none; b=ISOulVjKzGxNj/uu9ejFosrcVCGfbSkBSWn1qh1A36iaWQLSyREe/mqyEkjNHpWfgDVDVb95+yz9YNqhwFWAh+rM2k4aV6cBzhMH5vxpFD+5d/iMlm93bR2qMheLwt5LuOmm0oFxGovo5p9aOMQZtAyaWoSfO+rEUDyh3rTirEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106026; c=relaxed/simple;
	bh=ykUe5FcFS6xEUfKgJkbaSNHnvbk7Z7TOvlHCGXMReG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWwusG8MeQjyYYt+Fn7m2BjfF7pBHQYdptJHn/sUlbmKjHSHvxj/LXpOTXmDfltcOBrhtUlcpkrYPmS18u1vnubNcxM8TO9eX8MvVzLRqLsH5VQtAv48X9Tt7gSAjRjrasK41JKpJiy3SSt7+wCgWkr3TviYYeJ6c83nh6Lo5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KbZERaaD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nBXobliZ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KbZERaaD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nBXobliZ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 102AC11400D4;
	Thu,  5 Jun 2025 02:47:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 05 Jun 2025 02:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106023;
	 x=1749192423; bh=24ZnGGl7URA0RcUBPlKO/BwYCcrHbURm9NZIVmJph2A=; b=
	KbZERaaDDuct4dtRczxAOUsVLMs7RSWubejF+4ae2De5hbGyFSLXdmpqGukejNPf
	IoeoWmFh2/6QHsJJ9Ngr93CtEC6q5LZdCPkUgJlDW7k0YLn/z9NvrqtcMO74SwN2
	OgN8VZ42dB5KtFGjlp6q/AECt/ZuIBZQAqvDto1pVYT9dBTFX78Uezo3fPF9ZmoV
	nQMNgZM7o+zo3herKCuWgGuLQaxPyQRgcRTOXwER2RuMP60dNYkUPKZZmbQahn7K
	yzqf+IXCjWOCThjgYnDZHWtZYCjm5rm9z81OUpKxn6P9IXBZnYU7aUNCHTczi4XR
	Jf/QxRewFSJRKz4HF7Pkmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106023; x=
	1749192423; bh=24ZnGGl7URA0RcUBPlKO/BwYCcrHbURm9NZIVmJph2A=; b=n
	BXobliZyV1y1c64bMiLx1aICUCJxlk8HaCUIfPOpBSvBWjrYE7TCYNJN6rSrIBFM
	UMmVFS5PVr3EdCSByOnuj2kdz1yP38XFDLKUa18Hz1yKYAMvyzca2oinAS8nBitW
	P4IF4FyELmTNgJSVM77wMfGTVe47gMyNf2fYXzGtEZUyFPu57dYJfK1zm4ADsgJJ
	kfCuxVC35WoskPxNQgT93FduGuU6laFWCd4gtLpixulOn98exOYEYRJC4EFm+kMZ
	7vv3PQpzLbXF9tc/vPsoI6r/mPFsdg33+K9I+Tvl4gcCR90kp72CJvXXvvfGT5iF
	pZX6vjmQE+qYmFonF0pIA==
X-ME-Sender: <xms:Zz1BaJgnHYl-6R8DvajNpaPEb6e851xkQuIM72VbBaf8a2SKmfnicg>
    <xme:Zz1BaOCHEitQf8-Gr2tQ_1yltheo7up5VMPKtpjRBiEbBzXa2_WRReWt7Y0UCcAE5
    ylCCkeodcbq_M7-aQ>
X-ME-Received: <xmr:Zz1BaJFy13YsjcqjP1lS1yCiFkSFplkWGbcAkHh5vGSrPcf6vh72quiXfhqa-dAteJPOtcD0dIpx0ga7cmlBFcpzcZSTUQPtg1ts79k6rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Zz1BaOR5OctJoH7Y7gF-xXPY63gmtQK1ishwppgYdN7YyeePuWFRvw>
    <xmx:Zz1BaGyCb33raGSQrllQ9bTWJzPPYycNoYSJdAKLvXpumaEBpjkJjg>
    <xmx:Zz1BaE4sHvz_mV9geY6zGwAq7WTNql-43V_Ob1qR1jwz-sN1yvwymw>
    <xmx:Zz1BaLyCLGO2nkFRGmJVeAX4MYPgxAAUkmY5_Zob4aKhUY6WvxAXpA>
    <xmx:Zz1BaC7K1pcHVnEXlyvBInXkh20QrB3C2P2SjW06IcGbyvIPUGi5YBG_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:47:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8de89ee4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:47:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Jun 2025 08:46:55 +0200
Subject: [PATCH v5 05/17] odb: get rid of `the_repository` in `find_odb()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-5-779d1c28774b@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
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
index c3851e29668..941329c6943 100644
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
2.50.0.rc1.591.g9c95f17f64.dirty

