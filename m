Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD57E57C
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130303; cv=none; b=BbGNpU61oKjkoVMZHKZuNB5a6S7RuVH5v6JgbVWeZI1yWqTmgCCTAtT2GF3UTnH/1ZPGi4MaRElTiucCEoyOmjj+wClBD2y5SX8/3biDtChS563FwOgnNjI1ey3oR6NHAkeYq68tK6A8uKCDykxM3eNiJ4+BKFRXOoSdK4T+KQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130303; c=relaxed/simple;
	bh=GA/uYGCuc3dtJWd4YJAb9SnH9EG9gKAMvHkIu0762qc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XStrgn4lusQ3kk9AHU/cq8AzOVHWEC1E/Ksg5x0H3TqJy4amGnn+dw/LC8Zn4P3LnwrpC54v48b41VXxHRFdDvK8rKi00P4kmybL0I9iA2OoGyBCD3tCO+TxLnTJzrfwDD9oHHFG+6Uk8hIC0+YnYoz/1/QpxPjlJLid2C232C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8h1i88v; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8h1i88v"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35f06861ae6so3652209f8f.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130299; x=1718735099; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMNUmGFaG7R8EPEWmcuiLS+3zud0y74cveu4YNpA5Bs=;
        b=H8h1i88vhcKMP5bnXIKR9D7fc5KZL1y/JMapxdTXkQvcrJW+IVc6zI0Edx9ItiMO+y
         GXnwunI2bXPS9CFaYRTCwYV0ThO3KW/sUR7GFnZ5r4zC86knglVmMWBbNf7xMl1eMppE
         FxG2rqBhXF2DJzH0qE86euXBL6uYhhoC6gCuKVveJ+yjGjt9X/Vv4ExUZnUxft0rw0IC
         qymOySHnOcvV+LWeLJfCWvCmhUQxq5fJdrJJU+461Cy3afH70JiwmqHIrqXX2DiSq1RT
         WV+4BDAfR0R8wU7ZOXicKQh9FNm75O9/XXyvTw7P2Gy7YaXnrSlZpqVbKx49cTKm8R7t
         5KAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130299; x=1718735099;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMNUmGFaG7R8EPEWmcuiLS+3zud0y74cveu4YNpA5Bs=;
        b=SjL+bj9ilTrUIKDycrBxi1gVyQ6/eRoriBzpfIN+SbpGV+BPUx37F5cyplvHoHh0sP
         yBedOLNqz1emFy5RXj1h1UpmltIfZ9U/4jewXTtDFxfAwhvsG2CjJgpMZ9tg23hF6UzW
         t83yuLR5WKRf7jVJUcjsX4N4j/gGx+2QzcRkD5hGdNqEDDxPfgeGjOuYYRG/CpFL7FCW
         3u5DNK4cKm09njOO4Z+aFnMXNGnpJv8a0QcFRmzlm3eqADRtckIfbbVE9BV695O+Ninh
         AncsCBGs4HjRkOpYju/n9oth8micTEesjoiqpqGnblOCtMpSofPcsLBMLyU7GqrbWJmZ
         2tqw==
X-Gm-Message-State: AOJu0YxA9SwrNzgXecyHzHZ2cBDojY6DYWI3WomXscbs6wMSLJhBWyg0
	yoWj21sXQxji17Tx5M2q8XDHoC2sCVvnB6kfjgu7lho6g8eNd4ZCwCgDOw==
X-Google-Smtp-Source: AGHT+IFWfKO8YAlDsxt2sTKMgEFoXnU17tk198qGmRMnp40Dpsxl+VtYxmPBBNxBTIGQMFFgd039+Q==
X-Received: by 2002:a05:6000:1f83:b0:35f:283e:9504 with SMTP id ffacd0b85a97d-35f283e9617mr4679397f8f.42.1718130299548;
        Tue, 11 Jun 2024 11:24:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0f996ee3sm10446988f8f.71.2024.06.11.11.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:58 -0700 (PDT)
Message-Id: <130413f2404bb27a2ede4fb00041227c90587e8e.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:43 +0000
Subject: [PATCH 11/16] mktree: create tree using an in-core index
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Rather than manually write out the contents of a tree object file, construct
an in-memory sparse index from the provided tree entries and create the tree
by writing out its corresponding cache tree.

This patch does not change the behavior of the 'mktree' command. However,
constructing the tree this way will substantially simplify future extensions
to the command's functionality, including handling deeper-than-toplevel tree
entries and applying the provided entries to an existing tree.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c | 74 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 19 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index e9e2134136f..12f68187221 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -4,6 +4,7 @@
  * Copyright (c) Junio C Hamano, 2006, 2009
  */
 #include "builtin.h"
+#include "cache-tree.h"
 #include "gettext.h"
 #include "hex.h"
 #include "index-info.h"
@@ -24,6 +25,11 @@ struct tree_entry {
 	char name[FLEX_ARRAY];
 };
 
+static inline size_t df_path_len(size_t pathlen, unsigned int mode)
+{
+	return S_ISDIR(mode) ? pathlen - 1 : pathlen;
+}
+
 struct tree_entry_array {
 	size_t nr, alloc;
 	struct tree_entry **entries;
@@ -57,17 +63,25 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
 	if (literally) {
 		FLEX_ALLOC_MEM(ent, name, path, len);
 	} else {
+		size_t len_to_copy = len;
+
 		/* Normalize and validate entry path */
 		if (S_ISDIR(mode)) {
-			while(len > 0 && is_dir_sep(path[len - 1]))
-				len--;
+			while(len_to_copy > 0 && is_dir_sep(path[len_to_copy - 1]))
+				len_to_copy--;
+			len = len_to_copy + 1; /* add space for trailing slash */
 		}
-		FLEX_ALLOC_MEM(ent, name, path, len);
+		ent = xcalloc(1, st_add3(sizeof(struct tree_entry), len, 1));
+		memcpy(ent->name, path, len_to_copy);
 
 		if (!verify_path(ent->name, mode))
 			die(_("invalid path '%s'"), path);
 		if (strchr(ent->name, '/'))
 			die("path %s contains slash", path);
+
+		/* Add trailing slash to dir */
+		if (S_ISDIR(mode))
+			ent->name[len - 1] = '/';
 	}
 
 	ent->mode = mode;
@@ -86,11 +100,14 @@ static int ent_compare(const void *a_, const void *b_, void *ctx)
 	struct tree_entry *b = *(struct tree_entry **)b_;
 	int ignore_mode = *((int *)ctx);
 
-	if (ignore_mode)
-		cmp = name_compare(a->name, a->len, b->name, b->len);
-	else
-		cmp = base_name_compare(a->name, a->len, a->mode,
-					b->name, b->len, b->mode);
+	size_t a_len = a->len, b_len = b->len;
+
+	if (ignore_mode) {
+		a_len = df_path_len(a_len, a->mode);
+		b_len = df_path_len(b_len, b->mode);
+	}
+
+	cmp = name_compare(a->name, a_len, b->name, b_len);
 	return cmp ? cmp : b->order - a->order;
 }
 
@@ -106,8 +123,8 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
 	for (size_t i = 0; i < count; i++) {
 		struct tree_entry *curr = arr->entries[i];
 		if (prev &&
-		    !name_compare(prev->name, prev->len,
-				  curr->name, curr->len)) {
+		    !name_compare(prev->name, df_path_len(prev->len, prev->mode),
+				  curr->name, df_path_len(curr->len, curr->mode))) {
 			FREE_AND_NULL(curr);
 		} else {
 			arr->entries[arr->nr++] = curr;
@@ -120,24 +137,43 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
 	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
 }
 
+static int add_tree_entry_to_index(struct index_state *istate,
+				   struct tree_entry *ent)
+{
+	struct cache_entry *ce;
+	struct strbuf ce_name = STRBUF_INIT;
+	strbuf_add(&ce_name, ent->name, ent->len);
+
+	ce = make_cache_entry(istate, ent->mode, &ent->oid, ent->name, 0, 0);
+	if (!ce)
+		return error(_("make_cache_entry failed for path '%s'"), ent->name);
+
+	add_index_entry(istate, ce, ADD_CACHE_JUST_APPEND);
+	strbuf_release(&ce_name);
+	return 0;
+}
+
 static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
 {
-	struct strbuf buf;
-	size_t size = 0;
+	struct index_state istate = INDEX_STATE_INIT(the_repository);
+	istate.sparse_index = 1;
 
 	sort_and_dedup_tree_entry_array(arr);
-	for (size_t i = 0; i < arr->nr; i++)
-		size += 32 + arr->entries[i]->len;
 
-	strbuf_init(&buf, size);
+	/* Construct an in-memory index from the provided entries */
 	for (size_t i = 0; i < arr->nr; i++) {
 		struct tree_entry *ent = arr->entries[i];
-		strbuf_addf(&buf, "%o %s%c", ent->mode, ent->name, '\0');
-		strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
+
+		if (add_tree_entry_to_index(&istate, ent))
+			die(_("failed to add tree entry '%s'"), ent->name);
 	}
 
-	write_object_file(buf.buf, buf.len, OBJ_TREE, oid);
-	strbuf_release(&buf);
+	/* Write out new tree */
+	if (cache_tree_update(&istate, WRITE_TREE_SILENT | WRITE_TREE_MISSING_OK))
+		die(_("failed to write tree"));
+	oidcpy(oid, &istate.cache_tree->oid);
+
+	release_index(&istate);
 }
 
 static void write_tree_literally(struct tree_entry_array *arr,
-- 
gitgitgadget

