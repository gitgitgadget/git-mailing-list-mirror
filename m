Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD13B7744
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678441; cv=none; b=ui8xDwBR/kDicr8JfbgHgpAA5PyhFSQS0jeWNhCNfc6YvqFXTh18u/q+8XA10N/NNEDLYk0kWusVlxYUMTk3ZI8NRIWir/UXsiEkXp5xoGoNprV3xUGUjjksAEWf937GMK73Y6Z8tZqM3eCUD/P7AHigXfZNO/FRPa5TTEs02/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678441; c=relaxed/simple;
	bh=uFHr5AJ6k9jY85S5GERiuymEnyrNj/0JIwpiCGGieMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJ/HasTJYS5SJ/GxU74XM0fo3N7CQMdaUjEeHgvPbnSuMiE8tA0VD0kT9sT7TRExf7IrbQ4izLbsgHouApxrjpaqJQpTzT10sbCv9X9nD06FG50UWICR1ocfKRbA/wH3XWop41WRnyf9tLLRprKF5IiQKn/e8WoXgS0WOb6sAug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v2V9cVWP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A2/GcXAv; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v2V9cVWP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A2/GcXAv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD1537A0106;
	Wed, 17 Jun 2026 02:40:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 17 Jun 2026 02:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678439;
	 x=1781764839; bh=1iS7QrF8bykghb8WnT/oBQdt5RdAIC7Px0dTHELvVp0=; b=
	v2V9cVWPwqDtpWHswOBODRH4+QSDf12nj/VfeBst+SbouAZKCR2MR87cWziS27O3
	yd6Jg198cuYv5hgzfzH6RPv25P0aRm1H1ISFAo0r9M7QmUxTatkDMvc0VD4SSSZu
	EPB1p/Nb5y25AKSwNum+qHFaqLHr6a4JjDivwEt7lEfoAMxtPArjnm9vFGVwy1Sj
	js0uUjcV88mPC4zx66jsRWRNxAvb81Zsy8bubPulAHQ6Zvm+n1cJS6LenvNcnnlv
	spNe8+zv82dsg6Gi7GaaFC5L4hrpKrUZNzcgu2Ps6OJ/bNkz4+rVbRRFt7YVIBxT
	Sr/DUs8yeCQAfV6uH61NJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678439; x=
	1781764839; bh=1iS7QrF8bykghb8WnT/oBQdt5RdAIC7Px0dTHELvVp0=; b=A
	2/GcXAvH6KXMdJ7jw/EUdH/ojx5XYQRqU5KnzuRO0IayqyUoqrnYa8K/SpPTz4Nv
	3Yt34BexT9C5BNBTvVw+2xKThbDp72Y9ZMcA9//VH8wJll6vxWi1x3fLQ4yVyD3z
	+VwlnGENY/SqcheMT2jsM0r+TcrIw/bGMRJ1r+zE4t8OAz0p1+8xCSwhtnQyWnC/
	pW5f57Ft6DYlEy4R7e2Vou/K2oi8WS4Klhy+7/uGpQ0EFgcAyxukNk6QequGCzl+
	xxErFl8IYmm053ccKZHREBnOibi+YOt+ugCqs6nLHngvP5gYxQmQhr/6uBKm0JIy
	Op23vF7VBNbEwF2LJOJdw==
X-ME-Sender: <xms:Z0Eyala13KC5KpC6-SienqeweU6aia2c_MsHB0fpT0Ze7MBXVuC9sQ>
    <xme:Z0Eyaj1x_jkeqc9oF9XslWw_s-6RFBD8daiOYa8lIxWpIK1ln7o2g6gAECk7hJOEH
    75sLu9TqmzCuTlom9eerV-VmVNUonfZl7dIvYPgjPXB2AFu9QN4>
X-ME-Received: <xmr:Z0EyalUNzckqcZhRnfyxqTjSQbQtkwNo5-weWhlqQ2kIL9bSWR23AGsd_FFHED3_NEto8YwIDGT3sUuI_m3CZ522QUW7EszKA_t6OaE>
X-ME-Proxy-Cause: dmFkZTGHvTLmvS+Iy1ZM+WjHEJhe9MGc4uuGdMkRBE6FVJMMA0lTTea5mpAou1KgMz2+7P
    u+drfVb/1TyqiWXDyCi7d+Oq+At63UwU1M2fQ2wU2scmoTNReY1dz6H37hrfrHAY/vi0dW
    K+AWlqIlRPHjxo5gKo3mfrzatFxjMdiuMAHDKLgig3HNDhGZQ8rQr+yLWiUtXcPdHUcQQZ
    49Kzuv4lLh7gn1NvuIEXKvAYmGAubUnV04j0enmCgWNddfmIYLa76wPaBXIjArFa3aqUZ7
    Tc3a9zUauqT7Lv2o/GyYLgezTA/joufbSujsvRLJg7cPaYOMmCwzioHF/iE1HAaBvxC6gx
    t+9LUysw28J17UKD08RbhjUitTxOXLOqy2xCnTKsTP7qIaBfzD/yuFNCDwDB9fW29wB1yq
    m3OivXkfWRvNF3JKrjH0TaD7iEXM1+t+9gIrD3+zSM/swlnslZtSdovtxs6XFAgIo4c2y6
    5FNQnzcTBwCG3LE4TRXr2ao+Cvb9QNjGud6s80Xxq/DOF4Duu0FfBSy+M3autPfXY7XO83
    9S6oyZH89fcawulhwW5FUMWu2F9Wr6OvUb/Q6y4PDJBL7MC20lb4OY5ZGCeRYgYirjRLAI
    yQy4QN7s9W/bUz26Pg4zE1FkcGNIZqaLWxJgLUfgv1VstlNjaSV0EWO1kACw
X-ME-Proxy: <xmx:Z0EyatWObw-BSSPyCr6pqGWtqGOh26D69gM5I7ZhFQ8oVFHafdUipw>
    <xmx:Z0EyakeqkJmN0NUn_aBHEtJYTIC7z1V3K1dCXt-AjxIR-54ZBvdtPA>
    <xmx:Z0EyamXLmfFLHmoYWKUQ5JoxaCxkH8bF89xG0JYLJP9i3sFEJXuUsw>
    <xmx:Z0EyatdhJ5ALJOeEF79H9vqcaX3hD72renqVn4keWUSVYDxJjP_5Uw>
    <xmx:Z0EyalRVSqBCJaxsCm5YUdRAsl1-gXj0XDx1dg0oYkkWnU9RopX3LtrX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9e917ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:40:00 +0200
Subject: [PATCH v3 17/17] odb/source-packed: drop pointer to "files" parent
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-17-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Over the last commits we have turned the packfile store into a proper
object database source that can be used as a standalone backend. As
such, it is no longer necessary to have it coupled to the "files" parent
source.

Remove the pointer to the owning "files" source so that the "packed"
source can be used as a standalone entity.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 27 +++++++++++++--------------
 odb/source-packed.h |  7 ++++---
 packfile.c          |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index fa2e18e71b..3bc6419dd7 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -269,7 +269,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	CALLOC_ARRAY(files, 1);
 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
 	files->loose = odb_source_loose_new(odb, path, local);
-	files->packed = odb_source_packed_new(files);
+	files->packed = odb_source_packed_new(odb, path, local);
 
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index d513b3efc3..42c28fba0e 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -585,7 +585,7 @@ static void report_pack_garbage(struct string_list *list)
 }
 
 struct prepare_pack_data {
-	struct odb_source *source;
+	struct odb_source_packed *source;
 	struct string_list *garbage;
 };
 
@@ -593,15 +593,14 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 			 const char *file_name, void *_data)
 {
 	struct prepare_pack_data *data = (struct prepare_pack_data *)_data;
-	struct odb_source_files *files = odb_source_files_downcast(data->source);
 	size_t base_len = full_name_len;
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
-	    !(files->packed->midx &&
-	      midx_contains_pack(files->packed->midx, file_name))) {
+	    !(data->source->midx &&
+	      midx_contains_pack(data->source->midx, file_name))) {
 		char *trimmed_path = xstrndup(full_name, full_name_len);
-		packfile_store_load_pack(files->packed,
-					 trimmed_path, data->source->local);
+		packfile_store_load_pack(data->source,
+					 trimmed_path, data->source->base.local);
 		free(trimmed_path);
 	}
 
@@ -626,7 +625,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
 }
 
-static void prepare_packed_git_one(struct odb_source *source)
+static void prepare_packed_git_one(struct odb_source_packed *source)
 {
 	struct string_list garbage = STRING_LIST_INIT_DUP;
 	struct prepare_pack_data data = {
@@ -634,7 +633,7 @@ static void prepare_packed_git_one(struct odb_source *source)
 		.garbage = &garbage,
 	};
 
-	for_each_file_in_pack_dir(source->path, prepare_pack, &data);
+	for_each_file_in_pack_dir(source->base.path, prepare_pack, &data);
 
 	report_pack_garbage(data.garbage);
 	string_list_clear(data.garbage, 0);
@@ -675,7 +674,7 @@ void odb_source_packed_prepare(struct odb_source_packed *source)
 		return;
 
 	prepare_multi_pack_index_one(source);
-	prepare_packed_git_one(&source->files->base);
+	prepare_packed_git_one(source);
 
 	sort_packs(&source->packs.head, sort_pack);
 	for (struct packfile_list_entry *e = source->packs.head; e; e = e->next)
@@ -733,14 +732,14 @@ static void odb_source_packed_free(struct odb_source *source)
 	free(packed);
 }
 
-struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
+struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
+						const char *path,
+						bool local)
 {
 	struct odb_source_packed *packed;
 
 	CALLOC_ARRAY(packed, 1);
-	odb_source_init(&packed->base, parent->base.odb, ODB_SOURCE_PACKED,
-			parent->base.path, parent->base.local);
-	packed->files = parent;
+	odb_source_init(&packed->base, odb, ODB_SOURCE_PACKED, path, local);
 	strmap_init(&packed->packs_by_path);
 
 	packed->base.free = odb_source_packed_free;
@@ -758,7 +757,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.read_alternates = odb_source_packed_read_alternates;
 	packed->base.write_alternate = odb_source_packed_write_alternate;
 
-	if (!is_absolute_path(parent->base.path))
+	if (!is_absolute_path(path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
 
 	return packed;
diff --git a/odb/source-packed.h b/odb/source-packed.h
index 9d4796261a..88994098c1 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -10,7 +10,6 @@
  */
 struct odb_source_packed {
 	struct odb_source base;
-	struct odb_source_files *files;
 
 	/*
 	 * The list of packfiles in the order in which they have been most
@@ -66,9 +65,11 @@ struct odb_source_packed {
 
 /*
  * Allocate and initialize a new empty packfile store for the given object
- * database source.
+ * database.
  */
-struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent);
+struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
+						const char *path,
+						bool local);
 
 /*
  * Cast the given object database source to the packed backend. This will cause
diff --git a/packfile.c b/packfile.c
index a577275d4f..59cee7925d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -801,7 +801,7 @@ struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 
 	p = strmap_get(&store->packs_by_path, key.buf);
 	if (!p) {
-		p = add_packed_git(store->files->base.odb->repo, idx_path,
+		p = add_packed_git(store->base.odb->repo, idx_path,
 				   strlen(idx_path), local);
 		if (p)
 			packfile_store_add_pack(store, p);

-- 
2.55.0.rc0.786.g65d90a0328.dirty

