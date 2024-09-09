Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8681BA28B
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890218; cv=none; b=KfzlHv3Q3/v2Hbt+5Ph5aZqqYymtoAVqQG2znRbovetuN+7qGzQ57wONucza8JvKLNHVDThzWch3AlNzRxcoivbTfu6aINDExOWcqlO8OdZwfsxKsfl7uwkhl9Th6kIBC5/uIUx+3m0qY2GoCP/WHulP7QmINRaVr7ngZl1lxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890218; c=relaxed/simple;
	bh=vh54P5Ia/Nsyrru7EnrGAUaHBEPJwBqJzHqEhQ578H0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z0daCNSn4632GlRPOw9b2eSIpXE9IoTD0cvS7YCQaGhHX6la4v3NCS6EhWj2ilTjeIYdErYd+QFfvnLHXTXvpChOBVImbe3MB+5RPiXfIAzESNCeLHS/pCE0/hv2MkJw2L+fxFew6juxTXK2Z1kot9AAKZzyiG6ueCzVypjM9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBIYbXox; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBIYbXox"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bef295a45bso1866098a12.0
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725890214; x=1726495014; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzHJfPpaIVVYcb4L1JUnwhRDi9iIA9n/x9t5bLqjltA=;
        b=VBIYbXoxKlWDoyXeyDbcGLiga1IWQLDn2+FDzVJ+AFRR3fiPQ5Mmr/x+y0tIcLVjLH
         XCy8+m5wXgwlugBbBuPwQoQIz8k1ocl4S1qb8+rVy45AIYYy4dkKJ0BnMEhYUXRB/ph1
         BdsO1XY0Ede9cJWKoqKqPU9Y+cKhj3qvTkAqmV4DRhel+yLO/Q4QG900i3OYyiiVQNJr
         Y8rARFnD5yPCFQ157sG/LA4wr4lXaM1PPiGQxEzrjlqK98jaZmH0UO/Qcnk3AuhPUEPb
         jcI78R5p0rMk6SO7ZsbFAXpFA1JHhZhv8Hbp0YU76plbltTfZ0B2eFTsQtlSo2Fjtxzs
         4zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725890214; x=1726495014;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzHJfPpaIVVYcb4L1JUnwhRDi9iIA9n/x9t5bLqjltA=;
        b=v5fhHo31D0pmGp5ERrh5TTgOSVQoDGop0z9osAsgbllaC1whrKRld0LimKRimDL2A1
         pbXSkWVrDnFQbz8W2Q3bF3Pc0b0+ADRo11veJ7Tt4h67X1pwZ+3G4HyAbPJxxT252ME4
         Mgf8em5iiwB6GTpzeh67UXI0dN43tytoQbjcuqQZadlUuUCjp7MRlcakzUek5KzigXYK
         8Lc8Qq57oHEkLu9KxZgeo0D3gQI/y6TFk1ql9PdX2XhBIMhu0BJ3dA9QJQhVYLo4Wm1V
         zjvkyTjQ5K4k5opEBvhg0d6ZjnfHFgMzGxxbuOEkOLoyO5xWxwDsJEl1MilRralZaXfs
         m5qA==
X-Gm-Message-State: AOJu0Yzw2JoKBFuTMbY8R451zeK56oNqxGydq9Q4XUTa8cPJ8ygFhH1U
	wimzprLZZA3+jkteHK9hqkpxORM6fnLmpSwmQSKdhQ5naWQxb/vfF+Zl0Q==
X-Google-Smtp-Source: AGHT+IFevk/RdEmAGBOc6SWHNQ5d9TyTdy68gcJKxuRgiQEKWNPDQszOHFf50PoB/OYL0x15bSOIXg==
X-Received: by 2002:a05:6402:524f:b0:5c2:6090:4049 with SMTP id 4fb4d7f45d1cf-5c3dc7b7c28mr11032664a12.24.1725890213021;
        Mon, 09 Sep 2024 06:56:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebce3448sm3089722a12.0.2024.09.09.06.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:56:52 -0700 (PDT)
Message-Id: <ff30f774ca82662bb25291804559bf3f2de061c2.1725890211.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Sep 2024 13:56:47 +0000
Subject: [PATCH 1/4] pack-objects: add --full-name-hash option
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

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.txt |  3 ++-
 builtin/pack-objects.c             | 20 +++++++++++++++-----
 builtin/repack.c                   |  5 +++++
 pack-objects.h                     | 20 ++++++++++++++++++++
 4 files changed, 42 insertions(+), 6 deletions(-)

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
index 778be80f564..2a89666d89f 100644
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
@@ -1670,7 +1678,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 		return 0;
 	}
 
-	create_object_entry(oid, type, pack_name_hash(name),
+	create_object_entry(oid, type, pack_name_hash_fn(name),
 			    exclude, name && no_try_delta(name),
 			    found_pack, found_offset);
 	return 1;
@@ -1884,7 +1892,7 @@ static void add_preferred_base_object(const char *name)
 {
 	struct pbase_tree *it;
 	size_t cmplen;
-	unsigned hash = pack_name_hash(name);
+	unsigned hash = pack_name_hash_fn(name);
 
 	if (!num_preferred_base || check_pbase_path(hash))
 		return;
@@ -3394,7 +3402,7 @@ static void show_object_pack_hint(struct object *object, const char *name,
 	 * here using a now in order to perhaps improve the delta selection
 	 * process.
 	 */
-	oe->hash = pack_name_hash(name);
+	oe->hash = pack_name_hash_fn(name);
 	oe->no_try_delta = name && no_try_delta(name);
 
 	stdin_packs_hints_nr++;
@@ -3544,7 +3552,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 	entry = packlist_find(&to_pack, oid);
 	if (entry) {
 		if (name) {
-			entry->hash = pack_name_hash(name);
+			entry->hash = pack_name_hash_fn(name);
 			entry->no_try_delta = no_try_delta(name);
 		}
 	} else {
@@ -3567,7 +3575,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 			return;
 		}
 
-		entry = create_object_entry(oid, type, pack_name_hash(name),
+		entry = create_object_entry(oid, type, pack_name_hash_fn(name),
 					    0, name && no_try_delta(name),
 					    pack, offset);
 	}
@@ -4398,6 +4406,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
 				N_("protocol"),
 				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
+		OPT_BOOL(0, "full-name-hash", &use_full_name_hash,
+			 N_("optimize delta compression across identical path names over time")),
 		OPT_END(),
 	};
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 8bb875532b4..87d0cd4d2f2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -57,6 +57,7 @@ struct pack_objects_args {
 	int no_reuse_object;
 	int quiet;
 	int local;
+	int full_name_hash;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -288,6 +289,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
 		strvec_pushf(&cmd->args, "--no-reuse-object");
+	if (args->full_name_hash)
+		strvec_pushf(&cmd->args, "--full-name-hash");
 	if (args->local)
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
@@ -1176,6 +1179,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("pass --no-reuse-delta to git-pack-objects")),
 		OPT_BOOL('F', NULL, &po_args.no_reuse_object,
 				N_("pass --no-reuse-object to git-pack-objects")),
+		OPT_BOOL(0, "full-name-hash", &po_args.full_name_hash,
+				N_("pass --full-name-hash to git-pack-objects")),
 		OPT_NEGBIT('n', NULL, &run_update_server_info,
 				N_("do not run git-update-server-info"), 1),
 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
diff --git a/pack-objects.h b/pack-objects.h
index b9898a4e64b..50097552d03 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -207,6 +207,26 @@ static inline uint32_t pack_name_hash(const char *name)
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
+	 * Just do the dumbest thing possible: add random multiples of a
+	 * large prime number with a binary shift. Goal is not cryptographic,
+	 * but generally uniformly distributed.
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
-- 
gitgitgadget

