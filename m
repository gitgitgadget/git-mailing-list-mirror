Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E42957D3
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799942; cv=none; b=PzA7vo5BUZiKR1quhNKFcjMqGBNwPflgSDTGlnXW63JnGibIMFpPSx71Kti4dn9DOH9/iXzQc3Uws/k1QJCZh4FvW/1PhLJQNIjQAYW0dveKcQbO3eDilIDkusy6eXvh2PHwzrDf0LHRnq9p2oy2F9igsigq36P5Rr7957fiWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799942; c=relaxed/simple;
	bh=6LjgVhuTHo+S/tQhBkJhlL1Dn5MFgFOclrPfEgrqWQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqCikbXmzL+m/A+jDXNXbd4fJY2n1YtqRhqgovt6NA9VvQFnzIJlIjABeT4Wn5iwYD4t98E/ThK7VvR+SHoVa5jRUkvfhGiTAvCHLjiRsKRsW8kGZRPjZ4JhPu9LcJLKILtDt85r7xTgQei0PnT77W/fQEOqf1so7PqYPipOffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=crLbprwy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u8L35eXM; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="crLbprwy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u8L35eXM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B6491140187;
	Fri,  9 May 2025 10:12:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 09 May 2025 10:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746799938;
	 x=1746886338; bh=P7d7wxVH9QztUeHK9ts3xrSc7wkdfedzpU6I7dQ/c4o=; b=
	crLbprwyiuGHG6hdxUzRfQYVSaef+nIdJB1JnBr5KOihqY+YqIkn+kEwD6lbDM5J
	a6WW65Z/zu/IB2PunIHzXsqoxbc9+GOFHbJVV1OI2shxkPUVCDjXnqHFxgOOwi9p
	dPImGbXW0BF+DYIjrwXbtt835r5xoNxVC462AGDp4cYvwu4HVEdZKmo8s0OZVoxY
	X3EecDTaBb6TWDxVDPd0X6+5TLrxEM+ZD6lVBG8SZ9oAQQPtwVA2K/R4vdCiliSh
	OAXZQKfoPsW7aX4O/ur3tygH0PtdiFRvsK2uIYjxy5iyPyU4rKVK6XYUtDBDHeRS
	UndXuuLJqE3o9IuH1v9r5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746799938; x=
	1746886338; bh=P7d7wxVH9QztUeHK9ts3xrSc7wkdfedzpU6I7dQ/c4o=; b=u
	8L35eXMCUKfSe+cFJNqzF9ZiBE248JIIwjc20PkSSKzf14yb/c6UDK1pevvFm2HC
	qPGjBj4z6AIIauizHhby4SH6J15QJs8CuLxWP5bdQ+c6qFtg5Hiyxfm+OF8y4GLm
	khPideMj5P1wIsjpRYbK9gLRtsXeFOgbAyuYpFKD5iiRMw7X57Ti+Sse9GGExfol
	5xoAP15MYvm5Y1x8K31cBLTHXCff8wz4bElhg9bq0UfgYjQ/5+VOcZOjgxWX4Rti
	XEWLWORNdYLdxAXCJIILuFpoV6y/kxAtNCXKB7REV48J2YesOhT8/VFLZpwL3nXR
	Ql/1XbaiDOTmVdBu0zuuQ==
X-ME-Sender: <xms:Qg0eaPCm8xhbe0wBLf0MrmiBvD7tT2dGgGloZ97WOc0-X-Rf6HSIsw>
    <xme:Qg0eaFjQ79Q2jkc7jZMQ2p6aPqrQEp3wyoN9RbspviSqaTSB13EKygmGHGHCHiuEl
    czQszTwGh2lgfYt_g>
X-ME-Received: <xmr:Qg0eaKkdy3fsNJXzdavvQtOIGZ0FKyNwPE9RzH2XWpqYHZKptQwFM8Sz5k0rtrQPDcw11Qq3ZSwrQ8mQRFjGJ4_eYZaotuHPLH48Pzm_nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Qg0eaBzj0KjI4tTnymwLcSahZltzzLoQalpvyw6xVA0zt6yRoj882Q>
    <xmx:Qg0eaESfD295nDmN720xqhDiEFVEzolnmwAbDVYsmpRwcIjyv0hh8Q>
    <xmx:Qg0eaEaEVJ6hLrXGDLFoGulVGiJeMpic9EJi7cnE7yQHTXon02D_XA>
    <xmx:Qg0eaFTH-G8luFpPXsfPZ8FaAWKfP7Oj0IgDe395vnYPoNZo2yyhiQ>
    <xmx:Qg0eaBMaKjc5i6qvSj7l4HN1W5DNcSjBN9X0sHfzxrwk_zWReSGM2OgN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:12:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b02adc18 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 14:12:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 16:12:05 +0200
Subject: [PATCH v2 05/17] odb: get rid of `the_repository` in `find_odb()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-object-store-wo-the-repository-v2-5-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index 745e38c1931..60d6358c2c6 100644
--- a/odb.h
+++ b/odb.h
@@ -58,7 +58,6 @@ struct odb_alternate {
 void prepare_alt_odb(struct repository *r);
 int has_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
-struct odb_alternate *find_odb(struct repository *r, const char *obj_dir);
 typedef int alt_odb_fn(struct odb_alternate *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
 typedef void alternate_ref_fn(const struct object_id *oid, void *);
@@ -185,6 +184,12 @@ struct object_database {
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
2.49.0.1077.gc0e912fd4c.dirty

