Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C6388E5F
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305004; cv=none; b=PGOXmicJ1oYogaMdLv60OR/M/tCrE5PQ9xMrUj7XLfhPgN25qMUpc2Zd2ye1EoObp8BhL3haWEBIkLdr48fwsi87XetFDRaxPXPXV7w7rxAstRh/equruSDaiDij2Px+HlWp4W7/VNF1YY9k45KYVX3sR09xOe2wEIxvfLtWDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305004; c=relaxed/simple;
	bh=9cy0kYR+GpCLWsA/dATjRp3bOhm0LkbYlZzvEjjANLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lx7xHA+sbtvlJKtgWa21vEViwpBBH1banvs7elwQe6adtzQKwCTYxMo3XjEFb/e05pt3Hy8uR8NfoBk6a+MFfGIyuPI36TBHhBKm2HCWEm/931lxGFo+SNUGp/c61X/QKh2aETXFCq9qDgkRvacsERtqFEFn5a/X3x/6eUHcJZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LKyscT3u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RDQGXaRX; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LKyscT3u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDQGXaRX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A54FFEC00DF;
	Thu, 12 Mar 2026 04:43:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 04:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773304999;
	 x=1773391399; bh=r+YeSKUMKCBJj5s9avTIutCelBm2jPSgW3OaucdJiF8=; b=
	LKyscT3uebCyS8YUC469IMXuCuDjb1XAUYAvvw19fw3/EKSoE+nJrQ3JtjOh3Bd0
	cwb2scY2FUmZscZ+Kr6p2KOqn1zRH1fHqBLX1Zrpf2761hvmKxsonTY9BYclsFjL
	XHruNfbpvWOOeSGysHft/FwDm/1lUKyPOC+h3zB4o7RVYzjd6Zv5/JuUsdJcpYPN
	gUPFTZuV38aaKAlQQHD4drgCMI5imkrznOUW9rGuu99EtNFlpp+OokzSDl6f/BTi
	rtkFcn/PQ4UOuy8JGS1YvKrTEBeoiY3Jr4uZtKJRLX3lAGIgm42mOtja4NyTLkiW
	wEEGEJUfFv6DmpdYg3r9wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773304999; x=
	1773391399; bh=r+YeSKUMKCBJj5s9avTIutCelBm2jPSgW3OaucdJiF8=; b=R
	DQGXaRXps8APCtf777iwcM0EdhbxKPg9VZkN3XkTjYtWsrwb9+VFRFk8ovZr2G03
	8Fpnzh8HPeEylxKV2Vhqw8rylUZmQyAdLpkbVfsRoPP+396wgww9tG4DRHzqFuG0
	V3+UtBwGHwpBjY54yO1UlLD+pVBPQPbwdxBjfvjlA2kzqUVewcpf6hn3YlERuSTd
	l03pv6yVV5Llic3urFhK9y7j8ceLRRA7dD482ahIqkT3Ih8npBdU99fgoncv4izS
	2NNOrdWqxc+z7gxpxYgHS4599HoWXgy/hwqCNKnm+PH1HLI5i4F/L64WOGwOkyMB
	a+ma/HWETpYwbe/GHtVNg==
X-ME-Sender: <xms:p3yyae_1dVMf6pDzC_1M30cZqajNNyGegTLdI-dZGjaytSmXqNhcQw>
    <xme:p3yyaWJoVDD0TRGh7LTuBHsl4vRvzvN6fkYt9x-keG36FrjtwRX3SRBDqTznrFaJN
    4ALAmUpVg7TKV6uwOyKejT--01woRuq5S8gXp0B4umqhdIVorb1QFw>
X-ME-Received: <xmr:p3yyaRaGjtTFdrvBtk1G0rXdYs4AO2-qNBAw8uBNnFHbGIl6k99g5bKhvlTKJg3pYYKMFkaxuWKeZLs2WBc-i7nXnEv-Zbuzh2QK72_TlznBVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeifeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:p3yyaQJfOSZV-kQJaWGx9Fs-IPpdK1WaLIXCIWwm_Wras65tqnabuA>
    <xmx:p3yyaXC7Ao4ASKcHCpEnR0XioJFfwFQPR7Jp4AoxnWSePQuRkT4BbA>
    <xmx:p3yyadrvYeHOGUssPRfhnmbDRcku4G4zq0cKFyHXo1fzPE79UH6Z3w>
    <xmx:p3yyaagF_IrJvk_Ulac9ohogzz9sIrOALL8HP3Io9AowwhW8Nz836g>
    <xmx:p3yyaZyJ85yPCPWbMBd6LobnBwUK55CK9_dPDGNiABdFVTYrT-GtJay1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 04:43:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3118ec03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 08:43:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Mar 2026 09:43:01 +0100
Subject: [PATCH v2 6/6] odb: introduce generic object counting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-b4-pks-odb-source-count-objects-v2-6-5914f69256bf@pks.im>
References: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
In-Reply-To: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
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
 odb.h          | 19 ++++++++++++++++---
 packfile.c     | 27 ---------------------------
 packfile.h     |  6 ------
 7 files changed, 64 insertions(+), 40 deletions(-)

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
index e6057477f6..9aee260105 100644
--- a/odb.h
+++ b/odb.h
@@ -110,10 +110,11 @@ struct object_database {
 	/*
 	 * A fast, rough count of the number of objects in the repository.
 	 * These two fields are not meant for direct access. Use
-	 * repo_approximate_object_count() instead.
+	 * odb_count_objects() instead.
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

