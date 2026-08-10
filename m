Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153C30100E
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368823; cv=none; b=HS1z3qxx2V3ao+tMa0bYrveGeM7i/9B89luVqOwJX15FIFq+kgxCTUNRORawYyrQGRb7PBiADGS1emJErwhuHKDmW86krXBQSscgwUi382N6bP//yNlHQNkE+8OT3p1kaQLrQm9HUvKQ7GBQLzbADjJDW9qV6Xx3W7iilEldCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368823; c=relaxed/simple;
	bh=UB0C73ZdAqGyj/FkC8Bd9boJ0mucu2MMb2c/jP20Dss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gpfcgfETdiwUV64dRy8JhWFhNJy/H0oob4J1fFNIle5blcs5AwiZ6lLFG9UCNfrzphtM0w6LfM9b7qaVrMWqv9W7WFHVmhDN+dCOqcx1lqj6/TB/ycLul98Irdt30Bn9RNpudkk5wXN0RoOyPV3UadJsNq5lm2geqCZi4wkatTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cRJrLPEu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IsyohRlJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cRJrLPEu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IsyohRlJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13CE414000F8
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 09:33:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 10 Aug 2026 09:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786368821;
	 x=1786455221; bh=j92WLFvbX8ATZKx21dRc7nQ9p+dHgfoHrsSnoIJdz04=; b=
	cRJrLPEuReVu5iYYaK8JL4nbUSyHkU6sjmID+vS7nXO+C6PrTEDVdWyWuvaV7VIt
	kCoH59wKcGQGiyAFrqdRTmMNiMq2v0gEoVWmVOi+IBJqOr07R/l8w/EAHN/gdpSZ
	v5lKB3Wl5E3F6BpDv1euOV/xtkmXj+jdgqwGkvkxdOYyqJM33uk9qjnTZiMk0mrM
	wBpKBeFZmUL7geGfXyVnvufcwO2ZkkvMIsON53H4WJRzTq7LdUUBt9Q+KhwE0UEP
	/2J4h9zXOaI0Bx50KHIqLKbKzZMHjwKv3idZZGKJ0ZA96ldJSQ2oR7lQZzYB7RRa
	b8SaK7qhj1OGrmFploSXgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786368821; x=
	1786455221; bh=j92WLFvbX8ATZKx21dRc7nQ9p+dHgfoHrsSnoIJdz04=; b=I
	syohRlJdZhE8Nj5WzXiGR28aGF46lnUDO6KZPPiWTQm1ad/aADhUR72G8dxoZEte
	avYh0mxZmC/NxSJj2Wtv0wHJkZn3D66LTw8VL/XHL5L3W1BgD7tNqZNcO95oj3PX
	xVj2i/q7sUiBogeaQf0eVDdOJ+JHWpd53O4uHenlQKTLUoTm6rHPRd/a5Q8rSBlE
	goRINvtFGGDw2M4oQgDibd/msxS+wdzyVGgUh97IWRLW0RwxClnlmvgoH+U21MM3
	vB364dZwG+RdEVQCwK1oku9yqzV5bsu6/FxIBZbOl5/V6wP49hRHXGoODEmeCnZQ
	0Ll5OeEmiKriL8WwGgAKA==
X-ME-Sender: <xms:NNN5attEijXLnJ6qhJxyiTnbSlEvNW3T2s3DIw4cIGGZ-5Zc7YZTkg>
    <xme:NNN5atYnQBDvHXydVela2PZCi8NI6ZDuLKjPGNk1mS28frKEVwOoPRCZDmztF02CF
    bo62IEGRmEqCsIV0EYqbWTKj6PD7HhmplVuz3E4UOtjOZCCnEDl-w>
X-ME-Received: <xmr:NNN5amalhViqC3y0oj0qjcTwUe7iZWB1I60DTENQToqog0v201mmRrhm12yB-BtZvdo7XzrkIboFlIOo7h7dOp3U_H_G4eo73-K89-jwpQ>
X-ME-Proxy-Cause: dmFkZTGOG8gd1NbXOzGDbLaEL5rX4TayEDtDnwGJGigUSe6t/pAdO6k9be8XoAkN9vgI0v
    Z0qvwXySLfo2EXnafZPTpdEHv4jIW8Wddl/nQFZNDgMZOP+4X7svUW96hp9mttN9s9T7VE
    WQCwAaW1oM4ZmQr9cxFEHEM6N2xj3o8ZTeLFMKhztXWNGG2sDXaoZorHIBo/iK8rjZPScV
    GYhqytMSek9JFlFPDLYQ4U2w1QX7VmmJjPz+SuiClFDE3vZ6SvbCWhyZfgw6Oc5Hgr4r4p
    vvF55FHlAnhMrwOVr5+4arropYhdfTDk+tqVk+4VdR4YwqrD4N/Wah8v3j5ep0xb4k3NCn
    AGQdiwtASKQHyPlISKep5rQeiKdUU+uVNOr1gMu4J7Kx2QsmxfFMdXSBljC9wu3C/vuP0x
    pBpw5wEakFAmAbed8eNwim7Y46/zG1sgfgj2+DRaJHdIC18Ew47XBHJSageiK3ALokbY9B
    3UUB6eORQDkvqu/vO1TgLYHwzSu4SVzUq6x8WpjfpihXZElMmwU91p/18+VZ6XzLm+s10R
    Q1/H3IAJUC/DeSdA1Z9E2IFrNMfub0Okz7oBuD8WCoX7bKFf1SMYr4oqsYQRaaObk3XaLF
    xYSR5NUiZI2Ex2zqS2bHwXsFKdLlZox+Bsx5HIMbl2MTzc8ZGY4chgbyKWkA
X-ME-Proxy: <xmx:NNN5apWR_hn4r_6oXuhd0iWp69IPwtmtt5DF5Mod31RxtXSAby8kEw>
    <xmx:NdN5at3PsNSwzw5UuArig7GjMtpTWwt5HW3IUo6_q0g-KfztT-fF2A>
    <xmx:NdN5agb8b3GJ1Vz_-QNtOPZTQahCk6cgB_RgF5OwBFLrmequ5WYsEQ>
    <xmx:NdN5agq8ooGUTvGUlLAYe2LXTW9urQRSYVO4ojiFgRUFycdic85JVg>
    <xmx:NdN5akdwPtAMDhbsNCrPwt9DvxgYPLxG-j8VLtna26pjnbrgRXUTX-Yq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 10 Aug 2026 09:33:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a406f9d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 10 Aug 2026 13:33:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 10 Aug 2026 15:33:28 +0200
Subject: [PATCH 1/4] odb: decouple source path comparisons from
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pks-odb-eagerly-prepare-alternates-v1-1-f0fa4a4004e1@pks.im>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
In-Reply-To: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
To: git@vger.kernel.org
Cc: 
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
as the khash interface does not give us the ability to change these
functions.

Note that we can unconditionally use `strihash()` to compute entry
hashes regardless of case sensitivity: a hash function only needs to
guarantee that equal keys have equal hashes, and a case-insensitive
hash satisfies this requirement for both case-sensitive and
case-insensitive equality.

Overall it's quite debatable whether all of this complexity really is
worth it, or whether we should just linearly search through all sources
to find duplicates. But the mentioned commit cares about cases with
thousands of alternates, and a linear search would of course regress
performance quite a bit. This doesn't really feel like a reasonable case
to care about though, but I don't feel comfortable regressing it anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 63 ++++++++++++++++++++++++++++++++++++++++--------------------
 odb.h        | 15 ++++++++++++++-
 odb/source.h |  7 +++++++
 3 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/odb.c b/odb.c
index bd02d8ad54..51da386f22 100644
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
@@ -29,8 +28,32 @@
 #include "trace2.h"
 #include "write-or-die.h"
 
-KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
-	struct odb_source *, 1, fspathhash, fspatheq)
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
@@ -58,8 +81,8 @@ int odb_mkstemp(struct object_database *odb,
  */
 static bool odb_is_source_usable(struct object_database *o, const char *path)
 {
-	int r;
 	struct strbuf normalized_objdir = STRBUF_INIT;
+	struct hashmap_entry key;
 	bool usable = false;
 
 	strbuf_realpath(&normalized_objdir, o->sources->path, 1);
@@ -76,20 +99,18 @@ static bool odb_is_source_usable(struct object_database *o, const char *path)
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
@@ -172,8 +193,6 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 {
 	struct odb_source *alternate = NULL;
 	struct strvec sources = STRVEC_INIT;
-	khiter_t pos;
-	int ret;
 
 	if (!odb_is_source_usable(odb, source))
 		goto error;
@@ -184,10 +203,11 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
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
@@ -1056,6 +1076,8 @@ struct object_database *odb_new(struct repository *repo,
 	o->repo = repo;
 	pthread_mutex_init(&o->replace_mutex, NULL);
 	string_list_init_dup(&o->submodule_source_paths);
+	hashmap_init(&o->source_by_path, odb_source_by_path_cmp, o, 0);
+	o->source_paths_icase = -1;
 
 	if (flags & ODB_NEW_HONOR_ENV) {
 		primary_source = xstrdup_or_null(getenv(DB_ENVIRONMENT));
@@ -1094,8 +1116,7 @@ static void odb_free_sources(struct object_database *o)
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
2.55.0.679.g6767b8d81c.dirty

