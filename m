Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D70A30EF77
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526053; cv=none; b=Owsv9XVttzmk3GSNnXaMj1Sn5wuE0eHKtRwbyc1PosYUX3eUcKpR+qGQOsBSETRCqux8AOCA7sW5O/jP+8ZCiK7pv0OOAn6nH5Dsi/CCpPJQ4OyXVJHUMXuEQo94EoC1Y6qZAjUkjpCtksFFy+wO6Hq/belKBRYwFdnkpQQVokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526053; c=relaxed/simple;
	bh=UB0C73ZdAqGyj/FkC8Bd9boJ0mucu2MMb2c/jP20Dss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVCmZ7l/rViY4hk2vedXL5C9RCRpO6Nwo2YbRNotykJ2UOZeOPM+fj34YNUe9SacudN8RdLjQHgQvA9+kLQtuZmnwIgE+1P96GcyS5xyXItwt5kRzLmP27KPVWmkdDFiqt4mG7tqz8em/qp1qorN3irQj+f6b5n/Aj+jUOzUElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d+7xTBhX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DBrYufyj; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d+7xTBhX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DBrYufyj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 70F83EC0209;
	Wed, 12 Aug 2026 05:14:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 12 Aug 2026 05:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786526050;
	 x=1786612450; bh=j92WLFvbX8ATZKx21dRc7nQ9p+dHgfoHrsSnoIJdz04=; b=
	d+7xTBhXviUdtEFKVvrd0qefOSTd1EBs2upAGh6HVp25IOZL8DS97PtAhdpAHQDi
	z01RICZeoyCB18xShxPrlMXIRtyrAWJDFHbKlHs4ArKZGJqvYaWiPYGiAs0hsVdP
	Jm816jZAU0PjfOpJ5twoyjqpmwUclX1IreapDneVHk/K57QEBRFLn00QH5J2Drsk
	hWEBzFkea7T/XRyLbWty9eGMkShlrfYtcaL12uQpcLVAJ1L32byOgXhDFi7ugClr
	xRuj8ZUlQfWyTOpqhpYFyitLDnvtQdtHUSB20+dWIW2QYSMBk0NUzmuv/BvdvJZL
	qFdUyyEvYrkas99MqjYTiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786526050; x=
	1786612450; bh=j92WLFvbX8ATZKx21dRc7nQ9p+dHgfoHrsSnoIJdz04=; b=D
	BrYufyj67kj89hq0LOPLgwKDFD4BKEantaRMnlkVNxfcdQl1bb+0KcMQErKUUC0Z
	hmH3Thzv5XU9N2SVhxnvYF6dkNp10LD4OeRg99Q7XcId4lcNRnz+9yP5Zi9jYCvQ
	9euBawSh4k+0lSLhpFeJvmIzkOtVSUl/tSam4mzJTRvCcFBFwuJD5ZIytTraQqZ4
	+czWBSvOW1Qam+YwH0a3Ipxk1cCrWN5dywXyd+ZNCZB0BADlobAGSlhbKrg9KfbD
	EiWmWgiC4y4HfcUInt6RxetniHdEAJ12bmAwq7zI0xdTFhAcIfJQrdtoZsQMaC4m
	jrPaTkOjvOgEoNMg/wuuQ==
X-ME-Sender: <xms:Yjl8amxd62XIC4ilY4bGMkkXCZtN-dWOCPB_uoRZBYpAptdKfKtO5w>
    <xme:Yjl8aoRuSXsXV9zFMYBqMjbkWocGif6BpDaG96QKrgmftX7J8x1Dog5QIVgKptevF
    Vsz2pTPvMLbwsnRpCUsldx87EKArSu_aGuCHD32GkpeKmNw_efJeA>
X-ME-Received: <xmr:Yjl8al-chwWX-hHe7VFWKa8QF26L5y355WPf-9C6IdBlJAyK3NyvIOGC-o1NXI-AyqSA6rSISvuJxtl1xSPmbI8WAPVYI9NMEFaD-I3f1Q>
X-ME-Proxy-Cause: dmFkZTGlGgfLBb5kq8eRaon5LtSDU6ONXu83edgVnhlwN4EGSI3W9s7w4Q9C8S5pEUi+9E
    NMD4GVrReipSu79cachK5OfHtp4XeAkhH+4VwX2ML6A/AupDf9N3FuulNiFP+8DpU4rnbs
    wmaYYbTRH4ouycRyWkVZsvUi9fISWZXDF5Nb+TACI2p7ukr7+TpBKrdo7qbiyE3h5Y2h+Q
    2mqO6zcWlvx3v1oukJwpjOBSIppYRH1xDisYJqqtN95W9dYWKkRad+7LH2YFUYvTvqhzCa
    eX8VsulA3ZsEHqhia3iRgg7O3WwOLGr2QLNKi2iSnfeYV22qvdeOsKyLfIJU4SvI08tBFJ
    IXhPl760OtKtf5MjHqKOE8Ndb1wP2cemyyRpuWtEkHZia/K6fvEnwQ0GobqxZ6ad6FmPHo
    xRw8WFsfVh1hO32YFeqFqsMnV62Z1A2RjfEPE3+Gd8fEDKaGiAOd7ZyrBjzt4L7oNdVjNT
    cKcvFFEy9Lp7TgSnkFt6/w08Tbz4NCrGACNbnme6SYCtEXk1DLfeh1y493lhXhCJcRLL9u
    j/UQJLjZu6VqCUJUUzC36KJ087wCWXS3hdjPHtxaEVN70V4JcWPScG/+rRT0rQQ3HJ7Z+t
    3cZ5SyzNr6shDhgYL/HYApM9/f5fnKmV3m5J6hfVcKcRcbG8S055gE67cTnQ
X-ME-Proxy: <xmx:Yjl8ano3qeL1-7yt8GiIZz1KJ5UYT5V4OPOA3xoy-Q9eXQf5_hSVvA>
    <xmx:Yjl8aqm4ImSpYVJcAqQSBdTuNfXmbY4syUAw-B3YPuOZgSDfWodCXg>
    <xmx:Yjl8amJhFDw_zccL3BOvFtpcWz2_sey4FGVZEoF6vctzdNnQ6-9Z_w>
    <xmx:Yjl8anw1GIJqyG5HOCsjn9zhtqfa48zr-54SpDxynezYhvuiMTsYyw>
    <xmx:Yjl8aihPNVkEr1q3UlH5y58y1qRmIoUOdyiQZC7oftGbn_2u_LDu745V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:14:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a4804a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 09:14:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Aug 2026 11:13:57 +0200
Subject: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
In-Reply-To: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
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

