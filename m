Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F93451BF
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994056; cv=none; b=QDhjWwICzyfyaxR9MDYv8vXPy0Jo4d2zZqHvtGHdyLp0BeCAn9rN0R3zYBH3jvKJudi1Q4yuQW8XXM4jpaGZY7eULmxgoz7ufroJtZbkVJc+uvUAM29w7y9n+XNRFZmDM/Wh+HOkKDU/D/4tJgQHZVb1/QpP95ApvMSmGPHgrMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994056; c=relaxed/simple;
	bh=fN5Ho9DKwMoNwvK6FkywSbGo1zJ71OgXyfCbDXO4qV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bL/sUDIptdFfRCcbT8J5iMjDE1ph0kNKEN0Os+xSpJ6vP0ckzpfKMX0l5itHQdL4ezmjH/KnPv0g4Q/BV6Y1oWnBl/efXU3YCjNbECZqvS3S4ALWamhllfpVaJWD5EtfTimUzfkFfl6VngR4/BAlPArC5PAV7jOnx+MbG1gxYfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSbqvlbX; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSbqvlbX"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-656d9230cf2so3399291eaf.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 09:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765994053; x=1766598853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3xVGMTuV4qMUcgNkLKPyRxgK2IWRpRtDAO0wyQO6aI=;
        b=dSbqvlbXEjhjs2ft8reQNraEx+h6RrLPkiqxHLs2bEfoixYKU8muJCXhUtVFY0qXJg
         K8asEfw0GNdDyZicg7mf0u//F8OwDiIKpkmJWd8JuoFuuGbWdIpDGAdls5SEoFw1ymYR
         IFY+G6a7fXqBlTcfo1Xz9Z9ZnLCXfsLR5rOVu/MoeQS1xR6mKfv88dVpQPthhTEjj93S
         dJLX3pg5uVf0zPMKmhlNeeCutJj2KiJ+4c6MVazJy0RBQucMKHzcU1k4fBtfgiWpe0uB
         8mgppUZ3MHynm9W8oBbWYo1HQdT538jIALsh9NmQh60u0PL1k089sXIUmhyGrEN6onAS
         OyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994053; x=1766598853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3xVGMTuV4qMUcgNkLKPyRxgK2IWRpRtDAO0wyQO6aI=;
        b=BA2KDl3iIfO1IaHRTndffhrT5Xudy/NacSYACROoxHD3oF4oPXBFCD5xYf8TxAqZ+K
         9WTYdoYfR3fVrT4A0gPOXKSfVCiM141BF2FzcytNT6GLfcyRZgMT6LHXDHS2hErVLn79
         LppfGHt63qxwC/jBhP60tnyP/F+rf9c8oKKR4llvnCG0SYNw8DvCrEHiBz3a6yiLhaem
         RMPR8ZLLPGtRKCAT2bcMefwPApRjSRzfwL1yIkIcej5jrNfVaXtfLCekIyyqBwn+sXd0
         jodXYz7FWtcqq9gF4sOVcJIzxrWlqUKBMaVkn53t1idafWao1d2pxMDAkYKS6BmSEZt1
         KTMw==
X-Gm-Message-State: AOJu0YykpyPiohuzxxSULOkC8JEE9juzk9Bpu/DgjqVw7CyKhF4psNZ1
	yz7SWKUQRjsci+CskRYSR2aRlgNMLjO/nrAqNXnU1H5BPSMunMZbTPkrRhZ3+w==
X-Gm-Gg: AY/fxX7kvVvFQH2JVJnBcG6ML7lv1Oy05f5DqEm+KYKKMAjkyOQ1RmpSUNMY2Apvofn
	1l3sXCzMgMBsEzTpJ1t473ZfOFgZYQCuaLNB7Tysy0eWndIBl9PRNSJj3Gwl3QOPFDTYdiBGXk0
	2W9A5Ozh13fZ32Y5Gpn1wqv3DLUhKemJz7zGkjyVF4zS2pxbj4XZtRnAihHQ8p58fZy4xyuGSG/
	lz/qWYVv00AwXCWQa035qgiDDEcow0kLDdzmIPRz/HXgs0+liCMu5tJYeeTLuCkChtS2/t4W24k
	LhPX8Mtoh8Oo3qS01Aj2GUHRhubF15hCpkzAifPkXg/AVmsUIXZ1AkVmUobUGA+JwUkFHA+SdAl
	wdaD3m9+QAdOcjA23x0dBM7KFes7Jt1VkvT5pYgFnw20snCNqRLu+OFdEFd6veYrGq4f1VDKOXq
	fSNuJD6o8vSSmoEHi6Zmc=
X-Google-Smtp-Source: AGHT+IHYXN3NLyc/QClVnCbPEkYdM0gi/Th7PnqDXnLOt4jBB9t2l2j2fU4HQuylpM0I7nHuFAqq9Q==
X-Received: by 2002:a05:6820:622:b0:65c:f991:e805 with SMTP id 006d021491bc7-65cf992076emr630488eaf.37.1765994052737;
        Wed, 17 Dec 2025 09:54:12 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17f4b879sm20058fac.14.2025.12.17.09.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:54:12 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 6/7] builtin/repo: add disk size info to keyvalue stucture output
Date: Wed, 17 Dec 2025 11:54:03 -0600
Message-ID: <20251217175404.37963-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251217175404.37963-1-jltobler@gmail.com>
References: <20251216173842.3357832-1-jltobler@gmail.com>
 <20251217175404.37963-1-jltobler@gmail.com>
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
index 67d7548b88..7ea051f3af 100644
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

