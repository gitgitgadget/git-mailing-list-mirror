Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934818A93F
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823173; cv=none; b=uUNc6BIcYdiORiaAUIKpx5bIt+sHrvGjEIg4q954XFbQea5yAwGqQBqPklojFfFT6jFGsalLVBLrzyQC5HORFJwWzb5CDhb2+KL6B48yHVB0Qoy9js8jUvx3vMVTPkm3M3rApGzEZorsOyQhXrT7D7Dekmn5yTdLtlZN9ZxKH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823173; c=relaxed/simple;
	bh=hRI0A6nwjxJY9h3o2daGE3kVYvHnscFiw/M/53oGt/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hq4l9ixpk/i80Ro3KKxt/3KmLuVdBLluAd3MVM9qi7/7cmz8BHagcrBcwMbsmBAD5n7llwe/MNxW7ddiL0PuNdWexazXIYu9QLonXK+9i7h9L7gTHyo9FkER13nnNQHvhhfiPIYsYZy57u+bVwpRuugXuTcpzbT/edQYBW6+fF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GaDv9Mce; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UUeAvKS+; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GaDv9Mce";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UUeAvKS+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4EB6C1D001C3;
	Fri, 10 Apr 2026 08:12:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 10 Apr 2026 08:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823171;
	 x=1775909571; bh=ZLFDtleQFgxA4Un4yZzb4FItcd5MiGqs9xronVvePy0=; b=
	GaDv9Mcefb6kHHeQ9LaZ8VHl1l9/Z3QkCWUaAL5fWHN5QFST553rgcovuF3yloBs
	MGiCPZcWVTvLx0k/nD+Z1Cyix9N89bsF3NVEPdDjxc4sKCUqULIMPkRNiQfO9tWE
	BLE82LxQ9sNdHmeWMG7hJSd1kqFHJUc9je7ZQ6aeLdFVTNbdGlCyGL5Qi/ujBgMM
	gQ6xomD+e6llAY/aQFbLpw/gbBVeDnYNGOTcIfOiKVVy/hCPk8XYX/tN22pQoHFB
	oKI9YfQWYEY9pWW1TqBmQyYoJYUa8xRolEl+sKUsG1AlaOUUGSZzkPplm3As7isN
	fMJjqOJpfJtQJXJEkgRBFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823171; x=
	1775909571; bh=ZLFDtleQFgxA4Un4yZzb4FItcd5MiGqs9xronVvePy0=; b=U
	UeAvKS+PgfGqbz6afHPvrvQxzywakm1Q5Eyi5MkcfzzTUA5vzRoaVHdcH6Fzxfgn
	C8/T6dNrcOLlmhHHcTCUjrpasgkqFko2BUcsYEdjlB5VLRncsE/Dr3qDqLH4vu4P
	GRPhc5wWHj1+XXjHPc79oK3Zq1C2iYeKq/NZE+wWDR7BI4011O1jIWsNwBIpqLod
	QSLTxA/9Q0qL/wWTOWKnCFzfmwff6+d9m60/Syd8ypjp6OocUFK/pNPKfDSyNS0V
	CE71HW4vKSb6yksrS2g8j7sDhVHwjTV0wkRtMupEszm3XtkypQ2mti51DOYYiZpJ
	t6ZVn8U0XKKc42u+sK+fg==
X-ME-Sender: <xms:Q-nYafxmYhdVGRxHUQDNBsYothBMc8quRU1-QkL8Qsxxs6viT1Q2Fw>
    <xme:Q-nYaes4joe9_cVgMM364QV3ys9bADIl11jdOkHG-9vyrUeHaQrLgK1-ZZLH6jQQY
    nxPGo-1thxhdvpFH_U32x4BwAudIJOWtwm-hb3_X4_KZXa9PCda>
X-ME-Received: <xmr:Q-nYaWtm0_XyJugOnw-IagNkMSFyBIay4w6i6mM_N-pZr3Ggbtd9L25Wf01PawLslKZKwLNd_RloJdCHavTGoS1Hukdx9Im7zvT0Ip6OcbICTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:Q-nYaTNBdbZ4XngtWJVMAPbfXMuiLcfXWXGktNOwRk79VxqnKn8DWA>
    <xmx:Q-nYaU0Q5se-oRfSYW474IJJ8VsAHsqDe0KO8Guqf2-gQjjPeVSkNA>
    <xmx:Q-nYafOfJ6cdUax8pf8AwQlzyHempmydMEbZixXIV1FGBtNwWgrI3w>
    <xmx:Q-nYaU12amEQ0l7wfA-E03rf_DaGnGxerzrr3iePRUAfLapfddZ96A>
    <xmx:Q-nYaesWmUKQbEpme38-P-MJSzYVWo7hgh3Mt6ICWjdNMfaFzm-qeIJm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:12:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50dedd4c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:12:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:31 +0200
Subject: [PATCH v3 01/17] odb: introduce "in-memory" source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-1-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Next to our typical object database sources, each object database also
has an implicit source of "cached" objects. These cached objects only
exist in memory and some use cases:

  - They contain evergreen objects that we expect to always exist, like
    for example the empty tree.

  - They can be used to store temporary objects that we don't want to
    persist to disk, which is used by git-blame(1) to create a fake
    worktree commit.

Overall, their use is somewhat restricted though. For example, we don't
provide the ability to use it as a temporary object database source that
allows the user to write objects, but discard them after Git exists. So
while these cached objects behave almost like a source, they aren't used
as one.

This is about to change over the following commits, where we will turn
cached objects into a new "in-memory" source. This will allow us to use
it exactly the same as any other source by providing the same common
interface as the "files" source.

For now, the in-memory source only hosts the cached objects and doesn't
provide any logic yet. This will change with subsequent commits, where
we move respective functionality into the source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile              |  1 +
 meson.build           |  1 +
 odb.c                 | 21 +++++++++++++--------
 odb.h                 |  4 ++--
 odb/source-inmemory.c | 12 ++++++++++++
 odb/source-inmemory.h | 35 +++++++++++++++++++++++++++++++++++
 odb/source.h          |  3 +++
 7 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 22a8993482..3cda12c455 100644
--- a/Makefile
+++ b/Makefile
@@ -1218,6 +1218,7 @@ LIB_OBJS += object.o
 LIB_OBJS += odb.o
 LIB_OBJS += odb/source.o
 LIB_OBJS += odb/source-files.o
+LIB_OBJS += odb/source-inmemory.o
 LIB_OBJS += odb/streaming.o
 LIB_OBJS += odb/transaction.o
 LIB_OBJS += oid-array.o
diff --git a/meson.build b/meson.build
index 6dc23b3af2..ffa73ce7ce 100644
--- a/meson.build
+++ b/meson.build
@@ -404,6 +404,7 @@ libgit_sources = [
   'odb.c',
   'odb/source.c',
   'odb/source-files.c',
+  'odb/source-inmemory.c',
   'odb/streaming.c',
   'odb/transaction.c',
   'oid-array.c',
diff --git a/odb.c b/odb.c
index 40a5e9c4e0..60e1eead25 100644
--- a/odb.c
+++ b/odb.c
@@ -14,6 +14,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
+#include "odb/source-inmemory.h"
 #include "packfile.h"
 #include "path.h"
 #include "promisor-remote.h"
@@ -53,9 +54,9 @@ static const struct cached_object *find_cached_object(struct object_database *ob
 		.type = OBJ_TREE,
 		.buf = "",
 	};
-	const struct cached_object_entry *co = object_store->cached_objects;
+	const struct cached_object_entry *co = object_store->inmemory_objects->objects;
 
-	for (size_t i = 0; i < object_store->cached_object_nr; i++, co++)
+	for (size_t i = 0; i < object_store->inmemory_objects->objects_nr; i++, co++)
 		if (oideq(&co->oid, oid))
 			return &co->value;
 
@@ -792,9 +793,10 @@ int odb_pretend_object(struct object_database *odb,
 	    find_cached_object(odb, oid))
 		return 0;
 
-	ALLOC_GROW(odb->cached_objects,
-		   odb->cached_object_nr + 1, odb->cached_object_alloc);
-	co = &odb->cached_objects[odb->cached_object_nr++];
+	ALLOC_GROW(odb->inmemory_objects->objects,
+		   odb->inmemory_objects->objects_nr + 1,
+		   odb->inmemory_objects->objects_alloc);
+	co = &odb->inmemory_objects->objects[odb->inmemory_objects->objects_nr++];
 	co->value.size = len;
 	co->value.type = type;
 	co_buf = xmalloc(len);
@@ -1083,6 +1085,7 @@ struct object_database *odb_new(struct repository *repo,
 	o->sources = odb_source_new(o, primary_source, true);
 	o->sources_tail = &o->sources->next;
 	o->alternate_db = xstrdup_or_null(secondary_sources);
+	o->inmemory_objects = odb_source_inmemory_new(o);
 
 	free(to_free);
 
@@ -1123,9 +1126,11 @@ void odb_free(struct object_database *o)
 	odb_close(o);
 	odb_free_sources(o);
 
-	for (size_t i = 0; i < o->cached_object_nr; i++)
-		free((char *) o->cached_objects[i].value.buf);
-	free(o->cached_objects);
+	for (size_t i = 0; i < o->inmemory_objects->objects_nr; i++)
+		free((char *) o->inmemory_objects->objects[i].value.buf);
+	free(o->inmemory_objects->objects);
+	free(o->inmemory_objects->base.path);
+	free(o->inmemory_objects);
 
 	string_list_clear(&o->submodule_source_paths, 0);
 
diff --git a/odb.h b/odb.h
index 9eb8355aca..c3a7edf9c8 100644
--- a/odb.h
+++ b/odb.h
@@ -8,6 +8,7 @@
 #include "thread-utils.h"
 
 struct cached_object_entry;
+struct odb_source_inmemory;
 struct packed_git;
 struct repository;
 struct strbuf;
@@ -80,8 +81,7 @@ struct object_database {
 	 * to write them into the object store (e.g. a browse-only
 	 * application).
 	 */
-	struct cached_object_entry *cached_objects;
-	size_t cached_object_nr, cached_object_alloc;
+	struct odb_source_inmemory *inmemory_objects;
 
 	/*
 	 * A fast, rough count of the number of objects in the repository.
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
new file mode 100644
index 0000000000..c7ac5c24f0
--- /dev/null
+++ b/odb/source-inmemory.c
@@ -0,0 +1,12 @@
+#include "git-compat-util.h"
+#include "odb/source-inmemory.h"
+
+struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
+{
+	struct odb_source_inmemory *source;
+
+	CALLOC_ARRAY(source, 1);
+	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source", false);
+
+	return source;
+}
diff --git a/odb/source-inmemory.h b/odb/source-inmemory.h
new file mode 100644
index 0000000000..15db068ef7
--- /dev/null
+++ b/odb/source-inmemory.h
@@ -0,0 +1,35 @@
+#ifndef ODB_SOURCE_INMEMORY_H
+#define ODB_SOURCE_INMEMORY_H
+
+#include "odb/source.h"
+
+struct cached_object_entry;
+
+/*
+ * An in-memory source that you can write objects to that shall be made
+ * available for reading, but that shouldn't ever be persisted to disk. Note
+ * that any objects written to this source will be stored in memory, so the
+ * number of objects you can store is limited by available system memory.
+ */
+struct odb_source_inmemory {
+	struct odb_source base;
+
+	struct cached_object_entry *objects;
+	size_t objects_nr, objects_alloc;
+};
+
+/* Create a new in-memory object database source. */
+struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb);
+
+/*
+ * Cast the given object database source to the in-memory backend. This will
+ * cause a BUG in case the source doesn't use this backend.
+ */
+static inline struct odb_source_inmemory *odb_source_inmemory_downcast(struct odb_source *source)
+{
+	if (source->type != ODB_SOURCE_INMEMORY)
+		BUG("trying to downcast source of type '%d' to in-memory", source->type);
+	return container_of(source, struct odb_source_inmemory, base);
+}
+
+#endif
diff --git a/odb/source.h b/odb/source.h
index f706e0608a..0a440884e4 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -13,6 +13,9 @@ enum odb_source_type {
 
 	/* The "files" backend that uses loose objects and packfiles. */
 	ODB_SOURCE_FILES,
+
+	/* The "in-memory" backend that stores objects in memory. */
+	ODB_SOURCE_INMEMORY,
 };
 
 struct object_id;

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

