Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE733468C
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868495; cv=none; b=R7EWu0NzcH+jhLOwl34vPhaMbDlTSEWQzwb2KF97rkqDfwqQMjBelu6HEY5Zepi0E3uzCaX3o4+N7cP+z13VNjNvhcmYIOI2IwqkcBGlDmtO/ti6hIy2kyxhXpB4XE0ui8ygEDsWUvfHiEOqT82RcARrHYZSmOVQU9/9Cs7BkiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868495; c=relaxed/simple;
	bh=5rDVLDDRAKYtVtEo0t2M9IJJ3U+ncx1OuLYHQb86o9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtoKO/osx+SifD6FQ4e9ER4O++NWS/qzT+bRl9zhBztS8nu4iqAf+bEcOWAnMgaRFX21BKag9ixSv0fx2k16Q7GFD4ZWHz9szEhVMvragzDU/crPqol4dpXIk/72htrmc1d0XrpxGqaX3+sHcP7pVH3qVQbsHLiYDl3LT4XfIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqIX28ov; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqIX28ov"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4645dde00a7so1330217b6e.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868492; x=1772473292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87onjkU9GeLHhDcK/mIJBh09LsgLUoYCu3zxVCeXOPE=;
        b=SqIX28ovBhqyNKCuc/wp7uS3I0RiEzFAhw7Bgu5sPNTQ1lmRLfashhlNKIzGXqe1z4
         NeDwtizF2TSvqccz8jtFcJD03zO5Okzr8CdGq9K1goETPBOla2jMD/pFsfZDuFqOO9Cd
         43JK4JGpr4AuhYIOnAIEYZqBTG9fjTp0Ll0IpGtaaimgN84ljtDr4ikF4GiZhXsaB8CY
         ZH0d8VEHswF+FvudLt7jqLXVU1cpl1n946su9SPzWeB8Ri0RqLZfHLsMwXsyeE03+pob
         pyrlTjTaER22Ia54dBXkJ8UlvPCc8ljVKgcU5qQsQckAttPyZLJM1hFfizUocGKgpGZ2
         DwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868492; x=1772473292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=87onjkU9GeLHhDcK/mIJBh09LsgLUoYCu3zxVCeXOPE=;
        b=ojJ1JU9wETH+Guc81zHihfFGYM5WMjFgIsecIPO8BXgJEMncs9ao8VtJF7BvzK+J1G
         hsABdsx9P23pC2CZemxD27+IntHGPuVGUvtd8YfChTsF2gSV1K1esJFLCW5S/SwkC0Mk
         mF/VHRgHWKBSClp9N48dr/pjs10/xAcRiE+tdwaV7ACk4Mb0lbNdYvwKQsA3sARaRKWA
         icoS+KGV/JT6sAyATVrUnX9ic9ItI0hVUzgViHZ8+1tJJRAW+y+wcqtV9uXkgOWdYg3F
         Q7QNOZnuFwJVgDG+KW1KWih7pWd4F/voVYuVcmFkkKSt8ksYgZTFehwlJ8TC36nqVata
         qBlQ==
X-Gm-Message-State: AOJu0YzTbZbqhj/Dtiv41K3ZGPoa/uaszaPX3IGkCWF4t95T0F7iOxLT
	CDDxrzepVNMZSDw2m7iPZS+8bsXyejVtwW8EmEFC0HGw/lvo2zGtkxO25RU0Ww==
X-Gm-Gg: AZuq6aJYugPYoECdJc1XT2/EVNEls7Z0kXBBTryGjs019kHbAhru+9ALUK73wEUmy+U
	4CZwK4Mue4p4Lh91GBOq4DE5FeX66GsPnysgs4lniJcQMeqj1hCcFFZiMhdMmgWzZVFh2OAOEun
	Ei/rtf0SwtBRK9fBhvApjpsBFHyYwItEUwEBJqJS8Pjmz1dvPmMlJFgVvn2wsqkU42z4nBeCGSP
	i8l79pcLj+FPzQWRgXYcW9uR00Qp4qQm8PwkBSt6hIkBJ2N44mF28eguaEicgf6kBu0dd1dbRha
	2xiPEwJJCPTyFHsoXmGYynHInfUX0ZfZHr39Ye8razajfXhcOZ08QlN1jsloL5X4KpSY0mZSbJD
	L8GAuLg7/cko5LjcSClncE3Ma3CxB6rSs7lkY3Xkz4ltxK7IlDHfiD6rX7d6llYVqdxauooxfPo
	z1Tlk9BomQ9bXt5AUoqD0bQPTDyxIomDc=
X-Received: by 2002:a05:6808:169f:b0:45c:85fa:5a3e with SMTP id 5614622812f47-464276252femr7184842b6e.25.1771868492383;
        Mon, 23 Feb 2026 09:41:32 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d0386c6sm8305476a34.13.2026.02.23.09.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:41:32 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	eslam.reda.div@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 5/5] builtin/repo: find tree with most entries
Date: Mon, 23 Feb 2026 11:41:20 -0600
Message-ID: <20260223174120.2356504-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223174120.2356504-1-jltobler@gmail.com>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260223174120.2356504-1-jltobler@gmail.com>
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
index 97da147f68..349cb27aca 100644
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

