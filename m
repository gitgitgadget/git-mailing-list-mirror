Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EE953365
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775915; cv=none; b=SutYz3dAQC9hXvJliQ17+6XCm2c7f/RLCTWhSZ0NNjB11sTzSJzfJaZ1UOtZD9xwfL5CaWmaMhoeg4FAjp5lY1H4BzvxDPPj25TgmKWXJeyUc/R8zuwsXjhW5ZN0gRNnz70I+NmOg4NJps0bMjobfwUY1ht8SdGsnHAqMarX2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775915; c=relaxed/simple;
	bh=oZJtK4/Bt2qoVs7VRGKxAoXkn5HNOnhj+R51AbiGhb8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kkKMmf9blk0WGqngEMTmCJXZJny0fZuy+3EKjISOCSrskFd8G1ASqZSWZ0ZB32oa9fDF0Wsb4iqjwQLVYfakFG9bXyBXmBTTcOZ2EHKWspggb8bBERZ8zNDa7YD7rYnn2hMrMNod0O/TypVOeClL9ekAIiXI0X8TYf+FmK3hPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zedw80Up; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zedw80Up"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so38044985e9.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 19:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730775911; x=1731380711; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxKfgM7YMgrRt8jxV/3v61hBhNF4q0lgepI0Yc6tu+Y=;
        b=Zedw80Upe7PuywvXzgEnmuuOFiV12CJV7V4OAsBWR83HO6jz4HLbUuUehiijOlxzDf
         WuAHs+MZDkwKlD9FMl5sxaFX4rDthF4Lc/ocK6D1Cng8XYy5GnwL3V4QBL2UZmFgm1d9
         vtPaIj8Nq22XuFRyNPBn3gZ50i6Ro8rB8xDKRrAWHR7pb//hFXP1foOKCPlxkIAGBWSa
         QJ0eaKbgccy/S/TW31NBXKb2t2lP6eOaUpFhizOiFenMJ+b8YPN3VM+WFMVJqhwOfRaG
         yFENhd2pXYjD4V+nZNWg1azEnKwW86DUvILCnTTM8G+nb2EEt76FCW5uX0yujzf/nc0S
         A1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775911; x=1731380711;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxKfgM7YMgrRt8jxV/3v61hBhNF4q0lgepI0Yc6tu+Y=;
        b=GEBI7ZScSDYunmo/SQ4P/TNs5T2PaygtDTOVgkRipHo8U8d7Qqx/rECviwvcaK7FH1
         3qaBq7tNXpqcHp1S0EVV32JV4YAbjTc5D/gUP+6+EziF78NgUqZ/xT+OnW7iqRwdqriX
         3YpV91f1dgkRjWZpnqaDwhg/ij/1EdCO9vNZ8pdmmiE1OjxlRp6AZbJokcK5u5Q5Yi5F
         q8kpXnUa5OPzR0g3yh73KWWFSBP8sfuSMWKMMqIL5EFQCiUvGTCai1wBpvW9E8ahKZZ2
         P7ogmXuPiKPDMrOc+TqMNH84paUBOozjZXVSkFJGf8130A54ppOv8ySuWHYRSlR46l+6
         kM0g==
X-Gm-Message-State: AOJu0YwTqGNB2f7aJnyCJwFbQ2DHkFq5uthLTald7uLGCqAnxhLgCOty
	KTEgFr5pUIzBJJQEN/vOo5CTsXJ+QhUi9YaK9T7oqW2zaSsza9d+o+dqmQ==
X-Google-Smtp-Source: AGHT+IFmwR+6yhLwRAgSNsXXB3JRyXEZQy2Ax8Tui5sRqsN8zvwN7Y/Dqj2VSqLbsEAuoq7dhLfM9A==
X-Received: by 2002:a05:600c:458f:b0:431:5ed4:7e7d with SMTP id 5b1f17b1804b1-4327a82f755mr180771975e9.18.1730775910569;
        Mon, 04 Nov 2024 19:05:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b75sm14661657f8f.15.2024.11.04.19.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:05:10 -0800 (PST)
Message-Id: <812257e197cfe30bd0d3c68ea6ec0d062631185f.1730775907.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Nov 2024 03:05:01 +0000
Subject: [PATCH 1/7] pack-objects: add --full-name-hash option
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The pack_name_hash() method has not been materially changed since it was
introduced in ce0bd64299a (pack-objects: improve path grouping
heuristics., 2006-06-05). The intention here is to group objects by path
name, but also attempt to group similar file types together by making
the most-significant digits of the hash be focused on the final
characters.

Here's the crux of the implementation:

	/*
	 * This effectively just creates a sortable number from the
	 * last sixteen non-whitespace characters. Last characters
	 * count "most", so things that end in ".c" sort together.
	 */
	while ((c = *name++) != 0) {
		if (isspace(c))
			continue;
		hash = (hash >> 2) + (c << 24);
	}

As the comment mentions, this only cares about the last sixteen
non-whitespace characters. This cause some filenames to collide more
than others. Here are some examples that I've seen while investigating
repositories that are growing more than they should be:

 * "/CHANGELOG.json" is 15 characters, and is created by the beachball
   [1] tool. Only the final character of the parent directory can
   differntiate different versions of this file, but also only the two
   most-significant digits. If that character is a letter, then this is
   always a collision. Similar issues occur with the similar
   "/CHANGELOG.md" path, though there is more opportunity for
   differences in the parent directory.

 * Localization files frequently have common filenames but differentiate
   via parent directories. In C#, the name "/strings.resx.lcl" is used
   for these localization files and they will all collide in name-hash.

[1] https://github.com/microsoft/beachball

I've come across many other examples where some internal tool uses a
common name across multiple directories and is causing Git to repack
poorly due to name-hash collisions.

It is clear that the existing name-hash algorithm is optimized for
repositories with short path names, but also is optimized for packing a
single snapshot of a repository, not a repository with many versions of
the same file. In my testing, this has proven out where the name-hash
algorithm does a good job of finding peer files as delta bases when
unable to use a historical version of that exact file.

However, for repositories that have many versions of most files and
directories, it is more important that the objects that appear at the
same path are grouped together.

Create a new pack_full_name_hash() method and a new --full-name-hash
option for 'git pack-objects' to call that method instead. Add a simple
pass-through for 'git repack --full-name-hash' for additional testing in
the context of a full repack, where I expect this will be most
effective.

The hash algorithm is as simple as possible to be reasonably effective:
for each character of the path string, add a multiple of that character
and a large prime number (chosen arbitrarily, but intended to be large
relative to the size of a uint32_t). Then, shift the current hash value
to the right by 5, with overlap. The addition and shift parameters are
standard mechanisms for creating hard-to-predict behaviors in the bits
of the resulting hash.

This is not meant to be cryptographic at all, but uniformly distributed
across the possible hash values. This creates a hash that appears
pseudorandom. There is no ability to consider similar file types as
being close to each other.

In a later change, a test-tool will be added so the effectiveness of
this hash can be demonstrated directly.

For now, let's consider how effective this mechanism is when repacking a
repository with and without the --full-name-hash option. Specifically,
let's use 'git repack -adf [--full-name-hash]' as our test.

On the Git repository, we do not expect much difference. All path names
are short. This is backed by our results:

| Stage                 | Pack Size | Repack Time |
|-----------------------|-----------|-------------|
| After clone           | 260 MB    | N/A         |
| Standard Repack       | 127MB     | 106s        |
| With --full-name-hash | 126 MB    | 99s         |

This example demonstrates how there is some natural overhead coming from
the cloned copy because the server is hosting many forks and has not
optimized for exactly this set of reachable objects. But the full repack
has similar characteristics with and without --full-name-hash.

However, we can test this in a repository that uses one of the
problematic naming conventions above. The fluentui [2] repo uses
beachball to generate CHANGELOG.json and CHANGELOG.md files, and these
files have very poor delta characteristics when comparing against
versions across parent directories.

| Stage                 | Pack Size | Repack Time |
|-----------------------|-----------|-------------|
| After clone           | 694 MB    | N/A         |
| Standard Repack       | 438 MB    | 728s        |
| With --full-name-hash | 168 MB    | 142s        |

[2] https://github.com/microsoft/fluentui

In this example, we see significant gains in the compressed packfile
size as well as the time taken to compute the packfile.

Using a collection of repositories that use the beachball tool, I was
able to make similar comparisions with dramatic results. While the
fluentui repo is public, the others are private so cannot be shared for
reproduction. The results are so significant that I find it important to
share here:

| Repo     | Standard Repack | With --full-name-hash |
|----------|-----------------|-----------------------|
| fluentui |         438 MB  |               168 MB  |
| Repo B   |       6,255 MB  |               829 MB  |
| Repo C   |      37,737 MB  |             7,125 MB  |
| Repo D   |     130,049 MB  |             6,190 MB  |

Future changes could include making --full-name-hash implied by a config
value or even implied by default during a full repack.

It is important to point out that the name hash value is stored in the
.bitmap file format, so we must disable the --full-name-hash option when
bitmaps are being read or written. Later, the bitmap format could be
updated to be aware of the name hash version so deltas can be quickly
computed across the bitmapped/not-bitmapped boundary.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.txt |  3 ++-
 builtin/pack-objects.c             | 25 ++++++++++++++++++++-----
 builtin/repack.c                   |  5 +++++
 pack-objects.h                     | 21 +++++++++++++++++++++
 t/t5300-pack-object.sh             | 15 +++++++++++++++
 5 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index e32404c6aae..93861d9f85b 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
 	[--cruft] [--cruft-expiration=<time>]
 	[--stdout [--filter=<filter-spec>] | <base-name>]
-	[--shallow] [--keep-true-parents] [--[no-]sparse] < <object-list>
+	[--shallow] [--keep-true-parents] [--[no-]sparse]
+	[--full-name-hash] < <object-list>
 
 
 DESCRIPTION
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 08007142671..85595dfcd88 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -266,6 +266,14 @@ struct configured_exclusion {
 static struct oidmap configured_exclusions;
 
 static struct oidset excluded_by_config;
+static int use_full_name_hash;
+
+static inline uint32_t pack_name_hash_fn(const char *name)
+{
+	if (use_full_name_hash)
+		return pack_full_name_hash(name);
+	return pack_name_hash(name);
+}
 
 /*
  * stats
@@ -1698,7 +1706,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 		return 0;
 	}
 
-	create_object_entry(oid, type, pack_name_hash(name),
+	create_object_entry(oid, type, pack_name_hash_fn(name),
 			    exclude, name && no_try_delta(name),
 			    found_pack, found_offset);
 	return 1;
@@ -1912,7 +1920,7 @@ static void add_preferred_base_object(const char *name)
 {
 	struct pbase_tree *it;
 	size_t cmplen;
-	unsigned hash = pack_name_hash(name);
+	unsigned hash = pack_name_hash_fn(name);
 
 	if (!num_preferred_base || check_pbase_path(hash))
 		return;
@@ -3422,7 +3430,7 @@ static void show_object_pack_hint(struct object *object, const char *name,
 	 * here using a now in order to perhaps improve the delta selection
 	 * process.
 	 */
-	oe->hash = pack_name_hash(name);
+	oe->hash = pack_name_hash_fn(name);
 	oe->no_try_delta = name && no_try_delta(name);
 
 	stdin_packs_hints_nr++;
@@ -3572,7 +3580,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 	entry = packlist_find(&to_pack, oid);
 	if (entry) {
 		if (name) {
-			entry->hash = pack_name_hash(name);
+			entry->hash = pack_name_hash_fn(name);
 			entry->no_try_delta = no_try_delta(name);
 		}
 	} else {
@@ -3595,7 +3603,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 			return;
 		}
 
-		entry = create_object_entry(oid, type, pack_name_hash(name),
+		entry = create_object_entry(oid, type, pack_name_hash_fn(name),
 					    0, name && no_try_delta(name),
 					    pack, offset);
 	}
@@ -4429,6 +4437,8 @@ int cmd_pack_objects(int argc,
 		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
 				N_("protocol"),
 				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
+		OPT_BOOL(0, "full-name-hash", &use_full_name_hash,
+			 N_("optimize delta compression across identical path names over time")),
 		OPT_END(),
 	};
 
@@ -4576,6 +4586,11 @@ int cmd_pack_objects(int argc,
 	if (pack_to_stdout || !rev_list_all)
 		write_bitmap_index = 0;
 
+	if (write_bitmap_index && use_full_name_hash) {
+		warning(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
+		use_full_name_hash = 0;
+	}
+
 	if (use_delta_islands)
 		strvec_push(&rp, "--topo-order");
 
diff --git a/builtin/repack.c b/builtin/repack.c
index d6bb37e84ae..ab2a2e46b20 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -58,6 +58,7 @@ struct pack_objects_args {
 	int no_reuse_object;
 	int quiet;
 	int local;
+	int full_name_hash;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -306,6 +307,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
 		strvec_pushf(&cmd->args, "--no-reuse-object");
+	if (args->full_name_hash)
+		strvec_pushf(&cmd->args, "--full-name-hash");
 	if (args->local)
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
@@ -1203,6 +1206,8 @@ int cmd_repack(int argc,
 				N_("pass --no-reuse-delta to git-pack-objects")),
 		OPT_BOOL('F', NULL, &po_args.no_reuse_object,
 				N_("pass --no-reuse-object to git-pack-objects")),
+		OPT_BOOL(0, "full-name-hash", &po_args.full_name_hash,
+				N_("pass --full-name-hash to git-pack-objects")),
 		OPT_NEGBIT('n', NULL, &run_update_server_info,
 				N_("do not run git-update-server-info"), 1),
 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
diff --git a/pack-objects.h b/pack-objects.h
index b9898a4e64b..88360aa3e8e 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -207,6 +207,27 @@ static inline uint32_t pack_name_hash(const char *name)
 	return hash;
 }
 
+static inline uint32_t pack_full_name_hash(const char *name)
+{
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
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 3b9dae331a5..7585cac6595 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -674,4 +674,19 @@ do
 	'
 done
 
+# The following test is not necessarily a permanent choice, but since we do not
+# have a "name hash version" bit in the .bitmap file format, we cannot write the
+# full-name hash values into the .bitmap file without risking breakage later.
+#
+# TODO: Make these compatible in the future and replace this test with the
+# expected behavior when both are specified.
+test_expect_success '--full-name-hash and --write-bitmap-index are incompatible' '
+	git pack-objects base --all --full-name-hash --write-bitmap-index 2>err &&
+	test_grep incompatible err &&
+
+	# --stdout option silently removes --write-bitmap-index
+	git pack-objects --stdout --all --full-name-hash --write-bitmap-index >out 2>err &&
+	! test_grep incompatible err
+'
+
 test_done
-- 
gitgitgadget

