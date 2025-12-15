Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A93328B44
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765832220; cv=none; b=bfsVVJQay0g/X8gdToBqcm/51JzqRbtEXqkuxNseCXZqU8RBfzGvGnK2LnSVUbwHktmePzqkNiPQdE3+bzZCR0CB+RqwOmBTMzqNSaC804rYanQP3DpOoRj49FIVOla+c1c6g0Er7cxOxFs00Rfs8aYBj1VFvv+/LgUP3a8Gxyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765832220; c=relaxed/simple;
	bh=FAzlIEAg7lji6To9KspyUTQzrdmO+gQT3sJyA/dwjCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8Bcsf8OkMPFL8t0kvqg8BEW5SHXeMNXn2DMaceasgPEirVhMcfrXhG1fPgMQjB2SDsDnB9/Ynw97hEiuWynOZFDftHvo+VgATtfhKJ4DG8wBOTcs9BHGeRK+uTcyYli8jRFZGjaiD9YvSx9jXtYfyqns9/2qvaqvIk/fJUCqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoFEvJAY; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoFEvJAY"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6597cf49101so2294727eaf.2
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765832217; x=1766437017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkH+fsxdsr3rwTGKJkwYTnUv+u8jviY9EE0qRaSNVKo=;
        b=SoFEvJAYI9nLxoO+CDJldUullzhZNSsk/7Mu8WqWnIJtqsmcwBHcV+Nv//SP949wiC
         w8KENcHKwOu+BBrp5O1K2BMBktrEhfpg25OBW3cQNllgkgqSGYV6CNzCBodZ4Moq1byF
         MT7crhk4NL2niylJyExEqeRO7wz9lG9vFcBr2dmGFPr6lfgcmAM+/71UYDbQKjisorpp
         QeyNHhEUX0si8MjJQXVSATvv8FmiIm4A4ELAC1X88Mt54WLu3BG3M5AgzWY7E/1LSZSM
         9Azm+zTKX+5reReO/7mDobKxx+VwtFbVqPHuAckzJjEAnf0gDcRAilfWo3FUk08OzEsk
         22Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765832217; x=1766437017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dkH+fsxdsr3rwTGKJkwYTnUv+u8jviY9EE0qRaSNVKo=;
        b=IkJC0CcuvT8t2DeEPdmKHLLNCWqwmI7S/8FX+uGX7CNshbDavN2shMuIaJlWoHn25Z
         Vz3HfqHg3M1W7VcL3CnsnMsfTvZd1l4CClxKtrcYe65WpPQ9WeO86T0jl9u3UoLnQ6Zy
         8yP46zZgz6e74U8fXWQSz3SbSwe4wgLJm+A7u0Pur6i8kn1Zin3cKZVPSolWZBq3heGE
         q/7rHpU/1IfA5y3qxDjL10S/Nzx4u2wrMQ+BjMlP3jvg6EHz3POQ0ktQNK83dJcrpAbr
         CuSY1kihSs3g6IhzMs80a6CrDLPcPpLqLcdtZxbAMempGQ4SlDjqFtnnkIEHgmTmlLyH
         asjg==
X-Gm-Message-State: AOJu0YzSQbtn6Rv9eyPwMTzXVbVO0ivtuXNyQIMB0LOLMtqS1A77W3Um
	EnT8WINJFfrNKLPEuiX8amOHEY8KKDSIwi18EfbghNUId68AjlBQcoVMxYumnQ==
X-Gm-Gg: AY/fxX7qeFS0ylXN6O/PvVAEQY/+wEwWrjXpnGYFX2a0EQhEeghjUVzU7VVEihdv1eu
	W9BBbG/cVzgkRm2nz4/bfYOVZl6MwFxm6dkbidgsfiLRRJbIPICN3f9ewlrUj8Q53at3ebhSMJC
	TJWb8wu6jtqNn+E4x0g0r63QwHrJthrVg0OL0ylMJdF0pxLeffLmkUWoHa1mDP4fF3afkCNZsVO
	3mg2k5tWqIxrmpkMikdxQeeEN90mms7pK0RL1/uXZBRy6HGGrMA1H1EzFmBfk7ttKQVoc56Z35L
	HILeJeyxKeje1mH7Wf3Fvwdn5BKkljOzeXHMkJGhFXrS40FdhhofLPeIW6iJEeOrktR+4dqRFdc
	kea6UWF1CIulZSzsueKKUz5cByCxr3bzMuZYUhNvLk+Ty8179Zxo3kW3zzAnO/J8vvENngZf63q
	vpM4FNBqIzdEpEGA6ovXg0UhQXC6z7Ag==
X-Google-Smtp-Source: AGHT+IFLi94jnjHcqeLKsD5MoCSwv2Vns055cTR5K7Ju57TPcFtHMOOoM7/sQt3x07MNbi9fSP2G3A==
X-Received: by 2002:a05:6820:1523:b0:659:9a49:8ead with SMTP id 006d021491bc7-65b4523b56fmr5447183eaf.49.1765832217383;
        Mon, 15 Dec 2025 12:56:57 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b360f0f4fsm8778898eaf.14.2025.12.15.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:56:56 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 6/7] builtin/repo: add disk size info to keyvalue stucture output
Date: Mon, 15 Dec 2025 14:56:38 -0600
Message-ID: <20251215205639.2700270-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251215205639.2700270-1-jltobler@gmail.com>
References: <20251212223644.3090879-1-jltobler@gmail.com>
 <20251215205639.2700270-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to a prior commit, extend the keyvalue and nul output formats of
the git-repo(1) structure command to additionally provide info regarding
total object disk sizes by object type.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |  1 +
 builtin/repo.c              | 18 ++++++++++++++++++
 t/t1901-repo-structure.sh   | 11 ++++++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 287eee4b93..861073f641 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -51,6 +51,7 @@ supported:
 * Reference counts categorized by type
 * Reachable object counts categorized by type
 * Total inflated size of reachable objects by type
+* Total disk size of reachable objects by type
 
 +
 The output format can be chosen through the flag `--format`. Three formats are
diff --git a/builtin/repo.c b/builtin/repo.c
index b73cfd975b..0ed41bf9d4 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -214,6 +214,7 @@ struct object_values {
 struct object_stats {
 	struct object_values type_counts;
 	struct object_values inflated_sizes;
+	struct object_values disk_sizes;
 };
 
 struct repo_structure {
@@ -462,6 +463,15 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
 
+	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
+	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.trees, value_delim);
+	printf("objects.blobs.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.blobs, value_delim);
+	printf("objects.tags.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
+
 	fflush(stdout);
 }
 
@@ -536,13 +546,16 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 	struct count_objects_data *data = cb_data;
 	struct object_stats *stats = data->stats;
 	size_t inflated_total = 0;
+	size_t disk_total = 0;
 	size_t object_count;
 
 	for (size_t i = 0; i < oids->nr; i++) {
 		struct object_info oi = OBJECT_INFO_INIT;
 		unsigned long inflated;
+		off_t disk;
 
 		oi.sizep = &inflated;
+		oi.disk_sizep = &disk;
 
 		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
 						  OBJECT_INFO_SKIP_FETCH_OBJECT |
@@ -550,24 +563,29 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			continue;
 
 		inflated_total += inflated;
+		disk_total += disk;
 	}
 
 	switch (type) {
 	case OBJ_TAG:
 		stats->type_counts.tags += oids->nr;
 		stats->inflated_sizes.tags += inflated_total;
+		stats->disk_sizes.tags += disk_total;
 		break;
 	case OBJ_COMMIT:
 		stats->type_counts.commits += oids->nr;
 		stats->inflated_sizes.commits += inflated_total;
+		stats->disk_sizes.commits += disk_total;
 		break;
 	case OBJ_TREE:
 		stats->type_counts.trees += oids->nr;
 		stats->inflated_sizes.trees += inflated_total;
+		stats->disk_sizes.trees += disk_total;
 		break;
 	case OBJ_BLOB:
 		stats->type_counts.blobs += oids->nr;
 		stats->inflated_sizes.blobs += inflated_total;
+		stats->disk_sizes.blobs += disk_total;
 		break;
 	default:
 		BUG("invalid object type");
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index b18213c660..dd17caad05 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -4,6 +4,11 @@ test_description='test git repo structure'
 
 . ./test-lib.sh
 
+object_type_disk_usage() {
+	git rev-list --all --objects --disk-usage --filter=object:type=$1 \
+		--filter-provided-objects
+}
+
 test_expect_success 'empty repository' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -91,7 +96,7 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		test_commit_bulk 42 &&
 		git tag -a foo -m bar &&
 
-		cat >expect <<-\EOF &&
+		cat >expect <<-EOF &&
 		references.branches.count=1
 		references.tags.count=1
 		references.remotes.count=0
@@ -104,6 +109,10 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		objects.trees.inflated_size=28554
 		objects.blobs.inflated_size=453
 		objects.tags.inflated_size=132
+		objects.commits.disk_size=$(object_type_disk_usage commit)
+		objects.trees.disk_size=$(object_type_disk_usage tree)
+		objects.blobs.disk_size=$(object_type_disk_usage blob)
+		objects.tags.disk_size=$(object_type_disk_usage tag)
 		EOF
 
 		git repo structure --format=keyvalue >out 2>err &&
-- 
2.52.0.209.ge85ae279b0

