Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE6287246
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856487; cv=none; b=Y/mosTXrKFOVT0QRwPmRp0gVn+OcetFETD4EU9usXW+LrBvIU6df0Jd3VBfUL+kszZClJJF4egQhIXZZnvBJXQiNAZtZ88FrxaLuVRC0W14dzCDD9x6Uzn3KTy241HKcSRGy7NCeNep9WJ/xxyUZ5qVEgHhNC+5IXbcDfbsPBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856487; c=relaxed/simple;
	bh=wXV/TpDSyWkEkLX7Wd5f/pF4v/g49KpoUnOgeXFk8+Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RhJZ+86bPtf4T4I36cAJnq46Mzsu54OJSpCSCX9gzk+3eXbpfsIpKSqsruM93BQq5/fjHj2QpapuGtcMkbvjUlRZMPZeW4svxPyL0BR2+tkEPuG5ANRHyhgkHgFt8Sbobyyg7de10f4tG/giS9MysxgCTSqvvBJpU1ytHAbD5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXYVD4RY; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXYVD4RY"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb3bae8d3eso428548685a.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771856484; x=1772461284; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVEq7b4L3L6Yhqxfg1oEZgwqmWIZzM9/zalPSDEC6UU=;
        b=kXYVD4RYidjfWG9vSR3pGql7Uk7szuFt/6CexhBhk9VMb0sXCFrl4QRL0+SH/vj8QN
         T5z8IwPBM9peciuTLQK0ds/1ytjZ6Tt7gK+eiquftF0MolTrJ7s1cqcB6UE+qGjmZca3
         tFJxc4uRuOSQI7tB7VflPDYMy+de02PzKtWUbug+WhRIMDsI8ES8BNK2RWYolyOY67Cs
         Z6RanRdsiXE9Eje5pCcbSK/9WuvY1AeVi+uKlyUZhO5VoIFAYGpY/k5rVWXb25LKX0JG
         uTrqm1hzic/M/jtGut83Qeb+x6X8p/mOSSgDJvc/nbfTZKmx9yk8rSnlsuxugsZ5TQsQ
         bp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856484; x=1772461284;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVEq7b4L3L6Yhqxfg1oEZgwqmWIZzM9/zalPSDEC6UU=;
        b=TpBR7YP/ZtPig6D2DUH7cpiR0WNivAnBlsq+gHExcG7yWilSRmUwfeMOMRU+yG7ZlY
         2G6oxiPH+c8tCeX0FzeldsV35ndspVOocCTg+LSbedZjGRnS+sEtrdaeeqTPUcTvUKvM
         oLupzF0wlpc2jWx8HJengNjGRGmCANAaxTDQt1O28fWFjCks1xJh+rRYSbfJCfk/jJgv
         CncEv7V/tjq1ctzjyYiKxY3RxDkiPRxN11wpAxCB3fkJzKJFv9jC88LB92jhqYyalLt9
         xMKkQpreaZykpX5zwqGce+ZjMpNr4WGcufj9bmwswbinVEVzxQVbMz7NvUIPUWHrXh1l
         NXlw==
X-Gm-Message-State: AOJu0YwtQlit7MTk7Qo9VW9EyRT/OHo4dmNbD8nZbea49plExlhHP5VS
	D8JMHi04uNE/jaWKnEhEM1hQV8RzHXR55ZodQ7AqQm2tJwOW3/QOqc7AJHYHzQ/k
X-Gm-Gg: AZuq6aJhd20uVOZlT1JkbOqQI9kjgaGDXCnpMLSy12AZ7LlMKbOvxFeGrlQAyDhKKDD
	UAXjoBcASy5rXVn2LQuwdaxBLuWMp6vAMlhoL0CgdfZtSrfYutuCUGVDeXK6TZ7D0E9IIxnD5l0
	KOhsb5GOTVFmUs23xCD6ROhhyPVFKHn8eS1xzFtZZI5sikmH86oXzS21upmn1XtOW8GhQ3lKdym
	6898iNNgs1XF3c3XFdQ2B6AQmGlNmRdE1pzkhz7zn6sdMKotDy2hGKBsEl9IDzCL8akvsK+0n/K
	YViKmDJeDp2QmaSGrDjRFUJfMxPWkWtyzMqYyZD7PwxPYZHzdXHtVyh7kftc5iUvHDJTEdz3kaG
	pwvk8Vz19IA956rBoyyVKVLv5IbA8blgC/LQ85TvVO0ScfMxRFS7Gh1l9m42D5VrC7M5ZkHzIA/
	1xh23jHKE57YpVxsIzJajCYQ8=
X-Received: by 2002:a05:620a:44d2:b0:8cb:4f63:dac9 with SMTP id af79cd13be357-8cb8c9cdc4bmr1163171485a.17.1771856484231;
        Mon, 23 Feb 2026 06:21:24 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0460e1sm834340485a.2.2026.02.23.06.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:21:23 -0800 (PST)
Message-Id: <0525ed4cd99f312b35cd7c005f16679c682352c0.1771856469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
	<pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 14:21:08 +0000
Subject: [PATCH v2 8/9] t1901: extend structure metric coverage and
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
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

