Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375171F4CB8
	for <git@vger.kernel.org>; Wed, 14 May 2025 05:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199557; cv=none; b=JFAkqp7ixqufcaPpQnuRw5jj7tKqAhJ1MFvJnR+Gr+z52kqXLXpHOYsMDrgyQ6UF8zINOILguQFPZ8qOQZH9B7dcwvxdq/UGFXpibtwlUrPTHcdeyyCZBi7syCnxzTc5Mf7MjCGNzQNoWGDY94XhEq1Fv3iEMuvyQYopmwp2J4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199557; c=relaxed/simple;
	bh=1BEQyTRoNtQjAfGIRkkz1qEAL9KLCXrlw5VMIswHVzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0KsD+5cMv3RHBh4Z/M0xyQUXY+9AYY+VjJ2lA+O2nC3Z8C3XMSrUZ2u3SNha2r8w+wxWF7cDzZUhq3zFcRpQ7jRa4Wj+KJRaGOJIVLehvn2T5TT2hGUC6+l6vrJiVz/+Tr6+IEYf6BRw6ImGKPhDHm+S7fwzhlapbVdUmXBYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PZ/I3VGy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mtB4bF+P; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PZ/I3VGy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mtB4bF+P"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 059EA1140137;
	Wed, 14 May 2025 01:12:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 01:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747199554;
	 x=1747285954; bh=aUYlJCpRnC99rp/i+GwqLZNGoz0AT3FazMwuEdnmTJ8=; b=
	PZ/I3VGy0ICsv4Stsc+fVnC+apYiYxLTLxl91jGgNUsiM5oen+X/YxFAlYnoloNP
	YxlNApbXScse/QBmvd9NGsp7KLDrD6Q8CwUaSEwuHfEpLN3HLMDQEVU2snNspcev
	DAEEEdT3YEVez0LoIo4IegiDTHFgdLTPXMLWK+WV7x88GPDBJ4ZSbj7AfBsx/04H
	wCsSAVxI7nYUS9ZT+2Zgag1u7gwGaicfMNcu11ixKRrayP4Lokq9B9wB8pAyorg9
	npQMm+ppHx9S3A76cyI9H9SsC17XuUnLxTY51VWkGPrLc9h81AxBTEmTiZqD9alt
	0wmmoAjJZY52fk5QjC4wHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747199554; x=
	1747285954; bh=aUYlJCpRnC99rp/i+GwqLZNGoz0AT3FazMwuEdnmTJ8=; b=m
	tB4bF+PTKjA1U4z6xk+oopbMUc06XWe/S6gFVOzsRXnyKcWEda0uDRmPM95v7C9Z
	Bjv61SWUn1rKwTFdWIpWVERqHoC7np/tjh0kBSSZYGoUuZ5OHozXgQy2fgTGpjAd
	oKEcPtAUswji63RlShDv/ofVlpb/P6IgbyYGKwIC4DFgreqB2EYyjl0nvGRyQBoq
	zHDXXlWjRe4ISCXPbyvdzHEASw4di5Oc5MkSMd6CePLzwIqCVV6jcw7SkbSEPLpe
	OxO8ro15WpYFAbek32SGOPS3OC7xIEBM1ptAP1GCGLfJHXRtZf7YGzUENmtc5Gdm
	1VKcSZXznfd5jb/GV1vpA==
X-ME-Sender: <xms:QSYkaPJ903iaojjQC4K-PQ9MRW-1snasEplZ1igC828pPyvxiHw_fQ>
    <xme:QSYkaDIoQrQ2X2rU5CkL-FBYPOeIwtmxBfOhig67hsru8ckhejmlPMgkj82mAHfTQ
    kSWi9VYn6YanyC7ag>
X-ME-Received: <xmr:QSYkaHthwJGsHo3PZXpAE1miy9n4CgmGVqUztFXX9KSVm8xXYzn2_5WCpXWyadxmxh7BqwA7CasUWUskF5sF1sViHrRf_N5fyX4iZRltEt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepshhtohhlvggv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:QSYkaIZvxbJD4qjBO1SMFIOIRUh_WC_3PWjKneGzO8KRTsp-bja3Zw>
    <xmx:QSYkaGakDsClwDSZ3b_W_p-WOnv46uYrEpxsKv5GD92lJI0v5S8Wvw>
    <xmx:QSYkaMA_3nD8rqT_eeUmP6aqX6mkMcTJ4nSOhbSGQgPQ9KkKlvIsCg>
    <xmx:QSYkaEY2hXOd0KaBOF1ZYCZfLpv3V8tI-6b5sxvSkcq5bJBF9UEU5A>
    <xmx:QSYkaBeVkqvXcwraBYEf7n0X_VkOZVGRqBejsA3Deb6QNp3AKE4o3JPh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 01:12:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 04600555 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 05:12:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 May 2025 07:12:28 +0200
Subject: [PATCH v3 05/17] odb: get rid of `the_repository` in `find_odb()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-pks-object-store-wo-the-repository-v3-5-47df1d4ead22@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Get rid of our dependency on `the_repository` in `find_odb()` by passing
in the object database in which we want to search for the alternate and
adjusting all callers.

Rename the function to `odb_find_alternate()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 4 ++--
 midx-write.c           | 2 +-
 odb.c                  | 6 +++---
 odb.h                  | 7 ++++++-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index ae8ac52a975..90c767797e2 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -101,7 +101,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-	alternate = find_odb(the_repository, opts.obj_dir);
+	alternate = odb_find_alternate(the_repository->objects, opts.obj_dir);
 	graph_name = get_commit_graph_filename(alternate);
 	chain_name = get_commit_graph_chain_filename(alternate);
 	if (open_commit_graph(graph_name, &fd, &st))
@@ -289,7 +289,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	alternate = find_odb(the_repository, opts.obj_dir);
+	alternate = odb_find_alternate(the_repository->objects, opts.obj_dir);
 
 	if (opts.reachable) {
 		if (write_commit_graph_reachable(alternate, flags, &write_opts))
diff --git a/midx-write.c b/midx-write.c
index dd3b3070e55..dd65800e8b3 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -922,7 +922,7 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 	struct strbuf cur_path_real = STRBUF_INIT;
 
 	/* Ensure the given object_dir is local, or a known alternate. */
-	find_odb(r, obj_dir_real);
+	odb_find_alternate(r->objects, obj_dir_real);
 
 	for (cur = get_multi_pack_index(r); cur; cur = cur->next) {
 		strbuf_realpath(&cur_path_real, cur->object_dir, 1);
diff --git a/odb.c b/odb.c
index 2b36735087e..621a16b35ea 100644
--- a/odb.c
+++ b/odb.c
@@ -448,14 +448,14 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }
 
-struct odb_alternate *find_odb(struct repository *r, const char *obj_dir)
+struct odb_alternate *odb_find_alternate(struct object_database *odb, const char *obj_dir)
 {
 	struct odb_alternate *alternate;
 	char *obj_dir_real = real_pathdup(obj_dir, 1);
 	struct strbuf odb_path_real = STRBUF_INIT;
 
-	prepare_alt_odb(r);
-	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
+	prepare_alt_odb(odb->repo);
+	for (alternate = odb->alternates; alternate; alternate = alternate->next) {
 		strbuf_realpath(&odb_path_real, alternate->path, 1);
 		if (!strcmp(obj_dir_real, odb_path_real.buf))
 			break;
diff --git a/odb.h b/odb.h
index 1d1ab8e8bf2..5c5ce4653eb 100644
--- a/odb.h
+++ b/odb.h
@@ -61,7 +61,6 @@ struct odb_alternate {
 void prepare_alt_odb(struct repository *r);
 int has_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
-struct odb_alternate *find_odb(struct repository *r, const char *obj_dir);
 typedef int alt_odb_fn(struct odb_alternate *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
 typedef void alternate_ref_fn(const struct object_id *oid, void *);
@@ -188,6 +187,12 @@ struct object_database {
 struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
+/*
+ * Find backend by its object directory path. Dies in case the object directory
+ * couldn't be found.
+ */
+struct odb_alternate *odb_find_alternate(struct object_database *odb, const char *obj_dir);
+
 /*
  * Create a temporary file rooted in the object database directory, or
  * die on failure. The filename is taken from "pattern", which should have the

-- 
2.49.0.1141.g47af616452.dirty

