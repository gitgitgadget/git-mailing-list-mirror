Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108A9318ECB
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155923; cv=none; b=GhXCQKbT3IGYWormJWZBCRLZVtp2/iJKihdE7aoNOPT09RNvTBva2qvHHPLnSQYyqmXw+MZdLuWrdEal30uy1en27wwXz3SHoitjxP3gTqXoUH81TpRLCc1IvVM2LAyIjjIfX3n6OZW8GtSkcyDKmj+v8bB8viDWYFOkFBOKGxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155923; c=relaxed/simple;
	bh=WmCPn/V87M2X39P+sKrc5HZSNaCWWZky1Bb5TAURD5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iNMh/DOioehtQda7HsC68/WX0v1nOCM+m7eSF9kwPyfb2x8/4VvBAip324D3N6Fais4PtbMuVqNJ7mpdKNU4SKSj6knNuMJFvpOkSnWlvFQpwPPDGh0BjjkYKg0cgzFh+wb6H3NiEC2vAkCqh61dTzloJRlkNCqpEtwqczgI288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hqfS+N41; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iBSCf4DD; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hqfS+N41";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iBSCf4DD"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 502A3EC059C
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:18:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 10 Mar 2026 11:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773155921;
	 x=1773242321; bh=wYOLpK1PSIDBHcxSKFL9lA8U9YBTbatEEyhITtabejM=; b=
	hqfS+N41pOKZ8wOHcVM2z4Hez1S3AzCNJ0cyixEO5oomKlufPRRIO+e9KqJK3RPF
	bF/wkSFrxm359khvj/p/vc2IrbYenDcBTMbZwNrUbqju0Aut7Oer48SOZEdaq3W2
	L1DpN1c9KbH1JSSi47IrcFSobvQKLp3jIX2O3mzeZYc5fHkLmtFCeFmZQwm7fySt
	HjTYmIgzFaH82chxRW1hwLqPZUq4hj73xQVXR8vO307DkVrP+hCZYa2AgfRiAWer
	XQLjtj1N9KCQsbrNQWg3TgI7LmY6qQSajzFxLrdXXdwll5bZ4MvOZMO598KN2Z0R
	24IL2BhSenRg+n5StHXI/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773155921; x=
	1773242321; bh=wYOLpK1PSIDBHcxSKFL9lA8U9YBTbatEEyhITtabejM=; b=i
	BSCf4DDwQqwmchwuB6dsQNxBRQsd6+Ha3w8SabZYkvgVlEDQbVWqtcwoAWBBZInS
	uKtVvD+8DRpzOEV+gw39ZyM9dQnMNr30K/eSsXhiM2WoHbQmjGEKG+zxaX0or1TY
	eobKDNKuBSm9mtuHe62wFxB6WRhwUxnG4agt5Xjgg43QMMIvoCGp22oZZ262WxrY
	S67vSJYEbh22y1WafPRhRoddDT4gmySArlVQujQ9kYrSVw40lFGmcegWqHaDE5GB
	0B0D+eDZQCmbcPfRxbhP4JLUlhIAqHVo/9T4Qg27SNPUCHo/MmcUi2sk6qb38qqO
	KOMkXT/WQXW6lQ6UGtUhg==
X-ME-Sender: <xms:UTawaXRRjKoZqOA8qKz4vW6qjC5Zi-YUWmvC1KR7McVi-KnzGY-TDQ>
    <xme:UTawafv6fAR0eIxLhXW__Wc1a7BZ2GE_D94eamlYkBzuW3-BY9Tcu19jGsF9mv3as
    8-8nWgxJCCSIFQfXYs95R1o4PgQGCdT4ztRofQ6odt_jvGvgMIkAD8>
X-ME-Received: <xmr:UTawaSfKOrh-i-xOwRr6EgUovIOTbQPXp1d2gov5A4-9UC-oUxdJMv49p95OwbjThaqQ3czbkHbZP3OrO6zKAjUdbCTEth4iWtNVETlK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:UTawacKdENmc8-4Xu7CdFFVvrtyoyjR9GehOwdRBIPkXUle8qosVGQ>
    <xmx:UTawaQZtzKUHzh0LRz84fQv2xx0qXCNYfQ7lPvcqX3lBGiHVFiObkA>
    <xmx:UTawaXu8MLmWsMYFKqsP5PVkjBEJHiVveVsbdjamwWOGpZHVVock0A>
    <xmx:UTawadvLeR2iOReUbE7uA4FRxEFX-YiTurPzpIuBdzqSUJNYVrdgUA>
    <xmx:UTawabThT9yrpIV9o4RuDXIjUbXbzRBLGAw4xM0nn5zPcE0NQnhKQs6W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 11:18:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 55cbcfd5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 15:18:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 16:18:26 +0100
Subject: [PATCH 6/6] odb: introduce generic object counting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-pks-odb-source-count-objects-v1-6-109e07d425f4@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Similar to the preceding commit, introduce counting of objects on the
object database level, replacing the logic that we have in
`repo_approximate_object_count()`.

Note that the function knows to cache the object count. It's unclear
whether this cache is really required as we shouldn't have that many
cases where we count objects repeatedly. But to be on the safe side the
caching mechanism is retained, with the only excepting being that we
also have to use the passed flags as caching key.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c   |  6 +++++-
 commit-graph.c |  3 ++-
 object-name.c  |  6 +++++-
 odb.c          | 37 ++++++++++++++++++++++++++++++++++++-
 odb.h          | 17 +++++++++++++++--
 packfile.c     | 27 ---------------------------
 packfile.h     |  6 ------
 7 files changed, 63 insertions(+), 39 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3a64d28da8..cb9ca89a97 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -574,9 +574,13 @@ static uint64_t total_ram(void)
 static uint64_t estimate_repack_memory(struct gc_config *cfg,
 				       struct packed_git *pack)
 {
-	unsigned long nr_objects = repo_approximate_object_count(the_repository);
+	unsigned long nr_objects;
 	size_t os_cache, heap;
 
+	if (odb_count_objects(the_repository->objects,
+			      ODB_COUNT_OBJECTS_APPROXIMATE, &nr_objects) < 0)
+		return 0;
+
 	if (!pack || !nr_objects)
 		return 0;
 
diff --git a/commit-graph.c b/commit-graph.c
index f8e24145a5..c030003330 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2607,7 +2607,8 @@ int write_commit_graph(struct odb_source *source,
 			replace = ctx.opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
 	}
 
-	ctx.approx_nr_objects = repo_approximate_object_count(r);
+	if (odb_count_objects(r->objects, ODB_COUNT_OBJECTS_APPROXIMATE, &ctx.approx_nr_objects) < 0)
+		ctx.approx_nr_objects = 0;
 
 	if (ctx.append && g) {
 		for (i = 0; i < g->num_commits; i++) {
diff --git a/object-name.c b/object-name.c
index 7b14c3bf9b..e5adec4c9d 100644
--- a/object-name.c
+++ b/object-name.c
@@ -837,7 +837,11 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 	const unsigned hexsz = algo->hexsz;
 
 	if (len < 0) {
-		unsigned long count = repo_approximate_object_count(r);
+		unsigned long count;
+
+		if (odb_count_objects(r->objects, ODB_COUNT_OBJECTS_APPROXIMATE, &count) < 0)
+			count = 0;
+
 		/*
 		 * Add one because the MSB only tells us the highest bit set,
 		 * not including the value of all the _other_ bits (so "15"
diff --git a/odb.c b/odb.c
index 84a31084d3..350e23f3c0 100644
--- a/odb.c
+++ b/odb.c
@@ -917,6 +917,41 @@ int odb_for_each_object(struct object_database *odb,
 	return 0;
 }
 
+int odb_count_objects(struct object_database *odb,
+		      enum odb_count_objects_flags flags,
+		      unsigned long *out)
+{
+	struct odb_source *source;
+	unsigned long count = 0;
+	int ret;
+
+	if (odb->object_count_valid && odb->object_count_flags == flags) {
+		*out = odb->object_count;
+		return 0;
+	}
+
+	odb_prepare_alternates(odb);
+	for (source = odb->sources; source; source = source->next) {
+		unsigned long c;
+
+		ret = odb_source_count_objects(source, flags, &c);
+		if (ret < 0)
+			goto out;
+
+		count += c;
+	}
+
+	odb->object_count = count;
+	odb->object_count_valid = 1;
+	odb->object_count_flags = flags;
+
+	*out = count;
+	ret = 0;
+
+out:
+	return ret;
+}
+
 void odb_assert_oid_type(struct object_database *odb,
 			 const struct object_id *oid, enum object_type expect)
 {
@@ -1030,7 +1065,7 @@ void odb_reprepare(struct object_database *o)
 	for (source = o->sources; source; source = source->next)
 		odb_source_reprepare(source);
 
-	o->approximate_object_count_valid = 0;
+	o->object_count_valid = 0;
 
 	obj_read_unlock();
 }
diff --git a/odb.h b/odb.h
index e6057477f6..7b004f1cf4 100644
--- a/odb.h
+++ b/odb.h
@@ -112,8 +112,9 @@ struct object_database {
 	 * These two fields are not meant for direct access. Use
 	 * repo_approximate_object_count() instead.
 	 */
-	unsigned long approximate_object_count;
-	unsigned approximate_object_count_valid : 1;
+	unsigned long object_count;
+	unsigned object_count_flags;
+	unsigned object_count_valid : 1;
 
 	/*
 	 * Submodule source paths that will be added as additional sources to
@@ -509,6 +510,18 @@ enum odb_count_objects_flags {
 	ODB_COUNT_OBJECTS_APPROXIMATE = (1 << 0),
 };
 
+/*
+ * Count the number of objects in the given object database. This object count
+ * may double-count objects that are stored in multiple backends, or which are
+ * stored multiple times in a single backend.
+ *
+ * Returns 0 on success, a negative error code otherwise. The number of objects
+ * will be assigned to the `out` pointer on success.
+ */
+int odb_count_objects(struct object_database *odb,
+		      enum odb_count_objects_flags flags,
+		      unsigned long *out);
+
 enum {
 	/*
 	 * By default, `odb_write_object()` does not actually write anything
diff --git a/packfile.c b/packfile.c
index 8ee462303a..d4de9f3ffe 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1132,33 +1132,6 @@ int packfile_store_count_objects(struct packfile_store *store,
 	return ret;
 }
 
-/*
- * Give a fast, rough count of the number of objects in the repository. This
- * ignores loose objects completely. If you have a lot of them, then either
- * you should repack because your performance will be awful, or they are
- * all unreachable objects about to be pruned, in which case they're not really
- * interesting as a measure of repo size in the first place.
- */
-unsigned long repo_approximate_object_count(struct repository *r)
-{
-	if (!r->objects->approximate_object_count_valid) {
-		struct odb_source *source;
-		unsigned long count = 0;
-
-		odb_prepare_alternates(r->objects);
-		for (source = r->objects->sources; source; source = source->next) {
-			unsigned long c;
-
-			if (!odb_source_count_objects(source, ODB_COUNT_OBJECTS_APPROXIMATE, &c))
-				count += c;
-		}
-
-		r->objects->approximate_object_count = count;
-		r->objects->approximate_object_count_valid = 1;
-	}
-	return r->objects->approximate_object_count;
-}
-
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, unsigned long *sizep)
 {
diff --git a/packfile.h b/packfile.h
index 74b6bc58c5..a16ec3950d 100644
--- a/packfile.h
+++ b/packfile.h
@@ -375,12 +375,6 @@ int packfile_store_for_each_object(struct packfile_store *store,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-/*
- * Give a rough count of objects in the repository. This sacrifices accuracy
- * for speed.
- */
-unsigned long repo_approximate_object_count(struct repository *r);
-
 void pack_report(struct repository *repo);
 
 /*

-- 
2.53.0.880.g73c4285caa.dirty

