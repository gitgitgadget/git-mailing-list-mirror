Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48598274644
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372560; cv=none; b=sABIZpXuNtphufTMLKF3Jw8xQyquod95B6krZ8wij/TXpV9I0em1KV/toylTJ/zKNsSrjuPDVG0zLHKw1/H2Fz52U/uDIZlYK8UCqejENIOemoAOqt8ICeJJrEd7Md160VZd4RvxztXm1X9OaLEZ+Maf9yvef42j440M85U2SGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372560; c=relaxed/simple;
	bh=B4IvBpcEWc8GFDrY8YkeDaUYkZQ8pLYhrR5u5Smcu1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5Fi/hUp5Kd9uZmbOiplDFVZPR2wYQlEn2Y7zkCHhIA4/EY7OluLWYVO9dkd8+Q0fBabrEugt9o9RoHnfWHnP2dM1ovaJsdgVZj4MVLTRA9BPo73mfosJGS+0M06sucITh+Yt+r7YAkqVF3M8pXbYO0N7xgSMCQ77y6Sh6Xuixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rETNRbXr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nu6CrcjG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rETNRbXr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nu6CrcjG"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 77B6FEC04E7;
	Tue,  1 Jul 2025 08:22:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 01 Jul 2025 08:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751372558;
	 x=1751458958; bh=x6V+a0nQhySauJXhE8w0O/qY1LVX852j8PxGPJ2Xp7o=; b=
	rETNRbXrOwdzJ5d87HSeXhGMkYLGW5kCNKtbYI1I37F9cCLVZ5HlxqeuTVFoPAJ/
	QKjW6wt4AqqIpe+gND+vdUD7FA0IWPqSSp9MCD821jHX8DGdZTvpCIQkuUR8rc/T
	ONUzEjWgN2VPzPTEo1YOgpsAxrakYg3JLg5FcsBafmm/79/M7/hfLzToUhH4OEu4
	Q5SRt0W/KAFycWpsDdz8YEdVxBWXHXTb/swewMfNJz5ObiVB6AjQe8h22O0CvmT2
	zhC/+IomlhKVPMtqePLb04+CUHkj/fyWixbR0rYrjcXAtIKmrSf/a5U7M1bZmg9k
	LYGfX5vlJHl7rBVRYTN9Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751372558; x=
	1751458958; bh=x6V+a0nQhySauJXhE8w0O/qY1LVX852j8PxGPJ2Xp7o=; b=N
	u6CrcjGhcCoRmojt7/AE67fZbzQCTNMWHurj+EkPT3BRr4r/uEKYcS0xIYbfLAfo
	KYdGpLA8KR5OlNqihEUMYLTL9IMcyBXg09qS12OEo5vtSpQFO/iPKaKfeIQvRQtT
	D17/jaDdMEpLV7VWkk6M3uD0gMHgJuQTOLuwNMH1lx1JgakNr1mPTD3ElhKCUqhf
	SoB/pwWwQ5WDGa7w+R+dYnQob4AxAOuL/wOD6GmsQ1hA2j/8Cekj1NDVDfWz6E2P
	EtllUUaxc0/N6WmxrhJBRnlKvFbNRfIy/Rpnsej46g5KLlmAZPVBNZq/584T/Rh5
	AHPObkWZzlo+BDvY+6jhw==
X-ME-Sender: <xms:DtNjaMcXVZMi7y57Q6iohc3_QKkAgUp9Q554fjIXuKhEcELIYjChIA>
    <xme:DtNjaOMFAvTrv2psr2q_h2Y4rXuJ-O7frzL-CICwUwfZLsTRBMQasDO1lc0rRS3Nl
    z-9VLt_D4ZrKNeaYQ>
X-ME-Received: <xmr:DtNjaNjLyvT-qrzwHHB3tAP0d5rxvfrpaV7djvUVt036MxuOyecmk637-8yFzIGEv30CoQcH8JDyNTOWiLG8uzwMILpmHvEkEG-TbZssoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DtNjaB9HgO0s5bYrSPWthV9xnwnCFC3w09pY7h__SthclVdBPCBvfA>
    <xmx:DtNjaIvmWw6Z14Sj_8fo1YiOXePHzcz87MWUtgTtGhu-nLermVctjA>
    <xmx:DtNjaIGnTEHym4wda2ldOD4quRXZZhOBzp_XjIuENA3T_utulGleHw>
    <xmx:DtNjaHPJqmfqpJsBd0TelYdR9ZusYma0p9PZM3L7rrv1YE8lJOxgJw>
    <xmx:DtNjaDkufn8FTsYFI39PaZUmUcJWbKyj6krBJQgRoj_AM7a8OhM3c12o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:22:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 879a86df (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:22:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Jul 2025 14:22:17 +0200
Subject: [PATCH v6 05/17] odb: get rid of `the_repository` in `find_odb()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-pks-object-store-wo-the-repository-v6-5-dbf3894ab4e2@pks.im>
References: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
In-Reply-To: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
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
index 0464d7f54a2..240fc62ca2b 100644
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
2.50.0.195.g74e6fc65d0.dirty

