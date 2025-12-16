Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045429B8FE
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906765; cv=none; b=bx1Y6lpAuLY8JWYc6fY5qHBUUrrbxHS2zI5o9lwq4AP/dS7TvzNZUXV0g3nlmpU7MdnNbqcK5NKC4OO6S/u6U9hfNKj0qAeyQiWmXxVZO67iMC8ohUAndWIgTECLfdhNdzfyMMtMV6x09Xv+Lh5fbTsdpDuSZwsosiiQzq2kkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906765; c=relaxed/simple;
	bh=lbAuWkGQQIZIOLvu4WlP1Am3TLV3ukHwGKphqz2g8NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJA5ECuOdB4jpH5e69HF593Cb8GZ4zuO9SpXC8RbvgUzhRODenU1Nx6tJVqihQ742EX9lmQCgQnzS154jrCC/UOVNIRCw2P5S41vmJBwBqCuy7gM0oAbc4T3T86/G9r3g2R//qrgxubiAR1SC0OvT+7Lh//HGqEWskGsd+SNT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHdfUcCW; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHdfUcCW"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3f551ad50d1so1761956fac.0
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765906760; x=1766511560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=597qRwArHUV73rYg4v0XUL1bN4CGcDd9jlULQOCXCUY=;
        b=EHdfUcCWnasPk69Ewtz/JwkRZ3eRhrMF/4Cs72mx947pHbnnhabIEgSueeBNXwj5NZ
         XITs+uUbrc5uWeH0rXBKTDEaNrcAv6MPPtgJ2Z5V0ltvkktQ/vPkWd8xkGlaf0sDbKfc
         0KMLBqqorc7RNikYAAMWcDUl5qeiUIDe8Yjpf7/K4Z6d8in6M6u1bLe2cxgmPAdY8g5z
         j05j/uza2uYGPTfP47z4vxtEPN19pvf8KbrB+fyeuNqRYuqnYgYhpp5D+1yOMHHKiM4l
         lKr1n/CdL4Q2Q16YAkkX9hMLGvEG8xUbAB7rqDsNUdBY0VYH4j6u5qbJ6mBUqVpnrog1
         zF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906760; x=1766511560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=597qRwArHUV73rYg4v0XUL1bN4CGcDd9jlULQOCXCUY=;
        b=EK7HjLthufPScWnf+wKV4Glp2Q3zrrnak/Y27Mwfqgcrxtxz9BwSpaULk/sXDYBlPS
         bc09vsU8A6aPWTDztxHpsJJy1ATR/7M+wKhX3OhWKptwkBi0gFRF/nl03VWTZGRETHha
         HN9Tn4JXAfuCpyyZJf1wjNeZ0+ot3ej/N1TdGNM5TXxqGref738LWzajIGwoInqMATXe
         YiSJEOOIHiD4T5MJ4ZFcMrIjFdEvWejN+6JFdkwuJ4C/utPljmV6JnkgM+xNdVtUvJ8C
         ZZhyar4YQDLBvphwNMju4RI5iyVQmQju3m5bMJZw7NRN9KHBh/s2Ga5U6p7aOfH59V+K
         my6Q==
X-Gm-Message-State: AOJu0YyQp0B879BAZUB8fvz40p9mPmMqKf2ZOvoY8qUuIc+Qjj0Knzvp
	p/+FbRDC/DrYgWKds+xVsX7cyWBdfo0eUXfc7FgFYzMoZYqsrvgN1HwVWv2TkA==
X-Gm-Gg: AY/fxX6XAPu4M8TJMj4HccuR4kIj6y/m8Vy+e5KYB/OpQ0UrTJ/QhMIwjl6s0r9aaX7
	/B133HrNPUHOLPF3KsesUS+/vjvzyn/N2LeXwK7crZWVztOP9uePIfjJBotukJymRWQb4qcxRGo
	ycZsJdNc9UauBDy62zuevqwTYew9ma2nDRRtXbTPThTT+6XcyClmoQBsvlgJNdZNuoL5qDpo3Hr
	OKxZSEOtY8OeYhMjtHsWY4wWKxRBcWSJF39mpsxd/Q4DDaAllzNqG4HmTKozKKflM+dpclK/RPh
	GbrcqfdgFi/nGhGgHz/GSf+r0kKAykcAWXI56jymJnoRB+vESZ5gIEWb9Wv48svmD7xGicQ4+Oh
	Ks3dlDHL0QPX4nrW2rMXuggBEx4xKUq+8Wui+uAKMq4QBrakksLa2aJWxRcGJ2++ZtIQvIGeQFN
	Eqsg/P4xFhfb6lYhGMQ+g=
X-Google-Smtp-Source: AGHT+IHrnfcHsn0t1oSnDTEamT8U+9zYDHheM20iAyFlArd0QSed2h/S+ZK/Gm3A0kMW899Mk1Q5Ew==
X-Received: by 2002:a05:6871:b07:b0:3ec:41eb:6e48 with SMTP id 586e51a60fabf-3f5f890fb0fmr7350274fac.40.1765906760486;
        Tue, 16 Dec 2025 09:39:20 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm6438462fac.10.2025.12.16.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:39:19 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 7/7] builtin/repo: add object disk size info to structure table
Date: Tue, 16 Dec 2025 11:38:42 -0600
Message-ID: <20251216173842.3357832-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251216173842.3357832-1-jltobler@gmail.com>
References: <20251215205639.2700270-1-jltobler@gmail.com>
 <20251216173842.3357832-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to a prior commit, update the table output format for the
git-repo(1) structure command to display the total object disk usage by
object type.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            | 13 +++++++++++++
 t/t1901-repo-structure.sh | 31 ++++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ed41bf9d4..a071d2fdfe 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -324,6 +324,7 @@ static void stats_table_setup_structure(struct stats_table *table,
 	struct ref_stats *refs = &stats->refs;
 	size_t inflated_object_total;
 	size_t object_count_total;
+	size_t disk_object_total;
 	size_t ref_total;
 
 	ref_total = get_total_reference_count(refs);
@@ -358,6 +359,18 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->inflated_sizes.tags,
 			      "    * %s", _("Tags"));
+
+	disk_object_total = get_total_object_values(&objects->disk_sizes);
+	stats_table_size_addf(table, disk_object_total,
+			      "  * %s", _("Disk size"));
+	stats_table_size_addf(table, objects->disk_sizes.commits,
+			      "    * %s", _("Commits"));
+	stats_table_size_addf(table, objects->disk_sizes.trees,
+			      "    * %s", _("Trees"));
+	stats_table_size_addf(table, objects->disk_sizes.blobs,
+			      "    * %s", _("Blobs"));
+	stats_table_size_addf(table, objects->disk_sizes.tags,
+			      "    * %s", _("Tags"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index dd17caad05..1b68525079 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -5,8 +5,20 @@ test_description='test git repo structure'
 . ./test-lib.sh
 
 object_type_disk_usage() {
-	git rev-list --all --objects --disk-usage --filter=object:type=$1 \
-		--filter-provided-objects
+	disk_usage_opt="--disk-usage"
+
+	if test "$2" = "true"
+	then
+		disk_usage_opt="--disk-usage=human"
+	fi
+
+	if test "$1" = "all"
+	then
+		git rev-list --all --objects $disk_usage_opt
+	else
+		git rev-list --all --objects $disk_usage_opt \
+			--filter=object:type=$1 --filter-provided-objects
+	fi
 }
 
 test_expect_success 'empty repository' '
@@ -35,6 +47,11 @@ test_expect_success 'empty repository' '
 		|     * Trees          |    0 B |
 		|     * Blobs          |    0 B |
 		|     * Tags           |    0 B |
+		|   * Disk size        |    0 B |
+		|     * Commits        |    0 B |
+		|     * Trees          |    0 B |
+		|     * Blobs          |    0 B |
+		|     * Tags           |    0 B |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -58,7 +75,10 @@ test_expect_success SHA1 'repository with references and objects' '
 		# Also creates a commit, tree, and blob.
 		git notes add -m foo &&
 
-		cat >expect <<-\EOF &&
+		# The tags disk size is handled specially due to the
+		# git-rev-list(1) --disk-usage=human option printing the full
+		# "byte/bytes" unit prefix instead of just "B".
+		cat >expect <<-EOF &&
 		| Repository structure | Value      |
 		| -------------------- | ---------- |
 		| * References         |            |
@@ -79,6 +99,11 @@ test_expect_success SHA1 'repository with references and objects' '
 		|     * Trees          |  15.81 MiB |
 		|     * Blobs          |  11.68 KiB |
 		|     * Tags           |    132 B   |
+		|   * Disk size        | $(object_type_disk_usage all true) |
+		|     * Commits        | $(object_type_disk_usage commit true) |
+		|     * Trees          | $(object_type_disk_usage tree true) |
+		|     * Blobs          |  $(object_type_disk_usage blob true) |
+		|     * Tags           |    $(object_type_disk_usage tag) B   |
 		EOF
 
 		git repo structure >out 2>err &&
-- 
2.52.0.209.ge85ae279b0

