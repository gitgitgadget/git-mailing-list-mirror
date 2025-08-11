Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5219DF5F
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920018; cv=none; b=Hnlc2mF5K4S5g08GyzL5ObQlEtnk0xpcsLQiR/+gHn5bmbzO7N5Yj5azIVsVvlcuRy+V+rwfoDbGvYBN+lDHHzSsIgO3fiOfJTkDyJCRXKy3Vz4Jm+N6JJcSg+PeDtaVvg1BAWoDeeF7TzTe+C7A9PUtzHx75CVnTglSlYC08tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920018; c=relaxed/simple;
	bh=09IlWxcJg4/Ls+zQ4EA37fMd3GoU6hc3nChk3Ilu9e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JXLIs5F0fU26aXa003x/t/OzHdUVgM9Dp6KGTNaDCTNhXB458IygAcd4m5ZR2YaXWDMJ7GzO5ZNbCQrlEpHxpCnwN0CwGZHRfBSSiL3zfxr4p3fMGzCyMwpOyrmTiQdGwJ6F75SlQNjx30uWEerJH5C2lUThWIPfDKs68+mT8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cVAhLOHS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LdHOd74/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cVAhLOHS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LdHOd74/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6595A7A0077;
	Mon, 11 Aug 2025 09:46:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 11 Aug 2025 09:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754920015;
	 x=1755006415; bh=skDK4UsgIh3r7ZyJEpbPaqbJ2MNURjfHgvK0d9EP+oQ=; b=
	cVAhLOHS7jEHYlTwqWpQ9QlGu2FBS0CBaklyToN7HFyubEmrQszfLZMY97UE9wqB
	UF78uQ8SaI6n83HN9xRQjurfK1UbyZHDCJ1hbsGK6QuyVJ+yit1+yaQDw9u+B9g9
	oVuidHvvxlr3/0Ds9RIFz5O/GhdUjwIlW68o5/b8NcqBFqD9voDvIfnCQG9AnfHR
	kfdy5OPzA6g+KMNkwa/gCkeu+UE7YxtzZ5KD8Xv++PU4ri4YoTYv47gpdcs8rt7o
	7ztQR5goprRvSFC2aKUR+o5VeJ4mq2R1VS3yw5XXHX3X2sTlgcYYb7jmYP5y18N3
	V6jvS/RWHF9s1tVyIpXPIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754920015; x=
	1755006415; bh=skDK4UsgIh3r7ZyJEpbPaqbJ2MNURjfHgvK0d9EP+oQ=; b=L
	dHOd74/Nh6EZy6s4WP5Eyd61J2/WQVyCa7x1D9vrMQcdSiy97BGRP61kSIyof/3y
	zCLIbgyNawUfQZ0Uz21ReU7wwb7L/v6atRScxdaepv8do6UWpsSQR68fml9bqtDk
	fZzAWXu6X+6Xtm+dqRTMJWNo7QsS5yxNqjFnu8vqUR1286DTUYpfEde0/sVdS51v
	dLCj+MauTKzIzLLlXhvFo7qb1gGoiZEzc9IMURIkGmIX0CZHheyRHcVLJWAp8CLN
	JYkCKVmjg9Wlr2a2iXjxEjAQW1cSG9SR0OiwvlsdiH03rgevAZlrUHQzKIHjTDTx
	j/bbFw29VIOHuyMn59SZw==
X-ME-Sender: <xms:T_SZaPhBgBD7H9uZC6aspf5kKHtmsDbCOOcj5WKkz_r8bkPGQxJ1jQ>
    <xme:T_SZaHh5k8Wc0ltRbrx3FTcztg2vJwAA1TNXusq8_X7nFboDQsHl6xpQuprPMlwgi
    x5NTUzLrLwvJ9U1cg>
X-ME-Received: <xmr:T_SZaFiyLS9WHx2pIM24aaP2tqstQr7yxnF4P5ERtkwI9eoj55duMjBeJed1bC_L2_ogqzr7oIn5M7pRwQ9UIHF4BCyOJ-TlJ9WpOdH4HEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:T_SZaHK85RKp7pagjSVBXY9Aw5uU2s1mpDYUUHufm2zillrii9If9A>
    <xmx:T_SZaEECNAwnQRMc-oFItq0T2C82emnZJHVcO6alXK_oQJ-BAyGa_w>
    <xmx:T_SZaLSjULQe70ydw4nrglE2at4-Kt1GfHsWLXdAtWj3vPKgtzogqA>
    <xmx:T_SZaAetyjKLT_YysEv0R-hAbdmtbpIzF-20rokxrsPBlgLcUmLGhg>
    <xmx:T_SZaPyXif7I6cTR1GlDSIs2GuGidWrsiW-kNLVCsScJpo8KPVQkD_J8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 09:46:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3124ddf2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 13:46:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Aug 2025 15:46:42 +0200
Subject: [PATCH v3 02/10] odb: allow `odb_find_source()` to fail
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-b4-pks-midx-deduplicate-source-info-v3-2-e442bdf2b4ad@pks.im>
References: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
In-Reply-To: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>, 
 Derrick Stolee <stolee@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

When trying to locate a source for an unknown object directory we will
die right away. In subsequent patches we will add new callsites though
that want to handle this situation gracefully instead.

Refactor the function to return a `NULL` pointer if the source could not
be found and adapt the callsites to die instead. Introduce a new wrapper
`odb_find_source_or_die()` that continues to die in case the source
could not be found.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 4 ++--
 midx-write.c           | 2 +-
 odb.c                  | 6 ++++++
 odb.h                  | 7 +++++--
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 25018a0b9d..33fb7a5145 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -101,7 +101,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-	source = odb_find_source(the_repository->objects, opts.obj_dir);
+	source = odb_find_source_or_die(the_repository->objects, opts.obj_dir);
 	graph_name = get_commit_graph_filename(source);
 	chain_name = get_commit_graph_chain_filename(source);
 	if (open_commit_graph(graph_name, &fd, &st))
@@ -289,7 +289,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	source = odb_find_source(the_repository->objects, opts.obj_dir);
+	source = odb_find_source_or_die(the_repository->objects, opts.obj_dir);
 
 	if (opts.reachable) {
 		if (write_commit_graph_reachable(source, flags, &write_opts))
diff --git a/midx-write.c b/midx-write.c
index c1ae62d354..d38caceadb 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -916,7 +916,7 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 							const char *object_dir)
 {
-	struct odb_source *source = odb_find_source(r->objects, object_dir);
+	struct odb_source *source = odb_find_source_or_die(r->objects, object_dir);
 	return get_multi_pack_index(source);
 }
 
diff --git a/odb.c b/odb.c
index 1761a50840..4e7f14be4a 100644
--- a/odb.c
+++ b/odb.c
@@ -464,6 +464,12 @@ struct odb_source *odb_find_source(struct object_database *odb, const char *obj_
 	free(obj_dir_real);
 	strbuf_release(&odb_path_real);
 
+	return source;
+}
+
+struct odb_source *odb_find_source_or_die(struct object_database *odb, const char *obj_dir)
+{
+	struct odb_source *source = odb_find_source(odb, obj_dir);
 	if (!source)
 		die(_("could not find object directory matching %s"), obj_dir);
 	return source;
diff --git a/odb.h b/odb.h
index f9300439ba..312921077b 100644
--- a/odb.h
+++ b/odb.h
@@ -186,11 +186,14 @@ struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
 /*
- * Find source by its object directory path. Dies in case the source couldn't
- * be found.
+ * Find source by its object directory path. Returns a `NULL` pointer in case
+ * the source could not be found.
  */
 struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir);
 
+/* Same as `odb_find_source()`, but dies in case the source doesn't exist. */
+struct odb_source *odb_find_source_or_die(struct object_database *odb, const char *obj_dir);
+
 /*
  * Replace the current writable object directory with the specified temporary
  * object directory; returns the former primary source.

-- 
2.51.0.rc1.163.g2494970778.dirty

