Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361813FB042
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964974; cv=none; b=kkFZmbN5AF5tG42OENgGNkEMRCQHkX813SWPw6auQbpjFOBV6iL30crU+AIdiRyxmO495e+o0of3JVt7rFsXjlWwvtUFec568ibWLjwMTNKOqwgDTYJ5WFjHwJiAS+b10Amt+9dy77OkC4HgiZfT31kGjQeBbKFx5SWc+WEHfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964974; c=relaxed/simple;
	bh=R1F1Oaom6M6qYlze3sPMhB1WQvPF8HlIoqwIVh/hZRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/ufUBffGb+e5HCZmtZGuk4u6s2TjqpUmXN5MK/XAfIGrbKe1PfF1YOuEG7bqUuDW0FYImlE0kgZu/KRgmcr9hME3c/A4jg9DFFKMuxGU9FQh4c9V/9gxnmM+oVVn1ukq4ywUFyRe9Li/V/4k63Vsp07n7zKowbit6hOO3sr6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EbzhxMN/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z8+gOMuw; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EbzhxMN/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z8+gOMuw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 64606EC01C3;
	Mon, 17 Aug 2026 07:09:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 17 Aug 2026 07:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786964972;
	 x=1787051372; bh=xzOBhJvvFHnJVbgXyQ0Di6bKETgPbRUHLYYxLqWN0qI=; b=
	EbzhxMN/5IBL0zKt3H6W9PyvKDcVpa4M/TPkjPC6D84ltq+mWYPHja25jUn5BgLU
	3k/EEndEDyTwoAqYTtyBdvW0FB9h4K2fXCBL/yP3wE3Ft51ojIyv28MzplJh48R4
	0qip9/TUDTbDnTznAkgdcjPJQnYOCjGMZWQadaoL5CPKMzHHVqitqvTldrRSbX3x
	A4WT5HdGp3k/lzx3akhrpY9/fZJQkffMrB3P44kWRoTZE+Eio7wcP2gz52D7HvFY
	dmNT8vr8pOg5Kbt0G04snAtYhKLYJdkjn+bPQjdghgL37Yvo2RqHGjWCviBhglG6
	Rf++7M3zWHLxxn4m8p0WyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786964972; x=
	1787051372; bh=xzOBhJvvFHnJVbgXyQ0Di6bKETgPbRUHLYYxLqWN0qI=; b=Z
	8+gOMuwU+JPteB1mVdjOBd3YpLpNkY+7zvoQgYq9uvlWLT54vd7D+/n1g6S0yXSn
	jYII085StbtlmJ5ROupts9TvafwtzKzgJOyv+C1hLD0e70wmuk1a3l+nLuPkTp28
	//d0VT8zAyci2CIcJvGgJX6bGWT7CksnSsqzCIQyopwCov/xnttPb2zNwZhQ422k
	ydWrPo3YwOgc4uz832n8lMiOL3Skne3T2OqR1SsZf8jx4ys8aO7P3KMW0Osng//9
	p5WfGC4+GlP+XOIS79cbFgh9UaYStD1uiqhUBAIikuPHa8/4/FONc8dZ/6yq/xi1
	SoGl2myoEZLBoiZpM2SsA==
X-ME-Sender: <xms:7OuCaui3FDmQaNR611-z8GdAmFJBhVkXT9mRBjadUrJx0olRkFudFA>
    <xme:7OuCamB-GwhEbIGl9zesDbQXjy3dCVd2tTyd-32Jij87PpHOqyWx-z96rKbOi7DIM
    evQVR2IrI1e8GEeIAgihgYxmb9tRHc7VLs5T_npbWI_Mn6jP6KG3xA>
X-ME-Received: <xmr:7OuCarEcqVWYlOOQnx2BwrhJ00M34bLvrPKKN6_CCJ5u1BoeWpHV5KrD2QdzpNl08SEvXDhazVd7dnxhJhyziqHzw4ocvoP4qe4PjvgBZA>
X-ME-Proxy-Cause: dmFkZTFhrROEgUMCsHMDxIXKxd35YdsoBEoaHNh9Qjn1O9OUwZBiGGfRSn381E1sQ9m69M
    mgBANykgfGpJ3dGr3YvBzcVJb9naXiQZ4xdUewsI5PZTaxuTkMWllcmRSDeKMylPoZJPDd
    LtS9A6r2TYJr8GTYmtuAJK03UiagjnMV0iEBfYyREKJvQxGd/+6HfTJUwHBMHOhl3uAKWt
    px6u1yIbAHc3ZEwvpTeSrr+fvc3oyCeq7t9vq6YL5wOCFVWjLACWq/pHtHtvR+zCrVuJSM
    NFkSsBZm9HwcAt4EildApivRRUp/pVrJoKKR6pJYpB7nAcuxMfgt0pP2H1XxAGZnKfMeV7
    yCSlsoCbodhsOF99PQeqkyxCnOPUAuCoXKPLNUTeG69oG4J+4OkpkntAGTabChHAQKP/R0
    Ig0L+sKTUM8J5QKJ0Ami5H+WTmgCXhtOaFSm/MTCkN7rMaKfLX+4+wt/h4YXUIEj9Rk5zc
    Uu42Tw7HktB88aDzWtXGOfEdZ32W52ijhQDmlU4tw+r0joJMFfvxaVCPZTjif7mok5QnJv
    61BoMNbsYvooM3ID4Xvog9uHg+kRnEqbF5vtIjjUI7kVVgFAbePTdAvbnfvMIXDXv8E/Fk
    c9lCK22dQcFcRUNKsu/niF++yN5m01kY23sC95OYgLGUHpUIPYpL/ocKnD+Q
X-ME-Proxy: <xmx:7OuCamJLFDOuTC--3lV4Zeni9tCDfmLOmF7p3pEYepsau808r4tl5w>
    <xmx:7OuCanla9yJMdFqHUdQ3E9Lyn-joXLKky90parDYuUqB9pZg6w7twA>
    <xmx:7OuCamSJvMKjJ6Ctt3PTDNR02OfrEsXzmqmjT4Xg1iaEvn6Op-EF9Q>
    <xmx:7OuCahJr0TWVGdFYlLtcfVXPNQlURAP6t0COfp0_AVOkTuI33zhtaw>
    <xmx:7OuCalDYK2EH--V7qCHeVsNfCzR036gePsstLUAAT-8UBO71BrP_FHqf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:09:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d7ec9a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 11:09:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Aug 2026 13:09:22 +0200
Subject: [PATCH v3 2/5] odb: decouple source path comparisons from
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-pks-odb-eagerly-prepare-alternates-v3-2-1115a7e02467@pks.im>
References: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
In-Reply-To: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When registering alternates we deduplicate object database sources by
their path so that the same source won't be added twice. Ever since
cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
this duplicate check is backed by a map keyed by the source's path,
using `fspathhash()` and `fspatheq()` as hash and equality functions,
respectively.

These functions are problematic in this context for two reasons:

  - They implicitly depend on `the_repository` instead of the
    repository that owns the object database.

  - They derive case-sensitivity from `repo_ignore_case()`, which
    returns a default value in case the repository's configuration has
    not been parsed yet. Object database sources may be registered
    before that is the case, so the answer may flip depending on when a
    source gets registered.

Fix this by making the comparison self-contained in the object
database. Instead of using `fspathhash()` and `fspatheq()` we resolve
"core.ignoreCase" manually and then use the correct comparison function
based on the result. This requires us to migrate to a `struct hashmap`,
as the khash interface does not give us the ability to pass an arbitrary
payload to these functions, and hence we'd have to use global state to
decide which of those to use.

Note that we can unconditionally use `strihash()` to compute entry
hashes regardless of case sensitivity: a hash function only needs to
guarantee that equal keys have equal hashes, and a case-insensitive
hash satisfies this requirement for both case-sensitive and
case-insensitive equality.

Overall it's quite debatable whether all of this complexity really is
worth it, out of two reasons:

  - We could linearly search through all sources to find duplicates. But
    the mentioned commit cares about cases with thousands of alternates,
    and a linear search would of course regress performance quite a bit.
    This doesn't really feel like a reasonable case to care about, but I
    don't feel comfortable regressing it anyway.

  - It's dubious whether we should handle "core.ignoreCase" in the first
    place. The downside would be that we might add the same alternate
    multiple times with different casing. But this is an edge case, and
    it's not even fully fixed because we don't resolve symlinks or
    mountpoints, either.

So for now, keep this infrastructure in-place while removing the global
dependency on `the_repository`. We may want to revisit this in the
future though.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 78 ++++++++++++++++++++++++++++++++++++++++++++----------------
 odb.h        | 15 +++++++++++-
 odb/source.h |  7 ++++++
 3 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/odb.c b/odb.c
index bd02d8ad54..22f1425ba5 100644
--- a/odb.c
+++ b/odb.c
@@ -2,11 +2,10 @@
 #include "abspath.h"
 #include "commit-graph.h"
 #include "config.h"
-#include "dir.h"
 #include "environment.h"
 #include "gettext.h"
+#include "hashmap.h"
 #include "hex.h"
-#include "khash.h"
 #include "lockfile.h"
 #include "loose.h"
 #include "midx.h"
@@ -29,8 +28,47 @@
 #include "trace2.h"
 #include "write-or-die.h"
 
-KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
-	struct odb_source *, 1, fspathhash, fspatheq)
+/*
+ * NEEDSWORK: we're using "core.ignoreCase" to deduplicate alternates that
+ * _may_ be the same. This requires quite a bit of boilerplate for dubious
+ * benefit:
+ *
+ *   - Duplicating alternates should really only lead to regressed performance.
+ *
+ *   - We don't properly resolve symlinks or mointpoints, so we may still end
+ *     up duplicating alternates.
+ *
+ *   - The value may be lying, in which case we might deduplicate alternates
+ *     that are in fact not mapping to the same directory.
+ *
+ * We should investigate whether we can remove this whole mechanism outright.
+ */
+static int odb_source_paths_cmp(struct object_database *o,
+				const char *a, const char *b)
+{
+	if (o->source_paths_icase < 0) {
+		int icase = 0;
+		repo_config_get_bool(o->repo, "core.ignorecase", &icase);
+		o->source_paths_icase = icase;
+	}
+
+	return o->source_paths_icase ? strcasecmp(a, b) : strcmp(a, b);
+}
+
+static int odb_source_by_path_cmp(const void *cb_data,
+				  const struct hashmap_entry *entry,
+				  const struct hashmap_entry *entry_or_key,
+				  const void *keydata)
+{
+	struct object_database *o = (struct object_database *)cb_data;
+	const struct odb_source *source = container_of(entry, const struct odb_source, by_path_entry);
+	const char *path = keydata;
+
+	if (!path)
+		path = container_of(entry_or_key, const struct odb_source, by_path_entry)->path;
+
+	return odb_source_paths_cmp(o, source->path, path);
+}
 
 int odb_mkstemp(struct object_database *odb,
 		struct strbuf *temp_filename, const char *pattern)
@@ -58,8 +96,8 @@ int odb_mkstemp(struct object_database *odb,
  */
 static bool odb_is_source_usable(struct object_database *o, const char *path)
 {
-	int r;
 	struct strbuf normalized_objdir = STRBUF_INIT;
+	struct hashmap_entry key;
 	bool usable = false;
 
 	strbuf_realpath(&normalized_objdir, o->sources->path, 1);
@@ -76,20 +114,18 @@ static bool odb_is_source_usable(struct object_database *o, const char *path)
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	if (!o->source_by_path) {
-		khiter_t p;
-
-		o->source_by_path = kh_init_odb_path_map();
+	if (!hashmap_get_size(&o->source_by_path)) {
 		assert(!o->sources->next);
-		p = kh_put_odb_path_map(o->source_by_path, o->sources->path, &r);
-		assert(r == 1); /* never used */
-		kh_value(o->source_by_path, p) = o->sources;
+		hashmap_entry_init(&o->sources->by_path_entry,
+				   strihash(o->sources->path));
+		hashmap_add(&o->source_by_path, &o->sources->by_path_entry);
 	}
 
-	if (fspatheq(path, normalized_objdir.buf))
+	if (!odb_source_paths_cmp(o, path, normalized_objdir.buf))
 		goto out;
 
-	if (kh_get_odb_path_map(o->source_by_path, path) < kh_end(o->source_by_path))
+	hashmap_entry_init(&key, strihash(path));
+	if (hashmap_get(&o->source_by_path, &key, path))
 		goto out;
 
 	usable = true;
@@ -172,8 +208,6 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 {
 	struct odb_source *alternate = NULL;
 	struct strvec sources = STRVEC_INIT;
-	khiter_t pos;
-	int ret;
 
 	if (!odb_is_source_usable(odb, source))
 		goto error;
@@ -184,10 +218,11 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	*odb->sources_tail = alternate;
 	odb->sources_tail = &(alternate->next);
 
-	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
-	if (!ret)
+	hashmap_entry_init(&alternate->by_path_entry, strihash(alternate->path));
+	if (hashmap_get(&odb->source_by_path, &alternate->by_path_entry,
+			alternate->path))
 		BUG("source must not yet exist");
-	kh_value(odb->source_by_path, pos) = alternate;
+	hashmap_add(&odb->source_by_path, &alternate->by_path_entry);
 
 	/* recursively add alternates */
 	odb_source_read_alternates(alternate, &sources);
@@ -1056,6 +1091,8 @@ struct object_database *odb_new(struct repository *repo,
 	o->repo = repo;
 	pthread_mutex_init(&o->replace_mutex, NULL);
 	string_list_init_dup(&o->submodule_source_paths);
+	hashmap_init(&o->source_by_path, odb_source_by_path_cmp, o, 0);
+	o->source_paths_icase = -1;
 
 	if (flags & ODB_NEW_HONOR_ENV) {
 		primary_source = xstrdup_or_null(getenv(DB_ENVIRONMENT));
@@ -1094,8 +1131,7 @@ static void odb_free_sources(struct object_database *o)
 	odb_source_free(o->inmemory_objects);
 	o->inmemory_objects = NULL;
 
-	kh_destroy_odb_path_map(o->source_by_path);
-	o->source_by_path = NULL;
+	hashmap_clear(&o->source_by_path);
 }
 
 void odb_free(struct object_database *o)
diff --git a/odb.h b/odb.h
index 8eb4e85d64..71af7450a9 100644
--- a/odb.h
+++ b/odb.h
@@ -1,6 +1,7 @@
 #ifndef ODB_H
 #define ODB_H
 
+#include "hashmap.h"
 #include "object.h"
 #include "oidset.h"
 #include "oidmap.h"
@@ -54,7 +55,19 @@ struct object_database {
 	 */
 	struct odb_source *sources;
 	struct odb_source **sources_tail;
-	struct kh_odb_path_map *source_by_path;
+
+	/*
+	 * Map of object database sources, keyed by their respective paths.
+	 * This map is used to detect the case where the same source is
+	 * registered multiple times.
+	 */
+	struct hashmap source_by_path;
+
+	/*
+	 * Whether source paths shall be compared case-insensitively, as
+	 * determined by "core.ignoreCase".
+	 */
+	int source_paths_icase;
 
 	int loaded_alternates;
 
diff --git a/odb/source.h b/odb/source.h
index 4bc037b8d6..82cda8ad75 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -1,6 +1,7 @@
 #ifndef ODB_SOURCE_H
 #define ODB_SOURCE_H
 
+#include "hashmap.h"
 #include "object.h"
 #include "odb.h"
 #include "odb/transaction.h"
@@ -50,6 +51,12 @@ struct strvec;
 struct odb_source {
 	struct odb_source *next;
 
+	/*
+	 * Entry in the object database's map of sources, keyed by this
+	 * source's path.
+	 */
+	struct hashmap_entry by_path_entry;
+
 	/* Object database that owns this object source. */
 	struct object_database *odb;
 

-- 
2.55.0.822.g20453c30eb.dirty

