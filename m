Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063962FBE11
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 22:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321115; cv=none; b=XshOWoQPbiFV3mwNWk9FksHhKsdnwWxVxkni7DvPhkhcTS4dkbvivKeZTMWE1M7rYf1FRHF80nNa3FcFVEVuzA+VF9PH4zzWK36RirmAkuHGI21ljj2Q0tgRa3KItuEJFaZA9UQNMAIgZVmQwFeHrxYph7qebAwtN54raLX1uRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321115; c=relaxed/simple;
	bh=li8tmLTRz2cUinkyEc3qbZLF19yNZr86WLNLdSxI2Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPD2+NKvjSrJgP4OUa8d+K4VBT2vOJTa5FcdMW0M3A8IJ5XsF5hvUpP9fi8l9yciKOrntkW9r2lNqjUaxc3MqraUUyH5Kfc9YGiK8u+4/Ee0PGuccadGf0CTIYQT8D3SuNhXxtDFLh8PtLViL2wvS1N4HYlIYi6uj2dYMdryruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auEZwAX5; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auEZwAX5"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-455749af2e1so188506b6e.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 14:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765321111; x=1765925911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1tETqgJzhZ2x/XgHZMOOuvjREDJ70fBTBG+RqxqAzQ=;
        b=auEZwAX5OgLOeEEz1uwsdKGSvhU3GZSQGArkbS0xEgobd4txN/egBGaa8E0PIB/Nh3
         emeV8ObCZgBaef+rFBwk7u5bsd5pXiKsy1L0gXd/rULZHeiiGh35KpMc6o0/tdvYxJrc
         QqhSH4IWsgPnb3GTqgfykwA6Zcpjgf+/L+sGiLV/EVg9MKuIWX5XTrNqHoez8rhzGwqT
         73miUamBK+RM25zAhbIkQdaGVX6Asnhbu9d7xjH+h1P633OT4bNIpr20ac0ZDKH0lXDy
         /sJ1jNU/gxrRnIKQLK6JU0JuwGvtZKh0YHpG1/Of7iR0kyMqGFLOpUpgUhHZ/9/140WF
         W/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765321111; x=1765925911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1tETqgJzhZ2x/XgHZMOOuvjREDJ70fBTBG+RqxqAzQ=;
        b=gTNk0WoaMig9qcjTDMp+cmBCTuwznLThqZuF4fwABtWY5n95bJvPolsuY7pXeROfJ7
         AbDv7I80pj7zl9CLwGBUzsvCeiangTIwW1de+FEcZChjkkw+RvqKrPxCk3NXfWgckKgs
         Foz4PqqfkHAZZM1sjWvkWVCTyej0TqSsJ5RLMdkId6A6PoIvqjoJPviEqHteQIemyVqi
         qE9gc1HxfplSZpJ0xMl2QqfZUTBdfLNlNxHCAT5L50Eov7N1TtUKuGmVLzp2zhSUnSjN
         ZJcRGguq4n0WZHg5Rk2vqtGTYWMjvTrWvbOqusABd8B6j9vD3ti3w2L2K+6sYWSXMAP+
         2qqw==
X-Gm-Message-State: AOJu0YyCIyughYtF/GQpwx4uYhhVwnFLJ9pY8x6PNa/nvvIr2xfJpRb2
	Y3uB6GnmNjeOpt3fjq3Tx0b1JLp7CcLMREIMX/1d2ZB0jEGhTvH9ljkuhGvnvw==
X-Gm-Gg: ASbGncsL6SWtEazO0g+5Ziku1y9MgjT8yGZ7+qN2tGirKNBde8WBWwN1VX5ibl0wSta
	bOC24B4REHRQ6vAIjDVi/N43JgR3MCMhYDwB4oDWZmUjk/UGs4yy0Es/7OEsPif0XabYlRtCnSl
	9LpBbXsYuAfYeYwGyoz76soVaQSKacChwXeLhJtjRDFFIRhj3qNIEiatR9CFO9jyrh2p3TnkDWU
	7kSDllO+pi1qNC8CZbQWyngo6Gldcr2oxX+4au51DEUSx6Fbqqn3UI6SyLeA+jfjIeGEX+g4mAO
	lSM841Xved5Tm1lFk6hLEDqJmK5mkzLcB9ZuiGM/15zUenCACIM/9/RYWQWImYT1+7swojfQ0/i
	b4KR8iF0GryzZ7rllyYwiUUhibrJk1rmnJ+nakA+DAEZ5QRk3gglFOlob834Ie/LdaMZSm+WX86
	2Cdb58XbJhCDjAoDJvEfA=
X-Google-Smtp-Source: AGHT+IEOl8P+a6PjP8dJKNJzlYpfjpyGQCWS/fPnCXBBnu41umBZWl8/z9fHey64QYx3hI5MCgk+Ww==
X-Received: by 2002:a05:6808:16a9:b0:43f:68b:acb3 with SMTP id 5614622812f47-4558756302cmr195369b6e.17.1765321111125;
        Tue, 09 Dec 2025 14:58:31 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537f8a02desm8161354b6e.5.2025.12.09.14.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 14:58:30 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 5/6] builtin/repo: add disk size info to keyvalue stucture output
Date: Tue,  9 Dec 2025 16:58:19 -0600
Message-ID: <20251209225820.2861276-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251209225820.2861276-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
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

Since disk size may vary between platforms, tests do not validate actual
values and only check that size info is printed in an empty repository.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |  1 +
 builtin/repo.c              | 18 +++++++++++++++
 t/t1901-repo-structure.sh   | 45 +++++++++++++++++++++++++++++--------
 3 files changed, 55 insertions(+), 9 deletions(-)

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
index 5c37f4116f..8ea7c9b24f 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -214,6 +214,7 @@ struct object_values {
 struct object_stats {
 	struct object_values type_counts;
 	struct object_values inflated_sizes;
+	struct object_values disk_sizes;
 };
 
 struct repo_structure {
@@ -509,6 +510,15 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.inflated%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
 
+	printf("objects.commits.disk%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
+	printf("objects.trees.disk%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.trees, value_delim);
+	printf("objects.blobs.disk%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.blobs, value_delim);
+	printf("objects.tags.disk%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
+
 	fflush(stdout);
 }
 
@@ -583,13 +593,16 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
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
 						  OBJECT_INFO_FOR_PREFETCH) < 0)
@@ -597,24 +610,29 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			    oid_to_hex(&oids->oid[i]));
 
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
index 0ae96e6bbf..a98c651f1d 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -35,6 +35,37 @@ test_expect_success 'empty repository' '
 		git repo structure >out 2>err &&
 
 		test_cmp expect out &&
+		test_line_count = 0 err &&
+
+		cat >expect <<-\EOF &&
+		references.branches.count=0
+		references.tags.count=0
+		references.remotes.count=0
+		references.others.count=0
+		objects.commits.count=0
+		objects.trees.count=0
+		objects.blobs.count=0
+		objects.tags.count=0
+		objects.commits.inflated=0
+		objects.trees.inflated=0
+		objects.blobs.inflated=0
+		objects.tags.inflated=0
+		objects.commits.disk=0
+		objects.trees.disk=0
+		objects.blobs.disk=0
+		objects.tags.disk=0
+		EOF
+
+		git repo structure --format=keyvalue >out 2>err &&
+
+		test_cmp expect out &&
+		test_line_count = 0 err &&
+
+		# Replace key and value delimiters for nul format.
+		tr "\n=" "\0\n" <expect >expect_nul &&
+		git repo structure --format=nul >out 2>err &&
+
+		test_cmp expect_nul out &&
 		test_line_count = 0 err
 	)
 '
@@ -83,7 +114,7 @@ test_expect_success SHA1 'repository with references and objects' '
 	)
 '
 
-test_expect_success SHA1 'keyvalue and nul format' '
+test_expect_success SHA1 'keyvalue format' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -106,16 +137,12 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		objects.tags.inflated=132
 		EOF
 
-		git repo structure --format=keyvalue >out 2>err &&
+		git repo structure --format=keyvalue >out.raw 2>err &&
 
-		test_cmp expect out &&
-		test_line_count = 0 err &&
+		# Strip object disk usage from output due to platform variance.
+		grep -v "objects\..*\.disk=" out.raw >out &&
 
-		# Replace key and value delimiters for nul format.
-		tr "\n=" "\0\n" <expect >expect_nul &&
-		git repo structure --format=nul >out 2>err &&
-
-		test_cmp expect_nul out &&
+		test_cmp expect out &&
 		test_line_count = 0 err
 	)
 '
-- 
2.52.0.209.ge85ae279b0

