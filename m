Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7FA13210D
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130307; cv=none; b=FBx5FDgUppcJq51FgEp/o6Pd6tYDKgEZgRFWwPtFGqw8HzCQbJdQ+E4tAXVnRLkg5RXiUKlLXJxdN/9joyRzNjlAGGPmrfazBKMOzWCMv9rjVLqAkehY1Gk5KNVM0kyrDxz21+ojIbCxecW/2uv55FywSJmZCPNYOVHe0quUYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130307; c=relaxed/simple;
	bh=03OzM0oh5ra+ghw1/SmdZwx+xZMkipokS8ZxnLHydiE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hDfP3cw9qjOOxqm7QeIlQ/8a2xEtcrS3+NtVVUjg2rOW4mFV4xdNurLEla5OG0u8Y2O9li9KhvvUbUp8sDavT9qDZpM54zmllOzdyU/ehsCVwTk7sONX3vbcMMN/1674TTmwB/XgYjYVF0NdTwwKqy4KZQ1L3QlCeZbnQgAAfUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPB+Ut97; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPB+Ut97"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so14794245e9.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130304; x=1718735104; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+X6OiwowJLdCbJOKgYcMkQVtYykLJ8vrOMNLn5YdrM=;
        b=aPB+Ut978b9+NiDFfmDGHuYEYFyALyRfLNvuvWKncIjfm4VDF2+UO1m/pEqNQ9cX1J
         myWGauRbmE1ViSzYg1djj4OU+9XGP+NL0JZVmph7p1B7YHHSTIJkzixBXaWVp9kKhGdj
         bw2Nra+ABQD/1hA7OXbnKWEfRRmVIm+FSzSjx4uBdyxyU+julq16x3H3P/9u2R1fwkxS
         x7hoepEF6JBHVKovmAzV26MAMfU9sD2XQOPqZE5vlssNceG9x+SQbVz7YmYu4tchy/eP
         jPOON2IzF8yIeiwYSjdwJ17wzpNvTrqzKG253jdvGFE05VkTcS3e6mvk6qBu83FsYWNv
         49iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130304; x=1718735104;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+X6OiwowJLdCbJOKgYcMkQVtYykLJ8vrOMNLn5YdrM=;
        b=OEsm3ZjfaWQd0ZcsUli+HDhI1K3Tg1pKG1+D9+xh16pu59V6bnxKAUtHg6hQa/W4JV
         LTH+oo0I99NjZlqS8y8mnsxxf0wKrKA36z5mjXtg+W40V2SEkn21C/uig4jnrSCX6pZh
         3eANUdL9oMjvhJmFNmxEP9tn3EOWFdp09KUn9P8yWRL9izFXdWLM6wC9WqS+iB1UHDm0
         INfRLLtBI8EgXnSrvRE4bxiTWsw7yWen80fV8YZxBZiOcrGAbG+n2kD7c6nI3csjcicH
         66quNksPD0NDSd9Z45z//AYEV8rNuyfHIxqIl7J2Ht4hhJY48Fc2WrBmqXnGdiY8ei6W
         LPZg==
X-Gm-Message-State: AOJu0Yxlrvi4KVB/xKfEaPFzuMVpUeqpOlqHG7vFSPSy+khNkn2lyb+L
	BA9tguYKtdGTXb8ooDPvmLg4E0XycR7WOxR1u4ezeRlRHSavYhfq2Enhdw==
X-Google-Smtp-Source: AGHT+IHL4tupzGUuW5pJMpitAPNpDtLHHdj4yt1gO9raPorMvZhvJIbAnDGc159v2x2hC1XEJIiaWw==
X-Received: by 2002:a05:600c:1f06:b0:421:9502:3f24 with SMTP id 5b1f17b1804b1-42195023fe4mr64786115e9.14.1718130303658;
        Tue, 11 Jun 2024 11:25:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c690dsm189587455e9.34.2024.06.11.11.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:25:03 -0700 (PDT)
Message-Id: <a90d6d0c943283e9e7bd181cd6e9bb6d4572aaeb.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:48 +0000
Subject: [PATCH 16/16] mktree: remove entries when mode is 0
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

If tree entries are specified with a mode with value '0', remove them from
the tree instead of adding/updating them. If the mode is '0', both the
provided type string (if specified) and the object ID of the entry are
ignored.

Note that entries with mode '0' are added to the 'struct tree_ent_array'
with a trailing slash so that it's always treated like a directory. This is
a bit of a hack to ensure that the removal supercedes any preceding entries
with matching names, as well as any nested inside a directory matching its
name.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-mktree.txt |  4 +++
 builtin/mktree.c             | 64 ++++++++++++++++++++----------------
 t/t1010-mktree.sh            | 38 +++++++++++++++++++++
 3 files changed, 77 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index db90fdcdc8f..a660438c67f 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -55,6 +55,10 @@ entries nested within one or more directories. These entries are inserted into
 the appropriate tree in the base tree-ish if one exists. Otherwise, empty parent
 trees are created to contain the entries.
 
+An entry with a mode of "0" will remove an entry of the same name from the base
+tree-ish. If no tree-ish argument is given, or the entry does not exist in that
+tree, the entry is ignored.
+
 The order of the tree entries is normalized by `mktree` so pre-sorting the input
 by path is not required. Multiple entries provided with the same path are
 deduplicated, with only the last one specified added to the tree.
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 00b77869a56..e94c9ca7e87 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -32,7 +32,7 @@ struct tree_entry {
 
 static inline size_t df_path_len(size_t pathlen, unsigned int mode)
 {
-	return S_ISDIR(mode) ? pathlen - 1 : pathlen;
+	return (S_ISDIR(mode) || !mode) ? pathlen - 1 : pathlen;
 }
 
 struct tree_entry_array {
@@ -106,7 +106,7 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
 		size_t len_to_copy = len;
 
 		/* Normalize and validate entry path */
-		if (S_ISDIR(mode)) {
+		if (S_ISDIR(mode) || !mode) {
 			while(len_to_copy > 0 && is_dir_sep(path[len_to_copy - 1]))
 				len_to_copy--;
 			len = len_to_copy + 1; /* add space for trailing slash */
@@ -122,7 +122,7 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
 			arr->has_nested_entries = 1;
 
 		/* Add trailing slash to dir */
-		if (S_ISDIR(mode))
+		if (S_ISDIR(mode) || !mode)
 			ent->name[len - 1] = '/';
 	}
 
@@ -208,7 +208,7 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
 
 			if (!skip_entry) {
 				arr->entries[arr->nr++] = curr;
-				if (S_ISDIR(curr->mode))
+				if (S_ISDIR(curr->mode) || !curr->mode)
 					tree_entry_array_push(&parent_dir_ents, curr);
 			} else {
 				FREE_AND_NULL(curr);
@@ -272,6 +272,9 @@ static int build_index_from_tree(const struct object_id *oid,
 static int add_tree_entry_to_index(struct build_index_data *data,
 				   struct tree_entry *ent)
 {
+	if (!ent->mode)
+		return 0;
+
 	if (ent->expand_dir) {
 		int ret = 0;
 		struct pathspec ps = { 0 };
@@ -445,36 +448,39 @@ static int mktree_line(unsigned int mode, struct object_id *oid,
 		       const char *path, void *cbdata)
 {
 	struct mktree_line_data *data = cbdata;
-	enum object_type mode_type = object_type(mode);
-	struct object_info oi = OBJECT_INFO_INIT;
-	enum object_type parsed_obj_type;
 
-	if (obj_type && mode_type != obj_type)
-		die("object type (%s) doesn't match mode type (%s)",
-		    type_name(obj_type), type_name(mode_type));
+	if (mode) {
+		struct object_info oi = OBJECT_INFO_INIT;
+		enum object_type parsed_obj_type;
+		enum object_type mode_type = object_type(mode);
 
-	oi.typep = &parsed_obj_type;
+		if (obj_type && mode_type != obj_type)
+			die("object type (%s) doesn't match mode type (%s)",
+			    type_name(obj_type), type_name(mode_type));
 
-	if (oid_object_info_extended(the_repository, oid, &oi,
-				     OBJECT_INFO_LOOKUP_REPLACE |
-				     OBJECT_INFO_QUICK |
-				     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
-		parsed_obj_type = -1;
+		oi.typep = &parsed_obj_type;
 
-	if (parsed_obj_type < 0) {
-		if (data->allow_missing || S_ISGITLINK(mode)) {
-			; /* no problem - missing objects & submodules are presumed to be of the right type */
-		} else {
-			die("entry '%s' object %s is unavailable", path, oid_to_hex(oid));
+		if (oid_object_info_extended(the_repository, oid, &oi,
+					     OBJECT_INFO_LOOKUP_REPLACE |
+					     OBJECT_INFO_QUICK |
+					     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
+			parsed_obj_type = -1;
+
+		if (parsed_obj_type < 0) {
+			if (data->allow_missing || S_ISGITLINK(mode)) {
+				; /* no problem - missing objects & submodules are presumed to be of the right type */
+			} else {
+				die("entry '%s' object %s is unavailable", path, oid_to_hex(oid));
+			}
+		} else if (parsed_obj_type != mode_type) {
+			/*
+			* The object exists but is of the wrong type.
+			* This is a problem regardless of allow_missing
+			* because the new tree entry will never be correct.
+			*/
+			die("entry '%s' object %s is a %s but specified type was (%s)",
+			path, oid_to_hex(oid), type_name(parsed_obj_type), type_name(mode_type));
 		}
-	} else if (parsed_obj_type != mode_type) {
-		/*
-		 * The object exists but is of the wrong type.
-		 * This is a problem regardless of allow_missing
-		 * because the new tree entry will never be correct.
-		 */
-		die("entry '%s' object %s is a %s but specified type was (%s)",
-		    path, oid_to_hex(oid), type_name(parsed_obj_type), type_name(mode_type));
 	}
 
 	append_to_tree(mode, oid, path, data->arr, data->literally);
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 1d6365141fc..7cb88e32d4f 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -373,4 +373,42 @@ test_expect_success 'mktree fails on directory-file conflict' '
 	grep "You have both folder/one and folder/one/deeper/deep" err
 '
 
+test_expect_success 'mktree with remove entries' '
+	tree_oid="$(cat tree)" &&
+	blob_oid="$(git rev-parse $tree_oid:folder.txt)" &&
+
+	{
+		printf "100644 blob $blob_oid\ttest/deeper/deep.txt\n" &&
+		printf "100644 blob $blob_oid\ttest.txt\n" &&
+		printf "100644 blob $blob_oid\texample\n" &&
+		printf "100644 blob $blob_oid\texample.a/file\n" &&
+		printf "100644 blob $blob_oid\texample.txt\n" &&
+		printf "040000 tree $tree_oid\tfolder\n" &&
+		printf "0 $ZERO_OID\tfolder\n" &&
+		printf "0 $ZERO_OID\tmissing\n"
+	} | git mktree >tree.base &&
+
+	{
+		printf "0 $ZERO_OID\texample.txt\n" &&
+		printf "0 $ZERO_OID\ttest/deeper\n"
+	} | git mktree $(cat tree.base) >tree.actual &&
+
+	{
+		printf "100644 blob $blob_oid\texample\n" &&
+		printf "100644 blob $blob_oid\texample.a/file\n" &&
+		printf "100644 blob $blob_oid\ttest.txt\n"
+	} >expect &&
+	git ls-tree -r $(cat tree.actual) >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'type and oid not checked if entry mode is 0' '
+	# type and oid do not match
+	printf "0 commit $EMPTY_TREE\tfolder.txt\n" |
+	git mktree >tree.actual &&
+
+	test "$(cat tree.actual)" = $EMPTY_TREE
+'
+
 test_done
-- 
gitgitgadget
