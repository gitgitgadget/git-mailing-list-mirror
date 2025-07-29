Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AE81DC9A3
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798374; cv=none; b=C5RNJ2smBksMcJJ1C0FE3Fq2vlLNDifCSX5xI4hPReSk0P+++EDyJrluDV8zKCgGlbbLT1F21Pdfc6si/yMJ9n4vE3My9zOZy2mAlP5ybVq67JmBoG5c/3TCLYagH5RM5h1TL2+685xupvsN348Zk3RJ6mG0afiIPdozlJxAtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798374; c=relaxed/simple;
	bh=kIXPU+hcSZFHDhH8B8aMGIki4EEi5N1bgewbp/KmMY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQg1pD5enPZvypTnBL+CeKXZvI2nu78Xjqdqaos1TIdQ0xBwcX4galsUJxLWg+z1jzotsldZcyPl4cB79TsJVGUedpp6fXugFAXrtlOfMYSNWdb6pcp+nJ2uddDrg9Nep1bf6xZfPL8JAmag1aEox5A/YCVtD84MFR07V25FH/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TdhQhP6O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZNfg0omp; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TdhQhP6O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNfg0omp"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id EDE791D0011A;
	Tue, 29 Jul 2025 10:12:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 29 Jul 2025 10:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753798371;
	 x=1753884771; bh=v+JqB5fXrMY5emk2iw82B8BAE9vuAHGSV88yr8XyMXU=; b=
	TdhQhP6OgwxQ9CzgmflhN0qTQNWI/Vx3RtSiFgAn3shjGlLKGzN0u7LFjjwmrXmA
	pRIifYs9PoGIawRgf+qn0fSdGRQOGymAGcnBqEzYKCginLH3zKIOl+k1K92y+DCB
	R6j9zKhUuNqdhPQtXzcvVIllBht4z1jB5UnkD0xZ/EnHsANgifb0/iU6y7uM1leL
	Pwb+8rp03yRvjA+27xRohRBP3ECl8blaye44dZhynoTvDGFq5JZNheGaHiMhinmu
	1cDDyv1aCg9fli4+dOmAhF5YRO29mqIU0Ceoy6yK/eE4i++CK3BClZ4oU8sT61r1
	sK6PX77r7sXJlJqUyp5hDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753798371; x=
	1753884771; bh=v+JqB5fXrMY5emk2iw82B8BAE9vuAHGSV88yr8XyMXU=; b=Z
	Nfg0ompKQN9cX0PbNH8M5zmxk5UIJFmjChkehVL8OOUyptYUAJY2+IiwNA3zzf5m
	CsF0NUeHLQjmYBU/0QMhjOwtf1DvrSTNKNaYTu5ZpS/MZ6HHGdcxaT7LCNa1cfhw
	Uw7rRWJIfamrqkz/vYvppR6YYa8vtk66PorJxqZFSL3v3RVcQJ9YhpFP8wMRZI3W
	+lEppoGqolFWOGRtkwN/5HfMb4XqhGFbw1qzCvh+t/y/xJOerFhMW3yC0bi1J9hW
	p4uhk3OHFaW06V/hp/TniciyazWHYMTe18Ox+pqJJT6W7x4rlZOmTgC5MZLl+3lx
	ljEbJQUF/Q+O2Uk+dh5Vg==
X-ME-Sender: <xms:49aIaMFPvssSpekbzx7OiGQ4cI1_vJl7Q9_zrjfdF6TzN8TDDppNDw>
    <xme:49aIaFhR5NPa248d1XugH4OB63SaX72S6y487n46Eo5i_OVhW0G2N67N3i7PrSm_m
    qRGZvA4W4KynXSvDQ>
X-ME-Received: <xmr:49aIaH_7Rc7RIP8yk9F_4lWTIM4H3PaK73aifiRhaldbns842iLBz87mwvItiAbUp2oaEhkpGtp3uHnWTvFEulp1zVnHjnLflKcnIkkqOwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelhedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:49aIaMqsmpjY36oJ854eKVqS5l9g_HAl54o_jF1LKsBvZQfoYIDUoQ>
    <xmx:49aIaG_56AQ2bMB_dpBOCo0_WDlKPU1e_X7scUeNLkXn20mfHtDeLA>
    <xmx:49aIaAWhNHfndGwz8G81JTZyuLRt99Q277nzPJNXodzjMCa6q6_wEw>
    <xmx:49aIaMAEgYKthtrFONcshWZ8EzI4_l4D_014rNPQD9KqG2Ou3_daPQ>
    <xmx:49aIaNj2ckZ__g4EEUxGb65erXpGPBMu8jjLDVRtHUc5yGo8ZpmusCyT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 10:12:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a16d044 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 14:12:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 16:12:41 +0200
Subject: [PATCH 2/8] odb: allow `odb_find_source()` to fail
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-pks-midx-deduplicate-source-info-v1-2-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

When trying to locate a source for an unknown object directory we will
die right away. In subsequent patches we will add new callsites though
that want to handle this situation gracefully instead.

Refactor the function to return a `NULL` pointer if the source could not
be found and adapt the callsites to die instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 4 ++++
 midx-write.c           | 2 ++
 odb.c                  | 2 --
 odb.h                  | 4 ++--
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 25018a0b9d..dc2c1a5432 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -102,6 +102,8 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 	source = odb_find_source(the_repository->objects, opts.obj_dir);
+	if (!source)
+		die(_("could not find object directory matching %s"), opts.obj_dir);
 	graph_name = get_commit_graph_filename(source);
 	chain_name = get_commit_graph_chain_filename(source);
 	if (open_commit_graph(graph_name, &fd, &st))
@@ -290,6 +292,8 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
 	source = odb_find_source(the_repository->objects, opts.obj_dir);
+	if (!source)
+		die(_("could not find object directory matching %s"), opts.obj_dir);
 
 	if (opts.reachable) {
 		if (write_commit_graph_reachable(source, flags, &write_opts))
diff --git a/midx-write.c b/midx-write.c
index c1ae62d354..40580d8c73 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -917,6 +917,8 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 							const char *object_dir)
 {
 	struct odb_source *source = odb_find_source(r->objects, object_dir);
+	if (!source)
+		die(_("could not find object directory matching %s"), object_dir);
 	return get_multi_pack_index(source);
 }
 
diff --git a/odb.c b/odb.c
index 1761a50840..61104b7cb8 100644
--- a/odb.c
+++ b/odb.c
@@ -464,8 +464,6 @@ struct odb_source *odb_find_source(struct object_database *odb, const char *obj_
 	free(obj_dir_real);
 	strbuf_release(&odb_path_real);
 
-	if (!source)
-		die(_("could not find object directory matching %s"), obj_dir);
 	return source;
 }
 
diff --git a/odb.h b/odb.h
index d9f4dcf79f..387b117c87 100644
--- a/odb.h
+++ b/odb.h
@@ -186,8 +186,8 @@ struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
 /*
- * Find source by its object directory path. Dies in case the source couldn't
- * be found.
+ * Find source by its object directory path. Returns a `NULL` pointer in case
+ * the source could not be found.
  */
 struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir);
 

-- 
2.50.1.619.g074bbf1d35.dirty

