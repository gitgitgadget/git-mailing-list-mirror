Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506181AC8
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130304; cv=none; b=rJQk9wT+o6lm/1uYnijWRFkbZCBVbKFBbm8A09ARcjJttMRfkAa5l+tU+m6HVch87zhQR2CG7NepUdBqN/2wHczlgZF/zunUdjViyF1oK0d8FWtAKRnzQ34kfn+j6vKctI+pdSOAfuP5TVAumwWdUOd6ReHlAwv0OGv4yd3ODik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130304; c=relaxed/simple;
	bh=juJ5A/iY2RufRgHGN13pLErLvvIEMMqU9+2X4YJBL28=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JuCOmTQ9ZniLBmwM+tF0eIEdKZ0HvajvBerZYMp+BXZmAWGXVXGWLUD0XtdZHh3+2KzycFF9/5X2HqftXyQQkrLqzwzNZLzvm4iu0yA5buKDQ6ngk6RkXWQvv/u3Ka+8JLQpBMrm3f/JIpdND6R7PbVkpt5v0PZo0Obb5PapOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckyKpG8K; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckyKpG8K"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f1c567ae4so2719869f8f.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130301; x=1718735101; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIbDgrZZzLffzDsPZ7EVcEJznmdLDB8xTVpvzkl5Em8=;
        b=ckyKpG8KCQJz9wv1cNBRUiasMoPGm2FHRU8U6mHPrsjAa+pzjlk7UtFb9Uexh9mtJt
         v8rXzqVrwrNbq05Y73U0yP2F8GM5Xh14EXb5BxjSUurQ+UAdd0EMacjn7D+tp8MCgvro
         ALhqmnoYG3TaFA83CwFvSjR8px5rXMFJFlH7hl8DcYmBCyEOyYAf4VyOHE7xqjVfzNjt
         X7/zqU0lXXh+Fp+OP1llJdMFZRM5MCjbLiRlkrR9/ALtQ5umF+EkDgTuP+joS4jgeyEL
         PYuQhJFx527DG/Xv5b3v8uVIs0a5Wiv4kmu3fUgJMhbohy3quaEaQyx1if+V85O3RyU4
         a2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130301; x=1718735101;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIbDgrZZzLffzDsPZ7EVcEJznmdLDB8xTVpvzkl5Em8=;
        b=aHeBcLRY/So7nztZQm+u60NRq3LRNAGT+dCTUGRWi0GkbTrzvMHzEeGH13+c+YkUhk
         Oxu9+COJTGKKYm8ntnsi1ge56gVf5oNd94p7weelE/gDNA6g0nKaDFa0U1C6I/0HtMLd
         2YAq3BReuTK9gVEZSGQHIEcggd5M/TluiTTi3V2w7rSJmSptG7LStUw/RUji1KVsk40R
         j8jobDWg+1bG25tQT++RqfPbVXNIbve1+Of2v/JvplNb1p7zZz1McPnSGMddYSOzrNpW
         A3h++phXVuUAhcr2TTOY3CL46hznwOm4c3sMnpwwT13vMdk8+V5ZBFlxr8CtLFY07CTR
         cvDQ==
X-Gm-Message-State: AOJu0Ywialrct5PgHbE77eBX8oNvHPYlP+Ih1cK6yHpbiaAexBXv35N3
	1laCQtSm3PcgHBW6jUU11emBemYYVl4kFxdMQq8ym+7CWz+ENTJky0kxGQ==
X-Google-Smtp-Source: AGHT+IHGs0ag/KRifTEUft8rRrCTklG+krgc5+4mvBNtK/61u3IIz3Y3DiQuC4rlo2WEl11vaS0iqg==
X-Received: by 2002:a5d:4644:0:b0:35f:1522:10b1 with SMTP id ffacd0b85a97d-35f1522121cmr6567511f8f.52.1718130301263;
        Tue, 11 Jun 2024 11:25:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2169fc45sm7016616f8f.10.2024.06.11.11.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:25:00 -0700 (PDT)
Message-Id: <68acdd3c5ee266fd0c1d3ae45f69af4ef9012e07.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:45 +0000
Subject: [PATCH 13/16] mktree: add directory-file conflict hashmap
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

Create a hashmap member of a 'struct tree_entry_array' that contains all of
the (de-duplicated) provided tree entries, indexed by the hash of their path
with *no* trailing slash. This hashmap will be used in a later commit to
avoid adding a file to an existing tree that has the same path as a
directory, or vice versa.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index bee359e9978..09b3c5c6244 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -16,6 +16,8 @@
 #include "object-store-ll.h"
 
 struct tree_entry {
+	struct hashmap_entry ent;
+
 	/* Internal */
 	size_t order;
 
@@ -33,8 +35,33 @@ static inline size_t df_path_len(size_t pathlen, unsigned int mode)
 struct tree_entry_array {
 	size_t nr, alloc;
 	struct tree_entry **entries;
+
+	struct hashmap df_name_hash;
 };
 
+static int df_name_hash_cmp(const void *cmp_data UNUSED,
+			    const struct hashmap_entry *eptr,
+			    const struct hashmap_entry *entry_or_key,
+			    const void *keydata UNUSED)
+{
+	const struct tree_entry *e1, *e2;
+	size_t e1_len, e2_len;
+
+	e1 = container_of(eptr, const struct tree_entry, ent);
+	e2 = container_of(entry_or_key, const struct tree_entry, ent);
+
+	e1_len = df_path_len(e1->len, e1->mode);
+	e2_len = df_path_len(e2->len, e2->mode);
+
+	return e1_len != e2_len ||
+	       name_compare(e1->name, e1_len, e2->name, e2_len);
+}
+
+static void init_tree_entry_array(struct tree_entry_array *arr)
+{
+	hashmap_init(&arr->df_name_hash, df_name_hash_cmp, NULL, 0);
+}
+
 static void tree_entry_array_push(struct tree_entry_array *arr, struct tree_entry *ent)
 {
 	ALLOC_GROW(arr->entries, arr->nr + 1, arr->alloc);
@@ -43,6 +70,7 @@ static void tree_entry_array_push(struct tree_entry_array *arr, struct tree_entr
 
 static void clear_tree_entry_array(struct tree_entry_array *arr)
 {
+	hashmap_clear(&arr->df_name_hash);
 	for (size_t i = 0; i < arr->nr; i++)
 		FREE_AND_NULL(arr->entries[i]);
 	arr->nr = 0;
@@ -50,6 +78,7 @@ static void clear_tree_entry_array(struct tree_entry_array *arr)
 
 static void release_tree_entry_array(struct tree_entry_array *arr)
 {
+	hashmap_clear(&arr->df_name_hash);
 	FREE_AND_NULL(arr->entries);
 	arr->nr = arr->alloc = 0;
 }
@@ -135,6 +164,14 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
 	/* Sort again to order the entries for tree insertion */
 	ignore_mode = 0;
 	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
+
+	/* Finally, initialize the directory-file conflict hash map */
+	for (size_t i = 0; i < count; i++) {
+		struct tree_entry *curr = arr->entries[i];
+		hashmap_entry_init(&curr->ent,
+				   memhash(curr->name, df_path_len(curr->len, curr->mode)));
+		hashmap_put(&arr->df_name_hash, &curr->ent);
+	}
 }
 
 struct tree_entry_iterator {
@@ -302,6 +339,8 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 
 	ac = parse_options(ac, av, prefix, option, mktree_usage, 0);
 
+	init_tree_entry_array(&arr);
+
 	do {
 		ret = read_index_info(nul_term_line, mktree_line, &mktree_line_data);
 		if (ret < 0)
-- 
gitgitgadget

