Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5115A847
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834296; cv=none; b=ZWtEbOqtzezf/If5aaESVqL3KjOfaa3n+6k7EboETfOvKBtylSsY8c2VvY9xtKxZuoHKI6TWeQwVKQFZf1NBn10mT1BB2j3nfsQPTs6YmMLnqVIaZ8QvggaCYVXYUqq5/sLCD+wdM2wpVsYmhgLESPo19IdUr5FKQal9iSDwKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834296; c=relaxed/simple;
	bh=SvYQSH/EaKm+pcs76/PgNXOq55sTuVEqtsHHZqJTFMI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dPUBMsYYlMI8TVx+wBFRpFj6TZGx3ijuLNl/e+TRwghPQS4jLSoGpy9H87JMYKP8lL0Qz2VqPsCEzrGWL4+TvAMgBcX77sIvIctjlmfq+D2ZfAYFRHMdIA3r/oBFoaDW/ugYYao0s0qbMJUOEgjpSTExhV1o9x8w80TGdEracDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXe4ZdFH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXe4ZdFH"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-421d32fda86so3707335e9.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834292; x=1719439092; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W92hMv9JILmp1Imgm9S/wJe3H8FySBjdrj82quv+BOo=;
        b=PXe4ZdFHefe+iX3p8LiUzxIMyjCZjvnKn/OwUJi8zaaDFkirRa/Qy74+TbC32H4itB
         F2e6E+98iQCKMO7H9EHWlp3HQLI5j4xJNCc5R6GfZdDqmqK9JMnyDch2VOzDZ+CAOOV8
         bCKxX7DBNUwHAYk/vHP41kJ1Ag0wIVn9hgaqXgZNiZIrK8HYGbdaQz+hFE79lNJbVHmj
         kHU118BuzUQQFPoQ+cnWkMtu5H3wpfiLl8xGt5numQ8+tFoDTBYABrPa9OtYtYBC+HCK
         0d4RfsBkrAidBo98LfgFghaNHoKtOSzMxS5vBujz8X8N+UnfKxICLdE/YNUw9eDXtuU6
         U38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834292; x=1719439092;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W92hMv9JILmp1Imgm9S/wJe3H8FySBjdrj82quv+BOo=;
        b=C4Q3katGn/GfKb/j8Md/fjn9Yh7rjXjojScxfbkxR/Z7m963JjHZHp1aYKi0AYHRE4
         njhkNB6nHi1GQ/kHcY2SE/B6+MiI1Ntr7wDcPXTxIa18u7zDAmCwRH0TXQfFYC+Fd24b
         OGtaCnukghBUS7GduFfMxQpCYamw2pvoi6N/PGYXQIV+pKO+bSNxfnBlV2g4PeZMfSEI
         5hYkLuXCOTNHfI7ZLdp+i5r/7DLge4Yf5VEEMhKC9UbaYaeESWlNkqQT04VieXb8+JGD
         eEnaiSetZKjLE0+98kCepoVPRhupzI70dHut+CfU6R/QKR+uRYxsyBrhDiDNQgaShEun
         +iNw==
X-Gm-Message-State: AOJu0YxH6l7fvLcE+O7njI+VTGWlZDKCe9rIml89oZDIJu8P2nyZAyiM
	w4F1MYYhPZ/hwzCGOHruwlYONRxphnjwPPBxPdU8zRo/x9w62kgaHo9QNw==
X-Google-Smtp-Source: AGHT+IFXw6baQyFQgoyJWfq9vKFBOSAbFWJ5eZROSYvMjPKqgL8ft/Egz2RjnPdOd6+dhZutfrrdoQ==
X-Received: by 2002:a7b:ce8c:0:b0:421:f04d:ebcc with SMTP id 5b1f17b1804b1-42475182d11mr32615545e9.24.1718834291804;
        Wed, 19 Jun 2024 14:58:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247101aac6sm47309945e9.0.2024.06.19.14.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:10 -0700 (PDT)
Message-Id: <d0d5523a32b2f56f48772367651eba3d52d16c35.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:57:51 +0000
Subject: [PATCH v2 03/17] mktree: use non-static tree_entry array
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Replace the static 'struct tree_entry **entries' with a non-static 'struct
tree_entry_array' instance. In later commits, we'll want to be able to
create additional 'struct tree_entry_array' instances utilizing common
functionality (create, push, clear, free). To avoid code duplication, create
the 'struct tree_entry_array' type and add functions that perform those
basic operations.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c | 69 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index c02feb06aff..a96ea10bf95 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -12,15 +12,42 @@
 #include "parse-options.h"
 #include "object-store-ll.h"
 
-static struct tree_entry {
+struct tree_entry {
 	unsigned mode;
 	struct object_id oid;
 	int len;
 	char name[FLEX_ARRAY];
-} **entries;
-static int alloc, used;
+};
+
+struct tree_entry_array {
+	size_t nr, alloc;
+	struct tree_entry **entries;
+};
+
+static void tree_entry_array_push(struct tree_entry_array *arr, struct tree_entry *ent)
+{
+	ALLOC_GROW(arr->entries, arr->nr + 1, arr->alloc);
+	arr->entries[arr->nr++] = ent;
+}
+
+static void tree_entry_array_clear(struct tree_entry_array *arr, int free_entries)
+{
+	if (free_entries) {
+		for (size_t i = 0; i < arr->nr; i++)
+			FREE_AND_NULL(arr->entries[i]);
+	}
+	arr->nr = 0;
+}
 
-static void append_to_tree(unsigned mode, struct object_id *oid, char *path)
+static void tree_entry_array_release(struct tree_entry_array *arr, int free_entries)
+{
+	tree_entry_array_clear(arr, free_entries);
+	FREE_AND_NULL(arr->entries);
+	arr->alloc = 0;
+}
+
+static void append_to_tree(unsigned mode, struct object_id *oid, const char *path,
+			   struct tree_entry_array *arr)
 {
 	struct tree_entry *ent;
 	size_t len = strlen(path);
@@ -32,8 +59,7 @@ static void append_to_tree(unsigned mode, struct object_id *oid, char *path)
 	ent->len = len;
 	oidcpy(&ent->oid, oid);
 
-	ALLOC_GROW(entries, used + 1, alloc);
-	entries[used++] = ent;
+	tree_entry_array_push(arr, ent);
 }
 
 static int ent_compare(const void *a_, const void *b_)
@@ -44,19 +70,18 @@ static int ent_compare(const void *a_, const void *b_)
 				 b->name, b->len, b->mode);
 }
 
-static void write_tree(struct object_id *oid)
+static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
 {
 	struct strbuf buf;
-	size_t size;
-	int i;
+	size_t size = 0;
 
-	QSORT(entries, used, ent_compare);
-	for (size = i = 0; i < used; i++)
-		size += 32 + entries[i]->len;
+	QSORT(arr->entries, arr->nr, ent_compare);
+	for (size_t i = 0; i < arr->nr; i++)
+		size += 32 + arr->entries[i]->len;
 
 	strbuf_init(&buf, size);
-	for (i = 0; i < used; i++) {
-		struct tree_entry *ent = entries[i];
+	for (size_t i = 0; i < arr->nr; i++) {
+		struct tree_entry *ent = arr->entries[i];
 		strbuf_addf(&buf, "%o %s%c", ent->mode, ent->name, '\0');
 		strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
 	}
@@ -70,7 +95,8 @@ static const char *mktree_usage[] = {
 	NULL
 };
 
-static void mktree_line(char *buf, int nul_term_line, int allow_missing)
+static void mktree_line(char *buf, int nul_term_line, int allow_missing,
+			struct tree_entry_array *arr)
 {
 	char *ptr, *ntr;
 	const char *p;
@@ -146,7 +172,7 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 		}
 	}
 
-	append_to_tree(mode, &oid, path);
+	append_to_tree(mode, &oid, path, arr);
 	free(to_free);
 }
 
@@ -158,6 +184,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 	int allow_missing = 0;
 	int is_batch_mode = 0;
 	int got_eof = 0;
+	struct tree_entry_array arr = { 0 };
 	strbuf_getline_fn getline_fn;
 
 	const struct option option[] = {
@@ -182,9 +209,9 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 					break;
 				die("input format error: (blank line only valid in batch mode)");
 			}
-			mktree_line(sb.buf, nul_term_line, allow_missing);
+			mktree_line(sb.buf, nul_term_line, allow_missing, &arr);
 		}
-		if (is_batch_mode && got_eof && used < 1) {
+		if (is_batch_mode && got_eof && arr.nr < 1) {
 			/*
 			 * Execution gets here if the last tree entry is terminated with a
 			 * new-line.  The final new-line has been made optional to be
@@ -192,12 +219,14 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 			 */
 			; /* skip creating an empty tree */
 		} else {
-			write_tree(&oid);
+			write_tree(&arr, &oid);
 			puts(oid_to_hex(&oid));
 			fflush(stdout);
 		}
-		used=0; /* reset tree entry buffer for re-use in batch mode */
+		tree_entry_array_clear(&arr, 1); /* reset tree entry buffer for re-use in batch mode */
 	}
+
+	tree_entry_array_release(&arr, 1);
 	strbuf_release(&sb);
 	return 0;
 }
-- 
gitgitgadget

