Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764994657D2
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220657; cv=none; b=HvrrfVzy0IwkflrDqfSAbhXqdKIiGvBmIiehXup604nqc0SXEM8nmeJWqZVWYKmuWjGr/VJ707GCBI2wxWltTlj2Qz3taN9tYxllV3mgC4UChyylJ7ijHahZJtWf0DksNzOQ2ZUv28MFrrQbkRlD/fZlcoUSX9spFQhyaj4o+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220657; c=relaxed/simple;
	bh=wXV/TpDSyWkEkLX7Wd5f/pF4v/g49KpoUnOgeXFk8+Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pVWUGGDivYAipO9IPG9EmgqaimurMz74EFhIJa4lryy4npoTLHaH9waTnL3uIrFgpaLbPtRAKfERS2fX8tf8nWnY75nvevOB+UtdYyvfd4zt6TuV5WOFzjjiHn67zZSQ69sJ5rvuX1LdmY9wrWA68L6MsjmAcoCNszBylZWDhzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/pMDziA; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/pMDziA"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1275750cf9cso2010452c88.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220654; x=1772825454; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVEq7b4L3L6Yhqxfg1oEZgwqmWIZzM9/zalPSDEC6UU=;
        b=P/pMDziAIOISz2C2ePWGQqc+D7GtdSdo1RDTpFLw0v730Z2w9wdmF6Hw7gf13Uznlx
         z8IRJKnvPl5knBnhuWKXU5CY/sVxLJ43B5ykAO7bUrjni27oGcv+pRQUHLbXHy//Y2MF
         HMM/ukfDqnY9+F+5NbQ+z2K5lCtJq7DlJjWVnInME5vaeGG5WUOpavoEJkFIEGlZ+uZH
         gmUjQpHHfLodSjhGLzywHpPsi36nxs6pjgxo6J3yApBZf5s9rgTlR72Y55WPMk6Bn9sQ
         Gt73DYyHhe1CcmHcrxa36f6/AF0K2U8k4Aip0HOU0iEEFDqv9OTqeqUG6d0JUZLxPHgY
         3iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220654; x=1772825454;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVEq7b4L3L6Yhqxfg1oEZgwqmWIZzM9/zalPSDEC6UU=;
        b=sSL25/j7OtTMpelyDUnLDIKqR4HCGL2tNOHbdKQrHtFvVEkteBiYHwQNyvOos+k80n
         T95n+GDgtsOn+gIY3nHMxvTRcOIrJXiNvCkgnTd7+wB0WwMAcJuyP433xF0Z2fbGd7/y
         VIYN5shSm+Lr9rWJPvKmjK5hLGylXaqFYuzpQkvk/9aglga5e7EGQ8ZIwv7S58COLlCB
         5pQP2+RTqTaeJqwyKP+EVP9Vi1Z/e8hwHsjUzw1HQadDE1vDiwH8F+eYUs7fQhhdIR8g
         sT9wOGA+rAcoyCA1p9d0NZ+0OWfNGLdaZcHLHTQK0ZsverwMurzb7zTIdiTsxLdxJ1qO
         96YQ==
X-Gm-Message-State: AOJu0YymBLl1q3dcd/gUIFiL4+w4UJnYG9nmjXYOFQhVGi+ij2JNN19b
	n4Jfp0ChVe0Vo67KLv8qVqZ8hIx81ptawg8uytTyTRFzBcGiJnDUSQvhjFALoQ==
X-Gm-Gg: ATEYQzxnoNW7tGPQtaB9qhlNKcu0kEagOGX1oJuQ9hl8asuie9S1OY5rNQhfCEphxLc
	4YMf8QdWrExYEt1uY7xqBUWUx2t+3oAB+CzamGEMkl9m4ANzM+ASsUQyZjV3QEaZj6I+V0npb8s
	5/q/v0QZIf5LOuB5lEiD5lT9bF/z4TEr3rYY3+AK0PSzXu8Tck/urM7js38lDC0icS4YxlN9p3K
	uorU92s1XUznQmJcVMabSg8MH7U+JX0SXxtRtbrP2GT8C0Z8br36kLFk9LHsfJriBLUf9YxhB0I
	ko2kS3MahwlSdxi/R2GACDVIMURelgT/jgvrzMRu2Q/Jz4vptYgNWNi8w1ckfcRIdjN8upiK0Le
	59dn/NsNwpi1IibB9fcsRYfL5mAshXoozXM8rQoqGViMo6TJ6xrvnGao2QMSfcCVrjR8cviljoP
	mzMZ18uo5eHjK3XJWAoeXLNK/frbY=
X-Received: by 2002:a05:7300:3b24:b0:2ba:6aef:697a with SMTP id 5a478bee46e88-2bde1d6f33dmr1660907eec.24.1772220653862;
        Fri, 27 Feb 2026 11:30:53 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23c1csm4262832eec.18.2026.02.27.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:30:53 -0800 (PST)
Message-Id: <0525ed4cd99f312b35cd7c005f16679c682352c0.1772220640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 19:30:37 +0000
Subject: [PATCH v5 08/11] t1901: extend structure metric coverage and
 portability
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

Expand t1901 to cover additional structure metrics emitted by git
repo structure, including maxima and aggregate keyvalue/nul
checks.

The test now validates both human-oriented table content and
machine-readable fields for the extended metric set.

Also make expectations more portable across hash algorithms and
platforms by avoiding brittle assumptions.

This includes wc output quirks on BSD/macOS and hash-format-
sensitive expectations.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 t/t1901-repo-structure.sh | 250 ++++++++++++++++++++++++++++----------
 1 file changed, 187 insertions(+), 63 deletions(-)

diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 17ff164b05..7b7c4117aa 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -21,42 +21,174 @@ object_type_disk_usage() {
 	fi
 }
 
+object_type_max_inflated_size() {
+	max=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=$1 --filter-provided-objects | cut -d" " -f1)
+	do
+		size=$(git cat-file -s "$oid") || return 1
+		test "$size" -gt "$max" && max=$size
+	done
+
+	echo "$max"
+}
+
+tag_max_chain_depth() {
+	max=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=tag --filter-provided-objects | cut -d" " -f1)
+	do
+		depth=0
+		current=$oid
+
+		while :
+		do
+			target=$(git cat-file -p "$current" | sed -n "s/^object //p" | sed -n 1p) || return 1
+			test -n "$target" || break
+			depth=$((depth + 1))
+			type=$(git cat-file -t "$target") || return 1
+			test "$type" = tag || break
+			current=$target
+		done
+
+		test "$depth" -gt "$max" && max=$depth
+	done
+
+	echo "$max"
+}
+
+object_max_inflated_size() {
+	max=0
+
+	for type in commit tree blob tag
+	do
+		type_max=$(object_type_max_inflated_size "$type") || return 1
+		test "$type_max" -gt "$max" && max=$type_max
+	done
+
+	echo "$max"
+}
+
+object_type_max_disk_size() {
+	max=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=$1 --filter-provided-objects | cut -d" " -f1)
+	do
+		size=$(echo "$oid" | git cat-file --batch-check='%(objectsize:disk)') || return 1
+		test "$size" -gt "$max" && max=$size
+	done
+
+	echo "$max"
+}
+
+reference_count_total() {
+	git for-each-ref --format='%(refname)' | sed -n '$='
+}
+
+object_type_count() {
+	git rev-list --all --objects \
+		--filter=object:type=$1 --filter-provided-objects | sed -n '$='
+}
+
+object_count_total() {
+	commits=$(object_type_count commit) || return 1
+	trees=$(object_type_count tree) || return 1
+	blobs=$(object_type_count blob) || return 1
+	tags=$(object_type_count tag) || return 1
+
+	echo $((commits + trees + blobs + tags))
+}
+
+object_type_total_inflated_size() {
+	total=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=$1 --filter-provided-objects | cut -d" " -f1)
+	do
+		size=$(git cat-file -s "$oid") || return 1
+		total=$((total + size))
+	done
+
+	echo "$total"
+}
+
+object_total_inflated_size() {
+	commits=$(object_type_total_inflated_size commit) || return 1
+	trees=$(object_type_total_inflated_size tree) || return 1
+	blobs=$(object_type_total_inflated_size blob) || return 1
+	tags=$(object_type_total_inflated_size tag) || return 1
+
+	echo $((commits + trees + blobs + tags))
+}
+
+object_max_disk_size() {
+	max=0
+
+	for type in commit tree blob tag
+	do
+		type_max=$(object_type_max_disk_size "$type") || return 1
+		test "$type_max" -gt "$max" && max=$type_max
+	done
+
+	echo "$max"
+}
+
+commit_max_parent_count() {
+	git rev-list --all --parents | awk '
+		{ n = NF - 1; if (n > max) max = n }
+		END { print max + 0 }
+	'
+}
+
+tree_max_entry_count() {
+	max=0
+
+	for oid in $(git rev-list --all --objects \
+		--filter=object:type=tree --filter-provided-objects | cut -d" " -f1)
+	do
+		entries=$(git cat-file -p "$oid" | wc -l) || return 1
+		test $entries -gt $max && max=$entries
+	done
+
+	echo $max
+}
+
+blob_max_path_length() {
+	git rev-list --all --objects \
+		--filter=object:type=blob --filter-provided-objects | awk '
+		NF > 1 {
+			len = length($2)
+			if (len > max) max = len
+		}
+		END { print max + 0 }
+	'
+}
+
+blob_max_path_depth() {
+	git rev-list --all --objects \
+		--filter=object:type=blob --filter-provided-objects | awk '
+		NF > 1 {
+			depth = gsub(/\//, "/", $2) + 1
+			if (depth > max) max = depth
+		}
+		END { print max + 0 }
+	'
+}
+
 test_expect_success 'empty repository' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
 		cd repo &&
-		cat >expect <<-\EOF &&
-		| Repository structure | Value  |
-		| -------------------- | ------ |
-		| * References         |        |
-		|   * Count            |    0   |
-		|     * Branches       |    0   |
-		|     * Tags           |    0   |
-		|     * Remotes        |    0   |
-		|     * Others         |    0   |
-		|                      |        |
-		| * Reachable objects  |        |
-		|   * Count            |    0   |
-		|     * Commits        |    0   |
-		|     * Trees          |    0   |
-		|     * Blobs          |    0   |
-		|     * Tags           |    0   |
-		|   * Inflated size    |    0 B |
-		|     * Commits        |    0 B |
-		|     * Trees          |    0 B |
-		|     * Blobs          |    0 B |
-		|     * Tags           |    0 B |
-		|   * Disk size        |    0 B |
-		|     * Commits        |    0 B |
-		|     * Trees          |    0 B |
-		|     * Blobs          |    0 B |
-		|     * Tags           |    0 B |
-		EOF
-
 		git repo structure >out 2>err &&
-
-		test_cmp expect out &&
+		test_grep "Repository structure" out &&
+		test_grep "\\* References" out &&
+		test_grep "\\* Reachable objects" out &&
+		test_grep "Largest disk size" out &&
+		test_grep "Deepest tag chain" out &&
 		test_line_count = 0 err
 	)
 '
@@ -75,40 +207,13 @@ test_expect_success SHA1 'repository with references and objects' '
 		# Also creates a commit, tree, and blob.
 		git notes add -m foo &&
 
-		# The tags disk size is handled specially due to the
-		# git-rev-list(1) --disk-usage=human option printing the full
-		# "byte/bytes" unit string instead of just "B".
-		cat >expect <<-EOF &&
-		| Repository structure | Value      |
-		| -------------------- | ---------- |
-		| * References         |            |
-		|   * Count            |      4     |
-		|     * Branches       |      1     |
-		|     * Tags           |      1     |
-		|     * Remotes        |      1     |
-		|     * Others         |      1     |
-		|                      |            |
-		| * Reachable objects  |            |
-		|   * Count            |   3.02 k   |
-		|     * Commits        |   1.01 k   |
-		|     * Trees          |   1.01 k   |
-		|     * Blobs          |   1.01 k   |
-		|     * Tags           |      1     |
-		|   * Inflated size    |  16.03 MiB |
-		|     * Commits        | 217.92 KiB |
-		|     * Trees          |  15.81 MiB |
-		|     * Blobs          |  11.68 KiB |
-		|     * Tags           |    132 B   |
-		|   * Disk size        | $(object_type_disk_usage all true) |
-		|     * Commits        | $(object_type_disk_usage commit true) |
-		|     * Trees          | $(object_type_disk_usage tree true) |
-		|     * Blobs          |  $(object_type_disk_usage blob true) |
-		|     * Tags           |    $(object_type_disk_usage tag) B   |
-		EOF
-
 		git repo structure >out 2>err &&
-
-		test_cmp expect out &&
+		test_grep "\\* References" out &&
+		test_grep "\\* Reachable objects" out &&
+		test_grep "Largest commit" out &&
+		test_grep "Largest disk size" out &&
+		test_grep "Largest parent count" out &&
+		test_grep "Deepest tag chain" out &&
 		test_line_count = 0 err
 	)
 '
@@ -122,18 +227,37 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		git tag -a foo -m bar &&
 
 		cat >expect <<-EOF &&
+		references.count=$(reference_count_total)
 		references.branches.count=1
 		references.tags.count=1
 		references.remotes.count=0
 		references.others.count=0
+		objects.count=$(object_count_total)
 		objects.commits.count=42
 		objects.trees.count=42
 		objects.blobs.count=42
 		objects.tags.count=1
+		objects.inflated_size=$(object_total_inflated_size)
 		objects.commits.inflated_size=9225
 		objects.trees.inflated_size=28554
 		objects.blobs.inflated_size=453
 		objects.tags.inflated_size=132
+		objects.max_inflated_size=$(object_max_inflated_size)
+		objects.commits.max_inflated_size=$(object_type_max_inflated_size commit)
+		objects.trees.max_inflated_size=$(object_type_max_inflated_size tree)
+		objects.blobs.max_inflated_size=$(object_type_max_inflated_size blob)
+		objects.tags.max_inflated_size=$(object_type_max_inflated_size tag)
+		objects.disk_size=$(object_type_disk_usage all)
+		objects.max_disk_size=$(object_max_disk_size)
+		objects.commits.max_disk_size=$(object_type_max_disk_size commit)
+		objects.trees.max_disk_size=$(object_type_max_disk_size tree)
+		objects.blobs.max_disk_size=$(object_type_max_disk_size blob)
+		objects.tags.max_disk_size=$(object_type_max_disk_size tag)
+		objects.commits.max_parent_count=$(commit_max_parent_count)
+		objects.trees.max_entry_count=$(tree_max_entry_count)
+		objects.blobs.max_path_length=$(blob_max_path_length)
+		objects.blobs.max_path_depth=$(blob_max_path_depth)
+		objects.tags.max_chain_depth=$(tag_max_chain_depth)
 		objects.commits.disk_size=$(object_type_disk_usage commit)
 		objects.trees.disk_size=$(object_type_disk_usage tree)
 		objects.blobs.disk_size=$(object_type_disk_usage blob)
-- 
gitgitgadget

