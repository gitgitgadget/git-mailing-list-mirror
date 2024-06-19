Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E915D5D7
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834309; cv=none; b=U/x9QQmLt87al4u6DPwhZi2noZbqwPvYaXt4sRoU20toTM2yhqwujeL55vxhZtK38DZffwZXfX6S9XkW646E3/s993Mhx3Qwb6TNCD7Ndsd0OTu7bL5buc5e6MLHq7Olaj4pLhumlEj65tZld80p2fTg3pMpCvNi9VJmCQATUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834309; c=relaxed/simple;
	bh=PRVd/xG7+6beWajA3bSpu/PNzCIJaDbT+QMzqieVCvo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TR/ac5KGSGgQbt+7ZMCasvYClAZH3XQURvIIxGPlx/UpX7KwSIAjbdOpPA6d8WJD7MUcornJgzgaGYSJCLpyJZVfg9WcgUFTjX8gTjw1O+q+0tVHkfhd/zjImMIzbWRv46n4VcAXTe9ZFN3yZRJY43GOfjODwqwQe6grjfRq3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkyUSaow; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkyUSaow"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so2646765e9.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834306; x=1719439106; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1xjuy9nL0JZHkUaSByuJIWU3op6pW0/jKvj7oChM7k=;
        b=AkyUSaowc6B9x74WlNmGc0kA1vcmMIPxQXgXFSXtFbSKMKu602JLpd1Pgc2pRciL96
         1MpFL6VoPf/4PwFR1tTR4MyQNOjMsseaUvdQDtd1Tj13y78CVkcPvP1Ui6M2Y2wUkgw3
         J8zAsA4V1rShyPBv9vQGjTsDDHqwet+pJo6YpnpZSuvOo9bIVE8deBhX+K15pUoCj9Om
         N6aCxOHrzjzynUqlHjAvwoDi+aGrMYGNpiS0tP74981Pf+fQXXIfDOMZQCdG/zu44Xq0
         LGn5ffQMm7M2X0Pc0oXwn9zE6yT3eRF0rhapmj/jBP61g810wKSgbCjmdzrj1b985l1i
         8ERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834306; x=1719439106;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1xjuy9nL0JZHkUaSByuJIWU3op6pW0/jKvj7oChM7k=;
        b=aWQIFkoa1A6p3OblsNRFAYdjX9ySpNb/6F839X8Rh6HYqWlENSyYBnJD1+5chia5Sk
         XeWNQMaOe4dzC5NVqdVFGQsvY3PKJPKUvnQ+KaSTWhgQAr6U5S0aRkpN7kahnjJqjKG2
         APA16w7Vb6YGCW4lMR5TzHPEoWO7zU8/8PAToR24VLDa1FJoy6Gjvjm64cEEt4pdORzV
         zla62asgwQ6lkbIKlFHz2PxN/Da16i6/Qo3noHksx7MxZsSmx8Xb4KohXSxrJWazzCtw
         ZsKZ77E4+PAuVJccQDLdpEhORFoFYp8eiyVERi1YezhCWMQBXYyLrpqkZp8sj+pEAFnd
         rPiA==
X-Gm-Message-State: AOJu0YyBOxJYasUvMwzKrgH4fJK7VGVXEq0HwfwBRNvh8PR92qQapyqZ
	KNrr2XERuNPtiDjZhoLeTF0faOL1W66bAtOGfXh/NdENGEvGdVHywUgHVQ==
X-Google-Smtp-Source: AGHT+IFO1D7InHSFOytuUAHZNiMIqW+Or3k2ozPzbMvvV6m9eORZPvHRMAEhcgYpMFpbgxwj2nqigw==
X-Received: by 2002:a7b:cb93:0:b0:421:82ed:28d1 with SMTP id 5b1f17b1804b1-424752a3cbcmr22173945e9.41.1718834305799;
        Wed, 19 Jun 2024 14:58:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c0d56sm3826815e9.13.2024.06.19.14.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:24 -0700 (PDT)
Message-Id: <6f6d78ae7acb35991afbeaef9b61af892af93ca1.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:58:02 +0000
Subject: [PATCH v2 14/17] mktree: add directory-file conflict hashmap
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

Create a hashmap member of a 'struct tree_entry_array' that contains all of
the (de-duplicated) provided tree entries, indexed by the hash of their path
with *no* trailing slash. This hashmap will be used in a later commit to
avoid adding a file to an existing tree that has the same path as a
directory, or vice versa.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 344c9b9b6fe..b4d71dcdd02 100644
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
+static void tree_entry_array_init(struct tree_entry_array *arr)
+{
+	hashmap_init(&arr->df_name_hash, df_name_hash_cmp, NULL, 0);
+}
+
 static void tree_entry_array_push(struct tree_entry_array *arr, struct tree_entry *ent)
 {
 	ALLOC_GROW(arr->entries, arr->nr + 1, arr->alloc);
@@ -48,6 +75,7 @@ static void tree_entry_array_clear(struct tree_entry_array *arr, int free_entrie
 			FREE_AND_NULL(arr->entries[i]);
 	}
 	arr->nr = 0;
+	hashmap_clear(&arr->df_name_hash);
 }
 
 static void tree_entry_array_release(struct tree_entry_array *arr, int free_entries)
@@ -137,6 +165,14 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
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
@@ -311,6 +347,8 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 
 	ac = parse_options(ac, av, prefix, option, mktree_usage, 0);
 
+	tree_entry_array_init(&arr);
+
 	do {
 		ret = read_index_info(nul_term_line, mktree_line, &mktree_line_data, &line);
 		if (ret < 0)
-- 
gitgitgadget

