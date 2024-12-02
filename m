Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F161E008D
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733181696; cv=none; b=TCX6huVF3HvEXXbnA2fFBDq2ssGmWT6OC7wYInMtDKbNvmJhkcLbXxJloUKCm+cXgRflh542LB7Qn2lEyGVZ8Dkzyp83b253uJf4Ycdg1XAAK44is+/xK7MzS1z/ZMAP/VYMzn+wX4IhPAFiiWVSD+a2zoODc50yUgXZEuF/l2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733181696; c=relaxed/simple;
	bh=lbF7LhBsJ3Yhyk8y8b6ctTaysIym1GnOOeTfDg8AurY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k6yVoTywPuUTaMQksaEz9tFKXO8aIVITbmifI6i+ypoqxuYQItTWIeLHRdNWD0NbP7jOqOyw7uXVLc3c7OTuZfvsufh0fchRADdC6vYfjGq6I7/GGLUQdxQpWFJ5ov/ClyuLpz9Q1+KuVtKcKYtoJ9+8TWQ5REW4S8ejrVbjynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDoN8VSK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDoN8VSK"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa5325af6a0so673166866b.2
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 15:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733181692; x=1733786492; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJZwuhQwGprYs3w9qRTCbTMG4hfWZhCd5bzhHwooDGo=;
        b=EDoN8VSKsV8PjYAC8FnLrGbbHDjRL09XPv17P0yH+X3wGF0Y1rv/YEZCverpBXC+T9
         ak2uOuZIoPFMhvUVbtwdxngNUgAbmrM7YiXptO16ScCS/lE+z8TXTp3Kkji4lty04+rN
         x4pp9fyWhJjH0GkE0lFHRqWQKOgOy11Ucd4WEOjMKQww2jOv28WCLJOEcwhRBLlIajDN
         eYJd83hNguvXNZqSUdrmKvCsOvM/bfixqZvMZybl3MThqu0n0urIHgN4Jc9QMUaoGFJ0
         8NG4P1WVlQj1jdX6SepbSI4Nq4dSOl0eIpbst8whSKwLdadJKWy4Q2LQaFlQp1ZLPuGG
         CDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733181692; x=1733786492;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJZwuhQwGprYs3w9qRTCbTMG4hfWZhCd5bzhHwooDGo=;
        b=fpoIqrf31eIFdzHyXDIEGDCFeVpUOcUb1TSvV978M9uNVgntc6+gJrnzCeHZ2KLg8Z
         TQJd0S6sE46MsqAJlwFt8hVsSq8WMHcNnB/HWXTEqXbDvcst4jbBGGO2Nk0rgKgJA+d/
         RcvFu97JfIp8zmMNfZR+W4BR/DDig2FwJyuiDO4hPneN0V6YmksT+JZurt3RVXC6Ouj3
         x3IZ2igjYfVDZaRGHj3yXII0l8zmWUem2Qmy4sZHlICllpEEJ9tBjw1SSR0ToRNhA3Tn
         FjOm9yLWTuyOD5f6EeWDZvYcbYLtYjgGi77/OfOlGp3kpQJYFKykYiSr0XYEsSjwSmLh
         s3WQ==
X-Gm-Message-State: AOJu0YyfHlreE60BC33vKDsxfYJAB9FaQVp/lrVlvz+Miu56epRVdvcm
	62c86otfhVpDq0urs5vKmS8I17ow7KYDiKpqtcrEgNWXRgBA0onfnCBhGg==
X-Gm-Gg: ASbGncviOoUDMuNJPX966pAJ18C7VioaO1Ev5gCesYX81rKlU2VB923WlLcNKxJ9GIY
	oUt/OIlSeDHhVBG70uJdKPNgowbEjaomOEHkma5BFKNKnfDPa2UzH4eY3vueecnzA61OtsDa1rx
	tzQXO4BzzIXYimR2PgDuMQ6d9xzkbmIRK3Yq+/pd4p/7D7GZqlECf50dlw6QqMONr+rOqENpYjq
	jetL5nwcm39vMnvnqh8HEjES4cogFbfOVBum5zbo5l0FqrMUUY=
X-Google-Smtp-Source: AGHT+IGahgluz6z2aesyymggKXZw/S8SITVtikiZ+5fR5eUP0Kx6gU5StEqThkwH87XOF9+pQ77PsQ==
X-Received: by 2002:a17:907:7842:b0:aa5:14b3:a040 with SMTP id a640c23a62f3a-aa5f7cc2e89mr6825966b.5.1733181692243;
        Mon, 02 Dec 2024 15:21:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5eb5424cesm65157966b.144.2024.12.02.15.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 15:21:31 -0800 (PST)
Message-Id: <64fd7b3ccadabad7a2eb4515e99cae3ec3d9b2b1.1733181682.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
	<pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Dec 2024 23:21:22 +0000
Subject: [PATCH v2 8/8] pack-objects: add third name hash version
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    jonathantanmy@google.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The '--name-hash-version=<n>' option in 'git pack-objects' was
introduced to allow for specifying an alternative name hash function
when organizing objects for delta compression. The pack_name_hash_v2()
function was designed to break some collisions while also preserving
some amount of locality for cross-path deltas.

However, in some repositories, that effort to preserve locality results
in enough collisions that it causes issues with full repacks.

Create a third name hash function and extend the '--name-hash-version'
option in 'git pack-objects' and 'git repack' to understand it. This
hash version abandons all efforts for locality and focuses on creating a
somewhat uniformly-distributed hash function to minimize collisions.

We can observe the effect of this collision avoidance in a large
internal monorepo that suffered from collisions in the previous
versions. The updates to p5314-name-hash.sh show these results:

Test                               this tree
--------------------------------------------------
5314.1: paths at head                       227.3K
5314.2: distinct hash value: v1              72.3K
5314.3: maximum multiplicity: v1             14.4K
5314.4: distinct hash value: v2             166.5K
5314.5: maximum multiplicity: v2               138
5314.6: distinct hash value: v3             227.3K
5314.7: maximum multiplicity: v3                 2

These results demonstrate that of the 227,000+ paths, nearly all of them
find distinct hash values. The maximum multiplicity is 2, improved from
138 in the v2 hash function. The v2 hash function also had only 166K
distinct values, so it had a wide spread of collisions.

A more modest improvement is available in the open source fluentui repo
[1] with these results:

Test                               this tree
--------------------------------------------------
5314.1: paths at head                        19.5K
5314.2: distinct hash value: v1               8.2K
5314.3: maximum multiplicity: v1               279
5314.4: distinct hash value: v2              17.8K
5314.5: maximum multiplicity: v2                44
5314.6: distinct hash value: v3              19.5K
5314.7: maximum multiplicity: v3                 1

[1] https://github.com/microsoft/fluentui

However, it is important to demonstrate the effectiveness of this
function in the context of compressing a repository. We can use
p5313-pack-objects.sh to measure these changes. I will use a simplified
table summarizing the output of that performance test.

 | Test      | V1 Time | V2 Time | V3 Time | V1 Size | V2 Size | V3 Size |
 |-----------|---------|---------|---------|---------|---------|---------|
 | Thin Pack |  0.37 s |  0.12 s |  0.07 s |   1.2 M |  22.0 K |  20.4 K |
 | Big Pack  |  2.04 s |  2.80 s |  1.40 s |  20.4 M |  25.9 M |  19.2 M |
 | Shallow   |  1.41 s |  1.77 s |  1.27 s |  34.4 M |  33.7 M |  34.8 M |
 | Repack    | 95.70 s | 33.68 s | 20.88 s | 439.3 M | 160.5 M | 169.1 M |

Here, there are some performance improvements on a time basis, and the
thin and big packs are somewhat smaller in v3. The shallow and repacked
packs are somewhat bigger, though, compared to v2.

Two repositories that have very few collisions in the v1 name hash are
the Git and Linux repositories. Here are their stats for p5313:

Git:

 | Test      | V1 Time | V2 Time | V3 Time | V1 Size | V2 Size | V3 Size |
 |-----------|---------|---------|---------|---------|---------|---------|
 | Thin Pack |  0.02 s |  0.02 s |  0.02 s |   1.1 K |   1.1 K |  15.3 K |
 | Big Pack  |  1.69 s |  1.95 s |  1.67 s |  13.5 M |  14.5 M |  14.9 M |
 | Shallow   |  1.26 s |  1.29 s |  1.16 s |  12.0 M |  12.2 M |  12.5 M |
 | Repack    | 29.51 s | 29.01 s | 29.08 s | 237.7 M | 238.2 M | 237.7 M |

Linux:

 | Test      | V1 Time  | V2 Time  | V3 Time  | V1 Size | V2 Size | V3 Size |
 |-----------|----------|----------|----------|---------|---------|---------|
 | Thin Pack |   0.17 s |   0.07 s |   0.07 s |   4.6 K |   4.6 K |   6.8 K |
 | Big Pack  |  17.88 s |  12.35 s |  12.14 s | 201.1 M | 149.1 M | 160.4 M |
 | Shallow   |  11.05 s |  22.94 s |  22.16 s | 269.2 M | 273.8 M | 271.8 M |
 | Repack    | 727.39 s | 566.95 s | 539.33 s |   2.5 G |   2.5 G |   2.6 G |

These repositories make good use of the cross-path deltas that come
about from the v1 name hash function, so they already had mixed results
with the v2 function. The v3 function is generally worse for these
repositories.

An internal Javascript-based repository with name hash collisions
similar to the fluentui repo has these results:

 | Test      | V1 Time   | V2 Time  | V3 Time  | V1 Size | V2 Size | V3 Size |
 |-----------|-----------|----------|----------|---------|---------|---------|
 | Thin Pack |    8.28 s |   7.28 s |   0.04 s |  16.8 K |  16.8 K |   3.2 K |
 | Big Pack  |   12.81 s |  11.66 s |   2.52 s |  29.1 M |  29.1 M |  30.6 M |
 | Shallow   |    4.86 s |   4.06 s |   3.77 s |  42.5 M |  44.1 M |  45.7 M |
 | Repack    | 3126.50 s | 496.33 s | 306.86 s |   6.2 G | 855.6 M | 838.2 M |

This repository is also listed as "Repo B" in the repacking size table
below, along with other Javascript repos that have many name hash
collisions with the v1 name hash:

 | Repo     | V1 Size   | V2 Size | V3 Size |
 |----------|-----------|---------|---------|
 | fluentui |     440 M |   161 M |   170 M |
 | Repo B   |   6,248 M |   856 M |   840 M |
 | Repo C   |  37,278 M | 6,921 M | 6,755 M |
 | Repo D   | 131,204 M | 7,463 M | 7,124 M |

While the fluentui repo had an increase in size using the v3 name hash,
the others had modest improvements over the v2 name hash. But those
modest improvements are dwarfed by the difference from v1 to v2, so it
is unlikely that the regression seen in the other scenarios (packfiles
that are not from full repacks) will be worth using v3 over v2. That is,
unless there are enough collisions even with v2 that the full repack
scenario has larger improvements than these.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.txt |  9 +++++++++
 Documentation/git-repack.txt       |  9 +++++++++
 builtin/pack-objects.c             |  5 ++++-
 pack-objects.h                     | 26 ++++++++++++++++++++++++++
 t/helper/test-name-hash.c          |  1 +
 t/perf/p5313-pack-objects.sh       |  2 +-
 t/perf/p5314-name-hash.sh          |  2 +-
 t/t5300-pack-object.sh             |  4 ++--
 t/t5310-pack-bitmaps.sh            | 14 +++++++-------
 9 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 7f69ae4855f..9fe25c53415 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -374,6 +374,15 @@ breaking most of the collisions from a similarly-named file appearing in
 many different directories. At the moment, this version is not allowed
 when writing reachability bitmap files with `--write-bitmap-index` and it
 will be automatically changed to version `1`.
++
+The name hash version `3` abandons the locality features of versions `1`
+and `2` in favor of minimizing collisions. The goal here is to separate
+objects by their full path and abandon hope for cross-path delta
+compression. For this reason, this option is preferred for repacking large
+repositories with many versions and many name hash collisions when using
+the first two versions. At the moment, this version is not allowed when
+writing reachability bitmap files with `--write-bitmap-index` and it will
+be automatically changed to version `1`.
 
 
 DELTA ISLANDS
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ea69fbe1891..bc74d9333f0 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -279,6 +279,15 @@ breaking most of the collisions from a similarly-named file appearing in
 many different directories. At the moment, this version is not allowed
 when writing reachability bitmap files with `--write-bitmap-index` and it
 will be automatically changed to version `1`.
++
+The name hash version `3` abandons the locality features of versions `1`
+and `2` in favor of minimizing collisions. The goal here is to separate
+objects by their full path and abandon hope for cross-path delta
+compression. For this reason, this option is preferred for repacking large
+repositories with many versions and many name hash collisions when using
+the first two versions. At the moment, this version is not allowed when
+writing reachability bitmap files with `--write-bitmap-index` and it will
+be automatically changed to version `1`.
 
 
 CONFIGURATION
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7f1cb8de2fe..66efd43b036 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -270,7 +270,7 @@ static int name_hash_version = -1;
 
 static void validate_name_hash_version(void)
 {
-	if (name_hash_version < 1 || name_hash_version > 2)
+	if (name_hash_version < 1 || name_hash_version > 3)
 		die(_("invalid --name-hash-version option: %d"), name_hash_version);
 }
 
@@ -292,6 +292,9 @@ static inline uint32_t pack_name_hash_fn(const char *name)
 	case 2:
 		return pack_name_hash_v2(name);
 
+	case 3:
+		return pack_name_hash_v3(name);
+
 	default:
 		BUG("invalid name-hash version: %d", name_hash_version);
 	}
diff --git a/pack-objects.h b/pack-objects.h
index 15be8368d21..8c0840983e1 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -235,6 +235,32 @@ static inline uint32_t pack_name_hash_v2(const char *name)
 	return (base >> 6) ^ hash;
 }
 
+static inline uint32_t pack_name_hash_v3(const char *name)
+{
+	/*
+	 * This 'bigp' value is a large prime, at least 25% of the max
+	 * value of an uint32_t. Multiplying by this value (modulo 2^32)
+	 * causes the 32 bits to change pseudo-randomly.
+	 */
+	const uint32_t bigp = 1234572167U;
+	uint32_t c, hash = bigp;
+
+	if (!name)
+		return 0;
+
+	/*
+	 * Do the simplest thing that will resemble pseudo-randomness: add
+	 * random multiples of a large prime number with a binary shift.
+	 * The goal is not to be cryptographic, but to be generally
+	 * uniformly distributed.
+	 */
+	while ((c = *name++) != 0) {
+		hash += c * bigp;
+		hash = (hash >> 5) | (hash << 27);
+	}
+	return hash;
+}
+
 static inline enum object_type oe_type(const struct object_entry *e)
 {
 	return e->type_valid ? e->type_ : OBJ_BAD;
diff --git a/t/helper/test-name-hash.c b/t/helper/test-name-hash.c
index 5b402362020..1f71a41e2a8 100644
--- a/t/helper/test-name-hash.c
+++ b/t/helper/test-name-hash.c
@@ -15,6 +15,7 @@ int cmd__name_hash(int argc UNUSED, const char **argv UNUSED)
 	while (!strbuf_getline(&line, stdin)) {
 		printf("%10u ", pack_name_hash(line.buf));
 		printf("%10u ", pack_name_hash_v2(line.buf));
+		printf("%10u ", pack_name_hash_v3(line.buf));
 		printf("%s\n", line.buf);
 	}
 
diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index be5229a0ecd..493872e656d 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -25,7 +25,7 @@ test_expect_success 'create rev input' '
 	EOF
 '
 
-for version in 1 2
+for version in 1 2 3
 do
 	export version
 
diff --git a/t/perf/p5314-name-hash.sh b/t/perf/p5314-name-hash.sh
index 4ef0ba77114..e58a218d1ae 100755
--- a/t/perf/p5314-name-hash.sh
+++ b/t/perf/p5314-name-hash.sh
@@ -14,7 +14,7 @@ test_size 'paths at head' '
 	test-tool name-hash <path-list >name-hashes
 '
 
-for version in 1 2
+for version in 1 2 3
 do
 	test_size "distinct hash value: v$version" '
 		awk "{ print \$$version; }" <name-hashes | sort | \
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 97fe9e561c6..279a9deca9f 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -680,13 +680,13 @@ test_expect_success 'valid and invalid --name-hash-versions' '
 	# Valid values are hard to verify other than "do not fail".
 	# Performance tests will be more valuable to validate these versions.
 	# Negative values are converted to version 1.
-	for value in -1 1 2
+	for value in -1 1 2 3
 	do
 		git pack-objects base --all --name-hash-version=$value || return 1
 	done &&
 
 	# Invalid values have clear post-conditions.
-	for value in 0 3
+	for value in 0 4
 	do
 		test_must_fail git pack-objects base --all --name-hash-version=$value 2>err &&
 		test_grep "invalid --name-hash-version option" err || return 1
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 871ce01401a..2bf75e2a5d0 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -45,13 +45,13 @@ test_expect_success 'name-hash value stability' '
 	test-tool name-hash <names >out &&
 
 	cat >expect <<-\EOF &&
-	2582249472 1763573760 first
-	2289942528 1188134912 second
-	2300837888 1130758144 third
-	2544516325 3963087891 a/one-long-enough-for-collisions
-	2544516325 4013419539 b/two-long-enough-for-collisions
-	1420111091 1709547268 many/parts/to/this/path/enough/to/collide/in/v2
-	1420111091 1709547268 enough/parts/to/this/path/enough/to/collide/in/v2
+	2582249472 1763573760 3109209818 first
+	2289942528 1188134912 3781118409 second
+	2300837888 1130758144 3028707182 third
+	2544516325 3963087891 3586976147 a/one-long-enough-for-collisions
+	2544516325 4013419539 1701624798 b/two-long-enough-for-collisions
+	1420111091 1709547268 2676129939 many/parts/to/this/path/enough/to/collide/in/v2
+	1420111091 1709547268 2740459187 enough/parts/to/this/path/enough/to/collide/in/v2
 	EOF
 
 	test_cmp expect out
-- 
gitgitgadget
