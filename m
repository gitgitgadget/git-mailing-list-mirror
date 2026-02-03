Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6B31AA84
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 22:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157120; cv=none; b=ea0N8WBgGH0D6c5EuiBKJy+cHwAfjgU5s8Sr70ixptuh8l/9R9j8V3D2E3oSO3Txzvj0ZPQmC3cX6BRBXHUYA1oDl487rrrutEg1EtVqNq+HP82mZuDK8DIpotGUMjVcMhF0M1itQcSXl3/ep3dIT1FgsET1U1aTp2koABA/+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157120; c=relaxed/simple;
	bh=zwpRZCeVO7vSMEHdH93DdVcjKAqlDV124NvSvspvKko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyxWyfo2QIc5QtLcvVopfUGvzLpvVVUycmJoNksUzJH1JpYqSV0JuuOxuIPL5VWa2q/BBi/spjk58l5vwpowJtlXMgGPM6QYGYz/ooYtwibWp9Jz+R6N6gYzTz6mQCfQEMHP6LLsflTlxZvHxW8kxuVnxGLVqvIiYnYzS8VkdXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9YryChE; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9YryChE"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40945a682b5so2351816fac.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 14:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770157117; x=1770761917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLkC8UQEUAc2UCTIKArGok8eC8Q2hzJv7+WfOrT89lM=;
        b=H9YryChEBUDHwEBF7f4GSI3cyId1WhbOWUu5sfbVoYu6BVhoogJi7bZoXfFzFEEtri
         sMxMRO0EKNKxfTkDhlfn71xwdgkhl9Oi6+Z3nmZqhXLZNZjDe9soLDaebKJXQsGXEhAX
         Y+cRAS9+zjgUUScxMBrBqKl75xvnqAFxfqZ0NXQhDQwPMogUCf1KwXaGAjf2LUpUg61H
         S3p5x7AMOAiQ0ej18m8tLD/9b4+oiOQxZbDoJ6QGPQ3p4OU5f1MTvH5y5RkRDrVkW/6X
         gNbLc4ormTLpGDStCvnYQ8KMUthckuFpzt7HYni6Mn0V9crZ/97doCe9+9fG+geoCAAJ
         UniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770157117; x=1770761917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLkC8UQEUAc2UCTIKArGok8eC8Q2hzJv7+WfOrT89lM=;
        b=RPPuwvAn0aoudVNp3g40Fxd36rxwEy+8y6rDp1SGkAlj74NzKm/aZ+3bYX8dhgKazB
         gQbPN5aiUqp66mPeowSmmbBwiq/CGS2yt6U/G2NfHaLj7C2xxEwoGleBDesDrsNczksb
         6s1Pv6K4acEu2WXSIi1IU23hGg69NFJ+Sg5F+QbIlxXxSxxZu/GoTVNBtcOjeigpQIz4
         rGqtVlWUIItbbE/8OSaoJugHopdoi1AOXGFVaunQS9o3hSj01Nn9jMeFq4eAqzrN4NHm
         YvkfNY3QCg7vM2g0FYbHotnDtfXX7lBxp5bbajUMO+HyRsC+hXE5jEK4uHWEh7JWgW8P
         6u8Q==
X-Gm-Message-State: AOJu0Yw7k4SYNneVBTmVKBDds4P/aBvQrJHhdh2OQqfGwf+KWI6GVDDt
	Uku98WRpkIHbqTPEi7JIcCUxx+AqTx5uwySh6pxA9lOwiES7YUDhu0Z0OcqEfQ==
X-Gm-Gg: AZuq6aJwhpMQEb3yFpy4bC/fQrJdOpQsl98SH1ULTXloxQ5oBtUZN1qxWCSlFeeIpes
	AhB1THKtivWQOqaHxIFEWogmM0EGQPfY0GI8BPzD2QdJ7dj4NRDrJ1NbCv08fwlIVDXs2oaqWzw
	DgGH0juqM/RPRoFgZ4vwQ2cOw0RVC/8lz+q4zihQ5U0pxSE3U+yZOVaYWyGlE8SyA4mIyq1BURa
	ozazs0QY0M39NVAc+x22eGuEkrVyKHh8rMcRidhgg7XjSkhzMUYG2jKgPspk5YSgq9hS76HKs34
	zcHigHr+fI25Ne7eE/yLXkFsZYUIGy+OPGeyRds5nL3370+ppws+o2uvwH5y7jlTNPvQwKLByo0
	hgNz/JFjlleKKFdQwzyZyJSd0m7/0tbmJ1icTQARjY0Yowa7c7WxUeXFClTZyLb3wPCf9s/SDA/
	DabsxjYCkF1MXEfDjwCUI=
X-Received: by 2002:a05:6871:79a1:b0:3e3:6b75:6c14 with SMTP id 586e51a60fabf-40a5404e0bbmr494882fac.29.1770157117231;
        Tue, 03 Feb 2026 14:18:37 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a53c3c4dasm479042fac.0.2026.02.03.14.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 14:18:36 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 5/5] builtin/repo: find tree with most entries
Date: Tue,  3 Feb 2026 16:17:58 -0600
Message-ID: <20260203221758.1164434-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203221758.1164434-1-jltobler@gmail.com>
References: <20260203221758.1164434-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of a tree object usually corresponds with the number of entries
it has. While iterating through objects in the repository for
git-repo-structure, identify the tree with the most entries and display
it in the output.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            | 27 +++++++++++++++++++++++++++
 t/t1901-repo-structure.sh | 13 +++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index dc1ac7ad3b..0f77d8f68f 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -16,6 +16,8 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
+#include "tree.h"
+#include "tree-walk.h"
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
@@ -211,6 +213,7 @@ struct largest_objects {
 	struct object_data blob_size;
 
 	struct object_data parent_count;
+	struct object_data tree_entries;
 };
 
 struct ref_stats {
@@ -458,6 +461,10 @@ static void stats_table_setup_structure(struct stats_table *table,
 				     &objects->largest.tree_size.oid,
 				     objects->largest.tree_size.value,
 				     "    * %s", _("Maximum size"));
+	stats_table_object_count_addf(table,
+				      &objects->largest.tree_entries.oid,
+				      objects->largest.tree_entries.value,
+				      "    * %s", _("Maximum entries"));
 	stats_table_addf(table, "  * %s", _("Blobs"));
 	stats_table_object_size_addf(table,
 				     &objects->largest.blob_size.oid,
@@ -619,6 +626,10 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	       (uintmax_t)stats->objects.largest.parent_count.value, value_delim);
 	printf("objects.commits.max_parents_oid%c%s%c", key_delim,
 	       oid_to_hex(&stats->objects.largest.parent_count.oid), value_delim);
+	printf("objects.trees.max_entries%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.largest.tree_entries.value, value_delim);
+	printf("objects.trees.max_entries_oid%c%s%c", key_delim,
+	       oid_to_hex(&stats->objects.largest.tree_entries.oid), value_delim);
 
 	fflush(stdout);
 }
@@ -697,6 +708,20 @@ static void check_largest(struct object_data *data, struct object_id *oid,
 	}
 }
 
+static size_t count_tree_entries(struct object *obj)
+{
+	struct tree *t = object_as_type(obj, OBJ_TREE, 0);
+	struct name_entry entry;
+	struct tree_desc desc;
+	size_t count = 0;
+
+	init_tree_desc(&desc, &t->object.oid, t->buffer, t->size);
+	while (tree_entry(&desc, &entry))
+		count++;
+
+	return count;
+}
+
 static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			 enum object_type type, void *cb_data)
 {
@@ -749,6 +774,8 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			stats->disk_sizes.trees += disk;
 			check_largest(&stats->largest.tree_size, &oids->oid[i],
 				      inflated);
+			check_largest(&stats->largest.tree_entries, &oids->oid[i],
+				      count_tree_entries(obj));
 			break;
 		case OBJ_BLOB:
 			stats->type_counts.blobs++;
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index d003d64a8e..12ed67e846 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -59,6 +59,7 @@ test_expect_success 'empty repository' '
 		|     * Maximum parents     |    0   |
 		|   * Trees                 |        |
 		|     * Maximum size        |    0 B |
+		|     * Maximum entries     |    0   |
 		|   * Blobs                 |        |
 		|     * Maximum size        |    0 B |
 		|   * Tags                  |        |
@@ -122,16 +123,18 @@ test_expect_success SHA1 'repository with references and objects' '
 		|     * Maximum parents [2] |      1     |
 		|   * Trees                 |            |
 		|     * Maximum size    [3] |  32.29 KiB |
+		|     * Maximum entries [4] |   1.01 k   |
 		|   * Blobs                 |            |
-		|     * Maximum size    [4] |     13 B   |
+		|     * Maximum size    [5] |     13 B   |
 		|   * Tags                  |            |
-		|     * Maximum size    [5] |    132 B   |
+		|     * Maximum size    [6] |    132 B   |
 
 		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
 		[2] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
 		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
-		[4] 97d808e45116bf02103490294d3d46dad7a2ac62
-		[5] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
+		[4] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[5] 97d808e45116bf02103490294d3d46dad7a2ac62
+		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
 		EOF
 
 		git repo structure >out 2>err &&
@@ -176,6 +179,8 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		objects.tags.max_size_oid=1ee0f2b16ea37d895dbe9dbd76cd2ac70446176c
 		objects.commits.max_parents=1
 		objects.commits.max_parents_oid=de3508174b5c2ace6993da67cae9be9069e2df39
+		objects.trees.max_entries=42
+		objects.trees.max_entries_oid=09931deea9d81ec21300d3e13c74412f32eacec5
 		EOF
 
 		git repo structure --format=keyvalue >out 2>err &&
-- 
2.53.0

