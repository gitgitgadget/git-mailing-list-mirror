Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394018CBE8
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935366; cv=none; b=pv6lRmnQ32TT24De/4GXv77PZTUKCujcqy/dPG0xghmesevcnI8Uovxv3vBypv1BP7/Vh/9owQUwMQ2K9yt7bL5MGOauc2qz3qhXufZWkDGGDYTHoIyzPYBaYtYKohGKQnGxFX8s1xkuvPFaeFdSWL/yokULak1XhBrewApy3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935366; c=relaxed/simple;
	bh=GOA4LnHup7QqZPhgYPo87lfCUoroLitANQIg2wETmtc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aI50QQKHTy+S+xDbG347lttdUpP6STKtIDvdUwDiIKUCfRPblwqFMLVTMN5pzwvX8u28Kv04/HFIrEK48ynogU0TpScaGKs8IJBtcDXibq/iFRt8ZpvgsiDOLFHGwu6oreupGXvjYDaISDugbnLdMgnh4pwOLm+ECRCInm13gYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOU/v3L+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOU/v3L+"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d24f98215so359047766b.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935362; x=1726540162; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTaFrdUqHOfwtQ56odYrPo0YawVJ7ZpXQQo9OLhwZZc=;
        b=WOU/v3L+WAdbTUOURLjnZDGjlsrQ6cKQ/2zdcTlI04aNeBCfokQtKg+1soO3RnLfeQ
         sRvLKDl9fPIlQzd+9b4QvLNo0RKDdCTNoO7BTUPV0nX+2WBHLRqtQ4sncQiuMqAzNM/u
         FG7WCdLMqA4+BmMh6aw7qtyHSPeN90rz4xIXV2FmKRhGncvUovULoi44wDeGHHk+ML3+
         CH/vzVDEJZLuaNojfZ9k7ujMjITJ4sViXvKOUkxzjLdmsZRCdgDRltHaJWeAOFKOfIr7
         YCBpEcZn8MrUcZw3VSvBVK8YN2SurbX7bJeg4vWrWs9SnzLFIvIBdrce70isx1x+BOlx
         0yMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935362; x=1726540162;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTaFrdUqHOfwtQ56odYrPo0YawVJ7ZpXQQo9OLhwZZc=;
        b=ODKxGNQfozJpQDMlzypzVkgU0jBGYQv5FQr5MVUMUgceqWVlf9relv7DBDk7XVIlyB
         gBBwXHb3tqfvH9BXgHKtxoBJgIja4Amf73BXwFf5uYgTTNIpaQ8FdUkJZis0cIYaN18c
         kmQocYfSkfKJoqZ0a8DvFyFxuqeyMF3vP87IFdYcuOLHOtnmnMKT/NTtHXxjZxOIf2Zu
         i9P2RlB70oODsRG4U1RVQqxYcFOPgsDFGPXYg4hqrzHrjDxKNTFtspE1pFlD+3s42SKZ
         v9OTNlUa+EMGDx+BF4KD17K7/uFURg9hvY/mAHOvlvN/DZZbujXxy1OFubb6vMNTA556
         vIxg==
X-Gm-Message-State: AOJu0Yx1hFNFCrAe/eWkt7W/m5D+6FqjG7EO7mmCDm1f9oD+pP81nvQd
	LIBEgNwKTWhtWs14qWthtrBTFnn/dmANRzY5EV1LpnD+gM0DcAh7ARx6Vg==
X-Google-Smtp-Source: AGHT+IGBZNA4vZCQIkKWrnd7GzsHiinVjr5Ul8oUoRN8Ue7hkbSWdYBMkSwznbpZWVSYYvIVeizs3w==
X-Received: by 2002:a17:907:e602:b0:a8a:906d:b485 with SMTP id a640c23a62f3a-a8d2457bf57mr612590066b.26.1725935362089;
        Mon, 09 Sep 2024 19:29:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d259528ecsm415863566b.67.2024.09.09.19.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:21 -0700 (PDT)
Message-Id: <db8cc46909bae552b0b23be9b07fdb2adfa68a10.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:52 +0000
Subject: [PATCH 27/30] pack-objects: add --full-name-hash option
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

RFC NOTE: this is essentially the same as the patch introduced
independently of the RFC, but now is on top of the --path-walk option
instead. This is included in the RFC for comparison purposes.

RFC NOTE: As you can see from the details below, the --full-name-hash
option essentially attempts to do similar things as the --path-walk
option, but sometimes misses the mark. Collisions still happen with the
--full-name-hash option, leading to some misses. However, in cases where
the default name-hash algorithm has low collision rates and deltas are
actually desired across objects with similar names but different full
names, the --path-walk option can still take advantage of the default
name hash approach.

Here are the new performance details simulating a single push in an
internal monorepo using a lot of paths that collide in the default name
hash. We can see that --full-name-hash gets close to the --path-walk
option's size.

Test                                           this tree
--------------------------------------------------------------
5313.2: thin pack                              2.43(2.92+0.14)
5313.3: thin pack size                                    4.5M
5313.4: thin pack with --full-name-hash        0.31(0.49+0.12)
5313.5: thin pack size with --full-name-hash             15.5K
5313.6: thin pack with --path-walk             0.35(0.31+0.04)
5313.7: thin pack size with --path-walk                  14.2K

However, when simulating pushes on repositories that do not have issues
with name-hash collisions, the --full-name-hash option presents a
potential of worse delta calculations, such as this example using my
local Git repository:

Test                                           this tree
--------------------------------------------------------------
5313.2: thin pack                              0.03(0.01+0.01)
5313.3: thin pack size                                     475
5313.4: thin pack with --full-name-hash        0.02(0.01+0.01)
5313.5: thin pack size with --full-name-hash             14.8K
5313.6: thin pack with --path-walk             0.02(0.01+0.01)
5313.7: thin pack size with --path-walk                    475

Note that the path-walk option found the same delta bases as the default
options in this case.

In the full repack case, the --full-name-hash option may be preferable
because it interacts well with other advanced features, such as using
bitmap indexes and tracking delta islands.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c       | 20 +++++++++++++++-----
 builtin/repack.c             |  5 +++++
 pack-objects.h               | 20 ++++++++++++++++++++
 t/perf/p5313-pack-objects.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e7a9d0349c3..5d5a57e6b1f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -270,6 +270,14 @@ struct configured_exclusion {
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
@@ -1674,7 +1682,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 		return 0;
 	}
 
-	create_object_entry(oid, type, pack_name_hash(name),
+	create_object_entry(oid, type, pack_name_hash_fn(name),
 			    exclude, name && no_try_delta(name),
 			    found_pack, found_offset);
 	return 1;
@@ -1888,7 +1896,7 @@ static void add_preferred_base_object(const char *name)
 {
 	struct pbase_tree *it;
 	size_t cmplen;
-	unsigned hash = pack_name_hash(name);
+	unsigned hash = pack_name_hash_fn(name);
 
 	if (!num_preferred_base || check_pbase_path(hash))
 		return;
@@ -3405,7 +3413,7 @@ static void show_object_pack_hint(struct object *object, const char *name,
 	 * here using a now in order to perhaps improve the delta selection
 	 * process.
 	 */
-	oe->hash = pack_name_hash(name);
+	oe->hash = pack_name_hash_fn(name);
 	oe->no_try_delta = name && no_try_delta(name);
 
 	stdin_packs_hints_nr++;
@@ -3555,7 +3563,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 	entry = packlist_find(&to_pack, oid);
 	if (entry) {
 		if (name) {
-			entry->hash = pack_name_hash(name);
+			entry->hash = pack_name_hash_fn(name);
 			entry->no_try_delta = no_try_delta(name);
 		}
 	} else {
@@ -3578,7 +3586,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 			return;
 		}
 
-		entry = create_object_entry(oid, type, pack_name_hash(name),
+		entry = create_object_entry(oid, type, pack_name_hash_fn(name),
 					    0, name && no_try_delta(name),
 					    pack, offset);
 	}
@@ -4526,6 +4534,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
 				N_("protocol"),
 				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
+		OPT_BOOL(0, "full-name-hash", &use_full_name_hash,
+			 N_("optimize delta compression across identical path names over time")),
 		OPT_END(),
 	};
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 9e39a1ea8f8..a1ab103e62d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -58,6 +58,7 @@ struct pack_objects_args {
 	int quiet;
 	int local;
 	int path_walk;
+	int full_name_hash;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -291,6 +292,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--no-reuse-object");
 	if (args->path_walk)
 		strvec_pushf(&cmd->args, "--path-walk");
+	if (args->full_name_hash)
+		strvec_pushf(&cmd->args, "--full-name-hash");
 	if (args->local)
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
@@ -1163,6 +1166,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("pass --no-reuse-object to git-pack-objects")),
 		OPT_BOOL(0, "path-walk", &po_args.path_walk,
 				N_("pass --path-walk to git-pack-objects")),
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
diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index 48fc05bb6c6..b3b7fff8abf 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -28,6 +28,14 @@ test_size 'thin pack size' '
 	wc -c <out
 '
 
+test_perf 'thin pack with --full-name-hash' '
+	git pack-objects --thin --stdout --revs --sparse --full-name-hash <in-thin >out
+'
+
+test_size 'thin pack size with --full-name-hash' '
+	wc -c <out
+'
+
 test_perf 'thin pack with --path-walk' '
 	git pack-objects --thin --stdout --revs --sparse --path-walk <in-thin >out
 '
@@ -44,6 +52,14 @@ test_size 'big recent pack size' '
 	wc -c <out
 '
 
+test_perf 'big recent pack with --full-name-hash' '
+	git pack-objects --stdout --revs --full-name-hash <in-big-recent >out
+'
+
+test_size 'big recent pack size with --full-name-hash' '
+	wc -c <out
+'
+
 test_perf 'big recent pack with --path-walk' '
 	git pack-objects --stdout --revs --path-walk <in-big-recent >out
 '
@@ -62,6 +78,16 @@ test_size 'full repack size' '
 		       sort -nr | head -n 1
 '
 
+test_perf 'full repack with --full-name-hash' '
+	git repack -adf --no-write-bitmap-index --full-name-hash
+'
+
+test_size 'full repack size with --full-name-hash' '
+	du -a .git/objects/pack | \
+	   awk "{ print \$1; }" | \
+		       sort -nr | head -n 1
+'
+
 test_perf 'full repack with --path-walk' '
 	git repack -adf --no-write-bitmap-index --path-walk
 '
-- 
gitgitgadget

