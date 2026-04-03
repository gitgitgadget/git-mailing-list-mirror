Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20136AB53
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196148; cv=none; b=OVopAnLKhMW1Yw7a5QoYr4ZcMWB2M2nicGjROnk4NE/q1Ozr5xau7a5HNE7p+C8NQL3mKI76cBmOzjonXbgJZZJjEFyyfNm/ZGTD5nFVPyAEZ/VFWfoRiJffuSA/5uTmCbcRWcZtDRZLKZl4SZA1UwVulA2EU+5nceLQAk/w/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196148; c=relaxed/simple;
	bh=TKApxwB/QDTmTAvFUzx3ku4d/Fa+JYp0/8OpKOCemwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4gKtsLsEWCqAryAV2VithauTHaeflknRSQnKfRqvyCN9lh/nuBAwDrm4h0+L0Rdr/BXnI6txD72QYL7R5goj3PN1Ly2KyuLwuxId/CT10Qqrj2Ed/9z+hsr4YEwvSQOR/MJh0iFI7v0xUkA5KycagkTN5FhvY5bf+IPVwF8oRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r8gOpFHd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pgHmGkdd; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r8gOpFHd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pgHmGkdd"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E3AD41D00064
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 03 Apr 2026 02:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196136;
	 x=1775282536; bh=STqXkSn/0TMqS7aUdlVf02P/zNybPRPCRSLGnng7VlQ=; b=
	r8gOpFHd458PaVn/82EGpfHveIQXJRO8/kTqQizK/cQx2qsBodP83Gv0zFEkKpNF
	K09e/93AP9DTECOHu6VXsblsN5HehRbo+uEld7NUw39FKozcmptBx6YCvQOcOos6
	HeIK5PTpAZbX3aA9DP0+TR0GeRsjPwnTkpdwbrRe2i8ki+FS4bzJwGYvN+AjXkKV
	b8sdcTpncg3zDvVWn+pjd6E3DiM34ZNs+NtseH3zWdes8547psbdU0MlqZ19x0Kf
	SskY+ZSnoDAOHEhF8iR9vCLa6x1CF5/kScQVkvhR3/6e0uv8fvZiuq5AC6QI+3dD
	u3UTQtfcSPXgMXUyGPxe9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196136; x=
	1775282536; bh=STqXkSn/0TMqS7aUdlVf02P/zNybPRPCRSLGnng7VlQ=; b=p
	gHmGkdd9qJux22rA7rZn1p5YeMp+1xxEa61m5pUjBCosKaw3kIOZe5dAayAMRPxW
	hkofPh/q6nD+/WINZc/U3odfRTLxNQnv3LUBY91ICi58m3Qfcjl+MT/wyjMtc0aT
	LnGqqiOed0aaGkfjD5FJhFQ2PwV1wFlmpFSG2UsIvdPWmf2YvIo+OwJN0jpiqnxX
	Giz78GZ2KcL+/yJuYoskOv0HKLRZpWwoUx1DoAzfXuJRt2CQ1MMnmerfcI5etvF/
	KroaNWYTXBbWR5F01TroJjyjMsRL5U9DKBiAlmmcg9TQyzACikfLcOdoHFIJ+XsP
	fFYY+o7MG9di/ywH97FYA==
X-ME-Sender: <xms:6FfPaRrtahIiD0vH3QpjdA5YEh7Vs-nZmXnG-WAYFP4fHCSwNOz-Hw>
    <xme:6FfPaalkJK8VeI9sEZAPuyiBlwNMtwEp2S7jU3IvIlAejDUmNLHGOSDjT4AWtEh0W
    bkvhr_wuW81akZAHnPxMPAjony1-O-MyHI7iUElQE-EXuGTxdzyYw>
X-ME-Received: <xmr:6FfPaT0d3RrSZvEzuW5Qkmx8axahYXaExegoxYmZlN8vwrOoAr6doMBz7tC5T2jO3bbRRuLTSP5z3Cdo7vdQGxxFuzDfsC01TMem1-nL75s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:6FfPaSDCG1ueNNcsJWK-fgeJ_PnHeiu-mubjzFnrSinaJzc_y-W4bA>
    <xmx:6FfPaQxd3xETqtdU7Ktz9Y_mAmAM2bB0z6sXFzlN9ZmSfGRWr1Ayhw>
    <xmx:6FfPaQlTbjp-_8LoJwl_tYV9OPh0XVTGE2xkiAOSUxXyFIwF0tvbig>
    <xmx:6FfPaVF63mjBib-tZRdBb2OWo-RjuY9d-vk7J3PC_tCbhFwqIkr-pw>
    <xmx:6FfPaZLZBLK5RdAK9HJEcmBXqeZ6NI_kNMQQi15Lwt3UB6RQkKtP8nbB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a9e79699 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:01:48 +0200
Subject: [PATCH 01/16] odb: introduce "inmemory" source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-1-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Next to our typical object database sources, each object database also
has an implicit source of "cached" objects. These cached objects only
exist in memory and some use cases:

  - They contain evergreen objects that we expect to always exist, like
    for example the empty tree.

  - They can be used to store temporary objects that we don't want to
    persist to disk.

Overall, their use is somewhat restricted though. For example, we don't
provide the ability to use it as a temporary object database source that
allows the user to write objects, but discard them after Git exists. So
while these cached objects behave almost like a source, they aren't used
as one.

This is about to change over the following commits, where we will turn
cached objects into a new "inmemory" source. This will allow us to use
it exactly the same as any other source by providing the same common
interface as the "files" source.

For now, the inmemory source only hosts the cached objects and doesn't
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
index dbf0022054..175391e6f8 100644
--- a/Makefile
+++ b/Makefile
@@ -1218,6 +1218,7 @@ LIB_OBJS += object.o
 LIB_OBJS += odb.o
 LIB_OBJS += odb/source.o
 LIB_OBJS += odb/source-files.o
+LIB_OBJS += odb/source-inmemory.o
 LIB_OBJS += odb/streaming.o
 LIB_OBJS += oid-array.o
 LIB_OBJS += oidmap.o
diff --git a/meson.build b/meson.build
index 8309942d18..8f55d2650e 100644
--- a/meson.build
+++ b/meson.build
@@ -404,6 +404,7 @@ libgit_sources = [
   'odb.c',
   'odb/source.c',
   'odb/source-files.c',
+  'odb/source-inmemory.c',
   'odb/streaming.c',
   'oid-array.c',
   'oidmap.c',
diff --git a/odb.c b/odb.c
index 9b28fe25ef..95b21e2cfd 100644
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
index 3a711f6547..3d20270a05 100644
--- a/odb.h
+++ b/odb.h
@@ -8,6 +8,7 @@
 #include "thread-utils.h"
 
 struct cached_object_entry;
+struct odb_source_inmemory;
 struct packed_git;
 struct repository;
 struct strbuf;
@@ -98,8 +99,7 @@ struct object_database {
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
index 0000000000..95477bf36d
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
+ * An inmemory source that you can write objects to that shall be made
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
+ * Cast the given object database source to the inmemory backend. This will
+ * cause a BUG in case the source doesn't use this backend.
+ */
+static inline struct odb_source_inmemory *odb_source_inmemory_downcast(struct odb_source *source)
+{
+	if (source->type != ODB_SOURCE_INMEMORY)
+		BUG("trying to downcast source of type '%d' to inmemory", source->type);
+	return container_of(source, struct odb_source_inmemory, base);
+}
+
+#endif
diff --git a/odb/source.h b/odb/source.h
index f706e0608a..cd14f9e046 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -13,6 +13,9 @@ enum odb_source_type {
 
 	/* The "files" backend that uses loose objects and packfiles. */
 	ODB_SOURCE_FILES,
+
+	/* The "inmemory" backend that stores objects in memory. */
+	ODB_SOURCE_INMEMORY,
 };
 
 struct object_id;

-- 
2.53.0.1323.g189a785ab5.dirty

