Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B807315B0FD
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834305; cv=none; b=XKA/nJyqObF/q//Z5rIqv2/rr0k68aCj+maVLWNwXFP/m6l03c4skKTWFBy9zqZ2yN7r/2bqhokKCUWk4yRuMedmQRqClRMTpIiq1bkB3Z5GNGTo0n6DwtDuzK3Ogl04idiMUR4aBCj52p5ynw3XKAqcQYzxnxA07lLWsxQ3sJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834305; c=relaxed/simple;
	bh=OuSq1EvYfSqzdvrqwl8sQiNYVSld8V1YPsltCLoibE8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UiMqI//mqPar5Eu5wr/OK3wbcGVvAdb489nEME7sXTNlPIQI+HN6Mihc1OlRZ9VhaLTi/7epWVbCy5g2mr5hTuvVwbpk4YfvpMSveSMM8hOnZSSb62D7Yy2YZSZLBqtIhop6CQkckn94vII6nEkiAL6z3kg38ciiQpN3OGNwXTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFdWKGQ0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFdWKGQ0"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-363bd55bcc2so221993f8f.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834301; x=1719439101; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE9dkyq4QDse0xBWO2dwDE2MLj7JvTQgHs6uiJjwaFs=;
        b=fFdWKGQ0rcT6z5S4kHUEmIMZHsCH38Kd0iV53T8nviCAHCXTaj9ZApo9ThsoHWvOaZ
         YZzh/psD71usKWrzmI2t5/uMxJiq4+ttfUAcnG0l1QQ2jcpx148K2P1YogvYBIyqM80J
         fqoTkzRlH/J3bYgstIkA8qFoWnitcLwGCaTJcKGc6kHJnQi3vQLBrHoDfwJ44s99iA54
         nlU389SzeQOiskE/1rOx2sndOFZ4uIgJXa755feR1/cB2iuFi6LW3+Too4xeIrEpkWtE
         MNJoT9TvEe0ds8lQ6mU2yAaH/0jcQrV/YlsDYOCdxRddVQCGOUibt9GQrw6I4TuL2EfV
         D1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834301; x=1719439101;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE9dkyq4QDse0xBWO2dwDE2MLj7JvTQgHs6uiJjwaFs=;
        b=a1iqq0A18fNj6BvgZ9pM+GwsfQwawHTiipjQbETo0lR0tMIdHhpx1q1ARbyEvFoyCE
         W/zhEfhwVyP5gfBUiG1mUesBR0lu+q30qy9tn7D1qv/A5tJpPElQvR7M+0yBRDJAJmT4
         XVJ1EsjuMAZ38PsmuBPr2dJ5VagdoeU9/glyX0bBByJ3OCLdmxUpVYJqe108W3YU16p8
         DMilUAXuVuUrA/xh2QLQ2q3RPnVWwXTCO8VSJvfyxsYM5DsZO2TNfWyl0YSdSdTw+ISt
         k25+dJhy3W7BVEiiQcRybXTGcj1EJvQI53zjrYgvqFiCLRXFAQ9Us4gZhSWoLZA5Nb8Q
         Ov6w==
X-Gm-Message-State: AOJu0Yx8psbfkdkyPRdmQajC5SBcmv7UHFgQxyAITETrV1L48HnWxtyM
	6daLm/ZulwNkGjUYlG84oJY2MBg+zTcN4YbvNgwOrLg/W6oR4Vgh5U2I5g==
X-Google-Smtp-Source: AGHT+IHz9UMHMmyKYpK9qddVzl2uDKXmEu1+XUMGhrlLgUIq3/KcNQ6WheeZULHzbpkSEtU1a4do0w==
X-Received: by 2002:a5d:55d1:0:b0:35f:1dce:8671 with SMTP id ffacd0b85a97d-36317898270mr2554771f8f.25.1718834301463;
        Wed, 19 Jun 2024 14:58:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36318534adfsm3798654f8f.42.2024.06.19.14.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:20 -0700 (PDT)
Message-Id: <fb555658057f834d94f232f1d8b380a6304a3671.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:57:59 +0000
Subject: [PATCH v2 11/17] mktree: overwrite duplicate entries
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

If multiple tree entries with the same name are provided as input to
'mktree', only write the last one to the tree. Entries are considered
duplicates if they have identical names (*not* considering mode); if a blob
and a tree with the same name are provided, only the last one will be
written to the tree. A tree with duplicate entries is invalid (per 'git
fsck'), so that condition should be avoided wherever possible.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-mktree.txt |  3 ++-
 builtin/mktree.c             | 45 ++++++++++++++++++++++++++++++++----
 t/t1010-mktree.sh            | 36 +++++++++++++++++++++++++++--
 3 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 5f3a6dfe38e..cf1fd82f754 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -54,7 +54,8 @@ cannot be represented in a tree object. The command will fail without
 writing the tree if a higher order stage is specified for any entry.
 
 The order of the tree entries is normalized by `mktree` so pre-sorting the
-input by path is not required.
+input by path is not required. Multiple entries provided with the same path
+are deduplicated, with only the last one specified added to the tree.
 
 GIT
 ---
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 8f0af24b6b1..a91d3a7b028 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -15,6 +15,9 @@
 #include "object-store-ll.h"
 
 struct tree_entry {
+	/* Internal */
+	size_t order;
+
 	unsigned mode;
 	struct object_id oid;
 	int len;
@@ -74,15 +77,49 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
 	ent->len = len;
 	oidcpy(&ent->oid, oid);
 
+	ent->order = arr->nr;
 	tree_entry_array_push(arr, ent);
 }
 
-static int ent_compare(const void *a_, const void *b_)
+static int ent_compare(const void *a_, const void *b_, void *ctx)
 {
+	int cmp;
 	struct tree_entry *a = *(struct tree_entry **)a_;
 	struct tree_entry *b = *(struct tree_entry **)b_;
-	return base_name_compare(a->name, a->len, a->mode,
-				 b->name, b->len, b->mode);
+	int ignore_mode = *((int *)ctx);
+
+	if (ignore_mode)
+		cmp = name_compare(a->name, a->len, b->name, b->len);
+	else
+		cmp = base_name_compare(a->name, a->len, a->mode,
+					b->name, b->len, b->mode);
+	return cmp ? cmp : b->order - a->order;
+}
+
+static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
+{
+	size_t count = arr->nr;
+	struct tree_entry *prev = NULL;
+
+	int ignore_mode = 1;
+	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
+
+	arr->nr = 0;
+	for (size_t i = 0; i < count; i++) {
+		struct tree_entry *curr = arr->entries[i];
+		if (prev &&
+		    !name_compare(prev->name, prev->len,
+				  curr->name, curr->len)) {
+			FREE_AND_NULL(curr);
+		} else {
+			arr->entries[arr->nr++] = curr;
+			prev = curr;
+		}
+	}
+
+	/* Sort again to order the entries for tree insertion */
+	ignore_mode = 0;
+	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
 }
 
 static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
@@ -90,7 +127,7 @@ static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
 	struct strbuf buf;
 	size_t size = 0;
 
-	QSORT(arr->entries, arr->nr, ent_compare);
+	sort_and_dedup_tree_entry_array(arr);
 	for (size_t i = 0; i < arr->nr; i++)
 		size += 32 + arr->entries[i]->len;
 
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 7e750530455..08760141d6f 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -6,11 +6,16 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-	for d in a a- a0
+	for d in folder folder- folder0
 	do
 		mkdir "$d" && echo "$d/one" >"$d/one" &&
 		git add "$d" || return 1
 	done &&
+	for f in before folder.txt later
+	do
+		echo "$f" >"$f" &&
+		git add "$f" || return 1
+	done &&
 	echo zero >one &&
 	git update-index --add --info-only one &&
 	git write-tree --missing-ok >tree.missing &&
@@ -171,7 +176,7 @@ test_expect_success '--literally can create invalid trees' '
 
 test_expect_success 'mktree validates path' '
 	tree_oid="$(cat tree)" &&
-	blob_oid="$(git rev-parse $tree_oid:a/one)" &&
+	blob_oid="$(git rev-parse $tree_oid:folder.txt)" &&
 	head_oid="$(git rev-parse HEAD)" &&
 
 	# Valid: tree with or without trailing slash, blob without trailing slash
@@ -202,4 +207,31 @@ test_expect_success 'mktree validates path' '
 	test_grep "invalid path ${SQ}.git/${SQ}" err
 '
 
+test_expect_success 'mktree with duplicate entries' '
+	tree_oid=$(cat tree) &&
+	folder_oid=$(git rev-parse ${tree_oid}:folder) &&
+	before_oid=$(git rev-parse ${tree_oid}:before) &&
+	head_oid=$(git rev-parse HEAD) &&
+
+	{
+		printf "100755 blob $before_oid\ttest\n" &&
+		printf "040000 tree $folder_oid\ttest-\n" &&
+		printf "160000 commit $head_oid\ttest.txt\n" &&
+		printf "040000 tree $folder_oid\ttest\n" &&
+		printf "100644 blob $before_oid\ttest0\n" &&
+		printf "160000 commit $head_oid\ttest-\n"
+	} >top.dup &&
+	git mktree <top.dup >tree.actual &&
+
+	{
+		printf "160000 commit $head_oid\ttest-\n" &&
+		printf "160000 commit $head_oid\ttest.txt\n" &&
+		printf "040000 tree $folder_oid\ttest\n" &&
+		printf "100644 blob $before_oid\ttest0\n"
+	} >expect &&
+	git ls-tree $(cat tree.actual) >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

