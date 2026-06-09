Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1443EFD31
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995088; cv=none; b=jmEnNJmcveV27Ldd+zg2F2Ne2ElPN9YiVZn98KgxXVP+5rL5W2TWUnNifnT9QtawbtprmF3iaFUq7sb9GaJFYvFD1f3Q1ViYPDozXT5+93vIW6S6tg+0qcemItlVKEWXxn+sps7OXKx7fnumiN+v+Mb09t77WnlTehytRc4Y5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995088; c=relaxed/simple;
	bh=IjOIuNC18yKPxx7XrMPbzmra+vwrbXDqlvU82cLEy7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HvFidy2qqfasHUMeU7ycMycZdWutnuwjC5CYh3sLtylfoRJGM35f4KsRStxovvxigBA+q6Nnv9dxCd5ZSMf8Ui9rEKKtqH5VWLXNVuNYkFjeTNqFbbMnU6CvcZbfVqzoomim/XrAlpr8uZjgpkR7H2Mm69IKJO84mD43zJYQKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E9zVsb8n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gwc6JVQn; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E9zVsb8n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gwc6JVQn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0EFA51D00189;
	Tue,  9 Jun 2026 04:51:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 04:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995085;
	 x=1781081485; bh=K0VDl9i07PODaYGKBldIT6HTEF7/BgwTsGpNdcnZatE=; b=
	E9zVsb8nnd7z+zhREnEIQh+foCcgUADU+0nTwFbA86evUSU+IV03FplgQn/PCXyA
	Wzc/UU/39D7tfwoI+NNrBhfboqzmkAscNRMgXmiTxpeppisPtJSmGLzyDI2efkTa
	ulQe+7ScNe6oprj3Mq5H4DpDcm0jwL1+7FSeK3xwTcrzzTOE+sHjtk2kfK47mIrD
	HtLw7lTxcinwuQsYackAAtIvaXO7FIi2K/6jnbqr47/eKNMS2FbD5taFcrJr69xD
	RLFHvA1BghdJ6eEoeCQ5hdZ5AUXJ+m4meJJArllXaJl3XLXJet01vdC8sK44B7Hp
	JlSDTHb3jiKVkpTQ9eGvqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995085; x=
	1781081485; bh=K0VDl9i07PODaYGKBldIT6HTEF7/BgwTsGpNdcnZatE=; b=G
	wc6JVQnT7866lECeBInXDCMjWKCKb30pv7dya821vPOr8fraFZPFrl4/eXrQOkVQ
	5GLfG9K3b87Z44wA7axu6CHkaCUPH93bh1j3L7siPQW6fe/Zw6A1alCk4cIE9C/3
	+9f7eVpzMC4XFHUXEgsIPlA4icWRTFx4gAooaR/0d+saAr2XDADU2gYB5/zwJRUa
	JlFf52c9CQkidib8tnjF7bRbycXuY4WoD9p/Oo7JCUa9bkbEy49o+RY4Eon7lsyg
	/nkHZucNiTHL85aHvGI8BHGrBK/rnbP0R0t4M5xEc1F1hZ4m+Mp1iQ+L2OOU/a4J
	8dh1TE9kLyOYJBL8SFSdg==
X-ME-Sender: <xms:DdQnaj2gnLGfoQ4nlsDUNOlTyNHOwKXWmA3A2PwpudCXX8wIaDoA0w>
    <xme:DdQnaoGnds5Bu8kjr9JhhoVfqgAbf2dHkbcS0yGw9fuTB6fnkBCOP_2ND08wh0Uuv
    dAJMM-ZpkWC-xR4uI1DxUDF4G5f-DLWIOk7KiErpl37VrPuJWcdwQ>
X-ME-Received: <xmr:DdQnahguOAAvadHJzeM3bj10cb0nz3j2UqLzid4aeuFIrlpmz3YFAA32HydwAOANRxuLIM2wxU5kzWQScavV3AN6aauTTVLtTxYg9qSO4G0>
X-ME-Proxy-Cause: dmFkZTGHcLQNSpLSt/NXdkOaoJkTmvj04CJZqgn+zAvtnJsraJpdZ0ddSiSTFtEp0UEZbO
    /Wl8U+7383P89z8nu4XASlnQ0kEwbP0rvN/aGyp2/lJ60oOrnWlnHeg9FJVKkfykX6zHax
    e9cZL63tpGUrA2jT5KaI4nhsaz14vnFe8cHnENfZPuPThc3Ak/Uu7FrNhe5Unv1HQX9xMJ
    pBu6IPmTnfEwyXoirtywFzr6e0eFBa9JIGgo417lo6KFvgvzWWgi3TArqhDtqUygUobbk3
    ZRlDMR7g6RGBjmfVBDf2lq2Bs7vhbVY+ufr2Ex/bUSpOg8GNJp996m8x+U/hw4z4iOXXqR
    No5OVvoXaUTcGWu8OojDKvWx5JCUoUZhRlsk/1IBMIK1xpoYzSoUKg4vGbUhmWTIqNguXS
    RhbpED77c3714dysD7aAL/ABmOJb42Pj1HHUzXGrz1HcSDgCHUSr17hWInkLXqgJ4ynZpT
    cS9BCwUzS8Y76L5lGFyt66dsXGch0c2QST56XnkgRE3pt8GBl3Obs/vZLt+z8ZEc84W71N
    ldyvVKunvz5CxYoFYyMiX4f4Ee0bMAleq0X7oVe0oKZn9TbF37RvwY90aS6Q9OyXZKN9i6
    ITwSdiaX6H2n0VLRVw0hzt3Wrlo7QoLnEQj37pCS0mUQQlzA23XaQwf0ZW4g
X-ME-Proxy: <xmx:DdQnaj95TwfgCP8uE4jcgfuz4-xRcBh8NeLkSbyuqy1MEwSZF9_hUA>
    <xmx:DdQnaoq3n9WZc699AR3gzeNMyliEAATAZQdmG-ETDyPd7Q96Gy7VbQ>
    <xmx:DdQnai8Nt_AfG36fTWgCdRCB4QiOVUqGIEH6iZJJwf6wp8Dvp5kjzw>
    <xmx:DdQnasWJsbjhpgN2OK60BRhqrOGt-_4--LUAyQ0EBIQofMFt-AxckA>
    <xmx:DdQnagmX-o0h3S98VYV4yg7ERWD1dyjHbl2xrpOewF_xvmUUHvMCBVjS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b11e9eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:51:00 +0200
Subject: [PATCH v2 07/17] odb/source-packed: wire up `reprepare()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-7-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Move the logic to prepare and reprepare the "packed" source into
"odb/source-packed.c" and wire it up as the `reprepare()` callback.

Note that "preparing" a source is not yet generic. Eventually, it would
probably make sense to turn the existing `reprepare()` callback into a
`prepare()` callback with an optional flag to force re-preparing. But
this step will be handled in a separate patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c      |   2 +-
 midx.c              |   2 +-
 odb/source-files.c  |   2 +-
 odb/source-packed.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++
 odb/source-packed.h |   9 +++
 packfile.c          | 160 +---------------------------------------------------
 packfile.h          |  17 ------
 7 files changed, 172 insertions(+), 177 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 6a09571903..8080d1bf5e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1363,7 +1363,7 @@ int cmd_grep(int argc,
 			odb_prepare_alternates(the_repository->objects);
 			for (source = the_repository->objects->sources; source; source = source->next) {
 				struct odb_source_files *files = odb_source_files_downcast(source);
-				packfile_store_prepare(files->packed);
+				odb_source_packed_prepare(files->packed);
 			}
 		}
 
diff --git a/midx.c b/midx.c
index efbfbb13f4..00bbd137b2 100644
--- a/midx.c
+++ b/midx.c
@@ -102,7 +102,7 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	packfile_store_prepare(files->packed);
+	odb_source_packed_prepare(files->packed);
 	return files->packed->midx;
 }
 
diff --git a/odb/source-files.c b/odb/source-files.c
index 9b0fa9ccdc..7b1e0ac565 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -45,7 +45,7 @@ static void odb_source_files_reprepare(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	odb_source_reprepare(&files->loose->base);
-	packfile_store_reprepare(files->packed);
+	odb_source_reprepare(&files->packed->base);
 }
 
 static int odb_source_files_read_object_info(struct odb_source *source,
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 74805be1dd..e8e2e5bb48 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -1,10 +1,166 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
+#include "dir.h"
+#include "mergesort.h"
 #include "midx.h"
 #include "odb/source-packed.h"
 #include "packfile.h"
 
+void (*report_garbage)(unsigned seen_bits, const char *path);
+
+static void report_helper(const struct string_list *list,
+			  int seen_bits, int first, int last)
+{
+	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX))
+		return;
+
+	for (; first < last; first++)
+		report_garbage(seen_bits, list->items[first].string);
+}
+
+static void report_pack_garbage(struct string_list *list)
+{
+	int baselen = -1, first = 0, seen_bits = 0;
+
+	if (!report_garbage)
+		return;
+
+	string_list_sort(list);
+
+	for (size_t i = 0; i < list->nr; i++) {
+		const char *path = list->items[i].string;
+		if (baselen != -1 &&
+		    strncmp(path, list->items[first].string, baselen)) {
+			report_helper(list, seen_bits, first, i);
+			baselen = -1;
+			seen_bits = 0;
+		}
+		if (baselen == -1) {
+			const char *dot = strrchr(path, '.');
+			if (!dot) {
+				report_garbage(PACKDIR_FILE_GARBAGE, path);
+				continue;
+			}
+			baselen = dot - path + 1;
+			first = i;
+		}
+		if (!strcmp(path + baselen, "pack"))
+			seen_bits |= 1;
+		else if (!strcmp(path + baselen, "idx"))
+			seen_bits |= 2;
+	}
+	report_helper(list, seen_bits, first, list->nr);
+}
+
+struct prepare_pack_data {
+	struct odb_source *source;
+	struct string_list *garbage;
+};
+
+static void prepare_pack(const char *full_name, size_t full_name_len,
+			 const char *file_name, void *_data)
+{
+	struct prepare_pack_data *data = (struct prepare_pack_data *)_data;
+	struct odb_source_files *files = odb_source_files_downcast(data->source);
+	size_t base_len = full_name_len;
+
+	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
+	    !(files->packed->midx &&
+	      midx_contains_pack(files->packed->midx, file_name))) {
+		char *trimmed_path = xstrndup(full_name, full_name_len);
+		packfile_store_load_pack(files->packed,
+					 trimmed_path, data->source->local);
+		free(trimmed_path);
+	}
+
+	if (!report_garbage)
+		return;
+
+	if (!strcmp(file_name, "multi-pack-index") ||
+	    !strcmp(file_name, "multi-pack-index.d"))
+		return;
+	if (starts_with(file_name, "multi-pack-index") &&
+	    (ends_with(file_name, ".bitmap") || ends_with(file_name, ".rev")))
+		return;
+	if (ends_with(file_name, ".idx") ||
+	    ends_with(file_name, ".rev") ||
+	    ends_with(file_name, ".pack") ||
+	    ends_with(file_name, ".bitmap") ||
+	    ends_with(file_name, ".keep") ||
+	    ends_with(file_name, ".promisor") ||
+	    ends_with(file_name, ".mtimes"))
+		string_list_append(data->garbage, full_name);
+	else
+		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
+}
+
+static void prepare_packed_git_one(struct odb_source *source)
+{
+	struct string_list garbage = STRING_LIST_INIT_DUP;
+	struct prepare_pack_data data = {
+		.source = source,
+		.garbage = &garbage,
+	};
+
+	for_each_file_in_pack_dir(source->path, prepare_pack, &data);
+
+	report_pack_garbage(data.garbage);
+	string_list_clear(data.garbage, 0);
+}
+
+DEFINE_LIST_SORT(static, sort_packs, struct packfile_list_entry, next);
+
+static int sort_pack(const struct packfile_list_entry *a,
+		     const struct packfile_list_entry *b)
+{
+	int st;
+
+	/*
+	 * Local packs tend to contain objects specific to our
+	 * variant of the project than remote ones.  In addition,
+	 * remote ones could be on a network mounted filesystem.
+	 * Favor local ones for these reasons.
+	 */
+	st = a->pack->pack_local - b->pack->pack_local;
+	if (st)
+		return -st;
+
+	/*
+	 * Younger packs tend to contain more recent objects,
+	 * and more recent objects tend to get accessed more
+	 * often.
+	 */
+	if (a->pack->mtime < b->pack->mtime)
+		return 1;
+	else if (a->pack->mtime == b->pack->mtime)
+		return 0;
+	return -1;
+}
+
+void odb_source_packed_prepare(struct odb_source_packed *source)
+{
+	if (source->initialized)
+		return;
+
+	prepare_multi_pack_index_one(&source->files->base);
+	prepare_packed_git_one(&source->files->base);
+
+	sort_packs(&source->packs.head, sort_pack);
+	for (struct packfile_list_entry *e = source->packs.head; e; e = e->next)
+		if (!e->next)
+			source->packs.tail = e;
+
+	source->initialized = true;
+}
+
+static void odb_source_packed_reprepare(struct odb_source *source)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	packed->initialized = false;
+	odb_source_packed_prepare(packed);
+}
+
 static void odb_source_packed_reparent(const char *name UNUSED,
 				       const char *old_cwd,
 				       const char *new_cwd,
@@ -58,6 +214,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 
 	packed->base.free = odb_source_packed_free;
 	packed->base.close = odb_source_packed_close;
+	packed->base.reprepare = odb_source_packed_reprepare;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/odb/source-packed.h b/odb/source-packed.h
index 68e64cabab..9d4796261a 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -81,4 +81,13 @@ static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_so
 	return container_of(source, struct odb_source_packed, base);
 }
 
+/*
+ * Prepare the source by loading packfiles and multi-pack indices for
+ * all alternates. This becomes a no-op if the source is already prepared.
+ *
+ * It shouldn't typically be necessary to call this function directly, as
+ * functions that access the source know to prepare it.
+ */
+void odb_source_packed_prepare(struct odb_source_packed *source);
+
 #endif
diff --git a/packfile.c b/packfile.c
index e5386145a7..65631f674f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -8,7 +8,6 @@
 #include "pack.h"
 #include "repository.h"
 #include "dir.h"
-#include "mergesort.h"
 #include "packfile.h"
 #include "delta.h"
 #include "hash-lookup.h"
@@ -812,52 +811,6 @@ struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 	return p;
 }
 
-void (*report_garbage)(unsigned seen_bits, const char *path);
-
-static void report_helper(const struct string_list *list,
-			  int seen_bits, int first, int last)
-{
-	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX))
-		return;
-
-	for (; first < last; first++)
-		report_garbage(seen_bits, list->items[first].string);
-}
-
-static void report_pack_garbage(struct string_list *list)
-{
-	int i, baselen = -1, first = 0, seen_bits = 0;
-
-	if (!report_garbage)
-		return;
-
-	string_list_sort(list);
-
-	for (i = 0; i < list->nr; i++) {
-		const char *path = list->items[i].string;
-		if (baselen != -1 &&
-		    strncmp(path, list->items[first].string, baselen)) {
-			report_helper(list, seen_bits, first, i);
-			baselen = -1;
-			seen_bits = 0;
-		}
-		if (baselen == -1) {
-			const char *dot = strrchr(path, '.');
-			if (!dot) {
-				report_garbage(PACKDIR_FILE_GARBAGE, path);
-				continue;
-			}
-			baselen = dot - path + 1;
-			first = i;
-		}
-		if (!strcmp(path + baselen, "pack"))
-			seen_bits |= 1;
-		else if (!strcmp(path + baselen, "idx"))
-			seen_bits |= 2;
-	}
-	report_helper(list, seen_bits, first, list->nr);
-}
-
 void for_each_file_in_pack_subdir(const char *objdir,
 				  const char *subdir,
 				  each_file_in_pack_dir_fn fn,
@@ -900,116 +853,9 @@ void for_each_file_in_pack_dir(const char *objdir,
 	for_each_file_in_pack_subdir(objdir, NULL, fn, data);
 }
 
-struct prepare_pack_data {
-	struct odb_source *source;
-	struct string_list *garbage;
-};
-
-static void prepare_pack(const char *full_name, size_t full_name_len,
-			 const char *file_name, void *_data)
-{
-	struct prepare_pack_data *data = (struct prepare_pack_data *)_data;
-	struct odb_source_files *files = odb_source_files_downcast(data->source);
-	size_t base_len = full_name_len;
-
-	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
-	    !(files->packed->midx &&
-	      midx_contains_pack(files->packed->midx, file_name))) {
-		char *trimmed_path = xstrndup(full_name, full_name_len);
-		packfile_store_load_pack(files->packed,
-					 trimmed_path, data->source->local);
-		free(trimmed_path);
-	}
-
-	if (!report_garbage)
-		return;
-
-	if (!strcmp(file_name, "multi-pack-index") ||
-	    !strcmp(file_name, "multi-pack-index.d"))
-		return;
-	if (starts_with(file_name, "multi-pack-index") &&
-	    (ends_with(file_name, ".bitmap") || ends_with(file_name, ".rev")))
-		return;
-	if (ends_with(file_name, ".idx") ||
-	    ends_with(file_name, ".rev") ||
-	    ends_with(file_name, ".pack") ||
-	    ends_with(file_name, ".bitmap") ||
-	    ends_with(file_name, ".keep") ||
-	    ends_with(file_name, ".promisor") ||
-	    ends_with(file_name, ".mtimes"))
-		string_list_append(data->garbage, full_name);
-	else
-		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
-}
-
-static void prepare_packed_git_one(struct odb_source *source)
-{
-	struct string_list garbage = STRING_LIST_INIT_DUP;
-	struct prepare_pack_data data = {
-		.source = source,
-		.garbage = &garbage,
-	};
-
-	for_each_file_in_pack_dir(source->path, prepare_pack, &data);
-
-	report_pack_garbage(data.garbage);
-	string_list_clear(data.garbage, 0);
-}
-
-DEFINE_LIST_SORT(static, sort_packs, struct packfile_list_entry, next);
-
-static int sort_pack(const struct packfile_list_entry *a,
-		     const struct packfile_list_entry *b)
-{
-	int st;
-
-	/*
-	 * Local packs tend to contain objects specific to our
-	 * variant of the project than remote ones.  In addition,
-	 * remote ones could be on a network mounted filesystem.
-	 * Favor local ones for these reasons.
-	 */
-	st = a->pack->pack_local - b->pack->pack_local;
-	if (st)
-		return -st;
-
-	/*
-	 * Younger packs tend to contain more recent objects,
-	 * and more recent objects tend to get accessed more
-	 * often.
-	 */
-	if (a->pack->mtime < b->pack->mtime)
-		return 1;
-	else if (a->pack->mtime == b->pack->mtime)
-		return 0;
-	return -1;
-}
-
-void packfile_store_prepare(struct odb_source_packed *store)
-{
-	if (store->initialized)
-		return;
-
-	prepare_multi_pack_index_one(&store->files->base);
-	prepare_packed_git_one(&store->files->base);
-
-	sort_packs(&store->packs.head, sort_pack);
-	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
-		if (!e->next)
-			store->packs.tail = e;
-
-	store->initialized = true;
-}
-
-void packfile_store_reprepare(struct odb_source_packed *store)
-{
-	store->initialized = false;
-	packfile_store_prepare(store);
-}
-
 struct packfile_list_entry *packfile_store_get_packs(struct odb_source_packed *store)
 {
-	packfile_store_prepare(store);
+	odb_source_packed_prepare(store);
 
 	if (store->midx) {
 		struct multi_pack_index *m = store->midx;
@@ -2083,7 +1929,7 @@ static int find_pack_entry(struct odb_source_packed *store,
 {
 	struct packfile_list_entry *l;
 
-	packfile_store_prepare(store);
+	odb_source_packed_prepare(store);
 	if (store->midx && fill_midx_entry(store->midx, oid, e))
 		return 1;
 
@@ -2130,7 +1976,7 @@ int packfile_store_read_object_info(struct odb_source_packed *store,
 	 * been added since the last time we have prepared the packfile store.
 	 */
 	if (flags & OBJECT_INFO_SECOND_READ)
-		packfile_store_reprepare(store);
+		odb_source_reprepare(&store->base);
 
 	if (!find_pack_entry(store, oid, &e))
 		return 1;
diff --git a/packfile.h b/packfile.h
index 9dc3a13112..9674e573ae 100644
--- a/packfile.h
+++ b/packfile.h
@@ -55,23 +55,6 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
-/*
- * Prepare the packfile store by loading packfiles and multi-pack indices for
- * all alternates. This becomes a no-op if the store is already prepared.
- *
- * It shouldn't typically be necessary to call this function directly, as
- * functions that access the store know to prepare it.
- */
-void packfile_store_prepare(struct odb_source_packed *store);
-
-/*
- * Clear the packfile caches and try to look up any new packfiles that have
- * appeared since last preparing the packfiles store.
- *
- * This function must be called under the `odb_read_lock()`.
- */
-void packfile_store_reprepare(struct odb_source_packed *store);
-
 /*
  * Add the pack to the store so that contained objects become accessible via
  * the store. This moves ownership into the store.

-- 
2.54.0.1136.gdb2ca164c4.dirty

