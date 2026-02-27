Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3C46AEFE
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220660; cv=none; b=izaw4AoeAIvYTVCQyRE75mGsIhElgEwcfKlVJSR8HzjEgk0VSlrRs9VBoIjVMGqsRwA9wxpFEjk67/PDPFb1VG4MWygNDPkUUYjKWB3IPn7ojnVHrdBkGojcBM4DlxGhmdkPUNW6hKo081GAT9KO9TjlxUkERHj7g7EKB2hOFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220660; c=relaxed/simple;
	bh=gLKopDZBCpxScOZQCCHySjaKkc87nKYAK2RjSiqAlAQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sNW50zQ2en0LKeltfniiEpkJR8VxixSB8lQPuBcSMuJrEyrFnZF87cJ4KrI21dpov5lwRKL/iMCyRwOO15upHN2LqJ30lJHYIvGZaNaUdchuU4QhatD8jHyef7dllFshvYtawF/acJru6Gg25ozYQw0O0+bP/uWeP1P1c6G7K28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpQzkxlz; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpQzkxlz"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1275910b930so1483021c88.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220657; x=1772825457; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IM79YludtzkQXEMggwUjpXxaxNlvU5LmAlafGw7+5Cw=;
        b=RpQzkxlzHKEQ2csR9riXrBfxXNtK+I4jagtf7zOgaB2ZkXk5tJuGqMboqvjudepxDw
         xXU2aNtUKjUWAdehJmhmya4EVrCRFFDHD7bp8TUMuQ6bM46cJgV6aHkNzPgxajWK6qNd
         PVhygvW+ifsfnn9W/Qzs4akjTM8Z3kjHLGLzGNmW6F/v7cSuBGdCNUZfF402H5sh3YXh
         O5kT0g8nXDdV8RvRKbNdd+zadGjftrtu1eqZTbVs8gWLFYIYC8OssU0PcjEInlhsTlGc
         v3Z9oBtdFW44wp1SwAmD6pjkvQprns8+XDV7VsU7cn/1eoTMTO0tbAAv2WMCTQjXziiv
         MPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220657; x=1772825457;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IM79YludtzkQXEMggwUjpXxaxNlvU5LmAlafGw7+5Cw=;
        b=PDyndPkMDVtd4Vfpr65+DGLJcB7LQyOHsPnd7OA2o1jk/lFzFAznMAI4q1VvpNerd/
         77YbOjmuzzbAA+rUf6kTlq1mZN1Csd+4lEMCjEai4KIGlJiNllIzr40EQSJVZlTdm1ay
         F3pDnShbfnYDW4n7YXjUTQ5R+XbGLfnEXriSdp7MLRTtt8PF6vIMm/WBTcpgVw8vteU+
         YI6udZDeMROgopW7NK8OsecMsj2ETHPEBd3xdEdTaKThN5ZktnVzOWe4s+GviknmgfQl
         xsOeurX4yvh1Zln4IwYRA6GUFEKjgiJKE+brRTS5JItNbazdBznQsAiqcfFEiqsSmIBl
         8EPw==
X-Gm-Message-State: AOJu0YzBj8c9mLestXIos+9C8jZ0pdCjbWRGvAB2biG02NU8aEVpK1yR
	7kd5GbF9S+uyu4rG4ed30Y6PkIKNOqG2ucjoDIRlVW96veP2N308OhDhzQUS2Q==
X-Gm-Gg: ATEYQzwQ/sNtxZnxPN+q2KmbmvMOw5HJbu99HYNnYbiMxrZzm6fjtV27cmZPWSy7+D1
	cNCeay0TO8Z2p2NVUN1z4DAAHWcFJg5xwVU9w5VruhvfQhE6lYphmZ4+DWzGFhvw5bAXqWgo2ts
	5tnWBxRn6I+mIa/S4xnkm2YopdzUdphmXa8bXLONr6qshQtoR/1mo5QE8lAAamQ5+eZUIJGfmeH
	nUUCEDwI24aIA4aeAHhfv+9K+/lddyS6lhpDkKQ5suCEV5/JoeWz6mmS+727R1kSuDH6X26nH8Z
	3kTiACwYIfqTEvWWJANNEHwuS+M8x2g+Hz5hvgtVgt6RtSwKhmgWwyVh2UlYwgUkCNcim/jq4Vg
	1+S5h0tz6Xhuisvvq3g7HfPBjfhP/Y+X5v0XxtFpNK4DKI2lCyRA5oAdulad4ZKG3T7+7xCyuW6
	25D0HgVKSJUjXHXXASK1MsqBnO7Qk=
X-Received: by 2002:a05:7022:a8e:b0:11b:3eb7:f9d7 with SMTP id a92af1059eb24-127890d4f6amr3234969c88.14.1772220657012;
        Fri, 27 Feb 2026 11:30:57 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899d49ccsm6234789c88.3.2026.02.27.11.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:30:56 -0800 (PST)
Message-Id: <1bc100d6cab3b77badb5d79fb8133e22a35bd96e.1772220640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 19:30:39 +0000
Subject: [PATCH v5 10/11] repo: reduce repetition in structure keyvalue output
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Refactor structure_keyvalue_print() to use small helpers for
single-key and per-object-type metrics.

This makes the output section easier to review and reduces
copy/paste risk while keeping output keys unchanged.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 156 ++++++++++++++++++++++++-------------------------
 1 file changed, 76 insertions(+), 80 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index cb70171412..ecd9d3aee5 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -821,6 +821,27 @@ static void stats_table_clear(struct stats_table *table)
 	string_list_clear(&table->rows, 1);
 }
 
+static void print_keyvalue_size(const char *key, size_t value,
+				      char key_delim, char value_delim)
+{
+	printf("%s%c%" PRIuMAX "%c", key, key_delim, (uintmax_t)value,
+	       value_delim);
+}
+
+static void print_object_values(const struct object_values *values,
+				const char *metric,
+				char key_delim, char value_delim)
+{
+	printf("objects.commits.%s%c%" PRIuMAX "%c", metric, key_delim,
+	       (uintmax_t)values->commits, value_delim);
+	printf("objects.trees.%s%c%" PRIuMAX "%c", metric, key_delim,
+	       (uintmax_t)values->trees, value_delim);
+	printf("objects.blobs.%s%c%" PRIuMAX "%c", metric, key_delim,
+	       (uintmax_t)values->blobs, value_delim);
+	printf("objects.tags.%s%c%" PRIuMAX "%c", metric, key_delim,
+	       (uintmax_t)values->tags, value_delim);
+}
+
 static void structure_keyvalue_print(struct repo_structure *stats,
 				     char key_delim, char value_delim)
 {
@@ -831,86 +852,61 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	size_t max_inflated_size = get_max_object_value(&stats->objects.max_inflated_sizes);
 	size_t max_disk_size = get_max_object_value(&stats->objects.max_disk_sizes);
 
-	printf("references.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)references_count_total, value_delim);
-
-	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->refs.branches, value_delim);
-	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->refs.tags, value_delim);
-	printf("references.remotes.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->refs.remotes, value_delim);
-	printf("references.others.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->refs.others, value_delim);
-
-	printf("objects.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)object_count_total, value_delim);
-
-	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.type_counts.commits, value_delim);
-	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.type_counts.trees, value_delim);
-	printf("objects.blobs.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.type_counts.blobs, value_delim);
-	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
-
-	printf("objects.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)inflated_size_total, value_delim);
-
-	printf("objects.commits.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.inflated_sizes.commits, value_delim);
-	printf("objects.trees.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.inflated_sizes.trees, value_delim);
-	printf("objects.blobs.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.inflated_sizes.blobs, value_delim);
-	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
-
-	printf("objects.max_inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)max_inflated_size, value_delim);
-	printf("objects.commits.max_inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_inflated_sizes.commits, value_delim);
-	printf("objects.trees.max_inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_inflated_sizes.trees, value_delim);
-	printf("objects.blobs.max_inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_inflated_sizes.blobs, value_delim);
-	printf("objects.tags.max_inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_inflated_sizes.tags, value_delim);
-
-	printf("objects.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)disk_size_total, value_delim);
-
-	printf("objects.max_disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)max_disk_size, value_delim);
-	printf("objects.commits.max_disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_disk_sizes.commits, value_delim);
-	printf("objects.trees.max_disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_disk_sizes.trees, value_delim);
-	printf("objects.blobs.max_disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_disk_sizes.blobs, value_delim);
-	printf("objects.tags.max_disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_disk_sizes.tags, value_delim);
-
-	printf("objects.commits.max_parent_count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_commit_parent_count, value_delim);
-	printf("objects.trees.max_entry_count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_tree_entry_count, value_delim);
-	printf("objects.blobs.max_path_length%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_blob_path_length, value_delim);
-	printf("objects.blobs.max_path_depth%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_blob_path_depth, value_delim);
-	printf("objects.tags.max_chain_depth%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.max_tag_chain_depth, value_delim);
-
-	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
-	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.disk_sizes.trees, value_delim);
-	printf("objects.blobs.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.disk_sizes.blobs, value_delim);
-	printf("objects.tags.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
+	print_keyvalue_size("references.count", references_count_total,
+			   key_delim, value_delim);
+
+	print_keyvalue_size("references.branches.count", stats->refs.branches,
+			   key_delim, value_delim);
+	print_keyvalue_size("references.tags.count", stats->refs.tags,
+			   key_delim, value_delim);
+	print_keyvalue_size("references.remotes.count", stats->refs.remotes,
+			   key_delim, value_delim);
+	print_keyvalue_size("references.others.count", stats->refs.others,
+			   key_delim, value_delim);
+
+	print_keyvalue_size("objects.count", object_count_total,
+			   key_delim, value_delim);
+
+	print_object_values(&stats->objects.type_counts, "count",
+			    key_delim, value_delim);
+
+	print_keyvalue_size("objects.inflated_size", inflated_size_total,
+			   key_delim, value_delim);
+
+	print_object_values(&stats->objects.inflated_sizes, "inflated_size",
+			    key_delim, value_delim);
+
+	print_keyvalue_size("objects.max_inflated_size", max_inflated_size,
+			   key_delim, value_delim);
+	print_object_values(&stats->objects.max_inflated_sizes,
+			    "max_inflated_size", key_delim, value_delim);
+
+	print_keyvalue_size("objects.disk_size", disk_size_total,
+			   key_delim, value_delim);
+
+	print_keyvalue_size("objects.max_disk_size", max_disk_size,
+			   key_delim, value_delim);
+	print_object_values(&stats->objects.max_disk_sizes, "max_disk_size",
+			    key_delim, value_delim);
+
+	print_keyvalue_size("objects.commits.max_parent_count",
+			   stats->objects.max_commit_parent_count,
+			   key_delim, value_delim);
+	print_keyvalue_size("objects.trees.max_entry_count",
+			   stats->objects.max_tree_entry_count,
+			   key_delim, value_delim);
+	print_keyvalue_size("objects.blobs.max_path_length",
+			   stats->objects.max_blob_path_length,
+			   key_delim, value_delim);
+	print_keyvalue_size("objects.blobs.max_path_depth",
+			   stats->objects.max_blob_path_depth,
+			   key_delim, value_delim);
+	print_keyvalue_size("objects.tags.max_chain_depth",
+			   stats->objects.max_tag_chain_depth,
+			   key_delim, value_delim);
+
+	print_object_values(&stats->objects.disk_sizes, "disk_size",
+			    key_delim, value_delim);
 
 	fflush(stdout);
 }
-- 
gitgitgadget

