Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C8186601
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417056; cv=none; b=VlM7jF1Uk+yyCxJz98u9hV2/Wz8UMGGQklFI6qkjDcFxiz/TgfwYfepbq338nk+TY8acnyI32AuCEiBsIOD0Wd4FtcU1UCpTuotQQ013ddl5qd4TLePJzOrJpgDTNCfjEYYnbH62RiFInlWyDgEJKh6j9qpSkuizoEiXgM39fls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417056; c=relaxed/simple;
	bh=ui4ilQR0SI9ItjcLqBtDUpRYAT/gFkKj+aD9xFqnA7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxDMSQqwXdq9j+Ao4iFLxG95vdBeZsPEOVswKhMnrR51naJOLJfkilyX6zk3ASw/cfPBa0/9lfQl+9XQ2pMcf4p94HTQ+8jB6YEaKEzGdUaMOLT9pumZZ2UPgX9oQhYa8zyjwOx+9SX5uB2n5DUKtpBM4Rnj8otgsnk38k4lxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AdMex7jS; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AdMex7jS"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5dca997d29eso1397871eaf.0
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724417053; x=1725021853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I90/UP/q6icXCkBilSfBdZt6nPg8mq0ZvwJtHoU+Nnw=;
        b=AdMex7jS/KDLaNcZxjQCP0KLZWZETYmauKsC/KsvJ1Xn/EQKQm+qxHpe9Sq1L0WVHW
         D4Ag+GI2EHnOvr4oL/w2xnLIJrCi22dSxlQcAL3bj3S75QAy6/EMNnkcjGqEvou20dkg
         se96lMFvx7A8tnPK1YxopJe4ub5ufEvVswROASb0/wyvFjuGezkID1cI/ghJ6+e64aJy
         OLqeQ5/J7Wh0E+c/X8KsUpjQ/gbtEgF2Nhj93IOsmnOkfn4BcMjB4B/DZJvbdzgg3xLi
         3VxayVi5T6h/S3pSEIfChw0DMJ2M9Vvwo0/dKbB0lo/Mf4TwDF02rjxyR3rLBGEuX0d7
         OqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417053; x=1725021853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I90/UP/q6icXCkBilSfBdZt6nPg8mq0ZvwJtHoU+Nnw=;
        b=ldCIRXJ/xRWQLn31HtRcCzc7CFWTecHZVyTBEqX2nIO8FU1gHB5Qggk1C+/4ig8hkT
         0ROdMgVT5y/3MYTWgxVdmPINq8KS9d+Vuse9Yuev+ECpSeLqakSFmbq9Dq9irnvKaSky
         K8V6ZfDzjijvBDTsmc4xJD9tSdKpZ7YjAdSxPkqpuB4KmlXTiU2TBEDkUbhpjcBT6Hfk
         PGyWAWPj29WOmEHfLEJOTqpMuqz8TfF1rvh+kv9GRY4/SyfhI8Tnr2JP90b3Jb9BXjzF
         1uSg4ErXVCfAlc05Q4ZilumoY/uCYBaQtG2Uey6XE2A9nyUb5odhsxWQOSUHQYc6XujP
         /QOA==
X-Gm-Message-State: AOJu0Yz1Qfse4TsMaLti+6QH8bJyK+NQRFTV/bhOuSOYdTj0duaNUe+v
	LM+ZfeEx+3YYVqVPArqab+knII6izJAKPZF4+53g79IuE+30Ui80T9wCphNunygCZyUkDXoC5K/
	K
X-Google-Smtp-Source: AGHT+IHzLtiWZ0QXKU//n0pQtxi9nQFhv6cfoQrpLYjhMHnErJCKGx0a5/KXkRP3+VnxPfsHpyHT7g==
X-Received: by 2002:a05:6808:d4e:b0:3d5:5e18:cf32 with SMTP id 5614622812f47-3de2a916b5cmr2132339b6e.48.1724417053439;
        Fri, 23 Aug 2024 05:44:13 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad56c5esm3068023a12.75.2024.08.23.05.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:44:12 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [WIP v2 4/4] repack: use new exclude promisor pack objects option
Date: Fri, 23 Aug 2024 20:43:54 +0800
Message-ID: <20240823124354.12982-5-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823124354.12982-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20240823124354.12982-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use --exclude-promisor-pack-objects to pack objects in partial clone repo.
git repack will call git pack-objects twice on a partially cloned repo.
The first call to pack-objects combines all the objects in promisor packfiles,
and the second pack-objects command packs all reachable non-promisor objects
into a normal packfile. However 'objects in promisor packfiles' plus
'non-promisor objects' does not equal 'all the reachable objects in repo',
Since promisor objects also include objects referenced in promisor packfile.

--exclude-promisor-pack-objects only excludes objects in promisor packfiles,
this way we don't discard any reachable objects in git repack.
---
 builtin/pack-objects.c | 8 ++++----
 builtin/repack.c       | 2 +-
 list-objects.c         | 3 ++-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c481feadbf..a2b1aaa2e0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -238,7 +238,7 @@ static enum {
 } write_bitmap_index;
 static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
 
-static int exclude_promisor_objects;
+static int exclude_promisor_pack_objects;
 
 static int use_delta_islands;
 
@@ -4391,7 +4391,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
 		  option_parse_missing_action),
-		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
+		OPT_BOOL(0, "exclude-promisor-pack-objects", &exclude_promisor_pack_objects,
 			 N_("do not pack objects in promisor packfiles")),
 		OPT_BOOL(0, "delta-islands", &use_delta_islands,
 			 N_("respect islands during delta compression")),
@@ -4473,10 +4473,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		strvec_push(&rp, "--unpacked");
 	}
 
-	if (exclude_promisor_objects) {
+	if (exclude_promisor_pack_objects) {
 		use_internal_rev_list = 1;
 		fetch_if_missing = 0;
-		strvec_push(&rp, "--exclude-promisor-objects");
+		strvec_push(&rp, "--exclude-promisor-pack-objects");
 	}
 	if (unpack_unreachable || keep_unreachable || pack_loose_unreachable)
 		use_internal_rev_list = 1;
diff --git a/builtin/repack.c b/builtin/repack.c
index 62cfa50c50..aafe7d30ce 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1289,7 +1289,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_push(&cmd.args, "--indexed-objects");
 	}
 	if (repo_has_promisor_remote(the_repository))
-		strvec_push(&cmd.args, "--exclude-promisor-objects");
+		strvec_push(&cmd.args, "--exclude-promisor-pack-objects");
 	if (!write_midx) {
 		if (write_bitmaps > 0)
 			strvec_push(&cmd.args, "--write-bitmap-index");
diff --git a/list-objects.c b/list-objects.c
index 985d008799..9b3ff0fe1d 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -178,7 +178,8 @@ static void process_tree(struct traversal_context *ctx,
 		 * requested.  This may cause the actual filter to report
 		 * an incomplete list of missing objects.
 		 */
-		if (revs->exclude_promisor_objects &&
+		if ((revs->exclude_promisor_objects ||
+		    revs->exclude_promisor_pack_objects) &&
 		    is_promisor_object(&obj->oid))
 			return;
 
-- 
2.45.2

